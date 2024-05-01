Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0E34C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 03:06:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B1DD88C91;
	Wed,  1 May 2024 04:45:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="N6r5BaqN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A64F88C32; Wed,  1 May 2024 04:45:39 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3B3588C4B
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:45:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-69cb4a046dfso26210406d6.2
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531535; x=1715136335; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cmgk1PLhS4n4YqQmajiebqlsPW+BOj5ICLU2a3n52bo=;
 b=N6r5BaqNzW8OzaFgHSAmt4+wYBUwhwAGutRZvSE4xkXj5Bz3WNUzRhkimPZsSPCSw1
 EXdVswZaZ925NslxaUMTXWSrnKE7KHeu3Yao17VvbDDbMw7PfNlgH0Uw3EfkK35ascP3
 BgEriQj3hiaM8IeAgHORYdGkWEyevIUMWMGec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531535; x=1715136335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cmgk1PLhS4n4YqQmajiebqlsPW+BOj5ICLU2a3n52bo=;
 b=XqcL/HbSFwrfF1NW/QPbtJCHxym4KmSazEyeNbYLoRfTnCb0BtWcB6gUaPqatb4b0r
 le1SSi+gxpLOSnkobApAwaJf0Q/blbh82yQuWYx9D1ie9BJfT3P5CNG+jNKmBMOHAT1y
 C++r9Kdlwy/Tb8zWQHOzkdAgQ1L+UKXXMhLEFiNx73xNkWNQBdq3ChGckkqT1RtPYU3m
 eZ8UhHkC0uEMNUEPHfVn+vbcDBFaxJbWlNUHT/nj+snMaehzia95fakV3RBpjGa4GqyR
 DS6qymoaO6chXOkYloS7qegOK2jZ0t0nQ3WTumqEu0FTRfg3cBPPz+jNFnL6E1BbtIq1
 ZtjA==
X-Gm-Message-State: AOJu0Yy3QmSAdRR51MCYw9c1DNAV09fjF8Zpmno7FGRgaUjoNSo6peF7
 HSROwD8Ms9rNw83YuA5BMbnRi8U2ReSM6eGdqyKGYWTgZr4SOLOtcH7mhRjvybNxFPiTCGloGhh
 PXdOsH9Ko
X-Google-Smtp-Source: AGHT+IFDNimYvvN1c2/jA02+yg5GaVsyHj0z7PAU8htdLNpd71eXeaKF8w5ljoBdQVa1k2yu4eYdwQ==
X-Received: by 2002:a05:6214:2484:b0:69b:4503:9fbf with SMTP id
 gi4-20020a056214248400b0069b45039fbfmr1165547qvb.43.1714531535596; 
 Tue, 30 Apr 2024 19:45:35 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.45.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:45:35 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Yang Xiwen <firbidden405@outlook.com>
Subject: [PATCH 119/149] board: skyworth: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:42:46 -0600
Message-Id: <20240501024316.1767971-119-trini@konsulko.com>
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
Cc: Yang Xiwen <firbidden405@outlook.com>
---
 board/skyworth/hc2910-2aghd05/hc2910-2aghd05.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/skyworth/hc2910-2aghd05/hc2910-2aghd05.c b/board/skyworth/hc2910-2aghd05/hc2910-2aghd05.c
index abad5efdafb4..22be10d70a73 100644
--- a/board/skyworth/hc2910-2aghd05/hc2910-2aghd05.c
+++ b/board/skyworth/hc2910-2aghd05/hc2910-2aghd05.c
@@ -3,7 +3,6 @@
  * Board init file for Skyworth HC2910 2AGHD05
  */
 
-#include <common.h>
 #include <fdtdec.h>
 #include <init.h>
 #include <asm/system.h>
-- 
2.34.1

