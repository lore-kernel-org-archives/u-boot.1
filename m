Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F9CE6F06C
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 15:34:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB6398931C;
	Fri,  1 Nov 2024 16:34:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Gt03JsrQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4A7188DF5; Fri,  1 Nov 2024 16:34:18 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0030A88C4D
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 16:34:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5c903f5bd0eso3524081a12.3
 for <u-boot@lists.denx.de>; Fri, 01 Nov 2024 08:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730475256; x=1731080056; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MiQPsWkx+0bLhbdnaVqvXhnRKvJnTomqDQGUVt6lrv4=;
 b=Gt03JsrQz/p1QN9kwItuKiXD6YQPfKUfxjLCYnfsh/vcdB7j/a9gtku6hEjOjRAHnr
 OkhaE1h7fe4VmP0G3aPcVd6UtjfbZqvSXEg9MkcSTv/aVmMrNuw3PpnAjklL5HFQACUh
 k0Mk5rdTmJ5dOKlg/t/a42AgK7cwu9wxIdEVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730475256; x=1731080056;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MiQPsWkx+0bLhbdnaVqvXhnRKvJnTomqDQGUVt6lrv4=;
 b=dOQbPkdl5WGD+bhAKGEAX1qZZgu8zw1dYRVK6WFszCYSD5pBcCk5/KWazd6+9Q72Cc
 FkjFKIkqffA18zWBLI5yAs+/bJ+2QLzK10MfIXKJH/8UdtzhrUPkhmD8p4QvfLgKPF40
 67hasKO2IFwhOA5MLy5UpNCNJ94eRH7pd2j+PJ9m0DjMEkcnwSxdwxM8JQj3Q0wvhltI
 qXpLN8KQY2MMnz7WuG3fVlDjo0tb4Gw96TRgCs+VrFSfa1BPWWy+BuBJkMCHCHgKl4w3
 K54rshjXpp24MgS9l6A9canDU+HAsy9CUmhrLlQAhwDNWtQrID9XHP779z8f4mSYrblU
 uvlw==
X-Gm-Message-State: AOJu0YzR1l2k74Bgb2XPjVIhpHJ8cHV/QcJwjwH/5zhQ+KDaHqhyIzJn
 lZMmEzepIJe83w6irmB4xDX5yleTxSA0Widkrfif7Q85TtrUgsls282c3GG3KcWubLqUNxPQPSS
 CJJG+rgL7KbSkYiMKqyK160Q7MTkP8UxPRZF7
X-Google-Smtp-Source: AGHT+IEH7ApFbTB/3Lj9cxIT+cih6ELT0J3dnyo66FRkSzKJ+xZazwHxB1yXV6CReo3Y4c1OvqgD+n3Ogja5/BskKRk=
X-Received: by 2002:a17:907:7e84:b0:a9a:123d:3f1a with SMTP id
 a640c23a62f3a-a9e508d4af3mr633577166b.17.1730475256418; Fri, 01 Nov 2024
 08:34:16 -0700 (PDT)
MIME-Version: 1.0
References: <20241029192222.362445-1-sjg@chromium.org>
 <20241029192222.362445-4-sjg@chromium.org>
 <20241029201400.GJ4959@bill-the-cat>
 <CAFLszTigOBUyyi9pxpnLpXwhiw5hJfGEb6QeZPh4jesc5x4Rzg@mail.gmail.com>
 <20241031181405.GX2558755@bill-the-cat>
In-Reply-To: <20241031181405.GX2558755@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 1 Nov 2024 16:34:01 +0100
Message-ID: <CAFLszTiT7UtseESwEJiqmX_pTG2wHSbaqN_o6NLKR5sHCSSr5w@mail.gmail.com>
Subject: Re: [PATCH v9 03/11] sandbox: Add a -N flag to control on-host
 behaviour
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Thu, 31 Oct 2024 at 19:14, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Oct 31, 2024 at 06:52:33PM +0100, Simon Glass wrote:
> > Hi Tom,
> >
> > On Tue, 29 Oct 2024 at 21:14, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Oct 29, 2024 at 08:22:11PM +0100, Simon Glass wrote:
> > >
> > > > Sandbox is its own architecture, but sometimes we want to mimic the host
> > > > architecture, e.g. when running an EFI app not built by U-Boot.
> > > >
> > > > Add a -N/--native flag which tells sandbox to reflect the architecture
> > > > of the host.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > > (no changes since v8)
> > >
> > > I believe Heinrich asked that you invert the logic here and add a flag
> > > for when you need the unexpected behavior.
> >
> > Yes, but that is not correct, unfortunately. The expected behaviour is
> > for CI to use the same filename for its efi apps, no matter what host
> > architecture it is happens to be running on.
> >
> > The use case that Heinrich mentions seems to be broken on x86_64 now,
> > as I mentioned on the other thread, perhaps due to a recently
> > introduced bug in UEFI or QEMU. Just to be clear, this is not a
> > problem with sandbox. I suspect Heinrich will figure that out at some
> > point and then I will be able to try it too. I would also like to run
> > it on sandbox.
> >
> > I hope to get an ARM machine running CI eventually, but I need to get
> > my lab running first.
>
> I talked with Heinrich about this in private and while neither of us
> understand why you want this behavior, we'll stop objecting to it.

OK, good.

Heinrich mentioned that the RISC-V server did not work, for some
reason. But eventually we might have one of those.

I know from my fiddling with 32-bit rpi that even *running* sandbox on
ARM will be a challenge, let alone passing tests, but we'll see.

We should encourage ARM/Linux to set up an ARM runner at some point.

Regards,
Simon
