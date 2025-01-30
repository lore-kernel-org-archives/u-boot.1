Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8184AC0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 08:08:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE3C680C99;
	Thu, 30 Jan 2025 09:08:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uF1y63CD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD04C80C85; Thu, 30 Jan 2025 09:08:48 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::62d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DFB780AE2
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 09:08:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BjIIPCgSnEwqOJwSXYL61bRhTj+7EyKPguOV1C7YMRaIuFlSsAfe27+Hds674QTdxR56lNPeOxRL6+pBxN0sV/f5xS8kQVWsyL0qAwcIrdYkxTH21WrMD+0v99zGsl2uDY9jgH+tAwi5RdcSufMn6toN1LYbYMllPe02oC6X70YIbbwElcrIlHLVFB+LFA+Oqd/Wztu4Ye0H8vITxL6Q2Dr1BwlGyA0FgA3ilBzCAM/pC+tSdruhXqch+lPPoOKhy9CMGE0kyOiyAaeQRQjnk9K1k57MVlueEqaXCFIFvH6yBNhvXWHmmRyMRaQ6bAXJT0Yp83lzL2nNnefM8qxJlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u6SgkbIM2xJnlXBE7TvDC/bKMBhOUEVfFsRENLSVv3Q=;
 b=qZ3R2CDKqFi3M5ZPfmbggsGvzYcQwa3GI8/zMvEBn3T/kqqkg5+1XBSm42BeLFR8RdozSJwHg/bysbIKylFr2bG63WFJdkE/kGJZJOztbgul2AI0I/wGj7HSGZJ9lGKsQZBmdbBr3hMz1mw0zDwS0/B0rTAzw1MwnQAv2GFbS362bBgP8AzPfR1UhFJEBaTYfHvwV2t5kEO1rA+nsetnxHKLWa684zZUKMufFO4DK6qEIgJVelm3r4roU2rnj1Orrvv83MsyyoEVMNF59qPy1EHKxyoDcmEZxQ/Ez/volP+eKLeqUphe7E++9dkPaPMJ9QayWuS+cflE+W2MlfNikA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6SgkbIM2xJnlXBE7TvDC/bKMBhOUEVfFsRENLSVv3Q=;
 b=uF1y63CD1ygtGAVzQND7hb880Ikpa9Px4f/uTthhkrIGoz3VHoD2VBPixo1DDSaTIsjd0/t53slcEB1Td/Nle+qdF1Labo2G44XEClaQ9Skqm7BxWBETpAfv5VR7c8lq8ZwPRy7JVxAgsTCEZqCZ/2AynpX3xn7tIwkrJtqoKtw=
Received: from BL0PR02CA0008.namprd02.prod.outlook.com (2603:10b6:207:3c::21)
 by BY5PR12MB4081.namprd12.prod.outlook.com (2603:10b6:a03:20e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Thu, 30 Jan
 2025 08:08:41 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:207:3c:cafe::e2) by BL0PR02CA0008.outlook.office365.com
 (2603:10b6:207:3c::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.20 via Frontend Transport; Thu,
 30 Jan 2025 08:08:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Thu, 30 Jan 2025 08:08:41 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 30 Jan
 2025 02:08:37 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/3] arm64: zynqmp: Update binman configurations
Date: Thu, 30 Jan 2025 09:08:28 +0100
Message-ID: <cover.1738224505.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=710; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=m1tZCAHAgfeGqY1x/EZLNDOgbm192PnufL7nq2R75QI=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhvTZxrU/5i7eMP0Kc1DulNK458mlTUte5d7UiSg9JMT87
 9Zxx1SDjlgWBkEmBlkxRRZpmytn9lbOmCJ88bAczBxWJpAhDFycAjARvkCG+U4pp+aXMQmJFvvY
 h6d1Xbz1c+IOQYb57ndNZjhrrlNPeZS6/xebqNnHa9I3AA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|BY5PR12MB4081:EE_
X-MS-Office365-Filtering-Correlation-Id: c4e76e7a-430d-43a9-0ec1-08dd41054eea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wJc05jPSn64qQ/5Wt4N1rRf+zxbUNqsIPg7Xjql+6u2YGhvkzDJcnStFlXzK?=
 =?us-ascii?Q?6p8WecRe/j+GWbK1HA2Tx26so6nar1HhpNPyBAwkDKL8l7rK/9IZ9k7iIWPi?=
 =?us-ascii?Q?AXii1x58qe8OOgV3mAvka6jfjNpjUIhfK3D+uJFt3MSj58UBb4I7+uIhVzvC?=
 =?us-ascii?Q?x2SJP9L3eQOolxWgQdHh9FYYQML9Vj1N1aJLlec6sdB5Dxxzc7DyPBDtpHKm?=
 =?us-ascii?Q?MhH499t1ed/jTnamrCFuVyhecuL4m6sJSvuWYbyCwMRJ9ElXWWWOVwPt3vT7?=
 =?us-ascii?Q?OJcc6j0hJqhfJ0LlDNBgSx3XShBCgrLW6tDd1+e8acLD2o8R9ReNqrJRsWOl?=
 =?us-ascii?Q?Vt43Yt/0zi0YQo4ILs3CUn3UVO89hke1u8ztF2TrOQ5DHmGVSXDcBnZt7Qe3?=
 =?us-ascii?Q?kGOsQPl8TBZp0Dsa/6B+1RFh8zftzrTz5mw7b7YrOZ2Q5s3aF+ezIBcUnc7j?=
 =?us-ascii?Q?VLagVc/WqrZNcGnfXMG+Ggwuw0Fkx1sSZ6nXMip5/DYLas4M6b0sfH09wACQ?=
 =?us-ascii?Q?P2Yrrc+TpNWQMVZMsTmL7XjCTD/FEd9xdRqrWhrzDt+uF9zjCErNqHIpJywl?=
 =?us-ascii?Q?N6ci+D9n88gHc1Zj0+rGCbWB2gBbYxEQRohCzVNVQP4uxoichRYMU9ONRMu6?=
 =?us-ascii?Q?KWEWvRUATlphOymfkt68ieZc9Zb7L0rwEimRaDPyZ9LnUPk3NSVkA9I7p9OR?=
 =?us-ascii?Q?NDJotOkObn7f7e8kUl/9FRkiR47t8P/UzoHyoTFsLCqDrzU6I3kYAvbv938l?=
 =?us-ascii?Q?Y3ktUTl8OoB47D69gBTHRZygtFnqiN0xb5Hv+LlMBsFHCpKOV9lXThhQPf80?=
 =?us-ascii?Q?M7ipuGnUKtrKOuwnsp4SivqjFQlH5sMZ5XoJRFyBVVq1yACCM7MEiqctyTAG?=
 =?us-ascii?Q?hA9hHAHU6k6B3mkCR2KR7S1T7mxcgMDIRGrthUQn9s9KhUFAGo4yY7RXkLF2?=
 =?us-ascii?Q?EbYLY5PBsoiNxgXA6jbXjBQYLxsc8j1L1qblS7JT9vDvdkwFyg+nAZIg2ya2?=
 =?us-ascii?Q?BwqND7S04rBpPJCc0rdCJRc6HS/QR1TUK5sTvkZFbEmABwppkomTfQvRXMg3?=
 =?us-ascii?Q?GEvLgtqCnm31mEQsNcRRu4YSc0SnLUY/Sg5F0AoVVKKPasa++R1qXGQwmNay?=
 =?us-ascii?Q?RItp3W+kqog0hsbFq8QhqmiUYAZR8MmiaXPEYEaZNIpwxDglVo2eRvwczBWs?=
 =?us-ascii?Q?0+mi7QTjIoIkkeeoKniV8qFSwMcBMLuZE5eawGi2IkzrbQZ2jnVVnikkBcec?=
 =?us-ascii?Q?WPCzFUHPbKgZVJNgHSeisx74r/JkdHOA6kmxFr4uSZL6EOeDPkKZiy4G+MxK?=
 =?us-ascii?Q?k6grSndofpJMMnUDkWnGBn13jIWX1ffWJra6sZWwxWE//K0Ii7+R4O7+ncOz?=
 =?us-ascii?Q?j82EOJVCwnRTeQTV4C4wOEnVQvuEpk7vCnwM8J33JMaF4X72Oc3twV2Le3TK?=
 =?us-ascii?Q?KtOIbwbHe/tY0Lz49VOPJ3mgGtOvx/8cEMrh7kDzFPGSwkB2C7t717KTQ7ME?=
 =?us-ascii?Q?3sEG2fI82XjU+IY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 08:08:41.0457 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4e76e7a-430d-43a9-0ec1-08dd41054eea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4081
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

I wanted to test u-boot running out of EL3 which worked before and there
are some small chagnes needed. At the same time I found that TEE
configuration is not using proper load address because it wasn't tested.
And also DTB location can be taken directly from .config value as is done
for other values.

Thanks,
Michal


Michal Simek (3):
  arm64: zynqmp: Fix TEE loading address and add hash
  arm64: zynqmp: Use DTB address base from .config
  arm64: zynqmp: Describe images without TF-A

 arch/arm/dts/zynqmp-binman-som.dts | 14 ++++++++++---
 arch/arm/dts/zynqmp-binman.dts     | 33 ++++++++++++++++++++----------
 2 files changed, 33 insertions(+), 14 deletions(-)

-- 
2.43.0

