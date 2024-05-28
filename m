Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAD9FC25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 22:21:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D40F88584;
	Wed, 29 May 2024 00:21:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IONEmMHT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 915DD884B4; Tue, 28 May 2024 19:05:11 +0200 (CEST)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAD8F8844E
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 19:05:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=liujianfeng1994@gmail.com
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6f8e98760fcso836023b3a.1
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 10:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716915907; x=1717520707; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RPmPM7Lpw1CIjSI3VWRnsQ6HSVBVsdwmHSWa7zMAIGg=;
 b=IONEmMHTPeo9sOt+AdKAhJbV5HLcTsMLv4yeZA5vGGK5H2yT/DLpp1eMshKcOjFffs
 ZljxL+JGG7GGsQf4B61iopJ7viLbsxHbSr9z6XyyGj+O//Ox8jANufh8CHakJQ16RuRd
 c7KGGnb2dzuHMfyxcgND5kfMB6TntlJqSN0evmjIVZ5ANXDHchIZ0FpMWiDMPtCnxb4h
 WOHJymwtRJvIeJ7DHBFXOF43SnjjvAD2TQ3IbpgbT5hMsY9cbToLm9Gu12WAXiZKka2v
 7snazcsulkYCh0AL4+VEZd4obOhdMYAzwRHSSVyjyx3uF20vWIOng1f4SI1xaJZHUA34
 M2fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716915907; x=1717520707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RPmPM7Lpw1CIjSI3VWRnsQ6HSVBVsdwmHSWa7zMAIGg=;
 b=cYX8xwKb/NQrAW+s7neMgUzSMo/ooLRUQhiTWM5ym91BB+h6J8QoM6AWby0OaraKCD
 Cnk8sK6dg0V/dK2lJ+LEXJM9k9M7OyUswZJh/ogRYU7hcmh8rdFLgxC8tfo38KZ9ps0E
 EVyQDVizQgZIhtsDewes6g0r2auw/XsVYbvwy0W0dh6FzFNst4OfwyBf/w8DKBtLoef5
 uv0FI6mj7uWrhsa+qtR2ieFYT+KgRHo6PyxxyuMyadQFuLerEF+VRnazP0fZjmXQ5P3D
 n5dp3hNfJ0q31/usy2G+GuintYsN6Bo6oC76nhWwD0PEolNDy6yN29W/5ZF2W1PQ8YvM
 0LTw==
X-Gm-Message-State: AOJu0Yw5GrJ1NqfQ138FJW/H7qEQmmyf1acSF7JmORSvRKyoXlsgsUkI
 KFNwmE7ct3U4jxZcVpgeVsWj4Cah8qqMd4KSPA8OkyfYUbc8aausII4uyiTNhVFKjg==
X-Google-Smtp-Source: AGHT+IGbrTx1Y1bxQr9Wq+nzcrkQ880N4Epx7o5BXw/HZwrmht3FDgFKacRraTZc4cqh5hYS7ybQQw==
X-Received: by 2002:a17:902:da91:b0:1f3:7f0:74d with SMTP id
 d9443c01a7336-1f4486c6241mr197155915ad.11.1716915906813; 
 Tue, 28 May 2024 10:05:06 -0700 (PDT)
Received: from localhost.localdomain ([221.220.133.99])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f47efff203sm53037705ad.241.2024.05.28.10.05.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 10:05:06 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: u-boot@lists.denx.de
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Heiko Stuebner <heiko@sntech.de>, Jianfeng Liu <liujianfeng1994@gmail.com>,
 Diederik de Haas <didi.debian@cknow.org>,
 Kever Yang <kever.yang@rock-chips.com>, Niklas Cassel <cassel@kernel.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 01/10] arm64: dts: rockchip: Add rk3588 GPU node
Date: Wed, 29 May 2024 01:03:57 +0800
Message-Id: <20240528170406.353616-2-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528170406.353616-1-liujianfeng1994@gmail.com>
References: <20240528170406.353616-1-liujianfeng1994@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 29 May 2024 00:21:20 +0200
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

