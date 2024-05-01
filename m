Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D589BC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:52:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B15FA88B53;
	Wed,  1 May 2024 04:44:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TGk8D7dK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 902B088B49; Wed,  1 May 2024 04:44:17 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 858F588AFE
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:44:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-69b6c2e9ed9so30229786d6.1
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531454; x=1715136254; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FCQzr7+YJVEA6nkSXZ9OSA+KXFOB8yRk914FM9JZpAk=;
 b=TGk8D7dK4oJKcqTCNmD8+gdPx0yP0sl3zWv8IuJ5BS4czoav8DV968fBXce4dgxNb3
 rRyRRS5we38T48DeGR6WONYvwuVul5O1f4mVq1YAwqMb20FurztqRMJk68yj62G79RA/
 Flzckv8uUXH1zaHOYwPghurqzuNziaVn1kaaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531454; x=1715136254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FCQzr7+YJVEA6nkSXZ9OSA+KXFOB8yRk914FM9JZpAk=;
 b=b/Y+M15vxGufiPwpP2UL50lWmjzkGescCxb+zOoJlii7p8L08gBmIuN4fBDgVXT42t
 M9sQdX+FEfzOfBLQmCp9LV4YflufxiL8UvXxD0JqmKCwkB61DHgBPNogrHFjefo9XCUY
 +sSOO4/dFoWZ0Dtr1e0S43aSqoSvtyIrtvSV1sjMofhfJRhpAKicXpYD1Cr7giVeeQRt
 5BKlC5Yf+XVeZaG551yFf3mIN9wyQAXol3pENGLKoiPgClC2ce5lsNf2wEUHxQNtYvMp
 nJMNDlIMfjgbgKbeQHoyQPGYAeb/kne76oSzt2hUYEUus71236OHO8XFVLcdVpEOpAmh
 DGgg==
X-Gm-Message-State: AOJu0Yzz4+IZA2YSZt2tiLEYlpw3VccP70jz1IGnXOvEc30Z5sVrZ6U5
 RlZ2RdD1gQs1Ks/B4KE/6nqpNXBE6nCH3UZqf6KV2EU566GVhiXkpD21FUXS7hpCYAcahLpuqMY
 RX49kQg==
X-Google-Smtp-Source: AGHT+IHs1KP6yhoJnwTn9ROXJgJvBH5wx8ipIjvlxfMwrDuFnw58ZopXd38betvkhHxYeiz6NSXtcw==
X-Received: by 2002:a05:6214:242e:b0:69b:17b2:df34 with SMTP id
 gy14-20020a056214242e00b0069b17b2df34mr1564020qvb.63.1714531454271; 
 Tue, 30 Apr 2024 19:44:14 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.44.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:44:13 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Adam Ford <aford173@gmail.com>
Subject: [PATCH 048/149] board: davinci: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:41:35 -0600
Message-Id: <20240501024316.1767971-48-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501024316.1767971-1-trini@konsulko.com>
References: <20240501024316.1767971-1-trini@konsulko.com>
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

Remove <common.h> from this board vendor directory and when needed
add missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Adam Ford <aford173@gmail.com>
---
 board/davinci/da8xxevm/da850evm.c      | 2 +-
 board/davinci/da8xxevm/omapl138_lcdk.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/board/davinci/da8xxevm/da850evm.c b/board/davinci/da8xxevm/da850evm.c
index 05053a87a5a9..0011c8285237 100644
--- a/board/davinci/da8xxevm/da850evm.c
+++ b/board/davinci/da8xxevm/da850evm.c
@@ -8,7 +8,7 @@
  * Copyright (C) 2007 Sergey Kubushyn <ksi@koi8.net>
  */
 
-#include <common.h>
+#include <config.h>
 #include <dm.h>
 #include <env.h>
 #include <i2c.h>
diff --git a/board/davinci/da8xxevm/omapl138_lcdk.c b/board/davinci/da8xxevm/omapl138_lcdk.c
index 9738e2bd9c77..607e05ad9ae4 100644
--- a/board/davinci/da8xxevm/omapl138_lcdk.c
+++ b/board/davinci/da8xxevm/omapl138_lcdk.c
@@ -8,7 +8,7 @@
  * Copyright (C) 2007 Sergey Kubushyn <ksi@koi8.net>
  */
 
-#include <common.h>
+#include <config.h>
 #include <env.h>
 #include <i2c.h>
 #include <init.h>
-- 
2.34.1

