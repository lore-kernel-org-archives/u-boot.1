Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3334C369A4
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 15:18:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7497983890;
	Wed,  9 Apr 2025 17:18:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XcaHlyix";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E14B83898; Wed,  9 Apr 2025 17:18:28 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE01383886
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 17:18:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-2c7e5f7f0e3so2030935fac.3
 for <u-boot@lists.denx.de>; Wed, 09 Apr 2025 08:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744211904; x=1744816704; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZTkT1Aa+vu7Y1QELJGKUv4ARo2PS7qPeLTN1bzKoEzI=;
 b=XcaHlyix55hAnlo2pD/mqHxsz6w6uq8E2IvrzLxrMoPZQEFlyYL8t3Su/GRmHDI++K
 kC4cxkVOZLIZybQVt7uLFxlF7v67ZW8FTSN+z41meyr6aoERh04kIcy3tl5bYdkLxpVi
 d0AB0lKyx6TncSQ2c0Mx8SPJG7L036ROTjWH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744211904; x=1744816704;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZTkT1Aa+vu7Y1QELJGKUv4ARo2PS7qPeLTN1bzKoEzI=;
 b=tnsIj6fSuNgp53bdXXqxK6CSmdGSFVJnO5V8jf+L2CT9TfxDNzR8QjSzsin8LgpDXZ
 jRQIudgUxefPIXFWt+L1t5nJaBEYjPy5oj/7mo0ln5KOFXm7FgnNnLv80tPHxwwwUWc5
 jwe0NrOX0MPbhrbwsUvFrxjGcsND0XUp+OkRR9hsJKqolq5qw/YSTu3SNyWbd+Oa7xN6
 y4YY+h9vsDAvbbiyEgulxQQ/c4woAxdW0jny0AZG2NOoGoTL+ohRNPHtd6SlffjXPfb/
 2FW6U4LEwVKHU+37G+ithHG1RKYtEZMFOQCWA4vW9CAKu4CrUQfP24+L+7iBZPkEAGsc
 n49g==
X-Gm-Message-State: AOJu0Yx8XtbYeuQWSxWoywCtPkBm1Yy3EikMGp0vjXnT30VBzP15D6lU
 WgOkWnkDCFNzvWoqZmax6DKr9UuyHC6DF5Z7lqrNYNcCSU0yJvFi7vS8COeBP24=
X-Gm-Gg: ASbGncuyY4i7R07NVtixpRU7bNJlj7dnbw/0aq1iCq9TOQUIW3PV+XfE+T28p9VG2Ou
 O2t7bcl6lSVNubs4qXW31qYFJflkL7J/dKjWi8hJEreAojOQhuxq7bEsGpuFmsxSXcHD5QnJpnT
 YWfK27s7A5JUq4VjsCmcGK+uZ/ryp4m65YOH2Yxt085zjQ2Fy6x3jUeU85nlG/ZZqgIGRHU6hVE
 1eAAl4bjvLWfophfZ3308od85Tyn+WmtRUBZxSa3ATLdsZh/Ox6kx/pt47pCUsJbzrfivWOyRze
 QTmGPKUU0UVzuissMNds5Oq8OzmIvyrlsH7SjBzW0a7fjDlvPBY3OYICZxehRMonyywdTF8im7P
 e6w==
X-Google-Smtp-Source: AGHT+IFn0llkBHVBnqLXtei1inSZw0Lo9bt/GreSVWy7oeHKdP34OehyOnuG0wbNknSAQvqtn4su3w==
X-Received: by 2002:a05:6870:9c8b:b0:2c1:9a53:83c4 with SMTP id
 586e51a60fabf-2d091acccd4mr1531839fac.26.1744211903378; 
 Wed, 09 Apr 2025 08:18:23 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72e73e67465sm199508a34.57.2025.04.09.08.18.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Apr 2025 08:18:22 -0700 (PDT)
Date: Wed, 9 Apr 2025 09:18:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Douglas Anderson <dianders@chromium.org>, Sean Anderson <seanga2@gmail.com>
Subject: Re: [PATCH 0/5] patman: Separate gitutil fully
Message-ID: <20250409151820.GE5495@bill-the-cat>
References: <20250407105151.689453-1-sjg@chromium.org>
 <20250408221324.GA5495@bill-the-cat>
 <CAFLszTg7-yM0L8uuJyN7Jpsb1LbvOYO76cUWj+H719mfc97mMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="niV8X08Kdry/KYze"
Content-Disposition: inline
In-Reply-To: <CAFLszTg7-yM0L8uuJyN7Jpsb1LbvOYO76cUWj+H719mfc97mMQ@mail.gmail.com>
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


--niV8X08Kdry/KYze
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 09, 2025 at 07:04:48AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 8 Apr 2025 at 16:13, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Apr 07, 2025 at 10:51:42PM +1200, Simon Glass wrote:
> >
> > >
> > > The gitutil module uses Patman's settings module, which is not allowed
> > > as it is supposed to be a separate package. This series ties up this
> > > dependency.
> > >
> > > This series depends on these two patches being applied:
> > >
> > > https://patchwork.ozlabs.org/project/uboot/patch/20250227192735.40638=
9-1-sjg@chromium.org/
> > > https://patchwork.ozlabs.org/project/uboot/patch/20250328130225.26079=
74-1-sjg@chromium.org/
> > >
> > >
> > > Simon Glass (5):
> > >   patman: Untangle settings from gitutil
> > >   patman: Pass the alias dict into gitutil.build_email_list()
> > >   patman: Pass the alias dict into gitutil.email_patches()
> > >   patman: Pass aliases to Series.MakeCcFile()
> > >   patman: Update Series.ShowActions() to pass alias
> > >
> > >  tools/patman/control.py       | 11 ++++++++---
> > >  tools/patman/func_test.py     |  8 ++++----
> > >  tools/patman/series.py        | 32 ++++++++++++++++++++++----------
> > >  tools/u_boot_pylib/gitutil.py | 34 ++++++++++++++--------------------
> > >  4 files changed, 48 insertions(+), 37 deletions(-)
> >
> > I just want to reiterate my question / request to host these outside of
> > the U-Boot sources themselves so they can be managed (both in the sense
> > of U-Boot as user and as maintainer of sources) following normal Python
> > best practices? I'd be fine even with something under
> > https://source.denx.de/u-boot/<something>/patman, etc.
>=20
> Yes I am working towards that. This series cleans up something missed
> in the last series.
>=20
> After this series there is really just 'patchstream' left, which is
> used by buildman and patman. I haven't quite come to terms with the
> idea of moving it to u_boot_pylib yet.
>=20
> What are the best practices you are referring to?

Hosting python projects in their own repository, and versioning them
and managing them via pip/etc.

> As to location, I can keep it in my tree and just delete it from yours
> if you like.

That would be very silly. Aside from the whole thing about you needing
to close down your fork, which this isn't even about.

--=20
Tom

--niV8X08Kdry/KYze
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmf2j7UACgkQFHw5/5Y0
tyxwfAv/cdjWA1HScokkasC4g7BC4I8KcM/zftsP9pG6GYC3kE9XhYOWY+O2Tmly
qJBGBIvqUU8EJLhnF4XNHqmU9LUm9Qoi+egnzmR9fSxbBS7I7CM00Rx6qb0E7/L3
NoeazVfGV2W7C4GxC5lWuCfLocEN6/1CzkHWyivEnWGg2tXbSucCRNqwdqrSrRxe
zmBXE6ES9L1k8IJB9pm0EpDx8aCJ64COnGxLUJSDblCg6MHoe+dcBdBIwG/0Elup
n4KI0gwxln2ddlRHjqmrJA0Qln83sMNxpELPQ9RFNZqvGsuUEzafsazgA4WSeVn/
SfOkL3rtPMJfzK3HDSLltomi07UtgAjhLP/i9+8SQpZjQh9PwJwRxVYB9EhCJSVl
7h3XLNSGPe/Mr6wux8kRIG1T9/qtKXxP/wnUCBJniCEiwpwdS2hTtmGWvMRwiygb
BAtac/rrycmCMrQR3rcuuoNS6jXvb2vFja/zh8nn4DQWbt0ipyxswYpP2im+FpVF
IFZNIkpc
=DFND
-----END PGP SIGNATURE-----

--niV8X08Kdry/KYze--
