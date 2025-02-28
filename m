Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F076DC19F32
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 03:10:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13C0C807D7;
	Fri, 28 Feb 2025 04:10:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="JMcO+HhM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DD458083E; Fri, 28 Feb 2025 04:10:40 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::601])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C308801FB
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 04:10:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xf6G7eiOH1C4iVMxYLlW5gPH+YnU2mJ4F7dIQg1F4FXqpsYw3QZgxXEky5dDfR6bQ95NQ5+EKa7+VtArmk/lcbbIi6LY5TKnXytFXUhx7kFnnyah3bg782WjeeoPbBgJ79Nm1HrntshIqVsxyp5qv8TV5mCYI07oFmHpfiWyA2kTjTrOG08trp20amm3T2LVFWnnqnvZ7C2OTTZq48QqNqDAMCWb4CeAHL8Q5vtxTfj4LQqYmt5+T5VZBxbcdL+Kt0a5ANturL8JsDjawryZk1xik9Vr3QLXDrZYK/xZcutJ5uBynb/9U/Wm1gEL8rYKO/7CnHUh9N5GvwpHcSSpig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eCCsPk3cFOT0rpYfYJ832X/BozAvn4SeOHUpFEGZUmQ=;
 b=TBi5h9+O0WqKYvbUdxyJz5H31ceccjTl9yX3Uhyi7HR27lNt80nrErGsIh3L5h8f3UxIkubMUNuJxN6HuQqeLetUC7u43IhpEKwgZDblemoO0mjw1D3YmKt7ghLbzXprhk7+UVNGOYDkVT5+rozUJC6vaqzMKDIJp5PHrcH+sjVQ3WWhOGS3qbXfr30cX+on2x24IBKVE/kG9sxy6Jajwi4+HJWJX6MAxt3pitYY12xY1WYWp1uhhLU+6aqnkbGBS1SPphQsf+lL4GQ/u7eTHocXyJcDJGtynrxo6RzigTjUsQ3fKxI9yTPsIIGKoEfnPgMTtX7RURW91Xg7VFezVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eCCsPk3cFOT0rpYfYJ832X/BozAvn4SeOHUpFEGZUmQ=;
 b=JMcO+HhMAUNkHCYpuGvCYzUSWiuPdtAIYmb7kpZyV9o33USkK3xrjz2G5CW4vvcjHw12qi/oXGMojVJ/jYXguEKzGMDZAh6oh/v+nxKdbUF2NkG5BWGSHKmaBSCCivfByy3PuP9KCxoc51C46GhrdNtKREfMdlq1uK8XoEkIoxAVyfO/TH93OSKGrDXJ8hMWRKLJhnXzDvf5MRFlfPbCdVmzNG4BO/nBRwOtHqnCx3Av8C+HQXLdEirnsKpRuHtehyVzAa6erwN4g1VyVi28XoehP+GwjZN1TI5f/uzL0Nn1ljyWeg4lU10s1uL5lGS7ven3qS03Ah9V/UBvVSd3Aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB8905.eurprd04.prod.outlook.com (2603:10a6:20b:408::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 03:10:35 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8466.013; Fri, 28 Feb 2025
 03:10:34 +0000
Date: Fri, 28 Feb 2025 12:17:56 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: blemouzy.ml@gmail.com
Cc: u-boot@lists.denx.de, gaurav.jain@nxp.com, trini@konsulko.com,
 Benjamin Lemouzy <blemouzy@centralp.fr>
Subject: Re: [PATCH] crypto: fsl_hash: fix flush dcache alignment in
 caam_hash()
Message-ID: <20250228041756.GB30605@nxa18884-linux>
References: <20250221070501.19472-1-blemouzy@centralp.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221070501.19472-1-blemouzy@centralp.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR01CA0033.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::23) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM9PR04MB8905:EE_
X-MS-Office365-Filtering-Correlation-Id: 94ccc569-08bb-4041-44fa-08dd57a577bb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|7053199007|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yH3h50YL7yemWYYowwTyLcsqBbAUP099WjdT0XDFjQqRkVafdU4La0JGuiF+?=
 =?us-ascii?Q?H2GJfGLCyefsJ/jw3I356c6fkDjCpTbnY1nmYEeZXM4XMYG5xDGQqCkvJE9/?=
 =?us-ascii?Q?yBrYrgjHNS9QW02c/2duD8b/FaaAZno4rhG9JOv8k6t4qaCfs+V6gm2jEjQr?=
 =?us-ascii?Q?mB/64OTDU4ErXnt7YoUd1ufOzl9LofAo2/oQ0IqTbiCst/hTL7tQ4l1Ea2+b?=
 =?us-ascii?Q?ZgoveGWU/JSz+8elqKYrANSW/rC1PvDFSbogWcnAhd3SAfnjWhxhgzPvIZMz?=
 =?us-ascii?Q?X0I1pMucC8uBH0ZOL85iatmHNmU/pICyFcTh+bOVASdNU/yEN6I10pooUPMs?=
 =?us-ascii?Q?srxUdZP5KSYq0LcilQfL1uiWgmSv4RT3M34dImFAgOe8CT5eyCAg6FfurB8l?=
 =?us-ascii?Q?W5pi4zr+MjHQHRHg1SUyLogDTmnS9MWopStoGiwMCsMjl21oq23jOZbPNdtH?=
 =?us-ascii?Q?uXcRlaemoMmdvif/GVkao4sJlWvfcrkBY+8NGxBiWghN76NGsr8ub03gztua?=
 =?us-ascii?Q?5KxsHpGDMORLda5xyGUfdkONGjUmdHi7xOgMPGURUd24wwjU0EhWnUiIauZU?=
 =?us-ascii?Q?R9a4uDo2H5NHXwWI/SN9k0xeo3wsug9ggB/LUYUPvu4hNHy5S2n4/G3TlXta?=
 =?us-ascii?Q?Td7IC10N7X/0iL09EtxtC2KEVlZT9iqCbwFL4icFhf9WbXP6Yk6WOY+xI1su?=
 =?us-ascii?Q?Wm1KRYSe/uTPlmG+4FBnbuh7C3yTI/hIqcIkuQO/IUbLh5vE1xKFwmnFBGwD?=
 =?us-ascii?Q?+i1a13PAi89dZcB0TCPq5/dDyforYlAGbo3nbsYYxg85HIMoAZXco3T93dz4?=
 =?us-ascii?Q?KfLcxARfbXjdYFv5dBfuVJfHCS/8E5adv0JaxkGWvazzOLHjotmYYfO7DRc7?=
 =?us-ascii?Q?TsSIn5tOEH90OpCunhg3AzKDjgDzLowrYrMAoyTo+pNMcoOhtdXwSFmY50Mt?=
 =?us-ascii?Q?llpjFuoms1pklRTiR3GMMh5DT0KWJLlAvNGLlcsiIVCRDoPJdVKK/Dp2OQ59?=
 =?us-ascii?Q?J1SeCVT9QpsdzVaatO4zXOISuIDTYT5O/e/0kaqlw3ozKkZ5hDsibTlQfDvA?=
 =?us-ascii?Q?CGaZshF1rlWc3hG848yhg7cbk8OmQRWk/ZhunMHsGy90Co+THF+jBtqoTmTE?=
 =?us-ascii?Q?Vt8nV/gnjrRFji5rhmhJ6DJwOBr1xdjN5XyiorQ1qlqgRF6JqatgH2T4Zey1?=
 =?us-ascii?Q?vUe7rYFY6gFXtH4M9GlMOGVJOZM2M8tSe4RPGKZo34PI1sI4Sik0DIOkO6vd?=
 =?us-ascii?Q?ZDNTiXtjNwzdqMPkiczepKjKoRqBniZIYes/Y+L+t9Pj8lpjoav+C+RIaCaU?=
 =?us-ascii?Q?Hif8sEhxF6BaEyKHwgpciAMe8MtVxNyY/qzWQHWrtKTLJPsKyZ8IvVOzqYVE?=
 =?us-ascii?Q?GnGizMDY0rx2teiPwTzhOCUW8FijjCYphbSCZwShFNtV4oOBoA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A6NSAouulclp8LwSDRLyUkm4UsfSAp+gJo1UG3jH4n4+v/Ga/rE6P//LteVG?=
 =?us-ascii?Q?C4p+KQjDV6AxKEdD3cPOK5xQge/XJb1xZCYobt+TTU+X8gFnA8Y4j4ydBJNZ?=
 =?us-ascii?Q?LvIv2yyj5tuDejtosXQDYXHKUzvnFeXuZ+cVqXQfHoHR65t2hQNhiH5n+ZZr?=
 =?us-ascii?Q?AeZFREwJdF+6s76lUt8PapIEuZuypwmlmCkXXD7bu7Wxmn/JuvICzZA6Hjs3?=
 =?us-ascii?Q?x4Jl+/9khp3IRgMGypH+pwZ4N8aIn3ffioW5wuAidI8wjv54loIXOUYxjDRH?=
 =?us-ascii?Q?nmUU69ek18sxOs3jqjGH7kATExy+hJYmZiH3iwKZjbNLVm3VE+X9edqVtYQi?=
 =?us-ascii?Q?bvcCZu4W7Gw2bfIoWd+YUW+iTeB+gLcmFnhkORby1/R0DYtAR8TzS7nVw1E3?=
 =?us-ascii?Q?MwR99Kla5XxzAXq4tdV8LASbTmFvYnDa1k6MjvCKzhJRTDRY7TBs5gCpNkmF?=
 =?us-ascii?Q?WIyCC7qGSdtfHjW0lS4nq87daYBONt4lWe5a8KN8d/px+f4V1SgVqpsfLX4v?=
 =?us-ascii?Q?iSFbxl1agcRB21JopQ73hd2twl9h+Yq4xb5G9CwhrHidW+VWbhKejmb/xsdF?=
 =?us-ascii?Q?aejISSM02ujjkjtFADJ7AflsRXAW6MUsEAuMpbJ92dy+a6zOJv9XYps9jYf5?=
 =?us-ascii?Q?Mn1sMS76aXVV++b5Jz5pb0FfnBw2dSuIWWYtQRQLCur1BUUugIFciRO+Axro?=
 =?us-ascii?Q?0dfLRR/W89lTjs5LXCCDY7fmtQlgtVF5rOZ08NqviJ4O9r6adfK4Qx2QbR/z?=
 =?us-ascii?Q?uh8xW97d46vKjgAhZKsLMAf3vSXEaa+FE7nRM6pZwSLIaB5JK/NGf+DsvQ8e?=
 =?us-ascii?Q?EL/+8cGHAjx0u184qXFQ4b4JH2wnMOgkQNlIr48cCY1i8on9W9LFKjADeEkK?=
 =?us-ascii?Q?HDLt/hD7XLuxTs2Qpmn/5GyIh6GMb+m6cndPO75JKsXdL2lTUDesFyxBIzHi?=
 =?us-ascii?Q?JdruJwuA8djmZfozlZEm6Y9oF/g49Iv4Rfqu8Tk3Vp35x4dBEud1WDkbYwDv?=
 =?us-ascii?Q?967s/cc3fIjqAb6gO3Gawnc4P+Rc6QMJ3oTmH2sWADwgmG2C08IRG++KG7qi?=
 =?us-ascii?Q?odoHWNJ6FfDRFLDC7ssdvp9B3OZo7V8HN7i+S+6xiCCnUyt0x6odpOjgnZfV?=
 =?us-ascii?Q?Hf+j84ZZSYQijuV1LgzVz3YFOfTKl3AjE2vBB4QQhL8viSzb+VPQWyiKduIF?=
 =?us-ascii?Q?JnMJS0dyXYDgOvkaPvldMykGYigY1qEx2ao2gV/GgoIBA771AWOHHQ9zC18h?=
 =?us-ascii?Q?KRR1BYFHZ3HeU5jKHGCZYDQCrNmVSt4HtK79gDMZ3GgGD7+r5ipU5DQFTaWv?=
 =?us-ascii?Q?7lH33LK+Cg4DbzKwtgHBQBHQo+6PJkpmM11Auu2UonfIAUcomtuYqh7dh59H?=
 =?us-ascii?Q?wdS2emPa14Y+tg/LEiTBNy36KXmi+WfbAGlebnI+BYgoijKiHwtIZ8ZQRWJq?=
 =?us-ascii?Q?Ye8yc25/rO22sFU9FBsi6Dh6aZ78i/zkLz9WT3PgvsxzKW4IHIhFeK/bitdY?=
 =?us-ascii?Q?SphcFZE7IXQ096JKTUZl9nrxUB9mXzgbb7CG0e4JUAX9ayRP82SVDwBd8uzb?=
 =?us-ascii?Q?AlKe/GJ/biuYzCfW1lEvuO3yK7YK08QNuc869ll2?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94ccc569-08bb-4041-44fa-08dd57a577bb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 03:10:34.7798 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Ji/oKIvI5AwHlpyQtEIKrrNHa6+2ONyFf831DM5XQloKL1gjmbLs81yRC3XlWmoMcKo2pLM/NX3gJwz/wul5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8905
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

Hi Benjamin,

On Fri, Feb 21, 2025 at 08:05:01AM +0100, blemouzy.ml@gmail.com wrote:
>From: Benjamin Lemouzy <blemouzy@centralp.fr>
>
>Loading a FIT kernel image with hash hardware acceleration enabled
>(CONFIG_SHA_HW_ACCEL=y) displays the following CACHE warning:

Sorry for my lazyness, the following patch should be able to solve your issue.
I will prepare a PR soon.
https://patchwork.ozlabs.org/project/uboot/patch/1bd862e53b50825f6030bf9f212127c776fff881.camel@googlemail.com/

Thanks,
Peng
>
>    [...]
>    Trying 'kernel-1' kernel subimage
>    [...]
>    Verifying Hash Integrity ... sha256CACHE: Misaligned operation at
>range [16000128, 1673fae8]
>    [...]
>    Trying 'ramdisk-1' ramdisk subimage
>    [...]
>    Verifying Hash Integrity ... sha256CACHE: Misaligned operation at
>range [1676d6d4, 1737a5d4]
>    [...]
>    Trying 'fdt-imx6q-xxx.dtb' fdt subimage
>    [...]
>    Verifying Hash Integrity ... sha256CACHE: Misaligned operation at
>range [1673fbdc, 1674b0dc]
>    [...]
>
>This patch fixes it.
>
>Tested on:
>- i.MX 6 custom board
>- LS1021A custom board
>
>Signed-off-by: Benjamin Lemouzy <blemouzy@centralp.fr>
>---
> drivers/crypto/fsl/fsl_hash.c | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/crypto/fsl/fsl_hash.c b/drivers/crypto/fsl/fsl_hash.c
>index 79b32e2627..b721c86609 100644
>--- a/drivers/crypto/fsl/fsl_hash.c
>+++ b/drivers/crypto/fsl/fsl_hash.c
>@@ -183,6 +183,7 @@ int caam_hash(const unsigned char *pbuf, unsigned int buf_len,
> {
> 	int ret = 0;
> 	uint32_t *desc;
>+	unsigned long pbuf_aligned;
> 	unsigned int size;
> 
> 	desc = malloc_cache_aligned(sizeof(int) * MAX_CAAM_DESCSIZE);
>@@ -191,8 +192,9 @@ int caam_hash(const unsigned char *pbuf, unsigned int buf_len,
> 		return -ENOMEM;
> 	}
> 
>-	size = ALIGN(buf_len, ARCH_DMA_MINALIGN);
>-	flush_dcache_range((unsigned long)pbuf, (unsigned long)pbuf + size);
>+	pbuf_aligned = ALIGN_DOWN((unsigned long)pbuf, ARCH_DMA_MINALIGN);
>+	size = ALIGN(buf_len + ((unsigned long)pbuf - pbuf_aligned), ARCH_DMA_MINALIGN);
>+	flush_dcache_range(pbuf_aligned, pbuf_aligned + size);
> 
> 	inline_cnstr_jobdesc_hash(desc, pbuf, buf_len, pout,
> 				  driver_hash[algo].alg_type,
>-- 
>2.43.0
>
