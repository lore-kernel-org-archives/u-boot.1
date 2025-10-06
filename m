Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7067CCA471
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 23:46:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47F7983C46;
	Tue,  7 Oct 2025 01:46:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="utO0MmYi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B4C283C6C; Tue,  7 Oct 2025 01:46:35 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 095E983A45
 for <u-boot@lists.denx.de>; Tue,  7 Oct 2025 01:46:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-31d8778ce02so4948211fac.1
 for <u-boot@lists.denx.de>; Mon, 06 Oct 2025 16:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759794392; x=1760399192; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8attZgdBSr7EbpWDD8Qx4y+MgJ7pD9QUMWj/BUCZKww=;
 b=utO0MmYiARTAv9OL18HK7WqKN4yD5fKj9XblmZ6j3pv1z1UlyWsuLzHkLlLJtksWf5
 9nIb3Pgrx/qLG8AYUHHHJXfMAI2K481KcMnxeRr+cvp0tijN2nwXtLCSeYQG+6foO86w
 5+X5e3V9nk7ZWJNBr6SoYwO6ibUqyFzEF8DAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759794392; x=1760399192;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8attZgdBSr7EbpWDD8Qx4y+MgJ7pD9QUMWj/BUCZKww=;
 b=rDE1LI3m0GKefOYiNgHzdNQcQ6AjS+4dt4GFWU/+Djj7yxDxINnz+JlAJZ9q4DI1KB
 CkvoMVJJnn8WFLzayFpGA/DPPGw+sHWNbzW56nfov+Wc+3Wc8h8gx43Lqvf1J1tNjtl4
 jLYePm64T2uz1E/AieZUmg4LHSVKa6OUSKr3B/ekQokrWZv7unCk4qt7JzvFJSy5z8Xj
 J79e6SeTSOYygGYEClMTc86ukvO/yim/BzmPj2gvOoh4zOc89GL3UXoNdg3RYSA11g+5
 h5EAKHZjYBzy6vn6sDOXR4YNtld5ZjQoT6nAv3TMg5ofcKYObH0jcz+E3IW3yA01S1tU
 i8jw==
X-Gm-Message-State: AOJu0Yzqnr1muxN9cI3U62EpzW5grvadKVhi2awu8EZnUlbufIZn8055
 ni7Yep62EIzT50eMgMVG0xbonWp6mVZ1y/E4OskVvP4AA8Q9VGuyAyUPhIv0jPUt/h7vx/1ygx5
 cwVH9k4c=
X-Gm-Gg: ASbGncsfa9iryfPxZfwMLrwOrtQK3b10KgsDrIg8cy8mzArIZIAJkxRFsOx6KBnI8sy
 ilxiBq0k9yuuSlGmLnF/c731Plcs57+cxJjQGRSDCDJELKpL9fCEb/592giTIWx8G9SsTSgWfqa
 ER3qdNs8oA57Pn3NdH0HduOXAi4FA+95okpPOLByfYIiqnfEgG3trE0DEo9IH/HTFnnO0A7kr4R
 ItdNUVb5X0hTq0NBU/Bqc6Bmi0hC2oPQxVuDcUySPccCmrWBv9Xw/1ioZnoEPD3Oa3V7XG6DT6m
 c+Kq7G/hcNQ3M/5qjLUa9og2jGnWqMHjQBC/eG4aU1m6jkmJpwsbzbil5ZF9v94nbeicbFpZz7F
 YjacAWMXgHYgmvUkgLkUHqHsIWZsnkSzoJh3hpfBFB+p2ctbEz0bjJLsOcQR5bZ/3gm+BFbwjVk
 JR/2G6+r35Sw==
X-Google-Smtp-Source: AGHT+IHw6jgi0a3wPk8tVTq1CS1RG0vOvfCQRxbsbgEkm8fu3k4KuUckNEZ/UjRxZEgFwzufUkxPzg==
X-Received: by 2002:a05:6870:3281:b0:345:ee86:3565 with SMTP id
 586e51a60fabf-3be6a905120mr763212fac.4.1759794391596; 
 Mon, 06 Oct 2025 16:46:31 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7bf3f6104a2sm4206823a34.7.2025.10.06.16.46.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Oct 2025 16:46:30 -0700 (PDT)
Date: Mon, 6 Oct 2025 17:46:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: Re: [PATCH v2 16/17] boot: Run the EFI bootmgr just before network
 devices
Message-ID: <20251006234628.GH298503@bill-the-cat>
References: <20251001212649.3263574-1-sjg@chromium.org>
 <20251001212649.3263574-17-sjg@chromium.org>
 <20251002201546.GP6093@bill-the-cat>
 <CAFLszTiofxAigyXRGp3qREOd6tdjBDyZqkj9vsOu9U-TxCe3Rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qI4ffp4ANvZgYC+X"
Content-Disposition: inline
In-Reply-To: <CAFLszTiofxAigyXRGp3qREOd6tdjBDyZqkj9vsOu9U-TxCe3Rg@mail.gmail.com>
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


--qI4ffp4ANvZgYC+X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 06, 2025 at 05:31:23PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 2 Oct 2025 at 14:15, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Oct 01, 2025 at 03:26:41PM -0600, Simon Glass wrote:
> >
> > > At present the EFI bootmgr scans all devices in the system before
> > > deciding which one to boot. Ideally it would use the bootstd iterator
> > > for this, but in the meantime, give it a lower priority, so it runs
> > > just before the network devices.
> > >
> > > Note that if there are no hunted network devices hunted, then it will
> > > run at the end, after all bootdevs are exhausted. In other words, it
> > > will always run.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> >
> > This does not apply cleanly to master nor next as the test portion
> > fails to apply.
>=20
> OK. I'm not sure what happened there but it could perhaps have been a
> timing problem. I'll try again when I send the next version.

I don't know what you mean by a timing problem but yes, please make sure
to have something that's on top of master and documents any
dependencies, thanks.

--=20
Tom

--qI4ffp4ANvZgYC+X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaORU1AAKCRAr4qD1Cr/k
CpeqAQDI0mHsNtNjhGIGEPA8W9m1LL91mdg0ddc0BfuDquPKtwD/Xnk7dj4LdJDA
+gZSoBzXQolhXYnwMdPn7n0pmFpxzA4=
=3W9Y
-----END PGP SIGNATURE-----

--qI4ffp4ANvZgYC+X--
