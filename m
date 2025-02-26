Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E99F7C021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 11:19:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 340C7801DE;
	Wed, 26 Feb 2025 12:19:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="FCw4n+gk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DE6280805; Wed, 26 Feb 2025 12:19:56 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::627])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73E6D80077
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 12:19:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wuo8qozTNh0OG8vADMXoaecbshV11MS+FmvSASLCRzjpPJx+EoCRK39kLmonA2NiIpPROsKow9lxL7iawrhj0tRcjCJS8Hi1csRaSDo/36PYxfmRzp4g3r9RqwlkGPnoNjQMUgsW5N+YXTc+Ajxc/F4YndRhoFaeIyHDGMG8CjWih/kUHfvvVy5Zx+BZEJJaZefPg0BKCAV4WUWHHzlaqrpVS9zMgSdWOoE0SzD9qufNnkTraBKvAf6YtDslfB6soXwHP5d2D5SMTFB6aXmXEytoTfbw4pxZxTNTGUyr2GkqKjO0+dmKiFTT+wWg72UCxpHV2FRGVYGXtCa4aTaUsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IfgJHceYw9SKB7EH2s80ZrqoBsXwAGrHnPQDatKV6xk=;
 b=TGwWab088tL0m5LYGNEWno6sh2iruaT0q73EmoVYFp8cfSdRPgf+3K7RAPEHYHTZbf8a9Y4trH+A8+rtqqHWxUDWofGMCE+L/+wEizptQKmDQLByO2ZRc9Atlgj656I/34carV7pAeNR/0IqY17oS+IKeHCfufe8qzaqgE51Z0A63jodpbz5Er5ucUCnqkXioaAVPCR9Z4q2NY0fQs/ipMP0/bHrfmINS/+taofF1fpoKc1N7ewTLoDPGxlp/rJ5KiMNajn/v+FU6hGoFBdJV568G9bil+XojjJT8NI7JTTv0Bwqh7ZGoKUwYJGCsMwA7+Fc4ml1AVn5K5Iwe/PLIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IfgJHceYw9SKB7EH2s80ZrqoBsXwAGrHnPQDatKV6xk=;
 b=FCw4n+gkcxw2Z7P8LU0jhYM1MukAgQFUH90hO0z/bha1PjE0OU3ACKnx28XvCwgFm1RMXnAk1U3qTdtTxw+75OjLKVyCrwIudSj41672pkW3tDLIHbXQQfJhCwEVnrWyAqWPwqAmJMAsispgNOsgk816Rqo56lTttVKdNTil2+E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA3PR04MB11179.eurprd04.prod.outlook.com (2603:10a6:102:4b2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Wed, 26 Feb
 2025 11:19:51 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 11:19:51 +0000
Message-ID: <3bbc645c-3aad-417a-b8eb-633b6cf11668@cherry.de>
Date: Wed, 26 Feb 2025 12:19:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] led: fix next coverity scan error
To: Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@denx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>
References: <20250225094923.71364-1-hs@denx.de>
 <308422ff-3036-48ed-9d78-305b6904fc87@cherry.de>
 <ace167e3-1535-7184-6583-0e9654a8c7d2@denx.de>
 <20250225161334.GO1233568@bill-the-cat>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250225161334.GO1233568@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0208.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::16) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA3PR04MB11179:EE_
X-MS-Office365-Filtering-Correlation-Id: a1292ff5-8d48-4e36-7f35-08dd56577cce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RXd1eEhtZjJtNUVKRk9jVk5MOTFpck5tMEdDeFA0V1hLTFBFZWVUWkF3M05y?=
 =?utf-8?B?cmd0dWs2QWpQdTdrOWlrcUVvS3Q0V2RlRnFrWG9OeW5EVGVvVUhDWG1RbEZF?=
 =?utf-8?B?cURhcWFmTTZtcUYzdUtKZ2xjTllldUJWZ2k5clJiRzFmbU5MNkIvZlN2c1U0?=
 =?utf-8?B?TGRMbElMeG02MTRLajlIZFFyMmdyalJzamlRYnNyaWNONTJCdlF2UlpCRlZF?=
 =?utf-8?B?RWlwb01JaWZ2RG5SNFNrM2NaL3R6WGRXdFBEMTN0TDIxeWlSaHA3MjdiTllI?=
 =?utf-8?B?RVk2M2JPdlRRVjBFblVUMzlpSE5xYWo4VCtoVURvK3VrOWpwdHJwVUxwSHVR?=
 =?utf-8?B?UUhZR1RMY2pua0FSdlJOOHZRdDJBVjg2a0h0SHRCeWw2M2d5SlNWZyt3eUxI?=
 =?utf-8?B?dS9yZ3VzWUxLWHhDWmZVZ0lTT0NwRzg3MVZlNUpsZjNJNzIzU1lueEcxUEYy?=
 =?utf-8?B?Y2gyWXNRc1VDenN2M1NaTmFIZWlPTC9aR2xZaVZYM2hGQW1LU1pZYzM5Q3gv?=
 =?utf-8?B?WTUvTnN3ODVBNEJ4Vi9ycUdhZDYrdCtvVXZDRWJoK1Z0V1R5ZVo0YWtoSXEz?=
 =?utf-8?B?Rm1XLzRkanVia1ZwTk5QYXZlYnFVd0lWdU0rKzIxeGlTVHFpbzZrMmpaSG5N?=
 =?utf-8?B?SlhLZGE5SnNHTU5vYXZZN3o2aWNDYitnNG1qa2VnNGNJQ0paR2Rpa0hHWFA1?=
 =?utf-8?B?OTMrNzlMUEptb0JxKyt2QUVyNExWUTE2M3Y4NGtjVHpkb0cwZmNmSGdjMy9U?=
 =?utf-8?B?MG1uMXIzb2pHbGNpVXR0MklaR3JaWG9heHJTTUtMVUozNDh4VlpqWXBud0g3?=
 =?utf-8?B?Z0hmRHVwM3JxUTROMEtpTFpFVFhxSlRYR0QyN1pYdWxzcU8zUDdEcE1LZk9h?=
 =?utf-8?B?YmlrNUpaaXpCWjAxTnBPbWJBdFR5Q2FUUUNibWdFQ2hreTFpWW4zdHhNeDlk?=
 =?utf-8?B?Qm9BWFdueDB5emM0LzBJOFh3cFRiUDlWZzdLZVJMNXdmYWhIYUdUVHBGSjBE?=
 =?utf-8?B?RzRleVZyazRoemFkME5RaGY5Q1d6SFZZbnNTNlk2OTAxNXpvemRxWnUwYlMz?=
 =?utf-8?B?ZmNvZDdkRFdsVUl1MERtZndYQXA4eFFROTExQzBza2VwRWNxTVl4OHozbWRY?=
 =?utf-8?B?Wk5Ncng0YkFKRktrcmErN1psSHhMeW01aTJUK3F1OWlpalV2Vmlod3RTU2cz?=
 =?utf-8?B?Mkk3dmc2YVhMNnlJenNoVFpoMWlPRWVuVTdjR3FUOU13VGdWNlh6bEY1SUNN?=
 =?utf-8?B?WkNjcUs1NUw0SWUrZ2RDSzA1bkVFSkRxR0REdHhjMUcrT2lkcHc5dUJuWFc0?=
 =?utf-8?B?Z1loamlaaHczMktTMnozcDRreVRZL2QyYnBDS1JqY25zSmwxL3ZSeFFpZFpT?=
 =?utf-8?B?RWFKZWd0V3VkWHFuK1pqUEhxUFUrWU5PbzVHQ3ZXelFJcHI3MEhTWkFGMTdP?=
 =?utf-8?B?bG9rLzBSSUpGWVkwTkc4ZG9EV3RDMGVpVk1RSlB2aGkxd004UklQdzBrYnRW?=
 =?utf-8?B?dXJoZVUxcnVqUWlxTkpmM212Tzk2L1pCN0V1SmY4cXhDTGxBWjEyd0prY3FR?=
 =?utf-8?B?MDZNcEZMMmFIdUdyVXZhSXBTQXpIK2kvUUxQWDk4a3BYaUY4eHF4bXFoSGVa?=
 =?utf-8?B?SVFJT09ZS252cExSZ091QW5vYUJNd2hNanY5YUVNUVVmbnE4SThpeWd1VUdO?=
 =?utf-8?B?aUpCSDdSOUhpTStacFVzMXE0UjFONWdScFdBaVd0cUtXU3I0dElXdEw3WWpt?=
 =?utf-8?B?MnFxYUp4Z0V4R2M0U2diRGZDb0ViZ3I4b0hPOWlSQlJ5WEg0SzRDbTc5aElY?=
 =?utf-8?B?MUZ0U1Y1dy94Q1pXTlA2UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVkzb2VBZkFLT3NmM043czBjbE8xV3F0L1k3RXJhQmJGakU3U0o1eW5oRjEy?=
 =?utf-8?B?UE5wV09id1hJMWx3VStMTmR1S3dLQkh0VzFzUDduN3MyODdCc20vbVQzSmp3?=
 =?utf-8?B?Sld2cjlmWEZvVlRSazYwUzl0eFlhaTRieVF1eWUrTExwU1JZdDlFYkxQajhD?=
 =?utf-8?B?L2RTRE1Cbyt5bVJwcFhvMWhYZEJJdVlpVmxjS1BiL0VjWTlQSCtQRzh3ZXpp?=
 =?utf-8?B?TGZLaHRmb2ZOb1hRKy9HcllwSHAvRzg5VjdtZnRqb3g2eENsSDJSQjJvc0I3?=
 =?utf-8?B?Z1NBNUJRNUdFR2V2ZTBnVHFnNXk2aEtvUEdXZmVpSWNyc1VaYjlsR3M2UlpG?=
 =?utf-8?B?ZnhGbWlrdUd5NGdsUVdzV1Y4Q0V6a25mM0JVQkl2TjNPbjVwQ3BialhVd3JE?=
 =?utf-8?B?UWhETTJEQng3cGhhZFdWRzVxVmRVcXllaWJGa29tWW5qa1E4NEFzVjRVelVa?=
 =?utf-8?B?dUZqVnJ1ZUNIeXduNlpBMjZKVk1GbmhPY3lZVWRPMjIwa2Y4NkRERGtnQ2lq?=
 =?utf-8?B?UFc4T1AwZ2tTV0xXNEozSmJGQVZYMENNc3liaUZMNk5rWjArWUQzdVZ3aTJU?=
 =?utf-8?B?aXY5Nm9CejhFZ3lIaFJZd0tXYmZYemlIS0xadDNKcU5HRHpzc2ZJN0RxWXVM?=
 =?utf-8?B?MUxzZFE0THlIL3JvQXR2QStJZWN5RmtYNmhHL1dCYXl1bXI3NmhQRWlrSHNY?=
 =?utf-8?B?MC9WMmtZZk8zeHhmRVBPUFZrUDNIM20zUnd1L0pkYml5TzFLdzEvYzZ0UzFV?=
 =?utf-8?B?Z0FteGV4UFlHb0g1Uy9hb3FyWWM2S21kaysvU285NkRGTCtZSmVRVUdRTDhU?=
 =?utf-8?B?cmtzakpCV3RseWxLczZIVFI4bWszcGtwZGdobCt6RUpyM1E5ZHJlZ0wyVjlq?=
 =?utf-8?B?cjFoNzdVY29IYTUxU1cxTjBoSmthYnN3SVlaN29hbGlVMGpPTEFabUEyS0Ex?=
 =?utf-8?B?RDFnQ21qZVYwaHZ5Tzh5NEdyTGoxZkppeFIwSTJjTU5IbGRIYU1kNlovcW9R?=
 =?utf-8?B?dUxtdUwvclIvL2NTeGhaYUllaDdUeUlBa0hISTd0N3JDSStKMjQ3QjdEVG1S?=
 =?utf-8?B?bm0zOU0waDZhL2x1VXl2ZmlCR3Foa0VEa3lyeEh3LzhSakxoQ01GNDdnT1Fo?=
 =?utf-8?B?N2F2SnRuTm9OazNkckpkWmc2a282VDA2akQvLzQ0OG0xUVZyL0pCVHZWNXJN?=
 =?utf-8?B?eU5TWWtvaytBZ0cwWkNxYlNXVXc5TGxsSFR3U21TdVZ6Nm80NmtWaElESUZI?=
 =?utf-8?B?dmpqeGhFTFAyTjhNRWl6Z0UzY2Zpbzc5dy9WRm84eHdHdnRJa0s3VHZ6bW0v?=
 =?utf-8?B?czFRc3IyK3VNNC9JYVV0bVZtOXJEMFExWUtwQnhrRmFGRFloa0xQdUJNaWFk?=
 =?utf-8?B?akFSbUNLd3p6N0YvaVlaSHU3a01xR3F4R0hsN1dQRlpIT1RMbmFKS1Y0Z2FI?=
 =?utf-8?B?MWNMdDg0aE1Zb3Q2TnZXbUx5dFVrc2VvTHJhRm5ZS0J3aDhjZEZuZG41WU9C?=
 =?utf-8?B?YnE5R0V2R2cwQjY2Rk5iNUVGRlVVcndNNWlqNzBKMW8wbUlMYmtxUVluQlU2?=
 =?utf-8?B?RDBUUmVZVGZhNFpSSU5uQjRKandERHZqUUtrZnN2K2JHWlRiRXhXY0ZjWm56?=
 =?utf-8?B?Z1FYS295VFk1Tkk5eG5NWDQzZWE1UjEyMWhGb1ZFVUFjNmZqRURGMGNUcE5o?=
 =?utf-8?B?SFZPOVZNc3NNcTlNUEs4bHpGbUpBZFRIV1ZSbFY1VTZGeEh0c3V5NjhWaHNK?=
 =?utf-8?B?a0JyMUluZGdoRExtN01vWXpiN3RnV1BJaEdUWHdBMjhhS1ViVmI1OHhFUElP?=
 =?utf-8?B?N0FTZHRYNjgzSmFyYWRkSjVZR0tJRjhqcGNwQ1RNUjVpM05CSC9yNnFlVjlY?=
 =?utf-8?B?bUNNVGhuOGl2ZXZYNW9id2UxMWxrcmZZd2huQ1g1bVNQdVh5enNiR1BSU0p4?=
 =?utf-8?B?NjFDdGtRK2xXWGxIZ1FqaUdrNFRoemdPRDJ3SUhES2JlY3B2MFlsTWEvWlFx?=
 =?utf-8?B?M1I3TkNwM2dUNFhiR25GZklXa25MWGkzV3dqQ0FoalB2b0dxWmZZYUhQc1p5?=
 =?utf-8?B?SFNGVjhlWnVrT3NZQXZTd2JPelJtZjNxUVVrNVQzZm5OM1JNWEE5YTdZcEtH?=
 =?utf-8?B?T2YxZHg5VE8vTE5lL0ltbVZ1N2pkRURpRHdGQjcwY3N6NUxtQ2ZLRDU3eStz?=
 =?utf-8?B?UEE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a1292ff5-8d48-4e36-7f35-08dd56577cce
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 11:19:51.4256 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VGZxGAorEq6hBixgD+WKpjUO+5PNA0XFNlKEYS6zPBRLDoc5ztiS01OrItG06OVoJH1XirHH8lTc9CG/1itQyFC4y/a1JTfW/QOruEpHeEg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR04MB11179
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

Hi Tom,

On 2/25/25 5:13 PM, Tom Rini wrote:
> On Tue, Feb 25, 2025 at 12:29:29PM +0100, Heiko Schocher wrote:
>> Hello Quentin,
>>
>> On 25.02.25 12:13, Quentin Schulz wrote:
>>> Hi Heiko,
>>>
>>> On 2/25/25 10:49 AM, Heiko Schocher wrote:
>>>> Tom reported the following covervity scan error:
>>>>
>>>> *** CID 542488:  Control flow issues  (NO_EFFECT)
>>>> /drivers/led/led-uclass.c: 277 in led_get_function_name()
>>>> 271                     return uc_plat->label;
>>>> 272
>>>> 273             /* Now try to detect function label name */
>>>> 274             func = dev_read_string(dev, "function");
>>>> 275             cp = dev_read_u32(dev, "color", &color);
>>>> 276             // prevent coverity scan error CID 541279: (TAINTED_SCALAR)
>>>>>>>       CID 542488:  Control flow issues  (NO_EFFECT)
>>>>>>>       This less-than-zero comparison of an unsigned value is never true.
>>>> "color < 0U".
>>>> 277             if (color < LED_COLOR_ID_WHITE || color >= LED_COLOR_ID_MAX)
>>>> 278                     cp = -EINVAL;
>>>> 279
>>>>
>>>> see:
>>>> https://lists.denx.de/pipermail/u-boot/2025-February/581567.html
>>>>
>>>> Fix it.
>>>>
>>>> Signed-off-by: Heiko Schocher <hs@denx.de>
>>>>
>>>> ---
>>>> Azure build:
>>>> https://dev.azure.com/hs0298/hs/_build/results?buildId=171&view=results
>>>>
>>>>    drivers/led/led-uclass.c                       | 2 +-
>>>>    dts/upstream/include/dt-bindings/leds/common.h | 5 ++++-
>>>
>>> NACK. We don't modify files in dts/upstream as they are directly
>>> imported from devicetree-rebasing tree and would either be replaced
>>> during next update or induce a merge conflict.
>>
>> Ah, yes, indeed!
>>
>>>>    2 files changed, 5 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/led/led-uclass.c b/drivers/led/led-uclass.c
>>>> index 22f61d12d38..e2edcc43f30 100644
>>>> --- a/drivers/led/led-uclass.c
>>>> +++ b/drivers/led/led-uclass.c
>>>> @@ -274,7 +274,7 @@ static const char *led_get_function_name(struct udevice *dev)
>>>>        func = dev_read_string(dev, "function");
>>>>        cp = dev_read_u32(dev, "color", &color);
>>>>        // prevent coverity scan error CID 541279: (TAINTED_SCALAR)
>>>> -    if (color < LED_COLOR_ID_WHITE || color >= LED_COLOR_ID_MAX)
>>>> +    if (color >= LED_COLOR_ID_MAX)
>>>>            cp = -EINVAL;
>>>>        if (cp == 0 || func) {
>>>> diff --git a/dts/upstream/include/dt-bindings/leds/common.h
>>>> b/dts/upstream/include/dt-bindings/leds/common.h
>>>> index 4f017bea012..9e5ac5196e2 100644
>>>> --- a/dts/upstream/include/dt-bindings/leds/common.h
>>>> +++ b/dts/upstream/include/dt-bindings/leds/common.h
>>>> @@ -21,7 +21,10 @@
>>>>    #define LEDS_BOOST_ADAPTIVE    1
>>>>    #define LEDS_BOOST_FIXED    2
>>>> -/* Standard LED colors */
>>>> +/*
>>>> + * Standard LED colors, LED_COLOR_ID_WHITE must be the
>>>> + * first one and start with value 0
>>>> + */
>>>
>>> Can you explain why white needs to be the first AND be 0?
>>>
>>> I don't know enough about the C standard or compilers in general to know
>>> what happens if the indices in led_colors aren't in order but I guess
>>> that's where your limitation comes from?
>>>
>>> e.g.
>>>
>>>     static const char * const led_colors[LED_COLOR_ID_MAX] = {
>>>             [LED_COLOR_ID_WHITE] = "white",
>>>             [LED_COLOR_ID_RED] = "red",
>>>             [LED_COLOR_ID_GREEN] = "green",
>>>             [LED_COLOR_ID_BLUE] = "blue",
>>>             [LED_COLOR_ID_AMBER] = "amber",
>>>             [LED_COLOR_ID_VIOLET] = "violet",
>>>             [LED_COLOR_ID_YELLOW] = "yellow",
>>>             [LED_COLOR_ID_IR] = "ir",
>>>             [LED_COLOR_ID_MULTI] = "multicolor",
>>>             [LED_COLOR_ID_RGB] = "rgb",
>>>             [LED_COLOR_ID_PURPLE] = "purple",
>>>             [LED_COLOR_ID_ORANGE] = "orange",
>>>             [LED_COLOR_ID_PINK] = "pink",
>>>             [LED_COLOR_ID_CYAN] = "cyan",
>>>             [LED_COLOR_ID_LIME] = "lime",
>>>     };
>>>
>>> is ordered, but what happens if you have e.g.:
>>>
>>>     static const char * const led_colors[LED_COLOR_ID_MAX] = {
>>>             [LED_COLOR_ID_RED] = "red",
>>>             [LED_COLOR_ID_WHITE] = "white",
>>>             [LED_COLOR_ID_GREEN] = "green",
>>>             [LED_COLOR_ID_BLUE] = "blue",
>>>             [LED_COLOR_ID_AMBER] = "amber",
>>>             [LED_COLOR_ID_VIOLET] = "violet",
>>>             [LED_COLOR_ID_YELLOW] = "yellow",
>>>             [LED_COLOR_ID_IR] = "ir",
>>>             [LED_COLOR_ID_MULTI] = "multicolor",
>>>             [LED_COLOR_ID_RGB] = "rgb",
>>>             [LED_COLOR_ID_PURPLE] = "purple",
>>>             [LED_COLOR_ID_ORANGE] = "orange",
>>>             [LED_COLOR_ID_PINK] = "pink",
>>>             [LED_COLOR_ID_CYAN] = "cyan",
>>>             [LED_COLOR_ID_LIME] = "lime",
>>>     };
>>>
>>> ? I think it should be just fine?
>>
>> Yep, fully fine, so I drop simply this comment.
>>
>>> Reading the code, it seems there's an assumption that led_colors has a
>>> contiguous and full list of indices from LED_COLOR_ID "enum". What
>>> happens when the dt-binding gets extended with new colors and the DT
>>> makes use of it without updating led_colors in led-uclass.c? Aren't we
>>> going to try to print a NULL string?
>>>
>>> If that's the case, I see two solutions:
>>> - ignore LED colors when they aren't in led_colors,
>>> - decouple LED_COLOR_ID_MAX from the binding with UBOOT_LED_COLOR_ID_MAX
>>> which is the currently supported max based on led_colors last index
>>> (+1). We could even do a #warn or #error so that UBOOT_LED_COLOR_ID_MAX
>>> and LED_COLOR_ID_MAX are the same value so that we're forced to keep
>>> them in sync, but that'll make Tom's life harder when merging newer
>>> releases of devicetree-rebasing tree.
>>
>> Yep... may Tom can comment here, what he prefers, thanks for the review!
> 
> We should just expand the comment in the uclass when checking to note
> that we don't need to check the lower bound, only upper bound due to
> typing.
> 

My point was rather about dt-binding updates to LED_COLOR_ID_MAX. The 
code currently assumes we always have an entry in led_colors for all 
values between 0 and LED_COLOR_ID_MAX. But that may change if there are 
new values added in the kernel and we don't update led-uclass.c (e.g. 
the new LED_COLOR_ID_MAX is bigger than the current one, so there are 
NULL entries now in the array).

I've tested by removing the AMBER entry and then I have the following in 
the CLI:

=> led list
<NULL>:heartbeat <inactive>
blue:sd         <inactive>
=> led <NULL>:heartbeat
LED '<NULL>:heartbeat': off
=> led <NULL>:heartbeat on

so it seems "safe" wrt having a NULL led_colors[color]. If we have more 
than one non-existing entry in led_colors array with the same function, 
I assume only the first one will be addressed.

Cheers,
Quentin
