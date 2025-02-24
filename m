Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE830C021A4
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 23:07:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9161280FE2;
	Tue, 25 Feb 2025 00:07:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QpABdo31";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88D6280FD1; Tue, 25 Feb 2025 00:07:12 +0100 (CET)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B5C680977
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 00:07:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3cf880d90bdso13345475ab.3
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 15:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740438428; x=1741043228; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cgYQ1DBcTz0GQCTNBv2O8yfAQ8mKNJyLlRGuzmVQMpo=;
 b=QpABdo313rv4ytiNOq8wd+dwkrylpsEFTFcC8BGVjtcps/dNUxmpnn87ZwI3dL6u5v
 aRkVGintxPO+8ysj0pV87RWaAqCpDiCjw5bVwu5ri5G8addG8yJuW8c/0Ai+5/rKFJN5
 kNhX7QhEldyI1N0qcvaqblpszMqg9PDPzJ9fc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740438428; x=1741043228;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cgYQ1DBcTz0GQCTNBv2O8yfAQ8mKNJyLlRGuzmVQMpo=;
 b=k0xUVwZCb27dBl4zUK7wnE+rRSgi17Qi2H/zsa/+13ZmxEuqWcTkTC/vcLyAKguv5Q
 gcHrYoxVrwjEWaOlmBZzhDCjqA1/2wqOHFzYYfAZy4weecjFmsK81nzvIvVTO+7kZTOU
 lL7WMO36GGTQ5zPwKpAhWTY5tN/dhFs3GMhsXH6P0L1IqFgmZPLFTme57aPV31wf05Ty
 piB4s6pjXddeaFR6mnLhivqLwwNVUL1Uk2E+X7Aoona7AfvARsyTG/E5LrLtkPMijBjx
 yTbqENKir7Mz5cAawTJROkCv5//gKIreGb88HS7LNLBFHFeyInkhBNi4MKwyzwZ0IHGN
 Pouw==
X-Gm-Message-State: AOJu0YwbY03KDJFIsGp58Zyt+jNkOUWLorGzSOwrpS+rx0xHsXMvKegI
 o1kyQOEPYpeMmm91i2UIQN4sm2fVSSNN7N65nyiDmPrXDmNvLTVAhCwXOKblLS/dlAYXK6owdu8
 =
X-Gm-Gg: ASbGncsTrKge0US8c92T+3kOlYfBcWnQRa/5dtqvHIRqgEqIBqscyJpIAZQRpNxgm4s
 PK02WeykQV5q43UJNsBJNPqq1X74ScS5S2HzyGX5WVW60ShDtjuQ1MzmGPLC7nROsrTor9lI8Qu
 WzOu1y/VptM1oz2WeFhUIEwXycUu3J3JwsamFGY/LlYJowADUX75BV0kc+BcAa3iXIlOQQukEkf
 QJEZHN6wffiK5/BYP0Cln+K7NaAAiQZPG0hnf35TAmnQz39CVYJXEOV3e6yJTvLI2N5yHUjK5vT
 BKQ9H4yIsNB0G5wKVgHqM0HH0cAXZb8lXntlwOka/26KMZeDCsj8XFSeZohl9nQ=
X-Google-Smtp-Source: AGHT+IG5fqxYvl6yTJIUHbuCTvpRfr6HF5rW67LCQP0e/RBT1K9IK2LcghZ/sG3lE8HxDpZJ2gvTGQ==
X-Received: by 2002:a05:6e02:20ca:b0:3d0:2314:26e5 with SMTP id
 e9e14a558f8ab-3d2caf0039emr175035895ab.18.1740438428586; 
 Mon, 24 Feb 2025 15:07:08 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f04752e026sm113941173.107.2025.02.24.15.07.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 15:07:07 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 06/44] x86: Add some log categories
Date: Mon, 24 Feb 2025 16:05:55 -0700
Message-ID: <20250224230640.2665206-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224230640.2665206-1-sjg@chromium.org>
References: <20250224230640.2665206-1-sjg@chromium.org>
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

