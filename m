Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D264DD116F1
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 11:03:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34AA483B96;
	Mon,  1 Dec 2025 12:01:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="NL9isqIj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5730483BC4; Mon,  1 Dec 2025 12:01:57 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3731C83B85
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 12:01:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-salunke@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WLPn+CNKDjnFsJjh8v1Bg8DGs4YHoGCCTH4QGt+UkmxrEpxV9HEqUT7j3SCxdhVmTCPcqaVkuWX/F2OExa+arroOQkzvu5OQuab5V0vrGPqBqCmIfhhq8ct0ielS5fuxtX+OMNS5XLHIteR6bhOPF7LgiYOtOVDY/1X/5dEw3hCWdtglU4McJPdeeseerfrwdcT6DUx421PYyF9Nif5bduPanwUuhC0ZjwcdGII3dxVvvH2S19viVzwOwNLnF/GML7QFDGFkrBe1iavR9SzEFPys82oOX6fk73UnIKrENMIRPl6xY5ykPj2sEpliHjH5keWpji8w4UbDbhgYVhVGtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FkD18atIBK3ujdm/75sj7qEA0PB8Tel+ePK4ibyweO0=;
 b=p5SgEpAgxizj4PBjDGFe6GPy2LBliJL2A93XVmIDfiY31gz+tCb+j5gyOVjpNaL8hu+8xn3R/BoCOGAwpKHTKx7Ycqefx9uEfTDrwKHVM6xOB9DGrVsamSZuJs5YfR110IAJQdNRBRPYamqtsdWY02rfKEnOIOWwlzOC2oNCNq5DUH/EZQ45KQbww7S+MiiXaVI4n4qz7engD+Jen+5fP5Lx2tUuQ2PUafAJbFoIsNFtNN0hytLTWu/eJtiOmiXnmspIUI1LQk/bsUoghs9+jarSsWT0eGXfO7MAs8P/1HHcKpwY3OxMT2cwt1zyRvnKVf+2o2flNMXiuMki1SR8PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FkD18atIBK3ujdm/75sj7qEA0PB8Tel+ePK4ibyweO0=;
 b=NL9isqIjD7Nh1V41Z1hQ0B96H6PM7L+SL7eOFC79abbHo9aPZ+v6KdDtpH1bZK/smUDhCaG1MyPe4KaL8qxde5BmBNj0Dj5y5q/Mf/CQwoUYOA88Ir83+bfAcQ7MthMgPfXWKHt4oG80TFaJxNg9zCBeJgZ32rE+73l/mCWoq0k=
Received: from PH0P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::15)
 by SJ2PR10MB7736.namprd10.prod.outlook.com (2603:10b6:a03:574::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 11:01:52 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::8d) by PH0P220CA0006.outlook.office365.com
 (2603:10b6:510:d3::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 11:01:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 1 Dec 2025 11:01:50 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Dec
 2025 05:01:46 -0600
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Dec
 2025 05:01:45 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 1 Dec 2025 05:01:45 -0600
Received: from hp-z2-tower.dhcp.ti.com (hp-z2-tower.dhcp.ti.com
 [172.24.231.157])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B1B14qf306512;
 Mon, 1 Dec 2025 05:01:41 -0600
From: Hrushikesh Salunke <h-salunke@ti.com>
To: <trini@konsulko.com>, <a-nandan@ti.com>, <m-chawdhry@ti.com>,
 <c-vankar@ti.com>, <u-kumar1@ti.com>, <j-keerthy@ti.com>,
 <marek.vasut+renesas@mailbox.org>, <n-francis@ti.com>, <jm@ti.com>,
 <anshuld@ti.com>, <s-vadapalli@ti.com>, <ahalaney@redhat.com>,
 <semen.protsenko@linaro.org>, <mkorpershoek@kernel.org>
CC: <u-boot@lists.denx.de>, <h-salunke@ti.com>, <danishanwar@ti.com>
Subject: [PATCH v4 08/10] configs: j742s2_evm_r5_defconfig: Disable PCIe boot
 configs
Date: Mon, 1 Dec 2025 16:31:01 +0530
Message-ID: <20251201110103.845413-9-h-salunke@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251201110103.845413-1-h-salunke@ti.com>
References: <20251201110103.845413-1-h-salunke@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|SJ2PR10MB7736:EE_
X-MS-Office365-Filtering-Correlation-Id: bdb159d2-57c2-4f44-4e54-08de30c907bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Gg5vBSw7/TMODM6ZIqyVk0jRrpDBniCx5HVBUPsXIF+Hkd8aVOQmRz+1iV0R?=
 =?us-ascii?Q?Y3hKqdUQrFd4No6DuyOlJkpcL80pajETothkspleR5XNH8LexxwAQMo5Y/xI?=
 =?us-ascii?Q?jptn0yMuU/fY5Z51QvT9dVzBgw2rXpLWeYn4nU9CiXBiEeKeGMNNWc/vSvPE?=
 =?us-ascii?Q?EBlcY2Yu2futGdhfMKEVA6MjvpyfBMGVYkbKhjdbT7WdXLPmZS7iZ6arPWYO?=
 =?us-ascii?Q?bymaq36A96lfwpKUr7cyfc4LLRe4Nh4deMd4TkKhqaqNg7dEYA7gdl5158og?=
 =?us-ascii?Q?R4jDhCSHAlf++gabAtuNZAkUYav3U2WZw5yGb6NvaqBXVRZfstUGmFsX11ih?=
 =?us-ascii?Q?doE910MxYYzJJCCAzX6BLgDdEDY8gansqhbRfKYV6o34Iho+0UYoqeaBiJOn?=
 =?us-ascii?Q?MA5YEJC5OSwxAWWnyhdSh+MKyFMhwxJfuhnkbin298fTPE0XOUJo3BNyRPTH?=
 =?us-ascii?Q?E3PUWgSDfGTl9b2Lk7Hm1sb+zs9RPwIAQ8pX6b2UWXUEjmPJwtiYdSK7aw7w?=
 =?us-ascii?Q?KaavEoPcFwnO6czWvh44X8tRPt2ZfI06s27cl1G8XFFyZex5DNl6WbRasNvQ?=
 =?us-ascii?Q?OrUUVmT/OUhBou6RgnmhN27DSr1FS2fAVQrtqhQJ2OKGvGM4EIgWSpvVxBci?=
 =?us-ascii?Q?Z8yAmTKrHSjRMwSawFeADteG7y4K9ZpkT/hozCLeK9uvyauIGTNOBME/tudE?=
 =?us-ascii?Q?GoQCGvbv3rsfKo3bj82HNfqYM93LU2gY3vrCORmJEFgJPpRLLxzHSABl3cU3?=
 =?us-ascii?Q?SQ9e1ZWDPI/buErn9It48EHpCA+ImAdqzQNmeSMnlAeF96yTw9xXh4cLEETP?=
 =?us-ascii?Q?VDeGLSj0daR2ZEm5mIMTPIW7jydJcb+lQodIA1FrvEXFPq0juzNwf3yqMD/R?=
 =?us-ascii?Q?En0T9XH/jiL6axkrOBgsO0QkUP9vYUX44ciSR9dspSXKoLe6zl3IaLC8kSw7?=
 =?us-ascii?Q?whJ6lBKwWyQVbMLdEo9mMIE7XRqsp6AQOSg7nhuaQtrt/mb4BYvXQYXZeOFZ?=
 =?us-ascii?Q?NkniFyEOTWpJ/T4/KQ7B3VBv6lmKgylTYYQHYNoXHNJhqjGWXIC1Vvt+hOsZ?=
 =?us-ascii?Q?ujEjbvPsoHRNo+ok1vTus7VWyBLwr08RNsxCXrW+w+zG+TfEeDTnRNUfGnRD?=
 =?us-ascii?Q?8aZMQxXI9zapqsU/cf5yPp9L0+118PrOcDUCboVXxML9dy2MOxc3bbk3SLEx?=
 =?us-ascii?Q?M262tWttu8Ob1hkmJoNaP8f2q6I7P2xt8hhLNBUaHHRHzg6D9AiQsrU2EIRH?=
 =?us-ascii?Q?OLIxXqZSR4PRELoqJH/eh+rLFDArT+dSzWMbnxq3pqcj49nupS55ZKgJn/1n?=
 =?us-ascii?Q?Z9YGZ11ZHie2uFDhCdXs4fxA+KjtDYRI40kE/P2Zf6Aex27Hbzsdd9yIL7Z0?=
 =?us-ascii?Q?YUR9UsGCY+MWVLF7TT+mvaXdNrQybsjiy2i9jfAxZ760gtW5g+kY8JuBQYc4?=
 =?us-ascii?Q?fA9E+Oa3UBdT574dTh5sVTyYJTJYi+FbyD/fRWU0UfupXFd+bK4RALl0KpYa?=
 =?us-ascii?Q?BrlXXbYWcmzp+WsizRRpksJYZW1ks7nrAr7o6Gb8ylEPFXw3NrrfrgNhWhiv?=
 =?us-ascii?Q?Bp8trcJGB2FG/NwecHiqopvbc7JE+lWqchAMsDl8?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(921020); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 11:01:50.7879 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdb159d2-57c2-4f44-4e54-08de30c907bd
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7736
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

J742S2 EVM supports PCIe boot but it is not enabled yet. Disable PCI
boot related configurations that are not applicable.

Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
---
 configs/j742s2_evm_r5_defconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/configs/j742s2_evm_r5_defconfig b/configs/j742s2_evm_r5_defconfig
index 2be6318df76..fa0bafca689 100644
--- a/configs/j742s2_evm_r5_defconfig
+++ b/configs/j742s2_evm_r5_defconfig
@@ -5,5 +5,14 @@ CONFIG_ARCH_K3=y
 CONFIG_SOC_K3_J784S4=y
 CONFIG_TARGET_J742S2_R5_EVM=y
 
+CONFIG_SPL_PCI_ENDPOINT=n
+CONFIG_SPL_PCI_DFU=n
+CONFIG_MULTIPLEXER=n
+CONFIG_SPL_MUX_MMIO=n
+CONFIG_PCIE_CDNS_TI_EP=n
+CONFIG_SPL_PHY=n
+CONFIG_SPL_PHY_CADENCE_TORRENT=n
+CONFIG_SPL_PHY_J721E_WIZ=n
+
 CONFIG_DEFAULT_DEVICE_TREE="k3-j742s2-r5-evm"
 CONFIG_SPL_OF_LIST="k3-j742s2-r5-evm"
-- 
2.34.1

