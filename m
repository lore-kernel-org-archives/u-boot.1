Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3109E77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 07:03:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0CC780327;
	Wed, 18 Dec 2024 08:03:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xSUafSFs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6301A80317; Wed, 18 Dec 2024 08:03:23 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E5ED80214
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 08:03:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4361f796586so67127485e9.3
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 23:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734505400; x=1735110200; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wAGJkBIwNOsSutnccXwuAcu3Cb4fiUiBWKCSjpp2MNc=;
 b=xSUafSFs6VRRHlaz2mfZBHWb4M/5OKP0z5y0wkFhuB0ZqI5iJ1DlfMzFqH++joS2Ti
 ybsbz+//pv3FmVoRs6bd22M4q+mVDJq+d/Gc5jfNj7nWGuqiVplpmZZ54bnoTsUu9cqC
 +0PElo16hzwu2cqD+Irmguj46XI2a9prqS6A3kUuyZW60SAsUcOpG0oFqBrmIUF4GPmS
 dpMYfdVMhNe/P1YYo++5xSXBhmC8O+dBKZEn/oUynZY/FX8IQSnNfGvWCm7ZbboPhVbm
 k0LZhqkixSSs2tdgdIQtuSJ7kujtQFOz512g9FvQvdAIiEHvkXOduqEW33/zhVCPy9/x
 L64g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734505400; x=1735110200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wAGJkBIwNOsSutnccXwuAcu3Cb4fiUiBWKCSjpp2MNc=;
 b=MBWZVvCzNdmkHRl4feSMNOP6lVz2OhCEyGuJYor9HgYik5621xjbgyc9ultSQXXBwL
 KaXzZdkqDHc+SolwqgFZH3g7LqcbAyxDB67dukgycGQbW4pKW4PPUbFYSyNC7O+/TsjG
 bLxwq+HnBOe2oclZviojEcSv2MyeB925XTwSgbf8+FkW2SEWXCAHDAOjDLR9IdeGrtUL
 T8CvUB0+0xuocEC98bnbK1IOX5FJE3xTd36/Kf1rXocjC+zq4/EdWi0Oy7aQ0j48tbsY
 VLfL+57lj6c5OpibvZpt0h0gnfUq2g+H6LfYQNXPR5WhqM8qK7KT3YON92HNX820D3YG
 gByg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDY9m3l3mPAdUjTKkjoUpq/3uaSBIKLm4DmnuhENsHtk+THSQX1GbKmku0PJg9uylURMgLGGo=@lists.denx.de
X-Gm-Message-State: AOJu0YwLAkivPcD8Be0TI8x1e85NUDoOe4kDWMC4XnK+wRUj7fQ0L2Tq
 tyXNUEKaO7vH43oqvgxYrxAx8/LT9Hqwh4XUsD2lW6GV+jh5vMJrO2c/cUXn0tc=
X-Gm-Gg: ASbGncu9NAiJSrzn15KpGlsbzZ8UxCC/vfbHlKGcnfN3nlxY3NAJ1Vk0VmZDWRfVJej
 1MD6QZftsRvNyosbKtbSmkx+ZNaVrpZA1Num87X7kmhBg07QkyohKaC+jUltkXsJmClqHWe+V3a
 xQEZhCCUUxXVo0L+JJ6bqnwrB5iFTB3qbsVjileWeeWAjNOrsnRy5UuqueldQF5pzQizAY2koEj
 s5QdGJaATVxkFZSKV1TSWLTXqIWGHoDQN9OFSrBREtFoLQBJ8tYMsesFltlCXd7mvW3g6f6CX09
 vTOkSETgoUw61mdF2nohps2V9F5tJj2JlQ==
X-Google-Smtp-Source: AGHT+IEMA6iIZVI/u+/1Wa3FAcQkQJLC7E/tSACjlFRJDporBZykQnoG5GI5E2gcvXwRCqn3kZnYSQ==
X-Received: by 2002:a05:6000:4021:b0:385:f6f4:f8e with SMTP id
 ffacd0b85a97d-388e4db8a44mr1043836f8f.50.1734505400496; 
 Tue, 17 Dec 2024 23:03:20 -0800 (PST)
Received: from localhost.localdomain (ppp176092181030.access.hol.gr.
 [176.92.181.30]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8060592sm12971612f8f.98.2024.12.17.23.03.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 23:03:20 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de,
	trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michael Walle <mwalle@kernel.org>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Peter Korsgaard <peter@korsgaard.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Sean Anderson <seanga2@gmail.com>, Nam Cao <namcao@linutronix.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Prasad Kummari <prasad.kummari@amd.com>, Janne Grunau <j@jannau.net>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH v2 6/8] lmb: Remove lmb_alloc_addr_flags()
Date: Wed, 18 Dec 2024 09:02:35 +0200
Message-ID: <20241218070251.686383-7-ilias.apalodimas@linaro.org>
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

lmb_alloc_addr() is just calling lmb_alloc_addr_flags() with LMB_NONE
There's not much we gain from this abstraction, so let's remove the
latter, add a flags argument to lmb_alloc_addr() and make the code a
bit easier to follow.

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Tested-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 fs/fs.c                     |  2 +-
 include/lmb.h               | 10 ++++------
 lib/efi_loader/efi_memory.c |  2 +-
 lib/lmb.c                   | 15 ++-------------
 test/lib/lmb.c              | 34 +++++++++++++++++-----------------
 5 files changed, 25 insertions(+), 38 deletions(-)

diff --git a/fs/fs.c b/fs/fs.c
index 21a23efd932d..99ddcc5e37be 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -554,7 +554,7 @@ static int fs_read_lmb_check(const char *filename, ulong addr, loff_t offset,
 
 	lmb_dump_all();
 
-	if (lmb_alloc_addr(addr, read_len) == addr)
+	if (lmb_alloc_addr(addr, read_len, LMB_NONE) == addr)
 		return 0;
 
 	log_err("** Reading file would overwrite reserved memory **\n");
diff --git a/include/lmb.h b/include/lmb.h
index 18030c610ab2..e38af036a0d0 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -94,7 +94,6 @@ long lmb_reserve(phys_addr_t base, phys_size_t size, u32 flags);
 
 phys_addr_t lmb_alloc(phys_size_t size, ulong align);
 phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t max_addr);
-phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size);
 phys_size_t lmb_get_free_size(phys_addr_t addr);
 
 /**
@@ -115,8 +114,8 @@ phys_addr_t lmb_alloc_base_flags(phys_size_t size, ulong align,
 				 phys_addr_t max_addr, uint flags);
 
 /**
- * lmb_alloc_addr_flags() - Allocate specified memory address with specified
- *			    attributes
+ * lmb_alloc_addr() - Allocate specified memory address with specified attributes
+ *
  * @base: Base Address requested
  * @size: Size of the region requested
  * @flags: Memory region attributes to be set
@@ -127,8 +126,7 @@ phys_addr_t lmb_alloc_base_flags(phys_size_t size, ulong align,
  *
  * Return: Base address on success, 0 on error.
  */
-phys_addr_t lmb_alloc_addr_flags(phys_addr_t base, phys_size_t size,
-				 uint flags);
+phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size, uint flags);
 
 /**
  * lmb_is_reserved_flags() - Test if address is in reserved region with flag
@@ -166,7 +164,7 @@ void lmb_pop(struct lmb *store);
 
 static inline int lmb_read_check(phys_addr_t addr, phys_size_t len)
 {
-	return lmb_alloc_addr(addr, len) == addr ? 0 : -1;
+	return lmb_alloc_addr(addr, len, LMB_NONE) == addr ? 0 : -1;
 }
 
 /**
diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index edd7da7d8c6e..34e2b9e18ef0 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -490,7 +490,7 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
 			return EFI_NOT_FOUND;
 
 		addr = map_to_sysmem((void *)(uintptr_t)*memory);
-		addr = (u64)lmb_alloc_addr_flags(addr, len, flags);
+		addr = (u64)lmb_alloc_addr(addr, len, flags);
 		if (!addr)
 			return EFI_NOT_FOUND;
 		break;
diff --git a/lib/lmb.c b/lib/lmb.c
index 659581f13f20..ffad7ec12eb5 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -761,8 +761,7 @@ phys_addr_t lmb_alloc_base_flags(phys_size_t size, ulong align,
 	return alloc;
 }
 
-static phys_addr_t _lmb_alloc_addr(phys_addr_t base, phys_size_t size,
-				   u32 flags)
+static phys_addr_t _lmb_alloc_addr(phys_addr_t base, phys_size_t size, u32 flags)
 {
 	long rgn;
 	struct lmb_region *lmb_memory = lmb.available_mem.data;
@@ -786,17 +785,7 @@ static phys_addr_t _lmb_alloc_addr(phys_addr_t base, phys_size_t size,
 	return 0;
 }
 
-/*
- * Try to allocate a specific address range: must be in defined memory but not
- * reserved
- */
-phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size)
-{
-	return _lmb_alloc_addr(base, size, LMB_NONE);
-}
-
-phys_addr_t lmb_alloc_addr_flags(phys_addr_t base, phys_size_t size,
-				 uint flags)
+phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size, uint flags)
 {
 	return _lmb_alloc_addr(base, size, flags);
 }
diff --git a/test/lib/lmb.c b/test/lib/lmb.c
index 6e870274fedb..971614fd8314 100644
--- a/test/lib/lmb.c
+++ b/test/lib/lmb.c
@@ -530,21 +530,21 @@ static int test_alloc_addr(struct unit_test_state *uts, const phys_addr_t ram)
 	ut_asserteq(ret, 0);
 
 	/* Try to allocate a page twice */
-	b = lmb_alloc_addr_flags(alloc_addr_a, 0x1000, LMB_NONE);
+	b = lmb_alloc_addr(alloc_addr_a, 0x1000, LMB_NONE);
 	ut_asserteq(b, alloc_addr_a);
-	b = lmb_alloc_addr_flags(alloc_addr_a, 0x1000, LMB_NOOVERWRITE);
+	b = lmb_alloc_addr(alloc_addr_a, 0x1000, LMB_NOOVERWRITE);
 	ut_asserteq(b, 0);
-	b = lmb_alloc_addr_flags(alloc_addr_a, 0x1000, LMB_NONE);
+	b = lmb_alloc_addr(alloc_addr_a, 0x1000, LMB_NONE);
 	ut_asserteq(b, alloc_addr_a);
-	b = lmb_alloc_addr_flags(alloc_addr_a, 0x2000, LMB_NONE);
+	b = lmb_alloc_addr(alloc_addr_a, 0x2000, LMB_NONE);
 	ut_asserteq(b, alloc_addr_a);
 	ret = lmb_free(alloc_addr_a, 0x2000);
 	ut_asserteq(ret, 0);
-	b = lmb_alloc_addr_flags(alloc_addr_a, 0x1000, LMB_NOOVERWRITE);
+	b = lmb_alloc_addr(alloc_addr_a, 0x1000, LMB_NOOVERWRITE);
 	ut_asserteq(b, alloc_addr_a);
-	b = lmb_alloc_addr_flags(alloc_addr_a, 0x1000, LMB_NONE);
+	b = lmb_alloc_addr(alloc_addr_a, 0x1000, LMB_NONE);
 	ut_asserteq(b, 0);
-	b = lmb_alloc_addr_flags(alloc_addr_a, 0x1000, LMB_NOOVERWRITE);
+	b = lmb_alloc_addr(alloc_addr_a, 0x1000, LMB_NOOVERWRITE);
 	ut_asserteq(b, 0);
 	ret = lmb_free(alloc_addr_a, 0x1000);
 	ut_asserteq(ret, 0);
@@ -560,22 +560,22 @@ static int test_alloc_addr(struct unit_test_state *uts, const phys_addr_t ram)
 		   alloc_addr_b, 0x10000, alloc_addr_c, 0x10000);
 
 	/* allocate blocks */
-	a = lmb_alloc_addr(ram, alloc_addr_a - ram);
+	a = lmb_alloc_addr(ram, alloc_addr_a - ram, LMB_NONE);
 	ut_asserteq(a, ram);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 3, ram, 0x8010000,
 		   alloc_addr_b, 0x10000, alloc_addr_c, 0x10000);
 	b = lmb_alloc_addr(alloc_addr_a + 0x10000,
-			   alloc_addr_b - alloc_addr_a - 0x10000);
+			   alloc_addr_b - alloc_addr_a - 0x10000, LMB_NONE);
 	ut_asserteq(b, alloc_addr_a + 0x10000);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, ram, 0x10010000,
 		   alloc_addr_c, 0x10000, 0, 0);
 	c = lmb_alloc_addr(alloc_addr_b + 0x10000,
-			   alloc_addr_c - alloc_addr_b - 0x10000);
+			   alloc_addr_c - alloc_addr_b - 0x10000, LMB_NONE);
 	ut_asserteq(c, alloc_addr_b + 0x10000);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, ram, 0x18010000,
 		   0, 0, 0, 0);
 	d = lmb_alloc_addr(alloc_addr_c + 0x10000,
-			   ram_end - alloc_addr_c - 0x10000);
+			   ram_end - alloc_addr_c - 0x10000, LMB_NONE);
 	ut_asserteq(d, alloc_addr_c + 0x10000);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, ram, ram_size,
 		   0, 0, 0, 0);
@@ -591,7 +591,7 @@ static int test_alloc_addr(struct unit_test_state *uts, const phys_addr_t ram)
 
 	/* allocate at 3 points in free range */
 
-	d = lmb_alloc_addr(ram_end - 4, 4);
+	d = lmb_alloc_addr(ram_end - 4, 4, LMB_NONE);
 	ut_asserteq(d, ram_end - 4);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, ram, 0x18010000,
 		   d, 4, 0, 0);
@@ -600,7 +600,7 @@ static int test_alloc_addr(struct unit_test_state *uts, const phys_addr_t ram)
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, ram, 0x18010000,
 		   0, 0, 0, 0);
 
-	d = lmb_alloc_addr(ram_end - 128, 4);
+	d = lmb_alloc_addr(ram_end - 128, 4, LMB_NONE);
 	ut_asserteq(d, ram_end - 128);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, ram, 0x18010000,
 		   d, 4, 0, 0);
@@ -609,7 +609,7 @@ static int test_alloc_addr(struct unit_test_state *uts, const phys_addr_t ram)
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, ram, 0x18010000,
 		   0, 0, 0, 0);
 
-	d = lmb_alloc_addr(alloc_addr_c + 0x10000, 4);
+	d = lmb_alloc_addr(alloc_addr_c + 0x10000, 4, LMB_NONE);
 	ut_asserteq(d, alloc_addr_c + 0x10000);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, ram, 0x18010004,
 		   0, 0, 0, 0);
@@ -624,18 +624,18 @@ static int test_alloc_addr(struct unit_test_state *uts, const phys_addr_t ram)
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, ram + 0x8000000,
 		   0x10010000, 0, 0, 0, 0);
 
-	d = lmb_alloc_addr(ram, 4);
+	d = lmb_alloc_addr(ram, 4, LMB_NONE);
 	ut_asserteq(d, ram);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, d, 4,
 		   ram + 0x8000000, 0x10010000, 0, 0);
 
 	/* check that allocating outside memory fails */
 	if (ram_end != 0) {
-		ret = lmb_alloc_addr(ram_end, 1);
+		ret = lmb_alloc_addr(ram_end, 1, LMB_NONE);
 		ut_asserteq(ret, 0);
 	}
 	if (ram != 0) {
-		ret = lmb_alloc_addr(ram - 1, 1);
+		ret = lmb_alloc_addr(ram - 1, 1, LMB_NONE);
 		ut_asserteq(ret, 0);
 	}
 
-- 
2.45.2

