Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94838CAC5A5
	for <u-boot@archiver.kernel.org>; Wed, 24 Sep 2025 14:14:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F2E183447;
	Wed, 24 Sep 2025 16:14:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uQphtbPc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49BE48359F; Wed, 24 Sep 2025 16:14:35 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2051E80107
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 16:14:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-6218b52be5cso1876964eaf.0
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 07:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758723272; x=1759328072; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EJ9wnIX62GrPUBt6MJmgZTJSaCx9v5XzgeTbEyYMGEQ=;
 b=uQphtbPcyBkqeKC+fWTiNdJfntPtW34FzuTMXtCiqL304yaBjpee0FQFA7xF/k815j
 h6Rlcj3vpnV2WZ2fkf/Fnp3r3IerwSvYjzku7QP5/EjgqxDAm0LdQK6WueeD6ujECwR7
 2HjMZKwjSy9UU/gIi5iskS2RUTTM9jMJfA7MI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758723272; x=1759328072;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EJ9wnIX62GrPUBt6MJmgZTJSaCx9v5XzgeTbEyYMGEQ=;
 b=pFayBOowgQb1GZI3BwcjMBjU3L7iIINp1qYYZGUQ7XGXuuJXvLsyg+HrlmWavmYxkx
 A4ak9Y2K6WnLRyC3qWprwr5hIcXoRurjgA/XpbkDP8gCeU6ST7kkzroObFbT/TNx+FKS
 K/WxArHsQSMIz+tz7HwTNvHkf//z8gKItlwYZKmdJInmRTX0shxDWUqQDvtK4CkA3FQB
 k6w/6+Vap8VcvK60aO+VpFibyojR9cjtdDSThATaMtqaV84CqAs8TipZxMnWPeVzpGL+
 YrxJnyM+RPBj3QP//zuSVwHqd9o2RD0GevlRM71XZeZLv+41zo9aVtHl7yvGcwCs14db
 rvrA==
X-Gm-Message-State: AOJu0YzxWebSZiVFYkU/UT3+q0ZXLfPzfBfnN1xk8xOaPbrOIFULRhMR
 DKR3fX9LCB9A27acyGKdjz6N6DiKlP5VNRW03/5VlLXBDGfwphUpVPCQPj/e6FrbtCA=
X-Gm-Gg: ASbGncuA5I1lzjpZ7RX2PDcn1AA4M+UnrIdl8HcafviefCiYANCqtxi4NwcFgb7z30p
 Q2mYT2FwDws2btlak1dsbe9Ts755DTBfcIaTeaLAXCQ6J27V24+9umMW3NXqdWODsDfQ8s9X3gH
 xiUm69g+yCpq131BUCqk+iqo9Ujf7bjxkg4+0MRhj3Bc/TdcQHcle+B8NQAByg51+0ADlcmOzO1
 VbFx0xoiGkvCbJoVTLU8UzozYH/SBTkz3LDld0FrrvM5Md24xnO0CO7vBa4gJrTZfAEjLWVA8DR
 G//yb88LLjNeTSDCt4FY0knh10aGcA1M0IaVpeZeV/4uD3DsQIjcZaZyvO4kwSuDbMxBrI5o2TH
 4aVeZGVb0MM630Fg+R5JXGqPGqCuOGNEaNck34eAswlofEe/DYFz3oJN8EUPwsYa0auw=
X-Google-Smtp-Source: AGHT+IHoDt07We6noNk9DDaWz/RBmgUj8X0BCF3gncrB5LaQpnBrS4Fq9/eTBtpxizbeoz5QOO3OvA==
X-Received: by 2002:a05:6808:11d1:b0:43f:285a:ee4c with SMTP id
 5614622812f47-43f4cea1d5bmr74651b6e.38.1758723271737; 
 Wed, 24 Sep 2025 07:14:31 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-43f445e99c5sm296156b6e.18.2025.09.24.07.14.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 07:14:30 -0700 (PDT)
Date: Wed, 24 Sep 2025 08:14:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Yegor Yefremov <yegorslists@googlemail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, seanga2@gmail.com,
 Simon Glass <sjg@chromium.org>
Subject: Re: am335x: NAND boot problem using the legacy u-boot.img
Message-ID: <20250924141428.GI197373@bill-the-cat>
References: <CAGm1_ktPcqpCzy=B=_n1fZS5dZVCB208qt8CTgBJak=V0xfgEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Eoq7NRKiDIhfr+PJ"
Content-Disposition: inline
In-Reply-To: <CAGm1_ktPcqpCzy=B=_n1fZS5dZVCB208qt8CTgBJak=V0xfgEQ@mail.gmail.com>
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


--Eoq7NRKiDIhfr+PJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 11:09:16AM +0200, Yegor Yefremov wrote:

> HI all,
>=20
> trying to boot using the latest master, I get the following error:
>=20
> U-Boot SPL 2025.10-rc4 (Sep 23 2025 - 16:45:07 +0200)
> Trying to boot from NAND
> Error: -5
> SPL: failed to boot from all boot devices (err=3D-5)
> ### ERROR ### Please RESET the board ###
>=20
> It turns out that bl_len will be set to 0 in spl_nand_read():
>=20
> spl_set_bl_len(load, nand_page_size());
>=20
> This sets the aligned image size to 0 in _spl_load():
>=20
> size =3D ALIGN(spl_image->size + overhead, spl_get_bl_len(info));
>=20
> Looks like FIT images with full FIT support will be also affected:
>=20
>                        read =3D info->read(info, offset,
>                                            ALIGN(size, spl_get_bl_len(inf=
o)),
>                                             buf);
>=20
> If I manually set bl_len to 1, I can boot without an issue. What am I mis=
sing?

I wonder if this has always been an underlying problem. Looking at
drivers/mtd/nand/raw/am335x_spl_bch.c we've always had nand_page_size()
return nand_to_mtd(&nand_chip)->writesize and I assume that should have
been being set to CONFIG_SYS_NAND_PAGE_SIZE but I don't see that as the
case. If you change nand_page_size to just return
CONFIG_SYS_NAND_PAGE_SIZE or nand_init to set writesize to
CONFIG_SYS_NAND_PAGE_SIZE does it then work again?

--=20
Tom

--Eoq7NRKiDIhfr+PJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaNP8wQAKCRAr4qD1Cr/k
CiP0APoCcfexyK1t/oRLDa/OTVCKWN5SxcZSkDKcXvJSRBMoNQEArMN10iv+uJkt
2mu8tg+kgM4jT94vuHFPcC3yLTDavgQ=
=OPqt
-----END PGP SIGNATURE-----

--Eoq7NRKiDIhfr+PJ--
