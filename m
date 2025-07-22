Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E1CC83F25
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 11:04:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74E4D8382A;
	Tue, 22 Jul 2025 13:04:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sBvFSsj3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC98B83817; Tue, 22 Jul 2025 13:04:12 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::631])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 624C183253
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 13:04:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KqhgkMdPsxPEqNVTMHy7Vusp61ptFDsV+cwmmSjDOdo/tgPbflIHd9WROlEEq3zza2iCld2wJHr1PvYh8XVJcyONFyEIURMtt99tSauJNN9mP6A61GInLLSHP38FNQ0zIrqcbTl5tsrg6iRcxliknquAnPGiOZ0h/KkgxHHLw95yKjtJ4TB3PqUCf6eOo2FPaeRcVsXGmJtcB1g1n7h0l51BcXqFVEK/NoJDR5BhF5Hs6Qo9q1UfcynqzAYM22M6nKyjQKG37pJnroxUhxGn4wVR3w+6v2VFTqEWKzudD41ICqXaKIgxUUBmG1GmX2C1vwZkgmXfCI6fuE/DEPbhZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P/qvtNFiWqHhoTI7MALApeGcjG8//lcGqpzS8f2CLbQ=;
 b=bjCQgUOpd96Lwkv4KUy7bCwxxTRhzz1JBIq2umR1MmDrhO6r7VpSPNx+Em398v3YzG9lVexBd3FAej/Pb788VdWsDzzIlSrh2VwzHji1A4fsRfC66C4NM/Bya14wiswZ/+fXTmquwjm2ltFKoMfSHS/9Qep8Mz/bwpx4Dv9NjSyac0mao88xSLlwDbZcnppDwryBqoYBTnniFmnG+FLrHTnXTq/dmLMkWzmrVO5OBwx9jzPlECr7J6UIIcOgf3wIFBBrpcrC9Kyam+zAMtqz7Qub4Q62mzWFR9VOUGvfWGQniwR8D9NeiDXckKvEM6G+2JHlCAHCDe4pD6/qj64zMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/qvtNFiWqHhoTI7MALApeGcjG8//lcGqpzS8f2CLbQ=;
 b=sBvFSsj3UQjCz0JDbNmpQpzJgou4v6QI/w1GYiNH+k6KH7GPX+SlmqSChhlA3xQ9KABtvuhRLRWTogPF7FlITiClhGyYhDGkS2uv+3/gJLSOqx3SKXFqP+OfZNjvF1EqfFZ+mnnSRHvLzUjmvwg5nJAKiIxZkviU0h3z0Lx3unM=
Received: from DS7PR03CA0050.namprd03.prod.outlook.com (2603:10b6:5:3b5::25)
 by DM4PR12MB5843.namprd12.prod.outlook.com (2603:10b6:8:66::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 11:04:06 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:5:3b5:cafe::48) by DS7PR03CA0050.outlook.office365.com
 (2603:10b6:5:3b5::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.23 via Frontend Transport; Tue,
 22 Jul 2025 11:04:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 11:04:06 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 06:04:00 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 06:03:58 -0500
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Jul 2025 06:03:58 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Conor Dooley
 <conor.dooley@microchip.com>, Eric Schikschneit
 <eric.schikschneit@novatechautomation.com>, Hal Feng
 <hal.feng@starfivetech.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Junhui
 Liu <junhui.liu@pigmoral.tech>, Kongyang Liu <seashell11234455@gmail.com>,
 Leo <ycliang@andestech.com>, Marek Vasut <marex@denx.de>, Padmarao Begari
 <padmarao.begari@amd.com>, Rick Chen <rick@andestech.com>, Simon Glass
 <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH 0/4] xilinx: mbv: Prepare MBV for CI
Date: Tue, 22 Jul 2025 13:03:42 +0200
Message-ID: <cover.1753182218.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1168; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=cPeLf9TnkiDtv/A470xCEG1Lj9Ed2non4kzJA4o3uGg=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWTUFwhIrFGxu3g3SEjStt03/kb/LcaENPNvwktuit119
 r2iItHZUcrCIMbBICumyDKdScdhzbdrS8WWR+bDzGFlAhnCwMUpABOpO8Dwv8pixxl1zoUvT2z5
 cvVAmtQvw9VtknxmdVHOH7XrLtkvXs7I8Nw54kewbsGrE6Hzdi5+tzX1pXQ1ZzxTYjS/3/kNy86
 7MQEA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|DM4PR12MB5843:EE_
X-MS-Office365-Filtering-Correlation-Id: 91ed6b25-70c2-462a-dc6e-08ddc90f79d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|7416014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uQ0UJtqeAcbvoePAQo9uTcKUxA0PmqZ1L0TCdvtDS3hCQdXYfWx5NEZp1owI?=
 =?us-ascii?Q?UQ1/AUY10zcLRW1PMNOoRt+Ckbq/Cn0CWJcH+vy5oyOzv+dzSzAVQ+qcAth1?=
 =?us-ascii?Q?gOnBRA8JPELs2+/BQd+cJ7YHjLi+dkWveWPwNWw/Shv2YYe+/sRRs4VJ56TR?=
 =?us-ascii?Q?9e70bBPrQwU4ZSMVvy/BqIaXOXpLGvdI4AuNcFOAPd1q5bXFOuiTTi6IkvVV?=
 =?us-ascii?Q?06iQmEz7zPbug1Nbin70lgrbD5hJJMLtquMAZpLFvJsORdZ6jsmg814Lwg3A?=
 =?us-ascii?Q?5kBf4CjKMwhkneQE8bsApyu2LuIqOOyErUH9gCx0Uy4CpazaMV7Mhwaju1gR?=
 =?us-ascii?Q?qZwUarcASm4aTij+GamN4LQgXu8+nAT8uTb509id/ukafyGZ6ElJy5OENlek?=
 =?us-ascii?Q?bAW3RjIOfloG4QRQ9LsN+yB/xQYMKc+JmIObBUUeKvScv4wCyUEAkHYrw5kk?=
 =?us-ascii?Q?y4+4AXk4MPVLX8MM/g/OoUMokN7Vyw/G/t/kB+wOUGIca+xpubujeLHoFRkl?=
 =?us-ascii?Q?phLpwoouYupuKfdvrze3kejRJzNmHV1wNXUMKDsnlRCE9BOjSJf7e8KzNiUw?=
 =?us-ascii?Q?UQzgLk3Fuyxqf2IOR3R8eMZSxaXexr1E4IqkzUooTTQRCcG/Cct+7RLlPpJf?=
 =?us-ascii?Q?QkX+mGKLSCLuC6HJp/bGG+IpdRAsI4e8NHQld2FWdYPZep2Roi02YgbwZSVw?=
 =?us-ascii?Q?x3ogpuIhdVeQUUrW++QbPoABp4X1IdAVblCcVmeOlu/ziGverfSZ7MjIcO88?=
 =?us-ascii?Q?J0s6RrMxt3ko7jxJ7aBcuyCzRRUb1DplHNGTQDBocxXsR9g3HN8RYu8LsuS5?=
 =?us-ascii?Q?hMepILLRCmU2/mCjwwX957nTq7O8qIt8YQf90+Q1neboK7c16zKh3a+SPxeN?=
 =?us-ascii?Q?VDT9IPIUXXbSop4dqhhCede7F8Clx+76JihbKcYJK/IWLN95r2Nd0eI+55vp?=
 =?us-ascii?Q?N0opqI5aecozsIBMoY3CTF8xKUhhhrlPbowr8KdWLvoby0ypj7wke2KAahQh?=
 =?us-ascii?Q?rkdQ7GM7fIhSlM8aNQU5wKGmtYnHYDc7U2/vcoHFBbeBE5gmGHSxwx3TkkgW?=
 =?us-ascii?Q?84a/p95/ODS16vjjqys9KF8sfY+/SBzZ822JhwOAZ2tZZaqeuGpgFaqvRCeA?=
 =?us-ascii?Q?0lsvPT9aAIwlNBlIHGaQF3FnkVamjeweaV9Dp1WTvFdwHFt7H5JM0dohUd4T?=
 =?us-ascii?Q?p7II6hLZtTEYHFTfjWzY5jaYo2MQjKy2mxFs8/q+2x8xqpkGK3gPh4e3X7fb?=
 =?us-ascii?Q?Sx41MkIN6yfDz8HFotJqrVxypCpE0rdgDqAeLmqIOWWOrrPs47TefkqyjaFY?=
 =?us-ascii?Q?s892H3Q/S7iBlxoe3pI8INqMg6ENTVsquMQhcGDC2THJzWg5AS0JUfp9qoY4?=
 =?us-ascii?Q?gUVXpLija32UDP/lE5SBFPolLQiIIfkjBnHO8PJPYUUCpwnJbtoeo3OaHj1F?=
 =?us-ascii?Q?kB4GeFPzpJLsL6GigMCL+mCix51nYNfIBDcvLss1kZW9eF+STxdYTb8y/MqA?=
 =?us-ascii?Q?o4jI374S75zsn8RnuJjE4a3r3V5sWRVFCegAwCC8+UB0T7a78Xh0atFB0w?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 11:04:06.1670 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91ed6b25-70c2-462a-dc6e-08ddc90f79d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5843
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

this patch series is fixing issues reported by dt-schema and all 4
combinations are tested on Qemu to be able to wire them in CI.
U-Boot hooks changes are sent here
https://lore.kernel.org/r/82725079ee90362468fe8096db24ef2959725af9.1753181505.git.michal.simek@amd.com

Thanks,
Michal


Michal Simek (4):
  xilinx: mbv: Disable OF_HAS_PRIOR_STAGE
  xilinx: mbv: Add missing mmu-type cpu property
  xilinx: mbv: Fix dt properties in interrupt controller node
  xilinx: mbv: Use separate DTB for binman nodes

 arch/riscv/dts/Makefile              |  1 +
 arch/riscv/dts/xilinx-binman.dts     | 12 ++++++++++++
 arch/riscv/dts/xilinx-mbv32.dts      |  8 ++++----
 arch/riscv/dts/xilinx-mbv64.dts      |  8 ++++----
 board/xilinx/mbv/Kconfig             |  1 -
 configs/xilinx_mbv32_defconfig       |  1 +
 configs/xilinx_mbv32_smode_defconfig |  1 +
 configs/xilinx_mbv64_defconfig       |  1 +
 configs/xilinx_mbv64_smode_defconfig |  1 +
 9 files changed, 25 insertions(+), 9 deletions(-)
 create mode 100644 arch/riscv/dts/xilinx-binman.dts

-- 
2.43.0

base-commit: 063b2e618afb05a32d66218f3631a5f23b30ea3e
branch: debian-sent3
