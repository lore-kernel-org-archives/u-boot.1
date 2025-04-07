Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DCC1C3601E
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 13:53:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C844382D0C;
	Mon,  7 Apr 2025 15:53:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="enW/rAr7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1145482DB4; Mon,  7 Apr 2025 15:53:19 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27C2A82CFD
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 15:53:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-72c7336ed99so1336281a34.0
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 06:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744033995; x=1744638795; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+A7pOUAtD3zpSI+1TsKGJlTGr9c21UzWR5r7ZbE8+eo=;
 b=enW/rAr7xtqIcoNumtXtxdiT0XNJNGTskDMqRwlSDP2ScTdt/yzbpJGDc2/k7R5G7U
 gkOV8tv1/eRxrG7t31qMQHovpXu9hDV6G2RJqObbSAm/OGqQoQA3wkYyQqX0VJIvcGsA
 kB9eJkZWW6YMSnBdqAm0vkIGgKlqMBsoHEJGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744033995; x=1744638795;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+A7pOUAtD3zpSI+1TsKGJlTGr9c21UzWR5r7ZbE8+eo=;
 b=cMXKw3plAqeNXh6F2sHEV7JWcD/vGHyv8fxUxct1tGi8fYo0scXvefoBQopoMNFGIm
 1RKv8JbnRdIIyO+Q36GJfQYK/yqi8Tx5+vud3CW5f2TmwMt0cGm9lg5o4gCyZTD5SXD4
 c8iV9i3pTgpxc8l6Bt2hhz/+m79vrq6vYBEU/AAcZ3XVJsOZbMOCBEBtFr6lf4KBKCx9
 oATUluwUjV8L3Dae+5/i/GRMAiWBOKBl+LW4BYh7mPnU2XrFpR2c6RA0n6SMZxG4QQ5S
 wLfeBQpuzgcO9Nj+F34girAbkaRFvcZewTi9NC4zoiqr9mtKstfpvZGtb9bH/r+DK2Md
 Rlrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUa5pOx3tUvlNN+XufZxfRDB4+NYyTpaXWFvklv53TRoVyrvSFjVieelyg+MWfJl1QqN0xBReQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzH91BXGFbT6PclBidkUkz2hxELwkJw5ShtZCb8SlaTx9jAzQhY
 8k0YgUx830ay2cNkXaMajcn9OdPz5MOZwFSmmsTsakkcRiWyo9nUAwNRMLsq9l8=
X-Gm-Gg: ASbGncuasqP3XQwGGwUaxCYb5UyT6vkIujhDBIjG/MTYPR5dOi09gMs5zpWbrOckCIS
 681r71LYQ8emB8Y2uGqLl7eoiv5bhKOd9GOeCfp0j7khvmj4WJ42p+G/W1n5lgsoZEPxEn+WKWr
 NHwLALNK3/5z1NGBimR+VpoLaZWiH4Xrd7zmGY5xLiWFnfvpFMnJhPC6xmmNJV1RDCQs4lplKoO
 yos6WlWO2qyZg+LYszvpD2ze6IbpuR6BMoeFow3CZK/6Tr5SKCXxNtiywUbri5ZWRyyTQ9/MM1E
 cLCUVybJ5QMwhPU8yS5piQyOm5XQ3/YrKupf6CwuRQI5BGGPSpS7B8+oSpzvTslAunP/waz3Vln
 PCpXs0Q==
X-Google-Smtp-Source: AGHT+IE2AQ1WTxUz98Ii33tODmUOgLe+AguZhcd7SdOGFotZ/3avf2Uc7nAapfpLkL3ID0osxdWebw==
X-Received: by 2002:a05:6830:3787:b0:72b:8297:e988 with SMTP id
 46e09a7af769-72e36973ac5mr9534266a34.25.1744033994718; 
 Mon, 07 Apr 2025 06:53:14 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6040c4ea8dbsm1751547eaf.18.2025.04.07.06.53.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 06:53:13 -0700 (PDT)
Date: Mon, 7 Apr 2025 07:53:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Jonas Karlman <jonas@kwiboo.se>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Albert Aribaud <albert.u.boot@aribaud.net>, Bin Meng <bmeng.cn@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Julien Masson <jmasson@baylibre.com>, Leo <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Peter Korsgaard <peter@korsgaard.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ramon Fried <rfried.dev@gmail.com>, Rick Chen <rick@andestech.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>
Subject: Re: [PATCH v5 00/29] pxe: Precursor series for supporting read_all()
 in extlinux / PXE
Message-ID: <20250407135310.GJ5495@bill-the-cat>
References: <CAFLszThrij_kGPdFcdJLoxJLpoZru=_M_vG4eVKwdPAqDfQJyg@mail.gmail.com>
 <2ad3b1c5-b6e7-47e2-b225-834b821cc5c4@kwiboo.se>
 <20250404224801.GV5495@bill-the-cat>
 <20250405144008.GY5495@bill-the-cat>
 <20250405144823.GZ5495@bill-the-cat>
 <CAFLszTiJct7mhx5_7iPzt_4m1BZL72pp1QML62b=7R3AgBn3fw@mail.gmail.com>
 <20250405232346.GB5495@bill-the-cat>
 <CAFLszTj4+GXkmEk3pq-iwJ=8CcJsSreJFKfqWsvW1LQKDz04_w@mail.gmail.com>
 <20250406224826.GF5495@bill-the-cat>
 <CAFLszTgc6UHvw6kRnGMkcbAMc1UDCX12HDSyW0YG+716Pq0Yzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mmA1fzxGYun+opJV"
Content-Disposition: inline
In-Reply-To: <CAFLszTgc6UHvw6kRnGMkcbAMc1UDCX12HDSyW0YG+716Pq0Yzw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--mmA1fzxGYun+opJV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 07, 2025 at 01:07:34PM +1200, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 7 Apr 2025 at 10:48, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Apr 07, 2025 at 09:12:32AM +1200, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Sun, 6 Apr 2025 at 11:23, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Sun, Apr 06, 2025 at 08:46:31AM +1200, Simon Glass wrote:
> > > > > (question for Heinrich below)
> > > > >
> > > > > Hi Tom,
> > > > >
> > > > > On Sun, 6 Apr 2025 at 02:48, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Sat, Apr 05, 2025 at 08:40:08AM -0600, Tom Rini wrote:
> > > > > > > On Fri, Apr 04, 2025 at 04:48:01PM -0600, Tom Rini wrote:
> > > > > > > > On Fri, Apr 04, 2025 at 11:32:12PM +0200, Jonas Karlman wro=
te:
> > > > > > > > > Hi Simon,
> > > > > > > > >
> > > > > > > > > On 2025-04-04 00:30, Simon Glass wrote:
> > > > > > > > > > Hi Jonas,
> > > > > > > > > >
> > > > > > > > > > On Fri, 4 Apr 2025 at 09:57, Jonas Karlman <jonas@kwibo=
o.se> wrote:
> > > > > > > > > >>
> > > > > > > > > >> Hi Tom and Simon,
> > > > > > > > > >>
> > > > > > > > > >> On 2025-03-19 00:21, Tom Rini wrote:
> > > > > > > > > >>> On Wed, 05 Mar 2025 17:24:54 -0700, Simon Glass wrote:
> > > > > > > > > >>>
> > > > > > > > > >>>> This series includes some patches related to allowin=
g read_all() to be
> > > > > > > > > >>>> used with the extlinux / PXE bootmeths.
> > > > > > > > > >>>>
> > > > > > > > > >>>> These patches were split out from the stb4 series, s=
ince it will need to
> > > > > > > > > >>>> have additional patches for LWIP, to avoid breaking =
PXE booting when
> > > > > > > > > >>>> LWIP is used.
> > > > > > > > > >>>>
> > > > > > > > > >>>> [...]
> > > > > > > > > >>>
> > > > > > > > > >>> Applied to u-boot/next, thanks!
> > > > > > > > > >>
> > > > > > > > > >> This series broke booting a compressed arm64 defconfig=
 Linux kernel
> > > > > > > > > >> (without module loading) due to changes in decompressi=
on buffer length.
> > > > > > > > > >>
> > > > > > > > > >> My arm64 defconfig kernel (Image.gz) is ~24 MiB compre=
ssed and ~85 MiB
> > > > > > > > > >> uncompressed.
> > > > > > > > > >>
> > > > > > > > > >> Before this series the decompression buffer was 10x th=
e kernel_comp_size
> > > > > > > > > >> and now it is instead limited by the SYS_BOOTM_LEN Kco=
nfig symbol.
> > > > > > > > > >>
> > > > > > > > > >> A broken boot using current next branch:
> > > > > > > > > >>
> > > > > > > > > >>   Retrieving file: /Image.gz
> > > > > > > > > >>   Retrieving file: /initramfs.cpio.gz
> > > > > > > > > >>   append: earlycon
> > > > > > > > > >>   cmd 'booti' states 1f1f addr_img '0x02080000' conf_r=
amdisk '0x06000000:394d3c' conf_fdt '3df16350' images 000000003ffe53a0
> > > > > > > > > >>      kernel data at 0x02080000, len =3D 0x00000000 (0)
> > > > > > > > > >>   load 2080000 start 2080000 len 0 ep 0 os 5 comp 1
> > > > > > > > > >>   find_other type 2 os 5
> > > > > > > > > >>   ## Flattened Device Tree blob at 3df16350
> > > > > > > > > >>      Booting using the fdt blob at 0x3df16350
> > > > > > > > > >>   Working FDT set to 3df16350
> > > > > > > > > >>   load_os load 8000000 image_start 2080000 image_len 2=
000000
> > > > > > > > > >>      Uncompressing Kernel Image to 8000000
> > > > > > > > > >>   Error: inflate() returned -5
> > > > > > > > > >>   Image too large: increase CONFIG_SYS_BOOTM_LEN
> > > > > > > > > >>   Must RESET board to recover
> > > > > > > > > >>   Resetting the board...
> > > > > > > > > >>
> > > > > > > > > >> Changing SYS_BOOTM_LEN from default 64 MiB to 128 MiB =
fixed the boot:
> > > > > > > > > >>
> > > > > > > > > >>   Retrieving file: /Image.gz
> > > > > > > > > >>   Retrieving file: /initramfs.cpio.gz
> > > > > > > > > >>   append: earlycon
> > > > > > > > > >>   cmd 'booti' states 1f1f addr_img '0x02080000' conf_r=
amdisk '0x06000000:394d3c' conf_fdt '3df16430' images 000000003ffe5480
> > > > > > > > > >>      kernel data at 0x02080000, len =3D 0x00000000 (0)
> > > > > > > > > >>   load 2080000 start 2080000 len 0 ep 0 os 5 comp 1
> > > > > > > > > >>   find_other type 2 os 5
> > > > > > > > > >>   ## Flattened Device Tree blob at 3df16430
> > > > > > > > > >>      Booting using the fdt blob at 0x3df16430
> > > > > > > > > >>   Working FDT set to 3df16430
> > > > > > > > > >>   load_os load 8000000 image_start 2080000 image_len 2=
000000
> > > > > > > > > >>      Uncompressing Kernel Image to 8000000
> > > > > > > > > >>      kernel loaded at 0x08000000, end =3D 0x0d3b5a00
> > > > > > > > > >>      Loading Ramdisk to 3cb51000, end 3cee5d3c ... OK
> > > > > > > > > >>      Loading Device Tree to 000000003cb3f000, end 0000=
00003cb509df ... OK
> > > > > > > > > >>   Working FDT set to 3cb3f000
> > > > > > > > > >>
> > > > > > > > > >>   Starting kernel ...
> > > > > > > > > >>
> > > > > > > > > >> Do we need to increase the default SYS_BOOTM_LEN for A=
RM64 now?
> > > > > > > > > >
> > > > > > > > > > Are you using the 'booti' command? Can you post a bit m=
ore console
> > > > > > > > > > output or a script here as it isn't clear what boot com=
mand you are
> > > > > > > > > > using? For now I'm going to assume booti
> > > > > > > > >
> > > > > > > > > Above was using an extlinux.conf with bootstd, not using =
the booti cmd.
> > > > > > > > >
> > > > > > > > > Use of booti cmd is not affected as it continue to use a =
10x multiple
> > > > > > > > > of the kernel_comp_size env var for buffer size.
> > > > > > > > >
> > > > > > > > > The change this series introduced was instead of the 10x =
multiple of
> > > > > > > > > kernel_comp_size now use SYS_BOOTM_LEN for buffer size (3=
20 vs 32 MiB).
> > > > > > > > >
> > > > > > > > > And because cmd/booti.c was not converted there is now tw=
o different
> > > > > > > > > handling of this decompression buffer size.
> > > > > > > > >
> > > > > > > > > If the change to now use SYS_BOOTM_LEN was intended this =
need to be
> > > > > > > > > changed as it has mostly been irrelevant for booting Linu=
x on AArch64
> > > > > > > > > boards prior to this series.
> > > > > > > >
> > > > > > > > We need to clean things up such that the path which is usin=
g 10x
> > > > > > > > multiple (and we lmb_alloc an area iirc) is used in all cas=
es.
> > > > > > >
> > > > > > > Looking at the code this morning, I was confusing this with w=
hat we do
> > > > > > > for compressed FIT images, oops.
> > > > > >
> > > > > > Ugh. Simon, can you go and fix this whole problem? Both do_boot=
z and
> > > > > > do_booti have non-trivial amounts of code that's missed by chan=
ging from
> > > > > > calling do_bootX() to bootX_run().
> > > > >
> > > > > For do_bootz() I believe the current code is correct. It does call
> > > > > bootz_start() and then doesn't call it again when bootz_run() sta=
rts.
> > > > > It looks like you have taken my Ubuntu test so perhaps I can add a
> > > > > bootz test for another board in my lab.
> > > > >
> > > > > For do_booti(), the code in booti_start() is used for the
> > > > > non-compressed case, so I believe it is still needed and that boo=
tm
> > > > > doesn't currently honour 'Image' relocation when using an uncompr=
essed
> > > > > image. But then there is the issue of SYS_BOOTM_LEN, below.
> > > > >
> > > > > bootm_load_os() has code for ARM at the end, which I suspect need=
s to
> > > > > run on RISC-V too, in case the image needs to be relocated. Marek
> > > > > added this 7 years ago[1] so it predates RISC-V and Heinrich perh=
aps
> > > > > didn't notice it when adding his support , if it is actually need=
ed.
> > > > >
> > > > > SYS_BOOTM_LEN is a 'last bastion' security feature to avoid people
> > > > > loading images that wrap around memory, etc. I could put bootm_len
> > > > > into struct bootm_info so that a 10x value can be used for the bo=
oti
> > > > > case.
> >
> > I'm not sure any of the above is 100% correct. My very quick look was
> > that it seems like if we want to have the command part of bootX be able
> > to be equivalently called via API, more of most of the commands needs to
> > be moved out of cmd/cmdX.c and to boot/bootX.c and put in to some state.
>=20
> Yes, my intent has been to move code out of commands into boot/ and
> have things work as before.

Then none of this should be in a "pxe" series, and you should have
been removing a bunch more code out of the command part of the file.

> Also don't forget that booting a FIT with a compressed boot kernel did
> not work before my series. The series was largely written to fix bugs
> (in one place) rather that just to refactor for the fun it.

I'm not sure which FIT use case you're talking about here exactly and
when it got broken (because if it was in use already, someone would have
reported it).

> > > > > Tom, we also have the issue that you haven't taken the rest of th=
e PXE
> > > > > series (due to the lwip case), so our trees are out of sync in th=
is
> > > > > area. It would really help if you could take that series, and aga=
in, I
> > > > > am happy to do the lwip case once it is landed.
> >
> > Your further PXE rework is irrelevant to this discussion. Except in that
> > it points out there's still further changes that could break other
> > things even more.
>=20
> Yes, any change in untested code has the potential to create bugs. I
> do the best I can, but I could use a little more support in this
> effort.

And the best way to get support for that is to slow down and make
smaller more easily testable series. There's yet another bug in this
series too that Svyatoslav has or will post about shortly.

> > > > > So for now, if people agree, I can do a small series to use a
> > > > > different SYS_BOOTM_LEN for the booti command and perhaps add RIS=
C-V
> > > > > as above.
> >
> > Well, no, that sounds like a step in the wrong direction. I'd like to
> > instead restore the expected behavior, and then perhaps we could clean
> > it up such that the compressed case for booti-Images works like FIT
> > images where we lmb allocate a larger area if needed.
>=20
> Yes, restoring the 10x decompression size is what I am talking about
> here. Is there anything else?

Functional wise, the being reported now issue Svyatoslav found too.

Implementation wise, yes, I don't want to refactor and re-wrtie a bunch
of this as the first step. The first step should be just what's needed
to move the working functionality out of cmd/bootX.c and in to
boot/bootX.c and let people verify things haven't regressed. Then some
rework can be reviewed on its own.

> > > > > Later, I could continue the boot-unification effort, e.g. delete =
the
> > > > > booti_start() function. and incorporate the uncompressed case into
> > > > > bootm code.
> > > >
> > > > I'm not sure your reading of the situation is right. I'm more incli=
ned
> > > > to revert this merge rather than take on more rework in the area.
> > >
> > > Well that would be a pretty poor show. No one else has spent effort
> > > trying to clean up and rationalise this code in the last 10 years, so
> > > far as I can see. This is in -next so there is plenty of time to
> > > resolve any issues.
> >
> > Yes, things haven't broken in 10 years. This is why I don't value "tidy
> > up and refactor" in and of itself. Massive reworks then require a long
> > time to check all of the corner cases. This has been true of many of the
> > massive reworks you've done over the years.
>=20
> Well, do you want to be able to boot without CMDLINE, or not?

It's an interesting long term goal. But since there's always some
distribution or another that ships with each release we do, not having
functional regressions is more important than speed of new features.
Being able to practically disable the command line has been a feature
for forever. Being able to literally has implications for both security
and end user rights that need to be considered too.

> > > I believe my reading of the situation is right, but if you disagree
> > > with some of it, please indicate which.
> >
> > Your answer is not "Oh, I'll go understand what I broke and restore
> > expected behavior". It's "you should take more of my big rework and I'll
> > rework this area even more". That is not convincing that we won't have
> > v2025.07 broken here.
>=20
> You only took half of the series, remember. We are talking about a
> tiny corner case here, with no test coverage. I'm offering to fix the
> case that has been reported. I can also even add a test for it.

It wasn't half of the series. I didn't take more because it was either
the stuff that broke other functionality or because it wasn't used until
some further series from you. It's not a tiny corner case. A test case
is nice, sure, but we'll never have 100% test coverage and need physical
testing too. Which most people only have time for around releases. Which
is why we need to go slow. Which again is why you need to split up your
changes more and expect them to go slower. So there's time to test
things.

--=20
Tom

--mmA1fzxGYun+opJV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfz2L8ACgkQFHw5/5Y0
tywTrgwAsJH0pXJ3DugOjZCgdcjOC5uH6stJNZrhj5/GtUwpxe06QQp+Rf8uGS1w
BZnx7oSZJytxsx3hcrN0VDse96TqweiRVoqvQEE4K1NY2fV0g2DlUn/z1gc170fY
Zn6G+MCWatGzBZz7rrQvLjq6EQ0TRq1/QiRmIxFb9WIU82+8Mx8TDSfKrJZ3vUPL
peiCfZjsOwo3TkR5p8Fv4T1cq7YHPYUqqSJdJ2pFVvnvKSm1vb7R8DRSNe+qwbbD
I1ICqwz2jZLPLhBVLR5TmHP2Q7MMTzWMpmD1FGycGkc7EnbTpQfwJ21Qb69na0Rn
kZL32xIB920wpQEXZFM97xb9ga98ewmGxqgkLdOWrdeeBcL+zUmkZkH6ftzcWSC8
0iisk194zVhgOfhNx/uTz2LnT6ul/8gSIV/avMsMDRTNX3RPWPmYbVHCme1uTpfo
OookoXaz9yLy6K0Gl+u1OPkSiswZ9czIwKku2HLI3xSxR3yKla67JdEP7sxoa8On
EQrpvWq3
=7nkH
-----END PGP SIGNATURE-----

--mmA1fzxGYun+opJV--
