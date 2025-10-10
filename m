Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C7DCCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 14:38:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41B8883F82;
	Fri, 10 Oct 2025 16:38:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="C4PzBqwK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E1F783FF9; Fri, 10 Oct 2025 16:38:12 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6976483F70
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 16:38:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-79d36a6298dso781777a34.0
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 07:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760107088; x=1760711888; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=k1TNLOxjXAASHvCFL9bxU/zW3++rpCJgodn/v+iKF/o=;
 b=C4PzBqwKjpJarB1EF1hFybay431+NbPy/PeHi/uohzmBP+b3rctZX9ZNKvGf5TiWqz
 6I425swLg3rDiLt0eKBmEQBuI2Sp8xva1Ot9kHFFXxXBSKxpzvfCVoz4SeT+Jzz7/Wgp
 IaSUbpke7WWWRHqW8pBKoTNbP8la6Q9XEN6C0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760107088; x=1760711888;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k1TNLOxjXAASHvCFL9bxU/zW3++rpCJgodn/v+iKF/o=;
 b=Qas2ZFpaNqGrBRHMmP26WKMUefIoZOEn7lVk9LjLocTmc9/MIIhzahs8nvifRQddD8
 cd+5axpKN6bk+uvLwLuWwCERG4tBQVVdiqTufET7md7XtgMylACboIhNOrdArLFcQ05Y
 ku7WAjeeGwYsLlSUy94sel22n70SyaIwGmjFl4/sNZyawob5257GupP9tbsXP2vIqmST
 /w7swmJyXLlNDT+yzL1aGkeUKcK2rAcXuYLFoVaxR7ixuSFwbAzsSBsTwpq/mFIbcwOa
 ft8kS/c5coGGsB0YyQ1RP2vd7KWtvg6XIC3Kord0N81wl7zysL1QpgTpoH9ckkmLmBWv
 tYmw==
X-Gm-Message-State: AOJu0Yw4j5zbZSrVOYHLJfWjEq01SjeHaf94fEpFIMFrnP6m9ufQABQK
 xIDP8pXlQT5fohW3Y0UwhodxZ2zlFXw+/DX193f+zXobjYTcI/0qffq2tvMLj2/k7ab5B86sUOr
 O6n8jSPs=
X-Gm-Gg: ASbGncvOkNxExKklTUs7kLww45r5AZreScwwwPynWq64ozIV0uIVpszKCIFLE8dtfRl
 +mvum8jJ+qA8MVjgeONhgeo6YsgED98/NnpdyVc9P6tFG4s63vjhDvqmfq3GelyBux+TYwEtWHZ
 7+s40iuNyzinRPPgMNvrVG7sscQejvo0nPBhWhIBYWaWUE8kmKpDxbakzZGC6Y07aJIYMKpsC36
 Tam4tBk1JpZKH6QghibsqpFEeSv+9/k21P/kQLOUz8+0ri/scZauBY7AYOGREQQqK2QJ1nTx4N8
 QFeBsirNuLi4QY58Uoa53YSKXaNbl1HlYCGvEPFtrNVUPnEuXus6Bp9A/nHr07oFKZUpzmkbvkW
 3VdAdNnZYGqHKrH2NVxioKAio0ar9DScnGdisHe43/4Q52EuQMTilhmrnIi7viS994PTC3VTFKD
 aqJWYL
X-Google-Smtp-Source: AGHT+IE+MYPe2p6DWekS05LfchuAu8VVOaqe96faYX/1MLthPBzEP6k7q0T4WdmBXh/RThhyRSUyTw==
X-Received: by 2002:a05:6830:6c09:b0:746:d4cf:b47d with SMTP id
 46e09a7af769-7c0df6e496emr5553590a34.3.1760107088052; 
 Fri, 10 Oct 2025 07:38:08 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c0f90510a2sm885858a34.2.2025.10.10.07.38.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 07:38:07 -0700 (PDT)
Date: Fri, 10 Oct 2025 08:38:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Peter Robinson <pbrobinson@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>
Subject: Re: [PATCH v4 4/4] boot: Move preparing bootdev into a function
Message-ID: <20251010143804.GA298503@bill-the-cat>
References: <20251009092959.260121-1-sjg@chromium.org>
 <20251009092959.260121-5-sjg@chromium.org>
 <20251009173522.GR298503@bill-the-cat>
 <CAFLszTisxbgD3WLLQNvfi5MO1Mhbk2V_cCEnMQSod=eE8Phijg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ma0t7oO2ruj0Giah"
Content-Disposition: inline
In-Reply-To: <CAFLszTisxbgD3WLLQNvfi5MO1Mhbk2V_cCEnMQSod=eE8Phijg@mail.gmail.com>
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


--Ma0t7oO2ruj0Giah
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 11:36:20AM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 9 Oct 2025 at 18:35, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Oct 09, 2025 at 03:29:55AM -0600, Simon Glass wrote:
> >
> > > The code at the end of iter_inc() is already somewhat tortuous. Before
> > > making it worse, move it into a function.
> >
> > This is not a great commit message. Taking a look at v2 as a whole, the
> > reason to extract this logic from the end of iter_inc is because you
> > will be checking it in multiple places. That is a good reason to move
> > the code. Adding another 5 lines of code (a single if test) alone would
> > not be.
>=20
> OK, so how about:
>=20
> The code at the end of iter_inc() is already somewhat tortuous. A future
> series needs to call it in from two places in iter_inc(), so move it
> into a function.

No, I dropped the "already somewhat tortuous" part on purpose, because
it's just normal regular easy to understand code. It's on that threshold
of indentation where you could break it out, or you could leave it, and
be fine. The entire reason to split it out is because it will be called
in multiple places.

--=20
Tom

--Ma0t7oO2ruj0Giah
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOkaTAAKCRAr4qD1Cr/k
CsZLAP9BzhIdbNOJWa/ZC3NDEyh4sr1KOWmdBLm5VWe/q6/W9AEAwq70EVEck9DR
UkIqrSCi4Cm7nArmG+RZFmu3C7FelQY=
=oQXd
-----END PGP SIGNATURE-----

--Ma0t7oO2ruj0Giah--
