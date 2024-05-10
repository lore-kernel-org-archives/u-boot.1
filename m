Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B223C25B10
	for <u-boot@archiver.kernel.org>; Fri, 10 May 2024 06:22:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABF0188287;
	Fri, 10 May 2024 08:22:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rzJz9ym1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E89C8825B; Fri, 10 May 2024 08:22:49 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EBF988287
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 08:22:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G31iEfWeQ1699IbVmcOUwPVOBgybMZcSbfneLOZrBMg78bGD5l8G/NmFw8boU5M4tAfX5FZ581Q4C1DZGOpWpWOhDH2xbfvcPqqnirUUQf8VaSjuE5PuPXJB3wi2fZcPH6LqEZD+xXIc55nf+vWeeRmSJ+/2RW8UC/aA9/vRFi5c8hmtxTdqcXkYXLR2k9bHRLWBrfay8L9ylfGGbzyR1md1XO8W/sL3znn7aj82e90PK9kGCDylHUx5hkg4cGlDAOBV1THJRYw5q423OB55LuScHRthS6F7FdBuTSd5VNZPZsKwhCIPVyvyUATEc1LZBvUKljJuzp+E01trGD/Eiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rztkJbMOZsKlJyljB/Z4zZcbcYCah9jernMAOjSfp8I=;
 b=DTd/JXihLWKgCWEa/1pvG/YzeaIez3GUhGGZLd+9gLWOIDuFSHkE23O2hrrp/pdyZ3gjzQUIgukrJVpe//tjLn/+e0vrNi45uV+NgjhW1WNvqcm1HOmT+squGU55tCwadN80iHn9IHma9u69PTPalzOZW+b8Aqs2N+0l8UvQFs08PkBiioakVVgcfiE+PbD/g7EQjINNqx7Cc0SoZ4Pp5wwIkQv1PUGBXy8+OZkTVMFcAWsi8Yp9lw3sPpY02vebu9bDYf2oh7wt/ToJq7Yp/Vxq4RMwLJLS5yMmBPb+7/7+/bL5RqWiRNj0ptbZrjpuMZj+X54nMLbMwsGnCb6OUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rztkJbMOZsKlJyljB/Z4zZcbcYCah9jernMAOjSfp8I=;
 b=rzJz9ym1L5idreQec6aS0SOP+EQGTl5Gt1HFm1YFTmUT4HW1RiKxgTD9nK+pqTcHUdIabMTLveFhX7m0QNNtVDn+c5Oj8tie2KgVqPXGvd9MSVmVScNNPHePSfz9qCWUfHTxv5qyUQGXrjyY6gtmPhc5NM76xWJCe8A3XHcfrKg=
Received: from SN6PR16CA0055.namprd16.prod.outlook.com (2603:10b6:805:ca::32)
 by DS0PR12MB8342.namprd12.prod.outlook.com (2603:10b6:8:f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Fri, 10 May
 2024 06:22:43 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:805:ca:cafe::89) by SN6PR16CA0055.outlook.office365.com
 (2603:10b6:805:ca::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.48 via Frontend
 Transport; Fri, 10 May 2024 06:22:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Fri, 10 May 2024 06:22:43 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 10 May
 2024 01:22:41 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, "Polak, Leszek"
 <LPolak@arri.de>, Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] xilinx: versal: Do not prioritize boot device if driver is
 not enabled
Date: Fri, 10 May 2024 08:22:38 +0200
Message-ID: <8b7cca5c7b84cb4854104e0c48f8aa63c4ec5ace.1715322156.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1802; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=yw4zKlq5N86teVxmlM//XGOo8uf32pBdVaVAJuaTPQk=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhjTbvfrhq5x/vftQNCGw2nHV3d/7Zqpf0b4yuei3T6jPq
 14Go5X9HbEsDIJMDLJiiizSNlfO7K2cMUX44mE5mDmsTCBDGLg4BWAinw4yzNN9suqcTILxgkMr
 i0/s4a4MPvr6VCfDgrkvZqydrsZ6KVTkOo+nyzLxtPgP/wE=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|DS0PR12MB8342:EE_
X-MS-Office365-Filtering-Correlation-Id: f1084c33-5856-4776-f8ad-08dc70b999ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Id+0KnO155n8agsHsDjSsEcJ8l+J6OQFZ3uhI/97UH+5TDSqIDzU9xL21t5B?=
 =?us-ascii?Q?/Yt60To4hynb1aw59zmYsvCl9rKNL9tgz/4BYmK3NdJpUz/j7qSvYS9VpyRi?=
 =?us-ascii?Q?i/AEPWg77JqUH1G/9/pDkzPjBUSz43zOwTUJVCwWkFY3lvSYuOWEUYwZ7n/R?=
 =?us-ascii?Q?aL90T0a8c39WcJhlMr36wjL+rqAR8/wHBIPWjtGOo1AcsdIY9kPWoYqy8oIG?=
 =?us-ascii?Q?kSnzTILh8QeaE1gzwg9qnlqd2daLHCmRtnoPQxaQadq0LlkImXftBkQupvBi?=
 =?us-ascii?Q?ZLDYZeQt1pKLangRzTwEfPUaCIhEg8dp5fSQfKo2PC9MNqFl5+x0Z05z0k8u?=
 =?us-ascii?Q?wYcq62cyz+GtDK+UhH+Vy51AcABH1ijodsre8SexWfwA3n46G/gI4ftfrUn4?=
 =?us-ascii?Q?SKoJM6WxuVdGKpEgEpkO69f2B15gnpqbynlZw4NPQaAMszII9p2rV3bf2Raa?=
 =?us-ascii?Q?RIqJ1NTFFvRD88F0aZ9NgxeS49pH2Ad0tOb4NYkQ69qcZe+QFduVSSSFhgT0?=
 =?us-ascii?Q?KlV9aXDODLCRrKpWiJGVa1tzsu3tx2OlIqNlTkba3aLlYpzjLUbAz4UaTisw?=
 =?us-ascii?Q?HogU5SkEJ6pTWk64kjI6NmCistTmPZMequ9ZsEsGVqFu5I4L2UKV4TuDnK3C?=
 =?us-ascii?Q?RECFS4s//i8Ut1RYMBO+OGU/+Wd4LvNcKny0scx9xwzwx3pCjAV6ye/b6XhJ?=
 =?us-ascii?Q?LU5FyeUEFke9EDo53F8HJ1mbRwg/35AxkCzfGN6H7NrcVBbqE/GvtXSe6jF5?=
 =?us-ascii?Q?Ctvpg1ucVbbxPv32osrP3f0Gc/MFabdW32iWcEfHK6Qm0fCnVI3HMl2cc/PY?=
 =?us-ascii?Q?azqszzH59p/GNGPag8JuaJrCl5NsXGl6SgIEc66HsRbzjAqbSBo1TJR+ETBo?=
 =?us-ascii?Q?KyczdSo/sYLqVPYLZFgxWV09ISCkGiRjqgA85TBW9qdgeUwgrl3N8gY3ti8J?=
 =?us-ascii?Q?uzNFzNP6WcYUHGdp9R/W3l9/CR2QEB1aXySKGrI4aTS2Q2aPSScEAoYoIkyk?=
 =?us-ascii?Q?d4AlJoX+w3TnZqoEaYhe1Z6MPu3HmM91Jw23Tiyx/zvznVacrEQ1Ja8pYLZn?=
 =?us-ascii?Q?TCUagkztgFwikcp26FOhflZxGzZs1AQztFHToJ+Jkft1KEhtIUaZCwlAnoAe?=
 =?us-ascii?Q?VJsETl1KClydNBzFA+1Ej0rKd2XUP62it4rFa8YiThWSxfxqUbPVFcRfO9Yx?=
 =?us-ascii?Q?Kehw1QaLOcI6HwGNzfskgSqdLaTV8UKzW7qRcnA9+VL6O8hvafNOAw/8aC6p?=
 =?us-ascii?Q?QdYlxVi6L8WRTC40GDyzNe1U7Bm7b5kMpkAw5VmD2Msv5qYIsbUmlvtX9GlK?=
 =?us-ascii?Q?hQtBOhB6owXHBfQFupT7xROz06g/9TQGK03Mj4MnLp1KbcpDvmerxQBHTfwO?=
 =?us-ascii?Q?YMXh6rwNarEgxtKa1azu3DYH1Pqk?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 06:22:43.3936 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1084c33-5856-4776-f8ad-08dc70b999ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8342
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

From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>

SOC can boot out of the device which is not accessible from APU and running
this is detected as a warning, as the device is not accessible.For example
getting below warning when the boot mode is OSPI and OSPI is not enabled in
device tree.
Invalid bus 0 (err=-19)
Failed to initialize SPI flash at 0:0 (error -19)

Ignoring the prioritization of the boot device which driver is not enabled
and continue with the default boot_targets. Recommendation is to use custom
boot_targets via environment file as is done for example for Kria via
zynqmp_kria.env file.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 board/xilinx/versal/board.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/board/xilinx/versal/board.c b/board/xilinx/versal/board.c
index 4f6d56119db1..f00605da7825 100644
--- a/board/xilinx/versal/board.c
+++ b/board/xilinx/versal/board.c
@@ -151,14 +151,29 @@ static int boot_targets_setup(void)
 		break;
 	case QSPI_MODE_24BIT:
 		puts("QSPI_MODE_24\n");
+		if (uclass_get_device_by_name(UCLASS_SPI,
+					      "spi@f1030000", &dev)) {
+			debug("QSPI driver for QSPI device is not present\n");
+			break;
+		}
 		mode = "xspi0";
 		break;
 	case QSPI_MODE_32BIT:
 		puts("QSPI_MODE_32\n");
+		if (uclass_get_device_by_name(UCLASS_SPI,
+					      "spi@f1030000", &dev)) {
+			debug("QSPI driver for QSPI device is not present\n");
+			break;
+		}
 		mode = "xspi0";
 		break;
 	case OSPI_MODE:
 		puts("OSPI_MODE\n");
+		if (uclass_get_device_by_name(UCLASS_SPI,
+					      "spi@f1010000", &dev)) {
+			debug("OSPI driver for OSPI device is not present\n");
+			break;
+		}
 		mode = "xspi0";
 		break;
 	case EMMC_MODE:
-- 
2.44.0

