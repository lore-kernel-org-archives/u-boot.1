Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31A58D711CB
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 17:06:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68B6D89346;
	Wed, 20 Nov 2024 18:06:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XcxI0CO+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D6F488FED; Wed, 20 Nov 2024 16:56:03 +0100 (CET)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 003FB89001
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 16:55:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-72061bfec2dso3794198b3a.2
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 07:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732118154; x=1732722954; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=j0cyMbIa0dVDvpRVOaV2zbVVSelOr41xBBl53wb1X9A=;
 b=XcxI0CO+hBB+YGFayDaSVlGQGL1j+y+92yxdu4uZ9loMXdyaRcuvHI/tyuypY2cxAZ
 YEW9VYzgG79et+XZHQYPyF/7FJhh8xOqI8ImZ1tOw/Z81jOMPD/9hXd5zqY/hnJ7/BYN
 Q70/GpqBf8C4bE4q5gBfsx1fbChYvrIWz7oiR4NXMregB1RrwFz05nerpDs/F0wX8ZZ9
 qeXfsXiJLZits8agkFh6Lu6Sfo33NdtOiQcD+LWdDcL50UvjalVK/yxgi1vfwSt0xoyQ
 NGnCaMIRd+GZgsBps3kUUYeE+61LxrRKepWFLpi9iGN/4Bc4MMjLFtIBn3uTBQdlHcd5
 VU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732118154; x=1732722954;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j0cyMbIa0dVDvpRVOaV2zbVVSelOr41xBBl53wb1X9A=;
 b=wWEk3Xj/9QEX6Vs2nhsb//PxwTw6sKccEA5akhXXZ61KH+9EnlyasQMsQeMtifZxat
 ExJT1SuxZuaO2MIHNeLPh8NBuQCpBSIAzvTc3WwM1xDyDPaG7ngQshqbvQhegrhYBQjW
 /2mtwi37Nd4ue8DX77kIu5tsEKviQq/yJJzeAPqRQWY53cwy5AaNk7efLL81R/potdRc
 cEw9ZES+oU7SJWHHiBhc0T6xYARqSJba9/dbJa/thF89kIjOpgP+tvPs+SYCWTeztDjp
 /viiF37D64mm6AXFFyOU3/xpom7f2Li25/t5yZj8V1YxObk0j6iBQDujY14V0y5KkecI
 c1Ww==
X-Gm-Message-State: AOJu0YwC0hUU9pQV2Kx+JP1yRLvnhk5nxot4Ji+s4AuYphfyFscaO6lw
 ceNhASue1pwfnHGifBZ/h2l+1ulPdN/7Ajo8Yj4j6Y1F6ucm4mjIsG7/SWAwN5VGg7nRKeUxNAz
 6RVKN8gYPg0fZlEi3JxKuNPLslwkSoknzQexHBw==
X-Google-Smtp-Source: AGHT+IFF3Uvof2q/c4XsGZjt1XK8QUep/1IUtFTXGwNA0bQKTEgUx5hA1TrMUfg1MSNRZ9PQuHNHnqOpC09akoXQQE8=
X-Received: by 2002:a05:6a00:1488:b0:724:6bac:1003 with SMTP id
 d2e1a72fcca58-724bee2912cmr4598898b3a.24.1732118154417; Wed, 20 Nov 2024
 07:55:54 -0800 (PST)
MIME-Version: 1.0
References: <20241028124815.47262-1-sjg@chromium.org>
 <CAC_iWjKtaN54B98OKbkoXkC_GmKJ=x+M4=UY_O6roSOpZaDxag@mail.gmail.com>
 <CAFLszTj9Dc-uF=GjSyxTue5Sw3ohUnDaAnAc5sz2dxfQ3gEuxw@mail.gmail.com>
 <CAC_iWjJkAfJHp_NDXJMfNPe7OhBp6B_WBMxvwU_qHU5tamm6ZA@mail.gmail.com>
 <CAFLszTiL88dHANMHo1bK2Uj5K1-7B56_Uk8keSQTo6FUfUoOVQ@mail.gmail.com>
 <CAC_iWjJOFv1v5VPoJ2UEu1YR84i1GUdB7tEng-uqgZ+6o_XWZw@mail.gmail.com>
 <CAFLszThCONSk2v30pGDGyGjz9mz2X0mtpqGCWSZJdbAuDaT0bw@mail.gmail.com>
In-Reply-To: <CAFLszThCONSk2v30pGDGyGjz9mz2X0mtpqGCWSZJdbAuDaT0bw@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 20 Nov 2024 17:55:18 +0200
Message-ID: <CAC_iWj+g1nMA1DrWjguP=YiQhKOmyGKyu233Eb6Zjcv0x4yatA@mail.gmail.com>
Subject: Re: [PATCH 00/15] efi_loader: Add support for logging to a buffer
To: Simon Glass <sjg@chromium.org>
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
X-Mailman-Approved-At: Wed, 20 Nov 2024 18:06:37 +0100
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

Hi Simon,

On Wed, 20 Nov 2024 at 17:37, Simon Glass <sjg@chromium.org> wrote:
>
> HI Ilias,
>
> On Fri, 1 Nov 2024 at 05:32, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Simon,
> >
> > On Thu, 31 Oct 2024 at 20:02, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Ilias,
> > >
> > > On Tue, 29 Oct 2024 at 19:32, Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > On Tue, 29 Oct 2024 at 17:45, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > Hi Ilias,
> > > > >
> > > > > On Tue, 29 Oct 2024 at 10:58, Ilias Apalodimas
> > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > >
> > > > > > Hi Simon,
> > > > > >
> > > > > > On Mon, 28 Oct 2024 at 14:48, Simon Glass <sjg@chromium.org> wrote:
> > > > > > >
> > > > > > > It is a bit of a pain to log EFI boot-services calls at present. The
> > > > > > > output goes to the console so cannot easily be inspected later. Also it
> > > > > > > would be useful to be able to store the log and review it later, perhaps
> > > > > > > after something has gone wrong.
> > > > > > >
> > > > > > > This series makes a start on implementing a log-to-buffer feature. It
> > > > > > > provides a simple 'efidebug log' command to inspect the buffer. For now,
> > > > > > > only memory allocations are logged.
> > > > > >
> > > > > > Why is this problem specific to EFI and no U-Boot in general? Do we
> > > > > > have a similar machinery for malloc()?
> > > > >
> > > > > Mostly because an app can make EFI calls and we want to know what they
> > > > > are, e.g. to debug them and figure out what might be wrong when
> > > > > something doesn't boot.
> > > >
> > > > EFI_PRINT() has been proven pretty useful for this. I don't personally
> > > > see the point of adding ~1300 lines of code to replace a print.
> > > > What would make more sense is teach EFI_PRINT to log errors in a buffer.
> > >
> > > Is that a NAK? Please be clear if you are reviewing the code or just
> > > rejecting the whole idea.
> >
> > For the idea, no. But I don't think what's implemented here is what we want.
> >
> > To track what EFI services are called, we already have EFI_ENTRY and EFI_EXIT.
> > Why don't we instead, add a logging service (and we already have
> > ftrace iirc) and plug it in the macros above?
> > That would make more sense not to mention way less code.
>
> I am wanting to programmatically log and manage what EFI_LOADER does,
> so that bootstd can present a high-level view of what is going on,
> e.g. which protocols are used, how much memory is allocated and where.
> So this is not just about logging text output.

Why the EFI_LOADER only? Bootstd is supposed to cover more cases, so
why not a generic framework for all boot commands?


>
> >
> > >
> > > I am hoping to expand this into a debugging tool for figuring out how
> > > to boot Windows and perhaps logging detailed information when things
> > > go wrong, for later analysis. It might seem like overkill, but we will
> > > see.
> >
> > I've managed to run windows installers on QEMU & U-Boot. It's been
> > more than a year but windows boots and calls EBS(). The something
> > fails down the road.
> > I think I have a branch somewhere with the changes needed, I'll send
> > it over if I find it.
>
> Did you find it?

I didn't but Alexander has a tree on which I based my work on.
https://github.com/u-boot/u-boot/compare/master...agraf:u-boot:qemu-arm-win10

Cheers
/Ilias

>
> Regards,
> Simon
