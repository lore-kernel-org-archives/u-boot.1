Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9949ECD37BE
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 13:29:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07195838D7;
	Mon, 11 May 2026 15:29:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nvR92gAU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF40380398; Mon, 11 May 2026 15:29:36 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3B2283A91
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 15:29:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-67c4aaf76ecso6759359a12.3
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 06:29:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778506174; cv=none;
 d=google.com; s=arc-20240605;
 b=PkT4tKmS2YrpLzIHFJRk4WuvPOSjHgKfX6Js/auYPRDS4p1qFagDqABG3ISqzl/STn
 s25fSCE/ao3CrINc1suuDU/3n9SqKBTJPbDxoUg7Nl0f69pZRGcM6q+SdlMaCYUawY5k
 FOsiVkjNPRwmq+rEPKml8wXj7qvnsAoBdeOC3mSjMKpVKOavm1FbdWrQigJWT1wJvfOp
 YoKZz8GibE/Hdfpd/0kt/he3qLi/vDUQzDzCPrS6tF58N+s0846tHRY+LN4ks8aYjBAH
 7iqIH3POne83DUAac9CXCUqCKR153/tNq6xl2yAf9WNTGZKfF/o2mYQ915acm9wdmaKL
 YKxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Y5MYVxhCqVURCgu/Q/pjVezeunG0Iy1BAdugwC7/VcI=;
 fh=GQ2cjfQn5sZJCXk7Y4miokBo6mkL3WClEi6ZZsPVrlo=;
 b=C6Iu3ZqrS6einTt1wz13vVgGu9TnmAeS5dzC9AazL5UF/Ga2sjSA0/W23j2E3oF27k
 DMEAI83T5zTujs86C4OT5QgS5gvrmaRU0Kt7mQKZcPr0ToHS60aASMDEWq5AG0of2f6h
 dEvmIXJcWVGBQAdmzipkp/+L6s5jqHFp3AgOv23MB5E272hwMtkNOFdH4USt/IfZy5Hd
 +jkZ7wndstUKcSPWKWoqSDgREWZb04FXVQwOxr7EhWoEQIEFUaGFgzEALPxi7E1CKyH5
 KrrzUH4KE3wDvinqqby0pUCwPOIWppU2fiv0+oBsWsaVUexROXXXsPjog/C6qnKb2ZPR
 T/Lw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778506174; x=1779110974; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Y5MYVxhCqVURCgu/Q/pjVezeunG0Iy1BAdugwC7/VcI=;
 b=nvR92gAUCGRGZrWYiAm3VRxiUuzpmcgcPaKJBoEsUa7g6vyXTnrjb8JO6TQdFsxywv
 6r3BZ02ZUSn4aeRtUBUlnnSgDT+7agR+EzCBHJ9MRI7Ch5Pgz5xk8Fsi+1OqNykljjqR
 TQohjfML4mgJQAvyZ0lCnhQbP2zZZfDPG0QRVcqEnSC0rGP/iZG7OccohN3MqCXasgfW
 uXDbE77J4YRB7etRSmpX5nkqQ01DFtHOa0DVmc/sHAI82jvU8dL2nHtihdDxX92/0qQZ
 eymO5+uUaY0Yhl3BUX6QqboW7TJI5Bx71zDfrP2pY0G27xUhIfdQoctk+BSUOarCcIgO
 5dAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778506174; x=1779110974;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y5MYVxhCqVURCgu/Q/pjVezeunG0Iy1BAdugwC7/VcI=;
 b=kFC8mMdOvG/2WDTHMvfROXAxwkCf+ZVlc0PXqp9Qo5E3vcJ0vduuLRh3+fsPM/AuW1
 IrDbWLT4OdG7acXN+EVsRQk4353OhMP2qnmrzfXCGOHpMVZcWI4cR8Uh48Mzxy9iY3fu
 ZFhOdca/pjfAYG3PjV77MD0/07eWsYqKln/wqxsDxieEXN1ufqbpUiOzuvC8v3VqXPv0
 AYtT7Fgmyl2bt5/Q5Xm+FRw9ivu0ov4NFj00kyTqSjLCVhYkYREKVr8XLMkRSwDEZG3x
 qEcskr6OM4GPMvMfd/dXKlg0E2xfTGXL6owUcDIx2yzIJT8hLUzZrf+ZZEPiXXalqd4g
 DyRA==
X-Gm-Message-State: AOJu0Yyb4n9vBjWdUPH3HniOPjQu+XOMWrEmUxivVXcCKnuQXMnTobsS
 a/GZ6tjgc4trUmQziY7H6UQ7W+yVc6z+0UIDvXiL95OAXqvop++A1fiMUQxUtmeaI9WrrOhEWIs
 eXjFIkBiMbOQWvST4SHYrPqNfRBo6zQc=
X-Gm-Gg: Acq92OEkUEaC5jp8B2lJmrVQbrlfHVf8S3MrZf/INvCZf6uYGpttcp/BUtzS/n0IwFa
 9a1z55K/P3ptXAWK4k4/ttT85qmJq2zv8mQobU+4stIDoggysbrmNeoGumpFrPuy3lQAKILFah+
 he9KRsZZTBujTO4hxSnVnSWkX8gDgiU/LCKy60wWZMs8Xmf1N5OjjwhsgA/ustGs7W7/oDkiCkH
 lYErrewPosJ42ttCI+FvTQmSzlvQXgh0WP62PBse2h7wGJFy9pXSoycw2VrpvjL9ZR0WZliM4w5
 NS0PoFPTQdqKWJ2J2eU8uaN44ooTwOZfgLeVO+Ml+NLGDEEiMkDYp3edp23sBUU2UCzxPfSK1wZ
 QTFAgWJWOFGWvNXiZsOTVS1+hN5UoDIfhmX4iDtDMUhIH+ffJ
X-Received: by 2002:a05:6402:35c5:b0:673:b696:8823 with SMTP id
 4fb4d7f45d1cf-67d642b99f0mr12230214a12.15.1778506174167; Mon, 11 May 2026
 06:29:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260508233254.2022495-1-sjg@chromium.org>
 <CALeDE9PLAf9-VrOCfKmDDiQHWFtMvowoB_U_35QZgixFiJ_s9g@mail.gmail.com>
In-Reply-To: <CALeDE9PLAf9-VrOCfKmDDiQHWFtMvowoB_U_35QZgixFiJ_s9g@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 11 May 2026 14:29:22 +0100
X-Gm-Features: AVHnY4JKWu_QvD9iI0q8qAtyh2rdAUL4jLnJ9kOhxHq0Su6LS-JunA0jkRm_4ZE
Message-ID: <CALeDE9O+9fpn8Ada4=xbLsuNcqrMTkN4z9k+_XF5zcA+j+-Kmw@mail.gmail.com>
Subject: Re: [PATCH] rpi: bcm2712: Extend DRAM mapping to 16 GiB
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Matthias Brugger <mbrugger@suse.com>, Stephen Warren <swarren@nvidia.com>, 
 Stephen Warren <swarren@wwwdotorg.org>, Tom Rini <trini@konsulko.com>
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

On Mon, 11 May 2026 at 12:40, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> Hi Simon,
>
> Thanks for this.
>
> On Sat, 9 May 2026 at 00:33, Simon Glass <sjg@chromium.org> wrote:
> >
> > The bcm2712 memory map only covers the first 1 GiB of DRAM, but Pi 5
> > models ship with up to 16 GiB. Accesses above 1 GiB fault because the
> > range is not present in the MMU page tables.
> >
> > Allocations above 1 GiB used to be blocked at the lmb layer because
> > memory above ram_top was reserved as no-overwrite. Commit 0efb6bc3e36d
> > ("lmb: Reinstate access to memory above ram_top") removed that
> > reservation, so callers like tftp now route allocations into the
> > unmapped range and trigger a fault.
> >
> > Extend the first DRAM entry to 16 GiB to cover the largest addressable
> > range for any production Pi 5 model. Smaller models are unaffected
> > because aarch64 only faults on actual access of unbacked memory, and
> > no peripheral region lies between 1 GiB and 64 GiB on this SoC
> > (peripherals start at 0x1000000000).
>
> So a couple of questions:
> 1) Do we need to do this for the Pi4 (bcm2711) too? It's currently at ~4Gb.
> 2) On the bcm2711 it sits at just under 4gb, initially that was
> 4Gb-16Mb AFAICT (917a1e9a78fe) and then it was reduced in a followup
> commit (c44b3f523c48) because of overlap with "device's IO area"
> 3) why doesn't the rpi5 have the overlap issues?

Also at least on a 1Gb RPi5 it's still crashing for me.

> Peter
>
> > Fixes: 0efb6bc3e36d ("lmb: Reinstate access to memory above ram_top")
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  arch/arm/mach-bcm283x/init.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/mach-bcm283x/init.c b/arch/arm/mach-bcm283x/init.c
> > index 7a1de22e0ae..3d11c9e5c3b 100644
> > --- a/arch/arm/mach-bcm283x/init.c
> > +++ b/arch/arm/mach-bcm283x/init.c
> > @@ -69,10 +69,10 @@ static struct mm_region bcm2711_mem_map[MEM_MAP_MAX_ENTRIES] = {
> >
> >  static struct mm_region bcm2712_mem_map[MEM_MAP_MAX_ENTRIES] = {
> >         {
> > -               /* First 1GB of DRAM */
> > +               /* DRAM, up to the 16 GiB maximum supported by Pi 5 models */
> >                 .virt = 0x00000000UL,
> >                 .phys = 0x00000000UL,
> > -               .size = 0x40000000UL,
> > +               .size = 0x400000000UL,
> >                 .attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
> >                          PTE_BLOCK_INNER_SHARE
> >         }, {
> > ---
> > base-commit: 3cdd19089f1b1b7cd08530f33ff4708abcfd426c
> > branch: rpi-us
> >
> > --
> > 2.43.0
> >
