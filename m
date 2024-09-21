Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B70DACF9C5B
	for <u-boot@archiver.kernel.org>; Sat, 21 Sep 2024 11:35:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 216A488413;
	Sat, 21 Sep 2024 13:35:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HozzNdvO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C48088646; Sat, 21 Sep 2024 13:35:22 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E2F38839A
 for <u-boot@lists.denx.de>; Sat, 21 Sep 2024 13:35:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42cc43454d5so22686165e9.3
 for <u-boot@lists.denx.de>; Sat, 21 Sep 2024 04:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726918519; x=1727523319; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pYnvKvnMobjCfMamjr2yAUbqdYEIJX8aFuLMJy3s7hs=;
 b=HozzNdvOwPhdQ6Q3cBdfhGL+DtPAXhOgiesW7nq0oaOdJ4DopqT+VUA5WDsifxiykb
 QGRcU0+ZKdxyimFS5xE8yHkviaxgo1J80bX/uxJBusRpICFzbk6fV3gZa8wUfFASz3/O
 XFexcAkv5etS5N8rei7qtAT7WB/nugRXRM2iw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726918519; x=1727523319;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pYnvKvnMobjCfMamjr2yAUbqdYEIJX8aFuLMJy3s7hs=;
 b=uoSVeYiQVhnXqas1ghdmIVJ2U54nYF+9I/NzGbNdYhsfHkLQxkiR5Ie5HbA/kgYtr9
 w46fIdBRBZ5+U58fzFttJFIrrtwnbnf51ie2ixN7Aa8/oisfL5iWhieRot+Ffl6Rlg2c
 AJsJtgqWYuQ55hwXXOw3nTj9gTBEhn/2qinfy9MvmSl7nDLk6tUzK6qx0Z2EEKgqKv8n
 Cz6UHd/cbh50wmoz+Am5ylefEvoNY1AW6KGcfZmCv0kGXrSw/PhGkTPeut1oafWgJA5b
 HKtquqo6ZtwXld/n73VnjXAlQ32WWDLDIaOI7Kh3rTXCAlUDmjJWPuivxgVue9wx0pHJ
 27AQ==
X-Gm-Message-State: AOJu0YyOKBcqV+kJDakA6k7Wanu21Ci0wERMHYiJskzPyHGcwPfIpH56
 oqZKhxHa37YLpdCckKsDAN3tGdUqq4p4LvPhkK5avohkLWa5ynng+KLFMZhfMihG21HlWZfzGtQ
 xKlEz
X-Google-Smtp-Source: AGHT+IGMJm9tehTqlM8IcnwEX8L6oX2iEh6UA+8p+uFCw+83p7w7Cs0vtQAQu4OqPD0ZXzi4e0HP4w==
X-Received: by 2002:a05:600c:1550:b0:42b:af5a:109 with SMTP id
 5b1f17b1804b1-42e7ad8b143mr34236765e9.24.1726918519258; 
 Sat, 21 Sep 2024 04:35:19 -0700 (PDT)
Received: from chromium.org (82-132-231-226.dab.02.net. [82.132.231.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e7afec0c3sm47667425e9.37.2024.09.21.04.35.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Sep 2024 04:35:18 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 05/18] malloc: Show amount of used space when memory runs
 out
Date: Sat, 21 Sep 2024 13:34:33 +0200
Message-ID: <20240921113450.319072-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
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

Show a bit more information when malloc() space is exhausted and
debugging is not enabled.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Add the missing word 'not' into the commit message

Changes in v2:
- Add field names into the message

 common/malloc_simple.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/common/malloc_simple.c b/common/malloc_simple.c
index 5a8ec538f8f..f0f90a095bd 100644
--- a/common/malloc_simple.c
+++ b/common/malloc_simple.c
@@ -26,7 +26,8 @@ static void *alloc_simple(size_t bytes, int align)
 	log_debug("size=%lx, ptr=%lx, limit=%x: ", (ulong)bytes, new_ptr,
 		  gd->malloc_limit);
 	if (new_ptr > gd->malloc_limit) {
-		log_err("alloc space exhausted\n");
+		log_err("alloc space exhausted ptr %lx limit %x\n", new_ptr,
+			gd->malloc_limit);
 		return NULL;
 	}
 
-- 
2.43.0

