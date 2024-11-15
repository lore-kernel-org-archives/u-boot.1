Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D43FD6DDDB
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 07:18:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A08E89346;
	Fri, 15 Nov 2024 08:18:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="FO8uO7yV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BB4089353; Fri, 15 Nov 2024 08:18:16 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::621])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E991F8933F
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 08:18:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fzQPtbfDSxRuCPzb53+6qEOAKbexb4OkEF5NPq0Qzq/D9r4Zdp+WCRokDBryQ/QHmtQaiUJXoY8Yi6eCeU7JYDbzGGgXcfmDr6j2I7ZLJoOOTdebCd0j56tvMqBjg5lz5r08GBPJ7blFxwRF+kLo2P+nLskruI+gsSnhzDCu15CH1BMnb2HELpBEZsQ4bT8L7M9W50dSD/gabie3uAKPODSEllR2bzdOEViaWLNjtrAzZrfvMB9Q9sl9f6VFxnbb/yfC+oi98v9Y1iLhQywFQKI0DfTwgqO/wLSg6n98uI8rgVDnkirDCIuqbcFyXCXbhkBX5D5AiUeKPGRYGh3tAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uLVOVOfODCJoS/kpCeHmlptzhAvLwZ5EUXeo1DSvxko=;
 b=YczZb1oesTTUSZigg7TUamLxdwtvX7u8lYCknsWAjAECG0O1EAwN7OR9D/VLIZNEu5MjF8rhgA8uoDXSZC7OzI+WwQ9g2qy4J8Jhx+DR0p55cilA/W6tkcwZZLtQkw8Kx9RjWaYJ78YOuPjTZ+jua/nl618/Irb/FLYBTtlRD7vltcooFArQ5Ejpa6lAECghiX0fo4nRJoEYSHa7t2QbHpGhhZ0S60z4QWzvWH9lnoTu4tnldqkvyBl+Wtb1byobemFJsejPrflGeEDA5R/kuBI6llNF5FWYLbYOy5vooQSpRWGJGalCAssWICnGzLPb4DFGU/xu13lFCc/rUwzY8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uLVOVOfODCJoS/kpCeHmlptzhAvLwZ5EUXeo1DSvxko=;
 b=FO8uO7yV+hLwGYOByzTwNv2gKW3h9uyo9xZ0BVtPOqwFwjRdo8rDgIWja4W1Oez9aQAslhqUzkmxXHMwLsO73CtJBUr/E87LJf7pTktowbaJ04tjETZlkvF/GsisiMTnazyGB57nCjhy9SfEM4pierFukIa7YOhdi0fE0xc66t8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:41::17)
 by PAWPR10MB7343.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2ee::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Fri, 15 Nov
 2024 07:18:11 +0000
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4]) by DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4%5]) with mapi id 15.20.8158.013; Fri, 15 Nov 2024
 07:18:11 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: Tom Rini <trini@konsulko.com>,  heinrich.schuchardt@canonical.com,
 hugo.cornelis@essensium.com,  sjg@chromium.org,  paulerwan.rio@gmail.com,
 al.kochet@gmail.com,  ada@thorsis.com,  philippe.reynes@softathome.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] tools: use cryptographically safe RNG
In-Reply-To: <87plmx1h4r.fsf@bloch.sibelius.xs4all.nl> (Mark Kettenis's
 message of "Fri, 15 Nov 2024 01:21:24 +0100")
References: <20241102163259.305802-1-heinrich.schuchardt@canonical.com>
 <20241114172654.GA4059396@bill-the-cat>
 <CAM=mAOmFn0tytht3oK1F59=-nGxuLJmtSr2HpJDyTf=LWKYQOg@mail.gmail.com>
 <20241114173927.GJ3600562@bill-the-cat>
 <87plmx1h4r.fsf@bloch.sibelius.xs4all.nl>
Date: Fri, 15 Nov 2024 08:18:17 +0100
Message-ID: <87ttc9m0cm.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0065.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::19) To DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:41::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR10MB2475:EE_|PAWPR10MB7343:EE_
X-MS-Office365-Filtering-Correlation-Id: ea79f2fe-86cb-415c-ab68-08dd0545a966
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?G7buTrMtbJiTKdo06VdxpbP8PXtcnJbfWH7gFj+UAWDyggR8lwvCarv4dR5I?=
 =?us-ascii?Q?WfA7fHZ8s5OIouxEp2nJs/su7248P/4q75/XMica8c74mwMbx7+hmczfjudt?=
 =?us-ascii?Q?E/uGGYAjFXxJaciBmaFyO4Qn6adIrX+9dCh+Unrh2grYZpRPdZjPVUZEYzsS?=
 =?us-ascii?Q?btQ9F2NLvmG0kjuEnpOn3+uqqNHaxJN/yVdDPrNoyjQirrl+lLmV2ccW69IK?=
 =?us-ascii?Q?TdFDvIeKE62PDoVARyEKbm9lYTmEfRu0n3oytBPov/YjLYXy1sQ975gbi/Am?=
 =?us-ascii?Q?m9d8+MG8pjxOpT6inV/6IL+0Raxn/ZYLKcBs4LQoJqMc6DYIrUI3CV3Y+Ksy?=
 =?us-ascii?Q?zQVdfrTFbMJ0Rl5SdkDLT30cy0y3qVm+jxrac3h6VUO5uXlH+JRsUTp7oI6m?=
 =?us-ascii?Q?9DSda5lMO8DmbewTrFzaI+dDX2JAp0I3q9dDD7pAYmRCrVursKlRy3EOHDYy?=
 =?us-ascii?Q?0YLgSdFy/eVKxBUOQsA0vf/R2Bzdo3damy1/CemXQSXO7w7WKWloI1wfKKU7?=
 =?us-ascii?Q?ZTF0B4DsTAIec7/gi0Qe7NChpP5DPD9tDZ00nxR6dnJcaUU8OVjO/2kUGWq0?=
 =?us-ascii?Q?K3sAgdQUtqEhATOUnTGsjcCQ6jsvdNo5TZjUUbW1AmNktq1eiLHL4QHqjZoL?=
 =?us-ascii?Q?rmMWJOzkKFxoORGpxqhboUDCsE1GnzaZ4H3ZVMbgVAwKxFQks4gMzB56lWm3?=
 =?us-ascii?Q?oFOylFdvJZhWj8/Gg1q5xYBXnfxveKgStUXmbt0hA0ARpUXsTphdbubRVlrM?=
 =?us-ascii?Q?rYb9Xh20SyKTRQ9TrkR+sk7KYbuFWN5BIYOYG3RUEzIo17CJJ4uN3sLVxROu?=
 =?us-ascii?Q?A9Mkb3vcj5EBvciJivYtrhhaEibvHpbL4dQ6R3Tbf6bZNe2OR0m8H5wAfoGm?=
 =?us-ascii?Q?iUH1QUAYrESF6Fe6ZJs6cAkZiPb2ugSwhPsTwSfqSz6q4DnCbEP5/cPmyW7V?=
 =?us-ascii?Q?Qn1+Aq5O8O6FZU9j96IM30drtYQiKpWHrqymduhrLwNix3DiqjyTn+DYcART?=
 =?us-ascii?Q?vi3VQ628p0uNn0hqbJEqHUKjXLzH9C+7YudLMJDIdBiuWyLmenC5ROFWnrF8?=
 =?us-ascii?Q?TR88B0cLULKkyze68N5mRBRVYtxWlpiBKLNOnXn1AFaMEWIdVpSIarzW/3O5?=
 =?us-ascii?Q?6A5e0+6RIIy+pmGDoSFlV8aPBBwdOPqBMoJJhFfZZGSrMl6FuniqH3BS83Q/?=
 =?us-ascii?Q?dz/DjVBa4/7PCSu2knOUYSZAdrThVgLwe4rLLyaLtvUd+gWUQpiNsjqTzJSr?=
 =?us-ascii?Q?j7+FexihQtI9Kgu0DNBwIfnofBdf05tN/nOYTnnaW+ADOdup/I90sjEw1cNA?=
 =?us-ascii?Q?IF69zDaY/by/jJKCDBpz6gli?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZaS26ttpcUuMh7eEY/M2+iOkdfP76qhI1NefdX+juWMFE49b46VPh//Y9Uei?=
 =?us-ascii?Q?LgQGq6PPGYuOQCe07+eZTKyNufTS4sQFeSbYp5gLZINIWqblaBwBCEGm7zYs?=
 =?us-ascii?Q?UKAFYv226oXIEg/fKGwfyjJ3VlAZr/cdbFFBCtBUuJJenQHVt+eikd8RK3SA?=
 =?us-ascii?Q?aaQ2iIvCGq8wS4d2kqA7v8zkwq1M89MR5vwbezLy+XF4SxUVv88kjUyaPV8U?=
 =?us-ascii?Q?/pv0kJ1M6ZEFgMtHfaDBOy13Q3A+e19SeowcBxMCBfitCfNG+IOHfomIIVnO?=
 =?us-ascii?Q?aKC7eDNsJkjXH+FR/STLpBy4OG2icOrrDKrSdVARAfIGQ1R8Rj/0L3zSZa84?=
 =?us-ascii?Q?+0pz7rkJXJ37HUsBtZZHhd1CGS3J1IFrJkr/M+9JX8vdsETeEm8wPBIok42U?=
 =?us-ascii?Q?eGgkfYB1qh8FlCGVrFsRHdV/TMTsODJWYMsb+vTMS+UGYb5vVUH91WUlq12+?=
 =?us-ascii?Q?4yQ0SjR/3n6Uy5tNpFdXrb3g6yZlPpuXQ1lUd99VBI1ELwKalnYawBHw2Opl?=
 =?us-ascii?Q?XF7ZkZwucWzi1DbGaoIIIwQuDaPYe7zmcAfLagYGN1r2p1HZydpcRdH95Y6z?=
 =?us-ascii?Q?HGRMQgEVywssNV7lMuDceMvjY8bYsWBuKigjBa6R1dfkYpi7AgeWAo1uCEh9?=
 =?us-ascii?Q?4js2dPAwXppebv6a/FMQV6cGq1CYMzYTudd40Mk9BhtK7o3V8WDha+vG8MuX?=
 =?us-ascii?Q?iRYaNyUTsKxrUY6uNZEMbFztJ4Jcy54bMeGLLPMss1DyB2ZpfBAPHafxJasr?=
 =?us-ascii?Q?GsMoZKaymAIEGNWKi+iNqEeLYHdOzeWfnx4Sou4FsRAg+nvsnHXUC0+gg9Hn?=
 =?us-ascii?Q?l9DwS1wtLD0L331Fvco0Db889d0ofzQaxWHB8w5FBQ86Nq4B+jgG+5Ui8/Bp?=
 =?us-ascii?Q?AR7WSWeH1smieffGhZxdhBh3bNH+drypGxvgqpmjLnt9gn1naYHuteet2KOb?=
 =?us-ascii?Q?q+S03PUYc0/YNFBjJrYjR3B14QdDBrcAAvC6p5OgAeefryNk30J8WE9TyMjK?=
 =?us-ascii?Q?xKAqoWzu6fjNGV/63NCuej1rPpg891QKb80VTSE6ojBFU9klcliYttSfTvcc?=
 =?us-ascii?Q?y1hWDaXfgUwzazpJv2N6sfOpnpA4LmFJWysnyRrVljyfhuU6P9PQclHZif75?=
 =?us-ascii?Q?kzyiurg1ySNroMvmxAwYeh4OxS5NvUd6sB/2coViFhDgp38bNQQyKZe1fj4w?=
 =?us-ascii?Q?r9Au257PK7yWBjSsXB10iRlSIEClyb5jvpmu6Hfq0ASyOYSIEVwWrCAUGa1F?=
 =?us-ascii?Q?nwFH3A5qzYYHWjmzrBpEyZjCs60v8RZqTkp90M/tnb/afkK5tk/TLkKrbpBt?=
 =?us-ascii?Q?I8ashy0nthdVtwPqaderkK1Y2PlasUPCzk9rfRZo0wAtPcqLNIZdHSy+DUKW?=
 =?us-ascii?Q?ftGTxL6/aa+dUSODuGEkPAsljP5V3PiLtTpYkDNz2riH5T165yx+lBGqdF7L?=
 =?us-ascii?Q?1zTBNfotacUvMJ2OGCYXcrMqdJDp07vdIGHnoCQT2iUT1oitASUSc9MOuqYu?=
 =?us-ascii?Q?PybDYOBFK6p+LNrP0MX5Kx0lMWZQAuKFL5xdH9loeL+jpKKfZcAfnBwI/bX0?=
 =?us-ascii?Q?99rAt9wM7H+vFjVoOI95kfDt7IznYdTJfnhAZ0GgMC3XbQBQXC1QsIwlkSal?=
 =?us-ascii?Q?yQ=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: ea79f2fe-86cb-415c-ab68-08dd0545a966
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 07:18:11.1839 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hh25RM3g9wSSZnmDjVFeA4S8j8KtJyhc563VPX2uEtQJpvR6h77/F311EDSamHJ1X/ZWo0xXjdjfRnaTIiB8ih3zCl6vkd9xtxjSZb0V3uU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7343
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

On Fri, Nov 15 2024, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:

>> Date: Thu, 14 Nov 2024 11:39:27 -0600
>> From: Tom Rini <trini@konsulko.com>
>> 
>> On Thu, Nov 14, 2024 at 06:35:44PM +0100, Heinrich Schuchardt wrote:
>> > Tom Rini <trini@konsulko.com> schrieb am Do., 14. Nov. 2024, 18:27:
>> > 
>> > > On Sat, Nov 02, 2024 at 05:32:59PM +0100, Heinrich Schuchardt wrote:
>> > >
>> > > > The PRNG implementing the random() function only has 2^31 states and
>> > > > therefore is unsafe to use for cryptography. Use arc4random() instead.
>> > > >
>> > > > Fixes: cc34f04efd63 ("tools: image-host.c: use random instead of rand")
>> > > > Addresses-Coverity-ID: 312953 Calling risky function
>> > > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> > > > ---
>> > > >  tools/image-host.c | 35 +++--------------------------------
>> > > >  1 file changed, 3 insertions(+), 32 deletions(-)
>> > >
>> > > Now I get:
>> > > /home/uboot/u-boot/u-boot/tools/image-host.c: In function
>> > > 'fit_image_setup_cipher':
>> > > /home/uboot/u-boot/u-boot/tools/image-host.c:439:17: warning: implicit
>> > > declaration of function 'arc4random_buf' [-Wimplicit-function-declaration]
>> > >   439 |                 arc4random_buf((void *)info->iv,
>> > > info->cipher->iv_len);
>> > >       |                 ^~~~~~~~~~~~~~
>> > > /usr/bin/ld: tools/image-host.o: in function `fit_image_cipher_data':
>> > > image-host.c:(.text+0xb41): undefined reference to `arc4random_buf'
>> > > collect2: error: ld returned 1 exit status
>> > > make[3]: *** [scripts/Makefile.host:104: tools/dumpimage] Error 1
>> > >
>> > > in the docker container. I gather this means arc4random_buf is not as
>> > > widely available as assumed.
>> > >
>> > 
>> > glibc 2.36 is required published 2022-08. Ubuntu Jammy is 22.04.
>> 
>> Yeah, that's likely (a) too new and (b) strange because:
>> https://source.denx.de/u-boot/u-boot/-/jobs/945810 and so is jammy
>> 22.04.
>
> Linking against libbsd might be an alternative on older systems.

Or use getrandom(), which according to the man page has been exposed via
glibc since glibc 2.25. Or just read from /dev/urandom which should work
everywhere.

Rasmus
