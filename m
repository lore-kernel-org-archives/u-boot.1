Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A37C27C54
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 14:25:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62EB3881D3;
	Thu,  6 Jun 2024 16:25:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Vt7BfcYM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DF468839C; Thu,  6 Jun 2024 16:25:35 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6226081F9A
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 16:25:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-2509f93959bso398314fac.1
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 07:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1717683932; x=1718288732; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4Ses8crwPcSnYyKXJHMqHLTgpMFudKTl6b7KmLTZbTQ=;
 b=Vt7BfcYMiZCEyhMj4XT8E7a735HU/ZK2G5MtQUR4sPm7/VBwF8sBrT/TXptMlNgdEB
 WNb0Gi8l0G5dqys1P0m0Aws0drVLGEKEUXh4F4L71p7zG8uc4+WR/XCa5N9WP55LXnco
 i3WOT5v8KmgTKEW9te0eH9GZ+bzieGo2spvJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717683932; x=1718288732;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Ses8crwPcSnYyKXJHMqHLTgpMFudKTl6b7KmLTZbTQ=;
 b=blJ19jFPLMWfinTSkza35CtKKytKv+dGchE2l23oLTzrujJrFqjZO2WYOiCrxtWP+7
 wV0i5UybqZLSXrgEJHTSktqi4dUj0VZQuvvwFpr88mZ3OiN9LYGIoMNf3TaZky38o4Er
 J3Pc5uFY90L1wExFg32Zw4FJvTxmiqTv11Gl2bPDG4uJwlb619uK44112JYU4nRLPjBz
 /3PMLKpMTpQpi5WqCeCBpQK0GjAx4M/0wkKDmZdkgELSu8tCI9287vGOHQcFzvLEmKex
 vYVnq06U44aYYzUYrUeRkSYHFmdGJu9pyKiPXwAQN0aRBkRQRLrMqTLGRJdytcWWSmMR
 ukKA==
X-Gm-Message-State: AOJu0YxGAni+4yuJ47PNDxzjErhTaRscAw/FoIsRHPjlnAAMRoE9brN2
 clGhBajapP6EgHrJMOmjDmWlfOOoiVB3bfSE7ZyoPVgaU3d8F64bjSdJBBxGOdI=
X-Google-Smtp-Source: AGHT+IG4GY+kwPSdfuKOzJAF6YnfLQGo6KzCKmjXFEZUXTInv5H5r2s8bg4hizKCXGOoipFjqU9GSA==
X-Received: by 2002:a05:6870:d0c7:b0:23c:adb0:c31b with SMTP id
 586e51a60fabf-2543fe50c26mr1155663fac.0.1717683932026; 
 Thu, 06 Jun 2024 07:25:32 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-254480d9e3esm379713fac.53.2024.06.06.07.25.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 07:25:31 -0700 (PDT)
Date: Thu, 6 Jun 2024 08:25:29 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>
Subject: Re: [PATCH v2 00/14] Introduce the lwIP network stack
Message-ID: <20240606142529.GZ68077@bill-the-cat>
References: <cover.1716566960.git.jerome.forissier@linaro.org>
 <20240527153447.GI2568172@bill-the-cat>
 <5010e5bf-1059-4e14-a260-28f383ff7347@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FPXKYnBqEKh6n+X8"
Content-Disposition: inline
In-Reply-To: <5010e5bf-1059-4e14-a260-28f383ff7347@linaro.org>
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


--FPXKYnBqEKh6n+X8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 06, 2024 at 11:15:54AM +0200, Jerome Forissier wrote:
>=20
>=20
> On 5/27/24 17:34, Tom Rini wrote:
> > On Fri, May 24, 2024 at 06:19:54PM +0200, Jerome Forissier wrote:
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
> >> etc. directly from the U-Boot shell.
> >> - Possibly benefit from additional features implemented in lwIP
> >> - Less code to maintain in U-Boot
> >>
> >> The first patch introduces a new Kconfig symbol: NET_LWIP, which selec=
ts
> >> the lwIP implementation instead of the current one (NET). Contrary to =
the
> >> approach chosen by Maxim in [1], NET_LWIP and NET cannot be enabled
> >> simultaneously. The rationale is we want to start from a clean state a=
nd
> >> not pull potentially duplicated functionality from both stacks. Note
> >> however that a few files are still built in net/, they are the ones
> >> related to ethernet device management and the ethernet bootflow.
> >>
> >> The second patch imports the lwIP code as a Git subtree under
> >> lib/lwip/lwip. Some glue code is added under lib/lwip/u-boot.
> >=20
> > For next time, please just make it a pre-req to run the git subtree
> > command (and note it in the cover letter).
> >=20
> > In more specific feedback, I tried this on a Pi 3, and:
> > U-Boot> tftpboot 200000 EFI/arm64/helloworld.efi
> > TFTP from server 192.168.1.10; our IP address is 192.168.1.100
> > Filename 'EFI/arm64/helloworld.efi'.
> > Load address: 0x200000
> > Loading:
> > ....
> > FAILED test/py/tests/test_efi_loader.py::test_efi_helloworld_net - u_bo=
ot_spawn.Timeout
> >=20
> > So some amount of networking is working (that's a reasonable dhcp
> > response it got), but tftp'ing a file fails.
>=20
> Thanks for testing! This fails because I changed the command output. The
> legacy command prints "Bytes transferred =3D" while the newer one prints
> "%lu bytes transferred" plus throughput information. I will use the older
> message in v3 because several tests as well as documentation would need
> updating. We'll do that later if desired.

Thanks. And yeah, I would like to keep the output unchanged as much as
is feasible, it's in many ways a form of ABI.

--=20
Tom

--FPXKYnBqEKh6n+X8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZhxtkACgkQFHw5/5Y0
tyyqLAv+Mdl+iUEoihhqIoE1aO8tehlInXxU4c1M1CDUXGF/y8iNpo8A4Y/cKyd9
nVcI0Khd7s7xz4dSpjgAilt2E7MTm/EpV6IARtKrKbK0ESyEQzy+xZSBlHyIcG9R
q+YaFIHfmC4Nx+X6NTuCx3nv2G60TuxsEyRTxW5Ch9orIjRDBaw9uV5K33WC3ExN
3mbnZeoR5OTbH6kCK1dCVXpE4iplaGFNVRXwAw/A9hPtuEmhwMYFO2+nLxiKWFYo
C6qNMqSFwi8L4jOTrLhDYYouqY8nleT8yNI7IQ9EY8+sOJsS+2IbHqnq7TxPQsEV
iH2sufJ/mv4pWh7KenK4AvN0ch7NeCRQpytDZUnuxWDfGcayTO7+uKUJqnlPED3b
BJ6YDI7B0/ZittirlP+Lz3ULZfLwViGP+gM0YRvM4UmzZFOM1G0AcFYThSdeU49S
Gncmf6jZxAJC4GEYm7iD3N+3VMqJuEK3NKDfSAWtHYHvMrZq4Merd06YP6Dx7YrY
Wi6A84IE
=SC0O
-----END PGP SIGNATURE-----

--FPXKYnBqEKh6n+X8--
