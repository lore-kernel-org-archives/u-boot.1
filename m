Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0131DC282DE
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 15:31:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4168A8144F;
	Mon, 10 Mar 2025 16:31:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Qu4E5Cg2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73E7F8164E; Mon, 10 Mar 2025 16:31:03 +0100 (CET)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12A5B811C1
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 16:31:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-300fefb8e06so281989a91.0
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 08:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741620659; x=1742225459; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IuvJ88cFRCdZ+PIJCv5oi7fzQPydKUJBi1QiXl06Gac=;
 b=Qu4E5Cg27xM5WO2iZ0jR0OA/pzEBrC6ECuWSeYjQii3MpPRRKzgQqTp9OiFXsyYMNx
 a9Wh/0Ngx0GgoKPgfSpEuVSlE/CSksmcgRhJ5nlsT3vzgWFhwrpV1mRGcgtiZ8AS2Ak6
 Hx2Ivb+E6LdQ0Sz4jFClCofgTjFKGD1L1o4gE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741620659; x=1742225459;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IuvJ88cFRCdZ+PIJCv5oi7fzQPydKUJBi1QiXl06Gac=;
 b=FaZWshZLfdeSQX2ZwwOm1I+A3ZmFrMDttJ3gMdViZnf/y6NxDQVSDY0W1DMvTgvq0V
 z7LcrmOkPyEdeVCqQ+/LXsL31mH/69lh/4fPK2Y10YeRksPgUYfeEcqH7p/s0bkhAHmo
 DMRfmbu7Ya0+0fuoezsloMOAoMqSHRHHWXhs6KMaKRURiJvIIgR3eRLH+o6pgGoUZjdb
 PKj9oOIPXAp/aC5pYWyESbvtPNXHFFLwL0af2hLpEVjaJ18ec8gZH1ef23Ut4s3h0auV
 UMnELxhgr4/X7LliBG1W4wLbdgmcrcxE+8WhOMeiIU/6mzLzxYKftoUtyfIchZrfRncW
 pJNQ==
X-Gm-Message-State: AOJu0YwQK/7Txv0fD9IfyuLEPsX+W01oortBD6nkzcSGPLkeJgjFsdQz
 uYXh0dYCzjRlDxo8Gab1XTC8jA03uqDiV95STA/Ff/0i2iA5r9bLLcHjd3tptHA=
X-Gm-Gg: ASbGncv+qiiMSqTAxrgAmuXa4SdMubHJIEFzNGtYPR8lpBdMwWtYlqj0ZS+Qs+Kplno
 d+MNerhNkpR28haHKBrWLb5CCQ54MhF+qjoGrDRWJkNMw7gIVdQC+sFPNEptV0cusTyGQ0gyCH+
 ZN/9/HEh7uhrK0+TX0qg/gmrZrifj5DPux8OY74Q1nkj5RXa+9DHLKpd9iZaTV2ZDrUP5xrzlTC
 YUboxh09UIvBwUVnRqOzLnmJuPMT+112Pyxg5/Xknutn1O3YtKHrlnrVCR954e0LV5eJjDmZNa0
 SdgKfmwBKy58dIrFTre/s6dRLwTeBgPovtIUOToaAKz5mg==
X-Google-Smtp-Source: AGHT+IEp1yygeCJiuZ+UiGlsVwTQPfJkBBS6KGRzXXtvMHvN/rnKhLdZ4plCjIQP28fAqPKUOe6BGQ==
X-Received: by 2002:a17:90b:1642:b0:2ff:6f8a:3a12 with SMTP id
 98e67ed59e1d1-300ff369b35mr436994a91.33.1741620659462; 
 Mon, 10 Mar 2025 08:30:59 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff693746b9sm8063505a91.27.2025.03.10.08.30.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 08:30:59 -0700 (PDT)
Date: Mon, 10 Mar 2025 09:30:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Baruch Siach <baruch@tkos.co.il>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nam Cao <namcao@linutronix.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH 12/12] test_fs: Add exfat tests
Message-ID: <20250310153055.GI2640854@bill-the-cat>
References: <20250308201533.1315951-1-marex@denx.de>
 <20250308201533.1315951-13-marex@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1oxrNPEQMZPFttJP"
Content-Disposition: inline
In-Reply-To: <20250308201533.1315951-13-marex@denx.de>
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


--1oxrNPEQMZPFttJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 08, 2025 at 09:12:16PM +0100, Marek Vasut wrote:
> Add tests for the exfat filesystem. These tests are largely an
> extension of the FS_GENERIC tests with the following notable
> exceptions.
>=20
> The filesystem image for exfat tests is generated using combination
> of exfatutils mkfs.exfat and python fattools. The fattols are capable

Did you mean "exfatprogs" and not "exfatutils" ? But we need to update
tools/docker/Dockerfile to list the tool there.

> of generating exfat filesystem images too, but this is not used, the

Presumably because "fattools mkfat" seems to have further external
dependencies and so would be more of a pain to use.

> fattools are only used as a replacement for dosfstools 'mcopy' and
> 'mdir', which are used to insert files and directories into existing
> fatfs images and list existing fatfs images respectively, without the
> need for superuser access to mount such images.
>=20
> The exfat filesystem has no filesystem specific command, there is only
> the generic filesystem command interface, therefore check_ubconfig()
> has to special case exfat and skip check for CONFIG_CMD_EXFAT and
> instead check for CONFIG_FS_EXFAT.
>=20
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Baruch Siach <baruch@tkos.co.il>
> Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Hiago De Franco <hiago.franco@toradex.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Nam Cao <namcao@linutronix.de>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>  test/py/requirements.txt          |  1 +
>  test/py/tests/fs_helper.py        |  8 ++++++--
>  test/py/tests/test_fs/conftest.py | 20 +++++++++++---------
>  test/py/tests/test_fs/test_ext.py | 20 ++++++++++++++------
>  4 files changed, 32 insertions(+), 17 deletions(-)

We also need to update test/py/tests/test_fs/fstest_helpers.py to know
to call fsck.exfat.

[snip]
> @@ -64,6 +66,8 @@ def mk_fs(config, fs_type, size, prefix, src_dir=3DNone=
, size_gran =3D 0x100000):
>                  check_call(f'tune2fs -O ^metadata_csum {fs_img}', shell=
=3DTrue)
>          elif fs_lnxtype =3D=3D 'vfat' and src_dir:
>              check_call(f'mcopy -i {fs_img} -vsmpQ {src_dir}/* ::/', shel=
l=3DTrue)
> +        elif fs_lnxtype =3D=3D 'exfat' and src_dir:
> +            check_call(f'fattools cp {src_dir}/* {fs_img}', shell=3DTrue)
>          return fs_img
>      except CalledProcessError:
>          call(f'rm -f {fs_img}', shell=3DTrue)

A cleanup to use fattools in both cases would be nice, as a follow-up.

Otherwise looks good, thanks!

--=20
Tom

--1oxrNPEQMZPFttJP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfPBaQACgkQFHw5/5Y0
tyxP0gv/Tob0sq4PGy77gLu3/5zrAKoVeiFINfZjvWpzg2hs8LJDYaIqXH1YTKvc
YEoZRrOsZEsz8ZkDt5QRJYazCCzkhIWIK8jQPZzJGYKYRFfMjp2PIpitPIzCIEGU
mv8+wWAK/Pu0lB3nUiKzmuwgaWPLO9u39nEZc8iun7KegCO+eTv/fq+7e9Z7FfXb
8XBULFKlviHaaMYvrf7bUaYfg+i7DfzEudvBjTne4sIo/sB3gJFTnx84rrX59eWJ
cT5UdLmb1r3BpL6JXsChea3w0aHpAZCZdgZQktynkpMpFeT4U8c0wA3eE30fcFyr
KG0ZiaLpR4R6PpBcWrro8Elt1Tt4rse32zIJHVuB+XLs1tjI/2omEp80idNJ/okt
1XnpnP6wMvXGEKgfphPIn1gf6GbqI/syzZwbBbhlzqQP8E7cpBRjGvteP0YjtHoE
8aNsO6lNR+8n66VpBd2MglHyd0uWRgfwlBcqXcpNTUk8Dks5hApM1ltpw2JUsvmV
ooTetYlw
=DoTR
-----END PGP SIGNATURE-----

--1oxrNPEQMZPFttJP--
