Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF8BC4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:40:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A150E88CE7;
	Thu,  2 May 2024 03:33:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dEL7rXds";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DEB588CC9; Thu,  2 May 2024 03:33:55 +0200 (CEST)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B88988CA2
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:33:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-43ad4097aefso18050721cf.2
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613632; x=1715218432; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FKx9cdlelBr8Bn20wUPdTgjnAMrcsIu5gwsg5LpBFI4=;
 b=dEL7rXdsOELi68qTw4ko7/ZytMJGcn7dP6lx9j9XnOynsD8YYjqN0puLYqJXEms5Rn
 7ZYgGLbkYCaEzoOYgCLpdiG7We1jzuIX8EuG5fN4ILyt4a1x+dqdbUkOvDL6wkNPlwtI
 JMsfZ86tlsz1tiSLKiWw5lR4mwzBOMIq62chk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613632; x=1715218432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FKx9cdlelBr8Bn20wUPdTgjnAMrcsIu5gwsg5LpBFI4=;
 b=hYUypXKdUFpT+zz8F9TtkA6gmZJTKd3FDFD+Q7p+688O+vYLJsIgp5vJJr2LtHbxng
 HMPOkpD3aO21Q5fSwexuor7OfvDhINTZnoPPKs3KaDuoQqy4F4A2Mftp/X/88lgPtTmB
 EC/nPaKpdeoteSg+G+jISY5+1gxF7hZ8LmhO/XliExzLOjlhLfHEvzr2XXpGgP1EMVPT
 KvgGxs+6o0yvIM3S4Z0BgH20eAUXMJP36cFIiRsQH3bDKu0rU6MCd/zHn/hsDEHhMrHP
 zIMYJ1vZWrwF6iX1d3FNpie639xqWessq4Q4nmuCASSuuiKbYek7Ftzw4FBbJhBG4NXw
 ntCQ==
X-Gm-Message-State: AOJu0YzbFRkuHNh2Vy12fftxCh/jgDqV68NudigFTiTa+TfwA9bLMfez
 HFyzHbtgq5XBXsppMpaizZi8OLl0BjV82wIPUevZgdCHfltJqsi1oHoZGhNktPlYSc3KZRx7XhI
 9udRQU65A
X-Google-Smtp-Source: AGHT+IFiz3FiQWjp4BRT5/vhXT9sr55kRGAuaysPiiWxX0wiek61W8s7Gkn+N3RV9LR6tqSc7pcZOg==
X-Received: by 2002:a05:622a:1485:b0:43a:b9e1:3891 with SMTP id
 t5-20020a05622a148500b0043ab9e13891mr653420qtx.51.1714613631970; 
 Wed, 01 May 2024 18:33:51 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.33.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:33:51 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 67/81] sysinfo: Remove <common.h> and add needed includes
Date: Wed,  1 May 2024 19:31:24 -0600
Message-Id: <20240502013138.2383421-67-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502013138.2383421-1-trini@konsulko.com>
References: <20240502013138.2383421-1-trini@konsulko.com>
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

Remove <common.h> from this driver directory and when needed
add missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Tom Rini <trini@konsulko.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>
---
 drivers/sysinfo/gazerbeam.c      | 1 -
 drivers/sysinfo/gpio.c           | 1 -
 drivers/sysinfo/rcar3.c          | 1 -
 drivers/sysinfo/sandbox.c        | 1 -
 drivers/sysinfo/smbios.c         | 1 -
 drivers/sysinfo/sysinfo-uclass.c | 1 -
 6 files changed, 6 deletions(-)

diff --git a/drivers/sysinfo/gazerbeam.c b/drivers/sysinfo/gazerbeam.c
index c1fae6ccf2a6..a3c9d5354dd2 100644
--- a/drivers/sysinfo/gazerbeam.c
+++ b/drivers/sysinfo/gazerbeam.c
@@ -4,7 +4,6 @@
  * Mario Six, Guntermann & Drunck GmbH, mario.six@gdsys.cc
  */
 
-#include <common.h>
 #include <dm.h>
 #include <sysinfo.h>
 #include <i2c.h>
diff --git a/drivers/sysinfo/gpio.c b/drivers/sysinfo/gpio.c
index 82f90303bb70..aaca318419b0 100644
--- a/drivers/sysinfo/gpio.c
+++ b/drivers/sysinfo/gpio.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2021 Sean Anderson <sean.anderson@seco.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <sysinfo.h>
diff --git a/drivers/sysinfo/rcar3.c b/drivers/sysinfo/rcar3.c
index 7b127986da7e..37e2cccd9afe 100644
--- a/drivers/sysinfo/rcar3.c
+++ b/drivers/sysinfo/rcar3.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2021 Marek Vasut <marek.vasut+renesas@gmail.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <i2c_eeprom.h>
 #include <log.h>
diff --git a/drivers/sysinfo/sandbox.c b/drivers/sysinfo/sandbox.c
index d270a26aa438..d39720958f07 100644
--- a/drivers/sysinfo/sandbox.c
+++ b/drivers/sysinfo/sandbox.c
@@ -4,7 +4,6 @@
  * Mario Six, Guntermann & Drunck GmbH, mario.six@gdsys.cc
  */
 
-#include <common.h>
 #include <dm.h>
 #include <sysinfo.h>
 
diff --git a/drivers/sysinfo/smbios.c b/drivers/sysinfo/smbios.c
index 80ebd1921d8e..a7ac8e3f072a 100644
--- a/drivers/sysinfo/smbios.c
+++ b/drivers/sysinfo/smbios.c
@@ -4,7 +4,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <sysinfo.h>
 
diff --git a/drivers/sysinfo/sysinfo-uclass.c b/drivers/sysinfo/sysinfo-uclass.c
index 10194d0e14c3..d77d1e3ee442 100644
--- a/drivers/sysinfo/sysinfo-uclass.c
+++ b/drivers/sysinfo/sysinfo-uclass.c
@@ -6,7 +6,6 @@
 
 #define LOG_CATEGORY UCLASS_SYSINFO
 
-#include <common.h>
 #include <dm.h>
 #include <sysinfo.h>
 
-- 
2.34.1

