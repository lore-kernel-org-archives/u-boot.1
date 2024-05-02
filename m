Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F422FC4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:36:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B430988C58;
	Thu,  2 May 2024 03:32:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tmBELhkE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F002388C58; Thu,  2 May 2024 03:32:25 +0200 (CEST)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7741888C38
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:32:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-43b0b09d012so17697291cf.3
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613542; x=1715218342; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0WoBWWkNyBBx4V+F9FWN4vIoB+6yivbN1AAIEUQGEqw=;
 b=tmBELhkEYlhyT58u14Wsg9/xXeljill0morlzj1MVM5e2CloyeCg2a4Q9S7a3+gKLX
 9mqOnA93spwCXZe9GCjfhsosim5J3Awag2eUfIhdwSedqH+//BcsAUVtBPwAfCNtEtNS
 1OlbZ/TKkLsoOjumknc1xnO2Z1iGbq4ySeMUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613542; x=1715218342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0WoBWWkNyBBx4V+F9FWN4vIoB+6yivbN1AAIEUQGEqw=;
 b=Lj0uCw/3UoAeagsAaJ/dqp61kAubRBARoGK9dOyiw56f9hgYerH2OLNm6P7eBgI2WL
 M6V1cS20tN+jycbqAEM6I/zNxS8UBrivJ3zTLJDG+Zi14MD6oQQGF2oT2MwLGtJcYKue
 1B3C7NXjfe3fXKcdbVHU1mDHMpD3dyb8W2buVGj5ybPfLd9tnKLDX7wbl83p/u+XqsPF
 Rk1QsrPkubzNgcXcAr8nwqHbY2wpNW7BT9jtY7QIDZXNQFbII5FkfdnuZOJVfZ7F/4KY
 kG2yjHXsrPV5CxY+6e4nYNYZ75gyODFe0UyrZe5I7mrChlLKQq0gYwhoIRYflXKh78JI
 Ue/w==
X-Gm-Message-State: AOJu0Yx/EVMulsnuLYgF18BBbbRWYOYM9WShhl4/tX0LouGXh7VfwIwH
 Q0MqmwU2Uc2ewqD2mZ4KRfIAPyqXfzKAjmyBgYZaKELSbf5r5nTiPBvu2aw5Mm/BadfGjCM8buQ
 HtOEw1SCr
X-Google-Smtp-Source: AGHT+IHeLuCW3IpxXyVkthAYpNmGPPM4/j6tm0mlhV+eaPxaQ/098QLxOBd8JreXvzroqJ3/Z3KpFg==
X-Received: by 2002:ac8:5a8e:0:b0:43b:7:7d81 with SMTP id
 c14-20020ac85a8e000000b0043b00077d81mr4488990qtc.66.1714613542039; 
 Wed, 01 May 2024 18:32:22 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.32.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:32:21 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH 28/81] fastboot: Remove <common.h> and add needed includes
Date: Wed,  1 May 2024 19:30:45 -0600
Message-Id: <20240502013138.2383421-28-trini@konsulko.com>
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
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>
---
 drivers/fastboot/fb_command.c | 2 +-
 drivers/fastboot/fb_common.c  | 2 +-
 drivers/fastboot/fb_getvar.c  | 2 +-
 drivers/fastboot/fb_mmc.c     | 1 -
 drivers/fastboot/fb_nand.c    | 1 -
 5 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_command.c
index 01443c5d39e2..e4484d65aca5 100644
--- a/drivers/fastboot/fb_command.c
+++ b/drivers/fastboot/fb_command.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2016 The Android Open Source Project
  */
 
-#include <common.h>
 #include <command.h>
 #include <console.h>
 #include <env.h>
@@ -13,6 +12,7 @@
 #include <fb_nand.h>
 #include <part.h>
 #include <stdlib.h>
+#include <vsprintf.h>
 #include <linux/printk.h>
 
 /**
diff --git a/drivers/fastboot/fb_common.c b/drivers/fastboot/fb_common.c
index 3576b0677299..12ffb463deb9 100644
--- a/drivers/fastboot/fb_common.c
+++ b/drivers/fastboot/fb_common.c
@@ -11,11 +11,11 @@
  */
 
 #include <bcb.h>
-#include <common.h>
 #include <command.h>
 #include <env.h>
 #include <fastboot.h>
 #include <net.h>
+#include <vsprintf.h>
 
 /**
  * fastboot_buf_addr - base address of the fastboot download buffer
diff --git a/drivers/fastboot/fb_getvar.c b/drivers/fastboot/fb_getvar.c
index f65519c57b47..93cbd598e024 100644
--- a/drivers/fastboot/fb_getvar.c
+++ b/drivers/fastboot/fb_getvar.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2016 The Android Open Source Project
  */
 
-#include <common.h>
 #include <env.h>
 #include <fastboot.h>
 #include <fastboot-internal.h>
@@ -12,6 +11,7 @@
 #include <fs.h>
 #include <part.h>
 #include <version.h>
+#include <vsprintf.h>
 #include <linux/printk.h>
 
 static void getvar_version(char *var_parameter, char *response);
diff --git a/drivers/fastboot/fb_mmc.c b/drivers/fastboot/fb_mmc.c
index 060918e49109..f11eb66761b1 100644
--- a/drivers/fastboot/fb_mmc.c
+++ b/drivers/fastboot/fb_mmc.c
@@ -4,7 +4,6 @@
  */
 
 #include <config.h>
-#include <common.h>
 #include <blk.h>
 #include <env.h>
 #include <fastboot.h>
diff --git a/drivers/fastboot/fb_nand.c b/drivers/fastboot/fb_nand.c
index bbe26ddcc9be..afc64fd52807 100644
--- a/drivers/fastboot/fb_nand.c
+++ b/drivers/fastboot/fb_nand.c
@@ -5,7 +5,6 @@
  */
 
 #include <config.h>
-#include <common.h>
 #include <blk.h>
 
 #include <fastboot.h>
-- 
2.34.1

