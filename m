Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 971F5E77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 07:03:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EEEB8021D;
	Wed, 18 Dec 2024 08:03:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ql9+Nk+G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA144802B4; Wed, 18 Dec 2024 08:03:11 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CC4980214
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 08:03:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4361815b96cso40598685e9.1
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 23:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734505389; x=1735110189; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y7XIpF0RcmNHSw9YLYK7Opl+/eMYWDy3q85wIJRpPx0=;
 b=Ql9+Nk+G4yO4jHUdLgyGuPn+PMP36C2ZJIzzLD7MDM0OmwUoQZofDNjVS4L2UAIQ8g
 JGoQuoM326tg2PITHWp7vMm4iySF0Z3l/ulReZVb31REdUGDL5eN3UeR3Un0bfGIn4B9
 aOKAiTeE1zpE0tCUCjPFXV/24dYQ8oJ9I5iZx3rzOeU8yBaLe9J9UCsBYia6Fgv7KwRP
 eEXKufpBh1p1M2E/RWFSHaVzTL3TbvHAb6Q/bFxobXOjb8WVyDjmCt9G4RJE77mBIkvy
 LPiPAsijp6+YOA2NLdQjUDDdaSBv8h4TBgvgmHFT1ezAS2tLv3ESLw95TrAm3CwyAo7l
 fZoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734505389; x=1735110189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y7XIpF0RcmNHSw9YLYK7Opl+/eMYWDy3q85wIJRpPx0=;
 b=Cp/ikKrPTvgxatgTcpvBTAb4SBgpCKRpkaiHIqkHu+J7Uu4XSJSh3u4DrZPQyygraK
 VFKRFftdH6MwRbhavOTF5gvHM+Umx1UGPdLPO7XZ0MfkV5lm4X5IEEvYMp+lqEAmC4mt
 xkm9OzeRhKeV388YJ450JvDE2axWmw3YrartbUGKFirDmLUIlZbmcOj1VfazqvGlUyh2
 azc89vj9FbNSzXoUEMiLyVPd5rQXOPf7+C/u7VGMVgxHW+lZyUeMILNqIXHbHrPuQ0mY
 mkhJeMcr5o2Ke3W+/l13gGtLH8XT/orjRDIcMAS99x8mCyFe33pt3UZwUhcA5PY81AN+
 vLTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3SIURQUjCN87esizpn9wfk7H9khmUQf9UtUgHXQ8o5PhGjYN2IQxrQSkYiAAtCvpm5F0Ujic=@lists.denx.de
X-Gm-Message-State: AOJu0Yz5D1AO/fjqROW21Spb94kEf86dAOmkCyXR1/uuyu/fLPlajEZf
 SIEB53htmwJNFXbpffebnuJSlxk7Dm6dWSZiuEwlEW+e50Q8v2cLe9AmD1wXZwQ=
X-Gm-Gg: ASbGncu+nrTCxPB7NDLZL0sAZccnyW1V1rwCqIFDCDra2NC81fwLgjU9xrNiMQ9MdUz
 wGnt6PJ6xHEToA4gQHTPh6Cy1utFL/vkPLBcwsPmSMpR0D7EREzf2ST2DgwB7EhLhntb8g6pHWl
 PHKhIhcOl8kPngfxWVAbSGXJEvpmX5/+XKYCsK1NMQAKjtBRzPFoPF78t96jOaZb7EnaRvBs1Wu
 sLl/DRL/9SpKMljX785TgybD2arRWnTDUFnDfsH2S58TiIn3jZuuNX8Ymj3TA2EwkaqYe+qvlhS
 fEbeITIFtYtjK3rLkWg8EqqPDAFCxhnJ5A==
X-Google-Smtp-Source: AGHT+IG6ksi4OOTxPZ2EEFq5dVTSnTtbFxWflSBk3UdYA7FKArsBECIosnXlISAqOaVoKocgo0nObA==
X-Received: by 2002:a05:600c:3109:b0:434:ff25:1988 with SMTP id
 5b1f17b1804b1-4365540cfd4mr10314195e9.32.1734505388615; 
 Tue, 17 Dec 2024 23:03:08 -0800 (PST)
Received: from localhost.localdomain (ppp176092181030.access.hol.gr.
 [176.92.181.30]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8060592sm12971612f8f.98.2024.12.17.23.03.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 23:03:08 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de,
	trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Peter Korsgaard <peter@korsgaard.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Nam Cao <namcao@linutronix.de>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Prasad Kummari <prasad.kummari@amd.com>, Janne Grunau <j@jannau.net>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH v2 3/8] lmb: Remove lmb_reserve_flags()
Date: Wed, 18 Dec 2024 09:02:32 +0200
Message-ID: <20241218070251.686383-4-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241218070251.686383-1-ilias.apalodimas@linaro.org>
References: <20241218070251.686383-1-ilias.apalodimas@linaro.org>
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

Reviewed-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Tested-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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
index 3b911d5d8391..3abe24deb56e 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -80,16 +80,7 @@ void lmb_add_memory(void);
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
@@ -99,8 +90,7 @@ long lmb_reserve(phys_addr_t base, phys_size_t size);
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

