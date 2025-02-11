Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C3B8C0219B
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 14:08:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCB42807E1;
	Tue, 11 Feb 2025 15:08:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AQ7YQQk8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7716980842; Tue, 11 Feb 2025 15:08:03 +0100 (CET)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10136803CC
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 15:08:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2fa7465baceso4212691a91.0
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 06:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739282879; x=1739887679; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kyzFnZ/euEEEYnPBRgeAbCYWBDmLkVWKngAHO8NF4pg=;
 b=AQ7YQQk87ef+Z1/p0JcJ7zKG/iCIUmh6xRIHpDJekHgGunMQQ6hlSaURWBKSR39Q/j
 CuRQacqqZTP1yIyEnbG7hmhFrJREYb1XPbs+PG9X9VmUHPsbFJxLxCmeBtY7Jo396M5m
 SbpdUpN1D2xr9XiAxa/TVMfaM+LF6qUFvFh9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739282879; x=1739887679;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kyzFnZ/euEEEYnPBRgeAbCYWBDmLkVWKngAHO8NF4pg=;
 b=Rh1/0I7w+5h0sllEqqVp2uiv0eiJPCj0r/Bga6hj4NP7q16kCE6TomiUyScgZiNsTp
 ykHF31X/wmMQZ6FhdiFwBNkGpFhDdk3/iFmWKkN99aESSN1doo1E9XwddyoZFFTebOe0
 thsOjbVBzJFlGK4Gr8eEaqG4VDwRIDjyRfWdiFBqyW1fvT3dyUt50bhsccMWVfbwlCtH
 2/ycTYX/PZ1MR0RbYc/r7OnYsbdTHaYuNxO7zCfkFogG7LNSsIRH49nea6wvUT228bKO
 AX4SfTyASLZiupUsQp3x6tZ0UxeGdC3Y1rXRYDqBkOlpuUpGm7hrJbiPX4N6NP28hr5U
 KWCQ==
X-Gm-Message-State: AOJu0YwL3tNR0L6aufrAUYmQ3iKetXk/ymU53LEbUjGjPCMk0/PbJAoa
 Vz1+1YZxCdnzh/BPdPppfnYFnabV7yuIxiDKreYFTqyYb9FYixLPQ5FuYonKN9c=
X-Gm-Gg: ASbGncsiKtZCWOpyjP8c/YTRFq6z4TbdMYcMYbT5UYsfGe+f4NJeAMyjEWhOoTc6qN9
 CX/Lh9tLfolheqIyqwcIGX7nS3Qq5KFzFZcoHF3mXue4/eitKp4qxOb+Ys+JLfouPl+zhujFACG
 lA1v+Mn9fk0blOS66jvikEjqtagvMMkdHDiWcqg1fJsKx2KJylBLmXbopdVQjl5chAqLlB5V5/q
 r0Lliu8H29K8R4K4SM8lwe5PAl3bQtZCWzlbTqK7nXYGG8DFmbDIR17nVd8NtPck5ktnSmtAUA9
 HKR8t5ulPKkgNYU=
X-Google-Smtp-Source: AGHT+IED/TU3pFGr5OwAfChMWU85ZMtkPJlgbYQWz15EmPK/4qoueaIMZywWYQ6582to7XyPLnLTcw==
X-Received: by 2002:a05:6a00:1798:b0:730:8e97:bd74 with SMTP id
 d2e1a72fcca58-7308e97c379mr11977879b3a.2.1739282879390; 
 Tue, 11 Feb 2025 06:07:59 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73048ae7f79sm9440495b3a.77.2025.02.11.06.07.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 06:07:58 -0800 (PST)
Date: Tue, 11 Feb 2025 08:07:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alex Shumsky <alexthreed@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Joshua Watt <jpewhacker@gmail.com>, Levi Yun <yeoreum.yun@arm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, Stefan Roese <sr@denx.de>
Subject: Re: [PATCH v2 35/35] bloblist: Allow using a different bloblist
 address
Message-ID: <20250211140755.GA1233568@bill-the-cat>
References: <20250209211502.2299245-1-sjg@chromium.org>
 <20250209211502.2299245-36-sjg@chromium.org>
 <20250210143312.GB1233568@bill-the-cat>
 <CAFLszTiX-rNzEmrLOZ4PMMa9m3fHiLkchbJ=xtGh3RpZLmZ6Cw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QKdZtRgEKYDc8UsR"
Content-Disposition: inline
In-Reply-To: <CAFLszTiX-rNzEmrLOZ4PMMa9m3fHiLkchbJ=xtGh3RpZLmZ6Cw@mail.gmail.com>
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


--QKdZtRgEKYDc8UsR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 06:09:03AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 10 Feb 2025 at 07:33, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sun, Feb 09, 2025 at 02:14:56PM -0700, Simon Glass wrote:
> >
> > > Where the bloblist is located in internal memory and TF-A's BL31 blob
> > > removes access to this memory, the best option seems to be to relocate
> > > the bloblist just before running TF-A.
> > >
> > > We can do the relocation in board-specific code, but need an option to
> > > pick up the correct address within U-Boot proper.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > > Changes in v2:
> > > - Move the actual relocation code to a previous board-specific patch
> > >
> > >  common/Kconfig    | 20 ++++++++++++++++++++
> > >  common/bloblist.c | 15 ++++++++++++++-
> > >  2 files changed, 34 insertions(+), 1 deletion(-)
> >
> > I'm going to NAK this whole concept. The whole nightmare thread about
> > these platforms comes from using a fixed address. We need to pass in a
> > bloblist or see that one is not passed to us, via register. And then use
> > that mechanism to pass the bloblist to the next phase. When we don't
> > have a bloblist passed to us, we allocate one, and not at a fixed
> > location.
>=20
> Well I understand that Linaro may be doing some work to head in that
> direction.

Are they? I don't know. I know Raymond was doing some clean up based on
the idea of treating bloblist and standard passage as two separate
things. Which I think is a terrible idea, despite suggesting it. But I
think it's also the only way to make progress now that you've decided
you can't work with them anymore.

> The 'piror-stage' stuff is what has made this all too hard and
> confusing. We should think of things from a U-Boot perspective and
> make that work. The new case can be handled by standard passage, along
> the lines that Raymond suggested, i.e. just checking for it first.
>=20
> For x86 we don't need this path as there is no bloblist in TPL, i.e.
> it can be placed in DRAM from the start.

A fixed address is a bad API for the U-Boot case and is what makes this
all so confusing. And no, we can't put it in DRAM on x86 either, that's
what had coral broke until I put it back in CAR.

Please explain why a fixed address is a better API than passing a known
valid location via register, for the U-Boot case. I don't like it
because it means that we cannot always safely check if it exists.

--=20
Tom

--QKdZtRgEKYDc8UsR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmerWbsACgkQFHw5/5Y0
tyxjOwv+J0aiXbxBRB/mcne4r3DR3LEuyw1bf+lOJPN61+P3umNZN47cQwvBQSNK
h28xGVxDoXaCZlU3J0TvWJ7e2jd8kFBUxGjV23+nilXKsr0Fydg1RmQxNsD1gKsv
6QHgmuIbjbK0l1H8hC89SKoCsv1AqgORyqnNpvvYUj4inn9bXkLC8JSaCV0dzXLV
4OxiCYk3/uQ3ZZ+BGTkSDkyvTq6MaGAUcJc3ABqFdGCnHBqLz9sl4Pq0JTpOZ6JG
qzbd4qVomNbzHS9zb7zmqNBlD1G1ZPNaV0WjDxhFgEBm/w7yvdvhdAFlTuGKpCGR
YM42JYhSwzs7C087Pg1w0J6hRAkl7D0SdeIgomG2tA/1ulXtHoCMn81Qqy0vd5Ko
CpfiUu1T+WMnpMURQoFh/t2QXCaUC805OduSCAQRcOOi+9r8qxO/CUX8DrB91hCG
ZpJVPkAjanZToNw0BgAsaeUMum+3Xzg/AJCchsnMXKy5QFKGW4QwQZYTGHZ8by8F
rvW126vy
=2zbf
-----END PGP SIGNATURE-----

--QKdZtRgEKYDc8UsR--
