Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9467CC4345F
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 13:39:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1818288A47;
	Tue, 30 Apr 2024 15:36:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qVala8RH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6138B88A4D; Tue, 30 Apr 2024 15:36:28 +0200 (CEST)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AED488A35
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 15:36:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-78edc49861aso418957085a.3
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 06:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714484185; x=1715088985; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TO+YYw6ihuJ81I4S89lAeEsP3JKkrswmMWKTwLZMMeY=;
 b=qVala8RH5ELBinL23Tj5nNDWBenIma6z479XxIoOA9ZGDk3gU5nRUpn6J5VAlG3q0Q
 5ewACRKHZGdbY1cmXiC/nQgwos3uaNR3J2FaagdxPTEgsirrz6OhVFDBKmLxCbMTzYtd
 I0TXY1uyhr6Q2//UldiK+xSipVmjhKp/zOUk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714484185; x=1715088985;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TO+YYw6ihuJ81I4S89lAeEsP3JKkrswmMWKTwLZMMeY=;
 b=TqkVNOHwR5H19ElufxLEKkSaIqMBk4Za5O31HEepj8NeVJBnoviRAAmZGXJ2uQ0SKg
 29kr0nmuV7SrKo+LIueCZ5NIjpaN+IUCFrUiReyL3Z1/uw5MihlmKVgGn7l897MBpQpC
 CnDR390JgKyaSbday1kIXmxKloU5j1mjUfNM/X0V1fmdattPmbuUFd5t/Kle70iPFJOu
 ZMyONBqKQuo/hB00SbLQrxrbD4QfICorc2G3I4Q9TzrwmDtDw5Q/xIveUlHQkr6v5Q6q
 Rw0VqcPqF75IKU4B3cYGhB+TEtQHSaEEx+jT8rxUBua+bC+HmNrF6+hWXrnBF9WfhIUg
 KxGg==
X-Gm-Message-State: AOJu0Yyw/xdCtb/Bq+ughoTxGZZ4DtoZiP09agBxzAR1PNmExJOgu5lD
 J25VPZ+j4UltKNF1aH9vf4SPGpyTdgQm+iJo8ETEA/oANNdwFLIR91MfiUDxLgXjC6AxzZal2PJ
 OyMu7FA==
X-Google-Smtp-Source: AGHT+IEalqji/JnEP/IavLy5Kc19T2gQ2ACJ1rWWf9LAKJdGmvrNKdGblYpiCPLFMJXEEjETcgFZ6Q==
X-Received: by 2002:a05:6214:2a8f:b0:6a0:b905:97b1 with SMTP id
 jr15-20020a0562142a8f00b006a0b90597b1mr10265145qvb.51.1714484185041; 
 Tue, 30 Apr 2024 06:36:25 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 f12-20020a05621400cc00b006a0d0d792cesm1743877qvs.83.2024.04.30.06.36.24
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 06:36:24 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 21/33] arm: lpc32xx: Remove <common.h> and add needed includes
Date: Tue, 30 Apr 2024 07:35:47 -0600
Message-Id: <20240430133559.1836389-21-trini@konsulko.com>
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

Remove <common.h> from all mach-lpc32xx files and when needed add
missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/arm/mach-lpc32xx/clk.c     | 1 -
 arch/arm/mach-lpc32xx/cpu.c     | 1 -
 arch/arm/mach-lpc32xx/devices.c | 2 +-
 arch/arm/mach-lpc32xx/dram.c    | 1 -
 arch/arm/mach-lpc32xx/timer.c   | 1 -
 5 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/clk.c b/arch/arm/mach-lpc32xx/clk.c
index cb2344d79fec..2e11903e7e07 100644
--- a/arch/arm/mach-lpc32xx/clk.c
+++ b/arch/arm/mach-lpc32xx/clk.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2011 by Vladimir Zapolskiy <vz@mleia.com>
  */
 
-#include <common.h>
 #include <clock_legacy.h>
 #include <div64.h>
 #include <asm/arch/cpu.h>
diff --git a/arch/arm/mach-lpc32xx/cpu.c b/arch/arm/mach-lpc32xx/cpu.c
index a97f9a1958ab..80f5e7c88eb4 100644
--- a/arch/arm/mach-lpc32xx/cpu.c
+++ b/arch/arm/mach-lpc32xx/cpu.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2011-2015 by Vladimir Zapolskiy <vz@mleia.com>
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <init.h>
 #include <net.h>
diff --git a/arch/arm/mach-lpc32xx/devices.c b/arch/arm/mach-lpc32xx/devices.c
index 6a67a3591aa6..49308d6d4be0 100644
--- a/arch/arm/mach-lpc32xx/devices.c
+++ b/arch/arm/mach-lpc32xx/devices.c
@@ -3,7 +3,7 @@
  * Copyright (C) 2011 by Vladimir Zapolskiy <vz@mleia.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <dm.h>
 #include <ns16550.h>
 
diff --git a/arch/arm/mach-lpc32xx/dram.c b/arch/arm/mach-lpc32xx/dram.c
index 160223792353..ab7c13512a5a 100644
--- a/arch/arm/mach-lpc32xx/dram.c
+++ b/arch/arm/mach-lpc32xx/dram.c
@@ -10,7 +10,6 @@
  * This code runs from SRAM.
  */
 
-#include <common.h>
 #include <netdev.h>
 #include <asm/arch/cpu.h>
 #include <asm/arch/clk.h>
diff --git a/arch/arm/mach-lpc32xx/timer.c b/arch/arm/mach-lpc32xx/timer.c
index 90183e3014eb..523f9cfc8c48 100644
--- a/arch/arm/mach-lpc32xx/timer.c
+++ b/arch/arm/mach-lpc32xx/timer.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2011 Vladimir Zapolskiy <vz@mleia.com>
  */
 
-#include <common.h>
 #include <init.h>
 #include <time.h>
 #include <asm/arch/cpu.h>
-- 
2.34.1

