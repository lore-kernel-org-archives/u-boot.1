Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAC65C02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 13:16:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 772F780834;
	Wed,  5 Feb 2025 14:15:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="P+/6aCeV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE046805D7; Wed,  5 Feb 2025 08:17:58 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADB7380207
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 08:17:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5dca468c5e4so6015081a12.1
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 23:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738739876; x=1739344676; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/x0YKAnL00eTuwXFVQ8eQUflm3OpI1I778TGY4W49Os=;
 b=P+/6aCeVpKxRW/Rs9Dpr6G21S4saLwsTVYupH4s+eKhVSe4X1IGDaa+yGnXoLXv9QF
 P4l95P2mC05KhUbO/HfjyO7qhdsc/ZV3r64QMRcaVPNpmUJ0Mg6OAPss6LGVc4Ied9WW
 PYe2tQYeA1Y6g8uSuplp4cvwfO6fJrRFHsRHeU2s5u68LROqwJbPNoFF2ywgVmbM5ndE
 MMy7oJbXgNKo00dfzasevfPAG4l7+QiNKzFKrl/NSCYXqBkA0AMdtmG3K/+hRj12IB2H
 Q8vh94KHcstKs7PRegNcpP/aAAnpk0NqV7JRfQ8xdWYzurPJsODYtRK0JRKCLKxvV88y
 P+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738739876; x=1739344676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/x0YKAnL00eTuwXFVQ8eQUflm3OpI1I778TGY4W49Os=;
 b=WsssAsFqQGK6pApaA03AEx5V54hrwO9PnPxcatHhTOS5bedsj2aMPpL0DSLtwsOTFQ
 xm9muoARpCPqtiDI5VZL1M3JpkzUVvP5IqwJk3/bFWA/j2hjZaGbx776l7+zsmIZbkYx
 xWKnOwTUm6+U/tCgiugmc/wRV6P/EI4QRfnsnKNVyvQtTIRzNLsnSu+KwCl3cTRXyJWe
 xPVkBMzlBAWX4SnZM7sMWBlr8r/K8THbSvw86ExT2gviH0N4q57wXLfjF6xkb3errcJg
 TkN3VoE3EcKxvGLGI5fZYuViYLIsZ2BTyibI2bKYCjC2xBAXaNmr7KQy5BD3ciggiAiF
 t+Lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0K5ObIYsTci8eA5Qko2/za0p4N6o8woG2PlSn2Yp/m4P/dC+noJWYAW6oNlGOBdjacSfYeEs=@lists.denx.de
X-Gm-Message-State: AOJu0YxfnxnrsIKfhZVrr4VzUs60sytY/5jcUvwzHa++deXIqCvlGgJE
 EWzO+xn099qJEGzJsimeWkZHpGRwO/BerBrXBmBBOCv9Ri3H4VJFQfqr0NBhcX4=
X-Gm-Gg: ASbGnctlEDmQcUDgD5Tz1xTSvls3TFeJvfGMlDOPUC1GmApXIrwQDsXS9NfupsWYr3M
 rGdVni6PdElGEp8eZj78tleYF9XNBAtFDa9I1d0+0gE6FFclQ+PvOJ+HM7Xxv4n2ZD60+DP0RSD
 kcTxJ7ZyQS73HHPbPM2bQ2jyz6q2nCSdKqFgcrIijaR7nD04wTpclO6KDVHVrqDgWZZz8sEFTHZ
 gKgIW0+UxnUaWFCMJ/qzrn95qh/2900cYV7/9GVEhb0biULK0X/6GwCYJI0gdYtAEi2CTg5x6Xi
 z9XwYxJUMszRhW7oKDUjk+Kx50CLqYXiUa7MCWQCGEKPKOuoBE9FEnUOrNOT+vXZY7sE
X-Google-Smtp-Source: AGHT+IE6fffmE1bF6GxbQhyb/pwv3wzgXGqMBhIZ84RhS0wsezg10HpOLbnCaW+KutT37NUCt/303A==
X-Received: by 2002:a05:6402:5299:b0:5dc:8fb1:d43e with SMTP id
 4fb4d7f45d1cf-5dcdb732c95mr1882765a12.12.1738739876138; 
 Tue, 04 Feb 2025 23:17:56 -0800 (PST)
Received: from localhost.localdomain (ppp176092167070.access.hol.gr.
 [176.92.167.70]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dcda28cbcesm1107191a12.43.2025.02.04.23.17.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 23:17:55 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de,
	trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Marek Vasut <marex@denx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 =?UTF-8?q?Pierre-Cl=C3=A9ment=20Tosi?= <ptosi@google.com>,
 Peng Fan <peng.fan@nxp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>, Peter Hoyes <Peter.Hoyes@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, Sam Day <me@samcday.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Stefan Roese <sr@denx.de>,
 Alex Shumsky <alexthreed@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Joshua Watt <jpewhacker@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Jonas Jelonek <jelonek.jonas@gmail.com>, uboot-snps-arc@synopsys.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v1 5/6] treewide: Add a function to change page permissions
Date: Wed,  5 Feb 2025 09:16:49 +0200
Message-ID: <20250205071714.635518-6-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250205071714.635518-1-ilias.apalodimas@linaro.org>
References: <20250205071714.635518-1-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 05 Feb 2025 14:15:26 +0100
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

For armv8 we are adding proper page permissions for the relocated U-Boot
binary. Add a weak function that can be used across architectures to change
the page permissions

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 arch/arc/lib/cache.c           |  2 ++
 arch/arm/cpu/arm926ejs/cache.c |  2 ++
 arch/arm/cpu/armv7/cache_v7.c  |  1 +
 arch/arm/cpu/armv7m/cache.c    |  2 ++
 arch/arm/cpu/armv8/cache_v8.c  | 22 ++++++++++++++++++++++
 arch/arm/lib/cache.c           |  2 ++
 arch/m68k/lib/cache.c          |  2 ++
 arch/nios2/lib/cache.c         |  2 ++
 arch/powerpc/lib/cache.c       |  2 ++
 arch/riscv/lib/cache.c         |  2 ++
 arch/sh/cpu/sh4/cache.c        |  2 ++
 arch/xtensa/lib/cache.c        |  2 ++
 include/cpu_func.h             | 16 ++++++++++++++++
 13 files changed, 59 insertions(+)

diff --git a/arch/arc/lib/cache.c b/arch/arc/lib/cache.c
index 5169fc627fa5..5c79243d7223 100644
--- a/arch/arc/lib/cache.c
+++ b/arch/arc/lib/cache.c
@@ -819,3 +819,5 @@ void sync_n_cleanup_cache_all(void)
 
 	__ic_entire_invalidate();
 }
+
+void __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm) {}
diff --git a/arch/arm/cpu/arm926ejs/cache.c b/arch/arm/cpu/arm926ejs/cache.c
index 5b87a3af91b2..857311b3dfad 100644
--- a/arch/arm/cpu/arm926ejs/cache.c
+++ b/arch/arm/cpu/arm926ejs/cache.c
@@ -88,3 +88,5 @@ void enable_caches(void)
 	dcache_enable();
 #endif
 }
+
+void __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm) {}
diff --git a/arch/arm/cpu/armv7/cache_v7.c b/arch/arm/cpu/armv7/cache_v7.c
index d11420d2fdd0..14c9be77db8d 100644
--- a/arch/arm/cpu/armv7/cache_v7.c
+++ b/arch/arm/cpu/armv7/cache_v7.c
@@ -209,3 +209,4 @@ __weak void v7_outer_cache_flush_all(void) {}
 __weak void v7_outer_cache_inval_all(void) {}
 __weak void v7_outer_cache_flush_range(u32 start, u32 end) {}
 __weak void v7_outer_cache_inval_range(u32 start, u32 end) {}
+__weak void pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm) {}
diff --git a/arch/arm/cpu/armv7m/cache.c b/arch/arm/cpu/armv7m/cache.c
index b6d08b7aad73..458a214e9577 100644
--- a/arch/arm/cpu/armv7m/cache.c
+++ b/arch/arm/cpu/armv7m/cache.c
@@ -370,3 +370,5 @@ void enable_caches(void)
 	dcache_enable();
 #endif
 }
+
+void __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm) {}
diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
index 670379e17b7a..1cf3870177ee 100644
--- a/arch/arm/cpu/armv8/cache_v8.c
+++ b/arch/arm/cpu/armv8/cache_v8.c
@@ -1028,6 +1028,28 @@ skip_break:
 	__asm_invalidate_tlb_all();
 }
 
+void pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm)
+{
+	u64 attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_INNER_SHARE | PTE_TYPE_VALID;
+
+	switch (perm) {
+	case MMU_ATTR_RO:
+		attrs |= PTE_BLOCK_PXN | PTE_BLOCK_UXN | PTE_BLOCK_RO;
+		break;
+	case MMU_ATTR_RX:
+		attrs |= PTE_BLOCK_RO;
+		break;
+	case MMU_ATTR_RW:
+		attrs |= PTE_BLOCK_PXN | PTE_BLOCK_UXN;
+		break;
+	default:
+		log_err("Unknown attribute %llx\n", perm);
+		return;
+	}
+
+	mmu_change_region_attr(addr, size, attrs, false);
+}
+
 #else	/* !CONFIG_IS_ENABLED(SYS_DCACHE_OFF) */
 
 /*
diff --git a/arch/arm/lib/cache.c b/arch/arm/lib/cache.c
index 516754caeaf9..c7704d8ee354 100644
--- a/arch/arm/lib/cache.c
+++ b/arch/arm/lib/cache.c
@@ -170,3 +170,5 @@ __weak int arm_reserve_mmu(void)
 
 	return 0;
 }
+
+void __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm) {}
diff --git a/arch/m68k/lib/cache.c b/arch/m68k/lib/cache.c
index 370ad40f1423..b275646384a5 100644
--- a/arch/m68k/lib/cache.c
+++ b/arch/m68k/lib/cache.c
@@ -151,3 +151,5 @@ __weak void flush_dcache_range(unsigned long start, unsigned long stop)
 {
 	/* An empty stub, real implementation should be in platform code */
 }
+
+void __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm) {}
diff --git a/arch/nios2/lib/cache.c b/arch/nios2/lib/cache.c
index 8f543f2a2f26..7a93a8fcc6a7 100644
--- a/arch/nios2/lib/cache.c
+++ b/arch/nios2/lib/cache.c
@@ -127,3 +127,5 @@ void dcache_disable(void)
 {
 	flush_dcache_all();
 }
+
+void __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm) {}
diff --git a/arch/powerpc/lib/cache.c b/arch/powerpc/lib/cache.c
index a9cd7b8d30ac..3d0536caccde 100644
--- a/arch/powerpc/lib/cache.c
+++ b/arch/powerpc/lib/cache.c
@@ -58,3 +58,5 @@ void invalidate_icache_all(void)
 {
 	puts("No arch specific invalidate_icache_all available!\n");
 }
+
+void __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm) {}
diff --git a/arch/riscv/lib/cache.c b/arch/riscv/lib/cache.c
index 71e4937ab542..1c751e562157 100644
--- a/arch/riscv/lib/cache.c
+++ b/arch/riscv/lib/cache.c
@@ -151,3 +151,5 @@ __weak void enable_caches(void)
 	if (!zicbom_block_size)
 		log_debug("Zicbom not initialized.\n");
 }
+
+void __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm) {}
diff --git a/arch/sh/cpu/sh4/cache.c b/arch/sh/cpu/sh4/cache.c
index 99acc5999652..22e0f1484a33 100644
--- a/arch/sh/cpu/sh4/cache.c
+++ b/arch/sh/cpu/sh4/cache.c
@@ -126,3 +126,5 @@ int dcache_status(void)
 {
 	return 0;
 }
+
+void __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm) {}
diff --git a/arch/xtensa/lib/cache.c b/arch/xtensa/lib/cache.c
index e6a7f6827fc2..aacc2d2627d6 100644
--- a/arch/xtensa/lib/cache.c
+++ b/arch/xtensa/lib/cache.c
@@ -57,3 +57,5 @@ void invalidate_icache_all(void)
 {
 	__invalidate_icache_all();
 }
+
+void __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm) {}
diff --git a/include/cpu_func.h b/include/cpu_func.h
index 7e81c4364a73..17b6d199302a 100644
--- a/include/cpu_func.h
+++ b/include/cpu_func.h
@@ -69,6 +69,22 @@ void flush_dcache_range(unsigned long start, unsigned long stop);
 void invalidate_dcache_range(unsigned long start, unsigned long stop);
 void invalidate_dcache_all(void);
 void invalidate_icache_all(void);
+
+enum pgprot_attrs {
+	MMU_ATTR_RO,
+	MMU_ATTR_RX,
+	MMU_ATTR_RW,
+};
+
+/** pgprot_set_attrs() - Set page table permissions
+ *
+ * @addr: Physical address start
+ * @size: size of memory to change
+ * @perm: New permissions
+ *
+ **/
+void pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm);
+
 /**
  * noncached_init() - Initialize non-cached memory region
  *
-- 
2.47.2

