Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1820FC71153
	for <u-boot@archiver.kernel.org>; Sun, 10 Sep 2023 23:15:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D9EC86B94;
	Mon, 11 Sep 2023 01:15:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MrrRfyc4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D27B786B0E; Mon, 11 Sep 2023 01:15:13 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5D1086C0B
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 01:15:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-52bcd4db4cbso4819246a12.1
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 16:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694387707; x=1694992507; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=roBaD4d3ys+Lf7KIHwoN1UK2lqg/pcjZSXV0GHlyOnk=;
 b=MrrRfyc456TLxRA6yfqF4vTaGzZSnEBi39+EWgQ7Ln31prgx8uGsV96XGX35qVczYG
 sZCMkYmiOG4tY3gSmFQ9LJNs0Fsm87l99LhVgzaV6KxnR/AIpYLpDxrd9zNcRoGqZIvj
 edOdu6m5S5heL+M5g/aQNzOrCPTBp78/MAPZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694387707; x=1694992507;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=roBaD4d3ys+Lf7KIHwoN1UK2lqg/pcjZSXV0GHlyOnk=;
 b=t283V84zXrn5rSH5ThSx+KZ6A9FdH05U/ZlBn09YnpLMB9HrDV8pfamPhxtul6wNEo
 RvShpns5f/ReymwXlNgCY4n0buocjAhQYy8MBYXh96FO30jIZp9wcwqjK6B2BWmxxnaU
 t6k2n2AH9SY2z7kKNqCjtjiyD6zwVwBgMYST246pfpIgUNTiIeMy+6+Xwaez+WH6AOcT
 u9qsmVlcuW0nx9CH0UQAQ7N8IcKe6nvfo8F04Nd/+qFt6wjQTAAEfu0BfO1vLpVF0+0O
 ITUMGW95XV6wK0jRCzCmX9ZchQFK+RllZuqKtfcsWh8j7zIGUGo5Q/2GwCW8/QxvNb0w
 81Fw==
X-Gm-Message-State: AOJu0Yx10yvN5U4hoPr6EHcbI8mDi7J0RBrgAJanXhqacsN6I3lhxL2m
 vLjOFvL9w7EH8XJjUEGfjS7Gi/KT+JPGXYUwZbloMA==
X-Google-Smtp-Source: AGHT+IFy9h3aRXTbGY4TVg0yRg3Po3bJKVCXfmA8Y5Fdgd1qaoGXR90lHme07B7jECiKywkI5MkhSsIgRMwxz8b1yks=
X-Received: by 2002:a05:6402:795:b0:52a:1d9c:83f2 with SMTP id
 d21-20020a056402079500b0052a1d9c83f2mr7268960edy.23.1694387706939; Sun, 10
 Sep 2023 16:15:06 -0700 (PDT)
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
In-Reply-To: <20230817151032.GG1515023@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 10 Sep 2023 17:14:55 -0600
Message-ID: <CAPnjgZ0Mb-4Fcq+j-nRJbpN9gr9=SFsTtDQUx2WqVzbjAqFPXw@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] board_f: Fix corruption of relocaddr
To: Tom Rini <trini@konsulko.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, Bin Meng <bmeng.cn@gmail.com>, 
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

On Thu, 17 Aug 2023 at 09:10, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Aug 16, 2023 at 09:16:05PM +0530, Devarsh Thakkar wrote:
> > Hi Simon,
> >
> > On 15/08/23 20:14, Simon Glass wrote:
> > > Hi Devarsh,
> > >
> > > On Tue, 15 Aug 2023 at 03:23, Devarsh Thakkar <devarsht@ti.com> wrote=
:
> > >>
> > >> Hi Simon, Tom,
> > >>
> > >> On 15/08/23 04:13, Simon Glass wrote:
> > >>> Hi Devarsh, Nikhil, Tom,
> > >>>
> > >>> On Wed, 9 Aug 2023 at 09:29, Bin Meng <bmeng.cn@gmail.com> wrote:
> > >>>>
> > >>>> On Thu, Aug 3, 2023 at 7:03=E2=80=AFPM Bin Meng <bmeng.cn@gmail.co=
m> wrote:
> > >>>>>
> > >>>>> On Thu, Aug 3, 2023 at 6:37=E2=80=AFPM Bin Meng <bmeng.cn@gmail.c=
om> wrote:
> > >>>>>>
> > >>>>>> On Tue, Aug 1, 2023 at 12:00=E2=80=AFAM Simon Glass <sjg@chromiu=
m.org> wrote:
> > >>>>>>>
> > >>>>>>> When the video framebuffer comes from the bloblist, we should n=
ot change
> > >>>>>>> relocaddr to this address, since it interfers with the normal m=
emory
> > >>>>>>
> > >>>>>> typo: interferes
> > >>>>>>
> > >>>>>>> allocation.
> > >>>>>>>
> > >>>>>>> This fixes a boot loop in qemu-x86_64
> > >>>>>>>
> > >>>>>>> Signed-off-by: Simon Glass <sjg@chromium.org>
> > >>>>>>> Fixes: 5bc610a7d9d ("common: board_f: Pass frame buffer info fr=
om SPL to u-boot")
> > >>>>>>> Suggested-by: Nikhil M Jain <n-jain1@ti.com>
> > >>>>>>> ---
> > >>>>>>>
> > >>>>>>> Changes in v3:
> > >>>>>>> - Reword the Kconfig help as suggested
> > >>>>>>>
> > >>>>>>> Changes in v2:
> > >>>>>>> - Add a Kconfig as the suggested conditional did not work
> > >>>>>>>
> > >>>>>>>   common/board_f.c      | 3 ++-
> > >>>>>>>   drivers/video/Kconfig | 9 +++++++++
> > >>>>>>>   2 files changed, 11 insertions(+), 1 deletion(-)
> > >>>>>>>
> > >>>>>>> diff --git a/common/board_f.c b/common/board_f.c
> > >>>>>>> index 7d2c380e91e..5173d0a0c2d 100644
> > >>>>>>> --- a/common/board_f.c
> > >>>>>>> +++ b/common/board_f.c
> > >>>>>>> @@ -419,7 +419,8 @@ static int reserve_video(void)
> > >>>>>>>                  if (!ho)
> > >>>>>>>                          return log_msg_ret("blf", -ENOENT);
> > >>>>>>>                  video_reserve_from_bloblist(ho);
> > >>>>>>> -               gd->relocaddr =3D ho->fb;
> > >>>>>>> +               if (IS_ENABLED(CONFIG_VIDEO_RESERVE_SPL))
> > >>>>>>> +                       gd->relocaddr =3D ho->fb;
> > >>>>>>>          } else if (CONFIG_IS_ENABLED(VIDEO)) {
> > >>>>>>>                  ulong addr;
> > >>>>>>>                  int ret;
> > >>>>>>> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> > >>>>>>> index b41dc60cec5..f2e56204d52 100644
> > >>>>>>> --- a/drivers/video/Kconfig
> > >>>>>>> +++ b/drivers/video/Kconfig
> > >>>>>>> @@ -1106,6 +1106,15 @@ config SPL_VIDEO_REMOVE
> > >>>>>>>            if this  option is enabled video driver will be remo=
ved at the end of
> > >>>>>>>            SPL stage, beforeloading the next stage.
> > >>>>>>>
> > >>>>>>> +config VIDEO_RESERVE_SPL
> > >>>>>>> +       bool
> > >>>>>>> +       help
> > >>>>>>> +         This adjusts reserve_video() to redirect memory reser=
vation when it
> > >>>>>>> +         sees a video handoff blob (BLOBLISTT_U_BOOT_VIDEO). T=
his avoids the
> > >>>>>>> +         memory used for framebuffer from being allocated by U=
-Boot proper,
> > >>>>>>> +         thus preventing any further memory reservations done =
by U-Boot proper
> > >>>>>>> +         from overwriting the framebuffer.
> > >>>>>>> +
> > >>>>>>>   if SPL_SPLASH_SCREEN
> > >>>>>>>
> > >>>>>>>   config SPL_SPLASH_SCREEN_ALIGN
> > >>>>>>
> > >>>>>> Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
> > >>>>>
> > >>>>> applied to u-boot-x86, thanks!
> > >>>>
> > >>>> Dropped this one from the x86 queue per the discussion.
> > >>>
> > >>> I just wanted to come back to this discussion.
> > >>>
> > >>> Do we have an agreed way forward? Who is waiting for who?
> > >>>
> > >>
> > >> I was waiting on feedback on
> > >> https://lore.kernel.org/all/3b1e8005-f161-8058-13e7-3de2316aac34@ti.=
com/
> > >> but per my opinion, I would prefer to go with "Approach 2" with a
> > >> Kconfig as it looks simpler to me. It would look something like belo=
w :
> > >>
> > >> if (gd->relocaddr > (unsigned long)ho->fb) {
> > >>       ulong fb_reloc_gap =3D gd->relocaddr - gd->ho->fb;
> > >>
> > >>       /* Relocate after framebuffer area if nearing too close to it =
*/
> > >>       if (fb_reloc_gap < CONFIG_BLOBLIST_FB_RELOC_MIN_GAP)
> > >>              gd->relocaddr =3D ho->fb;
> > >> }
> > >>
> > >> Regarding CONFIG_BLOBLIST_FB_RELOC_MIN_GAP
> > >> -> This describes minimum gap to keep between framebuffer address an=
d
> > >> relocation address to avoid overlap when framebuffer address used by
> > >> blob is below the current relocation address
> > >>
> > >> -> It would be selected as default when CONFIG_BLOBLIST is selected =
with
> > >>   default value set to 100Mb
> > >>
> > >> -> SoC specific Vendors can override this in their defconfigs to a
> > >> custom value if they feel 100Mb is not enough
> > >>
> > >> Also probably we can have some debug/error prints in the code to sho=
w
> > >> overlap happened (or is going happen) so that users can fine tune th=
is
> > >> Kconfig if they got it wrong at first place.
> > >>
> > >> I can re-spin updated patch if we are aligned on this,
> > >> Kindly let me know your opinion.
> > >
> > > I'm just nervous about the whole idea, TBH. Perhaps I am missing some
> > > documentation on how people are supposed to lay out memory in SPL and
> > > U-Boot properr, but I'm not really aware of any guidance we give.
> > >
> > > Perhaps we should say that the SPL frame buffer should be at the top
> > > of memory, and U-Boot's reserve area should start below that?
> >
> > 1) As per my personal opinion, I don't like putting such constraints an=
d would
> > instead like to give some flexibility to end user for choosing
> > framebuffer area as I earlier mentioned, as for that matter if we are u=
sing a
> > predefined address then there is no need of using framebuffer address o=
n
> > videoblob,
>
> I think this is the wrong direction.  We need to offer strong defaults
> that shouldn't be deviated without good reason, rather than "pick what
> you want".  Very few cases will deviate from the defaults, and of those
> it's hard to know if they're being changed for the best, or because
> someone didn't fully understand the implications and breaks something
> else.

So what is next with this? I would like to clean it up...I feel that
having SPL pass the top of usable RAM (below the framebuffer) is a
reasonable solution. Does constraining things in that way cause any
problems for TI?

Regards,
Simon
