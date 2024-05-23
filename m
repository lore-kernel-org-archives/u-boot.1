Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB224C25B7C
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 15:43:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AE7C885A5;
	Thu, 23 May 2024 17:43:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MCa6YciL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6153885A5; Thu, 23 May 2024 17:43:24 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DBD7885C7
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 17:43:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-240cb6ed477so3928011fac.1
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 08:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1716479001; x=1717083801; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SyNw0er148TMfADn1I3jS8mDM+ObRlCa4JupIbw2ufc=;
 b=MCa6YciLIZAVzHtlrdca1qEVYMBvn+CYchSFtl+pOibWv6hS0OfA6naych//UAE6yN
 YAAuIZSfa7nHyZX6Ihrlzx1BeOl1qZuICF/3pzAYwgvAXzQoy1EGygRReKKnVWlIdOnz
 uhS6NQtk3vX4Bh+0xneKvgkjXrdpAM63Vk4xc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716479001; x=1717083801;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SyNw0er148TMfADn1I3jS8mDM+ObRlCa4JupIbw2ufc=;
 b=th9jyX07lPES2+21ZU0B9gpk0I1GTQqF1hAyl0tI+MiKxgHHb1Vdhwa9F5vd1iwAPD
 Pm+n1xbhSHc599mh/6EYmswb/ZpoZxH42gdIp8TuPYrGuP6FuA3RZ8IRv5wTsR9qrSAp
 N49D24rVfi/ojgwHo7m1pHSb8nUxGctR341lPAuESToT+dg0fy5zoyTceAdqUs8gdPFg
 OQBUzlrvJUAlLuckqMNHvC4ha+dVaTbCwXAcvFgkMv11zQS+jZXXQki+03Afnetfo73N
 M26wyTSkVxkUfV0qQPR8UVbWaHuPNVkiiySCCcYC+kSWIiiTQwGZWFJVZWoYX90OZqDj
 RhTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFaL3wHKSRY1ytdMmGTOpsWra8Ol+Lkt+iAlBIgsSSYyUbIGITgHMkgJ7TfUbc01FvRKuhrTqN18ZpxTP5uAEK1YbfzA==
X-Gm-Message-State: AOJu0YxErBIY6qibXo4ijspf/+trdjY45JwPDasKRnDIjgQKfq6Zj7Qy
 AvzIzIWElrLqvjEAYlKYALmhnbXXJrH00x/ZD+Y/Wfi6g6heDaAa/hv2KhLb6EA=
X-Google-Smtp-Source: AGHT+IHMyyAwLNJ97C0RvZjtwAmqsm8P7K5tOCL0ZIucffVUHR/j6dcjdDqbsnIVR/DoDZq7bS1gZg==
X-Received: by 2002:a05:6871:5b0e:b0:24c:4b62:a5b0 with SMTP id
 586e51a60fabf-24c68ada61fmr5805940fac.9.1716479000862; 
 Thu, 23 May 2024 08:43:20 -0700 (PDT)
Received: from bill-the-cat ([189.178.170.52])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43e09f7862asm159679271cf.91.2024.05.23.08.43.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 08:43:20 -0700 (PDT)
Date: Thu, 23 May 2024 09:43:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 00/16] LoongArch initial support
Message-ID: <20240523154317.GT2568172@bill-the-cat>
References: <20240522-loongarch-v1-0-1407e0b69678@flygoat.com>
 <20240523152540.GR2568172@bill-the-cat>
 <36b2a4a8-9a37-44b8-9630-bb48a862e60d@app.fastmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kSRCPaAM7KgJsSNU"
Content-Disposition: inline
In-Reply-To: <36b2a4a8-9a37-44b8-9630-bb48a862e60d@app.fastmail.com>
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


--kSRCPaAM7KgJsSNU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 04:38:52PM +0100, Jiaxun Yang wrote:
>=20
>=20
> =E5=9C=A82024=E5=B9=B45=E6=9C=8823=E6=97=A5=E4=BA=94=E6=9C=88 =E4=B8=8B=
=E5=8D=884:25=EF=BC=8CTom Rini=E5=86=99=E9=81=93=EF=BC=9A
> > On Wed, May 22, 2024 at 04:34:43PM +0100, Jiaxun Yang wrote:
> >
> >> Hi all,
> >>=20
> >> Sorry for flooding the mailing list recently, yet another huge RFC ser=
ies ahead.
> >>=20
> >> So after working on MIPS, arm64be and Xtensa I'm now on LoongArch, as =
suggested
> >> by=C2=A0Heinrich.
> >
> > My big feedback here, and it applies to all of your other series as
> > well, is to please update CI to make use of and test this. On the Docker
> > side, update tools/docker/Dockerfile as needed. For Azure, you can tell
> > it to use a different image and then follow the documentation on
> > https://docs.u-boot.org/en/latest/develop/ci_testing.html and for GitLab
> > you can at least use their "linter" to make sure that your additions
> > have the correct syntax. Thanks.
>=20
> Hi Tom,
>=20
> Thanks for the feedback, I thought CI is for custodians only :-)
>=20
> Do you mean I should include azure/gitlab pipeline file to create
> pipeline for those new qemu targets?

Yes, just like the rest of the QEMU targets.

--=20
Tom

--kSRCPaAM7KgJsSNU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZPZA4ACgkQFHw5/5Y0
tyzYJQv/TpLxAnJwmcrN4ycAFQ4f1CJLoLpPpU75jtad9UN5EKZ4sb34as/Rk3f9
fwknMZEvOWOpXUmwiIAlB0tAglNQRCSmzeZGmbH6Wkaz5wpUhUDjnaSrnwXJNUCh
USF4IMNh5/lk5L9Z7vJ1UG2CZwZCyDiDp67Y8VytLdUkVAzFpt1L0YYl4LA5z0nn
vmJ6ltbBnCZ8qkcyTmDJlKwEcVome4cymu/4Q2tzgF3IrAX86GeV987rncvxAOVU
fLMfIQQXWyBLwMXCtcLrEDLIpHerYWrtBQGegje9R1so4FFWhsrZkrzjEEbDhpkQ
3X9obcQkUJSGMNgvCeP6J61We0mVtp7Lp+CiIg/Bm+gaD8li6rHJFYiZWSZv67e0
uH5JBKEFQKLyPTOAp8o9bKiHszVpkgF3oTOrT2LC//486ZGjWkivFFW7UFPLIv7d
OhI4P2VGDzGzn9UzNcfoRi4yhabnsMLgxBT7QA+sXMXsq61G4CdsOk+LqWS2JeYY
/rp7bhIg
=3Tlz
-----END PGP SIGNATURE-----

--kSRCPaAM7KgJsSNU--
