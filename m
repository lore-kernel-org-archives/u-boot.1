Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4F38C07E97
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 19:27:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FC708749C;
	Wed, 29 Nov 2023 20:27:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BUhNG0ZJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B545A87626; Wed, 29 Nov 2023 20:27:53 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25CB5870AB
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 20:27:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-9fa45e75ed9so17731666b.1
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 11:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701286070; x=1701890870; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6gR6QlSoTlyq04eRwNKCnLLqDlXv6VkMGmXKmkbAaQ0=;
 b=BUhNG0ZJRgmm1Df+siHM08CUDcKQXSjoKjAE+JKBDGNVvMwYXO8VqR53Urt+JGP2KW
 PfIZNZ9IQvBBWWEBoIKBb83Gsu11ISsfZBcVL4l5M+1eOyw7F2ovuzHzlbwenCJePzVS
 WNwMpSAXO2yur6TrUL2FPNUd7BAZKVf/zdFWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701286070; x=1701890870;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6gR6QlSoTlyq04eRwNKCnLLqDlXv6VkMGmXKmkbAaQ0=;
 b=Ine2Hi9ZCdXSa+O72GpPFg9/+fDqtRGD8B/lP9kjiFhurRgQ9P2Y/wctDhm2q2VByL
 nbeOScH69lTZzF/2xRitdp6sLF+c5K22BPZ1zMhQb8aEdDiD+2OEd17mwX0dkVtoU1+m
 oeHS5hltWpCa4k3AAJo1BBW54ZFyTD3upZ8Eb4xoLX4yCFz82pA4/hVDdazW7sTqvblv
 U0CJzMjwhC+LhyXSYgGCVIAqaSA0gcM4V/tCQFxSKw2o4K01wzQSUlWE9n5f9b+rgHGW
 0gtaRrOHtzYxvVGWS2R0RvU06aoJHzicdD6ewgZlZNlSJFaRCdrYyLv+wZ95rLKYXvFr
 lzfQ==
X-Gm-Message-State: AOJu0YypFL+ydGNl/OpOa33iG2DC7HIMIC9YtuhElLne6ElYv3c2dXEN
 3J8+awarkZji0G15+BG5Q7qM/mxHwperYlnK4rnSIw==
X-Google-Smtp-Source: AGHT+IFHd0lnsDfy+Z0LdFjR7oopIOyEOsVSQwIRDwzAaCAHJiPxmbCa0ilD2wIXfA2WW2IAWhTwgbrifbGP3/TbFI4=
X-Received: by 2002:a17:906:ccc5:b0:a11:d323:c1bc with SMTP id
 ot5-20020a170906ccc500b00a11d323c1bcmr5061259ejb.19.1701286070318; Wed, 29
 Nov 2023 11:27:50 -0800 (PST)
MIME-Version: 1.0
References: <20231129172200.430674-1-sjg@chromium.org>
 <20231129172200.430674-3-sjg@chromium.org>
 <30f32467-51ea-47de-a272-38e074f4060b@pengutronix.de>
 <CAPnjgZ25xoXsi74XYY0E8ucQiowQqPdZgUHrfVNAYWKZEYODHg@mail.gmail.com>
 <875f0dbc-1d78-4901-91b2-6ad152bcea5a@pengutronix.de>
In-Reply-To: <875f0dbc-1d78-4901-91b2-6ad152bcea5a@pengutronix.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Nov 2023 12:27:38 -0700
Message-ID: <CAPnjgZ0UCkm5QCx+JXe1ggSshozPnOLB6cN=UoJyMn6S4wfFkg@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] arm64: boot: Support Flat Image Tree
To: Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, 
 Masahiro Yamada <masahiroy@kernel.org>, Tom Rini <trini@konsulko.com>, 
 lkml <linux-kernel@vger.kernel.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Terrell <terrelln@fb.com>, Nicolas Schier <nicolas@fjasle.eu>,
 Will Deacon <will@kernel.org>, 
 linux-kbuild@vger.kernel.org, Pengutronix Kernel Team <kernel@pengutronix.de>
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

Hi Ahmad,

On Wed, 29 Nov 2023 at 12:15, Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>
> Hello Simon,
>
> On 29.11.23 20:02, Simon Glass wrote:
> > Hi Ahmad,
> >
> > On Wed, 29 Nov 2023 at 11:59, Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
> >>
> >> Hi,
> >>
> >> a few more comments after decompiling the FIT image:
> >>
> >> On 29.11.23 18:21, Simon Glass wrote:
> >>> +    with fsw.add_node('kernel'):
> >>> +        fsw.property_string('description', args.name)
> >>> +        fsw.property_string('type', 'kernel_noload')
> >>
> >> The specification only says no loading done, but doesn't explain what it
> >> means for a bootloader to _not_ load an image. Looking into the U-Boot commit
> >> b9b50e89d317 ("image: Implement IH_TYPE_KERNEL_NOLOAD") that introduces this,
> >> apparently no loading means ignoring load and entry address?
> >>
> >> I presume missing load and entry is something older U-Boot versions
> >> were unhappy about? Please let me know if the semantics are as I understood,
> >> so I can prepare a barebox patch supporting it.
> >
> > Oh, see my previous email.
>
> Thanks.
>
> >
> >>
> >>> +        fsw.property_string('arch', args.arch)
> >>> +        fsw.property_string('os', args.os)
> >>> +        fsw.property_string('compression', args.compress)
> >>> +        fsw.property('data', data)
> >>> +        fsw.property_u32('load', 0)
> >>> +        fsw.property_u32('entry', 0)
> >>> +
> >>> +
> >>> +def finish_fit(fsw, entries):
> >>> +    """Finish the FIT ready for use
> >>> +
> >>> +    Writes the /configurations node and subnodes
> >>> +
> >>> +    Args:
> >>> +        fsw (libfdt.FdtSw): Object to use for writing
> >>> +        entries (list of tuple): List of configurations:
> >>> +            str: Description of model
> >>> +            str: Compatible stringlist
> >>> +    """
> >>> +    fsw.end_node()
> >>> +    seq = 0
> >>> +    with fsw.add_node('configurations'):
> >>> +        for model, compat in entries:
> >>> +            seq += 1
> >>> +            with fsw.add_node(f'conf-{seq}'):
> >>> +                fsw.property('compatible', bytes(compat))
> >>
> >> The specification says that this is the root U-Boot compatible,
> >> which I presume to mean the top-level compatible, which makes sense to me.
> >>
> >> The code here though adds all compatible strings from the device tree though,
> >> is this intended?
> >
> > Yes, since it saves needing to read in each DT just to get the
> > compatible stringlist.
>
> The spec reads as if only one string (root) is supposed to be in the list.
> The script adds all compatibles though. This is not really useful as a bootloader
> that's compatible with e.g. fsl,imx8mm would just take the first device tree
> with that SoC, which is most likely to be wrong. It would be better to just
> specify the top-level compatible, so the bootloader fails instead of taking
> the first DT it finds.

We do need to have a list, since we have to support different board revs, etc.

>
> >>> +        fsw.property_string('description', model)
> >>> +        fsw.property_string('type', 'flat_dt')
> >>> +        fsw.property_string('arch', arch)
> >>> +        fsw.property_string('compression', compress)
> >>> +        fsw.property('compatible', bytes(compat))
> >>
> >> I think I've never seen a compatible for a fdt node before.
> >> What use does this serve?
> >
> > It indicates the machine that the DT is for.
>
> Who makes use of this information?

U-Boot uses it, I believe. There is an optimisation to use this
instead of reading the DT itself.

Regards,
Simon
