Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03EF0C46CD2
	for <u-boot@archiver.kernel.org>; Sun, 28 Jan 2024 01:20:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D941A880E7;
	Sun, 28 Jan 2024 02:20:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="BQQXeGWA";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="TI7B9UmH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0D8988135; Sun, 28 Jan 2024 02:20:22 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48F3188093
 for <u-boot@lists.denx.de>; Sun, 28 Jan 2024 02:20:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4TMtsH6JDtz9sV3;
 Sun, 28 Jan 2024 02:20:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1706404819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Z6ANC1vf3NafOUKDiresf6K4An2JTSSMTM8eiQoWupQ=;
 b=BQQXeGWArr49lxUEUEWV/l8TGa2jrCi6p8kwtyfmzsob1cwEDdpt3IeZbi7FXqhhwimCbN
 cYO7zsqLCKmZva3IrzjwjWuwIcw8u/ZgcteZH2FM2ajQH0n7k7hKhkp1i/+OdfaO232j+s
 cKGNGR0K96ZJeTM5fD01BIImomJGEoP9Cb2W0TeZxTfspMJHKzyhdGrvpZKeNBx/Qt0Cie
 YEwZrMrbAiStldkxP5M+sr0U8W2f3xiNsUUQIcuye8T17zo0CF2l7BXxzl79NoYcUGUqL9
 KlFeVMzM1rAJrBu6MnFD46SckhbLhOD18W5nILSJdmbXIqFBTkSmwt7ZmPQrJA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1706404818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Z6ANC1vf3NafOUKDiresf6K4An2JTSSMTM8eiQoWupQ=;
 b=TI7B9UmHjBLBwRPkRj175WI9am1qKwxkK2jr5c/bazZyLVVcZ3tqIXM4WpDug7gVs4Lp/V
 MKZl6OKD25t/szpYG59E88ouCAQCDXCAfC0xWGDexoVjzRVppvNhVTdldf3XLScFzqTAUO
 dD/r9qM+ag/v3xxUOqkwyEgW2GCiN9P2XDcB4OVeR0gpl/iHk8K5TePiCYkkLgfGtsNyxT
 pJHSpCLS41BOAVk6nCY5GioA0Cm3wT2bWK35oKmiDme/TsGVQ+cr+z+pvNTFO22xU2y+VQ
 DQjAanfJgvRo3Yt+2gHGjGZP1prFVRdk1oUnojUDxAGH5qiUeK3waY7Nk7EnmQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v2] net: phy: Use PHY MDIO address from DT if available
Date: Sun, 28 Jan 2024 02:19:40 +0100
Message-ID: <20240128011959.59995-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: ef5e10c1dd42f0ca03e
X-MBO-RS-META: rznf1fq5onyjukkfag177w6rsjcaxmib
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

In case the PHY is fully described in DT, use PHY MDIO address
from DT directly instead of always using auto-detection. This
also fixes the behavior of 'mdio list' in such DT setup, which
now prints the PHY connected to the MAC correctly.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
---
V2: This patch is generic replacement for
    - net: ravb: Use PHY MDIO address from DT if available
    - net: sh_eth: Use PHY MDIO address from DT if available
---
 drivers/net/phy/ethernet_id.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/phy/ethernet_id.c b/drivers/net/phy/ethernet_id.c
index 877a51c3d00..6cb1fd4453e 100644
--- a/drivers/net/phy/ethernet_id.c
+++ b/drivers/net/phy/ethernet_id.c
@@ -71,6 +71,9 @@ struct phy_device *phy_connect_phy_id(struct mii_dev *bus, struct udevice *dev,
 		}
 	}
 
+	if (phyaddr == -1)
+		phyaddr = ofnode_read_u32_default(phandle_args.node, "reg", -1);
+
 	id =  vendor << 16 | device;
 	phydev = phy_device_create(bus, phyaddr, id, false);
 	if (phydev)
-- 
2.43.0

