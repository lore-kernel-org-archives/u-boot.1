Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A818FEFB6D
	for <u-boot@archiver.kernel.org>; Fri, 27 Feb 2026 16:28:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF7B283D1A;
	Fri, 27 Feb 2026 17:28:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="W5/DRDD/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2103D83E76; Fri, 27 Feb 2026 17:28:27 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD2E983CDF
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 17:28:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JGhDTVrds2zN/YRKuN+9sAYGpKp/z1O/4zopwOw5+pvQlYKhSia+XZf3J9WZLnJpVUktKwdKGvElSiisXrU6hnofO11MOF8vis7I7iJdGtegVEps9Q3XLVZ2K6q6IfhVKIdMfP0wkHAXZ85/NQnKrAXXSPhVNl3Zu/XoawCB9Q4VSjXDMsg8ukbrG/y2QMmg6GG8NO/ubW76KRUbmAG2Um8dTpo4i8Gm2FPqBQksNSQhzpyI43k5ZfhtaBtR9BOycDaAJ/nL8EhDvEuQZbk/xdyYdrdtrGV7iEG1OEHhLGVo1MByJEFA1BFn1ur50W3ri17x8nZvsW66mbyM0GJ3Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aVd4v61CRq9HiFMp2Gj+qCC6jXs17KLvrwv6G5U640I=;
 b=TFf5MfVdvCD5jRLKgvFNdP2zZ1xIKBjp4A108qFXxdpPn5CqRMlE/QApowK7W1z2CLl77jxay5wcgBwPadRGMHNQcLMCC/9dsBtkfs03fdlh23v+BD0RgxmSTtv6XLFqbhcMEzne4vRMdQsp81MPPQUzBYR/o7WOXV8129eAcwEmUp8zGXO/tCRWV3PRkmaF29GX5lRQQ3ebqUWOLmuEw/Y0LU+iDHgfI1yH9ReS1hzXUcw4fznx4pUPxPFPGrs20X+9eS8xDfnIoF0jk6Iud8am82ZhqUVhJmi5WiaqrywUkm+YFvGswXEQ4OL1Lai/X0KXihuuw/+Sn7stNiamcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVd4v61CRq9HiFMp2Gj+qCC6jXs17KLvrwv6G5U640I=;
 b=W5/DRDD/5We9nsHLM/UsjCGqd2ZSxvALUVBf2s+/QwR7BioB46lXfULx2NeySfYcuRsys+OcX8fg/8DeLMB/whmh/r8IJt+kJFoFvc2V/9jP7DFjCTFXvWHIdBb3eFf1gTfc/v53LiRjRBybZq98yv4Bfq55WZmxlgOIMqKlhB0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by PAXPR04MB8457.eurprd04.prod.outlook.com (2603:10a6:102:1d8::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Fri, 27 Feb
 2026 16:28:21 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%5]) with mapi id 15.20.9654.013; Fri, 27 Feb 2026
 16:28:19 +0000
Message-ID: <19fa89be-623b-4179-b301-9658fb0ee42d@cherry.de>
Date: Fri, 27 Feb 2026 17:27:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] treewide: fix uImage.FIT document paths
To: Daniel Golle <daniel@makrotopia.org>, Tom Rini <trini@konsulko.com>,
 Otavio Salvador <otavio@ossystems.com.br>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Dai Okamura <okamura.dai@socionext.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@arm.com>, jerome@forissier.org,
 Philip Molloy <philip.molloy@analog.com>, Simon Glass <sjg@chromium.org>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 Martin Schwan <m.schwan@phytec.de>, Anshul Dalal <anshuld@ti.com>,
 Luca Weiss <luca.weiss@fairphone.com>, David Heidelberg <david@ixit.cz>,
 Shiji Yang <yangshiji66@outlook.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Francois Berder <fberder@outlook.fr>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
References: <0fd6b30e6181e10fcc30a1e23618e97adc9f3441.1772149772.git.daniel@makrotopia.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <0fd6b30e6181e10fcc30a1e23618e97adc9f3441.1772149772.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0059.eurprd03.prod.outlook.com
 (2603:10a6:803:118::48) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|PAXPR04MB8457:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eabc965-dde5-4ccc-cf36-08de761d37f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|921020|7053199007; 
X-Microsoft-Antispam-Message-Info: TAaeSzVdtz6EeI19+x1Gyqzc/GJFHwqBb7Dunkijpq1+xaMLcATdhiVAaJjsI1jwHMnLc4j5fGxXaM7n6w8e22Hpw3gHZ6YMcm+X3BHXH58rqjPjbPBgKP546Sst71wzJmWkIgRcQDVk8JOA0SJr25ppk5SQqz/B1GwX5gtVao2cMtBwLZWXfjnI5E7/mMH7xEGQW2fzP+/TtoCUCI/CUhr3EfUnD+LZNLQ4+IYxYey6m8/3gtB43X8k8BKm/1si1iVBCu4vcjdC6+LLGZhQVpuVLDlHkQrKtnRrHB7sPj8FBnpYgnRC8qDaoFLPsPVun0kmu2J1inBEigGUnV9wMJdYjID+cofV4HBzmY++XtXzNqzV6Hj9sHwPzh1rDIyMkDjwps64AWbYoIQh8+YrdHd0x+4DDTTSL38zp5NLpXPkILZm3+q+uFlYaWzMjuQekO0q2fNE2ghKk8NYCx98YB4OBYvDxuMDimf+pvqEirdv9smIElJ4YPKU/EoUhKa4fiEuySHp2EtxEzyf6CsAQSBdIbtaZHuiC8IlgWK1Cw/MBWpmIfiBx/TI1hZBEzljLdDrFgnGupioyIqszO6EAbOTgbBl/WndmLrTs5UPomGBRI2S9UUvuP10OlWPySX6dszamqZMAOkbGe0R9iHYZct8Jyq/tlCaqAu1VpdyIbhLRti0uyh8yl34V+7Nktsp5ThLrUoF7ApdaHWMFP3/28o1cnrRa4YtcdoGmZMfBgsf7en4buS99JvoWYZnUTPQaN/uHZa7iRxz5iOKmyM9kQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkNKTjNUbHNMUXYvbGwwUU5TOVBSaXc5dVpXU3BnVndGeEFlN2RLQW9ic3Np?=
 =?utf-8?B?aDdSUnUwbHdRejRvemtESnJmdXhaWXExTHJObGdwWEtJWGNYcTJiK0tkSUNK?=
 =?utf-8?B?OW52MUVER2FVeUJNR25ONGtmemxsUzMyaCt3NEVaSjhNRkIvVXQvSENhYWJl?=
 =?utf-8?B?YmFhMXZvNVN6NS82cFF3RVFEQVNha1VVYWdYRE9ZZ1RhVW9xT3krVjNkcjk3?=
 =?utf-8?B?Z1VwZTZIeFU1RHZqRGVEamplcU1vQzRuY0wvcTVONk9LcGdxMVdGdWwrN3J6?=
 =?utf-8?B?NzZIN0pTQnFkL3Yva1VOVE1RcFhRaG0rOTY0QTBmL2x0TkxRalhOOGYwTi9s?=
 =?utf-8?B?elR3N2w5VitmMExyVkdtcWxnY3l0K0tmVnRkREhwandLdDZZcnVHTC9KZGNr?=
 =?utf-8?B?cFVwbkI2aWp2VE91Qll0YWl5ZGFQL1BoM1E3ZHJUWDhNQlpuZHJKTDEydkVK?=
 =?utf-8?B?dUtuV09qUzFyNVdmVWZBWm80T1hNT1o2TEVBRDhxenBrTlJYNzNDRVZ2U255?=
 =?utf-8?B?RnNIeEtWdmNhbW91NHlqREFOSnU5bk84N0UwYU5nM1BoYkdUcGRoQ2Vid3M3?=
 =?utf-8?B?N3l0WVZQd1BZUlpnRENUMU80SEp6Nk0zd0pFeVNLTVhUNXM1RnRWc2ZWMjhn?=
 =?utf-8?B?TGU3cnR2d2NjWlF4NDNwOFdaVnJGQjZuTG5xa3NZYzVOTVFxbXVXVE8wMHhW?=
 =?utf-8?B?aEswS3Z2UlVib3dkUDJLZU4vRHg0ZXBuRmk3eE1QM3ROU2ZUeFZaUWxwbm93?=
 =?utf-8?B?QlNaVytid0c4SEVlaWRLYzFVMUNRNkJWMUxpeUNZeSsrWXFXVXpVN05nblRo?=
 =?utf-8?B?ekhjM0hqRnk0a2p6Z1BnRmlnaU1nYnFwWWJMU1dzeWhVa1pvYkx1Nm5LUUoz?=
 =?utf-8?B?NXNqTFdkMDlEam80QnhMWTd2SDFPVDhGaXZPNWtZUEhidzFQeEhvMlI3UTZx?=
 =?utf-8?B?b3JjMWpoV1JTb0o0dFYvSFVlSC9aMHcyZ2xaZmd2YjhnT1pGVTg1K0ExZVEw?=
 =?utf-8?B?cWxnck1LclJVdW0wRHI0R2dMS0loa2djTjFyYUMrNUVtVmlwZlkvT3VXWXdG?=
 =?utf-8?B?R0xyQjNhYUFYSmlEdG9HZ3J3QVFpWnlaZU1FcER2Q1ZzVnNCeTFoMFBPd2F3?=
 =?utf-8?B?VE9RUGR4aWc0YnlVdVM5UW9oTWkxVG85ZnFWOC84c0tPbFdmdi80RG9OM0hJ?=
 =?utf-8?B?c2poR0NxUHovY0I1emRZYjNPQnBOMG9qMUJkcm00YlJoeXZ3Mm1FdVJnNW5I?=
 =?utf-8?B?eVRvVnJYMTBLc3g3SWxFWVRRZGxIOEpOR0F3Vm84U1pmUUVwdDBMa0Q2OWo3?=
 =?utf-8?B?bnBrcmVvSElkN1hWaXNScmVQUnhxNzEveXh6Q09JbE9BSXQ4bmR2TVFUNmxG?=
 =?utf-8?B?SDQwVGdPSVhXZkpsTjFOWENYMjJVZVpyVUo5eWlma041c0FSalVwbUlwbW1I?=
 =?utf-8?B?T2JkZXRHVjBJK0J3Tm5qMXg2b1NxZ2VDTCtHQ0IxeGJTNGxYdGtvYjRnazYx?=
 =?utf-8?B?MGh5Tmc1b3ExWXpnZWZEZEVlNHMwT1pKMlhrendiRUppUG9NeXZIVXp6MDU2?=
 =?utf-8?B?N1U5eXlPL3pxY1YvKzZBb28xclRvdGVjNWJ5cmc5YlFMdEpyVUR2bTdSOXJp?=
 =?utf-8?B?TFJnRlk0Wmd1VVVVcjB3Q2Q0dkFlN1Vuc01YV1JVNER2bks0V01VU1pmWUJz?=
 =?utf-8?B?V2xhSFB2cldoYlUrZ3pQQy82d2hZblpES2JiWWZRVEcxQm5HQmpxVUVjVDMy?=
 =?utf-8?B?MStOVGx6UUJvY0wrZDFCQjJrR0dncU1ha2ZDOEVwUitBSTNtbHVzSXd0MlF6?=
 =?utf-8?B?R3pSZTlPOVFiRk12cFBRMlpQYk1wTzVHaUxvSllRZzZSVFFHWUNYc0dMb2Np?=
 =?utf-8?B?MU1VR2VaS1FOeVV1ZG5hVTl3dWFJcCtaRVBseGdCZVMzM1pSZDVOREd2QUpP?=
 =?utf-8?B?akVQSzFva29ldWdFV3NmSGZmL2QwWHZ5VjdBTjU0QXVPbkU2K1hpTkl4K3Ax?=
 =?utf-8?B?amhwazBycFRUU2lKdVZlYjFVZVhRTkp1MFFJOFQ4NTZ2ZlZuN1dpV1FqejRJ?=
 =?utf-8?B?aGIrVlQ4ZVowRU04alh2V055TlpZbnRHa3NHTFh4NzBvblZxdU5oZlByQldp?=
 =?utf-8?B?VElUeTlVWnU2YXRjRTdCQ3l3ZG53UysvL3kxMVdNZ0dHaFdzS1lNMU9jd1lR?=
 =?utf-8?B?V1VTNVU0Z3Z4S09FTTZRZWFSRzd3KzFxZlhjcjZPd0hkNHRTY2lqbzNLbm0r?=
 =?utf-8?B?NDA2am1hcUdldU9nS29RWnd1VEwvaWRyWVBIc0RTb3hFdzdKQ0ozVFR2UDIz?=
 =?utf-8?B?VGNJVXEvbDBkSGxvS1RSTnpDTzFWdTFvSzhiT2RHR3QxSEwwNC9OZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eabc965-dde5-4ccc-cf36-08de761d37f1
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 16:28:19.9054 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ks9Jjw0sWEG0hKLCtDhqHo9Tbma31TiC+aLwcJ4gXhQqHTE7wRatTEMVlThrVLGGnkWsEu2taCRjl8bFsSxBrD67lN68OyfSPvJLfCTwLk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8457
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

Hi Daniel,

On 2/27/26 1:03 AM, Daniel Golle wrote:
> Commit 488445cefa1 ("doc: Move FIT into its own directory") moved the
> documentation in doc/uImage.FIT to doc/usage/fit, subsequently all
> documents and example sources have been converted to reStructuredText.
> 
> Fix (almost) all of the remaining occurrences of the old path and
> filenames across the tree.
> 
> The exception is doc/uImage.FIT/command_syntax_extensions.txt which
> apparently has been removed entirely, or at least I was unable to
> locate where that document is now.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>   README                                             | 2 +-
>   board/technexion/pico-imx7d/README.pico-imx7d_BL33 | 2 +-
>   boot/Kconfig                                       | 2 +-
>   doc/README.dfutftp                                 | 2 +-
>   doc/README.odroid                                  | 2 +-
>   doc/README.uniphier                                | 2 +-
>   doc/README.update                                  | 6 +++---
>   doc/board/qualcomm/board.rst                       | 2 +-
>   doc/develop/package/index.rst                      | 2 +-
>   doc/usage/fit/howto.rst                            | 4 ++--
>   lib/ecdsa/Kconfig                                  | 2 +-
>   lib/rsa/Kconfig                                    | 4 ++--
>   tools/image-host.c                                 | 2 +-
>   13 files changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/README b/README
> index 20a73bab802..e2d49e2ebd3 100644
> --- a/README
> +++ b/README
> @@ -1662,7 +1662,7 @@ New uImage format (FIT)
>   Flexible and powerful format based on Flattened Image Tree -- FIT (similar
>   to Flattened Device Tree). It allows the use of images with multiple
>   components (several kernels, ramdisks, etc.), with contents protected by
> -SHA1, MD5 or CRC32. More details are found in the doc/uImage.FIT directory.
> +SHA1, MD5 or CRC32. More details are found in the doc/usage/fit directory.
>   
>   
>   Old uImage format
> diff --git a/board/technexion/pico-imx7d/README.pico-imx7d_BL33 b/board/technexion/pico-imx7d/README.pico-imx7d_BL33
> index 1b346093b88..9bf4b9907d3 100644
> --- a/board/technexion/pico-imx7d/README.pico-imx7d_BL33
> +++ b/board/technexion/pico-imx7d/README.pico-imx7d_BL33
> @@ -41,4 +41,4 @@ fiptool_images. Run below command in ATF folder to generate FIP image.
>   - Test
>       Just boot up your board and wait for u-boot start up after ATF's log.
>       For booting Linux in FIT image, please reference the FIT files in
> -    u-boot doc/uImage.FIT/ folder.
> +    u-boot doc/usage/fit/ folder.
> diff --git a/boot/Kconfig b/boot/Kconfig
> index e5db165424a..ab31b8f40ed 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -335,7 +335,7 @@ config TPL_LOAD_FIT
>   	     property will not be loaded. This limitation also applies to FPGA
>   	     images with the correct "compatible" string.
>   	  2. For FPGA images, the supported "compatible" list is in the
> -	     doc/uImage.FIT/source_file_format.txt.
> +	     doc/usage/fit/source_file_format.rst.
>   	  3. FDTs are only loaded for images with an "os" property of "u-boot".
>   	     "linux" images are also supported with Falcon boot mode.
>   
> diff --git a/doc/README.dfutftp b/doc/README.dfutftp
> index 12065079117..b25f398ee2e 100644
> --- a/doc/README.dfutftp
> +++ b/doc/README.dfutftp
> @@ -94,7 +94,7 @@ FIT image format for download
>   To create FIT image for download one should follow the update tftp README file
>   (./doc/README.update) with one notable difference:
>   
> -The original snippet of ./doc/uImage.FIT/update_uboot.its
> +The original snippet of ./doc/usage/fit/update_uboot.rst
>   
>   	images {
>   		update@1 {
> diff --git a/doc/README.odroid b/doc/README.odroid
> index 1090a0ea141..6eb7e67474d 100644
> --- a/doc/README.odroid
> +++ b/doc/README.odroid
> @@ -152,7 +152,7 @@ Two for both, kernel with device tree support and also without it:
>   If proper fdt file exists then it will be automatically loaded,
>   so for old kernel types, please remove fdt file from boot partition.
>   
> -The third boot option for multi image support (more info: doc/uImage.FIT/)
> +The third boot option for multi image support (more info: doc/usage/fit/)
>   - boot_fit - for binary file: "Image.itb"
>   
>   Default boot command: "autoboot"
> diff --git a/doc/README.uniphier b/doc/README.uniphier
> index 9f72cfa67b5..6f373aa2a6c 100644
> --- a/doc/README.uniphier
> +++ b/doc/README.uniphier
> @@ -112,7 +112,7 @@ Verified Boot
>   
>   U-Boot supports an image verification method called "Verified Boot".
>   This is a brief tutorial to utilize this feature for the UniPhier platform.
> -You will find details documents in the doc/uImage.FIT directory.
> +You will find details documents in the doc/usage/fit directory.
>   
>   Here, we take LD20 reference board for example, but it should work for any
>   other boards including 32 bit SoCs.
> diff --git a/doc/README.update b/doc/README.update
> index bf4379279e2..f16b2d23af1 100644
> --- a/doc/README.update
> +++ b/doc/README.update
> @@ -48,14 +48,14 @@ The auto-update feature uses the following configuration knobs:
>   Since the update file is in FIT format, it is created from an *.its file using
>   the mkimage tool. dtc tool with support for binary includes, e.g. in version
>   1.2.0 or later, must also be available on the system where the update file is
> -to be prepared. Refer to the doc/uImage.FIT/ directory for more details on FIT
> +to be prepared. Refer to the doc/usage/fit/ directory for more details on FIT
>   images.
>   
>   
>   Example .its files
>   ------------------
>   
> -- doc/uImage.FIT/update_uboot.its
> +- doc/usage/fit/update_uboot.rst
>   
>     A simple example that can be used to create an update file for automatically
>     replacing U-Boot image on a system.
> @@ -83,7 +83,7 @@ Example .its files
>     where the update will be placed is correct. Making mistake here and
>     attempting the auto-update can render the system unusable.
>   
> -- doc/uImage.FIT/update3.its
> +- doc/usage/fit/update3.rst
>   
>     An example containing three updates. It can be used to update Linux kernel,
>     ramdisk and FDT blob stored in Flash. The procedure for preparing the update
> diff --git a/doc/board/qualcomm/board.rst b/doc/board/qualcomm/board.rst
> index e5dbc9816b9..eb800f8c535 100644
> --- a/doc/board/qualcomm/board.rst
> +++ b/doc/board/qualcomm/board.rst
> @@ -27,7 +27,7 @@ We will build ``u-boot-nodtb.bin`` from the u-boot source tree.
>   
>   Generate FIT image (optional)
>   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> -See doc/uImage.FIT for more details
> +See doc/usage/fit for more details

Please use :doc: directive here. I think this could be

:doc`/doc/usage/fit/index`

but I'm not sure. But for sure we want the link to the doc and not 
simply a path.

>   
>   Pack android boot image
>   ^^^^^^^^^^^^^^^^^^^^^^^
> diff --git a/doc/develop/package/index.rst b/doc/develop/package/index.rst
> index 4f448313f95..ff4c1882cbd 100644
> --- a/doc/develop/package/index.rst
> +++ b/doc/develop/package/index.rst
> @@ -5,7 +5,7 @@ Package U-Boot
>   
>   U-Boot uses Flat Image Tree (FIT) as a standard file format for packaging
>   images that it reads and boots. Documentation about FIT is available at
> -doc/uImage.FIT
> +doc/usage/fit
>   

Ditto.

>   U-Boot also provides binman for cases not covered by FIT. Examples include
>   initial execution (since FIT itself does not have an executable header) and
> diff --git a/doc/usage/fit/howto.rst b/doc/usage/fit/howto.rst
> index 675c9aa5bb0..9c8d86e50be 100644
> --- a/doc/usage/fit/howto.rst
> +++ b/doc/usage/fit/howto.rst
> @@ -157,7 +157,7 @@ development host is to be booted old-style (non-FDT) by U-Boot on an embedded
>   target. Assume that the outcome of the build is vmlinux.bin.gz, a file which
>   contains a gzip-compressed PPC Linux kernel (the only data file in this case).
>   The uImage can be produced using the image source file
> -doc/uImage.FIT/kernel.its (note that kernel.its assumes that vmlinux.bin.gz is
> +doc/usage/fit/kernel.rst (note that kernel.its assumes that vmlinux.bin.gz is

Ditto.

>   in the current working directory; if desired, an alternative path can be
>   specified in the kernel.its file). Here's how to create the image and inspect
>   its contents:
> @@ -269,7 +269,7 @@ Example 2 -- new-style (FDT) kernel booting
>   Consider another simple scenario, where a PPC Linux kernel is to be booted
>   new-style, i.e., with a FDT blob. In this case there are two prerequisite data
>   files: vmlinux.bin.gz (Linux kernel) and target.dtb (FDT blob). The uImage can
> -be produced using image source file doc/uImage.FIT/kernel_fdt.its like this
> +be produced using image source file doc/usage/fit/kernel_fdt.rst like this

Ditto.

Looks good to me for the rest.

Cheers,
Quentin
