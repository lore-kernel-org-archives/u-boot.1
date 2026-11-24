Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1151D606A321
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 19:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yNO6O8Tx;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XZMtsxj5
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D189B6082B;
	Tue, 24 Nov 2026 19:53:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UgE73-kfgVWt; Tue, 24 Nov 2026 19:53:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D87F66069B
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795549989;
	b=QgnddBYcfCOIMwDUp31UtVa4bTKHOfBAVzfyO8axfTVXE87kBxE+LTHPq/3xxM8rmXGb
	 M8Mny9DTic3yoKA1hFS1FJH0N3XWPiTEjRKjLDnj8VxXHHPnXWafjuxhD+p+LHz3Gm5Au
	 uTDZ6U6u79Puogz1yU+1BE17LLK5XGEBmSATUckXA2ygdYIJdW6imgu8bIHxlerTF+ixS
	 NS20mOoSQU2gwNRsCw37GMwtfRTs4HFdiDBFN+hSOstpjvzOciLEB6GO6B+xaBVr3KGkT
	 yX42Js9VaigVACoZjxNiiNSPCSHvR5+L4hVGjcJuOqOBDlrFa/usb7Onv51bIVDc1gg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795549989;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=dOwavnBJHmzDi0p18ob9c5g7b+7byyZz3Lr6azU4fhI=;
	b=ssiK4SqOooz/NuLA+3+PYQLu1sSKSXWFNDYwp/+zfax0kCy7RSdEh9B8jq8Z3NuVIai4
	 bPHwY6GhNwHf6dt4iHTqbnA6t2qWq7AkdbKv9b3YOpfwcJl3U9V026MnOpzb+5sJofNBk
	 aZ6/Qb0OX+nEWIIV7+L8g77K46GV7tPMoMiWAvzg00LXJ6cjxUxn0hyXsBUIm0ZM07Al/
	 pTmp6qIEeZ+EVWKihcJAmD4nFy/I0bPtW6vDZxYSNii+Xu/BAkrLcbLDbmHS1VyEUdb5x
	 74qCc0I0D8A3PwGVXHcSQ3DtyK897yaCwxsOr4qlmK8thOr2r8VqjYYXEoUqCM5IEsQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795549989;
	bh=dOwavnBJHmzDi0p18ob9c5g7b+7byyZz3Lr6azU4fhI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yNO6O8TxrTAz9RHFoPFKk8ATlsS4qOkiMgXVkST4GkE2FMfWHb4RMwx2gBs80Stzo
	 BVo7Z/izgWWJeyENaWGDJE44NVsVlCCq2mIEfPcB0YCCmHIVJPcy90eJlSWV3MX20N
	 U1Vv1BL7SeYZ+CarR7emTV5l2at7JEVPuAxWWah9S4S9gmI4amEvPVgcKAzHeV8Fsg
	 rmM1zidZ0ttGMxWJen0GFGXGEo0F3jDUrA7ycmjVTC3C4uBCyH5WBNpxDvUP+Zb8Z6
	 9eXXZ1uIoownjxVnuoSI+0MYDX6fG8lBLfWZOLXY+wRN8tYRQkfPeaH0PlaCaw8wn7
	 d0kPdEdnZIQSQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D87F66069B;
	Tue, 24 Nov 2026 19:53:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4A2282F5
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 19:53:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 47ED480DE2
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 19:53:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sM5i32sWboC1 for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 19:53:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 06D0280E36
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::133"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::133; helo=mail-lf1-x133.google.com;
 envelope-from=indrek.kruusa@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=XZMtsxj5
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 06D0280E36
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 19:53:06 +0000 (UTC)
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5bfbc67991cso3333598e87.0
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 11:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795549984; x=1796154784;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dOwavnBJHmzDi0p18ob9c5g7b+7byyZz3Lr6azU4fhI=;
 b=XZMtsxj5xOecq0q7LIVhL+V8UUXcRuK6hzgJH0dqK9pSQxYXDq3hb8lJK3uWcsXjcb
 yYI2yn7VdCADZHZUamze9Qe3S63FNrioRS0PkJ2ROIJQ6ck4c4GqaGFuJwhAg+OLJsy4
 S8H9E1Je2Mtmd57gTJEPXKG1JC3pbcGdN0uXvniMfISdsYSDW5aqHJx9oCe7B4Rcw4tf
 1FCrqUge8rzz1mMgHBpg0ivfMxw6vjcUF5ww2LbS80k9RfnG+2EYZTEyEfHWWkRjo5ll
 uE5PVCn6+4oDO1j5ndM0Vrm+jdGNGCx8XahrCm4cQlyGB5/GxoDvoVvXnSwwo32ucO5n
 MVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795549984; x=1796154784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dOwavnBJHmzDi0p18ob9c5g7b+7byyZz3Lr6azU4fhI=;
 b=RQIf6uxSH1hAWrDo9St7VNnPV4Zn+IEYLuUFxts2HQwUpTu4d5EBuBMW624ZbbHIav
 X2QwYJsSbAbVjxkhuiun0NIeOoW4PtnAX2/cD/ih8jpnSPH0MpPy2w/85Rb416+8Kp0n
 KdfSA8CdQH0PMv4s3dVpa6T8u217etdSVEkbGC+M984p7n3vD4l+NKx3d5MxZS5cHRUC
 pUbH1mP4SwQTxccduEJ32UxU+MTuI8xbQgTDdXe5be6e0a/IfHVPU6QIAP6kCKe7dAJY
 LexHGZRi2X4tDaltFu1+gCf5WVx9gD/Il+S7qoLkMJT/fVIFT58H/tR6mNDTINmt9ZFv
 pl7Q==
X-Forwarded-Encrypted: i=1;
 AL+hErHjKJ08Tm8QyX7Fy0o50xQiMshO4OsJ5lBZLlmrzF0sz6eEXElUdcK2HA7WoLSsUYp3Lc5mNwM=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9M6wpgdbcejamG8YW8fXDXhfYUmtjgTQUu7iQSbqAUCpEXL1xB
 ul3ir9ZhQB6E1/ADCUPcsu9KgDceruijTcCvCzJVVjis5GJ0HZ73xoQc
X-Gm-Gg: AZFdTZdxs3zGLa/pUvtu4+Phl7NQCNgdTN+IYHYtkdYqdGbea6KRmeclVoOYG+OLQI3
 OTrKkna3fENkdtcCm8g/ephLrd+GHWSiWwOc8NrYeoZlaTyp+1x/w0GgFWBEi7lT0ZoFqccBhoe
 PWz9vEc/0S0dsJ9NcrKgoXYOWllJ0mxQHMkDw1L4LiC52ZXSQSzU0ciBHSPqx6G9qeZJY8dH54D
 qIlwtArvXf3V9RdZl80GoJbtEE+CzAjZ6kz3/HOJjzTjPmVqs/bvHRhUTegLPaTLchK4vnmq9mr
 aOwgmIN2Pg+RpPEA0xpYsuK36LwFaNaMok93oB0uP2xNj9C3YFdsx5fSfERzAmbKawufPeNpkX7
 J/f3II58byzIccELHbHoZ6rGwRqCdOtFj4ZVVJ7l5Y1HPVkg6wfHyec41Fy6yAXvHHoTySxsH7g
 FLRJ7N4JCwocBE2uFrk1noMhY+gQI6aqu1wLZgtqm9Tr9q19g6B4rebwnK2IOxZPfikOnvB2abt
 jFB+S5NEzKeLSFIVtTwRVglIGgXKSxPsanYt6Btu2XqE86/3Sgbru5+1EPSMa5D324zPpyN0SCs
 U6ySri+7mLI/ltliwYOu1+A6EPAFhgj41Ov99Shsjl2uiNLwl53DuXiBHh6g7rNSVrvw
X-Received: by 2002:a05:6512:3d0c:b0:5c1:4dba:f748 with SMTP id
 2adb3069b0e04-5c1bc7bcccemr5162655e87.10.1795549984391; 
 Tue, 24 Nov 2026 11:53:04 -0800 (PST)
Received: from ik5070.localdomain (82-131-69-225.ip.elisa.ee. [82.131.69.225])
 by smtp.googlemail.com with ESMTPSA id
 2adb3069b0e04-5c1bd041813sm4057216e87.53.2026.11.24.11.52.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 11:53:00 -0800 (PST)
From: Indrek Kruusa <indrek.kruusa@gmail.com>
To: Tim Ouyang <tim609@andestech.com>,
	Leo Liang <leo.liang@sifive.com>
Cc: Yao Zi <me@ziyao.cc>, Tom Rini <trini@konsulko.com>,
 Han Gao <gaohan@iscas.ac.cn>, Kongyang Liu <seashell11234455@gmail.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>,
 Samuel Holland <samuel@sholland.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Hiago De Franco <hfranco@baylibre.com>, E Shattow <e@freeshell.de>,
 Yixun Lan <dlan@kernel.org>, Raymond Mao <raymond.mao@riscstar.com>,
 u-boot@lists.u-boot-project.org, Indrek Kruusa <indrek.kruusa@gmail.com>
Subject: [PATCH 4/4] riscv: lib: add the whole-cache and enable operations
Date: Tue, 24 Nov 2026 21:52:37 +0200
Message-ID: <20261124195237.692679-5-indrek.kruusa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124195237.692679-1-indrek.kruusa@gmail.com>
References: <20261124195237.692679-1-indrek.kruusa@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add flush_dcache_all() and invalidate_dcache_all(), and the cache
enable, disable and status functions.

On C910 the whole-cache instructions act on the L1 of the calling core
only, so the L2 is cleaned on top of them when THEAD_L2_CACHE is set.
The address-range operations need nothing on top: since commit
b3d8c7bd081a ("riscv: thead: fix D-cache flushing") they clean and
invalidate, and they already reach the L2 and every core.

The enable and status functions use MHCR, an M-mode register, so they
are compiled out where U-Boot runs in S-mode, as on CV1800B.

Signed-off-by: Indrek Kruusa <indrek.kruusa@gmail.com>
---
 arch/riscv/Kconfig             |   7 ++
 arch/riscv/cpu/th1520/Kconfig  |   1 +
 arch/riscv/cpu/th1520/Makefile |   1 -
 arch/riscv/cpu/th1520/cache.c  |  34 ----------
 arch/riscv/lib/thead_cache.c   | 116 ++++++++++++++++++++++++++++-----
 5 files changed, 108 insertions(+), 51 deletions(-)
 delete mode 100644 arch/riscv/cpu/th1520/cache.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 23fe867c840..421219fa17a 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -95,6 +95,13 @@ config THEAD_CACHE
 	  Support for T-Head C9xx cache operations not covered by the RISC-V
 	  base ISA.
 
+config THEAD_L2_CACHE
+	bool
+	depends on THEAD_CACHE
+	help
+	  Make the whole-cache operations cover the L2.  This option is not
+	  about enabling the L2 hardware.
+
 config SPL_SYS_DCACHE_OFF
 	bool "Do not enable dcache in SPL"
 	depends on SPL
diff --git a/arch/riscv/cpu/th1520/Kconfig b/arch/riscv/cpu/th1520/Kconfig
index 738bdc7523f..baff8ba1934 100644
--- a/arch/riscv/cpu/th1520/Kconfig
+++ b/arch/riscv/cpu/th1520/Kconfig
@@ -10,6 +10,7 @@ config THEAD_TH1520
 	select SUPPORT_SPL
 	select BINMAN if SPL
 	select THEAD_CACHE
+	select THEAD_L2_CACHE
 	select CLK_THEAD
 	select PINCTRL_TH1520
 	imply CPU
diff --git a/arch/riscv/cpu/th1520/Makefile b/arch/riscv/cpu/th1520/Makefile
index d971ea7390d..2b7253867a4 100644
--- a/arch/riscv/cpu/th1520/Makefile
+++ b/arch/riscv/cpu/th1520/Makefile
@@ -2,7 +2,6 @@
 #
 # Copyright (C) 2025, Yao Zi <ziyao@disroot.org>
 
-obj-y += cache.o
 obj-y += cpu.o
 obj-y += dram.o
 obj-$(CONFIG_SPL_BUILD) += spl.o
diff --git a/arch/riscv/cpu/th1520/cache.c b/arch/riscv/cpu/th1520/cache.c
deleted file mode 100644
index b2fec229363..00000000000
--- a/arch/riscv/cpu/th1520/cache.c
+++ /dev/null
@@ -1,34 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (c) 2025 Yao Zi <ziyao@disroot.org>
- */
-
-#include <asm/io.h>
-#include <cpu_func.h>
-#include <linux/bitops.h>
-
-#define CSR_MHCR		0x7c1
-#define  CSR_MHCR_IE		BIT(0)
-#define  CSR_MHCR_DE		BIT(1)
-
-#if CONFIG_IS_ENABLED(RISCV_MMODE)
-void icache_enable(void)
-{
-	csr_write(CSR_MHCR, csr_read(CSR_MHCR) | CSR_MHCR_IE);
-}
-
-void dcache_enable(void)
-{
-	csr_write(CSR_MHCR, csr_read(CSR_MHCR) | CSR_MHCR_DE);
-}
-
-int icache_status(void)
-{
-	return (csr_read(CSR_MHCR) & CSR_MHCR_IE) != 0;
-}
-
-int dcache_status(void)
-{
-	return (csr_read(CSR_MHCR) & CSR_MHCR_DE) != 0;
-}
-#endif /* CONFIG_IS_ENABLED(RISCV_MMODE) */
diff --git a/arch/riscv/lib/thead_cache.c b/arch/riscv/lib/thead_cache.c
index 763ff799edd..a1104a53dc1 100644
--- a/arch/riscv/lib/thead_cache.c
+++ b/arch/riscv/lib/thead_cache.c
@@ -1,36 +1,49 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
+ * Copyright (C) 2025, Yao Zi <ziyao@disroot.org>
+ * Copyright (C) 2026, Indrek Kruusa <indrek.kruusa@gmail.com>
+ *
+ * Cache operations for the T-Head C9xx cores.
  */
 
+#include <asm/csr.h>
+#include <asm/thead_csr.h>
 #include <cpu_func.h>
 
 /*
- * dcache.ipa rs1 (invalidate)
- * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
- *   0000001    01010      rs1       000      00000  0001011
- *
- * dcache.cpa rs1 (clean)
- * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
- *   0000001    01001      rs1       000      00000  0001011
+ * These instructions are not known to the assembler, so they are emitted as
+ * raw encodings.  They all use funct3 = 0, rd = 0 and opcode 0001011, with the
+ * operation in funct5 and the address of the affected line, if any, in rs1:
  *
- * dcache.cipa rs1 (clean then invalidate)
- * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
- *   0000001    01011      rs1       000      00000  0001011
+ *   dcache.ipa   rs1   invalidate the line at a0
+ *   dcache.cipa  rs1   clean and invalidate the line at a0
+ *   dcache.iall        invalidate all L1 entries
+ *   dcache.ciall       clean and invalidate all L1 entries
+ *   l2cache.iall       invalidate the L2
+ *   l2cache.ciall      clean and invalidate the L2
+ *   sync.s             wait for the operation to complete
  *
- * sync.s
- * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
- *   0000000    11001     00000      000      00000  0001011
+ * They only decode while MXSTATUS.THEADISAEE is set.  Where U-Boot runs in
+ * M-mode, harts_early_init() sets it; on S-mode ports the FSBL has already
+ * enabled the extensions.
  */
 #define DCACHE_IPA_A0	".long 0x02a5000b"
-#define DCACHE_CPA_A0	".long 0x0295000b"
 #define DCACHE_CIPA_A0	".long 0x02b5000b"
+#define DCACHE_IALL	".long 0x0020000b"
+#define DCACHE_CIALL	".long 0x0030000b"
+#define L2CACHE_IALL	".long 0x0160000b"
+#define L2CACHE_CIALL	".long 0x0170000b"
 
 #define SYNC_S		".long 0x0190000b"
 
+#if !CONFIG_IS_ENABLED(SYS_DCACHE_OFF)
+
 void invalidate_dcache_range(unsigned long start, unsigned long end)
 {
-	register unsigned long i asm("a0") = start & ~(CONFIG_SYS_CACHELINE_SIZE - 1);
+	register unsigned long i asm("a0") =
+		start & ~(CONFIG_SYS_CACHELINE_SIZE - 1);
+
 	for (; i < end; i += CONFIG_SYS_CACHELINE_SIZE)
 		__asm__ __volatile__(DCACHE_IPA_A0);
 	__asm__ __volatile__(SYNC_S);
@@ -38,8 +51,79 @@ void invalidate_dcache_range(unsigned long start, unsigned long end)
 
 void flush_dcache_range(unsigned long start, unsigned long end)
 {
-	register unsigned long i asm("a0") = start & ~(CONFIG_SYS_CACHELINE_SIZE - 1);
+	register unsigned long i asm("a0") =
+		start & ~(CONFIG_SYS_CACHELINE_SIZE - 1);
+
 	for (; i < end; i += CONFIG_SYS_CACHELINE_SIZE)
 		__asm__ __volatile__(DCACHE_CIPA_A0);
 	__asm__ __volatile__(SYNC_S);
 }
+
+/*
+ * The whole-cache operations act on the L1 of the calling core only, so the
+ * L2 is cleaned on top when CONFIG_THEAD_L2_CACHE is set.  The address-range
+ * operations above are different: they act on both levels and every core of
+ * the cluster, which is why nothing is added for them.
+ */
+void invalidate_dcache_all(void)
+{
+	__asm__ __volatile__(DCACHE_IALL);
+	if (IS_ENABLED(CONFIG_THEAD_L2_CACHE))
+		__asm__ __volatile__(L2CACHE_IALL);
+	__asm__ __volatile__(SYNC_S);
+}
+
+void flush_dcache_all(void)
+{
+	__asm__ __volatile__(DCACHE_CIALL);
+	if (IS_ENABLED(CONFIG_THEAD_L2_CACHE))
+		__asm__ __volatile__(L2CACHE_CIALL);
+	__asm__ __volatile__(SYNC_S);
+}
+
+#endif /* !CONFIG_IS_ENABLED(SYS_DCACHE_OFF) */
+
+/*
+ * MHCR is not accessible from S-mode, so this half is only built where U-Boot
+ * runs in M-mode.
+ */
+#if CONFIG_IS_ENABLED(RISCV_MMODE)
+
+void icache_enable(void)
+{
+	invalidate_icache_all();
+	csr_set(CSR_MHCR, MHCR_IE);
+}
+
+void icache_disable(void)
+{
+	csr_clear(CSR_MHCR, MHCR_IE);
+}
+
+int icache_status(void)
+{
+	return csr_read(CSR_MHCR) & MHCR_IE;
+}
+
+#if !CONFIG_IS_ENABLED(SYS_DCACHE_OFF)
+
+void dcache_enable(void)
+{
+	invalidate_dcache_all();
+	csr_set(CSR_MHCR, MHCR_DE);
+}
+
+void dcache_disable(void)
+{
+	flush_dcache_all();
+	csr_clear(CSR_MHCR, MHCR_DE);
+}
+
+int dcache_status(void)
+{
+	return csr_read(CSR_MHCR) & MHCR_DE;
+}
+
+#endif /* !CONFIG_IS_ENABLED(SYS_DCACHE_OFF) */
+
+#endif /* CONFIG_IS_ENABLED(RISCV_MMODE) */
-- 
2.43.0

