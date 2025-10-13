Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE713CCD183
	for <u-boot@archiver.kernel.org>; Mon, 13 Oct 2025 21:08:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E6DB83710;
	Mon, 13 Oct 2025 23:08:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FRQvPv1E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4717838D7; Mon, 13 Oct 2025 23:08:43 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01B03836F0
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 23:08:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-36c9859b036so2981472fac.0
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 14:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760389720; x=1760994520; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IStlbUPncs5alORQ0XtvSVvkbUg85ZJGPwbbog4YKfQ=;
 b=FRQvPv1EUVVzQzbpzJvgGtKniBfzXZ7OzI9SiMgkYVP1JqlwAirztzsNSOrCJyHZYv
 EY5e8fOxyoR5mW6oiW0COeum91nEzLrkFNrgPeugAorrPRfMGet6rDoLSyFSuQu2LO5f
 vSQBTuoW2xaZOLR4RMK+qSShuRMlYF4Nhy1nk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760389720; x=1760994520;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IStlbUPncs5alORQ0XtvSVvkbUg85ZJGPwbbog4YKfQ=;
 b=iGeIZ09OD/sHCvL/2Tr4jkNXZH9RycJ79h4dmcJuCFJ1xx/i+hhBiGoDRZHxXRXvt/
 F5MA+FQx7ggMD08J37HKX6xF5Q+r4O5R3gTOwBjrG6xskxxqGUtmt+hylXDBHbPyAsPY
 Po7RdFJ4N8bvzQ2p+3lU6j5vKVLztlsUGJWtDezgeDj49khPp3sMXKj3ixENlzVg4FbJ
 Q2b9PGxRbU1uU8r6LTDYmUt5oTB3Gfc3+zp7efsb0x4z1jfFqq4AMXSxeuUG8Eef8W0H
 AxZOj1S2LfoN8rhsc01O9N12okzyhSa/WoHkXWWWHM4Ue5eI93Rs2Q4aKuYHp28F0M2B
 XzSQ==
X-Gm-Message-State: AOJu0YzUL3RoETWB2JUUOPJtTaRdu2bEelJnKChQLwkWenEdsSylrLjH
 8R04eTCMqM+FLWu2az8PSXdwjNWKA2W66I/X2YLwaLjiGY6cKSC9dMKUFm99ggonQKM=
X-Gm-Gg: ASbGnctBEn91vhyk/PAHCmR/JrOnuZcm40hD+oT9MM2Y8W+f/lQ50Zt7+GBYGNN0GCb
 kT5CfvYw+hTGzaDBA3FI7J/DMVjhePD6PvWMtC86hHILnyzstj0IQ2y2CnVKsBs5C/alH7bOu35
 wdqjDdyrewcsDPfyIo4uamfo5OfS14zz4T5Os2Bp/+dxrDA3Na0Tb8lIikDFPOYBMBEFmhFZ9s+
 /xT5/i8crkVtrVxUG+BjMhwS4APMzKnhc5wEi4z6XLeRLs5aq5AJZSOw67na12C+6q5FXAGBIR4
 Uw+KJRMLDsLUMAinLb6cemD/5lqf7HSZ14Ky9X9MkDn74m3Hc1MpkhGBvx0zGdgU8vn0VAgU+Rw
 apehYet1nowTWTY0llsEIdH9oOw/nV2+OJhpW9FzO2j3wL8Sv123HYN2kwrtqxSJk+U0HnUajmr
 S2Ioh50gXuOyAjlRQ=
X-Google-Smtp-Source: AGHT+IEOBhhlZ6DcXu5VjGWMpJQcqwh+d/vveQSiPFby381W+PcvfhZQDgNaVFQ1N/msQHw0keBCsw==
X-Received: by 2002:a05:6871:207:b0:315:8d77:4a22 with SMTP id
 586e51a60fabf-3be6eb3b65amr11882138fac.23.1760389719672; 
 Mon, 13 Oct 2025 14:08:39 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3c8c8f67c7csm3828813fac.27.2025.10.13.14.08.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Oct 2025 14:08:38 -0700 (PDT)
Date: Mon, 13 Oct 2025 15:08:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Martin Schwan <m.schwan@phytec.de>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Andreas Pretzsch <apr@cn-eng.de>, upstream@lists.phytec.de
Subject: Re: [PATCH v2] test: boot: Add test for bootmeth_rauc
Message-ID: <20251013210836.GL6113@bill-the-cat>
References: <20251009-wip-bootmeth-rauc-tests-v2-1-08fbd3738e0a@phytec.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IlfhejPxQYu81Aoq"
Content-Disposition: inline
In-Reply-To: <20251009-wip-bootmeth-rauc-tests-v2-1-08fbd3738e0a@phytec.de>
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


--IlfhejPxQYu81Aoq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 09, 2025 at 09:06:12AM +0200, Martin Schwan wrote:

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
> ---
> Changes in v2:
> - Use mk_fs() instead of calling fallocate/mkfs/mcopy individually for
>   the boot and root partitions in mmc9.img
> - Link to v1: https://lore.kernel.org/r/20251008-wip-bootmeth-rauc-tests-=
v1-1-3da21a731524@phytec.de
> ---
>  arch/sandbox/dts/test.dts |  8 +++++++
>  configs/sandbox_defconfig |  1 +
>  test/boot/bootflow.c      | 57 +++++++++++++++++++++++++++++++++++++++++=
++++++
>  test/py/tests/test_ut.py  | 44 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 110 insertions(+)

This doesn't work now:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D FAILURES =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
___________________________ test_ut_dm_init_bootstd _______________________=
_____
test/py/tests/test_ut.py:604: in test_ut_dm_init_bootstd
    setup_rauc_image(ubman)
test/py/tests/test_ut.py:581: in setup_rauc_image
    fs_helper.mk_fs(ubman.config, fs, 0x800000, fsfile.split('.')[0], bootd=
ir)
test/py/tests/fs_helper.py:68: in mk_fs
    check_call(f'mcopy -i {fs_img} -vsmpQ {src_dir}/* ::/', shell=3DTrue)
/usr/lib/python3.10/subprocess.py:369: in check_call
    raise CalledProcessError(retcode, cmd)
E   subprocess.CalledProcessError: Command 'mcopy -i /tmp/sandbox/persisten=
t-data/rauc_boot.fat32.img -vsmpQ /tmp/sandbox/persistent-data/boot/* ::/' =
returned non-zero exit status 1.
----------------------------- Captured stdout call ------------------------=
-----

--=20
Tom

--IlfhejPxQYu81Aoq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaO1qUQAKCRAr4qD1Cr/k
CsZVAP9eXOlSn+rNunLorMFwJhTJnEE3G6ERYbPob8JuEXluJAD+JH1XWGjgG6oN
/thv6KwBWf2kUIVs856WyDONHM/h4gM=
=kIo2
-----END PGP SIGNATURE-----

--IlfhejPxQYu81Aoq--
