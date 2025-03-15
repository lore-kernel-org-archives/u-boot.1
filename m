Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EBB6C28B28
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 14:38:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDDD680F91;
	Sat, 15 Mar 2025 15:38:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ElLALV3A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E721380F9A; Sat, 15 Mar 2025 15:38:43 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61DE980756
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 15:38:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5e5e22e6ed2so4557872a12.3
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 07:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742049521; x=1742654321; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TVbtizlVjyZk3wsqRuH5bDpwtK5POmwHDxT89XS3p1g=;
 b=ElLALV3AK7mAgtLSrmK5E5+qhWEi0Ga2H4smCrJRKthDy7r/hVU9cIDOoIWd3bcmTG
 +27e8rpwS4y9vqggytDhcyzhu+IsQEESSdGOKLVTnAIRUKUdoCNVOzTe6Wgu7rB71hP1
 VMziTYvp2Km4BUoJLQcgXtUj7Q2YdwuKpc/Pk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742049521; x=1742654321;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TVbtizlVjyZk3wsqRuH5bDpwtK5POmwHDxT89XS3p1g=;
 b=Ni7s2kbu8rlp8w5FlEMEQY7YcWprswGVEBrTnnlxETtmMM4iJdiiPe6acnLQd+W6Af
 7PwPKGDm7ac+RrV+Eq1xSVaTnM9LGJ2i7OsWT8UR1x2m5sAF6QOWilcZ5/eVAD1G8Z3E
 sS5ctziLjRQzt58jSo2cHqgSJqyfyGfR3OVmtx+oIhlXy+xYTgC72YmKXrs7CCxV104r
 u992lFcSMf/sJsAgEOrGYz76Pk51gB4sdxtMLsY0c7Hf/ajVrn4CMS8LAto86jiaAVSd
 iLSzoZlpvBkwfddCLfGSLtU5XnchezEFJBDd6rT+qgDP4fkgqjVDslfg9SIQA1tJH1Xj
 UcMQ==
X-Gm-Message-State: AOJu0YzAOTD94MjSFoN2If/rNNN2nx6HPUIPqNM8AOu+iYrQVSFrh2UD
 /b7SkrUhyB7VudYpugrw8YUc1of5NrXHUIjpdzvnJMdWhlWSCe3dlXj+0ygk9OpHOJZm4B+MsAk
 zmLinwMWbiwCCNIFbRZupfCYvOse8KFJRbSBU
X-Gm-Gg: ASbGncvOopxWe/rvhCCaHH1FG6KJ0L1RdsdWU5jSjJKBzVyz0BNTqUV/6oHB6ZOh0dW
 oa/J+bu9IB7+GvDfPidNO+7NlfDiDRSP1IDmjxrkvrVALIC+7XM9a//NvVSIfAOmAYRM2uwVxDD
 Z4O7uI33zIP+Iy9G/5VEhZZluwAgJzDVogU+tp7w==
X-Google-Smtp-Source: AGHT+IHJaF9e0zV3ssuT+IiVhzCmNBte73n5CcXuKYJjrLmbw2arKls2ZPF9rh5JhvxJGOeh6TDAYLeE7UrzFjB3HCk=
X-Received: by 2002:a05:6402:2793:b0:5e6:1996:7902 with SMTP id
 4fb4d7f45d1cf-5e8a0c0d26fmr6916482a12.32.1742049520664; Sat, 15 Mar 2025
 07:38:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250306160428.3041057-1-sjg@chromium.org>
 <20250307142255.GL2640854@bill-the-cat>
 <CAFLszTgtYsVQW-kETzUAdvJvAT6fN_53TeoN7o8wu52Ze3u56Q@mail.gmail.com>
 <20250314160652.GS2640854@bill-the-cat>
 <CAFLszTjGV==WftDU6C=S8VB28QJLvFJGS0H3=PKwTCjkZvNibQ@mail.gmail.com>
 <20250315135749.GI2640854@bill-the-cat>
In-Reply-To: <20250315135749.GI2640854@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 15 Mar 2025 14:38:29 +0000
X-Gm-Features: AQ5f1JryOCU1CPd9qV8swCUkqyaT5LDarLbQvIYJbFTEBjjncUyBQewbAE2hkI4
Message-ID: <CAFLszTjEONSErVbE0O5E0+izUDO8yFNZ+hwzvHjvx-nTczzeSQ@mail.gmail.com>
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

On Sat, 15 Mar 2025 at 13:57, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Mar 15, 2025 at 12:54:25PM +0000, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 14 Mar 2025 at 16:06, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, Mar 14, 2025 at 02:44:35PM +0000, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Fri, 7 Mar 2025 at 14:23, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Thu, Mar 06, 2025 at 09:03:27AM -0700, Simon Glass wrote:
> > > > >
> > > > > > U-Boot can start and boot an OS in both qemu-x86 and qemu-x86_64 but it
> > > > > > is not perfect.
> > > > > >
> > > > > > With both builds, executing the VESA ROM causes an intermittent hang, at
> > > > > > least on some AMD CPUs.
> > > > > >
> > > > > > With qemu-x86_64 kvm cannot be used since the move to long mode (64-bit)
> > > > > > is done in a way that works on real hardware but not with QEMU. This
> > > > > > means that performance is 4-5x slower than it could be, at least on my
> > > > > > CPU.
> > > > > >
> > > > > > We can work around the first problem by using Bochs, which is anyway a
> > > > > > better choice than VESA for QEMU. The second can be addressed by using
> > > > > > the same descriptor across the jump to long mode.
> > > > > >
> > > > > > With an MTRR fix this allows booting into Ubuntu on qemu-x86_64
> > > > > >
> > > > > > In v3 some e820 patches are included to make booting reliable and avoid
> > > > > > ACPI tables being dropped. Also, several MTTR problems are addressed, to
> > > > > > support memory sizes above 4GB reliably.
> > > > >
> > > > > Do you plan to rebase the prerequisite series' this requires so that it
> > > > > can be merged?
> > > >
> > > > Here's my understanding of where things are:
> > > >
> > > > 1. You rejected the membuf series and my replies to try to resolve
> > > > that haven't gone anywhere yet. So your tree doesn't have any tests
> > > > for that code and still has the old naming.
> > >
> > > https://patchwork.ozlabs.org/comment/3473898/ is a well thought out not
> > > gratuitous summary of why the series as it stands is a step in the wrong
> > > direction. Tests are good. They're not a reason to pull an otherwise bad
> > > series. This series should be rebased to not depend on that series. The
> > > tests from the other series should be split out.
> >
> > It's not a bad series, unfortunately. I replied with my own comments
> > and I stand by them.
> >
> > I don't mind if you want to drop the #ifdef (which shows how a flag
> > could be used and the code-size impact). But other than that, I am
> > firm on this for now. I've already applied it to my tree and a membuf
> > implementation with tests and without a power-of-two limitation is
> > important for my current work on distros and expo.
>
> Well, you need to rebase this series without that then as I'm not going
> to take something another long time project contributor said was wrong
> and offered lots of constructive feedback on.

It doesn't affect this series. It is for future work.

We'll see if the LTPC replies to my concerns.

>
> > > > 2. I sent the first part of the PXE series so you could apply that.
> > >
> > > Yes, I should be applying that next week.
> > >
> > > > 3. You rejected the second part of this series because it didn't
> > > > include support for lwip without cmdline. I offered to handle that
> > > > case later but I'm pretty sure you rejected that too.
> > >
> > > That's not how I would characterize it, no. I said you should probably
> > > focus on sandbox + lwip, since you're the sandbox guru and ask Jerome to
> > > do the net_loop-alike thing, since he's one of the network custodians
> > > and the lwip person. I was trying to direct you to where your efforts
> > > might be most useful but if you insist on instead doing the
> > > net_loop-alike part and Jerome ack's it, that's fine.
> >
> > As you know there have been many arguments from the EFI guys about
> > sandbox and you have already rejected my sandbox-focussed EFI-memory
> > series for your tree. If I were actually a guru, that wouldn't have
> > happened.
> >
> > I see that Jerome has created some tests, which is good.
> >
> > So really, you should consider applying the full PXE series so that
> > Jerome can build on that and add support for non-CMDLINE PXE in lwip
> > in a way that you would like.
>
> I saw that Jerome posted sandbox for lwip as well and was pleased. You
> can pickup whatever is left and move forward once both your current
> series and his have been merged.

For now I've just applied it to my tree. I believe my offer of adding
non-CMDLINE lwip immediately after you applied it was a good
compromise, but not good enough, so for now I've decided to just move
on.

>
> > > > 4. This series is now marked 'changes requested' but the only feedback
> > > > I see is in the RFC patch.
> > >
> > > Yes, rebase to something that can be applied is a change I've requested.
> > > Because my feedback was "Do you plan to rebase the prerequisite series'
> > > this requires so that it can be merged?". I would have otherwise merged
> > > it by now.
> >
> > OK I sent a PR.
>
> Eh? v4 as-is needs to be rebased to mainline. That you didn't make it
> against mainline but instead your tree is why this wasn't merged
> already.

I sent a PR for the test series, to try to get that landed in your
tree. At least that will help reduce the diff with new tests. The PR
is the only prereq for v5 of this series (Ubuntu test).

>
> > > Patchwork reflects mainline status.
> >
> > OK. I am finding it more and more slow and painful. Since we are
> > talking about Patchwork, I noticed some patches assigned to me in
> > there, so I've assigned them to you. I'll try to look there more
> > often.
>
> I guess you missed the email where I told you what was assigned to you
> in patchwork and could easily be put in a pull request by you to me to
> get to mainline.

Well let's see how things go over the next few days.

Regards,
SImon
