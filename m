Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5495C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 03:01:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF2DF88C09;
	Wed,  1 May 2024 04:45:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QrLzrJWg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 224B788C04; Wed,  1 May 2024 04:45:10 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B7D188BE9
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:45:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-69b6d36b71cso32329086d6.3
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531506; x=1715136306; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jm9KckwOjUT32pT656lPqSuCgO62cg7PwCkgt28mYUI=;
 b=QrLzrJWgClZ4A51K8B2TTDIPonM7puA4MHJeGI7Dpa1FnFj8NGB5masYAK3VErO4Ax
 2/N6KMb+yeouhXFcaHQWCU0v5Z8j91MB29LAeGe+uOjRAxz+qtj8XneJ94Lkp91M9pX/
 6V+rHZiXGkwksp8GuZZSGcloNzPoiFKMWta0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531506; x=1715136306;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jm9KckwOjUT32pT656lPqSuCgO62cg7PwCkgt28mYUI=;
 b=BjUzF02T1Jer1ptcEh/fd6znCnEHlbNkd7qjgea+oh2g+u9M/S3dh+8Pk3nm3omU0t
 iBPKt3CDqwRRUqerCCZBUIEDz1IksN3PPlO1Tckqm1I6yks5qUfZWZq2yZTppcBm5POy
 0mVT+fWXDagwDCSM7puA2tzEm3TFoETreWYfnFB5AktE3lL1+NJ/N6sa/l1CG1yoYMc0
 hR/eaCkpUTQ3KYXLwgavC2jEDo3g7Iqn0Qd5gL0mE1+YTfbYyEkho372kz9frmvw3MfK
 YOimy//unNctSqDTh81vNboiaZMpIOhptVc47ZIOXYbS21/zGrS6nBkoMNU6JoLsFp5Z
 ZGQw==
X-Gm-Message-State: AOJu0YzdHl+vO2Hs75Ab/5Fcpbq8wB6YHswno2YKvSsZoctaUbsY2z8V
 gPqXqRTrDvRf9L83R0tomacW5yBZAtYD9JeDgkEfhWfOnUifYT9/5o/lqVaoezav45Sv6pnZssf
 uGuAmUNTL
X-Google-Smtp-Source: AGHT+IGCc6cUkjF/E+/hGWpx+D/KkLdyCt9HFVJhVZcKIwsnxL7QLqUZFxnaYFvnqrnaOUH9RHu/+g==
X-Received: by 2002:a05:6214:20ee:b0:6a0:b2fa:71e9 with SMTP id
 14-20020a05621420ee00b006a0b2fa71e9mr1432660qvk.61.1714531506071; 
 Tue, 30 Apr 2024 19:45:06 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.45.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:45:05 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Martyn Welch <martyn.welch@collabora.com>,
 Ian Ray <ian.ray@gehealthcare.com>
Subject: [PATCH 093/149] board: msc: Remove <common.h> and add needed includes
Date: Tue, 30 Apr 2024 20:42:20 -0600
Message-Id: <20240501024316.1767971-93-trini@konsulko.com>
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
Cc: Martyn Welch <martyn.welch@collabora.com>
Cc: Ian Ray <ian.ray@gehealthcare.com>
---
 board/msc/sm2s_imx8mp/sm2s_imx8mp.c | 1 -
 board/msc/sm2s_imx8mp/spl.c         | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/board/msc/sm2s_imx8mp/sm2s_imx8mp.c b/board/msc/sm2s_imx8mp/sm2s_imx8mp.c
index 6ccbf02db06e..b1ce014bd55d 100644
--- a/board/msc/sm2s_imx8mp/sm2s_imx8mp.c
+++ b/board/msc/sm2s_imx8mp/sm2s_imx8mp.c
@@ -7,7 +7,6 @@
  * Copyright 2021 Collabora Ltd.
  */
 
-#include <common.h>
 #include <errno.h>
 #include <miiphy.h>
 #include <netdev.h>
diff --git a/board/msc/sm2s_imx8mp/spl.c b/board/msc/sm2s_imx8mp/spl.c
index ed7a1b7d3d00..b1b5561838dc 100644
--- a/board/msc/sm2s_imx8mp/spl.c
+++ b/board/msc/sm2s_imx8mp/spl.c
@@ -7,7 +7,7 @@
  * Copyright 2021 Collabora Ltd.
  */
 
-#include <common.h>
+#include <config.h>
 #include <cpu_func.h>
 #include <fsl_esdhc_imx.h>
 #include <hang.h>
-- 
2.34.1

