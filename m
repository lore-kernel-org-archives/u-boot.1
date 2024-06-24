Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0179C2BD09
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 21:07:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7C95884D4;
	Mon, 24 Jun 2024 23:05:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=odyssee-systemes.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA716883FA; Mon, 24 Jun 2024 21:15:43 +0200 (CEST)
Received: from 7.mo560.mail-out.ovh.net (7.mo560.mail-out.ovh.net
 [188.165.48.182])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C60B6883AF
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 21:15:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=odyssee-systemes.fr
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=marjolaine.amate@odyssee-systemes.fr
Received: from director4.ghost.mail-out.ovh.net (unknown [10.108.2.201])
 by mo560.mail-out.ovh.net (Postfix) with ESMTP id 4W7Hjn1mGdz1FyN
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 19:15:41 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-rndwq (unknown [10.108.54.198])
 by director4.ghost.mail-out.ovh.net (Postfix) with ESMTPS id D5D931FE53;
 Mon, 24 Jun 2024 19:15:40 +0000 (UTC)
Received: from odyssee-systemes.fr ([37.59.142.103])
 by ghost-submission-6684bf9d7b-rndwq with ESMTPSA
 id sjXdLtzFeWb8+QEAq5R9cg
 (envelope-from <marjolaine.amate@odyssee-systemes.fr>);
 Mon, 24 Jun 2024 19:15:40 +0000
Authentication-Results: garm.ovh; auth=pass
 (GARM-103G00520aad82a-6044-4f0d-9ba9-743e58829730,
 F6C0AEFBAD486127301FF0EA271F04B174220FCD)
 smtp.auth=marjolaine.amate@odyssee-systemes.fr
X-OVh-ClientIp: 194.146.15.227
From: Marjolaine Amate <marjolaine.amate@odyssee-systemes.fr>
To: u-boot@lists.denx.de
Cc: Marjolaine Amate <marjolaine.amate@odyssee-systemes.fr>
Subject: [PATCH] e1000: add support for i226
Date: Mon, 24 Jun 2024 19:15:32 +0000
Message-ID: <20240624191532.57693-1-marjolaine.amate@odyssee-systemes.fr>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 14257551999394116081
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrfeeguddgudefjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepofgrrhhjohhlrghinhgvucetmhgrthgvuceomhgrrhhjohhlrghinhgvrdgrmhgrthgvsehougihshhsvggvqdhshihsthgvmhgvshdrfhhrqeenucggtffrrghtthgvrhhnpeekjeeuteevhfdukeduvdeiffelfeffvdefffeggeffvdelgeejfedtjeeltdekffenucfkphepuddvjedrtddrtddruddpudelgedrudegiedrudehrddvvdejpdefjedrheelrddugedvrddutdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehmrghrjhholhgrihhnvgdrrghmrghtvgesohguhihsshgvvgdqshihshhtvghmvghsrdhfrhdpnhgspghrtghpthhtohepuddprhgtphhtthhopehuqdgsohhotheslhhishhtshdruggvnhigrdguvgdpoffvtefjohhsthepmhhoheeitddpmhhouggvpehsmhhtphhouhht
X-Mailman-Approved-At: Mon, 24 Jun 2024 23:05:18 +0200
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

This patch adds support for Intel Foxville I226
devices LM,V,I,K in e1000 driver.

Signed-off-by: Marjolaine Amate <marjolaine.amate@odyssee-systemes.fr>
---
 drivers/net/e1000.c | 18 ++++++++++++++++++
 drivers/net/e1000.h |  2 ++
 include/pci_ids.h   |  7 +++++++
 3 files changed, 27 insertions(+)

diff --git a/drivers/net/e1000.c b/drivers/net/e1000.c
index 4e7ba66677..f9803b92b0 100644
--- a/drivers/net/e1000.c
+++ b/drivers/net/e1000.c
@@ -108,6 +108,12 @@ static struct pci_device_id e1000_supported[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_80003ES2LAN_SERDES_DPT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_80003ES2LAN_COPPER_SPT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_80003ES2LAN_SERDES_SPT) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_I226_K) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_I226_LMVP) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_I226_LM) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_I226_V) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_I226_IT) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_I226_UNPROGRAMMED) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_I210_UNPROGRAMMED) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_I211_UNPROGRAMMED) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_I210_COPPER) },
@@ -1569,6 +1575,12 @@ e1000_set_mac_type(struct e1000_hw *hw)
 	case E1000_DEV_ID_ICH8_IGP_M:
 		hw->mac_type = e1000_ich8lan;
 		break;
+	case PCI_DEVICE_ID_INTEL_I226_K:
+	case PCI_DEVICE_ID_INTEL_I226_LMVP:
+	case PCI_DEVICE_ID_INTEL_I226_LM:
+	case PCI_DEVICE_ID_INTEL_I226_V:
+	case PCI_DEVICE_ID_INTEL_I226_IT:
+	case PCI_DEVICE_ID_INTEL_I226_UNPROGRAMMED:
 	case PCI_DEVICE_ID_INTEL_I210_UNPROGRAMMED:
 	case PCI_DEVICE_ID_INTEL_I211_UNPROGRAMMED:
 	case PCI_DEVICE_ID_INTEL_I210_COPPER:
@@ -4843,6 +4855,8 @@ static int e1000_set_phy_type (struct e1000_hw *hw)
 		hw->phy_type = e1000_phy_igb;
 		break;
 	case I225_I_PHY_ID:
+	case I226_LM_PHY_ID:
+	case I226_I_PHY_ID:
 		hw->phy_type = e1000_phy_igc;
 		break;
 		/* Fall Through */
@@ -4954,6 +4968,10 @@ e1000_detect_gig_phy(struct e1000_hw *hw)
 			match = true;
 		if (hw->phy_id == I225_I_PHY_ID)
 			match = true;
+		if (hw->phy_id == I226_LM_PHY_ID)
+			match = true;
+		if (hw->phy_id == I226_I_PHY_ID)
+			match = true;
 		break;
 	default:
 		DEBUGOUT("Invalid MAC type %d\n", hw->mac_type);
diff --git a/drivers/net/e1000.h b/drivers/net/e1000.h
index e1311126a3..aa649328f5 100644
--- a/drivers/net/e1000.h
+++ b/drivers/net/e1000.h
@@ -2421,7 +2421,9 @@ struct e1000_hw {
 #define BME1000_E_PHY_ID     0x01410CB0
 
 #define I210_I_PHY_ID		0x01410C00
+#define I226_LM_PHY_ID		0x67C9DC10
 #define I225_I_PHY_ID		0x67C9DCC0
+#define I226_I_PHY_ID		0x67C9DCD0
 
 /* Miscellaneous PHY bit definitions. */
 #define PHY_PREAMBLE			0xFFFFFFFF
diff --git a/include/pci_ids.h b/include/pci_ids.h
index f1886c3a75..834ec926b5 100644
--- a/include/pci_ids.h
+++ b/include/pci_ids.h
@@ -2701,6 +2701,11 @@
 #define PCI_DEVICE_ID_INTEL_82441	0x1237
 #define PCI_DEVICE_ID_INTEL_82380FB	0x124b
 #define PCI_DEVICE_ID_INTEL_82439	0x1250
+#define PCI_DEVICE_ID_INTEL_I226_LM			0x125b
+#define PCI_DEVICE_ID_INTEL_I226_V			0x125c
+#define PCI_DEVICE_ID_INTEL_I226_IT			0x125d
+#define PCI_DEVICE_ID_INTEL_I221_V			0x125e
+#define PCI_DEVICE_ID_INTEL_I226_UNPROGRAMMED		0x125f
 #define PCI_DEVICE_ID_INTEL_I210_UNPROGRAMMED		0x1531
 #define PCI_DEVICE_ID_INTEL_I211_UNPROGRAMMED		0x1532
 #define PCI_DEVICE_ID_INTEL_I210_COPPER			0x1533
@@ -2930,6 +2935,7 @@
 #define PCI_DEVICE_ID_INTEL_LYNNFIELD_MC_CH2_ADDR_REV2  0x2db1
 #define PCI_DEVICE_ID_INTEL_LYNNFIELD_MC_CH2_RANK_REV2  0x2db2
 #define PCI_DEVICE_ID_INTEL_LYNNFIELD_MC_CH2_TC_REV2    0x2db3
+#define PCI_DEVICE_ID_INTEL_I226_K	0x3102
 #define PCI_DEVICE_ID_INTEL_82855PM_HB	0x3340
 #define PCI_DEVICE_ID_INTEL_IOAT_TBG4	0x3429
 #define PCI_DEVICE_ID_INTEL_IOAT_TBG5	0x342a
@@ -3001,6 +3007,7 @@
 #define PCI_DEVICE_ID_INTEL_UNC_R3QPI1	0x3c45
 #define PCI_DEVICE_ID_INTEL_JAKETOWN_UBOX	0x3ce0
 #define PCI_DEVICE_ID_INTEL_IOAT_SNB	0x402f
+#define PCI_DEVICE_ID_INTEL_I226_LMVP	0x5503
 #define PCI_DEVICE_ID_INTEL_5100_16	0x65f0
 #define PCI_DEVICE_ID_INTEL_5100_19	0x65f3
 #define PCI_DEVICE_ID_INTEL_5100_21	0x65f5
-- 
2.43.0

