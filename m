Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73875C4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 18:53:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5607988206;
	Fri, 12 Apr 2024 20:52:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fz4buEg0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E4FA88207; Fri, 12 Apr 2024 20:52:29 +0200 (CEST)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14E1C88020
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 20:52:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-78d68c08df7so66957385a.2
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 11:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712947946; x=1713552746; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Vreo6mUDP0paEhUwiH2NI7IR1NldD3g1vs7s5JPUQko=;
 b=fz4buEg0ab8p2euXHEdpXgj+8urmeUu64q5vPWhEk6L7A612OZ9kFqkrGlbLD418Ob
 2Gfb2ycW81VQrs9yM973YbIJI7InO88YVKwaNgrPvjJKSK3q+pFuXELtrbU4PC3nMc2e
 Tk3mGvHm1uwaofk4Hm/GU2bI4MtWwVFJV1Ss0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712947946; x=1713552746;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vreo6mUDP0paEhUwiH2NI7IR1NldD3g1vs7s5JPUQko=;
 b=Y3sE/K3/bZngHxKB4nZ+CdzFGy7rTWXzzscBbCVNvEE8SRL+dfw+XiqnMcb8leAnef
 Kz3Gd6l4iq9a1UnC+NlvCRwFQDnYdYxRVVgkaFl+fPs0dd+z9ZP4rGDZe5BLn89kAlpM
 81sWRjb1tevW3WShl/ILAOEn1qCK1r0WsUJHAqTjubK5DXMZ+dhw8qJ45n3xrheVHAJf
 +oHf/hU69pNam0B1dsNFahPHzSwyCRsQhvw+Kg56WXYS/jYqGy47Zi8bx0smzfhWiyP6
 b/5AITAZt6AHSYuT/BsUdjxdkF9xRqF1iFIs9WkytIkZjLgctEDl7GsLZxSJoQ/x1Blo
 eSgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgbd286J3CtaUK1vgdofRoNfPhRCHpgs7NdPxpx+pv9e4oH1ue9i5IZG1/CHrQPKObIhKqSYuuJs4Y+ah6PKLw3JDeag==
X-Gm-Message-State: AOJu0Yy4Fpl6WaAnz0OXmtmF4+JRCiXJNE5FRmreqrijKQoBy57K5bkE
 cxDqEfPLa9/fKXs9Xp9mrzrq88ZL11JrwrkswP5DJvSTYnwrC3Rj2AUqeeuUtAg=
X-Google-Smtp-Source: AGHT+IFwCNDscapOtueF7d82pKrp7Cf1wxwwBbgWQ/ZaPXQq4fLmwbmlJUXb2ESvhh6OJsH8xQtYOA==
X-Received: by 2002:a0c:ab19:0:b0:69b:16bb:d6a1 with SMTP id
 h25-20020a0cab19000000b0069b16bbd6a1mr3702919qvb.37.1712947945897; 
 Fri, 12 Apr 2024 11:52:25 -0700 (PDT)
Received: from bill-the-cat ([2806:102e:18:245e:b648:93e1:5c61:68a3])
 by smtp.gmail.com with ESMTPSA id
 j12-20020a056214032c00b0069b50de8fd8sm2054020qvu.24.2024.04.12.11.52.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 11:52:25 -0700 (PDT)
Date: Fri, 12 Apr 2024 12:52:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, David Virag <virag.david003@gmail.com>,
 Masahiro Yamada <masahiroy@kernel.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] fdt: Fix fdt_pack_reg() on 64-bit platforms
Message-ID: <20240412185222.GU2493117@bill-the-cat>
References: <20240330005553.30869-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cyZNaU48wDRQrtJk"
Content-Disposition: inline
In-Reply-To: <20240330005553.30869-1-semen.protsenko@linaro.org>
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


--cyZNaU48wDRQrtJk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 07:55:53PM -0500, Sam Protsenko wrote:

> When "memory" node is being processed in fdt_pack_reg() on ARM64
> platforms, an unaligned bus access might happen, which leads to
> "synchronous abort" CPU exception. Consider next dts example:
>=20
>     / {
>         #address-cells =3D <2>;
>         #size-cells =3D <1>;
>=20
>         memory@80000000 {
>             device_type =3D "memory";
>             reg =3D <0x0 0x80000000 0x3ab00000>,
>                   <0x0 0xc0000000 0x40000000>,
>                   <0x8 0x80000000 0x80000000>;
>         };
>     };
>=20
> After fdt_pack_reg() reads the first addr/size entry from such memory
> node, the "p" pointer becomes 12 bytes shifted from its original value
> (8 bytes for two address cells + 4 bytes for one size cell). So now it's
> not 64-bit aligned, and an attempt to do 64-bit bus access to that
> address will cause an abort like this:
>=20
>     "Synchronous Abort" handler, esr 0x96000021, far 0xba235efc
>=20
> This issue was originally reported by David Virag [1] who observed it
> happening on Samsung Exynos7885 SoC (ARM64), and later the same issue
> was observed on Samsung Exynos850 (ARM64).
>=20
> Fix the issue by using put_unaligned_be64() helper, which takes care of
> possible unaligned 64-bit accesses. That solution was proposed by Simon
> Glass in the original thread [1].
>=20
> [1] https://lists.denx.de/pipermail/u-boot/2023-July/522074.html
>=20
> Fixes: 739a01ed8e02 ("fdt_support: fix an endian bug of fdt_fixup_memory_=
banks")
> Suggested-by: Simon Glass <sjg@google.com>
> Reported-by: David Virag <virag.david003@gmail.com>
> Closes: https://lists.denx.de/pipermail/u-boot/2023-July/522074.html
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

Applied to u-boot/master, thanks!

--=20
Tom

--cyZNaU48wDRQrtJk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYZguYACgkQFHw5/5Y0
tyw+Qwv/T5AB1qNcB7f60kgfUIQ26EnsGk5Yanzko33kazAYS9ahm6pi6/VH7DDv
kCz+xOluFN5ucDywMptbFi3QZsutT27haiFjSbO+U8QD/BfzBz02qWMhp7ZBMksF
9XgyIP21JxyqnLkrGopAh1vm4H3BZJbxVsEUDTpKyOnMKqCJC+b9pbtt5XfpAg+o
9WTOXJy1N5HlsH0SzJMcR//DsaacG7zEvO56ffnyWncGIDvJkdlsiVtqjY3pe3/z
Glzscgmr2CrV3x8okwJNeFKADtWFSU3MKoO6g0gsJAGGjmLkJkDA0Jahc64+GOoL
D4ZmvOHyWpUPcQcHuiftUyY6JA30uiAElw4si26n/QFYIlsPXbqNPSYUQicFd8MY
RV4tiu+fL67NNJRO51/jMPIaveIC9KVpQiP3HMtwAmMu9JBF5/uKGQSQfXyiy/r5
wRDGnweYxP3Xh1qm5bPv4WiWp4JZ+DnpYj4zcJzDTBo/fC/GuLh6NeMB+N8jE+bC
uB77NdiV
=HibH
-----END PGP SIGNATURE-----

--cyZNaU48wDRQrtJk--
