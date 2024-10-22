Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5411D2C543
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 12:16:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42C8388D97;
	Tue, 22 Oct 2024 14:16:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EZQ0943X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3559D88D97; Tue, 22 Oct 2024 14:16:31 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB67388969
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 14:16:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a99f646ff1bso674923666b.2
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 05:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729599388; x=1730204188; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8gW101+XJOGKR4CAJ53WThAaVmpG7WCDkCQ2iu1gFUw=;
 b=EZQ0943X1Vqk7kTJtxsGqVss9WyoTD7utQkXbM9+SUDdw5Rl5IlMqn+G2VToKr9VVV
 31N6CJwUBqAIokiotlkBUXu/1Y1Wio2xj2fiiSzGYpezcWMG6kNlKY22n7QgOfr1DQba
 hpEoxDc+qpu1BXdpDaKuxblIe1eCviz/y3fkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729599388; x=1730204188;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8gW101+XJOGKR4CAJ53WThAaVmpG7WCDkCQ2iu1gFUw=;
 b=rEUmXaLCP0IgXpiVYOSW69i8HXKxVaoAPJKvJwR4WwCTakrmLnktotj7TJCWZIxdp2
 lO3+2OpiSd4XM45u39IiVIHqaz12wjxyDxR67n79lbysJBbpaM+pMNd3Gp68rl9j6Utl
 Wfl1nTtqQYGg5dof5gJLe50kHJtmLlwTK1xS4mEtvgxthMtW5RugawFhy61EXrKXDPOW
 46WH+lTteyCD/H5bjkMs25TfJVeqN9NkmFpyp25sTImrtpnlMD6XysCYlTtEO7cM+9Fg
 IjV+B5HtFdlVrMyuKDZhGp4Eq89YAEMxvVLoiLaGYsiQJu7NcEO1d3bR9Nw4yRkU4x0U
 RnKA==
X-Gm-Message-State: AOJu0Yyxo3/R4joZjUndbvpeVTxGwswxKJgJC5soD+V7G00nngGfYjTB
 nybXx5DqHg0wvoXtzpwfUutzAX4LQ8iNrrxbB2yWSLXnYqe5lw3UKjtLnX9FRmfeq62NddSF8Pz
 FOHSsv5m5Ppl+fhFT3J0UnJbjLo8QkxuGz8Ru
X-Google-Smtp-Source: AGHT+IGormGqST91zxYKQCfU9VTkl0kDKOT73d08dnmZTckU2MVK9eovKE95QugC8ctn9h91rWeQLun2ha/tHCS3jlk=
X-Received: by 2002:a17:906:7955:b0:a9a:222f:45bb with SMTP id
 a640c23a62f3a-a9aa892dba8mr355087266b.35.1729599388297; Tue, 22 Oct 2024
 05:16:28 -0700 (PDT)
MIME-Version: 1.0
References: <20241021134450.22985-1-sjg@chromium.org>
 <20241021143336.GG4959@bill-the-cat>
 <CAFLszTjK=uw61U_WaqLjBX1JFCC15Ee2dRBm_qGUEsnjqiqpEw@mail.gmail.com>
 <20241021164958.GK4959@bill-the-cat>
In-Reply-To: <20241021164958.GK4959@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 22 Oct 2024 14:16:16 +0200
Message-ID: <CAFLszThz2DGSQ+gBiJi0jaSmsghVau0UTUyuZppjSyuy9pRkuA@mail.gmail.com>
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

On Mon, 21 Oct 2024 at 18:50, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Oct 21, 2024 at 06:32:18PM +0200, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, Oct 21, 2024, 16:33 Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Mon, Oct 21, 2024 at 03:44:49PM +0200, Simon Glass wrote:
> > >
> > > > Something this breaks, so add a test to keep it working. Since sandbox
> > > > enables a lot of options, it is a good board to use.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > >  .azure-pipelines.yml |  8 ++++++++
> > > >  .gitlab-ci.yml       | 11 +++++++++++
> > > >  2 files changed, 19 insertions(+)
> > >
> > > I don't like this because "sandbox" is one of the longest run-time
> > > build options due to all of the tests it runs. And given how we break
> > > down the jobs this will make a further bottleneck. Can we just disable
> > > CMDLINE in one of the existing sandbox defconfigs instead please?
> > > Perhaps sandbox_spl since that only does SPL related pytests?
> >
> > Actually we do boot into U-Boot proper as some tests need to check
> > that SPL did the right thing.
> >
> > Note that this patch doesn't run any tests at all. It just tries to
> > build sandbox without CMDLINE
>
> Is there no existing thing we can put this in? And have we had another
> problem with CMDLINE=n ? It's not cheap (wall clock) to add another
> stage, especially in Azure, I'd really rather figure some way to bundle
> this in with what we already do. Heck, following on with
> qemu_arm64_lwip_defconfig I'd rather just add
> sandbox_no_cmdline_defconfig and use #include so that it's just a few
> lines of defconfig anyhow, but merged in with existing builds.

No, I have not seen any problems with CMDLINE as it is, but there are
some BOOTSTD cases which I would like to check, since disabling the
command-line and using programmatic boot is something I'd like to
eventually test. So this is just a starting point. In the end perhaps
we have a new sandbox variant, or can take over the SPL one...but I'm
not sure yet.

If Azure is a problem, we could perhaps just do it in gitlab, where we
have more runners. A build variant isn't the sort of problem that
would be different between gitlab and Azure.

The run is at [1] and it only took 1m19s - I suppose you saw that it
is in the 'world build' section and no tests are run.

Regards,
Simon

[1] https://source.denx.de/u-boot/custodians/u-boot-dm/-/jobs/924269
