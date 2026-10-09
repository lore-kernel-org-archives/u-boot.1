Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54BE4CA6015
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 16:16:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1CA2A608FA;
	Fri,  9 Oct 2026 16:16:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8xQMPzmYSz3C; Fri,  9 Oct 2026 16:16:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1F90C60A3A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791562575;
	b=MiCwE9neYIDCG78w2YIVSVjuQFUE/qNM8DRl6l1QKF/bhG1Hz5HXwKtGBtVAqnGOD/O8
	 i8Kpf3vizG0bfnVyh3+RvDmOkmaOcEsXEK4beVTAJnfZeQ2QfdccC3Dlwjl8WAE0n3kkA
	 i5+0P0mKVkvUI8tJ+fOX6yncoZMf3UaOsNgwxkRiLlqrqp2VFyeCP02AJaVwBIzu+dPoI
	 nB21d6022y32Xx4uCjQWLT0aT4egLBmi12Sp6d/RrX92lQELVSeEbWaJ/FRhFJ7zpDWCs
	 /6jLzGd7aLommMk3m2uOWQd6zdgrF6dXJ25u6GYWsEz5oZAMMuxAg+z1ck73HnQ3qgA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791562575;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=kUHcQWtMJaIDMsiLmhwggwSd+nWOUA4FVHjkpKv+gfQ=;
	b=boum2C70iwfyuH7w5rZ3MWS2nKlBRQz6JKyLNx9cjTx2qY8yWTQMsyHvc7HsyfI88D6X
	 Lbnyo+MaDYdF2K4wo7qoHMxtDxbKTZHP/5CXzkKZS00TpsGl4Ks+9ZgNGm3f2Wlktrbxe
	 6x2yBJQRHR9gDDiGhelaPC6etUk70Kyuxm/Ssa3SZ/MVO5md/qb+Oh5Lx66BcVuYtiwiB
	 aXxQWWe7ipeozLW7TwJu9j71xxo5KWamahGZCUgVHgwyroI7NES+Dqr7qZc1WA8oeXgEV
	 OYWLSScxlMDoccFtxCcvpf7LpT0k1YJpi8lHkzPdZSH6TYxZNqbtCnTTk5Nl68hnn9g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791562575;
	bh=kUHcQWtMJaIDMsiLmhwggwSd+nWOUA4FVHjkpKv+gfQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dmgcWvDkoVvKRDX/nNimNXw9oT9PM1/KPFvNikECi0VDH8+nuIPAdJAMFmZRRzjyf
	 Bb8pg5EtHIoq1b5/EgH2E1ib1KP0IOQqyVzyoWml7QFw7iQngx6/zZiy+lSLOALvst
	 OZJGa0YoCdZzQ+EP7Qah3UbP/G5clZxI8+kYH+gIYmBBrzp/ExBg4ovqTRkBVwz4SI
	 3DOu0yLPYx6qCAwKaOd9L2YmK/zopa56y0FTOFhgbI2P0QgnnxcoeS/d/TQwVW5pf4
	 hs3mA/goFfd43D4U0gzfVbmmrHSchU6Mc8s06om6h2bFJrsKsnGGg+OfjoNLAaqEzd
	 hbOFrBb8Abp0Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1F90C60A3A;
	Fri,  9 Oct 2026 16:16:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 215932AA
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 16:16:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1312A40050
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 16:16:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EqObJxUUSPNK for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 16:16:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 37A9E40102
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791562569;
 b=VMuOuljGg4uvRCRiaalEXt/KXIaqi7+vr/wIzhUez9O1b9GcUozT0LnQgkdJFEF4IsCZ
 H/KiQGn1Q4wMhN3R6B9jomKRTbYqpTI2+cb356URSW3TSqsVzU5OCFqbyG0vJ8Buzb5GP
 fLRkglRdfi+HSQTSpQCgYZeN2Fc8KAGwT02lmSHfyGmh9AubU195ckaFnvXRJysj2GMO1
 id1hM9R37MOeYp0j8sUu9ThCcFB5ZlniIiAqX6tYJV+kXx8dQOttyVyQ06dLFuAOqBgNF
 j5Eldce6/hcoPIIjMWDrdhYp6zo9uqxQL3jBUytu6k/SarifKveakvoLcT+QmSELnLg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791562569;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=kUHcQWtMJaIDMsiLmhwggwSd+nWOUA4FVHjkpKv+gfQ=;
 b=YRKNzFH+06KYA7Sanvu0nP8VEhvvic0zeovzUTVv86mWUNXVneU7+NmGUdoamTqMVDy6
 HwmmYOOw6K2O3aJZeZaN6jPKW6aD6M3wAR+UIEBeXSMg56+yK/b7hphjPCbAhaOVQuTMy
 VLQE6Ex2rZ+AasDHn8Ql2chrlVvGAJbLnYbYeubDKl/DkjuP8Ys7lsHXXbHijB/8nGah6
 LoXK7Ps3wY8IHdx2K3AwJffBEw31LvBhwt20Q8BGKlft9kMUEx0CkN57T4GjxBrpgkPv4
 KPF7P4vmT9BgKtxmtUNzHdotKjvqlkW85E4ZKy+s9PGjU8HxTXyLk8IWuO2gpoOzkEg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Ih9a8iJh; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22b; helo=mail-oi1-x22b.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Ih9a8iJh
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 37A9E40102
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 16:16:08 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-4e4a4d77e5bso1188240b6e.0
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 09:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791562568; x=1792167368;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kUHcQWtMJaIDMsiLmhwggwSd+nWOUA4FVHjkpKv+gfQ=;
 b=Ih9a8iJhXtOiAvLHE7sq1aA22yUyUXjPpCLe2bQ1CHlxNxLmI/gqj5ggQuPV0PykRO
 U7VXmDvwUJxcfUcLP+mCBpAW5zXZjW8kHIDV4ZVWv6e+ipmN976jlkkYOtEmGzKzqbHA
 Bm8BEPoi7owyWBJ6I3hASFDqN+GGrnmOn1W23NUPNhXVp/k/TRsk1fBa4cWGSAfvcLtn
 kVNWOFq3SJWYZuJUxqfUApd8YVxAt41YTlMP+L/Jqg/Uzgi5Ra20ru7IivA9PK5w5v0W
 uJ5UF7AA68Pt5wm7NF118B/R6iVLib0zooVNLZNBC+o30KxFljXLxKKoKiMZ+DfnJONG
 Q1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791562568; x=1792167368;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kUHcQWtMJaIDMsiLmhwggwSd+nWOUA4FVHjkpKv+gfQ=;
 b=yXpFaNgNV9ZEA9EsZp3mYSBEs9Hzh8pSXM1UTlfLIg6H6hPatSha0l7rtp17MvTjJO
 y8VPsqgp/hv0XUtdX7Smvmf96ZfnqasFIvS0gn/UNlDXXBW//YNmtaCJTCVlvp6CE3Cw
 DLAXC13kUS0G47cltfmlQPwiS8JsUy/Hh80ldI1aN1PywB3ZGUrCH9hvIgyX++e7J0Fx
 CqjwC2xn+sVTu9COTA4sn64QkmdL9MsIS1AfV6+MTHCrLf4CrlfpR+JHwZ8kOcZGIg6y
 ryfrHI0IeunqAyhdasK5vUYF+AYbL8NIvrZ5AK6GMLYTnRgshFzKIREl4ggZPClWsOSs
 N8KQ==
X-Gm-Message-State: AFuF++nRCX8r/hCr7oMP5CCar5Sij8YuJvLqaxcBJDJ7GbDqyqTkdC/z
 oUUTOdU4ZvAhgfWM3LmSqYuFTod3opD5Pl5PSmLrhWku2HH86WvzAsRWZ7HiCGMi0D8=
X-Gm-Gg: AYBFou2pQuE0J2B4xisb52Xe+Uoo1MkGvi7JD/M0S9aF6MCOtXjqF0fXz/LgM6P+OVb
 jlOV8r5viymAETi9IJRJp156T8lFi61PTzcB34INe5QWceusBrlyIsgVDaLjyJNb1QcKHTbYZqB
 b3seCHBYeg+ThscWXPjUYg34mCk5mdqSyOvhnbdD9YMhxk2w4OKTE8dGSBxf5jppjUgzSDtoWV8
 +296QvgG2iqifs4ml5GX0vGRqkEgHU7o2CcpuO0NuJIGRja02MHY0Ib9cFHCHu2PCd6qso3XIvO
 egyD65PVBTDr//c5Rnp377AjC+oK+fMimxEqMeO2m1fqR2MvRpHbiNr1gmPhlFWorfLF1Saxaxr
 2grsNbF8fNY4/TsiI1kzB8B8k5h5ymVihxcd7+2O+3/L0lM0erhCI5CC+NBLHU06Oqo/G7OqCx5
 1sZ2K1I8X3PR9KLcEkB5HZHrl9yU/PBKX6qoeYO7spi3NEIQE3TNJFdRpskxg8TBwi8p+/jNm17
 UY=
X-Received: by 2002:a05:6808:1a0d:b0:4e9:1d81:a952 with SMTP id
 5614622812f47-50b5f075b72mr1818375b6e.19.1791562567773; 
 Fri, 09 Oct 2026 09:16:07 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:29bd:56f6:5ae7:35d2])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-50c0c5fe7d0sm2451506b6e.2.2026.10.09.09.16.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 09:16:06 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 09 Oct 2026 11:14:14 -0500
Subject: [PATCH 11/13] arm: dts: mediatek: describe the eDP panel on the
 Genio 520 and 720 EVKs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-mtk-genio-720-edp-v1-11-4fbcf5b2904d@baylibre.com>
References: <20261009-mtk-genio-720-edp-v1-0-4fbcf5b2904d@baylibre.com>
In-Reply-To: <20261009-mtk-genio-720-edp-v1-0-4fbcf5b2904d@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4595; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=zZqNFiIgVAr7tsr+ob+wyPJqE09ASDcgOhXaJfGvVng=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqyRMctmjsGmtqGyV4aUfjpDwTBoNFsteJ680/G
 uwBeYkghxOJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaskTHBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AZaEH+wc8kaJL6MBgHtdACIOVWH3p+/N8ftBlAma00x5
 gtPamAiFOgWiNJZFWSXR0myT60mRfG1zaCsm7G+x70IX6SX1IOhcHlvfLwCwAPbl/1VTbjZkueO
 8O22y3JsOSoTZjAdNmUkPJu4JXzZMN2NUDXuPx3AR1WLOs/cOklVSEGiCMvPqgWg/KunrYfFD7p
 40Zm65CIv9nOId2+j1Clu751EwcwVdkIZQClPJpmj9I8dL8OM8XMKj3g/mkrdf0tN474YsJG/S+
 QZHLvZajR5g+jPkkUaAwT+HFgZf2uJNe4TIuH1PX/opqXiy3GNXakybBVHRjqy0S7TVePug6Hh6
 2hLQ=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Describe the hardware behind the EVK's eDP connector: the panel on the
transmitter's AUX bus and the display graph from the DVO through the
transmitter to it, the panel's 3.3 V supply and the backlight's 12 V
supply, the backlight driven from PWM1, and the pin configurations for
the PWM, the hot plug detect line, the two regulator enables and the
backlight enable.

Each of the three enable lines gets a pin group that drives it low, so
neither supply nor the backlight turns on before its consumer claims
the GPIO.

All of it is disabled, because the board drives the DSI panel by
default and the two share the display pipeline.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/dts/mt8371-genio-common.dtsi | 134 ++++++++++++++++++++++++++++++++++
 1 file changed, 134 insertions(+)

diff --git a/arch/arm/dts/mt8371-genio-common.dtsi b/arch/arm/dts/mt8371-genio-common.dtsi
index 95391a0585c..f6c0754d0ad 100644
--- a/arch/arm/dts/mt8371-genio-common.dtsi
+++ b/arch/arm/dts/mt8371-genio-common.dtsi
@@ -63,6 +63,44 @@
 		default-brightness-level = <576>;
 	};
 
+	backlight_lcd1: backlight-lcd1 {
+		compatible = "pwm-backlight";
+		pwms = <&disp_pwm1 0 500000>;
+		brightness-levels = <0 1023>;
+		num-interpolated-steps = <1023>;
+		default-brightness-level = <576>;
+		power-supply = <&reg_edp_backlight_12v>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&edp_backlight_en_pins>;
+		enable-gpios = <&pio 108 GPIO_ACTIVE_HIGH>;
+		post-pwm-on-delay-ms = <1>;
+		status = "disabled";
+	};
+
+	reg_edp_panel_3v3: regulator-edp-panel-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "edp-panel-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&edp_panel_3v3_en_pins>;
+		gpio = <&pio 109 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		status = "disabled";
+	};
+
+	reg_edp_backlight_12v: regulator-edp-backlight-12v {
+		compatible = "regulator-fixed";
+		regulator-name = "edp-backlight-12v";
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&edp_backlight_12v_en_pins>;
+		gpio = <&pio 110 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		status = "disabled";
+	};
+
 	reg_dsi0_vdd: regulator-dsi0-vdd {
 		compatible = "regulator-fixed";
 		regulator-name = "dsi0-vdd";
@@ -150,6 +188,21 @@
 	status = "okay";
 };
 
+&disp_dvo0 {
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@1 {
+			reg = <1>;
+
+			dvo0_out: endpoint {
+				remote-endpoint = <&edp_in>;
+			};
+		};
+	};
+};
+
 &disp_ovl0_4l {
 	status = "okay";
 };
@@ -160,6 +213,11 @@
 	status = "okay";
 };
 
+&disp_pwm1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&disp_pwm1_pins>;
+};
+
 &disp_rdma0 {
 	status = "okay";
 };
@@ -200,6 +258,47 @@
 	};
 };
 
+&edp_tx {
+	pinctrl-names = "default";
+	pinctrl-0 = <&edp_hpd_pins>;
+
+	aux-bus {
+		panel {
+			compatible = "edp-panel";
+			power-supply = <&reg_edp_panel_3v3>;
+			backlight = <&backlight_lcd1>;
+
+			port {
+				edp_panel_in: endpoint {
+					remote-endpoint = <&edp_out>;
+				};
+			};
+		};
+	};
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+
+			edp_in: endpoint {
+				remote-endpoint = <&dvo0_out>;
+			};
+		};
+
+		port@1 {
+			reg = <1>;
+
+			edp_out: endpoint {
+				remote-endpoint = <&edp_panel_in>;
+				data-lanes = <0 1 2 3>;
+			};
+		};
+	};
+};
+
 &mipi_tx_config0 {
 	status = "okay";
 };
@@ -269,6 +368,13 @@
 		};
 	};
 
+	disp_pwm1_pins: disp-pwm1-pins {
+		pins {
+			pinmux = <PINMUX_GPIO30__FUNC_DISP_PWM1>;
+			output-high;
+		};
+	};
+
 	dsi0_iovcc_pins: dsi0-iovcc-pins {
 		pins {
 			pinmux = <PINMUX_GPIO58__FUNC_GPIO58>;
@@ -290,6 +396,34 @@
 		};
 	};
 
+	edp_backlight_12v_en_pins: edp-backlight-12v-en-pins {
+		pins {
+			pinmux = <PINMUX_GPIO110__FUNC_GPIO110>;
+			output-low;
+		};
+	};
+
+	edp_backlight_en_pins: edp-backlight-en-pins {
+		pins {
+			pinmux = <PINMUX_GPIO108__FUNC_GPIO108>;
+			output-low;
+		};
+	};
+
+	edp_hpd_pins: edp-hpd-pins {
+		pins {
+			pinmux = <PINMUX_GPIO28__FUNC_EDP_TX_HPD>;
+			bias-pull-up;
+		};
+	};
+
+	edp_panel_3v3_en_pins: edp-panel-3v3-en-pins {
+		pins {
+			pinmux = <PINMUX_GPIO109__FUNC_GPIO109>;
+			output-low;
+		};
+	};
+
 	panel0_pins: panel0-pins {
 		pins {
 			pinmux = <PINMUX_GPIO13__FUNC_GPIO13>,

-- 
2.53.0

