Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84E11C369CD
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 12:29:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6AA088D7D;
	Thu, 26 Sep 2024 14:29:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IN6Mo80K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98112884DB; Thu, 26 Sep 2024 14:29:06 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 968DC88A0A
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 14:29:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a8d6ac24a3bso174935866b.1
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 05:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727353744; x=1727958544; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=31H+kJxzmCnhqeBHzbcDiS14/Dwq3yuP8Vh3u/YrUZo=;
 b=IN6Mo80KsSAINx+Gzj4CFprb/vUUe3RjO+hb83TjLjJEpwUu8gV0WWH8g0V6kkmm8y
 Czre4WaUmHeGp6MDoZlnzSMBCfrLy89AFmeKJtZZzhFgo6yfkTpjneeOl3/cRsN3RZND
 WJY777eu4+r9sl0f+cN0ewmn/lsLkdse6nrSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727353744; x=1727958544;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=31H+kJxzmCnhqeBHzbcDiS14/Dwq3yuP8Vh3u/YrUZo=;
 b=k0BB9ssq8X6ppWxa/xhBoC52RY5C158olk4rsahcDxZ9Smh9PYntDt/aVWHoBFMhna
 9yyBuhDvL7hNhlpnAp0tNVqLc4ZjsgBI7RDQvgT+8yQtim3kDbsmcWHsVYC/40WX1TCm
 g5mKjhldhf7Z20QJno7iqsil6do9e6YBq2SoLn00RlLxngQ8Ky8EBxHeHKHFvRx3QAMv
 nLjI7ZpNUDqW7UK0QYcD4BUxeefpMiARht+OKsKSyk0LnFCyM6h0sZ0DQziX1Q0HnUVT
 Bu8oeK8z9EodNyUICNLBNz+wASZM88P0VQbvqqJIFmbXWu/FJf1oMUjEyk4cn50auy8T
 HwIQ==
X-Gm-Message-State: AOJu0YwnjlwklXteSkHX/yPNN63pj5VQTEAb7wzZ2J3zAvGfz+96JtWq
 mj6N/xikbLg+e6jMX7PLvn9Rbllv27qcaYucVGfdvIS6Oe4BJMsK0yX+DRe14uUUQFvn8QvcL9u
 NFted
X-Google-Smtp-Source: AGHT+IExhqaLzjaIHKwJIEFrdlV8a9wnemDyz0NeTYGtCbPkqiLjGjwWkZgCrU3UfmnRcuN0ohuRHA==
X-Received: by 2002:a17:907:f1c1:b0:a7a:acae:340b with SMTP id
 a640c23a62f3a-a93b1649142mr324295366b.31.1727353743763; 
 Thu, 26 Sep 2024 05:29:03 -0700 (PDT)
Received: from chromium.org ([212.185.66.16]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93930fb361sm342878166b.183.2024.09.26.05.29.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 05:29:03 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Alexander Dahl <ada@thorsis.com>,
 Heiko Schocher <hs@denx.de>, Joao Marcos Costa <jmcosta944@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <seanga2@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Subject: [PATCH v2] doc: Move the generic memory-documentation to doc/
Date: Thu, 26 Sep 2024 14:28:51 +0200
Message-ID: <20240926122852.658621-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
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

Move this section of the README into doc/ with some minor updates to
mention SPL and user lower-case hex.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Mention that these docs need updating

 README                 | 45 ----------------------------------------
 doc/develop/index.rst  |  1 +
 doc/develop/memory.rst | 47 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 48 insertions(+), 45 deletions(-)
 create mode 100644 doc/develop/memory.rst

diff --git a/README b/README
index 4be1e8c22a0..d73042406b6 100644
--- a/README
+++ b/README
@@ -2516,51 +2516,6 @@ On RISC-V, the following registers are used:
 
     ==> U-Boot will use gp to hold a pointer to the global data
 
-Memory Management:
-------------------
-
-U-Boot runs in system state and uses physical addresses, i.e. the
-MMU is not used either for address mapping nor for memory protection.
-
-The available memory is mapped to fixed addresses using the memory
-controller. In this process, a contiguous block is formed for each
-memory type (Flash, SDRAM, SRAM), even when it consists of several
-physical memory banks.
-
-U-Boot is installed in the first 128 kB of the first Flash bank (on
-TQM8xxL modules this is the range 0x40000000 ... 0x4001FFFF). After
-booting and sizing and initializing DRAM, the code relocates itself
-to the upper end of DRAM. Immediately below the U-Boot code some
-memory is reserved for use by malloc() [see CONFIG_SYS_MALLOC_LEN
-configuration setting]. Below that, a structure with global Board
-Info data is placed, followed by the stack (growing downward).
-
-Additionally, some exception handler code is copied to the low 8 kB
-of DRAM (0x00000000 ... 0x00001FFF).
-
-So a typical memory configuration with 16 MB of DRAM could look like
-this:
-
-	0x0000 0000	Exception Vector code
-	      :
-	0x0000 1FFF
-	0x0000 2000	Free for Application Use
-	      :
-	      :
-
-	      :
-	      :
-	0x00FB FF20	Monitor Stack (Growing downward)
-	0x00FB FFAC	Board Info Data and permanent copy of global data
-	0x00FC 0000	Malloc Arena
-	      :
-	0x00FD FFFF
-	0x00FE 0000	RAM Copy of Monitor Code
-	...		eventually: LCD or video framebuffer
-	...		eventually: pRAM (Protected RAM - unchanged by reset)
-	0x00FF FFFF	[End of RAM]
-
-
 System Initialization:
 ----------------------
 
diff --git a/doc/develop/index.rst b/doc/develop/index.rst
index 0d0e60ab56c..cbea38d4323 100644
--- a/doc/develop/index.rst
+++ b/doc/develop/index.rst
@@ -13,6 +13,7 @@ General
    codingstyle
    designprinciples
    docstyle
+   memory
    patman
    process
    release_cycle
diff --git a/doc/develop/memory.rst b/doc/develop/memory.rst
new file mode 100644
index 00000000000..816fe3ec5db
--- /dev/null
+++ b/doc/develop/memory.rst
@@ -0,0 +1,47 @@
+.. SPDX-License-Identifier: GPL-2.0+:
+
+Memory Management
+-----------------
+
+Note: This information is outdated and needs to be updated.
+
+U-Boot runs in system state and uses physical addresses, i.e. the
+MMU is not used either for address mapping nor for memory protection.
+
+The available memory is mapped to fixed addresses using the
+memory-controller. In this process, a contiguous block is formed for each
+memory type (Flash, SDRAM, SRAM), even when it consists of several
+physical-memory banks.
+
+U-Boot is installed in XIP flash memory, or may be loaded into a lower region of
+RAM by a secondary program loader (SPL). After
+booting and sizing and initialising DRAM, the code relocates itself
+to the upper end of DRAM. Immediately below the U-Boot code some
+memory is reserved for use by malloc() [see CONFIG_SYS_MALLOC_LEN
+configuration setting]. Below that, a structure with global Board-Info
+data is placed, followed by the stack (growing downward).
+
+Additionally, some exception handler code may be copied to the low 8 kB
+of DRAM (0x00000000 ... 0x00001fff).
+
+So a typical memory configuration with 16 MB of DRAM could look like
+this::
+
+	0x0000 0000	Exception Vector code
+	      :
+	0x0000 1fff
+	0x0000 2000	Free for Application Use
+	      :
+	      :
+
+	      :
+	      :
+	0x00fb ff20	Monitor Stack (Growing downward)
+	0x00fb ffac	Board Info Data and permanent copy of global data
+	0x00fc 0000	Malloc Arena
+	      :
+	0x00fd ffff
+	0x00fe 0000	RAM Copy of Monitor Code
+	...		eventually: LCD or video framebuffer
+	...		eventually: pRAM (Protected RAM - unchanged by reset)
+	0x00ff ffff	[End of RAM]
-- 
2.43.0

