Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 976F9E77180
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 10:56:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE3418022B;
	Wed, 11 Dec 2024 11:55:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gjwDneBk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6FB0801FE; Wed, 11 Dec 2024 11:55:39 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12DA480278
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 11:55:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-aa6b4cc7270so78780966b.0
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 02:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733914535; x=1734519335; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vq7Et1+06yoU+SrfNejcP7FvAUznzZZKURsbScNxGrA=;
 b=gjwDneBk5FLuX2YM0u6jecWFwP1wxirMoAF5X/42cB1Dj0izpnjAhtltpltw4cnf+M
 QoiOGKJGIWuNvOHAWXszzeWwnhyb6lsNwesxX5EAeT57RH1SFWhweBVLw1/q+nhSP9qI
 d0+yMcQpRowKBtO5f9GZ3EkZCCUMy9C/LUDfSLQV2JFl2kHtux1+TLWKJ+wuEoNp5EnF
 ExznIO2mjHIgNeFMlf/iplLDOZZTA9fS0C62+LTraYmN+tPFxYvJ6tdz+PX8pc07iopv
 8/NWE5NlADhb+uA7saPABbqkMyxuBokaxILhv2Hd/oKkVRd9sRZzezokGidhBuP91Th9
 o+FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733914535; x=1734519335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vq7Et1+06yoU+SrfNejcP7FvAUznzZZKURsbScNxGrA=;
 b=bx0yvQRmesmdrmV4i1+9mpr1F4396NMNebRyf55paOE+3ArLkvJljYk0BCM98HNr2w
 EtNfQmJGiCrb9xI4/W3u/xcI+ekS/b9Ye4sHlTMuxJA8osGMe/LdQxHmOPsViX+3s9h/
 JBqQl0iIkZt4QPSl30cYL91XwisdRRHN/+hjhT43/qYEVu/uWMBifXoDpkNxmhguKze2
 O3QwPqfkmmcl6DOvScLXB6PXSA4Ih57ibwyRKoozeWJy+90S8+RTE2PoS4W1s16PEVvW
 6Cww8NY63pDeCay+F+1gqHlPgwhJCyHj9MELrz3LtJ1NTmm3opbqlhsy8mYo2il5HhkJ
 BEQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW92S4FSxJmzJGZIeSM+Mm4gPj4dog9HNzxzmYPvizDNvkCgQtYQHkXCcNLTtrYjb6DaDb751E=@lists.denx.de
X-Gm-Message-State: AOJu0Yw7njjVyAPQDzl7dLiT7P3sN5g7eyDM9j+53enywsKJXae4Gc/J
 A8lluauz+fPnL58V5xOAw/iTfADq3VWXRdWJtS9j8ihbJPPV4BkmEayuFB7TMwU=
X-Gm-Gg: ASbGncvizmqp1ptnvlke7uxSNbWFVYndfQJ2Jgp6S5wlyKvqCgkQwglDyRseb3GThqr
 PgEpYA04yRqwYFc/L/uSm6+80jKdEfdVOrmZSZBtEUNslSpwqWIWQWRS/Fc8SqVbpmXDZfRgaiH
 xRHo68o8dGYTSfCtUKIhGfa+evwwAss2wru+Q+bSvo+4FUnchQ3vzoBD453UY2qXdrg7B33WTWw
 +2Dg3gFigY2YUKeT8mi2qfH54KogcBtgCaSQeWZwXwcO20kqVjqknkrXWi+YRvyyyYbj8TUsDgR
 Srhads+2twHXL+Lrx4Tp5YsveQvb1dM=
X-Google-Smtp-Source: AGHT+IFm1vYhSH3XIgLJTxZbaQFoP3kE8Im+62fEc3L17VkLQgOsCZx1Swun00YdiXNv0m5al+3bqw==
X-Received: by 2002:a05:6402:4008:b0:5d0:ced8:d22d with SMTP id
 4fb4d7f45d1cf-5d43314d119mr5792678a12.22.1733914535491; 
 Wed, 11 Dec 2024 02:55:35 -0800 (PST)
Received: from localhost.localdomain (ppp176092181030.access.hol.gr.
 [176.92.181.30]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa67e652b1dsm508006566b.172.2024.12.11.02.55.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 02:55:35 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de,
	trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Peter Korsgaard <peter@korsgaard.com>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Sean Anderson <seanga2@gmail.com>, Baruch Siach <baruch@tkos.co.il>,
 Nam Cao <namcao@linutronix.de>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Janne Grunau <j@jannau.net>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH v1 7/8] lmb: Remove lmb_alloc_base_flags()
Date: Wed, 11 Dec 2024 12:54:48 +0200
Message-ID: <20241211105504.453234-8-ilias.apalodimas@linaro.org>
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

lmb_alloc_base() is just calling lmb_alloc_base_flags() with LMB_NONE.
There's not much we gain from this abstraction, so let's remove the
former add the flags argument to lmb_alloc_base() and make the code
a bit easier to follow.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 boot/image-board.c          | 18 +++++++++++-------
 boot/image-fdt.c            |  5 +++--
 include/lmb.h               |  7 +++----
 lib/efi_loader/efi_memory.c |  4 ++--
 lib/lmb.c                   | 19 +++----------------
 test/lib/lmb.c              |  8 ++++----
 6 files changed, 26 insertions(+), 35 deletions(-)

diff --git a/boot/image-board.c b/boot/image-board.c
index 070ada007185..4e86a9a22719 100644
--- a/boot/image-board.c
+++ b/boot/image-board.c
@@ -565,9 +565,11 @@ int boot_ramdisk_high(ulong rd_data, ulong rd_len, ulong *initrd_start,
 			lmb_reserve(rd_data, rd_len, LMB_NONE);
 		} else {
 			if (initrd_high)
-				*initrd_start = (ulong)lmb_alloc_base(rd_len,
-								      0x1000,
-								      initrd_high);
+				*initrd_start =
+					(ulong)lmb_alloc_base(rd_len,
+								    0x1000,
+								    initrd_high,
+								    LMB_NONE);
 			else
 				*initrd_start = (ulong)lmb_alloc(rd_len,
 								 0x1000);
@@ -839,7 +841,8 @@ int boot_get_cmdline(ulong *cmd_start, ulong *cmd_end)
 
 	barg = IF_ENABLED_INT(CONFIG_SYS_BOOT_GET_CMDLINE, CONFIG_SYS_BARGSIZE);
 	cmdline = (char *)(ulong)lmb_alloc_base(barg, 0xf,
-				env_get_bootm_mapsize() + env_get_bootm_low());
+				env_get_bootm_mapsize() + env_get_bootm_low(),
+				LMB_NONE);
 	if (!cmdline)
 		return -1;
 
@@ -872,9 +875,10 @@ int boot_get_cmdline(ulong *cmd_start, ulong *cmd_end)
 int boot_get_kbd(struct bd_info **kbd)
 {
 	*kbd = (struct bd_info *)(ulong)lmb_alloc_base(sizeof(struct bd_info),
-						       0xf,
-						       env_get_bootm_mapsize() +
-						       env_get_bootm_low());
+							     0xf,
+							     env_get_bootm_mapsize() +
+							     env_get_bootm_low(),
+							     LMB_NONE);
 	if (!*kbd)
 		return -1;
 
diff --git a/boot/image-fdt.c b/boot/image-fdt.c
index d717f6690729..9d1598b1a93c 100644
--- a/boot/image-fdt.c
+++ b/boot/image-fdt.c
@@ -187,7 +187,8 @@ int boot_relocate_fdt(char **of_flat_tree, ulong *of_size)
 			lmb_reserve(map_to_sysmem(of_start), of_len, LMB_NONE);
 			disable_relocation = 1;
 		} else if (desired_addr) {
-			addr = lmb_alloc_base(of_len, 0x1000, desired_addr);
+			addr = lmb_alloc_base(of_len, 0x1000, desired_addr,
+					      LMB_NONE);
 			of_start = map_sysmem(addr, of_len);
 			if (of_start == NULL) {
 				puts("Failed using fdt_high value for Device Tree");
@@ -216,7 +217,7 @@ int boot_relocate_fdt(char **of_flat_tree, ulong *of_size)
 			 * for LMB allocation.
 			 */
 			usable = min(start + size, low + mapsize);
-			addr = lmb_alloc_base(of_len, 0x1000, usable);
+			addr = lmb_alloc_base(of_len, 0x1000, usable, LMB_NONE);
 			of_start = map_sysmem(addr, of_len);
 			/* Allocation succeeded, use this block. */
 			if (of_start != NULL)
diff --git a/include/lmb.h b/include/lmb.h
index 5e59915340b7..d481972a6686 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -91,11 +91,10 @@ long lmb_add(phys_addr_t base, phys_size_t size);
 long lmb_reserve(phys_addr_t base, phys_size_t size, u32 flags);
 
 phys_addr_t lmb_alloc(phys_size_t size, ulong align);
-phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t max_addr);
 phys_size_t lmb_get_free_size(phys_addr_t addr);
 
 /**
- * lmb_alloc_base_flags() - Allocate specified memory region with specified
+ * lmb_alloc_base() - Allocate specified memory region with specified
  *			    attributes
  * @size: Size of the region requested
  * @align: Alignment of the memory region requested
@@ -108,8 +107,8 @@ phys_size_t lmb_get_free_size(phys_addr_t addr);
  *
  * Return: Base address on success, 0 on error.
  */
-phys_addr_t lmb_alloc_base_flags(phys_size_t size, ulong align,
-				 phys_addr_t max_addr, uint flags);
+phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t max_addr,
+			   uint flags);
 
 /**
  * lmb_alloc_addr() - Allocate specified memory address with specified attributes
diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index 34e2b9e18ef0..1212772471e3 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -472,7 +472,7 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
 	switch (type) {
 	case EFI_ALLOCATE_ANY_PAGES:
 		/* Any page */
-		addr = (u64)lmb_alloc_base_flags(len, EFI_PAGE_SIZE,
+		addr = (u64)lmb_alloc_base(len, EFI_PAGE_SIZE,
 						 LMB_ALLOC_ANYWHERE, flags);
 		if (!addr)
 			return EFI_OUT_OF_RESOURCES;
@@ -480,7 +480,7 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
 	case EFI_ALLOCATE_MAX_ADDRESS:
 		/* Max address */
 		addr = map_to_sysmem((void *)(uintptr_t)*memory);
-		addr = (u64)lmb_alloc_base_flags(len, EFI_PAGE_SIZE, addr,
+		addr = (u64)lmb_alloc_base(len, EFI_PAGE_SIZE, addr,
 						 flags);
 		if (!addr)
 			return EFI_OUT_OF_RESOURCES;
diff --git a/lib/lmb.c b/lib/lmb.c
index ffad7ec12eb5..bdaaa634abd1 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -731,24 +731,11 @@ static phys_addr_t _lmb_alloc_base(phys_size_t size, ulong align,
 
 phys_addr_t lmb_alloc(phys_size_t size, ulong align)
 {
-	return lmb_alloc_base(size, align, LMB_ALLOC_ANYWHERE);
+	return lmb_alloc_base(size, align, LMB_ALLOC_ANYWHERE, LMB_NONE);
 }
 
-phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t max_addr)
-{
-	phys_addr_t alloc;
-
-	alloc = _lmb_alloc_base(size, align, max_addr, LMB_NONE);
-
-	if (alloc == 0)
-		printf("ERROR: Failed to allocate 0x%lx bytes below 0x%lx.\n",
-		       (ulong)size, (ulong)max_addr);
-
-	return alloc;
-}
-
-phys_addr_t lmb_alloc_base_flags(phys_size_t size, ulong align,
-				 phys_addr_t max_addr, uint flags)
+phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t max_addr,
+			   uint flags)
 {
 	phys_addr_t alloc;
 
diff --git a/test/lib/lmb.c b/test/lib/lmb.c
index 971614fd8314..fcb5f1af532a 100644
--- a/test/lib/lmb.c
+++ b/test/lib/lmb.c
@@ -128,7 +128,7 @@ static int test_multi_alloc(struct unit_test_state *uts, const phys_addr_t ram,
 	ASSERT_LMB(mem_lst, used_lst, 0, 0, 2, alloc_64k_addr, 0x10000,
 		   ram_end - 4, 4, 0, 0);
 	/* alloc below end of reserved region -> below reserved region */
-	b = lmb_alloc_base(4, 1, alloc_64k_end);
+	b = lmb_alloc_base(4, 1, alloc_64k_end, LMB_NONE);
 	ut_asserteq(b, alloc_64k_addr - 4);
 	ASSERT_LMB(mem_lst, used_lst, 0, 0, 2,
 		   alloc_64k_addr - 4, 0x10000 + 4, ram_end - 4, 4, 0, 0);
@@ -138,7 +138,7 @@ static int test_multi_alloc(struct unit_test_state *uts, const phys_addr_t ram,
 	ut_asserteq(c, ram_end - 8);
 	ASSERT_LMB(mem_lst, used_lst, 0, 0, 2,
 		   alloc_64k_addr - 4, 0x10000 + 4, ram_end - 8, 8, 0, 0);
-	d = lmb_alloc_base(4, 1, alloc_64k_end);
+	d = lmb_alloc_base(4, 1, alloc_64k_end, LMB_NONE);
 	ut_asserteq(d, alloc_64k_addr - 8);
 	ASSERT_LMB(mem_lst, used_lst, 0, 0, 2,
 		   alloc_64k_addr - 8, 0x10000 + 8, ram_end - 8, 8, 0, 0);
@@ -163,7 +163,7 @@ static int test_multi_alloc(struct unit_test_state *uts, const phys_addr_t ram,
 		   alloc_64k_addr - 8, 4, alloc_64k_addr, 0x10000,
 		   ram_end - 8, 4);
 	/* allocate again to ensure we get the same address */
-	b2 = lmb_alloc_base(4, 1, alloc_64k_end);
+	b2 = lmb_alloc_base(4, 1, alloc_64k_end, LMB_NONE);
 	ut_asserteq(b, b2);
 	ASSERT_LMB(mem_lst, used_lst, 0, 0, 2,
 		   alloc_64k_addr - 8, 0x10000 + 8, ram_end - 8, 4, 0, 0);
@@ -363,7 +363,7 @@ static int test_noreserved(struct unit_test_state *uts, const phys_addr_t ram,
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 0, 0, 0, 0, 0, 0, 0);
 
 	/* allocate a block with base*/
-	b = lmb_alloc_base(alloc_size, align, ram_end);
+	b = lmb_alloc_base(alloc_size, align, ram_end, LMB_NONE);
 	ut_assert(a == b);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1,
 		   ram + ram_size - alloc_size_aligned,
-- 
2.45.2

