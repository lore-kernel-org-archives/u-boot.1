Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5155E8FDC5
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 02:12:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2293E8744F;
	Wed,  4 Oct 2023 04:11:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gc7hQegC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E8D48723B; Wed,  4 Oct 2023 04:11:53 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6003087259
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 04:11:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-579de633419so19529107b3.3
 for <u-boot@lists.denx.de>; Tue, 03 Oct 2023 19:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696385509; x=1696990309; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8Z3NZ7984ToDUVcJgWdTbm2j3ocroQ1Mry2F7I6BJ3Y=;
 b=gc7hQegCk1vmeFZTYy08SzW3O3P+8YDsUpzm+LatqBu+LiNGA/RI90wOU8fjHusUDC
 FKvXare++W/EragpD0VAncyOzngZ85br8KTRyrV9k+s0mL7JfhgekM0k5q+B3M7nWITT
 O4QwQF+Mizcmu8qiAE8JOkOJ3wJeTfFEil18s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696385509; x=1696990309;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8Z3NZ7984ToDUVcJgWdTbm2j3ocroQ1Mry2F7I6BJ3Y=;
 b=LBdh5XWb13iQM4Ws5HCMMojTXGKnrlQGAyhahACmLSIiowh77s3VxDf6qQXStYD6Yz
 pH63G/22Chm9tsStzcCj/HvAbSL52v7BatX81CiSaiKXJpgwhnkR21EyqmJlsytuCDd5
 2mli6gpcGb2D+P9Peq8YS4R2HAUGgNw4PnpSzW9Ur/feR59GZLexIutuelvDZWmG+3Ne
 4weOscZTkIXRLZWUk+o/WpoPvaszBRDdtIj5gCm2PmHTq4x9xugbVQwoqPBc9/FzVysn
 eEPXjfFmd7voRTp2G5QN45wkXoLMJG2DoJpAViEMGcGazSQezoqZOI8+IeTYywKxS2zT
 0isg==
X-Gm-Message-State: AOJu0Yyk9LcOKpkxtITrMHf+XizTVD6Uwe+HqriIBHq61zdpk4dcaevM
 RdxH6iSRpffe2NKxC5sP+eBoXohqYK9X8EIOY45/F+5H2tY4KDowVHA=
X-Google-Smtp-Source: AGHT+IHyQSoFxuUTdXgn/lbio3PiHm28OWQNzAMh6IZBC4vBjrI93gCKKzTUBk7evc0Cr0WoVCYje4Kk0c6kWWocOMM=
X-Received: by 2002:a0d:c8c3:0:b0:59b:fb69:1639 with SMTP id
 k186-20020a0dc8c3000000b0059bfb691639mr1194074ywd.32.1696385509315; Tue, 03
 Oct 2023 19:11:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230921015730.1511373-1-sjg@chromium.org>
 <20230921015730.1511373-31-sjg@chromium.org>
 <CAC_iWjJ=-MvO5rPwmnGTbjyaqTv+VzXNq2mXmP+Az3FKaQ_Jyg@mail.gmail.com>
 <CAPnjgZ3yAYQ7V=n-4MyPiaB_JU7_wre9xOHg5K0L22a4gYBenA@mail.gmail.com>
 <CAC_iWjJBsNXguALKFKVDOnTWFH4YB6PMevt43fOyQWonitwS7w@mail.gmail.com>
 <CAPnjgZ2DFvGz6NvS5JORBLXcCk0HMLYM-HGaRhqWDzuz4ZF1Xw@mail.gmail.com>
 <CAC_iWjLS62kkMOYT6UiGoL66o-CaFst1nYWv7xgH+GNyeuaz9A@mail.gmail.com>
 <CAPnjgZ0Vo1iPhGRW6bcROfa6Q56ZNV=Kw_z4hD4jiJdAJ3kqXw@mail.gmail.com>
 <CAC_iWj+hkVjftjfVfRFd27uF59=cpsJ0r+6jCg++EYFqZjBZyQ@mail.gmail.com>
In-Reply-To: <CAC_iWj+hkVjftjfVfRFd27uF59=cpsJ0r+6jCg++EYFqZjBZyQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 3 Oct 2023 20:11:08 -0600
Message-ID: <CAPnjgZ0uN+KTMBV7+GVmU4yzgTu0GNKdxfaVGcTfPD6BE=CJ2Q@mail.gmail.com>
Subject: Re: [PATCH v2 30/32] fdt: Allow the devicetree to come from a bloblist
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, 
 Baruch Siach <baruch@tkos.co.il>, Bin Meng <bmeng.cn@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jerry Van Baren <vanbaren@cideas.com>,
 Michal Simek <michal.simek@amd.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Nikhil M Jain <n-jain1@ti.com>, Qu Wenruo <wqu@suse.com>
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

Hi Ilias,

On Mon, 2 Oct 2023 at 01:33, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon
>
> On Mon, 2 Oct 2023 at 04:23, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Ilias,
> >
> > On Tue, 26 Sept 2023 at 07:13, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Hi Simon,
> > >
> > > [...]
> > >
> > > > > > >
> > > > > > > So, instead of adding OF_BLOBLIST, just move this code under OF_BOARD,
> > > > > > > inside an IS_ENABLED(BLOBLIST) check. If a bloblist is required and
> > > > > > > the previous stage loader is supposed to provide a DT we can just
> > > > > > > throw an error and stop booting
> > > > > >
> > > > > > This is the bit I don't get.
> > > > > >
> > > > > > The OF_BOARD thing is a hack, in that the board can do what it likes.
> > > > > > It is our way of handling board-specific mechanisms.
> > > > > >
> > > > > > But I am wanting a standard mechanism, i.e. like 'standard passage', a
> > > > > > way of passing the DT through the phases.
> > > > > >
> > > > > > If I put this under OF_BOARD, then the board gets to override the
> > > > > > mechanism, so which is it?
> > > > >
> > > > > No, it's the other way around in my head.  OF_BOARD description is 'a
> > > > > previous stage loader hands me over the DT', which is a superset of
> > > > > the bloblist.
> > > > > Whether it comes in a firmware handoff format, or a hacky register the
> > > > > previous bootloader filled in is a detail we have to deal with and we
> > > > > need to keep backwards compatibility.
> > > > >
> > > > > Maybe adding a coding snip would help
> > > > > if (IS_ENABLED(CONFIG_OF_BOARD)) {
> > > > >     if (CONFIG_IS_ENABLED(BLOBLIST)) { <- This instead of OF_BLOBLIST
> > > > >         ret = bloblist_maybe_init();
> > > > >         if (ret)
> > > > >             return ret;
> > > > >         /* Dynamically scan for a DT in the bloblist. */
> > > > >         gd->fdt_blob = bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
> > > > >         if (!gd->fdt_blob) {
> > > > >             printf("Not FDT found in bloblist\n");
> > > > >             bloblist_show_list();
> > > > >            // We can choose to not return an error here and keep
> > > > > scanning in case the DT is in a register, but I am fine with both
> > > > >             return -ENOENT;
> > > > >         }
> > > > >        gd->fdt_src = FDTSRC_BLOBLIST;
> > > > >        bloblist_show_list();
> > > > >        log_debug("Devicetree is in bloblist at %p\n", gd->fdt_blob);
> > > > >       // We can also bail out of this entirely if we do find a DT via
> > > > > a bloblist.
> > > > >      } else {
> > > > >          gd->fdt_blob = board_fdt_blob_setup(&ret);
> > > > >          if (ret)
> > > > >              return ret;
> > > > >          gd->fdt_src = FDTSRC_BOARD;
> > > > >     }
> > > > > }
> > > > >
> > > > > I haven't even compiled the code above, but it should give you a
> > > > > better idea of what I am suggesting
> > > >
> > > > OK I see...yes that is along the lines of what I thought you meant.
> > > >
> > > > But OF_BOARD does not mean 'previous stage loader hands me over the
> > > > DT'. I means call board_fdt_blob_setup() which could do anything. If
> > > > some boards use that function to implement getting a DT from the prior
> > > > stage, that's fine, but it isn't limited to that.
> > >
> > > I think it is limited. The help message says 'Provider of DTB for DT
> > > control' and OF_BOARD help message is 'Provided by the board (e.g a
> > > previous loader) at runtime '.
> > > In fact, that's exactly what I tried to clean up with commit
> > > e7fb789612e39.  Sandbox had its special OF_HOSTFILE for the DT.  We
> > > cleaned that up and then reintroduced it with a different name in
> > > commit 275b4832f6bf91c.
> >
> > That commit adds HAS_PRIOR_STATE, though, not anything to do with sandbox.
> >
> > OK. Perhaps it is just the OF_BOARD name that I object to?
> >
> > >
> > > In any case, if people want to do 'more' we have
> > > CONFIG_OF_BOARD_SETUP/FIXUP which should be used instead for other
> > > platform-specific stuff.  While at it OF_PRIOR_STAGE is a much better
> > > name that OF_BOARD.  So we could get rid of OF_PRIOR_STAGE and rename
> > > OF_BOARD to that.
> >
> > To do that, we have to work out what to do with board-specific setup.
> >
> > >
> > > The function name that is called in the setup phase is
> > > board_fdt_blob_setup(), so it's explicitly targeting the fdt setup, or
> > > at least that's what the name suggets. Grepping for CONFIG_OF_BOARD
> > > matches in
> > > board/AndesTech/ae350/ae350.c
> > > board/armltd/vexpress64/vexpress64.c
> > > board/raspberrypi/rpi/rpi.c
> > > board/sifive/unleashed/unleashed.c
> > > board/sifive/unmatched/unmatched.c
> > > board/starfive/visionfive2/starfive_visionfive2.c
> > > board/xilinx/common/board.c:
> > > All these just use it to setup the DT, apart from the rpi which
> > > additionally sets up some memory for the DT.
> > >
> > > Apart from that it's used on a few platform drivers to setup so DM
> > > flags (most of them set DM_FLAG_PRE_RELOC), but we can easily change
> > > that and use The only affected files are
> > > drivers/pinctrl/broadcom/pinctrl-bcm283x.c
> > > drivers/serial/serial_bcm283x_mu.c
> > > drivers/serial/serial_bcm283x_pl011.c
> > >
> > > So making OF_BOARD do the right thing is trivial and I can work with
> > > you on that.  I don't think it's too much effort anyway
> >
> > What is the right thing you refer to here?
> >
> > >
> > > >
> > > > There is an HAS_PRIOR_STAGE option which sets OF_BOARD at present. But
> > > > that doesn't seem right in the long term.
> > > >
> > > > The goal here is to standardise the passing of DT from a prior stage,
> > > > so that all boards (except perhaps the dark child rpi) use standard
> > > > passage (bloblist) to do so. That should not depend on OF_BOARD and in
> > > > fact I would like to make OF_BOARD the exception, used when
> > > > OF_BLOBLIST doesn't suit.
> > >
> > > We are on the same page regarding the standardization.  But I think
> > > shoehorning an OF_BLOBLIST just papers over the problem.
> > > The board should ideally have 2 options
> > > 1. a previous loader gives me the DT in X random ways (one of them is
> > > the bloblist)
> > > 2. U-Boot provides it because it was built with it
> > > A user can always load his own special DT if he wants to, but that's
> > > done at a later stage.
> >
> > OK
> >
> > >
> > > But if we clean it up properly we can
> > > 1. Do Not allow people to sneak in random options in OF_BOARD or
> > > whatever and keep the options sane and clean
> >
> > I am certainly keen to remove OF_BOARD, or print a warning when it is used.
> >
> > > 2. enable BLOBLIST by default in all supported platforms and push to
> > > make it the default.  We can even be stricter and crash on boot if
> > > BLOBLIST is selected and we can't find the DT in there.  That would
> > > have a similar effect to selecting it as a Kconfig option
> >
> > Yes, that's what I am doing with this patch. So we end up with:
> >
> > OF_SEPARATE - packed with U-Boot
> > OF_BLOBLIST - comes in a bloblist
> > OF_BOARD - escape hatch, please don't use
>
> That's not what I am suggesting though.  Let me try and sum it up in
> case it helps
>
> - Remove OF_PRIOR_STAGE
> - Rename OF_BOARD -> OF_PRIOR_STAGE
> - Add the bloblist scanning code for DT under the OF_PRIOR_STAGE

What happens if the bloblist does not contain a DT?

What do we do with boards with have a magic way of getting the DT, not
using bloblist?

Regards,
Simon


>
> Thanks
> /Ilias
> >
> > Regards,
> > Simon
> >
> >
> >
> > >
> > > Thanks
> > > /Ilias
> > >
> > >
> > > >
> > > > >
> > > > > Hope that helps
> > > > > /Ilias
> > > > > >
> > > > > > You say 'we can just throw and error' but what is the error? If the DT
> > > > > > is provided via the bloblist, there is no error. If it is not, I
> > > > > > already show an error and halt as you can see in the code below.
> > > > > >
> > > > > > I guess I'm just confused about what you are saying here.
> > > > > >
> > > > > > >
> > > > > > >
> > > > > > > > +               gd->fdt_blob = bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
> > > > > > > > +               if (!gd->fdt_blob) {
> > > > > > > > +                       printf("Not FDT found in bloblist\n");
> > > > > > > > +                       bloblist_show_list();
> > > > > > > > +                       return -ENOENT;
> > > > > > > > +               }
> > > > > > >
> > > > > > > [...]
> > > > > > >
> > > >
> > > > Regards,
> > > > Simon
