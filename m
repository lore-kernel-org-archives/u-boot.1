Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DAD4C282EC
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 14:56:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A220081197;
	Tue, 11 Mar 2025 15:55:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jUkQ9o5D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADF0881335; Tue, 11 Mar 2025 15:55:57 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 371248083E
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 15:55:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7c559b3eb0bso111429185a.1
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 07:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741704954; x=1742309754; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dDw+7zgtklvCkemcrfKVX2oa32Tc5XvL59jgkcskGS0=;
 b=jUkQ9o5DbrVbYboHsQHSxouf6UY8TJWz+fAbRnYIe4Tp4NFcI7FueZh5m2/vz99Puc
 ogwNWlRfU/BuhcqVmd1CSZkEWjYlq3hQ+J9w8sZAPhjCHGoJ/RIlHOfoNCNaysVhGl9u
 /e8UbW+8ZG5jZp5JRaRixAFO6QUjp5c/CZ4tU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741704954; x=1742309754;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dDw+7zgtklvCkemcrfKVX2oa32Tc5XvL59jgkcskGS0=;
 b=tZnVHHWQnjLtVN5oA0IgHg+P63cL7KpnJ70ydiW3xzQuTv2hGHTvmOmRtuutVldEwV
 pCi+YoCdAxpGHXwbfkJqTuxVjhpoFZXXZZlAvlMvpAG3b1BUI0g858VYmvAumH46JKtw
 tnUIhlcyjCiaciXnC/ndcPY/JCfSf1PWCBjx+ostBPM+qPENx50dfxW3uEIELFo9U0cm
 0eLDSrrfcPv6xfdRgYagBe07NesU7VbiRtNRsvb4jxgsR8cGxpg0UgO3U71xS6upaxDK
 AFi59T9eXG0eo4h6WnsLrILDNn7aGV6cqG1HSbpUah/w2VmGe1zrXIYdLf4fdHUVLHdo
 Ykfg==
X-Gm-Message-State: AOJu0YxTopqzHOwRAtiM8vQvJft5UUJAjonzMF43+xEr/yRyfHPeJW3M
 06TflLIOwuFjC29sAH6xNrcSCUNJat6Fz1Sso+dUUMF4ixplljUHHjxURzSHl/Y=
X-Gm-Gg: ASbGnctMVpeFJ4btbEd8P32gId/PjhYt8YjEx/xZBRgxHCRh3upVhNo8O0gZDtBQpa+
 Ky74iiJJoOt9gZMTXWOeDAe2A4pJSgEF6FocNGkuHxwKQF7j+d6KmlDe86YMUwpJK6Qsj8pZmUC
 xK0FdNNc52XPSmYcAsjfuyT9b+vJ7+m1p8P1bbkwGP5puk3BEvYgYHVpWZ2oog4JcrhgmCWnrJ+
 mnJ1XKGdU+ARU8KmeONmm7/d3PrJcrAOiWKQvQ4ELtzRdZK7TrLbEjtd79oGrCc4315n1QpVBwR
 aa19L8YfBxR1akedrU4kNmd6xBYrCoKdTcYmZjkikYeCdQ==
X-Google-Smtp-Source: AGHT+IGyK4Lv+1ikJdtML9XO/kKut1mb+47ktombol2/otd7wVqYXUk/d9gLTmpfJfsb6TFMtUsrsg==
X-Received: by 2002:a05:6214:20c4:b0:6e6:4969:f005 with SMTP id
 6a1803df08f44-6e9006c8314mr224017706d6.30.1741704954031; 
 Tue, 11 Mar 2025 07:55:54 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e8f707c4b5sm73101916d6.1.2025.03.11.07.55.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 07:55:53 -0700 (PDT)
Date: Tue, 11 Mar 2025 08:55:50 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com
Subject: Re: [PATCH v1] spl: remove usage of CMD_(BOOTI|BOOTZ) from image
 parsing
Message-ID: <20250311145550.GU2640854@bill-the-cat>
References: <20250311093709.3372104-1-anshuld@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+8LZoQ6UhblfD9bH"
Content-Disposition: inline
In-Reply-To: <20250311093709.3372104-1-anshuld@ti.com>
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


--+8LZoQ6UhblfD9bH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 03:07:09PM +0530, Anshul Dalal wrote:

> Using CMD_* configs from spl doesn't make logical sense. Therefore this
> patch removes the check for CONFIG_CMD_BOOT(I|Z) from the image parsing
> code during falcon boot and adds compilation targets for image.c and
> zimage.c on SPL_OS_BOOT.
>=20
> More info:
> https://lore.kernel.org/u-boot/20250310135544.GV2640854@bill-the-cat/
>=20
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
>  arch/arm/lib/Makefile | 3 +--
>  common/spl/spl.c      | 6 ++----
>  2 files changed, 3 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
> index 1c95dd6fed2..0e36d493aee 100644
> --- a/arch/arm/lib/Makefile
> +++ b/arch/arm/lib/Makefile
> @@ -36,8 +36,7 @@ obj-$(CONFIG_CMD_BOOTZ) +=3D bootm.o zimage.o
>  else
>  obj-$(CONFIG_$(PHASE_)FRAMEWORK) +=3D spl.o
>  ifdef CONFIG_SPL_FRAMEWORK
> -obj-$(CONFIG_CMD_BOOTI) +=3D image.o
> -obj-$(CONFIG_CMD_BOOTZ) +=3D zimage.o
> +obj-$(CONFIG_SPL_OS_BOOT) +=3D image.o zimage.o
>  endif
>  obj-$(CONFIG_OF_LIBFDT) +=3D bootm-fdt.o
>  endif
> diff --git a/common/spl/spl.c b/common/spl/spl.c
> index 76fd56dfe4b..79149ba07db 100644
> --- a/common/spl/spl.c
> +++ b/common/spl/spl.c
> @@ -335,8 +335,8 @@ int spl_parse_image_header(struct spl_image_info *spl=
_image,
>  		panic("** no mkimage signature but raw image not supported");
>  	}
> =20
> -	if (CONFIG_IS_ENABLED(OS_BOOT) && IS_ENABLED(CONFIG_CMD_BOOTI)) {
> -		ulong start, size;
> +	if (CONFIG_IS_ENABLED(OS_BOOT)) {
> +		ulong start, size, end;
> =20
>  		if (!booti_setup((ulong)header, &start, &size, 0)) {
>  			spl_image->name =3D "Linux";
> @@ -349,8 +349,6 @@ int spl_parse_image_header(struct spl_image_info *spl=
_image,
>  			      spl_image->load_addr, spl_image->size);
>  			return 0;
>  		}
> -	} else if (CONFIG_IS_ENABLED(OS_BOOT) && IS_ENABLED(CONFIG_CMD_BOOTZ)) {
> -		ulong start, end;
> =20
>  		if (!bootz_setup((ulong)header, &start, &end)) {
>  			spl_image->name =3D "Linux";

We need something more clever here now however, likely some new HAS_...
symbols. What you do here means that all OS_BOOT platforms will have 32
and 64bit image support, which isn't what we usually want.

--=20
Tom

--+8LZoQ6UhblfD9bH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfQTvMACgkQFHw5/5Y0
tyyGUwv/VInqyNyoNqJVGw7jj6sG8Jdf3xNytMkTqROsBQco2GMQV+SPdmJMSvaV
0dat1+ClwuF0Op42DIWTa5nR9iuJqAy0qXBiM4JTseHEkgUx54rvgbjWawU3LtGh
9UPC5yTK8OJEvApCgSacai/mj5+oAi9IFT+n8iOCFKj/Ux1l7k9VvAkXR5bb5qJW
RD0QS+0q/YPmwTNdajQmmlRkoEDMj6FKTAmgJNNGhcfFtqxGqOeNQN28xutAyDHo
q0x93IXZx5efBobZsgssbqZcewzEgoAECS/wKOGWPFgFh+xhh1KTFd7/ah7z8N5X
RUZknulNuxT7agmuHhkEbTkkQcsHJDtZ2BuGrcKdRJVDvJbmayvshs+GG8TwCfLD
OMhdLO9yARDUW1Y6eCcPl1UxzDh/abLEC1zDgQCty1mkiRubIwmlFVQhcWmnpL85
4HEtpnD/ZFdXYRYrBUx0KKSfs8goy2ihPsKnbxQJnMw3HBPSO+PPD0Fr1lZo1B+d
TecdnudB
=RPeY
-----END PGP SIGNATURE-----

--+8LZoQ6UhblfD9bH--
