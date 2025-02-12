Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A22C02198
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 09:31:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 080B380C8F;
	Wed, 12 Feb 2025 10:31:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="kk4trGt+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1560C80D1C; Wed, 12 Feb 2025 10:31:39 +0100 (CET)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6518A80C83
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 10:31:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.henrys_ext@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RMHnxwqg8K6U5GKoz33pjdrg76tFXSh+pjdL7Bsoo65iZxRk0NX6U4DdchljXUgjYia3JpqPDfrVwYCJK+5uJYrd2mDoVQqhBUZCaAEuTOzZo7Bnws6Bbar49+IfJ2H6mLu4HjGvojiTpW4ftlLYyZp3rQgaMSboBKUK0iErrTGnKnSdZfk1shdngAlJoYCC5jawwLk2jetTo0qN7HqQ/XtcDD4M2q/rJBTWJt7g+J7V5MR2hyF0cT9SD9Mf+dDy0I0oRJwXMCsyX/AwlD0NMt61DEiQkTMyncxzlb+cHw1G1NUZ0p0ErHDYdgrqWmL/aCNeGlKIGi1fvUHduNa9Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D31eS0LNziZPPpGaEzXZKUUq/vat2w/Ez2/WBHhAGvQ=;
 b=QWJWYbYSILBQmws8FJWvdaeTuwijnqa2ESk1158jMboaDK4I5bDj0CXuypvSxOomTN3Ii2SWkfHUfqBxCAOQkCtoSadtluLMFfBzFsJ/HMpOsT0s4zzyrPIZZmVb04mSLDdE3abaMM9pigqb2bUN7uVdJmUCf9ITlhUXjUxGmkfrfU/MocdBzbgeDTpX8reiJRQxJOYCOc41WJ1Rn5Wef+tBLnrfKxvwalrYAZrYUNKwMcCGuPLiY6Vyh3zEVm1WEwdY8kmaqgSPCq/sZcz1ugb+rfAVcbm+VNhVRA47uW7To8uJO5uHX/lf8gg7ImttJeTmoRP2yQhs5pLCV3tK0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D31eS0LNziZPPpGaEzXZKUUq/vat2w/Ez2/WBHhAGvQ=;
 b=kk4trGt+FiQXFJI+J3dMQ3fETP7nNbVTHoH2k9hpx5AQ1svBDwsm9V97RJtKPjuP4/CdlDQ5F486Hg7kTbowO2CDeaLoThW7K18Dz+RG9C0Y1jtENdPnNYkJGJizsMl0IFIt0Z3SLDRwLijLUHhO9WTkCH9Bao9PDBVGKXqpQ5RY1NrZ3bnn4iSub06QhzcsR3K/XFzZ1hJMAccjOwHyNpEnXGRemWTFJzFbvpfpreU43q5qlKAKn0iGo1eU1V72GpmDS00KqAsHLOzFhoy4kG6WAc97zUfo3MZu9iu8wU4QLkQSekZjzfguN+WVyCuU39tPN1AkcmWzL3M8eEQI5A==
Received: from PA7P264CA0370.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:37c::26)
 by MR1PPFF5609832D.FRAP264.PROD.OUTLOOK.COM (2603:10a6:508:1::2e0)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Wed, 12 Feb
 2025 09:31:33 +0000
Received: from PA1PEPF000CC3FB.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:37c:cafe::f2) by PA7P264CA0370.outlook.office365.com
 (2603:10a6:102:37c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.13 via Frontend Transport; Wed,
 12 Feb 2025 09:31:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA1PEPF000CC3FB.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.10
 via Frontend Transport; Wed, 12 Feb 2025 09:31:32 +0000
Received: from sah2lpt245.. (unknown [192.168.72.253])
 by proxy.softathome.com (Postfix) with ESMTPSA id A148720059;
 Wed, 12 Feb 2025 10:31:32 +0100 (CET)
From: Paul HENRYS <paul.henrys_ext@softathome.com>
To: u-boot@lists.denx.de
Cc: paul.henrysd+nodisclaimer@gmail.com, sjg@chromium.org,
 Paul HENRYS <paul.henrys_ext@softathome.com>
Subject: [PATCH 0/6] Add preload_check_sign tool
Date: Wed, 12 Feb 2025 10:31:20 +0100
Message-ID: <20250212093126.3722186-1-paul.henrys_ext@softathome.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3FB:EE_|MR1PPFF5609832D:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2470fbb4-00b5-46f4-1be5-08dd4b4809c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?39GNQAWh37WgALar0V9ny0FNudeBkBVk3/rFJUKHr+OcwLOTnbhDLoyvSOJo?=
 =?us-ascii?Q?z3GIm3FssuUa2fd1NW79TKylGwHfLUBzzAuCfYpmTiqX8GAc3vpPV8Kv5Akj?=
 =?us-ascii?Q?h8kcu4co+Ek+rW/yJFzf6MY+PpHru42G0VhktyARzlbVZuPsagoNqQj7DjH7?=
 =?us-ascii?Q?Ia5gTySH+Hi1gaNlM9jw9SNO2YDYPx9g8FM3ekZ/O8Sc01tLTWEXvwtKGV26?=
 =?us-ascii?Q?XIm5R9xtKaOPHXLEUKi0XLzGQGqJkaxk7V0NhfGRe5ndDxTE2ez3z7SaP0Hv?=
 =?us-ascii?Q?Ovr8xZh2e/McmtRMFtA8ytAx5lDrUa6KQzNMqTpvoIaFMOi5Sfshdx2EjwBw?=
 =?us-ascii?Q?zu2b6oyD86MajHfvnRfeVvODHgX2IFLyvkBu2G+trgrovFeqggacnsL+aTm1?=
 =?us-ascii?Q?tlrDu9xKAFXG3XgbUbqqaINf3iCyrEYT5diOOLVYmA7ZO/hhaDi9FQfKOUT8?=
 =?us-ascii?Q?fKmSW6ViEI9PThvAeDwVaSRRp6ZqKGgCvwPLNMQUH8CEAkSFScxC0wsotA1M?=
 =?us-ascii?Q?ztZw+RHsm7sxtrt1tRdaKP7W2FE3FfCOnUM1Xbxy6WUVpfHm2ptxI62iQDU1?=
 =?us-ascii?Q?aiZQ7U8lXpNytuJoUcwDEXFdASU7T82szbcP+ul9F7pcblnIh1DrY/hW6LaV?=
 =?us-ascii?Q?cISxFg2pSB40VOLpcLibeCZEp9zdHavsV3yDaYAYzsVOEuTDu8eUikVKOph7?=
 =?us-ascii?Q?BFGLUDwy2P74E7m9OWDLVkic/9zIZDd7sCXeqwoF+iqyuocYZ0nLCXY2vDPt?=
 =?us-ascii?Q?I9dUc3E85YfaIsYA8cSxrKVnJuKfVFJaQfhjt3M7wXcFkEURnwSe8WCmVLTb?=
 =?us-ascii?Q?BtEdc9SZzhVlwrjhrzgaPgVrdCcY9plOvfaMJK0mNiMWpDEba/qfp7pJ+QIP?=
 =?us-ascii?Q?LU4qOjcTgimVlSjp4J2RhOqzkrL0snECELT1MAh2UujNTPGQkTrv3XsFJe1s?=
 =?us-ascii?Q?zfGNuAwFoxbVfp4jCU/semGt1fyk/Bnda0iiimImFX1LLZz5g0chaEgiG44K?=
 =?us-ascii?Q?OW3fAWZJnbziigFsIomj4XEhdSiq2jyzZGISaO6cWjUIaXZLWNiPQ33wyVVD?=
 =?us-ascii?Q?9uat5Ubj71YOTPjeSBbC1EVbjtH8Z24RnntP70uah+0Fg3Th0REOAG7IBX1D?=
 =?us-ascii?Q?ireXjX/9mPnQtwgMOLmI185uzJLzWQEsQmmKyRVQVTSfDxltAdhtJc92yLSU?=
 =?us-ascii?Q?XhLIXDG0YnkjiZvbUYw1htvwtPUPTGhR8ZtVjp7fRbgTJyTXNQuvOQ2NvXK/?=
 =?us-ascii?Q?30AxIaLwRxQQNNyv3cGVCrD2gx5mjNo36V6uhclT5hQ3CRqFkPtPrgdxnXun?=
 =?us-ascii?Q?wTfEJtXjJ+qrjbEsQTABtLXvZ5MBtFGI+hImDuDv0j577VyN54UwO25bbSPp?=
 =?us-ascii?Q?pkBCujFXaBWk0vB0MPt0PWjTouoD2KcHKQbOZwMge/dWaaETriTxaG+JsOsr?=
 =?us-ascii?Q?iFpT+/dtYiHfrIxmdGm7HdekDX5oIyaTcm015g5DZpEyDcfB7rZm5bI6JUSi?=
 =?us-ascii?Q?sO9oPKkoG0OZ5Gg=3D?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 09:31:32.9781 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2470fbb4-00b5-46f4-1be5-08dd4b4809c7
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3FB.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1PPFF5609832D
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

This serie of patches adds a new tool to authenticate files signed
with a preload header.
This tool is also used in the tests to actually verify the
authenticity of the file signed with such a preload header.

Paul HENRYS (6):
  rsa: Add rsa_verify_openssl() to use openssl for host builds
  image: Add an inline declaration of unmap_sysmem()
  boot: Add support of the pre-load signature for host tools
  tools: Add preload_check_sign to authenticate images with a pre-load
  configs: Enable the pre-load signature in tools-only_defconfig
  binman: Authenticate the image when testing the preload signature

 boot/image-pre-load.c        |  57 ++++++++++++-
 configs/tools-only_defconfig |   3 +-
 include/image.h              |  18 ++++
 lib/rsa/rsa-verify.c         |   5 ++
 tools/.gitignore             |   1 +
 tools/Kconfig                |   5 ++
 tools/Makefile               |   5 ++
 tools/binman/ftest.py        |  15 ++++
 tools/image-host.c           | 141 ++++++++++++++++++++++++++++++
 tools/mkimage.h              |   4 +
 tools/preload_check_sign.c   | 161 +++++++++++++++++++++++++++++++++++
 11 files changed, 412 insertions(+), 3 deletions(-)
 create mode 100644 tools/preload_check_sign.c

-- 
2.43.0

