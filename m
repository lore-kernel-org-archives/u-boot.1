Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA0B3C55174
	for <u-boot@archiver.kernel.org>; Sun,  2 Aug 2026 22:26:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9764440563;
	Sun,  2 Aug 2026 22:26:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qp2PyO5ZaBHu; Sun,  2 Aug 2026 22:26:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 64CCE404E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785709586;
	bh=ji0v28vfoZ5XqEdsfOwQJ1oeTpDFEOQhsagGjAvrMjU=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=u/TzDJw5FRuYSdCFAb6AFyIpq1KBuI1ErcKbWOSyTw0ykLYiItbOfHeDHsGmsq7Zw
	 54vcg0g52aqR1agbH82jEZ/+xzl4f7SsfEGYWZXU3JH4RgtfZL1XFl3RnGDU4qOMp3
	 6Sma6zxowDDB0bQZqqUNmJUnMTayrMN7PYEUGby0gCK5Q0Horb2gQeJmJQHhjMTiR+
	 315VPNzdygWplxxgG6e7LpLDTJy04wSkkm7HaSsMIbRaHFrPDJxWRExDws/rD+VQwD
	 Xp2e6Nkh7jk6Uwujc0PXNvNnBO6IJYJXRMPM6Ss5cI6jwE4HTB4ni2qYrflypd9vfo
	 KeqPh5/DQLxRg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 64CCE404E0;
	Sun,  2 Aug 2026 22:26:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 431BBFE3
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 22:26:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3462840080
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 22:26:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5UvvC0R6FSo0 for <u-boot@lists.u-boot-project.org>;
 Sun,  2 Aug 2026 22:26:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::202; helo=mout-p-202.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 62E734006F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 62E734006F
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 62E734006F
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 22:26:24 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hCvXt1XmpzMlLs;
 Mon, 03 Aug 2026 00:26:22 +0200 (CEST)
To: u-boot@lists.u-boot-project.org
Cc: Tuyen Dang <tuyen.dang.xa@renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] ufs: rcar-gen5: Switch from FASTAUTO mode to FAST mode
Date: Mon,  3 Aug 2026 00:25:52 +0200
Message-ID: <20260802222614.194571-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: d8b32377e5e13d0cb5c
X-MBO-RS-META: 6qe9c13ia66jh9ahxxkfdjgirjp66b5j
X-Rspamd-Queue-Id: 4hCvXt1XmpzMlLs
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785709582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ji0v28vfoZ5XqEdsfOwQJ1oeTpDFEOQhsagGjAvrMjU=;
 b=haOjSOUhg3vXpRYNQh3O9WkfA3pOqY+BeEMAbO8FoEH79LuxBbka+whv6NxGg/tMC9uXQv
 e164hsKs78uNnMYGzYgsvPL2THqFZ7ShQbfxZIcEQ4HnmqjxMd7GIT9RWOSxmtmNTljn45
 TfyOB/hWLMvOAgJZwbAPGjbxfIVV9efj4u+7Ov0dCtlyiU0GgYwi3Fy5Jgcsph6EJcJ85B
 8EDFEklk+0wSjQN4dV1n3XNhCVpjRPuI8xieJTWKUzXoBeLP+HYeeIDhfvpC4mLUXroEJW
 dORpFklH38QfOQknW7/jPKHrd5J9PAOgKan/XTQDil/vSwMhPFIBw6XRx9NxkQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785709580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ji0v28vfoZ5XqEdsfOwQJ1oeTpDFEOQhsagGjAvrMjU=;
 b=LWY+w96TW13sElR9UyQLOr8LgqjOOGVgb4HXKnQTaoM5Yoc8eIs9Ngxj/evQbmIuOAwAIM
 pcv1y/I9ITM1a6Salpl02XqozMhQoQ8EJxPVbauW7nQpHnTeh1JiRW2iE2mmIJZRbdeIgJ
 7lQ6u1JCLsVIxmEG3Y8UCpAsQjr060ryINzz8fM5FnQr+ySbf6wg5ZEj29DTOxNj6lMlBg
 gz/S/QXDMvR94aI3d/PdXiLqUl7x+UOtIFGjXEZbcCP9bjpnNLj558eJTMJ2VzUhRWBkh4
 WqpXFUn1AOWyMgYIiaC9ujMrQnKbJ2qey+xo0CRuF6M3Qp4eueKaaSCrAltSqg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=haOjSOUh; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=LWY+w96T
X-Mailman-Original-Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=LWY+w96T;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
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
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Tuyen Dang <tuyen.dang.xa@renesas.com>

Switch from FASTAUTO to FAST mode and lane 2 to achieve
higher throughput. Drop the 64bit address quirk.

Signed-off-by: Tuyen Dang <tuyen.dang.xa@renesas.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>
Cc: Neha Malcom Francis <n-francis@ti.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Tuyen Dang <tuyen.dang.xa@renesas.com>
Cc: u-boot@lists.u-boot-project.org
---
 drivers/ufs/ufs-renesas-rcar-gen5.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/ufs/ufs-renesas-rcar-gen5.c b/drivers/ufs/ufs-renesas-rcar-gen5.c
index a9473cd60b1..c6e436fe197 100644
--- a/drivers/ufs/ufs-renesas-rcar-gen5.c
+++ b/drivers/ufs/ufs-renesas-rcar-gen5.c
@@ -72,7 +72,7 @@ static int ufs_renesas_pre_init(struct ufs_hba *hba)
 	if (ret)
 		return ret;
 
-	writew(0x0000, priv->phy_base + 0x20000);
+	clrbits_le16(priv->phy_base + 0x20000, BIT(0));
 
 	ufshcd_writel(hba, BIT(0), REG_CONTROLLER_ENABLE);
 
@@ -88,6 +88,9 @@ static int ufs_renesas_pre_init(struct ufs_hba *hba)
 	if (ret)
 		return ret;
 
+	ufshcd_rmwl(hba, 0xe000, 0, 0xc0);
+	ufshcd_rmwl(hba, 0x5000, 0x5000, 0xc0);
+
 	/* Skip IE because we cannot handle interrupts here */
 	ufs_dme_command(hba, 0x00000002, 0x81010000, 0x00000000, 0x00000005);
 	ufs_dme_command(hba, 0x00000002, 0x81150000, 0x00000000, 0x00000001);
@@ -133,6 +136,10 @@ static int ufs_renesas_pre_init(struct ufs_hba *hba)
 	if (ret)
 		return ret;
 
+	clrbits_le16(priv->phy_base + 0x20000, BIT(0));
+
+	ufs_dme_command(hba, 0x00000002, 0xd0890000, 0x00000000, 0x00000001);
+
 	priv->initialized = true;
 
 	return 0;
@@ -140,8 +147,7 @@ static int ufs_renesas_pre_init(struct ufs_hba *hba)
 
 static int ufs_renesas_init(struct ufs_hba *hba)
 {
-	hba->quirks |= UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS | UFSHCD_QUIRK_HIBERN_FASTAUTO |
-		       UFSHCD_QUIRK_BROKEN_LCC;
+	hba->quirks |= UFSHCD_QUIRK_HIBERN_FASTAUTO | UFSHCD_QUIRK_BROKEN_LCC;
 
 	return 0;
 }
@@ -180,12 +186,12 @@ static int ufs_renesas_get_max_pwr_mode(struct ufs_hba *hba,
 {
 	max_pwr_info->info.gear_rx = UFS_HS_G5;
 	max_pwr_info->info.gear_tx = UFS_HS_G5;
-	max_pwr_info->info.pwr_tx = FASTAUTO_MODE;
-	max_pwr_info->info.pwr_rx = FASTAUTO_MODE;
-	max_pwr_info->info.hs_rate = PA_HS_MODE_A;
+	max_pwr_info->info.pwr_tx = FAST_MODE;
+	max_pwr_info->info.pwr_rx = FAST_MODE;
+	max_pwr_info->info.hs_rate = PA_HS_MODE_B;
 
-	max_pwr_info->info.lane_rx = 1;
-	max_pwr_info->info.lane_tx = 1;
+	max_pwr_info->info.lane_rx = 2;
+	max_pwr_info->info.lane_tx = 2;
 
 	dev_info(hba->dev, "Max HS Gear: %d\n", max_pwr_info->info.gear_rx);
 
-- 
2.53.0

