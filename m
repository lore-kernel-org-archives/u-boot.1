Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E78BC4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:36:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E724388C5D;
	Thu,  2 May 2024 03:32:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Tukww5A0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC27D88C56; Thu,  2 May 2024 03:32:30 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7930D88C60
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:32:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-61b62005f38so75672077b3.2
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613546; x=1715218346; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9dexN8sFqJyYX+VEyn1k48UhN0XdI9Ggk/xBTMWGZRU=;
 b=Tukww5A0BKZr8MSdc4ab+IKzdB/UJk9qi0UQzkmAgp8V67ihHgApgzB1am1uiot3z2
 g0pKFGglG3oGZEDx1lt1SbVcPShfYRloKJymVGmBD4d5iN1+t5xvfTXbWCjM89dH5Dah
 iuL582p5QWTDFmQfnTkP+LP6hfZUK1EAWx+yo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613546; x=1715218346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9dexN8sFqJyYX+VEyn1k48UhN0XdI9Ggk/xBTMWGZRU=;
 b=vdVMfrhvka8HfKWIVd2n8Q+GCSaWMMJEXmO/073t+UEqAdNYBF0qqr02OGQHfd6kFU
 hv5bUYYLIlGOU2pIcucj5AUDl2guB9Z4h930WkdgZCGF+WhovNow1QjZ7uYn1kRZ0FvW
 WxnFCjKffQqYi+9JNgOCIgtoSY3D/UFjrWLUdFJuYWRteUzrsiWszDsjLgGUaiU2GARh
 3xzbaMpXSM4R2zk59mgeT4QxOF+aCTFJHU7CVrebqeBk9AuJw3zvJUG47D/dTyOMUC8f
 V2miKGOQpaT78giseAzEieWOKtonFnXsOx0CZF5tLkhh91ZX+LU3XF12iZy1zNKjJ8bJ
 OOtQ==
X-Gm-Message-State: AOJu0YzfRL8vcIh+S2+4EWla/ehoXHO4E+4H0Lihc0XTj5U954J+tKRf
 eqb7K946/dGvqPUafO9Wq18Emkg7ksoW/lLDejJ0hJYuLW5iAWll2WtywAuf5gMunpmI8qMnqW1
 jZKHcyDN0
X-Google-Smtp-Source: AGHT+IFcDG7uz7Dz5/Ucn9sp2gbNAw+H6U3tVqLNRWHLs6/0fuv9GGENVs9I3IeNhutki0ubEkSboA==
X-Received: by 2002:a05:690c:6905:b0:61b:342e:b0cd with SMTP id
 if5-20020a05690c690500b0061b342eb0cdmr4622540ywb.24.1714613546157; 
 Wed, 01 May 2024 18:32:26 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.32.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:32:25 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH 31/81] fuzz: Remove <common.h> and add needed includes
Date: Wed,  1 May 2024 19:30:48 -0600
Message-Id: <20240502013138.2383421-31-trini@konsulko.com>
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
 drivers/fuzz/fuzzing_engine-uclass.c  | 1 -
 drivers/fuzz/sandbox_fuzzing_engine.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/fuzz/fuzzing_engine-uclass.c b/drivers/fuzz/fuzzing_engine-uclass.c
index b16f1c4cfb71..08ce3ed2ec15 100644
--- a/drivers/fuzz/fuzzing_engine-uclass.c
+++ b/drivers/fuzz/fuzzing_engine-uclass.c
@@ -6,7 +6,6 @@
 
 #define LOG_CATEGORY UCLASS_FUZZING_ENGINE
 
-#include <common.h>
 #include <dm.h>
 #include <fuzzing_engine.h>
 
diff --git a/drivers/fuzz/sandbox_fuzzing_engine.c b/drivers/fuzz/sandbox_fuzzing_engine.c
index ebb938e5ba86..677402470edc 100644
--- a/drivers/fuzz/sandbox_fuzzing_engine.c
+++ b/drivers/fuzz/sandbox_fuzzing_engine.c
@@ -4,7 +4,6 @@
  * Written by Andrew Scull <ascull@google.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <fuzzing_engine.h>
 #include <asm/fuzzing_engine.h>
-- 
2.34.1

