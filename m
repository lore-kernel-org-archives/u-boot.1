Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9742C27C5F
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 18:57:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A019488506;
	Fri,  7 Jun 2024 20:54:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31B238848F; Fri,  7 Jun 2024 20:54:50 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 9141E88551
 for <u-boot@lists.denx.de>; Fri,  7 Jun 2024 20:54:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B5BB1480;
 Fri,  7 Jun 2024 11:55:11 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F4833F792;
 Fri,  7 Jun 2024 11:54:44 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Fabio Estevam <festevam@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [RFC PATCH 23/31] test: lmb: initialise the lmb structure before tests
Date: Sat,  8 Jun 2024 00:22:32 +0530
Message-Id: <20240607185240.1892031-24-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
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

The LMB allocations are now persistent and global, and with that all
the local instances of the structure variable have been removed. Every
LMB test cases that are run require a clean slate of the structure --
facilitate that by adding an initialisation function which gets called
at the start of every test.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
 include/lmb.h  |  4 ++++
 lib/lmb.c      | 17 +++++++++++++++++
 test/lib/lmb.c | 18 ++++++++++++++++++
 3 files changed, 39 insertions(+)

diff --git a/include/lmb.h b/include/lmb.h
index 1d4cd255d2..08ece0a90b 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -148,6 +148,10 @@ void arch_lmb_reserve_generic(ulong sp, ulong end, ulong align);
  */
 void lmb_reserve_common(void *fdt_blob);
 
+#if defined(CONFIG_SANDBOX)
+void lmb_init(void);
+#endif /* CONFIG_SANDBOX */
+
 #endif /* __KERNEL__ */
 
 #endif /* _LINUX_LMB_H */
diff --git a/lib/lmb.c b/lib/lmb.c
index c9f6ca692e..2798ce0989 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -718,3 +718,20 @@ static int efi_mem_map_update_sync(void *ctx, struct event *event)
 }
 EVENT_SPY_FULL(EVT_EFI_MEM_MAP_UPDATE, efi_mem_map_update_sync);
 #endif /* MEM_MAP_UPDATE_NOTIFY */
+
+#if CONFIG_IS_ENABLED(SANDBOX)
+void lmb_init(void)
+{
+#if IS_ENABLED(CONFIG_LMB_USE_MAX_REGIONS)
+	lmb.memory.max = CONFIG_LMB_MAX_REGIONS;
+	lmb.reserved.max = CONFIG_LMB_MAX_REGIONS;
+#else
+	lmb.memory.max = CONFIG_LMB_MEMORY_REGIONS;
+	lmb.reserved.max = CONFIG_LMB_RESERVED_REGIONS;
+	lmb.memory.region = memory_regions;
+	lmb.reserved.region = reserved_regions;
+#endif
+	lmb.memory.cnt = 0;
+	lmb.reserved.cnt = 0;
+}
+#endif /* SANDBOX */
diff --git a/test/lib/lmb.c b/test/lib/lmb.c
index ace1ddf4e4..260ebcfcd3 100644
--- a/test/lib/lmb.c
+++ b/test/lib/lmb.c
@@ -77,6 +77,8 @@ static int test_multi_alloc(struct unit_test_state *uts, const phys_addr_t ram,
 	ut_assert(alloc_64k_addr >= ram + 8);
 	ut_assert(alloc_64k_end <= ram_end - 8);
 
+	lmb_init();
+
 	if (ram0_size) {
 		ret = lmb_add(ram0, ram0_size);
 		ut_asserteq(ret, 0);
@@ -235,6 +237,8 @@ static int test_bigblock(struct unit_test_state *uts, const phys_addr_t ram)
 	/* check for overflow */
 	ut_assert(ram_end == 0 || ram_end > ram);
 
+	lmb_init();
+
 	ret = lmb_add(ram, ram_size);
 	ut_asserteq(ret, 0);
 
@@ -299,6 +303,8 @@ static int test_noreserved(struct unit_test_state *uts, const phys_addr_t ram,
 	/* check for overflow */
 	ut_assert(ram_end == 0 || ram_end > ram);
 
+	lmb_init();
+
 	ret = lmb_add(ram, ram_size);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(&lmb, ram, ram_size, 0, 0, 0, 0, 0, 0, 0);
@@ -382,6 +388,8 @@ static int lib_test_lmb_at_0(struct unit_test_state *uts)
 	long ret;
 	phys_addr_t a, b;
 
+	lmb_init();
+
 	ret = lmb_add(ram, ram_size);
 	ut_asserteq(ret, 0);
 
@@ -418,6 +426,8 @@ static int lib_test_lmb_overlapping_reserve(struct unit_test_state *uts)
 	const phys_size_t ram_size = 0x20000000;
 	long ret;
 
+	lmb_init();
+
 	ret = lmb_add(ram, ram_size);
 	ut_asserteq(ret, 0);
 
@@ -473,6 +483,8 @@ static int test_alloc_addr(struct unit_test_state *uts, const phys_addr_t ram)
 	/* check for overflow */
 	ut_assert(ram_end == 0 || ram_end > ram);
 
+	lmb_init();
+
 	ret = lmb_add(ram, ram_size);
 	ut_asserteq(ret, 0);
 
@@ -597,6 +609,8 @@ static int test_get_unreserved_size(struct unit_test_state *uts,
 	/* check for overflow */
 	ut_assert(ram_end == 0 || ram_end > ram);
 
+	lmb_init();
+
 	ret = lmb_add(ram, ram_size);
 	ut_asserteq(ret, 0);
 
@@ -664,6 +678,8 @@ static int lib_test_lmb_max_regions(struct unit_test_state *uts)
 	phys_addr_t offset;
 	int ret, i;
 
+	lmb_init();
+
 	ut_asserteq(lmb.memory.cnt, 0);
 	ut_asserteq(lmb.memory.max, CONFIG_LMB_MAX_REGIONS);
 	ut_asserteq(lmb.reserved.cnt, 0);
@@ -722,6 +738,8 @@ static int lib_test_lmb_flags(struct unit_test_state *uts)
 	const phys_size_t ram_size = 0x20000000;
 	long ret;
 
+	lmb_init();
+
 	ret = lmb_add(ram, ram_size);
 	ut_asserteq(ret, 0);
 
-- 
2.34.1

