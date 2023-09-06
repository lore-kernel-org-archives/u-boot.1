Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A4C2EE14D0
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 21:33:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC68A86A3C;
	Wed,  6 Sep 2023 23:30:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="mSs2VXbB";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="B3q1kEY3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82CCB86A24; Wed,  6 Sep 2023 23:30:53 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1C4986963
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 23:30:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4RgwXV3bPvz9sjN;
 Wed,  6 Sep 2023 23:30:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bplSA57tqql5dFfTEUR3cu2y+vV7myXYRWQWwTLcb8Q=;
 b=mSs2VXbBn4R0aLzdhyFxiGr5y52kbgvSWh9rEGsEI4DdjrPaA0LQvj7gU6F4GSycq10dF4
 Of3NV56gvf1qVJ7cC6s+dTFsPJ5Xjde9tTpUqh6NKRgJp9q2FtZA4u4NUPMY8NhueuYjcv
 TtduxYBYu0O843899aWe8N5RH7LmbCZLDLJC0CZhfUg2WDFM5uNnLDZ0t1PcMLK5ll7uQL
 5JCdVvjufzs6di2U/ndtGa5fWjE1DKEOGn1SndbRRQtllPI78VDC833/yIIZ1A1Tj9A98n
 v6Muf3GVdraxbES2EBRlJRcSPe1yJlk/J/uoZlCYu8pi0LBijX5WItNEY+fQhg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bplSA57tqql5dFfTEUR3cu2y+vV7myXYRWQWwTLcb8Q=;
 b=B3q1kEY3+NSP7Qs+uC11icsFI4OEiytMRGsJ7/j41Mkl/XulRyFmWMjr16AAoziK4K66zz
 fcSHw6VvfLuf0885c0+iaelqTjOJ6drU1cjVtdfiti18DfBLiBru0KILOoRVBOk01HIhS1
 RPiotdk+IMC2mvYT9YTgpS+O3oIbAbuhWHY05fFQFHo77jZroJHZfXy1rSbpuCmIa3Y2yC
 +E85Z0yzk0INeVaPDNXT5/TMBCfMQYn+7waSNd/drFwoVINOTeyzCid1MpVj5ElvTWtjnI
 1t7jB67+0jMjzXRb/Kv0jyMdlsFCuecBXsRb09JtxWFqhICyKnLpxIwhgksBeg==
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 16/35] dm: Remove unused NEEDS_MANUAL_RELOC code bits
Date: Wed,  6 Sep 2023 23:29:56 +0200
Message-Id: <20230906213015.203437-17-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
References: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: eeb5246d442914f5ffe
X-MBO-RS-META: kkz6a84qbg7knfi6at7puekttuf7jkwc
X-Rspamd-Queue-Id: 4RgwXV3bPvz9sjN
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

The last user of the NEEDS_MANUAL_RELOC has been removed in commit
26af162ac8f8 ("arch: m68k: Implement relocation")
Remove now unused NEEDS_MANUAL_RELOC code.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/core/root.c | 81 ---------------------------------------------
 1 file changed, 81 deletions(-)

diff --git a/drivers/core/root.c b/drivers/core/root.c
index 79d871ab291..47b1320a441 100644
--- a/drivers/core/root.c
+++ b/drivers/core/root.c
@@ -55,81 +55,6 @@ void dm_fixup_for_gd_move(struct global_data *new_gd)
 	}
 }
 
-void fix_drivers(void)
-{
-	struct driver *drv =
-		ll_entry_start(struct driver, driver);
-	const int n_ents = ll_entry_count(struct driver, driver);
-	struct driver *entry;
-
-	for (entry = drv; entry != drv + n_ents; entry++) {
-		if (entry->of_match)
-			entry->of_match = (const struct udevice_id *)
-				((ulong)entry->of_match + gd->reloc_off);
-		if (entry->bind)
-			entry->bind += gd->reloc_off;
-		if (entry->probe)
-			entry->probe += gd->reloc_off;
-		if (entry->remove)
-			entry->remove += gd->reloc_off;
-		if (entry->unbind)
-			entry->unbind += gd->reloc_off;
-		if (entry->of_to_plat)
-			entry->of_to_plat += gd->reloc_off;
-		if (entry->child_post_bind)
-			entry->child_post_bind += gd->reloc_off;
-		if (entry->child_pre_probe)
-			entry->child_pre_probe += gd->reloc_off;
-		if (entry->child_post_remove)
-			entry->child_post_remove += gd->reloc_off;
-		/* OPS are fixed in every uclass post_probe function */
-		if (entry->ops)
-			entry->ops += gd->reloc_off;
-	}
-}
-
-void fix_uclass(void)
-{
-	struct uclass_driver *uclass =
-		ll_entry_start(struct uclass_driver, uclass_driver);
-	const int n_ents = ll_entry_count(struct uclass_driver, uclass_driver);
-	struct uclass_driver *entry;
-
-	for (entry = uclass; entry != uclass + n_ents; entry++) {
-		if (entry->post_bind)
-			entry->post_bind += gd->reloc_off;
-		if (entry->pre_unbind)
-			entry->pre_unbind += gd->reloc_off;
-		if (entry->pre_probe)
-			entry->pre_probe += gd->reloc_off;
-		if (entry->post_probe)
-			entry->post_probe += gd->reloc_off;
-		if (entry->pre_remove)
-			entry->pre_remove += gd->reloc_off;
-		if (entry->child_post_bind)
-			entry->child_post_bind += gd->reloc_off;
-		if (entry->child_pre_probe)
-			entry->child_pre_probe += gd->reloc_off;
-		if (entry->init)
-			entry->init += gd->reloc_off;
-		if (entry->destroy)
-			entry->destroy += gd->reloc_off;
-	}
-}
-
-void fix_devices(void)
-{
-	struct driver_info *dev =
-		ll_entry_start(struct driver_info, driver_info);
-	const int n_ents = ll_entry_count(struct driver_info, driver_info);
-	struct driver_info *entry;
-
-	for (entry = dev; entry != dev + n_ents; entry++) {
-		if (entry->plat)
-			entry->plat += gd->reloc_off;
-	}
-}
-
 static int dm_setup_inst(void)
 {
 	DM_ROOT_NON_CONST = DM_DEVICE_GET(root);
@@ -181,12 +106,6 @@ int dm_init(bool of_live)
 		INIT_LIST_HEAD(DM_UCLASS_ROOT_NON_CONST);
 	}
 
-	if (IS_ENABLED(CONFIG_NEEDS_MANUAL_RELOC)) {
-		fix_drivers();
-		fix_uclass();
-		fix_devices();
-	}
-
 	if (CONFIG_IS_ENABLED(OF_PLATDATA_INST)) {
 		ret = dm_setup_inst();
 		if (ret) {
-- 
2.40.1

