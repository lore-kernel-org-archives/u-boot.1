Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B191C5DF81
	for <u-boot@archiver.kernel.org>; Sun, 23 Aug 2026 20:39:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DADA780D93;
	Sun, 23 Aug 2026 20:39:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XF7FU04EnKgR; Sun, 23 Aug 2026 20:39:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787517585;
	bh=Y8F+2J4sQkRdkDlLwiUW4Tj1R7ad5joMxHEqiliDGaI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xZE9xsvnOYphY1UYpakdEkffz+zMs0jOsFL6adVSDCc3NYQ16hHc6E5Q4ZC6uItbx
	 ZMTr9KEXBM1jrtLk/6gue7lu4HOp/GRbXFyyG+WBIwg4CLcyg7IRxk1o/ohv7j1VT9
	 E346+JYSFHXMZOUYJCq0HRNuj4hM9Pq/DBOmjoxMk5GWWV2BHQygL9ma3ac1DXtezT
	 oKMsv96l3LcgGzary5P2u/TOdHPzCRFxmufuuRQUHVzeU/ML4/n5rQhJmzCc02sCfr
	 jZTDX/rO0+QHzTZdOLmtcfq2HOf5nlJTRtcx6iq/076cM3plmIbUDMcm0TMvXpLOgr
	 26i79FUkdbC3w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A384180D96;
	Sun, 23 Aug 2026 20:39:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id CE32E41A
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 20:39:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CB5BC80C59
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 20:39:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m9DCloxZWrCL for <u-boot@lists.u-boot-project.org>;
 Sun, 23 Aug 2026 20:39:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=linusw@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=T1H6oscG
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C4D3E80D39
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 20:39:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4918D4064C;
 Sun, 23 Aug 2026 20:39:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F41C11F000E9;
 Sun, 23 Aug 2026 20:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787517579;
 bh=Y8F+2J4sQkRdkDlLwiUW4Tj1R7ad5joMxHEqiliDGaI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=T1H6oscGz3wxklMLBzK2hG5KkTIRqyP0XUXySf1MuS3BacEmNpZ2z6LXjJC3qEo3u
 SkXVlfQqVioA8wxiQY8bHVoiGVrcFakNY84Rhcte+5ntU781oEAHP1jbXcWthmsJ/u
 5XRENtOf/IJUQHaxVEjCKvojoXmRyWchTxgRzixCkCsrWAmOeVGdWpZnXkLucKdBMj
 K/MWY0gxgLbG5u4/FSwuUD7jDbaJDuLfZ9JIPUb10T8Gqiv+d50nNODQ/WyIiajafx
 7LpOI0Ij59IpuP6FCg24QG7TD9d+dOxadegUCCmkCMabF747YSDGEMCo3JIzzLsg8I
 77KbLrO/DPICQ==
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 23 Aug 2026 22:39:25 +0200
Subject: [PATCH v5 06/13] mmc: arm_pl180: Power down card supplies at OS
 handoff
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260823-ux500-external-sdcard-v5-6-07ca794e2b94@kernel.org>
References: <20260823-ux500-external-sdcard-v5-0-07ca794e2b94@kernel.org>
In-Reply-To: <20260823-ux500-external-sdcard-v5-0-07ca794e2b94@kernel.org>
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
index 8483d859fb96..012ee0508776 100644
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
@@ -488,6 +502,20 @@ static int arm_pl180_mmc_probe(struct udevice *dev)
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
@@ -551,8 +579,10 @@ U_BOOT_DRIVER(arm_pl180_mmc) = {
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

