Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02FECC47DB3
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 12:45:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3158287C6D;
	Fri,  2 Feb 2024 13:45:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="BQDGt0y6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F415687C75; Fri,  2 Feb 2024 13:45:03 +0100 (CET)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on0720.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1e::720])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FD9A87C6A
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 13:45:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nc1YBzxmLcSDUX6Ll2maaqqeex6BbDJ2rZLjuxdb+7oW/e7JgJogAqeNzHim56n844DQbk1mqrQjshPAwdmHXykIwHfbhWCrnc0kzEzMOslCMEjIMPbXXMXp5c9Bzw9vuWfR/tNo43prnGYARpmLxRRVE/sqKfIwonGKqV6573Se8mjY40YWhfuCaKwsn6F+xx/XVMzTJECLFAzcKACmaXTyrA7Q3s1hIeyqg8I65ycYoAqNezn24J5P8K3/edmSFSdzR8f+1EGhvDWNFx3kDkIOsvrR4DrUTVKz36esIF19ML2E1t/5ZRqwNhf5j5i5GZKj5mHvZlguZYein7Vzrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZTYZdCpyl0eOtVcY7b5V7G6ZCGIBczpkg5Y++11WWro=;
 b=STwNs74wA5eommvLcq3h5X3/4/Qugws+lIHC6t48DF+89bNZwF57O1vUY1YewvBhB35rhIeeY/jghbfXZmpxNfTAQQVGRL7NqR11tNAutXzUztXPT0vecE4znFjOldaqGvqiGn3Pz0Xam09N5nlz5Pt+am7KfsItYbxeTrnDve69t2Atg/8d4j7b2D5302v82do+AfyK4q+2fnS5Sp2EX2RCBEycwn0Fo5B5OW4Jcexjm5vDHf7YYSA75QhWPKbCbjeAaoJg481vflB14gczV8i1p2n1OSlmuL3lnsBp24uBssntwHTDW+t9gt7cxDHGrzBUwj8TGU/HvU7gVj3eRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTYZdCpyl0eOtVcY7b5V7G6ZCGIBczpkg5Y++11WWro=;
 b=BQDGt0y6dWGPaef592w/JJ8gSjM3ekXpMlcC/Bc9EFs83PRjWQYNsfsqTs5mvim2LPl7ygs1+1lakQkSFzdDryogm9f5Ieb300ah2BhjtsYHJdxBazh3bNCNE3TQ6ylf1jUvfY33Y+mBqME7OaIyokK9H4VO2/6KaawGoul+3AtonEQK7b/dCoRHtsMuzVCr8nTSsIrbe/0LaQD8AVs8jK5RoSMPMQ/YKlUb2e6XnsaaOBRiF/Bb21PniZfJYt7HKJ5T0D6R08a3nxdYR13gsZ6+CCcW/kRA8vsEVb4YX7GlCvAi4F0pcu+5ftygdquyBSDMOFkUi5kawBx63/Ivbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by AM9PR04MB7505.eurprd04.prod.outlook.com (2603:10a6:20b:285::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Fri, 2 Feb
 2024 12:44:58 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e%5]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 12:44:58 +0000
Message-ID: <344d6560-46ef-47d2-a498-0011c63dddbf@theobroma-systems.com>
Date: Fri, 2 Feb 2024 13:44:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] rockchip: rk35xx: Remove use of eMMC DDR52 mode
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
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
 <10f0b268-0a9d-41a8-ba4e-d02abb62e418@theobroma-systems.com>
In-Reply-To: <10f0b268-0a9d-41a8-ba4e-d02abb62e418@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0410.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::15) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|AM9PR04MB7505:EE_
X-MS-Office365-Filtering-Correlation-Id: f84bbbe1-0bb8-4bbd-f386-08dc23ecc39f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MADEbGzdVqnugdzW52vHNS8pKR2tU/H/0Yc1qWr9+NBUoYIxue/CArbrPknPoUsdj22hCt0f32p+C2XROa0tRqKmfkdAXY6plxD49I+I5IQnZHvOeSd8pPLWo4Y8B2mOoH2iKEtW3oWDpZXeYxk8SMGx70ObiNXW3Jq6jwUSB8KCAthsbozq0KIZkGzAuKHFS3CVDgrYY18w2xWhkL3Uc6yJS5IIvpdyKGp72/jyuAqE9NESgUwlAzqt98ozccm7pWGtQ/GZ7ywgx8CeuOx9fe2MOXPAYygHPXz1AQHvsqOa68g7tP5vy274jbsc7SbPfXKP/8OBn01K2J5FcJXDdAvko68SWCp6/soV/a8b+kwhBLVTeM3srR7O1U/FRuSz/UiFwcgVJ6WJS/v1yoSM2GZoYJhohrG1BQBZe8nBiN7prjljYYscw2G+mTLdZRHuUzWrV/oKKiZHE4zr83Mxh+4fxx0hb0V+eDhm5ukfMLXfuLrO6u2/rktAd8ry/CFHN2Z6Bp9UAPM+GaD2mzECzymg8hbVtu1sRF+V0Aoh5Q7IbCZ4hoKEOB0bJbdc0Rrw1BBYE/HdDczgKSBxpHAcIAtwjctla1zqp4bBE9pvcPz7OiNkdYdl4SJp8pDzAf97URgi8tPvw2wI0E7s6GTudQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(396003)(366004)(346002)(376002)(136003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(31686004)(6486002)(966005)(41300700001)(478600001)(38100700002)(26005)(53546011)(6506007)(83380400001)(6512007)(66556008)(316002)(2906002)(44832011)(5660300002)(66476007)(7416002)(36756003)(8676002)(8936002)(110136005)(54906003)(86362001)(66946007)(4326008)(2616005)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eU45RXBCNDhkS1NIWmVyRTZDQ2hKSGFzSVo4Rk5yVk9BQmFEa24xbzZCcWtM?=
 =?utf-8?B?YWtlaWphUy9SWUJqbVNiV2JPQVB0N1pjeVZPd3ZzajgrRTFYZng2UFF5UUEw?=
 =?utf-8?B?N3A5d1pOb1FrNVh5eXZ4VXlXcG85YmFPUlYzbGVHNThoUDcxOFQ5Q085bUpO?=
 =?utf-8?B?RFBoK3JzNURCU2dRWVpGZmoxczRIYWFIS3BDYmtTTUNPSThDQThuZjJISzFW?=
 =?utf-8?B?UlVUYXdPRDZkd1hCNlZoR3p0b0VMSGVyZ1dJeGU4OS8wd2owVjg4TVdmR01Q?=
 =?utf-8?B?WEtoSDFzUlBnempYTmZYUEFxL0g5T3Evc2ZBckJGaG1IYXU3YnB5QTlJcWpD?=
 =?utf-8?B?aFBSOUo1RHkyRUdGT0tHbXczZmVxOVE2U0dPb0cyK3ZrUVh5ZXgreWprSHFz?=
 =?utf-8?B?WTBoOVZWaEZjc2txZTBOYTV1MmxFQzd4QnhDQWxWbUhGeEJiSzlTNlVzR1do?=
 =?utf-8?B?UmtQT1RnM25sbS9wWm1GVmF4TkdsOXRIeXRXRnBXVzBSSnZvREU0YXMwcGJ4?=
 =?utf-8?B?MVZhV2xDeTJEb2pnZ1A0Sk1OY3lzdnZHY01Tc1FucDl5NEQ3aHY0eXcxVmdN?=
 =?utf-8?B?WUhmbXVnelgwQkFXVS81WXdrQ0RBY2xlTHJ6bzdGWCt2M2ZZVU5zUUdadmFV?=
 =?utf-8?B?WmRucFhzQ3lvc0pGaForbVhFNXZNeG54QUJIc04rQzNDSUdCcS83eDhlZVFl?=
 =?utf-8?B?Y1BaZUpCb05xNjZPN2JkTW5xenBzMzZJazdwNzEzZElHNTFhREwzYUhGUzUw?=
 =?utf-8?B?SkI3Qk9NeE4vTC9mbzhyZXNmRm1PNGU4OGJUbW45Ulp5Ulk2TjVxQ0tOS2hK?=
 =?utf-8?B?VUQ4WXNkUEh2RlJwYW11RDFoSE5aL1FBZ3c2K3dFRVpkVmhxNE8vK0dPTkw2?=
 =?utf-8?B?eU1NUHByNmRjT3FhRGY2Zkk5V2hwbDVzL0s5NUFodktSSk41ZlNGRVFMaHFW?=
 =?utf-8?B?MWJvdGRKNHIwbEZkT0NqVXlCUVB0V09lMmUvbnFjUmNwaWo2U2w3SDYvQU4r?=
 =?utf-8?B?RWtncmdjcVBCUXJrRXROUUtMK3AvT25Gd25aSTVaNE54ditweUw1ZDNHOHpj?=
 =?utf-8?B?bmp2V0pmUGhlQmZ5Z3BnalErekVZcWFiek9YMDIxSU5CN21naDJMUWRGUHJV?=
 =?utf-8?B?RWRsb2h4Tko0NG9EWXdCWVVKaUY1d08vSnliVlhPNFVTYmUycU5ITjNvUU1X?=
 =?utf-8?B?aEhOUm4vOHBFRTNqeGI0YjJuTVNGV3pRK2Y0aGdTTWZqc2d0bnZ2R2VTS2Fq?=
 =?utf-8?B?NEpaeHlLQk9oMkg2N3Q2K0dhbTd5SCtJK1h1Y2tKYjE4cWZ2amdLYmdpMTd6?=
 =?utf-8?B?ZFBDa1lpRkgrMG5vZnUyd3JUQ24vT1ZPcmZFTmttMWJuVWtmWXdGMVlJQzlN?=
 =?utf-8?B?OVMyTDhoWmNSOGJubFpNUUxMN1ZGd2dvYSs2YmhwRWJzWjdWYllXelFpTm5W?=
 =?utf-8?B?MzVlZ1FHc0hqNjJ4V012cTdCK1hpeWExMVhUaGF5aHZ2eUwzTUpXa1pucC9X?=
 =?utf-8?B?SjNVVGFOa09BbWlyaC9pRFJmWEZTZlNqODB2S3psaVJ5WmRhKzVBTUVoYTIv?=
 =?utf-8?B?Q2pyVFc2RGNGaUZUY2FaNFVzRmlEeU11UGV6c3BIUHRSY3FVdUdPMDZra2xG?=
 =?utf-8?B?YlVYcWhrZ2swV0Q5dEdwQUdnOWxHNGo0WjBWaXFKS1hNRThsRFZNRmdkaGk3?=
 =?utf-8?B?YnVOa0YxS1pqR0ZBTHRHR1J4ZEIxZE1iMUp2Si83a0JONWRIZkZQSHdzSlBL?=
 =?utf-8?B?K0k4SjhQVnpzcU9WSTFhNzUyNXFYSGJHcmFEQ040ZWtjZnFBSkp4MGtqbHNs?=
 =?utf-8?B?dUhRRzNkdk9EOE5kM2RDV0NLWmhXZDdXZVdmRFZHWG5mZzBudll6Q1VmR2Jz?=
 =?utf-8?B?eFo2V1cwMkZIVU96Y3ZjaGRXMzFrVEhQTHZpN0RqZk0yamt2Yjd2cElmWUo4?=
 =?utf-8?B?akNRNGE2b2dNcm55OE93NWw4anpsTGxiNUVDb2dXcE93MFdJZTZGbklLSnFn?=
 =?utf-8?B?QlQ4UmdibWJ5RkJsdEZoNVFjS0IxNC9LQm0rTG9OazVNV1FUOG9jaXB4Vnh1?=
 =?utf-8?B?WE9DK254eFREQ3RnODcvY3M0djdlUDJPNFlKcC9wMmhTay91N3Zwdng0MEQ4?=
 =?utf-8?B?MFpQMEw4MkZ6eWxLUGRla3RsWkg1RnQ2OGNjTTVGajI4aTNodXpXck44S1FO?=
 =?utf-8?Q?+FisE8FH9T/h8kW5rN69AcU=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f84bbbe1-0bb8-4bbd-f386-08dc23ecc39f
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 12:44:58.2615 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qmkXrPogF9UnDtCe1Il9+lvmacfR+cfHvwefwxjx54KJb3YtFdca1zcGUEoCxcqq+ZFsgTwgAbjrnX1VpFLPY7kSKIsdjVFzp7Q1a7i5nxYvNg2nd798ZbvqrWHBXvd3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7505
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

On 2/2/24 12:10, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 2/1/24 21:06, Jonas Karlman wrote:
>> Hi Quentin,
>>
>> On 2024-02-01 13:40, Quentin Schulz wrote:
>>> Hi Jonas,
>>>
>>> On 2/1/24 11:51, Jonas Karlman wrote:
>>>> Hi Quentin,
>>>>
>>>> On 2024-02-01 11:18, Quentin Schulz wrote:
>>>>> Hi Jonas,
>>>>>
>>>>> On 1/27/24 12:15, Jonas Karlman wrote:
>>>>>> Hi Eugen,
>>>>>>
>>>>>> On 2024-01-27 04:48, Eugen Hristev wrote:
>>>>>>> Hi Jonas,
>>>>>>>
>>>>>>>
>>>>>>> On 1/27/24 01:26, Jonas Karlman wrote:
>>>>>>>> Writing to eMMC using DDR52 mode does not work reliably or at 
>>>>>>>> all on
>>>>>>>> RK356x and RK3588 boards.
>>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> This is related to the old issue I encountered last year with mmc 
>>>>>>> write?
>>>>>>
>>>>>> Yes, I think it is.
>>>>>>
>>>>>> I did some testing on RK3566/RK3568/RK3588S/RK3588 boards with 
>>>>>> different
>>>>>> eMMC modules with following result:
>>>>>>
>>>>>> Read seem to work with all enabled modes:
>>>>>> RK3566: MMC legacy, MMC High Speed (26MHz), MMC High Speed (52MHz),
>>>>>>            MMC DDR52 (52MHz) and HS200 (200MHz)
>>>>>> RK3568/RK3588S/RK3588: all above + HS400 (200MHz) and HS400ES 
>>>>>> (200MHz)
>>>>>>
>>>>>> However, write had issues with some of the modes:
>>>>>> MMC DDR52 (52MHz): all RK35xx
>>>>>> HS400/HS400ES: only on RK3568 after changing hs400_txclk_tapnum to 8
>>>>>>
>>>>>> HS200 seem to be the most stable write speed that worked on all SoCs.
>>>>>>
>>>>>> So, dropping MMC DDR52 (52MHz) and enable use of HS200 (200MHz) 
>>>>>> seem to
>>>>>> be the best option to get speedy and working read and write eMMC.
>>>>>>
>>>>>
>>>>> 1) we have this enabled on RK3588 Jaguar in upstream Linux... I may 
>>>>> have
>>>>> improperly tested it then, would you mind sharing how you tested this
>>>>> mode on RK3588 so I can reproduce this and fix it on our product if
>>>>> we're impacted? I assume because we have HS200/HS400/HS400-ES enabled,
>>>>> DDR52 would never be used? (our eMMC is soldered and support the 
>>>>> former
>>>>> modes).
>>>>

OK so just tested this in Linux kernel 5.10 from Rockchip and v6.6.7 
with some patches for rk3588 (and the jaguar dts). I ran the following 
tests:

$ fio --filename=/dev/mmcblk0 --rw=read --direct=1 --name=fioBench 
--bs=1M --ioengine=libaio --cmdprio_percentage=100 --output-format=json 
--allow_file_create=0 --time_based=1 --runtime=60 --ioscheduler=none

$ fio --filename=/dev/mmcblk0 --rw=write --direct=1 --name=fioBench 
--bs=1M --ioengine=libaio --cmdprio_percentage=100 --output-format=json 
--allow_file_create=0 --time_based=1 --runtime=60 --ioscheduler=none;

It worked in HS200, HS400, HS400ES without any issue. It worked in 
high-speed.

It was a bit "difficult" to get the kernel to switch to DDR52 because 
even with the property gone from the DTB it would detect the card as 
HS200. I had to comment out 
https://elixir.bootlin.com/linux/latest/source/drivers/mmc/host/sdhci.c#L4558 
to force it into DDR52 (or what I assume to be DDR52 :) the kernel 
prints: "mmc0: new DDR MMC card at address 0001" ). It failed reads in 
that mode so didn't even test writes, but not sure if it's a fair test 
with the aforementioned line commented out. I see it's also there in the 
SDHCI implementation in U-Boot, so maybe it's just that mmc rescan 4 
doesn't actually make much sense to test since I would assume it would 
just detect it as HS200 even without the DT property? (or maybe 
something really is missing there in the SDHCI logic?).

I couldn't quickly find out how to put the eMMC into non high-speed mode 
so gave up on that.

Cheers,
Quentin
