Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB49C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:51:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CF0B88B30;
	Wed,  1 May 2024 04:44:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DqAFjiDm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A94088B27; Wed,  1 May 2024 04:44:08 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6737688AD7
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:44:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6a06b12027cso4378456d6.0
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531445; x=1715136245; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=arIWsHGDqUdyy/l7F2QkTx0sxD5caqcPD2y3/r0BqHc=;
 b=DqAFjiDm6yEBXYr8Q+TBOU5PxmBB68L05nHn5PACm+fBpCepWO/MFwELq2JeuDZhL9
 hJiST29A0O0OD7UpyQEA3LCi79viAVMZy0ZDkK24rF7qu831dsQQKFAH+P3/EuDqw2Hv
 IPXsrkKSpiElVYjpjQwRlk+UkHKxjcy9E0Jps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531445; x=1715136245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=arIWsHGDqUdyy/l7F2QkTx0sxD5caqcPD2y3/r0BqHc=;
 b=wopZRj1mBCMiM9kRh96eeaMe0e8gAKOWKeKdii+9BUnbczNkf1+lU5TA/0/89993bt
 LmV20YAAIepMgdIYsiHP+cFnJNzsMdOin0xXBrwY5NPAth09La9TexfHv/kYf4lD1KCn
 xrTxPSLViJw+4dQ/70jN9kCWvT01m4Jl9ZnV0HfrpFEbsxov0uQTvHo3K6cAxYYTVedO
 bYEYllMhzAngqwc4HQIZVOWpf0A2FXKn2OTQxXcl0qabxNyjf+LEqGeWicRMG3pMC6xt
 egbQ2+oGt0KjHWqjgZIKRQLm3txse9yx+jCqvMfA9i7XSyEcqUxoOfM09TiarNmUEi1G
 Xi9w==
X-Gm-Message-State: AOJu0YwtD4/b1oMAyUuCOVOC4IWmfWIakYcJO3We4xhs5KAyaAXVLuiF
 7y35aFFW7bISCQoGuMbU1gpN0EOqX05BsINogiThcE58Vk6q6gw7UW1kN2zbN147CtXCMAw0EjE
 Lmx/b3Q==
X-Google-Smtp-Source: AGHT+IEU0NE7lN86q05PxrG4Uc3w6lfX3CmYA7o3gXf2mplkJ9G4PVFqb/e9m30HoElOE37/O8dZ1Q==
X-Received: by 2002:a05:6214:4116:b0:6a0:919e:5822 with SMTP id
 kc22-20020a056214411600b006a0919e5822mr2920370qvb.28.1714531444990; 
 Tue, 30 Apr 2024 19:44:04 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.44.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:44:04 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Angelo Dureghello <angelo@kernel-space.org>
Subject: [PATCH 040/149] board: cobra5272: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:41:27 -0600
Message-Id: <20240501024316.1767971-40-trini@konsulko.com>
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
Cc: Angelo Dureghello <angelo@kernel-space.org>
---
 board/cobra5272/cobra5272.c | 2 +-
 board/cobra5272/flash.c     | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/board/cobra5272/cobra5272.c b/board/cobra5272/cobra5272.c
index 69a9df942311..774aa82b57fe 100644
--- a/board/cobra5272/cobra5272.c
+++ b/board/cobra5272/cobra5272.c
@@ -4,7 +4,7 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
+#include <config.h>
 #include <init.h>
 #include <asm/global_data.h>
 #include <asm/immap.h>
diff --git a/board/cobra5272/flash.c b/board/cobra5272/flash.c
index 8416af163ad1..157b71da85e8 100644
--- a/board/cobra5272/flash.c
+++ b/board/cobra5272/flash.c
@@ -4,13 +4,17 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
+#include <config.h>
 #include <console.h>
 #include <cpu_func.h>
 #include <flash.h>
 #include <irq_func.h>
+#include <stdio.h>
+#include <time.h>
 #include <uuid.h>
+#include <vsprintf.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #define PHYS_FLASH_1 CFG_SYS_FLASH_BASE
 #define FLASH_BANK_SIZE 0x200000
-- 
2.34.1

