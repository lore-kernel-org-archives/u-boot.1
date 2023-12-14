Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D643C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 18:17:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB2EB87B5D;
	Thu, 14 Dec 2023 19:17:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CcxzBpFf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F9F487B65; Thu, 14 Dec 2023 19:17:06 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A47AD87B5D
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 19:17:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5e309941f46so17319837b3.3
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 10:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702577822; x=1703182622; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/JTZ9q/74XhlMa1amzsJ2WlEJL9UrPuHmMzHvhjBDf0=;
 b=CcxzBpFfO5ZbOgBv4wJAez/66mHislAGlqIzyRlTPBkoVfpaiCgdWc5hfpUGw7T173
 2FrN1mH+OmELhLbYhOSKKtvTd4Gee2sqxmZdqS0PEX8ARuyZJvjyoO0al2wBBMr8uTBF
 fr4CECGGF8hCiHSt7oZoeVS5Mv2vqFW8QDi2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702577822; x=1703182622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/JTZ9q/74XhlMa1amzsJ2WlEJL9UrPuHmMzHvhjBDf0=;
 b=Z+urjKU4Wdx1+/AeXjQU+Kh79qqRrG4SkeC3gUNBJCsXM6oQtXI3frkj2QWidBV5K+
 i+qeC5BbMdbqX5N2EEgv2rv3vDUTZcTLf8hJl1ZYebirmQu40SGV32f/McCZXtF2R+P0
 hJdOKaGUnF4LXbkijNTHVj3q7Soq7jd7Doh9Bl6SBm0ZUFj1gYId37pDogj24paXlIa4
 bpzK0SINU2aOO2FLiWzOvMl6PcQbce8LFxaqkG7Mpeuv6Qt1v3srQH6QE8GHvLot/T34
 WslSseKAICyegGcN2LGcxwf3t55D/1awxDouKd/uba1c2FoLTHPGzp2R9droiS/kTDRD
 B0Vg==
X-Gm-Message-State: AOJu0YyrWEFk+w+/PG7KkUJCmgsumPTOH5Oo7LDy1WCLc0PzXChNBLGH
 I5jiUiUhIHiTVBeuzvFbYcyFXVsh5RXMpcrbS1o=
X-Google-Smtp-Source: AGHT+IGg288eUtTlro9CRv0HpHsodx0fmDPVct04LHBY9hf7zvSqEnYz462OzyQWl9A6AmPQh81Xbg==
X-Received: by 2002:a0d:e446:0:b0:5d7:1940:53ce with SMTP id
 n67-20020a0de446000000b005d7194053cemr8064086ywe.70.1702577822002; 
 Thu, 14 Dec 2023 10:17:02 -0800 (PST)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-ef43-b142-0a3d-20b7.res6.spectrum.com.
 [2603:6081:7b00:6400:ef43:b142:a3d:20b7])
 by smtp.gmail.com with ESMTPSA id
 s129-20020a0dd087000000b005d361dd6454sm5665698ywd.87.2023.12.14.10.17.01
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 10:17:01 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [v2 04/16] sandbox: Audit config.h and common.h usage
Date: Thu, 14 Dec 2023 13:16:46 -0500
Message-Id: <20231214181658.3359902-4-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214181658.3359902-1-trini@konsulko.com>
References: <20231214181658.3359902-1-trini@konsulko.com>
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

Remove and replace common.h and config.h in sandbox when it's not needed
and add some explicit includes where needed.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v2:
- Drop <autoboot.h> from arch/sandbox/cpu/state.c as it's also not
  needed and leads to unrelated build failures with CMDLINE=n
---
 arch/sandbox/cpu/cache.c         | 1 -
 arch/sandbox/cpu/cpu.c           | 1 -
 arch/sandbox/cpu/sdl.c           | 2 +-
 arch/sandbox/cpu/spl.c           | 1 -
 arch/sandbox/cpu/start.c         | 2 +-
 arch/sandbox/cpu/state.c         | 3 +--
 arch/sandbox/include/asm/io.h    | 2 ++
 arch/sandbox/include/asm/state.h | 1 -
 arch/sandbox/lib/bootm.c         | 1 -
 arch/sandbox/lib/fdt_fixup.c     | 1 -
 arch/sandbox/lib/interrupts.c    | 1 -
 arch/sandbox/lib/pci_io.c        | 1 -
 board/sandbox/sandbox.c          | 2 +-
 13 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/arch/sandbox/cpu/cache.c b/arch/sandbox/cpu/cache.c
index 46c62c0b4461..c8a5e64214b6 100644
--- a/arch/sandbox/cpu/cache.c
+++ b/arch/sandbox/cpu/cache.c
@@ -3,7 +3,6 @@
  * Copyright 2020, Heinrich Schuchardt <xypron.glpk@gmx.de>
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <asm/state.h>
 
diff --git a/arch/sandbox/cpu/cpu.c b/arch/sandbox/cpu/cpu.c
index a1c5c7c4311a..d6475c969c4d 100644
--- a/arch/sandbox/cpu/cpu.c
+++ b/arch/sandbox/cpu/cpu.c
@@ -5,7 +5,6 @@
 
 #define LOG_CATEGORY	LOGC_SANDBOX
 
-#include <common.h>
 #include <bootstage.h>
 #include <cpu_func.h>
 #include <errno.h>
diff --git a/arch/sandbox/cpu/sdl.c b/arch/sandbox/cpu/sdl.c
index 590e406517bf..ed84646bdab7 100644
--- a/arch/sandbox/cpu/sdl.c
+++ b/arch/sandbox/cpu/sdl.c
@@ -72,7 +72,7 @@ static struct sdl_info {
 static void sandbox_sdl_poll_events(void)
 {
 	/*
-	 * We don't want to include common.h in this file since it uses
+	 * We don't want to include cpu_func.h in this file since it uses
 	 * system headers. So add a declation here.
 	 */
 	extern void reset_cpu(void);
diff --git a/arch/sandbox/cpu/spl.c b/arch/sandbox/cpu/spl.c
index 16b766279833..9ad9da686c6a 100644
--- a/arch/sandbox/cpu/spl.c
+++ b/arch/sandbox/cpu/spl.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2016 Google, Inc
  */
 
-#include <common.h>
 #include <dm.h>
 #include <hang.h>
 #include <handoff.h>
diff --git a/arch/sandbox/cpu/start.c b/arch/sandbox/cpu/start.c
index 2589c2eba738..dce804165296 100644
--- a/arch/sandbox/cpu/start.c
+++ b/arch/sandbox/cpu/start.c
@@ -3,7 +3,7 @@
  * Copyright (c) 2011-2012 The Chromium OS Authors.
  */
 
-#include <common.h>
+#include <config.h>
 #include <cli.h>
 #include <command.h>
 #include <efi_loader.h>
diff --git a/arch/sandbox/cpu/state.c b/arch/sandbox/cpu/state.c
index e38bb248b7ff..a9ca79e76d2d 100644
--- a/arch/sandbox/cpu/state.c
+++ b/arch/sandbox/cpu/state.c
@@ -3,9 +3,8 @@
  * Copyright (c) 2011-2012 The Chromium OS Authors.
  */
 
-#include <common.h>
-#include <autoboot.h>
 #include <bloblist.h>
+#include <config.h>
 #include <errno.h>
 #include <fdtdec.h>
 #include <log.h>
diff --git a/arch/sandbox/include/asm/io.h b/arch/sandbox/include/asm/io.h
index 77a02e5f5241..3c0a102697ec 100644
--- a/arch/sandbox/include/asm/io.h
+++ b/arch/sandbox/include/asm/io.h
@@ -6,6 +6,8 @@
 #ifndef __SANDBOX_ASM_IO_H
 #define __SANDBOX_ASM_IO_H
 
+#include <linux/types.h>
+
 enum sandboxio_size_t {
 	SB_SIZE_8,
 	SB_SIZE_16,
diff --git a/arch/sandbox/include/asm/state.h b/arch/sandbox/include/asm/state.h
index 59a20595f51d..c84a1f7060f4 100644
--- a/arch/sandbox/include/asm/state.h
+++ b/arch/sandbox/include/asm/state.h
@@ -6,7 +6,6 @@
 #ifndef __SANDBOX_STATE_H
 #define __SANDBOX_STATE_H
 
-#include <config.h>
 #include <sysreset.h>
 #include <stdbool.h>
 #include <linux/list.h>
diff --git a/arch/sandbox/lib/bootm.c b/arch/sandbox/lib/bootm.c
index a748ba650b12..290db4521702 100644
--- a/arch/sandbox/lib/bootm.c
+++ b/arch/sandbox/lib/bootm.c
@@ -4,7 +4,6 @@
  * Copyright (c) 2015 Sjoerd Simons <sjoerd.simons@collabora.co.uk>
  */
 
-#include <common.h>
 #include <bootstage.h>
 #include <image.h>
 #include <asm/io.h>
diff --git a/arch/sandbox/lib/fdt_fixup.c b/arch/sandbox/lib/fdt_fixup.c
index a646f2059c2c..e333bd52ea28 100644
--- a/arch/sandbox/lib/fdt_fixup.c
+++ b/arch/sandbox/lib/fdt_fixup.c
@@ -2,7 +2,6 @@
 
 #define LOG_CATEGORY LOGC_ARCH
 
-#include <common.h>
 #include <fdt_support.h>
 #include <log.h>
 
diff --git a/arch/sandbox/lib/interrupts.c b/arch/sandbox/lib/interrupts.c
index 4d7cbff802c6..3f6583e11f04 100644
--- a/arch/sandbox/lib/interrupts.c
+++ b/arch/sandbox/lib/interrupts.c
@@ -5,7 +5,6 @@
  * found in the LICENSE file.
  */
 
-#include <common.h>
 #include <efi_loader.h>
 #include <irq_func.h>
 #include <os.h>
diff --git a/arch/sandbox/lib/pci_io.c b/arch/sandbox/lib/pci_io.c
index 2038141947ab..6040eacb594f 100644
--- a/arch/sandbox/lib/pci_io.c
+++ b/arch/sandbox/lib/pci_io.c
@@ -8,7 +8,6 @@
  * IO space access commands.
  */
 
-#include <common.h>
 #include <command.h>
 #include <dm.h>
 #include <log.h>
diff --git a/board/sandbox/sandbox.c b/board/sandbox/sandbox.c
index 9d58860451c5..802596569c64 100644
--- a/board/sandbox/sandbox.c
+++ b/board/sandbox/sandbox.c
@@ -3,8 +3,8 @@
  * Copyright (c) 2011 The Chromium OS Authors.
  */
 
-#include <common.h>
 #include <addr_map.h>
+#include <config.h>
 #include <cpu_func.h>
 #include <cros_ec.h>
 #include <dm.h>
-- 
2.34.1

