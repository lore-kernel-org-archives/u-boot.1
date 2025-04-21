Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E181C369AB
	for <u-boot@archiver.kernel.org>; Mon, 21 Apr 2025 16:51:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9408281B4B;
	Mon, 21 Apr 2025 18:51:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="vjbuUYuz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB95981F0D; Mon, 21 Apr 2025 07:12:23 +0200 (CEST)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8886B81DE3
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 07:12:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tingting.meng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a32ttLI79QQ0ieymCU1FOlhHiX+uC9UM0UWfRO+WKy/jRJJKk1IX5J3crw/OOmB5bsUOUB85t7NoZchZqx3D8gkmYfC4DQZ6FA/xtcD8BDBvNRaYbA2WASFmz0rwbvWI3TdpMZw+xqAYW5/Fn+ApKaQyhpysvW5iPExhGUxahyeD75yyigSZf2/JMTCzH+F7DRdeBu0DDKAqY+4j9rBr5yw8Ct32CfP0WpnQuQuZ7yE6ErFFKjA1+56OV5j0ysQ2UrpWo2CvVKtA0hvALkQDjuRJ3M1EIlAtpGf+LAsgjwvGjPCS293QHef6hfa/WAMGH6P75YSGwTdebeqyHa7IOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G00STd2FPYs6yDJa0WWn40jpgPwzDv64xoGSgD2lLrM=;
 b=eY7jCHj+qyY/gB1KM8GBxrTaS/etO8b/vKUG03d4g+f6nrOGY1peBL1Ev7Ri2HB+ZK/QMeuFjcl2kmmiwXsOikorNrnU7r4iowdl+VHt99xkKd6k55LyFyv9QmPRrIDa/Tmchv1q3ppNZ8nUGSXNQ30pcQl9DelIWD0RqH/lEKkru+Q1aFQ4mQcY52y5JslIh18aZjWkrfdG4P0AFRKBJ4EcUzxlhhyot+UnCd959K57csSZ8FC58tB5WAdL6fSskSXelPtXwc+PwulVcfBqijin7gub6sCp3NrQlcdhTRuCuvXuPORtMFwAz5T5x3bKF3tfRXwoWU3/WwMuOU/4sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G00STd2FPYs6yDJa0WWn40jpgPwzDv64xoGSgD2lLrM=;
 b=vjbuUYuzovTX+yC7qTdQ219Su51hZYmywiELM4W/kX3i8szAOW8muKN+SCJGLyepJxAxc8uYd0FqA097F+8nKUie40BTjhYsa7mtOT0YRCXqUKE0hqxuqofU4maQvZW99+Gw85DmI6x4EStGUeVQfnkfr5bGlSrRrr+YLgsNehAgJSZDj3yrW9QfhHKZQdAs/WRr3XW+xsfPvSQcmvzV+JNtBqJGR3HG/7PgoNGsQXUCEypQHNWbrC5jSdJqKts1PyrmWJ5y9vLkxb/Y09hmeZ17zitXKvFqt/T0eHKvm+T+e5Mq93OeXFn/7O3eLzzFXUuEpML1UhGPkT1B7x9z3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5621.namprd03.prod.outlook.com (2603:10b6:5:2c8::21)
 by SA1PR03MB7099.namprd03.prod.outlook.com (2603:10b6:806:330::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.30; Mon, 21 Apr
 2025 05:12:18 +0000
Received: from DS7PR03MB5621.namprd03.prod.outlook.com
 ([fe80::5337:db99:bde7:e33b]) by DS7PR03MB5621.namprd03.prod.outlook.com
 ([fe80::5337:db99:bde7:e33b%5]) with mapi id 15.20.8655.033; Mon, 21 Apr 2025
 05:12:18 +0000
From: tingting.meng@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Danish <danish.ahmad.rosdi@altera.com>,
 Hazim <muhammad.hazim.izzat.zamri@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>
Subject: [PATCH v1 1/5] arm: socfpga: agilex5: Add MMU mapping region
Date: Sun, 20 Apr 2025 22:11:26 -0700
Message-Id: <20250421051126.13799-1-tingting.meng@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0178.namprd05.prod.outlook.com
 (2603:10b6:a03:339::33) To DS7PR03MB5621.namprd03.prod.outlook.com
 (2603:10b6:5:2c8::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5621:EE_|SA1PR03MB7099:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f0b370d-3230-4f59-827b-08dd8093168a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9ra6VkWkqHt4Ylw5tqzPx96PicfIknlnF2B13F2cYNQY/TfKdHPjjJkvyEEq?=
 =?us-ascii?Q?vdr+QTjJ5QL4GrO26KZBBLjGQ0w85Ye+PXhSfiEEUZmcrCHzcr29vvj5LlF0?=
 =?us-ascii?Q?reDXhzwummmZ6N3E71620q4Sqil31NvAP3f5RpYmZFV2Advg6/guHQSsqnRQ?=
 =?us-ascii?Q?gndIfGcsXz40p+9A213ZgLWMMPsOu6Lgv+DU0bkmqDkJeo+W3gkaAdzfTUYq?=
 =?us-ascii?Q?G+w7dcH3SkmojtdH8Xnd6LjVLfiFrEAXgc1OJcAxuiX/h89/SgarB62LsGRb?=
 =?us-ascii?Q?NYmfQGZn4NRzfdg8/vqh9nap4OQaVmarS12Nerd4Ijk3BugoGsoG/psqERDC?=
 =?us-ascii?Q?oVCqVe/n8UKi59wiiKdh+LHGalzkGeRLbBAQuQwfVMPNjor+o30BmKY3mAkJ?=
 =?us-ascii?Q?SJ99J/p++tmCW7oqywsT65Dy6/LMODZyqy6+mmTtfw2CdFYXFYncChrILwTX?=
 =?us-ascii?Q?Mw92QvDr/ZKu0Ri2ObPbRQ7NIBRhMr2s6g0rYoGKj5uMXpBFidv1pX+FD2/b?=
 =?us-ascii?Q?x9zIeaFQwrpdQ36lvK009k1KdWG+hCjQclgeoqIydqtdYRj8EnXdn/u3Kb2d?=
 =?us-ascii?Q?sokFWD/M/MdbG7dZkmnweFsG6E1T0/9bTV30cBdTdH+UnNhRPehV7kfL0LYg?=
 =?us-ascii?Q?6gHOKGYOK8gi0UocJTb+6kckYUhdatRykY+Copl3R23DGWM6Fz7gpgeVFZmj?=
 =?us-ascii?Q?AcNCB8FEnn6Mh/wXohS68TcuNMtWEWWi7T+T27qKxjoowgGyMo+iOLop1aEB?=
 =?us-ascii?Q?cRrA0wBAedeXBX3p8gIM2FkWpV/n2Sc/qPFlDD7U+g4jqbhB6pqWwJHFiSuQ?=
 =?us-ascii?Q?ZdYdKP5igxzJ/Zd3MI3mMDY9alEIZrjhsxVCGgtGMD/bUOQXNMJXNFEzl7GV?=
 =?us-ascii?Q?ShCeUkIvhiLPgTTHg7EGc16oEN2d2DRPOXl92gC0DA2fYH9kHzEB0/v9Vl90?=
 =?us-ascii?Q?r4D0FQJYnJcEN6y5PoRtt+nikjwF2voL0nkAbhlaU8cnK/qUGmDRad6Xqkjx?=
 =?us-ascii?Q?sE4z9a4Uts4EIqkbE4Du5MkBp1flSz46B7DSPXeK0XgcRndukbSAdr3xHZyh?=
 =?us-ascii?Q?oQNfEWnzJe44HTBmmuRlKQksuMgvi0qFgVPH/B10RMNXkcrgoMHW06ccIx3G?=
 =?us-ascii?Q?vc+BN+onvt5Bhr9s44prGtsXMJ5Xyro6jJzIo1Zn5Wcc/24Hqf4yli8bW25F?=
 =?us-ascii?Q?zvrlJ88V+88HW3BDIYNKqY/cSV08H+XX0jVb0DaDwTGhKqIHP8pjUSWDRoU3?=
 =?us-ascii?Q?n86dtrJ7YW+lUJ0yts5u8XX8QllhD7e9nGbtM7p/K7DvGV9MYYTRHE6yaIlF?=
 =?us-ascii?Q?OU7+Xtu+dny83VcA8oZF8f+zdzTZyN6Yx+a++veBjPOtHaW5zpYBahpNWG1y?=
 =?us-ascii?Q?7JwOBeT9zyByhqDQikmLw4VVcFt3wr9mbOnuDG9NOHenNPZ6BH80t6BpHrFp?=
 =?us-ascii?Q?+K7YXJamhkc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5621.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qZ0gsWHJTZj7R+SK8W0bnxZ6EeWvyWimwxdhoU+gOmd3NSgK/zW2WbYkRZNC?=
 =?us-ascii?Q?XpeIaHBwGFhrciWO224J2PXzYO5UVK+Svjq9DdufcDG7GyEEKd0wI/Fb1Qfm?=
 =?us-ascii?Q?G1W2mJV6vG6d1TE71BCgeH3ZG1/4epKozV6Jpl0IZ3DAFjJqCSyhzLFkNikY?=
 =?us-ascii?Q?D/Pp+6fHb9voJ8Oo/pGrN6MV+mo54Y2KVewwppeRL6UBa95X+yQr+CHJKNwh?=
 =?us-ascii?Q?QBoy0QNdiqW3o9aQaZmAGqzCJbEExnWs3hpGNZRNzewH8z4fDae4jM2B+8/G?=
 =?us-ascii?Q?asdKNUPfb4pEqwv1hRgSoo3hFZDWtFBVSgyYdyN9d/fjJRx01YnclCasZXHq?=
 =?us-ascii?Q?aNX5nRkaQ5IZI1Vq03SvW8IbmDmstwwKPH4dxuaZy0h7aqKwTOIK20HjUuPa?=
 =?us-ascii?Q?TKniidxCdEgbekJ7CnREl2qHAX3SZn7JUSDi2uCzjPEjaUc2ktAnAhYu2sgA?=
 =?us-ascii?Q?yLpw73zTDVGkDxauZroaqj0ocq6dylbG8zFp34DFT0Ies/DpT5f6fRcXh9A/?=
 =?us-ascii?Q?ZYHtyIQO3S43DtZ4zUdy9VWQapVz1yp8iAtTdz8lxzw4USvI6xfLGaz91qEG?=
 =?us-ascii?Q?iVqMlmjOxbxcZfcOKC4H+/FPJY/YfIvPhHcpUh95Mjt4c+dL42sqingVHiaG?=
 =?us-ascii?Q?lCeaRPxi72MF/Pc7+iCzsLYN9N5niD5Kh6A7b3UvNTPp9Xmj/17BdANPAHcf?=
 =?us-ascii?Q?7y+kzOY+FhYj2V+yoXb5eTcYqbm7p+MTWcIQ/ij429o/Jd8mDz9lDWtdJ2r0?=
 =?us-ascii?Q?hlV3nEyEZuMEba1OK7DBMeTRZyentknfD2r87k2LfM2mldASSpSDGtimjc19?=
 =?us-ascii?Q?W+sUKQpFS+boxL9Qlzd/i1Z/rVqY49lK495/i2S+cOezrRYnAATrdPTUsCB3?=
 =?us-ascii?Q?uVvoKx2PKv0rcJ81Vxdxepa/KrumxqFu4xKrp44GZEJi6pZwylzeOgxN+AlV?=
 =?us-ascii?Q?AIq24p+KfOZHvQ87lHUIKus9hT7mSq91uWLzXobOXCoYjxnah4d36Dqb50ot?=
 =?us-ascii?Q?RsdnsKD+XphdFSqbH85EZhdKsfsUj3nH5LRjRi4VadP3CAFsWexG9uT6+3+t?=
 =?us-ascii?Q?/xGyqqvO59aG793XZZ33A8V5aUZW1PXtDWpZHxUhoyiBQVPuPU7EZ/QSVbg0?=
 =?us-ascii?Q?WXutEYR8S9S7aqBmzBBwr8K2UzcSPCETZGgwjludq+UhEs/D99Zry5jkrfp9?=
 =?us-ascii?Q?hOiW/XP5//qdybP7GijNyx/Ty+WOAv+MsWNB9qkSWUB5ZhI5jzkx9wadS2fC?=
 =?us-ascii?Q?y/qQ309IMQzj5j1Vp1toi18LeTGnEhwKtUfqUE8nnrvKZ6jtUhnLTdW/Pwt/?=
 =?us-ascii?Q?Z4pQsIDI4KoLtm/ztsl8Es6T3m8vcW4RbxaOzdzWheS6Q2DUcZmyDiBTYcF6?=
 =?us-ascii?Q?t/Qxx9LPGWHrTgNVmARRAhL/hkIJL6PGjZ7ZTKOQdTGCPcmV9mognZNU6Gud?=
 =?us-ascii?Q?BUzugRaAmJmep6slECkQVy/BYbP0xrmAoOfBURv98gQ8BpXBTrE7rg5oOvzG?=
 =?us-ascii?Q?YFCIL2HOweTmBcooODkm2LXwPiYR2A6zftPaWOUoDirUHPNPfuYY0278HgX9?=
 =?us-ascii?Q?zRQ2W8+ktCmRQXGBYTfXpC0hVuQ67YWXQtrofbVPWEq1zsyvB6kJM99/pgH+?=
 =?us-ascii?Q?tQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f0b370d-3230-4f59-827b-08dd8093168a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5621.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 05:12:18.5942 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ZmsTLiYeX0xXE0FMSL4obX8yA9Nm6EhS1O4S9lecEP2G48p43zX4CVKY8VOCpasrBU2tqGFTxmke5bEWB1RxuE9kjB+zYAKTI8m49nzBSA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB7099
X-Mailman-Approved-At: Mon, 21 Apr 2025 18:51:44 +0200
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

From: Tingting Meng <tingting.meng@altera.com>

MMU mapping regions were added for the second and third DDR memory banks.

Signed-off-by: Tingting Meng <tingting.meng@altera.com>
---
 arch/arm/mach-socfpga/mmu-arm64_s10.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/mach-socfpga/mmu-arm64_s10.c b/arch/arm/mach-socfpga/mmu-arm64_s10.c
index b8e40d9a788..1dc44ab4797 100644
--- a/arch/arm/mach-socfpga/mmu-arm64_s10.c
+++ b/arch/arm/mach-socfpga/mmu-arm64_s10.c
@@ -57,6 +57,20 @@ static struct mm_region socfpga_agilex5_mem_map[] = {
 		.size	= 0x80000000UL,
 		.attrs	= PTE_BLOCK_MEMTYPE(MT_NORMAL) |
 				PTE_BLOCK_INNER_SHARE,
+	}, {
+		/* MEM 30GB */
+		.virt	= 0x880000000UL,
+		.phys	= 0x880000000UL,
+		.size	= 0x780000000UL,
+		.attrs	= PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+				PTE_BLOCK_INNER_SHARE,
+	}, {
+		/* MEM 480GB */
+		.virt	= 0x8800000000UL,
+		.phys	= 0x8800000000UL,
+		.size	= 0x7800000000UL,
+		.attrs	= PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+				PTE_BLOCK_INNER_SHARE,
 	}, {
 		/* List terminator */
 	},
-- 
2.25.1

