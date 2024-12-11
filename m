Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A8EE7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 10:56:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 622488021D;
	Wed, 11 Dec 2024 11:55:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LGZjSiui";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8628C801BF; Wed, 11 Dec 2024 11:55:34 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57A618021F
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 11:55:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-aa6aee68a57so148583666b.3
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 02:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733914532; x=1734519332; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZQsPHQ1/jdI36lyyoSKwR2ROE1TShrRikMUQaGqrphk=;
 b=LGZjSiuinQBXxr0bw7al75l59pL0Qk4BxbSU3Zjqrdxqk8CpdKkfXNBfgU7ThmVVtT
 8O8XQ7ykdeum4HnJWPZCHI8a1x7ApRub498AH6hmYMfwT5orr+n+nw4rEVopMuU9QLx8
 JPKACRMZZSkic2triigekCaCReXvumdpI0IJK+9Th5rSdE+ia+bc2+0Sx4TICv1MzEbr
 ldbOvuEEEPg7xcJ452vx8+W/B1TBNSBBAS6vQhuZK9tupC5/1Mao8OzGqnZop8MkRJqp
 Z4sK8th4v/RdjWyUTh+yz79K/Cdkrh5wYeffdZFrrBMhUIKiD/dpPOXGIc3r3GvaAvME
 qk4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733914532; x=1734519332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZQsPHQ1/jdI36lyyoSKwR2ROE1TShrRikMUQaGqrphk=;
 b=V46JmzC9xuOJeU3Lk/rfHb3DWYn/7FhEniEJ9qgtT/7r/Pc1zz/BXO+4eVHOrbTY2x
 XFJducKhGRdQBSrNndDncsF/ywwOASay05KSqNtlePhufe4X3TW1HihHHRxJrYh8ZmXm
 hu+i8slPh2AqDZ+P+1xjQF9juIJPEt7oeWVCbeROeq2uCkjoK/mdiTcNTan3LVM4Wipn
 xkZmATMB6/iGTZDM1PhT32c6Zb5etML6eDvRLWUG7bBn+qH7Jzb3qjR7HkN9GBc5mUQI
 9YEZRYG9ddKNLIr47BCRtMSfTWJVD3wyh/5H0pzgvBQoDB58+JLhC+/DF+AeFeJx84Xl
 kDIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVe0tIWFkQr0BM54v5Fh2AuGCwpUgRci9uug3iCO7PTx1chELlQlsuWnd/Awht+1Hvn98/9aCU=@lists.denx.de
X-Gm-Message-State: AOJu0YwkmFXh7aMWh9C5rctQLQPTog1Gi+tQ+eiaHNx1mxGptNbS1Fj5
 Oa256X+tSYUP2FZmBrDDbki0LrY8bEJeVHs0Ulj+oE56YrDirY9WaybbZf9gLSQ=
X-Gm-Gg: ASbGnctQIHI/LEds8APbOvSJ6Ta3dAa+UFRsR0DOvaYk9pqX3GlT4g7dBQQ/XdvUZFb
 7/0aGEk7ff93LKvcOx/vARc2A6agavEf8qfKDFqZH7jwVMKMsquuTeFavam35xFI/3Ls5nmGm8G
 J8WJJ4y75cWeiBxy6F3mry6Gi4TGbIFQGYlNRGvpdfb44/HHeOwUmNa0LYnfYmK6YA6p0wmB6wI
 uxzoD7eSfdma6lXKnKHwJTKkqncYYY+OCzpewKhO9sYVedaaLq4GX4x08ohf/5cfxNfUqTwPRmP
 PmG3UAaz3rXBkaFWL81WO+xnafpw8Pw=
X-Google-Smtp-Source: AGHT+IEQJn1ezvP2DgGI80UP6OjBfvI0z1Q3PYi9/D1WEKhtqFH1GawLpgnWE9KfaGuRTAROHavyjA==
X-Received: by 2002:a17:906:31c1:b0:aa6:9624:78f7 with SMTP id
 a640c23a62f3a-aa6b118234cmr216300766b.17.1733914531755; 
 Wed, 11 Dec 2024 02:55:31 -0800 (PST)
Received: from localhost.localdomain (ppp176092181030.access.hol.gr.
 [176.92.181.30]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa67e652b1dsm508006566b.172.2024.12.11.02.55.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 02:55:31 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de,
	trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Peter Korsgaard <peter@korsgaard.com>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Nam Cao <namcao@linutronix.de>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Janne Grunau <j@jannau.net>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH v1 6/8] lmb: Remove lmb_alloc_addr_flags()
Date: Wed, 11 Dec 2024 12:54:47 +0200
Message-ID: <20241211105504.453234-7-ilias.apalodimas@linaro.org>
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

lmb_alloc_addr() is just calling lmb_alloc_addr_flags() with LMB_NONE
There's not much we gain from this abstraction, so let's remove the
latter, add a flags argument to lmb_alloc_addr() and make the code a
bit easier to follow.

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
index 3db35992df8d..5e59915340b7 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -92,7 +92,6 @@ long lmb_reserve(phys_addr_t base, phys_size_t size, u32 flags);
 
 phys_addr_t lmb_alloc(phys_size_t size, ulong align);
 phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t max_addr);
-phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size);
 phys_size_t lmb_get_free_size(phys_addr_t addr);
 
 /**
@@ -113,8 +112,8 @@ phys_addr_t lmb_alloc_base_flags(phys_size_t size, ulong align,
 				 phys_addr_t max_addr, uint flags);
 
 /**
- * lmb_alloc_addr_flags() - Allocate specified memory address with specified
- *			    attributes
+ * lmb_alloc_addr() - Allocate specified memory address with specified attributes
+ *
  * @base: Base Address requested
  * @size: Size of the region requested
  * @flags: Memory region attributes to be set
@@ -125,8 +124,7 @@ phys_addr_t lmb_alloc_base_flags(phys_size_t size, ulong align,
  *
  * Return: Base address on success, 0 on error.
  */
-phys_addr_t lmb_alloc_addr_flags(phys_addr_t base, phys_size_t size,
-				 uint flags);
+phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size, uint flags);
 
 /**
  * lmb_is_reserved_flags() - Test if address is in reserved region with flag
@@ -164,7 +162,7 @@ void lmb_pop(struct lmb *store);
 
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

