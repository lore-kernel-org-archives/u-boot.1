Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0094DC27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 21:06:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1677E88356;
	Mon, 10 Jun 2024 23:05:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CNnFqYjN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04DE78825E; Mon, 10 Jun 2024 23:05:58 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE5AE88356
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 23:05:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5b9706c84e5so2789266eaf.1
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 14:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718053553; x=1718658353; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Yg9FHleTTDZyNUW/9dRsG34/2GxbeMxedVVbVqmeWQQ=;
 b=CNnFqYjNFAAQEZ1EoHkXhzwX/5PhhpF/5ULYol2Rn5VH9+yRdR39XmLcqOcRLA+huU
 Jsr2aKAELTkRiUQhOpj7dCE7/lGMTx4u0E4XVI4zqnex2ywMr+7RhR4DTWNY9V/NdZtv
 Nlc7I/joJm88t5bNjy1ATG8CAtlfdMfeYcEm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718053553; x=1718658353;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yg9FHleTTDZyNUW/9dRsG34/2GxbeMxedVVbVqmeWQQ=;
 b=uFtZNJWmp6HNd+Bd9RA4CMr18qIWPO6JSYg3dXOcKqOD674DivIJ9b1wfX+wEex7xf
 G/kcSkWXnvUJwH0S8yVT5m6zmEUqWQn6cXGC5yto85GUcLhZeC4UhOJMpuOttwZrCcaM
 mbAgnOMyO+sEGOB44d74wlnqs6Ja+IO1CFocEfVeoYS7ChTGMN5Omlijsp8Zc+K27OKk
 tT/Ky8iRhcGTQuPIV4ROJqgR47SKLRsPNcpEoHGc9dZHAZI+Lvg6MYtPHl2lmPFFyz/j
 mBqQ+0dL82E7KRbF+iHA4Eyovw3RRjA/cimUir44deZhySZfymey4xagu4zL966U2j2V
 dQLQ==
X-Gm-Message-State: AOJu0YxEBbJwvBiXsR+pDDFQQiFqLB7y1oMnJBrotuGQIXVb3fRUy1xV
 rN/HmmerOl3vVjz08sWkD5wsWULy3K5bcMwaFoBFkMhCdH1rs/dTrzfMYDBJpJI=
X-Google-Smtp-Source: AGHT+IHnFk/0lXbXyQ6vXYwH3USTFUJEzdr1ldqhPPLg/pbrXYuW35yaK3Yp385dvJn2xQ3WiuBv8Q==
X-Received: by 2002:a05:6820:2210:b0:5bb:1b9d:24d7 with SMTP id
 006d021491bc7-5bb1b9d28cemr1879404eaf.6.1718053553075; 
 Mon, 10 Jun 2024 14:05:53 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5ba97692e45sm1820204eaf.3.2024.06.10.14.05.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 14:05:52 -0700 (PDT)
Date: Mon, 10 Jun 2024 15:05:50 -0600
From: Tom Rini <trini@konsulko.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Fabio Estevam <festevam@gmail.com>
Subject: Re: [RFC PATCH 00/31] Make U-Boot memory reservations coherent
Message-ID: <20240610210550.GA68077@bill-the-cat>
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UCYPEkmQuxf8k5ff"
Content-Disposition: inline
In-Reply-To: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
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


--UCYPEkmQuxf8k5ff
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 08, 2024 at 12:22:09AM +0530, Sughosh Ganu wrote:

> The aim of this patch series is to fix the current state of
> incoherence between modules when it comes to memory usage. The primary
> issue that this series is trying to fix is that the EFI memory module
> which is responsible for allocating and freeing memory, does not have
> any visibility of the memory that is being used by the LMB
> module. This is further complicated by the fact that the LMB
> allocations are caller specific -- the LMB memory map is not global
> nor persistent. This means that the memory "allocated" by the LMB
> module might be relevant only for a given function. Hence one of the
> requirements for making the memory usage visible across modules is to
> make LMB allocations persistent and global, and then have means to
> communicate the use of memory across modules.
>=20
> The first set of patches in this series work on making the LMB memory
> map persistent and global. This is being done keeping in mind the
> usage of LMB memory by platforms where the same memory region can be
> used to load multiple different images. What is not allowed is to
> overwrite memory that has been allocated by the other module,
> currently the EFI memory module. This is being achieved by introducing
> a new flag, LMB_NOOVERWRITE, which represents memory which cannot be
> re-requested once allocated.
>=20
> The second set of patches are then introducing a notification
> mechanism to indicate any changes to a respective module's memory
> map. This way, any memory allocation/reservation by a module gets
> notified to any interested listners, who then update their memory map
> accordingly, thus keeping memory usage coherent.
>=20
> Todo's
> ------
> I have run these patches through CI, but the LMB unit tests need an
> overhaul. I have currently marked these tests for manual run, as
> running these would obviously tamper the LMB memory map, thus
> affecting subsequent tests. The current set of LMB tests are written
> with the assumption of local LMB memory maps. This needs to be
> reworked.
>=20
> Secondly, there needs to be a test written for testing the various
> scenarios of memory being allocated and freed by different modules,
> namely LMB and EFI. I have written a couple of commands for testing
> the changes that I have made -- I have also included these temporary
> commands to assist anyone who might want to test these changes. But I
> will be working on adding a more comprehensive test.
>=20
> Lastly, as the series touches common code, there is obviously an
> increase in the size of the image, moreover since the LMB memory is
> now persistent, and the variables do not reside on the stack. I want
> to check if there can be ways of decreasing the size impact of the
> changes.

So, I think you made some changes between your last CI run and posting?
A ton of platforms (basically anything with EFI_LOADER disabled) fail to
build now because the two "temp" commits at the end of the series are
always enabled. I took those commits out and ran my world build size
check tests and the results are at:
https://gist.github.com/trini/d42bd392463c39766a5f872c190ccf27

And 64bit ARM looks very reasonable, but I wonder if we can improve the
32bit ARM results?

I also did an every commit run for a 32bit ARM board without EFI_LOADER
(which is going to be the case for size constrained systems) and see
that the series isn't bisect'able to start with, so please fix that for
the next go-round. That said:
Summary of 30 commits for 1 boards (1 thread, 12 jobs per thread)
01: Added arm64 assembly for examples/api crt0
02: lmb: remove the unused lmb_is_reserved() function
03: lmb: staticize __lmb_alloc_base()
       arm: (for 1/1 boards) all -16.0 text -16.0
            omapl138_lcdk  : all -16 text -16
               u-boot: add: 0/-1, grow: 1/0 bytes: 172/-186 (-14)
                 function                                   old     new   d=
elta
                 lmb_alloc_base                              40     212    =
+172
                 __lmb_alloc_base                           186       -    =
-186
04: lmb: make the lmb reservations persistent
       arm:  +   omapl138_lcdk
+(omapl138_lcdk) lib/lmb.c: In function 'lmb_dump_all_force':
+(omapl138_lcdk) lib/lmb.c:64:29: error: 'lmb' is a pointer; did you mean t=
o use '->'?
+(omapl138_lcdk)    64 |         lmb_dump_region(&lmb.memory, "memory");
+(omapl138_lcdk)       |                             ^
+(omapl138_lcdk)       |                             ->
+(omapl138_lcdk) lib/lmb.c:65:29: error: 'lmb' is a pointer; did you mean t=
o use '->'?
+(omapl138_lcdk)    65 |         lmb_dump_region(&lmb.reserved, "reserved");
+(omapl138_lcdk) lib/lmb.c: In function 'lmb_add':
+(omapl138_lcdk) lib/lmb.c:356:39: error: 'lmb' is a pointer; did you mean =
to use '->'?
+(omapl138_lcdk)   356 |         struct lmb_region *_rgn =3D &lmb.memory;
+(omapl138_lcdk)       |                                       ^
+(omapl138_lcdk)       |                                       ->
+(omapl138_lcdk) lib/lmb.c: In function 'lmb_free':
+(omapl138_lcdk) lib/lmb.c:363:38: error: 'lmb' is a pointer; did you mean =
to use '->'?
+(omapl138_lcdk)   363 |         struct lmb_region *rgn =3D &lmb.reserved;
+(omapl138_lcdk)       |                                      ^
+(omapl138_lcdk)       |                                      ->
+(omapl138_lcdk) lib/lmb.c: In function 'lmb_reserve_flags':
+(omapl138_lcdk) lib/lmb.c:414:39: error: 'lmb' is a pointer; did you mean =
to use '->'?
+(omapl138_lcdk)   414 |         struct lmb_region *_rgn =3D &lmb.reserved;
+(omapl138_lcdk) lib/lmb.c: In function '__lmb_alloc_base':
+(omapl138_lcdk) lib/lmb.c:451:21: error: 'lmb' is a pointer; did you mean =
to use '->'?
+(omapl138_lcdk)   451 |         for (i =3D lmb.memory.cnt - 1; i >=3D 0; i=
--) {
+(omapl138_lcdk)       |                     ^
+(omapl138_lcdk)       |                     ->
+(omapl138_lcdk) lib/lmb.c:452:42: error: 'lmb' is a pointer; did you mean =
to use '->'?
+(omapl138_lcdk)   452 |                 phys_addr_t lmbbase =3D lmb.memory=
=2Eregion[i].base;
+(omapl138_lcdk)       |                                          ^
+(omapl138_lcdk)       |                                          ->
+(omapl138_lcdk) lib/lmb.c:453:42: error: 'lmb' is a pointer; did you mean =
to use '->'?
+(omapl138_lcdk)   453 |                 phys_size_t lmbsize =3D lmb.memory=
=2Eregion[i].size;
+(omapl138_lcdk) lib/lmb.c:469:55: error: 'lmb' is a pointer; did you mean =
to use '->'?
+(omapl138_lcdk)   469 |                         rgn =3D lmb_overlaps_regio=
n(&lmb.reserved, base, size);
+(omapl138_lcdk)       |                                                   =
    ^
+(omapl138_lcdk)       |                                                   =
    ->
+(omapl138_lcdk) lib/lmb.c:472:56: error: 'lmb' is a pointer; did you mean =
to use '->'?
+(omapl138_lcdk)   472 |                                 if (lmb_add_region=
(&lmb.reserved, base,
+(omapl138_lcdk)       |                                                   =
     ^
+(omapl138_lcdk)       |                                                   =
     ->
+(omapl138_lcdk) lib/lmb.c:477:39: error: 'lmb' is a pointer; did you mean =
to use '->'?
+(omapl138_lcdk)   477 |                         res_base =3D lmb.reserved.=
region[rgn].base;
+(omapl138_lcdk) lib/lmb.c: In function 'lmb_alloc_addr':
+(omapl138_lcdk) lib/lmb.c:513:39: error: 'lmb' is a pointer; did you mean =
to use '->'?
+(omapl138_lcdk)   513 |         rgn =3D lmb_overlaps_region(&lmb.memory, b=
ase, size);
+(omapl138_lcdk) lib/lmb.c:519:42: error: 'lmb' is a pointer; did you mean =
to use '->'?
+(omapl138_lcdk)   519 |                 if (lmb_addrs_overlap(lmb.memory.r=
egion[rgn].base,
+(omapl138_lcdk) lib/lmb.c:520:42: error: 'lmb' is a pointer; did you mean =
to use '->'?
+(omapl138_lcdk)   520 |                                       lmb.memory.r=
egion[rgn].size,
+(omapl138_lcdk) lib/lmb.c: In function 'lmb_get_free_size':
+(omapl138_lcdk) lib/lmb.c:537:39: error: 'lmb' is a pointer; did you mean =
to use '->'?
+(omapl138_lcdk)   537 |         rgn =3D lmb_overlaps_region(&lmb.memory, a=
ddr, 1);
+(omapl138_lcdk) lib/lmb.c:539:36: error: 'lmb' is a pointer; did you mean =
to use '->'?
+(omapl138_lcdk)   539 |                 for (i =3D 0; i < lmb.reserved.cnt=
; i++) {
+(omapl138_lcdk)       |                                    ^
+(omapl138_lcdk)       |                                    ->
+(omapl138_lcdk) lib/lmb.c:540:39: error: 'lmb' is a pointer; did you mean =
to use '->'?
+(omapl138_lcdk)   540 |                         if (addr < lmb.reserved.re=
gion[i].base) {
+(omapl138_lcdk) lib/lmb.c:542:43: error: 'lmb' is a pointer; did you mean =
to use '->'?
+(omapl138_lcdk)   542 |                                 return lmb.reserve=
d.region[i].base - addr;
+(omapl138_lcdk)       |                                           ^
+(omapl138_lcdk)       |                                           ->
+(omapl138_lcdk) lib/lmb.c:544:32: error: 'lmb' is a pointer; did you mean =
to use '->'?
+(omapl138_lcdk)   544 |                         if (lmb.reserved.region[i]=
=2Ebase +
+(omapl138_lcdk)       |                                ^
+(omapl138_lcdk)       |                                ->
+(omapl138_lcdk) lib/lmb.c:545:32: error: 'lmb' is a pointer; did you mean =
to use '->'?
+(omapl138_lcdk)   545 |                             lmb.reserved.region[i]=
=2Esize > addr) {
+(omapl138_lcdk) lib/lmb.c:551:27: error: 'lmb' is a pointer; did you mean =
to use '->'?
+(omapl138_lcdk)   551 |                 return lmb.memory.region[lmb.memor=
y.cnt - 1].base +
+(omapl138_lcdk)       |                           ^
+(omapl138_lcdk)       |                           ->
+(omapl138_lcdk) lib/lmb.c:551:45: error: 'lmb' is a pointer; did you mean =
to use '->'?
+(omapl138_lcdk)       |                                             ^
+(omapl138_lcdk)       |                                             ->
+(omapl138_lcdk) lib/lmb.c:552:27: error: 'lmb' is a pointer; did you mean =
to use '->'?
+(omapl138_lcdk)   552 |                        lmb.memory.region[lmb.memor=
y.cnt - 1].size - addr;
+(omapl138_lcdk) lib/lmb.c:552:45: error: 'lmb' is a pointer; did you mean =
to use '->'?
+(omapl138_lcdk) lib/lmb.c: In function 'lmb_is_reserved_flags':
+(omapl138_lcdk) lib/lmb.c:561:28: error: 'lmb' is a pointer; did you mean =
to use '->'?
+(omapl138_lcdk)   561 |         for (i =3D 0; i < lmb.reserved.cnt; i++) {
+(omapl138_lcdk)       |                            ^
+(omapl138_lcdk)       |                            ->
+(omapl138_lcdk) lib/lmb.c:562:40: error: 'lmb' is a pointer; did you mean =
to use '->'?
+(omapl138_lcdk)   562 |                 phys_addr_t upper =3D lmb.reserved=
=2Eregion[i].base +
+(omapl138_lcdk)       |                                        ^
+(omapl138_lcdk)       |                                        ->
+(omapl138_lcdk) lib/lmb.c:563:28: error: 'lmb' is a pointer; did you mean =
to use '->'?
+(omapl138_lcdk)   563 |                         lmb.reserved.region[i].siz=
e - 1;
+(omapl138_lcdk) lib/lmb.c:564:33: error: 'lmb' is a pointer; did you mean =
to use '->'?
+(omapl138_lcdk)   564 |                 if ((addr >=3D lmb.reserved.region=
[i].base) && (addr <=3D upper))
+(omapl138_lcdk)       |                                 ^
+(omapl138_lcdk)       |                                 ->
+(omapl138_lcdk) lib/lmb.c:565:36: error: 'lmb' is a pointer; did you mean =
to use '->'?
+(omapl138_lcdk)   565 |                         return (lmb.reserved.regio=
n[i].flags & flags) =3D=3D flags;
+(omapl138_lcdk) make[2]: *** [scripts/Makefile.build:256: lib/lmb.o] Error=
 1
+(omapl138_lcdk) make[1]: *** [Makefile:1892: lib] Error 2
+(omapl138_lcdk) make[3]: *** [scripts/Makefile.build:256: spl/lib/lmb.o] E=
rror 1
+(omapl138_lcdk) make[2]: *** [scripts/Makefile.spl:538: spl/lib] Error 2
+(omapl138_lcdk) make[1]: *** [Makefile:2092: spl/u-boot-spl] Error 2
+(omapl138_lcdk) make: *** [Makefile:177: sub-make] Error 2
05: lmb: remove local instances of the lmb structure variable
-(omapl138_lcdk) lib/lmb.c: In function 'lmb_dump_all_force':
-(omapl138_lcdk) lib/lmb.c:64:29: error: 'lmb' is a pointer; did you mean t=
o use '->'?
-(omapl138_lcdk)    64 |         lmb_dump_region(&lmb.memory, "memory");
-(omapl138_lcdk)       |                             ^
-(omapl138_lcdk)       |                             ->
-(omapl138_lcdk) lib/lmb.c:65:29: error: 'lmb' is a pointer; did you mean t=
o use '->'?
-(omapl138_lcdk)    65 |         lmb_dump_region(&lmb.reserved, "reserved");
-(omapl138_lcdk) lib/lmb.c: In function 'lmb_add':
-(omapl138_lcdk) lib/lmb.c:356:39: error: 'lmb' is a pointer; did you mean =
to use '->'?
-(omapl138_lcdk)   356 |         struct lmb_region *_rgn =3D &lmb.memory;
-(omapl138_lcdk)       |                                       ^
-(omapl138_lcdk)       |                                       ->
-(omapl138_lcdk) lib/lmb.c: In function 'lmb_free':
-(omapl138_lcdk) lib/lmb.c:363:38: error: 'lmb' is a pointer; did you mean =
to use '->'?
-(omapl138_lcdk)   363 |         struct lmb_region *rgn =3D &lmb.reserved;
-(omapl138_lcdk)       |                                      ^
-(omapl138_lcdk)       |                                      ->
-(omapl138_lcdk) lib/lmb.c: In function 'lmb_reserve_flags':
-(omapl138_lcdk) lib/lmb.c:414:39: error: 'lmb' is a pointer; did you mean =
to use '->'?
-(omapl138_lcdk)   414 |         struct lmb_region *_rgn =3D &lmb.reserved;
-(omapl138_lcdk) lib/lmb.c: In function '__lmb_alloc_base':
-(omapl138_lcdk) lib/lmb.c:451:21: error: 'lmb' is a pointer; did you mean =
to use '->'?
-(omapl138_lcdk)   451 |         for (i =3D lmb.memory.cnt - 1; i >=3D 0; i=
--) {
-(omapl138_lcdk)       |                     ^
-(omapl138_lcdk)       |                     ->
-(omapl138_lcdk) lib/lmb.c:452:42: error: 'lmb' is a pointer; did you mean =
to use '->'?
-(omapl138_lcdk)   452 |                 phys_addr_t lmbbase =3D lmb.memory=
=2Eregion[i].base;
-(omapl138_lcdk)       |                                          ^
-(omapl138_lcdk)       |                                          ->
-(omapl138_lcdk) lib/lmb.c:453:42: error: 'lmb' is a pointer; did you mean =
to use '->'?
-(omapl138_lcdk)   453 |                 phys_size_t lmbsize =3D lmb.memory=
=2Eregion[i].size;
-(omapl138_lcdk) lib/lmb.c:469:55: error: 'lmb' is a pointer; did you mean =
to use '->'?
-(omapl138_lcdk)   469 |                         rgn =3D lmb_overlaps_regio=
n(&lmb.reserved, base, size);
-(omapl138_lcdk)       |                                                   =
    ^
-(omapl138_lcdk)       |                                                   =
    ->
-(omapl138_lcdk) lib/lmb.c:472:56: error: 'lmb' is a pointer; did you mean =
to use '->'?
-(omapl138_lcdk)   472 |                                 if (lmb_add_region=
(&lmb.reserved, base,
-(omapl138_lcdk)       |                                                   =
     ^
-(omapl138_lcdk)       |                                                   =
     ->
-(omapl138_lcdk) lib/lmb.c:477:39: error: 'lmb' is a pointer; did you mean =
to use '->'?
-(omapl138_lcdk)   477 |                         res_base =3D lmb.reserved.=
region[rgn].base;
-(omapl138_lcdk) lib/lmb.c: In function 'lmb_alloc_addr':
-(omapl138_lcdk) lib/lmb.c:513:39: error: 'lmb' is a pointer; did you mean =
to use '->'?
-(omapl138_lcdk)   513 |         rgn =3D lmb_overlaps_region(&lmb.memory, b=
ase, size);
-(omapl138_lcdk) lib/lmb.c:519:42: error: 'lmb' is a pointer; did you mean =
to use '->'?
-(omapl138_lcdk)   519 |                 if (lmb_addrs_overlap(lmb.memory.r=
egion[rgn].base,
-(omapl138_lcdk) lib/lmb.c:520:42: error: 'lmb' is a pointer; did you mean =
to use '->'?
-(omapl138_lcdk)   520 |                                       lmb.memory.r=
egion[rgn].size,
-(omapl138_lcdk) lib/lmb.c: In function 'lmb_get_free_size':
-(omapl138_lcdk) lib/lmb.c:537:39: error: 'lmb' is a pointer; did you mean =
to use '->'?
-(omapl138_lcdk)   537 |         rgn =3D lmb_overlaps_region(&lmb.memory, a=
ddr, 1);
-(omapl138_lcdk) lib/lmb.c:539:36: error: 'lmb' is a pointer; did you mean =
to use '->'?
-(omapl138_lcdk)   539 |                 for (i =3D 0; i < lmb.reserved.cnt=
; i++) {
-(omapl138_lcdk)       |                                    ^
-(omapl138_lcdk)       |                                    ->
-(omapl138_lcdk) lib/lmb.c:540:39: error: 'lmb' is a pointer; did you mean =
to use '->'?
-(omapl138_lcdk)   540 |                         if (addr < lmb.reserved.re=
gion[i].base) {
-(omapl138_lcdk) lib/lmb.c:542:43: error: 'lmb' is a pointer; did you mean =
to use '->'?
-(omapl138_lcdk)   542 |                                 return lmb.reserve=
d.region[i].base - addr;
-(omapl138_lcdk)       |                                           ^
-(omapl138_lcdk)       |                                           ->
-(omapl138_lcdk) lib/lmb.c:544:32: error: 'lmb' is a pointer; did you mean =
to use '->'?
-(omapl138_lcdk)   544 |                         if (lmb.reserved.region[i]=
=2Ebase +
-(omapl138_lcdk)       |                                ^
-(omapl138_lcdk)       |                                ->
-(omapl138_lcdk) lib/lmb.c:545:32: error: 'lmb' is a pointer; did you mean =
to use '->'?
-(omapl138_lcdk)   545 |                             lmb.reserved.region[i]=
=2Esize > addr) {
-(omapl138_lcdk) lib/lmb.c:551:27: error: 'lmb' is a pointer; did you mean =
to use '->'?
-(omapl138_lcdk)   551 |                 return lmb.memory.region[lmb.memor=
y.cnt - 1].base +
-(omapl138_lcdk)       |                           ^
-(omapl138_lcdk)       |                           ->
-(omapl138_lcdk) lib/lmb.c:551:45: error: 'lmb' is a pointer; did you mean =
to use '->'?
-(omapl138_lcdk)       |                                             ^
-(omapl138_lcdk)       |                                             ->
-(omapl138_lcdk) lib/lmb.c:552:27: error: 'lmb' is a pointer; did you mean =
to use '->'?
-(omapl138_lcdk)   552 |                        lmb.memory.region[lmb.memor=
y.cnt - 1].size - addr;
-(omapl138_lcdk) lib/lmb.c:552:45: error: 'lmb' is a pointer; did you mean =
to use '->'?
-(omapl138_lcdk) lib/lmb.c: In function 'lmb_is_reserved_flags':
-(omapl138_lcdk) lib/lmb.c:561:28: error: 'lmb' is a pointer; did you mean =
to use '->'?
-(omapl138_lcdk)   561 |         for (i =3D 0; i < lmb.reserved.cnt; i++) {
-(omapl138_lcdk)       |                            ^
-(omapl138_lcdk)       |                            ->
-(omapl138_lcdk) lib/lmb.c:562:40: error: 'lmb' is a pointer; did you mean =
to use '->'?
-(omapl138_lcdk)   562 |                 phys_addr_t upper =3D lmb.reserved=
=2Eregion[i].base +
-(omapl138_lcdk)       |                                        ^
-(omapl138_lcdk)       |                                        ->
-(omapl138_lcdk) lib/lmb.c:563:28: error: 'lmb' is a pointer; did you mean =
to use '->'?
-(omapl138_lcdk)   563 |                         lmb.reserved.region[i].siz=
e - 1;
-(omapl138_lcdk) lib/lmb.c:564:33: error: 'lmb' is a pointer; did you mean =
to use '->'?
-(omapl138_lcdk)   564 |                 if ((addr >=3D lmb.reserved.region=
[i].base) && (addr <=3D upper))
-(omapl138_lcdk)       |                                 ^
-(omapl138_lcdk)       |                                 ->
-(omapl138_lcdk) lib/lmb.c:565:36: error: 'lmb' is a pointer; did you mean =
to use '->'?
-(omapl138_lcdk)   565 |                         return (lmb.reserved.regio=
n[i].flags & flags) =3D=3D flags;
-(omapl138_lcdk) make[2]: *** [scripts/Makefile.build:256: lib/lmb.o] Error=
 1
-(omapl138_lcdk) make[1]: *** [Makefile:1892: lib] Error 2
-(omapl138_lcdk) make[3]: *** [scripts/Makefile.build:256: spl/lib/lmb.o] E=
rror 1
-(omapl138_lcdk) make[2]: *** [scripts/Makefile.spl:538: spl/lib] Error 2
+(omapl138_lcdk) boot/image-board.c: In function 'image_setup_linux':
+(omapl138_lcdk) boot/image-board.c:907:65: error: 'lmb' undeclared (first =
use in this function)
+(omapl138_lcdk)   907 |                 ret =3D image_setup_libfdt(images,=
 *of_flat_tree, lmb);
+(omapl138_lcdk)       |                                                   =
              ^~~
+(omapl138_lcdk) boot/image-board.c:907:65: note: each undeclared identifie=
r is reported only once for each function it appears in
+(omapl138_lcdk) make[2]: *** [scripts/Makefile.build:256: boot/image-board=
=2Eo] Error 1
+(omapl138_lcdk) make[1]: *** [Makefile:1892: boot] Error 2
+(omapl138_lcdk) make[3]: *** [scripts/Makefile.build:257: spl/boot/image-b=
oard.o] Error 1
+(omapl138_lcdk) make[2]: *** [scripts/Makefile.spl:538: spl/boot] Error 2
06: lmb: pass a flag to image_setup_libfdt() for lmb reservations
       arm:     omapl138_lcdk
-(omapl138_lcdk) boot/image-board.c: In function 'image_setup_linux':
-(omapl138_lcdk) boot/image-board.c:907:65: error: 'lmb' undeclared (first =
use in this function)
-(omapl138_lcdk)   907 |                 ret =3D image_setup_libfdt(images,=
 *of_flat_tree, lmb);
-(omapl138_lcdk)       |                                                   =
              ^~~
-(omapl138_lcdk) boot/image-board.c:907:65: note: each undeclared identifie=
r is reported only once for each function it appears in
-(omapl138_lcdk) make[2]: *** [scripts/Makefile.build:256: boot/image-board=
=2Eo] Error 1
-(omapl138_lcdk) make[1]: *** [Makefile:1892: boot] Error 2
-(omapl138_lcdk) make[3]: *** [scripts/Makefile.build:257: spl/boot/image-b=
oard.o] Error 1
-(omapl138_lcdk) make[2]: *** [scripts/Makefile.spl:538: spl/boot] Error 2
-(omapl138_lcdk) make[1]: *** [Makefile:2092: spl/u-boot-spl] Error 2
-(omapl138_lcdk) make: *** [Makefile:177: sub-make] Error 2
07: lmb: reserve and add common memory regions post relocation
       arm:  +   omapl138_lcdk
+(omapl138_lcdk) common/board_r.c: In function 'initr_lmb':
+(omapl138_lcdk) common/board_r.c:564:9: error: implicit declaration of fun=
ction 'lmb_add_memory' [-Werror=3Dimplicit-function-declaration]
+(omapl138_lcdk)   564 |         lmb_add_memory(gd->bd);
+(omapl138_lcdk)       |         ^~~~~~~~~~~~~~
+(omapl138_lcdk) cc1: all warnings being treated as errors
+(omapl138_lcdk) make[2]: *** [scripts/Makefile.build:256: common/board_r.o=
] Error 1
+(omapl138_lcdk) make[1]: *** [Makefile:1892: common] Error 2
+(omapl138_lcdk) make: *** [Makefile:177: sub-make] Error 2
08: lmb: remove lmb_init_and_reserve_range() function
09: lmb: replcace the lmb_init_and_reserve() function
       arm:     omapl138_lcdk
-(omapl138_lcdk) common/board_r.c: In function 'initr_lmb':
-(omapl138_lcdk) common/board_r.c:564:9: error: implicit declaration of fun=
ction 'lmb_add_memory' [-Werror=3Dimplicit-function-declaration]
-(omapl138_lcdk)   564 |         lmb_add_memory(gd->bd);
-(omapl138_lcdk)       |         ^~~~~~~~~~~~~~
-(omapl138_lcdk) cc1: all warnings being treated as errors
-(omapl138_lcdk) make[2]: *** [scripts/Makefile.build:256: common/board_r.o=
] Error 1
-(omapl138_lcdk) make[1]: *** [Makefile:1892: common] Error 2
-(omapl138_lcdk) make: *** [Makefile:177: sub-make] Error 2
10: lmb: allow for resizing lmb regions
       arm: (for 1/1 boards) all +224.0 text +224.0
            omapl138_lcdk  : all +224 text +224
               u-boot: add: 0/0, grow: 1/0 bytes: 224/0 (224)
                 function                                   old     new   d=
elta
                 lmb_add_region_flags                       416     640    =
+224
11: event: add events to notify memory map changes
12: lib: Kconfig: add a config symbol for getting memory map updates
13: add a function to check if an address is in RAM memory
14: efi_memory: notify of any changes to the EFI memory map
15: lmb: notify of any changes to the LMB memory map
       arm: (for 1/1 boards) all +8.0 text +8.0
            omapl138_lcdk  : all +8 text +8
               u-boot: add: 0/0, grow: 2/0 bytes: 12/0 (12)
                 function                                   old     new   d=
elta
                 lmb_reserve_flags                           32      40    =
  +8
                 lmb_free                                   192     196    =
  +4
16: efi_memory: add an event handler to update memory map
17: lmb: add an event handler to update memory map
       arm: (for 1/1 boards) all +349.0 rodata +61.0 text +288.0
            omapl138_lcdk  : all +349 rodata +61 text +288
               u-boot: add: 3/0, grow: 3/0 bytes: 232/0 (232)
                 function                                   old     new   d=
elta
                 event_notify                                 -     104    =
+104
                 initcall_run_list                           96     144    =
 +48
                 image_setup_libfdt                         236     284    =
 +48
                 event_notify_null                            -      18    =
 +18
                 event_type_name                              -       8    =
  +8
                 run_main_loop                               10      16    =
  +6
18: lmb: remove call to efi_lmb_reserve()
19: sandbox: iommu: remove lmb allocation in the driver
20: zynq: lmb: do not add to lmb map before relocation
21: test: cedit: use allocated address for reading file
22: test: event: update the expected event dump output
23: test: lmb: run the LMB tests only on sandbox
24: test: lmb: initialise the lmb structure before tests
25: test: lmb: add a test case for checking overlapping region add
26: test: lmb: adjust the test case to handle overlapping regions
27: test: lmb: run lmb tests only manually
28: test: bdinfo: dump the global LMB memory map
29: cmd: bdinfo: only dump the current LMB memory
       arm: (for 1/1 boards) all -8.0 text -8.0
            omapl138_lcdk  : all -8 text -8
               u-boot: add: 0/0, grow: 0/-1 bytes: 0/-8 (-8)
                 function                                   old     new   d=
elta
                 do_bdinfo                                  472     464    =
  -8
30: temp: mx6sabresd: bump up the size limit of the board

So my first thought is, do we really need the event notifier framework
in the case where it's NOT also using EFI_LOADER? Or is perhaps that
Kconfig logic not quite right?

--=20
Tom

--UCYPEkmQuxf8k5ff
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZnaqoACgkQFHw5/5Y0
tyzf7Qv/dVkhK3TzNVoaB8GlBFsVJFpZXlkntVLEs4c6FCnS+tONEhi1Ix/mYnLn
1U9ptneSBjxRqxLdBh/mlhjgVGR7z9c/ul78HUIQ8SVW0tvqaZqRTz0hOAGZ6TR0
xL5H43QcpS906ZoVIA5zgDFU/DBSjEaEqm2IWpNLD6vUCqLwC4Aoot1hDiwG5cT8
KVKlcZzezGVYm7yuYLk6TEkY5wM16ZATgsjOpVEwBTSaCWDOcmeJ9Zfgd5s/eNOk
QlBw7llbkVS0ALCkrX2IJmyVVvLyr8XQ6/VrW5BjqFtMjXtxWD566cLLw7r0DLAY
nT5tGLmyQz0zi15OcsmXaUMgrWwWxPgt++i4ZpPjWacGAjYv5vgmQm8cz35rylVT
MUxocoAcXWWnB+42Cd5FlW4i70im+D0hBSzLO4HlWhXFiKamZjcDJxn7koH235mn
YfaNtHehjQoMgnxZRpt32LbayNQf+C6+ycqRlvfgkbhkio+yN4cfAPI1XQX2URiF
hEGT7Ojj
=lAEt
-----END PGP SIGNATURE-----

--UCYPEkmQuxf8k5ff--
