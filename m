Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79155C021A3
	for <u-boot@archiver.kernel.org>; Sat, 14 Sep 2024 16:06:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B05BA889E2;
	Sat, 14 Sep 2024 18:06:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="eHZXLFfo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52A6388AAC; Sat, 14 Sep 2024 18:06:09 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 385E5886F3
 for <u-boot@lists.denx.de>; Sat, 14 Sep 2024 18:06:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 8636A3F1E4; 
 Sat, 14 Sep 2024 16:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1726329964;
 bh=TNrZE0Y6Aj0jmT0/YnjYNcj7LT6FYzbLRMx6fiJKEy0=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=eHZXLFfouuT7URyY/g99YlTLpbTZGPTisywNFXsVsjvZAR00c0vf0xrM0fVn0NwIg
 qWlIE+9kYNV6sU/qjMJWU48pdIJKpQW9XXHD159doRNh+utwL9nFoFtckQM1VcmJHi
 k77BR9FTR9uO0HFRS0qrTZO7ScymAIjARn7rbSMOyv2O19pksuoUig69Ljzon8ZFIU
 fpoP5dxmiUOA3C8y8w6r5CfxTaTws8aYaO3NxG05g2BgegafrAP0aKyQ3EmTfGAiWx
 33QwB2boW8CEzfqiJ9z0hnJC0+jHzT1ypduNZb97NWtzglo+ZEdXS0o6bttNTg+i85
 mSCOhRVaFGRnw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_leader: delete rng-seed if having EFI RNG protocol
Date: Sat, 14 Sep 2024 18:05:48 +0200
Message-ID: <20240914160548.42551-1-heinrich.schuchardt@canonical.com>
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
index 9d017804eea..8f9e8dbd1ec 100644
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
+	for (const char * const *pos = prop; pos < &prop[ARRAY_SIZE(prop)];
+	     ++pos) {
+		err = fdt_delprop(fdt, nodeoff, *pos);
+		if (err < 0 && err != -FDT_ERR_NOTFOUND)
+			log_err("Error deleting %s\n", *pos);
+		log_debug("Deleted /chosen/%s\n", *pos);
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

