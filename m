Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86631C02183
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 14:10:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9958680717;
	Fri, 17 Jan 2025 15:10:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="XHRWxpLM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4615A806FB; Fri, 17 Jan 2025 07:14:17 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B27A8806D8
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 07:14:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737094455; x=1768630455;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=K2JKxmDBlmJ5/UYTxzGcJWsQQkLlsHJkNtAjaX+NcTw=;
 b=XHRWxpLMubzTvTgNDAsUG4vN0VDMC2ojQhbfzhlBxfciKv2+VSjsdQM3
 gNguFhAoMzdZOjqO0RhxJsl4DnpPUAZ6WUiWmhA4wFWKL2gXreraa9yLd
 BXtGsjVdRTi0sLhUi7XV4ZvOTIyMh7+hUihSmbqWxZW3nWQL+k136wrqM
 ad9ERvY+kx4cDfgkBamqeILlvDQV/dkcsPRLKtwWMS4v7aAAjxVbN92/4
 OSjQnfU29nJl1djsF/3wFG9nBsVxSbC4r+TcSzGEmf793ltN6sNqZm5i5
 EJktz+ci0mg46XWBwX1WCw2+Jc9kXLpDFp841+KC/fiz4yGqL0k5Dncdr g==;
X-CSE-ConnectionGUID: QPNw984oShGrhrvaQ3/+ug==
X-CSE-MsgGUID: 2znfO9aWSSaS6Ni2bB3OIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="48912167"
X-IronPort-AV: E=Sophos;i="6.13,211,1732608000"; d="scan'208";a="48912167"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jan 2025 22:14:14 -0800
X-CSE-ConnectionGUID: QtIiAcCWQ4S6+L0Ej7Rjuw==
X-CSE-MsgGUID: 1IWoUh0+SE220P0nbh+Y9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,211,1732608000"; d="scan'208";a="136564643"
Received: from apgcp0d551112.png.altera.com ([10.244.77.50])
 by orviesa002.jf.intel.com with ESMTP; 16 Jan 2025 22:14:09 -0800
From: Boon Khai Ng <boon.khai.ng@intel.com>
To: Uboot Open List <u-boot@lists.denx.de>
Cc: Tien Fong Chee <tien.fong.chee@intel.com>,
 Kok Kiang Hea <kok.kiang.hea@intel.com>,
 Dinesh Maniyam <dinesh.maniyam@intel.com>,
 Alif Zakuan <alif.zakuan.yuslaimi@intel.com>,
 Muhammad Hazim <muhammad.hazim.izzat.zamri@intel.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan <alif.zakuan.yuslaimi@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Muhammad Hazim <muhammad.hazim.izzat.zamri@altera.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Boon Khai Ng <boon.khai.ng@intel.com>
Subject: [config 2 support v1 1/1] net: dwc_eth_xgmac_socfpga: Add support for
 distinct mac-mode and phy mode.
Date: Fri, 17 Jan 2025 14:14:02 +0800
Message-Id: <20250117061402.31985-2-boon.khai.ng@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20250117061402.31985-1-boon.khai.ng@intel.com>
References: <20250117061402.31985-1-boon.khai.ng@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 17 Jan 2025 15:10:26 +0100
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

This patch adds support for configuring the ethernet MAC mode independently
from the PHY mode on our SoC FPGA board. Specifically, this is necessary
for a scenario where the ethernet controller MAC is connected to the
FPGA HVIO with a different GMII interface, and the FPGA output is routed
to the PHY using a RGMII interface.

To support this configuration, a mechanism is introduced to handle
separate MAC mode settings, ensuring that the MAC controller and PHY
can operate correctly with their respective interface modes.

If mac-mode is not defined, the MAC mode will default to the PHY mode,
ensuring compatibility and proper operation between the MAC and PHY.

Signed-off-by: Boon Khai Ng <boon.khai.ng@intel.com>
---
 drivers/net/dwc_eth_xgmac_socfpga.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dwc_eth_xgmac_socfpga.c b/drivers/net/dwc_eth_xgmac_socfpga.c
index 87fb7e887e..07315f289d 100644
--- a/drivers/net/dwc_eth_xgmac_socfpga.c
+++ b/drivers/net/dwc_eth_xgmac_socfpga.c
@@ -29,6 +29,25 @@
 
 #define SOCFPGA_XGMAC_SYSCON_ARG_COUNT 2
 
+phy_interface_t dwxgmac_of_get_mac_mode(struct udevice *dev)
+{
+	const char *mac_mode;
+	int i;
+
+	debug("%s(dev=%p):\n", __func__, dev);
+	mac_mode = dev_read_string(dev, "mac-mode");
+	if (!mac_mode)
+		return PHY_INTERFACE_MODE_NA;
+
+	if (mac_mode) {
+		for (i = 0; i < PHY_INTERFACE_MODE_MAX; i++) {
+			if (!strcmp(mac_mode, phy_interface_strings[i]))
+				return i;
+		}
+	}
+	return PHY_INTERFACE_MODE_NA;
+}
+
 static int dwxgmac_socfpga_do_setphy(struct udevice *dev, u32 modereg)
 {
 	struct xgmac_priv *xgmac = dev_get_priv(dev);
@@ -66,12 +85,17 @@ static int xgmac_probe_resources_socfpga(struct udevice *dev)
 	struct ofnode_phandle_args args;
 	void *range;
 	phy_interface_t interface;
+	phy_interface_t mac_mode;
 	int ret;
 	u32 modereg;
 
 	interface = xgmac->config->interface(dev);
+	mac_mode = dwxgmac_of_get_mac_mode(dev);
+
+	if (mac_mode == PHY_INTERFACE_MODE_NA)
+		mac_mode = interface;
 
-	switch (interface) {
+	switch (mac_mode) {
 	case PHY_INTERFACE_MODE_MII:
 	case PHY_INTERFACE_MODE_GMII:
 		modereg = SYSMGR_EMACGRP_CTRL_PHYSEL_ENUM_GMII_MII;
-- 
2.26.2

