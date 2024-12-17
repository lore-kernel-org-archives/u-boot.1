Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A198BE7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 14:49:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E96E4801CE;
	Tue, 17 Dec 2024 15:49:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jgzBPtIR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 048DD801FB; Tue, 17 Dec 2024 15:49:43 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1B1680107
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 15:49:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7b8618be68bso9062285a.3
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 06:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734446979; x=1735051779; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RDStmrVTnssWPitr/ACwHc4tF9T8zj565qfyP4lxxNs=;
 b=jgzBPtIRmJxFoYfRG09+sppAVGacMkS9zagoOD/gfm48f1oY2+cOo2evGPRjiJK91t
 vXPxNdWhH4pUd2E4V0OP1B5vSwaE136u6NDKzuZoGmb65Hs7smMCS4dePVVkKIYb9+w2
 z/eYmXtau4v4SUQn/QL/8ZZtyXCRaON4te1yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734446979; x=1735051779;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RDStmrVTnssWPitr/ACwHc4tF9T8zj565qfyP4lxxNs=;
 b=GG7F+sb6FM3W+sKY1nQwxwkdlczYwTdwwE63iCxig54/0d/oos0PJuP7FFudq+Emgh
 qP29Gl4i+OP2uMiykLfPGW2OLH0BFexiwLJjYGuKAQW5mUjeA9AKh6iWgNXkXlQ2Jntd
 4vq87jfYPkWB/PPRbZ+BBZRHXq/vC7JcmDYnOH7BpuJ6NIxz7eqRjMIBSyqqqAIuPPSe
 hF7yfIAkCdlLQyvZ48Qomq8I3MOlaeKKOL51DIAeYRDz2RcmsyUspRVLLjVkD5lXxS8h
 z714CaMdf8OC2XjqHdqa4ivD6dy2ebNcFZfiWbUfGFcNC/g9+v/sgQzfZM/YpRGy5nPz
 pJ8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKK98Ig4l0muFlQFx5QnxvZosl4jDpP6oY+XImfp1MogpMVCtFNFYqMZ1+nIM8x6MvXZNrKkg=@lists.denx.de
X-Gm-Message-State: AOJu0YwnwFxLUdH6M7JuC4Yy3ZGgND6N6v3YjbvgGKwYR1tr1Pleq3ju
 56lxc/eTIpTHxSElQRyEfDfD1aiz4pV18gcxN/xHSkm2z1wunGFNNAMxLib8TvA=
X-Gm-Gg: ASbGncv+Z1Ho8NTOjcGCJ5eEhu8rJzI2Aha657Ekrzj1xzDziAmhQ9pYya18bHqSj2J
 bfIsQHGFWUPAGoN8bdy65F7GeGhl9vZfOENtKuWFTomfzAnwDL7lUPulcAbZLYkoQOC5iP7HfII
 FP3uXJ8RH4efLLUsunLuDkIyw2kWoioTYEEk+OrM+EOw4cci4vv3UfKY/v0C9S0qrm9AmweFuuZ
 KlhXsTqlAwaFI/fyB+ZFQEZSmymMKqs37uYFhFlHD5+5KndCTgF2XGW
X-Google-Smtp-Source: AGHT+IHpHZDyUXsESJfDbp8TYjbSgFr4iqI9DKv1ShhpDP/VWDxH0ih6U+97ekQBlM9M8yE9q1nRQA==
X-Received: by 2002:a05:620a:1707:b0:7b6:dadd:cd53 with SMTP id
 af79cd13be357-7b85952d334mr500382285a.59.1734446979610; 
 Tue, 17 Dec 2024 06:49:39 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b7048bd92csm322319785a.81.2024.12.17.06.49.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 06:49:38 -0800 (PST)
Date: Tue, 17 Dec 2024 08:49:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 u-boot@lists.denx.de, David Feng <fenghua@phytium.com.cn>,
 Peter Hoyes <Peter.Hoyes@arm.com>, Liviu Dudau <liviu.dudau@foss.arm.com>
Subject: Re: [PATCH v2 1/1] rtc: CONFIGS_RTC_PL031 must depend on
 CONFIGS_DM_RTC
Message-ID: <20241217144935.GM1505244@bill-the-cat>
References: <20241205203621.45806-1-heinrich.schuchardt@canonical.com>
 <20241205203621.45806-2-heinrich.schuchardt@canonical.com>
 <CACRpkdbTQHKNGuJtkQgV0M99k190RXZh2JftB-Jiq4t5BTW7kA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TCqlVPuDJbWO/MLP"
Content-Disposition: inline
In-Reply-To: <CACRpkdbTQHKNGuJtkQgV0M99k190RXZh2JftB-Jiq4t5BTW7kA@mail.gmail.com>
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


--TCqlVPuDJbWO/MLP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 03:03:57PM +0100, Linus Walleij wrote:
> On Thu, Dec 5, 2024 at 9:36=E2=80=AFPM Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>=20
> > Building qemu_arm64_defconfig with CONFIGS_DM_RTC=3Dn and CONFIGS_RTC_P=
L031=3Dy
> > leads to a build failure.
> >
> > Adjust the vexpress64 configuration to avoid circular dependency.
> >
> > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > ---
> > v2:
> >     Adjust the vexpress64 configuration to avoid circular dependency.
>=20
> > +       imply DM_RTC
> >         imply RTC_PL031
> > -       select DM_RTC if RTC_PL031
>=20
> Should it not be:
> imply RTC_PL031 if DM_RTC
>=20
> (The dependency in the driver will fix it I guess.)
>=20
> The way we are using imply in U-Boot is a bit worrisome
> but I'm no expert. It may work better in our case because we
> never have an option be "m" (module) as in Linux... This
> works for sure.

In this case, DM_RTC (and most DT_xxx symbols) are library functions. In
this case, RTC_PL031 already correctly depends on DM_RTC. So we imply
DM_RTC here so that we can then also imply RTC_PL031.

--=20
Tom

--TCqlVPuDJbWO/MLP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdhj3sACgkQFHw5/5Y0
tyzMtgv/SRtf1iDbDIHEYQD2m8ZmWZWIx0Bj5ONceW7PPkaJThk0NE4gqGQJBbqo
UTdw++2QAixGW9i2hgWtMIhKbtqW3j3Q1A/PPhCz6aIJ2fNNSxY4gkaAu70v8bLO
YbEXxo4oKLocvAVLOC/5YfEkAmEzMrl6QoEhWFMF5C5LtZ89Aa7cZv806rq+CM2K
QprhM/Z/f8/sU+ttDrseTi+AmhVnlsC0kOAYYrIsAcT39K7VlkhtaDlKDE+w9sI7
QTj+DgcncCK81ti2lmVqKLwDcGNeNiUxKHXW9FO/sfiUPDQAXTC2BJ3RGQWl8SOo
2wgijsfI5Sh/SD395iMkiyQ44JPMr4/pPrnceukWnMR+m13bwHRJRGv+0fv94PAT
Iv0BG9kmz0eoL0JbpeB/+v7NM2IuwWqINFzu0aSGD0l1miJFF/UeZcjHkCrqUkR7
iuCeYIJqqiT0gqqk4xz8zJP8HfCr+O57kcJJIv64WhyH65/bwPv4XxIp5z2a7zJf
jyXIizsH
=Ofkq
-----END PGP SIGNATURE-----

--TCqlVPuDJbWO/MLP--
