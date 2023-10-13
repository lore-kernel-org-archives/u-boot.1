Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 281B6CDB47E
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 16:53:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 122EC86EF6;
	Fri, 13 Oct 2023 18:53:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eD4xKbGr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5184686D62; Fri, 13 Oct 2023 18:53:10 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7345E86B95
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 18:53:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-66d0c777bf0so12018726d6.3
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 09:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697215984; x=1697820784; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6TF1gagVcrxU9ufwicMrILpwQDPxr+sUdLX3UHr1S14=;
 b=eD4xKbGrAduWQeoMX6o87ufuURdUsDolVD0DjoQsMrsC3VE1zEYr+Uz/beCXyt23PS
 9da+M9iy1W/UUS9MiUwxKqMUIjBGujCozQy3/bpg/pJYH3RkA17QRq5ACwWSFs87cKoF
 FcHXe9LhwsGnLvxO+vZN7EQOjpB+Vvx8X3f0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697215984; x=1697820784;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6TF1gagVcrxU9ufwicMrILpwQDPxr+sUdLX3UHr1S14=;
 b=fRfNEg8nmHEvJNUfyYyyVG0jqmGL3DZLjOONwXxdzQbfYfs1o1wJv8/Y252bxjJBnf
 MJoLnxf6y7xQTLjTKKFybBRLwlKSldtMP93OLvqbczkaE4QnrXY14YBgzn2a15FHKGLE
 JWZ888YSfgF7+ZDRRg/DLHPGJJzPdTXrOcrqICZITHVNfOD4a2Rj9D/tLi7D8t433tMp
 RbQyMZbWeGohc3BcNKx2OWXXUb0w0ebRdd22ajg7qiAh14oXwO69i8fArtW+KeQ6XmER
 5uLSl2Y0PCMs8lrOwaCVAvzxP3g14/fh1CJBBvs2bGTP6/idHfCK/tvMY9QObE48PbFx
 P0Hw==
X-Gm-Message-State: AOJu0YyfN8wK/TciAkF41Bg+TxQcoPnY3Crdopv3U7gbp3tpOm9UKvc5
 /+co9UsObW5tfeqvdcKxypv19w==
X-Google-Smtp-Source: AGHT+IFfHM7nvSOh3QvSm7NFaHId5N5v9A1bF69ZFKb1rnSpCrhCqXWD7NIlgJ55UZMiAtpyk3U9aQ==
X-Received: by 2002:a05:6214:5c06:b0:65b:2008:8a3e with SMTP id
 ly6-20020a0562145c0600b0065b20088a3emr28944719qvb.46.1697215984251; 
 Fri, 13 Oct 2023 09:53:04 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-b33e-4d05-2330-607e.res6.spectrum.com.
 [2603:6081:7b00:6400:b33e:4d05:2330:607e])
 by smtp.gmail.com with ESMTPSA id
 dz1-20020ad45881000000b0064906cfe430sm793637qvb.135.2023.10.13.09.53.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 09:53:03 -0700 (PDT)
Date: Fri, 13 Oct 2023 12:53:00 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Paul Barker <paul.barker@sancloud.com>, Simon Glass <sjg@chromium.org>,
 Weizhao Ouyang <o451686892@gmail.com>
Subject: Re: Pull request efi-2024-01-rc1
Message-ID: <20231013165300.GQ3119521@bill-the-cat>
References: <090248a1-7ff1-41b9-91d6-270f53031b10@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1UD1xGQUPhiwoegc"
Content-Disposition: inline
In-Reply-To: <090248a1-7ff1-41b9-91d6-270f53031b10@gmx.de>
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


--1UD1xGQUPhiwoegc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 13, 2023 at 04:51:31PM +0200, Heinrich Schuchardt wrote:

> Dear Tom,
>=20
> The following changes since commit 997bef3c6d22d12c7fd092fb831bf94d114c9f=
6f:
>=20
>   Merge branch '2023-10-11-port-gen_compile_commands_py' (2023-10-11
> 13:25:01 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-2024-01-rc1
>=20
> for you to fetch changes up to c1ab04626d6b05c6e82dfe4d97d3f62f7310d612:
>=20
>   efi_loader: use well-known guid for auto-created boot option
> (2023-10-12 08:32:27 +0200)
>=20
> Gitlab CI showed no issues:
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/18093
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--1UD1xGQUPhiwoegc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUpdewACgkQFHw5/5Y0
tyybKQv/RnTlle2602yrdIjEYuj/y0kUhUov/OUc7vNIPwhCMvVdDdOVEFXS0snf
+YMnfql9OzHf/nqEBLVdLeIT5f++BRUXllnMB9BvpdTlityGHRCH9AIueUMmj79X
mDfwYzsWgeX5FuJYviwsS5+Te13NFiJFHRg0SiX0QZwc4SUinf5zNs+ItSFVxTvQ
JvAWufVPXItAd5G6B8M3XQYIzSCojtikqlnranaPEDzJu+DzPAMl6AuR6BUwUxVY
qzOL+WQd6hjN61DQqNn1nJVUhhd7Cwxg5NqGzLAIULnAfIaD0qiCUS2KoeUqq4pS
iDzOXMCD9otXH2AeCDvDOBaRCEVXPrOn+Y2cy7cpn8Z9Fvyj/zMoxEpu9YCnCzoc
cUcaK+oeajDFQ2ehGJKMMFcSh+CSXqN9rSl00S4If2uT7z0Nm8KRabCWqyLKYeGi
fImyOiX30GHNBBhiPvtZR8zagaBpWCNOLnbIqOjkdG1oQ9Rdt170+gkF9SpKIdeM
CSJNvYqd
=7HB5
-----END PGP SIGNATURE-----

--1UD1xGQUPhiwoegc--
