Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F21DFC282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 14:44:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8261A81D27;
	Fri, 14 Mar 2025 15:44:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CUjh6Kl8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1521F81DD6; Fri, 14 Mar 2025 15:44:10 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C42581D27
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 15:44:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ac2bdea5a38so376029466b.0
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 07:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741963447; x=1742568247; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QMzbmUaw3yqqjVsmJyKCxdJiIWUReojwQklZHk2OaPQ=;
 b=CUjh6Kl8ZA1spB31Wc1EDWr/xFp6PSjoE0AsUqTBA2mVMriuEkRlDDuVW01QjFdy/P
 HKSoUwO9GNddxpWbcgLdahRzrWiLjTC0dtwM/VtAXOl/Pdy1hEmty+lR6nJU5rLD2zDv
 i0xvxQ109RtXBcGG4Wv1uaxFjcA9iRGQ0J99U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741963447; x=1742568247;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QMzbmUaw3yqqjVsmJyKCxdJiIWUReojwQklZHk2OaPQ=;
 b=gY2F5ITt6cNwHiShg01jFE1O3nlMqHQo82w4y5Pqfx9KAxTGkWYxq+riffHsxyRi9s
 GuYBRi/P/KupA1iMlkukcWf2IxzN8zk6OUGLUxIIjCEKHWM3HZTYu7KMz58RdmuLZNzQ
 oBgDmBC2P5OxX0LPm4FKIu61Vdz4ND4cGvGu3sbjLBqmOnfsmni+weDp86iUDCM4fkB9
 I6B8CK67hA2PuWU5V8RX5eEGvKNdymb3s1H2l/q4ZWIEFeL0F9tU87xI+/srFK4hNa9F
 PlUCLYIxuQIksHU3SQLxr8zEV3DUo84RXxSAyVrlGFJQIjomenejtoQ4EGchxomJrbtU
 0QFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWF8/H/igIJPopnAQCadK9C1guoAYk3FAvzbt87UPUCHvQLJtx7xbDXWRzaY9Dpxjd5AKxim6I=@lists.denx.de
X-Gm-Message-State: AOJu0YyI6+zZecXuX11IXq6sqsbRXKugpvUC5eqqOC2Zkl+wWyyEvFud
 L7g+6q1ZUJcV2mjgiaaIJtY/G3hktX7CNrnt51ENuO1CWc2uoETwL1VNmqsr1+SmEbYXZfr3vOk
 G5Jb8GFPTnoj+fPKhJQ0P3lHc8pN3KH5UOPRJ
X-Gm-Gg: ASbGncszFEsA+VL7tJ3M5p0aW+OdbS01F/9DUGbW+iVN1PzuekY6xVs0qoA1EAnYYL/
 uvN07IZyV4k2MIaNGaewX4hei3im8YkJ/Rpxz853rUELSWc98le+i1l2gLfSZy9AKmyE/2VWym+
 J4j99gkJcTsw1NtJNl6WZg64wDYsXC2t7rzuNVtRI=
X-Google-Smtp-Source: AGHT+IEkDwikDjTJUUrX3ESnLnOknq/Vj+9P1YX8fJCo1FLjZyR2bEdzIkV8vpeGIEEYYopgUEGu5h8U5Dla9/V8i4w=
X-Received: by 2002:a17:907:9712:b0:abf:38a:6498 with SMTP id
 a640c23a62f3a-ac3304e556cmr316766966b.55.1741963446906; Fri, 14 Mar 2025
 07:44:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250306002533.2380866-1-sjg@chromium.org>
 <20250306002533.2380866-16-sjg@chromium.org>
 <a264575d-41e2-4e73-a800-900c5309aea2@gmx.de>
In-Reply-To: <a264575d-41e2-4e73-a800-900c5309aea2@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 14 Mar 2025 14:43:54 +0000
X-Gm-Features: AQ5f1JpSi0u1GtKJZKpbcpZ78bteNvjn2fgNSatQ3JlzEBIlvTLd6SMgp-w5Vmc
Message-ID: <CAFLszTgnQz2GhuDHw=w30N1dtGOJVs1JxjeyxrM+2_LJiOdSOw@mail.gmail.com>
Subject: Re: [PATCH v5 15/29] boot: arm: riscv: sandbox: Add a format for the
 booti file
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, Albert Aribaud <albert.u.boot@aribaud.net>, 
 Julien Masson <jmasson@baylibre.com>, Leo <ycliang@andestech.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Peter Korsgaard <peter@korsgaard.com>, Rick Chen <rick@andestech.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
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

HI Heinrich,

On Sat, 8 Mar 2025 at 06:09, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 3/6/25 01:25, Simon Glass wrote:
>
> There is no such thing as a booti file as booti takes pointers for three
> different files: kernel, initrd, dtb. I guess you try to refer to the
> Linux Image file format.
>
> Please, rephrase the commit title.

OK

>
> > Arm invented a new format for arm64 and something similar is also used
> > with RISC-V. Add this to the list of supported formats and provide a way
> > for the format to be detected on both architectures.
>
> In Linux `make help` provides this information:
>
> Architecture-specific targets (arm64):
> * Image.gz      - Compressed kernel image (arch/arm64/boot/Image.gz)
>    Image         - Uncompressed kernel image (arch/arm64/boot/Image)
>    image.fit     - Flat Image Tree (arch/arm64/boot/image.fit)
>    install       - Install kernel (compressed if COMPRESSED_INSTALL set)
>    zinstall      - Install compressed kernel
>                    Install using (your) ~/bin/installkernel or
>                    (distribution) /sbin/installkernel or
>                    install to $(INSTALL_PATH) and run lilo
>
> Architecture-specific targets (riscv):
>    Image         - Uncompressed kernel image (arch/riscv/boot/Image)
>    Image.gz      - Compressed kernel image (arch/riscv/boot/Image.gz)
>    Image.bz2     - Compressed kernel image (arch/riscv/boot/Image.bz2)
>    Image.lz4     - Compressed kernel image (arch/riscv/boot/Image.lz4)
>    Image.lzma    - Compressed kernel image (arch/riscv/boot/Image.lzma)
>    Image.lzo     - Compressed kernel image (arch/riscv/boot/Image.lzo)
>    Image.zst     - Compressed kernel image (arch/riscv/boot/Image.zst)
>    Image.xz      - Compressed kernel image (arch/riscv/boot/Image.xz)
>    vmlinuz.efi   - Compressed EFI kernel image (arch/riscv/boot/vmlinuz.efi)
>                    Default when CONFIG_EFI_ZBOOT=y
>    xipImage      - Execute-in-place kernel image (arch/riscv/boot/xipImage)
>                    Default when CONFIG_XIP_KERNEL=y
>    install       - Install kernel using (your) ~/bin/installkernel or
>                    (distribution) /sbin/installkernel or install to
>                    $(INSTALL_PATH)
>
> How about:
>
> "With the booti command we support the "Image" format of the Linux
> kernel in compressed and uncompressed form."

OK

>
> >
> > Update the genimg_get_format() function to support this.
>
> %s/this/this file format/

OK

>
> >
> > Fix up switch() statements which don't currently mention this format.
> > Booti does not support a ramdisk, so this can be ignored.
>
> Booti takes three arguments the second one is for the RAM disk.

Yes, it is badly worded. I mean that select_ramdisk() has no special
handling for booti.

>
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v3)
> >
> > Changes in v3:
> > - Add new patch to add a format for the booti file
> >
> >   arch/arm/lib/image.c     | 9 ++++++++-
> >   arch/riscv/lib/image.c   | 9 ++++++++-
> >   arch/sandbox/lib/bootm.c | 5 +++++
> >   boot/image-board.c       | 5 +++++
> >   include/image.h          | 9 +++++++++
> >   5 files changed, 35 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/lib/image.c b/arch/arm/lib/image.c
> > index 1f672eee2c8..d78d704cb58 100644
> > --- a/arch/arm/lib/image.c
> > +++ b/arch/arm/lib/image.c
> > @@ -28,6 +28,13 @@ struct Image_header {
> >       uint32_t        res5;
> >   };
> >
> > +bool booti_is_valid(const void *img)
> > +{
> > +     const struct Image_header *ih = img;
> > +
> > +     return ih->magic == le32_to_cpu(LINUX_ARM64_IMAGE_MAGIC);
> > +}
> > +
> >   int booti_setup(ulong image, ulong *relocated_addr, ulong *size,
> >               bool force_reloc)
> >   {
> > @@ -39,7 +46,7 @@ int booti_setup(ulong image, ulong *relocated_addr, ulong *size,
> >
> >       ih = (struct Image_header *)map_sysmem(image, 0);
> >
> > -     if (ih->magic != le32_to_cpu(LINUX_ARM64_IMAGE_MAGIC)) {
> > +     if (!booti_is_valid(ih)) {
> >               puts("Bad Linux ARM64 Image magic!\n");
> >               return 1;
> >       }
> > diff --git a/arch/riscv/lib/image.c b/arch/riscv/lib/image.c
> > index a82f48e9a50..859326cbac8 100644
> > --- a/arch/riscv/lib/image.c
> > +++ b/arch/riscv/lib/image.c
> > @@ -32,6 +32,13 @@ struct linux_image_h {
> >       uint32_t        res4;           /* reserved */
> >   };
> >
> > +bool booti_is_valid(const void *img)
> > +{
> > +     const struct linux_image_h *lhdr = img;
> > +
> > +     return lhdr->magic == LINUX_RISCV_IMAGE_MAGIC;
>
> The Linux header has more fields that we should check, cf.
> arch/riscv/kernel/head.S
>
> #if __riscv_xlen == 64
>          /* Image load offset(2MB) from start of RAM */
>          .dword 0x200000
> #else
>          /* Image load offset(4MB) from start of RAM */
>          .dword 0x400000
> #endif
>
> Please, check that the bitness matches the U-Boot architecture.
>
>          .ascii RISCV_IMAGE_MAGIC
>          .balign 4
>          .ascii RISCV_IMAGE_MAGIC2
>
> #define RISCV_IMAGE_MAGIC       "RISCV\0\0\0"
> #define RISCV_IMAGE_MAGIC2      "RSC\x05"
>
> Consider checking both magic fields.

OK I'll leave that to the maintainers as it is beyond the scope of
this patch. BTW did anyone ever send a patch to get the vf2 board in
my lab passing tests? I might have missed it.

>
> > +}
> > +
> >   int booti_setup(ulong image, ulong *relocated_addr, ulong *size,
> >               bool force_reloc)
> >   {
> > @@ -39,7 +46,7 @@ int booti_setup(ulong image, ulong *relocated_addr, ulong *size,
> >
> >       lhdr = (struct linux_image_h *)map_sysmem(image, 0);
> >
> > -     if (lhdr->magic != LINUX_RISCV_IMAGE_MAGIC) {
> > +     if (!booti_is_valid(lhdr)) {
> >               puts("Bad Linux RISCV Image magic!\n");
>
> As described above we should check more than the magic.

See above.

>
> >               return -EINVAL;
> >       }
> > diff --git a/arch/sandbox/lib/bootm.c b/arch/sandbox/lib/bootm.c
> > index 44ba8b52e13..8ed923750f4 100644
> > --- a/arch/sandbox/lib/bootm.c
> > +++ b/arch/sandbox/lib/bootm.c
> > @@ -89,3 +89,8 @@ int booti_setup(ulong image, ulong *relocated_addr, ulong *size,
> >
> >       return 1;
> >   }
> > +
> > +bool booti_is_valid(const void *img)
> > +{
> > +     return false;
> > +}
> > diff --git a/boot/image-board.c b/boot/image-board.c
> > index addccf87c80..07931c64198 100644
> > --- a/boot/image-board.c
> > +++ b/boot/image-board.c
> > @@ -250,6 +250,9 @@ enum image_fmt_t genimg_get_format(const void *img_addr)
> >       if (IS_ENABLED(CONFIG_ANDROID_BOOT_IMAGE) &&
> >           is_android_boot_image_header(img_addr))
> >               return IMAGE_FORMAT_ANDROID;
> > +     if (IS_ENABLED(CONFIG_CMD_BOOTI) &&
> > +         booti_is_valid(img_addr))
> > +             return IMAGE_FORMAT_BOOTI;
> >
> >       return IMAGE_FORMAT_INVALID;
> >   }
> > @@ -420,6 +423,8 @@ static int select_ramdisk(struct bootm_headers *images, const char *select, u8 a
> >                       done = true;
> >               }
> >               break;
> > +     case IMAGE_FORMAT_BOOTI:
> > +             break;
> >       case IMAGE_FORMAT_INVALID:
> >               break;
> >       }
> > diff --git a/include/image.h b/include/image.h
> > index dc1a7c307cc..f8f2c887a4b 100644
> > --- a/include/image.h
> > +++ b/include/image.h
> > @@ -603,6 +603,7 @@ enum image_fmt_t {
> >       IMAGE_FORMAT_LEGACY,            /* legacy image_header based format */
> >       IMAGE_FORMAT_FIT,               /* new, libfdt based format */
> >       IMAGE_FORMAT_ANDROID,           /* Android boot image */
> > +     IMAGE_FORMAT_BOOTI,             /* Arm64/RISC-V boot image */
>
> Please, describe the enum in Sphinx style, see
> https://docs.kernel.org/doc-guide/kernel-doc.html#structure-union-and-enumeration-documentation
>
> Please, avoid self-referential naming (booti supports the booti format):
>
> %s/IMAGE_FORMAT_BOOTI/IMAGE_FORMAT_LINUX_IMAGE/

OK

>
> >   };
> >
> >   /**
> > @@ -649,6 +650,14 @@ enum image_fmt_t genimg_get_format(const void *img_addr);
> >
> >   int genimg_has_config(struct bootm_headers *images);
> >
> > +/**
> > + * booti_is_valid() - Check if an image appears to be an Arm64 image
>
> Above you implement the function for RISC-V.
>
> "Check if an image is in a compatible Linux Image format"

OK

>
> > + *
> > + * @img: Pointer to image
> > + * Return: true if the image has the Arm64 magic
>
> For RISC-V we should be checking more than the magic. See above.

See above.

>
> Best regards
>
> Heinrich
>
> > + */
> > +bool booti_is_valid(const void *img);
> > +
> >   /**
> >    * boot_get_fpga() - Locate the FPGA image
> >    *
>

Regards,
Simon
