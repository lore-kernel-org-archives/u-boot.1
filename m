Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92343D17148
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 23:47:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8204C88FD4;
	Tue, 22 Oct 2024 01:45:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ie7O1u/a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA0C788FB8; Mon, 21 Oct 2024 18:33:11 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB9CB88E8A
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 18:33:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a99eb8b607aso490653266b.2
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 09:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729528387; x=1730133187; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=064QCBu1/ShiL/J+YYmRXBXRxKdwv3ZL17paOMyeo5Q=;
 b=Ie7O1u/ansd9T+Mb7/KyyQklFJwgVfV36IkITZ81rCXphiOtrPLFyUPas5wvJ+v+2H
 Eu6E8/mED/TSZRnPe4s4wAJ4uV++DqtX2q8fD83MZ9+hClV5LG68jzfL8Ge3n9P/NZ95
 VqkFvhYpUDaeQ4x8jAaScG0tEsmL8E6uI4tfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729528387; x=1730133187;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=064QCBu1/ShiL/J+YYmRXBXRxKdwv3ZL17paOMyeo5Q=;
 b=h/VwNx31nApnGdL6YzVwFPesnItSRhuzwl+8Fs2wiqesPASznx1SWeo8w/ZyEit8js
 VYBxAAR2EcMsS7qBkHNPCklPqim2kuAnSttWspXz2H7hpMQBIudBgqkqpyOjhjlSb+2j
 p2Zg0gJShQwxd0bEmJrxXPEVPXrhDDuERtgE60GQICbWgM0iyYqA3EgAqxBC2GWE49KL
 x9Alp5tKagSiib0maX5+PdVqLc/Y98TzJd+GI7x6jG9BtrOYr8slVNfeQLe/xDkyv9sp
 w7G5TbSCCe4Ip9xZ2wEeo2BLcSn8g0jg9/CkOteAkfAtJ3TXC02ApYuzFUwBcMCKOFSw
 Y43g==
X-Gm-Message-State: AOJu0Yx+Qd3/n6g08/vKuZO05F6xOUtNDwBJ4g9wFYELer04d1pH7en+
 wTKjPlEAeiEh/HcvwvWq9cK8mT2FYtn3HhBTnFnhTgri0E49tzJO+PGzxDS2ppQc+Z5aYVHjk/X
 uziqXjV/bF0Tgoa8tgMGRD/z3kmpy8Ng8yJ19
X-Google-Smtp-Source: AGHT+IEQ54a+63hTpKSWV9lRii9Hw3TWdwfJ/can+lgau1uE5Ew2vI1+yNEBxq/vhqFzkp7LKzSaNeZafG38SoWGi3A=
X-Received: by 2002:a17:907:6d0b:b0:a9a:e2b:1711 with SMTP id
 a640c23a62f3a-a9a694cbcb3mr1183189666b.0.1729528386965; Mon, 21 Oct 2024
 09:33:06 -0700 (PDT)
MIME-Version: 1.0
References: <20241021114247.349863-1-sjg@chromium.org>
 <20241021114247.349863-2-sjg@chromium.org>
 <4b6297f7-4433-46c3-8661-4f68d7320c7f@linaro.org>
In-Reply-To: <4b6297f7-4433-46c3-8661-4f68d7320c7f@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 21 Oct 2024 18:32:55 +0200
Message-ID: <CAFLszTg2zJ7ozumU+00824raKZZEN23cKmKbTiqu9wvprr6FoQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] fdt: Swap the signature for board_fdt_blob_setup()
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Aaron Williams <awilliams@marvell.com>, Alexander Graf <agraf@csgraf.de>, 
 Anastasiia Lukianenko <anastasiia_lukianenko@epam.com>,
 Andre Przywara <andre.przywara@arm.com>, 
 Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
 Bin Meng <bmeng.cn@gmail.com>, David Feng <fenghua@phytium.com.cn>, 
 E Shattow <lucent@gmail.com>, Eric Curtin <ecurtin@redhat.com>, 
 Francois Berder <fberder@outlook.fr>, Green Wan <green.wan@sifive.com>, 
 H Bell <dmoo_dv@protonmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Igor Opaniuk <igor.opaniuk@foundries.io>, "Ivan T. Ivanov" <iivanov@suse.de>, 
 James Hilliard <james.hilliard1@gmail.com>, Janne Grunau <j@jannau.net>, 
 Jerry Van Baren <vanbaren@cideas.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Linus Walleij <linus.walleij@linaro.org>, 
 Liviu Dudau <liviu.dudau@foss.arm.com>, Marek Vasut <marex@denx.de>, 
 Mark Kettenis <kettenis@openbsd.org>, Matthias Brugger <mbrugger@suse.com>, 
 Michal Simek <michal.simek@amd.com>, Minda Chen <minda.chen@starfivetech.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, 
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Padmarao Begari <padmarao.begari@amd.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Peng Fan <peng.fan@nxp.com>, Peter Hoyes <Peter.Hoyes@arm.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Randolph <randolph@andestech.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Raymond Mao <raymond.mao@linaro.org>, 
 Rick Chen <rick@andestech.com>, Sam Day <me@samcday.com>,
 Stefan Roese <sr@denx.de>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sumit Garg <sumit.garg@linaro.org>, 
 Thomas Fitzsimmons <fitzsim@fitzsim.org>, Tim Harvey <tharvey@gateworks.com>, 
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, 
 William Zhang <william.zhang@broadcom.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>, 
 u-boot-qcom@groups.io, uboot-stm32@st-md-mailman.stormreply.com, 
 =?UTF-8?Q?=C5=81ukasz_Stelmach?= <l.stelmach@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 22 Oct 2024 01:45:50 +0200
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

Hi Caleb,

On Mon, 21 Oct 2024 at 15:28, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Hi Simon,
>
> On 21/10/2024 13:42, Simon Glass wrote:
> > This returns a devicetree and updates a parameter with an error code.
> > Swap it, since this fits better with the way U-Boot normally works. It
> > also (more easily) allows leaving the existing pointer unchanged.
> >
> > No yaks were harmed in this change, but there is a very small code-size
> > reduction.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
>
> ...
>
> > diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> > index 2ab2ceb5138..7a7a36831c3 100644
> > --- a/arch/arm/mach-snapdragon/board.c
> > +++ b/arch/arm/mach-snapdragon/board.c
> > @@ -147,12 +147,11 @@ static void show_psci_version(void)
> >    * or for supporting quirky devices where it's easier to leave the downstream DT in place
> >    * to improve ABL compatibility. Otherwise, we use the DT provided by ABL.
> >    */
> > -void *board_fdt_blob_setup(int *err)
> > +int board_fdt_blob_setup(void **fdtp)
> >   {
> >       struct fdt_header *fdt;
> >       bool internal_valid, external_valid;
> >
> > -     *err = 0;
> >       fdt = (struct fdt_header *)get_prev_bl_fdt_addr();
> >       external_valid = fdt && !fdt_check_header(fdt);
> >       internal_valid = !fdt_check_header(gd->fdt_blob);
> > @@ -170,7 +169,7 @@ void *board_fdt_blob_setup(int *err)
> >       } else {
> >               debug("Using external FDT\n");
> >               /* So we can use it before returning */
> > -             gd->fdt_blob = fdt;
> > +             *fdtp = fdt;
>
> I believe this is a breaking change. The qcom_parse_memory() call below
> expects gd->fdt_blob to point to the in-use FDT. This is a bit of a
> hack, but doing memory parsing this early simplifies things for us.
>
> Additionally, this change doesn't make the function return -EEXIST when
> it should.

Hmm, OK, thanks. I wonder if there is another place where the memory
can be parsed, rather than as a side-effect of this call. I will
update this patch and try again.

>
> ...
>
> > diff --git a/include/fdtdec.h b/include/fdtdec.h
> > index 555c9520379..9e36acc7e9b 100644
> > --- a/include/fdtdec.h
> > +++ b/include/fdtdec.h
> > @@ -1191,11 +1191,13 @@ int fdtdec_resetup(int *rescan);
> >    *
> >    * The existing devicetree is available at gd->fdt_blob
> >    *
> > - * @err: 0 on success, -EEXIST if the devicetree is already correct, or other
> > + * @fdtp: Existing devicetree blob pointer; update this and return 0 if a
>
> It doesn't looks like this is initialised before calling
> board_fdt_blob_setup()?
>
> Kind regards,
> > + * different devicetree should be used
> > + * Return: 0 on success, -EEXIST if the devicetree is already correct, 0 to use
> > + * *@fdtp as the new devicetree, or other
> >    * internal error code if we fail to setup a DTB
> > - * @returns new devicetree blob pointer
> >    */
> > -void *board_fdt_blob_setup(int *err);
> > +int board_fdt_blob_setup(void **fdtp);
> >
> >   /*
> >    * Decode the size of memory
> > diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> > index 60e28173c03..e876b17f9ad 100644
> > --- a/lib/fdtdec.c
> > +++ b/lib/fdtdec.c
> > @@ -1706,11 +1706,16 @@ int fdtdec_setup(void)
> >
> >       /* Allow the board to override the fdt address. */
> >       if (IS_ENABLED(CONFIG_OF_BOARD)) {
> > -             gd->fdt_blob = board_fdt_blob_setup(&ret);
> > -             if (!ret)
> > +             void *blob;
> > +
> > +             ret = board_fdt_blob_setup(&blob);
> > +             if (ret) {
> > +                     if (ret != -EEXIST)
> > +                             return ret;
> > +             } else {
> >                       gd->fdt_src = FDTSRC_BOARD;
> > -             else if (ret != -EEXIST)
> > -                     return ret;
> > +                     gd->fdt_blob = blob;
> > +             }
> >       }
> >
> >       /* Allow the early environment to override the fdt address */
>
> --
> // Caleb (they/them)
>

Regards,
Simon
