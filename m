Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E7AAC61D85
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 14:42:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D890E875F7;
	Tue, 21 Nov 2023 15:42:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hbq7pX3Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6CA2875B8; Tue, 21 Nov 2023 15:42:44 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0935D875FB
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 15:42:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jmasson@baylibre.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4079ed65582so23928995e9.1
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 06:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1700577762; x=1701182562;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=30FuYRAjSPVTr6rUPMyKqmkn0HZTubRKlYkrLDV9LGE=;
 b=hbq7pX3Q1Qr8sTAFRvtAGYCjJAfrTxJ7nsK6tDjofx9aDSKFKt6BhwiRcG5p2tExdi
 blCNMcw1xT0OcEmWNDt9JVSUEAipLjPC5PGC8z94TwcPRw70MGNr/WqkO7HrV6RKhh7i
 LKD/NUEM04VT6TU91uFcgEzUv36BMJpkiXiUU2u6mp4125/CBNTeipxXXUTz2jP7uUl5
 4Fdyl9aVAwff/5O/6sb5AwwF+puQ/Bu0jGg2eogne1ySOIEDdU97ik4UugRvvxw/V/6u
 AxaNo9bbuq+WXo1xKGKvoYVrTsCu69T+tcOGRQ5dT2NImACZO4XNNHnrvFtLjkJtF2q5
 PfcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700577762; x=1701182562;
 h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=30FuYRAjSPVTr6rUPMyKqmkn0HZTubRKlYkrLDV9LGE=;
 b=kVRDi6lX4lQXlfpIxhjIZLSpNnZ9tL6YxSB68aMkr51QoEYgTIZNuQaKuYcLk0dWBj
 D6ITYmoOOXOPim/QI9oJ7JW0gC3rmef1eLvYxn3OCukO+9zcocfTNZ1CBObrkGl6JcfW
 rlT2hH0LvIko3Og/vz+M/JecHeR11WTHpvf6IGvB+mv6HSrqJGMZtXyBqD+SbEMM2CbW
 moKC8eS69z7a6wQjsqkcZMIWLPzmoO4/W1KC5qHmXCqSWLxFE13nXcjuXDS5pcGj1a6D
 Le3n8ygVbEvzvQlxw2miYjNHgQyUhu/vbHo5Wp8C3a85L/w0PP+1A8zkHvDaxgvdalvh
 Az7A==
X-Gm-Message-State: AOJu0YxCjyjposKKx6LxnR5bbKfqFubwrrjPCVBHJyRQNT+Y5uzgUkde
 5Lx0sPJzU6Zg9Z4hT1ADJRlSmv/NRx6HUCe3Tmg=
X-Google-Smtp-Source: AGHT+IF3fcMWgnR9xo3H4SeFrZbqFt1CoOEOVzuQht6RZE5TfnlaK+WT49iOEmmOKBzBQBCVrb2+ig==
X-Received: by 2002:a05:600c:45c4:b0:405:1c19:b747 with SMTP id
 s4-20020a05600c45c400b004051c19b747mr7646126wmo.15.1700577762069; 
 Tue, 21 Nov 2023 06:42:42 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 p13-20020a05600c358d00b0040841e79715sm17566232wmq.27.2023.11.21.06.42.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 06:42:41 -0800 (PST)
From: Julien Masson <jmasson@baylibre.com>
To: u-boot@lists.denx.de
Cc: Sean Anderson <seanga2@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH] clk: fix clk_get_rate() always return ulong
Date: Tue, 21 Nov 2023 15:42:40 +0100
Message-ID: <871qcj5frz.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

When we call clk_get_rate(), we expect to get clock rate value as
ulong.
In that case we should not use log_ret() macro since it use internally
an int.
Otherwise we may return an invalid/truncated clock rate value.

Signed-off-by: Julien Masson <jmasson@baylibre.com>
---
 drivers/clk/clk-uclass.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
index 3b5e3f9c86..41dcd14be5 100644
--- a/drivers/clk/clk-uclass.c
+++ b/drivers/clk/clk-uclass.c
@@ -488,11 +488,7 @@ ulong clk_get_rate(struct clk *clk)
 	if (!ops->get_rate)
 		return -ENOSYS;
 
-	ret = ops->get_rate(clk);
-	if (ret)
-		return log_ret(ret);
-
-	return 0;
+	return ops->get_rate(clk);
 }
 
 struct clk *clk_get_parent(struct clk *clk)
-- 
2.41.0

