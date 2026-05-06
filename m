Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D3BCD342C
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 04:29:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DD5C848EB;
	Thu,  7 May 2026 06:29:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=deadband.dev
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=deadband.dev header.i=@deadband.dev header.b="hBCcxPBL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59EAF849DF; Thu,  7 May 2026 00:38:31 +0200 (CEST)
Received: from a4i683.smtp2go.com (a4i683.smtp2go.com [158.120.82.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01A29848BC
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 00:38:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=deadband.dev
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bounce.8uxrazs9yesf1v4=evnacmbrm5zq=gcrj8zsinz7hhy@em1005147.deadband.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deadband.dev;
 i=@deadband.dev; q=dns/txt; s=s1005147; t=1778107107; h=from : subject
 : to : message-id : date;
 bh=8VfirD+tosGtGcCiZD2KDO8ZzC5hR4CAVNj5k9SDmL4=;
 b=hBCcxPBLu+plyiP4IHF16wzpxeOwUFc3f7hw/PDI28arrj9rj8noFYWAzDLZoFcx0V/2O
 HYinoir8JUC/6DOyftHb6BtgacC48lI5EROYpttzDcUUrUApbq1sopDP5sWrhWhUeJL5IpW
 t0ksclTTt3XjAv3qZ9bZqxq43qUau2gm5LMarb/6ex6RKQ1Gcbb6TSCZ+CH0YPqrjlkgjg4
 n8K0506x4m9maNmBeTdPkHqsRhUQArsn4FW2UpbrAVq9Yb4pGzYHt6Sz7JbuxxTHx4sVoi2
 OP2Z8TzbXO+qHqm7YTtWfv9h6V+mVoIZgXIJd0bihsV4dbzymtd3vuib5NOw==
Received: from [10.181.246.189] (helo=synclavier) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.99.1-S2G) (envelope-from <austin@deadband.dev>)
 id 1wKksj-4o5NDgrpQRN-eEUZ; Wed, 06 May 2026 22:38:17 +0000
From: Austin Shirley <austin@deadband.dev>
To: u-boot@lists.denx.de
Cc: patrick.delaunay@foss.st.com, patrice.chotard@foss.st.com,
 trini@konsulko.com, uboot-stm32@st-md-mailman.stormreply.com,
 Austin Shirley <austin@deadband.dev>
Subject: [PATCH] configs: stm32mp13: add SPI-NAND UBI boot support
Date: Wed,  6 May 2026 16:37:58 -0600
Message-ID: <20260506223758.3717574-1-austin@deadband.dev>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Feedback-ID: 1005147m:1005147a6bgr7a:1005147smN-Ax-so8
X-smtpcorp-track: XoibFgylKSuF.33msBJBfoJ7U.jxY_xwacc9p
X-Mailman-Approved-At: Thu, 07 May 2026 06:29:13 +0200
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

The STM32MP13 default environment only handles MMC and serial/USB boot.
When TF-A reports BOOT_FLASH_SPINAND the boot_device variable is set to
'spi-nand' but bootcmd_stm32mp never redirects boot_targets to ubifs0,
so distro_bootcmd falls through to MMC/USB.

This change mirrors the STM32MP15 logic:
 - Add a BOOT_TARGET_UBIFS entry to BOOT_TARGET_DEVICES so that
   bootcmd_ubifs0 is defined (ubi part UBI; ubifsmount ubi0:boot).
 - Add the 'spi-nand' / 'nand' clause to bootcmd_stm32mp so that
   boot_targets is set to 'ubifs0' when booting from NAND.

Signed-off-by: Austin Shirley <austin@deadband.dev>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 include/configs/stm32mp13_common.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/configs/stm32mp13_common.h b/include/configs/stm32mp13_common.h
index 3e3f49abae0..e707b146f90 100644
--- a/include/configs/stm32mp13_common.h
+++ b/include/configs/stm32mp13_common.h
@@ -33,6 +33,12 @@
 #define BOOT_TARGET_MMC1(func)
 #endif
 
+#ifdef CONFIG_CMD_UBIFS
+#define BOOT_TARGET_UBIFS(func)	func(UBIFS, ubifs, 0, UBI, boot)
+#else
+#define BOOT_TARGET_UBIFS(func)
+#endif
+
 #ifdef CONFIG_CMD_USB
 #define BOOT_TARGET_USB(func)	func(USB, usb, 0)
 #else
@@ -41,12 +47,14 @@
 
 #define BOOT_TARGET_DEVICES(func)	\
 	BOOT_TARGET_MMC1(func)		\
+	BOOT_TARGET_UBIFS(func)		\
 	BOOT_TARGET_MMC0(func)		\
 	BOOT_TARGET_USB(func)
 
 /*
  * default bootcmd for stm32mp13:
  * for serial/usb: execute the stm32prog command
+ * for nand or spi-nand boot, distro boot with ubifs on UBI partition
  * for mmc boot (eMMC, SD card), distro boot on the same mmc device
  */
 #define STM32MP_BOOTCMD "bootcmd_stm32mp=" \
@@ -56,7 +64,10 @@
 	"else " \
 		"run env_check;" \
 		"if test ${boot_device} = mmc;" \
-		"then env set boot_targets \"mmc${boot_instance}\"; fi;" \
+		"then env set boot_targets \"mmc${boot_instance}\"; fi; " \
+		"if test ${boot_device} = nand ||" \
+		  " test ${boot_device} = spi-nand ;" \
+		"then env set boot_targets ubifs0; fi;" \
 		"run distro_bootcmd;" \
 	"fi;\0"
 
-- 
2.54.0

