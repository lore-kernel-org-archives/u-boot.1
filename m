Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8957EC001B0
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 14:45:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A73E869E2;
	Tue, 15 Aug 2023 16:44:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RCmsxY4E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6873C869AD; Tue, 15 Aug 2023 16:44:40 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36687869C9
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 16:44:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-99d937b83efso386464966b.3
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 07:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692110677; x=1692715477;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RYGAjiX2PyP9CzLGrFBMqjqIEqGZKwwiCYGiTIB8QhA=;
 b=RCmsxY4EMWpKeWhQnkdU3s8/7/CIIi8s5cZ57VIgdPI5k9Zq209Cttb7G7mBVvjFXz
 3ekh9Wr0jGZuKf54SiKhP359zu3cXogh7TLQZnvY0PEiFWnlBtB2LvBj575/6eLpzSoo
 MWfjdNSCb+lkRMJGxb8Bo6WfYE7oB/+QOJsdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692110677; x=1692715477;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RYGAjiX2PyP9CzLGrFBMqjqIEqGZKwwiCYGiTIB8QhA=;
 b=ekt3EkYPyINAzYTe2e+c9KHfj4XCRtWwGzHHZRKpXgVjeJ0C/ifMOG5J1PVcxSoUPu
 IfXNyGtd13F/IBen2pLJPlDlZbO8oR7SZlkWFh0WAgzmpECSHFh9YTEzeeNjb7bhBkTB
 B+0UqfNzMnkCjqieqTiEK+YqtRU2KJEOvs6Lnnu3NjDhlQPRBNi+eFWIhpeIvaGHjRW2
 cCh64YvEzaSi5llKfV5EgUTR5rK1wjc70Y54gT8FwQ2OeLAcjB5uvcFKnNXlu+qdEJqA
 UnZgJ4QGcBW12QCkCLM71O2dPn4uhP90XkshGwLiFSrdkUVWpzZ8ENMhwabvKKvGFREL
 RTlg==
X-Gm-Message-State: AOJu0YxnLvroUEkiF0jONIyWc0jDbVz4XApyKhfTExFahYJSrjJL9cNv
 6Udl/n+wAwa45vGXg2JwY5aFQeWLLZA95vL43p/ebQ==
X-Google-Smtp-Source: AGHT+IGOPTxy1LwYWNDwRr1+4NKLdhmnYQe3qsyCTBXeJAF2r3Yo3AkEg/wrxfIBNMdRR3HKVgD+qYyTCgOkuUx+lH0=
X-Received: by 2002:a17:906:1db:b0:99c:7eaa:28ec with SMTP id
 27-20020a17090601db00b0099c7eaa28ecmr9959063ejj.12.1692110676609; Tue, 15 Aug
 2023 07:44:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230731160008.82342-5-sjg@chromium.org>
 <CAEUhbmXn0VQ6B8Qfs+XWEBuPKQ0mtVbzNeH7ZmT+V1Yh1r5qWw@mail.gmail.com>
 <CAEUhbmU14kY-DpNEZyXJEWX4vbqFY-ANgEZZskqY_gxVv4rD5Q@mail.gmail.com>
 <CAEUhbmXMfoiKa7UXoLQNVPN0w59_Y+4Q4U6HzHoq63mH8930vA@mail.gmail.com>
 <CAPnjgZ1zSe6dL0Y5bKPPp_7VFXVqGzHTdm-rcgDvJo+iM-YrkA@mail.gmail.com>
 <99f81e66-9295-8e4c-1693-86e3d81a302c@ti.com>
In-Reply-To: <99f81e66-9295-8e4c-1693-86e3d81a302c@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 15 Aug 2023 08:44:23 -0600
Message-ID: <CAPnjgZ2EjOn86eQ-BdGH5F67Op3bSwG0BZb-LAbPOw955Srg0g@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] board_f: Fix corruption of relocaddr
To: Devarsh Thakkar <devarsht@ti.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, trini@konsulko.com, 
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

On Tue, 15 Aug 2023 at 03:23, Devarsh Thakkar <devarsht@ti.com> wrote:
>
> Hi Simon, Tom,
>
> On 15/08/23 04:13, Simon Glass wrote:
> > Hi Devarsh, Nikhil, Tom,
> >
> > On Wed, 9 Aug 2023 at 09:29, Bin Meng <bmeng.cn@gmail.com> wrote:
> >>
> >> On Thu, Aug 3, 2023 at 7:03=E2=80=AFPM Bin Meng <bmeng.cn@gmail.com> w=
rote:
> >>>
> >>> On Thu, Aug 3, 2023 at 6:37=E2=80=AFPM Bin Meng <bmeng.cn@gmail.com> =
wrote:
> >>>>
> >>>> On Tue, Aug 1, 2023 at 12:00=E2=80=AFAM Simon Glass <sjg@chromium.or=
g> wrote:
> >>>>>
> >>>>> When the video framebuffer comes from the bloblist, we should not c=
hange
> >>>>> relocaddr to this address, since it interfers with the normal memor=
y
> >>>>
> >>>> typo: interferes
> >>>>
> >>>>> allocation.
> >>>>>
> >>>>> This fixes a boot loop in qemu-x86_64
> >>>>>
> >>>>> Signed-off-by: Simon Glass <sjg@chromium.org>
> >>>>> Fixes: 5bc610a7d9d ("common: board_f: Pass frame buffer info from S=
PL to u-boot")
> >>>>> Suggested-by: Nikhil M Jain <n-jain1@ti.com>
> >>>>> ---
> >>>>>
> >>>>> Changes in v3:
> >>>>> - Reword the Kconfig help as suggested
> >>>>>
> >>>>> Changes in v2:
> >>>>> - Add a Kconfig as the suggested conditional did not work
> >>>>>
> >>>>>   common/board_f.c      | 3 ++-
> >>>>>   drivers/video/Kconfig | 9 +++++++++
> >>>>>   2 files changed, 11 insertions(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/common/board_f.c b/common/board_f.c
> >>>>> index 7d2c380e91e..5173d0a0c2d 100644
> >>>>> --- a/common/board_f.c
> >>>>> +++ b/common/board_f.c
> >>>>> @@ -419,7 +419,8 @@ static int reserve_video(void)
> >>>>>                  if (!ho)
> >>>>>                          return log_msg_ret("blf", -ENOENT);
> >>>>>                  video_reserve_from_bloblist(ho);
> >>>>> -               gd->relocaddr =3D ho->fb;
> >>>>> +               if (IS_ENABLED(CONFIG_VIDEO_RESERVE_SPL))
> >>>>> +                       gd->relocaddr =3D ho->fb;
> >>>>>          } else if (CONFIG_IS_ENABLED(VIDEO)) {
> >>>>>                  ulong addr;
> >>>>>                  int ret;
> >>>>> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> >>>>> index b41dc60cec5..f2e56204d52 100644
> >>>>> --- a/drivers/video/Kconfig
> >>>>> +++ b/drivers/video/Kconfig
> >>>>> @@ -1106,6 +1106,15 @@ config SPL_VIDEO_REMOVE
> >>>>>            if this  option is enabled video driver will be removed =
at the end of
> >>>>>            SPL stage, beforeloading the next stage.
> >>>>>
> >>>>> +config VIDEO_RESERVE_SPL
> >>>>> +       bool
> >>>>> +       help
> >>>>> +         This adjusts reserve_video() to redirect memory reservati=
on when it
> >>>>> +         sees a video handoff blob (BLOBLISTT_U_BOOT_VIDEO). This =
avoids the
> >>>>> +         memory used for framebuffer from being allocated by U-Boo=
t proper,
> >>>>> +         thus preventing any further memory reservations done by U=
-Boot proper
> >>>>> +         from overwriting the framebuffer.
> >>>>> +
> >>>>>   if SPL_SPLASH_SCREEN
> >>>>>
> >>>>>   config SPL_SPLASH_SCREEN_ALIGN
> >>>>
> >>>> Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
> >>>
> >>> applied to u-boot-x86, thanks!
> >>
> >> Dropped this one from the x86 queue per the discussion.
> >
> > I just wanted to come back to this discussion.
> >
> > Do we have an agreed way forward? Who is waiting for who?
> >
>
> I was waiting on feedback on
> https://lore.kernel.org/all/3b1e8005-f161-8058-13e7-3de2316aac34@ti.com/
> but per my opinion, I would prefer to go with "Approach 2" with a
> Kconfig as it looks simpler to me. It would look something like below :
>
> if (gd->relocaddr > (unsigned long)ho->fb) {
>       ulong fb_reloc_gap =3D gd->relocaddr - gd->ho->fb;
>
>       /* Relocate after framebuffer area if nearing too close to it */
>       if (fb_reloc_gap < CONFIG_BLOBLIST_FB_RELOC_MIN_GAP)
>              gd->relocaddr =3D ho->fb;
> }
>
> Regarding CONFIG_BLOBLIST_FB_RELOC_MIN_GAP
> -> This describes minimum gap to keep between framebuffer address and
> relocation address to avoid overlap when framebuffer address used by
> blob is below the current relocation address
>
> -> It would be selected as default when CONFIG_BLOBLIST is selected with
>   default value set to 100Mb
>
> -> SoC specific Vendors can override this in their defconfigs to a
> custom value if they feel 100Mb is not enough
>
> Also probably we can have some debug/error prints in the code to show
> overlap happened (or is going happen) so that users can fine tune this
> Kconfig if they got it wrong at first place.
>
> I can re-spin updated patch if we are aligned on this,
> Kindly let me know your opinion.

I'm just nervous about the whole idea, TBH. Perhaps I am missing some
documentation on how people are supposed to lay out memory in SPL and
U-Boot properr, but I'm not really aware of any guidance we give.

Perhaps we should say that the SPL frame buffer should be at the top
of memory, and U-Boot's reserve area should start below that?

Regards,
Simon
