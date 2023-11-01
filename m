Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EECEC4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 16:30:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F388787D4D;
	Wed,  1 Nov 2023 17:28:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JZJ4hwTm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F4A887D4D; Wed,  1 Nov 2023 17:28:46 +0100 (CET)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 871DC87D21
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 17:28:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6707401e1edso106986d6.1
 for <u-boot@lists.denx.de>; Wed, 01 Nov 2023 09:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698856116; x=1699460916; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cvi0oyvRl0oW1H9s4k2iGavI35AAa7iKmuVHFnXmCpY=;
 b=JZJ4hwTmgy+viYUY6p5PSFmBWiu95Q64LJLtFcrO0QsHXjzRKz/AsXVN7YcRwvHaFm
 1vkpAh9O75U1sIrO8N1UCtTmAGds/nMNO0pyCKj/urc+3+To+xEbkJD3cy2EnIdNHZ0P
 UrTTeV6TIo8i+kMxE5B8C39qhjhGCgsiEfOEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698856116; x=1699460916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cvi0oyvRl0oW1H9s4k2iGavI35AAa7iKmuVHFnXmCpY=;
 b=XIis8fM+3VEUobQ4pJBM65kyj0ocFPL63JcTue5vprS3d9CFQJu1LB2qbKAYJTIx4i
 METFU6Oc9qHIqbrHrJ2xXaUK8waIz27FuqTFQfmBGvjXO5W/bUnWmKQWML3QpZRAcl9n
 k/6bnAkN6WE/NL1UTmn6iPsXRkRE9bQNYsfK8Y1RQQUwji5b9VDkABhOo4znLRf0dINh
 5RM3iDJkQGYhMlbCacY1R+Ph01CRmrPdhpCa+gPy8icxrgyma1EqB2AM9rreSWrGOdAL
 sX7Q0vQjgo0NO8V0W1iH8x+BDCtZgrLzQ2h8gfrunTqeL5QaWWsZnM4mFEQjMc12PG0B
 tC8g==
X-Gm-Message-State: AOJu0YzzeIE4nq8xP9bunqkY5VsTNUQp5aW7i/mWRqmCyD6KwNq+y8/k
 cuYbcY2LDLZ6v4nwM/14rSXB2/IJlrAhPugiSUpaGA==
X-Google-Smtp-Source: AGHT+IFh6RkRuEFQd4ZKXoLHRuXrnzgia+Z7HM57O8iLoVN5EpKD8zeeIYvg+cmWRknHKd1fm3qkMw==
X-Received: by 2002:a05:6214:dc7:b0:66d:14ca:4bcb with SMTP id
 7-20020a0562140dc700b0066d14ca4bcbmr25447390qvt.62.1698856116204; 
 Wed, 01 Nov 2023 09:28:36 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 o3-20020a0cecc3000000b0065b21f1b687sm1610238qvq.80.2023.11.01.09.28.35
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 09:28:35 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 12/20] ls1088a: Add missing headers to eth_ls1088aqds.c
Date: Wed,  1 Nov 2023 12:28:16 -0400
Message-Id: <20231101162824.3755579-12-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101162824.3755579-1-trini@konsulko.com>
References: <20231101162824.3755579-1-trini@konsulko.com>
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

As we call sprintf in this file we need to include vsprintf.h in order
to get the function prototype and we need linux/string.h for strcmp.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 board/freescale/ls1088a/eth_ls1088aqds.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/board/freescale/ls1088a/eth_ls1088aqds.c b/board/freescale/ls1088a/eth_ls1088aqds.c
index f62f5fd27450..2fece3a1b09b 100644
--- a/board/freescale/ls1088a/eth_ls1088aqds.c
+++ b/board/freescale/ls1088a/eth_ls1088aqds.c
@@ -3,6 +3,8 @@
  * Copyright 2017 NXP
  */
 
+#include <vsprintf.h>
+#include <linux/string.h>
 #include <asm/io.h>
 #include <asm/arch/fsl_serdes.h>
 #include <fsl-mc/fsl_mc.h>
-- 
2.34.1

