Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48306D711B4
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 15:45:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8AD68932B;
	Wed, 20 Nov 2024 16:45:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QccN428D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF42187042; Wed, 20 Nov 2024 16:37:50 +0100 (CET)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60435892C6
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 16:37:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-71e681bc315so825221b3a.0
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 07:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732117067; x=1732721867; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qm2u4t46+8tjKn4fdlpHrukIxNf6eqhjqdxEX3pK+bk=;
 b=QccN428D2eEIdKMeC2VJhUYFXPIzKK/kGYdFdaOC2jQgo8m4Mv01t0bIRXJEtxIDrq
 77yayKt4cRWRRzWx/tou5OWyJDHh9GXD7ppXGrUyU0O/OUwe9MQohclwNuZMEpGdAker
 babQ5gsymeRh157BD4skMD+PzOYOnLWLqEDf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732117067; x=1732721867;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qm2u4t46+8tjKn4fdlpHrukIxNf6eqhjqdxEX3pK+bk=;
 b=mUMCia4aDiad4MzecEIyTWAZvWVowH4BHu6lV01ni80fyoq5LkZ9sfVrHCJvq5q9Cg
 uirJ8JqWkQZyLS4L8KPHrmjDv5Q3XnBbtePmgEmRVJdixjkNiLe89DnjE1DAp/VZ9JR1
 r1msnr088oNfxYcT3NOHH5v28vJsdfBUpnH8pWgAPtXCU3hOUm1J3FZEPLC3bWE49qQg
 kJkKlRnSjyXT8T9q+wu4Olgw5M1fL2UXgkAqoV//fobC0YewPF8Xj+ZjFavPqmYshzV3
 shnVqz8pYrkFIlVhlm265yAioHZCBltLFVIobtB+gsWpT9/ikA69BON+HwRqZt7fQSUg
 iaKA==
X-Gm-Message-State: AOJu0YwU2PRxwcaVM/2P/5T2CcqqjGSw/RlF8YwykZnF3BbK5t2GPTMa
 /fXwWJlP8wq9VXJj8xUD9skWIqhVF0PoY3dBrcoVfMuwzBWsRFPHdih1PtoH4VQiXfAeQW4WDPi
 eSJbz0Gkt2bZaVeNEz/BXCiBFPcHnEigfutg8
X-Google-Smtp-Source: AGHT+IGdeEWz6OxThQRJPbtMMDvWrJzu9zso6J0KJ1FIgJ9u0WdTeKjnOpydzyKpl0YrSN/kqs2QBEhJYs6TPmvBGEk=
X-Received: by 2002:a05:6a00:189e:b0:724:5b8d:f451 with SMTP id
 d2e1a72fcca58-724af8f6844mr11209938b3a.6.1732117066938; Wed, 20 Nov 2024
 07:37:46 -0800 (PST)
MIME-Version: 1.0
References: <20241028124815.47262-1-sjg@chromium.org>
 <CAC_iWjKtaN54B98OKbkoXkC_GmKJ=x+M4=UY_O6roSOpZaDxag@mail.gmail.com>
 <CAFLszTj9Dc-uF=GjSyxTue5Sw3ohUnDaAnAc5sz2dxfQ3gEuxw@mail.gmail.com>
 <CAC_iWjJkAfJHp_NDXJMfNPe7OhBp6B_WBMxvwU_qHU5tamm6ZA@mail.gmail.com>
 <CAFLszTiL88dHANMHo1bK2Uj5K1-7B56_Uk8keSQTo6FUfUoOVQ@mail.gmail.com>
 <CAC_iWjJOFv1v5VPoJ2UEu1YR84i1GUdB7tEng-uqgZ+6o_XWZw@mail.gmail.com>
In-Reply-To: <CAC_iWjJOFv1v5VPoJ2UEu1YR84i1GUdB7tEng-uqgZ+6o_XWZw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 Nov 2024 08:37:14 -0700
Message-ID: <CAFLszThCONSk2v30pGDGyGjz9mz2X0mtpqGCWSZJdbAuDaT0bw@mail.gmail.com>
Subject: Re: [PATCH 00/15] efi_loader: Add support for logging to a buffer
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>, 
 Emil Kronborg <emil.kronborg@protonmail.com>, 
 Etienne Carriere <etienne.carriere@foss.st.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, 
 Igor Prusov <ivprusov@salutedevices.com>,
 Jonathan Humphreys <j-humphreys@ti.com>, 
 Levi Yun <yeoreum.yun@arm.com>, Marek Vasut <marex@denx.de>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, 
 Michal Simek <michal.simek@amd.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Raymond Mao <raymond.mao@linaro.org>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Sean Anderson <seanga2@gmail.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sumit Garg <sumit.garg@linaro.org>, 
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Wei Ming Chen <jj251510319013@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 20 Nov 2024 16:45:28 +0100
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

HI Ilias,

On Fri, 1 Nov 2024 at 05:32, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> On Thu, 31 Oct 2024 at 20:02, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Ilias,
> >
> > On Tue, 29 Oct 2024 at 19:32, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > On Tue, 29 Oct 2024 at 17:45, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Ilias,
> > > >
> > > > On Tue, 29 Oct 2024 at 10:58, Ilias Apalodimas
> > > > <ilias.apalodimas@linaro.org> wrote:
> > > > >
> > > > > Hi Simon,
> > > > >
> > > > > On Mon, 28 Oct 2024 at 14:48, Simon Glass <sjg@chromium.org> wrote:
> > > > > >
> > > > > > It is a bit of a pain to log EFI boot-services calls at present. The
> > > > > > output goes to the console so cannot easily be inspected later. Also it
> > > > > > would be useful to be able to store the log and review it later, perhaps
> > > > > > after something has gone wrong.
> > > > > >
> > > > > > This series makes a start on implementing a log-to-buffer feature. It
> > > > > > provides a simple 'efidebug log' command to inspect the buffer. For now,
> > > > > > only memory allocations are logged.
> > > > >
> > > > > Why is this problem specific to EFI and no U-Boot in general? Do we
> > > > > have a similar machinery for malloc()?
> > > >
> > > > Mostly because an app can make EFI calls and we want to know what they
> > > > are, e.g. to debug them and figure out what might be wrong when
> > > > something doesn't boot.
> > >
> > > EFI_PRINT() has been proven pretty useful for this. I don't personally
> > > see the point of adding ~1300 lines of code to replace a print.
> > > What would make more sense is teach EFI_PRINT to log errors in a buffer.
> >
> > Is that a NAK? Please be clear if you are reviewing the code or just
> > rejecting the whole idea.
>
> For the idea, no. But I don't think what's implemented here is what we want.
>
> To track what EFI services are called, we already have EFI_ENTRY and EFI_EXIT.
> Why don't we instead, add a logging service (and we already have
> ftrace iirc) and plug it in the macros above?
> That would make more sense not to mention way less code.

I am wanting to programmatically log and manage what EFI_LOADER does,
so that bootstd can present a high-level view of what is going on,
e.g. which protocols are used, how much memory is allocated and where.
So this is not just about logging text output.

>
> >
> > I am hoping to expand this into a debugging tool for figuring out how
> > to boot Windows and perhaps logging detailed information when things
> > go wrong, for later analysis. It might seem like overkill, but we will
> > see.
>
> I've managed to run windows installers on QEMU & U-Boot. It's been
> more than a year but windows boots and calls EBS(). The something
> fails down the road.
> I think I have a branch somewhere with the changes needed, I'll send
> it over if I find it.

Did you find it?

Regards,
Simon
