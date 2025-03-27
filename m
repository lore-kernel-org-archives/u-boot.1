Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 544B8C3600B
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 02:21:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E802B81DCC;
	Fri, 28 Mar 2025 03:20:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="jv2GBS7i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6DA681879; Thu, 27 Mar 2025 15:39:47 +0100 (CET)
Received: from mx3.securetransport.de (mx3.securetransport.de [116.203.31.6])
 by phobos.denx.de (Postfix) with ESMTP id 8A0E08003E
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 15:39:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pzimmermann@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1743086361;
 bh=ryNOVqpTNu93VBGteovgRdMyZTJpLMjaxdzjFOAuSco=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=jv2GBS7iO4kw99RM+3DCx1FRpjGbUWV5LnzkBNrk+oJtXyZYvgNTF4Sofq0RsRXBp
 VLQWb2CfOtRZrjN4c7/QwDABPannBnfM3/AaAse9Wfgznv4gsKZoON8TgMVz8arSFZ
 5uGfCOf4mXwzGcGHPhQuJe43NCu4qdo/UNcxe5d5jx1N/SKXW7M4n2hKnGalFRTb3R
 IGsn/DASV6Ldl8XWC+zAlhL1lbV2Pw5YKclHMRxXLmfdSYFrQkPQPFcfz3zYciBbrn
 cGPlcrvT2icJQDLzzgrZY04Lr4Nn5QvP/m0wk6IXFcb2BsqCg2J9mwWkzntLP0XWx7
 EOuhWlVFm+alw==
From: Pascal Zimmermann <pzimmermann@dh-electronics.com>
To: <u-boot@lists.denx.de>
CC: Pascal Zimmermann <pzimmermann@dh-electronics.com>, Marek Vasut
 <marex@denx.de>, Patrick Delaunay <patrick.delaunay@foss.st.com>, Patrice
 Chotard <patrice.chotard@foss.st.com>, Tom Rini <trini@konsulko.com>, Simon
 Glass <sjg@chromium.org>, <u-boot@dh-electronics.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
Subject: [RESEND PATCH 2/2] ARM: stm32: env: Enable scan and start for AB
 schema on STM32MP15 DHSOM
Date: Thu, 27 Mar 2025 15:38:43 +0100
Message-ID: <20250327143843.19358-3-pzimmermann@dh-electronics.com>
X-klartext: yes
In-Reply-To: <20250327143843.19358-1-pzimmermann@dh-electronics.com>
References: <20250327143843.19358-1-pzimmermann@dh-electronics.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Fri, 28 Mar 2025 03:20:27 +0100
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
index 7e5b5aa67ef..c84116482f6 100644
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
index c004a8cec82..267e3446779 100644
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

