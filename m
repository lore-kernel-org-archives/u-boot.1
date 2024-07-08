Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B5F4C3271E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jul 2024 14:02:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 019FE8874E;
	Mon,  8 Jul 2024 16:02:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HPE9dIlZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E64888730; Mon,  8 Jul 2024 16:02:48 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 728D18874E
 for <u-boot@lists.denx.de>; Mon,  8 Jul 2024 16:02:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-5c66b5325bbso953501eaf.2
 for <u-boot@lists.denx.de>; Mon, 08 Jul 2024 07:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720447365; x=1721052165; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Qvo1zLjI+QRzDs9fNRohbVerpzCjgxaPEcdfCFFNh5Q=;
 b=HPE9dIlZ6RtPjjF4L4ZBLb6ts6PIrfQKxbb2/CU6J1EvMTEwiqxdVAEu55eC6MhDhZ
 4FMvfYej6Wa0Uvpar3tMARNfer7qFpyfXh4uLfL5kUozxCsalmDneGLzDlHLsbs5RDVv
 lGlpC/TQKAEEdgqkF0KEaQwQtScFYIhubaUoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720447365; x=1721052165;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qvo1zLjI+QRzDs9fNRohbVerpzCjgxaPEcdfCFFNh5Q=;
 b=hGX9/ako1JjMGFfTAjXgft4DprOnJVMjiepMqxVUm0OgykzszzsPSUlK1YRUd/ixEK
 DBIFarfyLMjNPKmLUmHQRk9EYRw6ufht7Fmxfrvbsqypd1z9rpTeAQOd16MQoW0lyjRs
 kGhxwBN8gV9FEcNrI2Qe+9NJrSO6zZqC42NnzdMyTP9+EMdLKUJVCuySJV5vMAJTBc5H
 fhgE6aRt+ekoezLWc8H39zyz1R8bWaiS+hETnZjEDaR2B4OAMTN8zGkDn9KP61FM+hWw
 zLhwW/944+tVGSswh07ymy0NN7YAf0peZVy2HzaOdkaX8ojs/Xu63ZuRydnBzxxL/Ayx
 akqg==
X-Gm-Message-State: AOJu0YxYVncxBsBdhXm7PXQVTlAZF/E4kbUU7LM948SWVDEA4EEYZy75
 ZoajohnUqbvH4X4KQXMDVp1MrKaJcQG2uyU4+HMJFIvmJyTjO2X/ba2AKMkHeqc=
X-Google-Smtp-Source: AGHT+IElOmAktEOLdHaPQlDnndSLNU9amNKxQrbhpKrR62T9ZaLZ1Y9KGpsWjYPEY87LpBO+D8LyNw==
X-Received: by 2002:a05:6870:4728:b0:254:930c:fa08 with SMTP id
 586e51a60fabf-25e2b8dfefbmr10062740fac.12.1720447365051; 
 Mon, 08 Jul 2024 07:02:45 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-45.totalplay.net.
 [189.203.97.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25ea9f8219asm5073fac.12.2024.07.08.07.02.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 07:02:44 -0700 (PDT)
Date: Mon, 8 Jul 2024 08:02:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Fabio Estevam <festevam@gmail.com>, Michal Simek <michal.simek@amd.com>
Subject: Re: [RFC PATCH v2 00/48] Make U-Boot memory reservations coherent
Message-ID: <20240708140242.GA38804@bill-the-cat>
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OaA0q7eV590CDDuV"
Content-Disposition: inline
In-Reply-To: <20240704073544.670249-1-sughosh.ganu@linaro.org>
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


--OaA0q7eV590CDDuV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 04, 2024 at 01:04:56PM +0530, Sughosh Ganu wrote:

> The aim of this patch series is to fix the current state of
> incoherence between modules when it comes to memory usage. The primary
> issue that this series is trying to fix is that the EFI memory module
> which is responsible for allocating and freeing memory, does not have
> any visibility of the memory that is being used by the LMB
> module. This is further complicated by the fact that the LMB
> allocations are caller specific -- the LMB memory map is not global
> nor persistent. This means that the memory "allocated" by the LMB
> module might be relevant only for a given function. Hence one of the
> requirements for making the memory usage visible across modules is to
> make LMB allocations persistent and global, and then have means to
> communicate the use of memory across modules.
>=20
> The first set of patches in this series work on making the LMB memory
> map persistent and global. This is being done keeping in mind the
> usage of LMB memory by platforms where the same memory region can be
> used to load multiple different images. What is not allowed is to
> overwrite memory that has been allocated by the other module,
> currently the EFI memory module. This is being achieved by introducing
> a new flag, LMB_NOOVERWRITE, which represents memory which cannot be
> re-requested once allocated.
>=20
> A review comment on the earlier version was to do away with the static
> arrays for the LMB lists of free and used memory. This version
> uses the alloced list data structure for the LMB lists.
>=20
> The second set of patches are making changes to the EFI memory module
> to make use of the LMB functions to allocate and free memory. A
> *_flags() version of LMB API's has been introduced for the same. The
> earlier version was using notification mechanism from both LMB and EFI
> modules to maintain memory coherence. This version makes use of the
> LMB API functions for the memory allocations. This is based on review
> comments of EFI maintainers.

On am64x_evm_a53, the last test in test/py/tests/test_net_boot.py fails
due to:
=2E..
TFTP from server 192.168.116.10; our IP address is 192.168.116.23
Filename 'pxelinux.cfg/default-arm-k3'.
Load address: 0x80100000
Loading: ##################################################  64 Bytes
         8.8 KiB/s
done
Bytes transferred =3D 64 (40 hex)
  1  pxe          ready   ethernet     0  port@1.bootdev.0          extlinu=
x/extlinux.conf
** Booting bootflow 'port@1.bootdev.0' with pxe
Retrieving file: pxelinux.cfg/default-arm
am65_cpsw_nuss_port ethernet@8000000port@1: K3 CPSW: rflow_id_base: 16
link up on port 1, speed 1000, full duplex
Using ethernet@8000000port@1 device
TFTP from server 192.168.116.10; our IP address is 192.168.116.23
Filename 'pxelinux.cfg/default-arm'.

TFTP error: trying to overwrite reserved memory...
Couldn't retrieve pxelinux.cfg/default-arm

And note that the pxelinux.cfg files are created as defined by the
example within the test. This test is also still fine on Pi 4.

--=20
Tom

--OaA0q7eV590CDDuV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaL8XsACgkQFHw5/5Y0
tywwFAv8CqPkIxiBH3paHQOuczsAqFlAHdnvRv9lNw8Mnv2Fh5XdKcSze5dsGkFU
zrsDZlIYtGcPitm4a/R7BSqVCcGSB8z8p6dMtFThEOAVW8giQPjJIcqg2+Zr5Rxg
29dPj4+cKGy6m4UcVEW+WyLbV3bqv2TaPqH/yfuD1QCnWNajisri7zI+4HKf7WOp
rDe/gAaXy96/3D+igpHxfT2QnE2o98oXrvotPYk+wCZr+vTOhLVSkTcqI+gnmyAr
otCnpM9Y1zJQ66lYFPWQB8fiMg0dRn5LDUoezWuNZtp5eMDZ4DIY11mBODdun+SV
1bcOjWBk9KAHTWWHHhS371RZXuGmWomG53cnbZyJ1r/1b1UzC4IBi74652D+p8/f
BsIZT6Ermh/Ldxa8Rp/ZW3po0vuPdRbDDERCsPVA1dNwogWpzqLcmSCts3Syvavx
2UbHb+0IcEQHRpCOSnr8BzbxuIxw+nXU/pX2gTZKkbMXU6yDIpzbsYP8Qw/nS4gf
zpaRyAfg
=bdmu
-----END PGP SIGNATURE-----

--OaA0q7eV590CDDuV--
