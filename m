Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C584C83F27
	for <u-boot@archiver.kernel.org>; Wed, 23 Jul 2025 03:07:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93BA4831C8;
	Wed, 23 Jul 2025 05:07:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="f2i/X5/5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D074D8329B; Wed, 23 Jul 2025 05:07:54 +0200 (CEST)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2409::622])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D1A583093
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 05:07:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=donalds@nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g2T/dQUiGKfNRyPxB1pJdNyjNaWjVms+/eby+9mHB6oLqyJ8nsnRs55cp0Z1rgnkCQWRA/w78UeG/SC9GnIfEKpYSadU3OhcSEuS+0GgXuayxxIaTI6m2MChSK4N3lY6PLmC8D7hwjv9ruq1mi5yRoMCj/GRnf/eiocz0Gh/OnTG7pKLeo30aumcr0TlYNcs8LWoLw3UXV3IhkTW4hkdJTtrUntDv/JSHQbXbFFnYLS5yzAF6u0JE+bQyywxHfvRP3pWP3xX/mxdUETXpFDXjsuh8YCyFI9bPp8oZfCly8dFaGGmSw1G0eW0HzTC5xcBxqomQ3m2kWhbnBG3wzHLHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7fbnsobRgwyaYIG9lcufUjKh+wqajCdxDxtft+iixxA=;
 b=X+F1jC0TLQRi66qLIIG5mJtY0tPdY76/UYOCEeD+w/TGprShJyjThkmNVwy6Pf9kQJZKqw9FO9ish89uGJw/voPcT1I54jOO5h++mofNw09aLnWwx9gDWWeHEE8VJeV2cRi8HJDt0KNQJcwymffS42FuxQDRJYPmY79T7gWS5ECD7mmJmFt2HPHNZBUpyyjduG1v2gifuQN5gbeVC1ggESCd2zaoMP8agSDp4tCWlQySKOQaqQ/DBUWC2wN7b9S0jhtJftVuRJFk0CVrZ7NjRQaUzcrkKSHIPbzfBaE3e6FOkNhJle0wRmfFC3Vxu1TZ1U4hP9SeLhYwl4yL+6h07g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=aribaud.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7fbnsobRgwyaYIG9lcufUjKh+wqajCdxDxtft+iixxA=;
 b=f2i/X5/5vsJUhrTQdTDAfvsTbUlVhuXP7PhkocrOgVIt/DZk3qUAtFyAhjCXcd1egjfJlzYkduthz8vRF5LzmI6zJJ1mklD5CER69/R1TKfP3/NTIY6RytqjpGyL1xdqWEU42fmQNWXxLrSvCc18SYlwUQawKVyIAPwGJ6uSNE7exgUA6A3mOx5eLArc9z+3bD5i9HXEF1sOnUhDjY7WNlZpcSrDt3PWsdB0dqnU3SBSX3dHqj5hbp+0i7OSgcmp4aokNbmLPSrE7yi5EroXoPzVRwc1l8P3GDDzNzR5uv0qLnzJ6Tp+YdmMAv0mSdvlsMesWtCB6+QuBLf7xuhD5A==
Received: from BY3PR10CA0020.namprd10.prod.outlook.com (2603:10b6:a03:255::25)
 by BN5PR12MB9461.namprd12.prod.outlook.com (2603:10b6:408:2a8::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Wed, 23 Jul
 2025 03:07:47 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:a03:255:cafe::a0) by BY3PR10CA0020.outlook.office365.com
 (2603:10b6:a03:255::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Wed,
 23 Jul 2025 03:07:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.20 via Frontend Transport; Wed, 23 Jul 2025 03:07:47 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 22 Jul
 2025 20:07:41 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 22 Jul 2025 20:07:41 -0700
Received: from dondevbox.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 22 Jul 2025 20:07:41 -0700
From: Donald Shannon <donalds@nvidia.com>
To: <albert.u.boot@aribaud.net>, <andrew@codeconstruct.com.au>,
 <thai@nvidia.com>, <donalds@nvidia.com>, <dkodihalli@nvidia.com>,
 <etanous@nvidia.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH v2 0/1] ARM: dts: aspeed: Add NVIDIA GB200 UT3.0b
Date: Tue, 22 Jul 2025 20:07:38 -0700
Message-ID: <20250723030739.51264-1-donalds@nvidia.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|BN5PR12MB9461:EE_
X-MS-Office365-Filtering-Correlation-Id: 74a210cb-c4b4-4d14-a6f1-08ddc99619fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KDQFFSXHZBPOtwFUk39EVeehSH5PXFienKh8258VhSwrMiNKpAMRR+YmTJ25?=
 =?us-ascii?Q?0apfTqopjyAPP3rnfyiq48OdMYv+wrKR3CgcPphI04/3xyTE06CLRqYziyrW?=
 =?us-ascii?Q?RyTjxzngtyBIaHDzwmRUKS9v/iPzhVKS9cR34G214Kspf0Ak22OJQYvHQuxM?=
 =?us-ascii?Q?D316o23RoE8tKnZAN+YsnG1xQ1ciU0tDjoIxVXe3xdEE5gf5aL3dufgF8Z10?=
 =?us-ascii?Q?D7W36CATDL730UzyQXWvbBh45+XQklZEEU9mGSyhgixA0+2CzAnqo0xcByAA?=
 =?us-ascii?Q?CCMkxfG3SC+gHWvy5bhJ6uh2604VjB0qmSlhuKiBrjvXoklOaL+6DbIyYjOV?=
 =?us-ascii?Q?PEXIfl4gchBqfJOgADc1uGuS62TaCVpdDNRZ/JMg9jzILxIqXaX/m1vopYze?=
 =?us-ascii?Q?AGzV85Ybu2gQI2NRLma/aUM1rkDKislELKDvn4vpBMzksKzzk4oWebNoJ76o?=
 =?us-ascii?Q?zMLBNtPAPtgjEIsEvmW2REfaFNlGsmQLT/BfeGfGefO5cJ8P8S0EFDfoOGsB?=
 =?us-ascii?Q?mzl3+fWNxSyp9oALqO6kGAct/gqadCttrfIQEQeZeS7dCzcuxXbbQhopQYmP?=
 =?us-ascii?Q?DAKitevNx9XR0VdYp4t+rnZN0P5PAJ1zYPzELudulvO8JTohuaUV7S8/H9HC?=
 =?us-ascii?Q?ZsaJBKceQgIELPwFMVg+P6LNECegDfNpJBJTqTuFHmHV0E/1P2us1lSKo25N?=
 =?us-ascii?Q?kzjZleFZ3lj3Fg9If/6INBppEY4WGcwXqJ+O69j8D0mUEUfOtHQAXJgvkVEc?=
 =?us-ascii?Q?QMfwOYkBMvd3JdTByyazjkY6/VKHW+2x13wq9PAVAq6j5dP00Ng9CaLUpLf9?=
 =?us-ascii?Q?lljcQye1LAL2zkd+aM3Nvjl4KGYsrTJT05m6r2NWbL1gAi0GO+paMJ3+pfio?=
 =?us-ascii?Q?wxRKJM3KbewWM17EjdJdbKyGwXFh9hwllOX3f5reTuVGHSQBrBuUeREKbtPC?=
 =?us-ascii?Q?WTSvMTuaApjBiQF1MHMaYqB6Hak8jEciihdk1ifFg7F2OnDy8uHkJY53qILM?=
 =?us-ascii?Q?j5N2M/cbzPoccVFkdSdHFoMN3CHLfGWMBQqSmTC1hT4etGIWahUxZwe8VmJY?=
 =?us-ascii?Q?swOa8rHq6/AFDg03KtQaoIFgmTPmij3fsO4J9mp2K9BiA7V1WTjAYHpzmPrG?=
 =?us-ascii?Q?cIci9Xn4JpMfvyjHzIVaAUzqn9cfc44R0yRp7UVJqWEgCLbAcVLmuiHWv860?=
 =?us-ascii?Q?FnqQQHA9Q/eAaNIBr1qRpfoKvnVI1lxCnFDhtIz0M27s0gP8oGfyKLo1MbJf?=
 =?us-ascii?Q?5Lx0h8pO/OCE6DPoAg7QNuOJFP2J19vjtmGpiJHqS+7mnvirCw+ctPQ5gQ0C?=
 =?us-ascii?Q?iHweZLWGvHjI3CwXFgxB7yZ4pnj4mm4/tzj0wsfB1xR9XJS6N9qyAr2HRXmN?=
 =?us-ascii?Q?pyBrXgJEK+xWsFDaqTcb/1PLFaD0ZWst2dIYdr3MBjWNeA1j3+PFBTbXyjsC?=
 =?us-ascii?Q?z3X+goSMZjeqNmjwDkQaKBFWbvhwomp/hQRWU+33qw1fh1zbA304Q5ixxcIM?=
 =?us-ascii?Q?/5zAK/J1wH6fheP9dW8DBERolUv0EMzOrJak?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 03:07:47.3370 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74a210cb-c4b4-4d14-a6f1-08ddc99619fb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9461
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

GB200 is an Aspeed 2600 based BMC+baseboard for NVIDIA's Blackwell GB200
platform.
UT3.0b is a unit tester variant that uses a different networking topology.

Reference to Ast2600 SOC [1].
Reference to Blackwell GB200NVL Platform [2].

Link: https://www.aspeedtech.com/server_ast2600/ [1]
Link: https://nvdam.widen.net/s/wwnsxrhm2w/blackwell-datasheet-3384703 [2]

Signed-off-by: Donald Shannon <donalds@nvidia.com>
---
Changes v1 -> v2:
  - Fixed whitespace issues

Donald Shannon (1):
  ARM: dts: aspeed: Add NVIDIA GB200 UT3.0b

 arch/arm/dts/Makefile                       |   1 +
 arch/arm/dts/ast2600-gb200-ut30b-nvidia.dts | 238 ++++++++++++++++++++
 2 files changed, 239 insertions(+)
 create mode 100644 arch/arm/dts/ast2600-gb200-ut30b-nvidia.dts


base-commit: 8e15f5c0b1e7b11296ae6c88b686e65d509237d0
-- 
2.43.0

