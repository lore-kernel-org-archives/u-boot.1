Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB191D4335A
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 12:48:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4598B88FC4;
	Thu,  7 Nov 2024 13:48:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a7cbp3Yj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9EBB89246; Thu,  7 Nov 2024 13:48:13 +0100 (CET)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::627])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 109CF88FBB
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 13:48:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Prasad.Kummari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kwZ4JZGkyc/64zlOgYLuPEAn5UnKUJNwBFcDp7rl6D8WglxoQ5eywSq8UZN1e2TG9eHjVuCC18+i+Q7E/tTMpadIrXmC+fz72QIHLghr8z9P5RHCH2lzBhP1NcczBy+fRQMiQl7NRzOzASz7DeGGln1HEIDFB+ThImHpSFuqEtq4xaXsTKpBdD7R8wU2zcUh/mBMiqOK8vKOoHzWR2dDjE/kCSfQu2AawEf6mGRiAyoMY1WtZKLPMT1yq9yrXEvqLEM5kmKNPD+V7svIBllsh3xI3zgFxUW4mTXLoLZL3xUI1kzWkigSKQ1JVpI+dvXeo3JCc0pqbhyS5vAa9Q72/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azBpquvW6Tksq7lLS2KGEC+dPLzOcwt4/M3aQgIExz4=;
 b=pLpIpb+QOnQXLqngE4pZVWXNYXKpGLPcR7VflJAvXKzZmxBAG4xXsYfo6rZPXczU71xaYaph43Pck2weY3NKr91zvSKMwpMFzqiFpoTXhJ3E/NRrnNGI91ihP9BpxrGeVeqahAUs32tMQjCFEVhM/FwZuxgi5DefGs5SOFvPWvZgZrcJ0j+m/4cTiUwX+EL7URnJeooj+tf8CWnm0VCOgCp2/5d904C8SeZh1VJ85zvWSuSYKILk+Ee7FqidMsoXluH7bEOUt4IJtleZvtggfL9XHIJowGcNkou7vKxYp/2TQe4QXT2FHFS/iDHnulh3E8w/MV6+I/wOoKAfawWpJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azBpquvW6Tksq7lLS2KGEC+dPLzOcwt4/M3aQgIExz4=;
 b=a7cbp3Yj9fKcdN4Fnnwt6WOBKdgD4LUJhr4D5XsdiLT4sXRmm/q3zEsEioEGUh4wF90aYKzOa5EbGhIfX7W1Zvt1uLvH3D5Ex3DpEyvh9KHJnaWuG4RUnZTVakTyLXR6W90l4geQMNB3sCg0BNCVLxIYfq9ReWFxr7A5IFokNcI=
Received: from BY5PR04CA0013.namprd04.prod.outlook.com (2603:10b6:a03:1d0::23)
 by CY8PR12MB9036.namprd12.prod.outlook.com (2603:10b6:930:78::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Thu, 7 Nov
 2024 12:48:08 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::7f) by BY5PR04CA0013.outlook.office365.com
 (2603:10b6:a03:1d0::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Thu, 7 Nov 2024 12:48:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 12:48:07 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Nov
 2024 06:48:06 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Nov
 2024 06:48:05 -0600
Received: from xhdkummari40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 7 Nov 2024 06:48:02 -0600
From: Prasad Kummari <prasad.kummari@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>,
 <padmarao.begari@amd.com>, <git@xilinx.com>, <jagan@amarulasolutions.com>,
 <n-francis@ti.com>, <d-gole@ti.com>, <vigneshr@ti.com>, <bb@ti.com>, "Prasad
 Kummari" <prasad.kummari@amd.com>
Subject: [PATCH 0/2] indirect write time out related changes
Date: Thu, 7 Nov 2024 18:17:05 +0530
Message-ID: <20241107124708.383695-1-prasad.kummari@amd.com>
X-Mailer: git-send-email 2.44.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: prasad.kummari@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|CY8PR12MB9036:EE_
X-MS-Office365-Filtering-Correlation-Id: c65bc96d-593c-44e3-93b5-08dcff2a6db1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?raPntBAyT+D5Fgmiu9wqc3+p6shDxY/oB+YPnKzo0aAfLguow2R2Vx2IjeM7?=
 =?us-ascii?Q?KVcyHGRHogotQkhp8tLWXfnrQBBFTh7cOXiCQxMQB5M9I+NuDqiBL0pXol6B?=
 =?us-ascii?Q?hSxEzEchOgmP1BAyL2Hix/+NrPyTEoeZuWeVrY22qydLhlOTLot1wSI75gM0?=
 =?us-ascii?Q?fLasmjlIpiPVX9fyw0x6qF5/Ux6hIg+SVel5Q2YmqvoN7CaFBOx4rudeFmLg?=
 =?us-ascii?Q?LYbTQitbH4hNOn5nDsERs1EX4ajQbyWPeee7KhCC9hcu5JvYsD88od5aGKW4?=
 =?us-ascii?Q?shTnkHrL4EWVgwhXfJLC1LaauSXPDVpjKCPIqX4Fae9sgWPQew3t8jm70w3t?=
 =?us-ascii?Q?0RtSro2wyzWdWCy1yjr6jHTsqwTZEqoKI899nUDVhvGsCLDYbO1eqI8/UmAs?=
 =?us-ascii?Q?JKODTDGVRpXy6xvaK4nhuQoA++Cdyi5vgXnSij0A5TXDQZ+E/++v41TPND+E?=
 =?us-ascii?Q?sskWFFRah2wpMx7wPCqCHtopK0OuFVd0UL3+H75Ub3v8ZMRTfY0zat4umKKc?=
 =?us-ascii?Q?WE2WNIV2LRfZW+dfXBXVH7sJvjZmjKIi42NVCRqyW/yWKx8K2MEjDylAcA+K?=
 =?us-ascii?Q?y0tEnXraeip2v/gwrAyU5ECshnkZxN5JV5tMT6ZC6ADEyp6kcq+xWAg/25fL?=
 =?us-ascii?Q?7V6gl1G6SP5Qnd1dhSd3ywmbbDJ+TiVimpA+txxygGpTlNkO2HfggTvkrZQe?=
 =?us-ascii?Q?GqsgdwU9/h6gV2NdJaY+ZhE4e4hUwYF8xSDd4Fh41J25eaBFEDzRgv0zu6q3?=
 =?us-ascii?Q?bx0sziOfmyDPzVJw4PB7jeHr2uVqkIo7xdlir8e6tR8zyoHIYmhRUSQG1uk8?=
 =?us-ascii?Q?GlFV5gBCWbRyIE5Oqtac259a8vNRYqRzLC5tBhBPd6W2xYLGZe0oqY1B4J8H?=
 =?us-ascii?Q?hd0HKNk/jI9aN63GO0adZTougp+t1AbDxxnMSZ2Xni2CMb61ljdh5ASfCkTQ?=
 =?us-ascii?Q?9c/zbKBvgXdmA3P0ElISim5NrvT20o1wwLrgUkSqH7hEDObGhiTLgYlG6LlG?=
 =?us-ascii?Q?VXXvSYYOKWzqGw8vbNKYidTmsWBPFwHxB5gXW38yOTA4XPSrxk8URjXhueZx?=
 =?us-ascii?Q?NJkt/KkplgWNFjXExHZjmXeWF44SJ1lZbCrlbX4NYnaW2g2DuTt2XB4XnThD?=
 =?us-ascii?Q?Me/+B0MMmf8GsJk46IuZD5x1RFniL/evBzaUhx5FXiIEqACjQNYDSRgskKyZ?=
 =?us-ascii?Q?Kz3/dLpcOaR8Bprdy8ZIHhFJHGdU4VHqYSR6SFrUjOI2HYHz2sOi/P0VC3bc?=
 =?us-ascii?Q?A+9jnm1xbYVNc860KDLtZDQo3By7AzFgOisZb56Kx23eCYCkFTpnfHnrbgsT?=
 =?us-ascii?Q?6Ed9nggvDkQX9tl0xUVGQobRVjvkvUK9eUJFvMWFLRcwCbeMN267xMfJbAvL?=
 =?us-ascii?Q?ri8JCFj1Za1jTqvu/bLIBfbSFcgjqkD1a4mlPU0d0rKdVWchwg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 12:48:07.2268 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c65bc96d-593c-44e3-93b5-08dcff2a6db1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB9036
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

Need to rebase top of this commit:
Link:
https://lore.kernel.org/r/b3b678603f76b9f6490c0a46ed0cec06652d1aa5.1701853668.git.tejas.arvind.bhumkar@amd.com

Prasad Kummari (1):
  spi: cadence_qspi: Fix Versal NET ospi indirect write timed out issue

Tejas Bhumkar (1):
  spi: cadence_qspi: Fix versal ospi indirect write timed out issue

 drivers/spi/cadence_qspi.h     | 11 +++++++++++
 drivers/spi/cadence_qspi_apb.c | 28 +++++++++++++++++++++-------
 2 files changed, 32 insertions(+), 7 deletions(-)

-- 
2.44.1

