Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28E14C87FCF
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 21:57:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A81983FEC;
	Mon,  4 Aug 2025 23:57:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fK+btbGu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75B7583FEC; Mon,  4 Aug 2025 23:57:26 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59E0483B1B
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 23:57:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-8818a5ba63fso37360939f.2
 for <u-boot@lists.denx.de>; Mon, 04 Aug 2025 14:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754344643; x=1754949443; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VTMZU7mvqq0WS+Us128MkpQ8XXoHprAqMn6peWAOHQQ=;
 b=fK+btbGuCYJvLHUgAbOwCHxVYFD7gKHsE5+Pv9sQantkbgXn+ZfzAgWRDvvtqb3kaa
 X8kXCGyOUyiUcT5XM88NZEw9W5P8NLD+ewELNPTSYa+hyQsnY2X70O5V6+d1/PtN87Vw
 AE+ZeH4Bvoap6PYX6xlPXvNfVZTk5/6JnKjHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754344643; x=1754949443;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VTMZU7mvqq0WS+Us128MkpQ8XXoHprAqMn6peWAOHQQ=;
 b=O0pLBM2vt5wfa+F0jhthsKxHFeRWAuvrAx43SHouMXYT4J6/OuyDU47TK/mzc9od5E
 GuASUmimY3SWNLTwF3iUE0PB+tkuseicEXMccqOTLYoPnIXa26uISLdZw7qcDq3zA6LM
 6wLyPWKZe7QzJgRux562bein3eFpas1MhikIAFhqW2mpzdhSidki7UXpQXlz/7tyTmBy
 y5Ki15OscOgxzrFUoFo2PBP9D74CuQnhmNnLiQVVKy5Dx4dMy6j7jDJBN1Hx/4DuvUjl
 lo00nhbNyWvSYKH3vB8u2ae1adxTSoDUKO90s3AIm1GtWKP4NZfwxaoGyOG6jb9E4+3+
 /Bkw==
X-Gm-Message-State: AOJu0YzpzpyKXQSPxTYQAFUEtTEYq5rQZpjffCOgJ8t6iGkTwWmX8eeW
 Cu5Y4xV6F+/LzkU1SjA3V6TwbHouhgoiwirWcpJ8gXngLT6XXpclJr7rwTY9vXbIiAV0wx7m3Ot
 6NkC5g4c=
X-Gm-Gg: ASbGncuIPvKR/OegKl2cOWysLERg8nfdDGxbsuLfSdTCSw5AHA2HyhYoGQDfqWBW5u/
 Bde9vAFVhSPGCdZNgpJh3E72aPWeHui9B6c6/tXExDrBDVZHJ8I00iKBicPFoGv3hGKOyK7XSgr
 xE8Kd09z/Ojpe5zVCuhRHUt5ggPvygcY5Fb8R8M7JOVogHyycn+GfSXLah0lv1mTbRMx49zwaFX
 e16KVI5XFFZSNksKcMdZxAv3oQtwsyur0U66DBOjWa1MU2mgNT7mcTyDbqxCU615cEXRURQaWtL
 V5yZVu4b8bSGVGA4mI/c5BTQMTjEMszx0ltXPYGthLWWpm6/ZjbyAKhhXYDii/x1zenugRN1sr3
 8Pp/bV/Nq2rqy9lo7NSP6eXeoWsEPKLbYm3tNFLSlmCAY2N3zWULsNSeiI7wUU1Bu0Ycu
X-Google-Smtp-Source: AGHT+IHteBrAZfsayDmpGBCeepz4d6WSKpYGGUBSRSmuoNzj+LMeJA+44dRZ1AFdBeMjvQxtzUQetQ==
X-Received: by 2002:a05:6602:d:b0:85b:476e:ede2 with SMTP id
 ca18e2360f4ac-881683d6f4amr1632553039f.13.1754344642947; 
 Mon, 04 Aug 2025 14:57:22 -0700 (PDT)
Received: from localhost.localdomain (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-50a9f677f81sm1066177173.39.2025.08.04.14.57.22
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 14:57:22 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 3/3] rtc: pl031: Correct function type of pl031_write_reg
Date: Mon,  4 Aug 2025 15:57:12 -0600
Message-ID: <20250804215719.1413106-3-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250804215719.1413106-1-trini@konsulko.com>
References: <20250804215719.1413106-1-trini@konsulko.com>
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

When calling writel we do not have a return value to check or pass
along. This function should therefore be void and not return what writel
gives us.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/rtc/pl031.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/pl031.c b/drivers/rtc/pl031.c
index 855ee9134168..6f189bc503ef 100644
--- a/drivers/rtc/pl031.c
+++ b/drivers/rtc/pl031.c
@@ -39,11 +39,11 @@ static inline u32 pl031_read_reg(struct udevice *dev, int reg)
 	return readl(pdata->base + reg);
 }
 
-static inline u32 pl031_write_reg(struct udevice *dev, int reg, u32 value)
+static inline void pl031_write_reg(struct udevice *dev, int reg, u32 value)
 {
 	struct pl031_plat *pdata = dev_get_plat(dev);
 
-	return writel(value, pdata->base + reg);
+	writel(value, pdata->base + reg);
 }
 
 /*
-- 
2.43.0

