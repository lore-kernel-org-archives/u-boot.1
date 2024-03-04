Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D59C48BF6
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 16:30:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E651187FBF;
	Mon,  4 Mar 2024 17:30:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=odyssee-systemes.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B93387FC9; Mon,  4 Mar 2024 16:23:48 +0100 (CET)
Received: from 6.mo575.mail-out.ovh.net (6.mo575.mail-out.ovh.net
 [46.105.63.100])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF6CD87061
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 16:23:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=odyssee-systemes.fr
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=marjolaine.amate@odyssee-systemes.fr
Received: from director3.ghost.mail-out.ovh.net (unknown [10.108.9.217])
 by mo575.mail-out.ovh.net (Postfix) with ESMTP id 4TpMsr1PPzz191Q
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 15:23:44 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-k2lrb (unknown [10.110.168.40])
 by director3.ghost.mail-out.ovh.net (Postfix) with ESMTPS id D7A9F1FE9C
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 15:23:43 +0000 (UTC)
Received: from odyssee-systemes.fr ([37.59.142.96])
 by ghost-submission-6684bf9d7b-k2lrb with ESMTPSA
 id 2VWjLn/n5WUuGAEAN+LPag
 (envelope-from <marjolaine.amate@odyssee-systemes.fr>)
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 15:23:43 +0000
Authentication-Results: garm.ovh; auth=pass
 (GARM-96R0017ecd8a84-c598-435f-bdb6-5a51f3194ec4,
 39AFD32D46772808B9CB301A76AC3855EFE185A2)
 smtp.auth=marjolaine.amate@odyssee-systemes.fr
X-OVh-ClientIp: 194.146.15.143
From: Marjolaine Amate <marjolaine.amate@odyssee-systemes.fr>
To: u-boot@lists.denx.de
Subject: [PATCH] e1000: add support for i225-IT
Date: Mon,  4 Mar 2024 16:23:38 +0100
Message-ID: <20240304152338.93453-1-marjolaine.amate@odyssee-systemes.fr>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 16681333021343936937
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrheejgdejfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeforghrjhholhgrihhnvgcutehmrghtvgcuoehmrghrjhholhgrihhnvgdrrghmrghtvgesohguhihsshgvvgdqshihshhtvghmvghsrdhfrheqnecuggftrfgrthhtvghrnhepfeegteehvdekffeiieeivdeutdefgfegveegfeduledufeetheeugfeghfeugfejnecukfhppeduvdejrddtrddtrddupdduleegrddugeeirdduhedrudegfedpfeejrdehledrudegvddrleeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehmrghrjhholhgrihhnvgdrrghmrghtvgesohguhihsshgvvgdqshihshhtvghmvghsrdhfrhdpnhgspghrtghpthhtohepuddprhgtphhtthhopehuqdgsohhotheslhhishhtshdruggvnhigrdguvgdpoffvtefjohhsthepmhhoheejhedpmhhouggvpehsmhhtphhouhht
X-Mailman-Approved-At: Mon, 04 Mar 2024 17:30:21 +0100
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

This patch adds support for i225-IT in e1000 driver.
Add e1000_phy_igc.

Signed-off-by: Marjolaine Amate <marjolaine.amate@odyssee-systemes.fr>
---
 drivers/net/e1000.c | 15 ++++++++++++++-
 drivers/net/e1000.h |  2 ++
 include/pci_ids.h   |  2 ++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/net/e1000.c b/drivers/net/e1000.c
index 84a2a7cf90..4e7ba66677 100644
--- a/drivers/net/e1000.c
+++ b/drivers/net/e1000.c
@@ -116,6 +116,8 @@ static struct pci_device_id e1000_supported[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_I210_SERDES) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_I210_SERDES_FLASHLESS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_I210_1000BASEKX) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_I225_UNPROGRAMMED) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_I225_IT) },
 
 	{}
 };
@@ -1575,6 +1577,8 @@ e1000_set_mac_type(struct e1000_hw *hw)
 	case PCI_DEVICE_ID_INTEL_I210_SERDES:
 	case PCI_DEVICE_ID_INTEL_I210_SERDES_FLASHLESS:
 	case PCI_DEVICE_ID_INTEL_I210_1000BASEKX:
+	case PCI_DEVICE_ID_INTEL_I225_UNPROGRAMMED:
+	case PCI_DEVICE_ID_INTEL_I225_IT:
 		hw->mac_type = e1000_igb;
 		break;
 	default:
@@ -3258,7 +3262,8 @@ e1000_setup_copper_link(struct e1000_hw *hw)
 		if (ret_val)
 			return ret_val;
 	} else if (hw->phy_type == e1000_phy_m88 ||
-		hw->phy_type == e1000_phy_igb) {
+		hw->phy_type == e1000_phy_igb ||
+		hw->phy_type == e1000_phy_igc) {
 		ret_val = e1000_copper_link_mgp_setup(hw);
 		if (ret_val)
 			return ret_val;
@@ -4531,6 +4536,8 @@ e1000_get_phy_cfg_done(struct e1000_hw *hw)
 	case e1000_igb:
 		while (timeout) {
 			if (hw->mac_type == e1000_igb) {
+				if (hw->phy_type == e1000_phy_igc)
+					break;
 				if (E1000_READ_REG(hw, I210_EEMNGCTL) & cfg_mask)
 					break;
 			} else {
@@ -4769,6 +4776,7 @@ e1000_phy_reset(struct e1000_hw *hw)
 	case e1000_phy_igp_3:
 	case e1000_phy_ife:
 	case e1000_phy_igb:
+	case e1000_phy_igc:
 		ret_val = e1000_phy_hw_reset(hw);
 		if (ret_val)
 			return ret_val;
@@ -4834,6 +4842,9 @@ static int e1000_set_phy_type (struct e1000_hw *hw)
 	case I210_I_PHY_ID:
 		hw->phy_type = e1000_phy_igb;
 		break;
+	case I225_I_PHY_ID:
+		hw->phy_type = e1000_phy_igc;
+		break;
 		/* Fall Through */
 	default:
 		/* Should never have loaded on this device */
@@ -4941,6 +4952,8 @@ e1000_detect_gig_phy(struct e1000_hw *hw)
 	case e1000_igb:
 		if (hw->phy_id == I210_I_PHY_ID)
 			match = true;
+		if (hw->phy_id == I225_I_PHY_ID)
+			match = true;
 		break;
 	default:
 		DEBUGOUT("Invalid MAC type %d\n", hw->mac_type);
diff --git a/drivers/net/e1000.h b/drivers/net/e1000.h
index f788394da8..e1311126a3 100644
--- a/drivers/net/e1000.h
+++ b/drivers/net/e1000.h
@@ -212,6 +212,7 @@ typedef enum {
 	e1000_phy_igp_3,
 	e1000_phy_ife,
 	e1000_phy_igb,
+	e1000_phy_igc,
 	e1000_phy_bm,
 	e1000_phy_undefined = 0xFF
 } e1000_phy_type;
@@ -2420,6 +2421,7 @@ struct e1000_hw {
 #define BME1000_E_PHY_ID     0x01410CB0
 
 #define I210_I_PHY_ID		0x01410C00
+#define I225_I_PHY_ID		0x67C9DCC0
 
 /* Miscellaneous PHY bit definitions. */
 #define PHY_PREAMBLE			0xFFFFFFFF
diff --git a/include/pci_ids.h b/include/pci_ids.h
index b63bf45168..f1886c3a75 100644
--- a/include/pci_ids.h
+++ b/include/pci_ids.h
@@ -2710,6 +2710,8 @@
 #define PCI_DEVICE_ID_INTEL_I211_COPPER			0x1539
 #define PCI_DEVICE_ID_INTEL_I210_COPPER_FLASHLESS	0x157b
 #define PCI_DEVICE_ID_INTEL_I210_SERDES_FLASHLESS	0x157c
+#define PCI_DEVICE_ID_INTEL_I225_UNPROGRAMMED		0x15dF
+#define PCI_DEVICE_ID_INTEL_I225_IT			0x0d9f
 #define PCI_DEVICE_ID_INTEL_80960_RP	0x1960
 #define PCI_DEVICE_ID_INTEL_82840_HB	0x1a21
 #define PCI_DEVICE_ID_INTEL_82845_HB	0x1a30
-- 
2.43.0

