Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 922D9CD1292
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 06:59:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E28CE8815D;
	Thu,  4 Apr 2024 08:59:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="EI+3FLpV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29A2B88253; Thu,  4 Apr 2024 08:59:04 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0948A8807F
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 08:58:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=cmax@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4V9CC40BDyz9tRC;
 Thu,  4 Apr 2024 08:58:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1712213936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xV4Hfe5wc6jRsUI1nBk7gY7OvSl7POxDhopxXA0M9q0=;
 b=EI+3FLpV3NrB3imn7gzjJeeP8p7ImUpRn8Dr7WmhIo9Mt+FUcXLWivl8V42REUo1lor4LH
 L63hHsKrc1JbsVRZwy1aPMBmN/X2Z42ePQKNPL6gVzMgetTRBlnH1iqoJ8Xtqh2w4zlCVZ
 8N3LTIrB2nJpc6cFPni1hedRwGOvSPulmDtfvZeZxHyhFbf4o/doP7pMan4WAqj0V7f4Xm
 skrbp56eSAxTOjW7pNwQiHF/ogDGagAWqGrQWoQd7l/bBReaXx7feynJq3PHKbNg8e+vBm
 BUY+Jhim6IcPeLz3nZQBArxQXICFKKxQO4/vhFZlzXh457GWWlZcmQ9G+bqPYg==
From: cmax@mailbox.org
To: u-boot@lists.denx.de
Cc: Maximilian Brune <maximilian.brune@9elements.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH v2] mmc: arm_pl180: Limit data transfer to U16_MAX
Date: Thu,  4 Apr 2024 08:58:22 +0200
Message-ID: <20240404065839.9351-1-cmax@mailbox.org>
In-Reply-To: <20240227201857.25814-1-cmax@mailbox.org>
References: <20240227201857.25814-1-cmax@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: d70b245d1b6f127bc12
X-MBO-RS-META: i4gcmz76qtpfenhkziuaujjhpf63t4i4
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

From: Maximilian Brune <maximilian.brune@9elements.com>

Currently fetching files bigger that cause a data transfer greater than
U16_MAX fails.

The reason is that the specification defines the datalength register
as a 16 bit wide register, but in u-boot it is used as if it is an
32 bit register. Therefore values greater than U16_MAX cause an
infinite loop inside u-boot. U-boot expects to get more data from
interface/hardware then it will ever get and therefore inifintely waits
for more data that will never come.

Signed-off-by: Maximilian Brune <maximilian.brune@9elements.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/arm_pl180_mmci.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mmc/arm_pl180_mmci.c b/drivers/mmc/arm_pl180_mmci.c
index 5cf5502ed5..cad73ea106 100644
--- a/drivers/mmc/arm_pl180_mmci.c
+++ b/drivers/mmc/arm_pl180_mmci.c
@@ -231,6 +231,7 @@ static int do_data_transfer(struct mmc *dev,
 	u32 blksz = 0;
 	u32 data_ctrl = 0;
 	u32 data_len = (u32) (data->blocks * data->blocksize);
+	assert(data_len < U16_MAX); /* should be ensured by arm_pl180_get_b_max */
 
 	if (!host->version2) {
 		blksz = (ffs(data->blocksize) - 1);
@@ -358,6 +359,14 @@ static int  host_set_ios(struct mmc *dev)
 	return 0;
 }
 
+static int arm_pl180_get_b_max(struct udevice *dev, void *dst, lbaint_t blkcnt)
+{
+	struct mmc_uclass_priv *upriv = dev_get_uclass_priv(dev);
+	struct mmc *mmc = upriv->mmc;
+
+	return U16_MAX / mmc->read_bl_len;
+}
+
 #ifndef CONFIG_DM_MMC
 /* MMC uses open drain drivers in the enumeration phase */
 static int mmc_host_reset(struct mmc *dev)
@@ -373,6 +382,7 @@ static const struct mmc_ops arm_pl180_mmci_ops = {
 	.send_cmd = host_request,
 	.set_ios = host_set_ios,
 	.init = mmc_host_reset,
+	.get_b_max = arm_pl180_get_b_max,
 };
 
 /*
@@ -531,6 +541,7 @@ static const struct dm_mmc_ops arm_pl180_dm_mmc_ops = {
 	.send_cmd = dm_host_request,
 	.set_ios = dm_host_set_ios,
 	.get_cd = dm_mmc_getcd,
+	.get_b_max = arm_pl180_get_b_max,
 };
 
 static int arm_pl180_mmc_of_to_plat(struct udevice *dev)
-- 
2.44.0

