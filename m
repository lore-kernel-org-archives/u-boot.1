Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9C88C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:46:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FFC688AC4;
	Wed,  1 May 2024 04:43:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KiSNaEgV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84EE388AAD; Wed,  1 May 2024 04:43:40 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 110D188ABB
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:43:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-790f91b834cso232569885a.0
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531416; x=1715136216; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Olxont2QveVh3zAscdBkDpY1JKJ4/2xS2vjnqBTH0gk=;
 b=KiSNaEgVdLbQUuRcUrU36JRlZalcFiNNFpT8Aw2RD2YQOQYOXggk6hnZ/vAow7/RAp
 5aeBaCTPGoloSGWA2egFIytfBUjfZKXcY92KnVrOtt0TYVqLV4jXsJL+QwJWLjoJ7fXf
 0Lvq9UqIuSm1ob1wSOHSBbGDiMwVKBLkk2rv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531416; x=1715136216;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Olxont2QveVh3zAscdBkDpY1JKJ4/2xS2vjnqBTH0gk=;
 b=grIS42dAT7B1FDcirE+krxHyxNCtoSZYVGuST/xqQu5A2X8zVtEp3OuR4kl21gWQka
 Vu0kPqvboTDgSjCTjSCZxLmr1q3MeD1ued5rpoWvd/LthyBikD48ij/k2LETnfU4znY/
 NJqgzECQp4ubzTnp8Bm9VriPYjRf0oYLEFfzuuf30FNUpr0wv1npGQMkVdlk3y9AXZ3D
 zgQQhIhym/nyL9S57ioFnUsVXHEs4N5/lNoyz+jWSuBZ1/7nhlk2euFV1De8c2THLKYr
 ii4i/vCKLwfdbaMUBrrdN89ITP/8OFJwLQDARQxjCyrZeestPkZ7P5q5W9Oq1J6zV5ig
 12pQ==
X-Gm-Message-State: AOJu0Yz1+yWQEMSPSguY1x2j6ZHFT1CGj0gs+UHxrS9+P+OLT3aGZXGL
 lFbhU/M9HGHt0D9P3YPWbPKKzfwXzJHvjszWv8CiPcnXK8tpcBbSy8GZkvF/RondP/A5ztxaINT
 uSnN4NA==
X-Google-Smtp-Source: AGHT+IFGtynW14NkOUZKkShyxpoSynKQVgRw6tYLRSqRmA0W8wgzQc2ivMlnRqoYf0z1zvKFHMfljA==
X-Received: by 2002:a05:6214:1403:b0:6a0:cb52:c727 with SMTP id
 pr3-20020a056214140300b006a0cb52c727mr1093853qvb.24.1714531416645; 
 Tue, 30 Apr 2024 19:43:36 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.43.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:43:36 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heiko Schocher <hs@denx.de>
Subject: [PATCH 017/149] board: aristainetos: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:41:04 -0600
Message-Id: <20240501024316.1767971-17-trini@konsulko.com>
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
Cc: Heiko Schocher <hs@denx.de>
---
 board/aristainetos/aristainetos.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/aristainetos/aristainetos.c b/board/aristainetos/aristainetos.c
index 17f37badd746..8cfac9fbb342 100644
--- a/board/aristainetos/aristainetos.c
+++ b/board/aristainetos/aristainetos.c
@@ -9,7 +9,6 @@
  * Author: Fabio Estevam <fabio.estevam@freescale.com>
  */
 
-#include <common.h>
 #include <bmp_layout.h>
 #include <command.h>
 #include <image.h>
-- 
2.34.1

