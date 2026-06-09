Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E71CD6E79
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 09:56:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E77283FF5;
	Tue,  9 Jun 2026 11:56:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lZU1Qn9s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 435F28405A; Tue,  9 Jun 2026 11:56:07 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F075F83FEC
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 11:56:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ye.li@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BkyXIcCRrv+otskJyuHdqv7XlmVQzpfk6QrMnnlb7dubieNL8xRqoLRtVcDt6os9JxwWSGhrb35MM2/ZnDDOlVoj3Gz8ypMcc8EIBFuUIHGSXpToynVoGyDq/PnW+7Y1o1YTVGu1DlZ9So3f2SJ2tnbHUfoYGDPxZvpa/YHAvC/9ub3cCLpZxvF/r/AXZatYr3SOzqTm+7D2S4wXWeAKMVzXoVIWAnQ+e5YQSOUTivS02x2rkRdOdiQNUMmqL39m690mun0S20YB/iH7JpprfoIcAgBLMFat7PYFGEVAjoyPCqDvWPvnbA1DsyePHYd5lBPwb9DAK8wt4wY3SJkRKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ubZnDm9VkfZ1fTn9J9FlU7LxivOhOnPW6wUpA7pQkA=;
 b=KVsoUX/AJF+M3gq7XLyu8NbvQyH6NKDNfQFlRxWrI+Ep+6pXen5Uk/++1Lig20xYBsCnkRi2tgq0z5w3/0AnTnDEnvRQtVAwm0n4ivDdjHKdZRKalLawlXp6oPbs5i1yiUWHTLP4eL4ZNIC/PajMVF95NeL24IxQpzHY9+j0EYE18Tvsqyg/IkZ6W0U82BEH+UlAClF8N5gGy2Vev0i333Nbl60duzBlhcwKmp/03y9jtTp6X1ofevNRcyx6J0N5vRyEIyuXOIVSmoYGgrKWt5BRgDsSNoRSJYBt9edFWplHM86J8aiUBfQAYX/u477jy40y2DjKmvi2g7lDOtIb1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ubZnDm9VkfZ1fTn9J9FlU7LxivOhOnPW6wUpA7pQkA=;
 b=lZU1Qn9sFAjVqkY08hC05E3lkFlWYkOzlGSh0Dmira5ml176fyHbwz9Z98gYRmQXjOiJwewU7fC0N6FwnZEATn8d1B3VKTGd6ZiwLcHWk4bgnEIVvGGjSaiyjc064yAtJFtM1XXWQHkFpyC0HjfLTrdAHMHHn6qBOIpgIczc8SPsL1m+ilcCcjB5IkMvFDX/aUX2HXszGHcPgaE67kioUmhznj5hgfUWUSjnGn1Kwd60Xeb4m8SQkJRDL9Lh1xiGLrI4KEBM1UFl95mvn3jswulVMNUiEfHKgmLM5KiNBzwaUySd5Pud5h52Azh+kTxzSBLQ+LdFB/h0sX+opzNZBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11760.eurprd04.prod.outlook.com (2603:10a6:150:2d1::6)
 by DB9PR04MB10009.eurprd04.prod.outlook.com (2603:10a6:10:4ec::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 09:56:00 +0000
Received: from GV2PR04MB11760.eurprd04.prod.outlook.com
 ([fe80::4960:3035:f3de:c0d6]) by GV2PR04MB11760.eurprd04.prod.outlook.com
 ([fe80::4960:3035:f3de:c0d6%6]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 09:56:00 +0000
Message-ID: <6774aac4-5c63-4fd4-a90e-4e8c4f3e2b85@oss.nxp.com>
Date: Tue, 9 Jun 2026 17:56:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: TZASC misconfiguration on i.mx8m
To: Richard Weinberger <richard@sigma-star.at>, sahil.malhotra@nxp.com
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, alice.guo@nxp.com,
 peng.fan@nxp.com, upstream+uboot@sigma-star.at, ye.li@nxp.com
References: <3208216.Ym5mLc6kNg@nailgun>
 <CAKxiovgS_1x4rVYN+bdXGGSBLQ87Q-ho88wSLn=eVEMQO9BG6Q@mail.gmail.com>
 <9bcf6592-e616-4b7f-9d54-83987c6a2bbb@oss.nxp.com>
 <4466851.5hrfCrGMcO@nailgun>
Content-Language: en-US
From: Ye Li <ye.li@oss.nxp.com>
In-Reply-To: <4466851.5hrfCrGMcO@nailgun>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI3PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:295::7) To GV2PR04MB11760.eurprd04.prod.outlook.com
 (2603:10a6:150:2d1::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11760:EE_|DB9PR04MB10009:EE_
X-MS-Office365-Filtering-Correlation-Id: db2cda8e-3256-4129-6fe7-08dec60d4f20
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|42112799006|19092799006|1800799024|376014|366016|6133799003|18002099003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: G0dgdzA/OXBOC2+2+uNTmjHhjxpM8dIMyOdlvEXQbESpxPcZQ9XXIa/nOMN+PzLxE7rYuche2sl38M9p0725jVJ7h0xGRVVFJoGA1LNVpECpDKWGA6+Wyipq5kyFeZYnM4wex6hKsJ9B+IhljtbkETTI9UMiT8pHWv+vu38ACsW88g/srlbFdQd8nqfDzLj+NEPKo56wfIK9wKqznXXkRJTiQdHcYZFiaZT6bAXM9H+rArvMQmHS5GIs9oS5zyPebycHeGzxE3pHYUdWdNhHXvIsKVd376oVqCXiPGb6BIbOnTzubdTtAtJRvbtiPD3nudLfui00OGyoQZdYiTGo7G5mZ4pcqzQEqhD//lghI6rw34TvfLEXemZj6LbulINzYzsiMHSEC3EUqq2Qm7WtgctdYi85mrAduxf9j+RJkfFEnbwlwdw0cRn+WUbJuyWnKvjoiu/qCvh5IAmLi+Kr9BOPqeBtfWUz2Jl1k3fX/sO9g3HgHlzrkutE8Yq2/B+rG/LiqZQpU8zQIptrIXDSmzBxaV/oBcU+z+akEZ+1L6p/MKYO6vgOkRpbBvFCZMrR5qbimfLj5Xn32+jYDyLLslkG74dp06XrgzCzv1rp2eFV3NSA/wCMOqhBP/aQal9Q7OLGtagt0WpUOv4b9S3xBJmHUnLXjXbhNRF/lUwuOWDybdGhbKDI2LqqNl59tIRb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11760.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(19092799006)(1800799024)(376014)(366016)(6133799003)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1c1R0FOZGNxaTJoWktuMVBQR3R6Z1pJeHYvaUJCRHhhUTJKRS81dnRRdmNL?=
 =?utf-8?B?eEJQaEIwcldaRk9vbGh4M3ZqSnd3QnAwckJKRVJJbXpUTE93RUtoakxkMjY4?=
 =?utf-8?B?WnZuZ0lwS01BalRzOC9LN1BaV1FTVzd0VmRBVnJrWlBQbXkyOVYrdEVpeS82?=
 =?utf-8?B?RVFWYWYrRzBqaWMvU3VKMEtRZkwwMVUrOU9aY0QwVEdtNm83SlBLRGtGaTdj?=
 =?utf-8?B?YnYyOThNVnJJcjQ4S3lXK3J2a1RPMzJmV1lwQXl3NS9pcDRNeFp2cEhURjVU?=
 =?utf-8?B?UGdUVUZmMkRNbEk1Mkx1KzltNVJYMlJVdU9RRU5wTFd3QU1DK3ZxZGdnVEUw?=
 =?utf-8?B?aURuQnYxYklZaDVzN3pPdW5Kb0wrbFEreXJkVThLVVFiSllYUjFKK2srbEtv?=
 =?utf-8?B?RGxVYlltcy90Skkvc2hOQkJFcUpzLy9CWTlZY2h2UXlQU2toVmRhNmJZVTFx?=
 =?utf-8?B?ZWVCK3UrNHJac2lHU3Bnc0xhejZBSGpLeDEvSWpuU3FtQXJ0bE1zcjJLNWNL?=
 =?utf-8?B?UTJsTjROdjBXRnNxOVBJV2ZIK0lYQWdjTk1nalNyN2plajlEUHp3YldlRlNh?=
 =?utf-8?B?QWZDMTE5bk8zZU1sSHM1ZExLK1hhcXF2YlIvVmEwdFpJcXROMVdvNHplQnFL?=
 =?utf-8?B?cFFDN3VjUmFHdVF0YlJRQm4wTG41M0Fpa1c5WTNrejV5RW9Eelp1WUkvUm9P?=
 =?utf-8?B?aWswMDB0YXJsZlFRYVN0Rnl3YUxaUHFKT1lHeWp2emlGemNUdUNaRHRQQnds?=
 =?utf-8?B?c1UxKzRaZ0pKSTI3YXZNd2RqQk80WTFvc0VkK3NZblpKLzNjdjJ2c0xkcENy?=
 =?utf-8?B?WVpTd284MnJLZndROHpsZmYyS1RDRjBHWFdzTVYvVS9VU3pwUGhzZUxsWE1m?=
 =?utf-8?B?NlNwY1Y4bktWWFp5blB4UHF1c3ZvekVuYXNMalg1QjZEWnVZcnZrT2ZmMTNz?=
 =?utf-8?B?eWQwOWlzN3NhZlJPb3JFRXJ6b3BPdFdTYVB5bDlzWG1qeHJWYytuWGNLMlRG?=
 =?utf-8?B?SERGQ2M1MCtPT1c3dHp5Q1ZmR2w0VGxxL1hwRzhYWU9kQmhpTzhEV05KbFhZ?=
 =?utf-8?B?UFpGaHBueVUwdkt1VVlmK0FuN3NLZVhqRUs0YjZIaWE1azhuUUN0ZGN5NlFV?=
 =?utf-8?B?OGtxK1N4T0lKUlZGTXNzOURxYWRLQlJ3dlJIMnQ2WFpYU25scEN1YlpqdzhC?=
 =?utf-8?B?c1RBd29qbE8yMllzQ1VYR3AzUGtiK0dUS0dBSFNtYTlBRGpwdnBGcnJTZ0ht?=
 =?utf-8?B?cGN1WktjcEU3dWVFMDRILzUrenh1eVE3SW85N2E0Uk5FdlVKZkJhUEVlWnFy?=
 =?utf-8?B?T2ZUTTg2V1pLVzhYb3h6L1V6a0F1Y3NJMTg4UGtFbEl5VUhtSFVidm5zY3pp?=
 =?utf-8?B?eXRtK3ZqK2JiaUhCVGNRb2NYT3dOTStXVkRPMkt2Mm1md201MExnbEJ2eW1p?=
 =?utf-8?B?RTlxb3hKc09PbEVQQ0pOaW11QXRDOWdaTm4vblEyWkJHWUVkcDV5SDd2MkFM?=
 =?utf-8?B?cFRwNlkwN2ZLcmluMU9wMmdiTS9jSTRSOWVrUXc1RnQxa0xaQll1WlhKRHEz?=
 =?utf-8?B?YlpqVG01NVA3UHZtbWpLNEl4WktZNGR3T0tGOVQ4eHpMd055SmZMMWp2elUy?=
 =?utf-8?B?Q3NtdUt0OTdHVHh5NFdhUzVJeDNCUWJNSC9tWGdGamM2bHFWWkJCenFyQU9S?=
 =?utf-8?B?bDU2Z1RBc3NQVERIaTYyeGptRFEwbkk0TFlDVUJyWE53OXJSckpCVHg3Vklw?=
 =?utf-8?B?U1NmeEtmYmFHQmMzTHN1Q1lUcGx1c2FPd0lhbW9GeGZRN0Z6elkvcWtyempE?=
 =?utf-8?B?MndlUnJ6ZS9Dc05DRXpDSGlDT1c2THlYRGY2d2ZscnRzQy9TRitlZmNRcTZO?=
 =?utf-8?B?eTB5REUxNldocjkveEhaRnd1OXkvdEl4aVhsNitmNVZvNE1QNTFnMTRXWVlD?=
 =?utf-8?B?bEYyN1drbXRMNFNLeWNKVDVFdG1rZWlVKythZ1JlWUUvVnA2Z3R3c2ROM2Qr?=
 =?utf-8?B?NVhuL2lldEQzanBNQkZBVE9qL3VRV1BtR2xZQWFlNkE1M2UrOWRFVVNvZzlE?=
 =?utf-8?B?OXVPTUZUdi9jMEZZV2daQVExQk9IUnRpeUdGZXNHdkpRMGo2MStRc2xabHJ0?=
 =?utf-8?B?MHA3dGVhQkdSaFhCN3JaN3FzYi9DeGNjUVBZTFdXMmgrWDFld29EVzlZbTYv?=
 =?utf-8?B?ZUZna0lOU0crSWFEM3RWd3pxc1J0K3g0T1U4MVFXZm9jRzZoTXR3cVEyRXll?=
 =?utf-8?B?TkFyUjNhY3lKa1pSR3RTUzVSUkhKNnBmTFZleFdiTkxqeWlHTUZXVlpvQVNX?=
 =?utf-8?Q?5wgsDGHfBOh96c36Zk?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db2cda8e-3256-4129-6fe7-08dec60d4f20
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 09:56:00.1748 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zq3QQnYaL++MJlCeKGJ0A59DFt+gduE2+/pcQbaCCrVQwIoPAxOeqloc+AK6Rgbl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB10009
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



On 6/9/2026 2:53 PM, Richard Weinberger wrote:
> Ye Li,
> 
> On Dienstag, 9. Juni 2026 03:44 Ye Li wrote:
>>>      We have discussed this with iMX optee owner. The fix should be done in
>>>      OPTEE not u-boot.
>>>      1. OPTEE uses secure memory, so it needs to re-confiure trustzone to
>>>      meet secure requirement not depending on SPL setting.
>>>      2. SPL also supports Non-optee case.
>>>
>>>      Best regards,
>>>      Ye Li
>>>
>>>
>>> Can you please point to this discussion?
>>
>> It is our internal discussion not on community thread. I add Sahil to
>> comment for optee. And please notice, trustzone should be enabled before
>> DDR initialization. So it should be in SPL not optee. Optee can
>> reconfigure trustzone setting.
> 
> But U-Boot right now harms the TZASC settings.
> 
> This is exactly why upstream OP-TEE has the following guard:
> commit 443c5817de47f1bd19091b419806898070382a67
> Author: Marco Felsch <m.felsch@pengutronix.de>
> Date:   Tue Jun 17 13:27:53 2025 +0200
> 
>      drivers: imx: tzc380: add support to verify region0
>      
>      There are platforms where memory aliasing can't be prevented, e.g. the
>      i.MX8M. If the previous running firmware configured region0, which
>      covers the whole AXI address space, to be accessible from secure and
>      non-secure world the OP-TEE core memory would be accessible via memory
>      aliasing.
>      
>      To prevent such attacks we need to ensure that region0 is accessible
>      from the secure world only.
>      
>      Reviewed-by: Sahil Malhotra <sahil.malhotra@nxp.com>
>      Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> 
> Upstream A-TF also used to misconfigure region0, this got fixed by:
> https://github.com/ARM-software/arm-trusted-firmware/commit/9bf148071aad597e7fe7d1080c00aeb35b67a3dd
> 
> So, why is U-Boot working *against* upstream?
> Instead of using the sledgehammer and enable normal world access to the whole
> region0, apply a more precise fix to make these USB masters work.
> I know, with downstream IMX OP-TEE it's less of a problem, because you carry this change:
> 
> commit c09d6e9da171f8c5ee42b42ff144b320761a5f16
> Author: Sahil Malhotra <sahil.malhotra@nxp.com>
> Date:   Mon Aug 4 20:08:59 2025 +0200
> 
>      LFOPTEE-468 core: plat-imx: tzc380: update TZASC configuration
>      
>      In order to prevent Memory aliasing, need to ensure that region0
>      is accessible from secure world only.
>      
>      Signed-off-by: Sahil Malhotra <sahil.malhotra@nxp.com>
> 
Why can't this optee patch apply to optee upstream? It is optee using 
secure memory, then it should be optee's responsibility to configure 
trustzone correctly. Optee can't depends on default value of trustzone, 
since trustzone is not enabled by optee.

Best regards,
Ye Li

> Thanks,
> //richard

