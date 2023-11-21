Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF799C61D90
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 18:08:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2E3587590;
	Tue, 21 Nov 2023 19:08:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hzlSvdpm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78A1187574; Tue, 21 Nov 2023 19:08:55 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47CFC87590
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 19:08:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-77891c236fcso385911585a.3
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 10:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700590132; x=1701194932; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bKpio8FbScuFCOB5FgbT0dLJiwH8oSQUN3fhj2KQpNM=;
 b=hzlSvdpmH/gsosDxXkjbtXV1Oo0mjK5IXJH9ST/n0ui6qiAVirYqkksiRw+Mf8ZSIm
 Ewv5ok/cBC4aM+FmDbzPcTj6uf01TBouP6BiKb9tnztL4ueRgkb2hYesmPLQoGfIvMpt
 L0wBCDMo2j2n4SxM+ECsQB4QSJJMXlMTmTb+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700590132; x=1701194932;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bKpio8FbScuFCOB5FgbT0dLJiwH8oSQUN3fhj2KQpNM=;
 b=FCicmeEtuqVCuuYvOXHS7dQZGYuMyj20UQHaAIF0YbfoesboGeDEeInzYmxxxW0Mgr
 P3ZhSn5OtUWrUrZZB4FD72v9n9a/2z3yJ96l8MNQSrMqHTzADeiwj7jH5TRagpiZTJq8
 TIRxe31VACzoxyW0s9vav1OgSsVyaLWRhfTc1f1sLKtgukoDDJfBT49Nuki5L5nl00UZ
 XNRwjnV0Tn18UueAaMR/ICeIqeARNNgE1XBXOed3zD19PlOycEG2mOXo3p8l8YFcSU5E
 z0+sAhHKQgeIJb1qjrw2lP9Gv54/WSDzoVhbC+SBgJZPjEW6wDHfOhAgPmJF/szpqB2h
 Ac8Q==
X-Gm-Message-State: AOJu0YysSvHTxfUJlZp6/ldHiRKsnDVZMFwJF3bvvZsNm6y90Ao4K1CM
 dfbPVZYs0oI6S3Z/mNkSME0qhw==
X-Google-Smtp-Source: AGHT+IEPZw7BK4micv+wMj8staUprJIUjxqBqS5yUIeIQgTC28x8ES8FnSW0bLYgWedFvuT64md1Pg==
X-Received: by 2002:ad4:5c89:0:b0:66d:1f11:8b7c with SMTP id
 o9-20020ad45c89000000b0066d1f118b7cmr16038292qvh.52.1700590132054; 
 Tue, 21 Nov 2023 10:08:52 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-92fa-6f17-75b6-6213.res6.spectrum.com.
 [2603:6081:7b00:6400:92fa:6f17:75b6:6213])
 by smtp.gmail.com with ESMTPSA id
 lw23-20020a05621457d700b00670f8570a24sm4162221qvb.23.2023.11.21.10.08.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 10:08:51 -0800 (PST)
Date: Tue, 21 Nov 2023 13:08:49 -0500
From: Tom Rini <trini@konsulko.com>
To: Dmitry Malkin <dmitry@bedrocksystems.com>
Cc: u-boot@lists.denx.de
Subject: Re: [RFC PATCH 0/2] rpi5: initial support
Message-ID: <20231121180849.GX2513409@bill-the-cat>
References: <CAKRNjQ3iYXO5b3NBBwsuyCeZoexfRyA+CCNxKRMNR_EfJiCVPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7i6I1x/a6todqwxD"
Content-Disposition: inline
In-Reply-To: <CAKRNjQ3iYXO5b3NBBwsuyCeZoexfRyA+CCNxKRMNR_EfJiCVPw@mail.gmail.com>
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


--7i6I1x/a6todqwxD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 18, 2023 at 05:41:34PM +0100, Dmitry Malkin wrote:

> I was not able to boot rpi5 with the latest master. I run into
> dram_init() error:
> > DRAM:  mbox: Timeout waiting for response
> > bcm2835: Could not query ARM memory size
>=20
> Apparently there is a new peripheral layout and ARMC MBOX has a
> different offset within.
>=20
> Turns out there is a compatible node "brcm,bcm2835-mbox" for all RPIs
> (bcm238x/bcm271x).
>=20
> After fixing this I got to the point where mmu_setup() was hanging
> (looks like it was due to incorrect mapping). So I've added a
> definition of first gigabyte of RAM and SOC range for bcm2712 into
> rpi.c.
>=20
> With those two patches and rpi_arm64_defconfig (with disabled
> CONFIG_VIDEO_BCM2835) I'm able to get a working u-boot prompt (over
> serial). FDT comes from firmware (EEPROM).
>=20
> These patches are based on v2024.01-rc2 and tested with RPI5 8GB.
>=20
> Known issues:
> * CONFIG_VIDEO_BCM2835 doesn't work.
> * MBOX get board revision (0x10002) doesn't work (the response status
> is 0x8000_0001).
>=20
>=20
> Dmitry Malkin (2):
>   rpi5: add alternative way to get MBOX address via FDT node
>   rpi5: add initial memory map for bcm2712
>=20
>  arch/arm/mach-bcm283x/include/mach/base.h |  1 +
>  arch/arm/mach-bcm283x/include/mach/mbox.h |  4 ++--
>  arch/arm/mach-bcm283x/init.c              | 29 ++++++++++++++++++++++-
>  3 files changed, 31 insertions(+), 3 deletions(-)
>=20

I'm glad to someone is looking at this currently, thanks! I suspect
we'll need a number of device compatible updates (and related tweaks) to
get most things working.

--=20
Tom

--7i6I1x/a6todqwxD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVc8i4ACgkQFHw5/5Y0
tyyqLQv+KT5pIkVeyGK4JkZgeA/wBjwSNJOBLBuJipbVOCDi0B3DYd9srUOGy7sa
QGh/zFiIyx/OYgN+MGVXnAxVa0R6+Yn4F1v/2wssgDwAPpqmQuJYlPIlep6j2r66
fpGjImQHlDdiCx0FJLT7KHub57D8jpaeQanoDHZya0XvAWeQbkDYZBKwPV9Fto5o
yqws/B1AU1vELEtyhPLQoUQR/dyKF+ee/m3gLo1m6XUQ7Dp97+98v7dr+ad6Wujd
FogRkPkOR4WebQlFKTwU1FAIQ97OGoHrRPyiYSXz0s3cIiPrEEUDeejsaDzDmYFx
i8M5oATOmosRjbh5gk/JKA4UbCn6I06eNwlJ4M1F6V+R4VhLCsOq7q1nKEI/eWL0
xUDPpX7Ez/2ISyG+dZn0ZWfQryKui+9k9kVGc2GD48g6CofmaWe0fe4jVzUcUVe9
2hByTtmHvjBqYb8GQFP9TCJJVWD3YgwJ2RKxnwyuKWWtuT6t1IK2Cn5T/b/C/U3H
m4JrUwSD
=F/01
-----END PGP SIGNATURE-----

--7i6I1x/a6todqwxD--
