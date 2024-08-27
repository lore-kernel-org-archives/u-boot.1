Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D86DC5472D
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 00:58:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E45C884DB;
	Tue, 27 Aug 2024 02:58:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a0QXzvFh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26B12888B4; Tue, 27 Aug 2024 02:58:40 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8118888387
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 02:58:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-27032e6dbf2so3275678fac.1
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 17:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724720316; x=1725325116; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eOadqJhN3ff75fXzh2EDIu+u8GnlkoDhvnS9H3WOoDo=;
 b=a0QXzvFhjDnrgweHGTCIvhzYNbUY0+AJwLZWj+BvY5qVaZ3FPmtfDKEJXWjXpeLxXb
 GI1QEazPhJGFTaviGZ1pwNAKplN/Pqw3VO0mEBnUkutTL5wH65roOktpkQ7Cq3hBTHJ+
 BYmyj2SIM8pt6oovzQ4jAp2t+cREgDljpcUHjb8A7dOOUxLjVNOOYNp2/iupu+9YRC70
 +vp1hjSjivEjS5ZsxfRT4xtwFXO1XxTo4e5J/GbwV8NADuhaPP08bcj+EE3NGSJoMsj8
 gm8jvcf2XCXD8eYf780Lt8vmajnrpXze+RySK5XJjilewpzJFmhYzwEK9ndo3s5UjdOs
 u+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724720316; x=1725325116;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eOadqJhN3ff75fXzh2EDIu+u8GnlkoDhvnS9H3WOoDo=;
 b=YOhbd+krjtWyRyZnUMrzM78xWBWJuH/7Jw00qPzCrYEuG6gAngsvUE7OA5mj0EyEIp
 FdG4aBFnees/06wh4EFtP5MuJ6ayrXbxlEc/1XK7oNjJImaO229E4GwDM/ZdEI42VUuA
 GTrNkeXy8y4mjwb3tCJ1k7P5m/CiMPo5jRYDJcdIUS9qwDl/qok2j85M32Quei/wy8Gi
 RL8PKfvV0HiDbHpDbDcDNJd55B7gDiZzTCXFkxvJ83eN59mScVpSK7gsEVtHGnyWZSk2
 WJz73kJ5QF4YleLWFeZsE5vvPjyoaisqpXQWPiKLs0Q+njaL2UcLiGcp38wDrEzWbqR+
 OhBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXptEWDr/C3EjxLFhnUFNsIA2h5cAj8WZc2HMfcD+XKNieBX+Jk754etDo90tSAvr52cHqBBb8=@lists.denx.de
X-Gm-Message-State: AOJu0YyhD4kCbu67Yfxf9rj9cYRWXb/+D218Kax3QM1R8GlMhc+IUaZV
 X6WrGrE8Y7ssffaDBfFBhVUZyEXluxAp75fdT+b4vXonAOCJAHBZ
X-Google-Smtp-Source: AGHT+IE/lzZeozdShRul0gMqdMAVZw+/gmSWCi9UGrp4O2K3gzMSqQT0H6pmsyn8UqTyDSxXntIRuw==
X-Received: by 2002:a05:6870:4713:b0:260:f75c:c28b with SMTP id
 586e51a60fabf-273e646d7a8mr12541778fac.8.1724720315896; 
 Mon, 26 Aug 2024 17:58:35 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:bc67:f2c3:ca16:906f])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71434254057sm7560311b3a.77.2024.08.26.17.58.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 17:58:35 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: peng.fan@nxp.com
Cc: marex@denx.de, u-boot@lists.denx.de, tharvey@gateworks.com,
 Fabio Estevam <festevam@denx.de>
Subject: [PATCH 1/3] imx: Remove CFG_MXC_USB_FLAGS
Date: Mon, 26 Aug 2024 21:58:23 -0300
Message-Id: <20240827005826.2831478-1-festevam@gmail.com>
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
---
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
index 6fd43511ee4d..097f819e44a4 100644
--- a/include/configs/apalis_imx6.h
+++ b/include/configs/apalis_imx6.h
@@ -26,7 +26,6 @@
 /* USB Configs */
 /* Host */
 #define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS		0
 
 /* Framebuffer and LCD */
 
diff --git a/include/configs/aristainetos2.h b/include/configs/aristainetos2.h
index 9d4a4bbdf43c..120ff9284ef6 100644
--- a/include/configs/aristainetos2.h
+++ b/include/configs/aristainetos2.h
@@ -413,7 +413,6 @@
 
 /* USB Configs */
 #define CFG_MXC_USB_PORTSC	(PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS	0
 
 /* UBI support */
 
diff --git a/include/configs/cl-som-imx7.h b/include/configs/cl-som-imx7.h
index 280ae1e9cca8..96058d48148b 100644
--- a/include/configs/cl-som-imx7.h
+++ b/include/configs/cl-som-imx7.h
@@ -97,6 +97,5 @@
 
 /* USB Configs */
 #define CFG_MXC_USB_PORTSC  (PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS   0
 
 #endif	/* __CONFIG_H */
diff --git a/include/configs/cm_fx6.h b/include/configs/cm_fx6.h
index 7d0f2b6dc13a..fc2d59751c42 100644
--- a/include/configs/cm_fx6.h
+++ b/include/configs/cm_fx6.h
@@ -136,7 +136,6 @@
 
 /* USB */
 #define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS		0
 
 /* Boot */
 #define CFG_SYS_BOOTMAPSZ	        (8 << 20)
diff --git a/include/configs/colibri-imx6ull.h b/include/configs/colibri-imx6ull.h
index 8860ceec1a0a..c896a897cbf4 100644
--- a/include/configs/colibri-imx6ull.h
+++ b/include/configs/colibri-imx6ull.h
@@ -120,7 +120,6 @@
 /* USB Configs */
 
 #define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS		0
 
 /* USB Device Firmware Update support */
 #define DFU_DEFAULT_POLL_TIMEOUT	300
diff --git a/include/configs/colibri_imx6.h b/include/configs/colibri_imx6.h
index 79e5b870b812..87c973883c33 100644
--- a/include/configs/colibri_imx6.h
+++ b/include/configs/colibri_imx6.h
@@ -24,7 +24,6 @@
 /* USB Configs */
 /* Host */
 #define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS		0
 
 /* Command definition */
 
diff --git a/include/configs/colibri_imx7.h b/include/configs/colibri_imx7.h
index 33133a0b96e1..0e0665038b1f 100644
--- a/include/configs/colibri_imx7.h
+++ b/include/configs/colibri_imx7.h
@@ -162,6 +162,5 @@
 /* USB Configs */
 
 #define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS		0
 
 #endif
diff --git a/include/configs/dart_6ul.h b/include/configs/dart_6ul.h
index c5781670864b..4d715d4f425e 100644
--- a/include/configs/dart_6ul.h
+++ b/include/configs/dart_6ul.h
@@ -48,7 +48,6 @@
 
 /* USB Configs */
 #define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS		0
 
 #define ENV_MMC \
 	"mmcdev=" __stringify(MMC_ROOTFS_DEV) "\0" \
diff --git a/include/configs/dh_imx6.h b/include/configs/dh_imx6.h
index 4b5ef4ad5100..dc5ca9fc60cd 100644
--- a/include/configs/dh_imx6.h
+++ b/include/configs/dh_imx6.h
@@ -32,7 +32,6 @@
 
 /* USB Configs */
 #define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS		0
 
 /* USB Gadget (DFU, UMS) */
 #if defined(CONFIG_CMD_DFU) || defined(CONFIG_CMD_USB_MASS_STORAGE)
diff --git a/include/configs/embestmx6boards.h b/include/configs/embestmx6boards.h
index 31c7e104f6b8..e378374a004a 100644
--- a/include/configs/embestmx6boards.h
+++ b/include/configs/embestmx6boards.h
@@ -19,7 +19,6 @@
 
 /* USB Configs */
 #define CFG_MXC_USB_PORTSC	(PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS	0
 
 /* MMC Configs */
 #define CFG_SYS_FSL_ESDHC_ADDR      0
diff --git a/include/configs/ge_b1x5v2.h b/include/configs/ge_b1x5v2.h
index 49b058cb10d4..0bf31897a744 100644
--- a/include/configs/ge_b1x5v2.h
+++ b/include/configs/ge_b1x5v2.h
@@ -25,7 +25,6 @@
 
 /* USB */
 #define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS		0
 
 /* Memory */
 #define PHYS_SDRAM		       MMDC0_ARB_BASE_ADDR
diff --git a/include/configs/gw_ventana.h b/include/configs/gw_ventana.h
index ebc5d03d0d5c..f884d74d9ca9 100644
--- a/include/configs/gw_ventana.h
+++ b/include/configs/gw_ventana.h
@@ -37,7 +37,6 @@
 
 /* USB Configs */
 #define CFG_MXC_USB_PORTSC     (PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS      0
 
 /* Miscellaneous configurable options */
 
diff --git a/include/configs/imx6_logic.h b/include/configs/imx6_logic.h
index 66004a6eb2a3..19613e838fb3 100644
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
index 6c61b3f44801..6651653d5e9c 100644
--- a/include/configs/imx6dl-mamoj.h
+++ b/include/configs/imx6dl-mamoj.h
@@ -44,7 +44,6 @@
 
 /* USB */
 #define CFG_MXC_USB_PORTSC			(PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS			0
 
 /* Falcon */
 
diff --git a/include/configs/imx6q-bosch-acc.h b/include/configs/imx6q-bosch-acc.h
index 2c998cdcfc72..aa365dc9a795 100644
--- a/include/configs/imx6q-bosch-acc.h
+++ b/include/configs/imx6q-bosch-acc.h
@@ -111,6 +111,5 @@
 #endif
 
 #define CFG_MXC_USB_PORTSC            (PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS             0
 
 #endif /* __IMX6Q_ACC_H */
diff --git a/include/configs/kontron-sl-mx6ul.h b/include/configs/kontron-sl-mx6ul.h
index 1c92cd787677..e68c667c5057 100644
--- a/include/configs/kontron-sl-mx6ul.h
+++ b/include/configs/kontron-sl-mx6ul.h
@@ -26,7 +26,6 @@
 
 #ifdef CONFIG_USB_EHCI_HCD
 #define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS		0
 #endif
 
 /* Boot order for distro boot */
diff --git a/include/configs/kontron-sl-mx8mm.h b/include/configs/kontron-sl-mx8mm.h
index eee3d2ddb037..be1f70a9a598 100644
--- a/include/configs/kontron-sl-mx8mm.h
+++ b/include/configs/kontron-sl-mx8mm.h
@@ -26,7 +26,6 @@
 
 #ifdef CONFIG_USB_EHCI_HCD
 #define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS		0
 #endif
 
 /* GUID for capsule updatable firmware image */
diff --git a/include/configs/kp_imx53.h b/include/configs/kp_imx53.h
index 6e383cbe75f7..91caf03091c4 100644
--- a/include/configs/kp_imx53.h
+++ b/include/configs/kp_imx53.h
@@ -12,7 +12,6 @@
 
 /* USB Configs */
 #define CFG_MXC_USB_PORTSC	(PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS	0
 
 /* Command definition */
 
diff --git a/include/configs/kp_imx6q_tpc.h b/include/configs/kp_imx6q_tpc.h
index 1aa4b8ab5987..74f6e4e9f963 100644
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
index 5811059c8e2b..25c30e6c6a5d 100644
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
index 9cf46b2c3624..1491c509820d 100644
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
index dccfdc3a15da..ab6b0b65556e 100644
--- a/include/configs/mx53cx9020.h
+++ b/include/configs/mx53cx9020.h
@@ -24,7 +24,6 @@
 /* USB Configs */
 #define CFG_MXC_USB_PORT	1
 #define CFG_MXC_USB_PORTSC	(PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS	0
 
 /* Command definition */
 
diff --git a/include/configs/mx53loco.h b/include/configs/mx53loco.h
index 7398804e6b54..04f4b7232099 100644
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
index df65dbeea41c..3c9a9fb045b6 100644
--- a/include/configs/mx53ppd.h
+++ b/include/configs/mx53ppd.h
@@ -14,7 +14,6 @@
 /* USB Configs */
 #define CFG_MXC_USB_PORT	1
 #define CFG_MXC_USB_PORTSC	(PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS	0
 
 /* Command definition */
 
diff --git a/include/configs/mx6sabreauto.h b/include/configs/mx6sabreauto.h
index 91544c8a0e23..eb963cbb0b3b 100644
--- a/include/configs/mx6sabreauto.h
+++ b/include/configs/mx6sabreauto.h
@@ -13,7 +13,6 @@
 
 /* USB Configs */
 #define CFG_MXC_USB_PORTSC	(PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS	0
 
 #define CFG_SYS_I2C_PCA953X_WIDTH	{ {0x30, 8}, {0x32, 8}, {0x34, 8} }
 
diff --git a/include/configs/mx6sabresd.h b/include/configs/mx6sabresd.h
index 844f10e4229f..9160f878f4b3 100644
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
index 490d9feb805b..65c6cdd4b87b 100644
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
index 1c14a6beb0ac..4e163d28e63d 100644
--- a/include/configs/mx6sxsabreauto.h
+++ b/include/configs/mx6sxsabreauto.h
@@ -97,7 +97,6 @@
 
 #ifdef CONFIG_CMD_USB
 #define CFG_MXC_USB_PORTSC  (PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS   0
 #endif
 
 #define CFG_SYS_FSL_USDHC_NUM	2
diff --git a/include/configs/mx6sxsabresd.h b/include/configs/mx6sxsabresd.h
index fe0ad34ef9c1..b43a1d813151 100644
--- a/include/configs/mx6sxsabresd.h
+++ b/include/configs/mx6sxsabresd.h
@@ -119,7 +119,6 @@
 
 #ifdef CONFIG_CMD_USB
 #define CFG_MXC_USB_PORTSC  (PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS   0
 #endif
 
 #ifdef CONFIG_CMD_PCI
diff --git a/include/configs/mx6ul_14x14_evk.h b/include/configs/mx6ul_14x14_evk.h
index 98b743b93644..fd0c87ffb012 100644
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
index 2571098d06c6..8defdfc4fda6 100644
--- a/include/configs/mys_6ulx.h
+++ b/include/configs/mys_6ulx.h
@@ -31,7 +31,6 @@
 
 /* USB Configs */
 #define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS		0
 
 #define CFG_EXTRA_ENV_SETTINGS \
 	"console=ttymxc0,115200n8\0" \
diff --git a/include/configs/nitrogen6x.h b/include/configs/nitrogen6x.h
index c03d11dcdaec..a8ad85050f79 100644
--- a/include/configs/nitrogen6x.h
+++ b/include/configs/nitrogen6x.h
@@ -20,7 +20,6 @@
 
 /* USB Configs */
 #define CFG_MXC_USB_PORTSC	(PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS	0
 
 #ifdef CONFIG_CMD_MMC
 #define DISTRO_BOOT_DEV_MMC(func) func(MMC, mmc, 0) func(MMC, mmc, 1)
diff --git a/include/configs/novena.h b/include/configs/novena.h
index 39d3afd1c8ee..144cf1b4a4b8 100644
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
index 5f933391cc01..f71e2657076b 100644
--- a/include/configs/npi_imx6ull.h
+++ b/include/configs/npi_imx6ull.h
@@ -30,7 +30,6 @@
 
 /* USB Configs */
 #define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS		0
 
 #ifdef CONFIG_CMD_NET
 #define CFG_FEC_MXC_PHYADDR		0x1
diff --git a/include/configs/opos6uldev.h b/include/configs/opos6uldev.h
index 1edb1826c4e8..12020d31e1c7 100644
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
index 38dcee053596..2a729c3e4544 100644
--- a/include/configs/pcl063.h
+++ b/include/configs/pcl063.h
@@ -43,7 +43,6 @@
 
 /* USB Configs */
 #define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS		0
 
 #define CFG_EXTRA_ENV_SETTINGS \
 	"console=ttymxc0,115200n8\0" \
diff --git a/include/configs/pcl063_ull.h b/include/configs/pcl063_ull.h
index d742201ce43b..afa8e7aeb716 100644
--- a/include/configs/pcl063_ull.h
+++ b/include/configs/pcl063_ull.h
@@ -45,7 +45,6 @@
 
 /* USB Configs */
 #define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS		0
 
 #define ENV_MMC \
 	"mmcdev=" __stringify(MMC_ROOTFS_DEV) "\0" \
diff --git a/include/configs/pico-imx6.h b/include/configs/pico-imx6.h
index d806d7d9c57d..6ccb3dc19021 100644
--- a/include/configs/pico-imx6.h
+++ b/include/configs/pico-imx6.h
@@ -17,7 +17,6 @@
 
 /* USB Configs */
 #define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS		0
 
 #define DFU_DEFAULT_POLL_TIMEOUT 300
 
diff --git a/include/configs/pico-imx6ul.h b/include/configs/pico-imx6ul.h
index 8a22f0134b39..ef8281440e5d 100644
--- a/include/configs/pico-imx6ul.h
+++ b/include/configs/pico-imx6ul.h
@@ -23,7 +23,6 @@
 
 /* USB Configs */
 #define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS		0
 
 #define DFU_DEFAULT_POLL_TIMEOUT 300
 
diff --git a/include/configs/pico-imx7d.h b/include/configs/pico-imx7d.h
index e7a8cb20dff9..21ec7fd3362c 100644
--- a/include/configs/pico-imx7d.h
+++ b/include/configs/pico-imx7d.h
@@ -107,6 +107,5 @@
 
 /* USB Configs */
 #define CFG_MXC_USB_PORTSC			(PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS			0
 
 #endif
diff --git a/include/configs/somlabs_visionsom_6ull.h b/include/configs/somlabs_visionsom_6ull.h
index 041a83b057d4..aa09528acd97 100644
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
index 27e61f5b8f46..28d86a263628 100644
--- a/include/configs/usbarmory.h
+++ b/include/configs/usbarmory.h
@@ -25,7 +25,6 @@
 /* USB */
 #define CFG_MXC_USB_PORT	1
 #define CFG_MXC_USB_PORTSC	(PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS	0
 
 /* Linux boot */
 
diff --git a/include/configs/vining_2000.h b/include/configs/vining_2000.h
index 30654191a264..3c2d7e668917 100644
--- a/include/configs/vining_2000.h
+++ b/include/configs/vining_2000.h
@@ -37,7 +37,6 @@
 #define CFG_FEC_MXC_PHYADDR          0x0
 
 #define CFG_MXC_USB_PORTSC  (PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS   0
 
 #ifdef CONFIG_CMD_PCI
 #define CFG_PCIE_IMX_PERST_GPIO	IMX_GPIO_NR(4, 6)
diff --git a/include/configs/wandboard.h b/include/configs/wandboard.h
index 7b8c5cbe7a8f..d64c4262bd69 100644
--- a/include/configs/wandboard.h
+++ b/include/configs/wandboard.h
@@ -18,7 +18,6 @@
 
 /* USB Configs */
 #define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-#define CFG_MXC_USB_FLAGS		0
 
 #define CFG_EXTRA_ENV_SETTINGS \
 	"console=ttymxc0\0" \
diff --git a/include/configs/xpress.h b/include/configs/xpress.h
index a2aa31008ec9..bb0a30c4344f 100644
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

