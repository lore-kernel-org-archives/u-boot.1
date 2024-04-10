Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC34C67861
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 00:44:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B29FE88116;
	Wed, 10 Apr 2024 02:44:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cuzIt8QE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25FFD88116; Wed, 10 Apr 2024 02:44:10 +0200 (CEST)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAA98879E2
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 02:44:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-78d735b0756so87469085a.1
 for <u-boot@lists.denx.de>; Tue, 09 Apr 2024 17:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712709846; x=1713314646; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vBvGm/ViRoaBpPQl5zntWXNeujEMfLGeYnFbGNnTb08=;
 b=cuzIt8QEhRZN2+V7j5xrBVRUcRjYNUBerBaHQoHitzPXH9x4fJW1r+8m6GUmCaHPIa
 kEYCfFdsx1Y+WH1aaPvM08eQBzEUinmyOZ733Ghqlc4Oh2LFM+xgoS9iue7W8MmN1mUN
 6NWbkYinT2ufnHlyXs0JChJyDUsfHc3mho/VQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712709846; x=1713314646;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vBvGm/ViRoaBpPQl5zntWXNeujEMfLGeYnFbGNnTb08=;
 b=YkZiZ4/9s6chCGHSyjPRQI5Ahlg8Wms3XaAx8CK2/NVnPNzUUbk86xPHmiyZad6JVc
 0Wjx//CAhmSaTTPHimlnhA40sM80aFgvtYIpkON57xqMofm3DOFWuX+6//yokrrl5Tkl
 TaCFnIGgtPLRnP4sJyccmRIaaTtE5ZOS6KQTI5w8HnSqbdGtuQE1b7IUWWO31kvp6shr
 1wiT4Bci7AJcBIyV9cs0BGKOVRWVC91w4Gn5h+dyyR1IcXfI8hX2KWs8OtEbpPod59EA
 GlC6S2Sbhqk2X34zXxO+58PNEP+At0cvsCvVwc5HIUwr9zKERFUZVcS177uZrHcOmmi/
 hRKA==
X-Gm-Message-State: AOJu0Yww6+NxyEhBHjGvgCPBTGU2fE8jsfyJ7taO8T3xJSW1Kh6v7Ush
 C6SSth4Lk18JgAExferlKb3mg6LPyVfJJQoY/CIgsnmOVWLxKhJTt7zzR6u2TSw=
X-Google-Smtp-Source: AGHT+IEvp1O7D+lk0hRzO3m4cwRfGeC4PzWlN8ZPUQlyXDc6IddvxhANRWMz4lviYeNwQ3oK3XBLmA==
X-Received: by 2002:a05:620a:46a5:b0:78d:781c:d9f8 with SMTP id
 bq37-20020a05620a46a500b0078d781cd9f8mr1585822qkb.25.1712709845744; 
 Tue, 09 Apr 2024 17:44:05 -0700 (PDT)
Received: from bill-the-cat ([187.144.96.143])
 by smtp.gmail.com with ESMTPSA id
 e17-20020a05620a12d100b0078d5a756e61sm3470082qkl.60.2024.04.09.17.44.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 17:44:05 -0700 (PDT)
Date: Tue, 9 Apr 2024 18:43:50 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] api: add missing cookie checks for network access
Message-ID: <20240410004350.GD2493117@bill-the-cat>
References: <20240409131655.59157-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="D0InE+VQLBYib9eU"
Content-Disposition: inline
In-Reply-To: <20240409131655.59157-1-heinrich.schuchardt@canonical.com>
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


--D0InE+VQLBYib9eU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 09, 2024 at 03:16:55PM +0200, Heinrich Schuchardt wrote:

> dev_write_net() and dev_read_net() should validate the provided cookie.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  api/api_net.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/api/api_net.c b/api/api_net.c
> index 7515c26e8b4..0b931a80787 100644
> --- a/api/api_net.c
> +++ b/api/api_net.c
> @@ -72,14 +72,16 @@ int dev_enum_net(struct device_info *di)
> =20
>  int dev_write_net(void *cookie, void *buf, int len)
>  {
> -	/* XXX verify that cookie points to a valid net device??? */
> +	if (!dev_valid_net(cookie))
> +		return API_ENODEV;
> =20
>  	return eth_send(buf, len);
>  }
> =20
>  int dev_read_net(void *cookie, void *buf, int len)
>  {
> -	/* XXX verify that cookie points to a valid net device??? */
> +	if (!dev_valid_net(cookie))
> +		return API_ENODEV;
> =20
>  	return eth_receive(buf, len);
>  }

Is this right? Probably. But what triggered looking in to this to start
with? I don't think anything is enabling the API support these days
even.

--=20
Tom

--D0InE+VQLBYib9eU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYV4MYACgkQFHw5/5Y0
tyxouwv/XyKtkH7pC0aL0ycwuICIuWLxUhL2rSQZ63MqEY+kJTE60/3dkG99S1HB
gqVmJbPVOj87cVM0ynkr33Ch/e6u20+CXBtUJIi4dDGTnNYXMdi97/FNLvwFE907
Fqop8SJFql+WYADhSEz5Y9R/ZOmPHdxTKdjIbe2qAd6nMeiEd/Z56s1+ioR3YFe6
22gtL7fegtlJVeyA2hOp8DluihHvHps+EyHcuT1TsNs6iuQBss5jru73fuTD/2D7
3/kJd9HMQ9D5eE0FEE4LDYlNYIjFz/TFgeee5BZaYIGbEugdfod0fLuxc9RK29fC
/mps4H+5M2dVCvHuwKJLnJACkHKw9B09RFef4d041TFPyh9qNUzZdJUfpvjDat0+
cAXS3KNx6fdj/gj2l3BnJ1nTmgkyYioEw8pg9DXUMIuEcU/K2FcMDgwVN4LI/Hn9
iuFPzjbPF/eLmkqlQXEac5n+Bhmvw/tH2RwvpChiZOGzzgRnHzJ/YjLVGWhJlR/A
WR7XZC+s
=2mvW
-----END PGP SIGNATURE-----

--D0InE+VQLBYib9eU--
