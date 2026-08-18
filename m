Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE81C5DF70
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 09:00:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4259740738;
	Tue, 18 Aug 2026 09:00:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dvRjW6KN675f; Tue, 18 Aug 2026 09:00:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 96D1E407A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787043645;
	bh=zZ0Ytiis7eiEAR/Ny8xoBKpj7SvQCh7nK+tOoYg8Ft0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CpHgTv3XaIK9hzktF3E8BLDw8y+00ZLa3cee1/9DOrQxrrwsuw6TxN9t+1DpbCwaz
	 4nuCkPhPz6GRnltotTuX2pM9WnikVQsqeT4uO3TR0xpu8fAERhWx0j+kZbsGTe698T
	 1W1+isq2hfmAV+e2CoFsZ7llanDqZEoIz6NUQw0/nG+iT4BD5m1vIWC4Ov7e2etPOa
	 THvb2RuHXdkxvekTcwndFJODOVf20xvReMYlujAGejIgG8XSvKrZEKuzQ5/ckTlufs
	 ypeNPPbJ/+FyN7p68zdi4WPdiBNTz1duNH6I9V70PWFIQ2xYJklg2o+QBFEd5XLdcO
	 Tlhj6KXTvcf4g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 96D1E407A2;
	Tue, 18 Aug 2026 09:00:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 90D7D237
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 09:00:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 722288100F
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 09:00:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DPgS02gs9Z2C for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 09:00:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=linusw@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 6CD6F80F14
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6CD6F80F14
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=JBvbUpXN
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6CD6F80F14
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 09:00:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7B24F60A6C;
 Tue, 18 Aug 2026 09:00:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 028801F000E9;
 Tue, 18 Aug 2026 09:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787043639;
 bh=zZ0Ytiis7eiEAR/Ny8xoBKpj7SvQCh7nK+tOoYg8Ft0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=JBvbUpXNd5rPSVLUC7W5pAE0tUcuziv5VmkDxKDPaGu6yS76jHrRTjvi58ijlogzd
 2WdBf74F/5UdzW8fy/wh96mgGRYzmzX6zLp1UeFeko+onRCK0H00tyR0msM6pH6tGr
 suFwp8TaEwiGsXmQa8Adqm5tT5pD+tMLPpO8vyNbFcJiyLy0KQq/+d01tvUKErkJtw
 SV/uW4M7xxwcM6oUxOZo+E0re9kmM8zR1TnbswzPVqNG1i0Z16WwFZQmM3po5vmSr6
 ISEvGUX9qlIpgdMuE8Va2Ug38ucKMzK/pY1dUW+Ks9Zd5gCiL79n17Du2v6E5NlYig
 G5srrn4tYvSzg==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 18 Aug 2026 11:00:29 +0200
Subject: [PATCH v3 05/11] mmc: arm_pl180: Power down card supplies at OS
 handoff
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-ux500-external-sdcard-v3-5-a5d94930f3bb@kernel.org>
References: <20260818-ux500-external-sdcard-v3-0-a5d94930f3bb@kernel.org>
In-Reply-To: <20260818-ux500-external-sdcard-v3-0-a5d94930f3bb@kernel.org>
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
index a2ea5cf03120..dd913f963c82 100644
--- a/drivers/mmc/arm_pl180_mmci.c
+++ b/drivers/mmc/arm_pl180_mmci.c
@@ -46,6 +46,20 @@ static int arm_pl180_set_supply_voltage(struct udevice *supply, int target_uV)
 					 target_uV, SD_VOLTAGE_MAX_UV);
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
@@ -497,6 +511,20 @@ static int arm_pl180_mmc_probe(struct udevice *dev)
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
@@ -560,8 +588,10 @@ U_BOOT_DRIVER(arm_pl180_mmc) = {
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

