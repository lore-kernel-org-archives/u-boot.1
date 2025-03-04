Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46261C021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 04:30:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A597811B3;
	Tue,  4 Mar 2025 05:30:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0UxURMT+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3D4F8121A; Tue,  4 Mar 2025 05:30:48 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::606])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AA97810ED
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 05:30:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dqeuiz77yc+Q+tb8Ut6Agd8cl1HtN65amGej6sDwFFcnZBQuEy/UYaxhy32hxWubwzuog04+8iaUMGniIDr69/DXUN+XDGKi7jBzy9F6MPotnkmM1cK6blAGO1iHQWkPznJgAGzqDwxRi7ijCm6CFZZXhLQ3AADQh95XCo8xP4wWpF/gaJmAFFGYt9Hv7HSY/z+1INLjNJsg6oIfEpguZ2Zq1KZGVHvfPaZ4eT2X4q1aGQQjC/VpyQT7PbA2fFT7tavZHe35ZR7md1EShu++zth8UhWKx62Oc/wlX5/0sdPzdh1GwhPk9YIyDrOEvZ/6fBu47L2m5LJEOg2J53iwYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A8OJgscb8SdH/XQdzj4sphnhyfRRmHCquuliwi0fsAU=;
 b=jGsDMJnSiPatM+00K/u61Q1cJ0NNxglPb45oqVsN5Khq4erRSbZKc7nJ1vpjQPglURsQOZym78Sl75KEpLWrLA5EX0ebeRZlxTUNU/tnYtp7IdTaHMjo7l9oI6n4IxmMFeOyW1x+kB299fy0fdZXzKZOkb8zbgugwags5DmwDwMOgrX8PRgyGKBlLzMQiCBcg2IBPhAxIbEBYvqQ40+6us1nHbgv8vvLIUHSLgz3oHZNWucXonbt29nltM6pulvvzMMPnYrulR7Hytw6ZNZyOJ0LXSNYdJeltpHpOl3nKQl+r2j3sOEZS50vlDT08vV8w4FZgreiwCOqXCIGezDFSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8OJgscb8SdH/XQdzj4sphnhyfRRmHCquuliwi0fsAU=;
 b=0UxURMT+Dxh/Mr5XX7oV2cbwqEKFf6AUbq/Ul4wGkoJ1BzANbRPWKKY2d37aFgV6nfVeOrV0CR9hKyf+bokgd9vb2aWe9JHdS3pO+8O7clTNM7FzKjV8Boak5GPwkdjtwFJSPK+hhNhGjAPvSec5T4bMjf7HLhDrSdkzZkw+Z0k=
Received: from DM6PR12CA0016.namprd12.prod.outlook.com (2603:10b6:5:1c0::29)
 by CYYPR12MB8654.namprd12.prod.outlook.com (2603:10b6:930:c9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 04:30:43 +0000
Received: from DS3PEPF0000C381.namprd04.prod.outlook.com
 (2603:10b6:5:1c0:cafe::fe) by DM6PR12CA0016.outlook.office365.com
 (2603:10b6:5:1c0::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Tue,
 4 Mar 2025 04:30:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C381.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Tue, 4 Mar 2025 04:30:42 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Mar
 2025 22:30:40 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Mar
 2025 22:30:38 -0600
Received: from xhdkummari40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 3 Mar 2025 22:30:37 -0600
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>
Subject: [PATCH v2] xilinx: Remove tftp block size 4096
Date: Tue, 4 Mar 2025 10:00:30 +0530
Message-ID: <20250304043030.2344536-1-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: padmarao.begari@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C381:EE_|CYYPR12MB8654:EE_
X-MS-Office365-Filtering-Correlation-Id: 40f3cf7e-1ae5-43a1-0c49-08dd5ad55369
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?j6D/GInwOZmpWE4yK+6BIRUu4PuSQlCeQ68b+JzbJD9nhrwJJc2WgbNSfKjE?=
 =?us-ascii?Q?BXmdCGxZegzWbekwFroc1tJk2QgBDYJbtzmgZQ0vpXZBHkwclfbmsSbgTnMi?=
 =?us-ascii?Q?+4qjgFfDW1djjZL+3we7RWzf/gwO0g+1hM5ECe5U0Fwz9DCjF4RVCFwJR4oy?=
 =?us-ascii?Q?lzi8sd1EgrHeJYRT3VOyShdty/nN/UUy4TP9a2i7lnGZvWB4xeJFL4vbog9Y?=
 =?us-ascii?Q?OTGkAeiU+d8AAJkzOIRh0e62VfHap/2QRsdfN9DF4pLDHs1RKIBp31g9Avhi?=
 =?us-ascii?Q?fyDixqX56zjbHRhVIt7v1e04KGnLcCUwnP8r7MBFrfNIL0tq5KQA8WPysDiN?=
 =?us-ascii?Q?6mbenoqtCcqIEyzORdGlV3YiPmLCZX1bf1l44NoNtj73pgPO2oFyjXeRzCZZ?=
 =?us-ascii?Q?tC5b0jww6O8DsGZc7kOt2GFY6Gkqb63yZaFpHFRRFv0iLXBPwcvEOcLN/NYY?=
 =?us-ascii?Q?H2p/jWCH2inndnBCAcoyqeLhr352nTDgA2zy/oMiEzL2bCsdyGrBhwKMhIZA?=
 =?us-ascii?Q?YqWnJeXetoXykWva9z+nUjmbZArqvwpGRvZbo8eq/w7EuB0Mr16Ynj29fl3h?=
 =?us-ascii?Q?343IccbCdIs0ND9mg6D4p/t5uES3sfxTM5c0+89VHaXyYCURzG9MCavEUyaJ?=
 =?us-ascii?Q?xHReno/n6rNJH7uZPTL0LH25rcXD8+jpRR7p3bWBch/j9zNrTe+VbInM0JD7?=
 =?us-ascii?Q?loWXaY09R+eMhB4G73+lWdJy4GLEv2enIrIGzGQwcwqHbsLux5fTkXePZxW8?=
 =?us-ascii?Q?y18Ir9fpBz1P6YQbp5SOyVaRWeenFoc0lMCn6veoEwTa2fM3wqYk9vI9RTiD?=
 =?us-ascii?Q?Spa7N26TxjRhaUenFMRvb9mjmh8kWp10c1zdNk2JrlpyWZHVHHUwSMN35zac?=
 =?us-ascii?Q?rfaT8A78MIUrXf99h2n25Bm/yrWjaqA2V3uPWwVqW5YS2dcKTd2EILjjww3k?=
 =?us-ascii?Q?CwehWUOUGHJGOicCNu6VuXpLAcF5XWriuunRe4rd1Ybcjy3E8OuysUAzC+04?=
 =?us-ascii?Q?A8vqehM+cxperdfpHhjJp4JOwrUW2yrNINc5LMSWNgkXx3L6ugt0bkfBZhRC?=
 =?us-ascii?Q?QnfQcICBRSQqWr6IL32NS/1/NNGQGuFANc75vI8ITksdPiM/CvmzkRl887vb?=
 =?us-ascii?Q?NEGIvBg/3GRIelB5l7uFQ/zTAlmvJUXHv1vIyYTXyuAeu056oR6KKZzno6LO?=
 =?us-ascii?Q?cxaxsqOI6SlYgRLI6Ug+v8glo/mZV/f/J/ax/dYC7JATn8l02b3C3ucXmZCG?=
 =?us-ascii?Q?QbxNchdZq5ZNKqS9GNJfxX9eqUzLSd0HCdu2iaGpRlUCG9A8NkDkKcuQpVRV?=
 =?us-ascii?Q?S+HUdfDHMi2v5tItTgckwFYKlYXlsPKaWhezs9zch2YOGJ1xpe551RvXlB+h?=
 =?us-ascii?Q?jeghOhKClbaA73mo2sNtPkPymDlqhaowlSx7GIlqTp/VXJlI2KS8v2xerV/p?=
 =?us-ascii?Q?r3cO/zCqy1n0eI5bnCjJmqYVtcL+3ysBiqD0Fss0VSS3AYRAjUBhJuN8qLId?=
 =?us-ascii?Q?BOFv3QJctwQEyvA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 04:30:42.9311 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f3cf7e-1ae5-43a1-0c49-08dd5ad55369
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C381.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8654
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

The zynqmp gem driver support max MTU size 1536, so remove tftp
block size 4096 from defconfig and use default tftp block size.

Fixes: a33b4b96b3cf ("xilinx: Enable MBEDTLS/LWIP/WGET and WGET_HTTPS")
Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
Changes in v2:
- Add fixes in commit message
- Remove tftp block size for versal2
---
 configs/amd_versal2_virt_defconfig       | 1 -
 configs/xilinx_versal_net_virt_defconfig | 1 -
 configs/xilinx_versal_virt_defconfig     | 1 -
 3 files changed, 3 deletions(-)

diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
index 8bee002777..9911caa0e4 100644
--- a/configs/amd_versal2_virt_defconfig
+++ b/configs/amd_versal2_virt_defconfig
@@ -70,7 +70,6 @@ CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_LWIP=y
 CONFIG_NET_RANDOM_ETHADDR=y
-CONFIG_TFTP_BLOCKSIZE=4096
 CONFIG_SIMPLE_PM_BUS=y
 CONFIG_CLK_CCF=y
 CONFIG_CLK_SCMI=y
diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_versal_net_virt_defconfig
index 5ef5fd44fd..1604b5915d 100644
--- a/configs/xilinx_versal_net_virt_defconfig
+++ b/configs/xilinx_versal_net_virt_defconfig
@@ -70,7 +70,6 @@ CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_LWIP=y
 CONFIG_NET_RANDOM_ETHADDR=y
-CONFIG_TFTP_BLOCKSIZE=4096
 CONFIG_SIMPLE_PM_BUS=y
 CONFIG_CLK_VERSAL=y
 CONFIG_DFU_RAM=y
diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
index f228eef7c9..baa4b8e412 100644
--- a/configs/xilinx_versal_virt_defconfig
+++ b/configs/xilinx_versal_virt_defconfig
@@ -74,7 +74,6 @@ CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_LWIP=y
 CONFIG_NET_RANDOM_ETHADDR=y
-CONFIG_TFTP_BLOCKSIZE=4096
 CONFIG_SIMPLE_PM_BUS=y
 CONFIG_CLK_VERSAL=y
 CONFIG_DFU_TIMEOUT=y
-- 
2.25.1

