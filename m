Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85140C9EC8D
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 14:56:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 065EA8393F;
	Mon, 12 Jan 2026 15:56:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="X0ModQVJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5943D83936; Mon, 12 Jan 2026 15:56:24 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 163208388D
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 15:56:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r2pX/0I9e/Z5rJnll6rHYDYSBi5ys02Fow8Jc5DrcAcNDfuwlS4s+6wSWTpQYuFNrzAqc7pQpoPzge1o8VSattNrPm7157J2QUdpzDAYX1n67Svk4ziE9P3vp2j95MRbhH73NVROJwSn0molWBCyXhiZXzKe9ekCSsCLCgW16+3abtgIHRwRoAWToCHMN5Jt/1Y2gzAUnNPabLc8jA82s9bt10uDhUvtLuHul+BgdVEMu37jUnOVL9rvap1uUetxs4feQ6Sbfj+DNlKGqfyqda1bXbFQaELvUhaMLZvtvPvEhVirZmlHghnafbnrDBv4u6M2bR/rXziP9l4qApXZgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GGFWDnyqGjc309GExZ18IkfajpVK2t8tz3vqBMJG8vg=;
 b=NKO9gaakxF1hrgL+EnkPfNzfOg79FucOBwwgC5yAgz5lmdNL8XjVdKSOZL6o73M2K1o579HcOZqXGAWPYqqwTdFPGN1Iz5duPmrodS9hrhNcM2zgILWtrYzKQc3BCvyHWDaeL7D2vQ3YGjAipV4kDqArkbU8MuHGvpsqBXEIR1wuIlh2U+kLq6twIc7H7cJbEciYkuGn+XgxeUFqaYxRZdg7E8EZwu/tL5E70AUtWcId+xmd8IVBFtu9Lc4jM/MnfdhPqzQ6E2kpzZJP922w+ak2rrAhU3ukfejPBq23VTcECUubzKeaxOuDaorIwvhrndUSQ/YQ7oiV+ejHMHHrtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGFWDnyqGjc309GExZ18IkfajpVK2t8tz3vqBMJG8vg=;
 b=X0ModQVJE5K3Wd7kC/Iw7HSsE64WmBbQfku4uohy8X7to6S0om5W1eZDShGgzrkOcrHNZK1TewY8uq+kBx3I6KyzJnSMTrymBZ8mUNCK93S7BXQZ24qJbn7IykEpDhGJDbwMGvEmBzDUeL0caQJAr0IQWeaeO5DW85Dtxb/l/4o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by VI2PR04MB10834.eurprd04.prod.outlook.com (2603:10a6:800:275::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Mon, 12 Jan
 2026 14:56:18 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 14:56:18 +0000
Message-ID: <70c77be6-4284-45f7-a1d2-6b74b741847e@cherry.de>
Date: Mon, 12 Jan 2026 15:56:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: gadget: fix vendor/product id for qcom
To: Casey Connolly <casey.connolly@linaro.org>,
 George Chan <gchan9527@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, Marek Vasut <marek.vasut@mailbox.org>,
 u-boot@lists.denx.de
References: <20260112144933.3992369-1-casey.connolly@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260112144933.3992369-1-casey.connolly@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0390.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::15) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|VI2PR04MB10834:EE_
X-MS-Office365-Filtering-Correlation-Id: 0be5ec73-4327-4ee9-7336-08de51eabe04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SDVaQkFsTjVidWJsaXNqaGx5MW14MjFJWjNvSU1CZnZkNHFCRlZLS2pLRzNV?=
 =?utf-8?B?Ri91S1BnQldOUUEwakpURzl6cVVNT0JCRCtpckt6emNQem14MWVzZk5oMnB1?=
 =?utf-8?B?VmJ5akdDRDA1TlZCNkRXN2lHS1lrMjE1dWNxUitGanM3dUUrTTVqbmN0aVdM?=
 =?utf-8?B?U1pMUHNUakIwRVlXQkwwUll4Zmc4Vk9YQi8zaXlYbFBvR2FMT1pjM1YxeE5C?=
 =?utf-8?B?TmpyRXZEV2VIS0NTLytRVTc3azlobERJN3dEQ1dZaU1GZC9FaGpnWUJMM0Ru?=
 =?utf-8?B?ajdiUnVMcGsyVXR1MGxXR3k4aUIrNXhuaTY4N0p2Q1luSThQdVloMHFzK3Ni?=
 =?utf-8?B?MVFycm1UcTcxazdiQjU1aXlLRDMyMDRYbjNrTWdzRkhHMk5kWEh6R1ZmNUFi?=
 =?utf-8?B?ZjkzSGpRVGtPakFIWE5aY25EanRjRWd2LzVhczVsZjRCY1kzMGFqVWJ3dy9w?=
 =?utf-8?B?Z3lrNlJaYlVhbFZoMEJMN0lrbzlaa3hVQnREcVBuVEcrRUpWa2pSNE0ycnJK?=
 =?utf-8?B?TFN4VENXQWRld0pOaWJaa3prUTY0Q0IwLzd2S3BsRkV4T0wrZHFwTGNST29t?=
 =?utf-8?B?VEVpckl2YjhqMG0vUWJvSEZNcVVMQ3FBT3RxU2VTRXNmeHY4aWN3S29iWDdj?=
 =?utf-8?B?QmFnaDdIZlBaeWxYakFhQTZhSTNVemNaNkprS2ZKN1B4SkdPWloyVi8vVTJV?=
 =?utf-8?B?SGFyeVlFeTA0b2phNXZaVDhHSGIyVFVnTHArTkFhNWJWVFlxUk1vZFZqRWNX?=
 =?utf-8?B?OEVMVUt6dlM5bm1DbUFkZ2hTeXAwdmVINUhXWXNUSlZHUzhNK2NGNnBlNk5o?=
 =?utf-8?B?S3hYQlRHNHlOSXhWUFZrSmxnaURxVVFYd3NjWENmUTRrYmZpY2JHaFNEK3Jm?=
 =?utf-8?B?NjBOY3VvVGtTWUMzeFFiMDR5SEFNT1plKyt0dGdYbEJnemZjd2JaaWZPSm9P?=
 =?utf-8?B?S28xeVNwUVROQmF3N1EwYW5ZSjJVVVZDQUZFK0lITFVQbW9lTDlMbkNtbXpt?=
 =?utf-8?B?VElpRXp3M05nWlBoNnlnRS9XUUQ0cGRaUTE4NWNmcHdwMVhpQ29wR09paUlq?=
 =?utf-8?B?UzRVU25lSm9pYUc5UGNLemEybk1iM0s4V3VGVlNYdzB3VTYwci81ZUJPcTBH?=
 =?utf-8?B?TzJiSkNPa2lIUTZCblhHSWZPeWVUVkdWTitXZlNydlVtemQ2SDMzVVk5Mmpr?=
 =?utf-8?B?dThqUEJGSXVrcE8vUldyZGdhWUVQQkRYdzdrdzkza0NwNWhGaWhOdnArL3F1?=
 =?utf-8?B?MW5Fc2xxc3ptRVQrb2IvMzhCZHBZeVBlclJWekRKODJPYzRDZ3ExRFd6bUZk?=
 =?utf-8?B?NUVFRnFrditvVzNXYitNSThHd0MwKzg1cUpoY3JXTDFUR3VqQmw0Rk54OElk?=
 =?utf-8?B?N0RJTjJxTzFuaEczTE90dEdDeFRXSm5EeXNEVWZVeFUvdDBVZURrS3R0dDFn?=
 =?utf-8?B?TFZFTStIZmlOdy90eHZORmdwVFdWTE90MnZTV3NCcXo4N1dRSDZ3TkdSVllM?=
 =?utf-8?B?bTFTTlk3ekY0MFhVdXkwSjRxdlltS1ZLS2Z4ck5KcGZxSWs3bEpFVTUzbmN1?=
 =?utf-8?B?Q3lOVTNoM0IvOFIrd3YrdGM5OStWS29zODM1MEsyZk9HVEQ4RXNLSzljLzcr?=
 =?utf-8?B?WGFDSFJYVnpCSExISjJoQ0Y0ekxxL3paclkyRHFVVEVDZ2hlbVZDekRQVVlC?=
 =?utf-8?B?dHRUbEdtRk1OemlHSEcyV3lvSFNzS3dHVTgrcEhXVjlZYkdyTHJURSswSXgy?=
 =?utf-8?B?cEcxN1hPZkcvdWNCb1pxRnBIOUVXcVFMRkVJNzNDcWpnZWpEYzlkVDkyTzJO?=
 =?utf-8?B?U0hTQmZCNlpQZGtOKzdEeExETU5sbjRVRnNPRjZNdzJaUVE0UWUyUFZOTmEr?=
 =?utf-8?B?aG9yZmZCY0V3dlp3eXQwYkZsdjFteFZUdWhlQ0sxaHZwVVpuSlNtK0hsalpQ?=
 =?utf-8?Q?jmSAxnwbbaaO+iLZb1prAFXZLgNDjakJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d01FSm9ndTdPUlBXaDRkdlo2VklEc1BOTjRpZC9PM2ZGZzRYNTBJODVka0hZ?=
 =?utf-8?B?WnY3MG9tcEZRRTE1UmEzdE1lODYxS3NnazRKcGZkanI2VmdjOXo2RzQrVmFU?=
 =?utf-8?B?OFRzZmdQdDVGK3JpYUJ2cjRHdnpuTXRnclpaK3o5UktkZzVycDVpdWYwK3NX?=
 =?utf-8?B?Yy9KSFpLVytDWWtUdG4xYTdRZmFtL0h3NDVtRmpRMzFJQkxNbVRGL1JVWVdl?=
 =?utf-8?B?Q3pxakVpTmovL0VUN2luZzYzakN6SW1PZ1E3b25JckphUE9SZlF3QnZRSEZt?=
 =?utf-8?B?NGhpTC9YTzNGTm4xZWxmSzhLcCt1K2h6cm5nbTFlYU91dVgxT3F4MVU2bnpG?=
 =?utf-8?B?MW5sWEh1aUh1bUJEYTJuN2w5aENiLzg3dnNNdUkyZW5CMHFZeG5OZFFlUlB3?=
 =?utf-8?B?SUpJMzVITnlNT09JWVRYODFoU3NyQWN4aXU0L0ticHQ1NnhhTHVMaGErSWYw?=
 =?utf-8?B?dGRlcks5aGlnY0hoVXBHdkF1d3lIa1dVZ211S1NuaDV6NnJ5WnlnWkdPUmFT?=
 =?utf-8?B?WGVFblNIZUVodGJpK3d0cU9WTDdZTG0yUHBWczRZeUM1cDRMWlA5L3pDT1Fk?=
 =?utf-8?B?YTY5SG1NcnFiTjhiRGVSWEZsS0I4SXF2ampIOFVKOHN2MDlWZ2RucUttZ1Ft?=
 =?utf-8?B?TzJtbHd6UEcxNTJCRG9ubXd4eUduSFJOdGhHTG9pL3pOOUo2NlppVTVON1NC?=
 =?utf-8?B?YnRQSUVmdmFZc24zWE44UmJSTDZQQThXQzF0K09LWk55K2M2Z0VVM3VFaHIv?=
 =?utf-8?B?OEY4cGZucTlmaktDNWlkYUphMGZMelhoaWNkM0xzT2pxNHRwdnlyclJLK1Fr?=
 =?utf-8?B?cG5PT3BEckw3V3YzazQ1ODJnU3ZvTWg0cnJEemxoVGVDeldnRzhJZ3VJR0I5?=
 =?utf-8?B?Y0FDYjFOYWQ3NWxTc1FwZjBzYUpiZkUxTklxcGoyT2pPcXlvWGtMTU5BVDc5?=
 =?utf-8?B?d1Ivd2xobUhxWlpkTjZac250QlBHRGRVVk5zUE5OWk81cDRHMEZnL2R3RFh1?=
 =?utf-8?B?Yjl4emFLd0lKTDd4d1ZSOVJSZU9XbEdoaTBYbGhxUWJZa0EyM3REUXpSQWVS?=
 =?utf-8?B?aVhobHpFR2xUYUR4U0FnaXJQbHM3Nk5qUUxsdUxBZjVLU0o5eDBuR0M1OUc3?=
 =?utf-8?B?L2kzL3V4UldMZDFUcHkwZVNMdy9MWnh2Ry9FSHhqYUtQbFRESHdlNlRaZ2p6?=
 =?utf-8?B?bVE4akV3NjRXV3ZrQTkzNCs4UXY0cU55aFRhU1orQjM2VlJxSGdJZGdaTE1p?=
 =?utf-8?B?a1RpNnpJQ2hrZjlBYW5vQ2lCWWgyZ3JpdHhXYTBQOGtHSE5PM05CMmtiam1Z?=
 =?utf-8?B?RmhEMEJvVUhpYkNOVFl1NlpvQUpsOHBsUUJlY29aMXloTHZmTnJBRGNVcWQ0?=
 =?utf-8?B?OEhzZnBDeWJXZXdqcXlNaElUZVdXMTFtZnhNeTVCOFBuNnhJRml4Q1owaFR0?=
 =?utf-8?B?amJkSWxrdFY2dmxuSDZVajRDQ2JZaGJyMGQ0L0pibnV2WjZMYzNKa1RlenpX?=
 =?utf-8?B?YUxYeXhoVmNBUzMwWlhlRzJjOUYwVzU4ZVhmREhSdytEM2plYWxwREdxdnlM?=
 =?utf-8?B?cFVWemZHNWV5Z3pQWHVvQlJ6UFB4V1gxclhTSXFydHlqZ3liSTdjRmE5bUdp?=
 =?utf-8?B?bG9zajFpdXRYeWV3Mms2WTlCUGRlZElaeXRCd2FjZ0JqMWgyQ1JuelpoYnZ3?=
 =?utf-8?B?bmhWQUtXaEVvaExGYk1OMkNLQ0hFaXRwMEI3czRHVlArT1YzalpsV2g0VVFP?=
 =?utf-8?B?SzY1UWJwRVk5ZWQ2MFhEcmRNK2VRUVM1T0sxMnRGY2hJeWVYTHE0TG5YZXhp?=
 =?utf-8?B?S3doS2U3QVU0VytSbjNvVjZIaDBNMS9DUEdoRkhxaytsaEFQWjlpRENaZjd5?=
 =?utf-8?B?ZFJsazVxRGpZY044VllHL09IL2t3U0pjZzJvSkNJYXRnR1p4WWRvTXlOclNm?=
 =?utf-8?B?UDNzSitHdkRzTHNzQ2tkT2h4eDJZMVJsekI3a2FGWkR3UUlDN2RDSFdkcTRY?=
 =?utf-8?B?U3hnYSt6SytVVDlJS3lJYVJCYUxueUFuckFQTXpCa0JwWU9rdCttV3Z6QW9j?=
 =?utf-8?B?M0NUSnlBQU1oQ2tLU0Z2REpqeFVVdHE5dDhmRGg1VzQxVktHYVZmSGJyc3Uw?=
 =?utf-8?B?NEx4RkJpVzFvdEhwSk1YNVpJWURvalVsdHNoL0RQRGhiNm9GRjdIaU5JRVYv?=
 =?utf-8?B?RDdPdXZ1Y2tWNi9sYWJrOUR3akNucmJxVGlGVy9wcmVKT2VXTU4vbDhqRUVF?=
 =?utf-8?B?SSt2VTZ6aUNvUVg5YWJNOFU4WUVkb3FNVGJCc1ZsbnRpTk91WGJHQUJpOVN2?=
 =?utf-8?B?MC9mSXJiRDBzeXhqNW8ya21WZnpqckEwbHFSSTdIOUw1cnZlUFQ2UT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0be5ec73-4327-4ee9-7336-08de51eabe04
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 14:56:18.6285 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wEA1OJ7PGSDu14XSW233er/AZFpJPbgdD8i4TLbydIYQCKyDoL0r1nodTmGnXYG+qzdTLTuQwpNU4QsxkqaCz/AEaAMLQ+/Ka0fQEUAr70w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10834
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

Hi Casey,

On 1/12/26 3:49 PM, Casey Connolly wrote:
> Due to a typo the defaults for Qualcomm were never actually
> set, this got missed in the original patch (maybe time to rename
> ARCH_SNAPDRAGON...).
> 
> Fixes: 934647d49c61 ("usb: gadget: Introduce usb gadget vendor/product default id for ARCH_QCOM")

A patch already has been sent (and is assigned to you on patchwork 
apparently), see https://lore.kernel.org/u-boot/87wm1wflcr.fsf@kernel.org/

Cheers,
Quentin
