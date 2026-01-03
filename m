Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C42FC6174
	for <u-boot@archiver.kernel.org>; Sat,  3 Jan 2026 07:05:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BB2F83B97;
	Sat,  3 Jan 2026 08:05:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="krEgF9tF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 735AB83AEE; Sat,  3 Jan 2026 04:08:00 +0100 (CET)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A84B83AAB
 for <u-boot@lists.denx.de>; Sat,  3 Jan 2026 04:07:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mateuslima.ti@gmail.com
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-34c84ec3b6eso16052701a91.3
 for <u-boot@lists.denx.de>; Fri, 02 Jan 2026 19:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767409676; x=1768014476; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=L1DOvFj+uPgmXYmWuTmgGcM2R71Xwo3wO2/n+yGqnr4=;
 b=krEgF9tFBwgNopvWri8unPdNUaq5ego0Sw1tnICcPvPR+bVcaRoYn3l9Jv1mRKr99G
 ACRI1JUYlCBR1CoEgNiZTm73s08TL8mT25JWAP91U22FXBWkvN7oyC8SIMmO7G8p5fKQ
 J8Lgekvz27DHvahVJxPPv38b0YWtYIQy6kvJsU2vBaBgJqw0EK2EjPtBZ3TqooKu8wqQ
 DwReqgiiEcEIElrAop3N0p8SdhiMh5cxxKezFz+Hu8oD0h/Ek21F9wR0HDRl54Pwytnx
 G3XIQ95mFWXyoEK6fyw2hPj9dgfh7I60L3FM8RwwQFmvlI0RjoxEmZyaRVAK54SooQPd
 L6LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767409676; x=1768014476;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L1DOvFj+uPgmXYmWuTmgGcM2R71Xwo3wO2/n+yGqnr4=;
 b=YCP+cpZ5QZ+f/83JyyG0lKmnMIz/18ET+rlH9y8JM4dC7zNDBurbl19cms/rSSwOUD
 r44VHGUotR3nuxA75PajXcBYW+DER/0mNZYxZgFLHUsHACy37aYrTYRBMH8oZutOEQhv
 WAhZpMlHgYH5iuU2Ft8SrIyP/I0n5pl8PDt1vX4tGRzh1s2r/KuA4Io6ccsGBfL0skxK
 XcxfL5D8YiUIdvM0SwRuUcpUodsogeQV0ktQ+iLqPqOknCekpd1s/ismcfPfhowqnzAS
 wkugyG+Wa2L6vywMO8y1eS4mBSuetGPACRB0F4IuMF6G5yKW2fPCXq3JSowlPMho5EyK
 Tgkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzQ3auwoR9KJk1K9S6ZE323YmoXzI4cFlk4nQcBm7XdgxOWcZC0zNwtJQCUdr+bV1tQFQPb78=@lists.denx.de
X-Gm-Message-State: AOJu0YwrEIzTkJ4XvFpKOXJ3rN10gv2KVchegR1GB5FArYZgDDEGcWuO
 7zUEgZXhI2Bm7j3ae6N0j4pyR50AYLN2G3fmNO2orsicOyGiCoTMkCGP
X-Gm-Gg: AY/fxX7l0BC/U2qW6eTHo1F7UAlFjCgSKqcw2equcGgODIxhmlJBWigZ5aElx2pMDLT
 /okmGaUW7QaQyEuXgLJOBX3OCAgNAH6cPvejjxwg2PmMYvOLvguSFp8+XSw453yHcTGKGXXNWfg
 m9AJ3FqUklofpI3sABiLxzkzpyaY19fKZWNtNqWpgS7mxmEDmhUPAE5vflUw+0BTmy7R4UAsVvR
 8UPN3RR4x1q85bBD+BaqseN72Dsl9KuXLHMoC6wFwb3KsoZXmYuMk303lbqSjX1WSgXWxeN/Wz2
 E2qm4DCgqIv7u26EVhJpDa3dd6dY14FBa0r9oOge+AboWbDu9zwQTXcSAuEWjOR0AwpRpJTuA17
 JeQbJInLlru4AVpGKw55nsp4WlmXULYg0xfIeFW2Wx4upAepG6WB3kILdlLPg6cGTZayLu5kchu
 f8IOBlnRwjZ5NCIE6+DsSaoK7rhrA7Ew==
X-Google-Smtp-Source: AGHT+IG28+8yCQX+N1mZdyB+z3L5VsIrATLuCyT3661QL43DmDCw/rZ17ESQwdk+7tFT7f66fLZGug==
X-Received: by 2002:a05:7022:82:b0:11a:126f:ee7d with SMTP id
 a92af1059eb24-121722f57bamr27390840c88.35.1767409675937; 
 Fri, 02 Jan 2026 19:07:55 -0800 (PST)
Received: from localhost.localdomain ([131.221.227.178])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b140c42eb9sm2984319eec.21.2026.01.02.19.07.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jan 2026 19:07:55 -0800 (PST)
From: Mateus Lima Alves <mateuslima.ti@gmail.com>
To: alison.wang@nxp.com
Cc: Mateus Lima Alves <mateuslima.ti@gmail.com>,
	u-boot@lists.denx.de
Subject: [PATCH] armv7: Add CPLD support via IFC to the ls1021a-iot board.
Date: Sat,  3 Jan 2026 00:07:21 -0300
Message-ID: <20260103030728.334736-1-mateuslima.ti@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 03 Jan 2026 08:05:36 +0100
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

This patch adds CPLD support via IFC to the ls1021a-iot board.

Signed-off-by: Mateus Lima Alves <mateuslima.ti@gmail.com>
---
 board/freescale/ls1021aiot/ls1021aiot.c |  5 ++++
 configs/ls1021aiot_sdcard_defconfig     |  2 +-
 drivers/misc/Kconfig                    |  6 ++++-
 include/configs/ls1021aiot.h            | 34 +++++++++++++++++++++++++
 4 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/board/freescale/ls1021aiot/ls1021aiot.c b/board/freescale/ls1021aiot/ls1021aiot.c
index 4eff0a3fee0..52a3c3abdb4 100644
--- a/board/freescale/ls1021aiot/ls1021aiot.c
+++ b/board/freescale/ls1021aiot/ls1021aiot.c
@@ -21,6 +21,7 @@
 #include <asm/sections.h>
 #include <fsl_csu.h>
 #include <fsl_immap.h>
+#include <fsl_ifc.h>
 #include <netdev.h>
 #include <fsl_mdio.h>
 #include <tsec.h>
@@ -120,6 +121,10 @@ int board_early_init_f(void)
 
 #endif
 
+#ifdef CONFIG_FSL_IFC
+	init_early_memctl_regs();
+#endif
+
 	arch_soc_init();
 
 	return 0;
diff --git a/configs/ls1021aiot_sdcard_defconfig b/configs/ls1021aiot_sdcard_defconfig
index 6b32150e408..450b46a6f1d 100644
--- a/configs/ls1021aiot_sdcard_defconfig
+++ b/configs/ls1021aiot_sdcard_defconfig
@@ -63,7 +63,6 @@ CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_DHCP=y
-CONFIG_CMD_MII=y
 # CONFIG_CMD_MDIO is not set
 CONFIG_CMD_PING=y
 CONFIG_CMD_EXT2=y
@@ -106,3 +105,4 @@ CONFIG_FSL_QSPI=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
+CONFIG_FSL_IFC=y
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index dde773ab6b1..229a50f266f 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -694,7 +694,11 @@ config ESM_PMIC
 	  typically to reboot the board in error condition.
 
 config FSL_IFC
-	bool
+	bool "Freescale Integrated Flash Controller"
+	help
+	  This driver is for the Integrated Flash Controller(IFC) module
+	  available in Freescale SoCs. This controller allows to handle
+	  devices such as NOR, NAND, FPGA and ASIC etc.
 
 config SL28CPLD
 	bool "Enable Kontron sl28cpld multi-function driver"
diff --git a/include/configs/ls1021aiot.h b/include/configs/ls1021aiot.h
index 971a393817a..66beff10002 100644
--- a/include/configs/ls1021aiot.h
+++ b/include/configs/ls1021aiot.h
@@ -44,6 +44,40 @@
 #define CFG_SYS_DDR_SDRAM_BASE	0x80000000UL
 #define CFG_SYS_SDRAM_BASE		CFG_SYS_DDR_SDRAM_BASE
 
+/* CPLD */
+
+#define CFG_SYS_CPLD_BASE		0x7fb00000
+#define CPLD_BASE_PHYS			CFG_SYS_CPLD_BASE
+
+#define CFG_SYS_FPGA_CSPR_EXT	(0x0)
+#define CFG_SYS_FPGA_CSPR		(CSPR_PHYS_ADDR(CPLD_BASE_PHYS) | \
+								 CSPR_PORT_SIZE_8 | \
+								 CSPR_MSEL_GPCM | \
+								 CSPR_V)
+#define CFG_SYS_FPGA_AMASK		IFC_AMASK(64 * 1024)
+#define CFG_SYS_FPGA_CSOR		(CSOR_NOR_ADM_SHIFT(4) | \
+								 CSOR_NOR_NOR_MODE_AVD_NOR | \
+								 CSOR_NOR_TRHZ_80)
+
+/* CPLD Timing parameters for IFC GPCM */
+#define CFG_SYS_FPGA_FTIM0		(FTIM0_GPCM_TACSE(0xf) | \
+								 FTIM0_GPCM_TEADC(0xf) | \
+								 FTIM0_GPCM_TEAHC(0xf))
+#define CFG_SYS_FPGA_FTIM1		(FTIM1_GPCM_TACO(0xff) | \
+								 FTIM1_GPCM_TRAD(0x3f))
+#define CFG_SYS_FPGA_FTIM2		(FTIM2_GPCM_TCS(0xf) | \
+								 FTIM2_GPCM_TCH(0xf) | \
+								 FTIM2_GPCM_TWP(0xff))
+#define CFG_SYS_FPGA_FTIM3		0x0
+#define CFG_SYS_CSPR0_EXT		CFG_SYS_FPGA_CSPR_EXT
+#define CFG_SYS_CSPR0			CFG_SYS_FPGA_CSPR
+#define CFG_SYS_AMASK0			CFG_SYS_FPGA_AMASK
+#define CFG_SYS_CSOR0			CFG_SYS_FPGA_CSOR
+#define CFG_SYS_CS0_FTIM0		CFG_SYS_FPGA_FTIM0
+#define CFG_SYS_CS0_FTIM1		CFG_SYS_FPGA_FTIM1
+#define CFG_SYS_CS0_FTIM2		CFG_SYS_FPGA_FTIM2
+#define CFG_SYS_CS0_FTIM3		CFG_SYS_FPGA_FTIM3
+
 /*
  * Serial Port
  */
-- 
2.43.0

