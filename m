Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 516F9C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 15:19:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5E0482F42;
	Mon,  7 Apr 2025 17:19:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iGpGV1+s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AC2782F5D; Mon,  7 Apr 2025 17:19:23 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7FB782ED0
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 17:19:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-abbd96bef64so866071866b.3
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 08:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744039160; x=1744643960; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bfO92gmEgfkwshJGwrlJ+HZ6BbvyPR8mXk+TTAmM9zw=;
 b=iGpGV1+sMsCMvju0dFvfjnks05hKQCl3nfxPUCKob7mLRgXNdT291h15F/DArLlBWI
 nyJeRoK0fZ865h92yTIVJd2OJb5kRcWCOQmHVipTRoc6F/GDIs6XdLYLvZJNJhloBZCe
 hsl2ATtW9pghKOKKNl/Fzwa3rjb0+vV6qujnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744039160; x=1744643960;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bfO92gmEgfkwshJGwrlJ+HZ6BbvyPR8mXk+TTAmM9zw=;
 b=aTzfcG/o8ZgAN1KG0AY5gAh+vF9L8A+Z1rwiAOGsN3Q3tGWsOs0WxfHkqZ7HuRQkVi
 vecnVXYKPipbskLqI++pIuSjA7SNeODMoPjrsDdPWCRFSvj2JgIHI1kBmUN2TThUNBpR
 /TCsWzuEvAA2EZwdnQ8eK5nKsMDT2g+bnCDMtBENjumHbPUc0wVKlAjSoS8Ztky+q6RK
 m4HcOsja3ky9APKf/A/1jpJedsi6M2jUx4Y7N1O4b4G3kiDM1dw0+Ji5bc1S6DDWFWss
 LD07nfREvi+mz9yK4dAS0eOFeIB9ShJjx0QzwlpzMUel/Ozc1cDgsb6Kq0tsmcNM77/Q
 S47A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4PP/W4EHYyve2UUug1vk+FltVqNYzcz/q2tCX6MV/toX6S7itcNRnJLJbOp5/8X+e5k44y7k=@lists.denx.de
X-Gm-Message-State: AOJu0YxLoyI1CaNIqxAkk4f4o3kupvZGN8pRc+icGmHVJeHvBnZNFUKM
 fqlhOpXHUSle1N05HztmXASKAj/cg5+gKkfEOno6v3LfT7qG3iBpCVBFFH7l8K1+OJanBOJSq4p
 bTksLC0JeXYS+r7Jzp8UodU69aFUsTgKQ6Ehm
X-Gm-Gg: ASbGncv6SC5I3W2c71C418Td97eMgRxpjin+ElI54XJyvkZ51d0Rqg1XGPcXc7S6H1y
 Ku4OI1mIeoOYsU+JAn0x0H+oiji7gkbubqBmQytHrn4HOdm1QNYUm7kDkvGiFLV8mx/zZd0d3Bb
 qjwPQnEh/cUz2m/Zrc8dHb+Tv/wVNxrRq5JhZjBeF1dA4Sz8D0mmnEqGb854icEs4yDCbULw==
X-Google-Smtp-Source: AGHT+IFVcl/TA9fkbSM9GOkYNDJPR1HACBt1OiIV5d5xftz675PMaYLTmXug7gcFSRBL/IsVfX/5JD0EP5sNhWf6iaA=
X-Received: by 2002:a17:907:988:b0:ac3:c020:25e9 with SMTP id
 a640c23a62f3a-ac7d194a064mr1163642666b.34.1744039159893; Mon, 07 Apr 2025
 08:19:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszThrij_kGPdFcdJLoxJLpoZru=_M_vG4eVKwdPAqDfQJyg@mail.gmail.com>
 <2ad3b1c5-b6e7-47e2-b225-834b821cc5c4@kwiboo.se>
 <20250404224801.GV5495@bill-the-cat>
 <20250405144008.GY5495@bill-the-cat> <20250405144823.GZ5495@bill-the-cat>
 <CAFLszTiJct7mhx5_7iPzt_4m1BZL72pp1QML62b=7R3AgBn3fw@mail.gmail.com>
 <20250405232346.GB5495@bill-the-cat>
 <CAFLszTj4+GXkmEk3pq-iwJ=8CcJsSreJFKfqWsvW1LQKDz04_w@mail.gmail.com>
 <20250406224826.GF5495@bill-the-cat>
 <CAFLszTgc6UHvw6kRnGMkcbAMc1UDCX12HDSyW0YG+716Pq0Yzw@mail.gmail.com>
 <20250407135310.GJ5495@bill-the-cat>
 <12fd7570-c5f6-4752-b0a3-162d6467c5d6@gmail.com>
In-Reply-To: <12fd7570-c5f6-4752-b0a3-162d6467c5d6@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 7 Apr 2025 09:19:05 -0600
X-Gm-Features: ATxdqUH29yTE3VQa540zP8bd_ARVposIClU-mHtgW50dwvIiUKBNiidHyODq1Pk
Message-ID: <CAFLszThAA8qbRS_iEQbAb57=DFG9MomvfjcYznhKLmT8w6SQZw@mail.gmail.com>
Subject: Re: [PATCH v5 00/29] pxe: Precursor series for supporting read_all()
 in extlinux / PXE
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Jonas Karlman <jonas@kwiboo.se>, 
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Adriano Cordova <adrianox@gmail.com>, 
 Albert Aribaud <albert.u.boot@aribaud.net>, Bin Meng <bmeng.cn@gmail.com>, 
 Christian Marangi <ansuelsmth@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Joe Hershberger <joe.hershberger@ni.com>, Julien Masson <jmasson@baylibre.com>,
 Leo <ycliang@andestech.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Peter Korsgaard <peter@korsgaard.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Ramon Fried <rfried.dev@gmail.com>, 
 Rick Chen <rick@andestech.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
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

Hi Svyatoslav,

On Mon, 7 Apr 2025 at 08:43, Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
>
> 07.04.25 4:53 =D0=BF=D0=BF, Tom Rini:
> > On Mon, Apr 07, 2025 at 01:07:34PM +1200, Simon Glass wrote:
> >> Hi Tom,
> >>
> >> On Mon, 7 Apr 2025 at 10:48, Tom Rini <trini@konsulko.com> wrote:
> >>> On Mon, Apr 07, 2025 at 09:12:32AM +1200, Simon Glass wrote:
> >>>> Hi Tom,
> >>>>
> >>>> On Sun, 6 Apr 2025 at 11:23, Tom Rini <trini@konsulko.com> wrote:
> >>>>> On Sun, Apr 06, 2025 at 08:46:31AM +1200, Simon Glass wrote:
> >>>>>> (question for Heinrich below)
> >>>>>>
> >>>>>> Hi Tom,
> >>>>>>
> >>>>>> On Sun, 6 Apr 2025 at 02:48, Tom Rini <trini@konsulko.com> wrote:
> >>>>>>> On Sat, Apr 05, 2025 at 08:40:08AM -0600, Tom Rini wrote:
> >>>>>>>> On Fri, Apr 04, 2025 at 04:48:01PM -0600, Tom Rini wrote:
> >>>>>>>>> On Fri, Apr 04, 2025 at 11:32:12PM +0200, Jonas Karlman wrote:
> >>>>>>>>>> Hi Simon,
> >>>>>>>>>>
> >>>>>>>>>> On 2025-04-04 00:30, Simon Glass wrote:
> >>>>>>>>>>> Hi Jonas,
> >>>>>>>>>>>
> >>>>>>>>>>> On Fri, 4 Apr 2025 at 09:57, Jonas Karlman <jonas@kwiboo.se> =
wrote:
> >>>>>>>>>>>> Hi Tom and Simon,
> >>>>>>>>>>>>
> >>>>>>>>>>>> On 2025-03-19 00:21, Tom Rini wrote:
> >>>>>>>>>>>>> On Wed, 05 Mar 2025 17:24:54 -0700, Simon Glass wrote:
> >>>>>>>>>>>>>
> >>>>>>>>>>>>>> This series includes some patches related to allowing read=
_all() to be
> >>>>>>>>>>>>>> used with the extlinux / PXE bootmeths.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> These patches were split out from the stb4 series, since i=
t will need to
> >>>>>>>>>>>>>> have additional patches for LWIP, to avoid breaking PXE bo=
oting when
> >>>>>>>>>>>>>> LWIP is used.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> [...]
> >>>>>>>>>>>>> Applied to u-boot/next, thanks!
> >>>>>>>>>>>> This series broke booting a compressed arm64 defconfig Linux=
 kernel
> >>>>>>>>>>>> (without module loading) due to changes in decompression buf=
fer length.
> >>>>>>>>>>>>
> >>>>>>>>>>>> My arm64 defconfig kernel (Image.gz) is ~24 MiB compressed a=
nd ~85 MiB
> >>>>>>>>>>>> uncompressed.
> >>>>>>>>>>>>
> >>>>>>>>>>>> Before this series the decompression buffer was 10x the kern=
el_comp_size
> >>>>>>>>>>>> and now it is instead limited by the SYS_BOOTM_LEN Kconfig s=
ymbol.
> >>>>>>>>>>>>
> >>>>>>>>>>>> A broken boot using current next branch:
> >>>>>>>>>>>>
> >>>>>>>>>>>>    Retrieving file: /Image.gz
> >>>>>>>>>>>>    Retrieving file: /initramfs.cpio.gz
> >>>>>>>>>>>>    append: earlycon
> >>>>>>>>>>>>    cmd 'booti' states 1f1f addr_img '0x02080000' conf_ramdis=
k '0x06000000:394d3c' conf_fdt '3df16350' images 000000003ffe53a0
> >>>>>>>>>>>>       kernel data at 0x02080000, len =3D 0x00000000 (0)
> >>>>>>>>>>>>    load 2080000 start 2080000 len 0 ep 0 os 5 comp 1
> >>>>>>>>>>>>    find_other type 2 os 5
> >>>>>>>>>>>>    ## Flattened Device Tree blob at 3df16350
> >>>>>>>>>>>>       Booting using the fdt blob at 0x3df16350
> >>>>>>>>>>>>    Working FDT set to 3df16350
> >>>>>>>>>>>>    load_os load 8000000 image_start 2080000 image_len 200000=
0
> >>>>>>>>>>>>       Uncompressing Kernel Image to 8000000
> >>>>>>>>>>>>    Error: inflate() returned -5
> >>>>>>>>>>>>    Image too large: increase CONFIG_SYS_BOOTM_LEN
> >>>>>>>>>>>>    Must RESET board to recover
> >>>>>>>>>>>>    Resetting the board...
> >>>>>>>>>>>>
> >>>>>>>>>>>> Changing SYS_BOOTM_LEN from default 64 MiB to 128 MiB fixed =
the boot:
> >>>>>>>>>>>>
> >>>>>>>>>>>>    Retrieving file: /Image.gz
> >>>>>>>>>>>>    Retrieving file: /initramfs.cpio.gz
> >>>>>>>>>>>>    append: earlycon
> >>>>>>>>>>>>    cmd 'booti' states 1f1f addr_img '0x02080000' conf_ramdis=
k '0x06000000:394d3c' conf_fdt '3df16430' images 000000003ffe5480
> >>>>>>>>>>>>       kernel data at 0x02080000, len =3D 0x00000000 (0)
> >>>>>>>>>>>>    load 2080000 start 2080000 len 0 ep 0 os 5 comp 1
> >>>>>>>>>>>>    find_other type 2 os 5
> >>>>>>>>>>>>    ## Flattened Device Tree blob at 3df16430
> >>>>>>>>>>>>       Booting using the fdt blob at 0x3df16430
> >>>>>>>>>>>>    Working FDT set to 3df16430
> >>>>>>>>>>>>    load_os load 8000000 image_start 2080000 image_len 200000=
0
> >>>>>>>>>>>>       Uncompressing Kernel Image to 8000000
> >>>>>>>>>>>>       kernel loaded at 0x08000000, end =3D 0x0d3b5a00
> >>>>>>>>>>>>       Loading Ramdisk to 3cb51000, end 3cee5d3c ... OK
> >>>>>>>>>>>>       Loading Device Tree to 000000003cb3f000, end 000000003=
cb509df ... OK
> >>>>>>>>>>>>    Working FDT set to 3cb3f000
> >>>>>>>>>>>>
> >>>>>>>>>>>>    Starting kernel ...
> >>>>>>>>>>>>
> >>>>>>>>>>>> Do we need to increase the default SYS_BOOTM_LEN for ARM64 n=
ow?
> >>>>>>>>>>> Are you using the 'booti' command? Can you post a bit more co=
nsole
> >>>>>>>>>>> output or a script here as it isn't clear what boot command y=
ou are
> >>>>>>>>>>> using? For now I'm going to assume booti
> >>>>>>>>>> Above was using an extlinux.conf with bootstd, not using the b=
ooti cmd.
> >>>>>>>>>>
> >>>>>>>>>> Use of booti cmd is not affected as it continue to use a 10x m=
ultiple
> >>>>>>>>>> of the kernel_comp_size env var for buffer size.
> >>>>>>>>>>
> >>>>>>>>>> The change this series introduced was instead of the 10x multi=
ple of
> >>>>>>>>>> kernel_comp_size now use SYS_BOOTM_LEN for buffer size (320 vs=
 32 MiB).
> >>>>>>>>>>
> >>>>>>>>>> And because cmd/booti.c was not converted there is now two dif=
ferent
> >>>>>>>>>> handling of this decompression buffer size.
> >>>>>>>>>>
> >>>>>>>>>> If the change to now use SYS_BOOTM_LEN was intended this need =
to be
> >>>>>>>>>> changed as it has mostly been irrelevant for booting Linux on =
AArch64
> >>>>>>>>>> boards prior to this series.
> >>>>>>>>> We need to clean things up such that the path which is using 10=
x
> >>>>>>>>> multiple (and we lmb_alloc an area iirc) is used in all cases.
> >>>>>>>> Looking at the code this morning, I was confusing this with what=
 we do
> >>>>>>>> for compressed FIT images, oops.
> >>>>>>> Ugh. Simon, can you go and fix this whole problem? Both do_bootz =
and
> >>>>>>> do_booti have non-trivial amounts of code that's missed by changi=
ng from
> >>>>>>> calling do_bootX() to bootX_run().
> >>>>>> For do_bootz() I believe the current code is correct. It does call
> >>>>>> bootz_start() and then doesn't call it again when bootz_run() star=
ts.
> >>>>>> It looks like you have taken my Ubuntu test so perhaps I can add a
> >>>>>> bootz test for another board in my lab.
> >>>>>>
> >>>>>> For do_booti(), the code in booti_start() is used for the
> >>>>>> non-compressed case, so I believe it is still needed and that boot=
m
> >>>>>> doesn't currently honour 'Image' relocation when using an uncompre=
ssed
> >>>>>> image. But then there is the issue of SYS_BOOTM_LEN, below.
> >>>>>>
> >>>>>> bootm_load_os() has code for ARM at the end, which I suspect needs=
 to
> >>>>>> run on RISC-V too, in case the image needs to be relocated. Marek
> >>>>>> added this 7 years ago[1] so it predates RISC-V and Heinrich perha=
ps
> >>>>>> didn't notice it when adding his support , if it is actually neede=
d.
> >>>>>>
> >>>>>> SYS_BOOTM_LEN is a 'last bastion' security feature to avoid people
> >>>>>> loading images that wrap around memory, etc. I could put bootm_len
> >>>>>> into struct bootm_info so that a 10x value can be used for the boo=
ti
> >>>>>> case.
> >>> I'm not sure any of the above is 100% correct. My very quick look was
> >>> that it seems like if we want to have the command part of bootX be ab=
le
> >>> to be equivalently called via API, more of most of the commands needs=
 to
> >>> be moved out of cmd/cmdX.c and to boot/bootX.c and put in to some sta=
te.
> >> Yes, my intent has been to move code out of commands into boot/ and
> >> have things work as before.
> > Then none of this should be in a "pxe" series, and you should have
> > been removing a bunch more code out of the command part of the file.
> >
> >> Also don't forget that booting a FIT with a compressed boot kernel did
> >> not work before my series. The series was largely written to fix bugs
> >> (in one place) rather that just to refactor for the fun it.
> > I'm not sure which FIT use case you're talking about here exactly and
> > when it got broken (because if it was in use already, someone would hav=
e
> > reported it).
> >
> >>>>>> Tom, we also have the issue that you haven't taken the rest of the=
 PXE
> >>>>>> series (due to the lwip case), so our trees are out of sync in thi=
s
> >>>>>> area. It would really help if you could take that series, and agai=
n, I
> >>>>>> am happy to do the lwip case once it is landed.
> >>> Your further PXE rework is irrelevant to this discussion. Except in t=
hat
> >>> it points out there's still further changes that could break other
> >>> things even more.
> >> Yes, any change in untested code has the potential to create bugs. I
> >> do the best I can, but I could use a little more support in this
> >> effort.
> > And the best way to get support for that is to slow down and make
> > smaller more easily testable series. There's yet another bug in this
> > series too that Svyatoslav has or will post about shortly.
> >
> >>>>>> So for now, if people agree, I can do a small series to use a
> >>>>>> different SYS_BOOTM_LEN for the booti command and perhaps add RISC=
-V
> >>>>>> as above.
> >>> Well, no, that sounds like a step in the wrong direction. I'd like to
> >>> instead restore the expected behavior, and then perhaps we could clea=
n
> >>> it up such that the compressed case for booti-Images works like FIT
> >>> images where we lmb allocate a larger area if needed.
> >> Yes, restoring the 10x decompression size is what I am talking about
> >> here. Is there anything else?
> > Functional wise, the being reported now issue Svyatoslav found too.
> >
> > Implementation wise, yes, I don't want to refactor and re-wrtie a bunch
> > of this as the first step. The first step should be just what's needed
> > to move the working functionality out of cmd/bootX.c and in to
> > boot/bootX.c and let people verify things haven't regressed. Then some
> > rework can be reviewed on its own.
> >
> >>>>>> Later, I could continue the boot-unification effort, e.g. delete t=
he
> >>>>>> booti_start() function. and incorporate the uncompressed case into
> >>>>>> bootm code.
> >>>>> I'm not sure your reading of the situation is right. I'm more incli=
ned
> >>>>> to revert this merge rather than take on more rework in the area.
> >>>> Well that would be a pretty poor show. No one else has spent effort
> >>>> trying to clean up and rationalise this code in the last 10 years, s=
o
> >>>> far as I can see. This is in -next so there is plenty of time to
> >>>> resolve any issues.
> >>> Yes, things haven't broken in 10 years. This is why I don't value "ti=
dy
> >>> up and refactor" in and of itself. Massive reworks then require a lon=
g
> >>> time to check all of the corner cases. This has been true of many of =
the
> >>> massive reworks you've done over the years.
> >> Well, do you want to be able to boot without CMDLINE, or not?
> > It's an interesting long term goal. But since there's always some
> > distribution or another that ships with each release we do, not having
> > functional regressions is more important than speed of new features.
> > Being able to practically disable the command line has been a feature
> > for forever. Being able to literally has implications for both security
> > and end user rights that need to be considered too.
> >
> >>>> I believe my reading of the situation is right, but if you disagree
> >>>> with some of it, please indicate which.
> >>> Your answer is not "Oh, I'll go understand what I broke and restore
> >>> expected behavior". It's "you should take more of my big rework and I=
'll
> >>> rework this area even more". That is not convincing that we won't hav=
e
> >>> v2025.07 broken here.
> >> You only took half of the series, remember. We are talking about a
> >> tiny corner case here, with no test coverage. I'm offering to fix the
> >> case that has been reported. I can also even add a test for it.
> > It wasn't half of the series. I didn't take more because it was either
> > the stuff that broke other functionality or because it wasn't used unti=
l
> > some further series from you. It's not a tiny corner case. A test case
> > is nice, sure, but we'll never have 100% test coverage and need physica=
l
> > testing too. Which most people only have time for around releases. Whic=
h
> > is why we need to go slow. Which again is why you need to split up your
> > changes more and expect them to go slower. So there's time to test
> > things.
> Hello there! I have recently faced an issue with booting Linux on my
> LG P895 (Tegra30 smartphone). It has installed PostmarketOS with extlinux
> bootmethod and boots perfectly fine with current master but fails with ne=
xt.
>
> Here is fragment of the boot log
>
>    Retrieving file: /Image
>    Retrieving file: /initramfs
>    append: rw gpt
>    Retrieving file: /tegra30-lg-p895.dtb
>    ERROR: booting os 'Invalid OS' (0) is not supported
>    Boot failed (err=3D-14)
>
> I have debugged a bit and so far reverting:
>
> e2e87b84 "boot: pxe: Refactor label_run_boot() to avoid cmdline"
> feb8d7fd "pxe_utils: Simplify default fdt in label_run_boot()"
> b1340802 "boot: pxe: Use bootm_...() functions where possible"
>
> Fixed booting for my device.

Thanks for the report and debugging. I'll take a look. I suspect the
global 'images' is somehow not being updated.

Regards,
Simon
