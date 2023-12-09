Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF35C10F04
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 16:31:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EDEF87215;
	Sat,  9 Dec 2023 17:31:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E5D0874B7; Sat,  9 Dec 2023 17:31:19 +0100 (CET)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com
 [209.85.128.172])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29F7B8717E
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 17:31:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux-m68k.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=geert.uytterhoeven@gmail.com
Received: by mail-yw1-f172.google.com with SMTP id
 00721157ae682-5d7a47d06eeso29556077b3.1
 for <u-boot@lists.denx.de>; Sat, 09 Dec 2023 08:31:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702139476; x=1702744276;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U39lWSDPg+0DYbB9pP+NhpXAadyQEt+SNRQFJQQg5DE=;
 b=P0aVXJ542Ay5dxWj2gt2Veyom2npj86G6I5Q9fXV69Jov0ChmuRezrtcJUzcyklwAL
 hCZe6mBdVIzrQmA08XepJj+Ipw6DziXUxrjUrFdE5SrweVS1TDNiZ8wREgwIsxx9ZInr
 DrGIcpeUeqnRb0fmuQ8LbPFubG6svZAy7RJJiZzUUtxPK4z0+RaQo09tw9+0mLQ3Ov0s
 rD7lZ2lehuEGSwkSueu7lyL6A6x+ZT08pIMW9hhj5t7UPVkmUaD5qkogfGMwRt3z2V4s
 FGymIFIZLn4Wy7x5qzEU8i1MCKUG9CGaswofTz6qAsvdYLShuihpvexaHQYgmigp3x7U
 my8Q==
X-Gm-Message-State: AOJu0YzzTqymkjE7sjCdX22xHqUQgUjZehjU3dWvf6H2dmZrkX6RfVAO
 pokySWfpM7IEEziaTd1aDNM6juo5RoGjBQ==
X-Google-Smtp-Source: AGHT+IFA/JQml+7+nKTnW1OvFi8v3QFBS3NxdA4WWd1uB6NBpJ3re+JbbrsrZDA3hUfDVUPZJbsGUg==
X-Received: by 2002:a81:8582:0:b0:5d7:f8da:c190 with SMTP id
 v124-20020a818582000000b005d7f8dac190mr1385244ywf.92.1702139475593; 
 Sat, 09 Dec 2023 08:31:15 -0800 (PST)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com.
 [209.85.128.174]) by smtp.gmail.com with ESMTPSA id
 l5-20020a0de205000000b005d37278f973sm1565900ywe.36.2023.12.09.08.31.15
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Dec 2023 08:31:15 -0800 (PST)
Received: by mail-yw1-f174.google.com with SMTP id
 00721157ae682-5d7a47d06eeso29555937b3.1
 for <u-boot@lists.denx.de>; Sat, 09 Dec 2023 08:31:15 -0800 (PST)
X-Received: by 2002:a0d:dd53:0:b0:5d1:1bab:5902 with SMTP id
 g80-20020a0ddd53000000b005d11bab5902mr1316761ywe.15.1702139474962; Sat, 09
 Dec 2023 08:31:14 -0800 (PST)
MIME-Version: 1.0
References: <20231202035511.487946-1-sjg@chromium.org>
 <20231202035511.487946-3-sjg@chromium.org>
 <20231203153401.GV8402@pendragon.ideasonboard.com>
 <20231207142723.GA3187877@google.com>
 <20231207143814.GD15521@pendragon.ideasonboard.com>
 <CAGXv+5Go_0pEVAOLQmRCc_a9-YUtZEmBfXtMuBupX_nb9iqwbw@mail.gmail.com>
 <20231209152946.GC13421@pendragon.ideasonboard.com>
In-Reply-To: <20231209152946.GC13421@pendragon.ideasonboard.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 9 Dec 2023 17:31:03 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVMZs6mnwWBgFwktO=8o=QzROv60cfZe085MhD6HxQjpQ@mail.gmail.com>
Message-ID: <CAMuHMdVMZs6mnwWBgFwktO=8o=QzROv60cfZe085MhD6HxQjpQ@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] arm64: boot: Support Flat Image Tree
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>, Simon Glass <sjg@chromium.org>, 
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

Hi Laurent,

On Sat, Dec 9, 2023 at 4:29=E2=80=AFPM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Sat, Dec 09, 2023 at 10:13:59PM +0900, Chen-Yu Tsai wrote:
> > On Thu, Dec 7, 2023 at 11:38=E2=80=AFPM Laurent Pinchart
> > <laurent.pinchart@ideasonboard.com> wrote:
> > > On Thu, Dec 07, 2023 at 10:27:23PM +0800, Chen-Yu Tsai wrote:
> > > > On Sun, Dec 03, 2023 at 05:34:01PM +0200, Laurent Pinchart wrote:
> > > > > On Fri, Dec 01, 2023 at 08:54:42PM -0700, Simon Glass wrote:
> > > > > > Add a script which produces a Flat Image Tree (FIT), a single f=
ile
> > > > > > containing the built kernel and associated devicetree files.
> > > > > > Compression defaults to gzip which gives a good balance of size=
 and
> > > > > > performance.
> > > > > >
> > > > > > The files compress from about 86MB to 24MB using this approach.
> > > > > >
> > > > > > The FIT can be used by bootloaders which support it, such as U-=
Boot
> > > > > > and Linuxboot. It permits automatic selection of the correct
> > > > > > devicetree, matching the compatible string of the running board=
 with
> > > > > > the closest compatible string in the FIT. There is no need for
> > > > > > filenames or other workarounds.
> > > > > >
> > > > > > Add a 'make image.fit' build target for arm64, as well. Use
> > > > > > FIT_COMPRESSION to select a different algorithm.
> > > > > >
> > > > > > The FIT can be examined using 'dumpimage -l'.
> > > > > >
> > > > > > This features requires pylibfdt (use 'pip install libfdt'). It =
also
> > > > > > requires compression utilities for the algorithm being used. Su=
pported
> > > > > > compression options are the same as the Image.xxx files. For no=
w there
> > > > > > is no way to change the compression other than by editing the r=
ule for
> > > > > > $(obj)/image.fit
> > > > > >
> > > > > > While FIT supports a ramdisk / initrd, no attempt is made to su=
pport
> > > > > > this here, since it must be built separately from the Linux bui=
ld.
> > > > >
> > > > > FIT images are very useful, so I think this is a very welcome add=
ition
> > > > > to the kernel build system. It can get tricky though: given the
> > > > > versatile nature of FIT images, there can't be any
> > > > > one-size-fits-them-all solution to build them, and striking the r=
ight
> > > > > balance between what makes sense for the kernel and the features =
that
> > > > > users may request will probably lead to bikeshedding. As we all l=
ove
> > > > > bikeshedding, I thought I would start selfishly, with a personal =
use
> > > > > case :-) This isn't a yak-shaving request though, I don't see any=
 reason
> > > > > to delay merging this series.
> > > > >
> > > > > Have you envisioned building FIT images with a subset of DTBs, or=
 adding
> > > > > DTBOs ? Both would be fairly trivial extensions to this script by
> > > > > extending the supported command line arguments. It would perhaps =
be more
> > > > > difficult to integrate in the kernel build system though. This le=
ads me
> > > > > to a second question: would you consider merging extensions to th=
is
> > > > > script if they are not used by the kernel build system, but meant=
 for
> > > > > users who manually invoke the script ? More generally, is the scr=
ipt
> > > >
> > > > We'd also be interested in some customization, though in a differen=
t way.
> > > > We imagine having a rule file that says X compatible string should =
map
> > > > to A base DTB, plus B and C DTBO for the configuration section. The=
 base
> > > > DTB would carry all common elements of some device, while the DTBOs
> > > > carry all the possible second source components, like different dis=
play
> > > > panels or MIPI cameras for instance. This could drastically reduce =
the
> > > > size of FIT images in ChromeOS by deduplicating all the common stuf=
f.
> > >
> > > Do you envision the "mapping" compatible string mapping to a config
> > > section in the FIT image, that would bundle the base DTB and the DTBO=
s ?
> >
> > That's exactly the idea. The mapping compatible string could be untied
> > from the base board's compatible string if needed (which we probably do=
).
> >
> > So something like:
> >
> > config {
> >     config-1 {
> >         compatible =3D "google,krane-sku0";
> >         fdt =3D "krane-baseboard", "krane-sku0-overlay";
> >     };
> > };
> >
> > With "krane-sku0-overlay" being an overlay that holds the differences
> > between the SKUs, in this case the display panel and MIPI camera (not
> > upstreamed) that applies to SKU0 in particular.
>
> The kernel DT makefiles already contain information on what overlays to
> apply to what base boards, in order to test the overlays and produce
> "full" DTBs. Maybe that information could be leveraged to create the
> configurations in the FIT image ?

Although the "full" DTBs created may only be a subset of all possible
combinations (I believe Rob just started with creating one "full" DTB
for each overlay, cfr. the additions I made in commit a09c3e105a208580
("arm64: dts: renesas: Apply overlays to base dtbs")), that could
definitely be a start.

Now, since the kernel build system already creates "full" DTBs, does
that mean that all of the base DTBs, overlays, and "full" DTBs will
end up in the FIT image?

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
