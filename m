Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BB92D41C37
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 13:56:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 287D283C94;
	Thu, 11 Dec 2025 14:55:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="V7XK/ECG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73D80839DE; Thu, 11 Dec 2025 12:41:19 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C9278334F
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 12:41:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N8495VJ/Z+IKG1ZciqIndeHpb9ocKEuuT3rchtX6NFK0xU4q30vQXJF64lUBH8CGIeXFZbjLaBu3SXaTOotvLX9t/gS9SX+TYcD+1BAuOP9YGoBxrOpURFwL3XMYpT2TkobOHIfBfMYgJBhKMptCFTSzZ3OcASQIuizrE08eUXR0x/lvmKS7i1RSidG0gmtt8ZPFi8oK4UPEZ0BEToXiYGh6Rp7o3ulC8midfHoIeK6MG+CIUnvDx2OM64nB48VAaa4sCfVL9/aJM7kRKUcpWxKWaNPV++vgKUCDrTaAYIQQM98JZ8HMWYe9spKDcMgC2LbzrS29gFQaa4h4+0E69w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3gMNM/RCjkcKJY8ZBxH8hJLMc5L1h8cxdjsvmmXr5I=;
 b=yb4DLsefkUBGEEjRfntjZdy1KDzMPtdBrssxK51sNl9cMlJwEIm1iVQjpC//t0QF2ji7mHyZl+CADyugasjrVztsaNcgf3igQpDnf/wc187CGA2+Fpzh8Wgc7xegr8izj6Y6UmOQDJRt9uhPbTcP744Bz9n3uaoRVMv6sLmtFA3UMWvDvcwoeYgM9qNHEqul3HCfXu45IONBmDMQXhyhe+nOSWibmFnif49z+839Obg5HuvPUrkvrtzuxfqcgKq++N/utKElpdi8ztz2JnT1+SVfZ89MuCYGuB5bLyE96zUgIbKvTkj0aJxy3NXV0+suuSio9Tc5t/kB1BlVPM97LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3gMNM/RCjkcKJY8ZBxH8hJLMc5L1h8cxdjsvmmXr5I=;
 b=V7XK/ECGB+hAgRCQIh5R9vfN5a4U3A93A3ozcQNGqWv+o1Hwq1u4P2YRoGaDorh+M8yAmx8WAPnMrRtjuGn+JPhwwkPuXvpKxQzZ1qx4t5Qsfkx62FBpo/4IuBNzBRKwuE0i1VanaiH/J3UolHv39Sk67mcMHBrL/VEhT6MrlX7e24YenWkJ6GH49WgFcN8peBTRTMEl8Bov4NglZUPbqtIG3a2nvi54RpoCPySKroX67a/GJ6ZOrUyZlSpDkW+ws5lB/V3QEbA3HBFZIitnfuWHHbcYcDu8z4m9JhjYZmZL3Yii48n41bcpGVcW/MYMY1xqrUIGAlmGFRJX/cuNHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM8PR04MB7956.eurprd04.prod.outlook.com (2603:10a6:20b:241::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Thu, 11 Dec
 2025 11:41:16 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9388.003; Thu, 11 Dec 2025
 11:41:09 +0000
Date: Thu, 11 Dec 2025 20:54:38 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: "Anthony Pighin (Nokia)" <anthony.pighin@nokia.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "peng.fan@nxp.com" <peng.fan@nxp.com>
Subject: Re: [PATCH] armv8/fsl-layerscape: fdt: Remove offline cores from
 cooling device maps
Message-ID: <aTq_Doii_fUQ0F4p@nxa18884-linux.ap.freescale.net>
References: <BN0PR08MB695168175B8E121E36076AD483D9A@BN0PR08MB6951.namprd08.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN0PR08MB695168175B8E121E36076AD483D9A@BN0PR08MB6951.namprd08.prod.outlook.com>
X-ClientProxiedBy: SI1PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM8PR04MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f6719dd-d7d9-43ac-83d4-08de38aa2dac
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|52116014|366016|376014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?h1F4DFOstbtl5bnxTTrJcJDYZvFbqHz7HstgbOU4wtihZVnY4yk35FDVSeWB?=
 =?us-ascii?Q?CxdTY8h+QSlp3T2Eio7G8hVniV7WGZXdR/4eVbHsyIcS7TNt6oTMmXrbU+VZ?=
 =?us-ascii?Q?O1o/5NDHhjhYAvmKva9YVXrPmuGPufBGTAaSVy3uIkQQCHLLJQBDUzshNhUr?=
 =?us-ascii?Q?ttLQSHidxOQ6DKwPYW6/waSS4QKLsoJE8u/HytxbqqUTjfAiVGI9+RJMKCuS?=
 =?us-ascii?Q?GLLDwYhieziXMLtfwRBtdTCCTpyT0bleRuN/DKeXU5F1xcTGf+dMkePu6gGZ?=
 =?us-ascii?Q?tvRRUkRI8R5HF4n4E5Wt2ECvIEktE99JY73CRG7QvxjSMg80aXIumiIcq5oc?=
 =?us-ascii?Q?Vwu6I9wM3qds5XcoDYj6ttKIh7+ksCvjqIL8O1HWK+QIOIdVBHXl2Fx1fxdi?=
 =?us-ascii?Q?3fd6ijKlzhnxKNsRHLZcJSNhE9kdpDBpYLgLkS0LzxPPRYFrfHSX75gfA3JP?=
 =?us-ascii?Q?Ojl6f4OOrgMErfYT8ztzIsuz8ptwwl6ulb0KMe+OXd5z1xwYm1T/3zzSWvN0?=
 =?us-ascii?Q?TqfFRhfZXWpNAkebRQKdyn5KoQtlkr4uGDKXfQAxvkAyahdLYE/Y4qSNA3WL?=
 =?us-ascii?Q?na0qwkyDSM1xFG0Gv7uRtjsXqVA59VyxFNXFw0q8oMAaLP+iBgMmAF8KMqmA?=
 =?us-ascii?Q?hnwgl9sp7ZzKlP15DC9r3+MPb4f9atIElBe3wyhw6lmFFXrp+E3n/kNO3D2d?=
 =?us-ascii?Q?b5l61OlEAp0UcLlEgsTzggrCEfJvZri3UIOjU49m6H/z4qDQHLRsK9N5M+lt?=
 =?us-ascii?Q?Ez5+tim6Kgz6gzahPukDw6nTPGUAoK7nlvqhEPRz11QsrH54lOoBKZw8UDVv?=
 =?us-ascii?Q?eLmWpKTMOLvTYuwJVHRYZPcUVa82CJtm6UaVnBZMEKle6S6/Qaj3d4/hO2U6?=
 =?us-ascii?Q?pn0YTRQfFg85rLF6+aNAJuJQyKp3hA84haPdN0mfjJrBYaXNiTFDzEi/LYBT?=
 =?us-ascii?Q?v4XGiF8pOZ4hF3KZJn42dFI1hoKWqrS0pz1JmDOA6bgmvCELJWB41wn/BY5Y?=
 =?us-ascii?Q?GQlBnzUx/dVfQTxuvFEPlpEo03tdaQwxh9CugGwYRRo5V/26k31Nks/mQfa5?=
 =?us-ascii?Q?xUHYmTlUV4dnVNiSZANQ6vnjCH5p8djwvOvD305JaJ96A6WyTSf+wb9jh5k8?=
 =?us-ascii?Q?bzI8kb4h5T2lbnw9Wr0V1UFNO2DbFtRQaeudcXF2DZj8wwDMEN6EeYtBXG3f?=
 =?us-ascii?Q?ZkwHR3OnRMSMqAI/Sv9ni74wP+MgwhSGfTKUCagcLEOCKTr+khZ99lZOut3r?=
 =?us-ascii?Q?hDGcqbgmZ0pmFV6HM38PEvfM7K3xI5gfLG8AsxMHAru4flStPU3CjnR+Wvk3?=
 =?us-ascii?Q?lei4iMaEDiHUqqrEvWxkD5Mtgl77Tf6kcQiR5jGtP/4/e9Tuqy2+YvVfBjL3?=
 =?us-ascii?Q?nf2e9POYgP78dhVM4PWJQGBemMgkROnJh/vd7QqZvtL1Rb1C/mBmDyV4NaEh?=
 =?us-ascii?Q?LPB+PDNQtHN5PRTdk4UVFhU1SfDVmiCr/tAsj52ZNoy9m0OMWuFsfnjhY3kE?=
 =?us-ascii?Q?7FFXpXps3HIUY3XXVRMqWPi4CWA16WlQXNqk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(52116014)(366016)(376014)(1800799024)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?prhZmzIEOce9qFACA68w0ZJ0asUEuprlc6iVJYyULtOC+4zDW7NhxZmTNpeH?=
 =?us-ascii?Q?XMGTPgZ8xM9/VrTtvIczPas6mqVZ+jVpSUcApO+wQQA9ezP/QH4q4jYaBGlj?=
 =?us-ascii?Q?r8bQ4toYtDcP5+QIYsX6arGU4LBxi+R8OkWPTN1c4is0M5DNJztw3EDTLXCz?=
 =?us-ascii?Q?gDw+5qflSIiFybEPoyMfB0KSk35shztu1jPvJjLQ1qFVL7eraAsqfUuK5OV4?=
 =?us-ascii?Q?TSJCj759moNbnLaBR802ioCD+e2JiQIy46FKchQ3aFRJNkXx1THhNWvd404e?=
 =?us-ascii?Q?JJPXTLLcaf7NLMbnSUWW4Z1gaMAF4J/bfOSqfWpvGLf6vxrCITVRc5eR95Bs?=
 =?us-ascii?Q?12VZuXwf5qia9/jIdQMdPKgwnMHHyceGrr122XU39v0OzvvB0nR8IUPZV7QO?=
 =?us-ascii?Q?TdMhQvLi6kKrc4wmFbRHn5lhJ64BIoiwf6kpB8jPJJDthmISI+qssfnjO/OB?=
 =?us-ascii?Q?laDADAFLXW6y9f2YzpoG6FE4XLklFU7iRfHf5p/GxDrxn/HXEIht2P2C31bE?=
 =?us-ascii?Q?l5MrdG+0XfL1m8rDOyqQd8nVDRVLe34Bs6/O4N+QHLgZwv2EOtN+ZGCXdO4K?=
 =?us-ascii?Q?hDeXnKYgmIjX+Xadzz2U7Ph2RrTcqapdrdYO+1lbLyn9qhei0GVWqbuFnAFl?=
 =?us-ascii?Q?UDZO1qGCijCwKzngPdysJJ8NhLB4HDz+mMe+tQXPMsI1lHAldvA+VFUffaJM?=
 =?us-ascii?Q?D47p1CZl1ohyrlyJ0lu7agl6p/26bl1+HcZWDWyMyYz4NL2yCZVvu+J9AZcu?=
 =?us-ascii?Q?gYo95ccXOfYr2BAz5c6YcXTevL+5rcsKfhOH9svg7ukDJwEOs1O9ATLhY95h?=
 =?us-ascii?Q?CtPFx5edRiNcqiC4F2RfV8yjOYJaA4+FMl2ZbHSANWXQ1Tq+8OIjExJpE6KC?=
 =?us-ascii?Q?BMttLh2fCq4y96ERiQJheOrXym3leupjGUCyh/Mm/r8iI4cm4+gJLJTjrTUI?=
 =?us-ascii?Q?OpAEAjs06p/nlN3xlj9nr/kLpn1S9mdQGa+8LwKdfb34i5fHhyjVa/U/S0QB?=
 =?us-ascii?Q?/rfifS8zIDhqzUOtUaFgT2ITsIHv4Osc1uMXOClaRG9OgAo72lZYft6/AmNF?=
 =?us-ascii?Q?oPHn7sTNpD6npJT34LM3FUNcxOLtfH71CnwBSi1/wOddQkLutdPD5wLfuh+3?=
 =?us-ascii?Q?fDlIqXN/y2iQPlLSER0rOxcdpf6F0LvnJcztIq+cnYx6XufSUmg+JyoxTqIq?=
 =?us-ascii?Q?ElkJVUpRmkLlx8tMqrh/G3h8QgYop6iYkrlzEwCPpn+gPiiqh08CYW2rKEVN?=
 =?us-ascii?Q?GI0MPZ/TWEZwiX5pFBCV55/P1sLKqKIbxAJiG4FGi95DjxC/R9nXqrBOdltu?=
 =?us-ascii?Q?cQgELribbIEs/h73GX3dy5KYZyCYkJKgkip9p7qpZZ00HIbfcDlazHP/0F1b?=
 =?us-ascii?Q?Hkq6fhSSaHLuJEEj1OXpgJlTqyyd4YcXgF1+XHfAIiMmnIz2lpqO7E1ldnXF?=
 =?us-ascii?Q?ubbb988oqHnoJSgOUJFMYUaBgbNZWP67IWo/62n0QXTkOCpu99NgoU0d8B0W?=
 =?us-ascii?Q?H6t2JdfkDZ0xAA1ZK78TimFleRvnXbAwJNBUD+QTZpwjp76ZFh1bBbLg7KiO?=
 =?us-ascii?Q?D71SXRF/uptsdJ8eC30+YR8rK1E6jJrlInlIoo7H?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f6719dd-d7d9-43ac-83d4-08de38aa2dac
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 11:41:09.6666 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jV/BVbVccDgpqT+yQ2rlxBRlkK+24dwVxvpukDiY/vFFpke1gxIpHPQ66dHw0mvROkttTMWYraAAO0O28Cp3dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7956
X-Mailman-Approved-At: Thu, 11 Dec 2025 14:55:31 +0100
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

On Wed, Dec 03, 2025 at 04:25:39PM +0000, Anthony Pighin (Nokia) wrote:
>Some processor families use a generic device tree, and rely on u-boot
>fixups to massage that for lower core count personalities (i.e. NXP
>LX2* family). For example, the LX2160A device tree will be used and
>then modified to offline non-existent cores when running on an 8-core
>LX2080A.
>
>However, the cooling maps still contain references to the non-existent
>core phandles, resulting in:
>
>    OF: /thermal-zones/cluster6-7-thermal/cooling-maps/map0:
>        could not find phandle 15
>
>Rebuild the cooling maps as non-existent cores are deleted.
>
>Signed-off-by: Anthony Pighin <anthony.pighin@nokia.com>

Applied.

Thanks,
Peng
