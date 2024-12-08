Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE44E77173
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 10:53:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93E088954F;
	Sun,  8 Dec 2024 11:53:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uWuQ0jqY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9BE7895A1; Sun,  8 Dec 2024 11:53:02 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0BD6893BF
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 11:53:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-aa67af4dc60so39040266b.2
 for <u-boot@lists.denx.de>; Sun, 08 Dec 2024 02:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733655180; x=1734259980; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Ft5M/+tzeZwzuuJMrMRIXXkC4+uiGclSrP1ntGrZHs=;
 b=uWuQ0jqYChqABzagbrkDm2YH9SMcXHpXO+/GTlvLGFW5QQKib3WUbHyA/R5nSTBNl+
 Pab/TgyQCz2IZrw+FM55rtOOIRqIXSqtphb9T7GuRmeFSXn+PO7cYTQr0BDETzHEhtM/
 HMOjiLHwxiBFjvLo6u5icKYCUluvUV2h/eOXOEnGmaNw+iZaOsDg4Cp4oKcOvWXW7nCS
 Yb7TozUas0kKDO3r4UDYKA6u59nSxCfdyvgeBL5Vu0603b1DnNYUB8t6IHDQfXePY0sA
 P2sG26yffXHzcQoYTVocNKhIYWxPimmfbIWAXVQ0DpHeUDa+7hB2rnJogIVkYddxq6mZ
 XHvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733655180; x=1734259980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2Ft5M/+tzeZwzuuJMrMRIXXkC4+uiGclSrP1ntGrZHs=;
 b=uuUXjK4COQAc1UIjBebtl7XaeDyNE1KpObbGUwNm1DkPWDCqekzi1xvvP2+8HKTB+D
 UwmDgirDfAoT/t7LD3EZjqcs9COgD1Gk2cdr8qO0gjXAeVUNsNtU6osDYnmTszJxMvNP
 q+xAszaB8iy9ESqkrIPddDW4u9ah3iSpkuB3JGBME1zzs5anPUn4E/jamjbzXku8IgJa
 8MmbXPDQ+BFoHUSBDIFfvnVqg8F1xtYkH7myXjOR+t2FUaOEf+YFhEVV8IAfQTIq87Yx
 YhECPvXp/j+3US5e0OlQiR7eJUdJR2wUkjovjOsVZwMiu3fKZMfTKBzSToKMLeC/aG1a
 k1jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGOjww+D2k6Rp1MnAGZZe2fPSto07pAl9iCQPOFGadXhtSdavJDnye9bn5JP5hIThUpxp2Po0=@lists.denx.de
X-Gm-Message-State: AOJu0YxlRP9HBOagqEh6DW0pBe5yyJAItkAAShHwN8kVXEVK8WqLuQt9
 YxAymZ9TmAEgFqEXEX9neUDnu2ojN5N7oFHAQsVZSgvYf5igYPSC7A2pbG+SitM=
X-Gm-Gg: ASbGncsMPCXVA8nfaKdjTA8Q2XlnahjtrHRJIElpgpdqaTFqaKOxYJqJwUKRWUkPrb8
 /ZCDXyXAv37uEY0NaPfE3ismxOhJlFa+UQWVp+rzVqUYj9yXDJF5q0r+fPxmyWujhaBBz4y77Jj
 tyHXTu7bOk1YegxIFJHO7rRjNbAchpo7rSdkHBX/ZKNsEbG0GMfo787Ub8aEdX11Vm5BSDhPLzf
 W4SlYc10YcXP4Hk7zQ2YHuH64ef0IAmt2YJv03cFAn0np90ohDSQpWOy2OJphy4LdiFEy9hezSD
 pggSjJ6c27gaZsLvc0DPcUqUJRQ=
X-Google-Smtp-Source: AGHT+IGnZoBt030HafpiqCODucpTYJ99GSrQ07WaIDpms0AaJritdvwqju4QbnMsey2kt6iFYY2t6g==
X-Received: by 2002:a17:907:7714:b0:aa6:3418:d9d4 with SMTP id
 a640c23a62f3a-aa63a073aa6mr686966066b.17.1733655180043; 
 Sun, 08 Dec 2024 02:53:00 -0800 (PST)
Received: from localhost.localdomain (ppp176092181030.access.hol.gr.
 [176.92.181.30]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa625e92fe3sm517768566b.51.2024.12.08.02.52.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Dec 2024 02:52:59 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de,
	trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Peter Korsgaard <peter@korsgaard.com>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Nam Cao <namcao@linutronix.de>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Janne Grunau <j@jannau.net>, Caleb Connolly <caleb.connolly@linaro.org>,
 u-boot@lists.denx.de
Subject: [RFC PATCH 6/7] lmb: Replace lmb_alloc_base() with
 lmb_alloc_base_flags()
Date: Sun,  8 Dec 2024 12:52:09 +0200
Message-ID: <20241208105223.2821049-7-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241208105223.2821049-1-ilias.apalodimas@linaro.org>
References: <20241208105223.2821049-1-ilias.apalodimas@linaro.org>
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
former and make the code a bit easier to follow.

The code size increase is minimal - e.g for sandbox which includes all
of the LMB tests

add/remove: 1/2 grow/shrink: 4/1 up/down: 316/-382 (-66)
Function                                     old     new   delta
lmb_alloc_base_flags                           -     299    +299
test_multi_alloc.constprop                  3036    3042      +6
lmb_alloc                                      4       9      +5
boot_relocate_fdt                            601     605      +4
test_noreserved                             1207    1209      +2
lmb_alloc_base                                48       -     -48
efi_allocate_pages.part                      303     249     -54
_lmb_alloc_base.lto_priv                     280       -    -280
Total: Before=2492763, After=2492697, chg -0.00%

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 boot/image-board.c | 22 +++++++++++++---------
 boot/image-fdt.c   |  6 ++++--
 include/lmb.h      |  1 -
 lib/lmb.c          | 15 +--------------
 test/lib/lmb.c     |  8 ++++----
 5 files changed, 22 insertions(+), 30 deletions(-)

diff --git a/boot/image-board.c b/boot/image-board.c
index c4d914fd6074..d84104ab5c9f 100644
--- a/boot/image-board.c
+++ b/boot/image-board.c
@@ -565,9 +565,11 @@ int boot_ramdisk_high(ulong rd_data, ulong rd_len, ulong *initrd_start,
 			lmb_reserve_flags(rd_data, rd_len, LMB_NONE);
 		} else {
 			if (initrd_high)
-				*initrd_start = (ulong)lmb_alloc_base(rd_len,
-								      0x1000,
-								      initrd_high);
+				*initrd_start =
+					(ulong)lmb_alloc_base_flags(rd_len,
+								    0x1000,
+								    initrd_high,
+								    LMB_NONE);
 			else
 				*initrd_start = (ulong)lmb_alloc(rd_len,
 								 0x1000);
@@ -838,8 +840,9 @@ int boot_get_cmdline(ulong *cmd_start, ulong *cmd_end)
 		return 0;
 
 	barg = IF_ENABLED_INT(CONFIG_SYS_BOOT_GET_CMDLINE, CONFIG_SYS_BARGSIZE);
-	cmdline = (char *)(ulong)lmb_alloc_base(barg, 0xf,
-				env_get_bootm_mapsize() + env_get_bootm_low());
+	cmdline = (char *)(ulong)lmb_alloc_base_flags(barg, 0xf,
+				env_get_bootm_mapsize() + env_get_bootm_low(),
+				LMB_NONE);
 	if (!cmdline)
 		return -1;
 
@@ -871,10 +874,11 @@ int boot_get_cmdline(ulong *cmd_start, ulong *cmd_end)
  */
 int boot_get_kbd(struct bd_info **kbd)
 {
-	*kbd = (struct bd_info *)(ulong)lmb_alloc_base(sizeof(struct bd_info),
-						       0xf,
-						       env_get_bootm_mapsize() +
-						       env_get_bootm_low());
+	*kbd = (struct bd_info *)(ulong)lmb_alloc_base_flags(sizeof(struct bd_info),
+							     0xf,
+							     env_get_bootm_mapsize() +
+							     env_get_bootm_low(),
+							     LMB_NONE);
 	if (!*kbd)
 		return -1;
 
diff --git a/boot/image-fdt.c b/boot/image-fdt.c
index fd68b8594325..a4ef01a8a470 100644
--- a/boot/image-fdt.c
+++ b/boot/image-fdt.c
@@ -188,7 +188,8 @@ int boot_relocate_fdt(char **of_flat_tree, ulong *of_size)
 					  LMB_NONE);
 			disable_relocation = 1;
 		} else if (desired_addr) {
-			addr = lmb_alloc_base(of_len, 0x1000, desired_addr);
+			addr = lmb_alloc_base_flags(of_len, 0x1000, desired_addr,
+						    LMB_NONE);
 			of_start = map_sysmem(addr, of_len);
 			if (of_start == NULL) {
 				puts("Failed using fdt_high value for Device Tree");
@@ -217,7 +218,8 @@ int boot_relocate_fdt(char **of_flat_tree, ulong *of_size)
 			 * for LMB allocation.
 			 */
 			usable = min(start + size, low + mapsize);
-			addr = lmb_alloc_base(of_len, 0x1000, usable);
+			addr = lmb_alloc_base_flags(of_len, 0x1000, usable,
+						    LMB_NONE);
 			of_start = map_sysmem(addr, of_len);
 			/* Allocation succeeded, use this block. */
 			if (of_start != NULL)
diff --git a/include/lmb.h b/include/lmb.h
index 4e8e4f23e279..a35a69d69f77 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -93,7 +93,6 @@ long lmb_add(phys_addr_t base, phys_size_t size);
 long lmb_reserve_flags(phys_addr_t base, phys_size_t size,
 		       enum lmb_flags flags);
 phys_addr_t lmb_alloc(phys_size_t size, ulong align);
-phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t max_addr);
 phys_size_t lmb_get_free_size(phys_addr_t addr);
 
 phys_addr_t lmb_alloc_base_flags(phys_size_t size, ulong align,
diff --git a/lib/lmb.c b/lib/lmb.c
index 6dbdd81bd7d8..c09f1a1277ad 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -747,20 +747,7 @@ static phys_addr_t _lmb_alloc_base(phys_size_t size, ulong align,
 
 phys_addr_t lmb_alloc(phys_size_t size, ulong align)
 {
-	return lmb_alloc_base(size, align, LMB_ALLOC_ANYWHERE);
-}
-
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
+	return lmb_alloc_base_flags(size, align, LMB_ALLOC_ANYWHERE, LMB_NONE);
 }
 
 /**
diff --git a/test/lib/lmb.c b/test/lib/lmb.c
index 49857cb3fd4b..df61b2fd5a0c 100644
--- a/test/lib/lmb.c
+++ b/test/lib/lmb.c
@@ -128,7 +128,7 @@ static int test_multi_alloc(struct unit_test_state *uts, const phys_addr_t ram,
 	ASSERT_LMB(mem_lst, used_lst, 0, 0, 2, alloc_64k_addr, 0x10000,
 		   ram_end - 4, 4, 0, 0);
 	/* alloc below end of reserved region -> below reserved region */
-	b = lmb_alloc_base(4, 1, alloc_64k_end);
+	b = lmb_alloc_base_flags(4, 1, alloc_64k_end, LMB_NONE);
 	ut_asserteq(b, alloc_64k_addr - 4);
 	ASSERT_LMB(mem_lst, used_lst, 0, 0, 2,
 		   alloc_64k_addr - 4, 0x10000 + 4, ram_end - 4, 4, 0, 0);
@@ -138,7 +138,7 @@ static int test_multi_alloc(struct unit_test_state *uts, const phys_addr_t ram,
 	ut_asserteq(c, ram_end - 8);
 	ASSERT_LMB(mem_lst, used_lst, 0, 0, 2,
 		   alloc_64k_addr - 4, 0x10000 + 4, ram_end - 8, 8, 0, 0);
-	d = lmb_alloc_base(4, 1, alloc_64k_end);
+	d = lmb_alloc_base_flags(4, 1, alloc_64k_end, LMB_NONE);
 	ut_asserteq(d, alloc_64k_addr - 8);
 	ASSERT_LMB(mem_lst, used_lst, 0, 0, 2,
 		   alloc_64k_addr - 8, 0x10000 + 8, ram_end - 8, 8, 0, 0);
@@ -163,7 +163,7 @@ static int test_multi_alloc(struct unit_test_state *uts, const phys_addr_t ram,
 		   alloc_64k_addr - 8, 4, alloc_64k_addr, 0x10000,
 		   ram_end - 8, 4);
 	/* allocate again to ensure we get the same address */
-	b2 = lmb_alloc_base(4, 1, alloc_64k_end);
+	b2 = lmb_alloc_base_flags(4, 1, alloc_64k_end, LMB_NONE);
 	ut_asserteq(b, b2);
 	ASSERT_LMB(mem_lst, used_lst, 0, 0, 2,
 		   alloc_64k_addr - 8, 0x10000 + 8, ram_end - 8, 4, 0, 0);
@@ -363,7 +363,7 @@ static int test_noreserved(struct unit_test_state *uts, const phys_addr_t ram,
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 0, 0, 0, 0, 0, 0, 0);
 
 	/* allocate a block with base*/
-	b = lmb_alloc_base(alloc_size, align, ram_end);
+	b = lmb_alloc_base_flags(alloc_size, align, ram_end, LMB_NONE);
 	ut_assert(a == b);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1,
 		   ram + ram_size - alloc_size_aligned,
-- 
2.45.2

