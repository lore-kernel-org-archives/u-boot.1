Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB6CEC4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 09:34:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0AA2877A2;
	Wed,  6 Dec 2023 10:32:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C6qp8ZjV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6664D87227; Wed,  6 Dec 2023 10:32:49 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::62a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29E1C877A2
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 10:32:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gg/j5b41yqFyzo6AcWJbwhWEdaVlaaR1figr4wyHY4VEtlP37xczMCV/wMAi9MMTNP4SAUb1kNZX2QjDeOGoa1F+GiaNTZTfn55lWYaHhwhm4kd6DA14sDxtcTr2l4wenTDGYeoNSWluQ0HdngPpyyYWARGwnr2CVwY86GVZX00pm7z/KD8iXcBYzLN8uzwVPme2OTNGNh190DMn1yZTeseIXpWY2r6z+BbSeVVxgzzUDaTK8wGZLj37QR2AGkyFLTPByv3KVs3OKztw99iOSscOVwOPc9/kcuGs/GR8CHqdC3//COnh3/0t65NufGLshSeUCEGa+XHMmDPcepDzXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XDDsM5Vjpi7JKtq+CZ/2eVN1UBPO5eUSm14130fPsAE=;
 b=AXN8J9XHsBSUNa2l8wSmA2MhRnSwG1P+jbQyN2FfxMyCSzdUAdMssBd/gV4v1Y/eagSp0nOfqa/KmxutApBve53H2l0j6ojtqVBOI02BqovrcjDbBkuqYhmnyRPSG21JnJtwKfgX0YXkNndk0FYF65hqzDwMZ25ss5KYBjhy5R5x0NliJ7/PhChqQ/j9y4R9lum5q4RjOlD3wiQMo8+ekckOBB3ii2HUYzGQUqfAhiP7MDEr08oMRmZdlDNPQchIyiVnGscQFnJcktSZZ5stLFe7H5nqlvojrsnJj2GE1YEAJPt4scxniWCcLpOuBwWPzAeARlrTLO2nq2F1+LS3Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XDDsM5Vjpi7JKtq+CZ/2eVN1UBPO5eUSm14130fPsAE=;
 b=C6qp8ZjVUmNUPbeSDXNadxiewTiBeHvtcTEmcTFCv2AHE/Qr1GupozrzUlhJt87os/Gbn/MfyWdWFgRTXMJuFT0m9IiK+kbj+jE3kZcfxR/2zVyKsRl1JMZiP8c3YIx77VXmtCka4nbTf2EtsZSREAZQlNUqeSXlOFFz/ue9ers=
Received: from CY5P221CA0161.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:6a::15)
 by MN2PR12MB4453.namprd12.prod.outlook.com (2603:10b6:208:260::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 09:32:42 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:930:6a:cafe::ce) by CY5P221CA0161.outlook.office365.com
 (2603:10b6:930:6a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Wed, 6 Dec 2023 09:32:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 09:32:41 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 03:32:40 -0600
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Wed, 6 Dec 2023 03:32:38 -0600
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, <michal.simek@amd.com>, 
 <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <git@xilinx.com>,
 "T Karthik Reddy" <t.karthik.reddy@xilinx.com>
Subject: [PATCH v2 16/30] spi: cadence_ospi_versal: ospi ddr changes in
 cadence ospi versal driver
Date: Wed, 6 Dec 2023 15:01:27 +0530
Message-ID: <a32f537bacbc997e5aec82db5571c9ba24d3398b.1701853668.git.tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1701853668.git.tejas.arvind.bhumkar@amd.com>
References: <cover.1701853668.git.tejas.arvind.bhumkar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|MN2PR12MB4453:EE_
X-MS-Office365-Filtering-Correlation-Id: 33de86ad-7f19-47ea-913e-08dbf63e4b7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2o8fPSvyXrOO1w9D2vZTVkXxY0yZ/aKHZM7DoY6GxORpu0yjjJr44sV+WSjDbu9OA/0z+YJ4Shj2Y4HLDhuXThGbmCNrkTVCp8zDs5ZmDHImsRB3gUH9CZEp5akp8HMwf+1fWS+7PJVm8SjfjbqEwylimySR5gxvvsyGMdMMQ/w1foCysN40rgQ3mItkXinnu0+MOLwgOfyb1131EJzcNyJ9uDF6fdJgjjG4oWkhr/WTZM9H65rd4PpY9vruW5WhEUhPLdZQQdcVCP+oZhA8DpGYWbo5Juqmc4bD4phhXh7l5xQOwmShGxoMZxp8g3RbN2yscrdV26FE8iZCvmT58feIj098ZJbn4znZxNPToQBnQzi2yTUqlSZCErxrPS8eDS9vopNGtC/lU5qKCPr5UI8Edq/qCfUZGjwMZQJUjOBAw3YXwcFRw1DKW3tzs0yJEZOO5aWzz9c+H0ihYPnTmAgqoUmHWo4EB9tKvr/0LvjD10VWstqe5BvDlcjHHgDBM39g8Q2i+LPv9+fe+oKyJiM2V8VpXHU6+UCssH2JLMJBw9IPbPvUw9F2UfinUkXtJm+axFs0hJ65/fYdl6zjBeK9nBV9odnimT1syYM/Xom6g6nUGWUEGtqpLarm7TnctZvnbzEJ+DURYuTTO4sACLnbTaw6kf7k55c8UxkISZPYKGRH7hA5DH/M/FA+XYvqPzcOGmiSk5MGbBNAwiZBIXi7aIVn4tGUTCb9GeKEiudV8zAS+yA37gqK3/IOJP7bireDm5hxew+bJa1i2Z/xKQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(136003)(376002)(346002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(82310400011)(40470700004)(36840700001)(46966006)(81166007)(356005)(47076005)(83380400001)(6666004)(478600001)(82740400003)(8676002)(36860700001)(8936002)(316002)(54906003)(70206006)(70586007)(40480700001)(26005)(336012)(2616005)(426003)(6916009)(5660300002)(40460700003)(2906002)(4326008)(41300700001)(36756003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 09:32:41.6798 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33de86ad-7f19-47ea-913e-08dbf63e4b7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4453
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

From: T Karthik Reddy <t.karthik.reddy@xilinx.com>

Set cmd, address & data buswidth to octal. Handle dummy clock
cycles incase of reads & writes. Convert odd bytes to even
bytes lengths in ddr mode, as we cannot rx/tx odd data in
ddr mode.

Disable the DMA once the transfer is done to avoid disabling
it at other places.

Signed-off-by: T Karthik Reddy <t.karthik.reddy@xilinx.com>
Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
---
 drivers/spi/cadence_ospi_versal.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/cadence_ospi_versal.c b/drivers/spi/cadence_ospi_versal.c
index 243de6efaf..9db1911110 100644
--- a/drivers/spi/cadence_ospi_versal.c
+++ b/drivers/spi/cadence_ospi_versal.c
@@ -21,12 +21,13 @@
 
 #define CMD_4BYTE_READ  0x13
 #define CMD_4BYTE_FAST_READ  0x0C
+#define CMD_4BYTE_OCTAL_READ 0x7c
 
 int cadence_qspi_apb_dma_read(struct cadence_spi_priv *priv,
 			      const struct spi_mem_op *op)
 {
 	u32 reg, ret, rx_rem, n_rx, bytes_to_dma, data;
-	u8 opcode, addr_bytes, *rxbuf, dummy_cycles;
+	u8 opcode, addr_bytes, *rxbuf, dummy_cycles, unaligned_byte;
 
 	n_rx = op->data.nbytes;
 	rxbuf = op->data.buf.in;
@@ -70,13 +71,14 @@ int cadence_qspi_apb_dma_read(struct cadence_spi_priv *priv,
 		writel(CQSPI_REG_INDIRECTRD_DONE, priv->regbase +
 		       CQSPI_REG_INDIRECTRD);
 		rxbuf += bytes_to_dma;
-	}
 
-	if (rx_rem) {
+		/* Disable DMA on completion */
 		reg = readl(priv->regbase + CQSPI_REG_CONFIG);
 		reg &= ~CQSPI_REG_CONFIG_ENBL_DMA;
 		writel(reg, priv->regbase + CQSPI_REG_CONFIG);
+	}
 
+	if (rx_rem) {
 		reg = readl(priv->regbase + CQSPI_REG_INDIRECTRDSTARTADDR);
 		reg += bytes_to_dma;
 		writel(reg, priv->regbase + CQSPI_REG_CMDADDRESS);
@@ -84,10 +86,10 @@ int cadence_qspi_apb_dma_read(struct cadence_spi_priv *priv,
 		addr_bytes = readl(priv->regbase + CQSPI_REG_SIZE) &
 				   CQSPI_REG_SIZE_ADDRESS_MASK;
 
-		opcode = CMD_4BYTE_FAST_READ;
-		dummy_cycles = 8;
-		writel((dummy_cycles << CQSPI_REG_RD_INSTR_DUMMY_LSB) | opcode,
-		       priv->regbase + CQSPI_REG_RD_INSTR);
+		opcode = (u8)readl(priv->regbase + CQSPI_REG_RD_INSTR);
+		if (opcode == CMD_4BYTE_OCTAL_READ &&
+		    priv->edge_mode != CQSPI_EDGE_MODE_DDR)
+			opcode = CMD_4BYTE_FAST_READ;
 
 		reg = opcode << CQSPI_REG_CMDCTRL_OPCODE_LSB;
 		reg |= (0x1 << CQSPI_REG_CMDCTRL_RD_EN_LSB);
@@ -99,7 +101,12 @@ int cadence_qspi_apb_dma_read(struct cadence_spi_priv *priv,
 				CQSPI_REG_RD_INSTR_DUMMY_MASK;
 		reg |= (dummy_cycles & CQSPI_REG_CMDCTRL_DUMMY_MASK) <<
 			CQSPI_REG_CMDCTRL_DUMMY_LSB;
-		reg |= (((rx_rem - 1) & CQSPI_REG_CMDCTRL_RD_BYTES_MASK) <<
+		if (priv->edge_mode == CQSPI_EDGE_MODE_DDR && (rx_rem % 2) != 0)
+			unaligned_byte = 1;
+		else
+			unaligned_byte = 0;
+		reg |= (((rx_rem - 1 + unaligned_byte) &
+			CQSPI_REG_CMDCTRL_RD_BYTES_MASK) <<
 			CQSPI_REG_CMDCTRL_RD_BYTES_LSB);
 		ret = cadence_qspi_apb_exec_flash_cmd(priv->regbase, reg);
 		if (ret)
-- 
2.27.0

