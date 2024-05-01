Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F524C10F16
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:57:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CFB688B9E;
	Wed,  1 May 2024 04:44:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ftHbBf4E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1696A88B99; Wed,  1 May 2024 04:44:45 +0200 (CEST)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9FE988B9C
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:44:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-78ecd752a7cso452799785a.0
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531480; x=1715136280; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GAqFM3R/kvW0H10TZDVRDGJDmz9/B91muaFH+JmsvRw=;
 b=ftHbBf4EI9k+U/SvjeB49Q2/7NbfdBBX55lwKX1YIEMjvaxByxi+ed9XgZdN/Qk6my
 IZBLCUuFcIYiXvstZiavIDvhhLg1hgUOn+scg96P9iYWC9/8Zt4rTnRA0CC4F9MK+qMa
 SjNsyTxH1THl0ey3OYJdkxJpKuP7t4/4Z+2Uk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531480; x=1715136280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GAqFM3R/kvW0H10TZDVRDGJDmz9/B91muaFH+JmsvRw=;
 b=s6RBKOFe0AqTIzPK7etMC8oWYBCA18ODwV9DNWlZESjRp3tYReely39TXY1A0eyw7C
 a+cxPN+bD0vsrFKg4j3zttQM0bC+aLOo7Usx5uSvdGnj7Xrdpb4zV03cTNHt2BHali9P
 CEHr+6snW1cqs52oJCuSLhMuqCInM+YVOzoZqhmr1lzfmNxOMy4cjxKdOi6vEX9fg0CB
 Zw1ZJw2/GcVbtWA7nvT3AZUr/crtqD2nqRG4ugAYNwok8um4B5NGYMaWs2MUjKM1LE4b
 3zFxwyD+8nbNgFM0JSyJWLtuzEC0tWPL8rtNMtU5VKV/KqTkZExvUrRyt/MvnsU8uKu1
 CFQQ==
X-Gm-Message-State: AOJu0YxRqtcrI/yuN1kE8N4wJ1dokbnPGInojPjQZhjEKRgqBq0WOlkz
 +RY/EbeDZOfOFA6FSx6zbDCIQNoe4aUOZsCxMET/xNJ+3CMU2mDtNC0HluN4YlvCE7iigtm+dKP
 BBwDzPg==
X-Google-Smtp-Source: AGHT+IEXYjGtCMBPak+0xk1VjyGXyrimwvj39W15nsxPu8Qu8I1AA8Bxz6dpVOSjWwjwwhrn4jg5oQ==
X-Received: by 2002:a05:6214:2524:b0:6a0:adff:b769 with SMTP id
 gg4-20020a056214252400b006a0adffb769mr1502407qvb.55.1714531480235; 
 Tue, 30 Apr 2024 19:44:40 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.44.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:44:39 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH 069/149] board: highbank: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:41:56 -0600
Message-Id: <20240501024316.1767971-69-trini@konsulko.com>
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
Cc: Andre Przywara <andre.przywara@arm.com>
---
 board/highbank/ahci.c     | 1 -
 board/highbank/hb_sregs.c | 1 -
 board/highbank/highbank.c | 1 -
 3 files changed, 3 deletions(-)

diff --git a/board/highbank/ahci.c b/board/highbank/ahci.c
index 9c057278ace1..899c502dfbc8 100644
--- a/board/highbank/ahci.c
+++ b/board/highbank/ahci.c
@@ -3,7 +3,6 @@
  * Copyright 2012 Calxeda, Inc.
  */
 
-#include <common.h>
 #include <ahci.h>
 #include <asm/io.h>
 #include <linux/delay.h>
diff --git a/board/highbank/hb_sregs.c b/board/highbank/hb_sregs.c
index d9dd2c2bf67f..94052f7a3f9a 100644
--- a/board/highbank/hb_sregs.c
+++ b/board/highbank/hb_sregs.c
@@ -10,7 +10,6 @@
  * Copyright (C) 2019 Arm Ltd.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/lists.h>
 
diff --git a/board/highbank/highbank.c b/board/highbank/highbank.c
index 7f67d1e45308..f3df83ed6c9b 100644
--- a/board/highbank/highbank.c
+++ b/board/highbank/highbank.c
@@ -3,7 +3,6 @@
  * Copyright 2010-2011 Calxeda, Inc.
  */
 
-#include <common.h>
 #include <ahci.h>
 #include <cpu_func.h>
 #include <env.h>
-- 
2.34.1

