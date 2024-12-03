Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 011BFE64AAD
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 13:57:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DA138921A;
	Tue,  3 Dec 2024 14:57:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XeB1ZrPD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 491E4895C7; Tue,  3 Dec 2024 14:57:23 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCE7B88F55
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 14:57:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7b66ea49407so489489885a.0
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 05:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733234240; x=1733839040; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zJWiuRxK3/1YcmPL//8NXmOaP4lJcygwD+NW4J/cHZ8=;
 b=XeB1ZrPDkGmzBCOPRFFLH43XZEWGBK2G2LOvTlQ0BMlGUhnBEVEc6Js6d0esqcWgue
 3focCstn1fXHLz3rhQPKy6iDA+A+gUStWQM+jv4qjYrpB7N1XN+TYiudvvVBCBJSTd/I
 41u5CeN7vEGJHNRc/7TkVWo9wa2uqpuyS5x0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733234240; x=1733839040;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zJWiuRxK3/1YcmPL//8NXmOaP4lJcygwD+NW4J/cHZ8=;
 b=NC/dq2YahdPVXl+ovQpbyZA9EWUfElGWPRVR3CtHQGVulnoTdxeMQAZRJnMjyiKE2x
 nKUeMSVZRcu3aoRhuVYQ7y+7M8t4U8FTyd7y06HHfSvYHnHMUV70nF3fJ1c71HcUimIA
 MdcoDebi7KT9XmrP1spNOH4d2WQerhdEajBTRSaL8SE1elus8MsN35fPOwlE0ApeYSrA
 3TLNSzg8nn20fT8Do7RrieknGQhGRtpa00LXsNCMgmVLpY0vtUYiOX04O+ofwOcHtCpD
 q9E45tYIgWjhfkWEBmGM/5gr7zdEwc3AlWZmvKpKH/+TtHm2iYM+qYalDq7T7zlot5pQ
 dBcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPxhNDvUNVYZ+51QqIg7Za6/r0Qvl3EXFP0iU54iePPUQFLHyiRnLiqPz0qnznp9P6JtJe77A=@lists.denx.de
X-Gm-Message-State: AOJu0Yz7h4lDLuhbS26oImzHrXOuMP9E3RUe/hr0tNhTlXDvr9FksQY8
 OYTY3aYgDCTPJleysf+JVtzRoJFEwihJZkfmp1GuYaH6VzyneQqJwHT7Dy4fels=
X-Gm-Gg: ASbGncuU/QQkdCAZgVGm4mcRINhHdemZX0dax0nE1oFfrS7021mDvAd0+Al4amjqf7A
 qQ6DBhFKbS/7ttki+dPzoXq2lCbpn4i4FVGvd5/E+OLsG444Bn5zjSnru05okrX986RdKate9XW
 VDhJ0yJOsOPJVvcrbfet6YwWfcF41kHcpfj9aetyZW1MKxcaR04IFCKoICe/pY1n8XimYWXj5RN
 px3EGzAUNdkCN8VxNJeBfNx3+YrnrSbVM6PJCr7GJgKkMzXJg==
X-Google-Smtp-Source: AGHT+IHezeb9pF6dJhpCsHyN2Z+G4dKdKGfSPwkS6Ggs8sIvCPGw1JZDU/Xd2J2/wnBrf1hyTNMEpA==
X-Received: by 2002:a05:620a:1729:b0:7ac:e8bf:894a with SMTP id
 af79cd13be357-7b683a2cff9mr3791884985a.20.1733234239655; 
 Tue, 03 Dec 2024 05:57:19 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b68492114bsm511760385a.9.2024.12.03.05.57.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 05:57:19 -0800 (PST)
Date: Tue, 3 Dec 2024 07:57:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Moritz Fischer <moritzf@google.com>
Subject: Re: [PATCH v5 6/9] efi: Show the location of the bounce buffer when
 debugging
Message-ID: <20241203135716.GR2457179@bill-the-cat>
References: <20241201152815.1668093-1-sjg@chromium.org>
 <20241201152815.1668093-7-sjg@chromium.org>
 <CADg8p946omqMf9QAzwU_Aa6wbPFkfO3sUpAWebn1DraUoN7rUQ@mail.gmail.com>
 <b5a14d41-587d-45fd-a1d7-a02ed09eab5b@gmx.de>
 <CADg8p96f_Wdb-T688QpeaEPXec6AYQwTTj-g18L-XXZk5QTzUA@mail.gmail.com>
 <CADg8p96_QYnVvbQH+YTimOrcgqOsdRinTMgDCXGeky8tmgPwMw@mail.gmail.com>
 <CAFLszTiRJnhuV1YPSbO8=0FNOR-D7wr64V2bvL1xtjgMsRfBQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5tQJzsl/GsGoaVb0"
Content-Disposition: inline
In-Reply-To: <CAFLszTiRJnhuV1YPSbO8=0FNOR-D7wr64V2bvL1xtjgMsRfBQQ@mail.gmail.com>
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


--5tQJzsl/GsGoaVb0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 03, 2024 at 06:45:32AM -0700, Simon Glass wrote:
> Hi Sughosh,
>=20
> On Tue, 3 Dec 2024 at 06:13, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > On Tue, 3 Dec 2024 at 18:22, Sughosh Ganu <sughosh.ganu@linaro.org> wro=
te:
> > >
> > > On Tue, 3 Dec 2024 at 18:11, Heinrich Schuchardt <xypron.glpk@gmx.de>=
 wrote:
> > > >
> > > > On 03.12.24 13:06, Sughosh Ganu wrote:
> > > > > On Sun, 1 Dec 2024 at 20:58, Simon Glass <sjg@chromium.org> wrote:
> > > > >>
> > > > >> The EFI_LOADER_BOUNCE_BUFFER feature was added many years ago. I=
t is
> > > > >> still needed and 24 boards (lx2160ardb_tfa_stmm,
> > > > >> lx2162aqds_tfa_SECURE_BOOT and the like) use it.
> > > > >>
> > > > >> This feature uses EFI page allocation to create a 64MB buffer 'i=
n space'
> > > > >> without any knowledge of where boards intend to load their image=
s. This
> > > > >> may result in image corruption or other problems.
> > > > >>
> > > > >> For example, if the feature is enabled on qemu_arm64 it puts the=
 EFI
> > > > >> bounce buffer at 1045MB, with the kernel at 1028MB and the ramdi=
sk at
> > > > >> 1088MB. The kernel is probably smaller than 27MB but the buffer =
does
> > > > >> overlap the ramdisk.
> > > > >>
> > > > >> The solution is probably to use BOUNCE_BUFFER instead, with the =
EFI
> > > > >> version being dropped. For now, show the address of the EFI boun=
ce
> > > > >> buffer so people have a better chance to debug any problem.
> > > > >>
> > > > >> Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > >> ---
> > > > >> In response to questions on how to show this problem:
> > > > >>
> > > > >> First, add CONFIG_EFI_LOADER_BOUNCE_BUFFER=3Dy to
> > > > >> configs/qemu_arm64_defconfig and build
> > > > >>
> > > > >> Then, to run:
> > > > >> qemu-system-aarch64 -machine virt -nographic -cpu cortex-a57 \
> > > > >>     -bios u-boot.bin
> > > > >>
> > > > >> U-Boot 2024.10-00809-gae29e5f76e4a-dirty (Oct 11 2024 - 11:48:46=
 -0600)
> > > > >>
> > > > >> DRAM:  128 MiB
> > > > >> Core:  51 devices, 14 uclasses, devicetree: board
> > > > >> Flash: 64 MiB
> > > > >> Loading Environment from Flash... *** Warning - bad CRC, using d=
efault environment
> > > > >>
> > > > >> In:    serial,usbkbd
> > > > >> Out:   serial,vidconsole
> > > > >> Err:   serial,vidconsole
> > > > >> No USB controllers found
> > > > >> Net:   eth0: virtio-net#32
> > > > >>
> > > > >> starting USB...
> > > > >> No USB controllers found
> > > > >> Hit any key to stop autoboot:  0
> > > > >> =3D> bootefi hello
> > > > >> Enabling coop memory
> > > > >> No EFI system partition
> > > > >> No EFI system partition
> > > > >> Failed to persist EFI variables
> > > > >> Missing TPMv2 device for EFI_TCG_PROTOCOL
> > > > >> Missing RNG device for EFI_RNG_PROTOCOL
> > > > >> Warning: EFI bounce buffer 000000004157f000-000000004557f000
> > > > >> Not loaded from disk
> > > > >> Booting /MemoryMapped(0x0,0x47763730,0x31b0)
> > > > >> EFI: Call: efi_load_image(false, efi_root, file_path, source_buf=
fer, source_size, &handle)
> > > > >> EFI: 0 returned by efi_load_image(false, efi_root, file_path, so=
urce_buffer, source_size, &handle)
> > > > >> Hello, world!
> > > > >> Running on UEFI 2.10
> > > > >> Firmware vendor: Das U-Boot
> > > > >> Firmware revision: 20241000
> > > > >> Have device tree
> > > > >> Load options: <none>
> > > > >> File path: <none>
> > > > >> Boot device: /MemoryMapped(0x0,0x47763730,0x31b0)
> > > > >> =3D> print kernel_addr_r
> > > > >> kernel_addr_r=3D0x40400000
> > > > >> =3D> print ramdisk_addr_r
> > > > >> ramdisk_addr_r=3D0x44000000
> > > > >> =3D>
> > > > >>
> > > > >> The EFI bounce buffer overlaps with the ramdisk.
> > > > >
> > > > > Why can't we "allocate" sane values for the env variables in ques=
tion,
> > > > > similar to what is being done for the apple and qcom boards -- yo=
u can
> > > > > refer to arch/arm/mach-apple/board.c:board_late_init(). We won't =
be
> > > > > facing these issues then. Eventually, there can be a common, plat=
form
> > > > > agnostic function to initialise these values. So, just as a PoC, I
> > > > > added this code to the qemu-arm.c, and no longer observe any over=
laps.
> > > > >
> > > > > diff --git a/board/emulation/qemu-arm/qemu-arm.c
> > > > > b/board/emulation/qemu-arm/qemu-arm.c
> > > > > index 6095cb02b23..bad787f7a65 100644
> > > > > --- a/board/emulation/qemu-arm/qemu-arm.c
> > > > > +++ b/board/emulation/qemu-arm/qemu-arm.c
> > > > > @@ -109,6 +109,9 @@ int board_init(void)
> > > > >
> > > > >   int board_late_init(void)
> > > > >   {
> > > > > +
> > > > > +       u32 status =3D 0;
> > > > > +
> > > > >          /*
> > > > >           * Make sure virtio bus is enumerated so that peripherals
> > > > >           * on the virtio bus can be discovered by their drivers
> > > > > @@ -119,6 +122,14 @@ int board_late_init(void)
> > > > >          if (CONFIG_IS_ENABLED(USB_KEYBOARD))
> > > > >                  usb_init();
> > > > >
> > > > > +       status |=3D env_set_hex("loadaddr", lmb_alloc(SZ_2M, SZ_2=
M));
> > > > > +       status |=3D env_set_hex("fdt_addr_r", lmb_alloc(SZ_2M, SZ=
_2M));
> > > > > +       status |=3D env_set_hex("kernel_addr_r", lmb_alloc(SZ_2M,=
 SZ_2M));
> > > > > +       status |=3D env_set_hex("ramdisk_addr_r", lmb_alloc(SZ_8M=
, SZ_2M));
> > > >
> > > > Hello Sughosh,
> > > >
> > > > avoiding fixed addresses would make sense for most boards.
> > > >
> > > > Your suggested memory reservations for the kernel and initrd are wa=
y too
> > > > small. On my system I find
> > > >
> > > > decompressed kernel - 67 MiB
> > > > initrd - 77 MiB
> > > >
> > > > scriptaddr is missing.
> > > >
> > > > ARM have address restrictions (see function efi_get_max_initrd_addr=
()):
> > > >
> > > > armv7:
> > > > max_init_rd_addr =3D
> > > > round_down(image_addr, SZ_4M) + SZ_512M
> > > >
> > > > armv8:
> > > > #define VA_BITS_MIN          (48)
> > > > max_init_rd_addr =3D
> > > > round_down(image_addr, SZ_1G) + (1UL << (VA_BITS_MIN - 1))
> > > >
> > > > These are not modeled in your suggestion.
> > > >
> > > > I would suggest to make a single <=3D 512 MiB allocation for both i=
nitrd
> > > > and kernel to keep both together and then assign the addresses in t=
he
> > > > allocated area, e.g.
> > > >
> > > > kerneladdr =3D lmb_alloc(SZ_512M, SZ_4M);
> > > > if (!kerneladdr)
> > > >         goto err;
> > > > if (env_set_hex("kernel_addr_r", kerneladdr))
> > > >         goto err;
> > > > if (env_set_hex("initrd_addr_r", kerneladdr + SZ_256M))
> > > >         goto err;
> > >
> > > Yes, I simply wanted to illustrate here that there would not be an
> > > issue of overlaps if we used the lmb API's to get memory addresses. In
> > > fact, this logic that you have pasted above can be added through the
> > > reserve event function that Simon is introducing in this series -- one
> > > of the functions can reserve memory for all these env variables. I
> > > don't see the need to allocate some separate memory region for EFI
> > > though. Thanks.
> >
> > Although the size of the allocation might have to be controlled
> > through a config symbol, or computed at runtime, based on the size of
> > RAM. Not all platforms might have the same amount of memory.
> >
>=20
> We can use the size of the image we are loading, when known. When not

Please note that the size of what we're loading alone is not enough. The
common case of "execute it right there" means needing to look at the
header to see how much space BSS needs too. Happily "Image" formatted
images have this information now and we're not quite as stuck as we were
in older times.

> known (e.g. some tftp servers) we can set an address above the others
> we have used, so it can grow, then adjust the top once we know the
> size.
>=20
> But all of this is in the future, since a lot of boards are not using
> bootstd and we have to respect their env vars. The latest set of
> boards to move is sunxi, which is blocked in Tom's tree.

Yes, sunxi moving to bootstd is blocked in mainline because it's not
ready yet as it doesn't support all of the use cases sunxi has and no
one has implemented what was agreed on as the path forward there.

--=20
Tom

--5tQJzsl/GsGoaVb0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdPDjwACgkQFHw5/5Y0
tywTjAv/RigHj3eQ70pAqhxdzmn9haU2oYYCogPoc1Ed5/yA6yFJ4By5q+SfGQTC
Qb44mya78pmuggGpzj/5Y/UOPnCTIg3735BFvnRX7W5OMfNL8oBhQo6MPo1A3AQI
PUw3QMULN6TqVJ3uarUnRR0IeVnrvVSTU2vpbeLyp6f05/JrjEL9NDb3rj/Y5D81
ioHgviMKqas1N47zoqtxpJiGLMBAL7fYxq1439JvQmf+anDK0G2X73j6v9XyJhO5
91l4bDGITbMpYpf/GCTyd3R1/wjT8fVYSaNasT7tkKN4m3QugVpQuKmfQOr3s9RE
vIj+S+JWyMJ96dKY4S4MUfmlhTBAkrv3iNEkyaZJPDdmpftRfDGGS55UUmPEThwJ
ErSbQFHHtQSfALjEwLW9EQd2ie6PMhkMjIgTSoUeLQqwwd/xvS2n5J9JtUyGazWU
4uPlTzg5viF8DFV14z/tgw5odKpx8AdfjEqc+gBGWQkY+3Sm4zSzPYWy9NmWDRjv
g8kDIpJb
=1z22
-----END PGP SIGNATURE-----

--5tQJzsl/GsGoaVb0--
