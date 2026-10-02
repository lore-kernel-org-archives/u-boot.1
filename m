Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0BF0CA5FCE
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 03:14:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4EF9840CFD;
	Fri,  2 Oct 2026 03:14:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ihggobOgpNi9; Fri,  2 Oct 2026 03:14:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C175D40CE0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790910841;
	b=heW8IGooQShDPunb4LShf3gzW3A4cxR+CHMLTMUtvfqVJiBOAYy4iPItW91zt2jJalQt
	 fHeDUBR87UtB2hLhJSH0KBcH0N9dGL9oOv+jzeKNCaCmwHNA7/V69IU5RqFqEBLGYLg8d
	 tRgQiK+zoiDq8C06kBr8Lh+f7L47zJg5ZA0Snscdy1KLZDvLTsXWTGFjah2ImBBt//FA6
	 LsKxGwRa9DDZxBQpaJLb5iyxP2vTiMxqykarX4L28jXncvPaqWlenXigs2ls3B5uHCvWv
	 s21eGArkhvioouRv3fRi3V/YxIX2biAZVfQJIEpFJicZTXVoR47e8AEbJM95ftWodzA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790910841;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:X-Relaying-Domain:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=y3y0mj0fRgOPJPY3eOB2j43NxlU+5t0jZsgC6eFar5U=;
	b=KqCMw2JGdCjFXmpySV88lzGE9FdKn8Fo1oiZBHLh3u8Pu6aIt4HSJi1kFFyQTtk7LOhk
	 JIA8OOhdmdl4T0mYrulM/T9clD9G7whACpZl94HmpRJqP3EAxvsEpDhbyowAEU1d3PhJb
	 +3IBaJ8QarCxPb+0JJuwiCzF81khDfYpfksnPTvnIIjkPMwMt8LwiQN3vomDIeANFNQKF
	 bsBZ9G1aDbw6pXL5pU9M8uBN1uQBlmvTz3asikKuACBKOPLkXh/YP8qjhMISLieEBNc4O
	 KBGpx/3JC3hBVk+77zFNH+tRLNV3f2Gf2edmgwg7+lZ9lbnYoD4Ds6M0pDosAl76jUA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790910841;
	bh=y3y0mj0fRgOPJPY3eOB2j43NxlU+5t0jZsgC6eFar5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xT1NZQoL1iycmn9qQga5HPd3HJI2NUNAt5ep8PKRddPTdPDfW8fkH8D5fVsas5GRN
	 Kunrxm+Fr8NesMn6IJatIWYluOJsjqF29QJJFgu8fXLNS4s146diCijiKzx8egHKOa
	 IxmPizEExmsotMRvj3NjJeTzT9JQKwsXjHJMtIPdJxFAd/n7jjq2HViMLkZC8WgFJi
	 o5Zp1Aj47dN3JTCnFWYMj1v/97/bgNcRuFO16BvkVnIZ54H+8DCDcptQO+MkBdiaNU
	 wfEoGYnNQGodUeW8pYAqhBX3geMWiEsqcEiFT3tVlpRcCEdXqYXWvTyYHDieKI/e8g
	 Lt7LTQsJOWr3Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C175D40CE0;
	Fri,  2 Oct 2026 03:14:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D5DB41A6
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 03:13:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BC2AD607CE
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 03:13:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gZUK-BhdoQxU for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 03:13:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B780D6070F
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1061"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790910830;
 b=Pp7EMeB4Y0SD3TwRxKqLhMQ/CM61naXhaAFtFQv7q8gsygMCdgjz7C3CXcQfHzf2wCid
 0kX7C+eddo6Jv+0XWkKc20wLelH7CI3C7B/LwFCmsble4sp65+nV4XoaNjwTyUW9gmqk7
 XsNONVhwl8dKOUsDcD2Fk0Xn5sFSWbk2/wdJuFw1CBZMzw6NTqLCt5OR4WA0czkA68s5x
 BQh0zyxcn/Y21cKCAvoa2sZpGuzesMAHUvMLI09wSyRMEacT6Je1P36ypgxSv6olrABff
 sqU8DcMxL0K308NukwCOxj4JaeMPT60FElQmTM3MvLP6xX66if7LN6vnlFOeVJ3crKw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790910830;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:From:
 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=y3y0mj0fRgOPJPY3eOB2j43NxlU+5t0jZsgC6eFar5U=;
 b=s7Gc5sF/VKChmDBGE70O+KQIJxIKmqRXnnwhqc4UI+s4bkZwiS4IK3cFAb0qpeYwZmW0
 treCBjSVL0TgMduXJWhR0wQuRXEJ5y2EnOT4shAj37KbZ6hY+0BZOH3YZOYvZognyWevm
 SuAFOUAzVYKlRGLNIwpmI3ioxXm8XdtXyas9HoEvcY2RTWmNFQSWL+EKjCwaioQf1tCvN
 WRXWUDL+Fpzlev3sB94Hi4Gv7/ACFKtNtFw8lQJ6hd5iyntfdjzijuDLGZDvDq5JHmGIu
 IfLtz3rJ08qqS2FdWxYFt1Jdva4hyFcfkKzIafxwbrFYPXMhq5DAGtbNppdxkwWZgjQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=ausil.us; 
 dkim=pass header.d=ausil.us header.i=@ausil.us header.a=rsa-sha256
 header.s=google header.b="MBtl/ZkJ"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1061"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1061; helo=mail-pj1-x1061.google.com;
 envelope-from=dennis@ausil.us; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=ausil.us
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=ausil.us header.i=@ausil.us
 header.a=rsa-sha256 header.s=google header.b=MBtl/ZkJ
Received: from mail-pj1-x1061.google.com (mail-pj1-x1061.google.com
 [IPv6:2607:f8b0:4864:20::1061])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B780D6070F
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 03:13:50 +0000 (UTC)
Received: by mail-pj1-x1061.google.com with SMTP id
 98e67ed59e1d1-3a4b9732d5aso858729a91.3
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 20:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ausil.us; s=google; t=1790910830; x=1791515630; darn=lists.u-boot-project.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y3y0mj0fRgOPJPY3eOB2j43NxlU+5t0jZsgC6eFar5U=;
 b=MBtl/ZkJzi5RMTLRCENXj+e4B5+o9GoBhxAVTsLSSkTJiv3v1+PP21d38SdRvB4+BS
 N539DeuWvkjsJov0LM/VOa1da5VK8XqUJXICIjBfy3kISwohxmKOcZW/WVv86x0IWHyY
 12f3NM5MmoT21YxaAIKMmWPgTVzW++clKXLnWpmMVy0zWr5ONiafUT6FjKFBkIfzwNNG
 Svacn8otMqDbkLjB/5WSEnP+qZQdxhrpgnNBSHgwIDvvXoQnzJ8eORvgvsucmXa3JV5v
 DueGEbcR0KLZNpTUcs/XFe6kMBqHKBPPj2rFA6indABE6x6cUHM1FFJOfQ03TZ39gosS
 /cXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790910830; x=1791515630;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=y3y0mj0fRgOPJPY3eOB2j43NxlU+5t0jZsgC6eFar5U=;
 b=anP3MN9dMFO53YcjjVIaaT6nZoY4jJi15D0irIetzQp7vhyASZ/NkkKXvrPG/1Ynrc
 lEwV8dVuqcZUSGcpOkkfGg/zkKNqLFpFKXBVeTP/fWFpdbZ55+6ejYzFZERgwX3rZE5R
 JHKfh3LABscZO9czEYlTpIJAixwzKXfj905YVyjewyFFxe7eNJs/YYXd62hYGBxZCNFP
 RCCVWFtOB0C0WKyB6i4RMZb3JaMu2cAxLPexEyd2mYUFWpv0UQx29BFvi9JFwLFw5joB
 RgP7w/HjX5N8RjEDYjmkjph/iVXwnp5EWVtS0BPP4yHpeyf6Zt+Xrw1K6Ao8M7+ZujMg
 ctxA==
X-Gm-Message-State: AFq9FYIB0OkWanVoUUeL1oevKSD/V2jWcMs/IfRVd5ZHOCNMZ2Ojfsk6
 8oXkiAxZtqNm1lvObsa0e1cRTKYNYIJw2R/UwHY4PHax4/ZGugWpj03Ia3Ik3pZKilQlFZ3moHk
 uMlNNnaRO89qWuNunf/aOMIjDhKusDBm4eUAb2+EHyoOs
X-Gm-Gg: AYBFou1mla/b1A2Pcavcn4L0CsUrYCp1VD54RpnksEB1HOh7z2MMMLUkMROsvfTUB3r
 fyavJdC2BisjOc3C5YdVDyYShCimlziFruvXwv6Q/fTROjLEXnYJFpbcXZZaKlZCdc9LLp/vYWD
 21NwD3GC/m9Wsuods9WpxjoSSfCowjpOzX6ov7FEL2ZSku6Q5f0a7idzfnSeLo1nbX4PVDCxq8D
 SBVyZ4PHsQrPMaPo+kXjpKKop7uzCi5TMqjYkfSViOqq32fv43CghwpaVkGFdhX2zsEKcFwYABk
 /kXwrDBV9NjP6TDYRdtjTbXCWj/taNveyP8myqcFR1iWV0x9/yZZydFmvCsxeLQazRTWAI7VfC0
 SwjF6jgBD8U9CcXAZABq+xzU=
X-Received: by 2002:a17:90b:1c86:b0:3a4:d5c0:f826 with SMTP id
 98e67ed59e1d1-3a6ce9b0fe4mr1358988a91.65.1790910829884; 
 Thu, 01 Oct 2026 20:13:49 -0700 (PDT)
Received: from ryac.ausil.us (207-179-239-100.mtco.net. [207.179.239.100])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3a6cd60531fsm834715a91.6.2026.10.01.20.13.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 20:13:49 -0700 (PDT)
X-Relaying-Domain: ausil.us
From: Dennis Gilmore <dennis@ausil.us>
To: u-boot@lists.u-boot-project.org
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>,
 Jonas Karlman <jonas@kwiboo.se>, Alexey Charkov <alchark@gmail.com>,
 Dennis Gilmore <dennis@ausil.us>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/5] arm64: dts: rockchip: Add Orange Pi 5 Pro board support
Date: Thu,  1 Oct 2026 22:13:33 -0500
Message-ID: <20261002031334.3285687-5-dennis@ausil.us>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002031334.3285687-1-dennis@ausil.us>
References: <20261002031334.3285687-1-dennis@ausil.us>
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
---
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
2.55.0

