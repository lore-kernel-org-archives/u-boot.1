Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB79CE77180
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 10:55:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73092801ED;
	Wed, 11 Dec 2024 11:55:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Jgoe5qsC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3C8380212; Wed, 11 Dec 2024 11:55:23 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69590801EA
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 11:55:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a9a68480164so962402466b.3
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 02:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733914521; x=1734519321; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZePv0turzEJjx/RvBmyBpYP2kTWKVfhuUztW1KX614Y=;
 b=Jgoe5qsCLhTR+AQ+Uo8qxJ0V1afcDbkFTHLFeYz9u71nUorNAQg065ye0i14y9Uvgt
 ILJ4107eAnQZOVMQbUAYL7IUw+TmaRFLxobV5+OA+Za20p1ZTsiNheCxXelal7eZ9VED
 zBx+2xQAPTdgQL4LEFccx5r4yKfgci143mZJcuJwmK/0zp4F0H9Q6spyT7DijCrcSYcD
 8TTDD9EeFVQa3VeumR863XwrNQ61FfiQkqqyP2uEbcfw6rxcqBO1mRsmpUwzSEZP0byd
 ljI1yxY9PGG6Iv3x/ukBWceiVoa0n/+5OQoBFcphiLlHCTfclqW8qqS9A/Lp9pvMND56
 yp3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733914521; x=1734519321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZePv0turzEJjx/RvBmyBpYP2kTWKVfhuUztW1KX614Y=;
 b=EECwy+su5e3i7CBeTkG2tSg22dfnqCziPSivLep1jG3qcX0vjE5IfBPY9rmZ1cgiaG
 HV3BTL7T6aP69eAIftpJX6xu7X4573te94Sqzm9+8C2MQlJ/Cd3HBgWTuu9LLtmiHi7k
 k10z4+cMx8WNwJY63JQvgBFAGclGvZD1I8QulAKm8h7MN68Tu/2/l8EKuFoVlu7qFzZj
 yOhSs01VwSe8wK/Fmk14mGazqQrQb0yhT67RV4tueTaHVUxf4IqGrwxbl5bB0euCKtWq
 v8JR487DtTXYeAfy0S9Cp1IOa5hRW+bizCI0ok3gAuPhCxu0viNuuUYNI7T+PTcztMxr
 AxRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2CdBYLWHoH4jG7xMog/9AZb3M2LH11YUehy+D/bwOb3R9t2NP+cRiX6PnjTs/y7TqCiNEtp0=@lists.denx.de
X-Gm-Message-State: AOJu0YxciL8+yyZZ4CPLiGAPa1ob+tvCwM4ToTb16B0o5NvLoj2PUQSd
 3PsAUTdohmY1S92nWkCt+SoC7NgceojmNksoLdaEuQZSgZSuKHisxWJMou9bd1Y=
X-Gm-Gg: ASbGncsRKIO1sIHwaZiFDRoikK3ZQ5JcJonPsOJeLZqxDQDMVp3A8d3QVtiq6omABKu
 neWQqhGFP2dSJyOMRSir/y5gyFXghr1119fWt6W1cT2cnNXFVVNFXu6AAsNQ/pPJwxFPvBXt/YO
 79bDgwULBuKP5hl6MQa5YB+6YKpfM+74kEkKRa0GlXso3uwpOVpwyVgaIV+eLB1JSlZlSRt4p2S
 3m0yw8mslGYBeZcw650rjirUwodj4AjEveKEwHj3vuyofyUnuQW+EKJmvjJ18lLtZiwSKVS4eO/
 On3yQ1urjdLMqsG18t8Z8npbmH5kYw0=
X-Google-Smtp-Source: AGHT+IHI039hBF2fO/Nk4lFcB9J6ZkmsTxgMPC1XP4vMj/xuNJ6KPn+y6eziGbZi2S7PLrP9OFULOw==
X-Received: by 2002:a17:906:23e1:b0:aa6:7b1e:47cc with SMTP id
 a640c23a62f3a-aa6b11b3e19mr228547866b.20.1733914520658; 
 Wed, 11 Dec 2024 02:55:20 -0800 (PST)
Received: from localhost.localdomain (ppp176092181030.access.hol.gr.
 [176.92.181.30]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa67e652b1dsm508006566b.172.2024.12.11.02.55.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 02:55:20 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de,
	trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Peter Korsgaard <peter@korsgaard.com>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Nam Cao <namcao@linutronix.de>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Janne Grunau <j@jannau.net>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH v1 3/8] lmb: Remove lmb_reserve_flags()
Date: Wed, 11 Dec 2024 12:54:44 +0200
Message-ID: <20241211105504.453234-4-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241211105504.453234-1-ilias.apalodimas@linaro.org>
References: <20241211105504.453234-1-ilias.apalodimas@linaro.org>
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

lmb_reserve() is just calling lmb_reserve_flags() with LMB_NONE.
There's not much we gain from this abstraction.
So let's remove the latter, add the flags argument to lmb_reserve()
and make the code a bit easier to follow.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---
 arch/powerpc/cpu/mpc85xx/mp.c |  2 +-
 arch/powerpc/lib/misc.c       |  2 +-
 boot/bootm.c                  |  3 ++-
 boot/image-board.c            |  2 +-
 boot/image-fdt.c              |  6 ++---
 cmd/booti.c                   |  2 +-
 cmd/bootz.c                   |  2 +-
 cmd/load.c                    |  2 +-
 include/lmb.h                 | 14 ++--------
 lib/lmb.c                     | 28 ++++++++------------
 test/lib/lmb.c                | 48 +++++++++++++++++------------------
 11 files changed, 48 insertions(+), 63 deletions(-)

diff --git a/arch/powerpc/cpu/mpc85xx/mp.c b/arch/powerpc/cpu/mpc85xx/mp.c
index bed465cb2cba..8918a401fac3 100644
--- a/arch/powerpc/cpu/mpc85xx/mp.c
+++ b/arch/powerpc/cpu/mpc85xx/mp.c
@@ -412,7 +412,7 @@ void cpu_mp_lmb_reserve(void)
 {
 	u32 bootpg = determine_mp_bootpg(NULL);
 
-	lmb_reserve(bootpg, 4096);
+	lmb_reserve(bootpg, 4096, LMB_NONE);
 }
 
 void setup_mp(void)
diff --git a/arch/powerpc/lib/misc.c b/arch/powerpc/lib/misc.c
index 4cd23b3406d1..7e303419624a 100644
--- a/arch/powerpc/lib/misc.c
+++ b/arch/powerpc/lib/misc.c
@@ -40,7 +40,7 @@ int arch_misc_init(void)
 
 			printf("WARNING: adjusting available memory from 0x%lx to 0x%llx\n",
 			       size, (unsigned long long)bootm_size);
-			lmb_reserve(base, bootm_size - size);
+			lmb_reserve(base, bootm_size - size, LMB_NONE);
 		}
 
 #ifdef CONFIG_MP
diff --git a/boot/bootm.c b/boot/bootm.c
index 16a43d519a8a..854ac7ec7388 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -696,7 +696,8 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
 	}
 
 	if (CONFIG_IS_ENABLED(LMB))
-		lmb_reserve(images->os.load, (load_end - images->os.load));
+		lmb_reserve(images->os.load, (load_end - images->os.load),
+			    LMB_NONE);
 
 	return 0;
 }
diff --git a/boot/image-board.c b/boot/image-board.c
index b726bd6b3035..070ada007185 100644
--- a/boot/image-board.c
+++ b/boot/image-board.c
@@ -562,7 +562,7 @@ int boot_ramdisk_high(ulong rd_data, ulong rd_len, ulong *initrd_start,
 			debug("   in-place initrd\n");
 			*initrd_start = rd_data;
 			*initrd_end = rd_data + rd_len;
-			lmb_reserve(rd_data, rd_len);
+			lmb_reserve(rd_data, rd_len, LMB_NONE);
 		} else {
 			if (initrd_high)
 				*initrd_start = (ulong)lmb_alloc_base(rd_len,
diff --git a/boot/image-fdt.c b/boot/image-fdt.c
index cda7c3aa9e38..d717f6690729 100644
--- a/boot/image-fdt.c
+++ b/boot/image-fdt.c
@@ -72,7 +72,7 @@ static void boot_fdt_reserve_region(u64 addr, u64 size, u32 flags)
 {
 	long ret;
 
-	ret = lmb_reserve_flags(addr, size, flags);
+	ret = lmb_reserve(addr, size, flags);
 	if (!ret) {
 		debug("   reserving fdt memory region: addr=%llx size=%llx flags=%x\n",
 		      (unsigned long long)addr,
@@ -184,7 +184,7 @@ int boot_relocate_fdt(char **of_flat_tree, ulong *of_size)
 		if (desired_addr == ~0UL) {
 			/* All ones means use fdt in place */
 			of_start = fdt_blob;
-			lmb_reserve(map_to_sysmem(of_start), of_len);
+			lmb_reserve(map_to_sysmem(of_start), of_len, LMB_NONE);
 			disable_relocation = 1;
 		} else if (desired_addr) {
 			addr = lmb_alloc_base(of_len, 0x1000, desired_addr);
@@ -675,7 +675,7 @@ int image_setup_libfdt(struct bootm_headers *images, void *blob, bool lmb)
 
 	/* Create a new LMB reservation */
 	if (CONFIG_IS_ENABLED(LMB) && lmb)
-		lmb_reserve(map_to_sysmem(blob), of_size);
+		lmb_reserve(map_to_sysmem(blob), of_size, LMB_NONE);
 
 #if defined(CONFIG_ARCH_KEYSTONE)
 	if (IS_ENABLED(CONFIG_OF_BOARD_SETUP))
diff --git a/cmd/booti.c b/cmd/booti.c
index 43e79e87201b..1a57fe913977 100644
--- a/cmd/booti.c
+++ b/cmd/booti.c
@@ -87,7 +87,7 @@ static int booti_start(struct bootm_info *bmi)
 	images->os.start = relocated_addr;
 	images->os.end = relocated_addr + image_size;
 
-	lmb_reserve(images->ep, le32_to_cpu(image_size));
+	lmb_reserve(images->ep, le32_to_cpu(image_size), LMB_NONE);
 
 	/*
 	 * Handle the BOOTM_STATE_FINDOTHER state ourselves as we do not
diff --git a/cmd/bootz.c b/cmd/bootz.c
index 787203f5bd70..99318ff213f4 100644
--- a/cmd/bootz.c
+++ b/cmd/bootz.c
@@ -56,7 +56,7 @@ static int bootz_start(struct cmd_tbl *cmdtp, int flag, int argc,
 	if (ret != 0)
 		return 1;
 
-	lmb_reserve(images->ep, zi_end - zi_start);
+	lmb_reserve(images->ep, zi_end - zi_start, LMB_NONE);
 
 	/*
 	 * Handle the BOOTM_STATE_FINDOTHER state ourselves as we do not
diff --git a/cmd/load.c b/cmd/load.c
index 20d802502ae6..899bb4f598e2 100644
--- a/cmd/load.c
+++ b/cmd/load.c
@@ -179,7 +179,7 @@ static ulong load_serial(long offset)
 		    {
 			void *dst;
 
-			ret = lmb_reserve(store_addr, binlen);
+			ret = lmb_reserve(store_addr, binlen, LMB_NONE);
 			if (ret) {
 				printf("\nCannot overwrite reserved area (%08lx..%08lx)\n",
 					store_addr, store_addr + binlen);
diff --git a/include/lmb.h b/include/lmb.h
index 7db9e0b62840..9539cb67c3d7 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -78,16 +78,7 @@ void lmb_add_memory(void);
 long lmb_add(phys_addr_t base, phys_size_t size);
 
 /**
- * lmb_reserve() - Reserve a memory region (with no special flags)
- * @base: Base address of the memory region
- * @size: Size of the memory region
- *
- * Return: 0 on success, negative error code on failure.
- */
-long lmb_reserve(phys_addr_t base, phys_size_t size);
-
-/**
- * lmb_reserve_flags() - Reserve one region with a specific flags bitfield
+ * lmb_reserve() - Reserve one region with a specific flags bitfield
  * @base: Base address of the memory region
  * @size: Size of the memory region
  * @flags: Flags for the memory region
@@ -97,8 +88,7 @@ long lmb_reserve(phys_addr_t base, phys_size_t size);
  * * %-EEXIST	- The region is already added, and flags != LMB_NONE
  * * %-1	- Failure
  */
-long lmb_reserve_flags(phys_addr_t base, phys_size_t size,
-		       u32 flags);
+long lmb_reserve(phys_addr_t base, phys_size_t size, u32 flags);
 
 phys_addr_t lmb_alloc(phys_size_t size, ulong align);
 phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t max_addr);
diff --git a/lib/lmb.c b/lib/lmb.c
index edecdb8e9cbf..fd0e91981ad4 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -553,12 +553,11 @@ static void lmb_reserve_uboot_region(void)
 		if (bank_end > end)
 			bank_end = end - 1;
 
-		lmb_reserve_flags(rsv_start, bank_end - rsv_start + 1,
-				  LMB_NOOVERWRITE);
+		lmb_reserve(rsv_start, bank_end - rsv_start + 1, LMB_NOOVERWRITE);
 
 		if (gd->flags & GD_FLG_SKIP_RELOC)
-			lmb_reserve_flags((phys_addr_t)(uintptr_t)_start,
-					  gd->mon_len, LMB_NOOVERWRITE);
+			lmb_reserve((phys_addr_t)(uintptr_t)_start,
+				    gd->mon_len, LMB_NOOVERWRITE);
 
 		break;
 	}
@@ -584,7 +583,7 @@ static __maybe_unused void lmb_reserve_common_spl(void)
 	if (IS_ENABLED(CONFIG_SPL_STACK_R_ADDR)) {
 		rsv_start = gd->start_addr_sp - 16384;
 		rsv_size = 16384;
-		lmb_reserve_flags(rsv_start, rsv_size, LMB_NOOVERWRITE);
+		lmb_reserve(rsv_start, rsv_size, LMB_NOOVERWRITE);
 	}
 
 	if (IS_ENABLED(CONFIG_SPL_SEPARATE_BSS)) {
@@ -592,7 +591,7 @@ static __maybe_unused void lmb_reserve_common_spl(void)
 		rsv_start = (phys_addr_t)(uintptr_t)__bss_start;
 		rsv_size = (phys_addr_t)(uintptr_t)__bss_end -
 			(phys_addr_t)(uintptr_t)__bss_start;
-		lmb_reserve_flags(rsv_start, rsv_size, LMB_NOOVERWRITE);
+		lmb_reserve(rsv_start, rsv_size, LMB_NOOVERWRITE);
 	}
 }
 
@@ -624,11 +623,11 @@ void lmb_add_memory(void)
 			 * allocated
 			 */
 			if (bd->bi_dram[i].start >= ram_top)
-				lmb_reserve_flags(bd->bi_dram[i].start, size,
-						  LMB_NOOVERWRITE);
+				lmb_reserve(bd->bi_dram[i].start, size,
+					    LMB_NOOVERWRITE);
 			else if (bank_end > ram_top)
-				lmb_reserve_flags(ram_top, bank_end - ram_top,
-						  LMB_NOOVERWRITE);
+				lmb_reserve(ram_top, bank_end - ram_top,
+					    LMB_NOOVERWRITE);
 		}
 	}
 }
@@ -669,7 +668,7 @@ long lmb_free(phys_addr_t base, phys_size_t size)
 	return lmb_free_flags(base, size, LMB_NONE);
 }
 
-long lmb_reserve_flags(phys_addr_t base, phys_size_t size, u32 flags)
+long lmb_reserve(phys_addr_t base, phys_size_t size, u32 flags)
 {
 	long ret = 0;
 	struct alist *lmb_rgn_lst = &lmb.used_mem;
@@ -681,11 +680,6 @@ long lmb_reserve_flags(phys_addr_t base, phys_size_t size, u32 flags)
 	return lmb_map_update_notify(base, size, MAP_OP_RESERVE, flags);
 }
 
-long lmb_reserve(phys_addr_t base, phys_size_t size)
-{
-	return lmb_reserve_flags(base, size, LMB_NONE);
-}
-
 static phys_addr_t _lmb_alloc_base(phys_size_t size, ulong align,
 				   phys_addr_t max_addr, u32 flags)
 {
@@ -790,7 +784,7 @@ static phys_addr_t _lmb_alloc_addr(phys_addr_t base, phys_size_t size,
 				      lmb_memory[rgn].size,
 				      base + size - 1, 1)) {
 			/* ok, reserve the memory */
-			if (!lmb_reserve_flags(base, size, flags))
+			if (!lmb_reserve(base, size, flags))
 				return base;
 		}
 	}
diff --git a/test/lib/lmb.c b/test/lib/lmb.c
index 48c3c966f8f2..3c3e862ffa0e 100644
--- a/test/lib/lmb.c
+++ b/test/lib/lmb.c
@@ -117,7 +117,7 @@ static int test_multi_alloc(struct unit_test_state *uts, const phys_addr_t ram,
 	}
 
 	/* reserve 64KiB somewhere */
-	ret = lmb_reserve(alloc_64k_addr, 0x10000);
+	ret = lmb_reserve(alloc_64k_addr, 0x10000, LMB_NONE);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(mem_lst, used_lst, 0, 0, 1, alloc_64k_addr, 0x10000,
 		   0, 0, 0, 0);
@@ -264,7 +264,7 @@ static int test_bigblock(struct unit_test_state *uts, const phys_addr_t ram)
 	ut_asserteq(ret, 0);
 
 	/* reserve 64KiB in the middle of RAM */
-	ret = lmb_reserve(alloc_64k_addr, 0x10000);
+	ret = lmb_reserve(alloc_64k_addr, 0x10000, LMB_NONE);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, alloc_64k_addr, 0x10000,
 		   0, 0, 0, 0);
@@ -466,35 +466,35 @@ static int lib_test_lmb_overlapping_reserve(struct unit_test_state *uts)
 	ret = lmb_add(ram, ram_size);
 	ut_asserteq(ret, 0);
 
-	ret = lmb_reserve(0x40010000, 0x10000);
+	ret = lmb_reserve(0x40010000, 0x10000, LMB_NONE);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, 0x40010000, 0x10000,
 		   0, 0, 0, 0);
 
 	/* allocate overlapping region should return the coalesced count */
-	ret = lmb_reserve(0x40011000, 0x10000);
+	ret = lmb_reserve(0x40011000, 0x10000, LMB_NONE);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, 0x40010000, 0x11000,
 		   0, 0, 0, 0);
 	/* allocate 3nd region */
-	ret = lmb_reserve(0x40030000, 0x10000);
+	ret = lmb_reserve(0x40030000, 0x10000, LMB_NONE);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, 0x40010000, 0x11000,
 		   0x40030000, 0x10000, 0, 0);
 	/* allocate 2nd region , This should coalesced all region into one */
-	ret = lmb_reserve(0x40020000, 0x10000);
+	ret = lmb_reserve(0x40020000, 0x10000, LMB_NONE);
 	ut_assert(ret >= 0);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, 0x40010000, 0x30000,
 		   0, 0, 0, 0);
 
 	/* allocate 2nd region, which should be added as first region */
-	ret = lmb_reserve(0x40000000, 0x8000);
+	ret = lmb_reserve(0x40000000, 0x8000, LMB_NONE);
 	ut_assert(ret >= 0);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, 0x40000000, 0x8000,
 		   0x40010000, 0x30000, 0, 0);
 
 	/* allocate 3rd region, coalesce with first and overlap with second */
-	ret = lmb_reserve(0x40008000, 0x10000);
+	ret = lmb_reserve(0x40008000, 0x10000, LMB_NONE);
 	ut_assert(ret >= 0);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, 0x40000000, 0x40000,
 		   0, 0, 0, 0);
@@ -550,11 +550,11 @@ static int test_alloc_addr(struct unit_test_state *uts, const phys_addr_t ram)
 	ut_asserteq(ret, 0);
 
 	/*  reserve 3 blocks */
-	ret = lmb_reserve(alloc_addr_a, 0x10000);
+	ret = lmb_reserve(alloc_addr_a, 0x10000, LMB_NONE);
 	ut_asserteq(ret, 0);
-	ret = lmb_reserve(alloc_addr_b, 0x10000);
+	ret = lmb_reserve(alloc_addr_b, 0x10000, LMB_NONE);
 	ut_asserteq(ret, 0);
-	ret = lmb_reserve(alloc_addr_c, 0x10000);
+	ret = lmb_reserve(alloc_addr_c, 0x10000, LMB_NONE);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 3, alloc_addr_a, 0x10000,
 		   alloc_addr_b, 0x10000, alloc_addr_c, 0x10000);
@@ -680,11 +680,11 @@ static int test_get_unreserved_size(struct unit_test_state *uts,
 	ut_asserteq(ret, 0);
 
 	/*  reserve 3 blocks */
-	ret = lmb_reserve(alloc_addr_a, 0x10000);
+	ret = lmb_reserve(alloc_addr_a, 0x10000, LMB_NONE);
 	ut_asserteq(ret, 0);
-	ret = lmb_reserve(alloc_addr_b, 0x10000);
+	ret = lmb_reserve(alloc_addr_b, 0x10000, LMB_NONE);
 	ut_asserteq(ret, 0);
-	ret = lmb_reserve(alloc_addr_c, 0x10000);
+	ret = lmb_reserve(alloc_addr_c, 0x10000, LMB_NONE);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 3, alloc_addr_a, 0x10000,
 		   alloc_addr_b, 0x10000, alloc_addr_c, 0x10000);
@@ -747,19 +747,19 @@ static int lib_test_lmb_flags(struct unit_test_state *uts)
 	ut_asserteq(ret, 0);
 
 	/* reserve, same flag */
-	ret = lmb_reserve_flags(0x40010000, 0x10000, LMB_NOMAP);
+	ret = lmb_reserve(0x40010000, 0x10000, LMB_NOMAP);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, 0x40010000, 0x10000,
 		   0, 0, 0, 0);
 
 	/* reserve again, same flag */
-	ret = lmb_reserve_flags(0x40010000, 0x10000, LMB_NOMAP);
+	ret = lmb_reserve(0x40010000, 0x10000, LMB_NOMAP);
 	ut_asserteq(ret, -EEXIST);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, 0x40010000, 0x10000,
 		   0, 0, 0, 0);
 
 	/* reserve again, new flag */
-	ret = lmb_reserve_flags(0x40010000, 0x10000, LMB_NONE);
+	ret = lmb_reserve(0x40010000, 0x10000, LMB_NONE);
 	ut_asserteq(ret, -1);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, 0x40010000, 0x10000,
 		   0, 0, 0, 0);
@@ -767,20 +767,20 @@ static int lib_test_lmb_flags(struct unit_test_state *uts)
 	ut_asserteq(lmb_is_nomap(&used[0]), 1);
 
 	/* merge after */
-	ret = lmb_reserve_flags(0x40020000, 0x10000, LMB_NOMAP);
+	ret = lmb_reserve(0x40020000, 0x10000, LMB_NOMAP);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, 0x40010000, 0x20000,
 		   0, 0, 0, 0);
 
 	/* merge before */
-	ret = lmb_reserve_flags(0x40000000, 0x10000, LMB_NOMAP);
+	ret = lmb_reserve(0x40000000, 0x10000, LMB_NOMAP);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, 0x40000000, 0x30000,
 		   0, 0, 0, 0);
 
 	ut_asserteq(lmb_is_nomap(&used[0]), 1);
 
-	ret = lmb_reserve_flags(0x40030000, 0x10000, LMB_NONE);
+	ret = lmb_reserve(0x40030000, 0x10000, LMB_NONE);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, 0x40000000, 0x30000,
 		   0x40030000, 0x10000, 0, 0);
@@ -789,7 +789,7 @@ static int lib_test_lmb_flags(struct unit_test_state *uts)
 	ut_asserteq(lmb_is_nomap(&used[1]), 0);
 
 	/* test that old API use LMB_NONE */
-	ret = lmb_reserve(0x40040000, 0x10000);
+	ret = lmb_reserve(0x40040000, 0x10000, LMB_NONE);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, 0x40000000, 0x30000,
 		   0x40030000, 0x20000, 0, 0);
@@ -797,18 +797,18 @@ static int lib_test_lmb_flags(struct unit_test_state *uts)
 	ut_asserteq(lmb_is_nomap(&used[0]), 1);
 	ut_asserteq(lmb_is_nomap(&used[1]), 0);
 
-	ret = lmb_reserve_flags(0x40070000, 0x10000, LMB_NOMAP);
+	ret = lmb_reserve(0x40070000, 0x10000, LMB_NOMAP);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 3, 0x40000000, 0x30000,
 		   0x40030000, 0x20000, 0x40070000, 0x10000);
 
-	ret = lmb_reserve_flags(0x40050000, 0x10000, LMB_NOMAP);
+	ret = lmb_reserve(0x40050000, 0x10000, LMB_NOMAP);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 4, 0x40000000, 0x30000,
 		   0x40030000, 0x20000, 0x40050000, 0x10000);
 
 	/* merge with 2 adjacent regions */
-	ret = lmb_reserve_flags(0x40060000, 0x10000, LMB_NOMAP);
+	ret = lmb_reserve(0x40060000, 0x10000, LMB_NOMAP);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 3, 0x40000000, 0x30000,
 		   0x40030000, 0x20000, 0x40050000, 0x30000);
-- 
2.45.2

