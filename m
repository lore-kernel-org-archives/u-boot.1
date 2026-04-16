Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51C7FF8A179
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 13:46:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B484841D5;
	Thu, 16 Apr 2026 15:46:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="fG15Jxs8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87B38841C2; Thu, 16 Apr 2026 15:46:48 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3387A841C2
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 15:46:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HyRqmwoGqQiY6qJAm+zO13AtnitBbXDZufdWtx04qcEWiZ4DtcQMjkpuTdQ5xTHu8Z1K9OsP/YOCeuwvJOacxQnhwm6IOw5R0r28U3eKtKN8hdtPD7QTXnFvTiV+7MXFOEM30kwq4UtZdyVsK0UHm9bpgTRnR2GxRDmVdxSE/9e2x64Oj3wRjNKUDol389CK2SCs77gpmwxD8s3QzE8tfk/5ze/NXM7AVUK2v8+edPKQR45F4xb/2dF9BEqRwr/l3EWfe11fSRWrXSmdgPfNRQDs+iu67AYG1COIiqm5oKbs+l2OsChbIM79eJPkW9RXf3e34BCWhCGepSDcgvUGuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iMxkjjHlXvrSPFKMvRKzYgEh+cZD/b8VdhX76JD3gjQ=;
 b=Bvmln4/2qcNuDj9yvN2s7giK0i3ElRY4Vs4B6XFXNcQ501RRCmN0pzOK+HHQP39kuBbxK6OT45++JWX/yKbE/tmIXKKhDsNcPvVLBKI0C8lm8U+ZgWg0T1bEmbdSKZr0fjmjnFzXCk9bEkGO0YyUPaejjMbwUaBHJMabCwkF/tFppNl7RtuBCSJ4CSdi60SW6uwBzTnNQiIziyIPYKa2dNXBW+m2mePhnW3C462OJSg9b1pBEt+bwIf6akwUbdQcQq9wlEKPP33zCe0jqX51GY+J5ZIqnRUxAyseRi/bBV0TH3KE7l4Ty+j7c00+GP66FmtZ1LKrT5sXq4U3jj3cgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iMxkjjHlXvrSPFKMvRKzYgEh+cZD/b8VdhX76JD3gjQ=;
 b=fG15Jxs8IF+ZPiTELsYEgHT5HZ3W202MNwIMivQ4AiYepGTlQLmmmY7qumonns2VrClWIHKWM0kBkUnGu6djhg9V+K4jwQE7fS2qeA/6FYMjTDcpR8HpKdCF489wQb1Czb2SmhQGm5DU8KVhZp4RJ42i2/WqMDQYkqGN4xxP2EUhvEZZISjVchkVLPvoQnkKNjAFTSS9nRf8VgIsysWw+V/8N1m7OfT68F73rgJg6Fh0LdWOQ5i/WttKAWJIGHsWTCjnyx4IRK1cbHDLSP8j4LRumUfdjbxAc5QvFhEPxTibMW8uFvevQJHWnIHHVSumERNGCLBZVoNyF5BAIrsyUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by PAXPR04MB8861.eurprd04.prod.outlook.com (2603:10a6:102:20c::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 16 Apr
 2026 13:46:43 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::5732:4a55:2959:6da1]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::5732:4a55:2959:6da1%4]) with mapi id 15.20.9818.023; Thu, 16 Apr 2026
 13:46:42 +0000
From: Ye Li <ye.li@nxp.com>
To: peng.fan@nxp.com
Cc: u-boot@lists.denx.de,
	ioana.ciornei@nxp.com,
	ye.li@oss.nxp.com
Subject: [PATCH] arm: layerscape: Check zero size memory bank before lmb_add
Date: Thu, 16 Apr 2026 21:48:38 +0800
Message-Id: <20260416134838.186098-1-ye.li@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0197.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::8) To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|PAXPR04MB8861:EE_
X-MS-Office365-Filtering-Correlation-Id: d478bb11-b807-463b-a56e-08de9bbe978d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|42112799006|366016|376014|19092799006|52116014|1800799024|38350700014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 7pQFdAQAjbbjJteqvgdRQn7It2wls5SWmhrYDNPyaWv0nNyQepaKZOId4FNJuoGsXaXpTm0QU8ZnBfq5brBKpGyWzhmeYz7fulDQxExewoy7jy9dJ3qxEaTo4e25CG/E3GYcaTOom6Ccx+0ANzUMNUiHiGEu4x1plKhTvbQxvVq9igHvBDvfmSXsm3A5tZl4ZQkbn+qnu04N+/+QzDDGy5dN3pDokYrclkGZeESuVgHnBj1izRuC4sbJQnmCUr3Ngq++pR4Vg48T49XlPJ/xFjEeOQaP39OFZiRbIzIrOj1V0IEXNoaDXKmoCGcj1/Qf4+hh3pEbdsKxL3U8hiY1mcI2O5DZB+ELrS1BSVJQUaBOvoGB+DOhOHOGOGJ3xWfttloiGXjRaA1bAfdDbGPPzen2jRXndN1ipdyABh3j4vyLFtjv61hOesTvM8/fmrFRVSH/miUOWfz9AJcMfUPPLRsWI3NMVUqVAPlWZUvhMxiIM02csBjwaOb2eLoHABpEfz40RQHqjOLNwW57TkeFO4Ek8aOqqoZ+umZrVlZEH9i0rlhjB1o76Uzp+mE3FJTDE06IpOZfMAjpFmHM+ZnxbNQxjKE5nReLa/Xd4dmliKOvt2HB/jJSaGui6ve55ry96eiC6wQKkrGt2dnuYYgpC4JY95C4OFR1MNnyjhuljqX0pbNuNsvfKNFWb6y9C0/6WyfT9gKwRt5jEAxnk7jwGyDrFoIr80eUWuTPV6zDzbUPkbVkcQSRSMlQtlzkS/wCiqa2HHj+Nmto4xpXdxUWEvt+HXa9kSeeThL7GjvgFuo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(366016)(376014)(19092799006)(52116014)(1800799024)(38350700014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J2QsfCCg4teZednFVn5SPG5/CapjQkpULMqGASmN4D0OiQd0UVUu6pKCVkye?=
 =?us-ascii?Q?Yrbs05OeyWx2e4x1gJaJ6rjy/ExyrXUf3xILXv+6IQ8szc9h6dmh0x3pmyOA?=
 =?us-ascii?Q?KQru5pidLdZmtoBM7cMez/CG9QHfT6IszF2As7deRcqHuQNNB/irm28SV+xp?=
 =?us-ascii?Q?P2c/641d3Z1H3i/MA3eYcKg+WfBPTpW59TxZ9tfMucoYD+Xz9ra47FQCAQxd?=
 =?us-ascii?Q?8IKlA8DuMNXdK46ZnFsoICjs0v+9CGXbQGaD2AFL2mf/fFQgkKs1KipKsBSr?=
 =?us-ascii?Q?E4L1SydgHKs8H7dbp1cNNYoSZAbKhOwFa2UVhjukE248HFKYwjbkVurJTC1F?=
 =?us-ascii?Q?KFFz+n0HP0e00hCP8FBrSpfX8cRygSNmH1oStilwcTfZPDytBw8Csc9YHg5i?=
 =?us-ascii?Q?PgtBBcAbMeEm2UM7a3TvsWvP4EgneP2TVxx4NcyzjLLy65ScfJA+1lq6evtH?=
 =?us-ascii?Q?Am393yRF7CXt7Dyj9Uitluiw5kkM/5MmvK1U3yQyEe0pKTLF0eerl5BMLlsE?=
 =?us-ascii?Q?XnzFPYyrA3L9PA/XbL13L3I1zE0HNOtfyZXyverq1IAgJzZNr8HGKDzIWwXG?=
 =?us-ascii?Q?dVuPyrZ/y73n0Mrsa7r3B92QldG1fLwhUy5ggOl8TS5GABz26cqFY1/xePGd?=
 =?us-ascii?Q?bjMZ3TjyFznuRDLU/2Ef1irTVRqmkHhcA/fV4x/wWX804cxaQqrzBJfNxwqE?=
 =?us-ascii?Q?0+coeOTrwpFS3BHAaftYFENHkyc+jW8vsBqdxNOETwIkWhy3fOHqjCnUP6Tg?=
 =?us-ascii?Q?hXFG6XGaWWc81/teUa3tX6BaFA9tspwk73X4ZmYzv7wUY2c6yv5TRNtIEylE?=
 =?us-ascii?Q?fKFPASAothPl2btVqTW4GfliwaO0PNeFxbTaOfmo0axrz7x90jutrEEloSTo?=
 =?us-ascii?Q?G/O6a7YblWv8I9eonko7x5M6+e7RnHRJpdYqV4iDoVeZ7/exzFxqshWdjAw1?=
 =?us-ascii?Q?lAx94ON7YQjhoN7oYnb9lfWBC1BidwBDUpZf7+fVU29zX8AVAb0B1El9RnsB?=
 =?us-ascii?Q?QhD9XAMRk/cd9g8M9rTCrJsbqJm1SGn7hxvLBi3AIAhAMwY96FeECYLRyPkg?=
 =?us-ascii?Q?aZl1sYMcsuhghCRaRhKh36GdiaDivvzVPDPc2LaOk0t7u8fl01yoveVO/Uk5?=
 =?us-ascii?Q?GV8W6Q5CzSL22klJiW27wcY6KLMVjVN8Cu09ltykhI+nhx3NjGbCa+oQNlcl?=
 =?us-ascii?Q?3XYu//E+7NMZH3MqWpANPk8Z3+H2Bk6BSJj2WGkUtFmTVdU+dDl1XhbU+rxj?=
 =?us-ascii?Q?y1C+GSefCA2Kn2y5WN2Fzy1ud/SiW7YqqWqR/UQ2WdRqBHAUlb1e8IMQrm3f?=
 =?us-ascii?Q?9RjBbxiOYcG6lJ6L+ihYKuJ10P0wzWdHwR2ckZh4KoOZ/IfEN+okXqKJhLPz?=
 =?us-ascii?Q?SQPRyVjQCbIa9LYPbzTjTuOu5gu2cUyB84AdjXfVI9sRau0Dr7PVJtWg8YjZ?=
 =?us-ascii?Q?NwPRO+Pz/y+DnJIAOOQXOnrw9aAwxsLPTkSe89pBvfda/B1QNd0tbK/pZXe9?=
 =?us-ascii?Q?hndll0ACt+4KeHT084Jgta13pDC8dMmIR/cVUZdvpJxGoqoDvbUIUvaSQUkT?=
 =?us-ascii?Q?biHEUIdcUZx2nlqhJA/MsHpyL94Wxi7vN+qIKBSzZGntN5tP7bu/UWSaqnKZ?=
 =?us-ascii?Q?8BjbLWO3dIF0jNeHpox8BGKUueWJfPMhbmg8FqjtjA7nuryJ1Kdd9HGKUMn6?=
 =?us-ascii?Q?ztTIj7aekbmD8VovJj2/XEvruHqrm5G9niBYxUmgpp3GgM/H?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d478bb11-b807-463b-a56e-08de9bbe978d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 13:46:42.4848 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YqmgvTD43GxytCFYnPFvlFr1bQfSgcZJrGhWyKtBgM6JqL7IDxiAhYyLOzLNCMfI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8861
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

In layerspace's lmb_arch_add_memory implementation, all memory bank
are added to lmb, even some is with zero size. This will cause lmb
treating it as overlap with available memory by lmb_addrs_overlap
and merge with available memory. Finally causing available memory
start address changed to 0.

For example, on LX2160, before zero memory bank added to lmb, there
are two available memory regions:
  - region 0, start 0x80000000, size 0x7be00000
  - region 1, start 0x2080000000, size 0x700000000
After zero size memory bank added, merge to one region:
  - region 0, start 0, size 0x2780000000
This wrong new region causes efi_memory_init issue when allocating bounce
buffer because of conflict address (with uboot reserved) is allocated.

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 arch/arm/cpu/armv8/fsl-layerscape/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/cpu/armv8/fsl-layerscape/cpu.c b/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
index cfbaa475701..7f0cb28f52d 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
+++ b/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
@@ -1549,7 +1549,8 @@ void lmb_arch_add_memory(void)
 		    gd->arch.resv_ram < ram_start + ram_size)
 			ram_size = gd->arch.resv_ram - ram_start;
 #endif
-		lmb_add(ram_start, ram_size);
+		if (ram_size > 0)
+			lmb_add(ram_start, ram_size);
 	}
 }
 #endif
-- 
2.37.1

