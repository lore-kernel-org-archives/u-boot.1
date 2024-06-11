Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9407C27C75
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 14:40:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0B47886E6;
	Tue, 11 Jun 2024 16:40:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UEFN78Rn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEDFB886F1; Tue, 11 Jun 2024 16:40:03 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA8E487E0D
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 16:40:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-5ba33b08550so585129eaf.2
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 07:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718116799; x=1718721599; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IsSbYg1QmAJgZyEfIUwjHoaeJ4gE1xoqqmxTyojeFjs=;
 b=UEFN78RnMizVMlT6wyen/hMEY3eX2qtN6ojw9psLOjlpd+Pct4qgbqXoFnX36cC0br
 tBGk2EvlosCF48caGFTsHyu9ibNibPpo7dLoCihmffta7MdqFH7Qs4ucF49yEZlz3JW/
 isrGOj5ALe0HutrcKpUvY6VQ99ZH3KkDT4Gzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718116799; x=1718721599;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IsSbYg1QmAJgZyEfIUwjHoaeJ4gE1xoqqmxTyojeFjs=;
 b=wNAuRN6aqMDM6dXYF2Emx4KoPcM3B3d+vodweVkdpUXFwuZUj9wcjnWJi4knA0MRTZ
 bbiLH44bEUOEDp5UIXirVLo5kptYvHgWOGmmEl1SJSkbE68A9oImyyCQ08Tm1Ai54IX0
 Hgk1s2g3hjBugHRM7QLiHMdAC7EDOt9WVEgJtVE2b02AzLPtFDfE6FYMnt2uHvxVyYo0
 GkkhpRJS1tRlAEwCeSdajAeYW2poiT19DzVvi9BpZErf+0uUh/5urpMgK/EY8EYrLBjQ
 mqc6XdrY+BVjG+kRJocekMaCVpZxXGmDzPObkZmivP7Pc2dJB+1gp7R2xVw8MW1zHGqP
 0A3A==
X-Gm-Message-State: AOJu0YzJGFYeOHnnD1llcQbAK7PutBS7pw31MK05W+k0kTW20ZRaRaHk
 gBXKqZplu32maN0AA9XaCMTtMErCpJ/wZhuaX3o5Ca4Og6e5tcUDF+IzRIE91SM=
X-Google-Smtp-Source: AGHT+IHFndQBhbUCs+eEk2X6VhwFfb731yLphbqNNCrV8riq1rKS4TcoNuE0cPVvn1Rf+bwaiWRLsw==
X-Received: by 2002:a05:6820:1ad3:b0:5bb:79d:1c6e with SMTP id
 006d021491bc7-5bb079d201dmr6289583eaf.8.1718116799131; 
 Tue, 11 Jun 2024 07:39:59 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5bac95e0733sm1411774eaf.7.2024.06.11.07.39.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 07:39:58 -0700 (PDT)
Date: Tue, 11 Jun 2024 08:39:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Fabio Estevam <festevam@gmail.com>
Subject: Re: [RFC PATCH 00/31] Make U-Boot memory reservations coherent
Message-ID: <20240611143956.GG68077@bill-the-cat>
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
 <20240610210550.GA68077@bill-the-cat>
 <CADg8p94qENnqk8fJ+VBhDP5xrptW4kEBS_SoowH2MLbd9uFAuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="muwyrQfI6C4AdeUz"
Content-Disposition: inline
In-Reply-To: <CADg8p94qENnqk8fJ+VBhDP5xrptW4kEBS_SoowH2MLbd9uFAuw@mail.gmail.com>
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


--muwyrQfI6C4AdeUz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 02:31:27PM +0530, Sughosh Ganu wrote:
> On Tue, 11 Jun 2024 at 02:35, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, Jun 08, 2024 at 12:22:09AM +0530, Sughosh Ganu wrote:
> >
> > > The aim of this patch series is to fix the current state of
> > > incoherence between modules when it comes to memory usage. The primary
> > > issue that this series is trying to fix is that the EFI memory module
> > > which is responsible for allocating and freeing memory, does not have
> > > any visibility of the memory that is being used by the LMB
> > > module. This is further complicated by the fact that the LMB
> > > allocations are caller specific -- the LMB memory map is not global
> > > nor persistent. This means that the memory "allocated" by the LMB
> > > module might be relevant only for a given function. Hence one of the
> > > requirements for making the memory usage visible across modules is to
> > > make LMB allocations persistent and global, and then have means to
> > > communicate the use of memory across modules.
> > >
> > > The first set of patches in this series work on making the LMB memory
> > > map persistent and global. This is being done keeping in mind the
> > > usage of LMB memory by platforms where the same memory region can be
> > > used to load multiple different images. What is not allowed is to
> > > overwrite memory that has been allocated by the other module,
> > > currently the EFI memory module. This is being achieved by introducing
> > > a new flag, LMB_NOOVERWRITE, which represents memory which cannot be
> > > re-requested once allocated.
> > >
> > > The second set of patches are then introducing a notification
> > > mechanism to indicate any changes to a respective module's memory
> > > map. This way, any memory allocation/reservation by a module gets
> > > notified to any interested listners, who then update their memory map
> > > accordingly, thus keeping memory usage coherent.
> > >
> > > Todo's
> > > ------
> > > I have run these patches through CI, but the LMB unit tests need an
> > > overhaul. I have currently marked these tests for manual run, as
> > > running these would obviously tamper the LMB memory map, thus
> > > affecting subsequent tests. The current set of LMB tests are written
> > > with the assumption of local LMB memory maps. This needs to be
> > > reworked.
> > >
> > > Secondly, there needs to be a test written for testing the various
> > > scenarios of memory being allocated and freed by different modules,
> > > namely LMB and EFI. I have written a couple of commands for testing
> > > the changes that I have made -- I have also included these temporary
> > > commands to assist anyone who might want to test these changes. But I
> > > will be working on adding a more comprehensive test.
> > >
> > > Lastly, as the series touches common code, there is obviously an
> > > increase in the size of the image, moreover since the LMB memory is
> > > now persistent, and the variables do not reside on the stack. I want
> > > to check if there can be ways of decreasing the size impact of the
> > > changes.
> >
> > So, I think you made some changes between your last CI run and posting?
> > A ton of platforms (basically anything with EFI_LOADER disabled) fail to
> > build now because the two "temp" commits at the end of the series are
> > always enabled. I took those commits out and ran my world build size
> > check tests and the results are at:
> > https://gist.github.com/trini/d42bd392463c39766a5f872c190ccf27
> >
> > And 64bit ARM looks very reasonable, but I wonder if we can improve the
> > 32bit ARM results?
> >
> > I also did an every commit run for a 32bit ARM board without EFI_LOADER
> > (which is going to be the case for size constrained systems) and see
> > that the series isn't bisect'able to start with, so please fix that for
> > the next go-round. That said:
>=20
> Yes, I should have mentioned it in the cover letter about issues with
> bisectability, primarily because some code under boot/ uses the lmb
> API's unconditionally, without having a check for LMB being enabled or
> not.

Yeah, today at least LMB functionally should be a def_bool y instead of
a choice.

> > Summary of 30 commits for 1 boards (1 thread, 12 jobs per thread)
> > 01: Added arm64 assembly for examples/api crt0
> > 02: lmb: remove the unused lmb_is_reserved() function
> > 03: lmb: staticize __lmb_alloc_base()
> >        arm: (for 1/1 boards) all -16.0 text -16.0
> >             omapl138_lcdk  : all -16 text -16
> >                u-boot: add: 0/-1, grow: 1/0 bytes: 172/-186 (-14)
> >                  function                                   old     new=
   delta
> >                  lmb_alloc_base                              40     212=
    +172
> >                  __lmb_alloc_base                           186       -=
    -186
> > 04: lmb: make the lmb reservations persistent
> >        arm:  +   omapl138_lcdk
> > +(omapl138_lcdk) lib/lmb.c: In function 'lmb_dump_all_force':
> > +(omapl138_lcdk) lib/lmb.c:64:29: error: 'lmb' is a pointer; did you me=
an to use '->'?
> > +(omapl138_lcdk)    64 |         lmb_dump_region(&lmb.memory, "memory");
> > +(omapl138_lcdk)       |                             ^
> > +(omapl138_lcdk)       |                             ->
> > +(omapl138_lcdk) lib/lmb.c:65:29: error: 'lmb' is a pointer; did you me=
an to use '->'?
> > +(omapl138_lcdk)    65 |         lmb_dump_region(&lmb.reserved, "reserv=
ed");
> > +(omapl138_lcdk) lib/lmb.c: In function 'lmb_add':
> > +(omapl138_lcdk) lib/lmb.c:356:39: error: 'lmb' is a pointer; did you m=
ean to use '->'?
> > +(omapl138_lcdk)   356 |         struct lmb_region *_rgn =3D &lmb.memor=
y;
> > +(omapl138_lcdk)       |                                       ^
> > +(omapl138_lcdk)       |                                       ->
> > +(omapl138_lcdk) lib/lmb.c: In function 'lmb_free':
> > +(omapl138_lcdk) lib/lmb.c:363:38: error: 'lmb' is a pointer; did you m=
ean to use '->'?
> > +(omapl138_lcdk)   363 |         struct lmb_region *rgn =3D &lmb.reserv=
ed;
> > +(omapl138_lcdk)       |                                      ^
> > +(omapl138_lcdk)       |                                      ->
> > +(omapl138_lcdk) lib/lmb.c: In function 'lmb_reserve_flags':
> > +(omapl138_lcdk) lib/lmb.c:414:39: error: 'lmb' is a pointer; did you m=
ean to use '->'?
> > +(omapl138_lcdk)   414 |         struct lmb_region *_rgn =3D &lmb.reser=
ved;
> > +(omapl138_lcdk) lib/lmb.c: In function '__lmb_alloc_base':
> > +(omapl138_lcdk) lib/lmb.c:451:21: error: 'lmb' is a pointer; did you m=
ean to use '->'?
> > +(omapl138_lcdk)   451 |         for (i =3D lmb.memory.cnt - 1; i >=3D =
0; i--) {
> > +(omapl138_lcdk)       |                     ^
> > +(omapl138_lcdk)       |                     ->
> > +(omapl138_lcdk) lib/lmb.c:452:42: error: 'lmb' is a pointer; did you m=
ean to use '->'?
> > +(omapl138_lcdk)   452 |                 phys_addr_t lmbbase =3D lmb.me=
mory.region[i].base;
> > +(omapl138_lcdk)       |                                          ^
> > +(omapl138_lcdk)       |                                          ->
> > +(omapl138_lcdk) lib/lmb.c:453:42: error: 'lmb' is a pointer; did you m=
ean to use '->'?
> > +(omapl138_lcdk)   453 |                 phys_size_t lmbsize =3D lmb.me=
mory.region[i].size;
> > +(omapl138_lcdk) lib/lmb.c:469:55: error: 'lmb' is a pointer; did you m=
ean to use '->'?
> > +(omapl138_lcdk)   469 |                         rgn =3D lmb_overlaps_r=
egion(&lmb.reserved, base, size);
> > +(omapl138_lcdk)       |                                               =
        ^
> > +(omapl138_lcdk)       |                                               =
        ->
> > +(omapl138_lcdk) lib/lmb.c:472:56: error: 'lmb' is a pointer; did you m=
ean to use '->'?
> > +(omapl138_lcdk)   472 |                                 if (lmb_add_re=
gion(&lmb.reserved, base,
> > +(omapl138_lcdk)       |                                               =
         ^
> > +(omapl138_lcdk)       |                                               =
         ->
> > +(omapl138_lcdk) lib/lmb.c:477:39: error: 'lmb' is a pointer; did you m=
ean to use '->'?
> > +(omapl138_lcdk)   477 |                         res_base =3D lmb.reser=
ved.region[rgn].base;
> > +(omapl138_lcdk) lib/lmb.c: In function 'lmb_alloc_addr':
> > +(omapl138_lcdk) lib/lmb.c:513:39: error: 'lmb' is a pointer; did you m=
ean to use '->'?
> > +(omapl138_lcdk)   513 |         rgn =3D lmb_overlaps_region(&lmb.memor=
y, base, size);
> > +(omapl138_lcdk) lib/lmb.c:519:42: error: 'lmb' is a pointer; did you m=
ean to use '->'?
> > +(omapl138_lcdk)   519 |                 if (lmb_addrs_overlap(lmb.memo=
ry.region[rgn].base,
> > +(omapl138_lcdk) lib/lmb.c:520:42: error: 'lmb' is a pointer; did you m=
ean to use '->'?
> > +(omapl138_lcdk)   520 |                                       lmb.memo=
ry.region[rgn].size,
> > +(omapl138_lcdk) lib/lmb.c: In function 'lmb_get_free_size':
> > +(omapl138_lcdk) lib/lmb.c:537:39: error: 'lmb' is a pointer; did you m=
ean to use '->'?
> > +(omapl138_lcdk)   537 |         rgn =3D lmb_overlaps_region(&lmb.memor=
y, addr, 1);
> > +(omapl138_lcdk) lib/lmb.c:539:36: error: 'lmb' is a pointer; did you m=
ean to use '->'?
> > +(omapl138_lcdk)   539 |                 for (i =3D 0; i < lmb.reserved=
=2Ecnt; i++) {
> > +(omapl138_lcdk)       |                                    ^
> > +(omapl138_lcdk)       |                                    ->
> > +(omapl138_lcdk) lib/lmb.c:540:39: error: 'lmb' is a pointer; did you m=
ean to use '->'?
> > +(omapl138_lcdk)   540 |                         if (addr < lmb.reserve=
d.region[i].base) {
> > +(omapl138_lcdk) lib/lmb.c:542:43: error: 'lmb' is a pointer; did you m=
ean to use '->'?
> > +(omapl138_lcdk)   542 |                                 return lmb.res=
erved.region[i].base - addr;
> > +(omapl138_lcdk)       |                                           ^
> > +(omapl138_lcdk)       |                                           ->
> > +(omapl138_lcdk) lib/lmb.c:544:32: error: 'lmb' is a pointer; did you m=
ean to use '->'?
> > +(omapl138_lcdk)   544 |                         if (lmb.reserved.regio=
n[i].base +
> > +(omapl138_lcdk)       |                                ^
> > +(omapl138_lcdk)       |                                ->
> > +(omapl138_lcdk) lib/lmb.c:545:32: error: 'lmb' is a pointer; did you m=
ean to use '->'?
> > +(omapl138_lcdk)   545 |                             lmb.reserved.regio=
n[i].size > addr) {
> > +(omapl138_lcdk) lib/lmb.c:551:27: error: 'lmb' is a pointer; did you m=
ean to use '->'?
> > +(omapl138_lcdk)   551 |                 return lmb.memory.region[lmb.m=
emory.cnt - 1].base +
> > +(omapl138_lcdk)       |                           ^
> > +(omapl138_lcdk)       |                           ->
> > +(omapl138_lcdk) lib/lmb.c:551:45: error: 'lmb' is a pointer; did you m=
ean to use '->'?
> > +(omapl138_lcdk)       |                                             ^
> > +(omapl138_lcdk)       |                                             ->
> > +(omapl138_lcdk) lib/lmb.c:552:27: error: 'lmb' is a pointer; did you m=
ean to use '->'?
> > +(omapl138_lcdk)   552 |                        lmb.memory.region[lmb.m=
emory.cnt - 1].size - addr;
> > +(omapl138_lcdk) lib/lmb.c:552:45: error: 'lmb' is a pointer; did you m=
ean to use '->'?
> > +(omapl138_lcdk) lib/lmb.c: In function 'lmb_is_reserved_flags':
> > +(omapl138_lcdk) lib/lmb.c:561:28: error: 'lmb' is a pointer; did you m=
ean to use '->'?
> > +(omapl138_lcdk)   561 |         for (i =3D 0; i < lmb.reserved.cnt; i+=
+) {
> > +(omapl138_lcdk)       |                            ^
> > +(omapl138_lcdk)       |                            ->
> > +(omapl138_lcdk) lib/lmb.c:562:40: error: 'lmb' is a pointer; did you m=
ean to use '->'?
> > +(omapl138_lcdk)   562 |                 phys_addr_t upper =3D lmb.rese=
rved.region[i].base +
> > +(omapl138_lcdk)       |                                        ^
> > +(omapl138_lcdk)       |                                        ->
> > +(omapl138_lcdk) lib/lmb.c:563:28: error: 'lmb' is a pointer; did you m=
ean to use '->'?
> > +(omapl138_lcdk)   563 |                         lmb.reserved.region[i]=
=2Esize - 1;
> > +(omapl138_lcdk) lib/lmb.c:564:33: error: 'lmb' is a pointer; did you m=
ean to use '->'?
> > +(omapl138_lcdk)   564 |                 if ((addr >=3D lmb.reserved.re=
gion[i].base) && (addr <=3D upper))
> > +(omapl138_lcdk)       |                                 ^
> > +(omapl138_lcdk)       |                                 ->
> > +(omapl138_lcdk) lib/lmb.c:565:36: error: 'lmb' is a pointer; did you m=
ean to use '->'?
> > +(omapl138_lcdk)   565 |                         return (lmb.reserved.r=
egion[i].flags & flags) =3D=3D flags;
> > +(omapl138_lcdk) make[2]: *** [scripts/Makefile.build:256: lib/lmb.o] E=
rror 1
> > +(omapl138_lcdk) make[1]: *** [Makefile:1892: lib] Error 2
> > +(omapl138_lcdk) make[3]: *** [scripts/Makefile.build:256: spl/lib/lmb.=
o] Error 1
> > +(omapl138_lcdk) make[2]: *** [scripts/Makefile.spl:538: spl/lib] Error=
 2
> > +(omapl138_lcdk) make[1]: *** [Makefile:2092: spl/u-boot-spl] Error 2
> > +(omapl138_lcdk) make: *** [Makefile:177: sub-make] Error 2
> > 05: lmb: remove local instances of the lmb structure variable
> > -(omapl138_lcdk) lib/lmb.c: In function 'lmb_dump_all_force':
> > -(omapl138_lcdk) lib/lmb.c:64:29: error: 'lmb' is a pointer; did you me=
an to use '->'?
> > -(omapl138_lcdk)    64 |         lmb_dump_region(&lmb.memory, "memory");
> > -(omapl138_lcdk)       |                             ^
> > -(omapl138_lcdk)       |                             ->
> > -(omapl138_lcdk) lib/lmb.c:65:29: error: 'lmb' is a pointer; did you me=
an to use '->'?
> > -(omapl138_lcdk)    65 |         lmb_dump_region(&lmb.reserved, "reserv=
ed");
> > -(omapl138_lcdk) lib/lmb.c: In function 'lmb_add':
> > -(omapl138_lcdk) lib/lmb.c:356:39: error: 'lmb' is a pointer; did you m=
ean to use '->'?
> > -(omapl138_lcdk)   356 |         struct lmb_region *_rgn =3D &lmb.memor=
y;
> > -(omapl138_lcdk)       |                                       ^
> > -(omapl138_lcdk)       |                                       ->
> > -(omapl138_lcdk) lib/lmb.c: In function 'lmb_free':
> > -(omapl138_lcdk) lib/lmb.c:363:38: error: 'lmb' is a pointer; did you m=
ean to use '->'?
> > -(omapl138_lcdk)   363 |         struct lmb_region *rgn =3D &lmb.reserv=
ed;
> > -(omapl138_lcdk)       |                                      ^
> > -(omapl138_lcdk)       |                                      ->
> > -(omapl138_lcdk) lib/lmb.c: In function 'lmb_reserve_flags':
> > -(omapl138_lcdk) lib/lmb.c:414:39: error: 'lmb' is a pointer; did you m=
ean to use '->'?
> > -(omapl138_lcdk)   414 |         struct lmb_region *_rgn =3D &lmb.reser=
ved;
> > -(omapl138_lcdk) lib/lmb.c: In function '__lmb_alloc_base':
> > -(omapl138_lcdk) lib/lmb.c:451:21: error: 'lmb' is a pointer; did you m=
ean to use '->'?
> > -(omapl138_lcdk)   451 |         for (i =3D lmb.memory.cnt - 1; i >=3D =
0; i--) {
> > -(omapl138_lcdk)       |                     ^
> > -(omapl138_lcdk)       |                     ->
> > -(omapl138_lcdk) lib/lmb.c:452:42: error: 'lmb' is a pointer; did you m=
ean to use '->'?
> > -(omapl138_lcdk)   452 |                 phys_addr_t lmbbase =3D lmb.me=
mory.region[i].base;
> > -(omapl138_lcdk)       |                                          ^
> > -(omapl138_lcdk)       |                                          ->
> > -(omapl138_lcdk) lib/lmb.c:453:42: error: 'lmb' is a pointer; did you m=
ean to use '->'?
> > -(omapl138_lcdk)   453 |                 phys_size_t lmbsize =3D lmb.me=
mory.region[i].size;
> > -(omapl138_lcdk) lib/lmb.c:469:55: error: 'lmb' is a pointer; did you m=
ean to use '->'?
> > -(omapl138_lcdk)   469 |                         rgn =3D lmb_overlaps_r=
egion(&lmb.reserved, base, size);
> > -(omapl138_lcdk)       |                                               =
        ^
> > -(omapl138_lcdk)       |                                               =
        ->
> > -(omapl138_lcdk) lib/lmb.c:472:56: error: 'lmb' is a pointer; did you m=
ean to use '->'?
> > -(omapl138_lcdk)   472 |                                 if (lmb_add_re=
gion(&lmb.reserved, base,
> > -(omapl138_lcdk)       |                                               =
         ^
> > -(omapl138_lcdk)       |                                               =
         ->
> > -(omapl138_lcdk) lib/lmb.c:477:39: error: 'lmb' is a pointer; did you m=
ean to use '->'?
> > -(omapl138_lcdk)   477 |                         res_base =3D lmb.reser=
ved.region[rgn].base;
> > -(omapl138_lcdk) lib/lmb.c: In function 'lmb_alloc_addr':
> > -(omapl138_lcdk) lib/lmb.c:513:39: error: 'lmb' is a pointer; did you m=
ean to use '->'?
> > -(omapl138_lcdk)   513 |         rgn =3D lmb_overlaps_region(&lmb.memor=
y, base, size);
> > -(omapl138_lcdk) lib/lmb.c:519:42: error: 'lmb' is a pointer; did you m=
ean to use '->'?
> > -(omapl138_lcdk)   519 |                 if (lmb_addrs_overlap(lmb.memo=
ry.region[rgn].base,
> > -(omapl138_lcdk) lib/lmb.c:520:42: error: 'lmb' is a pointer; did you m=
ean to use '->'?
> > -(omapl138_lcdk)   520 |                                       lmb.memo=
ry.region[rgn].size,
> > -(omapl138_lcdk) lib/lmb.c: In function 'lmb_get_free_size':
> > -(omapl138_lcdk) lib/lmb.c:537:39: error: 'lmb' is a pointer; did you m=
ean to use '->'?
> > -(omapl138_lcdk)   537 |         rgn =3D lmb_overlaps_region(&lmb.memor=
y, addr, 1);
> > -(omapl138_lcdk) lib/lmb.c:539:36: error: 'lmb' is a pointer; did you m=
ean to use '->'?
> > -(omapl138_lcdk)   539 |                 for (i =3D 0; i < lmb.reserved=
=2Ecnt; i++) {
> > -(omapl138_lcdk)       |                                    ^
> > -(omapl138_lcdk)       |                                    ->
> > -(omapl138_lcdk) lib/lmb.c:540:39: error: 'lmb' is a pointer; did you m=
ean to use '->'?
> > -(omapl138_lcdk)   540 |                         if (addr < lmb.reserve=
d.region[i].base) {
> > -(omapl138_lcdk) lib/lmb.c:542:43: error: 'lmb' is a pointer; did you m=
ean to use '->'?
> > -(omapl138_lcdk)   542 |                                 return lmb.res=
erved.region[i].base - addr;
> > -(omapl138_lcdk)       |                                           ^
> > -(omapl138_lcdk)       |                                           ->
> > -(omapl138_lcdk) lib/lmb.c:544:32: error: 'lmb' is a pointer; did you m=
ean to use '->'?
> > -(omapl138_lcdk)   544 |                         if (lmb.reserved.regio=
n[i].base +
> > -(omapl138_lcdk)       |                                ^
> > -(omapl138_lcdk)       |                                ->
> > -(omapl138_lcdk) lib/lmb.c:545:32: error: 'lmb' is a pointer; did you m=
ean to use '->'?
> > -(omapl138_lcdk)   545 |                             lmb.reserved.regio=
n[i].size > addr) {
> > -(omapl138_lcdk) lib/lmb.c:551:27: error: 'lmb' is a pointer; did you m=
ean to use '->'?
> > -(omapl138_lcdk)   551 |                 return lmb.memory.region[lmb.m=
emory.cnt - 1].base +
> > -(omapl138_lcdk)       |                           ^
> > -(omapl138_lcdk)       |                           ->
> > -(omapl138_lcdk) lib/lmb.c:551:45: error: 'lmb' is a pointer; did you m=
ean to use '->'?
> > -(omapl138_lcdk)       |                                             ^
> > -(omapl138_lcdk)       |                                             ->
> > -(omapl138_lcdk) lib/lmb.c:552:27: error: 'lmb' is a pointer; did you m=
ean to use '->'?
> > -(omapl138_lcdk)   552 |                        lmb.memory.region[lmb.m=
emory.cnt - 1].size - addr;
> > -(omapl138_lcdk) lib/lmb.c:552:45: error: 'lmb' is a pointer; did you m=
ean to use '->'?
> > -(omapl138_lcdk) lib/lmb.c: In function 'lmb_is_reserved_flags':
> > -(omapl138_lcdk) lib/lmb.c:561:28: error: 'lmb' is a pointer; did you m=
ean to use '->'?
> > -(omapl138_lcdk)   561 |         for (i =3D 0; i < lmb.reserved.cnt; i+=
+) {
> > -(omapl138_lcdk)       |                            ^
> > -(omapl138_lcdk)       |                            ->
> > -(omapl138_lcdk) lib/lmb.c:562:40: error: 'lmb' is a pointer; did you m=
ean to use '->'?
> > -(omapl138_lcdk)   562 |                 phys_addr_t upper =3D lmb.rese=
rved.region[i].base +
> > -(omapl138_lcdk)       |                                        ^
> > -(omapl138_lcdk)       |                                        ->
> > -(omapl138_lcdk) lib/lmb.c:563:28: error: 'lmb' is a pointer; did you m=
ean to use '->'?
> > -(omapl138_lcdk)   563 |                         lmb.reserved.region[i]=
=2Esize - 1;
> > -(omapl138_lcdk) lib/lmb.c:564:33: error: 'lmb' is a pointer; did you m=
ean to use '->'?
> > -(omapl138_lcdk)   564 |                 if ((addr >=3D lmb.reserved.re=
gion[i].base) && (addr <=3D upper))
> > -(omapl138_lcdk)       |                                 ^
> > -(omapl138_lcdk)       |                                 ->
> > -(omapl138_lcdk) lib/lmb.c:565:36: error: 'lmb' is a pointer; did you m=
ean to use '->'?
> > -(omapl138_lcdk)   565 |                         return (lmb.reserved.r=
egion[i].flags & flags) =3D=3D flags;
> > -(omapl138_lcdk) make[2]: *** [scripts/Makefile.build:256: lib/lmb.o] E=
rror 1
> > -(omapl138_lcdk) make[1]: *** [Makefile:1892: lib] Error 2
> > -(omapl138_lcdk) make[3]: *** [scripts/Makefile.build:256: spl/lib/lmb.=
o] Error 1
> > -(omapl138_lcdk) make[2]: *** [scripts/Makefile.spl:538: spl/lib] Error=
 2
> > +(omapl138_lcdk) boot/image-board.c: In function 'image_setup_linux':
> > +(omapl138_lcdk) boot/image-board.c:907:65: error: 'lmb' undeclared (fi=
rst use in this function)
> > +(omapl138_lcdk)   907 |                 ret =3D image_setup_libfdt(ima=
ges, *of_flat_tree, lmb);
> > +(omapl138_lcdk)       |                                               =
                  ^~~
> > +(omapl138_lcdk) boot/image-board.c:907:65: note: each undeclared ident=
ifier is reported only once for each function it appears in
> > +(omapl138_lcdk) make[2]: *** [scripts/Makefile.build:256: boot/image-b=
oard.o] Error 1
> > +(omapl138_lcdk) make[1]: *** [Makefile:1892: boot] Error 2
> > +(omapl138_lcdk) make[3]: *** [scripts/Makefile.build:257: spl/boot/ima=
ge-board.o] Error 1
> > +(omapl138_lcdk) make[2]: *** [scripts/Makefile.spl:538: spl/boot] Erro=
r 2
> > 06: lmb: pass a flag to image_setup_libfdt() for lmb reservations
> >        arm:     omapl138_lcdk
> > -(omapl138_lcdk) boot/image-board.c: In function 'image_setup_linux':
> > -(omapl138_lcdk) boot/image-board.c:907:65: error: 'lmb' undeclared (fi=
rst use in this function)
> > -(omapl138_lcdk)   907 |                 ret =3D image_setup_libfdt(ima=
ges, *of_flat_tree, lmb);
> > -(omapl138_lcdk)       |                                               =
                  ^~~
> > -(omapl138_lcdk) boot/image-board.c:907:65: note: each undeclared ident=
ifier is reported only once for each function it appears in
> > -(omapl138_lcdk) make[2]: *** [scripts/Makefile.build:256: boot/image-b=
oard.o] Error 1
> > -(omapl138_lcdk) make[1]: *** [Makefile:1892: boot] Error 2
> > -(omapl138_lcdk) make[3]: *** [scripts/Makefile.build:257: spl/boot/ima=
ge-board.o] Error 1
> > -(omapl138_lcdk) make[2]: *** [scripts/Makefile.spl:538: spl/boot] Erro=
r 2
> > -(omapl138_lcdk) make[1]: *** [Makefile:2092: spl/u-boot-spl] Error 2
> > -(omapl138_lcdk) make: *** [Makefile:177: sub-make] Error 2
> > 07: lmb: reserve and add common memory regions post relocation
> >        arm:  +   omapl138_lcdk
> > +(omapl138_lcdk) common/board_r.c: In function 'initr_lmb':
> > +(omapl138_lcdk) common/board_r.c:564:9: error: implicit declaration of=
 function 'lmb_add_memory' [-Werror=3Dimplicit-function-declaration]
> > +(omapl138_lcdk)   564 |         lmb_add_memory(gd->bd);
> > +(omapl138_lcdk)       |         ^~~~~~~~~~~~~~
> > +(omapl138_lcdk) cc1: all warnings being treated as errors
> > +(omapl138_lcdk) make[2]: *** [scripts/Makefile.build:256: common/board=
_r.o] Error 1
> > +(omapl138_lcdk) make[1]: *** [Makefile:1892: common] Error 2
> > +(omapl138_lcdk) make: *** [Makefile:177: sub-make] Error 2
> > 08: lmb: remove lmb_init_and_reserve_range() function
> > 09: lmb: replcace the lmb_init_and_reserve() function
> >        arm:     omapl138_lcdk
> > -(omapl138_lcdk) common/board_r.c: In function 'initr_lmb':
> > -(omapl138_lcdk) common/board_r.c:564:9: error: implicit declaration of=
 function 'lmb_add_memory' [-Werror=3Dimplicit-function-declaration]
> > -(omapl138_lcdk)   564 |         lmb_add_memory(gd->bd);
> > -(omapl138_lcdk)       |         ^~~~~~~~~~~~~~
> > -(omapl138_lcdk) cc1: all warnings being treated as errors
> > -(omapl138_lcdk) make[2]: *** [scripts/Makefile.build:256: common/board=
_r.o] Error 1
> > -(omapl138_lcdk) make[1]: *** [Makefile:1892: common] Error 2
> > -(omapl138_lcdk) make: *** [Makefile:177: sub-make] Error 2
> > 10: lmb: allow for resizing lmb regions
> >        arm: (for 1/1 boards) all +224.0 text +224.0
> >             omapl138_lcdk  : all +224 text +224
> >                u-boot: add: 0/0, grow: 1/0 bytes: 224/0 (224)
> >                  function                                   old     new=
   delta
> >                  lmb_add_region_flags                       416     640=
    +224
> > 11: event: add events to notify memory map changes
> > 12: lib: Kconfig: add a config symbol for getting memory map updates
> > 13: add a function to check if an address is in RAM memory
> > 14: efi_memory: notify of any changes to the EFI memory map
> > 15: lmb: notify of any changes to the LMB memory map
> >        arm: (for 1/1 boards) all +8.0 text +8.0
> >             omapl138_lcdk  : all +8 text +8
> >                u-boot: add: 0/0, grow: 2/0 bytes: 12/0 (12)
> >                  function                                   old     new=
   delta
> >                  lmb_reserve_flags                           32      40=
      +8
> >                  lmb_free                                   192     196=
      +4
> > 16: efi_memory: add an event handler to update memory map
> > 17: lmb: add an event handler to update memory map
> >        arm: (for 1/1 boards) all +349.0 rodata +61.0 text +288.0
> >             omapl138_lcdk  : all +349 rodata +61 text +288
> >                u-boot: add: 3/0, grow: 3/0 bytes: 232/0 (232)
> >                  function                                   old     new=
   delta
> >                  event_notify                                 -     104=
    +104
> >                  initcall_run_list                           96     144=
     +48
> >                  image_setup_libfdt                         236     284=
     +48
> >                  event_notify_null                            -      18=
     +18
> >                  event_type_name                              -       8=
      +8
> >                  run_main_loop                               10      16=
      +6
> > 18: lmb: remove call to efi_lmb_reserve()
> > 19: sandbox: iommu: remove lmb allocation in the driver
> > 20: zynq: lmb: do not add to lmb map before relocation
> > 21: test: cedit: use allocated address for reading file
> > 22: test: event: update the expected event dump output
> > 23: test: lmb: run the LMB tests only on sandbox
> > 24: test: lmb: initialise the lmb structure before tests
> > 25: test: lmb: add a test case for checking overlapping region add
> > 26: test: lmb: adjust the test case to handle overlapping regions
> > 27: test: lmb: run lmb tests only manually
> > 28: test: bdinfo: dump the global LMB memory map
> > 29: cmd: bdinfo: only dump the current LMB memory
> >        arm: (for 1/1 boards) all -8.0 text -8.0
> >             omapl138_lcdk  : all -8 text -8
> >                u-boot: add: 0/0, grow: 0/-1 bytes: 0/-8 (-8)
> >                  function                                   old     new=
   delta
> >                  do_bdinfo                                  472     464=
      -8
> > 30: temp: mx6sabresd: bump up the size limit of the board
> >
> > So my first thought is, do we really need the event notifier framework
> > in the case where it's NOT also using EFI_LOADER? Or is perhaps that
> > Kconfig logic not quite right?
>=20
> So, I had actually tried putting all the notification code under the
> newly introduced config symbol, but I get build warnings on sandbox
> spl and sandbox vpl builds, which result in CI failures. I would have
> thought that having the function call under a CONFIG_IS_ENABLED check
> would result in the linker to discard the function call. But that is
> not happening. I will check if this can be handled by introducing SPL,
> TPL and VPL variants of this config.

It's also possible that some stages aren't passing
-ffunction-sections/-fdata-sections/--gc-sections ? A testing option
would be to enable (and be sure it's used) LTO ?

--=20
Tom

--muwyrQfI6C4AdeUz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZoYbwACgkQFHw5/5Y0
tywoqgwAs9GUEOxxwHPVDdqPg3b8JEz7nlAhmO61YPH5582cDvd4AC3xxFAVRDAj
8JdlqjOt4NQIhakzWWIJtvrbnGkgFSWNpnTBwIIfRj04JVwnxG+x2bIt5NL4z8PX
b9sT7VQNp428DM39gcz1lLqVGXQYf/dxGCeszspdwDjO+LvotUgMxG0C8wbfe0AJ
qkYKGe5KBY+gP+Dl3xhjcekVZ8NRcCuW4BGCOJHO7oz1nmVpjBqYJ/SSEsCdQ605
icMDfG9wNeEpdp/NtspbN2Mnp3Q/UUqfr3IBWNjqU7BD1j6Xh+r9AsPFm2pn0EQp
SeKP4ukRMGd5a4e7EIxiRySK1bmVr5EfKfd8CTw8VqTizubbjeSWohoR9WsISEsD
wv9yObelXiXr8jAJudVJOJDJJ9ty9aWlPimHPpVTArqhNk1rRYqI6txkvQ+EsMs2
pUiyDZyG9e9Ue7zrlYte5ocxRwa/oVuTD8EW5o4U6cmWN3V3XXU7uT6wNg/F3BUb
CrmgyXkt
=xaQQ
-----END PGP SIGNATURE-----

--muwyrQfI6C4AdeUz--
