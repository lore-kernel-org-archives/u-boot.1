Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC560C46CD2
	for <u-boot@archiver.kernel.org>; Tue,  2 Jan 2024 14:07:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76DC087823;
	Tue,  2 Jan 2024 15:06:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="idoIW6kf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2141887823; Tue,  2 Jan 2024 15:06:51 +0100 (CET)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EFAB8783D
 for <u-boot@lists.denx.de>; Tue,  2 Jan 2024 15:06:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-67ff241c2bcso57502046d6.1
 for <u-boot@lists.denx.de>; Tue, 02 Jan 2024 06:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704204407; x=1704809207; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6iEL2SnNU7h56Btek9ja+Yee3I1xokTiPSAMq7yuvDc=;
 b=idoIW6kfcvVAzEgzCHx3WPpZZKwu7LRKb81tDeB0zRtw14xKRAXgTeH+ltOAb2yfdp
 /FNonCaNMvG9G/tR4luQOeoxAG+QpsEGvdru9+YFSJGGtVoD7rhMhvceZnX8HTdOWbGR
 5laUkhlWKetsLTQWDBKzGxwFdq6GnWduRfxzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704204407; x=1704809207;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6iEL2SnNU7h56Btek9ja+Yee3I1xokTiPSAMq7yuvDc=;
 b=GpG3CrqNFqyyOUquOt24SGLUKAo5pfH4YDuiTgJheeBlDuSY8oWMSP0xw125H5UV2/
 mQG3v4FF3hk6tN4eUbvVgA4t4eIEpLJbsfO6dLvgfaituhwpHLUlFjbBUimkePXDneNz
 CNXDmsSt3vhOqOabJkewZkLcGWrAdpduPfd2nD2sWQ0wZvHS3MS/p9QjMhY/yg71QAX5
 acMG/F5mtJvc0Mld1+VNe/yn6SCl7EEvBKweYF60tA7DibzHGOsXYsdNGK3jN6wMbgBY
 dgwWBViSWW5Mk5SlY4NEpEKePkFp8Kx96fA4Wnq32gjUFT6fCUV/jeAF6k/HPZ46WhLC
 a0eQ==
X-Gm-Message-State: AOJu0YyE7kO3RMdkwWWMTncfs+883ICy927GCh5V8V3Kh4uSu6HpcncS
 T64HPAAUj87zfEyJDbkpDxHWW3LmT8KzxIfi29/j2std7yis7WYeVtrAmMc=
X-Google-Smtp-Source: AGHT+IFfCZp0nNRVtokbdF2cBOS9zIR+0FRFBpmIrh0dx9G0lExy0sPcitltyLFKOXGI+pVTfJYOTvhtHxlQBC8vZYM=
X-Received: by 2002:ad4:5ca9:0:b0:67f:4cf9:c9f6 with SMTP id
 q9-20020ad45ca9000000b0067f4cf9c9f6mr25749579qvh.50.1704204407397; Tue, 02
 Jan 2024 06:06:47 -0800 (PST)
MIME-Version: 1.0
References: <20231227082405.2202246-1-sjg@chromium.org>
 <20231227132156.GQ2652760@bill-the-cat>
 <CAFLszThBrAVSH2jYxhxFSETqr4za+BqjZBBjLaDokc1ZdrXXRw@mail.gmail.com>
 <20231228142311.GD2652760@bill-the-cat>
 <CAFLszTghB1ZObpxUe+afAp2zzQOfn2M9198ofsgnyW9cseG2Ew@mail.gmail.com>
 <20231228154019.GH2652760@bill-the-cat>
 <CAFLszTgZfAHATieERE1x8hhoFHpYDK4Vq4=VVmQapKEn63diyA@mail.gmail.com>
 <20231228204425.GQ2652760@bill-the-cat>
 <CALeDE9MfEd=xjwekR+oVPuWNR7TBPCMU6mc+Z7ig7tc1nhKu_Q@mail.gmail.com>
 <CAFLszTj0MQGUBcNqVTLZuOL=1YBD2pqL2+P8oLKqc5PnLq3GdA@mail.gmail.com>
 <20231231140127.GA2652760@bill-the-cat>
In-Reply-To: <20231231140127.GA2652760@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 2 Jan 2024 07:06:36 -0700
Message-ID: <CAFLszTj0vdkZ+ch5-crygw7i3Mj8DO5=4naOWAwYMFNqGe0WWA@mail.gmail.com>
Subject: Re: [PATCH 0/9] dts: Move to SoC-specific build rules
To: Tom Rini <trini@konsulko.com>
Cc: Peter Robinson <pbrobinson@gmail.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Sumit Garg <sumit.garg@linaro.org>, Albert Aribaud <albert.u.boot@aribaud.net>,
 =?UTF-8?Q?Andreas_Bie=C3=9Fmann?= <andreas@biessmann.org>, 
 Michal Simek <michal.simek@amd.com>, Michal Simek <monstr@monstr.eu>, 
 Minkyu Kang <mk7.kang@samsung.com>, Thomas Chou <thomas@wytron.com.tw>
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

Hi Tom,

On Sun, Dec 31, 2023 at 7:01=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Sun, Dec 31, 2023 at 05:45:00AM -0700, Simon Glass wrote:
> > -Scott as it is bouncing
> >
> > Hi,
> >
> > On Fri, Dec 29, 2023 at 9:46=E2=80=AFAM Peter Robinson <pbrobinson@gmai=
l.com> wrote:
> > >
> > > On Fri, Dec 29, 2023 at 12:23=E2=80=AFAM Tom Rini <trini@konsulko.com=
> wrote:
> > > >
> > > > On Thu, Dec 28, 2023 at 07:48:08PM +0000, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Thu, Dec 28, 2023 at 3:40=E2=80=AFPM Tom Rini <trini@konsulko.=
com> wrote:
> > > > > >
> > > > > > On Thu, Dec 28, 2023 at 03:09:40PM +0000, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Thu, Dec 28, 2023 at 2:23=E2=80=AFPM Tom Rini <trini@konsu=
lko.com> wrote:
> > > > > > > >
> > > > > > > > On Thu, Dec 28, 2023 at 01:37:07PM +0000, Simon Glass wrote=
:
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > On Wed, Dec 27, 2023 at 1:21=E2=80=AFPM Tom Rini <trini@k=
onsulko.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Wed, Dec 27, 2023 at 08:23:56AM +0000, Simon Glass w=
rote:
> > > > > > > > > >
> > > > > > > > > > > U-Boot builds devicetree binaries from its source tre=
e. As part of the
> > > > > > > > > > > Kconfig conversion, the Makefiles were updated to ali=
gn with how this
> > > > > > > > > > > is done in Linux: a single target for each SoC is use=
d to build all the
> > > > > > > > > > > .dtb files for that SoC.
> > > > > > > > > > >
> > > > > > > > > > > Since then, the Makefiles have devolved in some cases=
, resulting in
> > > > > > > > > > > lots of target-specific build rules. Also Linux has m=
oved to using
> > > > > > > > > > > subdirectories for each vendor.
> > > > > > > > > > >
> > > > > > > > > > > Recent work aims to allow U-Boot to directly use devi=
cetree files from
> > > > > > > > > > > Linux. This would be easier if the directory structur=
e were the same.
> > > > > > > > > > > Another recent discussion involved dropping the build=
 rules altogether.
> > > > > > > > > > >
> > > > > > > > > > > This series makes a start at cleaning up some of the =
build rules, to
> > > > > > > > > > > reduce the amount of code and make it easier to add n=
ew boards for the
> > > > > > > > > > > same SoC.
> > > > > > > > > > >
> > > > > > > > > > > One issue is that the ARCH_xxx Kconfig options betwee=
n U-Boot and Linux
> > > > > > > > > > > are not always the same. Given the large number of So=
Cs and boards
> > > > > > > > > > > supported by U-Boot, it would be useful to align thes=
e where possible.
> > > > > > > > > >
> > > > > > > > > > I don't know why we should start with this now, and fur=
ther not being on
> > > > > > > > > > top of Sumit's series to remove our duplicate dts files=
. And that's
> > > > > > > > > > where we can have the conversation about for which case=
s it even makes
> > > > > > > > > > sense to build all of the dts files for a given SoC.
> > > > > > > > >
> > > > > > > > > This is a completely different series - there are no conf=
licts with
> > > > > > > > > Sumit's series so it can be applied before or after it.
> > > > > > > > >
> > > > > > > > > My goal here is to clean up our build rules, rather than =
just throwing
> > > > > > > > > them all away, for reasons we have discussed previously. =
I filed [1]
> > > > > > > > > to track that.
> > > > > > > >
> > > > > > > > Yes, I'm saying we shouldn't be doing anything this series =
does until
> > > > > > > > after Sumit's series has landed. Along with the fact that I=
 don't like
> > > > > > > > what's going on in this series.
> > > > > > >
> > > > > > > This seems to again be the disagreement over whether a single=
 DT
> > > > > > > should be build for each board, or all the DTs for an SoC?
> > > > > >
> > > > > > It's about the disagreement on what we should be building, and =
what that
> > > > > > infrastructure looks like. I do not like adding extra rules for
> > > > > > "clarity" because they don't make things clearer, they lead to =
the
> > > > > > unclear mess we have today getting worse. Most instructions are=
 _not_
> > > > > > "now take this dtb and this binary and .." but just "take this =
binary",
> > > > > > because we already have the rules and logic to ensure we build =
the
> > > > > > required dtbs. I also don't like the parts of this series that =
amount
> > > > > > to deck shuffling when we should just be taking the chairs away=
. There's
> > > > > > just not nor will there be a case for omap3/4/5 platforms of "c=
hange the
> > > > > > dtb", so building more is pointless. For other SoCs, there may =
be some
> > > > > > cases of "this could have been just a DT change", like
> > > > > > rock5b-rk3588_defconfig / rock5a-rk3588s_defconfig could share =
a board
> > > > > > dir, but the configs are different and the dts are different, s=
o I don't
> > > > > > know that you could really just swap the dtbs.
> > > > >
> > > > > It is true that we have a different defconfig for each board, but=
 IMO
> > > > > that is not good. It is an artifact of the way the build system w=
orks.
> > > > > IMO Kconfig should be used to define sensible defaults so that th=
e
> > > > > defconfigs are nearly empty. Perhaps config fragments can be part=
 of
> > > > > the mix, if we can agree on [1].
> > > > >
> > > > > But if we let this genie out of the bottle, it will be impossible=
 to
> > > > > put back in. The devicetree should control the hardware in U-Boot=
 and
> > > > > it should be possible to use the same U-Boot proper on all boards
> > > > > which use the same SoC.
> > > >
> > > > We've never been past the point where a few examples of closely rel=
ated
> > > > boards can re-use the same U-Boot build and just change the device =
tree.
> > > >
> > > > It's going to be very SoC specific if we can ever do things like th=
at,
> > > > and it will also likely in turn become a question of where did the
> > > > tricky bits that U-Boot used to do get shoved instead. You're not g=
oing
> > > > to combine board/beagle/beagle/beagle.c and board/ti/omap3evm/evm.c=
 (and
> > > > ignoring all of the other omap3 boards) and get one binary that wor=
ks on
> > > > both, and just uses DT. Let alone that no one wants to do that work=
.
> > > >
> > > > You've mentioned Rockchip before as maybe a better example, but
> > > > https://patchwork.ozlabs.org/project/uboot/list/?series=3D383579&st=
ate=3D* was
> > > > leading me to think that no, there's too much "this is what THIS
> > > > hardware does" that means that no, there's going to be hardware
> > > > variation that one must just handle in C. Or get more and new bindi=
ngs
> > > > accepted upstream to try and make that be data driven, and also pos=
sibly
> > > > have to deal with "that's policy, not hardware" type arguments and =
so
> > > > forth.
> >
> > Oh wow yes that is crazy! But you can always check the compatible
> > string if really necessary. It would be nice to use a sysinfo driver
> > for this sort of thing. I should just be a full-time code reviewer...
> >
> > >
> > > Related I've seen issues with nearly identical rockchips devices that
> > > use different memory chips that as a result need different U-Boot
> > > builds because the early boot part needs to initialise a completely
> > > different set of memory and the two different sets of rules aren't
> > > detectable at run-time nor are they even small enough to fit into
> > > smem.
> >
> > Some of the differences are real/important, like memory settings, some
> > are not. For boards with enough SRAM that SPL can use DM/DT, we can
> > deal with these.
> >
> > But even if SPL does need to be custom, that is better than having a
> > full, separate U-Boot for every single board.
>
> I'm not sure that's a use case anyone else has or wants, and I disagree
> that building a unique SPL and then more generic U-Boot is a win, in
> practical and effort terms.

Think about firmware update where you could have an update that
supports all rk3399 boards, rather than 110 separate (and duplicate)
firmware updates.

> The only win I see there is it would be part
> of what I've said before about how I do not want the "XPL" series you've
> talked about before, but instead think Yamada-san was right in hindsight
> and in short we should have "fooboard_defconfig",
> "fooboard_spl_defconfig" and "fooboard_tpl_defconfig" and you make each
> config and build each config by itself. In that context, yes, you could
> have barvend-fooboard_rev1_spl_defconfig,
> barvend-fooboard_rev2_spl_defconfig and barvend-fooboard_defconfig to
> get a more generic U-Boot build.  But nothing so much like an OS kernel
> because we care about binary size and rarely does the OS vendor (but
> some production cases in turn do), so outside of SoC-vendor where
> showing off features is more important than size, most of the time, will
> you see an actual use for SoC-generic U-Boot build.

We'll see. The size cost for making things generic across an SoC is
likely very small, particularly if the settings are in the DT where
they belong. But I do accept we are not seeing the pressure yet.

For XPL, there are pros and cons, but I thought we talked about that
at the time and agreed that the need for Kconfig dependencies between
phases makes having separate defconfigs too painful?

Regards,
Simon
