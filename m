Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88DBBC83F22
	for <u-boot@archiver.kernel.org>; Sun, 20 Jul 2025 15:11:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC45B80C93;
	Sun, 20 Jul 2025 17:11:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NpIyjfo6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D824829E7; Sun, 20 Jul 2025 17:11:21 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41BDE801DD
 for <u-boot@lists.denx.de>; Sun, 20 Jul 2025 17:11:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-615a4b50215so1224171eaf.1
 for <u-boot@lists.denx.de>; Sun, 20 Jul 2025 08:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753024278; x=1753629078; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2ZPuo67n8pfaNdchQ9Lw8TIzN0Ia7OR/OgVUgh15uaU=;
 b=NpIyjfo6oKvzqDcAwM8LA37seN/S32Q2bTFAPeyUCPRrYk/MSA/XNWKToSviPYASl3
 Z++XjqRHuA5bArN0maUy8LbTktbL4yg8zEeFjuy5M6zhkEwo3msay+T6WDokWMDGvvdZ
 D3MnCk7YVP7vnUxbSfaTODgUuyMNzMSqeE138=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753024278; x=1753629078;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2ZPuo67n8pfaNdchQ9Lw8TIzN0Ia7OR/OgVUgh15uaU=;
 b=l9N9vp8/YK75Q96hCDDNSS70tTD0mSW+sJtmnbso6ukDH+slR8ovaWTcnieF4nQfjf
 1kjpNtnkTlDML2+GpnGk1BBbS3waE0rLBajc9FTZtIZPxOlHiYgBm2j+5uQWUQL6W3po
 zN7FMBZJ+u3nwY+w1dSGLs+GEI/r/tOa4szTgeMbSN4BpuUWPXf13w8ajZ9wEm4OOPkQ
 tgjNcQVbg/zDaPqaZvImgEyi5xB1LnSWjYjG7sdnvMcq3j7/tKsCgFWqHGFmGfwU1WOu
 ik6RvL0Hl0IQZgvmPX1AqGc5j74qfHqUfaazl8VD239wNEDRiiiV/U3/ySsslBvtv2P1
 CR8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFZyExcXr2P8754LA1rc9eZokoAeVniHCZAqXOizG1kapPinY2wfEu3Gfyq3g67BMqr5PvHuc=@lists.denx.de
X-Gm-Message-State: AOJu0Yy7pVha1cKHUXfNvMc9LykjpsCy4y6wdwymQYepuWNQLnsrvhaO
 dFwmcJFwVbCPM2+CUcOsDn3R7NfXsMIzSdYBxkeyuuYtHPjxZIPMdYlVWKTwG98EgrU=
X-Gm-Gg: ASbGncv+nhQKII80iJ5GPvJAQIehO25CJgCYix7FS/H3gRsUr04LzYht/kIV+mMBDLu
 bHo1DhEvnSF6qhrfBcbBy2DDNs83yaHDpMP5Y41Y91ITkxNM7ASo9FVwpOhqaW9Rl+NMZcQ2r0V
 kr74JxyoNbpTHKXIRJSXsX3F8igpNg5/VsC6UpCzvwMtR+DWhxdqbITmK48JNGWXyHwH3VUts9J
 hgd+4UoK3ElQGL2ZYuISIEt/EicL2kzQlCSnZ9I9LrO+ZNl6NS8qj405zlBl3kuxJrQt9i3PkqY
 LJK9aPgAMAc/e3dFYsTDWSJytvHrIUn4k2rSQJebOs1LeiYYRe2Cxd8nUO6yAOdXqAAlnviVKVX
 5C33T78WgQNztgE12/NK0fGVWPnIVwe/F0+p6EYjLt6ff3AERBTpr6wF6
X-Google-Smtp-Source: AGHT+IHgXLbxWJvwU/dfWg1Ow78SlZsklFYRkWYdEvAoKRy3ZuL3cIOkALN143DgIMd0AogPSd9Tow==
X-Received: by 2002:a05:6820:4b87:b0:610:fc12:cbb4 with SMTP id
 006d021491bc7-6159fe1ef24mr14130945eaf.1.1753024277944; 
 Sun, 20 Jul 2025 08:11:17 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73e83be2689sm2141653a34.63.2025.07.20.08.11.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Jul 2025 08:11:16 -0700 (PDT)
Date: Sun, 20 Jul 2025 09:11:14 -0600
From: Tom Rini <trini@konsulko.com>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Sumit Garg <sumit.garg@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 3/7] drivers/reset/reset-airoha: add support for airoha
 en7523 SoC family
Message-ID: <20250720151114.GB193579@bill-the-cat>
References: <20250719005717.113842-1-mikhail.kshevetskiy@iopsys.eu>
 <20250719005717.113842-4-mikhail.kshevetskiy@iopsys.eu>
 <20250719145757.GY193579@bill-the-cat>
 <0cb84343-d12c-40f2-aa24-710e1d254928@iopsys.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1vV5T9jkppD0bP/1"
Content-Disposition: inline
In-Reply-To: <0cb84343-d12c-40f2-aa24-710e1d254928@iopsys.eu>
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


--1vV5T9jkppD0bP/1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 20, 2025 at 02:57:34AM +0300, Mikhail Kshevetskiy wrote:
>=20
> On 19.07.2025 17:57, Tom Rini wrote:
> > On Sat, Jul 19, 2025 at 03:57:13AM +0300, Mikhail Kshevetskiy wrote:
> >
> >> This adds reset controller support for airoha en7523/en7529/en7562 SoC=
s.
> >>
> >> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> >> ---
> >>  drivers/reset/reset-airoha.c                  | 63 +++++++++++++++++--
> >>  .../dt-bindings/reset/airoha,en7523-reset.h   | 61 ++++++++++++++++++
> >>  2 files changed, 119 insertions(+), 5 deletions(-)
> >>  create mode 100644 dts/upstream/include/dt-bindings/reset/airoha,en75=
23-reset.h
> > This is not the correct form of cherry-picking an upstream binding.
> > What version of the kernel includes the required binding, to start with?
> > Thanks.
> This comes not from linux. I write it from the scratch.

Then it does not belong in "dts/upstream" and you need to also be
submitting this upstream. We can temporarily take things that're being
added upstream and not yet there, but if there's changes in the bindings
we aren't going to maintain backwards compatibility either, so it's best
to start upstream first.

--=20
Tom

--1vV5T9jkppD0bP/1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmh9BxIACgkQFHw5/5Y0
tyyTlwv/RhflohHjZYuxotahN0wCxoQIT7lKT4/sTPBQNCT6ZGRmY5O0844A5bJD
BOnI5rOd8hSxVm2Dr2OcLWluZ5vQJBfFpmm1xbBv8smtLdwiWcLdbxi2kOFl3mgF
OuRSLGKBsHh4GiTVRVrCl/toHJ/roGQVDFUM1y03x4RpV9cX4X4+OlGX+u8wB8js
UJWeJ+eQjTseYPt69+pCqeFWV9r/FvwWhGs18Nt/ANIkZKMTVWzCnBsWKMj/rPEx
HW5cp7nVcjKVoNjh2w+nUdGSCDb7KPG+9IsLmOok/jqGZm8eGQNYppbO61eH0rIm
zN7A3Mzv6ZB/NKxW5cVHsN7Qsno1uqHQfs9ruvLserd+/BeUMlwOY+fpYQjYMH+L
pW6CvdjoDo75zohj7PckIy1RFRJVg/QWOAdRHaqBElxaZmDHs6k/JY909JPsE3tR
MXDUapIWQ9NBX1X2ejEmUDyKIwRka1+BCLpEnqZg5c/VRu7zjYcsHiKh92wNVNjs
8myVyIFT
=zl7b
-----END PGP SIGNATURE-----

--1vV5T9jkppD0bP/1--
