Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD2B0C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:53:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EEB288B64;
	Wed,  1 May 2024 04:44:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="onK4WBOS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 516EA88B52; Wed,  1 May 2024 04:44:23 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B33888B5E
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:44:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-69b4e94ecd2so32102226d6.3
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531460; x=1715136260; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GMrfan/4ZfM8RRBkMSm7XIJjhHCUf1RPL9sZoi4Vp3U=;
 b=onK4WBOSmzUWRdJ8aQfq/ThUkmwquvFJ5suIaq4sxP9nYBHkjd6ZXJy54wIHIkyUtx
 Da2MduLEDmPxRVA1fy8TOyarf+HIFAqPNoKCLJ3it0sT8gbsOQh679haqx9Jvbbnhi/Q
 0BFbkyJi6MeoSyT3OEeuYXUKke0nsFEExaYpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531460; x=1715136260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GMrfan/4ZfM8RRBkMSm7XIJjhHCUf1RPL9sZoi4Vp3U=;
 b=V725zzaMYzaHt9fo8VXjPAsOwI9Xo3cA/CRU5M+UrA681ecUl6eGovfXolnrOPP1QY
 LFPDNXQ3J+3R8FKS0SfBOivIx7tlWxDfIv4pXa3AF48vYXtECLt5vIQpqLbPAiMFfmFD
 EnvwR3lVYawzRaCiU1FMRR/P7SZWanR10xB7254MSH9icQjjEeY1NSi793/kjtxix0zF
 K3LFrOYphRwWmoEP1GoaDpHgMkaIQGP25f3PsP70uV7Ff3P4okGSzF/GUe47jsLxtWVd
 SHOxrBsrgPYNQzBfctJr4X90SjK3tUMy1FVQ/67czgIJI8b/Vx9j50NuihpHZntweVhR
 Y0tw==
X-Gm-Message-State: AOJu0Yw3qOa/Y2AX6nZkp44Bu5PyljGo9SoiVcuJYyc6rQe5nBAK/kbf
 EqtAKuHbUV1w/zry6Gxmz76/LJTvrvN+1vdxhvYOnhmZVvvtUOVwfY7gaau4quDgRtoAU6e8n77
 2DKOPmQ==
X-Google-Smtp-Source: AGHT+IEy40nGD01hpEhKSOIKwofn12zXt50niq/Zm5eN7S+ajPY+Na8z42aMcdK2qfBzEFULxaAmBQ==
X-Received: by 2002:a05:6214:1c09:b0:6a0:7d91:1adf with SMTP id
 u9-20020a0562141c0900b006a07d911adfmr1285726qvc.35.1714531459863; 
 Tue, 30 Apr 2024 19:44:19 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.44.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:44:19 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 053/149] board: efi: Remove <common.h> and add needed includes
Date: Tue, 30 Apr 2024 20:41:40 -0600
Message-Id: <20240501024316.1767971-53-trini@konsulko.com>
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
Cc: Bin Meng <bmeng.cn@gmail.com>
---
 board/efi/efi-x86_payload/payload.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/efi/efi-x86_payload/payload.c b/board/efi/efi-x86_payload/payload.c
index 5d4492cdc77a..d7d1e53e911c 100644
--- a/board/efi/efi-x86_payload/payload.c
+++ b/board/efi/efi-x86_payload/payload.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2018, Bin Meng <bmeng.cn@gmail.com>
  */
 
-#include <common.h>
 #include <init.h>
 #include <usb.h>
 
-- 
2.34.1

