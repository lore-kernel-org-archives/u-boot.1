Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 075F0C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 03:00:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 735EF88C01;
	Wed,  1 May 2024 04:45:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fasWBmyO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B50F088BE4; Wed,  1 May 2024 04:45:02 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A821D88BE5
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:45:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6a0ce3e823fso13799586d6.1
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531499; x=1715136299; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6HerkAdk7lg0Vf2G49/p8nkcR78Rx9sFVUcwTJchcBc=;
 b=fasWBmyOv1WsGVlFO9eBAYERWZDrRSbwhqsT093WqJ3kM1HkqYEy371rNzClGytYc3
 FimQZkaobzezv8S4Ju4XkCnoynSz5riB2QcEH7ocCrDYXvED/2CvE84dSMVxAbDnjwTd
 /Jt6Sv1z2Pt6D4d8Hz2XTq0V0VFbTbtP/iBfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531499; x=1715136299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6HerkAdk7lg0Vf2G49/p8nkcR78Rx9sFVUcwTJchcBc=;
 b=iaB8mYVldKQ38g7QAjNPnVEjwwKuci6o1tWezOYXKTolM7JH17mJ+89bIVYC93NUXV
 vpdRz50wbCkXDX4OHzryltFkXG8RLV+97f0OtYPN8uAdJcpKOlf9XBXyZxGnfl3awLQG
 tPa/Fhv4AkLsebe/3JE2fEpyGwmXX2V9trWo1wWtw9E03QGFrBKr0h0Fn2QtNPpdo5R+
 wWZEAkkl5YoDBDq4IdTfqzsC9hAurJRjc0aqsUeM69I7P4ef9ee5v2MMdsexjiMpi4XR
 5rHmn99aaZpqDedmeRFuV2DFuJbew84TKmem/mcQ20QIfYAiBJBbkYjGx8Cjz7W2ojT0
 HECQ==
X-Gm-Message-State: AOJu0YylrmxwI1rFh+ni1OSJgL2R0IyXipbZjAJx+M8VUhBgyInskaKU
 eDXyFugfAdsZ45W/ZhxMcn13cm+kGTGi4MrENtmQ+TzOGo+cZvEsd3syAGcTtn6w2KTfeZvQ6Uw
 BuA7VRQ==
X-Google-Smtp-Source: AGHT+IG2T/WM5epQZ3EUVeLRAm3sOUT952s0/e4ZqD1e00kjcxwu8o9lW81b6Xv3mXdSMYzEbVrlgA==
X-Received: by 2002:ad4:5764:0:b0:6a0:e59b:6737 with SMTP id
 r4-20020ad45764000000b006a0e59b6737mr1176227qvx.26.1714531499420; 
 Tue, 30 Apr 2024 19:44:59 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.44.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:44:59 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>
Subject: [PATCH 087/149] board: maxbcm: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:42:14 -0600
Message-Id: <20240501024316.1767971-87-trini@konsulko.com>
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
Cc: Stefan Roese <sr@denx.de>
---
 board/maxbcm/maxbcm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/maxbcm/maxbcm.c b/board/maxbcm/maxbcm.c
index aad3dc864295..e011520f2ec2 100644
--- a/board/maxbcm/maxbcm.c
+++ b/board/maxbcm/maxbcm.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2014 Stefan Roese <sr@denx.de>
  */
 
-#include <common.h>
 #include <init.h>
 #include <miiphy.h>
 #include <asm/global_data.h>
-- 
2.34.1

