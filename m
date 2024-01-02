Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A72DC46CD2
	for <u-boot@archiver.kernel.org>; Tue,  2 Jan 2024 14:31:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B174876FB;
	Tue,  2 Jan 2024 15:31:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lnuQFsrB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2634D86E42; Tue,  2 Jan 2024 04:19:40 +0100 (CET)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E3F586C68
 for <u-boot@lists.denx.de>; Tue,  2 Jan 2024 04:19:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=wenst@chromium.org
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2ccba761783so70421311fa.1
 for <u-boot@lists.denx.de>; Mon, 01 Jan 2024 19:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704165573; x=1704770373; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MSG8CaCQvnMHmRj4U7U29sjt1LfOepuOZsoWy7DEkWU=;
 b=lnuQFsrBMUanNy4J8UXZomW1ZUSdoonG+owgHaIhscFN6INnKTrhnBs0/xLLGUrrBC
 vOPhchQNwZ9ikNZNd/MXmYNGiDSqMUPTFgXqfbTIcFHQEX2fQAl3amxa2sqokc9OPAyz
 tczpI2GjBPWbKxTK1flzCLyR8tdPHbWQhgW/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704165573; x=1704770373;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MSG8CaCQvnMHmRj4U7U29sjt1LfOepuOZsoWy7DEkWU=;
 b=uTPtcNoaA9dFBe09Dq9tMeo9EVwUxp0kfX2tZhViBl9qI+3aBwy0uCBkmlY03l9L/p
 t8jhA9OArXOZkc229JaKuzXUGjf85q14PQZ/1zqiNfkFLTPRkBrlnOF5FqAgcb0DnAfM
 kS3TRDRmmZ/kw+oDUzqN8vaR9wWrV96kvJDtRJiE70nVKEPxdeueFc/UmKjaEE5QLqSz
 ytJ3ppwCJuzERW77qGpgf0rUb4jT71HPicK9oF1J72eWMCiDQzVY+wLjPQ3EDYuzd2Lc
 9JEspEis7+AzVDL2rhHxl8XMQKvdKyanjhTNHnEtEyR06+sTyctT+FEhPjHAZh6hGf14
 9gmQ==
X-Gm-Message-State: AOJu0Yyb/DnQe1XVgfwtE9utbr4Qah9huluTb+0XrZ+GTluduxZZZuCA
 z75kdIbDD72qoIHZzHN9+ZkcKH9bbhH5mtrXpP7ekBa7+rnm
X-Google-Smtp-Source: AGHT+IGT4BrLfdWsBgROHYxY8UAI/pZQNjY8Pr+V7A3z8LJ4pVTi524kqd3irjIggIFV9gC7XM+GECK0k+nYmYpg5aA=
X-Received: by 2002:a05:651c:4cd:b0:2cd:10aa:7628 with SMTP id
 e13-20020a05651c04cd00b002cd10aa7628mr26646lji.8.1704165572658; Mon, 01 Jan
 2024 19:19:32 -0800 (PST)
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
 <CAFLszTjfN8dzBNpr6+EVQiwen5BPoYtu8LJM3dCcd-sMP3=Nvw@mail.gmail.com>
In-Reply-To: <CAFLszTjfN8dzBNpr6+EVQiwen5BPoYtu8LJM3dCcd-sMP3=Nvw@mail.gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 2 Jan 2024 11:19:21 +0800
Message-ID: <CAGXv+5Fp__Hats=sNmdmg8dYVfNB2K0FP23aKA_7D3sz4EvzrA@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] arm64: boot: Support Flat Image Tree
To: Simon Glass <sjg@chromium.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
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
X-Mailman-Approved-At: Tue, 02 Jan 2024 15:31:53 +0100
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

On Fri, Dec 29, 2023 at 2:39=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Masahiro,
>
> On Thu, Dec 14, 2023 at 7:34=E2=80=AFAM Masahiro Yamada <masahiroy@kernel=
.org> wrote:
> >
> > On Thu, Dec 14, 2023 at 3:12=E2=80=AFPM Masahiro Yamada <masahiroy@kern=
el.org> wrote:
> > >
> > > On Thu, Dec 14, 2023 at 1:03=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.=
org> wrote:
> > > >
> > > > On Sun, Dec 10, 2023 at 1:31=E2=80=AFAM Geert Uytterhoeven <geert@l=
inux-m68k.org> wrote:
> > > > >
> > > > > Hi Laurent,
> > > > >
> > > > > On Sat, Dec 9, 2023 at 4:29=E2=80=AFPM Laurent Pinchart
> > > > > <laurent.pinchart@ideasonboard.com> wrote:
> > > > > > On Sat, Dec 09, 2023 at 10:13:59PM +0900, Chen-Yu Tsai wrote:
> > > > > > > On Thu, Dec 7, 2023 at 11:38=E2=80=AFPM Laurent Pinchart
> > > > > > > <laurent.pinchart@ideasonboard.com> wrote:
> > > > > > > > On Thu, Dec 07, 2023 at 10:27:23PM +0800, Chen-Yu Tsai wrot=
e:
> > > > > > > > > On Sun, Dec 03, 2023 at 05:34:01PM +0200, Laurent Pinchar=
t wrote:
> > > > > > > > > > On Fri, Dec 01, 2023 at 08:54:42PM -0700, Simon Glass w=
rote:
> > > > > > > > > > > Add a script which produces a Flat Image Tree (FIT), =
a single file
> > > > > > > > > > > containing the built kernel and associated devicetree=
 files.
> > > > > > > > > > > Compression defaults to gzip which gives a good balan=
ce of size and
> > > > > > > > > > > performance.
> > > > > > > > > > >
> > > > > > > > > > > The files compress from about 86MB to 24MB using this=
 approach.
> > > > > > > > > > >
> > > > > > > > > > > The FIT can be used by bootloaders which support it, =
such as U-Boot
> > > > > > > > > > > and Linuxboot. It permits automatic selection of the =
correct
> > > > > > > > > > > devicetree, matching the compatible string of the run=
ning board with
> > > > > > > > > > > the closest compatible string in the FIT. There is no=
 need for
> > > > > > > > > > > filenames or other workarounds.
> > > > > > > > > > >
> > > > > > > > > > > Add a 'make image.fit' build target for arm64, as wel=
l. Use
> > > > > > > > > > > FIT_COMPRESSION to select a different algorithm.
> > > > > > > > > > >
> > > > > > > > > > > The FIT can be examined using 'dumpimage -l'.
> > > > > > > > > > >
> > > > > > > > > > > This features requires pylibfdt (use 'pip install lib=
fdt'). It also
> > > > > > > > > > > requires compression utilities for the algorithm bein=
g used. Supported
> > > > > > > > > > > compression options are the same as the Image.xxx fil=
es. For now there
> > > > > > > > > > > is no way to change the compression other than by edi=
ting the rule for
> > > > > > > > > > > $(obj)/image.fit
> > > > > > > > > > >
> > > > > > > > > > > While FIT supports a ramdisk / initrd, no attempt is =
made to support
> > > > > > > > > > > this here, since it must be built separately from the=
 Linux build.
> > > > > > > > > >
> > > > > > > > > > FIT images are very useful, so I think this is a very w=
elcome addition
> > > > > > > > > > to the kernel build system. It can get tricky though: g=
iven the
> > > > > > > > > > versatile nature of FIT images, there can't be any
> > > > > > > > > > one-size-fits-them-all solution to build them, and stri=
king the right
> > > > > > > > > > balance between what makes sense for the kernel and the=
 features that
> > > > > > > > > > users may request will probably lead to bikeshedding. A=
s we all love
> > > > > > > > > > bikeshedding, I thought I would start selfishly, with a=
 personal use
> > > > > > > > > > case :-) This isn't a yak-shaving request though, I don=
't see any reason
> > > > > > > > > > to delay merging this series.
> > > > > > > > > >
> > > > > > > > > > Have you envisioned building FIT images with a subset o=
f DTBs, or adding
> > > > > > > > > > DTBOs ? Both would be fairly trivial extensions to this=
 script by
> > > > > > > > > > extending the supported command line arguments. It woul=
d perhaps be more
> > > > > > > > > > difficult to integrate in the kernel build system thoug=
h. This leads me
> > > > > > > > > > to a second question: would you consider merging extens=
ions to this
> > > > > > > > > > script if they are not used by the kernel build system,=
 but meant for
> > > > > > > > > > users who manually invoke the script ? More generally, =
is the script
> > > > > > > > >
> > > > > > > > > We'd also be interested in some customization, though in =
a different way.
> > > > > > > > > We imagine having a rule file that says X compatible stri=
ng should map
> > > > > > > > > to A base DTB, plus B and C DTBO for the configuration se=
ction. The base
> > > > > > > > > DTB would carry all common elements of some device, while=
 the DTBOs
> > > > > > > > > carry all the possible second source components, like dif=
ferent display
> > > > > > > > > panels or MIPI cameras for instance. This could drastical=
ly reduce the
> > > > > > > > > size of FIT images in ChromeOS by deduplicating all the c=
ommon stuff.
> > > > > > > >
> > > > > > > > Do you envision the "mapping" compatible string mapping to =
a config
> > > > > > > > section in the FIT image, that would bundle the base DTB an=
d the DTBOs ?
> > > > > > >
> > > > > > > That's exactly the idea. The mapping compatible string could =
be untied
> > > > > > > from the base board's compatible string if needed (which we p=
robably do).
> > > > > > >
> > > > > > > So something like:
> > > > > > >
> > > > > > > config {
> > > > > > >     config-1 {
> > > > > > >         compatible =3D "google,krane-sku0";
> > > > > > >         fdt =3D "krane-baseboard", "krane-sku0-overlay";
> > > > > > >     };
> > > > > > > };
> > > > > > >
> > > > > > > With "krane-sku0-overlay" being an overlay that holds the dif=
ferences
> > > > > > > between the SKUs, in this case the display panel and MIPI cam=
era (not
> > > > > > > upstreamed) that applies to SKU0 in particular.
> > > > > >
> > > > > > The kernel DT makefiles already contain information on what ove=
rlays to
> > > > > > apply to what base boards, in order to test the overlays and pr=
oduce
> > > > > > "full" DTBs. Maybe that information could be leveraged to creat=
e the
> > > > > > configurations in the FIT image ?
> > > > >
> > > > > Although the "full" DTBs created may only be a subset of all poss=
ible
> > > > > combinations (I believe Rob just started with creating one "full"=
 DTB
> > > > > for each overlay, cfr. the additions I made in commit a09c3e105a2=
08580
> > > > > ("arm64: dts: renesas: Apply overlays to base dtbs")), that could
> > > > > definitely be a start.
> > > > >
> > > > > Now, since the kernel build system already creates "full" DTBs, d=
oes
> > > > > that mean that all of the base DTBs, overlays, and "full" DTBs wi=
ll
> > > > > end up in the FIT image?
> > > >
> > > > I suppose we could add an option to the packing tool to be able to =
_not_
> > > > add the "full" DTBs if they can also be assembled with a base DTB a=
nd
> > > > overlays. Think of it as a firmware compatibility option: if the fi=
rmware
> > > > supports overlays, then you almost always want the deconstructed pa=
rts,
> > > > not the fully assembled ones. Vice versa.
> > > >
> > > > If we don't we could end up with two configurations that have the s=
ame
> > > > compatible string?
> > >
> > >
> > > Right.
> > >
> > > We would end up with such situations because applying
> > > an overlay does not change the compatible string.
> > >
> > >
> > >
> > > With this code in arch/arm64/boot/dts/ti/Makefile:
> > >
> > > k3-am642-tqma64xxl-mbax4xxl-sdcard-dtbs :=3D \
> > >       k3-am642-tqma64xxl-mbax4xxl.dtb k3-am64-tqma64xxl-mbax4xxl-sdca=
rd.dtbo
> > > k3-am642-tqma64xxl-mbax4xxl-wlan-dtbs :=3D \
> > >       k3-am642-tqma64xxl-mbax4xxl.dtb k3-am64-tqma64xxl-mbax4xxl-wlan=
.dtbo
> > >
> > >
> > >
> > >
> > > $ fdtdump  arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl-sdcard.=
dtb
> > > 2>/dev/null| head -n15 | tail -n2
> > >     model =3D "TQ-Systems TQMa64xxL SoM on MBax4xxL carrier board";
> > >     compatible =3D "tq,am642-tqma6442l-mbax4xxl", "tq,am642-tqma6442l=
",
> > > "ti,am642";
> > >
> > >
> > > $ fdtdump  arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl-wlan.dt=
b
> > > 2>/dev/null| head -n15 | tail -n2
> > >     model =3D "TQ-Systems TQMa64xxL SoM on MBax4xxL carrier board";
> > >     compatible =3D "tq,am642-tqma6442l-mbax4xxl", "tq,am642-tqma6442l=
",
> > > "ti,am642";
> > >
> > >
> > >
> > >
> > >
> > > These two go into image.fit, but one of them is completely dead
> > > since there is no way to distinguish them.
> > >
> > >
> > > $ fdtdump  arch/arm64/boot/image.fit
> > >
> > >         ...
> > >
> > >         conf-10 {
> > >             compatible =3D "tq,am642-tqma6442l-mbax4xxl",
> > > "tq,am642-tqma6442l", "ti,am642";
> > >             description =3D "TQ-Systems TQMa64xxL SoM on MBax4xxL car=
rier board";
> > >             fdt =3D "fdt-10";
> > >             kernel =3D "kernel";
> > >         };
> > >
> > >         ...
> > >
> > >         conf-25 {
> > >             compatible =3D "tq,am642-tqma6442l-mbax4xxl",
> > > "tq,am642-tqma6442l", "ti,am642";
> > >             description =3D "TQ-Systems TQMa64xxL SoM on MBax4xxL car=
rier board";
> > >             fdt =3D "fdt-25";
> > >             kernel =3D "kernel";
> > >         };
> > >
> > >
> > >
> > >
> > >
> > > I agree with Chen-Yu.
> > >
> > > FIT should not include full DTBs.
> > >
> > > Bootloaders should assemble the final DTB
> > > from base and overlays on-the-fly.
> > >
> > >
> > > The FIT spec allows the "fdt" property to list
> > > multiple image nodes.
> > >
> > >
> > > o config-1
> > >  |- description =3D "configuration description"
> > >  |- kernel =3D "kernel sub-node unit name"
> > >  |- fdt =3D "fdt sub-node unit-name" [, "fdt overlay sub-node unit-na=
me", ...]
> > >  |- loadables =3D "loadables sub-node unit-name"
> > >  |- script =3D "
> > >  |- compatible =3D "vendor
> >
> >
> >
> >
> >
> > This is a question for U-Boot (and barebox).
> >
> >
> >
> >
> >    images {
> >           base {
> >                 ...
> >           };
> >
> >           addon1 {
> >                 ...
> >           };
> >
> >           addon2 {
> >                 ...
> >           };
> >     };
> >
> >     configurations {
> >           ...
> >           fdt =3D "base", "addon1", "addon2";
> >     };
> >
> >
> >
> >
> > Is U-Boot's "bootm" command able to dynamically construct
> > the full DTB from "base" + "addon1" + "addon2"
> > and pass to the kernel?
> >
> >
> >
> > When I used overlay from U-Boot command line last time,
> > I typed complicated commands, following this manual:
> > https://docs.u-boot.org/en/latest/usage/fdt_overlays.html
> >
> >
>
> So far this is not possible with bootm, no. But if we can add
> extensions to the FIT spec, then it should be possible to implement
> this.

Isn't this already part of the FIT spec? There's nothing special here.
It's one configuration that lists a base DTB plus some addon overlays.

The FIT spec says:

  - fdt : Unit name of the corresponding fdt blob (component image node of =
a
    "fdt type"). Additional fdt overlay nodes can be supplied which signify
    that the resulting device tree blob is generated by the first base fdt
    blob with all subsequent overlays applied.

Are you saying that U-boot currently lacks a mechanism to select the config=
?
A quick skim over U-boot code suggests that boards need to implement
board_fit_config_name_match()?

> Is it (or will it be) possible to get Linux to build the DT + overlay
> combinations?

It is possible to build overlays separately, and have the build system
apply them. Taking an example from the Renesas tree (line wrap mine):

    dtb-$(CONFIG_ARCH_R8A779G0) +=3D r8a779g0-white-hawk.dtb
    dtb-$(CONFIG_ARCH_R8A779G0) +=3D r8a779g0-white-hawk-ard-audio-da7212.d=
tbo
    r8a779g0-white-hawk-ard-audio-da7212-dtbs :=3D r8a779g0-white-hawk.dtb =
\
            r8a779g0-white-hawk-ard-audio-da7212.dtbo
    dtb-$(CONFIG_ARCH_R8A779G0) +=3D r8a779g0-white-hawk-ard-audio-da7212.d=
tb

The overlays are applied using the fdtoverlay command from the device tree
compiler suite.

ChenYu

> > One more question to confirm if I can use this
> > for my practical use-cases.
> >
> > Is U-Boot able to handle FIT (includes kernel + DTs)
> > and a separate initrd?
> >
> >   # bootm  <fit-address>:<conf-name>  <ramdisk-address>
> >
> >
> > Presumably, it would be difficult to inject initramdisk
> > into image.fit later, so I am hoping bootm would work like that,
> > but I did not delve into U-Boot code.
> >
> >
>
> The ramdisk is handled by the FIT configuration. I suppose it would be
> possible to add a way to bypass the logic in select_ramdisk(), but I
> wonder what is the use case for this?
>
> >
> > If it works, is it possible to verify the integrity of initrd?
> > The kernel and DTs inside FIT will be verified, but not sure
> > if it is possible for ramdisk.
>
> I do have thoughts about a possible new FIT feature to allow external
> files, which could perhaps include an initrd.
>
> Regards,
> Simon
