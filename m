Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98CD5C55174
	for <u-boot@archiver.kernel.org>; Sat,  8 Aug 2026 13:37:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 28EEE80DD0;
	Sat,  8 Aug 2026 13:37:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qxiyq-CLd8qY; Sat,  8 Aug 2026 13:37:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 44DA180DC8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786196257;
	bh=lAi3BFQmgkm1TTHSOdMfnbKWz/5e5fhlqM1ZG40Ws0c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ftTMkpBXI+nmutTDGPX9tdFPlC+Gafdc4QcsBgB2n3A/e2GW73+RrP7isAQADknIg
	 B3mLFiSVmYD6KHbLXHHn6avVhCl19fvKN8DCE+mHURyXMe3Lrnijn4+q7Xdykajefw
	 ahhCjVsldWnAERUPyuYcPyyKpmN3YEePJYLALSOaOJq/djogYIIPzOEalejoAmfxov
	 3klk2atVQlBzgiG1eszuSlg7oJ2GtnB3rAsW6+aqwyEM3R/mX7vGmS1pb4tpk22y6e
	 gM7ozzd+zgzk+9q6ytS/NYfJ9x7AYBKe28OZD1Vpk92yNltiCVx2YLpswz2U7mkeVf
	 88CjFtWk+YAiw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 44DA180DC8;
	Sat,  8 Aug 2026 13:37:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3B109296
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 13:37:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2CB7D60672
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 13:37:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iTgtFg91HzAV for <u-boot@lists.u-boot-project.org>;
 Sat,  8 Aug 2026 13:37:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 2B79F6065E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2B79F6065E
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2B79F6065E
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 13:37:33 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6983d3dae7aso4475645a12.0
 for <u-boot@lists.u-boot-project.org>; Sat, 08 Aug 2026 06:37:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786196252; cv=none;
 d=google.com; s=arc-20260327;
 b=Zeik2n8gmMIGdk6BTzauYgzZLKf/+6Fx1ThoQr2M3+ifNv/ohJ0U7WjdODCkIdCxm6
 +aID+EINERUZO833VyFVMR+oq9zggjr2b3SBHo/2nzvw6fORsyNNV4yy2kjyKkrTemQ9
 +4CBrFVf5VIoAQtInhku//fXkXVqBOaGVVtrnSKFCO4YNlKwfTOz8udM0V7zAOYwawYN
 D1eL1gtZDAohAQ3OakreRaOjf8w+u2byAovMKYa26J4SRAki0YAForpqFhFpSbN//1dq
 sqsFfw64/RvABuWujP9IzlbPT1caeSKybpLXATetCDUYSM7GPcSrG6zsyLqC29nw2gFS
 2R/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=lAi3BFQmgkm1TTHSOdMfnbKWz/5e5fhlqM1ZG40Ws0c=;
 fh=wv9U280orsXMno9WuTni6ohWD2+xkOxQCZ2w+wycjaI=;
 b=Q/VVU85BGh/GBZK7IeSAi7FpxRcAkH2m5IhHBlci0yJ4QNnbxO/sRJSuJ9ck72LJpg
 j9opPhfJd8NmpqFKoBeNLRH0U6s9q+ZswWJcGx5JIOF00EkKYLoY1HVz4UNMGn6Yr/dN
 kqKgHViUnzq/yXIxwwxzAq3xSx7sqIrkhZyhFDKwHtpcR9NSuqGJI+lRi2roj7sEBpzO
 Ic1p7pb7m3oVqhqd7q2mVIxLrB+4ExYQe+761Oux4paCsdOFndww1TZmo4qmskwS5SSP
 JdEoQM7/Q5R4iJqX1E1DS8A6O0C9vSvT2ZZVtUe5y9lStP0fR2zUH79ozfJUjYRTHaSy
 F8VA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786196252; x=1786801052;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=lAi3BFQmgkm1TTHSOdMfnbKWz/5e5fhlqM1ZG40Ws0c=;
 b=EANaajgmS3i4Vcc7gz9aquLv9sojo2PGJBgv3y1E+rZJNqtqpI8C9UfoVF09UEB2FN
 a5SEkF7oftu968FBReUUO5G9KwzxRuxnSoK2L519GV/ps33XYlsjHfnlJZ5YmV2H6DhG
 oGU5D+iZCUvdDorPA5SqPsXuCnI1AiH1fgIyLQ76PM6b+NRA7WTQRcHC/jlmnmnH7sRj
 Kw6eUrKPf31yK56OQA4WVXcP56SNFgcxeTQxQ+uxqbD5iPtuwDp18sxhffDLTsbxEugN
 nrlwUFlq8SeiBv5IAymvSiXodrztP+D1tDgSUcuy0el6TIP6dBEJGjFoQaxivuNdOiqR
 xa7w==
X-Forwarded-Encrypted: i=1;
 AHgh+RrtX79tspUSwlPldXp30YdkSCjQL7kbdwJdYHTplTbg0dNjSlGsNMwfK06ULQh/zESjBd5GJPQ=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yz9c73nEkF3Kfv6Wbv6hPeW7qV1KWg+N9Rmv7qFb+4KhjFflvQ+
 dXJGrZjNnRUztN+Ei0ScnaEBRxrw1SoLMIMbIWCVcYDYBkUnYmy85eNlUyhooSat8avn7E1cW9I
 6U8QBJfz7Iq2GyIHoiqX129lhdspO1+k1ZinaB59D
X-Gm-Gg: AR+sD105XqicafXxhB8Ohndi1xxWnvBuLQ/SZdLAa/0ZVgXKIpa7gL7OSNaUSlVNnhi
 zu5Qvj0Kr3Kq4xZ5gZFzj/1ZCbggkVWUdDcfaLpy7GhfETvKIW0FNn9hNHF5h7rhUKXX+rxQwPW
 yFv2JTxclKIE/O3l1Qoa2S47mU1etO6FnQcHFGuCiaND12wEjdBThGAUMoJAZgV1ESxir8YDlSz
 ml0IZNBVdVSA3JoDDH6tx44wtmrbPT9rOAOowBjl7GZPPmb8666CnpgkdYQkv4gP/B3+zP6UhRm
 HofL/Ay4vSd4c+/cRTcCplG0jdWhfRO5nlIN80PcP+c=
X-Received: by 2002:a17:906:7946:b0:c20:367d:f8b8 with SMTP id
 a640c23a62f3a-c208d3cb2d6mr207523766b.4.1786196251753; Sat, 08 Aug 2026
 06:37:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260730141308.1218014-1-jonas@kwiboo.se>
In-Reply-To: <20260730141308.1218014-1-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 8 Aug 2026 07:37:18 -0600
X-Gm-Features: AUfX_mx1Jneh73D_jH_-LfwJv3ILxb6vCeYlAbiUG6_CPyo9iewPY9q3PeXq9po
Message-ID: <CAFLszTjbyE8LJXimR9qjvzf=1bA5PZvG+yZtsmjkbz_FDDzg5g@mail.gmail.com>
Subject: Re: [PATCH 00/15] rockchip: Miscellaneous RK35xx clock fixes
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Lukasz Majewski <lukma@denx.de>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786196252; x=1786801052;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lAi3BFQmgkm1TTHSOdMfnbKWz/5e5fhlqM1ZG40Ws0c=;
 b=lrwz1psEXh3VPXV3gGdU8uVWzEcc8U0i3l/BCbjA2hvjmRW4Ty6/CYMu8FhGeDthjO
 2qAQ9bqgIY58f93YTazcZBZpbhy89SardYXDPcQDKYTz+QeI+Ibt9xAlU6pu5UKy/Sjn
 NuI2OtlDPn3TY+qCgG1oupuGl+dD61v+QegaM=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=lrwz1psE
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

Hi Jonas,

On Thu, 30 Jul 2026 at 08:13, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> This series fixes a few trivial copy-paste mistakes and other misc clock
> issues for RK35xx SoCs.
>
> Patch 1-3 fixes minor and very unlikely issues for plls
> Patch 4 fixes PPLL mode handling on RK3588/RK3576
> Patch 5 disable 'special pll handling' for RK3576 plls
> Patch 6-7,11-13 fixes trivial clock configuration errors
> Patch 8-9 fixes less trivial clock configuration errors
> Patch 14-15 remove unused GRF syscon lookups
>
> Some of these fixes has only been compile tested as it involves clocks
> or rates that is rarely used in U-Boot.
>
> The 'special pll handling' should ideally be moved into clk_rk3588
> driver, something that can be done in a future follow-up series.
>
> Jonas Karlman (15):
>   clk: rockchip: pll: Fix double use of postdiv1
>   clk: rockchip: pll: Always write the dsmpd flag
>   clk: rockchip: pll: Always write the k param
>   clk: rockchip: pll: Use PLL_FIXED_MODE flag on rk3588/rk3576 plls
>   clk: rockchip: pll: Limit special rk3588_pll handling to RK3588
>   clk: rockchip: rk3568: Fix trivial clock configuration errors
>   clk: rockchip: rk3588: Fix trivial clock configuration errors
>   clk: rockchip: rk3588: Fix possible divide by zero
>   clk: rockchip: rk3588: Fix ACLK_BUS_ROOT rate set during probe
>   clk: rockchip: rk3588: Use SPLL_HZ constant
>   clk: rockchip: rk3576: Fix trivial clock configuration errors
>   clk: rockchip: rk3528: Fix trivial clock configuration errors
>   clk: rockchip: rk3506: Fix trivial clock configuration errors
>   clk: rockchip: rk3568: Drop unused GRF syscon lookup
>   clk: rockchip: rk3588: Drop unused GRF syscon lookup
>
>  .../include/asm/arch-rockchip/cru_rk3568.h    |  1 -
>  .../include/asm/arch-rockchip/cru_rk3576.h    |  5 +-
>  .../include/asm/arch-rockchip/cru_rk3588.h    |  6 +-
>  drivers/clk/rockchip/clk_pll.c                | 56 ++++++++++---------
>  drivers/clk/rockchip/clk_rk3506.c             |  2 +
>  drivers/clk/rockchip/clk_rk3528.c             |  7 ++-
>  drivers/clk/rockchip/clk_rk3568.c             | 12 ++--
>  drivers/clk/rockchip/clk_rk3576.c             | 26 ++++-----
>  drivers/clk/rockchip/clk_rk3588.c             | 39 ++++++-------
>  9 files changed, 72 insertions(+), 82 deletions(-)
>
> --
> 2.54.0
>

Just to note that Quentin has done a very thorough review and I didn't
see anything else to mention, so I'm not going to send review tags on
this one.

Regards,
Simon
