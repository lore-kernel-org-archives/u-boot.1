Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75D24C25B47
	for <u-boot@archiver.kernel.org>; Fri, 27 Oct 2023 08:26:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD10A87C18;
	Fri, 27 Oct 2023 10:26:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B6e7xxFK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49A8887C18; Fri, 27 Oct 2023 10:26:33 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C230E87C10
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 10:26:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-50797cf5b69so2525519e87.2
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 01:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698395190; x=1698999990; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KnuJzyttXdYOO/Y5QuViyNLB5skqt6xD/FB7G0SDNwU=;
 b=B6e7xxFKKVoNBfKKx8ZYY6kpcNY36n8z3EdVKJsfh+0VcbHdFvTRuwGVq+66lO6rkG
 udZgmR5138hbu0Z4AXJQhkZb/Orxf5q94ttFn8LHFNptkQokM1gF151SzRcBinoLKvvt
 4qv/1wAgsi2uV7ltgTfb0sTh45zwXu1m98qZ4xFHnJ/h9mzNonMNmDp3akVeKyP+ecJo
 N9VDf91ey/KQqGHRrhaKQ0Hxc0pZ2KXS63zXgBMx1JFmAByyU6STDnkbRT4yUckFxJsy
 4FqSO+iKZlownytPRC3ZSE14mNqNeadGeegciBhglewM0ZPD5N52wp27scq3iwwcEW9g
 0btw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698395190; x=1698999990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KnuJzyttXdYOO/Y5QuViyNLB5skqt6xD/FB7G0SDNwU=;
 b=N2vod2lNt/LI3h1pgVX73M2ij3lw4blpMag+nVz7YltM7BcV2v2ZaAX9BvjQ/e6TWX
 MOH9gfl7OuTs7kpom4K2zSP5WZ0j12Wp3U2fAFLmp+0rR1GK4VZRAlFbJI5NbAapXnbY
 Y4kKLYAZE5M8XHku4nw6PrM+QB/TAw5n4nm1ugZ9WB1I93ML6HcDlw9XdkXxtZgHiOYu
 /vaLgmQS99mFgpRhhG24Roev7G87oSRQ0+Tl+zKkVEUeArhtfTwjhCR//dlWUh/V/muK
 md14E6zG7OxUF0NM8sexap1SQDieDtNLic1GcGLVNesLQ0GoU2POs+75597Yd1y7fQ9c
 lbBg==
X-Gm-Message-State: AOJu0YyzlOebt7lMWp1r3KNjepx5xPutUB5oyWVM5VlTQ7Pf9tnkbHZN
 5uiOQzDlhBPRPI7tW4aKYEw=
X-Google-Smtp-Source: AGHT+IHB4bIpN03Yv4B8ZIAiacZmXbsuNKcgvHix2ANM36Jpl6jxjl/IvaPZoP2uKQRxOPkVGvyfWg==
X-Received: by 2002:a05:6512:1046:b0:503:9c2:e44e with SMTP id
 c6-20020a056512104600b0050309c2e44emr1599675lfb.55.1698395189872; 
 Fri, 27 Oct 2023 01:26:29 -0700 (PDT)
Received: from xeon.. ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 u15-20020ac248af000000b004fdd6b72bfdsm183445lfg.117.2023.10.27.01.26.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 01:26:29 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v9 2/8] power: regulator: palmas: fix ldoln and ldousb
 detection
Date: Fri, 27 Oct 2023 11:26:09 +0300
Message-Id: <20231027082615.306943-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231027082615.306943-1-clamor95@gmail.com>
References: <20231027082615.306943-1-clamor95@gmail.com>
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

dev->driver_data will carry the tail of ldo if there is a number and
if there is no number it will be an error code, anyway it will not be
zero. This results in a wrong ldo regulator detection.

To avoid this check for non-numerical ldo first and then manipulate
dev->driver_data.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/power/regulator/palmas_regulator.c | 24 +++++++++++++---------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/power/regulator/palmas_regulator.c b/drivers/power/regulator/palmas_regulator.c
index 3c4eb83be7..d615e94734 100644
--- a/drivers/power/regulator/palmas_regulator.c
+++ b/drivers/power/regulator/palmas_regulator.c
@@ -301,19 +301,23 @@ static int palmas_ldo_probe(struct udevice *dev)
 
 	uc_pdata->type = REGULATOR_TYPE_LDO;
 
-	if (dev->driver_data) {
+	/* check for ldoln and ldousb cases */
+	if (!strcmp("ldoln", dev->name)) {
+		uc_pdata->ctrl_reg = palmas_ldo_ctrl[type][9];
+		uc_pdata->volt_reg = palmas_ldo_volt[type][9];
+		return 0;
+	}
+
+	if (!strcmp("ldousb", dev->name)) {
+		uc_pdata->ctrl_reg = palmas_ldo_ctrl[type][10];
+		uc_pdata->volt_reg = palmas_ldo_volt[type][10];
+		return 0;
+	}
+
+	if (dev->driver_data > 0) {
 		u8 idx = dev->driver_data - 1;
 		uc_pdata->ctrl_reg = palmas_ldo_ctrl[type][idx];
 		uc_pdata->volt_reg = palmas_ldo_volt[type][idx];
-	} else {
-		/* check for ldoln and ldousb cases */
-		if (!strcmp("ldoln", dev->name)) {
-			uc_pdata->ctrl_reg = palmas_ldo_ctrl[type][9];
-			uc_pdata->volt_reg = palmas_ldo_volt[type][9];
-		} else if (!strcmp("ldousb", dev->name)) {
-			uc_pdata->ctrl_reg = palmas_ldo_ctrl[type][10];
-			uc_pdata->volt_reg = palmas_ldo_volt[type][10];
-		}
 	}
 
 	return 0;
-- 
2.39.2

