Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8428CC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:56:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4550E88BA9;
	Wed,  1 May 2024 04:44:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZW7q/gAh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 988AF88B9E; Wed,  1 May 2024 04:44:40 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8403F88B7A
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:44:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-69b4454e2f1so28516676d6.0
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531477; x=1715136277; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gj6BlABb7jl5mZjvSDuC/9iVntR235d42XR5s5eSwkc=;
 b=ZW7q/gAh0kgpKok4eHbwDP6r6at2QqbeBDEHVMrnZhAP9TQJOkvCx3PB4FnWigDwUN
 jocKDhWaYgO7cTkR4E9xMEo4BGoJHZZoxsPMnf5YzvZ4WOIDhYhzfshbWwRUZOHVqRIU
 XQaLfHxq4ljcievz1xIf63CpLyOGD8uP83XXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531477; x=1715136277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gj6BlABb7jl5mZjvSDuC/9iVntR235d42XR5s5eSwkc=;
 b=ecfdvRh4ZlPj2vT5yq44qOTaNwz9OpWzBN4HzKhQY/+AqzPbcn7Shek7BJvlxY73yl
 +VpQv3WcxREc5RBXcRpoX51pDtDOZgYxkasMVlePI1w5HVMBdfahZA82Y1yzeFj8cx1V
 Hw28J7A1eMt7kaZYCdFnsTbQUU75JSz0lDveAlE6E45nOAi59JmHKbJkTaktdhdp2Cdc
 rlvlE3EbRmLR3xJ/jYXJERtm8DBqkWSV9OCmtUHvS9VidfawwQIMpxtFS+R6hrPZaakl
 bDyBTXX2ZS6x76fRA55kWcQ4qnqK5pLL9djs5dasomK/AewsU3teaSiOr2RTeULImKuK
 SsMQ==
X-Gm-Message-State: AOJu0YxB/UxaUTbmt0Shq2ayzBIPoN5ky5QPgyrBwtE/HEdMJSWWKOpO
 X3uMnW1CNRdmUKEYtEhD0Ei2o8mubziWrQA9pSSG+7lxZWMlpel2G++iy2l28DVLVaPsoasCWjo
 nJ5Ye9w==
X-Google-Smtp-Source: AGHT+IH94ImogrE+mefoG11A5nGsopnJR7UVYTrH4gEIxhc52wXTtMeeDvPrxlNYoP7Ioi/9mc2U+g==
X-Received: by 2002:a05:6214:2344:b0:6a0:cde0:e44e with SMTP id
 hu4-20020a056214234400b006a0cde0e44emr1188450qvb.60.1714531476953; 
 Tue, 30 Apr 2024 19:44:36 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.44.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:44:36 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: "Huan 'Kitty' Wang" <HuanWang@gehealthcare.com>,
 Ian Ray <ian.ray@gehealthcare.com>,
 Martyn Welch <martyn.welch@collabora.com>
Subject: [PATCH 066/149] board: ge: Remove <common.h> and add needed includes
Date: Tue, 30 Apr 2024 20:41:53 -0600
Message-Id: <20240501024316.1767971-66-trini@konsulko.com>
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
Cc: "Huan 'Kitty' Wang" <HuanWang@gehealthcare.com>
Cc: Ian Ray <ian.ray@gehealthcare.com>
Cc: Martyn Welch <martyn.welch@collabora.com>
---
 board/ge/b1x5v2/b1x5v2.c         | 1 -
 board/ge/common/ge_rtc.c         | 1 -
 board/ge/mx53ppd/mx53ppd.c       | 1 -
 board/ge/mx53ppd/mx53ppd_video.c | 1 -
 4 files changed, 4 deletions(-)

diff --git a/board/ge/b1x5v2/b1x5v2.c b/board/ge/b1x5v2/b1x5v2.c
index a2cbd1512e92..031773bc5ef3 100644
--- a/board/ge/b1x5v2/b1x5v2.c
+++ b/board/ge/b1x5v2/b1x5v2.c
@@ -17,7 +17,6 @@
 #include <asm/io.h>
 #include <asm/mach-imx/video.h>
 #include <command.h>
-#include <common.h>
 #include <i2c.h>
 #include <input.h>
 #include <ipu_pixfmt.h>
diff --git a/board/ge/common/ge_rtc.c b/board/ge/common/ge_rtc.c
index 6437afc7bd0a..5c62ecca8c89 100644
--- a/board/ge/common/ge_rtc.c
+++ b/board/ge/common/ge_rtc.c
@@ -3,7 +3,6 @@
  * Copyright 2017 General Electric Company
  */
 
-#include <common.h>
 #include <env.h>
 #include <dm/uclass.h>
 #include <rtc.h>
diff --git a/board/ge/mx53ppd/mx53ppd.c b/board/ge/mx53ppd/mx53ppd.c
index cc462d53da6a..9396d43f8add 100644
--- a/board/ge/mx53ppd/mx53ppd.c
+++ b/board/ge/mx53ppd/mx53ppd.c
@@ -8,7 +8,6 @@
  * Jason Liu <r64343@freescale.com>
  */
 
-#include <common.h>
 #include <init.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
diff --git a/board/ge/mx53ppd/mx53ppd_video.c b/board/ge/mx53ppd/mx53ppd_video.c
index 4e2c6ebde73c..eb4dd758b3b5 100644
--- a/board/ge/mx53ppd/mx53ppd_video.c
+++ b/board/ge/mx53ppd/mx53ppd_video.c
@@ -8,7 +8,6 @@
  * Fabio Estevam <fabio.estevam@freescale.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <linux/list.h>
 #include <asm/arch/iomux-mx53.h>
-- 
2.34.1

