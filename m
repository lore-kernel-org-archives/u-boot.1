Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B23BBD18151
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 21:45:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27F7C891E0;
	Mon, 14 Oct 2024 23:45:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FLAsMD9O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADB75891C1; Mon, 14 Oct 2024 23:45:03 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47BE2890D4
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 23:45:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6cb97afcec9so41689576d6.2
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 14:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728942300; x=1729547100; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MdRC7IzqbRUzYV/MDonmeFdsgpHRA7xFGnQUqGH6SfA=;
 b=FLAsMD9OMiYQHft1zeBMIkkvGMQiw8x4AN8yv5uvygFjTNXbTR1+pzOCFee/EkUmWm
 sl3Zk7uu5oH1o9TBn7MEMXgeRttpjBWgTqApedPBD1Nc1U+X43N4JEid8ecnGWjBxD6L
 +IbbPSVcXdNY2DPD25gdG8VTldB7uZ5Spfzjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728942300; x=1729547100;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MdRC7IzqbRUzYV/MDonmeFdsgpHRA7xFGnQUqGH6SfA=;
 b=YDhWjUfkl35GYcyM9cbDxlha/BbloxlIEFOUu4VePNqsT1FEXcWuTxK/exqBIIXdOx
 LwfOLFJScY5uLSs4Gblw4FIgaOCjRFGbfyOlOibhPw4AqtfFUnFECQMiLBardPHGgllm
 EsM0Qqy49goAy6uBMgZd3yONIjqAtzQxGgLo/6YNlw8r8egfVqDHYOTr7+LB0ZfcDh6H
 bTguftKp8KXsulFjWgbB8y+OqUgG+MPWhq7isE+f3hHNoMWiZMYB/NIJILY9ykAJcgSi
 5amBSFffSESZFAz/Pwjgr37bIq61W2oM42DgJ2SRBInaEmUnAvmPjTtwWd84s0QLC/Ty
 U7MQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+e+2VyjnfZ+nR+81O/vwgkrs7G7mTz6Bjlpty28eNW11qZsO+Ow+uy2Y426taiueyp9UtUEc=@lists.denx.de
X-Gm-Message-State: AOJu0YzdrGDg0+3j+VNNBtuqlsNbShzpOvusuKX5qjITWLylrMRrPeOH
 FCZGWms5A5ZOPtMlJQblTwHco/qtCZD3+K+VEcO30VRWkMczeclUmuHwa2iU42I=
X-Google-Smtp-Source: AGHT+IGRBZ/DGl76I41fC57uNeWaRuVhLbhp9gDOXm88xdBW+fyYGmyZV/4gnmWHegt9MhDA+O1AFQ==
X-Received: by 2002:a05:6214:5c07:b0:6cb:ee08:c1e8 with SMTP id
 6a1803df08f44-6cbeff61ed6mr218128206d6.23.1728942300182; 
 Mon, 14 Oct 2024 14:45:00 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cbe8679a66sm49514536d6.141.2024.10.14.14.44.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 14:44:59 -0700 (PDT)
Date: Mon, 14 Oct 2024 15:44:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>
Subject: Re: [PATCH v4 2/5] efi: Show the location of the bounce buffer when
 debugging
Message-ID: <20241014214455.GC53053@bill-the-cat>
References: <20241011212126.747741-1-sjg@chromium.org>
 <20241011212126.747741-3-sjg@chromium.org>
 <A51D5AB2-A3A6-44E9-BE35-45B79081EB9E@gmx.de>
 <CAFLszTinmXQ-O5PKR2ZREeipYi4q-3fyYykBp5aMr0dAh_nV1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2KJIUtXeN/czGysk"
Content-Disposition: inline
In-Reply-To: <CAFLszTinmXQ-O5PKR2ZREeipYi4q-3fyYykBp5aMr0dAh_nV1g@mail.gmail.com>
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


--2KJIUtXeN/czGysk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 02:20:09PM -0600, Simon Glass wrote:
> Hi Heinrich,
>=20
> On Fri, 11 Oct 2024 at 16:02, Heinrich Schuchardt <xypron.glpk@gmx.de> wr=
ote:
> >
> >
> >
> > Am 11. Oktober 2024 23:21:23 MESZ schrieb Simon Glass <sjg@chromium.org=
>:
> > >The EFI_LOADER_BOUNCE_BUFFER feature was added many years ago. It is
> > >still needed and 24 boards (lx2160ardb_tfa_stmm,
> > >lx2162aqds_tfa_SECURE_BOOT and the like) use it.
> > >
> > >This feature uses EFI page allocation to create a 64MB buffer 'in spac=
e'
> > >without any knowledge of where boards intend to load their images. This
> > >may result in image corruption or other problems.
> > >
> > >For example, if the feature is enabled on qemu_arm64 it puts the EFI
> > >bounce buffer at 1045MB, with the kernel at 1028MB and the ramdisk at
> > >1088MB. The kernel is probably smaller than 27MB but the buffer does
> > >overlap the ramdisk.
> > >
> > >The solution is probably to use BOUNCE_BUFFER instead, with the EFI
> > >version being dropped. For now, show the address of the EFI bounce
> > >buffer so people have a better chance to debug any problem.
> > >
> > >Signed-off-by: Simon Glass <sjg@chromium.org>
> > >---
> > >In response to questions on how to show this problem:
> > >
> > >First, add CONFIG_EFI_LOADER_BOUNCE_BUFFER=3Dy to
> > >configs/qemu_arm64_defconfig and build
> > >
> > >Then, to run:
> > >qemu-system-aarch64 -machine virt -nographic -cpu cortex-a57 \
> > >   -bios u-boot.bin
> > >
> > >U-Boot 2024.10-00809-gae29e5f76e4a-dirty (Oct 11 2024 - 11:48:46 -0600)
> > >
> > >DRAM:  128 MiB
> > >Core:  51 devices, 14 uclasses, devicetree: board
> > >Flash: 64 MiB
> > >Loading Environment from Flash... *** Warning - bad CRC, using default=
 environment
> > >
> > >In:    serial,usbkbd
> > >Out:   serial,vidconsole
> > >Err:   serial,vidconsole
> > >No USB controllers found
> > >Net:   eth0: virtio-net#32
> > >
> > >starting USB...
> > >No USB controllers found
> > >Hit any key to stop autoboot:  0
> > >=3D> bootefi hello
> > >Enabling coop memory
> > >No EFI system partition
> > >No EFI system partition
> > >Failed to persist EFI variables
> > >Missing TPMv2 device for EFI_TCG_PROTOCOL
> > >Missing RNG device for EFI_RNG_PROTOCOL
> > >Warning: EFI bounce buffer 000000004157f000-000000004557f000
> > >Not loaded from disk
> > >Booting /MemoryMapped(0x0,0x47763730,0x31b0)
> > >EFI: Call: efi_load_image(false, efi_root, file_path, source_buffer, s=
ource_size, &handle)
> > >EFI: 0 returned by efi_load_image(false, efi_root, file_path, source_b=
uffer, source_size, &handle)
> > >Hello, world!
> > >Running on UEFI 2.10
> > >Firmware vendor: Das U-Boot
> > >Firmware revision: 20241000
> > >Have device tree
> > >Load options: <none>
> > >File path: <none>
> > >Boot device: /MemoryMapped(0x0,0x47763730,0x31b0)
> > >=3D> print kernel_addr_r
> > >kernel_addr_r=3D0x40400000
> > >=3D> print ramdisk_addr_r
> > >ramdisk_addr_r=3D0x44000000
> > >=3D>
> > >
> > >The EFI bounce buffer overlaps with the ramdisk.
> > >
> > >Changes in v4:
> > >- Reword the commit message since this feature is needed
> > >
> > > lib/efi_loader/efi_bootbin.c | 9 +++++++++
> > > 1 file changed, 9 insertions(+)
> > >
> > >diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin=
=2Ec
> > >index a87006b3c0e..eefdd660cee 100644
> > >--- a/lib/efi_loader/efi_bootbin.c
> > >+++ b/lib/efi_loader/efi_bootbin.c
> > >@@ -209,6 +209,15 @@ efi_status_t efi_binary_run(void *image, size_t s=
ize, void *fdt)
> > >               return -1;
> > >       }
> > >
> > >+#ifdef CONFIG_EFI_LOADER_BOUNCE_BUFFER
> > >+      /*
> > >+       * Add a warning about this buffer, since it may conflict with =
other
> > >+       * things
> > >+       */
> > >+      log_debug("Warning: EFI bounce buffer %p-%p\n", efi_bounce_buff=
er,
> > >+                efi_bounce_buffer + EFI_LOADER_BOUNCE_BUFFER_SIZE);
> > >+#endif
> >
> > Adding a debug message here is ok.
> >
> > But writing "warning" in a debug message which is just printing an addr=
ess for a configuration selected item looks weird to me.
>=20
> I added that because you said it needed to say it was a warning. I'll
> remove it and try again.

Since we talked about it on IRC, the most useful option here would be
instead to switch this to the regular CONFIG_BOUNCE_BUFFER code so that
it can go away entirely. The second most useful option is yes, we can
put a debug message for when someone enables "make a hole in memory for
me" when they do not need that hole made in memory.

--=20
Tom

--2KJIUtXeN/czGysk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcNkNcACgkQFHw5/5Y0
tyzi/Av6ApgzBxAyJqqsqklWQxFQGZgY5UxaFPMzTvYE9Uzb4UlGFjP4uUKxcqKO
ef2xwmhCklgV/P20Md6K2k007s+wKhVqiGZCYsfa6V4gwfYriOKNnEjHiVR0dnnf
F6LDRam5F5N110zC44S8xcXM6Cu+of96XJXuoPJI5fChfqeeZzd3r++YJP5VZWuH
xYMh8w+wAHC7O3NgEDwhSYVQsLsHdmCiawtDLtro2aOlB4V/Gh6SlCfNrx3aeKs4
csewKuU8JFTIUHOBmWlbtOBOw/0kPYS+lNYXWp2cUAJoeVRQ7MsF4ymQ5i5+msaq
TAaCfhRRHwU6xWQtdpJjhr7TSlOY60RcJj0PIzS2jco+CKYzvfIfp0Wq0krEXEci
1lfJXyqY+JS+x9N1fTlqZgK+aM2h20+8S6EImnsXS5RUDWllc5CX1z6xs3suzxkE
6ZFiG0fpOTbGBWgnlhUw5ZCug77dSnW3dUk3kGk2HU17gyYvhiHD3NfI5gQeydFN
ZjqzjOMm
=ylwD
-----END PGP SIGNATURE-----

--2KJIUtXeN/czGysk--
