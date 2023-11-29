Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6C9CC46CA3
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 19:03:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1748C877A8;
	Wed, 29 Nov 2023 20:03:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SlUi2FGm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74EAF877BA; Wed, 29 Nov 2023 20:03:11 +0100 (CET)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7166B87782
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 20:03:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2c88b7e69dfso2106351fa.0
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 11:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701284589; x=1701889389; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eqFuufKBS903oC+09D1OgJlE8YGZvK320Etdppu6ukQ=;
 b=SlUi2FGmmWRhVVcmZVNVmYTo41c2ClgqYStMIEaSUl+E+PPhfkaj0cOA9WbbS86Mmn
 qWy0v8dkhZfRDC/NFSyBMFPcbUKMfLcULxFGpUsbJcU0MXy3JHZU8woTjb2t+LXW/Rgk
 JsKHdDm2rn2jAE5iuLQznp4mu8QkjNicFmAus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701284589; x=1701889389;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eqFuufKBS903oC+09D1OgJlE8YGZvK320Etdppu6ukQ=;
 b=egya1e03RFELrnwCmh3cZkw6nYLf7QQ8LKFxe5ulr5Ia5djZw3Pn1ZA3283gu+L1fl
 s34GJaJEMPdnVGgCyiXhDT5X95Epc5qzFg9Xew2NVQO3R7qXhzv6DMatOMaLemp7QbXO
 NODS8UreI1ReInbIpFSlLRAEsOhwCEvMmMID8T35f6ElU8zbGq3t4V3MkLkWeYuPNdDp
 WjLVLbflIJGrBLc5Pc072r+KUo7hKljhVr1/LDgrxlG1hv47i2FDtx57sobJ8ANgRoWi
 CT/pEcm7YkJuAy3cb3HV6lmzbPRYI4VhvnFoGWmVuU5SRzM0YiuBb4R4m0KxyHr8xWn3
 Dh6Q==
X-Gm-Message-State: AOJu0Yy3FbNTafEfBHPEXrgyCTNJE2HGUYtUUYxCzmItQNuX5kPuQF1Y
 muogQb2PJcWAQ+gcMTx1dPqfz4VJ+1zBpZNY/u914Q==
X-Google-Smtp-Source: AGHT+IFVXUrZjpsbk8/VnzdMqcgpeht/p4RMDUy/Er0zzFvjxFoqfqyI6+x7cYid7etTRdTN+BrdV820tcBQ82gj6bM=
X-Received: by 2002:a05:6512:2343:b0:509:455c:9e3d with SMTP id
 p3-20020a056512234300b00509455c9e3dmr12103134lfu.18.1701284588464; Wed, 29
 Nov 2023 11:03:08 -0800 (PST)
MIME-Version: 1.0
References: <20231129172200.430674-1-sjg@chromium.org>
 <20231129172200.430674-3-sjg@chromium.org>
 <30f32467-51ea-47de-a272-38e074f4060b@pengutronix.de>
In-Reply-To: <30f32467-51ea-47de-a272-38e074f4060b@pengutronix.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Nov 2023 12:02:57 -0700
Message-ID: <CAPnjgZ25xoXsi74XYY0E8ucQiowQqPdZgUHrfVNAYWKZEYODHg@mail.gmail.com>
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

On Wed, 29 Nov 2023 at 11:59, Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>
> Hi,
>
> a few more comments after decompiling the FIT image:
>
> On 29.11.23 18:21, Simon Glass wrote:
> > +    with fsw.add_node('kernel'):
> > +        fsw.property_string('description', args.name)
> > +        fsw.property_string('type', 'kernel_noload')
>
> The specification only says no loading done, but doesn't explain what it
> means for a bootloader to _not_ load an image. Looking into the U-Boot commit
> b9b50e89d317 ("image: Implement IH_TYPE_KERNEL_NOLOAD") that introduces this,
> apparently no loading means ignoring load and entry address?
>
> I presume missing load and entry is something older U-Boot versions
> were unhappy about? Please let me know if the semantics are as I understood,
> so I can prepare a barebox patch supporting it.

Oh, see my previous email.

>
> > +        fsw.property_string('arch', args.arch)
> > +        fsw.property_string('os', args.os)
> > +        fsw.property_string('compression', args.compress)
> > +        fsw.property('data', data)
> > +        fsw.property_u32('load', 0)
> > +        fsw.property_u32('entry', 0)
> > +
> > +
> > +def finish_fit(fsw, entries):
> > +    """Finish the FIT ready for use
> > +
> > +    Writes the /configurations node and subnodes
> > +
> > +    Args:
> > +        fsw (libfdt.FdtSw): Object to use for writing
> > +        entries (list of tuple): List of configurations:
> > +            str: Description of model
> > +            str: Compatible stringlist
> > +    """
> > +    fsw.end_node()
> > +    seq = 0
> > +    with fsw.add_node('configurations'):
> > +        for model, compat in entries:
> > +            seq += 1
> > +            with fsw.add_node(f'conf-{seq}'):
> > +                fsw.property('compatible', bytes(compat))
>
> The specification says that this is the root U-Boot compatible,
> which I presume to mean the top-level compatible, which makes sense to me.
>
> The code here though adds all compatible strings from the device tree though,
> is this intended?

Yes, since it saves needing to read in each DT just to get the
compatible stringlist.

>
> > +        fsw.property_string('description', model)
> > +        fsw.property_string('type', 'flat_dt')
> > +        fsw.property_string('arch', arch)
> > +        fsw.property_string('compression', compress)
> > +        fsw.property('compatible', bytes(compat))
>
> I think I've never seen a compatible for a fdt node before.
> What use does this serve?

It indicates the machine that the DT is for.

Regards,
Simon
