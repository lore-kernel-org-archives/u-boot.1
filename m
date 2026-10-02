Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67323CA5FD6
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 03:13:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0464C40BD5;
	Fri,  2 Oct 2026 03:13:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xj6P-DDLjSDb; Fri,  2 Oct 2026 03:13:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4C35B40B48
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790910833;
	b=IQEMhVSgZpM9W1/s4NFpLJIPTpLfzjPRwjP8CwON+dCidUJSwUKXbHihYZB/y6G8EDRy
	 6vxX1/NcX+l5va0uIoylz/ytHslTHikfRZ1UDIHMekm3vj66MFjuugvfIQ/knhz7a2WyD
	 Q1oKzCaYugUn3pZuNQnTcGMaEzLSWcweGQSG9EePKINyzRWnfwOJL7HbpM9GyhWDW8ydF
	 wfpRdps9snZABCYt7b3BaYhRz8xH5QHK6Eim7Rp65iPpnV1MXKsvB/0178AKz9aKdb8UQ
	 0bWm+YbcZchmui9M+kGZ7hQ8ieWKKMv4HfFI2zp081zTB9Cc3l6SSqgMYAWdAmOZf+g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790910833;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:X-Relaying-Domain:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=LUGvFEbA7F8kcCSpbkRwV7VmhmxLmaGOW2ReI/Xs/vU=;
	b=lf/97w0pjXH4rH0RzIEU8qXXC63IOraeHnP5zef+DwhOdixiIUKI/4WWdkJEqGMM9hRa
	 8WGUJC122PmrS8RitV4xn4a3tsO3GBeaOxbTs/oXxIx9PJ531gMT0DHdJQcq92I0RsB3o
	 uLKuno5DgTzy0hGWaILsW/eLy+b8g/+SspXXNbGcntQPGbo1UjIPQ+s5Dg5bjHX1wH/jC
	 BgYK5MFbZKEwksrPtU0RO8uR3RAQuOA4+v+m3O1iFH24pB8vvJowO+uhc/1l5MfDLzxg7
	 Y3mW+BKuit1+CtVC7IijJiukt4FiVTMcdV1eGt68jcIuDziqnkSnWAYEb4pQslMF6fA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790910833;
	bh=LUGvFEbA7F8kcCSpbkRwV7VmhmxLmaGOW2ReI/Xs/vU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BOs66QfUVRrBPxUfJ1OeRj+YSnWmq0V2jLlPnu2XZmxy8LW00a2Xz8YMQCuxpol56
	 Pp2NDWDHFJ8+tx9Et8rLndgvsuH/EuTKhqP+P4ps5oFORXPuRDiJUoNMmI4A2PWCNw
	 MKwhhNhpqEX7Hb4oLCTObMHlKM3B+E0oksi0eRbkWmHCf49R3scRifS+vOxhdYUylf
	 jAT+XEs/BU9fOR2XXP0I6JaaybYBsbvNr1AzRG+6sFIrX8oGiDP4mEuALAOqgPEJtm
	 BTOTe/eC3SblPeGmDZ7MX66khik48LCQCHKkAHmWONArvCBa2G0HrNDNakC4O/qbOg
	 MQdEQEdobDDIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4C35B40B48;
	Fri,  2 Oct 2026 03:13:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 99C2E32F
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 03:13:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7FE02607CE
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 03:13:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5psJeCu-JgZO for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 03:13:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A5A116070F
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1063"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790910828;
 b=MC8eTYOlIgDmBO8hf4MFBKsWwCT+sIaGB0LAnitYrR2rdP5S1s5rJdE6MhgNqxNTf3l3
 v2fm30X49uoVT/u8yNcYcXypAMA02N0SmHBY3CMYKqtaUpTUjnmNs3YevvTvDNv+m2CiG
 wmL/ek00PeJQJrIFsZBEkp6VrhbgWRf4WDvywS649EvIkgdA61j94heemm/f/KlAnZO3p
 BrSmeR8WUHP34NZAxCm/PSt7KoWbv1QaGHFUYJQMzyCx8gBeUy1uaCqj2HompVz19jejc
 idKqw3fl/gdxc0Wx6izoTMYDVtBXUY8a9ejyL7qI9n8kCw1b9QNq91mXCzDtxeMh0fg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790910828;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:From:
 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=LUGvFEbA7F8kcCSpbkRwV7VmhmxLmaGOW2ReI/Xs/vU=;
 b=maFIwwUjc7vb3/n7/1qYYKBMuNVFErDh+b9j22wMXngZlTO5L2BxhnYN20DGfJgXEk/v
 NylE/36kkXlyz5Ff7Hxl0ndS2zL37Lzs4+TR6kLxYph2GyXpWfYd7y654fzo4A2PUeLR2
 pSyve9pAuIhY+FN5j5UbVf9xaPLRvrirudrZ3+RGdQTiln8V0LOAk3J6DBBQLHbqkmEDO
 Bj62f/ctm3x1PwXEeek7BzwxJQstEmBVHklc6a5pOgGjjUyTWN/+pNfSEiY38qViZJ7SZ
 BzCCDuObahu5Bs0rpxFLmrFsRWLD5L4YSeov/heq3ODMIYBAh9rpfRhPui1Hk8zHtiA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=ausil.us; 
 dkim=pass header.d=ausil.us header.i=@ausil.us header.a=rsa-sha256
 header.s=google header.b=gFnvN6Ge; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1063"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1063; helo=mail-pj1-x1063.google.com;
 envelope-from=dennis@ausil.us; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ausil.us
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ausil.us header.i=@ausil.us header.a=rsa-sha256
 header.s=google header.b=gFnvN6Ge
Received: from mail-pj1-x1063.google.com (mail-pj1-x1063.google.com
 [IPv6:2607:f8b0:4864:20::1063])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A5A116070F
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 03:13:48 +0000 (UTC)
Received: by mail-pj1-x1063.google.com with SMTP id
 98e67ed59e1d1-38e58034d05so1526007a91.2
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 20:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ausil.us; s=google; t=1790910827; x=1791515627; darn=lists.u-boot-project.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LUGvFEbA7F8kcCSpbkRwV7VmhmxLmaGOW2ReI/Xs/vU=;
 b=gFnvN6GerUaX/hLApKueKmMnQhPqh16JmSoFI23VUCVxz030AKBM2h58SyOqCu5zsk
 RmtfjLz5b/lcEOMjDWTQRzXyNbyspDGwnkdfegJ3B9bv6FtHRqV9yrx0hFUgcM3PFLjD
 vkscSXMizGYDtc6jA+9B7cmTaLQ34FvUh5V10KBO9xxVo9RWcExJqpJXEedblAukiAtK
 9eL1Df1xtTD3KFwEkDT33n7VWUVxvpgjeSU/CMoi8osgiBNwSrs3/ULl3K5fVCE53xVU
 G9x3hNOw8CAsenDdnWFX2oE7rhFpXr6XA9X4seXtiZf4xqa/r0AlAuoxzOe+gtrkconu
 oY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790910827; x=1791515627;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LUGvFEbA7F8kcCSpbkRwV7VmhmxLmaGOW2ReI/Xs/vU=;
 b=XhDUeyqbWaKXVTsJ6dm7JmFjRyBgVGLyt4JkX3Fg4NWt9TNvfBKGP5b/VkR7aZsgDR
 wtFYLiTHRdFiOsuyhJUXgmzrqJqtMVTBTZBMxBLL6Nh2puFOg5K9ge2dNLKeuVDE8PrU
 voBpdoq2NZdP/BBArWZcgt/WwA/zNMJM62wsKojeiFgDAcp/CAfp1sP4H4+L8eXzP97T
 cGkcGf2LSqmxVB4DxatW6y89xOwYTIDWyrUtaMqJ32Jaf9jC32CWN+SQaQUIuJeNKykN
 c5Fj1bx+1BrZMEjxQLzPkQplo4Knt2VS6bm4+/3LSXkywumHmkaDvBi+0bKVPFNuhAQM
 DMLA==
X-Gm-Message-State: AFq9FYJ3kuZ2A7TZQnOCTQKVJ0FfzMhqeJJUzisjhmkB5LmmdUFl3Pp0
 kMVXATX0FwKqZku7sYxyyEd6rkMks0DwMdgKiIDBHZAZq56uAakSNuWnY8nWAiNNzQyjebJMoE5
 fF0rjtYKIaFdnNMiPRZCQMcA5y0gOHI3y7FeAk3D98VUp
X-Gm-Gg: AYBFou2EGHnL+aEeZC3L7fnQa2AvzK+aGBaQe5100zCH1+46VW/W+fufWXeu2p9LTLt
 WSbXt29W7/ZV3Pd41I97pbEi8sB9hIePLpoLuLpVtfT0B5AnKmk8VaANxfjPFLsTHPLPXBALler
 C4f/qB7k8HZT8PLHzwNw2X5WPUqdTiQgVGEFT0usyCmSxotaito1bLF0yjZOrDwvJj4KPLP6LUI
 /pIjBjsreTGo1vE4nzFLoKa8Tt0MEEduAaIkxFTNkUcBrX+ACHz3FGN8SVnEnFSB0WCsRUag2zJ
 FIC3H+70og3msKTJjwvruRnzwt3k4sMwGQRYvMt9pH+a0kJtL8IT5t0Sm13y5zq0gmo73lu/s+D
 zE+IfooBqBb4PgByObE4MXG8=
X-Received: by 2002:a17:90b:35d2:b0:3a0:d79d:b6bf with SMTP id
 98e67ed59e1d1-3a6ce6af19fmr503480a91.20.1790910827574; 
 Thu, 01 Oct 2026 20:13:47 -0700 (PDT)
Received: from ryac.ausil.us (207-179-239-100.mtco.net. [207.179.239.100])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3a6cd60531fsm834715a91.6.2026.10.01.20.13.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 20:13:47 -0700 (PDT)
X-Relaying-Domain: ausil.us
From: Dennis Gilmore <dennis@ausil.us>
To: u-boot@lists.u-boot-project.org
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>,
 Jonas Karlman <jonas@kwiboo.se>, Alexey Charkov <alchark@gmail.com>,
 Dennis Gilmore <dennis@ausil.us>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/5] arm64: dts: rockchip: rename PLDO regulator labels to
 match schematic on rk3588s-orangepi-5
Date: Thu,  1 Oct 2026 22:13:31 -0500
Message-ID: <20261002031334.3285687-3-dennis@ausil.us>
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

The Orange Pi 5, 5B and 5 Pro schematics label the RK806 PLDO outputs
using the pattern VCC_*_S0 / VCCA_*_S0 / VDDA_*_S0. Rename the base
dtsi regulator labels (and the es8388 supply references) to match:

  pldo-reg1: avcc_1v8_s0 -> vcc_1v8_s0
  pldo-reg2: vcc_1v8_s0  -> vcca_1v8_s0
  pldo-reg3: avdd_1v2_s0 -> vdda_1v2_s0
  pldo-reg4: vcc_3v3_s0  -> vcca_3v3_s0

Also update the saradc vref-supply reference to track the pldo-reg1
rename. No functional change.

Signed-off-by: Dennis Gilmore <dennis@ausil.us>
Link: https://patch.msgid.link/20260511025352.106126-3-dennis@ausil.us
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: e3132dc1f4ebc9dd28ef9108f2aac84e5d4c5a15 ]

(cherry picked from commit eae11c5c68fda07dca1c855c129c5630408c1aa5)
Signed-off-by: Dennis Gilmore <dennis@ausil.us>
---
 .../arm64/rockchip/rk3588s-orangepi-5.dtsi    | 26 +++++++++----------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/dts/upstream/src/arm64/rockchip/rk3588s-orangepi-5.dtsi b/dts/upstream/src/arm64/rockchip/rk3588s-orangepi-5.dtsi
index dafad29f985..fd5c6a025cd 100644
--- a/dts/upstream/src/arm64/rockchip/rk3588s-orangepi-5.dtsi
+++ b/dts/upstream/src/arm64/rockchip/rk3588s-orangepi-5.dtsi
@@ -274,10 +274,10 @@
 		compatible = "everest,es8388", "everest,es8328";
 		reg = <0x10>;
 		clocks = <&cru I2S1_8CH_MCLKOUT>;
-		AVDD-supply = <&vcc_3v3_s0>;
-		DVDD-supply = <&vcc_1v8_s0>;
-		HPVDD-supply = <&vcc_3v3_s0>;
-		PVDD-supply = <&vcc_3v3_s0>;
+		AVDD-supply = <&vcca_3v3_s0>;
+		DVDD-supply = <&vcca_1v8_s0>;
+		HPVDD-supply = <&vcca_3v3_s0>;
+		PVDD-supply = <&vcca_3v3_s0>;
 		assigned-clocks = <&cru I2S1_8CH_MCLKOUT>;
 		assigned-clock-rates = <12288000>;
 		#sound-dai-cells = <0>;
@@ -441,7 +441,7 @@
 };
 
 &saradc {
-	vref-supply = <&avcc_1v8_s0>;
+	vref-supply = <&vcc_1v8_s0>;
 	status = "okay";
 };
 
@@ -666,8 +666,8 @@
 				};
 			};
 
-			avcc_1v8_s0: pldo-reg1 {
-				regulator-name = "avcc_1v8_s0";
+			vcc_1v8_s0: pldo-reg1 {
+				regulator-name = "vcc_1v8_s0";
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-min-microvolt = <1800000>;
@@ -678,8 +678,8 @@
 				};
 			};
 
-			vcc_1v8_s0: pldo-reg2 {
-				regulator-name = "vcc_1v8_s0";
+			vcca_1v8_s0: pldo-reg2 {
+				regulator-name = "vcca_1v8_s0";
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-min-microvolt = <1800000>;
@@ -691,8 +691,8 @@
 				};
 			};
 
-			avdd_1v2_s0: pldo-reg3 {
-				regulator-name = "avdd_1v2_s0";
+			vdda_1v2_s0: pldo-reg3 {
+				regulator-name = "vdda_1v2_s0";
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-min-microvolt = <1200000>;
@@ -703,8 +703,8 @@
 				};
 			};
 
-			vcc_3v3_s0: pldo-reg4 {
-				regulator-name = "vcc_3v3_s0";
+			vcca_3v3_s0: pldo-reg4 {
+				regulator-name = "vcca_3v3_s0";
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-min-microvolt = <3300000>;
-- 
2.55.0

