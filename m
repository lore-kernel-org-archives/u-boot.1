Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2944CDB483
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 12:56:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FBCF86E77;
	Fri, 13 Oct 2023 14:56:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="p6IA28eG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CB0886E5E; Fri, 13 Oct 2023 14:56:06 +0200 (CEST)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CA6D86EA6
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 14:56:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-d9a516b015cso2230068276.2
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 05:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697201759; x=1697806559; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NTRqE6ybiXOonB59qyxs/NAnUE8ltIvWRAw4+P8Jwts=;
 b=p6IA28eG9qve4E1pMKfBZoDLLQl/qF2D1DhKWMfeOivMbqY+wYjIKtyHULxTQelZi6
 o9lfgChohL+YQ/lgwWdOVrwundVf089iEo2Cs5fv3N0nQ3QzAP4oafD5QTfU2Cm166o1
 f0fTmotDOV8SG5bVXZRS/Bmg7do6ccY6vC7Kg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697201760; x=1697806560;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NTRqE6ybiXOonB59qyxs/NAnUE8ltIvWRAw4+P8Jwts=;
 b=aYCCKKZ1vkdG8I53eOlmin8OjWatTHS3hlOJhJBZoevjmvK+St7bdsX7YqD+i+PUoL
 VbBI9QZZp1uf/tEqGR2bjTVlWEd6GOYat2pwdsShq2KeSikFCbFuJS7r1UeYgffnMWmA
 Z3YlhcQikc8IZ3zhSav4RShY7mluOqUnc4g6XwOjIrGtwkdjh4XoRgRZyhzznSU3xjuP
 QwC7s/ukDnuSxMHGrh/K54FmY4aywriKNr4bVdYoeJRpWNIvAWANxdpWHtjP9F892lSY
 cac17B+2e0irvMzrj6wIY2tDzekjF9weVBbzJNrTCrbieYNnLOVyh7WxHfrjTAQVSoIJ
 EIng==
X-Gm-Message-State: AOJu0YzBZ+RVYKKuUG0jK4SmIVAPp7XF0dn3NJt4WpPJBkx7cUIpSoDG
 +13qLn8YSPbZMF8zmk1f1xllvg==
X-Google-Smtp-Source: AGHT+IHnVINjiUfNOhbA/pIbhhdzQaIF13Oi4N09CBn/TBz/A/GEpli1Qt2HKmd7+r93TuhdLIEeOw==
X-Received: by 2002:a25:ab0a:0:b0:d9a:de96:3da2 with SMTP id
 u10-20020a25ab0a000000b00d9ade963da2mr3843570ybi.1.1697201759655; 
 Fri, 13 Oct 2023 05:55:59 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5647-4a14-f04e-8d8d.res6.spectrum.com.
 [2603:6081:7b00:6400:5647:4a14:f04e:8d8d])
 by smtp.gmail.com with ESMTPSA id
 a36-20020a25ae24000000b00d9abff76f5csm490370ybj.9.2023.10.13.05.55.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 05:55:59 -0700 (PDT)
Date: Fri, 13 Oct 2023 08:55:57 -0400
From: Tom Rini <trini@konsulko.com>
To: Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>,
 uboot-imx@nxp.com, Anatolij Gustschin <agust@denx.de>,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Stefano Babic <sbabic@denx.de>
Subject: Re: [PATCH 07/26] arm: imx: Check header before calling
 spl_load_imx_container
Message-ID: <20231013125557.GI3119521@bill-the-cat>
References: <20231012015626.3487451-1-seanga2@gmail.com>
 <20231012015626.3487451-8-seanga2@gmail.com>
 <20231012164007.GP3119521@bill-the-cat>
 <3f66c0fc-712d-6c91-47b1-cc01aabbe1e0@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4cK3ISpZ65TkFPOz"
Content-Disposition: inline
In-Reply-To: <3f66c0fc-712d-6c91-47b1-cc01aabbe1e0@gmail.com>
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


--4cK3ISpZ65TkFPOz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 12, 2023 at 09:39:22PM -0400, Sean Anderson wrote:
> On 10/12/23 12:40, Tom Rini wrote:
> > On Wed, Oct 11, 2023 at 09:56:07PM -0400, Sean Anderson wrote:
> > > Make sure we have an IMX header before calling spl_load_imx_container,
> > > since if we don't it will fail with -ENOENT. This allows us to fall b=
ack to
> > > legacy/raw images if they are also enabled.
> > >=20
> > > To avoid too much bloat, Legacy/Raw images are disabled for the four
> > > configs which only boot from raw MMC.
> > >=20
> > > Future work could include merging imx_container.h with imx8image.h, s=
ince
> > > they appear to define mostly the same structures.
> > >=20
> > > Signed-off-by: Sean Anderson <seanga2@gmail.com>
> >=20
> > So, since you mention bloat, this sounds like it's making functional
> > changes here, but that's not intentional, yes?  Or to ask another way,
> > is deneb disabling features here, to save space now that it can, or
> > because they're growing "a bunch" and this reduces the growth?
> >=20
>=20
> This is a functional change, one which likely should have been in place f=
rom
> the start, but a functional change nonetheless. Previously, all non-IMX8 =
images
> (except FITs without FIT_FULL) would be optimized out if the only image l=
oad
> method supported IMX8 images. With this change, support for these image t=
ypes
> now has an effect.
>=20
> There are seven boards with SPL_LOAD_IMX_CONTAINER enabled:
>=20
> imx93_11x11_evk_ld imx8qm_mek imx8qxp_mek giedi imx93_11x11_evk imx8ulp_e=
vk deneb
>=20
> All of these boards also have SPL_RAW_IMAGE_SUPPORT and SPL_LEGACY_IMAGE_=
FORMAT
> enabled as well. However, none have FIT support enabled. Of the six load =
methods
> affected by this patch, only SPL_MMC and SPL_BOOTROM_SUPPORT are enabled =
with
> SPL_LOAD_IMX_CONTAINER. spl_romapi_load_image_seekable does not support l=
egacy
> or raw images, so there is no growth. However, mmc_load_image_raw_sector =
does
> support loading legacy/raw images. Since these images could not have been=
 booted
> before, I have disabled support for legacy/raw images on these four board=
s. This
> reduces bloat from around 800 bytes to around 200.

Ah, OK, thanks for explaining.

--=20
Tom

--4cK3ISpZ65TkFPOz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUpPl0ACgkQFHw5/5Y0
tyxmjAv/aJpzWEeOahRbawOqXakIAesEqJQTe795PXmqR+iwN/h1ueXqBLs+Efhs
7UjVc3zVb2EpVEmf0IzD3XhXmrWqHY6W66uHW4/AJbp1uBqPIvxksrZ397oSuZ4e
JZUmmGjc1KzIxhYJ2bsNWMrF2O2j0toeQIj/qzGdlq3vmp21cHyLhELMCmwKVzdm
WpoETqEY2+lxoZkABeV1j/A64fp5X1AuSaS9K5X0HKk1xdRaU7Pav3z73ONyGCI+
yNyjBGvFyhaXaJ4cUZe0QwCaw8T03lbjuN+ZTGSA5SRBAZOokEuveYcf6vOyXVO+
/7uIzpcMy0AfgdJ24V5ivc+RWKvw8ewM7dIkL8aZsZozWLC0ycPjTLgmiHANftDk
/WtBsnTCdDiuSz/6++QbQCeaXp3O8fPjxI1UoJDS6HxAC7Dti0U3/ikh5KHKBOL7
spnpQRhu6/yd+/GmklQcL12D68xfRO8QsgFM/gr2N8a1Md88g49d0Su9sFxtAhyY
PROJCAHq
=KP1h
-----END PGP SIGNATURE-----

--4cK3ISpZ65TkFPOz--
