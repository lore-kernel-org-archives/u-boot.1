Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28D99CD3430
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 13:42:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FDAA846A4;
	Mon,  4 May 2026 15:42:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3879584686; Mon,  4 May 2026 15:41:59 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20720.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::720])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77E0284686
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 15:41:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q2CUaswZyxNLjef50E1kPWCsbvXw7M28gw6GBXAWtUkPEq4VhYYGmNkU/03brny74j+XbxQKcJv/Y2YIO5ZVUsRHxHDFxcgekIn8Dtw8axcXuILtnNKZQZepf7IXkqP/K96cCiZKoPCEbQWioobhC5stR7LReiJxc01hB9Q449gybvPn8mRpJJNk52KN+93RzGBrpihPksltoqxYUoEP4hsxjsQ91dgXdSX8RjwelJKe3n+g/2LMCTLIRXwls2rdRjZjOJIsFWxyb4vXNTgzf5Fk8QrNRwZXT/30p1Sf7ws4loxBN/5ERaYs+MTbhRKD/Qd2/Xvs/9uWRIkNW1IeAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fjigp+dzTgKTF6douLieRxVaEcEGjKWX5zVq3zNarB4=;
 b=WFPQiNL9+VYzbnb9sZ3EeHmX3CiFZ2/17zR4W6oXZuIrtH5kMfe/O5aHpQTpSYy25oj/y/UGJHPxEMu76cSJyHLAnXG6VBBuWmQegkaYXiulqbZRNHOQNlLptFaY6pYbIAn/7ij9+Hruf4KS13mxsb6Mwct5E6nWthSxvxd+XO1uTOSy51qrOfNgHgOnMIb7XGjL2d4Squi1xNL6D20KEiR1Ed/eKos3yEzFC7tYCLg1Wb19vspqLYUD3F+uHxL1Q1+Vj7U8YqG8cASLN2Sy6DCsU87EvuimEgiyxJGEqntdS+btJZjxywI3/zQlAT1nqV18tqHpuawL9yBgxw1jvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1227.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 13:41:43 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::4386:5cc4:3bc4:4795]) by
 ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn ([fe80::4386:5cc4:3bc4:4795%4])
 with mapi id 15.20.9870.023; Mon, 4 May 2026 13:41:43 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo Yu-Chi Liang <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Rick Chen <rick@andestech.com>, Sumit Garg <sumit.garg@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, E Shattow <e@freeshell.de>
Cc: Hal Feng <hal.feng@starfivetech.com>,
	u-boot@lists.denx.de
Subject: [PATCH v2 0/2] Add support for StarFive VisionFive 2 Lite eMMC board
Date: Mon,  4 May 2026 21:41:33 +0800
Message-ID: <20260504134135.4542-1-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJSPR01CA0017.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:c::29) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1227:EE_
X-MS-Office365-Filtering-Correlation-Id: a1354706-8bb0-43ff-270f-08dea9e2e095
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|52116014|38350700014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: xLOl7P5sf5sES9OR7teflraE/53QK+harSlCMNtmTSrKmNSvXiAuvdM+8FRF1deApVDW0w6oaCkTaNBVlBttosCkq3SUga2Mse9YbAbIDTb+lCgw6yjf7DLSKOfey0H0nlWHp+3OPYnBO3TH9nPvVNH7pVzaZcVRZUl+GGFKUYPNxRcQhNuXUrjQO6IPavBlYzSbPh5XUJI+64rMxGEPAo4JafFXxHdsiQux1MpBZOKLT6p64HzgjIsxYac22jrZpqLJi+D37tLdUgbvR3jtBWL2K5f6P6kWqrA6NyX4akR/tpdywy7hEPJ5PDjH7aR60DYxzOC2g4hDxfW0GePUZQbuhU/BJeq8xz8L16m4HJ4nkA/Bx2JiNo+5Y3tHr0+o3wgqYRa0s92UyuYQjA6PX/fIFLdC5ayQCr182JV0Ny9cDuflMgnetIhg+Tgp1TS7Y7TEqC3vc3hhhdl+75XJ0LVjLJlX+CtJbNpwyrz3tHuvX3NRMx1l8HWSiFmIxT4/FMJB+zz2b/f+JUD4mTSjZVck5fX3JQlKTG5i0D0O+qSWuoOk6xZkeL9HaWj2d3vk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(52116014)(38350700014)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y6ACAgtPihTM5eWSz/dyA+/i/2tvjslqfx3IOQADqWmmVIJwbHzdPSWPz0cb?=
 =?us-ascii?Q?dRP6CauAa1ZDWOI8xOqxXwgV7o5INQ2EegmOMxKgAOq/E+d00yajjhaVdRKd?=
 =?us-ascii?Q?PxmF2oL0OZmu8WM3iajT8ZWfESOTeiNpgezDTa5CYhFIRgHPXlugYpXYGcot?=
 =?us-ascii?Q?PFJZQ2k3Xzp63lwqdXSCYiGLS3icz3kXDvCmSK3jP1v5/jqOaXDBXehShQRz?=
 =?us-ascii?Q?MpoElxZOdhQf+2yC6ppIWDIPWgTQkFrn5vVkKQAgCP6v4nrUygnNqn1vpMtw?=
 =?us-ascii?Q?F+vggMIKbhJqmtIt6ZOLnPD5PcE9eCFvHcaS7FJoQgOB+ZGSiCVA/8b+0JsK?=
 =?us-ascii?Q?aqwYFN5F0IFCudMTrRFf6riM0O+IlQDm2GT2/kOLdkZPcVpxFK+ZFNsQqByp?=
 =?us-ascii?Q?ll+9VkfoZhmb4nr7Op4XaEcgW/ieJqVdJgHiUyi/PZaWqUiR8VX06wa/FK71?=
 =?us-ascii?Q?M5xM0fVs9HLidLCd9ZZQdoxY+x2e+Lxc09J3lADSn+uDydGPmw0nU9FsqXWw?=
 =?us-ascii?Q?gqJXQJfL0jW9JOfJ4YZWV91R07sVfcPn4RT7xBtTjYsSgZT+ykLIZxNmqX2P?=
 =?us-ascii?Q?rFqG0iegmJfHtV56ALOdRmdK8gIqkPbqcx+sTAn1CIns3xxoTHZ/n9LjrJeS?=
 =?us-ascii?Q?b2Gl9zXsc0MzCT63jFyE5Qu2JooSvCMX53+5rrgabVVsYfdhs1BbrkdCJAKf?=
 =?us-ascii?Q?I+vO3gGatV9zzRBM/nbUh/IPrk0Pt2OxH4X1nsWwfIGD9H1wxG/2D6LFIcbE?=
 =?us-ascii?Q?wlJ7v7860pQHsanUuPVRfYPRho67yebF5FIOfissKHvXhaYm/MuI9FxNXgwx?=
 =?us-ascii?Q?lMKWaRu2xqtKA8F5L4Fhwmx5JDAz0UR7bodZ4aZP+vQ0NRmayEzoqgpmf96r?=
 =?us-ascii?Q?jnkIyX83Miq3UOm4h5wzIsSroLWrgzuzpHY8OwhW2S6l93PUFK6wI0D7+6JE?=
 =?us-ascii?Q?R5BPjlbQ86K0+ESSxORfBOmzthnxuYteAbB50bzfZ4X6M58b222njOHfENfC?=
 =?us-ascii?Q?H+3msg0DxiadrRa7Aiet/8AEa99p9+FPmHlweCnfOyQoCyUbw2a9QUlQdHw3?=
 =?us-ascii?Q?xzmmEpA7Dfsu4CLc5bPKKCZvaySet1HteBEX83/aew3258IrzbnvI7rZZu9f?=
 =?us-ascii?Q?NHryuWMnU61B/eGLY6kQS1yUpNfr7Xx/BxJftaObn7tUZ9+vdspFQx3ambzg?=
 =?us-ascii?Q?VnCilCQR8HpVtAV30pv4JsGQLxVeY1nzej5TxBfqHzLj9jslwA4Zn6Ucfosb?=
 =?us-ascii?Q?DQ283UlU/UAm0Y/j3bI4d0JUB3DsS7TpdbnSlnRs4bRKqOk3NFNDVgD9YpCy?=
 =?us-ascii?Q?y4OdWZJgsJ4N16+E2ff7fFj9nEbVcEUBtuNQchg23HrTGFdrJ5F89mfoN1z/?=
 =?us-ascii?Q?DYROr3BNnbbnhE+1Q3lNlep22M650yzBO+Qn72k9j2hyaGCDnMjBrLO/ApB9?=
 =?us-ascii?Q?W4XVPTVp59GepQJXBdNBbHSQs57IYybcIjYz4nfyr35yJO2iewmGq9D1Pkit?=
 =?us-ascii?Q?YbIDPnZeVNr9C8WmOZ3XlT83bIIfj2WNpTD9vm+MbwXXtd3aef/4uHxP1dAn?=
 =?us-ascii?Q?aL1f7Yd1e2YOL/SdsnqKDQLX9HAZxJ5P1LYvrpl9SY6qcnFKPcAj2GmaZaoz?=
 =?us-ascii?Q?j/RvpyqIrYL8WJOtnDqhT87sk+yqemWAOmEnhaNbrAjjO69WOJ5og7g8Bs03?=
 =?us-ascii?Q?a+vwq1HY7N9vTEXe9NNbh+RRyFB9KgXOpJVrOL7fgPFl+XN3GuakDnGFHcXt?=
 =?us-ascii?Q?tlxrgqsBAaXcEb0rztEoJwDmK0typAw=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1354706-8bb0-43ff-270f-08dea9e2e095
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 13:41:43.1132 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9VfMQE2/uOH34SK+chpxmpGcWb1yrnemFT6iORe/C7u0ZnwsMbT1yZTwppkbShZR0z+zOu8wJ8CqVZK+2kdnaH6rp79EcpvSCvwYIgROhaw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1227
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

VisionFive 2 Lite eMMC board uses the eMMC as storage component instead
of the MicroSD card in VisionFive 2 Lite board. The device tree of
VisionFive 2 Lite eMMC board is already upstream in Linux, so add support
in u-boot also.

Changes since v1:
- Add Reviewed-by tag from E Shattow.

Hal Feng (2):
  configs: visionfive2: Add VisionFive 2 Lite eMMC DT to OF_LIST
  board: starfive: visionfive2: Support VisionFive 2 Lite eMMC

 board/starfive/visionfive2/spl.c                  | 7 ++++++-
 board/starfive/visionfive2/starfive_visionfive2.c | 6 +++++-
 configs/starfive_visionfive2_defconfig            | 2 +-
 3 files changed, 12 insertions(+), 3 deletions(-)


base-commit: bb0f3eebb3c196d9b6efbbd1e5aa9b16abbb9ad6
-- 
2.43.2

