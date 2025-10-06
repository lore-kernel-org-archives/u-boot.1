Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 022A2CCA471
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 23:45:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B9F483B64;
	Tue,  7 Oct 2025 01:45:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ss0JGV5p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D83EB83BC4; Tue,  7 Oct 2025 01:45:06 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C71E83A45
 for <u-boot@lists.denx.de>; Tue,  7 Oct 2025 01:45:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-64fdca63b41so138476eaf.2
 for <u-boot@lists.denx.de>; Mon, 06 Oct 2025 16:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759794303; x=1760399103; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7YC87GmoTNwuRjLYvwPkcguozWmJV6B0GJItlbWRsjQ=;
 b=ss0JGV5ptZBagrpT8erbDQHzIaxmHkuzUer7sfZyvQl9HjxiPk0DNezfUc1ooYbv5Y
 rOc6yOCKHq8sSr2j1BC8i/Iz26JZbJrO0BbGQk4Tsf2s4+4BO6nVOAh7fwZXybu/yD2f
 B0TveuDSw6BHf/F121dVpDdxbrtKkLI0k2Lfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759794303; x=1760399103;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7YC87GmoTNwuRjLYvwPkcguozWmJV6B0GJItlbWRsjQ=;
 b=kp325408v2jkcpAIbUOj72wsNulHvBGq/ij5a99pbJrbWhCX/5bXb6U/GiHJkOtLHm
 lzGlNYFJHImyQju0McCEIm0+HITjoOM14yWQB3MWuJoUaRlUaPN5WbzMsMJgtFYnsurh
 ulQebviZ7csJpIktv2Adfv2+mr+9vPS+/Xls0YbSwxndbyw5NcRjDysE7usFjaEU8nKL
 aHuuu/Nu/SCiA/sUih7x6o7m1mEFuA1Hr4uU5EJxMDy7WlwBfdma/iQxYj6QdcyrLpsw
 fQCyYIV2maWp2wcnW8wyg2wnNZL3JebS0T78x0WEG+qkN9v5U0s4ItC/JofymMN/Wxtz
 5ydA==
X-Gm-Message-State: AOJu0YyiWYXjVcKNQ7YcG30klGWM5V7YpdHMMUVilD5I2wKl4avUCRwx
 algZf3jKsAkXSl6COEOxqZSiMt24s+WxqE8p8SWlQ7+/D7D9jTD8AvveeUC1uc1oUOE=
X-Gm-Gg: ASbGncvhMzNQWx90RDGtl8MawNKF07O6mU6BeDooL3wMVor+2kDk76OgufV0N8QvICW
 8o3LFHAoTpGZFYwLWOl0CHMTTW4TWoQ9usNpV8wnhImpy+FIurDYoLhyffg1I0BFWSxe9PwMSZ/
 XdI2XtkBlThwocjsvUyA7CnkrkYs9C0gAMLV95gZJ2LQ+UB191kuTdF0o9XCUA8fv3s5C+d7LeK
 cYRuNkBh9f/qcnT0eNmod31AB8rT/izJVZZI2MNIVgFUJ79uV+In5MUohoFkhhH29wUp2cyn6/Y
 9GVU5a4UUTKF8hxKAcHI4rOFdrKT1HBxVjmNn7ySVoopkqWgfi1YlhU4Y84PcSBxRG67/tFLeP3
 clGISgzmKalWqIJYIJc23YwXvv82LIBKIvbfashhE1zuSqUGuU4XQ9BwQEb4XkMqNayhfu+gEyf
 5es/3V5rCYhw==
X-Google-Smtp-Source: AGHT+IFq7jdzEqPp0C9NTWQcz7qv44C+N8APuj63Db+djfXVDySZ+SBDCAofGQ8wtaKy2pymrKswLQ==
X-Received: by 2002:a05:6870:3190:b0:31d:8e9f:e422 with SMTP id
 586e51a60fabf-3b1019ab1a0mr6910287fac.31.1759794303047; 
 Mon, 06 Oct 2025 16:45:03 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ab94d983adsm4440129fac.27.2025.10.06.16.45.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Oct 2025 16:45:02 -0700 (PDT)
Date: Mon, 6 Oct 2025 17:45:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: Re: [PATCH v2 05/17] boot: Move showing of bootflows out of the
 command
Message-ID: <20251006234500.GG298503@bill-the-cat>
References: <20251001212649.3263574-1-sjg@chromium.org>
 <20251001212649.3263574-6-sjg@chromium.org>
 <20251002201537.GO6093@bill-the-cat>
 <CAFLszTigwz2mVfS=C6yXDnTMvdGxw=FsD36QCrpS2VOVSr+7nA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2nX2KXF64H7GNV9U"
Content-Disposition: inline
In-Reply-To: <CAFLszTigwz2mVfS=C6yXDnTMvdGxw=FsD36QCrpS2VOVSr+7nA@mail.gmail.com>
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


--2nX2KXF64H7GNV9U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 06, 2025 at 05:30:23PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 2 Oct 2025 at 14:15, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Oct 01, 2025 at 03:26:30PM -0600, Simon Glass wrote:
> >
> > > It is helpful in tests to be able to show the bootflow that is being
> > > examined. Move show_bootflow() into boot/ and rename it.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > > Changes in v2:
> > > - Add a log_err() for an invalid state
> > >
> > >  boot/bootflow.c    | 57 ++++++++++++++++++++++++++++++++++++++
> > >  cmd/bootflow.c     | 68 ++------------------------------------------=
--
> > >  include/bootflow.h |  9 ++++++
> > >  3 files changed, 69 insertions(+), 65 deletions(-)
> > [snip]
> > > +     case BOOTFLOWST_COUNT:
> > > +             log_err("Unexpected boot value of bootflow error %d",
> > > +                      bflow->state);
> >
> > A small thing, checkpatch.pl catches that this isn't aligned with the '=
('
> > here as it should be.
>=20
> OK. I'm unsure whether I really want this line anyway, since it
> increases code size.
>=20
> >
> > A larger thing, and please correct me if I'm wrong, but on reading the
> > whole set of changes, this move + rename just means we're putting more
> > info in the test output, and nothing else?
>=20
> It will also appear if you have CONFIG BOOTSTD_FULL and use 'bootflow
> list' or 'bootflow scan -l'.

But that should be the case before this patch as well, yes?

--=20
Tom

--2nX2KXF64H7GNV9U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaORUfAAKCRAr4qD1Cr/k
CkFYAP4/2irp7EOxFvSsqSEI5g6Lhv+lCv/ktIP5zHwLUfLvZgEAk1n5Qui3ExV4
zOWcDhUZMruXRpEE2sjpNnv9syKBqgA=
=qg4P
-----END PGP SIGNATURE-----

--2nX2KXF64H7GNV9U--
