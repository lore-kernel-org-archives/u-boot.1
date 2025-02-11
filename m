Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE43C021A1
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 11:05:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA023800CF;
	Tue, 11 Feb 2025 12:05:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="FrXFOBVv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62AE3800CF; Tue, 11 Feb 2025 12:05:03 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [IPv6:2003:a:e28:26e4::10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E98680079
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 12:04:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A47D61480300; Tue, 11 Feb 2025 12:04:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1739271895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Jz55kWjD81jx2gNWIM/Z3tQNbEgKnBBRN/FHZ42f9Q=;
 b=FrXFOBVv3DYvZUKeUjMLjwi2qbGkassyMHqvi2/mBRqrevZvJ4LyEDgmd6jDxGwPkfK6On
 z+3cANF76djmGwmMKOyqBjJruM8byCWuzM3b0+Bj2Pl0o7YcQ4P5ZLpCGBCbUfNoHD/ke/
 GmkPo771DxW68J6iVMdJ0ftDXDbD3nb13UU/A84EASLuvuwbep9s5+XCPiEXWxOIFbkvNi
 QJYc+aS9xYxoydhPsEteXI+s7rKw5YNs8KKuxp0q/KnTU+RpDkZvq5+PwG5By2l/HVRqi1
 Tg8kpH3OQ3Ky53qPt0Mxw93q3beI1KaiDih60b37HPfELWoGU2uEFu5LCMkk9Q==
Date: Tue, 11 Feb 2025 12:04:51 +0100
From: Alexander Dahl <ada@thorsis.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Mark Kettenis <kettenis@openbsd.org>
Subject: Re: [PATCH v4 05/15] lmb: notify of any changes to the LMB memory map
Message-ID: <20250211-distract-whooping-739989988035@thorsis.com>
Mail-Followup-To: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>,
 Mark Kettenis <kettenis@openbsd.org>
References: <20241015153717.401371-1-sughosh.ganu@linaro.org>
 <20241015153717.401371-6-sughosh.ganu@linaro.org>
 <20250117-molecular-quicksand-e80bf947313e@thorsis.com>
 <CADg8p97Q70PnsXd=GtTLncg8B8LMTN7bda4YXxb+VDnCU4HL4Q@mail.gmail.com>
 <20250120-shine-extended-134d3ccac85f@thorsis.com>
 <CADg8p96wCZppfKBrVok6nU1eyx=dHcAH9iZaiHa_jMkYd1LHUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADg8p96wCZppfKBrVok6nU1eyx=dHcAH9iZaiHa_jMkYd1LHUg@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3
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

Hello,

Am Tue, Feb 11, 2025 at 04:23:13PM +0530 schrieb Sughosh Ganu:
> On Mon, 20 Jan 2025 at 15:43, Alexander Dahl <ada@thorsis.com> wrote:
> >
> > Hello,
> >
> > Am Mon, Jan 20, 2025 at 02:40:38PM +0530 schrieb Sughosh Ganu:
> > > On Fri, 17 Jan 2025 at 16:40, Alexander Dahl <ada@thorsis.com> wrote:
> >
> > […]
> >
> > > > This changeset breaks build with CONFIG_CC_OPTIMIZE_FOR_DEBUG=y for
> > > > me.  In a usual non-debug build, everything is fine.  However in a
> > > > debug build now I get this error:
> > > >
> > > >       UPD     include/generated/timestamp_autogenerated.h
> > > >       GEN     Makefile
> > > >       Using /mnt/data/adahl/src/u-boot as source for U-Boot
> > > >       CC      common/version.o
> > > >       AR      common/built-in.o
> > > >       LD      u-boot
> > > >     arm-v5te-linux-gnueabi-ld.bfd: lib/lmb.o: in function `lmb_map_update_notify':
> > > >     /mnt/data/adahl/src/u-boot/lib/lmb.c:458: undefined reference to `efi_add_memory_map_pg'
> > >
> > > Can you share the details of the toolchain that you are using, where
> > > can I download it from. And the target that you build which shows this
> > > up. Thanks.
> >
> > Although I'm actually building with ptxdist and
> > OSELAS.Toolchain-2023.07.1/arm-v5te-linux-gnueabi for a custom board,
> > you should be able to reproduce the behaviour easily with buildman on
> > master when building for boards sam9x60ek or sam9x60_curiosity like
> > this:
> >
> >     buildman -o ~/build/u-boot/buildman -e -a CC_OPTIMIZE_FOR_DEBUG sam9x60
> >
> > My output when running the above is this:
> 
> Sorry, I haven't spent time debugging this issue, although this is on
> my todo list. Btw, since you already have a working setup, can you
> please reset your tree to the following commit and then check if that
> fixes your issue.
> 
> 92e75ee47f1 ("board_r: Remove duplicate headers")

Does not change anything.

Note: my tree is not special in any way, it's a clean mainline u-boot
checkout and I'm building for a board with an in tree config.
Everyone should be able to reproduce this by using
configs/sam9x60_curiosity_mmc_defconfig, enabling
CC_OPTIMIZE_FOR_DEBUG and building with the default toolchain
downloaded by buildman, which is also mainline u-boot tooling.

My assumption is: some efi code is pulled in unconditionally here,
but efi is not enabled on armv5 and it can not be enabled,  efi is not
needed on this target anyways.  Furthermore: I assume the code is
optimized out when doing a normal build without CC_OPTIMIZE_FOR_DEBUG,
which is basically building without optimizations and keeping debug
symbols.

Greets
Alex

> 
> -sughosh
> 
> >
> >     % buildman -o ~/build/u-boot/buildman -e -a CC_OPTIMIZE_FOR_DEBUG sam9x60
> >     Building current source for 5 boards (5 threads, 4 jobs per thread)
> >            arm:  +   sam9x60_curiosity_mmc1
> >     +arm-linux-gnueabi-ld.bfd: lib/lmb.o: in function `lmb_map_update_notify':
> >     +lib/lmb.c:458: undefined reference to `efi_add_memory_map_pg'
> >     +make[1]: *** [Makefile:1824: u-boot] Fehler 1
> >     +make: *** [Makefile:177: sub-make] Error 2
> >            arm:  +   sam9x60_curiosity_mmc
> >     +arm-linux-gnueabi-ld.bfd: lib/lmb.o: in function `lmb_map_update_notify':
> >     +lib/lmb.c:458: undefined reference to `efi_add_memory_map_pg'
> >     +make[1]: *** [Makefile:1824: u-boot] Fehler 1
> >     +make: *** [Makefile:177: sub-make] Error 2
> >            arm:  +   sam9x60ek_mmc
> >     +arm-linux-gnueabi-ld.bfd: lib/lmb.o: in function `lmb_map_update_notify':
> >     +lib/lmb.c:458: undefined reference to `efi_add_memory_map_pg'
> >     +make[1]: *** [Makefile:1824: u-boot] Fehler 1
> >     +make: *** [Makefile:177: sub-make] Error 2
> >            arm:  +   sam9x60ek_qspiflash
> >     +arm-linux-gnueabi-ld.bfd: lib/lmb.o: in function `lmb_map_update_notify':
> >     +lib/lmb.c:458: undefined reference to `efi_add_memory_map_pg'
> >     +make[1]: *** [Makefile:1824: u-boot] Fehler 1
> >     +make: *** [Makefile:177: sub-make] Error 2
> >            arm:  +   sam9x60ek_nandflash
> >     +arm-linux-gnueabi-ld.bfd: lib/lmb.o: in function `lmb_map_update_notify':
> >     +lib/lmb.c:458: undefined reference to `efi_add_memory_map_pg'
> >     +make[1]: *** [Makefile:1824: u-boot] Fehler 1
> >     +make: *** [Makefile:177: sub-make] Error 2
> >         0    0    5 /5              0:00:40  : sam9x60ek_nandflash
> >     Completed: 5 total built, 5 newly), duration 0:00:22, rate 0.23
> >
> > Greets
> > Alex
> >
