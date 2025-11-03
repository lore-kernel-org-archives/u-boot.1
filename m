Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8492FCCF9F8
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 07:10:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7D61838AE;
	Mon,  3 Nov 2025 08:10:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="SgCKesjE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD113838CE; Mon,  3 Nov 2025 08:10:52 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BFAF8331F
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 08:10:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y/GaLBwfNzbh5wcMDsOfVFkG5XSlKGnghv2kf9EJPNJHzt3P/CVkpXiqOY2/IuCx1/sIldV9ytow8viIz7sDnxEv2PnN7Ny+UoOeektB1Rdt+mXCl02CP/t90qTWgBKz0XLm01At91uGNYcY07QzntyIqykmPrXMShahTYxzZdBlLLF8ki5CA/eHq4bb3e2Z0VXCtYx+mcmFmprk4ivVFMAq+wIwAhEpzHE24wkNE/aL4qi/M9OacvGzncYiih0z/iZajEAuZ/BSfM6mcULJVDtGlDpeoUwmH5Ds0CqnnJkXXLJPBi5XqnM56BrIETasnfUbjYMiGlQ9e7nzExlB0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DLPaOHkEN3dTvjYic8ZSjpipVmTA8HEiwg4A/73weqo=;
 b=Gd6ZnW4O4MClcou1mmngphqiTLsW2hScFxtn5Y68tyl75Y8o3cfAEbN/N0Ti4w2h6DLArz7IL0gQmP6Dfy1YyTAZhOXmhr1XVoxCM5yt4uCcezpR6wIXZjtFoIxJ5Xrlpcz9sy3GWEt7dm+5kcr55u6Nf4QBiHlp4Bp+RPqPxdMJL8gmqpH1n7k86dylvxkLCxQ/XgKZ9WDTRfkMsYLdN/I12//jYAcAJ3Swwp4zTVYj+tNtZXpNTp3nVTVkg1CeOP3OJF6M74Ms5oNHfFLzSYZtRhk5lNJzX3IBTEkQcOkUChwZ9B+trwaAtZt1L5rACe4q7P88TECPNm43fGvNBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLPaOHkEN3dTvjYic8ZSjpipVmTA8HEiwg4A/73weqo=;
 b=SgCKesjE//G6wzXYBbbzMuSEIySg6Qj4jjG3G4EEUbGhVOIdBYhgJAlEzdRbItbO3aXPYyIBecfpDcx3EXoYD9Yh+rxwdSH50IVV8PfOWh1HqA4CNNCVyjrbGEjVOKsNGm5bu4/2QvlyjGwjU9lCGTRLmBkvAK8aA3TH9ubY+o4=
Received: from DS7P220CA0069.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:224::35) by
 PH0PR10MB4565.namprd10.prod.outlook.com (2603:10b6:510:31::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.15; Mon, 3 Nov 2025 07:10:47 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:8:224:cafe::3e) by DS7P220CA0069.outlook.office365.com
 (2603:10b6:8:224::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Mon,
 3 Nov 2025 07:10:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Mon, 3 Nov 2025 07:10:45 +0000
Received: from DFLE210.ent.ti.com (10.64.6.68) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 01:10:38 -0600
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 01:10:38 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 3 Nov 2025 01:10:38 -0600
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.235.200])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A37AZYt3684702;
 Mon, 3 Nov 2025 01:10:36 -0600
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>, <s-k6@ti.com>, <bb@ti.com>
CC: <m-chawdhry@ti.com>, <u-boot@lists.denx.de>, <u-kumar1@ti.com>,
 <gehariprasath@ti.com>, <n-francis@ti.com>
Subject: [PATCH v2 0/7] ti: j7: Update to v0.12.0 of DDR config tool
Date: Mon, 3 Nov 2025 12:40:28 +0530
Message-ID: <20251103071035.674604-1-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|PH0PR10MB4565:EE_
X-MS-Office365-Filtering-Correlation-Id: a2716c38-3a93-4cc8-c693-08de1aa81bac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024|34020700016; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xDwR4LvnpKYI7JYa+564wf8V7B5YY59XeuvjmOwJHn3XcPhN/zZTVXaiTcIy?=
 =?us-ascii?Q?oNH7bAkncYvTcw1fESY2rGP8gV/mrOMi2p/7Ncyhj9que+J/AnREA7bIqGKq?=
 =?us-ascii?Q?1WURONLZsND1eT93uQLETOiTC3v9FoLqFbiJmnEAQ6XWzub0qRAbR6GB8BKE?=
 =?us-ascii?Q?0lXoXpFug1g1GBUX5DxlwpDt+WdgWqLYLPTklJRKhvXKwb9Mtn2lzthT3yMM?=
 =?us-ascii?Q?q/rSQCfXzAM/4T+rgHOp3YznqIO5Qbz0LQvPFmYfnwgxKx7ADuuyKaLgP6uO?=
 =?us-ascii?Q?+UYJkBWwQIe8RfWriRAORGwMDtzJHxdtiIyAMSeiYDmGLvImLW65HjEh6X8e?=
 =?us-ascii?Q?vnWyLsgFL5xDlIMkWinx7rwUJXWpm7MWmLoI7VJQdygYGefNo/g74PNLiD+o?=
 =?us-ascii?Q?iKoKwllwclWMyxtmwseBVsH0kbM5S/TwfR0567AtMazRRMoSMvLpYQn2HrBr?=
 =?us-ascii?Q?govkaK2Jq6roTLGmHFRKPaci3tazVEWEm45fzHji4dI0aQzx2Rf/S3k8cZQ+?=
 =?us-ascii?Q?pO60NCtKOoU9R37uMVxhzzPb++K4BJoPF/GgheuZmjtvOR7MUdQ41cui4y+i?=
 =?us-ascii?Q?PS9EI2UJiKmpY+AAq5Koe/8C78tZ5hp1DkWVLHA1YMjuGb5MJ3vBpl+S2YXe?=
 =?us-ascii?Q?v940kja2W1x24sevZKQjATFP6kl19K33x6GNleaNQDigjwwxMLkBNeoRPQd0?=
 =?us-ascii?Q?tyL4bvQm+ZNuj54mzs3L96h9hmpJvaGD3zdUdXTvOQtlPq5mwN3ll96P8X6y?=
 =?us-ascii?Q?4hxzmYsKT6zz8Lxks4d7LhVglYAJls2HJq/VEXy1OzQ4msdCNWx6VLNmZykL?=
 =?us-ascii?Q?HsinluadQcHyLkQ8jHR8Ou7EdGwSVS4jjvbL7KS4lfkso+/qFYSd5iFnTghx?=
 =?us-ascii?Q?uTR4Y9q+y85lE0Cu5u1emQ/rwiy/E5KNomCsXRynE0CtZzKbGulwStih4cT8?=
 =?us-ascii?Q?9W2UAI/vGzKhgoRyvcY4B3MbZSpuL81rMFhZIz8o1YCivJOFMzt1JbVru/ld?=
 =?us-ascii?Q?G0GID4KnehkTc8jxw+FLyxUU7L3PSjOOrO+2GJVFeHhhydS4kgNpgJu1wZGm?=
 =?us-ascii?Q?7Y1P5HXwvWOCznMnv5mtSeYtJH8dhDsvl1ILCizlqZA8R8UIHKd1rKv6cJw7?=
 =?us-ascii?Q?ni1kz6W5z98if6kBDift8sinZQqQS+GjUxva7QwQLpR5zPGswfu8+ZSI1t5I?=
 =?us-ascii?Q?kOKp+8G3rR+xVf8MPZVsVizlPGej1QZsIkNY0nZ4dbMqb8CREr2Ue+QL33ZJ?=
 =?us-ascii?Q?Ge8mtLj01IFHAdxU6f3b/7cHnjEENEpPBikbxDvFeq88+zn+ovEDdadBEXCy?=
 =?us-ascii?Q?xZRwwCLV06jgzS1HVfb5Tt6nHyKxGLNhYJf7WdBq+DOQrKeHeQnnoaRnvIbC?=
 =?us-ascii?Q?40GJHuuvDkZ+uC2E5potVs9VLu0oMTFZOZijZDp+BPjCcWS7ZGAptaOVD2R3?=
 =?us-ascii?Q?q0QjW6JBad/4oWVw9ppIhv4U1tOjwb957Mv5dOIlvK2Wd2oyDPnnQV9pvAng?=
 =?us-ascii?Q?b8RKV0uxhPVNbRHxWLdjPmXnzXucxcXr5ofKz7g/trwogvBRgcuS5DNnU9oU?=
 =?us-ascii?Q?huAhL9DI4RcRZN2wBD8=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(34020700016);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 07:10:45.3870 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2716c38-3a93-4cc8-c693-08de1aa81bac
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4565
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

Update all DDR configuration DTSIs to the latest auto-generated output of
the Sysconfig Tool (DDR Configuration for TDA4x, DRA8x, AM67x, AM68x,
AM69x (0.12.00.0000)) [0]

The auto-generated files must not be modified, but effort will be taken to
change the tool output to adhere to the latest checkpatch.pl rules. J722S
and J721E will also be updated in a subsequent series.

All the changes have been kernel boot tested and memtester has passed (same
as v1, as no functional changes made).

[0] https://dev.ti.com/sysconfig/#/start

Changes since v1:
https://lore.kernel.org/u-boot/20251031053425.3960963-1-n-francis@ti.com/
- Remove old config file (Bryan)
- Add patch (7/7) for DDR configuration documentation (Tom)

Neha Malcom Francis (7):
  arm: dts: k3-j7200: ddr: Update to v0.12.0 of DDR config tool
  arm: dts: k3-j721s2: ddr: Update to v0.12.0 of DDR config tool
  arm: dts: k3-am68: ddr: Update to v0.12.0 of DDR config tool
  arm: dts: k3-j784s4: ddr: Update to v0.12.0 of DDR config tool
  arm: dts: k3-am69: ddr: Update to v0.12.0 of DDR config tool
  arm: dts: k3-j742s2: ddr: Update to v0.12.0 of DDR config tool
  doc: ti: k3: Add section for DDR configuration

 arch/arm/dts/k3-am68-ddr-sk-lp4-4266.dtsi     | 4410 +++++++++
 arch/arm/dts/k3-am68-sk-r5-base-board.dts     |    2 +-
 arch/arm/dts/k3-am69-ddr-sk-lp4-4266.dtsi     | 8786 +++++++++++++++++
 arch/arm/dts/k3-am69-r5-sk.dts                |    2 +-
 ...66.dtsi => k3-j7200-ddr-evm-lp4-3200.dtsi} |  563 +-
 .../arm/dts/k3-j7200-r5-common-proc-board.dts |    2 +-
 arch/arm/dts/k3-j721s2-ddr-evm-lp4-4266.dtsi  |  591 +-
 arch/arm/dts/k3-j742s2-ddr-evm-lp4-4266.dtsi  | 4872 +--------
 arch/arm/dts/k3-j784s4-ddr-evm-lp4-4266.dtsi  |  653 +-
 doc/board/ti/k3.rst                           |   11 +
 10 files changed, 14408 insertions(+), 5484 deletions(-)
 create mode 100644 arch/arm/dts/k3-am68-ddr-sk-lp4-4266.dtsi
 create mode 100644 arch/arm/dts/k3-am69-ddr-sk-lp4-4266.dtsi
 rename arch/arm/dts/{k3-j7200-ddr-evm-lp4-2666.dtsi => k3-j7200-ddr-evm-lp4-3200.dtsi} (87%)

-- 
2.34.1

