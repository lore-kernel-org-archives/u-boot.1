Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57BF3E8538E
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 20:31:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C88B084020;
	Fri,  3 Apr 2026 22:31:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="asWGCi0q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82CA5840ED; Fri,  3 Apr 2026 22:31:20 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D9A984020
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 22:31:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-466f1c3c627so1457534b6e.1
 for <u-boot@lists.denx.de>; Fri, 03 Apr 2026 13:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775248277; x=1775853077;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7dSzG/2xIDeleS6t8dA5nKZo8OCkzxcORwbJs1orvdM=;
 b=asWGCi0qw23dTykE2HWshnkZ3CJbYL4gBgUMHMxLP+0fRvNoqqiBlyThj2OS4LJcqi
 Mi/cT93kkct8IoCz6/18ghhAQPymWGiHY7PlCa/NDr4iI0lnhWGmaC7QLsh7CU7R1ikA
 EEdvweL99bw74wt990i9r37ytpjSHAa+Y/l/kEiWzxkibmzc3aUJ9XoxFjSoDKnwPjqb
 hB5HpDXHDF8ZTFMKniML4QUF1sFvo2DXP7wif1RFsUS3Dou96ThncIQ4zTtM0khd9zmK
 530HGI2ZtednwZq8KAQh2lYI63vSqUrzBFSsfPt4alKGRFrlueJiAQdglwKLuSPXuED6
 FEtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775248277; x=1775853077;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7dSzG/2xIDeleS6t8dA5nKZo8OCkzxcORwbJs1orvdM=;
 b=qnZX5SicbeitZuhMDDE3fU7GEyiFtJfZNXpyL/fbPuvBhYcHPldfyReQCqgnWc6OeD
 3lx2D54XFTLZFP7uVQUzpewI2g47fRMVo/k9l6JWOQdh/inWcnXRdADopxq0BEPm1sdK
 ZtZNp752/6OhmBB6FCnsmsGq25AW72/twiSXr/V8nwv/xfqtQQe70dlWTOdFUbQ1hq5L
 tHMS8gQVojswhNrWsRU8xpMgswVcHsDr2uyfttdp44H4LfA2yGPJ7zrHrZlBMDdJFxqd
 5PE6Ls6cXVVdXbWLfL7EKCODEsEzT/Tkr/EDpf25wgt7ZZrSCSeG12l6/P5IU3QIgvIW
 Rr2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgZzxeamlJBehPTvYdvcTL2QhBFZrsxDmHaWULpS+y081LFB5+sQK4AfdOgZpHgZOs4UV+OzA=@lists.denx.de
X-Gm-Message-State: AOJu0YxcuCu2GZOWkdRtev6tsCHPChNu2t1yk1tehYNQaAYmh7FmD2Bg
 eKgjtJRfjTr+yIxnGhOBnKeZ9m3eJC+xAXBoC+KcbKTvqT3lrty8NAU6xHlnEHtVAt5IRVKIcCq
 y3yI4
X-Gm-Gg: ATEYQzyS2ERYOulfgtdffhsfwQi7wvyyPa6bXMoHkYBZjOXoRMsKJ1i5FOtdyvVZRe7
 gke66MrGl0lZAimYePcLBK7nqOcSkxQQ//lHoktG8gyEZTKyFwRxX7udhxLRhYzTMGJ4ZTGcit2
 sVSSBI1YK3Ca3Hq8pqG/zMF/SKy8ETGqL/mrMGmwho1b3VUQcQW2Gkk6+MbAJql6ORSN1gkq20F
 ycYAX1G01EYReq+wbq40TGHb8t3jOugersgLT6rYASmB5grbaa11fL22yoLfNNtEVbMeOYr8a4L
 uCesIb/BmB5a+y+4+MVQRAj3Pjq8iL9ymQKO+268SZfEn7YTEzC2a5VQXoH0M8a0KW7BI+tsxxw
 1yJIkxH3INK9u9ndD2gSquDtJtXrgVDhuN/jG0Ikl3nT2HqXajrgQcXHV0h8FSRD85Pyac0SIP7
 oiuW8FLM6GywC1KKAg2dmTvoicXggM
X-Received: by 2002:a05:6808:1910:b0:45f:a12:5c88 with SMTP id
 5614622812f47-46efbde63afmr2580150b6e.49.1775248276901; 
 Fri, 03 Apr 2026 13:31:16 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:ffac:9f66:232e:966c])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-46d93271094sm4015965b6e.15.2026.04.03.13.31.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2026 13:31:16 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 03 Apr 2026 15:31:03 -0500
Subject: [PATCH] mtd: spi-nor-ids: add flags for mx25u12835f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-spi-nor-mx25u12835f-v1-1-c9ffdae25d8d@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2NwQ6DIBAFf8XsuaQCSo2/0nhQuthtAihgQ2L89
 9La4yTz5u0QMRBG6KsdAr4pkncF+KUC/RzdjIwehUHUQtVNLVlciDkfmM2i3bjoZGuYuUnRjUr
 yRiooyyWgofyr3oeT4za9UKdv6m8EXLdyl04NpjEi095aSn3lA83krg5zguE4PomA6PemAAAA
X-Change-ID: 20260403-spi-nor-mx25u12835f-f7328a631436
To: Vignesh R <vigneshr@ti.com>, 
 Takahiro Kuwano <takahiro.kuwano@infineon.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1367; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=oEB6lHL/9aXO4J02DxU5vwBiUZY7xGJz3/S8+eKp4oA=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBp0COMniL8amkoWv/+zfskRgBYd+MKnH6XnoxlF
 osvo+3f6X6JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCadAjjBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A8F4H/R6KWQ1oQxuLfFl8RL9RcKNRhg8/DOfdwgXBkcb
 kVCh+3LVE2zxWtlM1J5K0eRttegmRH0tV6+HKNZ26Nx3C5wu+/TQlTweswaJWNHVMpATuXZ7RU4
 rClTXEFMxOFuWpx8hKuwlk6LhvYeGWI9czbKrzNK3cz/bF5T+o04CV5Z/Zd4USO5vIYHPNrt+5q
 uEJ7VlnlAPzR+VgzR2qei7pDT38yzB/mF7DBuwQvOORMijpB/NuSbW6KuZSjwSbmEj+If40nRe3
 9lJ0Lhbsfi4tA5kaJ5kLawZ7Bx9vaQOjFPMTF6y4VUMVOSFyA52fapQ23qVMvUPFHmgqTVuxUcn
 3hQ0=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Add some capability flags for mx25u12835f.

In particular, we are interested in using the lock feature. According to
the datasheet, dual/quad read is also supported.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/mtd/spi/spi-nor-ids.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index e7fea375706..4930fa84685 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -272,7 +272,8 @@ const struct flash_info spi_nor_ids[] = {
 	{ INFO("mx25u3235f",  0xc22536, 0, 4 * 1024,  1024, SECT_4K) },
 	{ INFO("mx25u6435f",  0xc22537, 0, 64 * 1024, 128, SECT_4K) },
 	{ INFO("mx25l12805d", 0xc22018, 0, 64 * 1024, 256, SECT_4K) },
-	{ INFO("mx25u12835f", 0xc22538, 0, 64 * 1024, 256, SECT_4K) },
+	{ INFO("mx25u12835f", 0xc22538, 0, 64 * 1024, 256, SECT_4K |
+	       SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("mx25u51245g", 0xc2253a, 0, 64 * 1024, 1024, SECT_4K |
 	       SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 	{ INFO("mx25l12855e", 0xc22618, 0, 64 * 1024, 256, 0) },

---
base-commit: 1c1bfb1cf34bbb2a5717eb6995c55093279f9341
change-id: 20260403-spi-nor-mx25u12835f-f7328a631436

Best regards,
--  
David Lechner <dlechner@baylibre.com>

