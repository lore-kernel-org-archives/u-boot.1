Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E52E7717F
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 12:47:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A362A8004E;
	Mon, 16 Dec 2024 13:47:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="k3z85HPx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E4AC8005B; Mon, 16 Dec 2024 13:47:29 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E61AA8003E
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 13:47:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YJFxw8fPtM990JaTopWWnre4AM8En0GPqmTtSjr3vZSfW1pPKdemX28yy5KtL6bA0eEOCy2bcl2l2/tQn2kCeWKWQtlqqbvhwaS0HThxZwHqS0fuC0mdpNpvpD3Kd1VGKMzbSkSN8NIy9tk0J3BLbEHhjU1xJw4n5TYv/eVVAS7qPfSHfDn338MrGRMXcClnfB+ljlTp61LeVRGowl7ad/4YGsG5UN7xOMhFsozSFExvBLIGjYFEn6TOdvDEyELn7dbl7grKvKu4SbsLyzxfpYMl1k4M1gj/vpyJOGH+88DEKyqEyVG8osXthTzWv0m8mz9lVR/SU7OhykYCjNkMcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NmdiOWkHPGkYVYBHTvc2C9sozMqh98bUsmdlWFo6Ei0=;
 b=dVN5aNuxKwdFCYYibYHoQKfHNypXSpRuoylB0Q6I9Fj6fdKRBx7+o0syWuVSKUpgefQX2FlzW1FM0WvSpiugqNQKykwyoD2bz6+jKBFUVtiijRsWE44Yyx9xZok1+VlzYyEpjt7wjYaZK9sFZ1rOBs7emIj0lELjnEt/eR8QWsEABM74HDJETsntBzh7gZceen3MWOuVxCsllahO3aAz6WowO0fNSSL3pu7lS1OW8/r04X6OmklPiWA5Oli6fmQRrLlcTLEEe9SZ8fpMz3YSQd5rbuHDu86F/FaxkUoUjLEwyvkfOYN3kgDIgZYSugUUXFe4MiFUP9CRkyTg5YnLlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NmdiOWkHPGkYVYBHTvc2C9sozMqh98bUsmdlWFo6Ei0=;
 b=k3z85HPxFjMHHpPpCorTDesnAGhSu62YhWLH4tILPQTZA/swKFbd4S8TdwY9LF2eXYNhrZLehnMvJv0kMxxywP8Ueyh8EdcEfLYihHg5NQ5ZxD5eSgUCfNLq7suo5YvG5oehrd1Gb96L/DD2DN7w6OPa18/3JBwaB+0U3ObNTEc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA1PR04MB10400.eurprd04.prod.outlook.com (2603:10a6:102:44b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 12:47:24 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 12:47:24 +0000
Message-ID: <e4a637ff-853e-4072-821a-8f79230913f5@cherry.de>
Date: Mon, 16 Dec 2024 13:47:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] rockchip: Add support for Radxa ROCK 5C
To: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 sumit.garg@linaro.org, jonas@kwiboo.se
References: <20241211033934.23044-1-naoki@radxa.com>
 <20241211033934.23044-6-naoki@radxa.com>
 <2600bdcb-3c57-4d52-97d1-c63758b25ed2@cherry.de>
 <115020791DA19920+c09c7adb-9fe7-47f4-99cb-2c8c862fe1c5@radxa.com>
 <6b93f3d7-c0bf-4517-9523-3c1a6a1e23dd@cherry.de>
 <445A20D66F127770+f902f36a-5648-4850-8dd9-99b7f36380a8@radxa.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <445A20D66F127770+f902f36a-5648-4850-8dd9-99b7f36380a8@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0137.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::17) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA1PR04MB10400:EE_
X-MS-Office365-Filtering-Correlation-Id: e82ee0bd-b351-4088-1b90-08dd1dcfc9de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bTNPcEhXWXZ2elFsSmRUT1lHQkZlOGRPRGFjajRXUTNQZ0JISzljNENQb2RC?=
 =?utf-8?B?L2E5UGZuek9QVkdMVHYraXQ1SXdscXdRQTBFMWxlcEVHTGYzVXZJUlNzQTBo?=
 =?utf-8?B?NjdGMEY2MkgwU252TytVTkE5QlpibWIrNnpPUHJrVUIyVDEwU0pKdEV3WTA2?=
 =?utf-8?B?Q2pLeEVWZzBNSVJyVWFrcVhPcVBpMmg5MkhwWFVVa2h3YTdBUkIrNkgxY3V3?=
 =?utf-8?B?cXRrTGtIbE4vSHpNY1dOMWlYdjZOMXpScGhXVmVVUDZLc0pHTTJXdTVaeU96?=
 =?utf-8?B?NXprTitwaE1KR3A3ZXpSbkN6eGVnZWlUSTk4THU3OVhqTkdWbnl2REhPYTBW?=
 =?utf-8?B?bk8zU25yaGExaEw4OExsaWoveEJWNitEWkZpb1ltZlVOSzZoQkt3V0VjRjZo?=
 =?utf-8?B?YzJHVzZCenQxWTVMY2M5S2gxZldWYXkvVEtJdExvSUNKdE15V0ZjaUZKcHY1?=
 =?utf-8?B?REIvb3h0MkMySGlVcjN5bnFzai9qYTRqRzJIaUFDNVRhN0NZOEsyK2lnVklk?=
 =?utf-8?B?UTQzazRjQ3BDVDdpeHA5OEExY2JVUW9QUDRFeHdLUnZIbEFkKzZieE1FRUov?=
 =?utf-8?B?ZVZYMVB3R0JESWE1SVZLdENSeTFtNzlRSHlrSEUvc0R3LzNJM3lRVXFhcGVF?=
 =?utf-8?B?TXB2SXhDNWhWNS9VQVdGVS9teE1meHpxQ2Z5anE4a0l5SzYvZERLcGlXK1g0?=
 =?utf-8?B?bnpES3dSUS93NWNycVVQL0QrQndaeTZVMVFEVlVOdFRUdUZDK2pCRE41YkF3?=
 =?utf-8?B?aHQ2RFkvMUpTcVNEZWV0Tnp1eEY1WC9PYWY4bi9ZU1VwTU9tbUczN3F3eTVU?=
 =?utf-8?B?Qy82TGFRY09BNDBGZk1mUDkzUEJvOHM0eFhiODBsZVp4dmEzc3ZxN01uNE8y?=
 =?utf-8?B?YlRrc3pFM09peVhoMm96YmJNUkF0RWpEUFRWOHV0TGJwUGtKQWZ0SDRYUkhH?=
 =?utf-8?B?ZWRJVWVMcjJMT1RjQXIwbGtvaXc2QmtmY3A0SjN6MGNQWFg0Zy8yLytpK3lN?=
 =?utf-8?B?eUE5RDFnb3lxREpGL01jYlkwN29nV3pEOHZTUlphcGpOb2FWQitBY1U4MHRM?=
 =?utf-8?B?RXRSNlp1VHlNUE5hWmxuVlBvUUpPVGFqMmY1bGdRbEJ5YzNDN25GVkdVVTUr?=
 =?utf-8?B?YUl5KzBhQ3lVTUFWWXpBbzBvMHhFUnM0ZEdLbFV6VlRlRThaWFdQQVgyMFFk?=
 =?utf-8?B?QnRtNEFVVVUwaE9Ga3ZmeXg4d0lYUElUNGc3MnJxaHhWZkUwNy9DTlpoa3RC?=
 =?utf-8?B?UEtyRUtLeGFsdzhRMUJuOCsxYkh4SnpxcytQTlowNVcxVlNpTDEvZmJtUlFl?=
 =?utf-8?B?N1NBT0NEMHdGTHdKUTRRMWxMOFMyQy9uV1dlSmVXNU15SGhNM1pZVlhnRWVZ?=
 =?utf-8?B?b2RQbDlvWFIvN2ZpdS82TVVMTVNDZzZ4dXE3aUxpTGp1RlVTem8vZXA2RE5j?=
 =?utf-8?B?MEcrcFlwRmwwSU1FUC9Mb05WV1QxZzhseit5akVXTGNHRE1qTWVuajUzYUcw?=
 =?utf-8?B?bXZlbUI5eG9ac0pheHg4NlRzR25oaVBzWUpCL3VDMFIrUFhVVHFTYzROWGR2?=
 =?utf-8?B?MzRPQVoyUmVwalQxaVhrbWpFeFNvOExYZDJNSEVBYUtSV3ppVjlCbnVLREFU?=
 =?utf-8?B?d0dQM1BwMm9URDhNRWl2SXQzZUxPQVNjWjVYUFVEbXpoUHR2alpyZDFmM0xV?=
 =?utf-8?B?UTRHVG5POWhoK2tlZnJ4d3VoRlNxNVF2d1dBdnlqWm8rbHZEQk0xUy9WTEI2?=
 =?utf-8?Q?zbD9Akn/+ljvp9xK0p3JkMHVCPaGd2PhuSOKbLt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlJjdEZ6SGd0bmt4cGx0TWtNcVN2UUlRTnUzR2g4bHE3bmpUTlJRTU00bkd2?=
 =?utf-8?B?WkxiRkZEdDBGWlI0VHlCazN5dHg4a0ErdTZ4TVU1Y21WM0dnTXhnK0VMTTN4?=
 =?utf-8?B?K1ZBNjNSU2tBNy93a3Rsd3haRDBuMWVkczhhQUkxY3R0N0VETWNWRnRFVG5z?=
 =?utf-8?B?VzNyeFFBY2NXVTYxWE5YVGJVTVZNREdxTU1xSUVzazhVT2ptY3k4WkpPSUlI?=
 =?utf-8?B?YXk2blFMeWw4N3BjL2l1bWo1dTJBTFdUeVk1WE4veDVNWlZSRXBUUVN5TjY2?=
 =?utf-8?B?UEJFOXlIcEdmMklIUk1EOFBlUnJxZjVnSnhKZTRWUW9Tam1qYmNaMmlLSUQ3?=
 =?utf-8?B?UWl4WGI2akFEV1VSZG5paXJIOGFERGlDMU4xcjZUWHc1ZGRzZFVMeW1hbWo0?=
 =?utf-8?B?U21vRmNtU2VtdmV1T0hJTDZSbVJvRTRaQnFPdE84NGR2eFFibGYwZDZ2VnNw?=
 =?utf-8?B?a2FXNk1MSmpKZWZRT3JGS2Z2RFBsSmtseXdLblB6bTl1QVROS0RWN2RSeFpk?=
 =?utf-8?B?U1Y3NSs2alE1ZCsrRk5KNUc3UTJnTFpZcVJHdHVvbENrWVB3eFRjaDJIdU1Q?=
 =?utf-8?B?MW1HbWdNWUVoYUpiSTdOMmJjODNQeVNHaFNncFJaY2dTNkh1bHNWNUZzRWto?=
 =?utf-8?B?TDcxQlAyTFR3R3g1RUUreVhMQnROKzZOS29UeWQyTDFFZzZxQ0lmQzdwTldW?=
 =?utf-8?B?NEt4bmNYR2JoTFpoWkdLMjB4RnYzYXZkaHZkSEpLRWZ3bnQ5L3l6T3Q4L2xD?=
 =?utf-8?B?WEc5clloUlJLdEg0T1g1aGhRL0NJMEFneTNQVGlINTNRRlFsNC9mbXhTbk53?=
 =?utf-8?B?L3V6QmdsWU1PMXJ1V3k5TnFXaVZqSEJoeENMV0laakVBMGlJMVo1ZDZTbk55?=
 =?utf-8?B?YnNySjBhWTlMY0JDcE4vamJkSnhjZGhKWjMzUGIyQ3JmREJuRmNIUkk3Nldt?=
 =?utf-8?B?bmFlNmNYZElTS1BHRTZpdjRBSTVVS1U2OWlBclV0M0ZZd0hxUURnbmZNZ2pE?=
 =?utf-8?B?eVhoSWpGL20yRTJKZlJ0UHVQMXpEaXpPUXJUUXJiWFVReURaTVBjNG5NZFh6?=
 =?utf-8?B?UzhEVnd6a2daOFNFM1c2eTRaeFV2cDBHc200SFkxTzZFY2NZWm9obzQ1N0pI?=
 =?utf-8?B?bWdKbFl3VmRvZ1ZlREVrTGFxeXJwYXplcEdSaDhqSWplQzJIWVgrR2gzTXRT?=
 =?utf-8?B?cEpxSXFjSTFvMTNHNEZHM3BjZkM1SEFYdlBaU3o3UE5GQkRnVG5WcTNmT0Vo?=
 =?utf-8?B?VXZsSHkyak5zbzl1aS9sd3lYQlNNK2xuNy9kTDRhRG1BcTNPZDVSSkFDTGZV?=
 =?utf-8?B?YWNkZE5ocHA1ZWZ2WFJKOG5mZlJBNHBRZTNoeXhzVjVwVGpjNjVqczJHdWFO?=
 =?utf-8?B?bnk3YzBkbGNPaWtHeS85ZXkrUzYzY0h1MWNyQnc3NklleFM1MjdIVlpHVmZD?=
 =?utf-8?B?cjFuSWJvWnlZcEJxWCt2K1Z4VkYxbWkxV29IM3VWZUIrenJNakFNNXBFckJ0?=
 =?utf-8?B?UzdPYmxkMkthZmFJMTB1RHA3dXI1WG5uZ2tBelg5NkR6YmtHcTV0RHZHZlEy?=
 =?utf-8?B?YTNHc1ByVk5Dd1lEUjFFQnZJZTNhQUR1Mm54WkhZZkVHdVhXdFA0M2VybVVG?=
 =?utf-8?B?cTY0OFpuWG5iQzRINmdlT3NreTA0RmM4SFBjZnA4UFVEOXgvbngxTVlEa0xO?=
 =?utf-8?B?U3VvS2hETGNwZzZhcVB3VmhyTVI4WENzTHlJRzdWOGdnSDNmaWtqYjBOcnZF?=
 =?utf-8?B?Q0g1YlFRbEl4a1BiaU4rQTBoZzFibktGZXYrU2ZYUkNvTDVRbEJ6UlBqRUlO?=
 =?utf-8?B?Q1VNWUllcFI1RXdkaFFBNUt3YUpPMk9TRytEeEgrWGFuNGVwd0FUTVJRMTlZ?=
 =?utf-8?B?SVQ3bFpKeWdzbVpqei94ZGorTGtRSFV5QXNPa0wzOFFvcGxoRklUL2dFYUk1?=
 =?utf-8?B?T1F2QWc3QlMyK0x2WGF0dmJjQkVMRGRBUE1Na2NtU3c0R3hXU1JIR0ZrUCtq?=
 =?utf-8?B?Sm1vSWNsY3dHVjRKQmEwYiszdzE1K01mM0R0YlVOU0dGNlEvaTIvbjhQUzdq?=
 =?utf-8?B?R3lnWmFaVzl0NHBuSUZNNE5yaS9TSHJmdmZrVFIxY2dIRit6SlRTeUhjN1NM?=
 =?utf-8?B?cVdOKzVQKzBDNXRDYmFGbWFERWlsVjFZQ1VjNXpDcUJsTDhnQm9BUGl5M1pj?=
 =?utf-8?B?TkE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e82ee0bd-b351-4088-1b90-08dd1dcfc9de
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 12:47:24.0845 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3U0EYXar/RamzlI3F3kKFBXVA2sw6+eT89Vlh4oAYVQwLsV+ZqlideusvNM2vE4YMwxCaSt9XlHsyugE1nsMoNATPxSOfmj082tK3vjFDSo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10400
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

On 12/16/24 1:39 PM, FUKAUMI Naoki wrote:
> Hi Quentin,
> 
> On 12/16/24 18:57, Quentin Schulz wrote:
>> Hi Naoki,
>>
>> On 12/15/24 2:37 AM, FUKAUMI Naoki wrote:
>>> Hi Quentin,
>>>
>>> Thank you very much for your review!
>>>
>>> On 12/13/24 22:11, Quentin Schulz wrote:
>>>> Hi Naoki,
>>>>
>>>> On 12/11/24 4:39 AM, FUKAUMI Naoki wrote:
>>>>> Radxa ROCK 5C[1] is a Rockchip RK3588S2 based single board computer.
>>>>>
>>>>> [1] https://eur02.safelinks.protection.outlook.com/? 
>>>>> url=https%3A%2F%2Fradxa.com%2Fproducts%2Frock5%2F5c&data=05%7C02%7Cquentin.schulz%40cherry.de%7Cbe7d810ae88f4203af8208dd1ca921c6%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C638698234938145886%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=8TcHBC2dV1LzouPSR8%2FICOBVshq9RndgMQS3m3XLwFs%3D&reserved=0
>>>>>
>>>>> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
>>>>> ---
>>>>> Changes in v3:
>>>>> - fix compile error
>>>>> Changes in v2:
>>>>> - arch/arm/dts/rk3588s-rock-5-u-boot.dtsi: remove unused node
>>>>> - include/configs/rock-5-rk3588s.h: fix include order
>>>>> ---
>>>>>   arch/arm/dts/rk3588s-rock-5-u-boot.dtsi     | 16 ++++
>>>>>   arch/arm/dts/rk3588s-rock-5c-u-boot.dtsi    |  6 ++
>>>>>   arch/arm/mach-rockchip/rk3588/Kconfig       |  7 ++
>>>>>   board/radxa/rock-5-rk3588s/Kconfig          | 12 +++
>>>>>   board/radxa/rock-5-rk3588s/MAINTAINERS      |  8 ++
>>>>>   board/radxa/rock-5-rk3588s/Makefile         |  3 +
>>>>>   board/radxa/rock-5-rk3588s/rock-5-rk3588s.c | 77 +++++++++++++++++
>>>>>   configs/rock-5-rk3588s_defconfig            | 94 ++++++++++++++++ 
>>>>> + ++++
>>>>>   doc/board/rockchip/rockchip.rst             |  1 +
>>>>>   include/configs/rock-5-rk3588s.h            | 15 ++++
>>>>>   10 files changed, 239 insertions(+)
>>>>>   create mode 100644 arch/arm/dts/rk3588s-rock-5-u-boot.dtsi
>>>>>   create mode 100644 arch/arm/dts/rk3588s-rock-5c-u-boot.dtsi
>>>>>   create mode 100644 board/radxa/rock-5-rk3588s/Kconfig
>>>>>   create mode 100644 board/radxa/rock-5-rk3588s/MAINTAINERS
>>>>>   create mode 100644 board/radxa/rock-5-rk3588s/Makefile
>>>>>   create mode 100644 board/radxa/rock-5-rk3588s/rock-5-rk3588s.c
>>>>>   create mode 100644 configs/rock-5-rk3588s_defconfig
>>>>>   create mode 100644 include/configs/rock-5-rk3588s.h
>>>>>
>>>>> diff --git a/arch/arm/dts/rk3588s-rock-5-u-boot.dtsi b/arch/arm/ 
>>>>> dts/ rk3588s-rock-5-u-boot.dtsi
>>>>> new file mode 100644
>>>>> index 000000000000..be1a2f9ae7bb
>>>>> --- /dev/null
>>>>> +++ b/arch/arm/dts/rk3588s-rock-5-u-boot.dtsi
>>>>> @@ -0,0 +1,16 @@
>>>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>>>> +/*
>>>>> + * Copyright (c) 2024 Radxa Computer (Shenzhen) Co., Ltd.
>>>>> + */
>>>>> +
>>>>> +#include "rk3588s-u-boot.dtsi"
>>>>> +
>>>>> +&saradc {
>>>>> +    bootph-pre-ram;
>>>>> +    vdd-microvolts = <1800000>;
>>>>> +};
>>>>> +
>>>>> +&sdhci {
>>>>> +    cap-mmc-highspeed;
>>>>> +    mmc-hs200-1_8v;
>>>>> +};
>>>>> diff --git a/arch/arm/dts/rk3588s-rock-5c-u-boot.dtsi b/arch/arm/ 
>>>>> dts/ rk3588s-rock-5c-u-boot.dtsi
>>>>> new file mode 100644
>>>>> index 000000000000..bb1cc9e4a279
>>>>> --- /dev/null
>>>>> +++ b/arch/arm/dts/rk3588s-rock-5c-u-boot.dtsi
>>>>> @@ -0,0 +1,6 @@
>>>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>>>> +/*
>>>>> + * Copyright (c) 2024 Radxa Computer (Shenzhen) Co., Ltd.
>>>>> + */
>>>>> +
>>>>> +#include "rk3588s-rock-5-u-boot.dtsi"
>>>>> diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/mach- 
>>>>> rockchip/rk3588/Kconfig
>>>>> index b5a0e624a532..e1487ecb0464 100644
>>>>> --- a/arch/arm/mach-rockchip/rk3588/Kconfig
>>>>> +++ b/arch/arm/mach-rockchip/rk3588/Kconfig
>>>>> @@ -260,6 +260,12 @@ config TARGET_ROCK_5_ITX_RK3588
>>>>>         Front-panel connectors for audio and case-power, -leds
>>>>>         Powered by either 12V, ATX power-supply or PoE
>>>>> +config TARGET_ROCK_5_RK3588S
>>>>
>>>> This should be TARGET_ROCK_5C_RK3588S?
>>>
>>> rock-pi-4-rk3399_defconfig uses CONFIG_TARGET_ROCKPI4_RK3399.
>>> I'm doing same thing.
>>>
>>
>> config TARGET_ROCKPI4_RK3399
>>     help
>>       Support for ROCK Pi 4 board family by Radxa.
>>
>> Here you say this option is for ROCK 5C only.
> 
> Because this is first patch which adds support for ROCK 5C.
> 

That's fine, you could say something like:

Support for ROCK 5 board family by Radxa.
Currently supports: ROCK 5C

And then we can extend this list whenever someone adds support for a new 
board of that family, which would make it easy to find with a grep if 
the board is supported and via which target option.

>> While this could be a good idea, anything odd needs to be justified in 
>> the commit log so that we can follow your train of thoughts.
>>
>> This patch series only adds support for the ROCK 5C so nothing hints 
>> at this being usable/used for other boards from Radxa. Which boards 
>> are you planning to support with this option? If the ROCK 5B/ROCK 5 
>> ITX aren't going to be part of it, why and how do I know which of the 
>> ROCK 5 is supported by this option?
> 
> It's possible to add support for ROCK 5A (RK3588S).
> 

Since it seems you're planning on supporting ROCK 5A with the same 
target option and we already support ROCK 5A, maybe start this way 
instead of adding support for ROCK 5C and then migrate ROCK 5A to that?

i.e. adapt ROCK 5A so that it can be reused for ROCK 5C easily, and then 
add ROCK 5C using the mechanism you would introduce in the ROCK 5A 
adaptation commit(s)?

What do you think?

Is the ROCK 5T going to be supported by that common target, defconfig 
and board file as well? What are your plans :)?

Cheers,
Quentin
