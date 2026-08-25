Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB3DC61DB9
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 19:04:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0FDB640639;
	Tue, 25 Aug 2026 19:04:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n1eN9W0BXeb8; Tue, 25 Aug 2026 19:04:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787684663;
	bh=bARUAtwO2YgnQJnR0X1lXttSPrsPWxGSLq4QXwOHmpA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WgNyBh7ohHKZ0I8rWCU0Ts5MiY2clZ0n7XNncx2KMCnnL+1IZwyggi5/mKQULeQHS
	 eu6vblquNnqWZ4Sie7RUH2yjB+1u8vkL0hG2zp00ZDJNgB+df0F4nn7u6IqZaN1DOd
	 rkpE4FB5WmMNMlvg9+vqcWD5gfOKh4GZrCVe9KtfNZEZ79+70EjTNbAzFaWLtuoSyS
	 hS9VJdaTbkelBmJTLprxRcylmAEL1B0g8AtkeCW/driJDLzGO8As3jGRos/R13WEg8
	 rfzXLwOi8Ii0W+ysdgHEa2Urs6qbEGswshOYzxo+6bVIbcJtX8z68My5PJ0FbN8m+9
	 DEAKjQCR4e6Dg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 595AA405E6;
	Tue, 25 Aug 2026 19:04:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E48DF3C3
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:04:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CAA5F40085
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:04:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YJ1tGZz6-pPi for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 19:04:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=linusw@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=LmuYocMC
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D9DE240068
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:04:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EC45E40AFE;
 Tue, 25 Aug 2026 19:04:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A21F51F00A3A;
 Tue, 25 Aug 2026 19:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787684656;
 bh=bARUAtwO2YgnQJnR0X1lXttSPrsPWxGSLq4QXwOHmpA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=LmuYocMCnhDx0AR2aipRgdYsQCEqeWz6zV1vmcUo3mM680bKmSL8IR6T9Aj8yc++8
 XknzVyE28phLlypdz+7wkAiTjvZkQqGC+Y1myQifhVmgqcCvRRCZKKYHR9hHceacL0
 1bR5KeRlkq1uEFV2unDQrO/FK8gXIipoNHPfutlxaN1gJB9SbjWHyDLLQABiYnAZg7
 DAcDuJeC2LP03c/W0YIsmU3G/La9jUxvVmRjyQ9xfFiccuZztdWsHFw3zxY1brIIQ/
 qHVUlgS4ty5sWxMEQQus7WOm4xNOeH/p2KY2bAAU96WzrCUEkuElUs6q84cxvn95Xi
 6FE4aQCTmrJdg==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 25 Aug 2026 21:04:06 +0200
Subject: [PATCH v6 06/13] mmc: arm_pl180: Power down card supplies at OS
 handoff
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-ux500-external-sdcard-v6-6-61446b6c289e@kernel.org>
References: <20260825-ux500-external-sdcard-v6-0-61446b6c289e@kernel.org>
In-Reply-To: <20260825-ux500-external-sdcard-v6-0-61446b6c289e@kernel.org>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Stefan Hansson <newbyte@postmarketos.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>
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

