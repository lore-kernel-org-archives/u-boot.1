Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27987C35FF6
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 08:49:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8139988D5C;
	Tue, 17 Sep 2024 10:49:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="qnYi2w8c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B9B388D3D; Tue, 17 Sep 2024 10:49:40 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 542A788D5C
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 10:49:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-106-243.46.114.pool.telefonica.de
 [46.114.106.243])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id ADB8B3F84A; 
 Tue, 17 Sep 2024 08:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1726562977;
 bh=FPePV3CNXw551W5HpmNgEfnBq4xALSwW/1qOmV73iU0=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=qnYi2w8c8a1bDe4a30bfpQdkIxxVoN9blgApr0WdIMNPy/JSUt5hLAK45HzgTaYMc
 wGgk3aAx+al3NuRqpFQfYDyznERy8Jmr53n913q5rw59DIwmRoDBa0MxSotRPUOLed
 Ooj/ZH4J21r102ZOPsy+d9p1nsMNoe2cM6Sn2xMgapgrddqVc1SZoSJzmEGyCOj4ji
 CGrXiiZinWg/O+jq+xM0qvL2CuV3rFkFbXijpWoNVpobbxDqDwUA9bUbQ/fRGiKJJD
 E5xBgOkOJsqBl0Epm+eIHt1HOEg1JiCLGoeglymqRdONJxevZ7gDxkWViXYcUsaU6q
 YDwJFWMTCu4gg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/1] efi_leader: delete rng-seed if having EFI RNG protocol
Date: Tue, 17 Sep 2024 10:49:29 +0200
Message-ID: <20240917084929.41888-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

For measured be boot we must avoid any volatile values in the device-tree.
We already delete /chosen/kaslr-seed if we provide and EFI RNG protocol.

Additionally remove /chosen/rng-seed provided by QEMU or U-Boot.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	Use an index instead of a position pointer for better readability
---
 include/efi_loader.h          |  2 +-
 lib/efi_loader/efi_dt_fixup.c | 15 ++++++++++-----
 lib/efi_loader/efi_helper.c   |  2 +-
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index f84852e384f..511281e150e 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -567,7 +567,7 @@ efi_status_t EFIAPI efi_convert_pointer(efi_uintn_t debug_disposition,
 /* Carve out DT reserved memory ranges */
 void efi_carve_out_dt_rsv(void *fdt);
 /* Purge unused kaslr-seed */
-void efi_try_purge_kaslr_seed(void *fdt);
+void efi_try_purge_rng_seed(void *fdt);
 /* Called by bootefi to make console interface available */
 efi_status_t efi_console_register(void);
 /* Called by efi_init_obj_list() to proble all block devices */
diff --git a/lib/efi_loader/efi_dt_fixup.c b/lib/efi_loader/efi_dt_fixup.c
index 9d017804eea..0dac94b0c6c 100644
--- a/lib/efi_loader/efi_dt_fixup.c
+++ b/lib/efi_loader/efi_dt_fixup.c
@@ -41,7 +41,7 @@ static void efi_reserve_memory(u64 addr, u64 size, bool nomap)
 }
 
 /**
- * efi_try_purge_kaslr_seed() - Remove unused kaslr-seed
+ * efi_try_purge_rng_seed() - Remove unused kaslr-seed, rng-seed
  *
  * Kernel's EFI STUB only relies on EFI_RNG_PROTOCOL for randomization
  * and completely ignores the kaslr-seed for its own randomness needs
@@ -51,8 +51,9 @@ static void efi_reserve_memory(u64 addr, u64 size, bool nomap)
  *
  * @fdt: Pointer to device tree
  */
-void efi_try_purge_kaslr_seed(void *fdt)
+void efi_try_purge_rng_seed(void *fdt)
 {
+	const char * const prop[] = {"kaslr-seed", "rng-seed"};
 	const efi_guid_t efi_guid_rng_protocol = EFI_RNG_PROTOCOL_GUID;
 	struct efi_handler *handler;
 	efi_status_t ret;
@@ -67,9 +68,13 @@ void efi_try_purge_kaslr_seed(void *fdt)
 	if (nodeoff < 0)
 		return;
 
-	err = fdt_delprop(fdt, nodeoff, "kaslr-seed");
-	if (err < 0 && err != -FDT_ERR_NOTFOUND)
-		log_err("Error deleting kaslr-seed\n");
+	for (size_t i = 0; i < ARRAY_SIZE(prop); ++i) {
+		err = fdt_delprop(fdt, nodeoff, prop[i]);
+		if (err < 0 && err != -FDT_ERR_NOTFOUND)
+			log_err("Error deleting %s\n", prop[i]);
+		else
+			log_debug("Deleted /chosen/%s\n", prop[i]);
+	}
 }
 
 /**
diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
index 96f847652ec..a481eb4b7e3 100644
--- a/lib/efi_loader/efi_helper.c
+++ b/lib/efi_loader/efi_helper.c
@@ -522,7 +522,7 @@ efi_status_t efi_install_fdt(void *fdt)
 	/* Create memory reservations as indicated by the device tree */
 	efi_carve_out_dt_rsv(fdt);
 
-	efi_try_purge_kaslr_seed(fdt);
+	efi_try_purge_rng_seed(fdt);
 
 	if (CONFIG_IS_ENABLED(EFI_TCG2_PROTOCOL_MEASURE_DTB)) {
 		ret = efi_tcg2_measure_dtb(fdt);
-- 
2.45.2

