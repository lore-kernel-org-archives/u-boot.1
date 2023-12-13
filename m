Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD225C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 13:40:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0051287506;
	Wed, 13 Dec 2023 14:40:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j/zYfsAj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CBF1874A5; Wed, 13 Dec 2023 14:40:19 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34CDE87508
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 14:40:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=neal.frager@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Axz8SKPdcGgPTtEIDTIurd2mXrhZovJqqgr2l/RZLmJ9+IDLwTIW2YgI8vxBKxTBfKOoWo0x5SEaTJtycF7mJnBAV8gtfdnfSLveuDWF978dfselbU53VMAjgS020DsmbOzzdSxuTA0hjqXqLcSGTWceqvi8JsGMRNxPE79Elo1XrhwjL0t5b/KeJ6pKs5PG+MfBvTgdYLih3niqQogpsUbK4lDYzMmdapwQHNzh6wSgrGiwnpjxHpQVzhCMzYI8Xf85xdhWVrTgzRKd1aB4kzZK1YpPNip5itXzPGc494AB7u3ceZLGJLBeWdwqwzT5DiTn5lOJ3Zhqeil+oSTqTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pa2cGFEvLf1zQssM/urn8Ygf4zGqv0QZEDepbOvxyLI=;
 b=VT99TgVsp1CY0JkWNnVxDpnr8EfCl7P3UlIkta7rjc72V+U9+tEU1SYF+pAROKSdEuz6WdKv38jB05m4nnxoKpxSxY4lzUvsb3l8OTM4gpUxh5Htv/BujMyVBMmXs41v1prESkj+EQg7gnVz3XI5O9E9gMZpdnQRAnymQC5xUV/6ZM7y5ENLv5Bd4Mr3X0DBSo/E1Hh2gheFPopunKiBwJtuGuiUdSm6zngjj3fFLgIMsA/b6WWrWs4gZAHZHUA19IrhHwVY82U1cATrQT/P+cLD1R2ECFfxGeT9pNypAOLfKT4GhJW/O4J8oVdDhIfq0ymUfOsVs8EACxKX7TmUNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pa2cGFEvLf1zQssM/urn8Ygf4zGqv0QZEDepbOvxyLI=;
 b=j/zYfsAjdrwPr/wOBE2c3ZlKnPKH68EkNHahR8OphQZdMFnDREkAiitn+Zcemb6Fj60uKS9cagzSrpjDByX1elNih/68bOsdLLBEo5INvEpyp+ygK6YolI8f8yp0k7kBXsBLhcUHoFmCsDUxImWIdptEMwb4BRi5d5fOeX6knNE=
Received: from CYXPR03CA0066.namprd03.prod.outlook.com (2603:10b6:930:d1::18)
 by MW3PR12MB4348.namprd12.prod.outlook.com (2603:10b6:303:5f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 13:40:12 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:930:d1:cafe::1e) by CYXPR03CA0066.outlook.office365.com
 (2603:10b6:930:d1::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Wed, 13 Dec 2023 13:40:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Wed, 13 Dec 2023 13:40:12 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 13 Dec
 2023 07:40:10 -0600
Received: from xirengwts09.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 13 Dec 2023 07:40:10 -0600
From: Neal Frager <neal.frager@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <luca.ceresoli@bootlin.com>, Neal Frager
 <neal.frager@amd.com>
Subject: [PATCH v1 1/1] arm64: zynqmp: Fix k24 psu_init_gpl.c clocking
Date: Wed, 13 Dec 2023 13:40:07 +0000
Message-ID: <20231213134007.2818069-1-neal.frager@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|MW3PR12MB4348:EE_
X-MS-Office365-Filtering-Correlation-Id: 4deb98eb-17bd-4513-2c73-08dbfbe107f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fNghgXS/h/iWUxsHry1MZ0q6amZfk+/Qn01YNNDYEwNJo7OnFmECfWjt3jhy23WiF3sSWy8eFazcf7QLeN5+56HKgDfY/5eQ8AKw4xgyLnVykFgwGnPss99D+akxPy3Su2XSMFZADJDZ4cefMIKz0EMl7yJuYZPnYZcvdUbpyat8ZeNba3CPNoQOaxw9fsz9uFpiXG4Lzly929ZNgzCAvH6qUP0T8XZDbpUWfIWZZMy3bi0vfeH6swmxL2vSx1E9DlK1/JncVuZiyiUUFN471CWromLtyq2qBPUnnX1tL15DzwAd2Nr1IBCIS6tn5cIcnaDclYd3UMFlbQaKCdDm/qgyT4bKmYVXqtq3BsFVI5ytxVNvzba2HFjJj7hlEgq1yfnip82ofsmhzVroYMKqhCcc2rt6adqF6BUv6ze7fGsrWEAtQ9MCkdZb5rwjtBJ0LO2PolYX6wdG4i0z6bnCOa3JqzIL2KMeBuslb5mzTXC3VcAAG06xPod9bonpm4VhMzg+gS6/FSMwOfJJ2KTVNAXS+K7FiUYVtPlteG459weWlztljcEm4rAP0WErsqTV+sfr9ao0K9Fa/Zi0FOv3YNNCJORNP8XSXNAx6nnlgOXuxKj1+gIyaQ1S2czWAQoUfnSZoAB5w4w0U9I1XKkFh1RzMCCER/3PJ70jJDfdGIDZTQpSs8RB8bknFysgy7MpWixZVDXZUXQny+iVs7gjRV8ZfXNmyJADgtd9C54McHvP+p4G91QAu8uCwyEqOOvaS73X0sTFct8zxZzWiE9Byw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(396003)(136003)(346002)(230922051799003)(82310400011)(451199024)(64100799003)(1800799012)(186009)(40470700004)(36840700001)(46966006)(40480700001)(2616005)(1076003)(83380400001)(40460700003)(81166007)(356005)(86362001)(82740400003)(36756003)(47076005)(4326008)(5660300002)(30864003)(36860700001)(426003)(6666004)(336012)(316002)(6916009)(478600001)(70586007)(70206006)(54906003)(41300700001)(44832011)(8936002)(8676002)(2906002)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 13:40:12.1412 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4deb98eb-17bd-4513-2c73-08dbfbe107f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4348
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

This patch corrects the k24 som clocking configuration such that the serdes
clocks are correctly enabled and the usb0 is configured to use the psgtr
refclk2 for usb3 mode.

This patch also corrects the configuration of mio pins mio76 and mio77
which should be configured as gpio pins.

Signed-off-by: Neal Frager <neal.frager@amd.com>
---
 .../zynqmp/zynqmp-sm-k24-revA/psu_init_gpl.c  | 266 +++++++++++++-----
 1 file changed, 200 insertions(+), 66 deletions(-)

diff --git a/board/xilinx/zynqmp/zynqmp-sm-k24-revA/psu_init_gpl.c b/board/xilinx/zynqmp/zynqmp-sm-k24-revA/psu_init_gpl.c
index 45102302dc..4c904c6c81 100644
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
@@ -490,20 +502,20 @@ static unsigned long psu_mio_init_data(void)
 	psu_mask_write(0xFF18008C, 0x000000FEU, 0x00000000U);
 	psu_mask_write(0xFF180090, 0x000000FEU, 0x000000C0U);
 	psu_mask_write(0xFF180094, 0x000000FEU, 0x000000C0U);
-	psu_mask_write(0xFF180098, 0x000000FEU, 0x00000000U);
-	psu_mask_write(0xFF18009C, 0x000000FEU, 0x00000010U);
-	psu_mask_write(0xFF1800A0, 0x000000FEU, 0x00000010U);
-	psu_mask_write(0xFF1800A4, 0x000000FEU, 0x00000010U);
-	psu_mask_write(0xFF1800A8, 0x000000FEU, 0x00000010U);
-	psu_mask_write(0xFF1800AC, 0x000000FEU, 0x00000010U);
-	psu_mask_write(0xFF1800B0, 0x000000FEU, 0x00000000U);
-	psu_mask_write(0xFF1800B4, 0x000000FEU, 0x00000010U);
-	psu_mask_write(0xFF1800B8, 0x000000FEU, 0x00000010U);
-	psu_mask_write(0xFF1800BC, 0x000000FEU, 0x00000010U);
-	psu_mask_write(0xFF1800C0, 0x000000FEU, 0x00000010U);
-	psu_mask_write(0xFF1800C4, 0x000000FEU, 0x00000010U);
-	psu_mask_write(0xFF1800C8, 0x000000FEU, 0x00000010U);
-	psu_mask_write(0xFF1800CC, 0x000000FEU, 0x00000010U);
+	psu_mask_write(0xFF180098, 0x000000FEU, 0x00000002U);
+	psu_mask_write(0xFF18009C, 0x000000FEU, 0x00000002U);
+	psu_mask_write(0xFF1800A0, 0x000000FEU, 0x00000002U);
+	psu_mask_write(0xFF1800A4, 0x000000FEU, 0x00000002U);
+	psu_mask_write(0xFF1800A8, 0x000000FEU, 0x00000002U);
+	psu_mask_write(0xFF1800AC, 0x000000FEU, 0x00000002U);
+	psu_mask_write(0xFF1800B0, 0x000000FEU, 0x00000002U);
+	psu_mask_write(0xFF1800B4, 0x000000FEU, 0x00000002U);
+	psu_mask_write(0xFF1800B8, 0x000000FEU, 0x00000002U);
+	psu_mask_write(0xFF1800BC, 0x000000FEU, 0x00000002U);
+	psu_mask_write(0xFF1800C0, 0x000000FEU, 0x00000002U);
+	psu_mask_write(0xFF1800C4, 0x000000FEU, 0x00000002U);
+	psu_mask_write(0xFF1800C8, 0x000000FEU, 0x00000080U);
+	psu_mask_write(0xFF1800CC, 0x000000FEU, 0x00000080U);
 	psu_mask_write(0xFF1800D0, 0x000000FEU, 0x00000004U);
 	psu_mask_write(0xFF1800D4, 0x000000FEU, 0x00000004U);
 	psu_mask_write(0xFF1800D8, 0x000000FEU, 0x00000004U);
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
@@ -539,18 +551,18 @@ static unsigned long psu_mio_init_data(void)
 	psu_mask_write(0xFF180144, 0x03FFFFFFU, 0x03FFFFFFU);
 	psu_mask_write(0xFF180148, 0x03FFFFFFU, 0x03FFFFFFU);
 	psu_mask_write(0xFF18014C, 0x03FFFFFFU, 0x03FFFFFFU);
-	psu_mask_write(0xFF180154, 0x03FFFFFFU, 0x00080814U);
+	psu_mask_write(0xFF180154, 0x03FFFFFFU, 0x00FC0814U);
 	psu_mask_write(0xFF180158, 0x03FFFFFFU, 0x03FFFFFFU);
 	psu_mask_write(0xFF18015C, 0x03FFFFFFU, 0x00000000U);
-	psu_mask_write(0xFF180160, 0x03FFFFFFU, 0x03FFFFFFU);
-	psu_mask_write(0xFF180164, 0x03FFFFFFU, 0x03FFFFFFU);
-	psu_mask_write(0xFF180168, 0x03FFFFFFU, 0x03F7F7EBU);
-	psu_mask_write(0xFF180170, 0x03FFFFFFU, 0x00FC000BU);
+	psu_mask_write(0xFF180160, 0x0387FFFFU, 0x0387FFFFU);
+	psu_mask_write(0xFF180164, 0x03FFFFFFU, 0x03FFF87FU);
+	psu_mask_write(0xFF180168, 0x03FFFFFFU, 0x0303F7EBU);
+	psu_mask_write(0xFF180170, 0x03FFFFFFU, 0x0004400BU);
 	psu_mask_write(0xFF180174, 0x03FFFFFFU, 0x03FFFFFFU);
 	psu_mask_write(0xFF180178, 0x03FFFFFFU, 0x00000000U);
-	psu_mask_write(0xFF18017C, 0x0357FFFFU, 0x0357FFFFU);
-	psu_mask_write(0xFF180180, 0x03FFFFFFU, 0x0357FFFFU);
-	psu_mask_write(0xFF180184, 0x03FFFFFFU, 0x0303FFF4U);
+	psu_mask_write(0xFF18017C, 0x03FFFFFFU, 0x03FFFFFFU);
+	psu_mask_write(0xFF180180, 0x03FFFFFFU, 0x03FFFFFFU);
+	psu_mask_write(0xFF180184, 0x03FFFFFFU, 0x03FBBFF4U);
 	psu_mask_write(0xFF180200, 0x0000000FU, 0x00000000U);
 
 	return 1;
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
@@ -591,40 +598,26 @@ static unsigned long psu_peripherals_init_data(void)
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
 
 	return 1;
 }
 
 static unsigned long psu_serdes_init_data(void)
 {
-	psu_mask_write(0xFD410000, 0x0000001FU, 0x00000009U);
-	psu_mask_write(0xFD410004, 0x0000001FU, 0x00000009U);
 	psu_mask_write(0xFD410008, 0x0000001FU, 0x00000008U);
-	psu_mask_write(0xFD402860, 0x00000080U, 0x00000080U);
-	psu_mask_write(0xFD402864, 0x00000081U, 0x00000001U);
-	psu_mask_write(0xFD402868, 0x00000082U, 0x00000002U);
+	psu_mask_write(0xFD402868, 0x00000080U, 0x00000080U);
 	psu_mask_write(0xFD40A094, 0x00000010U, 0x00000010U);
 	psu_mask_write(0xFD40A368, 0x000000FFU, 0x00000038U);
 	psu_mask_write(0xFD40A36C, 0x00000007U, 0x00000003U);
-	psu_mask_write(0xFD402368, 0x000000FFU, 0x00000058U);
-	psu_mask_write(0xFD40236C, 0x00000007U, 0x00000003U);
-	psu_mask_write(0xFD406368, 0x000000FFU, 0x00000058U);
-	psu_mask_write(0xFD40636C, 0x00000007U, 0x00000003U);
-	psu_mask_write(0xFD402370, 0x000000FFU, 0x0000007CU);
-	psu_mask_write(0xFD402374, 0x000000FFU, 0x00000033U);
-	psu_mask_write(0xFD402378, 0x000000FFU, 0x00000002U);
-	psu_mask_write(0xFD40237C, 0x00000033U, 0x00000030U);
-	psu_mask_write(0xFD406370, 0x000000FFU, 0x0000007CU);
-	psu_mask_write(0xFD406374, 0x000000FFU, 0x00000033U);
-	psu_mask_write(0xFD406378, 0x000000FFU, 0x00000002U);
-	psu_mask_write(0xFD40637C, 0x00000033U, 0x00000030U);
 	psu_mask_write(0xFD40A370, 0x000000FFU, 0x000000F4U);
 	psu_mask_write(0xFD40A374, 0x000000FFU, 0x00000031U);
 	psu_mask_write(0xFD40A378, 0x000000FFU, 0x00000002U);
@@ -678,18 +671,8 @@ static unsigned long psu_serdes_init_data(void)
 	psu_mask_write(0xFD409978, 0x00000010U, 0x00000010U);
 	psu_mask_write(0xFD40D978, 0x00000010U, 0x00000010U);
 
-	serdes_illcalib(0, 0, 3, 0, 4, 0, 4, 0);
-	psu_mask_write(0xFD410010, 0x00000077U, 0x00000044U);
+	serdes_illcalib(0, 0, 3, 0, 0, 0, 0, 0);
 	psu_mask_write(0xFD410014, 0x00000007U, 0x00000003U);
-	psu_mask_write(0xFD400CB4, 0x00000037U, 0x00000037U);
-	psu_mask_write(0xFD404CB4, 0x00000037U, 0x00000037U);
-	psu_mask_write(0xFD4001D8, 0x00000001U, 0x00000001U);
-	psu_mask_write(0xFD4041D8, 0x00000001U, 0x00000001U);
-	psu_mask_write(0xFD404CC0, 0x0000001FU, 0x00000000U);
-	psu_mask_write(0xFD400CC0, 0x0000001FU, 0x00000000U);
-	psu_mask_write(0xFD404048, 0x000000FFU, 0x00000000U);
-	psu_mask_write(0xFD400048, 0x000000FFU, 0x00000000U);
-
 	return 1;
 }
 
@@ -699,7 +682,7 @@ static unsigned long psu_resetout_init_data(void)
 	psu_mask_write(0xFF9D0080, 0x00000001U, 0x00000001U);
 	psu_mask_write(0xFF9D007C, 0x00000001U, 0x00000000U);
 	psu_mask_write(0xFF5E023C, 0x00000140U, 0x00000000U);
-	psu_mask_write(0xFF5E0230, 0x00000008U, 0x00000000U);
+	psu_mask_write(0xFF5E0230, 0x00000002U, 0x00000000U);
 	psu_mask_write(0xFD1A0100, 0x00010000U, 0x00000000U);
 	psu_mask_write(0xFD4A0200, 0x00000002U, 0x00000000U);
 	psu_mask_write(0xFD4A0238, 0x0000000FU, 0x00000000U);
@@ -708,7 +691,6 @@ static unsigned long psu_resetout_init_data(void)
 	psu_mask_write(0xFE20C11C, 0x00000600U, 0x00000600U);
 	psu_mask_write(0xFE20C12C, 0x00004000U, 0x00004000U);
 	psu_mask_write(0xFD480064, 0x00000200U, 0x00000200U);
-	mask_poll(0xFD4063E4, 0x00000010U);
 	mask_poll(0xFD40A3E4, 0x00000010U);
 
 	return 1;
@@ -717,7 +699,7 @@ static unsigned long psu_resetout_init_data(void)
 static unsigned long psu_resetin_init_data(void)
 {
 	psu_mask_write(0xFF5E023C, 0x00000540U, 0x00000540U);
-	psu_mask_write(0xFF5E0230, 0x00000008U, 0x00000008U);
+	psu_mask_write(0xFF5E0230, 0x00000002U, 0x00000002U);
 	psu_mask_write(0xFD4A0238, 0x0000000FU, 0x0000000AU);
 	psu_mask_write(0xFD4A0200, 0x00000002U, 0x00000002U);
 	psu_mask_write(0xFD1A0100, 0x00010000U, 0x00010000U);
@@ -1034,6 +1016,157 @@ static unsigned long psu_ddr_phybringup_data(void)
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
@@ -1050,6 +1183,7 @@ int psu_init(void)
 	status &= psu_ddr_init_data();
 	status &= psu_ddr_phybringup_data();
 	status &= psu_peripherals_init_data();
+	status &= init_serdes();
 	init_peripheral();
 
 	status &= psu_afi_config();
-- 
2.25.1

