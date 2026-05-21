Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFDB4CD5BAC
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 15:19:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E31C1846EB;
	Thu, 21 May 2026 17:19:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=analog.com header.i=@analog.com header.b="asWCupJh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4905846E7; Thu, 21 May 2026 15:54:46 +0200 (CEST)
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com
 [148.163.135.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E9D4805D7
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 15:54:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=analog.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Caleb.Ethridge@analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
 by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64LD2gbU416785; Thu, 21 May 2026 09:54:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=DKIM; bh=RNIvZ
 NCzfSPuNdEeGpjlY944Rva0z23toaXlglsHxgQ=; b=asWCupJhaCZDxUeMZI3lH
 Rk+6muLxFrIJQyVTEOCAd75gErn0XQc5DlNL4xk7NeHdbxOW/iThfH0T6g6Fy8R9
 VbDmM9cQ5jqLp3vW5B0ewG8g64J4Rg+cO4IbOy1DfsoJ6lC1LQHkGyka8XNBuk3e
 0JN79daXzx8jbEmGhNTuY1A90hRUMlsBkBhOUlkcIDrlJK3e1McDk2x0jlYrh5al
 gnFkjDyRH6sttMQLoiD2U8j5u1Cjwui14SaQ1VkVlyhxwd658g0ILwP8Ut1xK2yw
 BdXwpY4FXDFDVNaNKZf05oBoULrcH4HBbgxO48i85CoDCK2WNQ4Qz7gjujSPaToD
 Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
 by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4e9e6wvkpt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 May 2026 09:54:40 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
 by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 64LDsd7V046900
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL); 
 Thu, 21 May 2026 09:54:39 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 21 May
 2026 09:54:39 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 21 May 2026 09:54:39 -0400
Received: from cethridg-sml01.ad.analog.com (cethridg-sml01.ad.analog.com
 [10.75.142.63])
 by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 64LDrkqe016286;
 Thu, 21 May 2026 09:54:34 -0400
From: Caleb Ethridge <caleb.ethridge@analog.com>
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <malysagreg@gmail.com>, <philip@philipmolloy.com>,
 <sjg@chromium.org>, <linux@analog.com>, <jcethrid@gmail.com>,
 Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH v6 02/16] mach-sc5xx: Remove update commands from default
 environment
Date: Thu, 21 May 2026 09:53:13 -0400
Message-ID: <ee3a67f20d38a287fb3e5b238784102e12998f35.1779370141.git.caleb.ethridge@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1779370141.git.caleb.ethridge@analog.com>
References: <cover.1779370141.git.caleb.ethridge@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: W4WBuRbk_hjp8hoSDHfOgb4KoXda4Sem
X-Proofpoint-ORIG-GUID: W4WBuRbk_hjp8hoSDHfOgb4KoXda4Sem
X-Authority-Analysis: v=2.4 cv=K8gS2SWI c=1 sm=1 tr=0 ts=6a0f0ea0 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=ww6bmzhZfQoOBl1ZbacA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE0MCBTYWx0ZWRfX9ONOid0Nx6SY
 62rLIAZNBHQZdr3txeN+mrV5ioGMA0KSMDUqIhg9VqsuIFjLHA99VvsvxY0IH/4O3T4/xXJEA8A
 T/cAEr7jNvERkQCbACVEUOARlUI6kVPLdjEmMhpweeMc8ulNbyCWsWd+vL+d8f27w0UPk7fliFR
 nwN9U4oSeXSwz0NaTomKC3lDpb23wiDBSm+rsd9n/1JSSefvn+hBsaOlTcG89hjT54cJPPhdFAc
 5rjMHNtvzPBeDvQ0aeObOuqr2VYfFxrfY7VbHTj7rleKuX+q0im/Mr3QJTEWMtzi7XSgNr2IUTd
 ct0EO8Jy6uIArxACv/i8zSOW4iiGcIFSR5abHs0JDO6FAuaRHEoWpwgFHsrbzwQtLLTcWDHVdt4
 FaNXZvMW1XgY/z+aDQJ0kpe4wwWBZYRokaT/bchPwacvhnvBYv5lB43eWGiUhsM/gHFcx1Zsb+R
 14CGbudcpdGGX2o5iqQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210140
X-Mailman-Approved-At: Thu, 21 May 2026 17:19:00 +0200
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

Remove the update_spi family of commands from the U-Boot
environment. These commands are not standard in U-Boot,
and boot media programming has moved to Linux, so the
commands can be safely removed.

Additionally, this commit removes the adi_stage2_offset,
adi_rfs_offset, imagefile, jffs2file, and init_ethernet variables that
were consumed by the update commands as they are no longer needed.
CONFIG_SC5XX_UBOOT_OFFSET and CONFIG_SC5XX_ROOTFS_OFFSET are also
removed.

Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
---
 board/adi/sc573-ezkit/sc573-ezkit.env         |  3 --
 board/adi/sc584-ezkit/sc584-ezkit.env         |  3 --
 board/adi/sc589-ezkit/sc589-ezkit.env         |  3 --
 board/adi/sc589-mini/sc589-mini.env           |  3 --
 board/adi/sc594-som-ezkit/sc594-som-ezkit.env |  3 --
 .../adi/sc594-som-ezlite/sc594-som-ezlite.env |  3 --
 board/adi/sc598-som-ezkit/sc598-som-ezkit.env |  3 --
 .../adi/sc598-som-ezlite/sc598-som-ezlite.env |  3 --
 configs/sc573-ezkit_defconfig                 |  2 -
 configs/sc584-ezkit_defconfig                 |  2 -
 configs/sc589-ezkit_defconfig                 |  2 -
 configs/sc589-mini_defconfig                  |  2 -
 include/env/adi/adi_boot.env                  | 54 -------------------
 13 files changed, 86 deletions(-)

diff --git a/board/adi/sc573-ezkit/sc573-ezkit.env b/board/adi/sc573-ezkit/sc573-ezkit.env
index 8b03a3d5da9..83cbe808efa 100644
--- a/board/adi/sc573-ezkit/sc573-ezkit.env
+++ b/board/adi/sc573-ezkit/sc573-ezkit.env
@@ -3,10 +3,7 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-adi_stage2_offset=CONFIG_SC5XX_UBOOT_OFFSET
 adi_image_offset=CONFIG_SC5XX_FITIMAGE_OFFSET
-adi_rfs_offset=CONFIG_SC5XX_ROOTFS_OFFSET
-jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc573-ezkit.jffs2
 loadaddr=CONFIG_SC5XX_LOADADDR
 
 #define USE_NFS
diff --git a/board/adi/sc584-ezkit/sc584-ezkit.env b/board/adi/sc584-ezkit/sc584-ezkit.env
index 8a6f7edd5e8..2640d97bab2 100644
--- a/board/adi/sc584-ezkit/sc584-ezkit.env
+++ b/board/adi/sc584-ezkit/sc584-ezkit.env
@@ -3,10 +3,7 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-adi_stage2_offset=CONFIG_SC5XX_UBOOT_OFFSET
 adi_image_offset=CONFIG_SC5XX_FITIMAGE_OFFSET
-adi_rfs_offset=CONFIG_SC5XX_ROOTFS_OFFSET
-jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc584-ezkit.jffs2
 loadaddr=CONFIG_SC5XX_LOADADDR
 
 #define USE_NFS
diff --git a/board/adi/sc589-ezkit/sc589-ezkit.env b/board/adi/sc589-ezkit/sc589-ezkit.env
index b8206e85179..a098f0b9c2c 100644
--- a/board/adi/sc589-ezkit/sc589-ezkit.env
+++ b/board/adi/sc589-ezkit/sc589-ezkit.env
@@ -3,10 +3,7 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-adi_stage2_offset=CONFIG_SC5XX_UBOOT_OFFSET
 adi_image_offset=CONFIG_SC5XX_FITIMAGE_OFFSET
-adi_rfs_offset=CONFIG_SC5XX_ROOTFS_OFFSET
-jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc589-ezkit.jffs2
 loadaddr=CONFIG_SC5XX_LOADADDR
 
 #define USE_NFS
diff --git a/board/adi/sc589-mini/sc589-mini.env b/board/adi/sc589-mini/sc589-mini.env
index f7628b0b335..bed2ddc944d 100644
--- a/board/adi/sc589-mini/sc589-mini.env
+++ b/board/adi/sc589-mini/sc589-mini.env
@@ -3,10 +3,7 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-adi_stage2_offset=CONFIG_SC5XX_UBOOT_OFFSET
 adi_image_offset=CONFIG_SC5XX_FITIMAGE_OFFSET
-adi_rfs_offset=CONFIG_SC5XX_ROOTFS_OFFSET
-jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc589-mini.jffs2
 loadaddr=CONFIG_SC5XX_LOADADDR
 
 #define USE_NFS
diff --git a/board/adi/sc594-som-ezkit/sc594-som-ezkit.env b/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
index 069edc717da..f629f7f2cff 100644
--- a/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
+++ b/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
@@ -3,10 +3,7 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-adi_stage2_offset=CONFIG_SC5XX_UBOOT_OFFSET
 adi_image_offset=CONFIG_SC5XX_FITIMAGE_OFFSET
-adi_rfs_offset=CONFIG_SC5XX_ROOTFS_OFFSET
-jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc594-som-ezkit.jffs2
 loadaddr=CONFIG_SC5XX_LOADADDR
 
 #define USE_NFS
diff --git a/board/adi/sc594-som-ezlite/sc594-som-ezlite.env b/board/adi/sc594-som-ezlite/sc594-som-ezlite.env
index e5382b67c81..f629f7f2cff 100644
--- a/board/adi/sc594-som-ezlite/sc594-som-ezlite.env
+++ b/board/adi/sc594-som-ezlite/sc594-som-ezlite.env
@@ -3,10 +3,7 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-adi_stage2_offset=CONFIG_SC5XX_UBOOT_OFFSET
 adi_image_offset=CONFIG_SC5XX_FITIMAGE_OFFSET
-adi_rfs_offset=CONFIG_SC5XX_ROOTFS_OFFSET
-jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc594-som-ezlite.jffs2
 loadaddr=CONFIG_SC5XX_LOADADDR
 
 #define USE_NFS
diff --git a/board/adi/sc598-som-ezkit/sc598-som-ezkit.env b/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
index 2cb475e1001..f629f7f2cff 100644
--- a/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
+++ b/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
@@ -3,10 +3,7 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-adi_stage2_offset=CONFIG_SC5XX_UBOOT_OFFSET
 adi_image_offset=CONFIG_SC5XX_FITIMAGE_OFFSET
-adi_rfs_offset=CONFIG_SC5XX_ROOTFS_OFFSET
-jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc598-som-ezkit.jffs2
 loadaddr=CONFIG_SC5XX_LOADADDR
 
 #define USE_NFS
diff --git a/board/adi/sc598-som-ezlite/sc598-som-ezlite.env b/board/adi/sc598-som-ezlite/sc598-som-ezlite.env
index 1d9ea6d188b..7b13d6fc32b 100644
--- a/board/adi/sc598-som-ezlite/sc598-som-ezlite.env
+++ b/board/adi/sc598-som-ezlite/sc598-som-ezlite.env
@@ -3,10 +3,7 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-adi_stage2_offset=CONFIG_SC5XX_UBOOT_OFFSET
 adi_image_offset=CONFIG_SC5XX_FITIMAGE_OFFSET
-adi_rfs_offset=CONFIG_SC5XX_ROOTFS_OFFSET
 loadaddr=CONFIG_SC5XX_LOADADDR
-jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc598-som-ezlite.jffs2
 
 #include <env/adi/adi_boot.env>
diff --git a/configs/sc573-ezkit_defconfig b/configs/sc573-ezkit_defconfig
index 976d8e0306a..7a0c7d04e84 100644
--- a/configs/sc573-ezkit_defconfig
+++ b/configs/sc573-ezkit_defconfig
@@ -6,9 +6,7 @@ CONFIG_SPL_GPIO=y
 CONFIG_DM_GPIO=y
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x10000
 CONFIG_SPL_SERIAL=y
-CONFIG_SC5XX_UBOOT_OFFSET=0x20000
 CONFIG_SC5XX_FITIMAGE_OFFSET=0xE0000
-CONFIG_SC5XX_ROOTFS_OFFSET=0x6E0000
 CONFIG_SC5XX_LOADADDR=0x83000000
 CONFIG_WATCHDOG_TIMEOUT_MSECS=60000
 CONFIG_CGU0_CLKOUTSEL=7
diff --git a/configs/sc584-ezkit_defconfig b/configs/sc584-ezkit_defconfig
index 27f55804199..7975a610ca3 100644
--- a/configs/sc584-ezkit_defconfig
+++ b/configs/sc584-ezkit_defconfig
@@ -10,9 +10,7 @@ CONFIG_SPL_STACK=0x200C0000
 CONFIG_SPL_BSS_START_ADDR=0x200A0000
 CONFIG_SPL_BSS_MAX_SIZE=0x8000
 CONFIG_SC58X=y
-CONFIG_SC5XX_UBOOT_OFFSET=0x20000
 CONFIG_SC5XX_FITIMAGE_OFFSET=0xE0000
-CONFIG_SC5XX_ROOTFS_OFFSET=0x6E0000
 CONFIG_SC5XX_LOADADDR=0x89300000
 CONFIG_WATCHDOG_TIMEOUT_MSECS=60000
 CONFIG_ADI_BUG_EZKHW21=y
diff --git a/configs/sc589-ezkit_defconfig b/configs/sc589-ezkit_defconfig
index 180b6904d95..0ceb57f1f42 100644
--- a/configs/sc589-ezkit_defconfig
+++ b/configs/sc589-ezkit_defconfig
@@ -13,9 +13,7 @@ CONFIG_SPL_BSS_START_ADDR=0x200A0000
 CONFIG_SPL_BSS_MAX_SIZE=0x8000
 CONFIG_SC58X=y
 CONFIG_TARGET_SC589_EZKIT=y
-CONFIG_SC5XX_UBOOT_OFFSET=0x20000
 CONFIG_SC5XX_FITIMAGE_OFFSET=0xE0000
-CONFIG_SC5XX_ROOTFS_OFFSET=0x6E0000
 CONFIG_SC5XX_LOADADDR=0xC3000000
 CONFIG_WATCHDOG_TIMEOUT_MSECS=60000
 CONFIG_ADI_USE_DMC1=y
diff --git a/configs/sc589-mini_defconfig b/configs/sc589-mini_defconfig
index 92c2741f701..32678b63a9f 100644
--- a/configs/sc589-mini_defconfig
+++ b/configs/sc589-mini_defconfig
@@ -12,9 +12,7 @@ CONFIG_SPL_BSS_START_ADDR=0x200A0000
 CONFIG_SPL_BSS_MAX_SIZE=0x8000
 CONFIG_SC58X=y
 CONFIG_TARGET_SC589_MINI=y
-CONFIG_SC5XX_UBOOT_OFFSET=0x20000
 CONFIG_SC5XX_FITIMAGE_OFFSET=0xE0000
-CONFIG_SC5XX_ROOTFS_OFFSET=0x8E0000
 CONFIG_SC5XX_LOADADDR=0xC3000000
 CONFIG_WATCHDOG_TIMEOUT_MSECS=60000
 CONFIG_ADI_USE_DMC1=y
diff --git a/include/env/adi/adi_boot.env b/include/env/adi/adi_boot.env
index db4148b1af9..42f33ed83af 100644
--- a/include/env/adi/adi_boot.env
+++ b/include/env/adi/adi_boot.env
@@ -1,11 +1,8 @@
 /*
  * A target board needs to set these variables for the commands below to work:
  *
- * - adi_stage2_offset, the location of stage2-boot.ldr on the SPI flash
  * - adi_image_offset, location of the fitImage on the SPI flash
- * - adi_rfs_offset, location of the RFS on the SPI flash
  * - loadaddr, where you want to load things
- * - jffs2file, name of the jffs2 file for update, ex adsp-sc5xx-tiny-adsp-sc573.jffs2
  */
 
 #ifdef CONFIG_SC59X_64
@@ -15,7 +12,6 @@
 #endif
 
 /* Config options */
-imagefile=fitImage
 ethaddr=02:80:ad:20:31:e8
 eth1addr=02:80:ad:20:31:e9
 uart_console=CONFIG_UART_CONSOLE
@@ -25,11 +21,6 @@ initrd_high=0xffffffffffffffff
 initrd_high=0xffffffff
 #endif
 
-/* Helper routines */
-init_ethernet=mii info;
-	dhcp;
-	setenv serverip ${tftpserverip}
-
 /* Args for each boot mode */
 adi_bootargs=EARLY_PRINTK console=ttySC0,CONFIG_BAUDRATE vmalloc=512M
 ramargs=setenv bootargs ${adi_bootargs}
@@ -73,48 +64,3 @@ ramboot=run init_ethernet;
 	run ramargs;
 	bootm ${loadaddr}
 #endif
-
-/* Update commands */
-stage1file=stage1-boot.ldr
-stage2file=stage2-boot.ldr
-
-#if defined(USE_SPI) || defined(USE_OSPI)
-update_spi_uboot_stage1=tftp ${loadaddr} ${tftp_dir_prefix}${stage1file};
-	sf probe ${sfdev};
-	sf update ${loadaddr} 0x0 ${filesize}
-update_spi_uboot_stage2=tftp ${loadaddr} ${tftp_dir_prefix}${stage2file};
-	sf probe ${sfdev};
-	sf update ${loadaddr} ${adi_stage2_offset} ${filesize}
-update_spi_uboot=run update_spi_uboot_stage1;
-	run update_spi_uboot_stage2;
-update_spi_fit=tftp ${loadaddr} ${tftp_dir_prefix}${imagefile};
-	sf probe ${sfdev};
-	sf update ${loadaddr} ${adi_image_offset} ${filesize};
-	setenv imagesize ${filesize}
-update_spi_rfs=tftp ${loadaddr} ${tftp_dir_prefix}${jffs2file};
-	sf probe ${sfdev};
-	sf update ${loadaddr} ${adi_rfs_offset} ${filesize}
-
-start_update_spi=run init_ethernet;
-	run update_spi_uboot;
-	run update_spi_fit;
-	run update_spi_rfs;
-start_update_spi_uboot_only=run init_ethernet;
-	run update_spi_uboot;
-#endif
-
-#if defined(USE_SPI)
-update_spi=setenv sfdev CONFIG_SC_BOOT_SPI_BUS:CONFIG_SC_BOOT_SPI_SSEL;
-	setenv bootcmd run spiboot;
-	setenv argscmd spiargs;
-	run start_update_spi;
-	saveenv
-#endif
-
-#if defined(USE_OSPI)
-update_ospi=setenv sfdev CONFIG_SC_BOOT_OSPI_BUS:CONFIG_SC_BOOT_OSPI_SSEL;
-	setenv bootcmd run ospiboot;
-	setenv argscmd spiargs;
-	run start_update_spi;
-	saveenv
-#endif
-- 
2.34.1

