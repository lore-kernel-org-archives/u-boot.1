Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 066ACE87822
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 12:22:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 631A283FFA;
	Tue,  3 Feb 2026 13:22:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="c399M05R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A74C8409A; Tue,  3 Feb 2026 13:22:52 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 672D383F53
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 13:22:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U8qED/RhIE7MR8XBl/Y0vU8G8Clkt6Ok4Z3FXxDc2qA0xwU3yVSIajAkTtg8bIgBcSyEYp0h3kNezYxjbEERK5O5f+04qIIXsAr4z76TkT3maSRCxop/u4YYAoAXAtO7XJuHezTyZlcdm801oQ9qEU+flPypvdM85S3BvW1DhmvlhiEGrHRdmwiKeRponRZuhM5pBTt/8rV46cNkwrBNuBsfLxuKty5dgldCvt6NBwpiWCFjXy7XUevSmNpF4WVQSRXC3+XV07CnQW5bwBKsvJtyQkNodQATrWF9OZiHTm1BgZZBD252pjRtaSKRw6sP6g9OxGErzF4FxuV7FW6WoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ppm6cXrhwIBgQUeVqRhldUneOWj9uOPYaSdq3QJyrfY=;
 b=upMPha44r5zSn5jRL2J+i4bXfMi7K3DwbtVGea7EoLJPVonUhxr4sEWqTtQ7xsV7UKfvt8gbR4jszvOBWv/fWmMFt/xLAg9DbP1brZY8NQj7M1hJVT+kRPTFzscJ5P9v+IPnINGEYR99MC6+K26RgdFg8yXLIR9WlXoGpNcnx9lFOZCo6dB1GMGgjsKOxhL5PaUAlBRLS7XZD4ctV3K0pR9pDpyTnAi4omzy1vdKTcgpdHsVqNJXBpLEt/+zSDBsPCZvkoUAu6YhHKeaabp8Uz7SPhrC9Z46r7vDwMqlZymzEUCpWS1rzhXztpxitw3NsIPZy4bVNW3b004jB0eVKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ppm6cXrhwIBgQUeVqRhldUneOWj9uOPYaSdq3QJyrfY=;
 b=c399M05Ro+RlJl7/6vEAbVnfvlACOG138TA4h8VK8/fnLFM4i2gCSyuwgJEtqV7La1t61kUU9NMg9G2TJEWMkidodpQbOWq2ofG5QXwamXgjSl/IqUlpNzz5vZRFmj/87PwlK0kPoZPL0NKdHe/PUjCOOdcrbqZB5ij+YNdDJkXR6jeF8upjelqPHs/b/rAq/rixa1leVE/6QCMFkz//aWhKGYzM+ncAuMCjLqBURUtsqqJWoIDpYlTcLnaFpBnmn/4NxfzPuy6Hs6iy7UsymzZIg6CAdu7upelZRDsX38D8qkLtHO5y+kxWIxcibtlb1ZgvMj8ZCSB/R/2/QG9RKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by OSKPR04MB11389.eurprd04.prod.outlook.com (2603:10a6:e10:95::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 12:22:47 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9564.006; Tue, 3 Feb 2026
 12:22:47 +0000
Date: Tue, 3 Feb 2026 21:37:35 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Gregory Baudet <gregory.b.dev@gmail.com>
Cc: u-boot@lists.denx.de, Peng Fang <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: add support for JESD84-B51B with CSD_REV 9
Message-ID: <aYH6H75gduflgjlR@nxa18884-linux.ap.freescale.net>
References: <20260130093539.10167-1-Gregory.B.dev@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130093539.10167-1-Gregory.B.dev@gmail.com>
X-ClientProxiedBy: SG2PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:4:54::23) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|OSKPR04MB11389:EE_
X-MS-Office365-Filtering-Correlation-Id: f73b05c5-cd13-4484-786c-08de631ef08e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|52116014|376014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YmJVjjMR1ysdBa7Iyo5OdSZQMTwmesfkKXYQhE0cexBGB3mVD0DHUZWpDOuu?=
 =?us-ascii?Q?1gF7e+Vj8r6zMWDtTOPdq4Q/hN9IDcTE+Lc622l7gVfSsqhvocn6D+25ryHO?=
 =?us-ascii?Q?OYQKtVo7LN8Ip8oiADxmNZecgMAopz05v3Z4dORZlDM3Y0am2fbOs8fy9hJg?=
 =?us-ascii?Q?YSKGLUZYc68hEwxqmgIy5nePM4HlyuLUxFbHzApqxourAB2QYOHtHdVCpT37?=
 =?us-ascii?Q?uHHpBHCtVAfEqoRmVVZk5Dl0IgEGYdR3TYqHzk4wLCQ5whNmn9UOXheEaaRZ?=
 =?us-ascii?Q?Qhx6gN/V6BdATod185xE0VenteQorH0iIdVF6yacXlGFB3Ls9LCw3ne05XOK?=
 =?us-ascii?Q?8Lt+bpNsWALPtRYwlqDnoUdxI35QqfauAmKHBxrQ7kYlnLJJpST+T1wYFIKF?=
 =?us-ascii?Q?pnfNsaiUNsO4m9HbfFAPG1pQkvFpF2brlm7sp6tA3m11/cxhS2XO+J5h2RUV?=
 =?us-ascii?Q?pQOgqeFHY/NzRc5ntK+X+I4I2LJPJuTFd7mfigM30L97fM9pFZojxkYkDrOy?=
 =?us-ascii?Q?GBUPoZoHqIGSMzGWu4W5PkKPsOP/eG/wzwVGKtiew7BqTUl3lzJixMca32te?=
 =?us-ascii?Q?18nILdh4YjCQZaEnPLKGESF+uUbaNNsVGHh12LKP12ooHhohS+cx6EoUwlWk?=
 =?us-ascii?Q?OzHpPby6p6H5kRmRSrLYXnrXhKHFwHO5CAQ+KqgkvnvloEU9F7XaSMoVvKdf?=
 =?us-ascii?Q?F3xy0IPAjuwPWshtYQXBKwR7PE53aNnXikZlMPO3dQFek6djhEeQX9zBgcbH?=
 =?us-ascii?Q?rkuhb3VHAm/HjJ6V89bXdFFciMRTmOWc7w80vjYkL1BND3xwyPcMvFm+GudG?=
 =?us-ascii?Q?cN8Ynen6drmJCu2uzn2tOwIKjOrUwtQJdEwhAIvsFiSZOHPThhLfmJ5RMvNu?=
 =?us-ascii?Q?1LdNlQASjc5rG6U7X90MvfUJ0pLLyBpS6KPen+NIXOdNwffhkMs5Dbxidz65?=
 =?us-ascii?Q?Uk7BDL+hPYgumEKHBqcGFZzIcmLtqZzkV6yDpI3RBL02WFqX3iPxfq3/Mmbi?=
 =?us-ascii?Q?xuHjpNvhIgvlBtcp1O8Ayj0xoqZq/QCQWiTx1arh/W2/ISdD7I4+viWj4nOI?=
 =?us-ascii?Q?wFml+acbTlmnNLpNmaynDVWFKN6SLZAUeTaY/Kfku2HD3n3Buj79K44Hxjok?=
 =?us-ascii?Q?1oe2VF0uxCJgilJDBYmrWrBg2pSnFY6ISoiXpgBpTXe25zi64qCCfVqpqybw?=
 =?us-ascii?Q?9k22fqNZX5Gv3p3FyVb2Xp15zhmNVC+inTKAqMRmBSAf1JtluKVuC5EsY1Xo?=
 =?us-ascii?Q?DhvGZ/X/1oorMV1mqyqWt1kp/XfAKOb/Xz1AoDQKZLNaBaO6Q9PGR87pgeOn?=
 =?us-ascii?Q?Fh6An8cNBi33YaCzAMrnSxu7B8JBXG6SQ9UDgMzg6RWs0z2LBa9jWI/fB076?=
 =?us-ascii?Q?KunJ0oJWb7sb/mSM98l6q8kfHcZMz+Sm9UfkqXi24FRZT/tQHqYY/XY6KiOe?=
 =?us-ascii?Q?utoL3SYZlg0fx7cRPeJlV3kx+xnnPQVRzYy7eSvAmmrMZMBtxmdDo/UtVA1E?=
 =?us-ascii?Q?HvJb6RcSNJZm0Sw+qZ/DvaRoY06Dyx87nmWeB9NhNK3ZMaThmKrQLdAbWrEt?=
 =?us-ascii?Q?n88lpL2Bz4YBdQKp8EDLSbi/Bqti6bX5bMZgnbx06ZQfEgN8A3YvWIuRpInN?=
 =?us-ascii?Q?reS+YVlzu2awDKCrw7Nalfw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(376014)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YDnqyD5ygSgO2NGbZUdcxYE3xAPN7ido1YK3bhQaKNsiUaAOyE4bg4poKiyC?=
 =?us-ascii?Q?Sz5NbnGBxtj8/niBLQEfilSHbmC/57pZtAuYx4DANCYHyUKevrWazKbr6hk8?=
 =?us-ascii?Q?/X60xc5YGlcIUxqFD34uOlXu4fUoZL08xpVOv3ngOL8S0dXBzjnKcGeSucb/?=
 =?us-ascii?Q?Rx1H+kHUNNFMNeLr46XrQAFYGPOX0XMLCMyspfwKlI4rXe4BAN/SesfcF2jN?=
 =?us-ascii?Q?2ze+o54VaI91UDT3M9iZDvg1wmmHcnDf1EOLGhPpkb3DBMgftDCX2RX4GIp+?=
 =?us-ascii?Q?qGc9XSSuLiWcWtEMXe6BYlQpFbHbk7/kdsfS0eXy5voP6j6G5Mk7ucU1t3T/?=
 =?us-ascii?Q?l8YObnXdA1C8kVAc5c3UiacCGb25JV377oZv8Si9pzhYvB9DgxB6TO2IXESf?=
 =?us-ascii?Q?vDJdAYmqbvs369M8r1o1zvY+9jVWnz+xH6t91CTcCf/TUPchHwSk3C65BGxT?=
 =?us-ascii?Q?CbAVPF3b8h/FOCdee0I5fsNxdlIu83njjJRw2nki76yXtK5zTlLndCAVyjIy?=
 =?us-ascii?Q?yVOYHeGiyKHpQ8SZ0Cq07QaJK/Lg9rtiVeS4TZJdXiZ2xsEOXNvtQj8lAE4t?=
 =?us-ascii?Q?l9okWlvR2+9MkzmROyGanwLPSflLkaycEwH1oZlsbptIeJc+OMbWO2JFU8wr?=
 =?us-ascii?Q?yssKAgiV0Z/qJscR77/KGoi2Plf33yz8gt+sGxMqkKohrELDlJ9QcFQ5NTv4?=
 =?us-ascii?Q?JvXINyfdMVcQ+J+vsrldfS4/TzRn1qU42HIfz90VSX0oNpeDAVfAzahxTlLg?=
 =?us-ascii?Q?eabWRO+ddVK+PkZyD8FZh9+Z/zXlIiPlFBUUZOsw9g9er5rSVusk6HgtShET?=
 =?us-ascii?Q?P6lMu3JooQnUZHSNtykdiBT2Xw/aMyNUXoZgaLPOdMyoO0SMRXcBLx/04Bes?=
 =?us-ascii?Q?PrFMhQo095d5FfwsJRLWlo9GMvHTTcvsQOUST/+X2YRebG/CHAIr8Dhvv5Mr?=
 =?us-ascii?Q?omHXuWoNn0vsW9juOG1mlnYq9OZZgkwgvIWz8WCpNy79IfqsauJn+NnFa6Si?=
 =?us-ascii?Q?GQdky15I9NI2gZMbWmTqMLFg6gXhJkhXzAFP5StfofRooOG3iiYDvWvwnXlP?=
 =?us-ascii?Q?Jpr4ipU1ng9b+0DX1nJzM1rQnbT9ofMzFrI6HbJUQNcp5TJBZWdA/4tqV8oF?=
 =?us-ascii?Q?TJwRfbkDSDvSMcSA5CCaCw51FHiRGj6SHDFzCgMyu2BHM4JTZcUVqmuoB8bx?=
 =?us-ascii?Q?zsRaHqfc6IO+qFvmuvdcmISgkU7ODjcft4HkUYbT1Gl2Sf1RjVgJlQcKSRak?=
 =?us-ascii?Q?zbI8xWspU3xIElul9XiNw8i4QZHVZneOyA5TyHGMsM7qaBUPdhWvOzw56sRa?=
 =?us-ascii?Q?hdXU7zjjKV1lvNbR5xKG++RXO6JRtPMDXUVCkKRC8GtA7/bUIT44hK4l/pGg?=
 =?us-ascii?Q?1GS+3CHVimm4IGHEORHilZdhWCzs6Zz0oveRj9leTMxW4g0K2JXtGCL9OeZf?=
 =?us-ascii?Q?lhYZQa1jhT+We5SzSGvAftN5md/AVb5ielJMQTOEzxQDKOd5HfFbMlktl8qI?=
 =?us-ascii?Q?br9kV6OSYBU2g5NiLZoP4GBbAJ0/uqvpgpD9UjG95/dRGmJKmPFSVUx34ksj?=
 =?us-ascii?Q?7VEUF/KkqFupsipi1E7gL7X+Thx2O4xJna0yQQvbdBY/37VfTYWXXPsElx4a?=
 =?us-ascii?Q?QRXjyN6OnOeYtI7prY2VUQBjDMKntV+BQRcdDdfOo2CN5Fv7cv2Hhxh2o80w?=
 =?us-ascii?Q?5nkTJoKqL78Fl3zajPonkpE2VKgGKU92Uim8Ympu4TsCSYh7mwnPgMDxFErF?=
 =?us-ascii?Q?Uz/c0tXfew=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f73b05c5-cd13-4484-786c-08de631ef08e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 12:22:47.1324 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZiB04CnU4iK92LWDGAk+gdlYfpx0oaYAkm3+hjdwtBPVz37a3is+vVi21sEMp5UBsLcLTzF4K75YtY8r6Y45HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSKPR04MB11389
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

On Fri, Jan 30, 2026 at 10:35:39AM +0100, Gregory Baudet wrote:
>This patch allows correct version detection for newer eMMC devices
>following the 5.1B version of the standard. This new version of the
>standard introduces CSD revision 9, and a new decoding rule of the MDT
>field in CID register.
>
>Signed-off-by: Gregory Baudet <Gregory.B.dev@gmail.com>
>Cc: Peng Fang <peng.fan@nxp.com>
>Cc: Jaehoon Chung <jh80.chung@samsung.com>
>---
> drivers/mmc/mmc.c | 3 ++-
> include/mmc.h     | 1 +
> 2 files changed, 3 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
>index 7dadff27abe..d9e6860bc74 100644
>--- a/drivers/mmc/mmc.c
>+++ b/drivers/mmc/mmc.c
>@@ -2343,7 +2343,8 @@ static int mmc_startup_v4(struct mmc *mmc)
> 		MMC_VERSION_4_41,
> 		MMC_VERSION_4_5,
> 		MMC_VERSION_5_0,
>-		MMC_VERSION_5_1
>+		MMC_VERSION_5_1,
>+		MMC_VERSION_5_1B
> 	};
> 
> #if CONFIG_IS_ENABLED(MMC_TINY)
>diff --git a/include/mmc.h b/include/mmc.h
>index 51d3f2f8dd5..47b0f11877d 100644
>--- a/include/mmc.h
>+++ b/include/mmc.h
>@@ -54,6 +54,7 @@ struct bd_info;
> #define MMC_VERSION_4_5		MAKE_MMC_VERSION(4, 5, 0)
> #define MMC_VERSION_5_0		MAKE_MMC_VERSION(5, 0, 0)
> #define MMC_VERSION_5_1		MAKE_MMC_VERSION(5, 1, 0)
>+#define MMC_VERSION_5_1B	MAKE_MMC_VERSION(5, 1, 1)
> 
> #define MMC_CAP(mode)		(1 << mode)
> #define MMC_MODE_HS		(MMC_CAP(MMC_HS) | MMC_CAP(SD_HS))

The changes looks good to me. But I would see whether this has been
tested on real devices.

Thanks,
Peng

>-- 
>2.51.0
>
>
