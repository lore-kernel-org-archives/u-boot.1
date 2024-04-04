Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF512CD1284
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 07:08:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BB1988278;
	Thu,  4 Apr 2024 09:08:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="q11okjJ6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86DA3882C8; Thu,  4 Apr 2024 09:08:19 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6C9388235
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 09:08:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danishanwar@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 434789AM096156;
 Thu, 4 Apr 2024 02:08:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1712214489;
 bh=F3xHYxGTmOvuyxvx0u99ffuGmeIZENxvcd2JS1gt5bU=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=q11okjJ6fgstQApOzAVVlqldAxX1tatzjMc1ByU+I64L/aSsdYBAWG7SnVhlnNtIn
 8BcSDi6GoH+Xg8MK1+l6UWOnAQfaGmdqQseJhyMnVHeQdF79o/UyNdhJsJvdnPEs9h
 11la7m6hGe6uSxlleJAdoM1Cp75CwrvgSHBUJBfM=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 434789fd096207
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 4 Apr 2024 02:08:09 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 Apr 2024 02:08:08 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 Apr 2024 02:08:09 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 434788U7091084;
 Thu, 4 Apr 2024 02:08:08 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
 by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 434787TD013454;
 Thu, 4 Apr 2024 02:08:08 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Ravi Gunasekaran <r-gunasekaran@ti.com>, Maxime Ripard
 <mripard@kernel.org>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Nishanth Menon <nm@ti.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 MD Danish Anwar <danishanwar@ti.com>, Aradhya
 Bhatia <a-bhatia1@ti.com>, Devarsh Thakkar <devarsht@ti.com>, Simon Glass
 <sjg@chromium.org>, Kamlesh Gurudasani <kamlesh@ti.com>, Christian Gmeiner
 <christian.gmeiner@gmail.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Andrew
 Davis <afd@ti.com>, Ramon Fried <rfried.dev@gmail.com>, Joe Hershberger
 <joe.hershberger@ni.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH v5 1/5] net: ti: icssg: Add Firmware Interface for ICSSG
 Ethernet driver.
Date: Thu, 4 Apr 2024 12:37:59 +0530
Message-ID: <20240404070803.2455207-2-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240404070803.2455207-1-danishanwar@ti.com>
References: <20240404070803.2455207-1-danishanwar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Add firmware interface related headers and macros for ICSSG Ethernet
driver. These macros will be later used by the ICSSG ethernet driver.

Reviewed-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/net/ti/icssg_switch_map.h | 209 ++++++++++++++++++++++++++++++
 1 file changed, 209 insertions(+)
 create mode 100644 drivers/net/ti/icssg_switch_map.h

diff --git a/drivers/net/ti/icssg_switch_map.h b/drivers/net/ti/icssg_switch_map.h
new file mode 100644
index 0000000000..b62c51407b
--- /dev/null
+++ b/drivers/net/ti/icssg_switch_map.h
@@ -0,0 +1,209 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Texas Instruments ICSSG Ethernet driver
+ *
+ * Copyright (C) 2020-2024 Texas Instruments Incorporated - https://www.ti.com/
+ *
+ */
+
+#ifndef __NET_TI_ICSSG_SWITCH_MAP_H
+#define __NET_TI_ICSSG_SWITCH_MAP_H
+
+/*Time after which FDB entries are checked for aged out values. Value in nanoseconds*/
+#define FDB_AGEING_TIMEOUT_OFFSET                          0x0014
+
+/*default VLAN tag for Host Port*/
+#define HOST_PORT_DF_VLAN_OFFSET                           0x001C
+
+/*Same as HOST_PORT_DF_VLAN_OFFSET*/
+#define EMAC_ICSSG_SWITCH_PORT0_DEFAULT_VLAN_OFFSET        HOST_PORT_DF_VLAN_OFFSET
+
+/*default VLAN tag for P1 Port*/
+#define P1_PORT_DF_VLAN_OFFSET                             0x0020
+
+/*Same as P1_PORT_DF_VLAN_OFFSET*/
+#define EMAC_ICSSG_SWITCH_PORT1_DEFAULT_VLAN_OFFSET        P1_PORT_DF_VLAN_OFFSET
+
+/*default VLAN tag for P2 Port*/
+#define P2_PORT_DF_VLAN_OFFSET                             0x0024
+
+/*Same as P2_PORT_DF_VLAN_OFFSET*/
+#define EMAC_ICSSG_SWITCH_PORT2_DEFAULT_VLAN_OFFSET        P2_PORT_DF_VLAN_OFFSET
+
+/*VLAN-FID Table offset. 4096 VIDs. 2B per VID = 8KB = 0x2000*/
+#define VLAN_STATIC_REG_TABLE_OFFSET                       0x0100
+
+/*VLAN-FID Table offset for EMAC*/
+#define EMAC_ICSSG_SWITCH_DEFAULT_VLAN_TABLE_OFFSET        VLAN_STATIC_REG_TABLE_OFFSET
+
+/*packet descriptor Q reserved memory*/
+#define PORT_DESC0_HI                                      0x2104
+
+/*packet descriptor Q reserved memory*/
+#define PORT_DESC0_LO                                      0x2F6C
+
+/*packet descriptor Q reserved memory*/
+#define PORT_DESC1_HI                                      0x3DD4
+
+/*packet descriptor Q reserved memory*/
+#define PORT_DESC1_LO                                      0x4C3C
+
+/*packet descriptor Q reserved memory*/
+#define HOST_DESC0_HI                                      0x5AA4
+
+/*packet descriptor Q reserved memory*/
+#define HOST_DESC0_LO                                      0x5F0C
+
+/*packet descriptor Q reserved memory*/
+#define HOST_DESC1_HI                                      0x6374
+
+/*packet descriptor Q reserved memory*/
+#define HOST_DESC1_LO                                      0x67DC
+
+/*special packet descriptor Q reserved memory*/
+#define HOST_SPPD0                                         0x7AAC
+
+/*special packet descriptor Q reserved memory*/
+#define HOST_SPPD1                                         0x7EAC
+
+/*_Small_Description_*/
+#define TIMESYNC_FW_WC_CYCLECOUNT_OFFSET                   0x83EC
+
+/*IEP count hi roll over count*/
+#define TIMESYNC_FW_WC_HI_ROLLOVER_COUNT_OFFSET            0x83F4
+
+/*_Small_Description_*/
+#define TIMESYNC_FW_WC_COUNT_HI_SW_OFFSET_OFFSET           0x83F8
+
+/*Set clock descriptor*/
+#define TIMESYNC_FW_WC_SETCLOCK_DESC_OFFSET                0x83FC
+
+/*_Small_Description_*/
+#define TIMESYNC_FW_WC_SYNCOUT_REDUCTION_FACTOR_OFFSET     0x843C
+
+/*_Small_Description_*/
+#define TIMESYNC_FW_WC_SYNCOUT_REDUCTION_COUNT_OFFSET      0x8440
+
+/*_Small_Description_*/
+#define TIMESYNC_FW_WC_SYNCOUT_START_TIME_CYCLECOUNT_OFFSET 0x8444
+
+/*Control variable to generate SYNC1*/
+#define TIMESYNC_FW_WC_ISOM_PIN_SIGNAL_EN_OFFSET           0x844C
+
+/*SystemTime Sync0 periodicity*/
+#define TIMESYNC_FW_ST_SYNCOUT_PERIOD_OFFSET               0x8450
+
+/*pktTxDelay for P1 = link speed dependent p1 mac delay + p1 phy delay*/
+#define TIMESYNC_FW_WC_PKTTXDELAY_P1_OFFSET                0x8454
+
+/*pktTxDelay for P2 = link speed dependent p2 mac delay + p2 phy delay*/
+#define TIMESYNC_FW_WC_PKTTXDELAY_P2_OFFSET                0x8458
+
+/*Set clock operation done signal for next task*/
+#define TIMESYNC_FW_SIG_PNFW_OFFSET                        0x845C
+
+/*Set clock operation done signal for next task*/
+#define TIMESYNC_FW_SIG_TIMESYNCFW_OFFSET                  0x8460
+
+/*New list is copied at this time*/
+#define TAS_CONFIG_CHANGE_TIME                             0x000C
+
+/*config change error counter*/
+#define TAS_CONFIG_CHANGE_ERROR_COUNTER                    0x0014
+
+/*TAS List update pending flag*/
+#define TAS_CONFIG_PENDING                                 0x0018
+
+/*TAS list update trigger flag*/
+#define TAS_CONFIG_CHANGE                                  0x0019
+
+/*List length for new TAS schedule*/
+#define TAS_ADMIN_LIST_LENGTH                              0x001A
+
+/*Currently active TAS list index*/
+#define TAS_ACTIVE_LIST_INDEX                              0x001B
+
+/*Cycle time for the new TAS schedule*/
+#define TAS_ADMIN_CYCLE_TIME                               0x001C
+
+/*Cycle counts remaining till the TAS list update*/
+#define TAS_CONFIG_CHANGE_CYCLE_COUNT                      0x0020
+
+/*Base Flow ID for sending packets to Host for Slice0*/
+#define PSI_L_REGULAR_FLOW_ID_BASE_OFFSET                  0x0024
+
+/*Same as PSI_L_REGULAR_FLOW_ID_BASE_OFFSET*/
+#define EMAC_ICSSG_SWITCH_PSI_L_REGULAR_FLOW_ID_BASE_OFFSET PSI_L_REGULAR_FLOW_ID_BASE_OFFSET
+
+/*Base Flow ID for sending mgmt and Tx TS to Host for Slice0*/
+#define PSI_L_MGMT_FLOW_ID_OFFSET                          0x0026
+
+/*Same as PSI_L_MGMT_FLOW_ID_OFFSET*/
+#define EMAC_ICSSG_SWITCH_PSI_L_MGMT_FLOW_ID_BASE_OFFSET   PSI_L_MGMT_FLOW_ID_OFFSET
+
+/*Queue number for Special packets written here*/
+#define SPL_PKT_DEFAULT_PRIORITY                           0x0028
+
+/*Express Preemptible Queue Mask*/
+#define EXPRESS_PRE_EMPTIVE_Q_MASK                         0x0029
+
+/*Port1/Port2 Default Queue number for untagged packets, only 1B is used*/
+#define QUEUE_NUM_UNTAGGED                                 0x002A
+
+/*Stores the table used for priority regeneration. 1B per PCP/Queue*/
+#define PORT_Q_PRIORITY_REGEN_OFFSET                       0x002C
+
+/* For marking Packet as priority/express (this feature is disabled) or
+ * cut-through/S&F.
+ */
+#define EXPRESS_PRE_EMPTIVE_Q_MAP                          0x0034
+
+/*Stores the table used for priority mapping. 1B per PCP/Queue*/
+#define PORT_Q_PRIORITY_MAPPING_OFFSET                     0x003C
+
+/*TAS gate mask for windows list0*/
+#define TAS_GATE_MASK_LIST0                                0x0100
+
+/*TAS gate mask for windows list1*/
+#define TAS_GATE_MASK_LIST1                                0x0350
+
+/*Memory to Enable/Disable Preemption on TX side*/
+#define PRE_EMPTION_ENABLE_TX                              0x05A0
+
+/*Active State of Preemption on TX side*/
+#define PRE_EMPTION_ACTIVE_TX                              0x05A1
+
+/*Memory to Enable/Disable Verify State Machine Preemption*/
+#define PRE_EMPTION_ENABLE_VERIFY                          0x05A2
+
+/*Verify Status of State Machine*/
+#define PRE_EMPTION_VERIFY_STATUS                          0x05A3
+
+/*Non Final Fragment Size supported by Link Partner*/
+#define PRE_EMPTION_ADD_FRAG_SIZE_REMOTE                   0x05A4
+
+/*Non Final Fragment Size supported by Firmware*/
+#define PRE_EMPTION_ADD_FRAG_SIZE_LOCAL                    0x05A6
+
+/*Time in ms the State machine waits for respond packet*/
+#define PRE_EMPTION_VERIFY_TIME                            0x05A8
+
+/*Memory used for R30 related management commands*/
+#define MGR_R30_CMD_OFFSET                                 0x05AC
+
+/*HW Buffer Pool0 base address*/
+#define BUFFER_POOL_0_ADDR_OFFSET                          0x05BC
+
+/*16B for Host Egress MSMC Q (Pre-emptible) context*/
+#define HOST_RX_Q_PRE_CONTEXT_OFFSET                       0x0684
+
+/*Buffer for 8 FDB entries to be added by 'Add Multiple FDB entries IOCTL*/
+#define FDB_CMD_BUFFER                                     0x0894
+
+/*16B for Host Egress MSMC Q (Express) context*/
+#define HOST_RX_Q_EXP_CONTEXT_OFFSET                       0x0940
+
+/*Start of 32 bits PA_STAT counters*/
+#define PA_STAT_32b_START_OFFSET                           0x0080
+
+#endif
+/* __NET_TI_ICSSG_SWITCH_MAP_H */
-- 
2.34.1

