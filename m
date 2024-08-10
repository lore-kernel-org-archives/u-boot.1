Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F1EC3DA4A
	for <u-boot@archiver.kernel.org>; Sat, 10 Aug 2024 13:52:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A1148870B;
	Sat, 10 Aug 2024 15:52:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ikysXS0k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 835F288802; Sat, 10 Aug 2024 15:52:54 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 636DD881C3
 for <u-boot@lists.denx.de>; Sat, 10 Aug 2024 15:52:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-690404fd27eso28039717b3.2
 for <u-boot@lists.denx.de>; Sat, 10 Aug 2024 06:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723297971; x=1723902771; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eWpfSQc7UMERzYm4Tb7bTvnLtWGsKpZVD9A2IvqjFiw=;
 b=ikysXS0kbH2BleA6q+O/m2v/ymi4Y/1qz2Ac07Md5MinlSL+C72XF2Ssv2tgmjoWLc
 51r9mdW0/LP2HR3ONTEK4bB9ITsM2HxNLXuT0i10fbgfk+kG61G4TSeWj6CTrXUSVnjz
 zofEnwCvglkRlEY4PHH+F2vOzH6eN/tLsZ8UmaNRaW91JXKy65KlZxj5unAeDQxrvhI2
 GaRHqNV1vuI8vnbBc15ihK4boVBjoUZkwyGy3hTm62bV7obdKEqavo0HjhsqJXLb7KwJ
 j2bEMLWZ/RoAfQgDDGUrp08VmWSBgfVNYBYqsdS4y1axITOE9Qm1Up4O1YolHKahPqga
 o/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723297971; x=1723902771;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eWpfSQc7UMERzYm4Tb7bTvnLtWGsKpZVD9A2IvqjFiw=;
 b=pkllEgKcrc3tlFb6+0RshgaqeTvMfsBfY27OU8RYkWapZOu0HWRBM9T9CkIX+VS5CQ
 HyKAECuTsIdykTTqOWugxLmr0PJvl9EP2UBQ/6gRKiKx6wLa0O/GTWOntWI5kgKgHktd
 pBjeqGV+QwTAYLahIR/cqydEP6a+rne7kwHMDZhdx1S7oHlTTStfQYypSpnlzFQR9Ymf
 RMfO9MZmMERsXzl2HgLvBWeN1w7IGCYUzUGTXdy1UqEHs0RLBHtJin58WKPqrX94PENw
 3WPzl4eI8qfuFyfmy+jU3pYt8UmLrsziS5yhzKtD7UYswwsvcLukOIqgOKIi/TK1BCVE
 U4mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWZGMzBl/Kptnn/DImQ3BeNWeSiJho77CVoFno8AuQXXBoTol+Ir6A9Inv5xFJy5ODl6K+H6Y9UzFiI/tjAp0srnkP2Q==
X-Gm-Message-State: AOJu0YzhvAzAK0+Iztn0jXbamGkk/E2BUDpsR6Ge3lxsDc++AZwvcqz4
 PtgoTLoW4oXDExrayQB1yDirPABz9NhaG8cOkgknFPD0dKVxPvuZ/A5QaQ==
X-Google-Smtp-Source: AGHT+IGxxbkidRBQ4jPQzxzWvkM9kqpvCepjHxEXxVDjm14+wiur2YuKk615JOqyxEutRt4V6/aysQ==
X-Received: by 2002:a05:6902:2292:b0:e0b:e2df:b422 with SMTP id
 3f1490d57ef6-e0eb9994b16mr5297270276.24.1723297971141; 
 Sat, 10 Aug 2024 06:52:51 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 af79cd13be357-7a4c7e115c0sm68589085a.133.2024.08.10.06.52.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Aug 2024 06:52:50 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: Simon Glass <sjg@chromium.org>,
	u-boot@lists.denx.de
Cc: Sean Anderson <seanga2@gmail.com>
Subject: [PATCH] sandbox: Fix pinmux warnings with non-test devicetrees
Date: Sat, 10 Aug 2024 09:52:49 -0400
Message-Id: <20240810135249.4037082-1-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
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

The sandbox pinmux driver is used in the non-test devicetree as well as
the test one. I didn't realize this when I modified the driver for
tests, and so broke the regular use case (which only resulted in
warnings). First, making the pinmux and the UART group available in all
boot phases to avoid ENODEV errors. Then, convert the pin groups and
functions to the new style, adding onewire group as well.

Fixes: 7f0f1806e3a ("test: pinmux: Add test for pin muxing")
Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

 arch/sandbox/dts/sandbox.dtsi                | 14 ++++++++------
 drivers/pinctrl/pinctrl-sandbox.c            |  4 +++-
 include/dt-bindings/pinctrl/sandbox-pinmux.h |  1 +
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/sandbox/dts/sandbox.dtsi b/arch/sandbox/dts/sandbox.dtsi
index c93ce712894..06ba4f031fa 100644
--- a/arch/sandbox/dts/sandbox.dtsi
+++ b/arch/sandbox/dts/sandbox.dtsi
@@ -231,23 +231,25 @@
 	};
 
 	pinctrl {
+		bootph-all;
 		compatible = "sandbox,pinctrl";
 		status = "okay";
 
 		pinctrl_i2c0: i2c0 {
-			groups = "i2c";
-			function = "i2c";
+			groups = "I2C_UART";
+			function = "I2C";
 			bias-pull-up;
 		};
 
 		pinctrl_serial0: uart0 {
-			groups = "serial_a";
-			function = "serial";
+			bootph-all;
+			groups = "I2C_UART";
+			function = "UART";
 		};
 
 		pinctrl_onewire0: onewire0 {
-			groups = "w1";
-			function = "w1";
+			pins = "P8";
+			function = "ONEWIRE";
 			bias-pull-up;
 		};
 	};
diff --git a/drivers/pinctrl/pinctrl-sandbox.c b/drivers/pinctrl/pinctrl-sandbox.c
index a5d056643a0..f6921b56ceb 100644
--- a/drivers/pinctrl/pinctrl-sandbox.c
+++ b/drivers/pinctrl/pinctrl-sandbox.c
@@ -42,7 +42,7 @@ static const char * const sandbox_pins_muxing[][2] = {
 	{ "GPIO0", "SPI CS0" },
 	{ "GPIO1", "SPI CS1" },
 	{ "GPIO2", "PWM0" },
-	{ "GPIO3", "PWM1" },
+	{ "GPIO3", "ONEWIRE" },
 };
 
 #define SANDBOX_GROUP_I2C_UART 0
@@ -63,6 +63,7 @@ static const char * const sandbox_functions[] = {
 	FUNC(GPIO),
 	FUNC(CS),
 	FUNC(PWM),
+	FUNC(ONEWIRE),
 #undef FUNC
 };
 
@@ -166,6 +167,7 @@ static int sandbox_pinmux_set(struct udevice *dev, unsigned pin_selector,
 		break;
 	case SANDBOX_PINMUX_CS:
 	case SANDBOX_PINMUX_PWM:
+	case SANDBOX_PINMUX_ONEWIRE:
 		mux = BIT(pin_selector);
 		break;
 	default:
diff --git a/include/dt-bindings/pinctrl/sandbox-pinmux.h b/include/dt-bindings/pinctrl/sandbox-pinmux.h
index 891af072e52..21c5a1762ab 100644
--- a/include/dt-bindings/pinctrl/sandbox-pinmux.h
+++ b/include/dt-bindings/pinctrl/sandbox-pinmux.h
@@ -13,6 +13,7 @@
 #define SANDBOX_PINMUX_GPIO 4
 #define SANDBOX_PINMUX_CS   5
 #define SANDBOX_PINMUX_PWM  6
+#define SANDBOX_PINMUX_ONEWIRE 7
 
 #define SANDBOX_PINMUX(pin, func) ((func) << 16 | (pin))
 
-- 
2.37.1

