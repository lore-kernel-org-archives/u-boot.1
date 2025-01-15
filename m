Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE77C02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 14:36:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4FA1806FD;
	Wed, 15 Jan 2025 15:36:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WysDZZJ0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0C6680708; Wed, 15 Jan 2025 15:36:07 +0100 (CET)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6EEC80657
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 15:36:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-467a6781bc8so48786971cf.2
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 06:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736951764; x=1737556564; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QneygkzGzmK4LI7VdMR2JuJuOhlIz7hpw+bWZHHGLNU=;
 b=WysDZZJ0PbH7YToLBfCBWjcKpJ3mAd8obF/OKo/M269s0B+lfRuIR7JjtLTw0Y/TP2
 6PhnhcaHaWDmXvJK7JevAm2r8BFaIB2iY7CVXhg3PDpkiAUK0p8K38OFDD7RSNHUDRvN
 aZxUWMpZlfrVDs7sEL8tZjQm8Br9YLGuxIQJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736951764; x=1737556564;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QneygkzGzmK4LI7VdMR2JuJuOhlIz7hpw+bWZHHGLNU=;
 b=D10SVnGJRw3LNRqxgNIxCB0AQIcxnXZuWV3blarRzHY9VYLFyE4+jvJecy7D1FWbHl
 xSwtRV/vd7NPH7xhuElj3MfdAvOnaX+u4pcBvBLZSdMcX3ECduMe06ld90DpOh3B9mbe
 mTKhhat5GBgNCNprXUSAgoQfQPWK0/e5dwiE3W6JmMLURtoa1P3hvM48RqJ3nVU+ZjGT
 uMJzEMtCG00m+I3afi1EvzCCx8RmmReYr6+MDQehz5/pkYL0WzD4R24bLYxejjxLMZT9
 dsk/AytBQZolA0Jy18GYuZcM947/d2tEyTIzGJHDxkhyaGXe1YqkL9RafvW0WDzGUSuz
 c6dQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCc9gGFauwUgAqG4mc8zjvGLLtgcMmZivVVWIYFZBdVADKJG606baEPcQWGYdmtxyStjgXDJw=@lists.denx.de
X-Gm-Message-State: AOJu0YzmGc88xy5mn1WX4srDzLUOdanNEQFUTSpUawpUXNOQFb5dwOon
 ry7dJP70b7DrK7uMiKP9hml77M7Q2uKQRL4mir/mQc1PG/gKIoY5j/TFHbXe+/0=
X-Gm-Gg: ASbGncupkniGaVoG+pWXxCFcPs4SOATKfmb1zszNm+DP3+9q/uWVieWqYiYy1/gOe90
 VE7dthDOIHTE8cs9y4/uLOXDZXazlnAeg428Jy5qLs+4wkPQGCJspD2Z8e4oWrV8Zuhk3BCoTfv
 GKN+WLCqprpq1/kDj1b+IRG/N3cPAoJsJX2FnyAtCRGRsHIB8xl2YJSb5x7V/lOMVDeZqc4YU+/
 oz3ep7PCt+wwzvn/EjUViqct6BGN+PuGHkyEQainD3fdDlPiHc7Wg==
X-Google-Smtp-Source: AGHT+IHfObrqiYA/7WZ41hMwdtHL2UxmEpNS656YQ6gzHkMYwg+bAuz4wTvC9+u9kLvyPokFe+BevA==
X-Received: by 2002:ac8:5848:0:b0:462:e827:c11a with SMTP id
 d75a77b69052e-46c70ffd4e3mr416391181cf.19.1736951764653; 
 Wed, 15 Jan 2025 06:36:04 -0800 (PST)
Received: from bill-the-cat ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dfade887cbsm66086466d6.96.2025.01.15.06.36.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 06:36:03 -0800 (PST)
Date: Wed, 15 Jan 2025 08:36:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Harrison Mutai <harrison.mutai@arm.com>
Cc: nd@arm.com, andre.przywara@arm.com, manish.pandey2@arm.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 3/4] bloblist: add support for CONFIG_BLOBLIST_PASSAGE
Message-ID: <20250115143601.GX3476@bill-the-cat>
References: <20250115135209.13946-1-harrison.mutai@arm.com>
 <20250115135209.13946-4-harrison.mutai@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3MGbH8zWCrGK7J/7"
Content-Disposition: inline
In-Reply-To: <20250115135209.13946-4-harrison.mutai@arm.com>
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


--3MGbH8zWCrGK7J/7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 01:52:06PM +0000, Harrison Mutai wrote:

> When the configuration option CONFIG_BLOBLIST_PASSAGE is selected, the
> bloblist present in the incoming standard passage is utilised in-place.
> There is no need to specify the size of the bloblist as the system
> automatically detects it using the header information.
>=20
> Signed-off-by: Harrison Mutai <harrison.mutai@arm.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--3MGbH8zWCrGK7J/7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeHx9EACgkQFHw5/5Y0
tyyNSwv7BZ86+f3WqEOvLN12DSIKLJhAWaWrQhmo8mQ4oK/sckRsuY5zfUXj904A
GbAab6JU0c78p2AtzvBup5W6zeCacxivspWTQTyxeG9DdftbAW7VKI0kWIDsztNz
uNS+8PtR0v7BMH29mSR5VNSORmtVgaKeVU0WPTkBooWELbqJpPy9uvI1tm/kO2KR
ICorEc6nt+NTynn2AlqdW3GCjRiT5ry87Az2QuNZCsQnCbE9tu3rnoKxQ4mNSy3S
Llw6XOOMsNGeeURZc9W4NcU8gfvWwJzh2TAnTTvG8krfYvjTUKkh6+MA/QZlRx1b
jk/8eXhJq7nxc19EEwkIpxMD5+TJHlBe19ri68X1EeYk7lDilgsi9ukXRcEfbxGz
TAY3EE8/xPL1HPafFE7/p4ActMpgE8+Dj2jTpLlU6+SBhtlZ8SN5x/jdvvd5xHLl
KpLaisRmX2TyQkEejuNtLHtN16dHTMyVwkQroruZKGxYhzATXfPY5IXdz7rTe0pL
+TFqc1/b
=CuPT
-----END PGP SIGNATURE-----

--3MGbH8zWCrGK7J/7--
