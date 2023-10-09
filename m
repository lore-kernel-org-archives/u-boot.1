Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C92F6E95A91
	for <u-boot@archiver.kernel.org>; Mon,  9 Oct 2023 07:47:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4489B86ACA;
	Mon,  9 Oct 2023 09:47:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YnAfD/cl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60D4186AB9; Mon,  9 Oct 2023 09:47:01 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DA9C869BD
 for <u-boot@lists.denx.de>; Mon,  9 Oct 2023 09:46:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-538e8eca9c1so7294933a12.3
 for <u-boot@lists.denx.de>; Mon, 09 Oct 2023 00:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696837619; x=1697442419; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=U7xg5X+aiDUj0t72/3deUgUrd/fzOr0yMB37L4LZj5o=;
 b=YnAfD/cl1x4C10VgB6xPC82b439yOobEBpvKszbPF7M4epFGioSxBtLynpSd1BQnqC
 wXKbP3vwyKtlhy7zZsTIqYgvCo62+sRBKT3LXmf01IOUF95gJNhfwf4GEkrtE0p39ey6
 3fIgWPiPiXe8nrkzHeTh1u0UzI9VMK/o7IkSd3f86/4AztRo4T8llmBPPdm1JTcgtSG4
 XQX9ks/iIJjQYvL4IdTEbeqoBNu98TAtqEs4f2h2La3fdy0Rju/6dX0VSbGiPDYUGJLF
 GPocetFXz8t7PNm8V98I15Bt7zFKWNszkvKSuUxA3xhiMQfChnAlCt2XK7pmu1fS1Mq0
 uEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696837619; x=1697442419;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U7xg5X+aiDUj0t72/3deUgUrd/fzOr0yMB37L4LZj5o=;
 b=Fvkb5QoEIfOo2h8pG3OKsLie0vb7ukFqOv/kHtw2cNu+uvZlr/Byib3cBWHAUesAb5
 IrKQrdbl29yyQYdoVkaBfp6jj4ANcSafqGPBn8iflJ9FynbAwly68PVakZnCMxXJxsYv
 M1VXjxbEsSP/mwJgqvVaLEW91MHvtTeF0jnjZWzYouET2zVp7zN8T2bkL8q7d/XZTly1
 3v3HW6XQfBbD/eV1/gsOfJ+eKFvy/oU+39lAp9UHEoaxDFmMwBzR7LNs5KprvBpcraP1
 TQqO263gr0d8CBAW7l8GgyFQ2xVcYB+jVau7El9o9XHWsS4y/1wqK4wSS6v1h4PXhnnz
 +bHw==
X-Gm-Message-State: AOJu0YzJDCj/HyMgo8szPnN5tzqh4VMkCcKe+psLKxdZ874rgfJMapG9
 uBNp5kJDzJi5SHS0o26jiWkgWCYpWNPTRzRIGynHxQ==
X-Google-Smtp-Source: AGHT+IG7Xng024+5cgXU7Lvw2rriL2lI42dJEMs6+ZeSBtXN7l/DdlqRPXUlo/Hqar37c3pvO9MofcaEUxRqtq9UTwM=
X-Received: by 2002:aa7:d5c8:0:b0:534:78a6:36cb with SMTP id
 d8-20020aa7d5c8000000b0053478a636cbmr12746409eds.39.1696837619044; Mon, 09
 Oct 2023 00:46:59 -0700 (PDT)
MIME-Version: 1.0
References: <20231004112722.416877-1-sughosh.ganu@linaro.org>
 <20231004112722.416877-5-sughosh.ganu@linaro.org>
 <CAPnjgZ2zhqStA-1viaTgTHvkMWNUg5TYAraWP0UxAi28sr0EmA@mail.gmail.com>
In-Reply-To: <CAPnjgZ2zhqStA-1viaTgTHvkMWNUg5TYAraWP0UxAi28sr0EmA@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 9 Oct 2023 13:16:48 +0530
Message-ID: <CADg8p972NEVQgiQALDFWR7ct5-6Sh3BFgvRGJhSf8M0zKE_i=w@mail.gmail.com>
Subject: Re: [PATCH 4/5] btool: mkeficapsule: Add support for EFI empty
 capsule generation
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>, 
 Tom Rini <trini@konsulko.com>
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

hi Simon,

On Sun, 8 Oct 2023 at 04:42, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sugosh,
>
> On Wed, 4 Oct 2023 at 05:27, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > Add a method to the mkeficapsule bintool to generate empty
> > capsules. These are capsules needed for the FWU A/B update feature.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> >  tools/binman/btool/mkeficapsule.py | 29 +++++++++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> >
> > diff --git a/tools/binman/btool/mkeficapsule.py b/tools/binman/btool/mkeficapsule.py
> > index 61179747ff..89c0adfc9f 100644
> > --- a/tools/binman/btool/mkeficapsule.py
> > +++ b/tools/binman/btool/mkeficapsule.py
> > @@ -80,6 +80,35 @@ class Bintoolmkeficapsule(bintool.Bintool):
> >
> >          return self.run_cmd(*args)
> >
> > +    def generate_empty_capsule(self, accept, revert, image_guid,
>
> Instead of two separate bools, how about an 'operation' param, a
> string which is either accept or revert? Or perhaps just have 'accept'
>  and pass True or False?

Okay incorporate this and the other two review comments on this patch. Thanks.

-sughosh

>
> > +                               output_fname):
> > +        """Generate empty capsules for FWU A/B updates
> > +
> > +        Args:
> > +            accept (int): Generate an accept capsule
> > +            revert (int): Generate a revert capsule
> > +            image_guid (str): GUID used for identifying the image
> > +            output_fname (str): Path to the output capsule file
> > +
> > +        Returns:
> > +            str: Tool output
> > +        """
> > +        if accept:
> > +            args = [
> > +                f'--guid={image_guid}',
> > +                '--fw-accept'
> > +            ]
> > +        elif revert:
> > +            args = [
> > +                '--fw-revert'
> > +            ]
>
> That can be on none line
>
> > +
> > +        args += [
> > +            output_fname
> > +        ]
>
> Same here
>
> > +
> > +        return self.run_cmd(*args)
> > +
> >      def fetch(self, method):
> >          """Fetch handler for mkeficapsule
> >
> > --
> > 2.34.1
> >
>
> Regards,
> Simon
