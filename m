Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30696C41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 16:17:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BB2487775;
	Tue, 19 Dec 2023 17:17:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r/I2kJEk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4A73876FA; Tue, 19 Dec 2023 17:17:11 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A77D874F3
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 17:17:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hqu4mTYSDyaSYhJeTo25UeS4EETnUBIQtkJLrTEG7ZPnTfS4DSl/Wbu8gPhni7bQkKE9U9OVtwPFu/UqgNWwhoejiwoN8o0ABwmFd69Y1qCGHSYBMSWcRTo4lcmhkDWFEk3rrz5VXkJt1jDj3LxOupJvW8n4hHB++NMD1OixnInyCGwRRKE2LaN0cJg03tbl4egSoaCS88eFzZaWHuTuQtQbWm8xLb0oCVTQOrdPrbQCbMbh1VAvdm0nsEXi1spLO8dasHQI9X71ip7rkgkewFJS/hTOGv/C8JtGHgcpCPogTeZNOvqUJxjCNjMSRA6GNStEwFJWvGysN2vplWtx4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8FkSIxL4rXSEuBDe3QwQkQfbDGR8aqc/xDk4xPVP+0Q=;
 b=CERpuEPrwDYeWlyj3VP7TIxetEIj+UCzWVeem7SR768OloR99gFshdnzOcqCfo5QE496YZ+zi5OsJ2Iu+IB9BRxQjiVlZk22q+Q6gqoGgJYILQ4J74KbivU4p3181aeDMfQ3YY3sG5AOlWg3lkxKygvsIiF+w4za/eorznfFbAK1p4G4+VWU1SOZx1/E671BooizXjNiBM1Usif9FGLKjxC+a5exbH9Fen1lVTruAo3FIqpkHznAaWC1xzc3q9f9KVnfb3DQKjmq9aQ2MFB13rVqr7WZsUeNiqp8hG7ahYlKjRaJyngtp/9hwrjbe+Fe8NniCfkdUibUXORMU5+bUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8FkSIxL4rXSEuBDe3QwQkQfbDGR8aqc/xDk4xPVP+0Q=;
 b=r/I2kJEkAeZ0SxQiV8OKJV0r4d/qKjnfiimmu/KXBjHnpZezw9KjQrG0WsxBe9NFXT7Cplu13vDh+dGlvZ5xSddy99SZSgXbm/dFxe7SdoDQdYgmOk5MtMhhwJhe01fMODg0UH84bV3u3x9ypbFXZUfruCjnG+ywhfg1L6UXFME=
Received: from DM6PR07CA0111.namprd07.prod.outlook.com (2603:10b6:5:330::12)
 by SA0PR12MB7463.namprd12.prod.outlook.com (2603:10b6:806:24b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 16:17:06 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:330:cafe::dc) by DM6PR07CA0111.outlook.office365.com
 (2603:10b6:5:330::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38 via Frontend
 Transport; Tue, 19 Dec 2023 16:17:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Tue, 19 Dec 2023 16:17:06 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 19 Dec
 2023 10:17:04 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
Subject: [PATCH 3/4] arm64: zynqmp: Remove mt25qu512a compatible string from
 SOM
Date: Tue, 19 Dec 2023 17:16:49 +0100
Message-ID: <517672560a472de33c8e5c4ffc729d8e288da43c.1703002605.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1703002605.git.michal.simek@amd.com>
References: <cover.1703002605.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=738; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=otRgdjY8hrbHF4mOWWQZvtjd+Lziye+TBUNnpDgdkEQ=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtTGg++TJq5g/3Z36mbt5jqjxCM1jVuyhVRneuXUOvUm3
 va627ikI5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAExk9xKGeaqnnJTrln79G1ZX
 8f5jzCHWiyJ8mxnm6elPX6f38pun0qZzGduZNRQ1BHU9AA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|SA0PR12MB7463:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ddd3161-bc59-46bc-d816-08dc00adf1b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4deroD3PpvyVxxCHj93dqQLpiWNnmWd1DsbSUnOWdt12qAQ1AgUDgbx8E1cJjMP0k3DLu1Qn4NGlfvjPavXFezCzgOfQM0FwOzby3IExu9LcW9btSlU8bZBLPHXP5Ba9wL1cDA5FrAArKM7I5dOKVA1Rd0W+Q/qs3VvEOKwMnvs3CqLtvCeYIZyvu1VQq5/kA4g8odCpbCdjicBoEnxAzWzNIh7bI3PMCgboK61io3/3O4rbRS85OTtzj1ls0Xcdkx8HoXen9AwfSsPXwHCaFUsdVBmx/PHXvGSpcXgX+lIc3cgUGO8uJsp/xCCeszeV4RqI8tA5GsbOWdAKtzfTCbMY4j+IgFNqwYRR4U19xhkvD/LjIvrJ0ign7tu/DVQimP3TuKr+qw64ttijvdFj5mcGXp2wu5cfXLn9b4xclxNCggEZ0bq9gwqwOd/Pzxz5kFQVIccQQTl44cuTtwWGxCAzWTdF2KO6iEqN48YUm3qFXD1FEt1Y8OHeoE4Y2apcS2Wzi666mH1nndFKvi2rEddEtUwlG22LcjGKLyYfPc6s+CzHjVYrJgHWf50Xlhwg/KDQDTwnb0j5DK9KlA1dDIrVgj+NEAfKGxlUhFvLLt7SyAlWDlSuITJefSbh+rE4FLRoEIfpPZQKRUlJwojpbHpDpge8h7X2MfNvgzHDwwvQswqG/jjkTXx+cHKeHlLxxVp56a7hF+J8zTr51uO8Ao7TzPiAvLSyuqxGuxbkDinHv0P4OQo+6XJg4hBliCvyAaKU8XnRMAjazIKuEOxbeg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(396003)(136003)(376002)(230922051799003)(64100799003)(82310400011)(1800799012)(451199024)(186009)(40470700004)(36840700001)(46966006)(40480700001)(426003)(336012)(16526019)(26005)(2616005)(40460700003)(86362001)(356005)(82740400003)(81166007)(6666004)(36756003)(47076005)(83380400001)(5660300002)(44832011)(36860700001)(8676002)(70206006)(8936002)(70586007)(110136005)(316002)(41300700001)(2906002)(4744005)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 16:17:06.3842 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ddd3161-bc59-46bc-d816-08dc00adf1b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7463
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

mt25qu512a is not documented in DT binding that's why remove it.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-sm-k26-revA.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/zynqmp-sm-k26-revA.dts b/arch/arm/dts/zynqmp-sm-k26-revA.dts
index 1d62c48e062e..5859e6cd8c23 100644
--- a/arch/arm/dts/zynqmp-sm-k26-revA.dts
+++ b/arch/arm/dts/zynqmp-sm-k26-revA.dts
@@ -144,7 +144,7 @@
 &qspi { /* MIO 0-5 - U143 */
 	status = "okay";
 	spi_flash: flash@0 { /* MT25QU512A */
-		compatible = "mt25qu512a", "jedec,spi-nor"; /* 64MB */
+		compatible = "jedec,spi-nor"; /* 64MB */
 		reg = <0>;
 		spi-tx-bus-width = <4>;
 		spi-rx-bus-width = <4>;
-- 
2.36.1

