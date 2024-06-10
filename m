Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 366A2C27C5E
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 15:00:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F028885D2;
	Mon, 10 Jun 2024 16:59:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IHJEAP9w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07E40885AE; Mon, 10 Jun 2024 16:59:43 +0200 (CEST)
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com
 [IPv6:2607:f8b0:4864:20::143])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0851885B5
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 16:59:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x143.google.com with SMTP id
 e9e14a558f8ab-375ae697214so323425ab.1
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 07:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718031579; x=1718636379; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tzGjO0ZIZQPDdKSNiaOQi+doAexplW+r4/rQxZL3WjQ=;
 b=IHJEAP9wkNtmj6q8rInlWVJ2kahJzT8jn/QE4thutdcSw7s/ac19svvQsKJihIfoXm
 /IbsMb7SCVsB7FpsTJqzpdkZ66NQd6SH8mJPsdy+V2onVEBvRxNGgLxYUZeeLoJeGV/H
 pt9bMx/V6uerRT48wvUeI3K3qbomUNKq+z6JE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718031579; x=1718636379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tzGjO0ZIZQPDdKSNiaOQi+doAexplW+r4/rQxZL3WjQ=;
 b=A6sxvsM+5MbVGDyUdm7ejnEKdBA5vUJa3CqboBiauhp6d857MxIEOelty2K5yYQZMP
 8dm96iMW4wTD0Kk6pKcYCq6HZO9YfyfEl5XngrRwiLw2vrIWJHPhT1QvRp/KB5uV/wPa
 Hq8VHwyvRwQdnVpGUfYy2FTcBzMNgLJVs1yxaOPrdoZS6KR98XnTZcrq2c8k9CeD7fak
 2YTrVV9yzQwmzzHuH3kC+deauV+CQn2zZfiL1IcMZC4rM8grX7nB0S0cGIUl9GYX6VNo
 zIvMeqPxDB4xotqJVObyrpRIJLUVOtYtfKPlpl1Np/XiCoLFy1/LUrWqD0bnUxLQS2PU
 wwhA==
X-Gm-Message-State: AOJu0YyBN55OKb7iWxb6eu4CiUPT59gatvORxg+PdKG18MIX4ZX6hgFe
 /cPH3z8dHkwDAS16JJEviZ8uQFtKjp0i/z7g2BtP9X+cw/FWQW1mOLFqIdd/nakpNHYDp5hjwW4
 dD1YQ
X-Google-Smtp-Source: AGHT+IHF1mnjQ9ZDIdu/YR21EibaUVY8bQw6RuLFc2pF2GFBqAalsTmjoS87WnlENK3w9YcARErPEg==
X-Received: by 2002:a05:6e02:20ee:b0:375:9a5f:8cbf with SMTP id
 e9e14a558f8ab-3759a5f8f7emr63183805ab.4.1718031579356; 
 Mon, 10 Jun 2024 07:59:39 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-375ac6104dasm2526885ab.4.2024.06.10.07.59.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 07:59:39 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>, huang lin <hl@rock-chips.com>
Subject: [PATCH v2 3/9] rockchip: veyron: Add logging for power init
Date: Mon, 10 Jun 2024 08:59:14 -0600
Message-Id: <20240610145920.3302001-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240610145920.3302001-1-sjg@chromium.org>
References: <20240610145920.3302001-1-sjg@chromium.org>
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
---

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

