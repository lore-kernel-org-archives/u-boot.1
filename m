Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94CB1CE7A81
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 15:14:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D45886C06;
	Mon, 25 Sep 2023 17:14:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.b="fur3bSQ+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0457C86ADA; Mon, 25 Sep 2023 17:14:47 +0200 (CEST)
Received: from s.wrqvtzvf.outbound-mail.sendgrid.net
 (s.wrqvtzvf.outbound-mail.sendgrid.net [149.72.126.143])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 932A286D4C
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 17:14:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bounces+31435339-7456-u-boot=lists.denx.de@em2124.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=mime-version:subject:references:from:in-reply-to:to:cc:content-type:
 content-transfer-encoding:cc:content-type:from:subject:to;
 s=s1; bh=1CP4kVoVG+m1XCGiwhqLn6RSkLiaVxyAddHf92+yh7E=;
 b=fur3bSQ+w6upKPXLZnoKG32F+XeAXHEZ4VbtDrwM6wrH126JRokTRrAIcQBY/qHPIslL
 0319cUn0BMNioBxjFRVfdsfJclD1kVYiydhFcrqw94GQIX+CBPIf7XOn3ehDwileFlbKn2
 m9SMS0encO3FHcFNE3mkuaYN73fFYbKC5Rv8iu93ul6JYE4Tqe3couDuhRl9g5F3cC9817
 QFQRF6ksxu5YQHaB39X+V7goz30vECk5j80lygE9SSqeKeoZNAPumW4s4FQTFH1DqMbHXC
 OCl13Bl/TuHfzAMw2UBK6DGQJu72wUnxohEHESeF23aTewc1SYeK+tz50LX3E9wQ==
Received: by filterdrecv-66949dbc98-2wdbb with SMTP id
 filterdrecv-66949dbc98-2wdbb-1-6511A3E1-56
 2023-09-25 15:14:41.976536415 +0000 UTC m=+871209.258987143
Received: from [192.168.1.50] (unknown) by geopod-ismtpd-6 (SG) with ESMTP
 id PVKwqHAzTna0ZpBG6diEHg Mon, 25 Sep 2023 15:14:41.670 +0000 (UTC)
Message-ID: <30f28625-865f-8342-95cb-5017c0db4277@kwiboo.se>
Date: Mon, 25 Sep 2023 15:14:42 +0000 (UTC)
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 4/4] binman: update documentation for fit,align property
References: <20230919113705.109639-1-rasmus.villemoes@prevas.dk>
 <20230919113705.109639-5-rasmus.villemoes@prevas.dk>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20230919113705.109639-5-rasmus.villemoes@prevas.dk>
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h+yYBTPU+oTqVZBiv?=
 =?us-ascii?Q?hMYmprN6QmVKGhFUPVHOS3d5c3+orHqCv5yZa+f?=
 =?us-ascii?Q?jyY8zdM7yB=2FCdFqFRKtkeAKbmsTnaCeLZM6Wqs5?=
 =?us-ascii?Q?idg3TV6aUicJEeulCqn=2Fb61hJfMJ02SDx0+Rcb8?=
 =?us-ascii?Q?aYiCEj6s43aSYi5mqiKevyzwW63YbV9gC5G3Ne?=
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Simon Glass
 <sjg@chromium.org>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Kever Yang
 <kever.yang@rock-chips.com>, u-boot@lists.denx.de
X-Entity-ID: P7KYpSJvGCELWjBME/J5tg==
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
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

Hi Rasmus,

On 2023-09-19 13:37, Rasmus Villemoes wrote:
> Eliminate the repetition "what alignment to use ... and provides the
> alignment to use", and indicate that fit,align can both be used by
> itself and together with fit,external-offset.
> 
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> ---
>  tools/binman/entries.rst | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
> index e7dfe6b2a3..f9ad27ce8c 100644
> --- a/tools/binman/entries.rst
> +++ b/tools/binman/entries.rst
> @@ -691,9 +691,8 @@ The top-level 'fit' node supports the following special properties:
>          external offset. This is passed to mkimage via the -E and -p flags.
>  
>      fit,align
> -        Indicates what alignment to use for the FIT and its external data,
> -        and provides the alignment to use. This is passed to mkimage via
> -        the -B flag.
> +        Indicates what alignment to use for the FIT and, if applicable,
> +        its external data. This is passed to mkimage via the -B flag.

This only updates entries.rst, please update tools/binman/etype/fit.py
and re-generate entries.rst from output of running binman entry-docs.

Regards,
Jonas

>  
>      fit,fdt-list
>          Indicates the entry argument which provides the list of device tree

