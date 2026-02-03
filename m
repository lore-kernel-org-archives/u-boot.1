Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C46CBE83059
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 06:36:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A48683FB2;
	Tue,  3 Feb 2026 07:36:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="fBL75kHy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D742983FB2; Tue,  3 Feb 2026 07:35:58 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85A6983FA4
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 07:35:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-k6@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YPnf1KNA4h2OGyA8w7cKSlrNtkIUDj07Se+d49UwGuh1Yy3rQLObxQgUsuk+zrnJ/fotPDDyYymnqxK8zcZdyHYiYesZtaH0x3hbAZtLoxJTgavdBmdkniflj6t+6NjNScZVpc3G7nsmtIOvu+1QYLMcA9anoXJy8l3yKYK+rfmHAudFT5iXjpbh5ikLedJeRaPqfUYfAj9JTZRtbiQzbEQSRAlaQUndapx8pZ3Lb4gxvxHlebTROgxBI2YNRSXVnyiOg7onk9EwVYCcAf42y0aplGjzpWnedz39ozGI4f3LdUBPPiMCgJtOW8IbhtauKzfYOTX1A6bgXrBL5rRvQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cRC4hxHH5IoQToVXYa3aFBmQvIXLnOBVQYfeyRZEfoM=;
 b=va+g/AJsnuh1Fjvo1maalVa1PyrkrWKMMTsekWJqxTyBHOnFuh9Y1kGTO0Cug/n69HvSt63mm4+v+SKRhzve7EcYu2lfs5Wje8IV8dFVMfl/OW3C2ll+EXfzNsLn+E3oLc0Sq+NDNQH5revM1UsvMwYewSEx7rSr7gqiWAMB/BGna5iok4DsgP+hcMt84k2pl8AnNcwKkx24JJnhIjgqxWAn2qNNRzL30RwSuAxiPZzW3qnGDccwKvOAeSLEE4iXJeqe+KL2JKhLHD5yBMsEEeRgsUlHGGEFqudHvYy4u4NTIB4OkMMayRmYd5lu/eZM5jB8WfUIrUIM4REQ3dUDag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cRC4hxHH5IoQToVXYa3aFBmQvIXLnOBVQYfeyRZEfoM=;
 b=fBL75kHyoFDTXRSDNiyPJlxer7wmWwHdpdACmM88w9SRKRrAlZVvsn1ywygiiiz6hTb1WILzChpJpSebZsGJ1osAn9JmDXV0BZaUbQXOnbne1UBpFNVY6YxSzcJTjFQTuvgT4jNXcUU5CwtwGzL0h3cpQtDifs1mzidGAH7XLXE=
Received: from MN2PR14CA0016.namprd14.prod.outlook.com (2603:10b6:208:23e::21)
 by CY5PR10MB6119.namprd10.prod.outlook.com (2603:10b6:930:35::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 06:35:53 +0000
Received: from BN2PEPF000055DB.namprd21.prod.outlook.com
 (2603:10b6:208:23e:cafe::6f) by MN2PR14CA0016.outlook.office365.com
 (2603:10b6:208:23e::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Tue,
 3 Feb 2026 06:35:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN2PEPF000055DB.mail.protection.outlook.com (10.167.245.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Tue, 3 Feb 2026 06:35:52 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Feb
 2026 00:35:51 -0600
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Feb
 2026 00:35:51 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 3 Feb 2026 00:35:51 -0600
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com
 [172.24.233.254])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6136Zn7T3483536;
 Tue, 3 Feb 2026 00:35:49 -0600
From: Santhosh Kumar K <s-k6@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>, <bb@ti.com>
CC: <u-boot@lists.denx.de>, <n-francis@ti.com>, <s-k6@ti.com>
Subject: [PATCH 0/5] Update DDR Configurations
Date: Tue, 3 Feb 2026 12:05:24 +0530
Message-ID: <20260203063529.1551907-1-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DB:EE_|CY5PR10MB6119:EE_
X-MS-Office365-Filtering-Correlation-Id: ead81ee4-08ab-4591-0b57-08de62ee7a62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UgRFM11oyRVX903UoSA2ZiPMY8lqmfBPPMfIT9NhUAl58ElGfKvaH6adH9Nv?=
 =?us-ascii?Q?wnnmZhP2IKVpnMj9fHGutAQou23QGECG4rmcpJb5sbReQiu4Lv28Vct6L/qE?=
 =?us-ascii?Q?BeWfadSlmQy8WGtSrC+8ihkaanI/EF73Lh4gJenIIupVz97v5NM44TiIufn7?=
 =?us-ascii?Q?Radf/iUkXQs5ZaUa1pWl/4TZeMz07qm1fsCm8FsA1QkhRVfNaJLQrLaL4yg5?=
 =?us-ascii?Q?S7X4pE0seETGvOt8lxCvgHASxMEIa4H2qAoDYckgYcU8LetJ3+k3GEjEyUuf?=
 =?us-ascii?Q?sIzu1fJulbW7uTmovdm+BDyQw3z6In5+w62+omPdsv5MImQE3CqOi8aRdJ3y?=
 =?us-ascii?Q?ahjmAjEDKoy5FBnDJS4gPo9MNBnO3LuPrrZ+rkqR+rR1h2lMK/ls+d5qAhov?=
 =?us-ascii?Q?BKPXjnbucWToKUvjJkvIOJOR2UOAC4oTbNmKmmZJyplFROTqGTTKRgj87WeJ?=
 =?us-ascii?Q?fBbikoN+DEx293kuD5LrSjkVLiBEnvwMEgffPg4+uQGI0+u9+G05rxo4S46j?=
 =?us-ascii?Q?RVfx5O0y7PC5QjzAqsHb9FUfOm+BsFNoW4yAuhAxgOKUX0FbcC3CQzhFQkHb?=
 =?us-ascii?Q?ytenl2XN4eS4oW+kKeRxoPE6M5ywh2vsgZKR3iGHabLEDNWT+bVdeFtk3dWY?=
 =?us-ascii?Q?htBUjC9IJFheW2TF6WGbjeyyzwaQRwh9X0yf8B1WGkBCCWRQSfl8tasaTVqz?=
 =?us-ascii?Q?FtxSlX4rmr8pljI47MVWyFwY5rKprdXjJiMkH5h88KVDu1d47U4aV/VMdOzi?=
 =?us-ascii?Q?G5Kmpap4JCzd8NetRGufd6lMnO2zy7N3oAEkyitAkj/cqCvNeo2nDQTUEbbM?=
 =?us-ascii?Q?GStcCMaDX3tr99su0TJCGRI+ce6oDSieCf66eqllqYCG8CQ2rCr9/GOz1pTx?=
 =?us-ascii?Q?HZr8CO8M0ra9JR5N2rtZIli492q4hpQdYyEhUOjPU2KRh/trplWtPKkgTSxu?=
 =?us-ascii?Q?jDjODwFEF44T0hIcgMsLGswMcxaypTOz+1wuKf1GIpaeHamO8v0A7+K5Wrka?=
 =?us-ascii?Q?/YYnozI/5iKfwGyQ8o4u26cDCw7ZM0pw4Rn3hU/+yF0nYNY4m231IkF3xDl7?=
 =?us-ascii?Q?6Cq2jbsTc2xGBS4MLUSsMPyTvqqv6xrs+sVnKOlzVeFSbDO8ZYbgmIeTnD3s?=
 =?us-ascii?Q?tes7JXOz0fs6Hr2HSq2ejfxtJGPRRzjmgvvuwU2FQg+bJqd3KF1I+Uinm1cQ?=
 =?us-ascii?Q?CgAzVcKanUt240u36HM8HvRmhhU3i8aEtJq3cI7zch/3ZDPpql8Wi5m5B/rv?=
 =?us-ascii?Q?1pjhtXDr+Ohgy1dT1KH+ULxlzoMazrcUgMLqHuWNO77q+Nf6/ztYIJOeMPCg?=
 =?us-ascii?Q?GKSjUlvw+f6Tc/ewmtnrTi3BDlU+V/bMz5b3o2MBOhtunSZ4a+HeSSziRzLT?=
 =?us-ascii?Q?KPlYDa6EkPofVGoIrcZ35+H+06jQ8F7o51yo9Z+rzSCDB33j3mVFOQxXmkDl?=
 =?us-ascii?Q?Lvkb6rYY1SJ7wHn63O1OeLvhKPaHd9cVwzXX4P11dYeVvSGdvGL276PprupQ?=
 =?us-ascii?Q?VAusCOUsoCxItpiwpgNldXJ7CF977boM0aDa7JjcHYxB1KPmu3siuKioJH9W?=
 =?us-ascii?Q?mjaOgcm4mllRly5YeNAYrvx7uR+yDmnWWDsMVGmhNIf9+GYlqLztwQfM+jjs?=
 =?us-ascii?Q?UDjc3ckv8kfBegoS1xk4st+1v5lMPaLfkP8F98ZsAAjj8cXInKkIut+oPN/O?=
 =?us-ascii?Q?knhX1Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 85xdtD/SBCQYVnf8RiwJodczry0g4qRfSdVmgOGSzXT6xYsHXqrWDPfI9M/GWWhcUTpULrwXqpzvDxNCeZs2sla3CPzyLLGPfib6YYBYBnokhgskdu4PtLv97WHeG6ybgWJHg3ckSguo5/jZ5kIUlzoiftWRRuHeh6T7y4Jpw3Rn1vnohuJmztH3K+CQXF/klzqjD7gTtlX5y5pSnUtocKhiSoyEYmZR5AVq1nRYc8r3P+SRw03RGMGvFvIo/L8q2ZcPMQVCeNhK7LMdlvFkszanGCI8h2qOykhSoAfp6oJZJAJlBgSF5RJWuC+FA2wuuvX9NcWhdTwoPYlJsKudTFpu9hmcGpmLPrD8bOsvjrzC6iS8uG8QEquJP7ytSATo23LOgsHD7hDqAmdgt1NNM4tfIMHOaz8ejjSnX3aLkaOMpfST4M0tEAU1S6BN7vGd
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 06:35:52.7001 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ead81ee4-08ab-4591-0b57-08de62ee7a62
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6119
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

This series updates the DDR Configurations according to the SysConfig DDR
Configuration tool v0.10.32 for the following devices [1]
 - AM64x EVM
 - AM62x SK
 - AM62x LP SK
 - AM62Ax SK
 - AM62Px SK

Testing:
memtester - 50% of memory for 10 loops - PASSED

[1] https://dev.ti.com/tirex/content/Processor_DDR_Config_0.10.32.0000/docs/REVISION_HISTORY.html

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>

Santhosh Kumar K (5):
  arm: dts: k3-am64: Update DDR Configurations
  arm: dts: k3-am62x: Update DDR Configurations
  arm: dts: k3-am62-lp: Update DDR Configurations
  arm: dts: k3-am62a: Update DDR Configurations
  arm: dts: k3-am62p: Update DDR Configurations

 arch/arm/dts/k3-am62-lp4-50-800-800.dtsi     |  13 +-
 arch/arm/dts/k3-am62a-ddr-1866mhz-32bit.dtsi |  25 ++--
 arch/arm/dts/k3-am62p-ddr-lp4-50-1600.dtsi   |  25 ++--
 arch/arm/dts/k3-am62x-sk-ddr4-1600MTs.dtsi   | 119 ++++++++++---------
 arch/arm/dts/k3-am64-evm-ddr4-1600MTs.dtsi   | 117 +++++++++---------
 5 files changed, 152 insertions(+), 147 deletions(-)

-- 
2.34.1
