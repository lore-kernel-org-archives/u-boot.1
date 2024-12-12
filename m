Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D0CE77180
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 19:18:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACE96801F5;
	Thu, 12 Dec 2024 20:18:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Iy0LLuqY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5713F801F5; Thu, 12 Dec 2024 20:18:30 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA95380269
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 20:18:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6d8f75b31bfso8748016d6.3
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 11:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734031106; x=1734635906; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hxP/phcTLJ1/nUanZmoQToRmnWFj397OyZYPAhsk+BA=;
 b=Iy0LLuqYGWZzL1BV6e/Be3YWZSO6j6r+kHXP6OB1VfFAVAGZRmJw/RLhoClonKkF8u
 +S2SizijpkhS6HELh3cYy/FeJGLEN5YDT29C9iS4d4so+0C2sPh9jj0RUvXJnmDmkkhj
 I+vUFA/fbcARbZKrmWQLgHVeEWeV1yV8i6z2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734031106; x=1734635906;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hxP/phcTLJ1/nUanZmoQToRmnWFj397OyZYPAhsk+BA=;
 b=f7DowmpRo9uTkpajMLCenVFXAXqinQ+dQgnLfFOn+zxdpBeeAeI70m0tDrJi3PCSjW
 MPoM0wm8NMKbwd5TYM1bPZ1EMr7eNI4xjrIYdbcx3nip0x2+GZ3p3T3ycijXFrIJCrbr
 hd6g0jy6mi96M7GfsEs1jCDhWEMJRkNOc21bKe6/QJwRenEF/EZ1UHz9ORKRNvrt7QwR
 19lL2efX2keI9gBXRkxnCV18nn3qsrSLFd3NZ//OEGGe253hEND9P4OkdJr9cR/zspCR
 eYHP+oQg/nKhX9MHr+jx1dNzRRNO/qJ8dvB0jXKTaoFrFHYPhJzmmbcaWUznaouiPrLD
 jwkA==
X-Gm-Message-State: AOJu0YwkWCoKcbbMQKO5zYz2YZ6ymbHowwnUfqxbWaAeLjC689L0orjz
 cGiMtGOufcKFLNQyVa7XtgzG7ozNxmEsyYj7p//eh7JT8Kfboxm0VfK1rScwE2A=
X-Gm-Gg: ASbGncvnmyLQ7jhkVvGSThZeEP6yg7P5Y4dkK8mDRoWLDTDHGj8BlRt0/RIE8J1xuZe
 w39n5x6MZeg51PVS/6PTVQdIm4PI3JB4SSlf1ssHGLp+dsvp4hD1tHXmAR3WzTcKDIRhBvdvez3
 bQMHQP/A3MxlSMa/FG/vPXnRnZKzdHZgmzjubCk8v6NAsfTaoTjkZWq6R0/YByK07TOIdikVnbh
 3nmWIX3TILU26NHylYwgPZgM94q0PzR49rGSR1P3zfR2+ivmap4hnVS
X-Google-Smtp-Source: AGHT+IH/B2HvKXF1SDB5sO9bmGmByvkLwBjGs46AMe3Uhpq0QJatQ3un45ZCyWnWzYS2rNMkRSu/+Q==
X-Received: by 2002:ad4:5dc9:0:b0:6d8:9bbe:392d with SMTP id
 6a1803df08f44-6db0f709d1dmr23067746d6.6.1734031105837; 
 Thu, 12 Dec 2024 11:18:25 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8da66efd7sm84693986d6.17.2024.12.12.11.18.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 11:18:25 -0800 (PST)
Date: Thu, 12 Dec 2024 13:18:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: u-boot@lists.denx.de, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, E Shattow <lucent@gmail.com>
Subject: Re: [PATCH] lmb: prohibit allocations above ram_top even from same
 bank
Message-ID: <20241212191822.GK1505244@bill-the-cat>
References: <20241202070624.1295497-1-sughosh.ganu@linaro.org>
 <173358702572.3722028.2684286775587826268.b4-ty@konsulko.com>
 <092f9d73-c0c5-419e-b6e5-e671f8227753@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="v9jAhJhR0sLHyLZk"
Content-Disposition: inline
In-Reply-To: <092f9d73-c0c5-419e-b6e5-e671f8227753@foss.st.com>
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


--v9jAhJhR0sLHyLZk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 05:18:28PM +0100, Patrice CHOTARD wrote:

>=20
>=20
> On 12/7/24 16:57, Tom Rini wrote:
> > On Mon, 02 Dec 2024 12:36:24 +0530, Sughosh Ganu wrote:
> >=20
> >> There are platforms which set the value of ram_top based on certain
> >> restrictions that the platform might have in accessing memory above
> >> ram_top, even when the memory region is in the same DRAM bank. So,
> >> even though the LMB allocator works as expected, when trying to
> >> allocate memory above ram_top, prohibit this by marking all memory
> >> above ram_top as reserved, even if the said memory region is from the
> >> same bank.
> >>
> >> [...]
> >=20
> > Applied to u-boot/master, thanks!
> >=20
> Hello
>=20
> This patch is breaking the boot on STM32MP135F-DK.
>=20
> On this platform, we got an area above gd->ram_top,=20
> this area, reserved for OPTEE, is tagged with LMB_NOMAP in boot_fdt_add_m=
em_rsv_regions().
>=20
> Since this commit 1a48b0be93d4 ("lmb: prohibit allocations above ram_top =
even from same bank"),
> this area is no more tagged as LMB_NOMAP, because it's previously been=20
> tagged with LMB_NOOVERWRITE in lmb_add_memory().
>=20
> By not being tagged LMB_NOMAP, the MMU configuration is impacted and lead=
s to a panic.
>=20
> I suggest to revert this patch.

Hi Patrice. Can you please re-test current top of tree? I believe Sam's
series should resolve this problem as well. Thanks!

--=20
Tom

--v9jAhJhR0sLHyLZk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdbNv4ACgkQFHw5/5Y0
tywY9gwAtIzTodEuC/5oIb4/FCld+dI8sSgSLkmJ26njytDvc/C6dd/1/AgL0z0Y
Ho6Fb55bWNJgXjFxkGZEPJ8CT1iXU4iEURQUqqhOZKKiWO7ZQbw6+yhGPmM6I4Ot
QdhWf54xLMyoWNf3AEfaVG6oxYiVbI37kANhw0GFddJ3ul15NwVWovIi9WZbs+DD
nTBEAbpUnW7YnLKCPNUWfPfDfYe9Gk/YHlnYRlhe856Ais0KmQCqR2GcTu9GYEo/
ooM2rlgVoe0kfZGLOhSDXixKp34HNGNuLFst+Zwi3/XywLoy5clB4ApcCahQOcok
cItsa9GVs6Ee512OuocxKU/wegVVMI2OuMcvCvxtSAMbC3qoZikItkNo7beq0yd+
9XwzX6E54fCUzL5bYRu3Yup7THV4vP3u0P4myIlVVpy1fn7VVJqti6oUxxygWOnT
oRQtOTUZNB1fXoU8EiCjSlASSJbgK+xqdlySh5yX6sgMVwGCpHeQI4cm14zsEZvC
4hXkqis7
=Xgsd
-----END PGP SIGNATURE-----

--v9jAhJhR0sLHyLZk--
