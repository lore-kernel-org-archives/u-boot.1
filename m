Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F9BFD3B7EA
	for <u-boot@archiver.kernel.org>; Tue,  9 Dec 2025 09:27:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3063E83C0E;
	Tue,  9 Dec 2025 10:26:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RbWbGYtv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 996FE83B95; Tue,  9 Dec 2025 06:58:09 +0100 (CET)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CE0E838A0
 for <u-boot@lists.denx.de>; Tue,  9 Dec 2025 06:58:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xieqinick@gmail.com
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-3437af8444cso4627063a91.2
 for <u-boot@lists.denx.de>; Mon, 08 Dec 2025 21:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765259886; x=1765864686; darn=lists.denx.de;
 h=message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ipWTaBkO9NRhYB73xbdcKlhmMD4pf98Ty0k/P5ljLEI=;
 b=RbWbGYtvk+nJjchHE3OmTg+d30nUD6mXcxalOyTsBGWnI9nCqIdXq3MkgK7F2hQOEX
 k3RegdGaR+pDNZF/3eOjDCG/sm3tomUVb9P11XHvDWpDfBt5HDsPrGqbbH3sYnBOF/bs
 CiqjoiGkJNUBsA4+Dw/bT5zzoQM/nsm3GwnR7VBoW5ctXewYa7gi7GO2gOCud6CdYMs3
 XhsD+4BEYlGrhwcG3MzsjK5NUU446FeVK1JnmRGzqBbgeMgH04I7j8bd5S3mxjznfFy5
 kPcZWiIprKNpldt6KTRr6ofISWSvf/sShtHUI64r1shru9jZ9LbZdTkPPPI6gmF/auBM
 OoWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765259886; x=1765864686;
 h=message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ipWTaBkO9NRhYB73xbdcKlhmMD4pf98Ty0k/P5ljLEI=;
 b=j/Y7rGM6APZNUINl2YjMW6rgRhoJFpDBY8/x4WlKUL77+mh8yrqWksg/w3BsXxLWXV
 5Mz2J8pm7fsxZRMpUUr6Awy9pJ/Ce3VkB8oplYmFegXW5X04yHC9lDRzI8F/N7qZB/xu
 rgHl7myjKp5NK6oJWDG3mrZTivD/XA/bRuENcXzQ2IDgKvikifM1i4W5QwWm6/mk6kPo
 Qdiw8T9jVXxGwqS/jeqjfniqsLdUbopbQx39SjYwh1djIxyWU3s7KynY2dc4HfDE4xRC
 sRl2728CIVettDXXAp2nVQN7SLWD/4BG/RFfZzpg8OC7kBBDMiQApc7mLKQHW1tNvlDp
 FZrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOrhbLeD+yQFivd2tTLE7VTKKERdu7i5fkV/BsK8KGKJ9aFI5TRbHV0icJo/1PLVVyjhvQwQs=@lists.denx.de
X-Gm-Message-State: AOJu0Yy6ACsOnBP/SzBTFY898UEyGj+bDGucJebWvdKT7YNyjKgUhZVe
 typLcYKrsLYs9J6q2ABJ5z5ElUV3l3AhpYS0pEtUgy9+dQt/znrABNnB
X-Gm-Gg: ASbGnctiPYMi1j/QnzD6I0wnvFXSbmIQiOsmh4+IAeU9I7Y8eXset5YbDhhLD9tnE+Q
 Hqx7Yq2HsfWa+WQdN5qxQ7T+yYT1I7rvG/RlFqkWX4w/u0BVoch2usupQYMrQNmRLblMVxZ5VZ8
 3r5BvQhoGPqhMjMWd/OkQYdzgWQzqXZqLc38kpFwNhOysepLgzAxJz3VMf8rIznusXVHYH0wAJq
 hWGs5B63/IVl5z2JOkGWur8/hKU2USL7eBIGBkLiQ5iuEjvrcJuEstZH2CO0H8b2NlEHvfs8LPL
 NRh9FY5lR6T/wyestLte1XjcHdly0sg+/mFcchVJZlpj0sBQE+UaZOdEiZQ8G3wB6rFobSggBEV
 0ImrD9e8LqxJBrkdh4Vs9ENk7/vst5sFop3+SBczYAesisVsGkztJn278OHY1dFvn/SBI8PFSfE
 Q/rJTwDbl5Sq4=
X-Google-Smtp-Source: AGHT+IE/lqap8UwMWERcs2fpnkS2PSs5SUmVJWPpsA3Tjw9p6waFsQQNR548elxCHuT5vN3qoe6z7g==
X-Received: by 2002:a17:90b:2fc3:b0:32e:749d:fcb7 with SMTP id
 98e67ed59e1d1-349a2518c46mr7733097a91.13.1765259885775; 
 Mon, 08 Dec 2025 21:58:05 -0800 (PST)
Received: from localhost.localdomain ([124.156.134.75])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34a4a7f55dcsm555593a91.4.2025.12.08.21.58.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Dec 2025 21:58:05 -0800 (PST)
From: Nick Xie <xieqinick@gmail.com>
X-Google-Original-From: Nick Xie <nick@khadas.com>
To: nick@khadas.com, neil.armstrong@linaro.org, peng.fan@nxp.com,
 jh80.chung@samsung.com, trini@konsulko.com, u-boot-amlogic@groups.io,
 u-boot@lists.denx.de
Subject: [PATCH] mmc: meson_gx_mmc: reduce maximum frequency
Date: Tue,  9 Dec 2025 13:57:50 +0800
Message-Id: <20251209055750.43594-1-nick@khadas.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Approved-At: Tue, 09 Dec 2025 10:26:50 +0100
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

Reduce the maximum frequency to 40MHz to be compatible with
more eMMC. And the Amlogic vendor U-Boot also use the maximum
frequency of 40MHz.

Signed-off-by: Nick Xie <nick@khadas.com>
---
 drivers/mmc/meson_gx_mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
index 5852b24c6d2..87c5f04da0f 100644
--- a/drivers/mmc/meson_gx_mmc.c
+++ b/drivers/mmc/meson_gx_mmc.c
@@ -278,7 +278,7 @@ static int meson_mmc_probe(struct udevice *dev)
 	cfg->host_caps = MMC_MODE_8BIT | MMC_MODE_4BIT |
 			MMC_MODE_HS_52MHz | MMC_MODE_HS;
 	cfg->f_min = DIV_ROUND_UP(SD_EMMC_CLKSRC_24M, CLK_MAX_DIV);
-	cfg->f_max = 100000000; /* 100 MHz */
+	cfg->f_max = 40000000; /* 40 MHz */
 	cfg->b_max = 511; /* max 512 - 1 blocks */
 	cfg->name = dev->name;
 
-- 
2.17.1

