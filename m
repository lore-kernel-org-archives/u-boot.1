Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9778ED6ACCA
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 13:08:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B52DB897FC;
	Wed, 27 Nov 2024 14:08:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hfaln+rA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E872897F3; Wed, 27 Nov 2024 14:08:26 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35E3C897D5
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 14:08:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5cfcf4df87aso8501696a12.1
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 05:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732712903; x=1733317703; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2e3oh4gerAgjWZntU30FCjclYM4YcSRQc2okOlNqesk=;
 b=hfaln+rAiwdxAlV5ZpIjxHnLzHdDDzW07won2VkMy3KA7lCrSswf1+jx+q7L0A+znO
 hUkgvOEiEfTgj8PpUFh5hebfweEOps9hj196nRyd6fSQxLEkE8FvXvHWuy+caj0gisZH
 uL/uy2alAYkFX+x6oB+WQSswJvyXOWrT+62nI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732712903; x=1733317703;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2e3oh4gerAgjWZntU30FCjclYM4YcSRQc2okOlNqesk=;
 b=Lf/d9Y1GYincOT0/mW0kHRrRHlnxvF+3XuRWQQZbqNt/Ix5OJ50dBcGvQgTt/MkT6q
 MMYtcui9LOKI74riv+zD039yvPMyrBKbTnoIxEnKFRFz8+/pbUs6aalAbQ4upGYcGQ2H
 A7qwMlC4/HDtf5UIKdgm7cRiKsU2zid5cqObL79nLkbP5EvsCLU0cFieOVWbUogXEsPB
 cZjRQSIXI9csI4W6xhMpU1cIT1EPmOYXKHvpd6A7l6da918i3+0C9wOM1RA5lPZ7lskX
 yg4z4hP2tyX95uvXourtO6SvvESzV+oxlIIHCSB4r4YJ6XCij/VUr6+i8+2h0jpUYi9l
 ZNOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLHT0ZgP6j49RSxUcTcU3+sxT2F4P38jWksOMiWuOTq+JgiVIhvUNdQuoJLP1i2CH0raS1gEg=@lists.denx.de
X-Gm-Message-State: AOJu0Yz8agc0CZ04I4kHFIZbWR7qOYqn5hwXHXDzHRUDPx4SjCBDrWJt
 QdgQzLHXmWaWhIsO+huntJP9jZvbz6gmdQi+ToEl25gjr1eqyZFyH30iaRvFYMD1uMhMHYuq4xo
 /+yV+55CwARU9FRLQwFErBpGWiB9EtM0OIx34
X-Gm-Gg: ASbGnctmyzrcvN3mO2zjBIJ6LXm/oPi3xdtE4JCAuyMKcC8hcL9BbkkhLrwGBrUJK+2
 JukITSMv5GXxFQ9XW2/UGClEYVLoZeVU=
X-Google-Smtp-Source: AGHT+IGqKFKMLj8VIZCDDg+2SfcF9Erj/uMdQmBMuYkAJ/rgooIRqLp5IEVmfDXsW7870MZl5oPfXZakDr3pZ7iCGfc=
X-Received: by 2002:a17:906:31d0:b0:aa5:37b4:cd5a with SMTP id
 a640c23a62f3a-aa580eded57mr213960766b.3.1732712903645; Wed, 27 Nov 2024
 05:08:23 -0800 (PST)
MIME-Version: 1.0
References: <20241125204456.1525752-1-sjg@chromium.org>
 <a6ba9ebe-9d52-4b2d-bb62-02c4f0ea86fb@gmx.de>
 <CAFLszThf3aSwi1yhaQP9Ns7wTNjKH8XicAqUU6vy5gej5GP+CQ@mail.gmail.com>
 <20241126160817.GS3600562@bill-the-cat>
In-Reply-To: <20241126160817.GS3600562@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 27 Nov 2024 06:08:10 -0700
Message-ID: <CAFLszThDb-dCiGUqDdZmTMAgU7X6P0Zya3ovUgPibPKJQMasVg@mail.gmail.com>
Subject: Re: [PATCH 00/13] efi: Tidy up confusion between pointers and
 addresses
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Janne Grunau <j@jannau.net>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mark Kettenis <kettenis@openbsd.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Moritz Fischer <moritzf@google.com>, Patrick Wildt <pwildt@google.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
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

Hi Tom,

On Tue, 26 Nov 2024 at 09:08, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Nov 26, 2024 at 08:39:05AM -0700, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Tue, 26 Nov 2024 at 02:10, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > >
> > > On 25.11.24 21:44, Simon Glass wrote:
> > > > The EFI-loader implementation converts things back and forth between
> > > > addresses and pointers, with not much consistency in how this is done.
> > > >
> > > > Within most of U-Boot a pointer is a void * and an address is a ulong
> > >
> > > No. It is phys_addr_t that was introduced to handle the sandbox's
> > > virtual addresses.
> > >
> > > And we should keep this sandbox stuff out of the EFI code. They are only
> > > needed for the command line interface.
> >
> > No. My statement is correct and long predates sandbox. U-Boot has
> > always used ulong. Using an address is generally much easier than a
> > pointer, so I believe this design decision was (and remains) a good
> > one. I certainly would not support changing it. The phys_addr_t type
> > has nothing to do with sandbox.
>
> At the high level, I think parts of the problem are that when U-Boot
> went from 32bit architectures to 36bit architectures (assorted PowerPC
> Freescale parts) to 64bit architectures that no, we didn't make some
> concious and consistent statement that "ulong is for address (except
> when it's not). If you look at the linux kernel, phys_addr_t is physical
> addresses, ulong is virtual addresses.
>
> And so phys_addr_t was introduced, iirc, for PowerPC where we had a
> 32bit architecture with 36bit addresses and had to deal with that.

OK, thanks.

I'm a bit unsure what to do here...but am leaning towards having a
separate struct for the memory areas in struct efi_mem_list, rather
than using the same efi_mem_desc. Then I can have one use addresses
and the other pointers.

Regards,
Simon
