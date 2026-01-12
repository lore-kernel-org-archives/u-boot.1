Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C73C9EC88
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 13:12:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF1078399B;
	Mon, 12 Jan 2026 14:09:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J81EMusZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8B1083CBD; Mon, 12 Jan 2026 11:09:23 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B402083869
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 11:09:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chaosesprit@gmail.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-79045634f45so67143197b3.1
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 02:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768212560; x=1768817360; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qg9wRX5589LJ78wB0G7Or7KpUgjaYmGrYmeExB5N1/w=;
 b=J81EMusZ6tu0E9U14Coe2tqDC6cbnT0a7MhNZ2nqzniVyyroy8X99J88yIs0g6YaN5
 fSAU++XqMHhB1zapApd0IEmVq4Z3C5pPvBgaHy8SUNCc5irLuSbOuQhxQGmy9rSqNuve
 aSRmG243VMaOToPD/AenGQSqJhN6Wa+6hY75uTGS0j8wy0+cAzbcn7B6xHOmfuSJkS7k
 bM8CNj6ZaIET4RYbC2/TqS6XJMdFLg8l1Z67P+KrYIilJf3Wf/QlkNw1a+GQI0Wc4Iq3
 j1PQADt4jqyQx6GxrrV89ELkZYXnKolOcIMKGf8Rz9cYVsZAcC8RxerGk4FBBhcvY21M
 StZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768212560; x=1768817360;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qg9wRX5589LJ78wB0G7Or7KpUgjaYmGrYmeExB5N1/w=;
 b=EtQGIBD+lyPIdnnZkji/t3aoOjkM9HrwRgjFZ5M1eKa/3W2ZUhSq46B2X4N/wtOBIN
 Cz7sl+3+XbHrqvytd2ModAf5w4WEPF6RjUiAFJAWQtEP9ghEBZdpoD7nCR+Do2mNi7gi
 mPRW/avukZAaAbKHtnTRow7goBTUXYx/p5r4sG7yrtkbdQs1F80dqzEVPb49TshD5IdQ
 QaPrwnw497DR0ekMGkAJ4A83l144MI0Xi94vClz8ar7vTSNc26OtZXTsMPgzstP1qT8W
 8JrdvEDRVCzJEWYOmIW7GvESFSvGvZJMQ7aYLX66NalvmlS7Ri/VXlGcgPGf6N8JXU+a
 Geiw==
X-Gm-Message-State: AOJu0YxEJUzxAoHhfHcOjAXUHrYlyS2tJsyjpudwAa2+27vT25OwvHMh
 37x/EG1UGR3Fm15PMqYqoGE8E2vZhrdnVYmnK/h1snmlOFpk+kiMPVY5CK828xUr+tiND5FRGas
 =
X-Gm-Gg: AY/fxX44nJ4ECQ/pBRB+HuGAmg8nF5efAYfq6s5PJ4BGitN0J8ipokNpbiN2/JhddKp
 Q3axYMBtjNNdrL0SAGwvMxVKTnutRq6tc4B4HMoTIEZNtyrbXFQktjPjzNV2tb2wWBAZtnAmfGI
 maEesEMU4VnpIDieIteAmYOJPHS/xuKeQ21HYGFp/k8vxPvKosl0dN76t+XFa1FZThurFIxnyHR
 Iz9MjA1HzH6upiBph7bvfTJk28LiahRBYu76yAenyyRX+on0szZzOMrz6sRYLyhXxbpxMwfHdVP
 IDqMbrogUgbehpOYAxLwBVvAXv6nRkckjnmTlOVhKD9+3lChBRS2MLKLE+srTJrDhMY1hLMP2Nw
 T1SJ+JvX/L7a+imKJ47EyaMOthqQvqSQn/bgsE8WBTPBwWuwy3PcGbd7iyLG9ZL3Us40zxfbEAX
 ef0rmkt12FnOzQCwZA5gijAanRX0l9nEJP/ikJZI27xsG6NjOSW5QosM4=
X-Google-Smtp-Source: AGHT+IHq7tORhQdiDP/jYV4tNX+HAdFhjJzsNN7nrctfkq6EWhl6SoBTsCNHxHcuSmDb9PA7dnlSxg==
X-Received: by 2002:a53:ac90:0:b0:645:591a:cb5e with SMTP id
 956f58d0204a3-64716b39f44mr14154164d50.5.1768212560149; 
 Mon, 12 Jan 2026 02:09:20 -0800 (PST)
Received: from omen.cambridgeig.com (199.168.137.240.16clouds.com.
 [199.168.137.240]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-6470d8c500esm7829456d50.23.2026.01.12.02.09.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 02:09:19 -0800 (PST)
From: Echo Hou <chaosesprit@gmail.com>
To: u-boot@lists.denx.de
Cc: Echo Hou <chaosesprit@gmail.com>
Subject: [PATCH] mtd: nand: Fix bad block marking for blocks with specific
 offsets in BBT
Date: Mon, 12 Jan 2026 18:09:14 +0800
Message-ID: <20260112100914.3800261-1-chaosesprit@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 12 Jan 2026 14:09:41 +0100
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

When BITS_PER_LONG is 32 and offs is in the range [29, 31], the GENMASK
macro produces a negative shift count. This undefined behavior causes
the bad block marking process to fail.

Signed-off-by: Echo Hou <chaosesprit@gmail.com>
---
 drivers/mtd/nand/bbt.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/bbt.c b/drivers/mtd/nand/bbt.c
index 4ff0999f62a..0a434a70d5f 100644
--- a/drivers/mtd/nand/bbt.c
+++ b/drivers/mtd/nand/bbt.c
@@ -115,12 +115,16 @@ int nanddev_bbt_set_block_status(struct nand_device *nand, unsigned int entry,
 	unsigned long *pos = nand->bbt.cache +
 			     ((entry * bits_per_block) / BITS_PER_LONG);
 	unsigned int offs = (entry * bits_per_block) % BITS_PER_LONG;
+	unsigned int offs_h = offs + bits_per_block - 1;
 	unsigned long val = status & GENMASK(bits_per_block - 1, 0);
 
 	if (entry >= nanddev_neraseblocks(nand))
 		return -ERANGE;
 
-	pos[0] &= ~GENMASK(offs + bits_per_block - 1, offs);
+	if (offs_h > BITS_PER_LONG - 1)
+		offs_h = BITS_PER_LONG - 1;
+
+	pos[0] &= ~GENMASK(offs_h, offs);
 	pos[0] |= val << offs;
 
 	if (bits_per_block + offs > BITS_PER_LONG) {
-- 
2.43.0

