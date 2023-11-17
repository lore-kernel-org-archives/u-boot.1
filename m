Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D844DC072A2
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 22:54:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C7BD874E9;
	Fri, 17 Nov 2023 23:53:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Syfs8b6x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 238AF874FB; Fri, 17 Nov 2023 23:53:32 +0100 (CET)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2D4C874D9
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 23:53:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-677f832d844so5242506d6.2
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 14:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700261597; x=1700866397; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yncfUOdR428xSI5RG+oWq1WkcHuS7poQBB7zxlboJuk=;
 b=Syfs8b6xIWMpJFp4E86brt6DSTmhyblHzCaHpSJz1B4jpgbMYcBfifBWAgz6Hwzk8r
 AiYYnl8gEov2D6ghkMrYdz5btL9zu2GA9yvRV0dIYL8b8g6cPTgm9DmONGgdqby08Ovt
 1rxwKAMMKyMYAK7GgkOHAP3mYwVGrkJIBY3p0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700261597; x=1700866397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yncfUOdR428xSI5RG+oWq1WkcHuS7poQBB7zxlboJuk=;
 b=OGkIubAkUq9nYie2O1nEAsy4HWGeJzKkOGI+WFHq00DVk8PmDBUmHl++Qjr7QcmE/V
 9DpMAaEfJL+0baREA37FkkNDtDO4SQkG4GgzCVi+amJW2S8gqqY3aKvXJODYslPCeHfx
 lFiZxZCWDCb0kUEykWdA8UtPS6T5dJBR/UJCA+RlSLb4zBSe0lsPXpmAsKvg6/iqwfkq
 8JihLt7w2IoDVAUrsS+vRN0FkxKX0I5PlMX4fGwt7Mk3GlwdwJH+3bwciR2en7NeN0wN
 qEKiStk5ZMtSAOivW+Mjd0QFj9hLEHQaAkEWdXvrF7mg4pIrSkKEMNDGrC5QbZwmtNFu
 MTsw==
X-Gm-Message-State: AOJu0YyypU9VX6z4EpRioH61WAJuDX+EiW4kE3xeA0OUq1IKwOLR1QxT
 JbgxnNW139mMqCXoD5VpbJ3aWghUTi4nwn8ZrrS8uA==
X-Google-Smtp-Source: AGHT+IFYuk9FzJATu2P2MqqyZzqOMjE64P+ehKly6bVxTs9oa8QPePm4nLCbVEVjDiobtudMHBejtw==
X-Received: by 2002:a05:6214:1d23:b0:66f:b8a2:521a with SMTP id
 f3-20020a0562141d2300b0066fb8a2521amr736220qvd.17.1700261596748; 
 Fri, 17 Nov 2023 14:53:16 -0800 (PST)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-dbd8-aafa-ccfe-bf84.res6.spectrum.com.
 [2603:6081:7b00:6400:dbd8:aafa:ccfe:bf84])
 by smtp.gmail.com with ESMTPSA id
 r12-20020a05621410cc00b0065b08bb01afsm961084qvs.124.2023.11.17.14.53.16
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 14:53:16 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 4/5] sandbox: Audit config.h and common.h usage
Date: Fri, 17 Nov 2023 17:53:12 -0500
Message-Id: <20231117225313.2144665-4-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231117225313.2144665-1-trini@konsulko.com>
References: <20231117225313.2144665-1-trini@konsulko.com>
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
 arch/sandbox/cpu/cache.c         | 1 -
 arch/sandbox/cpu/cpu.c           | 1 -
 arch/sandbox/cpu/sdl.c           | 2 +-
 arch/sandbox/cpu/spl.c           | 1 -
 arch/sandbox/cpu/start.c         | 2 +-
 arch/sandbox/cpu/state.c         | 2 +-
 arch/sandbox/include/asm/io.h    | 2 ++
 arch/sandbox/include/asm/state.h | 1 -
 arch/sandbox/lib/bootm.c         | 1 -
 arch/sandbox/lib/fdt_fixup.c     | 1 -
 arch/sandbox/lib/interrupts.c    | 1 -
 arch/sandbox/lib/pci_io.c        | 1 -
 board/sandbox/sandbox.c          | 2 +-
 13 files changed, 6 insertions(+), 12 deletions(-)

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
index e38bb248b7ff..2462f990baae 100644
--- a/arch/sandbox/cpu/state.c
+++ b/arch/sandbox/cpu/state.c
@@ -3,7 +3,7 @@
  * Copyright (c) 2011-2012 The Chromium OS Authors.
  */
 
-#include <common.h>
+#include <config.h>
 #include <autoboot.h>
 #include <bloblist.h>
 #include <errno.h>
diff --git a/arch/sandbox/include/asm/io.h b/arch/sandbox/include/asm/io.h
index 31ab7289b4bd..1ccb25a0fe1e 100644
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
index dc8b8e46cb41..270671145a0b 100644
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

