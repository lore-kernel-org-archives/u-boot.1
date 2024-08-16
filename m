Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4712C52D7C
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 02:38:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEE3B88A75;
	Fri, 16 Aug 2024 04:38:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a5I8aQOr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB4EC88A77; Fri, 16 Aug 2024 04:38:31 +0200 (CEST)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A5A988785
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 04:38:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7a1e0ff6871so102121185a.2
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 19:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723775905; x=1724380705; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HCe1vXxmGKO0dSKQfwerePGGeLegxvXuqgOMTZ2W/a4=;
 b=a5I8aQOrNnU+DHapWR13KZ6SsBMWysQAnFuIO6qtdGkfU3KtF0LGfnXQzs/L51U3ck
 fjgcqAS+Nh5cDRVeGHyZxQ6JfOBPPPTZwiZri6YagkgbbZ7ZzNLycC3IWdTGH0d/xc9k
 xXHiqfVs3pWQ57WNslEb/dMsYIPpSdpvWHS3V2DIf+qHU2Tghob8ZrU8Xv/vmd0oQE/B
 fdM/aqBiiTVF6pPUwyJ1k1V+ZuN1fLQllflnQTwBDKs7DUW0y82FlGJyVtxujG9E00yJ
 oXuL3QF11mO4fdJIB31cc0BLgwBiLMeokXEeeQoJYLM+5zspvljYPoLtNPfLlnPgn+tn
 s0Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723775905; x=1724380705;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HCe1vXxmGKO0dSKQfwerePGGeLegxvXuqgOMTZ2W/a4=;
 b=XXx/e72GHgzp9h9CmKsqFBvKigBMbxQx0N+ckUY22v00RqQn71uMhaszeL/aWHLJaI
 Rvjzmq1fVXCQXfzqianAq7m5WofMr/1irtnWsMPX8U/hmZgxxqDcmM0s8OzT7quy4GIL
 +b1urTp/UnLVX6Kuop0n7LkWljA/2B8sU1+vQDmhXV9wKKAIed1jEjRuzgxXFC50d8nW
 uj9GyRBpmUfWVAlzzFQ8TjzAfcxJ71kWZqIAFQDFzs7cFERdOCHxcFAPVHOxIMqN+aTd
 jl2Vao52SyK1cZb8pN+ttHamCqDCIhDDPjH7KpJHeRrifZrWUy4/ZOplRTP2aK2Cjvyz
 3wJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUE8XJXFfnjmm3vYJrDLyvzTJraymGCxBcUFIp2WNLSkLmBI4Yu9ZaPvR+Dl8nHbK+gqvUq686rPpNKZstzxfqEAVaQiw==
X-Gm-Message-State: AOJu0YyIJ42FgDlTEWC246N9VAapLxw9PoXoGnpeHkfPKYjaF5VjtRk2
 nVoHrKA2nrp+vYcNbxMTyK6AcPpHVStTH7l2SjVFaFU5GMWeuMmQic8/4Dkw
X-Google-Smtp-Source: AGHT+IEvWdL4c+pLmj36PdWP7jABlyfiq2lOl7apD8g/qOIZGTfTYhVWk7zsoRwjtTRhfMoMFBJ28A==
X-Received: by 2002:a05:622a:260c:b0:44f:efab:22a with SMTP id
 d75a77b69052e-45374300410mr24383561cf.38.1723775905062; 
 Thu, 15 Aug 2024 19:38:25 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 d75a77b69052e-4536a04e4fdsm11729511cf.62.2024.08.15.19.38.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Aug 2024 19:38:24 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: Simon Glass <sjg@chromium.org>,
	u-boot@lists.denx.de
Cc: Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v3] sandbox: Fix pinmux warnings with non-test devicetrees
Date: Thu, 15 Aug 2024 22:38:22 -0400
Message-Id: <20240816023822.647717-1-seanga2@gmail.com>
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
warnings). First, making the pinmux and the UART group available
pre-relocation to avoid ENODEV errors. Then, convert the pin groups and
functions to the new style, adding onewire group as well.

Fixes: 7f0f1806e3a ("test: pinmux: Add test for pin muxing")
Closes: https://source.denx.de/u-boot/u-boot/-/issues/2
Signed-off-by: Sean Anderson <seanga2@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Fix "something strange" in the commit message

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

