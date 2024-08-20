Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A115C3DA4A
	for <u-boot@archiver.kernel.org>; Tue, 20 Aug 2024 13:34:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9854F88840;
	Tue, 20 Aug 2024 15:34:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Fg4e4MTG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BABE988A46; Tue, 20 Aug 2024 15:34:55 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AB1C887F3
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 15:34:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nUnkxhRUyyFkdhCXRvKZx3mixAvQg/EVVs70ia87VGqZgEO83K7xDz4zWeJAUZ47PMvyc+92fEq/oOpB/kWGQN3aqBCj4qNDNqPYgqwN1ONjZehOoLp0BiRajfBTsG2V7amheeLdM5XghjA/iCrrFkq3GDh3O+E6FHNPUKL6sBaG39K6Pwx83G7PV7h6xSxOMW6+Cjn7S0uXGYJwueW/XngXSBYwyu6IEh8GH41cb0HiG+nxyFxVwm4PnffJMmkkcQhabs7LNoCNbxsuJ72hVB8w2KtyjGzI6GdsobgbJcCzmBw4Yo90kqx9rNhrNSp23T0GHvcdg78rzIUdt0F2cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/NU9QiiuWOpCgk0Y9HcaZj0oOZMQPGf1ZjUsBDJhDs=;
 b=KfuZahvam+wjbjDyYuVi1UWNeCXo7gU5+493U4N66oK1ANm/O4Tvbb1zy9HfhXTIm24Q4aMnl3boALR0Owj8Ry9qFkXSSe5KKCyPr+ivzlhFySMqIy53GrbjtHGm5GjG5nn3qu9ogqrI6wYrkctdD/sN74QRplpkwogJCLK5vZV3D8ZTivr1vy9TfFczFmUwxotT95iRpuJDsilShPTeTY2eF1KzvkiDq7Cv3Ov/nVQTsFZlHZ+2s9/VyoRzwZNABy9ty0jMj1NVQPAyO2Kwxb/3KdN2jbvy4ctDe6g7YBMINk7cd6S5Vgiv4TlS20H8L9vn3UIg6aSTZyNRS8R4mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/NU9QiiuWOpCgk0Y9HcaZj0oOZMQPGf1ZjUsBDJhDs=;
 b=Fg4e4MTGtp2L2r4b2lKjSZ+7KxL+AL9EAMacYED8o9h51Jh2z3Ri5GljEGDabnjJtwJwII4ROl7jtXdH5EC436eBNeEDom74se72Ie3Fkb5NqJJxfMv6qol9zATfsx8PCO+9sqUaGBxUCh7G6ZuA/ImXn9uX/ITSBI7HzBsbReA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAWPR04MB10030.eurprd04.prod.outlook.com (2603:10a6:102:387::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 13:34:48 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 13:34:48 +0000
Message-ID: <6bc0ccf4-66ef-467c-a3f2-e39d3d54f7cd@cherry.de>
Date: Tue, 20 Aug 2024 15:34:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: clarifying i2c_get_chip_for_busnum()
To: Sahaj Sarup <sahaj.sarup@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
References: <CAKZ1LvNcW7y0SnHwye98m1UrL53cqsErtKjFbGp0z+doiU+9aw@mail.gmail.com>
 <77a23ada-f1c2-4542-a4c3-55c71a1cc49b@cherry.de>
 <CAKZ1LvPSLRZJ0HnUtSvwOMw5ax-Vre_m94MaDrfhYmKYK_0KGg@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAKZ1LvPSLRZJ0HnUtSvwOMw5ax-Vre_m94MaDrfhYmKYK_0KGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE0P281CA0024.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:14::11) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAWPR04MB10030:EE_
X-MS-Office365-Filtering-Correlation-Id: db2b0407-dff6-4f31-8aab-08dcc11cdc64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T3dObkRWN2RPc2RaYTZGSGk0K3hWUHUvY29UY2VXTEZsVnUzNzVTN1E3eGJq?=
 =?utf-8?B?VDVMKzJVZ2drVnNTSncwSlpXR3h2Z0h1ZkpZQTF0bkhLUG5Ecjl0OTRtcWt4?=
 =?utf-8?B?ek41ZTRTc1RYbUNsemZ0MmZ4U0k3NmhJV3lKaXBUUGtmN3hnQnhFdEhNbm12?=
 =?utf-8?B?V3krYVVSNGVxTDE2eUUzWWJkNlcxcnVJTGExOWhVakEzNHJna2RHZnhGaVB6?=
 =?utf-8?B?SmtGeEIveHBBN2VLQ2R5SXlDK09QSkp6OUhxVjJTT21xdHhHekxnOU10NWVx?=
 =?utf-8?B?V2QyckduRUY2d21nMlI3UEI2b2RSMXJ3ZmQwY1RaODlvTWV6c2swS2ltYXFn?=
 =?utf-8?B?YUNKMEpuQ2F0VmFNSld5OGVtN05yY2svWUxyamgrZjNvVlNnQmJIK01tL0pz?=
 =?utf-8?B?eldVSDRFY2dobm8rSExSNlgxNnhhQzFUbEF0cVk4KzI5WUpJOVY0dnRSemRF?=
 =?utf-8?B?dlp5MmliS2x6ZktEdE1kYngya2xLc0o1WkZXb1RwQUFiM3JZZUdSMHFPMGxD?=
 =?utf-8?B?WDFJWW5iVXU3LzFOeGNQa1N4UUFNWnpqZ3J2NFB0cmFzWHBSNXg3Qmwxbm0w?=
 =?utf-8?B?NlMrVllXY1h6MkxuTHpabUUvbTJVL0xBQU5jREdoUUYxS21sNEVFS3FtNnRh?=
 =?utf-8?B?eXpDcHJ0WjVhVjZjRTRlWGkrOHlpMGR1aVk3N3ZHRE80S1JzbXNQNkN1YzJX?=
 =?utf-8?B?K2FubkdoZUc1L0RoN1pBbGdyanNta2hsVWowS1JXZHJURDNNZFN4T0EyYThO?=
 =?utf-8?B?eE10U3lQVE1ONzdtK2w4MVBvWjZxT3VCYVE1K2psT3hWLzFTdGEzbHEwVWg5?=
 =?utf-8?B?TlVER2YxUU43UUJaOCsxNEN6SGpBc1dyOTV2UzNZNFpsMUhuSmxJOERxd2VL?=
 =?utf-8?B?T095YzE2OWhnbjF1bzhvTEt5ZVhSK1QwajF1dWJQcUZFWVUvMitMVEdqY3N5?=
 =?utf-8?B?eDBSVWpuWXh0VnM3dzBpQXQxYnhxZm9KdEFjYlJkK0R5bERjc0M3cDZVM2oz?=
 =?utf-8?B?eUEwRGptaXVTWWFuRHNFYy9HeVNMbHVBbHpBQVBHTFo0QmRhRFRtZnBZMTZ5?=
 =?utf-8?B?VXo0b1poNlMzWVdOR0ZrV0c1MzZ3UE52ZUxRMklmOUVjUnViV3JPWUZlb3Z2?=
 =?utf-8?B?Y0JwZWVnSUFraU9QYXdKUWpTTE1yUjEwTVN5aXA1YkkyRU9WVWt2cU5qRXJN?=
 =?utf-8?B?NlRUckVmbzJKV3RjYm53OWNHRVdDSkVaelcvNk9GNkYyejJEMU1xa0xXR0hY?=
 =?utf-8?B?NFMxRGxlT3NaOGxIeHBIUUNzWUo3S0F6Y3JudmxOUG9ZMEFlQ0t0SERxT1hN?=
 =?utf-8?B?WXQwa2dyd0VoT3dYbGpMT2FuT2RZbXhLeC82VHFhSVVwUXI0Tkc5V1U2NWEv?=
 =?utf-8?B?RGR2eDVoV3N3bjBid0QwQzZ6enFxSENTKzlVeU00RHNhS1dUVU5rYnNNbU5R?=
 =?utf-8?B?anM2NlptczdSTmJjUFZJYTYvRUwwQ0hUSG1CQmFYMTYycHRpMVY1SFBlTFRj?=
 =?utf-8?B?OTFtZWVNQkY5ekNBWnhkNEM3TlBOM0lRcnd2VEhybGdGT25iMGUzSVZ1anNa?=
 =?utf-8?B?cDNFemgzY0JzVElsVVdEelV0VXpFN2xxN3N1Y1pFUnQ0VFlxb3MwK092VllT?=
 =?utf-8?B?V3M5MTRGMDNWOS95Z3hyR0swaGcrVC9GeXdxYW9PQ0RYK0NyS210czU1cWM1?=
 =?utf-8?B?aU1VMCtRNTZVMmxzTDl5TVBzSU9UZjlmU1VFMnBlQWZpTkluZDJKOXp1b1ds?=
 =?utf-8?B?TGhabjBjdDlDcm13MlBIVkZxK2JONElUZC9MYWRJZkN0aGFMN2xmNlprWUhy?=
 =?utf-8?B?bWtGajRRemV4VHVMNVZFdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2pLRDF0NWRNa0RwZmQ1L283UE1GY0hlWjR2TmkrNkJSRW9CYmREc0Z4bmlQ?=
 =?utf-8?B?WDU3TGY1SUgvaUNkTkdFMmtaTWdnNnJHck1Yc0JGbVJPRjd1K3doMnVScGlQ?=
 =?utf-8?B?a0UwWVQ4RFRCYlg5aS9LWDRjWmZVRWRkaFBQQUVhOW4vZzlmU21iL2FDK05U?=
 =?utf-8?B?V2swL1lZbCtaZ2RQNnJEMmxZUktCSTFQOGhiUUZsUmNUSkFjZGpiYlkxME4v?=
 =?utf-8?B?eWxNSGlYVnorWHBkQUI5eDB3cFA0RU9ISW9zT2hMd2JrZWRCQ3QxbGI0dW5w?=
 =?utf-8?B?cmFLMGszSytONkhGbUNJTXBBNVpkSnlQMXpYWUNQZE10OC9wTTZFWnF3ZGZV?=
 =?utf-8?B?MnhMMTNuZnhvb1Nvb3pNZkx4by9tbHZxWWN5aW5GTk5GMjdQZGpjeHVha3R4?=
 =?utf-8?B?dnVSQ2kwaXFjeWw0TGswcnRxdHlDYkI0aUEyNW5KeXJFcVZHT0V3anV3R0d6?=
 =?utf-8?B?RTNCTGhXMmdwaFBhTXBocVo3M1pxNEEzK29uZlNNTHRocFJBSTB3T1IwL2sw?=
 =?utf-8?B?b3BUMEw0THpYWDZyU1dSY1gyaDYzYzErcUpJaHEyelZQSWxtT3ZPakVUZ0pq?=
 =?utf-8?B?ejZuTTdrSDNrelRaenFIaGo5czdUZktDbUZiaUpROTBMdUJNbi9ieUw5ejZI?=
 =?utf-8?B?Njh6emxCWDJoSWpMTEVpcFhBVVc4dTVaZXVmd3VJVE5NblQwSFArVkZ5cURI?=
 =?utf-8?B?V0ltMTZwU3kxeExiT3FiMFRaK2J0RktSNVJsU21STDFhQTVhWXR0VmNQTWZr?=
 =?utf-8?B?K29IMTVjbVhaUEJHR3l0VVFncVU4bGVMeVlqcFc1bHdnS2tMbFZucE1oLzg2?=
 =?utf-8?B?NDBxem9qTjNYYS94MFA3TFUySkhuR0k5NXV0Y2d2VzF6V2h3WEVLV2c0bnFk?=
 =?utf-8?B?citjeDdxL0owVWptbVQxNk4xaG5WSXBNWmpKSm5ZZm9xQ3dseWRnemNsREEy?=
 =?utf-8?B?elJ4WmlVZ1l0eG9TdUwxKytFM1plWE05Y1JqK3E4WEN0SzNGOGN1WnpaaVd1?=
 =?utf-8?B?Zkxkd0hiajBKNmhwM2FSclJlQ3h3WGU5UkFyWUZaL1ZmTVowb1Jpek9RRUkv?=
 =?utf-8?B?ZmFNa3BkZ0pFME05MEtvZ0xSRitEaVhQbXFCVWlzR0g5aERDZHFYMFJ3SVlq?=
 =?utf-8?B?WW52TFdER2ppZVU3UGdpTGFuamtiL0piZFRnS2lsYTVmVUIwV1JoT3NoRkxU?=
 =?utf-8?B?R2FFTzNzNHVsSC9vTllIWTdKbzYwZ3U5NkhLOHhGck5TL2tVOE91NW1uM0pI?=
 =?utf-8?B?L09SNzJtVGFxNXhpUlBBQjJUZnJBQWFGb0h2dG9EUkVPWUhKV1pzVWpNWDZn?=
 =?utf-8?B?YWZzWWM1cTZJU3dRKy9YTExrSUxrb1Y2OUNRenlWZEYyQXVucThYc3FvT3lh?=
 =?utf-8?B?dGtvRXh2QVJ6S2JJamgrenllb2ZOaWVDYmQ2dWlzN21JL29CL29sY2J6UTRB?=
 =?utf-8?B?ajQyMnZkZUlkUXR0VmJhcEwyQ1ZmTEdQU2Q5MkN5TjhCazNQU3EyaUN0eG44?=
 =?utf-8?B?Y3ZkMHN0QzRnbHZNNXNiZXdXYVVGN3NvbUZvc1NzTHFMcDRQbnlaRDVWajdG?=
 =?utf-8?B?MTkyeGFrZ2hzN0Zreno3K0lmRktrb2Q5T1EzYjVma2wzNmgyQ01iTTV2SGIr?=
 =?utf-8?B?dHlEemVWdjVnSDRTdkhQOFdCekwxQ3Vxd1NqVWNLbm9hcW5mc3dYbmpwbGRp?=
 =?utf-8?B?VjI2RTFrV3BZcmlXTGJUSHJHUHNxdUx6WWlMRHY0UmJhenh5SjFCaG1TSDNM?=
 =?utf-8?B?ZjlJd0hLM0E0d2lWMkJmUlJyTE8rL3J0M1JVdFpYTmUvTWtmVkplSXZWc0Zx?=
 =?utf-8?B?R3h2K2lVcEZVQ1JsM0piWDFFcUpVaENsYmtRS0F3VFNWTk91bEwwTTJWd0VG?=
 =?utf-8?B?ZGFHcElQRmNVenFPQ3YxWkxvMzJGL1JTbnBIdGtGYWwxUERtTnRyM3h1Z1dQ?=
 =?utf-8?B?VUE4c2VxRXdJYnlaSFJQb1Q5WElBakFDMmxrODNneFhBc1ZiamE0YlBoVTNP?=
 =?utf-8?B?dlBhVWZpSnk4K3N3MzkweU9FSVIwd2pWa2VSS3ZZbnVjQlpTL2UwOGE3Lyth?=
 =?utf-8?B?cUxsbTVFSDhUUXFOR2E4NUt0LzRMRjBDUzZXVy9ualJGUzkxbkVPelZURThH?=
 =?utf-8?B?Z0UrMlV5MmZ2eExjUnoydmNmR3RNZ1NmQlJ6bi9qclROY2tmNEIreUk2bVpn?=
 =?utf-8?B?S1E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: db2b0407-dff6-4f31-8aab-08dcc11cdc64
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 13:34:48.1994 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ywBgxBFdwIsJS01WQKOlqB/8bI1Az2CT4a0elAansmrqyBjOJmwbwdjAvkKt83JkeV6raSyf9B61TG0h2+f5GB/5blQjz3cyi5lPwxYxG9U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10030
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

Hi,

On 8/20/24 3:01 PM, Sahaj Sarup wrote:
> [You don't often get email from sahaj.sarup@linaro.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> On Tue, 20 Aug 2024 at 17:21, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>
>> Hi,
>>
>> On 8/20/24 11:12 AM, Sahaj Sarup wrote:
>>> [You don't often get email from sahaj.sarup@linaro.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>>
>>> Hi,
>>>
>>> In `include/i2c.h` , the udevice pointer and return value definition
>>> seems to be confusing.
>>>
>>> ```
>>> /**
>>>    * i2c_get_chip_for_busnum() - get a device to use to access a chip on
>>> .
>>> .
>>> .
>>>    * @devp: Returns pointer to new device if found or -ENODEV if not
>>>    * found
>>>    */
>>> ```
>>>
>>> Should this instead be:
>>>
>>> ```
>>>    * @devp:   Returns pointer to new device or NULL if not found
>>>    * Return:  0 on success, -ENODEV on failure
>>> ```
>>>
>>
>> For the @devp part, seems like it as uclass_get_device_by_seq sets it to
>> NULL and i2c_get_chip only modifies it when a device is found.
>>
>> For the return part... not sure. We don't overwrite the return value we
>> get from functions we call, so not sure we can guarantee that only
>> ENODEV will be returned?
> 
> make sense, devp can't return -ENODEV, ofc, and Return returns 0 or -ve.
> So it can be closer to:
> 
> ```
> * @devp:   Returns pointer to new device or NULL if chip is not found
> * Return:  0 on success, -ve on failure to find bus or chip
> ```
> 

Nothing guarantees we'll return a negative value either though, c.f. the 
if conditions in i2c_get_chip_for_busnum(), where we only check for ret 
(i.e. ret != 0).

Cheers,
Quentin
