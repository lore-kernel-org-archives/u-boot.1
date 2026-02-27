Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2626FD7F95
	for <u-boot@archiver.kernel.org>; Fri, 27 Feb 2026 11:57:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E269E83E63;
	Fri, 27 Feb 2026 12:57:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="reHOYPPp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AEFC83E76; Fri, 27 Feb 2026 12:57:29 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B64B83AA9
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 12:57:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CsMd67Om1w4CdY3VVw/zTM5SAV0pSNrrKUk0Au16qY8g+b/+wBLpmKEizg0QhFUDSeaWYuMqs32qhUef+r1zpDG90Oqe7kTW7SFjDutF4n/6h5GKl4aN65WcTnM3zQfpbTHMgwpGUp+Q4WfsEkTV0aY8nkbXMWbbK9xZSClgp37YCofBZbP7yXlQ5uzOlyf339jTceDsLU+MVaZmhVd2MEpMPROTWM+bAFkMERkPGuYzc6esCw1m5Te/Q/ZPdtuZ2p0Ykz8BEtiTnlb4cczwzmUFceo5IV1x/vVDQg4Qb4QzbVo6UMRClSY0GEWzN7Er3p4BuG2b596ZkoiwQjf3Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k29p6iXDw3OPRVegD0v8zn2ayL57BfjzxzPOu168iqM=;
 b=G5dOKUoLONTIw2t56Xy4UgoeItuPeDhnPHJVvLXdCXgKrdL6V/FZWZsASCL2xLh0L/Yq09wj/2jzUYTugcPoM9+V0cyxUsmt/mnBixbWo1wEIJMEb4mNJw2nn4UPodc+eEnhfF/QYL8iIi/68uX0h4fjcLZpHoNB/gdA5NE3FRhmBH7sQYp9BkTGyNpBh1owhftySkIyuoKkJ8D7+Aoh6vAOSqUFyZd20DWkAiyeA87aTYeDeGi2X9gJQkaLtrKVGx3ghzcRWayFqpB4Y/HiVP8vtymvJ2oFEE4RRNXg6xqpzTkPfGv7G+rDJgFpvwWY2jPLHr8zH1eOksmTQi23XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k29p6iXDw3OPRVegD0v8zn2ayL57BfjzxzPOu168iqM=;
 b=reHOYPPpm1jf9CTnx2JQKXV3LepD1tEKtkcrEZq8qczSXmQxe4JMaga4FYfwYwWHGpqefdOkNCud4KetyrgF7jgmDS+Evx99LgRT89Ao8npZvAkh1DX8392kL16HfwKaiS+EiyFXDAbAWaZzC7XgwCJMi2WNr9zmufMyNG236tY=
Received: from PH8P221CA0065.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:349::13)
 by PH8PR10MB6672.namprd10.prod.outlook.com (2603:10b6:510:216::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 11:57:21 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:510:349:cafe::d3) by PH8P221CA0065.outlook.office365.com
 (2603:10b6:510:349::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Fri,
 27 Feb 2026 11:57:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Fri, 27 Feb 2026 11:57:18 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 27 Feb
 2026 05:57:16 -0600
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 27 Feb
 2026 05:57:16 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 27 Feb 2026 05:57:16 -0600
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61RBvApX3689228;
 Fri, 27 Feb 2026 05:57:11 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>, <anshuld@ti.com>,
 <d-gole@ti.com>, <n-francis@ti.com>, <bb@ti.com>, <jm@ti.com>, <s-k6@ti.com>, 
 <afd@ti.com>, <u-kumar1@ti.com>, <marek.vasut+renesas@mailbox.org>,
 <a-dutta@ti.com>, <neil.armstrong@linaro.org>, <semen.protsenko@linaro.org>,
 <peng.fan@nxp.com>, <george.mccollister@konsulko.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH 0/6] 64-bit PCIe for AM64, AM69, J7200, J722S and J784S4
Date: Fri, 27 Feb 2026 17:28:28 +0530
Message-ID: <20260227115841.333073-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|PH8PR10MB6672:EE_
X-MS-Office365-Filtering-Correlation-Id: bb28efaa-2db5-4bf7-0b4a-08de75f75b96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|34020700016|1800799024|82310400026|921020; 
X-Microsoft-Antispam-Message-Info: WLl+fEJgQYkE37XKP4qa/syX91+sls7KE/Dd/hQ6PEpWsuMX+x4gnc/15Uai/6Pf1ghYGaNmUmOlxdPxB1jf9WcxILxvPpMBooHTAPPa2lKie8scKpsttmC30GMxc0nXVl8MPmXhlsTtoRwrmpdzdLmlzTAiWq2tAxQv4nsiUEgt/b6Ctvwhy6XuXsXbrH9ucR9X6pS7D4Lyh7FrKrv+Fv94gNuVB5jmY+ggG4cGGvVZFSDu4KdbPPY1nghH8H2Snpr1YKAqPgricTLVoyCidUVB86xJ15pbNXq+GFQqz9B8/I+CoTfr96FNaYCSB97cxHP1oqULAG2cVfU6mMna8OX3L8kVYAqGd7x/mCcytTC8eQR/XsEUsPRFJBiaK0iO6jopUjV2vUP4LDSlSYkwtWZgUuriCvGqM9cIluXZGDdmRkBTLbaaF8F1a8i9Ifljn1tz8SDa2huifQtQAIyUiDQKjz5mYb90H3KA+Gv1y0h2WRwk3NRp9LR5WTOT3lkYPJ9smh4XrrifQezR//lYKKBACRryXOaaxopv1+SmrmW6cGBaq3kZCt1x5I9VElC2qJGpJAmz5l4rTNAY8u/XflJ0gK05njXTooNvzZwNJK8cB6V9L4dZuN/1v4cCcf0L4s3bcM5XlBJSVb7MV6TbUxJhWEs178r1dSqmv/q3hvxY0TbH1ePS2E9tQywqdnXF5a4SRdrGATSEO4D9QVmZDfEpPa7xEpfwhXi4CQpycrvdzDJwFJgvhA4lISz/acjveGV1b4B+89oyCpi5wmwxsWr03c1et2z/oeCgmcQH5xibtFFoX19rliVSG0/f+2cx
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(34020700016)(1800799024)(82310400026)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ydx99IYnvm45RjaGMJ4dM9QeXmwgORJoytulVpt7IDdBN0COVwohfc3/kUTMxtmyMbmPfGcOjAlvUb4CMi3UvM1dBc5D5M9U/3qKcazJXKbKBltlAm/yHg1SI9uBZFeNYIs6u6aAuBwJ9w6EmS7ijLeWRdLbQNbQIM/XpZTkYfk32YA7YVtOpnCOWxSQoTanToPelBQrtcTx5DkA3WJSMIowPziCCDypUIrW6OrCs3rC8vW/oaVPMM2Vx6TUobTNRnOzx7KY5PkvwNGTPDM9u0kyjG7YB1mo3/r6E6eapqfez1cCo+eHY2SAlrlE6Fqlg0WKUuvlnLDZq0snSpllza1QdNc8/8JD3kjaROq+KaqAbf1Fe5XSSdvQZLfj2oGfMNn2Fqb7ViCNV7LJqzjcL6zpOwNOAkRBKORkJkPcewuISW7/NVey9UKZUHDx5KQq
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 11:57:18.6201 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb28efaa-2db5-4bf7-0b4a-08de75f75b96
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6672
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

Hello,

This series is based on commit
437ea9f8be5 Gitlab: Fix TEST_PY_TEST_SPEC for qemu-x86_64 in sjg-lab
of the master branch of U-Boot.

Since Linux device-tree has switched to 64-bit Address space for the
PCIe Controllers on TI SoCs, currently, U-Boot needs to support the
same. This series adds support for 64-bit addressing for PCIe along with
enabling Root-Complex mode of operation for AM69 and J784S4 SoCs.

Series has been tested on all platforms being affected by this series.
Test Logs:
1. AM642-EVM
https://gist.github.com/Siddharth-Vadapalli-at-TI/82512389f8396a51e4f167c7ebe4c2a3
2. AM69-SK
https://gist.github.com/Siddharth-Vadapalli-at-TI/b20b2811804ffc6e6c063564330c0a35
3. J7200-EVM
https://gist.github.com/Siddharth-Vadapalli-at-TI/c545da68bd28a5e036803bb60f32d8e9
4. J722S-EVM
https://gist.github.com/Siddharth-Vadapalli-at-TI/3dde05c4c7076076aa20ac47a6e2d176
5. J784S4-EVM
https://gist.github.com/Siddharth-Vadapalli-at-TI/a93c1b2cd5d90f494e885d1831d3d23e

Regards,
Siddharth.

Siddharth Vadapalli (6):
  arm: mach-k3: arm64-mmu: add mapping for PCIe 4 GB Address Windows
  pci: pcie_cdns_ti: enable PCIe root-complex mode for J784S4 SoC
  configs: {am69_sk,j784s4_evm}_a72_defconfig: enable PCIe Root-Complex
    mode
  configs: am64x_evm_a53_defconfig: enable 64-bit addressing for PCIe
  configs: j7200_evm_a72_defconfig: enable 64-bit addressing for PCIe
  configs: j722s_evm_a53_defconfig: enable 64-bit addressing for PCIe

 arch/arm/mach-k3/arm64/arm64-mmu.c     | 16 ++++++++++++++++
 arch/arm/mach-k3/include/mach/k3-ddr.h | 11 +++++++----
 configs/am64x_evm_a53_defconfig        |  1 +
 configs/j7200_evm_a72_defconfig        |  1 +
 configs/j722s_evm_a53_defconfig        |  1 +
 configs/j784s4_evm_a72_defconfig       |  6 ++++++
 drivers/pci/pcie_cdns_ti.c             | 10 ++++++++++
 7 files changed, 42 insertions(+), 4 deletions(-)

-- 
2.51.1

