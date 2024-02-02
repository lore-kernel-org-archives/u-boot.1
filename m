Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C72C47DB3
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 11:10:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1363687C64;
	Fri,  2 Feb 2024 12:10:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="Dze7baxf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3155987C66; Fri,  2 Feb 2024 12:10:47 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48D4187C58
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 12:10:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PiXhcbCJ0lz1nT5gIy01uo/9JYenuJ2ES0DYPIWvsasm/MkL8pOVOU1gCGxUvgFSyuVVU/H9LbuLmCILxVefXQuNhbUKJj9nio2YvDlHJPfDmt+jd4WCHg6v6l+zeLIcsS0EJXPhIloH4QaUFblftqihZ6JVbxnrao5BOwUuRkXMUkS/prQGCDfbLu2FQw7kBuQnOq8dqvhKwAb1mQThcd3w8BxhMQ289ZKjnU0KQ3pyFDI0KwFmZSih8Ye0jF54rTFil8O6TakFFPmuIhO2ThtMJx/zvc2IxURqE/2zrE0hkOjYICYjJ+tPgG48JN3pkZu0SY8Zn4UWBSmQy4OGSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CY4mPYgWTydVXkMF9OjSKXLlay4SL/lct1LoivxBh50=;
 b=AahDWHDyIE+NiNvQl6uy9103x6Ma/J7NN4A6uvOIs/SvIPNPLCq3+jQmb4V9jBEPQj5fFPSQx5WPWz4RuxeO7HRjVq64D0aeJ1/jsnSlZlLUZdTGErpNLciZDCX7KyVAlM3JSLSu5CskStogdSllzVzzwDzaKhtAhAclP13VOYdTSp/Zoc2USFyfLn8OfJdhbKYfqsdC6lNmCIYHC2N4/lwA9R4Da9VT5GGhP3Ug1Il2oV26z86r5wRjkEY3lzo/RRCBV4W4dgrOjteTULXlSrO9UUm2gOmrV5apAYJLRxiz6qIezdWE3obBD3T0+2Y3tHJ5XFqymY5p4QTLjuMu7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CY4mPYgWTydVXkMF9OjSKXLlay4SL/lct1LoivxBh50=;
 b=Dze7baxfGEVB9j2f95VWAop8NUQe34oCsidy9RtMvrT8fm6v6g/sQP4UedXlJMSV3OYGAtB7VkWtn1MK+LpcQu7x6PrbvpGzYpR+ce0JKsobyqpq+s3pdvaZDljzSDOzo53EhN8s8mVK3Hq7zazlLyX6/rrrEXYx66GDRsNV0g4TqwDET9ISQvKpmgXoVr57jMM232U2s6PgXlh4MH4Yk+vbCdlVxVn/TKL2X4v8K0jJb4+klQX4Wj7Ured1ItSW/m5mDK5EEjxPj0ISTBxbK8uA3o0q8Umt8BGxJTf5qa7E9QlTIv8SAehwT21k/O8fsMTisYyIkD/YM4I05745kg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by PA4PR04MB9688.eurprd04.prod.outlook.com (2603:10a6:102:271::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Fri, 2 Feb
 2024 11:10:41 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e%5]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 11:10:41 +0000
Message-ID: <10f0b268-0a9d-41a8-ba4e-d02abb62e418@theobroma-systems.com>
Date: Fri, 2 Feb 2024 12:10:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] rockchip: rk35xx: Remove use of eMMC DDR52 mode
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>,
 Eugen Hristev <eugen.hristev@collabora.com>
Cc: u-boot@lists.denx.de, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Andy Yan <andyshrk@163.com>,
 Tianling Shen <cnsztl@gmail.com>, Akash Gajjar <gajjar04akash@gmail.com>,
 Joshua Riek <jjriek@verizon.net>
References: <20240126232615.6826-1-jonas@kwiboo.se>
 <20240126232615.6826-2-jonas@kwiboo.se>
 <515157a9-8d19-42f9-ae6d-914aaea8a3ba@collabora.com>
 <e1417a87-15ee-4e1b-9513-c101a02118d4@kwiboo.se>
 <23d7337a-88b7-4dcb-be08-c42b21e9dbd1@theobroma-systems.com>
 <e9d6883b-4331-4237-be19-5df6126a3962@kwiboo.se>
 <ab9af16d-37f5-43a1-9dc6-9d1ba93c1689@theobroma-systems.com>
 <54ad872d-c47a-46ea-a4a5-c9776ae6213f@kwiboo.se>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <54ad872d-c47a-46ea-a4a5-c9776ae6213f@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: VI1P195CA0086.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::39) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|PA4PR04MB9688:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eaf2a03-db36-4325-505b-08dc23df979c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /aG8eq54W2VW2dyWneoU/eotnLf7FwvU5tcAWhjSeOEs3eErLzkEFk45piqk+A5YjEgOdVBPlILv2MjCL7/9LhMlGocZ09JJ3iv8fJbLSP2VHUYR2soiy6JhCIwY8/wqNOJJLN6fdTkkqglI/Q/kE6mBeIJ/5qnRNGXmIMv9MOaSWVa+BD389ejOvu+17BMNaC+1EmGzQln5wNdrZqNvw4edQVZablwtepzcaTh03n96H5JNzp8qDaz0oAnentQfu+ntfXn4ePAPdZpU2NqVvrOzK6N+BSXcbM++1YY9mLWJvJIagFRk2YbezFdTRNWEFrCu24oZkS085fQudc0URmcd/lvtT2R9CYptedkZ/xS7BYYZE4al8HoAlt4VkeSd6fRjCMAv4Hr02FeWryCnWEGTItx6iN46n1CT9Gp43ZNydU88uVYgFeAvZYt5HKe0T6Z1Nvkz97nwXVYbF8nOqciTe+Pc4LnFHCf+K7l3Uv4J7h8nvCO8fd89B3zRSdU1gEyPZV13hifFD3cJG0/O36VSflhHLTtvcRqbQ9/fyaw5NaoTpEBXSLuJUpRx6dgbTU1jsCXbxLgKDr44cGgL2UwiBaKU4ppdZ/gKTFTzVIED+97RJClWQ4c8Jb7ppQxaTa9GxHfsk082BDT+l9j70g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(366004)(346002)(396003)(39850400004)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(478600001)(45080400002)(41300700001)(966005)(6486002)(83380400001)(38100700002)(31686004)(26005)(6512007)(53546011)(6506007)(36756003)(54906003)(316002)(66476007)(7416002)(66556008)(5660300002)(8936002)(2906002)(44832011)(8676002)(110136005)(4326008)(86362001)(66946007)(2616005)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3JHNVZrYnpGQ1VtWXBubWtVdmpXeHZHVGc1cEF6NmFQOUFUNUJ5bmFucWlv?=
 =?utf-8?B?VitLbGJRa0Q5dHMrellDWEpRbUJBcDZNdXBXZzJxR3BvbVpXMnU5aTdab0FM?=
 =?utf-8?B?TG5OWnVZQ2E4eXFQV0xoYkowY3hxL25DT3hhRDUvOWJzWmtWVDA2QW01WGNn?=
 =?utf-8?B?UGZlNjNROHJNMTBCNDV5S0lrcmhUQXZGbVY5OG5pYVFBWGNLK2ZPWnZnWTRH?=
 =?utf-8?B?MGlDQzRsU2YyM2cxWmVNQVlNcWFGamZYcHJGWjZWbWpuOFcvdXZHc3o3Vkc2?=
 =?utf-8?B?NWU2V2N3Vm9Dck5kYnVZeUhWcCtpYkdMZ1ZpdVB4N3dBdDJTUmZ2SHc0VUdS?=
 =?utf-8?B?bHlsZU9qVWlLbFJ0VU9XVjhOc2FuTFEyWmdEbk9hbStUTlpQYjZ5ejRvZ3VR?=
 =?utf-8?B?ZWxucWhSU0JDUkdEWm5aYTJjVnV2bi9hWXYyMU01b1JWOVUwYnpOTE1tWWxy?=
 =?utf-8?B?Ukt0cWgzVmpmL0g2KzZuYUZJeFhiZFRENUxEbE5EaFhqU1EvcytzUDRuK01m?=
 =?utf-8?B?VzA4bnZkYlZPcCtQeUhBa3N4K0VwZUZrSUdTdkZjRFVOM2NzeG55cWNyUjN2?=
 =?utf-8?B?WG5JNk5NM2VaR3k2STUyMEtBYVk1SCtLWVliRWtPUGxJUlRSR2ZwM3cvQUlR?=
 =?utf-8?B?QzhSZVBQbGs1QUpKS2lzdUpzbUJUUW1NNVZhdU9lMFhjY3AzUUZaNzR3U245?=
 =?utf-8?B?ZW5BZ0JhKzNPSndKUy90V1BlQzk3b3B0KzVpV1Z4OVpuV2NqdWVOMkx0YVVF?=
 =?utf-8?B?Q3JSbnhxdlZuUXVsMnAzT20zV09SZE5oSEJFRFl6WjNHdmxOWEI0dHV5UDBW?=
 =?utf-8?B?RGRyVDBOWk1KRit0VmcwR01QNi9ya3lmY2o0N25ud3lOZ2NWb05nQkpCc2Nm?=
 =?utf-8?B?L29zUGs3MzRzbi9WdE1pTkh4ZWExMmwyNGh3VVhNTDhZZkF6MkZZWDRSVEJZ?=
 =?utf-8?B?c3BZSXZybFdHV1ZCK0pJU2lWeGZ6SjFhREJFRGh5b1hEVnI2Zm1aUkRMZjly?=
 =?utf-8?B?ajQ0ZUJXUXRpdzBHUzNCRTV4bmtxdG45eGFjTDIyT3pMMWF3eXYyU2lRaXlD?=
 =?utf-8?B?WHEzdnkxTjNzallQT3E3cHlJQzJlQW9DVTc3SHhUY2xtTEZpWFZCNnhKbWNy?=
 =?utf-8?B?UTdUNmQwSHhSblp6M2wvdDRGbGJrUW5RWWJaVkhpVUZOdXM5UFRacXFXYk1T?=
 =?utf-8?B?cGRpWDVvQkxnTHU4SFV2M2JKTzBmcHAvRFZnaGxhUzV2Z0ovd1VIdG5CMy9n?=
 =?utf-8?B?ZklVbzBpeGZMK0FSMnV6V1NmUGJTUHBsTTVuVyswdDVWOTZlM08yTGVtS3Rr?=
 =?utf-8?B?UkMrb0pPM1Z2amc3ZDNmUHZRcTZvMmlXdGZ0LzBVYWlleEwrV0tKNldjQ2p4?=
 =?utf-8?B?NzdnbzluRU9IZ2Q1Mmxta2tORThOVEtLVmRhUHBYVHpuSFJnajJsOFFmdEhR?=
 =?utf-8?B?STk4dk1KbnNMN0l5a0dmK1J3L09qQ2JjR2VtQ2lLQWx2QUtoMzJuYVBFQW1p?=
 =?utf-8?B?bUV0NXphTk0veFhpU2N0MytuaGFwRVJ3cEZETHIvQkd4WGhwL2MwTE5vRzMx?=
 =?utf-8?B?SzU4dG1OSFg2WVFSdS8vZHpnUXk2MU5JU2tlUVprOUJJb3R6M1RXTGVNci9n?=
 =?utf-8?B?NGZZbGQwaHMzTTBjQy9JZE5PTnBTZGdkKzZPUjVvbzZVQUROWE1BcUtRKzdU?=
 =?utf-8?B?R1FEbTNuRllma05PNFVrdmN4S0R2ZmtmQkxNZC9ZbWkxTFpsZzVDZ09DOGho?=
 =?utf-8?B?MUR3NFZZQWMxSkdUNFdLNGdHUGN1ZEpzN0V0WG1jN01PSXpxb0dMQ2xCL0NB?=
 =?utf-8?B?SWhTcnkyWkljR3kxOHhMVFllZ0I1cWtPeHJTY1dXd1pYbWg3a3pqWVVvTzZM?=
 =?utf-8?B?S0oydG4xSW1CYVNpOVRxc004T1hEdHYwL0J1eld3WXYrajNlMW1yaDh1enJw?=
 =?utf-8?B?dHFXcEhTVHVWeWd6Y0tiaGc5OFdqM0VWQUJNbThaMkVON295UXZTQTN2OXRa?=
 =?utf-8?B?TzhtaSt0cGVGajluZXpoQnRtb09KOTJpa0wwNkZXdlJMb01CdDBlTTEvNnFD?=
 =?utf-8?B?TlRMOWFrMnpXZCsxVWJHM2JqY3BtM2F2L3J1bHJqZGlQQ2FkZjJtYjU5WEVo?=
 =?utf-8?B?Vmwray9CTjBvUzhZWnhTVmFYcnBwdEEwZmwzd3B4VXJ0M2pmTWpaSG8wTE05?=
 =?utf-8?Q?/18MBmkrAu1DyEP++VDhiLM=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eaf2a03-db36-4325-505b-08dc23df979c
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 11:10:40.9895 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ix6N+niBIG0ML3NUwqN/xxE4kzRLzJIQNrpUN3UIzBMg+jqRZ0+0ph8ev9TDta2x6KyrAAlx+PKDtdgq6bELbMOpxK8Rw0E5POfUn68AZMhhlKf96SRSQKeMYPf34Fvh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9688
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

Hi Jonas,

On 2/1/24 21:06, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 2024-02-01 13:40, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 2/1/24 11:51, Jonas Karlman wrote:
>>> Hi Quentin,
>>>
>>> On 2024-02-01 11:18, Quentin Schulz wrote:
>>>> Hi Jonas,
>>>>
>>>> On 1/27/24 12:15, Jonas Karlman wrote:
>>>>> Hi Eugen,
>>>>>
>>>>> On 2024-01-27 04:48, Eugen Hristev wrote:
>>>>>> Hi Jonas,
>>>>>>
>>>>>>
>>>>>> On 1/27/24 01:26, Jonas Karlman wrote:
>>>>>>> Writing to eMMC using DDR52 mode does not work reliably or at all on
>>>>>>> RK356x and RK3588 boards.
>>>>>>>
>>>>>>
>>>>>>
>>>>>> This is related to the old issue I encountered last year with mmc write?
>>>>>
>>>>> Yes, I think it is.
>>>>>
>>>>> I did some testing on RK3566/RK3568/RK3588S/RK3588 boards with different
>>>>> eMMC modules with following result:
>>>>>
>>>>> Read seem to work with all enabled modes:
>>>>> RK3566: MMC legacy, MMC High Speed (26MHz), MMC High Speed (52MHz),
>>>>>            MMC DDR52 (52MHz) and HS200 (200MHz)
>>>>> RK3568/RK3588S/RK3588: all above + HS400 (200MHz) and HS400ES (200MHz)
>>>>>
>>>>> However, write had issues with some of the modes:
>>>>> MMC DDR52 (52MHz): all RK35xx
>>>>> HS400/HS400ES: only on RK3568 after changing hs400_txclk_tapnum to 8
>>>>>
>>>>> HS200 seem to be the most stable write speed that worked on all SoCs.
>>>>>
>>>>> So, dropping MMC DDR52 (52MHz) and enable use of HS200 (200MHz) seem to
>>>>> be the best option to get speedy and working read and write eMMC.
>>>>>
>>>>
>>>> 1) we have this enabled on RK3588 Jaguar in upstream Linux... I may have
>>>> improperly tested it then, would you mind sharing how you tested this
>>>> mode on RK3588 so I can reproduce this and fix it on our product if
>>>> we're impacted? I assume because we have HS200/HS400/HS400-ES enabled,
>>>> DDR52 would never be used? (our eMMC is soldered and support the former
>>>> modes).
>>>
>>> My main mode of testing eMMC in U-Boot has been to enable following
>>> Kconfig options,
>>>
>>> CONFIG_MMC_HS200_SUPPORT=y
>>> CONFIG_MMC_HS400_SUPPORT=y
>>> CONFIG_MMC_HS400_ES_SUPPORT=y
>>> CONFIG_MMC_SPEED_MODE_SET=y
>>>
>>> and from U-Boot cli run following,
>>>
>>> => mmc rescan <mode> && mmc info && mmc read 10000000 2000 10000
>>> => mmc rescan <mode> && mmc info && mmc write 20000000 4000 10000
>>>
>>> for each of the modes below.
>>>
>>>     0 = MMC legacy
>>>     1 = MMC High Speed (26MHz)
>>>     3 = MMC High Speed (52MHz)
>>>     4 = MMC DDR52 (52MHz)
>>>     10 = HS200 (200MHz)
>>>     11 = HS400 (200MHz)
>>>     12 = HS400ES (200MHz)
>>>
>>> on different boards and different eMMC modules.
>>>
>>> Using some modes the read or write return ERROR instead of OK. When
>>> ERROR was reported a rescan or board reset was needed to test next mode.
>>>
>>> Please also note that I have only tested in U-Boot, not in linux.
>>>
>>
>> Thanks for the tips on how to test these.
>>
>> I have run the following commands on an RK3588 Jaguar (master branch +
>> your v6.8-rc1 DTS sync patch series + Jaguar patch series):
>>
>> => for j in 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19; do for i
>> in 0 1 3 4 10 11 12; do mmc rescan $i && mmc read 10000000 2000 100000;
>> if test $? -ne 0; then echo $i FAILED; fi; done; done
>>
>> Which is 20 iterations of an mmc read at each of the 7 supported modes.
>> The result is:
>> 1 fail in HS200, 2 fails in HS400, the rest passes just fine.
> 
> I am wondering if your HS200 fails could be because MMC DDR52 (52MHz)
> was being tested prior to the HS200 mode.
> 
> What happens if you exclude the mmc-ddr-1_8v prop and mode 4 in your
> test loops?
> 
> I did some quick re-test on a ROCK 5A (rk3588s) and ROCK 5B (rk3588)
> with DDR52 removed and could only see very few read fails with HS400.
> 

OK so I did something completely different instead. rescan in one mode, 
do a read, power cycle, rescan in another mode, do a read, power cycle, 
etc....

All tests passed.

Then...

>>
>> => for j in 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19; do for i
>> in 0 1 3 4 10 11 12; do mmc rescan $i && mmc write 20000000 4000 100000;
>> if test $? -ne 0; then echo $i FAILED; fi; done; done
>>
>> Which is 20 iterations of an mmc write at each of the 7 supported modes.
>> The result is:
>> 20 fails in DDR52, 2 fails in HS200, the rest passes just fine.
>>
>> So it seems DDR52, HS200 and HS400 aren't stable on my board, but
>> HS400ES somehow is (which is enabled in our defconfig).
> 

I did the same for the write:

rescan in one mode, do a write, power cycle, rescan in another mode, do 
a write, power cycle, etc....

And this brought surprising results:

EVERYTHING except HS200, HS400 and HS400ES failed. Like not even a block 
was written.

Now, that was not really what I remember happening yesterday. So it 
seems that the modes before HS200 may rely somehow on previous 
rescans/reads.

So I tested this theory by just running a single mmc read of one block 
after doing a rescan and before doing a write. This didn't help.

Now, I forced a HS400ES read before doing writes at modes below HS200 
(excluded) and they didn't work. However, once I did a single block read 
in HS400 instead of HS400ES, the writes in those same modes started to 
work (except DDR52).

They also worked when doing a single block read in HS200.

For all those tests, I still had mmc-ddr-1_8v in my DT.

So, I would say everything that isn't HS200+ is broken on RK3588? Did 
the modes below DDR52 work for you?

Cheers,
Quentin

> Please re-test with DDR52 mode skipped and see if you get any other
> result for HS200 mode.
> 
> And you are correct, HR400ES seem to also be working fine on my RK3588
> boards. I can see now that on my old testing commit [1] I only mention
> and drop the hs400 mode and not the hs400es mode for rk3588. Could also
> be the change to emmc_data_strobe pinctrl that got synced from linux
> v6.7 that help improve HR400ES mode results.
> 
>  From a very quick re-test on two boards with two different emmc modules
> I could only see a few "Select HS400 failed -70" lines being reported
> when testing read and/or write using your test loops (with a few modes
> skipped and smaller amount of data to read/write). Remaining modes seem
> to be working okay.
> 
> [1] https://github.com/Kwiboo/u-boot-rockchip/commit/cb1521aea8dee730bddcc5772afa28aa71fc69f9
> [2] https://lore.kernel.org/all/20231205202900.4617-2-CFSworks@gmail.com/
> 
> Regards,
> Jonas
> 
>>
>> I'll check if there's an easier way to test the Linux kernel than
>> rebooting with a newer DTB between every try.
>>
>> Cheers,
>> Quentin
>>
>>>>
>>>> 2) Why are we not enabling HS400/HS400-ES for RK3588 boards? You seem to
>>>> be saying there are issues with HS400/HS400-ES on RK3568 but you didn't
>>>> mention the status for RK3588. Did I misunderstand the last sentence?
>>>> Can you please rephrase in that case?
>>>
>>> I can see now that my wording was very confusing.
>>>
>>> Write for HS400/HS400ES mode only worked on RK3568 after modification to
>>> the driver, on RK3588 write always returned error for me.
>>>
>>> So on RK3568 HS400 modes could be made work, on remaining SoCs there was
>>> issues.
>>>
>>> Regards,
>>> Jonas
>>>
>>>>
>>>> Cheers,
>>>> Quentin
>>>
> 
