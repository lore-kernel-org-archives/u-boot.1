Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED22C5472D
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 00:59:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBA68889C5;
	Tue, 27 Aug 2024 02:58:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i5UImScH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FDC888915; Tue, 27 Aug 2024 02:58:45 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7467288418
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 02:58:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-2689e7a941fso4173349fac.3
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 17:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724720321; x=1725325121; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/htjHiF+5O/p2xsFyWlLNTRQhtT8ZiPrOFq54gIuRdA=;
 b=i5UImScHq7RO5NSC0z3ipxB4PouOCkaZiSyQfs/axeWWCZuoRuJM/2OOVVsKl50SwU
 paFOKDaa858xLbRIKXRKDZYQah6ytanHliRqmmAuUJHZYn0r3su0cSCTaZYCKkGwGPQJ
 DF9RLMvSVlbX8Qht/LOeiUAEPxtxSCGBjNbDe4izfE/AIFmNpKERHaK2mwG1FBXPKWVO
 bPvsIZloBPEru6sr0YAxQz72uPy/a2vTWc5OC8d+fIuVsTh4d8+awe4Dj1ua/fRjXcHK
 QYB6Hk8B9tAd0y2Jzs5w1JrdjHZDFp3btqzQJc5LPhfbehISl+a26iQhnjIEAASSpxiF
 NWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724720321; x=1725325121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/htjHiF+5O/p2xsFyWlLNTRQhtT8ZiPrOFq54gIuRdA=;
 b=oImFHjG8WNxzsKCiQByl8JohStei+h8WaCF1bLQjeJfkLiG9SerGS0/gNoJ7F3jCjy
 vk+dm7DMl2/0SHngyP4qnK3sHKD6+Uf5q1uK6WkMsFCih+bv5HvDrhtEBxPM6tP3Hdtb
 x10pZKIQT3gO6OWJ4ErKU5MOtvPMw0sAdtxbNQgokCOMPScdh0WOO+1xmkuyNqDq4T/r
 hdC9FDf++px57MkXgli9qYt/5IQF29ApgMh9abgOJSB6ez9tPe7640P2O3yhnRN2NlIw
 +GXHXgvlmoTbG05AtII1TTiAprP7TRVsRA3Wy4q3uBVTdww4yM8UOAHxUbqgUo5IN2Fb
 DVqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2ZxB7zMOhsJGwM2+63+/RShhNUs/ZR5vI15SD+yLku3lbOjFsH+B31OCtnDcBhEbWwaFyH84=@lists.denx.de
X-Gm-Message-State: AOJu0YxWkjz3HEEYr+7m2QYeeRaV2vNGcld6vaAUXuaY9daYtmVHz704
 9qWoX5LDkgpUk/wPQ8+LKM8nkxsTxoXAtj0kOE6qU3LMpk8rI3bz
X-Google-Smtp-Source: AGHT+IEz1gC1ZQk5T7lVNs9rIij/7nzFSNlN/Rf46xH6hokm+vWwiJgyD1ADTAFdfZZqBKcF4uzDGQ==
X-Received: by 2002:a05:6870:a710:b0:270:1f5d:94ee with SMTP id
 586e51a60fabf-273e647fc40mr12499874fac.17.1724720321007; 
 Mon, 26 Aug 2024 17:58:41 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:bc67:f2c3:ca16:906f])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71434254057sm7560311b3a.77.2024.08.26.17.58.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 17:58:40 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: peng.fan@nxp.com
Cc: marex@denx.de, u-boot@lists.denx.de, tharvey@gateworks.com,
 Fabio Estevam <festevam@denx.de>
Subject: [PATCH 3/3] imx: Remove CFG_MXC_USB_PORTSC
Date: Mon, 26 Aug 2024 21:58:25 -0300
Message-Id: <20240827005826.2831478-3-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240827005826.2831478-1-festevam@gmail.com>
References: <20240827005826.2831478-1-festevam@gmail.com>
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

'#define CFG_MXC_USB_PORTSC     (PORT_PTS_UTMI | PORT_PTS_PTW)' can
be removed from mx5/mx6/mx7/mx8m board config files as it is the
default in drivers/usb/host/ehci-mx5.c and drivers/usb/host/ehci-mx6.c.

Suggested-by: Tim Harvey <tharvey@gateworks.com>
Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 include/configs/apalis_imx6.h            | 1 -
 include/configs/aristainetos2.h          | 1 -
 include/configs/brppt2.h                 | 1 -
 include/configs/cl-som-imx7.h            | 1 -
 include/configs/cm_fx6.h                 | 1 -
 include/configs/colibri-imx6ull.h        | 1 -
 include/configs/colibri_imx6.h           | 1 -
 include/configs/colibri_imx7.h           | 1 -
 include/configs/dart_6ul.h               | 1 -
 include/configs/dh_imx6.h                | 1 -
 include/configs/display5.h               | 1 -
 include/configs/embestmx6boards.h        | 1 -
 include/configs/ge_b1x5v2.h              | 1 -
 include/configs/gw_ventana.h             | 1 -
 include/configs/imx6_logic.h             | 1 -
 include/configs/imx6dl-mamoj.h           | 1 -
 include/configs/imx6q-bosch-acc.h        | 1 -
 include/configs/imx7-cm.h                | 1 -
 include/configs/imx8mm-cl-iot-gate.h     | 1 -
 include/configs/kontron-sl-mx6ul.h       | 1 -
 include/configs/kontron-sl-mx8mm.h       | 1 -
 include/configs/kp_imx53.h               | 1 -
 include/configs/kp_imx6q_tpc.h           | 1 -
 include/configs/liteboard.h              | 1 -
 include/configs/m53menlo.h               | 1 -
 include/configs/meerkat96.h              | 1 -
 include/configs/mx53cx9020.h             | 1 -
 include/configs/mx53loco.h               | 1 -
 include/configs/mx53ppd.h                | 1 -
 include/configs/mx6cuboxi.h              | 1 -
 include/configs/mx6memcal.h              | 1 -
 include/configs/mx6sabreauto.h           | 1 -
 include/configs/mx6sabresd.h             | 1 -
 include/configs/mx6slevk.h               | 1 -
 include/configs/mx6sllevk.h              | 1 -
 include/configs/mx6sxsabreauto.h         | 1 -
 include/configs/mx6sxsabresd.h           | 1 -
 include/configs/mx6ul_14x14_evk.h        | 1 -
 include/configs/mx7dsabresd.h            | 1 -
 include/configs/mx7ulp_com.h             | 1 -
 include/configs/mys_6ulx.h               | 1 -
 include/configs/nitrogen6x.h             | 1 -
 include/configs/novena.h                 | 1 -
 include/configs/npi_imx6ull.h            | 1 -
 include/configs/o4-imx6ull-nano.h        | 1 -
 include/configs/opos6uldev.h             | 1 -
 include/configs/pcl063.h                 | 1 -
 include/configs/pcl063_ull.h             | 1 -
 include/configs/pico-imx6.h              | 1 -
 include/configs/pico-imx6ul.h            | 1 -
 include/configs/pico-imx7d.h             | 1 -
 include/configs/somlabs_visionsom_6ull.h | 1 -
 include/configs/tbs2910.h                | 1 -
 include/configs/tqma6.h                  | 1 -
 include/configs/usbarmory.h              | 1 -
 include/configs/verdin-imx8mm.h          | 1 -
 include/configs/vining_2000.h            | 1 -
 include/configs/wandboard.h              | 1 -
 include/configs/warp7.h                  | 1 -
 include/configs/xpress.h                 | 1 -
 60 files changed, 60 deletions(-)

diff --git a/include/configs/apalis_imx6.h b/include/configs/apalis_imx6.h
index 097f819e44a4..b7f66729ed4f 100644
--- a/include/configs/apalis_imx6.h
+++ b/include/configs/apalis_imx6.h
@@ -25,7 +25,6 @@
 
 /* USB Configs */
 /* Host */
-#define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
 
 /* Framebuffer and LCD */
 
diff --git a/include/configs/aristainetos2.h b/include/configs/aristainetos2.h
index 120ff9284ef6..aade66435dd4 100644
--- a/include/configs/aristainetos2.h
+++ b/include/configs/aristainetos2.h
@@ -412,7 +412,6 @@
 /* DMA stuff, needed for GPMI/MXS NAND support */
 
 /* USB Configs */
-#define CFG_MXC_USB_PORTSC	(PORT_PTS_UTMI | PORT_PTS_PTW)
 
 /* UBI support */
 
diff --git a/include/configs/brppt2.h b/include/configs/brppt2.h
index 38c98c5e21c4..73d136d355d5 100644
--- a/include/configs/brppt2.h
+++ b/include/configs/brppt2.h
@@ -79,6 +79,5 @@ BUR_COMMON_ENV \
 #define CFG_SYS_INIT_RAM_SIZE	IRAM_SIZE
 
 /* USB Configs */
-#define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
 
 #endif	/* __CONFIG_BRPP2_IMX6_H */
diff --git a/include/configs/cl-som-imx7.h b/include/configs/cl-som-imx7.h
index 96058d48148b..816056eeacf1 100644
--- a/include/configs/cl-som-imx7.h
+++ b/include/configs/cl-som-imx7.h
@@ -96,6 +96,5 @@
 #endif
 
 /* USB Configs */
-#define CFG_MXC_USB_PORTSC  (PORT_PTS_UTMI | PORT_PTS_PTW)
 
 #endif	/* __CONFIG_H */
diff --git a/include/configs/cm_fx6.h b/include/configs/cm_fx6.h
index fc2d59751c42..afe0c3af428c 100644
--- a/include/configs/cm_fx6.h
+++ b/include/configs/cm_fx6.h
@@ -135,7 +135,6 @@
 #define CFG_FEC_MXC_PHYADDR		0
 
 /* USB */
-#define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
 
 /* Boot */
 #define CFG_SYS_BOOTMAPSZ	        (8 << 20)
diff --git a/include/configs/colibri-imx6ull.h b/include/configs/colibri-imx6ull.h
index c896a897cbf4..56276b711e3c 100644
--- a/include/configs/colibri-imx6ull.h
+++ b/include/configs/colibri-imx6ull.h
@@ -119,7 +119,6 @@
 
 /* USB Configs */
 
-#define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
 
 /* USB Device Firmware Update support */
 #define DFU_DEFAULT_POLL_TIMEOUT	300
diff --git a/include/configs/colibri_imx6.h b/include/configs/colibri_imx6.h
index 87c973883c33..76a88d113e29 100644
--- a/include/configs/colibri_imx6.h
+++ b/include/configs/colibri_imx6.h
@@ -23,7 +23,6 @@
 
 /* USB Configs */
 /* Host */
-#define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
 
 /* Command definition */
 
diff --git a/include/configs/colibri_imx7.h b/include/configs/colibri_imx7.h
index 0e0665038b1f..d406b20fe26e 100644
--- a/include/configs/colibri_imx7.h
+++ b/include/configs/colibri_imx7.h
@@ -161,6 +161,5 @@
 
 /* USB Configs */
 
-#define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
 
 #endif
diff --git a/include/configs/dart_6ul.h b/include/configs/dart_6ul.h
index 4d715d4f425e..392562fce6c0 100644
--- a/include/configs/dart_6ul.h
+++ b/include/configs/dart_6ul.h
@@ -47,7 +47,6 @@
 #define CFG_SYS_INIT_RAM_SIZE	IRAM_SIZE
 
 /* USB Configs */
-#define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
 
 #define ENV_MMC \
 	"mmcdev=" __stringify(MMC_ROOTFS_DEV) "\0" \
diff --git a/include/configs/dh_imx6.h b/include/configs/dh_imx6.h
index dc5ca9fc60cd..73308645efe6 100644
--- a/include/configs/dh_imx6.h
+++ b/include/configs/dh_imx6.h
@@ -31,7 +31,6 @@
 #define CFG_MXC_UART_BASE		UART1_BASE
 
 /* USB Configs */
-#define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
 
 /* USB Gadget (DFU, UMS) */
 #if defined(CONFIG_CMD_DFU) || defined(CONFIG_CMD_USB_MASS_STORAGE)
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
index e378374a004a..86951e135fa7 100644
--- a/include/configs/embestmx6boards.h
+++ b/include/configs/embestmx6boards.h
@@ -18,7 +18,6 @@
 #define PHYS_SDRAM_SIZE		(1u * 1024 * 1024 * 1024)
 
 /* USB Configs */
-#define CFG_MXC_USB_PORTSC	(PORT_PTS_UTMI | PORT_PTS_PTW)
 
 /* MMC Configs */
 #define CFG_SYS_FSL_ESDHC_ADDR      0
diff --git a/include/configs/ge_b1x5v2.h b/include/configs/ge_b1x5v2.h
index 0bf31897a744..27d3409f0a67 100644
--- a/include/configs/ge_b1x5v2.h
+++ b/include/configs/ge_b1x5v2.h
@@ -24,7 +24,6 @@
 #endif
 
 /* USB */
-#define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
 
 /* Memory */
 #define PHYS_SDRAM		       MMDC0_ARB_BASE_ADDR
diff --git a/include/configs/gw_ventana.h b/include/configs/gw_ventana.h
index f884d74d9ca9..374e244cc16b 100644
--- a/include/configs/gw_ventana.h
+++ b/include/configs/gw_ventana.h
@@ -36,7 +36,6 @@
 /* Various command support */
 
 /* USB Configs */
-#define CFG_MXC_USB_PORTSC     (PORT_PTS_UTMI | PORT_PTS_PTW)
 
 /* Miscellaneous configurable options */
 
diff --git a/include/configs/imx6_logic.h b/include/configs/imx6_logic.h
index 19613e838fb3..44fe3606d5b8 100644
--- a/include/configs/imx6_logic.h
+++ b/include/configs/imx6_logic.h
@@ -116,7 +116,6 @@
 
 /* USB Configs */
 #ifdef CONFIG_CMD_USB
-#define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
 #endif
 
 /* Falcon Mode */
diff --git a/include/configs/imx6dl-mamoj.h b/include/configs/imx6dl-mamoj.h
index 6651653d5e9c..e403d8e578da 100644
--- a/include/configs/imx6dl-mamoj.h
+++ b/include/configs/imx6dl-mamoj.h
@@ -43,7 +43,6 @@
 #define CFG_FEC_MXC_PHYADDR		1
 
 /* USB */
-#define CFG_MXC_USB_PORTSC			(PORT_PTS_UTMI | PORT_PTS_PTW)
 
 /* Falcon */
 
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
index 131f18290b90..59eb4f16fb50 100644
--- a/include/configs/imx7-cm.h
+++ b/include/configs/imx7-cm.h
@@ -78,6 +78,5 @@
 #define CFG_SYS_FSL_USDHC_NUM		2
 
 /* USB Configs */
-#define CFG_MXC_USB_PORTSC  (PORT_PTS_UTMI | PORT_PTS_PTW)
 
 #endif	/* __CONFIG_H */
diff --git a/include/configs/imx8mm-cl-iot-gate.h b/include/configs/imx8mm-cl-iot-gate.h
index 6442e3d570f4..79bd29fa6efb 100644
--- a/include/configs/imx8mm-cl-iot-gate.h
+++ b/include/configs/imx8mm-cl-iot-gate.h
@@ -138,6 +138,5 @@
 #define CFG_FEC_MXC_PHYADDR		-1 /* Auto search of PHY on MII */
 
 /* USB Configs */
-#define CFG_MXC_USB_PORTSC	(PORT_PTS_UTMI | PORT_PTS_PTW)
 
 #endif /*__IMX8MM_CL_IOT_GATE_H*/
diff --git a/include/configs/kontron-sl-mx6ul.h b/include/configs/kontron-sl-mx6ul.h
index e68c667c5057..3d6715004800 100644
--- a/include/configs/kontron-sl-mx6ul.h
+++ b/include/configs/kontron-sl-mx6ul.h
@@ -25,7 +25,6 @@
 #define CFG_MXC_UART_BASE		UART4_BASE
 
 #ifdef CONFIG_USB_EHCI_HCD
-#define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
 #endif
 
 /* Boot order for distro boot */
diff --git a/include/configs/kontron-sl-mx8mm.h b/include/configs/kontron-sl-mx8mm.h
index be1f70a9a598..131f882c65ca 100644
--- a/include/configs/kontron-sl-mx8mm.h
+++ b/include/configs/kontron-sl-mx8mm.h
@@ -25,7 +25,6 @@
 /* Board and environment settings */
 
 #ifdef CONFIG_USB_EHCI_HCD
-#define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
 #endif
 
 /* GUID for capsule updatable firmware image */
diff --git a/include/configs/kp_imx53.h b/include/configs/kp_imx53.h
index 91caf03091c4..c41b4a368fbe 100644
--- a/include/configs/kp_imx53.h
+++ b/include/configs/kp_imx53.h
@@ -11,7 +11,6 @@
 #include <linux/sizes.h>
 
 /* USB Configs */
-#define CFG_MXC_USB_PORTSC	(PORT_PTS_UTMI | PORT_PTS_PTW)
 
 /* Command definition */
 
diff --git a/include/configs/kp_imx6q_tpc.h b/include/configs/kp_imx6q_tpc.h
index 74f6e4e9f963..a6ba31c5a3e0 100644
--- a/include/configs/kp_imx6q_tpc.h
+++ b/include/configs/kp_imx6q_tpc.h
@@ -18,7 +18,6 @@
 
 /* USB Configs */
 #ifdef CONFIG_CMD_USB
-#define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
 #endif
 
 #define CFG_EXTRA_ENV_SETTINGS	\
diff --git a/include/configs/liteboard.h b/include/configs/liteboard.h
index 25c30e6c6a5d..dc6d9e9dd2e1 100644
--- a/include/configs/liteboard.h
+++ b/include/configs/liteboard.h
@@ -95,7 +95,6 @@
 
 /* USB Configs */
 #ifdef CONFIG_CMD_USB
-#define CFG_MXC_USB_PORTSC  (PORT_PTS_UTMI | PORT_PTS_PTW)
 #endif
 
 #ifdef CONFIG_CMD_NET
diff --git a/include/configs/m53menlo.h b/include/configs/m53menlo.h
index 1491c509820d..a668eb70fc73 100644
--- a/include/configs/m53menlo.h
+++ b/include/configs/m53menlo.h
@@ -71,7 +71,6 @@
  */
 #ifdef CONFIG_CMD_USB
 #define CFG_MXC_USB_PORT		1
-#define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
 #endif
 
 /* LVDS display */
diff --git a/include/configs/meerkat96.h b/include/configs/meerkat96.h
index 6ffc1282411a..c8b65ebbb8e5 100644
--- a/include/configs/meerkat96.h
+++ b/include/configs/meerkat96.h
@@ -24,6 +24,5 @@
 /* Environment configs */
 
 /* USB configs */
-#define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
 
 #endif
diff --git a/include/configs/mx53cx9020.h b/include/configs/mx53cx9020.h
index ab6b0b65556e..278b45f0c221 100644
--- a/include/configs/mx53cx9020.h
+++ b/include/configs/mx53cx9020.h
@@ -23,7 +23,6 @@
 
 /* USB Configs */
 #define CFG_MXC_USB_PORT	1
-#define CFG_MXC_USB_PORTSC	(PORT_PTS_UTMI | PORT_PTS_PTW)
 
 /* Command definition */
 
diff --git a/include/configs/mx53loco.h b/include/configs/mx53loco.h
index 04f4b7232099..9b69ee6bcdd7 100644
--- a/include/configs/mx53loco.h
+++ b/include/configs/mx53loco.h
@@ -18,7 +18,6 @@
 
 /* USB Configs */
 #define CFG_MXC_USB_PORT	1
-#define CFG_MXC_USB_PORTSC	(PORT_PTS_UTMI | PORT_PTS_PTW)
 
 /* PMIC Controller */
 #define CFG_SYS_DIALOG_PMIC_I2C_ADDR	0x48
diff --git a/include/configs/mx53ppd.h b/include/configs/mx53ppd.h
index 3c9a9fb045b6..7dddabfb85ba 100644
--- a/include/configs/mx53ppd.h
+++ b/include/configs/mx53ppd.h
@@ -13,7 +13,6 @@
 
 /* USB Configs */
 #define CFG_MXC_USB_PORT	1
-#define CFG_MXC_USB_PORTSC	(PORT_PTS_UTMI | PORT_PTS_PTW)
 
 /* Command definition */
 
diff --git a/include/configs/mx6cuboxi.h b/include/configs/mx6cuboxi.h
index f0d6405d3012..fa11c5e7f61c 100644
--- a/include/configs/mx6cuboxi.h
+++ b/include/configs/mx6cuboxi.h
@@ -15,7 +15,6 @@
 #define CFG_SYS_FSL_ESDHC_ADDR	USDHC2_BASE_ADDR
 
 /* USB */
-#define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
 
 /* Command definition */
 
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
index eb963cbb0b3b..63715f920465 100644
--- a/include/configs/mx6sabreauto.h
+++ b/include/configs/mx6sabreauto.h
@@ -12,7 +12,6 @@
 #define CONSOLE_DEV		"ttymxc3"
 
 /* USB Configs */
-#define CFG_MXC_USB_PORTSC	(PORT_PTS_UTMI | PORT_PTS_PTW)
 
 #define CFG_SYS_I2C_PCA953X_WIDTH	{ {0x30, 8}, {0x32, 8}, {0x34, 8} }
 
diff --git a/include/configs/mx6sabresd.h b/include/configs/mx6sabresd.h
index 9160f878f4b3..b19b1c03fb65 100644
--- a/include/configs/mx6sabresd.h
+++ b/include/configs/mx6sabresd.h
@@ -26,7 +26,6 @@
 
 /* USB Configs */
 #ifdef CONFIG_CMD_USB
-#define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
 #endif
 
 #endif                         /* __MX6SABRESD_CONFIG_H */
diff --git a/include/configs/mx6slevk.h b/include/configs/mx6slevk.h
index 65c6cdd4b87b..ed84296803da 100644
--- a/include/configs/mx6slevk.h
+++ b/include/configs/mx6slevk.h
@@ -90,7 +90,6 @@
 
 /* USB Configs */
 #ifdef CONFIG_CMD_USB
-#define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
 #endif
 
 #define CFG_SYS_FSL_USDHC_NUM	3
diff --git a/include/configs/mx6sllevk.h b/include/configs/mx6sllevk.h
index 290996b51bc7..0948b5db100e 100644
--- a/include/configs/mx6sllevk.h
+++ b/include/configs/mx6sllevk.h
@@ -94,7 +94,6 @@
 
 /* USB Configs */
 #ifdef CONFIG_CMD_USB
-#define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
 #endif
 
 #include <linux/stringify.h>
diff --git a/include/configs/mx6sxsabreauto.h b/include/configs/mx6sxsabreauto.h
index 4e163d28e63d..e47dc41a38b2 100644
--- a/include/configs/mx6sxsabreauto.h
+++ b/include/configs/mx6sxsabreauto.h
@@ -96,7 +96,6 @@
 #define CFG_FEC_MXC_PHYADDR          0x0
 
 #ifdef CONFIG_CMD_USB
-#define CFG_MXC_USB_PORTSC  (PORT_PTS_UTMI | PORT_PTS_PTW)
 #endif
 
 #define CFG_SYS_FSL_USDHC_NUM	2
diff --git a/include/configs/mx6sxsabresd.h b/include/configs/mx6sxsabresd.h
index b43a1d813151..b848f6f4426e 100644
--- a/include/configs/mx6sxsabresd.h
+++ b/include/configs/mx6sxsabresd.h
@@ -118,7 +118,6 @@
 #define CFG_FEC_MXC_PHYADDR          0x1
 
 #ifdef CONFIG_CMD_USB
-#define CFG_MXC_USB_PORTSC  (PORT_PTS_UTMI | PORT_PTS_PTW)
 #endif
 
 #ifdef CONFIG_CMD_PCI
diff --git a/include/configs/mx6ul_14x14_evk.h b/include/configs/mx6ul_14x14_evk.h
index fd0c87ffb012..c6a41d762ee4 100644
--- a/include/configs/mx6ul_14x14_evk.h
+++ b/include/configs/mx6ul_14x14_evk.h
@@ -116,7 +116,6 @@
 
 /* USB Configs */
 #ifdef CONFIG_CMD_USB
-#define CFG_MXC_USB_PORTSC  (PORT_PTS_UTMI | PORT_PTS_PTW)
 #endif
 
 #ifdef CONFIG_CMD_NET
diff --git a/include/configs/mx7dsabresd.h b/include/configs/mx7dsabresd.h
index 94bee75fdea5..a0a5f7d09338 100644
--- a/include/configs/mx7dsabresd.h
+++ b/include/configs/mx7dsabresd.h
@@ -99,6 +99,5 @@
 #endif
 
 /* USB Configs */
-#define CFG_MXC_USB_PORTSC  (PORT_PTS_UTMI | PORT_PTS_PTW)
 
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
index 8defdfc4fda6..c5f85e4a8478 100644
--- a/include/configs/mys_6ulx.h
+++ b/include/configs/mys_6ulx.h
@@ -30,7 +30,6 @@
 #define CFG_SYS_NAND_BASE		0x40000000
 
 /* USB Configs */
-#define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
 
 #define CFG_EXTRA_ENV_SETTINGS \
 	"console=ttymxc0,115200n8\0" \
diff --git a/include/configs/nitrogen6x.h b/include/configs/nitrogen6x.h
index a8ad85050f79..9e8ac943a880 100644
--- a/include/configs/nitrogen6x.h
+++ b/include/configs/nitrogen6x.h
@@ -19,7 +19,6 @@
 #define CFG_FEC_MXC_PHYADDR		6
 
 /* USB Configs */
-#define CFG_MXC_USB_PORTSC	(PORT_PTS_UTMI | PORT_PTS_PTW)
 
 #ifdef CONFIG_CMD_MMC
 #define DISTRO_BOOT_DEV_MMC(func) func(MMC, mmc, 0) func(MMC, mmc, 1)
diff --git a/include/configs/novena.h b/include/configs/novena.h
index 144cf1b4a4b8..2fd7a53b0505 100644
--- a/include/configs/novena.h
+++ b/include/configs/novena.h
@@ -53,7 +53,6 @@
 
 /* USB Configs */
 #ifdef CONFIG_CMD_USB
-#define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
 #endif
 
 /* Extra U-Boot environment. */
diff --git a/include/configs/npi_imx6ull.h b/include/configs/npi_imx6ull.h
index f71e2657076b..ce1d3f9e7459 100644
--- a/include/configs/npi_imx6ull.h
+++ b/include/configs/npi_imx6ull.h
@@ -29,7 +29,6 @@
 #define CFG_SYS_NAND_BASE		0x40000000
 
 /* USB Configs */
-#define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
 
 #ifdef CONFIG_CMD_NET
 #define CFG_FEC_MXC_PHYADDR		0x1
diff --git a/include/configs/o4-imx6ull-nano.h b/include/configs/o4-imx6ull-nano.h
index 9050da8738b1..23c26b67c258 100644
--- a/include/configs/o4-imx6ull-nano.h
+++ b/include/configs/o4-imx6ull-nano.h
@@ -12,7 +12,6 @@
 #define CFG_SYS_INIT_RAM_SIZE	IRAM_SIZE
 
 #if IS_ENABLED(CONFIG_CMD_USB)
-#	define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
 #endif /* CONFIG_CMD_USB */
 
 #define CFG_EXTRA_ENV_SETTINGS \
diff --git a/include/configs/opos6uldev.h b/include/configs/opos6uldev.h
index 12020d31e1c7..45cefd6ab2da 100644
--- a/include/configs/opos6uldev.h
+++ b/include/configs/opos6uldev.h
@@ -19,7 +19,6 @@
 
 /* USB */
 #ifdef CONFIG_USB_EHCI_MX6
-#define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
 #endif
 
 /* LCD */
diff --git a/include/configs/pcl063.h b/include/configs/pcl063.h
index 2a729c3e4544..fc061d1b6901 100644
--- a/include/configs/pcl063.h
+++ b/include/configs/pcl063.h
@@ -42,7 +42,6 @@
 #define CFG_SYS_NAND_BASE		0x40000000
 
 /* USB Configs */
-#define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
 
 #define CFG_EXTRA_ENV_SETTINGS \
 	"console=ttymxc0,115200n8\0" \
diff --git a/include/configs/pcl063_ull.h b/include/configs/pcl063_ull.h
index afa8e7aeb716..f5d640a2e45e 100644
--- a/include/configs/pcl063_ull.h
+++ b/include/configs/pcl063_ull.h
@@ -44,7 +44,6 @@
 #define CFG_SYS_NAND_BASE		0x40000000
 
 /* USB Configs */
-#define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
 
 #define ENV_MMC \
 	"mmcdev=" __stringify(MMC_ROOTFS_DEV) "\0" \
diff --git a/include/configs/pico-imx6.h b/include/configs/pico-imx6.h
index 6ccb3dc19021..8bce836f18fe 100644
--- a/include/configs/pico-imx6.h
+++ b/include/configs/pico-imx6.h
@@ -16,7 +16,6 @@
 #define CFG_SYS_FSL_ESDHC_ADDR	USDHC3_BASE_ADDR
 
 /* USB Configs */
-#define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
 
 #define DFU_DEFAULT_POLL_TIMEOUT 300
 
diff --git a/include/configs/pico-imx6ul.h b/include/configs/pico-imx6ul.h
index ef8281440e5d..42e9d40fd7ee 100644
--- a/include/configs/pico-imx6ul.h
+++ b/include/configs/pico-imx6ul.h
@@ -22,7 +22,6 @@
 #define CFG_SYS_FSL_ESDHC_ADDR	USDHC1_BASE_ADDR
 
 /* USB Configs */
-#define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
 
 #define DFU_DEFAULT_POLL_TIMEOUT 300
 
diff --git a/include/configs/pico-imx7d.h b/include/configs/pico-imx7d.h
index 21ec7fd3362c..919fc4db8dfe 100644
--- a/include/configs/pico-imx7d.h
+++ b/include/configs/pico-imx7d.h
@@ -106,6 +106,5 @@
 #define CFG_SYS_FSL_USDHC_NUM		2
 
 /* USB Configs */
-#define CFG_MXC_USB_PORTSC			(PORT_PTS_UTMI | PORT_PTS_PTW)
 
 #endif
diff --git a/include/configs/somlabs_visionsom_6ull.h b/include/configs/somlabs_visionsom_6ull.h
index aa09528acd97..cad37fccbac9 100644
--- a/include/configs/somlabs_visionsom_6ull.h
+++ b/include/configs/somlabs_visionsom_6ull.h
@@ -61,7 +61,6 @@
 
 /* USB Configs */
 #ifdef CONFIG_CMD_USB
-#define CFG_MXC_USB_PORTSC  (PORT_PTS_UTMI | PORT_PTS_PTW)
 #endif
 
 #ifdef CONFIG_CMD_NET
diff --git a/include/configs/tbs2910.h b/include/configs/tbs2910.h
index 256331ae1733..eb5fdae0ea86 100644
--- a/include/configs/tbs2910.h
+++ b/include/configs/tbs2910.h
@@ -27,7 +27,6 @@
 
 /* USB */
 #ifdef CONFIG_CMD_USB
-#define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
 #endif /* CONFIG_CMD_USB      */
 
 #define CFG_EXTRA_ENV_SETTINGS \
diff --git a/include/configs/tqma6.h b/include/configs/tqma6.h
index b4a06a75c538..1da7e855a250 100644
--- a/include/configs/tqma6.h
+++ b/include/configs/tqma6.h
@@ -30,7 +30,6 @@
 #define CFG_SYS_FSL_ESDHC_ADDR	0
 
 /* USB Configs */
-#define CFG_MXC_USB_PORTSC	(PORT_PTS_UTMI | PORT_PTS_PTW)
 
 #if defined(CONFIG_TQMA6X_MMC_BOOT)
 
diff --git a/include/configs/usbarmory.h b/include/configs/usbarmory.h
index 28d86a263628..ffeead40573f 100644
--- a/include/configs/usbarmory.h
+++ b/include/configs/usbarmory.h
@@ -24,7 +24,6 @@
 
 /* USB */
 #define CFG_MXC_USB_PORT	1
-#define CFG_MXC_USB_PORTSC	(PORT_PTS_UTMI | PORT_PTS_PTW)
 
 /* Linux boot */
 
diff --git a/include/configs/verdin-imx8mm.h b/include/configs/verdin-imx8mm.h
index 12d2b6823058..31d153870af4 100644
--- a/include/configs/verdin-imx8mm.h
+++ b/include/configs/verdin-imx8mm.h
@@ -64,6 +64,5 @@
 #define PHYS_SDRAM_2_SIZE            (long)(SZ_1G)
 
 /* USB Configs */
-#define CFG_MXC_USB_PORTSC	(PORT_PTS_UTMI | PORT_PTS_PTW)
 
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
index d64c4262bd69..9b2d4eb55966 100644
--- a/include/configs/wandboard.h
+++ b/include/configs/wandboard.h
@@ -17,7 +17,6 @@
 #define CFG_SYS_FSL_ESDHC_ADDR	0
 
 /* USB Configs */
-#define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
 
 #define CFG_EXTRA_ENV_SETTINGS \
 	"console=ttymxc0\0" \
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
index bb0a30c4344f..877e1a00b104 100644
--- a/include/configs/xpress.h
+++ b/include/configs/xpress.h
@@ -28,7 +28,6 @@
 /* Environment is in stored in the eMMC boot partition */
 
 /* USB Configs */
-#define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
 
 #define CFG_FEC_ENET_DEV		0
 #define CFG_FEC_MXC_PHYADDR          0x0
-- 
2.34.1

