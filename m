Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6506FD6ACC4
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 12:18:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 446F2897D4;
	Wed, 27 Nov 2024 13:18:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="eS+AyhAL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 864CC897DA; Wed, 27 Nov 2024 13:18:00 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on2071b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::71b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84D6E897C3
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 13:17:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uoGc82AWPZDfA5vTanx3Zq62G+WRkbWCrW60NdLFILS9lVYdO353BUG0rRt4BKLGXHlLY76wzpLVYqOMktj39OEgXkVqSBj4EFIMSxmhOzBa+YopS5Zzf3TgYj5O5pxUAU6Aj2So3HLQt1sF2SGCzVAnyj4sZI/OiGvXn1oYVFw65dESudFc8kMW8tIP0FzVx4xjY/iivbkGaDeR03U0v2aP4/FbDRJiW8RrEz94a4VWIulXknJu71LFN29NtjYN3JklSfrDNkE7LC3oqR143Ba35YWtiXTrKY6ZiJ/Lv+3ABfX2tL/JwNljbO4RM1ws9oWe7f3jDD8Y2rLVz+2K6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zHbgHBnuO1iHjiPUCcQu7jxw+a0qZtF1DV21okYgKA=;
 b=TnOYA08aUk3ugp00/DFHjTCIeBoc8A4BAKVfEsGj5PANAUO0wVrQOrPMWFAbMWw4UaUBR/owKrZck5bJXgJPUhFG6MdfLB5thEGUdeHUjxXuwX23BShixOY2CqatSpd17gphKxzz7yvOtsuFvu6j6lwUvrMmPdLlfH+IJhhTbShlwRGgla5JLEk551Lc5oKSrru3/ZhY+RnMG41MV2XK3xSZm1NiOT5Tzl5mjacGe6VKUl6UcGXL+hW7boDNxybJMNrTec81ZsBxFyovT/HRZ7YjJkMaXOXpvu2BajDbRwmj40NVtSb0mgsn/1LORbTXae8dMnLmNnt+N9a6aVVlSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zHbgHBnuO1iHjiPUCcQu7jxw+a0qZtF1DV21okYgKA=;
 b=eS+AyhALn0t1vA70HbYJKP22WAwv/NyDcSyKPl7jjE0pVRjIaSevqF3KyJeQQUFcTkSnSxRyEcJX2cybX1ivWU0wQzpvQ3rorqg+AQ2Hq0KtwSePQ0rXDUTuzT8g8dMCAo0q3fRhkBIJ6/QA9EC/iq5ZLTp1dBOx07kV5ymkeog=
Received: from DUZPR01CA0350.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::22) by AS8P195MB1334.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:3c8::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Wed, 27 Nov
 2024 12:17:54 +0000
Received: from DU6PEPF0000B622.eurprd02.prod.outlook.com
 (2603:10a6:10:4b8:cafe::ea) by DUZPR01CA0350.outlook.office365.com
 (2603:10a6:10:4b8::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.13 via Frontend Transport; Wed,
 27 Nov 2024 12:17:54 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU6PEPF0000B622.mail.protection.outlook.com (10.167.8.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.12 via Frontend Transport; Wed, 27 Nov 2024 12:17:54 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 27 Nov
 2024 13:17:53 +0100
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 27 Nov
 2024 13:17:53 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <trini@konsulko.com>, <n-francis@ti.com>, <d-gole@ti.com>, <afd@ti.com>,
 <nm@ti.com>, <d.schultz@phytec.de>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: [PATCH 0/4] Enable EFI capsule updates for PHYTEC K3 SoMs
Date: Wed, 27 Nov 2024 13:17:32 +0100
Message-ID: <20241127121736.1525948-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B622:EE_|AS8P195MB1334:EE_
X-MS-Office365-Filtering-Correlation-Id: d2dbc99b-9395-4f01-b016-08dd0edd852f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UcqHGHbFcLHyS2JgxObssnr92cBvk9Q4DlzA4/KanP9n+PiKu34E75D5s+lC?=
 =?us-ascii?Q?PgHEuOBGqq54RXvXc47DvuZ7j80/B3quTwqAZZJdlJy4/VD/9XYxpJo7V6sv?=
 =?us-ascii?Q?anhgikgbOHFZOJnIgDJEGxgIYy5N250x2oY34ODi0iYdKXAj0pYLTG6Bmvkv?=
 =?us-ascii?Q?wRezGgTP+RZU22Wz38FG3EIrLMXYFtk7GH6xRvv8mNxfrI/nyPX0+uaAdOB6?=
 =?us-ascii?Q?G0YkTq5ibtcYvdNCDoJvbhuWCnCFeZQinvLuwfO6jYm9kFvmwWJApK/0pUEL?=
 =?us-ascii?Q?IGeyCD1B6m3Ev1ij3fa2Uml/BdJn7/ywI8E2XR8iGXVCKSIeX6CeeKcuyy4D?=
 =?us-ascii?Q?Op2Po3u0+SD9fTRcYTHa2yMPdEkpSG7+Vru98pgK48NiFeUZmbLWPBAhzeB7?=
 =?us-ascii?Q?oa974LFvisC9scizFRmbB9fQO5Ic5APjCOMRVhzA3LmEO6+eMrv1LQ2KJmkC?=
 =?us-ascii?Q?RF8dTh/hkyHsTGM9wf2/nw5e43ungTBbTIZyuXQOk/d/PQjU+39wwzUGtwMT?=
 =?us-ascii?Q?xpwZJ/za7CrE2Tqjg77jKG4qU11KJEl0iDHadUgGT+IM8l3z3l0WQkBoyuxL?=
 =?us-ascii?Q?2meUljW5x8vMIJFX0O8PnkZVwztntabFm7tX7cBQrwxNcM9+fv69OBRM4MuK?=
 =?us-ascii?Q?SJb3xqINTBTscP19dYghGlpFb3bNtGA4oLyI/PpgPqxBZ6D4FaFgHFNCRg1p?=
 =?us-ascii?Q?MF8pi3mAC75+P/sWgO7AHvDCfFl0lMWWRnMYPb54HP/0BOe4pUmnlswvUI8B?=
 =?us-ascii?Q?Ey/VMPr0Acy0k0TIb2+gSHuAwVtFQRw6vwO6s8CPvfxwCl34ULo5inKN7GM9?=
 =?us-ascii?Q?S98f3v9H6laDq7I4W7jnCXpxKERONxvEq7f35nZt8OWp82gK7g4pNkpoftfb?=
 =?us-ascii?Q?WHo1A3Jet0x/Zqt8M+6rrk/o07Q0W4VK3KTR1ZauIzsm+cn7pZwEE0n7HWGG?=
 =?us-ascii?Q?DW5jCYPZk49m39px0HH3Ss985XPdkxsyClOVCFCdY0HamxJ6cn9U2eFWGGOJ?=
 =?us-ascii?Q?JfMBG5k8fzwQFq2RXVGNV1NqsG1hdQQmY/9EhNO2ooyb5waHVrCELPfcYGfs?=
 =?us-ascii?Q?CHNYEXmZD0MdqmzmYfsnJ+IlKJRpBl4tppOyswm+46824NhMM7f4uCDeMqiA?=
 =?us-ascii?Q?2orrCG9kZ0SHJsaMrr/hADle2Ys5heGHwHMAc3dFXcw1Lq6b7iVMXL+AX0n1?=
 =?us-ascii?Q?EqTtVCYCjHLG7uFX2dOMG7X3Mq7Ft7Lm/FpPv29Yaekrt/4O//RAjCsjGnym?=
 =?us-ascii?Q?ezLg+xZ+npKa+JqYsRIOjcHF8DIQ5bgRO0lIEmJqwkLIKaj7VbrXkF0TfUJP?=
 =?us-ascii?Q?ETRS6ZpQU4Cw2LNBHn4P4MkeqdiW2o6nAL2MrjSuf0dRU/w9n+PxnWekDMZN?=
 =?us-ascii?Q?2QMfn92HJVDZ1pP/hZ/P3hkZjU50dVqVpnyN2ZTb+2/nwD03KTfVyfE7UCAn?=
 =?us-ascii?Q?Pu5BRY076Nx8d3ZAiHewBNiLuJEal/9I?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 12:17:54.0909 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2dbc99b-9395-4f01-b016-08dd0edd852f
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B622.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P195MB1334
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

This implements capsule updates for all our K3 SoMs for
eMMC, OSPI NOR and uSD cards.

We can use capsule updates to update the bootloader on all our
supported flash devices.

Wadim Egorov (4):
  arm: dts: k3-am625-phycore-som-binman: Provide capsule nodes
  arm: dts: k3-am642-phycore-som-binman: Provide capsule nodes
  board: phytec: k3: Add EFI capsule update support
  configs: phycore_am6*_a53_defconfig: Enable capsule update

 arch/arm/dts/k3-am625-phycore-som-binman.dtsi | 39 +++++++++
 arch/arm/dts/k3-am642-phycore-som-binman.dtsi | 38 +++++++++
 board/phytec/common/k3/board.c                | 80 +++++++++++++++++++
 configs/phycore_am62x_a53_defconfig           | 10 +++
 configs/phycore_am64x_a53_defconfig           |  8 ++
 include/configs/phycore_am62x.h               |  4 +
 include/configs/phycore_am64x.h               |  4 +
 7 files changed, 183 insertions(+)

-- 
2.34.1

