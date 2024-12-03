Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B273EE77166
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 00:00:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A11488EC9;
	Wed,  4 Dec 2024 01:00:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=riseup.net header.i=@riseup.net header.b="q2zlecED";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 818B18855C; Wed,  4 Dec 2024 00:30:11 +0100 (CET)
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0323894B2
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 00:30:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rhs@riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx0.riseup.net (Postfix) with ESMTPS id 4Y2xhY5k33z9xFG;
 Tue,  3 Dec 2024 23:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1733268605; bh=o5CsiH6PClHyWx5GSJW9uB29KvjpEm6SU1p8Jqwm3i4=;
 h=From:To:Cc:Subject:Date:From;
 b=q2zlecEDyxwNrlcBNX88ZIVM4CMpq+Tz6ne6gGbZ5UEK5DO0uK2+v4poKaObzJMKE
 TqldGUNXEZMqiLJwjSGdxLhEeyiuhaTND2ppZw/8INzWJ0876ng8V9gPgnI+It24lu
 Dez820SlPFNKTv598rXxOnxRxMrxpPAWEt3JoZEo=
X-Riseup-User-ID: 44065E5A5A7AECD344FFCCC7FDD04A91978BACEAFF6182EB859892A6E47D285B
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4Y2xhX3zp0zJmsQ;
 Tue,  3 Dec 2024 23:30:04 +0000 (UTC)
From: Rufus Segar <rhs@riseup.net>
To: u-boot@lists.denx.de
Cc: marex@denx.de, simon.k.r.goldschmidt@gmail.com,
 Rufus Segar <rufuss@carallon.com>, Rufus Segar <rufus.segar@carallon.com>
Subject: [PATCH] dwmac_socfpga: Add RGMII-ID support
Date: Tue,  3 Dec 2024 23:30:06 +0000
Message-ID: <20241203233006.42764-1-rhs@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 04 Dec 2024 01:00:24 +0100
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

From: Rufus Segar <rufuss@carallon.com>

This patch adds support for the "rgmii-id", "rgmii-rxid", and
"rgmii-txid" modes for the dwmac_socfpga driver.

Signed-off-by: Rufus Segar <rufus.segar@carallon.com>
---
 drivers/net/dwmac_socfpga.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/dwmac_socfpga.c b/drivers/net/dwmac_socfpga.c
index bba3fc4d34..dcaf4132c5 100644
--- a/drivers/net/dwmac_socfpga.c
+++ b/drivers/net/dwmac_socfpga.c
@@ -106,6 +106,9 @@ static int dwmac_socfpga_probe(struct udevice *dev)
 		modereg = SYSMGR_EMACGRP_CTRL_PHYSEL_ENUM_RMII;
 		break;
 	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
 		modereg = SYSMGR_EMACGRP_CTRL_PHYSEL_ENUM_RGMII;
 		break;
 	default:
-- 
2.47.1

