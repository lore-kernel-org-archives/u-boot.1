Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6620FC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 03:10:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B612888C8B;
	Wed,  1 May 2024 04:46:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CFh8xm05";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B593A88CF1; Wed,  1 May 2024 04:46:02 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5D4288CD9
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:46:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6a0ce3e823fso13802946d6.1
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531559; x=1715136359; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oFcQXveb0a5NATbeiqlKTe5T+MMbI8bnDGusbAo0UQ4=;
 b=CFh8xm05a6VSAUryvvmo9hCak7Y0tFPn+I+5dfvooyGmi24ZwLKcl4tgRdr2WGV3Hp
 flXfYXyauNjkperHkYMKbsGFarmxMkRSvNgZLYuJ5CisSx6yBCtPdFBFFqs8C1dY9clA
 lziiUfMcxJmharAxRGqZomjhLWggRl1Sed9Zw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531559; x=1715136359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oFcQXveb0a5NATbeiqlKTe5T+MMbI8bnDGusbAo0UQ4=;
 b=XyWVs4MkIXhNwDFYprabCFMPs/4HutSB0SDCqY3sMep6BAlNTIkF1GEIJGXVIq2clN
 3KmsEke6aIQhGluhkFDwyL/hey2nY0EmJlMoRwboi0KnMRQznTENF9Hbyfe6LoQE0DD7
 q+lPEHb2p7pCpa/+li/RXDbXfOd9X17vmWVLks3TQ9uVt45awQ+a+/ImTfYIYBzm1kSi
 c0OWtkgiPLTLLOqlX83UKIY3LrOjENT21U/QDfv9d9A3pjFbM3bO4A7Mp+K3Ki8tuYDG
 Tbf3thpQI/J0YskjZkOl27VLQIEASqzSib9why08tgzOoWFRqdeDChp80M4lGPjoy17k
 w46A==
X-Gm-Message-State: AOJu0YwOkpwj2qR4ltU8D2sYfb9cdqzEv4DkcGLm13r4oPhSJdgMBSi8
 Hj6ueNy3rA9f+PvShWu0PfDQCY0azBd1sdpueH4QeriMrFzc6cC3O2xkN9+N2jqSlzuCeOI3opW
 OJWB6lcIM
X-Google-Smtp-Source: AGHT+IHEzFtlRXpK5Qk/XAPH2o7SPV8OhQPv+wHDLMQPvimwia77WenRXkFBg9xnsCd/cMOfvC2u8Q==
X-Received: by 2002:a05:6214:2aac:b0:6a0:7f0f:5856 with SMTP id
 js12-20020a0562142aac00b006a07f0f5856mr1281642qvb.0.1714531559369; 
 Tue, 30 Apr 2024 19:45:59 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.45.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:45:59 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Parthiban Nallathambi <parthitce@gmail.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: [PATCH 142/149] board: variscite: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:43:09 -0600
Message-Id: <20240501024316.1767971-142-trini@konsulko.com>
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
Cc: Parthiban Nallathambi <parthitce@gmail.com>
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 board/variscite/dart_6ul/spl.c                  | 2 +-
 board/variscite/imx8mn_var_som/imx8mn_var_som.c | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/board/variscite/dart_6ul/spl.c b/board/variscite/dart_6ul/spl.c
index 1dff69c82771..6d17563d32c0 100644
--- a/board/variscite/dart_6ul/spl.c
+++ b/board/variscite/dart_6ul/spl.c
@@ -4,7 +4,7 @@
  * Copyright (C) 2019 Parthiban Nallathambi <parthitce@gmail.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <init.h>
 #include <spl.h>
 #include <asm/arch/clock.h>
diff --git a/board/variscite/imx8mn_var_som/imx8mn_var_som.c b/board/variscite/imx8mn_var_som/imx8mn_var_som.c
index 994fd4f70582..532d8d60a762 100644
--- a/board/variscite/imx8mn_var_som/imx8mn_var_som.c
+++ b/board/variscite/imx8mn_var_som/imx8mn_var_som.c
@@ -5,7 +5,6 @@
  * Copyright 2023 DimOnOff Inc.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <env.h>
 #include <fdtdec.h>
-- 
2.34.1

