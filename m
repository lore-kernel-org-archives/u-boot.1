Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E9AC282D0
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 21:33:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01E6F805C3;
	Tue,  4 Mar 2025 22:33:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="G4fj52XJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 724D0807D9; Tue,  4 Mar 2025 22:33:49 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E90BC800C1
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 22:33:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mQ4PlwHKFBevu4FVorn1rbh9NvPDlMvftmBR4VZIXopVz3p37PsxL44J3ohx8UpEdZTR7X+iGyxuaWotqtgxh/pUo3AydqxkKK4wjapqS2QqIneB6aE+KVh5GKXFoVdUawUtsMBRkJLk3VSmanP1/OI8j8Tj2NDifiRFwUjQkIUHoNBLhDpd/qH0kdsLLEBBEPk0T+IXAIWjZwFsy+dzx80iTH7+18izLUrsUlUWGrZyLUazjYgRq3BciGvbpmvq+vcGFEyv5WAo5L04PZHtxeBaQW+t0EBB4ohVTwWwTFlF5JdKZfgk1B77sKU4rK0uDE4IwyPPy0uBX61xyn472Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ls5QvUZmG5QReY0NM0Kkhg6AZT8Vva+P003Kus1pHsM=;
 b=jsm1RD/x91OPcbLrqVb3R85ZKM/HRAaNRyrrzd5+KoVkZBNumqybg9ZRXaGUgPN/6ovN8XT9uimfgcuYlQCUh2OBwx5OptZIi462qnpQD6JDF2YY3i+szx/6gnAKqsaDvp7+uzq8JFHqBUB8C9HcNCfRVJogyp870kj/AjprfBz/UL6h8uZOkt9wfUjvley3ETFEK91LqYy5rnV2oQOIsS9Jvj2egojWjGCLVZwi2MAvVavb3+zUCAkpjigCmqaJeyh7/FCM4RP/eULCEWpkI5iCozt7NEL02+jZLfDo/sMogLWgIVKXw/8FNqbFFjDUXzXeGNJkDba9bP1N5YXpTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ls5QvUZmG5QReY0NM0Kkhg6AZT8Vva+P003Kus1pHsM=;
 b=G4fj52XJJMxX0ltePZlXPyLpexP9We0KFGl8XLOnQaINxaYXMFVpKFoaFQyg5LVxn0ivFJ7L0SEX+aDXg1cojuZu25y5Kd1K35aWS9PEtiMSjkuNprmqkrt9esAUb48gPCXa01PB90fqE2rLRQONfpWatpi5yV54vksvG0EMn/I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:41::17)
 by DBAPR10MB3996.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1c4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 21:33:45 +0000
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4]) by DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4%5]) with mapi id 15.20.8466.028; Tue, 4 Mar 2025
 21:33:44 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>,  u-boot@lists.denx.de
Subject: Re: [PATCH] scripts/setlocalversion: Reinstate .scmversion support
In-Reply-To: <20250304144249.GY2640854@bill-the-cat> (Tom Rini's message of
 "Tue, 4 Mar 2025 08:42:49 -0600")
References: <20250302183128.326418-1-marex@denx.de> <87tt895etl.fsf@prevas.dk>
 <4ef833aa-49b3-4af8-b77b-4b3f3f6b184e@denx.de>
 <20250304144249.GY2640854@bill-the-cat>
Date: Tue, 04 Mar 2025 22:33:43 +0100
Message-ID: <87ldtk5vm0.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0035.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::23) To DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:41::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR10MB2475:EE_|DBAPR10MB3996:EE_
X-MS-Office365-Filtering-Correlation-Id: e0885723-da4e-47ce-d29c-08dd5b643d6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|7053199007|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GmisRRiatWCpcBVKDtC++cBujxjJaXMr0dLQsKc8NPvPXtWAF9/s5EmuEL1s?=
 =?us-ascii?Q?mgMM4DA4mfBWGD2HO1h2BkdUZoeG0r47GmhACqb5urdJSWn82BtBSrAqvy+z?=
 =?us-ascii?Q?IZ7BFrTpsyX1pqXIhegZ3dngPW4fTb1RXJI56yu2rCVXDr2YtVSLnVY7qbHo?=
 =?us-ascii?Q?afz3rluxoXvBWyvVK1xgz1wqS+zZa7vH5tNDaAgF/WF2rIkLJhzuKE5jA6bM?=
 =?us-ascii?Q?vLWGhANzPynFfUKQ6bMR+tOtrWHjr6c2Y4MCSZ0Bn+TqnynDvbXuEyUoX2Bx?=
 =?us-ascii?Q?GUjccKc7Ptm7LpuqYiHfCuvY+qADuJOXIyzrN8ZYH2vy/UTbL1BAdyO3U+zP?=
 =?us-ascii?Q?0w8foY/k58T76ClwIb8iHvl7abACkdOby4GPrBa/UUg5/rtITCZuOvSqRKa1?=
 =?us-ascii?Q?Ioz1q10IaGEcqEDV0bNjXA6k8QCZJXudczxX4u/HLhvhqFnoWQ1QPZU7CfZa?=
 =?us-ascii?Q?ZaeT/ol1pDHNOaMuprcPXc3WIi8mXabJ6Ul12uR1ryYWdrabapIxPUbulViE?=
 =?us-ascii?Q?BFvHcixEqpOQS1zKd8IIP0jCtU1Vq0aAMZU/ehVZVEsUA8nXo7DOXdhUHpS2?=
 =?us-ascii?Q?skC0OLbdoL3qsRw4lHU6G5gUwKzPJIebhVAmdLnjIxonQzFuoMY9kqv89UV1?=
 =?us-ascii?Q?l4cU3nr7eQ9GcKuIKs/23wSIaI1WW812KoR0kzosfF0c4CETNzN7qKysJq0u?=
 =?us-ascii?Q?qKirVJpvdPJsP0P7cWskdkPA6wTGD2AJU56dl/XM0aZrhxIxr7x4xv3UNSuy?=
 =?us-ascii?Q?cqYmxKWNM7+2yplo88P8en21LUrBuwvOhTgp4G9beOmXPWsjvIsIfpiZyerH?=
 =?us-ascii?Q?cH+TQJi766hXJve0gHgbKrfRli/DKgXqONsEOAJeolh6DrAWyzvHuvHuxKE9?=
 =?us-ascii?Q?8EA2MDDSls2Ikbq48Auw7YSGx43wQ/tCHZ7W+G0ihPpfsO97rC6wkj93x3c5?=
 =?us-ascii?Q?2S5nibSoHLxQQBiirh83F7rOhUfKweN+/sQKdIIE+zQOo1mwLotgpsZO0yyU?=
 =?us-ascii?Q?z166eDJSSt40MCeBOOUUG2koHzytUe1FsCCp43owkqO2yDW2RYfxfxHMcrE9?=
 =?us-ascii?Q?eRcwq8McxOLaSkZV49sbGUaN6CbJZRjgztmdEDJjK2T/LA0aBgTn4lFgLWFM?=
 =?us-ascii?Q?vH5omqplJkiI5c6EvWHq5Ob3xtbZ6v8fGddPYWxDTY2OlakH8GzL+QkAe/S4?=
 =?us-ascii?Q?RRbMuzUWNjdaWWNg/ljrF708N6L+EMQteXDSVCZiDlsgARJRtLv6wP07ELHi?=
 =?us-ascii?Q?vP8fDm3thQg+YkSTvOMvHWItSqUt01BM8xRY5eGQEpc15qspO9jS+H2B0G3t?=
 =?us-ascii?Q?j9UzIEao8Eq6Aoe4todcId6A1HRw8614Cf1bEjOQabAuuDnbhgE5P84bWPBS?=
 =?us-ascii?Q?pIfF3AWnkLTqli3RkNEob6ZctZSalm3XbuYymUhBGx2L1P/4LyqMe4ZPO26E?=
 =?us-ascii?Q?bqryK+dujJND4HjMqK6fhgTH9XsBDBAu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r0j2/hKSrAFHN5qO6mBl0km/O56YlWavMZT86KAGi05jJk3SMdiEhdLa7p88?=
 =?us-ascii?Q?WjqlPSbyp8jo4mVa6z0B0ZQzNl+eXS7u0/sibtVbDgmEHclw4DE/vMlkQVoj?=
 =?us-ascii?Q?BP+WLjxYeRPz/7ZgKuk2oWmjfE0hCH31H+YRRJ64x1H6jfME5HKmDgEDy2hN?=
 =?us-ascii?Q?e+MW3E9kwraOkQ8G9xUIw/5UUiVIGOTkJZqFIDPrGKG0M2h96RENJJiR5Uc0?=
 =?us-ascii?Q?G9whcp82NLl6asqInM/I2OEHGkiAIbzD9lDtTIFuq4n9NUkFVeWhP0bxRQYR?=
 =?us-ascii?Q?yaVMTFCWnYvWG3cwbPcqubvEfiIjkIwkkNX5Qy6iX045XN1gUkohODsmN3vD?=
 =?us-ascii?Q?YwJezS+Suk1E+tVRu4kvrlPFxE63U5EGvFxAheKaDjQ8knooaF+6jpyjwIQH?=
 =?us-ascii?Q?T/+8FcPyihloaEiwPGhCmkV5AW+KOV6Ah7ZwWkaN26NZdfRSX2pXh6UD1bwq?=
 =?us-ascii?Q?wvybIzC0RU+YZ1NSevaLo8OEdOhvSvXGvbW3Aqz1w9y7P5GGbQBMg5qrOIpN?=
 =?us-ascii?Q?8jLPWIUIPOrtPYqeWbDtpyW+/Tfm1bi1B0AHtVps8T/1AB7D4a2QPKc87RPP?=
 =?us-ascii?Q?9YcOsxNTEx/ulNlJ2pILulxstQr1qRhVS83po683rgjKq4uILXYPCMn97QA7?=
 =?us-ascii?Q?UjefuJHv+5vHQcW7G3dzzsPZI31is9Ho0bAOWat3QXqI5Q8f22XfFnIQy4D/?=
 =?us-ascii?Q?z1FYYlWhU4P49ZN9/KY1zzfPVAsccTT23mjtk0Oc4pWJ96/hxeMUW93GM/4/?=
 =?us-ascii?Q?NzV7krnWQUFyadf2vk6hJfq+Pngdrrwhuzngtlgh3lf+r4FasgF6rI77JNVE?=
 =?us-ascii?Q?TEyhO1tV5R3WbRzBFL7b0pT0a+N8+QyJZTBIkUrv+ThCXyBYXSlRTOsBc1HH?=
 =?us-ascii?Q?B8/u8c5y0O5ijTlWdwb562p+QMJk5FXzSOI3ad8ohMVF/aBWB4v/py4GLry1?=
 =?us-ascii?Q?D8cXKrU9twKPy+4kUIuM3i7WIIAeB1HS3VRGyxeSEk5GJPKI+x8wM8k+96PE?=
 =?us-ascii?Q?Ep3mfsJ8Q5DbUpS1bJsNaKdb0kKBFJHgBjtVXwJTyGWy0IaP8zsAGGvCAiTb?=
 =?us-ascii?Q?nr6yHfQOxqVHGs95N67mN0Vs6tANGtTc0wHGpYO9MpfOYElvAOe3YAtC9tO5?=
 =?us-ascii?Q?yUpGWzYBOPk3vUfDpdHiBrfiS5HIYqWuUm4jMC1oXB8WeQaVnhqxuGTUmF6d?=
 =?us-ascii?Q?u9clyKkyNVThkcTFKPGTlON10y8zWpTWGeddBG9gC0EMk6aSm/fxp7+o1U2V?=
 =?us-ascii?Q?G5gPINfX9U5YXKIe9F7gxAK7kYfzL7XcH24fuZn+A8EmQ/ztaPJte/AL/3FA?=
 =?us-ascii?Q?r48Giwsva27u78js0PxSp1fR8Ne58O+jDPdg74y3IsHdLpzQnc/VJW1Ge19M?=
 =?us-ascii?Q?VQA+A2pI0YFPat0L6MxEYqB4y2HhOEnoOlbkI6nX7SqZ1mpw0ED81tnS6qZv?=
 =?us-ascii?Q?5ABVHFj9GY99dGpIuT63E37myIexEaTQmuGHVzxFT7HtjLs/FtbPyGJzK5Tf?=
 =?us-ascii?Q?OBznBf1lGDWXFZXktEUB7mVnTDmTEyxyqr/NEeDg9Tv/YArxEWfu9HqEvZ5s?=
 =?us-ascii?Q?kc/NpJoBOMBi/bpjZ3S7zEfu6HM3CjnMFVyOKdfKFdYRgzO9vYW3bxiXJlUs?=
 =?us-ascii?Q?Dw=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: e0885723-da4e-47ce-d29c-08dd5b643d6b
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 21:33:44.7079 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yahEVVqj+/j2K5nowqt05loCGBdbPteTmC9hdgRQwB3Z+zG53Ut7wcd4NkdUbqZUuOHrThxwQSa4MFJ0ki750vpTkToB2nY8xpvUvvKkX8A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB3996
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

On Tue, Mar 04 2025, Tom Rini <trini@konsulko.com> wrote:

> On Tue, Mar 04, 2025 at 03:28:17PM +0100, Marek Vasut wrote:
>> On 3/4/25 10:24 AM, Rasmus Villemoes wrote:
>> > On Sun, Mar 02 2025, Marek Vasut <marex@denx.de> wrote:
>> > 
>> > > The .scmversion is used by oe-core to append U-Boot version string.
>> > > 
>> > > LOCALVERSION is not fully compatible replacement as it adds trailing
>> > > "-dirty" string at the end of version string in case the U-Boot git
>> > > tree contains uncommitted changes. This behavior itself is correct.
>> > > However, OE builds do clone U-Boot sources from git and may apply
>> > > additional patches on top, which are not tracked in U-Boot git tree,
>> > > but rather in the OE metalayer git tree, which leads to the addition
>> > > of "-dirty" string as well.
>> > > 
>> > 
>> > ... which is then _also_ correct, no?
>> 
>> No
>> 
>> > It means that U-Boot is built from
>> > v2024.10-321-gabcd1234 plus some entirely unknown additional patches,
>> 
>> This is not true, the patches are known and tracked in the OE layers.
>> 
>> They are not uncommited ad-hoc local changes.

Perhaps, but the resulting binary has no indication of what those
patches are or whether they are indeed under some external revision
control.

>> > > The .scmversion used by oe-core used to replace the version string
>> > > suffix fully, including the "-dirty" string. Reinstate support for
>> > > the .scmversion to let OE core do exactly that as it used to do it.
>> > 
>> > No, please don't. Let's not let this script deviate from upstream linux
>> > again, and let's instead try to fix the bug in oe-core
>> 
>> There is no bug in oe-core.
>> 
>> U-Boot commit Fixes: 5c02350fa03d ("scripts/setlocalversion: sync with linux
>> v6.9") introduced breaking change, the removal of .scmversion support . This
>> patch fixes it. It is as simple as that.

Huh? Since when isn't adapting to changes in the upstream project the
responsibility of distros and downstream meta-build systems? 

>> > that (ab)uses
>> > this legacy .scmversion file. The fundamental bug is that oe-core
>> > creates these .scmversion files unconditionally, even if they end up
>> > empty, making CONFIG_LOCALVERSION_AUTO completely useless. I have long
>> > since worked around those bugs in my own u-boot and linux recipes, but
>> > I'd much rather be able to eventually drop those workarounds.
>> > 
>> > Why doesn't doing what kernel.bbclass has done,
>> > 
>> > export LOCALVERSION = "${UBOOT_LOCALVERSION}"
>> U-Boot and Linux builds in OE-core work differently.
>> 
>> Linux uses SCC to apply patches onto a git tree (i.e. it behaves like "git
>> am *patch") and therefore the "-dirty" suffix is not added.
>> 
>> U-Boot recipe uses plain bitbake do_patch to apply patches, and therefore
>> the build tree is effectively dirty and the "-dirty" suffix is added. The
>> .scmversion overrides the dirty suffix.

I certainly don't; our u-boot and linux recipes both point at some
specific SRCREV, with any necessary patches maintained in a git repo. No
patches "maintained" in bitbake metadata.

> Yes, but that's Rasmus' point isn't it?
> 0592671fbba8c96df043d537d1f6415492de886e (v2025.01 hash) in oe-core
> isn't the same as in mainline because there's patches on top and it's
> non-obvious.

Exactly. When I have some customer device and need to debug some U-Boot
or linux problem, I want the U-Boot banner/uname -r to tell me exactly
what revision that was built from. That's why the .scmversion munging in
oe-core has always bugged me (because they've always added an _empty_
file, making CONFIG_LOCALVERSION_AUTO useless), and as I've said I've
had workarounds for that in place forever.

I strongly prefer to keep the setlocalversion script in sync with linux
as far as possible (there's a '| tr ...' due to U-Boot not being catched
up with all of kbuild) and not have to remember to forward-port patches
when re-syncing, but I'll defer to Tom now.

Rasmus
