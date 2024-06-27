Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A8DEC2BD09
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 08:30:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46DA38856B;
	Thu, 27 Jun 2024 10:30:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="T7q2zq67";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4430288579; Thu, 27 Jun 2024 10:30:01 +0200 (CEST)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59C7C8855E
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 10:29:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x442.google.com with SMTP id
 ffacd0b85a97d-36742cc9c12so342812f8f.2
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 01:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719476998; x=1720081798; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A6d6Au1EjTcFyCj48QfjSy1CLH2vHtoyvSNInjPJf5g=;
 b=T7q2zq67rNUUR7EqTgylXjonDFE3dBt71nXhLC0cGyjfvIWzQoBUCHfhtuWXUg08MK
 0pJtNiASswRL57hCtu9ZtG4SvX2Le43no+hpqOuLQlECbhRPS/9LKD8Tf2jF6I2iZabS
 XMJD2Pka95C8l+Rla93OaylltNkZHZxBaWLIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719476998; x=1720081798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A6d6Au1EjTcFyCj48QfjSy1CLH2vHtoyvSNInjPJf5g=;
 b=wqn7AjmVsO+NnmC2F9VHnlUMFgTW/ILCJeViqWOusUiRx4Jik2/b4zKLYuFew1mjaP
 ewN9V+FKbAu8g/AdS9LCFBC1Y6QJ0tqaFF8DOoYRf5NlOyliyOtYJZ4dPfA0HkLs7rac
 5xV7b3/EpFxknoMee5ZFEA+Td5N5TtxW16CEiR5InC0zrh6rJrOaKCO7RDe9gi0nd1+/
 LtXgpXuXqU+kS+6lsZILLOTb9lTTwW5EG9/N3Mv+ujPxAaeIAual1oxw+5YlKdKHbIeX
 qDhnVEvltbnCbUje9CBB9uyHh9DRojm8cvvdHXS38KT+Mez4S2cVsn+Gm3rJc5CDGwl6
 64Bg==
X-Gm-Message-State: AOJu0Yze+KB2B+wEt/4AoGb3d9wtP5Z5RxK+6zsTXjOA7Ygv4+SJb9rA
 BaVLlyay1GFCBX3ro7nltJM26xUsRvmnI9lkXnmHRd2aaM1SpJf0QFnkH0bmaKSgUDr7haHdl41
 0rj6o
X-Google-Smtp-Source: AGHT+IEGP4CA2+hYeLkTxC+TUnS2A98lEpnhGQNKPtGQeapDFTvODvcYEDCx8H4jT/n6ij0gFSzLjQ==
X-Received: by 2002:adf:e50e:0:b0:360:88bc:644b with SMTP id
 ffacd0b85a97d-366e96442fbmr7605177f8f.58.1719476998607; 
 Thu, 27 Jun 2024 01:29:58 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3674357c1c8sm1106534f8f.9.2024.06.27.01.29.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 01:29:58 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Jeffy Chen <jeffy.chen@rock-chips.com>, huang lin <hl@rock-chips.com>
Subject: [PATCH v6 4/8] rockchip: veyron: Add logging for power init
Date: Thu, 27 Jun 2024 09:29:45 +0100
Message-Id: <20240627082949.357089-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240627082949.357089-1-sjg@chromium.org>
References: <20240627082949.357089-1-sjg@chromium.org>
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

Add better logging for power init so that CONFIG_LOG_ERROR_RETURN can
be enabled.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---

(no changes since v2)

Changes in v2:
- Remove the superfluous if() and drop the debug() as well

 board/google/veyron/veyron.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/board/google/veyron/veyron.c b/board/google/veyron/veyron.c
index 32dbcdc4d10..6d4c9debdee 100644
--- a/board/google/veyron/veyron.c
+++ b/board/google/veyron/veyron.c
@@ -29,44 +29,38 @@ static int veyron_init(void)
 	int ret;
 
 	ret = regulator_get_by_platname("vdd_arm", &dev);
-	if (ret) {
-		debug("Cannot set regulator name\n");
-		return ret;
-	}
+	if (ret)
+		return log_msg_ret("vdd", ret);
 
 	/* Slowly raise to max CPU voltage to prevent overshoot */
 	ret = regulator_set_value(dev, 1200000);
 	if (ret)
-		return ret;
+		return log_msg_ret("s12", ret);
 	udelay(175); /* Must wait for voltage to stabilize, 2mV/us */
 	ret = regulator_set_value(dev, 1400000);
 	if (ret)
-		return ret;
+		return log_msg_ret("s14", ret);
 	udelay(100); /* Must wait for voltage to stabilize, 2mV/us */
 
 	ret = rockchip_get_clk(&clk.dev);
 	if (ret)
-		return ret;
+		return log_msg_ret("clk", ret);
 	clk.id = PLL_APLL;
 	ret = clk_set_rate(&clk, 1800000000);
 	if (IS_ERR_VALUE(ret))
-		return ret;
+		return log_msg_ret("s18", ret);
 
 	ret = regulator_get_by_platname("vcc33_sd", &dev);
-	if (ret) {
-		debug("Cannot get regulator name\n");
-		return ret;
-	}
+	if (ret)
+		return log_msg_ret("vcc", ret);
 
 	ret = regulator_set_value(dev, 3300000);
 	if (ret)
-		return ret;
+		return log_msg_ret("s33", ret);
 
 	ret = regulators_enable_boot_on(false);
-	if (ret) {
-		debug("%s: Cannot enable boot on regulators\n", __func__);
-		return ret;
-	}
+	if (ret)
+		return log_msg_ret("boo", ret);
 
 	return 0;
 }
@@ -81,7 +75,7 @@ int board_early_init_r(void)
 	if (!fdt_node_check_compatible(gd->fdt_blob, 0, "google,veyron")) {
 		ret = veyron_init();
 		if (ret)
-			return ret;
+			return log_msg_ret("vey", ret);
 	}
 #endif
 	/*
-- 
2.34.1

