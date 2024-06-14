Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41CE0C27C6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 14:58:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B397088A10;
	Fri, 14 Jun 2024 16:58:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jheLXPCJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BE8988A14; Fri, 14 Jun 2024 16:58:07 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 687298844D
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 16:58:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-2549c883c43so1540323fac.1
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 07:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718377084; x=1718981884; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aeZKMBPILPBH6sPtr41gLP6m9ASNvF5+nVcWFjmq9do=;
 b=jheLXPCJg3Rn6ShChm8l5wISLfk0GdT+oYp4Mx+BNnNENkYXMG7ufyC3R2VbirtGfa
 SokoxWvmkFq7AegM1U3ANpuDZLri1plAp+zkl+vTA99gPP50f++7Z0/TeC1Y/9Ncg/Pd
 Mw7JV80GSXtWqOHu7NLo/pxKtJKwLgHCQe0w4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718377084; x=1718981884;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aeZKMBPILPBH6sPtr41gLP6m9ASNvF5+nVcWFjmq9do=;
 b=uEA1fTeo0xHoag+HqJwc4oPDVL+djKmQEOycsg7J6pYSchefg0lNA7b2Z8mMxfBblm
 zw8F9+wsuJWM4iHtISNqlJvrSS9HZAhTz80Q/ozMKlvinskkYOJ13SLT4WPJtq88agmx
 K4zVoJgroypHhXLpUKxFHG6eO3AY4HxeYvpn4y94PMKMKgf9pgaWh06EpQ96JOrB5wnb
 Ju0aYndI58Tt+gHjW7kXTP2J8sN6WJTVPD4ex8hOkSNz9VBaKW3PnRhuGPS3RTZXcMbo
 /vy46iNwJL8UQQNhePUN22wHxMFbws7cC88urPDQ900E21hgCvyIFXIs2KCQt/tQFQK/
 pXIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0eFev1A60BVctP3e+jp0EghsOGW8t0w+5VI2eeuqs3bU0lO9N+3N46HCp7fbAAnjSyxFuELC29ox6TG8j2eLxI5b91w==
X-Gm-Message-State: AOJu0YyI6WW7mqypJdKOw6h2i5+8VUHbLxVbE4fdB0oB86flc0efjscR
 Q8e8+yS3jZdZi3bBvCH4CG4WTMJ6oiulJXGVDzXrxWZ5BizXEERcB8VVdJu9+oA=
X-Google-Smtp-Source: AGHT+IFyrS8pEW1L2HEvy1+DC6Tu+zuLxzik6EXT0IcM94t/vGOkZIVD9d4kDovuLm7xA/wb8AROTQ==
X-Received: by 2002:a05:6871:7996:b0:254:6f6c:5262 with SMTP id
 586e51a60fabf-25840ff8c09mr1616459fac.14.1718377084130; 
 Fri, 14 Jun 2024 07:58:04 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2567a94e352sm993878fac.5.2024.06.14.07.58.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jun 2024 07:58:03 -0700 (PDT)
Date: Fri, 14 Jun 2024 08:58:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Jonathan Humphreys <j-humphreys@ti.com>
Cc: Simon Glass <sjg@chromium.org>, Andrew Davis <afd@ti.com>,
 Roger Quadros <rogerq@kernel.org>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH] configs: j784s4: Enable RTC emulation
Message-ID: <20240614145801.GA2656409@bill-the-cat>
References: <20240531223212.2619317-1-j-humphreys@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6l8hPlPsUYZT9TSm"
Content-Disposition: inline
In-Reply-To: <20240531223212.2619317-1-j-humphreys@ti.com>
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


--6l8hPlPsUYZT9TSm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 05:32:12PM -0500, Jonathan Humphreys wrote:

> Enable RTC emulation for System Ready IR tests.
>=20
> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
> ---
>  configs/j784s4_evm_a72_defconfig | 3 +++
>  1 file changed, 3 insertions(+)

Please rebase on top of current -next, thanks.

--=20
Tom

--6l8hPlPsUYZT9TSm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZsWnkACgkQFHw5/5Y0
tyxehAv+IjVftHeTPMM9YmemQWlgIB9p/quRvNtYbmaWG8/DPLQEXV2hlIBehPgf
csynxvuq54UkWfXhORHskKbUYFXKvFjNel8VzDXfk3+iFG5wFYIAP6ldT++zCLTy
cxAoSf9qbDy0kejcoEQSGlnJ06grbWMWpXrlMZQEK9aYGUz6LD2zLz1sPPmY0rQy
xL2OVw4V6S23xZsviNpmsXv/ETVcdxdQflbVUqRhAZqbngbo+0j6Ae6NikInOHwB
6j4c/fEsFwxTFTkS12QzvGELq64ru2nkYofgHHzTtdBvselO9QKGH34syB++16fi
DTIBquSyBJbpRpWiKb0meW247IgM6j1ZYImBQyyji70zojXWDheLaHLZjEckYYLy
tj7D04COfp4hdhPnHzrNmiMAFqh22xOfHjeYN+v5X8qQZ3g0wfCyeKV9HAV8dSyY
aWPgC8BIKdwSSCgaoY5TXBN5SvI3BQc4l+5pY67RIrwXXrKzuQbfcSfRZEFzOJ7U
R2i2WXlE
=MmzO
-----END PGP SIGNATURE-----

--6l8hPlPsUYZT9TSm--
