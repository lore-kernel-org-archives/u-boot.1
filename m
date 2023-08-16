Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE57C001E0
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 15:06:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C33386A03;
	Wed, 16 Aug 2023 17:06:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="E0Efv3sr";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="uLRP5zCC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83BEA86A01; Wed, 16 Aug 2023 17:06:30 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1817F869E9
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 17:06:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4RQs0g0BxXz9sRt;
 Wed, 16 Aug 2023 17:06:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692198387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OOQGN18DkO78JYDEORjSM1+iL+5cPN4vINmOJxpQUnI=;
 b=E0Efv3srUAmmmsyU5ruEAyXhxyf5X7XOVYVStiQ988UpXbYYiOByTO4Nd/Yw2yfDGAgLZq
 18Bcr7dWMjkC9CkHPDT7Vee5AJdjdm56aLiCgMsWmNroIRd2oO+eRjOkW11vtN2XFfes27
 mHD8Kl9+cTQ/Ig46WUZx5yiLKSaxGeJPUdVBpFVqjJbOWfi5SkKALERVkuPry5g6LussQS
 gVHdAl5wXyDObt+kgmmu8CTzW2vVsNYraN+iv7cvvXgXGoucg/3qAE7f3GZihWxWPIldZ5
 qGXcecC7DgrLPECSktfMUq+GwvRFfiqRlEFmcO+LxfoTKhxg6dVHyw5Qn2zBXg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692198384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OOQGN18DkO78JYDEORjSM1+iL+5cPN4vINmOJxpQUnI=;
 b=uLRP5zCChHwFJkCMB5n0/lQIVrFILtE9U60+ncZuOLWYi9hfrEOtmv1LK0RX3Up1b8NkLZ
 DSeDHLrf899ow2QW4g1qdPMjHVXEtLHO8YyEb8QCAyyDO6Lac46Yxlzd8+I/BDF8Z2cas8
 tvUaC0WTCM+dWh7c/9ptgA/XaD/gE6hixLqv82X1fvFV9I5TskreP1uSe/Of8daLkVPs5e
 W5Pi7/OpkPPrg+bxWoWPKaW27fpxKWvAb8CUMyg4xLMhxPhCeMXI26NeQWEGicmhp+zI/m
 m3oqH4QqGgEsu64CUgyCwMO1Kg+gNG8NhJXZHJsg518L/PPRMNF4bWvEjMWDIQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bhupesh Sharma <bhupesh.sharma@linaro.org>, Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH v2 4/7] ufs: Handle UFS 3.0 controllers
Date: Wed, 16 Aug 2023 17:05:52 +0200
Message-Id: <20230816150555.245028-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230816150555.245028-1-marek.vasut+renesas@mailbox.org>
References: <20230816150555.245028-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 656c519ed008d75076c
X-MBO-RS-META: e6ioc1u7wgwzbn65isju4pbmundawgqd
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

Extend the version check to handle UFS 3.0 controllers as well.
Tested on R-Car S4 UFS 3.0 controller.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc: Faiz Abbas <faiz_abbas@ti.com>
---
V2: No change
---
 drivers/ufs/ufs.c | 3 ++-
 drivers/ufs/ufs.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
index 261ae2843c2..58830c8ddca 100644
--- a/drivers/ufs/ufs.c
+++ b/drivers/ufs/ufs.c
@@ -1903,7 +1903,8 @@ int ufshcd_probe(struct udevice *ufs_dev, struct ufs_hba_ops *hba_ops)
 	if (hba->version != UFSHCI_VERSION_10 &&
 	    hba->version != UFSHCI_VERSION_11 &&
 	    hba->version != UFSHCI_VERSION_20 &&
-	    hba->version != UFSHCI_VERSION_21)
+	    hba->version != UFSHCI_VERSION_21 &&
+	    hba->version != UFSHCI_VERSION_30)
 		dev_err(hba->dev, "invalid UFS version 0x%x\n",
 			hba->version);
 
diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
index 638c10b5503..9daaf03d222 100644
--- a/drivers/ufs/ufs.h
+++ b/drivers/ufs/ufs.h
@@ -781,6 +781,7 @@ enum {
 	UFSHCI_VERSION_11 = 0x00010100, /* 1.1 */
 	UFSHCI_VERSION_20 = 0x00000200, /* 2.0 */
 	UFSHCI_VERSION_21 = 0x00000210, /* 2.1 */
+	UFSHCI_VERSION_30 = 0x00000300, /* 3.0 */
 };
 
 /* Interrupt disable masks */
-- 
2.40.1

