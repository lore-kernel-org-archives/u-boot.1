Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A49B5C02182
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 13:02:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48616807B6;
	Thu, 23 Jan 2025 14:01:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="Sa8vZVwQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B19D0803B5; Thu, 23 Jan 2025 10:12:19 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9A8E80137
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 10:12:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 99E0D257BE;
 Thu, 23 Jan 2025 10:12:17 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jufy68xnyozM; Thu, 23 Jan 2025 10:12:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1737623536; bh=BuRiRBBf3pIXUQiIBb7jmcb75Iq8OYqnYRzMfdUDwLY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Sa8vZVwQpTrYM/lkuEbsBzRxFQLpJCX2El5Z5lydRSt0V2Fggjjssab5rF9SapY6o
 vP/ioVk1oq9V7CAOyXBCFSpoYELs0dP9TmKCC6y5B//tQdmJnNb60tOf4QiOUYNxkf
 uwTpjxCdoYMwtK98fDLKyhZvCN14xVh+8hFF8ez3zoybC6LgpYJkJtqxvve9uSYHGu
 5O2b/9qZQnv1TTaYVO+WtkJOLqWbhPfPfNPcipfSazUDiP/gPq6panegPgKnhplHbi
 2n/2d0Iq7r6mHrw2xI6WXeDUTjrsdKNRirYVNoohSp531OEmhsA6MXqUE+NiKF3lGX
 MdvRS+WXBXO2Q==
From: Yao Zi <ziyao@disroot.org>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Conor Dooley <conor.dooley@microchip.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,
	Yao Zi <ziyao@disroot.org>
Subject: [RFC PATCH 2/3] riscv: cpu: generic: fallback to generic
 cleanup_before_linux()
Date: Thu, 23 Jan 2025 09:11:34 +0000
Message-ID: <20250123091134.63634-4-ziyao@disroot.org>
In-Reply-To: <20250123091134.63634-2-ziyao@disroot.org>
References: <20250123091134.63634-2-ziyao@disroot.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 23 Jan 2025 14:01:27 +0100
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

The current implementation is equivalent to the fallback one, so
this shouldn't change any behaviour but cleans the code up only.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 arch/riscv/cpu/generic/Makefile |  1 -
 arch/riscv/cpu/generic/cpu.c    | 22 ----------------------
 2 files changed, 23 deletions(-)
 delete mode 100644 arch/riscv/cpu/generic/cpu.c

diff --git a/arch/riscv/cpu/generic/Makefile b/arch/riscv/cpu/generic/Makefile
index 258e4620dd4..a9be44ec387 100644
--- a/arch/riscv/cpu/generic/Makefile
+++ b/arch/riscv/cpu/generic/Makefile
@@ -3,4 +3,3 @@
 # Copyright (C) 2018, Bin Meng <bmeng.cn@gmail.com>
 
 obj-y += dram.o
-obj-y += cpu.o
diff --git a/arch/riscv/cpu/generic/cpu.c b/arch/riscv/cpu/generic/cpu.c
deleted file mode 100644
index f13c18942f3..00000000000
--- a/arch/riscv/cpu/generic/cpu.c
+++ /dev/null
@@ -1,22 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (C) 2018, Bin Meng <bmeng.cn@gmail.com>
- */
-
-#include <irq_func.h>
-#include <asm/cache.h>
-
-/*
- * cleanup_before_linux() is called just before we call linux
- * it prepares the processor for linux
- *
- * we disable interrupt and caches.
- */
-int cleanup_before_linux(void)
-{
-	disable_interrupts();
-
-	cache_flush();
-
-	return 0;
-}
-- 
2.48.0

