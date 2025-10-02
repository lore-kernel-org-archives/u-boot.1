Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F899CAC5B8
	for <u-boot@archiver.kernel.org>; Thu,  2 Oct 2025 10:36:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7373828A2;
	Thu,  2 Oct 2025 12:36:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gI7BauO6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E12B0831D3; Thu,  2 Oct 2025 12:36:13 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22DB981D6A
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 12:36:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-46b303f755aso6328535e9.1
 for <u-boot@lists.denx.de>; Thu, 02 Oct 2025 03:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759401370; x=1760006170; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vCAkxwJM8XbSWMvJYawM+XdlKGPZWSZSLEj6AwV/FQg=;
 b=gI7BauO6XaHOPV00Dwbj6b/FZapL+ET6VukANPOTqvwqFBX6WGlB5CjpPfdY9+/E31
 Hx1whXUl1cvx5oToX8hanULS/YKeHY3JVTbSC0pyNgjxzSj+dMKjzWZd8Lz+eGQWQNIt
 FbWMZ2dwch8IxcMQfbfQ9E3aYHP89gwS1/+TtKj4feFcJyIbn/ZRE+1cHa3/WsvRxeh5
 AS8kgbVhL7F4CH8id8uh6WsvMsk2lUPHtcVUZuHB48Q4B0gI5zA4ZQHMjYT1PGmWMcJY
 lGfLEYvb8xnzeS0bCdlMoIOgV+f3IXZGcbbMZD1hf/8MeUnCIOtdcPZFgWq9PwvQKWpn
 COrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759401370; x=1760006170;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vCAkxwJM8XbSWMvJYawM+XdlKGPZWSZSLEj6AwV/FQg=;
 b=PxFJwByu5p3dPkCHFjL1rVvCMWaZIWx3zqc426l7UVUgb4rfyiANaol0hSLIQOF5Nt
 i39Df6vK/2BCZFhd5OlZYGffXLevzmtFJSHZRiSxN+vuml13XwzwfbETBC4fiAojyRQ2
 TVy2qD6ZHIrctc2WKeJCu4Fru1JpLLDqCEGYoG+jXvrNxLbNzpyTa4ahAaviXBaYZhbt
 XLnILAUEILkyOr7m+YOGTxdeYCyjCQy69M4BBcrga4FvNJc+qC92t7kTMLypR/H9nNcr
 k96x4JS/DRjMzOU1TrEDFd9wFNRJWWJQXspQ3NwtUx+1OgLW+5bCzUycb8vB4htZFURs
 7Leg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkDB+IBQxYnZS7luARbRY3RUUbn0bogfvckz4NnOp3W2KBueUrt+OIjHZo4wjdREftA4Tm5kM=@lists.denx.de
X-Gm-Message-State: AOJu0YxdwAxjxfH9puxn3YdHLgqP6ppldvkTVGFpdWxFS4IYPyST/Xoc
 Omj1nIt1chXmFu6Y7DkdgX9GzfXMULXbUCqn4xq5s3I6cht/dIdteElv+nxJp5auw9o=
X-Gm-Gg: ASbGnctR9R58py2D276xLsiNMnTcb5Uau6OputJHqyJl0/fi1Hjj12LNwMU9qNdGlo9
 VJTgoaYDhzgwMmnPICEDV4gBeykVu3rdp8isPSpOVXzlP3wxfcfvI6ba6OxLVheNcmvhc7caKnW
 BsxGVJe2aPIRW8p1BXzGAMJV2+Egk6o+usFMEb27xqTUPj0y5ILM2Kx5eGwNE13k+QdRS26maVa
 PQEnO2jGcSOObZyK25KPEtPkoj1Du0Abc2UxwKrh29cKUWRidKnV5xErRW6p4h78DTrWMj0iDCE
 YaIQNEi4WG4gOgHokGgsstZqxUyJ+ZlHo4abuiupQ5q33NpQKK6eAOcxZ9vWfOeRukSjWcJdZzt
 ZaO6HoCiLjZHHql7h2FIaPfsf0T44glsiID6G74FDOR8x5rZ6LLkxVYRyEWarodbRJde0ahTKRU
 BVaRk=
X-Google-Smtp-Source: AGHT+IF/8djHxn5Uv1Q4kUVkRFJaPpXdRxyUzgaYaNfME0/h81KLrI2rCSAjOYjBQBFQded5FA25eA==
X-Received: by 2002:a05:600c:3505:b0:46d:5189:3583 with SMTP id
 5b1f17b1804b1-46e611e12a7mr55579785e9.0.1759401370494; 
 Thu, 02 Oct 2025 03:36:10 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:ebd:e301:a21d:c610:1e27:3706])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e693bd655sm32282915e9.14.2025.10.02.03.36.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 03:36:09 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Thu, 02 Oct 2025 11:36:09 +0100
Subject: [PATCH] fs/squashfs: Ensure memory is freed by using unwind goto
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251002-fs_squashfs-v1-1-d72e624dd056@linaro.org>
X-B4-Tracking: v=1; b=H4sIAJhV3mgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAwMj3bTi+OLC0sTijLRi3dQ047REE0sji1RjYyWgjoKi1LTMCrBp0bG
 1tQAYB0hwXQAAAA==
X-Change-ID: 20251002-fs_squashfs-ef3fa4928e33
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, u-boot@lists.denx.de
Cc: Joao Marcos Costa <jmcosta944@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Andrea della Porta <andrea.porta@suse.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.14.2
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

Returning immediately from sqfs_read_nest is not consistent with other
error checks in this function and can lead to memory leaks. Instead use
the unwind goto used elsewhere to ensure that the memory is freed.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 fs/squashfs/sqfs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/squashfs/sqfs.c b/fs/squashfs/sqfs.c
index 2dcdd60f68343f801bd73e318568fb030434ed31..4d3d83b75873f4d66f2dbd544ae6715f66f5d289 100644
--- a/fs/squashfs/sqfs.c
+++ b/fs/squashfs/sqfs.c
@@ -1584,8 +1584,10 @@ static int sqfs_read_nest(const char *filename, void *buf, loff_t offset,
 	table_offset = frag_entry.start - (start * ctxt.cur_dev->blksz);
 	n_blks = DIV_ROUND_UP(table_size + table_offset, ctxt.cur_dev->blksz);
 
-	if (__builtin_mul_overflow(n_blks, ctxt.cur_dev->blksz, &buf_size))
-		return -EINVAL;
+	if (__builtin_mul_overflow(n_blks, ctxt.cur_dev->blksz, &buf_size)) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	fragment = malloc_cache_aligned(buf_size);
 

---
base-commit: da47ddebd16a7e1047da8537fbf01558d2a89fcf
change-id: 20251002-fs_squashfs-ef3fa4928e33

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

