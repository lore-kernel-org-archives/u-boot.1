Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D64FEC282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 13:57:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C18480F4C;
	Tue, 18 Mar 2025 14:57:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eh/FIHG9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9DD3810E8; Tue, 18 Mar 2025 14:57:46 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7610E800B6
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 14:57:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22401f4d35aso105808665ad.2
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 06:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742306263; x=1742911063; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DHKNlWK5KP4Rino0SsEnL8dznBPR2Rbhbl2/2GpKeLw=;
 b=eh/FIHG9hnlElsoWZBIo5MzL2mtXmutOy+AvK1LsHdODWVu+HVf1L3xg8xQb8ytWjk
 1j27p77CH+6qBpL4GZEhYQys0nzi0kkYqNKLqijFdF1a8Ab0Jn8PSUkXJKKeTvvzKBLD
 o5VpfjI/ZRw2LGmBrZ1TlWbKuDOpdqfULA1QI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742306263; x=1742911063;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DHKNlWK5KP4Rino0SsEnL8dznBPR2Rbhbl2/2GpKeLw=;
 b=q0w/rKe8Odx75L0+lQG58+vdcB1y+R9XgKMBXNa7+GQts1vpIiotRU3SwF+nWxNXDK
 Yj2XC+/j/0Ac9f21e7XewkTXThWNxglWAto3X2QhxtfFD2PbXZaQwDPNtYBE06DRl4mh
 rZRdaXmvlnDZ7oItRjViEdUWC+amsdZTA/roijm6mG+EYFBshJGFCwZpPkuSL0cTrdj4
 wIslrZsMUVEJaaOJmvzHpk/xHGqRlicPja9vBc52s/wlmStR4ZmaVyoh6o3mf+2VXTh6
 i8eVgycJzmUdKig7VeKIEmqEdRBnY0eAl1hFjHQ5Ti336UdEI03MEeS+l8XjA83atDDh
 2duA==
X-Gm-Message-State: AOJu0Yw+o5mz4ZvWDGu/eQ7HFqYqcBgrlNbZv22UOQcVr5z/Xd7Ch2Rj
 hM0KBhYcg/U1rNjbVK2wQnyVj/PNwpl0EAWCwS/xMipWXjWb40Z9Xg5eE/4wtCk=
X-Gm-Gg: ASbGncuDPVuYyo9AJwN1gEnSBFO9ktqAls4WgGifuBUc2jwV8O4geGiPrrA5SJoU3GK
 Ii9jXL//WbzUskby6QYmCFofKZ8ukLVJFP7ebuUj7e3/pKC6LEDwAOFR0LqpKnoHvVjEajGdFf+
 GwdDAtc30nPjhJqw7Ry/2mgGmczgSK/1Qvns/F8AZIZXyLZ4Y6oUufiP/pCpbXH0wT47dOsfALa
 HhszevqcJzF+INo6SNkmTVuyRgCS2f2I/H0DnAepxhREfKsT96Tvo+tdM+rodIK/QMNlrXP8FFw
 beAzyrH6oQMZ8YiRsTJLJCuJYHkL0Aj7aOaHBVMmSnhJEg==
X-Google-Smtp-Source: AGHT+IHgl9gVvoMkibvOwsrOi/4A7ytVflBDGi4vOpz/v121V75TnxOh0xwFYat0GTiwXI+Yqz026A==
X-Received: by 2002:a17:902:c951:b0:223:5e76:637a with SMTP id
 d9443c01a7336-2262c562e3bmr44018305ad.23.1742306262868; 
 Tue, 18 Mar 2025 06:57:42 -0700 (PDT)
Received: from bill-the-cat ([187.144.138.125])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c68886a8sm94440135ad.44.2025.03.18.06.57.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 06:57:42 -0700 (PDT)
Date: Tue, 18 Mar 2025 07:57:39 -0600
From: Tom Rini <trini@konsulko.com>
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH] ARM: socfpga: Drop incorrect imply
 SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION*
Message-ID: <20250318135739.GW2640854@bill-the-cat>
References: <20250315012900.399381-1-trini@konsulko.com>
 <SN6PR03MB35836ECB9BAFF92F78B520FEA7DE2@SN6PR03MB3583.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="a57qBbqSZDyhCo5F"
Content-Disposition: inline
In-Reply-To: <SN6PR03MB35836ECB9BAFF92F78B520FEA7DE2@SN6PR03MB3583.namprd03.prod.outlook.com>
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


--a57qBbqSZDyhCo5F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 03:11:44AM +0000, Chee, Tien Fong wrote:
> Hi Tony,
>=20
> > -----Original Message-----
> > From: Tom Rini <trini@konsulko.com>
> > Sent: Saturday, March 15, 2025 9:29 AM
> > To: u-boot@lists.denx.de
> > Cc: Chee, Tien Fong <tien.fong.chee@altera.com>
> > Subject: [PATCH] ARM: socfpga: Drop incorrect imply
> > SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION*
> >=20
> > The use of both "imply
> > SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION" and "imply
> > SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE" here is wrong
> > as those are both part of the same choice statement. Furthermore you
> > cannot select/imply something from a choice statement, it must be a
> > "default ...
> > if ..." construct within the choice statement in question.
>=20
> I think the imply here which allows for overwritten in defconfig.

It doesn't. The specific warning is that these imply statements have no
effect.

> To support the "default....if...", new config for platform specific in
> Kconfig is required. Is there any other approach better to support
> this?

Adding "default SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION if ..." to the
choice statement is fine. But the follow-up question is if it's
something worth being listed like that compared with just being set as
needed in the defconfig.

--=20
Tom

--a57qBbqSZDyhCo5F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfZe9AACgkQFHw5/5Y0
tywgnQv9ErkTewNVIs/DVY1AF8+fbzOcH9OO2Y7N2t3/B+Dc5Jxrc3rUzeRxO9fZ
h88qfNFRldogEm2O9xP8esCFphdSEBx89zkJX9M0S9Ge8hQHrXfxS5xGzQPU+Zb/
FrL+pn37ZATGNyB24CXofl4r8JTFWvwh5SHE9cdGqOZ3quPD3/VxJrXYQdzCSJXo
Zr67ABWLJcIq3WMkv4M+Eoz9KSwkfoR4VbhHUE1mh/6HS2cVh/ma2Rkqp6x/DmHP
61ezoDQEPhwIpVxfuv0B0DeKUjwqI4ynlNq5jAEwyE+yqcHoMxOX5weSr0fTjfuI
Sfp3vkbEOqsaCryDM5FNWQHdzEamthxLcEjNWb5WbIzdIJtOarIymLvaOviVHyLI
OMdZvARQ9K4KNuE7ShgKvm0fEuYJGdhMxFgwqVZo36M5pnwi1xDKX+vt3DcBz0Ix
XdaRDPIDXE6hA8VGPOw2QgCFqu3Vuija6rx5puUwduULswpsrVgiueTsEEyZbagi
OKJ8I/m5
=U6bA
-----END PGP SIGNATURE-----

--a57qBbqSZDyhCo5F--
