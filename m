Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72724C4345F
	for <u-boot@archiver.kernel.org>; Sat, 27 Apr 2024 14:12:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C85C68841F;
	Sat, 27 Apr 2024 16:11:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AsDoi2A8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78CD9884F1; Sat, 27 Apr 2024 16:11:23 +0200 (CEST)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF8C988438
 for <u-boot@lists.denx.de>; Sat, 27 Apr 2024 16:11:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-790e7c02430so8700885a.0
 for <u-boot@lists.denx.de>; Sat, 27 Apr 2024 07:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714227079; x=1714831879; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VLAMUD5zoXeFaDzYh2ueliBE35z1abgLZ60p7OLpNpE=;
 b=AsDoi2A8uP54sj3Kb010uMs41fIs6Uv4zzZBQNH4LUDB6hPC60JDqwRHDJmyk6rsLn
 ciIVo7gQyniOMiMt8Rcre2AXDm0kbavhwUWM+oNsUCcYzv2OEXsGTfkxe21KR4JRIDAv
 D24YbrPCC2TZvr28Bc4THHK57TthxsM638DRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714227079; x=1714831879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VLAMUD5zoXeFaDzYh2ueliBE35z1abgLZ60p7OLpNpE=;
 b=AP8lQH5Qaj3qQbYpFvmorQxWm5U3JmXg9Ffpuhalp/83qqhVTqVk8k4SokuU89ZNl9
 rFewgiZMUfkR/74gxXZneT3dDjo3+N8f8pVys9SULPTX022VKH8eDTn6ced7jQSjbMBG
 0EZJDMGU+6tbxCn7ySsBv7zAPzEvHh0hPDDI9Udvr86TEG+9QPsCjawynhA6Ngibgl0Q
 oACq/V3o16msPOpw5GCwqrhAWDHkOjlB9BnG2B8SSoz3N0DfJvkfmnOQal81O/GRFAsc
 sW69e3KJI+TkN4DjYY9YkuyDa+JlTlLhX1fNmFpd5RAaEERAg5DjqImADPu9Z5FIj17y
 H28g==
X-Gm-Message-State: AOJu0Yx0m2brHhCnnvJtlpVbbtTsX6n3wWWvsz3DoDwv/DNd+EWAK4FN
 gR1iFL7r7B0M+64geJoKAEK+8oeQXhq8POX6iOvUS0dULA/Tih38MwDNUt0BZtdfEJGxqyGqXDh
 2Qa2LgA==
X-Google-Smtp-Source: AGHT+IEGNDGi2K0qmz6swhogb1lM5WBZM5Wic6wdxUoTONraYPdBHSpN9yX+XHU1dH/mYVX1uXOqSw==
X-Received: by 2002:ae9:e10b:0:b0:790:c79d:c604 with SMTP id
 g11-20020ae9e10b000000b00790c79dc604mr1176599qkm.42.1714227079193; 
 Sat, 27 Apr 2024 07:11:19 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a05620a112300b0078ed3667cb8sm8829760qkk.124.2024.04.27.07.11.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Apr 2024 07:11:18 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 07/18] sh: Remove <common.h> and add needed includes
Date: Sat, 27 Apr 2024 08:10:55 -0600
Message-Id: <20240427141106.3406000-8-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240427141106.3406000-1-trini@konsulko.com>
References: <20240427141106.3406000-1-trini@konsulko.com>
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

Remove <common.h> from all sh architecture files and when needed add
missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 arch/sh/cpu/sh4/cache.c      | 1 -
 arch/sh/cpu/sh4/cpu.c        | 1 -
 arch/sh/cpu/sh4/interrupts.c | 1 -
 arch/sh/cpu/sh4/watchdog.c   | 1 -
 arch/sh/lib/board.c          | 2 +-
 arch/sh/lib/bootm.c          | 2 +-
 arch/sh/lib/time.c           | 1 -
 arch/sh/lib/time_sh2.c       | 1 -
 arch/sh/lib/zimageboot.c     | 2 +-
 9 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/sh/cpu/sh4/cache.c b/arch/sh/cpu/sh4/cache.c
index 0f7dfdd3cf79..8c1839935ca1 100644
--- a/arch/sh/cpu/sh4/cache.c
+++ b/arch/sh/cpu/sh4/cache.c
@@ -4,7 +4,6 @@
  * (C) Copyright 2007 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
  */
 
-#include <common.h>
 #include <command.h>
 #include <cpu_func.h>
 #include <asm/cache.h>
diff --git a/arch/sh/cpu/sh4/cpu.c b/arch/sh/cpu/sh4/cpu.c
index 1b2f50dbe6e4..b0ad685a91b1 100644
--- a/arch/sh/cpu/sh4/cpu.c
+++ b/arch/sh/cpu/sh4/cpu.c
@@ -4,7 +4,6 @@
  * Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
  */
 
-#include <common.h>
 #include <command.h>
 #include <irq_func.h>
 #include <cpu_func.h>
diff --git a/arch/sh/cpu/sh4/interrupts.c b/arch/sh/cpu/sh4/interrupts.c
index 278a3e32ac91..eace09aeabfa 100644
--- a/arch/sh/cpu/sh4/interrupts.c
+++ b/arch/sh/cpu/sh4/interrupts.c
@@ -4,7 +4,6 @@
  * Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
  */
 
-#include <common.h>
 #include <irq_func.h>
 
 int interrupt_init(void)
diff --git a/arch/sh/cpu/sh4/watchdog.c b/arch/sh/cpu/sh4/watchdog.c
index bf403d3c520e..c59743374657 100644
--- a/arch/sh/cpu/sh4/watchdog.c
+++ b/arch/sh/cpu/sh4/watchdog.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
 
-#include <common.h>
 #include <cpu_func.h>
 #include <asm/processor.h>
 #include <asm/system.h>
diff --git a/arch/sh/lib/board.c b/arch/sh/lib/board.c
index b31fa6d70311..53b1c147c2e3 100644
--- a/arch/sh/lib/board.c
+++ b/arch/sh/lib/board.c
@@ -3,7 +3,7 @@
  * Copyright (C) 2016 Vladimir Zapolskiy <vz@mleia.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <init.h>
 #include <asm/global_data.h>
 
diff --git a/arch/sh/lib/bootm.c b/arch/sh/lib/bootm.c
index 05d586b1b6ce..e298d766b52d 100644
--- a/arch/sh/lib/bootm.c
+++ b/arch/sh/lib/bootm.c
@@ -7,7 +7,7 @@
  * (c) Copyright 2008 Renesas Solutions Corp.
  */
 
-#include <common.h>
+#include <config.h>
 #include <bootm.h>
 #include <command.h>
 #include <env.h>
diff --git a/arch/sh/lib/time.c b/arch/sh/lib/time.c
index 19c8e3ca3e7b..5feb19835561 100644
--- a/arch/sh/lib/time.c
+++ b/arch/sh/lib/time.c
@@ -10,7 +10,6 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
 #include <init.h>
 #include <asm/processor.h>
 #include <asm/io.h>
diff --git a/arch/sh/lib/time_sh2.c b/arch/sh/lib/time_sh2.c
index 5484c543c6c8..0ee7dc756ba6 100644
--- a/arch/sh/lib/time_sh2.c
+++ b/arch/sh/lib/time_sh2.c
@@ -7,7 +7,6 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
 #include <init.h>
 #include <time.h>
 #include <asm/io.h>
diff --git a/arch/sh/lib/zimageboot.c b/arch/sh/lib/zimageboot.c
index c2e285ff0f62..e731c6a7cb36 100644
--- a/arch/sh/lib/zimageboot.c
+++ b/arch/sh/lib/zimageboot.c
@@ -9,10 +9,10 @@
  * Linux SuperH zImage loading and boot
  */
 
-#include <common.h>
 #include <command.h>
 #include <env.h>
 #include <irq_func.h>
+#include <vsprintf.h>
 #include <asm/io.h>
 #include <asm/zimage.h>
 
-- 
2.34.1

