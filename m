Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A43C3E77197
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 15:15:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42E2A80602;
	Thu,  9 Jan 2025 16:15:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AolLvu97";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6AEE8066C; Thu,  9 Jan 2025 16:15:10 +0100 (CET)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AA31805E2
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 16:15:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2f441904a42so1858681a91.1
 for <u-boot@lists.denx.de>; Thu, 09 Jan 2025 07:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736435706; x=1737040506; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mDqcuQTkVw0GrRm5j+QC8P+9PcAqQDeKip3w9wFb/kk=;
 b=AolLvu97wE/e95D6tXnppNjcoimPmikCMkeQz5zIFu10lsAZn9a70/LIoH6eNGuQxt
 RuCUrF3EY4mSM1N9pOl9rk7jV7L2YjcxpujuA8FtchFGtgGjTMCm9xbXtTHkIsPT5aEA
 GXh0knjeyjlVMy+etIsaz99V+5hBnMalLeh60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736435706; x=1737040506;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mDqcuQTkVw0GrRm5j+QC8P+9PcAqQDeKip3w9wFb/kk=;
 b=iPowoTtSx9NgNbUBlE7lizWfV/0CVtKz0WRTtV0CAwO85n9vu648MfxdrQqczIYXzC
 Cb5TjmA389c36aYSosLgGln5sCnfNTqV4KhW0uqEZ79jhGlO/HvexM6GMECNi52RQWNz
 pB91RsUszaUh4DXbA2RJSguyuiq/OsDDfuLmnIX2vnZzt4Su6o9rK5jlCovdKpA54AKq
 rIKdkJLHIN8IhXWfo3KF6sjmf6WUai0yobNcmEyWg7nysy81ci/OtZ8W2wKi9TaHJqOt
 Ktvg4wWG4TQpAwC0II34eIMGcs/0cJauChMNt7l/xcsBo3O4USIZ0UEozjRQwVhsoXdZ
 0h9w==
X-Gm-Message-State: AOJu0Yyr+6fIznsmKf3cCQ6hXAj7hn5duX9zF3adgfKoK5iMKY6PIquM
 qEro2/T7vPq9GpgVjhhAUyRBTOk5UXlH91x4EgWB87MZgCuDJHo3D0ChCrP7vTaJVwMLSh4ZzC/
 dPluDb7sjdDpQRvzj6Sfqh//zwAqT5mHyuzPc
X-Gm-Gg: ASbGncvEEMR7HlzQ5VrXasqjR4kqwN2076725/I/yJw74UJ+8RMWcM1xVJv0C6E2E2g
 AKObj6bAOyfRjjY29a84fhvBYAOS2bI4+0rqNmCI=
X-Google-Smtp-Source: AGHT+IEwY8viBFaDwKx8NrqSF1uHS9wqPBVCgLoH688yGAphwjB4EiU1x6Df6FJlVj0kdSjX+AAzYv1dpLufJzgfsg8=
X-Received: by 2002:a17:90b:51c1:b0:2ee:f687:6acb with SMTP id
 98e67ed59e1d1-2f548f35587mr9898382a91.13.1736435706505; Thu, 09 Jan 2025
 07:15:06 -0800 (PST)
MIME-Version: 1.0
References: <20250106143229.3023771-1-sjg@chromium.org>
 <20250106143229.3023771-18-sjg@chromium.org>
 <20250108182528.GN3476@bill-the-cat>
 <CAFLszTh=HYTxwNSBOOmaiPpG+DO8tc52=XsQQiXAfMSpcwediA@mail.gmail.com>
 <20250109150954.GU3476@bill-the-cat>
In-Reply-To: <20250109150954.GU3476@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 9 Jan 2025 08:14:53 -0700
X-Gm-Features: AbW1kvZ-on0myYOidnLd4hramdslvPRokdIqdEO4n4jXrgcrLZ4mELCX4QRucU0
Message-ID: <CAFLszTg+pyMWMW-9rXe9D=siFpk1bbgTq1yk0g-+cms2aKnEuw@mail.gmail.com>
Subject: Re: [PATCH v2 17/33] boot: Update fit_image_get_emb_data to use abuf
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alexander Dahl <ada@thorsis.com>, 
 Alexander Kochetkov <al.kochet@gmail.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Devarsh Thakkar <devarsht@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Hugo Cornelis <hugo.cornelis@essensium.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Janne Grunau <j@jannau.net>, 
 Julien Masson <jmasson@baylibre.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Maxim Moskalets <maximmosk4@gmail.com>, Nikhil M Jain <n-jain1@ti.com>, 
 Paul-Erwan Rio <paulerwan.rio@gmail.com>, Raymond Mao <raymond.mao@linaro.org>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
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

On Thu, 9 Jan 2025 at 08:10, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Jan 09, 2025 at 05:36:03AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Wed, 8 Jan 2025 at 11:25, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Mon, Jan 06, 2025 at 07:32:13AM -0700, Simon Glass wrote:
> > >
> > > > This function uses separate arguments for data and size. Use the new
> > > > abuf instead, so that they are paired and in one place. In some cases it
> > > > also saves an argument, thus potentially reducing code size.
> > >
> > > This is one of the commits that globally increases size in both full
> > > U-Boot and SPL/etc.
> > >
> > > Is all of the "abuf" changes just a "tidy up" that increases the code a
> > > bit?
> >
> > Yes, a tidy-up which I hope will help overall. I have been thinking
> > for a while of how to avoid having addr/size and ptr/size passed
> > everywhere. For now abuf seems to provide some sort of solution.
> >
> > I see this:
> >
> > 18: boot: Update fit_image_get_emb_data to use abuf
> >    aarch64: (for 1/1 boards) all +4.0 bss -24.0 spl/u-boot-spl:all
> > +16.0 spl/u-boot-spl:text +16.0 text +28.0
> >
> > so growth on firefly-rk3399 but not with rk3288. I am not sure if the
> > growth will tail off as there are more users, though. We might even be
> > able to be more clever with static inlines.
>
> Yeah, lets not do this now then and worry about some "clean up" later
> when we can show that it does, or does not, improve size.

Oh.

> And there's
> something wrong with your numbers:
> 01: Fix neighbor discovery ethernet address saving
>    aarch64:  w+   firefly-rk3399
> +(firefly-rk3399) Image 'simple-bin' is missing external blobs and is non-functional: atf-bl31
> +(firefly-rk3399)
> +(firefly-rk3399) /binman/simple-bin/fit/images/@atf-SEQ/atf-bl31 (atf-bl31):
> +(firefly-rk3399)    See the documentation for your board. You may need to build ARM Trusted
> +(firefly-rk3399)    Firmware and build with BL31=/path/to/bl31.bin
> +(firefly-rk3399) Image 'simple-bin' is missing optional external blobs but is still functional: tee-os
> +(firefly-rk3399) /binman/simple-bin/fit/images/@tee-SEQ/tee-os (tee-os):
> +(firefly-rk3399)    See the documentation for your board. You may need to build Open Portable
> +(firefly-rk3399)    Trusted Execution Environment (OP-TEE) and build with TEE=/path/to/tee.bin
> +(firefly-rk3399) Some images are invalid
> 37: dm: core: Provide ofnode_find_subnode_unit()
>    aarch64: (for 1/1 boards) all +324.0 bss +32.0 spl/u-boot-spl:all +16.0 spl/u-boot-spl:text +16.0 text +292.0
>             firefly-rk3399 : all +324 bss +32 spl/u-boot-spl:all +16 spl/u-boot-spl:text +16 text +292
>                u-boot: add: 6/-1, grow: 4/-4 bytes: 516/-224 (292)
>                  function                                   old     new   delta
>                  ofnode_name_eq_unit                          -     160    +160
>                  ofnode_find_subnode_unit                     -     116    +116
>                  fit_image_get_data                          80     176     +96
>                  fit_image_get_emb_data                       -      84     +84
>                  ofnode_write_prop                          224     236     +12
>                  ofnode_add_subnode                         232     244     +12
>                  abuf_init_const                              -      12     +12
>                  abuf_init                                    -      12     +12
>                  abuf_addr                                    -       8      +8
>                  fit_image_print                            780     784      +4
>                  image_locate_script                        696     692      -4
>                  fit_image_load                            1584    1580      -4
>                  fit_image_verify                           176     164     -12
>                  ofnode_find_subnode                        140     116     -24
>                  fit_image_get_data_and_size                180       -    -180
>                spl-u-boot-spl: add: 3/-1, grow: 0/-1 bytes: 108/-92 (16)
>                  function                                   old     new   delta
>                  fit_image_get_emb_data                       -      84     +84
>                  abuf_init_const                              -      12     +12
>                  abuf_init                                    -      12     +12
>                  load_simple_fit                            580     568     -12
>                  fit_image_get_data                          80       -     -80

Yes, that's the whole series, so not related to this change.

 I elected to have two versions of ofnode_find_subnode() to avoid the
size growth in the previous version. But the cost is larger size
growth when OF_LIVE is used.

Without OF_LIVE, the size growth is tiny.

So...what to do?

Regards,
Simon
