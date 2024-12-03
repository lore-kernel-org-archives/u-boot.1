Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F14A0E74AC0
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 15:55:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C7C2895CE;
	Tue,  3 Dec 2024 16:55:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ks5kjDbE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEFED893D6; Tue,  3 Dec 2024 16:55:30 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A3028943D
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 16:55:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-385d6e36de7so4889780f8f.0
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 07:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733241328; x=1733846128; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qMGbEP3ZgJ6bXrg6a7hVYj2te9SEEsT84uf8IL1d/r0=;
 b=Ks5kjDbE1kJCRknxZ7SX8wn9cb3OJ5gUEvoy6ZoIXgMdLUuhyUb5/72x5UymKaoJ6Y
 8SVFpUJYkf7BjWNVDtE5lGwtjyxaP5S5ePnOe/5qgFQb4GehgkYEBwLz9eT65IOmlHCJ
 LZUpSEt5qiBthJ4ITrhhbjUzuWhW/NSsNwWPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733241328; x=1733846128;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qMGbEP3ZgJ6bXrg6a7hVYj2te9SEEsT84uf8IL1d/r0=;
 b=n4uu9wTEzIounTzcUVOn+wCeaHOsYxWdzLE4rTR6vyLo5pMIjOdOyf5ue9hk5lDz5e
 /SjIlHvu2yBqn8+8+m7KzKtsBjUsLFrSB2I84DCN9tWUIGEiAN1pEb1iMPKMYPbr+CW3
 WaG/zWTNQC5hf8iMCr526G5j1Cq6E3c7vZL1Li8EgnHu5SZ1lXNBqLMAfkbvuihQkyu/
 vKalRgb7GHLwlfKO/tKvqyk7c8t4qFWGa9IGBfYKjEe0Mq0T93KsCFjsOc2rCPGUab3X
 sY/P603gtUf/YFFzgg7HWJw50GdV+VjPcGXxpGEOiTUWnU8N3ev2WFe6EN+RJdApsaUW
 jIbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVd2XeHjPP0giXz9w9pMlS4+TjMx5JbVouet1BsUsf4HDbAKjm4l8KA4hdiMaR+trTJyzHFkaI=@lists.denx.de
X-Gm-Message-State: AOJu0YyXYr7/uzLw3SOcRLgOpow3jRksTGdR1g2f6IqHRBkRW+JMrACp
 eaFxukXteQt4lA2GFY9ebJqlL/RnSbCpS0FfXBiAevzFnb/lvM+uWxVNGaBLcuIFD8qXUmg+sVK
 /RowQXIGj/s2TcrewnIIsDPjnBYxjrMc96Imk
X-Gm-Gg: ASbGncvTCJcPo13fU/Tj/nXFrD1abRtq80VKMh6olpad8nxfyyK4mSaPQQvL0hwVyBj
 w3Avj7oGCkwMO2nlrMG/9mf9lTiqITOdk
X-Google-Smtp-Source: AGHT+IE7QWZY5Ikj2DCfww+BjLXGH7BszoXb+35L2y0FvG1PRqOvXDAL1AxWUQEOBFEqEMwg+bMYqmV3tqDVoTT6PhY=
X-Received: by 2002:a05:6000:156c:b0:385:e88a:7037 with SMTP id
 ffacd0b85a97d-385fd3cd72emr2860995f8f.6.1733241327689; Tue, 03 Dec 2024
 07:55:27 -0800 (PST)
MIME-Version: 1.0
References: <20241125-of_embed_fdt_blob_garbage-v1-1-faa78e2e1ee9@salutedevices.com>
 <35slrpavqjk23bsybse752vmwsjqzk3ej6stozo3gtlbpe5pfg@3rytobz4ewik>
In-Reply-To: <35slrpavqjk23bsybse752vmwsjqzk3ej6stozo3gtlbpe5pfg@3rytobz4ewik>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 3 Dec 2024 08:55:15 -0700
Message-ID: <CAFLszTgEKamsa6FTnjzrEWQBLkqAR7EBbZqffx09AKgQ7ppuVA@mail.gmail.com>
Subject: Re: [PATCH] common: relocate fdt_blob in global_data for FDTSRC_EMBED
 case
To: Evgeny Bachinin <eabachinin@salutedevices.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Peter Robinson <pbrobinson@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, kernel@salutedevices.com, 
 evgen89bachinin@gmail.com, u-boot@lists.denx.de
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

Hi Evgeny,

On Fri, 29 Nov 2024 at 03:03, Evgeny Bachinin
<eabachinin@salutedevices.com> wrote:
>
> Hello, dear reviewers!
>
> It was my 1st attempt to use b4-tool and it did not list all relevant
> reviewers.
>
> So, let me manually CC relevant stakeholders/maintainers.
> Please, take a look on the fix of bug/vulnerability
>
> P.S. If you wish, advise me, please, whether I need to re-send with
> updated CC list or just publish v2.
>
> On Mon, Nov 25, 2024 at 12:15:07PM +0300, Evgeny Bachinin wrote:
> > Patch resolves two kind of bugs, one of which is vulnerability related
> > to KASLR.
> >
> > === Issue briefly ===
> >
> >   Working with FDT (via non-relocated gd::fdt_blob) from inside bootm
> > command may lead to the reading the garbage instead of FDT nodes. And
> > this can result in various side-effects depending on DTS nodes, being
> > parsed during bootm.
> >
> >   But below is my specific story how I faced with this issue due to
> > MESON_RNG probing failure.
> >
> > === Bugs description ===
> >
> > 1) Bug is revealed on:
> > * configuration below
> > * U-boot 2024.10 - f919c3a889f ("Prepare v2024.10")
> >
> >   It seems, the following patch is a trigger:
> > ea955eea4f ("fdt: automatically add /chosen/kaslr-seed if DM_RNG is enabled")
> >
> >   Generally, CONFIG_OF_EMBED=y & CONFIG_RNG_MESON=y are the most
> > valuable ones for reproducing the issue.
> > ```
> >   CONFIG_ARCH_FIXUP_FDT_MEMORY=y
> >   CONFIG_CMD_FDT=y
> >   CONFIG_DEFAULT_FDT_FILE=""
> >   CONFIG_FDT_64BIT=y
> >   CONFIG_OF_BOARD_SETUP=y
> >   CONFIG_OF_CONTROL=y
> >   CONFIG_OF_EMBED=y
> >   CONFIG_OF_LIBFDT_ASSUME_MASK=0x0
> >   CONFIG_OF_LIBFDT_OVERLAY=y
> >   CONFIG_OF_LIBFDT=y
> >   CONFIG_OF_LIST="meson-axg-our-device-name"
> >   CONFIG_OF_REAL=y
> >   CONFIG_OF_TRANSLATE=y
> >   CONFIG_SUPPORT_OF_CONTROL=y
> >   CONFIG_SYS_FDT_PAD=0x3000
> >   CONFIG_TOOLS_OF_LIBFDT=y
> >
> >   CONFIG_DM_RNG=y
> >   CONFIG_RNG_MESON=y
> > ```
> >
> > 2) Due to CONFIG_OF_EMBED, the DTS is embedded into U-boot ELF and
> > accessible via __dtb_dt_begin symbol.
> >
> >   On early boot stage (board_f.c) the fdtdec_setup() is called only
> > once before U-boot's relocation into top of RAM. fdtdec_setup()
> > initializes gd::fdt_blob for FDTSRC_EMBED case:
> > ```
> >   gd->fdt_blob = dtb_dt_embedded();
> >   gd->fdt_src = FDTSRC_EMBED;
> > ```
> >
> > 3) Then reloc_fdt() is called in board_f.c
> >
> >   But due to CONFIG_OF_EMBED=y the reloc_fdt() does not update
> > gd::fdt_blob value (strictly speaking, it is impossible for
> > CONFIG_OF_EMBED=y, because U-boot ELF has not been relocated yet
> > at this moment).
> >
> >   As a result after relocation we get fdt_blob, pointing to DTS address
> > before relocation:
> > ```
> >    # bdinfo
> >   <...>
> >   relocaddr = 0x000000000fedf000
> >   reloc off = 0x000000000eedf000
> >   <...>
> >   fdt_blob = 0x010ce6c0 << points to __dtb_dt_begin before relocation
> >   new_fdt = 0x0000000000000000  << empty erroneously
> >   fdt_size = 0x0000000000000000 << zero erroneously
> > ```
> >
> > 4) During bootm command (according to our ITS-config file) the Linux
> > is loaded into 0x01080000 (which is very close to fdt_blob addr
> > 0x010ce6c0).
> > ```
> >   ## Loading kernel from FIT Image at 04000000 ...
> >      Trying 'kernel' kernel subimage
> >        <...>
> >        Load Address: 0x01080000
> > ```
> >
> >   So Linux image overwrites the gd::fdt_blob memory location
> > in RAM (0x010ce6c0).
> >
> > 5) Issue:
> >
> >   Hence any manipulation with DTS (say, via FDT API) inside
> > implementation of bootm command leads to accessing the fdt_blob area
> > with garbage, that can lead to two situations:
> >
> > 5.1) Abort.
> >
> >   Call to fdt_off_dt_struct() from fdt_next_tag() :: fdt_offset_ptr()::
> > fdt_offset_ptr_() returns with garbage, that leads to tagp value
> > being out of RAM top addr (256 Mb in our board), causing the abort:
> > ```
> >   Boot cmd: bootm 0x4000000#boot_evt1
> >   bootm_run_states()
> >   <...>
> >   image_setup_libfdt()
> >    fdt_chosen()
> >     fdt_kaslrseed()
> >      uclass_get_device()
> >       uclass_get_device_tail()
> >        device_probe()
> >         device_of_to_plat()
> >         meson_rng_of_to_plat()
> >          clk_get_by_name_optional()
> >           clk_get_by_name()
> >            clk_get_by_name_nodev()
> >             ofnode_stringlist_search()
> >              fdt_stringlist_search()
> >               fdt_getprop()
> >                fdt_get_property_namelen_()
> >                 fdt_first_property_offset()
> >                  fdt_check_node_offset_()
> >                   fdt_next_tag():
> >                     ```
> >                       tagp = fdt_offset_ptr(fdt, offset, FDT_TAGSIZE);
> >                     ```
> >                   fdt_next_tag() tagp:0x22890766
> >                   fdt_next_tag() ram_top:0x10000000 (tagp OUT of RAM)
> >   "Synchronous Abort" handler, esr 0x96000010, far 0x22890766
> >   elr: 000000000108be24 lr : 000000000108be24 (reloc)
> >   elr: 000000000ff6fe24 lr : 000000000ff6fe24
> >   x0 : 0000000000000041 x1 : 0000000000000000
> >   x2 : 000000000ff3b57c x3 : 0000000000000012
> >   x4 : 000000000ded2ad5 x5 : 0000000000000020
> >   x6 : 00000000ffffffe8 x7 : 000000000ded2f40
> >   x8 : 00000000ffffffd8 x9 : 000000000000000d
> >   x10: 0000000000000006 x11: 000000000001869f
> >   x12: 000000000fffffff x13: 000000000fffffff
> >   x14: 0000000000000000 x15: 000000000ded2abb
> >   x16: 000000000ff3b080 x17: 0000000000000001
> >   x18: 000000000ded3dc0 x19: 0000000022890766
> >   x20: 00000000010cb0f0 x21: 00000000000015e4
> >   x22: 000000000ff8f4d8 x23: 000000000000000b
> >   x24: 000000000ded2fbc x25: 000000000ffe2000
> >   x22: 000000000ff8f4d8 x23: 000000000000000b
> >   x24: 000000000ded2fbc x25: 000000000ffe2000
> >   x26: 000000000ffe2000 x27: 000000000000000b
> >   x28: 000000000ff9cf2d x29: 000000000ded2f40
> >
> >   Code: aa1603e1 91197484 52801742 94004de8 (b9400276)
> > ```
> >
> > 5.2) Vulnerability situation "KASLR is disabled".
> >
> > Almost the same as in (5.1), but 2 situations happen (depending on
> > the value of garbage):
> >   * call to fdt_offset_ptr_() :: fdt_off_dt_struct(fdt)
> >     returns not so big garbage, leading to tagp, being inside RAM.
> >   * or calculations of absoffset inside fdt_offset_ptr() leads to
> >     failure of the one of if() conditions with NULL as retval.
> >
> >   Result is fdt_next_tag() interprets the tagp as FDT_END. And we are
> > returning from our callstack via functions' error paths, leading to
> > "No RNG device" and "KASLR disabled due to lack of seed":
> > ```
> >   fdt_kaslrseed()
> >    uclass_get_device()
> >    <...>
> >     device_probe()
> >      device_of_to_plat()
> >       meson_rng_of_to_plat()
> >        clk_get_by_name()
> >         clk_get_by_name_nodev()
> >         <...>
> >          fdt_stringlist_search()
> >           fdt_getprop()
> >            fdt_get_property_namelen_()
> >             fdt_first_property_offset()
> >              fdt_check_node_offset_()
> >               fdt_next_tag():
> >                 ```
> >                   tagp = fdt_offset_ptr(fdt, offset, FDT_TAGSIZE);
> >                 ```
> >               fdt_next_tag() tagp:0000000001890677
> >               fdt_next_tag() ram_top:0x10000000 (tagp is inside RAM)
> >       uclass_get_device_tail():486 device_probe() ret:-22
> >   No RNG device
> >  Starting kernel ...
> >
> >   [ 0.000000] Linux version 6.9.12
> >   [ 0.000000] KASLR disabled due to lack of seed
> > ```
> >
> > Signed-off-by: Evgeny Bachinin <EABachinin@salutedevices.com>
> > ---
> > Tested:
> > * on board with Amlogic AXG SoC.
> > * on sandbox: make sure that certain code from patch is called (of
> >   course, when CONFIG_OF_EMBED=y)
> > * U-boot CI: https://github.com/u-boot/u-boot/pull/698/checks
> > ---
> >  common/board_r.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/common/board_r.c b/common/board_r.c
> > index 62228a723e12f8742437acae380e82f79903a8f5..88dc756b2a5e5a44f55f9b0fd012adc798a8afdb 100644
> > --- a/common/board_r.c
> > +++ b/common/board_r.c
> > @@ -152,6 +152,15 @@ static int initr_reloc_global_data(void)
> >        */
> >       gd->env_addr += gd->reloc_off;
> >  #endif
> > +
> > +     /*
> > +      * For CONFIG_OF_EMBED case the FDT is embedded into ELF, available by
> > +      * __dtb_dt_begin. After U-boot ELF self-relocation to RAM top address

U-Boot

> > +      * it is worth to update fdt_blob in global_data
> > +      */
> > +     if (IS_ENABLED(CONFIG_OF_EMBED))
> > +             gd->fdt_blob = dtb_dt_embedded();
> > +
> >  #ifdef CONFIG_EFI_LOADER
> >       /*
> >        * On the ARM architecture gd is mapped to a fixed register (r9 or x18).
> >
> > ---
> > base-commit: cca05617a8f585f3a98a8fa82f75cc68a530d771
> > change-id: 20241119-of_embed_fdt_blob_garbage-ea729a8236e1
> >
> > Best regards,
> > --
> > Evgeny Bachinin <EABachinin@salutedevices.com>

Note that OF_EMBED is a development feature[1], for debugging with
JTAG, etc. Which board is this?

Also, you should normally disable relocation (with gd->flags
GD_FLG_SKIP_RELOC) when using OF_EMBED, since the code ends up
elsewhere, which is a pain when debugging.

This macro is for use by fdtgrep...perhaps I should have added an
underscore at the end to make that clear. So please add a function in
fdtdec to handle this, calling it from initr_reloc_global_data(),
perhaps.

Regards,
Simon

[1] https://docs.u-boot.org/en/latest/develop/devicetree/control.html#configuration
