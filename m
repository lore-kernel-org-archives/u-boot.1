Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5610AC53219
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 04:55:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EA35A80FF9;
	Wed, 29 Jul 2026 04:55:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zci3FWjDOGpK; Wed, 29 Jul 2026 04:55:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D271C80FDD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785300924;
	bh=tt6BKIGyyBzCyM7XWfli/KrYb4wChUIGS2nTi/bshHU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CNCg8N48LSSIXTQ2z93nagPaO+NROJMoospNhvWxSw/qZoNNogWZ719PS/cUDUavE
	 dUn/4I84lbUj6kTkX50332qFzlfIq3Lrh/19zeHivksRRn6Ias35s6fp0qT0bUMLbe
	 DE2iczm+I/PmCxym0f6FcVbs1GMBqUAQpPV1awo5N9aTPcUJE5ESJ+R/Cy0ZpxVjir
	 W1URjWkzdbJ8y7u+sDxVHqgb2BAcBaUQuKidFUoExQyeuXo5iiETtpjB5DuF/jq/jg
	 bL7kcMGlQttSI41r1Qg0MXJmGWZUybY585yDAfFL49RUxZUf9JYgxXrtUabbZKj/2l
	 stTPc55AfaFGQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D271C80FDD;
	Wed, 29 Jul 2026 04:55:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B89904BF
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 16:54:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AA11080C47
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 16:54:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fvgqf-X3FhMh for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 16:54:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=bhargavdas100@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 994D380C27
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 994D380C27
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 994D380C27
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 16:54:34 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA4208493F; Tue, 28 Jul 2026 18:54:32 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4E4A8404D
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 18:54:30 +0200 (CEST)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-69fe400c14aso4483859a12.2
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 09:54:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785257670; cv=none;
 d=google.com; s=arc-20260327;
 b=aYl1imIaQWKiSdnVhp0t4NmN59Be9mNFhBKIyxzMvPyq111Lr7LkDNQzpnAGGS3Ll2
 qHPU7Dqu6zn3XeX7HLIhp0txnCEF5b99rIOamc/fFn7Tw+KLL8Bxuqh5cIwAvNQQtJBf
 OjnGDqlQa62DmvL3zTqzRlg7pYhIjUzBlspNmIsm0Jq+KlQcgq5RJRAtxKGQauh6v5T7
 VF18zjf3tI8YHa8pUJ1AVP27D2Ar2loh7N0fWeEgZoP6RSJ61KSH4zLspG33zrt6BWmE
 oP9WbS+Afx5JYpYMYO5U5L5hTd/WnYf5NYDxOguyfdWFAiQBKkF6MQfMiuHUN/VqfCq5
 2jfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=tt6BKIGyyBzCyM7XWfli/KrYb4wChUIGS2nTi/bshHU=;
 fh=Ho42j+Spn4xUvp32KhpTn5K2w7A/DtSUrymlb/HsrhU=;
 b=EPtH5KRRmIUqDN4/yfGX1o22iqAF6R1nD535b8ZqDYzETbWb0ap3gAJ956137ECYHI
 x40+GNMbfP9RUJ93nVtwwEgGbE1C+6JBWimXffSOAC7NOpnA4pUujNuJARrcHyrgr1We
 Wnl3Xroy9XGLFAVCXFf4CFLz9Ya3ICs9F69EO8aRSyTYUZ4PPodSZL61rbyZ5+xNKBhR
 U85oVQfmZcS//J8JYz1CZGYq9PXBBNipEGotVXwGeHIOuaQ1orCLCF33y5o55M86o1Dv
 fPShLtlbbkAcJaWo8gb5pLTA9yyvLMoDiB7xDU2oV4L3EJS967VOVa61sKKzb2+nylUC
 YdGA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785257670; x=1785862470;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=tt6BKIGyyBzCyM7XWfli/KrYb4wChUIGS2nTi/bshHU=;
 b=dkYyi3Gz25QcqGzGeFtIDrQzwRA02Bt2PzjXo4/2ZGiyfY2qcoABI4yqFBfUkB/tzQ
 EFioea99hEBsudL/MJlVExXd6v8HX7cKd/TyPCm5mQYvqCcmvCD8EvyPWBBK8lT6tlq9
 evwl3eHOc41WCTNHFpJn2GlFw554kI9/xfDL1YnYHUcbuG/ARturoHp5Kn2r5mKJ7Smo
 KzsQSb3cQboTHj9vk/zu3glh1CuEyX2QpmfT6xa0SoIOpsfBUc/pLqgD2MfFxzE+lmSo
 TmMHZ7uLZrvH9lWHwQ8Xn01lBvx4aocZKVbf/IQ/ubwqyKH7on99Cg0tmU18k+5lUH74
 9fVQ==
X-Gm-Message-State: AOJu0Yz2GPCMGuisU7or7Faw9LcqHbaGON2GpYCLyg4wR7BiTgZfiDZb
 PEWLoejVgFav8giML9X7frskhJzjv5SWc213Vyryc08al4xLbCd+mYMO5SIKQaRzqdQ6Vq+wjbN
 c7ZDL2NL3e/8ZQRexNlm9iXplSZdok2E=
X-Gm-Gg: AR+sD12CEIDB5UM4QNlvcy2wqvXOwkbQRK9CAwYg0tnDwesJ/MRrBdRt2hlLS48HKYl
 LSIo4hOB/rwkpUrS0Bm7Fb4099agLyPmD8c/6dPylky9O/eUrarrXGjOjgy6EqdEHB7nLOnKTFj
 Epmw98lgn7HiDkqQs4eWtDKwZfsICvB/1cbR4sxweXz+pQ/N7aYyXA+2YptmSjdY/EXO91q6lUC
 YwHec33nvp/7vHGlopLwMdQ1zpgY8FWo8/7vqt6Pu7qXpsy9/kJEcmiQdYMrq0=
X-Received: by 2002:a05:6402:e04:b0:698:70fa:af43 with SMTP id
 4fb4d7f45d1cf-6a034a79db6mr1803967a12.26.1785257669504; Tue, 28 Jul 2026
 09:54:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260726115702.15397-1-bhargavdas100@gmail.com>
 <CALeDE9Mq48q1=YjbCVfjVfw6kRm6wcMB-zLnjzdkvURD4uDQ6Q@mail.gmail.com>
In-Reply-To: <CALeDE9Mq48q1=YjbCVfjVfw6kRm6wcMB-zLnjzdkvURD4uDQ6Q@mail.gmail.com>
From: Bhargav Das <bhargavdas100@gmail.com>
Date: Tue, 28 Jul 2026 22:24:17 +0530
X-Gm-Features: AUfX_myOFeewylletx6BUewZtTLrd-aeWyf-smNaGSOpHCLWyp-j_Z72uyvEHH0
Message-ID: <CAPEHo3JH-xC6D4duTYzn2hVtvJU_6DWa83fG4z05YQ5ONZC_qw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] Add initial Raspberry Pi Pico 2 / RP2350 support
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 29 Jul 2026 04:55:22 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785257670; x=1785862470; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tt6BKIGyyBzCyM7XWfli/KrYb4wChUIGS2nTi/bshHU=;
 b=Pxgc3Gh5qYlLNUHdJWZuvcSvMgqqWozoCdD4LXJhr9wdIvywFsFJEMEaIFVhmNDMH9
 4oPibxzhvUeT3oFwnTZoh6OJc6ph9X1fuvM01D9yXdSK5adbZ/tkG1bpyXG+1sPIsrXa
 ZlrxXU4kIQ0nttK/fDN2QUBL02epxz2Nc3URyaTukqizoclHzLK5zxFwv2cR/OHTR92w
 1q00aJo/HEn3rDm2yZ1kmhwiox8E+tgMkQnfjRKy2CU0qIHY9Qif9c6BIqsNlHfme1vy
 XOrkD/CZJd2eFNhXlFLcPFlFug3q7izf9TKccGzs4MrwgzHkP4NEmXU4RwEQDwN0LAFf
 LOfA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 spf=fail smtp.mailfrom=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Pxgc3Gh5
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bhargavdas100@gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Pxgc3Gh5"; 
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

Hi Peter,

>
> Hi Bhargav,
>
> > This series adds initial U-Boot support for the Raspberry Pi Pico 2 board
> > and its RP2350 SoC, only the dual-core Cortex-M33 support is added.
>
> It would be useful to give a bigger overview of *why* this is
> happening? Is it used to boot Linux, some other OS? How can I test the
> wider ecosystem that this functionality provides?
>

In this hardware booting Linux would be close to impossible without
making hardware changes.
I was thinking maybe booting RTOSs from here, maybe freertos or zephyr.

I took this initially as PoC for porting U-Boot to a NO MMU
environment using a modern hardware.
I will share some workflow for the above in v2 but that might be while
before I port/write drivers for
some of the devices eg, timer , watchdog.

> > Sent as an RFC to get feedback on the overall approach before polishing
> > further.
> >
> > Status as of this RFC:
> >
> >   - UART1 console works; UART0 is not usable yet. Need to investigate.
> >   - Boot-tested on both Pico 2 and Pico 2 W boards.
> >   - `make sandbox_defconfig` passes with patches applied.
> >   - This series selects CPU_V7M for RP2350. RP2350's Cortex-M33 core is
> >     Armv8-M since there is no CPU_V8M support in U-Boot yet. Is CPU_V7M
> >     acceptable as a starting point with CPU_V8M as a later follow-up?
> >   - RP2350 has no device tree in mainline Linux yet, so patch 2
> >     hand-writes rp2350.dtsi / rp2350-pico2.dts locally, and
> >     rpi_pico2_defconfig uses CONFIG_OF_EMBED rather than
> >     CONFIG_OF_UPSTREAM.
>
> Has it been sent to a list upstream for review? Is there a timeline
> for that to happen?
>

No, it hasn't been sent. Also since it is almost impossible to boot
linux here, shall I send it ?

> >   - board/raspberrypi/pico2/ is added alongside the existing, unrelated
> >     BCM283x Raspberry Pi boards under board/raspberrypi/. Is this
> >     directory placement acceptable given the SoC is unrelated, or should
> >     it live elsewhere?
>
> It doesn't matter the relationship between SoCs, they're related
> because of the vendor. EG toradex is a board vendor that uses SoCs
> from a number of vendors.
>

Thanks for the clarifications.

> >   - Some functions and structures such as `struct rp2350_clocks_regs` is
> >     defined but not yet used.
> >   - misc_init_r() sets a fixed value for the "serial#" environment
> >     variable. This runs after relocation, so a successful env_set() here
> >     confirms env works post-relocation.
> >
> > Flashing procedure used for testing:
> >
> >     picotool uf2 convert u-boot.bin u-boot.uf2 --family rp2350-arm-s --offset 0x10000000
> >     picotool load u-boot.uf2 -v -x
> >
> > Bootlog:
> >
> >     U-Boot 2026.04-rc3-00070-gbabf6d42fec7-dirty (Jun 23 2026 - 01:55:20 +0530)
> >
> >     CPU:   Raspberry Pi RP2350
> >     Model: Raspberry Pi Pico 2
> >     DRAM:  520 KiB
> >     Core:  5 devices, 5 uclasses, devicetree: embed
> >     MMC:
> >     Loading Environment from nowhere... OK
> >     In:    serial@40078000
> >     Out:   serial@40078000
> >     Err:   serial@40078000
> >     RP2350>
> >
> > Bhargav Das (3):
> >   arm: Add RP2350 architecture support
> >   arm: dts: Add RP2350 device tree
> >   board: raspberrypi: Add Pico 2 support
> >
> >  arch/arm/Kconfig                          |   7 +
> >  arch/arm/Makefile                         |   2 +
> >  arch/arm/dts/Makefile                     |   1 +
> >  arch/arm/dts/rp2350-pico2.dts             |  30 +++
> >  arch/arm/dts/rp2350.dtsi                  |  32 +++
> >  arch/arm/include/asm/arch-rp2xxx/rp2350.h | 307 ++++++++++++++++++++++
> >  arch/arm/mach-rp2xxx/Kconfig              |  58 ++++
> >  arch/arm/mach-rp2xxx/Makefile             |   4 +
> >  arch/arm/mach-rp2xxx/image_def.S          |  23 ++
> >  arch/arm/mach-rp2xxx/rp2350.c             | 261 ++++++++++++++++++
> >  arch/arm/mach-rp2xxx/u-boot.lds           |  94 +++++++
> >  board/raspberrypi/pico2/Kconfig           |  15 ++
> >  board/raspberrypi/pico2/MAINTAINERS       |   9 +
> >  board/raspberrypi/pico2/Makefile          |   3 +
> >  board/raspberrypi/pico2/pico2.c           |  83 ++++++
> >  configs/rpi_pico2_defconfig               |  29 ++
> >  include/configs/rpi_pico2.h               |  48 ++++
> >  17 files changed, 1006 insertions(+)
> >  create mode 100644 arch/arm/dts/rp2350-pico2.dts
> >  create mode 100644 arch/arm/dts/rp2350.dtsi
> >  create mode 100644 arch/arm/include/asm/arch-rp2xxx/rp2350.h
> >  create mode 100644 arch/arm/mach-rp2xxx/Kconfig
> >  create mode 100644 arch/arm/mach-rp2xxx/Makefile
> >  create mode 100644 arch/arm/mach-rp2xxx/image_def.S
> >  create mode 100644 arch/arm/mach-rp2xxx/rp2350.c
> >  create mode 100644 arch/arm/mach-rp2xxx/u-boot.lds
> >  create mode 100644 board/raspberrypi/pico2/Kconfig
> >  create mode 100644 board/raspberrypi/pico2/MAINTAINERS
> >  create mode 100644 board/raspberrypi/pico2/Makefile
> >  create mode 100644 board/raspberrypi/pico2/pico2.c
> >  create mode 100644 configs/rpi_pico2_defconfig
> >  create mode 100644 include/configs/rpi_pico2.h
> >
> > --
> > 2.43.0
> >
