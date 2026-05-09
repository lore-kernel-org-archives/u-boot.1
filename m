Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0936CD37AC
	for <u-boot@archiver.kernel.org>; Sat,  9 May 2026 00:40:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1653684E1D;
	Sat,  9 May 2026 02:40:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=wolfssl-com.20251104.gappssmtp.com header.i=@wolfssl-com.20251104.gappssmtp.com header.b="cIN1Bbrj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB56584E0F; Sat,  9 May 2026 02:04:44 +0200 (CEST)
Received: from mail-dl1-x1234.google.com (mail-dl1-x1234.google.com
 [IPv6:2607:f8b0:4864:20::1234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72BCA84E10
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 02:04:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aidan@wolfssl.com
Received: by mail-dl1-x1234.google.com with SMTP id
 a92af1059eb24-12db2e415a7so1869602c88.1
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 17:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wolfssl-com.20251104.gappssmtp.com; s=20251104; t=1778285080; x=1778889880;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nbamVX3rWvdw7UjgaZEIs2puQ+YV3AvIErMweW3jqyU=;
 b=cIN1BbrjaRL62i93oQU/XiVue0cO9+Vnc3w0ZgerX6ncenBj5sRfg+5x3lsNYrEHl+
 8Du6hdJYxOON6P5OIdv76mQRFdj1pAuC4Y9Z+JAnoDKXCy9ofOAipDVJ3lM4Vg/cM7KS
 IEj6DwQ+HbAi4dj47yahiq9mfmEDDYiRIbDeihuQFmkou0LjTj1ZUrIWiLF+74u27d1g
 bzuyxttX22KvmsL0qLn+zCWbMgwG1iKfe7dw2qBJS0m9L7I4Vy00X/cJdhtRn2wfeI1T
 PvcNSp2kB27OT8yNKT+f0ChxQJs0kqNOEsff4umgMrIEbh8eOA6HnMxAELJmq0yJCJJX
 fhPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778285080; x=1778889880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nbamVX3rWvdw7UjgaZEIs2puQ+YV3AvIErMweW3jqyU=;
 b=ow0TCOBbL6l0YRp7NEKTjEvGItpa47vinXELFoGAXZyDi5uEkAwWfjSlmyqTEXprpd
 ovo29stwSiU7sZPvmEPyhUivHwPsHwsGqCPYpvokaghxI2qJJPVvC6mIH7jx2wn5jhKN
 JOcSDbKCqJFnO7jZ0gFoZarqhYlC4qkl4SArjEfOzBOEpje+v86oA9R+fmmg6lTxeP/d
 I5sCHk7EvjDNAhkt835Q63pobdXKLB5MO4YdT+uoWus7jBLOOWmdjH0j92560Uwi42KK
 dxbhjKbG+9/gp//j8Q02SMPjvkLjhTv7/+lIGjEyvgOAR34tI8CBjNPVbuue1xRQ+9HG
 o4iA==
X-Gm-Message-State: AOJu0YyH67fHhRjBxIn+TfxAM+VJEEg9+BlthniwcLAnNjCSJtcQg7Hr
 yseORrG+LIaGM3lXGH/U3j0d9ldon2Jmx9fQEtAnCBFdo0OQPJfphvfSyvn8D2Ed5NXVwWh3XYe
 r0fnN
X-Gm-Gg: AeBDiesWj4uafOAaUAj1ABwRxknAJ0/y/oJ23cmkq7Ng9uhL0NVF0iBuWwq5fw4ZJZV
 vVfKzI5+6tUHit/t+Jf2yGAImxFrfABLnYNwgTJUu2xowtVmsEz1mizjd03xfUlhhvxcePi1aws
 Dm4w0Oyl+t/Bs5DD5qN+PLZkertutDvVXYhtjVsegzbVg5Mm3aJAzX/kp6uX9MUIwDU5YKfwnJ/
 RNZj9cLdoU5+aAxOHTK1PyRzpOj2qXiz/QX3AmAT3tJC+PVkD2i842BhJb9qmmtol8F6Pc7snZg
 Az7wJTyxIC3MhKwRXfdpkFNar897SNLoM4VczoLJV9i1g9yReihL5WI0L7+9lhHwqHlOEqESiPu
 uCUKu2qYLySddDw8y8allMiDpV0SxXwse3r1A55YQ/TuXNZSJ5AJhotMY620EzJGSOcwjlVBV9F
 LozUICcW4AEpY673Jd0VIcCxmXgu3pJ/FIU1jXNaVek3nPWG1ofOWAd9e14lZw8GktIE4k08mZY
 vPRXzU55nLZ2jt+Y9raGQ==
X-Received: by 2002:a05:7022:43a6:b0:12b:f881:d8f6 with SMTP id
 a92af1059eb24-1319d05636cmr7071992c88.29.1778285080498; 
 Fri, 08 May 2026 17:04:40 -0700 (PDT)
Received: from localhost.localdomain ([207.231.76.218])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-132787673ffsm5505030c88.15.2026.05.08.17.04.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 17:04:40 -0700 (PDT)
From: Aidan Garske <aidan@wolfssl.com>
To: u-boot@lists.denx.de
Cc: David Garske <david@wolfssl.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v3 04/12] dts: add TPM device tree nodes for RPi4, QEMU,
 and sandbox
Date: Fri,  8 May 2026 17:04:11 -0700
Message-ID: <9922bb5e8b3fb1d5c6e80ea51a01b685690a2f44.1778277334.git.aidan@wolfssl.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1778277334.git.aidan@wolfssl.com>
References: <cover.1778277334.git.aidan@wolfssl.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 09 May 2026 02:40:11 +0200
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
2.47.3

