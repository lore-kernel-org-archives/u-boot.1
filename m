Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C14E9E77180
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 10:55:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2746F801F0;
	Wed, 11 Dec 2024 11:55:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ujYFMosy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34F2F80212; Wed, 11 Dec 2024 11:55:21 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E213801ED
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 11:55:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-aa6aee68a57so148542866b.3
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 02:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733914517; x=1734519317; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YbLpubeED0aQaKkvNACnHm1nwskLRmvJIgDVU5EU9oc=;
 b=ujYFMosy2jzLfqS4FPGmrz1brpgGPhLS7lxFik0FU05Jm9MugnFig8GVsrwK3Ra3Oa
 sEyym4ZfEZ5fynNrvQmb/q4AEdcMZtkOAx8EEJTFNZVvwJaAoajCbbdf/hwDkFC35SG1
 QV1YA6WGQa6++aFTg4O+Efqcr1lZhGt2XCHgzHqVUwt/K8kzAR4qFvhflbq2/cSpJp8Z
 Jywczq0371UYf73aeyWpPGkhqdeOsZBgKiw2B/r6rxcjmM/wxfWgDTDqTrYiXNUuXqvW
 t9Z+sDQJGb2UGPgeb/B7YIFw3i3v7Ssk8N76JYA72zPl93+cIfYVZmV84U2nI+CpEWDG
 kqig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733914517; x=1734519317;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YbLpubeED0aQaKkvNACnHm1nwskLRmvJIgDVU5EU9oc=;
 b=Zr2yvZKAm3Q+L5EEVYcGLY9ge6/Lp9prys9fRQdyUR0IERNMeJXz17+DYkg9wJwN/H
 TTkFxmALWKE9N94OPgDicXn6B5JuamPHeJ/x+G8/s7VyCEpeeAMt7tFHx1CpvBBFVMft
 V2A6+t+MELX9o/khsxoCpXqJV9yXtyhtd2y0Tgsl2plTPGNVPJ1w8M76ZrdqC/PuEWe8
 jVCS5TKWU361NUTIOcx5jmPDL/H5x3rSOJGvtTy/7WsoPuYjH6cgYxEdeVImnWdTMC4p
 H33XM4ymBAnHsLUR9janZADrOWwlhJG1ZQCfi8AvC18zonsIrUdfJDYV7dC6AAegnaYe
 U6zA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxYTKgrlOPU8YI1xQhTC6Nx2+uhbMr9Gk/wDlIQwK1dxliI2rxJcHlMMjTjzsW7d8/zvGzrdE=@lists.denx.de
X-Gm-Message-State: AOJu0Yyv2hD81y53lNSe1iNByPuehPD4KA07r42tusgoymqTN84EKxSt
 C0ojiUJ7Lde7XC2E8nJYlUWWdrqkP+sHqZtew+LTMyy9+IHQLEx/kFOoYUTdYPw=
X-Gm-Gg: ASbGncsNMcoPFGDCxKuD1B5zwU7W1SwI8M2wzKZ+JEsAq5Vq2sKRB/nQB2nf0ZSztkQ
 z+Rvr06Pn/gN2humCkcnc+1ip1qXF6Sx+Lw6EW5OrxZFc7MS+rkDWrF3tREu6g5hoC1t0hZKjr4
 39sSc8a8/IWIERePvV4AVKOsOYanLtYiFcEuQ654Rp7SihIy/KaQOwk5IO/dqqLKclgglfNSeaN
 6+Z9lnlQEFjR0nvrR/W54i0eAK6TGgmu7xyl9vciqxKscd6TOicjrnRnfbj2nscNw2tirL5uDcK
 wVujiO6VhMDIF3SLId5uaw9e+Jm/IPI=
X-Google-Smtp-Source: AGHT+IGxMnk3m06vQzF1hqKmJtWfnJ75kXIsBGlwc7tz33mbqFBWYYg2kC5V7+wRcF/aHgSSVbjnhQ==
X-Received: by 2002:a17:906:2922:b0:aa6:834b:d138 with SMTP id
 a640c23a62f3a-aa6b1180468mr212349566b.19.1733914516737; 
 Wed, 11 Dec 2024 02:55:16 -0800 (PST)
Received: from localhost.localdomain (ppp176092181030.access.hol.gr.
 [176.92.181.30]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa67e652b1dsm508006566b.172.2024.12.11.02.55.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 02:55:16 -0800 (PST)
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
 Baruch Siach <baruch@tkos.co.il>, Nam Cao <namcao@linutronix.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Janne Grunau <j@jannau.net>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH v1 2/8] lmb: Move enum lmb_flags to a u32
Date: Wed, 11 Dec 2024 12:54:43 +0200
Message-ID: <20241211105504.453234-3-ilias.apalodimas@linaro.org>
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

LMB flags is not an enum anymore. It's currently used as a bitmask
in various places of our code. So make it a u32 which is more
appropriate when dealing with masks.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 boot/image-fdt.c  |  4 ++--
 include/lmb.h     | 25 +++++++++++--------------
 lib/lmb.c         | 18 +++++++++---------
 test/cmd/bdinfo.c |  2 +-
 4 files changed, 23 insertions(+), 26 deletions(-)

diff --git a/boot/image-fdt.c b/boot/image-fdt.c
index 73c43c30684f..cda7c3aa9e38 100644
--- a/boot/image-fdt.c
+++ b/boot/image-fdt.c
@@ -68,7 +68,7 @@ static const struct legacy_img_hdr *image_get_fdt(ulong fdt_addr)
 }
 #endif

-static void boot_fdt_reserve_region(u64 addr, u64 size, enum lmb_flags flags)
+static void boot_fdt_reserve_region(u64 addr, u64 size, u32 flags)
 {
 	long ret;

@@ -100,7 +100,7 @@ void boot_fdt_add_mem_rsv_regions(void *fdt_blob)
 	int i, total, ret;
 	int nodeoffset, subnode;
 	struct fdt_resource res;
-	enum lmb_flags flags;
+	u32 flags;

 	if (fdt_check_header(fdt_blob) != 0)
 		return;
diff --git a/include/lmb.h b/include/lmb.h
index 03d5fac6aa79..7db9e0b62840 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -19,18 +19,15 @@
 #define LMB_ALIST_INITIAL_SIZE	4

 /**
- * enum lmb_flags - Definition of memory region attributes
- * @LMB_NONE: No special request
- * @LMB_NOMAP: Don't add to MMU configuration
- * @LMB_NOOVERWRITE: The memory region cannot be overwritten/re-reserved
- * @LMB_NONOTIFY: Do not notify other modules of changes to this memory region
- */
-enum lmb_flags {
-	LMB_NONE		= 0,
-	LMB_NOMAP		= BIT(1),
-	LMB_NOOVERWRITE		= BIT(2),
-	LMB_NONOTIFY		= BIT(3),
-};
+ * LMB_NONE: No special request
+ * LMB_NOMAP: Don't add to MMU configuration
+ * LMB_NOOVERWRITE: The memory region cannot be overwritten/re-reserved
+ * LMB_NONOTIFY: Do not notify other modules of changes to this memory region
+ */
+#define LMB_NONE 0
+#define LMB_NOMAP BIT(0)
+#define LMB_NOOVERWRITE BIT(1)
+#define LMB_NONOTIFY BIT(2)

 /**
  * struct lmb_region - Description of one region
@@ -41,7 +38,7 @@ enum lmb_flags {
 struct lmb_region {
 	phys_addr_t base;
 	phys_size_t size;
-	enum lmb_flags flags;
+	u32 flags;
 };

 /**
@@ -101,7 +98,7 @@ long lmb_reserve(phys_addr_t base, phys_size_t size);
  * * %-1	- Failure
  */
 long lmb_reserve_flags(phys_addr_t base, phys_size_t size,
-		       enum lmb_flags flags);
+		       u32 flags);

 phys_addr_t lmb_alloc(phys_size_t size, ulong align);
 phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t max_addr);
diff --git a/lib/lmb.c b/lib/lmb.c
index b9c26cb02e10..edecdb8e9cbf 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -188,7 +188,7 @@ static long lmb_resize_regions(struct alist *lmb_rgn_lst,
  * * %-1	- Failure
  */
 static long lmb_add_region_flags(struct alist *lmb_rgn_lst, phys_addr_t base,
-				 phys_size_t size, enum lmb_flags flags)
+				 phys_size_t size, u32 flags)
 {
 	unsigned long coalesced = 0;
 	long ret, i;
@@ -201,7 +201,7 @@ static long lmb_add_region_flags(struct alist *lmb_rgn_lst, phys_addr_t base,
 	for (i = 0; i < lmb_rgn_lst->count; i++) {
 		phys_addr_t rgnbase = rgn[i].base;
 		phys_size_t rgnsize = rgn[i].size;
-		enum lmb_flags rgnflags = rgn[i].flags;
+		u32 rgnflags = rgn[i].flags;

 		ret = lmb_addrs_adjacent(base, size, rgnbase, rgnsize);
 		if (ret > 0) {
@@ -430,14 +430,14 @@ long io_lmb_free(struct lmb *io_lmb, phys_addr_t base, phys_size_t size)

 static struct lmb lmb;

-static bool lmb_should_notify(enum lmb_flags flags)
+static bool lmb_should_notify(u32 flags)
 {
 	return !lmb.test && !(flags & LMB_NONOTIFY) &&
 		CONFIG_IS_ENABLED(EFI_LOADER);
 }

 static int lmb_map_update_notify(phys_addr_t addr, phys_size_t size, u8 op,
-				 enum lmb_flags flags)
+				 u32 flags)
 {
 	u64 efi_addr;
 	u64 pages;
@@ -470,7 +470,7 @@ static int lmb_map_update_notify(phys_addr_t addr, phys_size_t size, u8 op,
 	return 0;
 }

-static void lmb_print_region_flags(enum lmb_flags flags)
+static void lmb_print_region_flags(u32 flags)
 {
 	const char * const flag_str[] = { "none", "no-map", "no-overwrite",
 					  "no-notify" };
@@ -495,7 +495,7 @@ static void lmb_dump_region(struct alist *lmb_rgn_lst, char *name)
 {
 	struct lmb_region *rgn = lmb_rgn_lst->data;
 	unsigned long long base, size, end;
-	enum lmb_flags flags;
+	u32 flags;
 	int i;

 	printf(" %s.count = %#x\n", name, lmb_rgn_lst->count);
@@ -669,7 +669,7 @@ long lmb_free(phys_addr_t base, phys_size_t size)
 	return lmb_free_flags(base, size, LMB_NONE);
 }

-long lmb_reserve_flags(phys_addr_t base, phys_size_t size, enum lmb_flags flags)
+long lmb_reserve_flags(phys_addr_t base, phys_size_t size, u32 flags)
 {
 	long ret = 0;
 	struct alist *lmb_rgn_lst = &lmb.used_mem;
@@ -687,7 +687,7 @@ long lmb_reserve(phys_addr_t base, phys_size_t size)
 }

 static phys_addr_t _lmb_alloc_base(phys_size_t size, ulong align,
-				   phys_addr_t max_addr, enum lmb_flags flags)
+				   phys_addr_t max_addr, u32 flags)
 {
 	int ret;
 	long i, rgn;
@@ -774,7 +774,7 @@ phys_addr_t lmb_alloc_base_flags(phys_size_t size, ulong align,
 }

 static phys_addr_t _lmb_alloc_addr(phys_addr_t base, phys_size_t size,
-				   enum lmb_flags flags)
+				   u32 flags)
 {
 	long rgn;
 	struct lmb_region *lmb_memory = lmb.free_mem.data;
diff --git a/test/cmd/bdinfo.c b/test/cmd/bdinfo.c
index bb419ab2394e..014391b38ac0 100644
--- a/test/cmd/bdinfo.c
+++ b/test/cmd/bdinfo.c
@@ -104,7 +104,7 @@ static int lmb_test_dump_region(struct unit_test_state *uts,
 {
 	struct lmb_region *rgn = lmb_rgn_lst->data;
 	unsigned long long base, size, end;
-	enum lmb_flags flags;
+	u32 flags;
 	int i;

 	ut_assert_nextline(" %s.count = %#x", name, lmb_rgn_lst->count);
--
2.45.2

