Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4823DCD343F
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 11:04:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDD4F84A85;
	Thu,  7 May 2026 13:04:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="K8a2G01J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3849484A97; Thu,  7 May 2026 13:04:22 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB05E84A81
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 13:04:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7de46b8e432so664784a34.1
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 04:04:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778151858; cv=none;
 d=google.com; s=arc-20240605;
 b=JMt801A2EO4RsAdYnnKOJmPcCdPBLdxnsgkT1Wo0bFrQYE4xPksBmJD233yRoBKPbg
 U5/DuOW1gZMAruQhyM2SlFNfH/btlo/2wgF/h1n+SS9QT9vj8GGt/XbrtDXEHzHUFlI9
 /cAj6xQ8MtNRDVs7V9zOSwvoCZsJ8cpHhYkk1bpKLsfx4JpvKUTpxifNPKoH7HkaqvKA
 WoZFIZkhiEEuEp7ofJA3agP3ixpeGj6zTicWZyWsm2IWelILfdehhOHUfZxq+I0TD5SC
 BQNzodHj27FJX4iUqLWSbhlaXplF4UPEVpVfzX9IZwmja5fVMNc4eAJG8n+zj4MKlWyo
 miFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=v/wznG1/psjKtJqBirBZurZA4lTrrEID19UCuo2/AhM=;
 fh=PU95mNB4AuxGQ84jDLQBHcUTgKxXUQt4G4Ky7TZC1AM=;
 b=lkdlKGDIvtlUbzoVPZQ765InqRQOYCLJQkpDWOs6+okfsuOOm1XUpKSXoNSkWcOfNp
 eZZPwniEiksp4RaXZ87Jbs5aeIsVmzM/xkPhSywgy+Qu30M/hq1L9KK20Gc6k2R0liR/
 tVDIOO8UH67IvR+niccveKIsMGtipBfyVldUWyjvjP8OESuXFWOz8okK3RY6GxaL9Zsn
 ZPj5DagsjehR+M0BxpoFVWojo6gqL41YFbsCsDwgOiqX/WbCddQb0lBAReDNCshJ+2+c
 WK3WjByZJD5ee1AtVgr8scE1lBz3kvzeausK6lJq0Se8HnNN2pZW2vFmh/kZyVo8F/Ea
 t0bg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778151858; x=1778756658; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v/wznG1/psjKtJqBirBZurZA4lTrrEID19UCuo2/AhM=;
 b=K8a2G01JW3ULX7RGRfKEwkiHTq8NuP79No5eBciu3wUSh6vTsD+xLIoJrOmLIiBmBB
 8IXnyl+wYlR9vmFs0iiOlhjwme5CmCcfAZmNjCRQ+Pl+wAoJt3ydEwTtHzpJMJ46gWR/
 uBNsdSUikOJqIzQO1fcj32K08NvfXPf2aePzxM0VkrKYlxisgTRPCsISLEfUs6adD8cd
 +X0bmpBi5n39JlSLerr0w/0+I8s0lA6CxKLgLSOqXlTHkhCPRCbmCkP92EuUgsEmY+1n
 4E+6eBlvr+vIgE2ITKoSBLZd3kEGOoqtP7ur7YLZ/buUJLQR9a2mio0E/VaIE0Ugdrxx
 Pt4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778151858; x=1778756658;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=v/wznG1/psjKtJqBirBZurZA4lTrrEID19UCuo2/AhM=;
 b=iMhKZ+AuStF18+MSdneU++AZX/TkIzM8cPgLCTPZgJ3UdeFXxNvmpobgJIuMemW0R5
 WkYL6p8SLHdYGTdXZ2ReyeBSf5WOZEsGZCNfFMQupi+zrTTf41Z0Koq59GNxEUg5bp90
 jieBxPQn2/p+HujB4/ErOzNwXe9CK2zumIlnpMaFttQhXSKTKi+rPMyqMNhUkRHQ+OyB
 Q5KriAjT6jEl4J6hcZ//kAGCjeZE+c+b0sIgW7LsJC1q0F9mm+tPe5cBC/t5YiEFnE9C
 O0IOMbtt325qzScVG2FTVlMhjoJaWnIclZYlaQK75GziR82LJK3qOFM/L8CwfBRqYoNZ
 b1lA==
X-Gm-Message-State: AOJu0YzzLhvQFxpxTfxAvFvoaJqEfKQflqHea0eOlAVjM6i5vPXd/SPs
 iq72ppis7ctXYE26hbormb04rM9swclwbliDjn0mD9hH3d/OqPqN1cDc/5S7m9YNK4A6UJo84qJ
 T3m66TTvsXJaUXhFedMYhIw1R8IAqmDE=
X-Gm-Gg: AeBDieuAOSjegJRY2q4rLawpM638N6Bdb7f7G85/Wp6DTj2cs5rCeo/hzY6IrCja7SN
 DIHBu/lwcxixtvrJnFaIZNpKwg6Rx9OghPpV9uR16hTotkFYrpjOKkDF7M71iSaPKo61Dwfas5N
 9jlBURMGf81xJZqpbo3xpzQgSj46/uy56PrY3Xm9vBz5yTmEok6Pe3bsE606qaGINxvzGIDj7bB
 Yz6YagRsWaTveDPm1M7QzwQ6jYOIRttsfMnsQXBOCtn4gZ3HoLUuhWsaPlugVHoB5JiVXLzk3+3
 /SJE6PuGHoI1EFmxs2+W6qW7FtcXfM1vs2x0QDyd
X-Received: by 2002:a05:6830:201:b0:7e1:e832:c8a2 with SMTP id
 46e09a7af769-7e1e832ca72mr2683264a34.19.1778151858388; Thu, 07 May 2026
 04:04:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260423080637.30006-1-alif.zakuan.yuslaimi@altera.com>
In-Reply-To: <20260423080637.30006-1-alif.zakuan.yuslaimi@altera.com>
From: Sune Brian <briansune@gmail.com>
Date: Thu, 7 May 2026 19:04:06 +0800
X-Gm-Features: AVHnY4JSE4I5ur3h7kdYhxvMLWQYK6D1x2HO-jRtIQ6Qqv14GLXoKl0tf_SxLMg
Message-ID: <CAN7C2SD8D4yHnSLAQfrs3-kgGfmZrqh6fMXmB=QOfZYq9Uq7EA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] SoCFPGA: Update DDR Support for Gen5/Arria10 in
 U-Boot
To: Tien Fong Chee <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, alif.zakuan.yuslaimi@altera.com, 
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Apr 23, 2026 at 4:06=E2=80=AFPM <alif.zakuan.yuslaimi@altera.com> w=
rote:
>
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>
> This patch set updates the boot support for the Altera SoCFPGA Gen5/Arria=
10 platform in U-Boot. The changes include:
>         1. Update MMU/dcache setup across Gen5/Arria10 using common drive=
r
>         2. Add ECC scrubbing support for Gen5/Arria10
>         3. Add DRAM size checking for Gen5/Arria10
>
> This patch set has been tested on CycloneV devkit with SDMMC boot and RAM=
 boot (TFTP & ARM DS debugger).
> Tested on Arria10 devkit with RAM boot as well
>
> v1->v2:
> --------
> - ECC scrubbing, Gen5 DRAM size checking, and shared dram_bank_mmu_setup(=
) is set as optional via Kconfig and
>   defaulted on only for the reference Arria10/CycloneV boards to avoid SP=
L overflows on size-limited Gen5
>   defconfigs.

Well, I don't know I am only a contributor after all:
1) But do some one or some ones clearly mentioned [1]
2) Per-version change history must be placed below the '---' separator.
    The required format is 'Changes in vN:'. Custom formats are not
    acceptable.

So v1->v2 is considered as a valid format and not a custom format.
Hum, interesting.

What a wonderful world =3D]

Appreciated all the "reviewers" HAHA :D

Brian

[1] https://docs.u-boot.org/en/latest/develop/sending_patches.html#sending-=
updated-patch-versions

>
> History:
> --------
> [v1]: https://patchwork.ozlabs.org/project/uboot/cover/20251216084623.195=
89-1-alif.zakuan.yuslaimi@altera.com/
>
> Alif Zakuan Yuslaimi (3):
>   arm: socfpga: Consolidate dram_bank_mmu_setup()
>   ddr: altera: gen5: Add DRAM size checking
>   ddr: socfpga: Add ECC DRAM scrubbing support for Gen5/Arria10
>
>  arch/arm/mach-socfpga/Kconfig        | 21 +++++++
>  arch/arm/mach-socfpga/misc.c         | 31 ++++++++++
>  arch/arm/mach-socfpga/misc_arria10.c | 26 ---------
>  arch/arm/mach-socfpga/spl_a10.c      |  4 ++
>  arch/arm/mach-socfpga/spl_gen5.c     | 17 ++++++
>  drivers/ddr/altera/Makefile          |  4 +-
>  drivers/ddr/altera/sdram_arria10.c   | 34 +++++------
>  drivers/ddr/altera/sdram_gen5.c      | 64 ++++++++++++++++++++-
>  drivers/ddr/altera/sdram_soc32.c     | 85 ++++++++++++++++++++++++++++
>  drivers/ddr/altera/sdram_soc32.h     | 15 +++++
>  10 files changed, 252 insertions(+), 49 deletions(-)
>  create mode 100644 drivers/ddr/altera/sdram_soc32.c
>  create mode 100644 drivers/ddr/altera/sdram_soc32.h
>
> --
> 2.43.7
>
