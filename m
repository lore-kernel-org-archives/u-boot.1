Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E67EC43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 13:35:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0FFE84C21;
	Mon, 13 Jul 2026 15:35:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="cgLo/0LC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE15384C20; Mon, 13 Jul 2026 15:35:01 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3459484B93
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 15:34:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=orDfT4REJ1m1Ax0oiGZBPj+i3vVCL3W9Be+2J34s8g9yt3EsDEY0I0psoh3ZmVJ2Yyr+R1Cpxr+dz76PVEWlq7We7vGIomFWz/hZ1jdgUZdyXpuRLDM1GkAltUBoL8tU87j7UbBYemxIbWpdMonN50fhHUYPCuPVE3nPPyo/J+5C/k+HXK4m8HkT02t6lzOtLcoaKT9WHRR0Q9vWJuygnG0JlQRSAtKAQz1lDUmVvcq5fc+zoc8RdRCvsMguH5SO6PMOgK8BOGOlWzCx7TNcNPDABPWcEwaxeUQk4t0O5Wdr2LhVMm2jADf+9gR2LMw6fB1tig+OijSMqPwun3pK1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=asieMkrPtB+EAi2toPhwjFlKOoyzRztD/53M7LGYRNo=;
 b=OWjJIVjPCeM+lV+JOd3mTC4AHN9+caYi/XWph60XCKMleUcHFStuPe/NdbB2elYifMBUVieM7TufylwdrmgvPG55gxMzBCSHeBnjnGLRbujWGA5Q4RcRi8+o+OWYBp0mQ8TYze8hY/0ozIO+rxgQ7GSZjiS9XUdF6eCKukZSoW2fXvye23x6Gn883jZEPyrZ7iomG4mTdNV/FznMAMiSdUrGEzKfkethCpPqpt33cMQTiHI5S3fh/XJcW4YJP3OMn+Sta5d5MJXbTYZZhc0puVErgp6CpYPTWc/3X7u4OTdrQWBQPUB6gyCP95z6Q2TKMSB6IlPc5Sl3HZoGKysi5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=asieMkrPtB+EAi2toPhwjFlKOoyzRztD/53M7LGYRNo=;
 b=cgLo/0LCcFNvoZLwa8B8NmrGwy1WMnLrM/3BDxCGE7Qoj8FbBXvLjt0scUSA4MA7Glz2oo1rIAWytWlQMGCEwYdA4yQUNQrwHDz6SpGr3HLCTPCtu6nbB/s7R3tiSc+1LIfBgnTN83GSVHqKka3V679kJ7bbN0uBc06nfLaCUJuiF9YrixRs7EwsWW0sL+2TghcpJLaZDNKCJZjGI4jk7TWF1Y/rVCevUnjh6XFG6RtNlw7x5MAcsNqhvQax9fjekgMEpHg8m5fGdwLKf9oB0tTcy8dLBD0n/YEF/m1kX1LLGEJnP7fdJJlBrzd25ayild+rdbGTi03jsmTSe4G+fQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AS8PR04MB9011.eurprd04.prod.outlook.com (2603:10a6:20b:42f::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 13:34:56 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0202.018; Mon, 13 Jul 2026
 13:34:56 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 13 Jul 2026 21:32:55 +0800
Subject: [PATCH v2 4/5] mmc: fix mmc_bwrite() ignoring host get_b_max()
 callback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-mmc-fix-v2-4-b0ba3b4a8d97@nxp.com>
References: <20260713-mmc-fix-v2-0-b0ba3b4a8d97@nxp.com>
In-Reply-To: <20260713-mmc-fix-v2-0-b0ba3b4a8d97@nxp.com>
To: u-boot@lists.denx.de
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Jens Wiklander <jenswi@kernel.org>, 
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>, 
 Yanir Levin <yanir.levin@tandemg.com>, 
 Eran Moshe <emoshe@gsitechnology.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Christoph Stoidner <c.stoidner@phytec.de>, 
 Tanmay Kathpalia <tanmay.kathpalia@gmail.com>, 
 Jimmy Durand Wesolowski <jimmy.wesolowski@mobileye.com>, 
 Iulian Banaga <iulianeugen.banaga@mobileye.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI2PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:4:196::23) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|AS8PR04MB9011:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ec7ea8d-86a4-48e1-7651-08dee0e386f5
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|19092799006|23010399003|18002099003|22082099003|6133799003|56012099006|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info: NJILvlUiBu9TdWTVBNQ0wTvid7Lr6Q9lxjFQkI82g0xJ1t5l42Ah3ZAy/90s5AIFOYndkekW5GMcgrMQfRIVCKaPl5F57QCX2NLE+/cGUEYJ+F846DWm8+x6cr1oGgRdxBrwz8DfEjXu9NMakiKlATJ6PGh1c+eAYkcKd7nbDkGYs91fpallsF7oC3pgBTP0riM6Cyxmz5LZU5N4Pnq10XzdSQot6qwNBF9yM1LQFIAt0HJ1DTPDaK25Rtc12rcrMAl7llNDvEMRXjiLO54pWTJYDGug7oyiHQC1nTX6Fcba+QINs10lgdomZjxw9bgiMhrJrm6U8ucJtUYS3v60bEzsDzdF/ssK3/sRBQd4i1yDiwXuZaZ4aOMZH+Ky85Lbtb4WEl7UZb2ByrDyWgSH+1qMaIbcIK1tDBrOcEAY5QaHGMjkZ4DlxxDTjSBpsow5SzTyO8tlqcdFW/c2sP4qvSh6H3vStpMJC/4ZsWQH8dhmiX/AE3QCLeCFXbs0HsXFJyAGuPOy4Y8dMIuYEhmhRvSI80xjMeRKU+E4MLjmdaKBfA88zIvP8tF986st7agvQQoQsV2BA2PAo3EM0tEPGj8eaa5pEmLrJhOHh5b9wD7+bXpE8+qNb82cWSKbKKtGpplRnlTS1ZWg/ef4Pxv8nHLIODM/BTo7Uu9JQ5DGloQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(19092799006)(23010399003)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3FPSkdjUnFQZGtIZVVJek54eVN4WVI2UXkxRjFpdFNCR0svRkpEbXppZmRj?=
 =?utf-8?B?ZVh5My91eUpGVVY1U1pjTnVoTXJ4WEpWQ1RrRFB3eW55aHRGRUx3Ty9ndUFm?=
 =?utf-8?B?bnFGbXZCcXZmZlpiN2hUMGs1bEFhZmNCaTBPQ0NOOG1WQSswRnV4eDRJU2hz?=
 =?utf-8?B?Y3VvWWxrSVhWaXRtMVVWWDhNRUx1N0F3KzlvdEhsalVtY1luNDJiTFFQU3VM?=
 =?utf-8?B?Y240UkFPSmdSUlNlR3IvWStWWDlXMFdtNzk2eEJpM2VDVzdnU2QwS1p0V0dz?=
 =?utf-8?B?L2Z2czA4SXFyNjFjR0ZCYmlDWFFubk9xMEJjTU9XV3ZrUVdVazZmUkRONjdE?=
 =?utf-8?B?VDAxVTBQc21sRXByYzFjOXdKcTFaNnlQcjB1d1RHaCtNQXZkVjc2ajcvZ1VC?=
 =?utf-8?B?ZEpMRXlDV2xCMkwwWGoxN2pPQ0Q2dGVYUi9OWFluNE9KSlMzbGNXMngyK2Zx?=
 =?utf-8?B?WDgvLzJjQitsL3pyb0JxZmtMeFhyek9oWlg4RWhFeVg1NUEwbDdYaHVSZVlJ?=
 =?utf-8?B?M3VWMVB6MHdhbVlEbHJKTkpvcXY3bEJlMmwvSHNWZXZHQmI4VHV0QXlweUdL?=
 =?utf-8?B?ck0xVTh3YjBVWnRnYXZJckg3VmVwQjF6TE5oWGdqYkQwNDNVeWgyL2pOVlN5?=
 =?utf-8?B?U25pZkJQOFZrc2wraVl5R2NiL0xBazJsaHhNeTFMOHpsbk1aRWp0ajAzbm5y?=
 =?utf-8?B?QUdOOTNqTklSdFIza0VOK3l3STJCcHU3MWo4d0R2U2Nud05ZWmx3TlVod0Y3?=
 =?utf-8?B?aEZWbm5vR2RFSTUxczB1MnAvVlpmRlpYdHdtbTE5SHJKWVlLMDJxMko4Vzlx?=
 =?utf-8?B?TjRIMVMzaVlYM08vZGhxRi9ZcVBDQ2FBT0hCd2tZTGNOTWN4YjdvYmQ4S2xn?=
 =?utf-8?B?aVZqK0RaayswdkZKWFNNYjNFdUhScS9MaTZ1aGYxRk5BMXEvTHhSa29Hdlhj?=
 =?utf-8?B?R01zeHBXNHVhWjRnR1AzeXBHVzRPSko1cGs3eHVROG03cU9ESGoxV0RuTHlt?=
 =?utf-8?B?Wlh0ejFlNzFveS9jejRHSFhSNDZialNVZTUxSEVUdmkwa2tOODA3RFY3UWIy?=
 =?utf-8?B?WjFlb2hURFNJYVRuRURub0hYdmh2bGVUVUMwRXBWM09PTm4rTVYxMFJGYytN?=
 =?utf-8?B?ejlwUTN0RzZtVXFVTVB2RFd2VHFFM3FCSDVpYW90Zk9Jd2ZUTUpjNlpzaUZD?=
 =?utf-8?B?S1NmZDFSaVlwNEhHR1ROVzBXLzhCZ2pCczlaZ0o2VCs3REE4MUZaNjFNcXR3?=
 =?utf-8?B?V2NhSUY3dkhRT2hDendPa0RacUhDS0Z0ZCtUbWdmNHZ1TXM5TVRpcDBrYUp1?=
 =?utf-8?B?Nk9VeHFyRXVKczVSZmFEVTdQVDZGR3JyNE1xQWFoeHppN1Yvc0YrTVRqQXUr?=
 =?utf-8?B?bFFNVzhtVzR6MjVxanNmbExKWVlzMW9ZNW1MTi96UUw2ZjA3RkJuZ1poSXF2?=
 =?utf-8?B?WVdheG0zVDBNdnhKU2NaaEIrUlZUNmlURHc2VEZWZkkvdWJVcThranV6OE1V?=
 =?utf-8?B?WFIvSzgrRnQzeGtoOHVzSTBMa1duRE1LZG54T0kxMnpBUExFNEZhSkx1Q1NH?=
 =?utf-8?B?cWU3K1g4enRYR1VWdjIwTSsrL3UxYkt5YjBsaGV3aCtOQ2NuRERRZDEzRTdy?=
 =?utf-8?B?eloxZXJYbVVuZ3A1WHRsdFZIc1YySzU2T2NtM1A5dDljRUVueFhiWlJiNDB5?=
 =?utf-8?B?U2w0cjRoQ3RsSXlEZHBxTCswaE1oL0VzL2tvNElxQzE5czRDUFBrVVhwN2lR?=
 =?utf-8?B?bmZnbTJSZm9MWTJZZjBUc29QdFZxSk5vdTEwTlAvbyttb0RYN2RCT1lxSE1I?=
 =?utf-8?B?WWdQRUZVQ2w2bUxBWjg4NWdBY1RZMFZVQUpMbVJFVTBCWTNTUDBOcURzUVBh?=
 =?utf-8?B?aytWcFhobXo1bmV3ZG9uRHQwdDY2dWQxRk1KOXpXTC9YSmV5bFFzeDlxY3lv?=
 =?utf-8?B?KytkcytvTGtlOWZENEdhMStTOEg2dTlId2pEblpBME8yeWM3cHF3TDRJd1F1?=
 =?utf-8?B?Y0NoVGRaTktxSkVaWXZXNVE2QjFGZUFaTUNmemVBaEkvQXNRQnRaYWljcVV2?=
 =?utf-8?B?UVlIeEZkR1orYUFLcGZzU1dldkpIQmZJQlUrZTZFRHlpMHJJdjlrbUlVdVVq?=
 =?utf-8?B?c1RoS3l2ZjJJUUh0QmhvbTh2Z0d4dmdOajRmR2NYeHBZTzFCbjNGTElUajIy?=
 =?utf-8?B?T0RIQktHTnk1SzFoUDJwVkpZT0d0bHptYzV2MU42czJZUkdmMXVCRzdodWEz?=
 =?utf-8?B?RDdPeFc3Y0xxTnlYcTU4WGVlV1UvNTdXQVB3KzlqM0JYY0dsbEZvTk5lZ29r?=
 =?utf-8?B?N253enZWczRjVzlFcEtaWS8yR0ZHUlRGWUV0MGxadmVNZ2ZiQ3o0OG4zVGRK?=
 =?utf-8?Q?UE8dNfsUYCZtHLLa8NQo6LjMO9n1w95X4vyl+?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ec7ea8d-86a4-48e1-7651-08dee0e386f5
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 13:34:56.0521 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p/MQNaRYeVhj8gBk7XmVmlqld/y7HiQmmWO+OuJeqvP6XzgI6s0jxHGl8eKvhBooBRyoJecszXf3l6EvaNiyyGtXmKVy2x4dnK/kPshuU8wTnkN0iCxCYyhUZJTbAU5S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9011
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

From: Peng Fan <peng.fan@nxp.com>

mmc_bwrite() uses mmc->cfg->b_max directly to limit per-transfer block
count. The read path (mmc_bread()) correctly calls mmc_get_b_max()
which dispatches to the host driver get_b_max() callback. This callback
allows host drivers to enforce DMA boundary constraints based on the
buffer address.

Fix mmc_bwrite() to use mmc_get_b_max() to match the read path. This
requires removing the static qualifier from the non-DM mmc_get_b_max()
and adding its declaration to mmc_private.h.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mmc/mmc.c         | 2 +-
 drivers/mmc/mmc_private.h | 4 ++++
 drivers/mmc/mmc_write.c   | 6 ++++--
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index ef7defcde71..5fd12d21f92 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -490,7 +490,7 @@ static int mmc_read_blocks(struct mmc *mmc, void *dst, lbaint_t start,
 }
 
 #if !CONFIG_IS_ENABLED(DM_MMC)
-static int mmc_get_b_max(struct mmc *mmc, void *dst, lbaint_t blkcnt)
+int mmc_get_b_max(struct mmc *mmc, void *dst, lbaint_t blkcnt)
 {
 	if (mmc->cfg->ops->get_b_max)
 		return mmc->cfg->ops->get_b_max(mmc, dst, blkcnt);
diff --git a/drivers/mmc/mmc_private.h b/drivers/mmc/mmc_private.h
index fc45f017e5d..24e68ceb5e6 100644
--- a/drivers/mmc/mmc_private.h
+++ b/drivers/mmc/mmc_private.h
@@ -17,6 +17,10 @@ int mmc_poll_for_busy(struct mmc *mmc, int timeout);
 
 int mmc_set_blocklen(struct mmc *mmc, int len);
 
+#if !CONFIG_IS_ENABLED(DM_MMC)
+int mmc_get_b_max(struct mmc *mmc, void *dst, lbaint_t blkcnt);
+#endif
+
 #if CONFIG_IS_ENABLED(BLK)
 ulong mmc_bread(struct udevice *dev, lbaint_t start, lbaint_t blkcnt,
 		void *dst);
diff --git a/drivers/mmc/mmc_write.c b/drivers/mmc/mmc_write.c
index 928c05872ca..9cf07b4ad1f 100644
--- a/drivers/mmc/mmc_write.c
+++ b/drivers/mmc/mmc_write.c
@@ -228,6 +228,7 @@ ulong mmc_bwrite(struct blk_desc *block_dev, lbaint_t start, lbaint_t blkcnt,
 	int dev_num = block_dev->devnum;
 	lbaint_t cur, blocks_todo = blkcnt;
 	int err;
+	uint b_max;
 
 	struct mmc *mmc = find_mmc_device(dev_num);
 	if (!mmc)
@@ -240,9 +241,10 @@ ulong mmc_bwrite(struct blk_desc *block_dev, lbaint_t start, lbaint_t blkcnt,
 	if (mmc_set_blocklen(mmc, mmc->write_bl_len))
 		return 0;
 
+	b_max = mmc_get_b_max(mmc, (void *)src, blkcnt);
+
 	do {
-		cur = (blocks_todo > mmc->cfg->b_max) ?
-			mmc->cfg->b_max : blocks_todo;
+		cur = (blocks_todo > b_max) ? b_max : blocks_todo;
 		if (mmc_write_blocks(mmc, start, cur, src) != cur)
 			return 0;
 		blocks_todo -= cur;

-- 
2.51.0

