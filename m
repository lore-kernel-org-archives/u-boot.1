Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC76C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 15:25:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA93A86F99;
	Sun, 12 Nov 2023 16:25:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="jDbKGc9k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B7E986E24; Sun, 12 Nov 2023 16:25:45 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92AF387044
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 16:25:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=d4dd=G2=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1699802732;
 bh=nmcCH3TLrfzhlaVjLEx0KpEBpLZBZHb6DkqPs+Uss2Y=;
 b=jDbKGc9kq6RE/TpFtKedu7+8VQ+2UDezp7+rasj3i+xr3F8WrgiHQuZic3UWKj/aZHtPsxqC9
 1h/XEBUclRg4gT/2J3sZiri2vy5v7HZOn24gGhUtWpmK+G6WMu2eRFSPr7twTzZolwM8qtw0Z5y
 DaSoy4SW8hPjv0mCb9pNyxlgzJtQvHatHhO2RIij4tzKO0hTdS2T1EFaISLqb5TZULtwon9LEHm
 KK0ZaScCsBQkXQ4KR+oO9RulgPRhgLNN3rtWUvxxJ09DbXr1fEaDiPY1hziFEsJ+naOUaWFxJXd
 iEe3P+ZPnCchN0yZsBbsba6JYoLI7R/WgEED8vEyM9iQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Marek Vasut <marex@denx.de>
Cc: Jonas Karlman <jonas@kwiboo.se>, Kever Yang
 <kever.yang@rock-chips.com>, u-boot@lists.denx.de
Subject: [PATCH v2] usb: dwc3-generic: Use combined glue and ctrl node for
 RK3588
Date: Sun, 12 Nov 2023 15:25:25 +0000
Message-ID: <20231112152527.1306793-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 6550ee6cea828730b5a5f760
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

Like Rockchip RK3328 and RK3568, the RK3588 also have a single node to
represent the glue and ctrl for USB 3.0.

Use rk_ops as driver data to select correct ctrl node for RK3588 DWC3.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
Changes in v2:
- Required device tree changes have been merged into master
- Collect r-b tag

The commit c1710bfc4fa0 ("rockchip: rk3588-rock-5b: Sync USB3 nodes from
mainline linux patches") changed DT to use nodes matching the upstreamed
dt-binding for DWC3 on RK3588. It is now safe to merge this patch.

 drivers/usb/dwc3/dwc3-generic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
index 744fde806948..6fb2de8a5ace 100644
--- a/drivers/usb/dwc3/dwc3-generic.c
+++ b/drivers/usb/dwc3/dwc3-generic.c
@@ -610,6 +610,7 @@ static const struct udevice_id dwc3_glue_ids[] = {
 	{ .compatible = "rockchip,rk3328-dwc3", .data = (ulong)&rk_ops },
 	{ .compatible = "rockchip,rk3399-dwc3" },
 	{ .compatible = "rockchip,rk3568-dwc3", .data = (ulong)&rk_ops },
+	{ .compatible = "rockchip,rk3588-dwc3", .data = (ulong)&rk_ops },
 	{ .compatible = "qcom,dwc3" },
 	{ .compatible = "fsl,imx8mp-dwc3", .data = (ulong)&imx8mp_ops },
 	{ .compatible = "fsl,imx8mq-dwc3" },
-- 
2.42.0

