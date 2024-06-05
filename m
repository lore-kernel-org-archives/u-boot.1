Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D14C25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 20:15:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5141A88370;
	Wed,  5 Jun 2024 22:15:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KWUHWEXC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EFF288361; Wed,  5 Jun 2024 22:15:16 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC30388361
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 22:15:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3d1facdf12bso79872b6e.0
 for <u-boot@lists.denx.de>; Wed, 05 Jun 2024 13:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1717618512; x=1718223312; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0i2lexrXqYnldqn6Nm2QAl0MNJK5eTeA6IHmYTOcm40=;
 b=KWUHWEXC+Jc3ySXoKan7u1bSOXidfg2gFZF77gQ8yc6a3+ThfjqJ5c/JLn6FSeRpLk
 2wr1VUwGzkYbz4SW3Bj3x7afQrH6hpxiV5FUB3UWAq1ztejZMIFkcXvz5XjBNMuUdneG
 h9i8LI8kLaPZKZgRFSRY2oCGA1XHJlOBk7L4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717618512; x=1718223312;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0i2lexrXqYnldqn6Nm2QAl0MNJK5eTeA6IHmYTOcm40=;
 b=NQDZjO+tFyltfS9mnOmhkkfN9gpEOyrwVlZluwObkACnUbncv3tFnXM/npDdoAzSz6
 vpcK2A+9/iUZfjcVFyvjYHeCg1DgLD8iuoXIZOhR9361kn48Ufb2Bpwynunll0+PUulV
 H+QfG7vyJ/GZC6+eI8MgxCkt46dynPTqOCuyahoxBPD3u2mxa9Pu4sIqlBcR3paIbMOZ
 wfTTgP40fxxTf19XvWx6rxTXOQdtGvFMUoz/P259pjQCSsEGqc41QzEJWH8LHbgmZZNK
 vi8LJV6JL2zhh10EfXLpHZDb9BEeQLYWnFcybYW0sBkMIa3Xlunk35VqIm1n7637BMIu
 PMYw==
X-Gm-Message-State: AOJu0YytV+u6FWsOqeCw10M2y/8RAqU9vuf2JqkBtkGhDE5Z0+6CtTO/
 TejLBEKMNP3BR71sYWpjJF5f0dnCpmzA6rYBnkRCJ/RJrrNz9LRLeKJPHUk8vzU=
X-Google-Smtp-Source: AGHT+IG6DBH7ftJLVkHQnylw9Y3jfboR+Kv+ycZ7/t59dzwvzuKkrWyR9JqB2fDsp68uEb08edrGag==
X-Received: by 2002:a05:6808:6182:b0:3d1:cb32:32e6 with SMTP id
 5614622812f47-3d2044d4b85mr3370141b6e.56.1717618512518; 
 Wed, 05 Jun 2024 13:15:12 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d20a7a37a1sm56132b6e.4.2024.06.05.13.15.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 13:15:11 -0700 (PDT)
Date: Wed, 5 Jun 2024 14:15:09 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Subject: Re: [PATCH 9/9] Revert "arm: am335x: Enable SPL_OF_CONTROL on some
 configs"
Message-ID: <20240605201509.GW68077@bill-the-cat>
References: <20240605032521.1142768-1-sjg@chromium.org>
 <20240605032521.1142768-10-sjg@chromium.org>
 <20240605144224.GR68077@bill-the-cat>
 <CAFLszThEeXFtqf-Yk+_WbJ2GJtkFdC-R-_nWH2HAE9rjn0d8ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="suDsDWAEy0VnnMmn"
Content-Disposition: inline
In-Reply-To: <CAFLszThEeXFtqf-Yk+_WbJ2GJtkFdC-R-_nWH2HAE9rjn0d8ag@mail.gmail.com>
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


--suDsDWAEy0VnnMmn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 05, 2024 at 02:08:54PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 5 Jun 2024 at 08:42, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Jun 04, 2024 at 09:25:21PM -0600, Simon Glass wrote:
> >
> > > This is a partial revert which makes boneblack_vboot boot again.
> > >
> > > This reverts commit f4b64e9736e73ceec14d51600bed9a8ac48f9fe8.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > >  configs/am335x_boneblack_vboot_defconfig | 1 -
> > >  1 file changed, 1 deletion(-)
> > >
> > > diff --git a/configs/am335x_boneblack_vboot_defconfig b/configs/am335=
x_boneblack_vboot_defconfig
> > > index d473a1a793b..3ec4abddd77 100644
> > > --- a/configs/am335x_boneblack_vboot_defconfig
> > > +++ b/configs/am335x_boneblack_vboot_defconfig
> > > @@ -40,7 +40,6 @@ CONFIG_SYS_I2C_EEPROM_ADDR_LEN=3D2
> > >  # CONFIG_CMD_SETEXPR is not set
> > >  CONFIG_BOOTP_DNS2=3Dy
> > >  CONFIG_OF_CONTROL=3Dy
> > > -CONFIG_SPL_OF_CONTROL=3Dy
> > >  CONFIG_ENV_OVERWRITE=3Dy
> > >  CONFIG_ENV_IS_IN_MMC=3Dy
> > >  CONFIG_SYS_REDUNDAND_ENVIRONMENT=3Dy
> >
> > So, this change was a while ago. But I did it because some of the
> > drivers, tho I forget which ones exactly, really were not functional
> > without SPL_OF_CONTROL enabled. That said, does am335x_evm_defconfig
> > work in your configuration? I think we have to keep am335x_evm_spiboot
> > because it's so radically different from how the rest of the possible
> > options boot, but I'm not sure we need a vboot defconfig? Or if we do,
> > it should be updated to use the #include logic these days.
>=20
> I don't actually have an am335x_evm board, which is why I'm using bbb.
> We only have the vboot version, since the non-vboot was removed a
> while back.
>=20
> In any case, with this patch, bbb boots again.

Yes, the am335x_evm build supports all of the TI (or associated, like
beagleboard) platforms. Please give it a try.

--=20
Tom

--suDsDWAEy0VnnMmn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZgx0oACgkQFHw5/5Y0
tyxSwQv7BDBY+JgDmygD3/k/51oHIJwuiFpM5x/nEGAUFbrtDSaEVaS5/4Ac7sZ4
Ije7VbzgW3fvO6+bzQVBUSoPz9ocy33Dqyqtg6It7jwyCiwZ32MWa1WCj5PK/ILy
fwXv0VlwaIaHLMkmU1yUtB278S38pzznIOa46gGXLoHxOwKYFUvNRSBnA9+nX1+h
eJJfQwGrfafWRxJZXqWEImM7sbeHhEywabVC5+I2xzBtjlmiwCLzbc2OjYLc9/dl
pKVoKMYeksZBmecZsTBKpKndoU4CUC+jXQt5uQsjh8OEZmMs36SaWWtGIcvSvivv
7/vbobbwdXsYsce2reX+y5XlDa/dnUJpUvIC9IpnzHhuHKUyFkuuhGZhRYu7kRiY
KvN1ZH8SmRqidkH1UZ/KPPhnofidVF6MN3TFoswaokpFYA7SR5VkeX5eERoCJtDG
Tw2nTbzu+e2AnhaugsmUUp33CPMtha0+GJQ3giPUvrnYGUxRLqeOdamlUlcVv2+Q
eNtV+E7F
=X46/
-----END PGP SIGNATURE-----

--suDsDWAEy0VnnMmn--
