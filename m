Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 093B4C02185
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 13:08:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DEB6800B6;
	Mon, 20 Jan 2025 14:08:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bqOtf/BR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0624C80763; Mon, 20 Jan 2025 13:44:13 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::601])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 242B880077
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:44:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=ibai.erkiaga-elorza@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UymLtnlLx4VnFkb1js4FsOOd3zJmmom+RZptcAsp7Fj6xpbWicWW9TwBP1FcDDGG29I5vgnJmsgzT4bswMH+Za7ggRh5DsNEPvYa+ea7YwLKTNwWZwxax9IbXGBY+CEzamhKQO/Nl3xxVIzA68gmlJcImMTwpLA+LIWtSIWeU8oPzPg9rJ2DyZx0+IgtQ72fzoIHPq7MogdCo+gwjY4J2V1QIj1m5pbiJ4z4wdWDo/szhs+DX0OFlPt0YG7LpTZ8WyKBjFWNJXBW98v0y+q0o6hFyo57S/x4XkQvIfnYwuags7MWemGPlzpqS2LBxg53w1hhrMRyAj7gnCxtt6t9dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A81UX9mjUyyKf/L5v3qnpqJWI9yr23bk6o9VsGz6DRE=;
 b=s6xRissM1ACHwGBjn7k0BZxVpytJuOA/oVuSOo7y9n66QVpbUsZq+LWqtiMVihK+o3slyQzOBGSZQTWpxZ7KVIMZNIyUd83j6m92zSKXC9YoCU7MhbzXjhMJxBsNrh1u7SFVN2Eb5Ab/qIJE1AEnyB+5SsJXSrGLIHho/ErSHAv4EiLAg0hwAFGGRbwUUVmPaJ076pkFerRkQPwoOYZqGW0FTHP0ppFwrPiANhJUZuP7ANRVumei1wRjHu8cPD716K0FQvWZQ9LgaNaUN6NxljDhn9Dkh8u0j/t8788FDr+IjspcWpMcGyxO4GHwcOSVxO2dueAAXbFZc32Q/UFLWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A81UX9mjUyyKf/L5v3qnpqJWI9yr23bk6o9VsGz6DRE=;
 b=bqOtf/BR0YyXo8+4MOVCGEQdq2zk4nF3uRco3PUM9J70vVRQMtE4JU3i9e0WDuUNtj5sgezKDW2NwefY6bjbR3NODLtlZahILpsKplLUs5g/lkHn5aHsFQPiVfzcrUDFWOIhKu+Qm+OHS6hhcUugM1bxk2q+wW7UWmTKjtzinbA=
Received: from CH0PR03CA0035.namprd03.prod.outlook.com (2603:10b6:610:b3::10)
 by SJ2PR12MB8831.namprd12.prod.outlook.com (2603:10b6:a03:4d0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 12:44:06 +0000
Received: from CH3PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:610:b3:cafe::a) by CH0PR03CA0035.outlook.office365.com
 (2603:10b6:610:b3::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.22 via Frontend Transport; Mon,
 20 Jan 2025 12:44:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000009.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Mon, 20 Jan 2025 12:44:05 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 20 Jan
 2025 06:44:04 -0600
Received: from xirengwts04.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 20 Jan 2025 06:44:04 -0600
From: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>
To: <u-boot@lists.denx.de>
CC: <ada@thorsis.com>, Michal Simek <michal.simek@amd.com>, Ibai Erkiaga
 <ibai.erkiaga-elorza@amd.com>
Subject: [U-Boot][PATCH v4 0/5]   Improve fpga cmd usage information
Date: Mon, 20 Jan 2025 12:43:49 +0000
Message-ID: <20250120124402.1501320-1-ibai.erkiaga-elorza@amd.com>
X-Mailer: git-send-email 2.42.0.325.g3a06386e31
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: ibai.erkiaga-elorza@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000009:EE_|SJ2PR12MB8831:EE_
X-MS-Office365-Filtering-Correlation-Id: 50749d86-dfbe-48d7-2a61-08dd3950201c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GJi+EdmacSmWNe0EPnyCGdAEEW8XT2h1KD6WuBrmxL3kFgRfxTQ5yVH+IN1B?=
 =?us-ascii?Q?TuiDujchWi2/OPmEhiUkTsBmWWoOnXz+FGpjlwZi/sBZN/v8ucHLj5cKzvAU?=
 =?us-ascii?Q?h23ibd6nJaOwPylr/Z98vYn7T/iQvwXAfLNHby0egkJ69ow+Ndaj9q7ck7Rv?=
 =?us-ascii?Q?Zz4oW6xmTZmS6j4sahMtpjwhjQ1sWEuzqMRm1zc+GcVPLTLHyhQZBCBsvLvP?=
 =?us-ascii?Q?Ngv8/TRc+pWS2FZBbTXXEmWnR9PKXtRLo6qnIfoZPWa8Econ19w3fSiEN+DS?=
 =?us-ascii?Q?LZ0HQAfUWzo0TIUQ0CUELyJPPB9yjsgfpJzIXEE4MDFSQiuUgr+yRT1AyB4a?=
 =?us-ascii?Q?wsKpuauZL4RNl1s0hjus1wRtRIrAgzzbplIARR8NQ5XxcjaLAiSXQIEYPj4q?=
 =?us-ascii?Q?y4oQvqaJctyLiijL1rwKZwxHnF7lkT19/MPL/hY/8g1UEwQ7YvWOAWnwQ/6S?=
 =?us-ascii?Q?4PJmzq5myDMkFp+0xfQ7K96l1HvM52opCgGIEqN5GCaz4WF1QmFqU6yQbkzZ?=
 =?us-ascii?Q?7+hMizzYP20uOphymfGzQ1IsyRrjjvSZeKs3eQyq8PG1wSTyZWZtPOdW9LGa?=
 =?us-ascii?Q?RFq2Tgr31/FOC1pNpIaKXSu74WvOYUDMH/ZfTK4i1aVtzcEGx3XMXYJgNJP4?=
 =?us-ascii?Q?13YkreQSXcLO62k8haw4hisz1FUJkY/mZ5hpfFx7AjCy5nfvuZaM0LT23ZB0?=
 =?us-ascii?Q?1teBQZ95WGtaRm9pj7lZOKPHOcI+cW7F/cwpN5VJJ0y0XOlX7yd0LgJ4nZM1?=
 =?us-ascii?Q?BeLhSQhLES1uzJ6S8y7R3EIQr/3YFUiFTzo7dKeuGVg28VdaY5ZabCsh8uJ+?=
 =?us-ascii?Q?U4LrEi3SzD19C7rrRe9Empohl5PN0HhNgrsMaQuEURgWssL5vKiGaGsqK74c?=
 =?us-ascii?Q?wzCbfa3nNUZgiT9A/5v/hi3h6o56FzMO3JRCgkoYIQDuBFs17luz1t+BD35w?=
 =?us-ascii?Q?ArkcKgoEsy9985X4IiFEomfNsl8Vu9fQ3cj/NjYvEnS8QHt4a3hriCoJi735?=
 =?us-ascii?Q?Dl5BWnF6DClXaPMckLZx7JCfjXUNcIvjiZHnpLB5l7pXeFCKLJvS+ku7LY+T?=
 =?us-ascii?Q?KzoOZkhdHjZe+v9463xTLjb9ZzPnmWrHPncCPSO7ZeIIbDzsj0RCR+eEFxMF?=
 =?us-ascii?Q?iTziR9Q+DBZawMu1CFvFZS+CfZZqauICzH5m7zIKZxiYDOJHeGcpsV2j43QH?=
 =?us-ascii?Q?h+u+TglP78yF5I2415fJfizBmDIluAysaZKEHGmiiZEzm0RAmUwDQMMr8u3/?=
 =?us-ascii?Q?qkqbkbiwURXPKsxg/bABYwe+neRBqZ9ZfqckZ6/iT8FyeD/3B0PqzX6lyxym?=
 =?us-ascii?Q?utbpdPWLcjvYhbXZV6GRG/q7nlI5BwLczuE5cLYu5kiRoC8/c9mXrKfTuyzW?=
 =?us-ascii?Q?D00Y9OAwFYiZlHaD++fDYID4S4tKpXueNr4caAftVnIfiInQeIB9m4+IU+Wg?=
 =?us-ascii?Q?rdzIYupq3IYPhwDJl5rqYM2X8/HfJEM1FWVOm9dvXAZhuZeAGPd2nFOeRlrM?=
 =?us-ascii?Q?9s66HcXM1/4bliY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 12:44:05.4424 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50749d86-dfbe-48d7-2a61-08dd3950201c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8831
X-Mailman-Approved-At: Mon, 20 Jan 2025 14:08:43 +0100
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


  Current usage information is not read friendly specially when all the
  options are selected. This series fix some of the issues in the info,
  aligment and overlapping issues, excess of verbosity on the loads...

  Additionally Xilinx exclusive command dependencies are included to
  remove text stating Xilinx Only

  The output looks like this now:

  fpga - loadable FPGA image support

  Usage:
  fpga info   [dev]                  List known device information
  fpga dump   <dev> <address> <size> Load device to memory buffer
  fpga load   <dev> <address> <size> Load device from memory buffer
  fpga loadb  <dev> <address> <size> Load device from bitstream buffer
  fpga loadp  <dev> <address> <size> Load device from memory buffer
              with partial bitstream
  fpga loadbp <dev> <address> <size> Load device from bitstream buffer
               with partial bitstream
  fpga loadfs <dev> <address> <size> <blocksize> <interface> [<dev[:part]>] <filename>
              Load device from filesystem (FAT by default)
  fpga loadmk <dev> <address>        Load device generated with mkimage
              NOTE: loadmk operating on FIT must include subimage unit
              name in the form of addr:<subimg_uname>
  fpga loads  <dev> <address> <size> <authflag> <encflag> [Userkey address]
              Load device from memory buffer with secure bistream
              (authenticated/encrypted/both)
              -authflag: 0 for OCM, 1 for DDR, 2 for no authentication
              (specifies where to perform authentication)
              -encflag: 0 for device key, 1 for user key, 2 for no encryption
              -Userkey address: address where user key is stored
              NOTE: secure bitstream has to be created using Xilinx bootgen tool

Changes in v4:
- Split 4th patch into two, one for existing symbol dependencies and one
for the new symbol

Changes in v3:
- Split 3rd patch into two, resorting commands and Kconfig changes

Changes in v2:
- Tabs replaced by spaces
- fpga command added on each option similar to other commands like sf
- Dependencies to Xilinx only commands added in Kconfig

Ibai Erkiaga (5):
  fpga: fix alignment on fpga cmd usage info
  fpga: improve loads usage information
  fpga: resort fpga commands
  fpga: xilinx exclusive commands
  fpga: add new symbol for fpga_loadb

 cmd/Kconfig | 31 ++++++++++++++++-----------
 cmd/fpga.c  | 62 ++++++++++++++++++++++++-----------------------------
 2 files changed, 47 insertions(+), 46 deletions(-)

-- 
2.42.0.325.g3a06386e31

