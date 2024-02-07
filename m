Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E8EEC4828F
	for <u-boot@archiver.kernel.org>; Wed,  7 Feb 2024 17:20:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33D1687D06;
	Wed,  7 Feb 2024 18:19:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MKC3S7sz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D1F387D0A; Wed,  7 Feb 2024 18:19:31 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C18D87D09
 for <u-boot@lists.denx.de>; Wed,  7 Feb 2024 18:19:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id BAAD9CE1AA9;
 Wed,  7 Feb 2024 17:19:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EA33EC43390;
 Wed,  7 Feb 2024 17:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1707326364;
 bh=sg6ADNDQXae/kHOKrFKVMQs3zZyy0tBSTOjm3d8Q+88=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=MKC3S7szo7hmyQzxJAhUgfQBRiRr+yuA1ENmJD3KVBsOQlgirgzWqBBqNW7/c7ux2
 cEuywcNhQVuuiP9c+Nw21kcATazDLBj49GD6zQ5NyS6/KQNJrMUZK7YA1paHrRk6ZT
 tDt8pGsUHD4RZzDudhEYerkKMvQWKn5uILJPApCmXs4hPTKlcLPU6UtsLSXQcPkNfT
 lt6eKZ5X5+N1jiD6RFZMgpntRfLc0ljDtuUGy68CDiv06UcO0ATDVFaYpNrjfhDsuC
 umIWf1afPCLjr+UqkoScEW0A+cHAMNb3EVBrbX8NJluCLELuHpcUZa6GpkpfgVXvRO
 4IIu0WxrLUpxw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id D5E38C4828F;
 Wed,  7 Feb 2024 17:19:23 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Thu, 08 Feb 2024 01:19:22 +0800
Subject: [PATCH v2 3/3] usb: ehci: Make usage of
 generic_{setup,shutdown}_phy_bulk() helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240208-ehci-v2-3-6bf084b7ffac@outlook.com>
References: <20240208-ehci-v2-0-6bf084b7ffac@outlook.com>
In-Reply-To: <20240208-ehci-v2-0-6bf084b7ffac@outlook.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707326360; l=1440;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=/ZXy+/JFQl5w+CVuHs0t22RB2/75bzpwupaCW19x1fw=;
 b=T0VGMv/rvxKay1BaPdI+fbid9E5WCGCyPOwpFMwM7O/uU+078PWnIop8x7HnkzKh9ocSaA/K8
 zug2MCKYLb4AcZn//LMD0/7jbcAqcsFIN85vZCNsda8lJ6JMoYF+DER
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received: by B4 Relay for forbidden405@outlook.com/20230724 with
 auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
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
Reply-To: forbidden405@outlook.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Yang Xiwen <forbidden405@outlook.com>

Replace generic_setup_phy() and generic_shutdown_phy() by respectively
generic_setup_phy_bulk() and generic_shutdown_phy_bulk().

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/usb/host/ehci-generic.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/ehci-generic.c b/drivers/usb/host/ehci-generic.c
index 936e30438d..e109d84d73 100644
--- a/drivers/usb/host/ehci-generic.c
+++ b/drivers/usb/host/ehci-generic.c
@@ -25,7 +25,7 @@ struct generic_ehci {
 	struct ehci_ctrl ctrl;
 	struct clk_bulk clocks;
 	struct reset_ctl_bulk resets;
-	struct phy phy;
+	struct phy_bulk phys;
 	struct udevice *vbus_supply;
 };
 
@@ -95,7 +95,7 @@ static int ehci_usb_probe(struct udevice *dev)
 	if (err)
 		goto reset_err;
 
-	err = generic_setup_phy(dev, &priv->phy, 0);
+	err = generic_setup_phy_bulk(dev, &priv->phys);
 	if (err)
 		goto regulator_err;
 
@@ -110,7 +110,7 @@ static int ehci_usb_probe(struct udevice *dev)
 	return 0;
 
 phy_err:
-	ret = generic_shutdown_phy(&priv->phy);
+	ret = generic_shutdown_phy_bulk(&priv->phys);
 	if (ret)
 		dev_err(dev, "failed to shutdown usb phy (ret=%d)\n", ret);
 
@@ -140,7 +140,7 @@ static int ehci_usb_remove(struct udevice *dev)
 	if (ret)
 		return ret;
 
-	ret = generic_shutdown_phy(&priv->phy);
+	ret = generic_shutdown_phy_bulk(&priv->phys);
 	if (ret)
 		return ret;
 

-- 
2.43.0

