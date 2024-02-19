Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F5C7C48BF8
	for <u-boot@archiver.kernel.org>; Mon, 19 Feb 2024 21:14:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 494848751B;
	Mon, 19 Feb 2024 22:14:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="X3OQsNYd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32373876E7; Mon, 19 Feb 2024 22:14:26 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0DAA87061
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 22:14:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-607d8506099so45333447b3.0
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 13:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1708377257; x=1708982057; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=D6tNXPuS7JQBK+C4XRGRN0YaZzlPRiB4SJmbv+bW9tg=;
 b=X3OQsNYdhCMr6AgHwPyQDnrXRQReh29cZgvt+yT3P3uba2nytOsUuNhappDPiTgZzg
 hftTjD0EtrNb7y8ZXHtnnFgzkqJ5hZeVffjw8XgpamkKhDNde+JQjTxA1HRZLdj8a7Of
 uZwxCO30/0/FiXVi229qjUmBufQBT9LQAbMWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708377257; x=1708982057;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D6tNXPuS7JQBK+C4XRGRN0YaZzlPRiB4SJmbv+bW9tg=;
 b=YXpK5R5cZOHSIcZqu6KCLaABtw/BD4oIvAqrcFbhLHbgl0DJgsiENboaOkJwlnARyE
 qY4Z0TjX0LYXV45XCm63lY0fAKd4c0Q5D+t3EAD/dYqDtigO5hlBU5ApeeH0y2EGdqtB
 WhJozVknFD3kcBtsRBpg3IPjsfuh36JAz5ik9ecE8h3TF5Bm64qUM0xca+w10dV7rcrf
 SkTf99ns6L6i1siVt0MLl0+lh5qvLPYUbYXN4FqUpJZxkAl6wYWX70hTm7bCZPG336t3
 kgUuy4MLVfHnnDGEyKktyEPR6UBrpqvK2Fs5UbWxr+AmmffYVFb3MNpu5+66jCaGP6MO
 W/bw==
X-Gm-Message-State: AOJu0YwGt7Ogvl67yzfm1d693lk/JYvUdEBUijgJ6B4DuRKGUBB86hwH
 wyCiGD07kNi6eX1u5JvZ0b9pKUdY21dh6WT5RFynlyXR2na3wK21zGgpsqHxJuA=
X-Google-Smtp-Source: AGHT+IFCdR/zAsN0YUrj552crUFkKiZFUhxHNcImLnd3hZrC/9PIShOnkhFwmo3TI3GRlul8szwTTQ==
X-Received: by 2002:a0d:e243:0:b0:607:a30d:8b3 with SMTP id
 l64-20020a0de243000000b00607a30d08b3mr13809475ywe.18.1708377257487; 
 Mon, 19 Feb 2024 13:14:17 -0800 (PST)
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 u185-20020a8184c2000000b0060820229c74sm1019225ywf.5.2024.02.19.13.14.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 13:14:17 -0800 (PST)
Date: Mon, 19 Feb 2024 16:14:15 -0500
From: Tom Rini <trini@konsulko.com>
To: Sahaj Sarup <sahaj.sarup@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: LTO build failure with GCC 13.2.1
Message-ID: <20240219211415.GO3040305@bill-the-cat>
References: <CAKZ1LvPwQyWadPtmv4LRmANm-6CHQpNZQqgRyzdxM3fvBTT=1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0qqw3VCbzCVQ2kRJ"
Content-Disposition: inline
In-Reply-To: <CAKZ1LvPwQyWadPtmv4LRmANm-6CHQpNZQqgRyzdxM3fvBTT=1A@mail.gmail.com>
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


--0qqw3VCbzCVQ2kRJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 10:19:38AM +0530, Sahaj Sarup wrote:

> Hi all,
>=20
> Since commit f8cebb4f789c9950caf55a0b73e88049e7a1c3a3 enabled LTO by
> default for imx8m platforms,
> I have been having issues building u-boot.
> I am primarily working on imx8mp instead of imx8mm platforms so the
> bug resolved by that commit doesn't affect me yet.
> But I guess it's a generic issue with u-boot's LTO requirements and GCC 1=
3.
>=20
> Build log:
> ```
>   LTO     u-boot
> /usr/bin/aarch64-linux-gnu-ld:
> /usr/lib/gcc/aarch64-linux-gnu/13/libgcc.a(lse-init.o): in function
> `init_have_lse_atomics':
> /builddir/build/BUILD/gcc-13.2.1-20230728/aarch64-linux-gnu/aarch64-linux=
-gnu/libgcc/../../../gcc-13.2.1-20230728/libgcc/config/aarch64/lse-init.c:4=
6:
> undefined reference to `__getauxval'
> collect2: fatal error: ld terminated with signal 11 [Segmentation
> fault], core dumped
> compilation terminated.
> make: *** [Makefile:1766: u-boot] Error 1
> make: *** Deleting file 'u-boot'
> ```
>=20
> GCC Version:
> ```
> $ aarch64-linux-gnu-gcc -v
> Using built-in specs.
> COLLECT_GCC=3D/usr/bin/aarch64-linux-gnu-gcc
> COLLECT_LTO_WRAPPER=3D/usr/libexec/gcc/aarch64-linux-gnu/13/lto-wrapper
> Target: aarch64-linux-gnu
> Configured with: ../gcc-13.2.1-20230728/configure --bindir=3D/usr/bin
> --build=3Dx86_64-redhat-linux-gnu --datadir=3D/usr/share --disable-
> decimal-float --disable-dependency-tracking --disable-gold
> --disable-libgcj --disable-libgomp --disable-libmpx
> --disable-libquadmat
> h --disable-libssp --disable-libunwind-exceptions --disable-shared
> --disable-silent-rules --disable-sjlj-exceptions --disable-threa
> ds --with-ld=3D/usr/bin/aarch64-linux-gnu-ld --enable-__cxa_atexit
> --enable-checking=3Drelease --enable-gnu-unique-object --enable-init
> fini-array --enable-languages=3Dc,c++ --enable-linker-build-id
> --enable-lto --enable-nls --enable-obsolete --enable-plugin --enable-t
> argets=3Dall --exec-prefix=3D/usr --host=3Dx86_64-redhat-linux-gnu
> --includedir=3D/usr/include --infodir=3D/usr/share/info --libexecdir=3D/u=
sr/
> libexec --localstatedir=3D/var --mandir=3D/usr/share/man --prefix=3D/usr
> --program-prefix=3Daarch64-linux-gnu- --sbindir=3D/usr/sbin --shared
> statedir=3D/var/lib --sysconfdir=3D/etc --target=3Daarch64-linux-gnu
> --with-bugurl=3Dhttp://bugzilla.redhat.com/bugzilla/ --with-gcc-major-
> version-only --with-isl --with-newlib
> --with-plugin-ld=3D/usr/bin/aarch64-linux-gnu-ld
> --with-sysroot=3D/usr/aarch64-linux-gnu/sys-root
> --with-system-libunwind --with-system-zlib --without-headers
> --enable-gnu-indirect-function --with-linker-hash-style=3Dgnu
> Thread model: single
> Supported LTO compression algorithms: zlib zstd
> gcc version 13.2.1 20230728 (Red Hat Cross 13.2.1-1) (GCC)

Interesting, we build this platform fine with gcc-13.2.0, so this might
be a regression elsewhere? Please investigate what's required to fix
this, and perhaps if it's a toolchain problem or a compiler problem,
once the "fix" is known in U-Boot.

--=20
Tom

--0qqw3VCbzCVQ2kRJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXTxKMACgkQFHw5/5Y0
tyysdwv/UCzneTlFw5ZlKxt28gYA1QvUHYHpxhUzcnQvODT9x0qM3NB/A9g8xpMD
jNdEqTB1wRWo0FKowGRORUiUjA/JnigXer3e44S55M3ys4B+7QIMzld687Rh88gj
kcWws+Y3jaYF2Jidu6/Sk1DeLkEwF+qzuG/M8F0HCWtxpLh4BCNbjYxpwaR2vINo
PqXx9BreGxA4sB22ktXnGPwnN7wSJ54cUwT8gZ+dXlqkIUMAVBdS6q1EP4Hlw9kJ
oSpiOvY3/6bhOBU/ZhMLLtGhIWeBpqXLqLg5c7QTpYGVXK87f7huuPtkJpYPhNJb
OPTgGYcmiPsLrKAmaCg2owYn5zyS2PyTK9C4cKT1NSmbe3uHvvA3G0GJJ43c3wSl
l8x0Tu0I+Pu8uMFAyOfbwwhgrWn3KymYiFhMFtiiirpTUlzJ57pRL66yOFjL0/0C
GzbomO2AJRnQw5S9UJxTkOShlzx+EIm6Vtq3VAvQUMcjVYLUhQ6qHrCqx3tT35lo
LOYsMmKU
=kUqx
-----END PGP SIGNATURE-----

--0qqw3VCbzCVQ2kRJ--
