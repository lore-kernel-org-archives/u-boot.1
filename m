Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38BDAC4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 20:17:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99D81877F4;
	Wed, 13 Dec 2023 21:17:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nE7AbI4L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6746D877DE; Wed, 13 Dec 2023 21:17:01 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22AED87815
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 21:16:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3b9dbbaa9a9so6045407b6e.2
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 12:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702498618; x=1703103418; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=05bhmF3FXEnP/xVvC3M80DYrI5tkIQZEIA2da+0tnwc=;
 b=nE7AbI4L3aY1/uQIhWDzh6I8GnilN+R4rbffB77ZjlR2plAFu86uKsxkRwI4SQ9EQR
 X9OgPTJWucOYVNWJ3Q80bcV87yzFdjf39YODfWHOhXmdfgeKOoXQdlubhBZaeVlZ4RYG
 BQTAwuOB4oxkQ+SO22ey9Zrlj5uCaLFdk1v00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702498618; x=1703103418;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=05bhmF3FXEnP/xVvC3M80DYrI5tkIQZEIA2da+0tnwc=;
 b=FKfnHoVIIEnILjsMVmltuYe0XvJvr8Eta95bDOr+xnGn+U8CmMKlW76CNWDEbjYurY
 DTIkYnPmP9VuZSMT24fivucCXq9JUUuifhlZKa3A5G1it3co7l9X2TVzWyJmqIeovUvQ
 cqLKcR8FDKZ502JJziNe7afvbghlYQiICt7C/jNtjYpiK1JHtRK29/+dfx1BFWe5nMaa
 TvRFpkpfEv9VrGPjoVtIWP+g/nyPlkRVGlxnMusBWabHx4J4VbXDsncYz38IN3Z4CV1m
 AQgxeZvomQ/1NN4amRFA4JO0fBhmxqPNv7Vt0HTJvgeb/JXQXSjsP6MJdutDmjRUaIhq
 vY4A==
X-Gm-Message-State: AOJu0YzASzTNmVKE57th2VIWWp/pWGRbmN2OhOJCugbK72g5JBeKGuRx
 Ip+8wZ+4At3CCuQRSEE8pmraKw==
X-Google-Smtp-Source: AGHT+IG3v32h+E8OR1tN+HmhDTWeC1v22eZzU8OL3IJ5TawxkO+PabkMIR6EvCZkULAL0h2kVi2Hmg==
X-Received: by 2002:a05:6870:1613:b0:1fa:f6e2:6fce with SMTP id
 b19-20020a056870161300b001faf6e26fcemr9908036oae.33.1702498617728; 
 Wed, 13 Dec 2023 12:16:57 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-d78a-ada8-3cce-fa3d.res6.spectrum.com.
 [2603:6081:7b00:6400:d78a:ada8:3cce:fa3d])
 by smtp.gmail.com with ESMTPSA id
 o12-20020a258d8c000000b00dbcb622b2e9sm1543169ybl.53.2023.12.13.12.16.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Dec 2023 12:16:57 -0800 (PST)
Date: Wed, 13 Dec 2023 15:16:55 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, sean.anderson@seco.com,
 neil.armstrong@linaro.org, heinrich.schuchardt@canonical.com,
 mark.kettenis@xs4all.nl, u-boot@lists.denx.de
Subject: Re: [PATCH 2/2 v3] smbios: Fallback to the default DT if sysinfo
 nodes are missing
Message-ID: <20231213201655.GF2513409@bill-the-cat>
References: <20231207091850.17776-1-ilias.apalodimas@linaro.org>
 <20231207091850.17776-3-ilias.apalodimas@linaro.org>
 <CAPnjgZ2hMB0uTTd7tKZ2bGHkPiKM8j+Dz47nXKwiXH6vWHF8tQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="U5j7bXl28fld688g"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ2hMB0uTTd7tKZ2bGHkPiKM8j+Dz47nXKwiXH6vWHF8tQ@mail.gmail.com>
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


--U5j7bXl28fld688g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 12:51:33PM -0700, Simon Glass wrote:
> Hi Ilias,
>=20
> On Thu, 7 Dec 2023 at 02:19, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > In order to fill in the SMBIOS tables U-Boot currently relies on a
> > "u-boot,sysinfo-smbios" compatible node.  This is fine for the boards
> > that already include such nodes.  However with some recent EFI changes,
> > the majority of boards can boot up distros, which usually rely on
> > things like dmidecode etc for their reporting.  For boards that
> > lack this special node the SMBIOS output looks like:
> >
> > System Information
> >         Manufacturer: Unknown
> >         Product Name: Unknown
> >         Version: Unknown
> >         Serial Number: Unknown
> >         UUID: Not Settable
> >         Wake-up Type: Reserved
> >         SKU Number: Unknown
> >         Family: Unknown
> >
> > This looks problematic since most of the info are "Unknown".  The DT sp=
ec
> > specifies standard properties containing relevant information like
> > 'model' and 'compatible' for which the suggested format is
> > <manufacturer,model>. Unfortunately the 'model' string found in DTs is
> > usually lacking the manufacturer so we can't use it for both
> > 'Manufacturer' and 'Product Name' SMBIOS entries reliably.
> >
> > So let's add a last resort to our current smbios parsing.  If none of
> > the sysinfo properties are found, scan for those information in the
> > root node of the device tree. Use the 'model' to fill the 'Product
> > Name' and the first value of 'compatible' for the 'Manufacturer', since
> > that always contains one.
> >
> > pre-patch:
> > Handle 0x0001, DMI type 1, 27 bytes
> > System Information
> >         Manufacturer: Unknown
> >         Product Name: Unknown
> >         Version: Unknown
> >         Serial Number: 100000000bb24ceb
> >         UUID: 30303031-3030-3030-3061-613234636435
> >         Wake-up Type: Reserved
> >         SKU Number: Unknown
> >         Family: Unknown
> > [...]
> >
> > and post patch:
> > Handle 0x0001, DMI type 1, 27 bytes
> > System Information
> >         Manufacturer: raspberrypi
> >         Product Name: Raspberry Pi 4 Model B Rev 1.1
> >         Version: Unknown
> >         Serial Number: 100000000bb24ceb
> >         UUID: 30303031-3030-3030-3061-613234636435
> >         Wake-up Type: Reserved
> >         SKU Number: Unknown
> >         Family: Unknown
> > [...]
> >
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> > Simon, I'll work with tou on the refactoring you wanted and
> > remove the EFI requirement of SMBIOS in !x86 platforms.
> > Since this code has no tests, I'll add some once the refactoring
> > is done
> >
> > Changes since v2:
> > - Spelling mistakes
> > - rebase on top of patch #1 changes
> > Changes since v1:
> > - Tokenize the DT node entry and use the appropriate value instead of
> >   the entire string
> > - Removed Peters tested/reviewed-by tags due to the above
> >  lib/smbios.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 89 insertions(+), 5 deletions(-)
>=20
> Can we add a Kconfig to enable this?

Why? This is the default option that we want moving forward in order to
get the fields populated.

--=20
Tom

--U5j7bXl28fld688g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV6ETMACgkQFHw5/5Y0
tyyEfgv7BkeuhzP1zxMo1Jo9w2Wm9OvQHoKfPhl48qbcYp8K8n8iMGhWo1H4XSX0
iEWiWXiBoVX12gi9btH+Z/TmtXOKmhHFNgCpmIkB4NhEmz9j6sn+TFuGKTI6Rjx7
b2JCRXQeY8XlKXR3Dl0xevkwXpPY5QI+HLQxKc6aMfLxPlGGWosNdThVLDWmJ4VC
FrnBwG7mnv+AQe1wYPMDJnHfpqn5fF0rXQK7BChC/4/qeBjuIKu+bX+zoiiCXult
55ddpnXfXf/hbZt6VXnHL9Fw83N8bwJFbUwL7LEzK9sEX75p2kgkvEvhtU3VVc6V
EGADYqb2Zhx5z6EbzEBEC5ky/OPivNIjXELaTrdW2R3Ugtf95R4YiobHJDd/HGXs
trBS6tghsq5FnRgjsOxlgW5XApI6oWO/6qBYFE7Po4zq8yxnFbMhkQaOyMwYK4Cx
IzeRiqgom4lySV0LNgT3xmz4GjCznNKlWE8WmxVPz+ARH77NG82ouTejAbSo+f58
TpDFz8AE
=3GCI
-----END PGP SIGNATURE-----

--U5j7bXl28fld688g--
