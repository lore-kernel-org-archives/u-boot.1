Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A8ABC36008
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 18:01:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB304817EC;
	Mon, 24 Mar 2025 19:00:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="mUwREogm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4435F80548; Mon, 24 Mar 2025 19:00:55 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09356808AF
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 19:00:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3914a5def6bso2856036f8f.1
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 11:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1742839252; x=1743444052;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rk2FYKP+658TBtLU/m3Z1R7K/iJrSTDoXsuAJF08vcQ=;
 b=mUwREogmk3lj+hp4DatvnB8rwgWIquYuSvtClBNYJynJGokqltRMejhx7i0ZnfgMiI
 sV+crLrACdcn4Fm28qUvoB4Hl3QwDvFE7K3jLktx9Yg8tpjySc4s/Y08HPXv/DDEJiCr
 qysG/VTJr9cOpZQtxq3Blp7crPXOMSBE2xYZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742839252; x=1743444052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rk2FYKP+658TBtLU/m3Z1R7K/iJrSTDoXsuAJF08vcQ=;
 b=eVqe5pT9C8nmxfl38aGroBLFfPsFd5IDfb9ZvCbNRejeFd6PFNDUzBUa6duU3YPWBe
 FCkJzNqbyhR7qSgkdBW5OOEXGgcl8s0TawhPO671eDMkjr8+FtJevWD6FOZfEM2+PXoO
 c6jldhU0YHKvDMcoorkSkuQ6k463x6TCP9AsZUC9ItXLkYOBu3ydHTfGxFmnBiIKAe+A
 Zc8iY6rXMxncJs+onEazj4+QatVR06doZ/eZy3s398fx8w+U/MudbBpsFBtuzeJGOV6t
 2V92GamJmwGXF5OWKBTCa+rqOo5L1V3DakQOJWiY4B7VS6N3u6L2xtPS+pvut6rIcrsS
 0Dbg==
X-Gm-Message-State: AOJu0YxZJ0eggsEKfdrFr0tkEI7LkN9vA1dX410k6zZfhNDyLm5Od9+7
 2lKNjBU0asRT85i7stX+CZwKXKCRZXwYw2XHJiP1sRDzZ2oytwg5QX7U0yiKZWL1Nfsyu64w3ah
 8
X-Gm-Gg: ASbGncuXQoej1Gpx0PWfpg0PAzTfGPvCn2Gq7vKC5jtSkeSbT9PW7/0+DrwXTiPoc+U
 uGP4sydEPt/Ba2P7vfkuPMtxnyOS9519MitnHEkRMXZecgndNXbNaZPfbqdC98H89KxhW3pMGRY
 6FJ9RJJMwaDnCsvBr6lRZ8GYzrujBJZdnlr1c3ucOeNiUkVZuXQSyakfqs1AVkw6ynHBpzWK41x
 VpoQvGpY5uWhvSYp3NPt6P+DAsu68uXw3YdKtVjbYz3MTCQfBy6iPq0NdWk4w/8zoqaOY43JC7V
 aDGAdpcOAtLpQeJC3btOHaG6sJ4VkUmWwOCk4zTaA1xnkPAvRYLY+lvZM1G2g+9i8C3uMAFsF07
 SH8sf6yVb4UCOhY/Du6ylIs6k5OFy+49hHTwiI8muj9EWTA==
X-Google-Smtp-Source: AGHT+IEU07LD1fH2ljsaqwQTZjFGB5fer1YGjLvux9265p9QJsVsOStfjbGjFueJKxcBu5yA9PgXKw==
X-Received: by 2002:a5d:6d88:0:b0:391:2e6a:30fe with SMTP id
 ffacd0b85a97d-3997f92d305mr15123811f8f.39.1742839252269; 
 Mon, 24 Mar 2025 11:00:52 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com ([2.196.41.220])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f556a4sm178289285e9.22.2025.03.24.11.00.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 11:00:51 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 1/6] ARM: dts: stm32: add DSI support on stm32f769
Date: Mon, 24 Mar 2025 19:00:25 +0100
Message-ID: <20250324180047.1571378-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250324180047.1571378-1-dario.binacchi@amarulasolutions.com>
References: <20250324180047.1571378-1-dario.binacchi@amarulasolutions.com>
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
---

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

