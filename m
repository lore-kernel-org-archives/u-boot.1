Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66EF5C27C4F
	for <u-boot@archiver.kernel.org>; Wed, 26 Jun 2024 16:02:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8014E8857F;
	Wed, 26 Jun 2024 18:00:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="P27chEEv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4EA1884C7; Wed, 26 Jun 2024 18:00:15 +0200 (CEST)
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com
 [IPv6:2a00:1450:4864:20::144])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAAB288566
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 18:00:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x144.google.com with SMTP id
 2adb3069b0e04-52cdea1387eso4618716e87.0
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 09:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719417612; x=1720022412; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A6d6Au1EjTcFyCj48QfjSy1CLH2vHtoyvSNInjPJf5g=;
 b=P27chEEvlEx/KwpRCjlj+QoEoYI+LzUBQiJE/FtGR1yfgfgeDu1mm73MUK5lJZYK7A
 YFo1fruY7a1KgcG3FCCknJux9LQyglDeWoJnYQp7fby3CWwfMCFE5++JBt2800Sk0pRC
 cUDm10MBCBhQ5VGadrY6RiIZS26r7f8ce1AGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719417612; x=1720022412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A6d6Au1EjTcFyCj48QfjSy1CLH2vHtoyvSNInjPJf5g=;
 b=cSW8cTrqBZuwxs1WMYc8ACZde/DnnSMWertFjLMwElhW3yC3M83Fu/+4jtCgXxBZGG
 2s0mc7xxg4vU287zE3BUiOTPPNlXcHT5vA2MtmjqRfpk0VfmluAE4VMS/kcBmbThHVpg
 RtBK36FfQkzrNfN3U3cYYWXZUnBLgQdwzzbK2GoCK7V2U6BL215J4zfgbSECpL9jqjkc
 fh2fvnVI/X3VzCtM6jIll9TT2oKEZANPHHzmNQckz6zeclw5BYdN7CHpxf3G8LLNB2EQ
 3QJguwD7VApPx002wCyjOb2o60n38vwkP/P4P78DC3gzkS3zmoW1MPcATlL9Z4MWYd3g
 jVVg==
X-Gm-Message-State: AOJu0YwvW6XqXsEMkN3xnqbvNS1oEb8xrKI+86DD6X+m5oHxMIPkmshf
 3m4CSHViqrrkwgole0UVlhY8oaQQZVGaUcfLi8pkZy9USiCM1tjp7SI3DS21B2vTmjQQ0e9zSs3
 sQvo4
X-Google-Smtp-Source: AGHT+IEKhV77uOqtHqRllFWFvxvqeYepdW6CpeM+Xx1zTz6n0HN9gzJ0pFnWAYqCrrcLmSpRDZ7M3Q==
X-Received: by 2002:ac2:5299:0:b0:52c:c9ce:be8d with SMTP id
 2adb3069b0e04-52ce186482cmr7048305e87.57.1719417611970; 
 Wed, 26 Jun 2024 09:00:11 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424c827507bsm30753715e9.22.2024.06.26.09.00.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 09:00:11 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Jeffy Chen <jeffy.chen@rock-chips.com>, huang lin <hl@rock-chips.com>
Subject: [PATCH v5 09/16] rockchip: veyron: Add logging for power init
Date: Wed, 26 Jun 2024 16:59:38 +0100
Message-Id: <20240626155945.278640-10-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626155945.278640-1-sjg@chromium.org>
References: <20240626155945.278640-1-sjg@chromium.org>
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

