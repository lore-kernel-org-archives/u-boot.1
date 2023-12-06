Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19DEDC4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 03:55:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 865F387683;
	Wed,  6 Dec 2023 04:55:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="liVexwjv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E223C8753E; Wed,  6 Dec 2023 04:55:03 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9253487654
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 04:55:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-5d3644ca426so64624707b3.1
 for <u-boot@lists.denx.de>; Tue, 05 Dec 2023 19:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701834900; x=1702439700; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BsR8qY+uS6/BsLD1U3jPPzDAagYHPNv5M9ReQzqjMkA=;
 b=liVexwjvfOxLlwY3iFgYrTOFZP0sAarnNVDXo3DC9QE3C9E4wOMdLbLym67X3B5tFl
 Zy2SGzEhyWXqfAiMzPPecwuDViBNlGwvDaIRFCph9i42T3VU5oxAICUJZaz5cUiEn1kJ
 XC374tJbTf/v8W3V+Q9yVXZT9u+SjeamNCxqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701834900; x=1702439700;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BsR8qY+uS6/BsLD1U3jPPzDAagYHPNv5M9ReQzqjMkA=;
 b=fGd+ghW4AspDSB332A4IeJFcjuFcutU8aL5KsJG5tI1cXRlc3m3CRo//c6NafqnhE2
 5dPLkUgoqFLL2bSp42+9SwYjSdjSPBAiV5tA2XR8C9SwvPX0x7Rs2qR2d7Y9K6b0GvD4
 0YQ50x+i++kRHMq8GZ0FHVH8+xeLepJQ+Y9o6yKyEbcCsf7yyBzTQ7g4AK466G1UjWpY
 93384DY8HNcSPn0VcJjEoz3ElLis7oxDZvQlKJSO4wMyRHp1nu81jIHC2FuL9nZvnZF2
 3KVxLan6o5kDVLHCKzYqLRYeuyLNyKsryC7AFL6ZC0LUG+CVcj/ligxM0rLezjSvQSL7
 HpiA==
X-Gm-Message-State: AOJu0Yzi1jWj2shuuImAJ4EtlI0fO8+QOChrBKZCW0vuHrHoj2NtE4Oh
 Laoy/rEHgunvhoHFEvhRwmFAC6SprHCUvZIXpgFx3a+CnKDK0h6qCReMRg==
X-Google-Smtp-Source: AGHT+IHoRbTJaveVc4lI5CNcK45wkIN9hGVufXmpLxm2ne2EuM6HpHaABsrXS8hPPj5d6lQhPotGKPmzPUEdXOur9Ro=
X-Received: by 2002:a81:6dce:0:b0:5d7:3104:5649 with SMTP id
 i197-20020a816dce000000b005d731045649mr174139ywc.3.1701834900083; Tue, 05 Dec
 2023 19:55:00 -0800 (PST)
MIME-Version: 1.0
References: <20231202035511.487946-1-sjg@chromium.org>
 <20231202035511.487946-3-sjg@chromium.org>
 <92a3e3b4-6f4d-4ca4-947f-db905f328d4c@pengutronix.de>
In-Reply-To: <92a3e3b4-6f4d-4ca4-947f-db905f328d4c@pengutronix.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 5 Dec 2023 20:54:41 -0700
Message-ID: <CAPnjgZ3QZh3+2PtmSvje=KAw1n1o_jmhgC1ZnhM9JBoEjLG+fQ@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] arm64: boot: Support Flat Image Tree
To: Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, 
 Masahiro Yamada <masahiroy@kernel.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Nicolas Schier <nicolas@fjasle.eu>, Tom Rini <trini@konsulko.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Nathan Chancellor <nathan@kernel.org>, Nick Terrell <terrelln@fb.com>,
 Will Deacon <will@kernel.org>, 
 linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org, 
 linux-kernel@vger.kernel.org, workflows@vger.kernel.org, 
 Pengutronix Kernel Team <kernel@pengutronix.de>
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

On Tue, 5 Dec 2023 at 04:48, Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>
> Hello Simon,
>
> On 02.12.23 04:54, Simon Glass wrote:
> > Add a script which produces a Flat Image Tree (FIT), a single file
> > containing the built kernel and associated devicetree files.
> > Compression defaults to gzip which gives a good balance of size and
> > performance.
> >
> > The files compress from about 86MB to 24MB using this approach.
> >
> > The FIT can be used by bootloaders which support it, such as U-Boot
> > and Linuxboot. It permits automatic selection of the correct
> > devicetree, matching the compatible string of the running board with
> > the closest compatible string in the FIT. There is no need for
> > filenames or other workarounds.
> >
> > Add a 'make image.fit' build target for arm64, as well. Use
> > FIT_COMPRESSION to select a different algorithm.
> >
> > The FIT can be examined using 'dumpimage -l'.
> >
> > This features requires pylibfdt (use 'pip install libfdt'). It also
> > requires compression utilities for the algorithm being used. Supported
> > compression options are the same as the Image.xxx files. For now there
> > is no way to change the compression other than by editing the rule for
> > $(obj)/image.fit
> >
> > While FIT supports a ramdisk / initrd, no attempt is made to support
> > this here, since it must be built separately from the Linux build.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>
> kernel_noload support is now in barebox next branch and I tested this
> series against it:
>
> Tested-by: Ahmad Fatoum <a.fatoum@pengutronix.de> # barebox
>

OK great thank you.

> > +"""Build a FIT containing a lot of devicetree files
> > +
> > +Usage:
> > +    make_fit.py -A arm64 -n 'Linux-6.6' -O linux
> > +        -f arch/arm64/boot/image.fit -k /tmp/kern/arch/arm64/boot/image.itk
> > +        /tmp/kern/arch/arm64/boot/dts/ -E -c gzip
> > +
> > +Creates a FIT containing the supplied kernel and a directory containing the
> > +devicetree files.
> > +
> > +Use -E to generate an external FIT (where the data is placed after the
> > +FIT data structure). This allows parsing of the data without loading
> > +the entire FIT.
> > +
> > +Use -c to compress the data, using bzip2, gzip, lz4, lzma, lzo and
> > +zstd algorithms.
> > +
> > +The resulting FIT can be booted by bootloaders which support FIT, such
> > +as U-Boot, Linuxboot, Tianocore, etc.
>
> Feel free to add barebox to the list. Did you check whether Linuxboot and
> Tianocore support kernel_noload?

Only what I was told by people in those projects. They may not even
look at the load address, but I am not an expert on that.

>
> > +        fsw.property_u32('load', 0)
> > +        fsw.property_u32('entry', 0)
>
> I still think load and entry dummy values are confusing and should be dropped.

This is what the spec requires at present. But I agree we should
change it. I will dig into that at some point to see what is needed.

>
> > +    with fsw.add_node(f'fdt-{seq}'):
> > +        # Get the compatible / model information
> > +        with open(fname, 'rb') as inf:
> > +            data = inf.read()
> > +        fdt = libfdt.FdtRo(data)
> > +        model = fdt.getprop(0, 'model').as_str()
> > +        compat = fdt.getprop(0, 'compatible')
> > +
> > +        fsw.property_string('description', model)
> > +        fsw.property_string('type', 'flat_dt')
> > +        fsw.property_string('arch', arch)
> > +        fsw.property_string('compression', compress)
> > +        fsw.property('compatible', bytes(compat))
> > +
> > +        with open(fname, 'rb') as inf:
> > +            compressed = compress_data(inf, compress)
> > +        fsw.property('data', compressed)
> > +    return model, compat
>
> After Doug's elaboration, extracting multiple compatibles is fine by me.

OK good.

Regards,
Simon
