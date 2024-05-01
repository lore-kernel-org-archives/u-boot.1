Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 780A6C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:56:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C82D288B88;
	Wed,  1 May 2024 04:44:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="l57A3rjN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C95E188BB1; Wed,  1 May 2024 04:44:42 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7003888B9D
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:44:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-69b782287f9so30783926d6.0
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531479; x=1715136279; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1mDl+IiJ8cDyzpCfY2Ffq3Lo/jkq108ehtdOrJn+1EI=;
 b=l57A3rjNB36j9s8P7KSGoSyDJXLE5ISlIXr12U9Lq69RB6gCXyxVXEd5S6Ab5+rTng
 nNyP5Fs2RFkIj3UNTAVC/B1+Fijq3ZeSO84Ufsjs7xrAeHt7h1OO8k7sjbDITYRUF6gG
 H4ju7JcQ8Dj67RYkWlWE22EPs1eH/OkmFoQ7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531479; x=1715136279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1mDl+IiJ8cDyzpCfY2Ffq3Lo/jkq108ehtdOrJn+1EI=;
 b=FVE0MBXCsUO/u2dNZDQbWpfxRAuSpTUS+l5vG0YHIG87A2sR2/zcsJm+ALNnGQj+0i
 q3OyAq+a//YzPxL/Q4c4BGa2EWJh4O6vUm4WFTZGfKX/OyAb3hjptj6vKPwYYropZQxn
 Qp/uH8OPuu9bL2NeJU0dopYFO5mcM/SxdOG/QnmxJ7QOgv6GlQuZJCla1IWWpBAVW9bh
 Cp37z7TzKeAu4fnO2SAAK5FNnoT3aoNtYmLXyofv170kz5dASkT0TDv3QJJf9qPJ7TF6
 BvS6JfaotxWIBR8EciEXgqOr7QvBeI65hOF+C8QbrY0v9YMDsSP6MLA8m+2RcNlXhtE7
 k7RQ==
X-Gm-Message-State: AOJu0Yz8NE4my/aruIr74DOGjnHyewsjTjm344jCOd+5Qb18NIx3zQxi
 3PtWFsbvhFCSU110ZKXuhfHTMlGswcTOh55JPcFzkgzhMcItLUN43C5PyHEIFjkvknLR24q+vZl
 /lNrPdA==
X-Google-Smtp-Source: AGHT+IG2UUDZubg+xfn0Piluk6sjxihv7++fk5B/Lp/eMHUYV0h5SsPQ7x9gzwItgyJPMMCRwLKRLg==
X-Received: by 2002:ad4:4ea2:0:b0:69b:7acd:2b94 with SMTP id
 ed2-20020ad44ea2000000b0069b7acd2b94mr1484826qvb.0.1714531479244; 
 Tue, 30 Apr 2024 19:44:39 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.44.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:44:38 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marcin Niestroj <m.niestroj@grinn-global.com>
Subject: [PATCH 068/149] board: grinn: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:41:55 -0600
Message-Id: <20240501024316.1767971-68-trini@konsulko.com>
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
Cc: Marcin Niestroj <m.niestroj@grinn-global.com>
---
 board/grinn/chiliboard/board.c | 2 +-
 board/grinn/liteboard/board.c  | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/board/grinn/chiliboard/board.c b/board/grinn/chiliboard/board.c
index 64b32ca96df3..8313b37655fb 100644
--- a/board/grinn/chiliboard/board.c
+++ b/board/grinn/chiliboard/board.c
@@ -4,7 +4,7 @@
  * Copyright (C) 2017, Grinn - http://grinn-global.com/
  */
 
-#include <common.h>
+#include <config.h>
 #include <init.h>
 #include <net.h>
 #include <asm/arch/chilisom.h>
diff --git a/board/grinn/liteboard/board.c b/board/grinn/liteboard/board.c
index cf1d7cee9252..07bb5b7d7974 100644
--- a/board/grinn/liteboard/board.c
+++ b/board/grinn/liteboard/board.c
@@ -4,7 +4,6 @@
  * Copyright (C) 2016 Grinn
  */
 
-#include <common.h>
 #include <command.h>
 #include <init.h>
 #include <asm/arch/clock.h>
-- 
2.34.1

