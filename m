Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F9CC3ABC3
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 14:21:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10D9880C83;
	Mon, 12 May 2025 16:21:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WiXYHJfX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09E6E81DD6; Mon, 12 May 2025 16:21:53 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7FE2805D7
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 16:21:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-4033c70577fso2767176b6e.0
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 07:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747059709; x=1747664509; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8kunG7lDRwnC4BkyF+7oB/8oRirL1sksw0wSXEKv+h0=;
 b=WiXYHJfXc6iaqJtFDaAdAC5dkhgM7JESIGsjYiiZVBoz3d4U1897To93x9pR6iGnI+
 9/T2DUhI35bCZuRYogUJnvxK6F+AATI6KRQVeyqbpOc2v3ADdQnxdG4rvODO9nrS3UHW
 MT0j+5mkkYzb9IFhfps1+p1NU4+SVCdf53UIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747059709; x=1747664509;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8kunG7lDRwnC4BkyF+7oB/8oRirL1sksw0wSXEKv+h0=;
 b=LXol38z27T+4YVicWLaErBIcyLszGLHuHxK1gDqCUhS6zo2Ve2/L+4M0sjiwEr9ynu
 IH7ZK/o27E1d+bpiLg3GFL1gQYF4dgiLUU8r5nzqyuHOratk4/jHPdTrX/hMzrXOplJe
 +AyVlCzlLmXjGQH2toAFWGnH8UveqmFpWEwHM35q6Q40XM3vq87RK9woYJUJqQkkhOa9
 bJ37FTjXsLPivgE36H5cF/UEbRwAOQWsuILOAzqlPo4FL2xv7GqN2HBu83vOR9x1KPf7
 5IIVMlWISsWG0OhpPEt3WYoi7IOH3o9rdr7UiV8VnAp4ISZnA5RXMPHyNVtde8CwP+5O
 WvmA==
X-Gm-Message-State: AOJu0YwVhz2hki3y9rb07nucva81bwGKb+JEOGWt2suMC1QT2YuNi1ns
 44s3UJvWYuJrmcYJtF1GefAsNPOKWKNZ+Y0NpZmcPpSwRINojH94lQrnWJ+kZuE=
X-Gm-Gg: ASbGnctia13X4k6O/u8iraolzGFA9/4EgxvyIeMBDHGf4Mc332QQrwpJNfK29vmFRgR
 X0fH3xDIyzp+g1SvFOnI0lGUu7FQzY4iCOCZbpOUcWvnG/05LKVLjxp3gO2oaWGtlSLaOCbh8NE
 jbUHiubUkRhOdEC/iwPMWibHcN1LhtOSZdl4lRU4sJ25K964oFGXUIVnEIrQbvOgtcPEEK9phd+
 SL7qDmaGrG5j0HxokaGto2tc3aeU7a7b+rzdX43OPyMC8XPDGRdgKizkHkEok4NPvCuHIWw46RW
 FSrnHoaBemKLTx3NLQ2zknZ0zCd6KXdAI/Qa0i0q0JBGIffpN3ZZuPEHUrUpOtha9Ko1qybF6nD
 YihOV4KZV1D8t
X-Google-Smtp-Source: AGHT+IESUF1PwCjIu0rIsfAag79mtASsgvKutgWuGOhpiedw6eAUwxUGw/x59D+quOAjpTIOdCp3FQ==
X-Received: by 2002:a05:6808:178b:b0:401:e8a2:76f1 with SMTP id
 5614622812f47-4037fdd0081mr7383198b6e.8.1747059709527; 
 Mon, 12 May 2025 07:21:49 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-403802f7155sm1561803b6e.27.2025.05.12.07.21.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 07:21:48 -0700 (PDT)
Date: Mon, 12 May 2025 08:21:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Richard Weinberger <richard@nod.at>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH 0/6] script: Improve the QEMU scripts to Python
Message-ID: <20250512142146.GQ603748@bill-the-cat>
References: <20250511141828.2367318-1-sjg@chromium.org>
 <20250511143915.GN603748@bill-the-cat>
 <CAFLszTgPsnCxGjh3Y6rLotuMSocTHrMzE0VAoUw_8VVFeh4XSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZeWi2dckU5hf5aKv"
Content-Disposition: inline
In-Reply-To: <CAFLszTgPsnCxGjh3Y6rLotuMSocTHrMzE0VAoUw_8VVFeh4XSQ@mail.gmail.com>
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


--ZeWi2dckU5hf5aKv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 10:59:56AM +0200, Simon Glass wrote:
> Hi Tom,
>=20
> On Sun, 11 May 2025 at 16:39, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sun, May 11, 2025 at 04:18:15PM +0200, Simon Glass wrote:
> >
> > > This series updates the two QEMU scripts available in U-Boot:
> > >
> > > - Converts build-qemu to Python
> > > - Converts build-efi to avoid sudo (unless SCT is used)
> > > - Introduces a proper settings file shared between both scripts
> > >
> > > It also includes a few documentation updates.
> > >
> > > The next step is to get these scripts running in CI.
> >
> > This extends the anti-pattern of "one big repository for everything"
> > while also expanding upon the scripting that I already said I don't want
> > in mainline and I thought you were going to maintain in the
> > u-boot-contrib repository instead.
>=20
> Apart from the philosophical side,

OK, but it's not "philosophical". One giant repository is an
anti-pattern and is to be avoided. Mentioning things we use as subtrees
misses the point entirely. So no, this is the wrong direction for
numerous reasons and I leave it as an exercise to you to read up on why
this is bad.

--=20
Tom

--ZeWi2dckU5hf5aKv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgiA/oACgkQFHw5/5Y0
tywRAAwAhZ3f3Yl3DnULQE4KyhTJwsv486j8fP/+BcQNFBvPd5cDZT2+wy+5rmzS
G2jxGEETpXZqwnWxw0oxsmCczBZ4ldnkuCrf2LGhk3kdG2YpbbDdpfExq0ASASGo
vi5r4+jmq3OPtAxUnozpmDeAZ9JdKffTP4AI+NETDRnjIZGZLIxLqfHT4Z+d3vxr
Puk+0t++Is0iW6fDOSxYkDBWiEAENYs3zSPokvhsvQIURHf/2/EgilbFCPpr+ONe
qo5/fTt7RLVONACcnW31bR7keC7SNhzreNMv71MTHqU8VlDr/dTXM5RBO1EsijmJ
E+Pw+o4ETYxtXvpLKsoVR0ff2paS7fihH9bex25pKV1oY87whUXfIFnsGMMAFHrY
zhlXjGCvoWY9CQvxzpZxpefLpUK0L4P57x00ZVbAPpaLH9DRoe0X03ToL3VZyClp
IwACxci45IY06f2i063jOi7DSBoZssOqORKgDE2J4JzjoUF3YsZLSf4YxLTm2Laa
9MK9X10f
=/7gC
-----END PGP SIGNATURE-----

--ZeWi2dckU5hf5aKv--
