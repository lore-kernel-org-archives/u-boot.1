Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E47BEC27C53
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 15:20:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B06286DBD;
	Wed,  5 Jun 2024 17:20:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cHsvJ1Qi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 771108704E; Wed,  5 Jun 2024 17:20:44 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E969A866F6
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 17:20:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6f94ab2bcafso66791a34.0
 for <u-boot@lists.denx.de>; Wed, 05 Jun 2024 08:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1717600840; x=1718205640; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OdeDHD1i67pD1q18BdgCN3khTiRF3kfN/qChSGa9PXw=;
 b=cHsvJ1Qi0yyEXazDTHrTSjgNBKYfCGZffiTH2pAJ+4d/NJ7Z3vN9F/JMpriqEeApuO
 0NG+v/2sOR0mEhodQFdiRMlc91bt3Zvm3Ct/l/CJQm6SqKmlh5uDoHSuWRPQjEnngRV8
 xEFARAWI+YJ6g5LxcZE5reCDpniwOd1+0YjOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717600840; x=1718205640;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OdeDHD1i67pD1q18BdgCN3khTiRF3kfN/qChSGa9PXw=;
 b=jcyl4/wsQjqcWg7ppyt7zqaeFJTeqoVd9Anqu3nUYkEVajyeKPYsxy9eoigVMyXS+V
 o+XNckDyu9/XmtXi1sxO3BHuo6B9EcwOkLtPQQZFWaIWvyCbrNCVd0ld+rIZIxrUzVYn
 Td8gq8+1fwk5JCcy4PQtQBy7S6yjxd9vqaqLERykAHMixEtRxT5B10TXBA8BRLv8gnnD
 zu3oomHC0YIe/6jlNezkcwZax+V6y7JQ/S08XTO8vKstK/RWilcuLZmTmyrvCzm764/x
 ZtIuAzRCBbKKKK2SQtgGIhKU5Id9UakWqt8JafEZqCEZDeft/ynLZCqoxzbhgHYn46Zc
 H1+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUo6VsEyN38qykcIRIT/HUrhn/tS885CikBovg+dydTX2G2cd4de4fVw3ZMdTnx/ONVHRTkQthtQsjjaOf3vJHthK3KWg==
X-Gm-Message-State: AOJu0YyvgwL0vkMqvKlV8d8N1WkIZripeSKsfOjnFLzCF3TONQKLYm+o
 wUB4Kf/4oB0BPXo0TgWxO18QqvX6prVrDM1hlQy6J9Cdz1LT0Y2Vj/dGx8sWwzI=
X-Google-Smtp-Source: AGHT+IEYYFASt1x5WRXH1jYBQMy2wPe2rKMBKO6MsKa/UBR/KIYHtWjESb7xTlErLy395EALjmLw2A==
X-Received: by 2002:a05:6808:b0f:b0:3d1:e1bb:b370 with SMTP id
 5614622812f47-3d2043d1c96mr2893358b6e.37.1717600840354; 
 Wed, 05 Jun 2024 08:20:40 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d2060db24asm228528b6e.20.2024.06.05.08.20.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 08:20:39 -0700 (PDT)
Date: Wed, 5 Jun 2024 09:20:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de,
 Stefan Bosch <stefan_b@posteo.net>, Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilya Lukin <4.shket@gmail.com>, Sergei Antonov <saproj@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng@tinylab.org>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: Re: [PATCH v3 03/25] mbedtls: add mbedtls into the build system
Message-ID: <20240605152036.GS68077@bill-the-cat>
References: <20240528140955.1960172-1-raymond.mao@linaro.org>
 <20240528140955.1960172-4-raymond.mao@linaro.org>
 <Zl92YrE0tw-15wzZ@smile.fi.intel.com>
 <CAEfUkU+tcgjs61thzAiNVsBZEVDUTY+BBAxNQFuemHsfzWf9Sw@mail.gmail.com>
 <ZmAwMGCXZQbhoK0P@smile.fi.intel.com>
 <CAC_iWj+PpUurGLqMw42ALHV6fOLnSwscG4KB2k-55eO2HuLwCQ@mail.gmail.com>
 <ZmA7NgxcSS315jrK@smile.fi.intel.com>
 <CAC_iWj+B+X2BQP403X6wz7dj2HHUO_j0rXb=TjAwh6zCMEgGNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6De+z135xxE67Vp9"
Content-Disposition: inline
In-Reply-To: <CAC_iWj+B+X2BQP403X6wz7dj2HHUO_j0rXb=TjAwh6zCMEgGNg@mail.gmail.com>
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


--6De+z135xxE67Vp9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 05, 2024 at 04:30:58PM +0300, Ilias Apalodimas wrote:
> Hi Andy,
>=20
> [...]
>=20
> > > > > > Is this approach maintainable?
> > > > > > I don't remember if we have similar in Linux kernel, for exampl=
e.
> > > > > > (There are few candidates like compression algorithms that are =
usually
> > > > > > being
> > > > > >  hosted elsewhere)
> > > >
> > > > No answer?
> > >
> > > subtrees is what was decided on OF_UPSRTEAM as well. If you have a
> > > better idea feel free to propose it, but for the sake of conformance
> > > we are better off doing the same thing on every external tree we pull
> > > in
> >
> > How do they will (or already do) maintain this?
> >
>=20
> There's a script to do that in dts/update-dts-subtree.sh

And with:
https://patchwork.ozlabs.org/project/uboot/patch/20240517174930.1028063-2-t=
rini@konsulko.com/
we document the frequency and rules for the resync. The mbedTLS (and
lwIP) series need to do similar.

--=20
Tom

--6De+z135xxE67Vp9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZggkEACgkQFHw5/5Y0
tywPCgv/UI4GPuX6P4rJGO5XYzEYsEjjZVX7wKcxyV54QTU5GYvh3rUxo1ndJoHR
CpZmikpZLk30Be+mtBcHo/xESOflRXwW/lhrAQaVWcA/uPNXFDhvNIBKoafcAPnn
gOChXvkE9kuzWZtxotK01YExJ55b23Ydiipj1/8jomWn3zBPVnk5j2inPDE3oIKw
Xby6NCYh80+U2rcjOAgLN+rm/+IQj5ytU/FZA9lkfkaxbZ+a9bNmeVl2VeN7y385
TlEToo6ZVydt1xzZPRZhjpw03PzMOV7c8ZSc0zB1M8LaSxkySp1SoaMC/j2lKilj
anSSuFWpkHCM7CpoMtTwmXLNnNNfxsdMfXz3bu485kml2W2RadJsweBpdLi/MU4x
re6RTt9xbIhjEnsVLAjWU1jxfrLH8Bl80yWGc9udXpYDUNAi+uEsS/Av9QtnZ5+k
ARpW7b67cxsLeQeUIhQ2WEYUFPYGOz9ri/14viQ3aTwGCSEAWaRBCQUVYqP6/T5p
L7EuigTP
=nSBk
-----END PGP SIGNATURE-----

--6De+z135xxE67Vp9--
