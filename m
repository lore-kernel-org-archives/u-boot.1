Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44886C4829E
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 13:35:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C90B87DE1;
	Thu, 15 Feb 2024 14:35:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="N9zSNyiD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B6EE87DCF; Thu, 15 Feb 2024 14:35:28 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92F0287DE1
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 14:35:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-6078c21505bso7983967b3.0
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 05:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1708004122; x=1708608922; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4brI//OBBoV0vqYTEueLfu08ehL7kMhXyfasRuU9Cvs=;
 b=N9zSNyiDmz31EjY9WIQ/hvAc+zTd3zDilJlQxvu5uWVW+bexKKEY99C0WqbTt00cEo
 U4khCE7RA0GFSL2HOkAUq2p2u2G/IaXF0w0zLYvdqdz6ORXr658iqFW9AnFrpaaaLzck
 hGRjASrQRu7wYRx2AsFme9lvmASFg78dlp37M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708004122; x=1708608922;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4brI//OBBoV0vqYTEueLfu08ehL7kMhXyfasRuU9Cvs=;
 b=pzPteUFnqlxVIp/8mfj0kUkhUNMm68s4o309ed6DJWBhuKx/h629oT6zFzJ8WD13L1
 p7Msrs/FuHDlEHOhaLenU5NHf/vly8kgKNfXsp+SKa5SJiY22pm88ihcG3++XI5dn05/
 UkBfz0udMKVIPkortusIT0a8JWb9ZEjRF/EaBSNLbHL/sg4eRFN7MMO6oJ8BIeKJmIbI
 +RFkE2kwxRKMDap9EmhvgorqPP0NuUAjPt0+2bV5YkAZ5g+RTJLOlsp9f4CmHVcx9OoW
 Gm5XgMlGZXDh+FCbmccr8V8hzxihTEYcJSllOkLdCcM6CqC6N0xvr5E+FgBexmtvz70M
 GBqQ==
X-Gm-Message-State: AOJu0Yw6fLaGRUvfwha4Xh/ElKMyBufj5RWEs/LnFsA9RxkkQVUYELc5
 97VK5+tQ1AhMJGj2wYfYuQ0SteSs3zw1f+Ry0A1f3p92odyjElHh4qawMQdiersOsT4+MTL/19n
 +
X-Google-Smtp-Source: AGHT+IG3i11HdSs7LY99Gymm1ibakRHCFv2fbJqN9bWJp3S1gkXBwrU9kx+zOVfKSuG74H1PmgeJhw==
X-Received: by 2002:a81:b71b:0:b0:607:7df1:2c18 with SMTP id
 v27-20020a81b71b000000b006077df12c18mr1627622ywh.24.1708004120829; 
 Thu, 15 Feb 2024 05:35:20 -0800 (PST)
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 g143-20020a0ddd95000000b005ffce9cee9fsm241209ywe.12.2024.02.15.05.35.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 05:35:20 -0800 (PST)
Date: Thu, 15 Feb 2024 08:35:18 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Subject: Re: ACPI Vendor ID Request
Message-ID: <20240215133518.GC3040305@bill-the-cat>
References: <e72c7ad5-e1db-4065-99f6-326b55e7556e@canonical.com>
 <20240121151722.GD3652023@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hicGaxADl9y1/66g"
Content-Disposition: inline
In-Reply-To: <20240121151722.GD3652023@bill-the-cat>
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


--hicGaxADl9y1/66g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 21, 2024 at 10:17:22AM -0500, Tom Rini wrote:
> On Sun, Jan 21, 2024 at 03:42:16PM +0100, Heinrich Schuchardt wrote:
> > Hello Tom,
> >=20
> > as we have started to generate ACPI tables in U-Boot we should request =
an
> > ACPI vendor ID for the U-Boot project.
> >=20
> > As described in https://uefi.org/PNP_ACPI_Registry this is done by send=
ing a
> > mail to vid-request@uefi.org.
> >=20
> > As the ID is meant to have 4 letters I suggest to use 'UBOO'.
> >=20
> > https://uefi.org/ACPI_ID_List shows existing IDs. I don't know if the o=
wner
> > must be a legal company (which probably needs to be member of the UEFI
> > forum) or we simply can have "Das U-Boot project" as owner.
>=20
> I see from the list that Coreboot has "BOOT" so presumably we can
> request UBOO for the project, and I've done so now.

For the record, we've been granted the ID 'UBOO' now, officially.

--=20
Tom

--hicGaxADl9y1/66g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXOExMACgkQFHw5/5Y0
tywIXAwAhbMhY6RgRYHHuuovAHpNnIRJiWINMQI085mWq5OrClkI2B4yGxfXI9Nz
NDBkKgdJ/HKk2WJIvn6gOCc9SqYNozdvYA5vM0Bjbd2Lui7dB5XHk5V0c8dceoCB
5XYVykzOlsdJvdkae19LppwO2efaDluARFRKhohfc8+Cx86UxeSEmY7lRl9sfFvP
jpGWEQW6plFqe3uDAL7l/vhm9fxF63w+VhdIZcjvwW4srbdS7/+fIJkTJ2jkCpmm
qr5dYz3FNN4IPIIRcKDTmneo6kyGSHtAll0vLeWW14iT34JWXvvNoJDO2/kbTFuS
XvnBV4eYETP5Dzme37JjhRr6HfuPVfNj0yS9v4NnZr+YXK/ce0PefSY2m6DOXRXv
VcZS6FGHMAi+jC2jfzcWlBSd2c5F9top8NfE4Lehh1U+T2CIe2AJXPXWCKY7sXuA
H45G70P162wsjhz+oMUVveM6FAS5QjQ9O5uT46mAeOQrJXxTpfPNATxErQMVBhQ3
ooqNS6F0
=vUdm
-----END PGP SIGNATURE-----

--hicGaxADl9y1/66g--
