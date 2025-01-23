Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 781DAC02182
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 13:02:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99483807D9;
	Thu, 23 Jan 2025 14:01:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="Lk0aIv1l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19C2280137; Thu, 23 Jan 2025 10:12:20 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2ED5080243
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 10:12:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id C841725BB2;
 Thu, 23 Jan 2025 10:12:17 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0IrXC6HtsCbq; Thu, 23 Jan 2025 10:12:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1737623532; bh=Q7H5x45ew21P956cdkpE+/6J0SZ9gTyYSxaqTdrlq5A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Lk0aIv1lOagNDxw3+rmu1HTBvlLUEJKChGqjsKspFhbWAgJGkJPRYLZqeBhKIq06q
 RzJ8CHfz2yZbPrxfXc6fzAiWxZ6gHs83byjug67SlIpoKDY/wN7wI1m08qRahOGD9U
 x40//iQJe9RcHyYW+FGN+zVEFYZTEPOh/NKlNiBwGHjXlsVi/vwwS1sAf/MmrDT7q8
 uDZTZQt70juJJOwc2mHLkD111JHC+zjnKPj9n6pvRR+FNzULDmrqZWmo4UjfF1s6Fl
 /F1XMSG9D3EUqoqaYEj71Zteg9WYbMkuOM+A0Do2XUqiBPSomHrZuf2RRr33/M7yEN
 jybH98Xh9/glA==
From: Yao Zi <ziyao@disroot.org>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Conor Dooley <conor.dooley@microchip.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,
	Yao Zi <ziyao@disroot.org>
Subject: [RFC PATCH 1/3] riscv: add a generic implementation for
 cleanup_before_linux()
Date: Thu, 23 Jan 2025 09:11:33 +0000
Message-ID: <20250123091134.63634-3-ziyao@disroot.org>
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

Most RISC-V SoCs have similar cleanup_before_linux() functions. Let's
provide a weak symbol as fallback to reduce duplicated code.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 arch/riscv/cpu/cpu.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/riscv/cpu/cpu.c b/arch/riscv/cpu/cpu.c
index 06ecd92b9bc..5b31da64cbd 100644
--- a/arch/riscv/cpu/cpu.c
+++ b/arch/riscv/cpu/cpu.c
@@ -11,11 +11,13 @@
 #include <event.h>
 #include <hang.h>
 #include <init.h>
+#include <irq_func.h>
 #include <log.h>
 #include <asm/encoding.h>
 #include <asm/system.h>
 #include <asm/hwcap.h>
 #include <asm/cpufeature.h>
+#include <asm/cache.h>
 #include <dm/uclass-internal.h>
 #include <linux/bitops.h>
 #include <linux/log2.h>
@@ -729,3 +731,18 @@ void reset_cpu(void)
 	hang();
 }
 #endif
+
+/*
+ * cleanup_before_linux() is called just before we call linux, which prepares
+ * the processor for linux.
+ * this weak implementation is used by default. we disable interrupts and flush
+ * the cache.
+ */
+__weak int cleanup_before_linux(void)
+{
+	disable_interrupts();
+
+	cache_flush();
+
+	return 0;
+}
-- 
2.48.0

