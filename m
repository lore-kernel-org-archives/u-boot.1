Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3AA2C4707C
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 14:49:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 155FE87A97;
	Wed, 10 Jan 2024 15:49:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1704898167;
	bh=31n+meJy1+rZB3/uRnB4kv3idGFcLN8iCyuzEH40Si4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=U6H8WP7HipqkLb+bJKkfTM5qsKw6UzDZS1Y+OMlojucRT4TB6KbAVxa2ltPwpoyrQ
	 xdwZXASlJ+uBq80qFf0dzcACu9nrj1ttMJrIYyKadUnN95lzTgoGnmqDYSY1jNzJmV
	 +e5taY2dD8P6GWm63X2qqv+L5O+eMOCzNM2HEi2uU0v0t6Hfu6mDliHAhPGUjYentb
	 8nqDK7b22aGgNf+Fxt1y3yQInLNvbtXQ2kX1Mg/kaS8KJ9FJxkexhOlq/M5rhd5GAb
	 aVqk7r8lOGnU6Pe2dSnRgigEXtnZyUPd7QAkSlaGUfSuu+KSQQCdCxDFWPQC4TT0Gv
	 lZZe8pkCCq7DQ==
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl
 [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id D2BAF878E7;
 Wed, 10 Jan 2024 15:49:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1704898166;
 bh=31n+meJy1+rZB3/uRnB4kv3idGFcLN8iCyuzEH40Si4=;
 h=From:To:Cc:Subject:Date:From;
 b=vtzIzTeJXzbUC6d86t1iu+GXvF4fc6zI0C78CvDd+VVlydxX67I5iAa6+lnCtYWCQ
 /YQScd12JBN6z3mm/avFnoKEETotnn6vyfcP3HQi6J93kSZxGz59rStwksgV4AVlGk
 f6mSNn4H0xU3eYLbyUVlm5x8g2/Jxo7OnCuW0kYYoLiWDt4RAZcPUGPjZOGRMrCuVd
 7bsouqpZOgb3Absu2WhH885lQD1OWIIJxbNPkRIKOTTWPbvN3n+4Y8/ermwzuKjGYv
 aCQ1T5wGK1LA9aUcRV81GBUVABmB16PjgCml3VgaSw7l0myVa9hGjaHgJGXCpo/Dxz
 ov8GVjxaDCjEA==
From: Lukasz Majewski <lukma@denx.de>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 NXP u-boot <uboot-imx@nxp.com>
Cc: Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v1 1/3] arm: config: xea: Update environment variables for XEA
 board (imx287)
Date: Wed, 10 Jan 2024 15:48:47 +0100
Message-Id: <20240110144849.1783122-1-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
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

As the XEA now supports fitImage, the default envs shall reflect this
as well.

Moreover, some SPI-NOR layout re-organization has took place.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---

 include/configs/xea.h | 45 ++++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/include/configs/xea.h b/include/configs/xea.h
index 04ca5aa12a..a11bb522cd 100644
--- a/include/configs/xea.h
+++ b/include/configs/xea.h
@@ -33,17 +33,21 @@
 	"bootsec=sf_swu\0"						\
 	"consdev=ttyAMA0\0"						\
 	"baudrate=115200\0"						\
-	"dtbaddr=0x44000000\0"						\
-	"dtbfile=imx28-xea.dtb\0"					\
 	"rootdev=/dev/mmcblk0p2\0"					\
 	"netdev=eth0\0"							\
-	"rdaddr=0x43000000\0"						\
-	"swufile=swupdate.img\0"					\
-	"sf_kernel_offset=0x100000\0"					\
-	"sf_kernel_size=0x400000\0"					\
-	"sf_swu_offset=0x500000\0"					\
-	"sf_swu_size=0x800000\0"					\
-	"rootpath=/opt/eldk-5.5/armv5te/rootfs-qte-sdk\0"		\
+	"swufile=swupdate-image-xea-upd.itb\0"				\
+	"sf_kernel_offset=0xA0000\0"					\
+	"sf_swu_size=0xF40000\0"					\
+	"ethact=FEC\0"							\
+	"arch=xea\0"							\
+	"serverip=10.8.217.79\0"					\
+	"nfs_serverip=10.8.218.113\0"					\
+	"gatewayip=10.8.209.250\0"					\
+	"lwe_env="							\
+		"if dhcp ${loadaddr} ${hostname}/${lwe_uenv} ; then "	\
+		"source ${loadaddr}; "					\
+		"fi\0"							\
+	"lwe_uenv=env_uboot_xea.bin\0"					\
 	"do_update_mmc="						\
 		"if mmc rescan ; then "					\
 		"mmc dev 0 ${update_mmc_part} ; "			\
@@ -60,6 +64,12 @@
 		"sf write ${loadaddr} ${update_offset} ${filesize} ; "	\
 		"fi ; "							\
 		"fi\0"							\
+	"factory_reset="						\
+		"if sf probe ; then "					\
+		"run update_swu ; "					\
+		"setenv bootmode update ; "				\
+		"saveenv ; "						\
+		"fi\0"							\
 	"update_spl_filename=u-boot.sb\0"				\
 	"update_spl="							\
 		"setenv update_filename ${update_spl_filename} ; "	\
@@ -72,6 +82,8 @@
 		"run do_update_sf ; "					\
 		"setenv update_mmc_part 1 ; "				\
 		"setenv update_offset 0 ; "				\
+		"run do_update_mmc ; "					\
+		"setenv update_mmc_part 2 ; "				\
 		"run do_update_mmc\0"					\
 	"update_kernel_filename=uImage\0"				\
 	"update_kernel="						\
@@ -82,13 +94,9 @@
 		"setenv update_filename ${dtbfile} ; "			\
 		"setenv update_offset 0x400 ; "				\
 		"run do_update_mmc\0"					\
-	"update_sfkernel="						\
-		"setenv update_filename fitImage ; "			\
-		"setenv update_offset ${sf_kernel_offset} ; "		\
-		"run do_update_sf\0"					\
 	"update_swu="							\
 		"setenv update_filename ${swufile} ; "			\
-		"setenv update_offset ${sf_swu_offset} ; "		\
+		"setenv update_offset ${sf_kernel_offset} ; "		\
 		"run do_update_sf\0"					\
 	"addcons="							\
 		"setenv bootargs ${bootargs} "				\
@@ -108,9 +116,6 @@
 	"netload="							\
 		"dhcp ${loadaddr} ${hostname}/${bootfile} ; "		\
 		"tftp ${dtbaddr} ${hostname}/${dtbfile}\0"		\
-	"sfload="							\
-		"sf probe ; "						\
-		"sf read ${loadaddr} ${sf_kernel_offset} ${sf_kernel_size}\0" \
 	"usbload="							\
 		"usb start ; "						\
 		"load usb 0:1 ${loadaddr} ${bootfile}\0"		\
@@ -132,11 +137,11 @@
 		"bootm ${loadaddr} - ${dtbaddr} ; "			\
 		"fi\0"							\
 	"sf_swu="							\
-		"if run sfload ; then "					\
-		"sf read ${rdaddr} ${sf_swu_offset} ${sf_swu_size} ; "	\
+		"if sf probe ; then "					\
+		"sf read ${loadaddr} ${sf_kernel_offset} ${sf_swu_size} ; "	\
 		"setenv bootargs root=/dev/ram0 rw ; "			\
 		"run addargs ; "					\
-		"bootm ${loadaddr} ${rdaddr} ; "		\
+		"bootm ${loadaddr} ; "					\
 		"fi\0"							\
 	"net_mmc="							\
 		"if run netload mmcargs addargs ; then "		\
-- 
2.39.2

