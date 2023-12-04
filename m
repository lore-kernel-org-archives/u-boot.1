Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ACA8C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 21:57:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26EF287878;
	Mon,  4 Dec 2023 22:56:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H0C8Po7q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B62B876A4; Mon,  4 Dec 2023 22:56:57 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::604])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F1C5876E0
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 22:56:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tanmay.shah@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WLY1tytxtfX1GRZoCwKHMV92uJQHKuITe6OTU61BzuczDwIBNQKih0+Ha+peRHHWs3Lm9BaJMgP+TBIER2MGDXIUhbTSa2rBZosjMz4wNH9NJnNAerG2nCLxhr0pUN2tfQGWEP0XMfmMCnYTNHa+/wtM0xsgvJu/rO32wEn+0mRAeVAYiIJlLOIBcELtOGcws/lv3bovbAyrOKIADbyGIpc//Rv+Avyit/oYym2pmD0cbupna33vfa1yBldFEVkOxY8uv+BY6dmlUraU+Z6o8rCWQSq8TCi5RXLH27TrckqTW7HuKaos0f65r+PmTqpAy/tMTlMQUQsIsivOnErZxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HOnuyGZIx7ZPzSd/DYMjX77fPGoygQyneCAm5U7E0hE=;
 b=cW3Mp8zeDh9ghuUvL7xB/+v1/ywokTcF9YviavP8MFY3hoK7k3GyaQ/AhVybhTQ55L16a02lpUodxm5Ne4tMC4+pAiLZSNSRABLi+LPFkz6Tq2FraBwAfjqWQrg5zp/ml8Gjr+SpYCgcBQUnWevxItsFspObh30zvh1X6Fk93KU2sOfovn+ZEew1xOCphcLwAQmIP4NajI2KfugXdvGTqB1rnVkdrykZl8tw8mlBCuPHuAYGq6djSRz4mrMwze9YGsoJpvNZ/QQdt8wtlcw6ztRVcjh9HS+WlDV9y/nrBshZxoPoFuIfXCtqYkge49dEsIYeZJvWjy8A23CsVFMKug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HOnuyGZIx7ZPzSd/DYMjX77fPGoygQyneCAm5U7E0hE=;
 b=H0C8Po7qqZm3X8t5Ico5wxitKXmiKq82YiHGeJOA5efIpZYgVzK3AmWGFC1cn93pfHAF4gzj+JVDP/HKN+0rRk8y3iOagT0YS7Z9+L4S/lAY0zstqFacLaVOPHpDs2Mifp8NbVCyP6iX4uGHthHqJxp4dCTRYR7miC/WuChNitg=
Received: from SN7PR04CA0108.namprd04.prod.outlook.com (2603:10b6:806:122::23)
 by SA1PR12MB7038.namprd12.prod.outlook.com (2603:10b6:806:24d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 21:56:50 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:122:cafe::3e) by SN7PR04CA0108.outlook.office365.com
 (2603:10b6:806:122::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33 via Frontend
 Transport; Mon, 4 Dec 2023 21:56:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Mon, 4 Dec 2023 21:56:50 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 4 Dec
 2023 15:56:50 -0600
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via
 Frontend Transport; Mon, 4 Dec 2023 15:56:49 -0600
From: Tanmay Shah <tanmay.shah@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, Tanmay Shah <tanmay.shah@amd.com>
Subject: [PATCH 3/4] mailbox: zynqmp: support mulitple mboxes via device-tree
Date: Mon, 4 Dec 2023 13:56:19 -0800
Message-ID: <20231204215620.63334-4-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231204215620.63334-1-tanmay.shah@amd.com>
References: <20231204215620.63334-1-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|SA1PR12MB7038:EE_
X-MS-Office365-Filtering-Correlation-Id: 57804868-0fdb-4720-8af4-08dbf513eb78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KyXm1aBZfLpM9kOyWlWpb4K8luxnA+hB67D5yePtYuWqY92obfq4PNvn4nnKBi01N2+1pnMjUWv/mQu+jM1WhbXCT8hfBU/OSjluaQtgM+AmuLuny4f6uQ9Dt6S/tx/8OkBpnoxLwsGEg9fMjYMlsw+EuIllua8ZO1pTh/5D5OuM5657sdlsioCX8gtBXZvZYgz8mW8f6xr3r5XVwuKRfusni0p+CD7NTE8uA/yRUmemShXSQ7Ur4tBiUJmp8ACpZGpGaWDLjCjTYnIcXzwyv3rBZHVJkqkGjd3qeS+o23UQEypYToXN/e8mzv9Ch8nGUWfG5obqys6QGEz9Lnx15f5ZiOGWZEcqMPhEDpMSaSkF0h06jgNb1r87SFj86GdO04MJm8GVleeSoUMnAJ7nUdLzFwjQTT47lskKTz8GZ9qUFvaPBenuYSSB3ily/+wLQl9HAFTTeHPxGUPTbbWxwWQ8SYK4+Mmjq7957itGcJhHqoG5XaT7TXmUaazXByDglW9RmvQnKIJuKPNH2OvSxw3Shcg+4/qLr6SRD+R/lLDlVSO+0c7vHq9EF4yde/k5j5RsiSZfV5FYvpFNaaeEMs5IIifvW4BSr7tvgOAepBqlifNiOtAWavdj9JBTTXQH7pR1a3MfuCusStmaNee+3A4aj82jQsxKPCMorGh7GHx8spPgxnbRW8nO+vgogCTX0+NcRllfo07pvWUnUDxmqtTRkrmjgTUluLiLT1dRr0wdgIROxuOXfTBR/8BRtzhWfB8DADrzv5pHJIwseJqLww==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(136003)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(82310400011)(1800799012)(186009)(40470700004)(36840700001)(46966006)(40460700003)(6916009)(54906003)(8936002)(86362001)(316002)(8676002)(44832011)(4326008)(70206006)(478600001)(70586007)(36756003)(41300700001)(15650500001)(2906002)(5660300002)(36860700001)(81166007)(47076005)(356005)(26005)(2616005)(426003)(1076003)(83380400001)(82740400003)(336012)(6666004)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 21:56:50.6161 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57804868-0fdb-4720-8af4-08dbf513eb78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7038
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

As of now only one mailbox agent is supported by mailbox driver.
On zynqmp platform there are about 7 mailbox agents which can communicate
over same IPI channel to U-Boot. This patch series introduces new
"zynqmp_ipi_dest" driver which adds one to multi-channel mailbox
support.

Following format in device-tree is expected as per latest bindings:
zynqmp-ipi {
	compatible = "xlnx,zynqmp-ipi-mailbox";

	mbox_1: mailbox@1 {
		/* New compatible for child node */
		compatible = "xlnx,zynqmp-ipi-dest-mailbox";
		...
	};

	...

	mbox_n: mailbox@n {
		compatible = "xlnx,zynqmp-ipi-dest-mailbox";
		...
	}
};

Then mailbox client uses child mailbox node as following:

ipi-dest-1 {
	...
	mboxes = <mbox_1 0>, <mbox_1 1>;
	mbox-names = "tx", "rx";
	...
};

New "zynqmp_ipi_dest" driver is for devices with
"xlnx,zynqmp-ipi-dest-mailbox" compatible string. This driver will take care
of mailbox send recv ops and it replaces previous "zynqmp_ipi" driver.
Now "zynqmp_ipi" driver simply binds each child device with "zynqmp_ipi_dest"
driver.

However, its important to maintain backward comaptibility with previous
bindings where child node does not have compatible string. In such case, new
driver isn't probed by U-Boot during boot and system fails to boot. To
resolve this issue firmware-zynqmp.c driver probes all the IPI parent node
driver which binds each child node device with "zynqmp_ipi_dest" driver.

This makes sure corresponding child driver will be
probed when requested using mbox_get_by_name or mbox_get_by_idx
framework calls.

This way multiple mailbox agents are supported in device-tree without breaking
previous binding support.

Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
---
 drivers/firmware/firmware-zynqmp.c | 22 ++++++++++
 drivers/mailbox/zynqmp-ipi.c       | 65 ++++++++++++++++++++++++------
 2 files changed, 74 insertions(+), 13 deletions(-)

diff --git a/drivers/firmware/firmware-zynqmp.c b/drivers/firmware/firmware-zynqmp.c
index 8ea15c7ed3..dfad798a2e 100644
--- a/drivers/firmware/firmware-zynqmp.c
+++ b/drivers/firmware/firmware-zynqmp.c
@@ -8,6 +8,7 @@
 #include <common.h>
 #include <cpu_func.h>
 #include <dm.h>
+#include <dm/device_compat.h>
 #include <dm/lists.h>
 #include <log.h>
 #include <zynqmp_firmware.h>
@@ -290,10 +291,31 @@ int zynqmp_pmufw_load_config_object(const void *cfg_obj, size_t size)
 
 static int zynqmp_power_probe(struct udevice *dev)
 {
+	struct udevice *ipi_dev;
+	ofnode ipi_node;
 	int ret;
 
 	debug("%s, (dev=%p)\n", __func__, dev);
 
+	/*
+	 * Probe all IPI parent node driver. It is important to have IPI
+	 * devices available when requested by mbox_get_by* API.
+	 * If IPI device isn't available, then mailbox request fails and
+	 * that causes system boot failure.
+	 * To avoid this make sure all IPI parent drivers are probed here,
+	 * and IPI parent driver binds each child node to mailbox driver.
+	 * This way mbox_get_by_* API will have correct mailbox device
+	 * driver probed.
+	 */
+	ofnode_for_each_compatible_node(ipi_node, "xlnx,zynqmp-ipi-mailbox") {
+		ret = uclass_get_device_by_ofnode(UCLASS_NOP, ipi_node, &ipi_dev);
+		if (ret) {
+			dev_err(dev, "failed to get IPI device from node %s\n",
+				ofnode_get_name(ipi_node));
+			return ret;
+		}
+	}
+
 	ret = mbox_get_by_name(dev, "tx", &zynqmp_power.tx_chan);
 	if (ret) {
 		debug("%s: Cannot find tx mailbox\n", __func__);
diff --git a/drivers/mailbox/zynqmp-ipi.c b/drivers/mailbox/zynqmp-ipi.c
index e76561f310..eb86847bbe 100644
--- a/drivers/mailbox/zynqmp-ipi.c
+++ b/drivers/mailbox/zynqmp-ipi.c
@@ -12,6 +12,7 @@
 #include <dm.h>
 #include <mailbox-uclass.h>
 #include <dm/device_compat.h>
+#include <dm/lists.h>
 #include <dm/of_access.h>
 #include <linux/arm-smccc.h>
 #include <linux/ioport.h>
@@ -157,7 +158,7 @@ static int zynqmp_ipi_recv(struct mbox_chan *chan, void *data)
 	return ret;
 };
 
-static int zynqmp_ipi_probe(struct udevice *dev)
+static int zynqmp_ipi_dest_probe(struct udevice *dev)
 {
 	struct zynqmp_ipi *zynqmp = dev_get_priv(dev);
 	struct resource res;
@@ -166,14 +167,12 @@ static int zynqmp_ipi_probe(struct udevice *dev)
 
 	debug("%s(dev=%p)\n", __func__, dev);
 
+	node = dev_ofnode(dev);
+
 	if (IS_ENABLED(CONFIG_SPL_BUILD) || of_machine_is_compatible("xlnx,zynqmp"))
 		zynqmp->el3_supported = true;
 
-	/* Get subnode where the regs are defined */
-	/* Note IPI mailbox node needs to be the first one in DT */
-	node = ofnode_first_subnode(dev_ofnode(dev));
-
-	ret = dev_read_u32(dev, "xlnx,ipi-id", &zynqmp->local_id);
+	ret = dev_read_u32(dev->parent, "xlnx,ipi-id", &zynqmp->local_id);
 	if (ret) {
 		dev_err(dev, "can't get local ipi id\n");
 		return ret;
@@ -191,6 +190,8 @@ static int zynqmp_ipi_probe(struct udevice *dev)
 	};
 	zynqmp->local_req_regs = devm_ioremap(dev, res.start,
 					      (res.start - res.end));
+	if (!zynqmp->local_req_regs)
+		return -EINVAL;
 
 	if (ofnode_read_resource_byname(node, "local_response_region", &res)) {
 		dev_err(dev, "No reg property for local_response_region\n");
@@ -198,6 +199,8 @@ static int zynqmp_ipi_probe(struct udevice *dev)
 	};
 	zynqmp->local_res_regs = devm_ioremap(dev, res.start,
 					      (res.start - res.end));
+	if (!zynqmp->local_res_regs)
+		return -EINVAL;
 
 	if (ofnode_read_resource_byname(node, "remote_request_region", &res)) {
 		dev_err(dev, "No reg property for remote_request_region\n");
@@ -205,6 +208,8 @@ static int zynqmp_ipi_probe(struct udevice *dev)
 	};
 	zynqmp->remote_req_regs = devm_ioremap(dev, res.start,
 					       (res.start - res.end));
+	if (!zynqmp->remote_req_regs)
+		return -EINVAL;
 
 	if (ofnode_read_resource_byname(node, "remote_response_region", &res)) {
 		dev_err(dev, "No reg property for remote_response_region\n");
@@ -212,25 +217,59 @@ static int zynqmp_ipi_probe(struct udevice *dev)
 	};
 	zynqmp->remote_res_regs = devm_ioremap(dev, res.start,
 					       (res.start - res.end));
+	if (!zynqmp->remote_res_regs)
+		return -EINVAL;
 
 	return 0;
 };
 
-static const struct udevice_id zynqmp_ipi_ids[] = {
-	{ .compatible = "xlnx,zynqmp-ipi-mailbox" },
-	{ }
+static int zynqmp_ipi_probe(struct udevice *dev)
+{
+	struct udevice *cdev;
+	ofnode cnode;
+	int ret;
+
+	debug("%s(dev=%p)\n", __func__, dev);
+
+	dev_for_each_subnode(cnode, dev) {
+		ret = device_bind_driver_to_node(dev, "zynqmp_ipi_dest",
+						 ofnode_get_name(cnode),
+						 cnode, &cdev);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 };
 
-struct mbox_ops zynqmp_ipi_mbox_ops = {
+struct mbox_ops zynqmp_ipi_dest_mbox_ops = {
 	.send = zynqmp_ipi_send,
 	.recv = zynqmp_ipi_recv,
 };
 
+static const struct udevice_id zynqmp_ipi_dest_ids[] = {
+	{ .compatible = "xlnx,zynqmp-ipi-dest-mailbox" },
+	{ }
+};
+
+U_BOOT_DRIVER(zynqmp_ipi_dest) = {
+	.name = "zynqmp_ipi_dest",
+	.id = UCLASS_MAILBOX,
+	.of_match = zynqmp_ipi_dest_ids,
+	.probe = zynqmp_ipi_dest_probe,
+	.priv_auto = sizeof(struct zynqmp_ipi),
+	.ops = &zynqmp_ipi_dest_mbox_ops,
+};
+
+static const struct udevice_id zynqmp_ipi_ids[] = {
+	{ .compatible = "xlnx,zynqmp-ipi-mailbox" },
+	{ }
+};
+
 U_BOOT_DRIVER(zynqmp_ipi) = {
 	.name = "zynqmp_ipi",
-	.id = UCLASS_MAILBOX,
+	.id = UCLASS_NOP,
 	.of_match = zynqmp_ipi_ids,
 	.probe = zynqmp_ipi_probe,
-	.priv_auto	= sizeof(struct zynqmp_ipi),
-	.ops = &zynqmp_ipi_mbox_ops,
+	.flags = DM_FLAG_PROBE_AFTER_BIND,
 };
-- 
2.25.1

