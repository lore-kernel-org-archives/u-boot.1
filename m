Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90190CD4F57
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 10:35:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 475B686504;
	Fri, 22 Sep 2023 12:35:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0kfzSnAx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FFF98655F; Fri, 22 Sep 2023 12:35:55 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::615])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55B12864AA
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 12:35:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hbvOH8yZtCe3cwyY5j2yVeOrt/zVJTJVOLHAG14sttoUzGyCYrAnoRRfOIf6Zs6C7GSMAefsyuBFt3fuz7XS1hDpf7RNQFqmjaXWxr3DrNyk8iN+jaAGqJvxdE4lbVQRWWVpShkSXaYoy6imbZmYNoriFrYTbg8FZxqK4DqxfslGzR4jgKN1rOORusCPQuGESzravk/rfLt9NRJnju3rziCNpzBxE3bQS3lGGtiLutrAP7p8xJnz/Vqlyj/0xmbHHGPrK1pb/LMe/jMiTQ6h22yZp9TNfzIrtchk9P/+yJFQ1j5kA6D5PbFHmNuYcap2KVCAF4AMAZSj+u6/+R/BlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=77/rlxdLuRPW84SgcoDBOtGg25XOqS2hAmQ0h/6rKq0=;
 b=U5G+njjBJwxCewxw2crdILJYTgAqON/XqUsx8leBbSyG75YAzFGmrAWSao2tWFOz/zUOn7Gr23HO/Pr6dRjK8d8M4s/DiRUY3vYNSmaj440Rsy1QRyNM412t7uxQIKKdfO4btjvt1Gb44GyWxuYIvkCBqO1+LE0cBILTswR+BsD+KZbJm2DtoDv+YSKNCd1JLbDOEQok5w2onl/SP0p6cqo8CqbRIF9B2+2HptQH7nVncSfe6tM4FIFQTzm+R3iPBxWYI3rwxX/vP7ejMkiknxcYqjJDTUcLvIVPu87wNqXo6P97eMIi+Mz6OeuKnr60zwsHDiF8b8UGAaeimkdQ4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77/rlxdLuRPW84SgcoDBOtGg25XOqS2hAmQ0h/6rKq0=;
 b=0kfzSnAx61TnI9sQOqW0dBC6pVTgH9Gnu8IAo+BjzCR+pDjpMJ4fTgMI5pCuPFXbDAHxx7P8Roq7hzb+yiV4g2CG00kHBw5i7pb9GToWQKoaPQxShbF1/fGHOE7vsqzOEa/VSVL5rFigPv1E3SXK0ZnfscBhF2liInpBqWw1O0g=
Received: from DM6PR13CA0054.namprd13.prod.outlook.com (2603:10b6:5:134::31)
 by CH0PR12MB5331.namprd12.prod.outlook.com (2603:10b6:610:d6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Fri, 22 Sep
 2023 10:35:47 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:5:134:cafe::4) by DM6PR13CA0054.outlook.office365.com
 (2603:10b6:5:134::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.11 via Frontend
 Transport; Fri, 22 Sep 2023 10:35:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Fri, 22 Sep 2023 10:35:46 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 22 Sep
 2023 05:35:45 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Radhey Shyam Pandey
 <radhey.shyam.pandey@amd.com>, Robert Hancock <robert.hancock@calian.com>, 
 Simon Glass <sjg@chromium.org>, Tanmay Shah <tanmay.shah@amd.com>
Subject: [PATCH 00/14] arm64: xilinx: Sync with Linux kernel
Date: Fri, 22 Sep 2023 12:35:29 +0200
Message-ID: <cover.1695378830.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3497; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=gxcBoFsSMa6RUIKV3IOxf/xrCvvxHMOd4lE6JxnuTlE=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlTe3An/DZVv7DsVfCvdn6eA9Z2s4jbtj70xl5jNPOv+y
 emEXlHpiGVhEGRikBVTZJG2uXJmb+WMKcIXD8vBzGFlAhnCwMUpABMxF2GYp2xypvusL191+sVH
 m2e4ZDY/NX/WwjBPr+iItvDxx+UfcpyKNlwMddq6e7sOAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|CH0PR12MB5331:EE_
X-MS-Office365-Filtering-Correlation-Id: b84e0bfa-1061-46ca-8a93-08dbbb57ae5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T/5JCvRu1LbalEGmJmC66XU0IQac8kixdWtnxCFKrDA0U29gYDdd/ZEKHHxV15uMocCiSxsQMC5qPujvtCbBSkHqq7vViVpl6yaktUMix/tUT1uowQz3hYY7CureESeXGRHELfNqxcxi9AT6YsU5sxL+/25HTGct7uI1KTRWOZnZfz4SQhuZhbLhrVpnR28HQtrjcAfoLmU+AnH1GOS3NaEHEB/Vpr/cafvZ15HrTg4BhPutldpPe1/Bca3JSV1vpPUzx5TDse9Lbj7lqb9fG+9t3jZ+tltZ8QpN2sYWYXiishZLeOdQXVqCPGya1NSQcZfWPdAZ0gD9S2ffdV3+TXRVqzLZAJ+3ZdREiaJsjLja+Mvx35f+v4B3MZZCTToFXTrzdbNVq8SSIRBy07E25eG1T0o9/By1MJQgvMbX2vDwMxj3Sf8yEhm2Qtegr1iUR+YCkjppyFhYqhWj02k/vw0EXfHzjm/L9R27Mz/klysHT4zfRNHh/ftQmHEe7YpoedV0yKTmKxuRL8QwToJsfNuaFKgbsgwB7xPcZEQYrw3bPMpb6GFy4MxBCAVdeXL3Sl5I8844Cz2ftP362jmGc6t3AwcOCUYYcMAV8Qcf70FCd58HuGHLnwyvPrvMRqOkm5bdfsZ9nccevXhyw3o7Z0OoNB64uUuH7RZ0lcCSNGQ72jZlvoqdgp+lBHBArivli0b64VxKqwiF1NUJc28JHomkIhDIhbeHRxUAsoK3nSIfR8SgDRPRoCUhIA0hGLTBh3JzEoJyW3bdtnjX5/nnaG35xTx9pcCPw8/uPgbbuRc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(396003)(39860400002)(376002)(1800799009)(82310400011)(230921699003)(186009)(451199024)(36840700001)(40470700004)(46966006)(2906002)(16526019)(40460700003)(83380400001)(356005)(54906003)(5660300002)(44832011)(316002)(40480700001)(41300700001)(8676002)(8936002)(4326008)(36756003)(70586007)(110136005)(70206006)(86362001)(6666004)(336012)(26005)(426003)(2616005)(82740400003)(81166007)(478600001)(47076005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 10:35:46.4321 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b84e0bfa-1061-46ca-8a93-08dbbb57ae5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5331
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

Hi,

this series is syncing DTs with Linux kernel. A lot of patches are simply
taken from the Linux kernel and taken to U-Boot.
But there are also some new one which are trying to fix violations.
There is still some work to happen to be 100% in sync but we are getting
closer and closer.

Thanks,
Michal


Laurent Pinchart (2):
  arm64: dts: zynqmp: zcu106a: Describe DisplayPort connector
  arm64: dts: zynqmp: Add ports for the DisplayPort subsystem

Michal Simek (11):
  arm64: zynqmp: Describe interrupts by using macros
  arm64: xilinx: Remove address/size-cells from flash node
  arm64: xilinx: Use lower case for partition address
  arm64: zynqmp: Describe bus-width for SD card on KV260
  arm64: zynqmp: Fix Siva's email address format
  arm64: xilinx: Put ethernet phys to mdio node
  arm64: xilinx: Remove address/size-cells from gem nodes
  arm64: zynqmp: Convert kv260-revA overlay to ASCII text
  arm64: zynqmp: Sync licenses with Linux kernel
  ARM: zynq: Describe nand device in DT
  arm64: zynqmp: Aligned QSPI configuration with latest spec

Tanmay Shah (1):
  arm64: dts: xilinx: zynqmp: Add RPU subsystem device node

 arch/arm/dts/avnet-ultra96-rev1.dts      |   2 +-
 arch/arm/dts/bitmain-antminer-s9.dts     |   3 +
 arch/arm/dts/versal-mini-emmc0.dts       |   2 +-
 arch/arm/dts/versal-mini-emmc1.dts       |   2 +-
 arch/arm/dts/versal-mini-ospi.dtsi       |   2 +-
 arch/arm/dts/versal-mini-qspi.dtsi       |   2 +-
 arch/arm/dts/versal-mini.dts             |   2 +-
 arch/arm/dts/zynq-zc770-xm011.dts        |   3 +
 arch/arm/dts/zynqmp-clk-ccf.dtsi         |   3 +-
 arch/arm/dts/zynqmp-dlc21-revA.dts       |  10 +-
 arch/arm/dts/zynqmp-g-a2197-00-revA.dts  |  10 +-
 arch/arm/dts/zynqmp-m-a2197-01-revA.dts  |  10 +-
 arch/arm/dts/zynqmp-m-a2197-02-revA.dts  |  10 +-
 arch/arm/dts/zynqmp-m-a2197-03-revA.dts  |  10 +-
 arch/arm/dts/zynqmp-mini-emmc0.dts       |   2 +-
 arch/arm/dts/zynqmp-mini-emmc1.dts       |   2 +-
 arch/arm/dts/zynqmp-mini-nand.dts        |   2 +-
 arch/arm/dts/zynqmp-mini-qspi.dts        |   2 +-
 arch/arm/dts/zynqmp-p-a2197-00-revA.dts  |  10 +-
 arch/arm/dts/zynqmp-sck-kv-g-revA.dtso   |  11 +-
 arch/arm/dts/zynqmp-sck-kv-g-revB.dtso   |   5 +-
 arch/arm/dts/zynqmp-sm-k26-revA.dts      |   6 +-
 arch/arm/dts/zynqmp-zc1254-revA.dts      |   4 +-
 arch/arm/dts/zynqmp-zc1751-xm015-dc1.dts |  15 +-
 arch/arm/dts/zynqmp-zc1751-xm016-dc2.dts |  19 +-
 arch/arm/dts/zynqmp-zc1751-xm017-dc3.dts |   8 +-
 arch/arm/dts/zynqmp-zc1751-xm018-dc4.dts |  26 ++-
 arch/arm/dts/zynqmp-zc1751-xm019-dc5.dts |  10 +-
 arch/arm/dts/zynqmp-zcu102-rev1.0.dts    |   2 +-
 arch/arm/dts/zynqmp-zcu102-revA.dts      |   7 +-
 arch/arm/dts/zynqmp-zcu102-revB.dts      |   3 +-
 arch/arm/dts/zynqmp-zcu104-revA.dts      |   3 +-
 arch/arm/dts/zynqmp-zcu104-revC.dts      |   5 +-
 arch/arm/dts/zynqmp-zcu106-revA.dts      |  27 ++-
 arch/arm/dts/zynqmp-zcu111-revA.dts      |   7 +-
 arch/arm/dts/zynqmp-zcu1275-revA.dts     |   2 +-
 arch/arm/dts/zynqmp-zcu1275-revB.dts     |   2 +-
 arch/arm/dts/zynqmp-zcu1285-revA.dts     |   2 +-
 arch/arm/dts/zynqmp-zcu208-revA.dts      |   4 +-
 arch/arm/dts/zynqmp-zcu216-revA.dts      |   4 +-
 arch/arm/dts/zynqmp.dtsi                 | 249 +++++++++++++++--------
 arch/arm/mach-versal/mp.c                |   2 +-
 drivers/fpga/zynqmppl.c                  |   2 +-
 43 files changed, 345 insertions(+), 169 deletions(-)

-- 
2.36.1

