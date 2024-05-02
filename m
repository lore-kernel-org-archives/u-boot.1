Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB32FC4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:34:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9935C88C17;
	Thu,  2 May 2024 03:32:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JCrhq9EB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D263888C22; Thu,  2 May 2024 03:32:05 +0200 (CEST)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E1E188C03
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:31:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-43a317135a5so12236541cf.0
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613517; x=1715218317; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YLR0+InlPW/PcyiqSWamS73C+Cs76eycB4fFkZzERqg=;
 b=JCrhq9EB/TcEcjZ/YOzW5EWxMP207a5KAa+2HewkmvgclaSKIJORI8EaLawJ2MVEr5
 qCmIfeAM9C7ixjEzUJMne2wGrJNy1ZBL93SEq/km8RAC0t1Z0Pex1Iurcp4oBN4/pYDX
 ahW9dUUhD+3wt7+L1BlOq8WPWWjyHVdUilL9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613517; x=1715218317;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YLR0+InlPW/PcyiqSWamS73C+Cs76eycB4fFkZzERqg=;
 b=v6PqI7KyIOq5YOLWR6EjqZ3Yjm3HD+axrZpmWY5RUanjEXRfsaFSYNhEpqQw+oXn4S
 MlQYQTPL3mNrPEIl54QKG/EUEQS7GTMUJ8tsHpbDS7wosPmmdf40SD2t3pkVCI4LHp9R
 eH4Dh8jyKk3hYdUVc2Mji0nT1kHSBDnj2miTjnU+v6nwYQpLl31zfjXLW85KHdLsmzIi
 RUPR7JvpwNpOMx7q/mDyNanbZIg6u0c10AaPUHZ51CZWsZrwntwR0uGIUEExtBRdwqJK
 yGmODtu+hF2PyvzTNXFJOxdGoc7d9+GKXNlLK7/UdolvTM/8jMlNr6dZS3nVwSLJFPjG
 E4Mg==
X-Gm-Message-State: AOJu0Yx6VsAl3+hUwlxC2kMRXcjYkt4Fe1I7H9JocssU0xdhvno/9pZ9
 HGhL6M+hAuBgVvpNONDecsljHoD4S/SGOJxxGnla+SZut0OCZ5lU3xSv1szuXEVq2Qv5GVxn0lf
 aGemOvlYM
X-Google-Smtp-Source: AGHT+IE99DgVbXXY6noeTj2VaE5wkkKxHNpSdEevWt1Iq1DrWt0tfT6g8wwkhxFEzKK1WXEcATR5PA==
X-Received: by 2002:a05:622a:1a1e:b0:43a:fa49:8096 with SMTP id
 f30-20020a05622a1a1e00b0043afa498096mr2675735qtb.8.1714613516826; 
 Wed, 01 May 2024 18:31:56 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.31.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:31:56 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 13/81] bios_emulator: Remove <common.h> and add needed includes
Date: Wed,  1 May 2024 19:30:30 -0600
Message-Id: <20240502013138.2383421-13-trini@konsulko.com>
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
Cc: Bin Meng <bmeng.cn@gmail.com>
---
 drivers/bios_emulator/atibios.c         | 1 -
 drivers/bios_emulator/besys.c           | 1 -
 drivers/bios_emulator/bios.c            | 1 -
 drivers/bios_emulator/biosemu.c         | 1 -
 drivers/bios_emulator/x86emu/debug.c    | 1 -
 drivers/bios_emulator/x86emu/decode.c   | 1 -
 drivers/bios_emulator/x86emu/ops.c      | 1 -
 drivers/bios_emulator/x86emu/ops2.c     | 1 -
 drivers/bios_emulator/x86emu/prim_ops.c | 1 -
 drivers/bios_emulator/x86emu/sys.c      | 1 -
 10 files changed, 10 deletions(-)

diff --git a/drivers/bios_emulator/atibios.c b/drivers/bios_emulator/atibios.c
index 7ebead6bfad6..d544ffb5ffb6 100644
--- a/drivers/bios_emulator/atibios.c
+++ b/drivers/bios_emulator/atibios.c
@@ -45,7 +45,6 @@
 *		Jason ported this file to u-boot to run the ATI video card
 *		BIOS in u-boot.
 ****************************************************************************/
-#include <common.h>
 #include <compiler.h>
 #include <bios_emul.h>
 #include <errno.h>
diff --git a/drivers/bios_emulator/besys.c b/drivers/bios_emulator/besys.c
index 02c4286a854c..690fb5a4d7b3 100644
--- a/drivers/bios_emulator/besys.c
+++ b/drivers/bios_emulator/besys.c
@@ -48,7 +48,6 @@
 ****************************************************************************/
 
 #define __io
-#include <common.h>
 #include <asm/io.h>
 #include "biosemui.h"
 
diff --git a/drivers/bios_emulator/bios.c b/drivers/bios_emulator/bios.c
index 9596a1fdd3e0..7f883daf8f06 100644
--- a/drivers/bios_emulator/bios.c
+++ b/drivers/bios_emulator/bios.c
@@ -42,7 +42,6 @@
 ****************************************************************************/
 
 #define __io
-#include <common.h>
 #include <asm/io.h>
 #include "biosemui.h"
 
diff --git a/drivers/bios_emulator/biosemu.c b/drivers/bios_emulator/biosemu.c
index 82befbae66f7..ba4328474ce2 100644
--- a/drivers/bios_emulator/biosemu.c
+++ b/drivers/bios_emulator/biosemu.c
@@ -46,7 +46,6 @@
 ****************************************************************************/
 
 #include <malloc.h>
-#include <common.h>
 #include "biosemui.h"
 
 BE_sysEnv _BE_env = {{0}};
diff --git a/drivers/bios_emulator/x86emu/debug.c b/drivers/bios_emulator/x86emu/debug.c
index 95f3cc09aad5..b426dc3bc45e 100644
--- a/drivers/bios_emulator/x86emu/debug.c
+++ b/drivers/bios_emulator/x86emu/debug.c
@@ -38,7 +38,6 @@
 ****************************************************************************/
 
 #include <stdarg.h>
-#include <common.h>
 #include <linux/ctype.h>
 #include <linux/printk.h>
 #include "x86emu/x86emui.h"
diff --git a/drivers/bios_emulator/x86emu/decode.c b/drivers/bios_emulator/x86emu/decode.c
index e2028eaf0833..7e188d58a52c 100644
--- a/drivers/bios_emulator/x86emu/decode.c
+++ b/drivers/bios_emulator/x86emu/decode.c
@@ -36,7 +36,6 @@
 *		instruction decoding and accessess of immediate data via IP.  etc.
 *
 ****************************************************************************/
-#include <common.h>
 #include <linux/printk.h>
 #include "x86emu/x86emui.h"
 
diff --git a/drivers/bios_emulator/x86emu/ops.c b/drivers/bios_emulator/x86emu/ops.c
index 8c1a146165c9..57422ec3d473 100644
--- a/drivers/bios_emulator/x86emu/ops.c
+++ b/drivers/bios_emulator/x86emu/ops.c
@@ -72,7 +72,6 @@
 *
 ****************************************************************************/
 
-#include <common.h>
 #include <linux/printk.h>
 #include "x86emu/x86emui.h"
 
diff --git a/drivers/bios_emulator/x86emu/ops2.c b/drivers/bios_emulator/x86emu/ops2.c
index 6cd1ac398252..32fecb347913 100644
--- a/drivers/bios_emulator/x86emu/ops2.c
+++ b/drivers/bios_emulator/x86emu/ops2.c
@@ -41,7 +41,6 @@
 *
 ****************************************************************************/
 
-#include <common.h>
 #include <linux/compiler.h>
 #include <linux/printk.h>
 #include "x86emu/x86emui.h"
diff --git a/drivers/bios_emulator/x86emu/prim_ops.c b/drivers/bios_emulator/x86emu/prim_ops.c
index 5f6c795fb7ff..b3cccb17f202 100644
--- a/drivers/bios_emulator/x86emu/prim_ops.c
+++ b/drivers/bios_emulator/x86emu/prim_ops.c
@@ -97,7 +97,6 @@
 *
 ****************************************************************************/
 
-#include <common.h>
 
 #define PRIM_OPS_NO_REDEFINE_ASM
 #include "x86emu/x86emui.h"
diff --git a/drivers/bios_emulator/x86emu/sys.c b/drivers/bios_emulator/x86emu/sys.c
index f96652415cd3..483ecd52efe3 100644
--- a/drivers/bios_emulator/x86emu/sys.c
+++ b/drivers/bios_emulator/x86emu/sys.c
@@ -39,7 +39,6 @@
 *
 ****************************************************************************/
 
-#include <common.h>
 #include <linux/printk.h>
 #include "x86emu/x86emui.h"
 
-- 
2.34.1

