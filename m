Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33D4CC4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 13:58:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 437FC8759F;
	Sat,  9 Dec 2023 14:58:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YGooVxiR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 283C787128; Sat,  9 Dec 2023 14:14:15 +0100 (CET)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1328B86F87
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 14:14:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=wenst@chromium.org
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2c9f4bb2e5eso39873281fa.1
 for <u-boot@lists.denx.de>; Sat, 09 Dec 2023 05:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702127651; x=1702732451; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yAnV5/VTJKO+oXGb78o4eRSh3GZ7EBZgVLaL6KtYl8o=;
 b=YGooVxiRzre4dG43geDSekw5+OF5jOohJhbw0ze9r9TRketbDdxowcISrE6JgRfxCv
 FUjZW8QIJjTnGUEJqhw6GGC1vriVp7kNhRX1nUSnxyKhmix7/2adzlW8vSqVcArQFtHu
 KeLeQawAxiCMWAHJahDhjq6XsSgzaMtrpTW04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702127651; x=1702732451;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yAnV5/VTJKO+oXGb78o4eRSh3GZ7EBZgVLaL6KtYl8o=;
 b=PGJB1JxmReSX77woDjZ/yE3Uzb5XxLbk//wj+EMYl1kvacWvuOoZdlMoiRTcLT0g7b
 QgbjzpwP6te5i6Ol2JAROjQajLb2YU0dq9kJpMcCopDTqy29GFafijSscPYCgajIAs4F
 GV9ToybwNgVQYBHSRtYRS94LDEmFf4CT2AchCBPsxMeLoMHQLRTPo/jNxPouArmdJyqF
 0M+aW5egmrOb+t8tGjascNCwlbPAY7zuVxIvJeqJGgeiqwbd4M34j/tb4ipCyp5E5KKd
 wkWEY2aDvKzdl4/hwVhZZSmbQOxhFcXpaPE30cII17iznQWcXIfbB91BloiwC/fW2o7p
 mfzQ==
X-Gm-Message-State: AOJu0Ywsy/1CWIP4kp39iU9o35/5FMftvCuYYOhiIuPSkA95nGrcgOs1
 gZ4UVfG+zL6mC259oV5CCkywfpQttwIb0c+GdvkJtA==
X-Google-Smtp-Source: AGHT+IGeCP4QFN7ZgQJeFnN7faugEryNKJ80Nvg0QuCcVgGBL3GaaL9QrMygC+jl/dS1Ke3ms4zU355E0zK8lA+JEz0=
X-Received: by 2002:ac2:4acf:0:b0:50b:f8d8:b176 with SMTP id
 m15-20020ac24acf000000b0050bf8d8b176mr648422lfp.124.1702127651029; Sat, 09
 Dec 2023 05:14:11 -0800 (PST)
MIME-Version: 1.0
References: <20231202035511.487946-1-sjg@chromium.org>
 <20231202035511.487946-3-sjg@chromium.org>
 <20231203153401.GV8402@pendragon.ideasonboard.com>
 <20231207142723.GA3187877@google.com>
 <20231207143814.GD15521@pendragon.ideasonboard.com>
In-Reply-To: <20231207143814.GD15521@pendragon.ideasonboard.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Sat, 9 Dec 2023 22:13:59 +0900
Message-ID: <CAGXv+5Go_0pEVAOLQmRCc_a9-YUtZEmBfXtMuBupX_nb9iqwbw@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] arm64: boot: Support Flat Image Tree
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Simon Glass <sjg@chromium.org>, linux-arm-kernel@lists.infradead.org, 
 Masahiro Yamada <masahiroy@kernel.org>, Ahmad Fatoum <a.fatoum@pengutronix.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Nicolas Schier <nicolas@fjasle.eu>,
 Tom Rini <trini@konsulko.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Nathan Chancellor <nathan@kernel.org>, Nick Terrell <terrelln@fb.com>,
 Will Deacon <will@kernel.org>, 
 linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org, 
 linux-kernel@vger.kernel.org, workflows@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 09 Dec 2023 14:58:01 +0100
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

On Thu, Dec 7, 2023 at 11:38=E2=80=AFPM Laurent Pinchart
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
> > > > devicetree, matching the compatible string of the running board wit=
h
> > > > the closest compatible string in the FIT. There is no need for
> > > > filenames or other workarounds.
> > > >
> > > > Add a 'make image.fit' build target for arm64, as well. Use
> > > > FIT_COMPRESSION to select a different algorithm.
> > > >
> > > > The FIT can be examined using 'dumpimage -l'.
> > > >
> > > > This features requires pylibfdt (use 'pip install libfdt'). It also
> > > > requires compression utilities for the algorithm being used. Suppor=
ted
> > > > compression options are the same as the Image.xxx files. For now th=
ere
> > > > is no way to change the compression other than by editing the rule =
for
> > > > $(obj)/image.fit
> > > >
> > > > While FIT supports a ramdisk / initrd, no attempt is made to suppor=
t
> > > > this here, since it must be built separately from the Linux build.
> > >
> > > FIT images are very useful, so I think this is a very welcome additio=
n
> > > to the kernel build system. It can get tricky though: given the
> > > versatile nature of FIT images, there can't be any
> > > one-size-fits-them-all solution to build them, and striking the right
> > > balance between what makes sense for the kernel and the features that
> > > users may request will probably lead to bikeshedding. As we all love
> > > bikeshedding, I thought I would start selfishly, with a personal use
> > > case :-) This isn't a yak-shaving request though, I don't see any rea=
son
> > > to delay merging this series.
> > >
> > > Have you envisioned building FIT images with a subset of DTBs, or add=
ing
> > > DTBOs ? Both would be fairly trivial extensions to this script by
> > > extending the supported command line arguments. It would perhaps be m=
ore
> > > difficult to integrate in the kernel build system though. This leads =
me
> > > to a second question: would you consider merging extensions to this
> > > script if they are not used by the kernel build system, but meant for
> > > users who manually invoke the script ? More generally, is the script
> >
> > We'd also be interested in some customization, though in a different wa=
y.
> > We imagine having a rule file that says X compatible string should map
> > to A base DTB, plus B and C DTBO for the configuration section. The bas=
e
> > DTB would carry all common elements of some device, while the DTBOs
> > carry all the possible second source components, like different display
> > panels or MIPI cameras for instance. This could drastically reduce the
> > size of FIT images in ChromeOS by deduplicating all the common stuff.
>
> Do you envision the "mapping" compatible string mapping to a config
> section in the FIT image, that would bundle the base DTB and the DTBOs ?

That's exactly the idea. The mapping compatible string could be untied
from the base board's compatible string if needed (which we probably do).

So something like:

config {
    config-1 {
        compatible =3D "google,krane-sku0";
        fdt =3D "krane-baseboard", "krane-sku0-overlay";
    };
};

With "krane-sku0-overlay" being an overlay that holds the differences
between the SKUs, in this case the display panel and MIPI camera (not
upstreamed) that applies to SKU0 in particular.

Sorry for not giving a more concrete idea.


ChenYu

> > > meant to be used stand-alone as well, in which case its command line
> > > arguments need to remain backward-compatible, or do you see it as bei=
ng
> > > internal to the kernel ?
> >
> > [...]
> >
> > ChenYu
>
> --
> Regards,
>
> Laurent Pinchart
