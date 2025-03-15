Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5797BC28B28
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 09:24:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5385680540;
	Sat, 15 Mar 2025 10:24:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="R7eKnosB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 287F28058A; Sat, 15 Mar 2025 10:24:50 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2228C8043C
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 10:24:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3913fdd0120so1530269f8f.0
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 02:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742030687; x=1742635487; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3k/cTMEYdwt00YxQ2XPJKoGNbMltjk8OG3d2FF5sFy4=;
 b=R7eKnosBcSgFIxEoTDo2FYOYqI1LVYcW4cqM4si8NFL1nPBB3S1Ieuwmv+6VhrJO0y
 y9EPnuqsgMf314WRCcqj9AlzuC719/OxrYDZq3gkxZW18dP/D8qoMeyEwgfQa8ARCy+x
 mKuNWmJZX42dvw2CZ39BhvbMeyb348uWyXPwQ3MkTHZ9zAfhhIcqLEVGLTWKLvs+mN/Q
 ji2nZaXsdzsB1L7i3Qsw/GoYc/wdl2oiAMo160ELP9GD19oEhQAFM15GnY7FGeIV2m69
 awSUZs70RPiWNyku/l6QBMwQMeGbokGwXpx2bUlJEqrYSnjygwtdhty/TZjDRW+U20ao
 H6UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742030687; x=1742635487;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3k/cTMEYdwt00YxQ2XPJKoGNbMltjk8OG3d2FF5sFy4=;
 b=NHK//BZJ/diqpy5b3/c8xc7JtWFFHuQ0/y1GsnEx5Egy8DoY9qicU4Mb5WpmGrYIGf
 sR4Mz/QJlrAjwZAhTt2KaGP+RLALo3xF7mLtcGN025Ta5dvA5K0OyBQSXCevMJ7Rtvkw
 ZkQwtHlz2m9jSNRlxJHZwHKpAdMcu8HFXPpsOxDZAi62Zp9C+FMBeRNtN7ieU0UHdxtG
 V+Ddqarul9oGTtAXKvp0UU34V7WqX4oO77P8wx2Hs4411jT0UdEZ2FxmCu1FI5P7m2db
 Tx50rN3nHWrag8ZxywhsstKEFIjErjNFaz28rnXsmHPUqbn1Gs+9spAafeWUcDbN/Kpu
 tQKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcoZj0X0IW7VRMS03XLwLMzqEz9QTxSnlco+4VXVOoT0pRp9SUFFsQ9VxAbwP8TKJkrTSM66Q=@lists.denx.de
X-Gm-Message-State: AOJu0YyepfTGRHbO3oLI6vRFa6ghC1iUMpMpImvONPTSqN3UkR2rfhD7
 W/UEpkMTqC15vlR6RXQW19pX2Qnv7bv2zeEg+1IC2mGaqVUizI4K
X-Gm-Gg: ASbGncs7P+UoejcH0nkrFgk5QmWylUOXDj/Vri8sRvqECnZQGxpSYsV+4dmR2OakxQV
 x8I8VKHRDyg78Zf/dibEHFQP7R51vEZVeIvGY5mNxWHK0G2ehSDEe9qneV+f8ExrdiOYZpGeNnA
 WYnm53CVzHFHE+ClfIUtEZ6SQ8skZnO5gaNgyYjl6xhSx0DHzxWB2x3LRIGXjz6W71QMf3Oibam
 vBKCgBs0lKTjTJD/UOCEp8f3NpxfpHcqVNaDsvO9BXbNDxmsynr83K3X131Jpzn9g6gXeA1DtUP
 vnqWrRUO1thxpIwqc9eGpooRKokWlHic78VwYkuyJ+4YnoNwyIPm1cLAWcj9tqVx8AIzwvI9m+Q
 KSvNqC9j1QPLbSA==
X-Google-Smtp-Source: AGHT+IGZldJp9vl3QwL9VXzUN0Lb+OyMQJNwQPBKtSfolSHAgtUWbRTBH0jWoLDwQ1K3qkSCBrH0OQ==
X-Received: by 2002:a05:6000:1f88:b0:391:2306:5131 with SMTP id
 ffacd0b85a97d-3971f7f8ab4mr7734929f8f.45.1742030687234; 
 Sat, 15 Mar 2025 02:24:47 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it.
 [93.34.90.129]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-43d1fdc8e9esm23256105e9.1.2025.03.15.02.24.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 02:24:46 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, Tero Kristo <t-kristo@ti.com>,
 u-boot@lists.denx.de
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [RESEND PATCH] clk: fix crash on clk_set_rate clean rate cache
Date: Sat, 15 Mar 2025 10:24:14 +0100
Message-ID: <20250315092420.793-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
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

It's currently possible to make the bootloader crash on calling
clk_set_rate caused by the loop in clk_clean_rate_cache.

The loop assume that every child of the clock node are also clock
device but this is not always the case. For example it's common for a
clock to bind to a reset device or also expose a syscon if the clock
register map is also used to apply special configuration.

In such case, on accessing a device as a clock, the bootloader crash. To
correctly handle this, check if the child device is actually a clock and
ignore otherwise.

Fixes: 6b7fd3128f71 ("clk: fix set_rate to clean up cached rates for the hierarchy")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
RESEND as there was a problem with email To:

 drivers/clk/clk-uclass.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
index 353ae476068..8f3309d9530 100644
--- a/drivers/clk/clk-uclass.c
+++ b/drivers/clk/clk-uclass.c
@@ -554,6 +554,9 @@ static void clk_clean_rate_cache(struct clk *clk)
 	clk->rate = 0;
 
 	list_for_each_entry(child_dev, &clk->dev->child_head, sibling_node) {
+		if (device_get_uclass_id(child_dev) != UCLASS_CLK)
+			continue;
+
 		clkp = dev_get_clk_ptr(child_dev);
 		clk_clean_rate_cache(clkp);
 	}
-- 
2.48.1

