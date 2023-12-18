Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56AACC35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 06:46:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FAB6877FE;
	Mon, 18 Dec 2023 07:46:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WFO7pB+c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5723A877FE; Mon, 18 Dec 2023 07:46:33 +0100 (CET)
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com
 [IPv6:2607:f8b0:4864:20::e36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 790F287C14
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 07:46:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe36.google.com with SMTP id
 ada2fe7eead31-464811e5b3cso1534291137.1
 for <u-boot@lists.denx.de>; Sun, 17 Dec 2023 22:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702881982; x=1703486782; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aXuyzRtg4+Ai+dDAvgnTTx5D8olQjGvQjtsLS+JC/fU=;
 b=WFO7pB+c9rgmmYR9/D/woGb4fIHLGzbKI/4WA4IhDn8sYK5MMhX8Qe8aBBT+Ww4ope
 zgMMOvaj/zs3V48vsQjr/r+Brj+6P4sezTEQXg4MejiH7wT4L1H4c9JiMqh+Z4KsMBoO
 L4FWmMqW2R7SeN6qug/yWo+3cQEDIH+qxR/lYwm7GatW9q8HV1vQ9ebgIrgFk2v1ubDN
 GIqE3gLnaTUcEn2gOLoYSrJdaAYMR7U7Yrz3maPI4AZOIX1bHOP3+a0pbAkwHpOsQxm+
 Mn9jFwWqYIfmijUONlWRX8zY1mPZHKo9PvYVF5jzF/fh0/hK+qBrxjPu+68fv0/slSZv
 a58g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702881982; x=1703486782;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aXuyzRtg4+Ai+dDAvgnTTx5D8olQjGvQjtsLS+JC/fU=;
 b=XV0z/A6CTAjrg9nS30zZbezRq1vCX1ZbfmtVpWBv5FL/7KcAZGSY9iM2kbOH8X8pKx
 LqFsAxvD2HecO52j+D3BXD81QXNGNhqnOjTQ+VKxpSZPaxtTiyAOvNQmoK7Bc09YMMl7
 gLwrzPSEDY7tKu7cJTmDBJukfTBBYG/FC+K+gAhzM9nG5os+a6lmCsTrWpQ8cS21HiTo
 zvYo4eI92gxxqrzLIoKY+7eYUczSvDukeiaa8yePBXSbTlqAFBnUnL1NXdCfLRJC11HV
 JhpaBz834XGEpJw53S9mg5mjaVBo0tCci3jObO+hMTeEMC9lXdikHSog2VRqTipAv+s1
 ybpQ==
X-Gm-Message-State: AOJu0YyBI9cJ2s4NhRGbFvXgB3l2udU1BXIj/JBoM0TJODwehSL70GL0
 rFozI/hI7DyjgfLnNGSo5i593lnHU+L/D1NLpwNJHg==
X-Google-Smtp-Source: AGHT+IEh0f2Zh5kMNzCsOrQWJz4RFNvVZQNLBS0NxnrIt7AOZJC9udA0Ui3v+UDSH0yMmcaWvaY6pAle2Bl7vt2/+8E=
X-Received: by 2002:a67:fdcf:0:b0:466:88e5:c563 with SMTP id
 l15-20020a67fdcf000000b0046688e5c563mr1427365vsq.0.1702881982104; Sun, 17 Dec
 2023 22:46:22 -0800 (PST)
MIME-Version: 1.0
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
 <287883d6-ff1d-4172-bdab-476e880fa8b7@linaro.org>
 <20231214182328.GQ2513409@bill-the-cat>
 <CAL_JsqKTTL2jZfom2J+2Z_vLCS=LgZdaZ198-4yxZ-U1cW-hCg@mail.gmail.com>
 <0a143e84-5379-4455-b3c8-dc97beb9514c@linaro.org>
 <20231215133743.GV2513409@bill-the-cat>
 <20231215-sputter-puzzle-128dc9f85d73@spud>
 <20231215191954.GA2513409@bill-the-cat>
In-Reply-To: <20231215191954.GA2513409@bill-the-cat>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 18 Dec 2023 12:16:10 +0530
Message-ID: <CAFA6WYM3mybKOm_F_J4knCDJ5bn7gwL8=vQPYXL_AhtEmRwL=g@mail.gmail.com>
Subject: Re: [PATCH 0/8] An effort to bring DT bindings compliance within
 U-boot
To: Tom Rini <trini@konsulko.com>
Cc: Conor Dooley <conor@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Rob Herring <robh+dt@kernel.org>, neil.armstrong@linaro.org,
 u-boot@lists.denx.de, 
 u-boot-amlogic@groups.io, u-boot-custodians@lists.denx.de, sjg@chromium.org, 
 krzysztof.kozlowski+dt@linaro.org, caleb.connolly@linaro.org, 
 ff@shokubai.tech, daniel.thompson@linaro.org, dgilmore@fedoraproject.org, 
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, 
 b.galvani@gmail.com, xypron.glpk@gmx.de, michal.simek@amd.com, 
 seanga2@gmail.com, rasmus.villemoes@prevas.dk, peng.fan@nxp.com, 
 jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de
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

On Sat, 16 Dec 2023 at 00:49, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Dec 15, 2023 at 02:45:11PM +0000, Conor Dooley wrote:
> > On Fri, Dec 15, 2023 at 08:37:43AM -0500, Tom Rini wrote:
> > > On Fri, Dec 15, 2023 at 08:50:51AM +0100, Krzysztof Kozlowski wrote:
> > > > On 14/12/2023 20:48, Rob Herring wrote:
> > > > >>
> > > > >> I think some of the important questions to ask are, how often / likely
> > > > >> are the breakages to occur? It seems like these days it's either:
> > > > >> - U-Boot had an early version of the binding and we already state we
> > > > >>   don't support backwards compatibility here. It should be on the
> > > > >>   maintainer to be proactive in this case.
> > > > >> - It's a "the DT was wrong about the hardware, sorry not sorry it's an
> > > > >>   incompatible DTS change now". This too is hopefully the kind of thing
> > > > >>   that at least board maintainers will be more actively aware of needing
> > > > >>   to deal with in U-Boot, if it's really a problem.
> > > > >
> > > > > A common issue in the kernel is with forward compatibility when
> > > > > platforms add new resources from a new provider. Then the kernel
> > > > > expects a driver for the provider and waits for the dependency. Of
> > > > > course, older kernels don't have that provider driver and so the
> > > > > dependency is never met. Not sure if u-boot will have similar issues?
> > > > > At least you should/could know if the provider driver exists or not.
> > > > > (The kernel doesn't because modules.)
> > > >
> > > > If some U-Boot platform decides to aggressively sync with kernel DTS,
> > > > then probably the kernel subarch maintainer should be aware of it.
> > > > Mentioned forward compatibility issue is a result of assumption that
> > > > there are no out-of-tree upstream consumers of our DTS. I am certainly
> > > > not aware of any such consumer for Samsung. If someone told me (me
> > > > wearing Samsung hat), hey U-Boot now cares, I would start caring as well.
> > > >
> > > > The usual argument of contributors wanting to break the backward and
> > > > forward compatibility, is "there is no other OS depending on this"
> > > > (recent discussion with Johan about order of interrupts:
> > > > https://lore.kernel.org/all/ZWcPZPX-eT-xHAOv@hovoldconsulting.com/ ).
> > > > You need to tell the maintainers of that platform, that now they have
> > > > other OS/firmware/bootloader depending on DTS compatibility.
> > >
> > > I think this hints at one of the bigger impacts this might have.
> > > Reminding everyone that other projects do use the device trees and have
> > > for years.
> >
> > TBF, we do try to ask these questions as much as possible, usually (for
> > me at least) citing U-Boot or the BSDs as users. It largely seems to me
> > like we are all bark and no bite though, so a project like U-Boot having
> > a defined "schedule" as you suggest below would add more meaning to our
> > questioning.
> >
> > > Without rehashing history, BSD does use the trees as-is and
> > > for platforms U-Boot supports they are supposed to be re-synced
> > > periodically.
> >
> > I know this is the theory, but I also know that how well this is
> > implemented varies wildly per-platform. I generally don't pay all
> > that much attention to the various arm platforms, but I do pay
> > attention to what's going on for RISC-V and there appear to be no
> > active maintainers of individual platforms and the architecture
> > maintainers are not aware of the status of the equivalent patches
> > for Linux when they apply patches.
> >
> > In recent memory, this has lead to the clock indices in the DT
> > differing between U-Boot and Linux for one such platform, which, IMO,
> > is an insidious difference that is hard to spot during review and highly
> > unlikely to crop up while comparing dts files, since the defines were named
> > identically. To be clear, I am not expecting the architecture code
> > maintainers to be aware of the minutiae of the various RISC-V platforms,
> > but rather suggesting they might have an easier time reviewing if both
> > projects' dts files and binding headers were tied together.
> >
> > That said, automatically synced devicetrees will, as has been pointed out,
> > require the platform maintainers in Linux to be more aware of the affect of
> > what they accept on other users, but it will also require the equivalent
> > maintainers on the U-Boot side to engage too, so that the "upstream" dts
> > files do not change in a way that screws the usecase in U-Boot.
>
> Yeah, it will hopefully lead to better coordination between maintainers
> in some places. There are SoCs where the kernel DTS people are the
> U-Boot DTS people too. All in all, I should probably CC more people than
> I usually do on these resync patches just to try and head off any
> tricky changes like you've mentioned above.

Makes sense.

>
> > Also, if people send fixes to the U-Boot copies of these devicetrees,
> > would the plan be to request that these are sent to Linux and the fixes
> > pulled in via a resync after each -rc release of Linux (or similar, just
> > throwing some example schedule out there)?
>
> The way we've always tried to operate is that changes should be pushed
> to Linux and resynced down, or at least submitted simultaneously. If
> there's some specific bugfixes that need to come in out of cycle I
> _think_ subtree handles cherry picked commits in a reasonable fashion.
>

Agree.

-Sumit

> --
> Tom
