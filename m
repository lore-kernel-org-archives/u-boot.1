Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99480E7716A
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 03:59:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE1B8801CF;
	Tue, 17 Dec 2024 04:59:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zizOOtRv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A961800D2; Tue, 17 Dec 2024 04:59:35 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::60b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6769800D2
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 04:59:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F84RVJBC3Nf41jqFsHMRAh2V7u0GnIXyheEGH2VCBAVVdmSFnbIRMZPDiMeq8f3xOVuNiOaCWuX0TZzpSeGdXqjI7Qdy0KjDAcMdm1pd2YRVtRgUA6sqDDvZf6pDDY2kUtXCwbFjeFUzEsUhCXooq7C1w+xPTA/FSMILGA9xdu+KP5Pl6GRGjuu5SYQu7VIB7tIzePfuFpambCasQZamYFJWloWY6nVqyE/G/1HHnUWxSXTz1tAqXsYkFamnhgDoamRWGdXhhk+DXQSEex12Wl+4kVF4/pSY8j5fONJCRaO+YTrujLkKs0QnlQ7Sk6DndVxF/0OB9NYPSTqDUtrz8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sKjCJA8S/gkFoY2KiSNdwvw88wG2bZKd3y9Guybfqzs=;
 b=ve27ae7r1tSnGgkf6Znk3gtP8og3lkOg0A19AfrgT8hM+NYDMkx8cHtHQwIdbrmC7pn/qzBAZR3cIr8qN/MyrXO4KFZoh0nC5LtTcV1r59/aV5AXbCZotpuM/WAnUkvalFKUnxNOYe7n9u6Sh6NLMcMO4lpp1HGxT/AFvrG4Vrv9TUks2LdYGw+8s5sdqHIq+sXkTWsgDOld3xCUi84G3veVXQYpcNP9SJkb9UtuqwpzF4zKDc8GqDezrExpVQuOT2UF/O0T7P0BdW0mNB8VfHxx3WjemFbVgjzZ6x0xhS7uF9mJ3e4CH3WCsQFLaKfF7eM8Ndzm5mtFyOleavDTeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sKjCJA8S/gkFoY2KiSNdwvw88wG2bZKd3y9Guybfqzs=;
 b=zizOOtRvlDW1kGrrfY8sWkZDa5Wx/hRAwqlEn+W5bZUHPJbJ0h0tD/H0No31lVn8ChDOtbBi5/ZrgKafDshqzt4ABOnLdCwdS8g6Qz9n3cfhsv0zaMlWcRosVVsGTEPXv0mdFo1lPiHuBYcQPBHubIOhV29gAgUeGH369/Q1DLM=
Received: from DM6PR01CA0008.prod.exchangelabs.com (2603:10b6:5:296::13) by
 MN0PR12MB6222.namprd12.prod.outlook.com (2603:10b6:208:3c2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Tue, 17 Dec
 2024 03:59:29 +0000
Received: from DS3PEPF000099D6.namprd04.prod.outlook.com
 (2603:10b6:5:296:cafe::8f) by DM6PR01CA0008.outlook.office365.com
 (2603:10b6:5:296::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.22 via Frontend Transport; Tue,
 17 Dec 2024 03:59:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF000099D6.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Tue, 17 Dec 2024 03:59:28 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Dec
 2024 21:59:25 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Dec
 2024 21:59:24 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 16 Dec 2024 21:59:21 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <trini@konsulko.com>, <sjg@chromium.org>,
 <jens.wiklander@linaro.org>, <ilias.apalodimas@linaro.org>,
 <xypron.glpk@gmx.de>, <jerome.forissier@linaro.org>,
 <mkorpershoek@baylibre.com>, <akashi.tkhro@gmail.com>,
 <francis.laniel@amarulasolutions.com>, <ddrokosov@salutedevices.com>,
 <git@amd.com>
Subject: [PATCH v4 0/2] cmd: Add support for optee commands.
Date: Tue, 17 Dec 2024 09:29:12 +0530
Message-ID: <20241217035914.1297469-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D6:EE_|MN0PR12MB6222:EE_
X-MS-Office365-Filtering-Correlation-Id: a6007fff-a6af-41c7-a029-08dd1e4f348d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|7416014|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JK3Ms1WBBJpEZt679Wt387uqRPtwP0UzDG107WnR8h3Hbdsiq3hlY+Gi7xxn?=
 =?us-ascii?Q?kLOrsM0vPUtSb+NULJ4yF3eiK3CDCZSPAYMkGfzD74k6rIPGO4kd8Iq0mrTV?=
 =?us-ascii?Q?CwqBX3NlrmxyxZXhybU/QwYqQwhN9awj/heTGdXfOYLpybk/rdSBpUwhswld?=
 =?us-ascii?Q?nGdzEqtmTzRioBpSYj4ioHefWOCqUqE3k/uDYhcOUzKYzOqNpmDiHaur9uI9?=
 =?us-ascii?Q?bFrXia19HJDH6MhuFVm6Mttxs3lN7ipc1dhCXWnAgQWu3+Z4M0gXYMDLeGXy?=
 =?us-ascii?Q?likb9KJOUweIEEXqLO93m2lhJWHqcAba5uur1KZJ9GfDnj/MKHLCgwgWjOi7?=
 =?us-ascii?Q?q86M+0tAgagBGOLXevzlQoCVikzbE9UT9y0cBZkY35S9zkpB5fn+IwOtKmmg?=
 =?us-ascii?Q?QA+AAIZDi3/7PdNiH7+n/fpzQmTmhy9H1Ko8/4KhU6ayEeHWlonNU7Q49ugb?=
 =?us-ascii?Q?rP1QFQMUUz2faeaAqkbj3GPg9GjA3V3rVHQH1joZtETsb9f9iRJ+CJFumTHv?=
 =?us-ascii?Q?B5mQ920EVD6aMLwMhdUBTkF7lvUJOS1C4zZtCrEeW+FkxRNsmkrvhhplvT0b?=
 =?us-ascii?Q?6boJgCS6UNjfyd2RHwp6iaD7FPPq1tb/l5k4SLa1UwSVMuiW6nQGwJEgtii2?=
 =?us-ascii?Q?PIDnsfCWuQeO5PVXejjt1HtTQmZcnEtXIL8uPgswXjfauMnAVoHOClERGZhY?=
 =?us-ascii?Q?VpfBibpJuz/76STpGW/ALAMZzQUKtWZB4jAWiWXaG6dvHz8NIgcVUsMIGJAS?=
 =?us-ascii?Q?9ZaJeAeQ6P6CBJX4Hq8HeFhbpY9ElplTBdkN+WL4qaFi9QfmFrGcmXfb8sEp?=
 =?us-ascii?Q?n0usU7VxsC/w4wi64gX6l8ibKgfmZiWBQIRF/e06cEvV+a6BsXmYtXIhXoMB?=
 =?us-ascii?Q?eucKS8OtdbLMddvYLu75ihLcADxRChdwh4pHUxAidoOIM9Hd9a1qKH1wjVQi?=
 =?us-ascii?Q?Paxb+X7tl8NPhHJjGAfzT4al95AsJoC/pBonEwA8FqiUvhiebTvBENp2ffk5?=
 =?us-ascii?Q?5iZy0l+U9wCRVBDX/4FoEJc/kX9WWhHBDUkpzL/rtNqiT4q+DLb3t+be/H1v?=
 =?us-ascii?Q?7hmfo10VC/xcau23LD0OILnrEiYX7vqsxUybpQtGX2vp0Brm+7HZYp5px/OT?=
 =?us-ascii?Q?MXq5yhndKG+aBSJs0iag6ddT1YOFqE0C6sJi6ZZVCAiPom/PrsM0UYAsjoC/?=
 =?us-ascii?Q?Oac8FmzF22Y431pPBbGnh4pociCosc0fosmI6smBzFtoESmB+JcNGgxUB5ec?=
 =?us-ascii?Q?J9jpv6jMDfVnCY/9iZGbdMsq1a2Pdjs0u12s+fuqHF6JD91xarh3/q/cdU74?=
 =?us-ascii?Q?WyrGWK2M3hCMVyB+Vf6+SBg7emuHqkLvh/ROf2EFyma8t8McBOZwSUMs4cgD?=
 =?us-ascii?Q?45LjM0E4WJxhN24PwGgGwg2tcB/bMk25qa481fvkUVkD99V1F8SnRI99/+5Q?=
 =?us-ascii?Q?NJksZlRTqkdDbmaxVbjIaovwclQg8TKJmcrFCMJuQbKCQm1S987wzA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 03:59:28.8331 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6007fff-a6af-41c7-a029-08dd1e4f348d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6222
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

Add the basic 'hello world ta' command which increments the value passed.
This provides easy test for establishing a session with OP-TEE TA and verify.

It includes following subcommands:
optee hello
optee hello <value>; value to increment via OP-TEE HELLO WORLD TA.

Changes in v2:
- Added command "optee" and subdommand "hello".
- Update the man-page in doc/usage/cmd/optee.rst
Changes in v3:
- Rename the config from OPTEE_HELLO_WORLD_TA to CMD_OPTEE.
- Rename the file from optee_hello_world_ta.c to optee.c
- Add the hextoul from dectoul.
Changes in v4:
- Removed the hello_world_ta_open_session() and included in
the hello_world_ta() itself.


Venkatesh Yadav Abbarapu (2):
  cmd: Add support for optee commands
  doc: man-page for optee commands

 cmd/Kconfig             |  6 ++++
 cmd/Makefile            |  1 +
 cmd/optee.c             | 77 +++++++++++++++++++++++++++++++++++++++++
 doc/usage/cmd/optee.rst | 66 +++++++++++++++++++++++++++++++++++
 doc/usage/index.rst     |  1 +
 5 files changed, 151 insertions(+)
 create mode 100644 cmd/optee.c
 create mode 100644 doc/usage/cmd/optee.rst

-- 
2.34.1

