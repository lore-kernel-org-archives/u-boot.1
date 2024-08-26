Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D91ABC5321D
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 12:02:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82F0388A00;
	Mon, 26 Aug 2024 14:01:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EED7B8806A; Mon, 26 Aug 2024 14:01:03 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id CDC4388AFB
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 14:01:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B3C1DA7;
 Mon, 26 Aug 2024 05:01:27 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 97CFD3F762;
 Mon, 26 Aug 2024 05:00:57 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Michal Simek <michal.simek@amd.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v4 13/27] lmb: remove lmb_init_and_reserve_range() function
Date: Mon, 26 Aug 2024 17:29:26 +0530
Message-Id: <20240826115940.3233167-14-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826115940.3233167-1-sughosh.ganu@linaro.org>
References: <20240826115940.3233167-1-sughosh.ganu@linaro.org>
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
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changes since V3: None

 boot/bootm.c  | 15 +--------------
 include/lmb.h |  3 ---
 lib/lmb.c     |  8 --------
 3 files changed, 1 insertion(+), 25 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index e244b9b410..ddede08979 100644
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
index 04558724a7..2f155d706e 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -63,9 +63,6 @@ struct lmb {
  */
 int lmb_init(void);
 
-void lmb_init_and_reserve_range(phys_addr_t base, phys_size_t size,
-				void *fdt_blob);
-
 /**
  * lmb_add_memory() - Add memory range for LMB allocations
  *
diff --git a/lib/lmb.c b/lib/lmb.c
index de4d0d1803..686988e34f 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -227,14 +227,6 @@ static void lmb_reserve_common(void *fdt_blob)
 		efi_lmb_reserve();
 }
 
-/* Initialize the struct, add memory and call arch/board reserve functions */
-void lmb_init_and_reserve_range(phys_addr_t base, phys_size_t size,
-				void *fdt_blob)
-{
-	lmb_add(base, size);
-	lmb_reserve_common(fdt_blob);
-}
-
 static __maybe_unused void lmb_reserve_common_spl(void)
 {
 	phys_addr_t rsv_start;
-- 
2.34.1

