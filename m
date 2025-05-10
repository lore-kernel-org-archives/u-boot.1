Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0431C3ABC9
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 13:07:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C51D82AC4;
	Sat, 10 May 2025 15:07:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QdC3FzWW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6227582AC4; Sat, 10 May 2025 15:07:08 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8393682A8B
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 15:07:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5fcf1dc8737so746437a12.1
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 06:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746882425; x=1747487225; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=legQcD1RKrqh50YrtbpE3RosKq7jOWXC9T42QgkD93Q=;
 b=QdC3FzWWb+eqZc7f2VlCKdVUD6LoekXhzLwKx1krP5Nzxugh5ygy/9MrBJ2di/hmiY
 6Yv0nWNX4BsjbWVDgGsPUcXQJuoD7j5JPFs7ca3IRLiqZIMNNGSR8xYkkjCZu4duxfQ5
 0twNDf+quOlE7YsOxqM0be6mQsrIHkb+/adMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746882425; x=1747487225;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=legQcD1RKrqh50YrtbpE3RosKq7jOWXC9T42QgkD93Q=;
 b=T0ArOJQaha2utfIaBTT3xXw/v26Z66WghtZOLZaureU4rZAA9CAwHHGJp889uWf6ou
 HKMJe2Yaz28Q4D9raAT2Zh+Yo0R1/tNL54IHbSZbe6feGtXp8s0UKnle7lMq2ejAQziP
 xy9AOrGheNR6VAbTMDZgf3gTzvIWwOH9sijOzPh9AfasH8Z4rKkD7w6GDhfTQGPrtB1x
 MzRtnHrB5L99qxqY+a9lYtEu5tHR/CFmmNP1B13W6jFfDw5IwjWlLReiRXG6dsZG5ZKD
 D0PABAZ0HlHAFo3EdzSxDBKJSdC5Z3+JedK0bAt3jEJ003I2zhgXIWQRZLGGEdJls7fM
 LiwQ==
X-Gm-Message-State: AOJu0YyUnCiiR2XEeNUGiIhrqpFh+0NbXisEAP4ogu8OWXI1r37Zt9cC
 GflXsBzLQ54H5yPmMRZ6Zk9lPuPNHv2Cjn5kDyoSIEGWH/dIuG74kCl8Hs50cTYIwt+l7Z6bMOG
 9qStYZ1R0Ag==
X-Gm-Gg: ASbGncuio1nrMtKvwsG8pOZfHIoYH9OhZND4JG9ph6tKixKHL12zMvPakxA+TEPXOk0
 zvMX8fKTXV2OcK0R1+YOY80CT/n6aTW163x9vNPT3Md0LFB+bakouvmLOjPH1M1f/w4hL+hnPye
 G2o3lrUBjQ9C0uRr/Od2sq7MzwJzK8UTZBcN3RwUsMZk/dsEZ9KxhQQERD3Vyev13ZenBPimf/N
 pYuDfOJIu7p3RmEoCwwkEJOwYNn+J6qM9MhU9GlfHSFTO8/yJCFWjirjryibxnx5za0hB6gQlA5
 q+3+Z+qLY/tRS4r5246hvvLsuLEpOjlRPbyvasJwKjXrH0s=
X-Google-Smtp-Source: AGHT+IGNfHg7lRRWNPLIK2PO6dq0Rs7rMEcO+0Nq38tjpK2T+NFThQUjlBXZ9tewF3mxs6FWeO0smA==
X-Received: by 2002:a17:907:6a13:b0:acf:15d:2385 with SMTP id
 a640c23a62f3a-ad218f4872cmr672045966b.16.1746882425018; 
 Sat, 10 May 2025 06:07:05 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad24085b44fsm52272966b.149.2025.05.10.06.07.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 May 2025 06:07:03 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Richard Weinberger <richard@nod.at>, Tom Rini <trini@konsulko.com>,
 Uma Shankar <uma.shankar@samsung.com>,
 =?UTF-8?q?=C5=81ukasz=20Majewski?= <l.majewski@samsung.com>
Subject: [PATCH v3 05/10] ext4: Check for overflow of block count
Date: Sat, 10 May 2025 15:06:11 +0200
Message-ID: <20250510130642.1575114-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250510130642.1575114-1-sjg@chromium.org>
References: <20250510130642.1575114-1-sjg@chromium.org>
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

An overflow could cause too little memory to be allocated, thus
potentially causing undefined behaviour. Add a check for overflow.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 fs/ext4/ext4_write.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/ext4_write.c b/fs/ext4/ext4_write.c
index 86420d1c9d7..ae26354fbb2 100644
--- a/fs/ext4/ext4_write.c
+++ b/fs/ext4/ext4_write.c
@@ -25,6 +25,7 @@
 #include <malloc.h>
 #include <memalign.h>
 #include <part.h>
+#include <linux/overflow.h>
 #include <linux/stat.h>
 #include <div64.h>
 #include "ext4_common.h"
@@ -111,7 +112,8 @@ int ext4fs_get_bgdtable(void)
 	size_t alloc_size;
 	int gdsize_total;
 
-	alloc_size = fs->no_blkgrp * fs->gdsize;
+	if (check_mul_overflow(fs->no_blkgrp, fs->gdsize, &alloc_size))
+		return -1;
 	gdsize_total = ROUND(alloc_size, fs->blksz);
 	fs->no_blk_pergdt = gdsize_total / fs->blksz;
 
-- 
2.43.0

