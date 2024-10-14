Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 083DDD18148
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 21:05:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E453389174;
	Mon, 14 Oct 2024 23:05:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZcXoMBQq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6301689178; Mon, 14 Oct 2024 23:05:01 +0200 (CEST)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0DEC89170
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 23:04:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-460407b421bso37290761cf.3
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 14:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728939898; x=1729544698; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gGuJSYKzSTlj8wLaqOTTVR4OyIjMgFOw4ceEat9DSAI=;
 b=ZcXoMBQqu94Up5ByTVIfJdsAFZh7yv2piOONR1GmmlPWg6JMpH0jKhIqJ1I+ELPW36
 jYgeTVmBSIz3OwqMVr0mLhjeIJWQFCSn5EhAVyvy+5Iyidj09PUPQ7NFSY47o2z5jiAC
 +DFTPab3+Zl7zP8EImr2fDp0oXpqvW6eMXtMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728939898; x=1729544698;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gGuJSYKzSTlj8wLaqOTTVR4OyIjMgFOw4ceEat9DSAI=;
 b=RNE0Qtcx6emn1qvPaF31H0I76C2bqdy0t60Q0wvPrIyYzNwTrp/9MkYyaZWHtD5i9N
 sBWjsv+RbD5zxFePKOTu76PMW0Zg0vx5kOhcPdKrdX8GeWWdiUvQ5t0ty4S4GyCmwQ2P
 4keRMvacZXcAHf0oqdLznKBDEcihVK1kHY5YhIZAFCFzXtH9+INvDJ1tpZuGW86sWhbR
 pD5mnoX5noY9/eUcvBuirC0khhouS5Fmk7SRJ0/Gyw4OcmZs+pSUb+8/69SRL5ZiUmdT
 cbXnNnPJ/YCcJrpjU3IGmLOUEaEPpvQ7xfmTiGRPr9V8AGO4UPa+KUcJ9tC4v/4IvmYN
 tq/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPgutJlv+4mRjn7hsucTiM2ymaFKs5aG59WDM8Di5kluN/3/XlF9u+i8CpBgScXixsjbmw+eI=@lists.denx.de
X-Gm-Message-State: AOJu0YxpNOhjlDvWciFpFWYDlAszzKw+VEdMwuh2oH8xfDjiXqMs9nra
 gryrdiBI7JiByzo8zuv0NiXePq3GXc32o2zH+UjFK1Tta0plgaj3De6rZ8K3CBY=
X-Google-Smtp-Source: AGHT+IGZ7MxZrv+4wxYWBlas08YKZ45G36uEJYNerTPvum5ATpPaR2DnZCHrl5GpAEe4qRDF7xFZUg==
X-Received: by 2002:ac8:584c:0:b0:45d:8e45:762b with SMTP id
 d75a77b69052e-4604bb96254mr210918891cf.10.1728939897740; 
 Mon, 14 Oct 2024 14:04:57 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46042894150sm48799491cf.85.2024.10.14.14.04.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 14:04:56 -0700 (PDT)
Date: Mon, 14 Oct 2024 15:04:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>, Jonas Karlman <jonas@kwiboo.se>
Subject: Re: [PATCH v3 03/15] efi: memory: use the lmb API's for allocating
 and freeing memory
Message-ID: <20241014210453.GU53053@bill-the-cat>
References: <20241013105522.391414-1-sughosh.ganu@linaro.org>
 <20241013105522.391414-4-sughosh.ganu@linaro.org>
 <CAFLszTiov914NOS9_5UU4oLi0fCQ84a-Et82BeSEJbts4MEOVQ@mail.gmail.com>
 <20241014155642.GO53053@bill-the-cat>
 <CAFLszThVP_OgyTt_ksJ1_7HAHT+K-wcixWB+k+fmzAjh6+5Bmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1NQ/Qwp9IfGzQIa8"
Content-Disposition: inline
In-Reply-To: <CAFLszThVP_OgyTt_ksJ1_7HAHT+K-wcixWB+k+fmzAjh6+5Bmg@mail.gmail.com>
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


--1NQ/Qwp9IfGzQIa8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 01:13:17PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 14 Oct 2024 at 09:56, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Oct 14, 2024 at 09:50:37AM -0600, Simon Glass wrote:
> > > Hi Sughosh,
> > >
> > > On Sun, 13 Oct 2024 at 04:55, Sughosh Ganu <sughosh.ganu@linaro.org> =
wrote:
> > > >
> > > > Use the LMB API's for allocating and freeing up memory. With this, =
the
> > > > LMB module becomes the common backend for managing non U-Boot image
> > > > memory that might be requested by other modules.
> > > >
> > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > ---
> > > > Changes since V2:
> > > > * Use map_to_sysmem() to get the user-visible address to be shared
> > > >   with the lmb API's for sandbox.
> > > >
> > > >  lib/efi_loader/Kconfig      |  1 +
> > > >  lib/efi_loader/efi_memory.c | 77 +++++++++++----------------------=
----
> > > >  2 files changed, 24 insertions(+), 54 deletions(-)
> > >
> > > When efi_init_obj() is called, it should be able to add the lmb memory
> > > to its own tables. There is no need to worry about lmb after that,
> > > since no other images will be loaded, except under EFI's control. Then
> > > perhaps you don't need this patch?
> >
> > But that's not true. The EFI application can return us to the U-Boot
> > prompt.
>=20
> Can you finish that thought? What are you getting at?

Your assumption is false. As Heinrich followed up with, there are plenty
of common cases, including *env* where efi_init_obj() is called and then
the user can still do whatever they like via bootm. There is a need to
worry about it. Trying to make an artificial distinction here
complicates matters. Much more so than adjusting our almost non-existent
documentation about memory map / layout to say that this EFI related
data *is* U-Boot.

--=20
Tom

--1NQ/Qwp9IfGzQIa8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcNh2wACgkQFHw5/5Y0
tyxDwQv8DCvoplU9aSzCinAMIjnr9j5XZ0PbwGMOksgiEFB87bD+d6ZEj+Ttq5o5
DdwSZ0saiSLvbjs6olW7McG3+y7LR+Kw4JAkGx/7uL9+zWVrLA+eda1wRADkhKaZ
3MdzmZL8ymp513u30Gs5jY2mw4lnispaXJNj1HAs7VK0G9AgSwkpBqJkkQgYXqsB
1zq8lrL2/ttYdhDO57Ia/XPPom2vtj5oPfrjNsAGaGWmUVqQbBmYLdahnQ9HHPPF
6GKDEPvRgK2/sSNwh09CdwTso+XyJYmphSrlVk43uGYpDnAMZ0nDebclQ7Lrr6ld
fvOEo7tJgTqHO0wQ4wSWQV94pa5ThCY2H7xwsMeWhzMeR6RcmJI3Y0hg8HiJLyuL
JsCnJBPiWeWvAGdGIDmRPec8GnvTGRAflZ/1q/rOXsrkSz9TsEXfcNpc+mHBVyih
A4UtqwGzL70MOt/Ztqp7AsKuyk3zxOdgC8twhjf/aby7ftlXj3HIUDT1R5oNNaAc
A7WvWwtj
=SwMo
-----END PGP SIGNATURE-----

--1NQ/Qwp9IfGzQIa8--
