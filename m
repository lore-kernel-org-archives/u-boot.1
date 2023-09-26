Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 597A2E7E62F
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 12:38:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EDEF86D3E;
	Tue, 26 Sep 2023 14:38:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QDwQ7NBB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B802886D5D; Tue, 26 Sep 2023 14:38:43 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA7E4803AC
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 14:38:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-533d6a8d6b6so6633855a12.2
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 05:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695731921; x=1696336721; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zwhB8niiorSwnNriyDEscSuwIN6dxY3M+joqUDy5U9c=;
 b=QDwQ7NBBaCMXR+WbB0AYp/1RBY+BKfIgAWgDcD7kfJBa9udmhWqGG8gRhJAXCb/o8z
 8Wf0wJ28DzswQeIUg5nAYLpbElpV22sgLGwSdkVtQA0PfkPoP+FjqHPWvfJaLAqJW5gl
 fop5f4/qa83tNejdvC6Fe79iE2yMjQgSxGAsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695731921; x=1696336721;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zwhB8niiorSwnNriyDEscSuwIN6dxY3M+joqUDy5U9c=;
 b=bXXOM5iJDySiwa5ScgttarLHAYxJ0XcKdqFyUzsKTt4AKMFU60ZGT+cdTipwByUhcs
 1XxUObxYsxkENkQ4EHMWFvlH5WxTnT88Q69A+R+FhjhErjxAv39LSNGPG0PBvzggpGDP
 Hqb9ge4TQpD4kdZJp5rBfdZqrWvnNkRwbdNZL9V+F+yqc5V3PDckvNaxLGUHy0XOZ5s5
 mvAC43aQJsp8snkwTt9PShPu74nsE9Dwiq/yWRaFs8UKMAy0yPro3wicLZkbT4GhcZbt
 l7LoH5BEYA6wYWMLlDv7p648AUCIpwN6D829cqNIKXJVIkwPJvyplTpGmKyWCOGzVVUD
 Su3g==
X-Gm-Message-State: AOJu0Yz91UNlGoUzrFNbutd24/XdNadHRUWYwxGMhP1/J1shXlugllgZ
 5TM/g4zBw5Ve+zT40iRzFc/L9V0fdqZDobZcs4xOCw==
X-Google-Smtp-Source: AGHT+IFxSTi+ztvZUt+3cqbukeWcXTlmVxh1J3kzuvStl4BhOb6JSSum+msRuxJyA4vg+owrWr2jIYOltslbsH0Kn1E=
X-Received: by 2002:aa7:d78f:0:b0:530:74ed:fc8a with SMTP id
 s15-20020aa7d78f000000b0053074edfc8amr7614461edq.41.1695731920922; Tue, 26
 Sep 2023 05:38:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230921015730.1511373-1-sjg@chromium.org>
 <20230921015730.1511373-31-sjg@chromium.org>
 <CAC_iWjJ=-MvO5rPwmnGTbjyaqTv+VzXNq2mXmP+Az3FKaQ_Jyg@mail.gmail.com>
 <CAPnjgZ3yAYQ7V=n-4MyPiaB_JU7_wre9xOHg5K0L22a4gYBenA@mail.gmail.com>
 <CAC_iWjJBsNXguALKFKVDOnTWFH4YB6PMevt43fOyQWonitwS7w@mail.gmail.com>
In-Reply-To: <CAC_iWjJBsNXguALKFKVDOnTWFH4YB6PMevt43fOyQWonitwS7w@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 Sep 2023 06:38:21 -0600
Message-ID: <CAPnjgZ2DFvGz6NvS5JORBLXcCk0HMLYM-HGaRhqWDzuz4ZF1Xw@mail.gmail.com>
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

On Tue, 26 Sept 2023 at 06:32, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon
>
> On Tue, 26 Sept 2023 at 14:37, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Ilias,
> >
> > On Mon, 25 Sept 2023 at 13:48, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Hi Simon,
> > >
> > > I commented on the v1 thread, but let's continue the discussion here
> > >
> > > On Thu, 21 Sept 2023 at 04:58, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Standard passage provides for a bloblist to be passed from one firmware
> > > > phase to the next. That can be used to pass the devicetree along as well.
> > > > Add an option to support this.
> > > >
> > > > Tests for this will be added as part of the Universal Payload work.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > > Changes in v2:
> > > > - No changes as it still seems unclear what should be done
> > > >
> > >
> > > [...]
> > >
> > > >
> > > >         /* BLOBLISTT_VENDOR_AREA */
> > > > diff --git a/doc/develop/devicetree/control.rst b/doc/develop/devicetree/control.rst
> > > > index cbb65c9b177f..56e00090166f 100644
> > > > --- a/doc/develop/devicetree/control.rst
> > > > +++ b/doc/develop/devicetree/control.rst
> > > > @@ -108,6 +108,9 @@ If CONFIG_OF_BOARD is defined, a board-specific routine will provide the
> > > >  devicetree at runtime, for example if an earlier bootloader stage creates
> > > >  it and passes it to U-Boot.
> > > >
> > > > +If CONFIG_OF_BLOBLIST is defined, the devicetree comes from a bloblist passed
> > > > +from a previous stage.
> > >
> > > What I argued before is that we don't need to be this explicit.
> > > The bloblist can carry a bunch of options that might be used by
> > > U-Boot.  It would be better if we had a more generic approach instead
> > > of adding Kconfig options per bloblist entry
> >
> > Yes, fair enough. It would really get out of hand if we had a lot of
> > Kconfig options for everything that could be in a bloblist.
> >
> > I believe someone objected to this in the other thread, so there may
> > be board-specific issues to resolve.
>
> I had the same objection to that first version as well
>
> >
> > >
> > > [...]
> > >
> > > >  #ifndef USE_HOSTCC
> > > > +
> > > > +#define LOG_CATEGORY   LOGC_DT
> > > > +
> > > >  #include <common.h>
> > > > +#include <bloblist.h>
> > > >  #include <boot_fit.h>
> > > >  #include <display_options.h>
> > > >  #include <dm.h>
> > > > @@ -87,6 +91,7 @@ static const char *const fdt_src_name[] = {
> > > >         [FDTSRC_BOARD] = "board",
> > > >         [FDTSRC_EMBED] = "embed",
> > > >         [FDTSRC_ENV] = "env",
> > > > +       [FDTSRC_BLOBLIST] = "bloblist",
> > > >  };
> > > >
> > > >  const char *fdtdec_get_srcname(void)
> > > > @@ -1666,20 +1671,35 @@ int fdtdec_setup(void)
> > > >         int ret;
> > > >
> > > >         /* The devicetree is typically appended to U-Boot */
> > > > -       if (IS_ENABLED(CONFIG_OF_SEPARATE)) {
> > > > -               gd->fdt_blob = fdt_find_separate();
> > > > -               gd->fdt_src = FDTSRC_SEPARATE;
> > > > -       } else { /* embed dtb in ELF file for testing / development */
> > > > -               gd->fdt_blob = dtb_dt_embedded();
> > > > -               gd->fdt_src = FDTSRC_EMBED;
> > > > -       }
> > > > -
> > > > -       /* Allow the board to override the fdt address. */
> > > > -       if (IS_ENABLED(CONFIG_OF_BOARD)) {
> > > > -               gd->fdt_blob = board_fdt_blob_setup(&ret);
> > > > +       if (CONFIG_IS_ENABLED(OF_BLOBLIST)) {
> > > > +               ret = bloblist_maybe_init();
> > > >                 if (ret)
> > > >                         return ret;
> > > > -               gd->fdt_src = FDTSRC_BOARD;
> > >
> > > So, instead of adding OF_BLOBLIST, just move this code under OF_BOARD,
> > > inside an IS_ENABLED(BLOBLIST) check. If a bloblist is required and
> > > the previous stage loader is supposed to provide a DT we can just
> > > throw an error and stop booting
> >
> > This is the bit I don't get.
> >
> > The OF_BOARD thing is a hack, in that the board can do what it likes.
> > It is our way of handling board-specific mechanisms.
> >
> > But I am wanting a standard mechanism, i.e. like 'standard passage', a
> > way of passing the DT through the phases.
> >
> > If I put this under OF_BOARD, then the board gets to override the
> > mechanism, so which is it?
>
> No, it's the other way around in my head.  OF_BOARD description is 'a
> previous stage loader hands me over the DT', which is a superset of
> the bloblist.
> Whether it comes in a firmware handoff format, or a hacky register the
> previous bootloader filled in is a detail we have to deal with and we
> need to keep backwards compatibility.
>
> Maybe adding a coding snip would help
> if (IS_ENABLED(CONFIG_OF_BOARD)) {
>     if (CONFIG_IS_ENABLED(BLOBLIST)) { <- This instead of OF_BLOBLIST
>         ret = bloblist_maybe_init();
>         if (ret)
>             return ret;
>         /* Dynamically scan for a DT in the bloblist. */
>         gd->fdt_blob = bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
>         if (!gd->fdt_blob) {
>             printf("Not FDT found in bloblist\n");
>             bloblist_show_list();
>            // We can choose to not return an error here and keep
> scanning in case the DT is in a register, but I am fine with both
>             return -ENOENT;
>         }
>        gd->fdt_src = FDTSRC_BLOBLIST;
>        bloblist_show_list();
>        log_debug("Devicetree is in bloblist at %p\n", gd->fdt_blob);
>       // We can also bail out of this entirely if we do find a DT via
> a bloblist.
>      } else {
>          gd->fdt_blob = board_fdt_blob_setup(&ret);
>          if (ret)
>              return ret;
>          gd->fdt_src = FDTSRC_BOARD;
>     }
> }
>
> I haven't even compiled the code above, but it should give you a
> better idea of what I am suggesting

OK I see...yes that is along the lines of what I thought you meant.

But OF_BOARD does not mean 'previous stage loader hands me over the
DT'. I means call board_fdt_blob_setup() which could do anything. If
some boards use that function to implement getting a DT from the prior
stage, that's fine, but it isn't limited to that.

There is an HAS_PRIOR_STAGE option which sets OF_BOARD at present. But
that doesn't seem right in the long term.

The goal here is to standardise the passing of DT from a prior stage,
so that all boards (except perhaps the dark child rpi) use standard
passage (bloblist) to do so. That should not depend on OF_BOARD and in
fact I would like to make OF_BOARD the exception, used when
OF_BLOBLIST doesn't suit.

>
> Hope that helps
> /Ilias
> >
> > You say 'we can just throw and error' but what is the error? If the DT
> > is provided via the bloblist, there is no error. If it is not, I
> > already show an error and halt as you can see in the code below.
> >
> > I guess I'm just confused about what you are saying here.
> >
> > >
> > >
> > > > +               gd->fdt_blob = bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
> > > > +               if (!gd->fdt_blob) {
> > > > +                       printf("Not FDT found in bloblist\n");
> > > > +                       bloblist_show_list();
> > > > +                       return -ENOENT;
> > > > +               }
> > >
> > > [...]
> > >

Regards,
Simon
