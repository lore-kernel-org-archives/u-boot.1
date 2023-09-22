Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AC32CD4850
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 18:30:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52B7D86B56;
	Fri, 22 Sep 2023 20:29:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ii5tZ3+R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08FBE8654D; Fri, 22 Sep 2023 20:29:22 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E446786B86
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 20:29:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-59c0b9ad491so30555447b3.1
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 11:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695407354; x=1696012154; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XOiWxPqYEmICwUidEUYINjjdMi+LgO54GCQVYIFPzC0=;
 b=ii5tZ3+RlAy8YfVtTImq5tjjIZB0H50fTAtxobZpEUoNXUnIHwOIiGz0OQxQ6jM8PS
 MfXe9YS2a0RBLkARsLqywx0Ypp1gWMKv+ALGsSdRWW+X63L1pFOPyadVrHUMbuqgng/Z
 TWnJuHfxCWnP+wk5An+omwFES38rqqLOYfx1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695407354; x=1696012154;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XOiWxPqYEmICwUidEUYINjjdMi+LgO54GCQVYIFPzC0=;
 b=P/Lip0UN1BeECK3wnwwz5JLx7M5KuUry/+sh8MF9+mDoJCPqDvGV1jGGSTo3MpEMd2
 BX0B6kkxou06dPWZeKiacU50/fpGI6zex/KHzH1yf0KHqGogU04FBgvo5CZjDZNQY/eq
 /LAmBjsnGoeyXKQ7CPv2GNPfd7atfKIecvz1kKREh2JHyNLvFY4BERF+RY/WIP5kOgPg
 uyu45wxQuMz8FGEXIfKDwa3oa2pJdiwlNRNpHRd0neV6V0o4eMFGmvxu5OBWEywR9oEJ
 4VwXNDXeK8BFRKW+W9pCenbg2Ww7nM63tWTZ0IpyP0tJs8e44P/632o1gY1XZaffCOwV
 8x2A==
X-Gm-Message-State: AOJu0YyKWaG20CZ9JOtFJkeAWB3xhxy3e5yFKVgmUi4oJphdWRQcDoJm
 rnZXio+wRguin8jFJNadlN4ix7nxbhWIfkjz03Ckn4iKKiXLEf/z3U8=
X-Google-Smtp-Source: AGHT+IFksE75xGvcI58AN29RXZz1wBW4CP4Lcq3kdTLTy8YZOzvzAf6suXAxHxqGvYioE90MbX/cBkm9nSEPyG7s51g=
X-Received: by 2002:a81:a003:0:b0:59c:961:ead with SMTP id
 x3-20020a81a003000000b0059c09610eadmr445252ywg.41.1695407354421; 
 Fri, 22 Sep 2023 11:29:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230731160008.82342-5-sjg@chromium.org>
 <CAEUhbmXn0VQ6B8Qfs+XWEBuPKQ0mtVbzNeH7ZmT+V1Yh1r5qWw@mail.gmail.com>
 <CAEUhbmU14kY-DpNEZyXJEWX4vbqFY-ANgEZZskqY_gxVv4rD5Q@mail.gmail.com>
 <CAEUhbmXMfoiKa7UXoLQNVPN0w59_Y+4Q4U6HzHoq63mH8930vA@mail.gmail.com>
 <CAPnjgZ1zSe6dL0Y5bKPPp_7VFXVqGzHTdm-rcgDvJo+iM-YrkA@mail.gmail.com>
 <99f81e66-9295-8e4c-1693-86e3d81a302c@ti.com>
 <CAPnjgZ2EjOn86eQ-BdGH5F67Op3bSwG0BZb-LAbPOw955Srg0g@mail.gmail.com>
 <328fb0cf-5f98-019f-49f8-30674c9d34e1@ti.com>
 <20230817151032.GG1515023@bill-the-cat>
 <CAPnjgZ0Mb-4Fcq+j-nRJbpN9gr9=SFsTtDQUx2WqVzbjAqFPXw@mail.gmail.com>
 <ece7bb9b-29da-93d6-2aa9-746b296b1464@ti.com>
In-Reply-To: <ece7bb9b-29da-93d6-2aa9-746b296b1464@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 22 Sep 2023 12:27:27 -0600
Message-ID: <CAPnjgZ3Y5oKMuQ1jsNUyARw8MniEt4g8ebiU1-o81M0Tkoopiw@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] board_f: Fix corruption of relocaddr
To: Devarsh Thakkar <devarsht@ti.com>
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>, Nikhil M Jain <n-jain1@ti.com>, 
 Anatolij Gustschin <agust@denx.de>, Michal Suchanek <msuchanek@suse.de>,
 Ovidiu Panait <ovpanait@gmail.com>, 
 =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Stefan Roese <sr@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, 12 Sept 2023 at 08:35, Devarsh Thakkar <devarsht@ti.com> wrote:
>
> Hi Simon,
>
> On 11/09/23 04:44, Simon Glass wrote:
> > Hi Devarsh,
> >
> > On Thu, 17 Aug 2023 at 09:10, Tom Rini <trini@konsulko.com> wrote:
> >>
> >> On Wed, Aug 16, 2023 at 09:16:05PM +0530, Devarsh Thakkar wrote:
> >>> Hi Simon,
> >>>
> >>> On 15/08/23 20:14, Simon Glass wrote:
> >>>> Hi Devarsh,
> >>>>
> >>>> On Tue, 15 Aug 2023 at 03:23, Devarsh Thakkar <devarsht@ti.com> wrot=
e:
> >>>>>
> >>>>> Hi Simon, Tom,
> >>>>>
> >>>>> On 15/08/23 04:13, Simon Glass wrote:
> >>>>>> Hi Devarsh, Nikhil, Tom,
> >>>>>>
> >>>>>> On Wed, 9 Aug 2023 at 09:29, Bin Meng <bmeng.cn@gmail.com> wrote:
> >>>>>>>
> >>>>>>> On Thu, Aug 3, 2023 at 7:03=E2=80=AFPM Bin Meng <bmeng.cn@gmail.c=
om> wrote:
> >>>>>>>>
> >>>>>>>> On Thu, Aug 3, 2023 at 6:37=E2=80=AFPM Bin Meng <bmeng.cn@gmail.=
com> wrote:
> >>>>>>>>>
> >>>>>>>>> On Tue, Aug 1, 2023 at 12:00=E2=80=AFAM Simon Glass <sjg@chromi=
um.org> wrote:
> >>>>>>>>>>
> >>>>>>>>>> When the video framebuffer comes from the bloblist, we should =
not change
> >>>>>>>>>> relocaddr to this address, since it interfers with the normal =
memory
> >>>>>>>>>
> >>>>>>>>> typo: interferes
> >>>>>>>>>
> >>>>>>>>>> allocation.
> >>>>>>>>>>
> >>>>>>>>>> This fixes a boot loop in qemu-x86_64
> >>>>>>>>>>
> >>>>>>>>>> Signed-off-by: Simon Glass <sjg@chromium.org>
> >>>>>>>>>> Fixes: 5bc610a7d9d ("common: board_f: Pass frame buffer info f=
rom SPL to u-boot")
> >>>>>>>>>> Suggested-by: Nikhil M Jain <n-jain1@ti.com>
> >>>>>>>>>> ---
> >>>>>>>>>>
> >>>>>>>>>> Changes in v3:
> >>>>>>>>>> - Reword the Kconfig help as suggested
> >>>>>>>>>>
> >>>>>>>>>> Changes in v2:
> >>>>>>>>>> - Add a Kconfig as the suggested conditional did not work
> >>>>>>>>>>
> >>>>>>>>>>   common/board_f.c      | 3 ++-
> >>>>>>>>>>   drivers/video/Kconfig | 9 +++++++++
> >>>>>>>>>>   2 files changed, 11 insertions(+), 1 deletion(-)
> >>>>>>>>>>
> >>>>>>>>>> diff --git a/common/board_f.c b/common/board_f.c
> >>>>>>>>>> index 7d2c380e91e..5173d0a0c2d 100644
> >>>>>>>>>> --- a/common/board_f.c
> >>>>>>>>>> +++ b/common/board_f.c
> >>>>>>>>>> @@ -419,7 +419,8 @@ static int reserve_video(void)
> >>>>>>>>>>                  if (!ho)
> >>>>>>>>>>                          return log_msg_ret("blf", -ENOENT);
> >>>>>>>>>>                  video_reserve_from_bloblist(ho);
> >>>>>>>>>> -               gd->relocaddr =3D ho->fb;
> >>>>>>>>>> +               if (IS_ENABLED(CONFIG_VIDEO_RESERVE_SPL))
> >>>>>>>>>> +                       gd->relocaddr =3D ho->fb;
> >>>>>>>>>>          } else if (CONFIG_IS_ENABLED(VIDEO)) {
> >>>>>>>>>>                  ulong addr;
> >>>>>>>>>>                  int ret;
> >>>>>>>>>> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> >>>>>>>>>> index b41dc60cec5..f2e56204d52 100644
> >>>>>>>>>> --- a/drivers/video/Kconfig
> >>>>>>>>>> +++ b/drivers/video/Kconfig
> >>>>>>>>>> @@ -1106,6 +1106,15 @@ config SPL_VIDEO_REMOVE
> >>>>>>>>>>            if this  option is enabled video driver will be rem=
oved at the end of
> >>>>>>>>>>            SPL stage, beforeloading the next stage.
> >>>>>>>>>>
> >>>>>>>>>> +config VIDEO_RESERVE_SPL
> >>>>>>>>>> +       bool
> >>>>>>>>>> +       help
> >>>>>>>>>> +         This adjusts reserve_video() to redirect memory rese=
rvation when it
> >>>>>>>>>> +         sees a video handoff blob (BLOBLISTT_U_BOOT_VIDEO). =
This avoids the
> >>>>>>>>>> +         memory used for framebuffer from being allocated by =
U-Boot proper,
> >>>>>>>>>> +         thus preventing any further memory reservations done=
 by U-Boot proper
> >>>>>>>>>> +         from overwriting the framebuffer.
> >>>>>>>>>> +
> >>>>>>>>>>   if SPL_SPLASH_SCREEN
> >>>>>>>>>>
> >>>>>>>>>>   config SPL_SPLASH_SCREEN_ALIGN
> >>>>>>>>>
> >>>>>>>>> Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
> >>>>>>>>
> >>>>>>>> applied to u-boot-x86, thanks!
> >>>>>>>
> >>>>>>> Dropped this one from the x86 queue per the discussion.
> >>>>>>
> >>>>>> I just wanted to come back to this discussion.
> >>>>>>
> >>>>>> Do we have an agreed way forward? Who is waiting for who?
> >>>>>>
> >>>>>
> >>>>> I was waiting on feedback on
> >>>>> https://lore.kernel.org/all/3b1e8005-f161-8058-13e7-3de2316aac34@ti=
.com/
> >>>>> but per my opinion, I would prefer to go with "Approach 2" with a
> >>>>> Kconfig as it looks simpler to me. It would look something like bel=
ow :
> >>>>>
> >>>>> if (gd->relocaddr > (unsigned long)ho->fb) {
> >>>>>       ulong fb_reloc_gap =3D gd->relocaddr - gd->ho->fb;
> >>>>>
> >>>>>       /* Relocate after framebuffer area if nearing too close to it=
 */
> >>>>>       if (fb_reloc_gap < CONFIG_BLOBLIST_FB_RELOC_MIN_GAP)
> >>>>>              gd->relocaddr =3D ho->fb;
> >>>>> }
> >>>>>
> >>>>> Regarding CONFIG_BLOBLIST_FB_RELOC_MIN_GAP
> >>>>> -> This describes minimum gap to keep between framebuffer address a=
nd
> >>>>> relocation address to avoid overlap when framebuffer address used b=
y
> >>>>> blob is below the current relocation address
> >>>>>
> >>>>> -> It would be selected as default when CONFIG_BLOBLIST is selected=
 with
> >>>>>   default value set to 100Mb
> >>>>>
> >>>>> -> SoC specific Vendors can override this in their defconfigs to a
> >>>>> custom value if they feel 100Mb is not enough
> >>>>>
> >>>>> Also probably we can have some debug/error prints in the code to sh=
ow
> >>>>> overlap happened (or is going happen) so that users can fine tune t=
his
> >>>>> Kconfig if they got it wrong at first place.
> >>>>>
> >>>>> I can re-spin updated patch if we are aligned on this,
> >>>>> Kindly let me know your opinion.
> >>>>
> >>>> I'm just nervous about the whole idea, TBH. Perhaps I am missing som=
e
> >>>> documentation on how people are supposed to lay out memory in SPL an=
d
> >>>> U-Boot properr, but I'm not really aware of any guidance we give.
> >>>>
> >>>> Perhaps we should say that the SPL frame buffer should be at the top
> >>>> of memory, and U-Boot's reserve area should start below that?
> >>>
> >>> 1) As per my personal opinion, I don't like putting such constraints =
and would
> >>> instead like to give some flexibility to end user for choosing
> >>> framebuffer area as I earlier mentioned, as for that matter if we are=
 using a
> >>> predefined address then there is no need of using framebuffer address=
 on
> >>> videoblob,
> >>
> >> I think this is the wrong direction.  We need to offer strong defaults
> >> that shouldn't be deviated without good reason, rather than "pick what
> >> you want".  Very few cases will deviate from the defaults, and of thos=
e
> >> it's hard to know if they're being changed for the best, or because
> >> someone didn't fully understand the implications and breaks something
> >> else.
> >
> > So what is next with this? I would like to clean it up...I feel that
> > having SPL pass the top of usable RAM (below the framebuffer) is a
> > reasonable solution. Does constraining things in that way cause any
> > problems for TI?
>
> TBH, I am not fully able to visualize how this fits current arch :
>
> So instead of blob address will we be passing ram_top inside the video bl=
ob ?
> .Or we will be using separate ram_top blob passing from SPL to u-boot ?

Yes, a separate ram_top in the bloblist, not in the video blob.

>
> Are we planning to enforce some restriction/hardcoding for framebuffer to=
 be
> reserved at specific address (near top of RAM) or it would be just a gene=
ral
> guideline to keep framebuffer near the RAM top ?

Well it makes sense to put it at the top, since U-Boot relocations
itself to the top.

>
> Currently don't see video_reserve API put such constraint and user is fre=
e to
> call it anywhere and it just reserve after previously reserved areas. Now=
,
> with this approach I guess we would deviate from the agnostic behavior of
> video_reserve API then if we plan to update the same API ?
>
> Also u-boot proper starts reserving regions for MMU and few other stuff m=
uch
> before reserving framebuffers so by the time we receive the blob containi=
ng
> updated ram_top, we would have already reserved those regions from old ra=
m_top
>  so moving the ram_top here seems little counter-intuitive to me. In such
> scenario, as per my opinion better option seems to be moving he gd->reloc=
addr
> instead.
>
> Lastly, I think as much the user keep framebuffer way from ram_top that m=
uch
> memory will be lost even with this approach (as ram_top will be moved aft=
er
> framebuffer for u-boot proper) and same behavior will be observed with
> https://lore.kernel.org/all/20230801140414.76216-1-devarsht@ti.com/ too
>
> but if we are planning to put just a general guideline to user to keep
> framebuffer near the RAM top then to me above patch looks much simpler th=
an
> moving the ram_top.

I don't really have any more to say here. This is all just confusing
and I don't think it needs to be. If SPL allocs stuff, I believe it
should do so at the top of memory, then tell U-Boot about it, so
U-Boot's reservations can happen below that address.

Regards,
Simon
