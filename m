Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21ECBF53D85
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 18:25:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 805F8841C8;
	Mon, 16 Mar 2026 19:24:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=wolfssl-com.20230601.gappssmtp.com header.i=@wolfssl-com.20230601.gappssmtp.com header.b="et/JL/wi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED89884183; Mon, 16 Mar 2026 19:15:30 +0100 (CET)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DC4884179
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 19:15:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=david@wolfssl.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-4672076355aso3356236b6e.2
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 11:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wolfssl-com.20230601.gappssmtp.com; s=20230601; t=1773684927; x=1774289727;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d2X9eDB2hTwH7mKyeDU6xocglnghJUtwfVkfgQacZbE=;
 b=et/JL/wiPE2NFcP0hZebUPWFM/jRxu+D7bfE9GI4IgmnPEjf0sp1lGcv9XowyqBR/I
 i0BJFKblNegNufXXntzfzmO1bHJ1UpWaBXfNOuvZXJNiHYWkl+09p7gPnL7p7TdHi1IY
 jfS1FecOualusLqePZIFbwo1TLTNIayZ9CGtLHyezQs2Ni0EhSEXdKbX2TBEV1pBcorr
 eEN5niXVbh4Ti96ZOTjZyokoj6FtXc2Q+xLsUjpHnN9csiuBmwHsH+QF7qL/3L+GnsC9
 cuzA11oBhh3K23TpV+AMftPtWXNTAmJ0un1s67GEisHcdlLXTzWg/C9LCElBWwLfUAVh
 rtsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773684927; x=1774289727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d2X9eDB2hTwH7mKyeDU6xocglnghJUtwfVkfgQacZbE=;
 b=c/Blf6bizPCuwL/xzAw1qGkUqGMx1puR3/qLQAcJXLsp7fMYi+LOLhjaEPiBB+kPHG
 a4Y2p30RPjOJRmKjZUOE3lfedrXNZjFnZAuHwfpFaHlY5LRfQEw5Baq9QMHqg5aos+7R
 nr0B3V3Rk4cqNZhT1kEfpKf5FfAaFuPu2jBRvMJ4xmVi/3+g/an7/Nx7h5OF+M2NofJI
 uSNj79ghTb3hrSMA0j6+2yApxCuYV/YbYvP6QrPv4vIWz8lEdPA2OKEbbrCnc46Hd9W0
 hqKJ0JTyw6VyS3XZ3iqRCDf5kJpHWA4BWAT627GVnfnL9xTwq61NbO8DgQF+mbvYT8eo
 KkOg==
X-Gm-Message-State: AOJu0YwQtusBCfdW8Uq+yx3Dw6rMCgQaxAxXT1NOmwiOT0tNUD2y7KQA
 Pr8xGnNG02sz+Lborz8bo/gcXVElPpbuaqI2xI+Ddj95JIiuMZHBpIwY0YQWUzQCd5UhzVokm0E
 p0UyFu7U=
X-Gm-Gg: ATEYQzxUNTm8BF8QbA0Zm62kKAG6Hy5E3ZAwKNz8vN5UdqpzLjsWBegBWUXyOwzQrRl
 GyyXY/TThFYnmXQ1mFaaeR68wpGaojDLhg381Hby14GVZqnUTXYmBcW/oEMj0elbul1EXluLyPU
 lmsrqmoLFx5fwZd84T7V0Hy/mLYBsBeSZ06a0tJCLfiUZtVpPidWpO5Zv8vGqnBz9YEjk3/kPQG
 dKR2FoOIF26Sx7uCxMa1yJg1Ukv9+PCsn5nQRAT00evm33RrlE3ha2G8k+6jvxI+FFnZVgFfzxP
 mmsbGYnGZeXqNte2oFBUQvjBi4QF7KKKx09pPAzSrgiudsuwQ2ftARDWUXGYpZU1Cn+lmFMiU9f
 1g33E+q/jrKiFrfKL/BrfSv2f7hv9Fcz4hoyA2/MoSAwlOtDIoHmSa1jIVkFH3R6w92UZut+2QM
 j+Vn7Mn+TnRFMPlSDoyD4Tfw==
X-Received: by 2002:a05:6808:1313:b0:467:bfa:bdc2 with SMTP id
 5614622812f47-4675713cdffmr7173938b6e.24.1773684926654; 
 Mon, 16 Mar 2026 11:15:26 -0700 (PDT)
Received: from localhost ([2605:59c0:2082:bc08:ab40:208e:38fb:2546])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-467342ef6fesm10023762b6e.14.2026.03.16.11.15.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 11:15:25 -0700 (PDT)
From: David Garske <david@wolfssl.com>
To: u-boot@lists.denx.de
Cc: Aidan <aidan@wolfssl.com>
Subject: [[PATCH v2] tpm: Add wolfTPM library support for TPM 2.0 04/12] dts:
 add TPM device tree nodes for RPi4, QEMU, and sandbox
Date: Mon, 16 Mar 2026 11:14:33 -0700
Message-ID: <20260316181447.2986278-5-david@wolfssl.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316181447.2986278-1-david@wolfssl.com>
References: <20260316181447.2986278-1-david@wolfssl.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 16 Mar 2026 19:24:09 +0100
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

From: Aidan <aidan@wolfssl.com>

Add device tree entries for TPM devices across three platforms:

bcm2711-rpi-4-b.dts:
  Add SPI0 node with Infineon SLB9670/9672 TPM on CE1 (GPIO7),
  matching the standard Linux tpm-slb9670 overlay. Add spi0 alias
  so wolfTPM finds the bus at index 0.

bcm2711-rpi-4-b-u-boot.dtsi (new file):
  Add soft-SPI (GPIO bit-bang) fallback node for TPM communication.
  This uses spi-gpio with GPIO11/10/9/7 and provides an alternative
  to the hardware SPI driver when pinctrl naming differs between
  U-Boot and Linux device trees.

qemu-arm64.dts:
  Add MMIO-based TPM TIS node at 0x0c000000 for QEMU virt machine
  with swtpm. This allows wolfTPM testing via QEMU without hardware.

sandbox.dtsi:
  Add sandbox TPM SPI device (sandbox,tpm-spi) on SPI bus CS1 with
  a phandle reference to a sandbox TPM SPI emulator node. This
  enables wolfTPM SPI HAL testing in the sandbox environment.

Signed-off-by: Aidan Garske <aidan@wolfssl.com>
---
 arch/arm/dts/bcm2711-rpi-4-b-u-boot.dtsi | 54 ++++++++++++++++++++++++
 arch/arm/dts/bcm2711-rpi-4-b.dts         | 20 +++++++++
 arch/arm/dts/qemu-arm64.dts              |  4 ++
 arch/sandbox/dts/sandbox.dtsi            | 11 +++++
 4 files changed, 89 insertions(+)
 create mode 100644 arch/arm/dts/bcm2711-rpi-4-b-u-boot.dtsi

diff --git a/arch/arm/dts/bcm2711-rpi-4-b-u-boot.dtsi b/arch/arm/dts/bcm2711-rpi-4-b-u-boot.dtsi
new file mode 100644
index 00000000000..c38276abee9
--- /dev/null
+++ b/arch/arm/dts/bcm2711-rpi-4-b-u-boot.dtsi
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * U-Boot specific additions for Raspberry Pi 4 Model B
+ *
+ * Adds soft SPI support for Infineon SLB9670/9672 TPM HAT
+ * connected to SPI0 CE1 (GPIO 7)
+ *
+ * Uses GPIO bit-banging instead of hardware SPI to avoid
+ * GPIO chip naming issues (pinctrl-bcm2835 vs pinctrl-bcm2711)
+ */
+
+#include "bcm283x-u-boot.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	aliases {
+		spi0 = &soft_spi;
+	};
+
+	soft_spi: soft-spi {
+		compatible = "spi-gpio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "okay";
+		bootph-all;
+
+		/*
+		 * GPIO pins for SPI0 on Raspberry Pi 4:
+		 * GPIO 11 = SCLK
+		 * GPIO 10 = MOSI
+		 * GPIO 9  = MISO
+		 * GPIO 7  = CE1 (chip select for TPM)
+		 */
+		gpio-sck = <&gpio 11 GPIO_ACTIVE_HIGH>;
+		gpio-mosi = <&gpio 10 GPIO_ACTIVE_HIGH>;
+		gpio-miso = <&gpio 9 GPIO_ACTIVE_HIGH>;
+		cs-gpios = <&gpio 7 GPIO_ACTIVE_LOW>;
+		num-chipselects = <1>;
+		spi-delay-us = <1>;
+
+		/* Infineon SLB9672 TPM on CS1 */
+		tpm@0 {
+			compatible = "infineon,slb9672", "tcg,tpm-tis-spi";
+			reg = <0>;
+			spi-max-frequency = <10000000>;
+			status = "okay";
+			bootph-all;
+		};
+	};
+};
+
+&gpio {
+	bootph-all;
+};
diff --git a/arch/arm/dts/bcm2711-rpi-4-b.dts b/arch/arm/dts/bcm2711-rpi-4-b.dts
index 72ce80fbf26..a09276dc279 100644
--- a/arch/arm/dts/bcm2711-rpi-4-b.dts
+++ b/arch/arm/dts/bcm2711-rpi-4-b.dts
@@ -8,6 +8,11 @@
 	compatible = "raspberrypi,4-model-b", "brcm,bcm2711";
 	model = "Raspberry Pi 4 Model B";
 
+	/* Alias hardware SPI as spi0 so wolfTPM finds it at bus 0 */
+	aliases {
+		spi0 = &spi;
+	};
+
 	chosen {
 		/* 8250 auxiliary UART instead of pl011 */
 		stdout-path = "serial1:115200n8";
@@ -54,6 +59,21 @@
 		enable-active-high;
 		gpio = <&expgpio 6 GPIO_ACTIVE_HIGH>;
 	};
+
+};
+
+/* Hardware SPI with TPM - matches Linux tpm-slb9670 overlay */
+&spi {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi0_gpio7>;
+
+	/* Infineon SLB9670/9672 TPM 2.0 on CE1 (GPIO7) */
+	tpm@1 {
+		compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
+		reg = <1>;  /* CE1 */
+		spi-max-frequency = <32000000>;
+	};
 };
 
 &ddc0 {
diff --git a/arch/arm/dts/qemu-arm64.dts b/arch/arm/dts/qemu-arm64.dts
index 95fcf53ed74..e74d036a532 100644
--- a/arch/arm/dts/qemu-arm64.dts
+++ b/arch/arm/dts/qemu-arm64.dts
@@ -12,4 +12,8 @@
 #endif
 
 / {
+	tpm@0c000000 {
+		compatible = "tcg,tpm-tis-mmio";
+		reg = <0x0 0x0c000000 0x0 0x5000>;
+	};
 };
diff --git a/arch/sandbox/dts/sandbox.dtsi b/arch/sandbox/dts/sandbox.dtsi
index 02b03894eaf..2fdd7f0e942 100644
--- a/arch/sandbox/dts/sandbox.dtsi
+++ b/arch/sandbox/dts/sandbox.dtsi
@@ -286,6 +286,17 @@
 			spi-max-frequency = <40000000>;
 			sandbox,filename = "spi.bin";
 		};
+
+		tpm_spi: tpm@1 {
+			reg = <1>;
+			compatible = "sandbox,tpm-spi";
+			spi-max-frequency = <10000000>;
+			sandbox,emul = <&tpm_spi_emul>;
+		};
+	};
+
+	tpm_spi_emul: tpm-spi-emul {
+		compatible = "sandbox,tpm-spi-emul";
 	};
 
 	spl-test {
-- 
2.43.0

