Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A5DBFA3738
	for <u-boot@archiver.kernel.org>; Fri, 13 Sep 2024 10:01:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B023888D56;
	Fri, 13 Sep 2024 11:57:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="FfcKMZAc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65A3688DC6; Fri, 13 Sep 2024 11:57:40 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87BE388D5A
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 11:57:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a8a7b1c2f2bso304900666b.0
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 02:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1726221452; x=1726826252;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L7mEd5w5V+Lck0eWh6HqPKgdx4EIxLO43nvUmkqR8js=;
 b=FfcKMZAc0cU/4LDN/aemqzfC1QTJBFnzlmYMJVH4DMwhcnkBW2G+R/isZV+sHAH18k
 SdzreWTAiVrLm1ZRwk02LNc2QBHGXoXt/8rpODTciPhTH11XbFi9VhBBooTYXsWhs4NW
 w9DNHEonSMO/MGuEeyHPb6wvDR2aJpdvXm1ms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726221452; x=1726826252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L7mEd5w5V+Lck0eWh6HqPKgdx4EIxLO43nvUmkqR8js=;
 b=GDXP2xhzc4B3ufUxCNqUWuOmulQQSpBnw53CT5LSh9tJ/n8/+UbuJ3d+l/T+pzy5rq
 +GeubKhhzklyvGPilqtLFv67unG8f6YGaDo+y+L+9TIXc3zaRK/0UDQI72DKmdG6MxNc
 Qnptr2I0/6TFmPSknPCGUuylBd/uhjbwaexeXF2A/gqXJ3Y2jtApTm4lojhVKU67lsZf
 TigUjMnpnATPxnV5YZLYqbg8QF1sQ4bbH9e73Jmi740x6Pp1op733Ia2rzEjz5lsul72
 vzUe12Y6h9WB2lTzDqMbLeiDmiYLj1RDxY18i4FbrfZ/DxAxBJY98F00Zvm8q+tGA8TS
 mU8g==
X-Gm-Message-State: AOJu0Ywklx8tDYi7An57y/FW6iEc3PKc9J35S1wqy4SuSE3y1XPZkDCq
 87yi5ChSlTqA1C6jbyqEc+pMoPX74rIbdkG2V+Z/sOxHe98dQ3teA8vyWt4N5YV3gO+VTz31n57
 H6qI=
X-Google-Smtp-Source: AGHT+IFK1AqVCPe6UohxZ8HAIkCqQOYf9xvSxy1uDX4ZdWviFkdpDMb6zVcLBO6cyAXnWJ9RPEZptw==
X-Received: by 2002:a17:907:6096:b0:a8b:6ee7:ba26 with SMTP id
 a640c23a62f3a-a90294a88d5mr595854766b.1.1726221451563; 
 Fri, 13 Sep 2024 02:57:31 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-87-4-102-18.retail.telecomitalia.it. [87.4.102.18])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25cee72bsm863224766b.173.2024.09.13.02.57.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 02:57:31 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@denx.de>, linux-amarula@amarulasolutions.com,
 michael@amarulasolutions.com, Miquel Raynal <miquel.raynal@bootlin.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Patrick Barsanti <patrick.barsanti@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 26/26] imx8mn_bsh_smm_s2/pro: add splash screen with BSH logo
Date: Fri, 13 Sep 2024 11:56:08 +0200
Message-ID: <20240913095622.72377-27-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240913095622.72377-1-dario.binacchi@amarulasolutions.com>
References: <20240913095622.72377-1-dario.binacchi@amarulasolutions.com>
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

Display the BSH logo with features VIDEO_LOGO and SPLASH_SCREEN on
imx8mn_bsh_smm_s2/pro boards.

With CONFIG_SYS_VENDOR = "bsh", the logo bsh.bmp is selected, loaded at
the address indicated by splashimage and centered with "splashpos=m,m".

Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

 configs/imx8mn_bsh_smm_s2_defconfig        |   3 +++
 configs/imx8mn_bsh_smm_s2pro_defconfig     |   3 +++
 include/configs/imx8mn_bsh_smm_s2.h        |   1 +
 include/configs/imx8mn_bsh_smm_s2_common.h |   4 ++++
 include/configs/imx8mn_bsh_smm_s2pro.h     |   1 +
 tools/logos/bsh.bmp                        | Bin 0 -> 10644 bytes
 6 files changed, 12 insertions(+)
 create mode 100644 tools/logos/bsh.bmp

diff --git a/configs/imx8mn_bsh_smm_s2_defconfig b/configs/imx8mn_bsh_smm_s2_defconfig
index 4982b58407c6..b3190945c59c 100644
--- a/configs/imx8mn_bsh_smm_s2_defconfig
+++ b/configs/imx8mn_bsh_smm_s2_defconfig
@@ -123,10 +123,13 @@ CONFIG_USB_GADGET_VENDOR_NUM=0x0525
 CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
 CONFIG_CI_UDC=y
 CONFIG_VIDEO=y
+CONFIG_VIDEO_LOGO=y
 CONFIG_VIDEO_LCD_SYNAPTICS_R63353=y
 CONFIG_VIDEO_BRIDGE_SAMSUNG_DSIM=y
 CONFIG_VIDEO_MXS=y
 CONFIG_VIDEO_DT_SIMPLEFB=y
+CONFIG_SPLASH_SCREEN=y
+CONFIG_SPLASH_SCREEN_ALIGN=y
 CONFIG_BMP_16BPP=y
 CONFIG_BMP_24BPP=y
 CONFIG_BMP_32BPP=y
diff --git a/configs/imx8mn_bsh_smm_s2pro_defconfig b/configs/imx8mn_bsh_smm_s2pro_defconfig
index 7ae99adf7fad..db83a326c053 100644
--- a/configs/imx8mn_bsh_smm_s2pro_defconfig
+++ b/configs/imx8mn_bsh_smm_s2pro_defconfig
@@ -112,10 +112,13 @@ CONFIG_USB_GADGET_VENDOR_NUM=0x0525
 CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
 CONFIG_CI_UDC=y
 CONFIG_VIDEO=y
+CONFIG_VIDEO_LOGO=y
 CONFIG_VIDEO_LCD_SYNAPTICS_R63353=y
 CONFIG_VIDEO_BRIDGE_SAMSUNG_DSIM=y
 CONFIG_VIDEO_MXS=y
 CONFIG_VIDEO_DT_SIMPLEFB=y
+CONFIG_SPLASH_SCREEN=y
+CONFIG_SPLASH_SCREEN_ALIGN=y
 CONFIG_BMP_16BPP=y
 CONFIG_BMP_24BPP=y
 CONFIG_BMP_32BPP=y
diff --git a/include/configs/imx8mn_bsh_smm_s2.h b/include/configs/imx8mn_bsh_smm_s2.h
index deeed9c2f582..c8bd55fd3744 100644
--- a/include/configs/imx8mn_bsh_smm_s2.h
+++ b/include/configs/imx8mn_bsh_smm_s2.h
@@ -38,6 +38,7 @@
 #define CFG_EXTRA_ENV_SETTINGS \
 	MEM_LAYOUT_ENV_SETTINGS \
 	NANDARGS \
+	SPLASH_ENV_SETTINGS \
 	BOOTENV
 
 #define PHYS_SDRAM_SIZE			SZ_256M
diff --git a/include/configs/imx8mn_bsh_smm_s2_common.h b/include/configs/imx8mn_bsh_smm_s2_common.h
index 204fc4b31647..5d6b22e04139 100644
--- a/include/configs/imx8mn_bsh_smm_s2_common.h
+++ b/include/configs/imx8mn_bsh_smm_s2_common.h
@@ -21,6 +21,10 @@
 	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0" \
 	"bootcmd_mfg=echo Running fastboot mode; fastboot usb 0\0" \
 
+#define SPLASH_ENV_SETTINGS \
+	"splashimage=0x5bb00000\0" \
+	"splashpos=m,m\0" \
+
 /* Link Definitions */
 
 #define CFG_SYS_INIT_RAM_ADDR	0x40000000
diff --git a/include/configs/imx8mn_bsh_smm_s2pro.h b/include/configs/imx8mn_bsh_smm_s2pro.h
index 8619fdde7fdb..dd26e0b885d2 100644
--- a/include/configs/imx8mn_bsh_smm_s2pro.h
+++ b/include/configs/imx8mn_bsh_smm_s2pro.h
@@ -25,6 +25,7 @@
 #define CFG_EXTRA_ENV_SETTINGS \
 	MEM_LAYOUT_ENV_SETTINGS \
 	EMMCARGS \
+	SPLASH_ENV_SETTINGS \
 	BOOTENV
 
 #define PHYS_SDRAM_SIZE			SZ_512M
diff --git a/tools/logos/bsh.bmp b/tools/logos/bsh.bmp
new file mode 100644
index 0000000000000000000000000000000000000000..5b6fb1ebd50d70c7f5ce4a51042271e9634d8d81
GIT binary patch
literal 10644
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
EzX&OIXaE2J

literal 0
HcmV?d00001

-- 
2.43.0

