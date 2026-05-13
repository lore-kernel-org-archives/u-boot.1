Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBC7ECD4F21
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 00:27:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D0A784666;
	Wed, 13 May 2026 02:26:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=wolfssl-com.20251104.gappssmtp.com header.i=@wolfssl-com.20251104.gappssmtp.com header.b="JUPOx6or";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67A3184099; Wed, 13 May 2026 02:26:39 +0200 (CEST)
Received: from mail-dy1-x132d.google.com (mail-dy1-x132d.google.com
 [IPv6:2607:f8b0:4864:20::132d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0307083CD3
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 02:26:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aidan@wolfssl.com
Received: by mail-dy1-x132d.google.com with SMTP id
 5a478bee46e88-2ef2a1cc06dso11736827eec.0
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 17:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wolfssl-com.20251104.gappssmtp.com; s=20251104; t=1778631995; x=1779236795;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xfxFQh8kPBRaKZ5O4HpZqS21Tqf/hR5VCqy1fXZyh9Q=;
 b=JUPOx6orQgqi48Qi2Rz9r5CGhd4rVVSTXExhTw1OiIrlXOqBICloE459jHIebgtRFd
 cNMEtjA/7ZQ0cC0esS0HS8+V//uqRHUW5B3XS3GYexJqtG8RGGVp/F/BhlGPMJAqtfhP
 1mkE6kIo90Wa+7K75NFC7BFm0Fw/5SXKJ3ZPiLdMGCUVDryTGyVaDOHIVNSea0gq3yNe
 hYgu7VFespIg8bnJLvQywse/y5qyj+GtKU0u7AEQzyd3GgxTM16CFAhI8Pdd5PrwBfZn
 tj9CtFeXD3bYkad+38pnaFCP22vG1NxB+8EWDGPOmjNXoIHrsfnJlgUxB90v2rE2yMrT
 zYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778631995; x=1779236795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xfxFQh8kPBRaKZ5O4HpZqS21Tqf/hR5VCqy1fXZyh9Q=;
 b=e1ZKMSawJ/qckhxrtveN+hSnYu6dMTrfZnSCtTPgauSVlzaj1ASbueu58fCByL8iQE
 9cRLivSNUaDP2KbypcN/Gm7nwcAXWosgBXhRj5AbPjL619Jvd80Kp5PSYUhe/0R+aH2h
 ZDhYgwS39KrTcRTfjuTMRCJZxH9PAo4KZk2Vour2sNNZR4Yr8U5VY1Q8jrqpsKk310RL
 QRJTTuuf5W1/BAlgnZuyIrNh+PVB1Vb9TpVVo/eEmQr61SIpZHjdSy5oXftzZhKcXwR/
 yHGcE/O6/KvNoWOUMc70x9w0beDOHQ7QbIa5YqM52LAUb6dl6/UxFQvWHi6JDXgQg62H
 AR4A==
X-Gm-Message-State: AOJu0YyRW2ImwXx8UngyXp2RpvEU8ePIzr5inwGXR2NlX9Eg+witq8QW
 SHUNLQPOXyOx946h+yLuhRd9sXC083jteGkOuFSq3xSkSkpY3kDK+RIHvndtNi8hPLQ0azh26wX
 7+FFsipE=
X-Gm-Gg: Acq92OGsQdNq+lwR4v+9+h1yw3C/JfLM9k67E35nLiwZbkT9oM0MsUnETOzNlbjYjd9
 U+yHVsv4zDAm98R6nmu1G0UJ3ZtNHv2Jpnwb+hed/cALogfSZEpglDiZwF9yobpqK1KDP6ZZCFz
 LZPhs9LaWUkycKJwIsGb/Zhq1pnohWqgqB6sYrz5DK686Ck2Wln+vh5xiF/jcLDF8BzZk72DBTZ
 2jQ/GdYzsdoeZhRbDafHoNYyejTK5LKo2MLEXeOlJqV85Lgxsbe6/aiRc/psnxLxFXRPeerrjS7
 PRGbD+WHz2nsrkR53eqUDxQN2pQwXqFtSMHFllr1jOZqGh0PTND/md5eUzxkbjlL3p4lVUPpOuY
 ey/PR3GlDpqXWV7GhPvPdMq8l5P07zbcUcRMLc3Yp8GoOpnd4IpKMCW83xWrrC66xpW3tsCERng
 I/goB4neT8kF0GbaaLg+vliD+X998pmhrFcPXCFLrMkNa84bs6EhmyLm6h5JtPEdwBBZKtNtrld
 EZilZcvffvUwbdstYb+0uHWUjY5Ph+D
X-Received: by 2002:a05:7301:19ad:b0:2bd:c285:2fe with SMTP id
 5a478bee46e88-301185a91ccmr774856eec.9.1778631995110; 
 Tue, 12 May 2026 17:26:35 -0700 (PDT)
Received: from localhost.localdomain ([207.231.76.218])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f8884752ccsm19547827eec.17.2026.05.12.17.26.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 17:26:34 -0700 (PDT)
From: Aidan Garske <aidan@wolfssl.com>
To: u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, David Garske <david@wolfssl.com>,
 Aidan <aidan@wolfssl.com>
Subject: [PATCH v4 04/14] arm: dts: bcm2711-rpi-4-b: add Infineon SLB9670/9672
 TPM in U-Boot dtsi
Date: Tue, 12 May 2026 17:26:08 -0700
Message-ID: <20260513002625.76915-4-aidan@wolfssl.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1778619453.git.aidan@wolfssl.com>
References: <cover.1778619453.git.aidan@wolfssl.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 13 May 2026 02:26:53 +0200
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

Add a TPM 2.0 device-tree node on SPI0 CE1 for the Infineon
SLB9670 / SLB9672 TPM HAT.  The pinout matches the standard Linux
tpm-slb9670 overlay, so a board configured for U-Boot with this
addition behaves the same as a Linux kernel using that overlay.

The node is placed in bcm2711-rpi-4-b-u-boot.dtsi (the U-Boot-only
DT augmentation file) rather than in bcm2711-rpi-4-b.dts.  This
keeps the upstream-Linux-derived .dts unchanged, so SystemReady
firmware-provided FDTs and the upstream Linux device tree continue
to match what kernel.org ships - which addresses the concern raised
in v3 review about polluting the Linux DT path.

A spi0 alias is added pointing at the BCM2711 SPI controller, so
that wolfTPM's SPI HAL (which addresses the bus by number) finds
the TPM at bus 0 CS 1.

Signed-off-by: Aidan Garske <aidan@wolfssl.com>
---
 arch/arm/dts/bcm2711-rpi-4-b-u-boot.dtsi | 39 ++++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 arch/arm/dts/bcm2711-rpi-4-b-u-boot.dtsi

diff --git a/arch/arm/dts/bcm2711-rpi-4-b-u-boot.dtsi b/arch/arm/dts/bcm2711-rpi-4-b-u-boot.dtsi
new file mode 100644
index 00000000000..11174e62131
--- /dev/null
+++ b/arch/arm/dts/bcm2711-rpi-4-b-u-boot.dtsi
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * U-Boot-only additions for Raspberry Pi 4 Model B
+ *
+ * Adds a TPM 2.0 device tree node on SPI0 CE1 for the Infineon
+ * SLB9670 / SLB9672 TPM HAT (electrically identical pinout to
+ * the Linux tpm-slb9670 overlay).
+ *
+ * The node lives in *-u-boot.dtsi rather than in bcm2711-rpi-4-b.dts
+ * so it is only visible to U-Boot's bundled FDT and never pollutes
+ * the upstream Linux DT or a SystemReady firmware-provided FDT.
+ */
+
+#include "bcm283x-u-boot.dtsi"
+
+/ {
+	aliases {
+		spi0 = &spi;
+	};
+};
+
+&gpio {
+	bootph-all;
+};
+
+&spi {
+	status = "okay";
+	bootph-all;
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi0_gpio7>;
+
+	/* Infineon SLB9670 / SLB9672 TPM 2.0 on CE1 (GPIO7) */
+	tpm@1 {
+		compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
+		reg = <1>;
+		spi-max-frequency = <32000000>;
+		bootph-all;
+	};
+};
-- 
2.49.0

