Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05EBBC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 03:02:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75B3888C17;
	Wed,  1 May 2024 04:45:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Z9mqRytH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C618D88C10; Wed,  1 May 2024 04:45:12 +0200 (CEST)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDDCA88BE9
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:45:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-790eedf44faso259258485a.3
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531509; x=1715136309; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vrud9lTLsjDSljaHAJ/8QVOOn1Mf+D3CM1OGQEZMt8Y=;
 b=Z9mqRytHRkqQFh5fXygOOtTxmK1prfgUwd9Ux58Mw9XBaV36z7eeFOQQwvAb1aeKNa
 B6mLYR6aWQP0Zh0l8Jou0jRUYrKK8dAciK0A4LCKIciF8plClCEh93s8kaEbD4ilvGyw
 FQhIZ7lF1VRS26OaM9JddIdD6WS31nYhfy3ww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531509; x=1715136309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vrud9lTLsjDSljaHAJ/8QVOOn1Mf+D3CM1OGQEZMt8Y=;
 b=Dn5jINC2MdTj8OvO5ChR1Qu4tBTs9AOoPdJ4yty1+kFqeluJKkHHbKNo16OplVEXyO
 yBZxu2Na7WXu6MhopFnXa5WZn0F9bV5ZD/oVJcv6SphAag6QuxWVY2jKFfFV/BCKoOYQ
 kK0HtolYPattXw3IlTRnc/c2hB8OPfrQNS6BJpRe6FZxl9UDD3ptSYdXF4GzegYgDUTc
 FHhPb6uIMePAl9mgkjvB/Z25ULXhG/Xuoyf2+/8upFQCk4kd1KrmRYQUCG2vSxCWEg9s
 emRbZrjy9NCbxTTyhvGYrnHcrkrO0RQW+RQx6P/Aqfk55vLltT+fNb0IpJxEacyO7seW
 AjYg==
X-Gm-Message-State: AOJu0YyzipGw4yc+0Qkg4nBigqlHT/mxRtww0gadHzfu4vu+WszvnSG+
 OUQizRrAdysicyaDZBO0uPdmuC6P25K78eAx51xXU7XWmSh6yDSjXz7HeFEfnEBT1Erj78FfsPb
 e6v440Fn0
X-Google-Smtp-Source: AGHT+IF2A8eht+ABJafnjMTiVRdpocP1evZ+0n7/hyyQ+td53YjuquUBb2PqP/3SWyxVhPxqX4H/yQ==
X-Received: by 2002:a05:6214:27cb:b0:6a0:cd45:2584 with SMTP id
 ge11-20020a05621427cb00b006a0cd452584mr1376038qvb.20.1714531509389; 
 Tue, 30 Apr 2024 19:45:09 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.45.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:45:08 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Subject: [PATCH 096/149] board: netgear: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:42:23 -0600
Message-Id: <20240501024316.1767971-96-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501024316.1767971-1-trini@konsulko.com>
References: <20240501024316.1767971-1-trini@konsulko.com>
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

Remove <common.h> from this board vendor directory and when needed
add missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: "Álvaro Fernández Rojas" <noltari@gmail.com>
---
 board/netgear/dgnd3700v2/dgnd3700v2.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/netgear/dgnd3700v2/dgnd3700v2.c b/board/netgear/dgnd3700v2/dgnd3700v2.c
index cfc3529c3488..9cf3a2fe60a2 100644
--- a/board/netgear/dgnd3700v2/dgnd3700v2.c
+++ b/board/netgear/dgnd3700v2/dgnd3700v2.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2018 Álvaro Fernández Rojas <noltari@gmail.com>
  */
 
-#include <common.h>
 #include <init.h>
 #include <asm/io.h>
 #include <linux/bitops.h>
-- 
2.34.1

