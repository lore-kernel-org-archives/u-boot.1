Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B36CE87859
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 19:29:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D57D783CBD;
	Tue,  3 Feb 2026 20:29:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="wFpPFHdO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D60E83CEA; Tue,  3 Feb 2026 20:03:53 +0100 (CET)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBF2E83C39
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 20:03:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=48729a07b=Charles.Perry@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1770145429; x=1801681429;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=4Ia2B1s0lUxcr5Cd6PzqPKHTaDGXBO6tq7lNgt/rmWY=;
 b=wFpPFHdO91HvD2rT/l0elKwWZEBPncaS18A+Q4q3bfzCtMMxIsNS9HT+
 7MjzdUb/LXDfBQMQNL+nDFxrhClU6+MDoiUwW39PnG3ng0KKhd6kzSn/A
 NCKFrFQGiECr5YJjUc275pJSQLfmJka0wn4tpGoi1maqC5Iw3sgQlOTcB
 VBSk3Fk3PCvkQcZ1yILpp9SorJFFxpo0EjK41Dr8yHiVjB4yRySADDf0G
 htHddSKOIrZ+Z+quaZfFMzOoMte8JDkbz6YWw0U8NiVAoA9Hk2ngfZVqs
 PVoG326aN5wU+MR3li9RD7u9W3b3JAXF3fD/a1HIU7Ej4v3Jc1tCWQcaR A==;
X-CSE-ConnectionGUID: /gLRmsdJTkCbiIASZzG40A==
X-CSE-MsgGUID: OIj4jq7hQMChlkZ9S7jpAA==
X-IronPort-AV: E=Sophos;i="6.21,271,1763449200"; d="scan'208";a="52857529"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 03 Feb 2026 12:03:47 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 3 Feb 2026 12:03:33 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 3 Feb 2026 12:03:32 -0700
From: Charles Perry <charles.perry@microchip.com>
To: <u-boot@lists.denx.de>
CC: Charles Perry <charles.perry@microchip.com>, Joe Hershberger
 <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, "Jerome
 Forissier" <jerome@forissier.org>, Tom Rini <trini@konsulko.com>, "John
 Haechten" <john.haechten@microsemi.com>
Subject: [PATCH] net: phy: mscc: allow RGMII with internal delay for the
 VSC8541
Date: Tue, 3 Feb 2026 11:01:40 -0800
Message-ID: <20260203190141.340164-1-charles.perry@microchip.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Tue, 03 Feb 2026 20:29:12 +0100
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

Add the missing RGMII modes with internal delay for the VSC8541.

Fixes: a5fd13ad1913 ("net: phy: MSCC Add Support for VSC8530-VSC8531-VSC8540-VSC8541")
Signed-off-by: Charles Perry <charles.perry@microchip.com>
---
 drivers/net/phy/mscc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/phy/mscc.c b/drivers/net/phy/mscc.c
index bd9cd952975..7263887b9ce 100644
--- a/drivers/net/phy/mscc.c
+++ b/drivers/net/phy/mscc.c
@@ -1371,6 +1371,9 @@ static int vsc8541_config(struct phy_device *phydev)
 	case PHY_INTERFACE_MODE_GMII:
 	case PHY_INTERFACE_MODE_RMII:
 	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+	case PHY_INTERFACE_MODE_RGMII_ID:
 		retval = vsc8531_vsc8541_mac_config(phydev);
 		if (retval != 0)
 			return retval;
-- 
2.47.3

