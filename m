Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 319A6D7360D
	for <u-boot@archiver.kernel.org>; Sat, 30 Nov 2024 20:24:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EA11895FC;
	Sat, 30 Nov 2024 21:24:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nsVh/4RB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8282A89765; Sat, 30 Nov 2024 21:24:24 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72E4489471
 for <u-boot@lists.denx.de>; Sat, 30 Nov 2024 21:24:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-aa55da18f89so454639666b.0
 for <u-boot@lists.denx.de>; Sat, 30 Nov 2024 12:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732998261; x=1733603061; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dXacHkBNtpgOA0Gi827L/c5YpqGZUdr8i2WBWtXDD5Q=;
 b=nsVh/4RBHffpoOrwOgT7ilAtPyQX0DyGGnWy5f318AAAJReN7bE2uEuezXZjPwRaFZ
 rNr70EqdrhMU0/8hMIHL3gOs/iHsbD2wajOn5pgbUwNootL8mS7/sTCQaeCty23GRKum
 TTEOJ9aGguGXW2TGce1Yg2nRR1b/FnpEGeu+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732998261; x=1733603061;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dXacHkBNtpgOA0Gi827L/c5YpqGZUdr8i2WBWtXDD5Q=;
 b=grzsgJasL+XOOy6Vr3FyGWyPj2UWgrjdowT/AvZk77SzED+KJFvayYgm+ZEF6Q87Cv
 9VQNZrlMaVgoCpQZKJ6JbnSaVfXV1ZnG3cpjYrbo7+WP0UOuZfkDz6zK7qUPRiWlQQke
 vEAXt/fkLaoI/KOWYq9QIiRnUIX4Vpng/ihLC9NCKVfavXJZ1i4tNP0m/la04vO3fwhJ
 LWBYPMYsrvE2kiHxjJmtY09VmfoWsojDygZgTiJd9WRuP3amN+qCMQ1Pn6s0/eeLjUrr
 /I58M1doYbv2RgtKfAAIJH1GKldpzpgpFV6MH8DkYUn5oElp8rAuZw+GfLGMVIigtqDY
 RHyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6rnXjrhMKdhfKdG+iXL4HKMkcBcVkA+2tKVDCqpR+2P4C4Z9yNqf3eQM0cPjocatuvBYskHU=@lists.denx.de
X-Gm-Message-State: AOJu0YxAH6thCO8IBd64umAYzuQJh01Sqd9rrDTrs4J7KdU07WCUGTD/
 sUZtJP4py99/ozchYWawAPppEIsB+a0ZpLBIqXQKnrZZCR1XEEbgTaD772D3sII/WBkI4Io2hEh
 6V+I5hnl3DFL6lJCS44iSKp74xeCRDcUOv76x
X-Gm-Gg: ASbGncuqmRLgPl4P4+pskrKIXmEAzBwFzHILryy7chc9PH2M0KVoUhEXlMobgxCD7eE
 lQ5gW03NTNPc9ImprqfsGRXmwRtu0S90=
X-Google-Smtp-Source: AGHT+IEI1rtF/haIycxqM2Kq2z8Ztlu+lB4JQ0TVsNf6Xgobw5uT9j4Og/yvI1PiMj9NZQccTRScc4zTRlYzpUi5KoE=
X-Received: by 2002:a17:907:cb1d:b0:aa5:2d9a:1526 with SMTP id
 a640c23a62f3a-aa581093848mr1189196566b.61.1732998260716; Sat, 30 Nov 2024
 12:24:20 -0800 (PST)
MIME-Version: 1.0
References: <20241125204456.1525752-1-sjg@chromium.org>
 <a6ba9ebe-9d52-4b2d-bb62-02c4f0ea86fb@gmx.de>
 <CAFLszThf3aSwi1yhaQP9Ns7wTNjKH8XicAqUU6vy5gej5GP+CQ@mail.gmail.com>
 <20241126160817.GS3600562@bill-the-cat>
 <CAFLszThDb-dCiGUqDdZmTMAgU7X6P0Zya3ovUgPibPKJQMasVg@mail.gmail.com>
 <87h67szsus.fsf@bloch.sibelius.xs4all.nl>
In-Reply-To: <87h67szsus.fsf@bloch.sibelius.xs4all.nl>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 30 Nov 2024 13:24:08 -0700
Message-ID: <CAFLszTgd3cS8qwkiBzDhUittA0tRnmAm2C0bmtOe8icMWg+YsA@mail.gmail.com>
Subject: Re: [PATCH 00/13] efi: Tidy up confusion between pointers and
 addresses
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: trini@konsulko.com, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, 
 akashi.tkhro@gmail.com, caleb.connolly@linaro.org, j@jannau.net, 
 marek.vasut+renesas@mailbox.org, kettenis@openbsd.org, 
 kojima.masahisa@socionext.com, moritzf@google.com, pwildt@google.com, 
 sughosh.ganu@linaro.org, vincent.stehle@arm.com, u-boot@lists.denx.de
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

Hi Mark,

On Wed, 27 Nov 2024 at 06:52, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
>
> > From: Simon Glass <sjg@chromium.org>
> > Date: Wed, 27 Nov 2024 06:08:10 -0700
>
> Hi Simon,
>
> > Hi Tom,
> >
> > On Tue, 26 Nov 2024 at 09:08, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Nov 26, 2024 at 08:39:05AM -0700, Simon Glass wrote:
> > > > Hi Heinrich,
> > > >
> > > > On Tue, 26 Nov 2024 at 02:10, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > > >
> > > > > On 25.11.24 21:44, Simon Glass wrote:
> > > > > > The EFI-loader implementation converts things back and forth between
> > > > > > addresses and pointers, with not much consistency in how this is done.
> > > > > >
> > > > > > Within most of U-Boot a pointer is a void * and an address is a ulong
> > > > >
> > > > > No. It is phys_addr_t that was introduced to handle the sandbox's
> > > > > virtual addresses.
> > > > >
> > > > > And we should keep this sandbox stuff out of the EFI code. They are only
> > > > > needed for the command line interface.
> > > >
> > > > No. My statement is correct and long predates sandbox. U-Boot has
> > > > always used ulong. Using an address is generally much easier than a
> > > > pointer, so I believe this design decision was (and remains) a good
> > > > one. I certainly would not support changing it. The phys_addr_t type
> > > > has nothing to do with sandbox.
> > >
> > > At the high level, I think parts of the problem are that when U-Boot
> > > went from 32bit architectures to 36bit architectures (assorted PowerPC
> > > Freescale parts) to 64bit architectures that no, we didn't make some
> > > concious and consistent statement that "ulong is for address (except
> > > when it's not). If you look at the linux kernel, phys_addr_t is physical
> > > addresses, ulong is virtual addresses.
> > >
> > > And so phys_addr_t was introduced, iirc, for PowerPC where we had a
> > > 32bit architecture with 36bit addresses and had to deal with that.
> >
> > OK, thanks.
> >
> > I'm a bit unsure what to do here...but am leaning towards having a
> > separate struct for the memory areas in struct efi_mem_list, rather
> > than using the same efi_mem_desc. Then I can have one use addresses
> > and the other pointers.
>
> That does not make sense to me.  Why would you want to use pointers to
> manage what is effectively a memory address map?

I sent a series with the idea. Basically it is to use addresses within
the efi_memory.c implementation, doing the pointer <-> address
conversion in efi_boottime.c

So efi_memory.c has a table with real addresses. The
address-pretending-to-be-pointer happens only in efi_boottime.c and
doesn't spread any further.

Regards,
Simon
