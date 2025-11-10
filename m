Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C42CCFA13
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 18:32:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6815483A8C;
	Mon, 10 Nov 2025 19:32:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Q5DlX7zu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BA09835B3; Mon, 10 Nov 2025 19:32:55 +0100 (CET)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12DA383A8C
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 19:32:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-3e7ead70738so818118fac.0
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 10:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762799570; x=1763404370; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HBDl8aKlNT6qNUThiNkQcWw1c1xE7utB5o5amA63tsc=;
 b=Q5DlX7zubfcqZZxrb3K1aiu840zUm/4gLVUxFeJHtEl81qbV0wpY4IlARCBngcnczX
 PUJzRhin2CSaUY2PVhP4LDgWnkn/Xn04Lo5TmunIpmeKmBt711pjplqzdDE0s5SwQh9w
 k3x98UAykNfvR5c3PIVzOb6+v7AtEvt+jbGbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762799570; x=1763404370;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HBDl8aKlNT6qNUThiNkQcWw1c1xE7utB5o5amA63tsc=;
 b=R2sY7JeXdouwhbj8Ge2uQ9a4fD12Sl61IOzhaDxb/YXnIquqj/0JYRlABFGm6IkEcu
 tcAlGfWqCbUo1oovMjIPTZCg3bej1EcnFg4rMmSe0jtaWStX8c9TLFplBlYDT6ygiMX6
 jCngsqP+PC7mfTViFWVCYNNZtyEi8flPMvn8WRHqbx3Q84wlBvlFk/sckLxWCwaeNAuF
 flKG0n+7PdBCRz9LE8R7ECloDCnI+yxx3fA0pI0KKqjL/BQH8etWWir8vZp5rpFkpusL
 Gb23oSBrZCSzSmSLPAKHs9cemhNv8MJsFfhnNff9noWEtWPatGQzuOHdhcAEPyGa9GWH
 HiFA==
X-Gm-Message-State: AOJu0Yy9w4YmuoX3zgqvXnm2+oTZugDRC9TRpVzLAMsfCs3XESugsIsj
 DcViYhYk3g8HV1PCesheI5n+/ruuksj0EQxsjzWl9dS/NXj5qV7BLN6Miqmfkdx1jZhdfzHCFeh
 4TgP+DmWxJw==
X-Gm-Gg: ASbGncshck3UxMbT+XGEFOMtDGNfac8K+UAdiOzfH3JoCFHUhcoJaWxJ49fG+4ZHTzh
 O7xoACSvudzXrnSz5K/hkMHw3Z+g/BaObedUbwR/baZR6Y/PoIevPMo3HL7PqDSLnuNfwgaUJJV
 C+lPTthhptU0xV2rqN4J/RxbClonfuCw6EvvHLgbjuBXLZwCzSJqFyZaeTAs3OPiqFtlDWau0b2
 C9iPCyA7jFQfUDxt4VGpWykbRxn7IMfkiddyNMbs7LVNlXtDGtsrc7ZnudPeZ2MaL4BZXuX8VpO
 hvPccbmUwGeoLGPGQtyBWI9io6Tnc7XDKUvdfNLeDmV3QlnVbwyuG3FHZfNdW0skfxCL1ZYSv1H
 1NarcGwNRsDAvTH8pgOQ6wyN8r637SVGbfvgAEPRuSDYUUe3+XSe+okyQsGX06j4ZXr+pjlDPI4
 2UfgmZvg63l/jYdpl7n5YplvvGC4/rvmXELHKA2+I1BHlIS57WqqFUfOSqZKYC
X-Google-Smtp-Source: AGHT+IFTeD192z61cr5bNOsfGVwMZB7vh5AlEsEtmxQrD7WbwQWlXnVwDvNibWLdGtKSZKfR/g689w==
X-Received: by 2002:a05:6870:d1d3:b0:306:f5cc:5645 with SMTP id
 586e51a60fabf-3e7c279617bmr4499022fac.31.1762799569709; 
 Mon, 10 Nov 2025 10:32:49 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e41f13d088sm6811596fac.13.2025.11.10.10.32.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 10:32:49 -0800 (PST)
Date: Mon, 10 Nov 2025 12:32:47 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2026.01-rc2 released
Message-ID: <20251110183247.GP6688@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="thmUADWXFAr8b1Xc"
Content-Disposition: inline
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


--thmUADWXFAr8b1Xc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

So it's release day and I have tagged and pushed things out. Looking at
my own queue, I see some small changes I can still pull in (spelling
fixes, Kconfig dependency fixes and so on), but anything else is for
-next now. And there will be some bigger sized things going to -next,
including updating our host containers and updating LLVM.

We're continuing with a community meeting following the release and the
calendar link is
https://calendar.google.com/calendar/event?action=3DTEMPLATE&tmeid=3DZGNsNT=
h2YWQ2YTB0ajAzZXRkdDVhdjFuNmpfMjAyNTEwMjhUMTUwMDAwWiA4OWJlN2I4MTMxMzZiZWMwN=
mE4M2RlNGRhNTk3NDVmMGFiZDExYzFiODM2MDYxYWUwNmMxYzdkYmNkMThkZjQxQGc&tmsrc=3D=
89be7b813136bec06a83de4da59745f0abd11c1b836061ae06c1c7dbcd18df41%40group.ca=
lendar.google.com&scp=3DALL
and once again this is the same time as the previous meeting. The
meeting details itself are:
https://meet.google.com/btj-wgcg-euw
November 11th, 2025. 9am (GMT -06:00)

To join by phone:
https://meet.google.com/tel/btj-wgcg-euw?pin=3D1307528552322&hs=3D1

In terms of a rough changelog:
- Pulled in more fixes for issues found by smatch.
- More platform updates that were outstanding after -rc1.
  - We now have QEMU for testing transfer list support so vexpress_fvp
    has been taken out of Gitlab CI where it was failing due to race
    condtions for console quite often.
- Subsystem updates (MMC, UFS, USB, board extensions support, UEFI, DFU,
  documentation)
- Falcon mode support for secure platforms
- We can use clang to build on 64bit ARM platforms again (and there's
  some further fixes here to pull in).

I continue to plan to do an rc release every two weeks and the final
release will be 05 January 2026.

Thanks all!

--=20
Tom

--thmUADWXFAr8b1Xc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaRIvzwAKCRAr4qD1Cr/k
Cp57AQCogAmCuxHJ9Cgve6sqhjhx1N/34QgkMEC0ICgpA8gIoQD8C/AR6wFQZIQx
VRPxJVDAtYQvZIYd+x3nwEh7edhgfAA=
=yLoS
-----END PGP SIGNATURE-----

--thmUADWXFAr8b1Xc--
