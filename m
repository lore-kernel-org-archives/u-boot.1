Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F6AAC072A2
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 21:10:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF74C870E7;
	Sun, 19 Nov 2023 22:10:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="V2kmig6N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3BD587185; Sun, 19 Nov 2023 22:10:56 +0100 (CET)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on070f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0e::70f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F327871DE
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 22:10:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ixu9+uFQsbVH73z3rPB9x8XEn2g+tCZbY9gWKez4IyeYAoXXjQbcoGf4eIvILbbmsha15tpX0CNwR2Ij1Asa1MbudpmJQMAtBwhtJKqsEbqHqqImWRzXROHerMTMMo3b6Bkyel4hQFfr1Cav//bUN4wK8Q5P7I7WqDuULpFMqutFn8PfXd8+QT9VJhonv1dllT3/ZrOJbkgOb7WK/kD0UvUQ/n4sxq5iZAX+8gvJwAeHldV5xX78LcKBChU2trys2VAGqBLv+1USdAeL+J4pwhNw1gluzcNuZ0noJxkS/FuUmQJ0wYxVsh+5zlFOCg04x+zKVweKtU8E/BQEojqYEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rHM2IoZGHVzf9SmebgCHEbCACkRc7kFwAccpTrRpOzE=;
 b=j/Ro8IjdXKMgDQcXaN84S2AvWqz0fAZqBEWPu213jo4+OeuLcE2TrDVBWANfQ4yLYcrpxir0Mm+cx5QF1u2BQ21OuxGUm/6cfgz0NiJdIVmS0IaPR5O+DeiV3r+RLycQKf2KmaAaTQQgPyH7b4yyp75nLXXyTqct6FjHM4gsXlbw60jNk1/Dz8KLRvUxq+0Ij357SUEF7NbwS8mPfJTJQvnMLiHnm/63J+BjTjecY4IpnF37Zm0b0jV4TUqj4YcjNdTTxujG9N0X6gZTwA4jx7SCsxnWC7+JzONRSPMKmmyYnvwuGsOAetEb1Ja/Q72S4bJ42dusdJ9uAdoZibqddw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHM2IoZGHVzf9SmebgCHEbCACkRc7kFwAccpTrRpOzE=;
 b=V2kmig6N10NqTXwGfjFfZMEsOYN5v7sR7u33uZYB0bJOL3sIIG/V+AJ0CwPYL1D+wBgLGZOnJOkzHEfdOXVI02bArZ40ni6XSq03JzCvRIZiDJ86lMU0kqc/IgI7/TdnXDYolCi9fFRtfhgCaKWYFMxoFK/cER4c0UUUZocfGx0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by PAWPR10MB7792.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:369::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Sun, 19 Nov
 2023 21:10:49 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8bd9:31bc:d048:af15]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8bd9:31bc:d048:af15%5]) with mapi id 15.20.7002.026; Sun, 19 Nov 2023
 21:10:49 +0000
Message-ID: <dff7ba0b-6299-4413-b1d3-8409cfe58c6f@prevas.dk>
Date: Sun, 19 Nov 2023 22:10:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] global: Clean up arch/*/dts/Makefile
Content-Language: en-US, da
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20231117225214.2144414-1-trini@konsulko.com>
 <CAPnjgZ23gJb6mu53Tmmy9OdaRLu9zCCLgJTGsTVjjKcCv63VqA@mail.gmail.com>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <CAPnjgZ23gJb6mu53Tmmy9OdaRLu9zCCLgJTGsTVjjKcCv63VqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0093.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::16) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|PAWPR10MB7792:EE_
X-MS-Office365-Filtering-Correlation-Id: 4be3aa02-6a2f-4ef3-353b-08dbe944011b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AA0+al7OJjmz3jI1aFutL3NIIy2yG9LrXETPzlvWVk/gJP9h81Tl//xOmY4C3eyFZqSy4Z4LlLR0u2DaU3CDKYFblP9AtVxUcxy0g92660SVIoBqjb2ba3O5rTok5VMrW+0D4Z4j6ikYeAriUWeuRWDemNZ8eOVx+3i9wIX48mq2fekuDkaUjfFKBARz0ousA54Baqgl7oVX4mX7hrYlwtQkOZOnpfeNxcJ61UdLPWSloBqKZOm6mbPq+Fesicy//3F8AkiW/r0sDJNdElUWHqapIigwW6vubCucobL3RF414Uto4p45GX1MPQx7lcKeUstdxXIMEWDEIAOgK0mH+78+TalRNZy/au5zMrSZSQh1WJvokDzQPfhu5dNW5P0Xpr8YJf/PFZc60nKqmC39GyflCbR0kf0jmjdVmBD65yop83QoKOjtURX7/LGPn4xV/K1WXR4MYEN6Pkim/S1kR76NPGx9p2mZBzIMuq46ALeMypH54V7fr8G19FZOmQqfmOIV2yT2pKqQoTN2Tl/UTGEnWxvrtQvMci4YJPkO14J8SlvV28uNjvOiBt1SSBx2iFXSDCiXGtw5q4WPEMsYD6Af76P5MgpknntupUmXl9X0G91e9Lu8zkIe9nmxRzl5vbgVUw6ZeRv2ErhiMW4ULQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(136003)(396003)(376002)(39840400004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(5660300002)(2906002)(26005)(4326008)(8976002)(8676002)(2616005)(8936002)(31696002)(41300700001)(86362001)(66899024)(44832011)(83380400001)(36756003)(66946007)(66476007)(110136005)(66556008)(6506007)(316002)(478600001)(6486002)(6512007)(38100700002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1krVXhrYjl0V2crZFlkT2JrQmtkVkJXWnM5cEQyQ2M0aGxGZ2hnZWJsZ0xa?=
 =?utf-8?B?WTN4S1phemlPUThVc2kxWEx4dkVJR3Nld1VTQkk4L1E3blJRb2krOGcwVUNT?=
 =?utf-8?B?OG54Ni9JTi9MdFc0d2FwdWZxMVQ2WEczRjBmUXZTSG1lUTFuOFdIdHd4Z3Jq?=
 =?utf-8?B?bWNrZnMwbitKbUhaREJjRUhoa2dORi82eVNWWUgxdHJEc1VSRlNzc3hvRU9v?=
 =?utf-8?B?NTBXaHNXcjh4eXRNMjJmbG1HVXIwaFlmZFUrNWI4eExwQ2ZIc0NVb1Z6WFND?=
 =?utf-8?B?YXhyVHQrMVJUbWxOb3V6aFYvV0JNQmxpb0tPL2s1c0hIaVQ0bDlHS2cxdHo2?=
 =?utf-8?B?ZHNBVS9JT0cySmNYdXB6UjJjblJhMEtBMFJ1aGdXa2ZldERKa0VOVEJYeEEz?=
 =?utf-8?B?c3FVeVdFQ0xJSTkvU1A3MXdrcGYrN0FrdDBtRE0wTldXWjZvb2RESGRHc0Vj?=
 =?utf-8?B?VVRNb1JrOXFZUEIwK283QXRxOWRmVGRCVi8vaDJjRFpTWmJXSWY0UEkvRDZ0?=
 =?utf-8?B?dFQxb01Db0ZFdnZRN2dLbHBWeEppVit5Tk4yb0I5dzZVbWlWNzcrS2ZXN2VK?=
 =?utf-8?B?VFhOV1haSmM0Yngwd1RZT2hLWHhYN0hNVjdremQxdEJhZ2hZaGltNEV6dkNs?=
 =?utf-8?B?MTErSHdZa2cwOHMvYktkYmJCS3hZSjBrSEo5cm5taFdWNGhEK3BYS1p5Q21T?=
 =?utf-8?B?Rm1HQUJMbDRYMWFtQnR5T0swOXpqYVAxYnR1MGI4elJOS3VxZE51R2FSTkVs?=
 =?utf-8?B?MnNNUGYwTllBL0FhZ1RkTk1QYUR5L3ZvOUs1MmxOeFIvTE1neWRoRlZDdmZm?=
 =?utf-8?B?bkJmMU8veFFqZEdjSXNDWlFycm9OUnhwZi8yMzI3UnI1YU1lTVJkSmlPQllr?=
 =?utf-8?B?dW5zbWh5b3VBZTFnZUJSY1pseTh1YVptbUUvNDVUM3NvYzNJNmdDbERmYU8w?=
 =?utf-8?B?akc5Zm9pU3RaeVZhK0NaTGRwRk1pSFNRTnlXTGJORTRzQzhNUkZQallTODZE?=
 =?utf-8?B?dkFWVE4yc2V0SDZ0TE5uaFpzZ2RxaTlJb1BBTjcveDFtSGlGSUlzZTNMb1pS?=
 =?utf-8?B?REw2NGxPRjhjMlVIclNWc21uT2RINmVaTGp0eFBUc2wwNzI3aVpDM2lYZGdE?=
 =?utf-8?B?NlM0cS9QQWxKZ0hUOXpkOHBNb1RZNlpsNDNaS1pXbzF1SW43eTZyNnBadmsy?=
 =?utf-8?B?cWY3U2dFVlpFSmpqcWxDVXlPR3dqVDFUeVRRV01yaWpKVjZYUDBaM2VSbVFw?=
 =?utf-8?B?YVRaYmJWcGJMVlJaSXhBUXFxNHVWZ2FVNitiQ05YRUhjcUFucmRXRmdSbDVx?=
 =?utf-8?B?TXpNaXU1WlQvZWxnOGFyNDJzejJnYUNPSEZFU2VEM3duUGVNNHRiYUVOejVw?=
 =?utf-8?B?TU5iaUgrT0JxVUxEUC8vL3NUTmdta3JFQTdTNEEwSFJGWXd4Q0pVR0JVTWdx?=
 =?utf-8?B?bjluMW1rY3NOQW1kdERLWXNOSlRpK284dmE1djd4Wmc4eE96eDhVN3VyNzN1?=
 =?utf-8?B?NmhTSmNHMmNoRlJiS3lqWkMzOFBPN1UyMHZsamRieFN4REFDR1ZCWkJJSXVj?=
 =?utf-8?B?MGpsZ3lxN3RsMUZ2SmYwY1FITVFuZVY4V3M1T1A1VDc4Z09xVTRtM2Z5bWM4?=
 =?utf-8?B?VkgvaEl6TlVEaWplNDN5ZmJiYjltZGw0RU1LNUhIRUN6aFppUGRMUVhmRG84?=
 =?utf-8?B?M3JRY1hIRjJ4RkVSS0lmQkNib1djcnFkWnY5WEFkYXdVL1pBcUtiaG1hV2ND?=
 =?utf-8?B?b2FRL09GaVE3eGZGUEUycmp6ZmZMQzkyemZUUTNrZC9BUWNBWFEyTlQ0T3Bq?=
 =?utf-8?B?Y2p3ZUZCTkYrb0VacDdRZzdjei9ad0hoeTRGblVoWlh5R1BQcm9wMmwyWm5i?=
 =?utf-8?B?clk1eTBIWkFiNlIrcmRjVGFnV1pFRmNjOU11YmhIK3N4amM3SEc5MEpwRjNW?=
 =?utf-8?B?Z3ROQlluM2JoQkp6Q05XRWkyY1QzUTJWMFFoTndxNWFJc2ZkaTNFRHdzbnNa?=
 =?utf-8?B?QmJyZllnVmNkK05DSXVoMEVTRi80VkVkbWc2TDU2Um11ODFQUEVnWFVYeDJw?=
 =?utf-8?B?cHNHSllMd2FLNDVSRlJLKzhxVjgySnpRNUNnV2RIQ2xCVFNVMjd3cjFrVUNP?=
 =?utf-8?B?cmdIa3YyTTI0TlZ2WlpldXdmVUdYMkZ2ZWxHYktodVgxY3hVOGlua3AzdGsx?=
 =?utf-8?B?WVE9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 4be3aa02-6a2f-4ef3-353b-08dbe944011b
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2023 21:10:49.0182 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sPS+XwxtNjpSPI5A7HHVsnMz36N/XFtOfoA+xO8+LpP2LYL27OcdYXQFlcGIFXpm+cG8USLUp0KNlw5yflTHUsv7Kl90KRV8jbTMDozvbdk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7792
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

On 19/11/2023 20.09, Simon Glass wrote:

> On Fri, 17 Nov 2023 at 15:52, Tom Rini <trini@konsulko.com> wrote:
>>
>> With commit 3609e1dc ("dts: automatically build necessary .dtb files")
>> we now have logic that will ensure that all device trees needed in the
>> binary are built automatically. Any device tree that the developer needs
>> while working can still be built normally via make arch/.../foo.dtb so
>> we can simply drop the rest of this logic.

>>  13 files changed, 6 insertions(+), 1570 deletions(-)
> 
> I can see the motivation for this, but it ends up moving us away from
> driver model and devicetree, IMO. 

No, it does not.

> For example, rk3399 and other
> rockchip boards use DT for their init so the same U-Boot can be used
> for all, mostly. 

Huh? I just took a look at a few random _defconfigs that mention various
rk3399-* as CONFIG_DEFAULT_DEVICE_TREE. And they vary _wildly_ beyond
just that DEFAULT_DEVICE_TREE, so the U-Boot binary (as in the ELF file,
before being concat'ed with a .dtb or wrapped in some container) that
comes out of those must be similarly wildly different.

> Ideally that is the way all boards would be, as they
> are in Linux.

As Tom notes, that's just not gonna happen, ever, not even within a
single SOC. Something as simple as the amount of RAM may need to be
hardcoded by _some_ stage of the boot process. (Not all, I'm sure you
can find examples of SOCs where it is possible to actually build a quite
generic u-boot binary, but how that binary is then going to figure out
which .dtb is relevant either to itself or to the kernel its job is to
load is then hard to know... something like a top-level compatible
string would still need to be hard-coded somewhere in the binary).

> But here I have to manually add all the rk3399 boards to OF_LIST for
> each board

No, why? If you want to create such a generic U-Boot, you create one
single _defconfig that has all the options needed by all the various
rk3399 variants it's supposed to support, and add all the relevant .dtbs
to that defconfig's OF_LIST.

> So this is teaching people to use a board.c file, to use #ifdefs for
> device-specific differences, etc. It will be easier to do that than to
> do the right thing.

I'm sorry, but I really don't see how that follows. All this does is
eliminate duplication in our build system. Each defconfig already lists
the dtbs it works with (/is supposed to work with), which can be a wide
or narrow range of boards; some boards have multiple defconfigs simply
because the users may choose to store U-Boot (or its environment, or...)
in nand or emmc or SPI-NOR or... Sure, some of that info could come from
a .dtb, and the .dtb could somehow be chosen at run-time or some earlier
stage be tasked with figuring it out (which just leads to an elephants
all the way down problem).

> With Linux right now I can build an arm64 build which supports most of
> the boards...with about 990 devicetree files. 

Well, the kernel can get away with a kitchen-sink defconfig build
resulting in a 40+MB kernel image plus hundreds of MB of modules on top.
And relying on an earlier stage picking the right .dtb for it. U-Boot
simply doesn't have that luxury, because U-Boot is that earlier stage.

Rasmus

