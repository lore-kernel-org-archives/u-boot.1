Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A73C3DA61
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 06:08:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 302F9888EB;
	Wed, 24 Jul 2024 08:04:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DA8D887FA; Wed, 24 Jul 2024 08:04:36 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 1B64488875
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 08:04:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11A99106F;
 Tue, 23 Jul 2024 23:04:52 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B31AB3F766;
 Tue, 23 Jul 2024 23:04:21 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Michal Simek <michal.simek@amd.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 20/40] lmb: remove lmb_init_and_reserve_range() function
Date: Wed, 24 Jul 2024 11:32:04 +0530
Message-Id: <20240724060224.3071065-21-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
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

With the move to make the LMB allocations persistent and the common
memory regions being reserved during board init, there is no need for
an explicit reservation of a memory range. Remove the
lmb_init_and_reserve_range() function.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---
Changes since rfc: None

 boot/bootm.c  | 15 +--------------
 include/lmb.h |  3 ---
 lib/lmb.c     |  8 --------
 3 files changed, 1 insertion(+), 25 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 5ce84b73b5..d44fd2ed87 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -239,18 +239,7 @@ static int boot_get_kernel(const char *addr_fit, struct bootm_headers *images,
 	return 0;
 }
 
-#if CONFIG_IS_ENABLED(LMB)
-static void boot_start_lmb(void)
-{
-	phys_addr_t	mem_start;
-	phys_size_t	mem_size;
-
-	mem_start = env_get_bootm_low();
-	mem_size = env_get_bootm_size();
-
-	lmb_init_and_reserve_range(mem_start, mem_size, NULL);
-}
-#else
+#if !CONFIG_IS_ENABLED(LMB)
 #define lmb_reserve(base, size)
 static inline void boot_start_lmb(void) { }
 #endif
@@ -260,8 +249,6 @@ static int bootm_start(void)
 	memset((void *)&images, 0, sizeof(images));
 	images.verify = env_get_yesno("verify");
 
-	boot_start_lmb();
-
 	bootstage_mark_name(BOOTSTAGE_ID_BOOTM_START, "bootm_start");
 	images.state = BOOTM_STATE_START;
 
diff --git a/include/lmb.h b/include/lmb.h
index 50977e6561..2d8f9a6b71 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -37,9 +37,6 @@ struct lmb_region {
 	enum lmb_flags flags;
 };
 
-void lmb_init_and_reserve_range(phys_addr_t base, phys_size_t size,
-				void *fdt_blob);
-
 /**
  * lmb_add_memory() - Add memory range for LMB allocations
  *
diff --git a/lib/lmb.c b/lib/lmb.c
index ce1b0204c9..5afdfc32fb 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -292,14 +292,6 @@ __weak void lmb_add_memory(void)
 	}
 }
 
-/* Initialize the struct, add memory and call arch/board reserve functions */
-void lmb_init_and_reserve_range(phys_addr_t base, phys_size_t size,
-				void *fdt_blob)
-{
-	lmb_add(base, size);
-	lmb_reserve_common(fdt_blob);
-}
-
 static bool lmb_region_flags_match(struct lmb_region *rgn, unsigned long r1,
 				   enum lmb_flags flags)
 {
-- 
2.34.1

