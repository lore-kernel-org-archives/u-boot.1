Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98033E67485
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 22:38:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13963889A2;
	Thu, 31 Oct 2024 23:38:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Vvzo9j38";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B0A8889EF; Thu, 31 Oct 2024 23:38:05 +0100 (CET)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B89D889A2
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 23:38:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6cbce9e4598so8460766d6.2
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 15:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730414282; x=1731019082; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=o5xfSuHjJya1yp3MGV1ay5FScKsdxIrcTJCSPMx25sA=;
 b=Vvzo9j38OcLAcfSC0xmHz1LGeUm1LbmXt7+I0J0hP1TJQVEu1LdPxANgdfysZDOiPo
 n1QoWWR6Sjs0BVBPylX1o4W9nlZU42aG7DU1imGjDqFh9ORSK7XjypE/ZIDO+We0LHto
 I1AdkOL+xyFAow4Zzd8KgoVq6LvWhjXZ3k2BY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730414282; x=1731019082;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o5xfSuHjJya1yp3MGV1ay5FScKsdxIrcTJCSPMx25sA=;
 b=PKizbo2xH0OsvYR4eqaqD10DtUTuDXnnLlU6LkA1xuOu52mPSzjJbb0pq1aCPu+cbD
 OPXkNC0ABJEsMWMdHVXh314cBhPxLzS5IrBfggN958cc0iB6iB3cjypIk7xrDxB/Ekju
 2+2I91DrHX/ghUfu7JPpJarMWag5tTHetbO0qYt+IY9Bvn7ETScw+Ck/L5LNZyX9Lz35
 cIM2y+GuSm4fhx5ZpvnN+RNLf4ujnYMLN2uJWsCHHNETP8C+hjiqt7GD+P4JIG4JgfHV
 /EzjdPw1DaBKnJ+FGPU2s1uW7LdmbWr/w67QzuA4KoCtlfZRvqTzE81wbeKEOtxGFALu
 NBeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWktLujiOmnSV1Iha47BahzhpVgg5pYxBSWMayud0H9mRHToEVeBvk4eyk/3EbMVpJztv/9dj8=@lists.denx.de
X-Gm-Message-State: AOJu0YzqlaLbCGCO35y3h2gO3jCiUerciaMD7JXtbORmbVzQ/4yAm0by
 /WB6c7UfViZamaeJP7kpWAzGHtXEh/417SEghLjbzEdzBoXmnwUi1RHBIVINrII=
X-Google-Smtp-Source: AGHT+IGXfxHjclYhNmc9d4A3zwnL7KTrqR8P3RLFLeDm8ctddC45ubgFF6CzBhBkI4zNkpOBvU6GuA==
X-Received: by 2002:a05:6214:4a86:b0:6cb:255e:61a1 with SMTP id
 6a1803df08f44-6d35c188ff3mr18315256d6.41.1730414282085; 
 Thu, 31 Oct 2024 15:38:02 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d354179f1csm12575736d6.124.2024.10.31.15.37.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 15:38:01 -0700 (PDT)
Date: Thu, 31 Oct 2024 16:37:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Levi Yun <yeoreum.yun@arm.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>
Subject: Re: [PATCH 10/15] efi_loader: Add support for logging EFI calls
Message-ID: <20241031223757.GI3600562@bill-the-cat>
References: <20241028124815.47262-1-sjg@chromium.org>
 <20241028124815.47262-11-sjg@chromium.org>
 <A00AAF0F-5E6B-4DE3-B18A-DD564026D3A8@gmx.de>
 <CAFLszTj9EhCKkxjBotx-CvuKjuV2T7C6CyJTpHB59nerLavKjA@mail.gmail.com>
 <00941595-FD52-44B3-B618-CCC43F7342CB@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8T93rPblaEHTZ3wy"
Content-Disposition: inline
In-Reply-To: <00941595-FD52-44B3-B618-CCC43F7342CB@gmx.de>
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


--8T93rPblaEHTZ3wy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 11:30:58PM +0100, Heinrich Schuchardt wrote:
>=20
>=20
> Am 31. Oktober 2024 19:01:47 MEZ schrieb Simon Glass <sjg@chromium.org>:
> >Hi Heinrich,
> >
> >On Tue, 29 Oct 2024 at 23:32, Heinrich Schuchardt <xypron.glpk@gmx.de> w=
rote:
> >>
> >>
> >>
> >> Am 28. Oktober 2024 13:48:01 MEZ schrieb Simon Glass <sjg@chromium.org=
>:
> >> >The current logging system suffers from some disadvantages, mainly th=
at
> >> >it writes its output to the console and cannot be easily reviewed.
> >> >
> >> >Add a dedicated log, storing records in a binary format and including
> >> >the result codes and any return values from each call. The log is bui=
lt
> >> >sequentially in memory and can be reviewed after any EFI operation. It
> >> >could potentially be written to media for later review, but that is n=
ot
> >> >implemented so far.
> >>
> >> An EFI specific solution is not a good approach as it does not scale t=
o other parts of the code.  Please, implement a log driver to collect the m=
essages that you are interested in.
> >>
> >
> >I can do that too, but it isn't as easy to programmatically parse. I'd
> >like to track what calls are made and understand better what is going
> >on when Ubuntu boots, etc.
>=20
> What makes calls to log_debug hard to parse? We have __FILE__, __LINE__, =
__func__, and message text available as individual fields.
>=20
> What information are you missing?
>=20
> For tracking function calls we already have a trace capability in U-Boot.

Integrating EFI_LOADER with existing U-Boot logging / tracing
infrastructure sounds like a reasonable path forward to me.

--=20
Tom

--8T93rPblaEHTZ3wy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmckBsEACgkQFHw5/5Y0
tyyKiQv/dkQ3hQamVbmiFZgMsEUT0QU4yICpBoRo0M+RAZzRe/L8xvsHs5ohaXXz
1fFhhiiyEtcRLQG2vZ3QBBopZ2CIaEV9hrkLhAkIilSS2ZKeyOUeOc0geD8kjNDa
AzSFgAXSm4jVQPmMoocs9wE2bro7UMNDCDIs3z29PH8frMJv6TuiZV/HdLwAdsr7
KJEpJ48YRq9BpRgqfT90LGPWQtsBHxSibV3noVV8QNuPLQezR1t/H/IJZEgCZE3h
MG4UeKkS5aCpd5q5z5qsnQscJKzZ/K+TSaGhxxS+M9+j8t0dUe9b05FQy6iybps9
AKzcs6XnpG7FlqrZaCTY/NA/3PkrdnPOiLUMK2T4lVlsL+WKI4jaRnzWLrR90ggB
GVEggXgzg270r33HeOv9SBOaJMqzSyk8tH1IOaaXWw64SJnDY1hKPp7G505mJVE2
aBBMHtZ/tCNHqiilsmF1E2QUqds3La6Wo04XNoSbQPIAtMKxrqM2NnlxUa+7EE4E
Fs6SaWu1
=MC4C
-----END PGP SIGNATURE-----

--8T93rPblaEHTZ3wy--
