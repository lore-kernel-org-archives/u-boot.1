Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF3D8D358D1
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 07:52:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3F4C83B72;
	Thu, 29 Jan 2026 08:52:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=norik.com header.i=@norik.com header.b="P2yc/thM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 088FF83B91; Thu, 29 Jan 2026 08:52:55 +0100 (CET)
Received: from cp2.siel.si (cp2.siel.si [46.19.12.180])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 752AB83015
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 08:52:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=primoz.fiser@norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com; 
 s=default;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Rj/ZzdVl63WBQ5pVJf/hJKd7jvTWEE4c+UTPcIhFRPI=; b=P2yc/thMm4XbiWdv3XgA2iyCnV
 Gx4TNnfnMHtVteoLw7O43f+VWUmH3bz0NNWL+KeESc82Sy6iHljICglWFk/YKzK7qB9sLC80Sf0AG
 HIq9RPff/FJ+LOqtBB88eCnq8sYnLoHaiEZ+DOo7C+GqyB9SwttqbZQIjv3ZKeef0Dsjry4INR9YN
 MiLS/VQzT9r5Ny/YjH6Y0Qb7If1lGickd2FXChjEzvogRZgdD4uSmqQYqM0Ag3lcrUbodH4WwD2KA
 KHXjaGbxVvweQ30fD6TMy9PEg1AqL3tHTjz8z7jVqjGBwcs3ZvhrHn0DG805DzK7LoPvRejltfM0+
 aMP8pXbQ==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:41240
 helo=localhost.localdomain)
 by cp2.siel.si with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.1) (envelope-from <primoz.fiser@norik.com>)
 id 1vlMpg-0000000AIoH-0GZq; Thu, 29 Jan 2026 08:52:52 +0100
From: Primoz Fiser <primoz.fiser@norik.com>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome@forissier.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH] net: fec_mxc: Add support for i.MX91
Date: Thu, 29 Jan 2026 08:52:51 +0100
Message-Id: <20260129075251.3170179-1-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - cp2.siel.si
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cp2.siel.si: authenticated_id: primoz.fiser@norik.com
X-Authenticated-Sender: cp2.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
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

The i.MX91 SoC reuses the ENET FEC from i.MX93. Add all required driver
checks to make it work also on the i.MX91 based platforms.

Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
---
 drivers/net/Kconfig   | 2 +-
 drivers/net/fec_mxc.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 4fda1b0c28cf..eb6a1cab565d 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -423,7 +423,7 @@ config FEC_MXC_MDIO_BASE
 
 config FEC_MXC
 	bool "FEC Ethernet controller"
-	depends on MX28 || MX5 || MX6 || MX7 || IMX8 || IMX8M || IMX8ULP || IMX93 || VF610
+	depends on MX28 || MX5 || MX6 || MX7 || IMX8 || IMX8M || IMX8ULP || IMX91 || IMX93 || VF610
 	help
 	  This driver supports the 10/100 Fast Ethernet controller for
 	  NXP i.MX processors.
diff --git a/drivers/net/fec_mxc.c b/drivers/net/fec_mxc.c
index fee9973c4dc8..1c51e936b5be 100644
--- a/drivers/net/fec_mxc.c
+++ b/drivers/net/fec_mxc.c
@@ -594,7 +594,7 @@ static int fecmxc_init(struct udevice *dev)
 
 	/* Do not access reserved register */
 	if (!is_mx6ul() && !is_mx6ull() && !is_imx8() && !is_imx8m() && !is_imx8ulp() &&
-	    !is_imx93()) {
+	    !is_imx91() && !is_imx93()) {
 		/* clear MIB RAM */
 		for (i = mib_ptr; i <= mib_ptr + 0xfc; i += 4)
 			writel(0, i);
@@ -1236,7 +1236,7 @@ static int fecmxc_set_ref_clk(struct clk *clk_ref, phy_interface_t interface)
 		 interface == PHY_INTERFACE_MODE_RGMII_RXID ||
 		 interface == PHY_INTERFACE_MODE_RGMII_TXID) {
 		freq = 125000000;
-		if (is_imx93())
+		if (is_imx91() || is_imx93())
 			freq = freq << 1;
 	} else {
 		return -EINVAL;
-- 
2.34.1

