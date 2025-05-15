Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C231BC2D0CD
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 23:43:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F82D82B00;
	Fri, 16 May 2025 01:42:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KnbOMfCA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A74788059D; Fri, 16 May 2025 01:42:11 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A344B8129F
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 01:42:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-72ecb4d9a10so1874450a34.3
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 16:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747352528; x=1747957328; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9d9hm+R9t8Yn133RAZuWxU5qwEGTRfbBzZERR1IXb6U=;
 b=KnbOMfCAr/4Kk1aXaW9bJrUZRGOpSJHD1JALvyplAXwPkwGXk4vqslbsj7ihYk98XD
 fkMvsf/HtimtHlPoAGCmxO/u1mK4Oomyd8vqB1SbTPHRgWS/A0KbvxArjgMubXFts0lV
 ZYkImbAn65UjTBxNz9cXkSWtnsf8l2foY5J1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747352528; x=1747957328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9d9hm+R9t8Yn133RAZuWxU5qwEGTRfbBzZERR1IXb6U=;
 b=RWpHufKQOGsGq4n/inAYlhZXoe7DyXmyhSjb4RPFaR9MfzLhOPytLhrQyE1REF4mrT
 NNMU7x0Kuq+6RdUFktKM245k3mxwA7gNWCOWdhaUpZwKx6O9UuxSSIDqvWfCqtNp7KM2
 t/E9g5QWEeUNXmg9ERIo5wLv2xmt9Pgb0AODS6ZY2jHhGD7f8Ee28Ymq0BKlC1UUnvjS
 JlnFm3a9GDIMx6LzoHwRYepHZiIoBCCFrDRGC2Sc8x+0oUjqVyZzAYuRkkJzDquGPgKg
 j6Vh3OT5PsrQQZzNP+ViQKXaX5iHwKuiy3cbNJwU4wOhUiO0BCOmIxjnaFTpxr7wrTSo
 r6lw==
X-Gm-Message-State: AOJu0YzPwOqQYD3WGad+naFeJdTx0gTnrE8R/aCTM+okTUtqcd9iQCyQ
 bCleCks+yVoFM5n8SpolGlPcQUefFXvJM9jZUuzRjqIoHXHL1uOu27Ic9LBhDngIq/FI8zBqjJJ
 zvU990Jk=
X-Gm-Gg: ASbGncsv5cxqjVnMB5CafgF5jAIPgkivZglNP8Qbv1d1SuiZXk2MpuYgawfzKt5+0Lh
 LFgxo0ZIhKSUEBvoqfC0krWAu2gmX+JtaB10mveeakCOLpn/DpdwshQ5EhG4S0miFACRvIRGUF/
 Bp5hqYL1mFQ2HZsYMV4RlV0W9UnU7VjsQhFh6zTk7jc8SFgxtMc+yjdxDDkfNE8Suj6rmjYh06u
 Uf7DvWH7dUMhqaDoZKgO98P22MPIRonbFzKG65VqMhukxcdxafzSxaQxaWMUh1m4/SFmhk5m9by
 F0YBg1KfQk+Q+v1TNahbibFEYqCPPHuoir53fKrHNsPaJlcsWi0RNaYL1qW45qbeWkw+qxoZ8Li
 +1ryFA7yW9dYWK4o=
X-Google-Smtp-Source: AGHT+IFLZEXnFxKTLxhP0HFqHAhT3Cjhy1bT39Ldtb6M3+m0CowrQjrbMXJKpS5u3ybhagr8ALfG+Q==
X-Received: by 2002:a05:6830:6999:b0:72b:8ec6:e533 with SMTP id
 46e09a7af769-734f6ad78aamr960581a34.7.1747352528416; 
 Thu, 15 May 2025 16:42:08 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-734f6b3a9b3sm147559a34.52.2025.05.15.16.42.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 16:42:07 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 08/22] ronetix: Include env.h to permit reading the
 environment
Date: Thu, 15 May 2025 17:31:37 -0600
Message-ID: <20250515234154.1859366-9-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515234154.1859366-1-trini@konsulko.com>
References: <20250514225002.15361-1-trini@konsulko.com>
 <20250515234154.1859366-1-trini@konsulko.com>
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

From: Simon Glass <sjg@chromium.org>

This file reads from the environment but does not include the correct
header. Update it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---
Changes in v3:
- None
---
 board/ronetix/imx8mq-cm/imx8mq_cm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/ronetix/imx8mq-cm/imx8mq_cm.c b/board/ronetix/imx8mq-cm/imx8mq_cm.c
index fbee2c39771e..602216854ba4 100644
--- a/board/ronetix/imx8mq-cm/imx8mq_cm.c
+++ b/board/ronetix/imx8mq-cm/imx8mq_cm.c
@@ -3,6 +3,7 @@
  * Copyright 2018 NXP
  */
 
+#include <env.h>
 #include <miiphy.h>
 #include <asm-generic/gpio.h>
 #include <asm/arch/imx8mq_pins.h>
-- 
2.43.0

