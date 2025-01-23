Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95C6CC02182
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 13:02:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDD10807E9;
	Thu, 23 Jan 2025 14:01:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="HNj+0mUY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84334803B5; Thu, 23 Jan 2025 10:12:23 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57BA980243
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 10:12:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 25A7925746;
 Thu, 23 Jan 2025 10:12:21 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y0__xOuUU2Zs; Thu, 23 Jan 2025 10:12:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1737623540; bh=dFIdZ+mKqEc43eRsZjj4aPdYDATxWT7prtNQWZOjzR8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=HNj+0mUYm5Etjhwkh3cvrZQJmCvJr0Q5kYk19e1DDi6bAE5SexbvHhRVI/GVkQdB7
 EJbC0hSzqO7b8eC1IdYXB+z2+XPRCnwnAV/3/wnuGMmntE9QkIJ0GWJ1scgxj5+mjN
 DbQ3hUmO//ytl7kB2nwL6SPD8MqxcquR+Wqop8SOUm4KBSsC1JElsXViWgGpaVoqKb
 7a7d+udufyofXINdQ6du5bq/hVVOzq0WRoMqYSL3MO+jJYxogZ+7dwsYQhOYT+yobI
 XXW89+7IxW7swseX0CQdKmL3NmtZOrgfXqBkJzNpp3nNGRgZx9Y5OT9ERj0pV4fXfj
 BtLGS7eLWLxlA==
From: Yao Zi <ziyao@disroot.org>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Conor Dooley <conor.dooley@microchip.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,
	Yao Zi <ziyao@disroot.org>
Subject: [RFC PATCH 3/3] riscv: cpu: jh7110: fallback to generic
 cleanup_before_linux()
Date: Thu, 23 Jan 2025 09:11:35 +0000
Message-ID: <20250123091134.63634-5-ziyao@disroot.org>
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

JH7110 SoC requires no specific handling before entering Linux kernel.
Let's drop the specific implementation to avoid duplication.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 arch/riscv/cpu/jh7110/Makefile |  1 -
 arch/riscv/cpu/jh7110/cpu.c    | 23 -----------------------
 2 files changed, 24 deletions(-)
 delete mode 100644 arch/riscv/cpu/jh7110/cpu.c

diff --git a/arch/riscv/cpu/jh7110/Makefile b/arch/riscv/cpu/jh7110/Makefile
index 0939c1061d0..4f91aafa9da 100644
--- a/arch/riscv/cpu/jh7110/Makefile
+++ b/arch/riscv/cpu/jh7110/Makefile
@@ -5,6 +5,5 @@
 ifeq ($(CONFIG_XPL_BUILD),y)
 obj-y += spl.o
 else
-obj-y += cpu.o
 obj-y += dram.o
 endif
diff --git a/arch/riscv/cpu/jh7110/cpu.c b/arch/riscv/cpu/jh7110/cpu.c
deleted file mode 100644
index 1d7c026584a..00000000000
--- a/arch/riscv/cpu/jh7110/cpu.c
+++ /dev/null
@@ -1,23 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (C) 2022 StarFive Technology Co., Ltd.
- * Author: Yanhong Wang <yanhong.wang@starfivetech.com>
- */
-
-#include <asm/cache.h>
-#include <irq_func.h>
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

