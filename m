Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CCB5C369DC
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 13:06:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D1588059D;
	Thu,  1 May 2025 15:06:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HKnmpuGm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 419B48070C; Thu,  1 May 2025 15:06:18 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DACF8056A
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 15:06:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-acb2faa9f55so105764366b.3
 for <u-boot@lists.denx.de>; Thu, 01 May 2025 06:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746104775; x=1746709575; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LOfdF84z1dwOIT/5BRvsO53Bj96kLWpcsoOSyEHswMI=;
 b=HKnmpuGmPGQ5shJjZcX2h1/JNJIkMcNOzGtHW2j6dt1qow2fn8N3KIvOeVa5zqNyzP
 8RnJD1F/3E8fB6qGe5LlY6o0IdbLwS9HPGzaOuugPGNGEZ19JIiy0TPIR/SHGy5D6ear
 wwaBTa0srGk/70c2Tch+BgVy7NJcKgeaBjJkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746104775; x=1746709575;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LOfdF84z1dwOIT/5BRvsO53Bj96kLWpcsoOSyEHswMI=;
 b=EKw8T2Fk7QuFLDgDuPFFWzJN6t9YhvMo9nAltRzJziVhrG7R8d4SQ8uXFTG0O9yM85
 DAFJo+7J4Utz61SMKBP2kLAxtGzhRVwhBwq1Nx+AB1JGwynabtObHcAwTmLxDb1fnIeO
 v8N6e8r9YacIsj6msadCCojGU6zz/1hY0krGfNdhFAmgwlp0hN601xmOG9C/0bDAVxCC
 pnTjAm7m5oQK3gyiiOxjqdGzPWYVWw490raSH4EzfRDK0C+4xGKXfgksASF93rZpU97g
 PzUNKr4fOiXfB5O4NqCIRw13wFwJiNgolmhzhRQtKJdoO1Qx/z0D+T/GIyadLTolY0A2
 SpdA==
X-Gm-Message-State: AOJu0YztZu7bQCnf+JIt96Le1oTSFTh5apJFlCUZT/u6xYc7ZTAEPfuI
 Tr5qnI+ZrXu8Xrmh8iRfLPWqGmAGkZhW7obp3A0XgPrZGAoF52CH/IxV/DEYd3SgxOAivybPCFp
 3jziKoua4CjQzp0mLwxcwPRDX0VUNojG28kLW
X-Gm-Gg: ASbGncvuV+CNRR1iZXDubijWJPkpA660mLEyEKK3hG1dJdjMJkqga/7Km8Y3va9So8M
 nXc79Xuuciu3vHvvn4JFPVkpnqRRAkKnnckkIZdJROrRnn+/d1SqBXKlP9hLfD9N8CKQXhH8sg4
 t1ceEw0iK4686N77/ngG8hNy4=
X-Google-Smtp-Source: AGHT+IFZLcucaZhXh32Xfk2VOmBI5UYTxX1HTQI99dBNulRWgE66uB6Nr0WvSiHn/riyh7jCU2GvEq5++fUHmfKp16k=
X-Received: by 2002:a17:907:1c94:b0:ac7:1600:ea81 with SMTP id
 a640c23a62f3a-acee2600a17mr593427866b.49.1746104774713; Thu, 01 May 2025
 06:06:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250418125111.2193434-1-sjg@chromium.org>
 <20250418133315.GJ5495@bill-the-cat>
 <CAFLszTg45QDjKT=5JH=Cpoy6Efv8KSPQbQ6KnA8QE6nM_bk+xw@mail.gmail.com>
 <20250418140844.GP5495@bill-the-cat>
In-Reply-To: <20250418140844.GP5495@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 May 2025 07:06:03 -0600
X-Gm-Features: ATxdqUFby1ugIGKA6L4DvPa4KzNrUfgH4efmXfgsWRouBWFBOG6Efuv18oBsSgo
Message-ID: <CAFLszTgBpMt+XsrDHQz18nF7nOAZevHLQC1Jwv=-1a9yFzoq2Q@mail.gmail.com>
Subject: Re: [PATCH 0/3] booti: Remove the SYS_BOOTM_LEN limit for booti
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
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

Hi Tom,

On Fri, 18 Apr 2025 at 08:08, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Apr 18, 2025 at 07:46:59AM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 18 Apr 2025 at 07:33, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, Apr 18, 2025 at 06:50:59AM -0600, Simon Glass wrote:
> > >
> > > > This series restores the original behaviour of extlinux booting linux
> > > > 'Image' files, which is to ignore CONFIG_SYS_BOOTM_LEN and instead uses
> > > > a limit of 10x the compressed size.
> > > >
> > > > It also adds RISC-V support, since it uses a similar format to ARM64.
> > > >
> > > > Future work should integrate the code in 'booti' into main 'bootm'
> > > > logic.
> > > >
> > > >
> > > > Simon Glass (3):
> > > >   boot: Add a function to check if a linux Image is supported
> > > >   bootm: Add RISC-V support in booti_is_supported()
> > > >   booti: Allow ignoring SYS_BOOTM_LEN with the booti command
> > > >
> > > >  boot/bootm.c    | 31 +++++++++++++++++++++++++------
> > > >  cmd/booti.c     |  1 +
> > > >  include/bootm.h |  3 +++
> > > >  3 files changed, 29 insertions(+), 6 deletions(-)
> > >
> > > This is like pulling teeth. We aren't ignoring SYS_BOOTM_LEN so much as
> > > it was never relevant here to start with. The documentation
> > > (doc/usage/cmd/booti.rst) has explained that we use 10 x
> > > kernel_comp_size for the limit. The "bootm" namespace has largely been
> > > about uImage (and then FIT images when not using it's own namespace)
> > > images and not applied elsewhere, which is why bootz/booti handled
> > > things outside that namespace. And then, still, this series doesn't
> > > unify cmd/booti.c with your changes, it just introduces duplicated
> > > functionality, which is generally understood to be a bad thing.
> > >
> > > So again, please do similar to what you did for cmd/bootz.c and that
> > > report and move the existing functionality over. We can then look at
> > > cleaning it up (which should look like / abstract what we do for
> > > compressed FIT images) as a follow up, in order to make bisecting any
> > > regressions here easier down the line. Thanks.
> >
> > Well, I still don't understand what you are getting at here.
> >
> > The existing functionality for booti is already there. Marek added it
> > a few years back. Can you please be more specific as to what
> > functionality you think is missing?
>
> With:
> https://patchwork.ozlabs.org/project/uboot/patch/20250409155723.431102-1-sjg@chromium.org/
> You moved the functionality from cmd/bootz.c and over to boot/bootm.c
>
> You need to do the same thing here.

That code is already there. Here is the code you are talking about, in
cmd/booti.c (which is a hack, BTW)

static int booti_start(struct bootm_info *bmi)
{
        struct bootm_headers *images = bmi->images;
        int ret;
        ulong ld;
        ulong relocated_addr;
        ulong image_size;
        uint8_t *temp;
        ulong dest;
        ulong dest_end;
        unsigned long comp_len;
        unsigned long decomp_len;
        int ctype;

        ret = bootm_run_states(bmi, BOOTM_STATE_START);

See booti_run(). bootm_run_states() is called by virtue of boot_run(),
since the BOOTM_STATE_START flag is set

        /* Setup Linux kernel Image entry point */
        if (!bmi->addr_img) {
                ld = image_load_addr;
                debug("*  kernel: default image load address = 0x%08lx\n",
                                image_load_addr);
        } else {
                ld = hextoul(bmi->addr_img, NULL);
                debug("*  kernel: cmdline image address = 0x%08lx\n", ld);
        }

bootm handles the default load address, etc.

The next chunk is:

        temp = map_sysmem(ld, 0);
        ctype = image_decomp_type(temp, 2);
        if (ctype > 0) {
                dest = env_get_ulong("kernel_comp_addr_r", 16, 0);
                comp_len = env_get_ulong("kernel_comp_size", 16, 0);


                if (!dest || !comp_len) {
                        puts("kernel_comp_addr_r or kernel_comp_size
is not provided!\n");
                        return -EINVAL;
                }
                if (dest < gd->ram_base || dest > gd->ram_top) {
                        puts("kernel_comp_addr_r is outside of DRAM range!\n");
                        return -EINVAL;
                }

which is in this function:

static int found_booti_os(enum image_comp_t comp)
{
        images.os.load = images.os.image_start;
        images.os.type = IH_TYPE_KERNEL;
        images.os.os = IH_OS_LINUX;
        images.os.comp = comp;
        if (IS_ENABLED(CONFIG_RISCV_SMODE))
                images.os.arch = IH_ARCH_RISCV;
        else if (IS_ENABLED(CONFIG_ARM64))
                images.os.arch = IH_ARCH_ARM64;

        log_debug("load %lx start %lx len %lx ep %lx os %x comp %x\n",
                  images.os.load, images.os.image_start, images.os.image_len,
                  images.ep, images.os.os, images.os.comp);
        if (comp != IH_COMP_NONE) {
                images.os.load = env_get_hex("kernel_comp_addr_r", 0);
                images.os.image_len = env_get_ulong("kernel_comp_size", 16, 0);
                if (!images.os.load || !images.os.image_len) {
                        puts("kernel_comp_addr_r or kernel_comp_size
is not provided!\n");
                        return -ENOTSUPP;
                }
                if (lmb_reserve(images.os.load, images.os.image_len) < 0)
                        return -EXDEV;
        }

        return 0;
}


The next chunk is:

                debug("kernel image compression type %d size = 0x%08lx
address = 0x%08lx\n",
                        ctype, comp_len, (ulong)dest);
                decomp_len = comp_len * 10;
                ret = image_decomp(ctype, 0, ld, IH_TYPE_KERNEL,
                                 (void *)dest, (void *)ld, comp_len,
                                 decomp_len, &dest_end);
                if (ret)
                        return ret;
                /* dest_end contains the uncompressed Image size */
                memmove((void *) ld, (void *)dest, dest_end);
        }
        unmap_sysmem((void *)ld);

which happens in bootm_load_os():

        load_buf = map_sysmem(load, 0);
        image_buf = map_sysmem(os.image_start, image_len);
        err = image_decomp(os.comp, load, os.image_start, os.type,
                           load_buf, image_buf, image_len, bootm_len(),
                           &load_end);
        if (err) {
                err = handle_decomp_error(os.comp, load_end - load, bootm_len(),
                                          err);
                bootstage_error(BOOTSTAGE_ID_DECOMP_IMAGE);
                return err;
        }


then we have the setup:

        ret = booti_setup(ld, &relocated_addr, &image_size, false);
        if (ret)
                return 1;

        /* Handle BOOTM_STATE_LOADOS */
        if (relocated_addr != ld) {
                printf("Moving Image from 0x%lx to 0x%lx, end=0x%lx\n", ld,
                       relocated_addr, relocated_addr + image_size);
                memmove((void *)relocated_addr, (void *)ld, image_size);
        }

        images->ep = relocated_addr;
        images->os.start = relocated_addr;
        images->os.end = relocated_addr + image_size;

        lmb_reserve(images->ep, le32_to_cpu(image_size));

which happens later in bootm_load_os():

        if (IS_ENABLED(CONFIG_CMD_BOOTI) && images->os.arch == IH_ARCH_ARM64 &&
            images->os.os == IH_OS_LINUX) {
                ulong relocated_addr;
                ulong image_size;
                int ret;

                ret = booti_setup(load, &relocated_addr, &image_size, false);
                if (ret) {
                        printf("Failed to prep arm64 kernel (err=%d)\n", ret);
                        return BOOTM_ERR_RESET;
                }

                /* Handle BOOTM_STATE_LOADOS */
                if (relocated_addr != load) {
                        printf("Moving Image from 0x%lx to 0x%lx, end=0x%lx\n",
                               load, relocated_addr,
                               relocated_addr + image_size);
                        memmove((void *)relocated_addr, load_buf, image_size);
                }

                images->ep = relocated_addr;
                images->os.start = relocated_addr;
                images->os.end = relocated_addr + image_size;
        }

        if (CONFIG_IS_ENABLED(LMB))
                lmb_reserve(images->os.load, (load_end - images->os.load));


Finally we have this:

        /*
         * Handle the BOOTM_STATE_FINDOTHER state ourselves as we do not
         * have a header that provide this informaiton.
         */
        if (bootm_find_images(image_load_addr, bmi->conf_ramdisk, bmi->conf_fdt,
                              relocated_addr, image_size))
                return 1;

        return 0;
}

which happens by virtue of the BOOTM_STATE_LOADOS flag passed in booi_run()

>
> > Yes, the bootm implementation is separate from the booti command at
> > present. They both call booti_setup(). But the booti command uses
> > kernel_comp_addr_r which we shouldn't be using in bootm. In fact I'd
> > like to get rid of those vars, not proliferate them. There is
> > certainly some more common code which can be teased apart, but it's
> > not the subject of this bugfix. I have to stop somewhere.
> >
> > Perhaps you should let me do this refactoring in the way that I
> > believe it should be done?
>
> One of the big lessons learned I've had from all of the code refactors
> you've done over the years is we need to do them small and bisectable
> because corner cases become a nightmare to understand and resolve. So
> perhaps you should do the refactoring the way I believe it needs to be
> done.

You have to understand that bootm works in defined stages. The booti
command was written entirely separately and as a result bootm did not
support booting the linux 'Image' format. I've slowly been sorting
that out and cleaning up the hacks.

For example the 'booti' command does most of the stages all at once in
booti_start(). EFI has the same issue as i discussed with Heinrich
yesterday. See this code at the top of do_bootm_efi():

if (flag != BOOTM_STATE_OS_GO)
        return 0;

So it does nothing for all the stages, then loads, decompresses, etc.
etc. right at the end at the stage where it is supposed to just be
running the image.

Regards,
Simon
