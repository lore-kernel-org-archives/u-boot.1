Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DFD8CDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 15:22:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5994486E73;
	Thu, 12 Oct 2023 17:20:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TXHcNePe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C26EC86E54; Thu, 12 Oct 2023 17:20:51 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 595D586E4F
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 17:20:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-59f6492b415so9229557b3.0
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 08:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697124019; x=1697728819; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=k9BpA+GNTjgofFPrKqsQv89bdNIMvlRdPdaBw55iEjA=;
 b=TXHcNePe6iUx/Z5zWNiDe256y/GewepPymrV49dRb2G2ZjfB1ofcLwqF+56ndWzE/u
 QTYxunUlD0ws/RAK0yddOv6oLjZjfSOT8jN2PTXM1Yve4h0EvPEL9Eg50E4lI8fTRAg0
 bttPGkcbjHJYDe+tRZ8FeiG3rhdXKD1CqceuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697124019; x=1697728819;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k9BpA+GNTjgofFPrKqsQv89bdNIMvlRdPdaBw55iEjA=;
 b=AAjDhGHbEh+IS0VPmk3VkqOOryXvMoxPv2nALXEL/eSLsz24Nw720L3ZPA/DmBHTk4
 JiV/q3oDSZh4ukmOetPUjD+Y35lQZd1J/RaYq3WD6e3zB8Q+wOD8Pwlo7FvC0ZL7alWs
 vPILLrz41EokA0oClNnpSzqp2FvBlJIRCHxjJyoZFRwEog2P3aK2jDZKi5u2L3BGtqfN
 nmWOtLrQ4Q3N4vi/G26l7QB/0C8ws6seWCAqsYVSFdLieko9RfXzdAZTEF6Qif8jL+Pd
 Tbwu1uAfmDZso/F8bJIaFIL29WgYeA458Zlu7BEhf1RZccVKV0ceuiEH50eqapdZaE7b
 nbXQ==
X-Gm-Message-State: AOJu0YzG/uyxEIrpN9AKKZBDBf5bjb0jkhOZNGDDd5nrGH8HZn/CN+Lc
 8fObS9mu9LZUdWpQ2KlTnpMKbw==
X-Google-Smtp-Source: AGHT+IEyOe5Lnfw6oGT2w2mgq/J/osvL1IJRXb16uR8s+FqUqeqktJ4a9cQUhBf6dF4qj82WIibO4A==
X-Received: by 2002:a0d:d5c2:0:b0:59b:d33e:40e3 with SMTP id
 x185-20020a0dd5c2000000b0059bd33e40e3mr13680796ywd.11.1697124019003; 
 Thu, 12 Oct 2023 08:20:19 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2621-cda6-b3e1-0b3d.res6.spectrum.com.
 [2603:6081:7b00:6400:2621:cda6:b3e1:b3d])
 by smtp.gmail.com with ESMTPSA id
 t6-20020a81c246000000b00582fae92aa7sm22951ywg.93.2023.10.12.08.20.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Oct 2023 08:20:18 -0700 (PDT)
Date: Thu, 12 Oct 2023 11:20:16 -0400
From: Tom Rini <trini@konsulko.com>
To: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Harald Seiler <hws@denx.de>, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 03/26] spl: fit: Fix entry point for SPL_LOAD_FIT_FULL
Message-ID: <20231012152016.GO3119521@bill-the-cat>
References: <20231012015626.3487451-1-seanga2@gmail.com>
 <20231012015626.3487451-4-seanga2@gmail.com>
 <CAPnjgZ2RWZZbQMfF9_KUN+FsoVGoHKPq_sJ9=1GorNkrftwmbA@mail.gmail.com>
 <96125bdb-8363-62a6-1702-53b4bb63dea2@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="B1SYkk2Fh87Lg3fH"
Content-Disposition: inline
In-Reply-To: <96125bdb-8363-62a6-1702-53b4bb63dea2@gmail.com>
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


--B1SYkk2Fh87Lg3fH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 12, 2023 at 12:28:22AM -0400, Sean Anderson wrote:
> On 10/11/23 23:41, Simon Glass wrote:
> > On Wed, 11 Oct 2023 at 18:56, Sean Anderson <seanga2@gmail.com> wrote:
> > >=20
> > > The entry point is not always the same as the load address. Use the v=
alue
> > > of the entrypoint property if it exists and is nonzero (following the
> > > example of spl_load_simple_fit).
> > >=20
> > > Fixes: 8a9dc16e4d0 ("spl: Add full fitImage support")
> > > Signed-off-by: Sean Anderson <seanga2@gmail.com>
> > > ---
> > >=20
> > >   common/spl/spl_fit.c | 4 +++-
> > >   1 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> >=20
> > The check for 0 makes me uneasy, but I can't imagine it being valid in =
practice.
>=20
> This is mostly to match spl_load_simple_fit:
>=20
> 	/*
> 	 * If a platform does not provide CONFIG_SYS_UBOOT_START, U-Boot's
> 	 * Makefile will set it to 0 and it will end up as the entry point
> 	 * here. What it actually means is: use the load address.
> 	 */
>=20
> SYS_UBOOT_START doesn't seem to be set very often and defaults to TEXT_BA=
SE. That
> appears to be undefined on
>=20
> 	efi-x86_app64 efi-x86_app32 xtfpga 3c120 10m50
>=20
> but none of these platforms define SPL_LOAD_FIT. So maybe this is moot?

Moot for the last 3 there yes.  Not sure about the U-Boot as EFI app
builds.

--=20
Tom

--B1SYkk2Fh87Lg3fH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUoDpUACgkQFHw5/5Y0
tyxPhQv8CNZKLk4lO9BNHAeMW29NEZy6LdeY43sHX27fW5ddQS/CDuMyN+YupOpl
27prgObMBHdjW0XXqHaTqFtBtWT89zScRwQD9zGjx8ahHS8FQldeXkHZegTE/gpl
0AExvUTf+uv12QtD4Nwq1H4OuejuDX+G4ub/saAtZwoeybrUuTstvTcY+Z6Zm+M8
i1/em8HB3Lf+0U32y6j0R4d8Rx6OP7HcaeHcEjaCI0inoHgPBa3zYpe1nNLRcuFJ
gNRtzHo1dMXPmf/QNMC/QLNXFRz0KOzGxZPbWNP6RHj/wYeE4ql6RTYoX0+CKj19
g26vg8cX5KrIWpbnKbuAPGPU79K1QjEdvwExDXFFD59NEA8Qus5iqJbdt8gxPHIZ
eccPjT7dgnPTFNIE/4eqQ/rWuRe5gCKxQUAMEOXCkBLgEQmNBTnQos/czr1XYSfo
RRwEa8AsHW90Rr7oMnkLtZqKcmmdKA0pT3LdSM0xInk2/VOady/rR9CAN/hnH3tw
naEkXjtl
=ojjb
-----END PGP SIGNATURE-----

--B1SYkk2Fh87Lg3fH--
