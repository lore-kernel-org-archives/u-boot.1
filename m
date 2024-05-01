Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB47C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 03:04:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1AD788C63;
	Wed,  1 May 2024 04:45:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="C7p/EWeC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 620B188BE5; Wed,  1 May 2024 04:45:24 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5005688C47
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:45:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-69b10ead8f5so33944996d6.0
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531521; x=1715136321; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fUCAbip/nMsx43dN+Btpi+EUj3RHxt1pnvRMjPj2OzU=;
 b=C7p/EWeC9mkOLkaYRbt1vupTYzMMMU/LXOjwTIObsBfGIAwYjpKkABoLbynErfk2qS
 lpFRE2EmbqeGP8pOaBVpzb1Ky2B1ZyyS0jjEG8tYzDcGaIW7+HgM71qFMCBHd/b1lvHP
 BsolKKUPphIdHEqzvzfIWrKxUNyP2Va6iq9+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531521; x=1715136321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fUCAbip/nMsx43dN+Btpi+EUj3RHxt1pnvRMjPj2OzU=;
 b=IZRoMVtMWBb1AXnKTUmyZxO6Ejne0BNiv6rRqpABlDjZY5H3EMEzvPYfvXAZ6P8l+d
 LUHoX43UfD2xJ/b03zUqgc8779QyqNOHrd1R89m5gLbI4CmNWVzbJSIEYV1xYoutxRYL
 Mb3UcGe0vAyEY+aXy4DdADgU+C0VC4r2kFvhg44VaSvJxOsCzX4fZB62Wo0PIwu7iaKA
 3ZHwLe1Xw4aANxmS+Y8Hdi9rf0B8MUE4v5z/KfFmxuTlHNvhLn+rztWjZHb9cOpzboch
 VYycZ79uDgOWr7J0F60S7ha6K6p0MvcZjJSeukpHmB4cjTjAt5p/pTtT3q0nMCG3E2va
 86Pg==
X-Gm-Message-State: AOJu0YxEJTNoX8LcXwrTy+IQ5oWytevG9KU8p2n0b4EQl+b+Y4f9eEeE
 gj6BiFMBGL28unuXgIi/Om1uWBXKbmfHJpZT5NkbOxNlSGovZmIQaRvydWRdhXMn4S1g23C+/qr
 lTU6EFZb0
X-Google-Smtp-Source: AGHT+IGI+RmhAaVTEADBkNonJ1NwfsTxaVab3petffM+ao22QimFmh3fcP8LRzSCyBTuaejojUpvBw==
X-Received: by 2002:ad4:574d:0:b0:69b:1260:84c6 with SMTP id
 q13-20020ad4574d000000b0069b126084c6mr1158997qvx.29.1714531521057; 
 Tue, 30 Apr 2024 19:45:21 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.45.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:45:20 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Wills Wang <wills.wang@live.com>,
	Rosy Song <rosysong@rosinson.com>
Subject: [PATCH 107/149] board: qca: Remove <common.h> and add needed includes
Date: Tue, 30 Apr 2024 20:42:34 -0600
Message-Id: <20240501024316.1767971-107-trini@konsulko.com>
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
Cc: Wills Wang <wills.wang@live.com>
Cc: Rosy Song <rosysong@rosinson.com>
---
 board/qca/ap121/ap121.c | 1 -
 board/qca/ap143/ap143.c | 1 -
 board/qca/ap152/ap152.c | 1 -
 3 files changed, 3 deletions(-)

diff --git a/board/qca/ap121/ap121.c b/board/qca/ap121/ap121.c
index 60a2e19143db..6bb12602193a 100644
--- a/board/qca/ap121/ap121.c
+++ b/board/qca/ap121/ap121.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2015-2016 Wills Wang <wills.wang@live.com>
  */
 
-#include <common.h>
 #include <init.h>
 #include <asm/io.h>
 #include <asm/addrspace.h>
diff --git a/board/qca/ap143/ap143.c b/board/qca/ap143/ap143.c
index ac65054136ca..b88de9c4ec85 100644
--- a/board/qca/ap143/ap143.c
+++ b/board/qca/ap143/ap143.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2015-2016 Wills Wang <wills.wang@live.com>
  */
 
-#include <common.h>
 #include <init.h>
 #include <asm/io.h>
 #include <asm/addrspace.h>
diff --git a/board/qca/ap152/ap152.c b/board/qca/ap152/ap152.c
index 82458c3af421..53587288c939 100644
--- a/board/qca/ap152/ap152.c
+++ b/board/qca/ap152/ap152.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2018 Rosy Song <rosysong@rosinson.com>
  */
 
-#include <common.h>
 #include <init.h>
 #include <asm/io.h>
 #include <asm/addrspace.h>
-- 
2.34.1

