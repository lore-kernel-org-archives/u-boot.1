Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD376CD5BC8
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 21:12:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3732C848D8;
	Tue, 26 May 2026 23:12:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="OPI2Ijkv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85B89848DC; Tue, 26 May 2026 23:12:57 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 423E0846BD
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 23:12:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cvcAH4B3bJaBa7DPoqXvY0RUNI+JkBjts4Y42jv1Y4xfmKJC0PkwbhPc2zzU+Szj/r2ZtLCFs9KlveOddzhCdNibNwt797qh+3GsV/dGVBuHCK3UAWdkG5jHmpy5bAr5+j9zlcfR4Bzv8s6Jl5C0IzLr4ZgXvKOREuWzckI88wYvdjPA1sXpSneIMM4dYCZ+SIP2GZRJ1YafRr8gioimGSNYUp4mGvuoFxBQKL8U+rWIgwvWGrpAEcKPg/VWO6KdZmzPY63JiU2FzzMMln2qFOITTw0aTt+q23HYOZtQFU+mR0VJlBX0EeegfS1+Syu3oqtBHQsYbbRC9Gl9YzQIBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QhihRoyKEP9/b5BYeK337DHcTmdiCbTKVLRr3OCARqU=;
 b=WIZ5osoxLnFXHlDdpvQHtoHh5CSasUl9NHKlsoav0Hg4g9NCtV0k+D+ELm/Z9/6ah0/jpg6G4X1npBT6y8ZcjlMsJ7E79i/x8khe+eeqrX7CeI7qz6bT6IQd4Gic8Q4Tcxobg+jRFC/FjvdGWO6OF6yq+VubwylNIg5uB5XapUChBKkRwsHoIQve/jpNc1WZU57eT+eFnweef+FYtluy1H22fom6wR4hS9+uF4M5A500C1/3TpiZe3dsK5oNoEy7PB8hxNNC6K2kXNuaNPIMcNbPi/vgrO6Fkki/iaVJule2JcXPQvtXrgmLQeqFF+qCrjCK7NJ4P85tT/IOZA7ilg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QhihRoyKEP9/b5BYeK337DHcTmdiCbTKVLRr3OCARqU=;
 b=OPI2Ijkvxqwsa9OA6Oc77PiOyyamLR6GqPQyFC0qMGZuzqSVYBHlIbF+cBP4unbkp5Gfsx6kW+lAbSmoCQX7xKS/tHe7MdF9ItGRw969uDwNU80Eo5FqaoWzGEdeL8hcjdpYkW+GGXnfKehBJJWixX6jKAF8yF+6kkIXVl9n940=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by PAWPR10MB7246.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2e7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Tue, 26 May
 2026 21:12:51 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.21.0071.010; Tue, 26 May 2026
 21:12:51 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,  Tom Rini <trini@konsulko.com>,  Quentin Schulz
 <quentin.schulz@cherry.de>
Subject: Re: [PATCH v2 1/3] image-fit.c: introduce CONTROL_DTB_AS_FIT config
 knob
In-Reply-To: <CAFLszTijyoJ2H1kG+6T3wAccHyXFj+M+Mf1w13RU1kVc0Pweag@mail.gmail.com>
 (Simon Glass's message of "Mon, 25 May 2026 09:27:34 -0600")
References: <20260519225458.5587-1-ravi@prevas.dk>
 <20260519225458.5587-2-ravi@prevas.dk>
 <CAFLszTijyoJ2H1kG+6T3wAccHyXFj+M+Mf1w13RU1kVc0Pweag@mail.gmail.com>
Date: Tue, 26 May 2026 23:12:49 +0200
Message-ID: <87cxyhg9im.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: CPBP307CA0003.DNKP307.PROD.OUTLOOK.COM
 (2603:10a6:380:1::15) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|PAWPR10MB7246:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f427c61-aff5-460f-474f-08debb6b8b7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|38350700014|56012099006|6133799003|22082099003|18002099003|4143699003|11063799006|5023799004|3023799007;
X-Microsoft-Antispam-Message-Info: w7eH4HFgD3dZTYhA/vasM/nQVIdtkfTuk/mUvYXqZW2sO8h8kAR5xunRQB2UQsGSDr98KlMZemocPoITPlnliabuYe1ucXdcJlbTRDotmRp92AljFmeYIitZrIZknkdNVtX/z17wuDm/ammETqegajFdLuUd8XPiEt2E2PMJWbtM2RNUZGkNggnRwDxMYbxJ5MqzFR1oTIZC0vgNP6DmoEaTobX4aNUOr4zI68qScMY0SR7/bHl1Xq9xa1fs/JbUvGLtSXhjqvAabpa5CH/oPzQMlHQIqO2/2KU6keW+vxcyFyeAw2NlluQ5p0wocG7YbBVgEgvTKUpPsEPaswTTnPC+B8UI+5lyaV3GZ2cS33p4l50akE2Y8EXUkkypVUXK/2TUQvs54jAexrDcRducWHh/vHKPYdzkYTlpF/LQu2Nb487nw7kZMMRcGlXfP1gJ57EBHxiWLto+INXkUHRVZTQsYfF2y4rCvKHx++6+Fz/V9r0ILLIFVUxe0PWqNLR2hzfY+VuPPdLdsAeyMXjm11b1Xc7wpPkGnA/VUtJvNnahhxD7FAlC2qTwYgKLxnhiblRcMoebPNI/UbQ4EKiP3OvOAaprNWQ7NsDEbIKdqNpoBw2RlXMgI0OOn7TiqwE2Xn+Rro+1S90ujvGRJyL9MiCElti8UkG/uprPhYbi1EeOKmKeAKxMSgOlmsCZUhxRUxOixSZHYDCZ7RKKiIETDyPeAMnUNrHUV08qViZTjSRqpKovbslpQaxTzLEjbn2/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014)(56012099006)(6133799003)(22082099003)(18002099003)(4143699003)(11063799006)(5023799004)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7vOBaYmwkC0tFWCEgaxL0BAUp6IDL74x5ATZzZ84bTncH1LOZbxutK/NKpkF?=
 =?us-ascii?Q?ZpBALYovBRPLRFBzn5IQy8tWvziYFL7McapcrV0JRm82XY8Xt4uKmfgucCFS?=
 =?us-ascii?Q?YVRu8CYW9puDvNzcQGRjMt2yj2CVM2uABAtjUcRTkGF2/FBNt6jCC9D7JpWy?=
 =?us-ascii?Q?mkeEUW0u/9wNar67xTMxWdz6j099yPClbWtDK5i2DeoM6Tjq3Kc9qrDkYoNj?=
 =?us-ascii?Q?inxFqytHmIUbhg1Jfo3BdviN0rvkx1YqqnxlpuSQbHNR8k3oG75K5RcjoI9p?=
 =?us-ascii?Q?CS5avSBMO+UXCLVWZczfQKshtHTLRq64OsDxJnC20y0ksuBrNCLHLuNkkn9m?=
 =?us-ascii?Q?J/GkQVxmyvGLS5UItlkCFA6KopmgEBhdY2oktReDMTfEA9mMAB5CEYizL2kH?=
 =?us-ascii?Q?uQh8upHKfvuCBwa4htq4aVhKpIMQN0wLWjYLENns4tZp+ysu+zjGURxQUvlN?=
 =?us-ascii?Q?ukQDz6PKnBKIzvhjcQ4qRzMp8dVULgM+ZVHz+hBulDQ1yBlwOPDyYH61rDPP?=
 =?us-ascii?Q?NsNtwcFJLKKaPSDNb/zyl3khDf+TLsRl4t/vmp2TIX8E/GNVnG6W1RLfFJJe?=
 =?us-ascii?Q?HcjiZuuLJAlwEq4mUVqn1i9+s8CFgDoinIBNz5lp2+Obf6gvNm1fz2wxyzDY?=
 =?us-ascii?Q?CUIfeaOMGGnwwiMtMmtKm8pobAQ0QrR3dhfe4sptKJ+VWMk9ZVAkThLTpu2K?=
 =?us-ascii?Q?kSS31v3VANu0OMWUveKXO/wU5rIJUC+OrZSCsM0U9jkhqgh6iQ+ofTFClNo+?=
 =?us-ascii?Q?cvcbTwnyMaKpOdXDZirOS0yQlddX50xGbxvf/4++bCZEmCARBqkRgopyCDaV?=
 =?us-ascii?Q?EpOhmUltXjedavTTxVu/2QXIymglh9pF5sdk++i338AqCoyo808yQWaaRiFD?=
 =?us-ascii?Q?pMHj1Eah9hKBiA/A3EXPOooRpW3dR4cRii43rfMKvzzmu1G3otF0rOWS+Id2?=
 =?us-ascii?Q?lPJSMisbqTeQ2PB1vdShnw+nGqcrcKE89HLV+CpCYfQM3Embb9Py5nHLedrK?=
 =?us-ascii?Q?5w6/Yd6YMrcCOujp+HnzgWUeooSvGcQrnleJuCyzEc8yhWoHdP1OTyWDb0Oz?=
 =?us-ascii?Q?TmMJaGYTJeKk4hwfzF+9ji1lJ9GjgC+5D1bMPjG8jsIFYo2clx62ybK3FAXH?=
 =?us-ascii?Q?01laNPAs5v58KfO/r8Lmhos7C1nqPEPseanUU7j1Up5tnFVAKn73VTpGQj9c?=
 =?us-ascii?Q?wKCGiXCthmcO70MXG/zRkfr1c97tvcaSqA68VH7btldcLYPOXfzJHu7Qz67W?=
 =?us-ascii?Q?ZgJmKEYIJhQ0l1PdIRKRSuyJ5Pu4Yv+rLMB3ZctHuAmVaGGbqhYRQz1n5i2N?=
 =?us-ascii?Q?Yki3dEhtvkGG+ZGuSDM8uS8YyLllDXuYrMUT+7kK7AKN/RWpOJFWkvxQf68s?=
 =?us-ascii?Q?x8OIsehbCGjrJSLo1DB0k+lgROjEt30X6r/oXVJVVKwBswR+/YPfa2ElRyPi?=
 =?us-ascii?Q?GjJHg2W9i6Nm5DxMZ7KbjvqCKLicVAH0G8Ty2+258RMkXhYCqP9XYH1rcYVn?=
 =?us-ascii?Q?Ksv+Ymh7GHad/ZTv2NHz55jlNpS9qb9ii5DJA9w7sLRs5/M221Q1upRgQezz?=
 =?us-ascii?Q?OeYIxj0ggFRYNYpgaYqR+HZRG5+vPOqTLxKV2D3trrK+Jn2lkmZIAL/fbARd?=
 =?us-ascii?Q?VHFU6ieM41jNbzquHlPJMFqCONfnjW8sdjCaaQQKxAdPO8BTaPhPj9vUhMDT?=
 =?us-ascii?Q?C5onewNQBz5O6a12X+aoE3qsgrEEek5wNReacRZscVEnMzOmkT/Da6UlvtzI?=
 =?us-ascii?Q?ldLXoJFirKmBJuKOY9ubQ88Q9vOfAEs=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f427c61-aff5-460f-474f-08debb6b8b7f
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 21:12:51.0389 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9VZkcTwurZ/YDrgXZuvf1gzto6wnLswsKZmBPnQcEZN/QJY7orOD+Npw8oy9ZAUH/p3zYVDQlHHnoXxXpfn0lkEEU1BfyxJ8pxLqGp16ELk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7246
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

On Mon, May 25 2026, Simon Glass <sjg@chromium.org> wrote:

> Hi Rasmus,
>
> On 2026-05-19T22:54:57, Rasmus Villemoes <ravi@prevas.dk> wrote:
>> image-fit.c: introduce CONTROL_DTB_AS_FIT config knob
>>
>> Having scripts embedded one way or the other in the U-Boot binary
>> means they are automatically verified/trusted by whatever mechanism
>> verifies U-Boot.
>>
>> Writing those scripts in the built-in environment leads to
>> backslatitis and missing or wrong quoting and is generally not very
>> readable or maintainable.
>>
>> Maintaining scripts in external files allows one
>> to have both syntax highlighting and to some extent apply shellcheck
>> on it (though U-Boot's shell is of course not quite POSIX sh, so some
>> '#shellcheck disable' directives are needed). Getting those into the
>> U-Boot binary is then a matter of having a suitable .dtsi file such as
>>
>> / {
>>         images {
>>                 default = 'boot';
>>                 boot {
>> [...]
>>
>> boot/Kconfig     | 9 +++++++++
>>  boot/image-fit.c | 5 +++++
>>  2 files changed, 14 insertions(+)
>
>> diff --git a/boot/image-fit.c b/boot/image-fit.c
>> @@ -1676,6 +1676,10 @@ int fit_check_format(const void *fit, ulong size)
>>               return -ENOEXEC;
>>       }
>>
>> +     /* For the control DTB to act as a FIT image, we only require an /images node. */
>> +     if (CONFIG_IS_ENABLED(CONTROL_DTB_AS_FIT) && fit == gd_fdt_blob())
>> +             goto check_images_node;
>> +
>
> I wonder if you could avoid the goto by using a bool? E.g.
>
>    /* control DTB is trusted */
>    bool as_control = CONFIG_IS_ENABLED(CONTROL_DTB_AS_FIT) &&
>                      fit == gd_fdt_blob();
>
>    if (!as_control && CONFIG_IS_ENABLED(FIT_FULL_CHECK)) {
>            ...
>    }
>   ...

Not really. I mean, sure, I could avoid the goto, but it's not just the
FIT_FULL_CHECK I want to skip, it is also the 'description' and
'timestamp' checks, so using that bool I'd have to modify those if
statements as well. And I think the goto is actually the cleanest
approach.

The reason I didn't lift the 'check for an /images node' up and inserted
the 'fit == gd_fdt_blob()' after, doing an early return, is that I think
in the general case, the FIT_FULL_CHECK doing the basic sanity checks of
the dtb structure itself must be done before we start asking questions
about which nodes or properties it has.

So I did go back and forth a little, but in the end I felt that this was
the cleanest and most focused addition.


>> diff --git a/boot/Kconfig b/boot/Kconfig
>> @@ -103,6 +103,15 @@ config FIT_FULL_CHECK
>> +config CONTROL_DTB_AS_FIT
>> +     bool "Allow U-Boot's control DTB to act as FIT image"
>> +     help
>> +       Enable this to exempt U-Boot's control DTB from the sanity
>> +       checks done to ensure FIT images are valid. This can for
>> +       example be used to embed whole scripts in the control DTB,
>> +       that can then be invoked using 'source ${fdtcontroladdr}'.
>> +       See doc/develop/devicetree/control.rst for details.
>
> Please note in the help that this is safe because the control DTB is
> necessarily trusted (any verification covering U-Boot also covers it),
> and that only the address matching gd->fdt_blob is exempted - not
> arbitrary FIT loads.

OK. Something like

       Enable this to exempt U-Boot's control DTB from the sanity checks
       done to ensure FIT images are valid. This can for example be used
       to embed whole scripts in the control DTB, that can then be
       invoked using 'source ${fdtcontroladdr}'. In a secure boot setup,
       this is safe, as the control DTB is necessarily covered by any
       mechanism verifying U-Boot and can therefore be trusted. This
       only affects the case where the image being checked is
       gd->fdt_blob. See doc/develop/devicetree/control.rst for details.

Rasmus
