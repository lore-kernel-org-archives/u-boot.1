Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F487E77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 07:04:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F09F88022B;
	Wed, 18 Dec 2024 08:03:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hB+Qo4lE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83A1080214; Wed, 18 Dec 2024 08:03:27 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99EA28033D
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 08:03:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43621d27adeso42386195e9.2
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 23:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734505404; x=1735110204; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nZoqy5ApK1lE77i+xi36rzIAJ7MNo42oHPI6/sOtP9M=;
 b=hB+Qo4lEZHZDKKGvvezCbjpdrYfcBY/Q+yHjJW9ZZ4x6zRrrZaG9a+4dhf5iFsPCvY
 UiYQPjwTMXv5h8GxQqQLJ8glAaZ8cT037r1rTwX3kW6USwNkBXbfVF8XEjUGmDAe+TTb
 v7uvAX1SxnMk/QdWfEXzygbV6VZgBNL1VVjgTE06pVELcBUcGwSFNXzqMRBka5CJ1ELR
 5G34GjpaKlEB5u2/HuNLSFmYghYn+gWyompkvAYa2TjmQpb1TKs0GjPUplWrHYXS4Bwu
 0a+cYEei/HG9qagt5vV6t9yakxNiuBa9aU4WlXYJMiNhlAZzP+LHA2Um6SdRlO2PpGGg
 QKlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734505404; x=1735110204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nZoqy5ApK1lE77i+xi36rzIAJ7MNo42oHPI6/sOtP9M=;
 b=sl2GZr7CKq5bnX+JWbB5ydxrPuGnFEWZR5vldeJ6Y1+VUVgeklfB8I/LBDPjwZX70G
 4q1ddmXWOgI8l1mvqr55zRHBuoh2LBDx5hybQcDAGwJfc2pLNNEYEW8LlCNcMDnk1JwJ
 oDp5cYmmFhlDg0unXVzaGyWrYq3knZSO3KrXMp/R5uzdcJI4PLC+IfkdcAT0lfep5sbS
 lSWwW1CzmoYckwpoM+BI/iZsPen6mOx9qjAX/ihxKnN2Vft5cozPY3vcOVRPs1n3avQZ
 ZidOwTtnM7TU0uxNbO/nMVXM2bFDWCcWPC9WwFPKm8THD8kVSjnH7WcSMP6G1tO0g2Uk
 bEtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1KqlYlss2ouSGLu2CjGDiRpYmgvrRMFemaKnrafsko3zN5wp6wBNFC3QQEfFz46ZbkHetLYQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzNHnrJ7JlcqHgi4rz1z2DSWn42nqHZWbuRJRNlY2xxBKm7Nlml
 fwcK+g1C4u4kUoczd3srO0CqvrPoLNr5azUvoTLyyHmIjdtg2DshyRK6ktn65mE=
X-Gm-Gg: ASbGncvm8k9WoJrSrJmdSg+ShnTPUIDH9zxk1XUCXeRsIy7w/x8cpYS1L5XW1aJR9/1
 bc3QiI1BM/NVJLJDEiVexDl4WEzP2nn+U3BTUWJNoiTPaFOX09jZ6osjkJ7R8WQRcUClpxZ+VJV
 yUzt8Xw9r8FWiktaM4fWSljx4CNzco1zkCaVJF7prnAJ9KHpVx7XJaYeIGCPAdKLFMWRACODezh
 VMQSIa9pS4j7ne0GtdXVDqLu5No6M3ULltnZ3FjwmWAhtA3lgtOz4/8MQoZykl5MEfUisBKw06e
 WjH2V+iH0f1H7JK/askiSWumfUmAzmSqCA==
X-Google-Smtp-Source: AGHT+IG45I8RRU1veBioc+5fnYhltscA2wK+N1cZUmWNglPuVPIQINwn6G5yuMKduOYyEzBdo/gpkw==
X-Received: by 2002:a05:600c:1d29:b0:434:a902:97cd with SMTP id
 5b1f17b1804b1-4365535dd89mr12066595e9.12.1734505404043; 
 Tue, 17 Dec 2024 23:03:24 -0800 (PST)
Received: from localhost.localdomain (ppp176092181030.access.hol.gr.
 [176.92.181.30]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8060592sm12971612f8f.98.2024.12.17.23.03.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 23:03:23 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de,
	trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michael Walle <mwalle@kernel.org>, Peter Korsgaard <peter@korsgaard.com>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Nam Cao <namcao@linutronix.de>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Prasad Kummari <prasad.kummari@amd.com>, Janne Grunau <j@jannau.net>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH v2 7/8] lmb: Remove lmb_alloc_base_flags()
Date: Wed, 18 Dec 2024 09:02:36 +0200
Message-ID: <20241218070251.686383-8-ilias.apalodimas@linaro.org>
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

lmb_alloc_base() is just calling lmb_alloc_base_flags() with LMB_NONE.
There's not much we gain from this abstraction, so let's remove the
former add the flags argument to lmb_alloc_base() and make the code
a bit easier to follow.

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Tested-by: Sam Protsenko <semen.protsenko@linaro.org>
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
index e38af036a0d0..a0e666a1f7c3 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -93,11 +93,10 @@ long lmb_add(phys_addr_t base, phys_size_t size);
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
@@ -110,8 +109,8 @@ phys_size_t lmb_get_free_size(phys_addr_t addr);
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

