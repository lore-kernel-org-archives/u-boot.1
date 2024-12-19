Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39F08E77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 04:39:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 064248021D;
	Thu, 19 Dec 2024 05:39:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="awqP/9FL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E68580241; Thu, 19 Dec 2024 05:39:42 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::605])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C12E78021A
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 05:39:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H66rbWponV3mJkvEYv2YAEURC/9Z1n5L/w+Bf2DPhlwPwHEJ96OT0EVUWMnQ91/cu/asGB+LEthkQUkp905Hggb9AfO5pInFV7wHH5Gt2CmoHX0/icMZAfLNFTitktcIj10sM+zdTBEvQEDuOr6bnNXaDyOQ10NXuon99Tgc3ZF072zKZ8RLKtgTDpqD/28cxG9NYk1Seg7gMONqw37tc4wrDoUMC/8CEiaZ2oOsbCeOL2fNkVu+3KzR5E4+DVeUnOndCuFtRabfmDotnjLlYmyM3kv8A7WehET0zakLjjp/qF5Ae+HY/zEwIkqRqAflfoBRWMIQr6D97DoxyBYRlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oFO/kqLuNnl+vxUrPmdyolfIGujGF4HNdQazFQRtOJ8=;
 b=JkuKbc7AHTh5yWqqqQsk00k3JUBM/2uP9tfQFGnApfWHUogj6yk72MYkta2HFCNnwQ6OYT0Wvdgr7D2D1vTjYs+P+mEBQEw/pXqxgSRfi5wyGU6QWFicof6TZvsWJGSFP69JpuFMweWK3+sk2CvX2NJHIdh4p9D4pWZBiRrZMoBt13G3fwcN5iHc+L0Lg7fTFlWloxKuhWw6joJJm3W1qVEQvMii5l756311HMrMDA8yj1ZHo4eQprKVl7p24RSZfQwmKx94jAw9RrSumB3PzPq9GllEeMiCW8RqBtYP799FeMb37LjfrEtzCU3no7JFKKcz5QL5XWg07ESWJUjloQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oFO/kqLuNnl+vxUrPmdyolfIGujGF4HNdQazFQRtOJ8=;
 b=awqP/9FLOWg6EEqYn/QcrKS45Db1we43cWfKUrVcQDrPqbCIFWIKGj2wv3LofEPuWm9yq5AAyPRn7BiV2cViJ6awVyqq6XG4dYRQlgp0Vlilv1ILPNhNKq75GB67ip3+tLXoP6XI+q4z7dn9Q+0Ep7fBkHvOW/KsYROCP4n6LC8=
Received: from BY1P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::9)
 by CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Thu, 19 Dec
 2024 04:39:36 +0000
Received: from SJ5PEPF00000208.namprd05.prod.outlook.com
 (2603:10b6:a03:59d:cafe::82) by BY1P220CA0014.outlook.office365.com
 (2603:10b6:a03:59d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.25 via Frontend Transport; Thu,
 19 Dec 2024 04:39:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF00000208.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Thu, 19 Dec 2024 04:39:35 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Dec
 2024 22:39:34 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Dec
 2024 22:39:33 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 18 Dec 2024 22:39:30 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <trini@konsulko.com>, <sjg@chromium.org>,
 <jens.wiklander@linaro.org>, <ilias.apalodimas@linaro.org>,
 <xypron.glpk@gmx.de>, <jerome.forissier@linaro.org>,
 <mkorpershoek@baylibre.com>, <akashi.tkhro@gmail.com>,
 <francis.laniel@amarulasolutions.com>, <ddrokosov@salutedevices.com>,
 <git@amd.com>
Subject: [PATCH v6 0/2] cmd: Add support for optee commands.
Date: Thu, 19 Dec 2024 10:09:16 +0530
Message-ID: <20241219043918.1646095-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000208:EE_|CH2PR12MB4133:EE_
X-MS-Office365-Filtering-Correlation-Id: 341c85ee-77ba-4875-03db-08dd1fe72415
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kMeWdhhbbiqe3tlPlNCJB2NKhpdupOgpnwcxSH/wy3z5k4u/GPOPXPDrSmME?=
 =?us-ascii?Q?OyySnbQ646SGLBST8hEyLo945E7pjfN/B1IkjNayaGB3IQ2gaAnU+WJYgNap?=
 =?us-ascii?Q?qVH8GH+6qaRp07bwUE6O2LjcIxVIivpCnH6Sw6e2nl6JwhUmKz2s0BYZNOiW?=
 =?us-ascii?Q?i04O77rdj6Xk0MymBnvYtGujkX1yMW7t0IvSpJi2pzjec8gdk05kIWQ3qzjT?=
 =?us-ascii?Q?GMSSBEXBuj2Ubzfww8xkzvyMNTR3micA7QwybTx/0e4/T67ecFFDbey6wmuG?=
 =?us-ascii?Q?RamduHPH/4T0g9oHtA9Knhx+nolwAwn1kj+49iLP7nunwB66RYCTGJcO6o8i?=
 =?us-ascii?Q?u0E2ECGcubTFMROjM9ysZW7qWOGNJzXLGDPbmkGO0nLgpdML3bnbYE3XpP8c?=
 =?us-ascii?Q?LMBqtgFml/20/kg4qbIxyJ824/XRkcG6PuYOLkYdnsi+FV9Zx+SOId2GklX/?=
 =?us-ascii?Q?Ew/0EptBXEb8BsemO0GObheMnXyyM5zRRrUkrgJYR/ieyN2ccUGhx7gwROHw?=
 =?us-ascii?Q?pq5HUSfa8RcoWXl22JoWZ8wt602jLISzPRL3IuEA5UMzP+GvswYzjdVmnTL+?=
 =?us-ascii?Q?3ZpN5BWORnsA75oLDrA8AzW4BEDKJzlJ/6eppIRIHf6edCmUhih7IHKQbMK/?=
 =?us-ascii?Q?5FaflpZ9p28j721+DVGX7gNxllYlSeCMvhDMGzWahznwUPZ+CXly3PgECBou?=
 =?us-ascii?Q?9USWse3CwhnYhZ086kK+LdL8eYLzhbHHlOg+DDaujBPnJe4a0Yl1JYkKwCul?=
 =?us-ascii?Q?EuiQDQlX2ijJmu1zSDfZ98pNIjuJPny7lkWLxPcUmXwHFG4JbmLUDSgEU1jL?=
 =?us-ascii?Q?r8NBncV+W2UN+OZhjiiDSh/odNjSe/U4xm5mpTM1Bkj4pZ3hkLPkL92zjmLi?=
 =?us-ascii?Q?n3bQdGIZeoN2wcDhmR8l0vjXWaDi+3oCnpy4fVjSNZVBf760KbjZv8O5hXRk?=
 =?us-ascii?Q?V8ubDUA3llg/T/b9XuY9KYRihiy604Lv2+rZHfMA5ELfW/w3Rhczh/uZxSrE?=
 =?us-ascii?Q?9cZ1VyrUzukfguGa6MNG1SuM+sVWgBy7NfIoJTxQmMX0NZH1P1GQ9m28lkVe?=
 =?us-ascii?Q?QEFrbmGKF/KY1v+ZiFIj0Pd10QQCy3OOP+GbaXOF4anrn101kP2iMVLsqrAl?=
 =?us-ascii?Q?skrz7FYbwdngW6HJg6r0d0DmDDR6gtfxJR/YWTdEvbUR6azMsVwdxOAYG2Bd?=
 =?us-ascii?Q?i2qxrwZQqYhYnttzSC0W7t9AF4UZEmk03etbaXL2HZ/sqxRfGFevdgDl9fdD?=
 =?us-ascii?Q?AAX7ZZs1VMBCJnmLYDNmjQZtHjqoGCvKZZHRi9Kg0CrY8JI/IVyt8ZdZ3EA7?=
 =?us-ascii?Q?Op0KHA4AQ8nfI/9l62BRlx5yGFkiQgES83frxjRJntApopKXGH+QA43VFC/a?=
 =?us-ascii?Q?dsz3ZWDRO0WYtoms5Ug8RTC4+FsHBMUmYMbKDOpT2xc1wy1PcsEALnE36TyN?=
 =?us-ascii?Q?V21AtSEEmYfZ4CmhNTuzQ8xXaLzW0l5Pg/tbq+PqG166O5WHI12qBHGSwDe7?=
 =?us-ascii?Q?YLDSzq8xkqkll44=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 04:39:35.8023 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 341c85ee-77ba-4875-03db-08dd1fe72415
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4133
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
Changes in v5:
- Updated the printf statements.
- Fixed the description for doc usage.
Changes in v6:
- Updated the command help.
- Fixed the typo in the optee doc.

Venkatesh Yadav Abbarapu (2):
  cmd: Add support for optee commands
  doc: man-page for optee commands

 cmd/Kconfig             |  6 ++++
 cmd/Makefile            |  1 +
 cmd/optee.c             | 70 +++++++++++++++++++++++++++++++++++++++++
 doc/usage/cmd/optee.rst | 70 +++++++++++++++++++++++++++++++++++++++++
 doc/usage/index.rst     |  1 +
 5 files changed, 148 insertions(+)
 create mode 100644 cmd/optee.c
 create mode 100644 doc/usage/cmd/optee.rst

-- 
2.34.1

