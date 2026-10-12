Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D367DCA9ED0
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 02:01:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9023880CEB;
	Mon, 12 Oct 2026 02:01:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bVy-zIBwC3kH; Mon, 12 Oct 2026 02:01:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3FEBC80CEC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791770507;
	b=ga513IS5ua1ZtX9+Tumqysth5KU2nQXRciDpFotrjRvyceneiwREIZ3X0akZErJIqATl
	 k6XRI0wGKJtqY4MP43x250sB5z6h9MtEdE3YpJm7FcHKkAHw87ZeyMo4UampUGghXDscD
	 8/cXwWMWQgfysf/ls080bg/JsHTR5Z3wWCw+Qt5xAQSje2n0GEA4s6n85rXaFJ5g2KvZE
	 aozcq4xV4WbkkxlHIcinhO2Bmedx2Y0tcqM3WHn123RehDVz/qsyNU89ZO7DCtGPXj/9D
	 g4nohzS716/9VextDUCgh9UcZ9TtVVhoblJCT12jXn7+JHLo96fzamSYrTqW938lFfQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791770507;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:X-Relaying-Domain:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=2PGBszCttwoIYArmBc/gFBX/rzGMzZH1VAHtiYJaEDc=;
	b=i0uYsWvT32qP8PMwTXlXCNGjUR/Gp4oo4Fmjn7vlPNevF5bqrdUxD4Eewml+UvwMOmvD
	 frxkICmV1auzMWMtTrXSvQyGN1bGcHKYzbJyhk1cQYJeRa/hMWG3qZ9Rghw+R8+vCzpBU
	 AAl7oFHczfEOOz2xctFEbIpfYax/CROn2V703pX31SdATKbPuE8Cs9RJneTDONoR2T4UR
	 U3K5HDO0eUAv6so5eQAkwRp9/cZ4Y/xZQB9GDAvwMxJZu2NIqnGRuwraOdTuTAZiue7Ra
	 PHztMUrWi6XTo9q4CDt/uS5LbP2R8q+qP+fkJzKcCjZl1Rod1V+H9NTlRQjyHYIHztw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791770507;
	bh=2PGBszCttwoIYArmBc/gFBX/rzGMzZH1VAHtiYJaEDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OyObedVzB6CQBnT7XAS2JHairfTjPf7p+8pNsj/xYX4/2V74jRZ+0bJQqTgRE6NfX
	 L9G+aDiDPGOlyLMm/t/Vb3ZPWRJgXX+ys/7oZako9zdMeP3yYjIuuc+Frwdv6ela+n
	 AbFAlmof/YhlZ+SRXY+wiHKDhpZG6BA9NOvMCyL5l8K+iU6Zro80IyEPFC1xwv28k5
	 5eMjEWFKdSV2yeeQkpYEYDtQvvZPvacANP5KIF8+sbo56c7PYmasfBbdE31dHruYK+
	 rgNwajmF0f4oVp/WHela7j9u0s661TRp/wAp2tAKu7pYJC9yFrBz0BFOz4gVGq32nG
	 Tmo3s3kZDiJjQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3FEBC80CEC;
	Mon, 12 Oct 2026 02:01:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E1F20111
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 02:01:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D4455606EF
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 02:01:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qg1r5JsdR_dQ for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 02:01:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org ACBD4606D7
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::663"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791770503;
 b=Zqf9EXQHOqOAccJeX/8eu0VRvcIwpf7qz9hYUfxQ94VEw9X6dq988pVW6yN6XnwlDBb/
 cnVAKxhXD5axbEmz5Um9NNvTBwdYNbFqvht21q9jOTL+QeU/onPYmCI8Wc0VAhuc2jej9
 TNwuk5tadvatBo9aBPZZRHAPFVgg3BDjZwWdalFV+CC49CyhHui5CZomFwkZxO2tE+aVP
 Vgbh94dywx6iOH2aidvaQwoTekSZ9lUDp9W42EU9VfQnv8gyeh+CHlqSn/Glyf4svZAui
 lTh3HFe6Q6auljn/rnIaYJd6lLEUr24jcaUrUAoQDdJ2xuCjP4PiAp5t9wG69khpCmA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791770503;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:From:
 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=2PGBszCttwoIYArmBc/gFBX/rzGMzZH1VAHtiYJaEDc=;
 b=f6PgvMO0p0HchQPczfpxBBLWpeOZZ/kAtLK/R4tdbOYdFeP+8wEafmWTMFdSg8DmY+I3
 Z8of4WgO/9ev+EIUioHbHtuvzaMwIAk9kEYKAOfQeDb/YRtE+pfJocByZ8fGKhHgK7A+0
 Ot+EyEbUmoYjUA2PZQxyHR61sPnsa94se4r3k/R01YdWnBGecqdU5nrCDneNnTfzAsmE9
 NozyXcMMUNyZZ9BoSLox1mLVw9qcBHaZkA8Qsx1GxI+ypHZiZEHSOBlmWqB2fBdI/+d7g
 voVgjWCaAHXvg5Gl5/5d22u+fQT9wylTEPZCuEsB7JODAOffxzh5EhiCUfd2qFvLaLQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=ausil.us;
 dkim=pass header.d=ausil.us header.i=@ausil.us header.a=rsa-sha256
 header.s=google header.b=V8cwoPKb; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::663"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::663; helo=mail-pl1-x663.google.com;
 envelope-from=dennis@ausil.us; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=ausil.us
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=ausil.us header.i=@ausil.us
 header.a=rsa-sha256 header.s=google header.b=V8cwoPKb
Received: from mail-pl1-x663.google.com (mail-pl1-x663.google.com
 [IPv6:2607:f8b0:4864:20::663])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ACBD4606D7
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 02:01:43 +0000 (UTC)
Received: by mail-pl1-x663.google.com with SMTP id
 d9443c01a7336-2db80fcdf8bso7447345ad.2
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 19:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ausil.us; s=google; t=1791770503; x=1792375303; darn=lists.u-boot-project.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2PGBszCttwoIYArmBc/gFBX/rzGMzZH1VAHtiYJaEDc=;
 b=V8cwoPKbEJf/c/cf+0eSQxnY0dy38WFfb4ucdWz6DHO34f0Bx2p6nGSH9EAgl3V3PU
 DwQXkNEcJIl3nqNHGcQBHqudRMsTEJ9yvEhTswLE2QOKje/Rrluk+KGPw4xzzGCO9cJw
 KIZrzJYeyj5ng2OraGrpdbDl1AVKM50OPTSGUlToAdYU9J6dbVaund+6dlPmmv8Fi9f+
 qEjMY8KfTw4t2pbK2l0chuUiAcSmoTgjxUi08ZlZPHerwb27g1VALFceBQyd25Mur3ot
 oW63hgbCjdqUHaS/I+aUt2hM8yjiR+e8lgv4h1VZpaf2uBU/HwFmxa6Cue78j5ewQA0l
 941A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791770503; x=1792375303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2PGBszCttwoIYArmBc/gFBX/rzGMzZH1VAHtiYJaEDc=;
 b=ARWI5kRvfOcaG5NTpTxEaBnjguiTwcMFs/WSnWifGWZyZCKato4Xe3BfoI/agFnAfK
 zSzqeKtG46l8CHRVMAS2PasXGngcQKGQs30Scfw9K8n5KxDbb17J7p0V0KlQnsJTHMwd
 d18BdaDZoqq0U5xfA5KoznqJiaJt0ZQco6ZANac884ISuNeY864JdUQR5hMMUKqwK8wP
 DlG+sYFrleNsW68qTx1UHrNM0h+1G7r6gkpoEtz1UjQYuMSZ+eqZEW+NF1faKUqUiPN3
 RzEJZWJdK72Oi5JZpLbfbzsFiYlX/F01SBGjlH4fI12bGnlSW4EULrThpDgkfD/fW6G9
 iHTw==
X-Gm-Message-State: AFq9FYL/dYVVydiGzuc2guf/LwdyetX0DyZVtML04Dwy0qjs0C38UlQz
 wIjncejEN0k/p3xCvwU7VuGhF+Scw5Dt+sVV9ipt0s9hLc1nPBgLJYpuME/k28mBhThTy8Hm+/c
 1imYI8LGcgahULuN1NG1pTxQH2hRvQ82EoZ46s3CG0nd/
X-Gm-Gg: AYBFou1SHrff8WrKpuYu6TkNDKe2/GbwWlLD5n316yXudTtxvPoW7RbqFgPbjJxo5DI
 NFfAsFKxDvJWgpB2gSOdVr7yy3Qm5OJj1Kr2Om8Zn9kVWoxyLoruQcQnd78hlMF46SJTDLuNwm8
 1LisspM+NcTk3CFIn1DKfUg8TzSkvM7KtitweU7lRS0t29xntD9xVglED04LyJjz4wIciqWc1sU
 /vXdMmjsK/A6zgeMHJDkE69KWwLX0KxK2MiZ7yt78q/SYMDbZahCkUXMkDfCE1105LVLNUhiYR/
 87NiYsp1OJ1hB91+zrrVxo64iFSajgBoms/R3l6ga5wKTzI+yvUlkzDB1GSbSMFomG3pMEdUi09
 dugEMA0g7iV3+NRkvxLqUnVwd
X-Received: by 2002:a17:903:1c7:b0:2e2:c491:ec80 with SMTP id
 d9443c01a7336-2e8428a1d67mr56902505ad.22.1791770502892; 
 Sun, 11 Oct 2026 19:01:42 -0700 (PDT)
Received: from tomin.ausil.us (207-179-239-100.mtco.net. [207.179.239.100])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-2e84131a272sm3254325ad.0.2026.10.11.19.01.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 19:01:42 -0700 (PDT)
X-Relaying-Domain: ausil.us
From: Dennis Gilmore <dennis@ausil.us>
To: u-boot@lists.u-boot-project.org
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>,
 Jonas Karlman <jonas@kwiboo.se>, Alexey Charkov <alchark@gmail.com>,
 Dennis Gilmore <dennis@ausil.us>, Peter Robinson <pbrobinson@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 4/5] arm64: dts: rockchip: Add Orange Pi 5 Pro board support
Date: Sun, 11 Oct 2026 21:01:33 -0500
Message-ID: <20261012020134.621305-5-dennis@ausil.us>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261012020134.621305-1-dennis@ausil.us>
References: <20261012020134.621305-1-dennis@ausil.us>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Add device tree for the Xunlong Orange Pi 5 Pro (RK3588S).

- eMMC module, you can optionally solder a SPI NOR in place and turn
 off the eMMC
- PCIe-attached NIC (pcie2x1l2)
- PCIe NVMe slot (pcie2x1l1)
- AP6256 WiFi (BCM43456) via SDIO with mmc-pwrseq
- BCM4345C5 Bluetooth
- es8388 audio
- USB 2.0 and USB 3.0
- HDMI output is enabled
- the second HDMI port connected to the DP bridge is left out for a
  followup set

Vendors schematics are available at:
https://drive.google.com/file/d/1qs1DratHuh7C6J6MEtQIwUsiSrg8qgTi/view

Signed-off-by: Dennis Gilmore <dennis@ausil.us>
Reviewed-by: Alexey Charkov <alchark@gmail.com>
Link: https://patch.msgid.link/20260511025352.106126-5-dennis@ausil.us
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: f47af8ebbe5381e761a8019f29f3016ea9faee5b ]

(cherry picked from commit e533117c341594763d507ad8182d127845e038fa)
Signed-off-by: Dennis Gilmore <dennis@ausil.us>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---

Changes in v2:
- Add Reviewed-by from Quentin

 .../arm64/rockchip/rk3588s-orangepi-5-pro.dts | 358 ++++++++++++++++++
 1 file changed, 358 insertions(+)
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3588s-orangepi-5-pro.dts

diff --git a/dts/upstream/src/arm64/rockchip/rk3588s-orangepi-5-pro.dts b/dts/upstream/src/arm64/rockchip/rk3588s-orangepi-5-pro.dts
new file mode 100644
index 00000000000..c9679bac1db
--- /dev/null
+++ b/dts/upstream/src/arm64/rockchip/rk3588s-orangepi-5-pro.dts
@@ -0,0 +1,358 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+/dts-v1/;
+
+#include "rk3588s-orangepi-5.dtsi"
+
+/ {
+	model = "Xunlong Orange Pi 5 Pro";
+	compatible = "xunlong,orangepi-5-pro", "rockchip,rk3588s";
+
+	aliases {
+		mmc0 = &sdhci;
+		mmc1 = &sdmmc;
+		mmc2 = &sdio;
+	};
+
+	analog-sound {
+		compatible = "simple-audio-card";
+		pinctrl-names = "default";
+		pinctrl-0 = <&hp_detect>;
+		simple-audio-card,format = "i2s";
+		simple-audio-card,hp-det-gpios = <&gpio1 RK_PD5 GPIO_ACTIVE_HIGH>;
+		simple-audio-card,mclk-fs = <256>;
+		simple-audio-card,name = "rockchip,es8388";
+		simple-audio-card,routing =
+			"Headphones", "LOUT1",
+			"Headphones", "ROUT1",
+			"LINPUT1", "Microphone Jack",
+			"RINPUT1", "Microphone Jack",
+			"LINPUT2", "Onboard Microphone",
+			"RINPUT2", "Onboard Microphone";
+		simple-audio-card,widgets =
+			"Microphone", "Microphone Jack",
+			"Microphone", "Onboard Microphone",
+			"Headphone", "Headphones";
+
+		simple-audio-card,cpu {
+			sound-dai = <&i2s2_2ch>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&es8388>;
+			system-clock-frequency = <12288000>;
+		};
+	};
+
+	pwm-leds {
+		compatible = "pwm-leds";
+
+		led-0 {
+			color = <LED_COLOR_ID_BLUE>;
+			function = LED_FUNCTION_STATUS;
+			linux,default-trigger = "heartbeat";
+			max-brightness = <255>;
+			pwms = <&pwm15 0 1000000 0>;
+		};
+
+		led-1 {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_ACTIVITY;
+			linux,default-trigger = "heartbeat";
+			max-brightness = <255>;
+			pwms = <&pwm3 0 1000000 0>;
+		};
+	};
+
+	fan: pwm-fan {
+		compatible = "pwm-fan";
+		#cooling-cells = <2>;
+		cooling-levels = <0 50 100 150 200 255>;
+		fan-supply = <&vcc5v0_sys>;
+		pwms = <&pwm2 0 20000000 0>;
+	};
+
+	vcc3v3_eth: regulator-vcc3v3-eth {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpios = <&gpio3 RK_PB7 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&ethernet_en>;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "vcc3v3_eth";
+		startup-delay-us = <50000>;
+		vin-supply = <&vcc_3v3_s3>;
+	};
+
+	vcc5v0_otg: regulator-vcc5v0-otg {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpios = <&gpio0 RK_PC4 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vcc5v0_otg_en>;
+		regulator-max-microvolt = <5000000>;
+		regulator-min-microvolt = <5000000>;
+		regulator-name = "vcc5v0_otg";
+		vin-supply = <&vcc5v0_sys>;
+	};
+
+	sdio_pwrseq: sdio-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		clocks = <&hym8563>;
+		clock-names = "ext_clock";
+		pinctrl-names = "default";
+		pinctrl-0 = <&wifi_enable_h>;
+		post-power-on-delay-ms = <200>;
+		reset-gpios = <&gpio0 RK_PD0 GPIO_ACTIVE_LOW>;
+	};
+
+	typea_con: usb-a-connector {
+		compatible = "usb-a-connector";
+		data-role = "host";
+		label = "USB3 Type-A";
+		power-role = "source";
+		vbus-supply = <&vcc5v0_otg>;
+	};
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1m4_xfer>;
+	status = "okay";
+};
+
+&i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c3m0_xfer>;
+	status = "okay";
+
+	es8388: audio-codec@11 {
+		compatible = "everest,es8388", "everest,es8328";
+		reg = <0x11>;
+		#sound-dai-cells = <0>;
+		AVDD-supply = <&vcca_3v3_s0>;
+		DVDD-supply = <&vcca_1v8_s0>;
+		HPVDD-supply = <&vcca_3v3_s0>;
+		PVDD-supply = <&vcca_1v8_s0>;
+		assigned-clock-rates = <12288000>;
+		assigned-clocks = <&cru I2S2_2CH_MCLKOUT>;
+		clocks = <&cru I2S2_2CH_MCLKOUT>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2s2m1_mclk>;
+	};
+};
+
+&i2c4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c4m3_xfer>;
+	status = "okay";
+};
+
+&i2s2_2ch {
+	pinctrl-0 = <&i2s2m1_lrck &i2s2m1_sclk
+		     &i2s2m1_sdi &i2s2m1_sdo>;
+	status = "okay";
+};
+
+&package_thermal {
+	polling-delay = <1000>;
+
+	cooling-maps {
+		map0 {
+			trip = <&package_fan0>;
+			cooling-device = <&fan THERMAL_NO_LIMIT 1>;
+		};
+
+		map1 {
+			trip = <&package_fan1>;
+			cooling-device = <&fan 2 THERMAL_NO_LIMIT>;
+		};
+	};
+
+	trips {
+		package_fan0: package-fan0 {
+			hysteresis = <2000>;
+			temperature = <55000>;
+			type = "active";
+		};
+
+		package_fan1: package-fan1 {
+			hysteresis = <2000>;
+			temperature = <65000>;
+			type = "active";
+		};
+	};
+};
+
+/* NVMe */
+&pcie2x1l1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie30x1m1_1_perstn>, <&pcie30x1m1_1_clkreqn>,
+		    <&pcie30x1m1_1_waken>;
+	reset-gpios = <&gpio4 RK_PA2 GPIO_ACTIVE_HIGH>;
+	supports-clkreq;
+	vpcie3v3-supply = <&vcc_3v3_s3>;
+	status = "okay";
+};
+
+/* NIC */
+&pcie2x1l2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie20x1m0_perstn>, <&pcie20x1m0_clkreqn>,
+		    <&pcie20x1m0_waken>;
+	reset-gpios = <&gpio3 RK_PD1 GPIO_ACTIVE_HIGH>;
+	vpcie3v3-supply = <&vcc3v3_eth>;
+	status = "okay";
+};
+
+&pinctrl {
+	bluetooth {
+		bt_wake_gpio: bt-wake-pin {
+			rockchip,pins = <0 RK_PC6 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+
+		bt_wake_host_irq: bt-wake-host-irq {
+			rockchip,pins = <0 RK_PC5 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+	};
+
+	ethernet {
+		ethernet_en: ethernet-en {
+			rockchip,pins = <3 RK_PB7 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+	};
+
+	usb {
+		vcc5v0_otg_en: vcc5v0-otg-en {
+			rockchip,pins = <0 RK_PC4 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+	};
+
+	wlan {
+		wifi_enable_h: wifi-enable-h {
+			rockchip,pins = <0 RK_PD0 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+
+		wifi_host_wake_irq: wifi-host-wake-irq {
+			rockchip,pins = <0 RK_PA0 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+	};
+};
+
+&pwm15 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm15m2_pins>;
+	status = "okay";
+};
+
+&pwm2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm2m1_pins>;
+	status = "okay";
+};
+
+&pwm3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm3m2_pins>;
+	status = "okay";
+};
+
+&rk806 {
+	regulators {
+		vcca_1v8_s0: pldo-reg1 {
+			regulator-name = "vcca_1v8_s0";
+			regulator-always-on;
+			regulator-boot-on;
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+
+			regulator-state-mem {
+				regulator-off-in-suspend;
+				regulator-suspend-microvolt = <1800000>;
+			};
+		};
+
+		vcc_1v8_s0: pldo-reg2 {
+			regulator-name = "vcc_1v8_s0";
+			regulator-always-on;
+			regulator-boot-on;
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+
+			regulator-state-mem {
+				regulator-off-in-suspend;
+			};
+		};
+	};
+};
+
+&sdhci {
+	status = "okay";
+};
+
+&sdio {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	bus-width = <4>;
+	cap-sd-highspeed;
+	cap-sdio-irq;
+	keep-power-in-suspend;
+	max-frequency = <150000000>;
+	mmc-pwrseq = <&sdio_pwrseq>;
+	no-mmc;
+	no-sd;
+	non-removable;
+	sd-uhs-sdr104;
+	status = "okay";
+
+	ap6256: wifi@1 {
+		compatible = "brcm,bcm43456-fmac", "brcm,bcm4329-fmac";
+		reg = <1>;
+		interrupt-names = "host-wake";
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PA0 IRQ_TYPE_LEVEL_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&wifi_host_wake_irq>;
+	};
+};
+
+&uart9 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart9m2_xfer &uart9m2_ctsn &uart9m2_rtsn>;
+	uart-has-rtscts;
+	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm4345c5";
+		clocks = <&hym8563>;
+		clock-names = "lpo";
+		device-wakeup-gpios = <&gpio0 RK_PC6 GPIO_ACTIVE_HIGH>;
+		interrupt-names = "host-wakeup";
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PC5 IRQ_TYPE_LEVEL_HIGH>;
+		max-speed = <1500000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&bt_wake_host_irq &bt_wake_gpio>;
+		shutdown-gpios = <&gpio0 RK_PD5 GPIO_ACTIVE_HIGH>;
+		vbat-supply = <&vcc_3v3_s3>;
+		vddio-supply = <&vcc_1v8_s3>;
+	};
+};
+
+&u2phy0_otg {
+	phy-supply = <&vcc5v0_otg>;
+};
+
+&usb_host0_xhci {
+	dr_mode = "host";
+};
+
+&usbdp_phy0 {
+	/*
+	 * The USB3 Type-A host connector is wired to PHY lanes 2/3. Lanes 0/1
+	 * are connected to the LT8711UXD DP-to-HDMI bridge on the board.
+	 * dp-lane-mux routes USB3 SuperSpeed to the correct lanes.
+	 */
+	rockchip,dp-lane-mux = <0 1>;
+};
-- 
2.56.0

