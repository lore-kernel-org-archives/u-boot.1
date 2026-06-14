Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF967CD98C5
	for <u-boot@archiver.kernel.org>; Sun, 14 Jun 2026 12:33:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33F2F83EEF;
	Sun, 14 Jun 2026 14:33:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j19QZkKd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E42084869; Sun, 14 Jun 2026 14:33:39 +0200 (CEST)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1B5D800AE
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 14:33:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-517863a2edfso19853881cf.1
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 05:33:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781440415; cv=none;
 d=google.com; s=arc-20240605;
 b=g7uNdjIBkE8DrWeQohfwNzl8YfIePsj9LdrnJCJYj9Nixzlzw9++M/OD/lQM4s//K+
 3k7rAoPWOcwZximdIM5Yi5uw8EvdeK3AlBW8Xp9TqtshaurX0riKWiGhMCoN60Nf+MFb
 aqYagCs1MOiJiCw4OeSK759UWyklWb6+vrqbF6esPmqJF37rreYxJjcYkz8fbN24dhGi
 4uBFPPZFZSs3uWZlt4Lz2Vjl3I8NN4JkmAqa/ZHT6rlbOGl4j6KBlJ/3N3rN33jWlSwE
 OVJd1cuX5KCotIiRmkxzRv9EFRoX6ZOG2PWj1krU1I9o/R5C1pR5h6onRwOMCxxF5hw3
 +ACQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=l4PlbCZv7dOnr4bP3AnhG0ho67G8teeOYdZcSD+OU3k=;
 fh=kHKGotiU4C5Tz8ojSi9CK/Xtol8dki1lMMq/KRcp7/0=;
 b=H6FlNPAv6Dola868kEXiySvxh9ZKTKXhVsNSJbMaKKQSaWySAdwh+dV2FDeiaUpeGd
 A97rObrrzYehIMtN+oSGVUG5Y3tiA7EMmxCoXDMFfy69SHdKIrBsjHMX+0qjqB/NTYVc
 xgIg0pVcuu95QbBZtC0b1RNixtKiTdMraUjUOQIy3u5UY5iUTHaXKBWiqSP+Z/goeN1Z
 xYAZj0+NKLJ1CkGjhUBdb1aRf6kj4r5G8TGzRl+YM0QFVJRNKt4iEg4TRtU72RvMQ2Wh
 T+rlIfLFLSaBSY2eW2IdxRoTrul18B+Ap9nnc8ttyon1SkjqIpbDNcbH6BTFJSBTms+4
 uk8A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781440415; x=1782045215; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=l4PlbCZv7dOnr4bP3AnhG0ho67G8teeOYdZcSD+OU3k=;
 b=j19QZkKdGNnFyBzFxKI581+mOlFT0hzaMe8qROtVtQ27ppmi8+enf3mla53oIiijeH
 CC8jzvcM5c0gc6eTXtnGj4A00P6Jqz6VOjkJFMZQ8LaiyEODNEcwZT6Ns4AA7sRX6Q9q
 dJ/o5LBT3ZgTASPUXmYv/9AcLVY4YNMRtDVkxWTe2iZoihqqBv11RXCIUGWr8N7H8tNH
 lLE+H3IloKZQPMDXhRfo+kBlaYf3grnDC9gsECqnBrmVfQM/zDGLQLhw73PjOCS1l329
 +s+iErKhps6Eqr/EXsWhPSrNSFDARGC5jz6HODwfMxSIs79e19ylcqvwqcizN05J6ck8
 Fcrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781440415; x=1782045215;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l4PlbCZv7dOnr4bP3AnhG0ho67G8teeOYdZcSD+OU3k=;
 b=GpDmJbkdKUAyoPyjUoyr3WCN4UgiSD/7JK+xE0iRzOXpf0VG4F41kFB3OTzF8RsqAT
 AaMD/GyWGoRb6AbDyrAznX49rsd37n/URQMn8ic6kigbL9didKEBzTQepDq1/kGIxWDF
 3Tyy1qj6qRDy5YMlpIh0FDwxhmRcpq/Hvi2APgvN3Xu/SMIYBnZqtAPW5VMJ+ynhtB5Y
 6dzXQ7Sk9HtuE1FP8C716NgZxJIEVhvXw8BVrEGeG71mT4hg3Tpk4eG+TpZez+XBy2Cs
 0u0Du9lrdREo6hXYx0Wretst1B5csZjI8XLqWZE1VnY/o00yDytz98raKnsYUWQM4lHs
 qh1A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+HYtXNi4d/yWGxegANQFmxghbQZuI+3PuA6h4lERHElB96+PQOCiuls+nveOO9XqMqgo55j5c=@lists.denx.de
X-Gm-Message-State: AOJu0Yz0j5MgwI5I7b3Or4dd59sVHsRmU8q0hCOfOLRKI+55jOk3odgV
 OxgvA0bMcq0bJXxVCGS3M+zdjnJ8I7aJBqKMVPe2sProfRxvLrC99x0dsrRNO65MB/MAg3Zrv1L
 W2hzvhbaRjfw+bxPgl1suMUojQrDhS8o=
X-Gm-Gg: Acq92OHYdhnGH1OYrTRPNjLau6R87b0OVmmZnluZwKy8AHpe8ALU7vEux1axzedVQvL
 DpTeKhTMGqaTlPl5/nsYPtlUCNki88el4Qzxn2JivjxdZI1EhDE9tc4bvjereq0HW1s1QQu7aVo
 pENI6H6eMChwGKO65UupM3T8B6ObwlgK6B1YQw791cbLHECpDfoJoCBcFuuQAUHburLy2pSxDcz
 P0XuufNdSqRz/qmwn7qSKZ84i2J14VhRhw+VtlEpGXdCS3MV0hcsZxVO5v2sVz4DmVVBHvRnN4n
 1ozUTF++deWLM0998lT/J09JF8xmxRpXicRbH2eDLhKxIu4bXtZP1HNfVngxO2GlzxLuBHyRs9g
 /OsQizs97CDdYX8Fte9/Z9z5iCAy2l4lwYLknK1SHqot36D+74dV5p6t+2OMs+rI3kJgaNO+RbL
 npDg==
X-Received: by 2002:ac8:590f:0:b0:517:7ef6:d77d with SMTP id
 d75a77b69052e-517fe190c08mr152666461cf.10.1781440415363; Sun, 14 Jun 2026
 05:33:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260601103557.022EB68B05@verein.lst.de>
 <CAFLszTj4F+Wpv2QOtKPyK6sApK5YpBWtCdpi0vJa6FNgUgYWvw@mail.gmail.com>
In-Reply-To: <CAFLszTj4F+Wpv2QOtKPyK6sApK5YpBWtCdpi0vJa6FNgUgYWvw@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Sun, 14 Jun 2026 13:33:21 +0100
X-Gm-Features: AVVi8CcuqL69uL8Yd1H30SY-HFXf7dfY8XcavcHn6uityogdvP01srOzTAcu41Y
Message-ID: <CALeDE9NOW40eEXLpG6Ud3sYfg3rAPUgWa-pcf1R1QjVNdpea8Q@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] ARM: RPi5: Enable PCIe
To: Simon Glass <sjg@chromium.org>
Cc: Torsten Duwe <duwe@lst.de>, Matthias Brugger <mbrugger@suse.com>,
 Tom Rini <trini@konsulko.com>, 
 =?UTF-8?B?SmFuIMSMZXJtw6Fr?= <sairon@sairon.cz>, 
 Andrea della Porta <andrea.porta@suse.com>, "Ivan T. Ivanov" <iivanov@suse.de>,
 Stanimir Varbanov <stanimir.varbanov@suse.com>,
 Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>, 
 Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Huan Zhou <me@per1cycle.org>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Joseph Chen <chenjh@rock-chips.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>, Pedro Falcato <pfalcato@suse.de>,
 u-boot@lists.denx.de
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

On Sun, 14 Jun 2026 at 12:50, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Torsten,
>
> On Mon, 1 Jun 2026 at 04:36, Torsten Duwe <duwe@lst.de> wrote:
> >
> > Basic PCIe support for the RPi5. This is the prerequisite for PCIe
> > slot adapters / HATs and NVMe storage. Those might require their own
> > supporting drivers or changes. It is also the prerequisite for all
> > peripherials residing on the RP1 I/O controller, like USB, network,
> > GPIOs and all serial ports beyond the debug connector.
> >
> > Changes from v4:
> >   - fixed remaining style issues, no functional changes
> >   - patches 3&6 Reviewed-by Neil Armstrong
> >
> > Changes from v3:
> >   - differentiate only between bcm2711 and -12. No possible future
> >     extensions for other chips. In particular, keep EXT_CFG_INDEX and
> >     EXT_CFG_DATA offsets fixed, no functions in the cfg struct that
> >     are the same for both, like bridge_sw_init_set and rc_mode.
> >   - pass error codes through the newly introduced reset call chain
> >   - some patches Reviewed-by Neil Armstrong
> >
> > Changes from v2:
> >   - fix wrong subject prefixes
> >   - make reset drivers only found on the RPi5 depend on ARCH_BCM283X
> >   - some patches Reviewed-by Peter Robinson
> >
> > Changes from v1:
> >   - fixed inbound window rewrite, which broke RPi4
> >   - series Tested-by Pedro Falcato
> >
> > Andrea della Porta (1):
> >   pci: brcmstb: Fix PCIe bus numbers
> >
> > Torsten Duwe (8):
> >   ARM: bcm283x: Add bcm2712 PCIe memory window
> >   pci: brcmstb: Support different variants using a cfg struct
> >   reset: Add RPi5 brcmstb reset facilities
> >   reset: Add RPi5 rescal reset facilities
> >   pci: brcmstb: Get and use bridge and rescal reset properties
> >   pci: brcmstb: Fix iBAR size calculation
> >   pci: brcmstb: rework iBAR handling
> >   pci: brcmstb: Adapt to AXI bridge
> >
> >  .../mach-bcm283x/include/mach/acpi/bcm2711.h  |   6 +
> >  arch/arm/mach-bcm283x/init.c                  |  10 +-
> >  configs/rpi_arm64_defconfig                   |   2 +
> >  drivers/pci/pcie_brcmstb.c                    | 389 ++++++++++++++++--
> >  drivers/reset/Kconfig                         |  16 +
> >  drivers/reset/Makefile                        |   2 +
> >  drivers/reset/reset-brcmstb-rescal.c          | 103 +++++
> >  drivers/reset/reset-brcmstb.c                 |  97 +++++
> >  8 files changed, 589 insertions(+), 36 deletions(-)
> >  create mode 100644 drivers/reset/reset-brcmstb-rescal.c
> >  create mode 100644 drivers/reset/reset-brcmstb.c
> >
> > --
> > 2.54.0
> >
>
> I see that this series has been applied to -next although I didn't see
> any 'applied' email here.

That was probably me not replying and just marking it as applied in
patchwork. It's in master I believe.

> Do you know how I could try this out, please? I have a GeeekPi N07
> PCIe M.2 M-Key NVMe. What sort of changes might I need to make?

You need another series [1], which currently needs a rebase, and it
should mostly "just work".

[1] https://patchwork.ozlabs.org/project/uboot/list/?series=503410
