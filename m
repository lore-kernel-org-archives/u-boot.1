Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D7EEE14A9
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 22:04:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEC19869B6;
	Thu,  7 Sep 2023 00:04:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mf6Yzijy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48963869D1; Thu,  7 Sep 2023 00:04:24 +0200 (CEST)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 656BA86177
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 00:04:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-59205f26e47so3314967b3.2
 for <u-boot@lists.denx.de>; Wed, 06 Sep 2023 15:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694037860; x=1694642660; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2JR1mdMyJtc9NkzrlrDfQf6dM0lIAfvx7V7X+6hJ73I=;
 b=mf6YzijyA2FviuStBvElFKGzihmwOTp85zPpJoJ4ulRVt15Bjy/sI2gD/jkK4W88m7
 OzHAs7jIcow6OBQKTG3zBtknkc0wEYZAicLwHNz+gbq3jTB1qE9IZ/jHYBmz9XMOeysl
 1QKaQzEaiKl0XjIfiEJeiOEPBh6XrQR1iKPXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694037860; x=1694642660;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2JR1mdMyJtc9NkzrlrDfQf6dM0lIAfvx7V7X+6hJ73I=;
 b=V+PkLUYaNB1cNApm6IBwAGze+fz2ciUWKf/nDI8MGKL1nzaRDV1wweSQyaQsSGN9kw
 6VQ4m5ppjaKKAmF6aKSlu3JjUp9orKPm0YMeKo9NdUr12n9AbOlTZCcy6u5FBabCRi+p
 jtPHCqLvvq1OjOebVK3hBjocPbiLbXLe3GiUkYCaj4a4vQw28lVP76b6m1GPqWJfF8gX
 8wpcV2xP481UFxoZ7L51Xf5bunv+w4fAJTkHG7qXxhdDv0jgERsajA6jl6BqgoP5g+Yz
 rFgprJytnSXaCMmH35ra5shjDRwTlaDuDHyjNk/gdHYgGXRHLSXzDZj1zq/IfH8NMmK2
 kbOg==
X-Gm-Message-State: AOJu0YyI3YzDJL5kX0REQMZBV0j+MNd///t36oRwqEK2AVkYl7w55EOH
 obR+8SuZrIT29z8YROVodEBIpw==
X-Google-Smtp-Source: AGHT+IHGB+7HwqlGat0wFDmF0y3lUdrxWWJTLFKKKSnn16lr6y4URbD3ZpgdFCKBXNrTB1vDzJyVCg==
X-Received: by 2002:a0d:c404:0:b0:594:e357:a1f8 with SMTP id
 g4-20020a0dc404000000b00594e357a1f8mr19549295ywd.24.1694037860098; 
 Wed, 06 Sep 2023 15:04:20 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-27f1-c90c-e8ad-e559.res6.spectrum.com.
 [2603:6081:7b00:6400:27f1:c90c:e8ad:e559])
 by smtp.gmail.com with ESMTPSA id
 i23-20020a816d17000000b00595394ba941sm4004207ywc.81.2023.09.06.15.04.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Sep 2023 15:04:19 -0700 (PDT)
Date: Wed, 6 Sep 2023 18:04:16 -0400
From: Tom Rini <trini@konsulko.com>
To: Rob Herring <robh@kernel.org>
Cc: Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [RFC PATCH 0/5] Allow for removal of DT nodes and properties
Message-ID: <20230906220416.GK305624@bill-the-cat>
References: <20230826090633.239342-1-sughosh.ganu@linaro.org>
 <CAPnjgZ3HVJ9+-PjmHSKwQRgCMkcNPWAcfMkk5SMMgiHAcY0SsQ@mail.gmail.com>
 <CALeDE9MMiA9HVfbeOV3tGqfAAC9oYf9qvizBW0T=hLmqcYD=qw@mail.gmail.com>
 <CAPnjgZ1pgvxhntJvkuAsxKXUVxcWACNTpuDqgonFCrOLr=934Q@mail.gmail.com>
 <CALeDE9ODEwV0Z9APwb1N8QNZFQSB1dkMTMHPW2p2xTLiUZjQ1A@mail.gmail.com>
 <CAPnjgZ1FiqjjxjL+Ve-s5WEafksOZsSP3XyW4xYdjyP-U_TZzQ@mail.gmail.com>
 <20230906142139.GA1236014-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uPpiEA6Y+yjq3KOJ"
Content-Disposition: inline
In-Reply-To: <20230906142139.GA1236014-robh@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
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


--uPpiEA6Y+yjq3KOJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 06, 2023 at 09:21:39AM -0500, Rob Herring wrote:
> On Mon, Aug 28, 2023 at 04:09:29PM -0600, Simon Glass wrote:
> > Hi Peter,
> >=20
> > On Mon, 28 Aug 2023 at 14:29, Peter Robinson <pbrobinson@gmail.com> wro=
te:
> > >
> > > On Mon, Aug 28, 2023 at 6:54=E2=80=AFPM Simon Glass <sjg@chromium.org=
> wrote:
> > > >
> > > > Hi Peter,
> > > >
> > > > On Mon, 28 Aug 2023 at 10:37, Peter Robinson <pbrobinson@gmail.com>=
 wrote:
> > > > >
> > > > > On Mon, Aug 28, 2023 at 5:20=E2=80=AFPM Simon Glass <sjg@chromium=
=2Eorg> wrote:
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > On Sat, 26 Aug 2023 at 03:07, Sughosh Ganu <sughosh.ganu@linaro=
=2Eorg> wrote:
> > > > > > >
> > > > > > >
> > > > > > > Provide a way for removing certain devicetree nodes and/or pr=
operties
> > > > > > > from the devicetree. This is needed to purge certain nodes and
> > > > > > > properties which may be relevant only in U-Boot. Such nodes a=
nd
> > > > > > > properties are then removed from the devicetree before it is =
passed to
> > > > > > > the kernel. This ensures that the devicetree passed to the OS=
 does not
> > > > > > > contain any non-compliant nodes and properties.
> > > > > > >
> > > > > > > The removal of the nodes and properties is being done through=
 an
> > > > > > > EVT_FT_FIXUP handler. I am not sure if the removal code needs=
 to be
> > > > > > > behind any Kconfig symbol.
> > > > > > >
> > > > > > > I have only build tested this on sandbox, and tested on qemu =
arm64
> > > > > > > virt platform. This being a RFC, I have not put this through =
a CI run.
> > > > > > >
> > > > > > > Sughosh Ganu (5):
> > > > > > >   dt: Provide a way to remove non-compliant nodes and propert=
ies
> > > > > > >   fwu: Add the fwu-mdata node for removal from devicetree
> > > > > > >   capsule: Add the capsule-key property for removal from devi=
cetree
> > > > > > >   bootefi: Call the EVT_FT_FIXUP event handler
> > > > > > >   doc: Add a document for non-compliant DT node/property remo=
val
> > > > > > >
> > > > > > >  cmd/bootefi.c                                 | 18 +++++
> > > > > > >  .../devicetree/dt_non_compliant_purge.rst     | 64 +++++++++=
+++++++
> > > > > > >  drivers/fwu-mdata/fwu-mdata-uclass.c          |  5 ++
> > > > > > >  include/dt-structs.h                          | 11 +++
> > > > > > >  lib/Makefile                                  |  1 +
> > > > > > >  lib/dt_purge.c                                | 73 +++++++++=
++++++++++
> > > > > > >  lib/efi_loader/efi_capsule.c                  |  7 ++
> > > > > > >  7 files changed, 179 insertions(+)
> > > > > > >  create mode 100644 doc/develop/devicetree/dt_non_compliant_p=
urge.rst
> > > > > > >  create mode 100644 lib/dt_purge.c
> > > > > >
> > > > > > What is the point of removing them? Instead, we should make sur=
e that
> > > > > > we upstream the bindings and encourage SoC vendors to sync them=
=2E If we
> > > > > > remove them, no one will bother and U-Boot just becomes a dumpi=
ng
> > > > > > ground.
> > > > >
> > > > > Well things like the binman entries in DT are U-Boot specific and=
 not
> > > > > useful for HW related descriptions or for Linux or another OS bei=
ng
> > > > > able to deal with HW so arguably we're already a dumping ground to
> > > > > some degree for not defining hardware.
> > > >
> > > > I have started the process to upstream the binman bindings.
> > >
> > > I don't think they should be in DT at all, they don't describe
> > > anything to do with hardware, or generally even the runtime of a
> > > device, they don't even describe the boot/runtime state of the
> > > firmware, they describe build time, so I don't see what that has to do
> > > with device tree? Can you explain that? To me those sorts of things
> > > should live in a build time style config file.
>=20
> For the record, I tend to agree.
>=20
> > I beg to differ. Devicetree is more than just hardware and always has
> > been. See, for example the /chosen and /options nodes.
>=20
> There are exceptions...
>=20
> > We need run-time configuration here, since we cannot know at build
> > time what we will be asked to do by a previous firmware phase.
>=20
> Really, I don't want to have to care about the binman binding. If it is=
=20
> u-boot specific, then it should stay in u-boot. I took /options/u-boot/,=
=20
> but now I'm starting to have second thoughts on that being in dtschema=20
> if it is going to be continually and frequently extended. Validating it=
=20
> in SR does little. If a vendor is abusing /options/u-boot/ in some way=20
> they could just as easily remove the node in their u-boot fork to pass.=
=20
> SR is certainly not going to require the node be there.

It's going to continue to be a "fun" tight-rope to walk. No one wants an
easy way for vendors to cheat the requirements which is why in some
other parts of this thread (you may or may not have been on, I don't
recall, sorry) I've been trying to make it clear that the removal
mechanism should be both a slight pain to add to, and at least wrt
upstream, clear that effort was made to upstream things.  Cheaters are
going to cheat and they could just chain a bunch of "fdt rm" together to
do it today.

--=20
Tom

--uPpiEA6Y+yjq3KOJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmT492AACgkQFHw5/5Y0
tyydswv8CTiF9VcocxBfI3iIALhhkAAEavw+Nk+5bR8lqYNhtnthtg4+YLPOayt5
1/5yrro76w/MySY7Hb5WW/wtKPonMV91hBVMGRl3vV45zUkTBu/YcP7yqXsQp6CG
gM4SdZ0ExMVjcbcEvemLYHf+btyR7mB9OiQYoFWVWj8Aef6MHYaZSigFbvsTfiTD
IBodRdmdO0g1nMg2bqwU8xeVjbY22cet+j3D5u6MaC17J+yBBpXQcbmH8g54GFZx
SbCRl3shvbrue/bs4TCi6OIeRWwDk9VAxvDO5aXmbQqRtLaBg200U/7DBACw7lOf
cOz0lEQoL88fbUmfIAVON6bfzVYeMHZbAYfPR31NHqvW05jr5IfJfnVpW7osHjkW
Y7gYyBI5+vzoOFhUbeG2biquFGJkVi/17ordnqZAQWT6pcVOQLQGdVw/5fc0vFwL
cbcUvzDVYehHW/7b9o1sYIBX8G0HDMK6MTXWjyw0g9s8gm/O2qW2cH2Ui5yfqha1
eE6EnEap
=lHsw
-----END PGP SIGNATURE-----

--uPpiEA6Y+yjq3KOJ--
