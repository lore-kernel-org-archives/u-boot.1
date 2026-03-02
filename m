Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90DBED58E5F
	for <u-boot@archiver.kernel.org>; Mon,  2 Mar 2026 06:38:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA80183EC6;
	Mon,  2 Mar 2026 07:38:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=vaisala.com header.i=@vaisala.com header.b="CIsEweq9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 083D783F14; Mon,  2 Mar 2026 07:38:15 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC02B83D17
 for <u-boot@lists.denx.de>; Mon,  2 Mar 2026 07:38:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=niko.mauno@vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oTh34UilEW/6+7bN4ur0nM5EFu32U+D4oEBXNtCDYWhL/ONGlpIvxmN0etbU67LjiUEuk+bxP3V4foqlWm0qIW3iTKDY6jguZSO735NghvfpG7znQyfQZvtPXT1N+iYhJDDFJ4umUssLi6q3Nd6RnzrtnqAZdcXY8//E5v/73l+TXeGvrL9bda8wO/HgfXewVvMeY0a3p25lgA+3bIENVDSViDModuV3mbLrCBi9qvtLshapx9lwPX+stRlmtt+7EiWG+xKhD6iYXIjScaBlDMu6iheluvh6Ed0fMczNfdmJ32WIV+AMOePRdbvGc5OKl/j3c/IRSX4vKH+fF0uUhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4PZG68d5seess1YdSlW+00GrCK8sgIMr43dt9jZtZBc=;
 b=N13pYYJEBdtm/LLLRVAd1Cj9Ei1PMl0KxZoOrK7ZjoPGaRtQZsTNbas6TldqRRvGSrO71R70H16SSG0jcIR+I3HRssiDnyZXKMaAZO4toAqfTdFFKr6dyDhH3ormXtBuwR03dTgsZdQudlDkWQ577OjknRpvl/6cztNdjKozUgIQivVC3CTNxlOgziauW5p/pXax5wN/5Y3wfirA4jAnZx8RwzA/i1Fmy6w+2Z25iVrifeWfr8L4id9xanWI7O+hJEe4ARjKKHXeQCKtreUcpNJbNrQEh1+GoyJEMRizn1w6nylN/ze3WwbZhBjNL11eSuFgE4UiGtYObFJbWoE4rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4PZG68d5seess1YdSlW+00GrCK8sgIMr43dt9jZtZBc=;
 b=CIsEweq9aeuyCwLsl8HNsS94w64B1H3GPUEriVTTlX+OY3njAZ6wbiCnSGKbbbDSD2WKBd1a415mhEGyocOdyIDe0VcRmEKcsFpA3i4LziuzxMonK6nE4//XdrgxunHunXiEWQvotLswuot6LlpYiU4C7yinohFpkq/hWRZxsrlv4MSBpw/ITgimeghZJsFqPvj776YFxSaO+o/j4rQDF2HGMeDHpML5mftUVIl9BHxferhv2gLZIg8UT+kiQv02yH0i1tjnPTeFMlG8PmgfpqlPkFTAQlzua7o/tbgZE2XmkxYtCXOSr/pjZ6TC7Vj52sbjDSd/tZ5L28Urbv7zzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AS4PR06MB8447.eurprd06.prod.outlook.com (2603:10a6:20b:4e2::11)
 by AM7PR06MB6408.eurprd06.prod.outlook.com (2603:10a6:20b:120::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 06:38:08 +0000
Received: from AS4PR06MB8447.eurprd06.prod.outlook.com
 ([fe80::fb61:408a:ba4e:990f]) by AS4PR06MB8447.eurprd06.prod.outlook.com
 ([fe80::fb61:408a:ba4e:990f%6]) with mapi id 15.20.9654.014; Mon, 2 Mar 2026
 06:38:08 +0000
From: niko.mauno@vaisala.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	Niko Mauno <niko.mauno@vaisala.com>
Subject: [PATCH] misc: imx_ele: Fix compile without CMD_FUSE
Date: Mon,  2 Mar 2026 08:37:33 +0200
Message-ID: <20260302063733.927-1-niko.mauno@vaisala.com>
X-Mailer: git-send-email 2.47.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00023A0F.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::209) To AS4PR06MB8447.eurprd06.prod.outlook.com
 (2603:10a6:20b:4e2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR06MB8447:EE_|AM7PR06MB6408:EE_
X-MS-Office365-Filtering-Correlation-Id: ac0662f0-e6f5-4235-c0cf-08de78264422
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: zKpZeQnLYHg3b8cjpV+7mNqH9L7kWxF1k/xrTLZFnvNsMFTm35Wb32iLuvZeFgsG85WuRE72sXdQCU8pJ4S8ogp52rVx44zQ37MtIvEWJ/CgtKi7LxfIYqNZ5f0in0nvQSLo1qu2jUtwocPKpMHF+KLMD1lWwsnppHdPeLrcDs6hAN6wqMT3W3lb0/BWlia3EV3H5hZTQ8JspeTQb39mbMHXSXQ5tfqXKOYqAP5pL+ziBDPbQqckm8gNRZX0LewqH71yy92l48FWh/eTo5qqjlauPWuFL35Po6C8wTOz30UlM4BgUmr+REQqIocjutJHa9kP3uThRutBddEhy5H0D7dLK+48lxnQu5DHllWbOy+AO9LDPF3Ra+5YNu7+Kuk50oS0+a0wkJQZ+ugK268BffOa02p89ZsBu0AF1GT8ApEpxQLzmUPnOjwe90Tbcpz2L00vfFixDTElv9orOoIvQjZTdlwQeZNqHDL/lg2Oj3247YpBn3qvfo2Rv1PKyaQ+SQ90m9PGWa/6XO51cOceAOWJ1hFur6SThBy9AhjNHdZ1ak8SKB4ekvKyX/m/Ce654HTYcG23pKHSkq0vBBCIXqavrcdcliJ1OzlNEDNWhvv9M8gGlcRKfqvNS0pZt0nbBt3SN4Z4cz6ZpEVsBLUVcRb4UwuaLS434+bIiq8jZK4/hvXin2y5nUc9JyA5g0Vo7ZYibn+ainTtdu2D623yrVWOAr+0UI1fzQTokDKncZyQBxoqcpvg/ZxILt8FgG9A+1zy/PHeSwy7hn5fTgmhEJjT3eHlPGmovYOHpzFnLng=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR06MB8447.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k2Esh9H9VAEP2NBCS1YW++a/WoESW1iJndGkhwwxhL3GYU+ygDTBm5NwA16P?=
 =?us-ascii?Q?SZXDD42EEQJtEfO60YwtmFH/6FVPonj3NHldRMI2wZtAme1wn4eyxdm1EvmY?=
 =?us-ascii?Q?gIGA8Y2RSAL0GQqP2+8MFKCgJyPNOpbuwYz3VhLBOumIdVOK3ft8NXu9Pkcb?=
 =?us-ascii?Q?QCFBgNa39WhLqX0k5vnfwwU2cg9zmz5wqtdGNH0KSSIz/Q2LmpFs0ifX1C0E?=
 =?us-ascii?Q?e3O/RqSY+YNyoCnT/kpCQlP8Ovr9O5Cbdk1oDFck2PIe3bjrbiSufccwHICJ?=
 =?us-ascii?Q?X0UttZrlS3YsJdFh15d3VD/HFGJh9uDpfoQHrRHr+OJwUSshyRhgL1+t+Rgq?=
 =?us-ascii?Q?PcDilBWUXrLlEKzeoF1jZwbDbvq8SBcK4uFpUOJKVPLnTmaVHpRozvhIZl2x?=
 =?us-ascii?Q?mo51Y8lOmxwEkPZrKmV+LpQUQ590SmScbeiFktjtBscJPPDsAYRC+6rZ0vgn?=
 =?us-ascii?Q?H76n+Z3XiOGAkUGJB43giLj1o2PuxD6/aJdvJTJF1RyTYFvCrN7FFk2N9bpk?=
 =?us-ascii?Q?YaAOtMDBcAUNWM1y4rqfj0dRn00J5pbK4oKP3n0C83lzcWf4+cMQnSIJRYWs?=
 =?us-ascii?Q?lfQFO4pnk7VBbV+rV8aHtBcn7TUcVGo2eLSHhpIW1LhgBeeMWZpQWlihI8+F?=
 =?us-ascii?Q?wGGv8xHc5fkJvebqQrFbDSr12Unf0V3t3BynIGpzUwSACyl7H5YZweEmjG6i?=
 =?us-ascii?Q?9/FUObenR3Pm0UsBptI+EJ0rYwnSDx2aO0Ipb28U5iFkoLROZuPXLPYq7p/q?=
 =?us-ascii?Q?/+Nd/BFAP8XEIz6/ret+bVoMIPBdwTnhm1mJ69vwGylZaqFn3d5BM36Gcihf?=
 =?us-ascii?Q?FjSVbuAsTp170G3LM/aYykHkEov1Qex8PrSaZ4ZI6E/T5UZgTTLaKvZWeMVN?=
 =?us-ascii?Q?Mcc6YN1FNqLfE2N6u5Lv4VmLFmfsYrqSRNBrwc9+Y8hJhDzMS9qu6GhrpHLt?=
 =?us-ascii?Q?hmFqFs0jw8Li+6Erd0YoVFPW8fU35DllFvbINLBZh+MWfxSDZ+RTHumz9atM?=
 =?us-ascii?Q?X4YX9xbzQB/QNP3VALZ8dGn9ekn0UeUlS5dWXb1zYMdNJ6Attl2tUnpGjGNi?=
 =?us-ascii?Q?s+NUihkn/xwlAyVa9/t5fDVYazSOGorUaRjReNOfLKQym619Z4R6H1MXbrKB?=
 =?us-ascii?Q?TGuMIqWjwFfSL6LOrBbPYd2KRthiLWACPq7YJViw4gRJ+qwvNtMrv163v80L?=
 =?us-ascii?Q?X9GAuE4XXALG2uhhABFW/30CLJZxOhcQLTkIYa3swkzSf0HSHy6TsZaaO5CL?=
 =?us-ascii?Q?Hnu5Ag5UF7ZZSjg9Rdfj17v5OIncDaSZsh/FPCjp6v3sq3deF4Lg9bMEYdDG?=
 =?us-ascii?Q?ufQMR5PL4doZjcDANTjv25/WKTWZKMnrk3yilbVs6saTvhszraBnDw6+4LbH?=
 =?us-ascii?Q?Solh2E/BHFC+wGndGvT7Y5H8DVpC6qh2p11/Sw/mRtgl29x7O7zgoQPzJarU?=
 =?us-ascii?Q?1Jt+Q9Qi5WgI1cScS2JdrfmmZLj0IbG+f05tkojN2HpMCb0VfK3dd4EtR12Q?=
 =?us-ascii?Q?DE0BTRhq9QzHBnMasqOTS09ETDtFk8fT8Ilt425ivyBYD+NdIgmwnIAb7a54?=
 =?us-ascii?Q?3WSadi19enzk9aMj32qdwfDQW0NLNj7pqFbMtdNWdD20h3+aBdBTfLWGh449?=
 =?us-ascii?Q?qrMjn//pPacYNSBVd8asIzcibjAVWRZ7puUPxs1hMA7Oy6+umrXy23/chwzK?=
 =?us-ascii?Q?yufnJ8F5tgtKdZ8t9ZVaM9kyYVXSQMP8vXlg7xv3gQI1PldgbRj9KE0VswMQ?=
 =?us-ascii?Q?WMnBlee0sQ=3D=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac0662f0-e6f5-4235-c0cf-08de78264422
X-MS-Exchange-CrossTenant-AuthSource: AS4PR06MB8447.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 06:38:08.2253 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ipeEYYVdqi94I/NYyzLrMLC5dkx6ReVW9UnS4RKoH+wNKdBj/SIBcFwp4bfWSXSR/qdS/6EQn7E8H6qgJdJijw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR06MB6408
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

From: Niko Mauno <niko.mauno@vaisala.com>

If CONFIG_CMD_FUSE is not enabled in imx93_11x11_evk_defconfig, then
compilation fails with various undefined references to 'fuse_read',
such as:

  | .../arch/arm/mach-imx/imx9/soc.c:188:(.text.get_cpu_rev+0x38): undefined reference to `fuse_read'

therefore remove the 'fuse' command dependency in order to compile
fuse.c unconditionally to mitigate the issue.

Signed-off-by: Niko Mauno <niko.mauno@vaisala.com>
---
 drivers/misc/imx_ele/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/misc/imx_ele/Makefile b/drivers/misc/imx_ele/Makefile
index f8d8c55f983..a5317454583 100644
--- a/drivers/misc/imx_ele/Makefile
+++ b/drivers/misc/imx_ele/Makefile
@@ -1,4 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0+
 
-obj-y += ele_api.o ele_mu.o
-obj-$(CONFIG_CMD_FUSE) += fuse.o
+obj-y += ele_api.o ele_mu.o fuse.o
-- 
2.47.3

