Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DECEBC88E4A
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 10:47:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9E98140BE8;
	Fri, 11 Sep 2026 10:47:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6NgZ_LqfS1xK; Fri, 11 Sep 2026 10:47:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7F8DF40BAA
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789123651;
	b=hkxa5yY5qcFvCy03F5rlChWIUPDPv7ILGlFL26pUFaBKgSv1fyza8E26fPFq/zRO0Ylw
	 ZDoAS+0cJH67HMOgsZms7ZckK2KGABmZ7Zqka2CVEED3O5NiuVrDjJ7yEuWUYfTwlqpXO
	 EnLsmOpukyhC00d8gGD3YnLh+/rcjIxDAklYuIgt8XVo+BY0wN8qRaPv/q6GzIBglwKwO
	 MIi+AJz3I06RiP/qDPWV2jE5NtAnScyBKnsOeuGKSgJ/8LBguIxgE+9cQiCqNJhmtLmI0
	 E6vXMxE/pXKsZ+M/RsrEXF6JbB2P6XgD46azSn4yYlQeNSoGcSO1QZOG4ggTQ1CXTFA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789123651;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=xq8/q2IKPn3uROVL1umfky/3ZIAYGv7ALd/HCWIrL8k=;
	b=nngtLjGQRHZ5nEL1FBz0J7qEE8DD4hEcAHWhhMICkNJ8vk6EAk3G3/ooZ3ZbZm81Rbw5
	 Uzb9e3xyGVJlx/JSyJk3C17OnYf+F7tfBtU13Z5S0mcKwBEQq6h+eVqtRfX/oruqQ9nFa
	 Z7gyGsJEThU9Y9DQTE0cy5MMObTfblTnrGluAJEaF/26//AaSuH7SAFPKupmZnjrEeoJb
	 YbSz6d6EKqnBY9y7W9vnuORYv7vLGFp4kRJg9KlFjenmElcPec6kS6csr6ENBqZvtsHO2
	 LIj4k0lvuerZNh9FU4HzYuy4jBIbhPecxChOiaRvoyHg7z01qkc08nhEaeeR3ee5a6Q==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=ziyao.cc;
	dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=TCsr24nA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789123651;
	bh=xq8/q2IKPn3uROVL1umfky/3ZIAYGv7ALd/HCWIrL8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qm0/GDQt8pANfMFz+RPz9WI8CI1ssr0OD42pYqsbrkTVoGIylDCxi1r7lOC24ANqo
	 +VIaqkFIF6A8Hp9HKNQztAULOJakQo9tv3i6gBC2ZiJ0v4t8uG07Ech20+lkgCdWQE
	 Kje7qUypFUjUKcXYI9RCqtIcMXYENlkiMrCU3i1ItlkIkfmevk9cEN+g57heUhaQOt
	 N1byK110ID9dZLxd3h1CQ84AvUChxr3MlRnkd/zy4KMCI57vp6xVgx1YS4Wt25RiSf
	 dzn5FNjLxOWrkA3PqkBqO9j0jtlK3r2WlNXD+xLJk98k7Y9xErPvulU+AnO7GzxlkA
	 R88e+HolTIEfw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7F8DF40BAA;
	Fri, 11 Sep 2026 10:47:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6E72749D
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 10:47:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 548A140BAA
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 10:47:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gPdWiAXdYYJA for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 10:47:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6B42A40AF6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=136.143.188.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789123648;
 b=aw7XQM4AUT5P2tOLecY4L1ScsxYwBCyAXQnCTe58N6ywdq3orHVkcn/9RWDF6ggWHK+h
 RfErz0ocNYF5XZElObWqa/CszFSGLs5Thjb9UYLan2/c8zp0b9OOIxdv2nt9beLIePo7n
 P9QQ2qKXMYBZzFEyB+RMhO/1Pi98vHYLINZOpTrXAzFdURy2HB2Bba0Xvsawd44XcqpSn
 OkFBuls7JITzOoQxcfL+hIUhJDzn+NzBqO/pA+Woz0K/hJU42MTIntmaFT/hdVxOp4Ahz
 lit4v/vcglEGh3JCjuY9aPGA7rVS56uZVW46qcgyIDPNMrkqh+9YjZ7tO6kZBex+r7g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789123648;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-ZohoMailClient;
 bh=xq8/q2IKPn3uROVL1umfky/3ZIAYGv7ALd/HCWIrL8k=;
 b=pjT1HmHe6goVqTt2gCAjT3k3y9XgetAM0OVWPv2Az4VSkyfX5KA98rAldEGC62ZVlGcY
 GsVvIWdL/F+nwfRxgbY9JkVjVY7D64yJrshDB1tGs1b3mA58l3WAmuvYpW0SZGvu5mkCS
 Qw9eNHMLmSeKIwzoWvWWmt1uY8fBM33jU7jSIzoAL8+rL3lP+LC5HstKIQkdZQAoWl5vL
 Zt9fbNPNWX015teDRm3WuNLn4tnWXD4p8a0v+zuJMWOVFkcgmcR0BQ7GTsHFzzzqP3qcU
 FanxcLUYap25OnBpYFxvAvu39mPu+d8uwdaacfn9jzFoOEbXRb0zYMIbgHvX/j8usYA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=ziyao.cc; 
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=TCsr24nA; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.15;
 helo=sender4-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=TCsr24nA
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6B42A40AF6
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 10:47:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1789123642; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=XaG3NFfFYhejXo9ZZQ9+f6hDOrtpRD8nxftV0XQ2QT6xu6CyUfOFZDMLgiMvdS41rbqa9HA0TM8/ogaRX8xC/pixBYQ3MsB5DqNVzMMt5JDjq457UMBFmI/ok7CPBsJP1b4ZRRAvuXSZNfNM5alSoLR9NFAw0YmEQSrRrpr4ePY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1789123642;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=xq8/q2IKPn3uROVL1umfky/3ZIAYGv7ALd/HCWIrL8k=; 
 b=F0+Ow+ajDRw3iQBQBQSClRp2aYaikBBXr7MmlpkHAmXeoa1PYVBkb5+t87U0zNeSgTjip3GVMofMECPniJ2icZbBXSMH1ViNK/Vpmqo7FsfBK6PY2K8ZlYyGVgBpr7tIVLEd7zUohxYLs8dbTmjOt0u0blrXGRh7r6aSx8qvH18=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789123642; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=xq8/q2IKPn3uROVL1umfky/3ZIAYGv7ALd/HCWIrL8k=;
 b=TCsr24nA5qY1qZ6RdBcmKugKcEtFFLZ2WWTIc7vGJPiBfKg2G24ZK1oHF/4b7HH2
 1zj27xNCit83GS+06q9pK0srp76sV5JXHRkMkRjxYqt8d9IF8UBoh2pnTXohjZo1oLb
 tvWcGq8VClmZ0PT2hwmzi8sCfVysLfbIOJHxj0YA=
Received: by mx.zohomail.com with SMTPS id 1789123640303280.7615339092905;
 Fri, 11 Sep 2026 03:47:20 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH v4 08/19] LoongArch: CPU assembly routines
Date: Fri, 11 Sep 2026 10:45:53 +0000
Message-ID: <20260911104604.2910944-9-me@ziyao.cc>
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

start.S for initialisation, smp_secondary routine for
a spin-table like interface for secondary cpus.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Yao Zi <me@ziyao.cc>
---

No changes since v3

Changed from v2
- Add copyright to cpu/cpu.c
- Drop unnecessary includes from cpu/cpu.c
- Drop "resetting..." message from reset_cpu()
- Fix misleading comment about t1 in start.S
- Remove "move sp, s0" after board_init_f_alloc_reserve from start.S
- Clean up whitespaces in start.S

Changed from v1
- Replace t6, which is volatile across C function boundaries, with s5
  to hold relocation offset in start.S
- Fix typo "CLear" in smp_secondary.S[

 arch/loongarch/cpu/Makefile        |   4 +
 arch/loongarch/cpu/cpu.c           |  17 +++
 arch/loongarch/cpu/smp_secondary.S |  55 ++++++++++
 arch/loongarch/cpu/start.S         | 168 +++++++++++++++++++++++++++++
 4 files changed, 244 insertions(+)
 create mode 100644 arch/loongarch/cpu/cpu.c
 create mode 100644 arch/loongarch/cpu/smp_secondary.S
 create mode 100644 arch/loongarch/cpu/start.S

diff --git a/arch/loongarch/cpu/Makefile b/arch/loongarch/cpu/Makefile
index 3dbed94cc624..d3c38a16d057 100644
--- a/arch/loongarch/cpu/Makefile
+++ b/arch/loongarch/cpu/Makefile
@@ -3,3 +3,7 @@
 # Copyright (C) 2024 Jiaxun yang <jiaxun.yang@flygoat.com>
 #
 
+extra-y = start.o
+
+obj-y += cpu.o
+obj-y += smp_secondary.o
diff --git a/arch/loongarch/cpu/cpu.c b/arch/loongarch/cpu/cpu.c
new file mode 100644
index 000000000000..38005d576458
--- /dev/null
+++ b/arch/loongarch/cpu/cpu.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2018, Bin Meng <bmeng.cn@gmail.com>
+ * Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ * Copyright (C) 2026 Yao Zi <me@ziyao.cc>
+ */
+
+#include <hang.h>
+#include <stdio.h>
+
+#if !CONFIG_IS_ENABLED(SYSRESET)
+void reset_cpu(void)
+{
+	printf("reset not supported yet\n");
+	hang();
+}
+#endif
diff --git a/arch/loongarch/cpu/smp_secondary.S b/arch/loongarch/cpu/smp_secondary.S
new file mode 100644
index 000000000000..4ef4b16a3fb6
--- /dev/null
+++ b/arch/loongarch/cpu/smp_secondary.S
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Loop to run on secondary cores for LoongArch CPU
+ *
+ * Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ */
+
+#include <linux/linkage.h>
+#include <asm/asm.h>
+#include <asm/loongarch.h>
+#include <asm/arch/entry-init.h>
+
+ENTRY(secondary_core_loop)
+	smp_secondary_setup
+
+	PTR_LI		t0, LOONGARCH_IOCSR_MBUF0
+	LONG_IOCSRWR	zero, t0
+
+	/* Enable IPI interrupt for wakeup */
+	LONG_LI		t0, ECFGF_IPI
+	csrxchg		t0, t0, LOONGARCH_CSR_ECFG
+
+	LONG_LI		t0, 0xffffffff
+	li.w		t1, LOONGARCH_IOCSR_IPI_CLEAR
+	iocsrwr.w	t0, t1
+	li.w		t1, LOONGARCH_IOCSR_IPI_EN
+	iocsrwr.w	t0, t1
+
+	/* t1 for spin table */
+	PTR_LI		t1, LOONGARCH_IOCSR_MBUF0
+
+1:
+	/* Query spin table */
+	idle 0
+	nop
+	iocsrrd.w	t0, t1
+	beqz		t0, 1b
+
+	/* Clear IPI interrupt */
+	PTR_LI		t1, LOONGARCH_IOCSR_IPI_STATUS
+	iocsrrd.w	t0, t1
+	PTR_LI		t1, LOONGARCH_IOCSR_IPI_CLEAR
+	iocsrwr.w	t0, t1
+
+	/* Mask all interrupts */
+	LONG_LI		t0, ECFG0_IM
+	csrxchg		zero, t0, LOONGARCH_CSR_ECFG
+
+	/* Jump to secondary core */
+	PTR_LI		t1, LOONGARCH_IOCSR_MBUF0
+	LONG_IOCSRRD	t0, t1
+	/* If we ever return, put us back to the loop */
+	la.pcrel	ra, secondary_core_loop
+	jirl		zero, t0, 0
+END(secondary_core_loop)
diff --git a/arch/loongarch/cpu/start.S b/arch/loongarch/cpu/start.S
new file mode 100644
index 000000000000..fdf3697834f7
--- /dev/null
+++ b/arch/loongarch/cpu/start.S
@@ -0,0 +1,168 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Startup Code for LoongArch CPU
+ *
+ * Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ */
+
+#include <asm-offsets.h>
+#include <config.h>
+#include <elf.h>
+#include <system-constants.h>
+#include <asm/addrspace.h>
+#include <asm/asm.h>
+#include <asm/loongarch.h>
+#include <asm/arch/entry-init.h>
+
+#define BOOTCORE_ID		0
+
+.section .text
+.globl _start
+_start:
+	/* Allow arch specific setup code for MCSR stuff */
+	entry_setup
+
+	/* Disable interrupt */
+	LONG_LI		t0, CSR_CRMD_IE
+	csrxchg		zero, t0, LOONGARCH_CSR_CRMD
+
+	/* Configure reset ebase */
+	la.pcrel	t0, exception_entry
+	csrwr		t0, LOONGARCH_CSR_EENTRY
+
+	/* Setup direct map window for later use */
+	PTR_LI		t0, CSR_DMW0_INIT
+	csrwr		t0, LOONGARCH_CSR_DMWIN0
+	PTR_LI		t0, CSR_DMW1_INIT
+	csrwr		t0, LOONGARCH_CSR_DMWIN1
+
+	/* Branch out for nonboot core */
+	csrrd		t0, LOONGARCH_CSR_CPUID
+	andi		t0, t0, CSR_CPUID_COREID
+	LONG_LI		t1, BOOTCORE_ID
+	bne		t1, t0, secondary_core_loop
+
+/*
+ * Set stackpointer in internal/ex RAM to call board_init_f
+ */
+call_board_init_f:
+	PTR_LI		t0, (SYS_INIT_SP_ADDR & STACK_ALIGN)
+	move		sp, t0			/* save stack pointer */
+/*
+ * Now sp points to the right stack belonging to current CPU.
+ * It's essential before any function call, otherwise, we get data-race.
+ */
+
+call_board_init_f_0:
+	/* find top of reserve space */
+	PTR_LI		t1, 1
+	PTR_SLL		t1, t1, CONFIG_STACK_SIZE_SHIFT
+	PTR_SUB		a0, t0, t1		/* t1 -> size of one CPU stack */
+	bl		board_init_f_alloc_reserve
+
+	/* Set global pointer to u0 ($r21) */
+	move		u0, a0
+	bl		board_init_f_init_reserve
+
+	/* Probe and enable cache */
+	bl		probe_caches
+	bl		enable_caches
+
+#ifdef CONFIG_DEBUG_UART
+	bl		debug_uart_init
+#endif
+
+	move		a0, zero		/* a0 <-- boot_flags = 0 */
+	la.pcrel	t5, board_init_f
+	jirl		ra, t5, 0		/* jump to board_init_f() */
+
+/*
+ * void relocate_code(addr_sp, gd, addr_moni)
+ *
+ * This "function" does not return, instead it continues in RAM
+ * after relocating the monitor code.
+ *
+ */
+.globl relocate_code
+relocate_code:
+	move		s2, a0			/* save addr_sp */
+	move		s3, a1			/* save addr of gd */
+	move		s4, a2			/* save addr of destination */
+
+/*
+ *Set up the stack
+ */
+stack_setup:
+	move		sp, s2
+	la.pcrel	t0, _start
+	PTR_SUB		s5, s4, t0		/* s5 <- relocation offset */
+	beq		t0, s4, clear_bss	/* skip relocation */
+
+	move		t1, s4			/* t1 <- scratch for copy_loop */
+	la.pcrel	t2, __bss_start		/* t2 <- source end address */
+
+copy_loop:
+	LONG_L		t5, t0, 0
+	PTR_ADDI	t0, t0, LONGSIZE
+	LONG_S		t5, t1, 0
+	PTR_ADDI	t1, t1, LONGSIZE
+	blt		t0, t2, copy_loop
+
+/*
+ * Update dynamic relocations after board_init_f
+ */
+fix_rela_dyn:
+	la.pcrel	t1, __rel_dyn_start
+	la.pcrel	t2, __rel_dyn_end
+	beq		t1, t2, clear_bss
+	PTR_ADD		t1, t1, s5		/* t1 <- rela_dyn_start in RAM */
+	PTR_ADD		t2, t2, s5		/* t2 <- rela_dyn_end in RAM */
+
+6:
+	PTR_L		t5, t1, PTRSIZE		/* t5 <-- relocation info:type */
+	PTR_LI		t3, R_LARCH_RELATIVE	/* reloc type R_LARCH_RELATIVE */
+	bne		t5, t3, 8f		/* skip non-RELATIVE entries */
+	PTR_L		t3, t1, 0
+	PTR_L		t5, t1, (PTRSIZE * 2)	/* t5 <-- addend */
+	PTR_ADD		t5, t5, s5		/* t5 <-- location to fix up in RAM */
+	PTR_ADD		t3, t3, s5		/* t3 <-- location to fix up in RAM */
+	PTR_S		t5, t3, 0
+8:
+	PTR_ADDI	t1, t1, (PTRSIZE * 3)
+	blt		t1, t2, 6b
+
+
+	/* Update exception entry */
+	la.pcrel	t0, exception_entry
+	PTR_ADD		t0, t0, s5
+	csrwr		t0, LOONGARCH_CSR_EENTRY
+
+clear_bss:
+	la.pcrel	t0, __bss_start		/* t0 <- rel __bss_start in FLASH */
+	PTR_ADD		t0, t0, s5		/* t0 <- rel __bss_start in RAM */
+	la.pcrel	t1, __bss_end		/* t1 <- rel __bss_end in FLASH */
+	PTR_ADD		t1, t1, s5		/* t1 <- rel __bss_end in RAM */
+
+clbss_l:
+	LONG_S		zero, t0, 0		/* clear loop... */
+	PTR_ADDI	t0, t0, LONGSIZE
+	blt		t0, t1, clbss_l
+
+
+/*
+ * We are done. Do not return, instead branch to second part of board
+ * initialization, now running from RAM.
+ */
+call_board_init_r:
+	bl		invalidate_icache_all
+	bl		flush_dcache_all
+	la.pcrel	t0, board_init_r        /* offset of board_init_r() */
+	PTR_ADD		t4, t0, s5		/* real address of board_init_r() */
+/*
+ * setup parameters for board_init_r
+ */
+	move		a0, s3			/* gd_t */
+	move		a1, s4			/* dest_addr */
+	move		s0, zero		/* fp == NULL */
+	jirl		ra, t4, 0		/* jump to board_init_r() */
+
-- 
2.55.0

