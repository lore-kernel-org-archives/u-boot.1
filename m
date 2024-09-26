Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D09FACDE038
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 21:36:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CCCE88EA8;
	Thu, 26 Sep 2024 23:36:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lcDB7vpk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B61388ECC; Thu, 26 Sep 2024 23:36:15 +0200 (CEST)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0280988E8C
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 23:36:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7a9b3cd75e5so126548485a.0
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 14:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727386572; x=1727991372; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9atPGpT7ksLXtysL78O9snk92c4nXmyw2lxabJIlBHY=;
 b=lcDB7vpk+64JZZALFIxHYNtGPgcJEQPmBds6wpH91X6xR39O4alC0BQzmzT2Jpw1ri
 hbU+BI/6CGybWJiWZL3t1SVJMZVZsz7SXoX22Aj77GFojRF1ZXMqy6M/+sHrSDZT8JlS
 pFN8dj4qyIWidwP6v3NxwbHcaUiKZZnX+9SZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727386572; x=1727991372;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9atPGpT7ksLXtysL78O9snk92c4nXmyw2lxabJIlBHY=;
 b=AdkuAi8979julzf/rb4uxCQqGQ59forwhxxTTTG5RO8874IFxo00aDsCWRmAeStg5W
 D4WOHjHd308+JizSuUW+bgoUNlTX4XOUiDvMqRbBRLLPbd2urkpz3nklo8/hcNExbiq5
 SPtbTbLOqi5jc2b7t8/ZUwU7lTrvap8zFJXnCanbGw0QiGperEvQjZ/8BAgetNhFrH4B
 ksexy5jDuOQaAfi2GIJkOCB+PHD2BkkLVI/6xyFmG/rv3/vWazHKN1DT/le26fSICOpw
 JJDM9bphso6fcmNWrbL4UJXNb7/pQqOHNXOK6RdGau0UHmyiH3Sjc8p38ShJxRA23tPM
 f/gw==
X-Gm-Message-State: AOJu0Yz9E9ozCy7QNg45fdxMCarK5oB6wP5+lp4fRev8bg+W+kplSuMi
 pAAx6IuggFXQvlwoszMzfTwqqY05qCZyH/dPxoXhYBqMJg+bOLMLXmogD38OHIxHnprV1zQmkZ+
 3huaDRH0dB92IC64oeHfDvabHLFSh1pf3DNhcaI+4BeoGjY6gHu7ZIhQ=
X-Google-Smtp-Source: AGHT+IEZvDuMsjTRHKG2cSNssgo65Y5zOabvq/1tp//LU0Im1oHaptH5A+VTMovPPGpAI67yFIKk24632UN6uTnhLxs=
X-Received: by 2002:a05:6214:2dc9:b0:6c7:c761:4006 with SMTP id
 6a1803df08f44-6cb3b5e72b8mr15784436d6.5.1727386571843; Thu, 26 Sep 2024
 14:36:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240920060158.106612-1-sjg@chromium.org>
 <20240920060158.106612-2-sjg@chromium.org>
 <20240923203512.GQ4252@bill-the-cat>
 <CAFLszTjT3RZYChMhBxUDsf6YC-7cZfh1_YhuQrin3sRanSO=Xw@mail.gmail.com>
 <20240925172601.GA4252@bill-the-cat>
In-Reply-To: <20240925172601.GA4252@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 26 Sep 2024 23:36:00 +0200
Message-ID: <CAFLszTjFMRpfwFVPJ=-xqKUu=XbH=hq+yP+N17TuFd2b8+rt4g@mail.gmail.com>
Subject: Re: [PATCH v6 01/19] test: Allow signaling that U-Boot is ready
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

On Wed, 25 Sept 2024 at 19:26, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Sep 25, 2024 at 02:49:56PM +0200, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, 23 Sept 2024 at 22:35, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, Sep 20, 2024 at 08:01:36AM +0200, Simon Glass wrote:
> > >
> > >
> > > > When Labgrid is used, it can get U-Boot ready for running tests. It
> > > > prints a message when it has done so.
> > > >
> > > > Add logic to detect this message and accept it.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > > (no changes since v1)
> > > >
> > > >  test/py/u_boot_console_base.py | 9 +++++----
> > > >  1 file changed, 5 insertions(+), 4 deletions(-)
> > >
> > > What happens is that labgrid can also be told to look for and then
> > > interrupt autoboot, just like our pytests can do, and the system is at
> > > the prompt. But this is also what it's like for a system with autoboot
> > > disabled. Do we actually need this patch to achieve the functionality
> > > you want? Doesn't that already just happen?
> >
> > The point of this patch is actually to remove code in pytest, by
> > allowing it to skip all the banner-detection stuff. It does not affect
> > things in Labgrid, since it still needs to watch for banners, etc.
>
> But you can't remove code from pytest, people can and will run the suite
> outside of labgrid.

Yes, that's right. I meant that with Labgrid the code is not used.

>
> > Without this patch, we have to tell Labgrid's U-Boot driver to do
> > nothing, so that pytest does it. But that is not a good idea, since
> > Labgrid has a lot more info about the board than pytest has. For
> > example, look at all the SPL-banner-count stuff.
>
> Why do you have to tell it to do nothing? The pytest suite works fine,
> today, if the board stops at the prompt automatically. To be clear, the
> labgrid yaml file I'm using with my scripts has the information to stop
> autoboot in it and it's not causing a problem.

But if it wasn't causing a problem I would not have invented this
annoying scheme. For several boards, by the time pytest gets to see
the output it is too late to press a key and stop. Also, some boards
have a different prompt which is not detected by pytest.

For example:
configs/am62x_beagleplay_a53_defconfig:CONFIG_AUTOBOOT_PROMPT="Press
SPACE to abort autoboot in %d seconds\n"

>
> > Basically, without this patch we cannot use '-s uboot' to tell the
> > Labgrid strategy to take us to a U-Boot prompt. We must just use a raw
> > console with no strategy, relying on pytest to do all the work.
> >
> > I hope that helps explain the problem?
>
> I think I see what you're saying, and it's based on the assumption that
> we'll make everyone either use labgrid?

Not at all. I tested this version of the series again with my
pre-Labgrid lab and it works fine. But I do believe that the hooks
that pytest has are not ideal for use with Labgrid.

Regards,
Simon
