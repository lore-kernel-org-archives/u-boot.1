Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43266D116EA
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 05:32:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA04083B9B;
	Fri, 28 Nov 2025 06:32:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="t4SOoeAE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCDC683B9D; Fri, 28 Nov 2025 06:32:11 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C194983B8C
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 06:32:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ye.li@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=elS0qV15RDfmRR/ztLfJKRme0IuUoov9J3u4tFnM2d/zITXZPnQQn5wHAbv9qIiYH8zmaLxljLXs0SWfstFq2dEsiL9r4tACUitxuzN5TmeJp5CFuY8/Aibj4tei3/Y5pTL0aEI63iG6ch+gVceAz5uLa/xLkD1ua+zSIZC2mhocUXtLi7NL+l3ISa0ZVylfTGkY5aEg3NK4Dw2Z7QgL56NtAoL8yoYyF7WBDxU353Vstsdkfd/ln8dqh4ZWEJ6PZsWe05xjSXjbRf7HdVp9sO6pRjbE4TW8tw7s0o/vxjZDm0M3GhnfmU+upnrgE/LH3p98rN/+NgxGxm3gvzmtbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w4Tv4tyrd5x2Trn+uNMl/ZLIyWO31G2eDRBWxVp3dHQ=;
 b=sKq6Dh8c8q/cn9jKI2Yq+ssgIZgPZ4wcN+I814e4Sz//2OPCBipqTZCGWKdaXLW/47NDfe4+aduQjHMrvqucVptzkWUARQup/GH91viOihqUC/rvvgUgrEhuxTdSBoZFV7xsjsY4zfUrgbtW4ZuEmRX/VW3rlbkHUEurPK/JG7QIpucpvLv2G2Wg0uhngBvVYzyW9Hh3vbaj72IV2OwhzvUCkPT2R20fSjZ/6gDheZS/0pQD0zNT75JZcuTUEweOdfPxmFGahBoJLDvKauLue/uV2DgbMavghSPf5o+Fa8EMlIN8+91rH9RE1ILZlcCi+9bl4nQ33J4MdQymRugi1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4Tv4tyrd5x2Trn+uNMl/ZLIyWO31G2eDRBWxVp3dHQ=;
 b=t4SOoeAE07Ha1BfnZnMthJZjJQ2W8eOtB88hDeaoQsA3Qz7d21aL28dnzZFl1/+5ZEMkEGot/g3lHBaK4h4NT8aIk2sRKjvKePcGMrp3em/mUyyCtPxbi6vFoarMbEHqe4puh2bhPtcw5XF7aO3kOqZAhFKMD9o6c2DzIp/g8kr8pJ2tNqfijQucdI53YI/GlAKszRF4grgMGym6w4+uh6XOB3oIDYlOntYNLJQlk5/Z2M9VL1DELiAf+/I5iyoK3J0es1U77kiKGjZKqchL0vI75ueYd/qKw/0zxUz6ktmgTTosRZt3G+PSHPjVLYtHk76zMSVH/vVOhFiBPob2WQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by AS4PR04MB9507.eurprd04.prod.outlook.com (2603:10a6:20b:4ca::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Fri, 28 Nov
 2025 05:32:04 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%6]) with mapi id 15.20.9366.009; Fri, 28 Nov 2025
 05:32:04 +0000
Message-ID: <541c6616-224f-4b92-a980-a43ca159804d@oss.nxp.com>
Date: Fri, 28 Nov 2025 13:31:51 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] imx: container: Eliminate IMX_PQC_SUPPORT
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de
Cc: fedor.ross@ifm.com, =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <joao.goncalves@toradex.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>
References: <20251127192633.79935-1-marek.vasut@mailbox.org>
 <3da2565f-523d-47df-8202-0624bf0a445c@oss.nxp.com>
 <b44cb7cd-1c07-477c-8233-03d029266b7e@mailbox.org>
Content-Language: en-US
From: Ye Li <ye.li@oss.nxp.com>
In-Reply-To: <b44cb7cd-1c07-477c-8233-03d029266b7e@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0056.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:8::7)
 To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|AS4PR04MB9507:EE_
X-MS-Office365-Filtering-Correlation-Id: 60655d87-bc3e-4471-7be9-08de2e3f7647
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|42112799006|19092799006|376014|366016; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b0JrNFhSaXRKNENWWlB4L1VHWE03eEdtQjJ2MEM2K3ZObEZFZFN6dUJSd210?=
 =?utf-8?B?WHdRTTBvUzlISVBZbmFWMkF3U2w5OTRNUnZBMElPemd5Y3ZVSVJuaGFVendm?=
 =?utf-8?B?Ym4wMVBVL1hjN2k5dFdpcDZXT3pPaEZBOTA2RTY4WGFDMk5GMnk1bG9ocjFr?=
 =?utf-8?B?ZU9USFBESGpoMjVXRWxMeXNpK0J3VzFVY2l5Zmc3WEgrakhBbmM3ZkoyQkZ2?=
 =?utf-8?B?SHppU09xRi85ZzRoNVh0VG1qSWtjbGQ0d0hpOXNPRCszWTFSb05za01UWVMw?=
 =?utf-8?B?QXF2d2QwWGlDVG5HTFF6SWYrV2RnNHJ3aXRPcURwbVV5U0dkVUtRMXI4V3NP?=
 =?utf-8?B?UmtKUVlKNU5tdXRNTEh0RlRqOHZjVVFEWE9CRGFURExmMEVuemJYeWVLbHN6?=
 =?utf-8?B?WlVxMytpTE1TK0Q5Y3FTTHJQaWc2azlWZVBRbzNvVEpoekJKSTlZb0lPclpO?=
 =?utf-8?B?TXRFOFRrQXorNlI3S0tWeklWYzZIcFdleXRQN2Z3cG04SmxaOHQvZ2xRclRL?=
 =?utf-8?B?bExkTFlBUlVGSHJibEh2YjdZSnBSSG95WDRNTXpYMWJJdnlaZlJKSTB5Ry96?=
 =?utf-8?B?UW0zRnllUU5LTUM2VmZpVk45Z3h2SkN4R1h0OU8rbnMxcHIzYzE4eTcvcGVK?=
 =?utf-8?B?cXNINm9DNC8zTkJ2OWdjMDVkK25jUnpqckdGUElZanZFanI2QXJYTTFIcldJ?=
 =?utf-8?B?Uzh5aWFsVlZxRVFvdjUyazBYVFdTYUhCeGJqZHk5WFR4YkZMUmlvWUR3a1Vw?=
 =?utf-8?B?bkJjQUFuYytZalM3TDVHWmh6NmpEMHZCOTRmVTVnZmVHTC9HbXY1Y3MyQkRi?=
 =?utf-8?B?R01YaU9xSk9pQWhYRmJCdWhiUHczRm5BVk9yRWxpNGIxSXJTajR5Z2pma1Fj?=
 =?utf-8?B?em52L0MyS1JZWDJUbGVPU3BRdWZVZENmQnJINWVqOHQrTmZaUTJnV2Q2clZT?=
 =?utf-8?B?bXN4Z05DdmlTY3g3bUdzUnlnS3BkQzBWRGNMakhMMmhiQUcrQjFBdktRUnJu?=
 =?utf-8?B?djVIVzNrdzZCVmdMdWM3K0FLMFFZZkxCVHF5S3dUcm5oTWtaQ0FZZVd6bllV?=
 =?utf-8?B?MFJnQlFPQnNGQjMrYThWREE3SzhmMjQydnN5M1JSTTZRVTJuQlVyUzJ4Qnp6?=
 =?utf-8?B?ZTV3b21qQnQzaWVvaDdPdVphTS9jUjYxNFgwWHZIT0xtWEFSamQwWFdWTGdS?=
 =?utf-8?B?WFBDUmE5ZkhPYXFTREtxc2NyZitXNnZtb3E5M3VrUWpiWHFLa0xIQU5tUmJI?=
 =?utf-8?B?VlJEdm4xR2xJRU8rNXFsdHlQRVlueTdranBGSTd1WVFBN0lRTDA1VDdqTDhD?=
 =?utf-8?B?aWJ6TE5oUEJQU1RPZmdSNmRodXBPTEZmRXliUkdjSDRzRnU2VDZXeXJVcTZ1?=
 =?utf-8?B?WmV2RzEwS1Q2V2VSR2xrNk8vQmtwbTk3UFRsMHdNOUlDVWJ6dE1YZkdiRTVO?=
 =?utf-8?B?OCszenB0QnlXaW1aT3FkeVd1QlRPT1I3SEVYSndMYUIxUnAzY2lseUxsRnUx?=
 =?utf-8?B?NVpVM1hqeGlpT0xmSDNjN0huV3JHclNVbHAwaDYvdkZhbVhSdWpvYzFIaFcx?=
 =?utf-8?B?Mks0Y0p6UzlKb3FNalltOU1KWlJ2dWJOWVlxT2ZwdEhSRGkvU2tWUVFGNFRt?=
 =?utf-8?B?MW9LaDRMdnBZblZZT3RqRGlkQmF6VUhsVit1NXV4WTU0THdKalF0VG8rdW1D?=
 =?utf-8?B?OXhaRHpKdW5kc2huZUdiRXZ1L1liNHY0VGRkZDR4eG1aKzZ3MjB4Q3IxYzdB?=
 =?utf-8?B?cXJWd21HWjV2MThzWis2UENLMlF1akNYTXdPZ2JHbHNZNzFiTlFldTY2WnRT?=
 =?utf-8?B?dE12YzhldG55djBGSndqY1psR0VXNnhTbHd1WjRqNGN5czBhZkU3dHo5ZnlG?=
 =?utf-8?B?akd2dEUwMmVpY3JUZzJ5SklyV1Z1R2FkNVZCakZNYXJySU9mNXFMajRDSGgw?=
 =?utf-8?Q?erc1GsT6pmhABZSih26x/ki6XyrTJ/nR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(42112799006)(19092799006)(376014)(366016); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnFPVUZobG42UldMSDhPVldWV09jaWlhTE52YWZPL3k4bEt1VzlWVHFvUW1P?=
 =?utf-8?B?MWlhb0pkUnJBYmZvVGdsaFpOMzJPOFFHQmV6Q1U4NEZkMU5adWxMSVI3eUZY?=
 =?utf-8?B?TXRhTitYSStldVRuREFNMDdvQVNkSk56UWlhS2VHU1Z6cWlIMFRVaVBNbWZB?=
 =?utf-8?B?SytHTjVwSVBUK0hvS1dqWjYyWHFIaGczSGpmbk85bzBjeXlvcWwvakZlK1Vi?=
 =?utf-8?B?aHhhMnFOSzdvRnB1RGZoc0RHM01rdVJlWC9CcG9GTG9zSFU2OFN3a1JMZzZo?=
 =?utf-8?B?Qm1lRy9EUHJtNTlKek40bjdKMmZwR0dVb0toWlU4VUF5cks3aDV5OGRkVXQ0?=
 =?utf-8?B?SDVFYVpVQmF1emgwemxwcWExcXRVcS9zNGQ0TDlOLy9zdVh4cUpXNmVaanpL?=
 =?utf-8?B?TTJVS3EwZGdPN0hnbVZsUXpnQ3Y1QmE1R2k5STRLTUFFNFAxZjZHYVJ1QlJo?=
 =?utf-8?B?aTZuaS82T2trWFBna1dKWEd6MGFkMXZxTXB0L1ZRbkdNK0grRzdKL1hWdjdM?=
 =?utf-8?B?bjluRm4wYzlRaEUxTnR4Q09mdjV1YmFSMWoxK2pBVTBMaXZvNmdDRkJLVkF1?=
 =?utf-8?B?SHhHR2pWQkRpS0daYWZ2YU42d1BjM2xZYmR2Uk5DWEJBaDEzYWhnSFAyWVdt?=
 =?utf-8?B?cFhoMEhoSXdvUkNRZWVBK0ZhMmsvYU1YV2RhZVdPRC9lYWZyL1F4VHQwYkZP?=
 =?utf-8?B?enJPbTBPUlVudklwTmJyYWd2cUo1MC9Uek9ySVREenUzdEpjRXdxcjdPTk8v?=
 =?utf-8?B?VVo4QjgyNEg5Z3JLRS80UHgxS1JpWU9LTWlIcEp1d1ZOZFFDMDZ3VzBqdTlj?=
 =?utf-8?B?cjBEYXI5ajJ6MGFkU1o0a1habElpR05NbGIranBGeEY5TDA0ZjhnVkY1WEZn?=
 =?utf-8?B?ODJHSnBuZmNvSm5WVjU2ODhwVVllTUFMZGFwL0RrWXlEY29OaU5zc2loT0NH?=
 =?utf-8?B?Lzg1Mnp5ZEtOS0Z6OXQ3akZ4UUVYR3FFbEVhTTZUY2ZkdFFNOVJzS0d1NWgv?=
 =?utf-8?B?ejJveW9oNjd5NGhqM2dyMWJZbTNwZDFuSkpLYlZCbDM5ZTEyZEIzOHNicWRm?=
 =?utf-8?B?T1dWbXhkMlFZUXN3VnFmejJ6Z0Z1QXJjWTh3Zk1PbndZWUpTSXZORWF6V1Nu?=
 =?utf-8?B?ZTMvZWJWdlBQaU4xM1ExMUFvYXg4bDRYc3pHNHRZVHZuOERJUDJYZzgrWno2?=
 =?utf-8?B?ZHdBSlU1bmc0bXJVYVR6bDJyM1JqN09UTUlUYzVCOVlmQ3dVblltMDBVSkND?=
 =?utf-8?B?SHBlZ1RSNUtsRS9QU2hHMW1laGw1eUhoRGVkK0phZGZYYUxCUUJ6Vm5wU2xz?=
 =?utf-8?B?ZWFxc1IyWTVpVzZHYXRMK0NhTnVhZGQycDJDR0MvcUVzUEVVcFdCNGtBUTNy?=
 =?utf-8?B?OUsxaEtOQVlyT1hlZTh6cjd3YWQxeHBSNTVVWjRrMmZtK2l6eHRYcFp3OGtH?=
 =?utf-8?B?RlpYVlVLQ095T3Q5a050VkVjZldYRGhyelR6ODdVZEl3YlFZMy9WZEVsZUZn?=
 =?utf-8?B?Z2xXR1A4RDVvZnZNS2M2YStPWlVMUWRwemhIYWJRQnhySE5qS0ZFMHhVZGlY?=
 =?utf-8?B?Q1MyUEhRSGFsQXFiaHJ2K2QzdlYxclhnMFlQNjdqMTFpZEJEL01TT0Uyc2cz?=
 =?utf-8?B?cDYvaEVkYTJaR1BiZWh3cGVTcWl5N3I1ODR3THdqQXFxOEs1WnFZNERDZjdN?=
 =?utf-8?B?WmxNdkUyYVZGT3gwYThlUXI5RGVvY1kwZC9yVFg0M2d6bkxZd0JsanBkWGFU?=
 =?utf-8?B?d0hyVDRScGUxZVJQUFdzT1ZRbHR2MDVkcis2dmIyd255Wnc1QzE4N0RQenVk?=
 =?utf-8?B?dnNqUWY0MHNSNW5XRmU3RDdVaEMvNGlvbUwrQWRJZDRKQmZDN05PeEVjamtY?=
 =?utf-8?B?ZzdOMUMrYktLclBUZittWG9wSVR3eUFyOGZZU1ZvNkp0VjB4cGtTZDdKb2Ra?=
 =?utf-8?B?K2JsWlJRK0tGYlY4cm5NbWRBUVZnc2dNRHZucEdScDZPVU1sM0xyS2dxU05D?=
 =?utf-8?B?QkVlVXR5ZVVIUHJYZExCM2FkNjQ0dzBrZDBHcHpJSmc0NkUrY0ZYNnBkNHhE?=
 =?utf-8?B?TkNMenFURUtUQlNKdE1tL2NNdHJ0bHNnN2VaM3lCUDlrQXFOelVCbTIvbzdr?=
 =?utf-8?Q?VnXCQ7jxNSAeAqRk2dbb9+F3w?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60655d87-bc3e-4471-7be9-08de2e3f7647
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 05:32:03.9240 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7W2Mq91L92IhPftGyMwasj5MPdATyMEAZgB03XdK6FS/+6H8SEY3baaCRBqUGOXv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9507
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



On 11/28/2025 1:09 PM, Marek Vasut wrote:
> On 11/28/25 4:26 AM, Ye Li wrote:
> 
> Hello everyone,
> 
>>> +static inline int container_hdr_alignment(void)
>>> +{
>>> +    if (is_imx94())
>>> +        return 0x4000;    /* PQC */
>>> +
>>> +    if (is_imx95() && (soc_rev() >= CHIP_REV_2_0))
>>> +        return 0x4000;    /* PQC on i.MX95 B0 and newer */
>>> +
>>> +    return 0x400;    /* Non-PQC on i.MX95 A1 and older */
>>
>>
>> I understand you want to use single uboot and spl image for A0 and B0. 
>> But A0 is not production. Only early customers get few A0 samples. NXP 
>> marketing has notified these customers to replace A0 to B0. Are you 
>> still using A0 board? Is it necessary to do such change as we want to 
>> remove A0 to simplify the codes?
> 
> I have both A0 and B0 device.
> 
> I do not see why we need to have a Kconfig option for something we can 
> trivially auto-detect, hence this patch.

Yes, it can auto-detect. The history is we dropped A0 when upstreaming 
B0 support. But someone from community complained A0 broken and 
requested to add back A0. Using static Kconfig is easy for removing A0 
in future.

> 
>> Eliminate IMX_PQC_SUPPORT config is not a good way. When adding new 
>> SOC, developer has to update the container_hdr_alignment, then it will 
>> be a long list in this function. Actually only iMX95 is the exception. 
>> If you insist keeping A0, I prefer change like below and retain 
>> IMX_PQC_SUPPORT.
>>
>> #if IS_ENABLED(CONFIG_IMX95)
>> static inline u32 container_hdr_alignment(void)
>> {
>>      if (is_imx95() && (soc_rev() >= CHIP_REV_2_0))
>>          return 0x4000;
>>      else
>>          return 0x400;
>> }
>> #else
>> static inline u32 container_hdr_alignment(void)
>> {
>> #if IS_ENABLED(CONFIG_IMX_PQC_SUPPORT)
>>      return 0x4000;
>> #else
>>      return 0x400;
>> #endif
>> }
>> #endif
> This adds even more ifdeffery and makes the code even worse, so no.
> 
> But if you are sure that every new SoC will have the PQC alignment, then 
> the condition in this patch can be inverted this way:
> 
> static inline int container_hdr_alignment(void)
> {
>      if (is_imx95() && (soc_rev() < CHIP_REV_2_0))
>          return 0x400;    /* PQC on i.MX95 A1 and older */
> 
>      return 0x4000;    /* PQC is the default */
> }
> 
> Are you sure every new SoC (at least in the foreseeable future) will be 
> like that ?
No, it can't be guaranteed. And we have legacy SOC like 
8QM/8QXP/8ULP/93/91 using this container without PQC support, above new 
change will break them. Please consider keeping the IMX_PQC_SUPPORT, so 
every soc can select it to work.

Best regards,
Ye Li

