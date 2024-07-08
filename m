Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 021A3C3271E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jul 2024 15:40:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95749887CB;
	Mon,  8 Jul 2024 17:39:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BvdmZ2qm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 036DE8879C; Mon,  8 Jul 2024 17:39:57 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::618])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81E42887C4
 for <u-boot@lists.denx.de>; Mon,  8 Jul 2024 17:39:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Sam.Povilus@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LLFmuC2HIZjvC8unzWOt5u0d38GOtj77M6ylBaDvHvHYaoavW3D7KKtLZfKE7tZJqqLm8GZYkyBY5xPHLyazRWTGLm9HO+EWrcVCEV1bzLpCE+k89/7EhhlKTUNKaklualT5e+V214B9F887FHU+QhHwudgJGZnlr5OAkkInoC0Rfkf3l0sdSJGE7dOY7Udedq+vLHaVMRSF34225ZerKQdewm/zgALwVeft7E8icJcN9KbTHIhHsKMpIwyg0VnN5SCm32j4ZQ9XG2dsEKaoyhJWAcgHT2FxuiyabQ36W3YKeyIPl5pSJBf44Gdqi57yyvl250kzuFXjT67d93l5NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3mjPBT76d9UHSGcdTV4sQmKQakAlG2FfasQ0b5Luq7Q=;
 b=GkClv2o7SzbqRlcH9ezj+lBP4K48guyzBjKcQ7eSuhzNOXummKpFuO6C/FwAVnS5/R2uO0MB9x7jyffKFPmmUnIgwhUNUCVvkGF3fmvulPfOJVXEPs/AC/8XnsrP3ojJpS9qRiqcxdW1wopkMTL1XvuWXfQfF2p1GLS0P7m9O9sI7n8rq69sLOdMyae9pryL5ieW0yPS13+mExjSFyFzlwK2sio+xaIuLRPKvsxSLJLLV7bKk4z6cbwAuh8qRQRY4WlicgG+WtNzrYDeJMvoy0NVwJVu9pro75GbqHDzu1II3xRf7jtJoHt77xK1AGPu/WF0P4DODfTk9Px+Wwm3pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=konsulko.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3mjPBT76d9UHSGcdTV4sQmKQakAlG2FfasQ0b5Luq7Q=;
 b=BvdmZ2qmYam3Y4S0MWxl2FSumMIKF7ZwbN695fRYO2Fhr3Snpj1cP9QGS2Mwh0h98IaZ7X3tVlqw7+T0mdFFnv4rwl3TBtep/jDHamopJpxU8XzZcXEkvHqo4/z4ituqq//GoLhAxELPecMKa5t5zDLLZKZcL1Xm45iFuq1FtTU=
Received: from SN6PR2101CA0023.namprd21.prod.outlook.com
 (2603:10b6:805:106::33) by PH0PR12MB8824.namprd12.prod.outlook.com
 (2603:10b6:510:26f::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.33; Mon, 8 Jul
 2024 15:39:47 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:805:106:cafe::fe) by SN6PR2101CA0023.outlook.office365.com
 (2603:10b6:805:106::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.11 via Frontend
 Transport; Mon, 8 Jul 2024 15:39:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 15:39:47 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 8 Jul
 2024 10:39:44 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 8 Jul
 2024 10:39:44 -0500
Received: from xcoapps69.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 8 Jul 2024 10:39:43 -0500
From: Sam Povilus <sam.povilus@amd.com>
To: <trini@konsulko.com>, <sjg@chromium.org>, <xypron.glpk@gmx.de>,
 <u-boot@lists.denx.de>
CC: <sam.povilus@amd.com>, <git@amd.com>
Subject: [RFC v3 0/2]  FIT documentation link vs copy
Date: Mon, 8 Jul 2024 09:39:39 -0600
Message-ID: <20240708153941.1045588-1-sam.povilus@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: sam.povilus@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|PH0PR12MB8824:EE_
X-MS-Office365-Filtering-Correlation-Id: e6d41763-7410-41dc-362d-08dc9f6432c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4vZH0E1Kq/G2Mj0j8lQ1qtpS3ryPLqMgyglleUz2nj9Z87OlzShiihKkUeag?=
 =?us-ascii?Q?liFulhXDcxM/UsqD+NVUU1UzjM11rFmzZcYAEtPasAPfcO5CPcyobFMkk9oF?=
 =?us-ascii?Q?fiCeVIp10I1KnUxcJ7Ykp28dQ3zQPAjUlWJYCVborJ54LFa47pA7pWNXrFoq?=
 =?us-ascii?Q?OdmA1LmSdR/jZnOxomhMcCIKhn82hbpVYgBLfXd/9YYkZrkkNLocQ5Nr13uK?=
 =?us-ascii?Q?PGTi5sSGv6EFNllmXAunMwcti051Yqrzwkhx7RIpyuEy/Zy9gp+Ad7/0SyDS?=
 =?us-ascii?Q?oDaR2mE4jdKDSQQw6wOqfXZ6PW9C5hwvmF7UUgUtrGzSykG5vwBdizVJIrfn?=
 =?us-ascii?Q?Ul66aIxiwXpPLdQ5vbxayw9ow3mFJ/8yIMknOi04WIHnZzQUIEecOHA+CvvF?=
 =?us-ascii?Q?o/neH35+6YpnoOTcDw9X5ANCNSPWVwpT2ROgFSYvXcrW1eADmgu4W4y+4IU6?=
 =?us-ascii?Q?NXntyEoSfbnRN6vyjT/77h5QVd1DCsH1OV6/XH1Eqf08RgxRAm/q6itP5iit?=
 =?us-ascii?Q?g31LnWvhQbu6ID3VCfAaEYs2vKHpW0uaMnb/yFlCw+izYGnDTf74OA4ORRn8?=
 =?us-ascii?Q?Ti6PdE4FkMJ8uKhCPiM3gqtizaTlu/k13MN2f7TFau4jKFo7MboUX432bYZQ?=
 =?us-ascii?Q?qKbtCLr2hX8soPqJUqpXa+pIA6yxtLOOwDbf01PzJhNOr56k0C1Hldsy1QDE?=
 =?us-ascii?Q?28LJ0rZBcuJU/2tHXRUa8yUlvEqOnU0bmb0uahjl295zaOWw4fSGrlOKIass?=
 =?us-ascii?Q?xJpg6sX9nHLKB1fOsoT7a2pV3xA0gWHmGDozTuH7kpkqDXTxKvlIvomNPirE?=
 =?us-ascii?Q?7vtQZm/Op6LSoG+1yz/AXIwUvWe6JbzWznbtS7knq53quY0diXb9uVwGZYk0?=
 =?us-ascii?Q?1t7sPPr+RhGER1+NRlaekYutgL/7iJOslvOMmrks67L3XXexcHrRI9P0DrOj?=
 =?us-ascii?Q?AmWxISeKCiMroxXhN6JzcEZOEcyy3aJfJvGIAde6VVmHA9BzwDBTA2uU+5W9?=
 =?us-ascii?Q?W00p11DvaaYHX+2bVsxKvIl3DSKejYxLqdyFExlm2mW64E5sjrR3yac/pVb6?=
 =?us-ascii?Q?L9ouXPXDA/P43FqTL0LjT2gYRWTtx4S6xYOs0W1QTr+l8QEHw7fu+cWHwSzn?=
 =?us-ascii?Q?e3QrRFHREV6eqn3uyaefdsibra1vBq1KobwUmkx2Nrm64S1RvYWlaF1q/ZCH?=
 =?us-ascii?Q?/IBoXQ49RdGbUAfoQ5UnFE9bE8HN5LOrqbahuDKLIh+6c11tuTXIwJl6s18o?=
 =?us-ascii?Q?hCl+IZX6K6qUn5sQwq7xewnLKuYxzA0gBUMXVDyFnaknn4Y9hTQgVcqS2nIo?=
 =?us-ascii?Q?shDJK7K1B75J176HRfogHlJGyUEfTd13jP9ZvaesVo84yNvsarIEXj2bcnSr?=
 =?us-ascii?Q?25d9S/EdMKxp9UBN5glyuWTe64MCIvd9gE8kOOnbMgAagq9Lg4lG7FI+FqQJ?=
 =?us-ascii?Q?b/t0knDIV0BZgRID1KKCsHloa8y9ehpL?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 15:39:47.4861 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6d41763-7410-41dc-362d-08dc9f6432c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8824
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

I'm proposing linking the FIT documentation instead of double book keeping it, it does have the disadvantage of making it more difficult to see the documentation especially if offline. 

v2: update table of contents instead of removing
v3: remove duplicate entries, provide commit message

Sam Povilus (2):
  doc: Remove FIT documentation that is elsewhere
  doc: add missing table of content links

 doc/usage/fit/index.rst              |  26 +-
 doc/usage/fit/source_file_format.rst | 682 +--------------------------
 2 files changed, 23 insertions(+), 685 deletions(-)

-- 
2.34.1

