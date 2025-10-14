Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0EF8CCD192
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 14:17:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E600A8312A;
	Tue, 14 Oct 2025 16:17:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KeSKD/eQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 723CB8313B; Tue, 14 Oct 2025 16:17:14 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D49F6809A5
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 16:17:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-650304a822aso589287eaf.3
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 07:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760451430; x=1761056230; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=n5KYIfnnlQYM/tcnXlnB77qJHeyxLhGHtGCPhOt9uWU=;
 b=KeSKD/eQYxw/axbR9E4Q6VbMDekRdpTf3yaakBR0rxgVf5H8qOJVRMSoMjwlHzXO6b
 +dKzAiiptboBDlzAMp1t0k5d2feISRxxy/rK9AyI8rlGoZ/fDM8kxksbl8+qWt6XckNH
 Klqjny372CvJ0EFlGOai2Iw1/COW8s0jhCN30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760451430; x=1761056230;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n5KYIfnnlQYM/tcnXlnB77qJHeyxLhGHtGCPhOt9uWU=;
 b=B2NTW51pz0g83NVfzrPXDdUGgjfoE3lmR9SqnUmth+RhVWUEuVwDpzfF+2uJLnOWSZ
 10mopaYH+275nslcOw9XfBfWQzWk4iConX1ILlcOwIu4pDcL/BY2Q7gzUdQrDxs1ucFB
 lmlcQVTa0jLxPZaMzPnSB5lNxKuttoTfZghFajv+u2pVZXo9NbZdjbdu+ZnoFujg+0PS
 xn+H1HG1nH3iQRtKqbbmbCSoNpUUpJEs+PAWOIrr6Go7xEkdXrrhn2vqdUtvN4YafLx0
 fBVTG/SrPspkArRhCouU/uokWjDG+TgaANWTm00Sgt1BMIyseHxDDUzcWGCdCpH8SYVD
 2CMQ==
X-Gm-Message-State: AOJu0YztRG6rkGPM89bbh74hz9YArW/fvFeiCm1QUNZiDfxzKBT2lSXz
 /Y9oaAFEbznCbqa/rRnAfFeadiOLgsk8XFjQiNU8bKwzzeWytfneKlDvN4nGcgCayqs=
X-Gm-Gg: ASbGncvmOHMBvUIkaJkNXXHuqyDURxru4zBVbtKltnGwkw4KT7c3NEtjWfXbnTfgNXF
 C99IdfDhOcVfwXurYYi38uTMFXOIHiNuIA9TOFk24qrFKnDr25xT4M5Y1eiEtt9iPjTVvDpEbri
 EIaUDOqiLpXQuL4rjSDMVnACJOaa42hmZkiwIr3uB0OqBw7yoCnmQUOoTD5L9Fxuvx4vjQsQyT5
 aJ5E6F9YfjzMmBswJPIeSaQvNz9F384u6vyf/hUrwMvQdnghVBRqvgzkHSns9hCW2PDUjZiF+N+
 RroOQZbFR9uEmAJ4XePkgyAxOhKuKO2Ohe0UDugo+TOCq4zetkLaHIOpKTLpAI5c5UBfASDZBMe
 6rC5y8HpJ9FpiroDwZuR4KbrnA+htpWklrTGjRZBQ49IRvr2IAUbXZZs8QGiBFhXKxsM2UN4ozB
 /3f+Hd97Q7Nc+FPiE=
X-Google-Smtp-Source: AGHT+IHxYJrYYrqcmHO5mofHlD1g6Y8L0p57/2rTdNGnSI/iJBzo4ApxlbHgABZSL4jgIeyV4MYq7A==
X-Received: by 2002:a05:6808:e8b:b0:43b:977d:cc91 with SMTP id
 5614622812f47-4417b33fd35mr9138526b6e.3.1760451428572; 
 Tue, 14 Oct 2025 07:17:08 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4419894eb7bsm3284411b6e.19.2025.10.14.07.17.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 07:17:07 -0700 (PDT)
Date: Tue, 14 Oct 2025 08:17:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Martin Schwan <M.Schwan@phytec.de>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Simon Glass <sjg@chromium.org>, Andreas Pretzsch <apr@cn-eng.de>,
 "upstream@lists.phytec.de" <upstream@lists.phytec.de>
Subject: Re: [PATCH v2] test: boot: Add test for bootmeth_rauc
Message-ID: <20251014141705.GM6113@bill-the-cat>
References: <20251009-wip-bootmeth-rauc-tests-v2-1-08fbd3738e0a@phytec.de>
 <20251013210836.GL6113@bill-the-cat>
 <161597811da9f312d986c3e44f34f6a8c66c23f8.camel@phytec.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+gn8f7DLLzVYkkE0"
Content-Disposition: inline
In-Reply-To: <161597811da9f312d986c3e44f34f6a8c66c23f8.camel@phytec.de>
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


--+gn8f7DLLzVYkkE0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 08:31:12AM +0000, Martin Schwan wrote:
> Hi Tom,
>=20
> On Mon, 2025-10-13 at 15:08 -0600, Tom Rini wrote:
> > On Thu, Oct 09, 2025 at 09:06:12AM +0200, Martin Schwan wrote:
> >=20
> > > Add a simple unit test for testing the RAUC bootmethod. Provide
> > > only the
> > > very basic tests for now, running a scan and list, to verify
> > > correct
> > > detection of the RAUC bootmethod. More advanced boot tests of this
> > > bootmethod can be added in a separate patch.
> > >=20
> > > This requires another mmc image (mmc9) to contain the following
> > > partitions:
> > >=20
> > > 1. boot A: contains a dummy boot.scr
> > > 2. root A: contains an empty root filesystem
> > > 3. boot B: contains a dummy boot.scr
> > > 4. root B: contains an empty root filesystem
> > >=20
> > > The bootmeth_rauc scans all four partitions for existence and
> > > expects a
> > > boot script in each boot partition.
> > >=20
> > > Also add BOOTMETH_RAUC as a dependency on sandbox so that we can
> > > test
> > > this with:
> > >=20
> > > $ ./test/py/test.py -B sandbox --build -k test_ut # build the
> > > mmc9.img
> > > $ ./test/py/test.py -B sandbox --build -k bootflow_rauc
> > >=20
> > > Signed-off-by: Martin Schwan <m.schwan@phytec.de>
> > > ---
> > > Changes in v2:
> > > - Use mk_fs() instead of calling fallocate/mkfs/mcopy individually
> > > for
> > > =A0 the boot and root partitions in mmc9.img
> > > - Link to v1:
> > > https://lore.kernel.org/r/20251008-wip-bootmeth-rauc-tests-v1-1-3da21=
a731524@phytec.de
> > > ---
> > > =A0arch/sandbox/dts/test.dts |=A0 8 +++++++
> > > =A0configs/sandbox_defconfig |=A0 1 +
> > > =A0test/boot/bootflow.c=A0=A0=A0=A0=A0 | 57
> > > +++++++++++++++++++++++++++++++++++++++++++++++
> > > =A0test/py/tests/test_ut.py=A0 | 44
> > > ++++++++++++++++++++++++++++++++++++
> > > =A04 files changed, 110 insertions(+)
> >=20
> > This doesn't work now:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D FAILURES
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > ___________________________ test_ut_dm_init_bootstd
> > ____________________________
> > test/py/tests/test_ut.py:604: in test_ut_dm_init_bootstd
> > =A0=A0=A0 setup_rauc_image(ubman)
> > test/py/tests/test_ut.py:581: in setup_rauc_image
> > =A0=A0=A0 fs_helper.mk_fs(ubman.config, fs, 0x800000, fsfile.split('.')=
[0],
> > bootdir)
> > test/py/tests/fs_helper.py:68: in mk_fs
> > =A0=A0=A0 check_call(f'mcopy -i {fs_img} -vsmpQ {src_dir}/* ::/',
> > shell=3DTrue)
> > /usr/lib/python3.10/subprocess.py:369: in check_call
> > =A0=A0=A0 raise CalledProcessError(retcode, cmd)
> > E=A0=A0 subprocess.CalledProcessError: Command 'mcopy -i
> > /tmp/sandbox/persistent-data/rauc_boot.fat32.img -vsmpQ
> > /tmp/sandbox/persistent-data/boot/* ::/' returned non-zero exit
> > status 1.
> > ----------------------------- Captured stdout call ------------------
> > -----------
>=20
> That's strange. I cannot reproduce this error on my local machine
> (Archlinux), neither with Python 3.13 nor 3.10. Do you have additional
> output of the process call? Or is the captured stdout empty? Maybe
> there is something in stderr? The exit code 1 seems rather generic. At
> least I see all the required files on my machine for that call.

It's what's seen in CI. One of the full failures is at
https://source.denx.de/u-boot/u-boot/-/jobs/1264772 and you can trigger
CI runs as documented at:
https://docs.u-boot.org/en/latest/develop/ci_testing.html or grab the CI
docker container and run the tests locally inside of that. Thanks.

--=20
Tom

--+gn8f7DLLzVYkkE0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaO5bXgAKCRAr4qD1Cr/k
Cg4BAP9ovVGZkZMlWNR+2imsBNXJ0XUnL2BK3me2YqTRV2Kj8AD8DVH/RJMp8loj
ST24BE77FqYxv5j2lEqBBsbfd2PZtQo=
=Tv0o
-----END PGP SIGNATURE-----

--+gn8f7DLLzVYkkE0--
