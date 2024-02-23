Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B7F2C54798
	for <u-boot@archiver.kernel.org>; Fri, 23 Feb 2024 16:41:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C96C2878E2;
	Fri, 23 Feb 2024 17:41:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HDE9iLX8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30FDB8791E; Fri, 23 Feb 2024 17:41:33 +0100 (CET)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69B668781D
 for <u-boot@lists.denx.de>; Fri, 23 Feb 2024 17:41:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-dcbc00f6c04so1062491276.3
 for <u-boot@lists.denx.de>; Fri, 23 Feb 2024 08:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1708706484; x=1709311284; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6Jo2RNhgG2GBT4StxFThw56NyChMLHafAlwVD5W73yc=;
 b=HDE9iLX8ukQ6gJxx4bv1WuS5uLebXWSxquaNzcGEpfShON/xIDgr12I/2u9zivNgOl
 TdZNW4QIpaZGE5tTpgfYxN0syT0pp096yzKeJuiJCIZaxLE2GMowefrGqsuvDOCd8ndt
 GbvyNNJwKio6hj9WmSmQdlQyYF+Oy1mdupwNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708706484; x=1709311284;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Jo2RNhgG2GBT4StxFThw56NyChMLHafAlwVD5W73yc=;
 b=sn5Rk4SG/x/s6FnOVUvcQZSpNocZi3efHfXRtTta0HJzVSdJ8kYbqpEmyJkX+NF9br
 Ak+uz9AQImLQ1dFfFo/cGf+ovV2ZugEFdubLpYR144oojc24PMbhVHUkSgujN87Ai3s3
 WOAjAD6JLVF/XzeheY73a6Wxav23ZTEOOKjt0cuNRHEHlt8PWrkOURyY1L2G9rDS/qYp
 qDG/sPi0zSEgZsra+041ffPlUal/ZpgjQjL+6Zhcu6XXey2Dhc9oS/BxO+Hs61g779lJ
 hPNn3j+yHuat7G+JA3cq6aLnsb6x5/UrJBUgM96EHrqxKXlbqc7Tn98rmFvOUtf0RurZ
 3U5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQ4/gEf5WVuGhSp3YAJzdpAgD2RXi3JKGywMwS8Ab+w6HU2B6hFTcdOv9qFOVJhDIj9Zn7xcgsuWOYUEWdMDLvIN0jJQ==
X-Gm-Message-State: AOJu0YyJaQbK5LN6k7Albdk2gvSVAnFGOr2Ie1rwrQFQxxuQwIB1lQy5
 OXB/0UxTuC7xVIKgJEEfF+nUFqIRaLW9mgX5H+09lgC+4HnVRoAXLZcWhgw9FcBJ4oOIM7F8Pm/
 M
X-Google-Smtp-Source: AGHT+IFedbROKHOarVh3P/XEcA3z112wOQfd8mZ77d6dt5ULPm79E2KVEQU/5GrwsprKirvxdp8abQ==
X-Received: by 2002:a25:a1aa:0:b0:dcd:b624:3e55 with SMTP id
 a39-20020a25a1aa000000b00dcdb6243e55mr336360ybi.54.1708706484080; 
 Fri, 23 Feb 2024 08:41:24 -0800 (PST)
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 y23-20020a25ad17000000b00dcd512855d4sm3416043ybi.58.2024.02.23.08.41.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 08:41:23 -0800 (PST)
Date: Fri, 23 Feb 2024 11:41:20 -0500
From: Tom Rini <trini@konsulko.com>
To: Jonathan Humphreys <j-humphreys@ti.com>
Cc: vigneshr@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH 2/2] arm: dts: k3-am642-evm/sk: Enable OSPI support in SPL
Message-ID: <20240223164120.GY3040305@bill-the-cat>
References: <20240223052438.2013610-1-j-humphreys@ti.com>
 <20240223052438.2013610-3-j-humphreys@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rnwl5A6p48+53Oyr"
Content-Disposition: inline
In-Reply-To: <20240223052438.2013610-3-j-humphreys@ti.com>
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


--rnwl5A6p48+53Oyr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 11:24:38PM -0600, Jonathan Humphreys wrote:
> Add bootph DT tags to enable OSPI in SPL.
> Set OSPI regs for R5 SPL to address OSPI's boot region.
>=20
> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
> ---
>  arch/arm/dts/k3-am642-evm-u-boot.dtsi | 24 ++++++++++++++++++++++++
>  arch/arm/dts/k3-am642-r5-evm.dts      |  5 +++++
>  arch/arm/dts/k3-am642-r5-sk.dts       |  5 +++++
>  arch/arm/dts/k3-am642-sk-u-boot.dtsi  | 24 ++++++++++++++++++++++++
>  4 files changed, 58 insertions(+)
>=20
> diff --git a/arch/arm/dts/k3-am642-evm-u-boot.dtsi b/arch/arm/dts/k3-am64=
2-evm-u-boot.dtsi
> index b843078243..f7ab9f9a30 100644
> --- a/arch/arm/dts/k3-am642-evm-u-boot.dtsi
> +++ b/arch/arm/dts/k3-am642-evm-u-boot.dtsi
> @@ -182,3 +182,27 @@
>  &cpsw_port2 {
>  	status =3D "disabled";
>  };
> +
> +&ospi0_pins_default {
> +	bootph-all;
> +};
> +
> +&fss {
> +	bootph-all;
> +};
> +
> +&ospi0 {
> +	bootph-all;
> +
> +	flash@0 {
> +		bootph-all;
> +
> +		partitions {
> +			bootph-all;
> +
> +			partition@3fc0000 {
> +				bootph-all;
> +			};
> +		};
> +	};
> +};

Do we really need these tags on the partition table? And if so, do we
need them in main U-Boot, or just SPL?

--=20
Tom

--rnwl5A6p48+53Oyr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXYyq0ACgkQFHw5/5Y0
tyyRVQv/fkq0n7lR3y8Z9CtW6H0cnWeyuBJoYg1ewnIjEWRssGzsIYVtmzB6OodR
FigEk1GiCfXO9jVafgllGWZ54sHYP88TkifTTfQbm9kJB+3ZjdbX44mKfYAe/wyP
OYiGoPMwNLX7hOs/a3coM7vQYp60+OeWgPFZEgaQzq05IKx+Y8F3rJytrCBV00Jx
NDvzJyRwUQsKCKsRPy5gZ15aG3qd/3LExKz7frf48brebu6u8O8v2DmCtv2LoYzC
CL3Gp5+o6npOJLW72VwDtNXAn2NM8XVTsBpG3ME1Ue3/GptTDKnRspBBTWjJknXH
nweLkNtutM8XQZ82rCQI6gBzU2S8ynVg1rKuPRPahGJpi7Loo7fuVZPzwxYR0EeH
tQE319y8i3NRa6A7SuowH+c2YEVCK0M64gEP9nj1wziwxaFlSkhVUUwulCOHgMdn
/zRFNCzZaKlPHdk8REqsrKQicERxkWUPK/ZiFYXLxkXLIjrwcAKrGxcpFo2GS8/P
H/jbwYGs
=CNPd
-----END PGP SIGNATURE-----

--rnwl5A6p48+53Oyr--
