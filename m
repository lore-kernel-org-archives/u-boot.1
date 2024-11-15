Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1AD6D68BD5
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 20:49:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F5D2890C6;
	Fri, 15 Nov 2024 21:49:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MOS8Tvvk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82BA38904E; Fri, 15 Nov 2024 21:49:38 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15E00890DA
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 21:49:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6d40e69577dso197836d6.3
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 12:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731703775; x=1732308575; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Yal/VQs41k9KSui3E+G8zmroueZ86UxWXzD1Ipb1foE=;
 b=MOS8TvvkDHYOXxhvtp6dkLkv6/MQBl+xNdN2CagiT4D7qzFAkobFE9vJR9ltyM151e
 z8ct4utWqR7tfD/ERriJf6gMWCMlQKUmX2qnN9eRBM/2APGDh1VV/eUeEjI7oiktyuz/
 94XkAI8FnuFphZV4AxzzsT5E7y+flsXGyIqOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731703775; x=1732308575;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yal/VQs41k9KSui3E+G8zmroueZ86UxWXzD1Ipb1foE=;
 b=hyuzARuxKK0oai95VW2qhx8xFtHgI4WNAfW3Y1+8VI7FKhK+ECQyv7LIb2G/5RXR9s
 2/euF7/LCEZbKdWYOkBMseTRVUIemgsFsMoaH8Qnqnm1XKCT02Hst5mILgaX+hAIMS1k
 XN+ZnMKfG/0YTU7DrPZH6pg7k4p1ufw56ULnvyRBm/b4yL39moD2K0XkYokDP602eUWS
 t0zt/CHKjkVWLpGLpj1/5WwqUi/DjS0sxMTGQHhJM3zS/bzu6iB5RHOTaVMPRf5CniRz
 gOHU83BTwct7/cpJZqafgqMENvsMtmk/1mg8E8GuQzoBN9LVuKmt9InC5Qs2jHPfr+jY
 0IwA==
X-Gm-Message-State: AOJu0YxIEoBPZIbU4hlf4XkX9w/UAJdjIYt92nNBebMTg5D6WswXGDRx
 IO8ZvA09LWG9a632LkmvLDYzV9hbYssJ+ac6/fHQ667gidvXW/IUA+Z1yhQ8/RU=
X-Google-Smtp-Source: AGHT+IHoToCEOieIyNOBKJdBZy50CBMtWqop2UH4mPcIcOkXYL4YJTaRAgRV9IAzKgeyTMH8kOHhjg==
X-Received: by 2002:ad4:5aaa:0:b0:6d4:b1e:5418 with SMTP id
 6a1803df08f44-6d40b1e54fdmr15527596d6.33.1731703774892; 
 Fri, 15 Nov 2024 12:49:34 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d40dbfed6bsm880806d6.28.2024.11.15.12.49.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 12:49:34 -0800 (PST)
Date: Fri, 15 Nov 2024 14:49:31 -0600
From: Tom Rini <trini@konsulko.com>
To: Tony Dinh <mibodhi@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Git commit failed with mbedtls/framework
Message-ID: <20241115204931.GA3600562@bill-the-cat>
References: <CAJaLiFwvFVOKYpAQLSNUqAfVHCsPcxo6g74JGunw8HSQTMCFLA@mail.gmail.com>
 <20241115141748.GS3600562@bill-the-cat>
 <CAJaLiFx35Q8L-kR02GrA1PTd2nY699KMc2fy5fT381Khg5hgxg@mail.gmail.com>
 <CAJaLiFy2oo2fp-08qJni8srUn6RErgGgZs_A3GGPJuD0+=YsOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GcbUn7cviTboQm1d"
Content-Disposition: inline
In-Reply-To: <CAJaLiFy2oo2fp-08qJni8srUn6RErgGgZs_A3GGPJuD0+=YsOw@mail.gmail.com>
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


--GcbUn7cviTboQm1d
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 12:32:03PM -0800, Tony Dinh wrote:
> Hi Tom,
>=20
> On Fri, Nov 15, 2024 at 11:27=E2=80=AFAM Tony Dinh <mibodhi@gmail.com> wr=
ote:
> >
> > Hi Tom,
> >
> > On Fri, Nov 15, 2024 at 6:17=E2=80=AFAM Tom Rini <trini@konsulko.com> w=
rote:
> > >
> > > On Thu, Nov 14, 2024 at 08:26:33PM -0800, Tony Dinh wrote:
> > > > Hi Tom,
> > > >
> > > > I am on 2025.01-rc2, and I am trying to commit some files. The error
> > > > seems to indicate this framework directory might need some
> > > > modification. Did I miss something?
> > > >
> > > > error: 'lib/mbedtls/external/mbedtls/framework' does not have a com=
mit
> > > > checked out
> > > > fatal: updating files failed
> > >
> > > That's odd. You didn't happen to try out some of the previous lwIP
> > > iterations on that tree did you?
> >
> > No, I did not. The tree is clean with "make mrproper" and on the
> > master branch. I just did a git pull and worked on it.
> >
> > I went and looked at https://github.com/Mbed-TLS/mbedtls.git. The
> > framework directory is pointing to a specific commit.
> > framework @ 3867faa
> >
> > I'll stash and repeat it on another clean tree.
>=20
> I have the same commit error on a brand new tree.

Can you please reply with exactly what you're doing here ('script' may
be helpful for example) ? Thanks.

--=20
Tom

--GcbUn7cviTboQm1d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc3s9MACgkQFHw5/5Y0
tyyBAAv9FIHZd59FMxod1XjGLn5iImUrwl4Ozh3PeBOB+1sXlQgRhJrwbHnRd7C+
5epZMwCeABPtBUHd4CSgkFkvEzdK7KJqfsKL2M7IckTmyKApcAeGc7DOVSuobO+a
8hYYj42DxBaXrS0WKFFg0P5QzeDAIuo7cTFdF8hPWmYYXltYzWi2sG54+i+ENp6d
5dN5sDkdWvQxVgWQWFw3PWcfVKI/6Gy0/J7fvAgV6t/7RXi7Vg8NG9uVeC1AVzyD
8fz+OAO7L4dw/9S3STE8yOGwnTMR/XtQctrSrfd1nMdJYBZFh0zMkVuA/uTZi12d
6RLwOcLGF4oZEtlzokJyGtYo39eTaGcb8/PLgXD9RWCafsmcQMyUJ1U6lieNDHEu
0AB6UOdbW1joLDasv2lSzi2jN1v9PEmwI2kdF/u/Swgihs0BxISvtzL14S1p1MNM
VP1eA2VmiKUSgyzm6c/3K+/eQGeBs4/BWzNfEVWh73rgGxfUh2yg5ZL1D26DvD8E
kuhW3y/8
=sneM
-----END PGP SIGNATURE-----

--GcbUn7cviTboQm1d--
