Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC4ECDB479
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 15:32:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D68E84962;
	Thu, 25 Jun 2026 17:32:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RNfsYuiH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 517208498B; Thu, 25 Jun 2026 17:32:10 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B92E784949
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 17:32:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c07a6520cafso456067366b.0
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 08:32:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782401527; cv=none;
 d=google.com; s=arc-20260327;
 b=iTuv5BUW6bn1M4w/5BUIxYYAwgxq6OZDIPL2wX97R7uVOaalq54Iltq9xW0ldxRkJg
 ThaxlFS05ioqPwp8+RCaavnV92hZctQVsOy8qLElvW1c0YKdyvDpgxvK+b3AXXI6fecW
 3w2cxnyFut1jUDpc6QcxoYWqQ+RCojnur+TYI/WjdfaLtmtkH7N2NlMtkjxIkscyzfya
 6wX0GcsYXXEoFqhaQW7shskOicNz20tqAQd/Q0Bzbbdghq6QVcL1bXxGhn1FwiX0YFbU
 gG5WWntWBCRLiqfbNtzOeGcdwKkyoBbTSghqlv/KO/egoUfUoLJGPXYZk/InjCB/Qn9V
 LrzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=z2vK7q+jwJOPbWarana/PYcaPV4lwISTZqBb+lc6OTE=;
 fh=f0V7DNbJ1fdCZNfuO6pdoT7v31UyTk2sGsdlHkSXtF4=;
 b=jvGVVbiQCg2FveqTD1EnX2fCSLlmR/aK4wjWA8+zn3wUVuYST5st1uRDd2dttDmQAZ
 Ma5EPE1vEppuSN2tKxxrBq4F+oIYWA9ZJnDTOcZV6goHjZnU2iOLuw9I8T/VMXILmbqu
 kdsDdQV7crjqLWpRlsB6W7li8/dxzCcYyN1mKZdG1JqZZGe2NxixERT5ioKtnhVxJaZ8
 zQoR+Buzp1MO3cJYAnFVW0ZkZMFbcSq+hXX5pNp3H4aW2lMqs+sl8YOotiEIPi7TSU/r
 YSYNU3fLZDYjlubdXM8AItCZP2dc8FhBYUPQ8UqbeoeHZIo9XxPaDAlxzIXY3qDSauUt
 Gw2g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782401527; x=1783006327; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=z2vK7q+jwJOPbWarana/PYcaPV4lwISTZqBb+lc6OTE=;
 b=RNfsYuiHKGPrjWl24utIwB81/rxzdmgDf6BfzbymSYkSSDpQoQHg/q9d1GDBS9Het3
 QO6svzKP+1WAeB4G0jj3cN8fPaV/RljBzjqGJ+hQSdbygsgHGhS5aIvpNOOprY0Kwkos
 Bi5LXNq3lGHYDw+y8Q+7iHGnkstoog9cmobjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782401527; x=1783006327;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z2vK7q+jwJOPbWarana/PYcaPV4lwISTZqBb+lc6OTE=;
 b=VmId4TZwS7EIIa7TW/jRwW78ZXCMsb5aDAM5FZbTufTlNtPXiQAuehoTs1Owmer+Uq
 d4hGGYMcigZSiqV/UBNsiFOTqkEPfR7YRUjg64vXCPt3qvl7JudRA96Bgti8Oq5W7s1P
 EtOI3IoKbGOau3NQquguLO4npriwSFKt8442hX5urJ8znM+1fKQwoGdZDdMHwpsiHVEv
 qG63h9gfhlAwKtSuUBy4NSEze26f75oJMXNfnJN0WLZ8ERq8neL6PGBk2bYhk8hkuJLz
 s52bST2A0RTt4uuzURjla1PNlv2BbCbKivjtsh0M6jUT0RtZqCxZYcvRU7Vqu6KtpKw8
 Ro9g==
X-Forwarded-Encrypted: i=1;
 AHgh+RqcaolU6sHVUe0yqgD7c8FYiXi+8wfF7hEvs6AE5fBeFDBWcqscxUy49ngJDxaug3dhgRQbE+E=@lists.denx.de
X-Gm-Message-State: AOJu0YwiEDlklMkkwb56oRodV6VHd3qQj5uyfGVDoM2RewdKyhnVzs9a
 kY+7eHU21MVXNLpFiMFA0nihZah7WmY4ZFM/plJHQ98eH0/7rQB4qwVIj5UWR3BeoPYfnj22n0C
 rsSJRtFNepmSqEiWPvTE9oRxq1qEFwwxkvk1M6m1f
X-Gm-Gg: AfdE7cn55Z81Do1ZaEQE5il5pDZcQK3ngIpn3KLyRDR277MOoYdta8Ef96r2xLF/oKK
 fRV7H4shvNqPaRXOu3F/yhALuGCJEQHPbg6a65Cf2aJx4HtNfj9qmn8aIC9rI3pItnNu0k+qKJ9
 6Fm3uh8ITQPdsJ3uBGP5y7NHBt3cVZ5p57q0hHjS9PffQ1I83mQ028M/Jc5cpY6Y59S4jmXMuRz
 W0DTlmskPXinpoM3bxY1nPLAvfMYVgVPE+O1Wd29/7ex4Ej5IU/L7vq+2+Kw2XT7HsZsXEOVw==
X-Received: by 2002:a17:907:96ab:b0:c11:6b5b:70d0 with SMTP id
 a640c23a62f3a-c1205e06402mr251480466b.18.1782401526898; Thu, 25 Jun 2026
 08:32:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260520201218.3752042-1-sjg@chromium.org>
 <20260522170328.GU1858239@bill-the-cat>
 <e56cb70e-1a66-4ebf-8014-7fd6be9c69ef@cherry.de>
 <20260624181925.GP382693@bill-the-cat>
 <a3bb6dfa-b4c2-46cf-88a1-8198e9c54523@cherry.de>
In-Reply-To: <a3bb6dfa-b4c2-46cf-88a1-8198e9c54523@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jun 2026 16:31:55 +0100
X-Gm-Features: AVVi8Cdq5y4azTgi9hde9zbQ6XKzX1QcH0XBhqBoK-i2Pooh2PAWJpoY9xZxJHs
Message-ID: <CAFLszTjUt43UPjYX0Y16r=CXD8oNKvOQE2+vEcO5Ri0GqZHh1w@mail.gmail.com>
Subject: Re: [PATCH 0/2] Convert env export and import to use getopt()
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Sean Anderson <seanga2@gmail.com>, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Heiko Schocher <hs@nabladev.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
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

Hi Quentin,

On Thu, 25 Jun 2026 at 09:29, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> On 6/24/26 8:19 PM, Tom Rini wrote:
> > On Wed, Jun 24, 2026 at 07:35:49PM +0200, Quentin Schulz wrote:
> >> On 5/22/26 7:03 PM, Tom Rini wrote:
> >>> On Wed, May 20, 2026 at 02:12:12PM -0600, Simon Glass wrote:
> >>>
> >>>> U-Boot has had a getopt() implementation for over five years but it is
> >>>> not used much; most commands hand-roll their own argv loops to spot
> >>>> -x style flags. The env export and env import sub-commands have the
> >>>> gnarliest of these parsers in nvedit.c
> >>>>
> >>>> Each one walks every -prefixed argv element by hand, opens an inner
> >>>> loop to split grouped flags and tracks a counter to catch a repeated
> >>>> format flag.
> >>>>
> >>>> This short series converts both sub-commands to getopt(). The mutex
> >>>> check for the format flags is done after the option loop, since it is
> >>>> a per-command rule rather than an option-parsing rule, and the trailing
> >>>> positional list is read straight out of argv from gs.index onwards.
> >>>>
> >>>> There is no functional change. getopt() stops at the first non-option,
> >>>> just as the hand-rolled loops did, so options still have to appear
> >>>> before the positional arguments.
> >>>>
> >>>> Each command gains a 'select GETOPT' so the parser is linked in on
> >>>> boards that do not already enable it.
> >>>>
> >>>> For firefly-rk3399:
> >>>>
> >>>>     03: cmd: nvedit: Use getopt() in env export
> >>>>        aarch64: (for 1/1 boards) all -45.0 rodata +27.0 text -72.0
> >>>>     04: cmd: nvedit: Use getopt() in env import
> >>>>        aarch64: (for 1/1 boards) all -27.0 rodata -55.0 text +28.0
> >>>>
> >>>>
> >>>> Simon Glass (2):
> >>>>     cmd: nvedit: Use getopt() in env export
> >>>>     cmd: nvedit: Use getopt() in env import
> >>>>
> >>>>    cmd/Kconfig  |   2 +
> >>>>    cmd/nvedit.c | 186 +++++++++++++++++++++++----------------------------
> >>>>    env/common.c |   2 +-
> >>>>    3 files changed, 85 insertions(+), 105 deletions(-)
> >>>
> >>> For the record, here's a link to v2:
> >>> https://lore.kernel.org/u-boot/20260519233207.2765755-1-sjg@chromium.org/
> >>> And here's the full size change for firefly-rk3399:
> >>> Summary of 3 commits for 1 boards (1 thread, 12 jobs per thread)
> >>> 01: arm: Fix typo in linker script
> >>>      aarch64:  w+   firefly-rk3399
> >>> +(firefly-rk3399) Image 'simple-bin' is missing external blobs and is non-functional: atf-bl31
> >>> +(firefly-rk3399)
> >>> +(firefly-rk3399) /binman/simple-bin/fit/images/@atf-SEQ/atf-bl31 (atf-bl31):
> >>> +(firefly-rk3399)    See the documentation for your board. You may need to build ARM Trusted
> >>> +(firefly-rk3399)    Firmware and build with BL31=/path/to/bl31.bin
> >>> +(firefly-rk3399) Image 'simple-bin' is missing optional external blobs but is still functional: tee-os
> >>> +(firefly-rk3399) /binman/simple-bin/fit/images/@tee-SEQ/tee-os (tee-os):
> >>> +(firefly-rk3399)    See the documentation for your board. You may need to build Open Portable
> >>> +(firefly-rk3399)    Trusted Execution Environment (OP-TEE) and build with TEE=/path/to/tee.bin
> >>> +(firefly-rk3399) Some images are invalid
> >>> 02: cmd: nvedit: Use getopt() in env export
> >>>      aarch64: (for 1/1 boards) all +883.0 rodata +199.0 text +684.0
> >>>               firefly-rk3399 : all +883 rodata +199 text +684
> >>>                  u-boot: add: 5/0, grow: 0/-2 bytes: 1184/-500 (684)
> >>>                    function                                   old     new   delta
> >>>                    __getopt                                     -     520    +520
> >>>                    static.bdinfo_print_all                      -     324    +324
> >>>                    print_eth                                    -     236    +236
> >>>                    print_bi_dram                                -      92     +92
> >>>                    getopt_init_state                            -      12     +12
> >>>                    do_env_export                              548     476     -72
> >>>                    do_bdinfo                                  588     160    -428
> >>> 03: cmd: nvedit: Use getopt() in env import
> >>>      aarch64: (for 1/1 boards) all -27.0 rodata -55.0 text +28.0
> >>>               firefly-rk3399 : all -27 rodata -55 text +28
> >>>                  u-boot: add: 0/0, grow: 1/0 bytes: 28/0 (28)
> >>>                    function                                   old     new   delta
> >>>                    do_env_import                              668     696     +28
> >>>
> >>> And so this is why I'm just deferring this until someone has the time to
> >>> pick up and address the underlying problems with this potential
> >>> migration that have been raised in the previous iterations.
> >>>
> >>
> >> Chiming in because I was put in Cc...
> >>
> >> Do I understand correctly that this only impacts U-Boot proper? If so, is a
> >> size increase in proper that much of a blocker? As opposed to xPL which
> >> usually resides in SRAM, I'm assuming U-Boot proper would run in RAM where I
> >> hope an additional ~700B shouldn't be too much to ask for? The issue however
> >> could be on the storage medium where U-Boot proper is located, maybe this
> >> gets the binary above the max space allowed for U-Boot proper to be stored
> >> (e.g. on some of my boards I'm (self-imposed) limited to 2000KiB) though I'm
> >> assuming it could be less than 700B if U-Boot proper is compressed for
> >> example. But I'm also lucky enough to have storage space and (D)RAM to spare
> >> on my boards.
> >>
> >> Out of the RFC, I see the strlower() part as being separate from the rest,
> >> maybe that's something we could revisit separately? Reading the cover
> >> letter, we should even spare 60B with that alone, with the added benefit of
> >> easier maintainability?
> >
> > This was just impacting U-Boot proper. However, it showed I think two
> > sets of problems. The first of which is that there was an expectation
> > that switching the code should result in some sort of savings,
> > somewhere. And it didn't. And we do have boards where the space between
> > the end of U-Boot and the start of the environment is small and so
> > global changes that aren't just bug fixes need careful consideration
> > (and they've already turned off things that aren't needed for them such
> > as EFI loader). The second thing was that the code wasn't really easier
> > to read / follow. So I don't object to the concept but I think the
> > outcome of this series was that our getopt needs to be looked at in a
> > bit more detail, and figure out if it's really designed the way we need
> > it.
> >
>
> Understood, thanks for the additional info.

For the first point, it is true - I honestly don't see much in the way
of savings. In fact I had to work (very) hard just to keep things the
same after a conversion. Granted, this work can be used for other
commands too. As I may have mentioned elsewhere, I could imagine
changing the 'cmd' function-signature to a version which is just
passed the getopt struct. I later did some experimentation and it did
help, saving about 30 bytes (from memory) for each command.

For the second point, getopt() is easy enough to follow for regular
commands, but U-Boot does have a lot of hand-parsed pieces that
translate less well to getopt(). When I chose what to convert I
deliberately chose the odd things so that we wouldn't go ahead with
the conversion and then discover lots of pain later. Better to go in
with eyes open.

For your third point, when I see size increasing I tend to look around
randomly for things to chop. So I think it is better to keep the
strlower() win in the bag, ready for use when we need it to maintain
code size.

My vote (as I may have mentioned :-) is to bite the bullet and enable
getopt() for most boards...improving the architecture as we go. I
doubt anyone would take on converting ~1000 U-Boot commands in one go,
so we have to start somewhere.

Regards,
Simon
