Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A3E9C52D6F
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 16:21:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD64588E39;
	Wed, 21 Aug 2024 18:19:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dFprjd0+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B103C88E34; Wed, 21 Aug 2024 18:19:50 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 949F488E0E
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 18:19:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-70968db52d0so6964991a34.3
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 09:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724257187; x=1724861987; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mAFY6rrl0ebeYcHUMBB9c7si/T0IAblqWs8Qz5P3+ZQ=;
 b=dFprjd0+Ncc8UI24Jw3wcNpAXDuKX0osKKFGi3qA60EwlfQiUBqVuBXvgweUccwmzV
 YvyGoG0c38y4BJ48s1hKLF3LcR2XZHjh5j02Bp19bp30UYuZnEkfPEfZ8TJg7o3R7DVG
 wKd94im8jOSDMp2zOWOpZsWARk4qlfAaBqh+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724257187; x=1724861987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mAFY6rrl0ebeYcHUMBB9c7si/T0IAblqWs8Qz5P3+ZQ=;
 b=tggmWhKrzcGi/WSptq1r0v4hneOBI2iRH6fXt3jP19Mntt8rkBUJ3QJLgh3T8VDgoE
 tPGfgXKF9Pku1GYMwWGQNNajcx/qyIxT0A1UDMKuNOgG7KnxrcMitD2hv0vglvfs3XJx
 OcA18NpRBZDSeyZg2gXpVAIYNWRUYB9CgX6B8orazEHsfZ6xKtJPhUEo1CoxiquXfN7q
 gDzgBQ5WdvbDA5QmOALai0ZsiM/ATZH1+KDlmzfi1+U0ZnAq49HdcBZadLIsYcWxnkek
 7rvwoQZCUogpMspo50DLS2cAFtkFlD8Dy1B14XsemuwyLB8CLa+jvJCsY7T+Z3u4jt6O
 ErEA==
X-Gm-Message-State: AOJu0YxHOno8dFhmhAVZlv6JZd7Pcqs913BXQpS7LLh3mxqex5XoySd8
 rCRXRPMqUXq51h3XOL14FpEWgrKi/it0X+etBq9/z74SfIytNeJVRa+pfhg2as9Yqp16rb+iidM
 =
X-Google-Smtp-Source: AGHT+IH4I3aT+wM3JMxtOdj5MKgduZxgxGhDtGIUvauV4rFXdTROwEUpzlbRMACK/gfQbKRh5BIGhA==
X-Received: by 2002:a05:6830:6517:b0:70a:948c:6b3f with SMTP id
 46e09a7af769-70df870b7b6mr3803731a34.12.1724257187267; 
 Wed, 21 Aug 2024 09:19:47 -0700 (PDT)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70ca6629792sm3222376a34.72.2024.08.21.09.19.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 09:19:46 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 13/35] global_data: Remove pci_ram_top
Date: Wed, 21 Aug 2024 10:19:05 -0600
Message-Id: <20240821161927.695717-14-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821161927.695717-1-sjg@chromium.org>
References: <20240821161927.695717-1-sjg@chromium.org>
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

This field is set but not used. Drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/arm/mach-tegra/board2.c      |  4 ----
 arch/arm/mach-tegra/cboot.c       |  4 ----
 arch/x86/cpu/i386/cpu.c           |  8 --------
 include/asm-generic/global_data.h | 10 ----------
 4 files changed, 26 deletions(-)

diff --git a/arch/arm/mach-tegra/board2.c b/arch/arm/mach-tegra/board2.c
index 479137e457c..7971e3b68d5 100644
--- a/arch/arm/mach-tegra/board2.c
+++ b/arch/arm/mach-tegra/board2.c
@@ -423,10 +423,6 @@ int dram_init_banksize(void)
 	gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
 	gd->bd->bi_dram[0].size = usable_ram_size_below_4g();
 
-#ifdef CONFIG_PCI
-	gd->pci_ram_top = gd->bd->bi_dram[0].start + gd->bd->bi_dram[0].size;
-#endif
-
 #ifdef CONFIG_PHYS_64BIT
 	if (gd->ram_size > SZ_2G) {
 		gd->bd->bi_dram[1].start = 0x100000000;
diff --git a/arch/arm/mach-tegra/cboot.c b/arch/arm/mach-tegra/cboot.c
index c12543d71ac..e2342b2aece 100644
--- a/arch/arm/mach-tegra/cboot.c
+++ b/arch/arm/mach-tegra/cboot.c
@@ -189,10 +189,6 @@ int cboot_dram_init_banksize(void)
 		gd->bd->bi_dram[i].size = tegra_mem_map[1 + i].size;
 	}
 
-#ifdef CONFIG_PCI
-	gd->pci_ram_top = ram_top;
-#endif
-
 	return 0;
 }
 
diff --git a/arch/x86/cpu/i386/cpu.c b/arch/x86/cpu/i386/cpu.c
index db2727d7485..934e98ac582 100644
--- a/arch/x86/cpu/i386/cpu.c
+++ b/arch/x86/cpu/i386/cpu.c
@@ -412,12 +412,6 @@ int cpu_phys_address_size(void)
 	return 32;
 }
 
-/* Don't allow PCI region 3 to use memory in the 2-4GB memory hole */
-static void setup_pci_ram_top(void)
-{
-	gd_set_pci_ram_top(0x80000000U);
-}
-
 static void setup_mtrr(void)
 {
 	u64 mtrr_cap;
@@ -469,7 +463,6 @@ int x86_cpu_init_f(void)
 		setup_cpu_features();
 	setup_identity();
 	setup_mtrr();
-	setup_pci_ram_top();
 
 	/* Set up the i8254 timer if required */
 	if (IS_ENABLED(CONFIG_I8254_TIMER))
@@ -483,7 +476,6 @@ int x86_cpu_reinit_f(void)
 	long addr;
 
 	setup_identity();
-	setup_pci_ram_top();
 	addr = locate_coreboot_table();
 	if (addr >= 0) {
 		gd->arch.coreboot_table = addr;
diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index 0e276c5dece..1db1fb651db 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -303,10 +303,6 @@ s	 * @timer: timer instance for Driver Model
 	 * @hose: PCI hose for early use
 	 */
 	struct pci_controller *hose;
-	/**
-	 * @pci_ram_top: top of region accessible to PCI
-	 */
-	phys_addr_t pci_ram_top;
 #endif
 #ifdef CONFIG_PCI_BOOTDELAY
 	/**
@@ -565,12 +561,6 @@ static_assert(sizeof(struct global_data) == GD_SIZE);
 #define gd_set_malloc_start(val)
 #endif
 
-#if CONFIG_IS_ENABLED(PCI)
-#define gd_set_pci_ram_top(val)	gd->pci_ram_top = val
-#else
-#define gd_set_pci_ram_top(val)
-#endif
-
 #if CONFIG_VAL(SYS_MALLOC_F_LEN)
 #define gd_malloc_ptr()		gd->malloc_ptr
 #else
-- 
2.34.1

