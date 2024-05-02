Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A365C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:36:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 531B788C50;
	Thu,  2 May 2024 03:32:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iANEHM36";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47A3488C41; Thu,  2 May 2024 03:32:24 +0200 (CEST)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C6D788BDF
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:32:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-43ae2a44963so16724931cf.3
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613541; x=1715218341; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d+70cEoXL0D8S5gDyInV8x03oyinQauJhc+9pbiaS20=;
 b=iANEHM365jG0x4M9mrM1csODFWis1yqHi8/s35serKrEvr0ZiMSfnnm3uz4XZEuVW3
 mjLix/b1d7snwO0hby6Z5k5Yrvm7gbSctFZdKdtFGsd8kBkf8RehnYcc2JnvuhkAknO0
 f8g3PaPDbZI9+OVtUaXfwLW7BCV9qlAy4/qo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613541; x=1715218341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d+70cEoXL0D8S5gDyInV8x03oyinQauJhc+9pbiaS20=;
 b=a0B+1DKbMb5BD78Hjxgv/jvHTPhP2WcASff41C9TkMIO1zEd5FUWK2IlYAg1Tl27xQ
 49lEhFAgBBh9U65tzsdffetbjGfBmP9M8NWA0gTTwXkwBXaKuoFis1KXs8HYDa+BAuuu
 6N01fFGhE/LiS42W9C3mjCLQyvtZ5p3vHnRtmpqoQCemD3HBmyNRnmr4TpmI3eyzYXRo
 NQnKFYTBgbQCkIm6RWosYtDOPMzwTYaxin9E0KGno7A9k+NdMUET1ATt+RH8+3XCSwUk
 oNz1tfkFMs+k6Jgolof+aqh7QIVsu4Ac+8X1+XmF7zqgsL5wAllnY1GGY5/0srAEkOFb
 hXpw==
X-Gm-Message-State: AOJu0Yzsq8dbG81potoQa6QGiwJgkqC49SbkuAkC28h213Xgw3RVFlkx
 ASoV/wkqG/PoAhkEJ1fjva2FfYrukov9lBD4uG7zrm3aGuXdLYtnyOcOuJ6C1VoLizCV+hGGS7Y
 ZGvPYxujw
X-Google-Smtp-Source: AGHT+IFQicZLsHyT+UaC5jj03lx+cGvDY8RYFXoDJb0LUroLLv3u12/Atka8QOq/xf3++0emFK1HKA==
X-Received: by 2002:a05:622a:1:b0:43a:a8ad:1135 with SMTP id
 x1-20020a05622a000100b0043aa8ad1135mr687112qtw.0.1714613540966; 
 Wed, 01 May 2024 18:32:20 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.32.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:32:20 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Subject: [PATCH 27/81] extcon: Remove <common.h> and add needed includes
Date: Wed,  1 May 2024 19:30:44 -0600
Message-Id: <20240502013138.2383421-27-trini@konsulko.com>
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
Cc: Simon Glass <sjg@chromium.org>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/extcon/extcon-max14526.c | 1 -
 drivers/extcon/extcon-uclass.c   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/extcon/extcon-max14526.c b/drivers/extcon/extcon-max14526.c
index a33b5ef919cc..2d2166bde682 100644
--- a/drivers/extcon/extcon-max14526.c
+++ b/drivers/extcon/extcon-max14526.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2022 Svyatoslav Ryhel <clamor95@gmail.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <i2c.h>
 #include <linux/delay.h>
diff --git a/drivers/extcon/extcon-uclass.c b/drivers/extcon/extcon-uclass.c
index 9dd22b576269..1a5928738820 100644
--- a/drivers/extcon/extcon-uclass.c
+++ b/drivers/extcon/extcon-uclass.c
@@ -5,7 +5,6 @@
 
 #define LOG_CATEGORY UCLASS_EXTCON
 
-#include <common.h>
 #include <extcon.h>
 #include <dm.h>
 
-- 
2.34.1

