Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B22CA5FED
	for <u-boot@archiver.kernel.org>; Tue,  6 Oct 2026 21:48:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D589D60B07;
	Tue,  6 Oct 2026 21:48:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MY-iYSA9vOdz; Tue,  6 Oct 2026 21:48:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0156F60B50
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791323321;
	b=bpZlse9eZ3uPnTmCkjmIqlf0n5lYDZc2iQVs+nn+d44uTAEcvjPDgGNcWwFuQb3DD3BR
	 kuR9NiSk3b7n+OmZ1mTgHczVLihy3Pfzalkc44VFk6Q8HILDGm6RX8WeOIkg79XtjlRGi
	 HWFLefj++yUCGzo9Oj0OzymlogvYSbDPLzRUb9aG6c2QMAF+n9atK+JANvud2yrl8Qz6I
	 9s5lDs9VNfZJd0hRJyLoodIGxpI+miQ1e+fN8zYTCERAgvPz+45UOASplmHJCjgxpdv1v
	 YE4kskU7Uid/Gl+vkgYyso9udyhda3saC8lkYhwVXW2n5c/bBXRhgB0pDi8WId96EGQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791323321;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=nziU20649qK8zM0nN9xMVEjjaNopBke/NpyPtTnaZLA=;
	b=LIn01M9yLydsWcbxL6zZuItOKvdWL653yN8dar5Aue+B01G9kQVyYk7xlQOtgh/ygcLY
	 u5EALsjD7zjpxKHu7BRRGS/M6gf38ew+yl0YbnP3MYmZKq5ZOH/OOAEo0eOOK5YcA8CCL
	 dW0aVK1UZKsvAAoVESuvdcvnv/OKu7n5iWIkN/LEYUyWtOFwGk0naQdJVxjTh+7ROM8Ii
	 bEQ7x7hAzb9LAA6uFkvN7fCWXfN2xNk2pRHGXwaTMgGYNF2PdTsoKVJCvcywE9JS8Oa6G
	 7pIzQq698EweE8dvsi0Ot9lbVlbA1q3O2eLJout74IHqnePhTbakHU7vCIPTLfF9IPg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791323321;
	bh=nziU20649qK8zM0nN9xMVEjjaNopBke/NpyPtTnaZLA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=F+5fBD/G5J+ZKHSAf/TkzauRg+JNppp1B3rh1HHg72battNyyJrm89/udyhjjJVQp
	 DvgupkjvgguNG479Q5rYNDcvEz5MqTYCxvWFj2sh761XMiIjWJdOviRH6rHx+ReZ9/
	 IFoSIxvS+0EiM8n9ZFJXHoNd089tanktHSIwYE8Y1JESrw/yF/ANqkCBu3+kXiToKi
	 RU2TlH8KikTdawe2Kqz3tGV+dJ6j84qzWEdqXGN1pZVKK0vB2WKCnYjIM/HSZ//yrZ
	 OwhxhqraIvs3Eodmmmafctftqd8ch3apROabQPu36uRj0W90NYBXGHrXQmucygenoD
	 9jev8pM4kha5Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0156F60B50;
	Tue,  6 Oct 2026 21:48:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1AF0722B
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 21:37:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 00C26402D6
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 21:37:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VudSzqidAzzs for <u-boot@lists.u-boot-project.org>;
 Tue,  6 Oct 2026 21:37:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 30C1040210
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::236"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791322661;
 b=eUgnNYIzvhLUYDpIe+Tn6Ty1IeC+rVOkXR8t6Hd+moOl852s4/Pw7o4L/gB0mUz4SxoW
 kCY3cMTkHhnU1oAlzmzunLUuwrPaNgdV/HvXarLghEjtYslk2A//IzU8ohYX5Lqqxipyn
 42BD1UsSdsqfMf7fFoFK8mrpfDd3n37/dSE4jQqoGS/atVP6R8QX6xYjxX3T6/TTUB6Ix
 vBoBYDuxTL8kHndfjbi5zzgyeZm70QXIZQ1CjOgp/WzdK8v1G+frWOmukAZTgVvqQc4N7
 NqLbOWpz/ol72OYPOZyJdGhGv28AT0obZDUfOZwV3kkwCIl2Y9fc2rd8aHkq/zNAzSQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791322661;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=nziU20649qK8zM0nN9xMVEjjaNopBke/NpyPtTnaZLA=;
 b=NoSMnvxlxQ6Ba4CQ73dZT9/gSgopFunzVem6VxZMP2o5ej0gd5Or4dHAiHvxYbHXaN1/
 C37vOI3mbzYjMsDSl5iYoZZtU+5dqN+Oyuf2E60aP8tKtsFeZXy2PLXKC0EvZsELqRzzv
 Xo+VDx2ZXWOvhUoqhl+MRn4xbzsqbMz9lTTiMsIpgoXnoL0VJBa0sHBU3gtzPno1FVduM
 tc/wm+ChQWlgqOEw/FJtMHYK8gh6Vfon5lAnTfKGyymGdPrhMSpB7gpCmXcl7IZl+0woK
 LdoMERMDNhrw1qvmJKVzeHavJLn1SD0f4u+QZzRyiMus2PMoxlPkSeWL4p5isQbgTmg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=L6seVt+N; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::236"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::236; helo=mail-oi1-x236.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=L6seVt+N
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 30C1040210
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 21:37:40 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-4f488ba6e90so566496b6e.3
 for <u-boot@lists.u-boot-project.org>; Tue, 06 Oct 2026 14:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791322660; x=1791927460;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nziU20649qK8zM0nN9xMVEjjaNopBke/NpyPtTnaZLA=;
 b=L6seVt+NB7mwNdEMUyZ0KuYlPuttOF0zWzrDRrPEpVxgE5fqBlBRJPXXcipXe9eq0U
 sMz0UspgaW6+d1h5wx2+KQ35qsEtqnPuE4cpKe7NVRZKCocvrgwIIci1Iqs1NFyaWaUp
 +Cbs40k95h44tp8FTHwDDw42g4or0mP/ons0kU4ZBo7EosZtJvjbTHvvNTB5WfKHm+L5
 xkl2jGGzSkM+EAflbAcaKPBxMI8VmPXGVz+cdmaCwuY2dcUddJrkRVQFQjpVcfLMwzSc
 5uRviFGyIr+visktNqXGItTR/FKYbfSnKxeY8r8q1oD3Qh+cgEllu2+eFsE34Do2xUOA
 sYjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791322660; x=1791927460;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nziU20649qK8zM0nN9xMVEjjaNopBke/NpyPtTnaZLA=;
 b=R8vTIrKM6+SerHchXuMQfRDfo6oKtr7qYlj2Hru5CxWfpgJehsx8ffAaJgIW4UW9i5
 3BkwLaW8Nf0zgV/R31Ar6STQUeQGoLDS9o7j1asGTmRRyePm2S5WADcnpaDmBxDpg3XR
 OhnWmn0/BDTrgXdhtlw3UwRWYGtkSh4pwX/XQaxtb9StyO2oX90rhb0+uvI+e9AXGw0i
 hLbZ24eoILauhZMq2rex55k6zej5HXnfzUaN+9z6N9qXAB3NaKPX9j68Y2Ao2mUV/mSS
 07nw8ryubGKnr7yKUiuXDFCx2moeAHsdQ5hO6eVI1okw6srHwBqdnGVOyv7EHAzejyOS
 nF3g==
X-Gm-Message-State: AFuF++mrEu6EWC3QApXP/3eNj2hWT6GUUnvXliwVKELUcS3krcpooqoH
 xBZHjF06oWxN12m5IPNnyhZ1wywMccRVJrjsTqGQWu0LO1NkQWdcqO6R0DsybwsZAd4=
X-Gm-Gg: AYBFou0DT++T9C51DxWIVJ5OOoGHIm16H4hIQwJK37SG0kNHQn2emqf3e+3l77KtDrd
 OpZN8gyjaHVj0J4Z8RuUlR8uxZLUel3ku2dU1BK15ACEkvuvnbWvWyLs1FoZVcP8/NQEbJ8cGm2
 b2mpkmRMqOkE7Ug70BchnPvl20E/SuvqTEhhWV295LnOkAiORNcgMYZ4QvaTeGAJ/eKINCiQBk9
 XKm1Tc5UuNWy5ifhEElVW0djQob1vHyccNR1gc0hyJvBdbp1Yc10OiVNNuH+Qi/7RrQPk//DWLr
 mnyIfxTxnF3zj8ImhISeLhrOpVT12vt3Zr2ofAxbGd7n4G8neVuFTcVkqfoboJqXjijJ5sL24Wg
 DVi4vwPpk/4QrqtGgfiSSXMiVAS8gRKb7J8oH9AaI4PEbk7GUxfku+gpifMKL5JXZ3w4E/0RrRb
 mspitAdpRQk++AaAYRwcAptI5JWU+7GrpihNbWepMIaa1l3qx+W4X+w9j6JSwTBS7wrqUDj8LGY
 A==
X-Received: by 2002:a05:6808:4f10:b0:4f4:b5ba:a236 with SMTP id
 5614622812f47-4fc45248a85mr636588b6e.10.1791322659858; 
 Tue, 06 Oct 2026 14:37:39 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:372:3180:ce34:1fe7])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4fc4953f89fsm389386b6e.12.2026.10.06.14.37.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 14:37:38 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 06 Oct 2026 16:36:19 -0500
Subject: [PATCH 7/8] arm: dts: mediatek: add the DSI panel to the Genio 520
 and 720 EVKs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-mtk-genio-720-dsi-v1-7-7fa10e9c4506@baylibre.com>
References: <20261006-mtk-genio-720-dsi-v1-0-7fa10e9c4506@baylibre.com>
In-Reply-To: <20261006-mtk-genio-720-dsi-v1-0-7fa10e9c4506@baylibre.com>
To: Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4048; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=FqZ/ER/CdMstnhjv1o3RgdKKbrvYermAjGKi15xrbWI=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqxWoApOWtJgTl5P8Gk3+o3i91DUQKKj7chI9X9
 iDB7437HJGJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCasVqABYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AWMgH/Rz4riEbSMPb9f043eAxBZAEsB8gLIZA+WBxYUb
 I9WQYh4e7amb60J8gW8iOlQ5DiMay0Cq6mom31Cp97COSskLaTgRtLX8ljDDE0vmpK4hWKc0R2P
 jgbOhFMaEwyP/mBMOFLWnhBARfmsqtzSx5TeUkTwFzEk2kSk5qgXBiDGnUSszzu84HvAqhumwk0
 jlLBoyA3TLdlrNGalpoyAhpSQEEeElG5dcCT7g3WymEwVEWHur9RN49YiVt4Z+rzqxM3YCV9r5H
 KKCVmETV9nW2vu9aiUvINeKh5N43dZohISwSR6jJ3r/BaaLKC8dczv+IXvfmg/b8He+egwA30uG
 RwBk=
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

Both boards carry the same optional Startek KD070FHFID078 DSI panel, so
enable the vdosys0 DSI path and describe the panel, its PWM backlight
and its three GPIO-switched rails in the shared dtsi.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/dts/mt8371-genio-common.dtsi | 137 ++++++++++++++++++++++++++++++++++
 1 file changed, 137 insertions(+)

diff --git a/arch/arm/dts/mt8371-genio-common.dtsi b/arch/arm/dts/mt8371-genio-common.dtsi
index b1ec5aba082..95391a0585c 100644
--- a/arch/arm/dts/mt8371-genio-common.dtsi
+++ b/arch/arm/dts/mt8371-genio-common.dtsi
@@ -55,6 +55,41 @@
 		enable-active-high;
 	};
 
+	backlight_lcd0: backlight-lcd0 {
+		compatible = "pwm-backlight";
+		pwms = <&disp_pwm0 0 500000>;
+		brightness-levels = <0 1023>;
+		num-interpolated-steps = <1023>;
+		default-brightness-level = <576>;
+	};
+
+	reg_dsi0_vdd: regulator-dsi0-vdd {
+		compatible = "regulator-fixed";
+		regulator-name = "dsi0-vdd";
+		pinctrl-names = "default";
+		pinctrl-0 = <&dsi0_vdd_pins>;
+		gpio = <&pio 87 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_dsi0_vddp: regulator-dsi0-vddp {
+		compatible = "regulator-fixed";
+		regulator-name = "dsi0-vddp";
+		pinctrl-names = "default";
+		pinctrl-0 = <&dsi0_vddp_pins>;
+		gpio = <&pio 24 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_dsi0_iovcc: regulator-dsi0-iovcc {
+		compatible = "regulator-fixed";
+		regulator-name = "dsi0-iovcc";
+		pinctrl-names = "default";
+		pinctrl-0 = <&dsi0_iovcc_pins>;
+		gpio = <&pio 58 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	firmware {
 		optee {
 			compatible = "linaro,optee-tz";
@@ -115,6 +150,60 @@
 	status = "okay";
 };
 
+&disp_ovl0_4l {
+	status = "okay";
+};
+
+&disp_pwm0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&disp_pwm0_pins>;
+	status = "okay";
+};
+
+&disp_rdma0 {
+	status = "okay";
+};
+
+&dsi0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	panel@0 {
+		compatible = "startek,kd070fhfid078", "himax,hx8279";
+		reg = <0>;
+		reset-gpios = <&pio 25 GPIO_ACTIVE_HIGH>;
+		enable-gpios = <&pio 13 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&panel0_pins>;
+		backlight = <&backlight_lcd0>;
+		vdd-supply = <&reg_dsi0_vdd>;
+		/*
+		 * Not in himax,hx8279.yaml yet: these boards gate the panel's
+		 * VDDP rail from its own GPIO instead of tying it to VDD.
+		 */
+		vddp-supply = <&reg_dsi0_vddp>;
+		iovcc-supply = <&reg_dsi0_iovcc>;
+		status = "okay";
+
+		port {
+			panel0_in: endpoint {
+				remote-endpoint = <&dsi0_out>;
+			};
+		};
+	};
+
+	port {
+		dsi0_out: endpoint {
+			remote-endpoint = <&panel0_in>;
+		};
+	};
+};
+
+&mipi_tx_config0 {
+	status = "okay";
+};
+
 &mmc0 {
 	bus-width = <8>;
 	max-frequency = <200000000>;
@@ -153,6 +242,10 @@
 	regulator-always-on;
 };
 
+&mutex0 {
+	status = "okay";
+};
+
 &nor_flash {
 	pinctrl-names = "default";
 	pinctrl-0 = <&nor_pins>;
@@ -169,6 +262,42 @@
 };
 
 &pio {
+	disp_pwm0_pins: disp-pwm0-pins {
+		pins {
+			pinmux = <PINMUX_GPIO29__FUNC_DISP_PWM0>;
+			output-high;
+		};
+	};
+
+	dsi0_iovcc_pins: dsi0-iovcc-pins {
+		pins {
+			pinmux = <PINMUX_GPIO58__FUNC_GPIO58>;
+			output-low;
+		};
+	};
+
+	dsi0_vdd_pins: dsi0-vdd-pins {
+		pins {
+			pinmux = <PINMUX_GPIO87__FUNC_GPIO87>;
+			output-low;
+		};
+	};
+
+	dsi0_vddp_pins: dsi0-vddp-pins {
+		pins {
+			pinmux = <PINMUX_GPIO24__FUNC_GPIO24>;
+			output-low;
+		};
+	};
+
+	panel0_pins: panel0-pins {
+		pins {
+			pinmux = <PINMUX_GPIO13__FUNC_GPIO13>,
+				 <PINMUX_GPIO25__FUNC_GPIO25>;
+			output-high;
+		};
+	};
+
 	mmc0_default_pins: mmc0-default-pins {
 		pins-clk {
 			pinmux = <PINMUX_GPIO162__FUNC_MSDC0_CLK>;
@@ -367,6 +496,14 @@
 	};
 };
 
+&smi_disp_common {
+	status = "okay";
+};
+
+&smi_larb0 {
+	status = "okay";
+};
+
 &pmic {
 	interrupts-extended = <&pio 194 IRQ_TYPE_LEVEL_HIGH>;
 };

-- 
2.53.0

