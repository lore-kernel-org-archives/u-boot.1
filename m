Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E10E0C3DA59
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 20:45:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32C31889E0;
	Tue, 16 Jul 2024 22:45:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mail.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mail.de header.i=@mail.de header.b="2v6yoqNp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8ED0888A0A; Tue, 16 Jul 2024 22:45:33 +0200 (CEST)
Received: from shout02.mail.de (shout02.mail.de [IPv6:2001:868:100:600::217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78C73887D1
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 22:45:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=mail.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=seb-dev@mail.de
Received: from postfix02.mail.de (postfix02.bt.mail.de [10.0.121.126])
 by shout02.mail.de (Postfix) with ESMTP id 292F9240F11;
 Tue, 16 Jul 2024 22:45:30 +0200 (CEST)
Received: from smtp01.mail.de (smtp01.bt.mail.de [10.0.121.211])
 by postfix02.mail.de (Postfix) with ESMTP id 0889AA00E2;
 Tue, 16 Jul 2024 22:45:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
 s=mailde202009; t=1721162730;
 bh=vIf/s8LyRxv3i/Z7sVwyeHuS6fOfMBg8nvJjNFtrg5U=;
 h=From:To:Cc:Subject:Date:Message-ID:From:To:CC:Subject:Reply-To;
 b=2v6yoqNpL+Lpt3CazVbh6eMB+CA89cz4MhBaBliq992K3MjVpHIe28zRndjFox9if
 e9Yhi4ZC/vpoVn+GBwfej9l11ubHLpIg3hbup9BvnSEbjbwj209pPHNDeSoHItn+9X
 s5pcNql6GsJ9dla/t71cBCrlqnAYEN0uwTLXiTaATyKKlNmrO2qjUbucrMuDkopAw0
 JhFefa6pkG/gwBh1b27i6ys4SUQSxqC5Yy0rSKcnA9UiPQfMFccKMmt5t+b/IvS8DR
 tTJQ3q0pE7t5mtJxNg6EqO9PUFoXZ6xpCFeE/XwQ5zTf6DGRR2e+NyjUVQcHX/GRRw
 llVv1BX7Csf1g==
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp01.mail.de (Postfix) with ESMTPSA id A9A60240A07;
 Tue, 16 Jul 2024 22:45:29 +0200 (CEST)
From: Sebastian Kropatsch <seb-dev@mail.de>
To: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Subject: [PATCH v2 3/5] phy: rockchip: snps-pcie3: Fix "rockchip" spelling
Date: Tue, 16 Jul 2024 22:42:08 +0200
Message-ID: <20d662d8bd8cf1e7ca6aa28cc06c239d0b54fc21.1721161722.git.seb-dev@mail.de>
In-Reply-To: <cover.1721161722.git.seb-dev@mail.de>
References: <cover.1721161722.git.seb-dev@mail.de>
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
X-purgate-size: 1917
X-purgate-ID: 154282::1721162729-45DBE670-FBD07C80/0/0
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

Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
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

