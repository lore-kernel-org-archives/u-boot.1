Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4633FC369D9
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 01:05:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47D3D807B1;
	Thu,  1 May 2025 03:05:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="odwrb725";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 564B6807B1; Thu,  1 May 2025 03:05:25 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 085008056A
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 03:05:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3d450154245so3735395ab.2
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 18:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746061521; x=1746666321; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sla4UY5KLLFwgqTsQ83c75bL1Qu/O0DWwrWXaDVzGHo=;
 b=odwrb725VM+7tnWx47ejk8rrRqwDlKmZVhjCuNcexf2NYU/PwszShRmq0HvStCa4Tv
 zGTVkQ9xt2T7ss97Y/NOqGgVBPR4KnyaFRXwpgPXuW1UA9y/CDXFHWKzTYihmeM/xdZ6
 +7Xs7oNVJleI6S4il5DcbPHsdkzxl5P5tdMCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746061521; x=1746666321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sla4UY5KLLFwgqTsQ83c75bL1Qu/O0DWwrWXaDVzGHo=;
 b=NFfONUFDCohh+CJ364R7BJoLQflotuoqFOStbMox46GB7l8px6y5Xtks6yjour8RJ3
 M2/qfyXda59HI+afhXdpqvZTOaETwxteqBOsEqp0COCzcek/0d42NY/w3TLM7v3wqASF
 +AekOi4BgacMddQmkaWM8ktVRJGN6ZkA/Q3CdginblX6PZwhHjlSJ+Nf3tL+k/RpDmqU
 jHEMhzHGpCKKU2JX/KtbUTlapruOwVIBYvOQjGUyLIRTV7irKhPfsFYJyKcKf+JN+Y9n
 KidXW61C5QTiBpUE8gmFHEvg6TqAKXfHa97Yggk/dfhEfBd5xQc8xk89Q/ZXELGQkPpz
 xaMg==
X-Gm-Message-State: AOJu0YwkOPr2BJQ8ODjkGvn1tGfsq6c2TAni0BUbHSqQgO90KMVA2nDx
 FRSOD9BWphjDSwGRY5mNr9qZ3m+UkK62LC4eMV5yvaFP5IhI7AM9q7rE7oVGVIm8ewduY0cA2Vs
 =
X-Gm-Gg: ASbGnctkvKhk8m7X+7iiquK5D1GYnJDST/B/yQsYv0p/30+RQO41/FJNeDb4y+O37pI
 DBe6r8kmkNQ7T1sJu5e+znT4aqNyBwDw7xhsFHv6Hs0inmt4CDa8G2Bmo3+70sqhfFeQUvOKRJZ
 4yIsupZ25JmymSapLbCV41oxxfiKlzGDsZWmlfv6NI/jl2gjoxlli19GfdY5leaPwo0WZ9LqhUH
 8bso2mE7epCbbhC/f9deWRby7GyZznLFMTFe4wzbUrJ9PANmAzBpJ6C7whBoQLugNSd4xE0SWwV
 SG9N2YT/pVdETPje7l8QhFR/SEXmHeYkyJSuKP2gilzYr+CJzHOPhYghl86tWYjdYnyDuN+ytZU
 JOg==
X-Google-Smtp-Source: AGHT+IFr0BvtpoDi6rpTSeYqpbtiI/omYKrv31gWTESY2mTyGzInkOvJVulUXJo4KgE40xxrveLW7A==
X-Received: by 2002:a05:6e02:1aaf:b0:3d1:a75e:65f6 with SMTP id
 e9e14a558f8ab-3d970267206mr9422625ab.18.1746061520754; 
 Wed, 30 Apr 2025 18:05:20 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d95f480a99sm10771855ab.68.2025.04.30.18.05.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 18:05:19 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Oliver Graute <oliver.graute@kococonnector.com>
Subject: [PATCH v2 02/22] congatec: Include env.h to permit reading the
 environment
Date: Wed, 30 Apr 2025 19:04:27 -0600
Message-ID: <20250501010456.3930701-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501010456.3930701-1-sjg@chromium.org>
References: <20250501010456.3930701-1-sjg@chromium.org>
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

This file reads from the environment but does not include the correct
header. Update it.

Drop the unnecessary config.h while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 board/congatec/cgtqmx8/cgtqmx8.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/board/congatec/cgtqmx8/cgtqmx8.c b/board/congatec/cgtqmx8/cgtqmx8.c
index 054e4e10867..087ca007776 100644
--- a/board/congatec/cgtqmx8/cgtqmx8.c
+++ b/board/congatec/cgtqmx8/cgtqmx8.c
@@ -3,7 +3,8 @@
  * Copyright 2018 congatec AG
  * Copyright (C) 2019 Oliver Graute <oliver.graute@kococonnector.com>
  */
-#include <config.h>
+
+#include <env.h>
 #include <errno.h>
 #include <linux/libfdt.h>
 #include <fsl_esdhc.h>
-- 
2.43.0

