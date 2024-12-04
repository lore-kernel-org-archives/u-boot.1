Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A2EE7716D
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 16:32:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69A7889729;
	Wed,  4 Dec 2024 17:32:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=riseup.net header.i=@riseup.net header.b="CgaEzY35";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76560896C8; Wed,  4 Dec 2024 12:21:39 +0100 (CET)
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0747889353
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 12:21:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rhs@riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx1.riseup.net (Postfix) with ESMTPS id 4Y3FTT5s6lzDqdq;
 Wed,  4 Dec 2024 11:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1733311293; bh=sPOydY2AqScl86kf4p1e1qemzqLJCMBf/KgiXhTglZ4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CgaEzY35OxFhuNexSWmau1CKiN/8CVasYxx0NIiD7zM6eu083/vGWBstudDKfFzf3
 MPuYmRpDuxuYr9HVwLQ3aGzkCxmZF5q+uoDI4KFauw1AZtbAdsZdgnJdrDHdwBJwmZ
 uQV1EkG/khRooEKZt7R9Ff02xd8Ln/Z9TfvurgHI=
X-Riseup-User-ID: C23C4766080D8E36F59F922E04BE2301F84194A070861705CD333E4F953FC205
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4Y3FTS3SGPzJq7D;
 Wed,  4 Dec 2024 11:21:32 +0000 (UTC)
From: Rufus Segar <rhs@riseup.net>
To: u-boot@lists.denx.de
Cc: marex@denx.de, simon.k.r.goldschmidt@gmail.com, rufus.segar@carallon.com,
 Rufus Segar <rhs@riseup.net>
Subject: [PATCH V3] net: designware: socfpga: Add RGMII-ID support
Date: Wed,  4 Dec 2024 11:21:27 +0000
Message-ID: <20241204112127.3008702-1-rhs@riseup.net>
In-Reply-To: <ea18dd21-1251-455e-8456-09098414c1dd@denx.de>
References: <ea18dd21-1251-455e-8456-09098414c1dd@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 04 Dec 2024 17:31:58 +0100
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

This patch adds support for the "rgmii-id", "rgmii-rxid", and
"rgmii-txid" modes for the dwmac_socfpga driver.

Signed-off-by: Rufus Segar <rhs@riseup.net>
---
Changes for V2: Added signed-off-by line
Changes for V3: Changes subject prefix to "net: designware: socfpga:"

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
2.47.0

