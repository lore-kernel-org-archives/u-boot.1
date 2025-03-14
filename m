Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B44A5C282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 10:57:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B33881870;
	Fri, 14 Mar 2025 11:57:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="d4fLBq5T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9BF28197D; Fri, 14 Mar 2025 11:57:18 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1965180F9C
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 11:57:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5e5e22e6ed2so2910651a12.3
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 03:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741949834; x=1742554634; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=m/hVCTvXMcwr+MnabozUTY0iknD2nVRitBHq9SCn7Cc=;
 b=d4fLBq5TawePtJ1bch89wf3+qtPd3FLlajjofg5/CVugSYETeuoOtLWXAT0nYigfqp
 0kbdCsGruIjlq3pb+SfBVlk9h4rgRholaHDH57b2n+V2KysNVyrOsmnAzzppAeswOBbH
 qOz2maUG7Wn21FLRx+v3bohsElE/VjZ6ttFEDw6u+74QcCjxx1NRoO/b6KB9umfnW+Bu
 t4s5OT6AFc6Vfxw+2DU/RDZl+KwRSVcPz97bRrwqYWZLXKKpUpMX64aJURdsuHWFY33A
 YbgDjnaX92X+V00z7mtCrhzx8KGG+XPOzC80CVoT7BWjWBKwcmrzpippw3tM9KhT4Omm
 NRPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741949834; x=1742554634;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m/hVCTvXMcwr+MnabozUTY0iknD2nVRitBHq9SCn7Cc=;
 b=FgtqCfWKTPn0xRMHdXssp09zIp7fKmPgOjntbIl8l4xSfImSmIes8rmIcRPzN0glff
 yHQbpF7By4LHF3WW1tRwOssrb1U8O5tVFzKb2XTHcAtjbDgl0BG+MVaJe8qyGBK9ayIz
 AILMBNzgnyFIlRpllPTTkvBLO2AzvzWg7c94KpHfP3ej9SkF9xJrCFqKIngFn4hODaHF
 jxGjaSm0UAFHYTyYlW944XVJdMKF89qvcWiIKgPz54B+WklJbyk4pfbF7LGTn9j+7owE
 yk8gz2onR8pPCsgdY3LqVT+MhdSjvBgzQWmReQVRFqrt14Ztok50xk3RzIKlFXUyeY6a
 iGCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6HnH6k0S8kHxQ40YKOah2D4LGS8Ofpu0C74BNo1ludy1cAxkWbYPHwPtKyhsjiMP5aD0lL1U=@lists.denx.de
X-Gm-Message-State: AOJu0Ywe8lxoOG2M6iMnMKzAwmeMZMzVqqwUHl/FTPXEzTTC2Ifyz6IH
 8+wksj1/JhKLPHtkUev0sRjoWWadUnS3coqEUxvGDstyMhY4AJ4ji/AI6xmE3ko=
X-Gm-Gg: ASbGncvl4RpfB38NfdMrmFtft6bMYyPccUHhFVpX96v4D/4XKvVHocwzWacON9WohAK
 1ACwNOih3WHzaD5/JhnkNJm2Tmzg/7zzGvrxytJVGH3iWu/9+ySwk4gNP6LcYuEloCuHTcJTXbt
 hscrjpfVKgk0HtMpmKbZSwi68EnVi7NTVGDY2IRVEoI6+P2+AOCFHAd3927TFTF0v93ACV6a37q
 Xw6nkp90oYwZ1LtRWuSzEFgNPPzHLFyMhDGfb4AbFcY9tlIpTjstCY8o4IQ53k+t5dIpUBqrCjb
 J/bmm4961H9RFriEGfnPXMdwolWSZTtR/3jieRicKbOkk+qlHgcje8weHtfz0qmpAhlYJNYBQCh
 vwaJN+wxbw+8WkGlZ1ykQkV0=
X-Google-Smtp-Source: AGHT+IF1TqgMNTTL99u/caNgUH07TVBRE9Jy+44qlOTLxv6pert0aiKRgFpM8PJK7GF9zzii95zv7w==
X-Received: by 2002:a05:6402:51ca:b0:5e7:73ad:60a2 with SMTP id
 4fb4d7f45d1cf-5e8a0c09c6emr2221214a12.30.1741949834368; 
 Fri, 14 Mar 2025 03:57:14 -0700 (PDT)
Received: from localhost.localdomain (ppp089210242125.access.hol.gr.
 [89.210.242.125]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e816ad9ca5sm1790754a12.50.2025.03.14.03.57.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 03:57:13 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de
Cc: ardb@kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ben Schneider <ben@bens.haus>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Nam Cao <namcao@linutronix.de>, Baruch Siach <baruch@tkos.co.il>,
 Sam Protsenko <semen.protsenko@linaro.org>, Janne Grunau <j@jannau.net>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH] lmb: change the return code on lmb_alloc_addr()
Date: Fri, 14 Mar 2025 12:57:02 +0200
Message-ID: <20250314105703.277315-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.47.2
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

Ben reports a failure to boot the kernel on hardware that starts its
physical memory from 0x0.
The reason is that lmb_alloc_addr(), which is supposed to reserve a
specific address, takes the address as the first argument, but then also
returns the address for success or failure and treats 0 as a failure.

Since we already know the address change the prototype to return an int.

Reported-by: Ben Schneider <ben@bens.haus>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 fs/fs.c                     |  2 +-
 include/lmb.h               |  6 ++---
 lib/efi_loader/efi_memory.c |  3 +--
 lib/lmb.c                   |  6 ++---
 test/lib/lmb.c              | 53 +++++++++++++++++++------------------
 5 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/fs/fs.c b/fs/fs.c
index 99ddcc5e37be..1ed7c0f2d2c7 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -554,7 +554,7 @@ static int fs_read_lmb_check(const char *filename, ulong addr, loff_t offset,
 
 	lmb_dump_all();
 
-	if (lmb_alloc_addr(addr, read_len, LMB_NONE) == addr)
+	if (!lmb_alloc_addr(addr, read_len, LMB_NONE))
 		return 0;
 
 	log_err("** Reading file would overwrite reserved memory **\n");
diff --git a/include/lmb.h b/include/lmb.h
index 09297a4f530a..0d316c64c0a3 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -135,9 +135,9 @@ phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t max_addr,
  * parameter. The base parameter is used to specify the base address
  * of the requested region.
  *
- * Return: Base address on success, 0 on error.
+ * Return: 0 on success -1 on error
  */
-phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size, u32 flags);
+int lmb_alloc_addr(phys_addr_t base, phys_size_t size, u32 flags);
 
 /**
  * lmb_is_reserved_flags() - Test if address is in reserved region with flag
@@ -175,7 +175,7 @@ void lmb_pop(struct lmb *store);
 
 static inline int lmb_read_check(phys_addr_t addr, phys_size_t len)
 {
-	return lmb_alloc_addr(addr, len, LMB_NONE) == addr ? 0 : -1;
+	return lmb_alloc_addr(addr, len, LMB_NONE);
 }
 
 /**
diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index 6d00b1862505..c39b53922bb4 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -491,8 +491,7 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
 			return EFI_NOT_FOUND;
 
 		addr = map_to_sysmem((void *)(uintptr_t)*memory);
-		addr = (u64)lmb_alloc_addr(addr, len, flags);
-		if (!addr)
+		if (lmb_alloc_addr(addr, len, flags))
 			return EFI_NOT_FOUND;
 		break;
 	default:
diff --git a/lib/lmb.c b/lib/lmb.c
index 93fc1bea07cd..61bb13dc4e24 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -714,7 +714,7 @@ phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t max_addr,
 	return alloc;
 }
 
-phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size, u32 flags)
+int lmb_alloc_addr(phys_addr_t base, phys_size_t size, u32 flags)
 {
 	long rgn;
 	struct lmb_region *lmb_memory = lmb.available_mem.data;
@@ -731,11 +731,11 @@ phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size, u32 flags)
 				      base + size - 1, 1)) {
 			/* ok, reserve the memory */
 			if (!lmb_reserve(base, size, flags))
-				return base;
+				return 0;
 		}
 	}
 
-	return 0;
+	return -1;
 }
 
 /* Return number of bytes from a given address that are free */
diff --git a/test/lib/lmb.c b/test/lib/lmb.c
index fcb5f1af532a..01b1c7fdedd0 100644
--- a/test/lib/lmb.c
+++ b/test/lib/lmb.c
@@ -531,21 +531,21 @@ static int test_alloc_addr(struct unit_test_state *uts, const phys_addr_t ram)
 
 	/* Try to allocate a page twice */
 	b = lmb_alloc_addr(alloc_addr_a, 0x1000, LMB_NONE);
-	ut_asserteq(b, alloc_addr_a);
-	b = lmb_alloc_addr(alloc_addr_a, 0x1000, LMB_NOOVERWRITE);
 	ut_asserteq(b, 0);
+	b = lmb_alloc_addr(alloc_addr_a, 0x1000, LMB_NOOVERWRITE);
+	ut_asserteq(b, -1);
 	b = lmb_alloc_addr(alloc_addr_a, 0x1000, LMB_NONE);
-	ut_asserteq(b, alloc_addr_a);
+	ut_asserteq(b, 0);
 	b = lmb_alloc_addr(alloc_addr_a, 0x2000, LMB_NONE);
-	ut_asserteq(b, alloc_addr_a);
+	ut_asserteq(b, 0);
 	ret = lmb_free(alloc_addr_a, 0x2000);
 	ut_asserteq(ret, 0);
 	b = lmb_alloc_addr(alloc_addr_a, 0x1000, LMB_NOOVERWRITE);
-	ut_asserteq(b, alloc_addr_a);
-	b = lmb_alloc_addr(alloc_addr_a, 0x1000, LMB_NONE);
 	ut_asserteq(b, 0);
+	b = lmb_alloc_addr(alloc_addr_a, 0x1000, LMB_NONE);
+	ut_asserteq(b, -1);
 	b = lmb_alloc_addr(alloc_addr_a, 0x1000, LMB_NOOVERWRITE);
-	ut_asserteq(b, 0);
+	ut_asserteq(b, -1);
 	ret = lmb_free(alloc_addr_a, 0x1000);
 	ut_asserteq(ret, 0);
 
@@ -561,22 +561,22 @@ static int test_alloc_addr(struct unit_test_state *uts, const phys_addr_t ram)
 
 	/* allocate blocks */
 	a = lmb_alloc_addr(ram, alloc_addr_a - ram, LMB_NONE);
-	ut_asserteq(a, ram);
+	ut_asserteq(a, 0);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 3, ram, 0x8010000,
 		   alloc_addr_b, 0x10000, alloc_addr_c, 0x10000);
 	b = lmb_alloc_addr(alloc_addr_a + 0x10000,
 			   alloc_addr_b - alloc_addr_a - 0x10000, LMB_NONE);
-	ut_asserteq(b, alloc_addr_a + 0x10000);
+	ut_asserteq(b, 0);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, ram, 0x10010000,
 		   alloc_addr_c, 0x10000, 0, 0);
 	c = lmb_alloc_addr(alloc_addr_b + 0x10000,
 			   alloc_addr_c - alloc_addr_b - 0x10000, LMB_NONE);
-	ut_asserteq(c, alloc_addr_b + 0x10000);
+	ut_asserteq(c, 0);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, ram, 0x18010000,
 		   0, 0, 0, 0);
 	d = lmb_alloc_addr(alloc_addr_c + 0x10000,
 			   ram_end - alloc_addr_c - 0x10000, LMB_NONE);
-	ut_asserteq(d, alloc_addr_c + 0x10000);
+	ut_asserteq(d, 0);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, ram, ram_size,
 		   0, 0, 0, 0);
 
@@ -586,57 +586,58 @@ static int test_alloc_addr(struct unit_test_state *uts, const phys_addr_t ram)
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, ram, ram_size,
 		   0, 0, 0, 0);
 
-	ret = lmb_free(d, ram_end - alloc_addr_c - 0x10000);
+	/* free thge allocation from d */
+	ret = lmb_free(alloc_addr_c + 0x10000, ram_end - alloc_addr_c - 0x10000);
 	ut_asserteq(ret, 0);
 
 	/* allocate at 3 points in free range */
 
 	d = lmb_alloc_addr(ram_end - 4, 4, LMB_NONE);
-	ut_asserteq(d, ram_end - 4);
+	ut_asserteq(d, 0);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, ram, 0x18010000,
-		   d, 4, 0, 0);
-	ret = lmb_free(d, 4);
+		   ram_end - 4, 4, 0, 0);
+	ret = lmb_free(ram_end - 4, 4);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, ram, 0x18010000,
 		   0, 0, 0, 0);
 
 	d = lmb_alloc_addr(ram_end - 128, 4, LMB_NONE);
-	ut_asserteq(d, ram_end - 128);
+	ut_asserteq(d, 0);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, ram, 0x18010000,
-		   d, 4, 0, 0);
-	ret = lmb_free(d, 4);
+		   ram_end - 128, 4, 0, 0);
+	ret = lmb_free(ram_end - 128, 4);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, ram, 0x18010000,
 		   0, 0, 0, 0);
 
 	d = lmb_alloc_addr(alloc_addr_c + 0x10000, 4, LMB_NONE);
-	ut_asserteq(d, alloc_addr_c + 0x10000);
+	ut_asserteq(d, 0);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, ram, 0x18010004,
 		   0, 0, 0, 0);
-	ret = lmb_free(d, 4);
+	ret = lmb_free(alloc_addr_c + 0x10000, 4);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, ram, 0x18010000,
 		   0, 0, 0, 0);
 
-	/* allocate at the bottom */
-	ret = lmb_free(a, alloc_addr_a - ram);
+	/* allocate at the bottom a was assigned to ram at the top */
+	ret = lmb_free(ram, alloc_addr_a - ram);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, ram + 0x8000000,
 		   0x10010000, 0, 0, 0, 0);
 
 	d = lmb_alloc_addr(ram, 4, LMB_NONE);
-	ut_asserteq(d, ram);
-	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, d, 4,
+	ut_asserteq(d, 0);
+	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, ram, 4,
 		   ram + 0x8000000, 0x10010000, 0, 0);
 
 	/* check that allocating outside memory fails */
 	if (ram_end != 0) {
 		ret = lmb_alloc_addr(ram_end, 1, LMB_NONE);
-		ut_asserteq(ret, 0);
+		ut_asserteq(ret, -1);
 	}
 	if (ram != 0) {
 		ret = lmb_alloc_addr(ram - 1, 1, LMB_NONE);
-		ut_asserteq(ret, 0);
+		ut_asserteq(ret, -1);
 	}
 
 	lmb_pop(&store);
-- 
2.47.2

