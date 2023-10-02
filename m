Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13150E74914
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 19:21:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17E1386DBC;
	Mon,  2 Oct 2023 21:21:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="O1WZMd80";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 929BB87160; Mon,  2 Oct 2023 21:21:13 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20731.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1b::731])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A523C86DAD
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 21:21:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AtvCFI4R9jP+Du+vjdZZhCSZeNni/yAVkFABpekEecHVljd/a4U2Go5HBTnuOIfXEQ8iJhY3Aj2ZHsvfO+N8gG0ES7SntMamQxeCFYSKuaRL3qWP1vMvoFRnUlD0qMzZbLBGm5aVepPJDjDZqcxgbhVP0gunPgk3IbEpUe/1PjwjwaVzP8C0iujCoQfiijgRfqNiBecqr/6fWqNB1aNkRMcH8PesK3FHlSXtoKMohZHxgMmEvjwQQYyQWHrMciTaphiJfP/y+YNu7/L+YRctLzlB35q4AWIjybR10J7PrLdawPGfQLfQfUc7MYxLQjg92qb250SaShds19bWn1DH8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CvD89R2wECg4Yn9LR/9ki+mHG3//wEFxQ15dD3jJszA=;
 b=lvh0azS42hvwiryNkNJPsHPBhe0Q4t6ZASWDy+b+Y7oWlA8aj9EBHxAaaMf4bKKi/vKNXCGVfDL8aw5saJ3wqwoEgn2tSOXSG5t10U7xAfbNtLsXW6yMklU/RCaJt1BtfcbKi/EwBPg2cFa2Yfpn+qGf+KZtlMuOvjYZt87iUJUJ/tbFV0+5Clyn23aws9e4bjVdQemEsbvwVRciskvJlSuQJwfePPyx1B8HRIphbudCwQM1twuXzXB23QaU9fsXaXMBrdw2pruh8VUy4yreST99RPlv3RCJLd0VxbyIBrh8nPpRXsdho4yP6PB7ClJekvzhrW55voUlSgAp4R06EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CvD89R2wECg4Yn9LR/9ki+mHG3//wEFxQ15dD3jJszA=;
 b=O1WZMd80uOsLNdoSvbNrm3Dn/qBAZswhNFki+L+oTSmhrKzgDHYaXjGp3aIkDWmIPmWIksyihNUzBoG/FLX9H0hTz8MBQo6XLdf3K/oqipYASkxR8ULd29JSz8HOCbMNg0XyKZrAyiLQCc1TElac+MlZRaZwyoI683WK2kVlfX4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by DU0PR10MB5803.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3a5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Mon, 2 Oct
 2023 19:21:09 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5%7]) with mapi id 15.20.6838.028; Mon, 2 Oct 2023
 19:21:09 +0000
Message-ID: <b5588e2c-93cc-93a1-3b6b-8a56c8e7f45b@prevas.dk>
Date: Mon, 2 Oct 2023 21:21:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] scripts/Makefile.lib: also consider
 $(CONFIG_SYS_BOARD)-u-boot.dtsi
Content-Language: en-US, da
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <68f445de-c903-c3a1-906f-2cf7b5675d08@prevas.dk>
 <20230925181940.GH305624@bill-the-cat>
 <08e35aab-309c-a8e1-931e-7ab142beb593@prevas.dk>
 <CAPnjgZ3jO5s3HZRjXdG-dVLNmGYnyCWnpvzRKpKhBCRQqWH33Q@mail.gmail.com>
 <20230929160230.GP305624@bill-the-cat>
 <CAPnjgZ29hTMrzey1eZreTKhEVXWvi50JWBw-kUKC2VUYgXLYsw@mail.gmail.com>
 <20231002140854.GU305624@bill-the-cat>
 <CAPnjgZ0TTNCEUHfHDr7tALx+Po9PDoD-R7zYeN2gc4wnkWqSzw@mail.gmail.com>
 <20231002151212.GY305624@bill-the-cat>
 <CAPnjgZ1fZjxTi8ryiVZC=Js1MDfP+PdGbJK87BA_kJe52d038w@mail.gmail.com>
 <20231002162203.GZ305624@bill-the-cat>
 <CAPnjgZ0K-pP9FUxn-k+XeWZTdt+Z4XafpgJRJ5eUM7izZ8==PA@mail.gmail.com>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <CAPnjgZ0K-pP9FUxn-k+XeWZTdt+Z4XafpgJRJ5eUM7izZ8==PA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0019.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::11) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|DU0PR10MB5803:EE_
X-MS-Office365-Filtering-Correlation-Id: a4cf0b45-03e7-430e-d30e-08dbc37cbb75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hOWR+lirB9YqAUMOEd1b32zDujBqY3rIEUAFRT+HvVRfF1/LiydLacPo+SLFlzZ8JeglEFL4O5IDXE9wXi4zyND8ObyCF5deS7QZRSn/0reChJ5DHZJZgB3TS+hMhF91/jfNX7jwHnIw0nbygCvlL78NrGAdbnTAjViQIzUNmNbcy1UmrlFQo615l4GcDgpKNIuBZwWO40p/Ba9gzMhygPI3oejEj5FSSPn5dvjvcGZpklVBoUaymmaj9fV9EnRlK6ropk8CBXkkyGL4CkHkszf9S4IV5calvoidfnunTLRw05Y/T4CQjSpanfxP3rZYFa0Jm0WTCdkg/93s2JsqKWhYD4+oqZK/szRQTYYRQr5bGo1EJ6I2SIHsVCVysNa2uwepuG1gAekG/QjxnlprepjnANCugKmE5uMZ7gv2mJX/OTxKQP1wuT2zQxfdw/HGg1XjJ6GnZtuQqn+8EfcPjxrhBNwFtuZS4FDiMQT0wHAtGlkXuJtIHy39dGF/EVI1grILz3n3nUIUS41OMFm2pVjuF6QfWEFhgxk0VNoYXd5mAJYsuXeD3VpikKucWIwc0r2Ovduh+aq3jlhdfl64cL67JDY4PzLTfl/wFIKayBQcU8a1vg/K//LiHif/vHB5wk1nT4hpd4YtHmB9rtMqISEkY/XtOhzgJtXSIYbPXkBlQQZStbAnBN3ObUUu8W66
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39850400004)(376002)(136003)(366004)(396003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(2616005)(6506007)(52116002)(6486002)(6512007)(26005)(478600001)(2906002)(8676002)(4326008)(44832011)(66556008)(110136005)(5660300002)(66946007)(66476007)(316002)(41300700001)(8936002)(8976002)(36756003)(86362001)(38350700002)(38100700002)(31696002)(31686004)(66899024)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3RUbCtDQjdwWDAxK2NRNWFuRTEwL09obFpmcElvUG42N001NTRBaHdWK0JB?=
 =?utf-8?B?Uy9kL1RCSS81NXpxV05hNEVCY3FSV2d0NWpBbWxyZGZXZnJEQnhZVnROZUNm?=
 =?utf-8?B?SnM4b0p3YTJZY3lDYkpnRyt2M24rM2RPUWxvSEtMTWw5NlpMVkRZaU9pWFp4?=
 =?utf-8?B?Y2dzOGRCVERoM0dmUTBMTmVJNW1BbTRHM29qVzUxdUdyeXJlY1VTN01kNDBY?=
 =?utf-8?B?b29Ma3kwaW11clR4STdHKzcrbWpuTENKWEl3NVNDWjZXUzlYWHovbk5JaWNt?=
 =?utf-8?B?TzhIVndCSElWSkwxYlJucGQvNTZvaHVaNDBrSG5uZUE3Y3l0a3Fla29WNWxw?=
 =?utf-8?B?a1hDbHlkcXV5VHFUSFdIUGtUOW9jUHZrSE9lWHpOcDRKejE4d29sT3VGb2o1?=
 =?utf-8?B?VDlGWnJvWXYzWGhaVGIxeUhLYisvTnh4emd1eVBRUjRvTHJ6SDArOW5ZL0p4?=
 =?utf-8?B?VFRRZ3BLOHFER1hDaStBUHlDV1NaekhZVjljdkZKRjU4cDFrMmxlMit5WVRQ?=
 =?utf-8?B?R2ZwdUd2Y3ZYQkViSHllMlFwVWI0TS95dXdEZEYrbGRldEYzT1owenRDTkVQ?=
 =?utf-8?B?aUxrQzJrb0wzRXNLeGZ6dmlna2VWZVp2Y29OYkY0aWZlWXBJa1BxUlBTUmVH?=
 =?utf-8?B?MTl6dHBPd2Vsb0NUY28wcWUwVG1weGdVbGJaa0p1L3VXa3RSbFV6VUQxSEFm?=
 =?utf-8?B?SHZiT0F4NUppZVYzWWF3WUhQT2dQWjhMTWFTeiswQXdabzJ6eGMvc3FBWksy?=
 =?utf-8?B?MnlNN2EySUNMeUhBYkVuS0V5aTA1cFIrRG8wdjVNVkt2eFcyYmdBMktkcFc5?=
 =?utf-8?B?SEEzdUpaK29UNFRuZ01UeU1qRjVqZG9BR0M2S251cVNiT01JaDc2Wk44VEJy?=
 =?utf-8?B?R3luUmVDdUNoZmhlbEo3cEloZnhCZ05PaHlpZTdsWTF6T1N2d3hRbm9YS0hQ?=
 =?utf-8?B?bk5NY05lR2F2QmJHY09kSy8vT0t5bDZYTzZ4RVl3YlRvaElzUXd1MExMNENh?=
 =?utf-8?B?aWIyR0VTZGVuR1B1QStKY0I2UWZBVUJ5QUtoQnk4c2FyTjF4dklpeHB0WENk?=
 =?utf-8?B?RWpFYTJCbTAwOG5YeEdvRSt3MG5PODJLdnM5TmlzSFhFMC9nT1FmaGQ3UlNG?=
 =?utf-8?B?bXNOd2xZTDZ0SU9xdFo0Z1BBVVAvVEFTRG5wRG04akZBcEQzLy93bndITE1o?=
 =?utf-8?B?VXBrTDBGWjc4ZFl1Y0QzYVAyUVdXV1ovVDBJY0cxSHd3UzRPVGNFUW81dSs4?=
 =?utf-8?B?WXB6a0kxaXppUTdHQ04xVWI4akNHeW8xQVNjWThjVUFKeWlOb2pyMkVYdlVt?=
 =?utf-8?B?RURMdGpvb2VBQXArSmU0K1N2TzNJVzhYbVJCdlhrS25hTmJpV0JqZWlMVktx?=
 =?utf-8?B?SWNBM0xaNkhESjhiZGRjN2VHOEJkVDZTOHAyZjJSbkJQRU9Hdy9JbFBDTVE1?=
 =?utf-8?B?ZEdzWUt1aFVWZ2RhWmtNek96by9xZkdleEZaTE92ckpGTTRWWWNnV1VuQUd3?=
 =?utf-8?B?QVloUGdMZWpZalFzVFZva1ptVE1GK3BRVFk4MWtqaGhkNEsxenIraitiUmZV?=
 =?utf-8?B?d0ZRZjNqMVBJbkVTVmpTenB4L3FMcHNZaHJiLzJmYW1TZmZNN0Nlc0NlTkx3?=
 =?utf-8?B?TUI1dUdKVGlxL2ZVd1VqYjI0N1RzQWlLNE1OcXkxeHBSS0pMZ2FjbERTeEli?=
 =?utf-8?B?UDBhbzBjam45WE4yU3F0d1QzMHhQVWt0enNhdXRqcXU0VittQWNxQjdyOFAy?=
 =?utf-8?B?MnZpQTBnQWJucmlWanhxQ0QrKzI5bVZicHg3cThlWWluQTlOODBJNENMd0Z4?=
 =?utf-8?B?YTF2bkNGeEY0UFN5dCtsb1g2d1d1NjRaWk52YklobW5tVmc0UWpjWnpIZHZO?=
 =?utf-8?B?bkQ2azVkUWpLNHJFeWd2bllWQkZDYStwclBicE5OSnU0NXhBRFNrY0dOTjd5?=
 =?utf-8?B?U2wxTHdqR21TNS9PZjA5Z1ByWXArVmtobGJVZFcyS3pFMXJUK1FCVjNrUGlq?=
 =?utf-8?B?V1FLSUlIM21JQkRRNkN0SUFRZ2R0Zko2bkxadnFSTkx3UW1rejd3VGw2cTBS?=
 =?utf-8?B?MU9EV05PbWNYU3RFTVp6a1FYYjZRcTJabk9NRkxja2tWQmdLcjNvZ3BJSzF4?=
 =?utf-8?B?d3VHR2p5OFhlRU1lN0d5RmgzbWZoUGtkYjh1dnFwUjVRMTVENnpFVXVUc0JN?=
 =?utf-8?B?Z1E9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: a4cf0b45-03e7-430e-d30e-08dbc37cbb75
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 19:21:09.2543 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B7gtipw+Q3nqhWFCWNQkitNKsgRLmRcHdBK6/+8adrOzSactxAZRnyG6Q8xI+czEkApy2/yCtBM33zhFkqAMfLCS8T+d6Nal3mEg63x6FZg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5803
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

On 02/10/2023 20.56, Simon Glass wrote:
> Hi Tom,
> 
> On Mon, 2 Oct 2023 at 10:22, Tom Rini <trini@konsulko.com> wrote:
>>

>>> I'm really not sure that replacing build rules with a board CONFIG is
>>> a good idea. I suppose part of my confusion is why the Makefile is
>>> considered a problem?
>>
>> Because it's duplicative and as Rasmus points out, often wrong.
> 
> To me, that is under the control of the board maintainers. They should
> not put CONFIG_SYS_BOARD in the DT...it obviously goes against what DT
> is for and I'm not sure what binding would allow it anyway.
> 
> If it helps, I could do a little series to remove those? I think it is
> just arch/arm/dts/rockchip-optee.dtsi ?
> 
> This seems like a case of throwing the baby out with the bathwater.
> 

Huh? I don't think you understood what Tom was referring to, and I
certainly don't understand what you're talking about.

(1) duplicative = the _defconfig already has the necessary information
in *OF_LIST / DEFAULT_DEVICETREE

(2) often wrong = people add .dts targets to dtb-y, not .dtb targets.
They are harmless no-ops because people do get their .dtb files built
due to (1). "often" is perhaps a bit of an overstatement.

> We are trying to use DT (and not custom C code) to deal with the
> differences between boards. So long as that is preserved, I am happy
> enough.

Of course. This has nothing at all to do with C code versus device
tree(s). Just how we ensure that all relevant .dtbs that get built today
with the massive [mostly redundant] lists will still be built if we
remove all those dtb-$(FOO) += lists.

>>> The OF_LIST option is a little vague but I think it means that the DTs
>>> are packaged into a FIT in u-boot.img - is that right? But they
>>> presumably have to be built first.
>>
>> No, they don't have to be built first because scripts/Makefile.dts
>> ensures that we build everything in *OF_LIST.
> 
> That is from this commit:
> 
> 3609e1dc5f4 dts: automatically build necessary .dtb files
> 
> which was for use by custom boards using a private branch. Did it have
> a wider purpose that I didn't understand?

Not at the time, but it turns out that since we now _do_ have it, new
in-tree boards also don't have to modify an arch/*/dts/Makefile, and do
it wrong.

Rasmus

