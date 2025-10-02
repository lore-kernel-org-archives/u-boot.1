Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B173CCAC5B0
	for <u-boot@archiver.kernel.org>; Thu,  2 Oct 2025 13:05:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1934835AA;
	Thu,  2 Oct 2025 15:05:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="WTez32tP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 994598328F; Thu,  2 Oct 2025 15:05:11 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3262380107
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 15:05:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GTuh1zRatHGRCyTFSha4n/G0OXtb8xV5HZUUXR7naGVxBeLR8AzKav51Q7BQNsislCqibCiRZ8RNaHBwoae9lTU6geSehEemOdYpR9k5UrLQ+mI0cM8YaBrVzPku7KxWSzh38T585Ug/8Q8vF0+xmzu6YMaRy3UcJsWNX/zVKtlE4Cfc3TBazw+ghxoaGdD6a97YcQQTf//QUwDAXlQQJ1/TATTIP+DbMisTBfvtNCauG9VoFH2CCYKLVn7TFkxUcapCzKxh0JnFDEw/So444c4hxDzA8z3+Eyk2Eb7abwDuoQoKNK1lcEsxQ/1dUwkmyKx86C1q0YNl7wnxQeCXkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vjbSEyh+/7RD5lKyR+NdTKBzNDEwgTDcCSYShk+eB+Q=;
 b=E9JLTfs1IN8CGf1B3r85TLsruqgqmBW4BRz+jC5VxkFEcL27l9wNOP1nvsfcyqowV4tzdgDPcvQ8TnM2dm9IEbWKaFb9J6ot4VS8JxviaiWcdSho46qA54pROvbChWF7UbZaiJclfM8eGaaFijB6ddqbsqqncnUj7LdRLfWR+uSXRS4sij+RBzIruYf2jKD/2eTbmbgfhkYlxNvkdXCVK+DLsZjEMV9Cfm1KJGgd5+Awhw+0P3Dq8ZH5mi2bgfZwzPGzgnqzgMS5sV51Y8hTqkgmNKXI+pJRTSs3P22+21PCHb0RNv73jg44avYkBqBGB/jB3ufuH5mtT9lXW3r5bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vjbSEyh+/7RD5lKyR+NdTKBzNDEwgTDcCSYShk+eB+Q=;
 b=WTez32tP2RhZhJuS0c52AzbukG1RoQENd5g1QFc2DfE6uPQ8GjFRlOvSgeB88U2MufHb+buPwZgu6X63Tw4bzooOWuV2mP4FeE9VLyd5IJnyVVCXnaHrHlvoph+rnsccxQM9gJTbaGvs7/IG+kqsyUdiyWHwsUzqgLH5I4/QiX3b25HZrtn1H+hCOxtdfzVCawU//Bt0+i8PsCstpmmnT8d+0rnDfYncjs8Z2lA3W41x/zDBjBP1iRusf47QNQLzWwcoygNVChTY4YAjQrjKddQqLKn4c/emiBiDNnoWBsLmHd22CNJoK21T86GaODlSnF/RxJ/OSk7eZdrW7Mx0tg==
Received: from AM0PR08CA0033.eurprd08.prod.outlook.com (2603:10a6:208:d2::46)
 by GV1P195MB2551.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:1c5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 13:05:04 +0000
Received: from AMS1EPF00000048.eurprd04.prod.outlook.com
 (2603:10a6:208:d2:cafe::a4) by AM0PR08CA0033.outlook.office365.com
 (2603:10a6:208:d2::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.15 via Frontend Transport; Thu,
 2 Oct 2025 13:05:04 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 AMS1EPF00000048.mail.protection.outlook.com (10.167.16.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Thu, 2 Oct 2025 13:05:04 +0000
Received: from phytec.de (172.25.0.51) by Postix.phytec.de (172.25.0.11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Oct
 2025 15:05:03 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <trini@konsulko.com>, <afd@ti.com>, <n-francis@ti.com>, <s-k6@ti.com>,
 <bb@ti.com>, <ggiordano@phytec.com>, <b-padhi@ti.com>, <anshuld@ti.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: [PATCH 0/3] mach-k3: Rework spl/get_boot_device()
Date: Thu, 2 Oct 2025 15:04:52 +0200
Message-ID: <20251002130455.1795794-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000048:EE_|GV1P195MB2551:EE_
X-MS-Office365-Filtering-Correlation-Id: 12051506-a5a6-4a41-3599-08de01b44dca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/dx7Gq/9hCMDhgsYS1nrex1G3nMwsziEV9OqB3vD2tk7CIEnxtRTiu3j/tA6?=
 =?us-ascii?Q?8kG8++tT24QrjGbp44RkaOYMRxhP8NWzEDnQbj9mtOCC4ZNU1eWqtElMbA6k?=
 =?us-ascii?Q?kBr/+5mzbmJeSmxH8cfyBVoUWszQ5AKYv3fD1Ra3RcY5MSGlvsahkbf3G1QA?=
 =?us-ascii?Q?YEO+EMJ8SdPOQYBHpqVySRk9k8mZiTeKxDuKMykE/a2CThpOaLkxvNAkJjez?=
 =?us-ascii?Q?L4LnEJPjEwyOJr/pz02VE/IiBmQb2K/P1m37OorVGsQ+1lSeYnYTZdBTAc3/?=
 =?us-ascii?Q?BbUEqI1SbOVbGBo+klnQPjxy6ruOO2O92jAbnKrzDsvxwlIqdRtZmcGIcXSx?=
 =?us-ascii?Q?uxuQTdKMrbXgqYDY0F34K0evTT6EkgNQV1F1LZANZ3WoRZTpkwdDjPZbza/9?=
 =?us-ascii?Q?e2oBXGvolzWcd2SzcIh/cmFrSjZ6T0bOKW68uRknk0kDPAao+1bi8Sa2MhAq?=
 =?us-ascii?Q?rUVSnpoCrpN9BN8/x3lkIQuDI6F7x8vjtNAd3865WLmzv2Vr8iskDjYUWrIg?=
 =?us-ascii?Q?OEJOPQg/skKyNQRl9cdZyCRSs7B86hID6DlDmQzZn6IGQVBiAwyCu+BmRy+C?=
 =?us-ascii?Q?eAfDjRmaRSYdICTTp3ISZAnOiaOvEHlvolSm/8CwOCl23nSZ5m52moZgwh4E?=
 =?us-ascii?Q?3g2hR2YfcGHymOoBGvkI4WYh1DY+bQnjBem8J+APnVLUZpTevtvh3j5j3A0z?=
 =?us-ascii?Q?V9afPpflt2zMlZVBC/XNZu67H0FR54SLi0819otB9g+KPO4qsjMJoA44aiFM?=
 =?us-ascii?Q?CLUEBqJpcS3lWswTcnFPvRZHODGnJj3GvZ9YuT9PrOsJpH3LL5sV43Juqqek?=
 =?us-ascii?Q?s45cHqlfHKrBxvd1lEJf5eePSgwQOOCzEG4/z4wKVmx0c3jxGH65fLX2vX5z?=
 =?us-ascii?Q?hStl7+O/GPKat65mrntQA8fIJKzG03f0AK+sQ8EZf6ZwWIMGY4F0ukev9jWF?=
 =?us-ascii?Q?j7ehs2Aa6H24IP9qYScB/WERMBXIc/sce7Cd1P1jD1ISZpaS6Q4sab2amroQ?=
 =?us-ascii?Q?VrEbBjqOg7lVvRUD3j100IP04+cbAttJMLdQzicGVe/AvDg0iEZ7023ZTx5I?=
 =?us-ascii?Q?Qoiefo0/FWbIInvazip/34eK2WcNnUNpSExBbC2QMRTYxGfstreLhCH7/Nu+?=
 =?us-ascii?Q?dkir99pO0dIXe2sOQEcaAbtmgHVEYZ4FKDzVoJkx9UDg234fCXEP+8wPujht?=
 =?us-ascii?Q?HF3ihyVXFKXg8tawnKMTI7utdmbVZXvLho99IeGUELXQE0hZO4csdQaxFAk2?=
 =?us-ascii?Q?CivE2vyTjcwZphMYgWH0S98lXzUlV9xLj6lX+3ngjL7JwcI8VNkwrtOItgCh?=
 =?us-ascii?Q?u0QuRFVczqHeNI3wP2idEZoqVlTFqV9BmqHeie3cghjsm6jjLjZaV9fc8R7U?=
 =?us-ascii?Q?OlveliPtF9hmq/PuXo/4jtMzbHO290R0zxIH1VTQ82hBRbVSPEMiNfBJ3hff?=
 =?us-ascii?Q?4EnHOSSVWFGOIWjBNYFFHOWuKnUlJo4If8VpJrLWjsLOr91uZwU6gKEsNGIa?=
 =?us-ascii?Q?r1MNvFZqdihEXWFujCQCxUsyL+kYkRgwa069?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 13:05:04.3604 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12051506-a5a6-4a41-3599-08de01b44dca
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000048.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P195MB2551
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

This may need an rebase after the MMC macros fixup patch from Judith [1].
Also, if we want to extend it to all K3 SoCs, some of the Jacinto devices
would need an update of their DEVSTAT masks to be relativ to the
bootmode config.

RFC: https://lists.denx.de/pipermail/u-boot/2025-August/596543.html
v1:
  Update based on suggestions from Anshul:
  - Use k3_get_boot_device_info() to get rid of multiple extern variables
  - Implement k3_get_boot_device_info() for am62x/boot.c
  - Removed k3_boot_device_info[] array
  - Add info param to bootmedia functions
  - Apply to AM64x and AM62Ax

[1] https://lists.denx.de/pipermail/u-boot/2025-September/598239.html

Wadim Egorov (3):
  arm: mach-k3: Rework spl/get_boot_device()
  arm: mach-k3: am62ax: Switch to boot-device helper
  arm: mach-k3: am64x: Switch to boot-device helper

 arch/arm/mach-k3/Makefile                     |   2 +-
 arch/arm/mach-k3/am62ax/boot.c                | 141 ++++++------------
 arch/arm/mach-k3/am62x/boot.c                 | 141 ++++++------------
 arch/arm/mach-k3/am64x/boot.c                 | 139 +++++------------
 arch/arm/mach-k3/boot-device.c                |  90 +++++++++++
 arch/arm/mach-k3/boot-device.h                |  34 +++++
 arch/arm/mach-k3/include/mach/am62_hardware.h |   1 +
 7 files changed, 252 insertions(+), 296 deletions(-)
 create mode 100644 arch/arm/mach-k3/boot-device.c
 create mode 100644 arch/arm/mach-k3/boot-device.h

-- 
2.48.1

