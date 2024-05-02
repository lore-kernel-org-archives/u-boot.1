Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA9B2C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:42:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B029B88D0F;
	Thu,  2 May 2024 03:34:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="h2myH70I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9044488CC9; Thu,  2 May 2024 03:34:15 +0200 (CEST)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91BCA88CF4
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:34:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-790e7c02430so378712685a.0
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613651; x=1715218451; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=09ziqZVYWk0P/BIASiuuhQ1VLlyS8KdKQ5TSU3iccVs=;
 b=h2myH70InIYyByS2SU0q6gYVmMSkHAGw3OCutKOuWGWQ3UWOuTUUb20ic7j73UeRGL
 wMO+8/HWWz0o78CYlyexBHMOzCCshLh6Qs6VDm0Z93waxNdiT5RaI/YJEDPmgO8rlc7k
 jlRT6hnXxcXsLby5p0yWp92caONlNhXRNMSdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613651; x=1715218451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=09ziqZVYWk0P/BIASiuuhQ1VLlyS8KdKQ5TSU3iccVs=;
 b=Sl2qKtXNIKlSpO2YDbVAScjoMCRsp2tfI/R5GlJkTHQ2PjKmX/pAquBqhKKRT4eLn5
 zR+tBPJsC2LXfZW5MGsUjaqtbHk3uUf2wJMtqklG201vM0Kw7X7lgS4w/sBQMwxhs222
 sDeEzPw2I/D1ca2HE4GXQC0RQE1CsuFDgErmv/FoQqJopjBp/26wuv0PVC/vJ0Yxr6Aw
 YTlAd1q78M7D0mD27WXHutkml8WY3ciY+EgIQeFOjZLnKbzLobD2UH/ZFrDaV6VI+giH
 NEAvTAWztuV+5aWYQSCMbHWrru+rw7arN2oqxQu6oGNqnBiQ+DPvg97BFvkspbDxnGXL
 7Ydg==
X-Gm-Message-State: AOJu0YxmilZf4Jj2Xs3J9996UhfOkEREkL7ezn2K8AzP7Vx0YJYLNryw
 rAOanET04M8QiDu28Kc3woQBFJe1CgZU9pkz1necy6o55VO4xE3dkezn29sfW1y5EispTLeBdYA
 YfIcXGWHm
X-Google-Smtp-Source: AGHT+IGVAacfeDccY4/5j4WvNc4hoQ5O/xvcrHvxsEObmby+ZwSeHE+Y6C6aV5h5k4X4mv3aOC41Cw==
X-Received: by 2002:a05:622a:410:b0:43a:d063:c8d7 with SMTP id
 n16-20020a05622a041000b0043ad063c8d7mr685279qtx.1.1714613651375; 
 Wed, 01 May 2024 18:34:11 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.34.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:34:11 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH 77/81] w1-eeprom: Remove <common.h> and add needed includes
Date: Wed,  1 May 2024 19:31:34 -0600
Message-Id: <20240502013138.2383421-77-trini@konsulko.com>
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
---
 drivers/w1-eeprom/ds24xxx.c          | 1 -
 drivers/w1-eeprom/ds2502.c           | 1 -
 drivers/w1-eeprom/eep_sandbox.c      | 1 -
 drivers/w1-eeprom/w1-eeprom-uclass.c | 1 -
 4 files changed, 4 deletions(-)

diff --git a/drivers/w1-eeprom/ds24xxx.c b/drivers/w1-eeprom/ds24xxx.c
index 4be378b43d03..413d8bc58814 100644
--- a/drivers/w1-eeprom/ds24xxx.c
+++ b/drivers/w1-eeprom/ds24xxx.c
@@ -7,7 +7,6 @@
  *
  */
 
-#include <common.h>
 #include <linux/err.h>
 #include <dm.h>
 #include <w1-eeprom.h>
diff --git a/drivers/w1-eeprom/ds2502.c b/drivers/w1-eeprom/ds2502.c
index a67f5edd0feb..db9f41e97269 100644
--- a/drivers/w1-eeprom/ds2502.c
+++ b/drivers/w1-eeprom/ds2502.c
@@ -20,7 +20,6 @@
  * Martin Fuzzey <martin.fuzzey@flowbird.group>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/device_compat.h>
 #include <linux/err.h>
diff --git a/drivers/w1-eeprom/eep_sandbox.c b/drivers/w1-eeprom/eep_sandbox.c
index 27c7f9f1b6b8..2a69ca27de79 100644
--- a/drivers/w1-eeprom/eep_sandbox.c
+++ b/drivers/w1-eeprom/eep_sandbox.c
@@ -4,7 +4,6 @@
  *
  */
 
-#include <common.h>
 #include <linux/err.h>
 #include <dm.h>
 #include <w1-eeprom.h>
diff --git a/drivers/w1-eeprom/w1-eeprom-uclass.c b/drivers/w1-eeprom/w1-eeprom-uclass.c
index 70ba537243f8..3919aad3c8af 100644
--- a/drivers/w1-eeprom/w1-eeprom-uclass.c
+++ b/drivers/w1-eeprom/w1-eeprom-uclass.c
@@ -12,7 +12,6 @@
 
 #define LOG_CATEGORY UCLASS_W1_EEPROM
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <w1.h>
-- 
2.34.1

