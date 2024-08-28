Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E595C54FB3
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 13:26:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63DD288ADB;
	Wed, 28 Aug 2024 15:26:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MFJF3/5b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96CDE888AA; Wed, 28 Aug 2024 15:26:11 +0200 (CEST)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C8A48884F
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 15:26:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-6e7b121be30so4313084a12.1
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 06:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724851567; x=1725456367; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9yshqSHy3GEKi89F588wIfoMeb8eKTzx316+TvqZw2o=;
 b=MFJF3/5bWRzX4bl8CRwNCDMnlYTLyKLwG0ODdPZQ64z3ZaHrDinvId0cExN+j7Xiqq
 3tg8EYVxnnylTUE7vWy5zAwl6LDg+gAtTZR2Td7aP+m44DUUpzmGMRxyc5wsEpK4Hg67
 ObMqA6U079dCE8NaP/MpTUjBbiQJKCQdqli7a/gGJgVwQW8s1/CtLMugQX3o6xyyc3DU
 URW34zqZSsg8qPiqMClUhHBjzEuBWHuZ+kfSK/W5giXereCBTLzX3WB3ILAbshXalX1x
 9FRi0YkVnG4DuR1G6ZGLfYyTJdXWC6BWDMhzYWsSiQI40/0BIaJM1ZxIcv1RhSMPbfZy
 TiUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724851567; x=1725456367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9yshqSHy3GEKi89F588wIfoMeb8eKTzx316+TvqZw2o=;
 b=GYAR2neI18ImS39VNAqVJDEmTDLhr9Qx6pLgF9EHI8rtyFpOxltxSWboCLFfuHFlGK
 1A4Xu35rFvT5GT4cLrQcZJQmAvQQVGKHUuefN/oi/txKH1Pe2+OM0v6LxGxwC/VAnfGm
 M88S9gmku6Y9csfJBW+gsldhJzL4kV1DyTtBXKa+lzCJvjbPCANdcZT/g/q+WJDzp039
 sWslhwo4//4CwBG8m/qSHCHfiI7KRsmqI28bwmC/eGTDd0q+Gs1Ea/0qoRpg543lBHsG
 PbWeI4DxQzQR5G1qQiHT4JROcGzwUKKbYk6ihbz74BRVPGw6WSehFRp8Z3qk8l8lhzIc
 tCVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPWNCSHEIBl/xo47HxWn08x4Oexc8IeVNCSkrByaAHxHT1Yu7jhTzDXDZjerOvIdMoVpIB0MQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yx4shgK1FogSfBhTD/pYtQ9EdyvK47/DcMbTV2hoIcai6SOW7co
 e2GcOY26nSb4GFYa2Bg9arUelwDO6lKFJc5Nqk3/WU2cIjPFRG/42Uk3Ew==
X-Google-Smtp-Source: AGHT+IHMIl0PAdg16L8OBE7WPTNQU2G8c/yol/bX67Njp+rU5IqQcA9jca0+36Cx71FkzZaZn/EK9Q==
X-Received: by 2002:a17:90a:1bc7:b0:2d3:c9bb:9cd7 with SMTP id
 98e67ed59e1d1-2d646d558eamr14576854a91.36.1724851566878; 
 Wed, 28 Aug 2024 06:26:06 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:4b3a:557e:6b5b:dbdc])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d844617777sm1788660a91.24.2024.08.28.06.26.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 06:26:06 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: peng.fan@nxp.com
Cc: marex@denx.de, u-boot@lists.denx.de, tharvey@gateworks.com, smoch@web.de,
 Fabio Estevam <festevam@denx.de>
Subject: [PATCH v3 4/4] imx: Remove CFG_MXC_USB_PORTSC
Date: Wed, 28 Aug 2024 10:25:29 -0300
Message-Id: <20240828132529.3098961-4-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828132529.3098961-1-festevam@gmail.com>
References: <20240828132529.3098961-1-festevam@gmail.com>
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

The definition of CFG_MXC_USB_PORTSC as (PORT_PTS_UTMI | PORT_PTS_PTW)
can be removed from mx5/mx6/mx7/mx8m board config files as it is the
default in drivers/usb/host/ehci-mx5.c and drivers/usb/host/ehci-mx6.c.

Suggested-by: Tim Harvey <tharvey@gateworks.com>
Signed-off-by: Fabio Estevam <festevam@denx.de>
Reviewed-by: Tim Harvey <tharvey@gateworks.com>
---
Changes since v2:
- Keep mx51evk.h intact as it uses a different CFG_MXC_USB_PORTSC
definition.

 include/configs/apalis_imx6.h            | 4 ----
 include/configs/aristainetos2.h          | 3 ---
 include/configs/brppt2.h                 | 3 ---
 include/configs/cl-som-imx7.h            | 3 ---
 include/configs/cm_fx6.h                 | 3 ---
 include/configs/colibri-imx6ull.h        | 4 ----
 include/configs/colibri_imx6.h           | 4 ----
 include/configs/colibri_imx7.h           | 4 ----
 include/configs/dart_6ul.h               | 3 ---
 include/configs/dh_imx6.h                | 3 ---
 include/configs/display5.h               | 1 -
 include/configs/embestmx6boards.h        | 3 ---
 include/configs/ge_b1x5v2.h              | 3 ---
 include/configs/gw_ventana.h             | 3 ---
 include/configs/imx6_logic.h             | 5 -----
 include/configs/imx6dl-mamoj.h           | 3 ---
 include/configs/imx6q-bosch-acc.h        | 1 -
 include/configs/imx7-cm.h                | 3 ---
 include/configs/imx8mm-cl-iot-gate.h     | 3 ---
 include/configs/kontron-sl-mx6ul.h       | 4 ----
 include/configs/kontron-sl-mx8mm.h       | 4 ----
 include/configs/kp_imx53.h               | 3 ---
 include/configs/kp_imx6q_tpc.h           | 5 -----
 include/configs/liteboard.h              | 5 -----
 include/configs/m53menlo.h               | 7 -------
 include/configs/meerkat96.h              | 3 ---
 include/configs/mx53cx9020.h             | 3 ---
 include/configs/mx53loco.h               | 3 ---
 include/configs/mx53ppd.h                | 3 ---
 include/configs/mx6cuboxi.h              | 3 ---
 include/configs/mx6memcal.h              | 1 -
 include/configs/mx6sabreauto.h           | 3 ---
 include/configs/mx6sabresd.h             | 5 -----
 include/configs/mx6slevk.h               | 5 -----
 include/configs/mx6sllevk.h              | 5 -----
 include/configs/mx6sxsabreauto.h         | 4 ----
 include/configs/mx6sxsabresd.h           | 4 ----
 include/configs/mx6ul_14x14_evk.h        | 5 -----
 include/configs/mx7dsabresd.h            | 3 ---
 include/configs/mx7ulp_com.h             | 1 -
 include/configs/mys_6ulx.h               | 3 ---
 include/configs/nitrogen6x.h             | 3 ---
 include/configs/novena.h                 | 5 -----
 include/configs/npi_imx6ull.h            | 3 ---
 include/configs/o4-imx6ull-nano.h        | 4 ----
 include/configs/opos6uldev.h             | 5 -----
 include/configs/pcl063.h                 | 3 ---
 include/configs/pcl063_ull.h             | 3 ---
 include/configs/pico-imx6.h              | 3 ---
 include/configs/pico-imx6ul.h            | 3 ---
 include/configs/pico-imx7d.h             | 3 ---
 include/configs/somlabs_visionsom_6ull.h | 5 -----
 include/configs/tbs2910.h                | 5 -----
 include/configs/tqma6.h                  | 3 ---
 include/configs/usbarmory.h              | 3 ---
 include/configs/verdin-imx8mm.h          | 3 ---
 include/configs/vining_2000.h            | 1 -
 include/configs/wandboard.h              | 3 ---
 include/configs/warp7.h                  | 1 -
 include/configs/xpress.h                 | 3 ---
 60 files changed, 203 deletions(-)

diff --git a/include/configs/apalis_imx6.h b/include/configs/apalis_imx6.h
index 097f819e44a4..e5df82c68301 100644
--- a/include/configs/apalis_imx6.h
+++ b/include/configs/apalis_imx6.h
@@ -23,10 +23,6 @@
 
 /* Network */
 
-/* USB Configs */
-/* Host */
-#define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-
 /* Framebuffer and LCD */
 
 /* Command definition */
diff --git a/include/configs/aristainetos2.h b/include/configs/aristainetos2.h
index 120ff9284ef6..8a66b1275dfe 100644
--- a/include/configs/aristainetos2.h
+++ b/include/configs/aristainetos2.h
@@ -411,9 +411,6 @@
 
 /* DMA stuff, needed for GPMI/MXS NAND support */
 
-/* USB Configs */
-#define CFG_MXC_USB_PORTSC	(PORT_PTS_UTMI | PORT_PTS_PTW)
-
 /* UBI support */
 
 #define CFG_ENV_FLAGS_LIST_STATIC "ethaddr:mw,serial#:sw,board_type:sw," \
diff --git a/include/configs/brppt2.h b/include/configs/brppt2.h
index 38c98c5e21c4..d01f0d373163 100644
--- a/include/configs/brppt2.h
+++ b/include/configs/brppt2.h
@@ -78,7 +78,4 @@ BUR_COMMON_ENV \
 #define CFG_SYS_INIT_RAM_ADDR	IRAM_BASE_ADDR
 #define CFG_SYS_INIT_RAM_SIZE	IRAM_SIZE
 
-/* USB Configs */
-#define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-
 #endif	/* __CONFIG_BRPP2_IMX6_H */
diff --git a/include/configs/cl-som-imx7.h b/include/configs/cl-som-imx7.h
index 96058d48148b..8c363137b4fa 100644
--- a/include/configs/cl-som-imx7.h
+++ b/include/configs/cl-som-imx7.h
@@ -95,7 +95,4 @@
 #define CFG_SYS_FSL_USDHC_NUM	2
 #endif
 
-/* USB Configs */
-#define CFG_MXC_USB_PORTSC  (PORT_PTS_UTMI | PORT_PTS_PTW)
-
 #endif	/* __CONFIG_H */
diff --git a/include/configs/cm_fx6.h b/include/configs/cm_fx6.h
index fc2d59751c42..f7fd4c517b4f 100644
--- a/include/configs/cm_fx6.h
+++ b/include/configs/cm_fx6.h
@@ -134,9 +134,6 @@
 /* Ethernet */
 #define CFG_FEC_MXC_PHYADDR		0
 
-/* USB */
-#define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-
 /* Boot */
 #define CFG_SYS_BOOTMAPSZ	        (8 << 20)
 
diff --git a/include/configs/colibri-imx6ull.h b/include/configs/colibri-imx6ull.h
index c896a897cbf4..26b29bad6a18 100644
--- a/include/configs/colibri-imx6ull.h
+++ b/include/configs/colibri-imx6ull.h
@@ -117,10 +117,6 @@
 #define CFG_SYS_NAND_BASE		-1
 #endif
 
-/* USB Configs */
-
-#define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-
 /* USB Device Firmware Update support */
 #define DFU_DEFAULT_POLL_TIMEOUT	300
 
diff --git a/include/configs/colibri_imx6.h b/include/configs/colibri_imx6.h
index 87c973883c33..664b7c8ce0cd 100644
--- a/include/configs/colibri_imx6.h
+++ b/include/configs/colibri_imx6.h
@@ -21,10 +21,6 @@
 #define CFG_SYS_FSL_ESDHC_ADDR	0
 #define CFG_SYS_FSL_USDHC_NUM	2
 
-/* USB Configs */
-/* Host */
-#define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-
 /* Command definition */
 
 #define BOOT_TARGET_DEVICES(func) \
diff --git a/include/configs/colibri_imx7.h b/include/configs/colibri_imx7.h
index 0e0665038b1f..c340dfb11894 100644
--- a/include/configs/colibri_imx7.h
+++ b/include/configs/colibri_imx7.h
@@ -159,8 +159,4 @@
 #define CFG_SYS_NAND_BASE		0x40000000
 #endif
 
-/* USB Configs */
-
-#define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-
 #endif
diff --git a/include/configs/dart_6ul.h b/include/configs/dart_6ul.h
index 4d715d4f425e..2b329b4065c3 100644
--- a/include/configs/dart_6ul.h
+++ b/include/configs/dart_6ul.h
@@ -46,9 +46,6 @@
 #define CFG_SYS_INIT_RAM_ADDR	IRAM_BASE_ADDR
 #define CFG_SYS_INIT_RAM_SIZE	IRAM_SIZE
 
-/* USB Configs */
-#define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-
 #define ENV_MMC \
 	"mmcdev=" __stringify(MMC_ROOTFS_DEV) "\0" \
 	"mmcpart=" __stringify(MMC_ROOTFS_PART) "\0" \
diff --git a/include/configs/dh_imx6.h b/include/configs/dh_imx6.h
index dc5ca9fc60cd..9b6f03f68563 100644
--- a/include/configs/dh_imx6.h
+++ b/include/configs/dh_imx6.h
@@ -30,9 +30,6 @@
 /* UART */
 #define CFG_MXC_UART_BASE		UART1_BASE
 
-/* USB Configs */
-#define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-
 /* USB Gadget (DFU, UMS) */
 #if defined(CONFIG_CMD_DFU) || defined(CONFIG_CMD_USB_MASS_STORAGE)
 #define DFU_DEFAULT_POLL_TIMEOUT	300
diff --git a/include/configs/display5.h b/include/configs/display5.h
index 2005a256d6e3..51fa2b03a2e6 100644
--- a/include/configs/display5.h
+++ b/include/configs/display5.h
@@ -287,5 +287,4 @@
 /* The 0x120000 value corresponds to above SPI-NOR memory MAP */
 #endif
 
-#define CFG_MXC_USB_PORTSC           (PORT_PTS_UTMI | PORT_PTS_PTW)
 #endif /* __CONFIG_H */
diff --git a/include/configs/embestmx6boards.h b/include/configs/embestmx6boards.h
index e378374a004a..61c0d755a8d9 100644
--- a/include/configs/embestmx6boards.h
+++ b/include/configs/embestmx6boards.h
@@ -17,9 +17,6 @@
 
 #define PHYS_SDRAM_SIZE		(1u * 1024 * 1024 * 1024)
 
-/* USB Configs */
-#define CFG_MXC_USB_PORTSC	(PORT_PTS_UTMI | PORT_PTS_PTW)
-
 /* MMC Configs */
 #define CFG_SYS_FSL_ESDHC_ADDR      0
 
diff --git a/include/configs/ge_b1x5v2.h b/include/configs/ge_b1x5v2.h
index 0bf31897a744..f3d85c9c11e8 100644
--- a/include/configs/ge_b1x5v2.h
+++ b/include/configs/ge_b1x5v2.h
@@ -23,9 +23,6 @@
 #define CONSOLE_DEVICE "ttymxc2" /* Base board debug connector */
 #endif
 
-/* USB */
-#define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-
 /* Memory */
 #define PHYS_SDRAM		       MMDC0_ARB_BASE_ADDR
 
diff --git a/include/configs/gw_ventana.h b/include/configs/gw_ventana.h
index f884d74d9ca9..d112825ad1ff 100644
--- a/include/configs/gw_ventana.h
+++ b/include/configs/gw_ventana.h
@@ -35,9 +35,6 @@
 
 /* Various command support */
 
-/* USB Configs */
-#define CFG_MXC_USB_PORTSC     (PORT_PTS_UTMI | PORT_PTS_PTW)
-
 /* Miscellaneous configurable options */
 
 /* Memory configuration */
diff --git a/include/configs/imx6_logic.h b/include/configs/imx6_logic.h
index 19613e838fb3..75997469cd91 100644
--- a/include/configs/imx6_logic.h
+++ b/include/configs/imx6_logic.h
@@ -114,11 +114,6 @@
 #define CFG_SYS_NAND_BASE           0x40000000
 #define CFG_SYS_NAND_U_BOOT_START	CONFIG_TEXT_BASE
 
-/* USB Configs */
-#ifdef CONFIG_CMD_USB
-#define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-#endif
-
 /* Falcon Mode */
 
 /* Falcon Mode - MMC support: args@1MB kernel@2MB */
diff --git a/include/configs/imx6dl-mamoj.h b/include/configs/imx6dl-mamoj.h
index 6651653d5e9c..8abb58b06918 100644
--- a/include/configs/imx6dl-mamoj.h
+++ b/include/configs/imx6dl-mamoj.h
@@ -42,9 +42,6 @@
 /* Ethernet */
 #define CFG_FEC_MXC_PHYADDR		1
 
-/* USB */
-#define CFG_MXC_USB_PORTSC			(PORT_PTS_UTMI | PORT_PTS_PTW)
-
 /* Falcon */
 
 /* MMC support: args@1MB kernel@2MB */
diff --git a/include/configs/imx6q-bosch-acc.h b/include/configs/imx6q-bosch-acc.h
index aa365dc9a795..fab5063b73f4 100644
--- a/include/configs/imx6q-bosch-acc.h
+++ b/include/configs/imx6q-bosch-acc.h
@@ -110,6 +110,5 @@
 #endif
 #endif
 
-#define CFG_MXC_USB_PORTSC            (PORT_PTS_UTMI | PORT_PTS_PTW)
 
 #endif /* __IMX6Q_ACC_H */
diff --git a/include/configs/imx7-cm.h b/include/configs/imx7-cm.h
index 131f18290b90..36c4c5b8b50a 100644
--- a/include/configs/imx7-cm.h
+++ b/include/configs/imx7-cm.h
@@ -77,7 +77,4 @@
 #define CFG_SYS_FSL_ESDHC_ADDR       USDHC1_BASE_ADDR
 #define CFG_SYS_FSL_USDHC_NUM		2
 
-/* USB Configs */
-#define CFG_MXC_USB_PORTSC  (PORT_PTS_UTMI | PORT_PTS_PTW)
-
 #endif	/* __CONFIG_H */
diff --git a/include/configs/imx8mm-cl-iot-gate.h b/include/configs/imx8mm-cl-iot-gate.h
index 6442e3d570f4..146f7945719f 100644
--- a/include/configs/imx8mm-cl-iot-gate.h
+++ b/include/configs/imx8mm-cl-iot-gate.h
@@ -137,7 +137,4 @@
 
 #define CFG_FEC_MXC_PHYADDR		-1 /* Auto search of PHY on MII */
 
-/* USB Configs */
-#define CFG_MXC_USB_PORTSC	(PORT_PTS_UTMI | PORT_PTS_PTW)
-
 #endif /*__IMX8MM_CL_IOT_GATE_H*/
diff --git a/include/configs/kontron-sl-mx6ul.h b/include/configs/kontron-sl-mx6ul.h
index e68c667c5057..015df01db4e6 100644
--- a/include/configs/kontron-sl-mx6ul.h
+++ b/include/configs/kontron-sl-mx6ul.h
@@ -24,10 +24,6 @@
 /* Board and environment settings */
 #define CFG_MXC_UART_BASE		UART4_BASE
 
-#ifdef CONFIG_USB_EHCI_HCD
-#define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-#endif
-
 /* Boot order for distro boot */
 #define BOOT_TARGET_DEVICES(func) \
 	func(MMC, mmc, 1) \
diff --git a/include/configs/kontron-sl-mx8mm.h b/include/configs/kontron-sl-mx8mm.h
index be1f70a9a598..3a129c5cce77 100644
--- a/include/configs/kontron-sl-mx8mm.h
+++ b/include/configs/kontron-sl-mx8mm.h
@@ -24,10 +24,6 @@
 
 /* Board and environment settings */
 
-#ifdef CONFIG_USB_EHCI_HCD
-#define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-#endif
-
 /* GUID for capsule updatable firmware image */
 #define KONTRON_SL_MX8MM_FIT_IMAGE_GUID \
 	EFI_GUID(0xd488e45a, 0x4929, 0x4b55, 0x8c, 0x14, \
diff --git a/include/configs/kp_imx53.h b/include/configs/kp_imx53.h
index 91caf03091c4..48adff3f03a7 100644
--- a/include/configs/kp_imx53.h
+++ b/include/configs/kp_imx53.h
@@ -10,9 +10,6 @@
 #include <asm/arch/imx-regs.h>
 #include <linux/sizes.h>
 
-/* USB Configs */
-#define CFG_MXC_USB_PORTSC	(PORT_PTS_UTMI | PORT_PTS_PTW)
-
 /* Command definition */
 
 #define CFG_EXTRA_ENV_SETTINGS \
diff --git a/include/configs/kp_imx6q_tpc.h b/include/configs/kp_imx6q_tpc.h
index 74f6e4e9f963..c0cb3db23e7a 100644
--- a/include/configs/kp_imx6q_tpc.h
+++ b/include/configs/kp_imx6q_tpc.h
@@ -16,11 +16,6 @@
 
 /* FEC ethernet */
 
-/* USB Configs */
-#ifdef CONFIG_CMD_USB
-#define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-#endif
-
 #define CFG_EXTRA_ENV_SETTINGS	\
 	"console=ttymxc0,115200\0"	\
 	"fdt_addr=0x18000000\0"		\
diff --git a/include/configs/liteboard.h b/include/configs/liteboard.h
index 25c30e6c6a5d..fc6bc6b28baa 100644
--- a/include/configs/liteboard.h
+++ b/include/configs/liteboard.h
@@ -93,11 +93,6 @@
 
 /* FLASH and environment organization */
 
-/* USB Configs */
-#ifdef CONFIG_CMD_USB
-#define CFG_MXC_USB_PORTSC  (PORT_PTS_UTMI | PORT_PTS_PTW)
-#endif
-
 #ifdef CONFIG_CMD_NET
 #define CFG_FEC_ENET_DEV		0
 
diff --git a/include/configs/m53menlo.h b/include/configs/m53menlo.h
index 51ce030d831e..b5943f48c69f 100644
--- a/include/configs/m53menlo.h
+++ b/include/configs/m53menlo.h
@@ -66,13 +66,6 @@
 #define CFG_SYS_I2C_RTC_ADDR		0x68
 #endif
 
-/*
- * USB
- */
-#ifdef CONFIG_CMD_USB
-#define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-#endif
-
 /* LVDS display */
 #define CFG_SYS_LDB_CLOCK			33260000
 
diff --git a/include/configs/meerkat96.h b/include/configs/meerkat96.h
index 6ffc1282411a..8e248177b1ca 100644
--- a/include/configs/meerkat96.h
+++ b/include/configs/meerkat96.h
@@ -23,7 +23,4 @@
 
 /* Environment configs */
 
-/* USB configs */
-#define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-
 #endif
diff --git a/include/configs/mx53cx9020.h b/include/configs/mx53cx9020.h
index 38bafc5156dd..2ee5cc40e541 100644
--- a/include/configs/mx53cx9020.h
+++ b/include/configs/mx53cx9020.h
@@ -21,9 +21,6 @@
 
 /* bootz: zImage/initrd.img support */
 
-/* USB Configs */
-#define CFG_MXC_USB_PORTSC	(PORT_PTS_UTMI | PORT_PTS_PTW)
-
 /* Command definition */
 
 #define BOOT_TARGET_DEVICES(func) \
diff --git a/include/configs/mx53loco.h b/include/configs/mx53loco.h
index e9340c59ae1b..cec3658b1891 100644
--- a/include/configs/mx53loco.h
+++ b/include/configs/mx53loco.h
@@ -16,9 +16,6 @@
 /* MMC Configs */
 #define CFG_SYS_FSL_ESDHC_ADDR	0
 
-/* USB Configs */
-#define CFG_MXC_USB_PORTSC	(PORT_PTS_UTMI | PORT_PTS_PTW)
-
 /* PMIC Controller */
 #define CFG_SYS_DIALOG_PMIC_I2C_ADDR	0x48
 #define CFG_SYS_FSL_PMIC_I2C_ADDR	0x8
diff --git a/include/configs/mx53ppd.h b/include/configs/mx53ppd.h
index e0bfbbb459cf..6e1cbec0c1f4 100644
--- a/include/configs/mx53ppd.h
+++ b/include/configs/mx53ppd.h
@@ -11,9 +11,6 @@
 
 #include <asm/arch/imx-regs.h>
 
-/* USB Configs */
-#define CFG_MXC_USB_PORTSC	(PORT_PTS_UTMI | PORT_PTS_PTW)
-
 /* Command definition */
 
 #define PPD_CONFIG_NFS \
diff --git a/include/configs/mx6cuboxi.h b/include/configs/mx6cuboxi.h
index f0d6405d3012..068b9e4d25f1 100644
--- a/include/configs/mx6cuboxi.h
+++ b/include/configs/mx6cuboxi.h
@@ -14,9 +14,6 @@
 /* MMC Configs */
 #define CFG_SYS_FSL_ESDHC_ADDR	USDHC2_BASE_ADDR
 
-/* USB */
-#define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-
 /* Command definition */
 
 #define CFG_MXC_UART_BASE	UART1_BASE
diff --git a/include/configs/mx6memcal.h b/include/configs/mx6memcal.h
index f2edd13eb881..a966c8b2a446 100644
--- a/include/configs/mx6memcal.h
+++ b/include/configs/mx6memcal.h
@@ -31,6 +31,5 @@
 #define CFG_SYS_INIT_RAM_ADDR       IRAM_BASE_ADDR
 #define CFG_SYS_INIT_RAM_SIZE       IRAM_SIZE
 
-#define CFG_MXC_USB_PORTSC	PORT_PTS_UTMI
 
 #endif	       /* __CONFIG_H */
diff --git a/include/configs/mx6sabreauto.h b/include/configs/mx6sabreauto.h
index eb963cbb0b3b..e491af3e9278 100644
--- a/include/configs/mx6sabreauto.h
+++ b/include/configs/mx6sabreauto.h
@@ -11,9 +11,6 @@
 #define CFG_MXC_UART_BASE	UART4_BASE
 #define CONSOLE_DEV		"ttymxc3"
 
-/* USB Configs */
-#define CFG_MXC_USB_PORTSC	(PORT_PTS_UTMI | PORT_PTS_PTW)
-
 #define CFG_SYS_I2C_PCA953X_WIDTH	{ {0x30, 8}, {0x32, 8}, {0x34, 8} }
 
 #include "mx6sabre_common.h"
diff --git a/include/configs/mx6sabresd.h b/include/configs/mx6sabresd.h
index 9160f878f4b3..e34947c94d00 100644
--- a/include/configs/mx6sabresd.h
+++ b/include/configs/mx6sabresd.h
@@ -24,9 +24,4 @@
 #define CFG_PCIE_IMX_POWER_GPIO	IMX_GPIO_NR(3, 19)
 #endif
 
-/* USB Configs */
-#ifdef CONFIG_CMD_USB
-#define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-#endif
-
 #endif                         /* __MX6SABRESD_CONFIG_H */
diff --git a/include/configs/mx6slevk.h b/include/configs/mx6slevk.h
index 65c6cdd4b87b..d4e66a39882c 100644
--- a/include/configs/mx6slevk.h
+++ b/include/configs/mx6slevk.h
@@ -88,11 +88,6 @@
 
 /* Environment organization */
 
-/* USB Configs */
-#ifdef CONFIG_CMD_USB
-#define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-#endif
-
 #define CFG_SYS_FSL_USDHC_NUM	3
 
 #endif				/* __CONFIG_H */
diff --git a/include/configs/mx6sllevk.h b/include/configs/mx6sllevk.h
index 290996b51bc7..0ba4054bbe4a 100644
--- a/include/configs/mx6sllevk.h
+++ b/include/configs/mx6sllevk.h
@@ -92,10 +92,5 @@
 #define CFG_SYS_FSL_ESDHC_ADDR	USDHC1_BASE_ADDR
 #define CFG_SYS_FSL_USDHC_NUM	3
 
-/* USB Configs */
-#ifdef CONFIG_CMD_USB
-#define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-#endif
-
 #include <linux/stringify.h>
 #endif				/* __CONFIG_H */
diff --git a/include/configs/mx6sxsabreauto.h b/include/configs/mx6sxsabreauto.h
index 4e163d28e63d..36d82e81d5dd 100644
--- a/include/configs/mx6sxsabreauto.h
+++ b/include/configs/mx6sxsabreauto.h
@@ -95,10 +95,6 @@
 #define IMX_FEC_BASE			ENET2_BASE_ADDR
 #define CFG_FEC_MXC_PHYADDR          0x0
 
-#ifdef CONFIG_CMD_USB
-#define CFG_MXC_USB_PORTSC  (PORT_PTS_UTMI | PORT_PTS_PTW)
-#endif
-
 #define CFG_SYS_FSL_USDHC_NUM	2
 
 #endif				/* __CONFIG_H */
diff --git a/include/configs/mx6sxsabresd.h b/include/configs/mx6sxsabresd.h
index b43a1d813151..844becbfd2ce 100644
--- a/include/configs/mx6sxsabresd.h
+++ b/include/configs/mx6sxsabresd.h
@@ -117,10 +117,6 @@
 
 #define CFG_FEC_MXC_PHYADDR          0x1
 
-#ifdef CONFIG_CMD_USB
-#define CFG_MXC_USB_PORTSC  (PORT_PTS_UTMI | PORT_PTS_PTW)
-#endif
-
 #ifdef CONFIG_CMD_PCI
 #define CFG_PCIE_IMX_PERST_GPIO	IMX_GPIO_NR(2, 0)
 #define CFG_PCIE_IMX_POWER_GPIO	IMX_GPIO_NR(2, 1)
diff --git a/include/configs/mx6ul_14x14_evk.h b/include/configs/mx6ul_14x14_evk.h
index fd0c87ffb012..3716dc75b966 100644
--- a/include/configs/mx6ul_14x14_evk.h
+++ b/include/configs/mx6ul_14x14_evk.h
@@ -114,11 +114,6 @@
 
 /* environment organization */
 
-/* USB Configs */
-#ifdef CONFIG_CMD_USB
-#define CFG_MXC_USB_PORTSC  (PORT_PTS_UTMI | PORT_PTS_PTW)
-#endif
-
 #ifdef CONFIG_CMD_NET
 #define CFG_FEC_ENET_DEV		1
 
diff --git a/include/configs/mx7dsabresd.h b/include/configs/mx7dsabresd.h
index 94bee75fdea5..f5ab47207504 100644
--- a/include/configs/mx7dsabresd.h
+++ b/include/configs/mx7dsabresd.h
@@ -98,7 +98,4 @@
 /* DMA stuff, needed for GPMI/MXS NAND support */
 #endif
 
-/* USB Configs */
-#define CFG_MXC_USB_PORTSC  (PORT_PTS_UTMI | PORT_PTS_PTW)
-
 #endif	/* __CONFIG_H */
diff --git a/include/configs/mx7ulp_com.h b/include/configs/mx7ulp_com.h
index a310c64e7948..f8e3950fa321 100644
--- a/include/configs/mx7ulp_com.h
+++ b/include/configs/mx7ulp_com.h
@@ -51,5 +51,4 @@
 #define CFG_SYS_INIT_RAM_ADDR	IRAM_BASE_ADDR
 #define CFG_SYS_INIT_RAM_SIZE	SZ_256K
 
-#define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
 #endif	/* __CONFIG_H */
diff --git a/include/configs/mys_6ulx.h b/include/configs/mys_6ulx.h
index 8defdfc4fda6..ddd46c8f945b 100644
--- a/include/configs/mys_6ulx.h
+++ b/include/configs/mys_6ulx.h
@@ -29,9 +29,6 @@
 /* NAND */
 #define CFG_SYS_NAND_BASE		0x40000000
 
-/* USB Configs */
-#define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-
 #define CFG_EXTRA_ENV_SETTINGS \
 	"console=ttymxc0,115200n8\0" \
 	"fdt_addr_r=0x82000000\0" \
diff --git a/include/configs/nitrogen6x.h b/include/configs/nitrogen6x.h
index a8ad85050f79..23eefaffc721 100644
--- a/include/configs/nitrogen6x.h
+++ b/include/configs/nitrogen6x.h
@@ -18,9 +18,6 @@
 #define IMX_FEC_BASE			ENET_BASE_ADDR
 #define CFG_FEC_MXC_PHYADDR		6
 
-/* USB Configs */
-#define CFG_MXC_USB_PORTSC	(PORT_PTS_UTMI | PORT_PTS_PTW)
-
 #ifdef CONFIG_CMD_MMC
 #define DISTRO_BOOT_DEV_MMC(func) func(MMC, mmc, 0) func(MMC, mmc, 1)
 #else
diff --git a/include/configs/novena.h b/include/configs/novena.h
index 144cf1b4a4b8..059b8104e4b4 100644
--- a/include/configs/novena.h
+++ b/include/configs/novena.h
@@ -51,11 +51,6 @@
 /* UART */
 #define CFG_MXC_UART_BASE		UART2_BASE
 
-/* USB Configs */
-#ifdef CONFIG_CMD_USB
-#define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-#endif
-
 /* Extra U-Boot environment. */
 #define CFG_EXTRA_ENV_SETTINGS					\
 	"fdt_high=0xffffffff\0"						\
diff --git a/include/configs/npi_imx6ull.h b/include/configs/npi_imx6ull.h
index f71e2657076b..1caa63f0227b 100644
--- a/include/configs/npi_imx6ull.h
+++ b/include/configs/npi_imx6ull.h
@@ -28,9 +28,6 @@
 /* NAND */
 #define CFG_SYS_NAND_BASE		0x40000000
 
-/* USB Configs */
-#define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-
 #ifdef CONFIG_CMD_NET
 #define CFG_FEC_MXC_PHYADDR		0x1
 #endif
diff --git a/include/configs/o4-imx6ull-nano.h b/include/configs/o4-imx6ull-nano.h
index 9050da8738b1..f5a4898f90e6 100644
--- a/include/configs/o4-imx6ull-nano.h
+++ b/include/configs/o4-imx6ull-nano.h
@@ -11,10 +11,6 @@
 #define CFG_SYS_INIT_RAM_ADDR	IRAM_BASE_ADDR
 #define CFG_SYS_INIT_RAM_SIZE	IRAM_SIZE
 
-#if IS_ENABLED(CONFIG_CMD_USB)
-#	define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-#endif /* CONFIG_CMD_USB */
-
 #define CFG_EXTRA_ENV_SETTINGS \
 	"mmcdev=0\0" \
 	"mmcpart=2\0" \
diff --git a/include/configs/opos6uldev.h b/include/configs/opos6uldev.h
index 12020d31e1c7..fd945235af37 100644
--- a/include/configs/opos6uldev.h
+++ b/include/configs/opos6uldev.h
@@ -17,11 +17,6 @@
 #define CFG_SYS_INIT_RAM_ADDR	IRAM_BASE_ADDR
 #define CFG_SYS_INIT_RAM_SIZE	IRAM_SIZE
 
-/* USB */
-#ifdef CONFIG_USB_EHCI_MX6
-#define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-#endif
-
 /* LCD */
 #define MXS_LCDIF_BASE MX6UL_LCDIF1_BASE_ADDR
 
diff --git a/include/configs/pcl063.h b/include/configs/pcl063.h
index 2a729c3e4544..0c96506b5fbe 100644
--- a/include/configs/pcl063.h
+++ b/include/configs/pcl063.h
@@ -41,9 +41,6 @@
 /* NAND */
 #define CFG_SYS_NAND_BASE		0x40000000
 
-/* USB Configs */
-#define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-
 #define CFG_EXTRA_ENV_SETTINGS \
 	"console=ttymxc0,115200n8\0" \
 	"fdt_addr_r=0x82000000\0" \
diff --git a/include/configs/pcl063_ull.h b/include/configs/pcl063_ull.h
index afa8e7aeb716..0f265adc5dca 100644
--- a/include/configs/pcl063_ull.h
+++ b/include/configs/pcl063_ull.h
@@ -43,9 +43,6 @@
 /* NAND */
 #define CFG_SYS_NAND_BASE		0x40000000
 
-/* USB Configs */
-#define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-
 #define ENV_MMC \
 	"mmcdev=" __stringify(MMC_ROOTFS_DEV) "\0" \
 	"mmcpart=" __stringify(MMC_ROOTFS_PART) "\0" \
diff --git a/include/configs/pico-imx6.h b/include/configs/pico-imx6.h
index 6ccb3dc19021..500dd8c069ae 100644
--- a/include/configs/pico-imx6.h
+++ b/include/configs/pico-imx6.h
@@ -15,9 +15,6 @@
 /* MMC Configuration */
 #define CFG_SYS_FSL_ESDHC_ADDR	USDHC3_BASE_ADDR
 
-/* USB Configs */
-#define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-
 #define DFU_DEFAULT_POLL_TIMEOUT 300
 
 #define CFG_DFU_ENV_SETTINGS \
diff --git a/include/configs/pico-imx6ul.h b/include/configs/pico-imx6ul.h
index ef8281440e5d..37f4c7d8a098 100644
--- a/include/configs/pico-imx6ul.h
+++ b/include/configs/pico-imx6ul.h
@@ -21,9 +21,6 @@
 /* MMC Configs */
 #define CFG_SYS_FSL_ESDHC_ADDR	USDHC1_BASE_ADDR
 
-/* USB Configs */
-#define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-
 #define DFU_DEFAULT_POLL_TIMEOUT 300
 
 #define CFG_DFU_ENV_SETTINGS \
diff --git a/include/configs/pico-imx7d.h b/include/configs/pico-imx7d.h
index 21ec7fd3362c..89850d8e4a7e 100644
--- a/include/configs/pico-imx7d.h
+++ b/include/configs/pico-imx7d.h
@@ -105,7 +105,4 @@
 
 #define CFG_SYS_FSL_USDHC_NUM		2
 
-/* USB Configs */
-#define CFG_MXC_USB_PORTSC			(PORT_PTS_UTMI | PORT_PTS_PTW)
-
 #endif
diff --git a/include/configs/somlabs_visionsom_6ull.h b/include/configs/somlabs_visionsom_6ull.h
index aa09528acd97..c8fdb40d011b 100644
--- a/include/configs/somlabs_visionsom_6ull.h
+++ b/include/configs/somlabs_visionsom_6ull.h
@@ -59,11 +59,6 @@
 
 /* environment organization */
 
-/* USB Configs */
-#ifdef CONFIG_CMD_USB
-#define CFG_MXC_USB_PORTSC  (PORT_PTS_UTMI | PORT_PTS_PTW)
-#endif
-
 #ifdef CONFIG_CMD_NET
 #define CFG_FEC_MXC_PHYADDR		0x1
 #endif
diff --git a/include/configs/tbs2910.h b/include/configs/tbs2910.h
index 256331ae1733..9ef774afd0f9 100644
--- a/include/configs/tbs2910.h
+++ b/include/configs/tbs2910.h
@@ -25,11 +25,6 @@
 #define CFG_PCIE_IMX_PERST_GPIO	IMX_GPIO_NR(7, 12)
 #endif
 
-/* USB */
-#ifdef CONFIG_CMD_USB
-#define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-#endif /* CONFIG_CMD_USB      */
-
 #define CFG_EXTRA_ENV_SETTINGS \
 	BOOTENV \
 	"bootargs_mmc1=console=ttymxc0,115200 di0_primary console=tty1\0" \
diff --git a/include/configs/tqma6.h b/include/configs/tqma6.h
index b4a06a75c538..e85c801e4fbe 100644
--- a/include/configs/tqma6.h
+++ b/include/configs/tqma6.h
@@ -29,9 +29,6 @@
 /* MMC Configs */
 #define CFG_SYS_FSL_ESDHC_ADDR	0
 
-/* USB Configs */
-#define CFG_MXC_USB_PORTSC	(PORT_PTS_UTMI | PORT_PTS_PTW)
-
 #if defined(CONFIG_TQMA6X_MMC_BOOT)
 
 #define TQMA6_UBOOT_OFFSET		SZ_1K
diff --git a/include/configs/usbarmory.h b/include/configs/usbarmory.h
index 1d7caaa1448f..b895022ee9cc 100644
--- a/include/configs/usbarmory.h
+++ b/include/configs/usbarmory.h
@@ -22,9 +22,6 @@
 /* SD/MMC */
 #define CFG_SYS_FSL_ESDHC_ADDR	0
 
-/* USB */
-#define CFG_MXC_USB_PORTSC	(PORT_PTS_UTMI | PORT_PTS_PTW)
-
 /* Linux boot */
 
 #define BOOT_TARGET_DEVICES(func) func(MMC, mmc, 0)
diff --git a/include/configs/verdin-imx8mm.h b/include/configs/verdin-imx8mm.h
index 12d2b6823058..b018bbe29dd1 100644
--- a/include/configs/verdin-imx8mm.h
+++ b/include/configs/verdin-imx8mm.h
@@ -63,7 +63,4 @@
 #define PHYS_SDRAM_2                 0x100000000
 #define PHYS_SDRAM_2_SIZE            (long)(SZ_1G)
 
-/* USB Configs */
-#define CFG_MXC_USB_PORTSC	(PORT_PTS_UTMI | PORT_PTS_PTW)
-
 #endif /* __VERDIN_IMX8MM_H */
diff --git a/include/configs/vining_2000.h b/include/configs/vining_2000.h
index 3c2d7e668917..2cf7bc70d8de 100644
--- a/include/configs/vining_2000.h
+++ b/include/configs/vining_2000.h
@@ -36,7 +36,6 @@
 /* Network */
 #define CFG_FEC_MXC_PHYADDR          0x0
 
-#define CFG_MXC_USB_PORTSC  (PORT_PTS_UTMI | PORT_PTS_PTW)
 
 #ifdef CONFIG_CMD_PCI
 #define CFG_PCIE_IMX_PERST_GPIO	IMX_GPIO_NR(4, 6)
diff --git a/include/configs/wandboard.h b/include/configs/wandboard.h
index d64c4262bd69..b5b342b35383 100644
--- a/include/configs/wandboard.h
+++ b/include/configs/wandboard.h
@@ -16,9 +16,6 @@
 #define CFG_SYS_FSL_USDHC_NUM	2
 #define CFG_SYS_FSL_ESDHC_ADDR	0
 
-/* USB Configs */
-#define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-
 #define CFG_EXTRA_ENV_SETTINGS \
 	"console=ttymxc0\0" \
 	"splashpos=m,m\0" \
diff --git a/include/configs/warp7.h b/include/configs/warp7.h
index 0da9250c3b78..a5278d1cb9b8 100644
--- a/include/configs/warp7.h
+++ b/include/configs/warp7.h
@@ -92,7 +92,6 @@
 
 #define CFG_SYS_FSL_USDHC_NUM	1
 
-#define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
 
 /* USB Device Firmware Update support */
 #define DFU_DEFAULT_POLL_TIMEOUT	300
diff --git a/include/configs/xpress.h b/include/configs/xpress.h
index bb0a30c4344f..8efebf77c3d6 100644
--- a/include/configs/xpress.h
+++ b/include/configs/xpress.h
@@ -27,9 +27,6 @@
 
 /* Environment is in stored in the eMMC boot partition */
 
-/* USB Configs */
-#define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
-
 #define CFG_FEC_ENET_DEV		0
 #define CFG_FEC_MXC_PHYADDR          0x0
 
-- 
2.34.1

