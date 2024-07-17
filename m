Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F14D5C3DA4B
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 08:07:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B01688A2A;
	Wed, 17 Jul 2024 10:07:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="HN9zeSUJ";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="szGYOW6f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59BAC88049; Wed, 17 Jul 2024 10:07:21 +0200 (CEST)
Received: from fhigh8-smtp.messagingengine.com
 (fhigh8-smtp.messagingengine.com [103.168.172.159])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DFC18870E
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 10:07:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 3A8C211402E4;
 Wed, 17 Jul 2024 04:07:18 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Wed, 17 Jul 2024 04:07:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1721203638;
 x=1721290038; bh=Zk6UJmgv2HSAwrSkC9Gtlm3DEcy9iQkOC8PLf808+to=; b=
 HN9zeSUJiHyORdNN6MD3qGaWPUM3cDzl1xvLDsUttyPfw+62nWyL+Mktfy726GId
 rhntpqqEIkZy+RqaKDa5Oj5blQSBLAlel5ZXwybwqqxZL8RPL+YX+q2xiV5efHa2
 axDaOGpHhhY/U7gjF/3kwfjsq8c0dH48p1FdmduTl74ytQUQUZNkOGTeZfSOW2G5
 s5UZ/BYfDc2Hb6LAxBd5xhHMJqtceEuewHQ0cTsuN4B8WrLAAciTo4YEG2W8sRMB
 BwYA5BzrcBP6BPTdR01YXhOQ7EwmqcCWVKgSm/XHb6uS2JihCNh0gBIE17t62ebq
 nXulFUs5oezIEXNOMC/0lQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1721203638; x=
 1721290038; bh=Zk6UJmgv2HSAwrSkC9Gtlm3DEcy9iQkOC8PLf808+to=; b=s
 zGYOW6fYrynbYl9t6w8tzFm+nMWEqRC7PnZeDdLkMsjFoVGASiWD5LPbeC6LAV5X
 Ce1r2IQ9aOom/mX0Jz1VJQWd/GGDyKeowwlIhNoRcQ/EqtltS71IuN08q3+3KP3H
 YQbN/r2c/n8Ck/rrpY3pb67c2Od2MJrrKeqw9eAflURhE5MRYyfTrUcLoV1GGX40
 80h1RTAiEmEaYbMMou7WzYh1/CcgA/hVGkkOGqi8ps5YeUYUwx4oZj9pn+cJhMZ4
 ZOqtYplxu5DpF2bVFBPJU/R7rWfMhOEBWKSnn3JfesijlMgt6VTuGar7yzXBN9r1
 E+fxMh7uNsvuPcBeJkU4w==
X-ME-Sender: <xms:tXuXZhPtgfb7mWi6tBZQpTtAGeIGtrG7O3Skz-VIT-v052l9TFkC5g>
 <xme:tXuXZj8fy__b6o9hi7QOyjMr6_Q4gDQ9dKlGIfnoXbHzKlcDXgrFN8aYbN1OpXU4z
 LxvBT2y8a2vcIkUTw8>
X-ME-Received: <xmr:tXuXZgRAA8-TTKIjvQxtap8IBToidMGxEDIAaRi8Xqn5DFq_VIG_CHopm3kFW47j5mlh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeehgddufedtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:tXuXZttFedBPkbDh3Qh55mEOeFqfUU006nmC-xn7mXj2KOLAr7RYuQ>
 <xmx:tXuXZpdEjUTNm_oduAO52gkw8Z2YGMqKUq7dCJqvJkcpODx706WFHw>
 <xmx:tXuXZp164MlnX3lrZH_2X3UmN9GJiS8XU2n7Tx8SaaRyIGl4-28NRQ>
 <xmx:tXuXZl_UFkTe8es7wIb3gt0T-w8pdp8ne_bAGo-k63g6vaZ-dZWdFg>
 <xmx:tnuXZs9gzjQMNyXdFJdYoWsi4sZrs2_6RzPdkEplR-2L2ZWxMeqGxAT4>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jul 2024 04:07:13 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 17 Jul 2024 16:07:02 +0800
Subject: [PATCH 1/2] Kconfig: Unify endian support option
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240717-edian-v1-1-3cd4896edf2d@flygoat.com>
References: <20240717-edian-v1-0-3cd4896edf2d@flygoat.com>
In-Reply-To: <20240717-edian-v1-0-3cd4896edf2d@flygoat.com>
To: u-boot@lists.denx.de, uboot-snps-arc@synopsys.com
Cc: Tom Rini <trini@konsulko.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Ezequiel Garcia <ezequiel@collabora.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Lars Povlsen <lars.povlsen@microchip.com>, 
 Horatiu Vultur <horatiu.vultur@microchip.com>, 
 Alexey Brodkin <alexey.brodkin@synopsys.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11929;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=8BQJC9vACWFnnfN01wwgAaG9d9flng/j71QwDA4NHRk=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrTp1avTrxRE7AsULJE24dusrlG+0HGJS+zfX+4S/pZrl
 vwXudrTUcrCIMbFICumyBIioNS3ofHigusPsv7AzGFlAhnCwMUpABNROsDI0DLHw1wpMfpwz6bV
 DY7+XlV59dMbu422BuwTOb/vkJpILCPDzHOacT8NuBetiNz4eXXC7r/f8/JD2Je1at/PvvRDbps
 WIwA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
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

Move SUPPORT_BIG_ENDIAN, SUPPORT_LITTLE_ENDIAN to top-level
arch Kconfig and let architectures select them as necessary.

Remove if guard for Endianness selection choice so we can
have one of SYS_BIG_ENDIAN, SYS_LITTLE_ENDIAN config symbol
defined even on single endian system.

Default endian to SYS_BIG_ENDIAN for MIPS || MICROBLAZE
and LITTLE_ENDIAN for the rest to retain old config
behaviour.

Note: PPC, SH, Xtensa are technically bi-endian, but I
checked compiled u-boot image with readelf, U-Boot currently
only support little endian for SH and Xtensa, Big Endian for
PPC.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/Kconfig                  | 34 ++++++++++++++++++++++++++--------
 arch/mips/Kconfig             | 20 +++++++-------------
 arch/mips/mach-ath79/Kconfig  |  8 ++++----
 arch/mips/mach-bmips/Kconfig  | 20 ++++++++++----------
 arch/mips/mach-jz47xx/Kconfig |  2 +-
 arch/mips/mach-mscc/Kconfig   |  4 ++--
 arch/mips/mach-pic32/Kconfig  |  2 +-
 7 files changed, 51 insertions(+), 39 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index abd406d48841..8f1f46670128 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -8,6 +8,13 @@ config CREATE_ARCH_SYMLINK
 config HAVE_ARCH_IOREMAP
 	bool
 
+config SUPPORT_BIG_ENDIAN
+	bool
+
+config SUPPORT_LITTLE_ENDIAN
+	bool
+	default y if !SUPPORT_BIG_ENDIAN
+
 config SYS_CACHE_SHIFT_4
 	bool
 
@@ -59,6 +66,8 @@ config ARC
 	select SUPPORT_OF_CONTROL
 	select SYS_CACHE_SHIFT_7
 	select TIMER
+	select SUPPORT_BIG_ENDIAN
+	select SUPPORT_LITTLE_ENDIAN
 	select SYS_BIG_ENDIAN if CPU_BIG_ENDIAN
 	select SYS_LITTLE_ENDIAN if !CPU_BIG_ENDIAN
 
@@ -68,6 +77,7 @@ config ARM
 	select CREATE_ARCH_SYMLINK
 	select HAVE_PRIVATE_LIBGCC if !ARM64
 	select SUPPORT_ACPI
+	select SUPPORT_LITTLE_ENDIAN
 	select SUPPORT_OF_CONTROL
 
 config M68K
@@ -77,10 +87,13 @@ config M68K
 	select SYS_BOOT_GET_CMDLINE
 	select SYS_BOOT_GET_KBD
 	select SYS_CACHE_SHIFT_4
+	select SUPPORT_BIG_ENDIAN
 	select SUPPORT_OF_CONTROL
 
 config MICROBLAZE
 	bool "MicroBlaze architecture"
+	select SUPPORT_BIG_ENDIAN
+	select SUPPORT_LITTLE_ENDIAN
 	select SUPPORT_OF_CONTROL
 	imply CMD_TIMER
 	imply SPL_REGMAP if SPL
@@ -101,12 +114,14 @@ config NIOS2
 	select DM
 	select DM_EVENT
 	select OF_CONTROL
+	select SUPPORT_LITTLE_ENDIAN
 	select SUPPORT_OF_CONTROL
 	imply CMD_DM
 
 config PPC
 	bool "PowerPC architecture"
 	select HAVE_PRIVATE_LIBGCC
+	select SUPPORT_BIG_ENDIAN
 	select SUPPORT_OF_CONTROL
 	select SYS_BOOT_GET_CMDLINE
 	select SYS_BOOT_GET_KBD
@@ -115,6 +130,7 @@ config RISCV
 	bool "RISC-V architecture"
 	select CREATE_ARCH_SYMLINK
 	select SUPPORT_ACPI
+	select SUPPORT_LITTLE_ENDIAN
 	select SUPPORT_OF_CONTROL
 	select OF_CONTROL
 	select DM
@@ -160,6 +176,8 @@ config SANDBOX
 	select PCI_ENDPOINT
 	select SPI
 	select SUPPORT_OF_CONTROL
+	select SUPPORT_BIG_ENDIAN
+	select SUPPORT_LITTLE_ENDIAN
 	select SYSRESET_CMD_POWEROFF if CMD_POWEROFF
 	select SYS_CACHE_SHIFT_4
 	select IRQ
@@ -224,6 +242,7 @@ config SANDBOX
 
 config SH
 	bool "SuperH architecture"
+	select SUPPORT_LITTLE_ENDIAN
 	select HAVE_PRIVATE_LIBGCC
 	select SUPPORT_OF_CONTROL
 
@@ -231,6 +250,7 @@ config X86
 	bool "x86 architecture"
 	select SUPPORT_SPL
 	select SUPPORT_TPL
+	select SUPPORT_LITTLE_ENDIAN
 	select CREATE_ARCH_SYMLINK
 	select DM
 	select HAVE_ARCH_IOMAP
@@ -312,6 +332,7 @@ config X86
 config XTENSA
 	bool "Xtensa architecture"
 	select CREATE_ARCH_SYMLINK
+	select SUPPORT_LITTLE_ENDIAN
 	select SUPPORT_OF_CONTROL
 
 endchoice
@@ -515,24 +536,21 @@ endif
 
 source "board/keymile/Kconfig"
 
-if MIPS || MICROBLAZE
-
 choice
 	prompt "Endianness selection"
+	default SYS_BIG_ENDIAN if MIPS || MICROBLAZE
+	default SYS_LITTLE_ENDIAN
 	help
-	  Some MIPS boards can be configured for either little or big endian
+	  Some boards can be configured for either little or big endian
 	  byte order. These modes require different U-Boot images. In general there
 	  is one preferred byteorder for a particular system but some systems are
 	  just as commonly used in the one or the other endianness.
 
 config SYS_BIG_ENDIAN
 	bool "Big endian"
-	depends on (SUPPORTS_BIG_ENDIAN && MIPS) || MICROBLAZE
+	depends on SUPPORT_BIG_ENDIAN
 
 config SYS_LITTLE_ENDIAN
 	bool "Little endian"
-	depends on (SUPPORTS_LITTLE_ENDIAN && MIPS) || MICROBLAZE
-
+	depends on SUPPORT_LITTLE_ENDIAN
 endchoice
-
-endif
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index eb7f3ad23762..38577af43d03 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -28,14 +28,14 @@ config TARGET_MALTA
 	select OF_ISA_BUS
 	select PCI_MAP_SYSTEM_MEMORY
 	select ROM_EXCEPTION_VECTORS
-	select SUPPORTS_BIG_ENDIAN
 	select SUPPORTS_CPU_MIPS32_R1
 	select SUPPORTS_CPU_MIPS32_R2
 	select SUPPORTS_CPU_MIPS32_R6
 	select SUPPORTS_CPU_MIPS64_R1
 	select SUPPORTS_CPU_MIPS64_R2
 	select SUPPORTS_CPU_MIPS64_R6
-	select SUPPORTS_LITTLE_ENDIAN
+	select SUPPORT_BIG_ENDIAN
+	select SUPPORT_LITTLE_ENDIAN
 	select SWAP_IO_SPACE
 	imply CMD_DM
 
@@ -86,7 +86,7 @@ config ARCH_MTMIPS
 	select ROM_EXCEPTION_VECTORS
 	select SUPPORTS_CPU_MIPS32_R1
 	select SUPPORTS_CPU_MIPS32_R2
-	select SUPPORTS_LITTLE_ENDIAN
+	select SUPPORT_LITTLE_ENDIAN
 	select SUPPORT_SPL
 
 config ARCH_JZ47XX
@@ -112,7 +112,7 @@ config ARCH_OCTEON
 	select MIPS_TUNE_OCTEON3
 	select MTD
 	select ROM_EXCEPTION_VECTORS
-	select SUPPORTS_BIG_ENDIAN
+	select SUPPORT_BIG_ENDIAN
 	select SUPPORTS_CPU_MIPS64_OCTEON
 	select PHYS_64BIT
 	select OF_CONTROL
@@ -138,14 +138,14 @@ config TARGET_BOSTON
 	select OF_BOARD_SETUP
 	select OF_CONTROL
 	select ROM_EXCEPTION_VECTORS
-	select SUPPORTS_BIG_ENDIAN
 	select SUPPORTS_CPU_MIPS32_R1
 	select SUPPORTS_CPU_MIPS32_R2
 	select SUPPORTS_CPU_MIPS32_R6
 	select SUPPORTS_CPU_MIPS64_R1
 	select SUPPORTS_CPU_MIPS64_R2
 	select SUPPORTS_CPU_MIPS64_R6
-	select SUPPORTS_LITTLE_ENDIAN
+	select SUPPORT_BIG_ENDIAN
+	select SUPPORT_LITTLE_ENDIAN
 	imply CMD_DM
 
 config TARGET_XILFPGA
@@ -159,7 +159,7 @@ config TARGET_XILFPGA
 	select ROM_EXCEPTION_VECTORS
 	select SUPPORTS_CPU_MIPS32_R1
 	select SUPPORTS_CPU_MIPS32_R2
-	select SUPPORTS_LITTLE_ENDIAN
+	select SUPPORT_LITTLE_ENDIAN
 	imply CMD_DM
 	help
 	  This supports IMGTEC MIPSfpga platform
@@ -413,12 +413,6 @@ config MIPS_BOOT_FDT
 
 endmenu
 
-config SUPPORTS_BIG_ENDIAN
-	bool
-
-config SUPPORTS_LITTLE_ENDIAN
-	bool
-
 config SUPPORTS_CPU_MIPS32_R1
 	bool
 
diff --git a/arch/mips/mach-ath79/Kconfig b/arch/mips/mach-ath79/Kconfig
index cd85d1b6c31b..2fa628568aa0 100644
--- a/arch/mips/mach-ath79/Kconfig
+++ b/arch/mips/mach-ath79/Kconfig
@@ -8,7 +8,7 @@ config SOC_AR933X
 	bool
 	select MIPS_TUNE_24KC
 	select ROM_EXCEPTION_VECTORS
-	select SUPPORTS_BIG_ENDIAN
+	select SUPPORT_BIG_ENDIAN
 	select SUPPORTS_CPU_MIPS32_R1
 	select SUPPORTS_CPU_MIPS32_R2
 	help
@@ -17,7 +17,7 @@ config SOC_AR933X
 config SOC_AR934X
 	bool
 	select MIPS_TUNE_74KC
-	select SUPPORTS_BIG_ENDIAN
+	select SUPPORT_BIG_ENDIAN
 	select SUPPORTS_CPU_MIPS32_R1
 	select SUPPORTS_CPU_MIPS32_R2
 	select USB_EHCI_IS_TDI if USB_EHCI_HCD
@@ -28,7 +28,7 @@ config SOC_QCA953X
 	bool
 	select MIPS_TUNE_24KC
 	select ROM_EXCEPTION_VECTORS
-	select SUPPORTS_BIG_ENDIAN
+	select SUPPORT_BIG_ENDIAN
 	select SUPPORTS_CPU_MIPS32_R1
 	select SUPPORTS_CPU_MIPS32_R2
 	help
@@ -37,7 +37,7 @@ config SOC_QCA953X
 config SOC_QCA956X
 	bool
 	select MIPS_TUNE_74KC
-	select SUPPORTS_BIG_ENDIAN
+	select SUPPORT_BIG_ENDIAN
 	select SUPPORTS_CPU_MIPS32_R1
 	select SUPPORTS_CPU_MIPS32_R2
 	help
diff --git a/arch/mips/mach-bmips/Kconfig b/arch/mips/mach-bmips/Kconfig
index eb9ea34c52fe..b140552657ff 100644
--- a/arch/mips/mach-bmips/Kconfig
+++ b/arch/mips/mach-bmips/Kconfig
@@ -23,7 +23,7 @@ config SOC_BMIPS_BCM3380
 	bool "BMIPS BCM3380 family"
 	select SYS_CACHE_SHIFT_4
 	select MIPS_TUNE_4KC
-	select SUPPORTS_BIG_ENDIAN
+	select SUPPORT_BIG_ENDIAN
 	select SUPPORTS_CPU_MIPS32_R1
 	select SYSRESET_WATCHDOG
 	help
@@ -33,7 +33,7 @@ config SOC_BMIPS_BCM6318
 	bool "BMIPS BCM6318 family"
 	select SYS_CACHE_SHIFT_4
 	select MIPS_TUNE_4KC
-	select SUPPORTS_BIG_ENDIAN
+	select SUPPORT_BIG_ENDIAN
 	select SUPPORTS_CPU_MIPS32_R1
 	select SYSRESET_SYSCON
 	help
@@ -43,7 +43,7 @@ config SOC_BMIPS_BCM6328
 	bool "BMIPS BCM6328 family"
 	select SYS_CACHE_SHIFT_4
 	select MIPS_TUNE_4KC
-	select SUPPORTS_BIG_ENDIAN
+	select SUPPORT_BIG_ENDIAN
 	select SUPPORTS_CPU_MIPS32_R1
 	select SYSRESET_SYSCON
 	help
@@ -53,7 +53,7 @@ config SOC_BMIPS_BCM6338
 	bool "BMIPS BCM6338 family"
 	select SYS_CACHE_SHIFT_4
 	select MIPS_TUNE_4KC
-	select SUPPORTS_BIG_ENDIAN
+	select SUPPORT_BIG_ENDIAN
 	select SUPPORTS_CPU_MIPS32_R1
 	select SYSRESET_SYSCON
 	help
@@ -63,7 +63,7 @@ config SOC_BMIPS_BCM6348
 	bool "BMIPS BCM6348 family"
 	select SYS_CACHE_SHIFT_4
 	select MIPS_TUNE_4KC
-	select SUPPORTS_BIG_ENDIAN
+	select SUPPORT_BIG_ENDIAN
 	select SUPPORTS_CPU_MIPS32_R1
 	select SYSRESET_WATCHDOG
 	help
@@ -73,7 +73,7 @@ config SOC_BMIPS_BCM6358
 	bool "BMIPS BCM6358 family"
 	select SYS_CACHE_SHIFT_4
 	select MIPS_TUNE_4KC
-	select SUPPORTS_BIG_ENDIAN
+	select SUPPORT_BIG_ENDIAN
 	select SUPPORTS_CPU_MIPS32_R1
 	select SYSRESET_SYSCON
 	help
@@ -83,7 +83,7 @@ config SOC_BMIPS_BCM6368
 	bool "BMIPS BCM6368 family"
 	select SYS_CACHE_SHIFT_4
 	select MIPS_TUNE_4KC
-	select SUPPORTS_BIG_ENDIAN
+	select SUPPORT_BIG_ENDIAN
 	select SUPPORTS_CPU_MIPS32_R1
 	select SYSRESET_SYSCON
 	help
@@ -93,7 +93,7 @@ config SOC_BMIPS_BCM6362
 	bool "BMIPS BCM6362 family"
 	select SYS_CACHE_SHIFT_4
 	select MIPS_TUNE_4KC
-	select SUPPORTS_BIG_ENDIAN
+	select SUPPORT_BIG_ENDIAN
 	select SUPPORTS_CPU_MIPS32_R1
 	select SYSRESET_SYSCON
 	help
@@ -103,7 +103,7 @@ config SOC_BMIPS_BCM63268
 	bool "BMIPS BCM63268 family"
 	select SYS_CACHE_SHIFT_4
 	select MIPS_TUNE_4KC
-	select SUPPORTS_BIG_ENDIAN
+	select SUPPORT_BIG_ENDIAN
 	select SUPPORTS_CPU_MIPS32_R1
 	select SYSRESET_SYSCON
 	help
@@ -114,7 +114,7 @@ config SOC_BMIPS_BCM6838
 	bool "BMIPS BCM6838 family"
 	select SYS_CACHE_SHIFT_4
 	select MIPS_TUNE_4KC
-	select SUPPORTS_BIG_ENDIAN
+	select SUPPORT_BIG_ENDIAN
 	select SUPPORTS_CPU_MIPS32_R1
 	select SYSRESET_SYSCON
 	help
diff --git a/arch/mips/mach-jz47xx/Kconfig b/arch/mips/mach-jz47xx/Kconfig
index dcaac0162866..858173e75b40 100644
--- a/arch/mips/mach-jz47xx/Kconfig
+++ b/arch/mips/mach-jz47xx/Kconfig
@@ -6,7 +6,7 @@ config SYS_SOC
 
 config SOC_JZ4780
 	bool
-	select SUPPORTS_LITTLE_ENDIAN
+	select SUPPORT_LITTLE_ENDIAN
 	select SUPPORTS_CPU_MIPS32_R1
 	select SUPPORTS_CPU_MIPS32_R2
 	help
diff --git a/arch/mips/mach-mscc/Kconfig b/arch/mips/mach-mscc/Kconfig
index affc4721f82e..367d5248a1cc 100644
--- a/arch/mips/mach-mscc/Kconfig
+++ b/arch/mips/mach-mscc/Kconfig
@@ -6,10 +6,10 @@ menu "MSCC VCore-III platforms"
 config SOC_VCOREIII
 	select MIPS_TUNE_24KC
 	select ROM_EXCEPTION_VECTORS
-	select SUPPORTS_BIG_ENDIAN
+	select SUPPORT_BIG_ENDIAN
 	select SUPPORTS_CPU_MIPS32_R1
 	select SUPPORTS_CPU_MIPS32_R2
-	select SUPPORTS_LITTLE_ENDIAN
+	select SUPPORT_LITTLE_ENDIAN
 	bool
 
 config SYS_SOC
diff --git a/arch/mips/mach-pic32/Kconfig b/arch/mips/mach-pic32/Kconfig
index 2afa972074c1..52d2eec0a766 100644
--- a/arch/mips/mach-pic32/Kconfig
+++ b/arch/mips/mach-pic32/Kconfig
@@ -13,7 +13,7 @@ config SOC_PIC32MZDA
 	select ROM_EXCEPTION_VECTORS
 	select SUPPORTS_CPU_MIPS32_R1
 	select SUPPORTS_CPU_MIPS32_R2
-	select SUPPORTS_LITTLE_ENDIAN
+	select SUPPORT_LITTLE_ENDIAN
 	select SYS_MIPS_CACHE_INIT_RAM_LOAD
 	help
 	  This supports Microchip PIC32MZ[DA] family of microcontrollers.

-- 
2.45.2

