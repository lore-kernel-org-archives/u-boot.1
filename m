Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE34DC36002
	for <u-boot@archiver.kernel.org>; Sun,  6 Apr 2025 22:48:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2883182BE3;
	Mon,  7 Apr 2025 00:48:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bSEMsSoL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B79782C2B; Mon,  7 Apr 2025 00:48:34 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6074982B8E
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 00:48:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-72bc3987a05so2077516a34.1
 for <u-boot@lists.denx.de>; Sun, 06 Apr 2025 15:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743979710; x=1744584510; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xzr61l4dnvRsJxZ2HYplIM5Ospm37C5fQFY4G9mJyL0=;
 b=bSEMsSoLX1r3YIapCj+JZtjqQY+kawkKhol+al04HiUm5OJ8RXcFXDmjGhCzAq1Qjr
 RB86a1uGU8HKBJOvqZO2I+ytqjX80xembwUz3VBjZ3HYukgXsep1xMMMIiXi3nEozbZr
 c1PqXLYE6VXhE7znd2x8p5kwYKdznWRhEi9ws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743979710; x=1744584510;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xzr61l4dnvRsJxZ2HYplIM5Ospm37C5fQFY4G9mJyL0=;
 b=SD9zflfRnpjJ6FIbfZnwL+HhVSTlQt9dk/cIsUFcBMqmIRGk8whepQUCz4N0/mIP6X
 XxHryFsotiWo7I4miyEMcs7lY6MfGnagRqTFbZpSVyllY0m8jT4709c5D1ZFlgpPwgcw
 edvUW5dOMOhWi1sOrqAQjI7e81uoeuB8uCtiehuUSSOBBYSuFvH01VHrUAS4HpwGpAhy
 aWGjQwhxCRnsY01SIixfh8835ahOv+awHriiKzN33rNtO4abg0zv44Cd5c/KHHw4IIFi
 WcqokKvYB2d+cV3RcI48lr2zdua/aE5jtAdczjlSXmJJO7Ov9jdcohbNw3K2P8/7dmTQ
 N8bw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgMUd4GFf1F1rDWigFBxl5bHwvrtQeg85ZTrSxgUivfmjawSGxpdm4BStGdyxPDf5pYP6ivS8=@lists.denx.de
X-Gm-Message-State: AOJu0YxHa86fzddxV8ItquhI285YtrGj7qWmmxL+JEHpceroq7/otI4m
 WFI16AOtnJkXbhE1ZynaxvP3qfo/xKdAyCBn7Y2fxgEcUXizbrxn9zOuxlWxpFE=
X-Gm-Gg: ASbGnctVWeOvMEcUtaSBL1yQ4qA2L0xCegDXqgu6FMPoTeCEVhZ5A9BFbFA8h3RtWet
 2AJ+W+gzjcjTxgYnU6gal/nI5o5hGIw+COT1jpgjdNIPjMfjJHI7mROi4BLHLBMmk4qzAc17Ner
 E6cWiPr+bTEEA7dbLHC2mZYBORhwBwHcfDfNgyHQcw/ZBiqyUV5FK//WYca/HclKDhgVmAwXpJ9
 Le1U7ZGRMEBW/bHsd3DyV53cy+2WLQ8itJduUXNnAiYR+WQwyzpN2sYCLr2MZOjU+mi4vegoWDD
 CkQ0WbPidypZcVQ667Q9yeQ7VR7WcWi3F2N+QXBfTtx9VoYcS5EJAUp1utu//4wSSCD8+xBSoRb
 jxXTKHgjar1buNCaF
X-Google-Smtp-Source: AGHT+IFAXxBp65c7/1+rAiuXpTqTYI46U+6BmR3LZsRe1fDj+lAwEL8QkbOoAE1zfKd3BcSl37vT0g==
X-Received: by 2002:a05:6830:b82:b0:723:7853:8791 with SMTP id
 46e09a7af769-72e36c25075mr5701287a34.0.1743979709963; 
 Sun, 06 Apr 2025 15:48:29 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72e305b66fcsm1575972a34.65.2025.04.06.15.48.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Apr 2025 15:48:29 -0700 (PDT)
Date: Sun, 6 Apr 2025 16:48:26 -0600
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
Message-ID: <20250406224826.GF5495@bill-the-cat>
References: <174234008117.1788726.14383009154862416750.b4-ty@konsulko.com>
 <10a57d25-d484-4903-8f25-e373c451bc21@kwiboo.se>
 <CAFLszThrij_kGPdFcdJLoxJLpoZru=_M_vG4eVKwdPAqDfQJyg@mail.gmail.com>
 <2ad3b1c5-b6e7-47e2-b225-834b821cc5c4@kwiboo.se>
 <20250404224801.GV5495@bill-the-cat>
 <20250405144008.GY5495@bill-the-cat>
 <20250405144823.GZ5495@bill-the-cat>
 <CAFLszTiJct7mhx5_7iPzt_4m1BZL72pp1QML62b=7R3AgBn3fw@mail.gmail.com>
 <20250405232346.GB5495@bill-the-cat>
 <CAFLszTj4+GXkmEk3pq-iwJ=8CcJsSreJFKfqWsvW1LQKDz04_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qNNxrGTzJS20IH0n"
Content-Disposition: inline
In-Reply-To: <CAFLszTj4+GXkmEk3pq-iwJ=8CcJsSreJFKfqWsvW1LQKDz04_w@mail.gmail.com>
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


--qNNxrGTzJS20IH0n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 07, 2025 at 09:12:32AM +1200, Simon Glass wrote:
> Hi Tom,
>=20
> On Sun, 6 Apr 2025 at 11:23, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sun, Apr 06, 2025 at 08:46:31AM +1200, Simon Glass wrote:
> > > (question for Heinrich below)
> > >
> > > Hi Tom,
> > >
> > > On Sun, 6 Apr 2025 at 02:48, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Sat, Apr 05, 2025 at 08:40:08AM -0600, Tom Rini wrote:
> > > > > On Fri, Apr 04, 2025 at 04:48:01PM -0600, Tom Rini wrote:
> > > > > > On Fri, Apr 04, 2025 at 11:32:12PM +0200, Jonas Karlman wrote:
> > > > > > > Hi Simon,
> > > > > > >
> > > > > > > On 2025-04-04 00:30, Simon Glass wrote:
> > > > > > > > Hi Jonas,
> > > > > > > >
> > > > > > > > On Fri, 4 Apr 2025 at 09:57, Jonas Karlman <jonas@kwiboo.se=
> wrote:
> > > > > > > >>
> > > > > > > >> Hi Tom and Simon,
> > > > > > > >>
> > > > > > > >> On 2025-03-19 00:21, Tom Rini wrote:
> > > > > > > >>> On Wed, 05 Mar 2025 17:24:54 -0700, Simon Glass wrote:
> > > > > > > >>>
> > > > > > > >>>> This series includes some patches related to allowing re=
ad_all() to be
> > > > > > > >>>> used with the extlinux / PXE bootmeths.
> > > > > > > >>>>
> > > > > > > >>>> These patches were split out from the stb4 series, since=
 it will need to
> > > > > > > >>>> have additional patches for LWIP, to avoid breaking PXE =
booting when
> > > > > > > >>>> LWIP is used.
> > > > > > > >>>>
> > > > > > > >>>> [...]
> > > > > > > >>>
> > > > > > > >>> Applied to u-boot/next, thanks!
> > > > > > > >>
> > > > > > > >> This series broke booting a compressed arm64 defconfig Lin=
ux kernel
> > > > > > > >> (without module loading) due to changes in decompression b=
uffer length.
> > > > > > > >>
> > > > > > > >> My arm64 defconfig kernel (Image.gz) is ~24 MiB compressed=
 and ~85 MiB
> > > > > > > >> uncompressed.
> > > > > > > >>
> > > > > > > >> Before this series the decompression buffer was 10x the ke=
rnel_comp_size
> > > > > > > >> and now it is instead limited by the SYS_BOOTM_LEN Kconfig=
 symbol.
> > > > > > > >>
> > > > > > > >> A broken boot using current next branch:
> > > > > > > >>
> > > > > > > >>   Retrieving file: /Image.gz
> > > > > > > >>   Retrieving file: /initramfs.cpio.gz
> > > > > > > >>   append: earlycon
> > > > > > > >>   cmd 'booti' states 1f1f addr_img '0x02080000' conf_ramdi=
sk '0x06000000:394d3c' conf_fdt '3df16350' images 000000003ffe53a0
> > > > > > > >>      kernel data at 0x02080000, len =3D 0x00000000 (0)
> > > > > > > >>   load 2080000 start 2080000 len 0 ep 0 os 5 comp 1
> > > > > > > >>   find_other type 2 os 5
> > > > > > > >>   ## Flattened Device Tree blob at 3df16350
> > > > > > > >>      Booting using the fdt blob at 0x3df16350
> > > > > > > >>   Working FDT set to 3df16350
> > > > > > > >>   load_os load 8000000 image_start 2080000 image_len 20000=
00
> > > > > > > >>      Uncompressing Kernel Image to 8000000
> > > > > > > >>   Error: inflate() returned -5
> > > > > > > >>   Image too large: increase CONFIG_SYS_BOOTM_LEN
> > > > > > > >>   Must RESET board to recover
> > > > > > > >>   Resetting the board...
> > > > > > > >>
> > > > > > > >> Changing SYS_BOOTM_LEN from default 64 MiB to 128 MiB fixe=
d the boot:
> > > > > > > >>
> > > > > > > >>   Retrieving file: /Image.gz
> > > > > > > >>   Retrieving file: /initramfs.cpio.gz
> > > > > > > >>   append: earlycon
> > > > > > > >>   cmd 'booti' states 1f1f addr_img '0x02080000' conf_ramdi=
sk '0x06000000:394d3c' conf_fdt '3df16430' images 000000003ffe5480
> > > > > > > >>      kernel data at 0x02080000, len =3D 0x00000000 (0)
> > > > > > > >>   load 2080000 start 2080000 len 0 ep 0 os 5 comp 1
> > > > > > > >>   find_other type 2 os 5
> > > > > > > >>   ## Flattened Device Tree blob at 3df16430
> > > > > > > >>      Booting using the fdt blob at 0x3df16430
> > > > > > > >>   Working FDT set to 3df16430
> > > > > > > >>   load_os load 8000000 image_start 2080000 image_len 20000=
00
> > > > > > > >>      Uncompressing Kernel Image to 8000000
> > > > > > > >>      kernel loaded at 0x08000000, end =3D 0x0d3b5a00
> > > > > > > >>      Loading Ramdisk to 3cb51000, end 3cee5d3c ... OK
> > > > > > > >>      Loading Device Tree to 000000003cb3f000, end 00000000=
3cb509df ... OK
> > > > > > > >>   Working FDT set to 3cb3f000
> > > > > > > >>
> > > > > > > >>   Starting kernel ...
> > > > > > > >>
> > > > > > > >> Do we need to increase the default SYS_BOOTM_LEN for ARM64=
 now?
> > > > > > > >
> > > > > > > > Are you using the 'booti' command? Can you post a bit more =
console
> > > > > > > > output or a script here as it isn't clear what boot command=
 you are
> > > > > > > > using? For now I'm going to assume booti
> > > > > > >
> > > > > > > Above was using an extlinux.conf with bootstd, not using the =
booti cmd.
> > > > > > >
> > > > > > > Use of booti cmd is not affected as it continue to use a 10x =
multiple
> > > > > > > of the kernel_comp_size env var for buffer size.
> > > > > > >
> > > > > > > The change this series introduced was instead of the 10x mult=
iple of
> > > > > > > kernel_comp_size now use SYS_BOOTM_LEN for buffer size (320 v=
s 32 MiB).
> > > > > > >
> > > > > > > And because cmd/booti.c was not converted there is now two di=
fferent
> > > > > > > handling of this decompression buffer size.
> > > > > > >
> > > > > > > If the change to now use SYS_BOOTM_LEN was intended this need=
 to be
> > > > > > > changed as it has mostly been irrelevant for booting Linux on=
 AArch64
> > > > > > > boards prior to this series.
> > > > > >
> > > > > > We need to clean things up such that the path which is using 10x
> > > > > > multiple (and we lmb_alloc an area iirc) is used in all cases.
> > > > >
> > > > > Looking at the code this morning, I was confusing this with what =
we do
> > > > > for compressed FIT images, oops.
> > > >
> > > > Ugh. Simon, can you go and fix this whole problem? Both do_bootz and
> > > > do_booti have non-trivial amounts of code that's missed by changing=
 from
> > > > calling do_bootX() to bootX_run().
> > >
> > > For do_bootz() I believe the current code is correct. It does call
> > > bootz_start() and then doesn't call it again when bootz_run() starts.
> > > It looks like you have taken my Ubuntu test so perhaps I can add a
> > > bootz test for another board in my lab.
> > >
> > > For do_booti(), the code in booti_start() is used for the
> > > non-compressed case, so I believe it is still needed and that bootm
> > > doesn't currently honour 'Image' relocation when using an uncompressed
> > > image. But then there is the issue of SYS_BOOTM_LEN, below.
> > >
> > > bootm_load_os() has code for ARM at the end, which I suspect needs to
> > > run on RISC-V too, in case the image needs to be relocated. Marek
> > > added this 7 years ago[1] so it predates RISC-V and Heinrich perhaps
> > > didn't notice it when adding his support , if it is actually needed.
> > >
> > > SYS_BOOTM_LEN is a 'last bastion' security feature to avoid people
> > > loading images that wrap around memory, etc. I could put bootm_len
> > > into struct bootm_info so that a 10x value can be used for the booti
> > > case.

I'm not sure any of the above is 100% correct. My very quick look was
that it seems like if we want to have the command part of bootX be able
to be equivalently called via API, more of most of the commands needs to
be moved out of cmd/cmdX.c and to boot/bootX.c and put in to some state.

> > > Tom, we also have the issue that you haven't taken the rest of the PXE
> > > series (due to the lwip case), so our trees are out of sync in this
> > > area. It would really help if you could take that series, and again, I
> > > am happy to do the lwip case once it is landed.

Your further PXE rework is irrelevant to this discussion. Except in that
it points out there's still further changes that could break other
things even more.

> > > So for now, if people agree, I can do a small series to use a
> > > different SYS_BOOTM_LEN for the booti command and perhaps add RISC-V
> > > as above.

Well, no, that sounds like a step in the wrong direction. I'd like to
instead restore the expected behavior, and then perhaps we could clean
it up such that the compressed case for booti-Images works like FIT
images where we lmb allocate a larger area if needed.

> > > Later, I could continue the boot-unification effort, e.g. delete the
> > > booti_start() function. and incorporate the uncompressed case into
> > > bootm code.
> >
> > I'm not sure your reading of the situation is right. I'm more inclined
> > to revert this merge rather than take on more rework in the area.
>=20
> Well that would be a pretty poor show. No one else has spent effort
> trying to clean up and rationalise this code in the last 10 years, so
> far as I can see. This is in -next so there is plenty of time to
> resolve any issues.

Yes, things haven't broken in 10 years. This is why I don't value "tidy
up and refactor" in and of itself. Massive reworks then require a long
time to check all of the corner cases. This has been true of many of the
massive reworks you've done over the years.

> I believe my reading of the situation is right, but if you disagree
> with some of it, please indicate which.

Your answer is not "Oh, I'll go understand what I broke and restore
expected behavior". It's "you should take more of my big rework and I'll
rework this area even more". That is not convincing that we won't have
v2025.07 broken here.

--=20
Tom

--qNNxrGTzJS20IH0n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfzBLoACgkQFHw5/5Y0
tyzJqAv/ewt+gvt36sf8TD+ppwxDO7OpeE2DCF9VXVmTFoEAAxKxWLMsQcblcwwq
YIAMl2/gLZxKS0YzE0HcFevVVroBYaDq/xONHkEFabUZVa4D9thGXbDrijQ9drft
SijvCb3YNxHzzy1a+a7gH/PTRZeSa7V/rQTeGGnbd2eyCNB0E8uufIQqV+r086bd
M321g9uRXYzUGGEeuH9CM8SWANSvy6lyqLfTeo4blCVNNb8mb/65LoqlAOYh7p5e
rhXZNpyZ1tXUjqIynaZ9cEhUyhuiU7H0q6uUOIfqXHyB+CJvXhq6B/AkZhK82ZsM
Wgo8rgMSwUMZAliNAqMOAJgM6kHqdsCgjJmA3OG+7oil3y1oAWo6/fniYZwP+I6Y
1t8sCE0SyP9HA71kKIfMus+iJ7kYfiFwPi+8vEPUSl2Sac+mI3GUbdaSvko33N0U
IE3IQDRvZvYJDxt0p3YwInALZi3YthfWk+Y+e8QMtfd6XGielsDsU1DHUVrdZ1t2
+xtXNkCF
=QtEl
-----END PGP SIGNATURE-----

--qNNxrGTzJS20IH0n--
