Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A37D3C25B75
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 08:39:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F27C4886E8;
	Tue, 21 May 2024 10:38:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="MYga9eer";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E40DA886E8; Tue, 21 May 2024 10:38:58 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85F7F886E8
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 10:38:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KhLhQKv2fr49FQl6MQatrPzPtUC94rouoWjoLSVzfDik7ujKmT4AMLurkT/zoR91sc1HpUWqOKV4hGu45usVdozqobqUmRD11Mo7/TNzEMCjdKgLauwLyhPoknSeeR4VQt81rr9bacMv3fcpxBoyvTmxO/h/4gmZAhi0e1rwgmFxZxg7cZjtpv3GZTCm3WaMmFt/2jUbAXbHIYow6bl2YSN43qZxkVB+qRNfoJd1sP6WgLe64pOghSw43Sgbr9IqMhfVBdYpAWXn5gXt3vUgMDa6h2VNuKcPHnlJbO/4fZuSqyaiNtaPZBZClk/436pOiv5ymbCoabav3+P3g4xDog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gv0bWClrBr6R4qiBwTSYqJuAp2sZyic9Bgnv8px4Wa0=;
 b=FQDSrdUZWo4oNKxMK1GTDoQVaMXnfgUl1zIIBz3HFsW5t5I7Gl9OlyigFNubAZtD4VH5SMeFSMpDJvkTxn/G5XUy0q6W/qXy4tfjhxHoYmHOb92KqIQHh+d73NiUxxcDPVHWyUp0AFGtH1OamReCCNs6jZYKOhjAQcWIqmd7xvLQguk22UDmzCvR7CmBy5cnOItKN3Tgu2NpHq3REdCbnaa03zd7c2FP8P0h++3hEcP44pP1lsajPSFNjTOapj7hoXFfbq2o5kdqhKJbvZ2TlvONWdr3FTUn7TXm+leXEquNVVew6uO9kPlpeLNU6NBcXsBq6b1tpERAPpdKThjZXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gv0bWClrBr6R4qiBwTSYqJuAp2sZyic9Bgnv8px4Wa0=;
 b=MYga9eercAvel+3CLr6evoTQK6C1gI/Ofho+IuGKhmO4JOCj/lH9kNoGDkkZv9QKR8cW7NSOCH/0CaMDjABME+NPE28tJF0EN5TSbM7SBcx22JeuqYOsv8HHymNoCGGiIQ8nffzptaBSwXMqRq66IJNajs9S2JSCYtq0W9y/sus=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by GV1PR10MB8519.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d0::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 08:38:53 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.7587.030; Tue, 21 May 2024
 08:38:53 +0000
Message-ID: <b4dd54e5-9653-44eb-a505-1862da7fbee1@prevas.dk>
Date: Tue, 21 May 2024 10:38:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] cyclic: make clients embed a struct cyclic_info in
 their own data structure
To: Stefan Roese <sr@denx.de>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20240516075314.1548051-1-rasmus.villemoes@prevas.dk>
 <20240516075314.1548051-4-rasmus.villemoes@prevas.dk>
 <7f45eeed-4bcd-4a3a-9663-133a20c182f7@denx.de>
 <948d94a1-e97b-460d-8c83-4133eaebd2ff@prevas.dk>
 <4cb6b424-e61e-419a-ba42-53296de13277@denx.de>
Content-Language: en-US, da
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <4cb6b424-e61e-419a-ba42-53296de13277@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0029.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::17) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|GV1PR10MB8519:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cda7020-bc2a-45dc-c39e-08dc797171e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ODUwdk9OYnJiMHZ6eVRrb1lTSC9QQ0I4M3FaVUV0RHlaTzl2cWRMMkQ4Ym9X?=
 =?utf-8?B?MjZGUjhxQitOVjVaQ1BYSHMrTGUwUG1lSU9FN3lHeW5PYXFKK2NpVjBiSzcv?=
 =?utf-8?B?VitqbEYxeVByZm10R1V0YXA2ZW5IdUZBM0d2NDQ0UFhpUHhNUHN0OEdJcHFX?=
 =?utf-8?B?UFkrZTc5U2V0c2h2ZzlyWlpEMDdGdlBTdWdOMWdSb0hNOG13MmhaU3YzVlhN?=
 =?utf-8?B?YUQ4bTJYZXM3T0oyOE1meUthYVBhV1VWdnFRVHhOR0ZaaDlFeDdESllHUXFn?=
 =?utf-8?B?MHpDdy9SUVdCYm8wQ3FpTVpnM1JuY1I0YXRCMmpFMjRJZGR6NVVTVml3SUR5?=
 =?utf-8?B?dUF3RGVYdUV5K3p3VWZOSVh5emdDdkRrcHZ0TFpMTnlyZmc4OGEwTkIyTVJV?=
 =?utf-8?B?bUZTYmZJeERkdk16K3RneG41YXVGV2IxOVpMejVTWVpFL0ZUM0FSeXlrbDZD?=
 =?utf-8?B?VFlZY0IrQzU4Qlc4dHBsbUxKSHVoZFpaZUJLZ2w3ZTU2ZXorZmh4MnpydXNn?=
 =?utf-8?B?VUsyY0luZnA5RDUrSndraUdyc3RtUEpQUWk5c2dTSDBvU0dsQTZrVHVoWEpP?=
 =?utf-8?B?eEFuMURXYXBEMSt0a2h0WERpTVJlNzVzVXBwS3k5TWw5V0hTN2NibzRYQ0lS?=
 =?utf-8?B?NjllN3Jya2paS0ZOMm44Q3ZXRW16b3JZN2FJU1RIZk5aeVJmWGRCUDlqa3hG?=
 =?utf-8?B?QWRxRWZkRHR1NmFpdml2bWRzazlpQSs4eFlvb3hhN2RpbnoxVThGd1RIVTFo?=
 =?utf-8?B?RlA4YmlBR0J0ZzNYRlNXKzV3TGJXdFRlbFZPMjZMMVIrNlZJOTI3QXpuUHhR?=
 =?utf-8?B?VHA1Z3VWOExBbXdmUkt2Q3AyMnNJblAzNjczZ3hOSDh5OU1yQlVyamRxNkRI?=
 =?utf-8?B?dStRNVl6dEVZbU9vWnRtUzVvRlB3SDRhcGdhUnp3N2V2blovcWw5R3NzNGhz?=
 =?utf-8?B?T1NRL2RsRnhHNVNZVGQ1dTBQVW14cWk1c1FudUVyeGlROURuZGwzL0RsbFpl?=
 =?utf-8?B?bnQvN1M1Yk85WmNJSGhHN24zekRTNHpTUTd4UDdaZlUwb3Y0Y2w3bXY2ZlM1?=
 =?utf-8?B?bWk4RlB2RHJyY0xOY2oxMGtrQ0wwanZSNFlOMmtFd3IrNmJ5eDNJNGc3eGNK?=
 =?utf-8?B?NFk1bVFFQ1pvamhMMlB3ejZoVHVpbzJmeFhySUZJdG5RSEg0d294dkVmbEsw?=
 =?utf-8?B?ZE5LaXBhQ0cxTGE3Z004djV4cTh2eGdrOEszV3lMdWw0QWVQWFRqa0h4eWlN?=
 =?utf-8?B?T2hOKytPeHJzVE1CeEhteFl1ME93WDFzaVQvYS95VlBOaFFFMjVYL200M0JO?=
 =?utf-8?B?VGJ6aFB6ckFMK2xGWVpDRmNyVUpxcHRuR2ZYNC9KUXhQVjJxazJDcDBQQmkw?=
 =?utf-8?B?aGtDcTBXWVF0SkFiRGlBNUVTUUFJV1hVRHpETkpwUGFJeW5RcWJGek1RWmRP?=
 =?utf-8?B?Z0pwQlRCNXRxSkRmQTVwOWprd3BCT21XMFZKS0xxSGxBVUU1WjgrSDhTUXRG?=
 =?utf-8?B?dDliK2xncXJlbTdpd0JpRk5hVkdTYXA3L01nOVRoZzh3S3YxRy9xODc5RldE?=
 =?utf-8?B?OGhIeVBUL1M5OWR2UnpzUmw1WXRGSCtVTCtMUyt5SWt3eGpPcXE4TkIreXVh?=
 =?utf-8?Q?lFSKnUJfwe6ecmW+kAYk8P2iV6rj7Fys6saqXSP3eWJ4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVlzSmRnN3U1WHRZbzNweEZtWjBydWNQZjBFNVVrai93R2R0WmE1RTNNejBW?=
 =?utf-8?B?azVhdDVvaXcrbGJoL3lZaWoxWkc5QWtkYStPUWMzbjFDb2FscGYva2NUNXVV?=
 =?utf-8?B?QkpSZmxMZjFHWGYvT2J1M1BXbzR2dmNRWGZYdWJ4WitQT0xUQ09pTFk3elhu?=
 =?utf-8?B?SzRaM0t6YXZIaFBhbktqcHZSSVRINk4zekN6bnNZTWVvb1FDUkg4ZXB4THN4?=
 =?utf-8?B?Tk1seHlteWEwLzZ5ZTJVSFZ5UlptQUEwLzVxM0FQYVJkamp3eGVWZmgvbzE2?=
 =?utf-8?B?K3ZZc2FWc0UzTS9obDNxU1RkNHF5TDJEK0dOZERjVmN6L3RDVitydGZCVlI3?=
 =?utf-8?B?QXlUQVB6NURoQTAxTmRDaGxVRnkzeFpNWnFWSHlRMlV3cllPZG9aNkoxQXRL?=
 =?utf-8?B?cjR5bkJndEQzVHVvNkp2N1E2N054WmRueUhqU1JpZWw5L1JNVXlIL0tDaFlO?=
 =?utf-8?B?MSs2RCtYYVBxUzZTRCtYb2wvYlVHREdlYzlsWVkyUUVIY1Y0djBpVWVHenJZ?=
 =?utf-8?B?M2xUNUJOZDhQTUlkRHE2bmNFOE1BQ0lIU1UxZkIwMnptSDdwZmQvQ0VTd3d3?=
 =?utf-8?B?eFp0T25mWE9JOFpzRXZvVVp3UkhkVm9oUXJPSVhtVlpLQVlFcWVYYlJHUDUv?=
 =?utf-8?B?YlVkZXRtUGNjcThiU05sbmVFRERaT1F1ZHVFcXhYRGZHMnJHYzJkNGdEYk03?=
 =?utf-8?B?b1FOZzl2dzN1YWM5UXFZQzJHb1dWVHlMdnBGdUtDcVlHYTJMbHhEVXJWWmhS?=
 =?utf-8?B?c00vVHZyaHhlZnh3YU9zbUl3cEplWWpTZ29nUk14djVGTS9EckQxUDR6UnQx?=
 =?utf-8?B?emYvanpNR3MxNE1BSVdqSVBWbDUrZlFFM3VnU1VnenRaRVdiOWdQY2pXbUZ1?=
 =?utf-8?B?bjhlcDkvVE1WNE91TGFUTjJRd0hEL2hHVUpnYVNxaEdZQlpKQlBLZWIwazAx?=
 =?utf-8?B?K0YyTU1oSjJKNUtNN21sK0xva3RaQVJXQ3ZuVFdqekNVOGZhbTc3cGk2NGJM?=
 =?utf-8?B?OU8zNVVjeVFIcGRzYm5xdmdtRFUvcmRDNUo3cGZSN1VuNVB1S2tLVkRIejU0?=
 =?utf-8?B?NDRMYVA2N3pRSVpoVzdUUm5kTG9PTzlTZ1FjUUw3L0ZoeXB3Ti85RFdxdjFt?=
 =?utf-8?B?N2lLc00vcjFFNkpia3FMQjY3NDV3d1JyV01lemJTNktWbGxFMHdrdUk3WVFZ?=
 =?utf-8?B?NGV6UEZVdnVjeFB4YTB3cnlIbFBhRFVNZThJMmdRNlBHNS8yUkdqNHpWdno1?=
 =?utf-8?B?eExiRXpGdG1COGxhakNTanpLZlp4RmpGN3JkYWtkcXRjK1lhOTE0enRocHNB?=
 =?utf-8?B?RHU5QkFESmVBaEZwYnExRXl5dGxYa0hTMTVhZHd1S29LQlM2cDBBaC84eWk4?=
 =?utf-8?B?RW9mc21RU2MzMndCWU9FamNEYWF1KzQ4UkI5aDNnS1lRY1dGcjM1ODUvV3BU?=
 =?utf-8?B?MVdGaUJnaVBjdUtBRS9ENk1UeWNLUE41LzEwWC9rMEhubGVDOW5YQkJFS1N1?=
 =?utf-8?B?bThrZUdpUHVWTm1zTk9QVEgvV2tpQmRLd0k3L1FycVJqQUREbW9VR0Vra0hC?=
 =?utf-8?B?b1JPYlJVQWdNT203Unh0NmNvNWYxSnQ5Z2QvL09ER3V1U0p0cXhhV01JSkRi?=
 =?utf-8?B?RGFnbTNNSWRJbHcvTllmKzhqd3NmWSt1M1lDV2hLbXFhZFZZb2I5SzFRTFZD?=
 =?utf-8?B?RVVWOElGcTc0UlpHSi9mR1h2NFVjYkQzWmo4S1liQ0twMndqMDRZMy8rWU9W?=
 =?utf-8?B?bXpiUGlNYzJyZFVOQzNkblVUSjliNnhkYVF3eWJkMTczVDlvOGFTY1A5Z2Q4?=
 =?utf-8?B?UlFIMnVveWlWR3BGdjZCdkJROUFDeWQrVDIwUlhjdEx2MENianNFY0RoaC82?=
 =?utf-8?B?a21VWjVjejVuVkpiMnFWZXJJRlBKUDJtblczR0thTjNaY3F3WjQyYmlIb2o0?=
 =?utf-8?B?YWU5emZzTlZzbDFNQ0lmK2lFVmVrNFhTTG5GUGpmU3YwaHdLV04wSmdwOC90?=
 =?utf-8?B?c250VlhSc2p2eHJYNktCUWNGTjRZR3Z3Y1ZrV1p5NG9iTk5oVm9VcVYzZ0Jr?=
 =?utf-8?B?eWtMTDdUaStJZmcxb3dyM2tuT1Uwc1M3OTltL2M4VGk5a2pVSUNBT2xQdDBV?=
 =?utf-8?B?K1RYcjM0U2NYZS9BY2tscS9NS2IrdEZJVHU2bXFLMHpyWG9xTmw0VWpoYXVl?=
 =?utf-8?B?a1E9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cda7020-bc2a-45dc-c39e-08dc797171e8
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 08:38:53.0493 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kkJb6hqvJ5YUTrApHrNQi/JsHRpEF0UTGs30Fw3hHLfX4pa4iskWsWd1aB1GlSJ25DbUi0HJudk3Bo4XhW7yd0ka1njPAuE6iVDSDz7MO8k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8519
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

On 21/05/2024 08.57, Stefan Roese wrote:
> On 5/19/24 21:44, Rasmus Villemoes wrote:
>> On 18/05/2024 09.34, Stefan Roese wrote:
>>
>>> This introduces some problems when compiling e.g. sandbox:
>>>
>>> In file included from test/common/cyclic.c:10:
>>> test/common/cyclic.c: In function ‘dm_test_cyclic_running’:
>>> test/common/cyclic.c:25:42: warning: passing argument 1 of
>>> ‘cyclic_register’ from incompatible pointer type
>>> [-Wincompatible-pointer-types]
>>>     25 |         ut_assertnonnull(cyclic_register(cyclic_test, 10 *
>>> 1000,
>>> "cyclic_demo",
>>>        |                                          ^~~~~~~~~~~
>>>        |                                          |
>>>        |                                          void (*)(void *)
>>> include/test/ut.h:298:29: note: in definition of macro
>>> ‘ut_assertnonnull’
>> [...]
>>>
>>> Could you please also change the test file accordingly? I'll then
>>> try to get this upstream shortly.
>>
>> Whoops, I don't know how I managed to miss that when grepping for users.
>> Sorry about that. Updated version coming shortly.
> 
> Thanks. Still the new version also fails in the CI build. I'm using
> MS Azure for this, here the link to the failing build:
> 
> https://dev.azure.com/sr0718/u-boot/_build/results?buildId=355&view=results

Apparently I'm blind, the full definition of 'struct cyclic_info' was
not guarded by CONFIG_CYCLIC.

> Could you please make sure that CI fully builds?

Is there a way I can trigger that from my side without sending patches?

> BTW: Not sure if I still can pull this (updated version) in, since I'm
> leaving for a 2 week vacation tomorrow morning.

NP, I should have been more careful. I'll send an updated version in a
moment anyway.

Rasmus

