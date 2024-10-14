Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D92FD1812A
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 15:56:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA4428903C;
	Mon, 14 Oct 2024 17:56:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TJxwMwN6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8377F89157; Mon, 14 Oct 2024 17:56:53 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63EFE88EB9
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 17:56:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6cc03b649f2so14544936d6.3
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 08:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728921406; x=1729526206; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8lE8dOOwQ1+EDJ8vqAXK9hRw4Q7B/bTjQHy3TTwvMSU=;
 b=TJxwMwN68Q+gJ/Zi66u6pOnCq7WtozOMq+BIj3uwr0qXiBlM3T1fI4Pe2f1XsxwG/s
 bbDcNCv7kK3RMvWVvOeCBVbtol+lDJ6CCGWs1f8ivXkH/KRMrVbpJSJbkXhcatWIjpmP
 SMNG9KLIUj6diSS/PjBbmVTMFr/tZzsB3JGr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728921406; x=1729526206;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8lE8dOOwQ1+EDJ8vqAXK9hRw4Q7B/bTjQHy3TTwvMSU=;
 b=MHhxwMjTdMO/viwPVvv8teRvKi0KR+hO0+yH6ymkiVsl9/kWi6Aw1xuEyiVJXyMVLl
 AlEMRcBD+EXi9B1z0ZwlUDJ77COGP9X2gtE2aWU/WBV+iwScq8PXthGkO03iyZDv7bY9
 SKvkJTshgrHM/WV2rOK1qh6J1/UKH7Tc1AHlnuOGPB6fdzyS3lhAjQQSz8L7FmvsPupF
 Ypm+SQofsOw/jo+SmSMn5+w236kNgE28/9NfjIxBOQml455ZQG7CMLpwK4+A6wbtbn45
 89gKpcCnOsahk1t1PoPefqxuaS9lVwOZxOKFur3hKnJyfhWWhwp/KUcRO0CFx+a83eP9
 ZwYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUR5ewGzVpWT1yybwrDAIvAbrNdeGiSvRsXPaU5d8qv9AgA78rTqMqWijSsjM9iti1VmDZVUf4=@lists.denx.de
X-Gm-Message-State: AOJu0YwqayVY/sI1TVgRKs8ZM2KuNCGy8X8a9brVRBdBuFqv83oI/FUg
 uFTlLCQQ0yJqUObpq1f+c/lW3On8aL65fsnT0Xs1BjAEaYMutzCAZjPFQCntQ1I=
X-Google-Smtp-Source: AGHT+IGsNZ8MsMkDh4dBm5YkNRwh3FC2Ap7Qx1aydalW5CLIFSyCFXIpTCbt+Z81+jZAujRvxr4XCg==
X-Received: by 2002:a05:6214:3a06:b0:6cb:f8e0:18a7 with SMTP id
 6a1803df08f44-6cbf8e018eamr123943186d6.9.1728921406129; 
 Mon, 14 Oct 2024 08:56:46 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cbe85b79f6sm46941146d6.51.2024.10.14.08.56.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 08:56:45 -0700 (PDT)
Date: Mon, 14 Oct 2024 09:56:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>, Jonas Karlman <jonas@kwiboo.se>
Subject: Re: [PATCH v3 03/15] efi: memory: use the lmb API's for allocating
 and freeing memory
Message-ID: <20241014155642.GO53053@bill-the-cat>
References: <20241013105522.391414-1-sughosh.ganu@linaro.org>
 <20241013105522.391414-4-sughosh.ganu@linaro.org>
 <CAFLszTiov914NOS9_5UU4oLi0fCQ84a-Et82BeSEJbts4MEOVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uzigKdP/G9xlKo9P"
Content-Disposition: inline
In-Reply-To: <CAFLszTiov914NOS9_5UU4oLi0fCQ84a-Et82BeSEJbts4MEOVQ@mail.gmail.com>
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


--uzigKdP/G9xlKo9P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 09:50:37AM -0600, Simon Glass wrote:
> Hi Sughosh,
>=20
> On Sun, 13 Oct 2024 at 04:55, Sughosh Ganu <sughosh.ganu@linaro.org> wrot=
e:
> >
> > Use the LMB API's for allocating and freeing up memory. With this, the
> > LMB module becomes the common backend for managing non U-Boot image
> > memory that might be requested by other modules.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> > Changes since V2:
> > * Use map_to_sysmem() to get the user-visible address to be shared
> >   with the lmb API's for sandbox.
> >
> >  lib/efi_loader/Kconfig      |  1 +
> >  lib/efi_loader/efi_memory.c | 77 +++++++++++--------------------------
> >  2 files changed, 24 insertions(+), 54 deletions(-)
>=20
> When efi_init_obj() is called, it should be able to add the lmb memory
> to its own tables. There is no need to worry about lmb after that,
> since no other images will be loaded, except under EFI's control. Then
> perhaps you don't need this patch?

But that's not true. The EFI application can return us to the U-Boot
prompt.

--=20
Tom

--uzigKdP/G9xlKo9P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcNPzYACgkQFHw5/5Y0
tyy7+gv7BHrSeFO2hOvrI/jfJSZH/4dJQLE4cBvgFaTiOaLE8wMhPYOaPihSFLWI
9fyeYwr9eCXDL47OlYb2FMA4dmpweAY5v9IHn84Bo9zDZHUU05gY2AUg03FfJwcL
5bkj/kqMsXpfVDrN5GbxIepHv+YvlGX9Vwa83UihPvfCBGLIjTZ1bzjCG/5xfR3Y
dAZ/e/8aHfkkZWpuFAxgoSfbX/RucNEb1kXFYaY06Y6Au97Ra85pz/HjNqWqK7sW
34xpZWIN38YmwcEyaaX1jmK5NFBTLMgeQ8ml8Ae8GlOIcDYSgFZfwv0P1U4ygzcz
XfnfBru4u6I40rLul0HK1q+TfQDiM7J/X8DS3+dkGRE5+G/fARzQxNwYJHgb9/u0
wIV0Tu+WftbdzaM5orFeu2Yz0MfP7OH3IvSsnchY8uLVF4F3XWAGDLBNJA7+Dtxi
TqZyoNUUvtBPnPdTucGKDfVd497Jh0IgTVsRLogzUczFIgLiHazYjKVYD3HPHCYE
epVWprS4
=F86h
-----END PGP SIGNATURE-----

--uzigKdP/G9xlKo9P--
