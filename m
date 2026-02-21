Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1246FC61DE1
	for <u-boot@archiver.kernel.org>; Sat, 21 Feb 2026 10:01:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA3C583EB7;
	Sat, 21 Feb 2026 11:00:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S7Rutpjh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6CCD83EB7; Sat, 21 Feb 2026 11:00:58 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0215683E85
 for <u-boot@lists.denx.de>; Sat, 21 Feb 2026 11:00:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=zajec5@gmail.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-65a36583ef9so5634058a12.0
 for <u-boot@lists.denx.de>; Sat, 21 Feb 2026 02:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771668056; x=1772272856; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zfqG2wdnFl9URjyyXKdJ1hk8YQ+nTEcVBaG04wIiu/E=;
 b=S7RutpjhXCcZLGSsPDWmhXfp3FosL4wFrFnWhXDO9n5SlL5qFER70NCCST5JzhARKe
 ZlNUBGsNdC1rZNOx/ALd5GeIEnGYQEU9XLj7llf8EpQtO0EKO7XzKmhAEx1aoJlTL/yP
 mCOuYTypezfXak8QEZ22NjmQerdtyYAaO3d7bP9QFcE+x+oZAVCSBhD7mHK4l+JZNllW
 3wIQKhFb1bX0ROqcqwW42NfQPcdI7wpu3RpkYuAbyle6vvjb5TlhwOkS+qJdJVMcLC1l
 o2jS7n6dRfZHYndWA7MzjV4Gkt3cXSIppORINbTuek1YOkjfmsOh3pBzKHQhb/mtxkRg
 y5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771668056; x=1772272856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zfqG2wdnFl9URjyyXKdJ1hk8YQ+nTEcVBaG04wIiu/E=;
 b=je1150r4Gd0aNaHjKLGl76OaX0ALDgRfraGylGgfsTKgmUhtvICMELt4AEsmJMDvV8
 oHqvu1lFFqG9nmsXFIGlj8v1gGOrTqMPmnKPhwoGMLSczOEUS1G436X3QcBVXeWMm0AM
 deOc4t4QuBvirWxC8pz7ClDPnnRBPqElTZWHT3B2okGy/eSAzC5RC2Mqfwbo/tomur1K
 Y60Bb0peLUZqwmYnZCR6jv/gHgSzNmZizc6LsFagnHSZmDEw6fod2Q7rkCNQaGCV9Q0K
 AwW9gyvpt2xbB7csvXolMx1PayapOr9gXTDxVYVWriDY6vL7+RXE7FkzWi8qgRxOO1QX
 JYGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCdOqfiu2egEOqnTXAAsayPQe6OcDi4CBeyRh1V+fu81kF1IG+ZOCRr6E8zdlZR9psM+PEhWk=@lists.denx.de
X-Gm-Message-State: AOJu0YzNDOXMvpgXDlVkccSrzl0BMwboT+6brVLJc4BsAbdqUS3VE9w0
 SAigS/CS0p4J7IFczPQ4y+GALUQZwhcQCO7TQDE9/YzQJ8JSIghjgIEs
X-Gm-Gg: AZuq6aLsU4oY5a1KMrmVQYJn+OoFXgPlLte1CRL3yOej6/YJBiOTyG1jlEsIgNs/z3C
 GWNRrRZyiH3rpZl90bLT137SZx0eGMgc/Lg5YHSCf93Nsq2s8EyNyJRT0EPpOvAj8vpjZTNwo45
 mWj3fehkQM6ZGGrimoEdqkRopYs6RkdU6+iMfyKG8SWaDRgCh9MDa2B5wsuBiLUNL4Ake8YrD3c
 tOs4S+cXj/K1LxYZjZDCUCFK5LQtuqIc4uIW/xcM2ssoldSZWA2LrZohnCcAinVMikUt2oBA12e
 al/KFr+3v1OmX71cHL7bvdXHKBvnPQl2LaTJOUA1P+x1o/yUuBW9h+Wub1uqHoDxU6eqpLhjVyY
 UkDViwv8BreaymvDqpT6XAJvfHIW28O9ftzh6ISdnrFNlERddLZFli6uNjFD8PKiiLga3yUOmxI
 JWu8EKqS4ndcL4UkgHZQqlxBg1mFkyWM13j4zyBwKAoiSaxkzQ7Bug8WrKjV+gnfs5
X-Received: by 2002:a05:6402:3496:b0:64d:4149:4924 with SMTP id
 4fb4d7f45d1cf-65ea4e4d96fmr1311031a12.4.1771668056392; 
 Sat, 21 Feb 2026 02:00:56 -0800 (PST)
Received: from localhost.localdomain.pl ([89.151.31.85])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65eab9aabb2sm421298a12.8.2026.02.21.02.00.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Feb 2026 02:00:55 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 4/6] fw_env: unify calculation of "blockstart" in
 flash_write_buf()
Date: Sat, 21 Feb 2026 11:00:09 +0100
Message-ID: <20260221100011.29049-5-zajec5@gmail.com>
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

In both code paths "blockstart" is calculated the same way. Unify it.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 tools/env/fw_env.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/env/fw_env.c b/tools/env/fw_env.c
index c369bda1b85..8ca6a3e5478 100644
--- a/tools/env/fw_env.c
+++ b/tools/env/fw_env.c
@@ -1007,7 +1007,6 @@ static int flash_write_buf(int dev, int fd, void *buf, size_t count)
 	if (DEVTYPE(dev) == MTD_ABSENT) {
 		blocklen = count;
 		erase_len = blocklen;
-		blockstart = DEVOFFSET(dev);
 		block_seek = 0;
 		write_total = blocklen;
 	} else {
@@ -1018,8 +1017,6 @@ static int flash_write_buf(int dev, int fd, void *buf, size_t count)
 		/* Maximum area we may use */
 		erase_len = environment_end(dev) - erase_offset;
 
-		blockstart = erase_offset;
-
 		/* Offset inside a block */
 		block_seek = DEVOFFSET(dev) - erase_offset;
 
@@ -1085,6 +1082,7 @@ static int flash_write_buf(int dev, int fd, void *buf, size_t count)
 	erase.length = erasesize;
 
 	/* This only runs once on NOR flash and SPI-dataflash */
+	blockstart = DEVOFFSET(dev);
 	while (processed < write_total) {
 		rc = flash_bad_block(fd, DEVTYPE(dev), blockstart);
 		if (rc < 0)	/* block test failed */
-- 
2.51.0

