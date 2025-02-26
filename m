Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 976C4C021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 14:22:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14481807EE;
	Wed, 26 Feb 2025 15:22:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qHS1GSNG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67261807EE; Wed, 26 Feb 2025 15:22:55 +0100 (CET)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44FA58006D
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 15:22:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-4721bfdb565so91545241cf.1
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 06:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740579772; x=1741184572; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JQMhnjtB+cwP+ePVB2GDvVf2bsSitclemcVIyDXTdaI=;
 b=qHS1GSNG4tTjnJohBm8mu+wAzqYbfKIvCA9Po5/Fx06HcfxE43Abb/tfHFSHi78o4m
 S8y65VfqlwRnRNbEoxLDPD+bkpy+bBnBulqM5xPku8loIwcDuaLFXwQQiyy4SBeFF5dW
 aHQhxiC4rsv5OHRcpW+CTsrHK1Ev4O3rmntOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740579772; x=1741184572;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JQMhnjtB+cwP+ePVB2GDvVf2bsSitclemcVIyDXTdaI=;
 b=Se811gdux7mCsAaQBoLIkYGek0XbBZpAjqonv6T657neMwsLmR6S+XSxkvE0LEEcWN
 oa/JPv8OsERscW6xA9lCxJ5yznAFBtwOS9KRF3jYHoD1VQScou9B89bFMExfcKyW2P1K
 uMz5n4ZsyxI8N2WrDYxVYQFZJsiI6hx5yWUm1+SObwLXEoxF6rUBONF1l/Esee+C72uV
 /dl4K2kToLvzD1MKiESLFGUOJjW3AJA4M3xnOt2lLANJZ1J+1tOcmhkhvEXVM+V64Bst
 +HKKdFb26VyO+CtVHeHEGscQAaXj/4SaSnmzgdR/zcSL6Mpu+pdekubZ8FYhMS3eSZ+g
 Nr+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXR+I8kF00nnpj4AmNIrNHePekbCnV6GnV6QFxruWWb0O9nr1A2nRSewD/YJCiGsRhfwTDmJBI=@lists.denx.de
X-Gm-Message-State: AOJu0YzGW9BTYBRTkfBiapNC24bPsoLCuZmlogXIfH71FKkSNU9Nq2Zw
 tVkfctBwlBFGinuNIOXxXOHtO6jJYXsRXUbURovK5B4wPI+BvSuxIzJ/GTh8Q+A=
X-Gm-Gg: ASbGncu9VHW29lgQO5TKfPpwOad+liCLyYvyYBNsg+r/JIqAH6pOBr14mCy/OIexG36
 sazhO24OxQlSr7zt6d+wfZkIPN5pKjIIYXT+E9bN8jrCS7s/l6QaeowYJV2nw2Bz08nppx9Gh0p
 yVI83Zp2mDX0QZdF2jqwsE0g1kNLADTq8MOHbzK6mx9XWmFTjcNBWbWdpVBOqD3sbilitk4LVHd
 FZ8PMUT137YH6COoWT4XQ6S9ZGxkg2rCRFcwEcXTYsyrHIHzU1YDoSO5ZVDKWRoGaqAxG9PxhBP
 IHM3W4D5enEj8NQTNFvD3N1f
X-Google-Smtp-Source: AGHT+IEjkRsVTe2WOiygmLj0Ak5eREimt3PHhZD9WpDm9ZIbmI5ap9qydr/2Pno0sLHY481TTFa6+g==
X-Received: by 2002:a05:622a:18a6:b0:472:2021:b786 with SMTP id
 d75a77b69052e-4737725c9c5mr123197391cf.35.1740579772114; 
 Wed, 26 Feb 2025 06:22:52 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-47377e238d9sm24927111cf.46.2025.02.26.06.22.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 06:22:51 -0800 (PST)
Date: Wed, 26 Feb 2025 08:22:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Robert Marko <robert.marko@sartura.hr>,
 Luka Perkov <luka.perkov@sartura.hr>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
Subject: Re: [PATCH 0/2] rng: msm: support newer SoCs
Message-ID: <20250226142248.GH2640854@bill-the-cat>
References: <20241125-topic-sm8x50-rng-v1-0-52b72821c3e9@linaro.org>
 <9094cfe6-34ae-42cb-84c1-6965121d1a19@linaro.org>
 <20250226142134.GG2640854@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="R8C4M7p6RC9p0CDr"
Content-Disposition: inline
In-Reply-To: <20250226142134.GG2640854@bill-the-cat>
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


--R8C4M7p6RC9p0CDr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 08:21:34AM -0600, Tom Rini wrote:
> On Wed, Feb 26, 2025 at 02:07:28PM +0100, Neil Armstrong wrote:
> > Hi,
> >=20
> > On 25/11/2024 18:12, Neil Armstrong wrote:
> > > Add support for RNG on newer SoCs which shares the
> > > RNG hardware between different Execution Environments (EE).
> > >=20
> > > Also enable it by default to fill KASL seed when running Linux.
> > >=20
> > > Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> > > ---
> > > Neil Armstrong (2):
> > >        rng: msm: add support for newer Qualcomm hwrandom IPs
> > >        configs: qcom_defconfig: enable RNG driver and command
> > >=20
> > >   configs/qcom_defconfig |  3 +++
> > >   drivers/rng/msm_rng.c  | 13 ++++++++++++-
> > >   2 files changed, 15 insertions(+), 1 deletion(-)
> > > ---
> > > base-commit: dc1859f8d2ac3faaa5e2e1d465ec4bd8980520a5
> > > change-id: 20241125-topic-sm8x50-rng-714cd0012391
> > >=20
> > > Best regards,
> >=20
> > Gentle ping, who's supposed to take this ?
>=20
> It's amlogic, you can pick it up.

Sigh, sorry, too early. Caleb usually sends the PR for Qualcomm but if
the two of you agree you can also send one.

--=20
Tom

--R8C4M7p6RC9p0CDr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme/I7gACgkQFHw5/5Y0
tyxt+gv/bqG0DVNBhGS1LsqcN1WSYw93vRL7y+OGUX14NQttIhYlyRvrfjK3W/cw
G1xmuoTDW7C/QYzKMBot51XjIiLMH6S82Zg9pLipFr4JKRU3HdRzUN6jvLF42m83
bCE6A1xi3PZdto7QdgEdlVC7exUJXRRo5+MMf8bA+UE3cbGJVSXY59RZW6dvPaI7
cafGlrR9Nrj+QM5xEY/iLQ4+IT8sadU35MNlIzdTZDiY9sbh7EX7C1dE7F4yQrkc
Qdg3/NTRQVGjK16hJH++Cef5pWNGOKZ5m0Rw4qLrYT9ILIhDWD+wYd8lHyigXohm
E6gAoDDImbVjjnpRaLD7hHeFIVnSxs9jcalazFvq5SOgUn5b3Nt28B9CBrDW1PfR
3pjGkxrBkC7QJ9nVxLaNn6/H9i7AwMsYWZmssMXhLgwDz6RVLt0KnQrEz7ApVtfU
cfAU+bUmZJWuMVMNY1YNamACvh5zZWPjgMQpHYH+WojZBYl0JYjlGuQ+dMDIMNzm
WAhLuu6T
=ahyc
-----END PGP SIGNATURE-----

--R8C4M7p6RC9p0CDr--
