Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A3BEC001E0
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 15:07:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3543186A0C;
	Wed, 16 Aug 2023 17:06:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ggXl1Dl5";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Y+ThPeTF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE96D868B6; Wed, 16 Aug 2023 17:06:30 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9024E869E0
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
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4RQs0f2P9Zz9tDL;
 Wed, 16 Aug 2023 17:06:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692198386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+qnDS8yauVKC3TWdma1BbpkwdpYqDQ/Qe0gWdM4fxpU=;
 b=ggXl1Dl5RsiFMUE9IWOiHGQdEDcJ10Db+Q9nd6YVq73Qhbu8Y/XqMajwcihzzshUlBsSB8
 36rJ3qT5H6W6pvw2yX4L36c/kQAVC4AFabqMOzjTF/NjCfny9MDB8BC+Gb9htM++w+1UqV
 DTH83yC1tvIJK/oZ+DSVqDGhkyCzr4AKhMTt9Qpm+zTHp6LbUbQb2X0hyCVrgPUlzTvnMt
 Cuz5telklDlIsOMx3vMNSWtGLVebSWqCmRV3WOHpfSN2cgmxSD9AM9psTOQJznGM+AOcnr
 FvhG7p6kxzYqiwLo1IhjKyLS/ffrN/czwOxtsTcA6KfrRP2grgmoBVHWFEFZ7Q==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692198383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+qnDS8yauVKC3TWdma1BbpkwdpYqDQ/Qe0gWdM4fxpU=;
 b=Y+ThPeTFgOalbtZZJq6ySZkhFPcHRQ+qPBTARo5IgCnyGO05HXfnTT/cPZ68t1NXBgualm
 vrp/jzxc4cmzO+u3hDf1j64mfn5RW/mqfLMtU029eJyqeZTh8sUNHmMvHW02ujQpJL65jj
 HxCK2fbNdZ3kYZPxhuTATLDe9E+Okmexobxct5l15ZCQ3Qr7r+4OqNxs/2job3SDbp7K2x
 zJu27VTuBbbJAi6SQSKqI3lLGtMEd44DDFS/B5OQLDjG23Y5D83HR52KAG6ZMc8iiau6Do
 ZjaXODV4Lf9PBpI4Ghjin+t6khxZOP7141qJi6UWttx3xwndPxZSDvgsHnxapw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bhupesh Sharma <bhupesh.sharma@linaro.org>, Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH v2 2/7] ufs: Add UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS
Date: Wed, 16 Aug 2023 17:05:50 +0200
Message-Id: <20230816150555.245028-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230816150555.245028-1-marek.vasut+renesas@mailbox.org>
References: <20230816150555.245028-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 690e3a882a977362304
X-MBO-RS-META: mjpko4n4z47ry59bm4gug58ki9cdzrea
X-Rspamd-Queue-Id: 4RQs0f2P9Zz9tDL
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

Add UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS for host controllers which do not
support 64-bit addressing.

Ported from Linux kernel commit
6554400d6f66 ("scsi: ufs: core: Add UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS")
with ufs_scsi_buffer_aligned() based on U-Boot generic bounce buffer.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc: Faiz Abbas <faiz_abbas@ti.com>
---
V2: Use BIT() macro
---
 drivers/ufs/ufs.c | 26 ++++++++++++++++++++++++++
 drivers/ufs/ufs.h |  6 ++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
index 3bf1a95e7f2..da0550d98c6 100644
--- a/drivers/ufs/ufs.c
+++ b/drivers/ufs/ufs.c
@@ -8,6 +8,7 @@
  * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com
  */
 
+#include <bouncebuf.h>
 #include <charset.h>
 #include <common.h>
 #include <dm.h>
@@ -1889,6 +1890,8 @@ int ufshcd_probe(struct udevice *ufs_dev, struct ufs_hba_ops *hba_ops)
 
 	/* Read capabilties registers */
 	hba->capabilities = ufshcd_readl(hba, REG_CONTROLLER_CAPABILITIES);
+	if (hba->quirks & UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS)
+		hba->capabilities &= ~MASK_64_ADDRESSING_SUPPORT;
 
 	/* Get UFS version supported by the controller */
 	hba->version = ufshcd_get_ufs_version(hba);
@@ -1942,8 +1945,31 @@ int ufs_scsi_bind(struct udevice *ufs_dev, struct udevice **scsi_devp)
 	return ret;
 }
 
+#if IS_ENABLED(CONFIG_BOUNCE_BUFFER)
+static int ufs_scsi_buffer_aligned(struct udevice *scsi_dev, struct bounce_buffer *state)
+{
+#ifdef CONFIG_PHYS_64BIT
+	struct ufs_hba *hba = dev_get_uclass_priv(scsi_dev->parent);
+	uintptr_t ubuf = (uintptr_t)state->user_buffer;
+	size_t len = state->len_aligned;
+
+	/* Check if below 32bit boundary */
+	if ((hba->quirks & UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS) &&
+	    ((ubuf >> 32) || (ubuf + len) >> 32)) {
+		dev_dbg(scsi_dev, "Buffer above 32bit boundary %lx-%lx\n",
+			ubuf, ubuf + len);
+		return 0;
+	}
+#endif
+	return 1;
+}
+#endif	/* CONFIG_BOUNCE_BUFFER */
+
 static struct scsi_ops ufs_ops = {
 	.exec		= ufs_scsi_exec,
+#if IS_ENABLED(CONFIG_BOUNCE_BUFFER)
+	.buffer_aligned	= ufs_scsi_buffer_aligned,
+#endif	/* CONFIG_BOUNCE_BUFFER */
 };
 
 int ufs_probe_dev(int index)
diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
index 5a5c13aefdf..e5ddb6f64a9 100644
--- a/drivers/ufs/ufs.h
+++ b/drivers/ufs/ufs.h
@@ -719,6 +719,12 @@ struct ufs_hba {
  */
 #define UFSHCD_QUIRK_BROKEN_LCC				BIT(0)
 
+/*
+ * This quirk needs to be enabled if the host controller has
+ * 64-bit addressing supported capability but it doesn't work.
+ */
+#define UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS		BIT(1)
+
 	/* Virtual memory reference */
 	struct utp_transfer_cmd_desc *ucdl;
 	struct utp_transfer_req_desc *utrdl;
-- 
2.40.1

