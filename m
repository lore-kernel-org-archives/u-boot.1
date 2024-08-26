Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77346C5321E
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 12:01:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D470088B03;
	Mon, 26 Aug 2024 14:00:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1673A88ABA; Mon, 26 Aug 2024 14:00:47 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id CB09D88A77
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 14:00:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 70F28DA7;
 Mon, 26 Aug 2024 05:01:10 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8DDF33F762;
 Mon, 26 Aug 2024 05:00:40 -0700 (PDT)
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
Subject: [PATCH v4 09/27] lmb: allow lmb module to be used in SPL
Date: Mon, 26 Aug 2024 17:29:22 +0530
Message-Id: <20240826115940.3233167-10-sughosh.ganu@linaro.org>
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

With the introduction of separate config symbols for the SPL phase of
U-Boot, the condition checks need to be tweaked so that platforms that
enable the LMB module in SPL are also able to call the LMB API's. Use
the appropriate condition checks to achieve this.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changes since V3: None

 board/xilinx/common/board.c |  2 +-
 boot/bootm.c                |  4 ++--
 boot/image-board.c          |  2 +-
 fs/fs.c                     |  4 ++--
 lib/Makefile                |  2 +-
 net/tftp.c                  | 40 ++++++++++++++++++-------------------
 net/wget.c                  |  4 ++--
 7 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
index 4056884400..f04c92a70f 100644
--- a/board/xilinx/common/board.c
+++ b/board/xilinx/common/board.c
@@ -665,7 +665,7 @@ int embedded_dtb_select(void)
 }
 #endif
 
-#if defined(CONFIG_LMB)
+#if IS_ENABLED(CONFIG_LMB)
 
 #ifndef MMU_SECTION_SIZE
 #define MMU_SECTION_SIZE        (1 * 1024 * 1024)
diff --git a/boot/bootm.c b/boot/bootm.c
index d47feddb9b..e244b9b410 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -239,7 +239,7 @@ static int boot_get_kernel(const char *addr_fit, struct bootm_headers *images,
 	return 0;
 }
 
-#ifdef CONFIG_LMB
+#if CONFIG_IS_ENABLED(LMB)
 static void boot_start_lmb(void)
 {
 	phys_addr_t	mem_start;
@@ -1036,7 +1036,7 @@ int bootm_run_states(struct bootm_info *bmi, int states)
 		}
 	}
 #endif
-#if CONFIG_IS_ENABLED(OF_LIBFDT) && defined(CONFIG_LMB)
+#if CONFIG_IS_ENABLED(OF_LIBFDT) && CONFIG_IS_ENABLED(LMB)
 	if (!ret && (states & BOOTM_STATE_FDT)) {
 		boot_fdt_add_mem_rsv_regions(images->ft_addr);
 		ret = boot_relocate_fdt(&images->ft_addr, &images->ft_len);
diff --git a/boot/image-board.c b/boot/image-board.c
index 1f8c1ac69f..99ee7968ba 100644
--- a/boot/image-board.c
+++ b/boot/image-board.c
@@ -883,7 +883,7 @@ int image_setup_linux(struct bootm_headers *images)
 	int ret;
 
 	/* This function cannot be called without lmb support */
-	if (!IS_ENABLED(CONFIG_LMB))
+	if (!CONFIG_IS_ENABLED(LMB))
 		return -EFAULT;
 	if (CONFIG_IS_ENABLED(OF_LIBFDT))
 		boot_fdt_add_mem_rsv_regions(*of_flat_tree);
diff --git a/fs/fs.c b/fs/fs.c
index 2c835eef86..3fb00590be 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -526,7 +526,7 @@ int fs_size(const char *filename, loff_t *size)
 	return ret;
 }
 
-#ifdef CONFIG_LMB
+#if CONFIG_IS_ENABLED(LMB)
 /* Check if a file may be read to the given address */
 static int fs_read_lmb_check(const char *filename, ulong addr, loff_t offset,
 			     loff_t len, struct fstype_info *info)
@@ -567,7 +567,7 @@ static int _fs_read(const char *filename, ulong addr, loff_t offset, loff_t len,
 	void *buf;
 	int ret;
 
-#ifdef CONFIG_LMB
+#if CONFIG_IS_ENABLED(LMB)
 	if (do_lmb_check) {
 		ret = fs_read_lmb_check(filename, addr, offset, len, info);
 		if (ret)
diff --git a/lib/Makefile b/lib/Makefile
index 81b503ab52..d300249f57 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -118,7 +118,7 @@ obj-$(CONFIG_$(SPL_TPL_)OF_LIBFDT) += fdtdec.o fdtdec_common.o
 obj-y += hang.o
 obj-y += linux_compat.o
 obj-y += linux_string.o
-obj-$(CONFIG_LMB) += lmb.o
+obj-$(CONFIG_$(SPL_TPL_)LMB) += lmb.o
 obj-y += membuff.o
 obj-$(CONFIG_REGEX) += slre.o
 obj-y += string.o
diff --git a/net/tftp.c b/net/tftp.c
index c0a6210b9d..99b2ab9fca 100644
--- a/net/tftp.c
+++ b/net/tftp.c
@@ -82,9 +82,7 @@ static ulong	tftp_block_wrap;
 static ulong	tftp_block_wrap_offset;
 static int	tftp_state;
 static ulong	tftp_load_addr;
-#ifdef CONFIG_LMB
 static ulong	tftp_load_size;
-#endif
 #ifdef CONFIG_TFTP_TSIZE
 /* The file size reported by the server */
 static int	tftp_tsize;
@@ -160,19 +158,20 @@ static inline int store_block(int block, uchar *src, unsigned int len)
 	ulong store_addr = tftp_load_addr + offset;
 	void *ptr;
 
-#ifdef CONFIG_LMB
-	ulong end_addr = tftp_load_addr + tftp_load_size;
+	if (CONFIG_IS_ENABLED(LMB)) {
+		ulong end_addr = tftp_load_addr + tftp_load_size;
 
-	if (!end_addr)
-		end_addr = ULONG_MAX;
+		if (!end_addr)
+			end_addr = ULONG_MAX;
 
-	if (store_addr < tftp_load_addr ||
-	    store_addr + len > end_addr) {
-		puts("\nTFTP error: ");
-		puts("trying to overwrite reserved memory...\n");
-		return -1;
+		if (store_addr < tftp_load_addr ||
+		    store_addr + len > end_addr) {
+			puts("\nTFTP error: ");
+			puts("trying to overwrite reserved memory...\n");
+			return -1;
+		}
 	}
-#endif
+
 	ptr = map_sysmem(store_addr, len);
 	memcpy(ptr, src, len);
 	unmap_sysmem(ptr);
@@ -716,17 +715,18 @@ static void tftp_timeout_handler(void)
 /* Initialize tftp_load_addr and tftp_load_size from image_load_addr and lmb */
 static int tftp_init_load_addr(void)
 {
-#ifdef CONFIG_LMB
-	phys_size_t max_size;
+	if (CONFIG_IS_ENABLED(LMB)) {
+		phys_size_t max_size;
 
-	lmb_init_and_reserve(gd->bd, (void *)gd->fdt_blob);
+		lmb_init_and_reserve(gd->bd, (void *)gd->fdt_blob);
 
-	max_size = lmb_get_free_size(image_load_addr);
-	if (!max_size)
-		return -1;
+		max_size = lmb_get_free_size(image_load_addr);
+		if (!max_size)
+			return -1;
+
+		tftp_load_size = max_size;
+	}
 
-	tftp_load_size = max_size;
-#endif
 	tftp_load_addr = image_load_addr;
 	return 0;
 }
diff --git a/net/wget.c b/net/wget.c
index c1cd8216bc..241465b9b4 100644
--- a/net/wget.c
+++ b/net/wget.c
@@ -98,7 +98,7 @@ static inline int store_block(uchar *src, unsigned int offset, unsigned int len)
 	ulong newsize = offset + len;
 	uchar *ptr;
 
-	if (IS_ENABLED(CONFIG_LMB)) {
+	if (CONFIG_IS_ENABLED(LMB)) {
 		ulong end_addr = image_load_addr + wget_load_size;
 
 		if (!end_addr)
@@ -495,7 +495,7 @@ void wget_start(void)
 	debug_cond(DEBUG_WGET,
 		   "\nwget:Load address: 0x%lx\nLoading: *\b", image_load_addr);
 
-	if (IS_ENABLED(CONFIG_LMB)) {
+	if (CONFIG_IS_ENABLED(LMB)) {
 		if (wget_init_load_size()) {
 			printf("\nwget error: ");
 			printf("trying to overwrite reserved memory...\n");
-- 
2.34.1

