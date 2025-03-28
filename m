Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B1A2C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 14:26:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B6178144A;
	Fri, 28 Mar 2025 15:26:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lN+6fsE+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1123481DB4; Fri, 28 Mar 2025 15:26:48 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED1898129B
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 15:26:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5e6c18e2c7dso4080841a12.3
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 07:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743172004; x=1743776804; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/3MUHwyEi3eABzw0uCtS95j8vuukIq0agSbifGvJtsQ=;
 b=lN+6fsE+rmvyTRIq1XSyrEXF9+7fWqXWXa6jFu0tLnqCXPtgmk2Fh+iYEIWnPkNNE1
 Mbh9DWgdZE+zgShFyYlWaykBPW4Psxnqap9OLDTKdmlGCjOX6dsI6gGfsQxv+G3kI/0z
 E0TfxG9n8FAfdERkp7jHF8fVqq+D/LUUfOTf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743172004; x=1743776804;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/3MUHwyEi3eABzw0uCtS95j8vuukIq0agSbifGvJtsQ=;
 b=xM0qs2QzNR3kHokPKQzyRcWoDSjCYNxqQE9Y5gikYRWxDnJlh0AICPQ6Wn7E0Rb052
 Zx78OrBlYOZNpss797D4TfJOKQTHqVsEuvgXEekfKtRx/QtjmR+iMnxIxcufad9OZrWl
 0RREDWQOm34Px0sR4/8XZ+fU9DpEPJ2Z7ZscujOlG+00m7wj3TG/bLpu0Fr+gvf8Pfh2
 jz+K8C65harjUJrJsRX81fU/7agNIG5GgmY1OirUB61U1uiejHWNmSXoeUzK3hAFDM10
 ikxWG85BIW3x+iOp7d0bQhMeM64Swk9SQBKieF3mSXEN/FE3ToeECND7/yASys34cyVx
 xqkg==
X-Gm-Message-State: AOJu0YxKKxiSS1qkutALJcb1TKPRyLOXlFnV7tMFrcz+b/PVq/ko9scg
 4R/Y2Bzqk26/nkea+gJntepNqw60f0ERBomsQvqra2fgT2ltikxluQ84a28lAg29xw96zovybDy
 4FpLmyEfWfpKTfwEYnXqdOhzudmSnbmPfRzRY
X-Gm-Gg: ASbGncsImVG1MA8+IvpamKxsjvm0TrcN+tmGj7SR3AxAZIH5gXJr/872G/lnqboXi77
 NVgMQjxnrwKjiZi9CtFuXfHeLYIilSZIonwhkXZmuysz76v4Ona4T5Fgtmd8c0JOItoiLZYt/6A
 zkUwodQjBqzsFXfL+jOhTVvMuOb/k=
X-Google-Smtp-Source: AGHT+IEHSFK9/SfnneG9E3oNQzyJqgQnhGxD5WG0Y8KFJC3kPVueCIoQUHyrhjq2+3khOYsCJXLCNlH3HBY9Ifmobmw=
X-Received: by 2002:a17:907:3f26:b0:ac4:2ad:44d9 with SMTP id
 a640c23a62f3a-ac6faef2150mr747870466b.24.1743172004035; Fri, 28 Mar 2025
 07:26:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250327231318.2713201-1-raymond.mao@linaro.org>
 <CAFLszTjpbxH6_LEuv5mAyOjt812hXvTKL1nDpP42HMJXwMryWA@mail.gmail.com>
 <CAEfUkU+tYjjNQAmwv2=FWkPYxLZriAd3FdAVQQrdt7PTXK_xiQ@mail.gmail.com>
In-Reply-To: <CAEfUkU+tYjjNQAmwv2=FWkPYxLZriAd3FdAVQQrdt7PTXK_xiQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 28 Mar 2025 08:26:32 -0600
X-Gm-Features: AQ5f1JpzdBmLusy2LC4kdp7MyvnSp_-7vunV8duKhhiToP-gdjytMCHnJLUcP6A
Message-ID: <CAFLszTiwNM3=ZgFRU+rJN=nmQ9YuS8gkUf_jRNqhSJpuELi09g@mail.gmail.com>
Subject: Re: [PATCH 1/2] bloblist: fix the overriding of fdt from bloblist
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Joe Hershberger <joe.hershberger@ni.com>, 
 Tom Rini <trini@konsulko.com>, Ravi Minnikanti <rminnikanti@marvell.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Matthias Brugger <mbrugger@suse.com>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Raymond,

On Fri, 28 Mar 2025 at 08:17, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Hi Simon,
>
> On Fri, 28 Mar 2025 at 07:34, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Raymond,
> >
> > On Thu, 27 Mar 2025 at 17:13, Raymond Mao <raymond.mao@linaro.org> wrote:
> > >
> > > When a bloblist is valid and contains fdt, it explicitly means
> > > a previous boot stage is passing transfer list compliant with
> > > Firmware Handoff specification, thus the fdt from bloblist should
> > > not be overridden with the ones from board or env variables.
> >
> > Why is that? The board can choose to override it, if it wishes, but in
> > general, if gd->fdt_blob is already set up, it should return -EEXIST
> > from board_fdt_blob_setup().
> >
> First, if a board is running in a "stand-alone" mode, there should not
> be a transfer list passed from the previous boot stage.
> Secondly, overriding the transfer list with the env variables does not
> make sense, since booti, bootm and bootefi are actually using the env
> variables to get the fdt when launching to the kernel.
> We need to do the opposite way - override the env variable with the
> one pointing to the bloblist fdt (See my patch [2/2]), then all boot
> commands can work with the transfer list.

OK, but now we are going back to the OF_BLOBLIST thing that I did 18
months ago and ended up being the major reason I had to create my own
U-Boot tree just to get my boards working.

Anyway, Tom has agreed to let me maintain bloblist (and maybe fdt?)
again, so I am going to send a series to 'clean this up' as Ilias
would say. Let's see if that passes muster, because I do agree with
you that if the devicetree is in the bloblist, it should be
definitive.

Re your second point, do you know why we have fdt_addr? Is it just for
the distro scripts? I'm wondering if we could restrict the use of
fdt_addr to just the places that actually need to use environment
variables.

Regards,
SImon
