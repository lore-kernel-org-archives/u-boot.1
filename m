Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8311E7E635
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 13:13:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F0DE86B70;
	Tue, 26 Sep 2023 15:13:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="khUUbFAL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FFE186D61; Tue, 26 Sep 2023 15:13:30 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 642E586A24
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 15:13:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-50308217223so13911245e87.3
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 06:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695734007; x=1696338807; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=E4L0uGrPNnh9O42gTehiwUOiklqj7+vjNuSNpV6kzo8=;
 b=khUUbFALvFIadM2GJQHaFhsiHgeTp3C7gayQcPhNObSxkBgsX6HBfseBSlGpo6wY9x
 Pt4UtGaF9iYodP4c5zyPgLdHZlzj9ziKMRa2eWvphQD+Wi8dZzbhRP/LcKawzkcq3h+H
 8ShVyKklokxxD051O+s739F09zWEy9LGNW/PvlXLX24rly04NlMv7PcFmwZacpNpP9ou
 yyCwTe7ZsYyehaKUwq4Zp9EwYzDeKp6Vy4GsTKx+6/dxZw0aFYTpKugFE/0ItVUGPVFY
 NWn/f3DLSLGo54kknCLb9EtA/e9onn6rPcRBOr7iyEz2IXcUr6K+bL5aCP2AgZeuD6tT
 PsIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695734007; x=1696338807;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E4L0uGrPNnh9O42gTehiwUOiklqj7+vjNuSNpV6kzo8=;
 b=aUXRZ+ikQhl37euei6TwC94Qkp43pHMzfJyYeV7B0njfMuweDE7KTvbEveISIkaYkK
 VX3JGWFFrP6V4dmpWFVy18o7X/1c7Ix4YHTEad1p8pjqyBnyJf53R118nK7Kl6RyYOZ/
 Nc1P4e+D+eQ5Kjy8fA2tf+4orLLKfY2iBLVnxdKN5YvhtiT2vlkxR/FpR6H/B5k/zE84
 vx1XdCSK576TgKlUX79CQMiaywRL/7UvqaWOmHrXdIRnX4qirPFXujtn6kxwbUhplDk2
 TXNzssDSIHbtwduvKhDFLUODH8kuDfLHLn9m2Z3EZGjrCePuM9iP73A/HjF92ZNn30Y/
 o3xw==
X-Gm-Message-State: AOJu0YzfRaukKUTgglm39DCNrGxh6Fag0vAnr5oAmF1t8Ufu2j0CFCKy
 KFOh6KjqjyUn8X040OYPX2Z3+PUukLj5zoqZOeHybQ==
X-Google-Smtp-Source: AGHT+IGlrk6peb06nmTmXGpGUKjASLRE4Qjbr0N4NQrLno7ovMxgHgSphX7rSeJ3EQcilYil/w7BQEOJYUH8flokmzc=
X-Received: by 2002:a05:6512:4890:b0:503:102c:7a05 with SMTP id
 eq16-20020a056512489000b00503102c7a05mr7337636lfb.58.1695734007579; Tue, 26
 Sep 2023 06:13:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230921015730.1511373-1-sjg@chromium.org>
 <20230921015730.1511373-31-sjg@chromium.org>
 <CAC_iWjJ=-MvO5rPwmnGTbjyaqTv+VzXNq2mXmP+Az3FKaQ_Jyg@mail.gmail.com>
 <CAPnjgZ3yAYQ7V=n-4MyPiaB_JU7_wre9xOHg5K0L22a4gYBenA@mail.gmail.com>
 <CAC_iWjJBsNXguALKFKVDOnTWFH4YB6PMevt43fOyQWonitwS7w@mail.gmail.com>
 <CAPnjgZ2DFvGz6NvS5JORBLXcCk0HMLYM-HGaRhqWDzuz4ZF1Xw@mail.gmail.com>
In-Reply-To: <CAPnjgZ2DFvGz6NvS5JORBLXcCk0HMLYM-HGaRhqWDzuz4ZF1Xw@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 26 Sep 2023 16:12:51 +0300
Message-ID: <CAC_iWjLS62kkMOYT6UiGoL66o-CaFst1nYWv7xgH+GNyeuaz9A@mail.gmail.com>
Subject: Re: [PATCH v2 30/32] fdt: Allow the devicetree to come from a bloblist
To: Simon Glass <sjg@chromium.org>
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

Hi Simon,

[...]

> > > >
> > > > So, instead of adding OF_BLOBLIST, just move this code under OF_BOARD,
> > > > inside an IS_ENABLED(BLOBLIST) check. If a bloblist is required and
> > > > the previous stage loader is supposed to provide a DT we can just
> > > > throw an error and stop booting
> > >
> > > This is the bit I don't get.
> > >
> > > The OF_BOARD thing is a hack, in that the board can do what it likes.
> > > It is our way of handling board-specific mechanisms.
> > >
> > > But I am wanting a standard mechanism, i.e. like 'standard passage', a
> > > way of passing the DT through the phases.
> > >
> > > If I put this under OF_BOARD, then the board gets to override the
> > > mechanism, so which is it?
> >
> > No, it's the other way around in my head.  OF_BOARD description is 'a
> > previous stage loader hands me over the DT', which is a superset of
> > the bloblist.
> > Whether it comes in a firmware handoff format, or a hacky register the
> > previous bootloader filled in is a detail we have to deal with and we
> > need to keep backwards compatibility.
> >
> > Maybe adding a coding snip would help
> > if (IS_ENABLED(CONFIG_OF_BOARD)) {
> >     if (CONFIG_IS_ENABLED(BLOBLIST)) { <- This instead of OF_BLOBLIST
> >         ret = bloblist_maybe_init();
> >         if (ret)
> >             return ret;
> >         /* Dynamically scan for a DT in the bloblist. */
> >         gd->fdt_blob = bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
> >         if (!gd->fdt_blob) {
> >             printf("Not FDT found in bloblist\n");
> >             bloblist_show_list();
> >            // We can choose to not return an error here and keep
> > scanning in case the DT is in a register, but I am fine with both
> >             return -ENOENT;
> >         }
> >        gd->fdt_src = FDTSRC_BLOBLIST;
> >        bloblist_show_list();
> >        log_debug("Devicetree is in bloblist at %p\n", gd->fdt_blob);
> >       // We can also bail out of this entirely if we do find a DT via
> > a bloblist.
> >      } else {
> >          gd->fdt_blob = board_fdt_blob_setup(&ret);
> >          if (ret)
> >              return ret;
> >          gd->fdt_src = FDTSRC_BOARD;
> >     }
> > }
> >
> > I haven't even compiled the code above, but it should give you a
> > better idea of what I am suggesting
>
> OK I see...yes that is along the lines of what I thought you meant.
>
> But OF_BOARD does not mean 'previous stage loader hands me over the
> DT'. I means call board_fdt_blob_setup() which could do anything. If
> some boards use that function to implement getting a DT from the prior
> stage, that's fine, but it isn't limited to that.

I think it is limited. The help message says 'Provider of DTB for DT
control' and OF_BOARD help message is 'Provided by the board (e.g a
previous loader) at runtime '.
In fact, that's exactly what I tried to clean up with commit
e7fb789612e39.  Sandbox had its special OF_HOSTFILE for the DT.  We
cleaned that up and then reintroduced it with a different name in
commit 275b4832f6bf91c.

In any case, if people want to do 'more' we have
CONFIG_OF_BOARD_SETUP/FIXUP which should be used instead for other
platform-specific stuff.  While at it OF_PRIOR_STAGE is a much better
name that OF_BOARD.  So we could get rid of OF_PRIOR_STAGE and rename
OF_BOARD to that.

The function name that is called in the setup phase is
board_fdt_blob_setup(), so it's explicitly targeting the fdt setup, or
at least that's what the name suggets. Grepping for CONFIG_OF_BOARD
matches in
board/AndesTech/ae350/ae350.c
board/armltd/vexpress64/vexpress64.c
board/raspberrypi/rpi/rpi.c
board/sifive/unleashed/unleashed.c
board/sifive/unmatched/unmatched.c
board/starfive/visionfive2/starfive_visionfive2.c
board/xilinx/common/board.c:
All these just use it to setup the DT, apart from the rpi which
additionally sets up some memory for the DT.

Apart from that it's used on a few platform drivers to setup so DM
flags (most of them set DM_FLAG_PRE_RELOC), but we can easily change
that and use The only affected files are
drivers/pinctrl/broadcom/pinctrl-bcm283x.c
drivers/serial/serial_bcm283x_mu.c
drivers/serial/serial_bcm283x_pl011.c

So making OF_BOARD do the right thing is trivial and I can work with
you on that.  I don't think it's too much effort anyway

>
> There is an HAS_PRIOR_STAGE option which sets OF_BOARD at present. But
> that doesn't seem right in the long term.
>
> The goal here is to standardise the passing of DT from a prior stage,
> so that all boards (except perhaps the dark child rpi) use standard
> passage (bloblist) to do so. That should not depend on OF_BOARD and in
> fact I would like to make OF_BOARD the exception, used when
> OF_BLOBLIST doesn't suit.

We are on the same page regarding the standardization.  But I think
shoehorning an OF_BLOBLIST just papers over the problem.
The board should ideally have 2 options
1. a previous loader gives me the DT in X random ways (one of them is
the bloblist)
2. U-Boot provides it because it was built with it
A user can always load his own special DT if he wants to, but that's
done at a later stage.

But if we clean it up properly we can
1. Do Not allow people to sneak in random options in OF_BOARD or
whatever and keep the options sane and clean
2. enable BLOBLIST by default in all supported platforms and push to
make it the default.  We can even be stricter and crash on boot if
BLOBLIST is selected and we can't find the DT in there.  That would
have a similar effect to selecting it as a Kconfig option

Thanks
/Ilias


>
> >
> > Hope that helps
> > /Ilias
> > >
> > > You say 'we can just throw and error' but what is the error? If the DT
> > > is provided via the bloblist, there is no error. If it is not, I
> > > already show an error and halt as you can see in the code below.
> > >
> > > I guess I'm just confused about what you are saying here.
> > >
> > > >
> > > >
> > > > > +               gd->fdt_blob = bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
> > > > > +               if (!gd->fdt_blob) {
> > > > > +                       printf("Not FDT found in bloblist\n");
> > > > > +                       bloblist_show_list();
> > > > > +                       return -ENOENT;
> > > > > +               }
> > > >
> > > > [...]
> > > >
>
> Regards,
> Simon
