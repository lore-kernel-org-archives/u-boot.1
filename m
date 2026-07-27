Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D103AC531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 09:21:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9503F80C7B;
	Mon, 27 Jul 2026 09:21:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qDkplB6quEVa; Mon, 27 Jul 2026 09:21:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0100980C38
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785144110;
	bh=CTI4Ya/gzlwAY3PKlHdNSlBUwcGRSCP6Lw+nRB91ZA0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1Ls5aKf1M9FYxmImYlkW+3zcbEb2EQNDpA33l3qpBEr1/lKmZ+0Pelv8K0qAzAEEr
	 AAfwsmHR5Gd3u0pYcIlxnthRldoBkCs5s8VsNTbmntQIvqGUzcMWX7Qywwfd6XCEWP
	 o3w2qxyH18pegG3BGd4H3QCYyWeaRtkVpQlb5jmcpxgWDphGZM5ADhJ+d6TGhBUNL3
	 e01DaZAWAP+7uHqIhUHAdsnMWWI5Pxe4cuiuN7e5q8JhBlTNA5YhsQiBwPiDTXTHOH
	 E+qOguNuRI5e+r16eShDNh5a/pI3rFHfopQKri+gqNPrfFpDmKBSmv4wkBuWsLkk+a
	 GF689Wdd9CzTw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0100980C38;
	Mon, 27 Jul 2026 09:21:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 27843357
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 09:21:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 254CF6065A
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 09:21:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xjuz_tkNC_VE for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 09:21:48 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=pbrobinson@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B2AAC605E0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B2AAC605E0
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B2AAC605E0
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 09:21:47 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2876984671; Mon, 27 Jul 2026 11:21:46 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F017B82991
 for <u-boot@lists.denx.de>; Mon, 27 Jul 2026 11:21:43 +0200 (CEST)
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-8f256eaedf8so26208636d6.2
 for <u-boot@lists.denx.de>; Mon, 27 Jul 2026 02:21:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785144102; cv=none;
 d=google.com; s=arc-20260327;
 b=ga02sxUARbRO2gLe/6PUvXegLZf4qxbt/qUa9600zzguGG2PRxDgJTjGg5p/JQqknp
 +RG0hu9XZad2ueDqpUuI4I83vG221jSDiwqI2bQTFK5GICZIVJiD9qKNLqvXmYBngQXj
 ZA450Ce2++yLBWQGR68bFhB9qHkZOcy6Jd4Ysqe+CXG0vFr1PX6VDjGDy9znDDGXS52c
 EvBlp37bK5+pvvvWiVaQD5yWvZO09hL0NLbO01qrIuGxDexJXIzm3mk43naZYVlU/r50
 qoMXUca+7y+gSBvTP/ZabDPUGVF6uI/dEkfCyyOrU4VM7ocnEYtSVqSFoom4TABhclQI
 NO1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=CTI4Ya/gzlwAY3PKlHdNSlBUwcGRSCP6Lw+nRB91ZA0=;
 fh=upyhGHb5jq/S0VCOKRgMi0o40DHv24CuzxVOKiZYsmM=;
 b=RG8FPQE1/wJH0DdMX/6IsByS2+VtRg5ts+BZfCPKFmoRNjmgAD8MM8a4KKUiBUWQgW
 NavP2v7aNi3tjZz7zX53+yI1o12IacLq0ZdKkzJlkbYE4xvWXci/nvvn39vHP5MwQq4o
 hNzw70kRyVfetL4OYVI2SDp1lxbQ2RIUI1PBkoSJVYYmOBlZ2F9v9QyV0Kh8gV1i+2+V
 kuq/+S3SEzHVQVOUmAtWXutDgXXjq640+QriqfAMHB87EcdUcziMYpQ1CZmDeEBvOwV5
 gp+/efaqyg0hu6Kg3Q0Vy4B3MJW2z7Kg/DTn0isXK6vqoNjcVTZSO/P3neBpnMPWxJ+S
 V4yg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785144102; x=1785748902;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=CTI4Ya/gzlwAY3PKlHdNSlBUwcGRSCP6Lw+nRB91ZA0=;
 b=LQoUlCdd1bxdhRgpm91JluFqrs4EW8VXgzXYyDOY5rYZ57kdiFiuhi8/tUMTfA+KAz
 Gau3hnc0vM1js9Du3vJciJCwrT63/Y1ORSYGDUQq8h0hL1alrrTg9vVC7+Zao+cVeC/f
 bA7d4qmO8KsDuOdor+O5xn2oYfwmTzIznl9YqEtqFC4lpeSy6y3Hzk1SA9BJHQG+dg0J
 APR1FA4AqVKstzvnc/2sm5lNmTMLqHP7s0FHfWkcu8FCnOfr+hnl7jpaVdUybFwkSUIG
 MNOyBOFAQ3l4qgb/LIZYmOz+6n3DwAwT2e6haY2AcQO80SUxPWReos19iZ4j2fUxkxvA
 pmFA==
X-Gm-Message-State: AOJu0YyO2ngQK6enf5ITUtawE1Uld4QR0tQG5ec+P4zEU9kkQnptinQS
 hC6QqbtiGBwzbAihc21sWURwpOp4xmUPt5jdWoFW3ac4Isabhn50GJueZtTVCTRoBH8g/AOS31/
 6cMbSv+h9WFkE2InAt2q0o/QMMviIemo=
X-Gm-Gg: AR+sD121B7eH1PWOpVIENvJI9s+ykIm4isNJVskO4mzuDxmYcAnXewcXvWFnrDENeyP
 HSWPOTwMQ3aGh5FSXV0muyAEg+J51exmO4blLDpXkjbN9CzNWypCSUdslM7k39+G2cKU+YlIHrl
 KflWvKDCL7TVoOn1kpFMGWR5jGztrulpZs4UC6CYWSj4Ze1dNtxGMiUx/cBDX8TEJh61nMk9rId
 /t4Q+bSmNH0ziADmrfMo6+LTlp/X744XUKBthIAitv/TPjyd7AhLbJGw552boKnmllfQ92AwyW3
 W8+vJn/WGtfKVd6mIqs3ZdERzQ5XSEexSSIrbcEQBH9xKUgNdS3kPghEuGxkr6dHeOVvo15rri4
 eWIEY0fTb55hMbRHy188+2anYwU5NN5J4k/TzmlcvjtFjKsR+InJ4Z6krwkzqpRSCrbs=
X-Received: by 2002:a05:6214:5549:b0:905:d42e:557e with SMTP id
 6a1803df08f44-907ec82b59cmr85769916d6.53.1785144102078; Mon, 27 Jul 2026
 02:21:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260726115702.15397-1-bhargavdas100@gmail.com>
In-Reply-To: <20260726115702.15397-1-bhargavdas100@gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 27 Jul 2026 10:21:30 +0100
X-Gm-Features: AUfX_myo23LQOkxsFL8dLZMwxMDAV89T8-PkIStdix_zxnCDNBwj0M1YiCFanIQ
Message-ID: <CALeDE9Mq48q1=YjbCVfjVfw6kRm6wcMB-zLnjzdkvURD4uDQ6Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] Add initial Raspberry Pi Pico 2 / RP2350 support
To: Bhargav Das <bhargavdas100@gmail.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785144102; x=1785748902; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CTI4Ya/gzlwAY3PKlHdNSlBUwcGRSCP6Lw+nRB91ZA0=;
 b=QIp6r7iT/GgfDrt94Mw32qBfxEdUdgVXwwiizNSeYMr/LMOB9oAbuTxaCKPtvDau5C
 DEArPzUqv5hAqU7GLnqqgdPRcPURuwg7ZHqRhupAR2I5HrlyDyHnq8f8eab8CZvGdXGT
 dwSCmA/mchoiElZApNaLy3coxusz24GVExsihYvopPQWVIp6KHjA5s2+tWpbthA6dOHD
 EfK+NRAFALruAtSLziYqqx9cnAxQEuDYUjxri38hJKye9AMPi5F5841dRs+ufujwyh30
 WJpHdzH9hLVjyRnnLvK6KiJGixjMGSAVZWEY8PGuMS1n5zMoyhUVIECRU/VAm2tWSM0w
 njXQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=QIp6r7iT
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=pbrobinson@gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="QIp6r7iT"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Bhargav,

> This series adds initial U-Boot support for the Raspberry Pi Pico 2 board
> and its RP2350 SoC, only the dual-core Cortex-M33 support is added.

It would be useful to give a bigger overview of *why* this is
happening? Is it used to boot Linux, some other OS? How can I test the
wider ecosystem that this functionality provides?

> Sent as an RFC to get feedback on the overall approach before polishing
> further.
>
> Status as of this RFC:
>
>   - UART1 console works; UART0 is not usable yet. Need to investigate.
>   - Boot-tested on both Pico 2 and Pico 2 W boards.
>   - `make sandbox_defconfig` passes with patches applied.
>   - This series selects CPU_V7M for RP2350. RP2350's Cortex-M33 core is
>     Armv8-M since there is no CPU_V8M support in U-Boot yet. Is CPU_V7M
>     acceptable as a starting point with CPU_V8M as a later follow-up?
>   - RP2350 has no device tree in mainline Linux yet, so patch 2
>     hand-writes rp2350.dtsi / rp2350-pico2.dts locally, and
>     rpi_pico2_defconfig uses CONFIG_OF_EMBED rather than
>     CONFIG_OF_UPSTREAM.

Has it been sent to a list upstream for review? Is there a timeline
for that to happen?

>   - board/raspberrypi/pico2/ is added alongside the existing, unrelated
>     BCM283x Raspberry Pi boards under board/raspberrypi/. Is this
>     directory placement acceptable given the SoC is unrelated, or should
>     it live elsewhere?

It doesn't matter the relationship between SoCs, they're related
because of the vendor. EG toradex is a board vendor that uses SoCs
from a number of vendors.

>   - Some functions and structures such as `struct rp2350_clocks_regs` is
>     defined but not yet used.
>   - misc_init_r() sets a fixed value for the "serial#" environment
>     variable. This runs after relocation, so a successful env_set() here
>     confirms env works post-relocation.
>
> Flashing procedure used for testing:
>
>     picotool uf2 convert u-boot.bin u-boot.uf2 --family rp2350-arm-s --offset 0x10000000
>     picotool load u-boot.uf2 -v -x
>
> Bootlog:
>
>     U-Boot 2026.04-rc3-00070-gbabf6d42fec7-dirty (Jun 23 2026 - 01:55:20 +0530)
>
>     CPU:   Raspberry Pi RP2350
>     Model: Raspberry Pi Pico 2
>     DRAM:  520 KiB
>     Core:  5 devices, 5 uclasses, devicetree: embed
>     MMC:
>     Loading Environment from nowhere... OK
>     In:    serial@40078000
>     Out:   serial@40078000
>     Err:   serial@40078000
>     RP2350>
>
> Bhargav Das (3):
>   arm: Add RP2350 architecture support
>   arm: dts: Add RP2350 device tree
>   board: raspberrypi: Add Pico 2 support
>
>  arch/arm/Kconfig                          |   7 +
>  arch/arm/Makefile                         |   2 +
>  arch/arm/dts/Makefile                     |   1 +
>  arch/arm/dts/rp2350-pico2.dts             |  30 +++
>  arch/arm/dts/rp2350.dtsi                  |  32 +++
>  arch/arm/include/asm/arch-rp2xxx/rp2350.h | 307 ++++++++++++++++++++++
>  arch/arm/mach-rp2xxx/Kconfig              |  58 ++++
>  arch/arm/mach-rp2xxx/Makefile             |   4 +
>  arch/arm/mach-rp2xxx/image_def.S          |  23 ++
>  arch/arm/mach-rp2xxx/rp2350.c             | 261 ++++++++++++++++++
>  arch/arm/mach-rp2xxx/u-boot.lds           |  94 +++++++
>  board/raspberrypi/pico2/Kconfig           |  15 ++
>  board/raspberrypi/pico2/MAINTAINERS       |   9 +
>  board/raspberrypi/pico2/Makefile          |   3 +
>  board/raspberrypi/pico2/pico2.c           |  83 ++++++
>  configs/rpi_pico2_defconfig               |  29 ++
>  include/configs/rpi_pico2.h               |  48 ++++
>  17 files changed, 1006 insertions(+)
>  create mode 100644 arch/arm/dts/rp2350-pico2.dts
>  create mode 100644 arch/arm/dts/rp2350.dtsi
>  create mode 100644 arch/arm/include/asm/arch-rp2xxx/rp2350.h
>  create mode 100644 arch/arm/mach-rp2xxx/Kconfig
>  create mode 100644 arch/arm/mach-rp2xxx/Makefile
>  create mode 100644 arch/arm/mach-rp2xxx/image_def.S
>  create mode 100644 arch/arm/mach-rp2xxx/rp2350.c
>  create mode 100644 arch/arm/mach-rp2xxx/u-boot.lds
>  create mode 100644 board/raspberrypi/pico2/Kconfig
>  create mode 100644 board/raspberrypi/pico2/MAINTAINERS
>  create mode 100644 board/raspberrypi/pico2/Makefile
>  create mode 100644 board/raspberrypi/pico2/pico2.c
>  create mode 100644 configs/rpi_pico2_defconfig
>  create mode 100644 include/configs/rpi_pico2.h
>
> --
> 2.43.0
>
