Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57858CCF9F8
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 12:06:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0884839FA;
	Wed,  5 Nov 2025 13:06:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iAevqJFx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D395783A07; Wed,  5 Nov 2025 13:06:32 +0100 (CET)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7A44839F1
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 13:06:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-793021f348fso5113816b3a.1
 for <u-boot@lists.denx.de>; Wed, 05 Nov 2025 04:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762344388; x=1762949188; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=1CJXof85rhYqQplGMkmcHwAqkKq1Kh4G1T4V+WEqhnE=;
 b=iAevqJFxW/n4LPzAlBxop9ZOhrBcpd0HpUjMmWJj+qBBYUYi0JpRqiqgn81A2VHonz
 IRDrTYjMN+32iY4RqNSQf/BWHDdrnesK28mFxHThIJ+teyqQrkMcW8q/tdQNkSGfHYrv
 gMhxo95RQINLwh+oFBOhZVKbIjFpJvYaxv2cMhCQutkr2Co2mbY89dpntx2xi76o6F3/
 M45oKLygXhYC4s80r3mKTjwvzbNDRpEa+MVJ97mn1K1weJd/UkYpSw1hcM73BNCLCkHn
 baSav4bRf0xtUgmJRjBBRn8LLxfq4t6INks9T52W28Ok8vxKdom42NSIeojDXokCMGUN
 y/7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762344388; x=1762949188;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1CJXof85rhYqQplGMkmcHwAqkKq1Kh4G1T4V+WEqhnE=;
 b=r7dXJHptqIb9vYxaCxVJUqZNlHvCcKVgIaKVgx/nhqlsUktza4pITTiSRtZK8dYmes
 1J9sUxF5UIs9632MduILfxcP31aTCBpvuM5Z/81N0ad+t2CVA0MOOuuFIR0lVNBBU1lc
 tttdYEBli1ybI9WdoMYqPbui1ro9UqgHzEjsRdXcrsnvwj0IdmmXtiH16po9OaJRXgAz
 O/6Qzo20usx3GcJjLCrF4F7Fai7XEgKw0jTKzaeSz4b/XM2m+t1+BUk+pr9mP55hKR5Y
 nPJb9CL7PPCSuQLi+Pmeazyez7ZBe2Ulwe3ruQTVL6KT1TJtbKyaJpIwAoIqeg9NH61r
 oJzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCURuxUUIcNQ5aqnd/2cdzFiRW9A3z5TkYYHHw1V8nmGhwYQ2jFOaJ3fUIv+PjheJJMufKBTnsY=@lists.denx.de
X-Gm-Message-State: AOJu0Yya8XEsEqR32U18pjB+GbN7B/XaIFKhWXOZ1JMyMobe8ock0RBh
 ePSjHMmxDKxSshMJAyksruydEAaYoXBoRI1srzZKY6OD8MRV+KTQec8oX/C91HiB
X-Gm-Gg: ASbGncv6QwOVmOLSHXweJ6uwab7JEdR99PC4Dk/RqxPVlchpoCP0pBLKHD07pLDP9c+
 M58Im22gz95ZnqWYaHz2kiZUDDDzV3hQggOlLnxHakaErg9e59gaGeDv15P/PBrZOeI4nLNmh2o
 taAjK1U5NUKrF8VYG7e8AuD2F1NKQZklOu+RhnllSLBzJihW5WJD0DgI8kb6ahbIM5AuJ6YRTne
 WkcEkI/oeqEOoTSkNh0af3QCYykYh/RjlfJYQAHgEgRJRdwU51DcmGSoGRhsZvuDKRAGm5gOo/S
 uJbixKDcQVHRqiSZZPx7wrO3hzgkvgzLGvqzLSLn+fZNPVf8bWMAdBhh9vlqAqhXw1hEbXF+EkW
 JfozcI+X5xrIvfYwJwecfhrNZLJ2nuqDxIV4sK+BCd6jWhEeQS/tyaj+iLDrg+/+8PfFuYOLliu
 QYSzts5Q7cYbWLvkRK5XPFcdUJPw==
X-Google-Smtp-Source: AGHT+IFnGwjZwBy/WgxHEq+7UIpIlyW7u733i98LE2muY3pSH/k0TIVRY69qpJrb5T1GwYCRlUUsPA==
X-Received: by 2002:a05:6a00:1988:b0:7a4:f552:b522 with SMTP id
 d2e1a72fcca58-7ae1f48d188mr3520007b3a.27.1762344387706; 
 Wed, 05 Nov 2025 04:06:27 -0800 (PST)
Received: from localhost.localdomain ([185.213.82.45])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7acd6d026dcsm6069554b3a.70.2025.11.05.04.06.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Nov 2025 04:06:27 -0800 (PST)
From: Brian Sune <briansune@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Subject: [PATCH v1] sync doc/README.socfpga with new info
Date: Wed,  5 Nov 2025 20:06:13 +0800
Message-ID: <20251105120613.530-1-briansune@gmail.com>
X-Mailer: git-send-email 2.47.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Pulled from official Altera trunk
and modified the handoff section.
New handoff tool location and operations
are explained accordingly.

Signed-off-by: Brian Sune <briansune@gmail.com>
---
 doc/README.socfpga | 412 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 295 insertions(+), 117 deletions(-)

diff --git a/doc/README.socfpga b/doc/README.socfpga
index e5adb62102b..ae87f4cd9da 100644
--- a/doc/README.socfpga
+++ b/doc/README.socfpga
@@ -1,168 +1,346 @@
-----------------------------------------
+---------------------------------------------------------------------
 SOCFPGA Documentation for U-Boot and SPL
-----------------------------------------
+---------------------------------------------------------------------
 
-This README is about U-Boot and SPL support for Altera's ARM Cortex-A9MPCore
-based SOCFPGA. To know more about the hardware itself, please refer to
-www.altera.com.
+This README is about U-Boot and SPL support for Intel SOCFPGA.
+To know more about the hardware itself, please refer to
+https://www.intel.com/content/www/us/en/products/programmable/soc.html
 
+Table of Contents
 ---------------------------------------------------------------------
-Cyclone 5 / Arria 5 generating the handoff header files for U-Boot SPL
+	1. Device Family Support vs Tested Intel Quartus
+	2. Feature Support
+	3. Major Changes and Known Issues
+	4. Git branch naming convention
+	5. Cyclone V / Arria V generating the handoff header files for U-Boot SPL
+	6. Arria10 generating the handoff header files for U-Boot SPL
+	7. mkimage for Cyclone V, Arria V and Arria 10
+	8. SDRAM secure region in U-boot ATF flow
+	9. binman for U-boot ATF flow
+
+
+1. Device Family Support vs Tested Intel Quartus
 ---------------------------------------------------------------------
 
-This text is assuming quartus 16.1, but newer versions will probably work just fine too;
-verified with DE1_SOC_Linux_FB demo project (https://github.com/VCTLabs/DE1_SOC_Linux_FB).
-Updated/working projects should build using either process below.
+	Processor			SOCFPGA Device Family		Intel Quartus Prime Pro Edition		Intel Quartus Prime Standard Edition
+	--------------------------------------------------------------------------------------------------------------------------------------------
+	Dual-core ARM Cortex-A9		Cyclone V			N/A					22.1
+					Arria 10			23.2					N/A
+
+	Quad-core ARM Cortex-A53	Stratix 10			23.2					N/A
+					Agilex				23.2					N/A
+					eASIC N5X			23.2					N/A
+
+
+2. Feature Support
+---------------------------------------------------------------------
 
-Note: it *should* work from Quartus 14.0.200 onwards, however, the current vendor demo
-projects must have the IP cores updated as shown below.
+	Hardware Feature			Cyclone V	Arria 10	Stratix 10	Agilex		eASIC N5X
+						Arria V
+	--------------------------------------------------------------------------------------------------------------------
+	SDRAM					Yes		Yes		Yes		Yes		Yes
+	HPS bridge (LWH2F, H2F, F2S)		Yes		Yes		Yes		Yes		Yes
+	HPS cold/warm reset			Yes		Yes		Yes		Yes		Yes
+	FPGA configuration			Yes		Yes		Yes		Yes		No
+	Partial reconfiguration			No		No		Yes		Yes		No
+	Ethernet (Synopsys EMAC controller)	Yes		Yes		Yes		Yes		Yes
+	Synopsys GPIO controller		Yes		Yes		Yes		Yes		Yes
+	Synopsys UART controller		Yes		Yes		Yes		Yes		Yes
+	Synopsys USB controller			Yes		Yes		Yes		Yes		Yes
+	Synopsys Watchdog timer			Yes		Yes		Yes		Yes		Yes
+	Synopsys I2C master controller		Yes		Yes		Yes		Yes		Yes
+	Synopsys SDMMC controller		Yes		Yes		Yes		Yes		Yes
+	Cadence QSPI controller			Yes		Yes		Yes		Yes		Yes
+	Denali NAND controller			No		Yes		Yes		Yes		Yes
+	---------------------------------------------------------------------------------------------------------------------
+
+	Software Feature			Cyclone V	Arria 10	Stratix 10	Agilex		eASIC N5X
+						Arria V
+	---------------------------------------------------------------------------------------------------------------------
+	Remote System Update (RSU) [1]		No		No		Yes		Yes		No
+	ARM Trusted Firmware (ATF) [2]		No		No		Yes		Yes		Yes
+	Vendor Authorized Boot (VAB)		No		No		No		No		Yes
+	---------------------------------------------------------------------------------------------------------------------
+
+	Notes:
+	[1] RSU SPT/CPB recovery features are supported with Quartus version 20.4 onwards
+	[2] ATF boot flow is supported with altera-opensource/arm-trusted-firmware branch:socfpga_v2.3 onwards
+
+
+3. Major Changes and Known Issues
+---------------------------------------------------------------------
 
-Rebuilding your Quartus project
--------------------------------
+	3.1 Upgraded U-boot to version v2023.04
 
-Choose one of the follwing methods, either command line or GUI.
 
-Using the command line
-~~~~~~~~~~~~~~~~~~~~~~
 
-First run the embedded command shell, using your path to the Quartus install:
+4. Git branch naming convention
+---------------------------------------------------------------------
+	This convention is important to direct all users of Intel SOCFPGA U-Boot repository to use
+	the appropriate branch.
+
+	The syntax of branch naming will be "socfpga_v[year].[month][_RC]". For example,
+	"socfpga_v2021.04_RC" or "socfpga_v2021.01"
+	Where,
+		[year] is the year of the branch released.
+		[month] is the month of the branch released.
+		[_RC] is the label for branch categories, optional, based on the branch categories below.
+
+	Generally, branches in Intel SOCFPGA U-Boot repository can be distincted into TWO categories,
+	which are with and without "RC" labeled.
+
+	Branch with "RC" labeled
+	~~~~~~~~~~~~~~~~~~~~~~~~
+	A "RC" labeled branch is for Intel internal active development use and customer early access
+	for latest updates without official customer support. Since this "RC" labeled branch is still
+	comes with active development, the branch release with latest year and month. There will be
+	always only ONE branch labeled with "RC" in Intel SOCFPGA U-Boot repository.
+
+	Branch without "RC" labeled
+	~~~~~~~~~~~~~~~~~~~~~~~~~~~
+	Latest stable branch (no RC labeled) is strongly recommended for any development and
+	production use outside of Intel. Only stable branches will be supported by official
+	customer support.
+
+
+5. Cyclone V / Arria V generating the handoff header files for U-Boot SPL
+---------------------------------------------------------------------
 
-  $ /path/to/intelFPGA/16.1/embedded/embedded_command_shell.sh
+	Rebuilding your Quartus project
+	-------------------------------
 
-Then (if necessary) update the IP cores in the project, generate HDL code, and
-build the project:
+	Choose one of the following methods, either command line or GUI.
 
-  $ cd path/to/project/dir
-  $ qsys-generate soc_system.qsys --upgrade-ip-cores
-  $ qsys-generate soc_system.qsys --synthesis=[VERILOG|VHDL]
-  $ quartus_sh --flow compile <project name>
+	Using the command line
+	~~~~~~~~~~~~~~~~~~~~~~
 
-Convert the resulting .sof file (SRAM object file) to .rbf file (Raw bit file):
+	First run the embedded command shell, using your path to the Quartus install:
 
-  $ quartus_cpf -c <project_name>.sof soc_system.rbf
+	  $ /path/to/intelFPGA/16.1/embedded/embedded_command_shell.sh
 
+	Then (if necessary) update the IP cores in the project, generate HDL code, and
+	build the project:
 
-Generate BSP handoff files
-~~~~~~~~~~~~~~~~~~~~~~~~~~
+	  $ cd path/to/project/dir
+	  $ qsys-generate soc_system.qsys --upgrade-ip-cores
+	  $ qsys-generate soc_system.qsys --synthesis=[VERILOG|VHDL]
+	  $ quartus_sh --flow compile <project name>
 
-You can run the bsp editor GUI below, or run the following command from the
-project directory:
+	Convert the resulting .sof file (SRAM object file) to .rbf file (Raw bit file):
 
-  $ /path/to/bsb/tools/bsp-create-settings --type spl --bsp-dir build \
-      --preloader-settings-dir hps_isw_handoff/soc_system_hps_0/ \
-      --settings build/settings.bsp
+	  $ quartus_cpf -c <project_name>.sof soc_system.rbf
 
-You should use the bsp "build" directory above (ie, where the settings.bsp file is)
-in the following u-boot command to update the board headers.  Once these headers
-are updated for a given project build, u-boot should be configured for the
-project board (eg, de0-nano-sockit) and then build the normal spl build.
 
-Now you can skip the GUI section.
+	Generate BSP handoff files
+	~~~~~~~~~~~~~~~~~~~~~~~~~~
 
+	There are two forms to run the handoff script.
+	Method 1 - directly call from tools:
+	 $ python ./tools/cv_bsp_generator/cv_bsp_generator.py \
+	 	  -i <path_to_qpds_handoff>/hps_isw_handoff/<foo bar> \
+		  -o board/<vendor name>/<board name>/qts
 
-Using the Qsys GUI
-~~~~~~~~~~~~~~~~~~
+	Method 2
+	 $ # general make command with auto config board detection
+	 $ make prepare
+	 $ # user path define with make
+	 $ make prepare HANDOFF_PATH=<handoff folder path>
+	 $ # user path export
+	 $ export HANDOFF_PATH=<handoff folder path>
+	 $ make prepare
 
-1. Navigate to your project directory
-2. Run Quartus II
-3. Open Project (Ctrl+J), select <project_name>.qpf
-4. Run QSys [Tools->QSys]
-  4.1 In the Open dialog, select '<project_name>.qsys'
-  4.2 In the Open System dialog, wait until completion and press 'Close'
-  4.3 In the Qsys window, click on 'Generate HDL...' in bottom right corner
-     4.3.1 In the 'Generation' window, click 'Generate'
-     4.3.2 In the 'Generate' dialog, wait until completion and click 'Close'
-  4.4 In the QSys window, click 'Finish'
-     4.4.1 In the 'Quartus II' pop up window, click 'OK'
-5. Back in Quartus II main window, do the following
-  5.1 Use Processing -> Start -> Start Analysis & Synthesis (Ctrl+K)
-  5.2 Use Processing -> Start Compilation (Ctrl+L)
+	The generated files are uboot-compatible. They will be located in \
+    board/<board vendor>/<platform_type>/qts. These files will be used for SPL \
+    generation.
 
-    ... this may take some time, have patience ...
+	Argument:
 
-6. Start the embedded command shell as shown in the previous section
-  6.1 Change directory to 'software/spl_bsp'
-  6.2 Prepare BSP by launching the BSP editor from ECS
-       => bsp-editor
-  6.3 In BSP editor
-      6.3.1 Use File -> Open
-      6.3.2 Select 'settings.bsp' file
-      6.3.3 Click Generate
-      6.3.4 Click Exit
+	-i  - Directory with QPDS handoff path.
+	-o  - Directory to store the U-Boot compatible headers.
 
+	This will generate (or update) the following 4 files:
 
-Post handoff generation
-~~~~~~~~~~~~~~~~~~~~~~~
+	  iocsr_config.h
+	  pinmux_config.h
+	  pll_config.h
+	  sdram_config.h
 
-Now that the handoff files are generated, U-Boot can be used to process
-the handoff files generated by the bsp-editor. For this, please use the
-following script from the u-boot source tree:
+	These files should be copied into "qts" directory in the board directory
+	(see output argument of cv_bsp_generator.py command above).
 
-  $ ./arch/arm/mach-socfpga/qts-filter.sh \
-        <soc_type> \
-        <input_qts_dir> \
-        <input_bsp_dir> \
-        <output_dir>
+	Here is an example for the DE-0 Nano SoC after the above rebuild process:
 
-Process QTS-generated files into U-Boot compatible ones.
+	  $ ll board/terasic/de0-nano-soc/qts/
+	  total 36
+	  -rw-r--r-- 1 sarnold sarnold 8826 Mar 21 18:11 iocsr_config.h
+	  -rw-r--r-- 1 sarnold sarnold 4398 Mar 21 18:11 pinmux_config.h
+	  -rw-r--r-- 1 sarnold sarnold 3190 Mar 21 18:11 pll_config.h
+	  -rw-r--r-- 1 sarnold sarnold 9022 Mar 21 18:11 sdram_config.h
 
-    soc_type      - Type of SoC, either 'cyclone5' or 'arria5'.
-    input_qts_dir - Directory with compiled Quartus project
-                    and containing the Quartus project file (QPF).
-    input_bsp_dir - Directory with generated bsp containing
-                    the settings.bsp file.
-    output_dir    - Directory to store the U-Boot compatible
-                    headers.
+	Note: file sizes will differ slightly depending on the selected board.
+	      For SoC devkit please refer to https://rocketboards.org/foswiki/Documentation/BuildingBootloader#Cyclone_V_SoC_45_Boot_from_SD_Card
 
-This will generate (or update) the following 4 files:
+	Now your board is ready for full mainline support including U-Boot SPL.
+	The Preloader will not be needed any more.
 
-  iocsr_config.h
-  pinmux_config.h
-  pll_config.h
-  sdram_config.h
 
-These files should be copied into "qts" directory in the board directory
-(see output argument of qts-filter.sh command above).
+6. Arria10 generating the handoff header files for U-Boot SPL
+----------------------------------------------------------
 
-Here is an example for the DE-0 Nano SoC after the above rebuild process:
+	A header file for inclusion in a devicetree for Arria10 can be generated
+	by the qts-filter-a10.sh script directly from the hps_isw_handoff/hps.xml
+	file generated during the FPGA project compilation.  The header contains
+	all PLL, clock, pinmux, and bridge configurations required.
 
-  $ ll board/terasic/de0-nano-soc/qts/
-  total 36
-  -rw-r--r-- 1 sarnold sarnold 8826 Mar 21 18:11 iocsr_config.h
-  -rw-r--r-- 1 sarnold sarnold 4398 Mar 21 18:11 pinmux_config.h
-  -rw-r--r-- 1 sarnold sarnold 3190 Mar 21 18:11 pll_config.h
-  -rw-r--r-- 1 sarnold sarnold 9022 Mar 21 18:11 sdram_config.h
+	Please look at the socfpga_arria10_socdk_sdmmc-u-boot.dtsi for an example
+	that includes use of the generated handoff header.
 
-Note: file sizes will differ slightly depending on the selected board.
+	Devicetree header generation
+	~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-Now your board is ready for full mainline support including U-Boot SPL.
-The Preloader will not be needed any more.
+	The qts-filter-a10.sh script can process the compile time genetated hps.xml
+	to create the appropriate devicetree header.
 
+
+	  $ ./arch/arm/mach-socfpga/qts-filter-a10.sh \
+		<hps_xml> \
+		<output_file>
+
+	    hps_xml      - hps_isw_handoff/hps.xml from Quartus project
+	    output_file  - Output filename and location for header file
+
+	The script generates a single header file names <output_file> that should
+	be placed in arch/arm/dts.
+
+7. mkimage for Cyclone V, Arria V and Arria 10
 ----------------------------------------------------------
-Arria 10 generating the handoff header files for U-Boot SPL
+
+	The mkimage tool creates an Intel BootROM compatible image of the
+	Cyclone V SoC, Arria V SoC or Arria 10 SoC bootloader. mkimage is invoked
+	automatically in default U-boot building proccess. To create BootROM
+	compatible image manually, user can run example below:
+
+	./tools/mkimage -T <type> -d <input file> <output file>
+
+	Cyclone V and Arria V:
+	./tools/mkimage -T socfpgaimage -d spl/u-boot-spl.bin spl/u-boot-spl.sfp
+
+	Arria 10:
+	./tools/mkimage -T socfpgaimage_v1 -d spl/u-boot-spl.bin spl/u-boot-spl.sfp
+
+	For more inforation, run "./tools/mkimage --help".
+
+8. SDRAM secure region in U-boot ATF flow
 ----------------------------------------------------------
 
-A header file for inclusion in a devicetree for Arria10 can be generated
-by the qts-filter-a10.sh script directly from the hps_isw_handoff/hps.xml
-file generated during the FPGA project compilation.  The header contains
-all PLL, clock, pinmux, and bridge configurations required.
+	In boot flow that uses ATF (ARM trusted firmware), the first 1 MiB of SDRAM
+	is configured as secure region, other address spaces are non-secure regions.
+	Only software executing	at secure state EL3 (eg: U-boot SPL, ATF) and secure
+	masters	are allowed access to the secure region.
+
+9. binman for U-boot ATF flow
+----------------------------------------------------------
+
+	Overview
+	~~~~~~~~
+
+	Before v2021.04, we provide *.sh/*.its for user to generate FIT image using
+	'mkimage' tool. To align with U-Boot community strategy to eliminate the custom
+	*.sh/*its script, we have removed all *.sh/*.its files and switched to use
+	'binman' tool to generate FIT image for all SOC64 devices (Stratix 10, Agilex,
+	eASIC N5X) started in U-boot version v2021.04.
+
+	FIT image content is defined in binman node in U-boot device tree (u-boot.dtb).
+	U-Boot v2021.04 support u-boot.itb and kernel.itb.
+
+	With "CONFIG_BINMAN" enabled in deconfig, U-boot will always run 'binman' tool
+	before end of the code compilation. If the required input files exists in U-boot
+	folder, *.itb files defined in u-boot.dtb will be generated. Otherwise, 'binman'
+	will not generate the *.itb files. You can run 'binman' tool manually via command
+	line to generate the *.itb file.
+
+	Input Files
+	~~~~~~~~~~~
+
+	Input files for *_atf_defconfig FIT image generation:
+		To generate u-boot.itb:
+		    u-boot-nodtb.bin
+		    u-boot.dtb
+		    bl31.bin
+		To generate kernel.itb:
+		    Image
+		    linux.dtb
 
-Please look at the socfpga_arria10_socdk_sdmmc-u-boot.dtsi for an example
-that includes use of the generated handoff header.
+	Input files for *_vab_defconfig FIT image generation:
+		To generate u-boot.itb:
+		    signed-u-boot-nodtb.bin
+		    signed-u-boot.dtb
+		    signed-bl31.bin
 
-Devicetree header generation
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+		To generate kernel.itb:
+		    signed-Image
+		    signed-linux.dtb
 
-The qts-filter-a10.sh script can process the compile time genetated hps.xml
-to create the appropriate devicetree header.
+	Command Line
+	~~~~~~~~~~~~
 
+	Please use the following commands to generate the u-boot.itb and kernel.itb:
 
-  $ ./arch/arm/mach-socfpga/qts-filter-a10.sh \
-        <hps_xml> \
-        <output_file>
+		$ <U-boot path>/tools/binman/binman build -u -d u-boot.dtb -O .
+			This command generate all FIT images that defined in device tree.
 
-    hps_xml      - hps_isw_handoff/hps.xml from Quartus project
-    output_file  - Output filename and location for header file
+		$ <U-boot path>/tools/binman/binman build -u -d u-boot.dtb -O . -i u-boot
+			This command generate u-boot.itb only.
 
-The script generates a single header file names <output_file> that should
-be placed in arch/arm/dts.
+		$ <U-boot path>/tools/binman/binman build -u -d u-boot.dtb -O . -i kernel
+			This command generate kernel.itb only.
+
+9. Official Boot-up Flow Support
+---------------------------------------------------------------------
+	U-boot with Arm Trusted Firmware (ATF, TF-A) boot-up is the official supported
+	boot flow for Intel SoC FPGA Arm 64-bit architecture devices including
+	Stratix 10, Agilex and N5X. ATF is the secure runtime firmware running at EL3
+	which handles secure accesses from U-boot proper and Linux running at EL2 and EL1.
+
+	Official boot flow:
+		U-boot -> ATF BL31 -> U-boot proper -> Linux
+
+	Legacy (aka non ATF) boot flow:
+		U-boot -> U-boot proper -> Linux
+
+	U-boot version socfpga_v2021.07 and onwards change the defconfig name to match
+	the official boot flow. The non ATF flow defconfigs are renamed with _legacy_
+	appended and is not officially supported moving forward. See details as follow.
+
+	Legacy boot flow:
+		socfpga_agilex_defconfig    -> socfpga_agilex_legacy_defconfig
+		socfpga_n5x_defconfig       -> socfpga_n5x_legacy_defconfig
+		socfpga_stratix10_defconfig -> socfpga_stratix10_legacy_defconfig
+
+	Official boot flow:
+		socfpga_agilex_atf_defconfig    -> socfpga_agilex_defconfig
+		socfpga_n5x_atf_defconfig       -> socfpga_n5x_defconfig
+		socfpga_stratix10_atf_defconfig -> socfpga_stratix10_defconfig
+
+10. FPGA full reconfig flow for SoC64 devices
+---------------------------------------------------------------------
+	Bridges should be disabled before running any FPGA reconfiguration,
+	this ensures that all outstanding traffic between MPFE to bridge and
+	FPGA to bridge are completed.
+
+	Bridges should be enabled after FPGA is successfully programmed
+	and entered user mode.
+
+	Legacy and official boot flow:
+	If you are running fpga load command in U-Boot console, you are required
+	to run below steps to gracefully shutdown the bridges before running FPGA
+	reconfiguration:
+		1. bridge disable command
+		2. fpga load command
+		3. bridge enable command after FPGA is successfully programmed
+
+	If you are running bootm to program FPGA with bitstream loading from
+	FIT, you are required to run below steps before running bootm command.
+		1. bridge disable command (can be done in U-Boot script)
+		2. bootm, the bridge would be enabled automatically once FPGA is
+		is successfully programmed.
-- 
2.25.1

