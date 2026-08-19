Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2126FC5DF86
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 08:54:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6EE1A40697;
	Wed, 19 Aug 2026 08:54:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mvRqasYpxv61; Wed, 19 Aug 2026 08:54:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787129663;
	bh=zZ0Ytiis7eiEAR/Ny8xoBKpj7SvQCh7nK+tOoYg8Ft0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H3Jv+vInBGZ+eFxIjfBng779tLJpDG2nvBCeQRZx7jA9Nb3muFuEqhnrlq3Upl6kN
	 inscrjdsAc7FMO5Q6XRu1GNnGVDLdiwIvUbaRRxkVqfHps/yZPZCecAqaY03JF0s2a
	 Urs+Xw9JeoT8Rt/6YTWK5GKBf+rUgf9e4+/eEOqgzbs6BIeeALKj3IACFePatLWvrt
	 J/5i7HEw+VXMWuQcaLNy1g44lTKTcWdwweVuZwMbt6nfa6d9tNaXvG3Vm4+A7/4omX
	 f/CkIAJLJZLKfNuaEjNh9+3UuCh2JytHQ7ifmZckCM+MSG12m7obWhg6JXLj9zqYGX
	 733qB60/4DU6w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0C9FB40762;
	Wed, 19 Aug 2026 08:54:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id AF3852FD
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 08:54:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A154F4008C
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 08:54:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qi8Mq57JPcmS for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 08:54:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=linusw@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=D4Xsd2ip
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9ECA740042
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 08:54:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 805E360A58;
 Wed, 19 Aug 2026 08:54:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A9801F000E9;
 Wed, 19 Aug 2026 08:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787129658;
 bh=zZ0Ytiis7eiEAR/Ny8xoBKpj7SvQCh7nK+tOoYg8Ft0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=D4Xsd2iphjrNgODsYd89jj4aS+3Lzai+YJDHhcseFmyTBXYss94JMjKT2mW5MbtfF
 FAMb9l1MwXd3UUjjnoMzm+ywJJdTqaz79Oer3k3jltrcKrGYChdjLyY608Twvcu/lC
 4nZkyv34MDkPuObzYEnJFp9aZ2YU/JP/3UhPC+Mrz2YT1aiotzaCtjZ49NyDrE12TU
 5eY9sbEjmuDjybVPeeeFqtyHya66qkAxnYDVgeI+QgFvZH/9spHz7ZkNh8m/uvqrvY
 dSU4EPk16BZYwx6IyOQbjWEUnwIb179f8FShiopWMeVq/SLIZyuLza6m0HtiL1ez/6
 9dHbkwjoJ7Bkg==
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 19 Aug 2026 10:54:10 +0200
Subject: [PATCH v4 05/12] mmc: arm_pl180: Power down card supplies at OS
 handoff
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-ux500-external-sdcard-v4-5-f1c8c9ffac30@kernel.org>
References: <20260819-ux500-external-sdcard-v4-0-f1c8c9ffac30@kernel.org>
In-Reply-To: <20260819-ux500-external-sdcard-v4-0-f1c8c9ffac30@kernel.org>
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

