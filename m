Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECFFAC4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 14:13:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13837871E4;
	Tue,  7 Nov 2023 15:13:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FSkxVw21";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EC22871E4; Tue,  7 Nov 2023 15:13:12 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEFF8870C5
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 15:13:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahiroy@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 0EB74B816FF
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 14:13:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A4DC433C8
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 14:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1699366388;
 bh=3uu3xjsMv/HWdiZjhGCNJwq0vWIfTCG/6H7qC0Pb8Ig=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=FSkxVw21Z7If0wVbWvxaBgMv+hhbnv0GMpRhISsND3QGB2NXoAgELbfWiWgrlv88u
 JI4Q+pq0+WvPlPUn3GaAPLRRTu6dRuDhBdHsih+gihktGwjDHhth4mUAN+/i42vShP
 /LYTY8XjZreYIh56Tun6aEVex6spP6yg0APDv16tJpwf+J9an+WEAUmNeD6NljuFjT
 gPUjlVXvxL45UFpGYuAYLv5HwXcbnckqED7x44nNyzyK+JcfwATBmdfcEYyFoBY3wX
 wW4gbJvBPQ9nJnONPMNQguLdJ5tCOjET0rCDOeY5o0APQj+XQZVDNWZ8gxANn494dx
 aGg+tDaYPoNXA==
Received: by mail-oa1-f51.google.com with SMTP id
 586e51a60fabf-1dd5b98d9aeso2817441fac.0
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 06:13:08 -0800 (PST)
X-Gm-Message-State: AOJu0YzGwNPJ+0tfApswKLnIlxHntl4Tl4wTnosmlcqPwrBmaiMjj1yl
 L6zAdt3Y/OWybgaFztEl0RyY5sbABtzVLCfBa10=
X-Google-Smtp-Source: AGHT+IFdb80DVsZYYRJCaxdJVKIa3zCvpWN1Lu6hUl5fhI39v7rD9Qg+0szgCCaj0ejCvw3Q2Tsvs3YRMqFaGfuGGWU=
X-Received: by 2002:a05:6870:1281:b0:1e9:fb1e:870a with SMTP id
 1-20020a056870128100b001e9fb1e870amr1317914oal.3.1699366387706; Tue, 07 Nov
 2023 06:13:07 -0800 (PST)
MIME-Version: 1.0
References: <20231104194207.3370542-1-sjg@chromium.org>
 <20231104194207.3370542-3-sjg@chromium.org>
 <CAK7LNASVOdz2qdg5dwWN8HJwqJ1q_OgdeuapLhvmD6beavUqPg@mail.gmail.com>
 <CAPnjgZ2yrk38kApMSiUOmsNM8M9cDa3gtH-ozJZzk=VjLh+PLQ@mail.gmail.com>
In-Reply-To: <CAPnjgZ2yrk38kApMSiUOmsNM8M9cDa3gtH-ozJZzk=VjLh+PLQ@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 7 Nov 2023 16:12:30 +0200
X-Gmail-Original-Message-ID: <CAK7LNARzfMDBX9mhCaCV8QxpTic6A3JYOPBManJNh9Jas=-T9A@mail.gmail.com>
Message-ID: <CAK7LNARzfMDBX9mhCaCV8QxpTic6A3JYOPBManJNh9Jas=-T9A@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] arm: boot: Use double quotes for image name
To: Simon Glass <sjg@chromium.org>
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

Hi Simon,


On Tue, Nov 7, 2023 at 3:11=E2=80=AFPM Simon Glass <sjg@chromium.org> wrote=
:
>
> Hi Masahiro,
>
> On Tue, 7 Nov 2023 at 03:13, Masahiro Yamada <masahiroy@kernel.org> wrote=
:
> >
> > On Sat, Nov 4, 2023 at 9:42=E2=80=AFPM Simon Glass <sjg@chromium.org> w=
rote:
> > >
> > > The use of single quotes in the image name causes them to appear in
> > > the image description when the uImage is created. Use double quotes, =
to
> > > avoid this.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > > Changes in v2:
> > > - Split double-quote change out into its own patch
> > >
> > >  scripts/Makefile.lib | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> > > index 68d0134bdbf9..03e79e319293 100644
> > > --- a/scripts/Makefile.lib
> > > +++ b/scripts/Makefile.lib
> > > @@ -487,7 +487,7 @@ UIMAGE_OPTS-y ?=3D
> > >  UIMAGE_TYPE ?=3D kernel
> > >  UIMAGE_LOADADDR ?=3D arch_must_set_this
> > >  UIMAGE_ENTRYADDR ?=3D $(UIMAGE_LOADADDR)
> > > -UIMAGE_NAME ?=3D 'Linux-$(KERNELRELEASE)'
> > > +UIMAGE_NAME ?=3D "Linux-$(KERNELRELEASE)"
> > >
> > >  quiet_cmd_uimage =3D UIMAGE  $@
> > >        cmd_uimage =3D $(BASH) $(MKIMAGE) -A $(UIMAGE_ARCH) -O linux \
> > > --
> > > 2.42.0.869.gea05f2083d-goog
> > >
> >
> >
> > NACK.
> >
> >
> > This is because you are doing *WRONG* in 3/3.
> >
> > Look at your code closely.
> >
> > https://lore.kernel.org/linux-kbuild/20231104194207.3370542-4-sjg@chrom=
ium.org/T/#me2fb68151d6f4f330808406f9a711fffee149529
> >
> >
> >
> > In the mainline kernel, the quotation appears
> > only in the definition of UIMAGE_NAME.
> >
> >
> > masahiro@zoe:~/ref/linux(master)$ git grep UIMAGE_NAME
> > scripts/Makefile.lib:UIMAGE_NAME ?=3D 'Linux-$(KERNELRELEASE)'
> > scripts/Makefile.lib:                   -n $(UIMAGE_NAME) -d $< $@
> >
> >
> > The single quotes are consumed by shell.
> >
> >
> >
> >
> >
> >
> > This is mainline + your patch set.
> >
> > masahiro@zoe:~/ref/linux(simon-v2)$ git grep UIMAGE_NAME
> > scripts/Makefile.lib:UIMAGE_NAME ?=3D "Linux-$(KERNELRELEASE)"
> > scripts/Makefile.lib:                   -n "$(UIMAGE_NAME)" -d $< $@
> > scripts/Makefile.lib:                   --name "$(UIMAGE_NAME)" \
> >
> >
> > You quoted the definition of UIMAGE_NAME,
> > and also variable references.
> >
> >
> >
> >
> > See how it is expanded.
> >
> >
> > --name "$(UIMAGE_NAME)"
> >
> >
> >  =3D=3D>
> >
> >
> > --name ""Linux-$(KERNELRELEASE)""
> >
> >
> >  =3D=3D>
> >
> >
> > --name Linux-$(KERNELRELEASE)
> >
> >
> >
> >
> > You added double quotes in a row, just to cancel it.
>
> Yes, I understand that. But without the quotes in -n "$(UIMAGE_NAME)"
> then the name cannot contain spaces. So we do need some sort of
> quoting, right?


Yes.

If you move the quoting to the variable reference,
it is acceptable because there is a good reason to do so.



UIMAGE_NAME ?=3D Linux-$(KERNELRELEASE)


            ...
             -n '$(UIMAGE_NAME)' -d $< $@


This is the correct change.



>
> It just seems strange to use single quotes in a Makefile variable. I
> found it confusing.


Right. Why don't you remove it, then?


For clarification, there is no concept of quoting in GNU Make.

The single quote character ' and the double quote character " are
just normal characters for Make.

GNU Make handles them just like alphabets and numbers.

GNU Make just replaces $(UIMAGE_NAME)
with 'Linux-$(KERNELRELEASE)' verbatim.


It is the _shell_ that understands the quoting.

Just in case here is the spec for
"2.2.2 Single-Quotes" vs "2.2.3 Double-Quotes"

https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html


Shell supports both single-quoting and double-quoting
for good reasons.

There is no good or bad because both of them are meaningful.






>
> I think you are saying you want to keep the single quotes in the var
> declaration and drop the quotes from the cmd_fit rule. I am OK with
> that, but I do think it is unusual not to quote something which might
> have spaces. It may cause confusion for others, as it did for me?
>
> Anyway, I'll send a new version with the quoting reverted.
>


Please move the single quotes as I suggested above.

The reason is because UIMAGE_NAME can be passed-in
by a user and it can contain whitespaces.





> Regards,
> Simon



--=20
Best Regards
Masahiro Yamada
