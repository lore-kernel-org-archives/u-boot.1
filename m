Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D871075275
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 08:38:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2F5383FE1;
	Thu, 19 Mar 2026 09:37:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06CB183DA6; Thu, 19 Mar 2026 09:37:56 +0100 (CET)
Received: from Atcsqr.andestech.com (exmail.andestech.com [60.248.187.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98C2383E36
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 09:37:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTP id 62J8bI6K017660;
 Thu, 19 Mar 2026 16:37:18 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Mar
 2026 16:37:18 +0800
From: Leo Yu-Chi Liang <ycliang@andestech.com>
To: <u-boot@lists.denx.de>
CC: <pbonzini@redhat.com>, <trini@konsulko.com>, <rick@andestech.com>,
 <ycliang@andestech.com>, <jerome.forissier@arm.com>,
 <xypron.glpk@gmx.de>, <ilias.apalodimas@linaro.org>,
 <kory.maincent@bootlin.com>,
 <eric.schikschneit@novatechautomation.com>, <sputnik@on-the-web.ch>,
 <michal.simek@amd.com>, <cnoize@andestech.com>, <qemu-devel@nongnu.org>
Subject: [PATCH 3/6] riscv: andes: Implement noncached memory using SBI PMA
Date: Thu, 19 Mar 2026 16:37:10 +0800
Message-ID: <20260319083713.3456894-1-ycliang@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 62J8bI6K017660
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

Implement noncached memory region management for Andes RISC-V
platforms using SBI PMA (Physical Memory Attribute) calls:

- noncached_init(): Compute region below malloc area, probe PMA
  support via sbi_pma_probe(), then configure the region as
  non-cacheable bufferable using sbi_pma_set() with NAPOT and
  NON_CACHE_BUF flags.
- noncached_alloc(): Bump allocator from the noncached region.
- noncached_set_region(): No-op since PMA handles attributes.
- noncached_free(): Release PMA entry, with probe-before-free
  guard to avoid calling free on unsupported firmware.

Also call noncached_free() in cleanup_before_linux() before
cache_flush() so the PMA entry is released before handing off
to Linux.

Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
 arch/riscv/cpu/andes/Makefile   |  1 +
 arch/riscv/cpu/andes/cpu.c      |  3 ++
 arch/riscv/cpu/andes/noncache.c | 79 +++++++++++++++++++++++++++++++++
 include/cpu_func.h              |  1 +
 4 files changed, 84 insertions(+)
 create mode 100644 arch/riscv/cpu/andes/noncache.c

diff --git a/arch/riscv/cpu/andes/Makefile b/arch/riscv/cpu/andes/Makefile
index 35a1a2fb836..f3602f6f598 100644
--- a/arch/riscv/cpu/andes/Makefile
+++ b/arch/riscv/cpu/andes/Makefile
@@ -6,3 +6,4 @@
 obj-y	:= cpu.o
 obj-y	+= cache.o
 obj-y	+= spl.o
+obj-$(CONFIG_SYS_HAS_NONCACHED_MEMORY) += noncache.o
diff --git a/arch/riscv/cpu/andes/cpu.c b/arch/riscv/cpu/andes/cpu.c
index feb755a4f0d..3aa89d86b6b 100644
--- a/arch/riscv/cpu/andes/cpu.c
+++ b/arch/riscv/cpu/andes/cpu.c
@@ -22,6 +22,9 @@ int cleanup_before_linux(void)
 {
 	disable_interrupts();
 
+	if (IS_ENABLED(CONFIG_SYS_HAS_NONCACHED_MEMORY))
+		noncached_free();
+
 	cache_flush();
 
 	return 0;
diff --git a/arch/riscv/cpu/andes/noncache.c b/arch/riscv/cpu/andes/noncache.c
new file mode 100644
index 00000000000..9886a757620
--- /dev/null
+++ b/arch/riscv/cpu/andes/noncache.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Andes Technology Corporation
+ * Rick Chen, Andes Technology Corporation <rick@andestech.com>
+ */
+
+#include <cpu_func.h>
+#include <log.h>
+#include <malloc.h>
+#include <asm/sbi.h>
+#include <asm/system.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+
+static unsigned long noncached_start;
+static unsigned long noncached_end;
+static unsigned long noncached_next;
+
+void noncached_set_region(void)
+{
+}
+
+int noncached_init(void)
+{
+	phys_addr_t start, end;
+	size_t size;
+	int ret;
+
+	/* If this calculation changes, update board_f.c:reserve_noncached() */
+	end = ALIGN(mem_malloc_start, MMU_SECTION_SIZE) - MMU_SECTION_SIZE;
+	size = ALIGN(CONFIG_SYS_NONCACHED_MEMORY, MMU_SECTION_SIZE);
+	start = end - size;
+
+	debug("mapping memory %pa-%pa non-cached\n", &start, &end);
+
+	ret = sbi_pma_probe();
+	if (ret <= 0) {
+		debug("PMA probe failed: %d\n", ret);
+		return ret;
+	}
+
+	ret = sbi_pma_set(start, size,
+			  ANDES_PMACFG_ETYP_NAPOT |
+			  ANDES_PMACFG_MTYP_MEM_NON_CACHE_BUF);
+	if (ret) {
+		debug("PMA set failed: %d\n", ret);
+		return ret;
+	}
+
+	noncached_start = start;
+	noncached_end = end;
+	noncached_next = start;
+
+	return 0;
+}
+
+phys_addr_t noncached_alloc(size_t size, size_t align)
+{
+	phys_addr_t next = ALIGN(noncached_next, align);
+
+	if (next >= noncached_end || (noncached_end - next) < size)
+		return 0;
+
+	debug("allocated %zu bytes of uncached memory @%pa\n", size, &next);
+	noncached_next = next + size;
+
+	return next;
+}
+
+void noncached_free(void)
+{
+	if (!noncached_start)
+		return;
+
+	if (sbi_pma_probe() <= 0)
+		return;
+
+	sbi_pma_free(noncached_start);
+}
diff --git a/include/cpu_func.h b/include/cpu_func.h
index 70a41ead3f7..061d497d454 100644
--- a/include/cpu_func.h
+++ b/include/cpu_func.h
@@ -100,6 +100,7 @@ int noncached_init(void);
 void noncached_set_region(void);
 
 phys_addr_t noncached_alloc(size_t size, size_t align);
+void noncached_free(void);
 
 enum {
 	/* Disable caches (else flush caches but leave them active) */
-- 
2.34.1

