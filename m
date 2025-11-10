Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E944CCFA13
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 09:42:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7743839D7;
	Mon, 10 Nov 2025 10:42:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="k0c+AHPj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58AE7839D7; Mon, 10 Nov 2025 10:42:01 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F68683966
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 10:41:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-salunke@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NhXwM/3Y0lM1j3i0I46/74HOXtEibozo8fBG01y9F91SyxOMCSC0I6lqAdjCRUnTRpydTRBODof/2yn4gK8DETqQ7ohOdADmL1YAZ2H62WjiBoFdaMVzdMqCsnZglWb+Y4KeZeAMfsPymruqldB+qIjwU72hRadhDEwbu3ssjKSkjWagx9M1IucoP2N1u1ASVnzZBoPAgxuqTPf8W6JhjLNm7hS97cC1tqNxSRMSrc/wAkzYXXIBM6n3UHIKtk5wKjL7+llrJJ+OMZ5VF9mm0adm5MIBVYrQC26wGeMH1tpM4NwqXeCdurXS86FdyjPX2zSZ5FB8oYdWzQXoB2WULQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dW1VrgL5z1LKEah4FvG8hBlp/X97ZVabXT9Oms+Xwxg=;
 b=tOPTSV6JtH+Cjcy9Rl8I7xVxCsH78kPYtMrNdEa92WKfdbvNp6v1aSuzsT2gT74MGf/TZg/DREF/Bpafezx3IDISyeNpfSmOmTjJwYYAdJkb9U5V1vnwLhkopqcEVO2IQ5trk2aHd0FhlnJoVkK4mbXFl/UrnP3b/F8pUeHbQsiYAYh9a05b3JxKu/8PZfjBiCtcdkIMqxt/xBvQ8GD3CDxPulAb8vmLz65LtGD03r9CqCa33ONqFYKjzypgRBWoJtXtS81t1qUA5FOU1aMQs0IZAsAZF0Zwk0VDSf96mY5xXS10mngZZlLnGX1+ZB1meu4e0OboX0LUOLS0V22NHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dW1VrgL5z1LKEah4FvG8hBlp/X97ZVabXT9Oms+Xwxg=;
 b=k0c+AHPjPTVSoaLFJCCQEwfxVCgXuC4tTe8adb0Sq/o9BUbqNt9wiqdYKp2f9sCFnrTiDN9/Mdh+YbJpCwzjcfif0SGU7fXuTPKuKkpa/KPtYRfvRtJRuEFOt7q9ix6CmwludDBVMop1BMW0NZ+/aOk31fD+LWHpMzea3KRpfw4=
Received: from DS7PR05CA0045.namprd05.prod.outlook.com (2603:10b6:8:2f::7) by
 DS7PR10MB5976.namprd10.prod.outlook.com (2603:10b6:8:9c::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.16; Mon, 10 Nov 2025 09:41:54 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:8:2f:cafe::54) by DS7PR05CA0045.outlook.office365.com
 (2603:10b6:8:2f::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.14 via Frontend Transport; Mon,
 10 Nov 2025 09:41:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Mon, 10 Nov 2025 09:41:53 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 10 Nov
 2025 03:41:51 -0600
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 10 Nov
 2025 03:41:49 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 10 Nov 2025 03:41:49 -0600
Received: from hp-z2-tower.dhcp.ti.com (hp-z2-tower.dhcp.ti.com
 [172.24.231.157])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AA9fit03156252;
 Mon, 10 Nov 2025 03:41:45 -0600
From: Hrushikesh Salunke <h-salunke@ti.com>
To: <trini@konsulko.com>, <a-nandan@ti.com>, <c-vankar@ti.com>,
 <u-kumar1@ti.com>, <marek.vasut+renesas@mailbox.org>, <n-francis@ti.com>,
 <peng.fan@nxp.com>, <semen.protsenko@linaro.org>, <s-vadapalli@ti.com>,
 <jm@ti.com>, <m-chawdhry@ti.com>, <ahalaney@redhat.com>
CC: <u-boot@lists.denx.de>, <h-salunke@ti.com>, <danishanwar@ti.com>
Subject: [PATCH 0/5] arm: k3: j784s4: Add PCIe boot support
Date: Mon, 10 Nov 2025 15:11:39 +0530
Message-ID: <20251110094144.886956-1-h-salunke@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|DS7PR10MB5976:EE_
X-MS-Office365-Filtering-Correlation-Id: e3f2a74a-5842-4125-8f72-08de203d615b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BuEjIKifuakiOGJPEMBadGulr1ZPkt2OUBVu6/iyoHA49Yh0KHcLrMD3kA5j?=
 =?us-ascii?Q?D118xDlwNt3+EqcrfySsL5NE10NMh6eucOx3PpQEtGl80ZCjK6Crq0oKwqNB?=
 =?us-ascii?Q?Jx/QWKbedu1conZvb5+jetoKPEAcvIZhAT6WR7kKHEL3t0ZSM6Po8KFEEw60?=
 =?us-ascii?Q?xPdcpgf5ydAuamZYu7le2OWso+dIcpPFp172VRn/NMU8aC0m2+jTiU3qPN1w?=
 =?us-ascii?Q?mfJceMtS9K9dHs1ngV4O0fi78mo3sz49FrtKfyVbZi2KRErFVShz6dY9mq85?=
 =?us-ascii?Q?kaIMrNpdg5r7jV0B61GIqTwCtya7RjVnZUCK24uu7BdR3qJKIWi/a9IYD4HG?=
 =?us-ascii?Q?hLGgTPSxQ0w/BoOQkcIH8XzyNq8ZeyX22rvL29uaAYU0GwaN47CH5dwW0cRu?=
 =?us-ascii?Q?6nRli8LNRk+j9u+mHJHEMdPAxkmZT4UPkpiiMqsaSPU7SpZtSXy/+9AoE6bN?=
 =?us-ascii?Q?WzdQSVCmVVuTMJHYTYaOKlz+O2eWxpBrO4FWH481WnWXErPS5AvI1l6B6iqj?=
 =?us-ascii?Q?Iy5vhOgLLgeFp1WF/kZEyXdlL417TKFjD6Hyr1D5rlP6+TQJmX5p+saODiQt?=
 =?us-ascii?Q?CIursYbbT7hfl2N6MvvOFHk0T1YDFkh5DH5uquxFI/wNIRh/Pa/FCoDCxoVk?=
 =?us-ascii?Q?t77HsVW6+XlggumTKmcyvp4BMuErdn3H9pWk3yb1yoPLHxgFMt89LhlgCBdS?=
 =?us-ascii?Q?8jbcZIC1hG0kBQszfXYXSoe+BAjzKvWSUjJyGEPAVNUl/rlLAHT5OfFU3HmK?=
 =?us-ascii?Q?lk9KUwJp+LOe2f9zVmqjnr0sOnfw/JgdLLCjceWIHoFwjsv7lFfbnVhxfs7C?=
 =?us-ascii?Q?Ipj4vYhY/vMbrDJGZSD/FJOS3z/igPaAr6MQll474vemao3StEYENsEWBIfM?=
 =?us-ascii?Q?g4ZbUNTE8CfXModxAJA+X+KtkqfBy49ckFL3oqAEEP+yz1K6p3VN7FHCb+Nv?=
 =?us-ascii?Q?4CH1HfusLDgc+So0ycVJQ1yQkSyCDy4GhZm8cFtckJbgZe6XFBTrAKtFRNk6?=
 =?us-ascii?Q?Y+kBeJvbKZ2gsIryOKbRwTHjJiDHk0sGRNct9/w1wyuSCvjI+UH38MhxOb5b?=
 =?us-ascii?Q?d1ZOcnSMhjLsFtCtvjWy1Db7/qAHinEPTeA37uxnTcuuWr3zbnrPlGiKhZPU?=
 =?us-ascii?Q?T5/cWDZi0qu/ZbMaYWE9SNMSTLCAflQtdtMtyCnIBCQR2EV5cCAk0+tej6Nw?=
 =?us-ascii?Q?zMfCJW+RLFLXqIxvX+iSLa08zLZYafJrTUGfMtTEw+/SwZpc24s4VI9IEnFi?=
 =?us-ascii?Q?BxqqDnuJ42YdfyUYYkCt4TpNpQc06Y8ZVm2T6KvypR9KjqmzqgArgYm/Yx5X?=
 =?us-ascii?Q?J7bWtOWZuI6rmGuT9S54qAhuBqbv3TGCmuSoMeQ/XKHiDf3TRQR49PFs+WLe?=
 =?us-ascii?Q?k0hVzR9hCpM+6XGi0Sr1osvblvV44kyS+cGyTUnIJixSZh6qFN5SF8RNy/Iy?=
 =?us-ascii?Q?5CAOrlySOaG7oVO5l8bKXsjUEU+4zgy19B7ANF6Kj/4IBlJTNSUbc16gcjtg?=
 =?us-ascii?Q?2kjiy3aPtQZUzZHB4S20qx8PeZttImdb1aP3?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(921020); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 09:41:53.0908 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3f2a74a-5842-4125-8f72-08de203d615b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5976
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

This series adds PCIe endpoint boot support for the TI J784S4 SoC.

PCIe boot allows the device to boot as a PCIe endpoint, where the
bootloader images are loaded by a PCIe host through Device Firmware
Upgrade (DFU) over PCIe.

The J784S4 SoC uses PCIe1 instance with SERDES0 for endpoint boot.
To enable this functionality, the SERDES and PCIe peripherals must be
configured early in the R5 SPL stage before the bootloader images can
be transferred from the host.

This series:
1. Adds the required clock and device data for SERDES0 and PCIe1
2. Enables Cadence Torrent PHY driver at SPL stage
3. Enables J721E WIZ SERDES wrapper driver at SPL stage
4. Enables PCIe boot configs for R5 and A72 stage

This feature has been tested on J784S4 EVM. Following are the logs
corresponding to this feature.

https://gist.github.com/hrushikesh221/cf48b512eb4cd90c1612ad2e531b8ffe

Program used to copy bootloaders from PCIe Root-Complex to Endpoint:

https://gist.github.com/hrushikesh221/94e6042dbd717c74b74a5c9fc8ec5b6c

This series is based on commit :
6b27b688694 Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boot-sh

Hrushikesh Salunke (5):
  arm: mach-k3: j784s4: Update SoC autogen data to enable PCIe boot
  phy: cadence: Add config to enable Cadence Torrent PHY at SPL stage
  phy: ti: Add config to enable J721E WIZ SERDES wrapper at SPL stage
  configs: j784s4_evm_r5_defconfig: Enable configs for PCIe boot
  configs: j784s4_evm_a72_defconfig: Enable configs for PCIe boot

 arch/arm/mach-k3/r5/j784s4/clk-data.c | 211 ++++++++++++++++++++++++--
 arch/arm/mach-k3/r5/j784s4/dev-data.c |  45 +++---
 configs/j784s4_evm_a72_defconfig      |   7 +
 configs/j784s4_evm_r5_defconfig       |  13 ++
 drivers/phy/cadence/Kconfig           |   7 +
 drivers/phy/ti/Kconfig                |  10 ++
 6 files changed, 264 insertions(+), 29 deletions(-)

-- 
2.34.1

