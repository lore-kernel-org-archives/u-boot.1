Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E947CCFA05
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 16:58:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE9ED83E20;
	Fri,  7 Nov 2025 17:57:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="nMK1fZ3d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96D8383BA1; Fri,  7 Nov 2025 16:02:41 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7B9883DA7
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 16:02:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4711b95226dso8552835e9.0
 for <u-boot@lists.denx.de>; Fri, 07 Nov 2025 07:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1762527755; x=1763132555;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=j6NGntzkok+mwQVrzPiOtfZZI4bL0/QdtSXbPPhkLyk=;
 b=nMK1fZ3d0HzLX4tRz/yMOfGE/586KmA1dJ76qlCny39fspXzv9iDdgyOh4J1UVMhnH
 lAd2ju0tBYSO7tS51WQg1kgTgt8QLa++eA1kdYmxOF44cRXfJ6MYE/awMZSnYjhkSp16
 w2bezz9XHc7Yr+79kaHxuNKAhzwsqtrQkC92mTj5Z+K6GhH9/dP6EzvSOCcOmRPAo7rR
 em46z2Ceo60XDAi8s7hUMH3kjITcQ7nVZGvkEYhEE0iWVfF/7IwQFefD0stnsI50HNUo
 e1ND0XWkBQFpSszDOTzrW+ApDkgJmHHhqVkjvH2bWw13YzJcadvH2M9wrrAWQbbhs7R/
 gdzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762527755; x=1763132555;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=j6NGntzkok+mwQVrzPiOtfZZI4bL0/QdtSXbPPhkLyk=;
 b=Px1YlqkOzBImTqRrA1cIcfw55AZdMRfBX+CE6v1sIVv4Ii6Gjy32bc3+WET/ZAejNt
 vdrtlrPofmjkG0xNm8pFTAjzKm4CKKmoKYMiMVYhSYOkLmhGR5cPI8pm5hRC7NfYTo/A
 XAeZ8/wcafSwX0YTMu4f7bA6yZ+XZcSXv2vn9+kZkz0zPVt0B65k0ZlwOL3jWyggWmY6
 YvmjY+ddiE1/3aEVDFkjRMnarEZfZGwRoroGiBy7Cdoif5o5bdgmFjOgd9irgXUd2jJN
 HwLk/y3838ysoT+5LKwXRqSdYpj+CACXcc/yI7dbTtofAufa0VC2cDfsHJZSr8NwZ77h
 BBwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+X9jXm3/MAmVf29isIQ1yM8vVvPyX/KqKG0HsAessmpoQZOMGp8ly9K5E2SkJTWqUd4/LByY=@lists.denx.de
X-Gm-Message-State: AOJu0YzuPw4q1d4qWOrb+vKqSOLPxci8kKpjE+ZdjVK4fjs1fvSXB+rQ
 IuO3vt8F2r1cSTlFRLzXX/lH7Gn6ZQ//5vHkbVEGiGz6Yf+DSHDiO8EFuhOERbwxxA70wOo6OyY
 689GD
X-Gm-Gg: ASbGncsG6NSBwq6/cbgY6O+TV1x+uvqf/Elj2zRkXLgC1WGREsmoVT4BkrydIR4vgGH
 GtZM24j9b0HHq21IVxWcJc+4NrXWf7iB6cnEu1nG+AeOoxzSH3bVMFrkBlI5gfNnTQOnapuzOVW
 /w3sxqqux3hMcFJo6LwNvh4ZOdmZG98bfefNRhRXQQiT/1+rdibpR2zowmj4K/owdBkhsibYZ+x
 9k4k784QFjnxBNUimc5mrv8/X5cD0+7IMa5jdLgB3vfp9c8hmEhGQgsclsYbenN5qIDTaQWm4v4
 glstYrLsdeSjTJ45x1gWh21+XnYBnvJ6471EOS/DpjpoHqT4t6VdLrTjx1RikZHR9WbP/7EiPQy
 iFRqOOtoxznKN9DzjZRQbMEvbjoYlmgaYCSAdaIGzpkkhaC9rOplwjjz2LoJlBadA7G16MJbKg9
 c=
X-Google-Smtp-Source: AGHT+IFbYlcByMz8C6y5RLUJdJ4mlk9K/v2lvkwpblcyN9OtLjPGMRaq0D4o8kYtiTOyA3EKZHXS/A==
X-Received: by 2002:a05:600c:1c8c:b0:477:5a11:5545 with SMTP id
 5b1f17b1804b1-4776bcc00e4mr24499585e9.27.1762527754878; 
 Fri, 07 Nov 2025 07:02:34 -0800 (PST)
Received: from [127.0.1.1] ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-47763e15481sm42508845e9.3.2025.11.07.07.02.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 07:02:34 -0800 (PST)
From: Zixun LI <admin@hifiphile.com>
Date: Fri, 07 Nov 2025 16:02:24 +0100
Subject: [PATCH v2 2/2] mtd: rawnand: atmel: atmel_pmecc_create: Remove
 unused code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251107-pmecc-v2-2-271e6aea3231@hifiphile.com>
References: <20251107-pmecc-v2-0-271e6aea3231@hifiphile.com>
In-Reply-To: <20251107-pmecc-v2-0-271e6aea3231@hifiphile.com>
To: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>, 
 u-boot@lists.denx.de
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Tom Rini <trini@konsulko.com>, Alexander Dahl <ada@thorsis.com>, 
 Zixun LI <admin@hifiphile.com>
X-Mailer: b4 0.14.2
X-Mailman-Approved-At: Fri, 07 Nov 2025 17:57:52 +0100
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

"timing" and "timing_res_idx" are unused and not exist in Linux driver,
let's remove them.

Signed-off-by: Zixun LI <admin@hifiphile.com>
---
 drivers/mtd/nand/raw/atmel/pmecc.c | 7 ++-----
 drivers/mtd/nand/raw/atmel/pmecc.h | 1 -
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/raw/atmel/pmecc.c b/drivers/mtd/nand/raw/atmel/pmecc.c
index 7c4e9bd5f9967b119239adf2b39e683ea62b71fd..1acaa5d0e0783f11be8236ad12b42540ca530a5b 100644
--- a/drivers/mtd/nand/raw/atmel/pmecc.c
+++ b/drivers/mtd/nand/raw/atmel/pmecc.c
@@ -820,8 +820,7 @@ EXPORT_SYMBOL_GPL(atmel_pmecc_wait_rdy);
 static struct atmel_pmecc *
 atmel_pmecc_create(struct udevice *dev,
 		   const struct atmel_pmecc_caps *caps,
-		   int pmecc_res_idx, int errloc_res_idx,
-		   int timing_res_idx)
+		   int pmecc_res_idx, int errloc_res_idx)
 {
 	struct atmel_pmecc *pmecc;
 	struct resource res;
@@ -839,8 +838,6 @@ atmel_pmecc_create(struct udevice *dev,
 	ofnode_read_resource(dev->node_, 1, &res);
 	pmecc->regs.errloc = (void *)res.start;
 
-	pmecc->regs.timing = 0;
-
 	/* pmecc data setup time */
 	if (caps->clk_ctrl)
 		writel(PMECC_CLK_133MHZ, pmecc->regs.base + ATMEL_PMECC_CLK);
@@ -952,7 +949,7 @@ static int atmel_pmecc_probe(struct udevice *dev)
 		return -EINVAL;
 	}
 
-	pmecc = atmel_pmecc_create(dev, caps, 0, 1, 2);
+	pmecc = atmel_pmecc_create(dev, caps, 0, 1);
 	if (IS_ERR(pmecc))
 		return PTR_ERR(pmecc);
 
diff --git a/drivers/mtd/nand/raw/atmel/pmecc.h b/drivers/mtd/nand/raw/atmel/pmecc.h
index 43f96b2f168c7b88e0c907996f2ae64f8554ed58..88b0d18040e7c48f226c74ce9b5caf93b5760360 100644
--- a/drivers/mtd/nand/raw/atmel/pmecc.h
+++ b/drivers/mtd/nand/raw/atmel/pmecc.h
@@ -65,7 +65,6 @@ struct atmel_pmecc {
 	struct {
 		void __iomem *base;
 		void __iomem *errloc;
-		void __iomem *timing;
 	} regs;
 
 	/* Mutex used for pmecc enable/disable */

-- 
2.51.0

