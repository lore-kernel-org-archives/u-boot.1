Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 852D0C25B79
	for <u-boot@archiver.kernel.org>; Mon, 27 May 2024 21:34:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F99B8838B;
	Mon, 27 May 2024 23:34:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g1PlLW5w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5566B87D1A; Mon, 27 May 2024 19:02:41 +0200 (CEST)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF87E87E95
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 19:02:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=liujianfeng1994@gmail.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1f4a52b9589so8284825ad.3
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 10:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716829357; x=1717434157; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RPmPM7Lpw1CIjSI3VWRnsQ6HSVBVsdwmHSWa7zMAIGg=;
 b=g1PlLW5wm7HEk2lA86UNw8TaEkP+o0tl142FCzCvH5K20cdnTAZrG8rmp4ml5FPZ2x
 H+mtpjtcwXkbfqJyjNe48QlKpAWFWp/EoC/t33CHuVBYpm7pNwyw8nc+waqQqDRsvEWv
 4qdPsCyv1lGopXDjsiqPIZ3n4t8UZYyloRygd/xPLy/cRVrBjmTKr8sI95CAmL7FhPmH
 5s4X8wcooAiDmbhop0KxhX6XXHshuHQRDGUvZCzVs1QKTqC9E0ZrnEKLdbJZfXPLXUfs
 TKzvmXT5NRnZnikvJAZ3iLKhg2oobbNspAOfib6DRFBefGgUzHauW5OxG8+kpEc4PXHh
 nCNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716829357; x=1717434157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RPmPM7Lpw1CIjSI3VWRnsQ6HSVBVsdwmHSWa7zMAIGg=;
 b=k9FBHaojJ1x0iZsFmItH9BI3ZlGk0J+vfxAsCTzhe3lCXESJ8c/SI/bnL6tnjTNxin
 wHRrySWOeE9tBstEEzOANKEFEEKtGtnJx9K629EZ4OyVtuCpZWwo5Koug3uq+ULZIj/J
 dGz87lANCy6S+lfvXmA9R6xjZFvleSMcniwG8XcLTqEv7PmHTjF78ECLcglIwpTXTwli
 Mt8L7bz8FEpoYlPneuoIA04lEDUcdnuy2421AFmSy7PDzA1J5IGNKToiynOTNbs9FVbO
 b/kNt4l1H+QLJbCLIAkbKVvQDLusvI0IzPwzU/sp5N877sQAmUDrSWC1Mjy6SmQBK+fE
 gP9g==
X-Gm-Message-State: AOJu0YzrbxyLAuKtSLbXjZiZFO8GhOFsQV9zLpI4JBrMQTNnG+s8PIaK
 r8jFFGPNtfbI7p5vOsANLkRSjeGNi+1CFQDygYc8Y9eyUE13aA6joUF2+T0UfTQ=
X-Google-Smtp-Source: AGHT+IGC8+ygzbOWK+mXZV0UIUidOZR0/yIjRM8XbHISXQAXoH5EMTJKqQEM0lusMTDZHUF0s2cIdw==
X-Received: by 2002:a17:902:c402:b0:1f4:5c5d:2ae0 with SMTP id
 d9443c01a7336-1f45c5d2bb4mr89159025ad.43.1716829356940; 
 Mon, 27 May 2024 10:02:36 -0700 (PDT)
Received: from localhost.localdomain ([221.220.133.99])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c757845sm63462095ad.5.2024.05.27.10.02.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 10:02:36 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: u-boot@lists.denx.de
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Heiko Stuebner <heiko@sntech.de>, Jianfeng Liu <liujianfeng1994@gmail.com>,
 Diederik de Haas <didi.debian@cknow.org>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 1/7] arm64: dts: rockchip: Add rk3588 GPU node
Date: Tue, 28 May 2024 01:02:08 +0800
Message-Id: <20240527170214.283988-2-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527170214.283988-1-liujianfeng1994@gmail.com>
References: <20240527170214.283988-1-liujianfeng1994@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 27 May 2024 23:34:36 +0200
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

From: Boris Brezillon <boris.brezillon@collabora.com>

Add Mali GPU Node to the RK3588 SoC DT including GPU clock
operating points

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Link: https://lore.kernel.org/r/20240326165232.73585-3-sebastian.reichel@collabora.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: 6fca4edb93d335f29f81e484936f38a5eed6a9b1 ]

(cherry picked from commit 3cd15354ea0c8668812bc0b3a4136606c10803e9)
Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
---

(no changes since v1)

 dts/upstream/src/arm64/rockchip/rk3588s.dtsi | 56 ++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/dts/upstream/src/arm64/rockchip/rk3588s.dtsi b/dts/upstream/src/arm64/rockchip/rk3588s.dtsi
index 87b83c87bd5..89d40cff635 100644
--- a/dts/upstream/src/arm64/rockchip/rk3588s.dtsi
+++ b/dts/upstream/src/arm64/rockchip/rk3588s.dtsi
@@ -501,6 +501,62 @@
 		status = "disabled";
 	};
 
+	gpu: gpu@fb000000 {
+		compatible = "rockchip,rk3588-mali", "arm,mali-valhall-csf";
+		reg = <0x0 0xfb000000 0x0 0x200000>;
+		#cooling-cells = <2>;
+		assigned-clocks = <&scmi_clk SCMI_CLK_GPU>;
+		assigned-clock-rates = <200000000>;
+		clocks = <&cru CLK_GPU>, <&cru CLK_GPU_COREGROUP>,
+			 <&cru CLK_GPU_STACKS>;
+		clock-names = "core", "coregroup", "stacks";
+		dynamic-power-coefficient = <2982>;
+		interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH 0>;
+		interrupt-names = "job", "mmu", "gpu";
+		operating-points-v2 = <&gpu_opp_table>;
+		power-domains = <&power RK3588_PD_GPU>;
+		status = "disabled";
+
+		gpu_opp_table: opp-table {
+			compatible = "operating-points-v2";
+
+			opp-300000000 {
+				opp-hz = /bits/ 64 <300000000>;
+				opp-microvolt = <675000 675000 850000>;
+			};
+			opp-400000000 {
+				opp-hz = /bits/ 64 <400000000>;
+				opp-microvolt = <675000 675000 850000>;
+			};
+			opp-500000000 {
+				opp-hz = /bits/ 64 <500000000>;
+				opp-microvolt = <675000 675000 850000>;
+			};
+			opp-600000000 {
+				opp-hz = /bits/ 64 <600000000>;
+				opp-microvolt = <675000 675000 850000>;
+			};
+			opp-700000000 {
+				opp-hz = /bits/ 64 <700000000>;
+				opp-microvolt = <700000 700000 850000>;
+			};
+			opp-800000000 {
+				opp-hz = /bits/ 64 <800000000>;
+				opp-microvolt = <750000 750000 850000>;
+			};
+			opp-900000000 {
+				opp-hz = /bits/ 64 <900000000>;
+				opp-microvolt = <800000 800000 850000>;
+			};
+			opp-1000000000 {
+				opp-hz = /bits/ 64 <1000000000>;
+				opp-microvolt = <850000 850000 850000>;
+			};
+		};
+	};
+
 	pmu1grf: syscon@fd58a000 {
 		compatible = "rockchip,rk3588-pmugrf", "syscon", "simple-mfd";
 		reg = <0x0 0xfd58a000 0x0 0x10000>;
-- 
2.34.1

