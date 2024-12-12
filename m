Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDE73E77182
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 10:14:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A34E8023A;
	Thu, 12 Dec 2024 11:13:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="M3fGgnDP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62D76801EB; Thu, 12 Dec 2024 11:13:45 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65391801DB
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 11:13:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5d414b8af7bso794100a12.0
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 02:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733998423; x=1734603223; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4GRcmeu67lAsFvpn2VWFY5oGYsBLuvjsjyiPjqspLAo=;
 b=M3fGgnDPDCeshpb3PNClNsxDDcUEG3ukoxebtqKi1d8nDbkLn3gS3RNOxqmAKRf92P
 er77W1jSHz3uglEZTU9A1r3HbhTYyOBxtvLe2FGWkyEsWCFfceqSVlWPn1pWa3pThGCg
 IMI+5O7DnEB6xXRd041UBA/IeK+g9X+yn0Yvunfk/LRWmZysCYUOJp9/+56qiO4uarGx
 WZRjaigQyX+b4jKwnYh9N5psKxQGJYLsw9u7rDK2OwnAceUD3R6evUs+uqbcsmBySaYH
 w3TWLAF4JlTEKZJt+sNKTo83RJPL7HD0o/hTp3jCj5BP/jUEFOeNZ7FlkNqd05Y+Q62c
 75kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733998423; x=1734603223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4GRcmeu67lAsFvpn2VWFY5oGYsBLuvjsjyiPjqspLAo=;
 b=EzKoHW+BnKR+9PzkiblgV7IrzalhcMWvmYWZm9r/CQbmHajGVED0KitUARHpZoSnHt
 +oR6v8GPOyp1gEH0KSEMatJx5NA6YzaEaG3mJ7yp799JWFkrivs9Opp3MxQjXFxonSTH
 8OF/IIUaucBMYwa70zrOQ6EVE/Q2CW6P4uTDk+djM+F3NRVwa/y9pJX6eJwozQa3Zff+
 8i+/6J+knhjFc+HiCC1mzlCGjgbk4snZjf0pvepOVmvVen6cGfvsnq1it1lmnAmixDaZ
 pPEFDDUxdXRL/uUP5YEitc9GF+FNjQpUgpVEzN5+Q/57//29jIls6+6tN/TNOPcOccIo
 q27g==
X-Gm-Message-State: AOJu0YwufVdFX84vmElp2ZLXU+dMmzbYzuU+gKxUR+3zk23WzJiUEUzn
 yq19kOvoJPpvE7T/XMUruCdsBW1nZHgHga+0pYltQmIyZQ3UyVZ+mdXnoA==
X-Gm-Gg: ASbGnctrfeuNJIDC9PvovGT5OM1QUQLUarnZmmTD6+pArDqVTlWQ2hWcIni8ZylfZJ2
 U7rRs1KsKnRlP2bqBpZaxNe3Sfs+E8FuvzMkg5FlHTuzSeyGxrmqGaNkF7nXYIVjeFBM8QEfHuX
 AziG9akLCrZB2Bskvqr7/ldMJl2DBuru35MojX2ZCuE294tWcUoEeNGSshp1Pc4QJqImwRBgR0m
 k8fnix+l72Zs7qN1C18OPnQXC70QMZ41xx3rsTl7EP/qdK2
X-Google-Smtp-Source: AGHT+IGnY/VBAUygQU8gsqlk8LgiVIVYZWqw0jy6UCm1Fk9+9rTQQnZskySW8S1jNfYJrqoryjBWHg==
X-Received: by 2002:a05:6402:3508:b0:5d0:c67e:e263 with SMTP id
 4fb4d7f45d1cf-5d4edcc5c1bmr491791a12.8.1733998422711; 
 Thu, 12 Dec 2024 02:13:42 -0800 (PST)
Received: from xeon.. ([188.163.112.48]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d149a25cdcsm10192647a12.9.2024.12.12.02.13.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 02:13:42 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 4/5] ARM: tegra124: dts: add missing DSI nodes
Date: Thu, 12 Dec 2024 12:13:30 +0200
Message-ID: <20241212101331.6135-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241212101331.6135-1-clamor95@gmail.com>
References: <20241212101331.6135-1-clamor95@gmail.com>
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

Bind missing DSI and MIPI calibration devices.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/dts/tegra124.dtsi | 39 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/dts/tegra124.dtsi b/arch/arm/dts/tegra124.dtsi
index ffec9cae09d..cac9b112302 100644
--- a/arch/arm/dts/tegra124.dtsi
+++ b/arch/arm/dts/tegra124.dtsi
@@ -136,6 +136,38 @@
 			status = "disabled";
 		};
 
+		dsi@54300000 {
+			compatible = "nvidia,tegra124-dsi";
+			reg = <0x54300000 0x00040000>;
+			clocks = <&tegra_car TEGRA124_CLK_DSIA>,
+				 <&tegra_car TEGRA124_CLK_DSIALP>,
+				 <&tegra_car TEGRA124_CLK_PLL_D_OUT0>;
+			clock-names = "dsi", "lp", "parent";
+			resets = <&tegra_car 48>;
+			reset-names = "dsi";
+			nvidia,mipi-calibrate = <&mipi 0x060>; /* DSIA & DSIB pads */
+			status = "disabled";
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		dsi@54400000 {
+			compatible = "nvidia,tegra124-dsi";
+			reg = <0x54400000 0x00040000>;
+			clocks = <&tegra_car TEGRA124_CLK_DSIB>,
+				 <&tegra_car TEGRA124_CLK_DSIBLP>,
+				 <&tegra_car TEGRA124_CLK_PLL_D_OUT0>;
+			clock-names = "dsi", "lp", "parent";
+			resets = <&tegra_car 82>;
+			reset-names = "dsi";
+			nvidia,mipi-calibrate = <&mipi 0x180>; /* DSIC & DSID pads */
+			status = "disabled";
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		sor@54540000 {
 			compatible = "nvidia,tegra124-sor";
 			reg = <0x54540000 0x00040000>;
@@ -737,6 +769,13 @@
 		#thermal-sensor-cells = <1>;
 	};
 
+	mipi: mipi@700e3000 {
+		compatible = "nvidia,tegra124-mipi";
+		reg = <0x700e3000 0x100>;
+		clocks = <&tegra_car TEGRA124_CLK_MIPI_CAL>;
+		#nvidia,mipi-calibrate-cells = <1>;
+	};
+
 	dfll: clock@70110000 {
 		compatible = "nvidia,tegra124-dfll";
 		reg = <0x70110000 0x100>, /* DFLL control */
-- 
2.43.0

