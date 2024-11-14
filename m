Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F824D68B36
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 16:34:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 500AE8963B;
	Thu, 14 Nov 2024 17:34:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OpDY2KaF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A136E8963B; Thu, 14 Nov 2024 17:34:02 +0100 (CET)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EAFB89072
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 17:34:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-5ebc0dbc566so360518eaf.3
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 08:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731602039; x=1732206839; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=X+YvYXe7P8W3Q/b0vk8WQGVx8C3b1Xo7Czbi5uPXiCs=;
 b=OpDY2KaFT919rn3W8TkB8+SlEoAfDjhaZHPIES9MkdS988zFewUxkGeCmDHwmr6I6i
 4ejKfBKu2YD1bOKHXGXjgLckGWhmnGZp6EgET3SpeX3MGh5ihZ/J5iyPcGYVhoivVy1L
 v38G36DrNITOn0Cw0AVbGNDGMDcnCAJFa4uv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731602039; x=1732206839;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X+YvYXe7P8W3Q/b0vk8WQGVx8C3b1Xo7Czbi5uPXiCs=;
 b=OZeEmJLqBGBYPO7k/pZ4t5qPC+Mfo6lzzovCZt1rY/T+Dwwtonaa1QTH/JlZ/KBVo9
 ONJ7j1gs1L/CSzzhZ9aYkToNnL4lBSXArsLVELS8o6l0JMy7CyPKnzQrhxYiviqKWyum
 nQFJGY0opFieGjvQrXQQ5Td7klyGRlGCr3myXbBYZJvBxLTSivzR2NZAqFp05vb80nJp
 6KVD03Q7vXjNsy8Jfgjgf8Ngw0W4a8GmtZVO3YuummfN6NUvHXAIiKJD67gJWuHFz+mP
 GkaPDgCXjNvrAHANYNnlXcR59x52Su3scmd749oI7myKj7wyf8/dxlP5KxRqvusDrz4F
 x5Pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuHbeNy+w/LS4U69Dfl+2w7oi+y2U61hyDqFXahT8aal1J7mYv8pooHnT4jTe9NNbkadhE0O4=@lists.denx.de
X-Gm-Message-State: AOJu0YzlPI/SnOenG80/Fd6wsXRi7TGAtihm4j2ib+GFJG8qGPkn7tub
 Ji7CZnbYNba66LL8m63P4XSv9djnwz36rwprlpMRNsfIb3ek83Pgwy504cIiBJQ=
X-Google-Smtp-Source: AGHT+IHxSCeSvVRmVh2oxACyN0NUT81cMTYeBCzxK9v0IXWMpV4qzgMocdaqoUGt4VoTTRdbzclY0A==
X-Received: by 2002:a4a:e914:0:b0:5e5:b5d1:ee19 with SMTP id
 006d021491bc7-5ee57c71da3mr17700023eaf.8.1731602039128; 
 Thu, 14 Nov 2024 08:33:59 -0800 (PST)
Received: from bill-the-cat ([145.14.135.248])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5eea00d6539sm423521eaf.5.2024.11.14.08.33.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 08:33:58 -0800 (PST)
Date: Thu, 14 Nov 2024 10:33:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>,
 Wolfgang Wegner <w.wegner@astro-kom.de>,
 Thomas Weber <weber@corscience.de>,
 Stefan Herbrechtsmeier <stefan@herbrechtsmeier.net>,
 Tony Dinh <mibodhi@gmail.com>, Phil Sutter <phil@nwl.cc>,
 Siddarth Gore <gores@marvell.com>, Luka Perkov <luka@openwrt.org>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Heiko Schocher <hs@denx.de>,
 Evgeni Dobrev <evgeni@studio-punkt.com>, Stefan Roese <sr@denx.de>,
 Ilko Iliev <iliev@ronetix.at>, Dave Purdy <david.c.purdy@gmail.com>
Cc: "zdi-disclosures@trendmicro.com" <zdi-disclosures@trendmicro.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: ZDI-CAN-24679: New Vulnerability Report
Message-ID: <20241114163354.GH3600562@bill-the-cat>
References: <DM5PR0102MB3477A6AC67623306D970177980AC2@DM5PR0102MB3477.prod.exchangelabs.com>
 <BYAPR01MB38307E0A0D8A480B35F122F6805B2@BYAPR01MB3830.prod.exchangelabs.com>
 <20241114145636.GF3600562@bill-the-cat>
 <868d9f51-0d84-4c22-abdc-95cd60184465@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Op4gffea2gHXsU1z"
Content-Disposition: inline
In-Reply-To: <868d9f51-0d84-4c22-abdc-95cd60184465@amd.com>
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


--Op4gffea2gHXsU1z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 04:07:15PM +0100, Michal Simek wrote:

> Hi,
>=20
> On 11/14/24 15:56, Tom Rini wrote:
> > On Thu, Nov 14, 2024 at 04:02:29AM +0000, zdi-disclosures@trendmicro.co=
m wrote:
> >=20
> > > Hi,
> > > Do you have any updates to share regarding this vulnerability report?
> >=20
> > Michal, microblaze-generic is the most active platform that enables
> > FS_JFFS2 by default and so vulnerable here. Can you find some resources
> > to look in to fixing this please? Thanks.
>=20
> We have actually discussed this recently and we have other issues with jf=
fs2
> and not going to fix it or recommend to use it.
> JFFS2 should be removed from our configs and it is also not under our reg=
ression.

Ah OK, thanks. Adding a few more maintainers now then.

--=20
Tom

--Op4gffea2gHXsU1z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc2Jm8ACgkQFHw5/5Y0
tyxSjwv/W3dt/T6KavlTQBIGBTUobVsQB6zfFtTAlbLO+ubySMTuWwNJ242lV+US
FC0iMaFCU9j7MEiGmVJZTsnJ2RS+DXLKHb07oR7NZHleWZI/VXBgyF3y0yWU0kHV
bznWOwr9OUYff9NHAhvQEvJgWB8zUDlAasdQuZcowaMcidTfg5VT9khoyeu9pOK+
+oA9tuYd2MqwSGHSSQCPZXDKIV5BqBxp2qCj8V9bpmo1bTU0KQJI4N3NOmTBU3+V
11BbW3czIEQIEnUr5M56h7QmWbKTF4xDHecfftzQQpfnEfr1ZGWWKIZ5sIqhtq/c
n1aBpd7zbs6Cg+9IVuf7uLmrU/Rp9ZI9UkCgHHLol/vRVBk5TjCWTjoyiGS/SqDW
ksMIsm1OYSjgJk584ZNnIqT90ifHd7yBCAlelAG8VgQ6iRhttEUzMOzxRcKQZF28
7olX8MAZTyrJDZI3BoC9bZ7UY2OBAAJ0qmjAU5y6rfCKsUoRJdCRRMDkdh7AK8vD
dTi7C87k
=lFh2
-----END PGP SIGNATURE-----

--Op4gffea2gHXsU1z--
