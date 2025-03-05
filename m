Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E796C19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 14:48:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D645080E94;
	Wed,  5 Mar 2025 15:48:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UHDf/rqA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D188A80F56; Wed,  5 Mar 2025 15:48:36 +0100 (CET)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B3FE808B6
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 15:48:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e53a91756e5so5689383276.1
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 06:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741186113; x=1741790913; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lqzpBln38/r7vhF84AdZ1jSMBmdB+kH/iMZIMnbEWlY=;
 b=UHDf/rqAmzxEjhlWHih2vcEKcVF3EUZ2NQyqmaml4IP4JJx7pYbODNjq7Zjih1Oz5W
 dC9vY0fMnRg8CNMaCZXU785GPt3yHhkiuy8mdg7qokxSdNnbKQOd1w67xs8+A3hBL0S2
 f/HP3tjesKyp8y1d466vmnXExVX5bl3OHmsDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741186113; x=1741790913;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lqzpBln38/r7vhF84AdZ1jSMBmdB+kH/iMZIMnbEWlY=;
 b=V3+JeF5fqz4MymHDpXkhCxwAsksNE7Q2DNS4QulA85ObGMVJa5sWCbFkuVi/G56gMS
 qpOanLnrw7KkC1DM4xmKEncPFNGZYUXGF95fBlnCpzFO5ogUeCg0dP9T7cono5kBDIPz
 4kCIPzweG7lBiukRLOneAv0SoZx7HpdsuQnvEt3wJ2whJkpETGOesjx2xuuCptkNrTBH
 rTFPNpgfKdv7zqQtZGXvRZaRc15K4fL89e6dAhjI8Krm/zzYZEMWEBr9cjhSat7S/d6g
 LqWUSOSnDr1PKcUPCow3Cz7y/k205OvFO0dPuQH8oLjbX2H3oihXvWL8MlP9Z++R8V1d
 o63Q==
X-Gm-Message-State: AOJu0Yzpcz5xAERVv3FaakQVIXpFOGZdvXrAcrCXtTrPi7AkDSSsBd/V
 1/TBpO/FengxDYcDmlZHSTKVwF+540qxj8RH2dU4YireomDXclQa6u9xYaseRdI=
X-Gm-Gg: ASbGncug5egpQRssWNq2iGKA8/MsW/oylw7/MCBDEo7FwQ66NZzujBX2qd8kUuNrXrB
 teIhP6yF+Qm+0CmFPmYUyK+/K2r2de+DzP7P7mklF2jJrQmbgf68j1wP9K+jMF1yX7cWLYqAILh
 E/uj7+mq7LwVHv5Nr13RAaaLvmIUbSttLGHMhppsG72Ziv+PppZ2u0Wu363BmYlpjLZpthC2r9M
 b4RkRW13lPjpJexDCEOnBgECCKgzm9EUSiSm7ahgZ52FeAxYp/nzn+GFmzcTz+3YjFl9Z21aF2k
 H0RPpE7TNygMpunRlu9qR3xcr4qSKbol7EC6WIbF+/9g0A==
X-Google-Smtp-Source: AGHT+IHCEAZtsMLFzz/9YR+ncELl3RHktdbNAT7aQUQPcyiHgwBf08djIXWmehbJjvhFBqlgv/HKJA==
X-Received: by 2002:a05:6902:2210:b0:e60:9d5b:b882 with SMTP id
 3f1490d57ef6-e611e1c4b5fmr4410066276.27.1741186113142; 
 Wed, 05 Mar 2025 06:48:33 -0800 (PST)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e60a3aa52edsm4437099276.43.2025.03.05.06.48.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 06:48:32 -0800 (PST)
Date: Wed, 5 Mar 2025 08:48:29 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: (subset) [u-boot-test-hooks PATCH 1/3] labgrid: Deal with
 strange Python error
Message-ID: <20250305144829.GL2640854@bill-the-cat>
References: <20250221203243.672465-1-sjg@chromium.org>
 <174103318277.1518351.1970213948242640285.b4-ty@konsulko.com>
 <CAFLszTiGKWYFAJDf+SnBEhLNMwgr5Hn-3YsViLeH0=Hg_ET+pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="aCqManH3aPvBmdk/"
Content-Disposition: inline
In-Reply-To: <CAFLszTiGKWYFAJDf+SnBEhLNMwgr5Hn-3YsViLeH0=Hg_ET+pg@mail.gmail.com>
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


--aCqManH3aPvBmdk/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 05, 2025 at 07:19:05AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 3 Mar 2025 at 13:19, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, 21 Feb 2025 13:32:40 -0700, Simon Glass wrote:
> >
> > > Add a way to work around an unexplained Python message which appears
> > > sometimes with Python 3.12.3
> > >
> > > Make the file executable while we are here.
> > >
> > >
> >
> > Applied to u-boot/u-boot-test-hooks.git/master, thanks!
>=20
> I have seen a few responses like this. Is there a way in the tool to
> indicate which 'part' was applied?

Looking at https://b4.docs.kernel.org/en/latest/maintainer/ty.html I
don't see it, I'll go poke Konstantin and see if he wants a request
filed.

--=20
Tom

--aCqManH3aPvBmdk/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfIZDoACgkQFHw5/5Y0
tyweKAv/QD0u+EfSW5/hB6EuCKj4o28773OQNHPeLIo2FYLTh0EzZ7Wj7dXVOP6a
bOXKz5888RovYPnbYoba0HTJix+mIB/BqSYoZeyvlLFT84EYWcoJ9h07cneaWD5o
w8QzRAFgWSw+rCFjN5TdvJTDmOgbElsZyE2WUGkf5l5onZiENYhvBW+edb6GuuNS
cAxqV9VnUoQGTOcYu56GswkP0zdZtrO65XmXdDGauJDK2tNiuTV0K0Ivx3xiYWXK
O/30deuZjqa45FXdGwG4ySkjHBggaqPwJ9KMb5lkk5ga74un9ORqrGuzyoMngNI3
95x9agJKqXF8pGQrNQKUodZ2cI0c5IK1YBGlpcsdJfpeBT5++pIoP+Gd0j/1VeK3
mzj8VrcmanWgxdjq8ntQxvZ2jpP5jgKREnPfljbNolk9YVIDqIenCuKFiZnVwLgB
YfQW/VGzZv+/ul/ZGLLfoxMipj02avZQxz7Cn4haO1JpjZ0WutqvoqyBZKLn8aep
2LFh5EYP
=bF4l
-----END PGP SIGNATURE-----

--aCqManH3aPvBmdk/--
