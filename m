Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 173A6E64A8B
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 13:13:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B4A888A3C;
	Tue,  3 Dec 2024 14:13:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BddU6xQO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5BA68939E; Tue,  3 Dec 2024 14:13:13 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72D1788875
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 14:13:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a9a977d6cc7so329106566b.3
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 05:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733231591; x=1733836391; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OTRiHacQoTPT+L4YqCfKyIaEl/5vpkM1xRA0Cl9rWM4=;
 b=BddU6xQOWDgqExihtlvluXcPMH6ox2HOLZp0XKU56hU/dtxIKrsNCtx411S+CCyVg7
 DjEjCTe0SSmbCvjXGObF5R6qBkJwjYooFkuAZ+TKNtULfHRGxRReZ7Q6V1S4iCVSoaoS
 /gl6D7cxM9XaajtkFNcUpCN9XRROHPMl5/es5Qd8WrPz2aOefDvfdcCAXqXnh/gXdYSQ
 oR0FZPtUCqtVNkKN9Eui4FC/FIK6TcF69CuK9A3j3Lx05lGZK1BGR651IeDwUlA88eg4
 GDRTScVpPs849eFwfgDhJbPUn2ZDqmTfYS1pX64Acu6Kai7pqC/t3PP7N01BiFBKzxBB
 GCmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733231591; x=1733836391;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OTRiHacQoTPT+L4YqCfKyIaEl/5vpkM1xRA0Cl9rWM4=;
 b=pTQDz7xIyH2AEzJflC2ctBF3myziQvfBYCzBd2s0lUhOIZjUf771ogWhQeoS1mtr6j
 dt6B1USsYqhjAtmraEvRPfiQX4KLEq5gON/QHBlTSJQgCJvAUSYgtTX75XE/LTbtLqGH
 vPKufABd4XuhDGRHVcvTFXm1Ukct6qiQb4vm2E//RN8jK8c1rvAwYZwK1soKRZT3ZGFz
 EL6JbJJq6yF4tbjrnGhJmsW4Xl8c66G3Krx4Fylv6pB2fxa4sTOZWxx96fbCn88l0AA9
 Gz41xsA7cV5qwZ9jU4ujpZjh8n7oiMim36ogf+glCPtn+5rmSK+4cvgUpasm89U2FDiG
 0niA==
X-Gm-Message-State: AOJu0YyA/BsCqktZyP1x6udH7RJ7+lGV0AtoisfYNwWPvZi8h5YwxWkO
 1eY+F9/DilX+TQkwlJSaVfNJbfzzZwlx1i10Z1uho4fhTlNZnzeAxq3bcOzeg5Lt7iy1J4vFHTZ
 2zAKu6zdLb1qZ1DZIszGtH5Qqa100FgBDI/+aKQ==
X-Gm-Gg: ASbGncudQ5jodX2RrOnR7tdCrM8wMOftpDCCVFn95UxaiPYGEZAqffVbeXn3iS0XDtI
 fw0kNfggK0L0y0pMBfC+b41wXWih7o+8f
X-Google-Smtp-Source: AGHT+IEYq0i+wZusrNg8oBJYavcTd+GD8Pl6qpNqzLamykUNGMKm3WTc83cgJYnDKaekQrHI7FH5WVozunUyPHsya5U=
X-Received: by 2002:a05:6402:34d4:b0:5cf:f361:1c11 with SMTP id
 4fb4d7f45d1cf-5d10cb5c7c7mr2405920a12.20.1733231590799; Tue, 03 Dec 2024
 05:13:10 -0800 (PST)
MIME-Version: 1.0
References: <20241201152815.1668093-1-sjg@chromium.org>
 <20241201152815.1668093-7-sjg@chromium.org>
 <CADg8p946omqMf9QAzwU_Aa6wbPFkfO3sUpAWebn1DraUoN7rUQ@mail.gmail.com>
 <b5a14d41-587d-45fd-a1d7-a02ed09eab5b@gmx.de>
 <CADg8p96f_Wdb-T688QpeaEPXec6AYQwTTj-g18L-XXZk5QTzUA@mail.gmail.com>
In-Reply-To: <CADg8p96f_Wdb-T688QpeaEPXec6AYQwTTj-g18L-XXZk5QTzUA@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 3 Dec 2024 18:42:59 +0530
Message-ID: <CADg8p96_QYnVvbQH+YTimOrcgqOsdRinTMgDCXGeky8tmgPwMw@mail.gmail.com>
Subject: Re: [PATCH v5 6/9] efi: Show the location of the bounce buffer when
 debugging
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Moritz Fischer <moritzf@google.com>, Simon Glass <sjg@chromium.org>
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

On Tue, 3 Dec 2024 at 18:22, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Tue, 3 Dec 2024 at 18:11, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >
> > On 03.12.24 13:06, Sughosh Ganu wrote:
> > > On Sun, 1 Dec 2024 at 20:58, Simon Glass <sjg@chromium.org> wrote:
> > >>
> > >> The EFI_LOADER_BOUNCE_BUFFER feature was added many years ago. It is
> > >> still needed and 24 boards (lx2160ardb_tfa_stmm,
> > >> lx2162aqds_tfa_SECURE_BOOT and the like) use it.
> > >>
> > >> This feature uses EFI page allocation to create a 64MB buffer 'in space'
> > >> without any knowledge of where boards intend to load their images. This
> > >> may result in image corruption or other problems.
> > >>
> > >> For example, if the feature is enabled on qemu_arm64 it puts the EFI
> > >> bounce buffer at 1045MB, with the kernel at 1028MB and the ramdisk at
> > >> 1088MB. The kernel is probably smaller than 27MB but the buffer does
> > >> overlap the ramdisk.
> > >>
> > >> The solution is probably to use BOUNCE_BUFFER instead, with the EFI
> > >> version being dropped. For now, show the address of the EFI bounce
> > >> buffer so people have a better chance to debug any problem.
> > >>
> > >> Signed-off-by: Simon Glass <sjg@chromium.org>
> > >> ---
> > >> In response to questions on how to show this problem:
> > >>
> > >> First, add CONFIG_EFI_LOADER_BOUNCE_BUFFER=y to
> > >> configs/qemu_arm64_defconfig and build
> > >>
> > >> Then, to run:
> > >> qemu-system-aarch64 -machine virt -nographic -cpu cortex-a57 \
> > >>     -bios u-boot.bin
> > >>
> > >> U-Boot 2024.10-00809-gae29e5f76e4a-dirty (Oct 11 2024 - 11:48:46 -0600)
> > >>
> > >> DRAM:  128 MiB
> > >> Core:  51 devices, 14 uclasses, devicetree: board
> > >> Flash: 64 MiB
> > >> Loading Environment from Flash... *** Warning - bad CRC, using default environment
> > >>
> > >> In:    serial,usbkbd
> > >> Out:   serial,vidconsole
> > >> Err:   serial,vidconsole
> > >> No USB controllers found
> > >> Net:   eth0: virtio-net#32
> > >>
> > >> starting USB...
> > >> No USB controllers found
> > >> Hit any key to stop autoboot:  0
> > >> => bootefi hello
> > >> Enabling coop memory
> > >> No EFI system partition
> > >> No EFI system partition
> > >> Failed to persist EFI variables
> > >> Missing TPMv2 device for EFI_TCG_PROTOCOL
> > >> Missing RNG device for EFI_RNG_PROTOCOL
> > >> Warning: EFI bounce buffer 000000004157f000-000000004557f000
> > >> Not loaded from disk
> > >> Booting /MemoryMapped(0x0,0x47763730,0x31b0)
> > >> EFI: Call: efi_load_image(false, efi_root, file_path, source_buffer, source_size, &handle)
> > >> EFI: 0 returned by efi_load_image(false, efi_root, file_path, source_buffer, source_size, &handle)
> > >> Hello, world!
> > >> Running on UEFI 2.10
> > >> Firmware vendor: Das U-Boot
> > >> Firmware revision: 20241000
> > >> Have device tree
> > >> Load options: <none>
> > >> File path: <none>
> > >> Boot device: /MemoryMapped(0x0,0x47763730,0x31b0)
> > >> => print kernel_addr_r
> > >> kernel_addr_r=0x40400000
> > >> => print ramdisk_addr_r
> > >> ramdisk_addr_r=0x44000000
> > >> =>
> > >>
> > >> The EFI bounce buffer overlaps with the ramdisk.
> > >
> > > Why can't we "allocate" sane values for the env variables in question,
> > > similar to what is being done for the apple and qcom boards -- you can
> > > refer to arch/arm/mach-apple/board.c:board_late_init(). We won't be
> > > facing these issues then. Eventually, there can be a common, platform
> > > agnostic function to initialise these values. So, just as a PoC, I
> > > added this code to the qemu-arm.c, and no longer observe any overlaps.
> > >
> > > diff --git a/board/emulation/qemu-arm/qemu-arm.c
> > > b/board/emulation/qemu-arm/qemu-arm.c
> > > index 6095cb02b23..bad787f7a65 100644
> > > --- a/board/emulation/qemu-arm/qemu-arm.c
> > > +++ b/board/emulation/qemu-arm/qemu-arm.c
> > > @@ -109,6 +109,9 @@ int board_init(void)
> > >
> > >   int board_late_init(void)
> > >   {
> > > +
> > > +       u32 status = 0;
> > > +
> > >          /*
> > >           * Make sure virtio bus is enumerated so that peripherals
> > >           * on the virtio bus can be discovered by their drivers
> > > @@ -119,6 +122,14 @@ int board_late_init(void)
> > >          if (CONFIG_IS_ENABLED(USB_KEYBOARD))
> > >                  usb_init();
> > >
> > > +       status |= env_set_hex("loadaddr", lmb_alloc(SZ_2M, SZ_2M));
> > > +       status |= env_set_hex("fdt_addr_r", lmb_alloc(SZ_2M, SZ_2M));
> > > +       status |= env_set_hex("kernel_addr_r", lmb_alloc(SZ_2M, SZ_2M));
> > > +       status |= env_set_hex("ramdisk_addr_r", lmb_alloc(SZ_8M, SZ_2M));
> >
> > Hello Sughosh,
> >
> > avoiding fixed addresses would make sense for most boards.
> >
> > Your suggested memory reservations for the kernel and initrd are way too
> > small. On my system I find
> >
> > decompressed kernel - 67 MiB
> > initrd - 77 MiB
> >
> > scriptaddr is missing.
> >
> > ARM have address restrictions (see function efi_get_max_initrd_addr()):
> >
> > armv7:
> > max_init_rd_addr =
> > round_down(image_addr, SZ_4M) + SZ_512M
> >
> > armv8:
> > #define VA_BITS_MIN          (48)
> > max_init_rd_addr =
> > round_down(image_addr, SZ_1G) + (1UL << (VA_BITS_MIN - 1))
> >
> > These are not modeled in your suggestion.
> >
> > I would suggest to make a single <= 512 MiB allocation for both initrd
> > and kernel to keep both together and then assign the addresses in the
> > allocated area, e.g.
> >
> > kerneladdr = lmb_alloc(SZ_512M, SZ_4M);
> > if (!kerneladdr)
> >         goto err;
> > if (env_set_hex("kernel_addr_r", kerneladdr))
> >         goto err;
> > if (env_set_hex("initrd_addr_r", kerneladdr + SZ_256M))
> >         goto err;
>
> Yes, I simply wanted to illustrate here that there would not be an
> issue of overlaps if we used the lmb API's to get memory addresses. In
> fact, this logic that you have pasted above can be added through the
> reserve event function that Simon is introducing in this series -- one
> of the functions can reserve memory for all these env variables. I
> don't see the need to allocate some separate memory region for EFI
> though. Thanks.

Although the size of the allocation might have to be controlled
through a config symbol, or computed at runtime, based on the size of
RAM. Not all platforms might have the same amount of memory.

-sughosh
>
> -sughosh
>
> >
> > Best regards
> >
> > Heinrich
> >
> > > +
> > > +       if (status)
> > > +               log_warning("late_init: Failed to set run time variables\n");
> > > +
> > >          return 0;
> > >   }
> > >
> > >
> > > U-Boot 2025.01-rc3-00042-gacab6e78aca7-dirty (Dec 03 2024 - 17:17:42 +0530)
> > >
> > > DRAM:  512 MiB
> > > EFI bounce buffer 000000005957f000-000000005d57f000
> > > Core:  51 devices, 14 uclasses, devicetree: board
> > > Flash: 64 MiB
> > > Loading Environment from Flash... *** Warning - bad CRC, using default
> > > environment
> > >
> > > In:    serial,usbkbd
> > > Out:   serial,vidconsole
> > > Err:   serial,vidconsole
> > > No USB controllers found
> > > Net:   eth0: virtio-net#31
> > >
> > > starting USB...
> > > No USB controllers found
> > > Hit any key to stop autoboot:  0
> > >
> > > => bdinfo
> > >
> > > ...
> > >
> > > lmb_dump_all:
> > >   memory.count = 0x1
> > >   memory[0]    [0x40000000-0x5fffffff], 0x20000000 bytes, flags: none
> > >   reserved.count = 0x3
> > >   reserved[0]    [0x58600000-0x593fffff], 0xe00000 bytes, flags: none
> > >   reserved[1]    [0x5957c000-0x5d57efff], 0x4003000 bytes, flags:
> > > no-notify, no-overwrite
> > >   reserved[2]    [0x5d57fde0-0x5fffffff], 0x2a80220 bytes, flags: no-overwrite
> > >
> > > ...
> > >
> > > => printenv kernel_addr_r
> > > kernel_addr_r=58e00000
> > > => printenv ramdisk_addr_r
> > > ramdisk_addr_r=58600000
> > > => printenv fdt_addr_r
> > > fdt_addr_r=59000000
> > > => printenv loadaddr
> > > loadaddr=59200000
> > >
> > > -sughosh
> > >
> > >>
> > >> Changes in v5:
> > >> - Drop the word 'warning'
> > >>
> > >> Changes in v4:
> > >> - Reword the commit message since this feature is needed
> > >>
> > >>   lib/efi_loader/efi_bootbin.c | 9 +++++++++
> > >>   1 file changed, 9 insertions(+)
> > >>
> > >> diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> > >> index 7e7a6bf31aa..9a880251b47 100644
> > >> --- a/lib/efi_loader/efi_bootbin.c
> > >> +++ b/lib/efi_loader/efi_bootbin.c
> > >> @@ -208,6 +208,15 @@ efi_status_t efi_binary_run(void *image, size_t size, void *fdt)
> > >>                  return -1;
> > >>          }
> > >>
> > >> +#ifdef CONFIG_EFI_LOADER_BOUNCE_BUFFER
> > >> +       /*
> > >> +        * Add a warning about this buffer, since it may conflict with other
> > >> +        * things
> > >> +        */
> > >> +       log_debug("EFI bounce buffer %p-%p\n", efi_bounce_buffer,
> > >> +                 efi_bounce_buffer + EFI_LOADER_BOUNCE_BUFFER_SIZE);
> > >> +#endif
> > >> +
> > >>          ret = efi_install_fdt(fdt);
> > >>          if (ret != EFI_SUCCESS)
> > >>                  return ret;
> > >> --
> > >> 2.43.0
> > >>
> >
