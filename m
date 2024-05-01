Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC95C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 03:08:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB22388CAE;
	Wed,  1 May 2024 04:45:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mD6zzA0M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E85A488C78; Wed,  1 May 2024 04:45:46 +0200 (CEST)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D843888C4B
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:45:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-437610adf96so43463011cf.3
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531543; x=1715136343; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I9cOMLDiilTcyZuO+cMVD8tI3OOaxa4pdkPhWPhxYPk=;
 b=mD6zzA0MaxfMqB9bNogL/Xeg6ukkNGpteSddCtwG0Oc5q1yZhVYZQ0hw3LTKhS8YrJ
 HbEAQMoLGHVgQoP6TzCXFfHVZJfzNa71leStR5RN1+o9pSP6Kc3MDoU7aynWPx13z17N
 /s7pEx9ZN/bAnLAGHvP8F4CAzZei7k0W0t9v0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531543; x=1715136343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I9cOMLDiilTcyZuO+cMVD8tI3OOaxa4pdkPhWPhxYPk=;
 b=oU10TxU1Fka3fbfiQeWJinNRI96/yCRgKo6tZQwqBgzhWQn8xVAML7zwrfJOWqx3D1
 vvpjxN8m/c7zex/MXu40DGX9VEwyAawhuJ4oHqMi4hYJK4K7DRMLV7xaZviec/Sopg2B
 6KeR8EYZQJDylF+Vz6rl9kA9aSDkGgYlBEDjes5a6dHOp7uJsL2fP79wS5EZFoayaNE9
 G9wyfVpPez7cFInVa8nuWoCp0SIP+Jub0hcIijysBxNZUwmcJfqf/gBFhogQW/U0kAaL
 IaVNMTKz/8395U41nBnO7VAwz7qqY6zGCNkAUS+rO6JBzGQpF+6fhV3cEvtHLLTbkUb2
 GnoQ==
X-Gm-Message-State: AOJu0Yw2qQjNiIPR+EzA94CmPOX7pidH06dr/hqx91+VGOPAZS5cEacA
 Hhdn0/k9jtLf3j8Rv+Ao2+TCLK8NAuT6yTLqJtU+vYYXN8i29L8oTDy28Vt/a6qCRjV9LQE/KK+
 +ccAfUJnJ
X-Google-Smtp-Source: AGHT+IFWdGlVQpuyiltzL+y8+sHjdz6XvO1rFHxNlMe82LFrLaKcPO3a13DsutNRbVx2e42VBN43yQ==
X-Received: by 2002:a05:6214:2123:b0:6a0:c9e5:a15c with SMTP id
 r3-20020a056214212300b006a0c9e5a15cmr1430239qvc.63.1714531543501; 
 Tue, 30 Apr 2024 19:45:43 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.45.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:45:43 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 127/149] board: ste: Remove <common.h> and add needed includes
Date: Tue, 30 Apr 2024 20:42:54 -0600
Message-Id: <20240501024316.1767971-127-trini@konsulko.com>
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
Cc: Stephan Gerhold <stephan@gerhold.net>
---
 board/ste/stemmy/stemmy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/ste/stemmy/stemmy.c b/board/ste/stemmy/stemmy.c
index 060d562cbc90..826c002907d6 100644
--- a/board/ste/stemmy/stemmy.c
+++ b/board/ste/stemmy/stemmy.c
@@ -2,12 +2,12 @@
 /*
  * Copyright (C) 2019 Stephan Gerhold <stephan@gerhold.net>
  */
-#include <common.h>
 #include <env.h>
 #include <fdt_support.h>
 #include <init.h>
 #include <log.h>
 #include <stdlib.h>
+#include <linux/errno.h>
 #include <asm/global_data.h>
 #include <asm/setup.h>
 #include <asm/system.h>
-- 
2.34.1

