Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF67CC27C53
	for <u-boot@archiver.kernel.org>; Sun, 16 Jun 2024 15:20:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4A5B87CDA;
	Sun, 16 Jun 2024 17:20:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="dukrKKsi";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="rwBnnabR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D0F588113; Sun, 16 Jun 2024 17:20:02 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 496B2880DB
 for <u-boot@lists.denx.de>; Sun, 16 Jun 2024 17:19:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4W2GsV6tWBz9sRJ;
 Sun, 16 Jun 2024 17:19:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1718551198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=EoA0o57gLm63k6WSTnOlS2d47QXt9gllRhQLdYz9mS4=;
 b=dukrKKsi40r2hYDLz6rGqqvwfOXrDOfGEuVGAicdIymyW2YIRfjP5aL8dpa0bSErr0fmrU
 EQtUg+IVTM1DCCATsgHuf9wh+anw+9QHVE7CH4MNB2v/ophVR5C+NVI2YkLXbzmDegt9Ll
 1OlbkvpQDswzMRL5NGrxeQosQ6CdozLmrfMJH1dF+rXUSkUcSZVjHZWgJtblXlbr6QZqR6
 TmTCujgkKTkxM3+44Wvzf2/Wupyr5SEDKgbfhZjQK+1SrdmMU4mVw4/55eFUBilOAqYEZ9
 POC/Jm/shC2zuZsCpCcSZVTvJKzYZeaigVlB+b1L4OQFYRcgPiGlz8EQnIjPyQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1718551197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=EoA0o57gLm63k6WSTnOlS2d47QXt9gllRhQLdYz9mS4=;
 b=rwBnnabR4zIZTQcrLnvUv7/LNosmPc6IiiwD6GeX5q8clZp1CR/knLePdPVvpj743GbyX/
 JX6cFIwRLsKYQA6ivNrkOh0Ye9HrkYFEnTBiP1vtvtAO+3eiLtO1GF1oyvTouhxnsjq8ab
 6yt6Fp3S0+H0sjBy7MhXMSc1qPjZX8JknseIga+WL2y/TzhyFLphAlOrP9Fymf49a5IxuI
 Z0P6yW5RT5EIull64/swl0LV3ze1/avm4APfIrKc/7X/6h3vn85AtFXpZ/tp6vHxoQr3B/
 Dgg2ODbCs6+GK5Rx8ZUQbu9DtuGiKkDMVyTYufxLbBDYU7i+6/czc11JVtz1xA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] configs: Remove duplicate newlines
Date: Sun, 16 Jun 2024 17:19:11 +0200
Message-ID: <20240616151940.37802-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: q5b1crm8sfkwn3xi44darhsro4tuiooz
X-MBO-RS-ID: 34caf36dd9e6b568782
X-Rspamd-Queue-Id: 4W2GsV6tWBz9sRJ
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

Drop all duplicate newlines from config headers.
No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 include/configs/M5208EVBE.h            | 1 -
 include/configs/M5235EVB.h             | 1 -
 include/configs/M5249EVB.h             | 1 -
 include/configs/M5253DEMO.h            | 2 --
 include/configs/M5272C3.h              | 1 -
 include/configs/M5275EVB.h             | 1 -
 include/configs/M5282EVB.h             | 1 -
 include/configs/M53017EVB.h            | 1 -
 include/configs/M5329EVB.h             | 1 -
 include/configs/M5373EVB.h             | 1 -
 include/configs/MPC837XERDB.h          | 1 -
 include/configs/P2041RDB.h             | 1 -
 include/configs/T4240RDB.h             | 1 -
 include/configs/arbel.h                | 1 -
 include/configs/aristainetos2.h        | 1 -
 include/configs/astro_mcf5373l.h       | 1 -
 include/configs/cobra5272.h            | 1 -
 include/configs/display5.h             | 1 -
 include/configs/ds414.h                | 1 -
 include/configs/eb_cpu5282.h           | 1 -
 include/configs/ethernut5.h            | 1 -
 include/configs/ge_bx50v3.h            | 1 -
 include/configs/imx6_logic.h           | 1 -
 include/configs/imx7-cm.h              | 1 -
 include/configs/imx8mm-cl-iot-gate.h   | 1 -
 include/configs/imx8mm_evk.h           | 1 -
 include/configs/imx8mn_evk.h           | 1 -
 include/configs/imx8mp_evk.h           | 1 -
 include/configs/imx8mp_rsb3720.h       | 1 -
 include/configs/imx8mq_cm.h            | 1 -
 include/configs/imx8mq_evk.h           | 1 -
 include/configs/imx8mq_phanbell.h      | 1 -
 include/configs/imx8mq_reform2.h       | 1 -
 include/configs/imx8ulp_evk.h          | 2 --
 include/configs/j721e_evm.h            | 1 -
 include/configs/kontron_pitx_imx8m.h   | 2 --
 include/configs/ls1012aqds.h           | 1 -
 include/configs/ls1043a_common.h       | 1 -
 include/configs/ls1088a_common.h       | 3 ---
 include/configs/ls1088aqds.h           | 1 -
 include/configs/ls1088ardb.h           | 1 -
 include/configs/lx2160a_common.h       | 1 -
 include/configs/meson64.h              | 1 -
 include/configs/mt8183.h               | 1 -
 include/configs/mt8516.h               | 1 -
 include/configs/mx53cx9020.h           | 1 -
 include/configs/mx6ullevk.h            | 1 -
 include/configs/mx7ulp_evk.h           | 1 -
 include/configs/phycore_imx8mm.h       | 1 -
 include/configs/phycore_imx8mp.h       | 1 -
 include/configs/pico-imx6ul.h          | 1 -
 include/configs/pico-imx8mq.h          | 1 -
 include/configs/sei510.h               | 1 -
 include/configs/siemens-am33x-common.h | 1 -
 include/configs/socrates.h             | 1 -
 include/configs/stm32mp15_dh_dhsom.h   | 1 -
 include/configs/stmark2.h              | 1 -
 include/configs/ten64.h                | 1 -
 include/configs/topic_miami.h          | 1 -
 include/configs/warp7.h                | 1 -
 include/configs/x86-common.h           | 1 -
 include/configs/xtfpga.h               | 1 -
 include/configs/zynq-common.h          | 1 -
 63 files changed, 68 deletions(-)

diff --git a/include/configs/M5208EVBE.h b/include/configs/M5208EVBE.h
index d4c1e066884..a4fda551f1f 100644
--- a/include/configs/M5208EVBE.h
+++ b/include/configs/M5208EVBE.h
@@ -111,5 +111,4 @@
 #define CFG_SYS_CS0_MASK		0x007F0001
 #define CFG_SYS_CS0_CTRL		0x00001FA0
 
-
 #endif				/* _M5208EVBE_H */
diff --git a/include/configs/M5235EVB.h b/include/configs/M5235EVB.h
index e5428183400..8939c8e7ab9 100644
--- a/include/configs/M5235EVB.h
+++ b/include/configs/M5235EVB.h
@@ -130,5 +130,4 @@
 #	define CFG_SYS_CS0_CTRL	0x00001D80
 #endif
 
-
 #endif				/* _M5329EVB_H */
diff --git a/include/configs/M5249EVB.h b/include/configs/M5249EVB.h
index 2f4743ce50c..4fd539c0174 100644
--- a/include/configs/M5249EVB.h
+++ b/include/configs/M5249EVB.h
@@ -120,5 +120,4 @@
 #define	CFG_SYS_GPIO1_OUT		0x00c70000	/* Set outputs to default state */
 #define CFG_SYS_GPIO1_LED		0x00400000	/* user led                     */
 
-
 #endif	/* M5249 */
diff --git a/include/configs/M5253DEMO.h b/include/configs/M5253DEMO.h
index 0ff0bfce90b..75c70be7ac4 100644
--- a/include/configs/M5253DEMO.h
+++ b/include/configs/M5253DEMO.h
@@ -10,7 +10,6 @@
 
 #define CFG_SYS_UART_PORT		(0)
 
-
 /* Configuration for environment
  * Environment is embedded in u-boot in the second sector of the flash
  */
@@ -132,5 +131,4 @@
 #define CFG_SYS_GPIO1_OUT		0x00c70000	/* Set outputs to default state */
 #define CFG_SYS_GPIO1_LED		0x00400000	/* user led */
 
-
 #endif				/* _M5253DEMO_H */
diff --git a/include/configs/M5272C3.h b/include/configs/M5272C3.h
index 98a17181a41..0d332cba61c 100644
--- a/include/configs/M5272C3.h
+++ b/include/configs/M5272C3.h
@@ -107,5 +107,4 @@
 #define CFG_SYS_PBDAT		0x0000
 #define CFG_SYS_PDCNT		0x00000000
 
-
 #endif				/* _M5272C3_H */
diff --git a/include/configs/M5275EVB.h b/include/configs/M5275EVB.h
index 77ddf717643..607c5dee2fb 100644
--- a/include/configs/M5275EVB.h
+++ b/include/configs/M5275EVB.h
@@ -116,5 +116,4 @@
 #define CFG_SYS_CS1_CTRL		0x00001900
 #define CFG_SYS_CS1_MASK		0x00070001
 
-
 #endif	/* _M5275EVB_H */
diff --git a/include/configs/M5282EVB.h b/include/configs/M5282EVB.h
index e289a23b800..31699a40b6f 100644
--- a/include/configs/M5282EVB.h
+++ b/include/configs/M5282EVB.h
@@ -127,5 +127,4 @@
 #define CFG_SYS_DDRUA		0x05
 #define CFG_SYS_PJPAR		0xFF
 
-
 #endif				/* _CONFIG_M5282EVB_H */
diff --git a/include/configs/M53017EVB.h b/include/configs/M53017EVB.h
index dcc5701ee0b..6359915e09a 100644
--- a/include/configs/M53017EVB.h
+++ b/include/configs/M53017EVB.h
@@ -132,5 +132,4 @@
 #define CFG_SYS_CS1_MASK		0x00070001
 #define CFG_SYS_CS1_CTRL		0x00001FA0
 
-
 #endif				/* _M53017EVB_H */
diff --git a/include/configs/M5329EVB.h b/include/configs/M5329EVB.h
index dd5d4c98023..456135bdc64 100644
--- a/include/configs/M5329EVB.h
+++ b/include/configs/M5329EVB.h
@@ -138,5 +138,4 @@
 #define CFG_SYS_CS2_CTRL		0x00001f60
 #endif
 
-
 #endif				/* _M5329EVB_H */
diff --git a/include/configs/M5373EVB.h b/include/configs/M5373EVB.h
index 4bb99487509..4e8dcb5ef7f 100644
--- a/include/configs/M5373EVB.h
+++ b/include/configs/M5373EVB.h
@@ -136,5 +136,4 @@
 #define CFG_SYS_CS2_MASK		(16 << 20)
 #define CFG_SYS_CS2_CTRL		0x00001f60
 
-
 #endif				/* _M5373EVB_H */
diff --git a/include/configs/MPC837XERDB.h b/include/configs/MPC837XERDB.h
index 3967cc28363..a5176d176dc 100644
--- a/include/configs/MPC837XERDB.h
+++ b/include/configs/MPC837XERDB.h
@@ -132,7 +132,6 @@
  */
 #define CFG_SYS_NAND_BASE	0xE0600000
 
-
 /* Vitesse 7385 */
 
 #define CFG_SYS_VSC7385_BASE	0xF0000000
diff --git a/include/configs/P2041RDB.h b/include/configs/P2041RDB.h
index 28f53ae78a1..7cf6514f148 100644
--- a/include/configs/P2041RDB.h
+++ b/include/configs/P2041RDB.h
@@ -160,7 +160,6 @@
 
 /* I2C */
 
-
 /*
  * RapidIO
  */
diff --git a/include/configs/T4240RDB.h b/include/configs/T4240RDB.h
index 78e136224ec..c95325e162d 100644
--- a/include/configs/T4240RDB.h
+++ b/include/configs/T4240RDB.h
@@ -355,7 +355,6 @@
 #define CFG_SYS_FSL_ESDHC_ADDR       CFG_SYS_MPC85xx_ESDHC_ADDR
 #endif
 
-
 #define __USB_PHY_TYPE	utmi
 
 /*
diff --git a/include/configs/arbel.h b/include/configs/arbel.h
index d8ccc459682..61f6a5e2438 100644
--- a/include/configs/arbel.h
+++ b/include/configs/arbel.h
@@ -15,7 +15,6 @@
 #define CFG_SYS_BAUDRATE_TABLE	\
 	{ 9600, 14400, 19200, 38400, 57600, 115200, 230400, 380400, 460800, 921600 }
 
-
 /* Default environemnt variables */
 #define CFG_EXTRA_ENV_SETTINGS   "uimage_flash_addr=80400000\0"   \
 		"stdin=serial\0"   \
diff --git a/include/configs/aristainetos2.h b/include/configs/aristainetos2.h
index 286435d6f84..9d4a4bbdf43 100644
--- a/include/configs/aristainetos2.h
+++ b/include/configs/aristainetos2.h
@@ -22,7 +22,6 @@
 
 #include "mx6_common.h"
 
-
 /* MMC Configs */
 #define CFG_SYS_FSL_ESDHC_ADDR      USDHC1_BASE_ADDR
 
diff --git a/include/configs/astro_mcf5373l.h b/include/configs/astro_mcf5373l.h
index f3bfefa835e..65224324fbc 100644
--- a/include/configs/astro_mcf5373l.h
+++ b/include/configs/astro_mcf5373l.h
@@ -184,5 +184,4 @@
 #define CFG_SYS_CACHE_ICACR		(CF_CACR_EC | CF_CACR_CINVA | \
 					 CF_CACR_DCM_P)
 
-
 #endif	/* _CONFIG_ASTRO_MCF5373L_H */
diff --git a/include/configs/cobra5272.h b/include/configs/cobra5272.h
index 556705fb09f..cd50ffe98d0 100644
--- a/include/configs/cobra5272.h
+++ b/include/configs/cobra5272.h
@@ -184,5 +184,4 @@ configuration */
 #define CFG_SYS_PBDAT		0x0000			/* PortB value reg. */
 #define CFG_SYS_PDCNT		0x00000000		/* PortD control reg. */
 
-
 #endif	/* _CONFIG_COBRA5272_H */
diff --git a/include/configs/display5.h b/include/configs/display5.h
index 3b96fff7d6f..2005a256d6e 100644
--- a/include/configs/display5.h
+++ b/include/configs/display5.h
@@ -119,7 +119,6 @@
 	"run tftp_mmc_rootfs;" \
 	"run tftp_mmc_rootfs_bkp;" \
 
-
 #define TFTP_UPDATE_RECOVERY_SWU_KERNEL \
 	"tftp_sf_fitImg_SWU=" \
 	    "if tftp ${loadaddr} ${kernel_file}; then " \
diff --git a/include/configs/ds414.h b/include/configs/ds414.h
index f1921dac5e7..6fbcec0898a 100644
--- a/include/configs/ds414.h
+++ b/include/configs/ds414.h
@@ -53,7 +53,6 @@
 		"tftpboot ${loadaddr} u-boot-with-spl.kwb; "	\
 		"sf update ${loadaddr} 0x0 0xd0000\0"
 
-
 /* increase autoneg timeout, my NIC sucks */
 
 #endif /* _CONFIG_SYNOLOGY_DS414_H */
diff --git a/include/configs/eb_cpu5282.h b/include/configs/eb_cpu5282.h
index e2c9d9c43ce..26e4ade34ee 100644
--- a/include/configs/eb_cpu5282.h
+++ b/include/configs/eb_cpu5282.h
@@ -138,6 +138,5 @@
 #define CFG_SYS_DDRUA		0x05
 #define CFG_SYS_PJPAR		0xFF
 
-
 #endif	/* _CONFIG_M5282EVB_H */
 /*---------------------------------------------------------------------*/
diff --git a/include/configs/ethernut5.h b/include/configs/ethernut5.h
index 182369def91..807c6963192 100644
--- a/include/configs/ethernut5.h
+++ b/include/configs/ethernut5.h
@@ -32,7 +32,6 @@
 /* 512kB on-chip NOR flash */
 # define CFG_SYS_FLASH_BASE		0x00200000 /* AT91SAM9XE_FLASH_BASE */
 
-
 /* bootstrap + u-boot + env + linux in dataflash on CS0 */
 
 /* NAND flash */
diff --git a/include/configs/ge_bx50v3.h b/include/configs/ge_bx50v3.h
index 32960fb9325..07b36706e56 100644
--- a/include/configs/ge_bx50v3.h
+++ b/include/configs/ge_bx50v3.h
@@ -88,7 +88,6 @@
 		"run doboot; " \
 		"run failbootcmd\0" \
 
-
 /* Physical Memory Map */
 #define PHYS_SDRAM                     MMDC0_ARB_BASE_ADDR
 
diff --git a/include/configs/imx6_logic.h b/include/configs/imx6_logic.h
index 85c054451f3..66004a6eb2a 100644
--- a/include/configs/imx6_logic.h
+++ b/include/configs/imx6_logic.h
@@ -17,7 +17,6 @@
 #define CFG_SYS_FSL_ESDHC_ADDR      0
 #define CFG_SYS_FSL_USDHC_NUM       2
 
-
 /* Ethernet Configs */
 #define CFG_FEC_MXC_PHYADDR         0
 
diff --git a/include/configs/imx7-cm.h b/include/configs/imx7-cm.h
index 106fbdb9053..131f18290b9 100644
--- a/include/configs/imx7-cm.h
+++ b/include/configs/imx7-cm.h
@@ -77,7 +77,6 @@
 #define CFG_SYS_FSL_ESDHC_ADDR       USDHC1_BASE_ADDR
 #define CFG_SYS_FSL_USDHC_NUM		2
 
-
 /* USB Configs */
 #define CFG_MXC_USB_PORTSC  (PORT_PTS_UTMI | PORT_PTS_PTW)
 
diff --git a/include/configs/imx8mm-cl-iot-gate.h b/include/configs/imx8mm-cl-iot-gate.h
index 0c547027ba6..6442e3d570f 100644
--- a/include/configs/imx8mm-cl-iot-gate.h
+++ b/include/configs/imx8mm-cl-iot-gate.h
@@ -126,7 +126,6 @@
 #define CFG_SYS_INIT_RAM_ADDR	0x40000000
 #define CFG_SYS_INIT_RAM_SIZE	0x80000
 
-
 #define CFG_SYS_SDRAM_BASE		0x40000000
 #define PHYS_SDRAM			0x40000000
 #define PHYS_SDRAM_SIZE			0x80000000 /* 2GB DDR */
diff --git a/include/configs/imx8mm_evk.h b/include/configs/imx8mm_evk.h
index d5642b96495..9dd63fc1196 100644
--- a/include/configs/imx8mm_evk.h
+++ b/include/configs/imx8mm_evk.h
@@ -56,7 +56,6 @@
 #define CFG_SYS_INIT_RAM_ADDR        0x40000000
 #define CFG_SYS_INIT_RAM_SIZE        0x200000
 
-
 #define CFG_SYS_SDRAM_BASE           0x40000000
 #define PHYS_SDRAM                      0x40000000
 #define PHYS_SDRAM_SIZE			0x80000000 /* 2GB DDR */
diff --git a/include/configs/imx8mn_evk.h b/include/configs/imx8mn_evk.h
index b759b834b80..ca02e26c26e 100644
--- a/include/configs/imx8mn_evk.h
+++ b/include/configs/imx8mn_evk.h
@@ -48,7 +48,6 @@
 #define CFG_SYS_INIT_RAM_ADDR        0x40000000
 #define CFG_SYS_INIT_RAM_SIZE        0x200000
 
-
 #define CFG_SYS_SDRAM_BASE           0x40000000
 #define PHYS_SDRAM                      0x40000000
 #define PHYS_SDRAM_SIZE			0x80000000 /* 2GB DDR */
diff --git a/include/configs/imx8mp_evk.h b/include/configs/imx8mp_evk.h
index 71452aa2833..741ee39db1a 100644
--- a/include/configs/imx8mp_evk.h
+++ b/include/configs/imx8mp_evk.h
@@ -43,7 +43,6 @@
 #define CFG_SYS_INIT_RAM_ADDR	0x40000000
 #define CFG_SYS_INIT_RAM_SIZE	0x80000
 
-
 /* Totally 6GB DDR */
 #define CFG_SYS_SDRAM_BASE		0x40000000
 #define PHYS_SDRAM			0x40000000
diff --git a/include/configs/imx8mp_rsb3720.h b/include/configs/imx8mp_rsb3720.h
index 10a166d781e..b82e35f4963 100644
--- a/include/configs/imx8mp_rsb3720.h
+++ b/include/configs/imx8mp_rsb3720.h
@@ -126,7 +126,6 @@
 #define CFG_SYS_INIT_RAM_ADDR	0x40000000
 #define CFG_SYS_INIT_RAM_SIZE	0x80000
 
-
 /* Totally 6GB or 4G DDR */
 #define CFG_SYS_SDRAM_BASE		0x40000000
 #define PHYS_SDRAM			0x40000000
diff --git a/include/configs/imx8mq_cm.h b/include/configs/imx8mq_cm.h
index 7cf482d6de1..2bbd6b1680f 100644
--- a/include/configs/imx8mq_cm.h
+++ b/include/configs/imx8mq_cm.h
@@ -48,7 +48,6 @@
 #define CFG_SYS_INIT_RAM_ADDR        0x40000000
 #define CFG_SYS_INIT_RAM_SIZE        0x80000
 
-
 #define CFG_SYS_SDRAM_BASE           0x40000000
 #define PHYS_SDRAM                      0x40000000
 #define PHYS_SDRAM_SIZE					0x40000000 /* 1 GB DDR */
diff --git a/include/configs/imx8mq_evk.h b/include/configs/imx8mq_evk.h
index d2e1649400a..9eefc31dc6f 100644
--- a/include/configs/imx8mq_evk.h
+++ b/include/configs/imx8mq_evk.h
@@ -53,7 +53,6 @@
 #define CFG_SYS_INIT_RAM_ADDR        0x40000000
 #define CFG_SYS_INIT_RAM_SIZE        0x80000
 
-
 #define CFG_SYS_SDRAM_BASE           0x40000000
 #define PHYS_SDRAM                      0x40000000
 #define PHYS_SDRAM_SIZE			0xC0000000 /* 3GB DDR */
diff --git a/include/configs/imx8mq_phanbell.h b/include/configs/imx8mq_phanbell.h
index b66fc18fa5e..cd73a72d2b7 100644
--- a/include/configs/imx8mq_phanbell.h
+++ b/include/configs/imx8mq_phanbell.h
@@ -86,7 +86,6 @@
 #define CFG_SYS_INIT_RAM_ADDR        0x40000000
 #define CFG_SYS_INIT_RAM_SIZE        0x80000
 
-
 #define CFG_SYS_SDRAM_BASE           0x40000000
 #define PHYS_SDRAM                      0x40000000
 #define PHYS_SDRAM_SIZE			0x40000000 /* 1GB DDR */
diff --git a/include/configs/imx8mq_reform2.h b/include/configs/imx8mq_reform2.h
index 3148e8622e1..7fa441a8a83 100644
--- a/include/configs/imx8mq_reform2.h
+++ b/include/configs/imx8mq_reform2.h
@@ -54,7 +54,6 @@
 #define CFG_SYS_INIT_RAM_ADDR		0x40000000
 #define CFG_SYS_INIT_RAM_SIZE		0x80000
 
-
 #define CFG_SYS_SDRAM_BASE		0x40000000
 #define PHYS_SDRAM			0x40000000
 #define PHYS_SDRAM_SIZE			0x100000000	/* 4 GiB DDR */
diff --git a/include/configs/imx8ulp_evk.h b/include/configs/imx8ulp_evk.h
index 750aef1b597..aa9da19a11f 100644
--- a/include/configs/imx8ulp_evk.h
+++ b/include/configs/imx8ulp_evk.h
@@ -14,7 +14,6 @@
 #ifdef CONFIG_SPL_BUILD
 #define CFG_MALLOC_F_ADDR		0x22040000
 
-
 #endif
 
 /* ENET Config */
@@ -51,7 +50,6 @@
 #define CFG_SYS_INIT_RAM_ADDR	0x80000000
 #define CFG_SYS_INIT_RAM_SIZE	0x80000
 
-
 #define CFG_SYS_SDRAM_BASE		0x80000000
 #define PHYS_SDRAM			0x80000000
 #define PHYS_SDRAM_SIZE			0x80000000 /* 2GB DDR */
diff --git a/include/configs/j721e_evm.h b/include/configs/j721e_evm.h
index c26438c8684..d6853cd339f 100644
--- a/include/configs/j721e_evm.h
+++ b/include/configs/j721e_evm.h
@@ -25,5 +25,4 @@
 /* Now for the remaining common defines */
 #include <configs/ti_armv7_common.h>
 
-
 #endif /* __CONFIG_J721E_EVM_H */
diff --git a/include/configs/kontron_pitx_imx8m.h b/include/configs/kontron_pitx_imx8m.h
index 101c59141f7..3dda7b66806 100644
--- a/include/configs/kontron_pitx_imx8m.h
+++ b/include/configs/kontron_pitx_imx8m.h
@@ -18,7 +18,6 @@
 #define CFG_MALLOC_F_ADDR		0x182000
 /* For RAW image gives a error info not panic */
 
-
 #define CFG_POWER_PFUZE100_I2C_ADDR  0x08
 #endif
 
@@ -56,7 +55,6 @@
 	ENV_MEM_LAYOUT_SETTINGS \
 	BOOTENV
 
-
 #define CFG_SYS_INIT_RAM_ADDR        0x40000000
 #define CFG_SYS_INIT_RAM_SIZE        0x80000
 
diff --git a/include/configs/ls1012aqds.h b/include/configs/ls1012aqds.h
index 35e8ff05798..3c4f8b75b18 100644
--- a/include/configs/ls1012aqds.h
+++ b/include/configs/ls1012aqds.h
@@ -48,7 +48,6 @@
 */
 #define CFG_SYS_I2C_RTC_ADDR         0x51  /* Channel 3*/
 
-
 /* Voltage monitor on channel 2*/
 #define I2C_VOL_MONITOR_ADDR           0x40
 #define I2C_VOL_MONITOR_BUS_V_OFFSET   0x2
diff --git a/include/configs/ls1043a_common.h b/include/configs/ls1043a_common.h
index ac2319c1b42..e500a7d80ff 100644
--- a/include/configs/ls1043a_common.h
+++ b/include/configs/ls1043a_common.h
@@ -159,7 +159,6 @@
 		" && esbc_validate ${kernelheader_addr_r};"	\
 		"bootm $load_addr#$board\0"
 
-
 #ifdef CONFIG_TFABOOT
 #define QSPI_NOR_BOOTCOMMAND "run distro_bootcmd; run qspi_bootcmd; "	\
 			   "env exists secureboot && esbc_halt;"
diff --git a/include/configs/ls1088a_common.h b/include/configs/ls1088a_common.h
index 720a95d2f53..34085eeecc7 100644
--- a/include/configs/ls1088a_common.h
+++ b/include/configs/ls1088a_common.h
@@ -42,7 +42,6 @@
 
 /* I2C */
 
-
 /* Serial Port */
 #define CFG_SYS_NS16550_CLK          (get_bus_freq(0) / 2)
 
@@ -84,11 +83,9 @@ unsigned long long get_qixis_addr(void);
 #define QIXIS_BASE_PHYS				0x20000000
 #define QIXIS_BASE_PHYS_EARLY			0xC000000
 
-
 #define CFG_SYS_NAND_BASE			0x530000000ULL
 #define CFG_SYS_NAND_BASE_PHYS		0x30000000
 
-
 /* MC firmware */
 /* TODO Actual DPL max length needs to be confirmed with the MC FW team */
 #define CFG_SYS_LS_MC_DPC_MAX_LENGTH	    0x20000
diff --git a/include/configs/ls1088aqds.h b/include/configs/ls1088aqds.h
index 084ee064ae6..36e8422c34d 100644
--- a/include/configs/ls1088aqds.h
+++ b/include/configs/ls1088aqds.h
@@ -16,7 +16,6 @@
 
 #define SPD_EEPROM_ADDRESS		0x51
 
-
 /*
  * IFC Definitions
  */
diff --git a/include/configs/ls1088ardb.h b/include/configs/ls1088ardb.h
index a1749149e50..8be5febe57b 100644
--- a/include/configs/ls1088ardb.h
+++ b/include/configs/ls1088ardb.h
@@ -17,7 +17,6 @@
 
 #define SPD_EEPROM_ADDRESS	0x51
 
-
 #if !defined(CONFIG_QSPI_BOOT) && !defined(CONFIG_SD_BOOT_QSPI)
 #define CFG_SYS_NOR0_CSPR_EXT	(0x0)
 #define CFG_SYS_NOR_AMASK		IFC_AMASK(128 * 1024 * 1024)
diff --git a/include/configs/lx2160a_common.h b/include/configs/lx2160a_common.h
index 6f46ca78d4d..4c1b4bf2b2c 100644
--- a/include/configs/lx2160a_common.h
+++ b/include/configs/lx2160a_common.h
@@ -37,7 +37,6 @@
  * will be udpated later when get_bus_freq(0) is available.
  */
 
-
 /* Serial Port */
 #define CFG_PL011_CLOCK		(get_bus_freq(0) / 4)
 #define CFG_SYS_SERIAL0		0x21c0000
diff --git a/include/configs/meson64.h b/include/configs/meson64.h
index 65fa5f3d6dd..ccb8ea2e716 100644
--- a/include/configs/meson64.h
+++ b/include/configs/meson64.h
@@ -144,5 +144,4 @@
 	BOOTENV
 #endif
 
-
 #endif /* __MESON64_CONFIG_H */
diff --git a/include/configs/mt8183.h b/include/configs/mt8183.h
index 1f973829bba..7c31e219afd 100644
--- a/include/configs/mt8183.h
+++ b/include/configs/mt8183.h
@@ -11,7 +11,6 @@
 
 #include <linux/sizes.h>
 
-
 #define CFG_SYS_NS16550_COM1		0x11005200
 #define CFG_SYS_NS16550_CLK		26000000
 
diff --git a/include/configs/mt8516.h b/include/configs/mt8516.h
index 73776e3705b..27c3718352d 100644
--- a/include/configs/mt8516.h
+++ b/include/configs/mt8516.h
@@ -11,7 +11,6 @@
 
 #include <linux/sizes.h>
 
-
 #define CFG_SYS_NS16550_COM1		0x11005000
 #define CFG_SYS_NS16550_CLK		26000000
 
diff --git a/include/configs/mx53cx9020.h b/include/configs/mx53cx9020.h
index e995776d30d..dccfdc3a15d 100644
--- a/include/configs/mx53cx9020.h
+++ b/include/configs/mx53cx9020.h
@@ -21,7 +21,6 @@
 
 /* bootz: zImage/initrd.img support */
 
-
 /* USB Configs */
 #define CFG_MXC_USB_PORT	1
 #define CFG_MXC_USB_PORTSC	(PORT_PTS_UTMI | PORT_PTS_PTW)
diff --git a/include/configs/mx6ullevk.h b/include/configs/mx6ullevk.h
index 2c3cd32cefa..910140ab4b7 100644
--- a/include/configs/mx6ullevk.h
+++ b/include/configs/mx6ullevk.h
@@ -7,7 +7,6 @@
 #ifndef __MX6ULLEVK_CONFIG_H
 #define __MX6ULLEVK_CONFIG_H
 
-
 #include <asm/arch/imx-regs.h>
 #include <linux/sizes.h>
 #include <linux/stringify.h>
diff --git a/include/configs/mx7ulp_evk.h b/include/configs/mx7ulp_evk.h
index 5f4cd930623..d1c1202d061 100644
--- a/include/configs/mx7ulp_evk.h
+++ b/include/configs/mx7ulp_evk.h
@@ -11,7 +11,6 @@
 #include <linux/sizes.h>
 #include <asm/arch/imx-regs.h>
 
-
 /* Using ULP WDOG for reset */
 #define WDOG_BASE_ADDR			WDG1_RBASE
 
diff --git a/include/configs/phycore_imx8mm.h b/include/configs/phycore_imx8mm.h
index ce6dc87c69c..dd7cfdba52d 100644
--- a/include/configs/phycore_imx8mm.h
+++ b/include/configs/phycore_imx8mm.h
@@ -63,7 +63,6 @@
 #define CFG_SYS_INIT_RAM_ADDR	0x40000000
 #define CFG_SYS_INIT_RAM_SIZE	SZ_512K
 
-
 #define CFG_SYS_SDRAM_BASE		0x40000000
 
 #define PHYS_SDRAM			0x40000000
diff --git a/include/configs/phycore_imx8mp.h b/include/configs/phycore_imx8mp.h
index 299fabc6a99..47c56b50b16 100644
--- a/include/configs/phycore_imx8mp.h
+++ b/include/configs/phycore_imx8mp.h
@@ -18,7 +18,6 @@
 #define CFG_SYS_INIT_RAM_ADDR	0x40000000
 #define CFG_SYS_INIT_RAM_SIZE	SZ_512K
 
-
 #define CFG_SYS_SDRAM_BASE		0x40000000
 
 #define PHYS_SDRAM			0x40000000
diff --git a/include/configs/pico-imx6ul.h b/include/configs/pico-imx6ul.h
index 4caa8233758..8a22f0134b3 100644
--- a/include/configs/pico-imx6ul.h
+++ b/include/configs/pico-imx6ul.h
@@ -7,7 +7,6 @@
 #ifndef __PICO_IMX6UL_CONFIG_H
 #define __PICO_IMX6UL_CONFIG_H
 
-
 #include <asm/arch/imx-regs.h>
 #include <linux/sizes.h>
 #include "mx6_common.h"
diff --git a/include/configs/pico-imx8mq.h b/include/configs/pico-imx8mq.h
index be31f8a23ca..422b89a3dd3 100644
--- a/include/configs/pico-imx8mq.h
+++ b/include/configs/pico-imx8mq.h
@@ -65,7 +65,6 @@
 #define CFG_SYS_INIT_RAM_ADDR	0x40000000
 #define CFG_SYS_INIT_RAM_SIZE	0x80000
 
-
 #define CFG_SYS_SDRAM_BASE		0x40000000
 #define PHYS_SDRAM			0x40000000
 #define PHYS_SDRAM_SIZE			0x80000000	/* 2 GiB DDR */
diff --git a/include/configs/sei510.h b/include/configs/sei510.h
index ea91a061577..0f8070b8d31 100644
--- a/include/configs/sei510.h
+++ b/include/configs/sei510.h
@@ -25,7 +25,6 @@
 	"name=userdata,size=4820M,uuid=${uuid_gpt_userdata};" \
 	"name=rootfs,size=-,uuid=" ROOT_UUID
 
-
 #include <configs/meson64_android.h>
 
 #endif /* __CONFIG_H */
diff --git a/include/configs/siemens-am33x-common.h b/include/configs/siemens-am33x-common.h
index 6b1d5caafb1..74b7fe85800 100644
--- a/include/configs/siemens-am33x-common.h
+++ b/include/configs/siemens-am33x-common.h
@@ -40,7 +40,6 @@
 #define CFG_SYS_NS16550_COM1		0x44e09000
 #define CFG_SYS_NS16550_COM4		0x481a6000
 
-
 /* I2C Configuration */
 
 /* Defines for SPL */
diff --git a/include/configs/socrates.h b/include/configs/socrates.h
index 64cc17ca7ca..006d649f6ed 100644
--- a/include/configs/socrates.h
+++ b/include/configs/socrates.h
@@ -48,7 +48,6 @@
 /* I2C addresses of SPD EEPROMs */
 #define SPD_EEPROM_ADDRESS	0x50	/* CTLR 0 DIMM 0 */
 
-
 /* Hardcoded values, to use instead of SPD */
 #define CFG_SYS_DDR_CS0_BNDS		0x0000000f
 #define CFG_SYS_DDR_CS0_CONFIG		0x80010102
diff --git a/include/configs/stm32mp15_dh_dhsom.h b/include/configs/stm32mp15_dh_dhsom.h
index c1fca8359d2..6fe6e7b9b8c 100644
--- a/include/configs/stm32mp15_dh_dhsom.h
+++ b/include/configs/stm32mp15_dh_dhsom.h
@@ -53,7 +53,6 @@
 	"update_sf=run dh_update_sd_to_sf\0"				\
 	"usb_pgood_delay=1000\0"
 
-
 #include <configs/stm32mp15_common.h>
 
 #endif
diff --git a/include/configs/stmark2.h b/include/configs/stmark2.h
index af5da096b7d..c8a39e191a2 100644
--- a/include/configs/stmark2.h
+++ b/include/configs/stmark2.h
@@ -95,7 +95,6 @@
 #define CACR_STATUS			(CFG_SYS_INIT_RAM_ADDR + \
 					CFG_SYS_INIT_RAM_SIZE - 12)
 
-
 #define CFG_SYS_I2C_0
 
 #endif /* __STMARK2_CONFIG_H */
diff --git a/include/configs/ten64.h b/include/configs/ten64.h
index d2bef9b6e52..d5bb2e96c51 100644
--- a/include/configs/ten64.h
+++ b/include/configs/ten64.h
@@ -9,7 +9,6 @@
 
 #include "ls1088a_common.h"
 
-
 #define CFG_SYS_LS_MC_BOOT_TIMEOUT_MS 5000
 
 #define QSPI_NOR_BOOTCOMMAND	"run distro_bootcmd"
diff --git a/include/configs/topic_miami.h b/include/configs/topic_miami.h
index 3795e6152fa..06276175455 100644
--- a/include/configs/topic_miami.h
+++ b/include/configs/topic_miami.h
@@ -9,7 +9,6 @@
 #ifndef __CONFIG_TOPIC_MIAMI_H
 #define __CONFIG_TOPIC_MIAMI_H
 
-
 /* Speed up boot time by ignoring the environment which we never used */
 
 #include "zynq-common.h"
diff --git a/include/configs/warp7.h b/include/configs/warp7.h
index 5d2956a5963..0da9250c3b7 100644
--- a/include/configs/warp7.h
+++ b/include/configs/warp7.h
@@ -92,7 +92,6 @@
 
 #define CFG_SYS_FSL_USDHC_NUM	1
 
-
 #define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
 
 /* USB Device Firmware Update support */
diff --git a/include/configs/x86-common.h b/include/configs/x86-common.h
index 8bd0716c08d..d93a45d5aae 100644
--- a/include/configs/x86-common.h
+++ b/include/configs/x86-common.h
@@ -36,5 +36,4 @@
 	"ramdisk_addr_r=0x4000000\0"			\
 	"ramdiskfile=initramfs.gz\0"
 
-
 #endif	/* __CONFIG_H */
diff --git a/include/configs/xtfpga.h b/include/configs/xtfpga.h
index 9655b666eda..468c5b85ab7 100644
--- a/include/configs/xtfpga.h
+++ b/include/configs/xtfpga.h
@@ -71,7 +71,6 @@
 /* U-Boot autoboot configuration */
 /*==============================*/
 
-
 /*=========================================*/
 /* FPGA Registers (board info and control) */
 /*=========================================*/
diff --git a/include/configs/zynq-common.h b/include/configs/zynq-common.h
index 553bb1b45b6..03af859c951 100644
--- a/include/configs/zynq-common.h
+++ b/include/configs/zynq-common.h
@@ -185,7 +185,6 @@
 #define CFG_SYS_INIT_RAM_ADDR	0xFFFF0000
 #define CFG_SYS_INIT_RAM_SIZE	0x2000
 
-
 /* Extend size of kernel image for uncompression */
 
 /* Address in RAM where the parameters must be copied by SPL. */
-- 
2.43.0

