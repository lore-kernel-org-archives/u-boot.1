Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96CE0C001DF
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 15:25:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6C9D86F6F;
	Fri, 20 Oct 2023 17:25:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hGiuhRSp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 731E086E7E; Fri, 20 Oct 2023 17:25:24 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DA4286F84
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 17:25:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrejs.cainikovs@gmail.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-522bd411679so1420959a12.0
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 08:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697815522; x=1698420322; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bPD3NwKUXEFZUJ6kE1YRDh5NRSrDQlTcVRO9r+9lF7s=;
 b=hGiuhRSp11FK6w1LHpXzIPlIboHnAdqNygbX08wzcpTeBp3fHLIuQrNvM2HAzPoLQh
 Kx0m0ahJOYRZEPmQ0NkHZIzG1MdJL98voKqKDybWp3TcGWCES6C1/7TXcOFJmwLOm6z7
 fD/Y3gM3WUEcaQvKOAaflsA+HBajQ+hb2BcqI7emebaKUytUL5BZbCgGAw7nSLqqzzCy
 hevS35pBFMNp5KWhyrKljNB48RTbxtGQNy+o5nsRqEpyGh6+VbEKQa3bGv85wQDqc/tJ
 VGoFUXmoWls/0LzSGNw2buHmT5WEXmFQGjAKl+9dIxFuLYHhHv0cKys4ZYhllViSkIhT
 vz7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697815522; x=1698420322;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bPD3NwKUXEFZUJ6kE1YRDh5NRSrDQlTcVRO9r+9lF7s=;
 b=wuGmUlQbAP00sw4xS9GQer3YYQx3etLdD6s8D5VVKpoV7Y8F13SKNb4RxeEULOGl9Q
 +twmO0tNmjCFYVjgvaqr6h29y+jQUj57IAnSgdawGMy48ukUogNJAcMcJuLqI0tCs6RV
 tpOVZfOC6QFTuDA0sEcCPx1l96n4zBrMqlduyAtEFh0S4CLFrVEX8kI63YTbsDQjrKFh
 qZNgi3eZGFoi7WLzSszQDPoR9NIKtBaJfz7F18q3Qs/4C5oW3gM4B4qm7zbANcW3zaJA
 NDSZDkX3xy0oGoILmZNds7KMFR1cP1YgfPNEWy9tPp/Ow58hs9X5J7ztyS+048jK+1gw
 CtHQ==
X-Gm-Message-State: AOJu0Yx/IYh6Z9Jn65iiAdeyVdIMN6jDW+N2bGtTiObH0O8S0KcHIz7M
 3FzVmr368KYhT6g58EP85EMEU+2TxgIlYA==
X-Google-Smtp-Source: AGHT+IEXNvb97WMbQbspilGKcbQVT8imfPLpoKxkTqK8GntuqGaVmz834BVtglWlKlE1dYmjNov3tw==
X-Received: by 2002:a17:906:fe4c:b0:9c6:abf9:2a1e with SMTP id
 wz12-20020a170906fe4c00b009c6abf92a1emr1607135ejb.31.1697815521412; 
 Fri, 20 Oct 2023 08:25:21 -0700 (PDT)
Received: from andrejs-nb.int.toradex.com (77-59-154-235.dclient.hispeed.ch.
 [77.59.154.235]) by smtp.gmail.com with ESMTPSA id
 s16-20020a170906bc5000b009b95b46bbd1sm1685371ejv.133.2023.10.20.08.25.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 08:25:20 -0700 (PDT)
From: Andrejs Cainikovs <andrejs.cainikovs@gmail.com>
To: u-boot@lists.denx.de,
	"NXP i . MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Subject: [PATCH v1] apalis-imx8: add USBH_EN gpio hog
Date: Fri, 20 Oct 2023 17:25:16 +0200
Message-Id: <20231020152516.57338-1-andrejs.cainikovs@gmail.com>
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

From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>

USB host interface is not working on some Apalis Toradex carrier
boards with Apalis iMX8 SoM. This is due to USBH_EN pin, which
powers USB peripherals, having a strong pull-down on some boards,
and a weak pull-down on the others. This USBH_EN pin is left
unconfigured, which means it is in its default state at cold boot:
input with a strong pull-up. As a result, carrier boards with a
weak pull-down have this signal high enough to trigger power
delivery to USB peripherals, and opposite - boards with strong
pull-down on USBH_EN have this signal below the threshold needed
to trigger USB power delivery.
This change configures the USBH_EN pin as gpio hog, fixing this
issue for all Apalis carrier boards regardless of pull-down
resistor value.

Also, update apalis-imx8_defconfig via savedefconfig.

Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
---
 arch/arm/dts/fsl-imx8qm-apalis-u-boot.dtsi | 6 ++++++
 configs/apalis-imx8_defconfig              | 3 ++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/fsl-imx8qm-apalis-u-boot.dtsi b/arch/arm/dts/fsl-imx8qm-apalis-u-boot.dtsi
index f2d6b183ed9..c54a59e89c5 100644
--- a/arch/arm/dts/fsl-imx8qm-apalis-u-boot.dtsi
+++ b/arch/arm/dts/fsl-imx8qm-apalis-u-boot.dtsi
@@ -93,6 +93,12 @@
 
 &gpio4 {
 	bootph-some-ram;
+
+	usbh_en {
+		gpio-hog;
+		gpios = <4 GPIO_ACTIVE_HIGH>;
+		output-high;
+	};
 };
 
 &gpio5 {
diff --git a/configs/apalis-imx8_defconfig b/configs/apalis-imx8_defconfig
index b726ee351fa..340645bdded 100644
--- a/configs/apalis-imx8_defconfig
+++ b/configs/apalis-imx8_defconfig
@@ -21,9 +21,9 @@ CONFIG_SYS_MEMTEST_END=0x89000000
 CONFIG_REMAKE_ELF=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=1
+CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_USE_PREBOOT=y
 CONFIG_PREBOOT="test -n ${fdtfile} || setenv fdtfile ${soc}-apalis${variant}-${fdt_board}.dtb"
 CONFIG_LOG=y
@@ -65,6 +65,7 @@ CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_BOOTCOUNT_ENV=y
 CONFIG_CLK_IMX8=y
 CONFIG_CPU=y
+CONFIG_GPIO_HOG=y
 CONFIG_MXC_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_IMX_LPI2C=y
-- 
2.34.1

