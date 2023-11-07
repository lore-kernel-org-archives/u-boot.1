Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E271BC4167B
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 14:47:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 084D186F99;
	Tue,  7 Nov 2023 15:47:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AcEyzSkZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5013887076; Tue,  7 Nov 2023 15:47:56 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FA9186F44
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 15:47:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-53db360294fso9920262a12.3
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 06:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699368473; x=1699973273; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NnbeJZKiQOh5K3sI9hqRkc3lnO9o5y6c5lTMMzgYvsY=;
 b=AcEyzSkZMbjTvByQOEUPkVhvjF7/RWMUX51mA8oqbvp/X15AMwR7fzGXY91XEMnrfE
 jhLPP0c3aNYmwvYSW9WPIuGma7NpoH3hePGhbnPDr9SpeSn0lCbhOAe2Mq4yU1Db64aM
 HbMgdEZU0eVpbHrcNTGXsWRhvtjRULf9reQlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699368473; x=1699973273;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NnbeJZKiQOh5K3sI9hqRkc3lnO9o5y6c5lTMMzgYvsY=;
 b=SXmYptfDX2afw0/tAUO7FQVLcGQijYAcy/AyIbEunFaYLuq6T3zJo2gmBtGxfnGmCy
 uWa6eHC93Gt5vU+9ZLwrTxrGL9blPRYk10IbvH832khotEqdH6ftkenIWgz/uMvHtXkm
 L+NCngCholqhDnXBERuFIx/j20aQOmAoonfFuNosv5jdqNNJ9whY+1qlHwiJ9+mWbhoz
 O3b52r9iWxEErgadq9N5QEv/IwL6f42xe4bq4f7c4qMV0FL+EDAR3EhdfOdrbZUAL/Qx
 fczVJynCjLVA6AXP+wZ9Qf1nKl+ubLg6KQKFP4G0Umi5QV/1WS2KGcSuFQGlTVFeTkW3
 34/Q==
X-Gm-Message-State: AOJu0YwACjNDz6gvo8n+0uQZagJ9dC08niCqsOooVeXO6GuXgv8LqjQy
 Iom546PJbvJQUMZT0UQRUcHBmmJ9Yt+fPJMzLjeyqg==
X-Google-Smtp-Source: AGHT+IENfNsJXAisXICQ9hXfEFELw1udePjhEHmkIST9uDdPVV64sOD6sNTW7nyc6dFHLgikhceAKATe9uLSfW7Kz5c=
X-Received: by 2002:a50:8adc:0:b0:543:c578:f9d2 with SMTP id
 k28-20020a508adc000000b00543c578f9d2mr15339820edk.2.1699368473317; Tue, 07
 Nov 2023 06:47:53 -0800 (PST)
MIME-Version: 1.0
References: <20231104194207.3370542-1-sjg@chromium.org>
 <20231104194207.3370542-3-sjg@chromium.org>
 <CAK7LNASVOdz2qdg5dwWN8HJwqJ1q_OgdeuapLhvmD6beavUqPg@mail.gmail.com>
 <CAPnjgZ2yrk38kApMSiUOmsNM8M9cDa3gtH-ozJZzk=VjLh+PLQ@mail.gmail.com>
 <CAK7LNARzfMDBX9mhCaCV8QxpTic6A3JYOPBManJNh9Jas=-T9A@mail.gmail.com>
In-Reply-To: <CAK7LNARzfMDBX9mhCaCV8QxpTic6A3JYOPBManJNh9Jas=-T9A@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 7 Nov 2023 07:47:42 -0700
Message-ID: <CAPnjgZ27bsKOLwsK7nTw=3OEvdY4Yz5nZGsMNCmEzvsQPafjqw@mail.gmail.com>
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

On Tue, 7 Nov 2023 at 07:13, Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Hi Simon,
>
>
> On Tue, Nov 7, 2023 at 3:11=E2=80=AFPM Simon Glass <sjg@chromium.org> wro=
te:
> >
> > Hi Masahiro,
> >
> > On Tue, 7 Nov 2023 at 03:13, Masahiro Yamada <masahiroy@kernel.org> wro=
te:
> > >
> > > On Sat, Nov 4, 2023 at 9:42=E2=80=AFPM Simon Glass <sjg@chromium.org>=
 wrote:
> > > >
> > > > The use of single quotes in the image name causes them to appear in
> > > > the image description when the uImage is created. Use double quotes=
, to
> > > > avoid this.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > > Changes in v2:
> > > > - Split double-quote change out into its own patch
> > > >
> > > >  scripts/Makefile.lib | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> > > > index 68d0134bdbf9..03e79e319293 100644
> > > > --- a/scripts/Makefile.lib
> > > > +++ b/scripts/Makefile.lib
> > > > @@ -487,7 +487,7 @@ UIMAGE_OPTS-y ?=3D
> > > >  UIMAGE_TYPE ?=3D kernel
> > > >  UIMAGE_LOADADDR ?=3D arch_must_set_this
> > > >  UIMAGE_ENTRYADDR ?=3D $(UIMAGE_LOADADDR)
> > > > -UIMAGE_NAME ?=3D 'Linux-$(KERNELRELEASE)'
> > > > +UIMAGE_NAME ?=3D "Linux-$(KERNELRELEASE)"
> > > >
> > > >  quiet_cmd_uimage =3D UIMAGE  $@
> > > >        cmd_uimage =3D $(BASH) $(MKIMAGE) -A $(UIMAGE_ARCH) -O linux=
 \
> > > > --
> > > > 2.42.0.869.gea05f2083d-goog
> > > >
> > >
> > >
> > > NACK.
> > >
> > >
> > > This is because you are doing *WRONG* in 3/3.
> > >
> > > Look at your code closely.
> > >
> > > https://lore.kernel.org/linux-kbuild/20231104194207.3370542-4-sjg@chr=
omium.org/T/#me2fb68151d6f4f330808406f9a711fffee149529
> > >
> > >
> > >
> > > In the mainline kernel, the quotation appears
> > > only in the definition of UIMAGE_NAME.
> > >
> > >
> > > masahiro@zoe:~/ref/linux(master)$ git grep UIMAGE_NAME
> > > scripts/Makefile.lib:UIMAGE_NAME ?=3D 'Linux-$(KERNELRELEASE)'
> > > scripts/Makefile.lib:                   -n $(UIMAGE_NAME) -d $< $@
> > >
> > >
> > > The single quotes are consumed by shell.
> > >
> > >
> > >
> > >
> > >
> > >
> > > This is mainline + your patch set.
> > >
> > > masahiro@zoe:~/ref/linux(simon-v2)$ git grep UIMAGE_NAME
> > > scripts/Makefile.lib:UIMAGE_NAME ?=3D "Linux-$(KERNELRELEASE)"
> > > scripts/Makefile.lib:                   -n "$(UIMAGE_NAME)" -d $< $@
> > > scripts/Makefile.lib:                   --name "$(UIMAGE_NAME)" \
> > >
> > >
> > > You quoted the definition of UIMAGE_NAME,
> > > and also variable references.
> > >
> > >
> > >
> > >
> > > See how it is expanded.
> > >
> > >
> > > --name "$(UIMAGE_NAME)"
> > >
> > >
> > >  =3D=3D>
> > >
> > >
> > > --name ""Linux-$(KERNELRELEASE)""
> > >
> > >
> > >  =3D=3D>
> > >
> > >
> > > --name Linux-$(KERNELRELEASE)
> > >
> > >
> > >
> > >
> > > You added double quotes in a row, just to cancel it.
> >
> > Yes, I understand that. But without the quotes in -n "$(UIMAGE_NAME)"
> > then the name cannot contain spaces. So we do need some sort of
> > quoting, right?
>
>
> Yes.
>
> If you move the quoting to the variable reference,
> it is acceptable because there is a good reason to do so.
>
>
>
> UIMAGE_NAME ?=3D Linux-$(KERNELRELEASE)
>
>
>             ...
>              -n '$(UIMAGE_NAME)' -d $< $@
>
>
> This is the correct change.

OK.

>
>
>
> >
> > It just seems strange to use single quotes in a Makefile variable. I
> > found it confusing.
>
>
> Right. Why don't you remove it, then?
>
>
> For clarification, there is no concept of quoting in GNU Make.
>
> The single quote character ' and the double quote character " are
> just normal characters for Make.
>
> GNU Make handles them just like alphabets and numbers.
>
> GNU Make just replaces $(UIMAGE_NAME)
> with 'Linux-$(KERNELRELEASE)' verbatim.
>
>
> It is the _shell_ that understands the quoting.
>
> Just in case here is the spec for
> "2.2.2 Single-Quotes" vs "2.2.3 Double-Quotes"
>
> https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html
>
>
> Shell supports both single-quoting and double-quoting
> for good reasons.
>
> There is no good or bad because both of them are meaningful.

Yes...I suppose I knew that Makefiles are completely literal, but
thanks for the pointers. I tend to use double quotes by default and
single quotes only when I have to...but it doesn't really matter so
long as it is consistent.

Anyway, moving the single quotes away from the var removes the
confusion I had at the start of all of this.

>
>
>
>
>
>
> >
> > I think you are saying you want to keep the single quotes in the var
> > declaration and drop the quotes from the cmd_fit rule. I am OK with
> > that, but I do think it is unusual not to quote something which might
> > have spaces. It may cause confusion for others, as it did for me?
> >
> > Anyway, I'll send a new version with the quoting reverted.
> >
>
>
> Please move the single quotes as I suggested above.
>
> The reason is because UIMAGE_NAME can be passed-in
> by a user and it can contain whitespaces.

OK, done in v4.

Regards,
Simon
