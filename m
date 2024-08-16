Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B8CCC52D7F
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 00:48:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CDB988B7A;
	Fri, 16 Aug 2024 02:48:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RhtqrWMb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6AEF87C38; Fri, 16 Aug 2024 02:48:30 +0200 (CEST)
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com
 [IPv6:2607:f8b0:4864:20::e2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70E8B88B06
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 02:48:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-vs1-xe2b.google.com with SMTP id
 ada2fe7eead31-492aae5fde6so550119137.1
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 17:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723769302; x=1724374102; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=x0h1rJI6IM7X/QXq395c1wQ6lBDKPpdoBb0Xc9mHL4U=;
 b=RhtqrWMbk+xXTqJnDoYYf9jVvNnhKDoFUEfirSG321wQVIPpC2LjjMXpNhk/lDzeHF
 jBKAWJePrCQs89oH8IKjU41/D/ldJA0hQ6Iq6mF2BgNnKOO3ZYRHoT+Kp9uPaVCcfomB
 AKXGINa+U43uRwvL9tCcyqvrFBB2bapKelgbtCMh27X46VKBkORLrlYOAHAe5RxjZZyn
 vVYrrbTkuv3fGebJdtdIhI88jvTD97csLzXvWz0PLWGZlxabbDK8CGiEOSPw6ev971vb
 6ivV7PPoUp8rUUnEQj3ZHY5DouiB7qS12GuIR14y2apH3KvBaPrW+je0YzuCSa4mOfIZ
 buZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723769302; x=1724374102;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x0h1rJI6IM7X/QXq395c1wQ6lBDKPpdoBb0Xc9mHL4U=;
 b=a1iBoWdFU6OLvEnjMAUmD42P7qVdrK8wSoJwm6TxwIT4RDhmKu8zqcjRa441D/NBho
 4E2WegvxASybBPrk1KIEMOktlWe3ztR8o1NLLXCt01IjX5d2hTfT5otFe6SyD9TvObUL
 AW6SLoxSTJo71ZdMwSfxep+hldk+y1M26Nt34hdvFTBu2LoEdOfi6oB1+xwx0GNVqnep
 9XW6MKP1m8K7EQpe9qSeqDL4QdqKVuUk0jarfXTlel2OEK9HNMJPt0pW63RDUCW3IHG9
 X10tYzvserCnOrxWTn4f/5t0rEr7DsfZw7iGLyh8khQemFPID9ZrL5gww+MyI2cyPrk7
 laLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaLcJ/m5XTCtSxuXj+nBVhnJYI6vBH2fOW9x0QloUduUqAWDZVnZoAqES1aP+XrYdFbq0jU9xICo7JdoO5JiheQaeJRg==
X-Gm-Message-State: AOJu0YzYhBFW5zEaHbPlfLVBju361rLeVXvM0QIiLbuu7fM+N++CU6P7
 QUx5CF9h4Kvdad5Q5oylLr9wlsS/T/5qGr75PsVl1ksgZEmnXhTAF0fUgi7t
X-Google-Smtp-Source: AGHT+IE6lLKlOXD/x+QWXHPg9O97Hv1a+kKABzWHJC0zWjqUdUTVBUkzoFBo2tkwgRi+3mpd69y/Qg==
X-Received: by 2002:a05:6102:dcb:b0:48f:82c5:90e7 with SMTP id
 ada2fe7eead31-49779905e30mr1754574137.14.1723769302388; 
 Thu, 15 Aug 2024 17:48:22 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 af79cd13be357-7a4fef0046fsm118667285a.0.2024.08.15.17.48.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Aug 2024 17:48:21 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: Simon Glass <sjg@chromium.org>,
	u-boot@lists.denx.de
Cc: Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v2] sandbox: Fix pinmux warnings with non-test devicetrees
Date: Thu, 15 Aug 2024 20:48:19 -0400
Message-Id: <20240816004819.635938-1-seanga2@gmail.com>
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
Closes: https://source.denx.de/u-boot/u-boot/-/issues/2 Please enter the commit message for your changes. Lines starting
Signed-off-by: Sean Anderson <seanga2@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Only add the pinctrl node pre-relocation, as SPL/VPL try to run dtoc on all
  nodes included in their device trees.

 arch/sandbox/dts/sandbox.dtsi                | 14 ++++++++------
 drivers/pinctrl/pinctrl-sandbox.c            |  4 +++-
 include/dt-bindings/pinctrl/sandbox-pinmux.h |  1 +
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/sandbox/dts/sandbox.dtsi b/arch/sandbox/dts/sandbox.dtsi
index c93ce712894..8a115c503dc 100644
--- a/arch/sandbox/dts/sandbox.dtsi
+++ b/arch/sandbox/dts/sandbox.dtsi
@@ -231,23 +231,25 @@
 	};
 
 	pinctrl {
+		bootph-some-ram;
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
+			bootph-some-ram;
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

