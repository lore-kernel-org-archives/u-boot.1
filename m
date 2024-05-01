Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A7DC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:59:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DB3B88BD5;
	Wed,  1 May 2024 04:45:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ptBh8jRv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6546488BE0; Wed,  1 May 2024 04:44:59 +0200 (CEST)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26BD088BB8
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:44:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-78ecd752a7cso452808085a.0
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531496; x=1715136296; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I7kj5tbMvlnf0me+DqpwkDFRnw0Rpi4QYVr3oktRHlk=;
 b=ptBh8jRvLsR9YMej+UvLqfTY1wPxKddRXjupH87+kuZ3wAPnTLSTcMuSGnwLS6QQMB
 i57/NT9bJVajrEmPD/IuFWj98gqc68/T06SV4WIjNQHukH0k5PjKMRFuuGU2KUitaU0c
 e7SOv2t5rfve8DU3XKO/FLv8LDisS8gLKsslQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531496; x=1715136296;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I7kj5tbMvlnf0me+DqpwkDFRnw0Rpi4QYVr3oktRHlk=;
 b=ikzTXNtDopbrbbjXCkSMutPvpvOa/9C2KWN9MfEWzK3YUufjAbNHRKz9MJUgOTCZNT
 CaI6wT2KOLFUmEObsHjxu4jQDHQvA/geLWz02ftUI5iEUPABISKSUHpoXEJD3oy6XoiR
 Lut0MAedFXxxZo52/Zd5sdAvXkag1zkLm+f0zIk7wxj0Sph8ctCOa2m09059acVTl9m1
 +DbFRcocKZSS2l3uzxKz4xMW7Tx/uPnyFs+t/BNygeJHJOHpAkRAUeLSskGJ1ZdEZ8rB
 wLxecQgr84bOY38QvLITodcvxcGGmGvbsYf/KuvjC19mnRI9Am0F0t4HcgaXllu+y2FL
 9HBg==
X-Gm-Message-State: AOJu0YxrDhTfkYYwlTvmfViK3Lpj4/vd5zQonlb+MnfOox0y2RnTbFl6
 3ozw3rCtWvDJexY6EQvt89g9avALrSyGahJH4CL8Os/Yeitccs/e2DabY9ufq/iBvIJ79WucWmL
 MWOEpBQ==
X-Google-Smtp-Source: AGHT+IHu7VWyn/mIpVFjSfmomNWyJ8vZr9V0sQCGOoAg6l1cVs7krul2F5gb2P6HT5CEkrsHvthrPA==
X-Received: by 2002:a05:6214:dc9:b0:6a0:d290:693b with SMTP id
 9-20020a0562140dc900b006a0d290693bmr1408123qvt.50.1714531495802; 
 Tue, 30 Apr 2024 19:44:55 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.44.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:44:55 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: David Lechner <david@lechnology.com>
Subject: [PATCH 083/149] board: lego: Remove <common.h> and add needed includes
Date: Tue, 30 Apr 2024 20:42:10 -0600
Message-Id: <20240501024316.1767971-83-trini@konsulko.com>
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
Cc: David Lechner <david@lechnology.com>
---
 board/lego/ev3/legoev3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/lego/ev3/legoev3.c b/board/lego/ev3/legoev3.c
index 43afe593c78b..1a153668a43c 100644
--- a/board/lego/ev3/legoev3.c
+++ b/board/lego/ev3/legoev3.c
@@ -12,7 +12,7 @@
  * Copyright (C) 2007 Sergey Kubushyn <ksi@koi8.net>
  */
 
-#include <common.h>
+#include <config.h>
 #include <env.h>
 #include <i2c.h>
 #include <init.h>
-- 
2.34.1

