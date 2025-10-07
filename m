Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED41CCA470
	for <u-boot@archiver.kernel.org>; Tue,  7 Oct 2025 15:14:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35D4783D9F;
	Tue,  7 Oct 2025 17:14:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Vnj5ZmY4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0F9283D92; Tue,  7 Oct 2025 17:14:44 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2D5183DA9
 for <u-boot@lists.denx.de>; Tue,  7 Oct 2025 17:14:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-628f29d68ecso15627991a12.3
 for <u-boot@lists.denx.de>; Tue, 07 Oct 2025 08:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1759850082; x=1760454882; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eqxX55MnrkitzNiU3GtVxC4ZuThv9ebO7jkwK+EfccM=;
 b=Vnj5ZmY4HVCvAyvmV3Wvrrl+YJCoqCPrE8F//4pyNp78+Krezk9WV3MMK3Utkbs8J8
 nUZYl6WtZlSnpfjidOmgJYkCAbXGb6yUTWrBxUOhOTFrw29yH7LlR027r9oSNuMBOgGq
 hGug0rjm2MakxJI1fpDduIEjM6NwQM3vOc2Zk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759850082; x=1760454882;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eqxX55MnrkitzNiU3GtVxC4ZuThv9ebO7jkwK+EfccM=;
 b=M4IfR9NbZ1hEhp2bMOR0Ed7DxHaP5zbSL2JlPhkyUQBS0mowLQwUSmIB3kpuiNeTm4
 0Gou+KrVHK3tkjHNG7sEADJ5cWE2RBituwBS+FoqWTsTmFbsIZ7YdLAk/c0MnAt+sdcl
 xKwuJMnu0Zea5i9lawk28w1MD9/kWSOHOmv19CLucPZ6X/v23w5JbPiDNCcLpqjzvMHM
 kHie+H+ar5N0eg2ZmhXeEORSoQROiJv+CXeJseZaE/1st00Q3uRSXGjANqa1S4PLZCpS
 SY/t0K7ZdnXA0PsqseHQ0f14Bikh2YKTVaOZOn4P2bxDsLHPXgR7wBB8fgSt+MNBQlYe
 VsGA==
X-Gm-Message-State: AOJu0Yz/YjySvvqJ9BmTjjpy3biu/CnQ7AbBp3UTafw8n31bpcSMX+Zx
 Qow6TxfPvZrz4G54ZSk/tVhlsZvnO6bwV9+Fhqa5mmXXTu3L5vGekE72XgKt1EqWm1072Ov6h0a
 sAjuV6KYviTJ0Ji4dDo8kzGg0Q8/Co4uYJKxPh3QG
X-Gm-Gg: ASbGnctsOgmZGVb1R03gNU/riJmDwLhk8sLgrcYeyVjkyfeVoNGLT76+MkplsZf8YCE
 ZyZDx+LozXvFlkgiSjRwz40PSG5RbpgqfIZssukZGhx1oTz3AdvA7k93wQ/rKZSln+pVUjD3Nmj
 t3WoaMfvpJ83on9MXsMYIGF/sIcYi6ZT6AubvoL8NSakiBD60F/msn451hrmN0ATqxWR45NCqKF
 cIjSR8S9wPcAfniwcZA3eOKdN5ylQ==
X-Google-Smtp-Source: AGHT+IFEs6cUSFrYQTKXm+/2wFZ0EE3f8V3lHppG3Y+g41NaG/x+NrnFCl+/gy7Xhmsuvy/3TacuxbMC0a4L8h43mh4=
X-Received: by 2002:a05:6402:5c9:b0:638:66b1:e5b3 with SMTP id
 4fb4d7f45d1cf-639348cb8a2mr17923650a12.9.1759850082187; Tue, 07 Oct 2025
 08:14:42 -0700 (PDT)
MIME-Version: 1.0
References: <20251001212649.3263574-1-sjg@chromium.org>
 <20251001212649.3263574-6-sjg@chromium.org>
 <20251002201537.GO6093@bill-the-cat>
 <CAFLszTigwz2mVfS=C6yXDnTMvdGxw=FsD36QCrpS2VOVSr+7nA@mail.gmail.com>
 <20251006234500.GG298503@bill-the-cat>
 <CAFLszTgEoEN=+QocxEXewkwe-wjOKeNRMn5YWSvHcOcaLR2qsA@mail.gmail.com>
 <20251007135009.GI298503@bill-the-cat>
In-Reply-To: <20251007135009.GI298503@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 7 Oct 2025 09:14:29 -0600
X-Gm-Features: AS18NWC78G9BH6fDO1fGXlOnPalkMNJS8thxZjqmdYyWmBBPMS-ABXJoL-uXODs
Message-ID: <CAFLszTjimWcKE8n991-ik-7fyhsesHsm5hrQwx7-FKSqgd48QQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/17] boot: Move showing of bootflows out of the
 command
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
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

Hi Tom,

On Tue, 7 Oct 2025 at 07:50, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Oct 07, 2025 at 05:13:55AM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, 6 Oct 2025 at 17:45, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Mon, Oct 06, 2025 at 05:30:23PM -0600, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Thu, 2 Oct 2025 at 14:15, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Wed, Oct 01, 2025 at 03:26:30PM -0600, Simon Glass wrote:
> > > > >
> > > > > > It is helpful in tests to be able to show the bootflow that is being
> > > > > > examined. Move show_bootflow() into boot/ and rename it.
> > > > > >
> > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > ---
> > > > > >
> > > > > > Changes in v2:
> > > > > > - Add a log_err() for an invalid state
> > > > > >
> > > > > >  boot/bootflow.c    | 57 ++++++++++++++++++++++++++++++++++++++
> > > > > >  cmd/bootflow.c     | 68 ++--------------------------------------------
> > > > > >  include/bootflow.h |  9 ++++++
> > > > > >  3 files changed, 69 insertions(+), 65 deletions(-)
> > > > > [snip]
> > > > > > +     case BOOTFLOWST_COUNT:
> > > > > > +             log_err("Unexpected boot value of bootflow error %d",
> > > > > > +                      bflow->state);
> > > > >
> > > > > A small thing, checkpatch.pl catches that this isn't aligned with the '('
> > > > > here as it should be.
> > > >
> > > > OK. I'm unsure whether I really want this line anyway, since it
> > > > increases code size.
> > > >
> > > > >
> > > > > A larger thing, and please correct me if I'm wrong, but on reading the
> > > > > whole set of changes, this move + rename just means we're putting more
> > > > > info in the test output, and nothing else?
> > > >
> > > > It will also appear if you have CONFIG BOOTSTD_FULL and use 'bootflow
> > > > list' or 'bootflow scan -l'.
> > >
> > > But that should be the case before this patch as well, yes?
> >
> > Yes, that's right. This is just moving the code into a place where it
> > can be used from tests.
>
> But it's not being used from tests, with this series.

Please see this one: 'boot: Add a new test for global bootmeths'

Regards,
Simon
