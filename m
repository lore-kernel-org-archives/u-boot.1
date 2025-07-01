Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61716C83038
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 15:27:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9AEA82FAB;
	Tue,  1 Jul 2025 17:27:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bI7f2rxN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E0A882FC7; Tue,  1 Jul 2025 17:27:04 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FF1082F71
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 17:27:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-736f9e352cbso1894190a34.2
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 08:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751383621; x=1751988421; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Wq4wm7XGDfMGnh40ZapDTihvZiWgfR0fMRv0wWtoEMs=;
 b=bI7f2rxNTVz4bzzjGh4uy+gpHhp2fMAu4OkNe9uifOW3+2GYwtesmIqf5hqw5GDnig
 oOHYql2q244IqJEvfLzO/laF1RWVwXwcYKlHgEpesIf0jFEtIQrBb9cB9gRJwSvR8j2n
 qXbkNbb7EuteL5vrwTWU6ugq1bhgieLK/u5Mo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751383621; x=1751988421;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wq4wm7XGDfMGnh40ZapDTihvZiWgfR0fMRv0wWtoEMs=;
 b=PFR2H2p1+V9LJg14swxz5om4VVwXPMq2TevRD7gp3P1Kn5MoX8OZVsckMidXCjlsDl
 9bick6k3Swvdurx2xu4cpN1tG0XL+7/lWSQXYfgZF1+jQGluyYR45zVjx6SxIn+ez9z/
 GBdCw2VPvB64FskH3FG8y7dQqF6b7BsPMglRQUQQ8buSwTdkznfUIyX5/qdl+GlqXWvA
 8PMuS2Mimw1qhNzc6sdskuuwJYKqcPpCnMtrZoEZXeXt3TCsjlamY7XrZou04lGmOCVz
 EzJOW8YokxeHOZUur1jDyUCfhH8A4GzMejChTE9gaUcefP2mDzyFbbUJGaQSeumwLRwL
 HJFw==
X-Gm-Message-State: AOJu0YwUMnPAsmddQYXRoDgIS8Lv6YsWsD01NKVPXqcuaMO67eDY4A13
 bMlhm6LyW7I5wrsKzSXmHKejzeqPqnDT23T7uCWUaRZTC2fDYLAZ0fiX3AGs7liDT04IAlUrdXZ
 ftV11xEc=
X-Gm-Gg: ASbGncsicnUAHYTX6qQrKnlJykBIME1rkE+PdLp8acopH/93Cx7UU0VodaubZBnfzBp
 zz2lQFr/vDmoNMcQcK5HVfJlAeMsF97FlRmyfbQIOppDDQ8RxRHQSTcyLqoZQp0I8hUKsiC3IAi
 +UUu/lyzavrCeRdAQCbkHf++2A3+KgQ/Oo+7RzWOzQwm3IlPeNHkQVfjst5WBCMGJJ+vqXKlI0K
 GwIl1xWmzKEzC3Ybx5tWUOQG5O8GEfv6lw80glyJCz3vsdxgI6RWzR5MElENGRmIFEym4SHFEO3
 JZ8ccIf6kJ7sBWdgwHp6O1YG9FXN50I07SF4C+4U247pG8skpIi+192Sb2N0adCejXfz6pLTC0O
 TtriCIX66P5mBch2l2VkwFE8=
X-Google-Smtp-Source: AGHT+IHSq2yb4oC8vHIweL3u/ZFugBeKVH1omxkp0zsOIWvXBjn4OW4/zBj08C92M8k3uJMOWBzIBQ==
X-Received: by 2002:a05:6870:f61c:b0:2d5:4f4:e24d with SMTP id
 586e51a60fabf-2efed426df6mr12448288fac.6.1751383621148; 
 Tue, 01 Jul 2025 08:27:01 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd4c35a57sm3361774fac.0.2025.07.01.08.26.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 08:27:00 -0700 (PDT)
Date: Tue, 1 Jul 2025 09:26:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Fiona Klute <fiona.klute@gmx.de>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 0/3] Move PXE boot from README into online documentation
Message-ID: <20250701152658.GB523899@bill-the-cat>
References: <20250630105323.1346850-1-fiona.klute@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dTVM88Srm/g+QNWU"
Content-Disposition: inline
In-Reply-To: <20250630105323.1346850-1-fiona.klute@gmx.de>
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


--dTVM88Srm/g+QNWU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 12:53:20PM +0200, Fiona Klute wrote:

> Tom asked if I could move the README into usage documentation when I
> sent the recent patch about "append" in extlinux.conf. This is mostly
> a reformatting to make it fit in the RST documentation, I've also
> added the "sysboot" command which was key for me (patch 3) and grouped
> up environment variables (patch 2).
>=20
> There's definitely more that could be improved here (e.g. move the
> commands to the Shell Commands section, reduce overlap with
> doc/develop/distro.rst), but I hope this helps for now.

Thanks for doing this, I'm sure Heinrich will review this when he's got
time.

--=20
Tom

--dTVM88Srm/g+QNWU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhj/j8ACgkQFHw5/5Y0
tyyqWQv/RtYR4Ufpllq0xpXtEMTa8qLdp1JMAD2soNIewG4G7A6KWHKaDbQmJc9E
8lEN+ufEV4RHaZUK90m/70J7LXdGX0uQVAVHuosJCLIF++I52hgw7spTEb1nvMCf
7fuWzrlcwm1QWJriTgP7Qq7Tz82og7fqrBB4R6vY6Wm6/Nf+M1eVdRKFN1piaRYu
Z2y4AUnXgJrT91JP9snLxeWycoaXI8h4VeKP2swvBRLIoS0os9UFWr7SRD8wDr9B
vzsecqvmIw6Xwk3OD6+wvQMriMnWlgXncWcp16SQq7D11EM8CFfLWvXDzwF97QDU
vBZTIucgXn4kJfI8NzG+V/hxJ3gZ/6bZ6moNyRgWTcat6f0jsRYnoOAbgwqAtctp
n5BZZnEDMeGZU/5VdTvM4kTuAZu19uMfiBGn+eKlMuAdEOpdqmKk7G3GsJ1hxbSP
rLCK9T7c6SzzlfHVl2bcuVpNcjt6d+RqvuaNUOTEHY00hhsa8yO9C4fIqqUcC9/w
rUdr38Id
=adki
-----END PGP SIGNATURE-----

--dTVM88Srm/g+QNWU--
