Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0097BCFC5F7
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 18:59:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FB158925B;
	Thu, 10 Oct 2024 20:59:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rDTUoQDO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8092E8925B; Thu, 10 Oct 2024 20:59:18 +0200 (CEST)
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com
 [IPv6:2607:f8b0:4864:20::92a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE3298925A
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 20:59:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-84fcfe29e09so394814241.2
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 11:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728586755; x=1729191555; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=H/MSwJgelFz7QMSThqa9SIfm9SrAX18WLcfezxSipvQ=;
 b=rDTUoQDOLczZlhPg1XMLPd9f7gwR6ZlOfBPeGmIskFpMciZaDDEp+F5R9gYGHB6gPs
 +StHOMRxi36wwIusgn20JG9LFn2roQYA/Oj1DxSIuDCxJFRkd6Whdg60UNqnY36/iM7n
 QgxcxrZxU94koIIUQsV4RhWqg2jI+AfwX8Tp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728586755; x=1729191555;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H/MSwJgelFz7QMSThqa9SIfm9SrAX18WLcfezxSipvQ=;
 b=ZrcFwBciCDjOE3SJHQjUroLeto4fLdZ91weilLi91Q04agfaR+Pw5Eq458GkPTp0kw
 qRlMN5K2ZypmD4w/WhnwyqnNaPZUDKjQYiTCqzgzPZJkPq3755UrDDw0aJWl9l5uNFh3
 FEfuGdjq39YHb5jQfA+5rcQPJV73RC+CTrwEjzwv8ber8OoeG1tDdPtaY4Tkv3AZ5tEa
 3LY7xcEwBIZay8nBKAAxI9f0uJW2A1xyty7MMZO1TeXg+X0FBjOUnXa7wOUQQbY4jHMG
 L+3SuQkBD7zqhFje7Xzawgk8a7ZX4Lp/VIzF1QtLioziuTzTIS+7IhHIb8FXqmV8EUDW
 tvHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzBXPQsdbRIK6mvVJZ0ZJIXHlnGKo/+rrJOsyUj5yunKdYva/Bj/xERM2z8WFJgwiki3Bm1tI=@lists.denx.de
X-Gm-Message-State: AOJu0YyVrNtcKaB3xKlGPYVz3rtHxGExXnlbine2Ve/J/All2G8zSd9F
 h4b67zGGyrPoNzb9vRtjenfpFRb0hXdNOTNGxjGjQtRTeSMg2U2f2bbg3pxqxip/c0luAdLXAyY
 iiqmstc8Q
X-Google-Smtp-Source: AGHT+IFrjoOhvEY4f5DuuB0tKqlehhjp/gCvN1JGQ5VfvJ3dVj1GdShq/yEEk5WHEXvW15yOT2MaZA==
X-Received: by 2002:a05:6122:179b:b0:50a:c02e:788d with SMTP id
 71dfb90a1353d-50d17dace30mr563781e0c.7.1728586754583; 
 Thu, 10 Oct 2024 11:59:14 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cbe85b955csm7960726d6.56.2024.10.10.11.59.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2024 11:59:13 -0700 (PDT)
Date: Thu, 10 Oct 2024 12:59:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng@tinylab.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] tools: docker: Drop the git user name and email
 configuration
Message-ID: <20241010185910.GU14210@bill-the-cat>
References: <20240104132817.278079-1-bmeng@tinylab.org>
 <20240106174108.GY1610741@bill-the-cat>
 <CAFLszTiHj8yUuABQsHyAME6V2mdgM5SqocOBAdGksy+B0O9E3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oJyJIL4S1axRWpE+"
Content-Disposition: inline
In-Reply-To: <CAFLszTiHj8yUuABQsHyAME6V2mdgM5SqocOBAdGksy+B0O9E3A@mail.gmail.com>
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


--oJyJIL4S1axRWpE+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 12:50:18PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Sat, 6 Jan 2024 at 10:41, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Jan 04, 2024 at 09:28:17PM +0800, Bin Meng wrote:
> >
> > > Since commit b45ab9ca6621 ("CI: Update to QEMU 8.0.3"), the manual
> > > patch applying was removed, hence there is no need to do a git user
> > > name and email configuration.
> > >
> > > Signed-off-by: Bin Meng <bmeng@tinylab.org>
> > >
> > > ---
> > >
> > >  tools/docker/Dockerfile | 3 ---
> > >  1 file changed, 3 deletions(-)
> > >
> > > diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
> > > index c4a2596b48..c12ed0fd9b 100644
> > > --- a/tools/docker/Dockerfile
> > > +++ b/tools/docker/Dockerfile
> > > @@ -179,9 +179,6 @@ RUN git clone git://git.savannah.gnu.org/grub.git=
 /tmp/grub && \
> > >  RUN git clone https://gitlab.com/qemu-project/qemu.git /tmp/qemu && \
> > >       cd /tmp/qemu && \
> > >       git checkout v8.0.3 && \
> > > -     # config user.name and user.email to make 'git am' happy
> > > -     git config user.name u-boot && \
> > > -     git config user.email u-boot@denx.de && \
> > >       ./configure --prefix=3D/opt/qemu --target-list=3D"aarch64-softm=
mu,arm-softmmu,i386-softmmu,m68k-softmmu,mips-softmmu,mips64-softmmu,mips64=
el-softmmu,mipsel-softmmu,ppc-softmmu,riscv32-softmmu,riscv64-softmmu,sh4-s=
oftmmu,x86_64-softmmu,xtensa-softmmu" && \
> > >       make -j$(nproc) all install && \
> > >       rm -rf /tmp/qemu
> >
> > I'll apply this next time I update / respin the images but I hadn't
> > dropped this part just to make the next time we do need to backport a
> > patch easier.
>=20
> I just found this comment, but it looks like the code is still there?

Yeah, I don't know quite what I was trying to say before, but, yes, I'm
keeping the git config lines because it's more likely than not that
we'll have backports to QEMU needed in the future and keeping that will
make it easier.

--=20
Tom

--oJyJIL4S1axRWpE+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcII/oACgkQFHw5/5Y0
tyz6VAv/avzYhyErO/UDS3UhMSFPzNFaeyCgTSSDuFOAG0/+BEmUFtGWo48XUGxb
RkH1B4HVJ+KsNfEU0PjuRfKkIWLNROORPpuiZPPRavI3SZfOESnxKfARh4ZpReyc
CZ91YvXEf/zj3BujOrnOjkKYScAQOyEZXayRzHiWH61Xd/OgK0tpVNTaunsjMxZC
YBWmzw/xrxOO/EFXbe/D/3LaPGk5G8W8WjXCz3QyFxvnbePQ/1QiXanRhW1B3dki
M8dJmYMW5rtDidpA15Y5ZQQf+TgOcUUWMXTLAImiozXIYzyfSVvN6N3bDjArgUGJ
Lgc8J1Fo0ahIfPfCtC3hdza37w/K7Oe9jlh0BIJh225sNieysA+jdM2/o2pkoldl
gEVQLQBqUrPXOmRCikkrQ1UxHGhJJ6vYm6AliBjD1yy7nwELla30HN8MbJkVuge3
2/nY/0LXigil77ao8isJlnxoAOwibJOn+GXy6CJ5P6e7m+wCnKXJv24OgqV1aXYH
qgv5GZdn
=+Nm7
-----END PGP SIGNATURE-----

--oJyJIL4S1axRWpE+--
