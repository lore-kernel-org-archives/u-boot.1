Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFBA5C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 20:46:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9679C88A0E;
	Tue, 16 Jul 2024 22:45:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mail.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mail.de header.i=@mail.de header.b="DIzsgBgI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B54F8880B; Tue, 16 Jul 2024 22:45:33 +0200 (CEST)
Received: from shout01.mail.de (shout01.mail.de [IPv6:2001:868:100:600::216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A00B48881D
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 22:45:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=mail.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=seb-dev@mail.de
Received: from postfix03.mail.de (postfix03.bt.mail.de [10.0.121.127])
 by shout01.mail.de (Postfix) with ESMTP id 4D4F1240E24;
 Tue, 16 Jul 2024 22:45:29 +0200 (CEST)
Received: from smtp01.mail.de (smtp01.bt.mail.de [10.0.121.211])
 by postfix03.mail.de (Postfix) with ESMTP id 305BC801CF;
 Tue, 16 Jul 2024 22:45:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
 s=mailde202009; t=1721162729;
 bh=UWUrtga7RY+qXkOrZPhM7acMP7b8zOA+xtrWEYQgSJc=;
 h=From:To:Cc:Subject:Date:Message-ID:From:To:CC:Subject:Reply-To;
 b=DIzsgBgIFf/OsJIs75qH25DDOJ1LNRbpNn8Hkqxz+4H+l755adkaMOOwgoBRiRQNZ
 O+zQAclKgao1wbZMBD8NaLho3utZJfAhxRuRXPSlcP+LoQH+ZNpjhRXI2kzwbhP4dG
 jU2pkc5U+we4tkJzlX5haXmNIcR+YV0+yMlbdJRuNoQlNnQmp2WH7vEkcfg1EL/jNz
 +Eh9nUX9XoqKKmzNnCLfAXj0uZCgi99WFxF8xQHlxxV3HM5HUL4uPzilRWs6C03EoP
 VmOLIIrab6B59jvSn6AUIM6iNzHDstEpiz9mYsm+JQCV2XqVRp4dUqQRcUrbOOyubf
 wmJbINxcez/qg==
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp01.mail.de (Postfix) with ESMTPSA id D1F80240A07;
 Tue, 16 Jul 2024 22:45:28 +0200 (CEST)
From: Sebastian Kropatsch <seb-dev@mail.de>
To: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Subject: [PATCH v2 1/5] phy: rockchip: naneng-combphy: Fix "rockchip" spelling
Date: Tue, 16 Jul 2024 22:42:06 +0200
Message-ID: <bb6bd7767742de0a578ac617b67a99748797ec70.1721161722.git.seb-dev@mail.de>
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
X-purgate-size: 1222
X-purgate-ID: 154282::1721162729-45DBE670-1E2F3134/0/0
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

Replace "rochchip" by "rockchip" in two instances.

Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
Signed-off-by: Sebastian Kropatsch <seb-dev@mail.de>
---
 drivers/phy/rockchip/phy-rockchip-naneng-combphy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
index 3ad339bccc..1b85cbcce8 100644
--- a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
+++ b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
@@ -225,7 +225,7 @@ static int rockchip_combphy_xlate(struct phy *phy, struct ofnode_phandle_args *a
 	return 0;
 }
 
-static const struct phy_ops rochchip_combphy_ops = {
+static const struct phy_ops rockchip_combphy_ops = {
 	.init = rockchip_combphy_init,
 	.exit = rockchip_combphy_exit,
 	.of_xlate = rockchip_combphy_xlate,
@@ -535,7 +535,7 @@ U_BOOT_DRIVER(rockchip_naneng_combphy) = {
 	.name		= "naneng-combphy",
 	.id		= UCLASS_PHY,
 	.of_match	= rockchip_combphy_ids,
-	.ops		= &rochchip_combphy_ops,
+	.ops		= &rockchip_combphy_ops,
 	.probe		= rockchip_combphy_probe,
 	.priv_auto	= sizeof(struct rockchip_combphy_priv),
 };
-- 
2.43.0

