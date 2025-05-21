Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B78B9C2D0CD
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 15:12:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E21282F40;
	Wed, 21 May 2025 17:12:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WIQeTMCx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F058D82E9A; Wed, 21 May 2025 17:12:52 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1EC282CD2
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 17:12:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-609e7f3caf3so4155231eaf.1
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 08:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747840369; x=1748445169; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BQC5AGZQzrQbhriN/AzQM+0jSoV7WHiVXym2RCoXr70=;
 b=WIQeTMCxih7wsF07f4WHyNQX6TKPaz7jGrQMPaPzfSIcOJvhxP4P9o308OEIS9oPGJ
 EAhOuFMNu5WB12NWE2yM79s2/U5cIlWTSYLYiVvgOb/05jHC+5wGRJNwCjoQgQgEI8Gh
 Fh+2g1956U2fHEymQzCcotFojrAgrn7sMpLdc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747840369; x=1748445169;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BQC5AGZQzrQbhriN/AzQM+0jSoV7WHiVXym2RCoXr70=;
 b=DIqMN/1RYO7sj7mZ+lGHFFJ/Qxm0eQxaas0t96ieF0C/i6/Y1rbje9AXcU4E+dXsRL
 +9U8BHdpnBipeiDq8OFJgW7VOh8hR4x3L+3cP+gh9BxDXVgJeytiTTHQPdd6UR8h6nFt
 gFATYUYTNq0F6eQkse7EQU0lwzrH5Uk5XpNO6PoMpIU19Sr5BChvz0u/gdp1QRPTQ/OK
 Md5pU8qPK+LtGnth65hfAn99tGyGRLQmR11GaLdvnYgD52etbqxxDmuDdgrAWu5aAOG6
 IL/r/uH3agtKXZhb5gs4/q9mDK+dGutABkpJI5wL+LRHEU7qXPllD/RuAoQptJiVL3q7
 U4gA==
X-Gm-Message-State: AOJu0YxirUxksuwa6vUjIIRA3UGAWSEL/ZG5G+BZfAvJO1VZb6xOzBnZ
 d+lRNDMb8BG2ppsgLcNcVMunQfU19IIu50AyciYBnP9otrrMsoJ8IHLzAaAXhmGfB84=
X-Gm-Gg: ASbGnctUsgJR4lK8WaiA9Fe8AlggxxyNZLamRyDfNI+krtPkGTqgaFpsbMqqB3HyyUH
 iZ7sbcCSlgFSka3SCTgD0mBHHjq5e7shRSJKm2uU/V35y07j8YL2qRSIulHwJO4iLqtNTV14ouU
 BEdjC1OAGdRH5OdP7uATfIIltWq+/JA0aboEcO8brRIjvD6wMd0V2lERKkuyWfsEg90ehL5D3N6
 Yn6b1E9+uFNo5i7JFtrNtvw4AGfEySMtrkDvvs+oVwW5dkAnQ9eSDegq2mEOiqeZlad/LlcLdsZ
 uvcP8ES47wUVjzN1Ipu3C3D/SITuxwMsOULQ5HhryXBGFfQRJkVxkMyec+oWD/clz8jdRtSodT3
 am6T1PKrXLl6Q
X-Google-Smtp-Source: AGHT+IFM5lGzUzCqrqKZzzkHIeVm1mWa19tyCOdD96EVjDw7rW/4vB2mXN6FwnoeeJC7voZhhmgmlA==
X-Received: by 2002:a05:6871:a50f:b0:2c2:561c:47e3 with SMTP id
 586e51a60fabf-2e3c1cdb8b5mr12524342fac.21.1747840369568; 
 Wed, 21 May 2025 08:12:49 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2e3c075d6a6sm2653757fac.28.2025.05.21.08.12.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 08:12:48 -0700 (PDT)
Date: Wed, 21 May 2025 09:12:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Benjamin ROBIN <dev@benjarobin.fr>
Cc: u-boot@lists.denx.de, sjg@chromium.org
Subject: Re: [PATCH v2] bootm: Fix bmi->images pointer not initialized in
 some cases
Message-ID: <20250521151246.GD100073@bill-the-cat>
References: <20250520203515.25839-1-dev@benjarobin.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nNLJaJEqmS3tbDKC"
Content-Disposition: inline
In-Reply-To: <20250520203515.25839-1-dev@benjarobin.fr>
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


--nNLJaJEqmS3tbDKC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 10:35:15PM +0200, Benjamin ROBIN wrote:

> When building with only bootz command, without bootm, images pointer
> inside bootm_info structure is not initialized. And since this structure
> is stored in stack, the generated error is kind of random, but most of
> the time this will generate: "ramdisk - allocation error".
>=20
> Also, after analysis, this problem could occur with the command booti,
> if the command bootm is disabled.
>=20
> Currently bootm_init() is called by: do_bootz(), do_bootm(), do_booti()
> and by do_stm32prog(). And all of these commands execute bootm_run_states=
()
> which access the images pointer stored into bootm_info structure.
>=20
> So, to fix this issue, just do the assignment unconditionally.
>=20
> Fixes: c2211ff65136 ("bootm: Add more fields to bootm_info")
> Signed-off-by: Benjamin ROBIN <dev@benjarobin.fr>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--nNLJaJEqmS3tbDKC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgt7W4ACgkQFHw5/5Y0
tyxd3wwAhi+o46RpMmx/a3XGIaISEcu2Ve+VYjYOSodJBpX4TIwn67xXygAHx5S+
0JXM4AuP3t0FWWr5qtQyQTiI5gq/7BUMIpADgCmv28DmlDw8FG9lHE9oS+6tiCYe
QXcKYtLsQS6ELlCiJ09myvirkM3Yp8qcHOIBxEBKH2T4q2hHyanDzYHyozSUjAVU
qOv1uPbFy79QVPdXZE9F7zJwrvzAuJVAd7TOI2Icj4ZfxHz1ya02QJJy4jYdqHiw
rJdVM80XL5H94wr3KqiKS/cBwSwXdadQi9ZeX+RIzIbuzQwK8cLYBSKyQEHBG8yG
wmv7/RPhbxwPqyR+2dstQKHJ5bEnTauy861zZOGkDhEoPuQA2AQ+nMzFFwjeX0KB
E+8Rqq4ELsdz3r6FzMlw5XA5KsapGQGu/OAFwl+llDhdDTrGTI5QksV/siSJlGg4
zoE5zjJXx/iVG4f2ZaZpEJ3k86YDng+33NAMa2NbltuRbSJGp1asXWSaC5mHY2EE
CwCB1BuH
=aLI9
-----END PGP SIGNATURE-----

--nNLJaJEqmS3tbDKC--
