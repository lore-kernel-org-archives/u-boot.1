Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41FE9C19F32
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 18:06:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7047481273;
	Thu, 27 Feb 2025 19:06:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ay+WaUz6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28C888129B; Thu, 27 Feb 2025 19:06:34 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 940C581253
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 19:06:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-220e83d65e5so24311335ad.1
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 10:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740679587; x=1741284387; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xTkQ7Vu2wL5v9HL/xSMdZzvY4xifbykcH0AMRxEkTLs=;
 b=ay+WaUz6SWGY79ys0oiQokGE7Y9Pf+hBwd6vkWGLSdO025B9QijVCxoeCp9dbHtKPl
 ToKDJ+xRMq+zFdN2r+3owHTznKawKw2YusjII/WpUh1E7ud3q6prnhUTQ7R91zE+3tNk
 9KZDij7wtDRr/6Hp6+oUmu/WiL8nHL6UloKa8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740679587; x=1741284387;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xTkQ7Vu2wL5v9HL/xSMdZzvY4xifbykcH0AMRxEkTLs=;
 b=hX8txn/KKvLu87stnRd6lckSAdzXv5yaa3NKpCmPFjBITCt0sQ2mgnwtDzVZY9ckXG
 lvGKLvTz8zdsRN3yowpCJmMGe5kadVfeeVLuo3AJIRNewHG/N4PxZ+S+eAnPedin6mdd
 Qj2eMvEsBVtvbmSrU+KtarJS/8sT0eS3ZsWCkRDfBU8Jdl9DnNkalj3EGbmIdb+p900W
 8lg2w+k2RMEk6mQ2zJh1laBmd6d/YfVTCuylGEQQFE4gEjlUjhhmb9Ib+fckRi8tDcKP
 +Z0/FNEOscUXWVhjOV9MSav3HyCCj0XlVGtaOoEHukLWW53CzN7iVJQXDKyMzAZimdMV
 qIMg==
X-Gm-Message-State: AOJu0YxiO4GpoInIEZgILvBHOa2i1AWPQS50+PMjgwxCIZyMNdks2otg
 MGthm7h+JiHcAMFt27Q2jJB/hH+Lka/3oppZBD+4kInhjF7R9KQk927YFIqzRX5GhbIlwClUofm
 k2xE=
X-Gm-Gg: ASbGncseRfN5oL04gXTvdosY5pnLpwBddE4i5PpdjOVC1uaLSaPijv28zX1fjS72MG5
 UtU4bvOYwBImthsjPClvpuBOKAq8ib3jn0PVM5Uj/obDiCD7wso/H466a8kf+/ipd9rApyx4pkG
 pCzYjKADpNDCPVzXuMxW0OdnTanh9nQNCXQnR7T08ttSijZJMLFQ2O8KFNte+RdijuM4Dcb1u4B
 Z+DadHX93QJ+MvLNhyE4HTgni8lrFe0qkAldYFG1yMv4r27+DIst0joOGULAlvKv7i4FSOAOzB0
 VKCeIFz/qYczrxfNx++MgsSV
X-Google-Smtp-Source: AGHT+IEzhIpJxcLEc/2fNAlQHSTzCwYHbXwBYhEP2EAqlH6A+domMz108hwcIcCEjPhX/iXtCgdPiA==
X-Received: by 2002:a17:902:e844:b0:220:c2a8:6fbc with SMTP id
 d9443c01a7336-2236924e46amr1135865ad.34.1740679586936; 
 Thu, 27 Feb 2025 10:06:26 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2235050d7c1sm18046535ad.198.2025.02.27.10.06.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 10:06:25 -0800 (PST)
Date: Thu, 27 Feb 2025 12:06:23 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 0/5] net: lwip: root certificates
Message-ID: <20250227180623.GI2640854@bill-the-cat>
References: <cover.1740672437.git.jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tJZI/VJJ48VHkjZs"
Content-Disposition: inline
In-Reply-To: <cover.1740672437.git.jerome.forissier@linaro.org>
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


--tJZI/VJJ48VHkjZs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 05:09:00PM +0100, Jerome Forissier wrote:

> This series adds support for HTTP server authentication using root (CA)
> certificates.
>=20
> As a first step, the wget command is extended to support a sub-command:
> cacert <addr> <size>. The memory region shall contain the CA
> certificates. With this, it is possible to load the certificates from
> storage or get them from the network for example, which is convenient
> for testing at least. The Kconfig symbol for this feature is
> WGET_CACERT=3Dy.
>=20
> Then new Kconfig symbols are added to support providing the certificates
> at build time, as a DER or PEM encoded X509 collection:
> WGET_BUILTIN_CACERT=3Dy and WGET_BUILTIN_CACERT_PATH=3D<some path>.
> Note that PEM support requires MBEDTLS_LIB_X509_PEM=3Dy (for the cacert
> command as well as for the builtin way).
>=20
> Here is a complete example (showing only the relevant output from the
> various commands):
>=20
>  make qemu_arm64_lwip_defconfig
>  wget https://curl.se/ca/cacert.pem
>  echo CONFIG_WGET_BUILTIN_CACERT=3Dy >>.config
>  echo CONFIG_WGET_BUILTIN_CACERT_PATH=3Dcacert.pem >>.config
>  make olddefconfig
>  make -j$(nproc) CROSS_COMPILE=3D"ccache aarch64-linux-gnu-"
>  qemu-system-aarch64 -M virt -nographic -cpu max \
>         -object rng-random,id=3Drng0,filename=3D/dev/urandom \
>         -device virtio-rng-pci,rng=3Drng0 -bios u-boot.bin
>  =3D> dhcp
>  # HTTPS transfer using the builtin CA certificates
>  =3D> wget https://www.google.com/
>  18724 bytes transferred in 15 ms (1.2 MiB/s)
>  # Disable certificate validation
>  =3D> wget cacert 0 0
>  # Unsafe HTTPS transfer
>  =3D> wget https://www.google.com/
>  WARNING: no CA certificates, HTTPS connections not authenticated
>  16570 bytes transferred in 15 ms (1.1 MiB/s)
>  # Dowload and apply CA certificates from the net
>  =3D> wget https://curl.se/ca/cacert.pem
>  WARNING: no CA certificates, HTTPS connections not authenticated
>  ##
>  233263 bytes transferred in 61 ms (3.6 MiB/s)
>  =3D> wget cacert $fileaddr $filesize
>  # Now HTTPS is authenticated against the new CA
>  =3D> wget https://www.google.com/
>  18743 bytes transferred in 14 ms (1.3 MiB/s)
>  # Drop the certificates again...
>  =3D> wget cacert 0 0
>  # Check that transfer is not secure
>  =3D> wget https://www.google.com/
>  WARNING: no CA certificates, HTTPS connections not authenticated
>  # Restore the builtin CA
>  =3D> wget cacert builtin
>  # No more WARNING
>  =3D> wget https://www.google.com/
>  18738 bytes transferred in 15 ms (1.2 MiB/s)

As part of v2, please update the documentation as well with some example
like the above (perhaps as enable X/Y/Z then at run time ...), thanks!

--=20
Tom

--tJZI/VJJ48VHkjZs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfAqZsACgkQFHw5/5Y0
tywwVwv+MS2mtejzh0Vd+qllwSG9NBR3r3KL4v4IVMwIfqlsPX+hVmBrdltbW8pa
RzGvbBcKvnqMx1Wk9eEgZAxZUnYfdQ8rbiw51LLsFxrg26QDAmCwYmPH7H0GDVKy
06Y2a/Rkfmrkwi1iUgt/N/pDoaDi7la58zrEJzrRTwbnYqUwvwg94BYOuiLalJTt
e1ed33SKmerIzVjQSSw06P9QWK81eG5UGwZpnKQTBiDV5bGIh3oZgpA3JwrYMI4X
iOLU5Wloaxsd0y+RIIKFgXUvLCTSimWav2LVjjO8p9B/Wt1ACp7Mq9UcpF8xBlqv
paPOFgQh2L4CLxbUTzPUgHeqKODE19B38lmg1P3Zt6RkPceVN7z9eHgIRniG/2Xy
j5EV5p7L2Rwh9kK+NCOeqTPnuy/6rQ2oiXjroDHipMMh1w8XqtgNlfLJX1IHxwRG
6zuVpvYRfmu2cctsxOgo0zyKqlWi1be3W4b26E8oWh4TK9l6X6oizsbPIg0qHSQJ
XUMbsYH0
=xr1g
-----END PGP SIGNATURE-----

--tJZI/VJJ48VHkjZs--
