Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DCF5C3DA61
	for <u-boot@archiver.kernel.org>; Sun, 21 Jul 2024 10:08:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D977587702;
	Sun, 21 Jul 2024 12:08:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gZ4BUX8p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2445874AC; Sun, 21 Jul 2024 12:08:42 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A89C38789F
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 12:08:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6b79b93a4c9so25952716d6.1
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 03:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721556519; x=1722161319; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WlnfHo6zXpd/voeSFJ/99f4Wju/TbUk5mTfsDXfncy8=;
 b=gZ4BUX8p39igG/3olW2QizltJ4vCWm6OCgAJtCy25q1tMPY/EubfpLBDnOe2KpXetY
 hVw9lP6G/jFYH16bbKotAv7YVm64GIjLwJtZA+UQ5K5VTJkWQSI2LytxFafj7xZJABlI
 4DtVabPcU2sg7Ba+9ow1UKOolXJ0/8fMSPm04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721556519; x=1722161319;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WlnfHo6zXpd/voeSFJ/99f4Wju/TbUk5mTfsDXfncy8=;
 b=RasUdEgPfKammwYfOFRBumnvJrbbXnhvwMC/Qe7PevOIx2dMz4TeSr9DiSeSiaYlMb
 YZndRQ9TTDtAX2x9RgIDMLzHlSHmJOYlytxFQge345AvjjTw3OCSnXDj/njBNqCDZRP0
 yjQr99n/zjJddGKoJdHYT4XgvK3lgFN29bNZaUJVDGJKmPZl9MNZVqa2GtmSuWiVNPPR
 4M0A7d6Pob1pkjKkqhC9I2zuV7g18Ckf01pgjLmJ1wNUUcC5kfxlFBx3X4TN+I+MIA37
 f0Vhzxy5IMRRspbXYT0cTHx8IF2ilgA8voRWe0JjUivs2nVaYU5WICz+iAkPiOI/eCjm
 PNtw==
X-Gm-Message-State: AOJu0Yxm7JwZdA9xI4yrDQsCVCcZGOc9rY4jfW0ddPW9j3tHLCvvEC0y
 OdaatofmiRNNK1id/XwDgkvlq9RvZpXYSxqrwiqcj31LTM09iFoLQ9BbcPnn7uyV625lAnWk4TQ
 8fGVF0S999oVkXepc+F155Q4BHlrLFrqDs7g7
X-Google-Smtp-Source: AGHT+IHV3fKvj9whFlmUI4CyixYBwUkHKUOojtNzJ+nTF4VX0Z2N3TZQiGCC15gH6MfS+SPQV2TTdB8H25m9NYaTHhk=
X-Received: by 2002:a05:6214:cac:b0:6b5:684:2d5 with SMTP id
 6a1803df08f44-6b95b414bacmr73057316d6.4.1721556519461; Sun, 21 Jul 2024
 03:08:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240713070055.2172883-1-sjg@chromium.org>
 <20240713070055.2172883-16-sjg@chromium.org>
 <325e6cc7-8210-8e95-0267-10d84192a406@gmail.com>
 <CAFLszTgqzN2CwcOj3iR+mspxHD7mjLejaDPPx2Ext=RY8LS1=g@mail.gmail.com>
 <c968d99b-8a64-6afd-5824-844ad19e0d5a@gmail.com>
In-Reply-To: <c968d99b-8a64-6afd-5824-844ad19e0d5a@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 21 Jul 2024 11:08:28 +0100
Message-ID: <CAFLszThbPQA3KH4ibPPtnstMM7Bbcp6uT5EXMNCHNMZ33kQd=Q@mail.gmail.com>
Subject: Re: [PATCH v2 15/21] spl: Plumb in the Universal Payload handoff
To: Sean Anderson <seanga2@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Michal Simek <michal.simek@amd.com>, 
 Lean Sheng Tan <sheng.tan@9elements.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Devarsh Thakkar <devarsht@ti.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, 
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>, Marek Vasut <marex@denx.de>,
 Nikhil M Jain <n-jain1@ti.com>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Suniel Mahesh <sunil@amarulasolutions.com>, Tom Rini <trini@konsulko.com>, 
 Troy Kisky <troykiskyboundary@gmail.com>
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

Hi Sean,

On Sat, 20 Jul 2024 at 15:44, Sean Anderson <seanga2@gmail.com> wrote:
>
> On 7/20/24 08:36, Simon Glass wrote:
> > Hi Sean,
> >
> > On Thu, 18 Jul 2024 at 14:54, Sean Anderson <seanga2@gmail.com> wrote:
> >>
> >> On 7/13/24 03:00, Simon Glass wrote:
> >>> Specify the FIT and include information about each loaded image, as
> >>> required by the UPL handoff.
> >>>
> >>> Write the UPL handoff into the bloblist before jumping to the next phase.
> >>>
> >>> Control this using a runtime flag to avoid conflicting with other
> >>> handoff mechanisms.
> >>>
> >>> Signed-off-by: Simon Glass <sjg@chromium.org>
> >>> ---
> >>>
> >>> Changes in v2:
> >>> - Hang when something goes wrong, to avoid a broken boot
> >>> - Add a runtime flag to enable UPL
> >>>
> >>>    common/spl/spl.c                  |  8 ++++++++
> >>>    common/spl/spl_fit.c              | 22 ++++++++++++++++++++++
> >>>    include/asm-generic/global_data.h |  4 ++++
> >>>    3 files changed, 34 insertions(+)
> >>>
> >>> diff --git a/common/spl/spl.c b/common/spl/spl.c
> >>> index 7794ddccade..d6a364de6ee 100644
> >>> --- a/common/spl/spl.c
> >>> +++ b/common/spl/spl.c
> >>> @@ -810,6 +810,14 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
> >>>                        printf(SPL_TPL_PROMPT
> >>>                               "SPL hand-off write failed (err=%d)\n", ret);
> >>>        }
> >>> +     if (CONFIG_IS_ENABLED(UPL_OUT) && (gd->flags & GD_FLG_UPL)) {
> >>> +             ret = spl_write_upl_handoff(&spl_image);
> >>> +             if (ret) {
> >>> +                     printf(SPL_TPL_PROMPT
> >>> +                            "UPL hand-off write failed (err=%d)\n", ret);
> >>> +                     hang();
> >>> +             }
> >>> +     }
> >>>        if (CONFIG_IS_ENABLED(BLOBLIST)) {
> >>>                ret = bloblist_finish();
> >>>                if (ret)
> >>> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> >>> index 2a097f4464c..b288f675ae3 100644
> >>> --- a/common/spl/spl_fit.c
> >>> +++ b/common/spl/spl_fit.c
> >>> @@ -12,6 +12,7 @@
> >>>    #include <memalign.h>
> >>>    #include <mapmem.h>
> >>>    #include <spl.h>
> >>> +#include <upl.h>
> >>>    #include <sysinfo.h>
> >>>    #include <asm/global_data.h>
> >>>    #include <asm/io.h>
> >>> @@ -645,6 +646,8 @@ static int spl_fit_load_fpga(struct spl_fit_info *ctx,
> >>>                printf("%s: Cannot load the FPGA: %i\n", __func__, ret);
> >>>                return ret;
> >>>        }
> >>> +     upl_add_image(node, fpga_image.load_addr, fpga_image.size,
> >>> +                   fdt_getprop(ctx->fit, node, FIT_DESC_PROP, NULL));
> >>
> >> Does load_addr even make sense for FPGAs?
> >
> > Well the images do get loaded into RAM at a particular address.
>
> No they don't. I mean, technically yes, but it's just an intermediate step
> before being programmed into the FPGA. Much like how executable boot images
> may be loaded to an intermediate address before being copied to their final
> location. And the load_addr is set to 0 a few lines above.
>
> But don't bother special-casing this if you do the next part.

OK. I see the FPGA-loading happening right away. IMO this should be
done later, after all images are loaded. But I suppose the code is
easier the way it is.

>
> >>
> >> And I noticed that you always call this after load_simple_fit/fit_image_load.
> >> Could we call upl_add_image in those functions instead?
> >
> > Yes, although it means compiling upl.h for the host. Perhaps it isn't
> > that bad though and it avoids repeating code.
>
> I would prefer that to help ensure that future programmers don't forget it.

Yes.

>
> >>
> >>>        return spl_fit_upload_fpga(ctx, node, &fpga_image);
> >>>    }
> >>> @@ -768,6 +771,9 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
> >>>        if (ret)
> >>>                return ret;
> >>>
> >>> +     upl_add_image(node, spl_image->load_addr, spl_image->size,
> >>> +                   fdt_getprop(ctx.fit, node, FIT_DESC_PROP, NULL));
> >>> +
> >>>        /*
> >>>         * For backward compatibility, we treat the first node that is
> >>>         * as a U-Boot image, if no OS-type has been declared.
> >>> @@ -811,6 +817,8 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
> >>>                               __func__, index, ret);
> >>>                        return ret;
> >>>                }
> >>> +             upl_add_image(node, image_info.load_addr, image_info.size,
> >>> +                           fdt_getprop(ctx.fit, node, FIT_DESC_PROP, NULL));
> >>>
> >>>                if (spl_fit_image_is_fpga(ctx.fit, node))
> >>>                        spl_fit_upload_fpga(&ctx, node, &image_info);
> >>> @@ -847,6 +855,8 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
> >>>                spl_image->entry_point = spl_image->load_addr;
> >>>
> >>>        spl_image->flags |= SPL_FIT_FOUND;
> >>> +     upl_set_fit_info(map_to_sysmem(ctx.fit), ctx.conf_node,
> >>> +                      spl_image->entry_point);
> >>
> >> I think this should be virt_to_phys, since we aren't really mapping it.
> >
> > We want to pass the address, which (for sandbox) has to be able to be
> > mapped back to a pointer. Everywhere else in sandbox this is how we
> > handle that...
>
> This is really a nit. But I thought that map_to_sysmem implied a pairing with
> unmap. But I guess that's map_physmem.

Yes, map_sysmem() is the 'sandbox mapping' from an U-Boot address to a
pointer, and map_to_sysmem() reverses that.

Regards,
Simon
