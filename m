Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7460DD6B6AE
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 16:48:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4CDA8921E;
	Wed, 30 Oct 2024 17:48:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="GdFAefTH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6D678921C; Wed, 30 Oct 2024 17:48:32 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2072b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::72b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4C7F89206
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 17:48:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=itTQewPgJQ0yPsay6zFbI6zrGFw81Pgt/pIxeLCx+kF5TH3OAXSsULUG0PXjgBVZeQ5ArEL4kObs00VP2BbOlwmsVCcksdnn20w/kHTRq7lAcau+JBm1/xXsy7vjgXltZBfKozUmWGXvjcnGXUCNsWngumfZcSy5IHOLtbCZGx+D6UnxmBGW8VzoDQU03rijHmm3huORP8+gRUtkyKYk9olRtArusnyN29wVi9+lZJfY5tMaWelzv/8urD0jwU9yb0v89ygBAT4eg2ivblDA9i7t7S3Iwxn0tr+5zkPWPnrG2hEv7/QRRawf4BRxBgWH0QkV+blxVPF0Pn3k/nycNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=euh1v2gSK1GNSb9ScY8ydFTmURH+gliLxFLemgFmFJU=;
 b=Yl8tjhNC9b35utkxLI5NTZLxAtoqka4QLYUdP/zUOFqDnDqAAVJpwh2Gm3MXQlkYY1FIhs251CyEnA3P6vePkVmL9z8qwuOPhqhDG0wnjhNlzOFA7fa39xaLMpvtxWu4yZykpszIxYfmLupR9H+lcgMmnGk/JxvpoYyXRXxQOnpluf5RHmM0mbJLtEhBp/Wlcmq5/6iKHntbeDRC9DfZOSHAvUkg9tcvVCOatDnqocM7QMwVIduigNNhKuu6S+remh60waNbicd4kc57ni550mhdvY3tzglM4Fh9nMgkLH4fwjrRQgt1XD8261bSR+jxH0balxWtusedY7snMstZ3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euh1v2gSK1GNSb9ScY8ydFTmURH+gliLxFLemgFmFJU=;
 b=GdFAefTHE2yWczAszZaJVGZoAb8Of4SjDCc2vh7E3ExGXNmEwfOpHXaZkfyzntKiOtZui7ihOgNpoJhAR6sjQ7bcANeGjNWqvvzkMC+7SK0hk3vrTbY/VyNzJN22WKLuFvcMjv9gKqLDrNPCzOg7onkWK8soh4fqGgBYTnwqP+E=
Received: from AM0PR01CA0111.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::16) by AS1P195MB1572.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4a0::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.29; Wed, 30 Oct
 2024 16:48:28 +0000
Received: from AM3PEPF00009BA1.eurprd04.prod.outlook.com
 (2603:10a6:208:168:cafe::6b) by AM0PR01CA0111.outlook.office365.com
 (2603:10a6:208:168::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32 via Frontend
 Transport; Wed, 30 Oct 2024 16:48:28 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM3PEPF00009BA1.mail.protection.outlook.com (10.167.16.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 16:48:27 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 30 Oct
 2024 17:48:27 +0100
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 30 Oct
 2024 17:48:27 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <trini@konsulko.com>, <n-francis@ti.com>, <afd@ti.com>, <d-gole@ti.co>,
 <sjg@chromium.org>
CC: <d.schultz@phytec.de>, <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: [PATCH 0/6] Apply SoM overlays on phyCORE-AM6xx SoMs
Date: Wed, 30 Oct 2024 17:48:09 +0100
Message-ID: <20241030164815.1763506-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009BA1:EE_|AS1P195MB1572:EE_
X-MS-Office365-Filtering-Correlation-Id: 8786c4bc-4733-478c-9800-08dcf902ada2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?n2bfjhQrzMlzObVC3ZUW7AJI9rIGkLtzwfvX7mi/fYXpJOWF6e8DeoIcmxaU?=
 =?us-ascii?Q?LM9Vrf/zkFifF30UV+lEXqGotfCaJklPYV1VfKHMh/NbacWU5c7wcxDueIbd?=
 =?us-ascii?Q?3ZOGT0JOofH4EBWvNLAjaaPcV6Rl7bCDuqNNz9uSk50pdRjzDOjQV/44vCJr?=
 =?us-ascii?Q?P5V3doSDpXgmao9Ro97b1qEGfRv5+eugG3JLRNhMaMOLlHu25UQcp9n0yEXV?=
 =?us-ascii?Q?ObRawaBn2+l7DDuYuIz/COGW5aoVV5YQzXb88jaNNBQiFlpv1dRczmy416Rv?=
 =?us-ascii?Q?KtQ3pyh/fn6m3CoEelBrOq9PebI5TNPO/Urf/t/J6v2O7YsAu4kWyc8JLsQj?=
 =?us-ascii?Q?Qrhq4TpAUGbBPeD/HjB/xdP5F21vfuKKqSqZgcSy3k+zD3kIYkSXU9JJIo7p?=
 =?us-ascii?Q?Q3wzFe/Pa2iYNByBCTrXc76vvzkGN3z6XFpUbCrIpbx6rpBw9ZKMqdTbqZvG?=
 =?us-ascii?Q?+biIs1AmAAcPY84Q5rsWpcKjqga0Sk5YDBwS0UzsajysL8xEhBpXooH+Q/lY?=
 =?us-ascii?Q?j+6Ino6Ag29Wo7LEC0wa/dktUB/4CP4CF2YUahSH/gihH8v1cOY5icEI/iR1?=
 =?us-ascii?Q?niXFwceeQq4lF7y2gx4qzIn6jk68HXv8xJ7MorQdtDXy3c1hwjiSYa2LcUN2?=
 =?us-ascii?Q?+7fRMonejsRuepWOKpIhrxQmp9N3VlUgqidVMNBiawnZRgCEYY7ka2WK5oru?=
 =?us-ascii?Q?SimlX4jlUO2OA60A3Nm23FXKGIZaKJ9UKRqQfGX1/a606jkWpAdV8gMho0ip?=
 =?us-ascii?Q?OpshBP2nzqmckLqd+nrjGFk82eQekyCkL0KtVzn+3Lbf0VDQSHiNwGQOGwrd?=
 =?us-ascii?Q?iHzqkh5nRKJqX8dPqVzd6EWq9JOrVM66xronrJJ6gVeoNrXl4umSjwq+I8PJ?=
 =?us-ascii?Q?Ac3ReJxOli7wOH+z5oO0ywjiP7ylFfxK9+oeEW1t6GOUpM0RJdw7xOi+aTx2?=
 =?us-ascii?Q?xK+tgpF/ZyG5YT+We14CFgkh+JM8eo8Kqe9oS+SQvNpbRkmx/cM2CrkVLBHH?=
 =?us-ascii?Q?EM2lzi/X3TdKFnsP/YAZPFn7Wy5G5CsDguz/J0X0nwOn8oSsjmDWhvBd7gop?=
 =?us-ascii?Q?0Ysv9P0IH9ElUhTXwwiPFT2LGwQKrgad4xOG74iRYnFBcTpcAbfCqQiaqfcN?=
 =?us-ascii?Q?869vQz7oOyA2fGV7NzDg32Kg6HjVhbMcILlRt14d95si/vaDXuHTqChPvrxt?=
 =?us-ascii?Q?Rfi/1zdHdL6x+4oLCayvsArdrYIbx+87pGo5zXO77C5mx1urXIvWv26bTzm2?=
 =?us-ascii?Q?gbTXmD+WGpsSuUaJrMZs0rPscFu0zhYRvmAayoWBNwadAH982zWso3BAPsh3?=
 =?us-ascii?Q?4YSFS9N5mKE9sKiTgjWGowG2OtMz+lY0CJqaaY2PMNRoJj3zEJahsv0DBJFF?=
 =?us-ascii?Q?sELphcPqAPEFzpewVIzJB6/suIJsTKeu3Ys632HQYxAakbNGmg=3D=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 16:48:27.7663 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8786c4bc-4733-478c-9800-08dcf902ada2
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009BA1.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1P195MB1572
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

Our SoMs are available in multiple configurations, managed via device
tree overlays. To determine the specific variant in use, we read the
EEPROM and apply the appropriate overlays during boot to the device tree
used by the OS.

Apply overlays for phyCORE-AM62x and phyCORE-AM64x SoMs.
Future K3 SoMs will be able to reuse this logic and overlays.

Wadim Egorov (6):
  configs: phycore_am62x_a53_defconfig: Add SoM overlays to
    OF_OVERLAY_LIST
  configs: phycore_am64x_a53_defconfig: Add SoM overlays to
    OF_OVERLAY_LIST
  configs: phycore_am64x_a53_defconfig: Enable PHYTEC_SOM_DETECTION
  arm: dts: k3-am625-phycore-som-binman: Add SoM overlays
  arm: dts: k3-am642-phycore-som-binman: Add SoM overlays
  board: phytec: common: k3: Apply SoM-specific overlays to OS device
    tree

 arch/arm/dts/k3-am625-phycore-som-binman.dtsi | 54 +++++++++++++-
 arch/arm/dts/k3-am642-phycore-som-binman.dtsi | 54 +++++++++++++-
 board/phytec/common/k3/board.c                | 73 +++++++++++++++++++
 configs/phycore_am62x_a53_defconfig           |  1 +
 configs/phycore_am64x_a53_defconfig           |  4 +-
 5 files changed, 183 insertions(+), 3 deletions(-)

-- 
2.34.1

