Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82E6606A31D
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 05:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=sk4o0pca;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=TjQiphzG
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B1151606E1;
	Thu, 29 Oct 2026 05:09:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NxydWxAFdMjS; Thu, 29 Oct 2026 05:09:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 914C0606CA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793250560;
	b=WG5vzYRhyI0twjSP+QEPQ5KNR392Cc90RQm3ykWlEMW+eKchUngHyxBQcgOo+Qf7/GGn
	 I2JKHdYV0SW1lJTaIzCQB3VpAexCo+/6LNCv+hAcJgozyAingKS90Giciie1xHCu49M4X
	 iABKKxWa90Hs9Av5ZC/sYeQuFdkubiQOQ0uweLVXYr21nE8UCF4VxIMC3r9leGEgVibWg
	 YQX5CZl9TDaCXYfRV47iqR/paf0nucsCpqlWjX1Pfig4jP+Snazve8B+/R34Alf+mrhq1
	 MErkJeNrTIVUOa3/iQMyWo9LwU8P+v/7y9yjrXzUFh8C4HKbclf7xjl6rrpMQtOMbWA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793250560;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Q5p4WqqWxTbkdI8xVDuaNDzNRi1O+DhI6DGrEuKcTm4=;
	b=jPqaA0aN89Qfn0TRjh+tn3q/1SwWs5hoylaz7s0PTCtj9GgV0P8XS0oJPYdAOskCOrlw
	 bMP+xmFv3oPy23B/XDgveVZ3FTPXeHDolCL48YzSuFBy3Xt2hvSwur64qYBkZyrX6wr2D
	 S4XHFH3dROMJB6pt8ZQuIw7XSeDnqnIM6WeHpvgl6t89hHOdxriwoRdD+J96dfDPT62S2
	 3w4HDXzh+cgRctWYz79ea5Vqk8pOFIJmwRZ0m1oXvgrs8SQQyudCX9dgagtCCgW5BAZ+y
	 +vEp9dcpW6EE1OD7elOpwk/y4Jib0VLaaS3/MWdVaKnq6juiq7wTM7huSSUewitPGgw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793250560;
	bh=Q5p4WqqWxTbkdI8xVDuaNDzNRi1O+DhI6DGrEuKcTm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sk4o0pcaPD81sNTirDzwbdNd+C9RW15QnGBkdXR87zqQxyWRF/se6jeKANtUI5jLw
	 P9JfUOK6DdJ2Cqg9hHLoC2RDXFfbQNtfrQw6GrxVXAz+QBvifbQ4rkRaGUf93CDetA
	 iSlm9ybHjelpusRQUk+sw34lFqaNI+1ve6elcOKFvLLGu/UCMIIWauccEaqsY0j4UC
	 4cfyEPZ0Cv/dPoAd+POfP88I1uK5EMAwo+GxRaoiMipE3l+hb3uPZ3JPF+NwxBQEI3
	 Mt0oFgpi7orRRKODidIS7r3w4YnAGCnK2i8f3foxe8ZfZl5CwU8nzgltfd+Dg9yTrp
	 a6t2QmVl9BWZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 914C0606CA;
	Thu, 29 Oct 2026 05:09:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6BFEC235
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 05:09:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5DE7E80F7B
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 05:09:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pddOSzQhJ5Ca for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 05:09:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 62FA480F71
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793250554;
 b=iwx8IDplT7ho9Sy1Ap/95In/S0EeDCsFD3sYQReWLmu+kpu6dDXxiPt/K8MiqfaRFocs
 EH3bBgIWqAnVO5qSgJZkuLnBMj8naCLDWEJTQxRHy6QpI+b+ytPI5iV+2rDalK3XsMIuQ
 HBKgKe87V5UUPPUAGcEBhHStgrbykrwn7cURXU54mhF2t8ArIi0pWwBEdg6JSMArIAHBH
 Lqiy2Qd9l1uDQBvh2NMbUOANlV9yMXEZ0eTfaACNvZPsJ/gsh4o/QwSRCj4sc9CKj8Vh9
 mwJB0SxnKU84+T274IDrdqcb3HJfKkIOMT9YxeIBJITmiM4OtD/31lPdj/Rys4fQefA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793250554;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-ZohoMailClient;
 bh=Q5p4WqqWxTbkdI8xVDuaNDzNRi1O+DhI6DGrEuKcTm4=;
 b=jFlTlJNULNvaL2fgdj3IkDIHmbE04IhV08odTqEUVqgf9DTZZwwKY8NEsb0xFY0Ckw3x
 Z/7e2Y2le/nUZ0CeDwfhhJNvDr8iAjc8LrP8P2dHsJ7B0o/LIJsL38HhPhi1wzylCJ5wO
 kttHP4IVCaa6Ru0RNVBRnQHmfdTlNRq0rp7xpoocRnwzVGL/I/sYUXQkXJRwZWTSc3vnK
 aZ/GsMMBoqJibckI0jChJvfdWPYnsaZXb8vHjDwf4MZOyVYffwBjxmtFg51IhsCqqSDAr
 7PalfyPi+oHrQELQtTkDDOHSUtJbT3lFD/nxCqemXbouefQQydaF0eNxaEAqfUDCB9g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=ziyao.cc;
 dkim=pass header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=TjQiphzG; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.15;
 helo=sender5-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=TjQiphzG
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 62FA480F71
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 05:09:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1793250547; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=UCxuHQGbLmyXVDII9GXX5xu63gsSiIcokLuykuK845wnNn9cHR6yPDrFpLqehmx7A+QVLsMUHSfZxRTZAo6hZcxKJ2/75L6kzyoPswxWF3i1mtmCCuB1D6Id/eXaZNCSNVsLMLkmH+qqXUDADtZD9SCrs5ApH0skd2RRQpm17+c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1793250547;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Q5p4WqqWxTbkdI8xVDuaNDzNRi1O+DhI6DGrEuKcTm4=; 
 b=Gtg/P/LQ/OGx7oqDZcXb8Fza602fmjYm16bsLtCRHBWXqSRxNKb1Iqoe3SJddetYToYlChi14RhYA18XZXE8aHQlY2KGIAEaq5opXPx5Fhk8De0T3YFmRjlsZQ6orPLjUED4x98goErkMXd2oc3eiS6bz0UKt5tAqqA5aKbTrTw=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: a=rsa-sha256;
 b=TjQiphzGRxnVm1QhjI/HoE2oiCj/2NxOguP1IcWiwCOYXdiNy/W4M3OXbdYtT9H0W8+T5vAQJKIHlwRR2VkJSqYRS0ILUrEVV+vHV8eVeGAHzftFafcENKRZjyFufDG8JY9qdVWCm/Vve77Gc/UHI7ePiD4+AaU+RXW728O599M=;
 c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1;
 bh=Q5p4WqqWxTbkdI8xVDuaNDzNRi1O+DhI6DGrEuKcTm4=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793250544343889.8863580121985;
 Wed, 28 Oct 2026 22:09:04 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>
Subject: [PATCH v6 08/20] LoongArch: CPU assembly routines
Date: Thu, 29 Oct 2026 05:07:25 +0000
Message-ID: <20261029050738.1107663-9-me@ziyao.cc>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029050738.1107663-1-me@ziyao.cc>
References: <20261029050738.1107663-1-me@ziyao.cc>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
- Fix typo "CLear" in smp_secondary.S
---
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
2.56.0

