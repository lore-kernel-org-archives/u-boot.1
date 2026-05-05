Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92827FF885A
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 11:10:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DE5C848A7;
	Tue,  5 May 2026 13:10:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="mzUKRYJW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04252848AE; Tue,  5 May 2026 13:10:10 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E06B18489F
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 13:10:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S8JnUozC34LNcOJis2h9iIN2u8brgv3kr0zfBuvsfuvJmz0OaLoZUhDWn8gfjZjqnBTpHLTxfRjCdPejwJxS24MeCGLflnKGQDVYB6SmqQJM01RxdjF3iaY0Z5zWv0NU+tOPfh4YB3OQMMqreaqbEQqoEIpLKpp4s8UuSi37IJGK7sHd2My3MCKx29WAdyzAloD45C7X9abdBIfPUezlblgKA3ETR61TsNCfCLTM73j+/CT3v6SESSArUAgWrOu1nsvgGihuqIsVmE8WsAE1StKExGwA2PRM0mVUHPCfMYfzyhJ2rNeI7+qLfW/bGK6CdoCMGqnZp7XV3DnRXdiGgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XzGaOw5SQpfdndAhqwO0MQZCF5AJKC15cF4P/SbQ2hU=;
 b=TI+L3gRd+DuRa7ZdaxtmTAlvUNrPEKcm5HHurWAKYAgB0qplWqJdG0Qqj8ZbH3JWA/eN0QJnzaeQ4QTqdZrhD9iLfzS7UMIGQikDS5C0KJfkOAOvilbhELEA72piFvbl2PoaHpSUSivanOPX9APanHYJm0dEbihYOr/IR5IhYxY5rouH5gKbH5pqRMrYE6jjz7joRtFRO+2+TRQNMtWKDTvIAoEG6rPQZQYGN6dNPfARjjrBgC5Bv/BMRKXGYybZFvVSYY7JXII+GY1XdupJqoa/ZuMq7zO6Tk4Qk09Lcj70OYD96jfS5stDNc64pLZkSL2gQPwvXEtZ2QAp/4ecXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XzGaOw5SQpfdndAhqwO0MQZCF5AJKC15cF4P/SbQ2hU=;
 b=mzUKRYJW3rAx5DQIqF+4RM/TIMlqW8YeBgh4o90OD9MNQsLLbPlUVRSU1hZqZH6ezzftnERqtGfhq3dnBl8wJ6IhtIX1Q/FIhrZnV+/x7d3WmPDAAyFlxyFEt8FG8uxSyJPSFD8BpMx6/yrcltexNExgVuRkJXMAaxQJ7yiOiTs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by PAXPR04MB9325.eurprd04.prod.outlook.com (2603:10a6:102:2b9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 11:10:00 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 11:09:59 +0000
Message-ID: <26460fc4-7584-4d2d-8a85-86c7ce596b9d@cherry.de>
Date: Tue, 5 May 2026 13:09:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC next 15/18] kbuild: enable -Werror for hostprogs
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <simon.glass@canonical.com>, Raymond Mao
 <raymondmaoca@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Adriano Cordova <adrianox@gmail.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Yao Zi <me@ziyao.cc>, Rasmus Villemoes <ravi@prevas.dk>
References: <20260504-extrawarn-sync-v1-0-b19301d1948a@cherry.de>
 <20260504-extrawarn-sync-v1-15-b19301d1948a@cherry.de>
 <CAC_iWj+-_NvMQLPCiYJLEJ6UMwd9QQGsc=jMSgQsVE8M6BGASg@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAC_iWj+-_NvMQLPCiYJLEJ6UMwd9QQGsc=jMSgQsVE8M6BGASg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0271.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::38) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|PAXPR04MB9325:EE_
X-MS-Office365-Filtering-Correlation-Id: 517f75b4-0270-4788-1f2b-08deaa96d8f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: J+akP5VyaNf3MeB4CBqOXRXCSLciMf6D2FXOoWYZDGWAbROgKc4hs0eAHDv2+tzBF/9B95ShGPBJGBqgkl8CAvxtRnqgyQGzdjjtfJefPhy1xEOcJedwuLbGpELwsZtTc61gk7xTYJwZZdn9u1gGWFklWazwSwIgJ6D1XvNg10KMNGFXcuYlR1B+41WjBa54KjD0d/3Qw2H1ejVUa4/ekSeepUdW/4aOZ5+7Lzqkd1VVP2C/EDz9NY9jkd4YZc4zP/4goQMSE98y75pBI7yDsF1ZORf6ZUW4FZXpXrMHtjssK0+nK8uX3W1a+Tvwjjag17nAu/UJMscsvENhjCcAHAuMbtCMd7ZmpTHu9hgnzxN6ww/Z6SH4xBDE9SFsJpsVYuvahxqwb3FnCTsqOVHWxDaHCYYSGcdmoBb6h4H+D9/Ehh9vFQWaTiwM/rVDlSwPsgUTDwx4bY4VUEAHPE1achULlIKrqOpFXetBVEhqSrSFhFciwFXn1i4C2XMH7kTOq1UlaO923TqZiAuHGdRIiH/jezKHD6H/wmXgXb7vzZeQI8d25EcBxWL+xBE2hm3pRudMzwA0ZHm0JFnQ5aSY8bgfS95i5qqO/Te749UR5ElnRHLycYwiQwYO/PRK0wUkb5bs1ZqkBL99o7+GnDz5L7rjBc9shekGgKql+QP9TGDVaFXpMJpAmTNRv6zAudnQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2dWOHZBSTBxYnQ5RTRTTzBBSmhUaWwxK1h2Q0k3Y1k3UXRYUHYyRUxoVTBi?=
 =?utf-8?B?RGIvYlpWNTdRK1E1d3YySDFKelpqbFVLYjI5WTdDY2FYZ29zTnBCaVFHYUlT?=
 =?utf-8?B?R2ROOFJBRFl5K2ppQURaR2VHa0NaLy9nMFFWWVFKQVFMQXRwYkZlcm5LZVFr?=
 =?utf-8?B?bmx1N3FacG82amZVWjVOMmg4Sm9ZaW94SGY1SndaSjl5Ukp4RjJkVXhpQVU1?=
 =?utf-8?B?TXFPNGFpaEFwMXhwT0tjUnZnaUtNTE5CTVhIRHNLazZyd1gvcWtON1lweFhM?=
 =?utf-8?B?alpwb3FNY3dCUFU3bHFZVVRKYjhSL2l0eVJMZy9nTWYwYU8xTEd1NXNxUkpF?=
 =?utf-8?B?ZDFySjJ2VjlodHBQSjBQaTFMK0dTMkEwVGhIdXZRTDhLNzdBdlRLS0dlMzNm?=
 =?utf-8?B?eDRaWGg1VEtXTG44VkxSU2RRMkdrKzZ5RTlaU1hGSlFzTVB2d1I0MDgxUUFt?=
 =?utf-8?B?RWNTTEZFQzFCRXYwR1lIV3lCdzhUeVFNc3NreG9UN1Y4LzZYUFZZMU4vQk4z?=
 =?utf-8?B?dmk4NFdUWnNBdVdXbWhBTHFXSGdoVU5OZUVndjZ6K3J6M216NGVydUVCK0lp?=
 =?utf-8?B?Q2pSaHFwUGVrRWhmczhQVzNiL29UVFMzU2ZSS0tubmtsWDNFbWRHcysrVEE4?=
 =?utf-8?B?R1NSb0JtdExWYWJjYTF4YVNsNzFHMjVaWHJaekltQ0hPT25KdEwzWWMvNGFN?=
 =?utf-8?B?Y2hvSkphRURxNnlLa1BlZXVVeGQ2VGk4a1IzNVpOM3cyMzQ0Yi80ZWdSQmU2?=
 =?utf-8?B?R21xYkZrOVc3bXY1K3YxcWs0VEQrUjZFbkVUWXp2UjNWUVZ1eU9CZndHMXZl?=
 =?utf-8?B?VlM4V28yWXpXZjJzT0F1RHMvSk1pVEs2V0tDQ1FBMVU0U2lSbjZHVW1GL05j?=
 =?utf-8?B?NWhIakIzTk5CNWYyRmlaUHNtMTFIbFpWTEZubHYzTklWdnJ0ZXBsS0FPTFVU?=
 =?utf-8?B?OEozL2pwbkhhK1NJenA5NDVNQ0hJOHNsQ3c0RkpMNkZQUGtneEQ2L0RZL1JC?=
 =?utf-8?B?UUNWVGMxUElTYzRoQzRIeGh6Z2tWSVFqUllGb1Nmd0tUNmpwZkZkUFJSOEdT?=
 =?utf-8?B?RTRJMzlnOWhzUURlNkRuVXVJVmFtTnF3TEpLT3NLcVIvZFdZaDJZMzhZNnNB?=
 =?utf-8?B?U0N6Y2Fqd3VBaHVVc2I3NUp6elIxUElQajB0S0JPSGdOdzdOTGJ3cHdoejBZ?=
 =?utf-8?B?ZURMd1JxR2d1SDl4MDJoWW9hN2NGdnRad29jOWNkWHBFQW54R2dYbjV0Y3du?=
 =?utf-8?B?RjhsOEpsbjltSGFLOTR6WU90VmgxS0tBRDhSY25BUmR3TG52STFmaUJmMUF3?=
 =?utf-8?B?eVd2Yi9HdzFxeHpPWjJmaUlwR2FlTGVrbDd3ODJWYUcvbDBZT0JuL09kMkZa?=
 =?utf-8?B?VkVmc0VqS2hpK2kyVFlrbDJJckRGV3FvV2FXU0hPMzdSckpqLzREdDJlNlJi?=
 =?utf-8?B?bWcrckVla1hrNFJSSjU5SUFTTVgvYjBZaW94a3pVUEZsTVFtZ1Z2d1dlSTJw?=
 =?utf-8?B?SUxBb3d1TGQ5MUFXdGlRdzdHZWt0K0hFTUNNNHhjaWw0VkxFNjNwWHJKR2xy?=
 =?utf-8?B?aDJnS0hKK2svZlB6SmlWOTBqQmQvTHMrTEY4U29sWVRyVGtUeHhUZEc0TmRo?=
 =?utf-8?B?Tmxscy9tSmhZVThibUhyQ3ZIb1hHT2IwUDdkU1V2anFJVUF0SGFhOW5qMzBy?=
 =?utf-8?B?bUwwV2JqS0huKzV0RnJvZ1FuL1Z3WlBGVW5maWtvTU83WHkvOW5pUXdBK0kw?=
 =?utf-8?B?UVg0T2ZlRTV6Q0FCbW5NMWhKRU1wTXFzZmdXTnhRVm8xcmt4Y0pJTDEvZmZm?=
 =?utf-8?B?VDJNZExTcEdRWXpuV0w2ZktFd25mYWY0ek92UjM3aXdyVnZ2bCtrVFF2Q1R4?=
 =?utf-8?B?dm80SFBkbTVHWHdNNDRFcDhrZWtmRzR1NnlDUDAydGx5SkVrWE9JQlBwL0w5?=
 =?utf-8?B?cGhIOTdOKzlpc0hTWEQyYTJNampGWVdkOWVpeUswNVFLSWR0RWZqNTRZWDRI?=
 =?utf-8?B?Y3ZFajhIZm5yYWU0ODhNaGJ4dVV5dTVjYzRGK1NSMCtBcjQvcWNuRjM1NTh2?=
 =?utf-8?B?WjRIUWM5emhwZ2pnc1dCclFZYnFTbUdBZVI2OTAvaHVLK0RnYkk2NG84bzl2?=
 =?utf-8?B?NDRXVEFUU0NCN0RGS2xIMVpYaXcxT1g2TE5TVXRFOGx1allWMVQ0Z1JkTm0z?=
 =?utf-8?B?MERMRTZRUHdzYXc2cDhVaFN0eE56aldSaXJCTFZjOEdkbHA1cjRiVVJWd015?=
 =?utf-8?B?eWp4STdtSzhTUXFwWk9yd1ExNzNZcTFHYVNaTTFEbkdud3IyQWNIU09ESGgv?=
 =?utf-8?B?YjhEcW0zdi9HZU1PaGxSY1EreGJ2WE55S3NObklHeXJkc090cmtVQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 517f75b4-0270-4788-1f2b-08deaa96d8f2
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 11:09:59.5727 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CpQIPOBjwCJ4hhJoh+KCQxugWVS6g269U/iMF1mqFKUApjdgewTDC6rNxw5KhjpHSNaDV++OwQT5UWGAaGQJj/0NUxsdkHf7GtmP8EgoBwI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9325
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

Hi Ilias,

On 5/5/26 7:51 AM, Ilias Apalodimas wrote:
> On Mon, 4 May 2026 at 16:20, Quentin Schulz <foss+uboot@0leil.net> wrote:
>>
>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> [ Upstream commit 27758d8c2583d10472b745a43ff86fef96c11ef7 ]
>>
>> Original commit log:
>>
>>    The hostprog compilers and linkers do not share the regular compiler flags,
>>    so they are not affected by CONFIG_WERROR or W=e. As hostprogs are used
>>    during the bootstrap of the build, they can't depend on kconfig options.
>>
>>    Enable -Werror unconditionally.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>> ---
> 
> Doesn't the next patch reverts this? I think you can squash them in a
> single patch
> 

No, the next patch will guard the code but before this patch it was 
simply never applied so it's not a no-op.

I decided to backport them separately even if this patch here isn't 
great and modified right after, so that we preserve a similar history to 
the Linux kernel's.

I can squash them if really desired, but I like not messing too much 
when backporting patches.

Cheers,
Quentin
