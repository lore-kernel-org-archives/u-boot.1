Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F6BACC6B38
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 06:56:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D123E409B1;
	Fri, 16 Oct 2026 06:56:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y-RAdSdcYd8E; Fri, 16 Oct 2026 06:56:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 57A024099B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792133777;
	b=YYZL44L12RxdXQ8wcdgiO/FKINkUnseMp7Dm7PPjES1OqVkqdYhF/TliBpWoL3kGH7tx
	 SR5cl7uvVhFvU0LKZLQXdHtXzYCgbHteQwDTB0skjnFJV94nnDn4NJN8udg7gCSgbiy8s
	 f//YnACK4ZISmOzlqUCp3VoybzxX+iBTAV5D2oqSPddpIfNf2+OZDBHAUbRBNp6Wl1CZh
	 E6dVtzwd/QML85JeHNbBcp5D6OLRJ+3TpOgDBXNkwW/1UOBm3UfdNmtPf4ugcCU3eeefV
	 oDWsJ8EHqgzfk7UTPjVh81Ub7OQ5Q2JwBBbM8Pg+qFRLOfQQnaGKP8Dh9SZsFeQSXYA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792133777;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=P66NItKKHJ+YO/iCUkvczJc5r9KD5vbWhoDN2+LWoDM=;
	b=S3Bcsb0pP4vtJI9GaoviW69lwAM6Gx3sM3O5JZ62VrbA2cJ+mEhXQMtNpqu2LgLAYl7p
	 Tsgob5Bm1QRr1iYL9qcha1eib++BedKoigVEUiprdZ3xFCE8vXYIXZorIwrU8ZDSVQnw6
	 /IBx4d41PaODHOapNDRahYsZ9EBidP+5SAYlYIo8ULR07S5Roif4mAvpjhi8XWSK/wAJi
	 +43CIyog+WXlbistV4slIna5CSltAkGNnO0//Tty+29DPLqW524UXOVSSORDtnZB4tGN4
	 EBXZLtK29Yjvj3Gj1cByvFUzyx8IXq+fuOsfBBw2JEyXfeOeVp5kvOZGjACq21r9kQw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792133777;
	bh=P66NItKKHJ+YO/iCUkvczJc5r9KD5vbWhoDN2+LWoDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jZL6+T4/NmsrcF7yJnK/jjQiuEtasf/eQkIQiqP40GFDGIgd+gldGTRXddhMHTbH9
	 japj5UUbrfh4GGLnxkL0lupprdKnnJMYmeeqDsgxz//w956v7gYoTo/HScmmCBZAPm
	 HxFwPd5n24AxGLpXxufFHSrD/wWuU3rEkVE8LxM5kWptL3Bg9SN8U6AQqAtEU+oq/m
	 twlDP8D9G4SSlf5mZBDFIvaHLdZxvMQXJPOHkDeJU3H2r8Cdur5FlTLG6qQAg/plWE
	 FKrdpxHvuhigsmlqIww2hw0uOMP+tF1ogLAy0i2ba2+rbPSE2xn2AC1FIWpyl7242h
	 ambTZEEaru/3A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 57A024099B;
	Fri, 16 Oct 2026 06:56:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id BCA951DE
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:56:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AE93981309
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:56:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gQno9hHfZ5mJ for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 06:56:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8842A81303
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792133773;
 b=WjEY7+ek4792EU0AZjS0wXIyvnCI6+FL6Bb9M9YmStHNYZJWrDkYLfkOYa+/oreapRSS
 lhbYxsdL7Nrzp05TSqueKvK5twChdgQZhE7vuTwuJ19A5z+cvn4Fi0pN+iicGu0bM4QRN
 JUNNy8NBRf/KEmPt1VxzvLohiHlow+pbbuX/XVBFIpvY0xnwoq0sMfO3P8ZO8+DUrQMli
 SleI7j5F3tdfA4M2g0qwlq5CV7pFk3V4ffa0/Vz4Szd9TpVjpZmGLoRxVX/2dp04sdr2o
 uAWKbF4V6ksi4nnZLoA8HOE9HJoJn8axlNy4bkrl3aStRwaex5J8/SpezFL1h86jq+A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792133773;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-ZohoMailClient;
 bh=P66NItKKHJ+YO/iCUkvczJc5r9KD5vbWhoDN2+LWoDM=;
 b=GpxBAILsUPtookuGgQlTXflwAgIgQb+N5L7NKw+Om7j60KLnMg0vLAk2pdejjR8zG9Bx
 5JqXmYrP0nXgnM1n5a+RYiaIkE0NttiLSFhALswqIB2bzgm7b3owGZhoQQUtRirkiUALN
 fxL8psaVjzfTTg4NTY1rGfCtLTpEdYmmc0QVX2l0GtcCwxF0moBXBs+D0kbZT848ej5gC
 Et1xXDDVjFrEXVoTxJweY8YvNFrKr36jchTcj9xVhisvVgTXz5FSJjLk/M9LiN2u4FCbD
 q/HToC6ajp1DTvWZOI7yEXaNQp0mKgI2xfy0mTP5sKAtjI4ztiHN0UmqR4VtYub4r3g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=ziyao.cc;
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=cYinJwou; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=cYinJwou
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8842A81303
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:56:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1792133767; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=KCXu/8U8CwuvuQuTkBr2unDnUq7qoo5qShvyx+VifdMpQlD+lcDx64IcUcPpLANAw0vms7gBTkK2fGUxma0G5BMPglnB3YTc8Z6whDFcyquswH6xYCtjIcibk3ZRwL13ELXrWPBB5GTGd4nMDTsNPC6n7yRQmZ88zbkEV10zdVU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1792133767;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=P66NItKKHJ+YO/iCUkvczJc5r9KD5vbWhoDN2+LWoDM=; 
 b=UYzEIXVxYBUKNRJiqp3rCLDUd6Ok48b+nsaWM0u9pqmn7W+BOViELzJST8d+lSpoEaA1Gd5drFb0Xcx32sw/wZCcVBbhYgDgdS977TEQf7LWN2yvURODrwXd+TDfkRtPirrU2SaQy/ljV4ywgRToZ+qyBTWEWIfl6TfBR65iCV8=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792133767; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=P66NItKKHJ+YO/iCUkvczJc5r9KD5vbWhoDN2+LWoDM=;
 b=cYinJwouqC9DVA8glgn1mAIE2NSRYLAD7+cAIf1eVYISsfI+oYbI3saY3nyWvTfy
 advYKx2Unk8j3ZqqvStw8m1ojkqza+0+gxP9JfzMdfzIdpHGST7RdLBuHR18ymon9Oq
 VSMAysulZ6YlrxdZdSY+D8aKZB6muJElvjLi+rsw=
Received: by smtp.zohomail.com with SMTPS id 1792133764711520.9949267428342;
 Thu, 15 Oct 2026 23:56:04 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH v5 07/20] LoongArch: lib: General routines
Date: Fri, 16 Oct 2026 06:54:47 +0000
Message-ID: <20261016065500.137544-8-me@ziyao.cc>
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

Add cache probing through CPUCFG, cache operations, setjmp()/longjump(),
and etc. for the architecture.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Yao Zi <me@ziyao.cc>
---

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
2.55.0

