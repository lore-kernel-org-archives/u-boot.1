Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A9DEE8011
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 14:43:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3E9286A7B;
	Fri,  8 Sep 2023 16:43:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SFaIPmjd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B79ED86560; Fri,  8 Sep 2023 16:43:46 +0200 (CEST)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDEE686560
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 16:43:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-5922b96c5fcso20427797b3.0
 for <u-boot@lists.denx.de>; Fri, 08 Sep 2023 07:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694184222; x=1694789022; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Y0lab1jbFMsHKpeQmwg+brG28M2E3AjGuOGh8bp28dg=;
 b=SFaIPmjd/wRHsrgMsdTLeF4bCQp+hdkZmJ7wi0VghZOlPHAyZsOjZ2hsFRXtwpp8/N
 CcPWfB2vXmTvMsnsL/TklReOlMG6MA6pDmHNAYe+eUODfNjLIhdnXPgnQOIHCBbnX0W3
 kbZ1V71maLHiqkG2XhtYXK1wCFLmXkgQUytrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694184222; x=1694789022;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y0lab1jbFMsHKpeQmwg+brG28M2E3AjGuOGh8bp28dg=;
 b=n95DkkAggacqh+9SpV0rEli1ndMD16y5tQkc/Xx8LCWucPpQZgPX4xxjM42PBtWYQY
 hNB+quQnJh70T6DUqYeukQrv8vLtsS+4J/pZzZSmjxVk20zwy95CfbJeuK1252y9+8jc
 jvzOl7ePOAgVwnCaBJIdK/CBC2XoqGjV3wwSr5g1mvzMjq739oxrUhmpoAOiwi0nXvzv
 F1K2esqKiIjfcZkqIQmIiRWLxGUFGh6yWIbi8GVxTu/lu3De2nfej5IzUIFyLzgtYANu
 a6PttIgLmDuykxa/yc0sVa5L1Dq/uMFjGPXjxEbE0zSu4BqKjLE54J6gGLaoW3bU2eKc
 6osA==
X-Gm-Message-State: AOJu0Yyw0C1n7zyXxlRk7omyCfysA0GY40RMUKB4Rv8afHwe1av8wRaf
 n9oedG8n4I2fjI6YuHgl7wUatg==
X-Google-Smtp-Source: AGHT+IHxs3sS1LKxY6UxXZugIynBveeC2TRMYqv08MaBgpxBW2asmKgATm68+4z5A3jqL7zZBzeaMQ==
X-Received: by 2002:a81:4808:0:b0:583:7b49:57ac with SMTP id
 v8-20020a814808000000b005837b4957acmr2981047ywa.25.1694184222612; 
 Fri, 08 Sep 2023 07:43:42 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-031e-83f0-a4af-2e7d.res6.spectrum.com.
 [2603:6081:7b00:6400:31e:83f0:a4af:2e7d])
 by smtp.gmail.com with ESMTPSA id
 t128-20020a818386000000b0059590440338sm455563ywf.43.2023.09.08.07.43.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 07:43:41 -0700 (PDT)
Date: Fri, 8 Sep 2023 10:43:40 -0400
From: Tom Rini <trini@konsulko.com>
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Rob Herring <robh@kernel.org>, Peter Robinson <pbrobinson@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [RFC PATCH 0/5] Allow for removal of DT nodes and properties
Message-ID: <20230908144340.GF305624@bill-the-cat>
References: <20230826090633.239342-1-sughosh.ganu@linaro.org>
 <CAPnjgZ3HVJ9+-PjmHSKwQRgCMkcNPWAcfMkk5SMMgiHAcY0SsQ@mail.gmail.com>
 <CALeDE9MMiA9HVfbeOV3tGqfAAC9oYf9qvizBW0T=hLmqcYD=qw@mail.gmail.com>
 <CAPnjgZ1pgvxhntJvkuAsxKXUVxcWACNTpuDqgonFCrOLr=934Q@mail.gmail.com>
 <CALeDE9ODEwV0Z9APwb1N8QNZFQSB1dkMTMHPW2p2xTLiUZjQ1A@mail.gmail.com>
 <CAPnjgZ1FiqjjxjL+Ve-s5WEafksOZsSP3XyW4xYdjyP-U_TZzQ@mail.gmail.com>
 <20230906142139.GA1236014-robh@kernel.org> <ZPldgbS8mu+5DG7Q@hera>
 <CAPnjgZ0kcOZp65d_-wwYyjbTwC-aDamvGU50aa34o2PeZjZk6Q@mail.gmail.com>
 <CABb+yY0VJDu+L2C10E1O-uAU-p0OwuTq6XVF2XbYuOc2fBqoww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XDr3O0bcIIPUj8zQ"
Content-Disposition: inline
In-Reply-To: <CABb+yY0VJDu+L2C10E1O-uAU-p0OwuTq6XVF2XbYuOc2fBqoww@mail.gmail.com>
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


--XDr3O0bcIIPUj8zQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 08, 2023 at 09:37:12AM -0500, Jassi Brar wrote:
> Hi Simon,
>=20
> On Thu, Sep 7, 2023 at 3:08=E2=80=AFPM Simon Glass <sjg@chromium.org> wro=
te:
> > On Wed, 6 Sept 2023 at 23:20, Ilias Apalodimas
> > >
> > > > > I beg to differ. Devicetree is more than just hardware and always=
 has
> > > > > been. See, for example the /chosen and /options nodes.
> > > >
> > > > There are exceptions...
> > > >
> > >
> > > We've been this over and over again and frankly it gets a bit annoyin=
g.
> > > It's called *DEVICE* tree for a reason.  As Rob pointed out there are
> > > exceptions, but those made a lot of sense.  Having arbitrary internal=
 ABI
> > > stuff of various projects in the schema just defeats the definition o=
f a
> > > spec.
> >
> > Our efforts should not just be about internal ABI, but working to
> > provide a consistent configuration system for all firmware elements.
> >
> Sure, programmatically we can pass any data/info via DT, however it is
> only meant to map hardware features onto data structures.
>=20
> devicetree.org  landing page
>     "The devicetree is a data structure for describing hardware."
>=20
> devicetree-specification-v0.3.pdf  Chapter-2 Line-1
>    "DTSpec specifies a construct called a devicetree to describe
> system hardware."
>=20
> If we want to digress from the spec, we need the majority of
> developers to switch sides :)  which is unlikely to happen and rightly
> so, imho.

It's the same language-lawyering that's been going on since device trees
moved from the neat thing Apple-based PowerPC platforms provided (and
extended), and then got ad-hoc'd to support other PowerPC platforms, and
then was used to solve "Linus is sick of the patch conflicts on ARM"
problems.  And everyone is tired of talking about the exceptions to "it
must be hardware" because if your software isn't where the
software-burned-into-the-hardware wants it to be, the hardware won't
work and so on.

--=20
Tom

p.s. Yes, I know Apple didn't invent device trees either.

--XDr3O0bcIIPUj8zQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmT7MxgACgkQFHw5/5Y0
tyxezgv+N4Hq9cXCmbEMlO/unDk3LmKa4JD9XCCF+cmsmILOTo0wnszW5iDyaDPG
pgCM5gEbjSIivO5VsCAGWSpRAyGaHP0lLBRUmyN6vYnj6OVveB5Q38B2YabQ6+Iu
OgMpSbY9doQwarXIWK+tJbOsBtku7kvUeKsKgBc0sGTB+CY/i2l8XIl8c5i5TALe
G9ODfCw3HAh7piKTl9GI95zRVKIaU6bhVic20UBvH4ThvO+0pc/CQH8ZcMa/l1VA
Z4U4o9kUORDFgs0H2LZvxKMKANLNnApd58JgA0m4mQUO/vOuB44fUfpi11u7u3Un
WDhXtz+lwOEGERF/e4QopW3CRm3Me/7JsJCmsOJ9jPBYpQFp95OGXq29rOTwAb3y
PeHCSi4fmHabHmQQS2Lv/SQOPuba0zaQnuXYmsg3lP48fNgHj20Fd1qH7G8sbI6t
e6bPhS6CAvcjbGZglrj3D8ZB2BFi6nH4YxZvUTm+JEJTvDgm7q+tyxxe7du752hr
y999Fz/2
=JnIl
-----END PGP SIGNATURE-----

--XDr3O0bcIIPUj8zQ--
