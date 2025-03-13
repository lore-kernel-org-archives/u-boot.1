Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD19BC28B28
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 07:35:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6493980548;
	Thu, 13 Mar 2025 08:35:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vUnkJzYk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95BF480756; Thu, 13 Mar 2025 08:35:07 +0100 (CET)
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com
 [IPv6:2607:f8b0:4864:20::931])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E5D080540
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 08:35:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ua1-x931.google.com with SMTP id
 a1e0cc1a2514c-86d377306ddso294507241.2
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 00:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741851300; x=1742456100; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wsJ3wWxOBJUqi8T2wNbpIsrqGocca/qPtX/Yr5es8qA=;
 b=vUnkJzYkeJkzhV7sNXwOmC85Vt55dyZdifTDYRq6yFbhGsT0X2JM5nNPdG3K+YmsUj
 l9IHBlTWZKYsNipS5HKpRCVTJo7Pp3AZOtO5azA8vEX+fRakNbmpYyRMW0JfvwacWpnl
 c8oGeryKc6ZpW7TcNJzejNdvVUzmAEStUCxMNDA3BrrKuP75BwfBdUpslHVJdX2q90Vs
 xxotDfjyIYM73YFwBrsH1N2XcZj9DVx3tdtdlahNp2JCo/CyCR9i7GYbjHkdrAAeYzk5
 SRSbzeqSAfpQg/VLEXwhS7AG3/Epi7fqq3j1aPfpDakWfcLZeIFKQDo63sVNjIZ2srdt
 r6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741851300; x=1742456100;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wsJ3wWxOBJUqi8T2wNbpIsrqGocca/qPtX/Yr5es8qA=;
 b=FDXfN8sZaPw0NCUVNN3Egz5+uxW0ds2YzK3IykA6IjeGzEJmSqF0FhlWkqV//mDSCP
 8m3Ox5Nmrh3JVsAXBzf60XZaBsIptpPZE7q4DxKds42htRB17LTg9PkvZBQ/O2psqok5
 c3wYGW1vIM0+cvpvSuZt+VrwkWnndZQCD3hd+iXSHwyMM3vK6si37KdgqTCsVPg5MoH0
 /967lHmEpFTk1uiRWYh/33pTquU5BiKTW7T5JdbfLtytrN7FBdxVzDRVm3FLma2UbNmY
 THcd6gUN/xyfSytlviNL2Fom0AggsY8jiyrAahS9/MDi528oDoXnD7e6CCstt3Jvg3Ss
 HR8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVx24SiJBJumb9ClZA6mkycY7SeRBeCyDVTgalMP3VpbIXXuCWdvm8c5zx8ZvMoBLVdNBNdxHs=@lists.denx.de
X-Gm-Message-State: AOJu0YxHVp1uiVjLhcY3Dhosw5eL1YypYXu2HPVIRH6Ni4wwpyegcXqs
 1Ga60Ewot/aVRdmf2FCkqZjWgu1HXxLw5LReXezE3V9Hwe9/4Pq6GVhtXkkruKeSQDSCewrnlll
 bCLVU8tfEwWhuBMz6jwxG7Awd5DWvFyvuoygnJLc9RVE4nTMp
X-Gm-Gg: ASbGncu49vTTahCKZxDLF+hiasduQgLcJtNICHM+uxEwli8+yrlPfnphS+pW1M/OV+W
 zUick46Lbl8XcjyexABuXjWflUGgwxtM8/S3i4/3RpbSiOBqv/qLJFd2K54kTHjMv6dDqFjTu5S
 57U7XrFuPKRp93r4JMMjB6DaRZmivHVCW46beMnA==
X-Google-Smtp-Source: AGHT+IEPt79UlgOR4coVRxDi7fDYI6+pHPut3qcPtyN7UNRte9ZG9CCqfxUWbKsfs2blOZcEGMbkTR57iekzt7WgMJ0=
X-Received: by 2002:a05:6102:809c:b0:4c1:8f9b:19f1 with SMTP id
 ada2fe7eead31-4c30a5ab1c7mr19895114137.11.1741851299926; Thu, 13 Mar 2025
 00:34:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250312085424.1201148-1-sughosh.ganu@linaro.org>
 <20250312085424.1201148-6-sughosh.ganu@linaro.org>
 <60a1eccb-e4a1-4e38-b0d8-2e1693cb9abb@canonical.com>
In-Reply-To: <60a1eccb-e4a1-4e38-b0d8-2e1693cb9abb@canonical.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Thu, 13 Mar 2025 13:04:49 +0530
X-Gm-Features: AQ5f1JqLinlsREzE0IKQpzP4MC9Nfb7JuJgeitr3XJ9TXVN67afpoDhNSLqURSc
Message-ID: <CADg8p97xjNQG4G+xT1qpuZKkmU-XjuLw+JqQBneiYgOOcwz=HQ@mail.gmail.com>
Subject: Re: [PATCH v8 5/8] efi_loader: preserve installer images in pmem
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Anton Antonov <Anton.Antonov@arm.com>, 
 Tobias Waldekranz <tobias@waldekranz.com>, u-boot@lists.denx.de
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

On Thu, 13 Mar 2025 at 02:22, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 12.03.25 09:54, Sughosh Ganu wrote:
> > From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >
> > One of the problems OS installers face, when running in EFI, is that
> > the mounted ISO after calling ExitBootServices goes away. For some
> > distros this is a problem since they rely on finding some core packages
> > before continuing the installation. Distros have works around this --
> > e.g Fedora has a special kernel command line parameter called
> > inst.stage2 [0].
>
> The patch is about RAM disks and not about installers.

Okay, will try to not frame the commit message about installers.

>
> >
> > ACPI has NFIT and NVDIMM support to provide ramdisks to the OS, but we
> > don't have anything in place for DTs. Linux and device trees have support
> > for persistent memory devices.
> >
> > It's worth noting that for linux to instantiate the /dev/pmemX device,
> > the memory described in the pmem node has to be omitted from the EFI
> > memory map we hand over to the OS if ZONE_DEVICES and SPARSEMEM is
> > enabled. With those enabled the pmem driver ends up calling
> > devm_memremap_pages() instead of devm_memremap(). The latter works
> > whether the memory is omitted or marked as reserved, but mapping pages
> > only works if the memory is omitted.
> >
> > On top of that, depending on how the kernel is configured, that memory
> > area must be page aligned or 2MB aligned. PowerPC is an exception here
> > and requires 16MB alignment, but since we don't have EFI support for
> > it, limit the alignment to 2MB.
> >
> > Ensure that the ISO image is 2MB aligned and remove the region
> > occupied by the image from the EFI memory map.
> >
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> > Changes since V7: None
> >
> >   lib/efi_loader/efi_bootmgr.c | 22 +++++++++++++++++-----
> >   1 file changed, 17 insertions(+), 5 deletions(-)
> >
> > diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> > index c6124c590d9..081eff057f4 100644
> > --- a/lib/efi_loader/efi_bootmgr.c
> > +++ b/lib/efi_loader/efi_bootmgr.c
> > @@ -18,6 +18,8 @@
> >   #include <efi_loader.h>
> >   #include <efi_variable.h>
> >   #include <asm/unaligned.h>
> > +#include <linux/kernel.h>
> > +#include <linux/sizes.h>
> >
> >   static const struct efi_boot_services *bs;
> >   static const struct efi_runtime_services *rs;
> > @@ -362,13 +364,16 @@ static efi_status_t prepare_loaded_image(u16 *label, ulong addr, ulong size,
> >       }
> >
> >       /*
> > -      * TODO: expose the ramdisk to OS.
> > -      * Need to pass the ramdisk information by the architecture-specific
> > -      * methods such as 'pmem' device-tree node.
> > +      * Linux supports 'pmem' which allows OS installers to find, reclaim
>
> If the RAM disk contains is used by an installer is irrelevant here.
> If it is a data disk used by an OS the same patch is needed.

Will change

>
> > +      * the mounted images and continue the installation since the contents
> > +      * of the pmem region are treated as local media.
> > +      *
> > +      * The memory regions used for it needs to be carved out of the EFI
> > +      * memory map.
> >        */
> > -     ret = efi_add_memory_map(addr, size, EFI_RESERVED_MEMORY_TYPE);
> > +     ret = efi_remove_memory_map(addr, size, EFI_CONVENTIONAL_MEMORY);
> >       if (ret != EFI_SUCCESS) {
> > -             log_err("Memory reservation failed\n");
> > +             log_err("Failed to reserve memory\n");
> >               goto err;
> >       }
> >
> > @@ -490,6 +495,13 @@ static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
> >               ret = EFI_INVALID_PARAMETER;
> >               goto err;
> >       }
> > +     /*
> > +      * Depending on the kernel configuration, pmem memory area must be page
> > +      * aligned or 2MB aligned. PowerPC is an exception here and requires
>
> %s/pmem memory area/pmem memory areas/
>
> %s/MB/MiB/

Will change

-sughosh

>
> Best regards
>
> Heinrich
>
> > +      * 16MB alignment, but since we don't have EFI support for it, limit
> > +      * the alignment to 2MB.
> > +      */
> > +     image_size = ALIGN(image_size, SZ_2M);
> >
> >       /*
> >        * If the file extension is ".iso" or ".img", mount it and try to load
>
