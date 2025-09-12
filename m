Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4018CAC582
	for <u-boot@archiver.kernel.org>; Fri, 12 Sep 2025 10:06:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC0C4833ED;
	Fri, 12 Sep 2025 12:05:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hQjqbQA8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31704833EC; Fri, 12 Sep 2025 12:05:57 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::610])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A707F83322
 for <u-boot@lists.denx.de>; Fri, 12 Sep 2025 12:05:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wStvNjYpz1bOQqq8YiQe9TDxnmQhsDuUUKISApK4+CZp1hf1yxa6cGnUZF/Ztd56uhr+lKYB7grBccJDu4bt2cgWnvML/MJH1b5BVHEJass3wq/FjzsMFDWrhsQ+6TmT0Pj/t+mZo1q9oX789HGziF30dYKQ9iJxmiB5U2TSiULAdaSP5TvwPNWotjN7s2fIzOo9nAAP/7DbeMeVOMRjedCRZzHZmw9fzhUuJA92AAfqaEBkS6K55AGckfeqJhIKzZ3Po3xssMoG7IZ0NAtmPG5td6yH8HBLgMTtbiGakdRePiioSDi3yuE69zIUIK1X2DPNWz4aoUXpKJkeDNojUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KlVAkqM7FZ+fsQyhvbQ+OPujyoU6jYOt5Q+mW5bUnSY=;
 b=Qwmx3Uf3mjlqQt1KYkSDbajR90kIWlSyU2D3hG5NYrXFr2wfUvRY9IYpo85qChHKwlg4gr0a+sZNpEqQtffJ45lJRTZhcCwXB7LRfY5YejTGkxZpGjeVqWiiq4b3Awwndz9cnlWeEK/NkaepJEePriJfaH1RA28ovQiuJzu1stEdwofDa5uPhg5BoKL0dotAosD76P375PmAR6fg7hxpQgnjOrE1DUsPVYnRNOQKIHQNl1mv+Y3VTYarRCy3/0T48UMzlUrFbhDe+jpAwRJObPXdND6QlfDwN4vJuyjFOTpjC6AUUbklGduf24YO9ymyXQVhgXhbb28p4bq96ggbaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KlVAkqM7FZ+fsQyhvbQ+OPujyoU6jYOt5Q+mW5bUnSY=;
 b=hQjqbQA8lSxN+efKtr+oRVVxTlxz2hy45o0MPZYExw146DPXJm1X89lKgEhJ24uYHMGVedjNL5eVquRP69sJcKcZF+nrGGY6Zvy/qewwu14a9pgxp6CYMw1g+Vl8tBN6blJfIVZFf1CYTyhJlk3q9Pegx2U6DdpfVFyNVfHQXfI=
Received: from BN0PR02CA0056.namprd02.prod.outlook.com (2603:10b6:408:e5::31)
 by BL1PR12MB5873.namprd12.prod.outlook.com (2603:10b6:208:395::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 10:05:49 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:408:e5:cafe::38) by BN0PR02CA0056.outlook.office365.com
 (2603:10b6:408:e5::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.16 via Frontend Transport; Fri,
 12 Sep 2025 10:05:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.0 via Frontend Transport; Fri, 12 Sep 2025 10:05:49 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Sep
 2025 03:05:48 -0700
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Fri, 12 Sep 2025 03:05:46 -0700
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>, <ilias.apalodimas@linaro.org>
Subject: [PATCH v4 0/2] xilinx: Update guid with fwu metadata
Date: Fri, 12 Sep 2025 15:35:37 +0530
Message-ID: <20250912100539.4127378-1-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.44.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|BL1PR12MB5873:EE_
X-MS-Office365-Filtering-Correlation-Id: f6fca938-3039-4b1d-18ad-08ddf1e3f328
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YDp4VoKVTvTaMnvAb/a0H4zoIJddznsA/o4Pzi8kgXffJUQyN5/rYgSw8puS?=
 =?us-ascii?Q?81mvxe7IM2BjnoBukfzSJwuNo9PSVczSpnDxBIHOEx0hqlRTc/pg9DfEFD8R?=
 =?us-ascii?Q?hdrV9yzbyKldTplhnL8ax5mGoeQ6XUhIh+7/xxMwwMzFOm+XhgmyRHPQKx4L?=
 =?us-ascii?Q?KCYQ6qtWfGsb12H85j+IHUuKSRGlmWx/S5cKxvk8Z/wI3H3eRtLgbfcY2Gwt?=
 =?us-ascii?Q?+Qzr2TeSwMLxBbU/vHZ4spfZyhFBjKXZEn13hxvLNA76ZGHXm33DK0Vx1M/v?=
 =?us-ascii?Q?ezgJgSDdnzeucoew3yMS03W0pVr/tQPBu21J3ofJsaKwO03IY5sQRWzp1Y3k?=
 =?us-ascii?Q?dY9XfW0cn0MCmGsEdxmk4a/yEqZhwab1xWBkWsI/OmFAOhczMDEy0bYHT2oT?=
 =?us-ascii?Q?SzwWmOgvO3rVwk7PR+VcmLtsbVdppGJ6GU2oVnbCbByeaQC+xvEJ2UZ6qL17?=
 =?us-ascii?Q?4C8s4WyFgM04gptH49Nu9CxqxBLVNrzB0ZrTTTK0/9OPwL5zAHyTZ9Av53Zp?=
 =?us-ascii?Q?s9XkWQnd2pPwKW6MiodNbJMzGEbtRBFB90BqnC1btg2QevTg0v1hOHLZyr62?=
 =?us-ascii?Q?9RGGpgdnr5pXXsIc4WSFUz5KGC4Rmd5UTPAj8JF8gfE6iSSrw9gojvyTJCU/?=
 =?us-ascii?Q?1hqyVDCijnjL0f0Vsv0VwnSHMzhWktaJs6ElSOomCyrBZyOoF9aRzdTz5n1a?=
 =?us-ascii?Q?q7QOnwMwRKfKDiq3KNnsk3KBCLvpfDkGf+VA4oRYeKL5XGIFOE4Yi1kFftlP?=
 =?us-ascii?Q?ces5JdIGDSohgG6iQXEyB8yIWxDG56myjVrQcOuCsA0uOqnjFzS2mFYatupG?=
 =?us-ascii?Q?Rrq+5EH0H31DS7qNoVFNGGjwQSbCBMEsWW9oo5sRnc91bh8FP/tdTy7iQHJ+?=
 =?us-ascii?Q?OWo8r3OJCOUzrcerasG9akfOjwPxNsNCzfmIfIy0DfoQ2/2PpH82m1v7Rk0i?=
 =?us-ascii?Q?1mvyHqWfj0Sk3ZVbF0otF18/ZbXn3VkBimMzxG2qU9SaC3UHOyXCsjnAo7eT?=
 =?us-ascii?Q?JJw23vu15brrNmWf1tqCxE1gZ81OQt6LRgh7tgYi2OgfXp+NGfv79kE2xOu9?=
 =?us-ascii?Q?rAlH/wkC611FcoGYOG3JNulK/xU4b9pa/6/8sKt2weBO6GYUzHVvFqBMR5vt?=
 =?us-ascii?Q?5yL+hrbKy6tdDQVgc+kTu+Lum/jvwJJNkldQQ1CCW1aGoDOnyu28/fn/2nO4?=
 =?us-ascii?Q?nRfckZGz6E+abnx2Ndv1yZnTsSa3/YpQOPFmy7RELH2nwiFctKy/T93RF3X0?=
 =?us-ascii?Q?k2AqvFmPFOtpsXg5gZccD6ejpiJZcI3V4eAk1smNP9zXXm2FrUy7qca0EGp5?=
 =?us-ascii?Q?3pV8ySRHv4i27Amj8Kh7l7NgIH8uqVJwuEtkjXWL2ObAqkFTDodm+Yt5kUlq?=
 =?us-ascii?Q?BxWvD9IrF6zZjkE1Q+w9S9q1C0Di/6INrjfAP2xlYY2/Tj4sTzCGjn3BrDs2?=
 =?us-ascii?Q?aSj9BSsGUPjau3ZLg7Lyc4pLiB6LthS4cUpzQhmB3zVLuKisImT7xUxamKxc?=
 =?us-ascii?Q?CrexViLLS535gINOdII956IGqfMqJWUPKL8k?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 10:05:49.5427 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6fca938-3039-4b1d-18ad-08ddf1e3f328
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5873
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

Introducing the fwu platform hook function from fwu
initialization to process fwu metadata information with
platform specific operation, and use image uuid(GUID)
from fwu metadata structure for fwu multi bank update.

Change in v4:
-Include fwu.h in board.c
-Rename fwu_mtd_platform_hook() to fwu_platform_hook()

Change in v3:
-Update Note in function
-Update function description
-Remove ENOSYS

Change in v2:
-Update commit message for FWU mdata
-Remove platform_hook() from driver, add weak and actual platform hook function

Padmarao Begari (2):
  FWU: Add platform hook support for fwu metata
  board: xilinx: update guid based on metadata

 board/xilinx/common/board.c | 27 +++++++++++++++++++++++++++
 include/fwu.h               | 11 +++++++++++
 lib/fwu_updates/fwu.c       | 18 ++++++++++++++++++
 3 files changed, 56 insertions(+)

-- 
2.44.1

