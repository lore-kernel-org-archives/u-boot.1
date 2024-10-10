Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28AA5CFC5E7
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 17:32:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DFF888581;
	Thu, 10 Oct 2024 19:32:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Nlay+jQQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71E0488387; Thu, 10 Oct 2024 19:32:44 +0200 (CEST)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AED98910B
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 19:32:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-46042ee22a7so7300441cf.0
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 10:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728581561; x=1729186361; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=11pIpyWIVDU000JbvI0Rz7QQ61zDhM5GNc19LmkxDPg=;
 b=Nlay+jQQsInMStyckdqK7DR0pzwWPd8KiUkoYzY/qapDni4mP5K4pKEhs4aLt5mtpM
 vs/YD+uvv/oEeNAD1Qgc9Fa5z2UGPxN2Y+aeW9kcgMi0+uZKG6ME8eTaR/Xm1Suo7H72
 blN1mA6kU9BMNdmNAcUjYI/TxERNeqj7nQxY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728581561; x=1729186361;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=11pIpyWIVDU000JbvI0Rz7QQ61zDhM5GNc19LmkxDPg=;
 b=Mk16N/Wu7n43BMYtOJcOOpZzfi57ZzIQ4SdP38Fbzp/6oTqmSR0WrqCAXODZemEV80
 ZA38bgUdsNknw1qy1Y2m4+/zzcUyu5vSKTkCZfUg5o97pgq2gtf24/8jnUsOaUQU8iKj
 ZeWXgV9EJpUly+RC5VE+937x4Bw77Bv2X4HsrU+xFnXPAYMBaBtskAf9fnFudAzBwujz
 oWJA64qNxxWegYULsNnaf2fCSzBhmAZNEZuuNlOO8FwU6E8g6ggsom6xP3okj6QdOKqH
 6PK7gWw4TVjaf7jt71xSYdtThGjbQWFCiOY8AMVqBjDDc3HE4SNDSjQe9ZOXlG+pHVI6
 NLrg==
X-Gm-Message-State: AOJu0Yy6ZiCx5lkGDzt8jo8f/VCvnGGWAzwT38m3xNsvL8uEIW/OKskb
 c/KG6Tz+TJQnNF8CpK5mzZsKzody/tYLTxu59eWn/0mJwFq0ohEb0leFIQq6WmM=
X-Google-Smtp-Source: AGHT+IFQqd6XoLaW+d55mZIDDiPR4iOhiW4evP5uyTbhRzHvHNu8UGeHgm5G5TP4tyzjfnF4Li4l/g==
X-Received: by 2002:a05:622a:5c89:b0:454:f384:41e7 with SMTP id
 d75a77b69052e-4603ed1d93emr64449581cf.8.1728581560888; 
 Thu, 10 Oct 2024 10:32:40 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4604280dcafsm7192591cf.57.2024.10.10.10.32.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2024 10:32:39 -0700 (PDT)
Date: Thu, 10 Oct 2024 11:32:36 -0600
From: Tom Rini <trini@konsulko.com>
To: tkuw584924@gmail.com
Cc: u-boot@lists.denx.de, jagan@amarulasolutions.com, vigneshr@ti.com,
 tudor.ambarus@linaro.org, pratyush@kernel.org, Bacem.Daassi@infineon.com,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: Re: [2nd RESEND PATCH v2 0/6] mtd: Make sure UBIFS does not do
 multi-pass page programming on flashes that don't support it
Message-ID: <20241010173236.GA3699035@bill-the-cat>
References: <cover.1727399650.git.Takahiro.Kuwano@infineon.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="q941QhqSGEahjWX+"
Content-Disposition: inline
In-Reply-To: <cover.1727399650.git.Takahiro.Kuwano@infineon.com>
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


--q941QhqSGEahjWX+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 10:18:05AM +0900, tkuw584924@gmail.com wrote:

> From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
>=20
> Resent after modifying commit message in #5 (mention Linux commit first)
> and collecting A-b tags.
>=20
> This series is equivalent to the one for Linux MTD submitted by
> Pratyush Yadav.
>=20
> https://patchwork.ozlabs.org/project/linux-mtd/list/?series=3D217759&stat=
e=3D*
>=20
> Changes in v2:
>   - Fix an issue in setting macronix_octal_fixups
>   - Rework fixup hooks

Sorry, can you please rebase this on top of current master? With some
other related backlogged patches now applied this doesn't apply cleanly.
Thanks.

--=20
Tom

--q941QhqSGEahjWX+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcID7AACgkQFHw5/5Y0
tyy6dwv/QYifHDEV0DoPJaZ4Dwrdvjz2zbIh8XAzuCRTC2iArzYwMqDUQxJowzBY
dKzwtjjSdffHDhBL/XEkUu8nsWmaFrIK+N5IfpUvPugo/VqJjEgJoLCWbKae4HCD
mFRy96DhNASsmC/NV89epCY8bESZvi8GbFj6aeTmV1yuKGQeirwr3ixT3R5oqJ4/
p66vZmEjxrSRDl9EdpJyRqNH75KVTaZ6xRZVF8Ui9tG1kA91obkno9BTl1cMKZUf
Y5meoElNaZ8SLnckp6H2X049zx0UjhJYLJzaLOUA91/KQWam3MLDFWPz/e2aZ4lI
6c2ajLibR33ZWAHIuaX3n4OiZz/HQFjRDUFkz2PU4RQ6Pmj7nuTKVgxPObRBHQg0
PF+MHIWVOjrUKIP2AhSCxtBQNF4+jthZ8Yto1UU2SVHb4zrxWgQU2NJtwyVHT7VZ
baieakRCk2SMMohO/fK42mKEvCXI7sBMhwELieLTEN+A4lQy15aD/ZAXauOzVGUl
fr2ZVezT
=R1ou
-----END PGP SIGNATURE-----

--q941QhqSGEahjWX+--
