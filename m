Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CFBAC61DD3
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 09:13:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3BC7B80C68;
	Tue,  1 Sep 2026 09:13:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XYAMZOhqsuGZ; Tue,  1 Sep 2026 09:13:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788254001;
	bh=8mOCIbk/I5CIl9g67uqa+pZQve8xcPlyA/m52raZLnY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Xg86tdDZkZZGPe9M5cu8LxllG+vXZ2E3wPTBGayyAie/Em+M08BvT0n6X9j90qkeK
	 uw87VixE00usWa9tc8cz39fNb1IcyzFQB68kteS/skUhpawxBRLJSA63+7ReULdIpT
	 8cox+Y6UCJy4J/rU3LiAkiGg2rKRRiR97qxmBVgIh/TC2buRG91bKpJURD3WssZTkX
	 rx4tnH0WWNjrFJ5rlvXyeL8A6jlu/m7daXoXxvpHxxKE1l46L5LCcRVh879SDzhSZw
	 aF4XKEWAUSiwvZPTRobVo0sgOStV7keZQNxTKy0tZRQ4/H4RbwNDbExcCGmqd5BFtq
	 T0txX/r4cp8Ig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A0BFF80BFF;
	Tue,  1 Sep 2026 09:13:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 237AE1D9
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 09:13:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 06F1B80BFF
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 09:13:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XXJKwZa2Kns0 for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 09:13:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=linusw@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=kzANJ+R/
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1372480BCC
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 09:13:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A1D7E60209;
 Tue,  1 Sep 2026 09:13:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A296E1F000E9;
 Tue,  1 Sep 2026 09:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788253997;
 bh=8mOCIbk/I5CIl9g67uqa+pZQve8xcPlyA/m52raZLnY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=kzANJ+R/SSJCTX4G/vnC5FMtRhKrWJBi8PAt52jivf8X/+JQLuSLPQ4JvqGm+0VMj
 y/BB3BZZAMZ84sjFbKFyB1gQSehG/cB0XwpJI8CC6RQtteBN9aPrbD+QHOietlDjY7
 H0bAEj9WU8WyiJm3LL3KejPnPt//KJn08zi2HfZzXz3kh+tcJo+GYmCbITBJo5oAuo
 ffYln8m3R4MMHOZzRLahbDJtnyX5tk/L6s7L5LWM7IqiokM9a+b0xZM6gKWfM8Hasj
 nG7qHSrYsnlaEvcIOpbZC2dkacazluFru/XbJwdMmIFvK1pzRIijQhcVi1XE1APNH2
 K9z3wH8JJw/Fw==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 01 Sep 2026 11:13:04 +0200
Subject: [PATCH v7 06/13] mmc: arm_pl180: Power down card supplies at OS
 handoff
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-ux500-external-sdcard-v7-6-427923e9934b@kernel.org>
References: <20260901-ux500-external-sdcard-v7-0-427923e9934b@kernel.org>
In-Reply-To: <20260901-ux500-external-sdcard-v7-0-427923e9934b@kernel.org>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Stefan Hansson <newbyte@postmarketos.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
Cc: Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

PL180 card supplies remain enabled after probing and while U-Boot is
running. They are no longer needed once control is handed to the operating
system.

Mark the driver for removal during OS preparation and disable its VMMC and
VQMMC supplies from the remove callback.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/mmc/arm_pl180_mmci.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/mmc/arm_pl180_mmci.c b/drivers/mmc/arm_pl180_mmci.c
index e4c22d4b0782..03d907e9c06f 100644
--- a/drivers/mmc/arm_pl180_mmci.c
+++ b/drivers/mmc/arm_pl180_mmci.c
@@ -44,6 +44,20 @@ static int arm_pl180_set_supply_voltage(struct udevice *supply)
 					 SD_VOLTAGE_UV, SD_VOLTAGE_MAX_UV);
 }
 
+static int arm_pl180_disable_supply(struct udevice *supply)
+{
+	int ret;
+
+	if (!supply)
+		return 0;
+
+	ret = regulator_set_enable_if_allowed(supply, false);
+	if (ret == -ENOSYS)
+		return 0;
+
+	return ret;
+}
+
 static int wait_for_command_end(struct mmc *dev, struct mmc_cmd *cmd)
 {
 	u32 hoststatus, statusmask;
@@ -487,6 +501,20 @@ static int arm_pl180_mmc_probe(struct udevice *dev)
 	return 0;
 }
 
+static int arm_pl180_mmc_remove(struct udevice *dev)
+{
+	struct mmc *mmc = mmc_get_mmc_dev(dev);
+	int ret, vmmc_ret;
+
+	ret = arm_pl180_disable_supply(mmc->vqmmc_supply);
+	if (mmc->vmmc_supply != mmc->vqmmc_supply)
+		vmmc_ret = arm_pl180_disable_supply(mmc->vmmc_supply);
+	else
+		vmmc_ret = 0;
+
+	return ret ? ret : vmmc_ret;
+}
+
 int arm_pl180_mmc_bind(struct udevice *dev)
 {
 	struct arm_pl180_mmc_plat *plat = dev_get_plat(dev);
@@ -550,8 +578,10 @@ U_BOOT_DRIVER(arm_pl180_mmc) = {
 	.of_match = arm_pl180_mmc_match,
 	.ops = &arm_pl180_dm_mmc_ops,
 	.probe = arm_pl180_mmc_probe,
+	.remove = arm_pl180_mmc_remove,
 	.of_to_plat = arm_pl180_mmc_of_to_plat,
 	.bind = arm_pl180_mmc_bind,
 	.priv_auto	= sizeof(struct pl180_mmc_host),
 	.plat_auto	= sizeof(struct arm_pl180_mmc_plat),
+	.flags = DM_FLAG_OS_PREPARE,
 };

-- 
2.55.0

