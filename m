Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77A8FCC6B38
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 06:57:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2B4BA4097A;
	Fri, 16 Oct 2026 06:57:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Oqqda6plnf58; Fri, 16 Oct 2026 06:57:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5AE5440980
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792133857;
	b=XeoeNJL9BvBH3UP6Og3jSd9eAQ7iPcMRvUCadwCENl8uUcJs66BsKvWQSvzaedLYVC/j
	 fsCxhW1qUAAdJz95OU5eG7I/SxXibrzFXjzJqGWgqT3UKQ3lchW/xleEIcRzUspBbHT5O
	 EXxDL6gBZqz07AaZW2Cf8dGuVXCdIXvEUeQco6ZpvLfyLfWsMVj944HJemTNLYyBDuX0R
	 Fo0H7rNSoYFtcIiT6oF5PcTSC1UMlvpGVW8vjfFcE6YxPbxRwn3kA2m6J7QCPNj5zVRvj
	 M94TzlLyxG3cr8UG35ZW19slCf2zCd2JHTzQHcs2uGX6Kjo0Dj3Tsb6QNOVyA8Epu0g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792133857;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=+DXrfk0cI3lkLjhR4yhFYU1RCFSMkBcZkYB1/dbfszo=;
	b=NdUIIdRqRLVDdsngylzcyVgP8sKGHTx71PEs7w5T0yhwZJPMFtgVZqlfNs0Z9QB337iY
	 juh/4rb9iD/OWFSX6QfuVa75Z7AGZ+vqGbI2F0HK+L5fYws/HnPHA6KychFK1W5YJorZS
	 xDRiuSQ523UJxq1DB8h27E95HIpdpr7omrjB+sSRNMEPUqeTtjTkYTL+ZSfycSj6FdWf5
	 +koN0HV5fKf6yvmd1ze8qpEDhm43j7dG3VlAxykQfXitF3YGV0Vx09GuvQ4Eso4F1Fu3L
	 GkS1cj1P9yNivXa38R7mdepvSMxLCJx48U4+dfwXCJKTMDdMUbh8zJ5CYalXUKpMpuQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792133857;
	bh=+DXrfk0cI3lkLjhR4yhFYU1RCFSMkBcZkYB1/dbfszo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UNSx5ssjSBDSm/eTN5U2dZfvAys9+2482/l2i0UmSoTyj055YaBvD8biSAd6rTqWd
	 dn9vKMl5Cmkbdj0LSVlqEZaxgaHOMzItWwUHpMuoCssH4mSg09JL2EMTtOqXewwoxS
	 ZCIGicWHknrKI5rM+neyBlWCJjIijob+p45edSbdBK6XXUzjetkxIyA+xE3masCK74
	 6GHcWJmwpUL91pMuZsjoFtO2W8rAQiCIHPAyv9YbIXcIxEv4vHNWkEIlPvmgbK7nF7
	 wcSuMOq9xhPXdCpR8X2uhBWUkNBDL0bGKDaDYchgnxQfSOBC938dNLyfTz92T4f/c/
	 AtCKy9+5P2E3w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5AE5440980;
	Fri, 16 Oct 2026 06:57:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 649DA105
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:57:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5378B4009C
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:57:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n4ANn8EuFY9Z for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 06:57:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 8BC1840050
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792133855;
 b=AoJl3mmTZIExH93KU8naN9VARjwqOxDdlV6KND97jVuIGYASRsdFV51ZirgeXsgxY+XI
 DShknspdtMeaEqQSkfkdxvdieFD7JnD5nXpV3jb4EW49C8n71E91bsTZkNcYGNISwuFau
 FkTXokUMSbJW384m/MdduyXVFJOnt84fCkAgTWWkRJC9UODYRXuA7Ay/mroIeTFbnvgab
 V4vIhO7ImGGfSVsJ5wzNXz4DUZJUr5phYA76HB2JYkBLRn8pUewDUGKf2JkFNP0ScMKM/
 91ttPUfp213lGZy0+jI/YmgYMy5oFDmICI3KotY7C2BMZhWjJF/xwkIlT+UZOuMgMFA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792133855;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-ZohoMailClient;
 bh=+DXrfk0cI3lkLjhR4yhFYU1RCFSMkBcZkYB1/dbfszo=;
 b=gnx8TRA5A4EBbxBjefn7VlAzlMrwa/ac6Vm96Fx6wMB/+I7kx/RsiPIDoY5wndCkmeFm
 ZUebKemi7U7KsKJmDpWE5TtGOW7UOc2scaGJel+GADcK6gcXxnjEADgUUjT3dvAf8qp97
 0IDZGIzAOgmIWXKT9rFZYBvbUZz7sQMbX9ZduPHHyjhfUxGgfhvkgAzNjJAmwfkW3CkMx
 ESsl7oTMTFQmUidv40k3ZO8jzk0LO8mfPom7FBtZqe8f0UMndpXL5rJH5tdZZQjbmbCi4
 1zjtddf/8MXinKZTvnusOX+begqwHwHCuPmBJy2X5fTYSc8JeYWRj6e94ts23xowbDw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=ziyao.cc;
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b="a/ZoK9Tr"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=a/ZoK9Tr
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8BC1840050
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:57:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1792133849; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=PWGCHwdP2dMEat8y0TXBxrXVfGt4gplu5maA7mVjh+V5X3pjeV9JVTL5DV9QUJfEbrNXgdvV10KVn24g8Ny32QblBovHwzzl5qpWZgc32ryizYmx4HjtntE+0JgQWhCrqjQvLsS1AJdGT+iEcNv0pvcD5L/3FQmX8tOffGkX7Wk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1792133849;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=+DXrfk0cI3lkLjhR4yhFYU1RCFSMkBcZkYB1/dbfszo=; 
 b=nsnXOfC29Io10IjrBkqXdke/ZH04gO7vzjnU+fMC9Em5u3F3s8VaiBw9PA8DVcjgtAkFPVG0z/mVPBZ+rnsqFXz4ZmDt9lN8MubhACuWqnpMsWlJD44hTFZpqysQhRrmvmpvMEZSkeTIddb+FRu5FsZePvpxQ0FT3khzATr7gKs=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792133849; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=+DXrfk0cI3lkLjhR4yhFYU1RCFSMkBcZkYB1/dbfszo=;
 b=a/ZoK9TrUhf23IdKfonr10a1zcZVgY0kjGNus58W9C7y/VD9J2UzKa5koCGtkgW6
 En96yTK0rGFLogiGqPg9tszgZogdwPqR5uV21Ifr5fqr5LTtM8T14hq9bo9YpySiILJ
 kYFVCRIUZ17aWEOYIjRjyikgvJFop3yEHn7MEcR8=
Received: by smtp.zohomail.com with SMTPS id 1792133847497178.2835246027264;
 Thu, 15 Oct 2026 23:57:27 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH v5 11/20] LoongArch: Generic platform type
Date: Fri, 16 Oct 2026 06:54:51 +0000
Message-ID: <20261016065500.137544-12-me@ziyao.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016065500.137544-1-me@ziyao.cc>
References: <20261016065500.137544-1-me@ziyao.cc>
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
2.55.0

