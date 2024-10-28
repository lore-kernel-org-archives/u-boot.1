Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01EC3D13570
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 06:12:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DF3788FE8;
	Mon, 28 Oct 2024 07:12:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="eIFG+JNL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A0B488FE3; Mon, 28 Oct 2024 07:12:53 +0100 (CET)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::621])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CBF4885F5
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 07:12:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ywc4usap4RHNw8ZXq6bL7gag23N0FJUwDkAMB4L4b8g9VhrVaCPuJsIoach+lQotojSEqJZQRNHaxP2BPdxN2b1x2+dVMhb0g5lw5VuClZ9zK9XPk0gyL+A9ZV8bjPvECiOd9Xzn5pV/5tFnmcuDuQfBDAE2o6tKk3rdYx04pUPtTCf4xZqtIzMUo8FiGLCKgzr6R1EbEH299DH4bstabm2uEOrhvg4Gnv1aGR7Wc53jTJTb1JCBzhMcqsK0O+M/yfPIilPAh0xoKDrEEoYFEEXJ1iVpXBB8qomUoJ8gX9la8h4N1ODPRyAp2BCHV3XXyE1qEY0XDBvbi0vuE0ysxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p2Xc6xBcPSRo6fgEy7PPRO35CZMcHDagPlf0qPU9nNs=;
 b=JC+mmZaLjcDYJUw8ReGP/aB3nLZKSJC2BRzr0JlUt/BQpc7ZH8qPv7snoxDyOnQjlyoP2WFMLxaJVg3sAodNRnyZanuzRRnFkgDD9mKgcxmcuw36TqpgbrDsq9+ogEok2+sceNv0MpXoLhyI5Sqv5ACaoHo25SoR+6MlCtZPim4Op6SjTz60iFvx3F4QySC5bNftQSCpeYp3lTFNROADxVx9kavI6CIqW5xDlajl6ZYveAuxAlr92bg673aIKXDTv9j+8JDhRRRcw8maMbgH1VohS9+eATvJP3Qp1DJkaUGL7noCP5hw0HXqbCyM21EDkq7AZJnVDREaWeEwD7Vo0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2Xc6xBcPSRo6fgEy7PPRO35CZMcHDagPlf0qPU9nNs=;
 b=eIFG+JNLcuxpv65toXsvHoi1pA4S50PvQ5iPtWtYIO25jvyXYYqgmc28k3ooeNhQTlZWUW0l+z83hsOeGybjTxE+0YAxb6dagmuvaa0mlWFAhjRAtguVv274/V3Mu677ey1QfHBzNoYGfB0DK9QFYKq4BnL+1cjHCUSVvigCjS0J9qzX/DVBWCzJF4CD8DgCb81GmLhwNLIrZ0YMTspoPM0WUKNZuyYD8wJZoEdwywsz1P5oN4EL67AxPRHk9h24qXN33E6zVjprjpy6wy+dB/e8rRfZOunlRX0lNA3MqkUxbBHduy/Gg7qPJs7hFQWmL3uqEaSNQ/MtR2fHuoultQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB6165.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:38a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Mon, 28 Oct
 2024 06:12:47 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8114.007; Mon, 28 Oct 2024
 06:12:47 +0000
Message-ID: <ff2c2611-e650-40cb-86aa-275a930fcf87@siemens.com>
Date: Mon, 28 Oct 2024 07:12:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/13] smbios: Fill UUID from sysinfo when available
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bryan Brattlof <bb@ti.com>,
 Nishanth Menon <nm@ti.com>
References: <cover.1729577070.git.jan.kiszka@siemens.com>
 <9e440edc2a6bdcb7d768d277dd6afb02ab941ecd.1729577070.git.jan.kiszka@siemens.com>
 <20241025010854.GX4959@bill-the-cat>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20241025010854.GX4959@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0197.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB6165:EE_
X-MS-Office365-Filtering-Correlation-Id: 12301971-b2cb-4be2-3c20-08dcf7178b87
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OEx3aGFUOGZWUjJHT3VMRnY2UkRuMXBFZTRycm1QWlZUSEtweEdMc3lNb05w?=
 =?utf-8?B?OWJSRHBJYW9hN2FRMkV6dy9Tc1lIWml4Tnhkcyt0RGU1Nzllc2J4S00rWFc2?=
 =?utf-8?B?ajRIUlUwZE1JRldyQjVNUlh3T3N2VldSa3BBZXZkYmtNdXhlbFVlU0tXOUs4?=
 =?utf-8?B?TStoMFg4MVJhNnQ4MlYzTkxzOFU3b1hrWjNoQVVJelZWejRkQVZjUkIzZm5a?=
 =?utf-8?B?cTdzRWhDcnFJRlhKcFlmaUZsdThna04wOHB2T3BScXljUDBWUTFScW1wYzdj?=
 =?utf-8?B?bmFWdGs1S01GeVp6RWh1NVY5RXh0Z0lHNVZyeG05SGZsdnBNZlVNcU44Y2lj?=
 =?utf-8?B?STQ3VWZpTkc5dXhLMmVaeXhldjkrWU0rZ1ROYm9QWXk2VmlUM21sbHdPZzU5?=
 =?utf-8?B?WU5MSDlrVVE0akVQTFViL1Q3dnNZd2tXNDFpZnU3d1BLdzRkMVdWcUxFMnhV?=
 =?utf-8?B?aFphY213SzM0Sm9CRHA0bDBnQ0JoT2FaQjJHK0JPV2RZN1dsaHA4UWpLUUM3?=
 =?utf-8?B?ZDVSY0NLZDJHd0tUS2JseG5SelhiYm1sQTJIS0FiQmpUR1VmUGRBOXMyYlM1?=
 =?utf-8?B?OVRHOGxjV011a2MyUnVBalppRlNvYWsrK2lNVDQrSzU4WU5ocEVFbEJaMjFI?=
 =?utf-8?B?N01jT0pFeGNidjl1OUFnK3RIWjRKOS9hWUJPcGJUMXJDU1Y0TEU1NHRLY3lk?=
 =?utf-8?B?M1pURnlkUHBGelRCVURCcmlYdXNjS2VYU3NKWk5ITkl6ajFXOVk5dm02MnJM?=
 =?utf-8?B?ZlpHN2x6a2ZoaTBMUFZFRU9xYkR0a0NWUWR1SG5qakpJbmNLVG91VTFuTzBh?=
 =?utf-8?B?M0RWQXFMR0RYYVZCM1RodlNWNnc5UG1CNjdoSUV3OEhhb2NMNEl3ZnJaTzBS?=
 =?utf-8?B?c00vWTlpaW9NVk9iOUVTaGY5ZFdCbjF5SXpXUC9tVmpxVXJ0dlhUakpDVVhB?=
 =?utf-8?B?UUhlb2luRWtnck9aR2Jjbmd4cStjbm05a1dyZVdKaVBFT0hXcFV4eWRqcjhH?=
 =?utf-8?B?NE9RNkhEbGRPdjFuRHZsSFprWGprZmFmcEFvQ1VjUE9WeWJLZ1Y0VGxZYmJv?=
 =?utf-8?B?UmJVS0FzcC9pdE54WHBBTkRpeXZuM1pzZVFkMW5qcE9pRzNHVUlKNzJxbUNT?=
 =?utf-8?B?Sy8xZkdkZlRmSDYrNGVzSWxhTXpGTHROQ1V6RXNxZFN0UUlLb2lsdmZXQzVl?=
 =?utf-8?B?c2lEcHZ3ZnQvdTgyTUxsZ0FCVkM4cWQ0ZktzWjRnMFd6MXpTQXdtQm5BdVRG?=
 =?utf-8?B?Z1J0WjNtNzgyT1hnN3UzSjEwYmEvNmkrMFNNUTA3Z3Evci9YNnJYdWdMVGJO?=
 =?utf-8?B?Vkc0cmFIVG01ZUxVNU5tRHNPL3JqWWxJOXhkZDgzTGl3N3lqZVJtMlFqV2k5?=
 =?utf-8?B?UzB5ZXlkZmxidWkydXNzZmN1MjNkdHJCRkZtZENHaWlXcEFWT0J0amc4emxY?=
 =?utf-8?B?Vk5GRVkxekR6dXlpT2NCMnRJMytvQ1Y3ZzU5Unh5Njdzbng1TjhaVWRWMjlB?=
 =?utf-8?B?d1hwbnQxRWR0NGRrODgyY1I4UDJqNmNTM2FKdkl5ZTZodlJWUjlHbU9LZkI0?=
 =?utf-8?B?K0w2aXBOTDV2UDg4cy96UFQ1SWticCtQUVlqN1Ewa1ZTWGRTUnNUaDQzRjZZ?=
 =?utf-8?B?TnlvR3QvZ1pyNG5WSnI0Tlh3WVRERFdhWW16YzJIM2pvYzJCL2p0RzlXaTYz?=
 =?utf-8?Q?czWmlmovstnmyyqHUvWM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zms3T3RjM3JBYm5DTGtnOEtKYjZVUHBnVE1EK0FGcms4Nkhzcy9ybG1IVzR4?=
 =?utf-8?B?d0c3aGYvMytWbG9ocE5jZXRsVG9ZVndwTlR3UnZBNlgrWWJYRDVSZEZRUThx?=
 =?utf-8?B?RVFXMU0zb0NNNkM4UHl2b3lhWG5YT1ByN2ZWWlVjVmMvalkxVS9TcVRleGp6?=
 =?utf-8?B?eWVVR1RjNEtGVFNlWHloYVNHbFg1NUNtaDNSMVNSZHRuQUt4a2pTanV5bnBl?=
 =?utf-8?B?aUdOZEVDMkdQeFd5aEx2dUtwZ0NXMHRKajhxSHhSQUxjdWdUK3N1ZGxCendr?=
 =?utf-8?B?SXFQU29YeGt6SFliREc5cmVZZVNUNFJHd1VqTUw4TzVKOCswUzlKaTRqQnQ2?=
 =?utf-8?B?TmpBWktkZ0NybEdpekpSeHBnUjNod1ZEeTkxSlErbGRDWDJtcDFwVVEzZGxP?=
 =?utf-8?B?NjBHaHNrc2d2Y2VzM3cvNGZ6YWZOempWeU9QU1dKeGxnZU4weDFHZytHUkE2?=
 =?utf-8?B?aVNkWGJXbmZSbXFoYkhkM3NZQ3BRK1BwalVyUW5PSWtjdmdaSzVTeGdWTm83?=
 =?utf-8?B?WXRLcTArR2d5c3lRV0VhMUpPSEMxaEZCV3crY1FBcG5kUmhzeU9vQzg0a09x?=
 =?utf-8?B?Y2U0OWVCcGlEYlluS2NmK2ttQkdWeXRMUnFWZHlNM2pXaXBRL1RSM3lRQzlo?=
 =?utf-8?B?QW1KL2tiaFYwU0h0Y1VwNVlQYmR6Q28zRjY2cExmZGlSQkJuRGFlc2RjclJ2?=
 =?utf-8?B?QWZneG1HdDlsWFFyYUM1aFk1MjJNMnhkRTN3RHNQdHJRRTVFalliUURWVTgv?=
 =?utf-8?B?RjBkMStJWXdvTTBTU2JYdDh1cnhheHhtWFFWZlBMR0lYN0I0L2J6bFRzRnpl?=
 =?utf-8?B?eGp1NWRhTXp4VW9xYW9Od2dVL05XVE9laEh5MHFqSmovTDBsWllYNTVFS3hv?=
 =?utf-8?B?VzZ5cVE3M3VSaU1TVVVVQW1VNStsVVhmVFlSbXozbEVHVmVNNHdqMElMdk16?=
 =?utf-8?B?Znd3OHJmUVZ2VVZBSmt4MzQ3RnJqZ2h2OWhRektJcnprcWVnK3g2YmhTOHpy?=
 =?utf-8?B?bjJNVzNWWTNOcjhOOWVka1A0OHZkWW9SQVJYOThWZkVoQTFvTUY0SDFjT2FF?=
 =?utf-8?B?M0JNb1dtQ1NoZkRlNlB0dVNUblhnUnYwVDBDaDI5RWZqajRGNjJNSkFxcGli?=
 =?utf-8?B?NHFBaWRZTG1ZR1llUVZkbi9qcUJwN1drMnFKbkw0M01GY2NhdWRzNFNxZVkw?=
 =?utf-8?B?VERGRytrQXVZbXZyUjgvc3pnYVJrRkowQzREc25qT29EWnZ5Sjd4c1FlRzY5?=
 =?utf-8?B?cEI5SXNQWmFKanZ4Z3JXZ1J6cHJOd0tTV2U2N2VIZjZib0pQaG5SV3ZYV1NX?=
 =?utf-8?B?TkxoejNESVlqeXp0azhHRW1nUnNHdTdTK3JkMWZuRjFWTmFOcU16QnJhZzFF?=
 =?utf-8?B?a2djaUhveVJyd2tUVHZnaVNua0RnQ2NsMUpVcTBaN0poNzUyOGdyeU9RVTZG?=
 =?utf-8?B?aU5uMmp5dDJva1ZteDJyM1JxWUJaa0paMnNhYUhGQTJ1bVVGb1RvZURha2Jl?=
 =?utf-8?B?ZVRGeWhER1ZkWTZKSW1RZ2FSa0tNbnFjUU12TmcyNWhTeTROZUh3R1ZISDVC?=
 =?utf-8?B?VlNnYnVkNFV3dEZxM3JEZklDVkVFSlNUS2RCMFgrT01ZV2V0U0d4OWMxK1Ro?=
 =?utf-8?B?TlppTHBVbDlyZkMzWHhSM0ptR2grMGdNU2ZtclFMaTJMQktaN3pid3Q4ZXF1?=
 =?utf-8?B?L25RZzQ0dzRGekRwMjZtMVBQckJDMXBtd0poL0wxSE9tNnJDR25hRHhBRm5a?=
 =?utf-8?B?UTdycHVodGVIWU1HU05reFllenEwWUVTdk5ITUlTNm5iMmhxRGtONUFnUG9a?=
 =?utf-8?B?blMrVzJUWVRFNXN5N1lKVEV2ZllqREluSVIwU2F2dGJta0EvaWNrRk9oazNS?=
 =?utf-8?B?aytTZit6SWhtcklFaEJZLy9oOS9zc0lXRXdjT3JTN2tDZ0ZnNDlyZ3dTdlY4?=
 =?utf-8?B?NVV2R05PYWxwSnZ5WmpFOFkxLzBxb1NFZXR1cXRzdllYRHhHQnNqYUJMNlBt?=
 =?utf-8?B?djNESmtYMDd2dWx1YkhFMkdjTkRyb1gzamVnTnpzQWcvLzNIaityNm1IM0ts?=
 =?utf-8?B?Z0VKK3p6NzdGTUI0azZkMy9NWXJPUlo1ZHJ0Z0ZYMW1mdnQ0U2pyVjB3K0xj?=
 =?utf-8?Q?P4w2dx/awwNcISj6oqqi9IpmF?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12301971-b2cb-4be2-3c20-08dcf7178b87
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 06:12:47.8116 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qxvVrizKn2klYSlXYUhoPRNY71CympRY85McSjNmcv2z3fkhPV7joPVlBwYoAL3A9vUtlV7LLAfViY+82gbbfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6165
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

On 25.10.24 03:08, Tom Rini wrote:
> On Tue, Oct 22, 2024 at 08:04:28AM +0200, Jan Kiszka wrote:
> 
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Allow for the sysinfo drivers to provide a system UUID to SMBIOS. Will
>> be first used by the IOT2050 boards.
>>
>> Based on original patch by Li Hua Qian.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> Reviewed-by: Simon Glass <sjg@chromium.org>
>> ---
>>  include/sysinfo.h | 1 +
>>  lib/smbios.c      | 4 ++++
>>  2 files changed, 5 insertions(+)
>>
>> diff --git a/include/sysinfo.h b/include/sysinfo.h
>> index 8a77ef44856..1c5008b5f23 100644
>> --- a/include/sysinfo.h
>> +++ b/include/sysinfo.h
>> @@ -49,6 +49,7 @@ enum sysinfo_id {
>>  	SYSINFO_ID_SMBIOS_SYSTEM_SERIAL,
>>  	SYSINFO_ID_SMBIOS_SYSTEM_SKU,
>>  	SYSINFO_ID_SMBIOS_SYSTEM_FAMILY,
>> +	SYSINFO_ID_SMBIOS_SYSTEM_UUID,
>>  	SYSINFO_ID_SMBIOS_BASEBOARD_MANUFACTURER,
>>  	SYSINFO_ID_SMBIOS_BASEBOARD_PRODUCT,
>>  	SYSINFO_ID_SMBIOS_BASEBOARD_VERSION,
>> diff --git a/lib/smbios.c b/lib/smbios.c
>> index 7c24ea129eb..1441fa4cde6 100644
>> --- a/lib/smbios.c
>> +++ b/lib/smbios.c
>> @@ -387,6 +387,7 @@ static int smbios_write_type1(ulong *current, int handle,
>>  	struct smbios_type1 *t;
>>  	int len = sizeof(struct smbios_type1);
>>  	char *serial_str = env_get("serial#");
>> +	char uuid[sizeof(t->uuid)];
>>  
>>  	t = map_sysmem(*current, len);
>>  	memset(t, 0, sizeof(struct smbios_type1));
>> @@ -409,6 +410,9 @@ static int smbios_write_type1(ulong *current, int handle,
>>  						      SYSINFO_ID_SMBIOS_SYSTEM_SERIAL,
>>  						      NULL);
>>  	}
>> +	if (!sysinfo_get_str(ctx->dev, SYSINFO_ID_SMBIOS_SYSTEM_UUID,
>> +			     sizeof(uuid), uuid))
>> +		strncpy((char *)t->uuid, uuid, sizeof(t->uuid));
>>  	t->wakeup_type = SMBIOS_WAKEUP_TYPE_UNKNOWN;
>>  	t->sku_number = smbios_add_prop_si(ctx, "sku",
>>  					   SYSINFO_ID_SMBIOS_SYSTEM_SKU, NULL);
> 
> This commit leads to sandbox (and sandbox with clang) failing a ton of
> tests:
> https://source.denx.de/u-boot/u-boot/-/jobs/929474
> 
> Without this commit in the series, iot2050 fails to build.
> 

Strange on first sight - we will look into this. As this patch and the
following 2 are only adding a feature, maybe you could already merge the
first 10 patches? Would make v3 shorter for us.

Thanks,
Jan

-- 
Siemens AG, Technology
Linux Expert Center
