Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16452C5478C
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 01:30:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CC4E87F71;
	Tue, 27 Feb 2024 02:30:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="QwZhV+xw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C67787F6D; Tue, 27 Feb 2024 02:30:11 +0100 (CET)
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-sgaapc01olkn20823.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:feab::823])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BDA387F5E
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 02:30:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=forbidden405@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bcsVjHsGPN3TDT1AEB8D2GhX+cntSUei+G3Hjtwdx/ZH2sk6CUW9KC26+06yJ8zzHdPEKWIAeuNuN0eG79oCN8LUrwPanRNmp9PnX1exClhavDcSedF3U+IP8mNQpIPacHbAEGdU75eMQBbd1npT5epzTV/lb7KiN508/2RHsLovs05AASzVzzdfFKr+ybPb1NpJmbcVmc3+Kjo0ubmuwzQ4+Gpz7uYrFYcvR1B/+iYdRtm1jyXiODgWLeYwPo7RHXqnXlozrhAm+DPZ1QBYdEjwJt4cWcItM9hM13JrPaoexr89m4D3OMiLyWqZixjmS9MdBIVY9+KQgPJ19ZvhCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IKPgWFgvoRslClwmVpWth66drREUhBm7TBWykoQu3ro=;
 b=UJ364oexhcH6BynHn/s4rdxI1c4X+ypfVrrK+TI1iqhRZ354gqZgDj1wJTjsXd54c9STv9lmyv6At8oBH5BrMrTZ7503Fzs3phti8PHccIbMbonjoJomEUtEuSyqSXvHhx1SBUvnCJN5DbKT59bAfPVxzevLIGGIe0jGustB7PCBu3S1w5H8B3XYbM3ytW+k/TI64cXiTNHpXrWFUmnxdJI5hn8y4NrzZMeKwHw37YI8Vt9p6sqJdKjqxBTl4mj0cfq0d3sqNM5OBdgjiOaMDVc/ZJNSuwmm9TkxH/w/64TFKGAunHnF9qQMinL9JLPzbQ+jaBKM9EGnzIomJoEBEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IKPgWFgvoRslClwmVpWth66drREUhBm7TBWykoQu3ro=;
 b=QwZhV+xwQGq6eV2MQ6vCA1RYX7wPv7y3JNprt4Yq+Od0ehKZ123sJOlg901j7FWtlV7k11hjpdQ/BTaDdU/xFBFWzdeqYVqub1QovitzONvZ+ZgUMjbvQkGH8dSjBHTswmNEQ1sAFjSeEiTiVNSv3E9xlw0ULWkexl/NoO4r2FrL3FeQdEqKk41nVLTgZFosU2c4wHRA2srtpvSCM+OzhCS05mdcDDlYyGQaxjiyRVwXBG1aGKtVRzVigUodp56xlWW/AeU5o/kAsUlTe4sG+I84TzxadxsGk40JgxWblsqKQqQXOfgaaNYVgs7EoIPOiVCcvuEx6ZfXdt0KoyJKqw==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by TY0PR06MB5706.apcprd06.prod.outlook.com (2603:1096:400:272::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Tue, 27 Feb
 2024 01:30:05 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad%4]) with mapi id 15.20.7316.035; Tue, 27 Feb 2024
 01:30:05 +0000
Message-ID: <SEZPR06MB6959E1A4AE0D95ACD879E09D96592@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Tue, 27 Feb 2024 09:29:57 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] serial: pl01x: set baudrate when probing
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>
References: <20240225-b4-pl011-v1-1-2686496c1a17@outlook.com>
 <55c3b1b2-f384-44bb-8cf3-d47884124b6f@moroto.mountain>
Content-Language: en-US
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <55c3b1b2-f384-44bb-8cf3-d47884124b6f@moroto.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN: [w0DVZKdBum2QnupV+VjBRGYR0w8ppOAHxOODNmHsvMw9tc3+yfFi3/IjStUcAQUL]
X-ClientProxiedBy: SI2PR01CA0022.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::14) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID: <91a184c4-1491-46c4-a38e-8b0b503a2a7d@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|TY0PR06MB5706:EE_
X-MS-Office365-Filtering-Correlation-Id: 99bec8b1-b47d-4008-3b61-08dc3733a047
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sAhwfj9QudSx51KchQyA6uy6II7Hst4OJaj2fASJ/MFgHlyFZLRrf6in4Q/nsnUuCeYVob5h2sQWoyGbkeSlQraIwKXRP3D7AFvSdwl0MXg0Z4RVLs6pEPjXvFNuoMIYMDJ+s8bd/DdWB4NqK4+IvwaMIUZASID7Zjlf4Ytk9ELa8OP5/smOb5XnGymtFg4Q1cpMeSyBg2YRFMJ1iVH6xxy9JRfWX9Zlnhfy0UvcdEojobau5TfdjMp6kQyiF+LqPL3W8k3dWgI2h7mttPLgozIQ7je9WMN16K87pe7zKJFRW+x9093a86n7Gio4PcD8jlVu1pK3E3t0pMZzFcrP5oPApNU/fdJUQA5UEXdCKZclRdrqGuxbJkcKjJ9uKqxFXnNB2xsQJ9r1/NqppSNLfiN8fYrJy7ZHbkkFBr+2WVRl1zIIcdXCYYZYVIAxL+KNhzb4rynv3VXxLZW3VxrKv5U31jybKUTdY9nDV4cRFp6+eeqmG+a5qMZNBUfRk0l5hyIJNcGP/E9DhvsgobZp50PLvmi0icoNUHfwdCcYxtvHAsgCn+/9RlJg0Xp3xVNM
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVBWQWh1aTRXczl3VlRlc1VaNnFsZDRRSVk1OWQ1Q0VsVkxOb2t1OUF2UnFV?=
 =?utf-8?B?Y3o2aWkxQmNIV2JQMUdXa0N2R1VBY0xjK0IzeW8yNGpha2dkbTJGdXc3TDNY?=
 =?utf-8?B?aFRJWnpIRXF6dnFNcEU3bkRTRmcvY3BmcUh5ZUszUEVpc2QxUXpwcGpJaWJZ?=
 =?utf-8?B?Z1JORHQ4UXdmREZnWG1iL1hnODdKSHlGWHU5dWs0eW5BUVAzY3I3TjZHNWZr?=
 =?utf-8?B?MDM2OEtJRjljR3JvaXdZUCtZQkdoczdyQmR0TUYwRThIblRmWk42eGQwNlNw?=
 =?utf-8?B?LzZ3b0NFckRmMit6S2xqOWdtdDVrekc2VkpETzRwckxSci9kWkZYUzFKcDhs?=
 =?utf-8?B?N2QrR1pJTGNFY3M1UTdERWVYaGQ5aUdHT1MyUzVFWi80WFlmd2xJWjEvckFT?=
 =?utf-8?B?RnVFbDFNN2ROT2N3UXljY2l1QWI5MExsU25OMlpNbUk0aFdMbEhHd2xqRSts?=
 =?utf-8?B?OXZtOGZKalVWKzIzdkUvN1hkRE1uTDJESmhXT1hyVVh6TS9IVjNRTzk2YWpj?=
 =?utf-8?B?QkwzOVoyeFV4WWNWTDdMYUNRenNSeVI3bDBjWW52Qk8ya1VXNmY5Nm9ER1RE?=
 =?utf-8?B?ZDBBWXJzWFFUSmhVVDdVUlc1QU9uQVB4VkJJV3Fhbmd3endnL1JDQ2hBcTNC?=
 =?utf-8?B?cDR4WFhLNE8vLzFhUFNaYmJIbkdudGswUmhIUkg0RGpmTkRoWWNIU0xybThL?=
 =?utf-8?B?SjFDc3dBazROdjkwbVp2TktKeDI5YzB0ek5zTzlVMlZwSytLeW82ak1kcmx5?=
 =?utf-8?B?amd1NHMzbGZsRlJRNFpNZ2w4c2VVRGNnTGM2ZEhueHBSa0tYTVNRRU5lMm13?=
 =?utf-8?B?TTh6M3NCcnNuV3J5RjVSRE02cFRzZXVrOVdUQ2taRXdkcHptbmtRdW1Na3c2?=
 =?utf-8?B?SFBIWUVQckdqSFQ0cDgrcXl5cTlSMWVrbUJLQmY1OHpmcHNUMWRGQmNlY004?=
 =?utf-8?B?YWwzUC9aU3R5VVB1QUFYSVVYWnR2QXNvTDZrSVdKcjV6bDZwa0pqbFJIYjNx?=
 =?utf-8?B?bHB0K0NlUExuM1Q5RGE1SEVEOHUxL0JseEo4aTczaVZiaGswdE1EN25xazhm?=
 =?utf-8?B?dmtMUmUwWG54VHZUL3dwVFh0QW1qZkw3YmVJSTZINVZNcnJJbEIxVG84TTlQ?=
 =?utf-8?B?R2tpaTY5SndZZk1TbzN4NEl6Ty9Wem5hbmRNeXdrVzY3ZzBmMkRWc3dwemtK?=
 =?utf-8?B?dnVmYU0wamg3a041VzgzbEVWdm9lREpFd3BmdTBseHRDaUhQUStuWGZNbGI3?=
 =?utf-8?B?aksrRWxLMjVPTWlXWjVXbk13WHdDRlpKMzRoMUkvREUxcXJBVzRTTXhBcW1Q?=
 =?utf-8?B?RWZEYzVlckZ4cGoxc0VGZDJpcEd0UkkyWGN2aTlLWFlXaC9xMFlBTnRVdzRZ?=
 =?utf-8?B?WTFObjZkUGVRYStCM1o0MDgrY2trajlocU0yVTZVYVZBc3Z1QWphQkVYbWVs?=
 =?utf-8?B?dy9ScmhHcGFCTlZyZ3gzSGJEMzc5SnhMWW9tQmFad0VrUnozb1ZkM0l5U0Fx?=
 =?utf-8?B?eGZKckZ0MkswL2dQTnhiZVltamJJWlFlMWhnYysyV3hrS3RRV05VNFJISUZz?=
 =?utf-8?B?YmV2YnM5M0VLcnZML1lBOTRQbXNOZ3VMc0YyTHVnMlRjSzZvdEpJcjNkUGo2?=
 =?utf-8?B?R1pIVUZibFdxbFlESmxCTG81cHBlM1lBdS92eFF3bk5zZEFNMEpNMTZNc25t?=
 =?utf-8?B?WXBOKzVRK1RPSDA3aTZUOEZqRS9mbSs4SC9WcWx5S3FHMFNVWXpmQVlnd3ow?=
 =?utf-8?Q?hyKBOS9X5rTIR2c/BwUyYq248eemI8RaAaYYbMV?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99bec8b1-b47d-4008-3b61-08dc3733a047
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 01:30:05.4813 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5706
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

On 2/26/2024 4:23 PM, Dan Carpenter wrote:
> On Sun, Feb 25, 2024 at 08:38:33AM +0800, Yang Xiwen via B4 Relay wrote:
>>  #if CONFIG_IS_ENABLED(OF_PLATDATA)
>>  	struct dtd_serial_pl01x *dtplat = &plat->dtplat;
>> @@ -301,10 +302,14 @@ int pl01x_serial_probe(struct udevice *dev)
>>  #endif
>>  	priv->type = plat->type;
>>  
>> -	if (!plat->skip_init)
>> -		return pl01x_generic_serial_init(priv->regs, priv->type);
>> -	else
>> +	if (!plat->skip_init) {
>> +		ret = pl01x_generic_serial_init(priv->regs, priv->type);
>> +		if (!ret)
>                     ^^^^
> This if statement seems to be reversed.

Seems correct. Maybe i sent the wrong version.

> 
> regards,
> dan carpenter
> 
>> +			return ret;
>> +		return pl01x_serial_setbrg(dev, gd->baudrate);
>> +	} else {
>>  		return 0;
>> +	}
>>  }
> 

-- 
Best regards,
Yang Xiwen

