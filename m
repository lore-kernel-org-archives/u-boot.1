Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BAB8C4167B
	for <u-boot@archiver.kernel.org>; Thu,  7 Dec 2023 20:53:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B73286308;
	Thu,  7 Dec 2023 21:53:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BGVWglgM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5523786940; Thu,  7 Dec 2023 21:53:15 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D700807AE
 for <u-boot@lists.denx.de>; Thu,  7 Dec 2023 21:53:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-9fa45e75ed9so157554966b.1
 for <u-boot@lists.denx.de>; Thu, 07 Dec 2023 12:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701982392; x=1702587192; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oWIflf5hcpue6wGtlwNE/HkT4tbMsQSgIfDnrjtjjfg=;
 b=BGVWglgM3qnsZ9jIo5VFjH8/1K06dI6CtHW7vO3jJQRU3/2HFL0I3MV7JqL4p6QC2b
 8OuzfHIUDDXlckN/JJSke8rZKpc+8UgTudNjqagkvD3jSz5Ad11RJcl+GzdWaZj0m4mO
 QzSWxVbPW+faEm+uCUBwHLUG3hkVZvSx4xIsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701982392; x=1702587192;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oWIflf5hcpue6wGtlwNE/HkT4tbMsQSgIfDnrjtjjfg=;
 b=UPesYFfJiY4MPzExD56CzL4+P9cMPWPvcRjOufW7UR4PoBlKZAA4928ntXMGXPDGlz
 C0BjPjkC2hRmdXi2+XIhCkt7CsRSLRnKueUVYmLs6RzK3CT85PrhPrFwSo4nqaUwHQ3t
 1ISbokDIBPukn/NS9XSwsJ39v2/T9gWHi8VR0JdRjHbOLHdBHY4OHZG2pV1250Jh72WA
 /ebGWSRJce5pDbttG9/2Kx51KSoAOWrD17jdws9dR2XRTF/3mNxn+VSqI42zz4ao7lr1
 /y2K8L3WCj5gJKdKG9xBtpeJuDbQyFAASYekc4aTBPpvtdPMWR7b/lTk30l+7AifoAUe
 H7pA==
X-Gm-Message-State: AOJu0YxDKcFrOQyDChMlEiYAqUjO6e9JA2YTMtKWHznG95gCFbBHzwHt
 ZiXIRLauXdO0jyRCea/UUHBV9X0VQRXOjOGDREKRYg==
X-Google-Smtp-Source: AGHT+IGlqecBeKpKJsPolkl+LHqMluq7H92QsuDLPCGLyyt/tYoOLIFC7+pQZSilRLUlakLEfiXMyZjPKdw0aG6O2m4=
X-Received: by 2002:a17:907:2948:b0:a19:a19a:eac0 with SMTP id
 et8-20020a170907294800b00a19a19aeac0mr1471204ejc.121.1701982392232; Thu, 07
 Dec 2023 12:53:12 -0800 (PST)
MIME-Version: 1.0
References: <20231202035511.487946-1-sjg@chromium.org>
 <20231202035511.487946-3-sjg@chromium.org>
 <20231203153401.GV8402@pendragon.ideasonboard.com>
 <20231207142723.GA3187877@google.com>
 <20231207143814.GD15521@pendragon.ideasonboard.com>
In-Reply-To: <20231207143814.GD15521@pendragon.ideasonboard.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 7 Dec 2023 13:52:53 -0700
Message-ID: <CAPnjgZ1q3yBeyYfjLumJ03HR7JM1xwN7sMbNJqfUWpsVxFTs4Q@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] arm64: boot: Support Flat Image Tree
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>, linux-arm-kernel@lists.infradead.org, 
 Masahiro Yamada <masahiroy@kernel.org>,
 Ahmad Fatoum <a.fatoum@pengutronix.de>, 
 U-Boot Mailing List <u-boot@lists.denx.de>, Nicolas Schier <nicolas@fjasle.eu>,
 Tom Rini <trini@konsulko.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Nathan Chancellor <nathan@kernel.org>, Nick Terrell <terrelln@fb.com>,
 Will Deacon <will@kernel.org>, 
 linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org, 
 linux-kernel@vger.kernel.org, workflows@vger.kernel.org
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

Hi,

On Thu, 7 Dec 2023 at 07:38, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Thu, Dec 07, 2023 at 10:27:23PM +0800, Chen-Yu Tsai wrote:
> > On Sun, Dec 03, 2023 at 05:34:01PM +0200, Laurent Pinchart wrote:
> > > Hi Simon,
> > >
> > > Thank you for the patch.
> > >
> > > On Fri, Dec 01, 2023 at 08:54:42PM -0700, Simon Glass wrote:
> > > > Add a script which produces a Flat Image Tree (FIT), a single file
> > > > containing the built kernel and associated devicetree files.
> > > > Compression defaults to gzip which gives a good balance of size and
> > > > performance.
> > > >
> > > > The files compress from about 86MB to 24MB using this approach.
> > > >
> > > > The FIT can be used by bootloaders which support it, such as U-Boot
> > > > and Linuxboot. It permits automatic selection of the correct
> > > > devicetree, matching the compatible string of the running board with
> > > > the closest compatible string in the FIT. There is no need for
> > > > filenames or other workarounds.
> > > >
> > > > Add a 'make image.fit' build target for arm64, as well. Use
> > > > FIT_COMPRESSION to select a different algorithm.
> > > >
> > > > The FIT can be examined using 'dumpimage -l'.
> > > >
> > > > This features requires pylibfdt (use 'pip install libfdt'). It also
> > > > requires compression utilities for the algorithm being used. Supported
> > > > compression options are the same as the Image.xxx files. For now there
> > > > is no way to change the compression other than by editing the rule for
> > > > $(obj)/image.fit
> > > >
> > > > While FIT supports a ramdisk / initrd, no attempt is made to support
> > > > this here, since it must be built separately from the Linux build.
> > >
> > > FIT images are very useful, so I think this is a very welcome addition
> > > to the kernel build system. It can get tricky though: given the
> > > versatile nature of FIT images, there can't be any
> > > one-size-fits-them-all solution to build them, and striking the right
> > > balance between what makes sense for the kernel and the features that
> > > users may request will probably lead to bikeshedding. As we all love
> > > bikeshedding, I thought I would start selfishly, with a personal use
> > > case :-) This isn't a yak-shaving request though, I don't see any reason
> > > to delay merging this series.
> > >
> > > Have you envisioned building FIT images with a subset of DTBs, or adding
> > > DTBOs ? Both would be fairly trivial extensions to this script by
> > > extending the supported command line arguments. It would perhaps be more
> > > difficult to integrate in the kernel build system though. This leads me
> > > to a second question: would you consider merging extensions to this
> > > script if they are not used by the kernel build system, but meant for
> > > users who manually invoke the script ? More generally, is the script
> >
> > We'd also be interested in some customization, though in a different way.
> > We imagine having a rule file that says X compatible string should map
> > to A base DTB, plus B and C DTBO for the configuration section. The base
> > DTB would carry all common elements of some device, while the DTBOs
> > carry all the possible second source components, like different display
> > panels or MIPI cameras for instance. This could drastically reduce the
> > size of FIT images in ChromeOS by deduplicating all the common stuff.
>
> Do you envision the "mapping" compatible string mapping to a config
> section in the FIT image, that would bundle the base DTB and the DTBOs ?
>
> > > meant to be used stand-alone as well, in which case its command line
> > > arguments need to remain backward-compatible, or do you see it as being
> > > internal to the kernel ?

It is great to see all this discussion! I did send a proposal to the
U-Boot ML about extensions but it was mixed up with other things, so
I'll start a new thread.

For now, I am really just waiting for this to be applied, before
talking too much about future possibilities.

Regards,
SImon
