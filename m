Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 517C2C4828D
	for <u-boot@archiver.kernel.org>; Wed,  7 Feb 2024 15:11:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AAE287C9A;
	Wed,  7 Feb 2024 16:11:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m56250X4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96DD487C8F; Wed,  7 Feb 2024 16:00:24 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A95787CBC
 for <u-boot@lists.denx.de>; Wed,  7 Feb 2024 16:00:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=resch.max@gmail.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-33b18099411so532169f8f.0
 for <u-boot@lists.denx.de>; Wed, 07 Feb 2024 07:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707318021; x=1707922821; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cA5BaY7BKrIbOfE4vlzzjRyTADTD6IiszULgHx5+zG4=;
 b=m56250X4ShD76BoSAjKdNNwauQrVzUG7zBHC5astrCxcMxbeYyMhNe6ZJzyM5TMMIJ
 GzL8QN4TV996GiizzUZtDuhEPSuvCiN+Vq6ifj1aDU1bgyb+7Hb30eFoC9dyH4d7JMaJ
 zCvt1pYpXMdD+7RRg3gIDoBmb1+YQgrgC6VZ3DEqBKXNhzRFrM45jg7EQuXw88SkzcMZ
 actTPHCdnMxPv+JS8k5Uj9T9pREuaKryhZ3gpSLXkjufsuhnmR9UuErjRofug3QMRDoT
 VZENmfa7sfQXEKE0+cS+A+Td9C/FhtKz1Mtd0CogCftgzDNVmJFUTmWbCRcjouPJtqSX
 d+/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707318021; x=1707922821;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cA5BaY7BKrIbOfE4vlzzjRyTADTD6IiszULgHx5+zG4=;
 b=ZWdQt6NLNLnrL5/G85ZjP6fhnvfi1AA7iu95iaLPmlkXWuqGLILBI0OzKCOBaz79kk
 lIg7wk2zPSV3WXmUKFJqjcvZS2L8CjRUEXXC9jQel60cIfg2ES/2mDziqMfxAYjFx96J
 Ozq31jQktV+5SHFZACVxF6RdZOjT6OpLh/cbLabAJ2iG1zLOMsofq+SsIQC8V8al4xhU
 OwReW7XQJqlNgWd4RlEwJdBjXrAoGg7AaNKAlkGb0D8WmaBKwP/pKWJms++cZgcP4AAb
 5rv+p/diPJ0IiSN9ZUqlf3GLXPsCZxWEdlQbpfSuCzQ8UAHIeSKGp31wfNoa+tl6rm/E
 vUEg==
X-Gm-Message-State: AOJu0YwjShkrnQlJJiHVOywzMpTALatqUfHCsorcymyTD6H5fwWcnTwD
 uBWM3AJn2aj+c8uGldsw8kvTLrtAGOQ5UHb4yQaGWZuINkKp0K8+fDMWrtEiErY=
X-Google-Smtp-Source: AGHT+IFcZ4rq+jOPCf17BaZkU8sdXz+o42DP/1XQ+D8dbOj08rQT/XWuo9MIihCvFtADKgIm1Ib8mQ==
X-Received: by 2002:a5d:64ab:0:b0:33a:e4b9:d810 with SMTP id
 m11-20020a5d64ab000000b0033ae4b9d810mr4829596wrp.40.1707318021126; 
 Wed, 07 Feb 2024 07:00:21 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUjOSKLDDM88B9ayHXBnYrYVa1Zd9qn0AVbG1gb7MghDuRLBAHfO+dso/IhJE0BSW9Irye8dTuGZntWp/KFpTfVQLaj
Received: from niflheim.lan ([2001:871:223:9d90:4a25:3e0d:c47c:bed7])
 by smtp.gmail.com with ESMTPSA id
 m6-20020a056000024600b0033b40a3f92asm1693220wrz.25.2024.02.07.07.00.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 07:00:20 -0800 (PST)
From: Max Resch <resch.max@gmail.com>
To: u-boot@lists.denx.de
Cc: sr@denx.de,
	Max Resch <resch.max@gmail.com>
Subject: [PATCH v3] rng: Add Turris Mox rTWM RNG driver
Date: Wed,  7 Feb 2024 16:00:12 +0100
Message-ID: <20240207150017.666213-1-resch.max@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 07 Feb 2024 16:11:43 +0100
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

A RNG driver for Armada 3720 boards running the Turris Mox rWTM firmware
from CZ.NIC in the secure processor.

Signed-off-by: Max Resch <resch.max@gmail.com>
---

Changes in v3:
 - More meaningful variable names in accordance with review

Changes in v2:
 - Removed ring buffer implementation

 drivers/rng/turris_rwtm_rng.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/rng/turris_rwtm_rng.c b/drivers/rng/turris_rwtm_rng.c
index 143fe0b47f..ec2cb0bca3 100644
--- a/drivers/rng/turris_rwtm_rng.c
+++ b/drivers/rng/turris_rwtm_rng.c
@@ -41,18 +41,19 @@ static int turris_rwtm_rng_fill_entropy(phys_addr_t entropy, size_t size)
 
 static int turris_rwtm_rng_random_read(struct udevice *dev, void *data, size_t count)
 {
-	phys_addr_t p;
+	struct turris_rwtm_rng_priv *priv = dev_get_priv(dev);
+	phys_addr_t phys;
 	size_t size;
 	int ret;
 
-	p = ((struct turris_rwtm_rng_priv *)dev_get_priv(dev))->buffer;
+	phys = priv->buffer;
 
 	while (count) {
 		size = min_t(size_t, RNG_BUFFER_SIZE, count);
 
-		ret = turris_rwtm_rng_fill_entropy(p, size);
+		ret = turris_rwtm_rng_fill_entropy(phys, size);
 
-		memcpy(data, (void *)p, size);
+		memcpy(data, (void *)phys, size);
 		count -= size;
 		data = (u8 *)data + size;
 	}
@@ -62,7 +63,7 @@ static int turris_rwtm_rng_random_read(struct udevice *dev, void *data, size_t c
 
 static int turris_rwtm_rng_probe(struct udevice *dev)
 {
-	struct turris_rwtm_rng_priv *priv;
+	struct turris_rwtm_rng_priv *priv = dev_get_priv(dev);
 	u32 args[] = { 0 };
 	int ret;
 
@@ -76,7 +77,6 @@ static int turris_rwtm_rng_probe(struct udevice *dev)
 		return ret;
 
 	/* entropy buffer */
-	priv = (struct turris_rwtm_rng_priv *)dev_get_priv(dev);
 	priv->buffer = 0;
 
 	/* buffer address need to be aligned */
@@ -89,10 +89,10 @@ static int turris_rwtm_rng_probe(struct udevice *dev)
 
 static int turris_rwtm_rng_remove(struct udevice *dev)
 {
-	phys_addr_t p;
+	struct turris_rwtm_rng_priv *priv = dev_get_priv(dev);
+	phys_addr_t phys = priv->buffer;
 
-	p = ((struct turris_rwtm_rng_priv *)dev_get_priv(dev))->buffer;
-	dma_free_coherent((void *)p);
+	dma_free_coherent((void *)phys);
 
 	return 0;
 }
-- 
2.43.0

