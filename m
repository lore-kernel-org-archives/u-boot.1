Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 801B0CF58E0
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 07:27:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC377893BF;
	Fri, 20 Sep 2024 09:25:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OjRMadWe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3081089378; Fri, 20 Sep 2024 09:25:31 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BFFC893BF
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:25:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42cd46f3a26so14653075e9.2
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 00:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726817121; x=1727421921; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cw+z0SGM+G6uLjeGZXVJ2g9ettneXpGkiE9qTJm63TE=;
 b=OjRMadWeEhTSjgTYGVK42846MlQHFx4plVakY6SYGCyJVglXDK7d8QeKfbzXQPWOml
 TQpgBn3qMPu/99S+YTbowm6OctNc02ZCG//83ntCxErEEmW534MZuo5TDs42RU4JQeJs
 5juCkeUDPe1GIw4iRYV7Y0VLOwr+M1mas+2hk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726817121; x=1727421921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cw+z0SGM+G6uLjeGZXVJ2g9ettneXpGkiE9qTJm63TE=;
 b=Mls07UxwFzY5d+MHea9MQCwvz4v+ov/MZT0lwFZJq/0cAxrOp9wGDxRfFXnobtnd0+
 jiPGjYHQsRe8/bHQEO6exBb/JLnCM5wQm8GKM7uH4fEeW5lycZ68x8HHagWA2fISYzIh
 PkrgSyyRMOzX4YEtMJOh9A8nIDINSkD5Cw2dZmcsv1FSvZKwE/v8bWx4TlxlefMoGWn8
 2z52axStvRDSYis1zGaMnTfp/nsS+pQ52vLnR0iKzb/6PCvkQ/l68byybqCeyeus7rEO
 rWve+5IcyGCFTwzNiNBRw5iAmXp4dfk3Z4FovCuW5GhmMM5Fha9FMUfAnoF3dG1Me+/U
 tuDA==
X-Gm-Message-State: AOJu0Ywr4lOtk3os8Pgjibs0sBXm2N9MxkGqgSJrl8GcM9mMuu2j8rGl
 5Sb9rAThPJfXQOu7w0sciur1pNKQvHYs4rfuqhCfKX/H18nMRG97ifEH+nJLUHo3I91LNSvixNh
 nF+/J
X-Google-Smtp-Source: AGHT+IHNsikTDe+1i7iJWxbKtyC0ih7jiaZUkWEVGnRva0TfS3aRQmnakD0rGhJnlq718ULzU/TviQ==
X-Received: by 2002:a05:600c:1d08:b0:42c:bad0:6c16 with SMTP id
 5b1f17b1804b1-42e7abe21c2mr13646865e9.2.1726817121412; 
 Fri, 20 Sep 2024 00:25:21 -0700 (PDT)
Received: from chromium.org ([185.44.53.103]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e7540e32fsm41504535e9.9.2024.09.20.00.25.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 00:25:21 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Peng Fan <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 17/18] rockchip: mmc: Fix a missing colon and newline
Date: Fri, 20 Sep 2024 09:24:41 +0200
Message-ID: <20240920072444.134997-18-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240920072444.134997-1-sjg@chromium.org>
References: <20240920072444.134997-1-sjg@chromium.org>
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

Add a missing colon and newline in rk3399_emmc_get_phy().

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Update subject to mention that a newline is added too

 drivers/mmc/rockchip_sdhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/rockchip_sdhci.c b/drivers/mmc/rockchip_sdhci.c
index 15b4a39770a..4ea3307ed9c 100644
--- a/drivers/mmc/rockchip_sdhci.c
+++ b/drivers/mmc/rockchip_sdhci.c
@@ -230,7 +230,7 @@ static int rk3399_emmc_get_phy(struct udevice *dev)
 
 	grf_base = syscon_get_first_range(ROCKCHIP_SYSCON_GRF);
 	if (IS_ERR_OR_NULL(grf_base)) {
-		printf("%s Get syscon grf failed", __func__);
+		printf("%s: Get syscon grf failed\n", __func__);
 		return -ENODEV;
 	}
 	grf_phy_offset = ofnode_read_u32_default(phy_node, "reg", 0);
-- 
2.43.0

