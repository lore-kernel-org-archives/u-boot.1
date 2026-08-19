Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56AE2C5DF85
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 04:52:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 860E340764;
	Wed, 19 Aug 2026 04:52:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6OUcet9Bw-up; Wed, 19 Aug 2026 04:52:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787115143;
	bh=W7cL21lX8JIoKprcVe0rIw71Y9TY9Flo3QzGYENJ0pk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dJAcELuI1QOV/OWwVJll92vbEj4fVzvkoyuUPDwvBfCa0NGAW2wKfqXrXQ9TV6FcF
	 lLF/v8UWHVtCEAjcr1sLsM2orxRfU2lkuvAo/8wI91AZaAroTEoW68r6Bzgg5fNOPR
	 LWV6crFuZqoXczRIJdotnRsCTAz2gmiakr/kPcdMFQNoQBx3+fb79wybOYWspt3myB
	 6AfpuZdLqIjCII7qfNKkK3GhHR9cIbQPZ6PlXi5/2PtqQI1FqWx1aPEmdxgwMZf+f/
	 TXPVoNIJCT6CtiYuobIKiLyMMfAHoNk8ICeE1RBuX1JhsRVwOcVdUmUwPVIdtCM4Lm
	 Gc8/xARn20oXg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5F15140674;
	Wed, 19 Aug 2026 04:52:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 11CBD1460
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 03:56:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EB9CC80E46
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 03:56:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Eq8nrX72q4xb for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 03:56:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=wdK5gjcI
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 273FF80DF4
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 03:56:23 +0000 (UTC)
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-383b4a3755fso623595a91.3
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 20:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1787111783; x=1787716583;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=W7cL21lX8JIoKprcVe0rIw71Y9TY9Flo3QzGYENJ0pk=;
 b=wdK5gjcIQA3nkUgfyHp+kknRF2bFGcBQ5czWaUj3Njx6m/nVuFBgJG0TfDaAIKM988
 VZyJoEHlaAsIiJyHUA1lZBa/CEWWe4eEw1HJjZTkT+BEDhmq9DqsrQEYVR3i7xPWoGTf
 gwewTFQWlQT0f59UkvkTP5oS+pQz2zLK7xKYPh/DYrAYJVi5mf1dYMrpfrNi4tt34bCR
 6kJT85tPQOzYB9JD9UoZq7rksdIneO7IGRipxlIdcXt3uWv/iRQSiWSZefBLQMsUtMNz
 IdgO16OpsaBr5/BHV/LFSj7SYYcoZOX8MX8ekku++o1PH323cq9XxgrWkcbkT5byAsWl
 U5ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787111783; x=1787716583;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=W7cL21lX8JIoKprcVe0rIw71Y9TY9Flo3QzGYENJ0pk=;
 b=IbxbSNaKiQKJdDuCxyPwmVt/wnXfPJmNI8dWY9yXxfvLtAMU6Ej9+0CKIW+ZRqB1/A
 5PdxAJT5Ouoch0wfAMNT+/tR4aNdEvXds4QqIttPbzLlY+NboxMYPsu5OQGkWsAfdVp8
 7gFbSV58rxO1WCehZJxGAtfMqmm2LqB0HEXc5rphd7hAXmh0qtbfPZd0FXBnV3kjAfmV
 NiGi/5iMpxEfy2TqdvFtMDZdUD6ZM8IxrybcwYi9thm13w00XqKBP7aQmQ3vZpiG2q+a
 MloB8ciPabiZnJEEveqTMyqQyxvKh3bA0OPvy7c3qS1kNnFCVOE2AAH8NNqzUy55QwxY
 2mXg==
X-Forwarded-Encrypted: i=1;
 AHgh+RquoPIBXI+lHsSrVVzWthvomZ6JvwPEQHlTXqph9YghSqYb6U9nWZS8/sfnKgXVeWeeAbQ3smI=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yyah9Vkf5osHV/eU4D9WMK7imZXMFvg4DHGccz92ydjRcpoZbpn
 flnT0sZ4MJlTgmmPCG9wpL5sOJKTFQtGx8O64UfFkGJTDZdYLrW1xRivMMXSEWD9z+s=
X-Gm-Gg: AR+sD10b1Bg4Z8SGs7axVx9YCUvMF5Ih2rSRVZgWvFIi4U+feU+BMumsopWaS8BLMSm
 hFYST6X8T2Nfsmz59aN12Z9On7IHBprQNZzczbk1CqRyxroC6e7XgPAIjnJWM+JI6Zs4uW8AOwd
 MJ+Z3XNOupqw0juct0MgAx5C1xoQNY9ncSqZBBadYs3dRfuLVk0OTgWI5GtBUbVGt7yiWqC/0OY
 sfRIl7UVBjnE6uOK4LfVPhe7egBwLeUR0Z5CqhucelqhMpNpLlGjQXvebsaOIJsJ6HcrnLoWXeg
 DRs1kgGO/hAQoVJ/fe/dsoFsgGDk56Oyv26VwR1ZefDIVCzhPCJwi/WXCrtxEKAu9W+VCUZudd+
 j64y6btCoX7i1WxrqE18M8KF+BjupO5Q8ZKvzJCZYgEs5ju7TwDAb03XeUt/DI9IF0TJ7JJgU9X
 j/EeD5ai41O9Cz2SVWDnFX1NWL72FL9TkL49dGqIGRo9G+KO8DjnsARkMS0lncew8rpVl1naUHf
 C5Fgym3TkO9VBAK5APg55ioDHBSmtTV0pI0iY0aJfolgMd9Qp2UCTpz4X3aNWXwH6i0dRiOggF/
 1GEVWbFxQwPdhgNjVCSXBLhNDg==
X-Received: by 2002:a17:90b:3c07:b0:395:543a:cf3b with SMTP id
 98e67ed59e1d1-39580a533bfmr3344064a91.2.1787111783321; 
 Tue, 18 Aug 2026 20:56:23 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad53874sm2912408c88.4.2026.08.18.20.56.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 20:56:22 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Wed, 19 Aug 2026 11:54:49 +0800
Subject: [PATCH v9 07/19] riscv: dts: spacemit: k1-bananapi-f3: add SD card
 support with UHS modes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-m4-v9-7-6e66016392b9@riscstar.com>
References: <20260819-m4-v9-0-6e66016392b9@riscstar.com>
In-Reply-To: <20260819-m4-v9-0-6e66016392b9@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Peng Fan <peng.fan@nxp.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, Han Xu <han.xu@nxp.com>, 
 Yanir Levin <yanir.levin@tandemg.com>, 
 Christoph Stoidner <c.stoidner@phytec.de>, 
 Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>, 
 Daniel Palmer <daniel@thingy.jp>, Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Guodong Xu <guodong@riscstar.com>, Yao Zi <me@ziyao.cc>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Eric Chung <eric.chung@riscstar.com>, Iker Pedrosa <ikerpedrosam@gmail.com>, 
 Anand Moon <linux.amoon@gmail.com>, 
 Margherita Milani <margherita.milani@amarulasolutions.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Wed, 19 Aug 2026 04:52:19 +0000
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

From: Iker Pedrosa <ikerpedrosam@gmail.com>

Add complete SD card controller support with UHS high-speed modes.

- Enable sdhci0 controller with 4-bit bus width
- Configure card detect GPIO with GPIO_ACTIVE_LOW and internal pull-up
  support
- Connect vmmc-supply to buck4 for 3.3V card power
- Connect vqmmc-supply to aldo1 for 1.8V/3.3V I/O switching
- Add dual pinctrl states for voltage-dependent pin configuration
- Support UHS-I SDR25, SDR50, and SDR104 modes
- Add stable MMC device aliases (mmc0 = eMMC, mmc1 = SD card)

This enables full SD card functionality including high-speed UHS modes
for improved performance.

Suggested-by: Anand Moon <linux.amoon@gmail.com>
Tested-by: Anand Moon <linux.amoon@gmail.com>
Tested-by: Margherita Milani <margherita.milani@amarulasolutions.com>
Tested-by: Aurelien Jarno <aurelien@aurel32.net>
Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
Link: https://patch.msgid.link/20260515-orangepi-sd-card-uhs-v10-3-094af27e310d@gmail.com
Signed-off-by: Yixun Lan <dlan@kernel.org>

[ upstream commit: c76e2f058cbcab84e4a703f26857a58bdf6a0042 ]

(cherry picked from commit 3efd965004f1604c204001dcead9a44f729d5d58)
---
 dts/upstream/src/riscv/spacemit/k1-bananapi-f3.dts | 24 ++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/dts/upstream/src/riscv/spacemit/k1-bananapi-f3.dts b/dts/upstream/src/riscv/spacemit/k1-bananapi-f3.dts
index 9429189354d6..9beb8947f12c 100644
--- a/dts/upstream/src/riscv/spacemit/k1-bananapi-f3.dts
+++ b/dts/upstream/src/riscv/spacemit/k1-bananapi-f3.dts
@@ -17,6 +17,8 @@
 		spi3 = &spi3;
 		i2c2 = &i2c2;
 		i2c8 = &i2c8;
+		mmc0 = &emmc;
+		mmc1 = &sdhci0;
 	};
 
 	chosen {
@@ -221,7 +223,7 @@
 				regulator-always-on;
 			};
 
-			buck4 {
+			buck4: buck4 {
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-ramp-delay = <5000>;
@@ -242,7 +244,7 @@
 				regulator-always-on;
 			};
 
-			aldo1 {
+			aldo1: aldo1 {
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <3400000>;
 				regulator-boot-on;
@@ -374,3 +376,21 @@
 		reset-gpios = <&gpio K1_GPIO(124) GPIO_ACTIVE_LOW>;
 	};
 };
+
+&sdhci0 {
+	pinctrl-names = "default", "uhs";
+	pinctrl-0 = <&mmc1_cfg>;
+	pinctrl-1 = <&mmc1_uhs_cfg>;
+	bus-width = <4>;
+	cd-gpios = <&gpio K1_GPIO(80) (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
+	no-mmc;
+	no-sdio;
+	disable-wp;
+	cap-sd-highspeed;
+	vmmc-supply = <&buck4>;
+	vqmmc-supply = <&aldo1>;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	status = "okay";
+};

-- 
2.51.0

