Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D580C83F26
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 14:26:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD77E801DD;
	Wed, 30 Jul 2025 16:26:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="I4nBA/1z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 947FD803CC; Wed, 30 Jul 2025 16:26:32 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAA84801BE
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 16:26:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-2ffa8e58654so3641183fac.3
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 07:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753885588; x=1754490388; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aFjIiuxeoCWt34yFhogv2mADXDdHIIAXac8l5wGy6/0=;
 b=I4nBA/1zOCDvuPB/SIscPHtVzi0rQlu+S4xVEkkljI4qr0kg6tsTsClFpct0uvFBE2
 h70PmeA7xLkID0QSP/ZLIH3P3zhSsUNsjnfZGGV+4HGFAnNb4Rm29SbgdDFFlgBYDaIo
 vd8zXi5nKuL1HFETE0TpVpc/XHp0TkapRkdWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753885588; x=1754490388;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aFjIiuxeoCWt34yFhogv2mADXDdHIIAXac8l5wGy6/0=;
 b=wt4t4dyq3Fb2fogrRq0KhVhKWtbQGYf0FLULmjoq9EGAMPVfeZPZtz1fO0W8Tm9+dW
 SbrBYT8KawqvcB3P+8SxNU/+ATrjNNB1iLHqbYSWAbPaP4JaSS0qv8Jrp7+xL/EDCs6d
 1wtvVOTG2/1FH/bkpxJn1KrtNDTtnCSws8XPE+2Ao9C0coH47eAXdAJP2DolC46AKvY9
 f2CkAFegtrRSlq79NVNjI7MAWKQECih7Vpz0p0PYXUzOPIbBr6ExOWFubMygqNvrzqoQ
 eW7v6YZ5dslmjvNFBGOVWVKioHOrqJs0BQhoC1Q458Qel2mVkbGZLmCFXtx2Gb06HP18
 lGWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNsJHqvWdtXuqsar9Yox5wRkIH7g15D1WVaOKE9NWcbWwbhLGDDBnGJ11nUQ4B0gQ+5bWA2jg=@lists.denx.de
X-Gm-Message-State: AOJu0Yyb1mMqnDd/PyqRWWnJFjLzvyZNB+yuKyKTrBzKXvYLrQ3H1VlC
 nvbFTfQK2Nrh3L/qpDqpBL6Xturyq9MPtiujqDrvt9UI0NjkF5mR2S/pIHiTNaLRo4E=
X-Gm-Gg: ASbGncv+fHjUf1XIO2sOqp20JxD22DZVraO1AC2aqu5Je55W2Tjz34foRFcTFC/Y68Z
 2V5kTNrIjl4/6ftvEB01fQTMV7n4U9cArnx8Oxz+ZxXNpM89onf9FKd9F39jf6/3KUo0MZUGhFd
 0R/hCkSELck2A2LTjKgM58pnbuQ2mtC50TMXxuw/iv25Nu1R9pzlK65x4c6xRjkDLkMqrDMimXD
 KqFbWfZ8GtzJUpiple3HF3vEDEdw9Fr6GykqcfrsUd+LFAa16Rl07zcOI3x1bW9Z26UqDe1ytMX
 d7tR8qZz29DeYnrAfU+Yr7ruAyNyjRljvkszrw4wlAMrukvG3foqpFTsjYOEMIe2goFMxxHEoKp
 T3Ah6C9mo/84nZ9K42YpqY1Nb9lWkH8V0/K9sfVFpkCf92UgThiWYUc7Wex8UaFWO3c0=
X-Google-Smtp-Source: AGHT+IHSpz9hSgJtxPirv5gOU0GmY8C462lpR1WQXESgWgX3oNYFP3zpmnOW8+WyNcd5YuFIaiX3YA==
X-Received: by 2002:a05:6870:d1ca:b0:2d5:b7b7:2d6e with SMTP id
 586e51a60fabf-30785dd920emr1991727fac.38.1753885587780; 
 Wed, 30 Jul 2025 07:26:27 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-30713592187sm2896645fac.22.2025.07.30.07.26.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Jul 2025 07:26:26 -0700 (PDT)
Date: Wed, 30 Jul 2025 08:26:24 -0600
From: Tom Rini <trini@konsulko.com>
To: Wadim Egorov <w.egorov@phytec.de>
Cc: Bryan Brattlof <bb@ti.com>, Garrett Giordano <ggiordano@phytec.com>,
 u-boot@lists.denx.de, Daniel Schultz <d.schultz@phytec.de>
Subject: Re: [PATCH 0/2] arm: dts: k3-am62a: remove GP security variant for
 AM62A
Message-ID: <20250730142624.GO1807455@bill-the-cat>
References: <20250729-no-62a-gp-v1-0-1dbdb4469ad3@ti.com>
 <03e3be58-3c69-407d-8bf8-3f90e6b19e6c@phytec.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/KgKxVjmOCoLm4zh"
Content-Disposition: inline
In-Reply-To: <03e3be58-3c69-407d-8bf8-3f90e6b19e6c@phytec.de>
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


--/KgKxVjmOCoLm4zh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 04:12:48PM +0300, Wadim Egorov wrote:
>=20
>=20
> On 7/29/25 9:36 PM, Bryan Brattlof wrote:
> > Hello Everyone,
> >=20
> > The AM62Ax was created right when TI was shifting to their high security
> > (HS-FS and HS-SE) processes. During this transition a small subset of
> > AM62A parts where configured to use the old "GP" security for internal
> > and for select groups of partners but never sold for the wider public.
>=20
> I guess I will need to update my hardware to an HS-FS device :/

Did these chips then get sold to the wider public? Or just distributed
within phytec? I'm wondering if we have another i.MX95 A0 type situation
or not
(https://lore.kernel.org/u-boot/PAXPR04MB96443299A51764EE05533DE0E224A@PAXP=
R04MB9644.eurprd04.prod.outlook.com/)

--=20
Tom

--/KgKxVjmOCoLm4zh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaIorjAAKCRAr4qD1Cr/k
Co6QAP9S0wUU//sCzsCkJJkApqF/YqNFqiw59Do27+s2OkJmfgEAxyVw8FeESkWq
VzsIRdV470OXQ0NvHHjBABxTp5q6ugY=
=New5
-----END PGP SIGNATURE-----

--/KgKxVjmOCoLm4zh--
