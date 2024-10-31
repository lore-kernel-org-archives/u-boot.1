Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B8DFE68973
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 10:26:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94E78891DD;
	Thu, 31 Oct 2024 11:26:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="ewYklqZa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FAC98924F; Thu, 31 Oct 2024 11:26:08 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::62b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9530C891A9
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 11:26:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ms42K2hEwymsPVsyuYcIHpxadFXXzkDI5M9gvTtjr/aHqx6TEtfccT4qIu+FB6TrNpNwxzVU2NcOmjHRdFSN25ovXfxm8WWPciMyPDZBVsSuk4Z+5ox5sWuBvvMA/4EkUysuQuG3Qm1RfV83Smv6ZJ2yEdtG1n9/pWZSwacZp92nlNRGLBSfDxzqXoBuntkNSXbvBdeB1o1y5qBhPZfWLgqU43+GCkpU6TS3JZPfwuLGslJjLyCleGee6w4C15lOHxkLJiILhTOPKlp4EU0vNfCsnGr+F1Daqe78MX4mti2+iC+wbqJBa4pp8MaslwNB6y1igk/uf3SVguzA/wThHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a31tV22AqMGOQgH2/3agiWCCHsPFs14pZbtjbygsX58=;
 b=KQB+98eavhBoMaKVFj21LZnChJ/KL1PN7K1kBaasybH0uVDqIHxT7yA8mKbNQ5mModH59TJPrCc108wWpSaDeBOfWm4pgqkc5xg0T76yhMZSxVDbTgExUcFJzfVVkA0nu3BsV297ZT1/3V+USjtmtFobCMm63JGorxzfOAoYY+HO1AX47XF3vVy5ouIth18dFCCxWNRazoryz0QBLdul+W3iqelHaY9WgSjweaDZh8LGnIxqyuAQaRq4tDbCE6pHzP2Uta+Ik/z9Ukoe4aXbO5lJ6KgYzRmub8n2BGaA157m5Vr3naEBaCS/oneqq3ndfGOBxAKdWlPYmELP8hKsyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a31tV22AqMGOQgH2/3agiWCCHsPFs14pZbtjbygsX58=;
 b=ewYklqZagZYcOQd4m1FeVe0i//i3OmLwg3YEDMj92CNaI0fRyy0cqCMBnPKqS4S4vyliVuiIBbFUpyxDpzimOaY5DNKmVAyZpWBpCz0XfCqPCmCfHB+VGnMDC+KvFaiDwX8sI/Qh0b08oLGMfI0hWrrvP+WtFMj9i5cd+ixSjlk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS1PR04MB9560.eurprd04.prod.outlook.com (2603:10a6:20b:470::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Thu, 31 Oct
 2024 10:26:03 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8093.027; Thu, 31 Oct 2024
 10:26:03 +0000
Message-ID: <b14fbd0d-55b9-4e4c-a8c1-e04b989efd67@cherry.de>
Date: Thu, 31 Oct 2024 11:26:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] rockchip: add support for Radxa ROCK 5A with SPI
 NOR flash module
To: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 jonas@kwiboo.se, sumit.garg@linaro.org
References: <20240824223343.98577-1-naoki@radxa.com>
 <20240824223343.98577-2-naoki@radxa.com>
 <A486B5CC87D82BA9+a72f088c-d1ac-442a-86d5-9e1611492000@radxa.com>
 <9cbadcce-3e12-45ba-95f3-a35e29f4dd88@cherry.de>
 <C69FC67529AFD2FD+b0c7fa4d-e4a2-4117-a320-bc8b1a313afa@radxa.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <C69FC67529AFD2FD+b0c7fa4d-e4a2-4117-a320-bc8b1a313afa@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0005.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::15) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS1PR04MB9560:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e80cc58-0fb4-4d94-6e8a-08dcf9966bba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TzUxaHhPZlRic2o2MUM2UHhKbVhtbC9uRlRjSExoVjVJK3hmblhvQjJjYnJX?=
 =?utf-8?B?UU94QUpyaml1RGxYLzZSRFZiSmNNekxjbVhxRzkxcjl6KzNpV0c3czBEMnh3?=
 =?utf-8?B?RytRR1FiNFVpTVJ0Z1RCalp5cVFNUGgxdmh3WVRVdVhEU09TS01heG1FcmQ4?=
 =?utf-8?B?ejBKclAwcDhSL3dBaWwxc0lha2lyUXRhemxVOXNtOFBhNnVvSTdWenkyZU1p?=
 =?utf-8?B?YUFIZU5qT2k5MStxOXZObFNiYjBJTnFkWE5HZGJmeTdXa3FidVpWWTJzY1VB?=
 =?utf-8?B?QVN3N3lyTlF3dVJ6bE1pbjIvNHlXRWNWQWVBWmVGRmFybUkwYklHUXRuRnRz?=
 =?utf-8?B?UkIwZThCSzU4SUM0Z3YxVk93ZE50S1dZZmZ6NXNnT1lndnpjanF2cC9ZTUNs?=
 =?utf-8?B?cFZUbHVHUHpINmJiN3dJdE0rUGRDSzJ6V0JBWEZXcTVJbXFiMzhWdDErKzZB?=
 =?utf-8?B?YXlaZzRmRzBqcDBQSnhpVHdUdU15bkZRR0tLNnAvcVlWdkRLK0tZQjJlOTJ4?=
 =?utf-8?B?cEtIWE8zVW1WUGJNZlJHSnVmbUxseHdLUzBzMkh6SHBKZE8wTUJidC9rYXli?=
 =?utf-8?B?UFZLZnZvQmxBb3E3bnJveTBKRVJnMGZzb1gvV1hNM3dpUXhWa2RLRGduTnZD?=
 =?utf-8?B?RW96R3dUTXEvNm5yM3NiSGdtMVFIanBFNGVMcmpVdENXZ0U3cWYyd1JVTUNa?=
 =?utf-8?B?dHRrS1dkRzFlRW1JYVVBVUc5VFNaU1IvMVYxbkFMNTE0SlRweWM4VGdRRnZS?=
 =?utf-8?B?L2hQTnFjUG43cUkxb0JIYXhRMFNTaFozUU8zZ3RxWjhiTlQ0VnllRDBCZzdm?=
 =?utf-8?B?V0s3anNyZHhxaWNwc2V6ejRSdDk1Q2MrbTZJT25vZTFWME01ekpRT3JkVmZs?=
 =?utf-8?B?eFdqRUJyY3E3WXc1MEV0ZU44U2E5TDNFY21jMmxVYUI2S3ZkdCt3aTdGZzNM?=
 =?utf-8?B?WW5sc09kdDYrSTZHK0l6Q2YwTXozUEZPbWx2N0IyNk9YSGRXWWFiSG5Cb1pF?=
 =?utf-8?B?ckV0NG5NcE5VREd6SktuaDVmZTBoMkZoVnR5d29uQjhUeGtpS3NRZWdWcFFs?=
 =?utf-8?B?UThiNnNJZmkwaWluMHJScGI0eU12VU85NjJRdGVVdnJSaGhVYUQySTVITm5I?=
 =?utf-8?B?QXRQQlFTc0hFY1czaUs2SXJJbW9vbER6cm03UU5UUmVEMGZZVkozSldvYmhu?=
 =?utf-8?B?YjA1OWV1OGltZmVENm5FOXhRclk1aGJ5Yi8yajB3K0wza3hoRmNjcHVYY0RR?=
 =?utf-8?B?ZXB4RFBJaUkvM21Xb0IrYUNLbUpiUFNlRjNlL21wQldML0ZEdTNIZE5VTjVa?=
 =?utf-8?B?Wi9XaXUvTFRsY2pBWlFlTndLQWlGT0VHTUY2SkEzbzhuR0hIVVRrekxtT0xK?=
 =?utf-8?B?eXdlNkhhMk1wVVlTb2FkVmZRKzFjOXJZZjNOUFJYUWFMdlZaQm5GQnF1azM1?=
 =?utf-8?B?RFRTMEVUVEk1ZGZVRnJGbkJqMmlkMUNaWE0zZjJPVUV5bXlaaUUwOUdRby9L?=
 =?utf-8?B?cVhxNHYwd2FCQzczYUFTaGd6WEV3a2ltMUdGRzZISldBUFBvODFwLzhOZjBD?=
 =?utf-8?B?Z1NFVVpVTGlZLzNWOE84T0FzZjBTNEduNEkwOWRJK2JHSytPUE5jUDkxZ1Av?=
 =?utf-8?B?MXBnUXRpNXZrSmMwY2QwYmdTOWdHbjFyNFY2OVVEeGQvTk1SUlMzSGUrSlNB?=
 =?utf-8?Q?mGYSz8drg1+UzELt5JfX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUp4ZTlxYzJkZEQ5SS94dUtzRTBIY3QvRWd5RG1SU1FZY3EzYW15T1VrM1F4?=
 =?utf-8?B?NG9ZVlFLc0xxdHhwUnBHNVp6TXUweU9qRHN0Z1gxRi9aelBiQ3dGV0ticnlu?=
 =?utf-8?B?bk0vcXA0ZHJ2UUlGZCs3aVQ1VjZ2S25aS1J2YUp4YlBpNklaSWtwc0xvK0th?=
 =?utf-8?B?VVIwaXh5dlNOcWdlV3VubTg1WTY4TGQzV2EvdWtjRVRTdXpkRDFoeXV5dEtV?=
 =?utf-8?B?OE1pMDNxaWJGdW1vWlNETVZUb1Q4YUhaNit1T2dqYnpGVy84ZHhFTzNQSjc1?=
 =?utf-8?B?WjZ2NmJJb3NnYjdDTk9BSVpERzlIVU1CVnViaVdMREtNNlVwb2x3NWhKNU4v?=
 =?utf-8?B?RzY3VXVVRVhRaHljV0xCRU5HVWw4L0hQbVdybUVPNGxaSVJLbE5YNXR1Mjk3?=
 =?utf-8?B?dWFCTFBMVzhMWXI0OXRUVDFNOERRRnZtY29vYWVHQWJPSFZ5ajhQdmpZV1M1?=
 =?utf-8?B?L09Kc1FtdTZXTzI4RFY5VG15U29JRW5XWW1sNklOMlFkQjU2NFZxM1k2Zk8w?=
 =?utf-8?B?eEw3RFNsQnZxbThaQWpCTTI4MnFhSThLRzVGSnZTMjJDMlZPWFA1cWx2d0s5?=
 =?utf-8?B?eXRMT2JQK1l2cUpOTXVpS1FJMHZjMHFmWlcxVkxpaUhQT1hxT3laZDRXcCtN?=
 =?utf-8?B?Vmtma1d0Z3YvWTZ1U2k1MERWNkU3MlVmb3hsby9aSitCbHJ3WlIyekNvU083?=
 =?utf-8?B?Ym1lK3IvWGVKeFowSExITEdmNXdpZDdvQktvUjErbFhhcmxlUGwraHBxMEhC?=
 =?utf-8?B?UVJYTmdYTXNTUlR3cHJNamtPdS9HR2pxSmlwZ215bmZOZ2dGUVpudFZHVXZK?=
 =?utf-8?B?d2FoUUpZZjRsWnB0bDBuUlBXZ21JaWdMSFhMT1JSLzB2TmhxRHdQMWFhSklz?=
 =?utf-8?B?dWt2bmQyRktqSjlZMUNUV1lOZ2hnVkRwSWxWbnk3R3E5dU9TdlpDa1YrWWhx?=
 =?utf-8?B?cm1JQVdHT2ZXN1ZMVHExZGpTTk1tekF2SUtIbjFleU5NeVhXUGR2SytydmZu?=
 =?utf-8?B?WEZaWkExb2VIM3NSZ1I5UVZLSHVtbm8vaklsVTZLejVqWENqaGR0UU9ZUHA5?=
 =?utf-8?B?eWM4REplS1c3ZGRNTUJFOHpnOVM4UVNla2Zyc0lCVnk1MURTZCtXbkY3MEZU?=
 =?utf-8?B?bWYwUXd0aElWTUNMOEZtTTlrelJCNjVxYTlqUCtEYW4vc1M3d1Z3YXVTZFpq?=
 =?utf-8?B?eFVCdGF3N2pkU0ZhMFJycGxxSjcrQml2RUFoNmErS0gwMys4RGR6UjVwZjRM?=
 =?utf-8?B?UHhES2daTS90QkFKajlnWjFiUGoyQjRDSHh2emVUR3hZMG9UanFBTXpWc3ZD?=
 =?utf-8?B?YmhvTllnOGtSdkF1eEhSd1JPL1F1MEVYc3dEd1R1ekQ0RXZWb2ZiMU1wL2FW?=
 =?utf-8?B?NU9NYWNQMzg0dStEQ29iTUwyUXZ4NW9haUJDMTRmRk5pOFkrZmIvSzhyTnJH?=
 =?utf-8?B?elRybDlMM3ZaVlJldFFYUEVrTUVpUDg2OUQ1RWZaVmxYcUt2dmo0Z09wam4z?=
 =?utf-8?B?QUNQb1Z0bDU3c21hSjMxekttcStIaHhUTFFseGZ1dmw3UXRpTEZkL2Y1Rmdh?=
 =?utf-8?B?ZmFEcGpqeS9WWHNRTW01a3B1bTM5N2oxRXVnckdjS3M4RXFCb1RzNjFGMWVT?=
 =?utf-8?B?MGdKbVYvZENXNkZFckhJd0E2cy9BUm1iOWl4NWRXeGdGMmtmKzFObGR3VURD?=
 =?utf-8?B?R2NzQ1ZXOFZTUHZtVnlGUkRneWdBV2RCeTlwWkx3ZzljUENjMWJiNTdMblFD?=
 =?utf-8?B?SFdidm02ODhIL0dxZ1kzOEt3RTEvbWIybjh6LzArMjZzMVVoV1plL0orclpj?=
 =?utf-8?B?SzNoVGFzcmxwSDgrUmFVRXZZWHJLZDhSN3k0K1Y4NmJidWNDSGE2cktlakZM?=
 =?utf-8?B?U0xIM0ZxdFFtamNrRjN5YWhoRnN0Y0orTDRndng3Q1cyemFveGFpK0J4Z2VO?=
 =?utf-8?B?eGlBazJubHpxQXU2eENrYzVwbnYxUjU5S01PNHh2eFJndWpxbzhkaE9jeU1O?=
 =?utf-8?B?ckFBamlyNEdSdUROSUl5K0hCbk9WdEg3Znl2ek0wYVlwdG95ZXdMMUlrdXZh?=
 =?utf-8?B?RFdIdFhRRlJPK1UxQUtEaXZTZUNYT0piSUVGNFRXbmlqcjdlUnhSRnZTYXFr?=
 =?utf-8?B?UFU5ZlVDdUtvWkc5c29nV08zYmh5UnJUUlJoRGtNNlFyNDM0MThITmZuaXl1?=
 =?utf-8?B?VXc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e80cc58-0fb4-4d94-6e8a-08dcf9966bba
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 10:26:03.0054 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5GFek0ttXW2GOocKj8L/GmsL8kDFSoaLm5qr6v+YmYK6fdx6WQ6gfU/JmQ4tGhKrnErspoavmyiG6DnqftsNkSOQJGPeyXSO3XT9/mn1Skk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9560
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

Hi Naoki,

On 10/30/24 11:22 PM, FUKAUMI Naoki wrote:
> Hi,
> 
> On 10/30/24 19:39, Quentin Schulz wrote:
>> Hi Naoki,
>>
>> On 10/30/24 4:09 AM, FUKAUMI Naoki wrote:
>>> Hi,
>>>
>>> could you review this patch, anyone?
>>>
>>> Best regards,
>>>
>>> -- 
>>> FUKAUMI Naoki
>>> Radxa Computer (Shenzhen) Co., Ltd.
>>>
>>> On 8/25/24 07:33, FUKAUMI Naoki wrote:
>>>> on Radxa ROCK 5A, sdhci(eMMC) and fspim0(SPI NOR flash) share pins
>>>> (i.e. eMMC and SPI NOR flash are exclusive), new defconfig and dts
>>>> specifically for SPI NOR flash is required.
>>>>
>>>> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
>>>> ---
>>>> Changes in v2
>>>> - fix subject
>>>> ---
>>>>   arch/arm/dts/rk3588s-rock-5a-spi-u-boot.dtsi | 24 ++++++
>>>>   arch/arm/dts/rk3588s-rock-5a-spi.dts         |  4 +
>>>>   board/radxa/rock5a-rk3588s/MAINTAINERS       |  5 +-
>>>>   configs/rock5a-spi-rk3588s_defconfig         | 83 ++++++++++++++++ 
>>>> ++++
>>>>   4 files changed, 113 insertions(+), 3 deletions(-)
>>>>   create mode 100644 arch/arm/dts/rk3588s-rock-5a-spi-u-boot.dtsi
>>>>   create mode 100644 arch/arm/dts/rk3588s-rock-5a-spi.dts
>>>>   create mode 100644 configs/rock5a-spi-rk3588s_defconfig
>>>>
>>>> diff --git a/arch/arm/dts/rk3588s-rock-5a-spi-u-boot.dtsi b/arch/ 
>>>> arm/ dts/rk3588s-rock-5a-spi-u-boot.dtsi
>>>> new file mode 100644
>>>> index 00000000000..5cd131d3cb1
>>>> --- /dev/null
>>>> +++ b/arch/arm/dts/rk3588s-rock-5a-spi-u-boot.dtsi
>>>> @@ -0,0 +1,24 @@
>>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>>> +/*
>>>> + * Copyright (c) 2023 Collabora Ltd.
>>>> + */
>>>> +
>>>> +#include "rk3588s-u-boot.dtsi"
>>>> +
>>>> +&fspim0_pins {
>>>> +    bootph-pre-ram;
>>>> +    bootph-some-ram;
>>>> +};
>>>> +
>>>> +&sdhci {
>>>> +    status = "disabled";
>>>> +};
>>>> +
>>>> +&sfc {
>>>> +    status = "okay";
>>>> +
>>>> +    flash@0 {
>>>> +        bootph-pre-ram;
>>>> +        bootph-some-ram;
>>>> +    };
>>>> +};
>>
>> I assume the board can only be fitted with an SPI NOR or an eMMC and 
>> not both at the same time? If that's the case, then the status = 
>> disabled and status = okay should be in the dts. I assume we want this 
>> to be in the Linux kernel first too, either as a separate DTS or with 
>> a DTSO (not sure what they will want).
> 
> maybe it's time to update this patch.
> 
> https://eur02.safelinks.protection.outlook.com/? 
> url=https%3A%2F%2Fpatchwork.kernel.org%2Fproject%2Flinux- 
> rockchip%2Fpatch%2F20230913064505.77393-2- 
> naoki%40radxa.com%2F&data=05%7C02%7Cquentin.schulz%40cherry.de%7Cf853dffb859d43c4309f08dcf9315af8%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C638659237600855259%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=S1k4mVpoTXIf2S4npvbQCoUWTgNWdWae2ELb7PvEwQI%3D&reserved=0
> 
> rock-5a-base.dtsi (common part)
> rock-5a.dts (same as current one)
> rock-5a-spi-dts
> 

Nice, we'll need a cherry-pick for those whenever they land in 
https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git 
(doesn't seem to be the case right now though...).

THen a -u-boot.dtsi per variant (rock-5a.dts and rock-5a-spi.dts).

>>>> diff --git a/arch/arm/dts/rk3588s-rock-5a-spi.dts b/arch/arm/dts/ 
>>>> rk3588s-rock-5a-spi.dts
>>>> new file mode 100644
>>>> index 00000000000..780e90d041b
>>>> --- /dev/null
>>>> +++ b/arch/arm/dts/rk3588s-rock-5a-spi.dts
>>>> @@ -0,0 +1,4 @@
>>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>>> +
>>>> +/dts-v1/;
>>>> +#include "rk3588s-rock-5a.dts"
>>>> diff --git a/board/radxa/rock5a-rk3588s/MAINTAINERS b/board/radxa/ 
>>>> rock5a-rk3588s/MAINTAINERS
>>>> index a569efa74e3..06ebc9829f4 100644
>>>> --- a/board/radxa/rock5a-rk3588s/MAINTAINERS
>>>> +++ b/board/radxa/rock5a-rk3588s/MAINTAINERS
>>>> @@ -4,6 +4,5 @@ R:    Jonas Karlman <jonas@kwiboo.se>
>>>>   S:    Maintained
>>>>   F:    board/radxa/rock5a-rk3588s
>>>>   F:    include/configs/rock5a-rk3588s.h
>>>> -F:    configs/rock5a-rk3588s_defconfig
>>>> -F:    arch/arm/dts/rk3588s-rock-5a.dts
>>>> -F:    arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi
>>>> +F:    configs/rock5a*
>>>> +F:    arch/arm/dts/rk3588s-rock-5a*
>>>> diff --git a/configs/rock5a-spi-rk3588s_defconfig b/configs/rock5a- 
>>>> spi-rk3588s_defconfig
>>>> new file mode 100644
>>>> index 00000000000..297278c7a06
>>>> --- /dev/null
>>>> +++ b/configs/rock5a-spi-rk3588s_defconfig
>>
>> If Radxa starts having many such options, maybe it won't make a lot of 
>> sense to duplicate configs but rather have config fragments to change 
>> the default DT and add a few symbols that differ from the base (I 
>> assume we may have something similar needed for rock 5b+ compared to 
>> rock5b for example?
> 
> I'm thinking doing same for ROCK 5C...
> 
> https://eur02.safelinks.protection.outlook.com/? 
> url=https%3A%2F%2Fgithub.com%2FRadxaNaoki%2Fu- 
> boot%2Fcommits%2Frock-5c%2F&data=05%7C02%7Cquentin.schulz%40cherry.de%7Cf853dffb859d43c4309f08dcf9315af8%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C638659237600880322%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=R7VN8bJSvmKT14QQDYFbGmymxh5vsxzKLE3lEIwFCOw%3D&reserved=0
> 
>> Keeping all configs in sync for essentially same board with small 
>> differences may be difficult, maybe using config fragments will help?
> 
> any "config fragments" doc/example?
> 

https://docs.u-boot.org/en/latest/board/phytec/phycore-am64x.html

3.1.1

for how to use it.

I don't know how would one generate it. But if you figure it out, it's 
probably worth adding to the docs ;)

Cheers,
Quentin
