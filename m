Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED2AC46CD2
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 22:41:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 232CD87CAD;
	Mon, 22 Jan 2024 23:39:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kqmbhkpV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9A3987BC1; Mon, 22 Jan 2024 23:39:38 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41D3687C9D
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 23:39:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5ff7a098ab8so28344687b3.3
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 14:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705963174; x=1706567974; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ovOxCJjRBfYNr5YTvMR2+x2jHVYgXUcydVKWjnrrdAA=;
 b=kqmbhkpV+QVZc0KJ9X2mAtvcG8cRa/8ahTt5va5eL6OD8SV8msXoZZEYld8AxdaaSO
 vgDj1tZo6hi7adO/H+B0c4W0HZlXjnLkwzSRrSosX3Nm0/hEn2bT32DySzFR+NQl7LeP
 ekfrYk2RjN9C3rAgQTzkGc6r7dQBh2+4YSB2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705963174; x=1706567974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ovOxCJjRBfYNr5YTvMR2+x2jHVYgXUcydVKWjnrrdAA=;
 b=qQ7AZlz8nHaoeHkMzOSUrQXpKIleS57sxbI1h02RloogA+avx2A3ZMUcskWU0yE6Xd
 48ucF8Mgc74MvZ23VcPNYYhCSIsMvzuz+3Lb/QIEjsz79CnVh64dYqHad9gFoRLyMuDT
 il7xVBe2fK7pO2WrM+FsRZRH8LVGrwKX9dYws2MnSSd/zx1RAELxg/3fjFyX4n/MXi7x
 zOuQwvs6OrRuA2H2VEGHcHPmAiXYCu4zj5+UmN9TI5oibEH8DwR1B4AVyRliFwnyBNo0
 GGbOTqf2DF1bCIcn/QEeCmNRUlnhK6TMbcFIm+clzCFT+/fbGTcDuA8W+SxUWfIzm/OD
 T+zg==
X-Gm-Message-State: AOJu0Yxt6Or6xyWlMa5jiIdGfeVg3sPgiTMhJy6HsGNTr9HnqfUPkyIO
 d6SqCWP8r70TbYbcOr42IfQxAgZGhTeQMx9hdefZw7kqALIhpRUTPipLAnu67q400WqOD0h7Dls
 K
X-Google-Smtp-Source: AGHT+IFnY8jYZl04oSF2fg9XBFgLgATiQtsqEFjuSYQ0kT0ApnRvxFoHhym6ofKwUltiPGJslo5QDQ==
X-Received: by 2002:a25:8b89:0:b0:dc2:2dfe:99bf with SMTP id
 j9-20020a258b89000000b00dc22dfe99bfmr2157752ybl.92.1705963174453; 
 Mon, 22 Jan 2024 14:39:34 -0800 (PST)
Received: from bill-the-cat..
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 c18-20020a5b0bd2000000b00dc255105656sm1773243ybr.4.2024.01.22.14.39.33
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 14:39:33 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 16/16] Kconfig: Centralize prompting for SYS_CONFIG_NAME
Date: Mon, 22 Jan 2024 17:39:20 -0500
Message-Id: <20240122223920.3630168-16-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122223920.3630168-1-trini@konsulko.com>
References: <20240122223920.3630168-1-trini@konsulko.com>
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

Generally speaking, we do not prompt for this value and define it in the
board specific Kconfig file. There are some valid use cases however
today where we do prompt for this value, so instead of having this be
done in a number of locations, do this at the top-level location only.

This removes the question from a number of other locations and makes it
consistent that when we do set the value directly, we always do it the
same way. We don't need to specify the type, it's always string.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/Kconfig                            | 11 ++++++++++-
 arch/arm/mach-mediatek/Kconfig          |  6 ------
 arch/arm/mach-meson/Kconfig             |  8 --------
 arch/arm/mach-versal-net/Kconfig        |  8 --------
 arch/arm/mach-versal/Kconfig            |  8 --------
 arch/arm/mach-zynq/Kconfig              |  8 --------
 arch/arm/mach-zynqmp-r5/Kconfig         |  8 --------
 arch/arm/mach-zynqmp/Kconfig            |  8 --------
 arch/mips/mach-mtmips/mt7620/Kconfig    |  1 -
 arch/mips/mach-mtmips/mt7621/Kconfig    |  1 -
 arch/mips/mach-mtmips/mt7628/Kconfig    |  1 -
 arch/nios2/Kconfig                      |  7 -------
 board/Marvell/octeon_ebb7304/Kconfig    |  1 -
 board/Marvell/octeon_nic23/Kconfig      |  1 -
 board/cadence/xtfpga/Kconfig            |  1 -
 board/cavium/thunderx/Kconfig           |  1 -
 board/freescale/imxrt1020-evk/Kconfig   |  1 -
 board/freescale/imxrt1050-evk/Kconfig   |  1 -
 board/freescale/imxrt1170-evk/Kconfig   |  1 -
 board/kontron/sl-mx6ul/Kconfig          |  1 -
 board/kontron/sl-mx8mm/Kconfig          |  1 -
 board/samsung/starqltechn/Kconfig       |  8 --------
 board/st/stih410-b2260/Kconfig          |  1 -
 board/st/stm32f429-discovery/Kconfig    |  1 -
 board/st/stm32f429-evaluation/Kconfig   |  1 -
 board/st/stm32f469-discovery/Kconfig    |  1 -
 board/st/stm32f746-disco/Kconfig        |  1 -
 board/st/stm32h743-disco/Kconfig        |  1 -
 board/st/stm32h743-eval/Kconfig         |  1 -
 board/st/stm32h750-art-pi/Kconfig       |  1 -
 board/sysam/amcore/Kconfig              |  1 -
 board/xilinx/microblaze-generic/Kconfig |  8 --------
 32 files changed, 10 insertions(+), 99 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index b6fb9e927337..0d3cce919f8f 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -361,7 +361,16 @@ config SYS_BOARD
 	  leave this option empty.
 
 config SYS_CONFIG_NAME
-	string
+	string "Board header file" if ARCH_MESON || ARCH_VERSAL || \
+		ARCH_VERSAL_NET || ARCH_ZYNQ || ARCH_ZYNQMP || \
+		ARCH_ZYNQMP_R5 || MICROBLAZE || NIOS2
+	default "meson64" if ARCH_MESON
+	default "microblaze-generic" if MICROBLAZE
+	default "xilinx_versal" if ARCH_VERSAL
+	default "xilinx_versal_net" if ARCH_VERSAL_NET
+	default "xilinx_zynqmp" if ARCH_ZYNQMP
+	default "xilinx_zynqmp_r5" if ARCH_ZYNQMP_R5
+	default "zynq-common" if ARCH_ZYNQ
 	help
 	  This option should contain the base name of board header file.
 	  The header file include/configs/<CONFIG_SYS_CONFIG_NAME>.h
diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index c3872f428697..82018bd9d3e3 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -133,7 +133,6 @@ config SYS_BOARD
 	  be used.
 
 config SYS_CONFIG_NAME
-	string "Board configuration name"
 	default "mt7622" if TARGET_MT7622
 	default "mt7623" if TARGET_MT7623
 	default "mt7629" if TARGET_MT7629
@@ -145,11 +144,6 @@ config SYS_CONFIG_NAME
 	default "mt8512" if TARGET_MT8512
 	default "mt8516" if TARGET_MT8516
 	default "mt8518" if TARGET_MT8518
-	default ""
-	help
-	  This option contains information about board configuration name.
-	  Based on this option include/configs/<CONFIG_SYS_CONFIG_NAME>.h header
-	  will be used for board configuration.
 
 config MTK_BROM_HEADER_INFO
 	string
diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
index d6c890580617..6e6f9c13f17d 100644
--- a/arch/arm/mach-meson/Kconfig
+++ b/arch/arm/mach-meson/Kconfig
@@ -88,12 +88,4 @@ config SYS_BOARD
 	  Based on this option board/<CONFIG_SYS_VENDOR>/<CONFIG_SYS_BOARD> will
 	  be used.
 
-config SYS_CONFIG_NAME
-	string "Board configuration name"
-	default "meson64"
-	help
-	  This option contains information about board configuration name.
-	  Based on this option include/configs/<CONFIG_SYS_CONFIG_NAME>.h header
-	  will be used for board configuration.
-
 endif
diff --git a/arch/arm/mach-versal-net/Kconfig b/arch/arm/mach-versal-net/Kconfig
index edff5b039e91..1b5339993f83 100644
--- a/arch/arm/mach-versal-net/Kconfig
+++ b/arch/arm/mach-versal-net/Kconfig
@@ -13,14 +13,6 @@ config SYS_VENDOR
 config SYS_SOC
 	default "versal-net"
 
-config SYS_CONFIG_NAME
-	string "Board configuration name"
-	default "xilinx_versal_net"
-	help
-	  This option contains information about board configuration name.
-	  Based on this option include/configs/<CONFIG_SYS_CONFIG_NAME>.h header
-	  will be used for board configuration.
-
 config COUNTER_FREQUENCY
 	int "Timer clock frequency"
 	default 0
diff --git a/arch/arm/mach-versal/Kconfig b/arch/arm/mach-versal/Kconfig
index 645f06add44d..629a14129d5a 100644
--- a/arch/arm/mach-versal/Kconfig
+++ b/arch/arm/mach-versal/Kconfig
@@ -13,14 +13,6 @@ config SYS_VENDOR
 config SYS_SOC
 	default "versal"
 
-config SYS_CONFIG_NAME
-	string "Board configuration name"
-	default "xilinx_versal"
-	help
-	  This option contains information about board configuration name.
-	  Based on this option include/configs/<CONFIG_SYS_CONFIG_NAME>.h header
-	  will be used for board configuration.
-
 config SYS_MALLOC_LEN
 	default 0x2000000
 
diff --git a/arch/arm/mach-zynq/Kconfig b/arch/arm/mach-zynq/Kconfig
index b4c439b4cd6d..265e9ce588ad 100644
--- a/arch/arm/mach-zynq/Kconfig
+++ b/arch/arm/mach-zynq/Kconfig
@@ -43,14 +43,6 @@ config SYS_VENDOR
 config SYS_SOC
 	default "zynq"
 
-config SYS_CONFIG_NAME
-	string "Board configuration name"
-	default "zynq-common"
-	help
-	  This option contains information about board configuration name.
-	  Based on this option include/configs/<CONFIG_SYS_CONFIG_NAME>.h header
-	  will be used for board configuration.
-
 config SYS_MALLOC_F_LEN
 	default 0x800
 
diff --git a/arch/arm/mach-zynqmp-r5/Kconfig b/arch/arm/mach-zynqmp-r5/Kconfig
index f14514b3c7c1..b2ba896e9b41 100644
--- a/arch/arm/mach-zynqmp-r5/Kconfig
+++ b/arch/arm/mach-zynqmp-r5/Kconfig
@@ -13,14 +13,6 @@ config SYS_VENDOR
 config SYS_SOC
 	default "zynqmp-r5"
 
-config SYS_CONFIG_NAME
-	string "Board configuration name"
-	default "xilinx_zynqmp_r5"
-	help
-	  This option contains information about board configuration name.
-	  Based on this option include/configs/<CONFIG_SYS_CONFIG_NAME>.h header
-	  will be used for board configuration.
-
 config CPU_FREQ_HZ
 	int "CPU frequency"
 	default 800000000
diff --git a/arch/arm/mach-zynqmp/Kconfig b/arch/arm/mach-zynqmp/Kconfig
index 7e7c87d16fa9..6a7be0b42715 100644
--- a/arch/arm/mach-zynqmp/Kconfig
+++ b/arch/arm/mach-zynqmp/Kconfig
@@ -35,14 +35,6 @@ config SYS_VENDOR
 config SYS_SOC
 	default "zynqmp"
 
-config SYS_CONFIG_NAME
-	string "Board configuration name"
-	default "xilinx_zynqmp"
-	help
-	  This option contains information about board configuration name.
-	  Based on this option include/configs/<CONFIG_SYS_CONFIG_NAME>.h header
-	  will be used for board configuration.
-
 config SYS_MEM_RSVD_FOR_MMU
 	bool "Reserve memory for MMU Table"
 	help
diff --git a/arch/mips/mach-mtmips/mt7620/Kconfig b/arch/mips/mach-mtmips/mt7620/Kconfig
index 3ca711ad0f3f..398c7c6a9486 100644
--- a/arch/mips/mach-mtmips/mt7620/Kconfig
+++ b/arch/mips/mach-mtmips/mt7620/Kconfig
@@ -67,7 +67,6 @@ config CPU_FREQ_MULTI
 	default 7 if CPU_FREQ_620MHZ
 
 config SYS_CONFIG_NAME
-	string "Board configuration name"
 	default "mt7620" if  BOARD_MT7620_RFB || BOARD_MT7620_MT7530_RFB
 
 config SYS_BOARD
diff --git a/arch/mips/mach-mtmips/mt7621/Kconfig b/arch/mips/mach-mtmips/mt7621/Kconfig
index 008a28f991ca..8fe6e0a2d9a8 100644
--- a/arch/mips/mach-mtmips/mt7621/Kconfig
+++ b/arch/mips/mach-mtmips/mt7621/Kconfig
@@ -102,7 +102,6 @@ config BOARD_MT7621_NAND_RFB
 endchoice
 
 config SYS_CONFIG_NAME
-	string "Board configuration name"
 	default "mt7621" if  BOARD_MT7621_RFB || BOARD_MT7621_NAND_RFB
 
 config SYS_BOARD
diff --git a/arch/mips/mach-mtmips/mt7628/Kconfig b/arch/mips/mach-mtmips/mt7628/Kconfig
index e7273591bca1..79b2ddc6692d 100644
--- a/arch/mips/mach-mtmips/mt7628/Kconfig
+++ b/arch/mips/mach-mtmips/mt7628/Kconfig
@@ -49,7 +49,6 @@ config SYS_BOARD
 	default "mt7628" if BOARD_MT7628_RFB
 
 config SYS_CONFIG_NAME
-	string "Board configuration name"
 	default "mt7628" if BOARD_MT7628_RFB
 
 source "board/gardena/smart-gateway-mt7688/Kconfig"
diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
index bb4fb2ac3a5c..b06b3efcf563 100644
--- a/arch/nios2/Kconfig
+++ b/arch/nios2/Kconfig
@@ -4,11 +4,4 @@ menu "Nios II architecture"
 config SYS_ARCH
 	default "nios2"
 
-config SYS_CONFIG_NAME
-	string "Board header file"
-	help
-	  This option should contain the base name of board header file.
-	  The header file include/configs/<CONFIG_SYS_CONFIG_NAME>.h
-	  should be included from include/config.h.
-
 endmenu
diff --git a/board/Marvell/octeon_ebb7304/Kconfig b/board/Marvell/octeon_ebb7304/Kconfig
index ab54e6dbbc35..b3244f751b1f 100644
--- a/board/Marvell/octeon_ebb7304/Kconfig
+++ b/board/Marvell/octeon_ebb7304/Kconfig
@@ -9,7 +9,6 @@ config SYS_VENDOR
 	default "Marvell"
 
 config SYS_CONFIG_NAME
-	string
 	default "octeon_ebb7304"
 
 config DEFAULT_DEVICE_TREE
diff --git a/board/Marvell/octeon_nic23/Kconfig b/board/Marvell/octeon_nic23/Kconfig
index 3c42e8acdadc..468bbb756e61 100644
--- a/board/Marvell/octeon_nic23/Kconfig
+++ b/board/Marvell/octeon_nic23/Kconfig
@@ -9,7 +9,6 @@ config SYS_VENDOR
 	default "Marvell"
 
 config SYS_CONFIG_NAME
-	string
 	default "octeon_nic23"
 
 config DEFAULT_DEVICE_TREE
diff --git a/board/cadence/xtfpga/Kconfig b/board/cadence/xtfpga/Kconfig
index 69296be49c7a..a64961e6d6a3 100644
--- a/board/cadence/xtfpga/Kconfig
+++ b/board/cadence/xtfpga/Kconfig
@@ -25,7 +25,6 @@ config SYS_VENDOR
 	default "cadence"
 
 config SYS_CONFIG_NAME
-	string
 	default "xtfpga"
 
 config BOARD_SDRAM_SIZE
diff --git a/board/cavium/thunderx/Kconfig b/board/cavium/thunderx/Kconfig
index 927d8765d675..3d4b260ea29c 100644
--- a/board/cavium/thunderx/Kconfig
+++ b/board/cavium/thunderx/Kconfig
@@ -13,7 +13,6 @@ config SYS_VENDOR
 	default "cavium"
 
 config SYS_CONFIG_NAME
-	string
 	default "thunderx_88xx"
 
 config CMD_ATF
diff --git a/board/freescale/imxrt1020-evk/Kconfig b/board/freescale/imxrt1020-evk/Kconfig
index d00cbff094b7..3cb8fb1e6e9f 100644
--- a/board/freescale/imxrt1020-evk/Kconfig
+++ b/board/freescale/imxrt1020-evk/Kconfig
@@ -13,7 +13,6 @@ config SYS_SOC
 	default "imxrt1020"
 
 config SYS_CONFIG_NAME
-	string
 	default "imxrt1020-evk"
 
 config IMX_CONFIG
diff --git a/board/freescale/imxrt1050-evk/Kconfig b/board/freescale/imxrt1050-evk/Kconfig
index 79e6e4524ad3..068130beca98 100644
--- a/board/freescale/imxrt1050-evk/Kconfig
+++ b/board/freescale/imxrt1050-evk/Kconfig
@@ -13,7 +13,6 @@ config SYS_SOC
 	default "imxrt1050"
 
 config SYS_CONFIG_NAME
-	string
 	default "imxrt1050-evk"
 
 config IMX_CONFIG
diff --git a/board/freescale/imxrt1170-evk/Kconfig b/board/freescale/imxrt1170-evk/Kconfig
index c61fc579713d..b433d6e5df0b 100644
--- a/board/freescale/imxrt1170-evk/Kconfig
+++ b/board/freescale/imxrt1170-evk/Kconfig
@@ -13,7 +13,6 @@ config SYS_SOC
 	default "imxrt1170"
 
 config SYS_CONFIG_NAME
-	string
 	default "imxrt1170-evk"
 
 config IMX_CONFIG
diff --git a/board/kontron/sl-mx6ul/Kconfig b/board/kontron/sl-mx6ul/Kconfig
index 4e58de209477..782e099cec22 100644
--- a/board/kontron/sl-mx6ul/Kconfig
+++ b/board/kontron/sl-mx6ul/Kconfig
@@ -9,7 +9,6 @@ config SYS_VENDOR
 	default "kontron"
 
 config SYS_CONFIG_NAME
-	string
 	default "kontron-sl-mx6ul"
 
 endif
diff --git a/board/kontron/sl-mx8mm/Kconfig b/board/kontron/sl-mx8mm/Kconfig
index 9dcf407c867c..1cfe9ee64bd8 100644
--- a/board/kontron/sl-mx8mm/Kconfig
+++ b/board/kontron/sl-mx8mm/Kconfig
@@ -9,7 +9,6 @@ config SYS_VENDOR
 	default "kontron"
 
 config SYS_CONFIG_NAME
-	string
 	default "kontron-sl-mx8mm"
 
 endif
diff --git a/board/samsung/starqltechn/Kconfig b/board/samsung/starqltechn/Kconfig
index 0eea666d0358..e928cb0ea89b 100644
--- a/board/samsung/starqltechn/Kconfig
+++ b/board/samsung/starqltechn/Kconfig
@@ -6,17 +6,9 @@ config SYS_BOARD
 	  starqltechn is a production board for S9 and S9+ phones(SM-G96x0) phones based on SDM845 SoC.
 
 config SYS_CONFIG_NAME
-	string "Board configuration name"
 	default "sdm845"
-	help
-	  This option contains information about board configuration name.
-	  Based on this option include/configs/<CONFIG_SYS_CONFIG_NAME>.h header
-	  will be used for board configuration.
 
 config SYS_VENDOR
 	default "samsung"
 
-config SYS_CONFIG_NAME
-	default "starqltechn"
-
 endif
diff --git a/board/st/stih410-b2260/Kconfig b/board/st/stih410-b2260/Kconfig
index 590add05feab..441a83cbaea6 100644
--- a/board/st/stih410-b2260/Kconfig
+++ b/board/st/stih410-b2260/Kconfig
@@ -13,7 +13,6 @@ config SYS_SOC
 	default "stih410"
 
 config SYS_CONFIG_NAME
-	string
 	default "stih410-b2260"
 
 endif
diff --git a/board/st/stm32f429-discovery/Kconfig b/board/st/stm32f429-discovery/Kconfig
index e73d11bada4f..3c93df20afac 100644
--- a/board/st/stm32f429-discovery/Kconfig
+++ b/board/st/stm32f429-discovery/Kconfig
@@ -13,7 +13,6 @@ config SYS_SOC
 	default "stm32f4"
 
 config SYS_CONFIG_NAME
-	string
 	default "stm32f429-discovery"
 
 endif
diff --git a/board/st/stm32f429-evaluation/Kconfig b/board/st/stm32f429-evaluation/Kconfig
index ca4bb3d9c956..eaa40db8a74a 100644
--- a/board/st/stm32f429-evaluation/Kconfig
+++ b/board/st/stm32f429-evaluation/Kconfig
@@ -13,7 +13,6 @@ config SYS_SOC
 	default "stm32f4"
 
 config SYS_CONFIG_NAME
-	string
 	default "stm32f429-evaluation"
 
 endif
diff --git a/board/st/stm32f469-discovery/Kconfig b/board/st/stm32f469-discovery/Kconfig
index de61b6f2f6da..622a8d82d81a 100644
--- a/board/st/stm32f469-discovery/Kconfig
+++ b/board/st/stm32f469-discovery/Kconfig
@@ -13,7 +13,6 @@ config SYS_SOC
 	default "stm32f4"
 
 config SYS_CONFIG_NAME
-	string
 	default "stm32f469-discovery"
 
 endif
diff --git a/board/st/stm32f746-disco/Kconfig b/board/st/stm32f746-disco/Kconfig
index 09289d23238e..86ace17377c5 100644
--- a/board/st/stm32f746-disco/Kconfig
+++ b/board/st/stm32f746-disco/Kconfig
@@ -13,7 +13,6 @@ config SYS_SOC
 	default "stm32f7"
 
 config SYS_CONFIG_NAME
-	string
 	default "stm32f746-disco"
 
 endif
diff --git a/board/st/stm32h743-disco/Kconfig b/board/st/stm32h743-disco/Kconfig
index 7d6ec1d95864..bc116bcf32fa 100644
--- a/board/st/stm32h743-disco/Kconfig
+++ b/board/st/stm32h743-disco/Kconfig
@@ -13,7 +13,6 @@ config SYS_SOC
 	default "stm32h7"
 
 config SYS_CONFIG_NAME
-	string
 	default "stm32h743-disco"
 
 endif
diff --git a/board/st/stm32h743-eval/Kconfig b/board/st/stm32h743-eval/Kconfig
index ea879b13c8b0..ff86de25f7de 100644
--- a/board/st/stm32h743-eval/Kconfig
+++ b/board/st/stm32h743-eval/Kconfig
@@ -13,7 +13,6 @@ config SYS_SOC
 	default "stm32h7"
 
 config SYS_CONFIG_NAME
-	string
 	default "stm32h743-eval"
 
 endif
diff --git a/board/st/stm32h750-art-pi/Kconfig b/board/st/stm32h750-art-pi/Kconfig
index c31b9849fde6..ab2d0f227d72 100644
--- a/board/st/stm32h750-art-pi/Kconfig
+++ b/board/st/stm32h750-art-pi/Kconfig
@@ -13,7 +13,6 @@ config SYS_SOC
 	default "stm32h7"
 
 config SYS_CONFIG_NAME
-	string
 	default "stm32h750-art-pi"
 
 endif
diff --git a/board/sysam/amcore/Kconfig b/board/sysam/amcore/Kconfig
index dd9816ec2435..e13ee8f6e90e 100644
--- a/board/sysam/amcore/Kconfig
+++ b/board/sysam/amcore/Kconfig
@@ -13,7 +13,6 @@ config SYS_VENDOR
         default "sysam"
 
 config SYS_CONFIG_NAME
-        string
         default "amcore"
 
 endif
diff --git a/board/xilinx/microblaze-generic/Kconfig b/board/xilinx/microblaze-generic/Kconfig
index dd5eacef52a8..038ff0b61306 100644
--- a/board/xilinx/microblaze-generic/Kconfig
+++ b/board/xilinx/microblaze-generic/Kconfig
@@ -6,14 +6,6 @@ config SYS_BOARD
 config SYS_VENDOR
 	default "xilinx"
 
-config SYS_CONFIG_NAME
-	string "Board configuration name"
-	default "microblaze-generic"
-	help
-	  This option contains information about board configuration name.
-	  Based on this option include/configs/<CONFIG_SYS_CONFIG_NAME>.h header
-	  will be used for board configuration.
-
 config XILINX_MICROBLAZE0_USE_MSR_INSTR
 	int "USE_MSR_INSTR range (0:1)"
 	default 0
-- 
2.34.1

