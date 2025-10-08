Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E65CCA470
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 14:50:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC63A839DE;
	Wed,  8 Oct 2025 16:50:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GDAN6ZYf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFE5983FBF; Wed,  8 Oct 2025 16:50:23 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C49A9839DD
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 16:50:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-30cce5be7d0so2555416fac.0
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 07:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759935020; x=1760539820; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=b+WsdDZ3FqeBs/1XsWHTZ3GrDu4GnzUVm3yxWU1NKtc=;
 b=GDAN6ZYf9ScgTLqsLuM6rrqKLfhUh2tA9JAbEkyDOA1Qu0EWTvRKidXtm8K0gUh3fH
 RFZDIjG/RIwmYas7KlBYrojKT0iqG91MLM5rZ3PAZ2L3P01g5xdNY51ZdwvHSyQSaPZz
 iZmzH/Tz1RDe/FHvJLfTkZlIPoCOicyi/+54s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759935020; x=1760539820;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b+WsdDZ3FqeBs/1XsWHTZ3GrDu4GnzUVm3yxWU1NKtc=;
 b=L/5DacB7KqUo2Y8YjC8UZOU5qgnXXMgu1bfQM2+Nq6ZCDdoS4n3Dv5b7iIMOqXK99i
 FMTDBZtmyLQBc4Y49paZKnso7SyKhq4QclnWglHrK/ZYWDEO+QiK5UwI9BoK+mIqU4AU
 LL9R13swnOEXLyFqCHmHaQUSbicGeGce5RzkfJAO01eETqTVeENgFDSzOJktsFsjBSiH
 PA/4C7eH3JDPBWYCkd09N67IXMTxYq0h06XHmx0wFVI8T3axY5flF3Jb7AVlwV2BIAkn
 cUqJk+zf1V0y26erJiCaXR0gW/DcOOZEUyOP3ZgeQhLxRfjqZwPX2maSpizbxHO3HU11
 lI4Q==
X-Gm-Message-State: AOJu0Yx/bhWzJJl+Nis/SVW7Iagby6TzafxDafZAkyDxKj2m8lez7HN5
 8F7XiY41udmtBjrkMksCdsWWzABcS6XoYtIKQaUkSmgYJTylFs9HekohjXzkoG0wBS6Z5kb57sA
 eVZVaKIo=
X-Gm-Gg: ASbGnctlSjDsI7kKaFlEckPV3FG9oLWuvf8zlpb1y6F1HJ8ehk1BB13NVpcAXOCs2U2
 0RQEu9czJXMR69YfzSNTL8/kDfI+8nOCKTjDdH9ze+hr85fxwULctdatAm0l3PWW1XAeAnfjJL0
 dO3MZVgQAmGPaA4XvJ4FstYV1NhYOQ1qh5/oxkHA66/tYme9SYn4QNruHVkUilyqY6zjUEcW5OF
 BFXWW0FyC7wrD2jEEBjoKdLneung4DMaxsdTIGXeDS+HyGAJTKj4ajNXhE67OfNkq34d4+xZHZc
 IHomTbIyANaSzhTmzhr5haM5Rh+WA6Q7i6pcKR7Bm0dK/cKgv5hDihBy8rBIolau20xcs6RJ3vr
 dVBSluLpNPyRdS0APgQ0oYZ5nAQl8eRnITPNvzC4Nmcfqpn9tYkKHwXU5tiw57TK/B34AL+C9R7
 6lSZHv2XMtkw==
X-Google-Smtp-Source: AGHT+IF7LpskNs1FPNeHXYaom69hffVtKEUcWIOjut4eMVlyQIXVnBGk4HnV2UcarbM8Z8PnYnp4gA==
X-Received: by 2002:a05:6870:e307:b0:31d:66fd:298d with SMTP id
 586e51a60fabf-3c0f6d1ff02mr1983637fac.23.1759935020485; 
 Wed, 08 Oct 2025 07:50:20 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ab8e008857sm6142909fac.16.2025.10.08.07.50.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 07:50:19 -0700 (PDT)
Date: Wed, 8 Oct 2025 08:50:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Martin Schwan <m.schwan@phytec.de>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Andreas Pretzsch <apr@cn-eng.de>, upstream@lists.phytec.de
Subject: Re: [PATCH] test: boot: Add test for bootmeth_rauc
Message-ID: <20251008145017.GV298503@bill-the-cat>
References: <20251008-wip-bootmeth-rauc-tests-v1-1-3da21a731524@phytec.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lfc2xLA0JFtmCjQ9"
Content-Disposition: inline
In-Reply-To: <20251008-wip-bootmeth-rauc-tests-v1-1-3da21a731524@phytec.de>
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


--lfc2xLA0JFtmCjQ9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 08, 2025 at 08:57:30AM +0200, Martin Schwan wrote:

> Add a simple unit test for testing the RAUC bootmethod. Provide only the
> very basic tests for now, running a scan and list, to verify correct
> detection of the RAUC bootmethod. More advanced boot tests of this
> bootmethod can be added in a separate patch.
>=20
> This requires another mmc image (mmc9) to contain the following
> partitions:
>=20
> 1. boot A: contains a dummy boot.scr
> 2. root A: contains an empty root filesystem
> 3. boot B: contains a dummy boot.scr
> 4. root B: contains an empty root filesystem
>=20
> The bootmeth_rauc scans all four partitions for existence and expects a
> boot script in each boot partition.
>=20
> Also add BOOTMETH_RAUC as a dependency on sandbox so that we can test
> this with:
>=20
> $ ./test/py/test.py -B sandbox --build -k test_ut # build the mmc9.img
> $ ./test/py/test.py -B sandbox --build -k bootflow_rauc
>=20
> Signed-off-by: Martin Schwan <m.schwan@phytec.de>

I'm glad to see the tests. A question:

[snip]
> +    # Generate boot script
> +    script =3D '# dummy boot script'
> +    bootdir =3D os.path.join(mnt, 'boot')
> +    utils.run_and_log(ubman, f'mkdir -p {bootdir}')
> +    cmd_fname =3D os.path.join(bootdir, 'boot.cmd')
> +    scr_fname =3D os.path.join(bootdir, 'boot.scr')
> +    with open(cmd_fname, 'w', encoding=3D'ascii') as outf:
> +        print(script, file=3Doutf)
> +
> +    mkimage =3D os.path.join(ubman.config.build_dir, 'tools/mkimage')
> +    utils.run_and_log(
> +        ubman, f'{mkimage} -C none -A arm -T script -d {cmd_fname} {scr_=
fname}')
> +
> +    # Create boot filesystem image with boot script in it and copy to di=
sk image
> +    fsfile =3D 'rauc_boot.img'
> +    utils.run_and_log(ubman, f'fallocate -l 8M {fsfile}')
> +    utils.run_and_log(ubman, f'mkfs.vfat {fsfile}')
> +    utils.run_and_log(ubman, ['sh', '-c', f'mcopy -vs -i {fsfile} {scr_f=
name} ::/'])
> +    utils.run_and_log(ubman, f'dd if=3D{fsfile} of=3Dmmc{mmc_dev}.img bs=
=3D1M seek=3D1 conv=3Dnotrunc')
> +    utils.run_and_log(ubman, f'dd if=3D{fsfile} of=3Dmmc{mmc_dev}.img bs=
=3D1M seek=3D19 conv=3Dnotrunc')
> +    utils.run_and_log(ubman, f'rm -f {fsfile} {cmd_fname} {scr_fname}')
> +
> +    # Create empty root filesystem image and copy to disk image
> +    fsfile =3D 'rauc_root.img'
> +    utils.run_and_log(ubman, f'fallocate -l 10M {fsfile}')
> +    utils.run_and_log(ubman, f'mkfs.vfat {fsfile}')
> +    utils.run_and_log(ubman, f'dd if=3D{fsfile} of=3Dmmc{mmc_dev}.img bs=
=3D1M seek=3D9 conv=3Dnotrunc')
> +    utils.run_and_log(ubman, f'dd if=3D{fsfile} of=3Dmmc{mmc_dev}.img bs=
=3D1M seek=3D27 conv=3Dnotrunc')
> +    utils.run_and_log(ubman, f'rm -f {fsfile}')

Can we use mk_fs from test/py/tests/fs_helper.py for this part? I know
we can't use setup_image without further changes to allow for 'spec' to
be passed (which may or may not be worth doing, I'm not sure) but I
think we can use mk_fs here? Thanks.

--=20
Tom

--lfc2xLA0JFtmCjQ9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOZ6JQAKCRAr4qD1Cr/k
CtEoAP0fynvzDuJy5UjZE4Fx3dPj2veO6jGodzUv0XTDQS/KlQEA4MkRNN4zhlIr
9GRwEODQ8aAPKDSQBjUHPpLZq4pLYAM=
=j58s
-----END PGP SIGNATURE-----

--lfc2xLA0JFtmCjQ9--
