Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 153D3D10F24
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 18:15:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A2D1839DF;
	Wed, 26 Nov 2025 19:15:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LaMclJk+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32D6783A3B; Wed, 26 Nov 2025 19:15:58 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB778839DD
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 19:15:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PxfYVShV8wcMISzdm6/H19UKAWGfHc/8Ls8nf/SiY8QhU1VxYbtUB26NDKLR6UIFxzni2KZXALYMj7kLEkqAUQuy5N3hjdXbdJhqzIdPcTh5YvkJ3JaVNs0Tb1DqxciM3+LQWuPZ5YxL+qL9sS14P0uF3rpKsEbGxbXyNIHmhZPaqCvy8prhC8uoVw7GSRybseQoEY0cHI+a5s060+VHGRrjLRtif7H66pc+ScfBjhkSxg/zg9CsCI8YcHqHBqXaRdP/VDZBpBNTVBZ+4kBv5eAZLeICUndLn5b8HkIGGKYXNDrIGHTkt+Vmtol+NkK9buYKOS+/wPgGBMws65hQFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fdqavrYJO8diem3i3fU3lReDnmotH/p9vOcu5/kHKWo=;
 b=nRaDNPxdQXk5+HiSkys1Eu4WH+JyePCj9vidCE7fEsnbxS8xeCf04e3KAqDaZaXy1DKSze8+MB9wpF1SUjCbyxRKDTwaFd+W2DVd+4hFAxyyTZfWXq7bAnHu4Tdnu/Ol2tXCRx0J1eJg034NubTwwDoK8r5FvClMeold4DuZP9b13UjGZTaw6xlxam0511ZR0o81MTv+4Y/XqZN+QnayuQQFNlZegdV3tEMdtc/bA7rSjM/FPwcyvm9RwHtdfU/sx8n0u2FRfESMUmpfnzqc4SWEbMBhsWVCe1lUmhGpJ4YLwpqPDGqu5J2wxl5zr5cXKfCLTLY6rDtldo75Y3c2Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdqavrYJO8diem3i3fU3lReDnmotH/p9vOcu5/kHKWo=;
 b=LaMclJk+5l8/qz4tJKFqcYCn9W2LvtJ6ZYb/mSW1A3/xrExoUG6wOSlav13JJvwAFFqH0JORbz7w3x6qET2PghJYMpBDYeV4FDQhc1uS8Q6yeWVlY8ndovlHjIHbuGSInm9CvpqH5wB6XvJ2D4B6R9vzXj6VOqmwXn+F86FR41w=
Received: from DM6PR03CA0018.namprd03.prod.outlook.com (2603:10b6:5:40::31) by
 CH3PR12MB9454.namprd12.prod.outlook.com (2603:10b6:610:1c7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 18:15:45 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:5:40:cafe::77) by DM6PR03CA0018.outlook.office365.com
 (2603:10b6:5:40::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.13 via Frontend Transport; Wed,
 26 Nov 2025 18:15:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 18:15:44 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 26 Nov
 2025 12:15:43 -0600
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 26 Nov 2025 10:15:43 -0800
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>, Tom Rini <trini@konsulko.com>
CC: Andrew Goodbody <andrew.goodbody@linaro.org>, Boon Khai Ng
 <boon.khai.ng@altera.com>, Jagan Teki <jagan@amarulasolutions.com>, "Naman
 Trivedi" <naman.trivedimanojbhai@amd.com>, Senthil Nathan Thangaraj
 <senthilnathan.thangaraj@amd.com>, Tien Fong Chee
 <tien.fong.chee@altera.com>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>
Subject: [PATCH] cadence_qspi: Remove duplicated return
Date: Wed, 26 Nov 2025 19:15:39 +0100
Message-ID: <5f6d6db9c301daf10ddb707a9031f1a467d6ebf1.1764180937.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=857; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=ii5w4QdrmLiJSKMM8vyC0xdZutRYEgspc6xChjVLCRs=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWSqO5/5Vnht97zEg4mqeXlfG1/dPsIwUWG31+aSv+yTn
 SL8vJmzOkpZGMQ4GGTFFFmmM+k4rPl2banY8sh8mDmsTCBDGLg4BWAil+sZGV7Izvuj98ayRjpr
 u5VnWIPApqshd1U+1Ny5uOrR7IhjX6MYGVZu4vwTfmve2xX5DyZNkl+4RtazZ/re1ALm++/aMpd
 qabMDAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|CH3PR12MB9454:EE_
X-MS-Office365-Filtering-Correlation-Id: 852bc412-0f80-48be-d38d-08de2d17d131
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KTzWiSOd87XDXfvvC6v2iUVja4l1VmHHE20qyPmtcmdvWf5JfcnDBdsgshQn?=
 =?us-ascii?Q?aZh+uRFlRTeG6OQjslB4JADxHVfs+yQcsBbdjlf66c2gUYF4MPUSvM/joTPc?=
 =?us-ascii?Q?jFBQjG1vg9e/wvajmb2K3LsulxFvcMsACzxT+Se5Q8SG4N9FoYyp8LF5b1py?=
 =?us-ascii?Q?9T0isTTJrW1a+MB79TEZ2Dw+hSg+ws/7m/qxy1Ctw1GZuVzAz42OqXx3HKOa?=
 =?us-ascii?Q?0wytDyo1DRBbd/Ksqh4rJtxcvp5TncY2uxeUgQtc7qBaBkpyC1A7GHXeq1ih?=
 =?us-ascii?Q?woAmvPqU/gVnWdm36pcPCJvzuHLeSUnIBf7QCGt9xKx40XRn9KtVmiitbMFD?=
 =?us-ascii?Q?/N+tO2FDvNv4Md3GIRmluD9+qUhaPRmH1ljM/qDB03WMDPQdqxoYnijNlDLf?=
 =?us-ascii?Q?eWGpf28KQJCg4KCCkmZxWsVRON6+M28OMZVD0BSwAcqZXKDqZsiJF0oXXZ5f?=
 =?us-ascii?Q?OaoPcNAnhvOangT+0DyHnDOWHtbsV6L41MConM8g0gG1qFHcDIpgijD5kXVA?=
 =?us-ascii?Q?wkMwateIX8UfHDrQ+9nmO9k8yfN4o5oZvGbhNKe6mCV09F5onOUB+Dg28+//?=
 =?us-ascii?Q?pgUlQ8F18rjk6NV5vrkHJt9PtRSaGjX5/VLwybgVEKOb6icHLufXIcHeG/On?=
 =?us-ascii?Q?jL9qf0LPnQTKEKBUoiBybT/IjNU1c41xvuKHyCJOkHyuSA5eAHRypBjkPQPU?=
 =?us-ascii?Q?kgn9rRLEPmAyUHuetCPdfYZBt9MTaERGXMiVlP0gnaEunzdgM8tSR+1xvtAy?=
 =?us-ascii?Q?twY0/JuEb81pXxQvrQ7n/KO9N+Zmi+mSm+w/NdiCLybkbwN4LkDjlqCFssFR?=
 =?us-ascii?Q?FhDYczwUV+fyJF/Vh+dhnK1H9AbVBOzgo79Vvz+7LraoWTb/E7k6kb4O6nsS?=
 =?us-ascii?Q?q3nFd/emr8Brur8x7WCx1F9AH6QSJ75wYtuccLcIQOfS/SC4fnBHVYPJw0pA?=
 =?us-ascii?Q?r+GetmisupwNBEeyxjHVfKE7r2n2u9MHwoMbIYQEYDm8XvAs4KSOA+2EAaVI?=
 =?us-ascii?Q?/XCh8GLE2ViEaHaicVw0rk65Cvzs0VESt/eSaNjF/GYenzXH2yPUELVGPWap?=
 =?us-ascii?Q?KLsgMv9zuMtIqqzBgY8+fEZEo3PM3TPKqRwp0hRdoZ0ItExf4hN86ZNFv/Ih?=
 =?us-ascii?Q?FUFwYCfzO2hz8csfXdkJ2FxpsrYswaoK/szrFAPDpgLOi7uTY2nY8gr12FB2?=
 =?us-ascii?Q?mgdk95RS+c80D2hHtCd6z1VMMnxPFlskh3a5eIL3z4dO0qbS0GRBQEQsrTuI?=
 =?us-ascii?Q?HGkBVG8RWTKQFTpV0PzaeUNqnkTtK72YNBf/21zGEAFTNzZElTHeHgHbO1rh?=
 =?us-ascii?Q?h66Me/GlEG+4/MtYlASRx3PfEtbiZT6g8WxW7eyXv593DTrcnWHzGA/Bb13R?=
 =?us-ascii?Q?Y4tzl5SuZp8X/xUHDW0Vp7MKDv68fTSxbcowB1Q8MII8eHRrAIIl/+Crsu7B?=
 =?us-ascii?Q?izDo7+yY1IWCoEB/O5J+6Ypn0jW+Ysv2ZouWBJ+2FTKlRCTuUfsdetvq1WPu?=
 =?us-ascii?Q?cw0ZqFYr8Xfn+VeEBAbulphdJB6cBDVME98g2JtlOypwxpMzdVNa/fG5kONW?=
 =?us-ascii?Q?MrkOpnrF1MH7RS6EwYU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 18:15:44.9599 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 852bc412-0f80-48be-d38d-08de2d17d131
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9454
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

The commit 6d234a79e9eb ("cadence_qspi: Refactor the flash reset
functionality") introduced two returns in cadence_spi_probe() that's why
remove it.

Fixes: 6d234a79e9eb ("cadence_qspi: Refactor the flash reset functionality")
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/spi/cadence_qspi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
index 892dc3557a5e..2d2469565b5d 100644
--- a/drivers/spi/cadence_qspi.c
+++ b/drivers/spi/cadence_qspi.c
@@ -270,8 +270,6 @@ static int cadence_spi_probe(struct udevice *bus)
 
 	/* Reset ospi flash device */
 	return cadence_qspi_flash_reset(bus);
-
-	return 0;
 }
 
 static int cadence_spi_remove(struct udevice *dev)
-- 
2.43.0

base-commit: a0b13b17fbf99fd16341b68b649ec08ef2b3536a
branch: debian-sent3
