Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D02B4CE8D60
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 09:00:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BE14890F6;
	Thu, 19 Sep 2024 11:00:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KQW6aGl+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41AD8890F4; Thu, 19 Sep 2024 11:00:26 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2074B890FC
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 11:00:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-5e1ba0adcb0so332276eaf.0
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 02:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726736422; x=1727341222; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hBJ88n6oqJhzY2Fcq3R3D6zfRt4LkFwrsxwCbpNg7Bk=;
 b=KQW6aGl+Wb4F4Pg+jN2brHwQcH/EAHFCiOOsXzxtZdMmULF8ihQsa2PL4KOxzsCq5d
 ZP6FWvcncHH21nkuwuawCBuXCp5hlFmOwOA4T3OVyBXol4nFWgpBQs5nLzxUvBoLQFuA
 thKiIAwgeQLRCmUUkJjrYKRz5icARdpRJZcc6br6ubxssF2eJBqtsdbG14BNSR6uWI5F
 vCd4+BH+anLfqX4TTW2jIsGzhDKqsq2JvKMcxB3ef/SYYUsdn2jpiASToUA8/kBXc77v
 jpT13HBEEBNj9DInfO4J+JiHmJFfgY17b5E3//JoWm7v0ZED+kQJLCe/3Fbj9r40msXP
 AUnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726736422; x=1727341222;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hBJ88n6oqJhzY2Fcq3R3D6zfRt4LkFwrsxwCbpNg7Bk=;
 b=qxv83FlOpOftuI7fugykmwjVxja6EfyhiDyWUTxc+9Lltnpgn3rCB/jdqwHifZZCcv
 wbEU3sQpjZin1XM2TQr/misblej7kZ3D5L7cny1FjCWLP+9PwhSJd3Uv3nfcIP/6IV8a
 SU4Zwi+HuXnoVBs7zKYitDWBSPNx49GpikdCnkpdCKUr1inEVeCKB/PeqOuQTk9jFDIa
 Nueh5t1c47i+K1QAi2bqRoXurzdHyKwnXWt5JAw8zKw+5TEDwX7l9Dsub2EW2BCeKTSC
 D+xWXXc2dpogLNKBwvfmkcDVBwWiebUHJ2NH1KVUUmVSrpX6FNO764I09hy+Dh8y0J4W
 lm9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2CVTLneicUXiLR4QaEn1WNue2kxWN/pjGwr4InRC87ZXcdIxT9HIEhIbZljT6/lyzf1ncQ8c=@lists.denx.de
X-Gm-Message-State: AOJu0YwtTdwbBNSuKEWdPNA1Cy55Io6adrgzIeMO28Wk/i2CENrRdw/X
 qRe3sAJ9a2xu0FJ+bYi9Ai5I5YvVahIKlFBxNyEkhBTTIzSMoVpQ3/sO7I9WIfPWP8fy2j1hVVU
 1ElA0VBlN+NoaA2IITspQF/0Rkos=
X-Google-Smtp-Source: AGHT+IFqc5pHFlhqC4xw5ksHZDiMF0Dq6t/LYISkoVV3S8sd0+sFx4F5z5FSnwG0msDpwWpS4lkVmhkdATydHGz1yo0=
X-Received: by 2002:a05:6870:4722:b0:260:e611:c09 with SMTP id
 586e51a60fabf-27c3f6cdbc5mr14107176fac.47.1726736422521; Thu, 19 Sep 2024
 02:00:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240806043849.3607-1-linux.amoon@gmail.com>
 <5deea5f5-de08-473b-9f80-170c8126ba30@rock-chips.com>
In-Reply-To: <5deea5f5-de08-473b-9f80-170c8126ba30@rock-chips.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 19 Sep 2024 14:30:07 +0530
Message-ID: <CANAwSgTbph1FSqCkxdhyfY=Rx3LxCCc_PzC54=AbTT9dmPAwMw@mail.gmail.com>
Subject: Re: [PATCH v1 00/12] Bind Syscon driver with OF_REAL
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>,
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

Hi Kever,

On Sat, 14 Sept 2024 at 15:30, Kever Yang <kever.yang@rock-chips.com> wrote:
>
> Hi Anand,
>
> On 2024/8/6 12:38, Anand Moon wrote:
>
> Bind syscon driver with dm_scan_fdt_dev
> As OF_PLATDATA is no longer enabled, the related
> code is removed.
>
> The OF_PLATDATA is no removed, basically it's use in TPL/SPL for code size,
>
> and the SPL_OF_PLATDATA and TPL_PLATDAT still available,
>
> The OF_REAL is only to replace "OF_CONTROL && !OF_PLATDATA."
>

Thanks, for this update.
.
> Thanks,
> - Kever
>

Thanks

-Anand

> Compiled and tested on RK3399 and RV1126 board.
>
> Thanks
> -Anand
>
> Anand Moon (12):
>   arm: rockchip: rk3399: Remove unused syscon drivers code
>   arch: rockchip: rv1126: Update syscon driver binding method
>   arm: rockchip: rv1126: Remove unused syscon drivers code
>   arm: rockchip: px30: Remove unused syscon drivers code
>   arch: rockchip: rk3066: Update syscon driver binding method
>   arm: rockchip: rk3066: Remove unused syscon drivers code
>   arch: rockchip: rk3368: Update syscon driver binding method
>   arm: rockchip: rk3368: Remove unused syscon drivers code
>   arch: rockchip: rk3188: Update syscon driver binding method
>   arm: rockchip: rk3188: Remove unused syscon drivers code
>   arch: rockchip: rk3288: Update syscon driver binding method
>   arm: rockchip: rk3288: Remove unused syscon drivers code
>
>  arch/arm/mach-rockchip/px30/syscon_px30.c     |  31 ----
>  arch/arm/mach-rockchip/rk3066/syscon_rk3066.c |  34 +---
>  arch/arm/mach-rockchip/rk3188/syscon_rk3188.c |  34 +---
>  arch/arm/mach-rockchip/rk3288/syscon_rk3288.c | 157 +-----------------
>  arch/arm/mach-rockchip/rk3368/syscon_rk3368.c |  41 +----
>  arch/arm/mach-rockchip/rk3399/syscon_rk3399.c |  45 -----
>  arch/arm/mach-rockchip/rv1126/syscon_rv1126.c |  27 +--
>  7 files changed, 14 insertions(+), 355 deletions(-)
>
>
> base-commit: 6becf9ba1ab82af6f4fcf9f4d0da38f9c75212d2
