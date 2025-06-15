Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84899C61CE8
	for <u-boot@archiver.kernel.org>; Sun, 15 Jun 2025 11:06:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D63682BF6;
	Sun, 15 Jun 2025 13:06:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a26M5jCC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 273E082C84; Sun, 15 Jun 2025 13:06:08 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 258E48144A
 for <u-boot@lists.denx.de>; Sun, 15 Jun 2025 13:06:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-60780d74c85so5286304a12.2
 for <u-boot@lists.denx.de>; Sun, 15 Jun 2025 04:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749985565; x=1750590365; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oDmqlAHQTxVlK8hIkhsARjbE8wnwO4sdR7h5NGhp7TQ=;
 b=a26M5jCCR30PSY/3+2FVr15R1mTBfZbFZ/8EXKen1EaorIMj0VFmAgeOjkIajZYmAc
 HLT8FEuuXEzK7DRl97yi8aVvdtfLjcMSrZmloYQMMlXB+OV2FWuv5PlmuKc/9FAH8TgP
 MnSEaee5u6d1YmsPHml2mMvqLVs7ToH+Y5vyZ72I1B3ONycgWN4s1rWCSiowBmrnIyL1
 TESBu47EKh78y6tfi+rQ6hV4c2uYnhV6Z4M/hCUQR8gAFbabmT09NUGcLoA82lw+eIKS
 0FDjpbVRI5ooeH6UN1aG3S1nRqt+uhl5yvzkZYVeioaefwrIRrvGX0ALT5aGftwiNDRM
 517A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749985565; x=1750590365;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oDmqlAHQTxVlK8hIkhsARjbE8wnwO4sdR7h5NGhp7TQ=;
 b=RG4a1fmJAb6NNz22IDVn9iGf/rcsGO1XKWjs84LqQ6cYnNSiT98bjTLHOD8/Y1E/K3
 0/r7n3cO2g0YM6I1gAoxupj6ZQ+1faaGQ1ZloOTaDlCVbJZNchOSLfBMzlhlYesuG/mZ
 arWDv7NwzEjtNbMZvrLLUXuEOBl+LbleMVJgsfO5TiZhdZLucRsE1xwHH7oYA29wN8Kf
 CsotjkdKJKqXS9wDPDkw6INwofhVFk/+l3J2odyZ9JUkbDhR2zFL43PWWVPp79BVVHF0
 dIoWd71+TEfjk6K12efN1X1PTZ6boOVH6FkY/657P80t1OVFofrK8n0AmcrMZp9R78W7
 yrhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKZyEfNJxOWUVupjPw+Q4aTXKhSOJW7qYTBWKmEnXKsbkP+GmvXvGp4LzmF9EDr8j8tRXxFRY=@lists.denx.de
X-Gm-Message-State: AOJu0YxTWPo02xcf+Ol48UgQfiii1EVZNtZ+L1IToOSvPoDYmQDdboxX
 KhfXp0iu2ezh6QeyzsLWkcuorKPB0bxmuZ874AdXNkW3O/DYtkK3X3O++FCrvohdJvH2oT7dekR
 Oxs/JTYJiS7Nk7w1uuY8x72X4sImiFjM=
X-Gm-Gg: ASbGncvLvAfojSMrm+IGkiB8RMqlcZGHFWaeu0Q3hmXYP5kMzd489rhCHHSYrpepA5r
 WsidujXanpGE8zIDCXpMz23Q1WfKYfAQYudLcs90X++/e5nyQG7n8MLx6x0jHp0RAVAPJYRJa3r
 hjCv6q08EpZ3l1vw2/jFemkjqNbDmC/Ha5eJddpIqrQ086gFoTLL2PeV7VYzNqyX1ysfDLy13kk
 7RI+r8yaafYo/8=
X-Google-Smtp-Source: AGHT+IGvryvHbzA6HwWzxR+35jYLyZXfkobVmjBBFUD86gA7cyjU1siGrkXIXz+PZ0IKVqyzBQc+GylEmrZlnEuwFxU=
X-Received: by 2002:a17:907:3d16:b0:ad8:a4a8:1038 with SMTP id
 a640c23a62f3a-adfad4f68c1mr462532366b.53.1749985565434; Sun, 15 Jun 2025
 04:06:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250502113556.134731-1-brunosampaioleite@gmail.com>
 <20250502144031.GT1261075@bill-the-cat> <87frhj5r32.fsf@prevas.dk>
 <20250505134843.GK1261075@bill-the-cat>
 <87zffq95f7.fsf@bloch.sibelius.xs4all.nl>
 <20250505212816.GP5430@bill-the-cat> <878qna5h8c.fsf@prevas.dk>
In-Reply-To: <878qna5h8c.fsf@prevas.dk>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Sun, 15 Jun 2025 12:05:54 +0100
X-Gm-Features: AX0GCFv7SM3wkLgP0aNN2WCrV3ZDXpklPPEn5Ty_HkCw16vh4mTwvDRAdFauEJw
Message-ID: <CALeDE9O9-L5hKjN7cK_-EY3Ptn77DX-PUtp4zapRQ3jcXVx4jg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Add rpi5 specific defconfig
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: Tom Rini <trini@konsulko.com>, Mark Kettenis <mark.kettenis@xs4all.nl>, 
 brunosampaioleite@gmail.com, u-boot@lists.denx.de, probinson@gmail.com, 
 mbrugger@suse.com, clast@prevas.dk, brule@prevas.dk
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 6 May 2025 at 08:30, Rasmus Villemoes <ravi@prevas.dk> wrote:
>
> On Mon, May 05 2025, Tom Rini <trini@konsulko.com> wrote:
>
> > On Mon, May 05, 2025 at 10:19:24PM +0200, Mark Kettenis wrote:
> >> > Date: Mon, 5 May 2025 07:48:43 -0600
> >> > From: Tom Rini <trini@konsulko.com>
> >> >
> >> > On Mon, May 05, 2025 at 11:45:05AM +0200, Rasmus Villemoes wrote:
> >> > > On Fri, May 02 2025, Tom Rini <trini@konsulko.com> wrote:
> >> > >
> >> > > > On Fri, May 02, 2025 at 01:34:33PM +0200, Bruno Leite wrote:
> >> > > >
> >> > > >> From: Bruno Leite <brule@prevas.dk>
> >> > > >>
> >> > > >>
> >> > > >> Currently rpi5 uses a generic rpi_arm64_defconfig file that builds rpi4
> >> > > >> devicetree. Add a defconfig that is specific to the rpi5 building the
> >> > > >> now available upstream dts for that board. The defconfig makes use of
> >> > > >> defconfig including that is now available and only changes the DTS
> >> > > >> related config.
> >> > > >>
> >> > > >> It is also necessary to add a more specific u-boot.dtsi to rpi5, since
> >> > > >> due to the ARCH_BCM283X config it will try to build the
> >> > > >> bcm283x-u-boot.dtsi and break.
> >> > > >
> >> > > > My question is, can we not adjust rpi_arm64_defconfig to be generic
> >> > > > enough and not have a problem on Pi 5 due to the default device tree?
> >> > >
> >> > > Not really.
> >> > >
> >> > > What we want is to have CONFIG_DEFAULT_DEVICE_TREE to point at the
> >> > > rpi5's .dts file, because we really want to build that and not some
> >> > > "random" dts file that doesn't have anything to do with the hardware. I
> >> > > know that kinda works for the setups where the .dtb built in U-Boot is
> >> > > not used for anything, but in our case, we really do want to use the
> >> > > .dtb from the U-Boot build - we inject various U-Boot specific stuff via
> >> > > the EXTRA_DTSI mechanism, e.g. public key for kernel verification.
> >> > >
> >> > > And due to CONFIG_SYS_SOC being bcm283x, and bcm283x-u-boot.dtsi
> >> > > referencing nodes that simply don't exist when building
> >> > > bcm2712-rpi-5-b.dts, the build breaks.
> >> > >
> >> > > Perhaps the real problem is CONFIG_SYS_SOC being bcm283x for rpi5? I
> >> > > don't really know why rpi4 is both bcm2711 and bcm2835 and what the
> >> > > difference is, but rpi5 only seems to include a bcm2712.dtsi which does
> >> > > not include further dtsi files.
> >> > >
> >> > > If rpi5 has nothing to do with bcm283x, then perhaps a better approach
> >> > > is to ensure that CONFIG_SYS_SOC is bcm2712 when building for
> >> > > rpi5. Something like adding a CONFIG_TARGET_RPI_5 choice and adding a
> >> > > 'default "bcm2712" if TARGET_RPI_5' ?
> >> >
> >> > OK, so I guess my next question is, is rpi_arm64 useful enough in the
> >> > end for Pi 3 and Pi 4? I would have expected that it doesn't matter what
> >> > tree we build in to U-Boot as we would be using the one passed to us by
> >> > the prior stage firmware, and then update that at run-time as needed.
> >>
> >> Works well enough for us on OpenBSD.  And it would be nice if
> >> rpi_arm64 would work for the Pi 5 as well.
> >
> > But that gets back to my first question. Can we correct the code such
> > that we do whatever is required at run time, as the previous stage will
> > have assembled and passed a correct device tree already?
>
> I think this is sort-of asking the wrong question. The problem is not
> about what dtb the prior stage hands us or what to do at run-time. [*]
>
> The problem is to have a defconfig that will compile
> bcm2712-rpi-5-b.dts, as part of the U-Boot build. As I said, it's quite
> likely that rpi5 isn't at all a part of the 'menu "Broadcom BCM283X
> family"', and it's the CONFIG_SYS_SOC="bcm283x" that prevents
> bcm2712-rpi-5-b.dts from being compiled (because the bcm283x-u-boot.dtsi
> doesn't apply to that .dts). Bruno's patches achieve that by adding a
> more-specific -u-boot.dtsi file (it doesn't seem that we need any of the
> bootph-all settings from the bcm283x.dtsi file), and adding a defconfig
> file that is based on arm64, but just changes the dt settings.

Any reason why CONFIG_OF_LIST= wouldn't work for that?

> Those who simply ignore what .dtbs are part of the U-Boot build and use
> blobs coming from elsewhere can probably use rpi_arm64_defconfig as-is
> for rpi5.
>
> Rasmus
>
> [*] That's mostly a solved packaging problem outside the scope of
> U-Boot itself: Just put whatever .dtb one wishes the prior stage to pass
> to U-Boot along with u-boot.bin in the FAT filesystem, and put
>
> kernel=u-boot.bin
> device_tree=u-boot.dtb
>
> in config.txt (sure, there might be drivers that need updating to take
> different compatibles or whatnot into account).
