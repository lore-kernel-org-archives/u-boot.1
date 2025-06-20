Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C892EC71155
	for <u-boot@archiver.kernel.org>; Fri, 20 Jun 2025 14:58:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2ACFF80E9A;
	Fri, 20 Jun 2025 16:58:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YH2GTuYz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C3E680C83; Fri, 20 Jun 2025 16:58:52 +0200 (CEST)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7356B82CBC
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 16:58:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-b2c2c762a89so1608347a12.0
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 07:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750431527; x=1751036327; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PPwSR/hDNkCo8P2dCx71bSi8coaG4uAs8iUOFmeuueI=;
 b=YH2GTuYzg7tJLPsteSSHJHJ74lVoNG+SIfIQnDI0z3YLxqeq2Y6SZB0C5MMgtCrJQy
 88YK1hm+qki8/Z3xiuiic1WamWU6LAWndQTbZvzBujzv3pr0qXOEC+m/jY/N+50X22PE
 f2GG36r24mEqRvg/5eIKcaJCnBuL7zDQwks5HsdVglxMZcpcK4zkxUl4G3NQ053hTRHJ
 Eujz4ZKMEnQmPyArDHJT3k0GYAJZ+zO0CNILkfqirICF5te2Za146uP7KnkNtCIItQx8
 wWk1/6UJWmYCliYlfcaBVKaW9h/PEwkaKMKelx7N31C58ZruWSbc/dGu3U91bOUpPoGf
 x37Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750431527; x=1751036327;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PPwSR/hDNkCo8P2dCx71bSi8coaG4uAs8iUOFmeuueI=;
 b=ezGkqIBdFdhsWC4mTxLAGgz3lss0HsqgbecIYC/pbL8fyiAQjdxQDaByuI2DCobXXQ
 A0YS61YZBr4sWwKRwdjZyBuyMeYo/g+fQeduQZBSjTRvjFBhw420PzSSp7zC5VjBwU8G
 Ub6uoEFY1/46xWsgayB7CANQyX+RwGcFmSHzQ6g7qj2JffymUA7PM4Q+Tjd1pnMjq3Oq
 P4KzGiG3ZtkYjXsUqQ16G8cgPqXBHWJA0ksJom9hbvYadP0gDNDQym1iyQVO4NxBdfn2
 2q1G+MqziOFjc6zjmZJjOCMSjZT8ZE4lF/ZLtCAbWkVlc7ppiEspS3TLac8ZX3iKHmw1
 E6KA==
X-Gm-Message-State: AOJu0YyUtBE+mXg+I0bGhMJSQWFjAZDqcBVkXubeL0PnsHKD52l7dT7A
 UU6m15wr7wB1FhFOuB+QsfFsU4EXi4N1N7IlsZhx4FsDvITuXqX/psCz8pvpgYehvMjIHIooGgN
 +zU4ox2MDOh8a6zL74CCexqAa4N3WNMpqQYXgpUs1Ag==
X-Gm-Gg: ASbGncvsq2oCIXkRwmRFP59xgsEev8Ba1afYBKFFJZqy3eyuqqd9SDfXUcZUX4KdCQb
 Igo8bUmNDXiXbfkHqYxNO8gzySlIKVbto5EemUKSa7+gDomhqHV8lF+2QO8bYS9DYTx2cRv/MZZ
 YS0apRceaGFZsmXTr3P8kSITAYPnIG0yXq0E/EPw2kU0Y7
X-Google-Smtp-Source: AGHT+IFxbbLCv+KSxHxiqJSaBlzg+wtqJSZYTApgP1scSZn6gT0mNW/YDxtoiXUkSkLFKJXLJhE7O2H6jg6A1C5OHEU=
X-Received: by 2002:a17:90b:35c3:b0:2fe:85f0:e115 with SMTP id
 98e67ed59e1d1-3159d8dadfcmr4094397a91.26.1750431527324; Fri, 20 Jun 2025
 07:58:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250618145930.2652304-1-raymond.mao@linaro.org>
 <20250618145930.2652304-7-raymond.mao@linaro.org>
 <9a5ed161-0420-4656-9fcf-6d122d4f6c0e@amd.com>
 <CAEfUkUL5L6YVbWtZrjitKuRPbs_3-=nr4i_1xtppi6CcXhhv1w@mail.gmail.com>
 <c6e4593f-fab1-417a-ac50-a4b0218793d3@amd.com>
In-Reply-To: <c6e4593f-fab1-417a-ac50-a4b0218793d3@amd.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Fri, 20 Jun 2025 10:58:36 -0400
X-Gm-Features: AX0GCFvYdeZSXXPtee3sZTO1V2b475wEI0lPuIJOorIMd-xQRrNfsOlHnSN5_I8
Message-ID: <CAEfUkUK5jhtFbYSF6m1grpwmd94+jhbq8v=7sVZAeHCs9yEUpQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] fdtdec: apply DT overlays from bloblist
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, venkatesh.abbarapu@amd.com, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Levi Yun <yeoreum.yun@arm.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Harrison Mutai <harrison.mutai@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Matthias Brugger <mbrugger@suse.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi Michal,

On Fri, 20 Jun 2025 at 02:26, Michal Simek <michal.simek@amd.com> wrote:
>
> Hi,
>
> On 6/19/25 18:22, Raymond Mao wrote:
> > Hi Michal,
> >
> > On Thu, 19 Jun 2025 at 07:39, Michal Simek <michal.simek@amd.com> wrote:
> >>
> >>
> >>
> >> On 6/18/25 16:59, Raymond Mao wrote:
> >>> During FDT setup, apply all existing DT overlays from the bloblist
> >>> to the base FDT if bloblist is being used for handoff from previous
> >>> boot stage.
> >>
> >> More technical details would be good to have here.
> >> Especially that the way what you are using is to expand DT
> >>
> > Agree. I can add more details in the next post.
> >
> >>>
> >>> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> >>> ---
> >>>    lib/fdtdec.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> >>>    1 file changed, 56 insertions(+)
> >>>
> >>> diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> >>> index c38738b48c7..3a218d8c94a 100644
> >>> --- a/lib/fdtdec.c
> >>> +++ b/lib/fdtdec.c
> >>> @@ -1687,6 +1687,60 @@ void fdtdec_setup_embed(void)
> >>>        gd->fdt_src = FDTSRC_EMBED;
> >>>    }
> >>>
> >>> +static int fdtdec_apply_dto_from_blob(void **blob)
> >>> +{
> >>> +     int ret;
> >>> +     struct fdt_header *live_fdt;
> >>> +     size_t new_fdt_size, blob_size;
> >>> +     int expand_by;
> >>> +
> >>> +     if (!CONFIG_IS_ENABLED(OF_LIBFDT_OVERLAY) ||
> >>> +         !CONFIG_IS_ENABLED(BLOBLIST))
> >>> +             return -EPERM;
> >>> +
> >>> +     live_fdt = bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
> >>> +     ret = fdt_check_header(live_fdt);
> >>> +     if (ret)
> >>> +             return ret;
> >>
> >>
> >> Why is this needed? You already have gd->fdt_blob which has been checked.
> >>
> > You are right, these can be skipped.
> >
> >>
> >>> +
> >>> +     ret = fdt_check_header(*blob);
> >>> +     if (ret)
> >>> +             return ret;
> >>> +
> >>> +     blob_size = fdt_totalsize(*blob);
> >>> +
> >>> +     /* Expand the FDT for spare spaces to apply the overlay */
> >>> +     new_fdt_size = fdt_totalsize(live_fdt) + blob_size + 0x400;
> >>
> >> Some notes about this 0x400 would be good. Do you see issue if you don't use
> >> this value? Is file DTB after expansion actually bigger then origin+overlay that
> >> you need to add 0x400 magic value here?
> >>
> > The value 0x400 is arbitrary and it really depends on the DTOs.
> > When applying a DTO, it may create new entries in:
> > The structure block (nodes, properties)
> > The strings block (all unique strings, including property names and values)
> > These new entries require extra space, not just equal to the overlay
> > size - because:
> > Some parts will bring in new strings, which get appended to the string table.
> > Also alignment padding might require more bytes.
> > What I am concerned about is that 0x400 might be not sufficient for
> > those complex DTOs.
> > Maybe more bytes are required.
>
> Valid concern but it should be described in commit message to also say that it
> is just a number based on your experiments but maybe it is not enough.
>
Sure, this will be added into the commit message from the next post.

>
> >
> >>
> >>> +     ret = bloblist_resize(BLOBLISTT_CONTROL_FDT, new_fdt_size, &expand_by);
> >>> +     if (ret)
> >>> +             return ret;
> >>
> >> You do resize inside tl list.. That should be described in commit message
> >> because my exception was that this location can be read only from NS world.
> >>
> > I can update the commit message with more details but why should it be
> > read-only? At least I don't recall if the spec says the TL is not
> > expected to be updated in BL33.
>
> It is not about if should be read only but about it can be because it is
> exported from secure world. I understand why you are doing it but please
> describe it to make it clear.
>
> Spec is saying
> "TL relocation typically happens in later phases of the boot when there is
> more memory available, which is needed for adding larger entries."
>
First, the S TL ends its life cycle when BL31 exists, all information
has been relocated from S to NS.
TL relocation moves the complete TL and can help if you don't have
space to extend your total TL size.
But for a single TE, the spec expects it only contains its actual data
size, resizing is an expected action when you need adding more data.

> >
> >> I didn't run this on HW and likely I should do it to understand this better
> >> but isn't this moving CONTROL_FDT entry to different location which will have
> >> bigger space for applying overlay?
> >>
> > Do you mean to move it to a predefined address like existing
> > CONFIG_BLOBLIST_ADDR with more space reserved? I am open to it.
>
> I don't want this because I don't want to define address where it should be.
> I want to have one universal bootloader which can run from different memory
> locations and relocate based on information in DT/TL.
>
Agree. Me too.

> I just want to make sure that description declare that properly how it is
> supposed to be used.
>
Will add more descriptions.

> > But what I have to say is that the entry memory can only be marked
> > with void, no reclaim memory mechanisms. This leads to duplicated
> > memory ranges.
> > Other than that, I think dynamically increasing/shrinking the size is
> > more flexible.
>
> I have to take a look how exactly this is working. I though that you can reclaim
> that memory back. We plan to have limited space (6MB) for TL. There are going to
> be multiple DT overlays inside. It means I don't want to be any close to 6MB limit.
>
One solution might be to move the base DT to the TL tail, and reclaim
the memory of the old one.
Memory reclaim is a good-to-have feature especially for those big TEs
though it is not a mandatory requirement of the spec.
I had some discussions with spec community members before but didn't
put it into the plan yet.
If you think that has an advantage please feel free to raise it at the
SC meeting.

>
> >> Isn't it also worth to check if existing CONTROL_FDT has enough space inside
> >> that new overlay can fit there before resizing it?
> > By default each entry only contains the actual size since bloblist
> > (aka transfer list) is designed as a compact data structure and there
> > should not be a waiver for CONTROL_FDT to carry additional spare
> > spaces.
>
> Right but you can build dtb via dtc -S/-p to add additional padding. It means
> dtb will be bigger which goes to TL and should be possible to fit overlay there.
>
Yes, a developer knows exactly how big the merged DT should be...but
it is only DT specific and not a common case for applying other blob
data.
Maybe I can add a DT Kconfig for skipping resizing for the use case
you mentioned if all reviewers agree.

>
> >>
> >>
> >>> +
> >>> +     /* The blob is shifted if it was following the FDT */
> >>> +     if (*blob > (void *)live_fdt)
> >>> +             *blob += expand_by;
> >>> +
> >>> +     ret = fdt_open_into(live_fdt, live_fdt, new_fdt_size);
> >>> +     if (ret)
> >>> +             return ret;
> >>> +
> >>> +     ret = fdt_overlay_apply_verbose(live_fdt, *blob);
> >>> +     if (ret)
> >>> +             return ret;
> >>> +
> >>> +     /* Shrink the excessive spaces */
> >>> +     fdt_pack(live_fdt);
> >>> +     new_fdt_size = fdt_totalsize(live_fdt);
> >>> +     ret = bloblist_resize(BLOBLISTT_CONTROL_FDT, new_fdt_size, &expand_by);
> >>> +     if (ret)
> >>> +             return ret;
> >>
> >> I didn't try to run on HW but don't you need to also adjust gd->fdt_blob to
> >> point to current location where fdt is?
> >>
> > gd->fdt_blob is already pointed to the one inside TL, it remains the
> > same, only the size is changed.
>
> I though that you are moving base DTB inside TL list. Isn't this the case?
> I have to do closer look and debug your code to understand it better.
>
The base DT address won't change until relocation via calling
'bloblist_reloc()'.

Regards,
Raymond

> Thanks,
> Michal
>
