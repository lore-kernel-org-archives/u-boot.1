Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D21EBC27C77
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 06:54:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB97988081;
	Fri, 14 Jun 2024 08:54:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jEjhcxKZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8104E87E96; Fri, 14 Jun 2024 08:54:10 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C6588897B
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 08:54:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-52c32d934c2so2000694e87.2
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 23:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718348047; x=1718952847; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tXyC2hSxrSy8HIszYxHGrY3fviY0Db+JHvksS1U04QU=;
 b=jEjhcxKZxr+IWMBezOVorDtx/Z6UvQNMG/F2Iso4SybkRRGwyftQeiWhWd47h4UHeW
 GFNg0TAgp6T9cC7jPStUnylYApVbx91zoXLili4oAetQU0jSHOYxEnJpjLMQu+Ne6svm
 f4OHyXG4Se31p5W5hlTPtEKORYHUvO1bTvplZyq7Qx7E//j3wZrczwfjsYjTa81aX2ID
 Hkz7BtDcHZ9Jb5f3g2zq6tMdZvRJHQU1zl/JPqHfk4/fTXH1dSxNneStgpEjdKZusHG/
 1+XlLPhMHqCX4u7XPmGbi3yfYCp83zyFgYlj9WyoWTw9wqIzcCNJYmCym5yLkCChYEVz
 ZQKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718348047; x=1718952847;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tXyC2hSxrSy8HIszYxHGrY3fviY0Db+JHvksS1U04QU=;
 b=C9NSY1m3H8rhi6fSSfJFTvy7QmmTooCGsdLeiTGTQr1Une+i6axmEf1jBOARo0VMYC
 nMdCIEl4rUd8H9ov42KISGTMOF7TRi9UzONInT9CbhMxYPciqdSC5sc/krcIKvGAxm9w
 6uTBpgLg8UuEdmqDuDSCdv73UW92LRyn6iScELCC+UXhdT7wH5y3m6bbrJu5TGCxdn//
 hhNlBtyZvz5y3+csSVS48/ezcwP2pBs3sE3cLiGaUOxbzNcMWjtLjVljOrTPXI6MfbQl
 tr28JVGEV15fhpx0M8cm7NHZE3sQUm+I6Q3bTaLh2CqULaSqTIe6K+vK/nkfrYHrAxIZ
 83Xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7jQdO7YRxQoaSxPLh9PqUqbCwD/DtE6neC6WQj0PjRQQTQhQ+nWPVPRizXMl1zIAjL9yLgTkldTdHe9ikyBTBIoXp8w==
X-Gm-Message-State: AOJu0YxfUfrtZJuJLwSrFTL6dTW4eErVmlm/IqFJzyT0KRVEoZnNbP8G
 UE1Qbu1816aeqL7qsYZygEMgUq7mUt4JXrlSEEXMkX1pWUrYnjVIqxk18jdUq5s=
X-Google-Smtp-Source: AGHT+IFk2ePj/Nfnwz9NbVYcOJuYUO8eAaSFlC/8h98tDRAsbRpe6T0Vk83M0RAJNS4qbK0kCYcRlQ==
X-Received: by 2002:ac2:4db9:0:b0:52c:5252:55c2 with SMTP id
 2adb3069b0e04-52ca6e9a0d4mr982108e87.64.1718348047517; 
 Thu, 13 Jun 2024 23:54:07 -0700 (PDT)
Received: from localhost.localdomain (ppp046103020130.access.hol.gr.
 [46.103.20.130]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36074e0e5adsm3531579f8f.0.2024.06.13.23.54.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 23:54:06 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: sjg@chromium.org
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Angelo Dureghello <angelo@kernel-space.org>, u-boot@lists.denx.de
Subject: [PATCH] sandbox: cleanup linker scripts and sections
Date: Fri, 14 Jun 2024 09:53:56 +0300
Message-ID: <20240614065357.182446-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.1
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

commit 6e2228fb052b ("Merge patch series "Clean up arm linker scripts"")
was cleaning up linker scripts for armv7 and v8 in a similar fashion.

Several commits in the past -- e.g
commit d0b5d9da5de2 ("arm: make _end compiler-generated")
was moving symbols to be compiler generated. They were defined as c
variables in its own section to force the compiler emit relative a
reference. However, defining those in the linker script will do the
same thing since [0].

So let's remove the special sections from the linker scripts, the
variable definitions from sections.c, and define them as a symbols.
It's worth noting that the linker was discarding the symbols in the
older binary completely.

- new binary
$~ aarch64-linux-gnu-readelf -sW u-boot | grep efi_runtim
   246: 000000000004acbe    13 FUNC    LOCAL  DEFAULT   14 vbe_req_efi_runtime_rand
  3198: 0000000000318690    16 OBJECT  LOCAL  DEFAULT   29 efi_runtime_mmio
  6359: 00000000000dedff   217 FUNC    LOCAL  DEFAULT   14 efi_runtime_relocate
  7942: 00000000003074c0   136 OBJECT  GLOBAL HIDDEN    29 efi_runtime_services
  8869: 0000000000305e20     0 NOTYPE  GLOBAL DEFAULT   27 __efi_runtime_rel_stop
  9159: 0000000000305e20     0 NOTYPE  GLOBAL DEFAULT   27 __efi_runtime_stop
  9410: 0000000000305e20     0 NOTYPE  GLOBAL DEFAULT   27 __efi_runtime_start
 10137: 00000000005981bd     0 NOTYPE  WEAK   HIDDEN    33 efi_runtime.c.de5bed54
 10470: 0000000000305e20     0 NOTYPE  GLOBAL DEFAULT   27 __efi_runtime_rel_start

- old binary
$~ aarch64-linux-gnu-readelf -sW u-boot.old | grep efi_runtim
   246: 000000000004acbe    13 FUNC    LOCAL  DEFAULT   14 vbe_req_efi_runtime_rand
  3198: 0000000000318690    16 OBJECT  LOCAL  DEFAULT   29 efi_runtime_mmio
  6359: 00000000000dedff   221 FUNC    LOCAL  DEFAULT   14 efi_runtime_relocate
  7942: 00000000003074c0   136 OBJECT  GLOBAL HIDDEN    29 efi_runtime_services
 10135: 0000000000598320     0 NOTYPE  WEAK   HIDDEN    33 efi_runtime.c.de5bed54

$~ bloat-o-meter u-bool.old u-boot
add/remove: 0/0 grow/shrink: 1/1 up/down: 7/-4 (3)
Function                                     old     new   delta
efi_memory_init                              343     350      +7
efi_runtime_relocate                         221     217      -4
Total: Before=2009902, After=2009905, chg +0.00%

[0] binutils commit 6b3b0ab89663 ("Make linker assigned symbol dynamic only for shared object")

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 arch/sandbox/cpu/u-boot.lds | 20 ++++----------------
 arch/sandbox/lib/Makefile   |  2 +-
 arch/sandbox/lib/sections.c | 13 -------------
 3 files changed, 5 insertions(+), 30 deletions(-)
 delete mode 100644 arch/sandbox/lib/sections.c

diff --git a/arch/sandbox/cpu/u-boot.lds b/arch/sandbox/cpu/u-boot.lds
index 52f13af3742f..6ee8095b6cbb 100644
--- a/arch/sandbox/cpu/u-boot.lds
+++ b/arch/sandbox/cpu/u-boot.lds
@@ -19,30 +19,18 @@ SECTIONS
 		*(_u_boot_sandbox_getopt_end)
 	}

-	efi_runtime_start : {
-		*(___efi_runtime_start)
-	}
-
 	efi_runtime : {
+                __efi_runtime_start = .;
 		*(efi_runtime_text)
 		*(efi_runtime_data)
-	}
-
-	efi_runtime_stop : {
-		*(___efi_runtime_stop)
-	}
-
-	efi_runtime_rel_start : {
-		*(___efi_runtime_rel_start)
+                __efi_runtime_stop = .;
 	}

 	efi_runtime_rel : {
+                __efi_runtime_rel_start = .;
 		*(.relefi_runtime_text)
 		*(.relefi_runtime_data)
-	}
-
-	efi_runtime_rel_stop : {
-		*(___efi_runtime_rel_stop)
+                __efi_runtime_rel_stop = .;
 	}

 	.dynsym :
diff --git a/arch/sandbox/lib/Makefile b/arch/sandbox/lib/Makefile
index a2bc5a7ee60f..d7d15a50bb6c 100644
--- a/arch/sandbox/lib/Makefile
+++ b/arch/sandbox/lib/Makefile
@@ -5,7 +5,7 @@
 # (C) Copyright 2002-2006
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.

-obj-y	+= fdt_fixup.o interrupts.o sections.o
+obj-y			+= fdt_fixup.o interrupts.o
 obj-$(CONFIG_PCI)	+= pci_io.o
 obj-$(CONFIG_CMD_BOOTM) += bootm.o
 obj-$(CONFIG_CMD_BOOTZ) += bootm.o
diff --git a/arch/sandbox/lib/sections.c b/arch/sandbox/lib/sections.c
deleted file mode 100644
index 2f2f3fbfdb86..000000000000
--- a/arch/sandbox/lib/sections.c
+++ /dev/null
@@ -1,13 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright 2013 Albert ARIBAUD <albert.u.boot@aribaud.net>
- *
- */
-#include <linux/compiler.h>
-
-char __efi_runtime_start[0] __section("___efi_runtime_start");
-char __efi_runtime_stop[0] __section("___efi_runtime_stop");
-char __efi_runtime_rel_start[0]
-		__section("___efi_runtime_rel_start");
-char __efi_runtime_rel_stop[0]
-		__section("___efi_runtime_rel_stop");
--
2.45.1

