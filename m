Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 508B9F30283
	for <u-boot@archiver.kernel.org>; Sun, 15 Mar 2026 23:59:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB84D844C5;
	Mon, 16 Mar 2026 00:58:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="rfngnUJH";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Nf6DGDiy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43C97844C7; Mon, 16 Mar 2026 00:58:59 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 210628447E
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 00:58:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4fYwDJ5fWWz9sxL;
 Mon, 16 Mar 2026 00:58:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1773619136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=fk27869pGbCjkbYuY4fX01pjdYqXTbX8ZhnB7DADP8Q=;
 b=rfngnUJHCnk10N2S4QFlUY+kfy0d1DSlUAR93CafAATBSjuLPddKZVgqUTSAXQDnnleNQx
 3QttO80PvyfXUIlb+n/r5PsTQKr0uCWdDIjL6mJR2SGG/UiU7AZgOER592wlR++rUKTiQ5
 n+K2oZJeh6loyNcOq3gj4JI1fhi9FkWweMSKe/eM6gq5lzcZtTB6cEZ/Cr/2/RHfdQAvYB
 S39z0lj5ixB90p11Mc4DSqapVc8SXGXp6of2VqL9R5QVB+qJekxXgm7DN+KhhocHWV2PQa
 T1dXt4Pej8psGuOAdU5E9HUulkVfVnwpn/o5WwJbbBtHc4vNAonf02lDSnvWwQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=Nf6DGDiy;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1773619135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=fk27869pGbCjkbYuY4fX01pjdYqXTbX8ZhnB7DADP8Q=;
 b=Nf6DGDiy5l/URyB4F3GqEnanPdQMnFMSWsz9CgMFyAfkdXhAl7nbKh+1wK8UMMFl4dJ/ty
 WF2s3mgyh4EhslRD4JX0HGbxo3Xowy8PJisFraPT4pWtA2iiBL7dHVMluY9SHkRHj6WqRr
 p/atD75DjHV14MCjPaNp4aRJjvpKiAJFdhpbVPFaYQEFhv8iWwANvtS0e81qKYbfDIGpTp
 n0p7rH1GXb8AnDiJokgWXS0XEFc5qPB/y3BvWXHKOYcbRmkkhyM1ua7TyOBPKuGX7u0WSQ
 xegJWAS+dUUtUJ318BTo0T9TVoPDErqbADsqpSymTpzd1yu8w5DqwdTJJu/0Yw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Padmarao Begari <padmarao.begari@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] ufs: Remap CPU to bus addresses using dev_phys_to_bus()
Date: Mon, 16 Mar 2026 00:58:26 +0100
Message-ID: <20260315235850.305039-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 31bef70d030e9d0dc79
X-MBO-RS-META: 9rnyt95o9rmkyoansnnesbcs69wdiiht
X-Rspamd-Queue-Id: 4fYwDJ5fWWz9sxL
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

Use dev_phys_to_bus() to convert CPU addresses of DMA descriptors
into bus addresses of DMA descriptors. This is necessary on hardware
which does not have 1:1 mapping between CPU and memory addressed by
the DMA. This has no impact on other hardware which does not need
this conversion.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Neha Malcom Francis <n-francis@ti.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Padmarao Begari <padmarao.begari@amd.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/ufs/ufs-uclass.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
index 7a80a9d5664..5374ea68bd6 100644
--- a/drivers/ufs/ufs-uclass.c
+++ b/drivers/ufs/ufs-uclass.c
@@ -19,6 +19,7 @@
 #include <dm/device-internal.h>
 #include <malloc.h>
 #include <hexdump.h>
+#include <phys2bus.h>
 #include <scsi.h>
 #include <ufs.h>
 #include <asm/io.h>
@@ -471,13 +472,13 @@ static int ufshcd_make_hba_operational(struct ufs_hba *hba)
 	ufshcd_disable_intr_aggr(hba);
 
 	/* Configure UTRL and UTMRL base address registers */
-	ufshcd_writel(hba, lower_32_bits((dma_addr_t)hba->utrdl),
+	ufshcd_writel(hba, lower_32_bits(dev_phys_to_bus(hba->dev, (phys_addr_t)(uintptr_t)(hba->utrdl))),
 		      REG_UTP_TRANSFER_REQ_LIST_BASE_L);
-	ufshcd_writel(hba, upper_32_bits((dma_addr_t)hba->utrdl),
+	ufshcd_writel(hba, upper_32_bits(dev_phys_to_bus(hba->dev, (phys_addr_t)(uintptr_t)(hba->utrdl))),
 		      REG_UTP_TRANSFER_REQ_LIST_BASE_H);
-	ufshcd_writel(hba, lower_32_bits((dma_addr_t)hba->utmrdl),
+	ufshcd_writel(hba, lower_32_bits(dev_phys_to_bus(hba->dev, (phys_addr_t)(uintptr_t)(hba->utmrdl))),
 		      REG_UTP_TASK_REQ_LIST_BASE_L);
-	ufshcd_writel(hba, upper_32_bits((dma_addr_t)hba->utmrdl),
+	ufshcd_writel(hba, upper_32_bits(dev_phys_to_bus(hba->dev, (phys_addr_t)(uintptr_t)(hba->utmrdl))),
 		      REG_UTP_TASK_REQ_LIST_BASE_H);
 
 	/*
@@ -652,7 +653,7 @@ static void ufshcd_host_memory_configure(struct ufs_hba *hba)
 	u16 prdt_offset;
 
 	utrdlp = hba->utrdl;
-	cmd_desc_dma_addr = (dma_addr_t)hba->ucdl;
+	cmd_desc_dma_addr = dev_phys_to_bus(hba->dev, (phys_addr_t)(uintptr_t)(hba->ucdl));
 
 	utrdlp->command_desc_base_addr_lo =
 				cpu_to_le32(lower_32_bits(cmd_desc_dma_addr));
@@ -1604,12 +1605,15 @@ void ufshcd_prepare_utp_scsi_cmd_upiu(struct ufs_hba *hba,
 	ufshcd_cache_flush(hba->ucd_rsp_ptr, sizeof(*hba->ucd_rsp_ptr));
 }
 
-static inline void prepare_prdt_desc(struct ufshcd_sg_entry *entry,
+static inline void prepare_prdt_desc(struct ufs_hba *hba,
+				     struct ufshcd_sg_entry *entry,
 				     unsigned char *buf, ulong len)
 {
+	dma_addr_t da = dev_phys_to_bus(hba->dev, (phys_addr_t)(uintptr_t)buf);
+
 	entry->size = cpu_to_le32(len) | GENMASK(1, 0);
-	entry->base_addr = cpu_to_le32(lower_32_bits((unsigned long)buf));
-	entry->upper_addr = cpu_to_le32(upper_32_bits((unsigned long)buf));
+	entry->base_addr = cpu_to_le32(lower_32_bits(da));
+	entry->upper_addr = cpu_to_le32(upper_32_bits(da));
 }
 
 static void prepare_prdt_table(struct ufs_hba *hba, struct scsi_cmd *pccb)
@@ -1631,13 +1635,13 @@ static void prepare_prdt_table(struct ufs_hba *hba, struct scsi_cmd *pccb)
 	buf = pccb->pdata;
 	i = table_length;
 	while (--i) {
-		prepare_prdt_desc(&prd_table[table_length - i - 1], buf,
+		prepare_prdt_desc(hba, &prd_table[table_length - i - 1], buf,
 				  MAX_PRDT_ENTRY - 1);
 		buf += MAX_PRDT_ENTRY;
 		datalen -= MAX_PRDT_ENTRY;
 	}
 
-	prepare_prdt_desc(&prd_table[table_length - i - 1], buf, datalen - 1);
+	prepare_prdt_desc(hba, &prd_table[table_length - i - 1], buf, datalen - 1);
 
 	req_desc->prd_table_length = table_length;
 	ufshcd_cache_flush(prd_table, sizeof(*prd_table) * table_length);
-- 
2.51.0

