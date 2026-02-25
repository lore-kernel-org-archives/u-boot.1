Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21C89FD45F1
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 21:35:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6292583642;
	Wed, 25 Feb 2026 22:35:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OTGFO2MJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 644188366F; Wed, 25 Feb 2026 22:35:08 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A28082A9E
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 22:35:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7d18c654458so37164a34.3
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 13:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772055305; x=1772660105; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yYtu5Zka3kN93H3P+c/6Cu2PbcenA+/yubdYjIBcb8k=;
 b=OTGFO2MJP1XTn0QVhvztBGmKngIjKKxPrR2dS1R+rlxmcVlIv5v0cJ+mDlxHYqAhsl
 9/j/Nun3ljZenCXa5uWZ60LGRCq7qT9YuUMsBsITDyXYocNfiDQsn3bvG2MRE7SsdMQo
 Kdzbk3RiC9BYkYIdbflVcLoz5WfRH4sRBGYqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772055305; x=1772660105;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yYtu5Zka3kN93H3P+c/6Cu2PbcenA+/yubdYjIBcb8k=;
 b=jMm6Wc/ATDWRhkL0o5o/N+w4dSlgGEVmHJ8SYFDS3IN5Dkpu39NGbk9KBpbnRLynew
 3i0Hgo8KgGlf7jPFxEe41Be3NPH4ekiz8v9SZo4PJ2NQg+F9z+eK88mm0to6XzGVrmB5
 xEJEVEoctBKrQbzi7aFVtGw+Dy4DP9ZocQk28c2KlDZuwfit3UbkNDshNeG2IHLyWq9X
 TVvHbmLQd3Sy3sagoISQp1Km1uQS7QImc4I/Z5ieAVKymGqeoYobH5D9caNtEdG6+/yS
 zc50Jc1VYJU+UT2UwG1RmmdFLeypAjZf7VKfGrpThQ02T0dDOuDqF20kbF8Y3ZmWuQew
 iRfg==
X-Gm-Message-State: AOJu0YyJC0FC5cSxTglZGeaD/GkM0heb4s8P7z+miN67GWtk6MNrmB90
 B7K/MsqBDeb/C5Dhh5E2WUuDT/uZoJ+1NIAk9T4D8ktuisQmhRZLS/6Pl/2r1Yp5XdP+Memug3t
 Ky8ZYJN0=
X-Gm-Gg: ATEYQzxJKBcB2cQjQGtYVx18AYgpQycbnCebsK7Kl8hQiN13G7PZftkLqBu4BHSjJ6N
 CUzkorJqhPbCaNYqoGkgxFhAB1z3CIT4Oxoj+LunytAqICLB+UYEHHjXzuzjD8wTp8+h8UnLMC+
 idG4wu/Hy5molA1PrjW0qg+nZq/unQxJd1a7mKZAVanDRfbUQKP4Cq+R0jqkrIgkGwpAEUaNb8p
 mZnfZuvjQRVS2TL3J7quwwiTe8OgzKuU46y5rXeYZIiutWNLJVCwLtyKOqrD+ri47C7UibwnoUI
 xTU6LpZzS+FSExYg1h+oHyM0tBugmIU15xfJNB33UCtpxfnJb0c0YhOgMnM5LXzS3HHSnDHcnMm
 KploNo/0v3hD6BT/IN5Ah03NHvBonDxwhsMVyM4UbV4khQGkcg1rc7DmEFlKXSaabmXUheZaTPq
 CdfowJ4i7sdYRQ7+lzNb89ujo4V2lzjI/Geb9VRtsxf+VCOi9Sy7eV1h7uVfbO69TMxFT6qKrkc
 GhKtPjlRSZLDhwiVBeVlRVMJfJz1czw40pV0THbrfcWPtOnQUk=
X-Received: by 2002:a05:6830:6210:b0:7d5:1850:b26d with SMTP id
 46e09a7af769-7d52bea886cmr9543150a34.0.1772055304590; 
 Wed, 25 Feb 2026 13:35:04 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d586625e6bsm111053a34.17.2026.02.25.13.35.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 13:35:03 -0800 (PST)
Date: Wed, 25 Feb 2026 15:35:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Ludwig Nussel <ludwig.nussel@siemens.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] bootm: fix booting kernel_noload image
Message-ID: <20260225213500.GW1593142@bill-the-cat>
References: <20260224155712.286317-1-ludwig.nussel@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="J2CLG+W/Ro7HB82/"
Content-Disposition: inline
In-Reply-To: <20260224155712.286317-1-ludwig.nussel@siemens.com>
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


--J2CLG+W/Ro7HB82/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 04:57:10PM +0100, Ludwig Nussel wrote:

> FIT images don't work without having to explicitly specify physical
> load addresses. Digging into that it looks like a flaw in
> bootm_load_os().
> It duplicates images->os for convenience. However, the code handling
> "kernel_noload" images then updates the load address in the copy with
> the value lmb_alloc_mem() returned. Later there's another call to
> lmb_alloc_mem() that uses the old value. This leads to havoc due
> to subsequent calls of lmb_alloc_mem() picking too low addresses.
>=20
> The "fix" is to mark the local variable const to avoid accidental
> assignments. This works but IMO the logic is still flawed somehow as
> this leads to overlapping lmb reservations. I guess the fixed
> reservation should only be done when the noload path wasn't hit.
>=20
> Without the change:
> + bootm 0x40200000#qemu-arm 0x40200000#qemu-arm 0x40000000
>    Using 'qemu-arm' configuration
>    Verifying Hash Integrity ... OK
>    Trying 'kernel' kernel subimage
>      Description:  Linux kernel
>      Created:      2026-02-24  14:10:09 UTC
>      Type:         Kernel Image (no loading done)
>      Compression:  gzip compressed
>      Data Start:   0x402000b8
>      Data Size:    12227440 Bytes =3D 11.7 MiB
>      Hash algo:    sha256
>      Hash value:   7ea661fdecdd1127edd419cfbf8bff52e2d5ac55c...
>    Verifying Hash Integrity ... sha256+ OK
>    Using 'qemu-arm' configuration
>    Verifying Hash Integrity ... OK
>    Trying 'ramdisk' ramdisk subimage
>      Description:  Initial ramdisk
>      Created:      2026-02-24  14:10:09 UTC
>      Type:         RAMDisk Image
>      Compression:  uncompressed
>      Data Start:   0x40da9528
>      Data Size:    1067114 Bytes =3D 1 MiB
>      Architecture: AArch64
>      OS:           Linux
>      Load Address: unavailable
>      Entry Point:  unavailable
>      Hash algo:    sha256
>      Hash value:   2a711dcb5f58615187645ccec615c67eddcfbb3138...
>    Verifying Hash Integrity ... sha256+ OK
>    Booting using the fdt blob at 0x40000000
> Working FDT set to 40000000
>    Uncompressing Kernel Image (no loading done) to 13a400000
>    Loading Ramdisk to 400fb000, end 401ff86a ... OK
> device tree - allocation error
> FDT creation failed!
> resetting ...
> Bloblist at 0 not found (err=3D-2)
> alloc space exhausted ptr 400 limit 0
> Bloblist at 0 not found (err=3D-2)
> [reset]
>=20
> After:
> + bootm 0x40200000#qemu-arm 0x40200000#qemu-arm 0x40000000
>    Using 'qemu-arm' configuration
>    Verifying Hash Integrity ... OK
>    Trying 'kernel' kernel subimage
>      Description:  Linux kernel
>      Created:      2026-02-24  14:10:09 UTC
>      Type:         Kernel Image (no loading done)
>      Compression:  gzip compressed
>      Data Start:   0x402000b8
>      Data Size:    12227440 Bytes =3D 11.7 MiB
>      Hash algo:    sha256
>      Hash value:   7ea661fdecdd1127edd419cfbf8bff52e2d5ac55ce...
>    Verifying Hash Integrity ... sha256+ OK
>    Using 'qemu-arm' configuration
>    Verifying Hash Integrity ... OK
>    Trying 'ramdisk' ramdisk subimage
>      Description:  Initial ramdisk
>      Created:      2026-02-24  14:10:09 UTC
>      Type:         RAMDisk Image
>      Compression:  uncompressed
>      Data Start:   0x40da9528
>      Data Size:    1067114 Bytes =3D 1 MiB
>      Architecture: AArch64
>      OS:           Linux
>      Load Address: unavailable
>      Entry Point:  unavailable
>      Hash algo:    sha256
>      Hash value:   2a711dcb5f58615187645ccec615c67eddcfbb3138...
>    Verifying Hash Integrity ... sha256+ OK
>    Booting using the fdt blob at 0x40000000
> Working FDT set to 40000000
>    Uncompressing Kernel Image (no loading done) to 13a400000
>    Loading Ramdisk to 13a2fb000, end 13a3ff86a ... OK
>    Loading Device Tree to 000000013a1f8000, end 000000013a2fafff ... OK
> Working FDT set to 13a1f8000
>=20
> Starting kernel ...
>=20
> Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--J2CLG+W/Ro7HB82/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZ9rAQAKCRAr4qD1Cr/k
CkubAP42W88R3EOZcTEm3AbMBKd1Mvlz0ehahoppAcSdSpyh+wEAsYGUgDS6WClC
P4z5iiYm+U0lzhiZT0T7Gh2mXHFuDwE=
=hadJ
-----END PGP SIGNATURE-----

--J2CLG+W/Ro7HB82/--
