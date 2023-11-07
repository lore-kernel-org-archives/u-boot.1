Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF5EDC4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 13:11:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE03A86863;
	Tue,  7 Nov 2023 14:11:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g90Fxlrs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3585186BDF; Tue,  7 Nov 2023 14:11:25 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6228786689
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 14:11:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5401bab7525so9677148a12.2
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 05:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699362682; x=1699967482; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qm6N9dJ/FSSYVJxVKJ48BKdFLAoG420WN2Tv4cINOOM=;
 b=g90FxlrsSlxFEkn4GGB2fPhBq7lvquPPifnjEPVDjXXk1TlJIbWMs+Ghsp9jkzXMvO
 LKqdwpb95S3PwIWzd4Y5bvlgg9ak5ru71IaDHwE0kXICNP8HJS3TGJdUebMscJABDZEu
 X5STRbYzIF04BTh9Ecy71DVoVMQnMDv9xm8xM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699362682; x=1699967482;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qm6N9dJ/FSSYVJxVKJ48BKdFLAoG420WN2Tv4cINOOM=;
 b=ruI/0MkK5v3oy77xe5zrap4eGCow1WmY201GjExbbzkhI4bHiEceZdRlQR6tgW0oq6
 XHbKhWd7cOoZ9VDcDgv3sEqDezbmQ3m1oofMt9HskgaZNX+ehvjw1UL65bFAA1JNa75V
 46lrmpDsWcbeSUiRPbGpjSvnYN2HVfsQfEm6UsU2Lsij21BIlY++08XXr4nEAqWUaOSz
 f8z4fmuIx/35gedmNT/ZtFzM3VSafKhGwxUvWBeTbF2Wjf3WHM8/0zFNVDnFowkj1vfs
 IX0lDuzdSBMLjaWEz7IqyeWCOg+ORbA8cDx84nl+gdAP6kni69dUMdk96mKO5vqSkpEF
 i7hw==
X-Gm-Message-State: AOJu0YwDuB8K/bt8Kf9FIzprBrxb7ghuHZxn+L3iAJ/5sOvr+eh5FPsC
 3kw/dBUKLctYlvWeDC02ec5c14kaVQYIEG/8cJLDSw==
X-Google-Smtp-Source: AGHT+IFAt9ZvNXhAP24k2CMB3H8lR8ZLGxNoilWSXS9qb1pciEkcAkih+Vf7Ea6P/P+raouRDzcRzboDY2UxfiZqHd8=
X-Received: by 2002:a50:8e5d:0:b0:543:c50c:cacc with SMTP id
 29-20020a508e5d000000b00543c50ccaccmr13915784edx.41.1699362681654; Tue, 07
 Nov 2023 05:11:21 -0800 (PST)
MIME-Version: 1.0
References: <20231104194207.3370542-1-sjg@chromium.org>
 <20231104194207.3370542-3-sjg@chromium.org>
 <CAK7LNASVOdz2qdg5dwWN8HJwqJ1q_OgdeuapLhvmD6beavUqPg@mail.gmail.com>
In-Reply-To: <CAK7LNASVOdz2qdg5dwWN8HJwqJ1q_OgdeuapLhvmD6beavUqPg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 7 Nov 2023 06:11:04 -0700
Message-ID: <CAPnjgZ2yrk38kApMSiUOmsNM8M9cDa3gtH-ozJZzk=VjLh+PLQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] arm: boot: Use double quotes for image name
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, 
 Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Masahiro,

On Tue, 7 Nov 2023 at 03:13, Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Sat, Nov 4, 2023 at 9:42=E2=80=AFPM Simon Glass <sjg@chromium.org> wro=
te:
> >
> > The use of single quotes in the image name causes them to appear in
> > the image description when the uImage is created. Use double quotes, to
> > avoid this.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v2:
> > - Split double-quote change out into its own patch
> >
> >  scripts/Makefile.lib | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> > index 68d0134bdbf9..03e79e319293 100644
> > --- a/scripts/Makefile.lib
> > +++ b/scripts/Makefile.lib
> > @@ -487,7 +487,7 @@ UIMAGE_OPTS-y ?=3D
> >  UIMAGE_TYPE ?=3D kernel
> >  UIMAGE_LOADADDR ?=3D arch_must_set_this
> >  UIMAGE_ENTRYADDR ?=3D $(UIMAGE_LOADADDR)
> > -UIMAGE_NAME ?=3D 'Linux-$(KERNELRELEASE)'
> > +UIMAGE_NAME ?=3D "Linux-$(KERNELRELEASE)"
> >
> >  quiet_cmd_uimage =3D UIMAGE  $@
> >        cmd_uimage =3D $(BASH) $(MKIMAGE) -A $(UIMAGE_ARCH) -O linux \
> > --
> > 2.42.0.869.gea05f2083d-goog
> >
>
>
> NACK.
>
>
> This is because you are doing *WRONG* in 3/3.
>
> Look at your code closely.
>
> https://lore.kernel.org/linux-kbuild/20231104194207.3370542-4-sjg@chromiu=
m.org/T/#me2fb68151d6f4f330808406f9a711fffee149529
>
>
>
> In the mainline kernel, the quotation appears
> only in the definition of UIMAGE_NAME.
>
>
> masahiro@zoe:~/ref/linux(master)$ git grep UIMAGE_NAME
> scripts/Makefile.lib:UIMAGE_NAME ?=3D 'Linux-$(KERNELRELEASE)'
> scripts/Makefile.lib:                   -n $(UIMAGE_NAME) -d $< $@
>
>
> The single quotes are consumed by shell.
>
>
>
>
>
>
> This is mainline + your patch set.
>
> masahiro@zoe:~/ref/linux(simon-v2)$ git grep UIMAGE_NAME
> scripts/Makefile.lib:UIMAGE_NAME ?=3D "Linux-$(KERNELRELEASE)"
> scripts/Makefile.lib:                   -n "$(UIMAGE_NAME)" -d $< $@
> scripts/Makefile.lib:                   --name "$(UIMAGE_NAME)" \
>
>
> You quoted the definition of UIMAGE_NAME,
> and also variable references.
>
>
>
>
> See how it is expanded.
>
>
> --name "$(UIMAGE_NAME)"
>
>
>  =3D=3D>
>
>
> --name ""Linux-$(KERNELRELEASE)""
>
>
>  =3D=3D>
>
>
> --name Linux-$(KERNELRELEASE)
>
>
>
>
> You added double quotes in a row, just to cancel it.

Yes, I understand that. But without the quotes in -n "$(UIMAGE_NAME)"
then the name cannot contain spaces. So we do need some sort of
quoting, right?

It just seems strange to use single quotes in a Makefile variable. I
found it confusing.

I think you are saying you want to keep the single quotes in the var
declaration and drop the quotes from the cmd_fit rule. I am OK with
that, but I do think it is unusual not to quote something which might
have spaces. It may cause confusion for others, as it did for me?

Anyway, I'll send a new version with the quoting reverted.

Regards,
Simon
