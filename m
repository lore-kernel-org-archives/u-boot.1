Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B8BCC46CA3
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 04:25:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15976879DB;
	Thu, 14 Dec 2023 05:25:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gIShlWzc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9911F879CC; Thu, 14 Dec 2023 05:03:14 +0100 (CET)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F618879A1
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 05:03:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=wenst@chromium.org
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-50c0f13ea11so8919375e87.3
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 20:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702526591; x=1703131391; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1BVGmaHHT0VTxNDf7ANoSO4oiQpZnXTGuJuyRV1Z/eI=;
 b=gIShlWzcFmAB9mCxHiznhgj9D/vf6L3Ry2pyBwanYkgS02GINKK+swmw8uq3Cfitvr
 BjzCE/5+z8v3E8mz//ERzrG7G9LlhRGAUVwW7G3oH9aiT6WenbXu0C1FgnxMNI8AbcwU
 LzolAePVtfLV+RntkDAjaleRcoraJZkxl/2g4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702526591; x=1703131391;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1BVGmaHHT0VTxNDf7ANoSO4oiQpZnXTGuJuyRV1Z/eI=;
 b=DNUQJaifn8FBrFHIIslsrhr1utBtYOXUz+WasF1kAYTXOUqjDwlgloHciYyHlLGMyF
 WQMlyS1giCsJviDVzuIcRhUKSg0XcdOYOXd8DxvoxsS8LsoBznroXqRXDPKt9EDTaT7d
 HSyyWeREMklbZSY1UNmVD6dj59Cz1DwqyVezAZyczHUzmtp3GV2WdeGnXKUYbN/6/8R4
 f+aiC9BDOQ67NesH/YZxDzCJtqur1f068TPBIHQN44MqIO+IeISG+19+H7sqAw0uSjff
 vYwPcAVXJDuEZj9RBjh4Dh0fz1ZPKA7NuaymWAqhxV7OuQaOqId7s2La1h9EGnN1tKK5
 Nxfw==
X-Gm-Message-State: AOJu0Yw6tAWPr5Uv342nB+Jj419D3+o816uuqy+fxmcn/qS37WXgBVkI
 AiI+MWLQxcKRbuXRX66oZQnBjuDivc8wW1UX1P7dZg==
X-Google-Smtp-Source: AGHT+IGpnoN+ysm9cnTeiQyv3Oa45JaHPkpqumPIr4sCoWU/xTY31KZkmU3OY4UiPx8AToeHKTnCfcuuo2+B3LxIGFs=
X-Received: by 2002:a05:6512:3053:b0:50d:faa1:acce with SMTP id
 b19-20020a056512305300b0050dfaa1accemr3948920lfb.56.1702526591034; Wed, 13
 Dec 2023 20:03:11 -0800 (PST)
MIME-Version: 1.0
References: <20231202035511.487946-1-sjg@chromium.org>
 <20231202035511.487946-3-sjg@chromium.org>
 <20231203153401.GV8402@pendragon.ideasonboard.com>
 <20231207142723.GA3187877@google.com>
 <20231207143814.GD15521@pendragon.ideasonboard.com>
 <CAGXv+5Go_0pEVAOLQmRCc_a9-YUtZEmBfXtMuBupX_nb9iqwbw@mail.gmail.com>
 <20231209152946.GC13421@pendragon.ideasonboard.com>
 <CAMuHMdVMZs6mnwWBgFwktO=8o=QzROv60cfZe085MhD6HxQjpQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVMZs6mnwWBgFwktO=8o=QzROv60cfZe085MhD6HxQjpQ@mail.gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 14 Dec 2023 13:02:59 +0900
Message-ID: <CAGXv+5Est3FL-XcEL-vB-6zVNas0mqb2cNYa==Yb7W2SQU9xVQ@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] arm64: boot: Support Flat Image Tree
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Simon Glass <sjg@chromium.org>, 
 linux-arm-kernel@lists.infradead.org, Masahiro Yamada <masahiroy@kernel.org>, 
 Ahmad Fatoum <a.fatoum@pengutronix.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Nicolas Schier <nicolas@fjasle.eu>, Tom Rini <trini@konsulko.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Nathan Chancellor <nathan@kernel.org>, Nick Terrell <terrelln@fb.com>,
 Will Deacon <will@kernel.org>, 
 linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org, 
 linux-kernel@vger.kernel.org, workflows@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 14 Dec 2023 05:25:17 +0100
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

On Sun, Dec 10, 2023 at 1:31=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Laurent,
>
> On Sat, Dec 9, 2023 at 4:29=E2=80=AFPM Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
> > On Sat, Dec 09, 2023 at 10:13:59PM +0900, Chen-Yu Tsai wrote:
> > > On Thu, Dec 7, 2023 at 11:38=E2=80=AFPM Laurent Pinchart
> > > <laurent.pinchart@ideasonboard.com> wrote:
> > > > On Thu, Dec 07, 2023 at 10:27:23PM +0800, Chen-Yu Tsai wrote:
> > > > > On Sun, Dec 03, 2023 at 05:34:01PM +0200, Laurent Pinchart wrote:
> > > > > > On Fri, Dec 01, 2023 at 08:54:42PM -0700, Simon Glass wrote:
> > > > > > > Add a script which produces a Flat Image Tree (FIT), a single=
 file
> > > > > > > containing the built kernel and associated devicetree files.
> > > > > > > Compression defaults to gzip which gives a good balance of si=
ze and
> > > > > > > performance.
> > > > > > >
> > > > > > > The files compress from about 86MB to 24MB using this approac=
h.
> > > > > > >
> > > > > > > The FIT can be used by bootloaders which support it, such as =
U-Boot
> > > > > > > and Linuxboot. It permits automatic selection of the correct
> > > > > > > devicetree, matching the compatible string of the running boa=
rd with
> > > > > > > the closest compatible string in the FIT. There is no need fo=
r
> > > > > > > filenames or other workarounds.
> > > > > > >
> > > > > > > Add a 'make image.fit' build target for arm64, as well. Use
> > > > > > > FIT_COMPRESSION to select a different algorithm.
> > > > > > >
> > > > > > > The FIT can be examined using 'dumpimage -l'.
> > > > > > >
> > > > > > > This features requires pylibfdt (use 'pip install libfdt'). I=
t also
> > > > > > > requires compression utilities for the algorithm being used. =
Supported
> > > > > > > compression options are the same as the Image.xxx files. For =
now there
> > > > > > > is no way to change the compression other than by editing the=
 rule for
> > > > > > > $(obj)/image.fit
> > > > > > >
> > > > > > > While FIT supports a ramdisk / initrd, no attempt is made to =
support
> > > > > > > this here, since it must be built separately from the Linux b=
uild.
> > > > > >
> > > > > > FIT images are very useful, so I think this is a very welcome a=
ddition
> > > > > > to the kernel build system. It can get tricky though: given the
> > > > > > versatile nature of FIT images, there can't be any
> > > > > > one-size-fits-them-all solution to build them, and striking the=
 right
> > > > > > balance between what makes sense for the kernel and the feature=
s that
> > > > > > users may request will probably lead to bikeshedding. As we all=
 love
> > > > > > bikeshedding, I thought I would start selfishly, with a persona=
l use
> > > > > > case :-) This isn't a yak-shaving request though, I don't see a=
ny reason
> > > > > > to delay merging this series.
> > > > > >
> > > > > > Have you envisioned building FIT images with a subset of DTBs, =
or adding
> > > > > > DTBOs ? Both would be fairly trivial extensions to this script =
by
> > > > > > extending the supported command line arguments. It would perhap=
s be more
> > > > > > difficult to integrate in the kernel build system though. This =
leads me
> > > > > > to a second question: would you consider merging extensions to =
this
> > > > > > script if they are not used by the kernel build system, but mea=
nt for
> > > > > > users who manually invoke the script ? More generally, is the s=
cript
> > > > >
> > > > > We'd also be interested in some customization, though in a differ=
ent way.
> > > > > We imagine having a rule file that says X compatible string shoul=
d map
> > > > > to A base DTB, plus B and C DTBO for the configuration section. T=
he base
> > > > > DTB would carry all common elements of some device, while the DTB=
Os
> > > > > carry all the possible second source components, like different d=
isplay
> > > > > panels or MIPI cameras for instance. This could drastically reduc=
e the
> > > > > size of FIT images in ChromeOS by deduplicating all the common st=
uff.
> > > >
> > > > Do you envision the "mapping" compatible string mapping to a config
> > > > section in the FIT image, that would bundle the base DTB and the DT=
BOs ?
> > >
> > > That's exactly the idea. The mapping compatible string could be untie=
d
> > > from the base board's compatible string if needed (which we probably =
do).
> > >
> > > So something like:
> > >
> > > config {
> > >     config-1 {
> > >         compatible =3D "google,krane-sku0";
> > >         fdt =3D "krane-baseboard", "krane-sku0-overlay";
> > >     };
> > > };
> > >
> > > With "krane-sku0-overlay" being an overlay that holds the differences
> > > between the SKUs, in this case the display panel and MIPI camera (not
> > > upstreamed) that applies to SKU0 in particular.
> >
> > The kernel DT makefiles already contain information on what overlays to
> > apply to what base boards, in order to test the overlays and produce
> > "full" DTBs. Maybe that information could be leveraged to create the
> > configurations in the FIT image ?
>
> Although the "full" DTBs created may only be a subset of all possible
> combinations (I believe Rob just started with creating one "full" DTB
> for each overlay, cfr. the additions I made in commit a09c3e105a208580
> ("arm64: dts: renesas: Apply overlays to base dtbs")), that could
> definitely be a start.
>
> Now, since the kernel build system already creates "full" DTBs, does
> that mean that all of the base DTBs, overlays, and "full" DTBs will
> end up in the FIT image?

I suppose we could add an option to the packing tool to be able to _not_
add the "full" DTBs if they can also be assembled with a base DTB and
overlays. Think of it as a firmware compatibility option: if the firmware
supports overlays, then you almost always want the deconstructed parts,
not the fully assembled ones. Vice versa.

If we don't we could end up with two configurations that have the same
compatible string?


ChenYu


> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds
