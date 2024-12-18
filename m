Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C686E77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 07:03:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12DFF8027E;
	Wed, 18 Dec 2024 08:03:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="x6NTuU4M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CBD680243; Wed, 18 Dec 2024 08:03:09 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 802FE802EF
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 08:03:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-382610c7116so3186062f8f.0
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 23:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734505385; x=1735110185; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kmxL27mFCIVKJbTFnHm6/Ljivpz1TZT5CVJfvULBZkM=;
 b=x6NTuU4M4I/zvujmQyFziztQsnu01dG9atukNpUR03RTZrwFYeu1trrVzKvwRE8R0q
 YwrMNorPodZNMydwVX9nATgHHh604IvLVQXoHqWo5vJ3iJ00Qft47GT1PH9BWV6i39CK
 p/1/Yh8G43iC6l7qfv9zLhXe8rwNfJeXTJ62UM5LzPDx+pr22KCQU+gZGd2fZ5jBjx8S
 RpT3dYC5K5ynfucRRlSt269aYckKk8KB6GAmJNbO1trM3EfLd425KLRAVWEiR2peo9h3
 zftVEn5EhuLRps6AMriZLtIJUomo6yC5bRE9JsXCKPgzY5lhnB9UB7b6Z2D6JifKK0Gr
 e5Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734505385; x=1735110185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kmxL27mFCIVKJbTFnHm6/Ljivpz1TZT5CVJfvULBZkM=;
 b=OFnfHEPQolKAj52CgfBl4p3+F5mNAcfm9W/EP7rcE34psT2EgjDWples8pIcIkNEBF
 AuCXEYaUISbI7Z4SOevtB3cwRmzVcG/oDB6//r9qnuXy7BKsdbiYGJHmEF4B/Qjac6ci
 neuhfXolP9lQ5hS2X0Dm1OVnNUC+tVMWVERmoBd4tv26HtWbOGInXQoRwa3wZeYBeIHx
 e4L8GHadjtA+dAvLXycyk0dsd4L6Wo1DJ1t/LP4v4UC7esbrzmdDIVZ/3MnBoT38Zzur
 RzhbnNQd/TDEUxRG/4jkQ7dCmyiqSbERWJJQaaPjPe8c5zyAgvpA4TAAODR0XINtqCMi
 NY6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVODM+TuQIcrhKhaYkkQJff2oSME/DivGCnLhaKv/YT030ZL+2ZQLygNXZZ2Rhpra02cnMewTo=@lists.denx.de
X-Gm-Message-State: AOJu0YxN4nZmZALOQg6TyUtrDAVJzebTGpZp2lc48DVeAp+cFA7eU8ug
 c5Em80s5IZR4JgNgKQDurx9Dv3qgA6Uc8JAyjunWH0j3rsh7wRcqhYZGdoYwDzw=
X-Gm-Gg: ASbGncvgJY1KiDJc3yEwXqjTKknqCAzN+gxCPbavf44LuV737MTiZrnStJ3kij0DAT7
 zHzauWzx8JVixo66PzVcXYEFgOTUAChLb4ximBFBizwedzmYAb+kV0TnGHEIx56oHzg4wFBsgck
 jLNrTLAaiP5Yj5u/9KCgCNw3lUHYoUh2YOuPOOCUdr7XpwK1i+3Nm91sz0G73Og/6Czc1G4ILaa
 h+1SP1eRxXkWU488PwK0nIvFkFKu9LC9Sq4bIZLppROoq5lwtxykXNifXffmhq9cV1yvsn2K8Xn
 g0NZZPhJNFuu9cdkTkyCqHBsbcDd5fix8w==
X-Google-Smtp-Source: AGHT+IH8rgrM2ybScpoXwHd6dztj7ytwuzEHTIKsE87wXjOzr14S36mM+uiYwk32WrQutg4LEApIzQ==
X-Received: by 2002:a05:6000:186f:b0:385:f69a:7e5f with SMTP id
 ffacd0b85a97d-388e4d8df8bmr1282346f8f.38.1734505384949; 
 Tue, 17 Dec 2024 23:03:04 -0800 (PST)
Received: from localhost.localdomain (ppp176092181030.access.hol.gr.
 [176.92.181.30]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8060592sm12971612f8f.98.2024.12.17.23.03.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 23:03:04 -0800 (PST)
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
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Janne Grunau <j@jannau.net>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH v2 2/8] lmb: Move enum lmb_flags to a u32
Date: Wed, 18 Dec 2024 09:02:31 +0200
Message-ID: <20241218070251.686383-3-ilias.apalodimas@linaro.org>
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

LMB flags is not an enum anymore. It's currently used as a bitmask
in various places of our code. So make it a u32 which is more
appropriate when dealing with masks.

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Tested-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 boot/image-fdt.c  |  4 ++--
 include/lmb.h     | 27 +++++++++++++--------------
 lib/lmb.c         | 18 +++++++++---------
 test/cmd/bdinfo.c |  2 +-
 4 files changed, 25 insertions(+), 26 deletions(-)

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
index 03d5fac6aa79..3b911d5d8391 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -19,18 +19,17 @@
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
+ * DOC: Memory region attribute flags.
+ *
+ * %LMB_NONE: No special request
+ * %LMB_NOMAP: Don't add to MMU configuration
+ * %LMB_NOOVERWRITE: The memory region cannot be overwritten/re-reserved
+ * %LMB_NONOTIFY: Do not notify other modules of changes to this memory region
+ */
+#define LMB_NONE 0
+#define LMB_NOMAP BIT(0)
+#define LMB_NOOVERWRITE BIT(1)
+#define LMB_NONOTIFY BIT(2)
 
 /**
  * struct lmb_region - Description of one region
@@ -41,7 +40,7 @@ enum lmb_flags {
 struct lmb_region {
 	phys_addr_t base;
 	phys_size_t size;
-	enum lmb_flags flags;
+	u32 flags;
 };
 
 /**
@@ -101,7 +100,7 @@ long lmb_reserve(phys_addr_t base, phys_size_t size);
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

