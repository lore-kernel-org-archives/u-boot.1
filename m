Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 325C4C54E67
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 11:15:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D16DC880A6;
	Wed, 27 Mar 2024 12:14:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="EaRVNboO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B812488058; Wed, 27 Mar 2024 09:10:58 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A444587BAF
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 09:10:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=wefu@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711527055;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ichncZ0GpcF9pwEU5agmvKhoFyV7ZHIvBtIQMcePSg4=;
 b=EaRVNboOShAugI8mP1laeSggG+0bBIE4Hdm1AgrAa2Zqvy0vHWcS2uVBb1YBguYl/6lgOL
 1eJZnluuTOfxmYvfOPiiiiaoztNXXLGpYJzkdwJrkM/MBp3KnwCAl3bkasj55OFqfbxHrb
 CedVt3XPaTrmIIOI/5CQsFvcsY4vP9k=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-r2FK6-_oOhKV5mMhXAC_WA-1; Wed, 27 Mar 2024 04:10:54 -0400
X-MC-Unique: r2FK6-_oOhKV5mMhXAC_WA-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-5c65e666609so5339701a12.1
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 01:10:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711527052; x=1712131852;
 h=content-transfer-encoding:mime-version:reply-to:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ichncZ0GpcF9pwEU5agmvKhoFyV7ZHIvBtIQMcePSg4=;
 b=c1a2sfqrmpzI2te9pAT4ZAzAcVBU0h9MNrCIU3k8VvpSZAm6zukPywekJtlr4/q4/H
 YYwxabO/6A0UAcB2Vczn9Xy2WbqnRKoqXhLdPS9QxPUNMYWVYUkid+ZQHsgtHSbhOHEv
 qGh2qfUdy9Hq7FxaAHo8gfoskUe1+dUqvRKIBuPgn3kTT1mQp6Hie5C7CbGx4V11//7F
 dAtucHXRw3XpkAWRn4GuUa6AiRpmRmSo+R5z2LpV9JK+dnOxMFdMCOhhuu0etnYr9x2T
 XXutBCVfHqoMSE05SUPsY5MeRUubzLHKU5bUWJkzUVJIcaD8yA/15hVcGJVQ+WEHRbfT
 pl6g==
X-Gm-Message-State: AOJu0YzVElldH3kMFX/7QDj3hha9+G41K8h27TQUtxd2078nVt9TJDcZ
 hhvxv45kgrYaT4bLZvOLXS7QmWXmUKVT5HMsoqbeiHaOmr9jGeyupLKHaaUQykSaGGDCVguHUBo
 D/aI/pxwy/R0HdSPaWeCaA0qswwn4FIiNvZhD//foDp5yLFwKQyxow5ExOM39tYO6IngXEIEIs9
 Z9USrEKcXJ/BeGeOD7pOH3Y1sshzlUCSkeMWc=
X-Received: by 2002:a05:6a21:188:b0:1a3:5299:1648 with SMTP id
 le8-20020a056a21018800b001a352991648mr3676605pzb.16.1711527052540; 
 Wed, 27 Mar 2024 01:10:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsUaQAuIdXlewTMKU3qZ9E3b/Lxy/tWB21BdExy0rZv4m00j4zFc9F2iauP+ihlWD5428xKA==
X-Received: by 2002:a05:6a21:188:b0:1a3:5299:1648 with SMTP id
 le8-20020a056a21018800b001a352991648mr3676567pzb.16.1711527052156; 
 Wed, 27 Mar 2024 01:10:52 -0700 (PDT)
Received: from localhost.localdomain ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 n15-20020a170902d2cf00b001dcfaab3457sm8293709plc.104.2024.03.27.01.10.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 01:10:51 -0700 (PDT)
From: wefu@redhat.com
To: u-boot@lists.denx.de, bmeng@tinylab.org, rick@andestech.com,
 trini@konsulko.com, wefu@redhat.com, dlan@gentoo.org,
 joe.hershberger@ni.com, rfried.dev@gmail.com, ypron.glpk@gmx.de,
 michal.simek@amd.com, randolph@andestech.com, seashell11234455@gmail.com,
 peterlin@andestech.com, samuel@sholland.org, wiagn233@outlook.com,
 jonas@kwiboo.se, seanga2@gmail.com, baruch@tkos.co.il,
 kever.yang@rock-chips.com, sjg@chromium.org, gilbsgilbert@gmail.com,
 ycliang@andestech.com
Cc: tekkamanninja@gmail.com,
	tekkamanninja@163.com
Subject: [PATCH 1/6] cpu: add t-head's c9xx
Date: Wed, 27 Mar 2024 16:07:22 +0800
Message-ID: <20240327080817.44501-2-wefu@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240327080817.44501-1-wefu@redhat.com>
References: <20240327080817.44501-1-wefu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Approved-At: Wed, 27 Mar 2024 12:14:56 +0100
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
Reply-To: wefu@redhat.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Wei Fu <wefu@redhat.com>

Signed-off-by: Wei Fu <wefu@redhat.com>
Co-authored-by: Yixun Lan <dlan@gentoo.org>
---
 arch/riscv/Kconfig               |  1 +
 arch/riscv/cpu/c9xx/Kconfig      | 12 ++++++++
 arch/riscv/cpu/c9xx/Makefile     |  5 ++++
 arch/riscv/cpu/c9xx/cpu.c        | 51 ++++++++++++++++++++++++++++++++
 arch/riscv/cpu/c9xx/dram.c       | 36 ++++++++++++++++++++++
 arch/riscv/include/asm/csr.h     |  2 ++
 board/thead/th1520_lpi4a/Kconfig |  3 +-
 7 files changed, 109 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index ac52c5e6da..ac3b802abe 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -97,6 +97,7 @@ source "arch/riscv/cpu/fu540/Kconfig"
 source "arch/riscv/cpu/fu740/Kconfig"
 source "arch/riscv/cpu/generic/Kconfig"
 source "arch/riscv/cpu/jh7110/Kconfig"
+source "arch/riscv/cpu/c9xx/Kconfig"
 
 # architecture-specific options below
 
diff --git a/arch/riscv/cpu/c9xx/Kconfig b/arch/riscv/cpu/c9xx/Kconfig
new file mode 100644
index 0000000000..5a84bcacd6
--- /dev/null
+++ b/arch/riscv/cpu/c9xx/Kconfig
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2017-2020 Alibaba Group Holding Limited
+
+config RISCV_THEAD
+	bool
+	select ARCH_EARLY_INIT_R
+	imply CPU
+	imply CPU_RISCV
+	imply RISCV_TIMER
+	imply RISCV_RDTIME
+	imply CMD_CPU
diff --git a/arch/riscv/cpu/c9xx/Makefile b/arch/riscv/cpu/c9xx/Makefile
new file mode 100644
index 0000000000..e3f776cb41
--- /dev/null
+++ b/arch/riscv/cpu/c9xx/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2017-2020 Alibaba Group Holding Limited
+
+obj-y += cpu.o dram.o
diff --git a/arch/riscv/cpu/c9xx/cpu.c b/arch/riscv/cpu/c9xx/cpu.c
new file mode 100644
index 0000000000..4b21edd62b
--- /dev/null
+++ b/arch/riscv/cpu/c9xx/cpu.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2017-2020 Alibaba Group Holding Limited
+ */
+
+#include <asm/cache.h>
+#include <asm/csr.h>
+#include <cpu_func.h>
+
+/*
+ * cleanup_before_linux() is called just before we call linux
+ * it prepares the processor for linux
+ *
+ * we disable interrupt and caches.
+ */
+int cleanup_before_linux(void)
+{
+	cache_flush();
+
+	return 0;
+}
+
+void flush_dcache_range(unsigned long start, unsigned long end)
+{
+	register unsigned long i asm("a0") = start & ~(CONFIG_SYS_CACHELINE_SIZE - 1);
+
+	for (; i < end; i += CONFIG_SYS_CACHELINE_SIZE)
+		asm volatile(".long 0x0295000b");  /* dcache.cpa a0 */
+
+	sync_is();
+}
+
+void invalidate_dcache_range(unsigned long start, unsigned long end)
+{
+	register unsigned long i asm("a0") = start & ~(CONFIG_SYS_CACHELINE_SIZE - 1);
+
+	for (; i < end; i += CONFIG_SYS_CACHELINE_SIZE)
+		asm volatile(".long 0x02b5000b");  /* dcache.cipa a0 */
+
+	sync_is();
+}
+
+void invalid_dcache_range(unsigned long start, unsigned long end)
+{
+	register unsigned long i asm("a0") = start & ~(CONFIG_SYS_CACHELINE_SIZE - 1);
+
+	for (; i < end; i += CONFIG_SYS_CACHELINE_SIZE)
+		asm volatile(".long 0x02a5000b");  /* dcache.ipa a0 */
+
+	sync_is();
+}
diff --git a/arch/riscv/cpu/c9xx/dram.c b/arch/riscv/cpu/c9xx/dram.c
new file mode 100644
index 0000000000..614d7bf1cc
--- /dev/null
+++ b/arch/riscv/cpu/c9xx/dram.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2018, Bin Meng <bmeng.cn@gmail.com>
+ */
+
+#include <fdtdec.h>
+#include <init.h>
+#include <linux/sizes.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int dram_init(void)
+{
+	return fdtdec_setup_mem_size_base();
+}
+
+int dram_init_banksize(void)
+{
+	return fdtdec_setup_memory_banksize();
+}
+
+phys_size_t board_get_usable_ram_top(phys_size_t total_size)
+{
+	/*
+	 * Ensure that we run from first 4GB so that all
+	 * addresses used by U-Boot are 32bit addresses.
+	 *
+	 * This in-turn ensures that 32bit DMA capable
+	 * devices work fine because DMA mapping APIs will
+	 * provide 32bit DMA addresses only.
+	 */
+	if (gd->ram_top >= SZ_4G)
+		return SZ_4G - 1;
+
+	return gd->ram_top;
+}
diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 986f951c31..3102de6cbb 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -145,6 +145,8 @@
 #define CSR_MARCHID		0xf12
 #define CSR_MHARTID		0xf14
 
+#define sync_is()   asm volatile (".long 0x01b0000b")
+
 #ifndef __ASSEMBLY__
 
 #define csr_swap(csr, val)					\
diff --git a/board/thead/th1520_lpi4a/Kconfig b/board/thead/th1520_lpi4a/Kconfig
index 622246127c..bef0638e80 100644
--- a/board/thead/th1520_lpi4a/Kconfig
+++ b/board/thead/th1520_lpi4a/Kconfig
@@ -11,7 +11,7 @@ config SYS_VENDOR
 	default "thead"
 
 config SYS_CPU
-	default "generic"
+	default "c9xx"
 
 config SYS_CONFIG_NAME
 	default "th1520_lpi4a"
@@ -30,6 +30,7 @@ config SPL_OPENSBI_LOAD_ADDR
 config BOARD_SPECIFIC_OPTIONS
 	def_bool y
 	select ARCH_EARLY_INIT_R
+	select RISCV_THEAD
 	imply CPU
 	imply CPU_RISCV
 	imply RISCV_TIMER if RISCV_SMODE
-- 
2.44.0

