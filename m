Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FA4EC4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 20:56:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B60F88782E;
	Wed, 13 Dec 2023 21:56:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qPFcFMp0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 871DB8784E; Wed, 13 Dec 2023 21:56:40 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FE5986F7E
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 21:56:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-5c85e8fdd2dso72330967b3.2
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 12:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702500997; x=1703105797; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aUYrQhmulTwOBndpOgr2g2/+p8WY7Ra7rfZG0QOXu3I=;
 b=qPFcFMp0DajE1rvH+RATPwc1ecu2M0U6S0WKPxZAp2nhTs3+pmKccaX8c4Pmmlv1on
 9Fci+DgUiNkdUX0NOkdUTWsM7DZ1kbfVVJSciNnap4it5ZukNRgtXGvE1WIomsvQ1h/s
 j+lZHH3zKDdrzlmFU7oTg1Kh0eBG60kVFME2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702500997; x=1703105797;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aUYrQhmulTwOBndpOgr2g2/+p8WY7Ra7rfZG0QOXu3I=;
 b=dae/rwVuS7npDKn0gO/J8R2sg9bUMd8AD7cN6YR0jt9/8YvzjoJy79r+cf/J/GD5un
 i2Fjxs1gBKIWH6Qqpf5DC4uTntBVbNQWfC/66JKuqxAovp/3Z8YC9qENETivzoJj+GP2
 FlPfD/jrA/IiToZlBWtqVP0HlaoGyCLweMUtUqQXCHDwvGQy8OE4AwRjsezMho39QN6g
 3B6V9VZx0Q/C1EKo1FGuTzTJEVZhLT/Bwl65epg79IooJyEYEgsRAJaPzTklItNNqTHL
 KPoXfR8E94xtLGFEmPegFpJ8PmyaDaaWdOkwuiHh+4b8kJzdy7e0P7rGPH8rNNBsQ9og
 Ufwg==
X-Gm-Message-State: AOJu0YyxoaRKT8i+U3V2DEarDh5CGgiX/I7vmygWky21j6niOF4zCfyf
 VJpO3hUhUep9UpUUmwLU1xzZ+w==
X-Google-Smtp-Source: AGHT+IHaIF/C1N0JeiIMhTCvRM0amMOOH0kyy6YD3Swf2WqKH42AaCb6pA6KV9VtmZ2MKwtzJgquFw==
X-Received: by 2002:a0d:d956:0:b0:5d7:1940:dd63 with SMTP id
 b83-20020a0dd956000000b005d71940dd63mr6712979ywe.57.1702500996762; 
 Wed, 13 Dec 2023 12:56:36 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-d78a-ada8-3cce-fa3d.res6.spectrum.com.
 [2603:6081:7b00:6400:d78a:ada8:3cce:fa3d])
 by smtp.gmail.com with ESMTPSA id
 d62-20020a0df441000000b005d6f34893dfsm4957180ywf.135.2023.12.13.12.56.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Dec 2023 12:56:36 -0800 (PST)
Date: Wed, 13 Dec 2023 15:56:34 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, sean.anderson@seco.com,
 neil.armstrong@linaro.org, heinrich.schuchardt@canonical.com,
 mark.kettenis@xs4all.nl, u-boot@lists.denx.de
Subject: Re: [PATCH 2/2 v3] smbios: Fallback to the default DT if sysinfo
 nodes are missing
Message-ID: <20231213205634.GK2513409@bill-the-cat>
References: <20231207091850.17776-1-ilias.apalodimas@linaro.org>
 <20231207091850.17776-3-ilias.apalodimas@linaro.org>
 <CAPnjgZ2hMB0uTTd7tKZ2bGHkPiKM8j+Dz47nXKwiXH6vWHF8tQ@mail.gmail.com>
 <20231213201655.GF2513409@bill-the-cat>
 <CAPnjgZ3G_3iUcHoOFGGYQ5Dxho5HwqcH=TqwS3j-NoNcBCEdkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jCBVs7/C08ZA51j4"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ3G_3iUcHoOFGGYQ5Dxho5HwqcH=TqwS3j-NoNcBCEdkA@mail.gmail.com>
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


--jCBVs7/C08ZA51j4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 01:41:04PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 13 Dec 2023 at 13:17, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Dec 13, 2023 at 12:51:33PM -0700, Simon Glass wrote:
> > > Hi Ilias,
> > >
> > > On Thu, 7 Dec 2023 at 02:19, Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > In order to fill in the SMBIOS tables U-Boot currently relies on a
> > > > "u-boot,sysinfo-smbios" compatible node.  This is fine for the boar=
ds
> > > > that already include such nodes.  However with some recent EFI chan=
ges,
> > > > the majority of boards can boot up distros, which usually rely on
> > > > things like dmidecode etc for their reporting.  For boards that
> > > > lack this special node the SMBIOS output looks like:
> > > >
> > > > System Information
> > > >         Manufacturer: Unknown
> > > >         Product Name: Unknown
> > > >         Version: Unknown
> > > >         Serial Number: Unknown
> > > >         UUID: Not Settable
> > > >         Wake-up Type: Reserved
> > > >         SKU Number: Unknown
> > > >         Family: Unknown
> > > >
> > > > This looks problematic since most of the info are "Unknown".  The D=
T spec
> > > > specifies standard properties containing relevant information like
> > > > 'model' and 'compatible' for which the suggested format is
> > > > <manufacturer,model>. Unfortunately the 'model' string found in DTs=
 is
> > > > usually lacking the manufacturer so we can't use it for both
> > > > 'Manufacturer' and 'Product Name' SMBIOS entries reliably.
> > > >
> > > > So let's add a last resort to our current smbios parsing.  If none =
of
> > > > the sysinfo properties are found, scan for those information in the
> > > > root node of the device tree. Use the 'model' to fill the 'Product
> > > > Name' and the first value of 'compatible' for the 'Manufacturer', s=
ince
> > > > that always contains one.
> > > >
> > > > pre-patch:
> > > > Handle 0x0001, DMI type 1, 27 bytes
> > > > System Information
> > > >         Manufacturer: Unknown
> > > >         Product Name: Unknown
> > > >         Version: Unknown
> > > >         Serial Number: 100000000bb24ceb
> > > >         UUID: 30303031-3030-3030-3061-613234636435
> > > >         Wake-up Type: Reserved
> > > >         SKU Number: Unknown
> > > >         Family: Unknown
> > > > [...]
> > > >
> > > > and post patch:
> > > > Handle 0x0001, DMI type 1, 27 bytes
> > > > System Information
> > > >         Manufacturer: raspberrypi
> > > >         Product Name: Raspberry Pi 4 Model B Rev 1.1
> > > >         Version: Unknown
> > > >         Serial Number: 100000000bb24ceb
> > > >         UUID: 30303031-3030-3030-3061-613234636435
> > > >         Wake-up Type: Reserved
> > > >         SKU Number: Unknown
> > > >         Family: Unknown
> > > > [...]
> > > >
> > > > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > > ---
> > > > Simon, I'll work with tou on the refactoring you wanted and
> > > > remove the EFI requirement of SMBIOS in !x86 platforms.
> > > > Since this code has no tests, I'll add some once the refactoring
> > > > is done
> > > >
> > > > Changes since v2:
> > > > - Spelling mistakes
> > > > - rebase on top of patch #1 changes
> > > > Changes since v1:
> > > > - Tokenize the DT node entry and use the appropriate value instead =
of
> > > >   the entire string
> > > > - Removed Peters tested/reviewed-by tags due to the above
> > > >  lib/smbios.c | 94 ++++++++++++++++++++++++++++++++++++++++++++++++=
+---
> > > >  1 file changed, 89 insertions(+), 5 deletions(-)
> > >
> > > Can we add a Kconfig to enable this?
> >
> > Why? This is the default option that we want moving forward in order to
> > get the fields populated.
>=20
> The model name is fine. The manufacturer is in lower case (using the
> DT vendor name), so not in the right format.
>=20
> It only populates two fields, so far as I can tell.

Maybe we need to turn this discussion on its head slightly. What do you
want to do to get SMBIOS fields to be widely populated with
generally-correct information? What we have been doing has seen very
little adoption so we need something else.

--=20
Tom

--jCBVs7/C08ZA51j4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV6GngACgkQFHw5/5Y0
tyxi5Av/aRQmZGBxFt1UTH4XkIColReLxVAVfzYO3Kwlxr13Fwlg2envTG4CWmE5
FMVSEcLBDETZin7Z1+6vmtWY4S9OiYGynyATWB3wkKCibq0NeQEUCDW9vBs9PcPL
n3YH7wCwsF3QDf9XBGC5tpbWNSRPke0kdrl0VJd7Vi0RMtHjy8v6IZd4aV98rB6T
ZeYOPxHoBuj8V5GD0pkImP2CgETRUEFt4ShtT9+mzY5xhN12fGzywA6ObfReWsad
VIXYdtpxSDTQxoM0up6CydUfRYeEWoxxrt6nh5h6tqLYCETraeQ1NWDDT6kllKL1
DIDYZA6w4scR7J2OsME2I1YmT8wVAlj4zDwx+ZNVhayg16ATBepmdzcL3EbGEpjz
iJaCIqU1TFmtBhO2/AeXZykGDZCToVYadS0KBgu4PLqb3nq6bmkS2GonyIjbd5lu
FvayygA71XSuItGKS4YpAJU+t3FpnPJCL1XJx9rIk0fPFl+2v0RMWo/2HcWnknCj
5nCJFRCB
=/a1i
-----END PGP SIGNATURE-----

--jCBVs7/C08ZA51j4--
