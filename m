Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0217CD5BAE
	for <u-boot@archiver.kernel.org>; Thu,  5 Sep 2024 11:59:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01E7188C88;
	Thu,  5 Sep 2024 13:59:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xggkihcL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EA6988C97; Thu,  5 Sep 2024 13:59:06 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::606])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A577F88C87
 for <u-boot@lists.denx.de>; Thu,  5 Sep 2024 13:59:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Prasad.Kummari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uE/09ZyO8fLQRlgGbkb+igmxFBQyRCa31+iKw3iwn6ovtoOiPEQZI7BNJxJU2+WRZurPKihf5BVWBbfMI87X4BNbm3PormTQ+XAxipeT69V4X0xsVC0j0ikQJSwpzRJ0coQihjivpcEXliuZ1H7/dG633ORiGlxV4eF8IpQ4f8XfoQasa+YnCHKee4gOcvF43G/o6vuM43Ici+5w9u4TAdlQWg0Obu6e17FQMBNGAQ61/r6qITRqku67zK/yOd2/T/IhkYyl2cDbPZIVbnfdePfk/LU5qcvJTLz6QX8Bh1QNBkL82jRvWV14Axns6EVD6u+UL26xGICHWYDgFZxbDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tHPotmo893HNjp3I9M5DzkA2wWo1pwrs1x05qJW72W8=;
 b=dhrDh/fG8Q3LY97oI6fEes3iMvVyp8K+nVv3CXYsXbRmSFysf9rjkBMbhBTY1YbZNWct3nsJ5pd9k9iMgQhvzMX7qZ4hKhOa/rdQxVm9ghzbXvC9baX7zqc3bKSFacbaLHdw8eUn4gPpjgBN4sF+4MFHWuNEbhRcHf/bb9SukwGehcTODMyoac3XtAr8nV1c6NKy0fI2VetUjPH7lZ/hAQsGLXTddm1Rvj+ovK+xaJ37otACzqS3dTlwC5FpSFjXA6OarBladQSxiITEYgaANUn0kK0MF7VGBAjWKcRiXzYUrk8Tupo8ICJbWG7E6GSP0EpFMWUbJVCqgQ5rYGpNzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tHPotmo893HNjp3I9M5DzkA2wWo1pwrs1x05qJW72W8=;
 b=xggkihcLlPhr4BdsDIAc+u30JNmTr1xxvAm9nbfAw49LtP9q2I26mYdCx5iTJXSgedYG094XACHqQgh1hWgtkEk7330JcxrX+CORG/LYUPKXq/rKnoXB1x/kxxWgy4w2vVFWRlNcSfIlizQYNQguEj3QQeWBXmTQdYQDf3imw5I=
Received: from CH0PR03CA0185.namprd03.prod.outlook.com (2603:10b6:610:e4::10)
 by PH7PR12MB5688.namprd12.prod.outlook.com (2603:10b6:510:130::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 11:58:58 +0000
Received: from DS3PEPF000099D3.namprd04.prod.outlook.com
 (2603:10b6:610:e4:cafe::31) by CH0PR03CA0185.outlook.office365.com
 (2603:10b6:610:e4::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Thu, 5 Sep 2024 11:58:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D3.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 5 Sep 2024 11:58:57 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Sep
 2024 06:58:56 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 5 Sep 2024 06:58:54 -0500
From: Prasad Kummari <prasad.kummari@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>,
 <padmarao.begari@amd.com>, <git@xilinx.com>, <jagan@amarulasolutions.com>,
 <n-francis@ti.com>, <d-gole@ti.com>, Prasad Kummari <prasad.kummari@amd.com>
Subject: [PATCH] xilinx: versal-net: fix no previous prototype for function
 warning.
Date: Thu, 5 Sep 2024 17:27:59 +0530
Message-ID: <20240905115758.999936-1-prasad.kummari@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: prasad.kummari@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D3:EE_|PH7PR12MB5688:EE_
X-MS-Office365-Filtering-Correlation-Id: ccbaa514-9e7e-4b20-858a-08dccda21fb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hRS1Y0P3r9K2njchepwCCegdxR5INSkwTxf5AtxO2P8ql8naL0L0r/IBiP4H?=
 =?us-ascii?Q?opYu1Nu1b5+/KuC4BU8wfdtzNNsqRfcppFv9Z4kf/+TWyPMpbOMqxLY8kyP+?=
 =?us-ascii?Q?fSJvFXZVT9KMsK3x4AShv2+WCQTnfpjS/517On6iHB3KfodOCtarGgiIRwCL?=
 =?us-ascii?Q?F404FQSd2KBs4TGi22rrnLmecQqfiRNKWPS/m1r0NdekbfS9ZheI7d/XzeTF?=
 =?us-ascii?Q?NY+p1HH276xFuJqb6DTiq+0u0hnRzIVdnu8eQ8trEsvLiIbvGIbdwjCwZRx8?=
 =?us-ascii?Q?GAQAPla+J+aIruvYzkborQUJjlpFpCuQ9hNdtF0r75ST6sq5KrSb778zzqJP?=
 =?us-ascii?Q?zxUGRSwCtKVrDv34pJx0jTylDWYnUS7sAiZS5H3V5oBowFzzQzdEAtTUoKNE?=
 =?us-ascii?Q?iGb19v+jw2GpDtJs7Pmxd67Cw4wxiVF1fUUZnQ984puxYTiT0J5o77va/Wcy?=
 =?us-ascii?Q?7tuQeW0pZh1vt9G2qJPlSMOGTdsiHfDrrc0zCNyLXyv5M9Ta1yKTezWTPxvN?=
 =?us-ascii?Q?YsrAuva24q/HR+nRYTfTydyrJa2vHptabCJPhEzjhsMXeQkQsrcNLC4twBDU?=
 =?us-ascii?Q?xMvXplWUWOY0WF6FF+/S8A3BcK0ROY76CMEZ/eWPm/UxwX0VRSi/P/5LTWWQ?=
 =?us-ascii?Q?TBJKR+jzJM8T6L567qNczeeHKDzp0ghLBWcDwKq6j/q+U/ljrofEqzP8fRlZ?=
 =?us-ascii?Q?9eBXXawtyWdAzWQXfHFmieTzB7/QswwDX0RFE6a/4Z7DT2f/iQ6u8BiGVVhG?=
 =?us-ascii?Q?dP4Yk3aEuutUiDP1eQ7VjL4MhCd322wlbpchAyr/eylgJraJUdZwKRrjayN/?=
 =?us-ascii?Q?moC8ulLQhERVVG6RYcIEija+pfg9VmUBFnqRSt0z5iaV8hv0SOJ7ixGZlHmW?=
 =?us-ascii?Q?aHQeXYLQwxZkzbkVbr0JrpU6XnPuCCiJpRjo3s7gLTOH5gaPYbIJUFxJ591L?=
 =?us-ascii?Q?+4RLfUatUUUy7fZqk0NhthASMeMeovDsp52R7yGlHKX1ZuOxaZuf0ikkwdI8?=
 =?us-ascii?Q?aXgmx0qullsS7619FIrrzpNuyulLCB3VRtmSc7wePZ9XcSO17ABPngGY97bf?=
 =?us-ascii?Q?s2fmkFy+a8KGbZy8hUnfVKIKZ7F+nm5HKdVHgKIgYoKpoQ3uRVcKKVqS0DsF?=
 =?us-ascii?Q?yjUajZgYPvQv9kLMc3zGu5XoIAaO33CfsHyJF8JQIb8JSWrgOZYdhaQUnz70?=
 =?us-ascii?Q?1cc64yumAR/P3g425wKdVF+PBI1q3YOl7yjhE2UQP5R5/bpQhRqhzInrvYv2?=
 =?us-ascii?Q?8GOCygqCPzZvmDw53AywSnwLbYF77BWvJogw+CHUMJc6sl5lbgP2p8ffwuJr?=
 =?us-ascii?Q?xleTHhQERl1LGnmKT8GM5utig5SLO3MuC0dwESnu2ICvo7ZZXWSxqXCu2fBh?=
 =?us-ascii?Q?XZZq/nxGkvMYjwFA3kFwZ9XJSjQRdzfRyxaIls2KCFVsEnLKsi0M7RwQ1XRj?=
 =?us-ascii?Q?JQPGEADWj0FPoKTVR4tVucT1J1fTAXiw?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 11:58:57.8994 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccbaa514-9e7e-4b20-858a-08dccda21fb4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5688
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

Included the SPI header to resolve the no previous prototypes
for function. Removed unused mode variable.
sparse warnings
warning: no previous prototype for 'spi_get_env_dev'
[-Wmissing-prototypes]
warning: variable 'mode' set but not used
[-Wunused-but-set-variable]

Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
---
 board/xilinx/versal-net/board.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/board/xilinx/versal-net/board.c b/board/xilinx/versal-net/board.c
index 1d67e3f318..4d5913cff1 100644
--- a/board/xilinx/versal-net/board.c
+++ b/board/xilinx/versal-net/board.c
@@ -12,6 +12,7 @@
 #include <env_internal.h>
 #include <log.h>
 #include <malloc.h>
+#include <spi.h>
 #include <time.h>
 #include <asm/cache.h>
 #include <asm/global_data.h>
@@ -196,7 +197,6 @@ static u8 versal_net_get_bootmode(void)
 int spi_get_env_dev(void)
 {
 	struct udevice *dev;
-	const char *mode = NULL;
 	int bootseq = -1;
 
 	switch (versal_net_get_bootmode()) {
@@ -207,7 +207,6 @@ int spi_get_env_dev(void)
 			debug("QSPI driver for QSPI device is not present\n");
 			break;
 		}
-		mode = "xspi";
 		bootseq = dev_seq(dev);
 		break;
 	case QSPI_MODE_32BIT:
@@ -217,7 +216,6 @@ int spi_get_env_dev(void)
 			debug("QSPI driver for QSPI device is not present\n");
 			break;
 		}
-		mode = "xspi";
 		bootseq = dev_seq(dev);
 		break;
 	case OSPI_MODE:
@@ -227,7 +225,6 @@ int spi_get_env_dev(void)
 			debug("OSPI driver for OSPI device is not present\n");
 			break;
 		}
-		mode = "xspi";
 		bootseq = dev_seq(dev);
 		break;
 	default:
-- 
2.25.1

