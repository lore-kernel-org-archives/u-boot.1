Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2430EC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:46:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0705A88ABF;
	Wed,  1 May 2024 04:43:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aKk6+ciC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 149AC88AC8; Wed,  1 May 2024 04:43:43 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02F7088AAD
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:43:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-69b4e94ecd2so32100216d6.3
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531420; x=1715136220; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mK/vupfvHB0K9GGqLgBmtbyaQH0qX2wK7YRoW4G198A=;
 b=aKk6+ciCRu1T+5B8AjcfB7wtkG3OJwfhOyisFPCtgKVk/N+TFJ0l/AgaJG59Rh7AQD
 EIMos5Y2/geidJzpWqA5bgc+9AmB4lbd0OFLQuPP+ccq3gYXS2aN6xn1UGNZES8Q77gp
 3/6Wr/XowFrXDfKvWf2VDDz2KP0fj+8GgAGbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531420; x=1715136220;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mK/vupfvHB0K9GGqLgBmtbyaQH0qX2wK7YRoW4G198A=;
 b=rk+63w5JKAFesHTS+VXmgavJuHLq5RCEdPzWY2p8dpoGBsc9kQiIYswYxDPwkekMkq
 oSQTjDExr7HOpfEFyUuKYDHwIGf9SpHyf/f0S3HucQfcCSMSxDPRu5X47HtYqctUY4i0
 DtkI8eid6MZLstb+pzwLtPkEuMW5DNNzGo9RFOB+7Nz6xMd9uk+IsrEHYsHcM6IEPtnM
 z5AlVyF4WSRRTwF5tjh8dqNK0a4eMae5B0NTgbX7nboINWDyo7iQ7zT7GSWgKjhvVPUn
 McS3cUCfIRLna/3zuJcVWu3kvJWAd4qSjxOC6fpD77PwI5GPSJvVYKV3juSNrf5SUg2G
 /B3Q==
X-Gm-Message-State: AOJu0YxYqHD9Iq9J9EC6aIiy9auaa1ZnpGUa7Q+BxbwYoJ18nFZLcBFS
 63tBLLIVXfNSrn4rrob8ecxAqiKjk7xyxs2gTUixarhM0OO5EhKIAG3D3IUr3UJkyMR4Hx+kGuZ
 w+rCL8w==
X-Google-Smtp-Source: AGHT+IGx24VeQ6LdZay7Vq5501NFi94HYmBvev3hRtq5YwK4boBmbySmVP38ultRLRgHRzqROjMdAw==
X-Received: by 2002:a05:6214:2527:b0:6a0:49c5:c2b5 with SMTP id
 gg7-20020a056214252700b006a049c5c2b5mr1510801qvb.28.1714531417565; 
 Tue, 30 Apr 2024 19:43:37 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.43.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:43:37 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?S=C3=A9bastien=20Szymanski?= <sebastien.szymanski@armadeus.com>
Subject: [PATCH 018/149] board: armadeus: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:41:05 -0600
Message-Id: <20240501024316.1767971-18-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501024316.1767971-1-trini@konsulko.com>
References: <20240501024316.1767971-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: "Sébastien Szymanski" <sebastien.szymanski@armadeus.com>
---
 board/armadeus/opos6uldev/board.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/armadeus/opos6uldev/board.c b/board/armadeus/opos6uldev/board.c
index 365fdca1b76f..5b25545cdb88 100644
--- a/board/armadeus/opos6uldev/board.c
+++ b/board/armadeus/opos6uldev/board.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2018 Armadeus Systems
  */
 
-#include <common.h>
 #include <init.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/gpio.h>
-- 
2.34.1

