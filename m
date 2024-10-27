Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D2AD13572
	for <u-boot@archiver.kernel.org>; Sun, 27 Oct 2024 17:18:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7504C8841E;
	Sun, 27 Oct 2024 18:17:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="G/amRK9U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC2FA88969; Sun, 27 Oct 2024 18:17:07 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7520888F6C
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 18:16:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5c941623a5aso7483712a12.0
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 10:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730049419; x=1730654219; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2NlWtrYaXmy3BeX2e3sfLpFauKe5G6zlvBd/8dysovQ=;
 b=G/amRK9UnN1HMDPhOv8xO/rN+28peGkZgXg/xhOErmnfeLBFVZoFNKjNYLtxsu3p9G
 sOvV/CwZBQNoTWY+dYosE2Q2mlXQSp2XHZyIIufHcXrT35/YwekHOh4lEjGvcm9Ugyuh
 9cI2Mab3is5gTiz3vrE9KVyJh4dgvZkNsMpCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730049419; x=1730654219;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2NlWtrYaXmy3BeX2e3sfLpFauKe5G6zlvBd/8dysovQ=;
 b=K/92IP3hIs9cBipjfVYp+HKavaOoUmSqyCMznvW/07vwYl06dYEFUATYPh9S5CXOgL
 SxlUp3RAuehhb07i/EFEKPJZIP6c4GA/m58HXcMiGVNJOGYwwHgJpYxthl+NlpkiRD1n
 7yQrJcMfdFgymlGzk3+x9i5JE27iEDlkOz3qAfULaK2P165xlIXmWr4IMp3oWYR7g9xe
 m43Jv+B0Y8UdV+B4hS1vJ2CBNxE6Mtg+DpqJ9wMxBe75Jp/keViwH/cSp4QQhx4PqtXq
 zRudWSy7M8FtCwaDCN0pedSnm5RV02jcTszsWcmhx4QjrpIIWu/iUD3WD73VV+VdyP8Z
 xsdw==
X-Gm-Message-State: AOJu0YysJ/MjH6qpVBoJ084zZGpyZqowysVTB0cBk6HVY7y7JiBa+lo8
 +hgTVHyO3r/vBmCYQTBHa31hJQjLfh7H+9igrgNm3DH0ZZb0w7+GVkwwWVHqtxQsydu8a/DkuYw
 pv8ephGZD0IyPlbpXwnxLZxARAbvY3fNJIb8X
X-Google-Smtp-Source: AGHT+IGJRmN9kOPIvFZzOur+nes/ofplUZyIXbYAMHyobxpBkDi1pfd4aSK/zsaqi4bJuRgjwkqs4mNPaDyfBh2fTaU=
X-Received: by 2002:a17:907:724e:b0:a9a:1575:23e3 with SMTP id
 a640c23a62f3a-a9de3612ee7mr559726666b.19.1730049418835; Sun, 27 Oct 2024
 10:16:58 -0700 (PDT)
MIME-Version: 1.0
References: <20241021134450.22985-1-sjg@chromium.org>
 <20241021143336.GG4959@bill-the-cat>
 <CAFLszTjK=uw61U_WaqLjBX1JFCC15Ee2dRBm_qGUEsnjqiqpEw@mail.gmail.com>
 <20241021164958.GK4959@bill-the-cat>
 <CAFLszThz2DGSQ+gBiJi0jaSmsghVau0UTUyuZppjSyuy9pRkuA@mail.gmail.com>
 <20241022140223.GZ4959@bill-the-cat>
 <CAFLszTjn5jELfjZJ0+JNQ+Op8S++_t4V-9MLVxYNnf8kzv+xSQ@mail.gmail.com>
 <20241022175645.GI4959@bill-the-cat>
In-Reply-To: <20241022175645.GI4959@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 27 Oct 2024 18:16:45 +0100
Message-ID: <CAFLszTiHqkG+dCpP4qhGdWGzDPXW_O_td967gixK-exEMWBc1g@mail.gmail.com>
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

On Tue, 22 Oct 2024 at 19:56, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Oct 22, 2024 at 07:00:39PM +0200, Simon Glass wrote:
> > Hi Tom,
> >
> > On Tue, 22 Oct 2024 at 16:02, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Oct 22, 2024 at 02:16:16PM +0200, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Mon, 21 Oct 2024 at 18:50, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Mon, Oct 21, 2024 at 06:32:18PM +0200, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Mon, Oct 21, 2024, 16:33 Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Mon, Oct 21, 2024 at 03:44:49PM +0200, Simon Glass wrote:
> > > > > > >
> > > > > > > > Something this breaks, so add a test to keep it working. Since sandbox
> > > > > > > > enables a lot of options, it is a good board to use.
> > > > > > > >
> > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > ---
> > > > > > > >
> > > > > > > >  .azure-pipelines.yml |  8 ++++++++
> > > > > > > >  .gitlab-ci.yml       | 11 +++++++++++
> > > > > > > >  2 files changed, 19 insertions(+)
> > > > > > >
> > > > > > > I don't like this because "sandbox" is one of the longest run-time
> > > > > > > build options due to all of the tests it runs. And given how we break
> > > > > > > down the jobs this will make a further bottleneck. Can we just disable
> > > > > > > CMDLINE in one of the existing sandbox defconfigs instead please?
> > > > > > > Perhaps sandbox_spl since that only does SPL related pytests?
> > > > > >
> > > > > > Actually we do boot into U-Boot proper as some tests need to check
> > > > > > that SPL did the right thing.
> > > > > >
> > > > > > Note that this patch doesn't run any tests at all. It just tries to
> > > > > > build sandbox without CMDLINE
> > > > >
> > > > > Is there no existing thing we can put this in? And have we had another
> > > > > problem with CMDLINE=n ? It's not cheap (wall clock) to add another
> > > > > stage, especially in Azure, I'd really rather figure some way to bundle
> > > > > this in with what we already do. Heck, following on with
> > > > > qemu_arm64_lwip_defconfig I'd rather just add
> > > > > sandbox_no_cmdline_defconfig and use #include so that it's just a few
> > > > > lines of defconfig anyhow, but merged in with existing builds.
> > > >
> > > > No, I have not seen any problems with CMDLINE as it is, but there are
> > > > some BOOTSTD cases which I would like to check, since disabling the
> > > > command-line and using programmatic boot is something I'd like to
> > > > eventually test. So this is just a starting point. In the end perhaps
> > > > we have a new sandbox variant, or can take over the SPL one...but I'm
> > > > not sure yet.
> > > >
> > > > If Azure is a problem, we could perhaps just do it in gitlab, where we
> > > > have more runners. A build variant isn't the sort of problem that
> > > > would be different between gitlab and Azure.
> > > >
> > > > The run is at [1] and it only took 1m19s - I suppose you saw that it
> > > > is in the 'world build' section and no tests are run.
> > > >
> > > > Regards,
> > > > Simon
> > > >
> > > > [1] https://source.denx.de/u-boot/custodians/u-boot-dm/-/jobs/924269
> > >
> > > No, I don't want Azure and GitLab to diverge since Azure is where
> > > everywhere who isn't a custodian with git access can run CI and I keep
> > > encouraging more people to use it. And also note that the actual build
> > > took 8 seconds which is another reason it would be good to just drop it
> > > in to an existing job.
> >
> > Oh I didn't know that about Azure. Could/should we have a public
> > gitlab pusher also? Or is that not possible?
>
> I'd really rather not overwhelm our few build servers (of which you're
> providing most of).
>
> > Anyway, I cannot put it into a job which runs tests, since it doesn't
> > ever produce a command prompt. So that rules out the test.py stage,
> > since even if I use '-k nothing' it will still fail to see the prompt,
> > so the build will fail. I don't see any option but to put the build in
> > a separate piece?
>
> Yes, we could just do something like configs/qemu_arm64_lwip_defconfig
> but be sandbox_nocmdline_defconfig and it'll just be part of the normal
> world stage that already builds all of the sandbox targets.

Oh I see, yes I can do that.

Regards,
Simon
