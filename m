Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 279D6E77197
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 12:33:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B217B805EA;
	Thu,  9 Jan 2025 13:31:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FhqVnuVS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BE428005B; Thu,  9 Jan 2025 13:31:39 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1B50805EA
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 13:31:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-aaf6b1a5f2bso376912666b.1
 for <u-boot@lists.denx.de>; Thu, 09 Jan 2025 04:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736425895; x=1737030695; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EZQwjQXsGBBT13xCMysjGoS3c+Up+M4Y2sLc5Lwvl9U=;
 b=FhqVnuVSGYK31KG0xHBuL3vrmCrmUtpy9K/jXaEKGd4zNgbvoStfNEgaysOKAH9Idz
 iCXZ1JIqiYa83ZSXZGm/1vz2g/mQduaFMs9vnUwACBEKg+wQFexbDts4JeSbMUoNIDap
 pHXOz8h8jI8Y14sqeAh3VNddElS+reqX9EiAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736425895; x=1737030695;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EZQwjQXsGBBT13xCMysjGoS3c+Up+M4Y2sLc5Lwvl9U=;
 b=ov/6kCaAanyj+lXVt7gnLa9UoJZdvQiZX8n3EzQfaCKCpr8qxW+zc/lKBsPETI5BSq
 tKcmxoqbFklLRmqTDaHummKFNZxpEhg6HMZHYHsApYO3XmkTzhKlWNtt+TZTORb2RIti
 HQ5UGRZaYlCJEJJiThoSXA7Dn5jyrQ+zjXCkx+inuH0qg6PjIMBRgqg5qiUz9ByHown4
 RGwJPZZ499TEmSGMRwyQiB0Ua2HY/y12+pBL4FOMBP+HOwBy50iW6hl5Eo7RyZqA5gQk
 e5G/AK11n8uK9CjT0ARbkK+WqyqrMTicciax9af75JptxuReuYGd7xi2pXWfRRPzRLZt
 va0w==
X-Gm-Message-State: AOJu0YwIK8kWFuS+4BLtNVRUsOPC3wo1N2AX3IfU3h6TUZCglymVAqC7
 R3iv/AM/60dwEhbfROc22K8mC3gNnAz7ZYtnspp/XlJeHj0wPO6t43sBSGx1Xq16h+7J1ELlSei
 u4LacV4lnf15RVtnI3UdlO694Ff0bv/Ndvv8q
X-Gm-Gg: ASbGncvheO++WobFRLCrAs2s9kyRJL75dOQf9WZUzycQmF68TjXnWeoxDQJIY9w2YKH
 Br3EvwxuRMqbUaaDhKEvqMUs6M0GZvusWLftv+J0=
X-Google-Smtp-Source: AGHT+IFnQ93VQwqQeS4jssaX6NCZvIHMuNu00m6xN43V1/abIZY29ydFdqdszshWifJXOgPtgukr/4NZ3mZWJ0HfiiA=
X-Received: by 2002:a17:907:1b05:b0:aab:a02c:764e with SMTP id
 a640c23a62f3a-ab2c3c7a0c6mr301493666b.14.1736425895109; Thu, 09 Jan 2025
 04:31:35 -0800 (PST)
MIME-Version: 1.0
References: <20241220040120.3245610-1-sjg@chromium.org>
 <20241220040120.3245610-5-sjg@chromium.org>
 <20241220145609.GD1505244@bill-the-cat>
 <CAFLszTjzP+vm1YoUX_avNq4_4qnUtNzzjLyFocEhJYrCA7cGOA@mail.gmail.com>
 <20241220172348.GJ1505244@bill-the-cat>
 <CAFLszTjMWU7f_Db+qp6hFecx=mv+54ojX+zSZcrV-2CxT5dcxw@mail.gmail.com>
 <20241220204840.GM1505244@bill-the-cat>
 <CAFLszThNrYMZtiPRewdvY-ip6XmHKdLFbQ5OHZLTsULpiJZKsw@mail.gmail.com>
 <20250108173151.GL3476@bill-the-cat>
In-Reply-To: <20250108173151.GL3476@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 9 Jan 2025 05:31:23 -0700
X-Gm-Features: AbW1kvZvJ51AgMsiAb8ZT38WW1K3EFcClglGM764gmh64nmDQseuj0zmfdxSE-Q
Message-ID: <CAFLszTj2TSZYHUWUA2GmXrYQQWH8=vxqs80GCCH1a8sJre69Ug@mail.gmail.com>
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

On Wed, 8 Jan 2025 at 10:31, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Jan 08, 2025 at 10:04:07AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 20 Dec 2024 at 13:48, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, Dec 20, 2024 at 10:37:34AM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Fri, 20 Dec 2024 at 10:23, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Fri, Dec 20, 2024 at 10:18:17AM -0700, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Fri, 20 Dec 2024 at 07:56, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Thu, Dec 19, 2024 at 09:01:19PM -0700, Simon Glass wrote:
> > > > > > >
> > > > > > > > The current localboot implementation assumes that a 'localcmd'
> > > > > > > > environment variable is provided, with the instructions to follow. This
> > > > > > > > may not be included, so provide a fallback in that case.
> > > > > > > >
> > > > > > > > Add a test image and test as well.
> > > > > > > >
> > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > >
> > > > > > > This is a pretty niche feature, I had to dig around a bit to see how
> > > > > > > it's specified elsewhere (not really) and how it's used. And I think
> > > > > > > that based on how it's used, making up a bootcmd when localcmd is
> > > > > > > undefined is the wrong approach. It's the hook for "run what I defined
> > > > > > > in the environment", so if not set erroring back out seems appropriate.
> > > > > >
> > > > > > Yes, but unfortunately it seems to be used and we should support it.
> > > > > > The problem with scripts is that we don't know the boot device, etc,
> > > > > > so it needs to be integrated into PXE. I did consider putting
> > > > > > something in bootstd, but we only find out that it is requesting a
> > > > > > localboot when actually running the extlinux bootmeth, so this is what
> > > > > > I came up with.
> > > > > >
> > > > > > It will be interesting to see if any other cases come up.
> > > > >
> > > > > It would be helpful at this point I think if you can point to how the
> > > > > code for handling this case (the LOCALBOOT keyword followed by an
> > > > > integer) in other projects so that we can be compliant with what's
> > > > > expected, even if it's poorly documented.
> > > >
> > > > Yes, it seems very hard to find anything at all.
> > > >
> > > > The implementation in syslinux uses the BIOS to jump to a boot sector:
> > > >
> > > > https://repo.or.cz/syslinux.git/blob/HEAD:/core/bios/localboot.c
> > > >
> > > > I'm really not sure how it is supposed to work with a filesystem.
> > > >
> > > > [1] is a usage of it for rpi
> > >
> > > Yes, I did some searching on extlinux.conf and localboot and got a few
> > > hits on people using localcmd for when they need to run their own
> > > special thing, for various reasons, for example:
> > > https://stackoverflow.com/questions/54258960/applying-fdt-overlay-with-u-boot-using-extlinux-conf
> > >
> > > > But other than that, even Gemini doesn't seems to have much idea.
> > >
> > > I'm only half surprised it didn't make something up for it.
> >
> > I've been quite amazed at its capabilities recently. I can mostly get
> > good answers to quite complex questions and it is very fast now. I'm
> > just waiting for when I can start using it for development.
>
> Oh no, please no. We don't have a policy yet, but no "AI" created code,
> please.

lol me too :-)

>
> > I wonder who maintains the extlinux stuff. Do you have any idea? It
> > would be nice to move it into a git tree and generate the spec from
> > there.
>
> I would say the syslinux project should be the authority unless they say
> otherwise.

Yes I've tried irc and will see if I get any ideas. Will send an email too.

Regards,
Simon
