Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B66C5AD49
	for <u-boot@archiver.kernel.org>; Thu, 29 May 2025 11:11:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55C8D83015;
	Thu, 29 May 2025 13:11:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IspbjsoH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CB4E8301F; Thu, 29 May 2025 13:11:18 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92EB882FD6
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 13:11:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-adb2bd27c7bso33323066b.2
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 04:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748517076; x=1749121876; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hY6wpXz0TDorW+d9RB8YQHpmkh0m6agTIrLoVIChIOo=;
 b=IspbjsoHLgKYCItM8A/FoQw7bnqYv2KLZVnjmerl9rHrPU7p4mp1xKn3LkqGnY7jja
 7sGrK9wFmlF/JF5btJo/8EVhNQffhE4lDuiIHdofe0HoAmLcMEOTcpvyY/+qxfxWwumC
 LQxaaL/oGUNe5tNFnNFIBS/9labBrxxhBUksRciyXAoVKeqiuCfyyCTaUu4L1p3MoQss
 wT/dI/KFvOJn5p6xBubKIPCIwyv0w4z8ZHI9ZwB/yVdVxtugfha2Vx/71/lvaIWgMUmU
 xt8pO09tS4wdRmNAu+M+WwXqm4HJEog9bJWMi2f8iWA1GqY+f/GYYGJX9Fb20Tha3Glr
 v7Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748517076; x=1749121876;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hY6wpXz0TDorW+d9RB8YQHpmkh0m6agTIrLoVIChIOo=;
 b=QklT8dIJp4z+sodGyD8KhlozCps/uGxTMmd70rn3SEagHCbo+Xe2KkA1u1HOprJDqO
 EDpipdiLtsoH0e1uvSiXTvr4k/tDWKHr5I1KTXRggknx1e82HfnwlqOKBaJHay6zwBeQ
 32G2mWlyr5HAE+HIqJvIGZXq4DRZjemw0ZW15XG4DoOaG9HijIlZgjq8AOvvHMMxzoUP
 a+qxM3C5OzHmZXAPuiEt2JqC4addj8ILeDMOTjSWJ9suE4fL0CRctcwNb93SJL5oRxFF
 lMzMo0JKS7N7fz9UoMcHov4csfWx0+X+fYv8c0WpK7rF1w0Vqn9vgGKV16Ncx16sDIx7
 3fjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUX6+iNjDaOzAbr6+Uknw3MIEjo2uMMB6j9yV+FIXJtwa9TICrtT62/YFhT/z857Y9hJ1YZT0A=@lists.denx.de
X-Gm-Message-State: AOJu0YzzHvr0c0q3xq5BKdcLHwDo9yn4e9AZOEIILeWkAJOgYo49f8w7
 wOwjeiXCfTMr8n1h6Jkh0ielTlPz71SbdRyOBTwHIKIpzL3H+/8/8fOH2InscK6A6B/4V1I9+nW
 EWoLHjY/qzOhhctFSDPKuqgu2v5vjse+JOYUFw8I=
X-Gm-Gg: ASbGncvLvm0ard+pGExH0CUedZijSj4awreIUmMPcuTWJJhNbS7Ypc6yJlDG1BFccgQ
 2H4nerqGWuIjoEbAfJFYJE1HSMcEeHdM6nSjza4takHPpvuHWcPGJF/juYCqO4ozQQAKh6z5+Mw
 fCwvk84ELUTiRFixxlwELuAL1DOWn65pIQlYBOfTGUX5dvbJb7pG0Sit5rZYcjijhiS+FC3/fjg
 vrG
X-Google-Smtp-Source: AGHT+IHSx0rVp2742CxHRknAn4XtGqgqbE8C56zcP+n4Y0bvfbr0Umc7mDW5/kvbkhVVap4TJVLwXGQnpnfr5ILdlbI=
X-Received: by 2002:a17:907:86a2:b0:ad1:e7f0:d8e5 with SMTP id
 a640c23a62f3a-ad85b0d21f9mr2057908166b.16.1748517075715; Thu, 29 May 2025
 04:11:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250408221151.2762853-1-jonas@kwiboo.se>
In-Reply-To: <20250408221151.2762853-1-jonas@kwiboo.se>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 29 May 2025 12:11:03 +0100
X-Gm-Features: AX0GCFvBrPkd3kZz1j2ENofPQPyMJ2HzHTNjcux0Bv2FvbSBScHIrMkKWMHnFBo
Message-ID: <CALeDE9N+9ki7OtCqG9U0FU4FXP-z-WSTuPQkonWYGTQkMuynzw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] rockchip: Update rng compatible for RK356x and
 RK3588
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
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

Hi Jonas,

Sorry for the late reply here.

On Tue, 8 Apr 2025 at 23:37, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> This series adds support for and updates the random generator compatible
> used for RK356x and RK3588.
>
> The RK356x rng node is already part of dts/upstream so the rng node in
> u-boot.dtsi is removed, and because it is not enabled for rk3566 it gets
> enabled in u-boot.dtsi to restore its use in U-Boot.

It's explicitly disabled in the upstream kernel because it doesn't
produce actual random data and hence upstream believe it shouldn't be
used, there's a couple of threads on it.

Have we tested to see if the data produced in U-Boot from the HW
exhibits a different outcome? I wonder if Kever is aware of the kernel
issue and can provide input.

Peter

> The RK3588 rng node is added into dts/upstream DT by picking a commit
> from devicetree-rebasing v6.15-rc1-dts and the rng node in u-boot.dtsi
> is removed.
>
> Changes in v2:
> - Split rng driver and DT change into separate patches for RK356x
> - Pick RK3588 rng node commit from devicetree-rebasing v6.15-rc1-dts
>
> Jonas Karlman (3):
>   rng: rockchip_rng: Add compatible for RK3568
>   rockchip: rk356x: Remove rng node from u-boot.dtsi
>   rng: rockchip_rng: Update compatible for RK3588
>
> Nicolas Frattaroli (1):
>   arm64: dts: rockchip: Add rng node to RK3588
>
>  arch/arm/dts/rk356x-u-boot.dtsi                  | 9 ++++-----
>  arch/arm/dts/rk3588s-u-boot.dtsi                 | 5 -----
>  drivers/rng/rockchip_rng.c                       | 6 +++++-
>  dts/upstream/src/arm64/rockchip/rk3588-base.dtsi | 8 ++++++++
>  4 files changed, 17 insertions(+), 11 deletions(-)
>
> --
> 2.49.0
>
