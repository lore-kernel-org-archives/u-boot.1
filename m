Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 776B4C021A4
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 11:13:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41A53809A4;
	Sun, 16 Feb 2025 12:13:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="PkzHVeuA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19C9680F10; Sun, 16 Feb 2025 12:13:00 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EF3E80F10
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 12:12:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id CF1CB3FF78; 
 Sun, 16 Feb 2025 11:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1739704376;
 bh=DOSjmh6QTcDL5GjQfQaG+8Akqw05HQk425kNmXQPrOE=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=PkzHVeuAFoQVceYdGzZMICw0LAcwoESGp1OAboPXQmPT37uqZ0InNGKEl80SBKlZS
 yPU1drYGyNhXGR1UJ58XnjhAnPW+/YDxxojMJmMar7t2OBZCW628kZd2bkr4hJgS98
 ZBCoWrYrEPFQWLgDpI3ZXVFST804dTeAQiurOp7hZf26II0/+TH/fZfGOYZSWetT+0
 jIkMugoapJkuPA19DSV1LoJKAacS24Q6rTUoIgAVUehVohrKCRGFHa7FrkIhkUS4jR
 jz02eYP9RnW9fOFrd++4oEOEhYiSAvmBqq4CUHmW0+B4ARSF9wjxr6f+TyrKonoCuY
 tOHII4z36dtMA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Liya Huang <1425075683@qq.com>, Adriano Cordova <adrianox@gmail.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Janne Grunau <j@jannau.net>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/3] lmb: move lmb_map_update_notify() to EFI
Date: Sun, 16 Feb 2025 12:12:40 +0100
Message-ID: <20250216111241.6846-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250216111241.6846-1-heinrich.schuchardt@canonical.com>
References: <20250216111241.6846-1-heinrich.schuchardt@canonical.com>
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

When building with qemu_arm64_defconfig with CONFIG_CC_OPTIMIZE_FOR_DEBUG=y
and CONFIG_EFI_LOADER an error undefined reference to efi_add_memory_map_pg
occurs.

Move the EFI dependent part of lmb_map_update_notify() to the EFI
sub-system.

Reported-by: Liya Huang <1425075683@qq.com>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Acked-by: Liya Huang <1425075683@qq.com>
---
 include/efi_loader.h        | 15 +++++++++++++++
 lib/efi_loader/efi_memory.c | 27 +++++++++++++++++++++++++++
 lib/lmb.c                   | 31 +++----------------------------
 3 files changed, 45 insertions(+), 28 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index dcae6a731a0..db3d20fd753 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -1263,6 +1263,21 @@ efi_status_t efi_disk_get_device_name(const efi_handle_t handle, char *buf, int
  */
 void efi_add_known_memory(void);
 
+/**
+ * efi_map_update_notify() - notify EFI of memory map changes
+ *
+ * @addr:	start of memory area
+ * @size:	size of memory area
+ * @op:		type of change
+ * Return:	0 if change could be processed
+ */
+#ifdef CONFIG_EFI_LOADER
+int efi_map_update_notify(phys_addr_t addr, phys_size_t size,
+			  enum lmb_map_op op);
+#else
+#define efi_map_update_notify(addr, size, op) (0)
+#endif
+
 /**
  * efi_load_option_dp_join() - join device-paths for load option
  *
diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index 1212772471e..11d092dc289 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -865,3 +865,30 @@ int efi_memory_init(void)
 
 	return 0;
 }
+
+int efi_map_update_notify(phys_addr_t addr, phys_size_t size,
+			  enum lmb_map_op op)
+{
+	u64 efi_addr;
+	u64 pages;
+	efi_status_t status;
+
+	efi_addr = (uintptr_t)map_sysmem(addr, 0);
+	pages = efi_size_in_pages(size + (efi_addr & EFI_PAGE_MASK));
+	efi_addr &= ~EFI_PAGE_MASK;
+
+	status = efi_add_memory_map_pg(efi_addr, pages,
+				       op == LMB_MAP_OP_RESERVE ?
+				       EFI_BOOT_SERVICES_DATA :
+				       EFI_CONVENTIONAL_MEMORY,
+				       false);
+	if (status != EFI_SUCCESS) {
+		log_err("LMB Map notify failure %lu\n",
+			status & ~EFI_ERROR_MASK);
+		return -1;
+	}
+	unmap_sysmem((void *)(uintptr_t)efi_addr);
+
+	return 0;
+}
+
diff --git a/lib/lmb.c b/lib/lmb.c
index 7534a231c99..93fc1bea07c 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -426,37 +426,12 @@ long io_lmb_free(struct lmb *io_lmb, phys_addr_t base, phys_size_t size)
 
 static struct lmb lmb;
 
-static bool lmb_should_notify(u32 flags)
-{
-	return !lmb.test && !(flags & LMB_NONOTIFY) &&
-		CONFIG_IS_ENABLED(EFI_LOADER);
-}
-
 static int lmb_map_update_notify(phys_addr_t addr, phys_size_t size,
 				 enum lmb_map_op op, u32 flags)
 {
-	u64 efi_addr;
-	u64 pages;
-	efi_status_t status;
-
-	if (!lmb_should_notify(flags))
-		return 0;
-
-	efi_addr = (uintptr_t)map_sysmem(addr, 0);
-	pages = efi_size_in_pages(size + (efi_addr & EFI_PAGE_MASK));
-	efi_addr &= ~EFI_PAGE_MASK;
-
-	status = efi_add_memory_map_pg(efi_addr, pages,
-				       op == LMB_MAP_OP_RESERVE ?
-				       EFI_BOOT_SERVICES_DATA :
-				       EFI_CONVENTIONAL_MEMORY,
-				       false);
-	if (status != EFI_SUCCESS) {
-		log_err("%s: LMB Map notify failure %lu\n", __func__,
-			status & ~EFI_ERROR_MASK);
-		return -1;
-	}
-	unmap_sysmem((void *)(uintptr_t)efi_addr);
+	if (CONFIG_IS_ENABLED(EFI_LOADER) &&
+	    !lmb.test && !(flags & LMB_NONOTIFY))
+		return efi_map_update_notify(addr, size, op);
 
 	return 0;
 }
-- 
2.47.1

