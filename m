Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9306FCD1288
	for <u-boot@archiver.kernel.org>; Sat, 30 Mar 2024 21:36:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00ACA882B2;
	Sat, 30 Mar 2024 22:36:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Z1RtAlhu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D5E5882C0; Sat, 30 Mar 2024 22:36:31 +0100 (CET)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5534587E2E
 for <u-boot@lists.denx.de>; Sat, 30 Mar 2024 22:36:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6ea895eaaadso732702b3a.1
 for <u-boot@lists.denx.de>; Sat, 30 Mar 2024 14:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711834587; x=1712439387; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KEeExF3D7Fl5Rf+By3J8Z/Q8SsE809Nah3ujRm5PVK0=;
 b=Z1RtAlhuDMDY+Ss5fNsEMGqrHUv5Ap/T/LO+8fSq0ESgbISxEAoN5j15ge6ZpBr7CP
 9WoiHh/RKlr4MosGCXoY5qWb2gQQo9yXpA9JRRXnSnUEIdEK7YnoFRonfZyKYmigLkaq
 g1dum3GelzBPb8QCejRyvGpQzpkPJsMu0CAJ7dQzyhsGtH7otbdG5UyWKY5iDeEpBuF3
 tTGW4M+v7T7hGdZhZQDiZqLIncbvektqWYo6YVcJT+ecWCEdI7cEpPqx0muaf0S1q/c+
 HHTWwopywooMH4kfY35bEbq0VEz19Vq0AhWEIq1aUx6Z1yDi7wAkU7SB8qcs6+icHVfy
 uP2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711834587; x=1712439387;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KEeExF3D7Fl5Rf+By3J8Z/Q8SsE809Nah3ujRm5PVK0=;
 b=lAg+59cMtYbVbusthK24cr0ekNvIHE5TyWfonhCXN8O72FGCGzYOX6hHkJVTXIuCVE
 XELOtekU33kYwOxN6STbo6Ta8yVeeeCQfO4x6geTNOKyR7nHnEywHG8+j2SJRxRZ4MgS
 6HWdsP2I4ryeR+0xAWGIrRlB2wNrrzwhkHbqkP/5DEIxyBT9+KrGT5v4CCtejtXZ7dCU
 R4M3SglKVYtpCku5FIl2Hav9AiN4wOZa3T+TuT7UQtzyBLA8n3v3A+rmHoUFR3uwpQ4C
 kXpScq0oC5+iBSigRSFaZr4cEc5Vm+0qP6ElVnJVgdQPLr57g3jgxm5w2wyhKjYU+Dq/
 BCHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0KKB/RQixjR4LplpEtVyejI+zYlzf5wYifTxoqtfWN18zr3FF5If528vAE9fJY+u9DvfCNmtq8CPh5IKJ/0lRTgUjTg==
X-Gm-Message-State: AOJu0YzGq00/3a4ULPNSFaElBSdH/sKAkgbkDBTBX4ODLKxV0Ei4wPkC
 j8bFmjDAwmKFAr4i/EYhk/gA937nxrGdJyd2DwCB3eEthExRi42dIE/PuTTf
X-Google-Smtp-Source: AGHT+IF4vVH/vtmXLEA2F5ak3/yZXFinbbUX2CSwOHzPHI91ZaAwsoISgWhe3JQW0JFwUXdj1eFCrQ==
X-Received: by 2002:a17:903:503:b0:1dd:b883:3398 with SMTP id
 jn3-20020a170903050300b001ddb8833398mr6311997plb.4.1711834587476; 
 Sat, 30 Mar 2024 14:36:27 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:3bdf:3f7c:9329:bd24])
 by smtp.gmail.com with ESMTPSA id
 n16-20020a17090ac69000b002a06260ac96sm5032420pjt.16.2024.03.30.14.36.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Mar 2024 14:36:27 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: festevam@gmail.com
Cc: baruch@tkos.co.il, trini@konsulko.com, josua@solid-run.com,
 u-boot@lists.denx.de, cgmeiner@igalia.com
Subject: [PATCH v2] mx6cuboxi: Fix Ethernet after DT sync with Linux
Date: Sat, 30 Mar 2024 18:35:55 -0300
Message-Id: <20240330213555.2889619-1-festevam@gmail.com>
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

From: Josua Mayer <josua@solid-run.com>

The i.MX6 Cubox-i and HummingBoards can have different PHYs at varying
addresses. U-Boot needs to auto-detect which phy is actually present,
and at which address it is responding.

Auto-detection from multiple phy nodes specified in device-tree does not
currently work correct. As a work-around merge all three possible phys
into one node with the special address 0xffffffff which indicates to the
generic phy driver to probe all addresses.

Signed-off-by: Josua Mayer <josua@solid-run.com>
[fabio: Added the changes to imx6qdl-sr-som-u-boot.dtsi.]
Signed-off-by: Fabio Estevam <festevam@gmail.com>
Tested-by: Christian Gmeiner <cgmeiner@igalia.com>
---
Changes since v1:
- Disable ethernet-phy at addresses 0, 1 and 4.
- Remove the fixup of the fake 0xffffff address before booting Linux.

Josua and Christian,

I got access to a imx6 humming board and I was able to test it.

This is the minimal fix I came up based on your suggestions.

There is no need to fixup of the fake 0xffffff address before booting Linux,
as this fake address does not exist in Linux.

Successfully tested Ethernet in U-Boot and in the kernel.

Given that Ethernet is currently broken, I suggest we go with this
version to restore Ethernet for 2024.04.

What do you think?

 ...qdl-hummingboard2-emmc-som-v15-u-boot.dtsi |  1 +
 arch/arm/dts/imx6qdl-sr-som-u-boot.dtsi       | 49 +++++++++++++++++++
 2 files changed, 50 insertions(+)
 create mode 100644 arch/arm/dts/imx6qdl-sr-som-u-boot.dtsi

diff --git a/arch/arm/dts/imx6qdl-hummingboard2-emmc-som-v15-u-boot.dtsi b/arch/arm/dts/imx6qdl-hummingboard2-emmc-som-v15-u-boot.dtsi
index e9b188ed6587..358cf8abc4ff 100644
--- a/arch/arm/dts/imx6qdl-hummingboard2-emmc-som-v15-u-boot.dtsi
+++ b/arch/arm/dts/imx6qdl-hummingboard2-emmc-som-v15-u-boot.dtsi
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 
 #include "imx6qdl-u-boot.dtsi"
+#include "imx6qdl-sr-som-u-boot.dtsi"
 
 / {
 	board-detect {
diff --git a/arch/arm/dts/imx6qdl-sr-som-u-boot.dtsi b/arch/arm/dts/imx6qdl-sr-som-u-boot.dtsi
new file mode 100644
index 000000000000..0bd7df02dd66
--- /dev/null
+++ b/arch/arm/dts/imx6qdl-sr-som-u-boot.dtsi
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+
+#include <dt-bindings/gpio/gpio.h>
+
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_microsom_enet_ar8035>;
+	phy-handle = <&phy>;
+	phy-mode = "rgmii-id";
+
+	/*
+	 * The PHY seems to require a long-enough reset duration to avoid
+	 * some rare issues where the PHY gets stuck in an inconsistent and
+	 * non-functional state at boot-up. 10ms proved to be fine .
+	 */
+	phy-reset-duration = <10>;
+	phy-reset-gpios = <&gpio4 15 GPIO_ACTIVE_LOW>;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethernet-phy@0 {
+			status = "disabled";
+		};
+
+		ethernet-phy@1 {
+			status = "disabled";
+		};
+
+		ethernet-phy@4 {
+			status = "disabled";
+		};
+
+		phy: ethernet-phy@ffffffff {
+			/*
+			 * The PHY can appear either:
+			 * - AR8035: at address 0 or 4
+			 * - ADIN1300: at address 1
+			 * Actual address being detected at runtime.
+			 */
+			reg = <0xffffffff>;
+			qca,clk-out-frequency = <125000000>;
+			qca,smarteee-tw-us-1g = <24>;
+			adi,phy-output-clock = "125mhz-free-running";
+		};
+	};
+};
-- 
2.34.1

