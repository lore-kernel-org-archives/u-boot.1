Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D3D0C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 09:54:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F1308813C;
	Mon, 15 Apr 2024 11:54:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="wW98JN/0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5604B8820E; Mon, 15 Apr 2024 11:54:06 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5420B87D66
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 11:54:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=cmax@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4VJ2Z23QMSz9svt;
 Mon, 15 Apr 2024 11:54:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1713174842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9HqsTJxOi65nsvYbH6IwNBQsm+nwW1LQjC8miSiTusk=;
 b=wW98JN/0Kw4yaTY1VTspDIe1SG2odGKS40lBUzJA2jYD3boNvSOA+y9XyFv5MgrwXhY2cw
 W5fwkDNs/u02NZhhGbcxjgnAK9ndyXi2d4x7xaWFtB4MSnDf+uYrkk/EuBTwJm8xG874ea
 oppa/rroheFWNjHMxxUYaVASsPrWjRwM0c79ji+DjWjYTB/I+ZGQr4UYtG5lLuwCM9DuHU
 Md4h5ucjlnqmH9C5HFNBLfMwfENn2U1h7ChYv2VJg/DY2YS+WJTpZ/McTE0x78//1Cx9KB
 lYeD09oH+p5EfKh2jY+vZuOWTJFoj55o6jSVR+azpkaWuY6Houa/vtrG6aP3QQ==
From: cmax@mailbox.org
To: u-boot@lists.denx.de
Cc: Maximilian Brune <maximilian.brune@9elements.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH v2] mmc: arm_pl180: Limit data transfer to U16_MAX
Date: Mon, 15 Apr 2024 11:53:11 +0200
Message-ID: <20240415095324.28469-1-cmax@mailbox.org>
In-Reply-To: <20240227201857.25814-1-cmax@mailbox.org>
References: <20240227201857.25814-1-cmax@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: d3e54b82189f5be1049
X-MBO-RS-META: y84eqxhw79nbkii9kkuwu5r41ki77g3c
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
 drivers/mmc/arm_pl180_mmci.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mmc/arm_pl180_mmci.c b/drivers/mmc/arm_pl180_mmci.c
index 2666b65362..cecc7ad783 100644
--- a/drivers/mmc/arm_pl180_mmci.c
+++ b/drivers/mmc/arm_pl180_mmci.c
@@ -229,6 +229,7 @@ static int do_data_transfer(struct mmc *dev,
 	u32 blksz = 0;
 	u32 data_ctrl = 0;
 	u32 data_len = (u32) (data->blocks * data->blocksize);
+	assert(data_len < U16_MAX); /* should be ensured by arm_pl180_get_b_max */
 
 	if (!host->version2) {
 		blksz = (ffs(data->blocksize) - 1);
@@ -356,6 +357,14 @@ static int  host_set_ios(struct mmc *dev)
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
 static void arm_pl180_mmc_init(struct pl180_mmc_host *host)
 {
 	u32 sdi_u32;
@@ -470,6 +479,7 @@ static const struct dm_mmc_ops arm_pl180_dm_mmc_ops = {
 	.send_cmd = dm_host_request,
 	.set_ios = dm_host_set_ios,
 	.get_cd = dm_mmc_getcd,
+	.get_b_max = arm_pl180_get_b_max,
 };
 
 static int arm_pl180_mmc_of_to_plat(struct udevice *dev)
-- 
2.44.0

