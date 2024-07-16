Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A635EC3DA49
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 06:26:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E2AC8895F;
	Tue, 16 Jul 2024 08:26:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="h19eOXYy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC0778895E; Tue, 16 Jul 2024 08:26:21 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABA0888962
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 08:26:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-58d24201934so1558190a12.0
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 23:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721111178; x=1721715978; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5G72LMX6SMIcIwOOW314Cv+875KZS+PCyAk1NCG6UTc=;
 b=h19eOXYyBD8qAFTPU1WeyTHJY0bQNk4R8wwJ/FJcXAsOUOyVsICSKuCnIAinC6m98u
 sIQTMBWmku/XrZg2/nkw6C5zToANYxgHfIAndLKQmMDMRqu9b49g0Yx/e86nKWt7VTfE
 CoKIl+BtCuQbLopFErWH7lbuu6oatQYiUlYKcLrgmDcwd12VkX6TYSd+ZCcfZ5CDm90m
 2jqnUrZp329QUznhA/5t9NLoyjCzrxyi+lZvLu3zVOvcbM08rfbGnv9M8Iq1T/DxCg9D
 a4obO9Ho3gLidxrnfAppCPMV5RPlgwZ0Ap6O0kIn9KlYpOvNqhMxeoRKzvoBNpeP9dR+
 sT0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721111178; x=1721715978;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5G72LMX6SMIcIwOOW314Cv+875KZS+PCyAk1NCG6UTc=;
 b=o25VHE7+kD4MOsKEwtz9ruCiilh/B3kagvVWH1yP/SBoTFs6UeB5PunCPatgFN2qL2
 HxhZFN7YAx6jdK0iHouK4MwpwNRtiyXamOAp9VD0HuN3wKp2CZBB/Q6R6KhNVH0iy1wl
 a/QV/a8DMgiFvTMefaSp5SybZuJKCIjeaK6R4isyr9gnHGfqhHIs43rGDcMFU/n2ga3p
 6A9OEMOABe/i1kC2C5fv2WdGK3icCDxwXaXkpkLuLQKp7dcYlNRaG2bOI6E34Sj86q2A
 2+p2BvTzSOY/GWCl/r1ZWIxFChKfY1KTg3XTlqwu8PAGrIDVL05R0GeGd3imrYEoS5cy
 MVDA==
X-Gm-Message-State: AOJu0YwLNVUy7UQ99gYP75mS22SCIXh/4J8bX99mBHvql9J+RJIv+mAI
 Ju0BgwOAYVcohAi8pcl3mJsshS/2CQa+nickYynumw6gh7oCdgXJanl1Ue9LFJ6XnRZ0JdUv1yk
 AFyvNqQUsmogaDnU4eIv4JSPsgy8MlFW9wvuGD945800Hju7Y
X-Google-Smtp-Source: AGHT+IFXPKHTNqOXm7SM0+XIvK0z/g4AkWYzV+zJz7OsULs3fl5gIo8hBP7Zqc6oP1p7nYQrMPqUpdOQT8sSsVtLw6s=
X-Received: by 2002:a50:f697:0:b0:58b:8858:8034 with SMTP id
 4fb4d7f45d1cf-59f0b81a3a7mr704047a12.11.1721111177902; Mon, 15 Jul 2024
 23:26:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
 <20240704073544.670249-13-sughosh.ganu@linaro.org>
 <CAFLszTgp4GQydJY611gTOBnUk+Ce6o4vkVqNKtgcwKVzW9X6WQ@mail.gmail.com>
 <CADg8p94u_CYkek8tnPGtM8JOAn4QjMh5oLKCqvhRdj0M=H8GDA@mail.gmail.com>
 <CAFLszThFC8hW3nYoY=dfSdE_DgAT8UK762NuXy9LfR7Crd9=Ew@mail.gmail.com>
In-Reply-To: <CAFLszThFC8hW3nYoY=dfSdE_DgAT8UK762NuXy9LfR7Crd9=Ew@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 16 Jul 2024 11:56:06 +0530
Message-ID: <CADg8p94FT0HhZVQzj9NxRAAYqUX8KjS7KMKM-SxVidsP==NnYw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 12/48] lmb: allow for resizing lmb regions
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>, 
 Fabio Estevam <festevam@gmail.com>, Michal Simek <michal.simek@amd.com>
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

hi Simon,

On Mon, 15 Jul 2024 at 17:09, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> On Mon, 15 Jul 2024 at 10:27, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > hi Simon,
> >
> > On Sat, 13 Jul 2024 at 20:45, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Sughosh,
> > >
> > > On Thu, 4 Jul 2024 at 08:36, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > >
> > > > Allow for resizing of LMB regions if the region attributes match. The
> > > > current code returns a failure status on detecting an overlapping
> > > > address. This worked up until now since the LMB calls were not
> > > > persistent and global -- the LMB memory map was specific and private
> > > > to a given caller of the LMB API's.
> > > >
> > > > With the change in the LMB code to make the LMB reservations
> > > > persistent, there needs to be a check on whether the memory region can
> > > > be resized, and then do it if so. To distinguish between memory that
> > > > cannot be resized, add a new flag, LMB_NOOVERWRITE. Reserving a region
> > > > of memory with this attribute would indicate that the region cannot be
> > > > resized.
> > > >
> > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > ---
> > > > Changes since V1:
> > > > * Do the check for the region flags in lmb_resize_regions() and
> > > >   lmb_merge_overlap_regions() to decide on merging the overlapping
> > > >   regions.
> > > >
> > > >  include/lmb.h |   1 +
> > > >  lib/lmb.c     | 116 ++++++++++++++++++++++++++++++++++++++++++++------
> > > >  2 files changed, 103 insertions(+), 14 deletions(-)
> > > >
> > > > diff --git a/include/lmb.h b/include/lmb.h
> > > > index 069c6af2a3..99fcf5781f 100644
> > > > --- a/include/lmb.h
> > > > +++ b/include/lmb.h
> > > > @@ -20,6 +20,7 @@
> > > >  enum lmb_flags {
> > > >         LMB_NONE                = 0x0,
> > > >         LMB_NOMAP               = 0x4,
> > > > +       LMB_NOOVERWRITE         = 0x8,
> > >
> > > How about LMB_PERSIST ?
> >
> > Isn't LMB_NOOVERWRITE more suitable here ? I mean this is indicating
> > that the said region of memory is not to be re-used/re-requested.
> >
> > >
> > > These could be adjusted to use BIT()
> >
> > I am changing these to use the BIT macro in a subsequent commit.
>
> Yes, I saw that later and forgot to remove this. Normally we make
> refactoring changes before adding new code, though.

Okay, I will bring in that patch earlier in the series.

-sughosh

> [..]
>
> Regards,
> Simon
