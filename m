Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D4EC43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 19:02:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E98784BF4;
	Fri, 10 Jul 2026 20:59:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="GzLNTiJR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61D4184BC6; Fri, 10 Jul 2026 20:59:44 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50C608407E
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 20:59:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-44868d6a066so373285fac.3
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 11:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783709981; x=1784314781; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+9/q/4xqys1tPKc/trzQtN51NctBGdrVnwa9PDYgJ+o=;
 b=GzLNTiJRyAHGiPQZIY2Qw0UYyn4E+B5PiQv5VZvPmwiruMnkNLlQVPORC5jwejANOb
 83KUJ14U6mJTHBv51rMdx4o0pAaQ2NmmYv/hEEki/AUSGrs3BaEN3Lk3/DbkF53Xe0NP
 1t4kXwdDEiq05n+hojmgnfrsyG5hIeSWjSeTDVN1Ck1xboPiHawGxW4cuVsIYLaIbEB+
 +Mryprp6WxSmfwoymlWNJ8pbGEc9pLns+QF7XwuKLwMJnGHZKAmiI3G/l5rjT+dL05fQ
 TzDmR7EMU4rxkNLpuAgApNbSOvGk6eGVA7Z0SNGXABqx2USC3/vlhL5BEfOK9PEwUkGd
 7icQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783709981; x=1784314781;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+9/q/4xqys1tPKc/trzQtN51NctBGdrVnwa9PDYgJ+o=;
 b=iHvjqh997HBDTGW1niMs5mA+WSRmsAiNyxd0KVhtfSjZjPEOzhmUCTRFiwMnfK98W5
 T4SxdQI6EKWc5kCTkok6RPz+EX6H+9LO7kAyrDcnShJcFHWYp+VMC7RXP1naSDtsJmvu
 4uUfOpv3u2E1Ahy7i/dYppCDL2PXxbLi9xoQNhTeAhpHt7Kh7M/2Hi04G0uJ3yDspv7j
 SvxH5vSuDjufofHWH1kIuY0vV09k8nOc0sNEMyLep9EFPoGeV05sQ+K3mxtnMvLkFpRI
 +IK5C0XRbz07hyChHOWcf5XTvNS1osRLuYG7E7rw+QspgoIwOspsyIHkI3ZVfMxeS/75
 5o8A==
X-Gm-Message-State: AOJu0YxAlzdinQeP4InaJJkVMQiH6Y8IKuWCmJaEODvkA2JZdmkqvHK+
 nhRjeMZ6VrzI6kCjgTikA1l+cRYbpiHAxR+xv55Blh4j8yUMjaG6aYAPVG3zLBUBrrhUjQBpHqZ
 je8TU
X-Gm-Gg: AfdE7cnvBTiAvehe7pBJw7Qva/kXRjeg7Sk+6Dm9PMJLY/rnhuOCqhvwX0ItM4PGg2f
 RBOKdesZ8s++/0lxRx1d9Q5xFNITkpimuTAKh/egtpAXoNxO9wpMPf18Brmlx1S3P3KBzubQSDD
 8Nn0Q87Pv1aWUHnzv43IsOxPIn5LQoH87d/4VEPAiyHF33Rrh0JTcsIhbPT7YAh71QeaDkNejeJ
 b8LCvEiMYdfgdDoKQ92L5p5OXVKOurJhij2F2MDypdpL4x45XApEoBjXgZ2JuH9YCpEmFJx5W0M
 GgFHso+iZ2pogxuPwy5PuqGskKkmoBcjl/WHxK5OrVi9Yihc5FL+Pi92eNha0nXbsNluCxvhu52
 +cPXz8oOiId/WUgbyk3Gde7Y+m1ZygpVq+khBiBQjDcWhpC8D4r4cA0EnOjeWjjqG4xUO/mPwUr
 MYlrwrU8nCvFeUSkbm+PioVI88DRA=
X-Received: by 2002:a05:6871:2301:b0:451:b3d9:c75 with SMTP id
 586e51a60fabf-451f14e38e4mr105811fac.38.1783709981065; 
 Fri, 10 Jul 2026 11:59:41 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:1b03:95c:fbd4:4d00])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-451916f31d4sm5789657fac.16.2026.07.10.11.59.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 11:59:40 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 10 Jul 2026 13:56:37 -0500
Subject: [PATCH v2 21/24] arm: dts: mt7981: remove clock-parent properties
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-mtk-clk-parent-lookup-improvements-v2-21-f3f3a4a28dca@baylibre.com>
References: <20260710-mtk-clk-parent-lookup-improvements-v2-0-f3f3a4a28dca@baylibre.com>
In-Reply-To: <20260710-mtk-clk-parent-lookup-improvements-v2-0-f3f3a4a28dca@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1120; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=D4xk6d9IfOkXCYVFQYhiaekbmaPi6vt85LMoERhg010=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqUUDi9BWv2qhVnsPQEgB4vdxRMsodB9p1CYU3L
 rgBMbqoXESJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCalFA4hYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A6a8IAJbFllLUaMqmZYVeaZ3IJa9H4pWOqQ+IqZSsGnj
 yYusASOASqzt09moAKwYZ55p6SjCnzxBC+QkabDOjEiF6NaMV/NiXSJnpxbXQOuDfgY6AmSKjHX
 I8YFx1Z5k/fvbTBcSRowlipat4RCLCQzwtsxkAHtFGUJiR8+MTCMGfzZyNfpfapiBVc9Q9Rf7wI
 Pipzu2bbzS+mqG6/kOaYwFJo132HjcKgyXn3F8j+bbe6LaR9WrDveLM1QzQKJ2Bd+lBUofwqTIe
 XoYVlGz6NyPvrOu92feqExhbcfVix2pZhfU7ICJNPoEvbFq6V4GkZtebbGNCO/gYaJ2zZ+0vyXA
 D/To=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Remove all clock-parent properties from mt7981.dtsi. The clock driver
for this no longer uses this property. And this property would not be
acceptable upstream anyway.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/dts/mt7981.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/dts/mt7981.dtsi b/arch/arm/dts/mt7981.dtsi
index 5b4cadc22f7..675b14a0b7e 100644
--- a/arch/arm/dts/mt7981.dtsi
+++ b/arch/arm/dts/mt7981.dtsi
@@ -94,7 +94,6 @@
 	topckgen: topckgen@1001b000 {
 		compatible = "mediatek,mt7981-topckgen";
 		reg = <0x1001b000 0x1000>;
-		clock-parent = <&fixed_plls>;
 		#clock-cells = <1>;
 		bootph-all;
 	};
@@ -102,7 +101,6 @@
 	infracfg: infracfg@10001000 {
 		compatible = "mediatek,mt7981-infracfg";
 		reg = <0x10001000 0x30>;
-		clock-parent = <&topckgen>;
 		#clock-cells = <1>;
 		bootph-all;
 	};
@@ -221,7 +219,6 @@
 	ethsys: syscon@15000000 {
 		compatible = "mediatek,mt7981-ethsys", "syscon";
 		reg = <0x15000000 0x1000>;
-		clock-parent = <&topckgen>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
 	};

-- 
2.43.0

