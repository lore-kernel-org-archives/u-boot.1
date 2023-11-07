Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D54C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 19:46:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CE6D875DF;
	Tue,  7 Nov 2023 20:46:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Hwn+A78b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2081875ED; Tue,  7 Nov 2023 20:46:44 +0100 (CET)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 917CA87564
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 20:46:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6707401e1edso37193066d6.1
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 11:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699386401; x=1699991201; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0Ktgj3vTXfyCyvJ5rAHSPg6DTV3Iuj5mEtx3vEiJPus=;
 b=Hwn+A78bRgpJTj7zH+IvWnmxVE6dIKe7+2ecc5ymk5I9fO7z3K1uSktMRO3NJzheCQ
 /QC0lfEzsBBOunKi6p0bCBcSmu2KSGUv5zadsvw8yaE93D1dzQTJ70mrATXKJRI98poZ
 a+nPB70F6uCPAFz9heonZeRuLfytSAvEcz4EU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699386401; x=1699991201;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Ktgj3vTXfyCyvJ5rAHSPg6DTV3Iuj5mEtx3vEiJPus=;
 b=myHjri0KCZnFJ6YlcwPZ81t7YYdSgRipQ5FfJEi7D03NCj9Vg5KzFexNKyBk2wSiUC
 DIDSia73drFS9x6o1ua9JJZzxvZ99sE1aqKJGiaRFzcV/Giwqq94uWytS1gEe/EgNkaP
 o69EWRh1NuyzdXZz+G387H7FKmDlKi8AmMJUcfi+JbslskfrzU8iq6nRPdH8ZQAmvg9C
 sOtKUP7SUEeEXlv1BOyF1SewbBY0HmgBAPoHW7oAgxoc/LXsu3A46nky8omHXqvKT/l3
 P4AHteIdMhkPxisn1iHwVplEkjHEon8uQOQLbpPFmxM+aeKa0wSw8y09t3Zn65jFOvKn
 6eGQ==
X-Gm-Message-State: AOJu0Yyw2CoQp3cACOz8OSVO1ssK7iKYQVv8iFec9td2MNHX+jXhCHKC
 wRztdGbVuBxfIYkxYUuwYISsv6OAyY3BPyWF59emXw==
X-Google-Smtp-Source: AGHT+IF9uKrh2fcWZ4rE2A0jWEbj6U17FUP/dW0o9NE/lfJyc2bR2V6Mt0s00Prk5C+dpoa9Np3pmA==
X-Received: by 2002:a05:6214:f6c:b0:671:739e:e2fa with SMTP id
 iy12-20020a0562140f6c00b00671739ee2famr34558733qvb.59.1699386401202; 
 Tue, 07 Nov 2023 11:46:41 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2fee-489d-8907-1a68.res6.spectrum.com.
 [2603:6081:7b00:6400:2fee:489d:8907:1a68])
 by smtp.gmail.com with ESMTPSA id
 mx4-20020a0562142e0400b0066d132b1c8bsm213816qvb.102.2023.11.07.11.46.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 11:46:40 -0800 (PST)
Date: Tue, 7 Nov 2023 14:46:39 -0500
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <monstr@monstr.eu>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [GIT PULL] xilinx patches for v2024.01-rc3
Message-ID: <20231107194639.GO6601@bill-the-cat>
References: <c57462d6-33cd-4f16-87c8-a83de771fdf7@monstr.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/O7Zofcq5fBzSxCj"
Content-Disposition: inline
In-Reply-To: <c57462d6-33cd-4f16-87c8-a83de771fdf7@monstr.eu>
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


--/O7Zofcq5fBzSxCj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2023 at 04:31:23PM +0100, Michal Simek wrote:

> Hi Tom,
>=20
> please pull these patches to your tree. Most of them are dt related to
> aligned our dts in u-boot with dt-schema and fix issues around it.
> There are small updates out in spi to fix 64bit support and allow disable
> flash locking code to save some space for our mini configurations.
> And last change was related to reading baudrate from DT which was ack by =
Simon.
> There are some other things pending but not ready yet that's why I wanted=
 to
> get these patches merged to have more time for testing.
> Gitlab CI is not showing any issue too.
>=20
> Thanks,
> Michal
>=20
> The following changes since commit 3af0e9556c968fc2c40e3778d8f1e668a90af9=
2e:
>=20
>   Prepare v2024.01-rc2 (2023-11-06 14:47:25 -0500)
>=20
> are available in the Git repository at:
>=20
>   git@source.denx.de:u-boot/custodians/u-boot-microblaze.git
> tags/xilinx-for-v2024.01-rc3
>=20
> for you to fetch changes up to 37f500d711ec1f6b25189c1f6022ffe5e70a38ab:
>=20
>   dt-bindings: Remove VSC8531 specific RGMII delay definitions (2023-11-07
> 13:47:09 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--/O7Zofcq5fBzSxCj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVKlBkACgkQFHw5/5Y0
tyxS6AwAnlepR1REWilMoUQYZ+AFqwjGntsqO7UqWVi/j0999sWiqM/3R2woK8RP
hjWCHZQ7hH95awech0aZrP69kQINxS3mUVKdxPBdnV7P59wkttuLKTYihCVojtAG
rem3eZcebnePjOIYV2LBMOAEE3nqOTxSoc11s4EpFoZPu9Fs6HbQHv/Ly2PT47BP
ICZR/1yJ1LzfNZnPSEJFxleFVz6GEsFvpBItvfkXrMcZmhlL7lNDKt2u1ypMCwOy
t5ElaG0hiUgA5pBIrYgkquoGjEXn38drZzvP8GgR4SM8dh4fDIlsZ5xZNwONlqjC
t+//nT2gAWbArM+M1Kx1S7sOvkr8N3t5OQ2cwhwcsR90w95o+6FhY8HMXlqMXaL1
RLmpV6VZ1pL5NZf4/iJlI09z7/vu+H/2eXj/DNMbDhYNkyX3tKkpOj/YJsZF1hki
fuIi5/h+wo8nEwWeluxXTH0/h77dq3sDlf1YSbcuf9pdb+evbG5O1rU7sxVlNYY7
1H4ab3AU
=OtF8
-----END PGP SIGNATURE-----

--/O7Zofcq5fBzSxCj--
