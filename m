Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83344C282D0
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 13:12:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 976C0819AA;
	Tue,  4 Mar 2025 14:11:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UbKkfEFU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC4DA819B1; Tue,  4 Mar 2025 14:11:43 +0100 (CET)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76BBF819A2
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 14:11:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-5e4b410e48bso8512291a12.0
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 05:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741093841; x=1741698641; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uRfx6B52NpndFuqFC9hIQaVZrOgpj7/00dUmP9D25Fo=;
 b=UbKkfEFUz31OqVodssalbJXfMT3dT6Xsn6TrJSps7cgJOwiiwkQRqm/nrzwNKr05IN
 fOiyfB6aSFj0rpdGMHP0JN4HK2IAIsYI9yjS2cIupgwACB5+BHvE3XLIKAcfYN0Zhj7w
 0J9GnN9BqiZX3WCZtMN4fURhamXyWbpzpLTTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741093841; x=1741698641;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uRfx6B52NpndFuqFC9hIQaVZrOgpj7/00dUmP9D25Fo=;
 b=F5fQKstFvk7WnBUFcFdGrMWCI280g06aNbUuWRTsm37+t/UrTROHoe/x7tcyhTMlD2
 gXvaYUSmo6I7dbbdCpc9uUi8PMsOEr+D0DnoPOU1z7bxYGWrgpTza03BqhxOc/9im1fJ
 ReJna1879sekPJgJ/x/72kLeEMlgmkbji5AIzwSRldvHtNni5zSShYN2uz8KFaizPaCb
 590IZwAhNKw6Asz/eqggwrIEsNSFaQM8UPGSqvBQkhxlBQayUTbFaeRPsmgdVfw2mCn4
 /zrvGu8TjYQHaqE3LzvG9+4DKYgCa7e9moALXVlcANp52rG5dFnkhloxZA7Tflxs3Ptk
 IhAw==
X-Gm-Message-State: AOJu0YyfY4x1euS4sJI3B3uaaRBPo2HMjSsM0GmNTiytvSlrw49ZZcZ0
 hp/5LhO5uNXILXKOTMLuLp7WhdKaoVqRm/VxQQce8k9BENvW2BQ8/1s51VW6yHEkqDY0QHLo6hU
 eNIXzOTooM0ULAg+P5/j24tune+boyog+qLFM
X-Gm-Gg: ASbGnctRUnUlXRfu9ySkU7LJCLvvjHnuQ3h7mgPQiyMCBTaMY11mt6KEtkCLF7maNC1
 +bCq9KnCLWNcxuEPrxNrQ/tz1QG5eXXmKMpanfpj0qOM2oKHmGGtF9/M2JlCtNbszsKPBAKCKTk
 gHN3DP9+JLdx+ixzILtTIhZrW29rA=
X-Google-Smtp-Source: AGHT+IEXwjSiDUfRxQ2Kw1kTkaCzuONDaq9xOBe9be2ao8DJlGas3qqYBIYWRiKV7tofnCP5SyZJg8aanaSUsaFsj2w=
X-Received: by 2002:a17:906:840d:b0:abf:53ef:6584 with SMTP id
 a640c23a62f3a-abf53ef731amr1445592666b.50.1741093840920; Tue, 04 Mar 2025
 05:10:40 -0800 (PST)
MIME-Version: 1.0
References: <20250225200635.3781149-1-sjg@chromium.org>
 <20250225210645.GA2640854@bill-the-cat>
 <CAFLszTig7O=Eyx+C0xAsxkJi+rP_ghXgXBxUwN47GZLxg-KFwA@mail.gmail.com>
 <20250225213152.GB2640854@bill-the-cat>
 <CAFLszTicCUoW7qqy8qDwQ5a_9HuwwLExQsFdAuYRnXG5-J_NYQ@mail.gmail.com>
 <20250225215306.GD2640854@bill-the-cat>
 <CAFLszTgen=t-SCrwE7nPOjUTGHO7smNZ5CSvxWR=4KhE8DJ=DA@mail.gmail.com>
 <20250227170441.GF2640854@bill-the-cat>
In-Reply-To: <20250227170441.GF2640854@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 4 Mar 2025 06:10:27 -0700
X-Gm-Features: AQ5f1JqFLr2ixwPyaP4o39jFkvNjHVdzwJjQUJNR2wp84W1dUq0PdmO0p3_Vutw
Message-ID: <CAFLszTisYPa1_pbnHNb9a7F2Nrfk70KH27p60_sQ+UTR3tAA0A@mail.gmail.com>
Subject: Re: [PATCH 0/7] binman: Check code-coverage requirements
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alexander Kochetkov <al.kochet@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Brandon Maier <brandon.maier@collins.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Neha Malcom Francis <n-francis@ti.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Peng Fan <peng.fan@nxp.com>, Philippe Reynes <philippe.reynes@softathome.com>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
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

On Thu, 27 Feb 2025 at 10:04, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Feb 27, 2025 at 09:25:25AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Tue, 25 Feb 2025 at 14:53, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Feb 25, 2025 at 02:44:12PM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Tue, 25 Feb 2025 at 14:31, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Tue, Feb 25, 2025 at 02:26:39PM -0700, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Tue, 25 Feb 2025 at 14:06, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Tue, Feb 25, 2025 at 01:06:25PM -0700, Simon Glass wrote:
> > > > > > >
> > > > > > > > This series adds a cover-coverage check to CI for Binman. The iMX8 tests
> > > > > > > > are still not completed, so a work-around is included for those.
> > > > > > > >
> > > > > > > > A few fixes are included for some other problems.
> > > > > > > >
> > > > > > > >
> > > > > > > > Jiaxun Yang (1):
> > > > > > > >   binman: Workaround lz4 cli padding in test cases
> > > > > > > >
> > > > > > > > Simon Glass (6):
> > > > > > > >   binman: Exclude dist-packages and site-packages
> > > > > > > >   binman: Drop GetRootSkipAtStart()
> > > > > > > >   binman: fit: Drop unused code
> > > > > > > >   binman: Drop algo check in CheckSetHashValue()
> > > > > > > >   binman: Workaround missing test coverage
> > > > > > > >   CI: Run code-coverage test for Binman
> > > > > > >
> > > > > > > While we likely need Jiaxun's fix in order to be able to update to
> > > > > > > Ubuntu 24.04, the series itself doesn't apply to -next, please rebase if
> > > > > > > you intend for this to be in mainline, thanks.
> > > > > >
> > > > > > OK, would you able to pick this series up?
> > > > > >
> > > > > > https://patchwork.ozlabs.org/project/uboot/list/?series=444576
> > > > >
> > > > > It also doesn't apply. You should really put together a PR, against
> > > > > next.
> > > >
> > > > Oh, it needs another patch anyway. I'll send a v2. Once that is in I
> > > > can rework this one.
> > >
> > > Again, it would be helpful if you would send a PR and always base your
> > > patches on the appropriate upstream branch.
> >
> > I understand that, and I'm happy to rebase / resend when you are ready
> > to apply. I'd like to keep the diff as small as we can. But I don't
> > think it should hold up reviews, otherwise we're just going to diverge
> > further. When you reject patches for your tree I typically apply them
> > to my tree in the hope that they might find favour in future.
>
> I think you've got this backwards still.
>
> > For the skip-at-start series I sent a series, which you have seen.
>
> Yes, and what blocked them to start with is they defaulted to your tree
> and not mainline.

I can send a pull request for things, but your tree is missing things
and that seems to be growing over time.

As you have seen, I sent [1] to test the water so we'll see how it fares.

>
> > Speaking of patches, the PXE series seems to have got lost. It is
> > 'changes requested' but I'm not sure what changes are needed.
>
> The changes requested was that it breaks lwIP + tftp. You asked that I
> ignore that since it wasn't failing in public CI, I said it was failing
> in my CI. I then noticed that it should have failed in public CI (and
> likely was on Azure, but that's often overloaded enough I cancel runs
> when I see failures elsewhere). So I then fixed public CI so that the
> lwIP platforms there too should fail.

Well I did offer to add a test in my lab...I'll take another look at some point.

>
> > I also just found the membuf thing was never applied.
>
> Was that the one where Rasmus asked you to do it differently?

Yes and I spent quite a bit of time investigating, and replied, but
didn't see any further response. The power-of-two idea is too
restrictive and anyway is beyond the scope of my series which is
mostly to add some tests and align the naming better with U-Boot. I
did suggest some follow-on ideas. Anyway, I am wanting to use it in
future series, so it would be good to apply it.

Regards,
SImon

>
> --
> Tom

[1] https://patchwork.ozlabs.org/project/uboot/list/?series=446179
[2] https://patchwork.ozlabs.org/project/uboot/cover/20241018030027.842749-1-sjg@chromium.org/
