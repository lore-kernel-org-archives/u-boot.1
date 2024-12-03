Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44A8BE64AA6
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 13:54:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC80D88F55;
	Tue,  3 Dec 2024 14:54:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Yf8GYuHi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80A3F8921A; Tue,  3 Dec 2024 14:54:55 +0100 (CET)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22DBA88E5C
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 14:54:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6d8a13444fcso19161766d6.3
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 05:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733234092; x=1733838892; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DQD48TmFkwnIKYAJS86Cb74ZoW4Lc4QBEGxdEZ0rnZo=;
 b=Yf8GYuHi0a83Js5ruAYYwX79ypIkw2SCOxpWZX4DGOdfpzRLpQ5qOofCxKWwtPnxfp
 s47r+Pfjm6MnexfEMxlPt0QSujQfZMEJSqKSsEhPbL0T+WlnbvpPJEfgYaBvPnbxs/w4
 Hu6fin2DXIVqp3RzGqYXQty2yAxfJscIKGY6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733234092; x=1733838892;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DQD48TmFkwnIKYAJS86Cb74ZoW4Lc4QBEGxdEZ0rnZo=;
 b=ehk+LoFgWYgYVtM2casPAOJJLHSue0WiaV3W9w5+Y8N2EWyHATAsaE6/HJepp8hDP6
 dDmOIJY+K1j7J8IgGg8fJ5zl39ZK/Sy4OGfVcCHdrY8BAJ7q/e1J+VX00Wk8I1zw3W3P
 qE3BNWnVrqHcrj6WPucs9MovL8hT6to2ZFiGxf+zVqTjZlU00KTWHtNldhedBFtW0Qhv
 /kdYPirbJYdYA/bCizsyabsBtR2UlK9ERP8SILtdnHJ0v8oHloTbsDzm2zya9CrbAKFX
 hBI3Zi60pwXehGPE8VCbmpL73OfCxvNzcfh2tXMK+4oe+0njkxFs7wMRetlWB4O7EQ/b
 TqiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUN2qJkY5HybwFyi3+myO50XYC9Y469cYSMdvSCALjjtKNOoR2Xn+QFok+IUAdOR7IZtenmT8A=@lists.denx.de
X-Gm-Message-State: AOJu0YwgYZgjh06Fs520oq39ThCKGW1stRxkxtQg+/2XJiji30MdgkG/
 lmY/q2q1rHztOGHTHwHcu77kLo/+TThKY7jltz/hIAF4vofyOw1ouRjml/rs7I8=
X-Gm-Gg: ASbGncvTfiubuNXAp7aGvzM5BVaVS2TyMwVqD3W38VVXdfKGPwOKy5ALZv0abaaAQYd
 UsogeD8QtjcDdQOARSvxSmNsmPc1f6zwP3mCghZUpiRk5AJcGHPa8T20rylxd8SJYs4KOVhsH1k
 CBkrXwVsFmsU0ex4F6V8LUQYzGTgl20WgP3haeIB4x0R6GTveyNUzRGDLhDq8yhdqt6Mu5u3/p3
 hbTuYZXzGrTHYxY229GsFaO6KEDrX1KKL3TRDsyQO8Yc6oITA==
X-Google-Smtp-Source: AGHT+IEWm+mGDyreVUQ+3nRpyzmVJ9S78FLpH0Rc8lJ2HssUSHNFnNVm+8fbqx8Z4QiASbrCoH1Mqw==
X-Received: by 2002:ad4:5de7:0:b0:6d8:9a6f:fea7 with SMTP id
 6a1803df08f44-6d8b73a0de8mr42407126d6.24.1733234091926; 
 Tue, 03 Dec 2024 05:54:51 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b6849c4143sm510044085a.115.2024.12.03.05.54.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 05:54:51 -0800 (PST)
Date: Tue, 3 Dec 2024 07:54:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Moritz Fischer <moritzf@google.com>
Subject: Re: [PATCH v5 6/9] efi: Show the location of the bounce buffer when
 debugging
Message-ID: <20241203135448.GQ2457179@bill-the-cat>
References: <20241201152815.1668093-1-sjg@chromium.org>
 <20241201152815.1668093-7-sjg@chromium.org>
 <CADg8p946omqMf9QAzwU_Aa6wbPFkfO3sUpAWebn1DraUoN7rUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XuJbDU1UKSt4nbTt"
Content-Disposition: inline
In-Reply-To: <CADg8p946omqMf9QAzwU_Aa6wbPFkfO3sUpAWebn1DraUoN7rUQ@mail.gmail.com>
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


--XuJbDU1UKSt4nbTt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 03, 2024 at 05:36:40PM +0530, Sughosh Ganu wrote:
> On Sun, 1 Dec 2024 at 20:58, Simon Glass <sjg@chromium.org> wrote:
> >
> > The EFI_LOADER_BOUNCE_BUFFER feature was added many years ago. It is
> > still needed and 24 boards (lx2160ardb_tfa_stmm,
> > lx2162aqds_tfa_SECURE_BOOT and the like) use it.
> >
> > This feature uses EFI page allocation to create a 64MB buffer 'in space'
> > without any knowledge of where boards intend to load their images. This
> > may result in image corruption or other problems.
> >
> > For example, if the feature is enabled on qemu_arm64 it puts the EFI
> > bounce buffer at 1045MB, with the kernel at 1028MB and the ramdisk at
> > 1088MB. The kernel is probably smaller than 27MB but the buffer does
> > overlap the ramdisk.
> >
> > The solution is probably to use BOUNCE_BUFFER instead, with the EFI
> > version being dropped. For now, show the address of the EFI bounce
> > buffer so people have a better chance to debug any problem.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> > In response to questions on how to show this problem:
> >
> > First, add CONFIG_EFI_LOADER_BOUNCE_BUFFER=3Dy to
> > configs/qemu_arm64_defconfig and build
> >
> > Then, to run:
> > qemu-system-aarch64 -machine virt -nographic -cpu cortex-a57 \
> >    -bios u-boot.bin
> >
> > U-Boot 2024.10-00809-gae29e5f76e4a-dirty (Oct 11 2024 - 11:48:46 -0600)
> >
> > DRAM:  128 MiB
> > Core:  51 devices, 14 uclasses, devicetree: board
> > Flash: 64 MiB
> > Loading Environment from Flash... *** Warning - bad CRC, using default =
environment
> >
> > In:    serial,usbkbd
> > Out:   serial,vidconsole
> > Err:   serial,vidconsole
> > No USB controllers found
> > Net:   eth0: virtio-net#32
> >
> > starting USB...
> > No USB controllers found
> > Hit any key to stop autoboot:  0
> > =3D> bootefi hello
> > Enabling coop memory
> > No EFI system partition
> > No EFI system partition
> > Failed to persist EFI variables
> > Missing TPMv2 device for EFI_TCG_PROTOCOL
> > Missing RNG device for EFI_RNG_PROTOCOL
> > Warning: EFI bounce buffer 000000004157f000-000000004557f000
> > Not loaded from disk
> > Booting /MemoryMapped(0x0,0x47763730,0x31b0)
> > EFI: Call: efi_load_image(false, efi_root, file_path, source_buffer, so=
urce_size, &handle)
> > EFI: 0 returned by efi_load_image(false, efi_root, file_path, source_bu=
ffer, source_size, &handle)
> > Hello, world!
> > Running on UEFI 2.10
> > Firmware vendor: Das U-Boot
> > Firmware revision: 20241000
> > Have device tree
> > Load options: <none>
> > File path: <none>
> > Boot device: /MemoryMapped(0x0,0x47763730,0x31b0)
> > =3D> print kernel_addr_r
> > kernel_addr_r=3D0x40400000
> > =3D> print ramdisk_addr_r
> > ramdisk_addr_r=3D0x44000000
> > =3D>
> >
> > The EFI bounce buffer overlaps with the ramdisk.
>=20
> Why can't we "allocate" sane values for the env variables in question,
> similar to what is being done for the apple and qcom boards -- you can
> refer to arch/arm/mach-apple/board.c:board_late_init(). We won't be
> facing these issues then. Eventually, there can be a common, platform
> agnostic function to initialise these values. So, just as a PoC, I
> added this code to the qemu-arm.c, and no longer observe any overlaps.

There's two challenges. One challenge is that yes, we should make use of
LMB generally to allocate regions in the common case, like mach-apple
does. The second challenge is that everyone had agreed (I would swear)
that the EFI-specific bounce buffer needs to be removed and just use the
generic bounce buffer option. But no one has wanted to do the work, and
so Simon keeps posting some variant on this patch.

--=20
Tom

--XuJbDU1UKSt4nbTt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdPDaQACgkQFHw5/5Y0
tyz7fwwAjPFsZNFqH1PiNxMy6YuOLFM4CQmBCmTt0DOd2HJXLc/aODBzODCbYby6
D9BpYa0HxSLzcsWHLDknCjZXfE8rIaawHnF/bIqEWhvSbwrNsKkq/waIewVsZksg
O0TRZOLYIFFBxUEqYgHuP3B5bEqFd9jOOj1VYTua7/oUiERvPFdDZRtWn9VavhTy
rpAVEtYkQTJgpfYqCxxbWTQ9t6pSz4UNX/MyfH5gcQNSxvM63OHlc4KJgMnFQ+dd
fRDiCNR+wv7Kh+SJqDjTmi7qdqXu4tKBwkETIEEOfU1nup65LCnuljnhChnLg4Gd
NURPus6TZRfrXegoUxpxW4oUShF8ww6RwT3hr5QuIy7rO1L5kgISFFSwWjaAUeTk
e0PgQ3XXsHgcqBb+dFLo1fgfg9Gd9XuX/s43eUyp3z61u7RXAVvzXhJnEe/IMKpy
NMv+LDmDcdosWSI+A+LX3ha2aabH/dotTuvZalrBIb3YIoqklZ4N4ctG9APQ1yfM
+HfhPNmb
=RcNO
-----END PGP SIGNATURE-----

--XuJbDU1UKSt4nbTt--
