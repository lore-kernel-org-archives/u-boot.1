Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD6AFCF11FC
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 15:10:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6B3788C4D;
	Thu, 10 Oct 2024 17:10:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MLIfmCdD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53CE8889E9; Thu, 10 Oct 2024 17:10:35 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D35EA89114
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 17:10:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6cbcd8ce5f9so8659076d6.2
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 08:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728573032; x=1729177832; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wUs11E/aW34bs96kfcPWyzlbKYYQ0UDIKA4VdagbUvE=;
 b=MLIfmCdDTl/rxmxnPv+y5YC24k2BtCJmfnzZV6t035o39H74/MQ02T5buyETkoba8H
 c8z+kyEqP8i0ohYf4afIoOH95F+/rbgOzoNVXKfwTo+DRe2imQLfJyMTEODztvxrObic
 2NWJAZQGux3NS+i43IOWoD741SN3VBt0pB0Vc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728573032; x=1729177832;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wUs11E/aW34bs96kfcPWyzlbKYYQ0UDIKA4VdagbUvE=;
 b=d96eCZYQRLebWFqHuuRSoey8H3rjPIzcJ1e9Ie9lDBH6Qsz+u8RKFZpFBOmeRTMitC
 ER3rBx7HDynHw6cIEBV6kLvbkCNjAZw+5N5NFI/SznZXB6OflVjK59jb4UiManTW3mz/
 UksqbJEZD1XdcXswlrEiB0Fk/ZX8LAmgO5ikUifsK7mJyvjuIuCiyBvtwLOKtqXIBGJm
 dXM3iRJWQs2dQEG9a3h3J46D5W0y3UvSrt6VhQSTqTKrN1EL6fAxfIQnxrPv0FKguvPC
 KqvqmFwkZP7M0KlA7hJ8tWu8sDpBNTHeh0m81cpElzS0g+y4+JZ9SKBnRrKXq6BDrdl0
 WjCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYkcd+rjd0Q+ATayqowesETOPYNUeuJbVfjelEZZ71XAT5fCIzD9MkmODmU3IEsjf6bAjleNs=@lists.denx.de
X-Gm-Message-State: AOJu0YyQCCwOlGA3K1si6wSEV5Wo5hZtNJOkf+F6ZobQV7byUDo2RK4K
 Sw8TNIe0wRWguOr33r7PFqOntWZITAHOBvNVqRC55l2Ky98SULxJgU6zy/3uX8SppoKZmTYY7pr
 pi9Mmmcvk3qkhoFTvvh0Nt5fPvI7ACsJFxXmJ
X-Google-Smtp-Source: AGHT+IEurUwwxCocTHzVVzDWXF5+u7KlvgH0IhbDnIGfM4MYkHRUYVOEXfXoj9GTRHO1XeHTEWrl3BAXDvazEuYtgeQ=
X-Received: by 2002:a05:6214:33c6:b0:6cb:e3f0:94f1 with SMTP id
 6a1803df08f44-6cbe3f09500mr73791986d6.17.1728573001867; Thu, 10 Oct 2024
 08:10:01 -0700 (PDT)
MIME-Version: 1.0
References: <20241009015020.25817-1-sjg@chromium.org>
 <20241009015020.25817-7-sjg@chromium.org>
 <CAC_iWjKh7_OKKMi9K6eMaiYUN-Nxf+ZQ0NuW9BYzK3u4F0Krcg@mail.gmail.com>
 <CAFLszTjBQaoF9g0nky5mAA429gzA8QvzjxHxooDaRo1=BB+stg@mail.gmail.com>
 <20241009223907.GN14210@bill-the-cat>
 <CAC_iWjK8Bb16aLAKtmYB0Aof4CJP-AAdsMTEYvnFeMeXaiWM9w@mail.gmail.com>
In-Reply-To: <CAC_iWjK8Bb16aLAKtmYB0Aof4CJP-AAdsMTEYvnFeMeXaiWM9w@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 10 Oct 2024 09:09:50 -0600
Message-ID: <CAFLszThoXsWuPu=b+FT0wuURR1rxTE6RWZhUhET9mHbQ+j63ZA@mail.gmail.com>
Subject: Re: [PATCH 6/6] cmd: Add a command to show the memory map
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Alexander Gendin <agendin@matrox.com>,
 Emil Kronborg <emil.kronborg@protonmail.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
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

Hi,

On Thu, 10 Oct 2024 at 06:02, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Thu, 10 Oct 2024 at 01:39, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Oct 09, 2024 at 03:14:25PM -0600, Simon Glass wrote:
> > > Hi Ilias,
> > >
> > > On Wed, 9 Oct 2024 at 04:41, Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > Hi Simon,
> > > >
> > > > We already have a mem info command, which is pretty useless. Can't we
> > > > reuse that ?
> > >
> > > I am not too keen on using that as 'info' is pretty vague. We could
> > > perhaps create a 'mem' command with 'info' as one subcommand and 'map'
> > > as another?
> >
> > Are we talking about "meminfo" which literally only prints gd->ram_size?
> > If so, I don't think it's worth worrying about enhancing that.
>
> Yes, that's the one

So, you mean to just delete that command and make it show the memory
map instead? Or show the memory size at the top, before the memory
map?

Regards,
Simon
