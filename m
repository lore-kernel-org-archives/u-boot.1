Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61BF7C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:47:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1492D88AE7;
	Wed,  1 May 2024 04:43:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kDz7RY6c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E96888ADA; Wed,  1 May 2024 04:43:50 +0200 (CEST)
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com
 [IPv6:2607:f8b0:4864:20::e29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29DF488A7E
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:43:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vs1-xe29.google.com with SMTP id
 ada2fe7eead31-47c10a4083fso1890576137.3
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531427; x=1715136227; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=G+1Th+rRmvqg1f4k6NopnLDFm8cZLulazMlLh00U5+Y=;
 b=kDz7RY6c2Fy2Sx3lc6QFgpyveyWLnGrrNdIHlmvwWvk/i3/Ws2S9r5B9GdBgqyMM8r
 n9ju9SlmLhPe8syrVuWtIvesdEkXkKoAphxwcPsBC7dvFlKtShqeAZW+8TTj4RdPXp/t
 jDdKpUK8b70T9rFgACbkOd7vFOYPQDdZ6Zsd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531427; x=1715136227;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G+1Th+rRmvqg1f4k6NopnLDFm8cZLulazMlLh00U5+Y=;
 b=dLetiT6WudDiJc3nJoujNKbXiXT5+MYvmJ9/aE3uzFAmp7KJCA4R+BEfqyCRv3w2/w
 OPFIioSO7PWn6jAbdHwblZkygjj9PWt1AFoByX0RomQPumMFYvAZJENj9eYR5n6s6/lL
 kpcYDiIydP5qXFd0rjed7Sljsli/lFHb7VC/MUBsAQG2X+b4d4n8Sq6/rUrnK2fXJT1C
 FDdwft3cuFi+RUFCvdnDXLOuGzbF0IC8GUtXK6BX4JZBQYRNjrT9u3gowkQv+Vq6Si8Z
 JAsuqwzF6TM1Kko3P1jX2LPHHS1Zm2nRbHZXSlqjY2sZRI3OQps1talU1lZZyaCErdv8
 gXIQ==
X-Gm-Message-State: AOJu0Yw3yfRMZEBPu7Mv6QDhdD67HMEdtBkuehjXoZIJpGqbtt2I7oUT
 c+SJ0S7NSceUj3dRBIKT5mWsjmPGBIlJ3u+Grqko3rAnLcs8y3n36o/IYeBzftaJpbJ3QMKiZtk
 AY/MSoQ==
X-Google-Smtp-Source: AGHT+IH1wBaWQr8R47+QDWeGjW21lxV+HqdtF8oXaU3MEbyEeiLsCM/KAvqw0MmXpviVikZCPXLuWw==
X-Received: by 2002:a67:e359:0:b0:47c:2a81:a98 with SMTP id
 s25-20020a67e359000000b0047c2a810a98mr1274504vsm.20.1714531426793; 
 Tue, 30 Apr 2024 19:43:46 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.43.45
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:43:46 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 024/149] board: beagle: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:41:11 -0600
Message-Id: <20240501024316.1767971-24-trini@konsulko.com>
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
Cc: Tom Rini <trini@konsulko.com>
---
 board/beagle/beagle/beagle.c | 2 +-
 board/beagle/beagle/led.c    | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/board/beagle/beagle/beagle.c b/board/beagle/beagle/beagle.c
index 847d596646e3..ac2f89cf213a 100644
--- a/board/beagle/beagle/beagle.c
+++ b/board/beagle/beagle/beagle.c
@@ -12,7 +12,7 @@
  *	Syed Mohammed Khasim <khasim@ti.com>
  *
  */
-#include <common.h>
+#include <config.h>
 #include <bootstage.h>
 #include <dm.h>
 #include <env.h>
diff --git a/board/beagle/beagle/led.c b/board/beagle/beagle/led.c
index e21c0169db71..efbd7c1e0e36 100644
--- a/board/beagle/beagle/led.c
+++ b/board/beagle/beagle/led.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2010 Texas Instruments, Inc.
  * Jason Kridner <jkridner@beagleboard.org>
  */
-#include <common.h>
 #include <status_led.h>
 #include <asm/arch/cpu.h>
 #include <asm/io.h>
-- 
2.34.1

