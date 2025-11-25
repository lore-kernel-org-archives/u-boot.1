Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A609ED0E6EC
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 15:35:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2598783F89;
	Tue, 25 Nov 2025 16:35:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Q/F5Ep2k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A492840CA; Tue, 25 Nov 2025 16:35:49 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F415E83F75
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 16:35:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AWsa/Kpz3EgL9wLjsTxIzXSuRUHnDoYpwplrWBRqLROZzh00SfUHrqzND6gMOKAYzlKeDcYL61aUnEr3CXKK9DuMgawYdZ6WbXxweGUm4auMFUERKg8+5Ks9aWs56m2X1N9SQhsihp0Uv0WXt4Qd90UR+bY+m/qERafgzsM59JzPEo3MchN9Y21Du3u4LWJud+st2cyvknhuZ5YYcrfY6YHWsFCIzjAoMRFOa456g4Y4gATzwcjzkaWRX/xYYA4AgS3+s7/iLGwnsWA1zuRyQKnmRHkbvJhYmJ84K99qP30bnWJNSzSlsYncqOAyrgADrhK7QWmBv7ogb9uRthmZag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UGR4LFpVR5skKgiWPmna2Jb8AQaSfojsmOWE0IqCVYw=;
 b=VsR1owk/z884/oUJksJbSlgvpS8dHX75DtePZX2q9lEXC/bqBWc1DY9QBp7UMY0D8wd4wIqsfZ34niAEc7dAgVY+JVHIsBTMSNK65F7oxrjjT5KGf6W3YAh+Vj6kp61PKQUKUrblWm52ksfMWVLwNg7UwR4fZcVTsakJcgVHLJKCM2VYIKwiKreTR82fCtaUQBuNado0BrMqUSZd18kUIDvssFEagjWSwoyFJ5I6ztE39wPd8BGH8aZTcRw4cLNgZL3b+2ht/bkIZJ3huqjCCE7/OCMkdZwIp5FmAjdmvOT/NjqXq7by0WJfqp7j/N6xJFaCyOllTwbzMbC+1fPfDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UGR4LFpVR5skKgiWPmna2Jb8AQaSfojsmOWE0IqCVYw=;
 b=Q/F5Ep2kRhQ7CN/zaLKfOjnjWkWwNmsZA922kjCwsX0lrcGCsJHT5oROeemldMb7EmeTeRnH0uliRT0qIJU1BKc9CP7gUbiqCxJErvuqsJ2t3hrSy8yXK/lDicN5iSCNTNfkii/MVU1wzIYCGanL6AjdaYF0A0AKzrkE4ack3OQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by PA1PR04MB10504.eurprd04.prod.outlook.com (2603:10a6:102:444::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Tue, 25 Nov
 2025 15:35:45 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 15:35:44 +0000
Message-ID: <05987960-b2fa-4798-9504-78aab483e146@cherry.de>
Date: Tue, 25 Nov 2025 16:35:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] SDRAM Calibration Failed fix for GEN5 SoCFPGA
To: Brian Sune <briansune@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20251125123847.307-1-briansune@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251125123847.307-1-briansune@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0026.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::22) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|PA1PR04MB10504:EE_
X-MS-Office365-Filtering-Correlation-Id: 8afa44d6-0702-4066-e13c-08de2c384c7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|1800799024|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cUllcUZYcWhhaC8yRVZMaEZTZm1objMyTXVwSHBPMnhXS1FUdUVFYXNsQndx?=
 =?utf-8?B?WjhzTytJdnZQQ3VOaWp5bkFOa3FjUkhKancvTm9PVlp0UXlCL2tTVXpud1Rj?=
 =?utf-8?B?WDVEYUFtTFI2VDBTQnZnN2lQdnZCMjZubzZGQ0Q4eWIwQUdKQjllcHNnRGxX?=
 =?utf-8?B?QnBnRW54bXNrTzhaTFJxNDlwcjg0NEh2K3BmZjRsNFZUR0MwbCtSUG0zWU5X?=
 =?utf-8?B?K2VKSnFrYjRiQ1lqYzBEdHhYUDB6cXdjdUcwOTV5UCtCZk1NUGJscWNWRncx?=
 =?utf-8?B?UEtaSWNVeSsvM2t5d0k0RGtqYUdEclN6WVI0Y1ovRmN4eFI1c3RmT0xaRmtn?=
 =?utf-8?B?UW9RUmJwUkFCL3JqN1dCNFdiQ1AwUVBvckR5d3V5NjJ2a0UwSlNva2w2NWlO?=
 =?utf-8?B?V2NxbnhsR05Ya2VtZG9YL0loZ2xGbkZINExQVkRZYmJqaGJ4QlByQ3dvSXR3?=
 =?utf-8?B?N0hBNGFmWkRoSFJzNFFlcnZnLy8zSUkydGxMZ2NWR0Z1T2lNbzRrR0x2aDBV?=
 =?utf-8?B?NlN4Wk1hMXBtZy9CSi9UVGlIUCtHNzdlRzlPWWVhR3Z2WlJWMXVRNHV4Kzh0?=
 =?utf-8?B?YjJ5bVc5cnRGa2NrRzdURnhEQ0J6ZVR5N3Z4WGdhODZJNllyK0c1b2MvQUVO?=
 =?utf-8?B?a3BXbUM4TkREWGhmL1JOU1pFVjlnVHk0SXJycUtEZlplS0l3U0FCemhIWXpZ?=
 =?utf-8?B?RHR4RjlpUnN3aThWS0VYMlpiVWYvcElmenk1UWVidlhaeURnTkdGTTJyMWJM?=
 =?utf-8?B?czk5Rlp3SCs1UGd1M2VmUVJMMWx6aTlDd0ppNnBYR2hraFRpTkdsaFdyNE9h?=
 =?utf-8?B?aS9qSmFyK3hyZE5YRU5DeUhGWFp1Mk1lMlBJUloxaUp5aVlHNFJsMnhlM1U5?=
 =?utf-8?B?MjB3QTRkVFo4cndsRnhmU2p5QXJHODcxQ1lVSjh2ZjRVZjRqWHlsNDJ0U1ZZ?=
 =?utf-8?B?dkpVbjZKRG42cTlpaGluSWtOSWttUy9jelZZazB2QVFvN1g4ZEEzSnY3WXlT?=
 =?utf-8?B?dU1TUkJTK1dWTTdJdVdoN3RHYS81Zjc0NzNMT09SUW50Tk9zL0UyWitPS2Yy?=
 =?utf-8?B?QmFrYmYwek8wT01mdXAzaFkxN0srYTJ3TzNIZ3RGZFVubm1ET2FqVmUrdGhN?=
 =?utf-8?B?UnRLek5JZkZHV3lOTWpXSWF5djM1QVBYWDJZUnpvdmc2K3pSREJSV1BTeXdJ?=
 =?utf-8?B?Z3RSaytlZ3ZiOGlydm43MlZmNXdZN05WZHIzRUROc1djSTBLWEFlT056c3Zr?=
 =?utf-8?B?c1VXc09zeDNvU2tidXlrZkJweDdPR1Q3ZDhQT3MyejNybE5KYzFoVjJ3bDFp?=
 =?utf-8?B?OW8wZzNRQ3QxN3dabDZNU1RqZm81amRRTWlyRmpXQkdiSmltc21XZVhKamlu?=
 =?utf-8?B?cHE5YnlveDd3NDBRZzl4WU5XUzIxQXNDWXRHL3U0bDVpbXhVM3FXaVN4K2k4?=
 =?utf-8?B?Qjlrang4T3ZwUmpGTnV2ZnpueE1Dc0lQSEUvdnZrTExkOGs3RGlLUTRNbDc1?=
 =?utf-8?B?QWxDUjV4ZWN6STJ1RFNteVROUHJnMGVKK2FMMnNJZG44UnE3aU92MjBXR3JT?=
 =?utf-8?B?RmkwOWpYbW5JcGNSaFJlZEhGNkdhbm1sdzEvTDhoOTdvL0RBU3lMelo1T2R5?=
 =?utf-8?B?aFdmZ0VZb0JRaklNYXpiNjU2VG9sQnJhWUVYMDZMUzJVNE4xeHBEcG1KWldm?=
 =?utf-8?B?bG9CdHIyT1Rmakora2syZHl2Nk9GaTVoejB2LzB1RjlBbXlBN0NEaUZWSGdL?=
 =?utf-8?B?aGNkZjc1TnRiYkxhYjlMYThYQU5jOE1IamdKUzNXRi9NcFNWdnRaclpkOGQ5?=
 =?utf-8?B?WEk0Y0pMVWpTVTc3TmpGbERYQUZqaUJWNnh5QkVMUDFySlFidFl0ckNERG5Z?=
 =?utf-8?B?cTdRbjdxWUpBRmRlT1FWNVVKeHlLVVlMVC9wdUk3eG9xeXF6NVBoWWpKQWtY?=
 =?utf-8?Q?ucVqpTakMBD1JydxQu4HORG04aZJffMG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHNKNllicnQ2TGdzSVNlT2RFNlB1MlZaK1Jjank1TVF5NkszOXVDeGxETlYz?=
 =?utf-8?B?LzBNbks4bDcrcTd4V1lzY1MwdDQ3UFZ0ckNYeWdDYVArS2ZZdjc2K1NEdEtP?=
 =?utf-8?B?d3FyQVVXQzF3VFFiVVFjMlJqOGUyakp2ckRNZU5DdDkwbDNuVTVFRlAxWTE0?=
 =?utf-8?B?dDZ4aFNqRG41M2JQV2FnQ3ByaGNGdU55V283MVlQTGZNcldUMi9QWG9vUVI5?=
 =?utf-8?B?K3dnSytDZmUwQ0R0a3h3eXRONE1WNDIyTlBIYTU0Y0E4U1d3Yzg5eFZyYzdi?=
 =?utf-8?B?UUJpUDY0SGhYWjlVU2pOaXlaRldEMXBrRE92V2p0Y3VLbVZsdTY2NnJqd1VL?=
 =?utf-8?B?NXl6aWMrc09YZHY4RzVRVGRtYytMZjhPNU5nMmVkdFBLUEhDTksxeEhKRjlT?=
 =?utf-8?B?ZWIvaDdiMmRuNVFXZEs3cXV2UENKeFlxZ0FpamxWVTZERXdNanBCNFYwcVl4?=
 =?utf-8?B?ZitVYy9jMytqTE42NGJTc1hoV2l2ZmFZaW5nOHBIT280U3E1Rm1FVDMrbnVt?=
 =?utf-8?B?UVNzOE9NM2M0SUo2Ly9reUl2bGYvMDJKanIxTE1WQVZDcW5BenV4OWUySkRH?=
 =?utf-8?B?YjhLMk9xQTJZd1Z5cWZjejdxWW5ITlNpaDAwbFkvN015S01DWnAxckM1T0hU?=
 =?utf-8?B?MVNVS2x1cHB0Zk0xSEh1VjU1Z0hEMVRkK0lid3RoZjJjZXZmWEE3UWhYVEh3?=
 =?utf-8?B?RnVOSFVEVzkxcGtBcUcvRWhOV2c4VWw2QXhVaEUwWFQyWlJmaWsrVVJyNjhl?=
 =?utf-8?B?VXdWSmlobTlLa1ZNUzhBempOekhiTVRNNzhQTk9TenBGaE04VnNwL0VKUnow?=
 =?utf-8?B?OGhBNkZkVEoybDFRbGhGbXFEUXo2OThBc0pCdkpCVTBwR0k5S3BEWUxROURC?=
 =?utf-8?B?K2xBVVNuTWZ3QmU4L1BSZ0JDQWMrb2JMWU5odDFzU2VIRFJOWEh6cWJ6dzBl?=
 =?utf-8?B?bEJsNkY5UDZoeU9nWklUanBCY21kcU80L205UGg5cHVLOEdNVVJTV09vMS9W?=
 =?utf-8?B?dmJLbFFMYW9pVmQxY3RHd2F5b3Q2L0lBM3NWMEp6K3ZnYmw5emZKNGgwTWZL?=
 =?utf-8?B?SFlZLzV6Q3JLWFdhdVBGWWMzVGk2UVMwODk0bmo5NmVkQ0pZblZKVCt1RGp5?=
 =?utf-8?B?SE1oWXlPcDF2WkdTbTlGQml2WWRKODhQMmkyQjFML3pTWjJZUzlCdlNXRUE4?=
 =?utf-8?B?WWF1Vmk0OEEvRFVQcEJSUVRiS1hNNFRPZEphOERvd1VSY1VkSjNEby9tcWd2?=
 =?utf-8?B?aUZ2UzlLWDF2T3BiQTF3aVI0b2JsaERuVE1waDBlS2xUenVRRXp6cC9SejVV?=
 =?utf-8?B?ZnJkM3U3djB5TWZ3Y0t0Zmt3SG9zaDVOUitTeWpibURSbVlhbUEweHRXenUx?=
 =?utf-8?B?WVBxZGhLKzZCTEhodVFQZm1ralpNSUdoWGhEUE5SbWp3WXAwTThSWUU4YmVK?=
 =?utf-8?B?OVZCdCthVEJkcFVqS0VzTmVmRzlQSWpCN1BHMG4xNlZpN3ZCK1YvZWF2Sk1F?=
 =?utf-8?B?bTlDWVVjUDQvNFBGeXNvdVc4cFA0OEtXTHh6K3BHVmZEcWdJVXdVcTJCTFM1?=
 =?utf-8?B?MFBmWS9ZK0JSYTB6SmVTRVQyRVFpaFhLWW1ZcFlCQVpiMnpablJiUlI1YUIr?=
 =?utf-8?B?cnJvQ1dMT2wwaGp3cVBZVzdIS2d1YXZKc0QzTG42T2tCZFRTYnlYeUh2YTlF?=
 =?utf-8?B?MHkwZXRudnZPYVhOcDV2emFweUJ1ZE8vQ2lvQUtsL0VxUzRJcFJ1cStwQ0t6?=
 =?utf-8?B?SDJYK1piOFRmNDg0R2h4UitlSjRkZzZyV2xJTEwvTS90ZXh2bENITUVHb0ht?=
 =?utf-8?B?aHpkK2lKcVVYemMvOVhVNmhjbHFEamR2eVRweXZWZlI5UFVZeVQvQTFscXFC?=
 =?utf-8?B?WFNHditXZXdHdHVEcWd5aUZEWCt2aXFGUDlPZXpGV01HcHY2NU53WmhuOCtH?=
 =?utf-8?B?b21YLzBoTWdaejlwb3h4TFBXK0Rrb3hXS0ZDN0h4QytLYzJ5Y3NjZXZnb1l5?=
 =?utf-8?B?eEZEejZjRm9BTjlVUHNBZlhvTXhOcy8rbUl0MWxtSzRyR1AvTWFURzRtb0dH?=
 =?utf-8?B?UmlCRTFxMFprVXZKV2NUTVZEcjdKTnI1MU85L05pQlduSTNtU3VGTU5VaHhQ?=
 =?utf-8?B?bDZrSzhYNmdnU3BqREU3NnZPMVZ4L2txZlFvWm40UVpieEtLLzR1UDVYUW10?=
 =?utf-8?Q?SjJhGzBs3IDSTXmaNm9v4P0=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8afa44d6-0702-4066-e13c-08de2c384c7b
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 15:35:44.7110 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nbhQ6rJHMHzYdzBGA6AlUbB3xXI8NTyRHeREGe8wbfvNBoPTw9TkThnzllhaXW7WFa2HbdOZPMQ4J7qM9FjGYYVR4aLMc35Ui0wttZ81Xts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10504
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

Hi Brian,

On 11/25/25 1:38 PM, Brian Sune wrote:
> New SPL introduce cyclic and without initial
> the interrupt of SDRAM calibration could fail.

Are you even sure SPL_CYCLIC is required? Wouldn't enabling CYCLIC be 
enough?

Since you have not identified the root issue yet, can you please provide 
the actual defconfig used before this change so we can figure out what 
is happening, if other boards are impacted and how to fix it properly so 
this possible misconfiguration cannot happen anymore?

> Initialize the default CYCLIC setup fix it.
> 
> Signed-off-by: Brian Sune <briansune@gmail.com>
> ---
>   arch/arm/mach-socfpga/Kconfig | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
> index f2e959b5662..a06b677787d 100644
> --- a/arch/arm/mach-socfpga/Kconfig
> +++ b/arch/arm/mach-socfpga/Kconfig
> @@ -117,6 +117,9 @@ config TARGET_SOCFPGA_CYCLONE5
>   
>   config TARGET_SOCFPGA_GEN5
>   	bool
> +	select CMD_CYCLIC

I don't think you **need** a U-Boot command to be available to unbreak 
your device?

Cheers,
Quentin
