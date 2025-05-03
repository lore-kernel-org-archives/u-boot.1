Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51AA6C369C2
	for <u-boot@archiver.kernel.org>; Sat,  3 May 2025 21:28:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7204828C2;
	Sat,  3 May 2025 23:28:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MNnwaH1/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CF68828BC; Sat,  3 May 2025 23:28:08 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9594780EE5
 for <u-boot@lists.denx.de>; Sat,  3 May 2025 23:28:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5ed43460d6bso4826406a12.0
 for <u-boot@lists.denx.de>; Sat, 03 May 2025 14:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746307685; x=1746912485; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=b34LbA3Pw7EbBphkzpsdL8uLA7/IvjE0WTdrWrUwDrU=;
 b=MNnwaH1/fUEyRmCQq8xGz+tU04pO9+XjKhZz0JoFWbCbDoZUWr2/uF53uv3mlC/tIS
 EDBiyJKrezXcpy2cwV9OkMTCwXKv2Th4NFBIo3M2DN/7EdiPGulGk3aC/39/LAEucsie
 CHnr64rbowkLihUNNbCtdmsLt49QgbzfKILas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746307685; x=1746912485;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b34LbA3Pw7EbBphkzpsdL8uLA7/IvjE0WTdrWrUwDrU=;
 b=Z/wxgFZcfsYH+qHkAJGTImvG9hehNoaD9hRT8YhrGW2tStVpctiD+ciCHNtvZ7p9hq
 N0QaEaecze2dnmHTQJ2WPNVSB4883DVcwpYYWtuolD5WUdCPYus4WAWOeG0PiD+Cwbc8
 cjS6uizzaX5dAq05g3QymyfuuRYZ3HWvk8IRmlUQtCtoV+LKNKKni/WTiylGSMl961Gd
 88mssbW3FfutEBs/4Gy67SOygkYr4vCzPVwIY8O3LPTY5KyhbsQs50Y1y5FtRuPj3RiR
 08ItARyn5SHr+JTG5rr0g20ZXjJFvsSMpQp4dYR+0LLQm8T2EzoqY6RwylM56JNvbAqa
 DrSA==
X-Gm-Message-State: AOJu0Yw+aobBtrhrvfBQTRfSXbBodBO3mwafx5+QuR/zHwJncl/Q7dku
 S5qlrKcsi+YTi+lCs5hoplexTE0vtIQIk76m6AfiRN2wHKUvpBkstYAN4EYosNbM7F0rneAUho2
 8WvhiatK1Mw007/NeFshk9pa7kKGXwWJ8mgRf
X-Gm-Gg: ASbGncs5NoeynUFZNokjvH0yrKvKmSXMml6kbFoa3x2IL4eFCwtnsxAq3IUAwJQ2Bck
 d69PzIky0IXGUFbYe+SKSqUwYthZjxgM1iq5PBEsifry/lner7syxA1Ox+0DVoNV0MnzEMU41dK
 UzspND6b1OEikevsNnhZtSGNpH1n5LcPaiA5O+zlRY/fgk6DGsLy83+48=
X-Google-Smtp-Source: AGHT+IHSpoiMvorHvPP9662VhlKOHUHLm2tLmJb89HQHSd+65ByOTM2i1uKznLRZ8CF+ahrfHecgilzVkpogNcIev2I=
X-Received: by 2002:a05:6402:2345:b0:5f7:ebfd:58d3 with SMTP id
 4fb4d7f45d1cf-5fab05c15c0mr1851643a12.24.1746307684957; Sat, 03 May 2025
 14:28:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250501010456.3930701-3-sjg@chromium.org>
 <20250501140617.GD1261075@bill-the-cat>
 <CAFLszTirfZExTrcmNWZrjbaz0Av5VCCq6q1iLwoxCdG2KrmDVA@mail.gmail.com>
 <20250501153316.GH1261075@bill-the-cat>
 <CAFLszThcmQYqXO8rqiYKS-1TdyXcTbfTuaOTa3W8vWMTzKn-YQ@mail.gmail.com>
 <20250502140649.GQ1261075@bill-the-cat>
 <CAFLszTjqhnJNvzRUx5UD0ibSOnu+fFUCJa8CUDrTYy7vw1cjyw@mail.gmail.com>
 <20250502150429.GV1261075@bill-the-cat>
 <CAFLszTgKn9pbDs365Vztj+-gpcu=PUx5W2dRzpSS=qLdgD6nhw@mail.gmail.com>
 <20250503163035.GC1261075@bill-the-cat>
 <20250503163704.GD1261075@bill-the-cat>
In-Reply-To: <20250503163704.GD1261075@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 3 May 2025 15:27:50 -0600
X-Gm-Features: ATxdqUHrP-3J2-j3NsZe-px4SefeSCHn2AFOhaICOQSqX4NOc5Xt75YgAtd0Z4c
Message-ID: <CAFLszTiQ+TOTEa_qV1S4WBGYzPT0=AuF2-4_oDfZgZZjbjM5Ag@mail.gmail.com>
Subject: Re: [PATCH v2 02/22] congatec: Include env.h to permit reading the
 environment
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Oliver Graute <oliver.graute@kococonnector.com>
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

On Sat, 3 May 2025 at 10:37, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, May 03, 2025 at 10:30:35AM -0600, Tom Rini wrote:
> > On Fri, May 02, 2025 at 08:10:30PM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Fri, 2 May 2025 at 09:04, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Fri, May 02, 2025 at 08:52:37AM -0600, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Fri, 2 May 2025 at 08:06, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Fri, May 02, 2025 at 07:11:56AM -0600, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Thu, 1 May 2025 at 09:33, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > >
> > > > > > > > On Thu, May 01, 2025 at 09:04:45AM -0600, Simon Glass wrote:
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > On Thu, 1 May 2025 at 08:06, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Wed, Apr 30, 2025 at 07:04:27PM -0600, Simon Glass wrote:
> > > > > > > > > > > This file reads from the environment but does not include the correct
> > > > > > > > > > > header. Update it.
> > > > > > > > > > >
> > > > > > > > > > > Drop the unnecessary config.h while we are here.
> > > > > > > > > >
> > > > > > > > > > Are you sure about that? It was explicitly added in commit
> > > > > > > > > > ab61cc7d98f6 ("board: congatec: Remove <common.h> and add needed
> > > > > > > > > > includes") probably because of CFG_SYS_... usage.
> > > > > > > > >
> > > > > > > > > Well I assumed it wouldn't build if it had it, but perhaps that is
> > > > > > > > > incorrect? I understood that CFG_ things had to be values and you
> > > > > > > > > couldn't #idef them?
> > > > > > > >
> > > > > > > > The cases where in that series I added config.h were for good reason,
> > > > > > > > either failure to build or tricky size change reasons. All were
> > > > > > > > intentional. An audit-and-remove of config.h would be it's own series as
> > > > > > > > yes, there's perhaps not the need now as whatever complex chain was
> > > > > > > > unwound.
> > > > > > >
> > > > > > > Oh dear, OK. I'll respin the series.
> > > > > > >
> > > > > > > Hmm but I see you have sent a series that does some similar tweak[1].
> > > > > > > What was the goal there?
> > > > > >
> > > > > > I fixed your problem. Please don't bother re-spinning this series, it's
> > > > > > not clear what problems it's solving correctly.
> > > > >
> > > > > OK thanks. The problem was trying to include net.h in include/efi.h:
> > > > >
> > > > > https://patchwork.ozlabs.org/project/uboot/cover/20250501010456.3930701-1-sjg@chromium.org/
> > > >
> > > > Adding headers to headers needs extra care (so that we don't end up with
> > > > massive implicit include chains).
> > > >
> > > > > So long as that works, we're fine. Having said that, even if it were a
> > > > > problem, we could always refactor things to put the Ethernet decls in
> > > > > a separate header.
> > > >
> > > > Yes, if there's some problem down the line then some refactoring is
> > > > likely the thing to look at, not adding more headers to C files (the
> > > > right path is to unwind the header chain and fix C files, your series
> > > > doesn't remove env.h from any header).
> > >
> > > I hope we haven't got confused here.
> > >
> > > My series removed env.h from being *transitively* included. I had to
> > > add it to C files due to that.
> >
> > Yes, which may or may not be helpful. A transitive include in a C file
> > is not terrible, otherwise many files will have 20+ includes. A
> > transitive include in header file, which in turn pulls in another which
> > pulls in another, is a problem. And the header should be unwound and C
> > files then fixed.
> >
> > > Your series doesn't help with including net.h in efi.h - you can try
> > > that and see that it still fails.
> >
> > Perhaps I took it out too quickly then, I'd have sworn I build sandbox
> > with that change added.
>
> Yeah, I guess I removed it too quick and missed fixing
> drivers/usb/gadget/epautoconf.c still, along with whatever the right
> answer is for unwinding the exfat oddity. Likely seeing what the pain is
> over using the normal byteswap headers instead.

OK, are you thinking of taking a look at that? Or do you think it
would be better to change exfat to use the linux/byteorder stuff
(which I somewhat prefer)?

Regards,
Simon
