Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A17B9C531DC
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 09:42:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB68188861;
	Fri, 23 Aug 2024 11:42:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="YYY/p8cf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EBDE8888F; Fri, 23 Aug 2024 11:42:04 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3205288216
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 11:42:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-42809d6e719so13146525e9.3
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 02:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1724406121; x=1725010921; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SAAGco1i3RIFgkRFfZ2YuxlwK0wGtvkVJFRR6Kz6dI0=;
 b=YYY/p8cfZPWwVlCAlLu5gIhq5xmvVBrbvbWAllMKJRaTBjTzW+L+oheQ8yafFH6n3d
 Yn2IkPaCCi6X/fjEthOlptCrBvbQW4bqaE1Q8gxrcAFB1W9rKv55WpDIuLfajZVc7LXh
 qnZ297SjW7tScuMfvD6BA4HK0cFq3B0rU0E16i73S2Yz7Vn6S2GIl8LzHXoBOYGRKjQk
 M8ln+Yiebgt5bwFDEVLkXOcuQ1PuIizwqFX7KGM4OoVyHMh5iIpWpm7ckJisXaq0jwSd
 teBTxLBKRdOLx4aZvtgnoNZVKsu4ZA/Yfdk6KUPWoTb6MQ3za1QrreTWpvM6P31ACqoc
 TsVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724406121; x=1725010921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SAAGco1i3RIFgkRFfZ2YuxlwK0wGtvkVJFRR6Kz6dI0=;
 b=hf4rrGBgcv853CzaGv0snlcPvtqKOlQK8R34me7JLH5uKdQUDj5q4nC3xxAtJ7WRR8
 XGW83Gi8zNE3u2n2LuMp7meVck01VK7VHPfBBZS3Qcfti1dMi5R3/zHJoHhiQ97o+kxw
 GJgZRAL4KBsCzwlhCBbZZL99BnB1diVrWe7a5i2vBKihcJZ0gOs6NNRmZ+RUlizjGgfe
 bwC8boY0VC0NzU83Hv7IzrqeSCxaFtW2X9W1kLq9EuDq0S986yBsid7F+ugiCCTu0HpE
 ZFVtayEaBT/2ZYHDzgEfVUY4/hSd3MKqANGwgbIJxDX53tCq8H5lGu6pfMAMSMJwUzkJ
 AqpQ==
X-Gm-Message-State: AOJu0YxXDf3AgZvJ4YVuAy8+7afUp7b0tFimbJHaYrsuZM8UE9ycYoMr
 N2MHHtbPXRYk3V5dq+3/ywmRKYfUsEdnuhTDoMFzBE3h704nfOUzNb3HsD7UDMMN2GputPsigRe
 h
X-Google-Smtp-Source: AGHT+IHeVGZQgiSW/lbXBPdLsA95FqZ6Pp9erculPvvpQFExUApAF7SVQKsjgH6ofHTxHxYLK2bNNA==
X-Received: by 2002:a05:600c:3152:b0:426:6667:bbbe with SMTP id
 5b1f17b1804b1-42acc8d4aeemr12607665e9.9.1724406121014; 
 Fri, 23 Aug 2024 02:42:01 -0700 (PDT)
Received: from localhost.localdomain ([103.97.165.210])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-42ac516251fsm52909335e9.25.2024.08.23.02.41.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 02:42:00 -0700 (PDT)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: u-boot@lists.denx.de
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Randolph <randolph@andestech.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>,
 Ben Dooks <ben.dooks@codethink.co.uk>,
 Samuel Holland <samuel@sholland.org>,
 Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v2 2/2] riscv: cache: Add CBO instructions
Date: Fri, 23 Aug 2024 09:41:26 +0000
Message-Id: <20240823094127.207866-3-mchitale@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240823094127.207866-1-mchitale@ventanamicro.com>
References: <20240823094127.207866-1-mchitale@ventanamicro.com>
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
 arch/riscv/Kconfig     |  4 ++
 arch/riscv/lib/cache.c | 96 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+)

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
diff --git a/arch/riscv/lib/cache.c b/arch/riscv/lib/cache.c
index afad7e117f..e184d5e205 100644
--- a/arch/riscv/lib/cache.c
+++ b/arch/riscv/lib/cache.c
@@ -5,6 +5,98 @@
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
+static int riscv_zicbom_init(void)
+{
+	struct udevice *dev;
+
+	if (!CONFIG_IS_ENABLED(RISCV_ISA_ZICBOM) || zicbom_block_size)
+		return 1;
+
+	uclass_first_device(UCLASS_CPU, &dev);
+	if (!dev) {
+		log_debug("Failed to get cpu device!\n");
+		return 0;
+	}
+
+	if (dev_read_u32(dev, "riscv,cbom-block-size", &zicbom_block_size))
+		log_debug("riscv,cbom-block-size DT property not present\n");
+
+	return zicbom_block_size;
+}
 
 void invalidate_icache_all(void)
 {
@@ -17,6 +109,7 @@ __weak void flush_dcache_all(void)
 
 __weak void flush_dcache_range(unsigned long start, unsigned long end)
 {
+	cbo_flush(start, end);
 }
 
 __weak void invalidate_icache_range(unsigned long start, unsigned long end)
@@ -30,6 +123,7 @@ __weak void invalidate_icache_range(unsigned long start, unsigned long end)
 
 __weak void invalidate_dcache_range(unsigned long start, unsigned long end)
 {
+	cbo_inval(start, end);
 }
 
 void cache_flush(void)
@@ -72,4 +166,6 @@ __weak int dcache_status(void)
 
 __weak void enable_caches(void)
 {
+	if (!riscv_zicbom_init())
+		log_info("Zicbom not initialized.\n");
 }
-- 
2.34.1

