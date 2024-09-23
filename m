Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA3ACF9C6E
	for <u-boot@archiver.kernel.org>; Mon, 23 Sep 2024 11:24:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D43A88CA3;
	Mon, 23 Sep 2024 13:24:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="bhuzNClm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68D5D88B79; Mon, 23 Sep 2024 13:24:49 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AD1F88A0E
 for <u-boot@lists.denx.de>; Mon, 23 Sep 2024 13:24:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=orqOxgZABahK8oJW26PM1E5SPJtN3y9x7CG0tV/IBKlQtbFCheljZgMOasXn3SM5HD6XnEK4QBm9ecsOfqf8/feo218nae4eYDDKjIs5iGqra5cagcDHa8oFRwNbBrtHFct6unpwnkexSI+jmTdjy+u0BCZIRFAlLKzuW1V0GiPtOlKafEFyANXURXT8T1rwaICL3L3nohrz2FCPWW2Cf4/NcZu+8rX+RrfFGk8lO0L91i7O+Sb0EVAQyNy2/r4x41xBI5eMJYG3gQyFhyF4NvKM+YZhd712KqOacNK1fTyjrrq9feO6cgrdglwuLmHl5i5eS9WCEFUWAebFiTKtCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LiU8YAH/Ws7kw32os1PhE4okHOCZwFO3dvlonb/3Rvo=;
 b=YyYHNcl0jAnJJuzt61FUbTXeVtjPpyruTBrf9NGGIhR1hnu+j1s1mnQo7YO5kqrEe2dP67y+mJCjbCo99jSoyKTb6JNapsd+TFS2Qb7j24YUYcGdgfWuKuXD80jtvrI7xYqZzkf8hrSinSBW0mLQDo3QVokUbbjJEnESTDiA8mLew1t9NQcm+BVm++zGxIX2wIS45WOCudeRYhZuxZhgJHRLSuVL0ZQ9wEDay+bLraXHzOXli0opUCVF4dan/tDkYZ55hSIHIdbDsxsljBrXahNu4laIrM5X79m7Eh3PGAJoELdHf4983UsuPfUXAS4iwYWrGvntJ9AFLWyFnotKYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LiU8YAH/Ws7kw32os1PhE4okHOCZwFO3dvlonb/3Rvo=;
 b=bhuzNClmINwD9zfk6xyMQyKVYgOGrjBBqDMUpc0ZJ87NlfiVC/Yubnr963u+fPQtY6sdNqz67J4uW2saOVP9DVlwOFJZ+H7Knxkv4aWmo6kV7yBIaylSP0irVIikIvoJQNwb8s44I3VrnKErTGoiikmUzaiuJOdxM3/SADIMaqc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by PAXPR04MB8492.eurprd04.prod.outlook.com (2603:10a6:102:201::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Mon, 23 Sep
 2024 11:24:36 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%2]) with mapi id 15.20.7918.024; Mon, 23 Sep 2024
 11:24:35 +0000
Message-ID: <da41ca54-871e-4e40-b7c8-626a3c4a3f1a@cherry.de>
Date: Mon, 23 Sep 2024 13:24:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 4/4] board: rockchip: Enable PD_VO before driver access
To: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de
Cc: jonas@kwiboo.se, trini@konsulko.com, kever.yang@rock-chips.com,
 philipp.tomsich@vrull.eu, sjg@chromium.org, dsimic@manjaro.org,
 Chris Morgan <macromorgan@hotmail.com>
References: <20240919140022.511067-1-macroalpha82@gmail.com>
 <20240919140022.511067-5-macroalpha82@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240919140022.511067-5-macroalpha82@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0013.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::16) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|PAXPR04MB8492:EE_
X-MS-Office365-Filtering-Correlation-Id: 422e6b9f-e5f7-45b5-c3f2-08dcdbc24df8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MWk5UVIwdVFWN3BoUHgrc0twNk94Z0Jnb25IM2RXaHlKMVI0eWNTU25JaHFJ?=
 =?utf-8?B?REtoMWZrS2QwbnhOWWRteFNrWTVkcnRzeTdPais2WHVyUW52YTNFaVpadlUz?=
 =?utf-8?B?a1JtdXR5UmFTVVp0SjVudkRwb1ZxcjlVVFhJMWlsY2tYbUVzVkZXOWFiNzhn?=
 =?utf-8?B?SFl1ODF3cDNPN0svQnY3VW9HOC8xR0ZSZUIvWHJCL2xRM2x2WXRMTFY2ZW1J?=
 =?utf-8?B?aXIzU2F3VndyZWFXQzhScyszSE5vV3lBUlFwNHlTdHRmdmoyMUpFZldkazZr?=
 =?utf-8?B?K0Q3OGxIbWhLZHk3K3I4bjcrcGI0MnllT21pbXRXcitZV0MyTklEQ2FPemx1?=
 =?utf-8?B?dkpQL0sveGZHc204cFh2ZnlsVXJQaDBUUm1OS1B2MWozcnJNQVB3N2svT2hx?=
 =?utf-8?B?emlJWG8wQmc3dDlQM3AwNytrc1N4QlcyWTl0NnpGb2xqZVgycnVkTlRGbVRP?=
 =?utf-8?B?RnZnenlpbTRQeWs0V2NrNnNESjc0UDlDaXJBeVhlSHRUOVNPY25nSzJhaGVo?=
 =?utf-8?B?WWZ2ZnhsaUpiZ2ZhZkd5allkTThOTXBpdENNYlpjOExYSGZuWitWMXJJWDlz?=
 =?utf-8?B?VWVpYkQxZkRWNCtoeHgzdTFQd1c0N1BINnhEN3gxQ0hONW1icWorSjZ2WU1T?=
 =?utf-8?B?YVdEdHpXSFdtcWV0OTZmL1F0ZnhDNzVOYm52aUErbjl4QTJkZjhWbkFOSWhz?=
 =?utf-8?B?OUE0dDlKS2JFa0p6NWxadUNYTVovbEppNng2K2tzQUtlT2l0UjVnTjFFTTk5?=
 =?utf-8?B?NEI2VVlqelVqK2NRWmlGWGlmWUlZeVFFQjJXTUxaVkJacUtjRWNqZHdKcFlF?=
 =?utf-8?B?cFlzczMrRituN081cmpVUXJaRmFzRGtLUktHMkp6TmF5UkdmREt1M3p0aGJ5?=
 =?utf-8?B?ZDZSWnRMOEhUZms4OWxFRXM2TVg2bk1udUdtMytKckpVS0lqMzZXblJBV0FO?=
 =?utf-8?B?VkxEcGpWQ2M2bkFvMFA1U21HWkZMK3JHY2cvcHQxTS90K2dCRGhDckh0bkti?=
 =?utf-8?B?QnFyNkVudkFVbjl1VjlNVGJzcGVaMVU2a2Zlck52ZWhlMWRWTHFoT0FKekpt?=
 =?utf-8?B?MWxIcG9pYXpsUGxha2JQRmVEQnhxc1dOd3J1VGJOU2gzK0dINS9hYXUwMlZT?=
 =?utf-8?B?UEdEQzJwSTZkQ0pwblpUSmRxdXpJbit4R2lOZWN6RnQzd1daSjdJYUR0QXds?=
 =?utf-8?B?MExlZjNIMmtPQkJCbGRsMkNNdGtoeGJ0ODlVeXZ5SG5aQ01MQzNRRm5UNGhv?=
 =?utf-8?B?NzhOV0RFQ2NMdVpXaFNyM0t6cU5xSWN4U2JGR1F3ejJwNkM1YVFST29kWXlZ?=
 =?utf-8?B?MXJwUFp3T1FGWUxYMzYyUGNuajVyWmxMRjJoNFA2YWlhK1dkT0x4NUhTeUg1?=
 =?utf-8?B?YWZxK2xtL29oT25TTmFxcmlBcUVYQkRKRm5tbEhOUkZlQ1NOenpSTFFPODVN?=
 =?utf-8?B?TlRFcEZ1V0J2QkxCQTExMkhDSUpXZEpCWjNSVzhHQWxseHoxWWhtZTZyMkpD?=
 =?utf-8?B?a2ErSlYzaVJwVkp0d2lUb3NJVXZIcTlLWVUwOUZqQWQvejZFSWJPelY1TUtj?=
 =?utf-8?B?bmx1YmFVV2J5MkdZWW1URGN1ZkJ5MC9kcFlFdWxsWDh0NS9WQ3JQcmRCbTdS?=
 =?utf-8?B?WGhoaUNxOUZtMHBwRm0rb2FFYUhQRk9HQjlyM1BPTDZUbDBzWTdldVRUSFQv?=
 =?utf-8?B?TjVTTXZLbjVET3V4QmlSOEdyUFk1MUNaVzFXMDc4TlQ0NWZhdHBYd2RBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zjc4cDYyYk95Yis0U1M3YVFtZk83TUNhN3BEQ1piMi9QN3BzN3paS2ZTbE5F?=
 =?utf-8?B?M2pucG9ua2o1MUVHWjZ2dXpUYlg4aXBjQlNFcDIyUWMwUXM0YXYvOVBYcHh5?=
 =?utf-8?B?ZUpNZG51TE9tdHhFNmw5T3F0WGpMYjdGcUYwM2dDdUVkMFQyRmlrRnJJa29j?=
 =?utf-8?B?WW1rSXRFWUIzR1E3SXJhQVJqNzFndys4cENhSmtFdkJrSDdIUXFjVzNtb29p?=
 =?utf-8?B?STFlVmd1VzhpdTNrQ2Y2cnZRUTRFYzM2RCttY0o2Q3BBK29aTTJCU21GeW9U?=
 =?utf-8?B?YWV2eW9Oclk5TVJMZGtFN3JRem9wQjd2SUFNWmR1U3FXa21KaXZuQ2pSR2VK?=
 =?utf-8?B?SmNOL1dtYmRmRVNUOHpWWUMwNklsK2g0NmhQNndxZ1IvSGJ2dm1mWEduN0FD?=
 =?utf-8?B?WHRCdGhJMWVSY1ZvMU05bFVaU2xadmZsbC9wdzlHb2dQTmY4WUJjTEl4V1FY?=
 =?utf-8?B?QjRNdm5DUDVIcmgzSjJmNHlmc3BuRUpnWHhZYktsVTlBcXZKTXgreTZLZXJm?=
 =?utf-8?B?cVBWTWRkNVFWQUlIUk9qUE55ZlM2QkgxcitiZWxaQkxLWkhKNmRHdFlSQzFk?=
 =?utf-8?B?QjNvWGdoeVJYMFdnK0NXdFlXZm5JUjMvaHErdjFwZDJVOEV5Y2MydC9reFAz?=
 =?utf-8?B?aFJGaHd6ZFV0Q1RmY3VkOHB2a2pxU2Foanl3RFJHbkV3aC9NYkNDUWhhQ3la?=
 =?utf-8?B?MW1IR3FvazNOM3BIdmx2bkJrc2lteEx2VzVKa0VMMjV4eHg5M1B2Z3BpRE9z?=
 =?utf-8?B?V1l0SnpWelZ4RWdjc0ZIaS9IZ1FiL2ZWY2llZ2pxeFM1bHlsQ2JoUGw3Y1RE?=
 =?utf-8?B?VjBKYXV5SWFDdTlpR1o1OFRGTnJ5YU12RFUydEpHYUs5bUVrbm94MVZpNDhp?=
 =?utf-8?B?YS90ZFk5NUZnc1hmUmlUT25ScTV6V1VNNlVzZjJYYWtXbE9EMG05clNRUEps?=
 =?utf-8?B?dGs4ck9vMFhtYXZPemp3cDd2MXdmNXE5TDZsS2lETFEvQ1JzVnNKQnlCbUlH?=
 =?utf-8?B?TTZ4TDRZQVN6ejhoWSs1WXVWV2Yzb3M1ZSsvRjNzSmZzSjJxbmtwbFNpaGEw?=
 =?utf-8?B?OGRSckNOOHNrVzNVRVlxbzM1cFg5V3NtT3FNbThHTTZTdWxXckZ6RXZFVU13?=
 =?utf-8?B?Wnl1WVhTNHo5SWNmaXhPVCtzbGFsUXZIMlF6T3hPbUNHMzRpby9OSUxPRURr?=
 =?utf-8?B?NlhGdk9peDhITHpjam9JRDdBSUI1bDNjNjMxLy90NWRLbTAxR3dZVi9DYlRn?=
 =?utf-8?B?SDIzcEpESEtUNHNnL21zcG1VZ3ZPanlKTWxrNEpLZGYyejg4KzlNRFdVNzZo?=
 =?utf-8?B?aHo1b2lIMG92UkVXMVFzeHAvZittdWtwV1AwTVRTZ0J2TkQzRVhHbWp2ZCtz?=
 =?utf-8?B?Unp4c3lsLzJEV3cyYnFrVkFENGFqNkFVNHFabWJCUkdhbkdDczFFL1N0dU1i?=
 =?utf-8?B?NzFIUkNiZzk0OWRVUkEwb2FhYytuTTcvTzNWbER4S3BPYS9jeFc3SG1PSitW?=
 =?utf-8?B?UWRYMzlWbGhRdHlKK20zWkFEcHV1S3A4ZVpGRGdFYUpEZ3dZSlZhQkkzempV?=
 =?utf-8?B?YlFGWGxIQWNzMXM1NEc5UEdQeGxZWXRCcFBJS0RoZVFQVFdyY3pCZ1oreEVU?=
 =?utf-8?B?NWZ5cmszWVhrOGtPbSszeGFzdWVMV0ozM2pCdnBoK1p3VnJ6ZTNGMkhPV2Fl?=
 =?utf-8?B?b2QzZzRodklOTThGczJMTm94bk9Wb1hHMnh2WGZNd1RnQzBiQ0VqRStRa1Vr?=
 =?utf-8?B?QSt0Mnl5ZldGWGF2eWZPSm9JRDBCeTlVaytSN1VUdmxRNkJrV1dMTkdlZXZ3?=
 =?utf-8?B?VHcvaElEOEt2M3pycTAzY2hCQmtCV0tDL1huUnZBWE1Obm8yMUIwQUt4OVJI?=
 =?utf-8?B?amdkN2xOS1Y4a2JMYWltTmtNYW80RytmMlBFbzlMbFhvRUlsOTFRVkFUcDZx?=
 =?utf-8?B?TXd4YVRmRlhDZSt4SFVISEhoYmRZQlZQMW1OSVJIOTFrWVJmVXA2NS95RjMx?=
 =?utf-8?B?Z0s2blpySEZqSkMreGdRT2t0bkJrM0lHbnlFdnYrN2loWDZpSlp5SHRtbUZ4?=
 =?utf-8?B?TjBPaVFYVXR0cTcvUTAxWTBqKzZ4MjVmUk8wSlFZbGJ6cEh2U3d6V01HQkNr?=
 =?utf-8?B?b2kvMXFpRDNUUnFON0lveUR0eUVUM3NtVmxaeTBwancwam10a3JicXRBc240?=
 =?utf-8?B?Q1E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 422e6b9f-e5f7-45b5-c3f2-08dcdbc24df8
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 11:24:35.9228 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a+5xOVY0qzdgjN+U8Jk7ItyBg40TSdCqgG53UxFp0i4Yct1KooPPRYtpRKZPmZln2auVGYxvL9w3Z53QKBc9fM3Gs1gNi/EfkYkCLZlwd0c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8492
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

Hi Chris,

On 9/19/24 4:00 PM, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Enable the PD_VO power domain before driver access on the rk3568 SoC.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>   arch/arm/mach-rockchip/rk3568/rk3568.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/mach-rockchip/rk3568/rk3568.c b/arch/arm/mach-rockchip/rk3568/rk3568.c
> index 1b3e40074e3..d5742b68d68 100644
> --- a/arch/arm/mach-rockchip/rk3568/rk3568.c
> +++ b/arch/arm/mach-rockchip/rk3568/rk3568.c
> @@ -26,6 +26,8 @@
>   #define PMU_BASE_ADDR		0xfdd90000
>   #define PMU_NOC_AUTO_CON0	(0x70)
>   #define PMU_NOC_AUTO_CON1	(0x74)
> +#define PMU_PWR_GATE_SFTCON	(0xa0)
> +#define PMU_PD_VO_DWN_ENA	BIT(7)
>   #define EDP_PHY_GRF_BASE	0xfdcb0000
>   #define EDP_PHY_GRF_CON0	(EDP_PHY_GRF_BASE + 0x00)
>   #define EDP_PHY_GRF_CON10	(EDP_PHY_GRF_BASE + 0x28)
> @@ -130,6 +132,10 @@ int arch_cpu_init(void)
>   	writel(0x3f3f0707, GRF_BASE + GRF_GPIO1C_DS_1);
>   	writel(0x3f3f0707, GRF_BASE + GRF_GPIO1C_DS_2);
>   	writel(0x3f3f0707, GRF_BASE + GRF_GPIO1C_DS_3);
> +
> +	/* Enable VO power domain for display */
> +	writel((PMU_PD_VO_DWN_ENA << 16),
> +	       PMU_BASE_ADDR + PMU_PWR_GATE_SFTCON);

Maybe we want to guard this with a symbol for video stuff in U-Boot? I 
assume Linux is capable of handling this just fine without U-Boot's 
intervention?

At the very least have #if CONFIG_IS_ENABLED(VIDEO) ?

What do you think?

Cheers,
Quentin
