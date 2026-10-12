Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82AD5CA9ECF
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 02:01:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 561D1606D7;
	Mon, 12 Oct 2026 02:01:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NWTDV8kARq3Z; Mon, 12 Oct 2026 02:01:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AE95C606EF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791770505;
	b=WwwenKqsJEHfEj+CEIhPbVXi+/k21h4ZMvpjCwvlINR/qPH/ivicT4YB0YmeLQDtW0eC
	 j5ou5B1t97BsguiSNIUDOMGdzY3l0DtX6GSUyYOKOMSkThkxzX8MABPg6KUjZQeF4Fzjm
	 JmeUR+7yUd8ZR5tPQaDOk6nrO6NTcnw2kZlIDuvqfIusbC+fa1KpDGVO+Wc+O2o+darVU
	 1/gVnu4Y7kCKrBrnwyD9SRAlamFY3XTWDeok5PnbHuqJ72KomAe7uRabK4DQ/vrWSoK0C
	 aq7KWyxCrvRAMDZRNCK9G46ptwiuQL7aEKKONEi+/oth2c56g7s2REq9DIHsAPeHghQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791770505;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:X-Relaying-Domain:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=n5Cev5gLokOUmOi/CHs+OXHXaVCLK+tfTdofmgbDx08=;
	b=SWzM9NSuVhaNe5NczsxpoR8tdzy1fWqMvt6h3bP0JyASMNQ2mUJUrv+CkmF6MghE1XH+
	 ZeLkDfYBm6r8X0OPAoZZ8wta7ayO/mow1AprvrqfvyToEGZVwNTDEKjgX8JbYgWw56YHI
	 eXBRUWrSnvwxnDK7+aKPrjxYfMjbD0xHCi4+Qq+WkEZRWCPO6L85qL3yeYs8aDafLXK2Z
	 l/r4atNSJmFU9B6j0lqm6dBdATGT7p7c1UcGarSPqVTBCVYed/hCp/f0sjhQK4+1rRjJg
	 HgO6gxUqEXGK6CSal1Z9eDjxKtXRi65M4RNlTB3oUbJ5piQ6G08iOhswsV+g7sizGmg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791770505;
	bh=n5Cev5gLokOUmOi/CHs+OXHXaVCLK+tfTdofmgbDx08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pbGGWzLt9zpFYtDwLOM+gVD3vR9+/v2lXY19sqEAQU0gUgs6/o4K7GUarLDDa0oUh
	 lCZMxMCUcfnQ7xNbdAHTOebXfjATi/JNx56WyvOgf45dxBFrOjAkFffheaUPnrRZPZ
	 TLnAgi06Mp6EREca6/oBTyoC40fLEWUMe0S1NpWscn13EqIq5ZvRbGfyEb0O6dN1pd
	 XVXgVvmHjEqsLSXoMxQbEkyeJdyJ0N+kNHIYJfDad8+KQTpaUyUozh50y8diI0e5Sm
	 FmQyyRUp2GR3cmWuzwjbrzFEYYgSx7ePPRawJ42z1xN1vMDdO9Iv0yGuVBrME4P68i
	 uLRYwktX0LEzQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AE95C606EF;
	Mon, 12 Oct 2026 02:01:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4C8A81DE
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 02:01:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 280B280CD8
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 02:01:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NQgqYTJZ59eJ for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 02:01:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5E0BC80CBC
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::663"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791770502;
 b=NMeGRs3WhO6JPPejxzaV/DFK/YkuMchU+qoeX986VTivrYJx6SUmyhxmYp2BsbF8TStI
 xU5FfEsuHH6/Xr/QgUljKF7R+rWfGwFeHCWkt/rdiuSHsZlxVP6IJFM5o9du/AIsx5j4y
 vRex8z93hW9CH5pivp8IYgvNfHGTR/LlCv+cS2qeud2tno1i208w4uHI9aHVWDloHzwXv
 wSRMJbv6cH4Ai+SMPR4trhBLK3auYxSOEJKXpTqnSNLxE8d+ckT5kzOa2OcdgPijjnN0Q
 P2vs7heu4r8JHMqu/b+hBuNsypQ2/k1EfqdvuFFZYKMoisdZ2GzZzVI45YUyvMftawA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791770502;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:From:
 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=n5Cev5gLokOUmOi/CHs+OXHXaVCLK+tfTdofmgbDx08=;
 b=HiR65Iysr+j2shcjCTCWWbeiFBYrTUnzqlgwQhfdQfVAn6FEdlv6V/u6MC9lBXJ83r3F
 345Ps5q93ehUdsfXZBaFoy1+V2E3ROqCO8EYosOrEcTPPj0KD1BZIYpv0gY8k44SvmtT4
 hEytlLH/Jm8berV9l/WQxkg0zUNEiOhxstsH/azdxuQ28vhQmQNg7nhcciVGrWZIIbg+e
 SnywT6NAxT3g7N9vD4oeWBG1IEni9BJZysW6qRuM6FIn64FdFb/xSLfrfC8yi/N/4/mQU
 APTOlxLlrEKFTvrxkLrrgeTkzby8RKS77oqPc/meZS0uJ2FFbcjKVwpSOmXyFtsm/4w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=ausil.us;
 dkim=pass header.d=ausil.us header.i=@ausil.us header.a=rsa-sha256
 header.s=google header.b=MZAjM7tC; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::663"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::663; helo=mail-pl1-x663.google.com;
 envelope-from=dennis@ausil.us; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=ausil.us
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ausil.us header.i=@ausil.us header.a=rsa-sha256
 header.s=google header.b=MZAjM7tC
Received: from mail-pl1-x663.google.com (mail-pl1-x663.google.com
 [IPv6:2607:f8b0:4864:20::663])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5E0BC80CBC
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 02:01:42 +0000 (UTC)
Received: by mail-pl1-x663.google.com with SMTP id
 d9443c01a7336-2e8ad5b31c7so5414585ad.3
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 19:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ausil.us; s=google; t=1791770501; x=1792375301; darn=lists.u-boot-project.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=n5Cev5gLokOUmOi/CHs+OXHXaVCLK+tfTdofmgbDx08=;
 b=MZAjM7tChIk3LGgr7r29R9NaVO/i11F53bMBT8vz/GaxDqlPdxbPfo6/WaQXBTA5Uz
 3L4J4cS4gH09UGWL5TjgFjXnMrMz6nQPI2WKF2d/BIYwoFrD10tsX1319kSIvGqNZ7Ry
 Vh8QA24aRkG39ft45Y3cmJdUohFkR9wDG7+EQ79St+fpavzHzdu6VN+o8V8ZhoesvkR9
 4cO2J+SBi8xZE4Fg9SOOmVpxFnyVE+VZxC1GdY6QwZujxK5H2wHMyPHBqNGKtxIjue0z
 S3hYor+4cJNWRKeoWL7UsGDNCUCuQSGEKeEB6ltNss6zPZf410zdfGfURgSObmywUmcv
 o/Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791770501; x=1792375301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=n5Cev5gLokOUmOi/CHs+OXHXaVCLK+tfTdofmgbDx08=;
 b=Vzgp/HfiVPYPbaxPYWp/99TySLmn/TsKp80H5uz7xT4ITxaKx1ao+FBDKe1AMN7vdp
 k88ecCKg6VaGaqvH2R+xwlrr/sIixaigLl+pnqHC5H+34aVAmZQ2Nf9HmP0Lq2/A9Vro
 5Whya+ChJ4CJkOck+KkEgiBm4VlMHkN/oMSddqOAxYXO2v9DF2aS5O2RevRVeh215Ulx
 64N5FpSDhYylI3Tvqr8qNrnkgc8AMnUrvf7PDxLwAtxflWyflprmzRTE3g/bUP1IWrso
 Jfy2OC5mhzXCatbrWVjvkFTCh5s8uzR2lCgQDx2aAvqpnJHFabX8glKwb0S9vZJ2OS60
 bcuw==
X-Gm-Message-State: AFq9FYK1jkx3rmooEUxEY15TokHMNKJzFZ13O4/dnh+bMUo/T5a95xGv
 KJDLqhj8YnmyvvueOHmLuodDEwEqHwd+5+CvEayvkWFKL/Qsaq8uzdaz2e0IWVjYrleRxDR7nWw
 H+ofTeMqf691zHSisbFWORCvy9YsobH5fXYrH7BCpNwoC
X-Gm-Gg: AYBFou3YjsuiyKplrO2hr6Xwore75QDZy+E1fHUtH2gXsHeijk1e16+mqw52D8nxjZh
 M+Wk3TCGp0oUNo1M2olJsVzmB75TYrPtPRTAdr4uPcxfmrA2ipUdBg7w0J062FE6wGT8Vcb99cd
 r3nTBTbz5iOvfAsVPlHlqXZKWgJHQKAYmdP0scZDhzG2zTg5KtLOmcjxiFmerLEGURMB+teseFq
 iGMGAbb/0v2k3Uzap0lZiI9yOxCVRw/+iypkbrBrZDmc0FfIrk7RbuAl4yJvW0I0Nf+nSE9JizQ
 cBZES6ODaQE6ROkovxBPaobQfYpndlwMfLuAfg5zKGPlT6Pcg1ya9+IdfHDSWJHk8Bz2aDnJGlw
 9TGx/q3zV4SlEGRiLZdDvB/hu
X-Received: by 2002:a17:903:3504:b0:2e5:3451:565 with SMTP id
 d9443c01a7336-2e842bbf489mr65314565ad.33.1791770501447; 
 Sun, 11 Oct 2026 19:01:41 -0700 (PDT)
Received: from tomin.ausil.us (207-179-239-100.mtco.net. [207.179.239.100])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-2e84131a272sm3254325ad.0.2026.10.11.19.01.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 19:01:41 -0700 (PDT)
X-Relaying-Domain: ausil.us
From: Dennis Gilmore <dennis@ausil.us>
To: u-boot@lists.u-boot-project.org
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>,
 Jonas Karlman <jonas@kwiboo.se>, Alexey Charkov <alchark@gmail.com>,
 Dennis Gilmore <dennis@ausil.us>, Peter Robinson <pbrobinson@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 3/5] arm64: dts: rockchip: refactor items from Orange Pi
 5/b to prep for Pro
Date: Sun, 11 Oct 2026 21:01:32 -0500
Message-ID: <20261012020134.621305-4-dennis@ausil.us>
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

The Orange Pi 5 Pro uses the same SoC and base as the Orange Pi 5 and
Orange Pi 5B but has had sound, USB, and leds wired up differently. The
5 and 5B boards use gmac for ethernet where the Pro has a PCIe attached
NIC.

Move the 5/5B-specific bits (analog-sound/es8388, FUSB302 Type-C,
gmac1, pwm-leds, i2s1_8ch routing, USB role-switch plumbing) out of
rk3588s-orangepi-5.dtsi into a new rk3588s-orangepi-5-5b.dtsi that is
included by both 5 and 5B.

The RK806 PLDO1 and PLDO2 outputs are wired differently between the
5/5B and the Pro (PLDO1/PLDO2 are swapped), so label the PMIC node
rk806 in the base dtsi, drop pldo-reg1/pldo-reg2 from it, and define
them via a &rk806 regulators augmentation in rk3588s-orangepi-5-5b.dtsi.
The Pro will supply its own mapping.

Signed-off-by: Dennis Gilmore <dennis@ausil.us>
Reviewed-by: Alexey Charkov <alchark@gmail.com>
Link: https://patch.msgid.link/20260511025352.106126-4-dennis@ausil.us
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: b7a806c1c35eef2ddd8145e818427f285feb2413 ]

(cherry picked from commit 42705bdffa484c64ceec9b196156d62af36940f8)
Signed-off-by: Dennis Gilmore <dennis@ausil.us>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---

Changes in v2:
- Add Reviewed-by from Quentin

 .../arm64/rockchip/rk3588s-orangepi-5-5b.dtsi | 256 ++++++++++++++++++
 .../src/arm64/rockchip/rk3588s-orangepi-5.dts |   6 +-
 .../arm64/rockchip/rk3588s-orangepi-5.dtsi    | 253 +----------------
 .../arm64/rockchip/rk3588s-orangepi-5b.dts    |   2 +-
 4 files changed, 272 insertions(+), 245 deletions(-)
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3588s-orangepi-5-5b.dtsi

diff --git a/dts/upstream/src/arm64/rockchip/rk3588s-orangepi-5-5b.dtsi b/dts/upstream/src/arm64/rockchip/rk3588s-orangepi-5-5b.dtsi
new file mode 100644
index 00000000000..6e081bc06cf
--- /dev/null
+++ b/dts/upstream/src/arm64/rockchip/rk3588s-orangepi-5-5b.dtsi
@@ -0,0 +1,256 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Device tree definitions shared by the Orange Pi 5 and Orange Pi 5B
+ * but not the Orange Pi 5 Pro.
+ */
+
+#include <dt-bindings/usb/pd.h>
+#include "rk3588s-orangepi-5.dtsi"
+
+/ {
+	aliases {
+		ethernet0 = &gmac1;
+	};
+
+	analog-sound {
+		compatible = "simple-audio-card";
+		pinctrl-names = "default";
+		pinctrl-0 = <&hp_detect>;
+		simple-audio-card,name = "rockchip,es8388";
+		simple-audio-card,bitclock-master = <&masterdai>;
+		simple-audio-card,format = "i2s";
+		simple-audio-card,frame-master = <&masterdai>;
+		simple-audio-card,hp-det-gpios = <&gpio1 RK_PD5 GPIO_ACTIVE_HIGH>;
+		simple-audio-card,mclk-fs = <256>;
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
+			sound-dai = <&i2s1_8ch>;
+		};
+
+		masterdai: simple-audio-card,codec {
+			sound-dai = <&es8388>;
+			system-clock-frequency = <12288000>;
+		};
+	};
+
+	pwm-leds {
+		compatible = "pwm-leds";
+
+		led {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_STATUS;
+			linux,default-trigger = "heartbeat";
+			max-brightness = <255>;
+			pwms = <&pwm0 0 25000 0>;
+		};
+	};
+
+	vbus_typec: regulator-vbus-typec {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio3 RK_PC0 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&typec5v_pwren>;
+		regulator-name = "vbus_typec";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+};
+
+&gmac1 {
+	clock_in_out = "output";
+	phy-handle = <&rgmii_phy1>;
+	phy-mode = "rgmii-rxid";
+	pinctrl-0 = <&gmac1_miim
+			&gmac1_tx_bus2
+			&gmac1_rx_bus2
+			&gmac1_rgmii_clk
+			&gmac1_rgmii_bus>;
+	pinctrl-names = "default";
+	tx_delay = <0x42>;
+	status = "okay";
+};
+
+&i2c6 {
+	es8388: audio-codec@10 {
+		compatible = "everest,es8388", "everest,es8328";
+		reg = <0x10>;
+		clocks = <&cru I2S1_8CH_MCLKOUT>;
+		AVDD-supply = <&vcca_3v3_s0>;
+		DVDD-supply = <&vcca_1v8_s0>;
+		HPVDD-supply = <&vcca_3v3_s0>;
+		PVDD-supply = <&vcca_3v3_s0>;
+		assigned-clocks = <&cru I2S1_8CH_MCLKOUT>;
+		assigned-clock-rates = <12288000>;
+		#sound-dai-cells = <0>;
+	};
+
+	usbc0: usb-typec@22 {
+		compatible = "fcs,fusb302";
+		reg = <0x22>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PD3 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usbc0_int>;
+		vbus-supply = <&vbus_typec>;
+		status = "okay";
+
+		usb_con: connector {
+			compatible = "usb-c-connector";
+			label = "USB-C";
+			data-role = "dual";
+			op-sink-microwatt = <1000000>;
+			power-role = "dual";
+			sink-pdos =
+				<PDO_FIXED(5000, 1000, PDO_FIXED_USB_COMM)>;
+			source-pdos =
+				<PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+			try-power-role = "source";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					usbc0_hs: endpoint {
+						remote-endpoint = <&usb_host0_xhci_drd_sw>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					usbc0_ss: endpoint {
+						remote-endpoint = <&usbdp_phy0_typec_ss>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+					usbc0_sbu: endpoint {
+						remote-endpoint = <&usbdp_phy0_typec_sbu>;
+					};
+				};
+			};
+		};
+	};
+};
+
+&mdio1 {
+	rgmii_phy1: ethernet-phy@1 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0x1>;
+		reset-assert-us = <20000>;
+		reset-deassert-us = <100000>;
+		reset-gpios = <&gpio3 RK_PB2 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&pinctrl {
+	usb-typec {
+		usbc0_int: usbc0-int {
+			rockchip,pins = <0 RK_PD3 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+
+		typec5v_pwren: typec5v-pwren {
+			rockchip,pins = <3 RK_PC0 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
+
+&i2s1_8ch {
+	rockchip,i2s-tx-route = <3 2 1 0>;
+	rockchip,i2s-rx-route = <1 3 2 0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2s1m0_sclk
+			   &i2s1m0_mclk
+			   &i2s1m0_lrck
+			   &i2s1m0_sdi1
+			   &i2s1m0_sdo3>;
+	status = "okay";
+};
+
+&pwm0 {
+	pinctrl-0 = <&pwm0m2_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&rk806 {
+	regulators {
+		vcc_1v8_s0: pldo-reg1 {
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
+
+		vcca_1v8_s0: pldo-reg2 {
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
+	};
+};
+
+
+&usb_host0_xhci {
+	dr_mode = "otg";
+	usb-role-switch;
+
+	port {
+		usb_host0_xhci_drd_sw: endpoint {
+			remote-endpoint = <&usbc0_hs>;
+		};
+	};
+};
+
+&usb_host2_xhci {
+	status = "okay";
+};
+
+&usbdp_phy0 {
+	mode-switch;
+	orientation-switch;
+	sbu1-dc-gpios = <&gpio4 RK_PA5 GPIO_ACTIVE_HIGH>;
+	sbu2-dc-gpios = <&gpio4 RK_PA7 GPIO_ACTIVE_HIGH>;
+
+	port {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		usbdp_phy0_typec_ss: endpoint@0 {
+			reg = <0>;
+			remote-endpoint = <&usbc0_ss>;
+		};
+
+		usbdp_phy0_typec_sbu: endpoint@1 {
+			reg = <1>;
+			remote-endpoint = <&usbc0_sbu>;
+		};
+	};
+};
diff --git a/dts/upstream/src/arm64/rockchip/rk3588s-orangepi-5.dts b/dts/upstream/src/arm64/rockchip/rk3588s-orangepi-5.dts
index 83b9b6645a1..d76bdf1b5e9 100644
--- a/dts/upstream/src/arm64/rockchip/rk3588s-orangepi-5.dts
+++ b/dts/upstream/src/arm64/rockchip/rk3588s-orangepi-5.dts
@@ -2,12 +2,16 @@
 
 /dts-v1/;
 
-#include "rk3588s-orangepi-5.dtsi"
+#include "rk3588s-orangepi-5-5b.dtsi"
 
 / {
 	model = "Xunlong Orange Pi 5";
 	compatible = "xunlong,orangepi-5", "rockchip,rk3588s";
 
+	aliases {
+		mmc0 = &sdmmc;
+	};
+
 	vcc3v3_pcie20: regulator-vcc3v3-pcie20 {
 		compatible = "regulator-fixed";
 		enable-active-high;
diff --git a/dts/upstream/src/arm64/rockchip/rk3588s-orangepi-5.dtsi b/dts/upstream/src/arm64/rockchip/rk3588s-orangepi-5.dtsi
index fd5c6a025cd..6d58b5c9ffb 100644
--- a/dts/upstream/src/arm64/rockchip/rk3588s-orangepi-5.dtsi
+++ b/dts/upstream/src/arm64/rockchip/rk3588s-orangepi-5.dtsi
@@ -3,19 +3,13 @@
 /dts-v1/;
 
 #include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/leds/common.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/rockchip.h>
 #include <dt-bindings/soc/rockchip,vop2.h>
-#include <dt-bindings/usb/pd.h>
 #include "rk3588s.dtsi"
 
 / {
-	aliases {
-		ethernet0 = &gmac1;
-		mmc0 = &sdmmc;
-	};
-
 	chosen {
 		stdout-path = "serial2:1500000n8";
 	};
@@ -34,38 +28,6 @@
 		};
 	};
 
-	analog-sound {
-		compatible = "simple-audio-card";
-		pinctrl-names = "default";
-		pinctrl-0 = <&hp_detect>;
-		simple-audio-card,name = "rockchip,es8388";
-		simple-audio-card,bitclock-master = <&masterdai>;
-		simple-audio-card,format = "i2s";
-		simple-audio-card,frame-master = <&masterdai>;
-		simple-audio-card,hp-det-gpios = <&gpio1 RK_PD5 GPIO_ACTIVE_HIGH>;
-		simple-audio-card,mclk-fs = <256>;
-		simple-audio-card,routing =
-			"Headphones", "LOUT1",
-			"Headphones", "ROUT1",
-			"LINPUT1", "Microphone Jack",
-			"RINPUT1", "Microphone Jack",
-			"LINPUT2", "Onboard Microphone",
-			"RINPUT2", "Onboard Microphone";
-		simple-audio-card,widgets =
-			"Microphone", "Microphone Jack",
-			"Microphone", "Onboard Microphone",
-			"Headphone", "Headphones";
-
-		simple-audio-card,cpu {
-			sound-dai = <&i2s1_8ch>;
-		};
-
-		masterdai: simple-audio-card,codec {
-			sound-dai = <&es8388>;
-			system-clock-frequency = <12288000>;
-		};
-	};
-
 	hdmi0-con {
 		compatible = "hdmi-connector";
 		type = "a";
@@ -77,28 +39,14 @@
 		};
 	};
 
-	pwm-leds {
-		compatible = "pwm-leds";
-
-		led {
-			color = <LED_COLOR_ID_GREEN>;
-			function = LED_FUNCTION_STATUS;
-			linux,default-trigger = "heartbeat";
-			max-brightness = <255>;
-			pwms = <&pwm0 0 25000 0>;
-		};
-	};
-
-	vbus_typec: regulator-vbus-typec {
+	vcc_3v3_sd_s0: regulator-vcc-3v3-sd-s0 {
 		compatible = "regulator-fixed";
-		enable-active-high;
-		gpio = <&gpio3 RK_PC0 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&typec5v_pwren>;
-		regulator-name = "vbus_typec";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		vin-supply = <&vcc5v0_sys>;
+		gpios = <&gpio4 RK_PB5 GPIO_ACTIVE_LOW>;
+		regulator-name = "vcc_3v3_sd_s0";
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc_3v3_s3>;
 	};
 
 	vcc5v0_sys: regulator-vcc5v0-sys {
@@ -109,16 +57,6 @@
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
 	};
-
-	vcc_3v3_sd_s0: regulator-vcc-3v3-sd-s0 {
-		compatible = "regulator-fixed";
-		gpios = <&gpio4 RK_PB5 GPIO_ACTIVE_LOW>;
-		regulator-name = "vcc_3v3_sd_s0";
-		regulator-boot-on;
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		vin-supply = <&vcc_3v3_s3>;
-	};
 };
 
 &combphy0_ps {
@@ -161,20 +99,6 @@
 	cpu-supply = <&vdd_cpu_lit_s0>;
 };
 
-&gmac1 {
-	clock_in_out = "output";
-	phy-handle = <&rgmii_phy1>;
-	phy-mode = "rgmii-rxid";
-	pinctrl-0 = <&gmac1_miim
-		     &gmac1_tx_bus2
-		     &gmac1_rx_bus2
-		     &gmac1_rgmii_clk
-		     &gmac1_rgmii_bus>;
-	pinctrl-names = "default";
-	tx_delay = <0x42>;
-	status = "okay";
-};
-
 &gpu {
 	mali-supply = <&vdd_gpu_s0>;
 	status = "okay";
@@ -270,69 +194,6 @@
 	pinctrl-0 = <&i2c6m3_xfer>;
 	status = "okay";
 
-	es8388: audio-codec@10 {
-		compatible = "everest,es8388", "everest,es8328";
-		reg = <0x10>;
-		clocks = <&cru I2S1_8CH_MCLKOUT>;
-		AVDD-supply = <&vcca_3v3_s0>;
-		DVDD-supply = <&vcca_1v8_s0>;
-		HPVDD-supply = <&vcca_3v3_s0>;
-		PVDD-supply = <&vcca_3v3_s0>;
-		assigned-clocks = <&cru I2S1_8CH_MCLKOUT>;
-		assigned-clock-rates = <12288000>;
-		#sound-dai-cells = <0>;
-	};
-
-	usbc0: usb-typec@22 {
-		compatible = "fcs,fusb302";
-		reg = <0x22>;
-		interrupt-parent = <&gpio0>;
-		interrupts = <RK_PD3 IRQ_TYPE_LEVEL_LOW>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&usbc0_int>;
-		vbus-supply = <&vbus_typec>;
-		status = "okay";
-
-		usb_con: connector {
-			compatible = "usb-c-connector";
-			label = "USB-C";
-			data-role = "dual";
-			op-sink-microwatt = <1000000>;
-			power-role = "dual";
-			sink-pdos =
-				<PDO_FIXED(5000, 1000, PDO_FIXED_USB_COMM)>;
-			source-pdos =
-				<PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
-			try-power-role = "source";
-
-			ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				port@0 {
-					reg = <0>;
-					usbc0_hs: endpoint {
-						remote-endpoint = <&usb_host0_xhci_drd_sw>;
-					};
-				};
-
-				port@1 {
-					reg = <1>;
-					usbc0_ss: endpoint {
-						remote-endpoint = <&usbdp_phy0_typec_ss>;
-					};
-				};
-
-				port@2 {
-					reg = <2>;
-					usbc0_sbu: endpoint {
-						remote-endpoint = <&usbdp_phy0_typec_sbu>;
-					};
-				};
-			};
-		};
-	};
-
 	hym8563: rtc@51 {
 		compatible = "haoyu,hym8563";
 		reg = <0x51>;
@@ -346,32 +207,10 @@
 	};
 };
 
-&i2s1_8ch {
-	rockchip,i2s-tx-route = <3 2 1 0>;
-	rockchip,i2s-rx-route = <1 3 2 0>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2s1m0_sclk
-	             &i2s1m0_mclk
-	             &i2s1m0_lrck
-	             &i2s1m0_sdi1
-	             &i2s1m0_sdo3>;
-	status = "okay";
-};
-
 &i2s5_8ch {
 	status = "okay";
 };
 
-&mdio1 {
-	rgmii_phy1: ethernet-phy@1 {
-		compatible = "ethernet-phy-ieee802.3-c22";
-		reg = <0x1>;
-		reset-assert-us = <20000>;
-		reset-deassert-us = <100000>;
-		reset-gpios = <&gpio3 RK_PB2 GPIO_ACTIVE_LOW>;
-	};
-};
-
 &pd_gpu {
 	domain-supply = <&vdd_gpu_s0>;
 };
@@ -392,22 +231,6 @@
 			rockchip,pins = <1 RK_PD5 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
-
-	usb-typec {
-		usbc0_int: usbc0-int {
-			rockchip,pins = <0 RK_PD3 RK_FUNC_GPIO &pcfg_pull_up>;
-		};
-
-		typec5v_pwren: typec5v-pwren {
-			rockchip,pins = <3 RK_PC0 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-};
-
-&pwm0 {
-	pinctrl-0 = <&pwm0m2_pins>;
-	pinctrl-names = "default";
-	status = "okay";
 };
 
 &rknn_core_0 {
@@ -491,7 +314,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&spi2m2_cs0 &spi2m2_pins>;
 
-	pmic@0 {
+	rk806: pmic@0 {
 		compatible = "rockchip,rk806";
 		reg = <0x0>;
 		interrupt-parent = <&gpio0>;
@@ -666,31 +489,6 @@
 				};
 			};
 
-			vcc_1v8_s0: pldo-reg1 {
-				regulator-name = "vcc_1v8_s0";
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-				};
-			};
-
-			vcca_1v8_s0: pldo-reg2 {
-				regulator-name = "vcca_1v8_s0";
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-					regulator-suspend-microvolt = <1800000>;
-				};
-			};
-
 			vdda_1v2_s0: pldo-reg3 {
 				regulator-name = "vdda_1v2_s0";
 				regulator-always-on;
@@ -841,26 +639,7 @@
 };
 
 &usbdp_phy0 {
-	mode-switch;
-	orientation-switch;
-	sbu1-dc-gpios = <&gpio4 RK_PA5 GPIO_ACTIVE_HIGH>;
-	sbu2-dc-gpios = <&gpio4 RK_PA7 GPIO_ACTIVE_HIGH>;
 	status = "okay";
-
-	port {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		usbdp_phy0_typec_ss: endpoint@0 {
-			reg = <0>;
-			remote-endpoint = <&usbc0_ss>;
-		};
-
-		usbdp_phy0_typec_sbu: endpoint@1 {
-			reg = <1>;
-			remote-endpoint = <&usbc0_sbu>;
-		};
-	};
 };
 
 &usb_host0_ehci {
@@ -872,15 +651,7 @@
 };
 
 &usb_host0_xhci {
-	dr_mode = "otg";
-	usb-role-switch;
 	status = "okay";
-
-	port {
-		usb_host0_xhci_drd_sw: endpoint {
-			remote-endpoint = <&usbc0_hs>;
-		};
-	};
 };
 
 &usb_host1_ehci {
@@ -891,7 +662,7 @@
 	status = "okay";
 };
 
-&usb_host2_xhci {
+&vop {
 	status = "okay";
 };
 
@@ -899,10 +670,6 @@
 	status = "okay";
 };
 
-&vop {
-	status = "okay";
-};
-
 &vp0 {
 	vp0_out_hdmi0: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
 		reg = <ROCKCHIP_VOP2_EP_HDMI0>;
diff --git a/dts/upstream/src/arm64/rockchip/rk3588s-orangepi-5b.dts b/dts/upstream/src/arm64/rockchip/rk3588s-orangepi-5b.dts
index d21ec320d29..8af17477780 100644
--- a/dts/upstream/src/arm64/rockchip/rk3588s-orangepi-5b.dts
+++ b/dts/upstream/src/arm64/rockchip/rk3588s-orangepi-5b.dts
@@ -2,7 +2,7 @@
 
 /dts-v1/;
 
-#include "rk3588s-orangepi-5.dtsi"
+#include "rk3588s-orangepi-5-5b.dtsi"
 
 / {
 	model = "Xunlong Orange Pi 5B";
-- 
2.56.0

