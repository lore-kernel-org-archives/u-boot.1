Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE714C02198
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 20:45:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D6C380F57;
	Sun, 16 Feb 2025 21:45:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RY8i9Zaf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42D4880F68; Sun, 16 Feb 2025 21:45:06 +0100 (CET)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26F9E80F18
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 21:45:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3d19f5ce8a0so6563885ab.1
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 12:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739738701; x=1740343501; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cgYQ1DBcTz0GQCTNBv2O8yfAQ8mKNJyLlRGuzmVQMpo=;
 b=RY8i9Zaf7z9x8E+ska9uQT3Rb/UU6i8TNzFgkCgXiho/gdrwLjgawxP5h225+6ueAQ
 gtFj/2jCDcuguMWUQYsxlL5QlkyZ0bnDK2uskYSojd5Ph9sAW/0/Vab1MNFmimfHh5RO
 OvRMFeW4O/mS9l1rlxUEjM5alpT7iDrh3s7i8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739738701; x=1740343501;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cgYQ1DBcTz0GQCTNBv2O8yfAQ8mKNJyLlRGuzmVQMpo=;
 b=VsOK5iG9Sopaw+39Wqi0AHz536H2/Yyolcp/KEE4YjHuH22dZm8uusFxtxwy0De/35
 W3Lypjg3oG2u7d0GiIN/MMDAkIUpPcHrgN1O9Rgd8dsN4t9sFgV8p2C5ucEMlnab9XMK
 aksAhvbyd5vAME90FiGcAG5Efv3TA0GYvLbfbrz+0lFz33ZqVLtii7rjJPFqg5H8NWCB
 RqA2at629SPpSx7koIwByuN/2BCFroIv32olLHKjXBnjpGQnRe9pMoPDcMZMJFB04Sus
 K5vnlF0G8j689hjNybMF/TdQv4f+r3yeNvj19/7Hczse/s5bKW83/rf7PlsH+zZ/c4gk
 ZMfQ==
X-Gm-Message-State: AOJu0YymuY6qQeTlBO+FOD1ojIsDGZFzI6bheuiFEsIko0KJsq7EyZ3G
 AGKuufmGMr6iix8E8P2zR4q7MC62+R8hKIaKx2455HXaqYSG6YRptQJ50EAD62F5cFH7q9aWW0Y
 =
X-Gm-Gg: ASbGnct+/ARnhvTMdTqubhAm0xXDciRsw+ILp4s/7u94j2nePrTx2IW7jIrcEYJvcCf
 kUF4pMFH+hmfn64HFpSDiPFyP0DHO+9Q6hUCfIzIhzvF0eefm26s+MDF22aIbdFsCy+GeJW1V/r
 vFZRJZAJvPG/n1q4/BmxUY1xU/I6t4RSqV8+c4hwKGe2j1nb3G0k8WKT18dzkgEJKIwDJyf8Qdm
 LKuZKhGG2HrJ1IPKJ0U2kzWigQYszo5MUfOIdJu7EBRR5z7J2bXdLWRcEY2Blk/P7MLPiRAxZ38
 Gn4k0ySAxPo8RTzEnmTEY4+HjFNtuXuZ9sr3zUqM607hy0kLs9+E
X-Google-Smtp-Source: AGHT+IFsN76ULlFRGtq1vsQVx/Hb2BTFEKyK7QXuy1wsDApI+Q/o1M1M1Lp0t9NqbdG//rmArsP1/g==
X-Received: by 2002:a05:6e02:2161:b0:3d1:15c9:c15f with SMTP id
 e9e14a558f8ab-3d18cd2671bmr99472655ab.11.1739738701417; 
 Sun, 16 Feb 2025 12:45:01 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ed281718f4sm1854186173.45.2025.02.16.12.44.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 12:44:59 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 06/28] x86: Add some log categories
Date: Sun, 16 Feb 2025 13:43:51 -0700
Message-ID: <20250216204421.3560012-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216204421.3560012-1-sjg@chromium.org>
References: <20250216204421.3560012-1-sjg@chromium.org>
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

Add categories for i8259 and bios files, so that log statements have the
right category.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/lib/bios.c            | 3 +++
 arch/x86/lib/bios_interrupts.c | 2 ++
 arch/x86/lib/i8259.c           | 2 ++
 3 files changed, 7 insertions(+)

diff --git a/arch/x86/lib/bios.c b/arch/x86/lib/bios.c
index 03f7360032c..acae635cf19 100644
--- a/arch/x86/lib/bios.c
+++ b/arch/x86/lib/bios.c
@@ -5,6 +5,9 @@
  * Copyright (C) 2007 Advanced Micro Devices, Inc.
  * Copyright (C) 2009-2010 coresystems GmbH
  */
+
+#define LOG_CATEGRORY	LOGC_ARCH
+
 #include <compiler.h>
 #include <bios_emul.h>
 #include <irq_func.h>
diff --git a/arch/x86/lib/bios_interrupts.c b/arch/x86/lib/bios_interrupts.c
index b2cf1527b1c..3ae6c193ec7 100644
--- a/arch/x86/lib/bios_interrupts.c
+++ b/arch/x86/lib/bios_interrupts.c
@@ -7,6 +7,8 @@
  * Copyright (C) 2007-2009 coresystems GmbH
  */
 
+#define LOG_CATEGRORY	LOGC_ARCH
+
 #include <log.h>
 #include <asm/pci.h>
 #include "bios_emul.h"
diff --git a/arch/x86/lib/i8259.c b/arch/x86/lib/i8259.c
index 465ff70146f..088f78f4661 100644
--- a/arch/x86/lib/i8259.c
+++ b/arch/x86/lib/i8259.c
@@ -13,6 +13,8 @@
  * Programmable Interrupt Controllers.
  */
 
+#define LOG_CATEGORY	UCLASS_IRQ
+
 #include <log.h>
 #include <asm/io.h>
 #include <asm/i8259.h>
-- 
2.43.0

