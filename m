Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA45E6B255
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 12:56:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE6EF889E9;
	Fri,  1 Nov 2024 13:56:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="E5vBN94H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBC6688BBE; Fri,  1 Nov 2024 12:32:23 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A734C88E94
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 12:32:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-20c714cd9c8so19964045ad.0
 for <u-boot@lists.denx.de>; Fri, 01 Nov 2024 04:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730460740; x=1731065540; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Oj+ljQBf4NoO8Coi/4DBJUjArURyhAsouxL772sqzCA=;
 b=E5vBN94HtMGhIgiTAEfVo142CP9d4sVLA799ezIN5dQJ2vku64yQ0A7eaO54lZsLzs
 l4HdaicWmrfdNJJwnh5hDUH7Zcg/8vuZ89zl+bg/FwhyoA4Qv5Q0USuvRj/LcMOZLADe
 OeIRi9HxxzJH/GoH1RtHL2QRNwo0ZTRx4CZ8fXyUzavbjdHIvD5IgJQ3voN9zf9hMnIJ
 SvRookuBhF1WVDHuAd82awm+nWDCUhYhVM86ohZDGWz3qEm2UnNzTjKicq9oieOu6R3c
 QNMnIL7VkMIDC13a7X9NOwRPbQEUvuihYrCUnVsAK2uW1zaz5dl9ub589t/HOTp2p49R
 WFcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730460740; x=1731065540;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Oj+ljQBf4NoO8Coi/4DBJUjArURyhAsouxL772sqzCA=;
 b=VF3yAGuqlMXzZuVbdORuvEAXxKZ0o3KswzsIW5t87kRtc1AhcBoAY0t/pOnBHJvdwd
 axNWqfFlWXEuh/8/aK1sm7bsAjo6AiUsdCttkXp9Dq3jYYSRxlvMjslYDnpxULXy3w2q
 DXkht4WDfDdmd57Z10eFVybbpzWyi957RqjLJEAN0TU/TAY3/Es+M6iQrvN55QRN3ji+
 h/EztqJBSIPvlbQhGMACxh6a1FvGbmRpK+dIOV5xU9WPUh7X+Cd1+KDdpJ3MGV72+YZ4
 T/5+JT24Tbf3Sh7U2VrhlO9E8C3FEJVpMdSzJbkWAJT2MHsvAeZcQJCQKc/vHHSvwFz6
 ZU/A==
X-Gm-Message-State: AOJu0YyqQNPpkny5PJZ7I5ujPoQCtsXgTg3V2P3/mfo2hTwCjSWjAux1
 pfvA3OOii78hfoH3dbZxU9gUov/KI8lEe9RWJXuBtoa0qOT14vQOr55qAsuo+rntpS1s/in12T/
 Lv9bthNa7KpL/hK6WBO5JMElM11y+7v4WgRJo0w==
X-Google-Smtp-Source: AGHT+IG+D2aN6/5idDFUgiGqku9h3+FWmJuyguVI/uQx2ufhtavOGTPHQre2DKc6VzPQcDnoJdtsQ0hT4bHZNFMkFTA=
X-Received: by 2002:a17:902:f689:b0:20c:8cf9:6133 with SMTP id
 d9443c01a7336-2111af1c56emr39368705ad.8.1730460739834; Fri, 01 Nov 2024
 04:32:19 -0700 (PDT)
MIME-Version: 1.0
References: <20241028124815.47262-1-sjg@chromium.org>
 <CAC_iWjKtaN54B98OKbkoXkC_GmKJ=x+M4=UY_O6roSOpZaDxag@mail.gmail.com>
 <CAFLszTj9Dc-uF=GjSyxTue5Sw3ohUnDaAnAc5sz2dxfQ3gEuxw@mail.gmail.com>
 <CAC_iWjJkAfJHp_NDXJMfNPe7OhBp6B_WBMxvwU_qHU5tamm6ZA@mail.gmail.com>
 <CAFLszTiL88dHANMHo1bK2Uj5K1-7B56_Uk8keSQTo6FUfUoOVQ@mail.gmail.com>
In-Reply-To: <CAFLszTiL88dHANMHo1bK2Uj5K1-7B56_Uk8keSQTo6FUfUoOVQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 1 Nov 2024 13:31:43 +0200
Message-ID: <CAC_iWjJOFv1v5VPoJ2UEu1YR84i1GUdB7tEng-uqgZ+6o_XWZw@mail.gmail.com>
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
X-Mailman-Approved-At: Fri, 01 Nov 2024 13:56:15 +0100
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

On Thu, 31 Oct 2024 at 20:02, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> On Tue, 29 Oct 2024 at 19:32, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > On Tue, 29 Oct 2024 at 17:45, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Ilias,
> > >
> > > On Tue, 29 Oct 2024 at 10:58, Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > Hi Simon,
> > > >
> > > > On Mon, 28 Oct 2024 at 14:48, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > It is a bit of a pain to log EFI boot-services calls at present. The
> > > > > output goes to the console so cannot easily be inspected later. Also it
> > > > > would be useful to be able to store the log and review it later, perhaps
> > > > > after something has gone wrong.
> > > > >
> > > > > This series makes a start on implementing a log-to-buffer feature. It
> > > > > provides a simple 'efidebug log' command to inspect the buffer. For now,
> > > > > only memory allocations are logged.
> > > >
> > > > Why is this problem specific to EFI and no U-Boot in general? Do we
> > > > have a similar machinery for malloc()?
> > >
> > > Mostly because an app can make EFI calls and we want to know what they
> > > are, e.g. to debug them and figure out what might be wrong when
> > > something doesn't boot.
> >
> > EFI_PRINT() has been proven pretty useful for this. I don't personally
> > see the point of adding ~1300 lines of code to replace a print.
> > What would make more sense is teach EFI_PRINT to log errors in a buffer.
>
> Is that a NAK? Please be clear if you are reviewing the code or just
> rejecting the whole idea.

For the idea, no. But I don't think what's implemented here is what we want.

To track what EFI services are called, we already have EFI_ENTRY and EFI_EXIT.
Why don't we instead, add a logging service (and we already have
ftrace iirc) and plug it in the macros above?
That would make more sense not to mention way less code.

>
> I am hoping to expand this into a debugging tool for figuring out how
> to boot Windows and perhaps logging detailed information when things
> go wrong, for later analysis. It might seem like overkill, but we will
> see.

I've managed to run windows installers on QEMU & U-Boot. It's been
more than a year but windows boots and calls EBS(). The something
fails down the road.
I think I have a branch somewhere with the changes needed, I'll send
it over if I find it.


/Ilias
>
> Regards,
> Simon
