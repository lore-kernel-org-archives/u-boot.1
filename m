Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C86CD2CE08
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 17:01:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECC4E88FD9;
	Tue, 22 Oct 2024 19:01:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="M3ytQcXu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1B5D88FD9; Tue, 22 Oct 2024 19:01:02 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FB8088FF1
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 19:01:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-37d50fad249so4551311f8f.1
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 10:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729616460; x=1730221260; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GOsgrdlGX0zAnk4a5cHQJQ7/lz98cF4PogFIV+yrcMw=;
 b=M3ytQcXu4LyaMe8DE2KG8NGpKzFbKP5I/A5PXwphAQNUeJL7LfNLxRfFvw4ddhbDIz
 oizpxqoBN+EDH/zJ28DhLbrB0NmcY2HeRaZm6vDNZH+7ney5H69sp+V5lX/D6Z4IwGEG
 SNeZMFQt8HNemIPw5KT1OYoHBLB12YNzf1sjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729616460; x=1730221260;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GOsgrdlGX0zAnk4a5cHQJQ7/lz98cF4PogFIV+yrcMw=;
 b=QD8MQL/FwRrbQwLsgAHc5ez1aXl7zP+5b/iSp2zMgg8cP545hq0ocD8oqJ7PcmGz3n
 aLwpmMCngVvK0QmJLwVPeffcJtq6omw9Exs3UPC98zsq6FPkz78NmP832cEzDnaoUDl5
 rjFn8ppGDMf80RzxXTlJSM+fwp8wXNo9nA6lphJFkMYNv5vmm69h5iVqY4GRBufSdhRd
 KsyxWPyXd9xp2kA3qkAETWHWH13IfjYb0iXrEkcrrTdFtdBGBlVaDr5AVP+4SY39BYDc
 2n6llzrvlkTM5LRqkJ+fp8ysfefgG7MyJ88mZahkp/ClVWplO8qSFpW8V45+GmCj4yRE
 jdvw==
X-Gm-Message-State: AOJu0Yz8cxbRCK21EhWUWtzlvQHuk5auGEgddZ6D8Yp0zhSxQWKRslSo
 j1JK4jj1XlXo6hf5eqxMtG2vW3Q77lyAm1q6rlWgM4LlhHedxn0bDPNxE6gJ4qypcyVesBFqP4H
 MmOtEX/QQji9WN7w8gPhrbx6GxDD3wOvSGJwT
X-Google-Smtp-Source: AGHT+IHBJw8MY5ReULNOhPJXu5xHu2DDfi3TB/YYXBGuIy8KHEJnoxTLHcml1ttnlXAdY5bgcUtYjE/XFqsC87heMNw=
X-Received: by 2002:adf:f251:0:b0:37d:542c:559 with SMTP id
 ffacd0b85a97d-37eab4d888cmr9164742f8f.18.1729616459773; Tue, 22 Oct 2024
 10:00:59 -0700 (PDT)
MIME-Version: 1.0
References: <20241021134450.22985-1-sjg@chromium.org>
 <20241021143336.GG4959@bill-the-cat>
 <CAFLszTjK=uw61U_WaqLjBX1JFCC15Ee2dRBm_qGUEsnjqiqpEw@mail.gmail.com>
 <20241021164958.GK4959@bill-the-cat>
 <CAFLszThz2DGSQ+gBiJi0jaSmsghVau0UTUyuZppjSyuy9pRkuA@mail.gmail.com>
 <20241022140223.GZ4959@bill-the-cat>
In-Reply-To: <20241022140223.GZ4959@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 22 Oct 2024 19:00:39 +0200
Message-ID: <CAFLszTjn5jELfjZJ0+JNQ+Op8S++_t4V-9MLVxYNnf8kzv+xSQ@mail.gmail.com>
Subject: Re: [PATCH] CI: Add a test for building without CMDLINE
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, Raymond Mao <raymond.mao@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>
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

On Tue, 22 Oct 2024 at 16:02, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Oct 22, 2024 at 02:16:16PM +0200, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, 21 Oct 2024 at 18:50, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Mon, Oct 21, 2024 at 06:32:18PM +0200, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Mon, Oct 21, 2024, 16:33 Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Mon, Oct 21, 2024 at 03:44:49PM +0200, Simon Glass wrote:
> > > > >
> > > > > > Something this breaks, so add a test to keep it working. Since sandbox
> > > > > > enables a lot of options, it is a good board to use.
> > > > > >
> > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > ---
> > > > > >
> > > > > >  .azure-pipelines.yml |  8 ++++++++
> > > > > >  .gitlab-ci.yml       | 11 +++++++++++
> > > > > >  2 files changed, 19 insertions(+)
> > > > >
> > > > > I don't like this because "sandbox" is one of the longest run-time
> > > > > build options due to all of the tests it runs. And given how we break
> > > > > down the jobs this will make a further bottleneck. Can we just disable
> > > > > CMDLINE in one of the existing sandbox defconfigs instead please?
> > > > > Perhaps sandbox_spl since that only does SPL related pytests?
> > > >
> > > > Actually we do boot into U-Boot proper as some tests need to check
> > > > that SPL did the right thing.
> > > >
> > > > Note that this patch doesn't run any tests at all. It just tries to
> > > > build sandbox without CMDLINE
> > >
> > > Is there no existing thing we can put this in? And have we had another
> > > problem with CMDLINE=n ? It's not cheap (wall clock) to add another
> > > stage, especially in Azure, I'd really rather figure some way to bundle
> > > this in with what we already do. Heck, following on with
> > > qemu_arm64_lwip_defconfig I'd rather just add
> > > sandbox_no_cmdline_defconfig and use #include so that it's just a few
> > > lines of defconfig anyhow, but merged in with existing builds.
> >
> > No, I have not seen any problems with CMDLINE as it is, but there are
> > some BOOTSTD cases which I would like to check, since disabling the
> > command-line and using programmatic boot is something I'd like to
> > eventually test. So this is just a starting point. In the end perhaps
> > we have a new sandbox variant, or can take over the SPL one...but I'm
> > not sure yet.
> >
> > If Azure is a problem, we could perhaps just do it in gitlab, where we
> > have more runners. A build variant isn't the sort of problem that
> > would be different between gitlab and Azure.
> >
> > The run is at [1] and it only took 1m19s - I suppose you saw that it
> > is in the 'world build' section and no tests are run.
> >
> > Regards,
> > Simon
> >
> > [1] https://source.denx.de/u-boot/custodians/u-boot-dm/-/jobs/924269
>
> No, I don't want Azure and GitLab to diverge since Azure is where
> everywhere who isn't a custodian with git access can run CI and I keep
> encouraging more people to use it. And also note that the actual build
> took 8 seconds which is another reason it would be good to just drop it
> in to an existing job.

Oh I didn't know that about Azure. Could/should we have a public
gitlab pusher also? Or is that not possible?

Anyway, I cannot put it into a job which runs tests, since it doesn't
ever produce a command prompt. So that rules out the test.py stage,
since even if I use '-k nothing' it will still fail to see the prompt,
so the build will fail. I don't see any option but to put the build in
a separate piece?

Regards,
Simon
