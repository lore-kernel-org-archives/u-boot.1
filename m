Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40739E64AA9
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 13:45:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9F8789588;
	Tue,  3 Dec 2024 14:45:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Unrd/VVb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D356989328; Tue,  3 Dec 2024 14:45:46 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 991AE88E35
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 14:45:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-53de771c5ebso6521872e87.2
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 05:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733233544; x=1733838344; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZfzB5Am91IFmIm1GmZHAlEi9ZLwxTyoYf/gtPvZ60QA=;
 b=Unrd/VVbsajaNoErYURB2lwjBJHlqGKpB6JE5AV8rw3FAPCS7I7CVYyH37aVzn1WsI
 wxILxn+8YkutRsxRH6uGUQQIAKSMcsWI1BTr5wGLHDWIfqiRXfWYDBGS1DkwC/1P2V0u
 PIIOS1QjtS0YyVCciB0aZT3n6LhPczhoguaTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733233544; x=1733838344;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZfzB5Am91IFmIm1GmZHAlEi9ZLwxTyoYf/gtPvZ60QA=;
 b=MXfxhKiQ+XSF7Hbgx3XIXNwq9bPdulufdc1LkyAqODR9ruNg+LOhoGVv1Ny9dzF1mp
 MrguGKNy07eLIK0ZHMeoqQ2uPA59kcvziBW4zX9dlDYZcqyNwD3sRbDijNNDFj2zWggl
 Bmwsoy35M9ioC7K9mwHNNE745GbPVxziAHgWCdU3wUwGdalvmCCm2Y36yMvnTpMEi855
 Rml0WekoZnzMoFdWnUP5Xvm1yfPKR2eTkLiPH2dwSQSQgsHrt9g96vK4H8tP6QmvFuxt
 n52hrKjMgetJgeNEqwysU48n23+J+g5gC4z4Y96yDxs7Ooln1FWrvw4kT9oa6vgt9re9
 gEmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGOf6LqXZYpg/og0TD6OMnd0RisF1AJEAzY/xYiqvju3EyGanQAgwinb6LHL9CIRobqm6xd8k=@lists.denx.de
X-Gm-Message-State: AOJu0Yxtk/BiXcf0ud2/YjpZ426BczqlgN1tmnRA37kC0pHypntJaR3F
 IEqhf/RN4aLJS63cHFeQsiKarRerjoAuMjKFpcZwIoMHc0ZNR7Tfo616/RUDT919A6ULznJMNaI
 Z/O1Mv9qsixJ6X4u17FgROdbG4mJq170n9z/o
X-Gm-Gg: ASbGncuQrny/eGeaABgoR/OMcSSRTrR650lf/Q2kQNay92DA04TjCTP3DjGX9o+PnNI
 ZDXaAzDiRomRjIJ8Tr9I97RKAl5/KWlzH
X-Google-Smtp-Source: AGHT+IHoirZm2lBMFewlTqZ6+I4C63aazHDuD3ET+idptXZtrvFtU4EsTIsgOQLRGR/aNSqWNptajRJZq2Vl2tBkjzY=
X-Received: by 2002:a05:6512:12cd:b0:53d:ea1d:50fc with SMTP id
 2adb3069b0e04-53e12a28351mr1665296e87.48.1733233543720; Tue, 03 Dec 2024
 05:45:43 -0800 (PST)
MIME-Version: 1.0
References: <20241201152815.1668093-1-sjg@chromium.org>
 <20241201152815.1668093-7-sjg@chromium.org>
 <CADg8p946omqMf9QAzwU_Aa6wbPFkfO3sUpAWebn1DraUoN7rUQ@mail.gmail.com>
 <b5a14d41-587d-45fd-a1d7-a02ed09eab5b@gmx.de>
 <CADg8p96f_Wdb-T688QpeaEPXec6AYQwTTj-g18L-XXZk5QTzUA@mail.gmail.com>
 <CADg8p96_QYnVvbQH+YTimOrcgqOsdRinTMgDCXGeky8tmgPwMw@mail.gmail.com>
In-Reply-To: <CADg8p96_QYnVvbQH+YTimOrcgqOsdRinTMgDCXGeky8tmgPwMw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 3 Dec 2024 06:45:32 -0700
Message-ID: <CAFLszTiRJnhuV1YPSbO8=0FNOR-D7wr64V2bvL1xtjgMsRfBQQ@mail.gmail.com>
Subject: Re: [PATCH v5 6/9] efi: Show the location of the bounce buffer when
 debugging
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Moritz Fischer <moritzf@google.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Sughosh,

On Tue, 3 Dec 2024 at 06:13, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Tue, 3 Dec 2024 at 18:22, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > On Tue, 3 Dec 2024 at 18:11, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > >
> > > On 03.12.24 13:06, Sughosh Ganu wrote:
> > > > On Sun, 1 Dec 2024 at 20:58, Simon Glass <sjg@chromium.org> wrote:
> > > >>
> > > >> The EFI_LOADER_BOUNCE_BUFFER feature was added many years ago. It is
> > > >> still needed and 24 boards (lx2160ardb_tfa_stmm,
> > > >> lx2162aqds_tfa_SECURE_BOOT and the like) use it.
> > > >>
> > > >> This feature uses EFI page allocation to create a 64MB buffer 'in space'
> > > >> without any knowledge of where boards intend to load their images. This
> > > >> may result in image corruption or other problems.
> > > >>
> > > >> For example, if the feature is enabled on qemu_arm64 it puts the EFI
> > > >> bounce buffer at 1045MB, with the kernel at 1028MB and the ramdisk at
> > > >> 1088MB. The kernel is probably smaller than 27MB but the buffer does
> > > >> overlap the ramdisk.
> > > >>
> > > >> The solution is probably to use BOUNCE_BUFFER instead, with the EFI
> > > >> version being dropped. For now, show the address of the EFI bounce
> > > >> buffer so people have a better chance to debug any problem.
> > > >>
> > > >> Signed-off-by: Simon Glass <sjg@chromium.org>
> > > >> ---
> > > >> In response to questions on how to show this problem:
> > > >>
> > > >> First, add CONFIG_EFI_LOADER_BOUNCE_BUFFER=y to
> > > >> configs/qemu_arm64_defconfig and build
> > > >>
> > > >> Then, to run:
> > > >> qemu-system-aarch64 -machine virt -nographic -cpu cortex-a57 \
> > > >>     -bios u-boot.bin
> > > >>
> > > >> U-Boot 2024.10-00809-gae29e5f76e4a-dirty (Oct 11 2024 - 11:48:46 -0600)
> > > >>
> > > >> DRAM:  128 MiB
> > > >> Core:  51 devices, 14 uclasses, devicetree: board
> > > >> Flash: 64 MiB
> > > >> Loading Environment from Flash... *** Warning - bad CRC, using default environment
> > > >>
> > > >> In:    serial,usbkbd
> > > >> Out:   serial,vidconsole
> > > >> Err:   serial,vidconsole
> > > >> No USB controllers found
> > > >> Net:   eth0: virtio-net#32
> > > >>
> > > >> starting USB...
> > > >> No USB controllers found
> > > >> Hit any key to stop autoboot:  0
> > > >> => bootefi hello
> > > >> Enabling coop memory
> > > >> No EFI system partition
> > > >> No EFI system partition
> > > >> Failed to persist EFI variables
> > > >> Missing TPMv2 device for EFI_TCG_PROTOCOL
> > > >> Missing RNG device for EFI_RNG_PROTOCOL
> > > >> Warning: EFI bounce buffer 000000004157f000-000000004557f000
> > > >> Not loaded from disk
> > > >> Booting /MemoryMapped(0x0,0x47763730,0x31b0)
> > > >> EFI: Call: efi_load_image(false, efi_root, file_path, source_buffer, source_size, &handle)
> > > >> EFI: 0 returned by efi_load_image(false, efi_root, file_path, source_buffer, source_size, &handle)
> > > >> Hello, world!
> > > >> Running on UEFI 2.10
> > > >> Firmware vendor: Das U-Boot
> > > >> Firmware revision: 20241000
> > > >> Have device tree
> > > >> Load options: <none>
> > > >> File path: <none>
> > > >> Boot device: /MemoryMapped(0x0,0x47763730,0x31b0)
> > > >> => print kernel_addr_r
> > > >> kernel_addr_r=0x40400000
> > > >> => print ramdisk_addr_r
> > > >> ramdisk_addr_r=0x44000000
> > > >> =>
> > > >>
> > > >> The EFI bounce buffer overlaps with the ramdisk.
> > > >
> > > > Why can't we "allocate" sane values for the env variables in question,
> > > > similar to what is being done for the apple and qcom boards -- you can
> > > > refer to arch/arm/mach-apple/board.c:board_late_init(). We won't be
> > > > facing these issues then. Eventually, there can be a common, platform
> > > > agnostic function to initialise these values. So, just as a PoC, I
> > > > added this code to the qemu-arm.c, and no longer observe any overlaps.
> > > >
> > > > diff --git a/board/emulation/qemu-arm/qemu-arm.c
> > > > b/board/emulation/qemu-arm/qemu-arm.c
> > > > index 6095cb02b23..bad787f7a65 100644
> > > > --- a/board/emulation/qemu-arm/qemu-arm.c
> > > > +++ b/board/emulation/qemu-arm/qemu-arm.c
> > > > @@ -109,6 +109,9 @@ int board_init(void)
> > > >
> > > >   int board_late_init(void)
> > > >   {
> > > > +
> > > > +       u32 status = 0;
> > > > +
> > > >          /*
> > > >           * Make sure virtio bus is enumerated so that peripherals
> > > >           * on the virtio bus can be discovered by their drivers
> > > > @@ -119,6 +122,14 @@ int board_late_init(void)
> > > >          if (CONFIG_IS_ENABLED(USB_KEYBOARD))
> > > >                  usb_init();
> > > >
> > > > +       status |= env_set_hex("loadaddr", lmb_alloc(SZ_2M, SZ_2M));
> > > > +       status |= env_set_hex("fdt_addr_r", lmb_alloc(SZ_2M, SZ_2M));
> > > > +       status |= env_set_hex("kernel_addr_r", lmb_alloc(SZ_2M, SZ_2M));
> > > > +       status |= env_set_hex("ramdisk_addr_r", lmb_alloc(SZ_8M, SZ_2M));
> > >
> > > Hello Sughosh,
> > >
> > > avoiding fixed addresses would make sense for most boards.
> > >
> > > Your suggested memory reservations for the kernel and initrd are way too
> > > small. On my system I find
> > >
> > > decompressed kernel - 67 MiB
> > > initrd - 77 MiB
> > >
> > > scriptaddr is missing.
> > >
> > > ARM have address restrictions (see function efi_get_max_initrd_addr()):
> > >
> > > armv7:
> > > max_init_rd_addr =
> > > round_down(image_addr, SZ_4M) + SZ_512M
> > >
> > > armv8:
> > > #define VA_BITS_MIN          (48)
> > > max_init_rd_addr =
> > > round_down(image_addr, SZ_1G) + (1UL << (VA_BITS_MIN - 1))
> > >
> > > These are not modeled in your suggestion.
> > >
> > > I would suggest to make a single <= 512 MiB allocation for both initrd
> > > and kernel to keep both together and then assign the addresses in the
> > > allocated area, e.g.
> > >
> > > kerneladdr = lmb_alloc(SZ_512M, SZ_4M);
> > > if (!kerneladdr)
> > >         goto err;
> > > if (env_set_hex("kernel_addr_r", kerneladdr))
> > >         goto err;
> > > if (env_set_hex("initrd_addr_r", kerneladdr + SZ_256M))
> > >         goto err;
> >
> > Yes, I simply wanted to illustrate here that there would not be an
> > issue of overlaps if we used the lmb API's to get memory addresses. In
> > fact, this logic that you have pasted above can be added through the
> > reserve event function that Simon is introducing in this series -- one
> > of the functions can reserve memory for all these env variables. I
> > don't see the need to allocate some separate memory region for EFI
> > though. Thanks.
>
> Although the size of the allocation might have to be controlled
> through a config symbol, or computed at runtime, based on the size of
> RAM. Not all platforms might have the same amount of memory.
>

We can use the size of the image we are loading, when known. When not
known (e.g. some tftp servers) we can set an address above the others
we have used, so it can grow, then adjust the top once we know the
size.

But all of this is in the future, since a lot of boards are not using
bootstd and we have to respect their env vars. The latest set of
boards to move is sunxi, which is blocked in Tom's tree.

Regards,
Simon
