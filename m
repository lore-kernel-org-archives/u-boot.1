Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB902C3271E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jul 2024 16:48:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB6E6887DB;
	Mon,  8 Jul 2024 18:48:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZqryrfUZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B001287F5C; Mon,  8 Jul 2024 18:48:23 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::610])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59A78887D1
 for <u-boot@lists.denx.de>; Mon,  8 Jul 2024 18:48:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Sam.Povilus@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkhfqEsYOpsXtyEY/7iyiAkm4QVWIyjNLMteiEXFBJIfg53/z9L0UzBQ4gKijzpM1vCGUdEKiWchwAoFDRj829YbBX/t6gM0yNp/zKZ2i05SynW3IawGAEDbJebfs+TzsxOgS/A6dp4IAhMOMfjataXC3MJecCM/Kzwbaghmkr16ZgProotsbtxyXko1el1BmaopUz7OL/NxJiYFwt9WGnoic7mIJBejAjz+1jLdJ5y6t+onvKWnhYMzmJyc8Kh3c8Tgfrfe49EWUBHrvo0H9f30UkCfgoC4Z7pQda6t4TRhueHccl+qXFbuj2TKzk3Sl7qABBFz3RGhB+KXKvQrSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqwDgdHGEO+/xl5aQvDxj05JB2pJ5Uh/eKFPYDn27qI=;
 b=gLDmwQNArgZvM0kGL60miEtCnMsR2ldoNT4qrkPG4+2AJGzLOKtaKMdOVJaHw4eZMgP8wgijyrs5D63IKBaoeJcfA8ETQwBhKlAR7SfihSb/MgKdeM7mnkJOWvZcaifoybgIwOma7vkoZ0Z6gW0/qf+Wt50w0qs+eoPN+XbVScG24WoCHlZYSMzFeHbj3soviNyREynINRKSQx/1CiM1jq5AgRRNIZ0XOIb/U04B/HSgECyxj5YwatZyM7u3K+lKOWLvXZDY+F9FLlRbD8hWWeK0ukE0TFxTaoYgtW4a0yEPK01ZAInnNPtcrdNp8voInHlxff0NQKzyGSDGnjzbxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=konsulko.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqwDgdHGEO+/xl5aQvDxj05JB2pJ5Uh/eKFPYDn27qI=;
 b=ZqryrfUZ1l5Yd4QVkRQU1FjHM5AyXW6TCwEE0+fNr9RzD5o31Kh1AtPlI7r2MQuARGVhFWVpmJMVwVIj5mxySNt/s13AwzDsPmu9fO4OlhaFtbUNK3ysDlu/0Wf9XNzJLlmmInOz6yx5rwjRNiwsdGaVTlZSrkfqHf+T2t7oPrc=
Received: from SA9P221CA0012.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::17)
 by MW3PR12MB4428.namprd12.prod.outlook.com (2603:10b6:303:57::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 16:48:18 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:806:25:cafe::e9) by SA9P221CA0012.outlook.office365.com
 (2603:10b6:806:25::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Mon, 8 Jul 2024 16:48:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 16:48:17 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 8 Jul
 2024 11:48:16 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 8 Jul
 2024 11:48:16 -0500
Received: from xcoapps69.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 8 Jul 2024 11:48:15 -0500
From: Sam Povilus <sam.povilus@amd.com>
To: <trini@konsulko.com>, <sjg@chromium.org>, <xypron.glpk@gmx.de>,
 <u-boot@lists.denx.de>
CC: <sam.povilus@amd.com>, <git@amd.com>
Subject: [RFC v4 0/2] FIT documentation link vs copy
Date: Mon, 8 Jul 2024 10:48:10 -0600
Message-ID: <20240708164812.1205697-1-sam.povilus@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: sam.povilus@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|MW3PR12MB4428:EE_
X-MS-Office365-Filtering-Correlation-Id: a794c3e3-25b9-4464-c287-08dc9f6dc490
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Vh887a/r9Fm+7jQWdgNEDTKnpCUM0iWbvW8O8n6NCa8qNylolU2IIZybITY3?=
 =?us-ascii?Q?VwY3KoVzXNPLbaXJ7wT2WObnEkcu7f/t5Rbh5Pq7oEaN7I3rCxj+mt5X1AUe?=
 =?us-ascii?Q?kStlc1PgIvqnwMzCXZtLjAEgsbt1WkPcFqicqN+bbWIS+VDowuhQqmcgjvlb?=
 =?us-ascii?Q?VMcPXGRE4jiPtsVCQqlen4ROy8r+EcfV9MNy7FauVbL3T2mwj+3XkneaC28q?=
 =?us-ascii?Q?bAomxyYxpbmjo9yBalCFwhjciLH4uJwXFFVQCEMma3bu+tdH88AhSNcqJCDV?=
 =?us-ascii?Q?R9UgozmVaaGnf63MGTrtFujHxTUTB/rerFvPL8mQAAyn1rrzsdqTi71MRJq/?=
 =?us-ascii?Q?Nv3TzX5vUyTVk+5IqFdCPj/s3nSzIvOoPI17AkRY/KHPuXhkGgGPheVtv7wp?=
 =?us-ascii?Q?LjkpJ8azQ8Y8KIrT8xH1tZiBHkkdKS7T5DhPVrSjSJOWBgGh7tYHhNEAi2DV?=
 =?us-ascii?Q?/Udnu9zHqPqutV4IdETnNxtVqalQrqwdSlNqZvYUvQrkvuXsOkpVKcrG5BoS?=
 =?us-ascii?Q?kOeuG77t8OWG5hA+t/gjlxi615DMiwThp9n3Hee+blBPOE9NreRTPxlXNdJq?=
 =?us-ascii?Q?Dvhh4I5AF7X/XxWNY43Z0GpVZnWiyHU4xE9WbSt3rDevGu4XE+rolo66jf8i?=
 =?us-ascii?Q?vL0z0zeRHlPzSXreZNxMkH7byAaFCPi+JMTApaR9KGdR9kxQ5xTozDn7SBzY?=
 =?us-ascii?Q?cqG8IgCGobiRsBxwxhBNgEG5KwUa7f/IhsPqkbUuQd9ChgV4+5jBeHooovYe?=
 =?us-ascii?Q?Aqe5/2l67pFqfykdPkKguWY8PK8HVpD15NHMg0AF+LPJkX7IQOxvUCJmDfu3?=
 =?us-ascii?Q?NDWvgUC9SFxk3kiZX6TedYrHSBN6MT8Y5a0aBNLQP3/rkrnK2l0LEeGM1nKp?=
 =?us-ascii?Q?eNLR78ezb5vTIgsw9r2qi8E0o8M/57KXVUdlPabYVhHlY2owHptDxUOXYHfl?=
 =?us-ascii?Q?jcJVgEoe5JY4jDAgtoSktZg3rWxCNAk7BBCF4GW2N9GSdQ1SQtbHC3RREUAd?=
 =?us-ascii?Q?XheAo/130Malnx84G8ODyWT/OFN6Bx9MLmO+l8N03gGZ3p8z+v9nrx5ZwGVt?=
 =?us-ascii?Q?TM2+iv/UKfBP3Fyb6YwRvQWbdfqgso/X//p6EWV2S/+Pk+S+H2aSaq5jFub3?=
 =?us-ascii?Q?MtIv59uXNtPpZ+mfqjEhGmJA0goRGWHm9NAXyTKxrQTREI3Oc3WBPgyMDL3E?=
 =?us-ascii?Q?kmYD4dwPNMv1WuYEJrEZw89UgIxrFAWG1/0Ve/m2eHp+z5zOfzBW0gHspmF3?=
 =?us-ascii?Q?cGJp7a1QHWdN91WzUebaOkuvHFiFHRFEFhDPjonN/xvmz22he4nBDxDQ71Cb?=
 =?us-ascii?Q?oqN23RM2onFmM1wp5IieqBD8GsDQ1X/WWjNCs9DCGe1nHM6+NLHzy2E+a0Q0?=
 =?us-ascii?Q?7tIm37l6dRRlRx+OyaM5f5eUQvcVToJjVtSDt/k3wUi9Q3JkQ7atSJUBrAkJ?=
 =?us-ascii?Q?XvJ2zHafb4ugzpj0El+ludhQtCNK/5QJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 16:48:17.5184 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a794c3e3-25b9-4464-c287-08dc9f6dc490
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4428
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
v4: cleanup: newlines, duplicated word, commit order


Sam Povilus (2):
  doc: Remove FIT documentation that is elsewhere
  doc: add missing table of content links

 doc/usage/fit/index.rst              |  25 +-
 doc/usage/fit/source_file_format.rst | 682 +--------------------------
 2 files changed, 22 insertions(+), 685 deletions(-)

-- 
2.34.1

