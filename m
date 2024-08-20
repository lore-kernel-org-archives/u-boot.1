Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C73C531DF
	for <u-boot@archiver.kernel.org>; Tue, 20 Aug 2024 09:38:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D0DA88D7D;
	Tue, 20 Aug 2024 11:38:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="KVHDeTBL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9865D889D2; Tue, 20 Aug 2024 11:38:41 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75C18889D2
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 11:38:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3db1e4219f8so2940674b6e.3
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 02:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1724146718; x=1724751518; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CBdyr7ntGTLwsNIrpXtii0M8Km5ABf4KJHHJSfa65W0=;
 b=KVHDeTBLhqDpddbckXHXf/g/6NNR0wUIt0Bihnc0PuQQ0r8T/Ug4ID6Mvp1iSVFSUC
 72dR6zysl0KIvW7paMW1YrbEL9sjWphl4rLcw6MNNXzaikXf9s816XaY/XAN2p4VrX0N
 sVNgSmh9DoOlzcTK3x/hKMsXNnTsAJkFMJuI2BGafbESxTt+r/6cKFHuNA7P5oBmSRbv
 cIZ2UUvcDLmyVZI5cAVBoYIQ/Jfm04I7OxLjjBkqc5x3hw8f2Ja8vsh3FLRSL5FIH7Ds
 1J8h4AlDySxGnxXbDJOlBquvK7B8JhHowvwT/mWqSFakF5iBqJiXbDhRfAmD3fp36qws
 h89Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724146718; x=1724751518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CBdyr7ntGTLwsNIrpXtii0M8Km5ABf4KJHHJSfa65W0=;
 b=KKehhIKff+422hFF+6+rxz0NAsdTUHFQP6wBwWi9pxcvMft5I4Dztqb/qEP0HbVJZX
 0ZIUd1gUfpF4/GHzqmYU5e+xLadcQdy6vFGLU6PCVs4mEHrYmq3ze0MRwvGGWjsxrvFV
 skw5TSS9EG00gVV17Sjc8U95Q+gGhx2yK+E6psd3XfmeN/4H2xwgdVqBvhx4YB3HJcM5
 pI0Gukzce28oNbHyaSuESvqhv7An2HfGg1++12HkhElLptBN+NeHdZk+vvJiFd1Gcx6t
 JqaOfBT0u5fBZPed3kLhUZrgbkJy3+NHGXyT/5QTaabwF9pvQWkgZhWQmt7v05pL8Qn5
 CyHw==
X-Gm-Message-State: AOJu0Yx94b3Mwu0hXvfpLJGNypK2v7gf1B5QCXQoqsHCns8hdIrTlD8q
 nN44573xJhd3HlQ4hLy/tdL4RiNGHLz6di7786lTRCNs5ixkW33LcaYPJgTbUvtf0hrxE9kvzyy
 I
X-Google-Smtp-Source: AGHT+IErZC+NU0ZhMHqNyC7sJbkPhJ4O9eJQvjzcUh/OdXbxv7NjQVXk0/QlB5wcRcSvFuT0NyYeXQ==
X-Received: by 2002:a05:6808:2f07:b0:3de:13bf:3078 with SMTP id
 5614622812f47-3de13bf60f3mr807963b6e.11.1724146717869; 
 Tue, 20 Aug 2024 02:38:37 -0700 (PDT)
Received: from localhost.localdomain ([103.97.165.210])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-3dd33d3fe91sm2795674b6e.9.2024.08.20.02.38.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2024 02:38:37 -0700 (PDT)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: u-boot@lists.denx.de
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Randolph <randolph@andestech.com>, Michal Simek <michal.simek@amd.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>,
 Ben Dooks <ben.dooks@codethink.co.uk>,
 Samuel Holland <samuel@sholland.org>,
 Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v1 2/3] riscv: cache: Add CBO instructions
Date: Tue, 20 Aug 2024 09:37:51 +0000
Message-Id: <20240820093800.5436-3-mchitale@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240820093800.5436-1-mchitale@ventanamicro.com>
References: <20240820093800.5436-1-mchitale@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Define CBO inval and flush instructions and use those for the
dcache inval and flush operations respectively.

Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
---
 arch/riscv/Kconfig             |  4 ++
 arch/riscv/include/asm/cache.h |  3 ++
 arch/riscv/lib/cache.c         | 90 ++++++++++++++++++++++++++++++++++
 3 files changed, 97 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index fa3b016c52..0f89d07be7 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -310,6 +310,10 @@ endmenu
 config RISCV_ISA_A
 	def_bool y
 
+config RISCV_ISA_ZICBOM
+	bool "Zicbom support"
+	depends on !SYS_DISABLE_DCACHE_OPS
+
 config DMA_ADDR_T_64BIT
 	bool
 	default y if 64BIT
diff --git a/arch/riscv/include/asm/cache.h b/arch/riscv/include/asm/cache.h
index 874963d731..42dbce5b4f 100644
--- a/arch/riscv/include/asm/cache.h
+++ b/arch/riscv/include/asm/cache.h
@@ -9,6 +9,9 @@
 
 /* cache */
 void cache_flush(void);
+void riscv_zicbom_init(void);
+void cbo_flush(unsigned long start, unsigned long end);
+void cbo_inval(unsigned long start, unsigned long end);
 
 /*
  * The current upper bound for RISCV L1 data cache line sizes is 32 bytes.
diff --git a/arch/riscv/lib/cache.c b/arch/riscv/lib/cache.c
index afad7e117f..456353d9c1 100644
--- a/arch/riscv/lib/cache.c
+++ b/arch/riscv/lib/cache.c
@@ -5,6 +5,95 @@
  */
 
 #include <cpu_func.h>
+#include <dm.h>
+#include <asm/insn-def.h>
+#include <linux/const.h>
+
+#define CBO_INVAL(base)						\
+	INSN_I(OPCODE_MISC_MEM, FUNC3(2), __RD(0),		\
+	       RS1(base), SIMM12(0))
+#define CBO_CLEAN(base)						\
+	INSN_I(OPCODE_MISC_MEM, FUNC3(2), __RD(0),		\
+	       RS1(base), SIMM12(1))
+#define CBO_FLUSH(base)						\
+	INSN_I(OPCODE_MISC_MEM, FUNC3(2), __RD(0),		\
+	       RS1(base), SIMM12(2))
+enum {
+	CBO_CLEAN,
+	CBO_FLUSH,
+	CBO_INVAL
+} riscv_cbo_ops;
+static int zicbom_block_size;
+
+static inline void do_cbo_clean(unsigned long base)
+{
+	asm volatile ("add a0, %0, zero\n" CBO_CLEAN(%0) ::
+		      "r"(base) : "memory");
+}
+
+static inline void do_cbo_flush(unsigned long base)
+{
+	asm volatile ("add a0, %0, zero\n" CBO_FLUSH(%0) ::
+		      "r"(base) : "memory");
+}
+
+static inline void do_cbo_inval(unsigned long base)
+{
+	asm volatile ("add a0, %0, zero\n" CBO_INVAL(%0) ::
+		      "r"(base) : "memory");
+}
+
+static void cbo_op(int op_type, unsigned long start,
+		   unsigned long end)
+{
+	unsigned long op_size = end - start, size = 0;
+	void (*fn)(unsigned long base);
+
+	switch (op_type) {
+	case CBO_CLEAN:
+		fn = do_cbo_clean;
+		break;
+	case CBO_FLUSH:
+		fn = do_cbo_flush;
+		break;
+	case CBO_INVAL:
+		fn = do_cbo_inval;
+		break;
+	}
+	start &= ~(UL(zicbom_block_size - 1));
+	while (size < op_size) {
+		fn(start + size);
+		size += zicbom_block_size;
+	}
+}
+
+void cbo_flush(unsigned long start, unsigned long end)
+{
+	if (zicbom_block_size)
+		cbo_op(CBO_FLUSH, start, end);
+}
+
+void cbo_inval(unsigned long start, unsigned long end)
+{
+	if (zicbom_block_size)
+		cbo_op(CBO_INVAL, start, end);
+}
+
+void riscv_zicbom_init(void)
+{
+	struct udevice *dev;
+
+	if (!CONFIG_IS_ENABLED(RISCV_ISA_ZICBOM))
+		return;
+
+	uclass_first_device(UCLASS_CPU, &dev);
+	if (!dev) {
+		log_err("Failed to get cpu device!\n");
+		return;
+	}
+
+	(void)dev_read_u32(dev, "riscv,cbom-block-size", &zicbom_block_size);
+}
 
 void invalidate_icache_all(void)
 {
@@ -72,4 +161,5 @@ __weak int dcache_status(void)
 
 __weak void enable_caches(void)
 {
+	puts("WARNING: Caches not enabled\n");
 }
-- 
2.34.1

