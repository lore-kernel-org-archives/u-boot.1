Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 093E7C369AB
	for <u-boot@archiver.kernel.org>; Mon, 21 Apr 2025 16:52:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8075A815D1;
	Mon, 21 Apr 2025 18:51:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bosc.ac.cn
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17D6981E72; Mon, 21 Apr 2025 11:08:44 +0200 (CEST)
Received: from out28-113.mail.aliyun.com (out28-113.mail.aliyun.com
 [115.124.28.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76A3A81E1F
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 11:08:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=bosc.ac.cn
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=zhangzhijie@bosc.ac.cn
Received: from aliyun.com(mailfrom:zhangzhijie@bosc.ac.cn
 fp:SMTPD_---.cSdfg8._1745226509 cluster:ay29) by smtp.aliyun-inc.com;
 Mon, 21 Apr 2025 17:08:30 +0800
From: zhangzhijie <zhangzhijie@bosc.ac.cn>
To: zhangzhijie@bosc.ac.cn,
	joe.hershberger@ni.com,
	trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [PATCH] eth: Support E1000E I225-V
Date: Mon, 21 Apr 2025 17:08:26 +0800
Message-Id: <20250421090826.3126977-1-zhangzhijie@bosc.ac.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 21 Apr 2025 18:51:44 +0200
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

From: "ZhiJie.zhang" <zhangzhijie@bosc.ac.cn>

1. Add pcie device id 0x15f3
2. Add IIC phy id 0x67C9DC00

Signed-off-by: ZhiJie.Zhang <zhangzhijie@bosc.ac.cn>
---
 drivers/net/e1000.c | 5 +++++
 drivers/net/e1000.h | 1 +
 include/pci_ids.h   | 1 +
 3 files changed, 7 insertions(+)

diff --git a/drivers/net/e1000.c b/drivers/net/e1000.c
index b77298070f8..1c8767dbea2 100644
--- a/drivers/net/e1000.c
+++ b/drivers/net/e1000.c
@@ -121,6 +121,7 @@ static struct pci_device_id e1000_supported[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_I210_1000BASEKX) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_I225_UNPROGRAMMED) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_I225_IT) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_I225_V) },
 
 	{}
 };
@@ -1588,6 +1589,7 @@ e1000_set_mac_type(struct e1000_hw *hw)
 	case PCI_DEVICE_ID_INTEL_I210_1000BASEKX:
 	case PCI_DEVICE_ID_INTEL_I225_UNPROGRAMMED:
 	case PCI_DEVICE_ID_INTEL_I225_IT:
+	case PCI_DEVICE_ID_INTEL_I225_V:
 		hw->mac_type = e1000_igb;
 		break;
 	default:
@@ -4852,6 +4854,7 @@ static int e1000_set_phy_type (struct e1000_hw *hw)
 		hw->phy_type = e1000_phy_igb;
 		break;
 	case I225_I_PHY_ID:
+	case I225_V_PHY_ID:
 	case I226_LM_PHY_ID:
 	case I226_I_PHY_ID:
 		hw->phy_type = e1000_phy_igc;
@@ -4965,6 +4968,8 @@ e1000_detect_gig_phy(struct e1000_hw *hw)
 			match = true;
 		if (hw->phy_id == I225_I_PHY_ID)
 			match = true;
+		if (hw->phy_id == I225_V_PHY_ID)
+			match = true;
 		if (hw->phy_id == I226_LM_PHY_ID)
 			match = true;
 		if (hw->phy_id == I226_I_PHY_ID)
diff --git a/drivers/net/e1000.h b/drivers/net/e1000.h
index 5ca720f4609..cf8bd750757 100644
--- a/drivers/net/e1000.h
+++ b/drivers/net/e1000.h
@@ -2420,6 +2420,7 @@ struct e1000_hw {
 #define I226_LM_PHY_ID		0x67C9DC10
 #define I225_I_PHY_ID		0x67C9DCC0
 #define I226_I_PHY_ID		0x67C9DCD0
+#define I225_V_PHY_ID		0x67C9DC00
 
 /* Miscellaneous PHY bit definitions. */
 #define PHY_PREAMBLE			0xFFFFFFFF
diff --git a/include/pci_ids.h b/include/pci_ids.h
index a8939b105f1..cfff275daba 100644
--- a/include/pci_ids.h
+++ b/include/pci_ids.h
@@ -2725,6 +2725,7 @@
 #define PCI_DEVICE_ID_INTEL_I210_SERDES_FLASHLESS	0x157c
 #define PCI_DEVICE_ID_INTEL_I225_UNPROGRAMMED		0x15fd
 #define PCI_DEVICE_ID_INTEL_I225_IT			0x0d9f
+#define PCI_DEVICE_ID_INTEL_I225_V			0x15f3
 #define PCI_DEVICE_ID_INTEL_80960_RP	0x1960
 #define PCI_DEVICE_ID_INTEL_82840_HB	0x1a21
 #define PCI_DEVICE_ID_INTEL_82845_HB	0x1a30
-- 
2.34.1

