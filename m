Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C9BBE80AAD
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 14:19:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43E4186D59;
	Wed, 27 Sep 2023 16:19:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JsuOl2A8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A267C86B95; Wed, 27 Sep 2023 16:19:42 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A99386D91
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 16:19:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-534848725e8so2928328a12.0
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 07:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695824380; x=1696429180; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VekqCMLKs9Q5kHVCbDmXUrIfxykJ5lvToZpw/hMzDxU=;
 b=JsuOl2A8kKfruG0ftfO68r/hCXySwC++2oAX5RISqRH+klcLvpmgfYL3CclA2l4nOx
 mkhx1C7ahJ8roN+4YoQqrM7/KhmZlUvwEOMAYfkAhEOTgh/NXa39xp6M0I0fbV9mchvI
 R6HjflbmCbJIS6uFfsQNXxA9Yax/6mNxG3gBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695824380; x=1696429180;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VekqCMLKs9Q5kHVCbDmXUrIfxykJ5lvToZpw/hMzDxU=;
 b=OAKLRtTdarcdvGyigj0d01B243Q5r6ukOLowNrKbJ/8Wq1YisVQXgoFMHwCgDRsCAN
 Pk0mOgjZ4noHIuZn8lU8ZKUB5DQUUcX+dQrq778aYj+9YeNjZKjq/zeJCHL3xvdT2eqY
 u/zynIJlLbAb9RspdrKMtSUtzUmpxHdLWBv/2llYySxy+6INHC1j6CHx7+IOVoC/alqR
 TWaD0gbF+UMi+U+Fq11syAvJzAlc1Ww9x2lx3/fDVKf1IZNsEzz6jD3j8TuQFEIjx4lm
 egQTzersEuK6yA4CHV6LILqqnE7LzGAj4c9tiL9MRDdrtUNEoDIxIUhciTkYCWDPOMfn
 7euQ==
X-Gm-Message-State: AOJu0YzSdvfFJ4FgXuJWE01bM3HL6b9aGCpJ3d+1f+1y6l8FW2eqbynK
 ih6E1OXzVI5JmRPaQas+LDRMAaUWh/PuALsY5KXTrQ==
X-Google-Smtp-Source: AGHT+IHbT9rATopFb7nn8GByEZCeRunOvWfU3270Nf1qohFHF97YAiTrONdhoV4pGx/nRYjrrv/sXpeUzriUb9tviO0=
X-Received: by 2002:aa7:da19:0:b0:525:442b:6068 with SMTP id
 r25-20020aa7da19000000b00525442b6068mr2157722eds.13.1695824379696; Wed, 27
 Sep 2023 07:19:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230919113705.109639-1-rasmus.villemoes@prevas.dk>
 <20230919113705.109639-5-rasmus.villemoes@prevas.dk>
 <30f28625-865f-8342-95cb-5017c0db4277@kwiboo.se>
 <9f8ea578-1b32-f0f5-02be-ffb267cb6197@prevas.dk>
In-Reply-To: <9f8ea578-1b32-f0f5-02be-ffb267cb6197@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 27 Sep 2023 08:19:28 -0600
Message-ID: <CAPnjgZ1Uhb=+jdKen4tKrFPhXuiJEhZkKzDi1JwVh_21gP3y1A@mail.gmail.com>
Subject: Re: [PATCH 4/4] binman: update documentation for fit,align property
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Jonas Karlman <jonas@kwiboo.se>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 26 Sept 2023 at 00:25, Rasmus Villemoes
<rasmus.villemoes@prevas.dk> wrote:
>
> On 25/09/2023 17.14, Jonas Karlman wrote:
>
> >>      fit,align
> >> -        Indicates what alignment to use for the FIT and its external data,
> >> -        and provides the alignment to use. This is passed to mkimage via
> >> -        the -B flag.
> >> +        Indicates what alignment to use for the FIT and, if applicable,
> >> +        its external data. This is passed to mkimage via the -B flag.
> >
> > This only updates entries.rst, please update tools/binman/etype/fit.py
> > and re-generate entries.rst from output of running binman entry-docs.
>
> Ah, I didn't know the .rst was generated.
>
> Simon, want me to resend (this one or the whole series?), or can you
> fold in this when applying:

I can fold it in, so long as I remember.

>
> diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
> index 2c14b15b03..97d3cedaf5 100644
> --- a/tools/binman/etype/fit.py
> +++ b/tools/binman/etype/fit.py
> @@ -71,9 +71,8 @@ class Entry_fit(Entry_section):
>              external offset. This is passed to mkimage via the -E and
> -p flags.
>
>          fit,align
> -            Indicates what alignment to use for the FIT and its
> external data,
> -            and provides the alignment to use. This is passed to
> mkimage via
> -            the -B flag.
> +            Indicates what alignment to use for the FIT and, if applicable,
> +            its external data. This is passed to mkimage via the -B flag.
>
>          fit,fdt-list
>              Indicates the entry argument which provides the list of
> device tree
>
> Rasmus
>

Regards,
Simon
