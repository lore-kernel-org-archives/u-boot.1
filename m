Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC830CD1283
	for <u-boot@archiver.kernel.org>; Fri, 29 Mar 2024 17:52:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78A498826F;
	Fri, 29 Mar 2024 18:52:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="I3qOrGgD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74DD688263; Fri, 29 Mar 2024 18:52:02 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 064608824A
 for <u-boot@lists.denx.de>; Fri, 29 Mar 2024 18:51:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4154471fb59so12407445e9.3
 for <u-boot@lists.denx.de>; Fri, 29 Mar 2024 10:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711734718; x=1712339518; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sjhrrgYnsho6f1EhNidfi7Gxs46121Qo+nftv0lMnmQ=;
 b=I3qOrGgDCT4VBhP0Tu2yo6X0nTi82h3FMZde9Er1tTzv2Jrc6ungTsZrt5ZOyU18I9
 feMPM8sXEGWtO9WnmIv/8H+YudCJ5uPQHSHdmWyjwQKMfS4UmC/kCnLV/N03+FXXocKD
 iUB7ptSe9w/cJACQQnQcEe27oyeN2kMl//AzjfOE7JDbD61CtJTN19LToFmDtvUjQwux
 vVa/Gkii+XR+hL2D8tQjrqcSJ2Kvwln4yYrCa3JzxIXS20Vy+jC6w0FIaBcqT+FAykz8
 yVAIQZc3rLQ6x5ldBLI2vFJQel8K4/9GBfuqZUqcDRZ6g3sdAqFUUdSuZdRe48GXhgUi
 dUVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711734718; x=1712339518;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sjhrrgYnsho6f1EhNidfi7Gxs46121Qo+nftv0lMnmQ=;
 b=IDdN5nqbGRIRhMDa4sJO9sffF0N1lL5pomBzEaRLvaFio8I52NPMw6FReTu9VpBvEd
 VP1pjZ0CAnu3dKCszLGWX8Csiv3drkoeH+uIKieXA+1mFD/Mzp0FPOd0Hw/PHjPoIJt7
 XNUJ37/ZV3jfvXNfcqyMdkT5sWtoyO+OyL9VD2O0dYAwBIU/JCMpbbNb96kLlJL3vvPr
 1HGMrH2xoM/RmLr6vjeEY/CAS6rewwGswm0F305MkqZF/4hlcp0jjRBAA+i8E90uvlsU
 uqP7mqZR7TLc8Ng8DtN6TKTNv7v+HDOBLs89sDgu3Vhx2QJLIRIVNj/QPNoDLv+mZVSc
 zp3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4vtzxyEF8oc6CajbUGGEkmmnRtN2W6Kbn4boWOVPTlkWCSC38QABJlWphA23gxkuro0lMWEkTnCSR8MxsdXDHERTUKQ==
X-Gm-Message-State: AOJu0YyhP1srfxhtLxezAS0OE7sEbijKVapbQseYKLI6hNDPVrSh5U2q
 wenOOqUVucdlcoVWYeffzTQsrGCmxZEkaDP/Owu4nmGoovpikbRB4dIFZyLjZKc=
X-Google-Smtp-Source: AGHT+IHj0Z/gQGHM6BQd05z5AusRULZHZx1BarCwdZmdiKYBLloWgQ5ax+n9OBF1HGo4sd/6r87A/A==
X-Received: by 2002:a05:600c:a07:b0:415:59b:f665 with SMTP id
 z7-20020a05600c0a0700b00415059bf665mr2028832wmp.26.1711734717934; 
 Fri, 29 Mar 2024 10:51:57 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 d7-20020a05600c3ac700b00415509b33c0sm2127781wms.10.2024.03.29.10.51.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Mar 2024 10:51:57 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 29 Mar 2024 18:51:51 +0100
Subject: [PATCH v2 4/5] dts: meson-g12a: Switch to using upstream DT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240329-u-boot-of-upstream-v2-4-2512ad3eb63d@linaro.org>
References: <20240329-u-boot-of-upstream-v2-0-2512ad3eb63d@linaro.org>
In-Reply-To: <20240329-u-boot-of-upstream-v2-0-2512ad3eb63d@linaro.org>
To: Tom Rini <trini@konsulko.com>, Vyacheslav Bocharov <adeep@lexina.in>, 
 Christian Hewitt <christianshewitt@gmail.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=14062;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=3LwbmNpWlg5H5nvc8XRDOkA7qKxKvwZIOvLVUg0nTLI=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmBv+3fW7NOyFgP4fBYUJobmJiXRUfpoMzsKpHTgVO
 3EQhw0WJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZgb/twAKCRB33NvayMhJ0XUXD/
 wOxyv3P8Be2kyKrRg2EelwAlr/NJ5nCYtMKqLmuqii/SiT+58EDr2lR2MlK5gbYdEDNci09+t8OKRB
 uobZvyfJLZ06r6prrpp300QzXLvM0Kfwcs3URv4AT/AaLuev1ZQW5xgjgiPXjj2uOgYIEXO+TaH6cS
 nqieGzzrHO/7TP3XtYZW/Sv8um8V8z6EQHbXPdsZMoX8WlZwxAea1p3F4EJAlwaCm1eHNz0a1QuB7b
 dnvZvK4GCggnIBwnlXOXBckpiL4HrS/Inz8L8AKlvpR5asDEYLpyMl7ObJbz7+TgzJlgjCu4uMsEd+
 8u3yFOoSHEIMYO9Dv5PGnsOL5aIpSfZMuO/LGyMujEy5qGnBPGdCQ5E7b4y8YM8nE//h252QBwRKcy
 oCMH6bN95649Q/XH+A0ej+5BHFCTOswlV/dwlXi0rMHs491TI0zVROP9nGSKBpYBmKgw/LDoIiwcUk
 aU6paU5yPE591K5fDmpxkdhNoIsZdhDq/YG0tBZ+dtSAEOtg0R1LPSxo8AZPJlyXQ7JSHOp8ZNxru0
 A7LnrZpRc0IaPQlxZE+ATS4tAJGCloFsH9NGAgKSJ6BYD351uRIqESKr2cy9rOumOn80ngFGts+mS/
 FL7OpHl4rDU4P5vrnGijZUchUQSFkoz3AuYsRc7UHRh/V7apMDfY20O5en4w==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Enable OF_UPSTREAM to use upstream DT and add amlogic/ prefix to the
DEFAULT_DEVICE_TREE. And thereby directly build DTB from dts/upstream/src/
including *-u-boot.dtsi files from arch/$(ARCH)/dts/ directory.

Cc: Sumit Garg <sumit.garg@linaro.org>
Acked-by: Viacheslav Bocharov <adeep@lexina.in>
Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm/mach-meson/Kconfig               | 1 +
 configs/bananapi-cm4-cm4io_defconfig      | 2 +-
 configs/bananapi-m2-pro_defconfig         | 2 +-
 configs/bananapi-m2s_defconfig            | 2 +-
 configs/bananapi-m5_defconfig             | 2 +-
 configs/beelink-gsking-x_defconfig        | 2 +-
 configs/beelink-gtking_defconfig          | 2 +-
 configs/beelink-gtkingpro_defconfig       | 2 +-
 configs/khadas-vim3_android_ab_defconfig  | 2 +-
 configs/khadas-vim3_android_defconfig     | 2 +-
 configs/khadas-vim3_defconfig             | 2 +-
 configs/khadas-vim3l_android_ab_defconfig | 2 +-
 configs/khadas-vim3l_android_defconfig    | 2 +-
 configs/khadas-vim3l_defconfig            | 2 +-
 configs/odroid-c4_defconfig               | 2 +-
 configs/odroid-go-ultra_defconfig         | 2 +-
 configs/odroid-hc4_defconfig              | 2 +-
 configs/odroid-n2_defconfig               | 2 +-
 configs/odroid-n2l_defconfig              | 2 +-
 configs/radxa-zero2_defconfig             | 2 +-
 configs/radxa-zero_defconfig              | 2 +-
 configs/sei510_defconfig                  | 2 +-
 configs/sei610_defconfig                  | 2 +-
 configs/u200_defconfig                    | 2 +-
 24 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
index 1d837ae0f3..7570f48e25 100644
--- a/arch/arm/mach-meson/Kconfig
+++ b/arch/arm/mach-meson/Kconfig
@@ -53,6 +53,7 @@ config MESON_AXG
 config MESON_G12A
 	bool "G12A"
 	select MESON64_COMMON
+	imply OF_UPSTREAM
 	help
 	  Select this if your SoC is an S905X/D2
 
diff --git a/configs/bananapi-cm4-cm4io_defconfig b/configs/bananapi-cm4-cm4io_defconfig
index 116147fc9a..cb78dabc13 100644
--- a/configs/bananapi-cm4-cm4io_defconfig
+++ b/configs/bananapi-cm4-cm4io_defconfig
@@ -6,7 +6,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-g12b-bananapi-cm4-cm4io"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-g12b-bananapi-cm4-cm4io"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
diff --git a/configs/bananapi-m2-pro_defconfig b/configs/bananapi-m2-pro_defconfig
index 755bccb4a7..196bc4077d 100644
--- a/configs/bananapi-m2-pro_defconfig
+++ b/configs/bananapi-m2-pro_defconfig
@@ -6,7 +6,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-sm1-bananapi-m2-pro"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-sm1-bananapi-m2-pro"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
diff --git a/configs/bananapi-m2s_defconfig b/configs/bananapi-m2s_defconfig
index af8daced62..7b137d5e1c 100644
--- a/configs/bananapi-m2s_defconfig
+++ b/configs/bananapi-m2s_defconfig
@@ -6,7 +6,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-g12b-a311d-bananapi-m2s"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-g12b-a311d-bananapi-m2s"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
diff --git a/configs/bananapi-m5_defconfig b/configs/bananapi-m5_defconfig
index 6de5d5fe7b..99ed7c9669 100644
--- a/configs/bananapi-m5_defconfig
+++ b/configs/bananapi-m5_defconfig
@@ -6,7 +6,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-sm1-bananapi-m5"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-sm1-bananapi-m5"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
diff --git a/configs/beelink-gsking-x_defconfig b/configs/beelink-gsking-x_defconfig
index 99e36e970a..c1e60ede4a 100644
--- a/configs/beelink-gsking-x_defconfig
+++ b/configs/beelink-gsking-x_defconfig
@@ -7,7 +7,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-g12b-gsking-x"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-g12b-gsking-x"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
diff --git a/configs/beelink-gtking_defconfig b/configs/beelink-gtking_defconfig
index 5c21d8eeab..0b644f0e34 100644
--- a/configs/beelink-gtking_defconfig
+++ b/configs/beelink-gtking_defconfig
@@ -7,7 +7,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-g12b-gtking"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-g12b-gtking"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
diff --git a/configs/beelink-gtkingpro_defconfig b/configs/beelink-gtkingpro_defconfig
index 37bb4cde79..a694617a96 100644
--- a/configs/beelink-gtkingpro_defconfig
+++ b/configs/beelink-gtkingpro_defconfig
@@ -7,7 +7,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-g12b-gtking-pro"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-g12b-gtking-pro"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
diff --git a/configs/khadas-vim3_android_ab_defconfig b/configs/khadas-vim3_android_ab_defconfig
index ee62fe36d4..37b8d6a925 100644
--- a/configs/khadas-vim3_android_ab_defconfig
+++ b/configs/khadas-vim3_android_ab_defconfig
@@ -10,7 +10,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0x0
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-g12b-a311d-khadas-vim3"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-g12b-a311d-khadas-vim3"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
diff --git a/configs/khadas-vim3_android_defconfig b/configs/khadas-vim3_android_defconfig
index cecbe50617..55d59dd481 100644
--- a/configs/khadas-vim3_android_defconfig
+++ b/configs/khadas-vim3_android_defconfig
@@ -10,7 +10,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0x0
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-g12b-a311d-khadas-vim3"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-g12b-a311d-khadas-vim3"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
diff --git a/configs/khadas-vim3_defconfig b/configs/khadas-vim3_defconfig
index 5df4b92143..32579b8ac3 100644
--- a/configs/khadas-vim3_defconfig
+++ b/configs/khadas-vim3_defconfig
@@ -7,7 +7,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-g12b-a311d-khadas-vim3"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-g12b-a311d-khadas-vim3"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
diff --git a/configs/khadas-vim3l_android_ab_defconfig b/configs/khadas-vim3l_android_ab_defconfig
index ec4e0dc72e..95e70275cc 100644
--- a/configs/khadas-vim3l_android_ab_defconfig
+++ b/configs/khadas-vim3l_android_ab_defconfig
@@ -10,7 +10,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0x0
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-sm1-khadas-vim3l"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-sm1-khadas-vim3l"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
diff --git a/configs/khadas-vim3l_android_defconfig b/configs/khadas-vim3l_android_defconfig
index 206f8defca..6372d11989 100644
--- a/configs/khadas-vim3l_android_defconfig
+++ b/configs/khadas-vim3l_android_defconfig
@@ -10,7 +10,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0x0
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-sm1-khadas-vim3l"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-sm1-khadas-vim3l"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
diff --git a/configs/khadas-vim3l_defconfig b/configs/khadas-vim3l_defconfig
index de8fdd83cc..b9f4690045 100644
--- a/configs/khadas-vim3l_defconfig
+++ b/configs/khadas-vim3l_defconfig
@@ -7,7 +7,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-sm1-khadas-vim3l"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-sm1-khadas-vim3l"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
diff --git a/configs/odroid-c4_defconfig b/configs/odroid-c4_defconfig
index fe1f861258..4ef1e68166 100644
--- a/configs/odroid-c4_defconfig
+++ b/configs/odroid-c4_defconfig
@@ -7,7 +7,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-sm1-odroid-c4"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-sm1-odroid-c4"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
diff --git a/configs/odroid-go-ultra_defconfig b/configs/odroid-go-ultra_defconfig
index 49d628b76a..06437fe3ae 100644
--- a/configs/odroid-go-ultra_defconfig
+++ b/configs/odroid-go-ultra_defconfig
@@ -7,7 +7,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-g12b-odroid-go-ultra"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-g12b-odroid-go-ultra"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
diff --git a/configs/odroid-hc4_defconfig b/configs/odroid-hc4_defconfig
index 7720ab5eb8..60233fb9ce 100644
--- a/configs/odroid-hc4_defconfig
+++ b/configs/odroid-hc4_defconfig
@@ -7,7 +7,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-sm1-odroid-hc4"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-sm1-odroid-hc4"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
diff --git a/configs/odroid-n2_defconfig b/configs/odroid-n2_defconfig
index 9694f04a66..a4cc766f84 100644
--- a/configs/odroid-n2_defconfig
+++ b/configs/odroid-n2_defconfig
@@ -7,7 +7,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-g12b-odroid-n2"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-g12b-odroid-n2"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
diff --git a/configs/odroid-n2l_defconfig b/configs/odroid-n2l_defconfig
index 673e0cffb2..3f657d1881 100644
--- a/configs/odroid-n2l_defconfig
+++ b/configs/odroid-n2l_defconfig
@@ -7,7 +7,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-g12b-odroid-n2l"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-g12b-odroid-n2l"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
diff --git a/configs/radxa-zero2_defconfig b/configs/radxa-zero2_defconfig
index b795681b3f..92e0a8833c 100644
--- a/configs/radxa-zero2_defconfig
+++ b/configs/radxa-zero2_defconfig
@@ -6,7 +6,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-g12b-radxa-zero2"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-g12b-radxa-zero2"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
diff --git a/configs/radxa-zero_defconfig b/configs/radxa-zero_defconfig
index 103ff8a321..5179c58dad 100644
--- a/configs/radxa-zero_defconfig
+++ b/configs/radxa-zero_defconfig
@@ -6,7 +6,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-g12a-radxa-zero"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-g12a-radxa-zero"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
diff --git a/configs/sei510_defconfig b/configs/sei510_defconfig
index c4a49fbd6f..791979e744 100644
--- a/configs/sei510_defconfig
+++ b/configs/sei510_defconfig
@@ -10,7 +10,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0xFFFF0000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-g12a-sei510"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-g12a-sei510"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
diff --git a/configs/sei610_defconfig b/configs/sei610_defconfig
index ae254c62f2..ce5374319b 100644
--- a/configs/sei610_defconfig
+++ b/configs/sei610_defconfig
@@ -10,7 +10,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0xFFFF0000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-sm1-sei610"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-sm1-sei610"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
diff --git a/configs/u200_defconfig b/configs/u200_defconfig
index 21c90e7678..879ae0defa 100644
--- a/configs/u200_defconfig
+++ b/configs/u200_defconfig
@@ -6,7 +6,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-g12a-u200"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-g12a-u200"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y

-- 
2.34.1

