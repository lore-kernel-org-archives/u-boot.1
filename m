Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 930B3C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:39:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF4B688CA3;
	Thu,  2 May 2024 03:33:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nfVJWgoK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BB4988C8D; Thu,  2 May 2024 03:33:32 +0200 (CEST)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CE8388CAE
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:33:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-43ab8e0f435so19420141cf.1
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613608; x=1715218408; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0FfbMP1/8F9+TSP26zNQby81q/U9/wBczzOYaKcNPjM=;
 b=nfVJWgoKcLJVxnzJ4/dG8klD1Eb5OpW+pty4k5Rot/SAM8nJgeumepe5L41CVAguJS
 2sYrSxs6eMoETUqQDxMudo1Kxp+2TQe4PyT563Ozx8ZiWwNau3aRHFdUvRBTopfNGdVY
 /8zSLoATlXdy0WdfE2SBAeoWshCM3klUFrTbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613608; x=1715218408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0FfbMP1/8F9+TSP26zNQby81q/U9/wBczzOYaKcNPjM=;
 b=hp1f3xWpKu5RdfANrQUKUMwGeJ30I+G1X3Sbd36YxhCTCISQ4POeb39S5Rs0Sp2zbT
 oMpHohsLmEBZn5oMu/IVoryCLG/nXy8ed14BclgviuNAelHcfhs1Jxxmoyt4eB07ctV0
 gF5oKejYrW2O7tQBIk/2lf23jHU+03vWxPWjk8cDfb6Wx+n44hQChEmQxGBGFYr79eiu
 QFI1L9QDUnQpAIQdGqYgD/Fr7d33SqWgRCBwgGHfwMWP1pPWv0iQvbrapHh7m24MHf7b
 ROUdeMt4cczSAEPaVmm7L4LCsIjVGuRgpbvgVNQkpQMU2BYBRvD52K7EEV0AHLvhmKlz
 R1sg==
X-Gm-Message-State: AOJu0YzLciSX/UxIyuGZEWNTYjAMNKP5obD64Vpl1fr/HgVS9V0RiTNA
 C5VCoHlAPbGpK+JxbBAgRAJnudLCumPa6uXVsQHudKI2GoxxAdG8bVP2C6dEU8Z9UvYtIEEzkzu
 SgGi+I6yX
X-Google-Smtp-Source: AGHT+IEthXCtwyHE00UD4Zm8wz+dvyJBx+Pkt0ubjrGQ7iMZlIss/QaSmeqn4TNRosxAfndHWqU/aw==
X-Received: by 2002:ac8:590e:0:b0:43a:fd5a:9706 with SMTP id
 14-20020ac8590e000000b0043afd5a9706mr5281464qty.59.1714613608075; 
 Wed, 01 May 2024 18:33:28 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.33.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:33:27 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 55/81] reboot-mode: Remove <common.h> and add needed includes
Date: Wed,  1 May 2024 19:31:12 -0600
Message-Id: <20240502013138.2383421-55-trini@konsulko.com>
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
Cc: Sean Anderson <seanga2@gmail.com>
---
 drivers/reboot-mode/reboot-mode-gpio.c   | 1 -
 drivers/reboot-mode/reboot-mode-nvmem.c  | 1 -
 drivers/reboot-mode/reboot-mode-rtc.c    | 1 -
 drivers/reboot-mode/reboot-mode-uclass.c | 1 -
 4 files changed, 4 deletions(-)

diff --git a/drivers/reboot-mode/reboot-mode-gpio.c b/drivers/reboot-mode/reboot-mode-gpio.c
index 305174736ede..22ee40c34333 100644
--- a/drivers/reboot-mode/reboot-mode-gpio.c
+++ b/drivers/reboot-mode/reboot-mode-gpio.c
@@ -3,7 +3,6 @@
  * Copyright (c), Vaisala Oyj
  */
 
-#include <common.h>
 #include <asm/gpio.h>
 #include <dm.h>
 #include <dm/devres.h>
diff --git a/drivers/reboot-mode/reboot-mode-nvmem.c b/drivers/reboot-mode/reboot-mode-nvmem.c
index da41ca41d9a1..b9af242520a0 100644
--- a/drivers/reboot-mode/reboot-mode-nvmem.c
+++ b/drivers/reboot-mode/reboot-mode-nvmem.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2022 Sean Anderson <sean.anderson@seco.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <nvmem.h>
 #include <reboot-mode/reboot-mode.h>
diff --git a/drivers/reboot-mode/reboot-mode-rtc.c b/drivers/reboot-mode/reboot-mode-rtc.c
index 972d0cdbcb5b..4f4ad63febc1 100644
--- a/drivers/reboot-mode/reboot-mode-rtc.c
+++ b/drivers/reboot-mode/reboot-mode-rtc.c
@@ -3,7 +3,6 @@
  * Copyright (c), Vaisala Oyj
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/device_compat.h>
 #include <reboot-mode/reboot-mode-rtc.h>
diff --git a/drivers/reboot-mode/reboot-mode-uclass.c b/drivers/reboot-mode/reboot-mode-uclass.c
index 2b38aa26b859..7cbe02eb4ed4 100644
--- a/drivers/reboot-mode/reboot-mode-uclass.c
+++ b/drivers/reboot-mode/reboot-mode-uclass.c
@@ -3,7 +3,6 @@
  * Copyright (c), Vaisala Oyj
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/device_compat.h>
 #include <dm/devres.h>
-- 
2.34.1

