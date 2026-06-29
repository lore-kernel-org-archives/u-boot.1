Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43699C43327
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 09:46:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8600B849EE;
	Mon, 29 Jun 2026 11:46:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pq7M2wCb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87067849EF; Mon, 29 Jun 2026 11:46:51 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9136849E5
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 11:46:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kGAh4Ec8kf0dFEUyFdGrsy51L+eadtiL7xHA3sYMQsjFUORNEFViWuIWoqxmLSET4cfwhPVMmqJpNmnSalBMFeT/I6oLybz8YzIvADb41bqAHK51Qd2Wqs/lP8EgamIzAF47pW9Ta7FmgBiJiJCN7Aq3CDqUQKEL8cZGM0qStce6i1fmGmB6WwE5Cw7RJMoOCUjbKqu9mlOQcKKgRRAlHtSzkml5nf1qii3G4rdxzIVQXUgrd2ZFeZJXEI/EyUuibuxD+rGvdh4x0WivxMObnq+k0Px6v8AhdyBobyjcJmpL1ld4rfLKuev2Hm4PcOX6bzrGpzxdZ1tg90n26C2jwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYAn8gj4CUZNACk/vvBc4raU9pKxsz3d5ypHgxU9gXE=;
 b=Y2XvD0ysupSpMSmTVaqsZ412Ofv4bYhuE1UBRAB4J6n+8rx0T6phhq760I6By+5WE17tuNZb7bhCCuQrMM5YWsUikP4uTdcjFo1NbpbWczWPgOU7dTem5H7AptuDhDQdgIkCohZ1VLB+8GGeJeh9JqDPc6vOaQZWxnwdqohHwfIFZffmFLErO0ifCM7pW582HvQUQoDWh89EdhSrV3kOTzkt1Gi6Bwoqby4DNerU7iDm3iB85R0zCLD5UGIqpG0LXmgINXZrm0/qQ36jkIH5+rEKwTaLwBhUbetJ1gn09EsTWSfoCSH4QdsqbWP5t36OAgOOUA6mW3LrYYXxWruMBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYAn8gj4CUZNACk/vvBc4raU9pKxsz3d5ypHgxU9gXE=;
 b=pq7M2wCb7F/rk63wGRDPps2Sse36197UjYaO+X0tjDlSg6F8IA7SVLDDayjB3AWhwofN/kp9NRZbJzk7TK2awTkpCAe3S/CFOA92gKCmW5wAZ9AoSnoCxNE1AR5YrS531vwN5HJC9CHbzNyxnj8mhIWfruMK9zv/ExJZi6VHNGI=
Received: from CH3P221CA0010.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::15)
 by IA1PR12MB8540.namprd12.prod.outlook.com (2603:10b6:208:454::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 09:46:43 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:1e7:cafe::4a) by CH3P221CA0010.outlook.office365.com
 (2603:10b6:610:1e7::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 09:46:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 09:46:43 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 04:46:43 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 04:46:42 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Mon, 29 Jun 2026 04:46:41 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Harini T <harini.t@amd.com>, Neal Frager <neal.frager@amd.com>, "Nithish
 Kumar Naroju" <nithishkumar.naroju@amd.com>, Quanyang Wang
 <quanyang.wang@windriver.com>, Radhey Shyam Pandey
 <radhey.shyam.pandey@amd.com>, "Rob Herring (Arm)" <robh@kernel.org>, "Rohit
 Visavalia" <rohit.visavalia@amd.com>, Shaikh Mohammed Suhan
 <suhan.sm@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/4] arm64: zynqmp: DT updates
Date: Mon, 29 Jun 2026 11:46:32 +0200
Message-ID: <cover.1782726386.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1714; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=FHqWuJyt1oJq0FioM3CZ6uyST23IUQ3gvckPI59DP+A=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQ52f3xXM3vMJXZ/b7ew7UyL4KTuzPtnQOUmlTS3jz+v
 qfltPDTjlIWBjEOBlkxRZbpTDoOa75dWyq2PDIfZg4rE8gQBi5OAZjI5+sM/0vZlWv4+qcsFnVT
 uz6V1TBjE/ssVYMt5XeefXXfNt/Wz4fhn05K0ePYLse8Jr2lpjnhDrVlp0VfaSUm/tcR3z/z9J4
 GFgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|IA1PR12MB8540:EE_
X-MS-Office365-Filtering-Correlation-Id: f0c68003-a4de-413b-f337-08ded5c353e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|23010399003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: V1OttAum3xm1El+mc/kqT3g9gGJWF6Ntg2tR0h6vTW2B5zbaEvx5XFY8jEB2V3d/wu23Gn3DZLWuoX7D9FSCO1Fqigi+moSef2NwzWAKb4dPdtuyEpvDWrXhnmIj/jtNhHnWoyT72wSj0ATnppGS7uvf4RQNSTl+BkUgtJ+/j6jZ/Mbph7I3ogy561qcgqNukRnLSX6wj/rMkRkzqGcae0BPZDkEK2yfGhWGZmtt5goLHkiSSEYhbmKLMdC2bnIg1K/vOzvvzhkuDCFDqArtekVUl8TV3sDPUeVa481tD6koFnWolDyaqhHNzS7UCblGswzAXzJ1isSyZPjuAVSt75NC+Jy4CdWIUdMy7C3IoMiLElMIEkJ2VyoJaMu83CR2PzQvinpCT6l0kGdrvdwrPbatDqlIsTO6Rwf8IwrtIK181QoBM0J5Z4nnoAtatEbOIkOz6KZiVpOULEbNcLddN/qROQFMgVAIaXRvdmD5lCcUjY+h4SU74SA/uauQD48kj6deSALnhVvhxGfUSasuiYDujFmpJsqUealPR89L/Z6XtL7GNv+vq/teKDGDt9MOiu5n139w8Z7JSPg2s4atXEtJahyMBabTSC7XcLNpjd23SowBe/ralUH0xsEguO+6exZbonjwZCzSBgBzfCmGmrm+XiDxayEhSvvqSxcMCqg61GhrSrsWAbIIA/AFru8UZ/9AzI5PgomnBGQCOz1vxg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(23010399003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GKmnnWZLcaiGPU3HCoUIwfq102W1ImgOTQDp4KgoYk2hWS/6jCc0463m/FcGwVBcOyNxqKzI8n4GuL9/DVFuOiL4plel9pjSeyWRcZfNPQ5P/TdjkaVin3HanKMODu3bXF2FzLD792vTu7x/qxNd7jJqbIoGjbWJ9hO/Oh3rbesCIajQTx5ZSvTejZlooOpQ70exbD9ig7tWDI9KQQXeAw1ltkTp5rT0jRlgu8s6Y1SvkKkLkyme5u5YZskhDbdCMTpCGtzo7WpiCJV26dg60cmCt6i3IHQrJRQOL18ry/H90LpFEXLppl1qtYr8SYJ4AmaVHZbcFxjkk1fEg2erC/EBWbJ2M6HZpctfc/czMIRGCrR/NLJaxhTNCkGopn26GXCUmFYAj41E+A8Y82NnZs/2bujNM7zmIVpneJ1dIXGd0z3HzUrk9BWqYXm8Hlwd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 09:46:43.5627 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0c68003-a4de-413b-f337-08ded5c353e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8540
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

sending some patches to integrated the latest DT updates for ZynqMP SOC.

Thanks,
Michal


Harini T (1):
  arch: arm: dts: Add RTC clock nodes for ZynqMP platform

Michal Simek (3):
  arm64: zynqmp: Disable ina226 iio-hwmon nodes
  arm64: xilinx: Add missing newline in kr260-revA
  arm: dts: zynqmp: Fix space indentation to use tabs

 arch/arm/dts/zynqmp-clk-ccf.dtsi              | 15 ++++++-
 arch/arm/dts/zynqmp-e-a2197-00-revA.dts       | 20 ++++++++++
 arch/arm/dts/zynqmp-g-a2197-00-revA.dts       |  6 +++
 arch/arm/dts/zynqmp-m-a2197-01-revA.dts       |  6 +++
 arch/arm/dts/zynqmp-m-a2197-02-revA.dts       |  5 +++
 arch/arm/dts/zynqmp-m-a2197-03-revA.dts       |  5 +++
 .../arm/dts/zynqmp-sc-vm-p-m1369-00-revA.dtso | 20 +++++++++-
 .../arm/dts/zynqmp-sc-vn-p-b2197-00-revA.dtso | 16 ++++++++
 arch/arm/dts/zynqmp-sck-kr-g-revA.dtso        |  1 +
 arch/arm/dts/zynqmp-sck-kv-g-revA.dtso        | 40 +++++++++----------
 arch/arm/dts/zynqmp-zcu100-revC.dts           |  2 +
 arch/arm/dts/zynqmp-zcu102-revA.dts           | 18 +++++++++
 arch/arm/dts/zynqmp-zcu104-revC.dts           |  1 +
 arch/arm/dts/zynqmp-zcu106-revA.dts           | 18 +++++++++
 arch/arm/dts/zynqmp-zcu111-revA.dts           | 14 +++++++
 arch/arm/dts/zynqmp-zcu208-revA.dts           | 14 +++++++
 arch/arm/dts/zynqmp-zcu216-revA.dts           | 14 +++++++
 arch/arm/dts/zynqmp-zcu670-revA.dts           | 14 +++++++
 arch/arm/dts/zynqmp-zcu670-revB.dts           | 14 +++++++
 arch/arm/dts/zynqmp.dtsi                      |  1 -
 20 files changed, 220 insertions(+), 24 deletions(-)

---
base-commit: 3819bbedb39a31a0f872540dac5ed6076d39c026
branch: debian-sent3

-- 
2.43.0

