Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D7BC83F12
	for <u-boot@archiver.kernel.org>; Tue, 29 Aug 2023 16:17:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98BB086405;
	Tue, 29 Aug 2023 18:17:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ohwVJFch";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D19FD863FD; Tue, 29 Aug 2023 18:17:27 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71264864ED
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 18:17:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-579de633419so52272987b3.3
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 09:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693325843; x=1693930643;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/qh6oJXkhlu4x0NCFrHIjmIdhlvlY38cz/l5+LeKX+A=;
 b=ohwVJFchLelSQuAJJb1E2f19VVEtmyJKN/RWeMdf8Obg62gA0ukK8t3BsFkM47sJcR
 a9jiCQVCilo3i+a9NkFgJqKemoxFwtKKCVPAPqZj+HCmxpSolyfB25LJx9MhbWco9W5J
 W7SWA8ariJs5RYWosI4wfEjiv0mAylueGiDA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693325843; x=1693930643;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/qh6oJXkhlu4x0NCFrHIjmIdhlvlY38cz/l5+LeKX+A=;
 b=lLKSRWfyQQpMfd42e0FDwDWKndcHrICWRyKhdrYInJoPPL/Yf1B1MtsYdvQpgBmCLq
 FY8CKpudZZ3kBGZfcbzvLiRzgSQguC+sqpxSSklD8LSv+uSFAbdTQug6DZRVcxUOxecQ
 +NGjp+vvF6TUJ7PNpc92BN0BeSFfEJoV/oVJdWkHZtn8nV1XFnD0TjBMGdn6SE0/Vmk0
 JYtxRo+4FMXTCg/gukKZ86FutHJFFfyg9FZuVy5pe31jpdroUhHFUxZyAvvXV+HbVIeM
 vxMDYJmnoAE6PGe9wjLhCoYvJXIBPgpJUtjgIkdCjFKU37GRBz+zQ7t7wRKp+agGfwfR
 QnMQ==
X-Gm-Message-State: AOJu0YzksfThe/k1lCZHPCEX4Cgrmnf3fRgOGyCUAh/L4UplXZHgTMVy
 sb/lPRGIOFImSZtdvjKqeJuCMQ==
X-Google-Smtp-Source: AGHT+IH3PvlLrDUR/rAFS1iJdgoruT43pcv5hcKOJWxtzS6r1acnSy+OSiQL20cM38CPDxvn1V5Kug==
X-Received: by 2002:a81:4917:0:b0:586:9cbb:eef4 with SMTP id
 w23-20020a814917000000b005869cbbeef4mr31521989ywa.2.1693325843089; 
 Tue, 29 Aug 2023 09:17:23 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-4165-1a0d-2d73-76fa.res6.spectrum.com.
 [2603:6081:7b00:6400:4165:1a0d:2d73:76fa])
 by smtp.gmail.com with ESMTPSA id
 d2-20020a0ddb02000000b0058cd7816bcbsm2827665ywe.17.2023.08.29.09.17.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 09:17:22 -0700 (PDT)
Date: Tue, 29 Aug 2023 12:17:20 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] doc: describe Kconfig fragments
Message-ID: <20230829161720.GF3953269@bill-the-cat>
References: <20230829065427.16727-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ozPWgasOB8Lg5hE5"
Content-Disposition: inline
In-Reply-To: <20230829065427.16727-1-heinrich.schuchardt@canonical.com>
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


--ozPWgasOB8Lg5hE5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 29, 2023 at 08:54:27AM +0200, Heinrich Schuchardt wrote:

> In the 'Build with GCC' chapter mention Kconfig fragments and show how th=
ey
> are applied.
>=20
> Adjust the formatting in the configuration section to consistently use
> italics for file names.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  doc/build/gcc.rst | 35 ++++++++++++++++++++++++++++++-----
>  1 file changed, 30 insertions(+), 5 deletions(-)

We should really restructure this file as there's very few gcc-specific
parts and the rest is also true for clang.

--=20
Tom

--ozPWgasOB8Lg5hE5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTuGg0ACgkQFHw5/5Y0
tyzltgv/b6Yi8USP2jl8x8gVUmXL6nxp7y8Q3RTA8wvAPPAnm86UcNsKEqrYq/vJ
Fjvi/RZf8gW2bQJWqj5YwpDP3qugwNysSRxJYkrHucTdWIO3mXvaa6kFljEJLYI+
8BUNgf3OPzxuQdUzkpMPoo3WNUaytKYDt471DMguXyPfH5UGmfG3jtYhg0baxieP
DB3PGkSO2eJGPhSmzK5pvrGq9PXyopM7w+dMOq/9h/iB1rtohaW3e4G7ynalT34x
EbRu5XGSp/k/wvRupVcdjBxvKWpbyQpL8l1yoir04Mr7ANVeOqmhI5ULAu1rEt5I
hSr/Mck8dSveq1YN/6sXjloshKZfjURQ+21uj5tFW9JyQXc2Ay3rKt3DVDmpK0hh
aitp5weRtrom6pMIZqmG4+8a0Z2ojFFoG0E8YEaCAuOyhOBQurog5e9gbVg5cAmX
PQGKFi0JthH++ZvtAmN33FKKpEwAbssImXNYzUzCZjI9aMs3Zb4X1IO7FbLsSZKX
DMS0dd/w
=zj6A
-----END PGP SIGNATURE-----

--ozPWgasOB8Lg5hE5--
