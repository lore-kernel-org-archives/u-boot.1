Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E737CD4F25
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 13:53:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99203846E7;
	Fri, 15 May 2026 15:53:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PKRaoMCX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DEDB846C6; Fri, 15 May 2026 15:53:10 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26216846D7
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 15:53:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-488b150559bso72722775e9.1
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 06:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778853187; x=1779457987; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5DhxWBajyB0+r8siI5opHlhn4FUdwVl+T2aLAywpUo8=;
 b=PKRaoMCX9V6o1NPzs+hxA4O6qRa7shg4ryI+py8uUvFuj+pOiej6LyyMQgZOLngcR8
 4pjD8/OpiT840Pl3aXCHZvA5XiHFL6NszbWgrkmYd3NGm12Jlp/vsvtLCZ8kM1zaoUH6
 4CiB8s473V/Sca6QrIJ2htHvNATVJLroi0pQCsd95YVqBwbMgNrCbzm2wg4JuKBIXVzU
 Disup4yGOkpigj3rMXVMWgmMpHMmxep4ZEXvhW9hYDMELqoXtxKQAEIjIkcP6TyFgk6g
 IE5Z8oQrwnK8HPoYAueNRT5+SB0qMABBQBz9kGSA4KdjPg/+Tebtt8M7qu+P1RUoAvKD
 I8xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778853187; x=1779457987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5DhxWBajyB0+r8siI5opHlhn4FUdwVl+T2aLAywpUo8=;
 b=eQb/ivqZshluXlome9ZXbyrO+r3NSqymbECl36jjQBATQCQokAxbCF+2bad01Yi2p9
 sxq25h4fWFegoOP198fhXH6EUkDCY8T3gsqNPlAFJTX7GQ5T3jNX8Hdwtj6nAZtX4MAL
 v7Knrpyb+eO4B34r2R8OKK9g9XT7j7FIaYnyPmFwZo07E2d6SUJncfgfBeFqgtuWy3Ys
 HWJQCAaOd0ljr7uxCUAtIM3NWoUL3EH6X703trOPSZaf5BmJhEnvaEHC4OgO5AkUY6NQ
 AYoFrD3DHWeNSoZ495zLPG1mA/t5c9+pLn9LBJ44MeS6WWKFiiQbVsAmiu4o8HJhhnv3
 dBPQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9i2LsGpRlB125Nc3FGdlarACxBX/UppGIy4m7HG2rFzaLaktLoxbcqIdtVagtnOyHYI0ZLgDI=@lists.denx.de
X-Gm-Message-State: AOJu0YweAYLxL5hKfBZ1AyeeNJ4H+fCvW5QdpXT/Dg62CQczRccbv5lW
 +Rg5ahtU42wRrdUvRHwcAddwm788JPjNgGs208mp677QdZrP3FSsC4lNFtXW+lkVAd0=
X-Gm-Gg: Acq92OFiB1hReGLSC8TyhSuRDIjuj5kXpsMWdClImTWegwJw12k0YY+w/bfahubDzsU
 ETywbe4c9zR/gTWDWmSZ4i9qMPj1+AobztoPoMVKUGXqS9cREqyBZx0CNfY+ZV5hl2GZHblWANw
 ClM10gTJaKSNScFPJU3QwxS50X9KjX2HKeOJEQjNq+cGJmb+9m01/9+l43rv1EZlZzH4MZRl2s0
 gBW16Ip8r+i8pDZ/ApXTCKvsSI/I8n9L9/pxHRtQ7Hw9CB2lQQySm+HqF0Bt718qWRjZtPh++2p
 n/3cqtulg6Mcn2PRw6jt2+Xkg0R2O31elnjon2s5TrSeEKauZg/sDyZZYB30ANFNMz89PO6j72F
 py2SFg1RFFmFIWucOpIQyvydGoozRNqPvJXsmUNrJxPAztqwN98oHI7s/hTmK4W9leW4NRmTS4G
 bjJAHNDTL9tfe3a0yqO9wcUCBD7mtDMrNLF3lqWhGhKuEsm1AEbTZyvuzBuHyRbKp0YWGM/irwh
 tO28OSpdyJaRozrvrL3qPr2DuAr9gh9EJ6J3pq9BJi4LFtdNFPH+4/+cG44ytTjFlngKSc7V25b
 CQn4w+D1ZtcfnRwOmdH6rKHiPVtDieRNmAab9joCwH4ECLUmT7X65m39L7QObV3KTkpWerUJW0p
 bgV4aI0q9HvCeeAV+pZA4Sb7slUahA6VjDaMI156H+0151DoFEpa15SDS5PTZ4bDtB2E2lbhvhH
 fy+l4h/rpjp+aNd4uYmGSdYGfqjK7JUioRX64kGXf8VCPLf8lHPCUsIVdPOyaKXtANy1oDJepPU
 H7ew7ZkF6wPs5Qj2TSEAThi1DHi
X-Received: by 2002:a05:600c:c0db:b0:489:1ff1:74d3 with SMTP id
 5b1f17b1804b1-48fe63223e2mr40620375e9.20.1778853187571; 
 Fri, 15 May 2026 06:53:07 -0700 (PDT)
Received: from hades.. ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe4c88e5asm65854525e9.6.2026.05.15.06.53.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 06:53:07 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, anshuld@ti.com,
 sjg@chromium.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.denx.de
Subject: [PATCH v4 4/6] common: Add an option to relocate on ram top
Date: Fri, 15 May 2026 16:52:25 +0300
Message-ID: <20260515135245.45067-5-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515135245.45067-1-ilias.apalodimas@linaro.org>
References: <20260515135245.45067-1-ilias.apalodimas@linaro.org>
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

Right now we only relocate u-boot to the top of the first
memory bank unless the board specific code overwrites it.
This is problematic when loading big binaries as it
fragments the contiguous memory space for no apparent reason.

On certain platforms, it is currently not possible to relocate U-Boot
above the 32bit boundary, due to various dependencies on content located
below the 32bit boundary. One such example is ethernet, where the packet
buffer built into U-Boot binary is placed below the 32bit boundary and
allows loading of data via ethernet even above 32bit boundary due to
memory copy from the packet buffer to the destination location.

A previous patch moves the bi_dram[] info from bd to gd and make
the memory bank information available early. So move the
dram_init_banksize() INITCALL before the relocation address calculation
and use it to derive the address.

Also add a Kconfig option and allow the common code to relocate U-Boot
to the top of the last discovered bank.
It's worth noting that this patch changes when dram_init_banksize()
is called. It's now called  much earlier in the board init process.
That is a significant ordering change for every board with a custom
dram_init_banksize(), and it is unconditional (not gated on RELOC_ADDR_TOP).

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 Kconfig          | 14 ++++++++++++++
 common/board_f.c | 32 ++++++++++++++++++++++++++------
 2 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/Kconfig b/Kconfig
index 8428d039a1c0..6e7b3b4c61c0 100644
--- a/Kconfig
+++ b/Kconfig
@@ -503,6 +503,20 @@ config SKIP_RELOCATE_CODE_DATA_OFFSET
 	  Offset of the read-write memory which contains data, from read-only
 	  memory which contains executable text.

+config RELOC_ADDR_TOP
+	bool "Relocate to the topmost memory address"
+	depends on EXPERT
+	help
+	  When U-Boot relocates, it chooses the end of the first memory bank.
+	  Enable this if you have multiple banks and want U-Boot to relocate
+	  to the topmost memory address. This will use the information of the
+	  board memory banks configured with dram_init_banksize() to calculate
+	  the relocation address.
+	  Use this if you are certain all of the devices can access memory
+	  above the 32bit boundary. Devices that can only DMA below 4GiB will
+	  misbehave because their buffers may be allocated above the 32-bit
+	  boundary after relocation.
+
 endif # EXPERT

 config PHYS_64BIT
diff --git a/common/board_f.c b/common/board_f.c
index f58061026f8f..c69ac4106951 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -31,6 +31,7 @@
 #include <log.h>
 #include <malloc.h>
 #include <mapmem.h>
+#include <memtop.h>
 #include <os.h>
 #include <post.h>
 #include <relocate.h>
@@ -50,6 +51,7 @@
 #include <dm/root.h>
 #include <linux/errno.h>
 #include <linux/log2.h>
+#include <linux/sizes.h>

 DECLARE_GLOBAL_DATA_PTR;

@@ -308,6 +310,9 @@ __weak int mach_cpu_init(void)
 /* Get the top of usable RAM */
 __weak phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 {
+	if (CONFIG_IS_ENABLED(RELOC_ADDR_TOP))
+		return gd->ram_top;
+
 #if defined(CFG_SYS_SDRAM_BASE) && CFG_SYS_SDRAM_BASE > 0
 	/*
 	 * Detect whether we have so much RAM that it goes past the end of our
@@ -339,7 +344,24 @@ static int setup_ram_base(void)
 static int setup_ram_config(void)
 {
 	debug("Monitor len: %08x\n", gd->mon_len);
-#if CONFIG_VAL(SYS_MEM_TOP_HIDE)
+
+	if (CONFIG_IS_ENABLED(RELOC_ADDR_TOP)) {
+		int i;
+		phys_addr_t top;
+
+		gd->ram_size = 0;
+		for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
+			top = get_mem_top(gd->dram[i].start, gd->dram[i].size,
+					  ALIGN(gd->mon_len, SZ_1M),
+					  (void *)gd->fdt_blob);
+			gd->ram_top = max(top, gd->ram_top);
+			gd->ram_size += gd->dram[i].size;
+		}
+		gd->ram_top = board_get_usable_ram_top(gd->ram_size);
+	} else {
+		gd->ram_top = gd->ram_base + get_effective_memsize();
+		gd->ram_top = board_get_usable_ram_top(gd->mon_len);
+	}
 	/*
 	 * Subtract specified amount of memory to hide so that it won't
 	 * get "touched" at all by U-Boot. By fixing up gd->ram_size
@@ -350,10 +372,8 @@ static int setup_ram_config(void)
 	 * memory size from the SDRAM controller setup will have to
 	 * get fixed.
 	 */
-	gd->ram_size -= CONFIG_SYS_MEM_TOP_HIDE;
-#endif
-	gd->ram_top = gd->ram_base + get_effective_memsize();
-	gd->ram_top = board_get_usable_ram_top(gd->mon_len);
+	if (CONFIG_IS_ENABLED(SYS_MEM_TOP_HIDE))
+		gd->ram_size -= CONFIG_SYS_MEM_TOP_HIDE;

 	debug("Ram top: %08llx\n", (unsigned long long)gd->ram_top);
 	debug("Ram size: %08llx\n", (unsigned long long)gd->ram_size);
@@ -979,6 +999,7 @@ static void initcall_run_f(void)
 	 *  - board info struct
 	 */
 	INITCALL(setup_ram_base);
+	INITCALL(dram_init_banksize);
 	INITCALL(setup_ram_config);
 	INITCALL(setup_dest_addr);
 #if CONFIG_IS_ENABLED(OF_BOARD_FIXUP) && \
@@ -1007,7 +1028,6 @@ static void initcall_run_f(void)
 	INITCALL(reserve_bloblist);
 	INITCALL(reserve_arch);
 	INITCALL(reserve_stacks);
-	INITCALL(dram_init_banksize);
 	INITCALL(show_dram_config);
 	WATCHDOG_RESET();
 	INITCALL(setup_bdinfo);
--
2.53.0

