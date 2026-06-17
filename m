Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5FBDCD98ED
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 07:50:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14E128499D;
	Wed, 17 Jun 2026 09:49:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jkJOhmU7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D97C838BB; Wed, 17 Jun 2026 09:49:36 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B6868499D
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 09:49:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-490afc47455so24565425e9.2
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 00:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781682574; x=1782287374; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Igb9pKMTvLSMWZep9qQlk76lgO0j0ZDdSjDpromKq0k=;
 b=jkJOhmU7WcnvI30VD9TgYW4G99KwJpx92mzf0JzItfkXF7Lom11nfceOUAOM+dAOLs
 jtCZSsQZhwTQUosWSN3ykA6wbQVmJWJkICD/9kA6EDPQqsGX2bHQ9UThWvRyc0tcpCBu
 /AGSS3NIRmSrtopPW8RcHhVp/JtqxCDP2WEJP2kKfg/jqo57mDP1p9dXXUicdcNcKFBB
 HjLdCv30oP3aZ1RWvz2tfyP/iDr50wviIC/MtqanJWgixHHlEGv4h/wndIcmew5LwaSM
 GSWrIj6h0X7lRMxKupkXLPIbyVPLck+Wn5wLGDOVv8GOlD4p6sYU0Z2e1vlkgBf5/Nza
 AuBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781682574; x=1782287374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Igb9pKMTvLSMWZep9qQlk76lgO0j0ZDdSjDpromKq0k=;
 b=Pqm8y7d3TfBS9GpaAfzgUq+NjgN8NY9SbplJDvz16H/2ET2ORnmyGFUBQw/zUjb4o/
 kCfsXGyYh1BPKeBpHpDexo1rJKngiLXJTAlYT0nQmsHEn3Z8IAgjg0Vjms82ig+E3f6r
 pvVXtGG+M3O+ghczCLfAp53JTfF814kFtqHtxBTysh82MdN0/BD066MbAURbzCh7F7h3
 ZfVR0/PWczDlLVSOTuShC9LiE4KI0GrwowylvRjer9atj5DFNGwJIlF/txSAGtk78TPn
 XhHw70wURQ93Xq43sRxnGJ1QTAfwk57XvDxqYanPt5xDwLIEzf13WAVKeyALZWQwWimr
 hxUQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Si/1rJs65+GOhdgE9Um6LzW+3P5wdfk9iDHSfx0ijCfKdd3ZnzedTnPmoetJgB1sf8phanrY=@lists.denx.de
X-Gm-Message-State: AOJu0YzBLmGOmFz0zKgR69pZDF4cVX47UKZy9vI82pys7FgkL9kXgKoc
 HKTQXLV519uZP9aMR0FE//SlB/WgZXL13oZk7vf5bOINkZlBwP6u/Zas8/ia0TNjXNc=
X-Gm-Gg: Acq92OEDwDfWe0/FjPg1JuD9v8MenO+O/pDLIKzLJlQGgdHNxnLFLZJ13CSTMm8QMGx
 2Paqz8RYlIAP4GCm7BhUN9BEp7xPNUu8/AQ9OOwKwMsFD371py3WVGRXvgvHWZkSL9jtf30SrVp
 Xed1/kxa8WfWpiGn13FXRw7eV83+WPQT71eVbx8k6gqDLp7wB2x6P4CxBEDUiWUFbWweyWBL2+4
 GqWupsH/rqPc0iv47vOeE3GI0XInwAsNs8vcdmJQKAYE/6hPl8jRiLlLLAELVyHptMR3/eTQBPF
 TGCpAwUtOpwdwidpmkVKS4R/himNYKwKcQLeq/F3s/hifvCjoCyMRiaVvhFz5nWUIPZLQsY8yNx
 zDIfn9BevFnJq03V3IYVHLzJKo43IMKxCG72lqYeg7lKumJU1i3ssHJdHaTfYtkZBOO1FzKxovG
 0asjwK9BNYk8OEOo8yjAqBnwZ1xqXAwOwkS85dXgmeGL5wAc8ttOKWirL4QFPLb8L0MJMVXo/zY
 BuzWjllBFuJtTGvLf01+nOKgl6RM3ktAblfIZKXjeXtSCxKebnbiIgCS6M05Pv8kM3mX7PTsOJu
 F8gB2Q4ntxvpTScb8FLyZT+7vvJcdFszB2nqAtPFnssQqgpwrzjAi3+7Yn34iZUtJkvQv8mH9OA
 r5mps3bVWmD32IXcwqUw9CL+Xel2o0CpmyT77spW9FjES8Milc4AXcU2IVwkY8chjMqDj/EcJ5J
 X8F3shQeDPXQ7K/bP89PwseeN7Hg1G9UqI4uY2lf7vGVBNbQaZ/gKxOpqpVj7uEUub9cPnOabU6
 hVXM0nOPp1bPzH6og==
X-Received: by 2002:a05:600c:5287:b0:492:329e:528 with SMTP id
 5b1f17b1804b1-492333cf932mr44729325e9.23.1781682573690; 
 Wed, 17 Jun 2026 00:49:33 -0700 (PDT)
Received: from hades.. ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49230a4fd31sm132512615e9.4.2026.06.17.00.49.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 00:49:33 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, anshuld@ti.com,
 sjg@chromium.org, christophe.leroy@csgroup.eu,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH v7 5/7] common: Add an option to relocate on ram top
Date: Wed, 17 Jun 2026 10:48:23 +0300
Message-ID: <20260617074846.84362-6-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260617074846.84362-1-ilias.apalodimas@linaro.org>
References: <20260617074846.84362-1-ilias.apalodimas@linaro.org>
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

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Tested-by: Simon Glass <sjg@chromium.org>  # Radxa ROCK 5B
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 Kconfig          | 13 +++++++++++++
 common/board_f.c | 29 +++++++++++++++++++++++++----
 2 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/Kconfig b/Kconfig
index 8428d039a1c0..5960f469dffd 100644
--- a/Kconfig
+++ b/Kconfig
@@ -503,6 +503,19 @@ config SKIP_RELOCATE_CODE_DATA_OFFSET
 	  Offset of the read-write memory which contains data, from read-only
 	  memory which contains executable text.
 
+config RELOC_ADDR_TOP
+	bool "Relocate to the topmost memory address"
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
index b3e633418e1b..85b888d4bb85 100644
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
@@ -339,7 +344,23 @@ static int setup_ram_base(void)
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
+	} else {
+		gd->ram_top = gd->ram_base + get_effective_memsize();
+	}
+	gd->ram_top = board_get_usable_ram_top(gd->mon_len);
 	/*
 	 * Subtract specified amount of memory to hide so that it won't
 	 * get "touched" at all by U-Boot. By fixing up gd->ram_size
@@ -350,10 +371,10 @@ static int setup_ram_config(void)
 	 * memory size from the SDRAM controller setup will have to
 	 * get fixed.
 	 */
+#if CONFIG_VAL(SYS_MEM_TOP_HIDE)
+	gd->ram_top -= CONFIG_SYS_MEM_TOP_HIDE;
 	gd->ram_size -= CONFIG_SYS_MEM_TOP_HIDE;
 #endif
-	gd->ram_top = gd->ram_base + get_effective_memsize();
-	gd->ram_top = board_get_usable_ram_top(gd->mon_len);
 
 	debug("Ram top: %08llx\n", (unsigned long long)gd->ram_top);
 	debug("Ram size: %08llx\n", (unsigned long long)gd->ram_size);
@@ -988,6 +1009,7 @@ static void initcall_run_f(void)
 	 *  - board info struct
 	 */
 	INITCALL(setup_ram_base);
+	INITCALL(dram_init_banksize);
 	INITCALL(setup_ram_config);
 	INITCALL(setup_dest_addr);
 #if CONFIG_IS_ENABLED(OF_BOARD_FIXUP) && \
@@ -1016,7 +1038,6 @@ static void initcall_run_f(void)
 	INITCALL(reserve_bloblist);
 	INITCALL(reserve_arch);
 	INITCALL(reserve_stacks);
-	INITCALL(dram_init_banksize);
 	INITCALL(show_dram_config);
 	WATCHDOG_RESET();
 	INITCALL(setup_bdinfo);
-- 
2.43.0

