Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C0E1CD4F57
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 10:38:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AADE86B76;
	Fri, 22 Sep 2023 12:37:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zoLxBnXM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 051B886B74; Fri, 22 Sep 2023 12:37:01 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::60a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBB8686B68
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 12:36:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HXBexQ0PPP7fvomW8SEMqz65O5msb78q7hH6tBmjzohovelpKYa/H+bEGYgSeWvswFYHH3fyLvi888Qf36F3vKF7z0rokwUCfuCgxoc/QbHdPgwl5wd0kt2ru0dnA9Ao3/LQBkBK+ksYxCM+u6CZnoUMuoMdAkJu2VJtNrWt79Zc4PotRBBnJSNgSYhCtby62rmD5YgDnvuOYHS07i8qON9w4piemg0V3a/Dlm0CY0sSXr72YlD45kjKLUfQ5iIwIAszdLvCvncY8VCKTIiP82F6QPqSCccULJOuT/WQPJCQ3cJRTEuL7L/SnbhkVMzTm5Pc43lJ8pDDcyi/ulzJVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2qxGSdQtEHoCrRUq09/g35IDioKNNSnyD4vQopTSyf4=;
 b=HqHLyReKzZNigyJxGMyet/2hPhP9sGa59tcWrIihREE8Be67Z65KMGi/+KjXqgX6P97z/Qs1kD1i6wTqz8TcX2hRcTrdz/7qQuu/XogJqu0BU+wiuGGgQYTDS+9AFOUWAc/GQzDLfGvk87bK4J1h37n/NsXenChjABr3UMYdLPGj7QlK8HiT/nDwfcRdyUcHGPgvG58LaoMYZnjlCRUbPA+pBKzknwAhUa0VHhxThCXjsgrqeuAnzCDEf6k/ylC2FvxBB1Jj0OtuyJw5QxHYQWb31TsBKtj7IVuNo7TNntc9XISQhO7dq2eDNwtfumFd8c/nwUdzPbtIBus7Myd44g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qxGSdQtEHoCrRUq09/g35IDioKNNSnyD4vQopTSyf4=;
 b=zoLxBnXMea3peCN9aVO3aKY8KwMrH1qXSZ7oschLUwYWgOZe2HWd2qjxUHfVXt6ZvEX/4bN/HoPk1l6P8cWAvnTaE27G3kHDKY+zOsdANdbEK3K/fa93W/p8liV7rdensN+sCvpE38st8LVLuDno4fQn84tzAqBimmOleiyplk4=
Received: from DM6PR13CA0067.namprd13.prod.outlook.com (2603:10b6:5:134::44)
 by BL1PR12MB5826.namprd12.prod.outlook.com (2603:10b6:208:395::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 22 Sep
 2023 10:36:56 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:5:134:cafe::bd) by DM6PR13CA0067.outlook.office365.com
 (2603:10b6:5:134::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.13 via Frontend
 Transport; Fri, 22 Sep 2023 10:36:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Fri, 22 Sep 2023 10:36:55 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 22 Sep
 2023 05:36:53 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
Subject: [PATCH 12/14] arm64: zynqmp: Sync licenses with Linux kernel
Date: Fri, 22 Sep 2023 12:35:41 +0200
Message-ID: <813b29378083153b67c60772f28cd2613519f338.1695378830.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1695378830.git.michal.simek@amd.com>
References: <cover.1695378830.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7937; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=WfPs8SVFyOAwqjdUmz0BXTsMF+b3hGDAjp8Ch4IjgJg=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlTe3OkrPBb+7wp+4PbP23BDOh9XWk/j350S1p+NbbLEz
 xSWt83siGVhEGRikBVTZJG2uXJmb+WMKcIXD8vBzGFlAhnCwMUpABORdGeYX3SU78whg7rMtsev
 BG4vkDl8RaWqmmGeZX6P1tOQB3q15c1pk89Y8/lO534FAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|BL1PR12MB5826:EE_
X-MS-Office365-Filtering-Correlation-Id: ba3625ed-be15-41c7-dad2-08dbbb57d79c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N3CqBt8y7kLxyEIw7/FQOg+O7hpgtTg8ik7ML7YA8xv0vmXGVjyKJrexqhj5o/VLmLbaCWQtShQIrWJ/OEj9mt9MisCyV9kqgZn30iBNzgkPKd6OcGXqaMTnxpi0OEwH/AmwuWPsCON0o7U5rF1MkziPZL8RVjkzYs1V3IjWPZecRDVGHPVha70vzhohhxVFTEddLfsOjzQ9aVIKwYeWauJ8uFbwV/SrixQSilFOd/Eth4fOl5JUfTFH3bESZsSPj/8XhsDdxkl96S6N/NQ4QLLePuOWzBjju0TtVyM6Soj9reg764XCd4k/uQEiAwdSttssblPk3y3lzqdnpPvdVnuMyydKGxBKf4YTIAkigMdqAKa/h853rAhb2X0mMLVeKURxv2DSYOsavw1hk81Z1NYkNHOBM/Od76C61bi6v8IB8GaOt+r6iyjAUGrxRXvh8DZzhrMogUln0Cl6OxSK2/zbccg2kW4UgOUNdUk+ZPSztQSTk6NMF9JGTPCau7Adkcl0jzwlu9ODaKaMyrIDEmRKU6dJ+JVTLDfYk66NNWVIgbkvpEmnKZQvrk6wg2D0eTRyJqehRc/SCeaFNzsAhUj5SvE/XXn0aZ6900DTuqD8KhN6tWM38GHdB5Q0YeEJUaINcNsnWUNrxPEevdjx3jAYzxOejib0eVpKOBbGzouPG1gApPIjFMVec+woogN1vNmf6tv5s/QtZbZ05areKgnQEWzauFV/uegBm8fqiVbrr0AkanbzmWUmny2ky4etkatdA+b9XX8joGGF8SHc/rLzvglgm95ZK+8+KRBC3khiz0IYGJcE7XEjHLScpkvm
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(396003)(39860400002)(136003)(186009)(451199024)(230921699003)(82310400011)(1800799009)(40470700004)(46966006)(36840700001)(2616005)(40460700003)(2906002)(478600001)(83380400001)(86362001)(36756003)(6666004)(26005)(40480700001)(336012)(16526019)(426003)(41300700001)(8676002)(8936002)(36860700001)(47076005)(70586007)(5660300002)(44832011)(316002)(82740400003)(356005)(110136005)(81166007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 10:36:55.6205 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba3625ed-be15-41c7-dad2-08dbbb57d79c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5826
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

There is difference between licenses in the Linux kernel and there
shouldn't be any diff because all changes are coming from the same source
at the same time. The difference is really in a time when they were
upstreamed. That's why sync it up.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/avnet-ultra96-rev1.dts      | 2 +-
 arch/arm/dts/zynqmp-clk-ccf.dtsi         | 3 ++-
 arch/arm/dts/zynqmp-sck-kv-g-revA.dtso   | 3 ++-
 arch/arm/dts/zynqmp-sck-kv-g-revB.dtso   | 3 ++-
 arch/arm/dts/zynqmp-zc1254-revA.dts      | 2 +-
 arch/arm/dts/zynqmp-zc1751-xm015-dc1.dts | 3 ++-
 arch/arm/dts/zynqmp-zc1751-xm016-dc2.dts | 3 ++-
 arch/arm/dts/zynqmp-zcu102-rev1.0.dts    | 2 +-
 arch/arm/dts/zynqmp-zcu102-revA.dts      | 3 ++-
 arch/arm/dts/zynqmp-zcu102-revB.dts      | 3 ++-
 arch/arm/dts/zynqmp-zcu104-revA.dts      | 3 ++-
 arch/arm/dts/zynqmp-zcu104-revC.dts      | 5 +++--
 arch/arm/dts/zynqmp-zcu106-revA.dts      | 3 ++-
 arch/arm/dts/zynqmp-zcu111-revA.dts      | 3 ++-
 14 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/arch/arm/dts/avnet-ultra96-rev1.dts b/arch/arm/dts/avnet-ultra96-rev1.dts
index 96a6403efaf3..4c1bd69e7553 100644
--- a/arch/arm/dts/avnet-ultra96-rev1.dts
+++ b/arch/arm/dts/avnet-ultra96-rev1.dts
@@ -2,7 +2,7 @@
 /*
  * dts file for Avnet Ultra96 rev1
  *
- * (C) Copyright 2018 - 2020, Xilinx, Inc.
+ * (C) Copyright 2018, Xilinx, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  */
diff --git a/arch/arm/dts/zynqmp-clk-ccf.dtsi b/arch/arm/dts/zynqmp-clk-ccf.dtsi
index 9c0aa073dd94..4044b62d27a2 100644
--- a/arch/arm/dts/zynqmp-clk-ccf.dtsi
+++ b/arch/arm/dts/zynqmp-clk-ccf.dtsi
@@ -2,7 +2,8 @@
 /*
  * Clock specification for Xilinx ZynqMP
  *
- * (C) Copyright 2017 - 2021, Xilinx, Inc.
+ * (C) Copyright 2017 - 2022, Xilinx, Inc.
+ * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  */
diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
index 530bc9076d94..22e7d68d02b3 100644
--- a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
+++ b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
@@ -2,7 +2,8 @@
 /*
  * dts file for KV260 revA Carrier Card
  *
- * (C) Copyright 2020 - 2021, Xilinx, Inc.
+ * (C) Copyright 2020 - 2022, Xilinx, Inc.
+ * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
  *
  * SD level shifter:
  * "A" - A01 board un-modified (NXP)
diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
index 44738cef23be..eadc2563064b 100644
--- a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
+++ b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
@@ -2,7 +2,8 @@
 /*
  * dts file for KV260 revA Carrier Card
  *
- * (C) Copyright 2020 - 2021, Xilinx, Inc.
+ * (C) Copyright 2020 - 2022, Xilinx, Inc.
+ * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  */
diff --git a/arch/arm/dts/zynqmp-zc1254-revA.dts b/arch/arm/dts/zynqmp-zc1254-revA.dts
index c6a63201c1c4..cb9ef3746803 100644
--- a/arch/arm/dts/zynqmp-zc1254-revA.dts
+++ b/arch/arm/dts/zynqmp-zc1254-revA.dts
@@ -2,7 +2,7 @@
 /*
  * dts file for Xilinx ZynqMP ZC1254
  *
- * (C) Copyright 2015 - 2020, Xilinx, Inc.
+ * (C) Copyright 2015 - 2021, Xilinx, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  * Siva Durga Prasad Paladugu <siva.durga.prasad.paladugu@amd.com>
diff --git a/arch/arm/dts/zynqmp-zc1751-xm015-dc1.dts b/arch/arm/dts/zynqmp-zc1751-xm015-dc1.dts
index 5b592324021a..4fcb46605537 100644
--- a/arch/arm/dts/zynqmp-zc1751-xm015-dc1.dts
+++ b/arch/arm/dts/zynqmp-zc1751-xm015-dc1.dts
@@ -2,7 +2,8 @@
 /*
  * dts file for Xilinx ZynqMP zc1751-xm015-dc1
  *
- * (C) Copyright 2015 - 2021, Xilinx, Inc.
+ * (C) Copyright 2015 - 2022, Xilinx, Inc.
+ * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  */
diff --git a/arch/arm/dts/zynqmp-zc1751-xm016-dc2.dts b/arch/arm/dts/zynqmp-zc1751-xm016-dc2.dts
index 83648c2a1c54..23a3ff2fed98 100644
--- a/arch/arm/dts/zynqmp-zc1751-xm016-dc2.dts
+++ b/arch/arm/dts/zynqmp-zc1751-xm016-dc2.dts
@@ -2,7 +2,8 @@
 /*
  * dts file for Xilinx ZynqMP zc1751-xm016-dc2
  *
- * (C) Copyright 2015 - 2021, Xilinx, Inc.
+ * (C) Copyright 2015 - 2022, Xilinx, Inc.
+ * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  */
diff --git a/arch/arm/dts/zynqmp-zcu102-rev1.0.dts b/arch/arm/dts/zynqmp-zcu102-rev1.0.dts
index c0a4d913afea..c8f71a1aec89 100644
--- a/arch/arm/dts/zynqmp-zcu102-rev1.0.dts
+++ b/arch/arm/dts/zynqmp-zcu102-rev1.0.dts
@@ -2,7 +2,7 @@
 /*
  * dts file for Xilinx ZynqMP ZCU102 Rev1.0
  *
- * (C) Copyright 2016 - 2020, Xilinx, Inc.
+ * (C) Copyright 2016 - 2018, Xilinx, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  */
diff --git a/arch/arm/dts/zynqmp-zcu102-revA.dts b/arch/arm/dts/zynqmp-zcu102-revA.dts
index 0f7230b9526e..025e6519ea6a 100644
--- a/arch/arm/dts/zynqmp-zcu102-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu102-revA.dts
@@ -2,7 +2,8 @@
 /*
  * dts file for Xilinx ZynqMP ZCU102 RevA
  *
- * (C) Copyright 2015 - 2021, Xilinx, Inc.
+ * (C) Copyright 2015 - 2022, Xilinx, Inc.
+ * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  */
diff --git a/arch/arm/dts/zynqmp-zcu102-revB.dts b/arch/arm/dts/zynqmp-zcu102-revB.dts
index ce0a6e5f60a7..3c28130909bc 100644
--- a/arch/arm/dts/zynqmp-zcu102-revB.dts
+++ b/arch/arm/dts/zynqmp-zcu102-revB.dts
@@ -2,7 +2,8 @@
 /*
  * dts file for Xilinx ZynqMP ZCU102 RevB
  *
- * (C) Copyright 2016 - 2020, Xilinx, Inc.
+ * (C) Copyright 2016 - 2022, Xilinx, Inc.
+ * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  */
diff --git a/arch/arm/dts/zynqmp-zcu104-revA.dts b/arch/arm/dts/zynqmp-zcu104-revA.dts
index 90fbfca87f2b..cdfeea2fdd84 100644
--- a/arch/arm/dts/zynqmp-zcu104-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu104-revA.dts
@@ -2,7 +2,8 @@
 /*
  * dts file for Xilinx ZynqMP ZCU104
  *
- * (C) Copyright 2017 - 2021, Xilinx, Inc.
+ * (C) Copyright 2017 - 2022, Xilinx, Inc.
+ * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  */
diff --git a/arch/arm/dts/zynqmp-zcu104-revC.dts b/arch/arm/dts/zynqmp-zcu104-revC.dts
index 69470f8dede3..4b942acd4132 100644
--- a/arch/arm/dts/zynqmp-zcu104-revC.dts
+++ b/arch/arm/dts/zynqmp-zcu104-revC.dts
@@ -1,8 +1,9 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0
 /*
  * dts file for Xilinx ZynqMP ZCU104
  *
- * (C) Copyright 2017 - 2021, Xilinx, Inc.
+ * (C) Copyright 2017 - 2022, Xilinx, Inc.
+ * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  */
diff --git a/arch/arm/dts/zynqmp-zcu106-revA.dts b/arch/arm/dts/zynqmp-zcu106-revA.dts
index 4b8c69407ff6..776373d517b3 100644
--- a/arch/arm/dts/zynqmp-zcu106-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu106-revA.dts
@@ -2,7 +2,8 @@
 /*
  * dts file for Xilinx ZynqMP ZCU106
  *
- * (C) Copyright 2016 - 2021, Xilinx, Inc.
+ * (C) Copyright 2016 - 2022, Xilinx, Inc.
+ * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  */
diff --git a/arch/arm/dts/zynqmp-zcu111-revA.dts b/arch/arm/dts/zynqmp-zcu111-revA.dts
index c9ff99f8a830..62a8be9a537f 100644
--- a/arch/arm/dts/zynqmp-zcu111-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu111-revA.dts
@@ -2,7 +2,8 @@
 /*
  * dts file for Xilinx ZynqMP ZCU111
  *
- * (C) Copyright 2017 - 2021, Xilinx, Inc.
+ * (C) Copyright 2017 - 2022, Xilinx, Inc.
+ * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  */
-- 
2.36.1

