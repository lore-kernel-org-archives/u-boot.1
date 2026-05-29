Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28174CD5BD1
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 03:26:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0AB984659;
	Fri, 29 May 2026 05:26:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1106D846B4; Fri, 29 May 2026 05:26:40 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on2071d.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::71d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 847FF8341A
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 05:26:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i1zk1a3ZlZlpx6Ff/wOGvD0Zl/VYay4V9WnDsYmFWM3H5fSgXMCaFZsNJAQ+Spp/417Ci9rskPLOkxZZ3Zi48yOPQ/ni+gH+ywnoUx12CPbbweEDxSZp1STjUg2AcJlfmfdxOlmy95Bpf1xUT2OthNSSfFxkE68lcbmc3tUI18rZG0I61DkjMve4Hcip7vZZXxqCvEu0DexUlhjqqwX2PNGN4ytdZ9Id/NN9Z5n3eHtWWJnGgSbqP7NmpQwlNhlqBt0ny4J2lGWbtSH5XHz5jhOE4MENbOYveOZT7Mtm/u5mkjypVr9bPUINqasNcsdh9Eb4qudFIlYM6cqhc7+QAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wxUn3nkhK1orSJu3gHdqptJlD+lATgInsyZYbZtxNss=;
 b=OAqMRofithqKAWOwq/NhKY32sFi7ZcPH1amnSVtbYZAkgSmfsm6s3yvh1eMSKjObobKblscLfa2Y4dCjLs2SxZVcZSeyGDX+ofhfRQ+nkITYwRgrIuYRdkFjt/utnKe+l3ftffWAu43q1OI65J/HtJEj9EFRjnYNH1RApzZ3zNTUncgHrJktbUUdbjgOPpevaAwa9cLRSuht9DnM6JsLctP0wDbLKAnVICTcYC53AG9UUCW4N062rRfMRCT7lNzuTmDA46Ozdl5LGc5M2hIPul5QswmShHCjJExGNCHxQLEDrJlQwd9/aefEmVMqbCtNFEyrEFVdrdZu9++DzYcjAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1210.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:11::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 03:26:32 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::4386:5cc4:3bc4:4795]) by
 ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn ([fe80::4386:5cc4:3bc4:4795%3])
 with mapi id 15.21.0071.014; Fri, 29 May 2026 03:26:32 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo Yu-Chi Liang <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Rick Chen <rick@andestech.com>, Sumit Garg <sumit.garg@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, E Shattow <e@freeshell.de>
Cc: Hal Feng <hal.feng@starfivetech.com>,
	u-boot@lists.denx.de
Subject: [RESEND v2 0/2] Add support for StarFive VisionFive 2 Lite eMMC board
Date: Fri, 29 May 2026 11:26:22 +0800
Message-ID: <20260529032624.6868-1-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0022.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::23) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1210:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f7eb908-ab66-4e24-bc5e-08debd32146f
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: D5Ht9tRES5Y+73VYmm2jCkEHK3Pf9YXy8VHlRESOis++B5ei3bYahnCpazX52EZvzK9CmudWbe1eF1q65VhHpa2DEjf7Hnb1OBfsLiAenaJTmjaS1LMf5FFsgaEPkigAOlR61dL5E8c1eJDoxKDpDwhNSrCJm+WqaC5sWTxVJ9joX8dmORTvyBDSeP6i817lumWoJo5RK7jL/KE/mTcdGU7RWfILBgXIGu9nkNH2yQIxENy7GtcZopOH9t73L2JghUdTqxcuXAR22GsIxls/KqHDWamYIbpYVeI8782H6PMI9BF8UHFgCjgLwMmuvO3rbudGkM16I7rf/oipQVY+i+qmKeguTVGh0RD6U/iw8yYawNAOlym6fONA3R259cs/Y23LzCGNFfL2DUw/lm8yzpXFfZ9vLN+MDE4vw1vomDKzMdexcu8m4V6expU5VIa6hOZ+lSvaL1iD4LCenH7Tq0gMaP+hIIRJ8YhwAc3B5WQ/aEkvZBMp9sbvJmGUZFaG1s8xmdQCwL8VkBDxSMUuLYU5g5ttk+/h7O7kqINtQSlScn++JRJsOxelOMEQ2y0h
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OZw86LhePmcITKz1W8daJ/vHDmvTszT7rvfyoq8GaJ+OrfEHVqAnzcucf3R7?=
 =?us-ascii?Q?zWLRElpW3hBYLaQKiKgSZcyU7R7RDRqcECvoYHtaLxG5UCIyRF8bhn0lV0dI?=
 =?us-ascii?Q?CNeTo70SjF4GjIjfph1vPvCWLcLovdll9Tm+uwbMA5/Md2NR15dVncoJlUWV?=
 =?us-ascii?Q?KKHaunyKTSfy07W0vrWRCvubpBI+F2ZZmci1UVHMmY+aPFGYRnsGNCpv1a4n?=
 =?us-ascii?Q?CqiJfqw0hg3gsHFpaeqPwhTQU/J3Ca20b1bcOW4gE1xR5iGRSTv82niHihJ6?=
 =?us-ascii?Q?ZPR3BRK+LsofpCAnK/42xwYoKu1WcxSmRWXovSi2LRMsqBDtbf3bxg//rjaL?=
 =?us-ascii?Q?53zavciJyraXav7opfa/7P34OBUeBfd4jpNXKBXQ8nm8EwUtfkBOQU6CfXgJ?=
 =?us-ascii?Q?H75dKVHujbjuLANX+nXyfKGo/nFm2z9+auDnXGIgrWqAiJKiPUqmvIJAtNiY?=
 =?us-ascii?Q?grTx971MzKjWp17RXbo5gKUrXTyW3dWKVR/gx4FIzWLnlUQ+KMNzhNcjfGAz?=
 =?us-ascii?Q?qY+siUN9Qbow87FJrwRA2ukh2pK51wte/lcac50c49kHLg/1zQ08s7nHdsji?=
 =?us-ascii?Q?M6zX8dmPlWt8Wiu3XdhhtHVUAsAtmmzAOW4606MvcRFD2qgfcqjwrnPMXJJf?=
 =?us-ascii?Q?9/x1Q8x51J0AalEh4/xCPcOoB6kcUNF1tjFMWIZOAiQIkK1cUA5Xc5A9sC6R?=
 =?us-ascii?Q?+BlX4gaUuzscdDI1Ghx+NSkPVMm3yCb83cM1QQuOi34bHcGAeB95gHrOwVeu?=
 =?us-ascii?Q?/4dcsEeqJhUu4acj0H8H2sywIDIc6p0dKVrnmFB/D19CNHH6T1Exg8Wi8i/T?=
 =?us-ascii?Q?DGoTBO2a3K2E7mVbTD8UldVopNoZqj7G4gpYjvJw08siSmFrko0G09BdV6pd?=
 =?us-ascii?Q?AHF6gHcnJ1PwzAR1wtWUo/PaFmATSnwM+9pY94w5sn1PvOaPhJNL+x/MDSA8?=
 =?us-ascii?Q?aGx/alUNh28zB7kTWBqTMVHi+/YIbqkIvQBMj3xrzm6nqO4jr2Yb1cSoOLJc?=
 =?us-ascii?Q?FIBJhXhloOhNfTvtOdpBde60k0bCcJI9XIfXl+iYPscg8yaCxe+a2TYGk+hi?=
 =?us-ascii?Q?ugC7nfutQ1v9uy73u15DW0RuPMiXvfIni6CrYrahLeht4+pEYx1qwZA+K0zD?=
 =?us-ascii?Q?lp71J40hs9pngy3egzU0l5haBmEXIn4WU76m/+6ezMOa2jWYY27o/8Z4PRj/?=
 =?us-ascii?Q?/2edU54KlZ6L0nqqFqfKOSb4GWrxk5wS77ZufejiiqHcKd+4S3QbelfY7MEM?=
 =?us-ascii?Q?ag9wwy1gYTtRmxYcS4bbks/SqoUvfGON1MuGhT2QE5cfcSwdv/ocRMy9zSFt?=
 =?us-ascii?Q?A2P31E8fzNbvwpg/oSYp8KmIpj4x0t2QQtpO6KJqdS/Jxghu/iKLP9DYQUNh?=
 =?us-ascii?Q?rxDJCEjtl/byH3REwVDcJfMm8uJ5zSVmvrMJC3ErXf8jo6Pkk5w38u179zVV?=
 =?us-ascii?Q?5mQi9RxB7xUa0KjhmpXQ7nk/qsKsKxjFSMRRNjokOdsi/0WXflsGKoXeGVj8?=
 =?us-ascii?Q?3S2dZb+ABP+LZYWHG5s/67aQ4JIQZT/tNtaDzzvzMDN1iK1AV2JeQ/q3SoCt?=
 =?us-ascii?Q?A7x9+l+Uo0VfNx9n7etg6Yb1uWhKy/NZYtvdphtBkigGU0yzjJCbbqBmbmRh?=
 =?us-ascii?Q?vCeBJWP8gfvFLyOLezUj5WIe65g7CFXbZvmj8gynCRANbtGXPe82e6I2M8Mt?=
 =?us-ascii?Q?yx7UFQedNFk7bppSgG3NIL857b9/gOJwPunkidHZ+TF9dR0OA5F041h8o1dV?=
 =?us-ascii?Q?OiVEBLW/4/y+5WEwu9ciYw9rGhexqJo=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f7eb908-ab66-4e24-bc5e-08debd32146f
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 03:26:32.4253 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iBlEZCfATXUiooapU905gLn4tWAcBlShsvSm0lG0iWyq97fhwIDV41FKMSTrwQ56g8P8yb5gEpCk9Cp68Bxl4+gFdw+uCuhyZlJ+Jgmym1Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1210
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


base-commit: 987907ae4bcc5d6055bdf7d318a3edf53e14d5fa
-- 
2.43.2

