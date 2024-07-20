Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C5DEC3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 12:38:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3ABA88BFD;
	Sat, 20 Jul 2024 14:36:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aHQsjTKF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AF4988719; Sat, 20 Jul 2024 14:36:27 +0200 (CEST)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D82A3887DB
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 14:36:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-6510c0c8e29so27048617b3.0
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 05:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721478984; x=1722083784; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=T9F0V3rROPQTlmwUGsueyoocrprfrVSNNqKQa0kdL3Y=;
 b=aHQsjTKFUnHN0l8nP8I/W+AFvWN/Pq0FZ9E8YXhwI56XyM5NJuo9MhicODptaxRQ2Z
 cp4PHGobHn2+1JeX9BFY3Cy1dIWvcznp2f6CoiDQiXoO4YTb24jhpBhrX14mBWqAcNXx
 5GfHTEtpcA4jyo1q1Hk2zexgG3LLh+VseR4Ro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721478984; x=1722083784;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T9F0V3rROPQTlmwUGsueyoocrprfrVSNNqKQa0kdL3Y=;
 b=rpw9YG9vfQLNS7YnsaFqugQ80zuoxG7oKIDrMtEVFtGrWTFXIn5Z0lSjYRnbKlmwvI
 OWT9CWIrh7YcuRaC05mmoE6v/8RKaj9+dwWSB70USlan0AlE5IhF70cseMmHb+dnuSfM
 x2hTMrYtAQWzqbh9qPA+M4Eujg4t2/OlR9uFpLbMyR0fP/D6hMcuzzIjG/pCF35duUh/
 tqNdthsNpVhRr9IC9dKRCgIf9+piYOvkGo7uAEFEXsrwFXeX94gzExDEh1vnPVosjxN0
 e1wfQpnrZ1+f7q3RoD3GBc8ycltc00LUXeQaSkTD5NDOTBukrhEBDeC5XiS5uJVq5rM4
 1rKw==
X-Gm-Message-State: AOJu0YxF3Iq82LvhvJqc0zjdIawlKnsZvOs/J6pFiJ4t814HEDebTZIS
 4kBQ8Y6c0V46gYSbsuQCQU+iFc/qPTJIUtd63ThyAtuhMpLSgjVbI6ygZLpOD8uVEES4P+ZQjSG
 5E/gZ63JwvgRYefOrLKUhcK5T3vTlDrLm8ddx
X-Google-Smtp-Source: AGHT+IFQ7xTxJf3NAMbGaMQ5Z601oHajCu9x1bJbExblWQQCySQuHQ9kTYF1U6ZCoSMTJI/tM2QcXa7JfocKHC4vXDw=
X-Received: by 2002:a05:690c:4b09:b0:652:e90f:cd15 with SMTP id
 00721157ae682-66ad8dc3b84mr14694477b3.25.1721478983704; Sat, 20 Jul 2024
 05:36:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240713070055.2172883-1-sjg@chromium.org>
 <20240713070055.2172883-16-sjg@chromium.org>
 <325e6cc7-8210-8e95-0267-10d84192a406@gmail.com>
In-Reply-To: <325e6cc7-8210-8e95-0267-10d84192a406@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 20 Jul 2024 13:36:13 +0100
Message-ID: <CAFLszTgqzN2CwcOj3iR+mspxHD7mjLejaDPPx2Ext=RY8LS1=g@mail.gmail.com>
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

On Thu, 18 Jul 2024 at 14:54, Sean Anderson <seanga2@gmail.com> wrote:
>
> On 7/13/24 03:00, Simon Glass wrote:
> > Specify the FIT and include information about each loaded image, as
> > required by the UPL handoff.
> >
> > Write the UPL handoff into the bloblist before jumping to the next phase.
> >
> > Control this using a runtime flag to avoid conflicting with other
> > handoff mechanisms.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v2:
> > - Hang when something goes wrong, to avoid a broken boot
> > - Add a runtime flag to enable UPL
> >
> >   common/spl/spl.c                  |  8 ++++++++
> >   common/spl/spl_fit.c              | 22 ++++++++++++++++++++++
> >   include/asm-generic/global_data.h |  4 ++++
> >   3 files changed, 34 insertions(+)
> >
> > diff --git a/common/spl/spl.c b/common/spl/spl.c
> > index 7794ddccade..d6a364de6ee 100644
> > --- a/common/spl/spl.c
> > +++ b/common/spl/spl.c
> > @@ -810,6 +810,14 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
> >                       printf(SPL_TPL_PROMPT
> >                              "SPL hand-off write failed (err=%d)\n", ret);
> >       }
> > +     if (CONFIG_IS_ENABLED(UPL_OUT) && (gd->flags & GD_FLG_UPL)) {
> > +             ret = spl_write_upl_handoff(&spl_image);
> > +             if (ret) {
> > +                     printf(SPL_TPL_PROMPT
> > +                            "UPL hand-off write failed (err=%d)\n", ret);
> > +                     hang();
> > +             }
> > +     }
> >       if (CONFIG_IS_ENABLED(BLOBLIST)) {
> >               ret = bloblist_finish();
> >               if (ret)
> > diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> > index 2a097f4464c..b288f675ae3 100644
> > --- a/common/spl/spl_fit.c
> > +++ b/common/spl/spl_fit.c
> > @@ -12,6 +12,7 @@
> >   #include <memalign.h>
> >   #include <mapmem.h>
> >   #include <spl.h>
> > +#include <upl.h>
> >   #include <sysinfo.h>
> >   #include <asm/global_data.h>
> >   #include <asm/io.h>
> > @@ -645,6 +646,8 @@ static int spl_fit_load_fpga(struct spl_fit_info *ctx,
> >               printf("%s: Cannot load the FPGA: %i\n", __func__, ret);
> >               return ret;
> >       }
> > +     upl_add_image(node, fpga_image.load_addr, fpga_image.size,
> > +                   fdt_getprop(ctx->fit, node, FIT_DESC_PROP, NULL));
>
> Does load_addr even make sense for FPGAs?

Well the images do get loaded into RAM at a particular address.

>
> And I noticed that you always call this after load_simple_fit/fit_image_load.
> Could we call upl_add_image in those functions instead?

Yes, although it means compiling upl.h for the host. Perhaps it isn't
that bad though and it avoids repeating code.

>
> >       return spl_fit_upload_fpga(ctx, node, &fpga_image);
> >   }
> > @@ -768,6 +771,9 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
> >       if (ret)
> >               return ret;
> >
> > +     upl_add_image(node, spl_image->load_addr, spl_image->size,
> > +                   fdt_getprop(ctx.fit, node, FIT_DESC_PROP, NULL));
> > +
> >       /*
> >        * For backward compatibility, we treat the first node that is
> >        * as a U-Boot image, if no OS-type has been declared.
> > @@ -811,6 +817,8 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
> >                              __func__, index, ret);
> >                       return ret;
> >               }
> > +             upl_add_image(node, image_info.load_addr, image_info.size,
> > +                           fdt_getprop(ctx.fit, node, FIT_DESC_PROP, NULL));
> >
> >               if (spl_fit_image_is_fpga(ctx.fit, node))
> >                       spl_fit_upload_fpga(&ctx, node, &image_info);
> > @@ -847,6 +855,8 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
> >               spl_image->entry_point = spl_image->load_addr;
> >
> >       spl_image->flags |= SPL_FIT_FOUND;
> > +     upl_set_fit_info(map_to_sysmem(ctx.fit), ctx.conf_node,
> > +                      spl_image->entry_point);
>
> I think this should be virt_to_phys, since we aren't really mapping it.

We want to pass the address, which (for sandbox) has to be able to be
mapped back to a pointer. Everywhere else in sandbox this is how we
handle that...

>
> >
> >       return 0;
> >   }
> > @@ -891,6 +901,9 @@ int spl_load_fit_image(struct spl_image_info *spl_image,
> >       if (ret < 0)
> >               return ret;
> >
> > +     upl_add_image(ret, fw_data, fw_len,
> > +                   fdt_getprop((void *)header, ret, FIT_DESC_PROP, NULL));
> > +
> >       spl_image->size = fw_len;
> >       spl_image->load_addr = fw_data;
> >       if (fit_image_get_entry(header, ret, &spl_image->entry_point))
> > @@ -911,6 +924,9 @@ int spl_load_fit_image(struct spl_image_info *spl_image,
> >       if (ret >= 0) {
> >               spl_image->fdt_addr = (void *)dt_data;
> >
> > +             upl_add_image(ret, dt_data, dt_len,
> > +                   fdt_getprop((void *)header, ret, FIT_DESC_PROP, NULL));
> > +
> >               if (spl_image->os == IH_OS_U_BOOT) {
> >                       /* HACK: U-Boot expects FDT at a specific address */
> >                       fdt_hack = spl_image->load_addr + spl_image->size;
> > @@ -940,7 +956,13 @@ int spl_load_fit_image(struct spl_image_info *spl_image,
> >                                    &img_data, &img_len);
> >               if (ret < 0)
> >                       return ret;
> > +             upl_add_image(ret, img_data, img_len,
> > +                   fdt_getprop((void *)header, ret, FIT_DESC_PROP, NULL));
> >       }
> >
> > +     spl_image->flags |= SPL_FIT_FOUND;
>
> This change is unrelated and should be moved into a separate commit.

OK

Regards,
Simon
