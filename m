Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD353C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 13:31:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0DBA8710C;
	Tue,  7 Nov 2023 14:31:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DEdCWxp3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02C0086FD5; Tue,  7 Nov 2023 14:31:37 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 813D88710C
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 14:31:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-53de8fc1ad8so9577225a12.0
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 05:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699363894; x=1699968694; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Wbu/HKuTOC5/0Tdgo08J5MPmk4N48RIfvE16u+0D7bE=;
 b=DEdCWxp3EDLpz2phuREMJB8bwOK0ZkxGawVb1CYueWhEjEVPQME4JwAed8h4OFNoEK
 yxiGEoC1nnR3Kajj3FlUseONbMiJXwiWFHeJXadsebW5BGF2q22uHGowxuXg1epmY1v7
 C0+DlgdnT5IpYJhxOaJAH4SB0vaLIpR+ZaD5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699363894; x=1699968694;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Wbu/HKuTOC5/0Tdgo08J5MPmk4N48RIfvE16u+0D7bE=;
 b=Fq5o509/lkMHUMLRDreCUg/IaU06j9hpcfWV1rfYQGGwDHP1dmR7xws4Mvr13d2tyR
 e6HMhWTf/KazcDPjkUxOLnOfwIMX2OWJjbiDwNrTTZsTcXRPGqvoe4+fy3i94ABXPY0C
 o8oMeBGjlwZT9kHJdOOD8Alqkn2L9eAAJSz++CVx/TrVJekJQhbp2Snoa2qkVm8aHIIO
 ZsEDUGsi4061Es/QRs3AUhOJoHJM/3Q5gsA9hnXRv3CsGKwE4ENUdsGxDEnNtAvIZtL6
 2pbn6tTRAsHvna+fwdP2qMlDDxrmacpCyedZKNAi2FSkIgUfMI3sBLQRBHoPXukUYVrI
 ql3g==
X-Gm-Message-State: AOJu0YyVse0iTIoiaDI/NrYHuSsdHk5/t1ombDvu1rE5o2A9RVDWIhEc
 JpuQwXfMoss/XS9XHnSa2Umg+IgSZkgYQ+PM0zFG4Q==
X-Google-Smtp-Source: AGHT+IGt2+l9n31gz3EnhEUBIGX3yyFtXlZY3pxzpnGbapqdc75+pq7hHJjWLw8DuOb9PdRA9U67GrcVs6u5z1saQZs=
X-Received: by 2002:a50:9b5d:0:b0:544:1fa7:b6c1 with SMTP id
 a29-20020a509b5d000000b005441fa7b6c1mr10827643edj.0.1699363893826; Tue, 07
 Nov 2023 05:31:33 -0800 (PST)
MIME-Version: 1.0
References: <20231105200453.1887418-1-sjg@chromium.org>
 <7a1345b9-8844-48e9-a1b5-8c7508cefeb1@prevas.dk>
 <CAPnjgZ1BbpM_Ksr5aKg2zWLv1FPy-N_Kz6fbrkZoh=i7LfpMUA@mail.gmail.com>
 <20231107130450.GA6601@bill-the-cat>
In-Reply-To: <20231107130450.GA6601@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 7 Nov 2023 06:31:15 -0700
Message-ID: <CAPnjgZ0jFTG-Rq0u5yaMjSxcxdQvr578W2P+nzFx0g0GbQHjNQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] bootm: Handle compressed arm64 images with bootm
To: Tom Rini <trini@konsulko.com>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Marek Vasut <marex@denx.de>, Eddie James <eajames@linux.ibm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Joe Hershberger <joe.hershberger@ni.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>, 
 Safae Ouajih <souajih@baylibre.com>, Sean Anderson <sean.anderson@seco.com>, 
 Sean Anderson <seanga2@gmail.com>
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

On Tue, 7 Nov 2023 at 06:04, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Nov 07, 2023 at 05:23:05AM -0700, Simon Glass wrote:
> > Hi Rasmus,
> >
> > On Tue, 7 Nov 2023 at 02:56, Rasmus Villemoes
> > <rasmus.villemoes@prevas.dk> wrote:
> > >
> > > On 05/11/2023 21.03, Simon Glass wrote:
> > > > This little series corrects a problem I noticed with arm64 images,
> > > > where the kernel is not recognised:
> > >
> > > The $subject is misleading, bootm works just fine with compressed arm64
> > > images, with the type set to "kernel".
> > >
> > > >         Type:         Kernel Image (no loading done)
> > > >         Compression:  gzip compressed
> > >
> > > Isn't that a non-sensical combination to begin with? Decompressing the
> > > Image.gz kernel image to any location (however you determine that
> > > destination) _is_ loading it.
> >
> > Yes, I agree.
> >
> > >
> > > If you want XIP, obviously the image must be uncompressed in the FIT. I
> > > don't understand what you're trying to do here.
> >
> > Hmmm, I think I have just got confused about all of this, perhaps
> > because ChromeOS uses kernel_noload with compression. Is that an
> > invalid combination?
>
> Yes, that sounds like an invalid combination.
>
> > But then how does loading actually work? We don't want to put the load
> > address in the FIT, since we don't know what it is...we want to use
> > the address provided by the board. Which is kernel_noload...so how
> > should this be implemented?
>
> What do you mean, provided by the board? With kernel_noload we XIP the
> payload, because the board provided (by loading us to) a safe place to
> execute whatevers in there. In the olden days, that would mean (almost
> certainly) the zImage which in turn was already compressed and
> self-relocating. I know technically one could use the raw vmlinux
> instead. With the Linux Kernel and ARCH=arm64 (and a few other arches
> now too), they dropped the self-decompression part and the whole payload
> must be decompressed. We handle this case in "booti" today by having to
> have the board (via environment) say where to decompress to (and how
> much space is available). Then we move it back to where we started from,
> which is likely not necessary.
>
> Looking at
> https://www.kernel.org/doc/html/latest/arch/arm64/booting.html and
> https://www.kernel.org/doc/html/latest/riscv/boot-image-header.html
> stating "we're just like arm64" we can do better than we do today for
> this format of OS image. If aren't compressed, we only need to ensure
> that we are correctly aligned and move (and tell the user) if not. We
> can even put the 2MB check under some legacy kernel CONFIG option (3.17
> is over 9 years old). With respect to automatic decompression, if we
> don't have something telling us where a buffer is and we can't pull from
> the environment, we should tell the user and stop?

With the booti command, the kern_comp_addr_r and kern_comp_size vars
are used. Perhaps I should update my patch to use those too?

Do you understand what I am asking about, with bootm? It should be
possible to ignore the load address. In fact, load addresses in FIT
are mostly bad these days, IMO. If this is not kernel_noload, then
what should we use?

"provided by the board" means that the board knows the memory map, not
the FIT, so only the board can provide the addresses to use for
loading the kernel.

Regards,
Simon
