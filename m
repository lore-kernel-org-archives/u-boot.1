Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E86C2BA18
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 23:09:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D590188569;
	Fri, 21 Jun 2024 01:06:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Hp8SVGOh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B8E987E13; Fri, 21 Jun 2024 01:06:50 +0200 (CEST)
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com
 [IPv6:2607:f8b0:4864:20::d41])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF94387B77
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 01:06:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd41.google.com with SMTP id
 ca18e2360f4ac-7ebe019b9cdso51284939f.0
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 16:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718924806; x=1719529606; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A6d6Au1EjTcFyCj48QfjSy1CLH2vHtoyvSNInjPJf5g=;
 b=Hp8SVGOhpo/hqzdbkWukpUr1ylMJ9ST0gZCHE6dni2zKzZmdVjcK9pxansvNP0Hd0G
 i4i1n5USa2ieIC4h5JdHXEMgAsSwloRQBvNOK6w0ynaiq/oOju+S7NsoQAygOU5tPOBf
 MXg4FoWGMjwroIlETClWH9DRDAK0wwKTpE7/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718924806; x=1719529606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A6d6Au1EjTcFyCj48QfjSy1CLH2vHtoyvSNInjPJf5g=;
 b=U5J1Vt/xzc+DaaFtjLZmRR7biaNve5jAhoaLbC5hlNs02fj3GvopHv4RXwN3bWW8Ms
 mFYWxqMrUzUeG/DEISQ8Crs2P7ibXxiXBWDikrc5uQRk9Vys2pQz/cHO5KtGWfEqKrYC
 9yY9BUihB8HSqz9nzUxJjdlw8wYOEDvBJA9TXaCsBVsXGVPQmQy0lVPhUWMTCXG3BAOM
 rTXCpQUFdU/m/oaZANWMHy/pG7cAbGwMZs/cwywOLfdyvzPtyqNJjDTQSDd/a9gCu+GG
 PjgLDcZVWjm4nax9sD8rFt2Oze0J5Z9a/OWF+BNW3k1yITUJp2WAR8N2kji+wfD7A4JJ
 LsIA==
X-Gm-Message-State: AOJu0YzJleIHvRW0tJwoiVqenIf7xdztjEjpzDGUqa1sAUgrWxWIYJsN
 JuoEFYRc6bKYB2j7Y3Dak0GH5jjhScn1t/7gyo8F3DDZ3zoJmb4BGqFTJq5RT50LjYJrP/JW9MW
 GLMn9
X-Google-Smtp-Source: AGHT+IHxFxB5cf4sOZjtWZRdYfpgsrbWr5vyLcxUAWHl6MOjecFLr+P/qTd3/zj7hyTTdPrj0hneMw==
X-Received: by 2002:a05:6602:3429:b0:7eb:708a:3264 with SMTP id
 ca18e2360f4ac-7f13ee0f2cfmr718115539f.10.1718924806574; 
 Thu, 20 Jun 2024 16:06:46 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4b9d110f566sm53269173.44.2024.06.20.16.06.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 16:06:46 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>, huang lin <hl@rock-chips.com>
Subject: [PATCH v3 11/18] rockchip: veyron: Add logging for power init
Date: Thu, 20 Jun 2024 17:06:18 -0600
Message-Id: <20240620230625.1797397-12-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620230625.1797397-1-sjg@chromium.org>
References: <20240620230625.1797397-1-sjg@chromium.org>
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

