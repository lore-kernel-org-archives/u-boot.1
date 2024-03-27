Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 283C6C54E67
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 12:12:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 829B98802E;
	Wed, 27 Mar 2024 13:12:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="yrycsHf2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35BC2880E8; Wed, 27 Mar 2024 13:12:04 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B4548801A
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 13:12:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UwCbQ8xtbdXJ3cqLmHQgttPq6dNfpQz8qC/huPMyVvGWDrOD1sYceFjT7GbsE0yzzSEHR4KxRHZXZI8qVkT6QNovUrb/eBCTOEYRlZ+OUBqjM/52YMbYsdwLisDbe11IxIAUel74h4M9URgG5vNmHKHmtUbG5bt+ZM2NdJAC/0W/LbKuuQdg02bpMW6By5MFawtStw5a/ob267i4SFmETegovpBJvwpY0Q0LhJgHvxTb7Hp+wgNwi4gSYKYAgPwsBRc98a44aBCbkzQFTIr3iFrAZsLXkgSNsma6YsEnSv6wZRF4DV+ujnP+j7RMwlRpdEEwnCv0wqngzvdeFv6MBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cgLMiurSnjRmvYd5iJSp0z270hOY2W3Tr1V0UY9ghLY=;
 b=KveoV/34b4ODarPwpbV5BKBfztbSHVnNCpbLZhYKPtX8vmnJrQ3hYCHSqYVTBRmYtZ3K0oL+jq8uU8oDyAurpMSL6fiWvMr4FUze1A1ufLtLjKPIwGfqTMbcYIIXdG1LEKXFK2lRjyvwNLG/9WkqlmulH8qj3zjjDsMKcW2xoTomnmKoha03q17ZhtTwCuTDiI/yt1/oYysz/8sNNZ0HVQjPnZ0vgllEr5Te39FHsbeLWc6nlm8W2/2xawkNFPvXanI2ZUtqxYMLgjNF6lpiyZMh/y/Frp1aHwcN2i/Q4lw5EbWVlcw2ZNhnnI/ySgKzWidYT8pzonIgxjjjcGAPaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgLMiurSnjRmvYd5iJSp0z270hOY2W3Tr1V0UY9ghLY=;
 b=yrycsHf2jHkSvwsNnBahXlF6eX/6cYh7/zHexKKwH0PSewDE/TRkhX+dbooev8ayx6Aii+NVvWCKPB4aLygQwSEYcp5b502xCyQVlxsEI6J3K+Rxn20IJSnr+iXTOv6YHMjbG8hfG2MH8253Hz3o8o+UisxQx1UZRJimvxJ2ZeI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by PA4PR08MB6303.eurprd08.prod.outlook.com (2603:10a6:102:e5::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 12:12:00 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::d003:60c0:6918:8a5]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::d003:60c0:6918:8a5%6]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 12:12:00 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Lukas Funke <lukas.funke@weidmueller.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>,
 Bin Meng <bmeng@tinylab.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Chanho Park <chanho61.park@samsung.com>,
 =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>,
 Devarsh Thakkar <devarsht@ti.com>, Fabio Estevam <festevam@denx.de>,
 Jonas Karlman <jonas@kwiboo.se>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Marek Vasut <marex@denx.de>, Mayuresh Chitale <mchitale@ventanamicro.com>,
 Michal Simek <michal.simek@amd.com>, Nikhil M Jain <n-jain1@ti.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Suniel Mahesh <sunil@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Yang Xiwen <forbidden405@outlook.com>
Subject: [PATCH v3 0/2] Introduce spl_soc_init() for SoC specific
 initialization
Date: Wed, 27 Mar 2024 13:11:51 +0100
Message-Id: <20240327121153.2455126-1-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0038.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::21) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|PA4PR08MB6303:EE_
X-MS-Office365-Filtering-Correlation-Id: 49db6623-b7d1-4d8c-f59d-08dc4e571b02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SlGGpLYczWIiHJMb2GqXGOXemYp1h81zbIY9GVHsml4HMF4e8riLCvCzcqaqondYa4BYVaEUdzstGzJ+wpLY51oy7xSm01r9rVGNPo9AUzHEYw85imXYfLd7RXudcteTjrxtsU+ub+HrJF7w4lqWfv71bN6zaIkOJuPqJ631wVbyH5+ypLWOh9nr6C8d0YxhiwZOXBOhmYilIyaHwN4hQ7eUzUWyGrircGuA40JRnrysA/zVLyF3k6Ip+QNGScBmmMhsL10oIchMZt3CSkXGxGmJqcpBPPUoFHLgbCsSnROtp9i5gvgb0GNQkxs+QzcOUcKiRCw8kaJ5YOVJvnQIPIMSuiM+Uzv4ZMUEGTUXMiawdiWLV6939OItGLGFzOm9/+iG5WIObQQ/zpc4r0LU8vtTn1Ddd7k8i/iL4GwhUsMuK5xFyF7GOu89BXCDL+YzIcMz6En8nxvAb7wAx0FTfwi5SI39FQdDF3fh14PXjmVS2gyjlOnW84WSrSc78VYAxiwOZTNz5L+ImymYLa/v9V7SkmGt1O2D/QTbiETfjHqVy4Rv9hCWl5Qp5dFsiNRrx+flx1hl/vk5Ejt/hyGFOxb0keyhnoNC+K9YNqbJAF4cY0G7nCH5fAiru8SIYLDPhhYWjyc4VcAgDAF2RIM3HrrXYDZmfYvHRBpTYaJXecC/2h+KNl+1ZEXMZCUair9skC45QoTuY3gxoTdAD+hDVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(7416005)(52116005)(1800799015)(366007)(38350700005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mMyxoPFRagvPK/dIus+7CObIrUGs8sgTOYXtOIZdowP4pcE8qahCTbe2qNiN?=
 =?us-ascii?Q?LwTuMzG2xNCRKGbzYd5wNM2jZVnxjVBZGqHZjyNh7JX3vPxQ4in6yhfyQ5U1?=
 =?us-ascii?Q?Xs1Q+lVx5ZnjOqF2YphyoLx7dyDGNKbMwbsRSeSwTQLC1JKldMBIcam5evdH?=
 =?us-ascii?Q?LW0FynVV+/6ZrW/1Wv10FwhpPRH5L62jq5h/MGJjn0zH8CTpQlxvok8we/hU?=
 =?us-ascii?Q?VRjoCjyGbjV0SlC9GFpXX7ya8LvTCo4jOax22Z+8qFSnFsnd3dMYWPG4A2Ih?=
 =?us-ascii?Q?uoUAoB68Cp237JK9X56nexWt0+SQeWVQj/gFCDXwv8cdJulkuHmtyXRrtk8t?=
 =?us-ascii?Q?zFizKrrKTbnaJVRa8Am8LPoLJtkmXnSVfZBd//MHESLxFDcUoythtmOr1ND6?=
 =?us-ascii?Q?xPNLxwdN3fkSg1LEbR1nR+klaRHerqsHuLh+pzn0NnEAvTARzFS+bq4Bpl/U?=
 =?us-ascii?Q?gcoLO7Ly3c1KlDUdtKvZD/P6Rj3iFU2qb76tKeXsOeWWT9fhyNFmrhDspH3D?=
 =?us-ascii?Q?JjetRrdFjzfEVoYzNmvSWYTClkV4N99/RCysZPKynM5Jn1IY3SUvj0PFfLTW?=
 =?us-ascii?Q?uovJESG/2c/CeUeu6tATROJN+89tJLBQtcKFd903hGhdp7EleS589V1JPciB?=
 =?us-ascii?Q?CR7GuJNbNrH3kwEhEnY/k8LhMRHNZaKFa8qvx8JZkMvgSl8FFGsqjhT/8uko?=
 =?us-ascii?Q?73UwVgPn2+z0zAnlMgZLG0UXthojklGnEO+1pIXx8WxMgqec8CwUBqoaMJ33?=
 =?us-ascii?Q?geIWCjBcigSdjd7BbsSzgO+fu+b2Lc17ctN++LXWSwtWotyvGhEygOAFuOFE?=
 =?us-ascii?Q?C+S2jXt0dOrRB7vGKn2fZAKtLvo4ZPcR8ev6RL40SBlQy4rFmlkqnFCqJ6zx?=
 =?us-ascii?Q?iZKneiv2dPxo45Fk3IyFAisHh7aryz5WitoDJOe7ue+oT/GryAIGZExqB+km?=
 =?us-ascii?Q?A+nqhRUcs6MMJxg1+GyCbcRJ8n/WsUU8BI2hdz+J1NLYG2NQAWlh9Ama5Vck?=
 =?us-ascii?Q?ZOjPfKoFW4/AmXedueU4XOFNBXvKlLE2VhRyRjPF4njWH9tflnCRPPK8MmDW?=
 =?us-ascii?Q?S45YL/+ze+2jtiSmqdxwaJvrT2Omoo3GBxzom+D0QN6uivl9oQDuz3abuDlF?=
 =?us-ascii?Q?GcShe6Kd3QYKyj+rcQLbFY7CwBpz+SptClte2R5EuLeXemdM+rXHtWykRY3V?=
 =?us-ascii?Q?l7M8FECs1ubSiGDMqpvEQPhg8w7PGRUQaVDDNX9CqiL7iDc/uAbN4Eny1wkh?=
 =?us-ascii?Q?RO6flqr1fNuVIn6pAJEET8HRI+a4rQu8KsD5XIZg9ugJT/BudXJU1i0GqgoK?=
 =?us-ascii?Q?oSN6xrNo3jtZoLJOuAQuutMv/H0JsVkhPzwigsQW/mt7sDEDe3ArBN1sJ8iw?=
 =?us-ascii?Q?uXhNoJIDVoe7+s6m5v1vf6jPkuUsUT029ixs+Td3mMUUQm2+29RAY6hLobI0?=
 =?us-ascii?Q?CAumUc/XKOEdW+Z2YV/gvcO4rW9RiI4AFQUg2SmH2xg7FDnRcYCrM3OWi+lI?=
 =?us-ascii?Q?FZvPeSSaxxt2BGw/F8zID6X82Rc9VZMM3sh0YsmRDC3Jsn9kESZ3it0TuTTv?=
 =?us-ascii?Q?Iv+YLiJu5RWTLa6uxcKacsp07a4R8rmYHrnffeCtzWj7zQdy+gP5KMdFw6qb?=
 =?us-ascii?Q?+g=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49db6623-b7d1-4d8c-f59d-08dc4e571b02
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 12:12:00.3447 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9/xAgOHtRouOJZr+uA3/3i/b1BiqcwpADEwhNb6dU5fgEUQXZsb9W7oKS9pGS2kftu7+coP+sFjdYLuW1zEbzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6303
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

From: Lukas Funke <lukas.funke@weidmueller.com>


Currently some vendors use spl_board_init() for their SoC
specific initialization. This prohibits board developers from adding
board init code using said function. This series introduces a new
function in order to separate SoC init code from board init code.


Changes in v3:
 - Rephrase Kconfig description and correct minor typo

Changes in v2:
 - Change spl_arch_init() to spl_soc_init()

Lukas Funke (2):
  spl: Introduce SoC specific init function
  arm64: zynq(mp): Rename spl_board_init() to spl_soc_init()

 arch/arm/Kconfig           | 4 ++--
 arch/arm/mach-zynq/spl.c   | 4 ++--
 arch/arm/mach-zynqmp/spl.c | 4 ++--
 common/spl/Kconfig         | 7 +++++++
 common/spl/spl.c           | 3 +++
 include/spl.h              | 8 ++++++++
 6 files changed, 24 insertions(+), 6 deletions(-)

-- 
2.30.2

