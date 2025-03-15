Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F347C28B28
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 14:28:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09B0381877;
	Sat, 15 Mar 2025 15:27:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Zr+tfDzi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E9AD809A4; Sat, 15 Mar 2025 15:27:30 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5881810F5
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 15:27:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4394a0c65fcso6241895e9.1
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 07:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742048847; x=1742653647; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cgYQ1DBcTz0GQCTNBv2O8yfAQ8mKNJyLlRGuzmVQMpo=;
 b=Zr+tfDziweZ59KfvMtQPZrnvIa7A5KXQ0P2FNM6G0me3/fbALL15S9xA0hXl8YDTWd
 7u2Su1hAiDqQpq4KjuuHtS7ufNBjZeVt+MyuqmeSDBv29AgKlLjuik1bPYHDLN8cNfBz
 iWpyHOZYSdh277d/u4nvEYTlAASooF0t71EmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742048847; x=1742653647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cgYQ1DBcTz0GQCTNBv2O8yfAQ8mKNJyLlRGuzmVQMpo=;
 b=RciKogxqq1ZQq5ispax2RmOegnUoLKKtFJSvP+yamQtt+vM9NYcmfy347U6KfRqljF
 FIxWrClHSV6GNyfpxOKxesP7CxlDbqyr9uwKEL//ivv50nRmoQBk2LcGQuvPI3/nkfIV
 97cXQUb9VMjU5MAbYl2JM4QESfEk4eF4hhZtkSkyfMdQtz9L2I4G45JlOOA/eItAkP0c
 H4hvHOa+wa05Nr80B4pL1gwAI44ZTOnu3kstnzoev3ryP2nfeB+ywr30Rn9SfUWvAji1
 KPS+g4K9XLgOGetG2hWjPtvrKWF/Uphnmw6XZ+t/fP98nLQSBPTULbi4F4MDx/OENoY+
 amSQ==
X-Gm-Message-State: AOJu0Yyma8E4UeqcfTWxu3EK0DGFR9d7IkoS9koL1r059T+k+RYo3/Gn
 P9JN6qUjRDIFlpVq3Tgh/95fy5jQHQmM/7ccgCEd1Gr0Vaz8MvgLWhVUNhqtdmC6flWFP0Qjir8
 0Gg==
X-Gm-Gg: ASbGnctDSUVEzgJIuDvBy00ygSP1f9NQeGf/qEeglYQrZVoMkcl4IQegyvb9hw+8MSK
 xBEFnR+oksH1R7R3eKZexyCKV7dZHEspXbafwJR71ayy5TsAXkOQT/nBl1UNgdzsadZkoUpwtAq
 dRn3zBYp22qevtnOyGbsS3e4DHsV8Sqf1QVhko0TNiZoSXtpD8aELiX7vM8vI8MEw0R21B3CSVy
 MlZNS66JbJoMBJ3d6spHjJkcK2w2WOLgLIrl2TdZc6JhAD5GIrkDzNp3mQ9tJaCgU1krsJYp6WY
 yuMw9zFh+/s9itOyJqh4bTMxIAzKOwMQlZblY46gcA==
X-Google-Smtp-Source: AGHT+IGaN///fExRXYFjfmtZoUZWNWCHjfrYygvh+YQWPQhyqcRh9vEDlkjUGGeDtN+JOjPHhwMWfQ==
X-Received: by 2002:a05:600c:5494:b0:43d:b85:1831 with SMTP id
 5b1f17b1804b1-43d1ebfe809mr86373555e9.0.1742048847010; 
 Sat, 15 Mar 2025 07:27:27 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe29386sm52105055e9.17.2025.03.15.07.27.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 07:27:25 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 08/46] x86: Add some log categories
Date: Sat, 15 Mar 2025 14:25:28 +0000
Message-ID: <20250315142643.2600605-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250315142643.2600605-1-sjg@chromium.org>
References: <20250315142643.2600605-1-sjg@chromium.org>
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

