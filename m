Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2675AE77199
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 17:04:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB38D800DF;
	Wed,  8 Jan 2025 18:04:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JIuiD91H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 692E98036B; Wed,  8 Jan 2025 18:04:29 +0100 (CET)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA4468006D
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 18:04:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2f441791e40so17950a91.3
 for <u-boot@lists.denx.de>; Wed, 08 Jan 2025 09:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736355865; x=1736960665; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MBBK0oUAFnMuI7rY95R2RbXGUwkhNlj//7jrJM5ADLQ=;
 b=JIuiD91H8E54u+lJg+ANldE821a47z3SUT+2TOkJunr0lw9bA26G9VILv3d8hWW0Bn
 CjZyu4LEtrwIwzZi1CNHr3XxYdYHAfW4RqpNplJQt7UOc1oDGDzfYw0lvkmi6LNaYHyc
 v/omP27dADHR10LDfEGx5KX1dPw4XezjWwkbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736355865; x=1736960665;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MBBK0oUAFnMuI7rY95R2RbXGUwkhNlj//7jrJM5ADLQ=;
 b=wuSE/OYlRJ0SUGMKMPJR366H0GDP1KNBOu5C8ArL2LveKpWRy0lNo5UncsAAL2PGjy
 L9sKZzHyBE31fqz6eD5U1DgTDgE6yFmTqE2bwnSMT9RH8uS95SQrQxhXGIJeGZi23Aex
 iWBZO5eRhpd+94c9QnYQZT1+X8EZmGcJmqwQp8S68QYwqZ1fTLhw5QbJ3wAx97XdLum4
 Wu9HqLP9Wbw5/VZE3HNxIBOnyM48ocYpMkHflR7O/UEvbwROAx2njSddCNPunlLkkbGp
 JbOJ5y8kVdTlEJTzdLSw1foBrIUpKE7w+Cx9sTE6CYwMvH5s8F44ErJvhrP4mPq6THUo
 8WsQ==
X-Gm-Message-State: AOJu0Yzr+5o6sHvXosWohPUO8JIYHrrvPH6/hWC0Pdfxl60u4OVkl5f0
 QXAat1GjWyQEl5A4VgxafBAbLcwDjQjTjlbU3EDU5hgTWtTWvTY9wM8Wi5+jQO/bna14Bnx2nNI
 NR/lJk+lkj/lmKuhkliBH6U1XUgSRxEvfRXIh
X-Gm-Gg: ASbGnctIDeabIp74HY14wMYc9wMT6llHR/x9j1ARzTPpRQYx7AoM5oH6Bpf4QfA/u6R
 VoCwRItYOF3u8pzGtYyMc5RVCpGpC6cbo2X7YrAY=
X-Google-Smtp-Source: AGHT+IGjwE1KwGDjOD6zpNab+0q9oXywHcoPHtGjD8XX5BwEYimVT6c4+e7PqgMoAt20LwLTMg0aR0vSr5MBunabdEU=
X-Received: by 2002:a17:90b:2f0e:b0:2ee:8e75:4ae1 with SMTP id
 98e67ed59e1d1-2f548f6aa23mr4667204a91.21.1736355865121; Wed, 08 Jan 2025
 09:04:25 -0800 (PST)
MIME-Version: 1.0
References: <20241220040120.3245610-1-sjg@chromium.org>
 <20241220040120.3245610-5-sjg@chromium.org>
 <20241220145609.GD1505244@bill-the-cat>
 <CAFLszTjzP+vm1YoUX_avNq4_4qnUtNzzjLyFocEhJYrCA7cGOA@mail.gmail.com>
 <20241220172348.GJ1505244@bill-the-cat>
 <CAFLszTjMWU7f_Db+qp6hFecx=mv+54ojX+zSZcrV-2CxT5dcxw@mail.gmail.com>
 <20241220204840.GM1505244@bill-the-cat>
In-Reply-To: <20241220204840.GM1505244@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 8 Jan 2025 10:04:07 -0700
X-Gm-Features: AbW1kvanEb0ir6THRN5VV_Lwv5vtObdZumFmrtLaItsu9UOAd36CXZPl0tsyuoo
Message-ID: <CAFLszThNrYMZtiPRewdvY-ip6XmHKdLFbQ5OHZLTsULpiJZKsw@mail.gmail.com>
Subject: Re: [PATCH 4/5] pxe_utils: Support a backup for localboot
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Christian Marangi <ansuelsmth@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Richard Weinberger <richard@nod.at>, Sughosh Ganu <sughosh.ganu@linaro.org>
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

On Fri, 20 Dec 2024 at 13:48, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Dec 20, 2024 at 10:37:34AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 20 Dec 2024 at 10:23, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, Dec 20, 2024 at 10:18:17AM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Fri, 20 Dec 2024 at 07:56, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Thu, Dec 19, 2024 at 09:01:19PM -0700, Simon Glass wrote:
> > > > >
> > > > > > The current localboot implementation assumes that a 'localcmd'
> > > > > > environment variable is provided, with the instructions to follow. This
> > > > > > may not be included, so provide a fallback in that case.
> > > > > >
> > > > > > Add a test image and test as well.
> > > > > >
> > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > >
> > > > > This is a pretty niche feature, I had to dig around a bit to see how
> > > > > it's specified elsewhere (not really) and how it's used. And I think
> > > > > that based on how it's used, making up a bootcmd when localcmd is
> > > > > undefined is the wrong approach. It's the hook for "run what I defined
> > > > > in the environment", so if not set erroring back out seems appropriate.
> > > >
> > > > Yes, but unfortunately it seems to be used and we should support it.
> > > > The problem with scripts is that we don't know the boot device, etc,
> > > > so it needs to be integrated into PXE. I did consider putting
> > > > something in bootstd, but we only find out that it is requesting a
> > > > localboot when actually running the extlinux bootmeth, so this is what
> > > > I came up with.
> > > >
> > > > It will be interesting to see if any other cases come up.
> > >
> > > It would be helpful at this point I think if you can point to how the
> > > code for handling this case (the LOCALBOOT keyword followed by an
> > > integer) in other projects so that we can be compliant with what's
> > > expected, even if it's poorly documented.
> >
> > Yes, it seems very hard to find anything at all.
> >
> > The implementation in syslinux uses the BIOS to jump to a boot sector:
> >
> > https://repo.or.cz/syslinux.git/blob/HEAD:/core/bios/localboot.c
> >
> > I'm really not sure how it is supposed to work with a filesystem.
> >
> > [1] is a usage of it for rpi
>
> Yes, I did some searching on extlinux.conf and localboot and got a few
> hits on people using localcmd for when they need to run their own
> special thing, for various reasons, for example:
> https://stackoverflow.com/questions/54258960/applying-fdt-overlay-with-u-boot-using-extlinux-conf
>
> > But other than that, even Gemini doesn't seems to have much idea.
>
> I'm only half surprised it didn't make something up for it.

I've been quite amazed at its capabilities recently. I can mostly get
good answers to quite complex questions and it is very fast now. I'm
just waiting for when I can start using it for development.

I wonder who maintains the extlinux stuff. Do you have any idea? It
would be nice to move it into a git tree and generate the spec from
there.

Regards,
SImon
