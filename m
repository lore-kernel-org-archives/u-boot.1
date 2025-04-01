Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08087C36008
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 07:01:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE54981E5B;
	Tue,  1 Apr 2025 09:01:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="MNTzqvdk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7889581EDD; Tue,  1 Apr 2025 09:01:35 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AECA80584
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 09:01:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43cef035a3bso36942225e9.1
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 00:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1743490892; x=1744095692;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i044n2zFt+fwDjOmTfhSbZNrYh1Q9DyCsR3YROwfPZg=;
 b=MNTzqvdkp1/eFDVB8mPgAIGET/NQvrT/KR8W8vS/D2pEiagwCUpN2PZhd4WN0fkZjM
 ACGXhkabZbRUhqTxvz34RPC3YPI1r1VHbZmYJs3J728nwwBcxuOR2yk1tlzwdYvKaKcT
 idut5UUNBqXAcXqSuWdTY0wlwMjSIsyGZuPMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743490892; x=1744095692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i044n2zFt+fwDjOmTfhSbZNrYh1Q9DyCsR3YROwfPZg=;
 b=ewBh8PHwQxJ+KbuEfR/Kx1zmXSEeQwr71Ze05Lo0LbqUB+gfEc7VdjC+4t+nLzm0iZ
 2pT/uPSIHNZY4jnpPSk8G8OAqBS3OIMD5WAXkvXvc4R9gdSpF2Kg/QRED4KG8rCC2HQs
 8rM0hiRtaJFCea35NgYlkL6avor+tXnzb+PyYqwzWL1O4Idfw6iQv7XpBMP8GjJjtsGR
 DY3cbwec0mUals0LyLKTpLiz0I2FmwG5gWO7xeTJor2W5goVl8W7FvScU8nWGujAuNiJ
 NMEGRmzpkvgzLnxFBi0/5OiZWu215OoMP+lD2Bp0AkgOvzGtLlaW+3YfrtVtufMyQ+AI
 +2tw==
X-Gm-Message-State: AOJu0Yy21CP+awJed4rz2529tC2k6Ez/yKcIX3Y9bzyO165iLfAdw7sr
 VKT29LB7R9cRBltaVBiHkKqJbb765fsTG0vDVKNFfwMHhshz70WwIwzP7+fDzbn+TWD5RNMMQzg
 k
X-Gm-Gg: ASbGncsqgydeT0RwnnjWV0Ic3taOKheRCshd0w0j0oJ1lAZFJd+v4Jq+I9LjOSOyBkT
 D4pLTjcaXzjy2/Z0AbQUKDPjpfV0T2xM9s0sGTPkvq6J9MuTanTK1KUWnd9E59V62QWV5np+c+l
 QL70pAXvUSFNnOB9fjMIm6p2aIICBr0Y64N4QFeVMECUxtb2C4YoQFuGcgu98OC+jTRvbrLfxTV
 DwIYgh5zTh2xfTzBl2ks5IuaYJnnH0TBzNm1Xsr8CgWkxIsYAQ1n+Vkl70JKcemeo8YQWHlAGV2
 PvJzDxvVhYI6xC4sfjJPTaEXy3oxODoXQRdTVVlryPK1dDcOJY9zLS3MMEbXhcz+zp4Y9fX9krF
 IIZR6rWzl8w==
X-Google-Smtp-Source: AGHT+IGlvwzgkPuDKTDQIkOeCeOhyeM7o4vRhw5i/5zKLYdzpsXb4SMK0RjulavKgr5/jiL4Wzbqbg==
X-Received: by 2002:a05:600c:83c4:b0:439:91dd:cf9c with SMTP id
 5b1f17b1804b1-43db6223feamr148997085e9.10.1743490890455; 
 Tue, 01 Apr 2025 00:01:30 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.. ([2.196.40.230])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b66b015sm13701760f8f.54.2025.04.01.00.01.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 00:01:30 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 1/6] ARM: dts: stm32: add DSI support on stm32f769
Date: Tue,  1 Apr 2025 09:00:52 +0200
Message-ID: <20250401070125.3705126-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250401070125.3705126-1-dario.binacchi@amarulasolutions.com>
References: <20250401070125.3705126-1-dario.binacchi@amarulasolutions.com>
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

[backport from Linux commit a995fd2e8b3c6defd1dcdd3fb350c224e41ea1d0]

Add support for MIPI DSI Host controller. Since MIPI DSI is not
available on stm32f746, the patch adds the "stm32f769.dtsi" file
containing the dsi node inside.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

---

Changes in v2:
- Add Reviewed-by tag of Patrice Chotard

 arch/arm/dts/stm32f769-disco-u-boot.dtsi | 41 +++++++++++-------------
 arch/arm/dts/stm32f769-disco.dts         |  2 +-
 arch/arm/dts/stm32f769.dtsi              | 20 ++++++++++++
 3 files changed, 39 insertions(+), 24 deletions(-)
 create mode 100644 arch/arm/dts/stm32f769.dtsi

diff --git a/arch/arm/dts/stm32f769-disco-u-boot.dtsi b/arch/arm/dts/stm32f769-disco-u-boot.dtsi
index add55c96e21f..c5ae753debe6 100644
--- a/arch/arm/dts/stm32f769-disco-u-boot.dtsi
+++ b/arch/arm/dts/stm32f769-disco-u-boot.dtsi
@@ -44,30 +44,25 @@
 			};
 		};
 	};
+};
 
-	soc {
-		dsi: dsi@40016c00 {
-			compatible = "st,stm32-dsi";
-			reg = <0x40016c00 0x800>;
-			resets = <&rcc STM32F7_APB2_RESET(DSI)>;
-			clocks = <&rcc 0 STM32F7_APB2_CLOCK(DSI)>,
-				  <&rcc 0 STM32F7_APB2_CLOCK(LTDC)>,
-				  <&clk_hse>;
-			clock-names = "pclk", "px_clk", "ref";
-			bootph-all;
-			status = "okay";
-
-			ports {
-				port@0 {
-					dsi_out: endpoint {
-						remote-endpoint = <&panel_in>;
-					};
-				};
-				port@1 {
-					dsi_in: endpoint {
-						remote-endpoint = <&dp_out>;
-					};
-				};
+&dsi {
+	clocks = <&rcc 0 STM32F7_APB2_CLOCK(DSI)>,
+		 <&rcc 0 STM32F7_APB2_CLOCK(LTDC)>,
+		 <&clk_hse>;
+	clock-names = "pclk", "px_clk", "ref";
+	bootph-all;
+	status = "okay";
+
+	ports {
+		port@0 {
+			dsi_out: endpoint {
+				remote-endpoint = <&panel_in>;
+			};
+		};
+		port@1 {
+			dsi_in: endpoint {
+				remote-endpoint = <&dp_out>;
 			};
 		};
 	};
diff --git a/arch/arm/dts/stm32f769-disco.dts b/arch/arm/dts/stm32f769-disco.dts
index d63cd2ba7eb4..ad1b442055e1 100644
--- a/arch/arm/dts/stm32f769-disco.dts
+++ b/arch/arm/dts/stm32f769-disco.dts
@@ -5,7 +5,7 @@
  */
 
 /dts-v1/;
-#include "stm32f746.dtsi"
+#include "stm32f769.dtsi"
 #include "stm32f769-pinctrl.dtsi"
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/gpio/gpio.h>
diff --git a/arch/arm/dts/stm32f769.dtsi b/arch/arm/dts/stm32f769.dtsi
new file mode 100644
index 000000000000..4e7d9032149c
--- /dev/null
+++ b/arch/arm/dts/stm32f769.dtsi
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 Dario Binacchi <dario.binacchi@amarulasolutions.com>
+ */
+
+#include "stm32f746.dtsi"
+
+/ {
+	soc {
+		dsi: dsi@40016c00 {
+			compatible = "st,stm32-dsi";
+			reg = <0x40016c00 0x800>;
+			clocks = <&rcc 1 CLK_F769_DSI>, <&clk_hse>;
+			clock-names = "pclk", "ref";
+			resets = <&rcc STM32F7_APB2_RESET(DSI)>;
+			reset-names = "apb";
+			status = "disabled";
+		};
+	};
+};
-- 
2.43.0

