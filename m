Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86DF9CF395C
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 15:14:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A6BD891F3;
	Thu, 19 Sep 2024 17:14:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Bj/67aX3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2DEF884DB; Thu, 19 Sep 2024 17:14:31 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC24389230
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 17:14:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42cb5b3c57eso9025925e9.2
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 08:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726758869; x=1727363669; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cFWQJLdURE0qsc9NPj6MZmnsg8gkXI50GFdI5pU+D2I=;
 b=Bj/67aX33JajIF9JScvgo3HiCQjn2ZGpg82ilJdcXw/eicjV+6yEbZ6mjkcO3hJT+R
 fR18eP/3nWYVofh4k6U+u7dUSkuqfrmGxkPIgGUV6fu69nkuBT1DlY2j1L4FTWzbjg4s
 7jibVzVDnqltjQYq15/4TPCBsNYAeP9ZfU5IU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726758869; x=1727363669;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cFWQJLdURE0qsc9NPj6MZmnsg8gkXI50GFdI5pU+D2I=;
 b=b+LU/f75CrPQdJuyUBJZr9TuwCHh1NYPQNJSBV//ZzqfzPeJ33/uMe8lYY7p0U7KFW
 9WXQWTUjhZYBPvcui0uiZ8pOIPep9ibNNssFOfVWkj35ZqWFyvsq+p+YS4Bl8oGCL4Wd
 Am4+hSCz5WxF9MLXWNPmqyYfBapN7EohOu7BM/Ox8I//BpBGcDbs/Kwb2z/xvs8M0QDx
 /EcPm3pf4bnhl8PL7InlVksqHtD5NQijhyT39JFF2WNu/3t3mCJV7goPVh3r3IwZCHyv
 cjs7Jtc6mav/7G6hDbqzEZhxfJHjIY27R++P/Drf5dtoO4hnl2n50FskHpcd9cNcpqa6
 f12Q==
X-Gm-Message-State: AOJu0YzhJVZjOf9znDRNRmX+HjZfIqWF4UCQO5sT9lwPFOHLZoBjiuwD
 IO69qhrzezB6U4UXL0HLuy/UxDPk6xqUoKw0b4pzowbe7W0Bw3eM7M3Li34lK1S26WC58dHNbGk
 u/QQJsA8=
X-Google-Smtp-Source: AGHT+IFTdh5o38DHG20eZ0Fi2GtO3sdzsjuO8C/d+05+LM5YkcPTLfG/Yj4RGRVC6P3zRavvLjt8GQ==
X-Received: by 2002:a05:600c:314e:b0:42c:bf94:f9ad with SMTP id
 5b1f17b1804b1-42cdb5919fbmr188304875e9.34.1726758868695; 
 Thu, 19 Sep 2024 08:14:28 -0700 (PDT)
Received: from chromium.org ([185.44.53.103]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e73f9cd3sm15457790f8f.62.2024.09.19.08.14.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 08:14:28 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alexander Dahl <ada@thorsis.com>, Heiko Schocher <hs@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Joao Marcos Costa <jmcosta944@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <seanga2@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Subject: [PATCH] doc: Move the generic memory-documentation to doc/
Date: Thu, 19 Sep 2024 17:14:22 +0200
Message-ID: <20240919151424.57663-1-sjg@chromium.org>
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

 README                 | 45 ------------------------------------------
 doc/develop/index.rst  |  1 +
 doc/develop/memory.rst | 45 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+), 45 deletions(-)
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
index 00000000000..fa1ae5e97ed
--- /dev/null
+++ b/doc/develop/memory.rst
@@ -0,0 +1,45 @@
+.. SPDX-License-Identifier: GPL-2.0+:
+
+Memory Management
+-----------------
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

