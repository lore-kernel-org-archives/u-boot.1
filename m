Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAAD3C54E58
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 17:23:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80F7F87F16;
	Mon, 11 Mar 2024 18:23:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ijcHq2ml";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E48287E6F; Mon, 11 Mar 2024 18:23:14 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3528987F04
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 18:23:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DaV5HzxOBAOqiL0mR04AXTOs5ADDYfYS2cTboPFLR9gYjDcNg8DLkiSUQX6PG6mvDRKfsBKP3Yf80eh/x/Kq1v1OKO9HcUIF6zvYr63GsHfjskLlSPj/WTSaHC/sWY7AVJwjyEWdjL612oL4bSiB5M4cWQxC6LThNX+6jkPeEoQvcwKFftLYpvNPLjUPgx4WtCb4Fz08mcBNt8C/ISfbKc33Gsf7hdb3iipyWQmqCsGYUVfUbS7sAjaju/gofh/4HDQLigBoTryNzZy0+VyKcczoUm2tY7DGu6BEri0UbuYU7ZVI7584KnePyHvWgh+Dg23pniFDnfEiF1ErPTZ0tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=upsdTUqO3dNAGBOgqWyZysYP1/R4YyeU+iTbrOnRzMM=;
 b=XCr9ioUXQISgnwIwIm/j/HVPRMgxiUlGtlfGR7PWT0rIwzlPvf18TvX+QPlUlUJzWiKqXBhDyLD+XkgxkEhCmDVOuKxReqzsisfkrE4plckNKmbbMtEgo6S9hGVZx1uMfkADHQM+xWJW77mFS5Uq/6awP5+KmPVcOEJs8CHAtxYAB8z+i8uAMhrunhhxO5Lq1IGrGSq915DsJggEhgJ2Lun+JquZJS1Fod3wiRkkpnLawSOpnVD2bohOE4GB4FOLEc6p+CGaHZscHp6NJL/5GtRIYqWmsbqW0r9deCAzJ301UkKSbS9YsG1mv8+Dxpw0biqBgUpad6l5mSOcupUsEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=upsdTUqO3dNAGBOgqWyZysYP1/R4YyeU+iTbrOnRzMM=;
 b=ijcHq2mlUPFdx7CR6MNDF7Bpl6+wkZjoIyTW7lzIKOKGobcZQ3S/AJ/q2dhYbUdALLE26zbyhJK5Wz34E8sgOHN7+8vQbn+M022bXmsFGnTjmNetMC0eacRaZqqJSGEEl3RKQXtFUJXUkWR56MA9lMp7VZHxSUPncF+PmJaBjRI=
Received: from CH0PR03CA0314.namprd03.prod.outlook.com (2603:10b6:610:118::29)
 by IA0PR12MB8373.namprd12.prod.outlook.com (2603:10b6:208:40d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 17:23:09 +0000
Received: from CH2PEPF0000013B.namprd02.prod.outlook.com
 (2603:10b6:610:118:cafe::ee) by CH0PR03CA0314.outlook.office365.com
 (2603:10b6:610:118::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35 via Frontend
 Transport; Mon, 11 Mar 2024 17:23:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013B.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Mon, 11 Mar 2024 17:23:08 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 11 Mar
 2024 12:23:06 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 11 Mar
 2024 10:23:06 -0700
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 11 Mar 2024 12:23:04 -0500
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <jagan@amarulasolutions.com>, <n-francis@ti.com>, <michal.simek@amd.com>, 
 <venkatesh.abbarapu@amd.com>, <git@amd.com>, T Karthik Reddy
 <t.karthik.reddy@xilinx.com>
Subject: [PATCH 03/19] spi: cadence_ospi_versal: ospi ddr changes in cadence
 ospi versal driver
Date: Mon, 11 Mar 2024 22:52:33 +0530
Message-ID: <d473534fed06d96657684a4226d353dc5072a565.1710098033.git.tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1710098033.git.tejas.arvind.bhumkar@amd.com>
References: <cover.1710098033.git.tejas.arvind.bhumkar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013B:EE_|IA0PR12MB8373:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c000015-9806-400b-26f3-08dc41efebb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JBngb9Mu2IU98fE7W+xLYdbIXi65n5Yu9WpcbEWtyyCR881TMoX4y7QjVYhiR+BpFWCyKO60jc+lL/y0vzpZV1KaFw33Cld3ZpKKoBS/aUHfbjQFCv1bKZon2PmPZnmBpsAkHwxs4eL+TgJ47PZPAgNS839C+8HHyNK9pGoOG4RnbADcdqWreGRR7cmpKz6pqV+mwoLypT8+mZNpv4wXuZ0HSCNxmhESvtle6Y3B3up3fW938xzQ34zfHU6rU8NOqypIeM7hDQHBBlW8T2JuDVX74gUSL+cr5ImK7HoyCQMKfn81PO2KrI7EVrJD2eu+ujig4IQHDTVtcu0LEiE48DlghuqXKStpldlPZQLlZrcV2c08pjt2XfhLeEWtld0N41cW0LRsmUzg4GmjvSlCfDYBKrYeh5rkAgU547pnDJGqqk/2OyTnPbx2Ehc5GnuQE90zM9XFfaZs/0VrseZcy1GZqDX3lY9efbOndMH95YU4uAmxWqG4N/sQPFOhf2TjptkkmcXlqxvDZk+pckQyCS8kOJUeyDXRHyhctOhmjL+i7nWWYZMbUaPxYxJZzHdDqrTVktm4XkI80gHozD6psU0LcWGY84OgDGgmIC/ntfWvlkAjOYlgWXtb9NQqbbTcVVyDgzGYF46wVF4N+V+F3tQq+UpdeR5GeZUNN3s+q0IaBCVm5prIDOqPYTkwKb7r6KLtuB1QFcZiIRhhU59wTZWcJ24D+VeBDQcNyANi8/vK9kdsX/6dgRe4sdTxKW8q
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 17:23:08.6780 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c000015-9806-400b-26f3-08dc41efebb7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8373
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
 drivers/spi/cadence_ospi_versal.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/cadence_ospi_versal.c b/drivers/spi/cadence_ospi_versal.c
index 30abb7b431..2c5bdd5f26 100644
--- a/drivers/spi/cadence_ospi_versal.c
+++ b/drivers/spi/cadence_ospi_versal.c
@@ -23,7 +23,7 @@ int cadence_qspi_apb_dma_read(struct cadence_spi_priv *priv,
 			      const struct spi_mem_op *op)
 {
 	u32 reg, ret, rx_rem, n_rx, bytes_to_dma, data;
-	u8 opcode, addr_bytes, *rxbuf, dummy_cycles;
+	u8 opcode, addr_bytes, *rxbuf, dummy_cycles, unaligned_byte;
 
 	n_rx = op->data.nbytes;
 	rxbuf = op->data.buf.in;
@@ -67,13 +67,14 @@ int cadence_qspi_apb_dma_read(struct cadence_spi_priv *priv,
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
@@ -81,10 +82,10 @@ int cadence_qspi_apb_dma_read(struct cadence_spi_priv *priv,
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
@@ -96,7 +97,12 @@ int cadence_qspi_apb_dma_read(struct cadence_spi_priv *priv,
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

