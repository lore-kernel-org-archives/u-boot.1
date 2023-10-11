Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 263C4CD98E4
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 01:49:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60F2F86BED;
	Wed, 11 Oct 2023 03:49:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="f3XsccV/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99DA386BF8; Wed, 11 Oct 2023 03:49:28 +0200 (CEST)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7744086604
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 03:49:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-d9a6b21d1daso1356313276.3
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 18:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696988965; x=1697593765; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=L7rN3cokvyTTSg0iukAwhN7WHqPLPMx3+1V9BMHAswU=;
 b=f3XsccV/4rrihdHJskTuPfNobvFM/JKo5uqfsMRho291TTSQMXo45nbHvw5M+MB6iW
 t/sJPJwvaHsCMlSyKm7Av7XSxw434wc67moNTcTJzNc0QQhxf1axm2zgO8N25twML0AY
 tndr2nm0oyTxLQtFS7zj8s9OCMjgHzPd9w7Wk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696988965; x=1697593765;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L7rN3cokvyTTSg0iukAwhN7WHqPLPMx3+1V9BMHAswU=;
 b=FzjdhNhHffqkOIqE8xc0GF3gO87ONGqje3Yz6Bz1762Tc/N7ItDEjk7BFo8SGi/AFM
 4ghKRZKGLTh/mPNigulLBZhh21PUaVMdgo/LmBQ7xCoBZd9kzKpYJ8KXdF7mpFB3Wrh5
 A94DTg2k3FgYPulept+6AnNMz1m+neuaTS1ryrh0SdOIDBG8SHjFOZj2+9V/ZAwn6GqB
 KyVSLQEvheJyRgwBYar3WwPx06+GzcqFdKebgNrinfuK850gr8xxIbp54uKU9o8sle0z
 idoLU96Mlo2jh1NkTEyV2sspLc0tZpTbiA8tQcCrsGWYGcoTQ2kvZBYqttuu1i+rDTng
 uPSw==
X-Gm-Message-State: AOJu0YxZ7Se36ray93ReusdvknFQQfqkYxv4rQrIf0PD1yU5amXCGS9B
 HYDMhT1NR9chVCnZJozgQxvlFQ==
X-Google-Smtp-Source: AGHT+IGNw30nMu9FRRcSS77wwD7UlL50c3GxlXGxxMqXFU5bWlU7DqSpyXsaI5tIlGFj716fHh7HWA==
X-Received: by 2002:a81:bf54:0:b0:59f:4e6d:b56a with SMTP id
 s20-20020a81bf54000000b0059f4e6db56amr20843838ywk.2.1696988965049; 
 Tue, 10 Oct 2023 18:49:25 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a369-3392-aca4-1f00.res6.spectrum.com.
 [2603:6081:7b00:6400:a369:3392:aca4:1f00])
 by smtp.gmail.com with ESMTPSA id
 x189-20020a0dd5c6000000b005a7dd6b7eefsm240203ywd.66.2023.10.10.18.49.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Oct 2023 18:49:24 -0700 (PDT)
Date: Tue, 10 Oct 2023 21:49:22 -0400
From: Tom Rini <trini@konsulko.com>
To: Bin Meng <bmeng@tinylab.org>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Bin Meng <bmeng.cn@gmail.com>, Heiko Schocher <hs@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>, Johan Jonker <jbx6244@gmail.com>,
 Joshua Watt <jpewhacker@gmail.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Suchanek <msuchanek@suse.de>, Peng Fan <peng.fan@nxp.com>,
 Tobias Waldekranz <tobias@waldekranz.com>
Subject: Re: [PATCH 00/15] blk: sandbox: Support binding a device with a
 given logical block size
Message-ID: <20231011014922.GA567787@bill-the-cat>
References: <20230926084346.2237483-1-bmeng@tinylab.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kgQph2Wgk4Ink/DF"
Content-Disposition: inline
In-Reply-To: <20230926084346.2237483-1-bmeng@tinylab.org>
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


--kgQph2Wgk4Ink/DF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 26, 2023 at 04:43:30PM +0800, Bin Meng wrote:

> At present on Sandbox when binding to a host backing file, the host
> block device is created with a hard-coded 512 bytes block size.
>=20
> Such assumption works for most cases, but for situation that with a raw
> image file dump from a pre-formatted GPT partitioned disk image from a
> 4KiB block size device, when binding this file to a host device and mappi=
ng
> this device to a blkmap, "blkmap" command like "blkmap part" won't work
> correctly, due to block size mismatch during parsing the partition table.
>=20
> This series updates Sandbox block driver, as well as the blkmap driver,
> to get rid of the hard-coded 512 bytes block size assumption.
>=20
> This series is available at u-boot-x86/blk for testing.
>=20
> Test log (512 block size):
>=20
>   =3D> host bind 0 test.img
>   =3D> host info
>   dev       blocks  blksz label           path
>     0       262144    512 0               test.img
>   =3D> blkmap create 0
>   Created "0"
>   =3D> blkmap map 0 0 40000 linear host 0 0
>   Block 0x0+0x40000 mapped to block 0x0 of "host 0"
>   =3D> blkmap info
>   Device 0: Vendor: U-Boot Rev: 1.0 Prod: blkmap
>               Type: Hard Disk
>               Capacity: 128.0 MB =3D 0.1 GB (262144 x 512)
>   =3D> blkmap part
>=20
>   Partition Map for BLKMAP device 0  --   Partition Type: EFI
>=20
>   Part    Start LBA       End LBA         Name
>           Attributes
>           Type GUID
>           Partition GUID
>     1     0x00000022      0x000000bd      "u-boot-spl"
>           attrs:  0x0000000000000000
>           type:   5b193300-fc78-40cd-8002-e86c45580b47
>                   (5b193300-fc78-40cd-8002-e86c45580b47)
>           guid:   0bb6bb6e-4aac-4c27-be03-016b01e7b941
>     2     0x00000822      0x00000c84      "u-boot"
>           attrs:  0x0000000000000000
>           type:   2e54b353-1271-4842-806f-e436d6af6985
>                   (2e54b353-1271-4842-806f-e436d6af6985)
>           guid:   91d50814-8e31-4cc0-97dc-779e1dc59056
>     3     0x00000c85      0x0000cc84      "rootfs"
>           attrs:  0x0000000000000004
>           type:   0fc63daf-8483-4772-8e79-3d69d8477de4
>                   (linux)
>           guid:   42799722-6e55-46e6-afa9-529e7af3f03b
>=20
> Test log (4096 block size):
>=20
>   =3D> host bind 0 test.img 4096
>   =3D> host info
>   dev       blocks  blksz label           path
>     0        32768   4096 0               test.img
>   =3D> blkmap create 0
>   Created "0"
>   =3D> blkmap map 0 0 8000 linear host 0 0
>   Block 0x0+0x8000 mapped to block 0x0 of "host 0"
>   =3D> blkmap info
>   Device 0: Vendor: U-Boot Rev: 1.0 Prod: blkmap
>               Type: Hard Disk
>               Capacity: 128.0 MB =3D 0.1 GB (32768 x 4096)
>   =3D> blkmap part
>=20
>   Partition Map for BLKMAP device 0  --   Partition Type: EFI
>=20
>   Part    Start LBA       End LBA         Name
>           Attributes
>           Type GUID
>           Partition GUID
>     1     0x00000100      0x00001fff      "primary"
>           attrs:  0x0000000000000000
>           type:   0fc63daf-8483-4772-8e79-3d69d8477de4
>                   (linux)
>           guid:   eba904d7-72c1-4dbd-bb4e-36be49cba5e3
>     2     0x00002000      0x00007ffa      "primary"
>           attrs:  0x0000000000000000
>           type:   0fc63daf-8483-4772-8e79-3d69d8477de4
>                   (linux)
>           guid:   c48c360e-db47-46da-ab87-26416fad3cd3

With minor changes to apply again, applied to u-boot/master, thanks!

--=20
Tom

--kgQph2Wgk4Ink/DF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUl/x4ACgkQFHw5/5Y0
tyzYPAwAm1H+eoH0kN2OqzA216CA58ip8YyB1DvkARX2gGU6eGV+4rmTTuRXXm+Y
VtDkFiQn7jqt6OqRJnUwmD7G7nhifvvZvoTP7T3zd5Ou46aJ2AIg9DSwASlpQYg6
crC/LhmhSf26k+N3V+uOFYOz/nQs9z/cgm+sjA0mzO6GPA5wAVNKRZ/J4Usg33ox
tEAE9Xz213e3Gk0Wh+b1TAMlmaC7ES4jDPnyR2sOkUAbHZPeIer90rEvFYGxps8M
Hx7fcyUyft3rx+3tvT6iL9J8LMz4KuggUvaEUdsugx53rAHhiHYqDwb/vkQzcX4U
x+8h4XNK3URONELFfDD11jyQe+hpfB5kNyYgYJ7LZXFPuIIT0gP/+CtrZw579lLI
fRO1tDqKy/VFnN55OPrkct40hixmPyqVHvDh5Ek4V9eN1hGH0o8cV89RL1ctJc1M
7TE2Fn3zwls/1kTWPa6+8RZZMHOhTqJnkTMy9z/Q5U8i/KRHYv1dsIfffg37LCo+
4d6XKxYW
=eJu5
-----END PGP SIGNATURE-----

--kgQph2Wgk4Ink/DF--
