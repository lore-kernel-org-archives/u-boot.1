Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F379CCD195
	for <u-boot@archiver.kernel.org>; Sun, 19 Oct 2025 16:48:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5CB7838CC;
	Sun, 19 Oct 2025 18:48:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QKp1tmDu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14DFB838CE; Sun, 19 Oct 2025 18:48:52 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0188831D6
 for <u-boot@lists.denx.de>; Sun, 19 Oct 2025 18:48:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7bb79ad6857so1961926a34.0
 for <u-boot@lists.denx.de>; Sun, 19 Oct 2025 09:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760892529; x=1761497329; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+iy0TZG7+y00L3Qn93huWEbdPJL29BIecay5ij6l7yQ=;
 b=QKp1tmDusixmK4Se8YlYTnq6OxZ3uli+27T14zcld+BFXYUe4Ge9Co/Ta6/xBq5QIx
 qcnbZGwGGKcLRO6Nwh10GWYaogGNI2/RFFkUA9hdgth/V6UAFz6GLnYIwqgNH49fAnZf
 reoY4EQxDttHuXWbkrS1fvd9+1rhiWTJLivLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760892529; x=1761497329;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+iy0TZG7+y00L3Qn93huWEbdPJL29BIecay5ij6l7yQ=;
 b=pngv7p6tuTPwdZvX7vdfvi2AQnKlTfCTD1GAlkH68TMy0CpdI0uW9lKHzQSpoiaUFu
 4XgWz6QLeOUQayCEhrGE1j8glhetwBSh/oXFz98G3TBz1hL10Iu4/unlHTeSu8NvkIBI
 gJWK2/bDcqwhFm7SPDaqlgSH6yfaeaMLcf3+3IN201a7/VdTN4TI1L1kBX8Tllg+j9fC
 CDC2fZ3fI/AvjpwC1egMM6KYiPBFgOv3l4QcV/i86Rw82bvCRyePEZ+Um5zXpqEFH8YA
 s6tslnFZtPjfNIro+fnxUaiyd7qLu/MkrSiC5DjLBJqijVWpAmZYWOvt5ZrUYHCu9npV
 KbCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUS+Fr2rJioil4IE7Lov60NgVJgXigTVYPpQUBbQyS1Kibh5Wj7WbWhq9ApPTdhoJwuDe+lcQQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yy2nUVAVWxB8D4aBNhpDaLijx6tcnKm9eVOoCPR03qxrwNnhkfh
 IhPLaRghQHW6ZaEMhMg/FwWgERnQSt4kIJsoBrVzOmer1N1DlilPLz811h8WascDaDw=
X-Gm-Gg: ASbGncvjkAqWSycMIB8aJjQrrUNaMnf4qaQ7CjzND3kA+eO8SdZzh+YzVuVa4R7qw0P
 PVSMhZiYrlZnKyNoyXHUAjzcX0plDaDekS9sLDnki2EYCQMGIItlLdaHbBA5M0KyRC6wwANVzIS
 ezwLv4yB4ybWTuX561SacqUohY0Bh4HtTdWlZ4tQ7jo5xM0TAM9vYuKfRgWmXTQrSkH9yBz5DY4
 ai4Zrux1f7Oa+fiql44xkB78i+28jWvgcSarxMkrA1rkVs+ax337hhpo7t0ppJpyLTh0H/RvqKh
 8b+GUhUaMIGkT3T48Ju0Aesxa8fYR5j+yRmDpj/bzsB5xzmxSO/B61yU8OHDng5dyKZwOf1E0/5
 Pdlx82uY/eQWXaBqI+lDDbqiEhO3kIi5qfONrA2XycSrzrvb7p45aPC2uV/A/yR0Vu4nBZw/foi
 eSa15G0Juav7GIG2vYfuHdLJ4WUe7LLSa6Au1pCbg=
X-Google-Smtp-Source: AGHT+IHHqPYNB4PueqKqqY269zMDDECCXpgOLjdU7BLpB3OoVTRzipRZZGpowkZjKVO444zQ4aNsGg==
X-Received: by 2002:a05:6830:6c15:b0:758:85e2:9a00 with SMTP id
 46e09a7af769-7c27cb9f276mr4581514a34.17.1760892528713; 
 Sun, 19 Oct 2025 09:48:48 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c288936023sm1831309a34.33.2025.10.19.09.48.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Oct 2025 09:48:47 -0700 (PDT)
Date: Sun, 19 Oct 2025 10:48:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 E Shattow <e@freeshell.de>, Jerome Forissier <jerome.forissier@linaro.org>
Subject: Re: [PATCH] efi: Select required CMDs from BOOTMETH_EFILOADER
Message-ID: <20251019164845.GR6688@bill-the-cat>
References: <a2f2b1cf-aa2a-4628-9d04-f293591f5f9c@siemens.com>
 <59fa7090-9ec0-450c-8ea8-ead768d4e345@siemens.com>
 <CAFLszTg5gOP=bNJBBrDsFf-BKYiZF27a0-1t0CgiF6Z0xBD0Zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="liiiQ1S/9ozLwK0M"
Content-Disposition: inline
In-Reply-To: <CAFLszTg5gOP=bNJBBrDsFf-BKYiZF27a0-1t0CgiF6Z0xBD0Zg@mail.gmail.com>
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


--liiiQ1S/9ozLwK0M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 19, 2025 at 04:21:01PM +0100, Simon Glass wrote:
> Hi Jan,
>=20
> On Sun, 19 Oct 2025 at 16:02, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> >
> > On 20.08.25 07:50, Jan Kiszka wrote:
> > > From: Jan Kiszka <jan.kiszka@siemens.com>
> > >
> > > There are needed because distro_efi_read_bootflow_net depend on symbo=
ls
> > > provided by those commands when networking is in use. Imply is too we=
ak.
>=20
> Reviewed-by: Simon Glass <sjg@chromium.org>
>=20
> But I would like a bit more info on why 'imply' doesn't do the trick.
> Is it due to a depends being wrong somewhere else, perhaps?

Well, is it valid to enable BOOTMETH_EFILOADER and disable CMD_TFTPBOOT
and/or CMD_DHCP? It sounds like it's not (link failure) and so imply is
the wrong keyword.

--=20
Tom

--liiiQ1S/9ozLwK0M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaPUWbQAKCRAr4qD1Cr/k
ClrEAQCfukc+GEJZ1Wavz0YffZGPfjbA3Pf4eLq8lAW4gUAr/wD+NxdBWjzNLIdF
jjbHilDwQ3TkfpRcgZha7XOWhiEh5Q8=
=PvGI
-----END PGP SIGNATURE-----

--liiiQ1S/9ozLwK0M--
