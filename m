Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E896DCDB465
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 00:41:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9857869EB;
	Tue, 17 Oct 2023 02:41:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MT4pV4LG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F23B869EB; Tue, 17 Oct 2023 02:41:27 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D1F685DFA
 for <U-Boot@lists.denx.de>; Tue, 17 Oct 2023 02:41:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5a7a80a96dbso52449287b3.0
 for <U-Boot@lists.denx.de>; Mon, 16 Oct 2023 17:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697503284; x=1698108084; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=A+JlIWN5kC46qwef9Rr41BcNoqKYbA25RrDSOZdaucg=;
 b=MT4pV4LG8zkGtLlsTaeGP1ko8RX0N8g3WFeWjGs+KsAwxtP9sfZECba/GJHwMLJKZu
 a/pLSLcN+iDt4/jPgkY7d8oKb/5vRe3GlYqEicjbdmw1kp9lkUhB4evPzD0C3pluvxgK
 alygOZ8eMDfuRUSVKbrYqjtCBCkwocvUsHwiA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697503284; x=1698108084;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A+JlIWN5kC46qwef9Rr41BcNoqKYbA25RrDSOZdaucg=;
 b=o/O6cOTY2ZZOsbXOHAzwh/tJNOImwIG7R5/gBSVu3vqdD2ON+S8S/DrdrYWcPBNYUC
 uV49qgeyeE05QJRiCnVpgAP0EYrLFgelpotReyZMmGYyRwe4TasMIZCLdLrJu2UxWR3s
 NuopjMTEZuf//9biS+OtZU4+gs8r1xe8np8ugYkp3UOW/N2DE7BKHWNkPhcdU4RxJKyh
 pahhUA7l30Ev9+/8ecLFc4NlfvqCLZu86L6LuEtE7BE/PNAE+6a3BZ+hcVgE8oQghCKS
 EojeamKmlUrI6J8D7M9ZOeSfv5s6n8CnaDxaj/u8mXVkvQ6jhBKOw5zzttMPsZ+KFVJ+
 MHLg==
X-Gm-Message-State: AOJu0YypQ+XtGMDLyzupGewkzSzauqdp1CdsCVyy744zKClu5UqRDuAx
 z5kZ35+H4r6S4ts/jh7LuIy4KmaahydHzgnXXFXwpw==
X-Google-Smtp-Source: AGHT+IFNdMtdXadZaJhaV4zEhVpNoHZvcGth0exqJIF+WkFMDg8w7HvSC3iFrmBKRQteqt6WhAsA1Q==
X-Received: by 2002:a81:4814:0:b0:5a7:bfc6:96aa with SMTP id
 v20-20020a814814000000b005a7bfc696aamr310421ywa.7.1697503283662; 
 Mon, 16 Oct 2023 17:41:23 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 u140-20020a0deb92000000b0059bc980b1eesm161315ywe.6.2023.10.16.17.41.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 17:41:22 -0700 (PDT)
Date: Mon, 16 Oct 2023 20:41:21 -0400
From: Tom Rini <trini@konsulko.com>
To: Stefano Babic <sbabic@denx.de>
Cc: "U-Boot@lists.denx.de" <U-Boot@lists.denx.de>
Subject: Re: Pull request: please pull u-boot-imx-20231016
Message-ID: <20231017004121.GR3119521@bill-the-cat>
References: <0740042b-3c8f-4a53-8270-b528efaeef52@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zDypU4Oqd/lZtPbY"
Content-Disposition: inline
In-Reply-To: <0740042b-3c8f-4a53-8270-b528efaeef52@denx.de>
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


--zDypU4Oqd/lZtPbY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 11:32:45PM +0200, Stefano Babic wrote:

> Hi Tom,
>=20
> please pull from u-boot-imx, thanks !
>=20
> The following changes since commit 3c3f1626919cd93cbe6c56e3849937de5be18d=
bb:
>=20
>   Merge tag 'dm-pull-13oct23' of
> https://source.denx.de/u-boot/custodians/u-boot-dm (2023-10-14 10:50:20
> -0400)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git
> tags/u-boot-imx-20231016
>=20
> for you to fetch changes up to b0eef7326920ff55ec22dfb86812033d84737839:
>=20
>   imx8mp-evk: Add USB0 OTG support (2023-10-16 18:52:20 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--zDypU4Oqd/lZtPbY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUt2C4ACgkQFHw5/5Y0
tyyq1Av/ev50FSU9saxOWWjgiAaT/kT7ORdoXWzGCrdGe5XrMKMzOt4uJo+aLjNa
mm7xrjZhgI0oYJXOXihAmX/Vq2WW6DlBFItF/f1cWbnP+D6yH984hxSMoDSycLFM
SBm+7tUte5p94FcQcvz1eIUciHrHwxvZ7C9v4GxU1Romvsv9kKhPVV22zK6DvaQQ
cjNfcNGLFogikHLeD+MLPTKlJg/eiKnaDMKBLk8CJknwRLPJb13qutTtWssFbxaT
86iuSku0a5UxV+4l1SY0PylFdI3AOXU8RlVgulQi+Gmn8kQ/VEY2vmnQ0RrEpJJ4
nYh/WS49BiJ5DsDVFq2XJ31wAlEGkxiliRIKsjlSGPw12mh7tNFyGL0g9LF0kwb/
ecLT96GxaHjAAoucCxHy6QAou0HiqHLwCHgI6ypqGU1QzMZIKsqCQWp+amK1rvYe
wKlZ9J4n7gx+PkEKy4fheoKr70HmXnb0IrJCdPcNgPkaibf4auBhwMXdZE+8sAA9
oISVCh2o
=Xgju
-----END PGP SIGNATURE-----

--zDypU4Oqd/lZtPbY--
