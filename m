Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02127606A31C
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 05:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=N1fES74o;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=OMIgylLv
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CC06C80F7B;
	Thu, 29 Oct 2026 05:09:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iwbmf6OnGSlb; Thu, 29 Oct 2026 05:09:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EEAB380F7A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793250555;
	b=MQe5bzmcbc6cD/g6BfHYmmq+xcGuvOlDx6gZ3odB9UEDbvpr6bbVV3HWd00VmTDnUgjB
	 LtsYzv/M7AYHcYA3TBKQeim+dEKOLjkd5xWtE02p6DxBlbPP+iA+NjMy5bOeDK+34Fllx
	 BdorCbm1LfjM5GE9avRUAhD8V75G8IWDxb03ELldVkM1OTii54LkRYo8zTDUt3q/ijxWF
	 BPWSnIFC8qVEE8uE9KIVBiS9Hd/h2yTFAHDVWdXQioC+DwLhW7vbI423zTkgJdeice+mZ
	 vO2YIllmO9airiMba9lgt6aD5b/HheFAGHphVsQUy84BBaVRb7+blVPhnXBIWQd0inA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793250555;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=DUDZTAYLYXxL+u7tpwXHCkyE2g9Jdd8woQFsHV7LHI4=;
	b=fs7GkMoIrCLjvQys9DQLgLBzZ2hSmQ0hDGXXyZQrArK8t+00jbF1t2CK4ctVTj8pjtOG
	 oEcxsK76txP5amiQwzWRkw6u9GczWMaIEK+2Pb7l9VZxBXk+bpO69mxL/dXj6lmpWkp9m
	 sMbuXLaJq+5QzOwLfPaNJVqxOqNb6oNBeLGrJkE4OFMWVDZOrGDpORf9k4R4zkHXp2K8A
	 yNKA4YoWYl9xgEu0txw+wttq7knzBmwnvhelk0pCbGj8t3zDHvw0v128oOWslQnh09IuM
	 3uVHZ90WTKPHU4QOY+ryCDDmnZxBRVC/4j8ITZ4S8yMeOZcwgC7wCRavyQ1RGTzdq8g==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793250555;
	bh=DUDZTAYLYXxL+u7tpwXHCkyE2g9Jdd8woQFsHV7LHI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N1fES74o9W62XOW/SyeWqTiX+T251Fp/u3jEv8lLYS3SBcI4GT+GnBihrKg58e6R9
	 2UIkjB6UXQTp/FgIP+Kf5M2Ml3ck89RSzm03RDfSyfH3E0ZL3jWSG+LZ2r4iNW8Nxv
	 NrsZM12wzI5PaLJD54W5FEyQ6j6+ykgDAFhm5xOqgCJDc7nING5NE81EcAXXr8/QqH
	 dFXb5UsJgkU9+XpOe+K23WOgSc0XKsQFbAUdQ6P5rFIIwKgP64i3HVoMhF70XC0nzs
	 hB9/uRuB9gLMRv6TWrVQgslYGW2EO3m3ur4/1AM/MIXj42qHnfYBEa1QCCKCZLHghy
	 WbxIKMGMf5/nw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EEAB380F7A;
	Thu, 29 Oct 2026 05:09:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A78F3380
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 05:09:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8E08760717
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 05:09:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XVTtCRak59d7 for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 05:09:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6794160710
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793250552;
 b=HdK7ZnZ0Nz+JzXX8165dYkQXI8n1eb9e0rBJYEOn+R9HCDaq0TrR51nbuV4GBMF9aB79
 Ei/JLGQSj+LdfGr57fHH4kPnTw6HL9hacJrlq+vGZiayi1GqsrALWMJPQ415MEEhhwBAZ
 Ni+OTeVhCKEIDkPpxRdG/TzIELvriKnVR0xWc6gN6+zImQpNZKooN4nQZUzB7tx3Uewto
 W8ZeCduNs/E2NZyoHJEkmGFiyZHZxevMaAlvjSS5u4KpAbWFbvQCNNzv1M3JjsO+811th
 iFwLBFOxJGhPKTrRFFUuTGPXafIcW2iTV/YL8FbfPTDVHeZ1lGI4DfJ7oRacue43YWw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793250552;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-ZohoMailClient;
 bh=DUDZTAYLYXxL+u7tpwXHCkyE2g9Jdd8woQFsHV7LHI4=;
 b=SzK1t8jAfqiXfU89bQX0Lac82CcNkWnRBc7AQz8v4x1Fr+32HpF9zF/tdbECyId7Hp9S
 HGR1JHkjA5DpLQP00MBJrqMDDvBtKQv6bD3pbzPrPgkP+WADbfeqhnpBBrmInvgWL083s
 6vTcrc7RXuQoYhwjPBeFvOk4w+o9VZ5Gr+zUglrh2JzWs+9p32H16qpEghiJkRAm8Xqdp
 aOgK6D4Y+RmBGLYE/OVzPAJiWlh9j7MzTX2lWMXrkrL3N2LA6zvF9/PFo2zZNKAVQec8t
 OrWiv3Ugi+f5vNk8uzzRXCGhUzXfzGv68RLHm5guaD27mscOqwoDpAvd90idWiVcGVA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=ziyao.cc;
 dkim=pass header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=OMIgylLv; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=OMIgylLv
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6794160710
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 05:09:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1793250545; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=hLycDKRSNoR1cOW7FLYBU4k4RWt9qmptOSFUj4MphHMqukhEJPr1enWpB6xrV/WGpezYo1QbnsHt4hFmwUrTYY3kZxJR6MMCR9KINsGkc7Mbty3/ezP04l+yENas4e7QYIkPzVM6NaOFlfO6IcA7gqEfCa3dg7H0opEHjtgIDn0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1793250545;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=DUDZTAYLYXxL+u7tpwXHCkyE2g9Jdd8woQFsHV7LHI4=; 
 b=F1rUprT4shWfW/eTwn7ME8W1xMVZiW7xhrUTD92qvlE5kY8r1s0yneoxyyhQL1vILDXkQXi0B39PE3dJlviP1IPAw+p81RWPXCdAIwDrITl4HLj/iN89xGkpVJgDtYlcPgAcM+4HTSwDtF7+vcuZIk6uHYEA6UNPNZs2B6YCppE=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: a=rsa-sha256;
 b=OMIgylLvUZQ8nZTiEyk3gh/UklhtsSmBIK/ScZQVputVHHD7QaFo7xyFwFOojoahe1lFjdCyAwPosOe+oUtWfjpOfT63EQU4WiYiWN7Bl/1NbSFAqvWSGhZcphoE0hZcIiYbYdflu0tLz0K8i0kTe2TYAulw7yW4roBT7O/Ihnc=;
 c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1;
 bh=DUDZTAYLYXxL+u7tpwXHCkyE2g9Jdd8woQFsHV7LHI4=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 179325054244886.94716204093675;
 Wed, 28 Oct 2026 22:09:02 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>
Subject: [PATCH v6 07/20] LoongArch: lib: General routines
Date: Thu, 29 Oct 2026 05:07:24 +0000
Message-ID: <20261029050738.1107663-8-me@ziyao.cc>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

Add cache probing through CPUCFG, cache operations, setjmp()/longjump(),
and etc. for the architecture.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Yao Zi <me@ziyao.cc>
---

No changes since v5

Changed from v4
- Drop cache_flush()/cache_invalidate() helpers

Changed from v3
- Align the start address down to cacheline size when flushing dcache
  by address
- Fix off-by-one error when reading CPUCFG to probe L2/L3 unified
  cache

Changed from v2
- Improve commit message to list introduced routines, and how
  cache-probing is implemented
- Pass through addr in do_flush() macros
- Use CACHE_MAX_LEVEL instead of hard-coded 3 in probe_caches()
- Comment on cache behavior and cache probing logic in cache.c

Changed from v1
- Correctly implement dcache operations
---
 arch/loongarch/include/asm/cache.h       |  11 +-
 arch/loongarch/include/asm/global_data.h |   7 +
 arch/loongarch/lib/Makefile              |   7 +
 arch/loongarch/lib/asm-offsets.c         |  66 +++++++
 arch/loongarch/lib/boot.c                |  14 ++
 arch/loongarch/lib/cache.c               | 235 +++++++++++++++++++++++
 arch/loongarch/lib/reset.c               |  14 ++
 arch/loongarch/lib/setjmp.S              |  52 +++++
 8 files changed, 405 insertions(+), 1 deletion(-)
 create mode 100644 arch/loongarch/lib/asm-offsets.c
 create mode 100644 arch/loongarch/lib/boot.c
 create mode 100644 arch/loongarch/lib/cache.c
 create mode 100644 arch/loongarch/lib/reset.c
 create mode 100644 arch/loongarch/lib/setjmp.S

diff --git a/arch/loongarch/include/asm/cache.h b/arch/loongarch/include/asm/cache.h
index 854dd0c0a02e..f96b04ca3e4c 100644
--- a/arch/loongarch/include/asm/cache.h
+++ b/arch/loongarch/include/asm/cache.h
@@ -6,8 +6,10 @@
 #ifndef _ASM_LOONGARCH_CACHE_H
 #define _ASM_LOONGARCH_CACHE_H
 
+#include <linux/bitops.h>
+
 /* cache */
-void cache_flush(void);
+void probe_caches(void);
 
 #define cache_op(op, addr)						\
 	__asm__ __volatile__(						\
@@ -15,6 +17,13 @@ void cache_flush(void);
 	:								\
 	: "i" (op), "ZC" (*(unsigned char *)(addr)))
 
+#define CACHE_MAX_LEVEL		3
+#define CACHE_MAX_INDEX		6
+#define CACHE_OP		GENMASK(4, 3)
+#define  CACHE_INDEX_INVWB	0x1
+#define  CACHE_HIT_INVWB	0x2
+#define CACHE_INDEX		GENMASK(2, 0)
+
 #ifdef CONFIG_SYS_CACHELINE_SIZE
 #define ARCH_DMA_MINALIGN	CONFIG_SYS_CACHELINE_SIZE
 #else
diff --git a/arch/loongarch/include/asm/global_data.h b/arch/loongarch/include/asm/global_data.h
index 2a9a525e2f37..7aab802ca04d 100644
--- a/arch/loongarch/include/asm/global_data.h
+++ b/arch/loongarch/include/asm/global_data.h
@@ -10,6 +10,7 @@
 #define __ASM_GBL_DATA_H
 
 #include <linux/types.h>
+#include <asm/cache.h>
 #include <asm/u-boot.h>
 #include <compiler.h>
 
@@ -24,6 +25,12 @@ struct arch_global_data {
 #ifdef CONFIG_SMBIOS
 	ulong smbios_start;		/* Start address of SMBIOS table */
 #endif
+	ushort dcache_ways[CACHE_MAX_INDEX];
+	ushort dcache_sets[CACHE_MAX_INDEX];
+	ushort dcache_linesizes[CACHE_MAX_INDEX];
+	ushort dcache_index[CACHE_MAX_INDEX];
+	ushort dcache_levels;
+	bool dcache_inclusive;
 };
 
 #include <asm-generic/global_data.h>
diff --git a/arch/loongarch/lib/Makefile b/arch/loongarch/lib/Makefile
index 3dbed94cc624..3c17b9cd85af 100644
--- a/arch/loongarch/lib/Makefile
+++ b/arch/loongarch/lib/Makefile
@@ -3,3 +3,10 @@
 # Copyright (C) 2024 Jiaxun yang <jiaxun.yang@flygoat.com>
 #
 
+obj-$(CONFIG_CMD_GO) += boot.o
+obj-y	+= cache.o
+obj-y	+= interrupts.o
+ifeq ($(CONFIG_$(SPL_)SYSRESET),)
+obj-y	+= reset.o
+endif
+obj-y	+= setjmp.o
diff --git a/arch/loongarch/lib/asm-offsets.c b/arch/loongarch/lib/asm-offsets.c
new file mode 100644
index 000000000000..e3f4c629b63d
--- /dev/null
+++ b/arch/loongarch/lib/asm-offsets.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ *
+ * From arch/x86/lib/asm-offsets.c
+ *
+ * This program is used to generate definitions needed by
+ * assembly language modules.
+ */
+
+#include <asm/global_data.h>
+#include <asm/ptrace.h>
+#include <linux/kbuild.h>
+
+static void __used output_ptreg_defines(void)
+{
+	COMMENT("LoongArch pt_regs offsets.");
+	OFFSET(PT_R0, pt_regs, regs[0]);
+	OFFSET(PT_R1, pt_regs, regs[1]);
+	OFFSET(PT_R2, pt_regs, regs[2]);
+	OFFSET(PT_R3, pt_regs, regs[3]);
+	OFFSET(PT_R4, pt_regs, regs[4]);
+	OFFSET(PT_R5, pt_regs, regs[5]);
+	OFFSET(PT_R6, pt_regs, regs[6]);
+	OFFSET(PT_R7, pt_regs, regs[7]);
+	OFFSET(PT_R8, pt_regs, regs[8]);
+	OFFSET(PT_R9, pt_regs, regs[9]);
+	OFFSET(PT_R10, pt_regs, regs[10]);
+	OFFSET(PT_R11, pt_regs, regs[11]);
+	OFFSET(PT_R12, pt_regs, regs[12]);
+	OFFSET(PT_R13, pt_regs, regs[13]);
+	OFFSET(PT_R14, pt_regs, regs[14]);
+	OFFSET(PT_R15, pt_regs, regs[15]);
+	OFFSET(PT_R16, pt_regs, regs[16]);
+	OFFSET(PT_R17, pt_regs, regs[17]);
+	OFFSET(PT_R18, pt_regs, regs[18]);
+	OFFSET(PT_R19, pt_regs, regs[19]);
+	OFFSET(PT_R20, pt_regs, regs[20]);
+	OFFSET(PT_R21, pt_regs, regs[21]);
+	OFFSET(PT_R22, pt_regs, regs[22]);
+	OFFSET(PT_R23, pt_regs, regs[23]);
+	OFFSET(PT_R24, pt_regs, regs[24]);
+	OFFSET(PT_R25, pt_regs, regs[25]);
+	OFFSET(PT_R26, pt_regs, regs[26]);
+	OFFSET(PT_R27, pt_regs, regs[27]);
+	OFFSET(PT_R28, pt_regs, regs[28]);
+	OFFSET(PT_R29, pt_regs, regs[29]);
+	OFFSET(PT_R30, pt_regs, regs[30]);
+	OFFSET(PT_R31, pt_regs, regs[31]);
+	OFFSET(PT_CRMD, pt_regs, csr_crmd);
+	OFFSET(PT_PRMD, pt_regs, csr_prmd);
+	OFFSET(PT_EUEN, pt_regs, csr_euen);
+	OFFSET(PT_ECFG, pt_regs, csr_ecfg);
+	OFFSET(PT_ESTAT, pt_regs, csr_estat);
+	OFFSET(PT_ERA, pt_regs, csr_era);
+	OFFSET(PT_BVADDR, pt_regs, csr_badvaddr);
+	OFFSET(PT_ORIG_A0, pt_regs, orig_a0);
+	DEFINE(PT_SIZE, sizeof(struct pt_regs));
+	BLANK();
+}
+
+int main(void)
+{
+	output_ptreg_defines();
+	return 0;
+}
diff --git a/arch/loongarch/lib/boot.c b/arch/loongarch/lib/boot.c
new file mode 100644
index 000000000000..327be16bb59f
--- /dev/null
+++ b/arch/loongarch/lib/boot.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ */
+
+#include <asm/u-boot.h>
+
+unsigned long do_go_exec(ulong (*entry)(int, char * const []),
+			 int argc, char *const argv[])
+{
+	cleanup_before_linux();
+
+	return entry(argc, argv);
+}
diff --git a/arch/loongarch/lib/cache.c b/arch/loongarch/lib/cache.c
new file mode 100644
index 000000000000..ac992f57828e
--- /dev/null
+++ b/arch/loongarch/lib/cache.c
@@ -0,0 +1,235 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ * Copyright (C) 2026 Yao Zi <me@ziyao.cc>
+ */
+
+#include <asm/cache.h>
+#include <asm/global_data.h>
+#include <asm/loongarch.h>
+#include <cpu_func.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/kernel.h>
+
+#define CPUCFG_LX_IUPRE		BIT(0)
+#define CPUCFG_LX_IUUNIFY	BIT(1)
+#define CPUCFG_LX_IUINCL	BIT(3)
+
+DECLARE_GLOBAL_DATA_PTR;
+
+/*
+ * Existing LoongArch hardware maintains I-D cache consistency in hardware,
+ * thus only an ibar instruction is used in operations related to I-cache, in
+ * order to prevent pipeline hazard.
+ *
+ * Cache operations is implemented through CACOP instruction, which has three
+ * arguments: index of the cache, the operation, and either the cache line
+ * index, or a virtual address. The first two arguments are combined into an
+ * immediate operand.
+ *
+ * Caches are indexed from L1 to L3. For a level with separate I/D caches, the
+ * I-cache is ordered before the D-cache.
+ *
+ * Currently three cache operations are defined,
+ *  - initialize a cache line
+ *  - invalidate (and possibly writeback if it's a D-cache) a cache line, where
+ *    the cache line is indexed by
+ *    - cache line index (CACHE_INDEX_INVWB), or
+ *    - virtual address (CACHE_HIT_INVWB)
+ *
+ * Invalidating the leaf cache automatically invalidates other caches if it's
+ * inclusive.
+ */
+
+static inline void flush_cache_line_index(unsigned int cache_id,
+					  unsigned long index)
+{
+#define do_flush(_cache_id, _index)					\
+	case _cache_id:							\
+		cache_op(FIELD_PREP(CACHE_OP, CACHE_INDEX_INVWB) |	\
+			 FIELD_PREP(CACHE_INDEX, _cache_id),		\
+			 _index);					\
+		break;
+
+	switch (cache_id) {
+		do_flush(0, index);
+		do_flush(1, index);
+		do_flush(2, index);
+		do_flush(3, index);
+		do_flush(4, index);
+		do_flush(5, index);
+	}
+
+#undef do_flush
+}
+
+static inline void flush_cache_line_hit(unsigned int cache_id,
+					unsigned long addr)
+{
+#define do_flush(_cache_id, _addr)					\
+	case _cache_id:							\
+		cache_op(FIELD_PREP(CACHE_OP, CACHE_HIT_INVWB) |	\
+			 FIELD_PREP(CACHE_INDEX, _cache_id),		\
+			 _addr);					\
+		break;
+
+	switch (cache_id) {
+		do_flush(0, addr);
+		do_flush(1, addr);
+		do_flush(2, addr);
+		do_flush(3, addr);
+		do_flush(4, addr);
+		do_flush(5, addr);
+	}
+
+#undef do_flush
+}
+
+void invalidate_icache_all(void)
+{
+	asm volatile ("\tibar 0\n"::);
+}
+
+static void flush_dcache_level_all(unsigned int level)
+{
+	unsigned int way, set;
+	unsigned long index = 0;
+
+	for (set = 0; set < gd->arch.dcache_sets[level]; set++) {
+		for (way = 0; way < gd->arch.dcache_ways[level]; way++) {
+			flush_cache_line_index(gd->arch.dcache_index[level],
+					       index);
+			index++;
+		}
+
+		index -= gd->arch.dcache_ways[level];
+		index += gd->arch.dcache_linesizes[level];
+	}
+}
+
+__weak void flush_dcache_all(void)
+{
+	unsigned int level;
+
+	if (gd->arch.dcache_inclusive) {
+		flush_dcache_level_all(gd->arch.dcache_levels - 1);
+		return;
+	}
+
+	for (level = 0; level < gd->arch.dcache_levels; level++)
+		flush_dcache_level_all(level);
+}
+
+static void flush_dcache_level(unsigned int level, unsigned long addr,
+			       unsigned long end)
+{
+	addr = ALIGN_DOWN(addr, gd->arch.dcache_linesizes[level]);
+
+	for (; addr < end; addr += gd->arch.dcache_linesizes[level])
+		flush_cache_line_hit(gd->arch.dcache_index[level], addr);
+}
+
+__weak void flush_dcache_range(unsigned long start, unsigned long end)
+{
+	unsigned int level;
+
+	if (gd->arch.dcache_inclusive) {
+		flush_dcache_level(gd->arch.dcache_levels - 1, start, end);
+		return;
+	}
+
+	for (level = 0; level < gd->arch.dcache_levels; level++)
+		flush_dcache_level(level, start, end);
+}
+
+__weak void invalidate_icache_range(unsigned long start, unsigned long end)
+{
+	/* LoongArch mandatory hardware I-Cache coherence */
+	invalidate_icache_all();
+}
+
+__weak void invalidate_dcache_range(unsigned long start, unsigned long end)
+{
+	flush_dcache_range(start, end);
+}
+
+__weak void flush_cache(unsigned long addr, unsigned long size)
+{
+	invalidate_icache_range(addr, addr + size);
+	flush_dcache_range(addr, addr + size);
+}
+
+__weak void dcache_enable(void)
+{
+}
+
+__weak void dcache_disable(void)
+{
+}
+
+__weak int dcache_status(void)
+{
+	return 0;
+}
+
+static void populate_dcache_properties(u32 cfg0, unsigned int level,
+				       unsigned int cfgoff)
+{
+	u32 cfg1 = read_cpucfg(cfgoff);
+
+	if (level != 0)
+		gd->arch.dcache_inclusive = cfg0 & CPUCFG_LX_IUINCL;
+
+	gd->arch.dcache_ways[level] = FIELD_GET(CPUCFG_CACHE_WAYS_M, cfg1) + 1;
+	gd->arch.dcache_sets[level] = 1 << FIELD_GET(CPUCFG_CACHE_SETS_M, cfg1);
+	gd->arch.dcache_linesizes[level] = 1 << FIELD_GET(CPUCFG_CACHE_LSIZE_M, cfg1);
+}
+
+void probe_caches(void)
+{
+	unsigned int level = 0, index = 0;
+	u32 cfg = read_cpucfg(LOONGARCH_CPUCFG16);
+
+	if (cfg & CPUCFG16_L1_IUPRE) {
+		if (cfg & CPUCFG16_L1_IUUNIFY) {
+			gd->arch.dcache_index[level] = index;
+			populate_dcache_properties(cfg, level++,
+						   LOONGARCH_CPUCFG17);
+		}
+
+		index++;
+	}
+
+	if (cfg & CPUCFG16_L1_DPRE) {
+		gd->arch.dcache_index[level] = index++;
+		populate_dcache_properties(cfg, level++, LOONGARCH_CPUCFG18);
+	}
+
+	cfg >>= 3;
+
+	/*
+	 * Currently no CPUCFG register is defined to hold information for
+	 * separate L2D and L3D. Assume that L2 and L3, if present, must be
+	 * unified or instruction-only.
+	 */
+	for (; level < CACHE_MAX_LEVEL; level++) {
+		if (cfg & CPUCFG_LX_IUPRE && cfg & CPUCFG_LX_IUUNIFY) {
+			gd->arch.dcache_index[level] = index++;
+			populate_dcache_properties(cfg, level,
+						   LOONGARCH_CPUCFG17 + 1 + level);
+		} else {
+			break;
+		}
+
+		cfg >>= 7;
+	}
+
+	gd->arch.dcache_levels = level;
+}
+
+__weak void enable_caches(void)
+{
+	/* Enable cache for direct address translation mode */
+	csr_xchg64(1 << CSR_CRMD_DACM_SHIFT, CSR_CRMD_DACM, LOONGARCH_CSR_CRMD);
+}
diff --git a/arch/loongarch/lib/reset.c b/arch/loongarch/lib/reset.c
new file mode 100644
index 000000000000..ddf29ee41d95
--- /dev/null
+++ b/arch/loongarch/lib/reset.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ */
+
+#include <command.h>
+#include <cpu_func.h>
+
+int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	reset_cpu();
+
+	return 0;
+}
diff --git a/arch/loongarch/lib/setjmp.S b/arch/loongarch/lib/setjmp.S
new file mode 100644
index 000000000000..12981d0013fa
--- /dev/null
+++ b/arch/loongarch/lib/setjmp.S
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ */
+
+#include <config.h>
+#include <asm/asm.h>
+#include <linux/linkage.h>
+
+.pushsection .text.setjmp, "ax"
+ENTRY(setjmp)
+	LONG_S		s0, a0, 0
+	LONG_S 		s1, a0, (1 * LONGSIZE)
+	LONG_S		s2, a0, (2 * LONGSIZE)
+	LONG_S		s3, a0, (3 * LONGSIZE)
+	LONG_S		s4, a0, (4 * LONGSIZE)
+	LONG_S		s5, a0, (5 * LONGSIZE)
+	LONG_S		s6, a0, (6 * LONGSIZE)
+	LONG_S		s7, a0, (7 * LONGSIZE)
+	LONG_S		s8, a0, (8 * LONGSIZE)
+	LONG_S		fp, a0, (9 * LONGSIZE)
+	LONG_S		sp, a0, (10 * LONGSIZE)
+	LONG_S		ra, a0, (11 * LONGSIZE)
+
+	move		a0, zero
+	ret
+ENDPROC(setjmp)
+.popsection
+
+.pushsection .text.longjmp, "ax"
+ENTRY(longjmp)
+	LONG_L		s0, a0, 0
+	LONG_L 		s1, a0, (1 * LONGSIZE)
+	LONG_L		s2, a0, (2 * LONGSIZE)
+	LONG_L		s3, a0, (3 * LONGSIZE)
+	LONG_L		s4, a0, (4 * LONGSIZE)
+	LONG_L		s5, a0, (5 * LONGSIZE)
+	LONG_L		s6, a0, (6 * LONGSIZE)
+	LONG_L		s7, a0, (7 * LONGSIZE)
+	LONG_L		s8, a0, (8 * LONGSIZE)
+	LONG_L		fp, a0, (9 * LONGSIZE)
+	LONG_L		sp, a0, (10 * LONGSIZE)
+	LONG_L		ra, a0, (11 * LONGSIZE)
+
+	/* Move the return value in place, but return 1 if passed 0. */
+	li.w		a0, 1
+	beqz		a1, 1f
+	move		a0, a1
+1:
+	jr		ra
+ENDPROC(longjmp)
+.popsection
-- 
2.56.0

