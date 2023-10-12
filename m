Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C9F9CDB474
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 21:56:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EBE386EC0;
	Thu, 12 Oct 2023 23:49:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Hn+g1l//";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EE3786EAA; Thu, 12 Oct 2023 23:24:29 +0200 (CEST)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D05D686E75
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 23:24:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-4180f5c51f8so11749031cf.1
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 14:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697145690; x=1697750490; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3VIJWAoe9wrNQv/ONUiws4BOC2xjVDIZAwji4BQFjoI=;
 b=Hn+g1l//vDZlV2QiT77R7B95m9BZJGeF+mqWZzn/XXd5XfKgF5jh94EUOmR+TD6s5n
 jQCUB6VauR1ip8Z6SPiZso2c5t5PHWEjTNpuEaEFWxtdhBf0eYWaI2MZorSjkWTqVJzD
 G3moWKN5jUDKIfqO4wzF9l+1GqCd0R87ESkns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697145690; x=1697750490;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3VIJWAoe9wrNQv/ONUiws4BOC2xjVDIZAwji4BQFjoI=;
 b=FBcjhTqTzL6tGTIJj4IE9BD+/xeJvWP6WsrxGt5JMWQaqcoGQoj4uGqJcJLq/Re7JS
 EzaY5mWN9r/VlDUKq9FPnZUMC7AjXVfZLJ7ZNSE6KcMLGixx/phgABwMq+4XqiD5LtSF
 4J42ZC10kn2aFd7RGF2ifQtjt65drYlStNQJLHDzoMiuzH2tD9U1NTiW65RNZJVaQn+l
 d9XL//KD/FR9PIDEdcNxtergiXymolg+oVpr2PpVBwA7Zh+s3BJtwAuRDNjMlYZLe+3Z
 BzsXHvdIikhevY8GnD/VxxJPh8l21qHUanwgvypOr7YXSGEeABY2Gft8sD2kIuC/va6L
 EUsA==
X-Gm-Message-State: AOJu0YxOlxBmRGs8KNAzAN6urSEdM7B5m8cOpojH7Oj4hOMgOvSRUAai
 Zn8JoGzdz5nF3AwWjP7VwDaYhSJvj7QbxnHJ9XtcnA==
X-Google-Smtp-Source: AGHT+IGFjimVLupxb+8yiz7E8taHqiSd0CRcQdeMOBM4palzn+zy0Zeon27rFKKJlP312MpLJDwlCw==
X-Received: by 2002:a05:690c:88c:b0:570:2542:cc9b with SMTP id
 cd12-20020a05690c088c00b005702542cc9bmr15176455ywb.18.1697144674572; 
 Thu, 12 Oct 2023 14:04:34 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5647-4a14-f04e-8d8d.res6.spectrum.com.
 [2603:6081:7b00:6400:5647:4a14:f04e:8d8d])
 by smtp.gmail.com with ESMTPSA id
 y130-20020a0dd688000000b005a7a92a62besm222225ywd.8.2023.10.12.14.04.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Oct 2023 14:04:34 -0700 (PDT)
Date: Thu, 12 Oct 2023 17:04:32 -0400
From: Tom Rini <trini@konsulko.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>
Cc: u-boot@lists.denx.de, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Udit Kumar <u-kumar1@ti.com>, Reid Tonking <reidt@ti.com>,
 Apurva Nandan <a-nandan@ti.com>, Andrew Davis <afd@ti.com>
Subject: Re: [PATCH v7 6/7] docs: board: ti: Add j721s2_evm documentation
Message-ID: <20231012210432.GF3119521@bill-the-cat>
References: <20231006-b4-upstream-j721s2-r5-pinmux-v7-0-5d31f765dd2c@ti.com>
 <20231006-b4-upstream-j721s2-r5-pinmux-v7-6-5d31f765dd2c@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="R9VFWP4pkwQUpidF"
Content-Disposition: inline
In-Reply-To: <20231006-b4-upstream-j721s2-r5-pinmux-v7-6-5d31f765dd2c@ti.com>
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


--R9VFWP4pkwQUpidF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 06, 2023 at 10:16:00AM +0530, Manorit Chawdhry wrote:

> Add the documentation for J721S2-EVM and SK-AM68
>=20
> TRM for J721S2/AM68: https://www.ti.com/lit/pdf/spruj28
> Product Page for J721S2: https://www.ti.com/tool/J721S2XSOMXEVM
> Product Page for AM68: https://www.ti.com/tool/SK-AM68
>=20
> Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
> Reviewed-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>

Applied to u-boot/master, thanks!

--=20
Tom

--R9VFWP4pkwQUpidF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUoX2AACgkQFHw5/5Y0
tyxEbgv+OY9A7b4M/+iIccJiFFenPNBlMJy6P6TtVLsI8K8MvUDEGvWzY46lE7hq
rL0LnXzL2i0vePmizaX0TbshmU8tK+a6U8DrxWJS763EFu56TTLwLsLpgi9/ZlY3
GuUtGsTzyEU7mqCvbMj0yN0WD+GdDRhhxIRNTP/anD8bZYbOBR5qI49XBEX1AuAX
9RK2fEos2ZE8wb2OPhoSj/4116cbMP045OGZTbDm/CwX9WF8JOnqdmF3jnde4XDM
5fAik0eToDmZ/c7bj/Gy++fPRTBQBPLzTCyLF2kmAU0Zs3FysIoV6DJ3MPdfGgj8
8PB7Fu7df8NPBIsaMIxxMJHD8yzyDiMeCRc94EA4H9D7Ec5iQx0PS92qXMbCnNqy
LSIV4BxwQa/TraiGPsdoUIEiwa0J4Zm3/QhiZ1im1yhZpo3OBNFoiMuYI7rbA3Mo
3vT6lue/BFCUOybq4putpaFXzCc3Sr/2J3dU+pRsDVnMf/EVVIih7BIMV6KLQzt2
rMyKQufd
=pxni
-----END PGP SIGNATURE-----

--R9VFWP4pkwQUpidF--
