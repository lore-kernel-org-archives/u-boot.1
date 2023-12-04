Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF4BC4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 21:56:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 810708759E;
	Mon,  4 Dec 2023 22:56:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AYw3Nlh1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1970A877CE; Mon,  4 Dec 2023 22:56:55 +0100 (CET)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::62b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A617D86BD6
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 22:56:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tanmay.shah@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WiEU3mewSIhbN2lZXgL6Rr7facH8fXLdXWvLo41bgxz9Lp/kX42DKr+CWNhRHz2RKEmsAktbkTrChKM8bJjoQ5VdnOj8K/xOC4SWJUktCkhuvDDb5RdifXy2yaqiGt3uIWsXn1K17uPwYLmOBVgQEYS7MBs0INXBiIyKTqeibOBaURm6S8t4EW1R1S4IyMKYwGro2lzG9Qnga5No48ZSeel1ww/Ly7hrLCpSEVfjhYizEq02tknAnTcsMcKP561A6QCFAooxI0X2GCMksAiPkyMUsMQ7UtO33zDBQtlsm+DDoH+4vAOjc5Z5+o9eNdKSS0Hc4Syo0wWp6QKm06UyeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfv7yUBuPAyRI7GUgrl5xw/TfkKutLUDsi0oy7CPhNc=;
 b=PWRdKi5z6udwYu1I8XIaaqIIi8ArsQx9junpS6WdYswgwi+f3Gn9ZL+lnDiQnLsAsYpMF0Gj+VVNX3Sy/aoCkGWo6RQy91/HdVj4PSIeu781oZKmiTIF4PpuT8EHzPI1+xtj5ajM70JrKIL2ZDhMbSk/7e0aRueF6ZNyuiixMRaE4phQZetJQNkyP+PtPZC5oq5bIdTiqIt86wPNXhisH07zrTfquvqaQBgs+1R1UWzdxlEGX0lQVnYZ2ja5GaKnE7y8wvhpqp7awaHAqOt79sFdPTLKzZPSZPJx3pRmAPBplSaYl4JL+T5ZjOUJ3w8gdlXxyIFjEFCtKTf4HGdugg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfv7yUBuPAyRI7GUgrl5xw/TfkKutLUDsi0oy7CPhNc=;
 b=AYw3Nlh16HD4dJan/TyBW26bkTCQXBZOv5vPXXdDi0r+hlQ5HKAh6afdw9PFfjADbdbqkULu8hN/EcSN43nYKHnLcTLPV97mAk9UuS6TApqNB/IlWEcf9WVKo0RpE7jW66+hNqUCn/pHxHrqcljpDT/Dat3VE/NzJ4xH2GMmnzI=
Received: from SN7PR04CA0120.namprd04.prod.outlook.com (2603:10b6:806:122::35)
 by SN7PR12MB8169.namprd12.prod.outlook.com (2603:10b6:806:32f::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 21:56:50 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:122:cafe::f4) by SN7PR04CA0120.outlook.office365.com
 (2603:10b6:806:122::35) with Microsoft SMTP Server (version=TLS1_2,
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
 15.20.7068.20 via Frontend Transport; Mon, 4 Dec 2023 21:56:49 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 4 Dec
 2023 15:56:49 -0600
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via
 Frontend Transport; Mon, 4 Dec 2023 15:56:48 -0600
From: Tanmay Shah <tanmay.shah@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, Tanmay Shah <tanmay.shah@amd.com>
Subject: [PATCH 1/4] mailbox: zynqmp: support smc calls to TF-A
Date: Mon, 4 Dec 2023 13:56:17 -0800
Message-ID: <20231204215620.63334-2-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231204215620.63334-1-tanmay.shah@amd.com>
References: <20231204215620.63334-1-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|SN7PR12MB8169:EE_
X-MS-Office365-Filtering-Correlation-Id: 92da87c0-5809-4568-8f1d-08dbf513eb1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RxoTUPgglD2vl8dJHbL3t4p4S9YnZ3kCVT0/yJXBLex281AqB/W9CNK/+lIEgacartVEEx9Y04gWon341YyIjqaevvI216yzMFFox2WmQMBlsgx1GagsdKL/uCoEzJZ5mzorjSxal2onaZx1Oq5XSYI4HoXSSgADGRKANuEMBOe1c4q/V0lD0LfJIGrKtUnL/yslE2MPfYAVBwX6oGoKEgiKGm9jxszYYdXklozIb4wEKBn+yk60m+NQ5INBFdse1pJm5+MI5uAGu0y5gTlaAm3XP4+fomczPG/Bq5ko4UdMw9wKByfVrAXXvF2Fn4rY81ZbZL2dndQM+VnhmGqSfYq2k3y4WO8fVvm044XZsOlQy1DLm8KZwqg+tbEQLgNvVa0+WcKMqTOPopszn2mb+43Ye35E+K8OvPN+eaPMh9aamXPv/Wc7rAg5t6NkfJpALtAMvFZUhwbwQmf9bzBUwkqjIMymEplQJvDyOZBvp75I9PU2dCpXsBLj6iHXuL4OhyXVoIcCzjmDo7+VzweRFYBqLNk0hN1ywzkcqyzOrhTbC2l95oE/RncJ1wR9tLdQOLE5+KxThSQ1nMvPCdRPBQJDxtBGhknZbB42mPIg5guQQfHZYc4xdKxekWyV82RskhKMCVTt/1rYscrNe5+YgR+WoDBF3jyJMJIGihqGOI3blEcmQZ7x+m6/6TXWUzcRZ50p9l7yWsYhfRfTWwYGpL+EO15BmM8ts01VwQVWzbrbHJvBehRJ33JhvaCeaLP0szllUrcTaPFtv9IusTXLnA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(39860400002)(136003)(396003)(230922051799003)(82310400011)(186009)(451199024)(64100799003)(1800799012)(36840700001)(40470700004)(46966006)(70586007)(70206006)(6916009)(54906003)(316002)(478600001)(41300700001)(40460700003)(6666004)(36756003)(5660300002)(15650500001)(2906002)(8936002)(4326008)(8676002)(86362001)(44832011)(2616005)(40480700001)(82740400003)(83380400001)(47076005)(81166007)(356005)(26005)(336012)(426003)(1076003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 21:56:49.9911 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92da87c0-5809-4568-8f1d-08dbf513eb1b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8169
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

Use SMC calls to TF-A to operate IPI for execution level below 3. For
EL3 use hardcode IPI registers as TF-A isn't available in EL3.
Hence, in EL3 remote and local IPI ids retrieved using xlnx,ipi-id
property are unused.

Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
---
 drivers/mailbox/zynqmp-ipi.c | 88 +++++++++++++++++++++++++++++++++++-
 1 file changed, 86 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/zynqmp-ipi.c b/drivers/mailbox/zynqmp-ipi.c
index 3e4ec47389..acd0b287db 100644
--- a/drivers/mailbox/zynqmp-ipi.c
+++ b/drivers/mailbox/zynqmp-ipi.c
@@ -8,9 +8,12 @@
 #include <common.h>
 #include <log.h>
 #include <asm/io.h>
+#include <asm/system.h>
 #include <dm.h>
 #include <mailbox-uclass.h>
 #include <dm/device_compat.h>
+#include <dm/of_access.h>
+#include <linux/arm-smccc.h>
 #include <linux/ioport.h>
 #include <linux/io.h>
 #include <wait_bit.h>
@@ -21,6 +24,43 @@
 #define IPI_BIT_MASK_PMU0     0x10000
 #define IPI_INT_REG_BASE_APU  0xFF300000
 
+/* IPI agent ID any */
+#define IPI_ID_ANY 0xFFUL
+
+/* indicate if ZynqMP IPI mailbox driver uses SMC calls or HVC calls */
+#define USE_SMC 0
+
+/* Default IPI SMC function IDs */
+#define SMC_IPI_MAILBOX_OPEN		0x82001000U
+#define SMC_IPI_MAILBOX_RELEASE		0x82001001U
+#define SMC_IPI_MAILBOX_STATUS_ENQUIRY	0x82001002U
+#define SMC_IPI_MAILBOX_NOTIFY		0x82001003U
+#define SMC_IPI_MAILBOX_ACK		0x82001004U
+#define SMC_IPI_MAILBOX_ENABLE_IRQ	0x82001005U
+#define SMC_IPI_MAILBOX_DISABLE_IRQ	0x82001006U
+
+/* IPI SMC Macros */
+
+/*
+ * Flag to indicate if notification interrupt
+ * to be disabled.
+ */
+#define IPI_SMC_ENQUIRY_DIRQ_MASK	BIT(0)
+
+/*
+ * Flag to indicate if notification interrupt
+ * to be enabled.
+ */
+#define IPI_SMC_ACK_EIRQ_MASK		BIT(0)
+
+/* IPI mailbox status */
+#define IPI_MB_STATUS_IDLE		0
+#define IPI_MB_STATUS_SEND_PENDING	1
+#define IPI_MB_STATUS_RECV_PENDING	2
+
+#define IPI_MB_CHNL_TX	0 /* IPI mailbox TX channel */
+#define IPI_MB_CHNL_RX	1 /* IPI mailbox RX channel */
+
 struct ipi_int_regs {
 	u32 trig; /* 0x0  */
 	u32 obs;  /* 0x4  */
@@ -39,8 +79,23 @@ struct zynqmp_ipi {
 	void __iomem *local_res_regs;
 	void __iomem *remote_req_regs;
 	void __iomem *remote_res_regs;
+	u32 remote_id;
+	u32 local_id;
 };
 
+static int zynqmp_ipi_fw_call(struct zynqmp_ipi *ipi_mbox,
+			      unsigned long a0, unsigned long a3)
+{
+	struct arm_smccc_res res = {0};
+	unsigned long a1, a2;
+
+	a1 = ipi_mbox->local_id;
+	a2 = ipi_mbox->remote_id;
+	arm_smccc_smc(a0, a1, a2, a3, 0, 0, 0, 0, &res);
+
+	return (int)res.a0;
+}
+
 static int zynqmp_ipi_send(struct mbox_chan *chan, const void *data)
 {
 	const struct zynqmp_ipi_msg *msg = (struct zynqmp_ipi_msg *)data;
@@ -51,6 +106,15 @@ static int zynqmp_ipi_send(struct mbox_chan *chan, const void *data)
 	for (size_t i = 0; i < msg->len; i++)
 		writel(msg->buf[i], &mbx[i]);
 
+	/* Use SMC calls for Exception Level less than 3 where TF-A is available */
+	if (!IS_ENABLED(CONFIG_SPL_BUILD) && current_el() < 3) {
+		ret = zynqmp_ipi_fw_call(zynqmp, SMC_IPI_MAILBOX_NOTIFY, 0);
+
+		debug("%s, send %ld bytes\n", __func__, msg->len);
+
+		return ret;
+	}
+
 	/* Write trigger interrupt */
 	writel(IPI_BIT_MASK_PMU0, &ipi_int_apu->trig);
 
@@ -67,16 +131,23 @@ static int zynqmp_ipi_recv(struct mbox_chan *chan, void *data)
 	struct zynqmp_ipi_msg *msg = (struct zynqmp_ipi_msg *)data;
 	struct zynqmp_ipi *zynqmp = dev_get_priv(chan->dev);
 	u32 *mbx = (u32 *)zynqmp->local_res_regs;
+	int ret = 0;
 
 	/*
 	 * PMU Firmware does not trigger IPI interrupt for API call responses so
-	 * there is no need to check ISR flags
+	 * there is no need to check ISR flags for EL3.
 	 */
 	for (size_t i = 0; i < msg->len; i++)
 		msg->buf[i] = readl(&mbx[i]);
 
+	/* Ack to remote if EL is not 3 */
+	if (!IS_ENABLED(CONFIG_SPL_BUILD) && current_el() < 3) {
+		ret = zynqmp_ipi_fw_call(zynqmp, SMC_IPI_MAILBOX_ACK,
+					 IPI_SMC_ACK_EIRQ_MASK);
+	}
+
 	debug("%s, recv %ld bytes\n", __func__, msg->len);
-	return 0;
+	return ret;
 };
 
 static int zynqmp_ipi_probe(struct udevice *dev)
@@ -84,6 +155,7 @@ static int zynqmp_ipi_probe(struct udevice *dev)
 	struct zynqmp_ipi *zynqmp = dev_get_priv(dev);
 	struct resource res;
 	ofnode node;
+	int ret;
 
 	debug("%s(dev=%p)\n", __func__, dev);
 
@@ -91,6 +163,18 @@ static int zynqmp_ipi_probe(struct udevice *dev)
 	/* Note IPI mailbox node needs to be the first one in DT */
 	node = ofnode_first_subnode(dev_ofnode(dev));
 
+	ret = dev_read_u32(dev, "xlnx,ipi-id", &zynqmp->local_id);
+	if (ret) {
+		dev_err(dev, "can't get local ipi id\n");
+		return ret;
+	}
+
+	ret = ofnode_read_u32(node, "xlnx,ipi-id", &zynqmp->remote_id);
+	if (ret) {
+		dev_err(dev, "can't get remote ipi id\n");
+		return ret;
+	}
+
 	if (ofnode_read_resource_byname(node, "local_request_region", &res)) {
 		dev_err(dev, "No reg property for local_request_region\n");
 		return -EINVAL;
-- 
2.25.1

