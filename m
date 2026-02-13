Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD9ECEF99C1
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 17:54:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D339483E16;
	Fri, 13 Feb 2026 18:54:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gLqwnVgS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3A6583E23; Fri, 13 Feb 2026 18:54:00 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC96D83C4B
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 18:53:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b8fa79b9fcdso194806866b.0
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 09:53:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771005238; cv=none;
 d=google.com; s=arc-20240605;
 b=D0r4F4mIceWND4t9UGtV2kaoNJIGtJi/IYGXrv6xuVx49UFCVQSwC3zjpe2vGmBarJ
 OnRDLo/+RoFIl/WhIZpGSmVsTjwnquL6q/dWWTBw+1ZdGDllIzv0+mHQ4I8NSQckV+Qa
 yKdRMZFBDkaqkge0sFNcVD+kUQpN3vUrAxfUZysFYf+L0Z4YLniIE+qbzeg6+2e215HE
 JxRtn9bk06h/oMFIcIHD3OkXZyL+xP4BsnjmY7POD5sHa/RfWcGlnLu20PNDRwNdjzKL
 OTIZFtUqtWIMstQF6H+ou2xXukZ9iEht3IHqItD6AbQ5kjkanUMEWYB5HDdfmApZL4+J
 ZfdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xl07pl8m6wQnxKHaDIreXto7H7+/jqD1Ls1Lin6e0zg=;
 fh=ovaZgnLRpg1L0RMLgiLRxkTcqLl8fnWXExBexClVjmk=;
 b=dkcXON/T0wP/jtLrOr3dUPHK7AVZ7yhulzCEr0dq1eIP9IlZHgQn+takPnFwFOVFgI
 /vnpJABxk2YK+0JY2fNeAjOtLFp9dUoBHmaDiblLNnrb09L8ZU2WRfUWINfIOFFyx2hR
 N6TiibFAYjmmRcdEKfhYn4Rbzhit3fFhKEkbQ349E422VWsd8+BX4cTOJpot6CaCjyvs
 G3DhKxCUA55vH4Hl2eOEpHRDPgy3vFndfO79YSHvQ6id4hh0OVG1SYCTVOzLU/F9zbjp
 8DrMHgS1HWHmcBRxVjfDmx2egbRu5CAjJLLPHLO3suI4U1T7NTkuY5pEb6nmk/ZUolZf
 /YUw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771005238; x=1771610038; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xl07pl8m6wQnxKHaDIreXto7H7+/jqD1Ls1Lin6e0zg=;
 b=gLqwnVgSC5RjY3BVFqNTZedRLBqqDN/2uA10/I8p7jJLJzUC6qzc0CKsTrHPv4jKoF
 v53GikAS9zjajcymsOuRZmfZG6nMMZa2eB5tyTzdJt9JJuKFPNrUzEUJu4+Yv3xNIBPS
 N7D633I+nKTkHrcPGuEaBBgJpMhpTE9dPVVac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771005238; x=1771610038;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xl07pl8m6wQnxKHaDIreXto7H7+/jqD1Ls1Lin6e0zg=;
 b=lgUSK6WSSb6d/VGqX6xHn3Y3Z164yI1a9CjHgEpKAOhMDcci90EFIs4GnNQ5hRMTcB
 dDBZRmfi0A5p71uDJFqzpDJbI9w2XBYAz0874UjmsFzBJs5yZSC+lKJCsOcj15HGa864
 eoNgTgrGDd3gEJQnM+DnyHBz18XcCG4z9NpqoG6wCi5K3K5vJC1/Z9AuckQ0kNVcKvYs
 Xn7batch/4L0wuslnKS93Vc+o9aDwvTKkUBhH2PGUv7BZp8cCsmFLmDixMU5Uwom+5V9
 TvHCLF+20+tPWDf/tBHXryKo7qDOQnHxYB25HRLF1mjvk9DZ3lRCI/EQhIg3yuSQZ9CN
 5XMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVre3gBjMlpcq7raqbjAd+zh+sm9sqxurUT1t4GYUvbV9xLUTwUWc1DXHZO7UXDHv4CaQvrkhg=@lists.denx.de
X-Gm-Message-State: AOJu0YwchVaR7kztLzsAwopbj1RsBAuN7F4d3bJeShyrThTQBXuN5/TR
 qfL7fOdmNEnHH0iq4fkNSJyIYzMy5/6gp5vzDnLlhp7BO2ERQN70RcxAVOsmoU5Pmis+jjI8hg+
 /0SDN6X+wly9xp4vIN1WUboL0jpsB/WBVOPBOe64y
X-Gm-Gg: AZuq6aJNyx86fkmRp4+0iR8smNlQyZihrCetu0B58N+RzlGfIMZNyMXyu+bmPYNUCpC
 gog6yUREHV1HCpMUbqBDUBacPU+YygtsddSrMVFlEbPeDYm4EFQfLPsdWyr3cVu/7MPXfM6fCFT
 H+P6oH1hCkNlaScWE8AolbfORYYN0lcuI1pRUTrckIwwY191MBNA39SYWSl7Rhvrzd6i4huZLMs
 g5ibP/f+aiC9roXQLi+d8gemzbMjUq5bGj7ThGydU3gZfl4zzS9029x8gBXLf8VBRKs/DbN+7+8
 jcQyNA==
X-Received: by 2002:a17:906:fe0c:b0:b3a:8070:e269 with SMTP id
 a640c23a62f3a-b8fc0548fc0mr59717966b.14.1771005238021; Fri, 13 Feb 2026
 09:53:58 -0800 (PST)
MIME-Version: 1.0
References: <20260210185455.2409242-1-james.hilliard1@gmail.com>
 <0ed5f17d-14f3-432b-9f6d-e686ca1ae29e@mailbox.org>
In-Reply-To: <0ed5f17d-14f3-432b-9f6d-e686ca1ae29e@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 13 Feb 2026 10:53:28 -0700
X-Gm-Features: AZwV_QjpoLVXHtcwQYBI6BwZEGdWqTLth6r33uZ8BcVPGXx7NMUx51ZRpre9dkI
Message-ID: <CAFLszTg0taHzrMM5rqgZoL2eoG_v1+CBL-npmH0bdr74PtNcFg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] image: fit: Apply overlays using aligned writable
 FDT copies
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: James Hilliard <james.hilliard1@gmail.com>, u-boot@lists.denx.de, 
 Tom Rini <trini@konsulko.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Jamie Gibbons <Jamie.Gibbons@microchip.com>
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

Hi,

On Tue, 10 Feb 2026 at 13:04, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 2/10/26 7:54 PM, James Hilliard wrote:
> > libfdt expects FDT/DTO blobs to be 8-byte aligned. When loading the
> > base FDT or overlays from a FIT, the mapped buffer may be unaligned,
> > which can break fdt_open_into() on strict-alignment architectures.
> >
> > boot_get_fdt_fit() relocates the base FDT with boot_relocate_fdt()
> > before applying overlays. That uses the bootm memory map and can
> > overlap with the FIT buffer when the FIT is loaded into RAM,
> > corrupting data needed to load the kernel and ramdisk.
> >
> > Allocate writable, 8-byte aligned copies of the base FDT and overlays
> > with memalign() and fdt_open_into(). Grow the base buffer as needed,
> > apply overlays to it and pack the final tree. Free each temporary
> > overlay copy after application and check fdt_pack() errors.
> >
> > Fixes: 8fbcc0e0e839 ("boot: Assure FDT is always 8-byte aligned")
> > Fixes: 881f0b77dc8c ("image: apply FDTOs on FDT image node")
> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > ---
> > Changes v1 -> v2:
> >    - also fix alignment issues
>
> Please keep the Jamie on CC
>
> > ---
> >   boot/image-fit.c | 158 +++++++++++++++++++++++++++++++++++------------
> >   1 file changed, 118 insertions(+), 40 deletions(-)
> >
> > diff --git a/boot/image-fit.c b/boot/image-fit.c
> > index 41ab1f552b0..68fb75c8389 100644
> > --- a/boot/image-fit.c
> > +++ b/boot/image-fit.c
> > @@ -2344,6 +2344,52 @@ int boot_get_setup_fit(struct bootm_headers *images, uint8_t arch,
> >   }
> >
> >   #ifndef USE_HOSTCC
> > +#ifdef CONFIG_OF_LIBFDT_OVERLAY
> > +static int boot_get_fdt_fit_into_buffer(const void *src, ulong srclen,
> > +                                     ulong extra, ulong min_dstlen,
> > +                                     void **fdtdstbuf, ulong *fdtdstlenp)
> > +{
> > +     const void *fdtsrcbuf;
> > +     void *tmp = NULL;
> > +     ulong fdtdstlen;
> > +     int err;
> > +
> > +     /* Make sure the source FDT/DTO is 8-byte aligned for libfdt. */
> > +     fdtsrcbuf = src;
> > +     if (!IS_ALIGNED((uintptr_t)src, 8)) {
> > +             tmp = memalign(8, srclen);
> > +             if (!tmp)
> > +                     return -ENOMEM;
> > +
> > +             memcpy(tmp, src, srclen);
> > +             fdtsrcbuf = tmp;
> > +     }
> > +
> > +     fdtdstlen = ALIGN(fdt_totalsize(fdtsrcbuf) + extra, SZ_4K);
> > +     min_dstlen = ALIGN(min_dstlen, SZ_4K);
> > +     if (fdtdstlen < min_dstlen)
> > +             fdtdstlen = min_dstlen;
> > +
> > +     *fdtdstbuf = memalign(8, fdtdstlen);
> > +     if (!*fdtdstbuf) {
> > +             free(tmp);
> > +             return -ENOMEM;
> > +     }
> > +
> > +     err = fdt_open_into(fdtsrcbuf, *fdtdstbuf, fdtdstlen);
> > +     free(tmp);
> > +     if (err < 0) {
> > +             free(*fdtdstbuf);
> > +             *fdtdstbuf = NULL;
> > +             return err;
> > +     }
> > +
> > +     *fdtdstlenp = fdtdstlen;
> > +
> > +     return 0;
> > +}
> > +#endif
> > +
> >   int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
> >                    const char **fit_unamep, const char **fit_uname_configp,
> >                    int arch, ulong *datap, ulong *lenp)
> > @@ -2356,18 +2402,12 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
> >       char *next_config = NULL;
> >       ulong load, len;
> >   #ifdef CONFIG_OF_LIBFDT_OVERLAY
> > -     ulong ovload, ovlen, ovcopylen;
> > +     ulong ovload, ovlen, ovcopylen, need;
> >       const char *uconfig;
> >       const char *uname;
> > -     /*
> > -      * of_flat_tree is storing the void * returned by map_sysmem, then its
> > -      * address is passed to boot_relocate_fdt which expects a char ** and it
> > -      * is then cast into a ulong. Setting its type to void * would require
> > -      * to cast its address to char ** when passing it to boot_relocate_fdt.
> > -      * Instead, let's be lazy and use void *.
> > -      */
> > -     char *of_flat_tree;
> > -     void *base, *ov, *ovcopy = NULL;
> > +     void *ovcopy = NULL;
> > +     void *base_buf = NULL;
> > +     ulong base_buf_size = 0;
> >       int i, err, noffset, ov_noffset;
> >   #endif
> >
> > @@ -2410,18 +2450,27 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
> >       /* we need to apply overlays */
> >
> >   #ifdef CONFIG_OF_LIBFDT_OVERLAY
> > -     /* Relocate FDT so resizing does not overwrite other data in FIT. */
> > -     of_flat_tree = map_sysmem(load, len);
> > -     len = ALIGN(fdt_totalsize(load), SZ_4K);
> > -     err = boot_relocate_fdt(&of_flat_tree, &len);
> > -     if (err) {
> > -             printf("Required FDT relocation for applying DTOs failed: %d\n",
> > -                    err);
> > -             fdt_noffset = -EBADF;
> > +     /*
> > +      * Make a writable copy of the base FDT for applying overlays.
> > +      *
> > +      * Do not use boot_relocate_fdt() here: it allocates from the bootm map and
> > +      * may overlap with the FIT buffer (still needed to load the kernel /
> > +      * ramdisk) when the FIT is loaded into RAM.
> > +      */
> > +     err = boot_get_fdt_fit_into_buffer(map_sysmem(load, len), len,
> > +                                        CONFIG_SYS_FDT_PAD, 0, &base_buf,
> > +                                        &base_buf_size);
> > +     if (err < 0) {
> > +             if (err == -ENOMEM)
> > +                     printf("Required FDT copy for applying DTOs failed: out of memory\n");
>
> If this returns ENOMEM, you will likely not be able to print anything,
> so don't bother. Bail with a return value and be done with it, i.e. drop
> the error prints here.
>
> > +             else
> > +                     printf("Required FDT copy for applying DTOs failed: %s\n",
> > +                            fdt_strerror(err));
> > +             fdt_noffset = err;
> >               goto out;
> >       }
> >
> > -     load = (ulong)of_flat_tree;
> > +     len = fdt_off_dt_strings(base_buf) + fdt_size_dt_strings(base_buf);
> >
> >       /* apply extra configs in FIT first, followed by args */
> >       for (i = 1; ; i++) {
> > @@ -2465,46 +2514,73 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
> >               }
> >               debug("%s loaded at 0x%08lx len=0x%08lx\n",
> >                               uname, ovload, ovlen);
> > -             ov = map_sysmem(ovload, ovlen);
> > -
> > -             ovcopylen = ALIGN(fdt_totalsize(ov), SZ_4K);
> > -             ovcopy = malloc(ovcopylen);
> > -             if (!ovcopy) {
> > -                     printf("failed to duplicate DTO before application\n");
> > -                     fdt_noffset = -ENOMEM;
> > -                     goto out;
> > -             }
> > -
> > -             err = fdt_open_into(ov, ovcopy, ovcopylen);
> > +             err = boot_get_fdt_fit_into_buffer(map_sysmem(ovload, ovlen),
> > +                                                ovlen, 0, 0, &ovcopy,
> > +                                                &ovcopylen);
> >               if (err < 0) {
> > -                     printf("failed on fdt_open_into for DTO\n");
> > +                     if (err == -ENOMEM)
> > +                             printf("failed to duplicate DTO before application\n");
> > +                     else
> > +                             printf("failed on fdt_open_into for DTO: %s\n",
>
> DTTO
>
> > +                                    fdt_strerror(err));
> >                       fdt_noffset = err;
> >                       goto out;
> >               }
> >
> > -             base = map_sysmem(load, len + ovlen);
> > -             err = fdt_open_into(base, base, len + ovlen);
> > -             if (err < 0) {
> > -                     printf("failed on fdt_open_into\n");
> > -                     fdt_noffset = err;
> > -                     goto out;
> > +             /*
> > +              * Ensure the base FDT buffer is open and has enough room for
> > +              * the overlay. Grow it on demand.
> > +              */
> > +             need = ALIGN(len + ovcopylen + CONFIG_SYS_FDT_PAD, SZ_4K);
> > +             if (need > base_buf_size) {
>
> Doesn't boot_get_fdt_fit_into_buffer() do the necessary
> rounding/alignment/... already , so shouldn't it be enough to simply
> call it here, without this conditional ?
>
> > +                     void *new_base;
> > +                     ulong new_size;
> > +
> > +                     err = boot_get_fdt_fit_into_buffer(base_buf, base_buf_size,
> > +                                                        0, need, &new_base,
> > +                                                        &new_size);
> > +                     if (err < 0) {
> > +                             if (err == -ENOMEM)
> > +                                     printf("failed to expand FDT for DTO application\n");
> > +                             else
> > +                                     printf("failed on fdt_open_into while expanding FDT\n");
> > +                             fdt_noffset = err;
> > +                             goto out;
> > +                     }
> > +
> > +                     free(base_buf);
> > +                     base_buf = new_base;
> > +                     base_buf_size = new_size;
> >               }
> The rest looks good, thanks !

At some point I requested or suggested that we add a function to
allocate aligned space for a devicetree. If that was done then this
function should not be needed. If not, then the other code (which does
this in an ad-hoc manner) should be cleaned up to use this function.

Regards,
Simon
