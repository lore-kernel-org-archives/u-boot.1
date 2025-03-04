Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 193C6C021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 20:07:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 531CC80BAA;
	Tue,  4 Mar 2025 21:07:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28358807EE; Tue,  4 Mar 2025 21:07:29 +0100 (CET)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id 7B514807EE
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 21:07:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-CSE-ConnectionGUID: GICIEAUGRc2wy1OKRKDWYw==
X-CSE-MsgGUID: M1k3Dcf7SF24v2BHaPhZkg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie6.idc.renesas.com with ESMTP; 05 Mar 2025 05:07:26 +0900
Received: from rz-ub2404.betafive.net (unknown [10.226.93.7])
 by relmlir5.idc.renesas.com (Postfix) with ESMTP id 11D5E400B9FE;
 Wed,  5 Mar 2025 05:07:22 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
	u-boot@lists.denx.de
Subject: [PATCH 1/3] net: ravb: Add dependency on CONFIG_BITBANGMII
Date: Tue,  4 Mar 2025 20:07:07 +0000
Message-ID: <20250304200712.92514-2-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250304200712.92514-1-paul.barker.ct@bp.renesas.com>
References: <20250304200712.92514-1-paul.barker.ct@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The Renesas RAVB driver always requires bitbang MDIO bus support.

Fixes: 8ae51b6f324e ("net: ravb: Add Renesas Ethernet RAVB driver")
Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/net/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 1563404ca171..b9d8972ef08a 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -852,6 +852,7 @@ config RENESAS_ETHER_SWITCH
 config RENESAS_RAVB
 	bool "Renesas Ethernet AVB MAC"
 	depends on RCAR_64
+	select BITBANGMII
 	select PHYLIB
 	select PHY_ETHERNET_ID
 	help
-- 
2.43.0

