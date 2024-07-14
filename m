Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C913CC3DA42
	for <u-boot@archiver.kernel.org>; Sun, 14 Jul 2024 21:28:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC93C8859A;
	Sun, 14 Jul 2024 23:28:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mail.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mail.de header.i=@mail.de header.b="0hL91MpX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1C8188403; Sun, 14 Jul 2024 23:28:15 +0200 (CEST)
Received: from shout02.mail.de (shout02.mail.de [IPv6:2001:868:100:600::217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 485E188403
 for <u-boot@lists.denx.de>; Sun, 14 Jul 2024 23:28:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=mail.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=seb-dev@mail.de
Received: from postfix01.mail.de (postfix01.bt.mail.de [10.0.121.125])
 by shout02.mail.de (Postfix) with ESMTP id EF359240CC4;
 Sun, 14 Jul 2024 23:28:11 +0200 (CEST)
Received: from smtp01.mail.de (smtp04.bt.mail.de [10.0.121.214])
 by postfix01.mail.de (Postfix) with ESMTP id D47CA80298;
 Sun, 14 Jul 2024 23:28:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
 s=mailde202009; t=1720992491;
 bh=fSq60ryYsVVFPzNGlbJFrravXrSeUxzXecoHvqnpHy8=;
 h=From:To:Cc:Subject:Date:Message-ID:From:To:CC:Subject:Reply-To;
 b=0hL91MpXKokUEmAKxo4aklJhXCgH2OCdwJhVR6hENuQCY9g6FpO5T5r3trO+ebuQe
 +u1LA86ivKyK0o8lWtDuWQ2T09bpUA3Xyxi0beheu5e19GFg7pqI/nDSdMbY/9fuVk
 m/66W0RaIvRnZmhVaWNJ6GbOwNth8J8jsaAfAkAqqQNleo+lS+nX/PoVup5MJesgfd
 wQVOegk47foyl0fMo3eKRX8/SbLE5pgfUoHHU7IJG8l/O+iUx+AVvcm64HG9aDHP3u
 aAsXoT77tmqiwbsAovBnC/bAqgAbVQGORNUFtrDI2aBGl3ftaqg+3GVGd6K5e0bs1V
 szDVxBbFDAOjA==
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp01.mail.de (Postfix) with ESMTPSA id 8271D240BD8;
 Sun, 14 Jul 2024 23:28:11 +0200 (CEST)
From: Sebastian Kropatsch <seb-dev@mail.de>
To: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Subject: [PATCH 2/4] phy: rockchip: snps-pcie3: Fix "rockchip" spelling
Date: Sun, 14 Jul 2024 23:23:41 +0200
Message-ID: <6b71eee1acdc0069880755673a4a52194045ad9f.1720988760.git.seb-dev@mail.de>
In-Reply-To: <cover.1720988760.git.seb-dev@mail.de>
References: <cover.1720988760.git.seb-dev@mail.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for
 further information)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for
 further information)
X-purgate: clean
X-purgate-size: 1864
X-purgate-ID: 154282::1720992491-E37EF338-7DC56D25/0/0
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

Several identifiers use "rochchip" instead of "rockchip".
Fix this by replacing every instance of "rochchip" with "rockchip".

Signed-off-by: Sebastian Kropatsch <seb-dev@mail.de>
---
 drivers/phy/rockchip/phy-rockchip-snps-pcie3.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c b/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
index 2737bd81dd..1c94875aaa 100644
--- a/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
+++ b/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
@@ -164,7 +164,7 @@ static const struct rockchip_p3phy_ops rk3588_ops = {
 	.phy_init = rockchip_p3phy_rk3588_init,
 };
 
-static int rochchip_p3phy_init(struct phy *phy)
+static int rockchip_p3phy_init(struct phy *phy)
 {
 	struct rockchip_p3phy_ops *ops =
 		(struct rockchip_p3phy_ops *)dev_get_driver_data(phy->dev);
@@ -185,7 +185,7 @@ static int rochchip_p3phy_init(struct phy *phy)
 	return ret;
 }
 
-static int rochchip_p3phy_exit(struct phy *phy)
+static int rockchip_p3phy_exit(struct phy *phy)
 {
 	struct rockchip_p3phy_priv *priv = dev_get_priv(phy->dev);
 
@@ -251,9 +251,9 @@ static int rockchip_p3phy_probe(struct udevice *dev)
 	return 0;
 }
 
-static struct phy_ops rochchip_p3phy_ops = {
-	.init = rochchip_p3phy_init,
-	.exit = rochchip_p3phy_exit,
+static struct phy_ops rockchip_p3phy_ops = {
+	.init = rockchip_p3phy_init,
+	.exit = rockchip_p3phy_exit,
 };
 
 static const struct udevice_id rockchip_p3phy_of_match[] = {
@@ -272,7 +272,7 @@ U_BOOT_DRIVER(rockchip_pcie3phy) = {
 	.name		= "rockchip_pcie3phy",
 	.id		= UCLASS_PHY,
 	.of_match	= rockchip_p3phy_of_match,
-	.ops		= &rochchip_p3phy_ops,
+	.ops		= &rockchip_p3phy_ops,
 	.probe		= rockchip_p3phy_probe,
 	.priv_auto	= sizeof(struct rockchip_p3phy_priv),
 };
-- 
2.43.0

