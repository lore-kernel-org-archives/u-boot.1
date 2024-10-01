Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CD7ACEACCC
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 14:28:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B313088D39;
	Tue,  1 Oct 2024 16:28:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bpr82Ps4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C840D891D3; Tue,  1 Oct 2024 16:28:46 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D5FA88D38
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 16:28:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-6ddceaaa9ddso49191647b3.1
 for <u-boot@lists.denx.de>; Tue, 01 Oct 2024 07:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727792923; x=1728397723; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tOKKzzZmpNzG8zD7QI09Q3JDDY2cYCcdbKfaknGIANs=;
 b=bpr82Ps47XJZ6s+1l3LA5BqWYxiDnEN2BmeDa5KnSk+6UlWpS5yehjJ+IEo2gpndfJ
 BMyciEHuq+80SMunMYdejzKRNRt7JBiry2BPLtpCfhOoJSoYGma0TWxJ02VV9e6e3Kqd
 Vx7NOyLef9jmTB3Ndl2U5OGMjMaUMS1fvED5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727792923; x=1728397723;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tOKKzzZmpNzG8zD7QI09Q3JDDY2cYCcdbKfaknGIANs=;
 b=qtHSTAtmADgDINFNJqtxmo/z5h6a+TGFkBVnQHfKYI1jc+XKJZkuIKKpcACvSGvhqI
 H/0lPHNREXkL/4bay+BVq66jwsH7Zops0amqSXpN6FpNFCXmVIAtyn9xMVmgadifluwY
 tzqRMZ+qWjGHsP364PW9VTtgTFbNHLcZcoHRGVQqHo7k0CcO/+3kpmH0PcxMM0Xis7bC
 DHK2pqj4KIVdAs9m6NYVnPhwF0YTtcbprdRS81wicNvLU/B39cwv+Z6uBGEudglIdUfa
 q8AOfjbQHabRkSoJns3W0UIJOJ5SLKouUplE7cw7Hz4MqyuUrpSPvvUhMFBrDioV5QZY
 CXXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGLb4MZwyZvAUll0Qr/F5vqyzQZwtJepRBHQ/ybAYAeaxHkJwPp+dwTLOTInj8xWuGjYd3blk=@lists.denx.de
X-Gm-Message-State: AOJu0Yxi4funEgCNRbsCAwXGfF5zhkRAqkwZYmty+8IiQHa9ZGPujQgC
 tJw7/8MLmGJB9uTBdFMrEBbbhHaeMAstX5FPwuB5IrSf4ywg4BVX4xUysCnaJRw=
X-Google-Smtp-Source: AGHT+IEI/UeCWhdSjZgOSJFerbUKAdpTBi5egIQbGQ8DLpRfEFsTf/deEQ4GNtFR8Hubn4vAS2b9rw==
X-Received: by 2002:a05:690c:91:b0:6db:b5b2:53c with SMTP id
 00721157ae682-6e2475e6608mr110896547b3.32.1727792923188; 
 Tue, 01 Oct 2024 07:28:43 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb3b69421csm49358906d6.142.2024.10.01.07.28.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 07:28:41 -0700 (PDT)
Date: Tue, 1 Oct 2024 08:28:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v6 08/12] efi_loader: Disable ANSI output for tests
Message-ID: <20241001142837.GD4737@bill-the-cat>
References: <20240926215950.1265143-1-sjg@chromium.org>
 <20240926215950.1265143-9-sjg@chromium.org>
 <08596845-c0b1-4557-9993-cde57420560d@gmx.de>
 <20241001002442.GC4737@bill-the-cat>
 <CALeDE9O0zys8UW+ZoTDoQr2hAJKG+d7AbNpsyMMxdbtVWzFxWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YbQXIhCdyjNXTVyw"
Content-Disposition: inline
In-Reply-To: <CALeDE9O0zys8UW+ZoTDoQr2hAJKG+d7AbNpsyMMxdbtVWzFxWA@mail.gmail.com>
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


--YbQXIhCdyjNXTVyw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 01, 2024 at 08:49:26AM +0100, Peter Robinson wrote:
> On Tue, 1 Oct 2024 at 01:42, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Oct 01, 2024 at 01:38:56AM +0200, Heinrich Schuchardt wrote:
> > > On 26.09.24 23:59, Simon Glass wrote:
> > > > We don't want ANSI characters written in tests since it is a pain to
> > > > check the output with ut_assert_nextline() et al.
> > > >
> > > > Provide a way to tests to request that ANSI characters not be sent.
> > > >
> > > > Add a proper function comment while we are here, to encourage other=
s.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > >
> > > Please, consider prior review before resubmitting patches.
> > >
> > > As responded to all prior submissions:
> > >
> > > We want to test the code running on actual machines.
> > > We don't want to have sandbox code everywhere.
> > >
> > > I cannot see any test that is not passing due to the current behavior.
> >
> > The pytests for the EFI selftests are unreliable for me, on Raspberry Pi
> > 3, more often in 32bit mode than 64bit mode, but I feel like I see it
> > there too. And when they fail, the console log is full of ANSI escape
> > sequences. Is this specific test a test you run regularly on real
> > hardware?
>=20
> Is it possible there's a bug in the RPi support somewhere that's
> causing these issues that is triggered more easily with the ASCI
> codes?

I don't think so, in that I thought I saw it on other platforms as well,
but I don't have the logs anymore. I'll see if I can trigger a failure
again.

--=20
Tom

--YbQXIhCdyjNXTVyw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmb8BxIACgkQFHw5/5Y0
tywAHgwAqMp3u/kQ4PzW6oq/uFiDjXVc8NhXG+3V1HUFUrFu9zF/XyzNGgPF72Du
c9tz9suQ85ceLVHGUoSoyKFBPawDfzR7DhcbgbTSznK1Q7wBm0KfqjBS/8CzaOBz
W+ihF26Zh2IQGEbrPEZW8jfuMNCPqXE8d9EiPka2tUFC8BIoRc5OZ158gsFhA5D1
huJvHWWgSVZspcVZo1LX3HMiU1ys0RJuCm6gbL/Ag7bUWAYbNidjAB9RBSPSeUMB
OzGlChg4Cl1B4xW1iBmsy5nFnuUQHV7eTpxlXHHsFG+/63S8EUVbhKCAuHtuAxsq
+wUfDVF3UaQcRoMEwfHjs0TF+wlcMGCr/nylqAPRD+wV86Bi86i4vUrB7ofaEFw9
wtJgkhodsSvrY8ERVoZvvcc95wdcWY7AJW4w5pCTchU8WTNPWeY5bPFswV1fI6gG
mIvdWV+PjYEfkpFHcf8s1jwANAUfJZvkrIAojuu2DJ7eB6RITNEQgK3D4A1yFS0G
YVy1E9dm
=6vgc
-----END PGP SIGNATURE-----

--YbQXIhCdyjNXTVyw--
