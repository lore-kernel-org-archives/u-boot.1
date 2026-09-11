Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1AA3C88E4D
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 10:48:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6CCA140BA2;
	Fri, 11 Sep 2026 10:48:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wWM9QJoZFMui; Fri, 11 Sep 2026 10:48:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9895340B0B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789123694;
	b=WBRr4WeImdB6H0HDaU8a3yD3QbmEjI+ByOvevNWN/fjhU5fKcDCJk7bVQ54yxzIjp0rT
	 jUvfsi/UAw9Pv0D8Yg7LcmRk46WYEQzki3LabfJ978FHOGuV+SbFkIABmts1xGXHqdCwH
	 Bul+H+ScFiTP/ICoFzQZZZcW7RRc9L5+HC6n7FRGbJ9YeBA4JriQOD+ODecnBn++hjgCm
	 Q3q/ORGZEtTTXBJR2scATTC/oDDJztP5GfmePOJuh8bcD3X50Av0afpTeO+PJz0oUuuCX
	 W4/jkuulg7PShhhexFEVKYlSYq90Cp0CgkdwFKt3+0dWIGapcAzysf7+oz3/6jPsaeg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789123694;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=M18bajYwiQ233I3VvGFeKCV2ZcE5hUyoapy6q16fP9U=;
	b=HxNjIoQY7XzRg4opk4DqVx5L31wqcO+h3gQejuqtf6QnNIgzTeIrdLoSyKO7DgLndX7e
	 OYmYs2tg0sJXRw0KDD5U/Cj0poZ7HEktGFoc0UeAoJo5Gs1XLRubHJme23MF0lVgQj14L
	 tQVVSlQbMlov+esypUemKAhmG/yQ1q3Kh1HCtAsTw9p6NdSLqpKrdmFCfNHlGLBVwQT9q
	 ODxWS4aGKy/dZp3z9NV24XhChyhmj/GkiX2Pfd3NZreaFl3wj/eI4bkIUQDuMBjTBMv50
	 2puVoNQt3+zENZZUIhF0h9PpqbgXJxqidsBtiZNOuGZBlqAHySJyvX0SwtG+4lO3y0w==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789123694;
	bh=M18bajYwiQ233I3VvGFeKCV2ZcE5hUyoapy6q16fP9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OZ7CqnMJPFGnh8W9PWJUZIRbDUTZbO4gyr/Tfw/TGuBH+vf0Rt4W9jXBEDLwmSehY
	 ar0ywLTh5Dsx220EmjyDJGb77MUB1nKV9nQM5FPdMzlzJdFPqIFCudd04nWLRAdiFd
	 Rr/waSGTbGBCRRN+a9LbD1HC+tpGGU4/hBDZa7P3SfSWvstxyoq2l/1eKxFkoixnLp
	 t6NhnZ0pC/M5NkogxJRdE0mUOMfdjB73VzvyhVk/lxWJoe8xQPW+OOtRXRFMTjA+dT
	 Knk6f0PdyIXA0QK6Yg2QhDkYsA7vuVCEF022NBoZ9GFp1YNu+0D3rmD4WZXejCkWzk
	 IOm43vi1OAneg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9895340B0B;
	Fri, 11 Sep 2026 10:48:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A70DB14C
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 10:48:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8CBCA40461
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 10:48:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U3blsgLr9C4M for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 10:48:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org C0F5740460
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=136.143.188.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789123691;
 b=AnYeNteZ3PtNKKk7+Zs4+cMfJhCwZk/ODKbK3HSgYPqcxTmZ/UkdoxrnKpUjyk+RX0DI
 cAGOUt1QiIuziLG5quCzHvL/wcFS19ZI5sJKrN6v3ZVf0LQgEFEBsgo5fvSCQJzlolc5i
 Nzx0Tc1kVKSoU9D7NNgvEleSWx5+5miNdpa94oWNpthMepl1h8ii0BmoKn8wyjIGKb64e
 uu6S57zmLPBHPT4L5IjH4OE0d1jwrv8oac3ixRTrOfE24Ndr8LpRUcxr5dzrpi63/BalC
 mbe7LsdPHd1pKXHMqAZYaXHlyg5TGmutWAjLzzA1j1klrccAHSpvhraY2g+2JlTh8Dg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789123691;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-ZohoMailClient;
 bh=M18bajYwiQ233I3VvGFeKCV2ZcE5hUyoapy6q16fP9U=;
 b=At/43GIV0SbMq8OnjTdR+c6QpiWgtWOwFejTn1oGrEBCrVq4W7nmXy8724W53xmBcvdQ
 7SkAr0zm2T+Ud2JTrW96OfajAoxRqEPgUrrPhoHw985lhYSvvwzNHH9EZ/dPe9CML5sQF
 pWwOFhsdtpMUUSnlTJ00OiXVSa3Ykwy6S962mJIvDvJgl8jgVEBMGOFDXFF43FuA/i5Qz
 X+LfjrhdWdb/z3HV7/1ZH00dlWM/tagubvynqNdgmZIF7HrMdpib510UHU+x98wrKgeSI
 YChUKooXhpQxXPqWL9J3nxeOSeyO0dtfVQnZimPVkDlVS+hmJ3OMJZ1z86+yiRCUwqA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=ziyao.cc; 
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=krXYu+RY; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.15;
 helo=sender4-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=krXYu+RY
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C0F5740460
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 10:48:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1789123684; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=W/6NRyR99By/HRhz1myesOgyXCn9wwoHiDrl1DKuCqhNTBkzQKr52e9dW5DW6hpZ55pfVvv51DSBdmhiEO3+6TkcEUZR/GrVnnYYkmelW7XzupJuhmXYtDUz49hh9E67NdNtwsnzbZSbK+HG+lU+n2N4bEA0/IZZVTuOZDq6RCw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1789123684;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=M18bajYwiQ233I3VvGFeKCV2ZcE5hUyoapy6q16fP9U=; 
 b=JJf9r7v900ebSuCunbR6wHY4rtFVIPix0/sV1GT6GVB+hsZUfTcCQnEDIK5BNnpeNevx6Ssh6mmAkoQJtZwJNNXVGk0Mk1nmu1XC21xwvJauikYEIWIhXvEN0AOz+QXcMWIBpKLxBljD7FM9prhWPBsnTlyYK3kU42ZV/xom/yk=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789123684; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=M18bajYwiQ233I3VvGFeKCV2ZcE5hUyoapy6q16fP9U=;
 b=krXYu+RYTMvy91PYKDSa8j1o2kDFCj2V4nz6WQLC8OlZq25acEKqkJui6iyfIx6U
 dV00cRDnf1FT1bgjVStaBq4KiBqHXgbH/OOrJxMCxTyGYR7FYoQ5l7+AJG1m5OhNjEa
 y6LVvmNz5DF+BC8CYAfhjhKz+UhWsRz5OWTTiw78=
Received: by mx.zohomail.com with SMTPS id 1789123682052829.564299512896;
 Fri, 11 Sep 2026 03:48:02 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH v4 11/19] LoongArch: Generic platform type
Date: Fri, 11 Sep 2026 10:45:56 +0000
Message-ID: <20260911104604.2910944-12-me@ziyao.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911104604.2910944-1-me@ziyao.cc>
References: <20260911104604.2910944-1-me@ziyao.cc>
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

No changes since v3

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

