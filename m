Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9CFBCA0FFE
	for <u-boot@archiver.kernel.org>; Tue,  2 Sep 2025 08:53:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1CE0831D3;
	Tue,  2 Sep 2025 10:53:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4fBwA1LI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8353283253; Tue,  2 Sep 2025 10:53:51 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::61a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B35CD82C7F
 for <u-boot@lists.denx.de>; Tue,  2 Sep 2025 10:53:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NlD9uPWyzwLR8JMO5k/lugWgk4mxJyMCSV3K2c5FriM75Vf3aPZ6FBAUZf02ZhxzZXugZrl6tsdP2/cmCKqCyhIbKBC5v/5Mk1axljZs81/UbzWcAnCr40dacX4J6QkccEJFLMVjSjvqu8Ljo+GG8BvP+twi+5ggm+cXmfzo/Po+JdpLWeF7M1qCKaND2nvqrszE7YiqUIhYYwF0tQFa5gAMDSgCx6a9DBcqHCRF6ohZSp8oe9BgIVdSXJ853DpC7xg0j/bACLurpwgWgxaFvIzFUGL3BwJzb1lUwBzA3NGAi7fng78SfFiI/QjNuz2p72xyX7K1wTfEQ01/JAcqKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3T+sqJQjYluzMdd2M5A2EoWhpTIHAVrjt5m87l9vSI=;
 b=Ux0eI2MmJbMQ22wh2v69ebJUsABl+EPEPIK8Vq6IJtpKS1TLmmYfMWfKKCp8wE+PK9BzOh7cV9fPJB9pG1ZCBxNwgd8zH1Vh5MDkHvqx7LfoG1YPaUO5/U1YLDpv6I8HBZnlwXbhy3HVp9oqF96fwHe9j9e3Eo4/hUapxHC8sagST/YyRA3t9rfD2pO1C9VYYpRT9OOJkwZlII7Ldxvo4EwlKRn4hRWcA+pdde0lWKnvFRDeedi1zoDotfwK6Hd1wQT7GDqFcv7afLfK8rZjw/9PhXuvXvNrZeTxwXhNxbKaPfvPCgX6Dc/RZQuyiR83/28upGj+Jcm7qV6NWprx+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3T+sqJQjYluzMdd2M5A2EoWhpTIHAVrjt5m87l9vSI=;
 b=4fBwA1LIPWf7yN+Ba7OglFevUwaNTQZOkFsbR1cL1/gkxvf2iotdgQkaIBeFEIdH3l7fmz5s7Js8aBLD/6d15QmLPguEh9Sw3KjoT6OQz3Fw8mfqOKYx42woOqto3Y5N6bjavfxDzEyKdypUzi7C/ctdRxJIYmmBH+HY2fM7XFc=
Received: from MW4PR04CA0090.namprd04.prod.outlook.com (2603:10b6:303:6b::35)
 by DM6PR12MB4219.namprd12.prod.outlook.com (2603:10b6:5:217::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 08:53:45 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:303:6b:cafe::81) by MW4PR04CA0090.outlook.office365.com
 (2603:10b6:303:6b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Tue,
 2 Sep 2025 08:53:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Tue, 2 Sep 2025 08:53:44 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Sep
 2025 03:53:43 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Tue, 2 Sep
 2025 01:53:43 -0700
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 2 Sep 2025 03:53:42 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Nithish Kumar Naroju <nithishkumar.naroju@amd.com>, Padmarao Begari
 <padmarao.begari@amd.com>, Paul Alvin <alvin.paulp@amd.com>, Quanyang Wang
 <quanyang.wang@windriver.com>, Radhey Shyam Pandey
 <radhey.shyam.pandey@amd.com>, Rohit Visavalia <rohit.visavalia@amd.com>,
 Srinivas Goud <srinivas.goud@amd.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH 00/12] arm64: zynqmp: DT synchronization
Date: Tue, 2 Sep 2025 10:53:22 +0200
Message-ID: <cover.1756803198.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2893; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=OqRaPx0o7mcNQ4H2EQ6G5bRyAQr3KdVxPz4HaHh53Zk=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRs29AmwXqjL55vH3+Pqx6P/D7WjbusxVkuL/t0Yfpqv
 S0qZ5gZO0pZGMQ4GGTFFFmmM+k4rPl2banY8sh8mDmsTCBDGLg4BWAimk2MDHMZl32IqPtTwsav
 0dPUu/Wa9wWxffPKWDY25sSu9ixwKWX4726t5VAhcoBbNOD+O2u/5IviFvO3LElk233omsRa07S
 vPAA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|DM6PR12MB4219:EE_
X-MS-Office365-Filtering-Correlation-Id: d2c2504d-d810-498d-9344-08dde9fe392e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AyYg0/bCHVz0ShPA7Om3LrJTL+0v3ijz0ckX47kMNINPVAaWGGEPEcPjcqQ2?=
 =?us-ascii?Q?nTOFr77WBmDHQ7qBHvRNHKvDHoKumQb8NYCAiFa2cn5fxECNv9sIsctBD44n?=
 =?us-ascii?Q?1KgPdyFjYkWeVrC3s/524c6pvS8q4yKSbLcYTcYUYf5X4IYb5YAatMmG/mu2?=
 =?us-ascii?Q?yZKYRyWyOBWjPaD914kUtV3tnB53uh+EX6b6DIP4J6kLm+aagM+PryuX6NDv?=
 =?us-ascii?Q?spqEgibJRXlpF+fjwE8OndFD443O7NfdZLpE27kJF1zCxIXBYPVt5kDj+qbR?=
 =?us-ascii?Q?aqYbO2o3ty52pciwxljSJcuzEnO+5wryZ8FkT6HOHhB1pEym/IIdvoHXcimG?=
 =?us-ascii?Q?BRPr7ko4a8gC32LU3iGhyp2T2mZvsZTAI1dWIfVDG4Rv5Up0GClxbrYb3fEn?=
 =?us-ascii?Q?srVFwHzWeNcEON2E7lkQm+jXqxgheQ0JGh2yvgiF9R3gNsOGEEbT2/MJqHM5?=
 =?us-ascii?Q?QXIwUDFvn/2gDmb32WqZAZ9tP5bxJXwSEsLupQSBoF975v39PWOibSlmSzqn?=
 =?us-ascii?Q?VmsgI/odxEsoJ5hQvCpDsK6QHC07O5y0+KQwASSfPc58+AeBkImcAOQJijnj?=
 =?us-ascii?Q?X9wd7DKxjwi4DTuqQ+VA2/DOFx9bzGvfrYko3Mn7s51RVGh2Z4xQYcemO8+s?=
 =?us-ascii?Q?oUdww82d0rWa2waHD/4Xwrk7GX3A5WfFUq/ye+C4tydO1XvqPhUR0zQxPa6Y?=
 =?us-ascii?Q?vcy26YLa9mN9iuoDi1O73WQw69e/pdntvfzEavec7r/bUUmQefq1fbVgQLiP?=
 =?us-ascii?Q?2pQpuEfrpWmZIJGQHG+bGG/GoqX65p/jpdi6w3+T9tl+KteXdDfJHhsaOHln?=
 =?us-ascii?Q?li2cPnRZl5n/geAHzex8pO5trZJDJwKQx1d2oAUtn8iQK6zAW+0ncvKMN8gs?=
 =?us-ascii?Q?JwC+6JYPG/w/xDpz3pVR5DsmUD0rSXkovh43eIqGX3rd8rqUwBp/rjGVzDB5?=
 =?us-ascii?Q?rz09ead37jlDS52uFqOBuKwxSZnkqaxl6znDOAg0XVoIEWxzVfwb+wmWhUfu?=
 =?us-ascii?Q?Sf/rd+nUYxbvd2D0RTjPKpIdNRpls7/AqIMKoifKMDxQtSDNM0j2Zunurowh?=
 =?us-ascii?Q?MUCtN9RqasPzAz0S98ZSDPbd+9aUQsQTuAJQgsWKB95D8k3iqdmiZVP4vj2s?=
 =?us-ascii?Q?NZ4R0AdOtD2oQnZPp38U08UKB/lNuAML0knwQjgSjDnx5kYkFOdM645glKF3?=
 =?us-ascii?Q?MA4r++4Lx38Fcu2TXDkp4MCMyLqxNBGJ10RH/u8yxIVUXyPaHzuSisFq3rNo?=
 =?us-ascii?Q?QjF6fHt8Iv2mypTYjPdTXy7omqxk5Ej/vGE2mV7ZDcgmiE6xfGFRPFtkUl53?=
 =?us-ascii?Q?OLuHT4i2OSw0jYcoo7UIdBLxKdTiE5E2jzIhJQ7LE6sBZb09RzzUxDjrPcdY?=
 =?us-ascii?Q?HTqnVV9rkXu9LnwtRfgetD2vCRosVJkz0y07fnmkwChZsnje4OziYzD6fsUd?=
 =?us-ascii?Q?gj69lR7LD0SsL7FRRThi2uCOi+x4pRWN4Tp2MjIUjp2Wo70bt7PlwIymcdSB?=
 =?us-ascii?Q?MlSPOtPU5pAqIZPYscsMe3aQWli8zP0av3I9?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 08:53:44.5456 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2c2504d-d810-498d-9344-08dde9fe392e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4219
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

here are couple of patches to sync DTs between our internal tree, upstream
Linux to be able to do switch to OF_UPSTREAM.
Last missing piece is around MTD partitions but some days ago parallel
spi configuration has been merged via mtd concat driver.

Thanks,
Michal


Michal Simek (9):
  arm64: zynqmp: Remove undocumented arasan,has-mdma property
  arm64: zynqmp: Remove RTC calibration from sm-k26
  arm64: zynqmp: Remove "ti,tps53679" property
  arm64: zynqmp: Fix incomplete comment in
    zynqmp-sc-vn-p-b2197-00-revA.dtso
  arm64: zynqmp: Enable PSCI 1.0
  arm64: zynqmp: Update compatible string for tps546X24
  arm64: zynqmp: Introduce DP port labels
  arm64: zynqmp: Enable DP for kr260, kv260, zcu100, zcu102, zcu104,
    zcu111
  arm64: zynqmp: Add pmw_fan label to k26

Padmarao Begari (1):
  arm64: xilinx: Add i2c mux idle disconnect property

Quanyang Wang (1):
  arm64: zynqmp: Disable coresight by default

Radhey Shyam Pandey (1):
  arm64: zynqmp: Revert usb node drive strength and slew rate for zcu106

 arch/arm/dts/zynqmp-g-a2197-00-revA.dts       |  2 +-
 arch/arm/dts/zynqmp-m-a2197-01-revA.dts       |  2 +-
 arch/arm/dts/zynqmp-m-a2197-02-revA.dts       |  2 +-
 arch/arm/dts/zynqmp-m-a2197-03-revA.dts       |  2 +-
 arch/arm/dts/zynqmp-mini-nand.dts             |  1 -
 arch/arm/dts/zynqmp-p-a2197-00-revA.dts       |  2 +-
 arch/arm/dts/zynqmp-sc-vek280-revA.dtso       |  1 +
 arch/arm/dts/zynqmp-sc-vhk158-revA.dtso       |  2 ++
 .../arm/dts/zynqmp-sc-vm-p-m1369-00-revA.dtso | 28 +++++++++----------
 .../arm/dts/zynqmp-sc-vn-p-b2197-00-revA.dtso | 16 +++++------
 arch/arm/dts/zynqmp-sc-vpk120-revB.dtso       |  2 ++
 arch/arm/dts/zynqmp-sc-vpk180-revA.dtso       |  1 +
 arch/arm/dts/zynqmp-sc-vpk180-revB.dtso       |  1 +
 arch/arm/dts/zynqmp-sck-kr-g-revA.dtso        | 17 +++++++++++
 arch/arm/dts/zynqmp-sck-kr-g-revB.dtso        | 10 +++----
 arch/arm/dts/zynqmp-sck-kv-g-revA.dtso        | 17 +++++++++++
 arch/arm/dts/zynqmp-sck-kv-g-revB.dtso        | 10 +++----
 arch/arm/dts/zynqmp-sm-k26-revA.dts           |  3 +-
 arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts    |  2 +-
 arch/arm/dts/zynqmp-zc1751-xm016-dc2.dts      |  1 -
 arch/arm/dts/zynqmp-zc1751-xm017-dc3.dts      |  1 -
 arch/arm/dts/zynqmp-zcu100-revC.dts           | 18 ++++++++++++
 arch/arm/dts/zynqmp-zcu102-revA.dts           | 18 ++++++++++++
 arch/arm/dts/zynqmp-zcu104-revA.dts           | 18 ++++++++++++
 arch/arm/dts/zynqmp-zcu104-revC.dts           | 18 ++++++++++++
 arch/arm/dts/zynqmp-zcu106-revA.dts           | 14 ++++------
 arch/arm/dts/zynqmp-zcu111-revA.dts           | 18 ++++++++++++
 arch/arm/dts/zynqmp.dtsi                      | 18 +++++++-----
 28 files changed, 185 insertions(+), 60 deletions(-)

-- 
2.43.0

base-commit: d66473aa7d0cfe053531d1aecdcf2deede58162b
branch: debian-sent3
