Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 861E7C48BC3
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 08:40:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36C2687BB3;
	Tue, 20 Feb 2024 09:39:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="N6z2547k";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="OoesVVv+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 354C887FB9; Tue, 20 Feb 2024 09:39:47 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 713B087F79
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 09:39:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4TfCVx2Kw6z9scC;
 Tue, 20 Feb 2024 09:39:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1708418345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Mn3SQVWEQhem2TKfWn0P6peJemOFGmfLQ/0BBk48PnE=;
 b=N6z2547kV2ta/YnCtPw43HCnF5K8jYnUWrd2rNk8kGiqKfSB3SQ7u+SDQ9BiAoBQWT4oaR
 aFGMj6lxecCxhh3O+t6X4zVwtEexmoid2OgZmS7Eu3bKgWMhG9XuIJPOLL0C3bklcPJbxU
 o2zhGvBVUUs/Q9BqTsvmbYqCI0nCbUGf5Hbc+aOx+RG/GHwqKrAv1zFj1L99CS5kkJ2uF/
 6yZvsZjn6Joq4LO4Sb8bJXOT/FNvcF1JfUp1yCETGm/1IrL1XK9D2Su9V7W3B130MeibWO
 b3TDwKw+vDUrk35f6xZ5FqeuLh8B99KCbBVIVEoirzhWa6ccEIekxe0z9udfDw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1708418343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Mn3SQVWEQhem2TKfWn0P6peJemOFGmfLQ/0BBk48PnE=;
 b=OoesVVv+2JCW58OWB7nlYe7tzt8LQPolo/xq+3TDUxOIf2p6PZR68lIRQZOoYSrJyT3kwt
 8B5qXYU48mviyLxNcJuJgeTyXNuyQSVfpxlYH0O9RvCsxtcdu8B0NMTZvpx2FXz6ZoRJAL
 zivIsTniqbDZEcOyKsmqve54NI10KwrvVp7TW8sxcXq6SDJeu1S/xwceeL8+tvSt1Ibxla
 4vjefvl2lG3kr6irtJHsP9Le5vG3Ytifu/c2gz0JpcPf0+37ZG0J/gmvzZA+Obffy4yNkC
 bro1VylrIUOCvqm7rVVRkd1Kz7eemdtB8nN6Lg7QiK9lvmyuBEyzNQvp2I27dg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hai Pham <hai.pham.ud@renesas.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH] mmc: renesas-sdhi: Stop transmission in case tuning block
 transfer fails
Date: Tue, 20 Feb 2024 09:38:45 +0100
Message-ID: <20240220083853.34497-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: tt39m3f8zpp38i5wzqiamj5qfuko49kw
X-MBO-RS-ID: 49055c505b11522c630
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

The current code uses the state of tuning block received by SCC to
determine whether or not to send transmission stop command. This is
not correct. Use the state of tuning block transfer to determine
whether or not to send transmission stop command instead, because
the transmission stop command has to be sent in case the tuning
block transfer failed.

This requires two changes, separate variable to store and check the
state of tuning block received by SCC, and another separate variable
to store and check return value from transmission stop command.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/mmc/renesas-sdhi.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/renesas-sdhi.c b/drivers/mmc/renesas-sdhi.c
index 316b75b35fe..c4d0733b621 100644
--- a/drivers/mmc/renesas-sdhi.c
+++ b/drivers/mmc/renesas-sdhi.c
@@ -568,8 +568,8 @@ int renesas_sdhi_execute_tuning(struct udevice *dev, uint opcode)
 	struct mmc *mmc = upriv->mmc;
 	unsigned int tap_num;
 	unsigned int taps = 0;
-	int i, ret = 0;
-	u32 caps;
+	int i, ret = 0, sret;
+	u32 caps, reg;
 
 	/* Only supported on Renesas RCar */
 	if (!(priv->caps & TMIO_SD_CAP_RCAR_UHS))
@@ -612,8 +612,8 @@ int renesas_sdhi_execute_tuning(struct udevice *dev, uint opcode)
 		if (ret == 0)
 			taps |= BIT(i);
 
-		ret = renesas_sdhi_compare_scc_data(priv);
-		if (ret == 0)
+		reg = renesas_sdhi_compare_scc_data(priv);
+		if (reg == 0)
 			priv->smpcmp |= BIT(i);
 
 		mdelay(1);
@@ -624,9 +624,9 @@ int renesas_sdhi_execute_tuning(struct udevice *dev, uint opcode)
 		 * eMMC.
 		 */
 		if (ret && (opcode == MMC_CMD_SEND_TUNING_BLOCK_HS200)) {
-			ret = mmc_send_stop_transmission(mmc, false);
-			if (ret < 0)
-				dev_dbg(dev, "Tuning abort fail (%d)\n", ret);
+			sret = mmc_send_stop_transmission(mmc, false);
+			if (sret < 0)
+				dev_dbg(dev, "Tuning abort fail (%d)\n", sret);
 		}
 	}
 
-- 
2.43.0

