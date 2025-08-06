Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED4E5C87FCB
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 14:55:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BB2C83A6A;
	Wed,  6 Aug 2025 16:55:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sp3wI+n4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C792A83721; Wed,  6 Aug 2025 16:55:27 +0200 (CEST)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 484A783A61
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 16:55:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-61998205433so1482892eaf.1
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 07:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754492123; x=1755096923; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a8EfOihbpKVcEYNp0YnH1xNbXgGHB7stlaogVp9GpVs=;
 b=sp3wI+n4oK/YtZe2yct0iQa4LyyAdobCmBbnHBkVzsEEOVCEv6m+g08o+8jgKqzbAT
 DCKCcV6Yn0ISszCTtkI7oCJJ6bKBRKTjv/yL4Gz7WDsdpMrYYsw11vVUF08JNGZAstFw
 PqEFq/lmdMvQDTD88zA38EgNbfcr/uhWx8Bgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754492123; x=1755096923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a8EfOihbpKVcEYNp0YnH1xNbXgGHB7stlaogVp9GpVs=;
 b=Hpgn8XIul/SZXD1o9KmexYmPZ2iAC/B4auD/HTdAsanNlkGgnArQlsheWslN6pnf6K
 o7P+HMvwb5YgnC7Dc8Slb3boRPHen+61849+zJghwowym2/HmY009cuig9FCPD20yQMw
 /t+d05obpjswESsHOOTnj1S99ftvgvqDc+mefQiWTixZrcyy98MTc1bBh49YwRz0j7MV
 grvN/p7tQWeiG1hsPWH7YElL7TgEWYG8nvMwPYbD8u/Jr/S44J575TBvrukV2zn159el
 43UVvrZxcznbc5sGoodssZ5s+wkDQm6wSkqfr3xoRHKZ0dQq5DKfVbDoYSxzYEy8+4KD
 s7TQ==
X-Gm-Message-State: AOJu0YzIYeLfdFNb13SA1eZJIfndG6JkCN4RQqGAa1vXah4etfRAcZtP
 5xhT68r0Gqoy3E/i1z9RKilfRkxlTJl6lb8t8HD90hTPd0cdOGeQ/Utqas2UdzZ5G5zZ5IVqiNN
 UyvunfjM=
X-Gm-Gg: ASbGnct62Ln39meO5EQ5/A+0y26ZeRsi3oeEj9umva/QaBulMo4in//uhTC3Py+p0ZD
 Z5EoIIwisqdwxj4X0mC64MZ0RQQzYe08fq3muTTIzqS/p0qdDoroPAhb3s5/1pOckxYix/vSiMQ
 KiNJPhoZj8imkvKXbBptZw6oIhq9LL3MiR+W/dUqf7QNTMoAfnQh24HyNQlbpyFdXqxrzslQhEa
 SkNoTMbsfYYYrnTZ8JkBQmXJgCK5yL92LxyKygRxwXH7SxeDhceI5F8ygBf7TDjtvbYpiub3mLt
 mmOJJDInp16DpjkQIT3AQ7LBw3nRCO28bFUKbsTmIcFhdZIUXOax9YdzPQyfpuy4AnwoiybWz8D
 /AOFlFrhEU6z8rU3hys3clu4yV16OvvIAKsvHOgtNDSGbuCIoSG3IcQ4R5MfqN35wJP5n7w==
X-Google-Smtp-Source: AGHT+IE//2I9/B6g4V/OyB517waT75LcTseMLQOmWuQCpKl6B8PSMYcjFJa76Zp4eSuBWXi3+24KAw==
X-Received: by 2002:a05:6820:1886:b0:619:a8f7:dfa6 with SMTP id
 006d021491bc7-61b5f0dead8mr2148487eaf.0.1754492122697; 
 Wed, 06 Aug 2025 07:55:22 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61b4e4ac995sm615670eaf.18.2025.08.06.07.55.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 07:55:22 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH 2/3] tpm: cr50_i2c: Make use of 'z' for printing size_t
Date: Wed,  6 Aug 2025 08:55:18 -0600
Message-ID: <20250806145519.1664444-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250806145519.1664444-1-trini@konsulko.com>
References: <20250806145519.1664444-1-trini@konsulko.com>
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

When printing the contents of an size_t variable we need to use z prefix
to the format character in order to get the correct format type
depending on 32 or 64bit-ness.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 drivers/tpm/cr50_i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tpm/cr50_i2c.c b/drivers/tpm/cr50_i2c.c
index 5b2d5ccb1460..14a94f8d4a8e 100644
--- a/drivers/tpm/cr50_i2c.c
+++ b/drivers/tpm/cr50_i2c.c
@@ -388,7 +388,7 @@ static int cr50_i2c_recv(struct udevice *dev, u8 *buf, size_t buf_len)
 	int status;
 	int ret;
 
-	log_debug("%s: buf_len=%x\n", __func__, buf_len);
+	log_debug("%s: buf_len=%zx\n", __func__, buf_len);
 	if (buf_len < TPM_HEADER_SIZE)
 		return -E2BIG;
 
@@ -465,7 +465,7 @@ static int cr50_i2c_send(struct udevice *dev, const u8 *buf, size_t len)
 	ulong timeout;
 	int ret;
 
-	log_debug("len=%x\n", len);
+	log_debug("len=%zx\n", len);
 	timeout = timer_get_us() + TIMEOUT_LONG_US;
 	do {
 		ret = cr50_i2c_status(dev);
-- 
2.43.0

