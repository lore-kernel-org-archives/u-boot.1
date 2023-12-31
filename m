Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 375A3C3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 31 Dec 2023 12:45:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8772987084;
	Sun, 31 Dec 2023 13:45:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QHauh33F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5671B87646; Sun, 31 Dec 2023 13:45:15 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C355287021
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 13:45:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-680a9796b38so7055206d6.0
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 04:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704026711; x=1704631511; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LH3uSTA1DYfbUuVA+eLGd6cEZ9qWF+YwUxJYyH+Pi2A=;
 b=QHauh33F1JysB3gdslt6/kJRqkoFQwE/PEIb5+/t5yOxSTXBiDhwdwWJJM0M0GgRpZ
 oxHt1Ei03HHkuZDkYSVvlrv/wh+QrQkWhwIEkRWgpqmNrF+tb4CNqp0jeKGrji9MLMOh
 NRSq6Ty2WMM4p+kagsYyE6r6XLnSN2bv22HWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704026711; x=1704631511;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LH3uSTA1DYfbUuVA+eLGd6cEZ9qWF+YwUxJYyH+Pi2A=;
 b=LbdiirFtNLE3msZgfvz2++YrmpHd3GwHnHnGniaIcrd72suRnKeCW07i7tXCrL6z9b
 Vet15TfoLJxMjbaKKcpVTebQoxSQrzjXtoyT/+7vwpMG1nBMociU/WWhgjLHsSj1RQRt
 TKb8c16a/TbtNCbVFxIM4aUaNf+s0epDJ8yPicb7csvLuYynQBe8H5ow7rm+xbZCxGVf
 ZtZb9kP81qP606yNSAJyzQrATCwLDYXGMGHoHA9Q8rgRQeerxhqnTu7SDWtkYw0ff794
 PQy+QbH61Nv8NGyI94KeOvFUaosCdbhNg6Em13XIvNIFLACeuaMYsDLdHEni5mV+27jT
 T/lg==
X-Gm-Message-State: AOJu0Yxh2xuvhDKNHWAKa+vD/8lDMvtk5rSkNY9A3LcZLhkP2D8lEbPm
 xdz0wsHXl1E2kAzcAf5qwqOLMQ2sfoKZLjy0kByVabinh5oe
X-Google-Smtp-Source: AGHT+IHvvlFZ0bnVGFyyLnBfBIScquedekZWKmiS2UHJDdDKySP6UKvwFrzNU0HUFPDv/WU3ULTep7DL4ROtkGvImyM=
X-Received: by 2002:a0c:e844:0:b0:67f:a0a6:4cfa with SMTP id
 l4-20020a0ce844000000b0067fa0a64cfamr15100680qvo.112.1704026711573; Sun, 31
 Dec 2023 04:45:11 -0800 (PST)
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
In-Reply-To: <CALeDE9MfEd=xjwekR+oVPuWNR7TBPCMU6mc+Z7ig7tc1nhKu_Q@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 31 Dec 2023 05:45:00 -0700
Message-ID: <CAFLszTj0MQGUBcNqVTLZuOL=1YBD2pqL2+P8oLKqc5PnLq3GdA@mail.gmail.com>
Subject: Re: [PATCH 0/9] dts: Move to SoC-specific build rules
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Sumit Garg <sumit.garg@linaro.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>, 
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

-Scott as it is bouncing

Hi,

On Fri, Dec 29, 2023 at 9:46=E2=80=AFAM Peter Robinson <pbrobinson@gmail.co=
m> wrote:
>
> On Fri, Dec 29, 2023 at 12:23=E2=80=AFAM Tom Rini <trini@konsulko.com> wr=
ote:
> >
> > On Thu, Dec 28, 2023 at 07:48:08PM +0000, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Thu, Dec 28, 2023 at 3:40=E2=80=AFPM Tom Rini <trini@konsulko.com>=
 wrote:
> > > >
> > > > On Thu, Dec 28, 2023 at 03:09:40PM +0000, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Thu, Dec 28, 2023 at 2:23=E2=80=AFPM Tom Rini <trini@konsulko.=
com> wrote:
> > > > > >
> > > > > > On Thu, Dec 28, 2023 at 01:37:07PM +0000, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Wed, Dec 27, 2023 at 1:21=E2=80=AFPM Tom Rini <trini@konsu=
lko.com> wrote:
> > > > > > > >
> > > > > > > > On Wed, Dec 27, 2023 at 08:23:56AM +0000, Simon Glass wrote=
:
> > > > > > > >
> > > > > > > > > U-Boot builds devicetree binaries from its source tree. A=
s part of the
> > > > > > > > > Kconfig conversion, the Makefiles were updated to align w=
ith how this
> > > > > > > > > is done in Linux: a single target for each SoC is used to=
 build all the
> > > > > > > > > .dtb files for that SoC.
> > > > > > > > >
> > > > > > > > > Since then, the Makefiles have devolved in some cases, re=
sulting in
> > > > > > > > > lots of target-specific build rules. Also Linux has moved=
 to using
> > > > > > > > > subdirectories for each vendor.
> > > > > > > > >
> > > > > > > > > Recent work aims to allow U-Boot to directly use devicetr=
ee files from
> > > > > > > > > Linux. This would be easier if the directory structure we=
re the same.
> > > > > > > > > Another recent discussion involved dropping the build rul=
es altogether.
> > > > > > > > >
> > > > > > > > > This series makes a start at cleaning up some of the buil=
d rules, to
> > > > > > > > > reduce the amount of code and make it easier to add new b=
oards for the
> > > > > > > > > same SoC.
> > > > > > > > >
> > > > > > > > > One issue is that the ARCH_xxx Kconfig options between U-=
Boot and Linux
> > > > > > > > > are not always the same. Given the large number of SoCs a=
nd boards
> > > > > > > > > supported by U-Boot, it would be useful to align these wh=
ere possible.
> > > > > > > >
> > > > > > > > I don't know why we should start with this now, and further=
 not being on
> > > > > > > > top of Sumit's series to remove our duplicate dts files. An=
d that's
> > > > > > > > where we can have the conversation about for which cases it=
 even makes
> > > > > > > > sense to build all of the dts files for a given SoC.
> > > > > > >
> > > > > > > This is a completely different series - there are no conflict=
s with
> > > > > > > Sumit's series so it can be applied before or after it.
> > > > > > >
> > > > > > > My goal here is to clean up our build rules, rather than just=
 throwing
> > > > > > > them all away, for reasons we have discussed previously. I fi=
led [1]
> > > > > > > to track that.
> > > > > >
> > > > > > Yes, I'm saying we shouldn't be doing anything this series does=
 until
> > > > > > after Sumit's series has landed. Along with the fact that I don=
't like
> > > > > > what's going on in this series.
> > > > >
> > > > > This seems to again be the disagreement over whether a single DT
> > > > > should be build for each board, or all the DTs for an SoC?
> > > >
> > > > It's about the disagreement on what we should be building, and what=
 that
> > > > infrastructure looks like. I do not like adding extra rules for
> > > > "clarity" because they don't make things clearer, they lead to the
> > > > unclear mess we have today getting worse. Most instructions are _no=
t_
> > > > "now take this dtb and this binary and .." but just "take this bina=
ry",
> > > > because we already have the rules and logic to ensure we build the
> > > > required dtbs. I also don't like the parts of this series that amou=
nt
> > > > to deck shuffling when we should just be taking the chairs away. Th=
ere's
> > > > just not nor will there be a case for omap3/4/5 platforms of "chang=
e the
> > > > dtb", so building more is pointless. For other SoCs, there may be s=
ome
> > > > cases of "this could have been just a DT change", like
> > > > rock5b-rk3588_defconfig / rock5a-rk3588s_defconfig could share a bo=
ard
> > > > dir, but the configs are different and the dts are different, so I =
don't
> > > > know that you could really just swap the dtbs.
> > >
> > > It is true that we have a different defconfig for each board, but IMO
> > > that is not good. It is an artifact of the way the build system works=
.
> > > IMO Kconfig should be used to define sensible defaults so that the
> > > defconfigs are nearly empty. Perhaps config fragments can be part of
> > > the mix, if we can agree on [1].
> > >
> > > But if we let this genie out of the bottle, it will be impossible to
> > > put back in. The devicetree should control the hardware in U-Boot and
> > > it should be possible to use the same U-Boot proper on all boards
> > > which use the same SoC.
> >
> > We've never been past the point where a few examples of closely related
> > boards can re-use the same U-Boot build and just change the device tree=
.
> >
> > It's going to be very SoC specific if we can ever do things like that,
> > and it will also likely in turn become a question of where did the
> > tricky bits that U-Boot used to do get shoved instead. You're not going
> > to combine board/beagle/beagle/beagle.c and board/ti/omap3evm/evm.c (an=
d
> > ignoring all of the other omap3 boards) and get one binary that works o=
n
> > both, and just uses DT. Let alone that no one wants to do that work.
> >
> > You've mentioned Rockchip before as maybe a better example, but
> > https://patchwork.ozlabs.org/project/uboot/list/?series=3D383579&state=
=3D* was
> > leading me to think that no, there's too much "this is what THIS
> > hardware does" that means that no, there's going to be hardware
> > variation that one must just handle in C. Or get more and new bindings
> > accepted upstream to try and make that be data driven, and also possibl=
y
> > have to deal with "that's policy, not hardware" type arguments and so
> > forth.

Oh wow yes that is crazy! But you can always check the compatible
string if really necessary. It would be nice to use a sysinfo driver
for this sort of thing. I should just be a full-time code reviewer...

>
> Related I've seen issues with nearly identical rockchips devices that
> use different memory chips that as a result need different U-Boot
> builds because the early boot part needs to initialise a completely
> different set of memory and the two different sets of rules aren't
> detectable at run-time nor are they even small enough to fit into
> smem.

Some of the differences are real/important, like memory settings, some
are not. For boards with enough SRAM that SPL can use DM/DT, we can
deal with these.

But even if SPL does need to be custom, that is better than having a
full, separate U-Boot for every single board.

>
> > > [1] https://patchwork.ozlabs.org/user/todo/uboot/?series=3D380278
> >
> > Note that patchwork is annoying here and that for a series you've
> > assigned, you need to click on a patch in it, then the series link agai=
n
> > to get:
> > https://patchwork.ozlabs.org/project/uboot/list/?series=3D380278
> > which works for everyone. And append '&state=3D*' so that archive links
> > will still show it later once it's been accepted or superseded or what
> > have you.

OK, yes, I should have noticed that sorry.

Regards,
Simon
