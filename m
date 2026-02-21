Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE1FC61DE1
	for <u-boot@archiver.kernel.org>; Sat, 21 Feb 2026 10:01:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FDFE83E85;
	Sat, 21 Feb 2026 11:01:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PXzyPN1q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A535783EE2; Sat, 21 Feb 2026 11:01:00 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDEEC83EAC
 for <u-boot@lists.denx.de>; Sat, 21 Feb 2026 11:00:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=zajec5@gmail.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-65b94e0a875so4071537a12.0
 for <u-boot@lists.denx.de>; Sat, 21 Feb 2026 02:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771668058; x=1772272858; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+d/vCdFawyXk4KIlT7l4H2/d3GlBvg8yJ+lGUGu4Ggw=;
 b=PXzyPN1q647iT/OB+ndy8MuWzpH50kFmHbJ8D4vA+hKMYd+C4U62TtJr3Ta08UEJoe
 GtkxVjGy/oLE5i2zhZEtxtiDc+AdfPqe4Bjl/WeAnjuEZpsYukVxRUprry/pXgJFkNAV
 CUIwooIWXAEqOZbhEx5+KAzcspymzw4lmysY2l+FGX+cj/dvq7ooisdqv9GL9qE84+Pg
 CFUYzumKYpLGtD7yqUg7HBmyFyFyI3dEeVmMwdj4wrzVcQPxuHVHprCpKSrL07qFRj9f
 RaKWH0TJLLCzd5o5Zn7JSw1Meo91htBjVxCQXLEVPfADQ5ajXh2GbvVFOFAKP4S1Mzi+
 KwwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771668058; x=1772272858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+d/vCdFawyXk4KIlT7l4H2/d3GlBvg8yJ+lGUGu4Ggw=;
 b=XVPiDCmU8v9haxSnnsA01B9qxGf/H2QfIbjKi3iBhAdkTfPIwk0MqbPKSbd0tmUhD2
 FY1zKpiqdSXDzL09yXpfX07R7K1EfDagIGZFYrc/McpXUrTN/OaYD4TTDxXa6Nm3mKrC
 IPZztt1DKiWqZxm4GEnOAZv0RgcB/WhtEdUzFBNLqTOu+xwANgl/lZ/tJoNHUhoQpXbn
 HokkpP3TBKfhKVB1oqzIYuwWuo++P0m+yxULk5hDGtfBZtZs8eeav6I7aIIh0amHkA5P
 Jn61favWNb2MxbYrUqfpSkEiUcHCR9RcJ2VsC/5kAswnYoHxAXeF4JOENgiXKuLWeNwK
 dhQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSKrDYOU6Au2IMPgEI4gcf2GigWlGe7HIgyFc22FNFOb75EUY8uC/nX/N2jYRFoSM7VXqa2Rw=@lists.denx.de
X-Gm-Message-State: AOJu0YzXajwbgfIJSqyVUWGQ9o/B5BgWZFj7G+PBb0GGnCjofmVwTXHU
 uOy/McmzFslWKhhXoF3IEYrTX0/06ABl6frOhCGc6bJYUQNBdxhvYjf6
X-Gm-Gg: AZuq6aI0aoWTRUxRwOaOD+TpGN5U40WI7AQbGQOavt11PtLOXMZVlJyaZo7nqyf/Me7
 dkuPB2V3sLBfO3YkpaUnSKcic5gOq8Q69dcCtDCRm4AZGzkHb7D0qAqwq7vVYXHPjwY4q8Buly+
 Ysoyry+fZrGQT9Dgh4jXW+xKvvAcagmCU1RvII1c636GJCPbWgvHDLL1DmKWG+fNVivNtaE+sFx
 MAM3Ili2IjzaxuHNf67MgUFn01j5WW0cKsACxV5oz1+gh/NWSEyEJYC681CooZBd/ad1kZXm3U2
 6sgvZBUfONsx8q2oP4pLcctx3QriwbL8WPUKhAjyA8eB+JUl+emA25TpEtlOLMm4r/myTU/cM6c
 TLuowDu+CuV0eE6NnNqxP21IOATaeyQzeg1btTEospoAfzYsn6hJNR8HD5BTzkSLwoMFeZf82fs
 5UvOd6AtdfyPrhf8aCGUG4BQ9NUaNzF2QwAyG5PkTn41GwS2R7F+ybeYo3joeNG4FGyF4BNETmj
 Sc=
X-Received: by 2002:a05:6402:f25:b0:65a:4090:db4b with SMTP id
 4fb4d7f45d1cf-65ea4ed519bmr1002228a12.8.1771668058070; 
 Sat, 21 Feb 2026 02:00:58 -0800 (PST)
Received: from localhost.localdomain.pl ([89.151.31.85])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65eab9aabb2sm421298a12.8.2026.02.21.02.00.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Feb 2026 02:00:57 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 5/6] fw_env: move "erasesize" calculation up in a code
Date: Sat, 21 Feb 2026 11:00:10 +0100
Message-ID: <20260221100011.29049-6-zajec5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260221100011.29049-1-zajec5@gmail.com>
References: <20260221100011.29049-1-zajec5@gmail.com>
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

From: Rafał Miłecki <rafal@milecki.pl>

Calculate "erasesize" in the same place where other offsets and lengths
/ sizes are calculated. It makes code more consistent and will allow
further cleanups.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 tools/env/fw_env.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/env/fw_env.c b/tools/env/fw_env.c
index 8ca6a3e5478..de3a33a380d 100644
--- a/tools/env/fw_env.c
+++ b/tools/env/fw_env.c
@@ -1007,6 +1007,7 @@ static int flash_write_buf(int dev, int fd, void *buf, size_t count)
 	if (DEVTYPE(dev) == MTD_ABSENT) {
 		blocklen = count;
 		erase_len = blocklen;
+		erasesize = erase_len;
 		block_seek = 0;
 		write_total = blocklen;
 	} else {
@@ -1016,6 +1017,15 @@ static int flash_write_buf(int dev, int fd, void *buf, size_t count)
 
 		/* Maximum area we may use */
 		erase_len = environment_end(dev) - erase_offset;
+		if (DEVTYPE(dev) == MTD_NANDFLASH) {
+			/*
+			 * NAND: calculate which blocks we are writing. We have
+			 * to write one block at a time to skip bad blocks.
+			 */
+			erasesize = blocklen;
+		} else {
+			erasesize = erase_len;
+		}
 
 		/* Offset inside a block */
 		block_seek = DEVOFFSET(dev) - erase_offset;
@@ -1069,16 +1079,6 @@ static int flash_write_buf(int dev, int fd, void *buf, size_t count)
 		data = buf;
 	}
 
-	if (DEVTYPE(dev) == MTD_NANDFLASH) {
-		/*
-		 * NAND: calculate which blocks we are writing. We have
-		 * to write one block at a time to skip bad blocks.
-		 */
-		erasesize = blocklen;
-	} else {
-		erasesize = erase_len;
-	}
-
 	erase.length = erasesize;
 
 	/* This only runs once on NOR flash and SPI-dataflash */
-- 
2.51.0

