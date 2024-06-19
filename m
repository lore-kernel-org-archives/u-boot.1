Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E355C27C53
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 17:19:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82E948839C;
	Wed, 19 Jun 2024 19:19:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HxTxFx8C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D24E986EB5; Wed, 19 Jun 2024 19:19:43 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC2988839C
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 19:19:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-5b53bb4bebaso6234eaf.0
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 10:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718817579; x=1719422379; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=S4HHuciA9TeAGaH+7EsScXQ1+ultkSdELljkSr2Tn0s=;
 b=HxTxFx8CGQ5Vq9osWMZV0tn7lvTGeDDcBUOLs89hv2nSeNE9g/WaDyAawekXueeH72
 2k2+vfSjjagkiyTVBg1L6S2pCD5ApqNfBCF7t4a9DYudpg5Mmw1WHUdLSxB015eP9J/q
 PPnh39GTe4g9EOHIH1/ieLAPMcVD999142jAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718817579; x=1719422379;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S4HHuciA9TeAGaH+7EsScXQ1+ultkSdELljkSr2Tn0s=;
 b=sRA53p4XAxSZESwXOdhTqviafGK+z1Vvw+Ocw9DOQTcGW8f+s6bpNiFsfZUnB17frD
 IAsbe0vIjgtM4wAhFfmDDOkTPQTdt/loTBBzFoLv9HA9aCD9ndPGE6zCRp1JXlx5Rtz9
 kZojDNVWhOGcsYLH1ptzdy9jL2IHzVMeWNnXZO/CtnHOjdQwsZOjHPA/DGpr7bWXa3NO
 VOebV6Odzo1PyAnGVLH1jYScYj36ENbgQBBxuFPfOvagVZxY9FqEl94dUc79PJh5yK0N
 cescE1PFrhrxzdavGbpzPhaMsuIE1CNgHu5fiAi6FPUGdIEONXcK6YJM/zBJGBIcQpcG
 4kyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8FW5c8iI2zLADnthDVh6lfPugLw4tZG52M+PZ+uK3EaE4Xpe5X1pANoPYbIdVCVk0orznTgrO/i403kYL9w15bbeiEA==
X-Gm-Message-State: AOJu0Yy4a8ckF+fOKHOdpBt22yjpztGpHnqpOErgPWeROdsWnqOjFLo+
 BhuZgRx+6JTl/+qz8XqcZcz8IYBKKXAC7OT2WwRSmwH71QmsTogSGyEXlpaS1F8=
X-Google-Smtp-Source: AGHT+IFekF2PTK+d0DgEuRYsMp3QAIAo/G5iyxsYdEXc3FiXbXIDkVUVNQLvvIVLXVwkUzwXxaSfZQ==
X-Received: by 2002:a4a:310d:0:b0:5bd:a078:aba2 with SMTP id
 006d021491bc7-5c1adae382amr3340583eaf.2.1718817579624; 
 Wed, 19 Jun 2024 10:19:39 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5bd5e19e943sm1690734eaf.23.2024.06.19.10.19.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 10:19:39 -0700 (PDT)
Date: Wed, 19 Jun 2024 11:19:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Marek Vasut <marex@denx.de>, Simon Glass <sjg@chromium.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/3] cmd: avoid duplicate weak flush_dcache_all()
Message-ID: <20240619171936.GJ68077@bill-the-cat>
References: <20240616173105.7430-1-heinrich.schuchardt@canonical.com>
 <20240616173105.7430-2-heinrich.schuchardt@canonical.com>
 <CAC_iWj+W5grPjuD9=v7ZOYGPFDE7_mFxF7fJhERTTJCjjpk4aQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zYzC3269dMTjczDv"
Content-Disposition: inline
In-Reply-To: <CAC_iWj+W5grPjuD9=v7ZOYGPFDE7_mFxF7fJhERTTJCjjpk4aQ@mail.gmail.com>
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


--zYzC3269dMTjczDv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 03:23:36PM +0300, Ilias Apalodimas wrote:
> On Sun, 16 Jun 2024 at 20:31, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> >
> > If we have multiple weak implementations of functions, the linker might
> > choose any of these. ARM and RISC-V already provide a weak implementati=
on
> > of flush_dcache_all().
> >
> > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > ---
> >  cmd/cache.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/cmd/cache.c b/cmd/cache.c
> > index 0254ff17f9b..16fa0f7c652 100644
> > --- a/cmd/cache.c
> > +++ b/cmd/cache.c
> > @@ -52,11 +52,14 @@ static int do_icache(struct cmd_tbl *cmdtp, int fla=
g, int argc,
> >         return 0;
> >  }
> >
> > +/* ARM and RISC-V define a weak flush_dcache_all() themselves. */
> > +#if !defined(CONFIG_ARM) && !defined(CONFIG_RISCV)
> >  void __weak flush_dcache_all(void)
> >  {
> >         puts("No arch specific flush_dcache_all available!\n");
> >         /* please define arch specific flush_dcache_all */
> >  }
>=20
> Aren't we supposed to add a single __weak function so the linker can
> replace it? IOW why is the declaration for Arm/riscv a weak one?

Yeah, I'm going to see about re-structuring this a little bit right now.

--=20
Tom

--zYzC3269dMTjczDv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZzEyUACgkQFHw5/5Y0
tyytdgv8DuGy2rWbQYiEyMTYtldiaOFmb4zo+u21usV9BrB9TL93/aM9gbclvfnm
6WpNa0PdsZThCZe77T1H+etiLXSCR2f8gZr6MVUfNzvsXq0bfDdsDj4t5LNkrlGS
oF/ovgtV53/jgIGE9ynI+uu1GC40/r/KkiD4NaNKDKvbc7/+lckDoJBvILsaAJlz
Zmgyk1aK48kQ//gYdpYWgpYz9DWtC9QEyxzQO9YJJmMUsevyQLGNLZ1CPeYWDg+m
f+r6SlZ/niRIVsRxiMOocmlJ67zVbtjuU4uoefDneqksGTUU+K82AWHGOmOO2909
p5axkPuQSatnIUOtOpXQ90NesfrQfmAOok1Ke5hjcEAUuXeJE2A2K79Xhiq9deqo
BthIMF5nzPW85YlXUEKeKDLc0X4urqxzgL2chG5N0EHseiWaUEzuymQq6ukT2bVC
QIq0/4Axx9q4736cd0BgITpdPwdSljNk32AQkQwKsMvHUpA1fBr5pbuSe999+i3+
6JMOHL8K
=Pf9/
-----END PGP SIGNATURE-----

--zYzC3269dMTjczDv--
