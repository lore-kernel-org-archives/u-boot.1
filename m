Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 513CACCF9EA
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 14:05:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A2F88352B;
	Mon, 27 Oct 2025 15:05:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ifkFZnS0";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="X8d0n/uI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4469D836B4; Mon, 27 Oct 2025 15:04:59 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0351C82E34
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 15:04:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cwFd45FVGz9sn0;
 Mon, 27 Oct 2025 15:04:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761573896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=iISJsJMacbIS/XcHKTCdppfGdy4YZsXLSRB05vs8lzM=;
 b=ifkFZnS0YIIUh3sSPS2Do25sTh8wTh/KB8KpvnsSs+/Q2ogWkOi/Vt3+Ndbk+MOQUvWZtF
 HhYIdnBEwA43gcGa0YRR9nuy7cANp5+IVLpP0IJostNR9OSeYRW6dpjmP2/2aPZmYLlPuo
 QulbixgdbUWeyroxGaJknJsUrOHqI5NSTQnkXZoLm5JDCb3k5kfZgrPmvElgBR7HnKNos8
 VW2f7z1uPMEZvQgIxl9oXXFTL3CYUZTjOePtuDx7UCh4wiilhASP04pDLNrJPkWboGKlb7
 BPaFtYVoM1ZSE1FwFC7txkxXZuq0b29Ti/fIXo6yCjOidCLmE0qoQWmMwnb2EA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b="X8d0n/uI";
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761573894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=iISJsJMacbIS/XcHKTCdppfGdy4YZsXLSRB05vs8lzM=;
 b=X8d0n/uIBbXOJPVoJRUBajvvMe0TyJMJ1SoMoPZTRNT/KXGdzkaHGDL2yxcZ8qWhccjgcT
 g3FSXKDfLUNIWuXQr8jFjFyDhAOgdI30ufNcFnzFHXhA5RWXU58BT1wkjdwhbkCYcWgjs7
 +FqUkdu4+5FyU6lJ30z8yT4qJJC33BrDKn8Mdh7tssopj4zQUf7CDDQ+8AtlT/f9DjpTde
 akPzUm/9E0G2YvSjo3dUSEfgfJYYKaRNd6HQVy0iebMyyM8Id29t3AVC7V73yBCPRXnrAC
 U4W7ONQMDIarts9g1nGV8s33SICtEFPxxMb/LTHb0LxYXoyx0kH3OOsvD5ENww==
To: u-boot@lists.denx.de
Cc: Thanh Quan <thanh.quan.xn@renesas.com>, Hai Pham <hai.pham.ud@renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Dominic Rath <rath@ibv-augsburg.net>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] net: phy: dp83869: fix STRAP_OPMODE bitmask
Date: Mon, 27 Oct 2025 15:03:58 +0100
Message-ID: <20251027140439.9044-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: ced68900c646548713d
X-MBO-RS-META: snohr53t1iicj6rees597qj3u8diyxid
X-Rspamd-Queue-Id: 4cwFd45FVGz9sn0
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

From: Thanh Quan <thanh.quan.xn@renesas.com>

According to the TI DP83869HM datasheet Revision D (June 2025), section
7.6.1.41 STRAP_STS Register, the STRAP_OPMODE bitmask is bit [11:9].
Fix this.

In case the PHY is auto-detected via PHY ID registers, or not described
in DT, or, in case the PHY is described in DT but the optional DT property
"ti,op-mode" is not present, then the driver reads out the PHY functional
mode (RGMII, SGMII, ...) from hardware straps.

Currently, all upstream users of this PHY specify both DT compatible string
"ethernet-phy-id2000.a0f1" and ti,op-mode = <DP83869_RGMII_COPPER_ETHERNET>
property, therefore it seems no upstream users are affected by this bug.

The driver currently interprets bits [2:0] of STRAP_STS register as PHY
functional mode. Those bits are controlled by ANEG_DIS, ANEGSEL_0 straps
and an always-zero reserved bit. Systems that use RGMII-to-Copper functional
mode are unlikely to disable auto-negotiation via ANEG_DIS strap, or change
auto-negotiation behavior via ANEGSEL_0 strap. Therefore, even with this bug
in place, the STRAP_STS register content is likely going to be interpreted
by the driver as RGMII-to-Copper mode.

However, for a system with PHY functional mode strapping set to other mode
than RGMII-to-Copper, the driver is likely to misinterpret the strapping
as RGMII-to-Copper and misconfigure the PHY.

For example, on a system with SGMII-to-Copper strapping, the STRAP_STS
register reads as 0x0c20, but the PHY ends up being configured for
incompatible RGMII-to-Copper mode.

Fixes: f3e22eea815d ("net: phy: add TI DP83869HM ethernet driver")
Signed-off-by: Thanh Quan <thanh.quan.xn@renesas.com>
Signed-off-by: Hai Pham <hai.pham.ud@renesas.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org> # Use FIELD_GET()
---
Cc: Dominic Rath <rath@ibv-augsburg.net>
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Thanh Quan <thanh.quan.xn@renesas.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: Update commit message to match Linux
---
 drivers/net/phy/dp83869.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/dp83869.c b/drivers/net/phy/dp83869.c
index b6fb5adae1f..c60fbf26a03 100644
--- a/drivers/net/phy/dp83869.c
+++ b/drivers/net/phy/dp83869.c
@@ -5,6 +5,7 @@
  */
 
 #include <phy.h>
+#include <linux/bitfield.h>
 #include <linux/compat.h>
 #include <malloc.h>
 
@@ -64,7 +65,7 @@
 #define DP83869_RGMII_RX_CLK_DELAY_EN		BIT(0)
 
 /* STRAP_STS1 bits */
-#define DP83869_STRAP_OP_MODE_MASK		GENMASK(2, 0)
+#define DP83869_STRAP_OP_MODE_MASK		GENMASK(11, 9)
 #define DP83869_STRAP_STS1_RESERVED		BIT(11)
 #define DP83869_STRAP_MIRROR_ENABLED		BIT(12)
 
@@ -168,7 +169,7 @@ static int dp83869_set_strapped_mode(struct phy_device *phydev)
 	if (val < 0)
 		return val;
 
-	dp83869->mode = val & DP83869_STRAP_OP_MODE_MASK;
+	dp83869->mode = FIELD_GET(DP83869_STRAP_OP_MODE_MASK, val);
 
 	return 0;
 }
-- 
2.51.0

