Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67EA7E7719C
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 13:39:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF812801F5;
	Fri, 10 Jan 2025 14:39:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="n46ck6Zi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EF43805E9; Fri, 10 Jan 2025 14:39:36 +0100 (CET)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D927800D0
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 14:39:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2eec9b3a1bbso2810619a91.3
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 05:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736516373; x=1737121173; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Mfi5AZwTv8pUjgS7DfYJPfiABHg40kk9Qx2ejPAppEo=;
 b=n46ck6ZihJ+QLVmaFK3I2MmhYY0cXg/OIddQBcVSiXoeIUpZ4jESTIBUvHmCb32eVL
 k4s7nsHyJfxjV9C6Y+axKnbU8AL+5htJEX91bhaEJZv+vog5vtV5/L7CWJIfGXJ50Wle
 lOmt3WLecCRXUoBqiWhQssDkJDzijxhTy9ubo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736516373; x=1737121173;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Mfi5AZwTv8pUjgS7DfYJPfiABHg40kk9Qx2ejPAppEo=;
 b=hMBMiXhAykOGB+lseMEJP8ULmsPSWNGW36dCOW7kVX+zcvUPIeEab3+Foroz2U4s9z
 nPc1gofZn9jLKH9MQaFRfv3wzTLulsPi6EXIqLEwMTvQ2EFSFMqpsd8RKbNju97Pmhnr
 1sTEgwB+dPPWSVyn0mcWy/P5rWQkSU1vc9hRb2bh86uRA5GgYlM3QoI3BUfs9LxHhq86
 FdV2ybmKQA9Thv0KtNsanglX5orVkdDmhTuViindvyCkmCnmorWwoGBgXqaxsB/4FVK+
 WfRIP2IIdmYKmHhtRScI8eyqD95Sbk1wU05jnk7smerEVUkDhVSz9Gn6vF3NTDHiludH
 Lyaw==
X-Gm-Message-State: AOJu0YxkNJsFMttireGLZNh2I13ALfF9vm4aOhH9vWOJ6TIik+EVQ4Xn
 tsd3uXEjEBxYj34C1nw4KhkYjNWTbx7Sw5Ul6UBiamOSOwylBohaEhnZSgVp97Jq5uvckra2060
 aFeB0oc6l45zRd3Aei/1gs/rC7rMSW4BT5hjz
X-Gm-Gg: ASbGncv9HQrUwQXqpS/+xW7vDTb8kHaaSH92fXukbXmwMYdzvHKjdoRAJt1B/T1vE3d
 FwP8ElARGuPxtIY9OWc0hXGP18ofXKBpRbjdwKuM=
X-Google-Smtp-Source: AGHT+IERgxOnIQhIl2VbHVhON/DsdcjUAI32NW87TT+s/5yeBqQYjUBUamOlAyI61sU39hNt30LGANDP+hGLuX9pQc4=
X-Received: by 2002:a17:90b:51c5:b0:2f4:423a:8fb2 with SMTP id
 98e67ed59e1d1-2f548eca27emr15980931a91.20.1736516372704; Fri, 10 Jan 2025
 05:39:32 -0800 (PST)
MIME-Version: 1.0
References: <20250106143229.3023771-1-sjg@chromium.org>
 <20250106143229.3023771-18-sjg@chromium.org>
 <20250108182528.GN3476@bill-the-cat>
 <CAFLszTh=HYTxwNSBOOmaiPpG+DO8tc52=XsQQiXAfMSpcwediA@mail.gmail.com>
 <20250109150954.GU3476@bill-the-cat>
 <CAFLszTg+pyMWMW-9rXe9D=siFpk1bbgTq1yk0g-+cms2aKnEuw@mail.gmail.com>
 <20250109180817.GC3476@bill-the-cat>
In-Reply-To: <20250109180817.GC3476@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 10 Jan 2025 06:39:11 -0700
X-Gm-Features: AbW1kvaPJd_fAQQh2SVt43ymXeI9OdlQdB71LkF0LkcAxXgeDi_wqlypjiivuCQ
Message-ID: <CAFLszThn-XcHruFe60TH8FnsKsH08NFEco2zt+9JBHkneQgo0Q@mail.gmail.com>
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

On Thu, 9 Jan 2025 at 11:08, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Jan 09, 2025 at 08:14:53AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Thu, 9 Jan 2025 at 08:10, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, Jan 09, 2025 at 05:36:03AM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Wed, 8 Jan 2025 at 11:25, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Mon, Jan 06, 2025 at 07:32:13AM -0700, Simon Glass wrote:
> > > > >
> > > > > > This function uses separate arguments for data and size. Use the new
> > > > > > abuf instead, so that they are paired and in one place. In some cases it
> > > > > > also saves an argument, thus potentially reducing code size.
> > > > >
> > > > > This is one of the commits that globally increases size in both full
> > > > > U-Boot and SPL/etc.
> > > > >
> > > > > Is all of the "abuf" changes just a "tidy up" that increases the code a
> > > > > bit?
> > > >
> > > > Yes, a tidy-up which I hope will help overall. I have been thinking
> > > > for a while of how to avoid having addr/size and ptr/size passed
> > > > everywhere. For now abuf seems to provide some sort of solution.
> > > >
> > > > I see this:
> > > >
> > > > 18: boot: Update fit_image_get_emb_data to use abuf
> > > >    aarch64: (for 1/1 boards) all +4.0 bss -24.0 spl/u-boot-spl:all
> > > > +16.0 spl/u-boot-spl:text +16.0 text +28.0
> > > >
> > > > so growth on firefly-rk3399 but not with rk3288. I am not sure if the
> > > > growth will tail off as there are more users, though. We might even be
> > > > able to be more clever with static inlines.
> > >
> > > Yeah, lets not do this now then and worry about some "clean up" later
> > > when we can show that it does, or does not, improve size.
> >
> > Oh.
> >
> > > And there's
> > > something wrong with your numbers:
> > > 01: Fix neighbor discovery ethernet address saving
> > >    aarch64:  w+   firefly-rk3399
> > > +(firefly-rk3399) Image 'simple-bin' is missing external blobs and is non-functional: atf-bl31
> > > +(firefly-rk3399)
> > > +(firefly-rk3399) /binman/simple-bin/fit/images/@atf-SEQ/atf-bl31 (atf-bl31):
> > > +(firefly-rk3399)    See the documentation for your board. You may need to build ARM Trusted
> > > +(firefly-rk3399)    Firmware and build with BL31=/path/to/bl31.bin
> > > +(firefly-rk3399) Image 'simple-bin' is missing optional external blobs but is still functional: tee-os
> > > +(firefly-rk3399) /binman/simple-bin/fit/images/@tee-SEQ/tee-os (tee-os):
> > > +(firefly-rk3399)    See the documentation for your board. You may need to build Open Portable
> > > +(firefly-rk3399)    Trusted Execution Environment (OP-TEE) and build with TEE=/path/to/tee.bin
> > > +(firefly-rk3399) Some images are invalid
> > > 37: dm: core: Provide ofnode_find_subnode_unit()
> > >    aarch64: (for 1/1 boards) all +324.0 bss +32.0 spl/u-boot-spl:all +16.0 spl/u-boot-spl:text +16.0 text +292.0
> > >             firefly-rk3399 : all +324 bss +32 spl/u-boot-spl:all +16 spl/u-boot-spl:text +16 text +292
> > >                u-boot: add: 6/-1, grow: 4/-4 bytes: 516/-224 (292)
> > >                  function                                   old     new   delta
> > >                  ofnode_name_eq_unit                          -     160    +160
> > >                  ofnode_find_subnode_unit                     -     116    +116
> > >                  fit_image_get_data                          80     176     +96
> > >                  fit_image_get_emb_data                       -      84     +84
> > >                  ofnode_write_prop                          224     236     +12
> > >                  ofnode_add_subnode                         232     244     +12
> > >                  abuf_init_const                              -      12     +12
> > >                  abuf_init                                    -      12     +12
> > >                  abuf_addr                                    -       8      +8
> > >                  fit_image_print                            780     784      +4
> > >                  image_locate_script                        696     692      -4
> > >                  fit_image_load                            1584    1580      -4
> > >                  fit_image_verify                           176     164     -12
> > >                  ofnode_find_subnode                        140     116     -24
> > >                  fit_image_get_data_and_size                180       -    -180
> > >                spl-u-boot-spl: add: 3/-1, grow: 0/-1 bytes: 108/-92 (16)
> > >                  function                                   old     new   delta
> > >                  fit_image_get_emb_data                       -      84     +84
> > >                  abuf_init_const                              -      12     +12
> > >                  abuf_init                                    -      12     +12
> > >                  load_simple_fit                            580     568     -12
> > >                  fit_image_get_data                          80       -     -80
> >
> > Yes, that's the whole series, so not related to this change.
>
> Yes, that's the whole series including this change, so it's related to
> this change.

Right, but it is due to ofnode_find_subnode(), etc.

>
> >  I elected to have two versions of ofnode_find_subnode() to avoid the
> > size growth in the previous version. But the cost is larger size
> > growth when OF_LIVE is used.
> >
> > Without OF_LIVE, the size growth is tiny.
>
> And even worse in SPL, somehow. But you want more OF_LIVE users, not
> less, yes?

Well, OF_LIVE is always quite a bit larger, at least at the moment. It
has both Linux's of_access stuff and libfdt. It's not OF_LIVE I am
bothered about, but I do want people using ofnode. Unfortunately
people still send patches which use libfdt directly.

>
> > So...what to do?
>
> Well, if you drop the abuf changes for now, SPL won't change at all for
> most platforms and that'll be an improvement.

Yes, I'll look at that. This is one of many examples where I have a
problem and realise that we need a nicer way of dealing with it, then
implement it in the series, but then the series loses focus. So then I
take it out again, then forget about it until next time, but I never
actually make the change.

>
> And I'm going to keep complaining about size growth here because a
> non-trivial subset of users just wants things to boot quickly and be
> small.

Yes, you won't get any complaints from me on that. I did propose some
automated checking a few years back, but it never went anywhere.

Regards,
SImon
