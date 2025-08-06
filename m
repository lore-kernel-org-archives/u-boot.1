Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E11C87FD3
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 14:58:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74DA583A9A;
	Wed,  6 Aug 2025 16:57:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WcnGG+29";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BE1D8431B; Wed,  6 Aug 2025 16:57:00 +0200 (CEST)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E57A784301
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 16:56:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-61997c8e2a1so594169eaf.1
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 07:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754492217; x=1755097017; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Dc9rU6416qG7z+PyvtkSvZLVH1VPSaD/z3/9aMZQ/fo=;
 b=WcnGG+29yDCdPLkS2p6bx2uvVBf1CqM+vz24dGHZ+G6ds/TC7+CYmK817xhZ9l+qmY
 OZCoTFjX22KiMUc1AgpcOQ//YJnKXbdB7VirWAbpHoaPARHmpdeTTQFigChaP302VrAD
 JP1dwDUN40QqzXiPicTwZTW/27LUYEY0786zw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754492217; x=1755097017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dc9rU6416qG7z+PyvtkSvZLVH1VPSaD/z3/9aMZQ/fo=;
 b=PG9l0kt1yljfZTirUnXT6dQRHXs7FqYkLRFnYHMkD0MhhVhlZTTfjrAMRDaheU+JZ2
 8DifVUGrTUoTbIIWF0of/f7lmi0LtypZgKOYIJegkz5YfiBQFuuBkMccjv2KbKVP3bK0
 w8c8wN23NcsnSNOszrGLAGN5pFqDZHmyod4uYB6DMisa5QbWCRx3C9jLEj1Rr7zO5zlK
 43rB2Ui+7VxSKYQdWTpJ6erQ2BpPMdgFtB5abGL4hA2M6mCmS02wscflZjpneEtkgpR8
 DA+h67rabytmdnj35fJw6yyO7Bxek9Xa+DxbwuHnQCuwdi9DgPakbLchK0bImo51THnJ
 ncMw==
X-Gm-Message-State: AOJu0Ywkl7s92dipkFeVH7L/EVC6oO8kQgTfMueXt35RAMp3pUxklCwB
 /i/nQmSEM/b30D1zBhuwavEVKKzp+4UdjwFzScZOt36gBH2YcDX5RgqNDnF+7BF4Y44xJxYhi0z
 lGfbn9Kw=
X-Gm-Gg: ASbGnctt7ScvDHFWajFqDX0yzvGg7/1g1YoXSvT2qWo/locGy2LxH7JJdiRAgcBpbR+
 b1YtQgEuW5daOYH8SqBcP2W72ApheYm3xd88Mkl7MZoOQnc8wc9GXx9Yd15JgVHDemU1wlHIJEx
 JchTCg/7A6MJ9AtVe+Ip1T6GMxVtX0ai3C//s19auZ8RPccT73OApgLg7a6VmPx0xIq2nIuWiRu
 Uj6tbTW3K1lwAcLdTO1wKuQPxBt81zti+AU+z/ALmI5xUi1pqHNQbg2TL/EqJnvYMu40qYKqKz8
 7r/r2Mahy7aDApbmKl/JYlu9NdcWUVXlPyaijjz9+EuLHxNievtdvcF+8vpVtomGv5tUyJAFybp
 +n2vzgzHUQximjUBgYOWRphgwD0CXKTtyQyGV3uGR9BQtBYDd1c/8EwrXqMxNkwtlG/+DmQ==
X-Google-Smtp-Source: AGHT+IFzXMxKnwgefV7YNzhZYAtWwanzQF1blmsW8Ci39tyF1EJK9mGv6zDu6S1+FV2Dd5Hm9SsN/g==
X-Received: by 2002:a05:6820:5203:b0:61b:5f26:7059 with SMTP id
 006d021491bc7-61b5f88373bmr1530524eaf.4.1754492216568; 
 Wed, 06 Aug 2025 07:56:56 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6199c99b222sm1644790eaf.28.2025.08.06.07.56.56
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 07:56:56 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 8/8] video: stm32: stm32_ltdc: Add missing <linux/sizes.h> to
 stm32_ltdc.c
Date: Wed,  6 Aug 2025 08:56:49 -0600
Message-ID: <20250806145649.1664724-8-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250806145649.1664724-1-trini@konsulko.com>
References: <20250806145649.1664724-1-trini@konsulko.com>
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

This driver references the SZ_ macros while relying on an indirection
inclusion of <linux/sizes.h>. Add the missing include directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/video/stm32/stm32_ltdc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/stm32/stm32_ltdc.c b/drivers/video/stm32/stm32_ltdc.c
index 0a062c8939db..1281acaaadee 100644
--- a/drivers/video/stm32/stm32_ltdc.c
+++ b/drivers/video/stm32/stm32_ltdc.c
@@ -20,6 +20,7 @@
 #include <dm/device_compat.h>
 #include <linux/bitops.h>
 #include <linux/printk.h>
+#include <linux/sizes.h>
 
 struct stm32_ltdc_priv {
 	void __iomem *regs;
-- 
2.43.0

