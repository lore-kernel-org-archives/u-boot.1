Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FBA7CAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 12:51:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBB038394A;
	Wed,  8 Oct 2025 14:50:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="A5ZBjVHQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4437B839B9; Wed,  8 Oct 2025 14:50:58 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA7DD8393F
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 14:50:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-631df7b2dffso2118103a12.1
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 05:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1759927855; x=1760532655; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Iju4qVRgVun/WzsHcWsFFsuFpAj18W3HWMwQ0GkLPnA=;
 b=A5ZBjVHQANS4NE4o4DvDk7KKIKsCca0yyXhrWZM1EpgKj/1qMHrMgo6M0HrP5zxCHr
 XDGXqUYtj9V71yr6cqjQBJ9kjvIRbKsFX8GniwnEZ2tB0JhzSN5R++eA0h9b8E2bPlf7
 m9pNxmcnW5DJK2joIKAacz5eX2icyhARMrR/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759927855; x=1760532655;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Iju4qVRgVun/WzsHcWsFFsuFpAj18W3HWMwQ0GkLPnA=;
 b=N7xcEkrv4M0pWuVLXP7BDVBuvTTWdXFFgPAwPJpQfqnIlO+QkjfLGZilcFSYKlSVdQ
 9rbgI5f/osiWfWaIdoIVSOiE5DGkyy01a8wXowgULLmuLoUGxovPjC2wzB9kh9LO2vJ6
 5DhM/97peZ3OE5KU3EuzNTHthmMKddG5dtp4MGxkGBA1L6LJfKZ6T0e9Bx4qKjydX4o5
 swXpwP94V21l/tlgPhEA5SjX7OPChRYQwVEMnTT2HeDp/j+U2GB/4HEFpRnY4pxNuSde
 GdN7XVDfVksgnnpEAHyTJ/edBuD+Z7PZPtpUkhKyl7Cb5ujtCpVtc1RQg58RTrhDPj8v
 g3Wg==
X-Gm-Message-State: AOJu0Yz9VKXhWhFSIIra81BEhTNC36zEBxAEk11+rM85gBV9itjzUSiC
 MmK4V5L7ycGMJFrRlKhoOy29NyN+HMbAvueN4/X1VuCiQBEi42SMeaTvZ80vnlNTcVeym6f7CHB
 5CLtDib1AyzGNXqM36bB0K28SEdOOtjVdkH0siZxc
X-Gm-Gg: ASbGncuN/c8oadLmldMQRDUVfqDHyuH+pA+l9p07c/S1Rd/TSHyL5ExXHV2X5j8H3Dk
 qz5KgFYP/b+z62lrUVlgkZp4Mea0y1Y5Jq6/gCFXyVN3x/AH4c25s+bB/pdmduo2yTfVmBC6DEF
 qVwK1F3niv1sxKisV5VL/fWlZxL9WXgzaZS6JYA4fJ6KMjN2R0lKnQRhTXzNyfGS2vgGr2EUP/Q
 4utQ4xgrC3yjbvGpxBeGgprVcObyg==
X-Google-Smtp-Source: AGHT+IEXKRiHjYtaGhFKa5sasfcGIZdOK+Q8I5KFkYuLSA7rJiIJcCHa0uPb8GZ/3Xx9mMDWmd0oC1aZx8DvAQFj24Q=
X-Received: by 2002:a05:6402:1e92:b0:636:6e11:2fd1 with SMTP id
 4fb4d7f45d1cf-639d5fc0219mr3331830a12.4.1759927855112; Wed, 08 Oct 2025
 05:50:55 -0700 (PDT)
MIME-Version: 1.0
References: <20251001212649.3263574-1-sjg@chromium.org>
 <20251001212649.3263574-6-sjg@chromium.org>
 <20251002201537.GO6093@bill-the-cat>
 <CAFLszTigwz2mVfS=C6yXDnTMvdGxw=FsD36QCrpS2VOVSr+7nA@mail.gmail.com>
 <20251006234500.GG298503@bill-the-cat>
 <CAFLszTgEoEN=+QocxEXewkwe-wjOKeNRMn5YWSvHcOcaLR2qsA@mail.gmail.com>
 <20251007135009.GI298503@bill-the-cat>
 <CAFLszTjimWcKE8n991-ik-7fyhsesHsm5hrQwx7-FKSqgd48QQ@mail.gmail.com>
 <20251007153904.GK298503@bill-the-cat>
In-Reply-To: <20251007153904.GK298503@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 8 Oct 2025 06:50:41 -0600
X-Gm-Features: AS18NWAQXpNrrbM11o0KSG4DCUiKnBb_4nCDDakr97A8G7A6HeAzW3Wm6hwVLOE
Message-ID: <CAFLszThRcVQZN=rcrPga6a4JuJnL8Q6Ra9qHmXhWKCsokt2Qcw@mail.gmail.com>
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

On Tue, 7 Oct 2025 at 09:39, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Oct 07, 2025 at 09:14:29AM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Tue, 7 Oct 2025 at 07:50, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Oct 07, 2025 at 05:13:55AM -0600, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Mon, 6 Oct 2025 at 17:45, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Mon, Oct 06, 2025 at 05:30:23PM -0600, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Thu, 2 Oct 2025 at 14:15, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Wed, Oct 01, 2025 at 03:26:30PM -0600, Simon Glass wrote:
> > > > > > >
> > > > > > > > It is helpful in tests to be able to show the bootflow that is being
> > > > > > > > examined. Move show_bootflow() into boot/ and rename it.
> > > > > > > >
> > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > ---
> > > > > > > >
> > > > > > > > Changes in v2:
> > > > > > > > - Add a log_err() for an invalid state
> > > > > > > >
> > > > > > > >  boot/bootflow.c    | 57 ++++++++++++++++++++++++++++++++++++++
> > > > > > > >  cmd/bootflow.c     | 68 ++--------------------------------------------
> > > > > > > >  include/bootflow.h |  9 ++++++
> > > > > > > >  3 files changed, 69 insertions(+), 65 deletions(-)
> > > > > > > [snip]
> > > > > > > > +     case BOOTFLOWST_COUNT:
> > > > > > > > +             log_err("Unexpected boot value of bootflow error %d",
> > > > > > > > +                      bflow->state);
> > > > > > >
> > > > > > > A small thing, checkpatch.pl catches that this isn't aligned with the '('
> > > > > > > here as it should be.
> > > > > >
> > > > > > OK. I'm unsure whether I really want this line anyway, since it
> > > > > > increases code size.
> > > > > >
> > > > > > >
> > > > > > > A larger thing, and please correct me if I'm wrong, but on reading the
> > > > > > > whole set of changes, this move + rename just means we're putting more
> > > > > > > info in the test output, and nothing else?
> > > > > >
> > > > > > It will also appear if you have CONFIG BOOTSTD_FULL and use 'bootflow
> > > > > > list' or 'bootflow scan -l'.
> > > > >
> > > > > But that should be the case before this patch as well, yes?
> > > >
> > > > Yes, that's right. This is just moving the code into a place where it
> > > > can be used from tests.
> > >
> > > But it's not being used from tests, with this series.
> >
> > Please see this one: 'boot: Add a new test for global bootmeths'
>
> Yes, it calls the function, but doesn't seem to do anything with that,
> especially considering what the test does before these patches.

Well, it prints out the information so you can see it when running the
test. Other tests show what is going on so it seemed sensible to do
the same here.

I'm happy to remove this patch if you like.

Regards,
Simon
