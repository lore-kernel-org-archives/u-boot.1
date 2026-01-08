Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27AC6D1D478
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 19:37:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FB0B84150;
	Thu,  8 Jan 2026 20:37:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="j9bIy6Kg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80F8784285; Thu,  8 Jan 2026 20:37:53 +0100 (CET)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3423C84132
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 20:37:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-455dc1cf59aso2135409b6e.0
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 11:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767901070; x=1768505870; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RLk6RGYsd6WTQWYkiAVdg4BBJM9ywaJWVh5e0HxNTB8=;
 b=j9bIy6KgMOWiwoOxFsVYFF2o72xd95XNJiGi7JbQnmVaF9sBAG3FX+V1RmakrdUt20
 yUT2rDdtlv3gYTBe7RPqVOxZHwbzal5WMI41rw4pUlLGcKx4PzlCUPe4komA17cb611P
 jJEYKKk02xuWYuW7z6b5scabKlcBWvlhNE4RU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767901070; x=1768505870;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RLk6RGYsd6WTQWYkiAVdg4BBJM9ywaJWVh5e0HxNTB8=;
 b=ti6T+NUSf1OCCEjeekUihhWQ6Yn52HYRahOB5VWLFdXaazj3LExXAlexE6FJR5wA3g
 O1iGenC0AhBsJOmZfseRFJOPqIozKuzICLE5tLVFnxR0A9eFY/qNm6V5ftA8qepWVUVS
 402qV3pGWO0yUEHISt7yZpi0ITFG0r1HpG6oT0DkRoRJNHsCe9SbttGxNb24M+iVkjpU
 6YA6TXiytkQXs0iO6cAGTE0cbUaipKT4CjalqviMoAWwtz154mdkxfhNx/tTvoQbFgQA
 +klmThkXvYz5ImyKzFT8RC7Yc8ltQatdQs3DJgx/22LqrnL/vVH5UEFx04hFOuc63x8n
 W5pQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFAPfG40X+XaUBQC8inJiKWeBy8wj9qTmQ7BRyynOZ+32lWgq+n+p+p01c7BAEFQ3QzR9j3X0=@lists.denx.de
X-Gm-Message-State: AOJu0YytQA+8EN6R1YDotTgSL0mNhMBkz+OUt65+NGOfDvIfs7r22Jkj
 /13rxMsdlqdqdEUmiQ4LD7gls5m/f/z/TtrpZ5HIHfTGIRxLbmK9htxQFyQQK55AVpKyEFlnD5V
 LIHSJ1Os=
X-Gm-Gg: AY/fxX6vgF1JI4NAoTQ2ozW7tMgwwQyoLNeiUNjgeWFfzYMSRFULlbzOsCUEaEyHKvV
 Dw4qiaHka8ENUetN1IvyBQtyt2cnId/+5UAO6S6HMtpNdFxYbPqI9OFJ3AtszrBt4+73q6oXhsC
 01SzlVZ6Vo5bemCEWH/owPBYMfbb/HZEsL3ZtMHd/DYuf8uC3mY/1YCBdZkiVN1Yq27zBA66acU
 VWji7+IKmyNFklaIMtC2kt+IEOkdupYNwaR7RA7u1qUDScooEBEhny1fqCNxOnal7GPwrlgcQl3
 xhVoYGXgyL/Xzh2Y0aTlU6MJpYs65BepLPjysLeu4bwtE7L5UfmtPcJW+7nHOfLTYKOPD/A2l8j
 E5sdtVfATeGN/svx4dbKe7tcgEKXpHmqdW3TARTiNhI65z7SE7vzfQvG/sCv10l3uKpVta2et6L
 OZOPWf1BOmsBQm/28LvUCkD1DO+6xCWFf44atb44Mzjxm8U1fgltpqykRyry3Vw7BbmRbfV3hvS
 QNxg/GovQlKKa4HmAdz1u8RCpfg1r8VtLJhOps=
X-Google-Smtp-Source: AGHT+IGSk2U48snIon+HsIGXnJtjqH6WHkD0eycY7DXgBhwzYJ9cs9orBkxsBd0V1/0x/uF2cO0/VA==
X-Received: by 2002:a05:6808:5192:b0:459:b40f:8404 with SMTP id
 5614622812f47-45a6bd3d92fmr2833510b6e.29.1767901069859; 
 Thu, 08 Jan 2026 11:37:49 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ffa4de55ffsm5490538fac.2.2026.01.08.11.37.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 11:37:49 -0800 (PST)
Date: Thu, 8 Jan 2026 13:37:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] kbuild: fix out-of-tree build missing gpio.h
Message-ID: <20260108193747.GV3416603@bill-the-cat>
References: <20260108184032.3084584-1-casey.connolly@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/eBsJkmFWoiB7E5t"
Content-Disposition: inline
In-Reply-To: <20260108184032.3084584-1-casey.connolly@linaro.org>
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


--/eBsJkmFWoiB7E5t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 08, 2026 at 07:40:27PM +0100, Casey Connolly wrote:

> When building out-of-tree $(srctree) is typically a relative path, the
> kbuild 6.1 sync uses it in more places where KBUILD_SRC was used leading
> to issues like this where we create broken symlinks.
>=20
> Fix this by creating the symlink with an absolute path like the old
> behaviour.
>=20
> Fixes: bd3f9ee679b4 ("kbuild: Bump the build system to 6.1")
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>  scripts/Makefile.autoconf | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/scripts/Makefile.autoconf b/scripts/Makefile.autoconf
> index e3c88badb529..522389e04e8c 100644
> --- a/scripts/Makefile.autoconf
> +++ b/scripts/Makefile.autoconf
> @@ -137,9 +137,9 @@ ifdef building_out_of_srctree
>  		dest=3Darch/$(ARCH)/mach-$(SOC)/include/mach;			\
>  	else									\
>  		dest=3Darch/$(ARCH)/include/asm/arch-$(if $(SOC),$(SOC),$(CPU));	\
>  	fi;									\
> -	ln -fsn $(srctree)/$$dest include/asm/arch
> +	ln -fsn $$(realpath $(srctree)/$$dest) include/asm/arch
>  else
>  	$(Q)if [ -d arch/$(ARCH)/mach-$(SOC)/include/mach ]; then	\
>  		dest=3D../../mach-$(SOC)/include/mach;			\
>  	else								\

I think this was resolved with:
commit 726d11289f2776098b6fcd99b413b590782a556d
Author: David Lechner <dlechner@baylibre.com>
Date:   Mon Jan 5 14:35:04 2026 -0600

    scripts/Makefile.autoconf: use abs_srctree for out-of-tree symlink
   =20
    Replace usage of $(srctree) with $(abs_srctree) when creating a symlink
    to include/asm/arch in out of tree builds.
   =20
    When building_out_of_srctree is true, $(srctree) is just "..", so the
    created symlink was broken, for example:
   =20
        build-mt8365_evk/include/asm/arch -> ../arch/arm/include/asm/arch-m=
ediatek
   =20
    Which would resolve to a non-existent path:
   =20
        build-mt8365_evk/include/asm/arch/arm/include/asm/arch-mediatek
   =20
    To fix, we need to use the absolute path to the source tree since we
    don't know where the build tree is located relative to the source tree.
   =20
    Fixes: bd3f9ee679b4 ("kbuild: Bump the build system to 6.1")
    Signed-off-by: David Lechner <dlechner@baylibre.com>
    Tested-by: Sean Anderson <sean.anderson@linux.dev>

--=20
Tom

--/eBsJkmFWoiB7E5t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaWAHhwAKCRAr4qD1Cr/k
CkvlAP463nvuciuRH/xACfeWTOYgYFC74zaE7I/77zhmi57jJQEAks5fEW6da7+6
TpvPnAmDaGKMvleESo4l3qXKlkoIyQo=
=jplJ
-----END PGP SIGNATURE-----

--/eBsJkmFWoiB7E5t--
