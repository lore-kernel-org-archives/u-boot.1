Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF5B1C8303C
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 10:08:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 385A782998;
	Tue,  8 Jul 2025 12:08:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="gxshyaTJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C155F83123; Tue,  8 Jul 2025 12:08:30 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0499805D7
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 12:08:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 76F7B3F6CA
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 10:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1751969308;
 bh=Zi456A/SjbubGVpxtYTcNigOhDyaP4EMAZH7NkBkCDw=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=gxshyaTJ2ZZ7venL+dJziTx+MkjCMQrn3Y6dI1paKGBJ7bfV/PJ22O4uU0CeGTlyQ
 cFpl4W/0LXwNNdNiuNgc4Vi67U9XatijxA1Bm1pxZ+CK0KFtjRpAUo4euBXA6BcSUM
 ri3Mv8nRctEq2PFy29axzHgcQVVQLGNF6KKnkUGdL9i43Wt5WBX+zWvGHqwPGZiffs
 xHXUdZnTxkENxqmJeotqu4hPySwaFeVz3Lt44vponrVI06BPH+FlFqAdz88TquV/LL
 zHstxiwVPHblfaq01P49oXnCuhO1vnOnyKQVUy+Afht+74sF6ezIcCe1Q37aGK/ckd
 BcwWCmTvCe4WQ==
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-ae0a0683d6dso397560466b.2
 for <u-boot@lists.denx.de>; Tue, 08 Jul 2025 03:08:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751969308; x=1752574108;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Zi456A/SjbubGVpxtYTcNigOhDyaP4EMAZH7NkBkCDw=;
 b=X8t+elHlNIP1JrW0dfSkQEaqTjqsKlC+H33khkyZ01h9pQbHjDYXOn3J67Oh5wvWYY
 ey6n1UJcqee0L0svHOLyK04yarejf0ZnK9u5Jzg4UEmZhzX90LWFpz+0UR3L44nZR3uy
 6B/CTC8ot/HP48a5uw/bXpY+fzpaJVZIJV+HuTtG7+urGd9DN9nX9rNVbLTy6WKMZi81
 HSMEoyqqfDhT0S9+KhzoPjw9kWX5pZE+GinHoqGY4Ead3PqIdagAygF7WG9YoVtegyde
 ytM9OMrNvXjYFJctxfj+QWagX027wMdgqh4xIg8E9VF1db9yKGqzFRFATYGqnofQ7ogD
 1G8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5Eau1I3u2JAR4SeEMfw3Zw3xoYaqrUcRq7NYjVQSmsqEEbXdIhFTlY6M0smxXlT8dT8meD70=@lists.denx.de
X-Gm-Message-State: AOJu0YyFbMKeVVoVHVAi1o+UjQ2ljha6qVpouMR1e6xFfPmhbcRoRUUN
 Y2i2tgH1nxRvgs5jdKuVAnLNDcKqzPIl33H8LNBBaLdC1JSyeZ3Z/T9QFS1/GXGxes9ZruIwWHM
 ZBeJVvDNhtcvL4NwF9dfgodAFwMiHyKj+woWrb1aE2PNkDLY0lFfgmXDeNb3AWlZjBsy6Fs0fj8
 noW/3/GQ==
X-Gm-Gg: ASbGncs5ctAXu9jglhnFNMbnC4e08EznTlwuNl8jUjZOdgbhqtCrh23nao/+Zg1aCZy
 WtKzuZiOQgJdk6l2jcXpQ0dEVpzZLSkAKDWOWKnMUmcKrtBjMs4tuA2QCpwDfcoJqIhLAY70Ccm
 0F6iH/T+zINx9E7kszmxDKpWOAPT9vJg9e8KEFUWMO3jAeHfH5ZrhKJdQ4jS6R/AcwPJRDuKzGz
 I9pu1BaLd4RwiS86FbkReCvUb5AWo+SisQUpfEpjw6nzJwKshHX+e3onNDJlCU++l4P8KSgsVvo
 ++Gsmh936Nka1N95A2R+oThzav8fc2W0JoIIZ0xJnYFYEXBzJQDJCO2Mm53xNArQitcbSFz00LV
 xRGq0nQ1Ri//bsiU97jA9kvrQ
X-Received: by 2002:a17:907:1c1b:b0:ae1:1a30:6682 with SMTP id
 a640c23a62f3a-ae3fe5ca493mr1568077266b.18.1751969307687; 
 Tue, 08 Jul 2025 03:08:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5CmU/S98XQVjFWz88AR2Q2RgF/D4Rrbo+FqHc/yGuvsb9GL8i3o2HWp/9wKQQYogU3DkMDQ==
X-Received: by 2002:a17:907:1c1b:b0:ae1:1a30:6682 with SMTP id
 a640c23a62f3a-ae3fe5ca493mr1568074966b.18.1751969307231; 
 Tue, 08 Jul 2025 03:08:27 -0700 (PDT)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae3f692ecacsm870756166b.57.2025.07.08.03.08.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 03:08:26 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Ying-Chun Liu <paul.liu@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_loader: efi_realloc() must check efi_alloc() return
 value
Date: Tue,  8 Jul 2025 12:08:20 +0200
Message-ID: <20250708100820.34909-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
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

Avoid copying to NULL if out of memory.

Fixes: 3c08df58cc43 ("lib: efi_loader: efi_memory.c: add efi_realloc() for realloc memory")
Addresses-Coverity-ID: 569499: Null pointer dereferences (NULL_RETURNS)
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_loader/efi_memory.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index 6dfc698a247..b77c2f980cc 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -714,6 +714,8 @@ efi_status_t efi_realloc(void **ptr, size_t size)
 		sizeof(struct efi_pool_allocation);
 
 	new_ptr = efi_alloc(size);
+	if (!new_ptr)
+		return EFI_OUT_OF_RESOURCES;
 
 	/* copy old data to new alloced buffer */
 	memcpy(new_ptr, *ptr, min(size, old_size));
-- 
2.48.1

