Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D1D9C3DA4A
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 16:13:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D32688B88;
	Fri, 16 Aug 2024 18:13:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MIACD1Xc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A47F88B6D; Fri, 16 Aug 2024 18:13:19 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B4738852A
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 18:13:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-709428a9469so1350233a34.3
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 09:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723824794; x=1724429594; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rGy6xf1FY7jK3fTrCVKw2HpfDDlhw4ZlGBo7SV49k2s=;
 b=MIACD1XcHy/Fx8+mgTiDFvDEDUj57liWaAgRJ3LCcNKvYsnG44mEFXRku8bSqEIMTn
 AsNsNfY/LvFUp6jybDt28b4F+sPlUGyhEtowYziUJu59F8SptQsk6zbMEl4lhurOO6RX
 aTfmS+bZZ/92LPE7A7sRxC0PMzEIa1ATtmYvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723824794; x=1724429594;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rGy6xf1FY7jK3fTrCVKw2HpfDDlhw4ZlGBo7SV49k2s=;
 b=TCUIX9omUtc4eDNWQNUlzcecdnutGWyrACV8QNlfDtcjJtEbT7a17VpZpB8I8xM21n
 uVNuQIW8l3pe31kF8qYQ+KbO6C5EvKJIvVMSzgq/yiJgonxk8/wJ+sQo1uBUXV8WI47p
 RP8oy+Hh+hsFb9ZRYCwTDYm/sqMzrjRe7rIWdj/gtabNaA8hoDaF+mdlPwHnCq8h3Cgl
 8/lUx6EqS8IPIfbqtxGNHLyRcm9XkLzl6Gxtzg8DUHbU6b7fvsYhJepPvvZhlSprqZOC
 JJLtSZdqbXvRzlsyxkpCnCYpBgFU0swmjTcooble2RIRQ7fMPrUdbt7kxvxWEW+O67Ca
 cfQQ==
X-Gm-Message-State: AOJu0Yy7BAzpGKhM2RBsPBb9j7GhapbvfFPI4JNjjTNlSV4RNyXZsIbh
 NdPyTBvXVDFCEUOLbxdK3vdf2hE7oKZt+OEihbnmG3ZCh9KpPn+nNaNs3BmhrpQ=
X-Google-Smtp-Source: AGHT+IGmuSsipHjWeHRYutKwfdnT2L23xlwrkd6kb7ZcSOEPUxhrF3yguYbdQyjdUFfGM4ddwzNnnw==
X-Received: by 2002:a05:6830:3109:b0:703:79f5:fabb with SMTP id
 46e09a7af769-70cac84f62dmr2815911a34.11.1723824794358; 
 Fri, 16 Aug 2024 09:13:14 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-236.totalplay.net.
 [189.203.97.236]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70ca65b8d20sm723217a34.39.2024.08.16.09.13.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 09:13:13 -0700 (PDT)
Date: Fri, 16 Aug 2024 10:13:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v4 13/14] test: efi: boot: Set up an image suitable for
 EFI testing
Message-ID: <20240816161311.GY1626301@bill-the-cat>
References: <20240815202424.766778-1-sjg@chromium.org>
 <20240815202424.766778-14-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="D23lN5vNGwce5bl7"
Content-Disposition: inline
In-Reply-To: <20240815202424.766778-14-sjg@chromium.org>
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


--D23lN5vNGwce5bl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 02:24:23PM -0600, Simon Glass wrote:
> Create a new disk for use with tests, which contains the new 'testapp'
> EFI app specifically intended for testing the EFI loader.
>=20
> Attach it to the USB device, since most testing is currently done with
> mmc.
>=20
> Initially this image will be used to test the EFI bootmeth.
>=20
> Fix a stale comment in prep_mmc_bootdev() while we are here.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
[snip]
> +    try:
> +        loop =3D mount_image(cons, fname, mnt, 'ext4')
> +        mounted =3D True
> +        efi_dir =3D os.path.join(mnt, 'EFI')
> +        mkdir_cond(efi_dir)
> +        bootdir =3D os.path.join(efi_dir, 'BOOT')
> +        mkdir_cond(bootdir)
> +        efi_src =3D os.path.join(cons.config.build_dir,
> +                               f'lib/efi_loader/testapp.efi')
> +        efi_dst =3D os.path.join(bootdir, 'BOOTSBOX.EFI')
> +        with open(efi_src, 'rb') as inf:
> +            with open(efi_dst, 'wb') as outf:
> +                outf.write(inf.read())
> +    except ValueError as exc:
> +        print(f'Falled to create image, failing back to prepared copy: {=
exc}')
> +
> +    finally:
> +        if mounted:
> +            u_boot_utils.run_and_log(cons, 'sudo umount --lazy %s' % mnt)
> +        if loop:
> +            u_boot_utils.run_and_log(cons, 'sudo losetup -d %s' % loop)

Please see
https://patchwork.ozlabs.org/project/uboot/patch/20240802093322.15240-1-ric=
hard@nod.at/
for inspiration on making this not require sudo.

--=20
Tom

--D23lN5vNGwce5bl7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAma/eo0ACgkQFHw5/5Y0
tywHzQwAqGZjJ3MaEPtbe8l01935uxS2TTWhIkxt+qaMO38rpB1IUpk95DdKDpO/
/sS6n7lLyYk5IHluA+QZau64rMyJufjLxsJ4cSJ81Bb+cqqBUQrYfNSvqaGm3YOn
ngijDAecSBQzk5QGZY8K+Ui+1j5k4AkdIW2jPW93DHmMXePJfxjRV7c2CVF1nrJ/
wgMiSNjG5ktxYwvbySbQiDunG5ZwjPPngg3r6aijtu81+38LTcBeokWYbM4AXCek
lYK6jPkWzPQY4f+XQdGRZ4MC65uUoDkhsYAjqh2lsaq1/XrqZRGb9mZY0KM+Mth4
eP0KMFbaqoMX61+bG4EeV85Gs5YJXUmypXwKmePPHDu4r0jbgGdl7oEEOWsxjOPj
lrs97mVHOgs/eCHsYZRzkc85cXyu2aqzVB3oCxn4D3eI+jLSfxZ+Cb89j5cfu5IA
m5OjqVJAK96sT2vsUmi/c/Ljdml7YoUekoSBLz0P52i3mbbD89PlmmihB8crizqY
B1x8w95s
=9asV
-----END PGP SIGNATURE-----

--D23lN5vNGwce5bl7--
