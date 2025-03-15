Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D32A2C28B28
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 12:54:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 383DB80F70;
	Sat, 15 Mar 2025 13:54:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LzgV/uaM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA6FF80F91; Sat, 15 Mar 2025 13:54:39 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74139809A4
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 13:54:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-abec8b750ebso530053166b.0
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 05:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742043277; x=1742648077; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pnvnH8wVO5qHVr2rZFQVhxu42KjZs1lkGcg4CXpA0S8=;
 b=LzgV/uaMAolx8JjqAZKqP0OKloaeEpchd+qqZuBGTDQWosbdTugX5xEw4IPkQfqppq
 RzSymmU+ZhTJ1v5QaySCQEh9KodFZUHRbKwqUDk8DdQnl+sRKh+mrFHc6hnndMJ1azCi
 LTOrQjjAF5yjPIlZvbZ1jUN67aQPTwBYDvkhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742043277; x=1742648077;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pnvnH8wVO5qHVr2rZFQVhxu42KjZs1lkGcg4CXpA0S8=;
 b=IMcvXPdbe+vu8WZsMWUU2P/j7km2yuxTPzUndVLHX5seDx2xa0yi/U1868jQHBxLiR
 552a+IYtN7VRcGiKBn6U/y73qe5ZE2FUYRSK8/Dnm/W+wiVE02EM/VhENkZujLPpGP5m
 +reLY0ViUyc2G40FXFHsS6EAGRnimu0TqIXVin5/jn1pjTaeMikyJschUNXwUPi3ybF8
 UzJ9/Z5EpV2LAVJtVMUXdxSovDTyVHBT9T5A6vAkliPNR1ODZPsWY+DNiRgyFYz2Vuvl
 N1oz8xtpsf3IfY/e9G1ug9vGUJhBKbiy5QgsWmwcPM8aFZxprntz+AX4Lhi8Rhbd9KNK
 FlAg==
X-Gm-Message-State: AOJu0YxB40r+mVoCMsEojfM8x1n6MDT3dGBafDp1ndnNWKj7ZAltVMlS
 6ozlSqIFmUgkP+NzOEPWhRFf0wNYfKTXM+sqvzvFMgiOIPbcxNBZ5F7Gz8IX8WU174DH6KZIZo8
 Y7l1BlH4VcefAkzNeOM1zOnH2qe3WFojbUn63
X-Gm-Gg: ASbGncuZlVny72pBta+g9rxZrTAW8NRXv4eY/f80JWv3TFirz7I2YINHj2Uu2WYgGBL
 R1TlO3H3acjQb4exEoCV9wII+xdo//kHTfWpAHwSm+4AXEYVvKWfvKWwwUHjjYhhwbVQXg1vTDs
 iYcvSP5iXmSoPY77jG09HAelqo+tY=
X-Google-Smtp-Source: AGHT+IGHtf/RIdoLdPwNDeUFMCRzB2uZlLj6Fl+EBeeS/Dq58EqE3BXSNRTnmEwdzYxqbtin/vSy0XdXkTatKYRh1Pc=
X-Received: by 2002:a17:907:94c7:b0:ac2:1c64:b0a with SMTP id
 a640c23a62f3a-ac3301940d2mr573914966b.14.1742043276881; Sat, 15 Mar 2025
 05:54:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250306160428.3041057-1-sjg@chromium.org>
 <20250307142255.GL2640854@bill-the-cat>
 <CAFLszTgtYsVQW-kETzUAdvJvAT6fN_53TeoN7o8wu52Ze3u56Q@mail.gmail.com>
 <20250314160652.GS2640854@bill-the-cat>
In-Reply-To: <20250314160652.GS2640854@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 15 Mar 2025 12:54:25 +0000
X-Gm-Features: AQ5f1JqMTvq23AjX0FBIPqJObIJ2yxF3ERff3cPnP9UqG8sdu7lJiadJYaX85z0
Message-ID: <CAFLszTjGV==WftDU6C=S8VB28QJLvFJGS0H3=PKwTCjkZvNibQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/47] x86: Improve operation under QEMU
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Angelo Dureghello <angelo@kernel-space.org>,
 Guillaume La Roque <glaroque@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, 
 Julius Lehmann <lehmanju@devpi.de>, Love Kumar <love.kumar@amd.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Philip Oberfichtner <pro@denx.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Richard Weinberger <richard@nod.at>,
 Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, qemu-devel@nongnu.org
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

On Fri, 14 Mar 2025 at 16:06, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Mar 14, 2025 at 02:44:35PM +0000, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 7 Mar 2025 at 14:23, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, Mar 06, 2025 at 09:03:27AM -0700, Simon Glass wrote:
> > >
> > > > U-Boot can start and boot an OS in both qemu-x86 and qemu-x86_64 but it
> > > > is not perfect.
> > > >
> > > > With both builds, executing the VESA ROM causes an intermittent hang, at
> > > > least on some AMD CPUs.
> > > >
> > > > With qemu-x86_64 kvm cannot be used since the move to long mode (64-bit)
> > > > is done in a way that works on real hardware but not with QEMU. This
> > > > means that performance is 4-5x slower than it could be, at least on my
> > > > CPU.
> > > >
> > > > We can work around the first problem by using Bochs, which is anyway a
> > > > better choice than VESA for QEMU. The second can be addressed by using
> > > > the same descriptor across the jump to long mode.
> > > >
> > > > With an MTRR fix this allows booting into Ubuntu on qemu-x86_64
> > > >
> > > > In v3 some e820 patches are included to make booting reliable and avoid
> > > > ACPI tables being dropped. Also, several MTTR problems are addressed, to
> > > > support memory sizes above 4GB reliably.
> > >
> > > Do you plan to rebase the prerequisite series' this requires so that it
> > > can be merged?
> >
> > Here's my understanding of where things are:
> >
> > 1. You rejected the membuf series and my replies to try to resolve
> > that haven't gone anywhere yet. So your tree doesn't have any tests
> > for that code and still has the old naming.
>
> https://patchwork.ozlabs.org/comment/3473898/ is a well thought out not
> gratuitous summary of why the series as it stands is a step in the wrong
> direction. Tests are good. They're not a reason to pull an otherwise bad
> series. This series should be rebased to not depend on that series. The
> tests from the other series should be split out.

It's not a bad series, unfortunately. I replied with my own comments
and I stand by them.

I don't mind if you want to drop the #ifdef (which shows how a flag
could be used and the code-size impact). But other than that, I am
firm on this for now. I've already applied it to my tree and a membuf
implementation with tests and without a power-of-two limitation is
important for my current work on distros and expo.

>
> > 2. I sent the first part of the PXE series so you could apply that.
>
> Yes, I should be applying that next week.
>
> > 3. You rejected the second part of this series because it didn't
> > include support for lwip without cmdline. I offered to handle that
> > case later but I'm pretty sure you rejected that too.
>
> That's not how I would characterize it, no. I said you should probably
> focus on sandbox + lwip, since you're the sandbox guru and ask Jerome to
> do the net_loop-alike thing, since he's one of the network custodians
> and the lwip person. I was trying to direct you to where your efforts
> might be most useful but if you insist on instead doing the
> net_loop-alike part and Jerome ack's it, that's fine.

As you know there have been many arguments from the EFI guys about
sandbox and you have already rejected my sandbox-focussed EFI-memory
series for your tree. If I were actually a guru, that wouldn't have
happened.

I see that Jerome has created some tests, which is good.

So really, you should consider applying the full PXE series so that
Jerome can build on that and add support for non-CMDLINE PXE in lwip
in a way that you would like.

>
> > 4. This series is now marked 'changes requested' but the only feedback
> > I see is in the RFC patch.
>
> Yes, rebase to something that can be applied is a change I've requested.
> Because my feedback was "Do you plan to rebase the prerequisite series'
> this requires so that it can be merged?". I would have otherwise merged
> it by now.

OK I sent a PR.

>
> Patchwork reflects mainline status.

OK. I am finding it more and more slow and painful. Since we are
talking about Patchwork, I noticed some patches assigned to me in
there, so I've assigned them to you. I'll try to look there more
often.

Regards,
Simon
