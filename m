Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF720C54FB3
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 13:26:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22ECB887B4;
	Wed, 28 Aug 2024 15:26:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JfTiB2W5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F456888AA; Wed, 28 Aug 2024 15:26:03 +0200 (CEST)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7F1E8884F
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 15:26:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-7cd8d2731d1so4443224a12.3
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 06:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724851559; x=1725456359; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jfPiL2GqPzk9ltPN5Lg107H1L8mobP+Vrgs4P0kqAc0=;
 b=JfTiB2W5ALAyX6hAWYjU3CgfFIz+Yr/2R2gXG2zYwdl+lMd+2OnTPj9TWopQWs/Yg/
 yNp2jr8SNFt4sESF49uJkc8xl7TBePuBSVnToGg1ho8n6UfylDzNp+dlZPEdrmbPVv0J
 j/7wL59gmv+mwfztbU3PhN5GBHpkGq+NjmjCDC5BHXypAdoSWN/Zp8PQTSP/C4YYAQcz
 LB8tVlnuc1IFsoMc7gro0PidPytLsFe/iDBhMU8tUlHfJTAjHIqr1Jx8K93hla2TODPa
 FZBWyWYYBF7DJATHb2UCEalIH4tuqcwikd+zldRYIJ9MSE96jfIqu/PRMbLdYhHGhn7E
 XDTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724851559; x=1725456359;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jfPiL2GqPzk9ltPN5Lg107H1L8mobP+Vrgs4P0kqAc0=;
 b=VWbGAayJ1ZvJbHJ8G7A1M3zwHF1N/jYjxLQ9jV9g2PMAWnWbY+kfpQpYVUBG4sr02B
 WQMib0Dqp+x+XB0TL+nqCcf2TkaFtlOArZmECat4nWvj3PiWx4ocOo1b9IT0Hh3qTuwS
 g95mQHwGkWRK/H+aqUb8Wu6oF83bvS3M+kKJv3Kjl7H1VUoUd6t1EvsJNgbAdaO2+gYV
 X8eGb3uVyyUIkC5ZF1N9EoDniXKo7o+u9EmAGsWMZvwEFXmFDWptYpVCfCq0+7y3c8YL
 WqYUbpIbHNo9Oq1ZxkGaK7dfO8TQ5Tx2jwIrBXB/nEE/wlKA7u3BDj6DNtmyJ4MqR9OD
 P1xQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZSF7mCYwlRzAwGNUATq1OvLjQ1ndyYbxkgpYWihMJpBQU1hgrvunjv9afGkgEwmuN2zowzlc=@lists.denx.de
X-Gm-Message-State: AOJu0Yz5yaI/1WkLO1MHdDSQsNE4O/EWNGPrQKZDOI8m/GM9fhuDQCts
 sGk0j/HI1kZ71v+lhkFGsnz7IMlC9VRIRHTANwnmSDmcxjU5EHjs
X-Google-Smtp-Source: AGHT+IGvcjqpbEeFGkp/gmBKnplfGb5N2TIXZFXdsm0DoGywLRIDCUVPvFxjP0788bQifcJIKHnwzw==
X-Received: by 2002:a17:90a:6341:b0:2d3:c34e:2fda with SMTP id
 98e67ed59e1d1-2d646bcd3b5mr16397809a91.14.1724851558752; 
 Wed, 28 Aug 2024 06:25:58 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:4b3a:557e:6b5b:dbdc])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d844617777sm1788660a91.24.2024.08.28.06.25.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 06:25:58 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: peng.fan@nxp.com
Cc: marex@denx.de, u-boot@lists.denx.de, tharvey@gateworks.com, smoch@web.de,
 Fabio Estevam <festevam@denx.de>
Subject: [PATCH v3 1/4] imx: Remove CFG_MXC_USB_FLAGS
Date: Wed, 28 Aug 2024 10:25:26 -0300
Message-Id: <20240828132529.3098961-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Fabio Estevam <festevam@denx.de>

CFG_MXC_USB_FLAGS is only used for drivers/usb/host/ehci-mx5.c, so it
can be removed from all the imx6/imx7/imx8m board config files.

mx51evk.h is the only place CFG_MXC_USB_FLAGS is not set to 0.

Suggested-by: Tim Harvey <tharvey@gateworks.com>
Signed-off-by: Fabio Estevam <festevam@denx.de>
Reviewed-by: Marek Vasut <marex@denx.de>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
Changes since v2:
- None.

 include/configs/apalis_imx6.h            | 1 -
 include/configs/aristainetos2.h          | 1 -
 include/configs/cl-som-imx7.h            | 1 -
 include/configs/cm_fx6.h                 | 1 -
 include/configs/colibri-imx6ull.h        | 1 -
 include/configs/colibri_imx6.h           | 1 -
 include/configs/colibri_imx7.h           | 1 -
 include/configs/dart_6ul.h               | 1 -
 include/configs/dh_imx6.h                | 1 -
 include/configs/embestmx6boards.h        | 1 -
 include/configs/ge_b1x5v2.h              | 1 -
 include/configs/gw_ventana.h             | 1 -
 include/configs/imx6_logic.h             | 1 -
 include/configs/imx6dl-mamoj.h           | 1 -
 include/configs/imx6q-bosch-acc.h        | 1 -
 include/configs/kontron-sl-mx6ul.h       | 1 -
 include/configs/kontron-sl-mx8mm.h       | 1 -
 include/configs/kp_imx53.h               | 1 -
 include/configs/kp_imx6q_tpc.h           | 1 -
 include/configs/liteboard.h              | 1 -
 include/configs/m53menlo.h               | 1 -
 include/configs/mx53cx9020.h             | 1 -
 include/configs/mx53loco.h               | 1 -
 include/configs/mx53ppd.h                | 1 -
 include/configs/mx6sabreauto.h           | 1 -
 include/configs/mx6sabresd.h             | 1 -
 include/configs/mx6slevk.h               | 1 -
 include/configs/mx6sxsabreauto.h         | 1 -
 include/configs/mx6sxsabresd.h           | 1 -
 include/configs/mx6ul_14x14_evk.h        | 1 -
 include/configs/mys_6ulx.h               | 1 -
 include/configs/nitrogen6x.h             | 1 -
 include/configs/novena.h                 | 1 -
 include/configs/npi_imx6ull.h            | 1 -
 include/configs/opos6uldev.h             | 1 -
 include/configs/pcl063.h                 | 1 -
 include/configs/pcl063_ull.h             | 1 -
 include/configs/pico-imx6.h              | 1 -
 include/configs/pico-imx6ul.h            | 1 -
 include/configs/pico-imx7d.h             | 1 -
 include/configs/somlabs_visionsom_6ull.h | 1 -
 include/configs/usbarmory.h              | 1 -
 include/configs/vining_2000.h            | 1 -
 include/configs/wandboard.h              | 1 -
 include/configs/xpress.h                 | 1 -
 45 files changed, 45 deletions(-)

diff --git a/include/configs/apalis_imx6.h b/include/configs/apalis_imx6.h
index 6fd43511ee4..097f819e44a 100644
--- a/include/configs/apalis_imx6.h
+++ b/include/configs/apalis_imx6.h
@@ -26,7 +26,6 @@
 /* USB Configs */
 /* Host */
 #define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS		0
 
 /* Framebuffer and LCD */
 
diff --git a/include/configs/aristainetos2.h b/include/configs/aristainetos2.h
index 9d4a4bbdf43..120ff9284ef 100644
--- a/include/configs/aristainetos2.h
+++ b/include/configs/aristainetos2.h
@@ -413,7 +413,6 @@
 
 /* USB Configs */
 #define CFG_MXC_USB_PORTSC	(PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS	0
 
 /* UBI support */
 
diff --git a/include/configs/cl-som-imx7.h b/include/configs/cl-som-imx7.h
index 280ae1e9cca..96058d48148 100644
--- a/include/configs/cl-som-imx7.h
+++ b/include/configs/cl-som-imx7.h
@@ -97,6 +97,5 @@
 
 /* USB Configs */
 #define CFG_MXC_USB_PORTSC  (PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS   0
 
 #endif	/* __CONFIG_H */
diff --git a/include/configs/cm_fx6.h b/include/configs/cm_fx6.h
index 7d0f2b6dc13..fc2d59751c4 100644
--- a/include/configs/cm_fx6.h
+++ b/include/configs/cm_fx6.h
@@ -136,7 +136,6 @@
 
 /* USB */
 #define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS		0
 
 /* Boot */
 #define CFG_SYS_BOOTMAPSZ	        (8 << 20)
diff --git a/include/configs/colibri-imx6ull.h b/include/configs/colibri-imx6ull.h
index 8860ceec1a0..c896a897cbf 100644
--- a/include/configs/colibri-imx6ull.h
+++ b/include/configs/colibri-imx6ull.h
@@ -120,7 +120,6 @@
 /* USB Configs */
 
 #define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS		0
 
 /* USB Device Firmware Update support */
 #define DFU_DEFAULT_POLL_TIMEOUT	300
diff --git a/include/configs/colibri_imx6.h b/include/configs/colibri_imx6.h
index 79e5b870b81..87c973883c3 100644
--- a/include/configs/colibri_imx6.h
+++ b/include/configs/colibri_imx6.h
@@ -24,7 +24,6 @@
 /* USB Configs */
 /* Host */
 #define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS		0
 
 /* Command definition */
 
diff --git a/include/configs/colibri_imx7.h b/include/configs/colibri_imx7.h
index 33133a0b96e..0e0665038b1 100644
--- a/include/configs/colibri_imx7.h
+++ b/include/configs/colibri_imx7.h
@@ -162,6 +162,5 @@
 /* USB Configs */
 
 #define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS		0
 
 #endif
diff --git a/include/configs/dart_6ul.h b/include/configs/dart_6ul.h
index c5781670864..4d715d4f425 100644
--- a/include/configs/dart_6ul.h
+++ b/include/configs/dart_6ul.h
@@ -48,7 +48,6 @@
 
 /* USB Configs */
 #define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS		0
 
 #define ENV_MMC \
 	"mmcdev=" __stringify(MMC_ROOTFS_DEV) "\0" \
diff --git a/include/configs/dh_imx6.h b/include/configs/dh_imx6.h
index 4b5ef4ad510..dc5ca9fc60c 100644
--- a/include/configs/dh_imx6.h
+++ b/include/configs/dh_imx6.h
@@ -32,7 +32,6 @@
 
 /* USB Configs */
 #define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS		0
 
 /* USB Gadget (DFU, UMS) */
 #if defined(CONFIG_CMD_DFU) || defined(CONFIG_CMD_USB_MASS_STORAGE)
diff --git a/include/configs/embestmx6boards.h b/include/configs/embestmx6boards.h
index 31c7e104f6b..e378374a004 100644
--- a/include/configs/embestmx6boards.h
+++ b/include/configs/embestmx6boards.h
@@ -19,7 +19,6 @@
 
 /* USB Configs */
 #define CFG_MXC_USB_PORTSC	(PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS	0
 
 /* MMC Configs */
 #define CFG_SYS_FSL_ESDHC_ADDR      0
diff --git a/include/configs/ge_b1x5v2.h b/include/configs/ge_b1x5v2.h
index 49b058cb10d..0bf31897a74 100644
--- a/include/configs/ge_b1x5v2.h
+++ b/include/configs/ge_b1x5v2.h
@@ -25,7 +25,6 @@
 
 /* USB */
 #define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS		0
 
 /* Memory */
 #define PHYS_SDRAM		       MMDC0_ARB_BASE_ADDR
diff --git a/include/configs/gw_ventana.h b/include/configs/gw_ventana.h
index ebc5d03d0d5..f884d74d9ca 100644
--- a/include/configs/gw_ventana.h
+++ b/include/configs/gw_ventana.h
@@ -37,7 +37,6 @@
 
 /* USB Configs */
 #define CFG_MXC_USB_PORTSC     (PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS      0
 
 /* Miscellaneous configurable options */
 
diff --git a/include/configs/imx6_logic.h b/include/configs/imx6_logic.h
index 66004a6eb2a..19613e838fb 100644
--- a/include/configs/imx6_logic.h
+++ b/include/configs/imx6_logic.h
@@ -117,7 +117,6 @@
 /* USB Configs */
 #ifdef CONFIG_CMD_USB
 #define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS		0
 #endif
 
 /* Falcon Mode */
diff --git a/include/configs/imx6dl-mamoj.h b/include/configs/imx6dl-mamoj.h
index 6c61b3f4480..6651653d5e9 100644
--- a/include/configs/imx6dl-mamoj.h
+++ b/include/configs/imx6dl-mamoj.h
@@ -44,7 +44,6 @@
 
 /* USB */
 #define CFG_MXC_USB_PORTSC			(PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS			0
 
 /* Falcon */
 
diff --git a/include/configs/imx6q-bosch-acc.h b/include/configs/imx6q-bosch-acc.h
index 2c998cdcfc7..aa365dc9a79 100644
--- a/include/configs/imx6q-bosch-acc.h
+++ b/include/configs/imx6q-bosch-acc.h
@@ -111,6 +111,5 @@
 #endif
 
 #define CFG_MXC_USB_PORTSC            (PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS             0
 
 #endif /* __IMX6Q_ACC_H */
diff --git a/include/configs/kontron-sl-mx6ul.h b/include/configs/kontron-sl-mx6ul.h
index 1c92cd78767..e68c667c505 100644
--- a/include/configs/kontron-sl-mx6ul.h
+++ b/include/configs/kontron-sl-mx6ul.h
@@ -26,7 +26,6 @@
 
 #ifdef CONFIG_USB_EHCI_HCD
 #define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS		0
 #endif
 
 /* Boot order for distro boot */
diff --git a/include/configs/kontron-sl-mx8mm.h b/include/configs/kontron-sl-mx8mm.h
index eee3d2ddb03..be1f70a9a59 100644
--- a/include/configs/kontron-sl-mx8mm.h
+++ b/include/configs/kontron-sl-mx8mm.h
@@ -26,7 +26,6 @@
 
 #ifdef CONFIG_USB_EHCI_HCD
 #define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS		0
 #endif
 
 /* GUID for capsule updatable firmware image */
diff --git a/include/configs/kp_imx53.h b/include/configs/kp_imx53.h
index 6e383cbe75f..91caf03091c 100644
--- a/include/configs/kp_imx53.h
+++ b/include/configs/kp_imx53.h
@@ -12,7 +12,6 @@
 
 /* USB Configs */
 #define CFG_MXC_USB_PORTSC	(PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS	0
 
 /* Command definition */
 
diff --git a/include/configs/kp_imx6q_tpc.h b/include/configs/kp_imx6q_tpc.h
index 1aa4b8ab598..74f6e4e9f96 100644
--- a/include/configs/kp_imx6q_tpc.h
+++ b/include/configs/kp_imx6q_tpc.h
@@ -19,7 +19,6 @@
 /* USB Configs */
 #ifdef CONFIG_CMD_USB
 #define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS		0
 #endif
 
 #define CFG_EXTRA_ENV_SETTINGS	\
diff --git a/include/configs/liteboard.h b/include/configs/liteboard.h
index 5811059c8e2..25c30e6c6a5 100644
--- a/include/configs/liteboard.h
+++ b/include/configs/liteboard.h
@@ -96,7 +96,6 @@
 /* USB Configs */
 #ifdef CONFIG_CMD_USB
 #define CFG_MXC_USB_PORTSC  (PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS   0
 #endif
 
 #ifdef CONFIG_CMD_NET
diff --git a/include/configs/m53menlo.h b/include/configs/m53menlo.h
index 9cf46b2c362..1491c509820 100644
--- a/include/configs/m53menlo.h
+++ b/include/configs/m53menlo.h
@@ -72,7 +72,6 @@
 #ifdef CONFIG_CMD_USB
 #define CFG_MXC_USB_PORT		1
 #define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS		0
 #endif
 
 /* LVDS display */
diff --git a/include/configs/mx53cx9020.h b/include/configs/mx53cx9020.h
index dccfdc3a15d..ab6b0b65556 100644
--- a/include/configs/mx53cx9020.h
+++ b/include/configs/mx53cx9020.h
@@ -24,7 +24,6 @@
 /* USB Configs */
 #define CFG_MXC_USB_PORT	1
 #define CFG_MXC_USB_PORTSC	(PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS	0
 
 /* Command definition */
 
diff --git a/include/configs/mx53loco.h b/include/configs/mx53loco.h
index 7398804e6b5..04f4b723209 100644
--- a/include/configs/mx53loco.h
+++ b/include/configs/mx53loco.h
@@ -19,7 +19,6 @@
 /* USB Configs */
 #define CFG_MXC_USB_PORT	1
 #define CFG_MXC_USB_PORTSC	(PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS	0
 
 /* PMIC Controller */
 #define CFG_SYS_DIALOG_PMIC_I2C_ADDR	0x48
diff --git a/include/configs/mx53ppd.h b/include/configs/mx53ppd.h
index df65dbeea41..3c9a9fb045b 100644
--- a/include/configs/mx53ppd.h
+++ b/include/configs/mx53ppd.h
@@ -14,7 +14,6 @@
 /* USB Configs */
 #define CFG_MXC_USB_PORT	1
 #define CFG_MXC_USB_PORTSC	(PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS	0
 
 /* Command definition */
 
diff --git a/include/configs/mx6sabreauto.h b/include/configs/mx6sabreauto.h
index 91544c8a0e2..eb963cbb0b3 100644
--- a/include/configs/mx6sabreauto.h
+++ b/include/configs/mx6sabreauto.h
@@ -13,7 +13,6 @@
 
 /* USB Configs */
 #define CFG_MXC_USB_PORTSC	(PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS	0
 
 #define CFG_SYS_I2C_PCA953X_WIDTH	{ {0x30, 8}, {0x32, 8}, {0x34, 8} }
 
diff --git a/include/configs/mx6sabresd.h b/include/configs/mx6sabresd.h
index 844f10e4229..9160f878f4b 100644
--- a/include/configs/mx6sabresd.h
+++ b/include/configs/mx6sabresd.h
@@ -27,7 +27,6 @@
 /* USB Configs */
 #ifdef CONFIG_CMD_USB
 #define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS		0
 #endif
 
 #endif                         /* __MX6SABRESD_CONFIG_H */
diff --git a/include/configs/mx6slevk.h b/include/configs/mx6slevk.h
index 490d9feb805..65c6cdd4b87 100644
--- a/include/configs/mx6slevk.h
+++ b/include/configs/mx6slevk.h
@@ -91,7 +91,6 @@
 /* USB Configs */
 #ifdef CONFIG_CMD_USB
 #define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS		0
 #endif
 
 #define CFG_SYS_FSL_USDHC_NUM	3
diff --git a/include/configs/mx6sxsabreauto.h b/include/configs/mx6sxsabreauto.h
index 1c14a6beb0a..4e163d28e63 100644
--- a/include/configs/mx6sxsabreauto.h
+++ b/include/configs/mx6sxsabreauto.h
@@ -97,7 +97,6 @@
 
 #ifdef CONFIG_CMD_USB
 #define CFG_MXC_USB_PORTSC  (PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS   0
 #endif
 
 #define CFG_SYS_FSL_USDHC_NUM	2
diff --git a/include/configs/mx6sxsabresd.h b/include/configs/mx6sxsabresd.h
index fe0ad34ef9c..b43a1d81315 100644
--- a/include/configs/mx6sxsabresd.h
+++ b/include/configs/mx6sxsabresd.h
@@ -119,7 +119,6 @@
 
 #ifdef CONFIG_CMD_USB
 #define CFG_MXC_USB_PORTSC  (PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS   0
 #endif
 
 #ifdef CONFIG_CMD_PCI
diff --git a/include/configs/mx6ul_14x14_evk.h b/include/configs/mx6ul_14x14_evk.h
index 98b743b9364..fd0c87ffb01 100644
--- a/include/configs/mx6ul_14x14_evk.h
+++ b/include/configs/mx6ul_14x14_evk.h
@@ -117,7 +117,6 @@
 /* USB Configs */
 #ifdef CONFIG_CMD_USB
 #define CFG_MXC_USB_PORTSC  (PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS   0
 #endif
 
 #ifdef CONFIG_CMD_NET
diff --git a/include/configs/mys_6ulx.h b/include/configs/mys_6ulx.h
index 2571098d06c..8defdfc4fda 100644
--- a/include/configs/mys_6ulx.h
+++ b/include/configs/mys_6ulx.h
@@ -31,7 +31,6 @@
 
 /* USB Configs */
 #define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS		0
 
 #define CFG_EXTRA_ENV_SETTINGS \
 	"console=ttymxc0,115200n8\0" \
diff --git a/include/configs/nitrogen6x.h b/include/configs/nitrogen6x.h
index c03d11dcdae..a8ad85050f7 100644
--- a/include/configs/nitrogen6x.h
+++ b/include/configs/nitrogen6x.h
@@ -20,7 +20,6 @@
 
 /* USB Configs */
 #define CFG_MXC_USB_PORTSC	(PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS	0
 
 #ifdef CONFIG_CMD_MMC
 #define DISTRO_BOOT_DEV_MMC(func) func(MMC, mmc, 0) func(MMC, mmc, 1)
diff --git a/include/configs/novena.h b/include/configs/novena.h
index 39d3afd1c8e..144cf1b4a4b 100644
--- a/include/configs/novena.h
+++ b/include/configs/novena.h
@@ -54,7 +54,6 @@
 /* USB Configs */
 #ifdef CONFIG_CMD_USB
 #define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS		0
 #endif
 
 /* Extra U-Boot environment. */
diff --git a/include/configs/npi_imx6ull.h b/include/configs/npi_imx6ull.h
index 5f933391cc0..f71e2657076 100644
--- a/include/configs/npi_imx6ull.h
+++ b/include/configs/npi_imx6ull.h
@@ -30,7 +30,6 @@
 
 /* USB Configs */
 #define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS		0
 
 #ifdef CONFIG_CMD_NET
 #define CFG_FEC_MXC_PHYADDR		0x1
diff --git a/include/configs/opos6uldev.h b/include/configs/opos6uldev.h
index 1edb1826c4e..12020d31e1c 100644
--- a/include/configs/opos6uldev.h
+++ b/include/configs/opos6uldev.h
@@ -20,7 +20,6 @@
 /* USB */
 #ifdef CONFIG_USB_EHCI_MX6
 #define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS		0
 #endif
 
 /* LCD */
diff --git a/include/configs/pcl063.h b/include/configs/pcl063.h
index 38dcee05359..2a729c3e454 100644
--- a/include/configs/pcl063.h
+++ b/include/configs/pcl063.h
@@ -43,7 +43,6 @@
 
 /* USB Configs */
 #define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS		0
 
 #define CFG_EXTRA_ENV_SETTINGS \
 	"console=ttymxc0,115200n8\0" \
diff --git a/include/configs/pcl063_ull.h b/include/configs/pcl063_ull.h
index d742201ce43..afa8e7aeb71 100644
--- a/include/configs/pcl063_ull.h
+++ b/include/configs/pcl063_ull.h
@@ -45,7 +45,6 @@
 
 /* USB Configs */
 #define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS		0
 
 #define ENV_MMC \
 	"mmcdev=" __stringify(MMC_ROOTFS_DEV) "\0" \
diff --git a/include/configs/pico-imx6.h b/include/configs/pico-imx6.h
index d806d7d9c57..6ccb3dc1902 100644
--- a/include/configs/pico-imx6.h
+++ b/include/configs/pico-imx6.h
@@ -17,7 +17,6 @@
 
 /* USB Configs */
 #define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS		0
 
 #define DFU_DEFAULT_POLL_TIMEOUT 300
 
diff --git a/include/configs/pico-imx6ul.h b/include/configs/pico-imx6ul.h
index 8a22f0134b3..ef8281440e5 100644
--- a/include/configs/pico-imx6ul.h
+++ b/include/configs/pico-imx6ul.h
@@ -23,7 +23,6 @@
 
 /* USB Configs */
 #define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS		0
 
 #define DFU_DEFAULT_POLL_TIMEOUT 300
 
diff --git a/include/configs/pico-imx7d.h b/include/configs/pico-imx7d.h
index e7a8cb20dff..21ec7fd3362 100644
--- a/include/configs/pico-imx7d.h
+++ b/include/configs/pico-imx7d.h
@@ -107,6 +107,5 @@
 
 /* USB Configs */
 #define CFG_MXC_USB_PORTSC			(PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS			0
 
 #endif
diff --git a/include/configs/somlabs_visionsom_6ull.h b/include/configs/somlabs_visionsom_6ull.h
index 041a83b057d..aa09528acd9 100644
--- a/include/configs/somlabs_visionsom_6ull.h
+++ b/include/configs/somlabs_visionsom_6ull.h
@@ -62,7 +62,6 @@
 /* USB Configs */
 #ifdef CONFIG_CMD_USB
 #define CFG_MXC_USB_PORTSC  (PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS   0
 #endif
 
 #ifdef CONFIG_CMD_NET
diff --git a/include/configs/usbarmory.h b/include/configs/usbarmory.h
index 27e61f5b8f4..28d86a26362 100644
--- a/include/configs/usbarmory.h
+++ b/include/configs/usbarmory.h
@@ -25,7 +25,6 @@
 /* USB */
 #define CFG_MXC_USB_PORT	1
 #define CFG_MXC_USB_PORTSC	(PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS	0
 
 /* Linux boot */
 
diff --git a/include/configs/vining_2000.h b/include/configs/vining_2000.h
index 30654191a26..3c2d7e66891 100644
--- a/include/configs/vining_2000.h
+++ b/include/configs/vining_2000.h
@@ -37,7 +37,6 @@
 #define CFG_FEC_MXC_PHYADDR          0x0
 
 #define CFG_MXC_USB_PORTSC  (PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS   0
 
 #ifdef CONFIG_CMD_PCI
 #define CFG_PCIE_IMX_PERST_GPIO	IMX_GPIO_NR(4, 6)
diff --git a/include/configs/wandboard.h b/include/configs/wandboard.h
index 7b8c5cbe7a8..d64c4262bd6 100644
--- a/include/configs/wandboard.h
+++ b/include/configs/wandboard.h
@@ -18,7 +18,6 @@
 
 /* USB Configs */
 #define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS		0
 
 #define CFG_EXTRA_ENV_SETTINGS \
 	"console=ttymxc0\0" \
diff --git a/include/configs/xpress.h b/include/configs/xpress.h
index a2aa31008ec..bb0a30c4344 100644
--- a/include/configs/xpress.h
+++ b/include/configs/xpress.h
@@ -29,7 +29,6 @@
 
 /* USB Configs */
 #define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS		0
 
 #define CFG_FEC_ENET_DEV		0
 #define CFG_FEC_MXC_PHYADDR          0x0
-- 
2.34.1

