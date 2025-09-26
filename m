Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E163CAC5B8
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 14:48:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2839983692;
	Fri, 26 Sep 2025 16:48:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ms9DbPkE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96F1A83677; Fri, 26 Sep 2025 16:48:28 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F21E83692
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 16:48:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b2ee3c13aa4so348169466b.3
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 07:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1758898105; x=1759502905; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=upm3Qgl++c+4QXd6lAjSFbLcGtWiuXaUFc/N1QWj8Ck=;
 b=ms9DbPkEwS1tWTrwhQfVp1ujPwSqb5V1QYKzc2KZhFjMcVjiDYLDubzKpSUlMS9hcn
 2zP5AKESXlEdu/qLYSNimmi0ULWLl/NGfaCGGQlctmH2/n/raGUr3s5qg91XOHgQE0dR
 pdO30fNlSjphK8TyrNqIw5rNRuwFcWgxEbzq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758898105; x=1759502905;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=upm3Qgl++c+4QXd6lAjSFbLcGtWiuXaUFc/N1QWj8Ck=;
 b=PYBZfyyeI159P/4Ce7pt3m0Xbl/CKFPNrRjg84LEkmo1R5y+nSl2SNd7c3HgqRHcUt
 I8sqsf2Jb2CeejkPWL+wDijrWLTU+QEGgRy4ZrG1dRXOFYJzaMf/ZNc9iaSkN+6XAQds
 ZRq9DRupw2E8lq5aXtn+mMYnlnH+2B5jzSPwS1stOuqQ96/RTdkUkqkAS0q/J4ib1B9e
 UAsRExTkKW0tvzyOlJ1QLbGR4yO/cq6gRClzPelUFcHBohZdhyhoZb7RkJaeVjOIJBg4
 CD8DbTEjokHUGryD6FnpQnsAjyBgSj2tYwMucAq6a/oy48l3+jppumZJz6/z1FUzhM7z
 ueyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXF+jjwhuCp2xvNNaqB50U4RbWNUXs8+hs0LKf2TzLTHp2wKajaokYDZZCqU3qMAe7gXESeYJA=@lists.denx.de
X-Gm-Message-State: AOJu0YxLWDOLtKhgV2UtRYnXIXMGR1RFZOQIc8oQfNF439PIUqzN8eUX
 DJcgqm1m2fVo8NnMg0vv10ilttstsn4v3y9SjjCMfVF4d4DwRF0fGDuv5PfFadaKbW9MMilQ6Hp
 B2JvFWieQ27uBKIgUgWs7LLgWAvRpZu8VEFgM9b75
X-Gm-Gg: ASbGncuXnC1VY/5pCOU9dPvRkmX9F//c5TTi+qxtXB2ObmxkoaOLFSiqkikbQbinKyG
 Fy2Lrd5C3NJRfobgBkndDFm7jIhDrLWm0uJ7oj6cUbmvz5csKuVMYJVdwez+SSXczXssOgOHjQw
 yxrojdwbZp8gMjrrhK+ZWGEf997hirXCpBoNIDvjQwf184HAORzVYSEuKz5tz3bJdxdB3EVikaD
 8jepg==
X-Google-Smtp-Source: AGHT+IG140J5hgDEwyBOvL/yv64vX+v36ofjbkhxkcUjbbLWHlpDwFlvZVF/T16OdQ8e1lQUtMf3Wk9se0KhDD6kaW8=
X-Received: by 2002:a17:906:6a14:b0:af9:c119:3b4 with SMTP id
 a640c23a62f3a-b34ba147a76mr837074766b.13.1758898105324; Fri, 26 Sep 2025
 07:48:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250914110021.4103-1-aristo.chen@canonical.com>
 <20250914110021.4103-8-aristo.chen@canonical.com>
 <cf85516f-3985-4f53-bc61-6481446a5a19@kwiboo.se>
In-Reply-To: <cf85516f-3985-4f53-bc61-6481446a5a19@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 26 Sep 2025 08:48:11 -0600
X-Gm-Features: AS18NWCnxWDf1fyRVqdR8V87hv7ieBe5myR4aCDLTMDz8q9V6yAr1VA0dFvHfiU
Message-ID: <CAFLszThxPj4HdN0yONPW+xVgHOFK5E1maJS2fyLnnwi5WA57yQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] doc: binman: Add guidance for determining ELF load
 addresses
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Aristo Chen <jj251510319013@gmail.com>, trini@konsulko.com,
 alpernebiyasak@gmail.com, 
 al.kochet@gmail.com, paul.henrys_ext@softathome.com, bb@ti.com, 
 y.moog@phytec.de, w.egorov@phytec.de, francesco.dolcini@toradex.com, 
 ggiordano@phytec.com, n-francis@ti.com, afd@ti.com, d.schultz@phytec.de, 
 d-gole@ti.com, ravi@prevas.dk, carlos.lopezr4096@gmail.com, 
 quentin.schulz@cherry.de, alice.guo@nxp.com, 
 Aristo Chen <aristo.chen@canonical.com>, u-boot@lists.denx.de
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

On Wed, 24 Sept 2025 at 06:32, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi,
>
> On 9/14/2025 12:59 PM, Aristo Chen wrote:
> > Add documentation to help users understand how to determine where ELF
> > files will be loaded when using binman's 'fit,load' property. This
> > addresses the common confusion about how load addresses are determined
> > from ELF files.
> >
> > The documentation explains three methods:
> > 1. Using readelf to examine program headers
> > 2. Checking the linker script (.lds file)
> > 3. Using objdump to see section addresses
> >
> > Also includes a specific example from binman tests showing how
> > elf_sections.lds sets ATF load address to 0x00000010 and
> > elf_sections_tee.lds sets TEE load address to 0x00100010 to avoid
> > memory overlap conflicts.
> >
> > This helps users debug memory layout conflicts more efficiently when
> > working with FIT images containing multiple ELF components.
> >
> > Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> > ---
> >  tools/binman/entries.rst | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
> > index 12a39d070e4..f6a5465ca44 100644
> > --- a/tools/binman/entries.rst
> > +++ b/tools/binman/entries.rst
> > @@ -1050,6 +1050,24 @@ split-elf
> >          Generates a `load = <...>` property with the load address of the
> >          segment
> >
> > +        Note: The load address comes from the ELF file's program header or
> > +        linker script. To determine where an ELF file will be loaded, you can:
> > +
> > +        1. Use readelf to examine the program headers:
> > +           ``readelf -l your_elf_file.elf``
> > +           Look for the LOAD segments and their VirtAddr (Virtual Address)
> > +
> > +        2. Check the linker script (.lds file) used to build the ELF:
> > +           Look for the `. = <address>;` statements which set the location
> > +           counter and determine load addresses for different sections
> > +
> > +        3. Use objdump to see section addresses:
> > +           ``objdump -h your_elf_file.elf``
> > +
> > +        For example, in binman tests, elf_sections.lds sets ATF load address
> > +        to 0x00000010, while elf_sections_tee.lds sets TEE load address to
> > +        0x00100010 to avoid memory overlap conflicts.
>
> tools/binman/entries.rst should be generated from a "binman entry-docs"
> run as described in the documentation [1].
>
> Please update tools/binman/etype/fit.py or this will be lost next time
> someone updates the entries documentation.

With that fixed:

Reviewed-by: Simon Glass <sjg@chromium.org>


>
> [1] https://docs.u-boot.org/en/latest/develop/package/binman.html#entry-documentation
>
> Regards,
> Jonas
>
> > +
> >      fit,entry
> >          Generates a `entry = <...>` property with the entry address of the
> >          ELF. This is only produced for the first entry
>
