Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD96C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:53:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3D5C88B4C;
	Wed,  1 May 2024 04:44:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sxrd+t0+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C43A88B4B; Wed,  1 May 2024 04:44:21 +0200 (CEST)
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com
 [IPv6:2607:f8b0:4864:20::e2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3710788AB6
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:44:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vs1-xe2d.google.com with SMTP id
 ada2fe7eead31-479dbcdba2dso2163119137.3
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531458; x=1715136258; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+YHcGkUNhs2uO/Xt9o8N/LjDxTxSKOqrqAzOAXmCazU=;
 b=sxrd+t0+XUXfaRopdUzhwpHYdxQqUZ+/LHzdZ4iCXLw0afYumUae4DZDTc/047DLKT
 /bKBR38E3FS9InnjsoC6A9FABmT0kJKe7etulfezIcRlTzTZ4wi35pXHeBmHfZEJnDl9
 M3VUwnux4zAUVgW3TCxcYlF259578CMXAhQbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531458; x=1715136258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+YHcGkUNhs2uO/Xt9o8N/LjDxTxSKOqrqAzOAXmCazU=;
 b=o/dBEGSlgXlluKoRdtv3LSiUWkXYOQu1PZGaNg05JNa8iEdSRrnp26KCb71CIBxYRD
 LNlyhkYJkQTOnNFzZDjeOUNt+mCKugV+mNdMsyIFa5AtQTkbD4KSZMBNnK3EROw0R2hB
 6htw/48kKmb13XR+k4ThmlVKMdl/Z949brNyjPTdXhUAOuDcL6QaatteVUJhKmBlcZxH
 r5Ns+/NvfyVY0nqrJuErja/B3LDx+elGz2Kqi/OtW1kzKEXty+IYvZ0uJPdr/Gx6u9CQ
 n7YWGiLGOPZdpKKWdOLikd/T+e/pFzuvkw8ZIAFE024QUcr0g5dNApPfhjCtyIBD4pDH
 vW4g==
X-Gm-Message-State: AOJu0YydqhzPsLtF3MQIOy8ZGS3LtzokSY0aFCzMKgyF3Zrqy6S2l9ue
 +r59k0UhMXFx++8EZxb/1JRreL94yU2g6jXIqyHlFocUwnxxPVZqRc4XhnK87D/6tUfVAr45ETR
 TPxn7Lw==
X-Google-Smtp-Source: AGHT+IEYGiKLW0ApcQ/j7sRKszgLr7e1TH0ukAlG0VpcF8SomjFpuua98Nk/mnmt8BJaptRDeHLYiA==
X-Received: by 2002:a05:6102:3a50:b0:47b:6fb1:5299 with SMTP id
 c16-20020a0561023a5000b0047b6fb15299mr1868870vsu.14.1714531457773; 
 Tue, 30 Apr 2024 19:44:17 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.44.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:44:17 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Trevor Woerner <twoerner@gmail.com>,
	Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 051/149] board: ea: Remove <common.h> and add needed includes
Date: Tue, 30 Apr 2024 20:41:38 -0600
Message-Id: <20240501024316.1767971-51-trini@konsulko.com>
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
Cc: Trevor Woerner <twoerner@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
---
 board/ea/ea-lpc3250devkitv2/ea-lpc3250devkitv2.c | 2 +-
 board/ea/mx7ulp_com/mx7ulp_com.c                 | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/board/ea/ea-lpc3250devkitv2/ea-lpc3250devkitv2.c b/board/ea/ea-lpc3250devkitv2/ea-lpc3250devkitv2.c
index 2b03e4891d92..222e5facf434 100644
--- a/board/ea/ea-lpc3250devkitv2/ea-lpc3250devkitv2.c
+++ b/board/ea/ea-lpc3250devkitv2/ea-lpc3250devkitv2.c
@@ -5,7 +5,7 @@
  */
 
 #include <init.h>
-#include <common.h>
+#include <config.h>
 #include <asm/io.h>
 #include <asm/global_data.h>
 
diff --git a/board/ea/mx7ulp_com/mx7ulp_com.c b/board/ea/mx7ulp_com/mx7ulp_com.c
index cd9591a9e324..8f78937e0973 100644
--- a/board/ea/mx7ulp_com/mx7ulp_com.c
+++ b/board/ea/mx7ulp_com/mx7ulp_com.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2016 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
 #include <init.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
-- 
2.34.1

