Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A25FC5DF7D
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 08:44:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0841640930;
	Fri, 21 Aug 2026 08:44:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X97tEft8FBKd; Fri, 21 Aug 2026 08:44:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787301867;
	bh=h4zs1swzRe7yZuXEQhB8i0RkCH/Nzg50fduGQg9PyRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zZFOi4Supr55p+3fFpvwoqVm/VXE39UyA97u2oV0tajG4nLemW6CSxuCFNSVZE5vE
	 nRAgDTHaCtgkJnsxOV1dPSSL+btn5Q9nsH488qLPDYZfnvfWAyoo/AW3q5ghX374ee
	 P0bL5tgovQebsh8Mj3aOkMCp1bPUgjRXg2kFAe+tnNPnTleTgxMrsnd01gUp2p4lRJ
	 qc1WfCulS4m0naAq9v6FA9OoKvQCdXYiS9sYV3SiNGcpRw8u8lgHF7iHhwTm8CGIXA
	 y3TJMvub22WrfxtHginIo1pWwaymvgNka++TJU8WZK6tX5yrtywKwKhNZ4mvVdn2Vn
	 gnSFrDs5SBWng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 58C7240908;
	Fri, 21 Aug 2026 08:44:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id BAB274B8
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:44:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A100140908
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:44:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3X43gprgRqj7 for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 08:44:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.15;
 helo=sender4-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=SdtHl2/Y
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A8DC240899
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:44:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1787301857; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=j+uZ6F1aj4HmIoCEnIMV2sSvKOOd2yW94vvDVYR88DvgixU84bDi13CBAAiD4IQKs/CHYzlg4wgihA2dQr+bLAzpCYrpKzieg9iDza2KuyFKsnqjx+e/UJkM1wsQb93t7i0ZOkUoGLICzWdeKcISQtjAQs5btB+3D2laXucdxcw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1787301857;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=h4zs1swzRe7yZuXEQhB8i0RkCH/Nzg50fduGQg9PyRA=; 
 b=kHCKYuAxyl/+4C9GpGlX3PQkur99vv+oOfk2UqCtqJWrMYv+AfKlf2cfwMtCh5RkKRFdNWbQTiQyIVm23stHfB3pSWni2E4iXTOAtFah9TOQQAxjxNkwrNaTTT7OD2wR6oiHvrDW6jXQliLOUEtShnzo/fuavdRZKVCFytzl2vY=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787301857; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=h4zs1swzRe7yZuXEQhB8i0RkCH/Nzg50fduGQg9PyRA=;
 b=SdtHl2/Yrhbo7GhuNoxa5qtjdSyCEDmQGlGyHIyHbXnGvbxGFYJBfF/QKASMeCf5
 Kq3S8XOLP2gkt6DJVLapIhAJEkLRTJnWosW7pAcfZ0Y8mFjVhJO6yIg/IqodieH7rl9
 yRV/Cm9B3X9G+yv/tTE+VChDyO8Pvi+ilC3HjbvU=
Received: by mx.zohomail.com with SMTPS id 1787301854946631.7848218571696;
 Fri, 21 Aug 2026 01:44:14 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH v3 11/19] LoongArch: Generic platform type
Date: Fri, 21 Aug 2026 08:42:11 +0000
Message-ID: <20260821084219.1703743-12-me@ziyao.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821084219.1703743-1-me@ziyao.cc>
References: <20260821084219.1703743-1-me@ziyao.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

Provide a generic platform with some common routines expected to be
implemented at CPU level.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Yao Zi <me@ziyao.cc>
---

Changed from v2
- Select CPU if DISPLAY_INFO is enabled
- Reword the commit message, re-titled as "LoongArch: Generic platform
  type"
- Fix the comment for cleanup_before_linux() to note that cache isn't
  disabled, captilize Linux
- Drop unused DECLARE_GLOBAL_DATA_PTR from cpu/generic/dram.c

No changes since v1

 arch/loongarch/Kconfig              |  1 +
 arch/loongarch/cpu/generic/Kconfig  | 13 +++++++++++++
 arch/loongarch/cpu/generic/Makefile |  7 +++++++
 arch/loongarch/cpu/generic/cpu.c    | 22 ++++++++++++++++++++++
 arch/loongarch/cpu/generic/dram.c   | 16 ++++++++++++++++
 5 files changed, 59 insertions(+)
 create mode 100644 arch/loongarch/cpu/generic/Kconfig
 create mode 100644 arch/loongarch/cpu/generic/Makefile
 create mode 100644 arch/loongarch/cpu/generic/cpu.c
 create mode 100644 arch/loongarch/cpu/generic/dram.c

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 5654de5a58c7..c5ef82b583b1 100644
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
index 000000000000..7eae927b0003
--- /dev/null
+++ b/arch/loongarch/cpu/generic/cpu.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ */
+
+#include <irq_func.h>
+#include <asm/cache.h>
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
+	cache_flush();
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
2.55.0

