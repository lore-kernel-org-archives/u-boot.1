Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B4F0C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:51:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F79A88B35;
	Wed,  1 May 2024 04:44:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="priw6+jx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FAD388AFA; Wed,  1 May 2024 04:44:13 +0200 (CEST)
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com
 [IPv6:2607:f8b0:4864:20::a2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EDBB88AFE
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:44:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vk1-xa2b.google.com with SMTP id
 71dfb90a1353d-4dcc7c1055bso2004184e0c.0
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531450; x=1715136250; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LZY9h+buyzg27o5VxqTezVPRITBX+1E3WNBK1ZxpgPw=;
 b=priw6+jxRdeFlSqkTOSfvC+BwF2wOO3PqzgFmKbrcIL0GhkpYIIz2MzrekwBMCOyQG
 VgieUBNeu2iYn78IHxY2DdxXXSZDO/ztAVP7sse8Re4W89Fqp9sLRYtIAkwVPEfRGojC
 UpKcap+6yxc7YrUpARRXG6YeYkEw753ad2Hpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531450; x=1715136250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LZY9h+buyzg27o5VxqTezVPRITBX+1E3WNBK1ZxpgPw=;
 b=MK7fCAzzm5I1Aoj+Wg1t1R+SVrSWeUsZXet4vwjWExIXY0ndfiS5hBHuMp2X8XaWbk
 Sb97daKmj010LB2+4HKz3LWygQj3pbZ+vOdQGvSEK/TsAffWNBc2nokMPsGK4a15usgk
 RaQiITUfsRmg9ZupcwTHYHIt7qC2Yn0WHvLkAK9v9l7xtfTzRm4Z1dljAEVlGrMBJMnR
 GC59ERdQ9pWSpX37Tyf/NJPCEpnpuXXx1XCR5xolaAgmqDC1wg2wcQOUPBKt2I1ow9/E
 ifuVoVvdBd0O9ikypq7mKOnWkwa62DAg2x3Qxjjcxxyzz332zt2o5ROCu08T8zFBI6aP
 p+jA==
X-Gm-Message-State: AOJu0Yz5Q0IOdXwOfROerKRa9edVl5BxLsQOw0oK0hXM1yDbt/D9naiX
 Dss5ebHGHcpuzC4tC8RKva1F9dpkNqnjrCMjEZIUh/vyEwlyXfuj5riBMCKcUHgJ+5lerzjNPr4
 QDbGyXA==
X-Google-Smtp-Source: AGHT+IF3gIHiHpZa1wP/WTJcRAM/DO0TA6y8wL4A1dOQXZBtlbFQXVt3bS/MuJvHaiW3naTtdijLXA==
X-Received: by 2002:a05:6122:2503:b0:4cb:56c5:5816 with SMTP id
 cl3-20020a056122250300b004cb56c55816mr1727865vkb.12.1714531449948; 
 Tue, 30 Apr 2024 19:44:09 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.44.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:44:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Mike Frysinger <vapier@chromium.org>
Subject: [PATCH 044/149] board: coreboot: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:41:31 -0600
Message-Id: <20240501024316.1767971-44-trini@konsulko.com>
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
Cc: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>
Cc: Mike Frysinger <vapier@chromium.org>
---
 board/coreboot/coreboot/coreboot.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/coreboot/coreboot/coreboot.c b/board/coreboot/coreboot/coreboot.c
index e58dce37477f..f2ca10767681 100644
--- a/board/coreboot/coreboot/coreboot.c
+++ b/board/coreboot/coreboot/coreboot.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2018, Bin Meng <bmeng.cn@gmail.com>
  */
 
-#include <common.h>
 #include <splash.h>
 #include <init.h>
 #include <smbios.h>
-- 
2.34.1

