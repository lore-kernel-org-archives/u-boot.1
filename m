Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE19C4167D
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 07:58:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E08F87A3A;
	Thu, 14 Dec 2023 08:58:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDE1087A3C; Thu, 14 Dec 2023 08:58:08 +0100 (CET)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com
 [209.85.219.174])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AD7A87A36
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 08:58:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux-m68k.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=geert.uytterhoeven@gmail.com
Received: by mail-yb1-f174.google.com with SMTP id
 3f1490d57ef6-dbcdde08dc1so858876276.1
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 23:58:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702540685; x=1703145485;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sj0NwqxPiof3ml42MbQY4Ahv5ohZXpex6OnUgaYQww8=;
 b=cFDd3DeDsqqIHKRasBYarbQ1P00fFk4+krdpPAyw/UTOp1dkP8FsTUtPVdmaL5CqwN
 2br1NW8nyb69W/02rmxeAMc5dV8PPj/DyUUscV2dgdZZDCYqzkZlfupyeOkGLODmFXPc
 3SvEbFx29uP+k3lkA8fcC0bnzdPAFzbcUT86fNI64l5Db49ym6op/vjREkmNmGzTwpJF
 ixJ8qXOzPeOe8o2Ivq/3+UIPOZGMwRxwGRDEtKMnvIBo7pwcRC+If8us8OUqUnHdkZ1E
 x351yrNz/cTUyOcBUcV1BTxHTSxDp77MYMGGMa6ROcDNrGSqhDaMtnlolCJxa6T5S5Kl
 47cg==
X-Gm-Message-State: AOJu0YwbJkwzEDktBw5thss6TBF7ZiGsfQvJc1Fy3w8dkpDNPMjgADJ5
 MMMkB8viuD4OBKBOEt/Qdb2IiEmAvQJj7w==
X-Google-Smtp-Source: AGHT+IHo/S281vqqi1jWbhDSdCMlxq4RFeiWMTmEDrRdU5ChokA1BvMEhStG5NnB3+vMP6JBpvTelw==
X-Received: by 2002:a05:6902:1b0e:b0:dbc:bfb7:1f45 with SMTP id
 eh14-20020a0569021b0e00b00dbcbfb71f45mr2862511ybb.13.1702540684825; 
 Wed, 13 Dec 2023 23:58:04 -0800 (PST)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com.
 [209.85.219.182]) by smtp.gmail.com with ESMTPSA id
 cj9-20020a056902188900b00dbcd9bb4bbasm762844ybb.58.2023.12.13.23.58.04
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Dec 2023 23:58:04 -0800 (PST)
Received: by mail-yb1-f182.google.com with SMTP id
 3f1490d57ef6-db8892a5f96so7436599276.2
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 23:58:04 -0800 (PST)
X-Received: by 2002:a5b:7cf:0:b0:da0:442f:988e with SMTP id
 t15-20020a5b07cf000000b00da0442f988emr5673057ybq.19.1702540684087; Wed, 13
 Dec 2023 23:58:04 -0800 (PST)
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
In-Reply-To: <CAK7LNATyD-PeNbaLTjJmU9=koqqE+V6QvFe09c2VrXopWvjpcw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 14 Dec 2023 08:57:52 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXDPSQXNhBH5LCrggfJCWG32v_ZtcRdPfaGRuLj20N+Lg@mail.gmail.com>
Message-ID: <CAMuHMdXDPSQXNhBH5LCrggfJCWG32v_ZtcRdPfaGRuLj20N+Lg@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] arm64: boot: Support Flat Image Tree
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Simon Glass <sjg@chromium.org>, 
 linux-arm-kernel@lists.infradead.org, Ahmad Fatoum <a.fatoum@pengutronix.de>, 
 U-Boot Mailing List <u-boot@lists.denx.de>, Nicolas Schier <nicolas@fjasle.eu>,
 Tom Rini <trini@konsulko.com>, 
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

Hi Yamada-san,

On Thu, Dec 14, 2023 at 7:12=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
> On Thu, Dec 14, 2023 at 1:03=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org>=
 wrote:
> > On Sun, Dec 10, 2023 at 1:31=E2=80=AFAM Geert Uytterhoeven <geert@linux=
-m68k.org> wrote:
> > > On Sat, Dec 9, 2023 at 4:29=E2=80=AFPM Laurent Pinchart
> > > <laurent.pinchart@ideasonboard.com> wrote:
> > > > On Sat, Dec 09, 2023 at 10:13:59PM +0900, Chen-Yu Tsai wrote:
> > > > > On Thu, Dec 7, 2023 at 11:38=E2=80=AFPM Laurent Pinchart
> > > > > <laurent.pinchart@ideasonboard.com> wrote:
> > > > > > On Thu, Dec 07, 2023 at 10:27:23PM +0800, Chen-Yu Tsai wrote:
> > > > > > > On Sun, Dec 03, 2023 at 05:34:01PM +0200, Laurent Pinchart wr=
ote:
> > > > > > > > On Fri, Dec 01, 2023 at 08:54:42PM -0700, Simon Glass wrote=
:
> > > > > > > > > Add a script which produces a Flat Image Tree (FIT), a si=
ngle file
> > > > > > > > > containing the built kernel and associated devicetree fil=
es.
> > > > > > > > > Compression defaults to gzip which gives a good balance o=
f size and
> > > > > > > > > performance.
> > > > > > > > >
> > > > > > > > > The files compress from about 86MB to 24MB using this app=
roach.
> > > > > > > > >
> > > > > > > > > The FIT can be used by bootloaders which support it, such=
 as U-Boot
> > > > > > > > > and Linuxboot. It permits automatic selection of the corr=
ect
> > > > > > > > > devicetree, matching the compatible string of the running=
 board with
> > > > > > > > > the closest compatible string in the FIT. There is no nee=
d for
> > > > > > > > > filenames or other workarounds.
> > > > > > > > >
> > > > > > > > > Add a 'make image.fit' build target for arm64, as well. U=
se
> > > > > > > > > FIT_COMPRESSION to select a different algorithm.
> > > > > > > > >
> > > > > > > > > The FIT can be examined using 'dumpimage -l'.
> > > > > > > > >
> > > > > > > > > This features requires pylibfdt (use 'pip install libfdt'=
). It also
> > > > > > > > > requires compression utilities for the algorithm being us=
ed. Supported
> > > > > > > > > compression options are the same as the Image.xxx files. =
For now there
> > > > > > > > > is no way to change the compression other than by editing=
 the rule for
> > > > > > > > > $(obj)/image.fit
> > > > > > > > >
> > > > > > > > > While FIT supports a ramdisk / initrd, no attempt is made=
 to support
> > > > > > > > > this here, since it must be built separately from the Lin=
ux build.
> > > > > > > >
> > > > > > > > FIT images are very useful, so I think this is a very welco=
me addition
> > > > > > > > to the kernel build system. It can get tricky though: given=
 the
> > > > > > > > versatile nature of FIT images, there can't be any
> > > > > > > > one-size-fits-them-all solution to build them, and striking=
 the right
> > > > > > > > balance between what makes sense for the kernel and the fea=
tures that
> > > > > > > > users may request will probably lead to bikeshedding. As we=
 all love
> > > > > > > > bikeshedding, I thought I would start selfishly, with a per=
sonal use
> > > > > > > > case :-) This isn't a yak-shaving request though, I don't s=
ee any reason
> > > > > > > > to delay merging this series.
> > > > > > > >
> > > > > > > > Have you envisioned building FIT images with a subset of DT=
Bs, or adding
> > > > > > > > DTBOs ? Both would be fairly trivial extensions to this scr=
ipt by
> > > > > > > > extending the supported command line arguments. It would pe=
rhaps be more
> > > > > > > > difficult to integrate in the kernel build system though. T=
his leads me
> > > > > > > > to a second question: would you consider merging extensions=
 to this
> > > > > > > > script if they are not used by the kernel build system, but=
 meant for
> > > > > > > > users who manually invoke the script ? More generally, is t=
he script
> > > > > > >
> > > > > > > We'd also be interested in some customization, though in a di=
fferent way.
> > > > > > > We imagine having a rule file that says X compatible string s=
hould map
> > > > > > > to A base DTB, plus B and C DTBO for the configuration sectio=
n. The base
> > > > > > > DTB would carry all common elements of some device, while the=
 DTBOs
> > > > > > > carry all the possible second source components, like differe=
nt display
> > > > > > > panels or MIPI cameras for instance. This could drastically r=
educe the
> > > > > > > size of FIT images in ChromeOS by deduplicating all the commo=
n stuff.
> > > > > >
> > > > > > Do you envision the "mapping" compatible string mapping to a co=
nfig
> > > > > > section in the FIT image, that would bundle the base DTB and th=
e DTBOs ?
> > > > >
> > > > > That's exactly the idea. The mapping compatible string could be u=
ntied
> > > > > from the base board's compatible string if needed (which we proba=
bly do).
> > > > >
> > > > > So something like:
> > > > >
> > > > > config {
> > > > >     config-1 {
> > > > >         compatible =3D "google,krane-sku0";
> > > > >         fdt =3D "krane-baseboard", "krane-sku0-overlay";
> > > > >     };
> > > > > };
> > > > >
> > > > > With "krane-sku0-overlay" being an overlay that holds the differe=
nces
> > > > > between the SKUs, in this case the display panel and MIPI camera =
(not
> > > > > upstreamed) that applies to SKU0 in particular.
> > > >
> > > > The kernel DT makefiles already contain information on what overlay=
s to
> > > > apply to what base boards, in order to test the overlays and produc=
e
> > > > "full" DTBs. Maybe that information could be leveraged to create th=
e
> > > > configurations in the FIT image ?
> > >
> > > Although the "full" DTBs created may only be a subset of all possible
> > > combinations (I believe Rob just started with creating one "full" DTB
> > > for each overlay, cfr. the additions I made in commit a09c3e105a20858=
0
> > > ("arm64: dts: renesas: Apply overlays to base dtbs")), that could
> > > definitely be a start.
> > >
> > > Now, since the kernel build system already creates "full" DTBs, does
> > > that mean that all of the base DTBs, overlays, and "full" DTBs will
> > > end up in the FIT image?
> >
> > I suppose we could add an option to the packing tool to be able to _not=
_
> > add the "full" DTBs if they can also be assembled with a base DTB and
> > overlays. Think of it as a firmware compatibility option: if the firmwa=
re
> > supports overlays, then you almost always want the deconstructed parts,
> > not the fully assembled ones. Vice versa.
> >
> > If we don't we could end up with two configurations that have the same
> > compatible string?
>
> Right.
>
> We would end up with such situations because applying
> an overlay does not change the compatible string.

That is correct.  Which is one of the reasons for not using overlays
for this, cfr. the details in my reply in the other thread
"Re: Proposal: FIT support for extension boards / overlays"
https://lore.kernel.org/all/CAMuHMdXQdMeXUOAAw5nDO4+q5_HFvUc86Wi8ykMwjUwPex=
6wvQ@mail.gmail.com/

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
