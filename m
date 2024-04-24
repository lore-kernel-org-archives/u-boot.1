Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F444C4345F
	for <u-boot@archiver.kernel.org>; Wed, 24 Apr 2024 12:04:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A768E8872F;
	Wed, 24 Apr 2024 14:04:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cLB4+eK2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EF2288DE4; Wed, 24 Apr 2024 09:52:38 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7766188DD5
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 09:52:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=net147@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2d9fe2b37acso88420931fa.2
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 00:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713945156; x=1714549956; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Z3uL2x6VO+U3Lqdl2lUbSeHsFEr8Ine2bn+HmSPqMh8=;
 b=cLB4+eK27bRlW+tts2wtXIUP+lTgQOoNi7pr0xzIc/e23YW5TRUnX43QOVRS53i7KY
 jvlpde3+ueON4Bz6eO9Q0n0YJRmR1QbOu2GnLZdlfYizuM94tiVZ4XsKjfCOcMwznn+g
 WId3Qr25YnjxLLdIxUi63/Kg2oG2vKfoOPCybqtbHaW6SnCvJVMCcU48Pc3x6Z3E/NjV
 gUoLw+c0cRaXKOLxVFgEsgvTccF1tEbIFBLDgOQoFMjRLIiYLxHoOzu9nFl6Oz4QaNS6
 fE7TplT83psDOYso3LL9c9a58yg+QzI6QPD8xk6vZC4LVeRZ70/tJPjnTOtCE7c0qm0W
 3BDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713945156; x=1714549956;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z3uL2x6VO+U3Lqdl2lUbSeHsFEr8Ine2bn+HmSPqMh8=;
 b=aR5NdYGU0axFSeI6B4URr3E17rOEtOoShiCFXGWa3xb+12/KPRZvU9k20zoaiv7vYV
 RR5zAZaOOrLDN9d9eC6o2InA1Nb3pVyjP/HUu2Dq9kAyfaO0//rOgpq4rzAbbUCXFJ3Z
 6OV1Fn7a/KhFdijTDikhB8bgr1cdosEvMPi+cVt/j9KfNiBN643kFKdLron30sdHqB00
 x0lyxxH9pxZEW4FMesDPqWx/eG3doqOtaGBgO8JtAvPfIf4eHZOPIUFd4DeiDpNVW6OD
 MfJH3XMgxn7guA4FnK6ZrAIE2CvxrJFE7ZBSQlqDGHJR+tY4Xr82P+TTIvb6mYzK0h3d
 kCxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVC/LVp+Sc+FaX4p2BAQRTKlFYx58s1O/He0oMEH1dqxBR+jbVO8KP0ERPZkdQn0f4/4fiwWlUmUSqfQLzQJT8Se8HhFg==
X-Gm-Message-State: AOJu0YxXo6Isa9L/WhvFjtolW4OrgZPMdIRfKHWRI5vv4lMk8+wyT97X
 TW1Oi+rty1bi8Wza3blvlcmpiJCG5uC76HKO7iqp1hVkLfSzHsXfrOHYuuln8sq9TghpBjiH3xQ
 wnfh3TeokUIRK7/jfknctZMX5Ey0=
X-Google-Smtp-Source: AGHT+IHDamWlS+uQQFHM43CVyeWYPxh9P3ZdxYoaap/d+7NURJayL7YFaChYuaeZtOTukFTeorJ7hk0+vdkpJsX/VK0=
X-Received: by 2002:a2e:9201:0:b0:2d8:901f:7f50 with SMTP id
 k1-20020a2e9201000000b002d8901f7f50mr923931ljg.9.1713945155424; Wed, 24 Apr
 2024 00:52:35 -0700 (PDT)
MIME-Version: 1.0
References: <ea5147ee8606c47e4d714f8a3e0143d0fd9a1599.camel@googlemail.com>
 <80286c54-c617-d790-b7dc-efd4e52259eb@rock-chips.com>
In-Reply-To: <80286c54-c617-d790-b7dc-efd4e52259eb@rock-chips.com>
From: Jonathan Liu <net147@gmail.com>
Date: Wed, 24 Apr 2024 17:52:23 +1000
Message-ID: <CANwerB1VhRichsmiozR3zTu2nWi0SsGg6Td5c8RuUe9rxrjsrA@mail.gmail.com>
Subject: Re: rk3399 issue: no DMA in Linux with mainline TF-A and U-Boot SPL
To: Kever Yang <kever.yang@rock-chips.com>
Cc: chf.fritz@googlemail.com, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Heiko Stuebner <heiko@sntech.de>, 
 Tony Xie <tony.xie@rock-chips.com>, JuliusWerner <jwerner@chromium.org>, 
 DanHandley <dan.handley@arm.com>, Rockchip <op-tee@rock-chips.com>, 
 Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
 op-tee@lists.trustedfirmware.org, tf-a@lists.trustedfirmware.org, 
 =?UTF-8?B?5byg5a2m5bm/?= <sugar.zhang@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 24 Apr 2024 14:04:05 +0200
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

Hi Kever,

I also see this issue when switching between Rockchip ATF and Upstream ATF.

Versions:
Rockchip DDR Blob - rk3399_ddr_800MHz_v1.30.bin
Rockchip Miniloader - rk3399_miniloader_v1.30.bin
Rockchip ATF - rk3399_bl31_v1.36.elf
Upstream ATF - git://git.trustedfirmware.org/TF-A/trusted-firmware-a.git,
git tag v2.8.0, with RK3399_BAUDRATE changed from 115200 to 1500000 in
plat/rockchip/rk3399/rk3399_def.h
U-Boot - git://git.denx.de/u-boot.git, git tag v2022.01

Results:
Rockchip DDR Blob + Rockchip Miniloader + Rockchip ATF + U-Boot = DMA working
  dma-pl330 ff6d0000.dma-controller: Loaded driver for PL330 DMAC-241330
  dma-pl330 ff6d0000.dma-controller:       DBUFF-32x8bytes Num_Chans-6
Num_Peri-12 Num_Events-12
  dma-pl330 ff6e0000.dma-controller: Loaded driver for PL330 DMAC-241330
  dma-pl330 ff6e0000.dma-controller:       DBUFF-128x8bytes
Num_Chans-8 Num_Peri-20 Num_Events-16
Rockchip DDR Blob + Rockchip Miniloader + Upstream ATF + U-Boot = DMA
not working
  OF: amba_device_add() failed (-19) for /bus/dma-controller@ff6d0000
  OF: amba_device_add() failed (-19) for /bus/dma-controller@ff6e0000

I can't check the Rockchip ATF source code as it isn't available.
Any idea what is different between Rockchip ATF and Upstream ATF for
DMA to work properly?

Regards,
Jonathan

On Mon, 3 Apr 2023 at 18:38, Kever Yang <kever.yang@rock-chips.com> wrote:
>
> Hi Christoph,
>
>      The ARM PL330 DMA driver in kernel only relate to:
>
> - DTS kernel used, can be check in /proc/device-tree/
>
> - kernel driver which should mach the compatible name.
>
> This driver should has nothing to do with U-Boot SPL or TF-A, because we
> don't have any special setting for PL330 in loader stage.
>
>
> Thanks,
>
> - Kever
>
> On 2023/4/3 03:01, Christoph Fritz wrote:
> > Hello Kever,
> >
> >   on a rk3399, booting current U-Boot SPL with mainline TF-A leads to
> > missing DMA (and no sound) on Linux.
> >
> > However, when using rockchip its so called mini-loader
> > (rk3399_miniloader_v1.26.bin) and their BL31 (rk3399_bl31_v1.35.elf) to
> > boot, DMA works perfectly fine.
> >
> > Tested on a custom rk3399 board and on ROCK Pi4.
> >
> > Attached to this mail are two boot logs with some debug prints:
> >
> >   - good_amba_log.txt (DMA works)
> >   - no_amba_log.txt (no DMA device)
> >
> > The main difference I can spot between the two logs is that on Linux
> > (drivers/amba/bus.c) AMBA_CID (0xb105f00d) cannot be found. Instead,
> > only some CORESIGHT_CIDs (presumably for debugging) and four 0x00000000
> > CIDs are detected.
> >
> > As a result, the "PL330 DMAC-241330" driver does not load. My theory is
> > that DMA needs to be allowed somewhere in the undocumented syscon-
> > registers, similar to what U-Boot is already doing for eMMC in
> > arch_cpu_init() (arch/arm/mach-rockchip/rk3399/rk3399.c).
> >
> > Any ideas?
> >
> > Or maybe I'm just missing some configuration?
> >
> > Since multiple software projects are involved (TF-A, OP-TEE, U-Boot,
> > Linux), I Cc'ed a bit.
> >
> >   Thanks
> >    -- Christoph
