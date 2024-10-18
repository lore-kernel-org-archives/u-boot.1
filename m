Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C700DD30016
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 15:03:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CF14891F8;
	Fri, 18 Oct 2024 17:03:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bD2JGvIu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DA6E891F8; Fri, 18 Oct 2024 17:03:09 +0200 (CEST)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3FC889057
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 17:02:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-20ceb8bd22fso19395285ad.3
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 08:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729263778; x=1729868578; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7uS8o8mUxjW0Zui+76BUGkhwAcJAH7BQnIx7GZmqPP0=;
 b=bD2JGvIuAL3XwU8KdbHaYrdHDePwRiCXdKSDeyEoIvOXC3sPGCL9CjJJB2HcWESNIZ
 k7XXPbtIYiVMinROot3XOGnx6ydItmTTbhiJLHybwIibXLSs/oXLfjcxhfJ7yaDaME3F
 YDTWUEimoWEoZ+MpSmn6V9UOYwdozfA/vGCD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729263778; x=1729868578;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7uS8o8mUxjW0Zui+76BUGkhwAcJAH7BQnIx7GZmqPP0=;
 b=Tz22d9CxuVDqO5bNlYTigS7Z3GSfBsFJ4MmUU7E31VU7WWo1iJ5c1Ccn8A3IX5GCqs
 hNWS/SxIw5pDShHFYjCW5qogX6lsohYt2YPqr/myM8mO8Rpy76DpG/Utn0baHCg4l2Ow
 wEFTlT7K6Q++rqIj1mFF7kSoLg7iyRQ9keVLPGDylpmvmeWhl9u7f3lotnicDb4zWgNv
 3TVyGC+SkaYzTX/gZVvC9BZ/jox0biZS0BNj7j0uBE9Gz1iu+go+AKSGLSKnSvYX0DyD
 hyLSOg/8Ta0hmVMGgOEuyWX4Aef5v3wkakxC/DYwEgnIqICsBYRVMFMROlOSBKGgiIHO
 26Fg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXU+cCdFQAsdTj683UMui1UPj6VlxtpcVsPvsjgqA07alJt8BS3UNsjohCiYoCZthnF+5e02XY=@lists.denx.de
X-Gm-Message-State: AOJu0Yyh6wvsm5I0WNT0Ur7zNSQy8o5YzX4xGoyk7Lh5NdQraELLJoMD
 VPBJc1ES7HboP4xyw3aRd/l6fYr/CAubIdsH8wtfWKqq/VOXWQYTtNwFL4PvbcoMfAc9X7e5InM
 f5lRk++WLsOUimg9L9iWEAbVs+p8Th50tvO4I
X-Google-Smtp-Source: AGHT+IEx4vKwBn5k9gEWQ8hpvoosHflKD+W44teVajCfJ5GpVf8f72ZlTXJUKUmnTmEygi+vLnJ8cMtkgqP1hz/z7v0=
X-Received: by 2002:a17:90b:120c:b0:2e5:5ff9:bee1 with SMTP id
 98e67ed59e1d1-2e5618d0e13mr2847504a91.29.1729263778249; Fri, 18 Oct 2024
 08:02:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240926215950.1265143-1-sjg@chromium.org>
 <20240926215950.1265143-7-sjg@chromium.org>
 <56ceb77c-efcb-40cb-a497-0952a8457950@gmx.de>
 <CAFLszThLt96h=+28HaD3LmUk-wgj6mnQFav40ndxTxXVZDQw7g@mail.gmail.com>
 <20241018001734.GR4959@bill-the-cat>
 <CAFLszThZY6fOOYovYV2KdQHpZ-1q9RK1HyZxrCY8AJ8MYceeXA@mail.gmail.com>
 <F7608772-31A8-4F25-9FAB-3D4E194C0E88@gmx.de>
In-Reply-To: <F7608772-31A8-4F25-9FAB-3D4E194C0E88@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 18 Oct 2024 09:02:47 -0600
Message-ID: <CAFLszThoC_wQwx_VYDF+86gp6YByZdvaPrfugwpKi94oCxK=vA@mail.gmail.com>
Subject: Re: [PATCH v6 06/12] efi: Use the same filename for all sandbox builds
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Heinrich,

On Thu, 17 Oct 2024 at 21:45, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
>
>
> Am 18. Oktober 2024 05:05:08 MESZ schrieb Simon Glass <sjg@chromium.org>:
> >Hi Tom,
> >
> >On Thu, 17 Oct 2024 at 18:17, Tom Rini <trini@konsulko.com> wrote:
> >>
> >> On Thu, Oct 17, 2024 at 05:23:19PM -0600, Simon Glass wrote:
> >> > Hi Heinrich,
> >> >
> >> > On Mon, 30 Sept 2024 at 17:23, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >> > >
> >> > > On 26.09.24 23:59, Simon Glass wrote:
> >> > > > Sandbox is not a real architecture, but within U-Boot it is real enough.
> >> > > > We should not need to pretend it is x86 or ARM anywhere in the code.
> >> > > >
> >> > > > Also we want to be able to locate the sandbox app using a single
> >> > > > filename, 'bootsbox.efi', to avoid needing tests to produce different
> >> > > > files on each host architecture.
> >> > > >
> >> > > > Drop the confusing use of host architecture and just let sandbox be
> >> > > > sandbox.
> >> > >
> >> > > As I already wrote in
> >> > > https://lore.kernel.org/u-boot/ae1cf1fa-766e-46a0-8ef9-2c2c7af73d9e@gmx.de/
> >> > > this patch should not be merged.
> >> > >
> >> > > bootsbx.efi does not exist in the UEFI specification.
> >> >
> >> > If that is of concern I can get it added. Let me know.
> >> >
> >> > >
> >> > > Without this patch I can test that shim work and grub are correctly
> >> > > loaded from a distro image. This patch makes the sandbox misbehave.
> >> >
> >> > Why don't you do that with QEMU?
> >> >
> >> > If we want sandbox to do this, I could add a way for sandbox to select
> >> > its architecture. But this patch is correct, sorry. It is basically a
> >> > revert of your patch:
> >> >
> >> > 3a0654ecd0d efi_loader: correctly identify binary name
> >> >
> >> > Let me know if you would like a selection mechanism and I'll see what I can do.
> >>
> >> I'm confused. It sounds like Heinrich is using sandbox to test on
> >> various hosts, how U-Boot behaves, without relying on "just test in
> >> QEMU". I don't see how this disconnects from your usual request on how
> >> to use sandbox for further testing. What is breaking for you, Simon, by
> >> us saying that the host instruction set determines what we load and run
> >> (and so, is portable whereas saying "sandbox" is not, between x86 hosts,
> >> arm64 hosts and riscv64 hosts).
> >
> >This:
> >
> >Also we want to be able to locate the sandbox app using a single
> >filename, 'bootsbox.efi', to avoid needing tests to produce different
> >files on each host architecture.
>
> As I wrote before:
>
> The UEFI specification prescribes the naming of the default boot binary. Deviating from the specification should be avoided.

As I said before, I'm happy to get this added to the spec, if it
helps. It is a real use case.

>
> Anyway you need different images per host architecture. Writing a single switch statement to derive the default EFI binary name from the OS architecture does not look like an undue burden.

Yes, it is easy, but it is taking sandbox in a strange direction. It
becomes a hybrid of a host architecture and a U-Boot architecture,
which is then going to lead to all sorts of strange conversations. At
present it is pretty clear. So I want to head this off at the pass.

I did not get a chance to review the original patch, of which this is
essentially a revert. It has actually bitten me in a few areas.

>
> The sandbox should remain able to start GRUB from a distro image for the host architecture.
>
> The sandbox is not a fake architecture but can be considered a valid testbed for host native EFI binaries including GRUB, the kernel stub, the stubs of UKI images, and the EFI SCT.

I have to say that I wrote sandbox and I know what it is for. It
wasn't designed to run binaries built outside of U-Boot, or anything
of the sort. That said, as I mentioned, I should be able to make
something work here.

To help me come up with a solution, can you please send your workflow
/ commands for the testing you do? Also, what architectures do you do
this with?

My approach to U-Boot is that code needs to land, one way or another,
perhaps with some changes for the use case that is thrown up, or
perhaps done another way. But please try to consider this approach to
Open Source too.

Regards,
Simon


>
> Best regards
>
> Heinrich
>
>
> >
> >The idea of using sandbox to run native EFI apps is new to me, but it
> >sounds great, if it will get us more tests in this area.
> >
> >But sandbox is sandbox. It is not (x86, arm, riscv). It is a fake
> >architecture that we use in U-Boot. I've offered to create a way to
> >get the behaviour that Heinrich wants, so let's see what he says.

Regards,
SImon
