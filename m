Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4FCEC27C53
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 13:52:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1894087F6F;
	Fri,  7 Jun 2024 15:52:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lVEYZks4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CE2587FCD; Fri,  7 Jun 2024 15:52:41 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4C2F87E50
 for <u-boot@lists.denx.de>; Fri,  7 Jun 2024 15:52:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6f95084c257so950862a34.0
 for <u-boot@lists.denx.de>; Fri, 07 Jun 2024 06:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1717768357; x=1718373157; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6txHRFy6kfGwRc0UAXsbYBs1zFstHAMqxGR+QpcealU=;
 b=lVEYZks4RpEczy3SIeGuAOrcNTtB6NNTDmm+fMFoea7/RkXAfF6Pt1RBm5h6lPoNNP
 4v5fRWb9GiZHdQfypYcw/R64qJmfAmcOJ/r0NrwuNeA8bsZKWxNuunmq0sLC9GNckMUb
 e0FgO8SIUo2UlIFr9MosIIeXqzuv+9Jqviqc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717768357; x=1718373157;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6txHRFy6kfGwRc0UAXsbYBs1zFstHAMqxGR+QpcealU=;
 b=reymszJYyHLrOcFsCgi58dH4lwZFL0lrPAX/byp4V0V0J0xxuxUrr9OnEe1GPB+4id
 w9f2ZXZGYIz267m0QqCH7zAkvC3znY+w+ktnvL1gMciagu55XJiDGW9Kr0iAovEFhdYm
 nLxfoprZIBJ/vodqHArw1I11nmd/oLDPbAnCdro22lDRbwqumWSxA/r4NDRxJgAu9CVL
 ME09uW87yphf1Di+W7ATIk7C7V+vCznCz2L3hOCYFsOzvPBQdB8tdbDfRRmfk+UjB4GS
 +Ldm3S8UITw5xzsy/AiHzNdEWbZe85hqW6i4p3e6gxKlUyiaqZl8Zt/Twn1+jsB9M9FI
 R5zg==
X-Gm-Message-State: AOJu0YyNiEntLWDNgntwn2mB57rP/TGvc8LDLJlQW14MdjHb0E4ZKw6F
 3GGlFcF3krC2YQjU8dItQ/sSHh3MQgrs4huCwaQE0CryqvfzUcfu2pmvknPwRUI=
X-Google-Smtp-Source: AGHT+IGUvt4/g6jz7w+XX7qc6Th4VtNIZ/ZoDvfXy+53mrBGuhbXbDGeKkHu1UanMaIf9PMZqoV1/A==
X-Received: by 2002:a05:6870:f613:b0:24c:ae57:b4b9 with SMTP id
 586e51a60fabf-25464462e73mr2976500fac.14.1717768357353; 
 Fri, 07 Jun 2024 06:52:37 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-254480d9e3esm913215fac.53.2024.06.07.06.52.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jun 2024 06:52:36 -0700 (PDT)
Date: Fri, 7 Jun 2024 07:52:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>
Subject: Re: [PATCH v3 00/12] Introduce the lwIP network stack
Message-ID: <20240607135234.GI68077@bill-the-cat>
References: <cover.1717680809.git.jerome.forissier@linaro.org>
 <20240606165634.GB68077@bill-the-cat>
 <97621d9f-584b-41f9-98e9-c6e4346661a5@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tD1ExmBLzBQAcAZH"
Content-Disposition: inline
In-Reply-To: <97621d9f-584b-41f9-98e9-c6e4346661a5@linaro.org>
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


--tD1ExmBLzBQAcAZH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 07, 2024 at 11:11:49AM +0200, Jerome Forissier wrote:
>=20
>=20
> On 6/6/24 18:56, Tom Rini wrote:
> > On Thu, Jun 06, 2024 at 03:35:55PM +0200, Jerome Forissier wrote:
> >=20
> >> This is a rework of a patch series by Maxim Uvarov: "net/lwip: add lwip
> >> library for the network stack" [1]. The goal is to introduce the lwIP =
TCP/IP
> >> stack [2] [3] as an alternative to the current implementation in net/,
> >> selectable with Kconfig, and ultimately keep only lwIP if possible. So=
me
> >> reasons for doing so are:
> >> - Make the support of HTTPS in the wget command easier. Javier T. (CC'=
d)
> >> has some additional lwIP and Mbed TLS patches to do so. With that it
> >> becomes possible to fetch and launch a distro installer such as Debian
> >> etc. using a secure, authenticated connection directly from the U-Boot
> >> shell. Several use cases:
> >>   * Authentication: prevent MITM attack (third party replacing the
> >> binary with a different one)
> >>   * Confidentiality: prevent third parties from grabbing a copy of the
> >> image as it is being downloaded
> >>   * Allow connection to servers that do not support plain HTTP anymore
> >> (this is becoming more and more common on the Internet these days)
> >> - Possibly benefit from additional features implemented in lwIP
> >> - Less code to maintain in U-Boot
> >=20
> > Alright, on Pi 3, I think we have more "output changed, test fails"
> > problems:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D FAILURES =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > _____________________________________ test_efi_fit_launch _____________=
________________________
> > test/py/tests/test_efi_fit.py:452: in test_efi_fit_launch
> >     launch_efi(False, False)
> > test/py/tests/test_efi_fit.py:394: in launch_efi
> >     net_set_up =3D net_dhcp()
> > test/py/tests/test_efi_fit.py:178: in net_dhcp
> >     assert 'DHCP client bound to address ' in output
> > E   AssertionError: assert 'DHCP client bound to address ' in 'Waiting =
for Ethernet connection... done.\r\neth0: smsc95xx_eth b8:27:eb:fc:64:a6 ac=
tive'
> > ------------------------------------ Captured stdout call -------------=
------------------------
> > U-Boot> usb start
> > U-Boot> U-Boot> setenv autoload no
> > U-Boot> U-Boot> dhcp
> > Waiting for Ethernet connection... done.
> > eth0: smsc95xx_eth b8:27:eb:fc:64:a6 active
> > U-Boot>
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D short test summary info =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> >=20
> > I'm going to skip that set of tests and see how far we get but I suspect
> > it'll keep failing on DHCP output being different.
>=20
> As discussed offline with Ilias it might be a timeout issue, although 200=
0 ms
> for DHCP_TIMEOUT_MS seems a large value to me, it might not be enough in =
your
> environment. Can you please try to increase it? NET effectively has a tim=
eout
> of 28 seconds if we take the retries into account.

I increased it to 20000 ms and no change.

--=20
Tom

--tD1ExmBLzBQAcAZH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZjEJ8ACgkQFHw5/5Y0
tywO8wv+KkHdmJfNs6mOcprrSsql8t5kXg+rslUHWRgdusWy9KIn+W39mwzZ1XMh
9mIA2bXfjOxpNQScU6FxoZCabsto3fFZMS4xCvw6Hzofghh322jv+c1qGLjjHLoz
K7Ncl+MaSY+gh6Ptsql8kwYbGyPEIfDdFjBzIBzI85Ar45l/vHfKIsot8T7gv8XR
tDSSt2rDAW1/LmnbFuHrwg4/d+VK3gsXMAkeO4m2beufaLNhSi25hmc0hs5U/NSW
adtJL+pG5n4o7ufrMwurwHv5EM9sLGBDnXL3X6HSoUt1hjMTWgqeL0OLU/q3R3df
pe9npg1DblRoEVmebEGr+nkSW+LwtkK2hT2tsjY9l9qhkJ+4mR4V2elHSEdP4vVi
dR+SI6gwrAxDiVVomS+zShjQUcXO6khycIKQmxfMKeSA4HdKWExyQBf3+16JiXZh
M338klDdDWzoltMR9XOa0WorLAlPpL4B99gpi2M6eAdyBQdk47BewjDgbLH45doI
Xw8YQfHA
=FHxR
-----END PGP SIGNATURE-----

--tD1ExmBLzBQAcAZH--
