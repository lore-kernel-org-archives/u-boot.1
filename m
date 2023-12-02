Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BD2BC4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 18:25:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F08078772B;
	Sat,  2 Dec 2023 19:24:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bkZ2P/Xt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C38D987712; Sat,  2 Dec 2023 19:24:21 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24BE987702
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 19:24:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-5cece20f006so36833187b3.3
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 10:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701541455; x=1702146255; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Mech2uF39ab/ZYY++Fh/y/sVOTqrMn3aeRXoxMaX/YE=;
 b=bkZ2P/XtQBlNoLB4kO1e/oQS1OL9t4jUoDVuqqTsuGXKi2/ROkv0kucCGOMlTP16G1
 YQD2820bUBd4ty0uWJPHfexD7zePzUog3L34PO8dCAcRjV2/UkQrosEemgTws9aTjWZO
 wak3rkddx07BAcoN55gdJuctCsEbGGFWS/b2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701541455; x=1702146255;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Mech2uF39ab/ZYY++Fh/y/sVOTqrMn3aeRXoxMaX/YE=;
 b=MS4Ur+E2n/XzjJwtUGcw/giasZLVnf39oF50p76w2VS9OzMLz5HH/oyNq9Kyni5KB0
 7ycn/t1uE5JyIuZH3Q5IOX/bXiJ+/hJeDCGRGcHWsJUKCqp1MtY/yxJ45gTMAd5pAXt2
 xqwZNb1bLfVm6MPW0WEn3/DnqJOKMUxa9rdZVV+8ZbMiClwt0X013ny+9aR7hkL4THsm
 CmkJEHI/HBOsfgQJyUd8iir2yk003amW/JSTLrQiYnkhwD85G3ZWDu0kKl6PZiFauG2m
 vNDTLLzk8fT1F5m2d6BykCDtXy0JYu9evwO51UWfG2YAQtpk9uIiKSFNRZ6NnA3tFSer
 kBhQ==
X-Gm-Message-State: AOJu0YzY7R5UyEF1tVu3MuRSfmID36vpBdUdRMIVM9lTTQfp4UbEUA/t
 zhcOEX86DpEFyAni/XLKljOU2aO7MjgkFQZbkH1kfGps3jtTMUlycSbFgQ==
X-Google-Smtp-Source: AGHT+IGxXQKdLWs7wmoP8mcM+8BFU7awkjQ8+rRFHNgtfd75jxH5rP5K71wkH4SFrEdvCXme481ua86E/01PP83gdxc=
X-Received: by 2002:a05:690c:dd0:b0:5d7:1940:f3cd with SMTP id
 db16-20020a05690c0dd000b005d71940f3cdmr1424373ywb.53.1701541455221; Sat, 02
 Dec 2023 10:24:15 -0800 (PST)
MIME-Version: 1.0
References: <20231110152944.647535-1-devarsht@ti.com>
 <20231110152944.647535-6-devarsht@ti.com>
 <CAPnjgZ1TWnMrKDDbNDdg9TB8bhfW5ga2E7Lpy8HdyvsO46FDsw@mail.gmail.com>
 <c97b9ccd-8dd6-6fab-ebb6-b5b6cb2a1c08@ti.com>
In-Reply-To: <c97b9ccd-8dd6-6fab-ebb6-b5b6cb2a1c08@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 2 Dec 2023 11:23:29 -0700
Message-ID: <CAPnjgZ1VpjsrmPnKcBHXwiqpcGZ63LZPaehS5TC45Gh0xRzbSw@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] video: Fill video handoff in video post probe
To: Devarsh Thakkar <devarsht@ti.com>
Cc: u-boot@lists.denx.de, agust@denx.de, trini@konsulko.com, 
 bmeng.cn@gmail.com, msuchanek@suse.de, rasmus.villemoes@prevas.dk, 
 yangshiji66@outlook.com, praneeth@ti.com, nm@ti.com, vigneshr@ti.com, 
 a-bhatia1@ti.com, j-luthra@ti.com, nsekhar@ti.com, n-jain1@ti.com
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

Hi Devarsh,

On Sat, 25 Nov 2023 at 07:27, Devarsh Thakkar <devarsht@ti.com> wrote:
>
> Hi Simon,
>
> Thanks for the review.
>
> On 13/11/23 01:31, Simon Glass wrote:
> > Hi Devarsh,
> >
> > On Fri, 10 Nov 2023 at 08:29, Devarsh Thakkar <devarsht@ti.com> wrote:
> >>
> >> Fill video handoff fields in video_post_probe
> >> as at this point we have full framebuffer-related
> >> information.
> >>
> >> Also fill all the fields available in video hand-off
> >> struct as those were missing earlier and U-boot
> >
> > U-Boot
> >
> >> framework expects them to be filled for some of the
> >> functionalities.
> >
> > Can you wrap your commit messages to closer to 72 chars?
> >
> >>
> >> Reported-by: Simon Glass <sjg@chromium.org>
> >> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> >> ---
> >> V2:
> >> - No change
> >>
> >> V3:
> >> - Fix commit message per review comment
> >> - Add a note explaining assumption of single framebuffer
> >> ---
> >>  drivers/video/video-uclass.c | 29 +++++++++++++++++++----------
> >>  1 file changed, 19 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
> >> index f619b5ae56..edc3376b46 100644
> >> --- a/drivers/video/video-uclass.c
> >> +++ b/drivers/video/video-uclass.c
> >> @@ -154,16 +154,6 @@ int video_reserve(ulong *addrp)
> >>         debug("Video frame buffers from %lx to %lx\n", gd->video_bottom,
> >>               gd->video_top);
> >>
> >> -       if (spl_phase() == PHASE_SPL && CONFIG_IS_ENABLED(VIDEO_HANDOFF)) {
> >> -               struct video_handoff *ho;
> >> -
> >> -               ho = bloblist_add(BLOBLISTT_U_BOOT_VIDEO, sizeof(*ho), 0);
> >> -               if (!ho)
> >> -                       return log_msg_ret("blf", -ENOENT);
> >> -               ho->fb = *addrp;
> >> -               ho->size = size;
> >> -       }
> >> -
> >>         return 0;
> >>  }
> >>
> >> @@ -559,6 +549,25 @@ static int video_post_probe(struct udevice *dev)
> >>
> >>         priv->fb_size = priv->line_length * priv->ysize;
> >>
> >> +       /*
> >> +        * Set up video handoff fields for passing video blob to next stage
> >> +        * NOTE:
> >> +        * This assumes that reserved video memory only uses a single framebuffer
> >> +        */
> >> +       if (spl_phase() == PHASE_SPL && CONFIG_IS_ENABLED(BLOBLIST)) {
> >> +               struct video_handoff *ho;
> >> +
> >> +               ho = bloblist_add(BLOBLISTT_U_BOOT_VIDEO, sizeof(*ho), 0);
> >> +               if (!ho)
> >> +                       return log_msg_ret("blf", -ENOENT);
> >> +               ho->fb = gd->video_bottom;
> >> +               ho->size = gd->video_top - gd->video_bottom;
> >
> > should be plat->base and plat->size
> >
>
> plat->size contains the unaligned size actually. While reserving video memory,
> the size of allocation is updated [0] as per default alignment (1 MiB) or
> alignment requested by driver. So I thought it is better to pass actual
> allocated size calculated using gd as the next stage receiving hand-off can
> directly skip the region as per passed size. And since I used gd for
> calculating size, I thought to stick to using gd for ho->fb too for consistency.
>
> Kindly let me know if any queries.

This sort of thing would have been useful to put in a comment in the
code, or commit message.

I still don't really see why the 'aligned' size isn't already in plat,
after alloc_fb() is called.

Anyway I will leave this to Anatolij

Reviewed-by: Simon Glass <sjg@chromium.org>


>
> [0]:
> https://source.denx.de/u-boot/u-boot/-/blob/u-boot-2023.07.y/drivers/video/video-uclass.c?ref_type=heads#L88
>
> Regards
> Devarsh
>
> >> +               ho->xsize = priv->xsize;
> >> +               ho->ysize = priv->ysize;
> >> +               ho->line_length = priv->line_length;
> >> +               ho->bpix = priv->bpix;
> >> +       }
> >> +
> >>         if (IS_ENABLED(CONFIG_VIDEO_COPY) && plat->copy_base)
> >>                 priv->copy_fb = map_sysmem(plat->copy_base, plat->size);
> >>
> >> --
> >> 2.34.1
> >>
> >
> > Regards,
> > Simon
