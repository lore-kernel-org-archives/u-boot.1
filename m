Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 155A1CCF9EE
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 00:34:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A34883642;
	Thu, 30 Oct 2025 01:34:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ak/Ffne+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55D3E83655; Thu, 30 Oct 2025 01:34:23 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE67983623
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 01:34:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-294fb21b0dcso937645ad.1
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 17:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761784457; x=1762389257; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Icqgf9Mt/UgbHMRXXYRt5Jp/grBv4MmZphQc9ikAlO0=;
 b=Ak/Ffne+HGJS3vVYWtvqssPTQtBJfmaMfMWtkKsJWzEN0dDVXdC//Ytni8Ax8KyPxJ
 5OIdCh3GKPeGFYv2j897JCxOYVXe/R8kVckcFiNsdW51XyUlCFEZ92uZDuxmW7+WREJW
 i6WV60w/B03as6scKw+S7xbxl7mMAd058s71rDmKnEywIHuLKKzLDyfrbJdyVCHu1sMk
 Mj+LWXQE6v/uTAf13oaN+oQRpQU7supSwTlBZypAO/YdzP1HoTsCumILBHDV+zOPScL2
 lOcolwa+ckK4H+E4f4O4O4C5S4L5axqBEjN2C7L5HxMwO1RK8gTHAT1EFqEiyK1MWehl
 1muw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761784457; x=1762389257;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Icqgf9Mt/UgbHMRXXYRt5Jp/grBv4MmZphQc9ikAlO0=;
 b=BOYOvfG+WNTs4p5N9P6bpph3jYADLOW0l76FtgscIGpd+ENfPM1gtL7iGfBbiHgkdc
 E41JGxK2WyRWE8ZUMM0oJcQGJ0ZxGyK6rApAqHl7pcDIEbBeo27fuXlGbJdfQkqG7GU2
 Ekq+zJ2O/Ds7+YWJVeX/CoRz0QHZyjZwbZdbXiMk026DiB23vEal6AoGqCQngC9DDOL5
 OEPeohOLnVRM54FKX9rAKKy+qX1MSl+F711YLgsA9JOGfPn0xTz7TpyvGcBgVGi8C237
 gjqYZURtlYM4kgPP82iij2bqvtr33Ibw8vVsl94P1qZEPyN4nLWhlVj8ZmOfDRmvLVnD
 5frA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXshGxBnO7wp87XVVwpLnRybs2xiILoRXEGXyvAEp/6FWeiMqsgIEUpAcR0hp6iVQSOgKOF900=@lists.denx.de
X-Gm-Message-State: AOJu0Yz7rZsDBhBy3I31hg1bLMYEEtNgcdyTCK44OMShB7LDocbsyjqc
 sx4shGtCYKGKMiYL32YzrWgP1AN9TYRF4H5kl66PlltTLJy3c21RN8b4gTtxult2
X-Gm-Gg: ASbGnctuhfczDoS2jUnwJiXgp0CGFf2H7QUY8nIC0pmi6Rhd1XYcM5Hdbn6Ru4lY/H0
 w1izPowE1vT0Jw9Iybqqak4pFt81HJdnSioc8AcZ3ZVZjHJaR/DJ3mKzisGQLV/CiJz5AJ7F54I
 mJXm6ITmK3cmmlgFHJ1IyRAhtqyUp8+ARJFJQgb8fIrE0oWGFL5K/stOE78ULZqAGwIHlKqjJJc
 UGM0gb5nHopPgiQTHNxOC1LRYWJ/54Php+wucBZADEcCKGuCZBFCVexf6bKhr5ZUkNH/HLzJPuO
 PsWQ5Qa7RRSM4SNp4RAb7JiJQv6TH5bLgukZY4BJBZbcM0Q7ucl76oz2qC/3j2YYg6lXgYuNxbM
 5etMOD8pISxUxPPQcF5lMsMBstoDPgZBoUMpeV7kR08QxHlwCwJHwqRoaWDILylwxPQ0rEes2yk
 rUsse5TcHUMyIgQXpyuu/TJrjREnfS7kt5Q8gg
X-Google-Smtp-Source: AGHT+IHiAJhGl/vJp5+IBgv1etzSiH2kZH6C0WZTgO8iYM0jzAlJv9SKGLGGoro9iOiwC/AHfNbFAw==
X-Received: by 2002:a17:902:ec8f:b0:28e:7fce:6685 with SMTP id
 d9443c01a7336-294deed4263mr58470385ad.32.1761784456402; 
 Wed, 29 Oct 2025 17:34:16 -0700 (PDT)
Received: from localhost.localdomain ([185.213.82.99])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29498cf358fsm163677525ad.20.2025.10.29.17.34.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 17:34:16 -0700 (PDT)
From: Brian Sune <briansune@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Subject: [PATCH v1] Cyclone V Board handsoff script
Date: Thu, 30 Oct 2025 08:33:59 +0800
Message-ID: <20251030003359.1023-1-briansune@gmail.com>
X-Mailer: git-send-email 2.47.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Since turning from old build flow.
New Altera SoCFPGA requires converting handsoff
conversion via the python script. This is from
official provided, and now sync to U-Boot

Signed-off-by: Brian Sune <briansune@gmail.com>
---
 .../cv_bsp_generator/cv_bsp_generator.py      | 100 +++
 arch/arm/mach-socfpga/cv_bsp_generator/doc.py | 243 ++++++++
 .../arm/mach-socfpga/cv_bsp_generator/emif.py | 424 +++++++++++++
 arch/arm/mach-socfpga/cv_bsp_generator/hps.py | 571 ++++++++++++++++++
 .../mach-socfpga/cv_bsp_generator/iocsr.py    | 203 +++++++
 .../mach-socfpga/cv_bsp_generator/model.py    | 114 ++++
 .../mach-socfpga/cv_bsp_generator/renderer.py | 196 ++++++
 .../mach-socfpga/cv_bsp_generator/streamer.py | 102 ++++
 .../mach-socfpga/cv_bsp_generator/xmlgrok.py  |  32 +
 9 files changed, 1985 insertions(+)
 create mode 100755 arch/arm/mach-socfpga/cv_bsp_generator/cv_bsp_generator=
.py
 create mode 100755 arch/arm/mach-socfpga/cv_bsp_generator/doc.py
 create mode 100755 arch/arm/mach-socfpga/cv_bsp_generator/emif.py
 create mode 100755 arch/arm/mach-socfpga/cv_bsp_generator/hps.py
 create mode 100755 arch/arm/mach-socfpga/cv_bsp_generator/iocsr.py
 create mode 100755 arch/arm/mach-socfpga/cv_bsp_generator/model.py
 create mode 100755 arch/arm/mach-socfpga/cv_bsp_generator/renderer.py
 create mode 100755 arch/arm/mach-socfpga/cv_bsp_generator/streamer.py
 create mode 100755 arch/arm/mach-socfpga/cv_bsp_generator/xmlgrok.py

diff --git a/arch/arm/mach-socfpga/cv_bsp_generator/cv_bsp_generator.py b/a=
rch/arm/mach-socfpga/cv_bsp_generator/cv_bsp_generator.py
new file mode 100755
index 00000000000..aff597d3978
--- /dev/null
+++ b/arch/arm/mach-socfpga/cv_bsp_generator/cv_bsp_generator.py
@@ -0,0 +1,100 @@
+#! /usr/bin/env python
+# SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+"""
+Bsp preloader header file generator
+
+Process the handoff files from Quartus and convert them to headers
+usable by U-Boot. Includes the qts filter.sh capability to generate
+correct format for headers to be used for mainline Uboot on FPGA,
+namely Cyclone V & Arria V.
+
+Copyright (C) 2022 Intel Corporation <www.intel.com>
+
+Author: Lee, Kah Jing <kah.jing.lee@intel.com>
+"""
+import glob
+import optparse
+import os
+import shutil
+import emif
+import hps
+import iocsr
+import renderer
+import model
+import collections
+import sys
+
+def printUsage():
+    """ usage string """
+    print ("Usage:\n\t%s\n" % ("sys.argv[0], --input_dir=3D<path to iswinf=
o directory> --output_dir=3D<path store output files>"))
+    exit(1)
+
+def verifyInputDir(dir):
+    """ check if the input directory exists """
+    if not os.path.isdir(dir):
+        print ("There is no such directory '%s'!\n" % (dir))
+        exit(1)
+
+def verifyOutputDir(dir):
+    """ check if the output directory exists """
+    if not os.path.isdir(dir):
+        os.makedirs(dir)
+
+if __name__ =3D=3D '__main__':
+    # Do some rudimentary command line processing until it is proven we ne=
ed something
+    # heavier, such as argparse (preferred, but 2.7+ only) or optparse
+
+    inputDir =3D '.'
+    outputDir =3D '.'
+
+    progVersion =3D '%prog 1.0'
+    progDesc =3D 'Generate board-specific files for the preloader'
+    optParser =3D optparse.OptionParser(version=3DprogVersion, description=
=3DprogDesc)
+    optParser.add_option('-i', '--input-dir', action=3D'store', type=3D'st=
ring', dest=3D'inputDir', default=3D'.',
+                         help=3D'input-dir is usually the iswinfo director=
y')
+    optParser.add_option('-o', '--output-dir', action=3D'store', type=3D's=
tring', dest=3D'outputDir', default=3D'.',
+                         help=3D'output-dir is usually the directory conta=
ining the preloader source')
+
+    (options, args) =3D optParser.parse_args()
+
+    for arg in args:
+        print ("***WARNING: I don't understand '%s', so I am ignoring it\n=
" % (arg))
+
+    inputDir =3D options.inputDir
+    verifyInputDir(inputDir)
+    outputDir =3D options.outputDir
+
+    verifyOutputDir(outputDir)
+
+    emif =3D emif.EMIFGrokker(inputDir, outputDir, 'emif.xml')
+    hps =3D hps.HPSGrokker(inputDir, outputDir)
+
+    pllConfigH =3D outputDir + "/" + "pll_config.h"
+    print ("Generating file: " + pllConfigH)
+    hpsModel =3D model.hps.create(inputDir + "/" + "hps.xml")
+    emifModel =3D model.emif.create(inputDir +"/" + "emif.xml")
+
+    content=3Dstr(renderer.pll_config_h(hpsModel, emifModel))
+    f =3D open(pllConfigH, "w")
+    f.write(content)
+    f.close()
+
+    # For all the .hiof files, make a iocsr_config.[h|c]
+    # Only support single hiof file currently
+    hiof_list =3D glob.glob(inputDir + os.sep + "*.hiof")
+    if len(hiof_list) < 1:
+        print ("***Error: No .hiof files found in input!")
+
+    elif len(hiof_list) > 1:
+        print ("***Error: We don't handle more than one .hiof file yet")
+        print ("          Only the last .hiof file in the list will be con=
verted")
+        print ("          hiof files found:")
+        for f in hiof_list:
+            print ("              " + f)
+
+    for hiof_file_path in hiof_list:
+        hiof_file =3D os.path.basename(hiof_file_path)
+        # Avoid IOCSRGrokker having to parse hps.xml to determine
+        # device family for output file name, instead we'll just
+        # get it from HPSGrokker
+        iocsr =3D iocsr.IOCSRGrokker(hps.getDeviceFamily(), inputDir, outp=
utDir, hiof_file)
diff --git a/arch/arm/mach-socfpga/cv_bsp_generator/doc.py b/arch/arm/mach-=
socfpga/cv_bsp_generator/doc.py
new file mode 100755
index 00000000000..86c5726c5f1
--- /dev/null
+++ b/arch/arm/mach-socfpga/cv_bsp_generator/doc.py
@@ -0,0 +1,243 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+"""
+Generic document construction classes.
+
+These classes are templates for creating documents that are not bound
+to a specific usage or data model.
+
+Copyright (C) 2022 Intel Corporation <www.intel.com>
+
+Author: Lee, Kah Jing <kah.jing.lee@intel.com>
+"""
+
+class document(object):
+    """
+    An abstract document class which does not dictate
+    how a document should be constructed or manipulated.
+
+    It's sole purpose is to describe the entire document
+    in smaller units
+    """
+
+    class entry(object):
+        """
+        An entry is the smallest unit
+        """
+
+        def __init__(self, parent):
+            """ entry initialization """
+            if parent !=3D None:
+                parent.add(self)
+
+    class block(entry):
+        """
+        A block is the smallest collection unit
+        consists of entries and blocks.
+        """
+
+        def __init__(self, parent):
+            """ block initialization """
+            super(document.block, self).__init__(parent)
+            self.entries =3D []
+
+        def add(self, entry):
+            """ add entry to block """
+            self.entries.append(entry)
+
+
+    def __init__(self):
+        """ document initialization """
+        self.entries =3D []
+
+    def add(self, entry):
+        """ add entry to entry list """
+        self.entries.append(entry)
+
+
+class text(document):
+    """
+    A simple text document implementation
+    """
+
+    class string(document.entry):
+        """
+        The smallest unit of a text file is a string
+        """
+
+        def __init__(self, parent, stringString=3DNone):
+            """ string initialization """
+            super(text.string, self).__init__(parent)
+            self.stringString =3D stringString
+
+        def __str__(self):
+            """ convert None to empty string """
+            if (self.stringString !=3D None):
+                return self.stringString
+            else:
+                return ""
+
+
+    class line(string):
+        """
+        A line is a string with EOL character
+        """
+
+        def __str__(self):
+            """ convert string with newline """
+            return super(text.line, self).__str__() + "\n"
+
+    class block(document.block):
+        """
+        A block of text which can be made up of
+        strings or lines
+        """
+
+        def __str__(self):
+            """ concatenate strings or lines """
+            blockString =3D ""
+
+            for entry in self.entries:
+                blockString +=3D str(entry)
+
+            return blockString
+
+
+    def __str__(self):
+        """ concatenate strings or lines """
+        textString =3D ""
+
+        for entry in self.entries:
+            textString +=3D str(entry)
+
+        return textString
+
+
+class c_source(text):
+    """
+    A simple C header document implementation
+    """
+
+    class define(text.string):
+        """
+        C header define
+        """
+
+        def __init__(self, parent, id, token=3DNone):
+            """ c header constructor initialization """
+            super(c_source.define, self).__init__(parent, id)
+            self.token =3D token
+
+        def __str__(self):
+            """ c header to strings """
+            defineString =3D "#define" + " " + super(c_source.define, self=
).__str__()
+
+            if self.token !=3D None:
+                defineString +=3D " " + self.token
+
+            defineString +=3D "\n"
+
+            return defineString
+
+    class comment_string(text.string):
+        """
+        C header comment
+        """
+
+        def __str__(self):
+            """ c comment """
+            return "/*" + " " + super(c_source.comment_string, self).__str=
__() + " " + "*/"
+
+    class comment_line(comment_string):
+        """
+        C header comment with newline
+        """
+
+        def __str__(self):
+            """ c comment with newline """
+            return super(c_source.comment_line, self).__str__() + "\n"
+
+    class block(text.block):
+        """
+        A simple C block string implementation
+        """
+
+        def __init__(self, parent, prologue=3DNone, epilogue=3DNone):
+            """ ifdef block string implementation """
+            super(c_source.block, self).__init__(parent)
+
+            self.prologue =3D None
+            self.epilogue =3D None
+
+            if prologue !=3D None:
+                self.prologue =3D prologue
+
+            if epilogue !=3D None:
+                self.epilogue =3D epilogue
+
+        def __str__(self):
+            """ convert ifdef to string """
+            blockString =3D ""
+
+            if self.prologue !=3D None:
+                blockString +=3D str(self.prologue)
+
+            blockString +=3D super(c_source.block, self).__str__()
+
+            if self.epilogue !=3D None:
+                blockString +=3D str(self.epilogue)
+
+            return blockString
+
+    class comment_block(block):
+        """
+        A simple C header block comment implementation
+        """
+
+        def __init__(self, parent, comments):
+            """ block comment initialization """
+            super(c_source.comment_block, self).__init__(parent, "/*\n", "=
 */\n")
+            for comment in comments.split("\n"):
+                self.add(comment)
+
+        def add(self, entry):
+            """ add line to block comment """
+            super(c_source.block, self).add(" * " + entry + "\n")
+
+    class ifndef_block(block):
+        """
+        A simple C header ifndef implementation
+        """
+
+        def __init__(self, parent, id):
+            """ ifndef block initialization """
+            prologue =3D text.line(None, "#ifndef" + " " + id)
+            epilogue =3D text.block(None)
+            text.string(epilogue, "#endif")
+            text.string(epilogue, " ")
+            c_source.comment_line(epilogue, id)
+            super(c_source.ifndef_block, self).__init__(parent, prologue, =
epilogue)
+
+
+class generated_c_source(c_source):
+    """
+    Caller to generate c format files using the helper classes
+    """
+
+    def __init__(self, filename):
+        """ Generate c header file with license, copyright, comment,
+        ifdef block
+        """
+        super(generated_c_source, self).__init__()
+
+        self.entries.append(c_source.comment_line(None, "SPDX-License-Iden=
tifier: BSD-3-Clause"))
+        self.entries.append(c_source.comment_block(None, "Copyright (C) 20=
22 Intel Corporation <www.intel.com>"))
+        self.entries.append(c_source.comment_block(None, "Altera SoCFPGA C=
lock and PLL configuration"))
+        self.entries.append(text.line(None))
+
+        self.body =3D c_source.ifndef_block(None, filename)
+        self.body.add(c_source.define(None, filename))
+        self.entries.append(self.body)
+
+    def add(self, entry):
+        """ add content to be written into c header file """
+        self.body.add(entry)
diff --git a/arch/arm/mach-socfpga/cv_bsp_generator/emif.py b/arch/arm/mach=
-socfpga/cv_bsp_generator/emif.py
new file mode 100755
index 00000000000..143bd2da550
--- /dev/null
+++ b/arch/arm/mach-socfpga/cv_bsp_generator/emif.py
@@ -0,0 +1,424 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+"""
+SDRAM header file generator
+
+Process the handoff files from Quartus and convert them to headers
+usable by U-Boot.
+
+Copyright (C) 2022 Intel Corporation <www.intel.com>
+
+Author: Lee, Kah Jing <kah.jing.lee@intel.com>
+"""
+
+import os
+import re
+import xml.dom.minidom
+import streamer
+import xmlgrok
+
+class EMIFGrokker(object):
+    """ parse an emif.xml input and translate to various
+    outputs
+    """
+    SCRIPT_DIR =3D os.path.dirname(os.path.realpath(__file__))
+    TEMPLATE_DIR =3D os.path.dirname(SCRIPT_DIR) + '/src'
+    SDRAM_FILE_HEADER =3D '/*\n' + ' * Altera SoCFPGA SDRAM configuration\=
n' + ' *\n' + ' */\n\n'
+    SDRAM_SENTINEL =3D '__SOCFPGA_SDRAM_CONFIG_H__'
+    SDRAM_MATCH =3D r'#define (CFG_HPS_SDR_CTRLCFG_CTRLCFG_MEMTYPE|CFG_HPS=
_SDR_CTRLCFG_CTRLCFG_MEMBL|CFG_HPS_SDR_CTRLCFG_CTRLCFG_ADDRORDER|CFG_HPS_SD=
R_CTRLCFG_CTRLCFG_ECCEN|CFG_HPS_SDR_CTRLCFG_CTRLCFG_ECCCORREN|CFG_HPS_SDR_C=
TRLCFG_CTRLCFG_REORDEREN|CFG_HPS_SDR_CTRLCFG_CTRLCFG_STARVELIMIT|CFG_HPS_SD=
R_CTRLCFG_CTRLCFG_DQSTRKEN|CFG_HPS_SDR_CTRLCFG_CTRLCFG_NODMPINS|CFG_HPS_SDR=
_CTRLCFG_DRAMTIMING1_TCWL|CFG_HPS_SDR_CTRLCFG_DRAMTIMING1_AL|CFG_HPS_SDR_CT=
RLCFG_DRAMTIMING1_TCL|CFG_HPS_SDR_CTRLCFG_DRAMTIMING1_TRRD|CFG_HPS_SDR_CTRL=
CFG_DRAMTIMING1_TFAW|CFG_HPS_SDR_CTRLCFG_DRAMTIMING1_TRFC|CFG_HPS_SDR_CTRLC=
FG_DRAMTIMING2_IF_TREFI|CFG_HPS_SDR_CTRLCFG_DRAMTIMING2_IF_TRCD|CFG_HPS_SDR=
_CTRLCFG_DRAMTIMING2_IF_TRP|CFG_HPS_SDR_CTRLCFG_DRAMTIMING2_IF_TWR|CFG_HPS_=
SDR_CTRLCFG_DRAMTIMING2_IF_TWTR|CFG_HPS_SDR_CTRLCFG_DRAMTIMING3_TRTP|CFG_HP=
S_SDR_CTRLCFG_DRAMTIMING3_TRAS|CFG_HPS_SDR_CTRLCFG_DRAMTIMING3_TRC|CFG_HPS_=
SDR_CTRLCFG_DRAMTIMING3_TMRD|CFG_HPS_SDR_CTRLCFG_DRAMTIMING3_TCCD|CFG_HPS_S=
DR_CTRLCFG_DRAMTIMING4_SELFRFSHEXIT|CFG_HPS_SDR_CTRLCFG_DRAMTIMING4_PWRDOWN=
EXIT|CFG_HPS_SDR_CTRLCFG_LOWPWRTIMING_AUTOPDCYCLES|CFG_HPS_SDR_CTRLCFG_LOWP=
WRTIMING_CLKDISABLECYCLES|CFG_HPS_SDR_CTRLCFG_DRAMODT_READ|CFG_HPS_SDR_CTRL=
CFG_DRAMODT_WRITE|CFG_HPS_SDR_CTRLCFG_DRAMADDRW_COLBITS|CFG_HPS_SDR_CTRLCFG=
_DRAMADDRW_ROWBITS|CFG_HPS_SDR_CTRLCFG_DRAMADDRW_BANKBITS|CFG_HPS_SDR_CTRLC=
FG_DRAMADDRW_CSBITS|CFG_HPS_SDR_CTRLCFG_DRAMIFWIDTH_IFWIDTH|CFG_HPS_SDR_CTR=
LCFG_DRAMDEVWIDTH_DEVWIDTH|CFG_HPS_SDR_CTRLCFG_DRAMINTR_INTREN|CFG_HPS_SDR_=
CTRLCFG_LOWPWREQ_SELFRFSHMASK|CFG_HPS_SDR_CTRLCFG_STATICCFG_MEMBL|CFG_HPS_S=
DR_CTRLCFG_STATICCFG_USEECCASDATA|CFG_HPS_SDR_CTRLCFG_CTRLWIDTH_CTRLWIDTH|C=
FG_HPS_SDR_CTRLCFG_CPORTWIDTH_CPORTWIDTH|CFG_HPS_SDR_CTRLCFG_CPORTWMAP_CPOR=
TWMAP|CFG_HPS_SDR_CTRLCFG_CPORTRMAP_CPORTRMAP|CFG_HPS_SDR_CTRLCFG_RFIFOCMAP=
_RFIFOCMAP|CFG_HPS_SDR_CTRLCFG_WFIFOCMAP_WFIFOCMAP|CFG_HPS_SDR_CTRLCFG_CPOR=
TRDWR_CPORTRDWR|CFG_HPS_SDR_CTRLCFG_PORTCFG_AUTOPCHEN|CFG_HPS_SDR_CTRLCFG_F=
PGAPORTRST|CFG_HPS_SDR_CTRLCFG_FIFOCFG_SYNCMODE|CFG_HPS_SDR_CTRLCFG_FIFOCFG=
_INCSYNC|CFG_HPS_SDR_CTRLCFG_MPPRIORITY_USERPRIORITY|CFG_HPS_SDR_CTRLCFG_MP=
WIEIGHT_0_STATICWEIGHT_31_0|CFG_HPS_SDR_CTRLCFG_MPWIEIGHT_1_STATICWEIGHT_49=
_32|CFG_HPS_SDR_CTRLCFG_MPWIEIGHT_1_SUMOFWEIGHT_13_0|CFG_HPS_SDR_CTRLCFG_MP=
WIEIGHT_2_SUMOFWEIGHT_45_14|CFG_HPS_SDR_CTRLCFG_MPWIEIGHT_3_SUMOFWEIGHT_63_=
46|CFG_HPS_SDR_CTRLCFG_PHYCTRL_PHYCTRL_0|CFG_HPS_SDR_CTRLCFG_MPPACING_0_THR=
ESHOLD1_31_0|CFG_HPS_SDR_CTRLCFG_MPPACING_1_THRESHOLD1_59_32|CFG_HPS_SDR_CT=
RLCFG_MPPACING_1_THRESHOLD2_3_0|CFG_HPS_SDR_CTRLCFG_MPPACING_2_THRESHOLD2_3=
5_4|CFG_HPS_SDR_CTRLCFG_MPPACING_3_THRESHOLD2_59_36|CFG_HPS_SDR_CTRLCFG_MPT=
HRESHOLDRST_0_THRESHOLDRSTCYCLES_31_0|CFG_HPS_SDR_CTRLCFG_MPTHRESHOLDRST_1_=
THRESHOLDRSTCYCLES_63_32|CFG_HPS_SDR_CTRLCFG_MPTHRESHOLDRST_2_THRESHOLDRSTC=
YCLES_79_64|RW_MGR_ACTIVATE_0_AND_1|RW_MGR_ACTIVATE_0_AND_1_WAIT1|RW_MGR_AC=
TIVATE_0_AND_1_WAIT2|RW_MGR_ACTIVATE_1|RW_MGR_CLEAR_DQS_ENABLE|RW_MGR_EMR_O=
CD_ENABLE|RW_MGR_EMR|RW_MGR_EMR2|RW_MGR_EMR3|RW_MGR_GUARANTEED_READ|RW_MGR_=
GUARANTEED_READ_CONT|RW_MGR_GUARANTEED_WRITE|RW_MGR_GUARANTEED_WRITE_WAIT0|=
RW_MGR_GUARANTEED_WRITE_WAIT1|RW_MGR_GUARANTEED_WRITE_WAIT2|RW_MGR_GUARANTE=
ED_WRITE_WAIT3|RW_MGR_IDLE|RW_MGR_IDLE_LOOP1|RW_MGR_IDLE_LOOP2|RW_MGR_INIT_=
RESET_0_CKE_0|RW_MGR_INIT_RESET_1_CKE_0|RW_MGR_INIT_CKE_0|RW_MGR_LFSR_WR_RD=
_BANK_0|RW_MGR_LFSR_WR_RD_BANK_0_DATA|RW_MGR_LFSR_WR_RD_BANK_0_DQS|RW_MGR_L=
FSR_WR_RD_BANK_0_NOP|RW_MGR_LFSR_WR_RD_BANK_0_WAIT|RW_MGR_LFSR_WR_RD_BANK_0=
_WL_1|RW_MGR_LFSR_WR_RD_DM_BANK_0|RW_MGR_LFSR_WR_RD_DM_BANK_0_DATA|RW_MGR_L=
FSR_WR_RD_DM_BANK_0_DQS|RW_MGR_LFSR_WR_RD_DM_BANK_0_NOP|RW_MGR_LFSR_WR_RD_D=
M_BANK_0_WAIT|RW_MGR_LFSR_WR_RD_DM_BANK_0_WL_1|RW_MGR_MR_CALIB|RW_MGR_MR_US=
ER|RW_MGR_MR_DLL_RESET|RW_MGR_MRS0_DLL_RESET|RW_MGR_MRS0_DLL_RESET_MIRR|RW_=
MGR_MRS0_USER|RW_MGR_MRS0_USER_MIRR|RW_MGR_MRS1|RW_MGR_MRS1_MIRR|RW_MGR_MRS=
2|RW_MGR_MRS2_MIRR|RW_MGR_MRS3|RW_MGR_MRS3_MIRR|RW_MGR_NOP|RW_MGR_PRECHARGE=
_ALL|RW_MGR_READ_B2B|RW_MGR_READ_B2B_WAIT1|RW_MGR_READ_B2B_WAIT2|RW_MGR_REF=
RESH|RW_MGR_REFRESH_ALL|RW_MGR_RETURN|RW_MGR_SGLE_READ|RW_MGR_ZQCL|RW_MGR_T=
RUE_MEM_DATA_MASK_WIDTH|RW_MGR_MEM_ADDRESS_MIRRORING|RW_MGR_MEM_DATA_MASK_W=
IDTH|RW_MGR_MEM_DATA_WIDTH|RW_MGR_MEM_DQ_PER_READ_DQS|RW_MGR_MEM_DQ_PER_WRI=
TE_DQS|RW_MGR_MEM_IF_READ_DQS_WIDTH|RW_MGR_MEM_IF_WRITE_DQS_WIDTH|RW_MGR_ME=
M_NUMBER_OF_CS_PER_DIMM|RW_MGR_MEM_NUMBER_OF_RANKS|RW_MGR_MEM_VIRTUAL_GROUP=
S_PER_READ_DQS|RW_MGR_MEM_VIRTUAL_GROUPS_PER_WRITE_DQS|IO_DELAY_PER_DCHAIN_=
TAP|IO_DELAY_PER_DQS_EN_DCHAIN_TAP|IO_DELAY_PER_OPA_TAP|IO_DLL_CHAIN_LENGTH=
|IO_DQDQS_OUT_PHASE_MAX|IO_DQS_EN_DELAY_MAX|IO_DQS_EN_DELAY_OFFSET|IO_DQS_E=
N_PHASE_MAX|IO_DQS_IN_DELAY_MAX|IO_DQS_IN_RESERVE|IO_DQS_OUT_RESERVE|IO_IO_=
IN_DELAY_MAX|IO_IO_OUT1_DELAY_MAX|IO_IO_OUT2_DELAY_MAX|IO_SHIFT_DQS_EN_WHEN=
_SHIFT_DQS|AFI_RATE_RATIO|AFI_CLK_FREQ|CALIB_LFIFO_OFFSET|CALIB_VFIFO_OFFSE=
T|ENABLE_SUPER_QUICK_CALIBRATION|MAX_LATENCY_COUNT_WIDTH|READ_VALID_FIFO_SI=
ZE|REG_FILE_INIT_SEQ_SIGNATURE|TINIT_CNTR0_VAL|TINIT_CNTR1_VAL|TINIT_CNTR2_=
VAL|TRESET_CNTR0_VAL|TRESET_CNTR1_VAL|TRESET_CNTR2_VAL|CFG_HPS_SDR_CTRLCFG_=
EXTRATIME1_CFG_EXTRA_CTL_CLK_RD_TO_WR|CFG_HPS_SDR_CTRLCFG_EXTRATIME1_CFG_EX=
TRA_CTL_CLK_RD_TO_WR_BC|CFG_HPS_SDR_CTRLCFG_EXTRATIME1_CFG_EXTRA_CTL_CLK_RD=
_TO_WR_DIFF_CHIP)\s+'
+
+    SDRAM_CONFIG_H_FILENAME =3D "sdram_config.h"
+
+    sdramHTemplate =3D ""
+    seqAutoTemplate =3D ""
+    seqDefinesTemplate =3D ""
+    seqAutoAcTemplate =3D ""
+    seqAutoInstTemplate =3D ""
+    seqAutoTemplateList =3D []
+    seqDefinesTemplateList =3D []
+    seqAutoAcTemplateList =3D []
+    seqAutoInstTemplateList =3D []
+
+    def __init__(self, inputDir, outputDir, emifFileName=3D'emif.xml', hps=
FileName=3D'hps.xml'):
+        """ EMIFGrokker initialization """
+        self.inputDir =3D inputDir
+        self.outputDir =3D outputDir
+
+        sdramDir =3D self.outputDir
+        if not os.path.isdir(sdramDir):
+            os.makedirs(sdramDir)
+
+        self.emifFileName =3D inputDir + os.sep + emifFileName
+        self.hpsFileName =3D inputDir + os.sep + hpsFileName
+        self.emifDom =3D xml.dom.minidom.parse(self.emifFileName)
+        self.hpsDom =3D xml.dom.minidom.parse(self.hpsFileName)
+        self.sequencerDefinesStream =3D None
+        self.seqAutoFileName =3D inputDir + os.sep +  "sequencer_auto.h"
+        self.seqDefinesFileName =3D inputDir + os.sep + "sequencer_defines=
.h"
+        self.seqAutoACFileName =3D inputDir + os.sep + "sequencer_auto_ac_=
init.c"
+        self.seqAutoInstFileName =3D inputDir + os.sep + "sequencer_auto_i=
nst_init.c"
+
+        self.createFilesFromEMIF()
+
+    def openSeqFiles(self):
+        """ files to retrieve values to written to sdram_config.h """
+        self.seq_auto_fd =3D open(self.seqAutoFileName, "r")
+        self.seq_defines_fd =3D open(self.seqDefinesFileName, "r")
+        self.seq_auto_ac_fd =3D open(self.seqAutoACFileName, "r")
+        self.seq_auto_inst_fd =3D open(self.seqAutoInstFileName, "r")
+
+    def closeSeqFiles(self):
+        """ close files """
+        self.seq_auto_fd.close()
+        self.seq_defines_fd.close()
+        self.seq_auto_ac_fd.close()
+        self.seq_auto_inst_fd.close()
+
+    def processSeqAuto(self):
+        """ process sequencer files to retrieve variable. Regex match is f=
rom
+        qts-filter.sh
+        """
+        # replace underscore & bracket in sequencer_auto.h define
+        for line in self.seq_auto_fd.readlines():
+            if re.match(".*__RW_MGR_", line) and not re.match(".*ac_", lin=
e) and not re.match(".*CONTENT_", line):
+                line =3D re.sub("__RW_MGR", "RW_MGR", line)
+                if re.match(self.SDRAM_MATCH, line):
+                    self.seqAutoTemplateList.append(re.sub(r' (\w+)(\s+)(\=
d+)', r' \1\t\3', line))
+        self.seqAutoTemplateList.sort()
+        self.seqAutoTemplate =3D ''.join([item for item in self.seqAutoTem=
plateList])
+
+        # replace underscore & bracket in sequencer_defines.h define
+        for line in self.seq_defines_fd.readlines():
+            if re.match("^#define (\w+_)", line):
+                line =3D re.sub("__", "", line)
+                if re.match(self.SDRAM_MATCH, line):
+                    self.seqDefinesTemplateList.append(re.sub(r' (\w+)(\s+=
)(\d+)', r' \1\t\3', line))
+        self.seqDefinesTemplateList.sort()
+        self.seqDefinesTemplate =3D ''.join([item for item in self.seqDefi=
nesTemplateList])
+
+        arrayMatchStart =3D 0
+        # replace const variable declaration in sequencer_auto_ac_init.c
+        for line in self.seq_auto_ac_fd.readlines():
+            if re.match("^const.*\[", line) or arrayMatchStart:
+                if arrayMatchStart =3D=3D 0:
+                    line =3D line.strip() + " "
+                arrayMatchStart =3D 1
+                if re.match("};", line):
+                    arrayMatchStart =3D 0
+                    self.seqAutoAcTemplateList.append("};")
+                    continue
+                line =3D re.sub("alt_u32", "u32", line)
+                self.seqAutoAcTemplateList.append(re.sub("\[.*\]", "[]", l=
ine))
+        self.seqAutoAcTemplate =3D ''.join([item for item in self.seqAutoA=
cTemplateList])
+
+        arrayMatchStart =3D 0
+        # replace const variable declaration in sequencer_auto_inst_init.c
+        for line in self.seq_auto_inst_fd.readlines():
+            if re.match("^const.*\[", line) or arrayMatchStart:
+                if arrayMatchStart =3D=3D 0:
+                    line =3D line.strip() + " "
+                arrayMatchStart =3D 1
+                if re.match("};", line):
+                    arrayMatchStart =3D 0
+                    self.seqAutoInstTemplateList.append("};")
+                    continue
+                line =3D re.sub("alt_u32", "u32", line)
+                self.seqAutoInstTemplateList.append(re.sub("\[.*\]", "[]",=
 line))
+        self.seqAutoInstTemplate =3D ''.join([item for item in self.seqAut=
oInstTemplateList])
+
+    def handleSettingNode(self, settingNode):
+        """ create define string from variable name and value """
+        if settingNode.hasAttribute('name') and settingNode.hasAttribute('=
value'):
+            name =3D settingNode.getAttribute('name')
+            value =3D settingNode.getAttribute('value')
+            self.sequencerDefinesStream.write("#define " + name + ' ' + '(=
' + value + ')' + '\n')
+
+    def updateTemplate(self, name, value):
+        """ update sdram template """
+        pattern =3D "${" + name + "}"
+        self.sdramHTemplate =3D self.sdramHTemplate.replace(pattern, value)
+
+    def handleEMIFControllerNode(self, node):
+        """ retrieve values from emif.xml for controller node """
+        derivedNoDmPins =3D 0
+        derivedCtrlWidth =3D 0
+        derivedEccEn =3D 0
+        derivedEccCorrEn =3D 0
+
+        self.mem_if_rd_to_wr_turnaround_oct =3D 0
+
+        node =3D xmlgrok.firstElementChild(node)
+        while node !=3D None:
+            name =3D node.getAttribute('name')
+            value =3D node.getAttribute('value')
+
+            if value =3D=3D "true":
+                value =3D "1"
+            elif value =3D=3D "false":
+                value =3D "0"
+
+            self.updateTemplate(name, value)
+
+            if name =3D=3D "MEM_IF_DM_PINS_EN":
+                if value =3D=3D "1":
+                    derivedNoDmPins =3D 0
+                else:
+                    derivedNoDmPins =3D 1
+
+            if name =3D=3D "MEM_DQ_WIDTH":
+                if value =3D=3D "8":
+                    derivedCtrlWidth =3D 0
+                    derivedEccEn =3D 0
+                    derivedEccCorrEn =3D 0
+                elif value =3D=3D "16":
+                    derivedCtrlWidth =3D 1
+                    derivedEccEn =3D 0
+                    derivedEccCorrEn =3D 0
+                elif value =3D=3D "24":
+                    derivedCtrlWidth =3D 1
+                    derivedEccEn =3D 1
+                    derivedEccCorrEn =3D 1
+                elif value =3D=3D "32":
+                    derivedCtrlWidth =3D 2
+                    derivedEccEn =3D 0
+                    derivedEccCorrEn =3D 0
+                elif value =3D=3D "40":
+                    derivedCtrlWidth =3D 2
+                    derivedEccEn =3D 1
+                    derivedEccCorrEn =3D 1
+
+            if name =3D=3D "MEM_IF_RD_TO_WR_TURNAROUND_OCT":
+                self.mem_if_rd_to_wr_turnaround_oct =3D int(value)
+
+            node =3D xmlgrok.nextElementSibling(node)
+
+        self.updateTemplate("DERIVED_NODMPINS", str(derivedNoDmPins))
+        self.updateTemplate("DERIVED_CTRLWIDTH", str(derivedCtrlWidth))
+        self.updateTemplate("DERIVED_ECCEN", str(derivedEccEn))
+        self.updateTemplate("DERIVED_ECCCORREN", str(derivedEccCorrEn))
+
+    def handleEMIFPllNode(self, node):
+        """ retrieve values for pll node """
+        node =3D xmlgrok.firstElementChild(node)
+        while node !=3D None:
+            name =3D node.getAttribute('name')
+            value =3D node.getAttribute('value')
+
+            self.updateTemplate(name, value)
+
+            node =3D xmlgrok.nextElementSibling(node)
+
+    def handleEMIFSequencerNode(self, node):
+        """ retrieve values for sequencer node """
+        derivedMemtype =3D 0
+        derivedSelfrfshexit =3D 0
+
+        self.afi_rate_ratio =3D 0
+
+        node =3D xmlgrok.firstElementChild(node)
+        while node !=3D None:
+            name =3D node.getAttribute('name')
+            value =3D node.getAttribute('value')
+
+            self.updateTemplate(name, value)
+
+            if value.isdigit():
+                intValue =3D int(value)
+            else:
+                intValue =3D 0
+
+            if name =3D=3D "DDR2" and intValue !=3D 0:
+                derivedMemtype =3D 1
+                derivedSelfrfshexit =3D 200
+            elif name =3D=3D "DDR3" and intValue !=3D 0:
+                derivedMemtype =3D 2
+                derivedSelfrfshexit =3D 512
+            elif name =3D=3D "LPDDR1" and intValue !=3D 0:
+                derivedMemtype =3D 3
+                derivedSelfrfshexit =3D 200
+            elif name =3D=3D "LPDDR2" and intValue !=3D 0:
+                derivedMemtype =3D 4
+                derivedSelfrfshexit =3D 200
+            elif name =3D=3D "AFI_RATE_RATIO" and intValue !=3D 0:
+                self.afi_rate_ratio =3D intValue
+
+            node =3D xmlgrok.nextElementSibling(node)
+
+        self.updateTemplate("DERIVED_MEMTYPE", str(derivedMemtype))
+        self.updateTemplate("DERIVED_SELFRFSHEXIT", str(derivedSelfrfshexi=
t))
+
+
+    def handleHpsFpgaInterfaces(self, node):
+        """ retrieve values for fpga interface """
+        node =3D xmlgrok.firstElementChild(node)
+
+        while node !=3D None:
+            name =3D node.getAttribute('name')
+            value =3D node.getAttribute('value')
+
+            self.updateTemplate(name, value)
+
+            node =3D xmlgrok.nextElementSibling(node)
+
+
+    def createFilesFromEMIF(self):
+        """ create sdram_config.h with the template and value read from xm=
l.
+        Different sequencer files are written to individual section, with
+        comment at the start.
+        """
+        self.sdramHTemplate =3D"""\
+#define CFG_HPS_SDR_CTRLCFG_CPORTRDWR_CPORTRDWR		0x5A56A
+#define CFG_HPS_SDR_CTRLCFG_CPORTRMAP_CPORTRMAP		0xB00088
+#define CFG_HPS_SDR_CTRLCFG_CPORTWIDTH_CPORTWIDTH		0x44555
+#define CFG_HPS_SDR_CTRLCFG_CPORTWMAP_CPORTWMAP		0x2C011000
+#define CFG_HPS_SDR_CTRLCFG_CTRLCFG_ADDRORDER		${ADDR_ORDER}
+#define CFG_HPS_SDR_CTRLCFG_CTRLCFG_DQSTRKEN			${USE_HPS_DQS_TRACKING}
+#define CFG_HPS_SDR_CTRLCFG_CTRLCFG_ECCCORREN		${DERIVED_ECCCORREN}
+#define CFG_HPS_SDR_CTRLCFG_CTRLCFG_ECCEN			${DERIVED_ECCEN}
+#define CFG_HPS_SDR_CTRLCFG_CTRLCFG_MEMBL			${MEM_BURST_LENGTH}
+#define CFG_HPS_SDR_CTRLCFG_CTRLCFG_MEMTYPE			${DERIVED_MEMTYPE}
+#define CFG_HPS_SDR_CTRLCFG_CTRLCFG_NODMPINS			${DERIVED_NODMPINS}
+#define CFG_HPS_SDR_CTRLCFG_CTRLCFG_REORDEREN		1
+#define CFG_HPS_SDR_CTRLCFG_CTRLCFG_STARVELIMIT		10
+#define CFG_HPS_SDR_CTRLCFG_CTRLWIDTH_CTRLWIDTH		${DERIVED_CTRLWIDTH}
+#define CFG_HPS_SDR_CTRLCFG_DRAMADDRW_BANKBITS		${MEM_IF_BANKADDR_WIDTH}
+#define CFG_HPS_SDR_CTRLCFG_DRAMADDRW_COLBITS		${MEM_IF_COL_ADDR_WIDTH}
+#define CFG_HPS_SDR_CTRLCFG_DRAMADDRW_CSBITS			${DEVICE_DEPTH}
+#define CFG_HPS_SDR_CTRLCFG_DRAMADDRW_ROWBITS		${MEM_IF_ROW_ADDR_WIDTH}
+#define CFG_HPS_SDR_CTRLCFG_DRAMDEVWIDTH_DEVWIDTH		8
+#define CFG_HPS_SDR_CTRLCFG_DRAMIFWIDTH_IFWIDTH		${MEM_DQ_WIDTH}
+#define CFG_HPS_SDR_CTRLCFG_DRAMINTR_INTREN			0
+#define CFG_HPS_SDR_CTRLCFG_DRAMODT_READ			${CFG_READ_ODT_CHIP}
+#define CFG_HPS_SDR_CTRLCFG_DRAMODT_WRITE			${CFG_WRITE_ODT_CHIP}
+#define CFG_HPS_SDR_CTRLCFG_DRAMTIMING1_AL			0
+#define CFG_HPS_SDR_CTRLCFG_DRAMTIMING1_TCL			${MEM_TCL}
+#define CFG_HPS_SDR_CTRLCFG_DRAMTIMING1_TCWL			${MEM_WTCL_INT}
+#define CFG_HPS_SDR_CTRLCFG_DRAMTIMING1_TFAW			${MEM_TFAW}
+#define CFG_HPS_SDR_CTRLCFG_DRAMTIMING1_TRFC			${MEM_TRFC}
+#define CFG_HPS_SDR_CTRLCFG_DRAMTIMING1_TRRD			${MEM_TRRD}
+#define CFG_HPS_SDR_CTRLCFG_DRAMTIMING2_IF_TRCD		${MEM_TRCD}
+#define CFG_HPS_SDR_CTRLCFG_DRAMTIMING2_IF_TREFI		${MEM_TREFI}
+#define CFG_HPS_SDR_CTRLCFG_DRAMTIMING2_IF_TRP		${MEM_TRP}
+#define CFG_HPS_SDR_CTRLCFG_DRAMTIMING2_IF_TWR		${MEM_TWR}
+#define CFG_HPS_SDR_CTRLCFG_DRAMTIMING2_IF_TWTR		${MEM_TWTR}
+#define CFG_HPS_SDR_CTRLCFG_DRAMTIMING3_TCCD			4
+#define CFG_HPS_SDR_CTRLCFG_DRAMTIMING3_TMRD			${MEM_TMRD_CK}
+#define CFG_HPS_SDR_CTRLCFG_DRAMTIMING3_TRAS			${MEM_TRAS}
+#define CFG_HPS_SDR_CTRLCFG_DRAMTIMING3_TRC			${MEM_TRC}
+#define CFG_HPS_SDR_CTRLCFG_DRAMTIMING3_TRTP			${MEM_TRTP}
+#define CFG_HPS_SDR_CTRLCFG_DRAMTIMING4_PWRDOWNEXIT		3
+#define CFG_HPS_SDR_CTRLCFG_DRAMTIMING4_SELFRFSHEXIT		${DERIVED_SELFRFSHEX=
IT}
+#define CFG_HPS_SDR_CTRLCFG_EXTRATIME1_CFG_EXTRA_CTL_CLK_RD_TO_WR ${DERIVE=
D_CLK_RD_TO_WR}
+#define CFG_HPS_SDR_CTRLCFG_EXTRATIME1_CFG_EXTRA_CTL_CLK_RD_TO_WR_BC ${DER=
IVED_CLK_RD_TO_WR}
+#define CFG_HPS_SDR_CTRLCFG_EXTRATIME1_CFG_EXTRA_CTL_CLK_RD_TO_WR_DIFF_CHI=
P ${DERIVED_CLK_RD_TO_WR}
+#define CFG_HPS_SDR_CTRLCFG_FIFOCFG_INCSYNC			0
+#define CFG_HPS_SDR_CTRLCFG_FIFOCFG_SYNCMODE			0
+#define CFG_HPS_SDR_CTRLCFG_FPGAPORTRST			${F2SDRAM_RESET_PORT_USED}
+#define CFG_HPS_SDR_CTRLCFG_LOWPWREQ_SELFRFSHMASK		3
+#define CFG_HPS_SDR_CTRLCFG_LOWPWRTIMING_AUTOPDCYCLES	0
+#define CFG_HPS_SDR_CTRLCFG_LOWPWRTIMING_CLKDISABLECYCLES	8
+#define CFG_HPS_SDR_CTRLCFG_MPPACING_0_THRESHOLD1_31_0	0x20820820
+#define CFG_HPS_SDR_CTRLCFG_MPPACING_1_THRESHOLD1_59_32	0x8208208
+#define CFG_HPS_SDR_CTRLCFG_MPPACING_1_THRESHOLD2_3_0	0
+#define CFG_HPS_SDR_CTRLCFG_MPPACING_2_THRESHOLD2_35_4	0x41041041
+#define CFG_HPS_SDR_CTRLCFG_MPPACING_3_THRESHOLD2_59_36	0x410410
+#define CFG_HPS_SDR_CTRLCFG_MPPRIORITY_USERPRIORITY		0x0
+#define CFG_HPS_SDR_CTRLCFG_MPTHRESHOLDRST_0_THRESHOLDRSTCYCLES_31_0 0x010=
10101
+#define CFG_HPS_SDR_CTRLCFG_MPTHRESHOLDRST_1_THRESHOLDRSTCYCLES_63_32 0x01=
010101
+#define CFG_HPS_SDR_CTRLCFG_MPTHRESHOLDRST_2_THRESHOLDRSTCYCLES_79_64 0x01=
01
+#define CFG_HPS_SDR_CTRLCFG_MPWIEIGHT_0_STATICWEIGHT_31_0	0x21084210
+#define CFG_HPS_SDR_CTRLCFG_MPWIEIGHT_1_STATICWEIGHT_49_32	0x10441
+#define CFG_HPS_SDR_CTRLCFG_MPWIEIGHT_1_SUMOFWEIGHT_13_0	0x78
+#define CFG_HPS_SDR_CTRLCFG_MPWIEIGHT_2_SUMOFWEIGHT_45_14	0x0
+#define CFG_HPS_SDR_CTRLCFG_MPWIEIGHT_3_SUMOFWEIGHT_63_46	0x0
+#define CFG_HPS_SDR_CTRLCFG_PHYCTRL_PHYCTRL_0		0x200
+#define CFG_HPS_SDR_CTRLCFG_PORTCFG_AUTOPCHEN		0
+#define CFG_HPS_SDR_CTRLCFG_RFIFOCMAP_RFIFOCMAP		0x760210
+#define CFG_HPS_SDR_CTRLCFG_STATICCFG_MEMBL			2
+#define CFG_HPS_SDR_CTRLCFG_STATICCFG_USEECCASDATA		0
+#define CFG_HPS_SDR_CTRLCFG_WFIFOCMAP_WFIFOCMAP		0x980543
+"""
+
+        # Get a list of all nodes with the emif element name
+        emifNodeList =3D self.emifDom.getElementsByTagName('emif')
+        if len(emifNodeList) > 1:
+            print ("*** WARNING:" + "Multiple emif Elements found in %s!" =
% self.emifFileName)
+        # For each of the emif element nodes, go through the child list
+        # Note that currently there is only one emif Element
+        # but this code will handle more than one emif node
+        # In the future, multiple emif nodes may need additional code
+        # to combine settings from the multiple emif Elements
+        for emifNode in emifNodeList:
+            # Currently, there are only 3 children of the emif Element:
+            #     sequencer, controller, and pll
+            # but this is left open-ended for future additions to the
+            # specification for the emif.xml
+            childNode =3D xmlgrok.firstElementChild(emifNode)
+            while childNode !=3D None:
+
+                if childNode.nodeName =3D=3D 'controller':
+                    self.handleEMIFControllerNode(childNode)
+                elif childNode.nodeName =3D=3D 'sequencer':
+                    self.handleEMIFSequencerNode(childNode)
+                elif childNode.nodeName =3D=3D 'pll':
+                    self.handleEMIFPllNode(childNode)
+
+                childNode =3D xmlgrok.nextElementSibling(childNode)
+
+        data_rate_ratio =3D 2
+        dwidth_ratio =3D self.afi_rate_ratio * data_rate_ratio
+        if dwidth_ratio =3D=3D 0:
+            derivedClkRdToWr =3D 0
+        else:
+            derivedClkRdToWr =3D (self.mem_if_rd_to_wr_turnaround_oct / (d=
width_ratio / 2))
+
+            if (self.mem_if_rd_to_wr_turnaround_oct % (dwidth_ratio / 2)) =
> 0:
+                derivedClkRdToWr +=3D 1
+
+        self.updateTemplate("DERIVED_CLK_RD_TO_WR", str(int(derivedClkRdTo=
Wr)))
+
+        # MPFE information are stored in hps.xml despite we generate
+        # them into sdram_config, so let's load hps.xml
+        hpsNodeList =3D self.hpsDom.getElementsByTagName('hps')
+
+        for hpsNode in hpsNodeList:
+
+            childNode =3D xmlgrok.firstElementChild(hpsNode)
+
+            while childNode !=3D None:
+                # MPFE info is part of fpga_interfaces
+                if childNode.nodeName =3D=3D 'fpga_interfaces':
+                    self.handleHpsFpgaInterfaces(childNode)
+
+                childNode =3D xmlgrok.nextElementSibling(childNode)
+
+        self.sequencerDefinesStream =3D streamer.Streamer(self.outputDir +=
 os.sep + EMIFGrokker.SDRAM_CONFIG_H_FILENAME, 'w')
+        self.sequencerDefinesStream.open()
+        self.sequencerDefinesStream.writeLicenseHeader()
+        self.sequencerDefinesStream.write(EMIFGrokker.SDRAM_FILE_HEADER)
+        ret =3D self.sequencerDefinesStream.writeSentinelStart(EMIFGrokker=
.SDRAM_SENTINEL)
+        if ret =3D=3D -1:
+            print("Empty header written. Exiting.")
+        self.sequencerDefinesStream.write("/* SDRAM configuration */\n")
+        self.sequencerDefinesStream.write(self.sdramHTemplate)
+        self.openSeqFiles()
+        self.processSeqAuto()
+
+        self.sequencerDefinesStream.write("\n")
+        self.sequencerDefinesStream.write("/* Sequencer auto configuration=
 */\n")
+        self.sequencerDefinesStream.write(self.seqAutoTemplate)
+        self.sequencerDefinesStream.write("\n")
+        self.sequencerDefinesStream.write("/* Sequencer defines configurat=
ion */\n")
+        self.sequencerDefinesStream.write(self.seqDefinesTemplate)
+        self.sequencerDefinesStream.write("\n")
+        self.sequencerDefinesStream.write("/* Sequencer ac_rom_init config=
uration */\n")
+        self.sequencerDefinesStream.write(self.seqAutoAcTemplate)
+        self.sequencerDefinesStream.write("\n\n")
+        self.sequencerDefinesStream.write("/* Sequencer inst_rom_init conf=
iguration */\n")
+        self.sequencerDefinesStream.write(self.seqAutoInstTemplate)
+        self.sequencerDefinesStream.write("\n")
+
+        ret =3D self.sequencerDefinesStream.writeSentinelEnd(EMIFGrokker.S=
DRAM_SENTINEL)
+        if ret =3D=3D -1:
+            print("Empty header written. Exiting.")
+        self.sequencerDefinesStream.close()
+        self.closeSeqFiles()
diff --git a/arch/arm/mach-socfpga/cv_bsp_generator/hps.py b/arch/arm/mach-=
socfpga/cv_bsp_generator/hps.py
new file mode 100755
index 00000000000..d702c5b4891
--- /dev/null
+++ b/arch/arm/mach-socfpga/cv_bsp_generator/hps.py
@@ -0,0 +1,571 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+"""
+Pinmux header file generator
+
+Process the hps.xml from Quartus and convert them to headers
+usable by U-Boot.
+
+Copyright (C) 2022 Intel Corporation <www.intel.com>
+
+Author: Lee, Kah Jing <kah.jing.lee@intel.com>
+"""
+import os
+import re
+import streamer
+import xmlgrok
+import xml.dom.minidom
+import collections
+import io
+from io import StringIO
+
+class CompatStringIO(io.StringIO):
+    def write(self, s):
+        if hasattr(s, 'decode'):
+            # Use unicode for python2 to keep compatible
+            return int(super(CompatStringIO, self).write(s.decode('utf-8')=
))
+        else:
+            return super(CompatStringIO, self).write(s)
+    def getvalue(self):
+        return str(super(CompatStringIO, self).getvalue())
+
+class HPSGrokker(object):
+
+    SCRIPT_DIR =3D os.path.dirname(os.path.realpath(__file__))
+    TEMPLATE_DIR =3D os.path.dirname(SCRIPT_DIR) + '/src'
+
+    MAKEFILE_FILENAME =3D "Makefile"
+    makefileTemplate =3D ""
+    RESET_CONFIG_H_FILENAME =3D "reset_config.h"
+    resetConfigHTemplate =3D ""
+
+    # If no device family is specified, assume Cyclone V.
+    derivedDeviceFamily =3D "cyclone5"
+
+    # Assume FPGA DMA 0-7 are not in use by default
+    # Note: there appears to be a weird mismatch between sopcinfo
+    # value vs hps.xml value of DMA_Enable of string_list hw.tcl
+    # type, where sopcinfo uses comma as separator e.g.
+    # "No,No,No,..." while hps.xml uses space as separator.
+    dmaEnable =3D "No No No No No No No No"
+
+    def __init__(self, inputDir, outputDir, hpsFileName=3D'hps.xml'):
+        """ HPSGrokker initialization """
+        self.inputDir =3D inputDir
+        self.outputDir =3D outputDir
+        self.hpsInFileName =3D inputDir + os.sep + hpsFileName
+        self.dom =3D xml.dom.minidom.parse(self.hpsInFileName)
+        self.peripheralStream =3D None
+        self.pinmuxConfigBuffer =3D None
+        self.pinmuxHeaderBuffer =3D None
+        self.pinmuxHeaderFile =3D None
+        self.pinmuxArraySize =3D 0
+        self.config_hps_ =3D "CFG_HPS_"
+        self.clockStream =3D None
+        self.pinmux_regs =3D self.get_default_pinmux_regs()
+        self.pinmux_configs =3D self.get_default_pinmux_configs()
+        self.pinmux_config_h =3D None
+
+        self.createFilesFromHPS()
+
+    def get_default_pinmux_regs(self):
+        """ Set default pinmux values """
+        p =3D collections.OrderedDict()
+
+        p['EMACIO0'] =3D 0
+        p['EMACIO1'] =3D 0
+        p['EMACIO2'] =3D 0
+        p['EMACIO3'] =3D 0
+        p['EMACIO4'] =3D 0
+        p['EMACIO5'] =3D 0
+        p['EMACIO6'] =3D 0
+        p['EMACIO7'] =3D 0
+        p['EMACIO8'] =3D 0
+        p['EMACIO9'] =3D 0
+        p['EMACIO10'] =3D 0
+        p['EMACIO11'] =3D 0
+        p['EMACIO12'] =3D 0
+        p['EMACIO13'] =3D 0
+        p['EMACIO14'] =3D 0
+        p['EMACIO15'] =3D 0
+        p['EMACIO16'] =3D 0
+        p['EMACIO17'] =3D 0
+        p['EMACIO18'] =3D 0
+        p['EMACIO19'] =3D 0
+        p['FLASHIO0'] =3D 0
+        p['FLASHIO1'] =3D 0
+        p['FLASHIO2'] =3D 0
+        p['FLASHIO3'] =3D 0
+        p['FLASHIO4'] =3D 0
+        p['FLASHIO5'] =3D 0
+        p['FLASHIO6'] =3D 0
+        p['FLASHIO7'] =3D 0
+        p['FLASHIO8'] =3D 0
+        p['FLASHIO9'] =3D 0
+        p['FLASHIO10'] =3D 0
+        p['FLASHIO11'] =3D 0
+        p['GENERALIO0'] =3D 0
+        p['GENERALIO1'] =3D 0
+        p['GENERALIO2'] =3D 0
+        p['GENERALIO3'] =3D 0
+        p['GENERALIO4'] =3D 0
+        p['GENERALIO5'] =3D 0
+        p['GENERALIO6'] =3D 0
+        p['GENERALIO7'] =3D 0
+        p['GENERALIO8'] =3D 0
+        p['GENERALIO9'] =3D 0
+        p['GENERALIO10'] =3D 0
+        p['GENERALIO11'] =3D 0
+        p['GENERALIO12'] =3D 0
+        p['GENERALIO13'] =3D 0
+        p['GENERALIO14'] =3D 0
+        p['GENERALIO15'] =3D 0
+        p['GENERALIO16'] =3D 0
+        p['GENERALIO17'] =3D 0
+        p['GENERALIO18'] =3D 0
+        p['GENERALIO19'] =3D 0
+        p['GENERALIO20'] =3D 0
+        p['GENERALIO21'] =3D 0
+        p['GENERALIO22'] =3D 0
+        p['GENERALIO23'] =3D 0
+        p['GENERALIO24'] =3D 0
+        p['GENERALIO25'] =3D 0
+        p['GENERALIO26'] =3D 0
+        p['GENERALIO27'] =3D 0
+        p['GENERALIO28'] =3D 0
+        p['GENERALIO29'] =3D 0
+        p['GENERALIO30'] =3D 0
+        p['GENERALIO31'] =3D 0
+        p['MIXED1IO0'] =3D 0
+        p['MIXED1IO1'] =3D 0
+        p['MIXED1IO2'] =3D 0
+        p['MIXED1IO3'] =3D 0
+        p['MIXED1IO4'] =3D 0
+        p['MIXED1IO5'] =3D 0
+        p['MIXED1IO6'] =3D 0
+        p['MIXED1IO7'] =3D 0
+        p['MIXED1IO8'] =3D 0
+        p['MIXED1IO9'] =3D 0
+        p['MIXED1IO10'] =3D 0
+        p['MIXED1IO11'] =3D 0
+        p['MIXED1IO12'] =3D 0
+        p['MIXED1IO13'] =3D 0
+        p['MIXED1IO14'] =3D 0
+        p['MIXED1IO15'] =3D 0
+        p['MIXED1IO16'] =3D 0
+        p['MIXED1IO17'] =3D 0
+        p['MIXED1IO18'] =3D 0
+        p['MIXED1IO19'] =3D 0
+        p['MIXED1IO20'] =3D 0
+        p['MIXED1IO21'] =3D 0
+        p['MIXED2IO0'] =3D 0
+        p['MIXED2IO1'] =3D 0
+        p['MIXED2IO2'] =3D 0
+        p['MIXED2IO3'] =3D 0
+        p['MIXED2IO4'] =3D 0
+        p['MIXED2IO5'] =3D 0
+        p['MIXED2IO6'] =3D 0
+        p['MIXED2IO7'] =3D 0
+        p['GPLINMUX48'] =3D 0
+        p['GPLINMUX49'] =3D 0
+        p['GPLINMUX50'] =3D 0
+        p['GPLINMUX51'] =3D 0
+        p['GPLINMUX52'] =3D 0
+        p['GPLINMUX53'] =3D 0
+        p['GPLINMUX54'] =3D 0
+        p['GPLINMUX55'] =3D 0
+        p['GPLINMUX56'] =3D 0
+        p['GPLINMUX57'] =3D 0
+        p['GPLINMUX58'] =3D 0
+        p['GPLINMUX59'] =3D 0
+        p['GPLINMUX60'] =3D 0
+        p['GPLINMUX61'] =3D 0
+        p['GPLINMUX62'] =3D 0
+        p['GPLINMUX63'] =3D 0
+        p['GPLINMUX64'] =3D 0
+        p['GPLINMUX65'] =3D 0
+        p['GPLINMUX66'] =3D 0
+        p['GPLINMUX67'] =3D 0
+        p['GPLINMUX68'] =3D 0
+        p['GPLINMUX69'] =3D 0
+        p['GPLINMUX70'] =3D 0
+        p['GPLMUX0'] =3D 1
+        p['GPLMUX1'] =3D 1
+        p['GPLMUX2'] =3D 1
+        p['GPLMUX3'] =3D 1
+        p['GPLMUX4'] =3D 1
+        p['GPLMUX5'] =3D 1
+        p['GPLMUX6'] =3D 1
+        p['GPLMUX7'] =3D 1
+        p['GPLMUX8'] =3D 1
+        p['GPLMUX9'] =3D 1
+        p['GPLMUX10'] =3D 1
+        p['GPLMUX11'] =3D 1
+        p['GPLMUX12'] =3D 1
+        p['GPLMUX13'] =3D 1
+        p['GPLMUX14'] =3D 1
+        p['GPLMUX15'] =3D 1
+        p['GPLMUX16'] =3D 1
+        p['GPLMUX17'] =3D 1
+        p['GPLMUX18'] =3D 1
+        p['GPLMUX19'] =3D 1
+        p['GPLMUX20'] =3D 1
+        p['GPLMUX21'] =3D 1
+        p['GPLMUX22'] =3D 1
+        p['GPLMUX23'] =3D 1
+        p['GPLMUX24'] =3D 1
+        p['GPLMUX25'] =3D 1
+        p['GPLMUX26'] =3D 1
+        p['GPLMUX27'] =3D 1
+        p['GPLMUX28'] =3D 1
+        p['GPLMUX29'] =3D 1
+        p['GPLMUX30'] =3D 1
+        p['GPLMUX31'] =3D 1
+        p['GPLMUX32'] =3D 1
+        p['GPLMUX33'] =3D 1
+        p['GPLMUX34'] =3D 1
+        p['GPLMUX35'] =3D 1
+        p['GPLMUX36'] =3D 1
+        p['GPLMUX37'] =3D 1
+        p['GPLMUX38'] =3D 1
+        p['GPLMUX39'] =3D 1
+        p['GPLMUX40'] =3D 1
+        p['GPLMUX41'] =3D 1
+        p['GPLMUX42'] =3D 1
+        p['GPLMUX43'] =3D 1
+        p['GPLMUX44'] =3D 1
+        p['GPLMUX45'] =3D 1
+        p['GPLMUX46'] =3D 1
+        p['GPLMUX47'] =3D 1
+        p['GPLMUX48'] =3D 1
+        p['GPLMUX49'] =3D 1
+        p['GPLMUX50'] =3D 1
+        p['GPLMUX51'] =3D 1
+        p['GPLMUX52'] =3D 1
+        p['GPLMUX53'] =3D 1
+        p['GPLMUX54'] =3D 1
+        p['GPLMUX55'] =3D 1
+        p['GPLMUX56'] =3D 1
+        p['GPLMUX57'] =3D 1
+        p['GPLMUX58'] =3D 1
+        p['GPLMUX59'] =3D 1
+        p['GPLMUX60'] =3D 1
+        p['GPLMUX61'] =3D 1
+        p['GPLMUX62'] =3D 1
+        p['GPLMUX63'] =3D 1
+        p['GPLMUX64'] =3D 1
+        p['GPLMUX65'] =3D 1
+        p['GPLMUX66'] =3D 1
+        p['GPLMUX67'] =3D 1
+        p['GPLMUX68'] =3D 1
+        p['GPLMUX69'] =3D 1
+        p['GPLMUX70'] =3D 1
+        p['NANDUSEFPGA'] =3D 0
+        p['UART0USEFPGA'] =3D 0
+        p['RGMII1USEFPGA'] =3D 0
+        p['SPIS0USEFPGA'] =3D 0
+        p['CAN0USEFPGA'] =3D 0
+        p['I2C0USEFPGA'] =3D 0
+        p['SDMMCUSEFPGA'] =3D 0
+        p['QSPIUSEFPGA'] =3D 0
+        p['SPIS1USEFPGA'] =3D 0
+        p['RGMII0USEFPGA'] =3D 0
+        p['UART1USEFPGA'] =3D 0
+        p['CAN1USEFPGA'] =3D 0
+        p['USB1USEFPGA'] =3D 0
+        p['I2C3USEFPGA'] =3D 0
+        p['I2C2USEFPGA'] =3D 0
+        p['I2C1USEFPGA'] =3D 0
+        p['SPIM1USEFPGA'] =3D 0
+        p['USB0USEFPGA'] =3D 0
+        p['SPIM0USEFPGA'] =3D 0
+
+        return p
+
+
+    def get_default_pinmux_configs(self):
+        """ Get default pinmux values """
+        p =3D collections.OrderedDict()
+
+        p['rgmii0'] =3D { 'name': 'CFG_HPS_EMAC0', 'used': 0 }
+        p['rgmii1'] =3D { 'name': 'CFG_HPS_EMAC1', 'used': 0 }
+        p['usb0'] =3D { 'name': 'CFG_HPS_USB0', 'used': 0 }
+        p['usb1'] =3D { 'name': 'CFG_HPS_USB1', 'used': 0 }
+        p['nand'] =3D { 'name': 'CFG_HPS_NAND', 'used': 0 }
+        p['sdmmc'] =3D { 'name': 'CFG_HPS_SDMMC', 'used': 0 }
+        p['CFG_HPS_SDMMC_BUSWIDTH'] =3D { 'name': 'CFG_HPS_SDMMC_BUSWIDTH'=
, 'used': 0 }
+        p['qspi'] =3D { 'name': 'CFG_HPS_QSPI', 'used': 0 }
+        p['CFG_HPS_QSPI_CS3'] =3D { 'name': 'CFG_HPS_QSPI_CS3', 'used': 0 }
+        p['CFG_HPS_QSPI_CS2'] =3D { 'name': 'CFG_HPS_QSPI_CS2', 'used': 0 }
+        p['CFG_HPS_QSPI_CS1'] =3D { 'name': 'CFG_HPS_QSPI_CS1', 'used': 0 }
+        p['CFG_HPS_QSPI_CS0'] =3D { 'name': 'CFG_HPS_QSPI_CS0', 'used': 0 }
+        p['uart0'] =3D { 'name': 'CFG_HPS_UART0', 'used': 0 }
+        p['CFG_HPS_UART0_TX'] =3D { 'name': 'CFG_HPS_UART0_TX', 'used': 0 }
+        p['CFG_HPS_UART0_CTS'] =3D { 'name': 'CFG_HPS_UART0_CTS', 'used': =
0 }
+        p['CFG_HPS_UART0_RTS'] =3D { 'name': 'CFG_HPS_UART0_RTS', 'used': =
0 }
+        p['CFG_HPS_UART0_RX'] =3D { 'name': 'CFG_HPS_UART0_RX', 'used': 0 }
+        p['uart1'] =3D { 'name': 'CFG_HPS_UART1', 'used': 0 }
+        p['CFG_HPS_UART1_TX'] =3D { 'name': 'CFG_HPS_UART1_TX', 'used': 0 }
+        p['CFG_HPS_UART1_CTS'] =3D { 'name': 'CFG_HPS_UART1_CTS', 'used': =
0 }
+        p['CFG_HPS_UART1_RTS'] =3D { 'name': 'CFG_HPS_UART1_RTS', 'used': =
0 }
+        p['CFG_HPS_UART1_RX'] =3D { 'name': 'CFG_HPS_UART1_RX', 'used': 0 }
+        p['trace'] =3D { 'name': 'CFG_HPS_TRACE', 'used': 0 }
+        p['i2c0'] =3D { 'name': 'CFG_HPS_I2C0', 'used': 0 }
+        p['i2c1'] =3D { 'name': 'CFG_HPS_I2C1', 'used': 0 }
+        p['i2c2'] =3D { 'name': 'CFG_HPS_I2C2', 'used': 0 }
+        p['i2c3'] =3D { 'name': 'CFG_HPS_I2C3', 'used': 0 }
+        p['spim0'] =3D { 'name': 'CFG_HPS_SPIM0', 'used': 0 }
+        p['spim1'] =3D { 'name': 'CFG_HPS_SPIM1', 'used': 0 }
+        p['spis0'] =3D { 'name': 'CFG_HPS_SPIS0', 'used': 0 }
+        p['spis1'] =3D { 'name': 'CFG_HPS_SPIS1', 'used': 0 }
+        p['can0'] =3D { 'name': 'CFG_HPS_CAN0', 'used': 0 }
+        p['can1'] =3D { 'name': 'CFG_HPS_CAN1', 'used': 0 }
+
+        p['can1'] =3D { 'name': 'CFG_HPS_CAN1', 'used': 0 }
+        p['can1'] =3D { 'name': 'CFG_HPS_CAN1', 'used': 0 }
+        p['can1'] =3D { 'name': 'CFG_HPS_CAN1', 'used': 0 }
+        p['can1'] =3D { 'name': 'CFG_HPS_CAN1', 'used': 0 }
+
+        return p
+
+    def updateTemplate(self, name, value):
+        """ Update Makefile & reset_config.h """
+        pattern =3D "${" + name + "}"
+        self.makefileTemplate =3D self.makefileTemplate.replace(pattern, v=
alue)
+        self.resetConfigHTemplate =3D self.resetConfigHTemplate.replace(pa=
ttern, value)
+
+    def romanToInteger(self, roman):
+        """
+        Convert roman numerals to integer
+        Since we only support I,V,X, the
+        supported range is 1-39
+        """
+        table =3D { 'I':1 , 'V':5, 'X':10 }
+
+        literals =3D list(roman)
+
+        value =3D 0
+        i =3D 0
+
+        while(i < (len(literals) - 1)):
+            current =3D table[literals[i]]
+            next =3D table[literals[i + 1]]
+            if (current < next):
+                value +=3D (next - current)
+                i +=3D 2
+            else:
+                value +=3D current
+                i +=3D 1
+
+        if (i < (len(literals))):
+            value +=3D table[literals[i]]
+
+        return value
+
+    def getDeviceFamily(self):
+        """ Get device family """
+        return self.derivedDeviceFamily
+
+    def getDeviceFamilyName(self, deviceFamily):
+        """ Get device family name """
+        p =3D re.compile('^(\w+)\s+(\w+)$')
+        m =3D p.match(deviceFamily)
+        return m.group(1).lower() + str(self.romanToInteger(m.group(2)))
+
+    def handleHPSSystemNode(self, systemNode):
+        """ handleHPSPeripheralsNode(peripheralsNode)
+        peripheralsNode is a peripherals element node in hps.xml
+        peripheralsNode is a list of peripheralNodes
+        """
+        configNode =3D xmlgrok.firstElementChild(systemNode)
+        while configNode !=3D None:
+
+            name =3D configNode.getAttribute('name')
+            value =3D configNode.getAttribute('value')
+
+            self.updateTemplate(name, value)
+
+            if name =3D=3D "DEVICE_FAMILY":
+                self.derivedDeviceFamily =3D self.getDeviceFamilyName(valu=
e)
+
+            if name =3D=3D "DMA_Enable":
+                self.dmaEnable =3D value
+
+            configNode =3D xmlgrok.nextElementSibling(configNode)
+
+    def handleHPSPeripheralNode(self, peripheralNode):
+        """ This node of the hps.xml may contain a name, value pair
+        We need to:
+            emit a #define for the peripheral for is 'used' state
+            emit a #define for that pair, if it is marked 'used'
+        """
+        peripheralNode =3D xmlgrok.firstElementChild(peripheralNode)
+
+        while peripheralNode !=3D None:
+            if peripheralNode.hasAttribute('name') and peripheralNode.hasA=
ttribute('used'):
+                newLine =3D "\n"
+                name =3D peripheralNode.getAttribute('name')
+                used =3D peripheralNode.getAttribute('used')
+
+                if used =3D=3D 'true' or used =3D=3D True:
+                    used =3D 1
+                elif used =3D=3D 'false' or used =3D=3D False:
+                    used =3D 0
+
+                configs =3D collections.OrderedDict()
+
+                configNode =3D xmlgrok.firstElementChild(peripheralNode)
+                while configNode !=3D None:
+                    config_define_name =3D configNode.getAttribute('name')
+                    config_define_value =3D configNode.getAttribute('value=
')
+                    configs[config_define_name] =3D config_define_value
+                    configNode =3D xmlgrok.nextElementSibling(configNode)
+                    if configNode =3D=3D None:
+                        newLine +=3D newLine
+                    self.pinmuxConfigBuffer.write("#define " + str(config_=
define_name) + ' ' + '(' + str(config_define_value) + ')' + newLine)
+
+                entry =3D self.pinmux_configs[name]
+                define_name =3D entry['name']
+
+                if (len(configs) > 0):
+                    self.pinmux_configs[name] =3D { 'name': define_name, '=
used': used, 'configs': configs }
+                else:
+                    self.pinmux_configs[name] =3D { 'name': define_name, '=
used': used }
+
+                # skip the parent peripheral node
+                # since only need to define child config node(s)
+                peripheralNode =3D xmlgrok.nextElementSibling(peripheralNo=
de)
+
+    def handleHPSPinmuxNode(self, pinmuxNode):
+        """ For a pinmuxNode, we may emit a #define for the name, value pa=
ir
+        """
+        if pinmuxNode.hasAttribute('name') and pinmuxNode.hasAttribute('va=
lue'):
+            self.pinmuxArraySize +=3D 1
+            name =3D pinmuxNode.getAttribute('name')
+            value =3D pinmuxNode.getAttribute('value')
+
+    def handleHPSPinmuxesNode(self, pinmuxesNode):
+        """ PinmuxesNode is a list of pinmuxNodes
+        """
+        self.pinmuxHeaderBuffer.write(str("const u8 sys_mgr_init_table[] =
=3D {\n"))
+
+        pinmuxNode =3D xmlgrok.firstElementChild(pinmuxesNode)
+        while pinmuxNode !=3D None:
+            if pinmuxNode.hasAttribute('name') and pinmuxNode.hasAttribute=
('value'):
+                self.pinmuxArraySize +=3D 1
+                name =3D pinmuxNode.getAttribute('name')
+                value =3D pinmuxNode.getAttribute('value')
+                self.pinmux_regs[name] =3D value
+            pinmuxNode =3D xmlgrok.nextElementSibling(pinmuxNode)
+
+        reg_count =3D 0
+        pinmux_regs_count =3D len(self.pinmux_regs)
+        for reg, value in self.pinmux_regs.items():
+            reg_count +=3D 1
+            if reg_count < pinmux_regs_count:
+                self.pinmuxHeaderBuffer.write(str("\t" + str(value) + ', /=
* ' + reg + ' */\n' ))
+            else:
+                self.pinmuxHeaderBuffer.write(str("\t" + str(value) + ' /*=
 ' + reg + ' */\n' ))
+
+        # Write the close of the pin MUX array in the header
+        self.pinmuxHeaderBuffer.write(str("};" ))
+
+    def handleHPSClockNode(self, clockNode):
+        """ A clockNode may emit a #define for the name, frequency pair
+        """
+        if clockNode.hasAttribute('name') and clockNode.hasAttribute('freq=
uency'):
+            name =3D clockNode.getAttribute('name')
+            frequency =3D clockNode.getAttribute('frequency')
+            self.clockStream.write("#define " + name + ' ' + '(' + frequen=
cy + ')' + '\n')
+
+    def handleHPSClocksNode(self, clocksNode):
+        """ A list of clockNodes is call clocksNode
+        """
+        self.clockStream =3D streamer.Streamer(self.outputDir + os.sep + c=
locksNode.nodeName + '.h', 'w')
+        self.clockStream.open()
+        clockNode =3D xmlgrok.firstElementChild(clocksNode)
+        while clockNode !=3D None:
+            self.handleHPSClockNode(clockNode)
+            clockNode =3D xmlgrok.nextElementSibling(clockNode)
+
+        self.clockStream.close()
+
+    def handleHpsFpgaInterfaces(self, node):
+        """ Update FPGA Interface registers """
+        node =3D xmlgrok.firstElementChild(node)
+
+        while node !=3D None:
+            name =3D node.getAttribute('name')
+            used =3D node.getAttribute('used')
+
+            if used =3D=3D 'true':
+                reset =3D 0
+            else:
+                reset =3D 1
+
+            if name =3D=3D 'F2H_AXI_SLAVE':
+                self.updateTemplate("DERIVED_RESET_ASSERT_FPGA2HPS", str(r=
eset))
+            elif name =3D=3D 'H2F_AXI_MASTER':
+                self.updateTemplate("DERIVED_RESET_ASSERT_HPS2FPGA", str(r=
eset))
+            elif name =3D=3D 'LWH2F_AXI_MASTER':
+                self.updateTemplate("DERIVED_RESET_ASSERT_LWHPS2FPGA", str=
(reset))
+
+            node =3D xmlgrok.nextElementSibling(node)
+
+    def createFilesFromHPS(self):
+        """ Parse xml and create pinmux_config.h """
+        # Unfortunately we can't determine the file name before
+        # parsing the XML, so let's build up the source file
+        # content in string buffer
+        self.pinmuxHeaderBuffer =3D CompatStringIO()
+        self.pinmuxConfigBuffer =3D CompatStringIO()
+
+        # Get a list of all nodes with the hps element name
+        hpsNodeList =3D self.dom.getElementsByTagName('hps')
+        if len(hpsNodeList) > 1:
+            print ("*** WARNING:" + "Multiple hps Elements found in %s!" %=
 self.hpsInFileName)
+        # For each of the hps element nodes, go through the child list
+        # Note that currently there is only one hps Element
+        # but this code will handle more than one hps node
+        # In the future, multiple hps nodes may need additional code
+        # to combine settings from the multiple hps Elements
+        for hpsNode in hpsNodeList:
+            # Currently, there are only 3 children of the hps Element:
+            #     peripherals, pin_muxes, and clocks
+            # but this is left open-ended for future additions to the
+            # specification for the hps.xml
+            childNode =3D xmlgrok.firstElementChild(hpsNode)
+            while childNode !=3D None:
+                if childNode.nodeName =3D=3D 'pin_muxes':
+                    self.handleHPSPinmuxesNode(childNode)
+                elif childNode.nodeName =3D=3D 'system':
+                    self.handleHPSSystemNode(childNode)
+                elif childNode.nodeName =3D=3D 'fpga_interfaces':
+                    self.handleHpsFpgaInterfaces(childNode)
+                elif childNode.nodeName =3D=3D 'peripherals':
+                    self.handleHPSPeripheralNode(childNode)
+                else:
+                    print ("***Error:Found unexpected HPS child node:%s" %=
 childNode.nodeName)
+                childNode =3D xmlgrok.nextElementSibling(childNode)
+
+        self.updateTemplate("DERIVED_DEVICE_FAMILY", self.derivedDeviceFam=
ily)
+
+        # Now we write string buffers into files once we know the device f=
amily
+        self.pinmux_config_h =3D 'pinmux_config.h'
+        self.pinmux_config_src =3D 'pinmux_config_' + self.derivedDeviceFa=
mily + '.c'
+
+        # Create pinmux_config .h
+        headerDefine =3D "__SOCFPGA_PINMUX_CONFIG_H__"
+        self.pinmuxHeaderFile =3D streamer.Streamer(self.outputDir + os.se=
p + self.pinmux_config_h, 'w')
+        self.pinmuxHeaderFile.open()
+        self.pinmuxHeaderFile.writeLicenseHeader()
+        self.pinmuxHeaderFile.write('/*\n * Altera SoCFPGA PinMux configur=
ation\n */\n\n')
+
+        self.pinmuxHeaderFile.write("#ifndef " + headerDefine + "\n")
+        self.pinmuxHeaderFile.write("#define " + headerDefine + "\n\n")
+        self.pinmuxHeaderFile.write(self.pinmuxHeaderBuffer.getvalue())
+        self.pinmuxHeaderFile.write("\n#endif /* " + headerDefine + " */\n=
")
+        self.pinmuxHeaderFile.close()
+
+        # Free up string buffers
+        self.pinmuxHeaderBuffer.close()
+        self.pinmuxConfigBuffer.close()
diff --git a/arch/arm/mach-socfpga/cv_bsp_generator/iocsr.py b/arch/arm/mac=
h-socfpga/cv_bsp_generator/iocsr.py
new file mode 100755
index 00000000000..a6ff5dfd829
--- /dev/null
+++ b/arch/arm/mach-socfpga/cv_bsp_generator/iocsr.py
@@ -0,0 +1,203 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+"""
+IOCSR header file generator
+
+Process the hiof file from Quartus and generate iocsr header
+usable by U-Boot.
+
+Copyright (C) 2022 Intel Corporation <www.intel.com>
+
+Author: Lee, Kah Jing <kah.jing.lee@intel.com>
+"""
+import os
+import struct
+import streamer
+
+class IOCSRGrokker(object):
+    """ Decode the .hiof file and produce some C source code
+    """
+    IOCSR_ROOT_FILENAME =3D 'iocsr_config'
+    IOCSR_SENTINEL =3D '__SOCFPGA_IOCSR_CONFIG_H__'
+    IOCSR_FILE_EXTENSION_MAX_LEN =3D 6
+    PTAG_HPS_IOCSR_INFO =3D 39
+    PTAG_HPS_IOCSR =3D 40
+    PTAG_DEVICE_NAME =3D 2
+    PTAG_TERMINATION =3D 8
+
+    def __init__(self, deviceFamily, inputDir, outputDir, hiofSrcFileName):
+        """ IOCSRGrokker Initialization """
+        self.deviceFamily =3D deviceFamily
+        self.inputDir =3D inputDir
+        self.outputDir =3D outputDir
+        self.hiofInFileName =3D hiofSrcFileName
+        self.iocsrFileName =3D  self.IOCSR_ROOT_FILENAME
+        self.headerOut =3D None
+        self.sourceOut =3D None
+        self.createFilesFromHIOF()
+
+    @staticmethod
+    def byteArrayToStr(bytes):
+        """ Convert a list of bytes into a string
+        """
+        # We don't like nulls
+        bytes =3D bytes.replace('\x00', '')
+        s =3D ''
+        for b in bytes:
+            s +=3D b
+        return s
+
+    @staticmethod
+    def getLengthData(bytes):
+        """
+        @param: bytes is a chunk of bytes that we need to decode
+        There will be a ptag that we may care about.
+        If we care about it, we will get the length of the chunk
+        that the ptag cares about.
+        @rtype: a pair, length of chunk and the chunk itself
+        @return: length of the ptag chunk we care about
+        @return: data chunk that ptag indicates we need to decode
+        """
+        blockSize =3D len(bytes)
+        i =3D 0
+        bitlength =3D 0
+        length =3D 0
+        data =3D []
+
+        while i < blockSize:
+            byte =3D struct.unpack('B', bytes[i:i+1])[0]
+            i +=3D 1
+
+            if byte =3D=3D 1:
+                bitlength =3D struct.unpack('I', bytes[i:i+4])[0]
+                i +=3D 4
+            elif byte =3D=3D 2:
+                length =3D struct.unpack('I', bytes[i:i+4])[0]
+                i +=3D 4
+
+            elif byte =3D=3D 5:
+                j =3D 0
+                while i < blockSize:
+                    data.append(struct.unpack('I', bytes[i:i+4])[0])
+                    i +=3D 4
+                    j +=3D 1
+
+            else:
+                i +=3D 4
+
+        return (bitlength, data)
+
+
+    def verifyRead(self, tagWeRead, tagWeExpected):
+        """ verify the hiof value with tag expected """
+        if tagWeRead !=3D tagWeExpected:
+            print ("***Error: Expected ptag of %02d, but got %02d" % (tagW=
eExpected, tagWeRead))
+
+    def createFilesFromHIOF(self):
+        """ read the hiof file to create iocsr_config.h """
+        self.hiofStream =3D streamer.Streamer(self.inputDir + os.sep + sel=
f.hiofInFileName, 'rb')
+        self.iocsrHeaderStream =3D streamer.Streamer(self.outputDir + os.s=
ep + self.iocsrFileName + '.h', 'w')
+        self.hiofStream.open()
+        self.iocsrHeaderStream.open()
+        self.iocsrHeaderStream.writeLicenseHeader()
+        self.iocsrHeaderStream.write('/*\n * Altera SoCFPGA IOCSR configur=
ation\n */\n\n')
+        ret =3D self.iocsrHeaderStream.writeSentinelStart(IOCSRGrokker.IOC=
SR_SENTINEL)
+        if ret =3D=3D -1:
+            print("Empty header written. Exiting.")
+
+        # Read the file extension (typically .hiof)
+        # and the file version
+        self.fileExtension =3D self.hiofStream.readBytesAsString(IOCSRGrok=
ker.IOCSR_FILE_EXTENSION_MAX_LEN)
+        self.fileVersion =3D self.hiofStream.readUnsignedInt()
+
+        # Now read the ptags
+        # Device name is first
+        self.programmerTag =3D self.hiofStream.readUnsignedShort()
+        self.verifyRead(self.programmerTag, self.PTAG_DEVICE_NAME)
+        self.deviceNameLength =3D self.hiofStream.readUnsignedInt()
+        self.deviceName =3D self.hiofStream.readBytesAsString(self.deviceN=
ameLength)
+
+        # Basic information of the HIOF files
+        # This is not used by the preloader generator, but we read it and =
ignore the
+        # contents.
+        programmerTag =3D self.hiofStream.readUnsignedShort()
+        self.verifyRead(programmerTag, self.PTAG_HPS_IOCSR_INFO)
+        basicHPSIOCSRInfoLength =3D self.hiofStream.readUnsignedInt()
+        self.hiofStream.read(basicHPSIOCSRInfoLength)
+
+        # Actual content of IOCSR information
+        self.programmerTag1 =3D self.hiofStream.readUnsignedShort()
+        self.verifyRead(self.programmerTag1, self.PTAG_HPS_IOCSR)
+        self.HPSIOCSRLength1 =3D self.hiofStream.readUnsignedInt()
+        self.HPSIOCSRBytes1 =3D self.hiofStream.read(self.HPSIOCSRLength1)
+        self.HPSIOCSRDataLength1, self.HPSIOCSRData1 =3D IOCSRGrokker.getL=
engthData(self.HPSIOCSRBytes1)
+
+        # Actual content of IOCSR information
+        self.programmerTag2 =3D self.hiofStream.readUnsignedShort()
+        self.verifyRead(self.programmerTag2, self.PTAG_HPS_IOCSR)
+        self.HPSIOCSRLength2 =3D self.hiofStream.readUnsignedInt()
+        self.HPSIOCSRBytes2 =3D self.hiofStream.read(self.HPSIOCSRLength2)
+        self.HPSIOCSRDataLength2, self.HPSIOCSRData2 =3D IOCSRGrokker.getL=
engthData(self.HPSIOCSRBytes2)
+
+        # Actual content of IOCSR information
+        self.programmerTag3 =3D self.hiofStream.readUnsignedShort()
+        self.verifyRead(self.programmerTag3, self.PTAG_HPS_IOCSR)
+        self.HPSIOCSRLength3 =3D self.hiofStream.readUnsignedInt()
+        self.HPSIOCSRBytes3 =3D self.hiofStream.read(self.HPSIOCSRLength3)
+        self.HPSIOCSRDataLength3, self.HPSIOCSRData3 =3D IOCSRGrokker.getL=
engthData(self.HPSIOCSRBytes3)
+
+        # Actual content of IOCSR information
+        self.programmerTag4 =3D self.hiofStream.readUnsignedShort()
+        self.verifyRead(self.programmerTag4, self.PTAG_HPS_IOCSR)
+        self.HPSIOCSRLength4 =3D self.hiofStream.readUnsignedInt()
+        self.HPSIOCSRBytes4 =3D self.hiofStream.read(self.HPSIOCSRLength4)
+        self.HPSIOCSRDataLength4, self.HPSIOCSRData4 =3D IOCSRGrokker.getL=
engthData(self.HPSIOCSRBytes4)
+
+        # Now we should see the end of the hiof input
+        programmerTag =3D self.hiofStream.readUnsignedShort()
+        if 8 !=3D programmerTag:
+            print ("I didn't find the end of the .hiof file when I expecte=
d to!")
+
+        self.iocsrHeaderStream.write('#define CFG_HPS_IOCSR_SCANCHAIN0_LEN=
GTH\t' +\
+                       str(self.HPSIOCSRDataLength1) + '\n')
+        self.iocsrHeaderStream.write('#define CFG_HPS_IOCSR_SCANCHAIN1_LEN=
GTH\t' +\
+                       str(self.HPSIOCSRDataLength2) + '\n')
+        self.iocsrHeaderStream.write('#define CFG_HPS_IOCSR_SCANCHAIN2_LEN=
GTH\t' +\
+                       str(self.HPSIOCSRDataLength3) + '\n')
+        self.iocsrHeaderStream.write('#define CFG_HPS_IOCSR_SCANCHAIN3_LEN=
GTH\t' +\
+                       str(self.HPSIOCSRDataLength4) + '\n')
+
+        self.iocsrHeaderStream.write("\n")
+
+        self.iocsrHeaderStream.write('const unsigned long iocsr_scan_chain=
0_table[] =3D {\n')
+        for value in self.HPSIOCSRData1:
+            hv =3D '0x%08X' % (value)
+            self.iocsrHeaderStream.write('\t' + hv + ',\n')
+        self.iocsrHeaderStream.write('};\n')
+        self.iocsrHeaderStream.write('\n')
+
+        self.iocsrHeaderStream.write('const unsigned long iocsr_scan_chain=
1_table[] =3D {\n')
+        for value in self.HPSIOCSRData2:
+            hv =3D '0x%08X' % (value)
+            self.iocsrHeaderStream.write('\t' + hv + ',\n')
+        self.iocsrHeaderStream.write('};\n')
+        self.iocsrHeaderStream.write('\n')
+
+        self.iocsrHeaderStream.write('const unsigned long iocsr_scan_chain=
2_table[] =3D {\n')
+        for value in self.HPSIOCSRData3:
+            hv =3D '0x%08X' % (value)
+            self.iocsrHeaderStream.write('\t' + hv + ',\n')
+        self.iocsrHeaderStream.write('};\n')
+        self.iocsrHeaderStream.write('\n')
+
+        self.iocsrHeaderStream.write('const unsigned long iocsr_scan_chain=
3_table[] =3D {\n')
+        for value in self.HPSIOCSRData4:
+            hv =3D '0x%08X' % (value)
+            self.iocsrHeaderStream.write('\t' + hv + ',\n')
+        self.iocsrHeaderStream.write('};\n')
+        self.iocsrHeaderStream.write('\n\n')
+
+        ret =3D self.iocsrHeaderStream.writeSentinelEnd(IOCSRGrokker.IOCSR=
_SENTINEL)
+        if ret =3D=3D -1:
+            print("Empty header written. Exiting.")
+
+        self.iocsrHeaderStream.close()
diff --git a/arch/arm/mach-socfpga/cv_bsp_generator/model.py b/arch/arm/mac=
h-socfpga/cv_bsp_generator/model.py
new file mode 100755
index 00000000000..c30d6246cc4
--- /dev/null
+++ b/arch/arm/mach-socfpga/cv_bsp_generator/model.py
@@ -0,0 +1,114 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+"""
+Data models for XML files required for generating a preloader.
+
+These classes encapsulate the complexities of XML DOM in order to
+make retrieving data from XML files easier and more reliable.
+By shielding data model deserialization from data consumers,
+it'd be easier to switch to other formats such as JSON if required.
+
+There are some assumptions about how these XML files are structured
+such as the hierarchy of elements and ordering of attributes, these
+are relatively safe assumptions for as long as the XML files are
+always generated by HPS megawizard (isw.tcl) and are not hand-edited.
+
+Copyright (C) 2022 Intel Corporation <www.intel.com>
+
+Author: Lee, Kah Jing <kah.jing.lee@intel.com>
+"""
+import xml.dom.minidom
+
+def getSingletonElementByTagName(parent, tagName):
+	"""
+	Find tag by name and ensure that there is exactly one match
+	"""
+	nodes =3D parent.getElementsByTagName(tagName)
+
+	if len(nodes) =3D=3D 0:
+		raise Exception("Can't find element: " + tagName)
+	elif len(nodes) > 1:
+		raise Exception("Unexpected multiple matches for singleton element: " + =
tagName)
+	else:
+		return nodes[0]
+
+class hps(object):
+	"""
+	Data model for hps.xml
+	"""
+	@staticmethod
+	def create(file):
+		""" hps model """
+		return hps(file)
+
+	def __init__(self, file):
+		""" hps model initialization """
+		self.dom =3D xml.dom.minidom.parse(file)
+
+		try:
+			# Look for <hps> node
+			self.hpsNode =3D getSingletonElementByTagName(self.dom, "hps")
+			# Look for <hps><system> node
+			self.hpsSystemNode =3D getSingletonElementByTagName(self.hpsNode, "syst=
em")
+		except Exception:
+			raise Exception("Can't initialize from file: " + file)
+
+	def getSystemConfig(self, param):
+		""" parse system configuration tag """
+		hpsSystemConfigNode =3D None
+
+		# Look for <hps><system><config ...> nodes
+		for node in self.hpsSystemNode.getElementsByTagName("config"):
+			# assume name is the first attribute as in <config name=3D"..." ...>
+			nameAttrNode =3D node.attributes.item(0)
+			if nameAttrNode.nodeName =3D=3D "name" and nameAttrNode.nodeValue =3D=
=3D param:
+				# assume value is the second attribute as in <config name=3D"..." valu=
e=3D"...">
+				valueAttrNode =3D node.attributes.item(1)
+				if valueAttrNode.nodeName =3D=3D "value":
+					hpsSystemConfigNode =3D valueAttrNode
+					break
+
+		if hpsSystemConfigNode =3D=3D None:
+			raise ValueError("Can't find <hps><system><config> node: " + param)
+
+		return hpsSystemConfigNode.nodeValue
+
+class emif(object):
+	"""
+	Data model for emif.xml.
+	"""
+	@staticmethod
+	def create(file):
+		""" emif model """
+		return emif(file)
+
+	def __init__(self, file):
+		""" emif model initialization """
+		self.dom =3D xml.dom.minidom.parse(file)
+
+		try:
+			# Look for <emif> node
+			self.emifNode =3D getSingletonElementByTagName(self.dom, "emif")
+			# Look for <emif><pll> node
+			self.emifPllNode =3D getSingletonElementByTagName(self.emifNode, "pll")
+		except Exception:
+			raise Exception("Can't initialize from file: " + file)
+
+	def getPllDefine(self, param):
+		""" parse pll define tag """
+		emifPllDefineNode =3D None
+
+		# Look for <emif><pll><define ...> nodes
+		for node in self.emifPllNode.getElementsByTagName("define"):
+			nameAttrNode =3D node.attributes.item(0)
+			# assume name is the first attribute as in <define name=3D"..." ...>
+			if nameAttrNode.nodeName =3D=3D "name" and nameAttrNode.nodeValue =3D=
=3D param:
+				# assume value is the second attribute as in <config name=3D"..." valu=
e=3D"...">
+				valueAttrNode =3D node.attributes.item(1)
+				if valueAttrNode.nodeName =3D=3D "value":
+					emifPllDefineNode =3D valueAttrNode
+					break
+
+		if emifPllDefineNode =3D=3D None:
+			raise Exception("Can't find EMIF PLL define node: " + param)
+
+		return emifPllDefineNode.nodeValue
diff --git a/arch/arm/mach-socfpga/cv_bsp_generator/renderer.py b/arch/arm/=
mach-socfpga/cv_bsp_generator/renderer.py
new file mode 100755
index 00000000000..0ab1e2f2df2
--- /dev/null
+++ b/arch/arm/mach-socfpga/cv_bsp_generator/renderer.py
@@ -0,0 +1,196 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+"""
+Document renderer class for preloader source files
+
+Each document renderer takes care of a full construction of
+a specific file format using the required data model.
+
+Copyright (C) 2022 Intel Corporation <www.intel.com>
+
+Author: Lee, Kah Jing <kah.jing.lee@intel.com>
+"""
+import collections
+import doc
+
+class pll_config_h:
+    """
+    pll_config.h renderer.
+    """
+
+    def __init__(self, hpsModel, emifModel):
+        """ renderer initialization """
+        self.hpsModel =3D hpsModel
+        self.emifModel =3D emifModel
+        self.doc =3D doc.generated_c_source("__SOCFPGA_PLL_CONFIG_H__")
+
+    def createContent(self):
+        """ add the content based on settings parsed. eventually it will be
+        written to pll_config.h file
+        """
+        doc.c_source.line(self.doc)
+        id =3D "CFG_HPS_DBCTRL_STAYOSC1"
+        valueString =3D self.hpsModel.getSystemConfig("dbctrl_stayosc1")
+        # Unfortunately hps.xml never tells us the data type of values
+        # attributes. Here we workaround this type of problem, often
+        # this is case-by-case, i.e. having to know which parameter that
+        # we're dealing with, hence this ugly parameter-specific
+        # if-statement needs here to workaround the data type inconsistency
+        if valueString.lower() =3D=3D "true":
+            value =3D "1"
+        else:
+            value =3D "0"
+        doc.c_source.define(self.doc, id, value )
+        doc.c_source.line(self.doc)
+        self.addMainPllSettings()
+        doc.c_source.line(self.doc)
+        self.addPeriphPllSettings()
+        doc.c_source.line(self.doc)
+        self.addSdramPllSettings()
+        doc.c_source.line(self.doc)
+        self.addClockFreq()
+        doc.c_source.line(self.doc)
+        self.addAlteraSettings()
+        doc.c_source.line(self.doc)
+
+    def addMainPllSettings(self):
+        """ add pll settings to the file """
+        paramMap =3D collections.OrderedDict()
+        paramMap["VCO_DENOM"] =3D "main_pll_n"
+        paramMap["VCO_NUMER"] =3D "main_pll_m"
+
+        for key in paramMap.keys():
+            id =3D "CFG_HPS_MAINPLLGRP_" + key
+            value =3D self.hpsModel.getSystemConfig(paramMap[key])
+            doc.c_source.define(self.doc, id,  value )
+
+        # main_pll_c0, main_pll_c1, main_pll_c2 are fixed counters,
+        doc.c_source.define(self.doc, "CFG_HPS_MAINPLLGRP_MPUCLK_CNT", "0")
+        doc.c_source.define(self.doc, "CFG_HPS_MAINPLLGRP_MAINCLK_CNT", "0=
")
+        doc.c_source.define(self.doc, "CFG_HPS_MAINPLLGRP_DBGATCLK_CNT", "=
0")
+
+        paramMap =3D collections.OrderedDict()
+
+        paramMap["MAINQSPICLK_CNT"] =3D "main_pll_c3"
+        paramMap["MAINNANDSDMMCCLK_CNT"] =3D "main_pll_c4"
+        paramMap["CFGS2FUSER0CLK_CNT"] =3D "main_pll_c5"
+        paramMap["MAINDIV_L3MPCLK"] =3D "l3_mp_clk_div"
+        paramMap["MAINDIV_L3SPCLK"] =3D "l3_sp_clk_div"
+        paramMap["MAINDIV_L4MPCLK"] =3D "l4_mp_clk_div"
+        paramMap["MAINDIV_L4SPCLK"] =3D "l4_sp_clk_div"
+        paramMap["DBGDIV_DBGATCLK"] =3D "dbg_at_clk_div"
+        paramMap["DBGDIV_DBGCLK"] =3D "dbg_clk_div"
+        paramMap["TRACEDIV_TRACECLK"] =3D "dbg_trace_clk_div"
+        paramMap["L4SRC_L4MP"] =3D "l4_mp_clk_source"
+        paramMap["L4SRC_L4SP"] =3D "l4_sp_clk_source"
+
+        for key in paramMap.keys():
+            id =3D "CFG_HPS_MAINPLLGRP_" + key
+            value =3D self.hpsModel.getSystemConfig(paramMap[key])
+            doc.c_source.define(self.doc, id, value )
+
+    def addPeriphPllSettings(self):
+        """ add peripheral pll settings to the file """
+        paramMap =3D collections.OrderedDict()
+        paramMap["VCO_DENOM"] =3D "periph_pll_n"
+        paramMap["VCO_NUMER"] =3D "periph_pll_m"
+        paramMap["VCO_PSRC"] =3D "periph_pll_source"
+        paramMap["EMAC0CLK_CNT"] =3D "periph_pll_c0"
+        paramMap["EMAC1CLK_CNT"] =3D "periph_pll_c1"
+        paramMap["PERQSPICLK_CNT"] =3D "periph_pll_c2"
+        paramMap["PERNANDSDMMCCLK_CNT"] =3D "periph_pll_c3"
+        paramMap["PERBASECLK_CNT"] =3D "periph_pll_c4"
+        paramMap["S2FUSER1CLK_CNT"] =3D "periph_pll_c5"
+        paramMap["DIV_USBCLK"] =3D "usb_mp_clk_div"
+        paramMap["DIV_SPIMCLK"] =3D "spi_m_clk_div"
+        paramMap["DIV_CAN0CLK"] =3D "can0_clk_div"
+        paramMap["DIV_CAN1CLK"] =3D "can1_clk_div"
+        paramMap["GPIODIV_GPIODBCLK"] =3D "gpio_db_clk_div"
+        paramMap["SRC_SDMMC"] =3D "sdmmc_clk_source"
+        paramMap["SRC_NAND"] =3D "nand_clk_source"
+        paramMap["SRC_QSPI"] =3D "qspi_clk_source"
+
+        for key in paramMap.keys():
+            id =3D "CFG_HPS_PERPLLGRP_" + key
+            value =3D self.hpsModel.getSystemConfig(paramMap[key])
+            doc.c_source.define(self.doc, id, value )
+
+    def addSdramPllSettings(self):
+        """ add sdram pll settings to the file """
+        value =3D self.emifModel.getPllDefine("PLL_MEM_CLK_DIV")
+        doc.c_source.define(self.doc, "CFG_HPS_SDRPLLGRP_VCO_DENOM", value=
 )
+        value =3D self.emifModel.getPllDefine("PLL_MEM_CLK_MULT")
+        doc.c_source.define(self.doc, "CFG_HPS_SDRPLLGRP_VCO_NUMER", value=
 )
+        doc.c_source.define(self.doc, "CFG_HPS_SDRPLLGRP_VCO_SSRC", "0")
+        doc.c_source.define(self.doc, "CFG_HPS_SDRPLLGRP_DDRDQSCLK_CNT", "=
1")
+        value =3D self.emifModel.getPllDefine("PLL_MEM_CLK_PHASE_DEG")
+        doc.c_source.define(self.doc, "CFG_HPS_SDRPLLGRP_DDRDQSCLK_PHASE",=
 value )
+        doc.c_source.define(self.doc, "CFG_HPS_SDRPLLGRP_DDR2XDQSCLK_CNT",=
 "0")
+        doc.c_source.define(self.doc, "CFG_HPS_SDRPLLGRP_DDR2XDQSCLK_PHASE=
", "0")
+        doc.c_source.define(self.doc, "CFG_HPS_SDRPLLGRP_DDRDQCLK_CNT", "1=
")
+        value =3D self.emifModel.getPllDefine("PLL_WRITE_CLK_PHASE_DEG")
+        doc.c_source.define(self.doc, "CFG_HPS_SDRPLLGRP_DDRDQCLK_PHASE", =
value )
+
+        try:
+            value =3D self.hpsModel.getSystemConfig("sdram_pll_c5")
+        except ValueError:
+            value =3D "5"
+        doc.c_source.define(self.doc, "CFG_HPS_SDRPLLGRP_S2FUSER2CLK_CNT",=
 value )
+        doc.c_source.define(self.doc, "CFG_HPS_SDRPLLGRP_S2FUSER2CLK_PHASE=
", "0")
+
+    def addClockFreq(self):
+        """ add clock frequency settings to the file """
+        paramMap =3D collections.OrderedDict()
+        paramMap["OSC1"] =3D "eosc1_clk_hz"
+        paramMap["OSC2"] =3D "eosc2_clk_hz"
+        paramMap["F2S_SDR_REF"] =3D "F2SCLK_SDRAMCLK_FREQ"
+        paramMap["F2S_PER_REF"] =3D "F2SCLK_PERIPHCLK_FREQ"
+        paramMap["MAINVCO"] =3D "main_pll_vco_hz"
+        paramMap["PERVCO"] =3D "periph_pll_vco_hz"
+
+        for key in paramMap.keys():
+            id =3D "CFG_HPS_CLK_" + key + "_HZ"
+            value =3D self.hpsModel.getSystemConfig(paramMap[key])
+            doc.c_source.define(self.doc, id, value )
+
+        eosc1 =3D int(self.hpsModel.getSystemConfig("eosc1_clk_hz"))
+        eosc2 =3D int(self.hpsModel.getSystemConfig("eosc2_clk_hz"))
+        m =3D int(self.emifModel.getPllDefine("PLL_MEM_CLK_MULT"))
+        n =3D int(self.emifModel.getPllDefine("PLL_MEM_CLK_DIV"))
+        vco =3D int(round(eosc1 * (m + 1) / (n + 1)))
+        doc.c_source.define(self.doc, "CFG_HPS_CLK_SDRVCO_HZ", str(vco) )
+
+        paramMap =3D collections.OrderedDict()
+        paramMap["EMAC0"] =3D "emac0_clk_hz"
+        paramMap["EMAC1"] =3D "emac1_clk_hz"
+        paramMap["USBCLK"] =3D "usb_mp_clk_hz"
+        paramMap["NAND"] =3D "nand_clk_hz"
+        paramMap["SDMMC"] =3D "sdmmc_clk_hz"
+        paramMap["QSPI"] =3D "qspi_clk_hz"
+        paramMap["SPIM"] =3D "spi_m_clk_hz"
+        paramMap["CAN0"] =3D "can0_clk_hz"
+        paramMap["CAN1"] =3D "can1_clk_hz"
+        paramMap["GPIODB"] =3D "gpio_db_clk_hz"
+        paramMap["L4_MP"] =3D "l4_mp_clk_hz"
+        paramMap["L4_SP"] =3D "l4_sp_clk_hz"
+
+        for key in paramMap.keys():
+            id =3D "CFG_HPS_CLK_" + key + "_HZ"
+            value =3D self.hpsModel.getSystemConfig(paramMap[key])
+            doc.c_source.define(self.doc, id, value )
+
+    def addAlteraSettings(self):
+        """ add Altera-related settings to the file """
+        paramMap =3D collections.OrderedDict()
+        paramMap["MPUCLK"] =3D "main_pll_c0_internal"
+        paramMap["MAINCLK"] =3D "main_pll_c1_internal"
+        paramMap["DBGATCLK"] =3D "main_pll_c2_internal"
+
+        for key in paramMap.keys():
+            id =3D "CFG_HPS_ALTERAGRP_" + key
+            value =3D self.hpsModel.getSystemConfig(paramMap[key])
+            doc.c_source.define(self.doc, id, value )
+
+    def __str__(self):
+        """ convert to string """
+        self.createContent()
+        return str(self.doc)
diff --git a/arch/arm/mach-socfpga/cv_bsp_generator/streamer.py b/arch/arm/=
mach-socfpga/cv_bsp_generator/streamer.py
new file mode 100755
index 00000000000..19c30aced6a
--- /dev/null
+++ b/arch/arm/mach-socfpga/cv_bsp_generator/streamer.py
@@ -0,0 +1,102 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+"""
+Generate license, file header and close tag.
+
+Copyright (C) 2022 Intel Corporation <www.intel.com>
+
+Author: Lee, Kah Jing <kah.jing.lee@intel.com>
+"""
+import os
+import struct
+import doc
+
+class Streamer(object):
+    """ Streamer class to generate license, header, and close tag.
+    """
+    def __init__(self, fileName, mode=3D'r'):
+        """ Streamer initialization """
+        self.fileName =3D fileName
+        self.mode =3D mode
+        self.file =3D None
+        self.sentinel =3D None
+        if '+' in mode or 'w' in mode or 'a' in mode:
+            self.fileMode =3D 'write'
+        else:
+            self.fileMode =3D 'read'
+
+    def close(self):
+        """ file close """
+        if self.file !=3D None:
+            self.file.close()
+            self.file =3D None
+
+    def open(self):
+        """ file open """
+        if self.fileName !=3D None:
+            if self.file =3D=3D None:
+                if self.fileMode =3D=3D 'write':
+                    print ("Generating file: %s..." % self.fileName)
+                else:
+                    print ("Reading file: %s..." % self.fileName)
+                self.file =3D open(self.fileName, self.mode)
+
+    def read(self, numBytes):
+        """ file read number of bytes """
+        if self.file =3D=3D None:
+            print ("***Error: Attempted to read from unopened file %s" \
+                  % (self.fileName))
+            exit(-1)
+
+        else:
+            return self.file.read(numBytes)
+
+    def readUnsignedInt(self):
+        """ read unsigned integer """
+        return struct.unpack('I', self.read(4))[0]
+
+    def readUnsignedShort(self):
+        """ read unsigned short """
+        return struct.unpack('H', self.read(2))[0]
+
+    def readBytesAsString(self, numBytes):
+        """ Read some bytes from a binary file
+        and interpret the data values as a String
+        """
+        bytes =3D self.read(numBytes)
+        s =3D bytes.decode('utf-8')
+
+        return s
+
+    def write(self, str):
+        """ file write """
+        if self.file =3D=3D None:
+            print ("***Error: Attempted to write to unopened file %s" \
+                % (self.fileName))
+            exit(-1)
+
+        else:
+            self.file.write("%s" % str)
+
+    def writeLicenseHeader(self):
+        """ write license & copyright """
+        # format the license header
+        licenseHeader =3D "/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Cl=
ause */\n"
+        self.file.write("%s" % licenseHeader)
+        copyrightHeader =3D "/*\n * Copyright (C) 2022 Intel Corporation <=
www.intel.com>\n *\n */\n"
+        self.file.write("%s" % copyrightHeader)
+
+    def writeSentinelStart(self, sentinel):
+        """ start header """
+        if sentinel =3D=3D None:
+            return -1
+        self.sentinel =3D sentinel
+        self.file.write("%s\n%s\n\n" % (\
+            "#ifndef " + self.sentinel,
+            "#define " + self.sentinel))
+
+    def writeSentinelEnd(self, sentinel):
+        """ end header """
+        if sentinel =3D=3D None:
+            return -1
+        self.sentinel =3D sentinel
+        self.file.write("\n%s\n" % ("#endif /* " + self.sentinel + " */"))
diff --git a/arch/arm/mach-socfpga/cv_bsp_generator/xmlgrok.py b/arch/arm/m=
ach-socfpga/cv_bsp_generator/xmlgrok.py
new file mode 100755
index 00000000000..fae1d745bfd
--- /dev/null
+++ b/arch/arm/mach-socfpga/cv_bsp_generator/xmlgrok.py
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+"""
+XML node parser
+
+Copyright (C) 2022 Intel Corporation <www.intel.com>
+
+Author: Lee, Kah Jing <kah.jing.lee@intel.com>
+"""
+import xml.dom
+
+def isElementNode(XMLNode):
+    """ check if the node is element node """
+    return XMLNode.nodeType =3D=3D xml.dom.Node.ELEMENT_NODE
+
+def firstElementChild(XMLNode):
+    """ Calling firstChild on an Node of type Element often (always?)
+    returns a Node of Text type.  How annoying!  Return the first Element
+    child
+    """
+    child =3D XMLNode.firstChild
+    while child !=3D None and not isElementNode(child):
+        child =3D nextElementSibling(child)
+    return child
+
+def nextElementSibling(XMLNode):
+    """ nextElementSibling will return the next sibling of XMLNode that is
+    an Element Node Type
+    """
+    sib =3D XMLNode.nextSibling
+    while sib !=3D None and not isElementNode(sib):
+        sib =3D sib.nextSibling
+    return sib
--=20
2.25.1

