Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BA1AC47258
	for <u-boot@archiver.kernel.org>; Sat, 20 Jan 2024 16:58:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E075487ED7;
	Sat, 20 Jan 2024 17:56:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GkouKV3q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38BB487E5A; Sat, 20 Jan 2024 17:56:32 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B05E87DFA
 for <u-boot@lists.denx.de>; Sat, 20 Jan 2024 17:56:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-55a539d205aso2027106a12.3
 for <u-boot@lists.denx.de>; Sat, 20 Jan 2024 08:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705769784; x=1706374584; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yb+ttg64tTztrEbozQVb9yMpLf6tqGcEI47p0nRhVwA=;
 b=GkouKV3qXav4gawWZTsagT55Cve4Jo9gln+ntRoviSY3WE3DJbLwLaBYVonz9HFS4+
 ot7g+nWTguIhfxKmSudRJWB5W8Jn4MVe+N5NlhXLAyD7F7gNoh9WeHh6FzCAwe3YmIwL
 LvL6dXPj8LbjLZzz0MGns8ZE+thRRSa4WCu0qIftlUVfXROoRKxZEBQwg2YCTanPHNeI
 Mg8zvRT8jqCElUAYGqbGkSqW94jTdsTnD/7GsOjsehThZWF9uoy8NRaK3l8n75FoMwVr
 yTR0uZhYJJGbqcEfz4HO2oG3ILo4u2ep1/lYhFdIJ8yiA0B7pBXlwXyy7EVcb/yEyc0T
 ApCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705769784; x=1706374584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yb+ttg64tTztrEbozQVb9yMpLf6tqGcEI47p0nRhVwA=;
 b=Iq7jx68U4Wv0A/Mq7ei1wzFjWm1ak1i7FW0wTbXuicRO4zo1MlvLY8azGrYtwrL980
 4hweVhAEvozdwfzD3rkSRBv1OloWMkXNLysswn3E9tgfgOZXFU5GVlyu8w42ly8aKg9m
 m6J8dVecLLCHX0Ij0PejEupWCSWSHpD2L1GwU+OahF1hAraQLZAX385L5z9pg9IT5Qjs
 LOp3n7ztWOIyIm2+Y1dTglqefwC+TD7zjJUDRUY7L1kVGKBwxhpCxBjKqPNE9GuqsBXV
 r4gbtwJ8HoM/Rr63tRbIVjO5yI9+cXcllA0md/mFK5rkrRWz8S72Eg65ECNBeOh05/MB
 txcg==
X-Gm-Message-State: AOJu0YyVcyC9y7chEqWyxKPtSyUFy8zZTBOgWx82nzN+5PNUGxHeDzDi
 sZCR2zTQBAvQyUUU+WEgszsq8HFSLqxUZ1LLTj6pqoZsqobJw/HS
X-Google-Smtp-Source: AGHT+IFXBqYWj/ZtsCBsuh1pq23bJomRaFywdan0dR0324AGehfTBvc4s33b4PBm0bWy9gdppuH4Iw==
X-Received: by 2002:a17:906:e084:b0:a2c:41f7:ed43 with SMTP id
 gh4-20020a170906e08400b00a2c41f7ed43mr803715ejb.151.1705769783838; 
 Sat, 20 Jan 2024 08:56:23 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 ca13-20020a170906a3cd00b00a2c869be22dsm11311548ejb.143.2024.01.20.08.56.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jan 2024 08:56:23 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Anatolij Gustschin <agust@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v5 13/13] video: tegra20: dsi: set correct fifo depth
Date: Sat, 20 Jan 2024 18:55:43 +0200
Message-Id: <20240120165543.10226-14-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240120165543.10226-1-clamor95@gmail.com>
References: <20240120165543.10226-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Jonas Schwöbel <jonasschwoebel@yahoo.de>

According to Thierry Reding's commit in the linux kernel

976cebc35bed0456a42bf96073a26f251d23b264
"drm/tegra: dsi: Make FIFO depths host parameters"

correct depth of the video FIFO is 1920 *words* no *bytes*

Tested-by: Ion Agorria <ion@agorria.com> # HTC One X
Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # Nvidia Tegratab T114
Signed-off-by: Jonas Schwöbel <jonasschwoebel@yahoo.de>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/tegra20/tegra-dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/tegra20/tegra-dsi.c b/drivers/video/tegra20/tegra-dsi.c
index e60a1d2ac4..4bd1ca7280 100644
--- a/drivers/video/tegra20/tegra-dsi.c
+++ b/drivers/video/tegra20/tegra-dsi.c
@@ -859,7 +859,7 @@ static int tegra_dsi_bridge_probe(struct udevice *dev)
 		return -EINVAL;
 	}
 
-	priv->video_fifo_depth = 480;
+	priv->video_fifo_depth = 1920;
 	priv->host_fifo_depth = 64;
 
 	ret = reset_get_by_name(dev, "dsi", &reset_ctl);
-- 
2.40.1

