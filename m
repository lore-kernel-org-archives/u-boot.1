Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04884C47DA2
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 14:26:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A330C87B6E;
	Wed, 17 Jan 2024 15:26:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="U0krW0ob";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CD2487B6D; Wed, 17 Jan 2024 15:26:18 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 680EB87B66
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 15:26:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5fc2e997804so46420797b3.3
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 06:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705501575; x=1706106375; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mmwoa4LEXvti6Z5CRqkQiaEv4/90zVG4QtLyRmjmJT4=;
 b=U0krW0obaZ670eUtdiinkYM2Oz+u0W/z08gQkMGchDCavQ19c5SrDJ4KrzsbjqdSuq
 CydVYP4LX796PfHKQ2T7h4EQPhjQkf24IOyNXPsjDBk2YsUw8L9GdcGiIwa+GPzyh93A
 /MsE+eOF9MSGp2sMnC6Oowj14eMp436yZEw/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705501575; x=1706106375;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mmwoa4LEXvti6Z5CRqkQiaEv4/90zVG4QtLyRmjmJT4=;
 b=RajvX6HzLUaEIGfCn8q9Bvopfz8GjWbECLns/7dDx2B60Tl4QDVzkdKNv2pwZtYcd3
 uUC6R+PagzZ0QXjqvyCXctGGYpenWS+37qyDXnRYqwy9S9x38q6MPI8J/60Pcyl9j8p9
 MCjV+LH1VzG1P260mlGj3d4Mcps+JHIsZXbS+vpE3v9Njy9zoaFdvkwn+cZ4iqu+2FQ8
 lK5rll3O2D1JJ9IgZunHRDDA7YAnGB7rn7/8PcL7zbBgTEBJuGt8YZ/477xJ/bPWzFAA
 +wtgkvCGTtR0brfp7BGKO79RAmuOckb+0opOR7yz6qp3zVy/wUB8D7eu3CsZOUOXHXQu
 nq9g==
X-Gm-Message-State: AOJu0YwWpo1pPWXk859N26/o0oTYXIECNZ7Zm0lmVftnU8MyJquw/yep
 1N5gCYskqCF9sNeZVby+gv/JCoEBHPSDkPseSDXX8jt3bDI=
X-Google-Smtp-Source: AGHT+IEIDhwnDfPXjlOIrKmwtI1VcFMvA3eAAulWGDZPmglNi9HsidKOS6k0FuyJXRDCt0xEYgLYUA==
X-Received: by 2002:a81:8d42:0:b0:5ef:c519:76bd with SMTP id
 w2-20020a818d42000000b005efc51976bdmr6360319ywj.25.1705501575203; 
 Wed, 17 Jan 2024 06:26:15 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 d70-20020a814f49000000b005fdc47c460dsm2068366ywb.23.2024.01.17.06.26.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 06:26:14 -0800 (PST)
Date: Wed, 17 Jan 2024 09:26:12 -0500
From: Tom Rini <trini@konsulko.com>
To: Love Kumar <love.kumar@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@xilinx.com
Subject: Re: [PATCH] test/py: mdio: Add tests for mdio command
Message-ID: <20240117142612.GI12635@bill-the-cat>
References: <92907606c7b930808b82582bea752d4cee13cae6.1702988434.git.love.kumar@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kaCTbZqoYh/ks6OJ"
Content-Disposition: inline
In-Reply-To: <92907606c7b930808b82582bea752d4cee13cae6.1702988434.git.love.kumar@amd.com>
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


--kaCTbZqoYh/ks6OJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 05:50:51PM +0530, Love Kumar wrote:

> Add below test cases for mdio commands:
> mdio_list - To list MDIO buses
> mdio_read - To read PHY's register at <devad>.<reg>
> mdio_write - To write PHY's register at <devad>.<reg>
>=20
> Signed-off-by: Love Kumar <love.kumar@amd.com>
> Reviewed-by: Tom Rini <trini@konsulko.com>

Applied to u-boot/master, thanks!

--=20
Tom

--kaCTbZqoYh/ks6OJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWn44QACgkQFHw5/5Y0
tywDawwAqYbO1SCmUitOMCYTWuJYhkCFoN6lcWb4GH/oo24IHFqXxPYQP67HYEyd
BJZ4cA0tLFotspqWCD9U9URMhay4j6/FDc12D/O8A/NSPQLyNMpRo7Ofh9vIxCbs
1YjzdK8ZSl7qSDE7bbOq2u8CF/I2zHcTMs5eVA07VUiDbuG/V4n7T3LEyEQey8/4
q/V2Vtkm+3FKxMlHmkASViBPygqh0gFr8G1iTibkplXcV5jZRZsHZJ9UcLt6FCXK
nlYzRrR1I//s+SQzQy0slozqbGZO/BkHArSxr8hPXl32tU1A2OelGVaF1mlVSSQ2
cRgT9ajToCoGw02+clXoHT8V5arxn/fO4DQ2iVnZU/ETLYA9Ob1Tz1Lbc9smCiDT
ZlvwZwEzxFZefYmsGpeX0J4XuPA8hDQNhlgbS6F2reUSOKjMk40O2K454NC9nZcK
cDARnXQiWGlDnOlwJy49W0E5f54WXHnVO32MCihFfRNFHDQ25Ntc8pAX8k/chbNf
pHljpYUK
=C7mv
-----END PGP SIGNATURE-----

--kaCTbZqoYh/ks6OJ--
