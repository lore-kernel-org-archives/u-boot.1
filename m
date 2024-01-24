Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2993CC46CD2
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 12:43:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B189587CA5;
	Wed, 24 Jan 2024 13:42:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="AyiA2MMX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7452987BDE; Wed, 24 Jan 2024 07:50:10 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45499879F6
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 07:50:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danishanwar@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40O6nqmw039422;
 Wed, 24 Jan 2024 00:49:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706078992;
 bh=AqH51YFDMsvXlsQJam52pKi8BK7FsHn3egqombLWBTk=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=AyiA2MMXECf/I5vcS/3QDjW1BfE/i7GvzF+Y6MZzKMsGs09KKJWMzgv0Xi6TH3ts4
 ly23KL00UcwtkoY2MgelF3SBxt7q3DRFXojvGNnXVyyD8Up0LXjcHxf56jnJjzkeVL
 EzJmdIeSfekH1V9UxJbnYFjVdo5ixPIWwTJKvfN8=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40O6nq3q009073
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 24 Jan 2024 00:49:52 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 24
 Jan 2024 00:49:51 -0600
Received: from fllvsmtp7.itg.ti.com (10.64.40.31) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 24 Jan 2024 00:49:51 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
 by fllvsmtp7.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40O6nprA098821;
 Wed, 24 Jan 2024 00:49:51 -0600
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
 by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 40O6noAe010990;
 Wed, 24 Jan 2024 00:49:51 -0600
From: MD Danish Anwar <danishanwar@ti.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, Maxime Ripard
 <mripard@kernel.org>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Roger Quadros <rogerq@kernel.org>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Stefan Roese <sr@denx.de>, Qu Wenruo <wqu@suse.com>, Bryan Brattlof
 <bb@ti.com>, Sean Anderson <seanga2@gmail.com>, Martyn Welch
 <martyn.welch@collabora.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Nikhil M Jain <n-jain1@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>, Simon
 Glass <sjg@chromium.org>, MD Danish Anwar <danishanwar@ti.com>,
 FUKAUMI Naoki <naoki@radxa.com>,
 Christian Hewitt <christianshewitt@gmail.com>, Hai Pham
 <hai.pham.ud@renesas.com>, Svyatoslav Ryhel <clamor95@gmail.com>, Jonas
 Karlman <jonas@kwiboo.se>, Neil Armstrong <neil.armstrong@linaro.org>,
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Kever Yang <kever.yang@rock-chips.com>, Ramon Fried <rfried.dev@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <r-gunasekaran@ti.com>
Subject: [RFC PATCH v3 08/15] net: ti: icssg: Add support sending FDB command
 to update rx_flow_id
Date: Wed, 24 Jan 2024 12:19:23 +0530
Message-ID: <20240124064930.1787929-9-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124064930.1787929-1-danishanwar@ti.com>
References: <20240124064930.1787929-1-danishanwar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Wed, 24 Jan 2024 13:42:05 +0100
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

