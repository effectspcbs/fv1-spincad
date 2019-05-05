/* SpinCAD Builder - DSP Development Tool for the Spin FV-1 
 * SpinCADGenerator.xtend
 * This file is triggered by code generation and calls the SpinCADBlock,
 * SpinCADControlPanel, and SpinCADTest generator files as needed.
 * 
 * Copyright (C) 2015 - Gary Worsham 
 * 
 *   This program is free software: you can redistribute it and/or modify 
 *   it under the terms of the GNU General Public License as published by 
 *   the Free Software Foundation, either version 3 of the License, or 
 *   (at your option) any later version. 
 * 
 *   This program is distributed in the hope that it will be useful, 
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of 
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the 
 *   GNU General Public License for more details. 
 * 
 *   You should have received a copy of the GNU General Public License 
 *   along with this program.  If not, see <http://www.gnu.org/licenses/>. 
 *     
 */ 

/*
 * generated by Xtext
 */
package com.holycityaudio.spincad.generator

//import com.google.inject.Inject 
import com.holycityaudio.spincad.spinCAD.Program
import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.generator.IFileSystemAccess
import org.eclipse.xtext.generator.IGenerator
//import org.eclipse.xtext.naming.IQualifiedNameProvider

class SpinCADGenerator implements IGenerator {
 
  // @Inject extension IQualifiedNameProvider
 
	override void doGenerate(Resource resource, IFileSystemAccess fsa) {
		var pkage = "/com/holycityaudio/SpinCAD/CADBlocks/"
		fsa.generateFile(pkage + resource.className+"CADBlock.java", toCADBlockCode(resource.contents.head as Program))
		pkage = "/com/holycityaudio/SpinCAD/ControlPanel/"
		fsa.generateFile(pkage + resource.className+"ControlPanel.java", toControlPanelCode(resource.contents.head as Program))
//		pkage = "/com/holycityaudio/SpinCAD/test/"
//		fsa.generateFile(pkage + resource.className+"Test.java", toTestCode(resource.contents.head as Program))
	}
	
	def className(Resource res) {
		var name = res.URI.lastSegment
		// println(name)
		return name.substring(0, name.indexOf('.'))
	}
	
	def toCADBlockCode(Program pr) {
		val blockName = pr.eResource.className
		var boop = new SpinCADBlockGenerator()
'''
		«boop.codeGenerate(blockName, pr)»
'''
	}

	def toControlPanelCode(Program pr) { 
		val blockName = pr.eResource.className
		var boop = new SpinCADControlPanelGenerator
	'''
	«boop.genControlPanelCode(blockName, pr)»
	'''
	}

	def toTestCode(Program pr) { 
		val blockName = pr.eResource.className
		var boop = new SpinCADTestGenerator
	'''
		«boop.genTestHeader(blockName)»
		«boop.testNoConnections(blockName)»
		«boop.testAllConnections(blockName, pr)»
		«boop.genTestCloser(blockName)»
	'''
	}			
}
