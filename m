Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C477CC43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 14:53:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 229BE84B56;
	Mon, 13 Jul 2026 16:53:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="A4y/N2dd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D60684B70; Mon, 13 Jul 2026 16:53:25 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D87284B51
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 16:53:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rkKMwNNdESFX3ubVO9eyvl/3n8seTam94tiwIxjrh8LwvfpV8s9l9T2O3Mq1gGYbWpl5GAZZivrguhCxxkZ+LPeOH++7A6cvZtimvusovCj8ehWHOdf7nHRHiKy9itpfQACEDRUFo0Mpx4Z5HqImt92qE27IoxsC7xzLMLP8JRV06uDWiUle5XSZ8C+gpI+2a+tEqK/Rgg9Uuxt0nyrfyjhKasWcgBazG5BQNBF/k+TymRmnH91rfRU2InB5Yop9Cb5JlYHI8vn1vzkLNflFICkohdM0KciX4eOkdSxRK++iL1l6vYyO6vxlVBLxgDkPbArOrvy8dRH+MSdzjtARdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JWDP+Xa171U2/Rvi2GlCVGlS5fcrtXfoYkF81NaiVq0=;
 b=QnQV4yKU3OxBzdJ8KakF4N8ajB2RqNK//4bMvaKjRQ5bH85HrAm04XWu+Izj1WNbYoXtcp/5TQhA18V6JBMhBgVQC6B3W282VWlAazo0lnJXzumK7q33jMApZplOIQ4cI1CCDzrVIvAt5Lv7PxDVvY2BpbQ/pq7MW2zmCN5epepMxsOEPNJ8G7YNg5VsZdIrhiCh1smbZHJbsEC4Lqg+rLZ2r1qwXiNXQOsgPYiIaGoiaYgiXo0zYrok+62r04eQyf24yFfPJ3/1Zw2UItKz+SqVE6FLAWoqc1A2/uAoUK0ivpwvmzeIrCMZXn5mv2SuxXl8AzrVfX9pSIB95mRCGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JWDP+Xa171U2/Rvi2GlCVGlS5fcrtXfoYkF81NaiVq0=;
 b=A4y/N2ddaV0D/l6xRSd02tylPeuRPPVhLj7wkudVJpUGzDH3t9IR6p+aSA/qzLPlrYZmT8pQojxDA3fN8gSf/WWkMI3WkCQMFL2H/C/8WD42cygXaGXo52Du9R/MAVj2gGVqAq6lXcsrK/SKlJtXLYmzXLGCsQgRNea+tgk+nRI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by PA1PR10MB8929.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:451::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.23; Mon, 13 Jul
 2026 14:53:19 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.21.0181.019; Mon, 13 Jul 2026
 14:53:19 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: "Simon Glass" <sjg@chromium.org>
Cc: <u-boot@lists.denx.de>,  "Neha Malcom Francis" <n-francis@ti.com>,
 "Anshul Dalal" <anshuld@ti.com>,  "Tom Rini" <trini@konsulko.com>
Subject: Re: [PATCH 6/6] k3-binman.dtsi: insert keyfile and distinguished
 name templates in all ti-secure(-rom) nodes
In-Reply-To: <CAFLszTjzRQStvr-Vs=aOQ=BaMKBPFmtkPfNXKdh7XNsZ9hacSA@mail.gmail.com>
 (Simon Glass's message of "Mon, 13 Jul 2026 06:55:00 -0600")
References: <20260710123618.2036728-1-ravi@prevas.dk>
 <20260710123618.2036728-7-ravi@prevas.dk>
 <E34yhAlCVCKvRi2CPJi8pD86DADiz_24yKo13BW9Np4OH0VAVkCjdc-PkziRdM9IWfrE9bMWZliPPmLlpjWcug==@protonmail.internalid>
 <CAFLszTjzRQStvr-Vs=aOQ=BaMKBPFmtkPfNXKdh7XNsZ9hacSA@mail.gmail.com>
Date: Mon, 13 Jul 2026 16:53:17 +0200
Message-ID: <87o6gbrleq.fsf@rasmusvillemoes.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF0005F695.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::12b) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|PA1PR10MB8929:EE_
X-MS-Office365-Filtering-Correlation-Id: e27fba91-61fa-4223-d75b-08dee0ee7a48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|18002099003|22082099003|4143699003|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: h7s23AxQixuPiddgK/ZM3Ub2n7bSLL5Y8PWlPHhZXD5DVG4a3PRvgYqnrHWuYWYjWbhmp4Gf2Oxw0eMwQXRjC2pi7I67Pm+32BDL89BiTtWalkDvMFxuVio5cazD4w4o1fKFQ9CIX5enuYHnIXBOFVtYJt/Ku79EAEqWCni5s9CYWtSnTDYKvjpjZyn8k6f29xEbxZM/dUlg59Wmpgv99KaJuKOoIKBMN1C5VILeAWz431vc0qVx/67ZiV6VQeLWrIgtB4Nnswkd9ZuIqVK/G3tMOJaq3i2OmqU/LO1tSszgyUJzBO6XdoTpenQ19qZB0+nWY+w+EfawoMImWbWO4ugA8/8xrITctTwlj7VSFs4n79juNZJxqYDsKE+aWg0QEUbMdJeft6ZZJ0DEWj+Faqc85nk7lTbewG5qvkEuCKmK9gCH5/UQmf8Y1faCuQypfhl2wP1Y1WMDg3WzdL7mRHdAr04aaetHlsdNh+RVZwLecilOwMkVHDFwhjCwrdhpqcff9xEweybz6/zrcUsSHjlqX912k62Zt6LYQ2A66h+Q/M7vjJGjkygcJlxkjx9qFbGetPHtoyjrpit6vxtiJC12dqTMzWZQL1vyaho0zQ34+A6IO6pOHaRyY5mRlpQZ3stg682CoWtigLPd6cG3w/2R+Aqlmyn1eqr1KrWlW4w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vJxnoinh5sPZusMHtzPz6K30pR6x4DjPiwyZ+qKzbEMRAXmejkfFrrxyhXU4?=
 =?us-ascii?Q?xRtoq4KLkjamdO2O89IotxvFW2ZEB7munkKvlVeN9eFCepNZCe2KCv5w5Shm?=
 =?us-ascii?Q?ARa/DN5eEA/uFeGQyWW3UivjFCI9+i6o/lcK0h25v54EGiMhyWPiW+qWesIB?=
 =?us-ascii?Q?PF7Yzl8ULIweQAmhuSt0aZf4QxzTlI9D8xXSghkUiF+092pyPrHgAoLfvKDH?=
 =?us-ascii?Q?sh/xh9COFfPi6Lk/6vazLDCjeRUay/20u12U8qRdATXoxfYRFQfaIx6ZGkJA?=
 =?us-ascii?Q?+fM57B8XUtTH7bUFGahRx/WmC2Peg0xpm+2DfmtssJRxDMas5N7J+RraFlvz?=
 =?us-ascii?Q?ZGF6tbjRqqDq47DYlGx/yDIJf4DQJhh0lX/nOTLB1iHaOUsO5H0p8aYk3Ti1?=
 =?us-ascii?Q?KmHP/Bw6SXKleyFl7TRdVcS28YQKkqierRZV9RLgQGDgbItQESlUw0F5LWhI?=
 =?us-ascii?Q?i2ejeYodnFW8vqUemt0JSaIuLaBmFxV5aekCZU3oPkvEunMd9lO0PlWQDAR5?=
 =?us-ascii?Q?OX+fzL3L1HDwd/fPA9DjHFujyX1g1mu5/SqLbpNWSv/DerzrYdEhbdchYbPY?=
 =?us-ascii?Q?Jz6xM4v/CrejnHTN7edj7WV+NL313WfRauFmBbmVQl+3vidvrV/YTX1uIb49?=
 =?us-ascii?Q?iGj94LVdhHD4useMMF+zJlRCjudQtgCt+IcDcQRwLol3mGxdaK+LBMEMIWB3?=
 =?us-ascii?Q?Ytb7ulCutTz6Mf0NVheneKh6F3N1StQc0bz4xhDwXnMEDDU9vFyGP+zRThrC?=
 =?us-ascii?Q?Wqy5Bx9aQrqLdJuLVm74dSYB50dotfhYBI86qcuk06hbRJ/VZegWp55+J7AW?=
 =?us-ascii?Q?B6SAXHeswAc717hMrrC9CAWodpn+GpwP2hO7O7jFiNPleLipQDejyf5eDkWm?=
 =?us-ascii?Q?t29F14ZlFC6eDR2SkfubkZHSD86OxHtmkYpETy+z6EJjZQjRnPI1lCI7pmsa?=
 =?us-ascii?Q?A8i0TpJcp4XxQSwMIrwTzshBs+XBZVN/HeqX01jRUeYS7AicT+3NCat/sG6x?=
 =?us-ascii?Q?yeRI/4vw+TB1fVwTTaKADQB98AbMAhgC606Mxp0Dn5nteumVeuvRpyvsBjA1?=
 =?us-ascii?Q?200hkoUfP0vzAaRFpvdfwiPR8vqkpVNRYZ5cdX1ykX++WnTlLHYY52WCALrv?=
 =?us-ascii?Q?cz3xltfKvOu4t4TcBQkDV0cbkIiZld8hlUNdlgfumradAlYWZZcu0CQhtgUE?=
 =?us-ascii?Q?do1vj2yzuHhSlpn748YpLvoaohyO2/H9MY1eryvPsZtI9ZUzSYFEdAZttYEo?=
 =?us-ascii?Q?d4PMWGWvjUf+T1Iai63hAFE4mnNtpGC20rv2awPxsVtrKrKgkJgYjvoQ9PGJ?=
 =?us-ascii?Q?CeLL5bmNjQV28lFs/7Y4iK9LykdDhYECkOmFVNu1JdAHO/JwrBa2jONr+mN8?=
 =?us-ascii?Q?CG1GE6amwAi0yvC0p6fAwwI/XKfJKzyZ4a2oqe0iYJxwvETrMDbt8wSCK3ay?=
 =?us-ascii?Q?Ib2CCMiCYeNaAPO1XeRvzIRmz9Dc0eaAiHf2ESKReOMOd5NDnTXdbMG/09c6?=
 =?us-ascii?Q?JclVFkUG0wRGBK+6/D7azls70y1r3d4NCgYMm7uRyQIl7kR5yseGK0OftAX0?=
 =?us-ascii?Q?ycQZ+fucAxpg41RjXWFGYwrD9oUW9zzRhhYoD0P1kN0zeLK2pEYI57CGmcZC?=
 =?us-ascii?Q?aOvc+4NeRkb0qdF8UTXzWWf5OQ0saDtcYBHNstWQTrLp2Rt/BvkuGvfgGrEL?=
 =?us-ascii?Q?/aO90aUxuhL5FzzTS9O8FKCx/P+l8g4EbfYPrBU7f06s1aQHsMCG+LbGOEKa?=
 =?us-ascii?Q?ainjmTtTH4UNJtsEHG4r7AgOSluE3eY=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: e27fba91-61fa-4223-d75b-08dee0ee7a48
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 14:53:19.4346 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CokEM986sGHb60gAxtjTQDsUhUrflPRNvSYs5UEl1Gt7NiYsq1atcO3NN1EL1kMGq/s1Uy4qZJRbNMaATEKgpXwdcnHNzKbRa2jM+WkBgCE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8929
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

On Mon, Jul 13 2026, "Simon Glass" <sjg@chromium.org> wrote:

> Hi Rasmus,
>
> On 2026-07-10T12:36:12, Rasmus Villemoes <ravi@prevas.dk> wrote:
>> k3-binman.dtsi: insert keyfile and distinguished name templates in all ti-secure(-rom) nodes
>>
>> This should not make any functional difference, and downstream boards
>> that already override the keyfile property via an explicit .dtsi
>> fragment for each node will continue to have precedence over the value
>> coming from the template. But this makes it much more ergonomic to
>> have the keyfile and distinguished-name have consistent values
>> throughout, because one only has to override the values in the
>> templates and not each and every individual node.
>>
>> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
>>
>> arch/arm/dts/k3-binman.dtsi | 20 ++++++++++----------
>>  1 file changed, 10 insertions(+), 10 deletions(-)
>
>> k3-binman.dtsi: insert keyfile and distinguished name templates in all ti-secure(-rom) nodes
>
> I still see lots of custMpk.pem in .dtsi files after this series so
> I'm not sure of the exact mechanism for your claim in this series. I
> was expecting it to remove all of those?

Well, changing those are not needed for my immediate purpose, I only
need those in k3-binman.dtsi to be updated, as that is the only upstream
file I include. Yes, they should probably all be updated, but I didn't
want to pollute this series with tons of mechanical changes, that can be
done as a followup if and when this lands. 

>> diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
>> @@ -330,8 +330,8 @@
>>                                       ti-secure {
>> +                                             insert-template = <&keyfile_template>, <&distinguished_name_template>;
>>                                               content = <&u_boot_spl_nodtb>;
>> -                                             keyfile = 'custMpk.pem';
>>
>>                                       };
>
> Removing the keyfile property leaves a stray blank line before the
> closing brace. Please can you drop that while you are at it?

Of course.

Rasmus
