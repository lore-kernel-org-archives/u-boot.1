Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CAF4C4167B
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 07:40:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B76D98758F;
	Fri, 15 Dec 2023 08:40:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5Ng3r9J/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCE768780E; Fri, 15 Dec 2023 08:40:28 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::618])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DB7687575
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 08:40:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=neal.frager@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E780NvP/ZYeJDyqtZLdiqEMhiI8tnpE4F968jGTJa1Y9kVy135tQZt/wFRcW8df5238pp8AFGGVnBSzw+GzbORH04FVvaxsJkt7tJDvyE5fE56HLfgXRBa5e0ObMAWmpbmaHmUDR626W4u3EN2AMCSSvYyO8PCOF8RBuzooiTp4Ayp2AmssWk9KDAl+I337t/8GPaje7d8pJyUmWs6i9ANFQcHYwBBf/Kev0Fq4McwM4amwoMUfiK5Pz0J8/9UVRg8XpOMiUafymt2j7WE/Jpumx8uiPHe4/2DCWNGSKK9SYS1FlSC6n7inZ4d+Or6yLkphjds98eNKbaWSn1+T+2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RlYAqGnbc8oYholGSylYZFmJi64+7U1U5ApE+aqA7Dk=;
 b=Zi8xxvZV+dXkw+YM8kG1IN9H5I3Vq5GS3bT//PWzpwqpHbUzs4LCWwDj4hZJqJxPEcC1CnDHBM6/IVq1x9WmNuEG9z7JnCgPDkTkFyg8PBxUv9c/FOPxQ5+4DEdhoDNmaYuTyx/Y32R0cyJ+M2XiLn4CwciSWcFXdk9pwffB/jy0FqnBzuRMHxvTRQX8l7SxiEudbV+eWvKSVwN0HuyHiRUz4JEk/+NN2UAiOXdsWX2xNVXtsY/0PsN5qayoS92sLfJrGQrT5ELvYjB6qCvk3ZVCN5yHrmfaNhQPO2cjNf12ggYi1k/rOfm25aLzhCh5xjqdu1A/UIOvhmezs3uRkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RlYAqGnbc8oYholGSylYZFmJi64+7U1U5ApE+aqA7Dk=;
 b=5Ng3r9J/KnCzkY8WVz1ipkWOpZmV7wvLxGPCvCSKpzCVGj8BwoHhrrQ5gAI/aAM1XvKA/DF2fXol4VRX2Ivx36clqkIFA60mAPP7+vAoESQSXwQ5FS8Yl5KBXS6aSQChf1bIfo6srXUuPP/1nMnhOXEakaP+sB9k9bE8rTgl+8U=
Received: from SA1P222CA0163.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::22)
 by PH7PR12MB6419.namprd12.prod.outlook.com (2603:10b6:510:1fd::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 07:40:17 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:806:3c3:cafe::3a) by SA1P222CA0163.outlook.office365.com
 (2603:10b6:806:3c3::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31 via Frontend
 Transport; Fri, 15 Dec 2023 07:40:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Fri, 15 Dec 2023 07:40:16 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 15 Dec
 2023 01:40:16 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 15 Dec
 2023 01:40:15 -0600
Received: from xirengwts09.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Fri, 15 Dec 2023 01:40:15 -0600
From: Neal Frager <neal.frager@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <luca.ceresoli@bootlin.com>, Neal Frager
 <neal.frager@amd.com>
Subject: [PATCH v2 1/1] arm64: zynqmp: Enable usb3 for k24 som
Date: Fri, 15 Dec 2023 07:40:12 +0000
Message-ID: <20231215074012.483465-1-neal.frager@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|PH7PR12MB6419:EE_
X-MS-Office365-Filtering-Correlation-Id: e2c42969-8146-4d89-4d1e-08dbfd4114ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cyhh/CiRbJb6zw+IDX7FFIcJySpXUsmiVHNzecMNkHmdpzdiLeXezRSY5IpCihuPheUzNB8fWaX+wzmIj6HQfd3KYyKKMHE+y5K5D4278y5uV+ErpfevDgBdpd1b3kTdHNXVv9Y08Q5qqYRopKyg3uKBrRFoc1uSadV2SHyR1hn2qxAquF/yvbxhSVG0LpJSi7R/gbPGpDjbS0v1iFef/vLZI2tLrQbftcOv36zxQut3HgZnyl9fLsoQXwfQ2BotywytAkumrV8QrrrQ+oYDbdxdfFnH+4Mn0wXUUDw6/axW5f9VHRr/CfPLKyhiv76mmPfAAi/xBBwXeVGIOujzXq8dQveEk4cjx+3/kGqh6Gkt91UtJBK4Aa5+p2nx+v7TObXa/dwEbcKz4Ayd9imLszMjh3UTE/WcunoJm45RPfzQ6k8pgNEaDSH+saaQZ3wMp4xwqYidcuFxkvlzGwp3WFjk/p3G8BdOWodogXtwyRhQpZbzFpUjY5fyzDuahWTChA3JOsHB5tsJPS/4A/4/l576HYB8dmgCfiME3lIsmLL5LN9dOHyh5pTCKfbjPpGi5I6h6Kjx+Qk+s9gHGl2BnKAQNZqCT2ThrB0ZZAVqaaK+rp2oO1Sgr/ItL11iYe9nJxbhREWeOT9komSpE+WsRP7hxkDcsBX3Wa4Gkg/vcWh9UU+l64AWUvJJuklam2Cg+0njIpuSPZkOSAqb5+9Dyph9bn1zl67LZH1BwCk7kqVgX66OqrVOg6ofLMQb503RSnsm0dkmDlrzNYXSgx+nwA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(230922051799003)(64100799003)(82310400011)(186009)(451199024)(1800799012)(36840700001)(40470700004)(46966006)(41300700001)(1076003)(478600001)(2616005)(30864003)(36860700001)(336012)(26005)(86362001)(70206006)(70586007)(40480700001)(426003)(6666004)(54906003)(6916009)(356005)(81166007)(40460700003)(82740400003)(316002)(83380400001)(36756003)(8676002)(4326008)(8936002)(2906002)(47076005)(44832011)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 07:40:16.5467 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c42969-8146-4d89-4d1e-08dbfd4114ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6419
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

Currently, the u-boot zynqmp psgtr driver is not connected to the usb dwc3
driver.  Without this, the only way for u-boot to be able to use usb3 is if
the psgtr serdes clocking is already enabled in the psu_init_gpl.c.  This
patch enables the psgtr serdes for usb3 use, so the u-boot dwc3 driver will
work properly on boards based on the k24 som.

In addition, this patch correctly configures mio76 and mio77 as gpio pins
which are used as reset gpio pins on the kd240 starter kit.

This patch is needed for enabling u-boot to load an OS on the kd240
starter kit by either usb3 or the sd card interface connected over the usb3
to sd card bridge.

Signed-off-by: Neal Frager <neal.frager@amd.com>
---
V1->V2:
 - rebased patch to latest u-boot master branch
 - improved git commit message
---
 .../zynqmp/zynqmp-sm-k24-revA/psu_init_gpl.c  | 283 +++++++++++++++++-
 1 file changed, 270 insertions(+), 13 deletions(-)

diff --git a/board/xilinx/zynqmp/zynqmp-sm-k24-revA/psu_init_gpl.c b/board/xilinx/zynqmp/zynqmp-sm-k24-revA/psu_init_gpl.c
index 166e61431b..591f093752 100644
--- a/board/xilinx/zynqmp/zynqmp-sm-k24-revA/psu_init_gpl.c
+++ b/board/xilinx/zynqmp/zynqmp-sm-k24-revA/psu_init_gpl.c
@@ -72,6 +72,18 @@ static void dpll_prog(int div2, int ddr_pll_fbdiv, int d_lock_dly,
 	Xil_Out32(((0xFD1A0000U) + 0x0000002C), pll_ctrl_regval);
 }
 
+static int serdes_illcalib(u32 lane3_protocol, u32 lane3_rate,
+			   u32 lane2_protocol, u32 lane2_rate,
+			   u32 lane1_protocol, u32 lane1_rate,
+			   u32 lane0_protocol, u32 lane0_rate)
+{
+	Xil_Out32(0xFD409914, 0xF3);
+	Xil_Out32(0xFD409940, 0xF3);
+	Xil_Out32(0xFD409990, 0x20);
+	Xil_Out32(0xFD409924, 0x37);
+	return 1;
+}
+
 static unsigned long psu_pll_init_data(void)
 {
 	psu_mask_write(0xFF5E0034, 0xFE7FEDEFU, 0x7E4B0C62U);
@@ -528,8 +540,8 @@ static unsigned long psu_mio_init_data(void)
 	psu_mask_write(0xFF180124, 0x000000FEU, 0x00000002U);
 	psu_mask_write(0xFF180128, 0x000000FEU, 0x00000002U);
 	psu_mask_write(0xFF18012C, 0x000000FEU, 0x00000002U);
-	psu_mask_write(0xFF180130, 0x000000FEU, 0x000000C0U);
-	psu_mask_write(0xFF180134, 0x000000FEU, 0x000000C0U);
+	psu_mask_write(0xFF180130, 0x000000FEU, 0x00000000U);
+	psu_mask_write(0xFF180134, 0x000000FEU, 0x00000000U);
 	psu_mask_write(0xFF180204, 0xFFFFFFFFU, 0x50000000U);
 	psu_mask_write(0xFF180208, 0xFFFFFFFFU, 0x00B02020U);
 	psu_mask_write(0xFF18020C, 0x00003FFFU, 0x00000FC0U);
@@ -569,21 +581,16 @@ static unsigned long psu_peripherals_init_data(void)
 	psu_mask_write(0xFD1A0100, 0x0001807CU, 0x00000000U);
 	psu_mask_write(0xFF5E0238, 0x001A0000U, 0x00000000U);
 	psu_mask_write(0xFF5E023C, 0x0093C018U, 0x00000000U);
-	psu_mask_write(0xFF5E0230, 0x00000008U, 0x00000000U);
+	psu_mask_write(0xFF5E0230, 0x00000002U, 0x00000000U);
 	psu_mask_write(0xFF5E0238, 0x00000001U, 0x00000000U);
 	psu_mask_write(0xFF180390, 0x00000004U, 0x00000004U);
 	psu_mask_write(0xFF5E023C, 0x00000400U, 0x00000000U);
-	psu_mask_write(0xFF5E0238, 0x00000040U, 0x00000000U);
-	psu_mask_write(0xFF180310, 0x00008000U, 0x00000000U);
-	psu_mask_write(0xFF180320, 0x33840000U, 0x02840000U);
-	psu_mask_write(0xFF18031C, 0x7FFE0000U, 0x64500000U);
-	psu_mask_write(0xFF180358, 0x00000008U, 0x00000008U);
-	psu_mask_write(0xFF180324, 0x03C00000U, 0x00000000U);
+	psu_mask_write(0xFF5E0238, 0x00000080U, 0x00000000U);
 	psu_mask_write(0xFF5E0238, 0x00000400U, 0x00000000U);
 	psu_mask_write(0xFF5E0238, 0x00008000U, 0x00000000U);
 	psu_mask_write(0xFF5E0238, 0x00000010U, 0x00000000U);
 	psu_mask_write(0xFF5E0238, 0x00007800U, 0x00000000U);
-	psu_mask_write(0xFF5E0238, 0x00000004U, 0x00000000U);
+	psu_mask_write(0xFF5E0238, 0x00000006U, 0x00000000U);
 	psu_mask_write(0xFF5E0238, 0x00040000U, 0x00000000U);
 	psu_mask_write(0xFF4B0024, 0x000000FFU, 0x000000FFU);
 	psu_mask_write(0xFFCA5000, 0x00001FFFU, 0x00000000U);
@@ -591,13 +598,111 @@ static unsigned long psu_peripherals_init_data(void)
 	psu_mask_write(0xFFA60040, 0x80000000U, 0x80000000U);
 	psu_mask_write(0xFF260020, 0xFFFFFFFFU, 0x05F5DD18U);
 	psu_mask_write(0xFF260000, 0x00000001U, 0x00000001U);
-	psu_mask_write(0xFF5E0250, 0x00000F0FU, 0x00000202U);
+	psu_mask_write(0xFF0A0284, 0x03FFFFFFU, 0x01000000U);
+	psu_mask_write(0xFF0A0288, 0x03FFFFFFU, 0x01000000U);
+	psu_mask_write(0xFF0A0014, 0x03FF03FFU, 0x02FF0100U);
 
 	mask_delay(1);
-	psu_mask_write(0xFF5E0250, 0x00000F0FU, 0x00000002U);
+	psu_mask_write(0xFF0A0014, 0x03FF03FFU, 0x02FF0000U);
 
 	mask_delay(5);
-	psu_mask_write(0xFF5E0250, 0x00000F0FU, 0x00000202U);
+	psu_mask_write(0xFF0A0014, 0x03FF03FFU, 0x02FF0100U);
+
+	return 1;
+}
+
+static unsigned long psu_serdes_init_data(void)
+{
+	psu_mask_write(0xFD410008, 0x0000001FU, 0x00000008U);
+	psu_mask_write(0xFD402868, 0x00000080U, 0x00000080U);
+	psu_mask_write(0xFD40A094, 0x00000010U, 0x00000010U);
+	psu_mask_write(0xFD40A368, 0x000000FFU, 0x00000038U);
+	psu_mask_write(0xFD40A36C, 0x00000007U, 0x00000003U);
+	psu_mask_write(0xFD40A370, 0x000000FFU, 0x000000F4U);
+	psu_mask_write(0xFD40A374, 0x000000FFU, 0x00000031U);
+	psu_mask_write(0xFD40A378, 0x000000FFU, 0x00000002U);
+	psu_mask_write(0xFD40A37C, 0x00000033U, 0x00000030U);
+	psu_mask_write(0xFD40906C, 0x00000003U, 0x00000003U);
+	psu_mask_write(0xFD4080F4, 0x00000003U, 0x00000003U);
+	psu_mask_write(0xFD4090CC, 0x00000020U, 0x00000020U);
+	psu_mask_write(0xFD401074, 0x00000010U, 0x00000010U);
+	psu_mask_write(0xFD405074, 0x00000010U, 0x00000010U);
+	psu_mask_write(0xFD409074, 0x00000010U, 0x00000010U);
+	psu_mask_write(0xFD40D074, 0x00000010U, 0x00000010U);
+	psu_mask_write(0xFD401994, 0x00000007U, 0x00000007U);
+	psu_mask_write(0xFD405994, 0x00000007U, 0x00000007U);
+	psu_mask_write(0xFD40989C, 0x00000080U, 0x00000080U);
+	psu_mask_write(0xFD4098F8, 0x000000FFU, 0x0000001AU);
+	psu_mask_write(0xFD4098FC, 0x000000FFU, 0x0000001AU);
+	psu_mask_write(0xFD409990, 0x000000FFU, 0x00000010U);
+	psu_mask_write(0xFD409924, 0x000000FFU, 0x000000FEU);
+	psu_mask_write(0xFD409928, 0x000000FFU, 0x00000000U);
+	psu_mask_write(0xFD409900, 0x000000FFU, 0x0000001AU);
+	psu_mask_write(0xFD40992C, 0x000000FFU, 0x00000000U);
+	psu_mask_write(0xFD409980, 0x000000FFU, 0x000000FFU);
+	psu_mask_write(0xFD409914, 0x000000FFU, 0x000000F7U);
+	psu_mask_write(0xFD409918, 0x00000001U, 0x00000001U);
+	psu_mask_write(0xFD409940, 0x000000FFU, 0x000000F7U);
+	psu_mask_write(0xFD409944, 0x00000001U, 0x00000001U);
+	psu_mask_write(0xFD409994, 0x00000007U, 0x00000007U);
+	psu_mask_write(0xFD40D994, 0x00000007U, 0x00000007U);
+	psu_mask_write(0xFD40107C, 0x0000000FU, 0x00000001U);
+	psu_mask_write(0xFD40507C, 0x0000000FU, 0x00000001U);
+	psu_mask_write(0xFD40907C, 0x0000000FU, 0x00000001U);
+	psu_mask_write(0xFD40D07C, 0x0000000FU, 0x00000001U);
+	psu_mask_write(0xFD4019A4, 0x000000FFU, 0x000000FFU);
+	psu_mask_write(0xFD401038, 0x00000040U, 0x00000040U);
+	psu_mask_write(0xFD40102C, 0x00000040U, 0x00000040U);
+	psu_mask_write(0xFD4059A4, 0x000000FFU, 0x000000FFU);
+	psu_mask_write(0xFD405038, 0x00000040U, 0x00000040U);
+	psu_mask_write(0xFD40502C, 0x00000040U, 0x00000040U);
+	psu_mask_write(0xFD4099A4, 0x000000FFU, 0x000000FFU);
+	psu_mask_write(0xFD409038, 0x00000040U, 0x00000040U);
+	psu_mask_write(0xFD40902C, 0x00000040U, 0x00000040U);
+	psu_mask_write(0xFD40D9A4, 0x000000FFU, 0x000000FFU);
+	psu_mask_write(0xFD40D038, 0x00000040U, 0x00000040U);
+	psu_mask_write(0xFD40D02C, 0x00000040U, 0x00000040U);
+	psu_mask_write(0xFD4019AC, 0x00000003U, 0x00000000U);
+	psu_mask_write(0xFD4059AC, 0x00000003U, 0x00000000U);
+	psu_mask_write(0xFD4099AC, 0x00000003U, 0x00000000U);
+	psu_mask_write(0xFD40D9AC, 0x00000003U, 0x00000000U);
+	psu_mask_write(0xFD401978, 0x00000010U, 0x00000010U);
+	psu_mask_write(0xFD405978, 0x00000010U, 0x00000010U);
+	psu_mask_write(0xFD409978, 0x00000010U, 0x00000010U);
+	psu_mask_write(0xFD40D978, 0x00000010U, 0x00000010U);
+
+	serdes_illcalib(0, 0, 3, 0, 0, 0, 0, 0);
+	psu_mask_write(0xFD410014, 0x00000007U, 0x00000003U);
+	return 1;
+}
+
+static unsigned long psu_resetout_init_data(void)
+{
+	psu_mask_write(0xFF5E023C, 0x00000400U, 0x00000000U);
+	psu_mask_write(0xFF9D0080, 0x00000001U, 0x00000001U);
+	psu_mask_write(0xFF9D007C, 0x00000001U, 0x00000000U);
+	psu_mask_write(0xFF5E023C, 0x00000140U, 0x00000000U);
+	psu_mask_write(0xFF5E0230, 0x00000002U, 0x00000000U);
+	psu_mask_write(0xFD1A0100, 0x00010000U, 0x00000000U);
+	psu_mask_write(0xFD4A0200, 0x00000002U, 0x00000000U);
+	psu_mask_write(0xFD4A0238, 0x0000000FU, 0x00000000U);
+	psu_mask_write(0xFE20C200, 0x00023FFFU, 0x00022457U);
+	psu_mask_write(0xFE20C630, 0x003FFF00U, 0x00000000U);
+	psu_mask_write(0xFE20C11C, 0x00000600U, 0x00000600U);
+	psu_mask_write(0xFE20C12C, 0x00004000U, 0x00004000U);
+	psu_mask_write(0xFD480064, 0x00000200U, 0x00000200U);
+	mask_poll(0xFD40A3E4, 0x00000010U);
+
+	return 1;
+}
+
+static unsigned long psu_resetin_init_data(void)
+{
+	psu_mask_write(0xFF5E023C, 0x00000540U, 0x00000540U);
+	psu_mask_write(0xFF5E0230, 0x00000002U, 0x00000002U);
+	psu_mask_write(0xFD4A0238, 0x0000000FU, 0x0000000AU);
+	psu_mask_write(0xFD4A0200, 0x00000002U, 0x00000002U);
+	psu_mask_write(0xFD1A0100, 0x00010000U, 0x00010000U);
 
 	return 1;
 }
@@ -911,6 +1016,157 @@ static unsigned long psu_ddr_phybringup_data(void)
 	return 1;
 }
 
+static int serdes_enb_coarse_saturation(void)
+{
+	Xil_Out32(0xFD402094, 0x00000010);
+	Xil_Out32(0xFD406094, 0x00000010);
+	Xil_Out32(0xFD40A094, 0x00000010);
+	Xil_Out32(0xFD40E094, 0x00000010);
+	return 1;
+}
+
+static int serdes_fixcal_code(void)
+{
+	int maskstatus = 1;
+	unsigned int rdata = 0;
+	unsigned int match_pmos_code[23];
+	unsigned int match_nmos_code[23];
+	unsigned int match_ical_code[7];
+	unsigned int match_rcal_code[7];
+	unsigned int p_code = 0;
+	unsigned int n_code = 0;
+	unsigned int i_code = 0;
+	unsigned int r_code = 0;
+	unsigned int repeat_count = 0;
+	unsigned int L3_TM_CALIB_DIG20 = 0;
+	unsigned int L3_TM_CALIB_DIG19 = 0;
+	unsigned int L3_TM_CALIB_DIG18 = 0;
+	unsigned int L3_TM_CALIB_DIG16 = 0;
+	unsigned int L3_TM_CALIB_DIG15 = 0;
+	unsigned int L3_TM_CALIB_DIG14 = 0;
+	int i = 0;
+
+	rdata = Xil_In32(0xFD40289C);
+	rdata = rdata & ~0x03;
+	rdata = rdata | 0x1;
+	Xil_Out32(0xFD40289C, rdata);
+	int count = 0;
+	do {
+		if (count == 1100000)
+			break;
+		rdata = Xil_In32(0xFD402B1C);
+		count++;
+	} while ((rdata & 0x0000000E) != 0x0000000E);
+
+	for (i = 0; i < 23; i++) {
+		match_pmos_code[i] = 0;
+		match_nmos_code[i] = 0;
+	}
+	for (i = 0; i < 7; i++) {
+		match_ical_code[i] = 0;
+		match_rcal_code[i] = 0;
+	}
+
+	do {
+		Xil_Out32(0xFD410010, 0x00000000);
+		Xil_Out32(0xFD410014, 0x00000000);
+
+		Xil_Out32(0xFD410010, 0x00000001);
+		Xil_Out32(0xFD410014, 0x00000000);
+
+		maskstatus = mask_poll(0xFD40EF14, 0x2);
+		if (maskstatus == 0) {
+			xil_printf("#SERDES initialization timed out\n\r");
+			return maskstatus;
+		}
+
+		p_code = mask_read(0xFD40EF18, 0xFFFFFFFF);
+		n_code = mask_read(0xFD40EF1C, 0xFFFFFFFF);
+		;
+		i_code = mask_read(0xFD40EF24, 0xFFFFFFFF);
+		r_code = mask_read(0xFD40EF28, 0xFFFFFFFF);
+		;
+
+		if (p_code >= 0x26 && p_code <= 0x3C)
+			match_pmos_code[p_code - 0x26] += 1;
+
+		if (n_code >= 0x26 && n_code <= 0x3C)
+			match_nmos_code[n_code - 0x26] += 1;
+
+		if (i_code >= 0xC && i_code <= 0x12)
+			match_ical_code[i_code - 0xC] += 1;
+
+		if (r_code >= 0x6 && r_code <= 0xC)
+			match_rcal_code[r_code - 0x6] += 1;
+
+	} while (repeat_count++ < 10);
+
+	for (i = 0; i < 23; i++) {
+		if (match_pmos_code[i] >= match_pmos_code[0]) {
+			match_pmos_code[0] = match_pmos_code[i];
+			p_code = 0x26 + i;
+		}
+		if (match_nmos_code[i] >= match_nmos_code[0]) {
+			match_nmos_code[0] = match_nmos_code[i];
+			n_code = 0x26 + i;
+		}
+	}
+
+	for (i = 0; i < 7; i++) {
+		if (match_ical_code[i] >= match_ical_code[0]) {
+			match_ical_code[0] = match_ical_code[i];
+			i_code = 0xC + i;
+		}
+		if (match_rcal_code[i] >= match_rcal_code[0]) {
+			match_rcal_code[0] = match_rcal_code[i];
+			r_code = 0x6 + i;
+		}
+	}
+
+	L3_TM_CALIB_DIG20 = mask_read(0xFD40EC50, 0xFFFFFFF0);
+	L3_TM_CALIB_DIG20 = L3_TM_CALIB_DIG20 | 0x8 | ((p_code >> 2) & 0x7);
+
+	L3_TM_CALIB_DIG19 = mask_read(0xFD40EC4C, 0xFFFFFF18);
+	L3_TM_CALIB_DIG19 = L3_TM_CALIB_DIG19 | ((p_code & 0x3) << 6)
+	    | 0x20 | 0x4 | ((n_code >> 3) & 0x3);
+
+	L3_TM_CALIB_DIG18 = mask_read(0xFD40EC48, 0xFFFFFF0F);
+	L3_TM_CALIB_DIG18 = L3_TM_CALIB_DIG18 | ((n_code & 0x7) << 5) | 0x10;
+
+	L3_TM_CALIB_DIG16 = mask_read(0xFD40EC40, 0xFFFFFFF8);
+	L3_TM_CALIB_DIG16 = L3_TM_CALIB_DIG16 | ((r_code >> 1) & 0x7);
+
+	L3_TM_CALIB_DIG15 = mask_read(0xFD40EC3C, 0xFFFFFF30);
+	L3_TM_CALIB_DIG15 = L3_TM_CALIB_DIG15 | ((r_code & 0x1) << 7)
+	    | 0x40 | 0x8 | ((i_code >> 1) & 0x7);
+
+	L3_TM_CALIB_DIG14 = mask_read(0xFD40EC38, 0xFFFFFF3F);
+	L3_TM_CALIB_DIG14 = L3_TM_CALIB_DIG14 | ((i_code & 0x1) << 7) | 0x40;
+
+	Xil_Out32(0xFD40EC50, L3_TM_CALIB_DIG20);
+	Xil_Out32(0xFD40EC4C, L3_TM_CALIB_DIG19);
+	Xil_Out32(0xFD40EC48, L3_TM_CALIB_DIG18);
+	Xil_Out32(0xFD40EC40, L3_TM_CALIB_DIG16);
+	Xil_Out32(0xFD40EC3C, L3_TM_CALIB_DIG15);
+	Xil_Out32(0xFD40EC38, L3_TM_CALIB_DIG14);
+	return maskstatus;
+}
+
+static int init_serdes(void)
+{
+	int status = 1;
+
+	status &= psu_resetin_init_data();
+
+	status &= serdes_fixcal_code();
+	status &= serdes_enb_coarse_saturation();
+
+	status &= psu_serdes_init_data();
+	status &= psu_resetout_init_data();
+
+	return status;
+}
+
 static void init_peripheral(void)
 {
 	psu_mask_write(0xFD5F0018, 0x8000001FU, 0x8000001FU);
@@ -927,6 +1183,7 @@ int psu_init(void)
 	status &= psu_ddr_init_data();
 	status &= psu_ddr_phybringup_data();
 	status &= psu_peripherals_init_data();
+	status &= init_serdes();
 	init_peripheral();
 
 	status &= psu_afi_config();
-- 
2.25.1

