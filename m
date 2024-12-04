Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D1DE7716B
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 16:03:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D02578904E;
	Wed,  4 Dec 2024 17:03:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KTueMnGX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E7708909B; Wed,  4 Dec 2024 17:03:36 +0100 (CET)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3BFD888BE
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 17:03:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-4668486df76so63457041cf.3
 for <u-boot@lists.denx.de>; Wed, 04 Dec 2024 08:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733328212; x=1733933012; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bDF9jRAay6c2juIjz+Y84Gbh61VskZk4++xLt8k69QQ=;
 b=KTueMnGXI4/7Rp+9K0qWD1ukIpRxuULcn/bRvR1TxSe7SU35jSmJBaFqt+vOwu/XD5
 sDAkK4itUpbgV1V3zpCdpoZiuP/MpJ01W6dCLRz1+zXZiaGQG8OQMhnGnj0UdhFoiDfW
 f/kSwNwU3F1IOqehHo1w2Fqde0xZgVlBjSXe0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733328212; x=1733933012;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bDF9jRAay6c2juIjz+Y84Gbh61VskZk4++xLt8k69QQ=;
 b=jWBDt6FP9qNa18LNTA6o13WNDGDzvRoU4rZXxYCBjFzgU0JCdcjWCxgpRTanYbGBhk
 fYQLygFb50JX9SSTDupHOyXQoEim426BkKPkRYlZ1xSqJWSHcl/imyyNgAmh+311owjX
 LGfKpdP8nUC8CJtS2kppRRwsCgbfBdx7ydoCM7nGRgZ6/v4q2tM4HndAK6nz28ZYdjH3
 9Jw/ttH16VZo3x3Q2zmeesEjpSiIE0Vf5M9KmWsdXl2BB7euR5CVnAf+sAnF0h22F5+G
 8/SNXs3xnz7aOdVFPgTIyqOGgFve43DSXl6X42KNlJeFBzYAglaEDf6rjBNVAIqKrhYV
 hd/g==
X-Gm-Message-State: AOJu0YxB1Y7Pq5d9IgLvi9NJs9tZ/EtcfJSC2Rf0d/iutWSiCuiRaOF/
 p6DWB5rO+ceUCYeunZywNYzpmP2zP6TXz41vVthdQgSmQTJ6J+6QOLotEfxzTOU=
X-Gm-Gg: ASbGncsjZvyTX2SI0XPeo9xQEi5+GKqOSvWxARnmkfEcaXbDwgsZz7myRzqanBwXcbf
 u5qfkQMz2ROPCgkUQc5SidCqvdDql0jOWohgBtpUbGa7Q+EyJjLT81gwVpHuZwFuiluQ38PEnZ8
 0ZDLMRErZFTKslgrgqN8AXA7xFPXibB5DaFv0rca1otz7cOGtRpPQbkLBcVsenIj3DGehKgUfrv
 6a7dMhFOvFWoeffLrltSknoDQDy34eszPdiCkBab6mPk8rAuw==
X-Google-Smtp-Source: AGHT+IF1n0c7Vb3kkSX0ZRTc+uENCYQNUzkshsBrNjBDLz50U/bcfjFC3lIxLjyBpNsuOWh6g6cYjA==
X-Received: by 2002:a05:620a:454a:b0:7b1:51e9:ed77 with SMTP id
 af79cd13be357-7b6ababe984mr698609085a.10.1733328212350; 
 Wed, 04 Dec 2024 08:03:32 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b6849c3ff2sm621412185a.116.2024.12.04.08.03.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2024 08:03:31 -0800 (PST)
Date: Wed, 4 Dec 2024 10:03:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andy Yan <andyshrk@163.com>,
 =?iso-8859-1?Q?J=2E_Neusch=E4fer?= <j.ne@posteo.net>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>
Subject: Re: [MASTER] Pull-request efi-2025-01-rc4
Message-ID: <20241204160328.GF2457179@bill-the-cat>
References: <8910d434-2d77-425f-aa81-8eb803078aef@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sqTU2mrZUm/HdDcU"
Content-Disposition: inline
In-Reply-To: <8910d434-2d77-425f-aa81-8eb803078aef@gmx.de>
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


--sqTU2mrZUm/HdDcU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 04, 2024 at 01:10:19PM +0100, Heinrich Schuchardt wrote:
> Dear Tom,
>=20
> The following changes since commit f96e5133184aac377b54bd61f8abf78710f2ee=
56:
>=20
>   Merge branch 'master' of
> https://gitlab.denx.de/u-boot/custodians/u-boot-samsung (2024-12-03
> 12:37:20 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-2025-01-rc4
>=20
> for you to fetch changes up to 657310322e5893d0b1bbba002fbe59b318062192:
>=20
>   doc: environment: NET_LWIP dhcp sets ipaddrN, netmaskN and gatewayipN
> (2024-12-04 11:26:34 +0100)
>=20
> Gitlab CI showed no issues:
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/23706
>=20
> ----------------------------------------------------------------
> Pull-request efi-2025-01-rc4
>=20
> With the move to bootstd booting via the EFI boot manager stopped to
> consider all block devices due to missing probing.
>=20
> With this pull request probing of all bootdevs before running the boot
> manager is achieved. Prerequisite changes are needed to pass the CI.
>=20
>       efi_loader: simplify efi_disk_rw_blocks()
>       test: fix test_extension.py
>       configs: sandbox_deconfig: remove CONFIG_AMIGA_PARTITION
>       CI: xilinx_versal_virt: disable USB_DWC3
>       net: eth_bootdev_hunt() should not run DHCP
>       cmd: bootmenu: add parameter -e for UEFI boot options
>       efi_loader: run bootdev_hunt() to find ESP
>=20
> Further UEFI changes:
>=20
>       Avoid writing message in Exit() boot service
>       Update startimage_exit self-test to check error
>       Don't warn if the TCG2 FinalEvents table is not installed
>=20
> Documentation changes:
>=20
>       cmd: bootmenu typo 'read'
>       clk: mpc83xx: Fix typo in "Coherent System Bus"
>       efi_loader: Fix typos in enum efi_allocate_type
>       doc: sending_patches: Fix spelling of "its"
>       doc: environment: NET_LWIP dhcp sets ipaddrN, netmaskN and gatewayi=
pN
>       doc: board: theobroma-systems: fix feature list in introductions

We're about a month from release, and given upcoming holidays for many
people, about to enter a period of less testing of changes probably as
well. With that, the documentation changes are fine. I believe we need
those "Further UEFI changes" as well to fix regressions. But for ESP
changes, I think for v2025.01 if there's specific platforms always
getting things wrong now they can use PREBOOT to init / probe the
required subsystems, and boards / distributions can do similar, in their
bootcmd, yes?

--=20
Tom

--sqTU2mrZUm/HdDcU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdQfUgACgkQFHw5/5Y0
tyxEWgwAqL9vVm0Hh1jlxvsSdYTiN0Gno+lsTk22pztqX0N/T++NHUMv7DEg2xYo
VGeMDyDJb0YdHtad8mbu+f13RV2mgG3kzHM6uO94bsxVW4WZRAOoD6IYFMktUMCU
GHLPo8HiZdWa/swHkjCSMYa3skV32F6jveuef450Ui1Ndx9go8Uz1Ffpamx0jeua
jSJ9YSqJ5MM12+SqxS2tSY/pak18TBpfzY11pGeu8Nm8SkrkHGVB5tHlYCz6D1oA
po85ZpKDFhjnc95NT8gOtRiZCyhc5Rxjp3ibim/gusRnwAf/BYA3Zebs1m/TBK5N
1yOka73SR7wfj48cSvNQM+9Ac4ufbQaYSIp7MRy+rFk0sl8kCo5Mgn/cvOe53pcB
xjvIXWerfJ+ZkKPt382drghUMTDVyoKwgAOgru7rVWW7Ldi82yXa6hJh7798FBn/
JNvFg5BZB2YGKowgiXbXa6AEwc34lZAVy6PFfedCG6ZJQN90lZl+Nh0l7A31cpip
pQATPagb
=3agt
-----END PGP SIGNATURE-----

--sqTU2mrZUm/HdDcU--
