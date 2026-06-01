Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53F8ACD5BD1
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 12:12:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89CBA849BB;
	Mon,  1 Jun 2026 14:07:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="aV0ZN15P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A952A846D3; Mon,  1 Jun 2026 11:02:22 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFC9A80433
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 11:02:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.stein@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=Ll3Tj59QjnWm3vH9lRq41h2ryl+UgU0IswDq9Lt65ag=; b=aV0ZN15PiS8WS+oKlnOz/wmBsd
 bWv3kgQ9tFFIV6xas7xJXCUJxVnw21dEgTcArqdm4AlnlmvNmAXJOothJ5Bm7DKWvrTrpAr4ezqHO
 cG3TA3FIfoqfyXnS/mGCTw72MhgYVOoWOgk8+VwmFXiTeV6+YzmMx671lrU0dyma4HO5NiE1nFqgV
 9SVF+ZcvAYE1OizMM8Ink2ByJpBQHlAoqdd3ZxpfhsU9bn6+wvqMWF6OSNV8uzn99OOCjAauxWEgv
 J2vr3tPAGoHTOA1HUrExAYcoDEC7bZvaicLBzysxst8mUA8aX/3crXj/eZ8SWiARtdUF8Qkq53U5f
 B+WnCy6Q==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <alexander.stein@ew.tq-group.com>)
 id 1wTyXM-000Ayv-0Y; Mon, 01 Jun 2026 11:02:20 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy04.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <alexander.stein@ew.tq-group.com>)
 id 1wTyXS-000BJ5-15; Mon, 01 Jun 2026 11:02:26 +0200
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>
Cc: Markus Niebel <Markus.Niebel@tq-group.com>, u-boot@lists.denx.de,
 Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: [PATCH 1/1] net: phy: dp83867: enable extended read / write for driver
Date: Mon,  1 Jun 2026 11:02:16 +0200
Message-ID: <20260601090217.333747-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 01 Jun 2026 14:07:04 +0200
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

From: Markus Niebel <Markus.Niebel@tq-group.com>

Add a wrapper to implement ext_read / write using phy_[read,write]_mmd.

Check if devad is the only supported extended MMD address on this PHY.

Signed-off-by: Markus Niebel <Markus.Niebel@tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/net/phy/dp83867.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
index ebed61de133..34c871857e1 100644
--- a/drivers/net/phy/dp83867.c
+++ b/drivers/net/phy/dp83867.c
@@ -126,6 +126,22 @@ struct dp83867_private {
 	bool sgmii_ref_clk_en;
 };
 
+static int dp83867_phy_extread(struct phy_device *phydev,
+			       int addr, int devad, int reg)
+{
+	if (devad != DP83867_DEVADDR)
+		return -EINVAL;
+	return phy_read_mmd(phydev, devad, addr);
+};
+
+static int dp83867_phy_extwrite(struct phy_device *phydev, int addr,
+				int devad, int reg, u16 val)
+{
+	if (devad != DP83867_DEVADDR)
+		return -EINVAL;
+	return phy_write_mmd(phydev, devad, addr, (u32)val);
+};
+
 static int dp83867_config_port_mirroring(struct phy_device *phydev)
 {
 	struct dp83867_private *dp83867 =
@@ -410,4 +426,6 @@ U_BOOT_PHY_DRIVER(dp83867) = {
 	.config = &dp83867_config,
 	.startup = &genphy_startup,
 	.shutdown = &genphy_shutdown,
+	.readext = dp83867_phy_extread,
+	.writeext = dp83867_phy_extwrite,
 };
-- 
2.43.0

