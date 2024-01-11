Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B4BFC47077
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 13:10:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AD3987B30;
	Thu, 11 Jan 2024 14:08:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="LVg99XXU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FA0387A61; Thu, 11 Jan 2024 08:07:09 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87A5387738
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 08:07:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danishanwar@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40B76g0F049528;
 Thu, 11 Jan 2024 01:06:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1704956802;
 bh=AqH51YFDMsvXlsQJam52pKi8BK7FsHn3egqombLWBTk=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=LVg99XXUcBOxifEWANo56Vvq575r5PN25LnMgMxNmO1aTiSOQsVhtXiQZlX6JHq5n
 xm48c071Ivne51hkyZxSh2E/+dvuJqzRdGRY/bkdBn3NVerNNcrozesuW59ssIJxse
 uMycI5WAFuS7GtUczjW0tGUWH/hvda0yhWB/2DgI=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40B76g1P039167
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 11 Jan 2024 01:06:42 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 11
 Jan 2024 01:06:41 -0600
Received: from fllvsmtp7.itg.ti.com (10.64.40.31) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 11 Jan 2024 01:06:41 -0600
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
 by fllvsmtp7.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40B76fXf014386;
 Thu, 11 Jan 2024 01:06:41 -0600
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
 by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 40B76eHm024723;
 Thu, 11 Jan 2024 01:06:41 -0600
From: MD Danish Anwar <danishanwar@ti.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Maxime Ripard <mripard@kernel.org>, Roger Quadros
 <rogerq@kernel.org>, Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Stefan Roese <sr@denx.de>, Qu Wenruo <wqu@suse.com>, Sean Anderson
 <seanga2@gmail.com>, Bryan Brattlof <bb@ti.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Christian Gmeiner <christian.gmeiner@gmail.com>,
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Nikhil M Jain
 <n-jain1@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Andrew Davis
 <afd@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Simon Glass
 <sjg@chromium.org>, MD Danish Anwar <danishanwar@ti.com>, FUKAUMI Naoki
 <naoki@radxa.com>, Christian Hewitt <christianshewitt@gmail.com>, Hai Pham
 <hai.pham.ud@renesas.com>, Svyatoslav Ryhel <clamor95@gmail.com>, Jonas
 Karlman <jonas@kwiboo.se>, Neil Armstrong <neil.armstrong@linaro.org>,
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Kever Yang <kever.yang@rock-chips.com>, Ramon Fried <rfried.dev@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <r-gunasekaran@ti.com>
Subject: [RFC PATCH v2 08/15] net: ti: icssg: Add support sending FDB command
 to update rx_flow_id
Date: Thu, 11 Jan 2024 12:36:04 +0530
Message-ID: <20240111070611.342701-9-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111070611.342701-1-danishanwar@ti.com>
References: <20240111070611.342701-1-danishanwar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Thu, 11 Jan 2024 14:08:34 +0100
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

ICSSG firmware supports FDB commands. Add support to send FDB commands
from driver. Once rx_flow_id is obtained from dma, let firmware know that
we are using this rx_flow_id by sending a FDB command.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/net/ti/icssg_config.c | 66 +++++++++++++++++++++++++++++++++++
 drivers/net/ti/icssg_config.h | 18 ++++++++++
 drivers/net/ti/icssg_prueth.c |  6 ++++
 drivers/net/ti/icssg_prueth.h |  6 ++++
 4 files changed, 96 insertions(+)

diff --git a/drivers/net/ti/icssg_config.c b/drivers/net/ti/icssg_config.c
index 0dc2c0fa3a..630698add4 100644
--- a/drivers/net/ti/icssg_config.c
+++ b/drivers/net/ti/icssg_config.c
@@ -9,6 +9,7 @@
 #include "icssg_switch_map.h"
 #include "icss_mii_rt.h"
 #include <dm/device_compat.h>
+#include <linux/iopoll.h>
 
 /* TX IPG Values to be set for 100M and 1G link speeds.  These values are
  * in ocp_clk cycles. So need change if ocp_clk is changed for a specific
@@ -395,3 +396,68 @@ int emac_set_port_state(struct prueth *prueth,
 
 	return ret;
 }
+
+int icssg_send_fdb_msg(struct prueth *prueth, struct mgmt_cmd *cmd,
+		       struct mgmt_cmd_rsp *rsp)
+{
+	int slice = prueth->slice;
+	int ret, addr;
+
+	addr = icssg_queue_pop(prueth, slice == 0 ?
+			       ICSSG_CMD_POP_SLICE0 : ICSSG_CMD_POP_SLICE1);
+	if (addr < 0)
+		return addr;
+
+	/* First 4 bytes have FW owned buffer linking info which should
+	 * not be touched
+	 */
+	memcpy_toio((void __iomem *)prueth->shram.pa + addr + 4, cmd, sizeof(*cmd));
+	icssg_queue_push(prueth, slice == 0 ?
+			 ICSSG_CMD_PUSH_SLICE0 : ICSSG_CMD_PUSH_SLICE1, addr);
+	ret = read_poll_timeout(icssg_queue_pop, addr, addr >= 0,
+				2000, 20000000, prueth, slice == 0 ?
+				ICSSG_RSP_POP_SLICE0 : ICSSG_RSP_POP_SLICE1);
+
+	if (ret) {
+		dev_err(prueth->dev, "Timedout sending HWQ message\n");
+		return ret;
+	}
+
+	memcpy_fromio(rsp, (void __iomem *)prueth->shram.pa + addr, sizeof(*rsp));
+	/* Return buffer back for to pool */
+	icssg_queue_push(prueth, slice == 0 ?
+			 ICSSG_RSP_PUSH_SLICE0 : ICSSG_RSP_PUSH_SLICE1, addr);
+
+	return 0;
+}
+
+int emac_fdb_flow_id_updated(struct prueth *prueth)
+{
+	struct mgmt_cmd_rsp fdb_cmd_rsp = { 0 };
+	int slice = prueth->slice;
+	struct mgmt_cmd fdb_cmd = { 0 };
+	int ret = 0;
+
+	fdb_cmd.header = ICSSG_FW_MGMT_CMD_HEADER;
+	fdb_cmd.type   = ICSSG_FW_MGMT_FDB_CMD_TYPE_RX_FLOW;
+	fdb_cmd.seqnum = ++(prueth->icssg_hwcmdseq);
+	fdb_cmd.param  = 0;
+
+	fdb_cmd.param |= (slice << 4);
+	fdb_cmd.cmd_args[0] = 0;
+
+	ret = icssg_send_fdb_msg(prueth, &fdb_cmd, &fdb_cmd_rsp);
+	if (ret)
+		return ret;
+
+	if (fdb_cmd.seqnum != fdb_cmd_rsp.seqnum) {
+		dev_err(prueth->dev, "seqnum doesn't match, cmd.seqnum %d != rsp.seqnum %d\n",
+			fdb_cmd.seqnum, fdb_cmd_rsp.seqnum);
+		return -EINVAL;
+	}
+
+	if (fdb_cmd_rsp.status == 1)
+		return 0;
+
+	return -EINVAL;
+}
diff --git a/drivers/net/ti/icssg_config.h b/drivers/net/ti/icssg_config.h
index fc6eae0426..156127bd3d 100644
--- a/drivers/net/ti/icssg_config.h
+++ b/drivers/net/ti/icssg_config.h
@@ -80,6 +80,7 @@ struct icssg_rxq_ctx {
 #define ICSSG_FW_MGMT_FDB_CMD_TYPE	0x03
 #define ICSSG_FW_MGMT_CMD_TYPE		0x04
 #define ICSSG_FW_MGMT_PKT		0x80000000
+#define ICSSG_FW_MGMT_FDB_CMD_TYPE_RX_FLOW	0x05
 
 struct icssg_r30_cmd {
 	u32 cmd[4];
@@ -156,6 +157,23 @@ struct icssg_setclock_desc {
 	u32 CMP0_new;
 } __packed;
 
+struct mgmt_cmd {
+	u8 param;
+	u8 seqnum;
+	u8 type;
+	u8 header;
+	u32 cmd_args[3];
+} __packed;
+
+struct mgmt_cmd_rsp {
+	u32 reserved;
+	u8 status;
+	u8 seqnum;
+	u8 type;
+	u8 header;
+	u32 cmd_args[3];
+} __packed;
+
 #define ICSSG_CMD_POP_SLICE0	56
 #define ICSSG_CMD_POP_SLICE1	60
 
diff --git a/drivers/net/ti/icssg_prueth.c b/drivers/net/ti/icssg_prueth.c
index cd6ff1a7fe..50af9a2bc6 100644
--- a/drivers/net/ti/icssg_prueth.c
+++ b/drivers/net/ti/icssg_prueth.c
@@ -351,6 +351,12 @@ static int prueth_start(struct udevice *dev)
 	dev_info(dev, "K3 ICSSG: rflow_id_base: %u, chn_name = %s\n",
 		 dma_rx_cfg_data->flow_id_base, chn_name);
 
+	ret = emac_fdb_flow_id_updated(priv);
+	if (ret) {
+		dev_err(dev, "Failed to update Rx Flow ID %d", ret);
+		goto phy_fail;
+	}
+
 	ret = phy_startup(priv->phydev);
 	if (ret) {
 		dev_err(dev, "phy_startup failed\n");
diff --git a/drivers/net/ti/icssg_prueth.h b/drivers/net/ti/icssg_prueth.h
index fb76668f90..24dda1fee8 100644
--- a/drivers/net/ti/icssg_prueth.h
+++ b/drivers/net/ti/icssg_prueth.h
@@ -71,6 +71,7 @@ struct prueth {
 	u8			pru_core_id;
 	u8			rtu_core_id;
 	u8			txpru_core_id;
+	u8			icssg_hwcmdseq;
 };
 
 /* config helpers */
@@ -83,4 +84,9 @@ int icssg_queue_pop(struct prueth *prueth, u8 queue);
 void icssg_queue_push(struct prueth *prueth, int queue, u16 addr);
 u32 icssg_queue_level(struct prueth *prueth, int queue);
 
+/* FDB helpers */
+int icssg_send_fdb_msg(struct prueth *prueth, struct mgmt_cmd *cmd,
+		       struct mgmt_cmd_rsp *rsp);
+int emac_fdb_flow_id_updated(struct prueth *prueth);
+
 #endif /* __NET_TI_ICSSG_PRUETH_H */
-- 
2.34.1

