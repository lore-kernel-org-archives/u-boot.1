Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E2EC3DA49
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 12:46:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C065188C4C;
	Sat, 20 Jul 2024 14:43:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="vNDOPQTF";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="JTtguwBs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D41D288C7F; Sat, 20 Jul 2024 14:43:53 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51E4388C67
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 14:43:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4WR5ng0DHrz9sSs;
 Sat, 20 Jul 2024 14:43:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YCKKTGIBc8xAgEdt/2XUOW6r1tvfb2n7hYTwZxtZb8o=;
 b=vNDOPQTFN57udfmEhrqgUrK8p4Y0GC6Ec+JjcjqXZrKtchUqSPRjd9OVhodlX823MX8AX8
 pQ/vJs5NPxUs12OycqGJXOOrgjGe3lHM7UKIuZXuweKpmPZD1ioox8UCzNr70Wv16NYxyL
 WS9A8sHlAmS0CDCXkgJDWwGu4Ybz636KrdJdFAazjFRRwp/sv8g03eC4kv7Mlq7G3BWMQ7
 HSck1qcidutxpf9q7sRGh6I6T+HJ1bEp4Covyie0btZq3xmFeGGA455NQlVv26ef2w1GIg
 cjsTpvJbhsl7AtBrqyvAGr4vkBk87DrSFtfF1yuqIqau7031SblGK1e+5YUeJQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YCKKTGIBc8xAgEdt/2XUOW6r1tvfb2n7hYTwZxtZb8o=;
 b=JTtguwBstb2HzYROMpzF6aE3kYz8KJeP3SLTWW4AM15pCONLLrEhIaX+GqXyiBtg2kJWP+
 VuY750YAnqM4mVGIApDbNkp4HWtcSHCfUGgMY9UZfo2OUzko82VSNBe+nQmO/LIBAZTKpS
 eBhBWh6FEz55J7SK0nkDh9OfThnOUSWedDTMlUhgbDI5AcWBOLxFJy/xyEpvPL2UUcqtuq
 txyR2lzMPGUs3nQl/yqcDjjubw7whDw0Q/hgQvejX2YcKhgcLXyptK/ELBKIDAgE6dN0Uf
 ExXnaBcU/rOW2LJ5/30lwHP1U0gWj63rlG0LsUcNB3kc3cren60bfNJcSdPMKw==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 20/40] drivers: net: Remove duplicate newlines
Date: Sat, 20 Jul 2024 14:40:45 +0200
Message-ID: <20240720124239.7553-20-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
References: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 7e065633d66cf71af12
X-MBO-RS-META: 1h88c5eyd13mtrncshnqj7466jxhyn3o
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/net/bcm-sf2-eth-gmac.h          | 1 -
 drivers/net/bnxt/bnxt.c                 | 1 -
 drivers/net/designware.h                | 1 -
 drivers/net/e1000.c                     | 6 ------
 drivers/net/e1000.h                     | 4 ----
 drivers/net/fsl-mc/dpio/qbman_portal.c  | 2 --
 drivers/net/fsl-mc/dpio/qbman_portal.h  | 2 --
 drivers/net/ftmac100.c                  | 1 -
 drivers/net/gmac_rockchip.c             | 1 -
 drivers/net/ks8851_mll.h                | 1 -
 drivers/net/ldpaa_eth/ldpaa_eth.h       | 1 -
 drivers/net/ldpaa_eth/ldpaa_wriop.c     | 2 --
 drivers/net/macb.h                      | 3 ---
 drivers/net/mpc8xx_fec.c                | 1 -
 drivers/net/mscc_eswitch/luton_switch.c | 1 -
 drivers/net/mscc_eswitch/mscc_miim.h    | 1 -
 drivers/net/mvneta.c                    | 2 --
 drivers/net/mvpp2.c                     | 1 -
 drivers/net/pfe_eth/pfe_mdio.c          | 1 -
 drivers/net/phy/davicom.c               | 1 -
 drivers/net/phy/lxt.c                   | 1 -
 drivers/net/phy/micrel_ksz90x1.c        | 1 -
 drivers/net/phy/miiphybb.c              | 1 -
 drivers/net/phy/mv88e6352.c             | 1 -
 drivers/net/phy/natsemi.c               | 3 ---
 drivers/net/rtl8169.c                   | 2 --
 drivers/net/sh_eth.h                    | 1 -
 drivers/net/sun8i_emac.c                | 2 --
 drivers/net/ti/davinci_emac.c           | 3 ---
 drivers/net/ti/davinci_emac.h           | 3 ---
 drivers/net/ti/keystone_net.c           | 2 --
 drivers/net/zynq_gem.c                  | 1 -
 32 files changed, 55 deletions(-)

diff --git a/drivers/net/bcm-sf2-eth-gmac.h b/drivers/net/bcm-sf2-eth-gmac.h
index 477667f4eaa..ac5e45d4f90 100644
--- a/drivers/net/bcm-sf2-eth-gmac.h
+++ b/drivers/net/bcm-sf2-eth-gmac.h
@@ -18,7 +18,6 @@
 #define GMAC0_INTR_RECV_LAZY_ADDR	(GMAC0_REG_BASE + 0x100)
 #define GMAC0_PHY_CTRL_ADDR		(GMAC0_REG_BASE + 0x188)
 
-
 #define GMAC_DMA_PTR_OFFSET		0x04
 #define GMAC_DMA_ADDR_LOW_OFFSET	0x08
 #define GMAC_DMA_ADDR_HIGH_OFFSET	0x0c
diff --git a/drivers/net/bnxt/bnxt.c b/drivers/net/bnxt/bnxt.c
index 25fbcd7b116..96e804e8cac 100644
--- a/drivers/net/bnxt/bnxt.c
+++ b/drivers/net/bnxt/bnxt.c
@@ -3,7 +3,6 @@
  * Copyright 2019-2021 Broadcom.
  */
 
-
 #include <asm/io.h>
 #include <dm.h>
 #include <linux/delay.h>
diff --git a/drivers/net/designware.h b/drivers/net/designware.h
index 918a38615ad..e47101ccaf6 100644
--- a/drivers/net/designware.h
+++ b/drivers/net/designware.h
@@ -64,7 +64,6 @@ struct eth_mac_regs {
 #define MII_REGMSK		(0x1F << 6)
 #define MII_ADDRMSK		(0x1F << 11)
 
-
 struct eth_dma_regs {
 	u32 busmode;		/* 0x00 */
 	u32 txpolldemand;	/* 0x04 */
diff --git a/drivers/net/e1000.c b/drivers/net/e1000.c
index fcb205322c5..8f432b8637b 100644
--- a/drivers/net/e1000.c
+++ b/drivers/net/e1000.c
@@ -7,10 +7,8 @@ tested on both gig copper and gig fiber boards
 ***************************************************************************/
 /*******************************************************************************
 
-
   Copyright(c) 1999 - 2002 Intel Corporation. All rights reserved.
 
-
   Contact Information:
   Linux NICS <linux.nics@intel.com>
   Intel Corporation, 5200 N.E. Elam Young Parkway, Hillsboro, OR 97124-6497
@@ -1742,7 +1740,6 @@ e1000_initialize_hardware_bits(struct e1000_hw *hw)
 		reg_txdctl1 |= E1000_TXDCTL_COUNT_DESC;
 		E1000_WRITE_REG(hw, TXDCTL1, reg_txdctl1);
 
-
 		switch (hw->mac_type) {
 		case e1000_igb:			/* IGB is cool */
 			return;
@@ -2594,7 +2591,6 @@ e1000_set_d0_lplu_state(struct e1000_hw *hw, bool active)
 				return ret_val;
 		}
 
-
 	} else {
 
 		if (hw->mac_type == e1000_ich8lan) {
@@ -5216,7 +5212,6 @@ e1000_configure_tx(struct e1000_hw *hw)
 		E1000_WRITE_REG(hw, TARC1, tarc);
 	}
 
-
 	e1000_config_collision_dist(hw);
 	/* Setup Transmit Descriptor Settings for eop descriptor */
 	hw->txd_cmd = E1000_TXD_CMD_EOP | E1000_TXD_CMD_IFCS;
@@ -5227,7 +5222,6 @@ e1000_configure_tx(struct e1000_hw *hw)
 	else
 		hw->txd_cmd |= E1000_TXD_CMD_RS;
 
-
 	if (hw->mac_type == e1000_igb) {
 		E1000_WRITE_REG(hw, TCTL_EXT, 0x42 << 10);
 
diff --git a/drivers/net/e1000.h b/drivers/net/e1000.h
index aa649328f5f..5ca720f4609 100644
--- a/drivers/net/e1000.h
+++ b/drivers/net/e1000.h
@@ -1,7 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*******************************************************************************
 
-
   Copyright(c) 1999 - 2002 Intel Corporation. All rights reserved.
   Copyright 2011 Freescale Semiconductor, Inc.
 
@@ -402,7 +401,6 @@ struct e1000_phy_stats {
 							off */
 #define IFE_PSCL_PROBE_LEDS_ON               0x0007  /* Force LEDs 0 and 2 on */
 
-
 #define NUM_DEV_IDS 16
 
 #define NODE_ADDRESS_SIZE 6
@@ -1069,7 +1067,6 @@ typedef enum {
     e1000_ffe_config_blocked
 } e1000_ffe_config;
 
-
 /* Structure containing variables used by the shared code (e1000_hw.c) */
 struct e1000_hw {
 	const char *name;
@@ -2128,7 +2125,6 @@ struct e1000_hw {
 /* In-Band Control Register (Page 194, Register 18) */
 #define GG82563_ICR_DIS_PADDING		0x0010 /* Disable Padding Use */
 
-
 /* Bits...
  * 15-5: page
  * 4-0: register offset
diff --git a/drivers/net/fsl-mc/dpio/qbman_portal.c b/drivers/net/fsl-mc/dpio/qbman_portal.c
index 44ce00041ee..f4e82b0507c 100644
--- a/drivers/net/fsl-mc/dpio/qbman_portal.c
+++ b/drivers/net/fsl-mc/dpio/qbman_portal.c
@@ -218,7 +218,6 @@ void qbman_eq_desc_set_response(struct qbman_eq_desc *d,
 	qb_attr_code_encode(&code_eq_rsp_stash, cl, !!stash);
 }
 
-
 void qbman_eq_desc_set_qd(struct qbman_eq_desc *d, uint32_t qdid,
 			  uint32_t qd_bin, uint32_t qd_prio)
 {
@@ -365,7 +364,6 @@ static struct qb_attr_code code_dqrr_stat = QB_CODE(0, 8, 8);
 #define QBMAN_DQRR_RESPONSE_BPSCN     0x29
 #define QBMAN_DQRR_RESPONSE_CSCN_WQ   0x2a
 
-
 /* NULL return if there are no unconsumed DQRR entries. Returns a DQRR entry
  * only once, so repeated calls can return a sequence of DQRR entries, without
  * requiring they be consumed immediately or in any particular order. */
diff --git a/drivers/net/fsl-mc/dpio/qbman_portal.h b/drivers/net/fsl-mc/dpio/qbman_portal.h
index 8cbc771a127..67ed90cd389 100644
--- a/drivers/net/fsl-mc/dpio/qbman_portal.h
+++ b/drivers/net/fsl-mc/dpio/qbman_portal.h
@@ -16,7 +16,6 @@
 #define QBMAN_VER_4_0_DQRR_SIZE 4
 #define QBMAN_VER_4_1_DQRR_SIZE 8
 
-
 /* --------------------- */
 /* portal data structure */
 /* --------------------- */
@@ -130,7 +129,6 @@ static inline uint32_t qb_attr_code_decode(const struct qb_attr_code *code,
 	return d32_uint32_t(code->lsoffset, code->width, cacheline[code->word]);
 }
 
-
 /* encode a field to a cacheline */
 static inline void qb_attr_code_encode(const struct qb_attr_code *code,
 				       uint32_t *cacheline, uint32_t val)
diff --git a/drivers/net/ftmac100.c b/drivers/net/ftmac100.c
index 199a0723b84..fa0b3dbb6d1 100644
--- a/drivers/net/ftmac100.c
+++ b/drivers/net/ftmac100.c
@@ -101,7 +101,6 @@ static int _ftmac100_init(struct ftmac100_data *priv, unsigned char enetaddr[6])
 	/* set the ethernet address */
 	ftmac100_set_mac(priv, enetaddr);
 
-
 	/* disable all interrupts */
 
 	writel (0, &ftmac100->imr);
diff --git a/drivers/net/gmac_rockchip.c b/drivers/net/gmac_rockchip.c
index d63e2dbfaeb..8cfeeffe95b 100644
--- a/drivers/net/gmac_rockchip.c
+++ b/drivers/net/gmac_rockchip.c
@@ -51,7 +51,6 @@ struct rk_gmac_ops {
 	void (*set_to_rgmii)(struct gmac_rockchip_plat *pdata);
 };
 
-
 static int gmac_rockchip_of_to_plat(struct udevice *dev)
 {
 	struct gmac_rockchip_plat *pdata = dev_get_plat(dev);
diff --git a/drivers/net/ks8851_mll.h b/drivers/net/ks8851_mll.h
index 7f90ae4e59b..7c5da7db5e2 100644
--- a/drivers/net/ks8851_mll.h
+++ b/drivers/net/ks8851_mll.h
@@ -114,7 +114,6 @@
 #define TXSR_TXFID_SHIFT		(0)
 #define TXSR_TXFID_GET(_v)		(((_v) >> 0) & 0x3f)
 
-
 #define KS_RXCR1			0x74
 #define RXCR1_FRXQ			(1 << 15)
 #define RXCR1_RXUDPFCC			(1 << 14)
diff --git a/drivers/net/ldpaa_eth/ldpaa_eth.h b/drivers/net/ldpaa_eth/ldpaa_eth.h
index af082e34cae..ac8d1e408ec 100644
--- a/drivers/net/ldpaa_eth/ldpaa_eth.h
+++ b/drivers/net/ldpaa_eth/ldpaa_eth.h
@@ -17,7 +17,6 @@
 #include <fsl-mc/fsl_qbman_portal.h>
 #include <fsl-mc/fsl_mc_private.h>
 
-
 enum ldpaa_eth_type {
 	LDPAA_ETH_1G_E,
 	LDPAA_ETH_10G_E,
diff --git a/drivers/net/ldpaa_eth/ldpaa_wriop.c b/drivers/net/ldpaa_eth/ldpaa_wriop.c
index a803b8fa797..758759240e0 100644
--- a/drivers/net/ldpaa_eth/ldpaa_wriop.c
+++ b/drivers/net/ldpaa_eth/ldpaa_wriop.c
@@ -52,7 +52,6 @@ void wriop_init_dpmac_enet_if(int dpmac_id, phy_interface_t enet_if)
 	}
 }
 
-
 /*TODO what it do */
 static int wriop_dpmac_to_index(int dpmac_id)
 {
@@ -102,7 +101,6 @@ int wriop_is_enabled_dpmac(int dpmac_id)
 	return dpmac_info[i].enabled;
 }
 
-
 int wriop_set_mdio(int dpmac_id, struct mii_dev *bus)
 {
 	int i = wriop_dpmac_to_index(dpmac_id);
diff --git a/drivers/net/macb.h b/drivers/net/macb.h
index 72b84ae96ed..0eb90574618 100644
--- a/drivers/net/macb.h
+++ b/drivers/net/macb.h
@@ -273,7 +273,6 @@
 #define GEM_SGMIIEN_OFFSET	27
 #define GEM_SGMIIEN_SIZE	1
 
-
 /* Constants for data bus width. */
 #define GEM_DBW32		0 /* 32 bit AMBA AHB data bus width */
 #define GEM_DBW64		1 /* 64 bit AMBA AHB data bus width */
@@ -303,7 +302,6 @@
 #define GEM_ADDR64_OFFSET	30 /* Address bus width - 64b or 32b */
 #define GEM_ADDR64_SIZE		1
 
-
 /* Bitfields in NSR */
 #define MACB_NSR_LINK_OFFSET	0 /* pcs_link_state */
 #define MACB_NSR_LINK_SIZE	1
@@ -456,7 +454,6 @@
 #define GEM_TX_PKT_BUFF_OFFSET			21
 #define GEM_TX_PKT_BUFF_SIZE			1
 
-
 /* Bitfields in DCFG5. */
 #define GEM_TSU_OFFSET				8
 #define GEM_TSU_SIZE				1
diff --git a/drivers/net/mpc8xx_fec.c b/drivers/net/mpc8xx_fec.c
index c44fa6acdd7..182f84c38af 100644
--- a/drivers/net/mpc8xx_fec.c
+++ b/drivers/net/mpc8xx_fec.c
@@ -636,7 +636,6 @@ static int fec_start(struct udevice *dev)
 	return 0;
 }
 
-
 static void fec_stop(struct udevice *dev)
 {
 	struct ether_fcc_info_s *efis = dev_get_priv(dev);
diff --git a/drivers/net/mscc_eswitch/luton_switch.c b/drivers/net/mscc_eswitch/luton_switch.c
index 2f3d0911fdf..1c584373b8b 100644
--- a/drivers/net/mscc_eswitch/luton_switch.c
+++ b/drivers/net/mscc_eswitch/luton_switch.c
@@ -627,7 +627,6 @@ static int luton_probe(struct udevice *dev)
 			      GCB_MISC_STAT_PHY_READY, true, 500, false))
 		return -EACCES;
 
-
 	/* Initialize miim buses */
 	memset(&miim, 0x0, sizeof(miim) * LUTON_MIIM_BUS_COUNT);
 
diff --git a/drivers/net/mscc_eswitch/mscc_miim.h b/drivers/net/mscc_eswitch/mscc_miim.h
index feb1f40ae55..b53fd304b1e 100644
--- a/drivers/net/mscc_eswitch/mscc_miim.h
+++ b/drivers/net/mscc_eswitch/mscc_miim.h
@@ -20,5 +20,4 @@ struct mii_dev *mscc_mdiobus_init(struct mscc_miim_dev *miim, int *miim_count,
 				  phys_addr_t miim_base,
 				  unsigned long miim_size);
 
-
 #endif /* _MSCC_MIIM_H_ */
diff --git a/drivers/net/mvneta.c b/drivers/net/mvneta.c
index f014d39b175..1640868c24a 100644
--- a/drivers/net/mvneta.c
+++ b/drivers/net/mvneta.c
@@ -970,7 +970,6 @@ static struct mvneta_rx_queue *mvneta_rxq_handle_get(struct mvneta_port *pp,
 	return &pp->rxqs[rxq];
 }
 
-
 /* Drop packets received by the RXQ and free buffers */
 static void mvneta_rxq_drop_pkts(struct mvneta_port *pp,
 				 struct mvneta_rx_queue *rxq)
@@ -1107,7 +1106,6 @@ static void mvneta_cleanup_rxqs(struct mvneta_port *pp)
 		mvneta_rxq_deinit(pp, &pp->rxqs[queue]);
 }
 
-
 /* Init all Rx queues */
 static int mvneta_setup_rxqs(struct mvneta_port *pp)
 {
diff --git a/drivers/net/mvpp2.c b/drivers/net/mvpp2.c
index d19a79d1600..ae545fe229c 100644
--- a/drivers/net/mvpp2.c
+++ b/drivers/net/mvpp2.c
@@ -4702,7 +4702,6 @@ static int mvpp2_port_init(struct udevice *dev, struct mvpp2_port *port)
 		port->rxqs[queue] = rxq;
 	}
 
-
 	/* Create Rx descriptor rings */
 	for (queue = 0; queue < rxq_number; queue++) {
 		struct mvpp2_rx_queue *rxq = port->rxqs[queue];
diff --git a/drivers/net/pfe_eth/pfe_mdio.c b/drivers/net/pfe_eth/pfe_mdio.c
index ce2f76eabc8..651b8aee6f0 100644
--- a/drivers/net/pfe_eth/pfe_mdio.c
+++ b/drivers/net/pfe_eth/pfe_mdio.c
@@ -164,7 +164,6 @@ static void pfe_configure_serdes(struct pfe_eth_dev *priv)
 	if (gem->phy_mode == PHY_INTERFACE_MODE_2500BASEX)
 		sgmii_2500 = 1;
 
-
 	/* PCS configuration done with corresponding GEMAC */
 	bus.priv = gem_info[priv->gemac_port].gemac_base;
 
diff --git a/drivers/net/phy/davicom.c b/drivers/net/phy/davicom.c
index 72d66812985..52c7189b904 100644
--- a/drivers/net/phy/davicom.c
+++ b/drivers/net/phy/davicom.c
@@ -21,7 +21,6 @@
 #define MIIM_DM9161_10BTCSR    0x12
 #define MIIM_DM9161_10BTCSR_INIT       0x7800
 
-
 /* Davicom DM9161E */
 static int dm9161_config(struct phy_device *phydev)
 {
diff --git a/drivers/net/phy/lxt.c b/drivers/net/phy/lxt.c
index a817c58b128..60020508896 100644
--- a/drivers/net/phy/lxt.c
+++ b/drivers/net/phy/lxt.c
@@ -15,7 +15,6 @@
 #define MIIM_LXT971_SR2_100HDX    0x4000  /* 100 Mbit half duplex selected */
 #define MIIM_LXT971_SR2_100FDX    0x4200  /* 100 Mbit full duplex selected */
 
-
 /* LXT971 */
 static int lxt971_parse_status(struct phy_device *phydev)
 {
diff --git a/drivers/net/phy/micrel_ksz90x1.c b/drivers/net/phy/micrel_ksz90x1.c
index 556d75e31ed..c48ae6e88f3 100644
--- a/drivers/net/phy/micrel_ksz90x1.c
+++ b/drivers/net/phy/micrel_ksz90x1.c
@@ -228,7 +228,6 @@ int ksz9021_phy_extended_read(struct phy_device *phydev, int regnum)
 	return phy_read(phydev, MDIO_DEVAD_NONE, MII_KSZ9021_EXTENDED_DATAR);
 }
 
-
 static int ksz9021_phy_extread(struct phy_device *phydev, int addr, int devaddr,
 			       int regnum)
 {
diff --git a/drivers/net/phy/miiphybb.c b/drivers/net/phy/miiphybb.c
index 083d9d3996d..b143137893f 100644
--- a/drivers/net/phy/miiphybb.c
+++ b/drivers/net/phy/miiphybb.c
@@ -279,7 +279,6 @@ int bb_miiphy_read(struct mii_dev *miidev, int addr, int devad, int reg)
 	return rdreg;
 }
 
-
 /*****************************************************************************
  *
  * Write a MII PHY register.
diff --git a/drivers/net/phy/mv88e6352.c b/drivers/net/phy/mv88e6352.c
index 6284298ebc1..db4c91e34b4 100644
--- a/drivers/net/phy/mv88e6352.c
+++ b/drivers/net/phy/mv88e6352.c
@@ -262,7 +262,6 @@ int do_mvsw_reg_write(const char *name, int argc, char *const argv[])
 	return ret;
 }
 
-
 int do_mvsw_reg(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
 	int ret;
diff --git a/drivers/net/phy/natsemi.c b/drivers/net/phy/natsemi.c
index f7e514ef203..1a65e55402b 100644
--- a/drivers/net/phy/natsemi.c
+++ b/drivers/net/phy/natsemi.c
@@ -42,7 +42,6 @@ U_BOOT_PHY_DRIVER(dp83630) = {
 	.shutdown = &genphy_shutdown,
 };
 
-
 /* DP83865 Link and Auto-Neg Status Register */
 #define MIIM_DP83865_LANR      0x11
 #define MIIM_DP83865_SPD_MASK  0x0018
@@ -50,7 +49,6 @@ U_BOOT_PHY_DRIVER(dp83630) = {
 #define MIIM_DP83865_SPD_100   0x0008
 #define MIIM_DP83865_DPX_FULL  0x0002
 
-
 /* NatSemi DP83865 */
 static int dp838xx_config(struct phy_device *phydev)
 {
@@ -101,7 +99,6 @@ static int dp83865_startup(struct phy_device *phydev)
 	return dp83865_parse_status(phydev);
 }
 
-
 U_BOOT_PHY_DRIVER(dp83865) = {
 	.name = "NatSemi DP83865",
 	.uid = 0x20005c70,
diff --git a/drivers/net/rtl8169.c b/drivers/net/rtl8169.c
index e80aebc0bcf..edcae88a3fc 100644
--- a/drivers/net/rtl8169.c
+++ b/drivers/net/rtl8169.c
@@ -736,7 +736,6 @@ static void rtl8169_hw_start(struct udevice *dev)
 	RTL_W32(TxConfig, (TX_DMA_BURST << TxDMAShift) |
 				(InterFrameGap << TxInterFrameGapShift));
 
-
 	tpc->cur_rx = 0;
 
 	RTL_W32(TxDescStartAddrLow, dm_pci_mem_to_phys(dev,
@@ -1031,7 +1030,6 @@ static int rtl_init(unsigned long dev_ioaddr, const char *name,
 #endif
 	}
 
-
 	tpc->RxDescArray = rtl_alloc_descs(NUM_RX_DESC);
 	if (!tpc->RxDescArray)
 		return -ENOMEM;
diff --git a/drivers/net/sh_eth.h b/drivers/net/sh_eth.h
index 1c07610e1ac..ecf4a697e27 100644
--- a/drivers/net/sh_eth.h
+++ b/drivers/net/sh_eth.h
@@ -474,7 +474,6 @@ enum EESR_BIT {
 	EESR_PRE  = 0x00000002, EESR_CERF = 0x00000001,
 };
 
-
 #if defined(SH_ETH_TYPE_GETHER) || defined(SH_ETH_TYPE_RZ)
 # define TX_CHECK (EESR_TC1 | EESR_FTC)
 # define EESR_ERR_CHECK	(EESR_TWB | EESR_TABT | EESR_RABT | EESR_RDE \
diff --git a/drivers/net/sun8i_emac.c b/drivers/net/sun8i_emac.c
index 6fab34715de..0da182d9f4c 100644
--- a/drivers/net/sun8i_emac.c
+++ b/drivers/net/sun8i_emac.c
@@ -171,7 +171,6 @@ struct emac_eth_dev {
 	struct udevice *phy_reg;
 };
 
-
 struct sun8i_eth_pdata {
 	struct eth_pdata eth_pdata;
 	u32 reset_delays[3];
@@ -179,7 +178,6 @@ struct sun8i_eth_pdata {
 	int rx_delay_ps;
 };
 
-
 static int sun8i_mdio_read(struct mii_dev *bus, int addr, int devad, int reg)
 {
 	struct udevice *dev = bus->priv;
diff --git a/drivers/net/ti/davinci_emac.c b/drivers/net/ti/davinci_emac.c
index 03a1a7a1159..d8085193e80 100644
--- a/drivers/net/ti/davinci_emac.c
+++ b/drivers/net/ti/davinci_emac.c
@@ -144,7 +144,6 @@ static int davinci_emac_write_hwaddr(struct udevice *dev)
 	writel(mac_hi, &adap_emac->MACSRCADDRHI);
 	writel(mac_lo, &adap_emac->MACSRCADDRLO);
 
-
 	return 0;
 }
 
@@ -205,7 +204,6 @@ static int davinci_eth_phy_detect(void)
 	return count;
 }
 
-
 /* Read a PHY register via MDIO inteface. Returns 1 on success, 0 otherwise */
 int davinci_eth_phy_read(u_int8_t phy_addr, u_int8_t reg_num, u_int16_t *data)
 {
@@ -378,7 +376,6 @@ static int gen_auto_negotiate(int phy_addr)
 }
 /* End of generic PHY functions */
 
-
 #if defined(CONFIG_MII) || defined(CONFIG_CMD_MII)
 static int davinci_mii_phy_read(struct mii_dev *bus, int addr, int devad,
 				int reg)
diff --git a/drivers/net/ti/davinci_emac.h b/drivers/net/ti/davinci_emac.h
index 695855b4d54..c213e24b8b2 100644
--- a/drivers/net/ti/davinci_emac.h
+++ b/drivers/net/ti/davinci_emac.h
@@ -20,7 +20,6 @@
  */
 #define EMAC_MAX_RX_BUFFERS		10
 
-
 /***********************************************
  ******** Internally used macros ***************
  ***********************************************/
@@ -45,7 +44,6 @@
 /* Number of statistics registers */
 #define EMAC_NUM_STATS			36
 
-
 /* EMAC Descriptor */
 typedef volatile struct _emac_desc
 {
@@ -78,7 +76,6 @@ typedef volatile struct _emac_desc
 #define EMAC_RXMBPENABLE_RXCAFEN_ENABLE	(0x200000)
 #define EMAC_RXMBPENABLE_RXBROADEN	(0x2000)
 
-
 #define MDIO_CONTROL_IDLE		(0x80000000)
 #define MDIO_CONTROL_ENABLE		(0x40000000)
 #define MDIO_CONTROL_FAULT_ENABLE	(0x40000)
diff --git a/drivers/net/ti/keystone_net.c b/drivers/net/ti/keystone_net.c
index c6e5bf21cf0..d4abc9a0411 100644
--- a/drivers/net/ti/keystone_net.c
+++ b/drivers/net/ti/keystone_net.c
@@ -83,7 +83,6 @@ enum link_type {
 
 #endif
 
-
 struct ks2_eth_priv {
 	struct udevice			*dev;
 	struct phy_device		*phydev;
@@ -208,7 +207,6 @@ int keystone_sgmii_config(struct phy_device *phy_dev, int port, int interface)
 	__raw_writel(mr_adv_ability, SGMII_MRADV_REG(port));
 	__raw_writel(control, SGMII_CTL_REG(port));
 
-
 	mask = SGMII_REG_STATUS_LINK;
 
 	if (control & SGMII_REG_CONTROL_AUTONEG)
diff --git a/drivers/net/zynq_gem.c b/drivers/net/zynq_gem.c
index b41ee95892e..fe7d1084450 100644
--- a/drivers/net/zynq_gem.c
+++ b/drivers/net/zynq_gem.c
@@ -390,7 +390,6 @@ static int zynq_phy_init(struct udevice *dev)
 	return phy_config(priv->phydev);
 }
 
-
 static int zynq_gem_init(struct udevice *dev)
 {
 	u32 i, nwconfig, nwcfg;
-- 
2.43.0

