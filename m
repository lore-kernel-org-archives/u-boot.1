Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FD70E7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 13:29:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AD2D8027E;
	Tue, 17 Dec 2024 14:29:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Wd7OTbCN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37B6C80274; Tue, 17 Dec 2024 14:29:18 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38582801CE
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 14:29:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nbelin@baylibre.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4361b6f9faeso32988755e9.1
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 05:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734442156; x=1735046956;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qG5C2pdOoyB5ZvQ+ybsiuxmCMdBeRuvzy0wmlXzPgI4=;
 b=Wd7OTbCNhJt4HITnqyhCpZ5qb/xUg4vUBCi0q07ZF7TaWCGCQ/WCSKYq7gs7Y3lFTW
 Ifvb4R3i7AzNI4aTR1qAYG2/FVeUa7PCAQWQUo5JlidEvSRLXCrLNQQwF8K4Q5u+1EjS
 o8UKNGgBZ/Pw0OnBsqFMsDjWT4d3S5OvBN8QX/CF0wJbYn8k/v+LkAnBJiRQuW5lk85F
 RfQoDNGODAlxTLPW7TnVxclbTBzaL5DJsMLk9PzGzxF4Gk4ivukEw89L2HYrzYbMcLdE
 mrWIaY2r52k19imceGKW6qyU1jCkTv3J6IDgd8AGGVdeRHdzLiFfPdbIZegOSiXM+OtT
 Ei6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734442156; x=1735046956;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qG5C2pdOoyB5ZvQ+ybsiuxmCMdBeRuvzy0wmlXzPgI4=;
 b=ax1jtWRl2NlROJ0f1cx+DjvMowWopaTPfaNx7102dIXijpscHTprypXc+eyJ3Xtdvi
 1UleMrJtPf07mLqNa0A4ZxBRpiRTC6ovOADse44NC+MZuxv7zlh0wMPi3XEIoCtcPhdk
 IP7E9FjwSMCz8d9mDa3XiasgnWdTBRLE9JO5HfIJoGa3mABLsdsypwzBo9PMaxgZSYUt
 OQPi0Se4BNbfLJ1dKGEELaNuEq5RwOzSmJM4uOYzzGXSrH4GSlbvkQ3fgvBLBbEGEdMN
 e02edmrkcdP74TJ1AkmvPdwDoZluFSYTFSp1V11ACZA0eNlUSkE1G3ohpqtH93i2tenq
 Dgqw==
X-Gm-Message-State: AOJu0YwUy7pq9GN2A/S1jTzhFhf0On6e0eshO0C9+D9x/nSd6hkrokD9
 acwPDmAMH8sUpZCGZE9HeN2G+vTuEXEpEyAYvOQgNDYpoB1rW08B2BjSueXgQmU=
X-Gm-Gg: ASbGnctW6QE/d/9UicqbIILi2KUQSyd2XitC5z6VA0lQ6G+Yf/DuKx6qoAnLJxQpkZe
 Z4bPxe96mi4I65VcEwHZa4EoN3AxcudX7eXLbfQjVQSi9v+f8Kw8LLehElS7UEz0UnzqwJk+pPW
 r+afmytcNFSBVI0X7pGasaqMHaCTAj+Bx0uIwiyPMH7LnE1Fq+l0zoldhubk60PaGTrsz+NbcM0
 n+pPWWoA2DdHK/zQuHio9Jagk8KOTaVlOVHLQK99VcqeDRgAAy8hxJ9
X-Google-Smtp-Source: AGHT+IHugg4azA+dD1dQNdhSGmAe23qW+2PHE1Lm+tbW+He40Pq+xjOljyQXjg1KL4ZirTCLQS0gXA==
X-Received: by 2002:a7b:cd03:0:b0:434:9ce6:3ec with SMTP id
 5b1f17b1804b1-4364815b1a0mr28406175e9.7.1734442155645; 
 Tue, 17 Dec 2024 05:29:15 -0800 (PST)
Received: from [127.0.1.1] ([2001:861:d40:6fb0:d0f1:bd21:f6c6:25a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4362559ec08sm173605115e9.22.2024.12.17.05.29.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 05:29:14 -0800 (PST)
From: Nicolas Belin <nbelin@baylibre.com>
Date: Tue, 17 Dec 2024 14:29:09 +0100
Subject: [PATCH v2 2/3] boot: android: free newbootargs when done
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-fix-bootargs-concatenation-v2-2-b2fd7cf4e130@baylibre.com>
References: <20241217-fix-bootargs-concatenation-v2-0-b2fd7cf4e130@baylibre.com>
In-Reply-To: <20241217-fix-bootargs-concatenation-v2-0-b2fd7cf4e130@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Safae Ouajih <souajih@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Ahmad Draidi <ar2000jp@gmail.com>
Cc: u-boot@lists.denx.de, Nicolas Belin <nbelin@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734442151; l=745;
 i=nbelin@baylibre.com; s=20241211; h=from:subject:message-id;
 bh=JpnMTRMmwq26iYzb18wDU10iIkse/geV7rP/JqZ6K+o=;
 b=B10+wwMVEwXZ9th7FQrs4snYT4FTGqI4omEMw60tRTxUfxSqs2ctDKsWA+zuioAt+L1zYerfy
 MHFY5fEziaVBH4f4XUvbLbQkeSaWllKJrF6VppAFJYtM8XvPkh9C4OX
X-Developer-Key: i=nbelin@baylibre.com; a=ed25519;
 pk=w8SrWXgXuIaN/RB7JHkKa2EKDC5nVxqVHI8XawK2M7I=
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

Free newbootargs when the concatenation is done and bootargs env
is set.

Fixes: 86f4695b ("image: Fix Android boot image support")
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Signed-off-by: Nicolas Belin <nbelin@baylibre.com>
---
 boot/image-android.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/boot/image-android.c b/boot/image-android.c
index 57158280b41c6552c82838e21384d925d5f7cde4..362a5c7435a3a8bcf7b674b96e31069a91a892b5 100644
--- a/boot/image-android.c
+++ b/boot/image-android.c
@@ -322,6 +322,7 @@ int android_image_get_kernel(const void *hdr,
 	}
 
 	env_set("bootargs", newbootargs);
+	free(newbootargs);
 
 	if (os_data) {
 		if (image_get_magic(ihdr) == IH_MAGIC) {

-- 
2.34.1

