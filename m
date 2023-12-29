Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F28C9C46CD4
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 06:39:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71AC487A17;
	Fri, 29 Dec 2023 07:39:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AMpG2312";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A03FD87A3B; Fri, 29 Dec 2023 07:39:05 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB080876B2
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 07:39:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-5e811c5c1adso56191287b3.2
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 22:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703831941; x=1704436741; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ncWe7dUBo4O/c5b3q+xH9kX+M3BU9J/5qXVDoWQ6hRU=;
 b=AMpG2312+pQhz6cg6VwyMo/swOvH4MZprBWQoXeJPb/owf3LwdJqUYOfrXxBk2eIc6
 xESuS/ATYmZN9CkyXatzxrxBc7wxT4wKR4WiJX5k0CEFSrX2z/AGA+jboSRvxEiia1yx
 Jh1VZxkfzQqwVTI/x3osFUuzPz3+ve7meSjpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703831941; x=1704436741;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ncWe7dUBo4O/c5b3q+xH9kX+M3BU9J/5qXVDoWQ6hRU=;
 b=iqsXNxmkRhc6S1eTYcd6BMDjkAEnmFk3J2QOVbnAStv9D2kVfjFcGhI4hBhbQ4nX+y
 idVCE7y/dVBG/j01ZewLUnDWbCU2UFfMtDghjLli2Jdct1paFN4ilgQcXa15AhJoQhdX
 i/HNd+nybwVTOZ2DzrrUS6/vAW9sBL4lWUNcjIqKjH8ptNkfRGrfFXURka5OWkS4Vswu
 N3msGHIxLoly5JtVoCW7aWBQuLsO2uKDppgpCA99Xv9XGf8wOSNSLWqUZmz2s+SzpVWl
 g7sdgRN8kmuY5vQofN70n39z1keyXbGlSsAaSg0zXEtMmDN873VXPWnpwbQODxdQJaMT
 XvUA==
X-Gm-Message-State: AOJu0YzapUkKorFQRpuHL/5lYiJ4IXF3XC/H390KU2O5vaSZacCB0Q1S
 Rv5u9OWLxOGrVj09wT1vs867JnKjuGIbZaWJaiu8EodVDysu
X-Google-Smtp-Source: AGHT+IEJdV/1A4JP1OeUGiSOpRey9oFF/nlAlZcFgPe8HfCwst5LZ0Rkb0Rg1dR1bZzSjxWI35hth0uPLlY67scSbsQ=
X-Received: by 2002:a05:690c:fc8:b0:5e7:ecd0:2040 with SMTP id
 dg8-20020a05690c0fc800b005e7ecd02040mr8310159ywb.16.1703831941315; Thu, 28
 Dec 2023 22:39:01 -0800 (PST)
MIME-Version: 1.0
References: <20231202035511.487946-1-sjg@chromium.org>
 <20231202035511.487946-3-sjg@chromium.org>
 <20231203153401.GV8402@pendragon.ideasonboard.com>
 <20231207142723.GA3187877@google.com>
 <20231207143814.GD15521@pendragon.ideasonboard.com>
 <CAGXv+5Go_0pEVAOLQmRCc_a9-YUtZEmBfXtMuBupX_nb9iqwbw@mail.gmail.com>
 <20231209152946.GC13421@pendragon.ideasonboard.com>
 <CAMuHMdVMZs6mnwWBgFwktO=8o=QzROv60cfZe085MhD6HxQjpQ@mail.gmail.com>
 <CAGXv+5Est3FL-XcEL-vB-6zVNas0mqb2cNYa==Yb7W2SQU9xVQ@mail.gmail.com>
 <CAK7LNATyD-PeNbaLTjJmU9=koqqE+V6QvFe09c2VrXopWvjpcw@mail.gmail.com>
 <CAK7LNAR7Fm-1yaZmyH78vG5yNbbW2Avjj5F63u+aST6JQoMd5A@mail.gmail.com>
In-Reply-To: <CAK7LNAR7Fm-1yaZmyH78vG5yNbbW2Avjj5F63u+aST6JQoMd5A@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 29 Dec 2023 06:38:50 +0000
Message-ID: <CAFLszTjfN8dzBNpr6+EVQiwen5BPoYtu8LJM3dCcd-sMP3=Nvw@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] arm64: boot: Support Flat Image Tree
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 linux-arm-kernel@lists.infradead.org, 
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

Hi Masahiro,

On Thu, Dec 14, 2023 at 7:34=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> On Thu, Dec 14, 2023 at 3:12=E2=80=AFPM Masahiro Yamada <masahiroy@kernel=
.org> wrote:
> >
> > On Thu, Dec 14, 2023 at 1:03=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.or=
g> wrote:
> > >
> > > On Sun, Dec 10, 2023 at 1:31=E2=80=AFAM Geert Uytterhoeven <geert@lin=
ux-m68k.org> wrote:
> > > >
> > > > Hi Laurent,
> > > >
> > > > On Sat, Dec 9, 2023 at 4:29=E2=80=AFPM Laurent Pinchart
> > > > <laurent.pinchart@ideasonboard.com> wrote:
> > > > > On Sat, Dec 09, 2023 at 10:13:59PM +0900, Chen-Yu Tsai wrote:
> > > > > > On Thu, Dec 7, 2023 at 11:38=E2=80=AFPM Laurent Pinchart
> > > > > > <laurent.pinchart@ideasonboard.com> wrote:
> > > > > > > On Thu, Dec 07, 2023 at 10:27:23PM +0800, Chen-Yu Tsai wrote:
> > > > > > > > On Sun, Dec 03, 2023 at 05:34:01PM +0200, Laurent Pinchart =
wrote:
> > > > > > > > > On Fri, Dec 01, 2023 at 08:54:42PM -0700, Simon Glass wro=
te:
> > > > > > > > > > Add a script which produces a Flat Image Tree (FIT), a =
single file
> > > > > > > > > > containing the built kernel and associated devicetree f=
iles.
> > > > > > > > > > Compression defaults to gzip which gives a good balance=
 of size and
> > > > > > > > > > performance.
> > > > > > > > > >
> > > > > > > > > > The files compress from about 86MB to 24MB using this a=
pproach.
> > > > > > > > > >
> > > > > > > > > > The FIT can be used by bootloaders which support it, su=
ch as U-Boot
> > > > > > > > > > and Linuxboot. It permits automatic selection of the co=
rrect
> > > > > > > > > > devicetree, matching the compatible string of the runni=
ng board with
> > > > > > > > > > the closest compatible string in the FIT. There is no n=
eed for
> > > > > > > > > > filenames or other workarounds.
> > > > > > > > > >
> > > > > > > > > > Add a 'make image.fit' build target for arm64, as well.=
 Use
> > > > > > > > > > FIT_COMPRESSION to select a different algorithm.
> > > > > > > > > >
> > > > > > > > > > The FIT can be examined using 'dumpimage -l'.
> > > > > > > > > >
> > > > > > > > > > This features requires pylibfdt (use 'pip install libfd=
t'). It also
> > > > > > > > > > requires compression utilities for the algorithm being =
used. Supported
> > > > > > > > > > compression options are the same as the Image.xxx files=
. For now there
> > > > > > > > > > is no way to change the compression other than by editi=
ng the rule for
> > > > > > > > > > $(obj)/image.fit
> > > > > > > > > >
> > > > > > > > > > While FIT supports a ramdisk / initrd, no attempt is ma=
de to support
> > > > > > > > > > this here, since it must be built separately from the L=
inux build.
> > > > > > > > >
> > > > > > > > > FIT images are very useful, so I think this is a very wel=
come addition
> > > > > > > > > to the kernel build system. It can get tricky though: giv=
en the
> > > > > > > > > versatile nature of FIT images, there can't be any
> > > > > > > > > one-size-fits-them-all solution to build them, and striki=
ng the right
> > > > > > > > > balance between what makes sense for the kernel and the f=
eatures that
> > > > > > > > > users may request will probably lead to bikeshedding. As =
we all love
> > > > > > > > > bikeshedding, I thought I would start selfishly, with a p=
ersonal use
> > > > > > > > > case :-) This isn't a yak-shaving request though, I don't=
 see any reason
> > > > > > > > > to delay merging this series.
> > > > > > > > >
> > > > > > > > > Have you envisioned building FIT images with a subset of =
DTBs, or adding
> > > > > > > > > DTBOs ? Both would be fairly trivial extensions to this s=
cript by
> > > > > > > > > extending the supported command line arguments. It would =
perhaps be more
> > > > > > > > > difficult to integrate in the kernel build system though.=
 This leads me
> > > > > > > > > to a second question: would you consider merging extensio=
ns to this
> > > > > > > > > script if they are not used by the kernel build system, b=
ut meant for
> > > > > > > > > users who manually invoke the script ? More generally, is=
 the script
> > > > > > > >
> > > > > > > > We'd also be interested in some customization, though in a =
different way.
> > > > > > > > We imagine having a rule file that says X compatible string=
 should map
> > > > > > > > to A base DTB, plus B and C DTBO for the configuration sect=
ion. The base
> > > > > > > > DTB would carry all common elements of some device, while t=
he DTBOs
> > > > > > > > carry all the possible second source components, like diffe=
rent display
> > > > > > > > panels or MIPI cameras for instance. This could drastically=
 reduce the
> > > > > > > > size of FIT images in ChromeOS by deduplicating all the com=
mon stuff.
> > > > > > >
> > > > > > > Do you envision the "mapping" compatible string mapping to a =
config
> > > > > > > section in the FIT image, that would bundle the base DTB and =
the DTBOs ?
> > > > > >
> > > > > > That's exactly the idea. The mapping compatible string could be=
 untied
> > > > > > from the base board's compatible string if needed (which we pro=
bably do).
> > > > > >
> > > > > > So something like:
> > > > > >
> > > > > > config {
> > > > > >     config-1 {
> > > > > >         compatible =3D "google,krane-sku0";
> > > > > >         fdt =3D "krane-baseboard", "krane-sku0-overlay";
> > > > > >     };
> > > > > > };
> > > > > >
> > > > > > With "krane-sku0-overlay" being an overlay that holds the diffe=
rences
> > > > > > between the SKUs, in this case the display panel and MIPI camer=
a (not
> > > > > > upstreamed) that applies to SKU0 in particular.
> > > > >
> > > > > The kernel DT makefiles already contain information on what overl=
ays to
> > > > > apply to what base boards, in order to test the overlays and prod=
uce
> > > > > "full" DTBs. Maybe that information could be leveraged to create =
the
> > > > > configurations in the FIT image ?
> > > >
> > > > Although the "full" DTBs created may only be a subset of all possib=
le
> > > > combinations (I believe Rob just started with creating one "full" D=
TB
> > > > for each overlay, cfr. the additions I made in commit a09c3e105a208=
580
> > > > ("arm64: dts: renesas: Apply overlays to base dtbs")), that could
> > > > definitely be a start.
> > > >
> > > > Now, since the kernel build system already creates "full" DTBs, doe=
s
> > > > that mean that all of the base DTBs, overlays, and "full" DTBs will
> > > > end up in the FIT image?
> > >
> > > I suppose we could add an option to the packing tool to be able to _n=
ot_
> > > add the "full" DTBs if they can also be assembled with a base DTB and
> > > overlays. Think of it as a firmware compatibility option: if the firm=
ware
> > > supports overlays, then you almost always want the deconstructed part=
s,
> > > not the fully assembled ones. Vice versa.
> > >
> > > If we don't we could end up with two configurations that have the sam=
e
> > > compatible string?
> >
> >
> > Right.
> >
> > We would end up with such situations because applying
> > an overlay does not change the compatible string.
> >
> >
> >
> > With this code in arch/arm64/boot/dts/ti/Makefile:
> >
> > k3-am642-tqma64xxl-mbax4xxl-sdcard-dtbs :=3D \
> >       k3-am642-tqma64xxl-mbax4xxl.dtb k3-am64-tqma64xxl-mbax4xxl-sdcard=
.dtbo
> > k3-am642-tqma64xxl-mbax4xxl-wlan-dtbs :=3D \
> >       k3-am642-tqma64xxl-mbax4xxl.dtb k3-am64-tqma64xxl-mbax4xxl-wlan.d=
tbo
> >
> >
> >
> >
> > $ fdtdump  arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl-sdcard.dt=
b
> > 2>/dev/null| head -n15 | tail -n2
> >     model =3D "TQ-Systems TQMa64xxL SoM on MBax4xxL carrier board";
> >     compatible =3D "tq,am642-tqma6442l-mbax4xxl", "tq,am642-tqma6442l",
> > "ti,am642";
> >
> >
> > $ fdtdump  arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl-wlan.dtb
> > 2>/dev/null| head -n15 | tail -n2
> >     model =3D "TQ-Systems TQMa64xxL SoM on MBax4xxL carrier board";
> >     compatible =3D "tq,am642-tqma6442l-mbax4xxl", "tq,am642-tqma6442l",
> > "ti,am642";
> >
> >
> >
> >
> >
> > These two go into image.fit, but one of them is completely dead
> > since there is no way to distinguish them.
> >
> >
> > $ fdtdump  arch/arm64/boot/image.fit
> >
> >         ...
> >
> >         conf-10 {
> >             compatible =3D "tq,am642-tqma6442l-mbax4xxl",
> > "tq,am642-tqma6442l", "ti,am642";
> >             description =3D "TQ-Systems TQMa64xxL SoM on MBax4xxL carri=
er board";
> >             fdt =3D "fdt-10";
> >             kernel =3D "kernel";
> >         };
> >
> >         ...
> >
> >         conf-25 {
> >             compatible =3D "tq,am642-tqma6442l-mbax4xxl",
> > "tq,am642-tqma6442l", "ti,am642";
> >             description =3D "TQ-Systems TQMa64xxL SoM on MBax4xxL carri=
er board";
> >             fdt =3D "fdt-25";
> >             kernel =3D "kernel";
> >         };
> >
> >
> >
> >
> >
> > I agree with Chen-Yu.
> >
> > FIT should not include full DTBs.
> >
> > Bootloaders should assemble the final DTB
> > from base and overlays on-the-fly.
> >
> >
> > The FIT spec allows the "fdt" property to list
> > multiple image nodes.
> >
> >
> > o config-1
> >  |- description =3D "configuration description"
> >  |- kernel =3D "kernel sub-node unit name"
> >  |- fdt =3D "fdt sub-node unit-name" [, "fdt overlay sub-node unit-name=
", ...]
> >  |- loadables =3D "loadables sub-node unit-name"
> >  |- script =3D "
> >  |- compatible =3D "vendor
>
>
>
>
>
> This is a question for U-Boot (and barebox).
>
>
>
>
>    images {
>           base {
>                 ...
>           };
>
>           addon1 {
>                 ...
>           };
>
>           addon2 {
>                 ...
>           };
>     };
>
>     configurations {
>           ...
>           fdt =3D "base", "addon1", "addon2";
>     };
>
>
>
>
> Is U-Boot's "bootm" command able to dynamically construct
> the full DTB from "base" + "addon1" + "addon2"
> and pass to the kernel?
>
>
>
> When I used overlay from U-Boot command line last time,
> I typed complicated commands, following this manual:
> https://docs.u-boot.org/en/latest/usage/fdt_overlays.html
>
>

So far this is not possible with bootm, no. But if we can add
extensions to the FIT spec, then it should be possible to implement
this.

Is it (or will it be) possible to get Linux to build the DT + overlay
combinations?

>
>
> One more question to confirm if I can use this
> for my practical use-cases.
>
> Is U-Boot able to handle FIT (includes kernel + DTs)
> and a separate initrd?
>
>   # bootm  <fit-address>:<conf-name>  <ramdisk-address>
>
>
> Presumably, it would be difficult to inject initramdisk
> into image.fit later, so I am hoping bootm would work like that,
> but I did not delve into U-Boot code.
>
>

The ramdisk is handled by the FIT configuration. I suppose it would be
possible to add a way to bypass the logic in select_ramdisk(), but I
wonder what is the use case for this?

>
> If it works, is it possible to verify the integrity of initrd?
> The kernel and DTs inside FIT will be verified, but not sure
> if it is possible for ramdisk.

I do have thoughts about a possible new FIT feature to allow external
files, which could perhaps include an initrd.

Regards,
Simon
