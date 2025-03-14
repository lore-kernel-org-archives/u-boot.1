Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A447C282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 14:28:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 285A581D5A;
	Fri, 14 Mar 2025 15:28:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nt6LwIW6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F99D81D5A; Fri, 14 Mar 2025 15:28:01 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F7D781DCC
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 15:27:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7c55500cf80so169277985a.1
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 07:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741962476; x=1742567276; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9J43Ba4zeldc9WIRPpX45Em5Q4tide2Qe/CKm/roKyg=;
 b=nt6LwIW6sW4qoFY7Oj4xxwRXjl8w5P5CaPBxxm8Ums9bjDG7u1a4JZhcoUKZ+pDlQu
 HuGhYIEzrtZmTuZbB8LCdm3bhfE0X5U46Tv9jQOyow5TWE/KNUKd/8tIgsIklCc2fSsW
 GtgBlKROF4oTVJRezZHiApXPXmwNuYcjOYZVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741962476; x=1742567276;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9J43Ba4zeldc9WIRPpX45Em5Q4tide2Qe/CKm/roKyg=;
 b=k6FC+CK2Krja57++MfdHKXOcJAcCrBX0rZ7D5VoYcOrAz3Py/C8znnHql0rb+tO/bJ
 IJ0s92vAttdMq2WiSO6wckBX7kjCn+NssWRyJFoc5DffUjTGqbtVnvVC3Yp9CQtL9mPt
 PYVMjBVRITn+0DRc5rHS1AerfJRTgk6Enc95JxZNGVmapGE3B2HLVCZRNFlVp/hZgPqC
 ni3ASfHRTtQVdWlxLrg2DXGt6ZGr394Chnrso41vVpo7Lh80LT03Wlwnyq7WZ+VUhxO6
 y+5tIE+exHUlpnU62hRk+mrw8J+k9urB7vLovEo2mt2bBiQ5h+BLFZzQKPknEhZ9zPnr
 B9OQ==
X-Gm-Message-State: AOJu0YxVCoDkUKEKU0NPH0WAEY648pcrRXk+bb/Z2GcOM2wjI0p0TcRH
 50eoXgufPBn/IY+F01lMnPorJccvfTS/OZp7NlzHj2E3T84nCcEmP4BicFFZAAo=
X-Gm-Gg: ASbGncttesQl6Gt1FZtTkrg68oSQqT4AUXNV7Et6uD1SHQEipFVXrlBjjhABine+dvK
 lgswKVjfXYnXm0OQUEEeaaj0byRsRw8GTfWduh+eLRGe847DvKDX8ASWD9BiJFUJ/wv6wfg5nDb
 d664oZ1uz+D3ff4R5D8kgHyewLauNWMcaAtIt9iBZvaSfwPzL1n1x5iX5iaTeg9CO6TIyCdCOHi
 C4edipBga2F+Pm1IN6FdxY3bqL3aid5+Qcj3dvsMozE7GzZe+OGmFnMmMdVvPpbcYTAolm6iS8y
 BN5kvwx1tax+zjjEdwm9hG6pKK39NPdomPyBxyZg11I1Eg==
X-Google-Smtp-Source: AGHT+IEJOSKJJ5fyfBiHLyHPr8JFOVSJeAoDp1M2tHdfNow0g+HFCYfcqlf/SVyUjB4ErAIxxWKpNg==
X-Received: by 2002:a05:620a:8903:b0:7c5:4463:29a7 with SMTP id
 af79cd13be357-7c57c90a73amr409452585a.37.1741962476487; 
 Fri, 14 Mar 2025 07:27:56 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c573da455dsm257935285a.115.2025.03.14.07.27.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 07:27:56 -0700 (PDT)
Date: Fri, 14 Mar 2025 08:27:52 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Baruch Siach <baruch@tkos.co.il>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nam Cao <namcao@linutronix.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH v2 11/11] test_fs: Add exfat tests
Message-ID: <20250314142752.GN2640854@bill-the-cat>
References: <20250313191348.170054-1-marex@denx.de>
 <20250313191348.170054-12-marex@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tt/mjFejjPTcmxyu"
Content-Disposition: inline
In-Reply-To: <20250313191348.170054-12-marex@denx.de>
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


--tt/mjFejjPTcmxyu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 08:13:27PM +0100, Marek Vasut wrote:

> Add tests for the exfat filesystem. These tests are largely an
> extension of the FS_GENERIC tests with the following notable
> exceptions.
>=20
> The filesystem image for exfat tests is generated using combination
> of exfatprogs mkfs.exfat and python fattools. The fattols are capable
> of generating exfat filesystem images too, but this is not used, the
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
[snip]
> diff --git a/test/py/tests/test_fs/fstest_helpers.py b/test/py/tests/test=
_fs/fstest_helpers.py
> index c1447b4d43e..8f2e1fcf47d 100644
> --- a/test/py/tests/test_fs/fstest_helpers.py
> +++ b/test/py/tests/test_fs/fstest_helpers.py
> @@ -9,6 +9,8 @@ def assert_fs_integrity(fs_type, fs_img):
>      try:
>          if fs_type =3D=3D 'ext4':
>              check_call('fsck.ext4 -n -f %s' % fs_img, shell=3DTrue)
> +        if fs_type =3D=3D 'exfat':
> +            check_call('fsck.exfat -n %s' % fs_img, shell=3DTrue)
>          elif fs_type in ['fat12', 'fat16', 'fat32']:
>              check_call('fsck.fat -n %s' % fs_img, shell=3DTrue)
>      except CalledProcessError:

This should be elif not if? Not a big deal if there's nothing else
needing a v3 however. Everything else looks good, thanks.

--=20
Tom

--tt/mjFejjPTcmxyu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfUPOgACgkQFHw5/5Y0
tyzLfQwAo6StUiCdflYbcheJw9GcamHas2hX0Js3uf3LFp2GW4bFtfoG99J+ruya
W+JKZcuhGt4ufeOcnX3MyfQ/kfOwrYMPMhkpznysWtwrYOyFYXpPfllVCepLB9sK
aykTBG/+kUSnN66rbw6C+XPWEfTLCKpTK2cEQY28L8dYOmyj5jC3YgCT0Oq6itJ1
WJWrngB0fKH4pfm3aw1ULp1WaUF0K8UjLAzhAwrbdLvhtYUnLLRR8x2W2lvtiUq/
gksepGWrWrQ7VFNiEcRLkz3+dkb6k0vxVVvmRSXEpmkbSqLJzrFWcXUZcw4k3Odq
uVYUip/QIfcgvVt7woJG9kH3DWkJaRZFM+HblNvv8hneVadMBdcJxOtKSRw0jMxI
/jzPrUt7Vv430O+rvwQSU3JO5TzcSgvd2DxYiqzfI3sfsXUKcGa2ufcIvnxVZ/sY
EJ3jbo2wGztjzLFv//tU2PbXrqMYtUZPCUld3N5sChBQvSiiNUMmo6Sk1uZdi+8F
wYyLapva
=s0O0
-----END PGP SIGNATURE-----

--tt/mjFejjPTcmxyu--
