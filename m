Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE13BC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:59:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B112588BD8;
	Wed,  1 May 2024 04:44:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dT23xtFV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3C0088BB8; Wed,  1 May 2024 04:44:56 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C636D88BD5
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:44:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6a0badb6892so15247666d6.1
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531493; x=1715136293; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j+L09nF2R/CbbTOf9Wvac8aa3j/p83TSmysC380RT/E=;
 b=dT23xtFVBNKUsPPr7S91tkYRxFbzbxvJVae5mkv5ZxVtc31OVY0BjwkAcQ4ms2WX/Y
 n5wKBqVxeTYOJ6u6GkgiL6HxBiY6E46GYLVXkaBSptjymsd8M5jK5Psi3tR/CzPdSOvl
 d+Wb8PQuFpU3b6x/h8aW+oHRnDd6csLBK+Ghs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531493; x=1715136293;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j+L09nF2R/CbbTOf9Wvac8aa3j/p83TSmysC380RT/E=;
 b=uVTy1sfTGEa3FkZ9izakVk3IkWVMd0DaiGpbcwTnzDThhlE8IjnfOs5zY9mWVSnp9g
 TDYkDr5W/GHxBwudOziR7vawb8TFnEgkVjhAiIcZ5R0wK0gZrRoN4VSUnf91neYKHzCq
 ud5kSDmyY7j04fbaqpZfMLXcA7sjUNzJSw5wP+CyJAUZx6aHXCfTnLyC+IWo6kaVJQ+R
 q2CTtbQC2N81ld7fPVgh+S4zGpyOYReq/LT7qJq2hPN1h+cYl/YAKxp269yAz9+/pXDv
 f6/Uz++RcL9OhnUqS4dDVPdWSnokR46kEJfCzeL+tSaMc6MRmip2AwAmDv9UjDCTYs16
 2nTQ==
X-Gm-Message-State: AOJu0YxMs2iPNZaIhKz/PrqgXu+qNK+zVmvVssSxh7G5UQssr5Zpzuji
 zaJf6bpjZ0AYzc8SbKgG5G6XjjuLSsY+rAuvAJ02L9teBdgvxae8UwUVH1CkgwY2XlFRB8jQ9t6
 VrwsBYQ==
X-Google-Smtp-Source: AGHT+IGQg6EARQR6a8FR8E3XOoxbrfJNhW4rA4nucwUsVVJ4sYZx41Bme2V2OsWOHDk62tmU4fibuA==
X-Received: by 2002:a05:6214:518b:b0:6a0:5034:778e with SMTP id
 kl11-20020a056214518b00b006a05034778emr1255760qvb.57.1714531493517; 
 Tue, 30 Apr 2024 19:44:53 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.44.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:44:53 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>
Subject: [PATCH 081/149] board: kosagi: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:42:08 -0600
Message-Id: <20240501024316.1767971-81-trini@konsulko.com>
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
Cc: Marek Vasut <marex@denx.de>
---
 board/kosagi/novena/novena.c     | 1 -
 board/kosagi/novena/novena_spl.c | 2 +-
 board/kosagi/novena/video.c      | 1 -
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/board/kosagi/novena/novena.c b/board/kosagi/novena/novena.c
index f009a8afd48c..3220727f2366 100644
--- a/board/kosagi/novena/novena.c
+++ b/board/kosagi/novena/novena.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2014 Marek Vasut <marex@denx.de>
  */
 
-#include <common.h>
 #include <display_options.h>
 #include <dm.h>
 #include <eeprom.h>
diff --git a/board/kosagi/novena/novena_spl.c b/board/kosagi/novena/novena_spl.c
index 24c0fb22268f..008418b01846 100644
--- a/board/kosagi/novena/novena_spl.c
+++ b/board/kosagi/novena/novena_spl.c
@@ -5,7 +5,7 @@
  * Copyright (C) 2014 Marek Vasut <marex@denx.de>
  */
 
-#include <common.h>
+#include <config.h>
 #include <clock_legacy.h>
 #include <init.h>
 #include <asm/io.h>
diff --git a/board/kosagi/novena/video.c b/board/kosagi/novena/video.c
index a96a877f5f21..be5a737a31dd 100644
--- a/board/kosagi/novena/video.c
+++ b/board/kosagi/novena/video.c
@@ -9,7 +9,6 @@
  * Copyright (C) 2014 Marek Vasut <marex@denx.de>
  */
 
-#include <common.h>
 #include <log.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
-- 
2.34.1

