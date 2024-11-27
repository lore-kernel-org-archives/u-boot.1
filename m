Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD5BD6ACC5
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 12:33:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 472FF897E2;
	Wed, 27 Nov 2024 13:33:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="MsiF+zkj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0032489430; Wed, 27 Nov 2024 11:30:32 +0100 (CET)
Received: from mx3.securetransport.de (mx3.securetransport.de [116.203.31.6])
 by phobos.denx.de (Postfix) with ESMTP id 4149C897B2
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 11:30:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pzimmermann@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1732703419;
 bh=cA1cXJf53G81knR0v8ym1GNSSox9EhDy449dxZ7Z938=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=MsiF+zkjfQhCMe93+H8M9ueT+3kAxrhOgnGa/6+H3NGpDG/VvGpIearoZC9b+VAFo
 YOXly/OjsEjcT2TNZwc3tZ9VNehwaMp7qZoqlKuHvKM1QdPQ60fUSvHK8WW8WDQ5YP
 olEDTG9fGV5wYEyv5Kh/JGuu5y0j2Y3jBvz4WVsz6yEkkJ+aRN68/kuPaF4PyArBOG
 yw4EqKFAPx7gKCLOWPZDZl057bPZ3ESnhw6DFuQsm23JsgHbIkNFIG3+40d2fbwBs4
 c4GR9Q6rlX/nhEZZiDNyiuq0loHRGz96Y4kwIXmdRRduAtXOtezPBv6TrfNyfTP+Z6
 oHSozwQiIet+w==
From: Pascal Zimmermann <pzimmermann@dh-electronics.com>
To: <u-boot@lists.denx.de>
CC: Pascal Zimmermann <pzimmermann@dh-electronics.com>, Marek Vasut
 <marex@denx.de>, Patrick Delaunay <patrick.delaunay@foss.st.com>, Patrice
 Chotard <patrice.chotard@foss.st.com>, Tom Rini <trini@konsulko.com>, Simon
 Glass <sjg@chromium.org>, <u-boot@dh-electronics.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH 2/2] ARM: stm32: env: Enable scan and start for AB schema on
 STM32MP15 DHSOM
Date: Wed, 27 Nov 2024 11:29:24 +0100
Message-ID: <20241127102924.7652-3-pzimmermann@dh-electronics.com>
X-klartext: yes
In-Reply-To: <20241127102924.7652-1-pzimmermann@dh-electronics.com>
References: <20241127102924.7652-1-pzimmermann@dh-electronics.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Wed, 27 Nov 2024 13:32:59 +0100
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

For the STM32MP15 DHSOM, change the default environment so an AB schema
on a device can be detected.

For this the define "SCAN_DEV_FOR_BOOT_PARTS" is overwritten and
appended.

The detection works by looking for the partitions with specific lables.
The name of those partitions are in the variables and its defaults:
* dh_ab_partname_primary=rootfs-a
* dh_ab_partname_secondary=rootfs-b

To prevent being hanging at bootcmd, enable "CONFIG_BOOT_RETRY" and
"CONFIG_RESET_TO_RETRY", but the timer will only be activated, if the AB
partitions are detected.

Signed-off-by: Pascal Zimmermann <pzimmermann@dh-electronics.com>
---
Cc: Marek Vasut <marex@denx.de>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: u-boot@dh-electronics.com
Cc: uboot-stm32@st-md-mailman.stormreply.com
Cc: u-boot@lists.denx.de
---
 configs/stm32mp15_dhsom.config       |  3 +++
 include/configs/stm32mp15_dh_dhsom.h | 33 ++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/configs/stm32mp15_dhsom.config b/configs/stm32mp15_dhsom.config
index efc149577e..22d8bd3241 100644
--- a/configs/stm32mp15_dhsom.config
+++ b/configs/stm32mp15_dhsom.config
@@ -10,6 +10,9 @@ CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_BOARD_SIZE_LIMIT=1441792
 CONFIG_BOOTCOUNT_BOOTLIMIT=3
 CONFIG_BOOTDELAY=1
+CONFIG_BOOTRETRY=y
+CONFIG_RESET_TO_RETRY=y
+CONFIG_BOOT_RETRY_TIME=-1
 CONFIG_CMD_ADC=y
 CONFIG_CMD_REMOTEPROC=y
 CONFIG_CMD_STBOARD=y
diff --git a/include/configs/stm32mp15_dh_dhsom.h b/include/configs/stm32mp15_dh_dhsom.h
index c004a8cec8..267e344677 100644
--- a/include/configs/stm32mp15_dh_dhsom.h
+++ b/include/configs/stm32mp15_dh_dhsom.h
@@ -17,7 +17,40 @@
 			" 0x800000\0"
 #endif
 
+/* Add the search for AB partitons */
+#define SCAN_DEV_FOR_BOOT_PARTS						\
+	"run dh_check_if_ab; "						\
+	"if test -z \"${devplist}\"; "					\
+		"then "							\
+		"part list ${devtype} ${devnum} -bootable devplist; "	\
+	"fi; "
+
 #define STM32MP_BOARD_EXTRA_ENV						\
+	"altbootcmd= "							\
+	"setenv dh_ab_get_partnames "					\
+		"'setenv dh_ab_partnames ${dh_ab_partname_secondary} "	\
+			"${dh_ab_partname_primary}' && "		\
+		"run bootcmd\0"						\
+	"dh_check_if_ab= " /* Sets devplist if AB partitions*/		\
+		"echo test for AB on ${devtype} ${devnum} && "		\
+		"run dh_ab_get_partnames && "				\
+		"setenv devplist && "					\
+		"for partname in ${dh_ab_partnames}; do "		\
+			"setenv partnum && "				\
+			"if part number ${devtype} ${devnum} ${partname} partnum; "\
+				"then "					\
+				"setenv devplist \"${devplist} ${partnum}\" && "\
+				"setenv bootretry 60 ;"			\
+			"fi; "						\
+		"done ; "						\
+		"if test -n \"${devplist}\"; "				\
+			"then echo AB partitions found! ; "		\
+		"fi\0"							\
+	"dh_ab_get_partnames= " /* Sets dh_ab_partnames */		\
+		"setenv dh_ab_partnames ${dh_ab_partname_primary} "	\
+			"${dh_ab_partname_secondary}\0"			\
+	"dh_ab_partname_primary=rootfs-a\0" /* Names of AB partitions */\
+	"dh_ab_partname_secondary=rootfs-b\0"				\
 	"dh_preboot="							\
 		"run dh_testbench_backward_compat\0"			\
 	"dh_update_sd_to_emmc=" /* Install U-Boot from SD to eMMC */	\
-- 
2.30.2

