Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 141BAEFCE33
	for <u-boot@archiver.kernel.org>; Wed,  4 Mar 2026 18:03:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20135839A8;
	Wed,  4 Mar 2026 19:03:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Tm2JjOTU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3439A83AA9; Wed,  4 Mar 2026 19:03:03 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF45B83642
 for <u-boot@lists.denx.de>; Wed,  4 Mar 2026 19:03:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-660bdba9390so2740794a12.1
 for <u-boot@lists.denx.de>; Wed, 04 Mar 2026 10:03:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772647380; cv=none;
 d=google.com; s=arc-20240605;
 b=HYDMwR9GktjJpbTw5CyKFxn/+GJjG4uIkB6+hcsAcKs/f00iaXgvdgCa/nWUEmGOpv
 LAgz6ma46pdB1b1DsHpHJn+yGOr+vYoZeuD5eYsBrEf3A2miOFhoxZL6oWuXBV4UoYEs
 c6uu9lvgoDZxvwpEx6gL8UjYJ8OF91lagfWQX5B8zjH+FXnhEYpy3Ggk4/0uQAMxsbHX
 3VHnVjv9/OWfRe9eYv6dYpt0/6PP/oldUsSoXUS33i8tukDXj4pG+pMFTsUIwyTp/pmy
 e4BGVimvKOBKm6OrGIB3a/nFDsNMhxLqBz4oE+u0ZRazHKRSkwLwzMkQvkttwd23D5M1
 kkxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=e3KqJxrIP6cOhuZpqsFmy0WEpbXJMuXBgEaqevVETfc=;
 fh=c2UY08gJvUf4r9VLG9KgEJdenkhEqUcgiWaSvFizsmo=;
 b=F4oGaYVtVEOudxrAoK8CxkrSYjlBQG8KHwjqstLFOsA21n1ntznWArmnJ1EtnbMesh
 YLpezv+R4xsXk+rV5uwOyjZdOtFxghSoDU5Vd8nj9UgQ0crEcMH4ppuCvyEPjg11dm2I
 YWSGJjPZnt6uqNULOjXrtPb8V4knSpBKmjQjzkIQW9WY5byv3VOpsJb8S2dmAHUVLN5e
 N4wU5QY10VbRd1LgM0vtMCrD/rKsYQnGJrx0sf26Mv/adLVnGTud/KwWcA26W5hok1/q
 gPkx+ENQ2uNw8SW3/2lY+zswiULdbDhaj0echsSUxV1SgkOlGhnZxTBBfHAvqy3vnFfL
 7Lfw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772647380; x=1773252180; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=e3KqJxrIP6cOhuZpqsFmy0WEpbXJMuXBgEaqevVETfc=;
 b=Tm2JjOTU/pQ6NMbCH0ksgkS3noQIpr7qshube1/t0dG12vCRXQ/5dp2z5xsoYMSFuG
 QNPXIrgQGH78i/mwnktHPx/zEoi8IZNZQhFO6rgCOWAFLTd3iMUXqudEl6d/U43BLuOB
 GOj7MciOg4iKyNOOTAlejgj0qfjgCXzdyOwQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772647380; x=1773252180;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e3KqJxrIP6cOhuZpqsFmy0WEpbXJMuXBgEaqevVETfc=;
 b=OVgpgAC1Ud/myjjfDXVjqE0uUMr9YzUc2u4XfZ5Qw3IamvIbAeNccAalHikK5b7B2A
 SX7QF06a5fadMyXb/RMh1BvfetAMVAahUjqLbnbfRlQpWoBiKuQNm/BaEEc+VDu0srWm
 eNmcF5atk2N14bDb4t4GP7oP/r0w4Ho4OKNubQ/AppRe8E/3Z613jpgJu1OOGG5X0FYO
 JAU406h2cGDonowMuxH5FRTe2lSubQeZtuY8kBRvk1Vp+Mh0nRmPQaBQWhIMEgiaCMPG
 BBU2nvaLJiFVox1dMQxR3PQzem9CJGoRLreSzX4C+l5SF7Y4vUxbwuduRX+yJCLlLIMR
 8Xlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqU0D+yjM0hiVWWfUzh3Kpt9L7OHqtiCfIg88cjnDiTEshElNZLie6Kq6CGdBdMGlRSbDv4qI=@lists.denx.de
X-Gm-Message-State: AOJu0Yxwf/uAU8HhjMYsTZwa+O/uXI2src10G+L9OR+HC3GBElMHUFVX
 xLid6NjCHGIf8uaxUDgHX9Omwuz+7jF8AhWnkXIAwKlIYhw5n2aWpT11l7oexVB8ZsQxr0Q60IB
 R3h4NjO6vZhuKA8jp69lkFjsn99xbCU+TwQ/XcXy1
X-Gm-Gg: ATEYQzyh+SfbgMdJutxV6QGQtbzCQWFdJHYsL5UvxU6rdXpGs6yI48rTCAN3nRZevZn
 o3p939dRm+sKCPtiAtcBrmfBtHbMDx88RE7m8fGThxdVXeNSp6hApkOwmC88hf4neuwYMwXcoxh
 Y3ONaQPgxJ5KrsaDGJN8S9/HmA3ZW4u3LPq93C3EE9GLyrRwNk7YrCuU66CLY1FNO7Kg+pwXOCv
 J0Wr1ZDMh0d2k/kFN00QweyGGal7Wk5g8jLUnFVtU2DoU35ZpxH4LTVnRGWCf31ZmIerbWwvAYK
 jhpqRg==
X-Received: by 2002:a17:907:6e86:b0:b87:d255:39ff with SMTP id
 a640c23a62f3a-b93f13f0977mr186093966b.32.1772647379960; Wed, 04 Mar 2026
 10:02:59 -0800 (PST)
MIME-Version: 1.0
References: <20260214024736.3726811-1-simon.glass@canonical.com>
 <177256385549.3975993.592734328770415000.b4-ty@konsulko.com>
 <20260304-robe-praising-5509e3a984cd@spud>
 <20260304150145.GX1388590@bill-the-cat>
 <20260304-acquaint-wager-688fd7fbae6a@spud>
 <20260304151154.GY1388590@bill-the-cat>
 <20260304-germproof-gawk-d26040529131@spud>
 <20260304154549.GZ1388590@bill-the-cat>
 <CAC_iWjKehyCeLfmPWGUHAHF5YXaynWMzyYnuc-wqZmDmjQQnZg@mail.gmail.com>
 <20260304173427.GB1388590@bill-the-cat>
In-Reply-To: <20260304173427.GB1388590@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 4 Mar 2026 11:02:47 -0700
X-Gm-Features: AaiRm521AQy29HiLoo08RJp65c7vbVc6bSKqMr06TL-pKLoOHeqoxyoQSjcZuhA
Message-ID: <CAFLszTiOWF=JfxSNmdY4QS3+LeC+DGaJE+fZTBwv9A79VOzmWQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: unexport sub_make_done to fix child make
 invocations
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Conor Dooley <conor@kernel.org>, u-boot@lists.denx.de, 
 Simon Glass <simon.glass@canonical.com>, Sughosh Ganu <sughosh.ganu@arm.com>
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

Hi,

On Wed, 4 Mar 2026 at 10:34, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Mar 04, 2026 at 06:57:42PM +0200, Ilias Apalodimas wrote:
> > Hi Tom
> >
> >
> >
> > On Wed, 4 Mar 2026 at 17:45, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Mar 04, 2026 at 03:24:45PM +0000, Conor Dooley wrote:
> > > > On Wed, Mar 04, 2026 at 09:11:54AM -0600, Tom Rini wrote:
> > > > > On Wed, Mar 04, 2026 at 03:09:40PM +0000, Conor Dooley wrote:
> > > > > > On Wed, Mar 04, 2026 at 09:01:45AM -0600, Tom Rini wrote:
> > > > > > > On Wed, Mar 04, 2026 at 09:54:22AM +0000, Conor Dooley wrote:
> > > > > > > > On Tue, Mar 03, 2026 at 12:50:55PM -0600, Tom Rini wrote:
> > > > > > > > > On Fri, 13 Feb 2026 19:47:34 -0700, Simon Glass wrote:
> > > > > > > > >
> > > > > > > > > > The exported sub_make_done variable leaks into the environment of all
> > > > > > > > > > child processes. When make targets like tcheck spawn independent make
> > > > > > > > > > invocations with O=, those child makes inherit sub_make_done=1, skip
> > > > > > > > > > the KBUILD_OUTPUT setup and try to build in the source tree.
> > > > > > > > > >
> > > > > > > > > > There is a workaround that resets sub_make_done to 0 for specific test
> > > > > > > > > > targets, but this isn't great since it has tolist every target that
> > > > > > > > > > spawns independent make invocations.
> > > > > > > > > >
> > > > > > > > > > [...]
> > > > > > > > >
> > > > > > > > > Applied to u-boot/master, thanks!
> > > > > > > > >
> > > > > > > > > [1/1] kbuild: unexport sub_make_done to fix child make invocations
> > > > > > > > >       commit: 4284306d22c5b6d64ecd62b462551d9d313c8104
> > > > > > > >
> > > > > > > >
> > > > > > > > This breaks the build for me:
> > > > > > > > make ARCH=riscv CROSS_COMPILE=riscv64-unknown-linux-gnu- O=build microchip_mpfs_generic_defconfig
> > > > > > > >   GEN     Makefile
> > > > > > > > #
> > > > > > > > # configuration written to .config
> > > > > > > > #
> > > > > > > > make ARCH=riscv CROSS_COMPILE=riscv64-unknown-linux-gnu- O=build
> > > > > > > >   HOSTCC  scripts/basic/fixdep
> > > > > > > >   GEN     Makefile
> > > > > > > >   HOSTCC  scripts/kconfig/conf.o
> > > > > > > >   YACC    scripts/kconfig/zconf.tab.[ch]
> > > > > > > >   LEX     scripts/kconfig/zconf.lex.c
> > > > > > > >   HOSTCC  scripts/kconfig/zconf.tab.o
> > > > > > > >   HOSTLD  scripts/kconfig/conf
> > > > > > > > scripts/kconfig/conf  --syncconfig Kconfig
> > > > > > > > ***
> > > > > > > > *** Configuration file ".config" not found!
> > > > > > > > ***
> > > > > > > > *** Please run some configurator (e.g. "make oldconfig" or
> > > > > > > > *** "make menuconfig" or "make xconfig").
> > > > > > > > ***
> > > > > > > > make[4]: *** [/stuff/u-boot/scripts/kconfig/Makefile:75: syncconfig] Error 1
> > > > > > > > make[3]: *** [/stuff/u-boot/Makefile:702: syncconfig] Error 2
> > > > > > > > make[2]: *** [../Makefile:189: __sub-make] Error 2
> > > > > > > > make[1]: *** No rule to make target 'include/config/auto.conf', needed by 'include/config/uboot.release'.  Stop.
> > > > > > > > make: *** [Makefile:189: __sub-make] Error 2
> > > > > > >
> > > > > > > That's odd. What host distro and make? I don't see that on Ubuntu 24.04.
> > > > > >
> > > > > > Originally my CI found it in a docker container with "from: ubuntu:noble",
> > > > > > so 24.04. I reproduced it locally on debian unstable with make 4.4.1
> > > > >
> > > > > That's even more puzzling (noble is 24.04) since that sounds very close
> > > > > to our CI too. Can you please look more in to what's going on?
> > > >
> > > > Can I assume your CI also sets O=<something> then? Is the CI config
> > > > stuff in tree, or somewhere else?
> > >
> > > We use buildman, which in turn does separate output directories. We
> > > also, in Azure, have one job that uses O= specifically. Things are
> > > defiend in .gitlab-ci.yml and .azure-pipelines.yml
> >
> > I get the same error with
> > make ARCH=arm CROSS_COMPILE=aarch64-linux-gnu- qemu_arm64_lwip_defconfig O=build
> > make ARCH=arm CROSS_COMPILE=aarch64-linux-gnu- O=build
> >   HOSTCC  scripts/basic/fixdep
> >   GEN     Makefile
> >   HOSTCC  scripts/kconfig/conf.o
> >   YACC    scripts/kconfig/zconf.tab.[ch]
> >   LEX     scripts/kconfig/zconf.lex.c
> >   HOSTCC  scripts/kconfig/zconf.tab.o
> >   HOSTLD  scripts/kconfig/conf
> > scripts/kconfig/conf  --syncconfig Kconfig
> > ***
> > *** Configuration file ".config" not found!
> > ***
> > *** Please run some configurator (e.g. "make oldconfig" or
> > *** "make menuconfig" or "make xconfig").
> > ***
> > make[4]: *** [/home/apalos/work/u-boot-tpm/scripts/kconfig/Makefile:75:
> > syncconfig] Error 1
> > make[3]: *** [/home/apalos/work/u-boot-tpm/Makefile:702: syncconfig] Error 2
> > make[2]: *** [../Makefile:189: __sub-make] Error 2
> > make[1]: *** No rule to make target 'include/config/auto.conf', needed
> > by 'include/config/uboot.release'.  Stop.
> > make: *** [Makefile:189: __sub-make] Error 2
> >
> > Also the patch has a Fixes tag, but it doesn't actually fix anything.
> > It just tries to improve something. Can we revert it on master at
> > least? Do you want me to send a patch?
>
> Sigh, I'll revert it, thanks.

Yes unfortunately it is broken for this case, but I see another way.

The patch allows adding 'make qcheck' etc. to CI, something Tom has
requested for a while. Since this is being reverted, I'll send a v2.

Regards,
Simon
