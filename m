Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB14EE49B0
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 14:43:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B272C864F2;
	Wed, 23 Aug 2023 16:42:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tTa9abXG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93ACA864EF; Wed, 23 Aug 2023 16:42:39 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89562864E9
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 16:42:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-58cf42a32b9so63600377b3.2
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 07:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692801756; x=1693406556;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nOHqH4yOCUa5vpyQKzHm8kyYpn2K2nB2f/7if947F3A=;
 b=tTa9abXGvexVyR1eszDRdjC6lrQ08u9dZocyCXfh9nHpozH58xKZrTcgUpNZdCMmEu
 QVKwFd1VCAM1k88Dv3CpneoQgRJjfAIudmlOpybiTF2C+JVi0L/fwwzoyqcSNBktjhP6
 zI1H+uPyA2JgvSaSMB9KuBmUnFwNGvd1jMDIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692801756; x=1693406556;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nOHqH4yOCUa5vpyQKzHm8kyYpn2K2nB2f/7if947F3A=;
 b=aaOQYJThctgziLtHutF3xf/H+lYP1l9hNNBN8SVdH4lKkuScbyZq7727RrCY4mubKY
 /MPA7wBUnryX6bPmM+eeLI+RgGa0Df2XNJyse5NMhb3Or4nGVZLOmCua46pwHqIBnl0j
 8qfQ5R4RpbdKFKB0vbrX6siPJpLnG9bbbm0IrZFkUAp72XPKZ8lGOPricz9J5O+eJgA5
 ojCCUFakiqaJX6cVX94+xpy/6hU4pc1dHRebh9aAU9o3cPBm9w3aU9ORVg9gn9Zvm49m
 fyYxR3bwTxdJRKxXkpRqwpqL2l5yulM/nI7K/QmbNDMejonM+NDuMCEYJTRH8G1po77D
 djUQ==
X-Gm-Message-State: AOJu0YyXZ/dByAsP/zMik9G6H1rjR0LctdmuJyyzPfLCryjIUZqkAq08
 bhkQ/E/GQctEJ+P7lwOv6EtU/Q==
X-Google-Smtp-Source: AGHT+IH3ebuAQ4syZ+dUNQV3dnGtyqqe0UHTd/n4vSZ9WroW/ia4wYWOtMR5CSQtUexLElS4l68u4w==
X-Received: by 2002:a81:4a04:0:b0:58f:ae13:3b59 with SMTP id
 x4-20020a814a04000000b0058fae133b59mr14078385ywa.21.1692801756159; 
 Wed, 23 Aug 2023 07:42:36 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5ca1-6af2-305a-b62a.res6.spectrum.com.
 [2603:6081:7b00:6400:5ca1:6af2:305a:b62a])
 by smtp.gmail.com with ESMTPSA id
 i63-20020a0dc642000000b00583d44b4b30sm3363378ywd.99.2023.08.23.07.42.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 07:42:35 -0700 (PDT)
Date: Wed, 23 Aug 2023 10:42:34 -0400
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Andrew Davis <afd@ti.com>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] common: bouncebuf: Add missing cast to dma_addr_t
Message-ID: <20230823144234.GA3953269@bill-the-cat>
References: <20230813234747.591129-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sBRTjsuvLIhHPDUr"
Content-Disposition: inline
In-Reply-To: <20230813234747.591129-1-marek.vasut+renesas@mailbox.org>
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


--sBRTjsuvLIhHPDUr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14, 2023 at 01:47:47AM +0200, Marek Vasut wrote:

> Fix the following warning produced on qemu-x86_64_defconfig:
>=20
> "
> common/bouncebuf.c: In function =E2=80=98bounce_buffer_stop=E2=80=99:
> common/bouncebuf.c:82:34: warning: cast from pointer to integer of differ=
ent size [-Wpointer-to-int-cast]
>    82 |                 dma_unmap_single((dma_addr_t)state->bounce_buffer,
>       |                                  ^
> "
>=20
> The warning is valid, the pointer has to be up-cast first.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Reviewed-by: Andrew Davis <afd@ti.com>

Applied to u-boot/next, thanks!

--=20
Tom

--sBRTjsuvLIhHPDUr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTmGtoACgkQFHw5/5Y0
tyxbXQv+IG+xyST5IeTT1WNeydcw3ddpfCPdPJ6MwPHFLYkjb95cW71/H4QIRPXI
OiMRUfbtGZoYWsiJrxvzvp5HcXvXT2knowQoqed6w+F3PkSgKi1+ThwDGfOYVL/S
9Kz2uDxrDCu7cOwwc8XDNXclWm5wsksZSeUaw2JkANrJ1GI+VmEO7tsTWyN6o4Iz
z3VSpVJRNRD8ehxwbV0iKW8XquJGwe6gIok3hF9B0Ru7yqi92ag9aInfIUMQkMNw
bfMx+lRXrEUA/eCPAln3bsi4CIf8dLXq+nBdkHcCsvHm9zTZhAkPAdJ0uBXO3i7E
sqX976Hrxa7PUfxw39frJSiy6RUUWyZLofvDW3zn6Kmp3htj4uPTHB4+5Uj4wqts
zC1c707A2NfhXfkCJ/0cKb8ltAC3e7VgxgDuBD4WeMWKWqve78E5Am1uTRT5HdGS
46Lb0t3q4oEwH5ZPTr/0jjxuY1owd4X3JVJPy0QEx7bvCKl9x7FMg9+CC5BYymt7
dmJf/NRE
=rRhu
-----END PGP SIGNATURE-----

--sBRTjsuvLIhHPDUr--
