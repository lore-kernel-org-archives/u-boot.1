Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C03C2D0D1
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 18:13:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 362D687572;
	Mon, 24 Jun 2024 20:13:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KDozcpfa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3814087572; Mon, 24 Jun 2024 20:13:09 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01428883CD
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 20:13:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-700a8e595eeso1197521a34.3
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 11:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719252786; x=1719857586; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IiPFwn36fRz/REUVMVaYdmIQuoy0dyqo1bLE6VL+Sx8=;
 b=KDozcpfaBmHa4jfm/hO3mBYMU6aEWu8N4X30fHsO/KR/iyQyqlO0HZQNqe6ap/XaRj
 y7Y234tU+84efnBaUdf47Li4F+wgAT4Av7obHiIfYb9sougq1aAcJ+o5pfu2cFMBDXaP
 +2C1JxRpYdfwjldW+dgFCQteh1ded3aVaNHFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719252786; x=1719857586;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IiPFwn36fRz/REUVMVaYdmIQuoy0dyqo1bLE6VL+Sx8=;
 b=HVXTr9Sa8GWqiYTS5xBxNoPNbTL0MoPxntomu09ds+89PfbqiWERU77PPVSEVS/acf
 WMDNaYJbN5v3cE3zmHt2II4hEV7vy7e1bowtflQU6Okdk4g+6x8HqvDQQbMtZh994xB7
 LoI8ltLcPI1hnh8diyUVzAfyDRypfCx7L2yK8jlZTlJh6yO4EBwBTAKeohx+cps4DpE6
 Un0TqmgKDYIN2fR1EVXhzizsdwLWpo8GMIJGiaqCXLDGGNfVG5bF3HWJFrQNpAgYb8CC
 W4RzctPeGAJImtjuyUfiqhKd7lPrWFP/40kovAOYmyLY9YppYqNNaU7oYZnr1qfRhTM5
 NU8Q==
X-Gm-Message-State: AOJu0Yz7FUkzBBZ2z1vv5m+4ysaySgCklwjkXy3U1pRBi47vSdDttvt2
 4zVMMAvVXAOG8FnthjSkjz4c6xrCvCawF6R56yOvDmTkW9jYwdTDwkkuScbAl+k=
X-Google-Smtp-Source: AGHT+IH0anXJC6K3RSIC2q6epC0NJI3T4ukIKYEU2ljxqG0exLYMYrRKIg3k8SLkuafcHmvKv1gRlQ==
X-Received: by 2002:a05:6871:588f:b0:25c:9a02:cb61 with SMTP id
 586e51a60fabf-25d06bc7e5fmr5807801fac.7.1719252785652; 
 Mon, 24 Jun 2024 11:13:05 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-197-45.totalplay.net.
 [187.190.197.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25cd4941ce4sm1990659fac.12.2024.06.24.11.13.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 11:13:05 -0700 (PDT)
Date: Mon, 24 Jun 2024 12:13:03 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 08/19] test: Introduce the concept of a role
Message-ID: <20240624181303.GH38804@bill-the-cat>
References: <20240623203213.1571666-1-sjg@chromium.org>
 <20240623203213.1571666-9-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SlMNhPD1+6CYXl97"
Content-Disposition: inline
In-Reply-To: <20240623203213.1571666-9-sjg@chromium.org>
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


--SlMNhPD1+6CYXl97
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 23, 2024 at 02:32:02PM -0600, Simon Glass wrote:

> In Labgrid there is the concept of a 'role', which is similar to the
> U-Boot board ID in U-Boot's pytest subsystem.
>=20
> The role indicates both the target and information about the U-Boot
> build to use. It can also provide any amount of other configuration.
> The information is obtained using the 'labgrid-client query' operation.
>=20
> Make use of this in tests, so that only the role is required in gitlab
> and other situations. The board type and other things can be queried
> as needed.
>=20
> Use a new 'u-boot-test-getrole' script to obtain the requested
> information.
>=20
> With this it is possible to run lab tests in gitlab with just a single
> 'ROLE' variable for each board.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> (no changes since v1)
>=20
>  test/py/conftest.py | 31 +++++++++++++++++++++++++++----
>  1 file changed, 27 insertions(+), 4 deletions(-)
>=20
> diff --git a/test/py/conftest.py b/test/py/conftest.py
> index 6547c6922c6..5de8d7b0e23 100644
> --- a/test/py/conftest.py
> +++ b/test/py/conftest.py
> @@ -23,6 +23,7 @@ from pathlib import Path
>  import pytest
>  import re
>  from _pytest.runner import runtestprotocol
> +import subprocess
>  import sys
> =20
>  # Globals: The HTML log file, and the connection to the U-Boot console.
> @@ -79,6 +80,7 @@ def pytest_addoption(parser):
>      parser.addoption('--gdbserver', default=3DNone,
>          help=3D'Run sandbox under gdbserver. The argument is the channel=
 '+
>          'over which gdbserver should communicate, e.g. localhost:1234')
> +    parser.addoption('--role', help=3D'U-Boot board role (for Labgrid)')
>      parser.addoption('--no-prompt-wait', default=3DFalse, action=3D'stor=
e_true',
>          help=3D"Assume that U-Boot is ready and don't wait for a prompt")
> =20
> @@ -130,12 +132,33 @@ def get_details(config):
>              str: Build directory
>              str: Source directory
>      """
> -    board_type =3D config.getoption('board_type')
> -    board_identity =3D config.getoption('board_identity')
> +    role =3D config.getoption('role')
>      build_dir =3D config.getoption('build_dir')
> +    if role:
> +        board_identity =3D role
> +        cmd =3D ['u-boot-test-getrole', role, '--configure']
> +        env =3D os.environ.copy()
> +        if build_dir:
> +            env['U_BOOT_BUILD_DIR'] =3D build_dir
> +        proc =3D subprocess.run(cmd, capture_output=3DTrue, encoding=3D'=
utf-8',
> +                              env=3Denv)
> +        if proc.returncode:
> +            raise ValueError(proc.stderr)
> +        print('conftest: lab:', proc.stdout)
> +        vals =3D {}
> +        for line in proc.stdout.splitlines():
> +            item, value =3D line.split(' ', maxsplit=3D1)
> +            k =3D item.split(':')[-1]
> +            vals[k] =3D value
> +        print('conftest: lab info:', vals)
> +        board_type, default_build_dir, source_dir =3D (vals['board'],
> +            vals['build_dir'], vals['source_dir'])
> +    else:
> +        board_type =3D config.getoption('board_type')
> +        board_identity =3D config.getoption('board_identity')
> =20
> -    source_dir =3D os.path.dirname(os.path.dirname(TEST_PY_DIR))
> -    default_build_dir =3D source_dir + '/build-' + board_type
> +        source_dir =3D os.path.dirname(os.path.dirname(TEST_PY_DIR))
> +        default_build_dir =3D source_dir + '/build-' + board_type
>      if not build_dir:
>          build_dir =3D default_build_dir

I'm a little confused here. Why can't we construct "role" from
board_type+board_identity and then we have the board
conf.${board_type}_${board_identity} file set whatever needs setting to
be "labgrid" ?

--=20
Tom

--SlMNhPD1+6CYXl97
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZ5ty8ACgkQFHw5/5Y0
tyxCpAv/Wpg+aiWDnsXDaqm5O6Pyk9JzNLEJUxKJ7BW140jfiYwh8fWbuae4UwLL
+dyu+kS2upHpwdO3kuLfPuDvlonpvgvYVXbSIneVZ7dUC0rX9bw71bfXP2cd3OnJ
U1bZ+eSrLXwhpOSIIdn9iieJIUtdcJMBfoW9P81WI9+P5r+3rzXwTE5s+qVnUp4n
7On5BCWypzAbkQac1LRInZzrchAVwyOTD+aZulz6+UjQgV9l3epdi8jSauchDNuy
tb54Sq+PKOS6Ai4VrbWjZGFpm/t2gQiJDdQ6Aqx3Q3SEpNArvAfx3gJD95mMqwBc
uXEXDY6S9WHxaTW0iXV6Tx/rY5ZjaJQggquNk76+rTe1aGPuWfNVMbmeQByYkhDJ
DbMjv6F32j0d2RUFa1vgch0mSdg2OQG2rrgwL9MRweY4q/HtvVvGA8DAk+ANxsHS
FJ754eSPGOU/FRruLAbn+3tYWfbt4UdCuHHP2PFXz4At2O2bEb2mGzMRKqdnWOda
fjZHCueA
=yf+n
-----END PGP SIGNATURE-----

--SlMNhPD1+6CYXl97--
