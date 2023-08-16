Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E4D5C04A6A
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 15:06:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54ABD869E5;
	Wed, 16 Aug 2023 17:06:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="w/1qerVV";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="VWgpUAig";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 084D4869F3; Wed, 16 Aug 2023 17:06:29 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8360C868D8
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 17:06:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4RQs0f3JFKz9sQj;
 Wed, 16 Aug 2023 17:06:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692198386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6dXQLx9RLZoDkMUPkl2fwH+BGqhobiBqjdp4a+QZcik=;
 b=w/1qerVVReTABKYTCnrAl/Y9fCv7rd6+JxkGkfq23htJ67GBFd4yEfgiEbXSPdX6AARczV
 jrCn0BpZjdgFmgRGCLtmVMn8ZCYB09O6m6KA1rKYq5sjWhKScBIsZBC8mhbmuvec2nmAcn
 f2dEHlQnGoY8AQ2LZxn6ZkhajP54Hn3FkNuO1MLfZaQSPS5rhdP8JolYdypWWLnvkoMAT7
 hX5ePpmAEbONqi0VNK0660qGZx9sOWoMvP/8UlFScqv/mqt6xjChxNhSsWv0ePD6CcVB4Y
 c6B4rptrm4FsWccmJJyA3Ud9HNOgl0MORPA1NS62OWTJXE2CZZ7rWazBAbdx6A==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692198383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6dXQLx9RLZoDkMUPkl2fwH+BGqhobiBqjdp4a+QZcik=;
 b=VWgpUAigpZTWAlLAnU+DvA8zQNV/Mhk2L1GpG510/t0kJAWF16UrSI+puzxN+OBvGkstN4
 OFdG1/s/uG3s6CQE8/x1Jx6g6tyMRgupY12cVg5QjUE6WUtW+YZTBAR8JlROSt58l66imh
 BoiFtY+mq4LNvcsATc4P2OEcT8j46Sgeyz/tR0nCNtvAHbtVwbZ2EomTYSb1w3CqA8Pntd
 nPPYyYAplSrn+/fj+YOortgPl0wXk0tKJy6QUWdm1/U09YKaPAAYi3P781gXiGruH1jMf+
 W6T6Guw2gCKEFN7rH+phRQXnlYnsVK9X21XAiYRskTsuCLNL6vHc4t3htMw0HQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bhupesh Sharma <bhupesh.sharma@linaro.org>, Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH v2 3/7] ufs: Add UFSHCD_QUIRK_HIBERN_FASTAUTO
Date: Wed, 16 Aug 2023 17:05:51 +0200
Message-Id: <20230816150555.245028-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230816150555.245028-1-marek.vasut+renesas@mailbox.org>
References: <20230816150555.245028-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 3182eac62d023601f44
X-MBO-RS-META: 3jhu6fgq1ttnbig8y45ksfrmaxw14rep
X-Rspamd-Queue-Id: 4RQs0f3JFKz9sQj
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

Add UFSHCD_QUIRK_HIBERN_FASTAUTO quirk for host controllers which supports
auto-hibernate the capability but only FASTAUTO mode.

Ported from Linux kernel commit
2f11bbc2c7f3 ("scsi: ufs: core: Add UFSHCD_QUIRK_HIBERN_FASTAUTO")

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc: Faiz Abbas <faiz_abbas@ti.com>
---
V2: Use BIT() macro
---
 drivers/ufs/ufs.c | 9 +++++++--
 drivers/ufs/ufs.h | 6 ++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
index da0550d98c6..261ae2843c2 100644
--- a/drivers/ufs/ufs.c
+++ b/drivers/ufs/ufs.c
@@ -1631,8 +1631,13 @@ static int ufshcd_get_max_pwr_mode(struct ufs_hba *hba)
 	if (hba->max_pwr_info.is_valid)
 		return 0;
 
-	pwr_info->pwr_tx = FAST_MODE;
-	pwr_info->pwr_rx = FAST_MODE;
+	if (hba->quirks & UFSHCD_QUIRK_HIBERN_FASTAUTO) {
+		pwr_info->pwr_tx = FASTAUTO_MODE;
+		pwr_info->pwr_rx = FASTAUTO_MODE;
+	} else {
+		pwr_info->pwr_tx = FAST_MODE;
+		pwr_info->pwr_rx = FAST_MODE;
+	}
 	pwr_info->hs_rate = PA_HS_MODE_B;
 
 	/* Get the connected lane count */
diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
index e5ddb6f64a9..638c10b5503 100644
--- a/drivers/ufs/ufs.h
+++ b/drivers/ufs/ufs.h
@@ -725,6 +725,12 @@ struct ufs_hba {
  */
 #define UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS		BIT(1)
 
+/*
+ * This quirk needs to be enabled if the host controller has
+ * auto-hibernate capability but it's FASTAUTO only.
+ */
+#define UFSHCD_QUIRK_HIBERN_FASTAUTO			BIT(2)
+
 	/* Virtual memory reference */
 	struct utp_transfer_cmd_desc *ucdl;
 	struct utp_transfer_req_desc *utrdl;
-- 
2.40.1

