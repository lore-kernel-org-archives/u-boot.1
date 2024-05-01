Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80932C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:52:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1804688B57;
	Wed,  1 May 2024 04:44:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JqPCCyzv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C784E88AB6; Wed,  1 May 2024 04:44:18 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE2BE88B3F
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:44:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6a05f376effso49630326d6.0
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531455; x=1715136255; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cgXyIgrMWFrTdkMI6zxbaZ1FD5ESeL2N6+t6F8HKRCQ=;
 b=JqPCCyzvD1cf6AaaaKoATaxAUwOzJh1bO4JaP30jpVYgZGdCj33tWqzRE5SG/kbzqK
 1aj90jwD1k8cyF1Y9F0wxVQQW8FuIRdM4MIoXKVWEmd3MMTuJttikfUZlHxVQF8kry5E
 RaCZgP9/qZIZvp9o4bCsifIjTW8N5ZW9aealk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531455; x=1715136255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cgXyIgrMWFrTdkMI6zxbaZ1FD5ESeL2N6+t6F8HKRCQ=;
 b=Q54vfXD+FawuKlP5LIx76n95RtMf6nzvKo4G4VPYrlH43hLDeSwfCsJyRQwnfrlv36
 TLCCYCwCbCbnIyRWDGXiw2TrNPWw1fUAW2mCKBjYB1E98BRqJaWwGeXW1Svv21Ptls/8
 bCT2B6xkkW2J0c+Y7/VD+E+FUWFPM/QzNhqyHwgSV+FmguvFFQM9BZG0K7QAcALFDkNj
 HzqI14K7VViND56raR5OULX9HX3PYRmywc96mVmbQC7Af8WukMBt0kFtYH9pAt/pM0YJ
 C/atVv07Odc1T/eH4I+AVhNZRz4NgTy2CJWICkFwlx/ujIri4vje0iVbDOZBm7uxYj8N
 9+Ug==
X-Gm-Message-State: AOJu0YzGMXUOwLeAgv9weymEWrYyNTuDlOVdQca5JRtZ2T0eLCK1+30b
 qkofki3JoUnopJVyQcv+aSykbHfABVaMMr9VEYNLBRtTW+2hyUGumwb3L8zidhTHdpH4YYivBdf
 vk8zdbQ==
X-Google-Smtp-Source: AGHT+IGGnRnLn3QA3vECCkcRaKJodSqV3Pjb+wWHRpOj4W3LAkHP7qnfqHsS1zh+2AoEbKVnWoM+kA==
X-Received: by 2002:a05:6214:300e:b0:6a0:b461:ba6 with SMTP id
 ke14-20020a056214300e00b006a0b4610ba6mr1271082qvb.8.1714531455502; 
 Tue, 30 Apr 2024 19:44:15 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.44.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:44:14 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>
Subject: [PATCH 049/149] board: dfi: Remove <common.h> and add needed includes
Date: Tue, 30 Apr 2024 20:41:36 -0600
Message-Id: <20240501024316.1767971-49-trini@konsulko.com>
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
 board/dfi/dfi-bt700/dfi-bt700.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/dfi/dfi-bt700/dfi-bt700.c b/board/dfi/dfi-bt700/dfi-bt700.c
index 87506a77a17e..907cc985d7a9 100644
--- a/board/dfi/dfi-bt700/dfi-bt700.c
+++ b/board/dfi/dfi-bt700/dfi-bt700.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2016 Stefan Roese <sr@denx.de>
  */
 
-#include <common.h>
 #include <init.h>
 #include <log.h>
 #include <nuvoton_nct6102d.h>
-- 
2.34.1

