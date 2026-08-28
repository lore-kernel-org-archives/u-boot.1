Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9A94C61DB9
	for <u-boot@archiver.kernel.org>; Fri, 28 Aug 2026 10:52:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 02AC480F17;
	Fri, 28 Aug 2026 10:52:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5qpNDkiQIlFk; Fri, 28 Aug 2026 10:52:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787914347;
	bh=mkLW5UU7G6RrjDKudu8bgt/bjjOqIZoFtk7+m6e1XOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GKJjRdatc3FYxX4uQuSW/+QSM4ZMeILnRhqxTbrxuf34CVPogICP5Gm2Fp2OdcmWq
	 39bHdp9+p8glhxU44yRd0GcJFBXHq0CfBN+nfn3pdOxL3gnagxBqCZwxBMUsIbrCpU
	 Bk4EreCslsZ6+Gx8Sy8sB9z7c4xLsrDKQP1+zIhcGFVrHAJEn54cn/zjVRTENkqXmJ
	 ypmabc8VjQsXGU8lVyQb19Da49HsTV9epuuTWfJ12XR4j/YyVvqK/TH/Z0jYznXJ3G
	 KdbuI46PRdv/1gaahtgV/uycvD8fBfNKODBEzDgHmtpZHxSElJB7ZnovHWqdhAEZls
	 7DP0ShJDmmH1A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EAE5B80ED9;
	Fri, 28 Aug 2026 10:52:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 38FC0CBC
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 10:52:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 28D6D60708
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 10:52:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HhZSTmjSX7UV for <u-boot@lists.u-boot-project.org>;
 Fri, 28 Aug 2026 10:52:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=IfTdTChT
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 38DCB60705
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 10:52:20 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-49b0dd3c9a0so5633375e9.1
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 03:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787914339; x=1788519139;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mkLW5UU7G6RrjDKudu8bgt/bjjOqIZoFtk7+m6e1XOk=;
 b=IfTdTChTdv3e4ziheVommo/1ivC/TVcEgJ4H341tSTXme0bpHWaJkwGfCa26DujhHB
 8QhYtywV6m6uGXshxvI8RnbA85/0gttc42cTIliYJohpHzcXHe2inKPHTGBVH+3nGXfl
 DL1/EO1157uLAsgyDj3tPxOPuXsBF7iBnbQWLJqPP5eRsk9yzYJYqsW9JalA3D9I+q2Q
 bfFZQNhnwX1xjUGDYXyAxRG/4SQlOUXy2j4moZcvoWP8kGZOekNN5z3YdI7LnE7AfHrx
 hXKtNzk726+1anXWGyo9ZU3b7vuMwghzxVl/AzebG8yrFfye7SEevKvHrROOJCfraWFy
 dBxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787914339; x=1788519139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mkLW5UU7G6RrjDKudu8bgt/bjjOqIZoFtk7+m6e1XOk=;
 b=rXuP3uL1kUa0yHL+vnvNDiWDNh+asISaMooGa8cEHdduC0Eev3hWJMa9CtRdHZ79/x
 /QNjPQZsG2BgqGUiIz+v2TmrgD8tWEvliyOEYOa19ua3okNtzFD4Px30BGoJ1m7Qd5Re
 d7v0JS5IqNZuz/IlZ0Vr6aZE1OwoZXc9SNz5qEox9+q5fwGrkfF6kNwP5GMG+sJpcLrT
 e7dw6jMDvFpPvKyqGQUkbk6DdwQ83NCttABdEA+zsc5GRbysuWiwb2B6EXJVOruoGSJZ
 q9RkEq9KPNgADZeIX5NKqBsksBiedK/oNQ1XlHn0nfbNbHA8e2/GIJuY1u0qnOSVcdNk
 UpnQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RprX8QbaZ/RiJHtJPTFPWmp4Qk2eJLI9xznT1ev/0p+YiEkeJ5Ymjm9oOp/tN/n/uvqhVUdAlk=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nlxv9ObZw+NNw4xZQe+Ob6i33zD8vwZvb7JyXLi3RH8H/PnjUn
 r8aM+Kitz4SlgIZT2dwYIgzhKoC7bWX3hKK6rkKeaF6bBSuVHfZDrTgL
X-Gm-Gg: AR+sD10AyUgYmkQEyEhSle+EZm+VLc2QQiRgaT5UfsHo0YGBleNvF5E2MN3QJ3SCRzo
 /WAY9umVCOE8pO7um65gK7/ONzrumzbzneUiLIo17xWJVsL1xSlOJwnr25xNWQvE6gVP9BcIXKX
 ScuRLi2cEI5oKsLzzErlGC/O9y3nw9i23/uVCdqxHAyWqGwEgc2AUJE+tyHmXbybjONL71hKjkS
 OhXJZq3xAfsYwz09Zlz0KT1CxhItvw1bwfzGQuS5Q92C/0JjR4cWoh6A7jihlj9y/kKFrsuvAJH
 aJlWeY0BosFiilh5l0h+ST3iKTUvp46333L2/fk75fC/KG4IYCeQgb1v6MidXN3VTimz4vp1XLD
 iVi85TVvLr5dCX/37L7k3MPhdRVsdjBMuCUd4Lp5JgWGUZuPCtOhZSttBr7ve94Brx7/7/nzcLA
 VsYL5vJvhW7cRSnl+shLdTe4x/yBrt0BjnMPs9BCcbiRRbsgG4yZWBDHY8hBMMmodYKw==
X-Received: by 2002:a05:600c:1992:b0:499:593b:a15b with SMTP id
 5b1f17b1804b1-49b91c1fc56mr87139975e9.1.1787914338641; 
 Fri, 28 Aug 2026 03:52:18 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbab3f16sm3212202f8f.1.2026.08.28.03.52.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 03:52:17 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Vincent Jardin <vjardin@free.fr>,
 Ye Li <ye.li@nxp.com>, Michal Simek <michal.simek@amd.com>,
 Aristo Chen <aristo.chen@canonical.com>, u-boot@lists.u-boot-project.org,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Subject: [PATCH 4/4] test: dm: check the fixed regulator claims its GPIO at
 probe time
Date: Fri, 28 Aug 2026 12:52:10 +0200
Message-ID: <20260828105210.32664-5-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260828105210.32664-1-mehmet.fide@gmail.com>
References: <20260828105210.32664-1-mehmet.fide@gmail.com>
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

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

Give sandbox a fixed regulator with an enable GPIO and check the two
phases explicitly: after of_to_plat() the GPIO is still unclaimed, and
only probe() requests it and sets the direction; enabling and disabling
the regulator then moves the pin.

Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---
 arch/sandbox/dts/test.dts |  9 +++++++++
 test/dm/regulator.c       | 29 +++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index d24feec5422..19773305b4c 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -880,6 +880,15 @@
 		compatible = "sandbox,fpga";
 	};
 
+	fixed_gpio_reg: regulator-fixed {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-gpio-enabled";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		enable-active-high;
+		gpio = <&gpio_a 10>;
+	};
+
 	pinctrl-gpio {
 		compatible = "sandbox,pinctrl-gpio";
 
diff --git a/test/dm/regulator.c b/test/dm/regulator.c
index 51007d4079d..b78627023af 100644
--- a/test/dm/regulator.c
+++ b/test/dm/regulator.c
@@ -12,6 +12,7 @@
 #include <log.h>
 #include <malloc.h>
 #include <dm/device-internal.h>
+#include <asm/gpio.h>
 #include <dm/root.h>
 #include <dm/util.h>
 #include <dm/test.h>
@@ -195,6 +196,34 @@ static int dm_test_power_regulator_set_get_current(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_power_regulator_set_get_current, UTF_SCAN_FDT);
 
+/* The fixed regulator must claim its enable GPIO in probe, not before */
+static int dm_test_power_regulator_fixed_enable_gpio(struct unit_test_state *uts)
+{
+	struct gpio_desc chk;
+	struct udevice *dev;
+
+	ut_assertok(uclass_find_device_by_name(UCLASS_REGULATOR,
+					       "regulator-fixed", &dev));
+	ut_assertok(device_of_to_plat(dev));
+	ut_assertok(dm_gpio_lookup_name("a10", &chk));
+
+	/* reading the platform data must not have claimed the GPIO */
+	ut_asserteq(GPIOF_UNUSED, gpio_get_function(chk.dev, chk.offset,
+						    NULL));
+
+	ut_assertok(device_probe(dev));
+	ut_asserteq(GPIOF_OUTPUT, gpio_get_function(chk.dev, chk.offset,
+						    NULL));
+
+	ut_assertok(regulator_set_enable(dev, true));
+	ut_asserteq(1, sandbox_gpio_get_value(chk.dev, chk.offset));
+	ut_assertok(regulator_set_enable(dev, false));
+	ut_asserteq(0, sandbox_gpio_get_value(chk.dev, chk.offset));
+
+	return 0;
+}
+DM_TEST(dm_test_power_regulator_fixed_enable_gpio, UTF_SCAN_FDT);
+
 /* Test regulator set and get Enable method */
 static int dm_test_power_regulator_set_get_enable(struct unit_test_state *uts)
 {
-- 
2.54.0

