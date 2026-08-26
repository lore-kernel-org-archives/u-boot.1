Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B446C61DC2
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 13:42:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 446866075A;
	Wed, 26 Aug 2026 13:42:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1GHdGcOP_V5s; Wed, 26 Aug 2026 13:42:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787751760;
	bh=U3jN/ht7JuP/yaMS+e9R5Ps2NtkgcYO6LZQUvj8i7no=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fn6lLaIj+JHumto5gmhC2SFyUwZF+F1L7A//NBUlxelffH71S87v5QheNHL20lhOL
	 lMr9298k/R0Jssexift+soyhPcHHN54ZE0q9G0dw4Wf8rZZUQPHE4JTDf+MhuUbbMy
	 HaWvkr+d0A9ff1bCzXk/Sj2L91tKhJhY7V87Q2nNbb/6iXFa1bM+ctWlayb/BvxBIX
	 TK3Unj8lcABvhmYUi1yWTcS7dOdD2nUjXvm4pW6lL1MOjAoGqksWwTokyLU73DR/zT
	 Ar0HOic4nSjGzqyW5MFRsNaB6PAqKPyAnIyhQauy2qz0wa7L2kqa2sI/MH62c3z0zB
	 bVfQd7EzLPYlw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B3C0560787;
	Wed, 26 Aug 2026 13:42:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6912E3AD
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:35:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5AE9740467
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:35:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LZOeQOB3T0pd for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 13:35:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=34.2.90.19;
 helo=sonic.asd.mail.yahoo.com; envelope-from=maskachoska@yahoo.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com
 header.a=rsa-sha256 header.s=s2048 header.b=qZQa7fjq
Received: from sonic.asd.mail.yahoo.com (sonic-asso1-0020.asd.mail.yahoo.com
 [34.2.90.19]) by smtp4.osuosl.org (Postfix) with ESMTPS id 83FFB40434
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1787751302; bh=U3jN/ht7JuP/yaMS+e9R5Ps2NtkgcYO6LZQUvj8i7no=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=qZQa7fjqJRTgh4OHcUCorVqHKfqD3OomYFT0ydnu79+fQ/vKkdKfvCNhUf2RLBQqcoAUvFmenVUtLvO0xv9rGn+zn+cIXNN62VhVNZmAlQG28tcyFU82ShygjFnYk0sXiwIOWthoIrBoPxrcVeF+AvznoZwF5/dfzNbHvyQwepR1cUtk1nyc/dAfOnBfWES9kME+q6v6nLdalH0RujqfkypcwxCJkrVONSG85jFU38QsdMWn1EkjyBktd9JSOmPjbzfGE2TF09P2SNT/6ATCCvLL4+sJgIYVMIK8ZiXA/gB3v/k+1k07Ylwj1y/YPRE9NfO/9afpmo2ALnWvhlfE3g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1787751302; bh=6hpQUDWeMN49tlMGO/UUqOYZsjS3nrSjrYdUnm2Ov9e=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=JnfBYST1XYrHOw+Akz67PnMsMSSbs+A5icXmwqaiW+5JUedYOqK0mDT2I8D+qOx1BexZU5lncEjLZoVPfjzFRwwZA5pvF/NeBLYwXAEjCMQPqX1gh/qAO2JuF55QFWL3o2oxVVxCBp4KBloePUfxnKsey5dSpnq2//tbx5yeNoQIVs99gHhks7sVx5vZuzzV8fu9sGMv5CN3iPKE4nJY+WTeUAK4M1ytVHn+vcnsxAfFbMRMcetDcTvsKufGQPBbkI+elJsP2dpj4NbasjM6l2DwKnf0jHmU3wk5mg91PaPDBUaLkQ/dBNFlG8a5MDMvqxXcbfTiTlHKY1Bt1ghyzw==
X-YMail-OSG: NrxobQMVM1mCpE24tSD7_K8tPpTV2RcWiaRJyijmFa.akNbKiwnDkHxBBktb_6O
 uoqSTRQaTBA0zSeL79UqgES825cfGM2_iC958_inGF3K_K_cg7FgPIp4yUDJugjR90M07OC1m1hv
 djbMpmcZoOPoQaZ6r4v3HShl.X6OKsH0C.AU843Q3yz2j29uJu9qp8W7KPbPkewiVIV0g7ZYddDC
 Kw_wgN0l5rOcrEfddM0YxMiKy3f2uVEZDEsvdzAFyiwdMIjNsjZkA1PKKYYbs16blV5kG1gBZ54b
 6MHhEFiFZUkmKjaUNgHOTWTuukEYU0.bTKoWP.mIWTGyROp7ga6PPelW1KIco14r7iM8BOAIgxk5
 WTeIS_GbGObOb47ih2BaxmiPL8eiWrQ8ATCndiZofdZ6aY4RhZbv3i5QduFHa9myhnAaY4BbgE4j
 9VBPPg122UHkMDwp8rjz3yk9mf1GdW3Pg7zlj3qu52rgEOwKwJ3aVmOkKUtdFl.82Ndhhs_7UUOb
 nb7Le636a6bzZ_Fl8xkslh0xKOIPFyoV6.46K2qTTf6DehVpJhK50QsuuZS2qY.yZIgMmgYt7K64
 2Y6A7PDpNrUXg31S.hoLPG4Uq.RU35ptxZMQyxIuw9EL8MjpR6okBHbegSmLPaJ979MrQJDqgLC_
 VXuuMBPsO8NhTp96akLC1aBs2PfvN7qb2E0GUVkGzFQnfwUMTeXh6GS.WkA9tl56kbH2PPxGjlGr
 89aDpx1DObDAv1EMI4h.PFRmZl8PPzSgBtLzcGaidMEn1VNV7_6wWPA3ukA.fWjIBC2VZcG3kIIl
 X90BXRXhlX6w0UAHRdWRoBu688hqDpj1kgKE8GK6Dr8gLsEDlkk0KIXakNHSpy8FfPmyFJI0yvex
 jsdwxhmW8l1XL8.tvmAP3jhtnlxl251ryTg73JehnDpcBjIdp1sBFW4bu1LpQ_qwqU4yUfjPJ3oR
 yBoTqKCPiZNI4jHGjTnzboNDvzJXpCxF4n5OaB4dnBut3PqiOWxbfqPB1gp5Bm0DtQCSTryMyDNR
 l9gIvWfcfUWCXYNk4A_Sf4_sIysLh6TMWVCdiesBQcC_0mi81fL5vFUCdTLIaGFu1hCgKUeQJCRX
 bj0dqsvExclF0eYw3hsSWLBTMQuSZpPiRTk08DEOp3dXFpyd.RloToo8D0iBmoFCv9wrXZVfwUax
 mfr6k_sCLYztQKXQSLG0qiQBWbOOQWmPV5Q9Q2ZhEUFeebKhvOB86dZQFPfYx_cLH8P8QJ5LVPQg
 nVyXUXWx4tMywgNyvcAx9VYKnjUeXJN2M3YFdfD4DfXj6IjUIpyLg6BAj12ns4F7yojKsHRZc2zL
 2.lk_B8YbK0anU4L0Ev1n3D54500wqJ8nfF7AHoXTxvlLyGnW1WON5.bQw9T_O8g.ZHostqtVEo7
 _ALkj2JwbryzowEfPsQKoW89JT2A.s5FQV6UeJkgoC6varVwQSXHEwaJoW3axZN4m0ZC.czT8l6K
 oRCdVfruGzGaTXEIbXk2ZppkYJXBnWBCo1pumeNCDqyIDjtJwny37rvHYjxFReQbGcUNfXezHEja
 BSGbxcATJ.VrH8Uud.rktgaAqSR63NJTVB7CfhrNIi.4StgcV2lexr83pqcGd.CSJ6L9a6Uj9LA.
 M6bWShEAmz49q0zjWAUU0K1BBIy9kwVh8lTeYKSxylMeIL0AvMBKsXcjKZmWIM758fBPGFNYIjfT
 hk4jJOOJmtUx_ps45ceCXwLV3sSc7vLWA2hw5BCk8qD.6gOGKx4JAej93wP9SvaUCiBs.RhYCGo5
 F0ytbKmjTQOMYfEAgy6rzvkjOq1c9UQA8Qi8O5TYAwe7WE5fxbKNp4zvgQqceR4DKGsjaelMNDT0
 L9HuLoiim6rWn8tOwpv6tdX2fm9ENswdu0YUAphI1pFUa4zGd0igCrtJ7XCXO3O26re6XIfCgtQY
 xw_FygQxxpObIgOU9fMYPvXdWWKJzpyJknvIyfcORGkrO8QtJRKJULl.CUAN8CPD4ZjqsnKCtraC
 ENvaD4aE7ZiN0.PySdCZrhbPfAZy1W8_s9C_c8s0GcLMD7duz2RPv7CxpTBb6KxmCBtn3ObUHQAE
 iMIQ-
X-Sonic-MF: <maskachoska@yahoo.com>
X-Sonic-ID: f13f3b54-09b3-4e37-983d-92cdb7ac42d1
Received: from sonic.gate.mail.ne1.yahoo.com by
 mail-asdoutdeli-p-cin-asso1-prod-sonicconsumer-svc-101 with HTTP;
 Wed, 26 Aug 2026 13:35:02 +0000
Received: from dip100.lsn.sg3.yahoo.com ([106.10.223.109])
 by hello (SMTP) with SMTP ID acc4f7a299298e219e9ccf723c2619d7;
 Wed, 26 Aug 2026 13:34:59 +0000 (UTC)
From: AK Sharma <maskachoska@yahoo.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@arm.com>, Marek Vasut <marex@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 AK Sharma <maskachoska@yahoo.com>
Subject: [PATCH v2 5/9] net: airoha-eth: add EN7528 Ethernet support
Date: Wed, 26 Aug 2026 19:04:39 +0530
Message-ID: <618a7e274774eafbb9a97765123ce879791a4a34.1787736704.git.maskachoska@yahoo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1787736704.git.maskachoska@yahoo.com>
References: <20260825222211.712836-1-maskachoska@yahoo.com>
 <cover.1787736704.git.maskachoska@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 26 Aug 2026 13:42:25 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Extend the existing Airoha GDM Ethernet driver to support the EN7528: add
the SoC match, the frame-engine and GDMA/QDMA descriptor-ring setup, the
MAC initialisation and the wiring to the embedded gigabit switch (MT7530)
and its PHYs, so the port comes up and can run DHCP/TFTP/ping.

Signed-off-by: AK Sharma <maskachoska@yahoo.com>
---
 drivers/net/Kconfig      |   8 +-
 drivers/net/airoha_eth.c | 850 ++++++++++++++++++++++++++++++++++++---
 2 files changed, 807 insertions(+), 51 deletions(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 66661868..7bcc58ad 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -122,13 +122,13 @@ source "drivers/net/airoha/Kconfig"
 
 config AIROHA_ETH
 	bool "Airoha Ethernet QDMA Driver"
-	depends on ARCH_AIROHA
+	depends on ARCH_AIROHA || ARCH_EN75XX
 	select MISC
 	select PHYLIB
 	select DEVRES
-	select DM_ETH_PHY
-	select DM_RESET
-	select MDIO_MT7531_MMIO
+	select DM_ETH_PHY if ARCH_AIROHA
+	select DM_RESET if ARCH_AIROHA
+	select MDIO_MT7531_MMIO if ARCH_AIROHA
 	help
 	  This Driver support Airoha Ethernet QDMA Driver
 	  Say Y to enable support for the Airoha Ethernet QDMA.
diff --git a/drivers/net/airoha_eth.c b/drivers/net/airoha_eth.c
index e5d39b95..640e8bb2 100644
--- a/drivers/net/airoha_eth.c
+++ b/drivers/net/airoha_eth.c
@@ -4,6 +4,7 @@
  * and simplified for U-Boot usage for single TX/RX ring.
  *
  * Copyright (c) 2024 AIROHA Inc
+ * EN751221 support based on econet_eth by Caleb James DeLisle.
  * Author: Lorenzo Bianconi <lorenzo@kernel.org>
  *         Christian Marangi <ansuelsmth@gmail.org>
  */
@@ -13,6 +14,7 @@
 #include <dm/devres.h>
 #include <dm/lists.h>
 #include <mapmem.h>
+#include <malloc.h>
 #include <miiphy.h>
 #include <net.h>
 #include <regmap.h>
@@ -24,16 +26,27 @@
 #include <linux/ethtool.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
+#include <linux/mii.h>
 #include <linux/time.h>
+#if IS_ENABLED(CONFIG_ARCH_EN75XX)
+#include <asm/addrspace.h>	/* CKSEG1ADDR: uncached DMA-ring alias */
+#endif
+#if IS_ENABLED(CONFIG_ARCH_AIROHA)
 #include <asm/arch/scu-regmap.h>
+#endif
 
 #include "airoha/pcs-airoha.h"
 
 #define AIROHA_MAX_NUM_GDM_PORTS	4
 #define AIROHA_MAX_NUM_QDMA		1
-#define AIROHA_MAX_NUM_RSTS		3
+#define AIROHA_MAX_NUM_RSTS		4
 #define AIROHA_MAX_NUM_XSI_RSTS		4
 
+#define AIROHA_MAX_NUM_SWITCH_PORT	4
+#define AIROHA_MAX_PBUS_TRY		10
+#define AIROHA_PBUS_SLEEP		100
+#define AIROHA_PBUS_C22_MASK		0x800000
+
 #define AIROHA_MAX_PACKET_SIZE		2048
 #define AIROHA_NUM_TX_RING		1
 #define AIROHA_NUM_RX_RING		1
@@ -53,6 +66,8 @@
 #define   SWITCH_BC_FFP			GENMASK(31, 24)
 #define   SWITCH_UNM_FFP		GENMASK(23, 16)
 #define   SWITCH_UNU_FFP		GENMASK(15, 8)
+#define   SWITCH_CPU_EN			BIT(7)
+#define   SWITCH_CPU_PORT		GENMASK(6, 4)
 #define SWITCH_PMCR(_n)			0x3000 + ((_n) * 0x100)
 #define   SWITCH_IPG_CFG		GENMASK(19, 18)
 #define     SWITCH_IPG_CFG_NORMAL	FIELD_PREP(SWITCH_IPG_CFG, 0x0)
@@ -86,6 +101,19 @@
 #define   SWITCH_PHY_PRE_EN		BIT(15)
 #define   SWITCH_PHY_END_ADDR		GENMASK(12, 8)
 #define   SWITCH_PHY_ST_ADDR		GENMASK(4, 0)
+#define SWITCH_GEPHY_CONN_CFG		0x7c14
+#define   SWITCH_DPHY_CKIN_SEL		BIT(31)
+#define   SWITCH_PHY_CORE_REG_CLK_SEL	BIT(30)
+#define   SWITCH_ETHER_AFE_PWD		GENMASK(28, 24)
+#define SWITCH_PBUS_PHY_IAC		0x7c20
+#define   SWITCH_PBUS_PHY_START		BIT(31)
+#define   SWITCH_PBUS_PHY_CMD		BIT(30)
+#define   SWITCH_PBUS_PHY_CMD_READ	FIELD_PREP(SWITCH_PBUS_PHY_CMD, 0x0)
+#define   SWITCH_PBUS_PHY_CMD_WRITE	FIELD_PREP(SWITCH_PBUS_PHY_CMD, 0x1)
+#define   SWITCH_PBUS_PHY_PORTADDR	GENMASK(28, 24)
+#define   SWITCH_PBUS_PHY_REGADDR	GENMASK(23, 0)
+#define SWITCH_PBUS_PHY_IAWD		0x7c24
+#define SWITCH_PBUS_PHY_IARD		0x7c28
 
 /* FE */
 #define PSE_BASE			0x0100
@@ -106,6 +134,9 @@
 	 (_n) == 2 ? GDM2_BASE : GDM1_BASE)
 
 #define REG_GDM_FWD_CFG(_n)		GDM_BASE(_n)
+#define REG_GDM_MAC_LSB(_n)		(GDM_BASE(_n) + 0x08)
+#define REG_GDM_MAC_MSB(_n)		(GDM_BASE(_n) + 0x0c)
+#define REG_GDM_RX_LEN_THR(_n)		(GDM_BASE(_n) + 0x14)
 #define GDM_PAD_EN			BIT(28)
 #define GDM_DROP_CRC_ERR		BIT(23)
 #define GDM_IP4_CKSUM			BIT(22)
@@ -116,6 +147,74 @@
 #define GDM_MCFQ_MASK			GENMASK(7, 4)
 #define GDM_OCFQ_MASK			GENMASK(3, 0)
 
+/* EN7512/EN7521 GDM forwarding configuration */
+#define EN751221_GDM_DROP_OVERSIZE	BIT(25)	/* matches en7528 gdm_regs.h */
+#define EN751221_GDM_MYMAC_FPORT	GENMASK(15, 12)
+#define EN751221_GDM_BCAST_FPORT	GENMASK(11, 8)
+#define EN751221_GDM_MCAST_FPORT	GENMASK(7, 4)
+#define EN751221_GDM_DEFAULT_FPORT	GENMASK(3, 0)
+#define EN751221_GDM_OVERSIZE_LEN	GENMASK(31, 16)
+#define EN751221_GDM_RUNT_LEN		GENMASK(15, 0)
+
+/* EN7512/EN7521 QDMA register layout */
+#define EN751221_REG_TX_RING_BASE	0x0008
+#define EN751221_REG_RX_RING_BASE	0x000c
+#define EN751221_REG_TX_CPU_IDX		0x0010
+#define EN751221_REG_TX_DMA_IDX		0x0014
+#define EN751221_REG_RX_CPU_IDX		0x0018
+#define EN751221_REG_RX_DMA_IDX		0x001c
+#define EN751221_REG_FWD_DSCP_BASE	0x0020
+#define EN751221_REG_FWD_BUF_BASE	0x0024
+#define EN751221_REG_FWD_DSCP_CFG	0x0028
+#define EN751221_REG_LMGR_INIT_CFG	0x0030
+#define EN751221_REG_INT_STATUS		0x0050
+#define EN751221_REG_INT_ENABLE		0x0054
+#define EN751221_REG_RX_DELAY_INT	0x005c
+#define EN751221_REG_IRQ_BASE		0x0060
+#define EN751221_REG_IRQ_CFG		0x0064
+#define EN751221_REG_IRQ_CLEAR_LEN	0x0068
+#define EN751221_REG_IRQ_STATUS		0x006c
+#define EN751221_REG_RX_RING_SIZE	0x0100
+#define EN751221_REG_RX_RING_THR		0x0104
+
+#define EN751221_RING_IDX_MASK		GENMASK(11, 0)
+#define EN751221_IRQ_DEPTH_MASK		GENMASK(11, 0)
+#define EN751221_IRQ_THRESHOLD_MASK	GENMASK(27, 16)
+#define EN751221_IRQ_HEAD_IDX_MASK	GENMASK(11, 0)
+#define EN751221_IRQ_ENTRY_LEN_MASK	GENMASK(27, 16)
+#define EN751221_IRQ_CLEAR_LEN_MASK	GENMASK(7, 0)
+#define EN751221_HWFWD_LOW_THR_MASK	GENMASK(12, 0)
+#define EN751221_HWFWD_DESC_NUM_MASK	GENMASK(15, 0)
+#define EN751221_HWFWD_OVERHEAD_MASK	GENMASK(23, 16)
+#define EN751221_HWFWD_OVERHEAD_EN	BIT(24)		/* en7528: stock sets this */
+#define EN751221_GLOBAL_CFG_MSG_WORD_SWAP BIT(28)
+
+#define EN751221_TXMSG_CHANNEL_MASK	GENMASK(10, 3)
+#define EN751221_TXMSG_QUEUE_MASK	GENMASK(2, 0)
+#define EN751221_TXMSG_FPORT_MASK	GENMASK(21, 19)
+#define EN751221_FPORT_GDM1		1
+#define EN751221_HW_DSCP_NUM		256	/* en7528 stock LMGR pool (was 4) */
+#define EN751221_IRQ_QUEUE_LEN		32
+#define EN751221_IRQ_THRESHOLD		4
+/*
+ * SCU reset banks (base 0x1fb00000): kernel clk-en7523.c en751221_rst_ofs[] =
+ * { bank0 = REG_RST_CTRL2 = 0x830, bank1 = REG_RST_CTRL1 = 0x834 }, and
+ * en751221_rst_map[] places the frame-engine domains as (RST_NR_PER_BANK=32):
+ *   FE_QDMA1 "qdma0" = 32+1 -> bank1 bit1     FE_QDMA2 "qdma1" = 32+2 -> bank1 bit2
+ *   FE_RST   "fe"    = 32+21-> bank1 bit21     XPON_MAC = 32+31 -> bank1 bit31
+ *   XPON_PHY "xpon-phy" = 0 -> bank0 bit0
+ * The stock econet-eth eth node resets ALL FIVE as one array pulse.
+ */
+#define EN751221_RESET_CONTROL_B1	0xbfb00834	/* SCU reset bank1 (REG_RST_CTRL1) */
+#define EN751221_RESET_CONTROL_B0	0xbfb00830	/* SCU reset bank0 (REG_RST_CTRL2) */
+#define EN751221_RESET_CONTROL2		EN751221_RESET_CONTROL_B1  /* back-compat alias */
+#define EN751221_FE_SRAM_SEL		0xbfb00958
+#define EN751221_RST_QDMA0		BIT(1)		/* bank1: FE_QDMA1 "qdma0" */
+#define EN751221_RST_QDMA1		BIT(2)		/* bank1: FE_QDMA2 "qdma1" (was missing) */
+#define EN751221_RST_FE			BIT(21)		/* bank1: FE_RST */
+#define EN751221_RST_XPON_MAC		BIT(31)		/* bank1: XPON_MAC (was missing) */
+#define EN751221_RST_XPON_PHY		BIT(0)		/* bank0: XPON_PHY (was missing) */
+
 /* QDMA */
 #define REG_QDMA_GLOBAL_CFG			0x0004
 #define GLOBAL_CFG_RX_2B_OFFSET_MASK		BIT(31)
@@ -290,11 +389,24 @@ struct airoha_qdma_fwd_desc {
 	__le32 rsv1;
 };
 
+struct en751221_qdma_fwd_desc {
+	u32 addr;
+	u32 info;
+	u32 msg0;
+	u32 msg1;
+};
+
 struct airoha_queue {
 	struct airoha_qdma_desc *desc;
 	u16 head;
 
 	int ndesc;
+
+	/* Uncached TX bounce buffer: the same broken-flush issue means a CPU-
+	 * built packet in cached memory is not guaranteed to be in DRAM when the
+	 * QDMA reads it, so copy each TX frame through this uncached buffer. */
+	void *bounce;
+	unsigned long bounce_phys;
 };
 
 struct airoha_tx_irq_queue {
@@ -347,6 +459,7 @@ struct airoha_eth {
 
 struct airoha_eth_soc_data {
 	u32 version;
+	bool econet;
 	int num_xsi_rsts;
 	const char * const *xsi_rsts_names;
 	const char *switch_compatible;
@@ -365,6 +478,12 @@ static const char * const en7581_xsi_rsts_names[] = {
 	"xfp-mac",
 };
 
+static const char * const an7583_xsi_rsts_names[] = {
+	"hsi0-mac",
+	"hsi1-mac",
+	"xfp-mac",
+};
+
 static u32 airoha_rr(void __iomem *base, u32 offset)
 {
 	return readl(base + offset);
@@ -405,8 +524,12 @@ static u32 airoha_rmw(void __iomem *base, u32 offset, u32 mask, u32 val)
 #define airoha_qdma_clear(qdma, offset, val)			\
 	airoha_rmw((qdma)->regs, (offset), (val), 0)
 
+#define airoha_switch_rr(eth, offset)				\
+	airoha_rr((eth)->switch_regs, (offset))
 #define airoha_switch_wr(eth, offset, val)			\
 	airoha_wr((eth)->switch_regs, (offset), (val))
+#define airoha_switch_rmw(eth, offset, mask, val)		\
+	airoha_rmw((eth)->switch_regs, (offset), (mask), (val))
 
 static inline dma_addr_t dma_map_unaligned(void *vaddr, size_t len,
 					   enum dma_data_direction dir)
@@ -429,12 +552,41 @@ static inline void dma_unmap_unaligned(dma_addr_t addr, size_t len,
 	dma_unmap_single(start, end - start, dir);
 }
 
+static void *airoha_dma_alloc_coherent(size_t size, unsigned long *dma_addr)
+{
+#if IS_ENABLED(CONFIG_ARCH_EN75XX)
+	void *buf;
+
+	size = ALIGN(size, ARCH_DMA_MINALIGN);
+	buf = memalign(ARCH_DMA_MINALIGN, size);
+	if (!buf)
+		return NULL;
+
+	*dma_addr = virt_to_phys(buf);
+	/*
+	 * EN7528 CM L2 has no Hit_Writeback_Inv_SD (op 0x17 hangs). DMA-shared
+	 * rings must therefore live in KSEG1 so CPU stores reach DRAM without
+	 * an L2 writeback. QDMA then sees descriptors by construction.
+	 */
+	return (void *)CKSEG1ADDR((unsigned long)buf);
+#else
+	return dma_alloc_coherent(size, dma_addr);
+#endif
+}
+
+static bool airoha_is_en751221(struct airoha_eth *eth)
+{
+	return eth->soc->econet;
+}
+
 static int airoha_get_fe_port(struct airoha_gdm_port *port)
 {
 	struct airoha_qdma *qdma = port->qdma;
 	struct airoha_eth *eth = qdma->eth;
 
 	switch (eth->soc->version) {
+	case 0x7512:
+		return EN751221_FPORT_GDM1;
 	case 0x7523:
 		/* FIXME: GDM1 is the only supported port */
 		return FE_PSE_PORT_GDM1;
@@ -446,6 +598,32 @@ static int airoha_get_fe_port(struct airoha_gdm_port *port)
 
 static void airoha_fe_maccr_init(struct airoha_gdm_port *port)
 {
+	if (airoha_is_en751221(port->qdma->eth)) {
+		u32 fwd_cfg, len_thr;
+
+		/*
+		 * QDMA0 CPU is fport zero: received frames go to the CPU. The
+		 * stock en7528 econet-eth driver sets exactly this (all fport
+		 * classes = CPU) plus drop_oversize. (BIT25 DROP_OVERSIZE is the
+		 * correct en7528 bit per gdm_regs.h — the earlier bits[31:30]
+		 * "forward-enable" guess was wrong: those are VIP/L2LU bits.)
+		 */
+		fwd_cfg = EN751221_GDM_DROP_OVERSIZE |
+			  FIELD_PREP(EN751221_GDM_MYMAC_FPORT, 0) |
+			  FIELD_PREP(EN751221_GDM_BCAST_FPORT, 0) |
+			  FIELD_PREP(EN751221_GDM_MCAST_FPORT, 0) |
+			  FIELD_PREP(EN751221_GDM_DEFAULT_FPORT, 0);
+		airoha_fe_wr(port->qdma->eth, REG_GDM_FWD_CFG(port->id),
+			     fwd_cfg);
+
+		len_thr = FIELD_PREP(EN751221_GDM_OVERSIZE_LEN,
+				     PKTSIZE_ALIGN) |
+			  FIELD_PREP(EN751221_GDM_RUNT_LEN, 60);
+		airoha_fe_wr(port->qdma->eth, REG_GDM_RX_LEN_THR(port->id),
+			     len_thr);
+		return;
+	}
+
 	/*
 	 * Disable any kind of CRC drop or offload.
 	 * Enable padding of short TX packets to 60 bytes.
@@ -460,6 +638,214 @@ static int airoha_fe_init(struct airoha_gdm_port *port)
 	return 0;
 }
 
+static void en751221_qdma_reset_rx_desc(struct airoha_queue *q, int index)
+{
+	struct airoha_qdma_desc *desc = &q->desc[index];
+	uchar *rx_packet = net_rx_packets[index];
+	u32 next;
+
+	dma_map_single(rx_packet, PKTSIZE_ALIGN, DMA_FROM_DEVICE);
+	next = (index + 1) % q->ndesc;
+
+	WRITE_ONCE(desc->rsv, 0);
+	WRITE_ONCE(desc->ctrl,
+		   FIELD_PREP(QDMA_DESC_LEN_MASK, PKTSIZE_ALIGN));
+	WRITE_ONCE(desc->addr, virt_to_phys(rx_packet));
+	WRITE_ONCE(desc->data, next);
+	WRITE_ONCE(desc->msg0, 0);
+	WRITE_ONCE(desc->msg1, 0);
+	WRITE_ONCE(desc->msg2, 0);
+	WRITE_ONCE(desc->msg3, 0);
+
+	dma_map_unaligned(desc, sizeof(*desc), DMA_TO_DEVICE);
+}
+
+static void en751221_qdma_init_rx_desc(struct airoha_qdma *qdma)
+{
+	struct airoha_queue *q = &qdma->q_rx[0];
+	int i;
+
+	for (i = 0; i < q->ndesc; i++)
+		en751221_qdma_reset_rx_desc(q, i);
+
+	/* On EN751221, equal CPU/HW indices mean that the RX ring is full. */
+	q->head = 0;
+	airoha_qdma_wr(qdma, EN751221_REG_RX_CPU_IDX, 0);
+	airoha_qdma_wr(qdma, EN751221_REG_RX_DMA_IDX, 1);
+}
+
+static int en751221_qdma_init_rx(struct airoha_qdma *qdma)
+{
+	struct airoha_queue *q = &qdma->q_rx[0];
+	unsigned long dma_addr;
+
+	q->ndesc = RX_DSCP_NUM;
+	q->desc = airoha_dma_alloc_coherent(q->ndesc * sizeof(*q->desc), &dma_addr);
+	if (!q->desc)
+		return -ENOMEM;
+
+	memset(q->desc, 0, q->ndesc * sizeof(*q->desc));
+	airoha_qdma_wr(qdma, EN751221_REG_RX_RING_BASE, dma_addr);
+	airoha_qdma_wr(qdma, EN751221_REG_RX_RING_SIZE, q->ndesc);
+	airoha_qdma_wr(qdma, EN751221_REG_RX_RING_THR, 0);
+
+	en751221_qdma_init_rx_desc(qdma);
+	return 0;
+}
+
+static int en751221_qdma_init_tx(struct airoha_qdma *qdma)
+{
+	struct airoha_queue *q = &qdma->q_tx[0];
+	unsigned long dma_addr;
+
+	q->ndesc = TX_DSCP_NUM;
+	q->head = 0;
+	q->desc = airoha_dma_alloc_coherent(q->ndesc * sizeof(*q->desc), &dma_addr);
+	if (!q->desc)
+		return -ENOMEM;
+
+	memset(q->desc, 0, q->ndesc * sizeof(*q->desc));
+	airoha_qdma_wr(qdma, EN751221_REG_TX_RING_BASE, dma_addr);
+	airoha_qdma_wr(qdma, EN751221_REG_TX_CPU_IDX, 0);
+	airoha_qdma_wr(qdma, EN751221_REG_TX_DMA_IDX, 0);
+
+	q->bounce = airoha_dma_alloc_coherent(AIROHA_MAX_PACKET_SIZE,
+					      &q->bounce_phys);
+	if (!q->bounce)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int en751221_qdma_init_tx_irq(struct airoha_qdma *qdma)
+{
+	struct airoha_tx_irq_queue *irq_q = &qdma->q_tx_irq[0];
+	unsigned long dma_addr;
+	u32 cfg;
+
+	irq_q->size = EN751221_IRQ_QUEUE_LEN;
+	irq_q->q = airoha_dma_alloc_coherent(irq_q->size * sizeof(u32),
+					     &dma_addr);
+	if (!irq_q->q)
+		return -ENOMEM;
+
+	irq_q->qdma = qdma;
+	memset(irq_q->q, 0xff, irq_q->size * sizeof(u32));
+	dma_map_single(irq_q->q, irq_q->size * sizeof(u32), DMA_TO_DEVICE);
+
+	airoha_qdma_wr(qdma, EN751221_REG_IRQ_BASE, dma_addr);
+	cfg = FIELD_PREP(EN751221_IRQ_THRESHOLD_MASK,
+			 EN751221_IRQ_THRESHOLD) |
+	      FIELD_PREP(EN751221_IRQ_DEPTH_MASK, irq_q->size);
+	airoha_qdma_wr(qdma, EN751221_REG_IRQ_CFG, cfg);
+
+	return 0;
+}
+
+static void en751221_qdma_reset_tx(struct airoha_qdma *qdma)
+{
+	struct airoha_queue *q = &qdma->q_tx[0];
+
+	memset(q->desc, 0, q->ndesc * sizeof(*q->desc));
+	dma_map_single(q->desc, q->ndesc * sizeof(*q->desc), DMA_TO_DEVICE);
+	q->head = 0;
+	airoha_qdma_wr(qdma, EN751221_REG_TX_CPU_IDX, 0);
+	airoha_qdma_wr(qdma, EN751221_REG_TX_DMA_IDX, 0);
+}
+
+static int en751221_qdma_init_hfwd(struct airoha_qdma *qdma)
+{
+	unsigned long dma_addr;
+	u32 status, val;
+	int size;
+
+	size = EN751221_HW_DSCP_NUM * sizeof(struct en751221_qdma_fwd_desc);
+	qdma->hfwd.desc = airoha_dma_alloc_coherent(size, &dma_addr);
+	if (!qdma->hfwd.desc)
+		return -ENOMEM;
+	memset(qdma->hfwd.desc, 0, size);
+	dma_map_single(qdma->hfwd.desc, size, DMA_TO_DEVICE);
+	airoha_qdma_wr(qdma, EN751221_REG_FWD_DSCP_BASE, dma_addr);
+
+	size = AIROHA_MAX_PACKET_SIZE * EN751221_HW_DSCP_NUM;
+	qdma->hfwd.q = airoha_dma_alloc_coherent(size, &dma_addr);
+	if (!qdma->hfwd.q)
+		return -ENOMEM;
+	memset(qdma->hfwd.q, 0, size);
+	dma_map_single(qdma->hfwd.q, size, DMA_TO_DEVICE);
+	airoha_qdma_wr(qdma, EN751221_REG_FWD_BUF_BASE, dma_addr);
+
+	/* en7528 stock: low_thr = 32 (hwf_cfg = 0x20), not 1. */
+	val = FIELD_PREP(HW_FWD_DSCP_PAYLOAD_SIZE_MASK, 0) |
+	      FIELD_PREP(EN751221_HWFWD_LOW_THR_MASK, 32);
+	airoha_qdma_wr(qdma, EN751221_REG_FWD_DSCP_CFG, val);
+
+	/*
+	 * en7528 stock LMGR init = 0x01140100 (OVERHEAD_EN + overhead 0x14 +
+	 * 256 descriptors). The borrowed value omitted OVERHEAD_EN and used
+	 * only 4 descriptors, starving the PSE store-and-forward pool so
+	 * CPU-injected frames were dropped after QDMA writeback DONE.
+	 */
+	val = LMGR_INIT_START |
+	      EN751221_HWFWD_OVERHEAD_EN |
+	      FIELD_PREP(EN751221_HWFWD_OVERHEAD_MASK, 0x14) |
+	      FIELD_PREP(EN751221_HWFWD_DESC_NUM_MASK,
+			 EN751221_HW_DSCP_NUM);
+	airoha_qdma_wr(qdma, EN751221_REG_LMGR_INIT_CFG, val);
+
+	return read_poll_timeout(airoha_qdma_rr, status,
+				 !(status & LMGR_INIT_START), USEC_PER_MSEC,
+				 30 * USEC_PER_MSEC, qdma,
+				 EN751221_REG_LMGR_INIT_CFG);
+}
+
+static int en751221_qdma_init(struct airoha_qdma *qdma)
+{
+	u32 cfg;
+	int ret;
+
+	/* Stop the engine before replacing all descriptor rings. */
+	airoha_qdma_wr(qdma, REG_QDMA_GLOBAL_CFG, 0);
+	airoha_qdma_wr(qdma, EN751221_REG_INT_ENABLE, 0);
+	airoha_qdma_wr(qdma, EN751221_REG_INT_STATUS, 0xffffffff);
+
+	ret = en751221_qdma_init_rx(qdma);
+	if (ret)
+		return ret;
+
+	ret = en751221_qdma_init_tx(qdma);
+	if (ret)
+		return ret;
+
+	ret = en751221_qdma_init_tx_irq(qdma);
+	if (ret)
+		return ret;
+
+	ret = en751221_qdma_init_hfwd(qdma);
+	if (ret)
+		return ret;
+
+	/*
+	 * EN7528: do NOT set GLOBAL_CFG_DSCP_BYTE_SWAP. The stock en7528
+	 * econet-eth driver programs qdma_cfg = 0x140800f5 (msg_word_swap +
+	 * payload_byte_swap, dscp_byte_swap = soc->dscp_byte_swap = false).
+	 * The mainline-airoha value this port borrowed set dscp_byte_swap,
+	 * byte-swapping the TX descriptor the QDMA reads (addr/msg/FPORT) so
+	 * the frame was routed nowhere while still reporting DONE. Matching
+	 * the stock value restores CPU->GDM1->switch egress.
+	 */
+	cfg = EN751221_GLOBAL_CFG_MSG_WORD_SWAP |
+	      GLOBAL_CFG_PAYLOAD_BYTE_SWAP_MASK |
+	      GLOBAL_CFG_IRQ0_EN_MASK |
+	      GLOBAL_CFG_CHECK_DONE_MASK |
+	      GLOBAL_CFG_TX_WB_DONE_MASK |
+	      FIELD_PREP(GLOBAL_CFG_MAX_ISSUE_NUM_MASK, 3);
+	airoha_qdma_wr(qdma, REG_QDMA_GLOBAL_CFG, cfg);
+	airoha_qdma_wr(qdma, EN751221_REG_RX_DELAY_INT, 0);
+
+	return 0;
+}
+
 static void airoha_qdma_reset_rx_desc(struct airoha_queue *q, int index)
 {
 	struct airoha_qdma_desc *desc;
@@ -501,7 +887,7 @@ static int airoha_qdma_init_rx_queue(struct airoha_queue *q,
 	q->ndesc = ndesc;
 	q->head = 0;
 
-	q->desc = dma_alloc_coherent(q->ndesc * sizeof(*q->desc), &dma_addr);
+	q->desc = airoha_dma_alloc_coherent(q->ndesc * sizeof(*q->desc), &dma_addr);
 	if (!q->desc)
 		return -ENOMEM;
 
@@ -548,7 +934,7 @@ static int airoha_qdma_init_tx_queue(struct airoha_queue *q,
 	q->ndesc = size;
 	q->head = 0;
 
-	q->desc = dma_alloc_coherent(q->ndesc * sizeof(*q->desc), &dma_addr);
+	q->desc = airoha_dma_alloc_coherent(q->ndesc * sizeof(*q->desc), &dma_addr);
 	if (!q->desc)
 		return -ENOMEM;
 
@@ -570,7 +956,7 @@ static int airoha_qdma_tx_irq_init(struct airoha_tx_irq_queue *irq_q,
 	int id = irq_q - &qdma->q_tx_irq[0];
 	unsigned long dma_addr;
 
-	irq_q->q = dma_alloc_coherent(size * sizeof(u32), &dma_addr);
+	irq_q->q = airoha_dma_alloc_coherent(size * sizeof(u32), &dma_addr);
 	if (!irq_q->q)
 		return -ENOMEM;
 
@@ -615,7 +1001,7 @@ static int airoha_qdma_init_hfwd_queues(struct airoha_qdma *qdma)
 	int size;
 
 	size = HW_DSCP_NUM * sizeof(struct airoha_qdma_fwd_desc);
-	qdma->hfwd.desc = dma_alloc_coherent(size, &dma_addr);
+	qdma->hfwd.desc = airoha_dma_alloc_coherent(size, &dma_addr);
 	if (!qdma->hfwd.desc)
 		return -ENOMEM;
 
@@ -625,7 +1011,7 @@ static int airoha_qdma_init_hfwd_queues(struct airoha_qdma *qdma)
 	airoha_qdma_wr(qdma, REG_FWD_DSCP_BASE, dma_addr);
 
 	size = AIROHA_MAX_PACKET_SIZE * HW_DSCP_NUM;
-	qdma->hfwd.q = dma_alloc_coherent(size, &dma_addr);
+	qdma->hfwd.q = airoha_dma_alloc_coherent(size, &dma_addr);
 	if (!qdma->hfwd.q)
 		return -ENOMEM;
 
@@ -689,6 +1075,8 @@ static int airoha_qdma_init(struct udevice *dev,
 	qdma->regs = dev_remap_addr_name(dev, "qdma0");
 	if (IS_ERR(qdma->regs))
 		return PTR_ERR(qdma->regs);
+	if (airoha_is_en751221(eth))
+		return en751221_qdma_init(qdma);
 
 	err = airoha_qdma_init_rx(qdma);
 	if (err)
@@ -735,11 +1123,51 @@ static int airoha_pcs_init(struct udevice *dev)
 }
 #endif
 
+static int en751221_hw_init(struct udevice *dev, struct airoha_eth *eth)
+{
+	u32 val, val2;
+	int ret;
+
+	/* Expose the frame-engine register window instead of the FE SRAM. */
+	__raw_writel(0, (void __iomem *)EN751221_FE_SRAM_SEL);
+
+	/*
+	 * Reset the SAME FIVE frame-engine domains the stock econet-eth DT eth
+	 * node resets as one array pulse: {fe, qdma0=FE_QDMA1, qdma1=FE_QDMA2,
+	 * xpon-mac, xpon-phy}. The earlier port reset only qdma0(bit1)+fe(bit21)
+	 * and left FE_QDMA2 (bank1 bit2) — the second FE-DMA domain that gates
+	 * the QDMA<->PSE store-and-forward datapath shared by both QDMAs — in its
+	 * bootbase state. That back-pressures qdma0's drain: the first CPU-TX
+	 * latches TX_DMA_BUSY (qdma_cfg .f2) but the frame never reaches
+	 * GDM1/egress and tx_hwi never advances. Assert all five, hold, deassert.
+	 */
+	val = __raw_readl((void __iomem *)EN751221_RESET_CONTROL_B1);
+	val2 = __raw_readl((void __iomem *)EN751221_RESET_CONTROL_B0);
+	__raw_writel(val | EN751221_RST_QDMA0 | EN751221_RST_QDMA1 |
+		     EN751221_RST_FE | EN751221_RST_XPON_MAC,
+		     (void __iomem *)EN751221_RESET_CONTROL_B1);
+	__raw_writel(val2 | EN751221_RST_XPON_PHY,
+		     (void __iomem *)EN751221_RESET_CONTROL_B0);
+	mdelay(20);
+	__raw_writel(val, (void __iomem *)EN751221_RESET_CONTROL_B1);
+	__raw_writel(val2, (void __iomem *)EN751221_RESET_CONTROL_B0);
+	mdelay(20);
+
+	ret = airoha_qdma_init(dev, eth, &eth->qdma[0]);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static int airoha_hw_init(struct udevice *dev,
 			  struct airoha_eth *eth)
 {
 	int ret, i;
 
+	if (airoha_is_en751221(eth))
+		return en751221_hw_init(dev, eth);
+
 	/* disable xsi */
 	ret = reset_assert_bulk(&eth->xsi_rsts);
 	if (ret)
@@ -787,6 +1215,86 @@ static int airoha_switch_init(struct udevice *dev, struct airoha_eth *eth)
 
 	/* Switch doesn't have a DEV, gets address and setup Flood and CPU port */
 	eth->switch_regs = map_sysmem(addr, 0);
+	if (data->econet) {
+		u32 pmcr;
+
+		/*
+		 * Soft-reset the integrated MT7530 switch core to a known state
+		 * before (re)configuring it, mirroring mt7531_setup(): the stock
+		 * bootbase leaves it in its own config. SYS_CTRL @0x7000, bits
+		 * SW_SYS_RST|SW_REG_RST self-clear when the reset completes.
+		 */
+		airoha_switch_wr(eth, 0x7000, 0x3);
+		mdelay(100);
+
+		/* Integrated MT7530: flood unknown traffic to all ports and use P6. */
+		airoha_switch_wr(eth, SWITCH_MFC,
+				 SWITCH_BC_FFP | SWITCH_UNM_FFP | SWITCH_UNU_FFP |
+				 SWITCH_CPU_EN | FIELD_PREP(SWITCH_CPU_PORT, 6));
+
+		pmcr = SWITCH_MAC_MODE | SWITCH_FORCE_MODE | SWITCH_MAC_TX_EN |
+		       SWITCH_MAC_RX_EN | SWITCH_BKOFF_EN | SWITCH_BKPR_EN |
+		       SWITCH_FORCE_SPD_1000 | SWITCH_FORCE_DPX |
+		       SWITCH_FORCE_LNK;
+
+		/*
+		 * P5 is the TRGMII cascade to the external MCM switch while P6
+		 * is the CPU port.  The EN751221 OEM setup uses shrink IPG only
+		 * on the cascade and short IPG on the CPU link.
+		 */
+		airoha_switch_wr(eth, SWITCH_PMCR(5),
+				 pmcr | SWITCH_IPG_CFG_SHRINK);
+		airoha_switch_wr(eth, SWITCH_PMCR(6),
+				 pmcr | SWITCH_IPG_CFG_SHORT);
+		airoha_switch_wr(eth, SWITCH_PHY_POLL, 0x7f7f8c08);
+
+		/*
+		 * EN7528 LAN ports 1-4 (internal GPHYs at MDIO 9-12): enable the
+		 * MAC but DO NOT force the link. Leaving FORCE_MODE clear lets the
+		 * switch PHY-poll (SWITCH_PHY_POLL, set just above) drive each port
+		 * MAC to the speed/duplex the GPHY actually negotiates with its
+		 * peer. Force-linking these at 1G silently breaks egress to a
+		 * 100M/10M peer: the MAC<->GPHY line rate mismatches, so a CPU-TX
+		 * frame leaves GDM1 (GDM1 TX MIB increments) but never reaches the
+		 * RJ45. Proven on HW with a 100M host — forced 1G => 0 egress, auto
+		 * => ping/traffic works and PMSR reports the real 100M FDX link.
+		 * (Ports 5/6 keep the forced-1G `pmcr` above: those are the fixed
+		 * internal CPU/cascade links, not GPHY line ports.)
+		 */
+		{
+			u32 lan_pmcr = SWITCH_MAC_MODE | SWITCH_MAC_TX_EN |
+				       SWITCH_MAC_RX_EN | SWITCH_BKOFF_EN |
+				       SWITCH_BKPR_EN | SWITCH_IPG_CFG_NORMAL;
+			int p;
+
+			for (p = 1; p <= 4; p++)
+				airoha_switch_wr(eth, SWITCH_PMCR(p), lan_pmcr);
+		}
+
+		/*
+		 * EN7528: the integrated MT7530 needs its per-port forwarding
+		 * matrix programmed, or no frames pass between ports (the LAN
+		 * GPHYs at MDIO 9-12 are already powered and link fine; the
+		 * en7512 econet stub only set MFC/PMCR and never the matrix).
+		 * Give each user port (0-5) a matrix pointing at the CPU port
+		 * (6) and the CPU port a matrix of all user ports, and mark
+		 * every port a VLAN user port. Mirrors mt753x_port_isolation()
+		 * / mt7988_setup(): PCR = 0x2004 + p*0x100 (matrix at bit 16),
+		 * PVC = 0x2010 + p*0x100 (STAG 0x8100, VLAN_ATTR_USER).
+		 */
+		{
+			int p;
+
+			for (p = 0; p < 7; p++) {
+				airoha_switch_wr(eth, 0x2004 + p * 0x100,
+						 (u32)(p == 6 ? 0x3f : 0x40) << 16);
+				airoha_switch_wr(eth, 0x2010 + p * 0x100,
+						 0x81000000);
+			}
+		}
+
+		return 0;
+	}
 
 	/* Set FLOOD, no CPU switch register */
 	airoha_switch_wr(eth, SWITCH_MFC, SWITCH_BC_FFP | SWITCH_UNM_FFP |
@@ -809,6 +1317,59 @@ static int airoha_switch_init(struct udevice *dev, struct airoha_eth *eth)
 			 FIELD_PREP(SWITCH_PHY_END_ADDR, 0xc) |
 			 FIELD_PREP(SWITCH_PHY_ST_ADDR, 0x8));
 
+	/* AN7583 require tweak to GEPHY_CONN_CFG and clear PHY BMCR_PDOWN */
+	if (!strcmp(data->switch_compatible, "airoha,an7583-switch")) {
+		int i;
+
+		airoha_switch_rmw(eth, SWITCH_GEPHY_CONN_CFG,
+				  SWITCH_DPHY_CKIN_SEL |
+				  SWITCH_PHY_CORE_REG_CLK_SEL |
+				  SWITCH_ETHER_AFE_PWD,
+				  SWITCH_DPHY_CKIN_SEL |
+				  SWITCH_PHY_CORE_REG_CLK_SEL |
+				  FIELD_PREP(SWITCH_ETHER_AFE_PWD, 0));
+
+		/* Disable BMCR_PDOWN for every PHY */
+		for (i = 0; i < AIROHA_MAX_NUM_SWITCH_PORT; i++) {
+			int try;
+			u32 val;
+
+			airoha_switch_wr(eth, SWITCH_PBUS_PHY_IAC,
+					 SWITCH_PBUS_PHY_START |
+					 SWITCH_PBUS_PHY_CMD_READ |
+					 FIELD_PREP(SWITCH_PBUS_PHY_PORTADDR, i) |
+					 FIELD_PREP(SWITCH_PBUS_PHY_REGADDR,
+						    AIROHA_PBUS_C22_MASK | MII_BMCR));
+
+			for (try = 0; try < AIROHA_MAX_PBUS_TRY; try++) {
+				val = airoha_switch_rr(eth, SWITCH_PBUS_PHY_IAC);
+				if (!(val & SWITCH_PBUS_PHY_START))
+					break;
+
+				udelay(AIROHA_PBUS_SLEEP);
+			}
+
+			val = airoha_switch_rr(eth, SWITCH_PBUS_PHY_IARD);
+			val &= ~BMCR_PDOWN;
+
+			airoha_switch_wr(eth, SWITCH_PBUS_PHY_IAWD, val);
+			airoha_switch_wr(eth, SWITCH_PBUS_PHY_IAC,
+					 SWITCH_PBUS_PHY_START |
+					 SWITCH_PBUS_PHY_CMD_WRITE |
+					 FIELD_PREP(SWITCH_PBUS_PHY_PORTADDR, i) |
+					 FIELD_PREP(SWITCH_PBUS_PHY_REGADDR,
+						    AIROHA_PBUS_C22_MASK | MII_BMCR));
+
+			for (try = 0; try < AIROHA_MAX_PBUS_TRY; try++) {
+				val = airoha_switch_rr(eth, SWITCH_PBUS_PHY_IAC);
+				if (!(val & SWITCH_PBUS_PHY_START))
+					break;
+
+				udelay(AIROHA_PBUS_SLEEP);
+			}
+		}
+	}
+
 	return 0;
 }
 
@@ -828,6 +1389,8 @@ static int airoha_alloc_gdm_port(struct udevice *dev, ofnode node)
 	ret = ofnode_read_u32(node, "reg", &id);
 	if (ret)
 		return ret;
+	if (eth->soc->econet)
+		id++;
 
 	if (id > AIROHA_MAX_NUM_GDM_PORTS)
 		return -EINVAL;
@@ -882,56 +1445,65 @@ static int airoha_eth_probe(struct udevice *dev)
 {
 	struct airoha_eth_soc_data *data = (void *)dev_get_driver_data(dev);
 	struct airoha_eth *eth = dev_get_priv(dev);
-	struct regmap *scu_regmap;
 	struct udevice *mdio_dev;
 	ofnode node;
 	int i, ret;
 
-	scu_regmap = airoha_get_scu_regmap();
-	if (IS_ERR(scu_regmap))
-		return PTR_ERR(scu_regmap);
+	eth->soc = data;
+	if (!data->econet) {
+#if IS_ENABLED(CONFIG_ARCH_AIROHA)
+		struct regmap *scu_regmap;
 
-	/* It seems by default the FEMEM_SEL is set to Memory (0x1)
-	 * preventing any access to any QDMA and FrameEngine register
-	 * reporting all 0xdeadbeef (poor cow :( )
-	 */
-	regmap_write(scu_regmap, SCU_SHARE_FEMEM_SEL, 0x0);
+		scu_regmap = airoha_get_scu_regmap();
+		if (IS_ERR(scu_regmap))
+			return PTR_ERR(scu_regmap);
 
-	eth->soc = data;
+		/* FEMEM_SEL=1 hides QDMA/FE behind the shared SRAM window. */
+		regmap_write(scu_regmap, SCU_SHARE_FEMEM_SEL, 0x0);
+#else
+		return -EOPNOTSUPP;
+#endif
+	}
 
 	eth->fe_regs = dev_remap_addr_name(dev, "fe");
 	if (!eth->fe_regs)
 		return -ENOMEM;
 
-	eth->rsts.resets = devm_kcalloc(dev, AIROHA_MAX_NUM_RSTS,
-					sizeof(struct reset_ctl), GFP_KERNEL);
-	if (!eth->rsts.resets)
-		return -ENOMEM;
-	eth->rsts.count = AIROHA_MAX_NUM_RSTS;
+	if (!data->econet) {
+		eth->rsts.resets = devm_kcalloc(dev, AIROHA_MAX_NUM_RSTS,
+						sizeof(struct reset_ctl), GFP_KERNEL);
+		if (!eth->rsts.resets)
+			return -ENOMEM;
+		eth->rsts.count = AIROHA_MAX_NUM_RSTS;
 
-	eth->xsi_rsts.resets = devm_kcalloc(dev, data->num_xsi_rsts,
-					    sizeof(struct reset_ctl), GFP_KERNEL);
-	if (!eth->xsi_rsts.resets)
-		return -ENOMEM;
-	eth->xsi_rsts.count = data->num_xsi_rsts;
+		eth->xsi_rsts.resets = devm_kcalloc(dev, data->num_xsi_rsts,
+						    sizeof(struct reset_ctl), GFP_KERNEL);
+		if (!eth->xsi_rsts.resets)
+			return -ENOMEM;
+		eth->xsi_rsts.count = data->num_xsi_rsts;
 
-	ret = reset_get_by_name(dev, "fe", &eth->rsts.resets[0]);
-	if (ret)
-		return ret;
+		ret = reset_get_by_name(dev, "fe", &eth->rsts.resets[0]);
+		if (ret)
+			return ret;
 
-	ret = reset_get_by_name(dev, "pdma", &eth->rsts.resets[1]);
-	if (ret)
-		return ret;
+		ret = reset_get_by_name(dev, "pdma", &eth->rsts.resets[1]);
+		if (ret)
+			return ret;
 
-	ret = reset_get_by_name(dev, "qdma", &eth->rsts.resets[2]);
-	if (ret)
-		return ret;
+		ret = reset_get_by_name(dev, "qdma", &eth->rsts.resets[2]);
+		if (ret)
+			return ret;
 
-	for (i = 0; i < data->num_xsi_rsts; i++) {
-		ret = reset_get_by_name(dev, data->xsi_rsts_names[i],
-					&eth->xsi_rsts.resets[i]);
+		ret = reset_get_by_name(dev, "switch", &eth->rsts.resets[3]);
 		if (ret)
 			return ret;
+
+		for (i = 0; i < data->num_xsi_rsts; i++) {
+			ret = reset_get_by_name(dev, data->xsi_rsts_names[i],
+						&eth->xsi_rsts.resets[i]);
+			if (ret)
+				return ret;
+		}
 	}
 
 	ret = airoha_hw_init(dev, eth);
@@ -943,12 +1515,15 @@ static int airoha_eth_probe(struct udevice *dev)
 		return ret;
 
 	/* Airoha switch mdio PHYs maybe used by several GDM devices */
-	mdio_dev = airoha_switch_mdio_init(dev);
-	if (!IS_ERR_OR_NULL(mdio_dev))
-		eth->switch_mdio_dev = mdio_dev;
+	if (!data->econet) {
+		mdio_dev = airoha_switch_mdio_init(dev);
+		if (!IS_ERR_OR_NULL(mdio_dev))
+			eth->switch_mdio_dev = mdio_dev;
+	}
 
 	ofnode_for_each_subnode(node, dev_ofnode(dev)) {
-		if (!ofnode_device_is_compatible(node, "airoha,eth-mac"))
+		if (!ofnode_device_is_compatible(node, "airoha,eth-mac") &&
+		    !ofnode_device_is_compatible(node, "econet,eth-mac"))
 			continue;
 
 		if (!ofnode_is_enabled(node))
@@ -964,9 +1539,18 @@ static int airoha_eth_probe(struct udevice *dev)
 
 static int airoha_eth_port_of_to_plat(struct udevice *dev)
 {
+	struct airoha_eth *eth = (void *)dev_get_driver_data(dev);
 	struct airoha_gdm_port *port = dev_get_priv(dev);
+	u32 id;
+	int ret;
+
+	ret = dev_read_u32(dev, "reg", &id);
+	if (ret)
+		return ret;
+
+	port->id = id + (eth->soc->econet ? 1 : 0);
 
-	return dev_read_u32(dev, "reg", &port->id);
+	return 0;
 }
 
 static int airoha_eth_port_probe(struct udevice *dev)
@@ -992,6 +1576,9 @@ static int airoha_eth_port_probe(struct udevice *dev)
 		return -EINVAL;
 #endif
 	} else {
+		if (eth->soc->econet)
+			return 0;
+
 		/*
 		 * GDM1 device connected to airoha switch. Probe airoha switch
 		 * mdio to be able set/query states of corresponding LAN ports.
@@ -1016,7 +1603,12 @@ static int airoha_eth_init(struct udevice *dev)
 	qid = 0;
 	q = &qdma->q_rx[qid];
 
-	airoha_qdma_init_rx_desc(q);
+	if (airoha_is_en751221(qdma->eth))
+		en751221_qdma_init_rx_desc(qdma);
+	else
+		airoha_qdma_init_rx_desc(q);
+	if (airoha_is_en751221(qdma->eth))
+		en751221_qdma_reset_tx(qdma);
 
 	airoha_qdma_set(qdma, REG_QDMA_GLOBAL_CFG,
 			GLOBAL_CFG_TX_DMA_EN_MASK |
@@ -1087,6 +1679,129 @@ static void airoha_eth_stop(struct udevice *dev)
 			  GLOBAL_CFG_RX_DMA_EN_MASK);
 }
 
+static int en751221_eth_send(struct udevice *dev, void *packet, int length)
+{
+	struct airoha_gdm_port *port = dev_get_priv(dev);
+	struct airoha_qdma *qdma = port->qdma;
+	struct airoha_queue *q = &qdma->q_tx[0];
+	struct airoha_qdma_desc *desc;
+	u32 index, next, ctrl = 0, irq_status = 0;
+	int i;
+
+	index = q->head;
+	next = (index + 1) % q->ndesc;
+	desc = &q->desc[index];
+
+	/*
+	 * Stage the frame in the KSEG1 bounce buffer (see
+	 * airoha_dma_alloc_coherent). desc and bounce are uncached, so the
+	 * writes land in DRAM; no map/flush.
+	 */
+	memcpy(q->bounce, packet, length);
+
+	WRITE_ONCE(desc->rsv, 0);
+	WRITE_ONCE(desc->ctrl, FIELD_PREP(QDMA_DESC_LEN_MASK, length));
+	WRITE_ONCE(desc->addr, q->bounce_phys);
+	WRITE_ONCE(desc->data, next);
+	WRITE_ONCE(desc->msg0,
+		   FIELD_PREP(EN751221_TXMSG_CHANNEL_MASK, 0) |
+		   FIELD_PREP(EN751221_TXMSG_QUEUE_MASK, 0));
+	WRITE_ONCE(desc->msg1,
+		   FIELD_PREP(EN751221_TXMSG_FPORT_MASK,
+			      EN751221_FPORT_GDM1));
+	WRITE_ONCE(desc->msg2, 0);
+	WRITE_ONCE(desc->msg3, 0);
+
+	airoha_qdma_wr(qdma, EN751221_REG_TX_CPU_IDX, next);
+
+	for (i = 0; i < 10000; i++) {
+		ctrl = READ_ONCE(desc->ctrl);
+		if (ctrl & QDMA_DESC_DONE_MASK)
+			break;
+		udelay(1);
+	}
+
+	if (!(ctrl & QDMA_DESC_DONE_MASK))
+		return -ETIMEDOUT;
+
+	for (i = 0; i < 10000; i++) {
+		irq_status = airoha_qdma_rr(qdma, EN751221_REG_IRQ_STATUS);
+		if (FIELD_GET(EN751221_IRQ_ENTRY_LEN_MASK, irq_status))
+			break;
+		udelay(1);
+	}
+	if (!FIELD_GET(EN751221_IRQ_ENTRY_LEN_MASK, irq_status))
+		return -ETIMEDOUT;
+
+	/*
+	 * QDMA consumes one hardware-forward descriptor for each CPU TX
+	 * context.  Advancing the completion queue returns that descriptor
+	 * to LMGR; without this, the four-entry first-light pool is exhausted
+	 * after four packets even though TX writeback reports DONE.
+	 */
+	airoha_qdma_rmw(qdma, EN751221_REG_IRQ_CLEAR_LEN,
+			EN751221_IRQ_CLEAR_LEN_MASK, 1);
+
+	q->head = next;
+	return 0;
+}
+
+static int en751221_eth_recv(struct udevice *dev, uchar **packetp)
+{
+	struct airoha_gdm_port *port = dev_get_priv(dev);
+	struct airoha_qdma *qdma = port->qdma;
+	struct airoha_queue *q = &qdma->q_rx[0];
+	struct airoha_qdma_desc *desc;
+	uchar *rx_packet;
+	u32 index, hw_index, length, addr;
+
+	index = (q->head + 1) % q->ndesc;
+	hw_index = airoha_qdma_rr(qdma, EN751221_REG_RX_DMA_IDX) &
+		   EN751221_RING_IDX_MASK;
+	if (index == hw_index)
+		return -EAGAIN;
+
+	desc = &q->desc[index];
+	dma_unmap_unaligned((dma_addr_t)desc, sizeof(*desc),
+			    DMA_FROM_DEVICE);
+	length = FIELD_GET(QDMA_DESC_LEN_MASK, READ_ONCE(desc->ctrl));
+	addr = READ_ONCE(desc->addr);
+	if (!length || length > PKTSIZE_ALIGN) {
+		en751221_qdma_reset_rx_desc(q, index);
+		airoha_qdma_wr(qdma, EN751221_REG_RX_CPU_IDX, index);
+		q->head = index;
+		return -EIO;
+	}
+
+	/*
+	 * Hand U-Boot the KSEG1 alias of the received frame. QDMA wrote DRAM
+	 * directly; a cached read can still hit a stale L2 line because this
+	 * CM cannot Hit_Writeback_Inv_SD (see airoha_dma_alloc_coherent).
+	 */
+	rx_packet = (uchar *)CKSEG1ADDR((unsigned long)addr);
+	*packetp = rx_packet;
+
+	return length;
+}
+
+static int en751221_eth_free_pkt(struct udevice *dev, uchar *packet)
+{
+	struct airoha_gdm_port *port = dev_get_priv(dev);
+	struct airoha_qdma *qdma = port->qdma;
+	struct airoha_queue *q = &qdma->q_rx[0];
+	u32 index;
+
+	if (!packet)
+		return 0;
+
+	index = (q->head + 1) % q->ndesc;
+	en751221_qdma_reset_rx_desc(q, index);
+	airoha_qdma_wr(qdma, EN751221_REG_RX_CPU_IDX, index);
+	q->head = index;
+
+	return 0;
+}
+
 static int airoha_eth_send(struct udevice *dev, void *packet, int length)
 {
 	struct airoha_gdm_port *port = dev_get_priv(dev);
@@ -1100,6 +1815,9 @@ static int airoha_eth_send(struct udevice *dev, void *packet, int length)
 	u32 val;
 	int i;
 
+	if (airoha_is_en751221(qdma->eth))
+		return en751221_eth_send(dev, packet, length);
+
 	/*
 	 * There is no need to pad short TX packets to 60 bytes since the
 	 * GDM_PAD_EN bit set in the corresponding REG_GDM_FWD_CFG(n) register.
@@ -1161,6 +1879,9 @@ static int airoha_eth_recv(struct udevice *dev, int flags, uchar **packetp)
 	u16 length;
 	int qid;
 
+	if (airoha_is_en751221(qdma->eth))
+		return en751221_eth_recv(dev, packetp);
+
 	qid = 0;
 	q = &qdma->q_rx[qid];
 	desc = &q->desc[q->head];
@@ -1187,6 +1908,9 @@ static int arht_eth_free_pkt(struct udevice *dev, uchar *packet, int length)
 	struct airoha_queue *q;
 	int qid;
 
+	if (airoha_is_en751221(qdma->eth))
+		return en751221_eth_free_pkt(dev, packet);
+
 	if (!packet)
 		return 0;
 
@@ -1237,6 +1961,11 @@ static int arht_eth_write_hwaddr(struct udevice *dev)
 	macaddr_msb = FIELD_PREP(SMACCR1_MAC1, mac[1]) |
 		      FIELD_PREP(SMACCR1_MAC0, mac[0]);
 
+	if (airoha_is_en751221(qdma->eth)) {
+		airoha_fe_wr(qdma->eth, REG_GDM_MAC_LSB(port->id), macaddr_lsb);
+		airoha_fe_wr(qdma->eth, REG_GDM_MAC_MSB(port->id), macaddr_msb);
+	}
+
 	/* Set MAC for Switch */
 	airoha_switch_wr(qdma->eth, SWITCH_SMACCR0, macaddr_lsb);
 	airoha_switch_wr(qdma->eth, SWITCH_SMACCR1, macaddr_msb);
@@ -1246,11 +1975,20 @@ static int arht_eth_write_hwaddr(struct udevice *dev)
 
 static int airoha_eth_bind(struct udevice *dev)
 {
+	const struct airoha_eth_soc_data *data;
+
+	data = (const void *)dev_get_driver_data(dev);
+
 	/*
-	 * Force Probe as we set the Main ETH driver as misc
-	 * to register multiple eth port for each GDM
+	 * Force probe on Airoha ARM SoCs since the parent is a misc device
+	 * responsible for registering the child GDM Ethernet devices.  Do not
+	 * probe EN751221 here: DM_FLAG_PROBE_AFTER_BIND is handled by
+	 * initr_dm_devices() before serial_initialize(), which makes an early
+	 * QDMA/switch failure look like a silent hang.  The EN751221 board
+	 * probes this parent from board_late_init(), immediately before net init.
 	 */
-	dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
+	if (!data || !data->econet)
+		dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
 
 	return 0;
 }
@@ -1262,6 +2000,12 @@ static const struct airoha_eth_soc_data en7523_data = {
 	.switch_compatible = "airoha,en7523-switch",
 };
 
+static const struct airoha_eth_soc_data en751221_data = {
+	.version = 0x7512,
+	.econet = true,
+	.switch_compatible = "mediatek,mt7530",
+};
+
 static const struct airoha_eth_soc_data en7581_data = {
 	.version = 0x7581,
 	.xsi_rsts_names = en7581_xsi_rsts_names,
@@ -1269,13 +2013,25 @@ static const struct airoha_eth_soc_data en7581_data = {
 	.switch_compatible = "airoha,en7581-switch",
 };
 
+static const struct airoha_eth_soc_data an7583_data = {
+	.xsi_rsts_names = an7583_xsi_rsts_names,
+	.num_xsi_rsts = ARRAY_SIZE(an7583_xsi_rsts_names),
+	.switch_compatible = "airoha,an7583-switch",
+};
+
 static const struct udevice_id airoha_eth_ids[] = {
+	{ .compatible = "econet,en751221-eth",
+	  .data = (ulong)&en751221_data,
+	},
 	{ .compatible = "airoha,en7523-eth",
 	  .data = (ulong)&en7523_data,
 	},
 	{ .compatible = "airoha,en7581-eth",
 	  .data = (ulong)&en7581_data,
 	},
+	{ .compatible = "airoha,an7583-eth",
+	  .data = (ulong)&an7583_data,
+	},
 	{ }
 };
 
-- 
2.53.0

