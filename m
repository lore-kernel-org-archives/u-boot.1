Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33004C3ABC3
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 09:32:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7118B8091A;
	Mon, 12 May 2025 11:32:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="BSvwHyR3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14ADC81DD6; Mon, 12 May 2025 11:32:02 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B987805D7
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 11:31:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pvoiV0PyA5IbxpJj+eDxeuNqw8urEk/7j7rnkl3FaaNTfnEH+HOzZcJfeoxvfKDogkSzXFn2Ziih0gieIgWJbV3EEt+PC1adC3dAnpBBtvopxKF1sBeq2dibWrgrOG7keZB0vmjx/ZpuHi07+aeOW2R87IXyzlWzdEivBRd7Nx0Ai53mpXGetnyqF26h9BYDmzdhFURTL0VfBaG4Zp6SN6k1NK0g795E3XRimLvHorR6UAplHWXXjwszUZfb9EEtJYS/8+XrNdUwtSg0bdc+TWuUgGXin2CzX6YBqeOuhYpSNEP5wzDwIjpf0VGq2YPwlKxi1t75DXZ/RHy1HCqzwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ryVgupWyf7I/ZQ2SV8gt0fZlfII1l+jdeEDzVNmXac4=;
 b=JaRV6PAZSBeclrSgQ8RO285N45YWAGS5H5au0z8wgMTll2psmmB0wvNcWNocuUlkUFwNXgkKLYvuulzn3CAogWBXIU+N+eq7hGmZ8jD8tvtBjVa53LGAR5jreNMzLbeTKdnskdZhSqaRtDQaQawDTdCaqyBgbdsCwAFvHJ3YdW5gUKRVNynzEjRbpO62L9W5l0fQQKihx7h+11FGjIuknSNXAlJloyrGK56IA/IJSQV0zbOJC1E+FPlS3DcdBtMS3f4KaRL7jjrRpjmYcQi9BaI0oDG3+iYEtL9RGUNNtB1wxAJsnhxxQ9weTOEVvh7LUPC+mFlE8KihAK1YpsFTuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryVgupWyf7I/ZQ2SV8gt0fZlfII1l+jdeEDzVNmXac4=;
 b=BSvwHyR3bHUZywu1g/0iKOQ9GbYiczwlJsixLO9iVzZK0s87cqxJgymtunPl/oNwFv3HdIkO94PPq+x/qyCVM+dndEivfI1mLcqEwk2WZoPneqyXvek5itTN8eombE5rENU4Xa8NnzmWYhFMTvQ9EXOzfZRzMjsc0K2UNGS32ak=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by AM7PR10MB3511.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:132::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.26; Mon, 12 May
 2025 09:31:56 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 09:31:56 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: <u-boot@lists.denx.de>,  Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] doc: document test command
In-Reply-To: <3f0c1dfb-5c28-4160-9a8f-f49ad380bb50@cherry.de> (Quentin
 Schulz's message of "Mon, 12 May 2025 11:03:22 +0200")
References: <20250506205439.415877-1-ravi@prevas.dk>
 <3f0c1dfb-5c28-4160-9a8f-f49ad380bb50@cherry.de>
Date: Mon, 12 May 2025 11:31:54 +0200
Message-ID: <87v7q641kl.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0056.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::29) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|AM7PR10MB3511:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f36e67b-7ecf-435c-7243-08dd9137d67f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|7053199007|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Xkjj1lrnNvs/sBsc6qmferE9ghFU+iYDTD1U0V8RFUGtyW3w8hh5/fbA1tD5?=
 =?us-ascii?Q?CpZMJyNdGq38Z4iIhCETwm9yTXx4hlBFH9dCjaecbQu+hj0krWM8teo/DfRO?=
 =?us-ascii?Q?cKgUK2BJX/wg/9IBKSzMZ33U7LBnYc2xL1r+hZGfcPV0BKhhtA2aoPMopZFW?=
 =?us-ascii?Q?Ydx8uFjnrKjynYcRpTB68ACu+k5hPEEfbNqJyVTgz5EkY4Tfz+ubbEXBlm+A?=
 =?us-ascii?Q?h2a7aYBV6j+/JqzxL3X5asFtKcr1zbZ0EilrueoITlSTRuVz6BH8jfpmlqnv?=
 =?us-ascii?Q?Qat+1go6c1CqXL+yRdqXO8ZTv8KXHQcgpKX2YN2v453WTpkLViFuQYpz7R3C?=
 =?us-ascii?Q?R3HrgCyCXBZ/tJrHSkZg7Nzg8AsvX9+23kX/DclG1wilftEZ/N63XVADV64A?=
 =?us-ascii?Q?CfteLdmbreRr3bz20FYtBt2UhAOCfvTMBK4pIQNjvqJZoX7JE1o+Y1REFgL/?=
 =?us-ascii?Q?sIQsaAW68N5zOqz+8Btaxry66Hh5T1aLT06FnXSWm2Ec14SfjKBpKb44iD1j?=
 =?us-ascii?Q?JbC8IoaZJC4iF0+fUygZfIC9qXSWy/RYHU4Xsk0ypHu97xvx9ccv4nbFKg1V?=
 =?us-ascii?Q?/pH7FnCNxOVg8eQIOtZGGrHAea7CrSJkdwrw3cNcXjbtfy4yITP95Wumx1J0?=
 =?us-ascii?Q?X1pY4aQ76Vbe9FQ6cTrB2vpiXTqKfL6JSLp4QVFVgZ+J1dyWXpcAkG3iyGOC?=
 =?us-ascii?Q?bdgIKmlK3MpUB3vOiQuS1/OdiVGL9jSC13CeA7583XMgcmAbaUecNq9F6Jl1?=
 =?us-ascii?Q?yedjDP9ccfhsoPAMHfrl4ByfRwVR0ld4mqE+OTjUTD3n68av2IKJ6Anwi13F?=
 =?us-ascii?Q?+Khc2d8xz26lOPzqnpA3dOa7IoHDfNpBCJ8TM65DTFg9XZy7rqnnFoKT9xAR?=
 =?us-ascii?Q?a0kh4AK2S0IM5Xi+Aigt9pLezlEdhX6r615Yu/J6hMNdYc1OgQtsL9XA/zvb?=
 =?us-ascii?Q?jWlxeH6QHiMAxQ8Bwtr3hKUdhHb5/bHIWh5VEjoJUuw0tGNAUkXy8/EwIU91?=
 =?us-ascii?Q?BNoMUiysylX7o9RNRqPxhTruvsGyQxaRrF2VGBjoeR/E8M7s5iHXciKuo1JP?=
 =?us-ascii?Q?NbI57Q3DVVWPvFNVooyVDHe8GPgEgXfbsazB8RUevVv++CJJk2Wu0Tgveo4u?=
 =?us-ascii?Q?EDzGy+sfePExHK8eSSPqDdxjLP3XB0PAoLUHCuEk3SanDXf9XtO+0h4WTwMd?=
 =?us-ascii?Q?u7hEc0eeMu4JY6PMaMxW/qFwYjyBZWRl0YYFsqQ2w2INIk+8xpzG/2AvQkaS?=
 =?us-ascii?Q?RpEjLOOH1EJXWN08a7fnov4tm8ljAXLAfh/VM89ByFKaEmH1iVMigehkmj5w?=
 =?us-ascii?Q?5QK+NECHNb8wfA4MyHUxui85HpsjimxbaTP1ipRyGqO0Vj2v6Y1Io8KzzaPt?=
 =?us-ascii?Q?SUAEmgVlkEKZwLjoOM9rAf+nlmDo8s4GIOMdtqbH7in8IWULRREEUaW6wuMm?=
 =?us-ascii?Q?l+yB9w9EqdSza1gwYoM3Xae8NCr73W1umIdcKOJ7hAz8Nm25CXrRZw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ov3vp4ZqJSf/g369kel6AWy2L7nCEQ0OhTqQy25Hr4tBEr0unlWiHAEEipOj?=
 =?us-ascii?Q?m4cK5vd5TVnuK1S3Nk5oqe/anDCfsGeA+yNqXNiwBb9Sg+BEH9Sd+XfuF1Gz?=
 =?us-ascii?Q?Qf3TRtW7xbRoNPhYlfmYWpICdL9zdl3lHtVwMmh5adNvhWBfyQEU4abd9bJO?=
 =?us-ascii?Q?kHpm2X9CGaQWFizL+k5gCkdYKqWvq37sziP8gboAeLNFS1MaGKQVVfCOyFaf?=
 =?us-ascii?Q?UuERxTLm4I32WrXEhBlD9PsE0k6L753AI5oLx36EghUp1JWXvTKBp+vA2Tlx?=
 =?us-ascii?Q?oGUEciaRJdMgsDUwkfY1RdqlwmVkLRDuaHfaMfnWLv5l0ZgB1Y7K5CRwZzOE?=
 =?us-ascii?Q?rMdck7n1LmUcL0UzOpaIkBPcHbAyPZPiVA8n+s527KHdPaL87HJCPvFjTem/?=
 =?us-ascii?Q?oDStqZv0OjPigKecOgagoBifo1qgq0DNKIuI3QlNqXSMKp/SViqE+iiQbZaU?=
 =?us-ascii?Q?yQnw7pcCTm0/YdzHnIbWmdIXoYsr47LOCD+jm6A4AQ+iRzXOApzh9xmAvSp4?=
 =?us-ascii?Q?mx476sC3aZC4CSxqOfILw2fmCEvqn6/5eLScZZvOVJ1muAwsJz/alLT4VyRk?=
 =?us-ascii?Q?K0T3wuJPeX0XJyUtVmaXS4mTH6mBZqlNnHtwlglvIt2/68XfN22xD0kQ/fqp?=
 =?us-ascii?Q?VBg9lc6grgESfL4F8tDMglCHjotjbmZB38VYU1wYMUcTQIfkEnN7oxPk9xAG?=
 =?us-ascii?Q?IzQa6EhfIihxT4RTmLaCA27dso2l1BygRaN6X4BJ431nRL6ODt9qXgDYYbTe?=
 =?us-ascii?Q?KthpUSfvxXL7rTQR6dfDjSxDwtBybsecWMNxumlj4XIgmPtEVmA6ZHIVeBrr?=
 =?us-ascii?Q?ImvKqQ8yf0Kjuag5VN6oXZdm3676epghykOzBVsZ/EX0nrLth7ynLROkPoJt?=
 =?us-ascii?Q?BXJjQ+eJm6O/qYCVfvu5w+ax6GyU7HCmrkupwpLr2+xWTb3h00DGUcUti/vY?=
 =?us-ascii?Q?m6MsBDWxzZoCwj3WG2qJIn+mMdNvKUCKVeSEkAFwTZynjuptQuUiqPW1nEJQ?=
 =?us-ascii?Q?bF/gHU7KyItZERv54yWp7WXs1gN2NxsKAicbw88n02cJR21YuW225lw2GRWO?=
 =?us-ascii?Q?HXnZ14GgOK/ydcBenbcuulYHCKmxyG+hbjk78ql0a4Wu+PesW9g3/Lj9TyZ8?=
 =?us-ascii?Q?lprDB2+CVZLhoYb7FUPbPCcZF52BJj1CZfwbv4Zur7mNFSsTT9D7M9vUGqtN?=
 =?us-ascii?Q?gbyEl0fV/3t8TV0ymrbDIvxx69Y9G1aH2p/CKhgoPdtIdwXRWbXDPXqNp+7K?=
 =?us-ascii?Q?O8aEII8+HcH7VyicfH2Gv3+NH6P9PPLNQGTTVuXh6gXf9Yt3AtLprQ2Hd6rR?=
 =?us-ascii?Q?QMy9Kzg6beg7fphnEluflutY3X+ZCKxmFd/0bVfBdUNvtL60WNynZYh9d/YR?=
 =?us-ascii?Q?pHXyE6jBsW5r8lgH9uvQmKsz8wlVOzNh4eFb7iZM26cVtDJuO1aHpIJuZFhy?=
 =?us-ascii?Q?yEMhb0PebLqUUwh7sb18kt/pJqaM9JAxrqILW/1IZnI56nzK8UIYigRDDquB?=
 =?us-ascii?Q?i5T2ufQBB4G+zEMB6fcDORzCIOBGZj4uvWP0lCHUpFpEEjZSqMSPjNFOjn07?=
 =?us-ascii?Q?1MMLzkibPtDpv6zaEuD1x5uVMPLYbd11FYDoV4hSoM+M6mHwVSjjuRrE7bW8?=
 =?us-ascii?Q?pg=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f36e67b-7ecf-435c-7243-08dd9137d67f
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 09:31:56.6191 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Zm8Nzi1niCM3iFoOSjffPOz944ei2wEbMmzomlslii4PlH+NklDMH9GrsLWQY567x6jX9ncruRb9+7dipDEd2ucoMzZHf5As1D2pHLnQ74=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3511
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

On Mon, May 12 2025, Quentin Schulz <quentin.schulz@cherry.de> wrote:

> Hi Rasmus,
>

Hi Quentin

Thanks for the review.

> On 5/6/25 10:54 PM, Rasmus Villemoes wrote:
>> +
>> +Numbers
>> +~~~~~~~
>> +
>> +The number comparison operators ``-lt``, ``-le``, ``-gt``, ``-gt``,
>> +``-eq`` and ``-ne`` work as in ordinary shells.
>> +
>> +*Note*, however, that the numbers are parsed with ``simple_strtol(,
>
> Maybe use an admonition here?
>
> Something like
>
> .. note:: Numbers are parsed with ``simple_strtol(,0)`` ...
>
> so it's (hopefully) properly highlighted?

Good idea, as I said I'm not really an rst expert so I mostly just
copy-paste.

>> +0)``, meaning that they are treated as decimal unless there is a 0x
>
> ``0x`` ?
>
>> +prefix, any errors in parsing are ignored, and parsing stops as soon
>> +as a non-digit (for the selected base) is encountered. And most U-Boot
>> +commands that generate "numeric" environment variables store them as
>> +hexadecimal *without* a 0x prefix.
>> +
>
> ``0x`` ?
>

Hm, perhaps, I'm not sure if "code" highlighting is the best for those
0x, but I agree that some highlighting is in order.

>> +For example, this is not a correct way of testing whether a given file
>> +has a size less then 4KiB::
>> +
>
> s/then/than/

Ack.

>> +  # Assuming readme.txt exists, sets 'filesize' environment variable
>> +  $ size mmc 0:1 readme.txt
>> +  $ if test "$filesize" -lt 4096 ; then ...
>> +
>> +If the file size is actually 8000 (decimal), its hexadecimal
>> +representation, and thus the value of ``$filesize``, is ``1f40``, so
>> +the comparison that is done ends up being "1 < 4096".
>> +
>
> All nicely explained! Can you provide an example on how to do this
> properly though?
>
> I assume something like:
>
> if test "0x$filesize" -lt 4096 ; then ...
>
> maybe?

Yes, I think that would be the proper way - but it's really messy,
because if you ever have some variable that happens to contain a hex
number with a 0x prefix, adding another 0x in front would end up
yielding 0 when parsed. So I don't want to give the impression that one
should always blindly prefix 0x (also, sometimes one really does have a
decimal value). So I'm actually leaning on leaving a "positive" example
out, to force a developer to think.

>> +Logic
>> +~~~~~
>> +
>> +The ``!`` operator negates the sense of the test of the expression
>> +``<expr>``. The ``-o`` and ``-a`` operators perform logical or and
>
> logical OR and logical AND (and maybe even highlight them with
> backticks like ``OR``?) to make them stand out of the sentence since
> those are typical English words it may make it harder to parse the
> sentence if left looking like all other words?

Ah yes, ack, I did think about the "logical or and ..." reading quite
oddly, but didn't think of a good way of making them stand
out. Capitalizing is probably a good fix.

>> +logical and, respectively, of the two expressions.
>> +
>
> I would have the second sentence on a newline (with a blank link
> between the first and second sentence so that they make separate
> paragraphs in rST).

Ack.

>
>> +File existence
>> +~~~~~~~~~~~~~~
>> +
>> +Like ordinary shells, the ``-e`` operator can be used to test for
>> +existence of a file. However, the U-Boot version takes three
>> +arguments: The interface and device number (possibly including a
>> +partition specification), in addition to the usual path.
>> +
>
> This could be a list, e.g.:
>
> arguments:
>
> - the interface (e.g. `mmc`)
> - the device number (possibly including a partition specification)
> - the typical path to the file
>

Ack.

>> +Regular expressions
>> +~~~~~~~~~~~~~~~~~~~
>> +
>> +When ``CONFIG_REGEX`` is enabled, an additional operator ``=~`` is
>> +available. This is similar to the same operator available with bash's
>> +extended test command ``[[ ]]``. The left operand is a string which is
>> +matched against the regular expression described by the right operand.
>> +
>> +The regular expression engine supports these features:
>> +
>> +- Anchoring ``^`` and ``$``, matching at the beginning/end of the
>> +  string.
>> +- Matching any single character (including whitespace) using ``.``.
>> +- Character classes ``[ ]``, including ranges ``[0-9]`` and negation
>> +  ``[^ /.]``.
>> +- Grouping ``( )``.
>> +- Alternation ``|``.
>> +- Postfix qualifiers ``*``, ``+`` and ``?`` and their non-greedy
>> +  variants ``*?``, ``+?`` and ``??``
>> +
>> +For extracting the parts matching a capture group and/or performing
>> +substitutions, including back references, see :doc:`setexpr`.
>
> Question: Should we provide an example use case for each test subcommand?

I don't think so. I'd assume any U-Boot developer to be reasonably
familiar with the ordinary shell test, so I think it's better to just
emphasize the differences and gotchas than providing "shell 101"
material.

I'll fold in your suggestions, then resend the whole regex series with
this one properly included as patch 12.

Thanks,
Rasmus
