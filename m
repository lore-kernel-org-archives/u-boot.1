Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3061ED35660
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 00:55:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56E7584227;
	Wed, 28 Jan 2026 01:55:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Vgi1M9u5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7A2984228; Wed, 28 Jan 2026 01:55:02 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6188184164
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 01:55:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-bhagat@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ds9veqgPgTTfDbW5N/ByhKUb0FEBCWYsDiklHklr6b4kU3r9GdzcIa0EbNYndn6Z19RfZBNDYnKnS5bz3eAvZW+mqCTXp7i0Yw3b/7rOI2sZByB4HWKEK+JLnabsgplAV51Cdnc9SWeeNtSCff4r6AqkolivDKSY8XVP0OD+AKApqjp6e2POzcwQzdbebRCpEQa2jj0qEWGQZ19qCQuq7jhGYEgb1jkkEgftv8F6BoRGNN+BDUBOWn9jh3j8pENnpDTws7XePn9aVoIuFFeJnRZgvZ+5T6l0/WLb4oXTuRY7+hmkpWHxBL+WgkcM2bgrh/lTo0V0Ki6EmwlUl+2OSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oyrJgI1z6DeYPxzxtXXBgte9tNuClcGfmfKFXA5wWk0=;
 b=TzYWyQJwzvie8bO3haNGH45EoHUsQqyshoEE7Ati+HTcTorzOTMTQNDHBE/1AByjY0MuvGN6lRomYVDWlHevdusguziTumyboz/leTzyLPs5Lx6AT5mDeQx9+0YSL2M1CmyrCkMiRhgS6iLPewQs+HuHwFM+K0Puht4fdt+WyZTZOIPBhoEUGoriHCbK+hs9vdH52dO1kLf1/V1lClY5kJE41qReQ4EUnnGe9aLRxcAh/zonLBqxAWDy4Fqvssoir8vb73pygn6npWlzF3qymKafp3+b4Y5uMANp/14TWKoVY+rB2qmjvif1OuscL0GfQ8Bph0TqsL5hd6Rv0/Ap9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oyrJgI1z6DeYPxzxtXXBgte9tNuClcGfmfKFXA5wWk0=;
 b=Vgi1M9u5uxDiDAWBKCn6qn1rMJr14b+4jH8sdqpsd28hwuLc+uU0UH/r2vShUurMNI8RB0QwvK4NulGxF0tEUl1zs6ZcSbKA//OvMCIyH/VUUosZTxCw107yXlinwF+KZNn7niEP2BuN18tA/4w9oVfq9Te946fEGt9PckJwVLQ=
Received: from BL1PR13CA0229.namprd13.prod.outlook.com (2603:10b6:208:2bf::24)
 by SA3PR10MB7041.namprd10.prod.outlook.com (2603:10b6:806:320::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 00:54:57 +0000
Received: from BL02EPF00021F6B.namprd02.prod.outlook.com
 (2603:10b6:208:2bf:cafe::19) by BL1PR13CA0229.outlook.office365.com
 (2603:10b6:208:2bf::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Wed,
 28 Jan 2026 00:54:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL02EPF00021F6B.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 28 Jan 2026 00:54:56 +0000
Received: from DLEE209.ent.ti.com (157.170.170.98) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 18:54:56 -0600
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 18:54:56 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 27 Jan 2026 18:54:56 -0600
Received: from localhost (ula0502350.dhcp.ti.com [172.24.233.249])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60S0ssBc1068470;
 Tue, 27 Jan 2026 18:54:55 -0600
From: Paresh Bhagat <p-bhagat@ti.com>
To: <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <praneeth@ti.com>, <vigneshr@ti.com>, <bb@ti.com>, <afd@ti.com>,
 <m-chawdhry@ti.com>, <t-pratham@ti.com>, <nm@ti.com>, <v-singh1@ti.com>
Subject: [PATCH v2 0/1] arm: dts: k3-am62d-evm-binman updates
Date: Wed, 28 Jan 2026 06:24:52 +0530
Message-ID: <20260128005453.1387483-1-p-bhagat@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6B:EE_|SA3PR10MB7041:EE_
X-MS-Office365-Filtering-Correlation-Id: da9bc5cf-f1fb-4ac0-3f2f-08de5e07db3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DOUiibXuYf16AwBQTcgb8sj9hwdvttDZYET3Sag7EMmGjKoPWnNMD5lvOnoL?=
 =?us-ascii?Q?4443BqkQsdGm6rP9gu4cwjPHyt9jj5Sy+QTjGLTyP3PXwiWpeM82Mx+F2Ow9?=
 =?us-ascii?Q?NIkFotfLoO6jdNSeqTIH8iX9gcv7d/vvU+/rB3RTQmqKI5ol2s82tADb013M?=
 =?us-ascii?Q?PSkasKYO/2Lda57NKS+/GtfOSbap5FvPo/mUxnEZyR3JwyU3i9ph+AcYP/B2?=
 =?us-ascii?Q?i86W41cUpRegz7D4bzs9HL5JHXCA5hxH/uLXkxcN3BJ6zL8OYjkpKY9GtYF7?=
 =?us-ascii?Q?Q/h5MXQ57W3jTAwJm6wQ1cVJ1wlSJVt7xzbu2tqPo7kDVj9J8UR4kwXr6p1j?=
 =?us-ascii?Q?HnDte+8X/4EM/cItGjZb7b5YwERHV2ZShmHN0af+VRFNr6B4Dx4ZR2HI3qkO?=
 =?us-ascii?Q?aeS5JBuyGN2gTfRC4gV5Za0DgvR6G0uVHxb88vGxa/UDrEBZF3zjiakEAjlP?=
 =?us-ascii?Q?q0gQgVV4PnLBkuCQ/49Adt/UuKYBn7lxT2XnHck5F4qge9yiA70wAuL6n2+T?=
 =?us-ascii?Q?W43agspU73LOOT6v8n1Mq3Mh1S/sgq+p+asuA1yK8hyQy+F1fDIaeychJTwQ?=
 =?us-ascii?Q?yKb8QhK+HhEazCK700AsWP+DyTNP4MRwNVFZWbZ73v2honr98zbAMy9u/qxp?=
 =?us-ascii?Q?u16Ajmnq/e68LzK2eahR6D69fCb+k3MEhi1Y7P3VShoVnS9LOxK7fWiVFXqt?=
 =?us-ascii?Q?UE3oUTlzw6fjKzvRnhuEGrtzKOyt0pm5U6QvlZY9knv10pKlsMkpw+uPgOU/?=
 =?us-ascii?Q?5OyL8mH1OXEzI434YGBKuFpVh0kjDBTQpjNERa7I1w+slgV8dCkIEXJJdMC0?=
 =?us-ascii?Q?B/ei3huiIybk95W/lOwvEmhzUl1ZUnN3tf78EneUvFShRTWrpPJ/xwdeFaC/?=
 =?us-ascii?Q?cGy5ir/eBHaYFiXDeMmBLCcVOgT9miMDQqANVvFtLUTHdXqqbfwEex/SdaWF?=
 =?us-ascii?Q?i9WngOEXefEtzT6+3f/PbEz8t8MYOJEEbY2jHWT4yQgbsUnxyIN0zTgbgTkM?=
 =?us-ascii?Q?CuXnZlupbdp62X/786+47MQ1/ufGlqAMPA2pilB0TUo5nVJ6PgzkYTKNnE26?=
 =?us-ascii?Q?U791JkCsSpRiW11iYuuZ7rEL/VmaOFBWfwUo8igsvdVsDcHKCIPnR8Dgoz6C?=
 =?us-ascii?Q?U4iYKTSAg7hdnulAQZ/W/wyYPKFSE1UtKsBn6IcB5Fh+37AJ+CGAIIoRJask?=
 =?us-ascii?Q?81706QTZcMSLeMg+o7QyiRtXHd9BbhB7KM/b2rlfgukrpxScfurxbWmh4syU?=
 =?us-ascii?Q?2Jtt9gwo/FMbUFs9Ew/cYZVHHeE+34+VlIcbvTHOO1xVwvop2iAX/bO7U7R4?=
 =?us-ascii?Q?sWtxlqSoGHPX7f7p2Z+yZ21euOdcKmTBaIL2a6TkNqowQhumfB2rzwo9gUXs?=
 =?us-ascii?Q?tM1a0Dz9XYS5HDvkckAEpe57ngz1PW+LazYA8PUiZRHpm1xRrE2NPzxspdl6?=
 =?us-ascii?Q?RrGfy7VMwTWu8pJivB5V0Q+a/VLULHP5+XZe2E+j+PClIAdCDOdJTbsP7/YX?=
 =?us-ascii?Q?9S6Sf3gI7PAd7dtzHdvrNxpkGpaHybwPNSAZ/X68kF5EyPHeEWN9NH3aShQM?=
 =?us-ascii?Q?GkjZXMNwnbx+8il678VH2w3sO87gBtDUoJv5seFNyPqZA3HM0idx9Oe1VTJK?=
 =?us-ascii?Q?hknZ9e2028QCETiKDO5EGDE=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 00:54:56.7846 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da9bc5cf-f1fb-4ac0-3f2f-08de5e07db3a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7041
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

This patch series updates the AM62D EVM binman device tree configuration
by fixing references.

The series does the following:
- Corrects device tree reference to use AM62D-specific DTB instead of
  AM62A.

Change log:
	v1->v2: Drop patches to rename tiboot3 (Nacked)

v1-https://lore.kernel.org/all/20260116103010.3947922-1-p-bhagat@ti.com/
Boot logs-https://gist.github.com/paresh-bhagat12/0613a2df44cc5203c3c15df78dbebd83

Paresh Bhagat (1):
  arm: dts: k3-am62d-evm-binman: Fix device tree reference

 arch/arm/dts/k3-am62d-evm-binman.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

-- 
2.34.1

