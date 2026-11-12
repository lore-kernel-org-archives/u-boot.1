Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224AC606A321
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 11:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=G3RLt9PA;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=SfDxaChy
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0113640D12;
	Thu, 12 Nov 2026 11:57:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0lYT-NRduO8l; Thu, 12 Nov 2026 11:57:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 27537406DE
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794484623;
	b=moCWb5/hOpdt0PX8nqj9V4yuV0QeoHIQHMLHZ6tuvPKWMuPs9WNSECg9/NZOd0/oEJxy
	 pPog1nUbBTal54E8tAjVW9g6OCj5q45IDwVB6CwMY2xI7ynp2+kLmjefwSXAatCXrosbD
	 5cNF/aL5U/xJUIJUzDLnpD8hhU/kKsj4XyHrb8HOH3RUPD/F8qE6htBZoPjUfrKEAXTFU
	 +Zh8sA5f2ptE5gDjSgkFFCpzG++6H8IfUjRShI8y7zDMLRK+4VK5HFMV6aOZtOuSKGCUG
	 Z2em0RbsrdK2+6r+KMsgxQxhsoNjEJSyLfJe75kW02c7QyMgLDWygi/d59uaKQPLCiw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794484623;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=IlfVkdmHO1KCAlG/AEyUBYpQDvJXjX/bulguR5sWQ94=;
	b=PO/dJY3Lket6O6SrttfktjaCkPrjlQ41R8mCJkNW0uLC2dS+6YyncvrhF3nICWXWGxfS
	 EGOqO/H2rJ0SKK5eN3HUsvLYM5aknsBTvNiWJVBPVhSWPLKCsIILD1LIYIvP3dgKOcrVX
	 qUgvfW8EoriFqqHkj5Y6ObHC8y+xb6cPJJcQ/6C9ifOWHGnLp/zYmSkXiZvs7yyvkmKVH
	 RHwtC3TRqCVp22V44CQXNNiifmwcUx0mcAeWikbmhOKPWwISt/K1RY623ITAUX7R4ohWF
	 12X89UsMAcRey8YnWaG5fmRIjSucOIZ8r7p13O6b+4waLbx4ifo9CvxRwwCDXZdyNgg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794484623;
	bh=IlfVkdmHO1KCAlG/AEyUBYpQDvJXjX/bulguR5sWQ94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G3RLt9PAuP9a/fRk4/pYeRvXF2DO/ZBDZwRH5s8ywc1Kj+KdFwAMye91pseO63XjR
	 KIqtHi7rxN3MGHpMDOc/KB7J1/j82go5bEcb6tLpTUan9BJ18kd4eqJZymWoBp8fB4
	 uESDnsIa7aFXS6pma9dJETcMylUTzyDg3QjOO7Xsp04nEm9X0+ShFe3PNXH+1rW6PX
	 WRjqWieIrajSpZ1EuKFWaQnMXrQkmsaPF/3Gua3q95NEUloBHG23G8BeglNhpDhhJc
	 h8QMAZZv0m1gDQ7G12yTB79roprIrKu8nbKqoYCnSuS9lNTk4Yc7pFpjnXTsbgl8MQ
	 7Qd9bz4K3D0sQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 27537406DE;
	Thu, 12 Nov 2026 11:57:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1B9BB1A6
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 11:57:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 01EF7403FE
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 11:57:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZoJu9x5LQmtI for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 11:57:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 50640401A1
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=SfDxaChy
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 50640401A1
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 11:56:59 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=SfDxaChyzkP2/g57FuP1i8goVGH5i6sKBuf70zrp5+DpHZM2y/U19i+Wg12KSvNtUrDjHcHV2a1JmMlgQLR7eQK8hjWLmS1o6LBYtNZsppmV0zDroqaQaxv0uvhUsO8krqxWgY6CV7tyOuTLNb9PEF7tGWMBfmmBZISlcAqi2Qk=;
 c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1;
 bh=IlfVkdmHO1KCAlG/AEyUBYpQDvJXjX/bulguR5sWQ94=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 179448461281441.4079894893913;
 Thu, 12 Nov 2026 03:56:52 -0800 (PST)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v7 11/20] LoongArch: Generic platform type
Date: Thu, 12 Nov 2026 11:54:29 +0000
Message-ID: <20261112115438.1837663-12-me@ziyao.cc>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261112115438.1837663-1-me@ziyao.cc>
References: <20261112115438.1837663-1-me@ziyao.cc>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

Provide a generic platform with some common routines expected to be
implemented at CPU level.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Yao Zi <me@ziyao.cc>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

No changes since v5

Changed from v4
- Avoid using LoongArch-specific cache_flush() helpers in
  cleanup_before_linux()

No changes since v3

Changed from v2
- Select CPU if DISPLAY_INFO is enabled
- Reword the commit message, re-titled as "LoongArch: Generic platform
  type"
- Fix the comment for cleanup_before_linux() to note that cache isn't
  disabled, captilize Linux
- Drop unused DECLARE_GLOBAL_DATA_PTR from cpu/generic/dram.c

No changes since v1
---
 arch/loongarch/Kconfig              |  1 +
 arch/loongarch/cpu/generic/Kconfig  | 13 +++++++++++++
 arch/loongarch/cpu/generic/Makefile |  7 +++++++
 arch/loongarch/cpu/generic/cpu.c    | 23 +++++++++++++++++++++++
 arch/loongarch/cpu/generic/dram.c   | 16 ++++++++++++++++
 5 files changed, 60 insertions(+)
 create mode 100644 arch/loongarch/cpu/generic/Kconfig
 create mode 100644 arch/loongarch/cpu/generic/Makefile
 create mode 100644 arch/loongarch/cpu/generic/cpu.c
 create mode 100644 arch/loongarch/cpu/generic/dram.c

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index ac4be2c837c0..1f376ca291c1 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -12,6 +12,7 @@ endchoice
 # board-specific options below
 
 # platform-specific options below
+source "arch/loongarch/cpu/generic/Kconfig"
 
 # architecture-specific options below
 choice
diff --git a/arch/loongarch/cpu/generic/Kconfig b/arch/loongarch/cpu/generic/Kconfig
new file mode 100644
index 000000000000..5fcc2156906d
--- /dev/null
+++ b/arch/loongarch/cpu/generic/Kconfig
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2024 Jiaxun yang <jiaxun.yang@flygoat.com>
+#
+
+config GENERIC_LOONGARCH
+	bool
+	select SYS_CACHE_SHIFT_6
+	imply CPU
+	imply CPU_LOONGARCH
+	imply LOONGARCH_TIMER
+	imply CMD_CPU
+	select CPU if DISPLAY_CPUINFO
diff --git a/arch/loongarch/cpu/generic/Makefile b/arch/loongarch/cpu/generic/Makefile
new file mode 100644
index 000000000000..c98d63b4f831
--- /dev/null
+++ b/arch/loongarch/cpu/generic/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2024 Jiaxun yang <jiaxun.yang@flygoat.com>
+#
+
+obj-y += dram.o
+obj-y += cpu.o
diff --git a/arch/loongarch/cpu/generic/cpu.c b/arch/loongarch/cpu/generic/cpu.c
new file mode 100644
index 000000000000..eb11f1349856
--- /dev/null
+++ b/arch/loongarch/cpu/generic/cpu.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ */
+
+#include <cpu_func.h>
+#include <irq_func.h>
+
+/*
+ * cleanup_before_linux() is called just before we call Linux, it prepares the
+ * processor for linux
+ *
+ * We disable interrupts and flush caches.
+ */
+int cleanup_before_linux(void)
+{
+	disable_interrupts();
+
+	flush_dcache_all();
+	invalidate_icache_all();
+
+	return 0;
+}
diff --git a/arch/loongarch/cpu/generic/dram.c b/arch/loongarch/cpu/generic/dram.c
new file mode 100644
index 000000000000..26cabc4b3ccf
--- /dev/null
+++ b/arch/loongarch/cpu/generic/dram.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ */
+
+#include <fdtdec.h>
+
+int dram_init(void)
+{
+	return fdtdec_setup_mem_size_base_lowest();
+}
+
+int dram_init_banksize(void)
+{
+	return fdtdec_setup_memory_banksize();
+}
-- 
2.56.0

