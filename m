Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B588C3ABAA
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 16:35:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E405820EB;
	Mon,  5 May 2025 18:35:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="j4O+980v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45258820F6; Mon,  5 May 2025 18:35:46 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EA45820E8
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 18:35:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7304efb4b3bso2684607a34.0
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 09:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746462942; x=1747067742; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZDUzFv8JCi2r4h88hitoetOdwlC/+Uh52+uiXE9JBkg=;
 b=j4O+980vE0yoMNJFGsXOnaYY8VijAximgqA3SR+hdzwfLnEPtYvSTiN+BgIzaITSYH
 KQIjXxzUzA/96Vty+ypSUtN6hUKWp7LBZ3xHF/YDFKYNe2lHNB38kNo5ejTQwUhzYeys
 WfC1CnYw70DkohdPimvoRrWDuLTSU1tP7TPfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746462942; x=1747067742;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZDUzFv8JCi2r4h88hitoetOdwlC/+Uh52+uiXE9JBkg=;
 b=WDC0SvPYAPL19z+ddyf4pgClNKzWhTQI3qUB8W/oB5Xmhm/uN6fIZsuohSu6vu4roX
 JG3bDdDkpQIsYFQV0BHi1manqD//CVobI/FO+bMNbZ+g7JE4t5ybR0uPhVFbDUZKPo8r
 zo66aKpYIEEmAS5vnvpIW+q+94LpcLSJtIQxmvXrMrXV18HTl+T65lsKfD6Y8a19Qn4M
 unosWfd9pPkrE4ty6IMF7HJAfh8cyQL7ytcOdmBlUM0mVpR9IgYNNVPYv3Ez4MtYHJmc
 mNAOcd1mrlY5nAkmVh72oDpykeLP8a4y/N4S5k9xQPD+oLgV0A7KKj92SlCVm6mZr20X
 FLlw==
X-Gm-Message-State: AOJu0YwdSuvplvSc0FwuvYaZeS6Px6QtaXjdWddGHEo4DQahhosnoyCt
 asiVUqcmRkPZi+dIDbYnjRvTbaV3eUyipVrl3z6MP5TggS1Ned5lMg8BS1zP9k8=
X-Gm-Gg: ASbGncsxDBnLUJ0n/E/vxeNjSlxOOAO0M7TOBhSX6ioniWOl3uwxrYlrYE0wlPsL08r
 ntCJ/aZGLkQFS+qKp9RbS8hRq/CcA69tG+g/GgIGwamwYxlsWo5ufM1H/eazX3bDJfQ4wuByHAa
 /Muh4D+jAaeF4XFMK4cU9+bV/sX7LaPlaZUIqeVNWQOOZF4zH6P5+yjM5NcxA90jtoOmrqNHWBK
 12doqR4+J0SrtNm/Y12bHspW9fizEc0QtwHu9/K2aJaOsAYeAhwN3weUFQqgwp60UjeATHxLHdk
 vsfYtVy8zkkv2dn6jI3fhem47KqEkth/+ThT9D/Mz8txlzS3wUPkufvCDkNTfatu1R4nP5Z2jJV
 dFg==
X-Google-Smtp-Source: AGHT+IFHBPnkmEfmek22mz0VDZ2rj2alhH9hcwV5QylDsxGUlGJ1foIJykWbSdwqHuhweRco7dLh8Q==
X-Received: by 2002:a05:6830:6706:b0:72a:10ec:3637 with SMTP id
 46e09a7af769-731e5601409mr7091146a34.15.1746462941933; 
 Mon, 05 May 2025 09:35:41 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-731d31e2e4dsm1582565a34.41.2025.05.05.09.35.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 09:35:41 -0700 (PDT)
Date: Mon, 5 May 2025 10:35:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jonas Karlman <jonas@kwiboo.se>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH 0/3] booti: Remove the SYS_BOOTM_LEN limit for booti
Message-ID: <20250505163538.GF5430@bill-the-cat>
References: <20250418125111.2193434-1-sjg@chromium.org>
 <20250418133315.GJ5495@bill-the-cat>
 <CAFLszTg45QDjKT=5JH=Cpoy6Efv8KSPQbQ6KnA8QE6nM_bk+xw@mail.gmail.com>
 <20250418140844.GP5495@bill-the-cat>
 <CAFLszTgBpMt+XsrDHQz18nF7nOAZevHLQC1Jwv=-1a9yFzoq2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="J2P1ldXv4Np/QSQx"
Content-Disposition: inline
In-Reply-To: <CAFLszTgBpMt+XsrDHQz18nF7nOAZevHLQC1Jwv=-1a9yFzoq2Q@mail.gmail.com>
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


--J2P1ldXv4Np/QSQx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 01, 2025 at 07:06:03AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 18 Apr 2025 at 08:08, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Apr 18, 2025 at 07:46:59AM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Fri, 18 Apr 2025 at 07:33, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Fri, Apr 18, 2025 at 06:50:59AM -0600, Simon Glass wrote:
> > > >
> > > > > This series restores the original behaviour of extlinux booting l=
inux
> > > > > 'Image' files, which is to ignore CONFIG_SYS_BOOTM_LEN and instea=
d uses
> > > > > a limit of 10x the compressed size.
> > > > >
> > > > > It also adds RISC-V support, since it uses a similar format to AR=
M64.
> > > > >
> > > > > Future work should integrate the code in 'booti' into main 'bootm'
> > > > > logic.
> > > > >
> > > > >
> > > > > Simon Glass (3):
> > > > >   boot: Add a function to check if a linux Image is supported
> > > > >   bootm: Add RISC-V support in booti_is_supported()
> > > > >   booti: Allow ignoring SYS_BOOTM_LEN with the booti command
> > > > >
> > > > >  boot/bootm.c    | 31 +++++++++++++++++++++++++------
> > > > >  cmd/booti.c     |  1 +
> > > > >  include/bootm.h |  3 +++
> > > > >  3 files changed, 29 insertions(+), 6 deletions(-)
> > > >
> > > > This is like pulling teeth. We aren't ignoring SYS_BOOTM_LEN so muc=
h as
> > > > it was never relevant here to start with. The documentation
> > > > (doc/usage/cmd/booti.rst) has explained that we use 10 x
> > > > kernel_comp_size for the limit. The "bootm" namespace has largely b=
een
> > > > about uImage (and then FIT images when not using it's own namespace)
> > > > images and not applied elsewhere, which is why bootz/booti handled
> > > > things outside that namespace. And then, still, this series doesn't
> > > > unify cmd/booti.c with your changes, it just introduces duplicated
> > > > functionality, which is generally understood to be a bad thing.
> > > >
> > > > So again, please do similar to what you did for cmd/bootz.c and that
> > > > report and move the existing functionality over. We can then look at
> > > > cleaning it up (which should look like / abstract what we do for
> > > > compressed FIT images) as a follow up, in order to make bisecting a=
ny
> > > > regressions here easier down the line. Thanks.
> > >
> > > Well, I still don't understand what you are getting at here.
> > >
> > > The existing functionality for booti is already there. Marek added it
> > > a few years back. Can you please be more specific as to what
> > > functionality you think is missing?
> >
> > With:
> > https://patchwork.ozlabs.org/project/uboot/patch/20250409155723.431102-=
1-sjg@chromium.org/
> > You moved the functionality from cmd/bootz.c and over to boot/bootm.c
> >
> > You need to do the same thing here.
>=20
> That code is already there. Here is the code you are talking about, in
> cmd/booti.c (which is a hack, BTW)
>=20
> static int booti_start(struct bootm_info *bmi)
> {
>         struct bootm_headers *images =3D bmi->images;
>         int ret;
>         ulong ld;
>         ulong relocated_addr;
>         ulong image_size;
>         uint8_t *temp;
>         ulong dest;
>         ulong dest_end;
>         unsigned long comp_len;
>         unsigned long decomp_len;
>         int ctype;
>=20
>         ret =3D bootm_run_states(bmi, BOOTM_STATE_START);
>=20
> See booti_run(). bootm_run_states() is called by virtue of boot_run(),
> since the BOOTM_STATE_START flag is set
>=20
>         /* Setup Linux kernel Image entry point */
>         if (!bmi->addr_img) {
>                 ld =3D image_load_addr;
>                 debug("*  kernel: default image load address =3D 0x%08lx\=
n",
>                                 image_load_addr);
>         } else {
>                 ld =3D hextoul(bmi->addr_img, NULL);
>                 debug("*  kernel: cmdline image address =3D 0x%08lx\n", l=
d);
>         }
>=20
> bootm handles the default load address, etc.
>=20
> The next chunk is:
>=20
>         temp =3D map_sysmem(ld, 0);
>         ctype =3D image_decomp_type(temp, 2);
>         if (ctype > 0) {
>                 dest =3D env_get_ulong("kernel_comp_addr_r", 16, 0);
>                 comp_len =3D env_get_ulong("kernel_comp_size", 16, 0);
>=20
>=20
>                 if (!dest || !comp_len) {
>                         puts("kernel_comp_addr_r or kernel_comp_size
> is not provided!\n");
>                         return -EINVAL;
>                 }
>                 if (dest < gd->ram_base || dest > gd->ram_top) {
>                         puts("kernel_comp_addr_r is outside of DRAM range=
!\n");
>                         return -EINVAL;
>                 }
>=20
> which is in this function:
>=20
> static int found_booti_os(enum image_comp_t comp)
> {
>         images.os.load =3D images.os.image_start;
>         images.os.type =3D IH_TYPE_KERNEL;
>         images.os.os =3D IH_OS_LINUX;
>         images.os.comp =3D comp;
>         if (IS_ENABLED(CONFIG_RISCV_SMODE))
>                 images.os.arch =3D IH_ARCH_RISCV;
>         else if (IS_ENABLED(CONFIG_ARM64))
>                 images.os.arch =3D IH_ARCH_ARM64;
>=20
>         log_debug("load %lx start %lx len %lx ep %lx os %x comp %x\n",
>                   images.os.load, images.os.image_start, images.os.image_=
len,
>                   images.ep, images.os.os, images.os.comp);
>         if (comp !=3D IH_COMP_NONE) {
>                 images.os.load =3D env_get_hex("kernel_comp_addr_r", 0);
>                 images.os.image_len =3D env_get_ulong("kernel_comp_size",=
 16, 0);
>                 if (!images.os.load || !images.os.image_len) {
>                         puts("kernel_comp_addr_r or kernel_comp_size
> is not provided!\n");
>                         return -ENOTSUPP;
>                 }
>                 if (lmb_reserve(images.os.load, images.os.image_len) < 0)
>                         return -EXDEV;
>         }
>=20
>         return 0;
> }
>=20
>=20
> The next chunk is:
>=20
>                 debug("kernel image compression type %d size =3D 0x%08lx
> address =3D 0x%08lx\n",
>                         ctype, comp_len, (ulong)dest);
>                 decomp_len =3D comp_len * 10;
>                 ret =3D image_decomp(ctype, 0, ld, IH_TYPE_KERNEL,
>                                  (void *)dest, (void *)ld, comp_len,
>                                  decomp_len, &dest_end);
>                 if (ret)
>                         return ret;
>                 /* dest_end contains the uncompressed Image size */
>                 memmove((void *) ld, (void *)dest, dest_end);
>         }
>         unmap_sysmem((void *)ld);
>=20
> which happens in bootm_load_os():
>=20
>         load_buf =3D map_sysmem(load, 0);
>         image_buf =3D map_sysmem(os.image_start, image_len);
>         err =3D image_decomp(os.comp, load, os.image_start, os.type,
>                            load_buf, image_buf, image_len, bootm_len(),
>                            &load_end);
>         if (err) {
>                 err =3D handle_decomp_error(os.comp, load_end - load, boo=
tm_len(),
>                                           err);
>                 bootstage_error(BOOTSTAGE_ID_DECOMP_IMAGE);
>                 return err;
>         }
>=20
>=20
> then we have the setup:
>=20
>         ret =3D booti_setup(ld, &relocated_addr, &image_size, false);
>         if (ret)
>                 return 1;
>=20
>         /* Handle BOOTM_STATE_LOADOS */
>         if (relocated_addr !=3D ld) {
>                 printf("Moving Image from 0x%lx to 0x%lx, end=3D0x%lx\n",=
 ld,
>                        relocated_addr, relocated_addr + image_size);
>                 memmove((void *)relocated_addr, (void *)ld, image_size);
>         }
>=20
>         images->ep =3D relocated_addr;
>         images->os.start =3D relocated_addr;
>         images->os.end =3D relocated_addr + image_size;
>=20
>         lmb_reserve(images->ep, le32_to_cpu(image_size));
>=20
> which happens later in bootm_load_os():
>=20
>         if (IS_ENABLED(CONFIG_CMD_BOOTI) && images->os.arch =3D=3D IH_ARC=
H_ARM64 &&
>             images->os.os =3D=3D IH_OS_LINUX) {
>                 ulong relocated_addr;
>                 ulong image_size;
>                 int ret;
>=20
>                 ret =3D booti_setup(load, &relocated_addr, &image_size, f=
alse);
>                 if (ret) {
>                         printf("Failed to prep arm64 kernel (err=3D%d)\n"=
, ret);
>                         return BOOTM_ERR_RESET;
>                 }
>=20
>                 /* Handle BOOTM_STATE_LOADOS */
>                 if (relocated_addr !=3D load) {
>                         printf("Moving Image from 0x%lx to 0x%lx, end=3D0=
x%lx\n",
>                                load, relocated_addr,
>                                relocated_addr + image_size);
>                         memmove((void *)relocated_addr, load_buf, image_s=
ize);
>                 }
>=20
>                 images->ep =3D relocated_addr;
>                 images->os.start =3D relocated_addr;
>                 images->os.end =3D relocated_addr + image_size;
>         }
>=20
>         if (CONFIG_IS_ENABLED(LMB))
>                 lmb_reserve(images->os.load, (load_end - images->os.load)=
);
>=20
>=20
> Finally we have this:
>=20
>         /*
>          * Handle the BOOTM_STATE_FINDOTHER state ourselves as we do not
>          * have a header that provide this informaiton.
>          */
>         if (bootm_find_images(image_load_addr, bmi->conf_ramdisk, bmi->co=
nf_fdt,
>                               relocated_addr, image_size))
>                 return 1;
>=20
>         return 0;
> }
>=20
> which happens by virtue of the BOOTM_STATE_LOADOS flag passed in booi_run=
()

Which brings me to the point I was making before, and am making again.
Why in this case are you happy about having duplicated code, especially
since for the bootz case you went and refactored things not to.

> > > Yes, the bootm implementation is separate from the booti command at
> > > present. They both call booti_setup(). But the booti command uses
> > > kernel_comp_addr_r which we shouldn't be using in bootm. In fact I'd
> > > like to get rid of those vars, not proliferate them. There is
> > > certainly some more common code which can be teased apart, but it's
> > > not the subject of this bugfix. I have to stop somewhere.
> > >
> > > Perhaps you should let me do this refactoring in the way that I
> > > believe it should be done?
> >
> > One of the big lessons learned I've had from all of the code refactors
> > you've done over the years is we need to do them small and bisectable
> > because corner cases become a nightmare to understand and resolve. So
> > perhaps you should do the refactoring the way I believe it needs to be
> > done.
>=20
> You have to understand that bootm works in defined stages. The booti

Yes, I'm aware. I modeled this on bootz rather than include it in the
mess that was/is "bootm".

> command was written entirely separately and as a result bootm did not
> support booting the linux 'Image' format. I've slowly been sorting
> that out and cleaning up the hacks.
>=20
> For example the 'booti' command does most of the stages all at once in
> booti_start(). EFI has the same issue as i discussed with Heinrich
> yesterday. See this code at the top of do_bootm_efi():
>=20
> if (flag !=3D BOOTM_STATE_OS_GO)
>         return 0;
>=20
> So it does nothing for all the stages, then loads, decompresses, etc.
> etc. right at the end at the stage where it is supposed to just be
> running the image.

Yes, there wasn't a need / desire for bootz nor booti to have the
ability to call in to a specific state and run only that far, or resume
=66rom there. It ended up being much more simple to do.

--=20
Tom

--J2P1ldXv4Np/QSQx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgY6NYACgkQFHw5/5Y0
tyzymgwAseXCmq/SnjyA33ENLbnYDWak0O1FgAsXGQj7PvIozNeciLrXiMFiPZTI
F/GvdD28ttFcWKMApYcppjenHDlI5SCinX30AALNAGO4yjXdpl4dDiyQw55wlqkk
PURV+oivzmWb7otW0ZWCIhDD6OI175gkzcWAqrFocko6Cex+xCDwUokJEey3upbW
Lkc4CgOJGTFr/samr566YXFQZx8Zx0AmgGTVaWQmueeU1P4mYejCPJfbNXIgLJiV
vgADrCNWjNIxlzdl/INsqg1zzTVHLARH2iC8uKWExM/xZmJ01JNKw/CZkCJOmLet
uQQObdp7mN2RT004wJkYBHG4Aoe8l2ImVBEZw5LjuwQSgJnQqiabN/eZ93DkxDJT
nrA2neZm4VFdm4E2RGwKYlmr3X0rZHkruXVtpgTc46Ksu07TRzAb0XU45jTHcc43
uY4pwJLh26abvLR/F0NyLLpd3/zyhImgQQS/kpDSKxFP4M5WQ69aM10aUD+ptjly
il4h82Pa
=S63h
-----END PGP SIGNATURE-----

--J2P1ldXv4Np/QSQx--
