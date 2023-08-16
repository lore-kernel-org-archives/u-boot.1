Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E42A3C04A6A
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 15:07:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E498386A04;
	Wed, 16 Aug 2023 17:06:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="x6NtgrRE";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="XFBeLOj7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B3BC869E9; Wed, 16 Aug 2023 17:06:30 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00A57807C9
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 17:06:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4RQs0g5T2Bz9sQV;
 Wed, 16 Aug 2023 17:06:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692198387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iTvlqQlJxfZzSqklwU9h15POQPTEX7gt1BRMKlzWGAA=;
 b=x6NtgrREDFUnN8wVEZf+0miFKi3GfGOv0sxZ8BiwQnj2rEcAY3D/lAN/+9OH7D8TAOeTpa
 oKzizjx12nVGxQDhU4sBFzZiIIRHIly1tjftB6LrFYp4ElMsoxUZ5ngvH+/j0J6FE6LpLG
 eQBKIQMx8PXkd87whmpkflGPm8F/bY/XVmgucwtqDVkdhcmpKZLxcjMI2REQ6gzWHqA3Rh
 2S8ISqMQSasxXaiMExPSBgO+yHpiMpRCKUQk1zwuqV0kpoiiWBZxiEeycek9p+rkItfx6H
 qFLvFmnDW/1yuPI2CdV0+imIIj0OFxHZvP1dzD7Ax//BnnQ7GWIhL8sUPPfMiA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692198385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iTvlqQlJxfZzSqklwU9h15POQPTEX7gt1BRMKlzWGAA=;
 b=XFBeLOj7LCWLewbW6ECvmUeVvugd7u4IhasQcdwTknrUtTBtL/Mw4Zn8/bu0c41v1Rgd6X
 QISFIJHV5oVoVDRSlvwcdVcP3SBEKWTfLdV9PqDhT+BsXd3JpKdF8jutfsLS13bxPshOld
 afN5NDhDdCc24YgyGFwpaRCU29Czk2AlyGXmdZRk+NbXqQNZ1wNYNq3/QiLjAxn6iEAO0b
 IWpW/YcDjk/ylvk4wijLqApNBCKQ8bTeENWk2mt9QPU45Qw0PmgWkq47TF4oNZMQ/bfG2Q
 JF5NzPXtcG2pUlMnO0uz1yM8gFWTK06o9b1PLboe4/2Rql5EJ1KMSpd3nTqqHQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bhupesh Sharma <bhupesh.sharma@linaro.org>, Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH v2 5/7] ufs: Pass hba pointer to ufshcd_prepare_req_desc_hdr()
Date: Wed, 16 Aug 2023 17:05:53 +0200
Message-Id: <20230816150555.245028-5-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230816150555.245028-1-marek.vasut+renesas@mailbox.org>
References: <20230816150555.245028-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 386fad6ca2ba9452cc4
X-MBO-RS-META: eh9qn61zjm8nsf89kyop3844hecq7n7i
X-Rspamd-Queue-Id: 4RQs0g5T2Bz9sQV
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

Pass the hba pointer itself to ufshcd_prepare_req_desc_hdr()
instead of duplicating utp_transfer_req_desc access at each
call site. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc: Faiz Abbas <faiz_abbas@ti.com>
---
V2: No change
---
 drivers/ufs/ufs.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
index 58830c8ddca..da1009e2c14 100644
--- a/drivers/ufs/ufs.c
+++ b/drivers/ufs/ufs.c
@@ -696,10 +696,11 @@ static inline u8 ufshcd_get_upmcrs(struct ufs_hba *hba)
  * ufshcd_prepare_req_desc_hdr() - Fills the requests header
  * descriptor according to request
  */
-static void ufshcd_prepare_req_desc_hdr(struct utp_transfer_req_desc *req_desc,
+static void ufshcd_prepare_req_desc_hdr(struct ufs_hba *hba,
 					u32 *upiu_flags,
 					enum dma_data_direction cmd_dir)
 {
+	struct utp_transfer_req_desc *req_desc = hba->utrdl;
 	u32 data_direction;
 	u32 dword_0;
 
@@ -793,11 +794,10 @@ static int ufshcd_comp_devman_upiu(struct ufs_hba *hba,
 {
 	u32 upiu_flags;
 	int ret = 0;
-	struct utp_transfer_req_desc *req_desc = hba->utrdl;
 
 	hba->dev_cmd.type = cmd_type;
 
-	ufshcd_prepare_req_desc_hdr(req_desc, &upiu_flags, DMA_NONE);
+	ufshcd_prepare_req_desc_hdr(hba, &upiu_flags, DMA_NONE);
 	switch (cmd_type) {
 	case DEV_CMD_TYPE_QUERY:
 		ufshcd_prepare_utp_query_req_upiu(hba, upiu_flags);
@@ -1449,12 +1449,11 @@ static void prepare_prdt_table(struct ufs_hba *hba, struct scsi_cmd *pccb)
 static int ufs_scsi_exec(struct udevice *scsi_dev, struct scsi_cmd *pccb)
 {
 	struct ufs_hba *hba = dev_get_uclass_priv(scsi_dev->parent);
-	struct utp_transfer_req_desc *req_desc = hba->utrdl;
 	u32 upiu_flags;
 	int ocs, result = 0;
 	u8 scsi_status;
 
-	ufshcd_prepare_req_desc_hdr(req_desc, &upiu_flags, pccb->dma_dir);
+	ufshcd_prepare_req_desc_hdr(hba, &upiu_flags, pccb->dma_dir);
 	ufshcd_prepare_utp_scsi_cmd_upiu(hba, pccb, upiu_flags);
 	prepare_prdt_table(hba, pccb);
 
-- 
2.40.1

