Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D1FFF8855
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 15:50:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F3D78499C;
	Tue,  5 May 2026 17:49:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="2a34HIbi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF741848B8; Tue,  5 May 2026 15:58:04 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33A2C84669
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 15:58:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=5789c44b6=Charles.Perry@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1777989482; x=1809525482;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=5HfHCUsqgUvLFQs/0IJM2/VGA8MPjCzJ0K7c9j8KASU=;
 b=2a34HIbifB/UPBlS6AN/Rl/jJDj8oHWyzLUlVG1Q4f3Tbc08oYZvxgXX
 swrpByq/klkQbIluxmzpolay2WtydpqM+vzq1g24mWcIbQ1WZ1NFSRTbd
 YMk8ISiTnMrrZgIT78OnZxogsyIRfogmqtLc1Mp2pXc/oMOoM4X+R+/Vn
 pyB5uMk7Vgp/lWjXc8SRc+6v2r4EB/+PZ2j5SxSfznqEuv3yYD3/+td3k
 4AzNQUrmeeZzqWtP2KiglvFlbvjW4hXQXnObGNlDm/E518rOmPuqhnlaL
 9NJCAPAWgihfeQuI1q84jZzvGY1fS0qEL7kf2vjvGElMvEP3gxQbg6j58 Q==;
X-CSE-ConnectionGUID: s2JwSLIAQPq269J72tZXGA==
X-CSE-MsgGUID: z0lRj6ibRMWEg98mrjUB8g==
X-IronPort-AV: E=Sophos;i="6.23,217,1770620400"; d="scan'208";a="288428716"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 05 May 2026 06:58:00 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 5 May 2026 06:57:59 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 5 May 2026 06:57:59 -0700
From: Charles Perry <charles.perry@microchip.com>
To: <u-boot@lists.denx.de>
CC: Charles Perry <charles.perry@microchip.com>, Jerome Forissier
 <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>, Pranav Tilak
 <pranav.vinaytilak@amd.com>, Michal Simek <michal.simek@amd.com>
Subject: [PATCH] net: phy: mscc: add support for the VSC8572
Date: Tue, 5 May 2026 06:57:49 -0700
Message-ID: <20260505135750.3137160-1-charles.perry@microchip.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Tue, 05 May 2026 17:49:47 +0200
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

This is similar to the VSC8574 according to the Linux commit that adds
support for it [1].

This was tested on an HX1000 board with SGMII (PIC64-HX SoC which has a
GEM MAC).

[1]: https://lore.kernel.org/all/dfabe39a52efcd2cfff9358f271b8673143503b8.1480497966.git.neill.whillans@codethink.co.uk/

Signed-off-by: Charles Perry <charles.perry@microchip.com>
---
 drivers/net/phy/mscc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/phy/mscc.c b/drivers/net/phy/mscc.c
index 16387eea41b8..dd7a10047bbc 100644
--- a/drivers/net/phy/mscc.c
+++ b/drivers/net/phy/mscc.c
@@ -23,6 +23,7 @@
 #define PHY_ID_VSC8502			0x00070630
 #define PHY_ID_VSC8540                  0x00070760
 #define PHY_ID_VSC8541                  0x00070770
+#define PHY_ID_VSC8572			0x000704d0
 #define PHY_ID_VSC8574			0x000704a0
 #define PHY_ID_VSC8584                  0x000707c0
 
@@ -1623,6 +1624,16 @@ U_BOOT_PHY_DRIVER(vsc8541) = {
 	.shutdown = &genphy_shutdown,
 };
 
+U_BOOT_PHY_DRIVER(vsc8572) = {
+	.name = "Microsemi VSC8572",
+	.uid = PHY_ID_VSC8572,
+	.mask = 0x000ffff0,
+	.features = PHY_GBIT_FEATURES,
+	.config = &vsc8574_config,
+	.startup = &mscc_startup,
+	.shutdown = &genphy_shutdown,
+};
+
 U_BOOT_PHY_DRIVER(vsc8574) = {
 	.name = "Microsemi VSC8574",
 	.uid = PHY_ID_VSC8574,
-- 
2.47.3

