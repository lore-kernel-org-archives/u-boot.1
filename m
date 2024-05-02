Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC45C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:34:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E68788C22;
	Thu,  2 May 2024 03:32:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZoWEGYvW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 202DB88C05; Thu,  2 May 2024 03:32:07 +0200 (CEST)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BFCE88C17
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:32:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-de477949644so8296173276.1
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613524; x=1715218324; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=p32AsXAoXlbh2FP4LW5LeUAbrGqvIG3nHRFMpTJ+Xik=;
 b=ZoWEGYvWXKd978Bg+5YtatvHTpBfHYG/RFYcmrnW3hLUfzgeJR+p+rFdVGs5lfQ4ek
 R0XYllXmSumtmxv5/O7ZDgz9bi/QHsNQkP+Z0dxRhoktpPL0XciW1yHFEamyZ/1Bij5/
 a9DvjocnTQVAbxgncZ5Wm2WetdqdmhpVGLeGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613524; x=1715218324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p32AsXAoXlbh2FP4LW5LeUAbrGqvIG3nHRFMpTJ+Xik=;
 b=NhuNtAmtZUYt6cpXpDkgPLQ4jo+bR9o+l9Pp37LpNhHPZQ44Dn+IunNULdyRMNTOg5
 r3c2SRi/6jommQfEUB8t3LzTPGrU8BNen7c+9/Oq7XP1VnvczJNdTO5refaxOfb9mVkr
 Ogu9e3cev+OvOMsjVWJtXA8UiDWq3fw4DBmAGudkkBYUnJN8psZyn9O/7noZe86sZbZa
 2aVNVuEkNJZpMSqmADg6+pDOitVP7LSrg4lNYyWJV9BEsEw7h3jB3IiAKuwcXqRfs9lG
 W7fUkL9ulbUH7Ab+vagjE1EYCDjs6PtHgxQ7BsZ5HI0v80av49PEPypKtxB1BBB2iMw9
 1ZEA==
X-Gm-Message-State: AOJu0Yyv91BswqTEOKNjMXrUH9IDYmIzu2fU2JQqoljE9OtzN0nEpPMd
 XPQcixARbIkYyGaDWkt9tdUCynNKpepiSmGlOsFnGHjJscplyVPWnahW1/tBmTzWoPk5WrivSeL
 YmmH0jqIB
X-Google-Smtp-Source: AGHT+IEhClpW7UDh67AQ2qeol+xgZvieQcu1wlaA/RAb0M4IqoJZWUwD5YLmIqsNCxl/NkV/JsYTsA==
X-Received: by 2002:a25:a043:0:b0:de5:c1a4:560c with SMTP id
 x61-20020a25a043000000b00de5c1a4560cmr588286ybh.56.1714613521700; 
 Wed, 01 May 2024 18:32:01 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.32.00
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:32:01 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 17/81] button: Remove <common.h> and add needed includes
Date: Wed,  1 May 2024 19:30:34 -0600
Message-Id: <20240502013138.2383421-17-trini@konsulko.com>
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
---
 drivers/button/button-adc.c    | 1 -
 drivers/button/button-gpio.c   | 1 -
 drivers/button/button-uclass.c | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/button/button-adc.c b/drivers/button/button-adc.c
index 9c24c960e6ff..da7ddf2a8577 100644
--- a/drivers/button/button-adc.c
+++ b/drivers/button/button-adc.c
@@ -5,7 +5,6 @@
  * Author: Marek Szyprowski <m.szyprowski@samsung.com>
  */
 
-#include <common.h>
 #include <adc.h>
 #include <button.h>
 #include <log.h>
diff --git a/drivers/button/button-gpio.c b/drivers/button/button-gpio.c
index 7b5b3affe2dd..43b82d98aeb7 100644
--- a/drivers/button/button-gpio.c
+++ b/drivers/button/button-gpio.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2020 Philippe Reynes <philippe.reynes@softathome.com>
  */
 
-#include <common.h>
 #include <button.h>
 #include <dm.h>
 #include <dm/lists.h>
diff --git a/drivers/button/button-uclass.c b/drivers/button/button-uclass.c
index 032191d61abc..cda243389df3 100644
--- a/drivers/button/button-uclass.c
+++ b/drivers/button/button-uclass.c
@@ -7,7 +7,6 @@
 
 #define LOG_CATEGORY UCLASS_BUTTON
 
-#include <common.h>
 #include <button.h>
 #include <dm.h>
 #include <dm/uclass-internal.h>
-- 
2.34.1

