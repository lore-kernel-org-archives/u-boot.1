Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23639CD6E4A
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 07:38:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66622848F5;
	Thu,  4 Jun 2026 09:37:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tsHkk0Mo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58BED848F5; Thu,  4 Jun 2026 09:37:46 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D33383314
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 09:37:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-490b915ded5so2907475e9.3
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 00:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780558664; x=1781163464; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oEBKvbhJm7m0Qt/YilwCpacpTJdcvzd3qenirLblIAs=;
 b=tsHkk0MoZtaBlLS4DbYcHDow9BCtWFn06Nf6FJpJ5O+CLnVPs8GrEObcZM7Vs1QGri
 wQSBwfDaE9F3QCuPEyrlc4mMFKPO4bE5jPCR7nB7cyvNatukG+TSlLx1pzxqCtgwzftp
 53Ru9fZn5X3j/NUxA/ofOVaBul2jDDOAENYykqpUc+nrNHM9anCzzvXMBoZa5MxkD5Xz
 7ljTvrg+4fLQHcfHBbthR4xYO203JwbjlmPhQfNx9bCY5fvQcrHvF8ejOY3fEi9i2cBe
 VxZghbb0MJa6xiFFKilxKSoD44aCxow6oG+gv2sQn1hlOTDlYkBCf6d6E7EaLp+JMG4g
 HMVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780558664; x=1781163464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oEBKvbhJm7m0Qt/YilwCpacpTJdcvzd3qenirLblIAs=;
 b=laOPFD03p+fS1j1F62rABhMg8RA/gyMKoamuYqIsRF+cCBDZMF4z/UMh7Q6XV3vf1C
 c92lFlZo7ONdXMLS9SySu2lt+hWNK1pxptjD7QBTN2so9cUnByqBlurS68YDQAwMvIYq
 GBPKKbw3JpXT68LK0rVfdpJkPiMkYlVnKMD+Uyc0MGESMMpWt7RroQqCJDUnirGRslOf
 4Y5gKsIKi4S1SA+qq2UjXRTnK3EvravUfpjfYWgd2l8XuCM2Syf0wxEZ2CY5zFpI1jlY
 z0hvkcx1IWtMJTEog2JAa3qbPqcKsqAMMOwHEpCwTZ3RMU+/uIWTWzXF6sLyRmToW5zt
 YREQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+xcmMEuYd6VHBpHmEe+YOiZ4dSISV01RkZ4C12phFjf6L8n4Zbvx+cZIBZNWcIHR+Mi/C5yY0=@lists.denx.de
X-Gm-Message-State: AOJu0Yz5UDR2cLg12wDd4IaPMadq9xK2c0LEUZqj1u7cHpQ/+/jRLBkz
 rURDFfwaaa2BNg2/akGrDE/xuUXyMUrRWJ8V5j7EvGVIZbqh303Kxm2YWQPLJ96SCeQ=
X-Gm-Gg: Acq92OFo1LiwFYi+50CCHrpvoVgi/V78pc/XRonWsKuPH5dWT3SByMmg4ZNyhHm9JNi
 PZ68VVY1Djv5R0cyWj4YrFaeW1ezbZg8vuVXc2FhVpFfMWvnXyCFB9YGwuoxd1hs73lsWnuoIxX
 8jUDHKeiVAUIoJ4541rlQv/NTJbzk2hSlkfImrYAkz2b0Mf4xArFQbmKMKwApIkwkxOIA9opWeQ
 WD1JfSsiVfq4CgHzNwRJSHO61ycZWQit4eTTc/smBhctha28ukrDvgH6abRwFvC+ym7EeZnZEfZ
 AfdcoIUlmqlE4rLWgWARQF5EwJ10Ad7/pDmXAzPAPEXm2QRz7zNMCB5FP0JMjf3+d5SHGGZbJz9
 LKWj4OJjRgeeggi1d/WIKdIOoCsxTz7J5cHRJ8TIvA6CwkakFFzwfnmSBtyOb8L0a7YjBOEYYar
 2ryRpViX3CWCLOv4VYOTcW53BYHPBrQvxdZcn7EKQoTPjR+cS32+VP9U8GlBjbekC5Evrib/F+J
 n4oIzD9jQJJ83PCAulYVYl4HJ21FEZBnW9vZ276vA44/uRc4fbv6lkNSbmrrAvVsobYzBa6Seu4
 9zvtK8EOdc5Moz+m3z966Q0pjh/PmHzaQsYzYGZr0a1Sd6q8OcJmHP7ppmbloNpZopnJygmeIPt
 93TqGuHYzbg5+fUHuO256SEDKFRWasgDt932kKfqt6STHOu4Pb+YcwZrnR1ZU/YYQep+mX9/5vV
 aTnU5sj1BFKJg1G0hssHrMZ4oZRV2gozmxOcDqXJXyk3X+bkUiIpkdZJ9BzquA0aEvuqgJIfvKq
 W9dBi1BpNZjrrisrni1Wk5nOH3BcuEacNm5
X-Received: by 2002:a05:600c:c48e:b0:490:40f1:5314 with SMTP id
 5b1f17b1804b1-490b5eb73aamr100123155e9.1.1780558663748; 
 Thu, 04 Jun 2026 00:37:43 -0700 (PDT)
Received: from hera ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3918d7sm46436675e9.2.2026.06.04.00.37.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 00:37:43 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, anshuld@ti.com,
 sjg@chromium.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.denx.de
Subject: [PATCH v5 5/7] common: Add an option to relocate on ram top
Date: Thu,  4 Jun 2026 10:37:10 +0300
Message-ID: <20260604073719.48723-6-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604073719.48723-1-ilias.apalodimas@linaro.org>
References: <20260604073719.48723-1-ilias.apalodimas@linaro.org>
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
index f58061026f8f..315e58e2d9c0 100644
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
@@ -350,10 +372,9 @@ static int setup_ram_config(void)
 	 * memory size from the SDRAM controller setup will have to
 	 * get fixed.
 	 */
+#if CONFIG_VAL(SYS_MEM_TOP_HIDE)
 	gd->ram_size -= CONFIG_SYS_MEM_TOP_HIDE;
 #endif
-	gd->ram_top = gd->ram_base + get_effective_memsize();
-	gd->ram_top = board_get_usable_ram_top(gd->mon_len);
 
 	debug("Ram top: %08llx\n", (unsigned long long)gd->ram_top);
 	debug("Ram size: %08llx\n", (unsigned long long)gd->ram_size);
@@ -979,6 +1000,7 @@ static void initcall_run_f(void)
 	 *  - board info struct
 	 */
 	INITCALL(setup_ram_base);
+	INITCALL(dram_init_banksize);
 	INITCALL(setup_ram_config);
 	INITCALL(setup_dest_addr);
 #if CONFIG_IS_ENABLED(OF_BOARD_FIXUP) && \
@@ -1007,7 +1029,6 @@ static void initcall_run_f(void)
 	INITCALL(reserve_bloblist);
 	INITCALL(reserve_arch);
 	INITCALL(reserve_stacks);
-	INITCALL(dram_init_banksize);
 	INITCALL(show_dram_config);
 	WATCHDOG_RESET();
 	INITCALL(setup_bdinfo);
-- 
2.53.0

