Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 305D8C001DB
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 22:45:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 834CC86A3C;
	Tue, 15 Aug 2023 00:43:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HcajIwGE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCCE786A20; Tue, 15 Aug 2023 00:43:51 +0200 (CEST)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CDA3869E3
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 00:43:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-cfcebc33d04so4718032276.2
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 15:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692053027; x=1692657827;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=prHUWXjS1xmOyXdfOn5kI6fbfxhC7Ea3MHVSU6xBEOs=;
 b=HcajIwGEG+a9inwpBKRkahwpZc/xtEBCmJP1rdsKqis+brdIZqD+bPm3Zq3y+nWGj3
 YgAi1CaU2spHc4Nio/pzsjpH1zowPmmneOJk3FtNh7oTV7qTkCXhsKS1SFpytlv9qGbG
 Cxg+pVc3/IRyjY1f9fg7l6nfRjjs3dOEZOUO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692053027; x=1692657827;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=prHUWXjS1xmOyXdfOn5kI6fbfxhC7Ea3MHVSU6xBEOs=;
 b=QzFU9UFep/ESGBvF4XmW1hAAfhU566ieuvdDucHTULbRwUpjZjYpCgcsesT+jaD/yi
 wtlKF2HtyX3vbQbLqEnAEI/x0/TR5418notYZZyXKNsvq/zRFlgvbh6DJCHcyEO5Jya1
 QCYZkgonw6QZCjmFQqb2x4N0WSDfxVHmS9LU2At5L0eXkyZQiI+ZmQ3hK6WeYHNVO9nS
 onrrCDMHh0iThO8rPZxp7sUpqdeOakXTNdyJ/q+9zyRW+IGgPfGs6M6JDGphLDyUgcma
 QG2gkxc+QXoZX6GgyS/Jn4LMGYbQmyuQNnt/4/6Ci0CxsIRN5/n9sXENdd46gTzn6dly
 hKsw==
X-Gm-Message-State: AOJu0YxHlRK5vHAezUd11s632ROp63k6wLKQV7IYYjLFegN41VMi38lL
 5SbGPrsqPKCLuG9/LSXDcKcNt6o08EDX3IdZducG6iGx+qQioyabDs0=
X-Google-Smtp-Source: AGHT+IHZoD/D/cqbjX7HkxJYvkSe6pIWl9GMd1mFILq7O1mU2knVi3/lnKr2fr9Ptvnk6GFd5jNchRGklK6ajUtn4TU=
X-Received: by 2002:a25:4112:0:b0:d0a:127e:7478 with SMTP id
 o18-20020a254112000000b00d0a127e7478mr12277309yba.44.1692053026603; Mon, 14
 Aug 2023 15:43:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230731160008.82342-5-sjg@chromium.org>
 <CAEUhbmXn0VQ6B8Qfs+XWEBuPKQ0mtVbzNeH7ZmT+V1Yh1r5qWw@mail.gmail.com>
 <CAEUhbmU14kY-DpNEZyXJEWX4vbqFY-ANgEZZskqY_gxVv4rD5Q@mail.gmail.com>
 <CAEUhbmXMfoiKa7UXoLQNVPN0w59_Y+4Q4U6HzHoq63mH8930vA@mail.gmail.com>
In-Reply-To: <CAEUhbmXMfoiKa7UXoLQNVPN0w59_Y+4Q4U6HzHoq63mH8930vA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 14 Aug 2023 16:43:02 -0600
Message-ID: <CAPnjgZ1zSe6dL0Y5bKPPp_7VFXVqGzHTdm-rcgDvJo+iM-YrkA@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] board_f: Fix corruption of relocaddr
To: Bin Meng <bmeng.cn@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Nikhil M Jain <n-jain1@ti.com>,
 Anatolij Gustschin <agust@denx.de>, Devarsh Thakkar <devarsht@ti.com>,
 Michal Suchanek <msuchanek@suse.de>, Ovidiu Panait <ovpanait@gmail.com>,
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

Hi Devarsh, Nikhil, Tom,

On Wed, 9 Aug 2023 at 09:29, Bin Meng <bmeng.cn@gmail.com> wrote:
>
> On Thu, Aug 3, 2023 at 7:03=E2=80=AFPM Bin Meng <bmeng.cn@gmail.com> wrot=
e:
> >
> > On Thu, Aug 3, 2023 at 6:37=E2=80=AFPM Bin Meng <bmeng.cn@gmail.com> wr=
ote:
> > >
> > > On Tue, Aug 1, 2023 at 12:00=E2=80=AFAM Simon Glass <sjg@chromium.org=
> wrote:
> > > >
> > > > When the video framebuffer comes from the bloblist, we should not c=
hange
> > > > relocaddr to this address, since it interfers with the normal memor=
y
> > >
> > > typo: interferes
> > >
> > > > allocation.
> > > >
> > > > This fixes a boot loop in qemu-x86_64
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > Fixes: 5bc610a7d9d ("common: board_f: Pass frame buffer info from S=
PL to u-boot")
> > > > Suggested-by: Nikhil M Jain <n-jain1@ti.com>
> > > > ---
> > > >
> > > > Changes in v3:
> > > > - Reword the Kconfig help as suggested
> > > >
> > > > Changes in v2:
> > > > - Add a Kconfig as the suggested conditional did not work
> > > >
> > > >  common/board_f.c      | 3 ++-
> > > >  drivers/video/Kconfig | 9 +++++++++
> > > >  2 files changed, 11 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/common/board_f.c b/common/board_f.c
> > > > index 7d2c380e91e..5173d0a0c2d 100644
> > > > --- a/common/board_f.c
> > > > +++ b/common/board_f.c
> > > > @@ -419,7 +419,8 @@ static int reserve_video(void)
> > > >                 if (!ho)
> > > >                         return log_msg_ret("blf", -ENOENT);
> > > >                 video_reserve_from_bloblist(ho);
> > > > -               gd->relocaddr =3D ho->fb;
> > > > +               if (IS_ENABLED(CONFIG_VIDEO_RESERVE_SPL))
> > > > +                       gd->relocaddr =3D ho->fb;
> > > >         } else if (CONFIG_IS_ENABLED(VIDEO)) {
> > > >                 ulong addr;
> > > >                 int ret;
> > > > diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> > > > index b41dc60cec5..f2e56204d52 100644
> > > > --- a/drivers/video/Kconfig
> > > > +++ b/drivers/video/Kconfig
> > > > @@ -1106,6 +1106,15 @@ config SPL_VIDEO_REMOVE
> > > >           if this  option is enabled video driver will be removed a=
t the end of
> > > >           SPL stage, beforeloading the next stage.
> > > >
> > > > +config VIDEO_RESERVE_SPL
> > > > +       bool
> > > > +       help
> > > > +         This adjusts reserve_video() to redirect memory reservati=
on when it
> > > > +         sees a video handoff blob (BLOBLISTT_U_BOOT_VIDEO). This =
avoids the
> > > > +         memory used for framebuffer from being allocated by U-Boo=
t proper,
> > > > +         thus preventing any further memory reservations done by U=
-Boot proper
> > > > +         from overwriting the framebuffer.
> > > > +
> > > >  if SPL_SPLASH_SCREEN
> > > >
> > > >  config SPL_SPLASH_SCREEN_ALIGN
> > >
> > > Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
> >
> > applied to u-boot-x86, thanks!
>
> Dropped this one from the x86 queue per the discussion.

I just wanted to come back to this discussion.

Do we have an agreed way forward? Who is waiting for who?

Regards,
Simon
