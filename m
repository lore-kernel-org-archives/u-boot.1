Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D0CC83F25
	for <u-boot@archiver.kernel.org>; Mon, 21 Jul 2025 22:09:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7A4683829;
	Tue, 22 Jul 2025 00:08:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="HDuATmbe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F333B830EA; Tue, 22 Jul 2025 00:08:08 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5D1D83826
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 00:08:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=dd2a=2D=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1753135685; bh=j5unnKU7x9IZZNlubEyDQSg4BrGhuVUeckfLNqQ8SEU=;
 b=HDuATmbeDi+gWMgYlxXXiyNSqKCSD37+Cl2P1OUU89DLHawnsQguLxr6iAvYRG81R+nRphv28
 yWmMwKF6lzvFin2JjCli9l6OU6eFbxPMZL4WH+XJ76hpQuEJqtIlgF014dXs65kjc+XjzH/H/TD
 J3nEdanKkcgs8eLUxWsaUoZBMLreyBkOi/uIvAGc6PhAv3vxfIR2My5KN7zIk4OCCU4S0b4Sw8a
 wat1ZcUNEnGv6IPYVmIIc+Lg7qrMffbpOa9xvvgsOeJFOzr6Jppw3mtLrlqMPzM1UyqNhkPhtfc
 eLVmbb8l/D+ZLqtnOxrgkdVAEq3y0XAdZvc/FIUER4mw==
X-Forward-Email-ID: 687eba44285c522641289548
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.1.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 07/10] phy: rockchip: typec: Fix improper use of UCLASS_PHY
Date: Mon, 21 Jul 2025 22:07:16 +0000
Message-ID: <20250721220734.1617117-8-jonas@kwiboo.se>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721220734.1617117-1-jonas@kwiboo.se>
References: <20250721220734.1617117-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The Rockchip TypeC glue driver improperly present itself as a UCLASS_PHY
driver, without ever implementing the required phy_ops.

This is something that in special circumstances can lead to a NULL
pointer dereference followed by a SError crash.

Change the glue driver to use UCLASS_NOP to fix this.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/phy/rockchip/phy-rockchip-typec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-typec.c b/drivers/phy/rockchip/phy-rockchip-typec.c
index c48a5cd52676..66d1d32d25cb 100644
--- a/drivers/phy/rockchip/phy-rockchip-typec.c
+++ b/drivers/phy/rockchip/phy-rockchip-typec.c
@@ -788,7 +788,7 @@ U_BOOT_DRIVER(rockchip_tcphy_usb3_port) = {
 
 U_BOOT_DRIVER(rockchip_typec_phy) = {
 	.name	= "rockchip_typec_phy",
-	.id	= UCLASS_PHY,
+	.id	= UCLASS_NOP,
 	.of_match = rockchip_typec_phy_ids,
 	.probe = rockchip_tcphy_probe,
 	.bind = rockchip_tcphy_bind,
-- 
2.50.1

