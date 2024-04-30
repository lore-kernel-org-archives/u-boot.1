Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE3E1C4345F
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 13:41:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8756F88A8C;
	Tue, 30 Apr 2024 15:36:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WBbFH79g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E165889A2; Tue, 30 Apr 2024 15:36:36 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC85D88A57
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 15:36:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6a04c581ee3so21136666d6.0
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 06:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714484191; x=1715088991; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FSl1rRu2qgmKDEnlQ1iuAOoBmtc49WWuDd3G3eZoXlw=;
 b=WBbFH79gZoC/PEkr0JYYKmgn2a5HuiJ9PT4Xrlo8eJxw/FaSUa5DDZKQdL3lSfBWmC
 LxZudow/vJ7dZCEG7+64yI32FeHEDpdtpltk3RArBB7M+GXvA1tmkygRcdOo8GY18Fx6
 hVGQ0BphK9Rdma/tLHL3cY0KHrxc/cScO0lX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714484191; x=1715088991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FSl1rRu2qgmKDEnlQ1iuAOoBmtc49WWuDd3G3eZoXlw=;
 b=YJuGnIpB78jttbQZgRscl2racYxxvtbhVVmUtSI1bwOC8RTzwovK+PhIfas2M3Szmx
 C3ZWUq43wH1I3k7tephehYERBkEgMaPu2zS3kpeJze2gyEWPdyQFIhBuA8IJAhJXhdCX
 4jgp/lpEaCfvnf0cfdQDAdVUMfsFH1lpZHpnPo9VX+ycB8pymVcoHNdVdotby0vLxA61
 wzHB9B1pWRc5dHLGEOCH1qyEJXEQksrAffmwsiCdB8uIUnbvAp0cAdxSYNmrIQnb+iTq
 qt8fQB0W6nvg7xGXW4YdWl4n4y6W9LlCg6XIVhGZU8UuvI78jKqlC6ftUQsu0ZkmcUDg
 x1xg==
X-Gm-Message-State: AOJu0YzxBdXGCsTBrbpRbggYm1WJlUwBUTlXnHuEW9Deqwo9kkLjPcXH
 Jh0p4T8JVa48xBpkJmpkaUrjQzSQeK7IGRhU9O6VLk1XGB4QgH2DDyTkLzS6z9YQLc002MgceeN
 WDtDg0A==
X-Google-Smtp-Source: AGHT+IFgXyUektPK3YDYpyVJgPRBgI1nENfw6OW/8mwcqYMJEtzKGp47aLmBXqSQD/GIb8h4CdOgDQ==
X-Received: by 2002:a05:6214:3012:b0:6a0:590e:d616 with SMTP id
 ke18-20020a056214301200b006a0590ed616mr2720672qvb.29.1714484190963; 
 Tue, 30 Apr 2024 06:36:30 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 f12-20020a05621400cc00b006a0d0d792cesm1743877qvs.83.2024.04.30.06.36.30
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 06:36:30 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 27/33] arm: davinci: Remove <common.h> and add needed includes
Date: Tue, 30 Apr 2024 07:35:53 -0600
Message-Id: <20240430133559.1836389-27-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430133559.1836389-1-trini@konsulko.com>
References: <20240430133559.1836389-1-trini@konsulko.com>
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

Remove <common.h> from all mach-davinci files and when needed add
missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/arm/include/asm/ti-common/davinci_nand.h     | 1 +
 arch/arm/mach-davinci/cpu.c                       | 3 ++-
 arch/arm/mach-davinci/da850_lowlevel.c            | 2 +-
 arch/arm/mach-davinci/da850_pinmux.c              | 1 -
 arch/arm/mach-davinci/include/mach/davinci_misc.h | 1 +
 arch/arm/mach-davinci/misc.c                      | 3 ++-
 arch/arm/mach-davinci/pinmux.c                    | 1 -
 arch/arm/mach-davinci/psc.c                       | 1 -
 arch/arm/mach-davinci/reset.c                     | 1 -
 arch/arm/mach-davinci/spl.c                       | 1 -
 arch/arm/mach-davinci/timer.c                     | 2 +-
 11 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/arm/include/asm/ti-common/davinci_nand.h b/arch/arm/include/asm/ti-common/davinci_nand.h
index 38a1a6ea0d7b..84fe01e3b712 100644
--- a/arch/arm/include/asm/ti-common/davinci_nand.h
+++ b/arch/arm/include/asm/ti-common/davinci_nand.h
@@ -9,6 +9,7 @@
 #ifndef _DAVINCI_NAND_H_
 #define _DAVINCI_NAND_H_
 
+#include <config.h>
 #include <asm/arch/hardware.h>
 
 #define NAND_READ_START		0x00
diff --git a/arch/arm/mach-davinci/cpu.c b/arch/arm/mach-davinci/cpu.c
index dae60262f5b7..033411235391 100644
--- a/arch/arm/mach-davinci/cpu.c
+++ b/arch/arm/mach-davinci/cpu.c
@@ -4,11 +4,12 @@
  * Copyright (C) 2009 David Brownell
  */
 
-#include <common.h>
+#include <config.h>
 #include <clock_legacy.h>
 #include <init.h>
 #include <asm/arch/hardware.h>
 #include <asm/global_data.h>
+#include <asm/u-boot.h>
 #include <asm/io.h>
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/arch/arm/mach-davinci/da850_lowlevel.c b/arch/arm/mach-davinci/da850_lowlevel.c
index 08c8f5925243..936b5e116679 100644
--- a/arch/arm/mach-davinci/da850_lowlevel.c
+++ b/arch/arm/mach-davinci/da850_lowlevel.c
@@ -5,7 +5,7 @@
  * Copyright (C) 2011
  * Heiko Schocher, DENX Software Engineering, hs@denx.de.
  */
-#include <common.h>
+#include <config.h>
 #include <init.h>
 #include <nand.h>
 #include <ns16550.h>
diff --git a/arch/arm/mach-davinci/da850_pinmux.c b/arch/arm/mach-davinci/da850_pinmux.c
index f2536c8dd6d6..4ee3cd0d5b34 100644
--- a/arch/arm/mach-davinci/da850_pinmux.c
+++ b/arch/arm/mach-davinci/da850_pinmux.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2011 OMICRON electronics GmbH
  */
 
-#include <common.h>
 #include <asm/arch/davinci_misc.h>
 #include <asm/arch/hardware.h>
 #include <asm/arch/pinmux_defs.h>
diff --git a/arch/arm/mach-davinci/include/mach/davinci_misc.h b/arch/arm/mach-davinci/include/mach/davinci_misc.h
index 1133a23bdee3..0d0ad1e593e1 100644
--- a/arch/arm/mach-davinci/include/mach/davinci_misc.h
+++ b/arch/arm/mach-davinci/include/mach/davinci_misc.h
@@ -6,6 +6,7 @@
 #ifndef __MISC_H
 #define __MISC_H
 
+#include <linux/types.h>
 #include <asm/arch/hardware.h>
 
 /* pin muxer definitions */
diff --git a/arch/arm/mach-davinci/misc.c b/arch/arm/mach-davinci/misc.c
index cfad28c43d0a..93a144757a9e 100644
--- a/arch/arm/mach-davinci/misc.c
+++ b/arch/arm/mach-davinci/misc.c
@@ -8,7 +8,7 @@
  * Copyright (C) 2004 Texas Instruments.
  */
 
-#include <common.h>
+#include <config.h>
 #include <env.h>
 #include <i2c.h>
 #include <init.h>
@@ -16,6 +16,7 @@
 #include <net.h>
 #include <asm/arch/hardware.h>
 #include <asm/global_data.h>
+#include <asm/u-boot.h>
 #include <asm/io.h>
 #include <asm/arch/davinci_misc.h>
 
diff --git a/arch/arm/mach-davinci/pinmux.c b/arch/arm/mach-davinci/pinmux.c
index 7904257b4a42..5ecb434b03b6 100644
--- a/arch/arm/mach-davinci/pinmux.c
+++ b/arch/arm/mach-davinci/pinmux.c
@@ -8,7 +8,6 @@
  * Copyright (C) 2004 Texas Instruments.
  */
 
-#include <common.h>
 #include <asm/arch/hardware.h>
 #include <asm/io.h>
 #include <asm/arch/davinci_misc.h>
diff --git a/arch/arm/mach-davinci/psc.c b/arch/arm/mach-davinci/psc.c
index dae10aa03bbb..90b817860a62 100644
--- a/arch/arm/mach-davinci/psc.c
+++ b/arch/arm/mach-davinci/psc.c
@@ -7,7 +7,6 @@
  * Copyright (C) 2004 Texas Instruments.
  */
 
-#include <common.h>
 #include <asm/arch/hardware.h>
 #include <asm/io.h>
 
diff --git a/arch/arm/mach-davinci/reset.c b/arch/arm/mach-davinci/reset.c
index 0d59eb6e3cef..e3e2c56a6760 100644
--- a/arch/arm/mach-davinci/reset.c
+++ b/arch/arm/mach-davinci/reset.c
@@ -6,7 +6,6 @@
  * Copyright (C) 2007 Sergey Kubushyn <ksi@koi8.net>
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <asm/io.h>
 #include <asm/arch/timer_defs.h>
diff --git a/arch/arm/mach-davinci/spl.c b/arch/arm/mach-davinci/spl.c
index 5f5b9ebbf97a..4603c8fbc575 100644
--- a/arch/arm/mach-davinci/spl.c
+++ b/arch/arm/mach-davinci/spl.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2011
  * Heiko Schocher, DENX Software Engineering, hs@denx.de.
  */
-#include <common.h>
 #include <config.h>
 #include <hang.h>
 #include <init.h>
diff --git a/arch/arm/mach-davinci/timer.c b/arch/arm/mach-davinci/timer.c
index 83c190b620e7..f2990f718773 100644
--- a/arch/arm/mach-davinci/timer.c
+++ b/arch/arm/mach-davinci/timer.c
@@ -20,7 +20,7 @@
  * Copyright (C) 2007 Sergey Kubushyn <ksi@koi8.net>
  */
 
-#include <common.h>
+#include <config.h>
 #include <init.h>
 #include <time.h>
 #include <asm/global_data.h>
-- 
2.34.1

