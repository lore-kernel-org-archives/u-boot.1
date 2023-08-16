Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24BF8C04A6A
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 15:07:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2BC586A19;
	Wed, 16 Aug 2023 17:06:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="rNAXLr+c";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="enFQyQ6k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF22086A02; Wed, 16 Aug 2023 17:06:31 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10E65868D8
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 17:06:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4RQs0h5lC7z9smM;
 Wed, 16 Aug 2023 17:06:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692198388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mSZRGnwJ9N+Gb3NWslVvUdzkwIv/iA5EyBCdjRbxzkQ=;
 b=rNAXLr+cej9k+nEVA6/PhAUK/1OTW5kc29SB4s1PNM/iExXSKeHDVxEShLlg03z+3dpzVe
 d3JaYfSMjiUvy0HHO651MBKn+W2H6ZjX7JlHMP9lx6OxNFXK3W/wOWrDy+EDgIQzurZJwZ
 dJz2aM5yTaG1OngR43vbrXkfNuQZXqj1SuHmemcCp9QiwChbsQIN8LIw4ArI8CrlNC/1mC
 4Ffedqle+HzGnkw77vkywqMK45hmQsHWzPVRITAesbonRrKzOUnp1VONmNcR3419mxNyyE
 OVHk5LyjJYErnrmsE/ySNKBlU2erte6/+OKlSNU8o5LlBMif8s3cvBXqCczdUQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692198386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mSZRGnwJ9N+Gb3NWslVvUdzkwIv/iA5EyBCdjRbxzkQ=;
 b=enFQyQ6kLtvPN0AVcAEVrOcHEI3xVVe7xv0wOMUig30i4J6ogWeQSUMxp8oDaeBPS5LXNY
 Qn4P60GuxjMe2pDiMha8ACZd89B+UCqcJuaxYk5eOy8Qw259S3msifHDmGKL4EUJQ88GRq
 RLmMx17zsPYBhU2s5h0VO7SC5dy6izTxd3EuBhuYqtdHdqWevNhTSprae/BtESn70CQ0gE
 cOYoq3ySmeHiG24t1tUxS+AIoNzAQDra7b5wZ1rhyljOY+lyOONyr64vV3dlkXHxUaSAvg
 a4PzbHKoDBJ4VLGiWwMRzRYJrOpMl+OIU/9W3/Wtp70ZYPyNf9ljc6Nx8Ik2WA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bhupesh Sharma <bhupesh.sharma@linaro.org>, Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH v2 7/7] ufs: Implement cache management
Date: Wed, 16 Aug 2023 17:05:55 +0200
Message-Id: <20230816150555.245028-7-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230816150555.245028-1-marek.vasut+renesas@mailbox.org>
References: <20230816150555.245028-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 97b634df8983d9a27eb
X-MBO-RS-META: ey4fudstesbzyattdbx9p6mq5kondfus
X-Rspamd-Queue-Id: 4RQs0h5lC7z9smM
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

Add function to flush and invalidate cache over request and response
queue entries, and perform flush and optional invalidate over block
layer data that are passed into the UFS layer. This makes it possible
to use UFS with caches enabled.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc: Faiz Abbas <faiz_abbas@ti.com>
---
V2: No change
---
 drivers/ufs/ufs.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
index 041caee714f..7c48d57f99d 100644
--- a/drivers/ufs/ufs.c
+++ b/drivers/ufs/ufs.c
@@ -692,6 +692,21 @@ static inline u8 ufshcd_get_upmcrs(struct ufs_hba *hba)
 	return (ufshcd_readl(hba, REG_CONTROLLER_STATUS) >> 8) & 0x7;
 }
 
+/**
+ * ufshcd_cache_flush_and_invalidate - Flush and invalidate cache
+ *
+ * Flush and invalidate cache in aligned address..address+size range.
+ * The invalidation is in place to avoid stale data in cache.
+ */
+static void ufshcd_cache_flush_and_invalidate(void *addr, unsigned long size)
+{
+	uintptr_t aaddr = (uintptr_t)addr & ~(ARCH_DMA_MINALIGN - 1);
+	unsigned long asize = ALIGN(size, ARCH_DMA_MINALIGN);
+
+	flush_dcache_range(aaddr, aaddr + asize);
+	invalidate_dcache_range(aaddr, aaddr + asize);
+}
+
 /**
  * ufshcd_prepare_req_desc_hdr() - Fills the requests header
  * descriptor according to request
@@ -735,6 +750,8 @@ static void ufshcd_prepare_req_desc_hdr(struct ufs_hba *hba,
 	req_desc->header.dword_3 = 0;
 
 	req_desc->prd_table_length = 0;
+
+	ufshcd_cache_flush_and_invalidate(req_desc, sizeof(*req_desc));
 }
 
 static void ufshcd_prepare_utp_query_req_upiu(struct ufs_hba *hba,
@@ -763,10 +780,15 @@ static void ufshcd_prepare_utp_query_req_upiu(struct ufs_hba *hba,
 	memcpy(&ucd_req_ptr->qr, &query->request.upiu_req, QUERY_OSF_SIZE);
 
 	/* Copy the Descriptor */
-	if (query->request.upiu_req.opcode == UPIU_QUERY_OPCODE_WRITE_DESC)
+	if (query->request.upiu_req.opcode == UPIU_QUERY_OPCODE_WRITE_DESC) {
 		memcpy(ucd_req_ptr + 1, query->descriptor, len);
+		ufshcd_cache_flush_and_invalidate(ucd_req_ptr, 2 * sizeof(*ucd_req_ptr));
+	} else {
+		ufshcd_cache_flush_and_invalidate(ucd_req_ptr, sizeof(*ucd_req_ptr));
+	}
 
 	memset(hba->ucd_rsp_ptr, 0, sizeof(struct utp_upiu_rsp));
+	ufshcd_cache_flush_and_invalidate(hba->ucd_rsp_ptr, sizeof(*hba->ucd_rsp_ptr));
 }
 
 static inline void ufshcd_prepare_utp_nop_upiu(struct ufs_hba *hba)
@@ -783,6 +805,9 @@ static inline void ufshcd_prepare_utp_nop_upiu(struct ufs_hba *hba)
 	ucd_req_ptr->header.dword_2 = 0;
 
 	memset(hba->ucd_rsp_ptr, 0, sizeof(struct utp_upiu_rsp));
+
+	ufshcd_cache_flush_and_invalidate(ucd_req_ptr, sizeof(*ucd_req_ptr));
+	ufshcd_cache_flush_and_invalidate(hba->ucd_rsp_ptr, sizeof(*hba->ucd_rsp_ptr));
 }
 
 /**
@@ -1409,6 +1434,8 @@ void ufshcd_prepare_utp_scsi_cmd_upiu(struct ufs_hba *hba,
 	memcpy(ucd_req_ptr->sc.cdb, pccb->cmd, cdb_len);
 
 	memset(hba->ucd_rsp_ptr, 0, sizeof(struct utp_upiu_rsp));
+	ufshcd_cache_flush_and_invalidate(ucd_req_ptr, sizeof(*ucd_req_ptr));
+	ufshcd_cache_flush_and_invalidate(hba->ucd_rsp_ptr, sizeof(*hba->ucd_rsp_ptr));
 }
 
 static inline void prepare_prdt_desc(struct ufshcd_sg_entry *entry,
@@ -1423,6 +1450,7 @@ static void prepare_prdt_table(struct ufs_hba *hba, struct scsi_cmd *pccb)
 {
 	struct utp_transfer_req_desc *req_desc = hba->utrdl;
 	struct ufshcd_sg_entry *prd_table = hba->ucd_prdt_ptr;
+	uintptr_t aaddr = (uintptr_t)(pccb->pdata) & ~(ARCH_DMA_MINALIGN - 1);
 	ulong datalen = pccb->datalen;
 	int table_length;
 	u8 *buf;
@@ -1430,9 +1458,19 @@ static void prepare_prdt_table(struct ufs_hba *hba, struct scsi_cmd *pccb)
 
 	if (!datalen) {
 		req_desc->prd_table_length = 0;
+		ufshcd_cache_flush_and_invalidate(req_desc, sizeof(*req_desc));
 		return;
 	}
 
+	if (pccb->dma_dir == DMA_TO_DEVICE) {	/* Write to device */
+		flush_dcache_range(aaddr, aaddr +
+				   ALIGN(datalen, ARCH_DMA_MINALIGN));
+	}
+
+	/* In any case, invalidate cache to avoid stale data in it. */
+	invalidate_dcache_range(aaddr, aaddr +
+				ALIGN(datalen, ARCH_DMA_MINALIGN));
+
 	table_length = DIV_ROUND_UP(pccb->datalen, MAX_PRDT_ENTRY);
 	buf = pccb->pdata;
 	i = table_length;
@@ -1446,6 +1484,8 @@ static void prepare_prdt_table(struct ufs_hba *hba, struct scsi_cmd *pccb)
 	prepare_prdt_desc(&prd_table[table_length - i - 1], buf, datalen - 1);
 
 	req_desc->prd_table_length = table_length;
+	ufshcd_cache_flush_and_invalidate(prd_table, sizeof(*prd_table) * table_length);
+	ufshcd_cache_flush_and_invalidate(req_desc, sizeof(*req_desc));
 }
 
 static int ufs_scsi_exec(struct udevice *scsi_dev, struct scsi_cmd *pccb)
-- 
2.40.1

