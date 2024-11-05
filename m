Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 945E7D3E779
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 22:39:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDDD688E74;
	Tue,  5 Nov 2024 23:39:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="E4NXg18p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A59778904C; Tue,  5 Nov 2024 23:39:00 +0100 (CET)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A28BB88E65
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 23:38:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7b14df8f821so520000785a.2
 for <u-boot@lists.denx.de>; Tue, 05 Nov 2024 14:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730846335; x=1731451135; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KLd/L4ukna6SchqNWIPw2qIqDu0vFsWbigQk6BTGB64=;
 b=E4NXg18pbtRh6CaYfl58aSSVLh5zx8Iv/0L0IvK4dI9fMRjf5P1b+iUAFH4K+7Cywi
 AJixXl8Y7pW6fSqnpEiveneP6GH5JwsX2ukZc30X3YBm8spz4Ix57coyEnofPmIkfSpu
 qMLvyo52S1gTfW/TogKRg1L546s4GljU/Q2QE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730846335; x=1731451135;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KLd/L4ukna6SchqNWIPw2qIqDu0vFsWbigQk6BTGB64=;
 b=lUCBIgGcZ33Xnv9FA/X5KgsHITGGIN/HvBfiuG09Fn5FyN7Gm6sxu/FXdXXGGIz97b
 MCoYBQXEkzswv0gYzPaTE5mRWG7cXIA9zasUqLCHLggCUyyivQXHJ013Fp/2Pq1R+D5P
 3TsBgvc6YrMIHUJCHfVIlduEy8jEdDkGr/Lb7D/TvHQLusfyIzQvJwnADewN9s7q6Xsj
 HDFa3t6zE/NHqxYYPZGD82TjamEqGEJzp+pTF4AmKj67ydHVwdndHwxMtdUnC9TDVf6E
 Bl22eX1INFeruoj2balw2G32nA0BuVSUmfeupm9RDYm6FrKJX2FX+1bX+VtZUPdnyuNi
 xQWg==
X-Gm-Message-State: AOJu0YypYmN+kti8UDIlywNOVYQYkD4W7kxl2W/bTJRlDoCB5+oZFZWG
 2yh2QDqImYJlduN+eO8RkjErntookCLtnQa6lGMLIAxVdcMcHXFLNcKNmKaeFqM=
X-Google-Smtp-Source: AGHT+IHPBMJkKpAh42qvtFO7jVk6LJzSUnF7p21UrZfy3GXPSPeYiYkZPism90/iuuCuAjtd0UZkBw==
X-Received: by 2002:a05:620a:2908:b0:7b1:54e5:6183 with SMTP id
 af79cd13be357-7b2fb9d8775mr2858613785a.53.1730846335524; 
 Tue, 05 Nov 2024 14:38:55 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b2f3a0bdc9sm569330085a.63.2024.11.05.14.38.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 14:38:54 -0800 (PST)
Date: Tue, 5 Nov 2024 16:38:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, mbrugger@suse.com, pbrobinson@gmail.com
Subject: Re: [PATCH] board: rpi: Change from CONFIG_ARM64 to CONFIG_PHYS_64BIT
Message-ID: <20241105223851.GO3600562@bill-the-cat>
References: <CGME20241105221938epcas1p10c135e07759fd408aa11bb5b0b246195@epcas1p1.samsung.com>
 <20241105221936.508328-1-jh80.chung@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DlBwtuIXytvHOkWv"
Content-Disposition: inline
In-Reply-To: <20241105221936.508328-1-jh80.chung@samsung.com>
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


--DlBwtuIXytvHOkWv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 06, 2024 at 07:19:36AM +0900, Jaehoon Chung wrote:
> initrd_high is dependent with CONFIG_PHYS_64BIT configuration.
> Even though CONFIG_ARM64 is not enabled, CONFIG_PHYS_64BIT can be
> enabled.
>=20
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  board/raspberrypi/rpi/rpi.env | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/board/raspberrypi/rpi/rpi.env b/board/raspberrypi/rpi/rpi.env
> index 30228285edde..47529b0b7a68 100644
> --- a/board/raspberrypi/rpi/rpi.env
> +++ b/board/raspberrypi/rpi/rpi.env
> @@ -61,7 +61,7 @@ dfu_alt_info+=3DzImage fat 0 1
>   * only 64M, the remaining 25M starting at 0x02700000 should allow quite
>   * large initrds before they start colliding with U-Boot.
>   */
> -#ifdef CONFIG_ARM64
> +#ifdef CONFIG_PHYS_64BIT
>  fdt_high=3Dffffffffffffffff
>  initrd_high=3Dffffffffffffffff
>  #else

We really need to drop both of those _high variables in all cases and
set some reasonable bootm_size

--=20
Tom

--DlBwtuIXytvHOkWv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcqnnQACgkQFHw5/5Y0
tywqUwv9EQ0r5GYyyaLMETeImoEqzp8TJaMsMifEvHwDKRjK8Wk1+35Mp+cgdli/
Xb04yf6og35LVlqvwgMMJk+4cV83JmSW/Rqs6u9Hpn2XpG9WlEsPkaMvIig+qOt0
GIh4PyPLKg204iwp1vVX3RrMEDkpSAyrlx8pt9ElIFzoI3j/f5iHiyf8fmTVRPkp
Y8m9D/Smp5BcIOns8rYULnRnmRkml31j/6rFk5L3t1FhwXOqbGmZNEM2qMKbNuwi
fhPWh0yxwXMpPAfl5x2JWisrrMdlrLyqY6UAf9MMDTQVlrug7NhgFeFnJGH+u2VG
rAbrDBJ7CuEMMLjkGqgzk/FS08U1JpF4DJjSibO88bLgKdtXH5uDguniGaGkT8d4
LnLBY9i2QgVb2vDFiKoPgOGtfLLp0nQhyseyXl3P/UTt6LKP/jZBOcMLrOGGf3Y5
VEmPir35sslYJp2XP/NbDQkEqtKppmbh3LlTkY+Gt+2T2xU/3X8Ss4QKuhZIxpy3
PIGyp82K
=KQRU
-----END PGP SIGNATURE-----

--DlBwtuIXytvHOkWv--
