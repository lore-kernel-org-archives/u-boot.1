Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C875ECFC5F7
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 19:01:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 335F28925B;
	Thu, 10 Oct 2024 21:01:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Kj+4VdZ1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAF3189268; Thu, 10 Oct 2024 21:01:17 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF0908925A
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 21:01:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3e4d5aef2f8so783826b6e.2
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 12:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728586874; x=1729191674; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=z8vTWUNOxOswosyLq6RVt4SjoT1i+0tI9tpj6jdSo98=;
 b=Kj+4VdZ1r86Cv354RWNU5F/HgiRQu7Wm7FFDD1t6OScWz6q6r4wuvSBc2Z1lC7rM9S
 6aUyTgkrZDpemmjIO/WdekK5l5k7Yb1SLKc2ZNM/LtAygBHa5z5G3tWGKX+bWyBg/Q7K
 yQdgeFVMcD8gxmeeOdCrYlwLzzLFEoLmhhU0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728586874; x=1729191674;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z8vTWUNOxOswosyLq6RVt4SjoT1i+0tI9tpj6jdSo98=;
 b=IUMp2QIdBcm9ODJ2bBaFJYFlIhjE2ShtGeq/GVVApMlLoUsUiA1iXKpLYT9pZuEwta
 RIh2iDEt3LYpzN8xG65l73hFwHDUF79A8D8j4lq6yOgBcGguHbclXQycAMjFS64k5oIu
 lupfJJOVO40Qauqq8Adb21xSHyEjqyc5BzRujU6KoBVifFIu7zQtsI1rwv2T9qWsUtSx
 7zykcJpj8A0++NIgQsEChL2uX7XwqboOpKuWQVRDT0qhpzea6/URHqdr7VryluyvzBCI
 wWvnvTGL74Tq9p95Ed8rm036PHFmo6G+61XP+nVCtMdRWOEMolHhRykKzTr5oBJxro6U
 zuSg==
X-Gm-Message-State: AOJu0Yxho3xJ7/hFmn8oefe4H62I44Xobr5T4HHJbWS08lsoQbEP+gAj
 MHlMxjPmXhzlEHUgtY3s8sktku96s1GoyaBjcc6S2YIF25BuZas1rdEpD2C6XhA=
X-Google-Smtp-Source: AGHT+IFxy8l+gYbRv4FLjZzHAPd06rv+Tc/tEY7aOoqCxKdJ0Ls1BJZK5uH35ikhiXwJNMnFt7LZxw==
X-Received: by 2002:a05:6808:10d0:b0:3e5:3d32:90 with SMTP id
 5614622812f47-3e5c90f0157mr92212b6e.25.1728586874476; 
 Thu, 10 Oct 2024 12:01:14 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46042802400sm8081281cf.42.2024.10.10.12.01.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2024 12:01:13 -0700 (PDT)
Date: Thu, 10 Oct 2024 13:01:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>
Subject: Re: [PATCH v3 3/3] RFC: CI: Skip building dtc for world builds
Message-ID: <20241010190110.GV14210@bill-the-cat>
References: <20240815195746.749042-1-sjg@chromium.org>
 <20240815195746.749042-4-sjg@chromium.org>
 <CAFLszThRC=YvhPaiQD2bnvNFsGZZVexa3cx=NZ6PaBEdB-7Z2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="A/ar6sCq9jLZp8+s"
Content-Disposition: inline
In-Reply-To: <CAFLszThRC=YvhPaiQD2bnvNFsGZZVexa3cx=NZ6PaBEdB-7Z2A@mail.gmail.com>
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


--A/ar6sCq9jLZp8+s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 12:50:11PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 15 Aug 2024 at 13:58, Simon Glass <sjg@chromium.org> wrote:
> >
> > This is quite a significant waste of time in the world builds as dtc is
> > built separately for each board. Skip this to speed up the builds.
> >
> > Unfortunately the newer dtc produces a lot of warnings, which causes CI
> > to fail. I am not sure what we can do about this.
>=20
> What do you think about this one?
>=20
> We could install an older dtc in the container, perhaps?

Is backporting applying whatever dtc flags we need to ignore problems
that Linux isn't enforcing so difficult? That would then tell us just
how much work it is / isn't to deal with the rest of the dts files (or
poke maintainers to switch to OF_UPSTREAM where the issues are likely
fixed).

--=20
Tom

--A/ar6sCq9jLZp8+s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcIJHYACgkQFHw5/5Y0
tyy4bwv/ef/kFmHe6bAGlbr1EtVX8c8hfcT5ssp+rvEwAKs1LB0ae+yMY2FWALeJ
WzeIvNu8XSTuMNSD9x1rna7ktKcgHKGQFKFI3KPjuM5FtXqDObkFSyYwTdk8Uvhb
IiyvdYBfwCz39iHOM87xPnmWwzYXjTA1A/FY5IgF73fJsb0sQa4M6DTKxHO5HhLF
OblSMi8AHFXIx31MogJZnLkINQgGHH2vjQh3Cu64hihmmTfqexkqgSv0KMTdtZJ5
6+l9paE6aeYV6gQJn5Amu6s9Me5g3u+DKDd1L847VZ97j4Tg8p6K2G/6RVANLdRn
BbmdV+A6c4nJtNRezIPfsZ5SSu4DwcExeYzf8SlI6314ud1obbpIIv0yswzcTpe6
cvaztSaYlNzJ6SViPhQSnBloU7QEyngKarwDy56tbhZsPNNxhOTF5UHaC+dQaXUU
aNQb4aI59ytDR92JLu/s8xP/UAwvjzHso+jTGhEvZDFR7XGUV3m6dOqwxUFFF2qi
hQbBGcqV
=MsZS
-----END PGP SIGNATURE-----

--A/ar6sCq9jLZp8+s--
