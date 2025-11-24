Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA68CFA466
	for <u-boot@archiver.kernel.org>; Mon, 24 Nov 2025 12:32:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 538FE83D92;
	Mon, 24 Nov 2025 13:32:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Up2d1Zei";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3F6E83D9C; Mon, 24 Nov 2025 13:32:51 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3953183BEF
 for <U-Boot@lists.denx.de>; Mon, 24 Nov 2025 13:32:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BCP4TxHaZaVv9vPaMPTtiB2DITaxpeI/GSRVR1EeMmDXXuoE4dz68C8sfUWIyUav56AoimgQH4/PeIKqWv7h49huuNkW+Dq+pUzgJ18udBusRkE9RT3esmAzYyDyOhijwqQWjv8/8XRNaoRqcHwOtjPAc4JG5Q74nO1kFIZc4mH062QkJijMVJbhfIl4c2dZzaozJ01+WkwxIfmU/6jJUb9i5AKWQFVDuZRVhmfasRaFC+mWO9vSAmJYsxbBBVVpfWaDSraPGFK5ZP+Vl0F+63X+kUVPUM5sq8N1ye+okNGTdm7WPWY/O3a6B2zPv0XzlRoXskSfaGAAeaPIA+11rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FfNyj+bRFBTWT5XlNWJY5popj3JLjAEaehVj1XHEbyA=;
 b=Tx+EtNBHdIP5mDLePtwULGZvyROlkIn9t1vlTkPhCs2lgqlt4Y3HNEhBJ6gBNbbVvo0HMZAqNabM3p9UmtXgw64NPC4+EW/33wZTMvBGk+Lef0cPLmf4yZDDfE591fqZFn9DyGJ3mUhISScypmfCUXYGtnkOhhEDlgiZmx9Pc8kPx4J+X6i4u5nmbkoS+8YeRXvzKn9SOlHFjLBptDJ9RIbmoYUY9w+lWRM0azB/hvvLpkWoiM8VLQrLfKd+PEulWmGyqPPjBFo5/VkqAwhjGcH+E6kAitJF21EgCjvGnUYKIeSpH74F1yQINh5Jnu3DDT5F/cpTQ9FBWeTcoQLSUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FfNyj+bRFBTWT5XlNWJY5popj3JLjAEaehVj1XHEbyA=;
 b=Up2d1ZeiJeYH/40SVSY0uO1xPDWUj8DenXSBmhGq989H7woIV8CoolXg9WAXgG1M79Jqpq+ShRKNcugkvz/G/hw65UlzRJg5U7pSs+Kwcjba/advkXoj5vhr55+rXj01yXUVK9HTS4Dj9vCXTwVeIiz+kMb13M+CFwh71ed8t3k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AS8PR04MB8850.eurprd04.prod.outlook.com (2603:10a6:20b:42d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 12:32:47 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 12:32:47 +0000
Message-ID: <f8fd3d39-9fb7-46f2-973d-7e0b595e1ad6@cherry.de>
Date: Mon, 24 Nov 2025 13:32:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: v2025.10 env Kconfig rename (fb5235239aad) removed backward
 compatibility
To: Ozan Durgut <ozandurgut.2001@hotmail.com>, U-Boot@lists.denx.de
References: <DU2PPFBA6D4FC4D0E86306717E76599508AFDD2A@DU2PPFBA6D4FC4D.EURP189.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <DU2PPFBA6D4FC4D0E86306717E76599508AFDD2A@DU2PPFBA6D4FC4D.EURP189.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0079.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::7) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AS8PR04MB8850:EE_
X-MS-Office365-Filtering-Correlation-Id: e6b9a270-5f8a-441e-ed4d-08de2b5592cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|10070799003|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c3BTQUFFeEZMSG1HTUF1bVVMejBsOHFGdTBYS3p2dmk4L2UySk5BenpuQXpl?=
 =?utf-8?B?RC8wUDQ5TUIvNWFGNVMxdFBOdDZiZWRJZnVmSXdmKzI2cnlHdkZ4NGdwODlk?=
 =?utf-8?B?VlliaDh2cUlzQlZuKzRXM1JJV25XMzNXUVkwTzV4WXYvZG5Bc0JjU2R1T1dK?=
 =?utf-8?B?U0tDMkRZdEYvL0tiaWlEOE1PdVdPa2c2dmQ1Um54OUF5RHhjL09KREZGTGNl?=
 =?utf-8?B?ZjM3cytVL0RuK01nYU1pM1dBSGlLRUVPMjU4dGVvWDF1cGdCazhWazZDS2wy?=
 =?utf-8?B?MktnNWVteDhHY1NXdEhQb2R1RzlPcUtzdmRUc1ZpWGR5K3VPaFZJVHFBTU5K?=
 =?utf-8?B?Y0JMSkx5dngyR2htSmN1TFZhNjQzaDYzQ09maU02VGdOa2RJRnpPK29MVWZy?=
 =?utf-8?B?Z1IrUjZ0MEZGWDIyNmU4UVFUdHA2YVlzVHF2MnlqK2NObEhJb2ozMmxmYXJl?=
 =?utf-8?B?RGJwUDhUdXQ2dDFpaklSUGQ0QmFSK3hzUjFLVDEzR0pPcCt1NmQ5UnVsaXM2?=
 =?utf-8?B?amtJVFhPN2NsSTFhU2lmT0pYcEtqZWhNZllNUmVFU2NmUWRNbkp6V0VGOS9i?=
 =?utf-8?B?YnNDaVp6YzVidWpFaUJyS1VCQXBJelBqZEg4YlFqeDloaWt4Ri9VbjFBMk5K?=
 =?utf-8?B?TmlpTVFtMFg2MXdkNlhCU1FPN2JoVjdWcHVmZlQ5U2UvNG8zcVBNb2pvOVJv?=
 =?utf-8?B?NVdiMjU5dVA1SGpxN3cwV3NXU00zeWVYV1oxWkdGNmdJMWxyQWpOQzZZWXBt?=
 =?utf-8?B?N1BFdFY2ZmV5aExpN0JDYVdmMUVGUWgvd1ZocllmbDJKWjJTUmJKY0Ria1U4?=
 =?utf-8?B?Z2hXOFZXTzlhUE5qTkdKakp0NUV2L1duV0kxQUQzUk1WWlp6MlpWSFgwb2Ru?=
 =?utf-8?B?em9nRHhlenllZkRNNWFCYUozZk43OU45WWlnb2gyMU9leHE2SjE5RU85YjhU?=
 =?utf-8?B?VHNONCtJbEdmUk92S1pBK044UXRGS2VGdGtNNUJ6SEJoTGN0OUJ3OXRSMkxG?=
 =?utf-8?B?QjhhYS8xdFY5WjhCb3pMREMybWNjTGlNRTZaZjJPeThGQkFvRHIrSDFLVWov?=
 =?utf-8?B?Mkdoc3JQWnVoWGF5RS96L0dRMHdZTmc5cHJZOFBHUDRsZjJSSGY3KzB0UjR4?=
 =?utf-8?B?SEJxVnF5VVN1bG5MeEsvMitGeElXMlQxZG9hS1Y0azhadyt3aGZJU2JxWmMr?=
 =?utf-8?B?NytHU1hxQTlqRWx0b2NkaytsdFd0M2ttcTF3ZnFlZFI2UVJEY01aYitqc1k5?=
 =?utf-8?B?dDFGcDdNZlF6aUhvSjF3UHBQYTRMQU01ODBNWVQ4NG1rYTZCNGNOUjFSUFNm?=
 =?utf-8?B?YzhHL0xpMWU3dXJBWWtxbE1DeW1iVGV4YWV6bWFVWUlsUE9qdllIWXlCRjZp?=
 =?utf-8?B?d3V6OVdUZmp1Z2Z6akN3OGlNTUM3eWswdVFvUXFuNmJXRWpMemE0aVdIVlNs?=
 =?utf-8?B?eGZWeU5RcDhUT1FyTy9LUlJmVDc3SWthUlhrWjFQckpKaUdEN3RUaVFXdHVV?=
 =?utf-8?B?OUdRQzNuRFlMSGZ0ME8vMjgwTlNVQVhMLzlPM2E0Zm5tY3ZFZFAvYXFXc2lZ?=
 =?utf-8?B?VWxleFkwc0dZMW51U2ZXNHlVR0c2VkREZllKSHRhbWRwR0VneGRTYll2SG5j?=
 =?utf-8?B?andlQ2x5OFFWTEtia1MvQVNQZytJSUl0NU5aMk50NG82VTNCZHBqNVorbC9G?=
 =?utf-8?B?TEYvVEc0cWpSOHZtbVNEMDRkNjVJZDlmRExpVFAvL1puQkJyeDF3WDFacUZF?=
 =?utf-8?B?aXJxdW53MHZ5bGFSbmt2NUxjaDJTRk94QUIwVmZ5UmJvWEZwc0lGbXZaOHB1?=
 =?utf-8?B?WHdoQ0pmRzIyOXU4T2tBcGlyK1gyME9DbCtKQ0FCVHFlSjR0WE55SVh1R01m?=
 =?utf-8?B?S1JpcVZKTWVkMVZNVVd3Qis1R1VPdS96akY2cmxHUzBDRFE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjdiM3FHVUM4c3BCaXJVemhKRnQvQUwyZklCWHlZLzFmY1FoVmd1V3VDeEhn?=
 =?utf-8?B?OU9iVHFHRWMvL1lmZjhWNnovazFHMUhGWjVuMVpTTU5tU1RvR1paVlpCb0tz?=
 =?utf-8?B?QlEvc1VETmQyU2dQQVhVSkRlTlZQR0p5NUdkRUpOeUdqM3BlTGxlWUVJU01F?=
 =?utf-8?B?bGVkK3hkMkt6V3R4UG5FeTIzOHQ3bUMrNWRnSUV2Y0xHcmMxL1krL2JIQWoz?=
 =?utf-8?B?K2ZnZ3hud0pNL2pBUWJqU04vVkZZMjh5THkvVTRQZENzTkthNFJ2YW83cnR1?=
 =?utf-8?B?cmhKTDdoRFlKMmNrb3B5Y3JoLzJBc1NvZzlOTXdneHRuOStwd1hkajlXT2ZR?=
 =?utf-8?B?SGhzdmxtYXcwMnZ0dE9ZbFd3SWJDbzluYjAxdnU5MWk5MTFhd200VHhsVVZG?=
 =?utf-8?B?UmtrNDFiUlZxdUNSRUdONmEvOUMvRjREeGg1Snl3dSttUzVudklSeXZmeHRX?=
 =?utf-8?B?V1UybTJWN3ZFN01hOUpYbW1CR010a2dBNEp2MWx2TWV5QU50RTc2a1lKVmpJ?=
 =?utf-8?B?aitvcENTRktWalNVMXlPT3VKUTh5UWFOdXR1cGE4K00xU2YwOHQ3UWp5cXd1?=
 =?utf-8?B?ODd1QXBGRGYwazNweUluV3JpVm1FeTZxZlRRTlU5V0hwOTVKOHdXbm9NMFI3?=
 =?utf-8?B?Mzg0WUlaZG9LTE1LT29hNFNBRVl5MVZhd0o2RnpEMEVoVlNKeFIxQzVuQnU0?=
 =?utf-8?B?eEJQV0JNOUp0VDcrM1VnV24wMktCWGpMcHgya0hBblBXQnBlamlIL1d3SXEy?=
 =?utf-8?B?UFFRaU1QSFlFUTQ1VjR4NnZpWWs3ZWxWUWduOGhVVXZOL2U5bWFRNU02THhJ?=
 =?utf-8?B?SHlFUzgxcTkxam5aMG5idHo4RXhoRFZ4VXI5WVp1bG43VkhlZzlMaUlML2pS?=
 =?utf-8?B?ZWRaeEJiM1RWUFFvQll6S1ZRQVpHLzVhWU1PZGxGQmNETUVzSW1IakVtVFll?=
 =?utf-8?B?VGJGRXRaL3RSTllQYXR6citUZWs3UDBGNEx3eWZvSmZWVnhUSWJEeEI0b2NL?=
 =?utf-8?B?Skxoc2hrOVR4aUM3bVJXelEzcnUvT3U3T1NGSmplc1lPV3dwNHhuWTBlOTFs?=
 =?utf-8?B?OVUrc003WmR3NEY4VEhLYWQ3bUF0RkVGckVuSlczNk5oYk0ySGJZZWtlK1BV?=
 =?utf-8?B?bjV2dTZBZ1NRSVlBcXBMaDFrenFEcS9aYkJ5VEpBYTYvNng2U1dDSjZON21P?=
 =?utf-8?B?dGJTbkRjWDg0SjB5NkphOTBMNHhDODkyZjFkWE51Q25pTTVjQ0ZHa3BiYThC?=
 =?utf-8?B?MXhIN1pIc1ArRWJ1dG9qM2U2c0M0VDdhMXVqajEwMnd1YkJ3N0U1SkdYdlM5?=
 =?utf-8?B?MHY2SXh4MEFoRDlvTXhrOEs2UWJjOGpyb1l5bnV5K296TEMrelJOUHhGVjBD?=
 =?utf-8?B?WTMyU0tWck1tWmd2WWtObUJWWTV5SzRJWGxVdHhGUW9GVmZUZURZUkp4MTUw?=
 =?utf-8?B?ZXB3RG5wU3Y0bTVHcWgycytRSlZOaWpjbHQ1Ky8va1pvOGZoWmtJSnY4djgy?=
 =?utf-8?B?Yk5TZ21oQTA1em84OU1sK3daT2hZL2l2dnNYMmY0ZTVMRndEQXBXMXB3TXB3?=
 =?utf-8?B?QTVBY0lmUG15RG5CVzBoZVl0b2FqYnVZS2JrNitjMHRDWlVzaWV5S216aGU1?=
 =?utf-8?B?MENTcFUrQjEzZ3U5R2RnOXg3bUNtZm0yTG9aL1FNYzFCTit6TmVjd0RXTlZo?=
 =?utf-8?B?WlBaWFBjMEErWlFXUUZrbHdoa1BCaXFwZ0Zob1BMaGRkclNneTJ4MHZvOHkr?=
 =?utf-8?B?V0t5OWhGcVd4dnZkbnluSndBdTB5VVByTEhhL0wwUzBzbndzZUVDZ3hNdlZJ?=
 =?utf-8?B?YUZyNjBDTjhaY0V3Rmo1aWQ1V0duaEFGQkFNK0RMdVVOR3YyeTRabnlhV2tT?=
 =?utf-8?B?cjltREZCVmFVOTV5Si81NytIWGxpSTQwYlpzUHpwQlN0NGZmWGhZVVlqRFda?=
 =?utf-8?B?NkMwcTc1ck5qT1pFc1JCMXFkeGRpSW1RZW9ucWY4NTdWQVpTeUhXSEU5bDVO?=
 =?utf-8?B?UnZDOThWbXhldnVPajhmdE5FYmx5RUFXY1pqTzV3VzNCYy9PTmRKY3pmMU5X?=
 =?utf-8?B?QTc5dzhIMG1teDV4R0MrNDl4S2x5ODhjeWFoSnRNb1dDbkJQbDZCUHZyWERY?=
 =?utf-8?B?UVVQTVlUeG44WlV4cmxjc0NGMjBSRkYyWkRDQ3pSTnFlajVmOUh2SkRwRlBJ?=
 =?utf-8?Q?6o0yyooXDX3e/fIHAxxwkDk=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e6b9a270-5f8a-441e-ed4d-08de2b5592cf
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 12:32:46.9779 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hXg7i5g+nxi0z/cpZOOeBYmjgCxqa0mkVhzR2qRFDp4hJeo0oZfUwrDIc+4LDuAjupPqrbTBQUiPtAU4a6NTVTbA8VJshcpB7SLh3dXOBmo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8850
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

Hi Ozan,

On 11/22/25 2:18 PM, Ozan Durgut wrote:
> [You don't often get email from ozandurgut.2001@hotmail.com. Learn why 
> this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Dear U-Boot maintainers,
> 
> I hope you're doing well.
> 
> I would like to raise a backward compatibility concern regarding commit
> fb5235239aad ("env: Rename DEFAULT_ENV_FILE to
> ENV_DEFAULT_ENV_TEXT_FILE"), which landed in the v2025.10 release.
> 

I don't think we ever advertised backward compatibility for Kconfig 
symbols/defconfig.

> Previously used Kconfig symbols CONFIG_USE_DEFAULT_ENV_FILE and
> CONFIG_DEFAULT_ENV_FILE have been replaced with
> CONFIG_ENV_USE_DEFAULT_ENV_TEXT_FILE and
> CONFIG_ENV_DEFAULT_ENV_TEXT_FILE. However, the old symbols were removed
> outright, without a compatibility shim or deprecation period.
> 
> This change causes breakage when integrating U-Boot with Buildroot, as
> Buildroot currently lacks a mechanism to handle such changes
> conditionally based on U-Boot's version. As a result, downstream users
> are forced to choose between breaking support for older or newer U-Boot
> versions.
> 

Currently yes, but that's an issue in Buildroot you can fix. This was 
already asked on #u-boot and I already answered "just enable the new 
option as well?" 
(https://libera.catirclogs.org/u-boot/2025-11-20#39059950;). I've sent a 
patch to the Buildroot ML with a tentative patch (though it doesn't seem 
to appear on the ML archive just yet for some reason):

commit 73889fc15e1d631adc24a88e59f839569fe803dc
Author: Quentin Schulz <quentin.schulz@cherry.de>
Date:   Mon Nov 24 13:20:44 2025 +0100

     boot/uboot: fix externally provided env file not used on 2025.10

     fb5235239aad ("env: Rename DEFAULT_ENV_FILE to
     ENV_DEFAULT_ENV_TEXT_FILE") renamed the Kconfig symbols and thus we 
need
     to adapt the U-Boot package in Buildroot to support it.

     Fixes: 128c26f2875d ("boot/uboot: bump to version 2025.10")
     Reported-by: Ozan Durgut <ozandurgut.2001@hotmail.com>
     Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

diff --git a/boot/uboot/uboot.mk b/boot/uboot/uboot.mk
index 7bd0937df2..8dad710bf3 100644
--- a/boot/uboot/uboot.mk
+++ b/boot/uboot/uboot.mk
@@ -409,8 +409,12 @@ UBOOT_KCONFIG_OPTS = $(UBOOT_MAKE_OPTS) 
HOSTCC="$(HOSTCC_NOCCACHE)" HOSTLDFLAGS=
  ifeq ($(BR2_TARGET_UBOOT_DEFAULT_ENV_FILE_ENABLED),y)
  UBOOT_DEFAULT_ENV_FILE = $(call 
qstrip,$(BR2_TARGET_UBOOT_DEFAULT_ENV_FILE))
  define UBOOT_KCONFIG_DEFAULT_ENV_FILE
+	# Pre-2025.10
  	$(call KCONFIG_SET_OPT,CONFIG_USE_DEFAULT_ENV_FILE,y)
  	$(call KCONFIG_SET_OPT,CONFIG_DEFAULT_ENV_FILE,"$(shell readlink -f 
$(UBOOT_DEFAULT_ENV_FILE))")
+	# 2025.10 and later
+	$(call KCONFIG_SET_OPT,CONFIG_ENV_USE_DEFAULT_ENV_TEXT_FILE,y)
+	$(call KCONFIG_SET_OPT,CONFIG_ENV_DEFAULT_ENV_TEXT_FILE,"$(shell 
readlink -f $(UBOOT_DEFAULT_ENV_FILE))")
  endef
  endif
  endif # BR2_TARGET_UBOOT_BUILD_SYSTEM_LEGACY


Cheers,
Quentin
