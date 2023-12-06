Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62DDCC4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 05:36:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 439068773B;
	Wed,  6 Dec 2023 06:34:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CuYK4EiX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61C7C876E9; Wed,  6 Dec 2023 06:34:37 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23569876F7
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 06:34:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U5ADuwAfMzhKY0SJiE4JiOTjoXkiypEYiJQbF6LyA/CQsgCYP6W1ELvs0E8EHvR8Vybu68BLrUtlr1QqnJPIcx4cifHclGi2Xn0/i8t2n+j8VmPZjy92D7HOoKY/vASquwpBuDkpHzzqA7OtiloULOxut/wTgT8g68pMr7jktTN7OAhDCCvKfcc6RZT1vk7Aa+9D9iY+debFNvU56ekof9EXUNtW7uRIDaiCXD7JaFUeoQahzScuWzilQTo7LKrN8uRgPFb1f3QOb540OCj2BN0PJKjpE6HxAJWlCumaLNDHr13fa3U6zNFw/yY/34dQQEqlO4pO7XzllM/DAlP2xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XDDsM5Vjpi7JKtq+CZ/2eVN1UBPO5eUSm14130fPsAE=;
 b=E/ZQiygCkqpJwkfdApFaS4Wqs27mwHiICY+AEeDt2r61w2pLOuridv0NwTvp+w+5bFesrUSUxKdbyrt88iu6qfJI4EmOyhSPldDYNi5ffrabBQoy38ox7+m/I9JM5Wxgmyjjo/qFFc5zwu6OzjhZDLqjzrFqMJ1F7hREan+kwNfh9hW2rQiDWGni+peMnVvlZFi+Rh3PP0gPcmvtrc72dhdzXckk23NRh4M4SLreCMup3jWikHrb5HELCwdqHRCQYqh3T8vg5XmdaI+4jiuMtOwsXwIlHKghXADRV5p8OxyRJ99Zj2fT8xqECo/YXyO26rlSZwEmr984KsXkrRj22A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XDDsM5Vjpi7JKtq+CZ/2eVN1UBPO5eUSm14130fPsAE=;
 b=CuYK4EiXON1RigK/gLOFkgSpWq8uUx7TW8HOWp1PeSaHjmQmX7pKSBqTaMvDve1S/9mAThhrDJYpPdap0PBwetqzzyAW2gjPDvO+2OtYPbFdsQOy2b676UIH7LkyrhzmftOB9tyFAQzMOJ90fjMOvewVVBoEPTDEp6Z5nPesWf0=
Received: from MN2PR05CA0001.namprd05.prod.outlook.com (2603:10b6:208:c0::14)
 by BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Wed, 6 Dec
 2023 05:34:23 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:c0:cafe::60) by MN2PR05CA0001.outlook.office365.com
 (2603:10b6:208:c0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25 via Frontend
 Transport; Wed, 6 Dec 2023 05:34:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 05:34:23 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 5 Dec
 2023 23:34:22 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 5 Dec
 2023 21:34:21 -0800
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Tue, 5 Dec 2023 23:34:19 -0600
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, <michal.simek@amd.com>, 
 <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <git@xilinx.com>,
 "T Karthik Reddy" <t.karthik.reddy@xilinx.com>
Subject: [PATCH 16/30] spi: cadence_ospi_versal: ospi ddr changes in cadence
 ospi versal driver
Date: Wed, 6 Dec 2023 11:03:50 +0530
Message-ID: <20231206053353.3745918-7-tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20231206053353.3745918-1-tejas.arvind.bhumkar@amd.com>
References: <20231206053353.3745918-1-tejas.arvind.bhumkar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|BL0PR12MB5506:EE_
X-MS-Office365-Filtering-Correlation-Id: 4aba7929-596e-49aa-8114-08dbf61d0108
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zfan4qhM92+8h88websW9oGgAxb3DyKLY13TB7+jSsVZn4XC5pI2UWZUVHjcHqjJHlNSy7Q3iPNDPA0/74LueV+wHMyfx+55ldrVxWdRyvMHeDjFmQRo+thCyHdiYp9M3sxso92Xu5Q6oazc6TEzVvdAE8hhS8baKzhoCXxh0YQ4rJab0dLxJIldpMp5KaCdjHF4qKgeM4q79/nzQwqYEcz46F8rKSc83AmIguyEW6RFPiJe8qPDBfYmx+W5S10AJDpy/PBbPVT/0keE9iIYiAUUUVDRjEbqJJOtvPhq76LAUv/m5qyaEHwFSEhWiX+EZ2VGlEyKxV8JsX3Dgd/0rXKo+UPs6hCLzH46o8Auc8scmFo/0LB6z/2+tpft4obPASg9H/fmX91U649ijIuss+nvC/1sxz2CbK5LeqRDjVXpIQu0AGvwZTXrneRHfqx5dSgsO+UpdzcJY4U9pfmNL4sQZFwMbuwDgcycWs9uRvsXVeX3SHRUD1LOeJVImWw1Wj3yBL2Capo0nxQLGvGtfWQr/QhrdBoXwXi4GHjAV7/6/ogN3O5D5ykUrsfoBrDYSPXRey1U/Jmn7XjdsFa0h+d6DQlpxdbSnJiltRtWxiiewWlc/nB0k8ig766G6ty5K1fEjHaynBlaJNhspdWoIB9Sr0igHwTI3F20xyeDTpWRDssqtc+iEx2WAue5DDa8fY62olv1mORtmIZjlAE5vJFFJDIBOyfd+B6bLEAE1K1O/dAWEVni6FRyA4WOU6xSaPHKsPMRhcQmJj5zLfWhEQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(136003)(376002)(396003)(230922051799003)(451199024)(186009)(82310400011)(1800799012)(64100799003)(36840700001)(40470700004)(46966006)(41300700001)(36756003)(86362001)(40460700003)(5660300002)(2906002)(103116003)(2616005)(26005)(1076003)(40480700001)(82740400003)(83380400001)(426003)(6666004)(336012)(478600001)(47076005)(81166007)(356005)(36860700001)(4326008)(8936002)(8676002)(54906003)(70206006)(316002)(70586007)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 05:34:23.3782 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aba7929-596e-49aa-8114-08dbf61d0108
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5506
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

