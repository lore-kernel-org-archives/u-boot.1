Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0358C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 23:58:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C82398831B;
	Thu,  2 May 2024 01:58:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CRLIU0or";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0DAB88B83; Thu,  2 May 2024 01:58:56 +0200 (CEST)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80688882CB
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 01:58:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-792639cf4faso143226085a.1
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 16:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714607933; x=1715212733; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YR8BqLO1oJqVMSNh50NCctprernriU5BtFf9o358WqE=;
 b=CRLIU0orYUAvygEfx1xVclSwsUxBwwaYO6RotGHKtLKjIzZhdDIFjKWPvxMTQncxU1
 stuvdAe6UpEEh+yK0KTpa6MXqECV3sNcMkxn0UWeDkm7Rck7NpGheUsw9s5Q+zx/Zwim
 p0RJ7KzbYeHAw5RK87FHeMknfU2B1KPHhwp9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714607933; x=1715212733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YR8BqLO1oJqVMSNh50NCctprernriU5BtFf9o358WqE=;
 b=boLIZlFVK1FUymNCABettd+/kB/J8CDIGMKd9zmTGdx19SVuKt3WKpSC24Ga/qSKP0
 tDpZ7sZCCCyiAH9YK3BJ8CxD24zgJIDzKWfwNThIenM4n9U2f5mITLSRQiWgOvtqhSIe
 7tp2OahlZRZip61giv+oN3PlHGUWMgDLrwpDXLTuFZU8D82QPZXTipYY2oefDB+V/5QR
 qgAivWlEmPULKJwH6LsX2tG7ycDk0kSOyfT0sFFW2ZfMY+FP5ksQ4Gmk29mfoqZm7Szh
 9BSZ85ZUP5Dx9VW0XEEcbEfql14sqGqHjiWGkfJIT8bJu45yhtShnk7PU+T/S50Apmr5
 DZXQ==
X-Gm-Message-State: AOJu0Yy5KatX/7UOCieipfVlzrC6BA0TmIZqLZNeciyaGpvkoZLmtFm/
 pTY+G2vmlHmL/VZUSnIU4ZJj3qOTRFUAWCTsCSeqH/h5XdOIXHyVJ8Ry98A4vcQmR+VD1edi+mu
 e0P+5I+2P
X-Google-Smtp-Source: AGHT+IGoelbWEJ9Dnz9zVfYU6Q2cxIDJYrcHnMv0qDA1eAdBwSEPDAhnlSkaN0BMjeJR7hMFEB+G9g==
X-Received: by 2002:a05:6214:2683:b0:6a0:83a5:deaf with SMTP id
 gm3-20020a056214268300b006a083a5deafmr4957259qvb.29.1714607932710; 
 Wed, 01 May 2024 16:58:52 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 k10-20020ad4420a000000b0069b69c5f077sm189785qvp.102.2024.05.01.16.58.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 16:58:52 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: "Huan 'Kitty' Wang" <HuanWang@gehealthcare.com>,
 Ian Ray <ian.ray@gehealthcare.com>,
 Martyn Welch <martyn.welch@collabora.com>
Subject: [PATCHv2 066/149] board: ge: Remove <common.h> and add needed includes
Date: Wed,  1 May 2024 17:58:49 -0600
Message-Id: <20240501235849.2224082-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501024316.1767971-66-trini@konsulko.com>
References: <20240501024316.1767971-66-trini@konsulko.com>
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
Changes in v2:
- Remove "common.h" include as well.

Cc: "Huan 'Kitty' Wang" <HuanWang@gehealthcare.com>
Cc: Ian Ray <ian.ray@gehealthcare.com>
Cc: Martyn Welch <martyn.welch@collabora.com>

 board/ge/b1x5v2/b1x5v2.c         | 1 -
 board/ge/common/ge_rtc.c         | 1 -
 board/ge/common/vpd_reader.h     | 2 +-
 board/ge/mx53ppd/mx53ppd.c       | 1 -
 board/ge/mx53ppd/mx53ppd_video.c | 1 -
 5 files changed, 1 insertion(+), 5 deletions(-)

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
diff --git a/board/ge/common/vpd_reader.h b/board/ge/common/vpd_reader.h
index 0c51dc57e902..d32c18da351c 100644
--- a/board/ge/common/vpd_reader.h
+++ b/board/ge/common/vpd_reader.h
@@ -3,7 +3,7 @@
  * Copyright 2016 General Electric Company
  */
 
-#include "common.h"
+#include <linux/types.h>
 
 struct vpd_cache;
 
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

