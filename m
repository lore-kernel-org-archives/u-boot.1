Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0189EC83F1A
	for <u-boot@archiver.kernel.org>; Mon, 21 Jul 2025 22:08:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9EDC837E2;
	Tue, 22 Jul 2025 00:08:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="zyJUNkoJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFC9583768; Tue, 22 Jul 2025 00:08:08 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA4FC8380E
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 00:08:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=dd2a=2D=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1753135685; bh=WUPB6Mo0m3egby2FAB4C1w56F2JNJI6ZWdzZJ8wgDtA=;
 b=zyJUNkoJlh0hqArJ0sTSZbiMAN02Cu/Mf++DX7qaE4hqrjQ3vGoI04ycHb88r3PcQnWS/XWNT
 qubC7+rlC7tzktP/decAC1BJyzu0eiKrt0RciWjWPzpHymBA8MNdKtlqZJcWMwaqy59G/gBJUxh
 g1VdFbvcX7AzlnsAydaA4GVg+Nvnh0afjsCbkU6sq4TgPT8p0paUPwFJJle6eZ4SywdOvR+xbEr
 OQqKXW3m3sIrKBNq9eYdlf9uCS4s/Uwbh+JZLHrnVCn5rcq/ACXj1Zvx6yAWkpiGCgzVxqpTyh+
 RANCIEWrXD9cFOJSBa8lzNltkzhJeDb6SuXqeP66d/BA==
X-Forward-Email-ID: 687eba40285c522641289533
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
Subject: [PATCH 06/10] phy: rockchip: inno-usb2: Fix improper use of UCLASS_PHY
Date: Mon, 21 Jul 2025 22:07:15 +0000
Message-ID: <20250721220734.1617117-7-jonas@kwiboo.se>
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

The Rockchip USB2PHY glue driver improperly present itself as a
UCLASS_PHY driver, without ever implementing the required phy_ops.

This is something that in special circumstances can lead to a NULL
pointer dereference followed by a SError crash.

Change the glue driver to use UCLASS_NOP to fix this.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index 88b33de1b2a0..d6ce12b5e83d 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -538,7 +538,7 @@ U_BOOT_DRIVER(rockchip_usb2phy_clock) = {
 
 U_BOOT_DRIVER(rockchip_usb2phy) = {
 	.name	= "rockchip_usb2phy",
-	.id	= UCLASS_PHY,
+	.id	= UCLASS_NOP,
 	.of_match = rockchip_usb2phy_ids,
 	.probe = rockchip_usb2phy_probe,
 	.bind = rockchip_usb2phy_bind,
-- 
2.50.1

