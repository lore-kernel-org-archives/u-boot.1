Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D06CC2BA18
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 17:54:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7BE18845A;
	Sun, 23 Jun 2024 19:53:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ht6buAkJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DED7388387; Sun, 23 Jun 2024 19:53:29 +0200 (CEST)
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com
 [IPv6:2607:f8b0:4864:20::141])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95DA588535
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 19:53:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x141.google.com with SMTP id
 e9e14a558f8ab-3762c172d9aso12451205ab.2
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 10:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719165206; x=1719770006; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A6d6Au1EjTcFyCj48QfjSy1CLH2vHtoyvSNInjPJf5g=;
 b=ht6buAkJpSZjQfAnfjpNJ9b2+9LWnfH17xDKFPqO3n7DaOAQnHd9rTqArTnJQj0gTk
 BwckmcA6nLUqFUMJVrwGhCKsQXk46/2J8YvxPNwwp4/aZmyMHZS0sQkVsPMbKKr5IALV
 qjswrO9w4aepMGSgctFh4ZR3nP8DsTUTWMEU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719165206; x=1719770006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A6d6Au1EjTcFyCj48QfjSy1CLH2vHtoyvSNInjPJf5g=;
 b=Zu9lYlbYX0Jweb4NVTO3cV5NeYgw2y0w2XX39Qt/jgdTaJaiJCuDtKcZaxlvn4HUsa
 NcDifHX4JGrOzh3VUsoDlwPaOgiVrO4IuLFtOhAncFrl8xvNY9c9kVkA60DUDpAYJQ2d
 6sMCY5K1loipOhNmKmYogmkFWT3KbTYjayzZl6DRC+9LQlxUhE/wpOiHtfpa9N25qCeN
 /zsN4+sneZZDyhkA7f6462wcwhvdkqWsqW1CY0Rx7tsWfK6+hQ9wn7GY2T9C4RH/hlhA
 YxtUmLIKP8LLzS65H++IkMCcPL1ECcJtLFOX7Gubnww3W0Zj/ILYAX866XiPQAyAhhyk
 v4fg==
X-Gm-Message-State: AOJu0YwEwdgHcutXTLSKwik4RaSMHPnD6Fpb43UTkb/JBnjySbLWZy3Q
 TaTnx2nzKeY+LAHla+9rgYE7wxi5FfwOaGUrxSkL9mGja1yXTKqnSbZgF2yPZK12o3kpQCoc9Em
 dBbmK
X-Google-Smtp-Source: AGHT+IEIVir4ACYVRB77w5jBT9TTL2EXJpqPQko4MLZ0HIljt2RuBoXEEDmZnu4qqhzFTTbU3RWWwg==
X-Received: by 2002:a05:6602:158e:b0:7eb:eeba:5e90 with SMTP id
 ca18e2360f4ac-7f3a75e2cc8mr314060739f.18.1719165206128; 
 Sun, 23 Jun 2024 10:53:26 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4b9d113ff85sm1636834173.81.2024.06.23.10.53.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 10:53:25 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>, huang lin <hl@rock-chips.com>
Subject: [PATCH v4 09/16] rockchip: veyron: Add logging for power init
Date: Sun, 23 Jun 2024 11:52:55 -0600
Message-Id: <20240623175302.1463973-10-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240623175302.1463973-1-sjg@chromium.org>
References: <20240623175302.1463973-1-sjg@chromium.org>
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

