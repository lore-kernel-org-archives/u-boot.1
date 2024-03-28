Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8D3EC54E64
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 15:10:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B55C888198;
	Thu, 28 Mar 2024 16:09:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KK+moUik";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1DFF88198; Thu, 28 Mar 2024 16:09:20 +0100 (CET)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC4BE88150
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 16:09:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-78a13117a3dso91527585a.1
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 08:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1711638558; x=1712243358; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=incCmaaocmN04Ktmd/w9RUMCfIBZ10KwL7i9z/Zq49o=;
 b=KK+moUikb0UWjMpE3ehXFZ2mXRDpzGi6WqJhl39iGBF17FHnYhaYCgpyVPKHJ47T3Q
 lx42GxSW3MWlwoQ8FGLZrE4Fwyk5sxL0bYYuGB42LqceLEg07PHl0+79gZSIy3w9K2lp
 feuuzV0St5DjvCvJibzeM6LtAB2VnHzKMwUSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711638558; x=1712243358;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=incCmaaocmN04Ktmd/w9RUMCfIBZ10KwL7i9z/Zq49o=;
 b=kzGFB7HWHN9gHmsYbPtZKaFHhFwu8MEF9CFMu9mvSemC1rd57paoB7njotC2CTTzgF
 BO/hjnxNcC7mx9fxL35/tQQLsmndIamXXk/4Q21wLZ1Wykf09RYJzsYHc1YAj9mVtG59
 tWGsHcq/maorRkagEEWRtVuXwg18bIoExCOAZjS7zQdzHIbeo4b+bQCvU6JcvF7K2Tl5
 tHegUp6SIq/EVRCmXjQ5TqjYF5UxK+1X4hNCxEyf162ZjhTAvxEcJg8oQe98Rs10ZIs4
 Gp8xHaBZW4OKxKee5fD5I7KV9Pce9nFSsOJVrrybGis5n/utDL0l2LPZb+VwAiIWrhoE
 uCIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOyA9OAmHHhyBq+grwtRl+IFr3cC/9/XaCHZ322RUKMIpwwnfqzv/YVrmOpL46rNgfsiPPmD8tc9+i/yuznO9gRCuifA==
X-Gm-Message-State: AOJu0YxW661cf38ugG/GEPDdD6MgvNsFdmjWwi52R5TQY9dopdIuqz+d
 WwFVOAgABH3BR7TpxJN2AHwHPQoSLUR+pIZqMNM5rw8jM9YV2tg4ASmTjJgxBM8=
X-Google-Smtp-Source: AGHT+IH0dDLUkRUiho61T1lbgTjge7l1r8HaLEQMrVtBwVOLFVfSEGVYptT65Crx7XwoEbgCRi+TUg==
X-Received: by 2002:a05:620a:2086:b0:78a:3ccc:8140 with SMTP id
 e6-20020a05620a208600b0078a3ccc8140mr3859994qka.28.1711638557745; 
 Thu, 28 Mar 2024 08:09:17 -0700 (PDT)
Received: from bill-the-cat (065-184-193-066.res.spectrum.com. [65.184.193.66])
 by smtp.gmail.com with ESMTPSA id
 u6-20020ae9c006000000b00789e17a55fbsm583563qkk.131.2024.03.28.08.09.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Mar 2024 08:09:17 -0700 (PDT)
Date: Thu, 28 Mar 2024 11:09:15 -0400
From: Tom Rini <trini@konsulko.com>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com,
 marek.vasut+renesas@mailbox.org, michal.simek@amd.com,
 u-boot@lists.denx.de, BMC-SW@aspeedtech.com
Subject: Re: [PATCH] net: phy: the NC-SI phy device do not require mdio bus
Message-ID: <20240328150915.GY3442575@bill-the-cat>
References: <20240115103447.389339-1-jacky_chou@aspeedtech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pPzuKeJ/9GPds9rs"
Content-Disposition: inline
In-Reply-To: <20240115103447.389339-1-jacky_chou@aspeedtech.com>
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


--pPzuKeJ/9GPds9rs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2024 at 06:34:47PM +0800, Jacky Chou wrote:

> As with fixed-link phy device, the NC-SI phy devive does not
> require an mdio bus. So, a condition is added to check the
> NC-SI phy id to avoid accessing the bus pointer that is NULL.
>=20
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>

Applied to u-boot/next, thanks!

--=20
Tom

--pPzuKeJ/9GPds9rs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYFiBsACgkQFHw5/5Y0
tyyoMAwArGbRXWxJbKAi8tZT1jaQXrU5TGZeB6J3lPTza/Zoc050LsRukgAeMdMa
dPH/8mUwox+eqU6yWbcypJWWn7JFWo9Zp+3sf+u/p6WCjEX5inTA/tTu81spMwJz
cOPj3cAmeMKtU8dwBfHuT+N4l5SLjDfKok2QpNzBcblEbYowzRj9Qjkfqg1qUOnI
aRALI6xwhqc0b/gMHGOHu8KYHx8Dr7IAHmSIQMuzw3pUnCIBbq0rLTzyxWL6t2cK
0yrIkapTwOkBGcRlPO8okk8tOIbF+PwPdACbdeAZ4S2/EOOjd9YdH4rwkTRlrdw4
1ZeANo2iL0ZDumYfFO25kcQlRMfBfvf6sp21BMOt25fxiiKaEfjslgcrRKlnD7Ej
i57W3fHjnpq3tmlkIFx+vvranqtuWjiVT+ED8ogPeFnLX05NnWS5AFXv5WRAvyUK
/f4XylgmAMgqkxxfvTOuCsWX3FtRDzPOcNoPlbyqMXoAEu+RueezjFHlkma/3cW1
jFXN7bYi
=jibn
-----END PGP SIGNATURE-----

--pPzuKeJ/9GPds9rs--
