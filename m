Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63FF4CD8CA4
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 13:23:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 328ED848BC;
	Tue,  9 Jun 2026 15:23:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gW4zFAF1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03FCB84963; Tue,  9 Jun 2026 15:23:04 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DCA38496E
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 15:22:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-45efa80e0afso4266689f8f.2
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 06:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781011378; x=1781616178; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jMZJa82bCB/zg5YI83ChEyxtg1h9/Kere/ch5SxLZZ8=;
 b=gW4zFAF1CznuuZ2rpUXiMbrkFMxjLHzH+fxlPWPm/XMKgqe/F5cW/+cdJ/g+n0KU36
 H3torvuoxovfAcLbNwtgaZJ5iwgOswUT6xNzv1N1tbDk8GiEJwa3s1WRwvqC1UFeJ75S
 rcrdcu9gqilBlKnmf2l82WqQSGBy5YJurvqk9ao9tv0HM7BdT07m6lL3reLGFHCW2v6t
 NMczf8/A2j2KCqHB1r4lNv8+aVbQ9wD0vc78iQpqM9wkwW8QBqQvwZwVeG4SODh1sL+H
 FgZ/T4eQ7CBVPj2LY2muvK7cwxwnSV9vEqwIjBXAR4kpp5mv9kmVfu3CTuicM5ihqKmX
 TzDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781011378; x=1781616178;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jMZJa82bCB/zg5YI83ChEyxtg1h9/Kere/ch5SxLZZ8=;
 b=l1m6ym4zXXbnDnIs475wuIMB/wQTZaynyxwIVetz8UDJTIvmbqdGciIPFHsXJwziqj
 G4CN+1b9dAEwjNVzy+LspiJOtJ8eYJWJGGiM4QzRFd5nDKC7HFdrQR1W+3BkHbz7Ts6+
 rFRGY/V5xEbXoNjJC6g7Gh2tI9kglOhaRxJKLxErWSSYPpKPy8ewjtfrTUA8oU0jLOlB
 HmGzo8FmPUN9B077XHKJYd3UwrGEvwkz/ml//syx/A73bRGrwBdwArI73AN6Qh01SXDI
 P7pv9RG0XgSjKOEYPGz8pA27oOdM1qwLflZz9UmVtd91VX8Vb7M2DOOUqiL9XHzEc/sl
 Zc5Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ99GBZq8eKFhKsXUZDhUBkLse6LvMX90MPpat4bms4ulu6JrunGJEWOeqfe6glvA95gu+UR2tM=@lists.denx.de
X-Gm-Message-State: AOJu0YwuiNH57GNR7YiqvsP+qweYj0TXt/6TRCBxE+7vMznyZ1vu7Up0
 sLsJKR4aA/7F6sgAP8/JfvUBsq/aGgXcbjW3epT85hkUjrEkASKEoh8r5mEmDESnDBU=
X-Gm-Gg: Acq92OEXthvP9Bnz8MVKBPiImNLw174tsm7Nmf5owLIM7ciwiR/yJyci6mtzYDeaIyc
 8wIepq0hHZsKiBSgJMiyInn8IzmGBNyhZFMHEAvyzFgrNIJXglaX4j+TH1fZ6k2ulge++LM655F
 fKHyK2b+Uggni4vqS8i82F5PIa6UJGp8B4GBl28Wp24A3d/hr+09ayYpC8hlM1JOx6w12yJE2C/
 j2hQHE3Ueu+0GOlQNkxQ0edDLbqkq3fj+h74DBo3kOpUOqQasoMUjYBC7V/tFLpaRRJXkx4Gt8C
 /JYbmNC4B06rnf0iE6bKdB33aVpTt+eP3sXKJR88iT9kGl6XprpCZaRS/KFa/+2t8VUYv5a0TJ/
 /qUKvOMf4XeN2RSBHcGyMhhZMRHvkOqRZKppuEG5TR/oecGZCqvfifKCBgZwSL8vOY0JRJo+uwC
 NxskWASG8/goOGSMr1nGhS9Ra+lLE01YUJc736CbMhiWl02dja1kZY4dyPnLYe5XMhhpljArIMK
 I4G3+zbyR4O1wL1yZSVNECqzLWx0zIotN2hS1Ut4uY9XPLjw38n5wDx8gONW+70rSVDbbdFtk9E
 EzKGFPvEuHPMIx+NgR6v9+d7TblgugypRAZMhAYEhDxeNRaqi5rGNiNxHxBnxa1QMzCblHAr4iY
 hW9vx0L5vHNnGXV2Bd13x/Htc7xqkw5EYk4rFpK9CxihMEut29BXlJzzItgjLTtzJouFUjzM/+7
 EAJQ+vvRA827FiPVvzneNwZZOh2vwjPmcEfL/5eW7cWgdIRKiFbpshWBe1myjrVdHOiYPddxPr6
 UJJk3ElvnKqPdxu1V0jNsLq7kbGcOQIbiau75M=
X-Received: by 2002:a05:6000:4384:b0:460:3233:beea with SMTP id
 ffacd0b85a97d-4603233bfddmr18092156f8f.42.1781011378063; 
 Tue, 09 Jun 2026 06:22:58 -0700 (PDT)
Received: from hades.. ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f3446aesm68477564f8f.24.2026.06.09.06.22.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 06:22:57 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, anshuld@ti.com,
 sjg@chromium.org, christophe.leroy@csgroup.eu,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH v6 5/7] common: Add an option to relocate on ram top
Date: Tue,  9 Jun 2026 16:15:47 +0300
Message-ID: <20260609131611.46399-6-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609131611.46399-1-ilias.apalodimas@linaro.org>
References: <20260609131611.46399-1-ilias.apalodimas@linaro.org>
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
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 Kconfig          | 14 ++++++++++++++
 common/board_f.c | 29 +++++++++++++++++++++++++----
 2 files changed, 39 insertions(+), 4 deletions(-)

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
index d78d680406ad..93b7572bca60 100644
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
@@ -981,6 +1002,7 @@ static void initcall_run_f(void)
 	 *  - board info struct
 	 */
 	INITCALL(setup_ram_base);
+	INITCALL(dram_init_banksize);
 	INITCALL(setup_ram_config);
 	INITCALL(setup_dest_addr);
 #if CONFIG_IS_ENABLED(OF_BOARD_FIXUP) && \
@@ -1009,7 +1031,6 @@ static void initcall_run_f(void)
 	INITCALL(reserve_bloblist);
 	INITCALL(reserve_arch);
 	INITCALL(reserve_stacks);
-	INITCALL(dram_init_banksize);
 	INITCALL(show_dram_config);
 	WATCHDOG_RESET();
 	INITCALL(setup_bdinfo);
-- 
2.43.0

