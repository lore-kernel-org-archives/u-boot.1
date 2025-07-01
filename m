Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF985C7EE30
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 16:07:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1074082F6A;
	Tue,  1 Jul 2025 18:07:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="GnxQqz6d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D322082FC7; Tue,  1 Jul 2025 17:16:10 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD2D482F71
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 17:16:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a5257748e1so2268550f8f.2
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 08:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1751382968; x=1751987768;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DI6K/aIdpuSnX15tFEx2SJeo/7Da+vJWPzriBsx9UMk=;
 b=GnxQqz6d6iNzPvcVxLXinSei31AkSEm85vR/fSLJ+h9s2CHewWP7XRphuxwkGBFblo
 xD5yOd8+LZ1ZLqVB6233PX0HC5OS8rUMhkNfTpulc7FCKKrmw+H9vBOEqvAbp+om96B9
 3s096apzAXGbRoEDFzHS1AP/q9p+0ek7O0GLJcOOxKsIsLpTmn0P1UuMsj+OC9j0KgJB
 c84cOfWW6l1Drq/V5HAvYM/+NQAR/nPv6Ynw1663VuCugG/kgcxyaqNhy7Pg6CgwrSni
 hLKw0wimaObWwfgWjrAVace6FqNX9TRDl6eFtCeC1cyKEVKuoolwq2wzZuVv4Uzr2Wvl
 N2VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751382968; x=1751987768;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DI6K/aIdpuSnX15tFEx2SJeo/7Da+vJWPzriBsx9UMk=;
 b=EkP3ywVbfHLxfS37XueO/hEjBHqBfY48hYS5plXsAssf2KMmR2fEk2wV6b/CzehqbB
 4IQ7xjytUoM6bvChcy2ExJXjiV/V9G+KHLdCjUN3aCgb4eoXbIsp0/PwMqYBvUv49UmH
 QQ9BopG7BcfuwA1VDAbyCa3suMjmtGjfgO6BwrG291CZZunJj4spA+BpIgFrnx59Kgs/
 8eTlmAmcJ49HdOpTSGgo0SYI91lq/iMH/lgV4tMA/9R3RGypGrtIKSvTkglAaO8paZW1
 JT3egRgXIE1dc4TaoO5F4kFp3tTS3LY0VWST2FTs/9AO/6wOdiIuCSuaXwpUXMT+r2xP
 ZlKQ==
X-Gm-Message-State: AOJu0YxhhXN0zAr1Lk/cFZyEnMjskJHQgBXi0UCotR5Xy+0oMlbRBljP
 R9B6zurLv4Uy1H79RNvPzN06ic4fA8WmKwQXwfY7m77RQVkxmm0G3GbeGVM2zdszrPpyvW2QI5o
 06bK6UPY=
X-Gm-Gg: ASbGncsa+HViGcjZgfWadah4gE4siZ5kxNUroTrTGmGkno6YV1tuBXJYj8sNDRavU75
 2Rrfh5H3/DYHnwamB8QVDWpVk7V/B8U8xKnZw9/NOvxGGz2HHt0QKp38hXjNMRZhDxNfrt/HbXD
 H8D+ZZzwu/0MbZTx6M7AyvIM/iBLdmsHTowLBETunBWzsUs77FraKYr4TKO1U6yFQWRSBnzB+Kf
 nNVNotP8D2w50uMgNglFAu1pmsY1oNcVkt4FOxoQEJPFTji3rkYsi3OHFb0T70L095nlIiaQ9gu
 V0GyYDD8YrLk86P+OZuiZjwj5Dbna7ZH9/AZf0+41b80EjGfaQqfO7huuHc4
X-Google-Smtp-Source: AGHT+IG7VC5ui80n2H3txNMKXQYwOCKb4FnIe4Oa/ik/Mv6YtsqzzX98fSe9j6IMZHJNwPR7SGVBOQ==
X-Received: by 2002:adf:e182:0:b0:3a4:ed1e:405b with SMTP id
 ffacd0b85a97d-3a9000a803cmr14702281f8f.46.1751382967966; 
 Tue, 01 Jul 2025 08:16:07 -0700 (PDT)
Received: from [127.0.1.1] ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-453823ad247sm205793515e9.26.2025.07.01.08.16.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 08:16:07 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
Date: Tue, 01 Jul 2025 17:16:06 +0200
Subject: [PATCH] mtd: spi-nor-ids: Add support for AT25SF321B and
 AT25SF641B
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250701-nor-v1-1-ca3435d582d2@hifiphile.com>
X-B4-Tracking: v=1; b=H4sIALX7Y2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDcwND3bz8Il2D1FQjg2QzY4OkZBMloMqCotS0zAqwKdGxtbUAhDfJGVU
 AAAA=
X-Change-ID: 20250701-nor-0ee20c630bc4
To: Jagan Teki <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Zixun LI <admin@hifiphile.com>
X-Mailer: b4 0.14.2
X-Mailman-Approved-At: Tue, 01 Jul 2025 18:07:44 +0200
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

These flash chips are similar to AT25DF321A with Quad I/O capacity.

Signed-off-by: Zixun LI <admin@hifiphile.com>
---
Tested on SAM9X60 custom board.
---
 drivers/mtd/spi/spi-nor-ids.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index e7e97780d7cdd27104fd7db900b3a779d2188922..18bc6f2f06e9a02594da6ad1880489e78458a60f 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -76,6 +76,8 @@ const struct flash_info spi_nor_ids[] = {
 	{ INFO("at45db641d",	0x1f2800, 0, 64 * 1024, 128, SECT_4K) },
 	{ INFO("at25sl321",	0x1f4216, 0, 64 * 1024,  64, SECT_4K) },
 	{ INFO("at26df081a",	0x1f4501, 0, 64 * 1024,  16, SECT_4K) },
+	{ INFO("at25sf321b",	0x1f8701, 0, 64 * 1024,  64, SECT_4K) },
+	{ INFO("at25sf641b",	0x1f8801, 0, 64 * 1024, 128, SECT_4K) },
 #endif
 #ifdef CONFIG_SPI_FLASH_EON		/* EON */
 	/* EON -- en25xxx */

---
base-commit: 4d3b5c679bc9d5c6cbbeedcc1e4a186f1cc35541
change-id: 20250701-nor-0ee20c630bc4

Best regards,
-- 
Zixun LI <admin@hifiphile.com>

