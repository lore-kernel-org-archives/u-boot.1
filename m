Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A26CA0FED
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 10:37:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9433083106;
	Tue,  9 Sep 2025 12:37:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="iiMb2w6b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 123688319C; Tue,  9 Sep 2025 12:37:13 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20720.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::720])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 150EE830B4
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 12:37:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fYQIzT0qRsgqnRzN8JxSBoDrEXx3zayIKu6CbQIc84tXZczPztfjqK9BAKG1ypSueV7bw/Xt9stHY2N9btmxAgnHjkXFgeR66p2H86RQWkIxB7pNbWb+UWL5yb/rMx8/xbdrgtKs/Rspxp/EE2ToA5lPtl2tidk88MGBIf/wGmpnBe+P/pa6KjPwp9cXuXGrSOSpf9Jzq1hU+1EuADClZWvb0f8OhWtWIt+qiYB7GtqjxheYpe200CXtvC0/XUWFkpf5mvYYRdJTQie0uJZ8PVWRyi4NCnoGYJ3ex+d1rVVSJb5YWhNF2nKRMGBwjNd4shPeHA17tUChgQvPReHdtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e1BBPRQlyTWkZ2jmPwQG8QkxuEuSvKzXSO2so1PNf2U=;
 b=bC4pU56cRqP6EtgFs5DUZIQx0qMI8AFJAF1z6Rl9DEkHxSODGmFNvz+QQtnLGvtcfhA4qISGk1PX6pMnpEWC+Ob6ehnRlNtzMj7EJ/GxhdYjLVY4rVFq+iI6963z9y2IyT4Mku/EWsuGKUrRUUeVmPh2VAnYqBVyI4N/IEv2J3Yi0PS1YV3wTiWFh6POvVOri15NMZeS+t2nt4ZoQRI3Mv8FL6yPzQu4yJIVitxBf9CBK/7BVlTdSdGrhpJTQp+iBrdpY9Y14L1L8pIRUz50H8XaMAhdUkRCrHFwq3vE9jChkvwVdZ1MtGEksszAb1c02mr98M44CgEQrYMvT8ljcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e1BBPRQlyTWkZ2jmPwQG8QkxuEuSvKzXSO2so1PNf2U=;
 b=iiMb2w6bvsmMmp4FnAuSWV/V7tefLaiyX0ZstpN6zBBzJLiUswN9AwyYeccoRf80VQXBV1eUkHx5j98ctmqKx3SZm0TZobuFSSiB2+ehPqXEJoQ5OjRRrLjpQOHe5b3ZdJvjUz6TeWHnM2cfXTHnZrm580MFTSxj7W73oEZoFahnJmv8V/ORgz0l613b8HQNXfIBRsd/vpR+JqlTvudyBeyqUWNONWz/u9Ep7b2JDSmJ/HjzPLX80ffHa/bjex5bofRPx8MEwPT6Yi1H1KmxoCJimlrV5DVmlAd3En44uvhoC7ShoWBC2awFeoEx8PVciccYrXp1YQOq0po6ZwTlhQ==
Received: from DU2PR04CA0059.eurprd04.prod.outlook.com (2603:10a6:10:234::34)
 by AS8P195MB2042.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:52b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Tue, 9 Sep
 2025 10:37:07 +0000
Received: from DB1PEPF000509FB.eurprd03.prod.outlook.com
 (2603:10a6:10:234:cafe::b) by DU2PR04CA0059.outlook.office365.com
 (2603:10a6:10:234::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.23 via Frontend Transport; Tue,
 9 Sep 2025 10:36:37 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB1PEPF000509FB.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9115.13 via Frontend Transport; Tue, 9 Sep 2025 10:37:07 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Tue, 9 Sep
 2025 12:37:06 +0200
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Tue, 9 Sep
 2025 12:37:06 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <ggiordano@phytec.com>, <trini@konsulko.com>, <d.schultz@phytec.de>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: [PATCH 1/2] configs: phycore_am62ax_r5_defconfig: eMMC boot from raw
 offsets
Date: Tue, 9 Sep 2025 12:36:53 +0200
Message-ID: <20250909103654.3341398-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FB:EE_|AS8P195MB2042:EE_
X-MS-Office365-Filtering-Correlation-Id: 2115daf9-c4d0-49dc-1e96-08ddef8cd32a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nC+1hOWVBZ6kWjvnutk3JhbK0VhY2D+52BgnWzYx9jAMrOM05ESgUPuQ8BMB?=
 =?us-ascii?Q?LFyECLn7spoMq6uHV94aLCzi12YIcKgCNs8jD7Qi3dRlfonvf7N4ndt+J+Gy?=
 =?us-ascii?Q?bzEBCb4BlUQIRkHn2D6fcHa4dpFOOpmek2urwDVIHTUG44bJLPYO823brAJb?=
 =?us-ascii?Q?SYWyfJGCwGPOnCDdV4zvY1h38WVBfARDXhNRz6eAWKlI2sbBZ3CAMUsdu+uU?=
 =?us-ascii?Q?4AjJMYsmYpSMqNXjd4gIzN4fE0Nvdaufr5/akoeGsKCzJqLPe9kCvv7u95bz?=
 =?us-ascii?Q?ZuOaS/QCRIDYwmwFlLKPiPdzPEV5z1NJdvJ0CTctnPI41a8DBKFibBcAiEG/?=
 =?us-ascii?Q?RYG8taCqskfZppnxqCcwUVSj/XZBK47eoDuDCM8jFDeUnEZe4ETzi70p5W2/?=
 =?us-ascii?Q?htpxjVtheYpbSpuaQ6zsTQI3v/Cpg0mzfD02UZrBwaoTF9geYd9GIzPeOObW?=
 =?us-ascii?Q?gWVluihbxWYVdsGwTyQLvov+QhxWsVZb8m2e2dK0dYmqMdjs7pCZJfFRVqTl?=
 =?us-ascii?Q?r7wMqkWCisyfqV97LNljv/xSu6cr2n0i8jySAXGM/cqr21vGshYEBkLXRoNA?=
 =?us-ascii?Q?KuPcNAihNIwme/Fq2sxiqAwkETIjkYMy0rTpWOlJ7H+Eg4sNZsCBdXSkU/Yf?=
 =?us-ascii?Q?opomd2TpADmqnNZiDlEOTlC0IU2dgCCmVypNPWwsknzGxtCKdXdSZqsj/ARU?=
 =?us-ascii?Q?Yavhy91y4p/cO5bNcovE2Ky+gohonbDXPLUOBQlk2g+FMowag2uRk8XVrUgp?=
 =?us-ascii?Q?y4mi8Twl61t9QnQzCtOn5MoR2NjJZGn0Twc0QWaqwnUbXwnFiOmFRXPu5D8l?=
 =?us-ascii?Q?8qoYnp/uhKL6Y+ARu0eZGQ5qBwhOYz9uQ3Iv6axZvvLxraBZ470mGRsWJvQ3?=
 =?us-ascii?Q?8UpGtJR5+IVbZtumg9O4flfP2iY5JtPimu1YlmN1IOxE5cbkuAU3Cy3P85hS?=
 =?us-ascii?Q?3T6D6XLC3IR3kQZ79d8Q8/UdOK/FUHSs21aQZtqo67IsF36CDONpLi12wOsU?=
 =?us-ascii?Q?p2dVvOB7IKujEeVCxeONaoi6PfPK3/GtbP+dYHebl9TF75uO2L+I5dKd7WXw?=
 =?us-ascii?Q?Ex3jVkA1fcOzJjSM1JGzzdRJtKzDLeFxKSa8N2oRgtsxsZhQWV0Xw+lmvfs4?=
 =?us-ascii?Q?VKr4AHggNIlsnF9F5eyQbbb7g0aCiP1j8UAZLF1s67RhU7at+3Puv6iZbWtZ?=
 =?us-ascii?Q?Ko1/v676bgOxokyoYF0YN8zwX0SAnaQayqA7yYtB0yQ4UFQnFG1/G9EDskvS?=
 =?us-ascii?Q?mdtfQDZ9lLG3rhfeNbgJbyCx1hu5wzdvVVdTrtGmmDp/AUNYSOVEfFtL9+Ry?=
 =?us-ascii?Q?YCrysD0jCtbHu2Dy1DgnPnWMGC48KusPzEYz4JVqLddphLQnmo/FyP2H4Yzw?=
 =?us-ascii?Q?P7VsPy8fHIwj4KFtRXXbo63e2satFoWepz+6PB8BYtgnMrP16cdSNpUrT8Vh?=
 =?us-ascii?Q?jxvtxiW5ke4XiGPH+2T4fUVCJZE6lqt89vzKN3ItLv6CLOz+JvNkhDIJO1QD?=
 =?us-ascii?Q?vt5M+BEojpM/VOrfJBLlfVrv4bMOVRkPTSqY?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 10:37:07.2997 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2115daf9-c4d0-49dc-1e96-08ddef8cd32a
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509FB.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P195MB2042
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

From: Daniel Schultz <d.schultz@phytec.de>

Enable CONFIG_SPL_SYS_MMCSD_RAW_MODE and set the offset address to
boot from raw addresses instead of a FAT partition.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 configs/phycore_am62ax_r5_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/phycore_am62ax_r5_defconfig b/configs/phycore_am62ax_r5_defconfig
index 01d100842de..584a6415ca5 100644
--- a/configs/phycore_am62ax_r5_defconfig
+++ b/configs/phycore_am62ax_r5_defconfig
@@ -42,6 +42,8 @@ CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
 CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x84000000
 CONFIG_SPL_EARLY_BSS=y
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x400
 CONFIG_SPL_DMA=y
 CONFIG_SPL_DM_MAILBOX=y
 CONFIG_SPL_MTD=y
-- 
2.48.1

