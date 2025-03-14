Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9965AC282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 16:03:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D884081EBB;
	Fri, 14 Mar 2025 17:02:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YybIVXEH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D02881E18; Fri, 14 Mar 2025 17:02:41 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E1A681DE9
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 17:02:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ac25d2b2354so401209466b.1
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 09:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741968159; x=1742572959; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WnMpcNP9NtTrvV7sefm6IlQnVRV84F2bIJQZDZLSC0E=;
 b=YybIVXEHKfxRerZmABtTnOtG6mmi4T0LHQdabZEOEVgi9Vs3BiUWBu1jI4yjEnlFO1
 svl4qGIjGsC7xD16yDyjz+JjiRw/tK6vJOKasCgNjQKhdOJbXq/Db5AaQL2XznbeEpR3
 cpOLlQu8VdEOXjwlRcIH2KVtMEnYTFo7MbMtYn4uao1Lg0bOQtjDW2ckDVWaHJuFPf1g
 zVUlVWc+fLUjKcD50+CGLGUPQHS6sutFSna+1+NgSVEd7HuXcAzDCEYMoR8YrxvpuDPQ
 wirRFUqgB9FewDeOtFRFaY+xrAdblCaoMmatADVYlHO7AYSZTGundcgh10XoC1NWF1z8
 OJ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741968159; x=1742572959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WnMpcNP9NtTrvV7sefm6IlQnVRV84F2bIJQZDZLSC0E=;
 b=SkUiu588Gh4AHhXe/KaR2BPWnc+uC7Qj1anhiA3l7eThmS8+f4cBuDiArUwnNCMFzd
 RO9AB0MJ8kXvLFl1oe97GoZlDxK0kdzn0s3wVkXp/wcM5goStlMINM4iTD/z76aOX6rh
 Zvv+Hkgk8MP62SWiRaVl1OAo0aWIYppmvTmiAtSomJjn2E13Qp5HyFGp2td73v4XchrH
 /fhGF+T+oKQKXVseCV7arbxlic3l8KDfE+VzFx5mZmx9NnxH5IXTL+RCbjiw3x06uV1E
 WXCLKYLg8XRSwYmEc929x6HQdfEPm51ezVIvoaLN6h+1TNexh6XLVmsxZFyljXsFWolT
 d6sA==
X-Gm-Message-State: AOJu0Yx46TL1sIWka6r7XvNE+GWNGNOB7Jzbi9xmgVF6IDg4iU+Yt7XZ
 Llc7R151r5HX/9i+I2BVGx8efO9hI6Uy34OAiXnMIIfB/hrchIk2
X-Gm-Gg: ASbGncuvZo+VHop+c+IDzBnHNtX1pPMSgMb/Rfssi2z0tBZs0N9n1ojolQbQKF0mtda
 5J52mPCiVCb/ef+KJ4zZKS8LbPpTXgBb0g1wd/wxWtIM6M3Laab5sgUPnToxuuzo91kYqv0Mti7
 HkFE1PrFvMkIbhZxYyd/phLzHQ25USV1+GYu7nGLrhE1MDbwDP5H+LS5Yr+CGKyHmbyHOdfrrTI
 WWvv6LdZ4FZLQPZAHwNwFutrkaguPQ5ByHMWrx5cJcwxx3RjrzkCC2In2yDr6bqHGMKOcMzlzG2
 qPmNZBdqa5VGj5PbuLp5Wmz1Qt07XW6mIYyo
X-Google-Smtp-Source: AGHT+IEdcqCXElgrzNxgzPdR1mqqTfZrudjJ70w6MYsQ2ldNYS8rUPuFmx+PT251sD3Xk5BBJHGxaw==
X-Received: by 2002:a17:907:868a:b0:abf:40a2:40c8 with SMTP id
 a640c23a62f3a-ac3302f370dmr336686666b.28.1741968158693; 
 Fri, 14 Mar 2025 09:02:38 -0700 (PDT)
Received: from xeon.. ([188.163.112.73]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac314a47fdcsm242953066b.146.2025.03.14.09.02.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 09:02:38 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 4/4] ARM: tegra: tf700t: upgrade bindings
Date: Fri, 14 Mar 2025 18:02:16 +0200
Message-ID: <20250314160216.36327-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250314160216.36327-1-clamor95@gmail.com>
References: <20250314160216.36327-1-clamor95@gmail.com>
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

Align TF700T bindings with existing upstream device trees. OF_UPSTREAM
migration is possible already but resulting size of binary exceeds maximum
allowed size with full size trees.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/dts/tegra30-asus-tf700t.dts | 96 +++++++++++++++++++---------
 1 file changed, 67 insertions(+), 29 deletions(-)

diff --git a/arch/arm/dts/tegra30-asus-tf700t.dts b/arch/arm/dts/tegra30-asus-tf700t.dts
index 6dc760b90d6..47606ede9d6 100644
--- a/arch/arm/dts/tegra30-asus-tf700t.dts
+++ b/arch/arm/dts/tegra30-asus-tf700t.dts
@@ -15,7 +15,14 @@
 			rgb {
 				status = "okay";
 
-				nvidia,panel = <&tc358768>;
+				/delete-property/ nvidia,panel;
+
+				port {
+					dpi_output: endpoint {
+						remote-endpoint = <&bridge_input>;
+						bus-width = <24>;
+					};
+				};
 			};
 		};
 	};
@@ -118,38 +125,69 @@
 				vddio-supply = <&vdd_1v8_vio>;
 				vddmipi-supply = <&vdd_1v2_mipi>;
 
-				panel = <&panel>;
+				/*
+				 * Panasonic VVX10F004B00 or HYDIS HV101WU1-1E1
+				 * LCD SuperIPS+ Full HD panel.
+				 */
+				panel@1 {
+					compatible = "panasonic,vvx10f004b00";
+					reg = <1>;
+
+					power-supply = <&vdd_pnl_reg>;
+					backlight = <&backlight>;
+
+					display-timings {
+						timing@0 {
+							/* 1920x1200@60Hz */
+							clock-frequency = <154000000>;
+
+							hactive = <1920>;
+							hfront-porch = <48>;
+							hback-porch = <80>;
+							hsync-len = <32>;
+							hsync-active = <1>;
+
+							vactive = <1200>;
+							vfront-porch = <3>;
+							vback-porch = <26>;
+							vsync-len = <6>;
+							vsync-active = <1>;
+						};
+					};
+
+					port {
+						panel_input: endpoint {
+							remote-endpoint = <&bridge_output>;
+						};
+					};
+				};
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+
+						bridge_input: endpoint {
+							remote-endpoint = <&dpi_output>;
+							bus-width = <24>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+
+						bridge_output: endpoint {
+							remote-endpoint = <&panel_input>;
+						};
+					};
+				};
 			};
 		};
 	};
 
-	panel: panel {
-		compatible = "panasonic,vvx10f004b00";
-
-		power-supply = <&vdd_pnl_reg>;
-		backlight = <&backlight>;
-
-		/delete-property/ enable-gpios;
-
-		display-timings {
-			timing@0 {
-				/* 1920x1200@60Hz */
-				clock-frequency = <154000000>;
-
-				hactive = <1920>;
-				hfront-porch = <48>;
-				hback-porch = <80>;
-				hsync-len = <32>;
-				hsync-active = <1>;
-
-				vactive = <1200>;
-				vfront-porch = <3>;
-				vback-porch = <26>;
-				vsync-len = <6>;
-				vsync-active = <1>;
-			};
-		};
-	};
+	/delete-node/ panel;
 
 	vdd_1v2_mipi: regulator-mipi {
 		compatible = "regulator-fixed";
-- 
2.43.0

