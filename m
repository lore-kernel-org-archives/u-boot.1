Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF94C55ABA
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 19:20:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ED75C6079A;
	Tue,  4 Aug 2026 19:20:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c_GbTUJWfyqr; Tue,  4 Aug 2026 19:20:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0C36160781
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785871201;
	bh=ebArJ4g7FCwrczEGY+wmMK4JRnNjbo8B/DAT6cxUSYQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K4s5E57PvQEkNpF04dK/nGQW8xAfaOTvG4UP1jlJO1ci1kqkC0+M0tnQ1JP8BFXgD
	 4riuGBqph2LbUHGYjxViKvSkHHFnWGLFP3QdCy4dXuZenNb1wpejpwlg55Hq3BXNWa
	 YCPYIoFd/HSvwTtt45YdtnQsLq2eV5H/5iCmS9dp+PWF6P5C+MVokjRMdOaBnVuplX
	 1DY19DWLjhs4SqWdsvfSVFc0jc1YM+ozD5p5CRWm/Krn0o65htcsvo4g6+CYYopR6c
	 Di47pi3Ux4Kk7E8rqm0VjGJTecJ/s/6Qf+ME8gZRZ1DWYEWSHQiu+FtwigFom+Qo2N
	 zUTKjCYHOH7Dg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C36160781;
	Tue,  4 Aug 2026 19:20:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id DF7322B6
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 19:19:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C5A5B401CA
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 19:19:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IX_SCc5IQ1aU for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 19:19:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org C92BA401A3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C92BA401A3
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C92BA401A3
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 19:19:57 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6a144c8f01fso500697a12.1
 for <u-boot@lists.u-boot-project.org>; Tue, 04 Aug 2026 12:19:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785871195; cv=none;
 d=google.com; s=arc-20260327;
 b=HjZUp8HfbUMLm44eAjbtVBAjqtW3bMM15oHnlp2fScMH9pt23jV01WrSG1njnV1B/N
 1oOTHhpt5mV5xUHw/JsK1ve38fMH/ucPaxv5YETp+V+VOyru/lfJiOn++oLpFXlrA46Q
 r5jHrhm9phW/qrE9C2TLa3Kty/ZwoPiaGYFO4Lu79Q+DwWoFBM3oV9Q90flHfQ93WfUg
 y1KW8gtMK+SgJlZhZGtbM/tHckIezkj0Av5lOO3ThIaP6Cni+WRZb1pWKOZZhOQtAfnr
 CgwQAlNfLR8e6S3GnmK3w2NwQJdZ4EyvfEHyAxM7vwuVpDwdLjhhWKbe6mBtDK80qrF9
 J4Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ebArJ4g7FCwrczEGY+wmMK4JRnNjbo8B/DAT6cxUSYQ=;
 fh=Qf4arb6qvJTZOLQqtlKayM+6YUom6SXfWn6i7mhKMpA=;
 b=NLFQDMo+GAxQeLTrpuc3vBnM93jlnJUSDtSi7eM9UpZe3EzUFFH2Vzx7X+8FSnHRzL
 N1Y05pAhbvzFQdhPR+TsNBlDlot0026WEJUvq1tw+I9wYITLBlBQrVwQsy/JJa12DHo8
 7/OM14dDfp3+pwg/uxM6/SksyZC2sX8eeFdka1B9ZRSt7AOVL44p2Q840+SIrdmzsaDm
 CzSTSO212fmKT6SKhVgtLf8iUM5ofp8Fkc9opbgL9DmW4weSY1Vg0WhaDLB35u1xEj7y
 WYAWo0k7u0UxIVzzo27luQr1pFtEmVJWOvcG0Evb3k9wN0TtJipi5tTRTEOUPYzkzWKb
 2VKQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785871195; x=1786475995;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ebArJ4g7FCwrczEGY+wmMK4JRnNjbo8B/DAT6cxUSYQ=;
 b=Ci4jmMhAQQimbICnu70NEXZr4HuLYK670kJTpQ3T6r3Y9KGoClasaZYH2A+IKBNS6u
 igQ/jnfuPXPiWdORwPyw9GCSPS/pfN+eYtvpstaJEfuGlM6B27NQwaP0/CrtRWLmG8vG
 5hkmNDhhycFGdtlQtY2DUYcLBELsLslFssgYZxOIPqKqOf+NvfcM0XGrmAWzjFl82o/p
 4DTNAE5xrz9BiBsU3aaODIMgUBp2bnWgVH8EFMMAMuUUJGr5CXAnQFKocYeGxys5mDJ4
 J+vbMMFW6z90KrjO3MxPsSbLvQhgn9oLYfBs0ZFGXQJROp07naiuXkVwniK/fScIZ7L+
 5SgQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpF0Wlqqbub+oZNumTJUR7didRrXvmjkTFJSEkVGtgeazJ9SnY7ViKxAOKkBH9iMTQZzsuCK9M=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyXVOci9yv/QWdFoAqSDMv2Jc3nfZXBg/qNJz4ikIyvvsKnxZFy
 TCpMTPhB4G9/QcRFqn2uixy/LydxUSlPw5PFegdAntPOv5xjifQfQe5j7OS/1IDTfm6gHnKUH2/
 +rpGMs9oWMCUkU6vz2lM4SqyjmFzGLNQZ7Wiyb4yUJ4AF6KYnwG0=
X-Gm-Gg: AR+sD12wK5Z5Oz68hPA5jVoA3/XBpzHYkNtlLMXgbXOqjDmbCsmFq1HMqOG7KiGFChZ
 o/eoPx+iUec9Q9i+rEb3Zs6ynpbfVhiG825emmE75k2BkC3h1zSA3IbG2CTQclM3jy2NqHQfCCh
 6HLlCVzUkUlyqmXknWP9kEPERm3QTSQLFAJzgYLXrc3tOcKH5Bx3C/kJkL4sEohJVUbQjdRqJV+
 gB8QBbmSHxebq6Jy4aMtqZp896bZPDcx77bo3wFEhyxjaNiH0OUwOl/pPcXxQqwVlVAK5th9bOh
 fVDG/KSacV002NEBerECM4NMuoHMvu6Zm1jzz13+QWI=
X-Received: by 2002:a05:6402:4002:b0:6a1:332a:83c1 with SMTP id
 4fb4d7f45d1cf-6a14ef6fe2fmr907061a12.6.1785871195492; Tue, 04 Aug 2026
 12:19:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260804105721.2402406-1-jonas@kwiboo.se>
In-Reply-To: <20260804105721.2402406-1-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 4 Aug 2026 13:19:42 -0600
X-Gm-Features: AUfX_myUjAdYsD5sNGIr8HKRuzLDZmNKibyElSj48j7BGEyTCfwxu_HDmXJQwPw
Message-ID: <CAFLszTjBiTtKmjgknvXGFBrphh6kpBzRg8iroWjFQ0EDvuXTyQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] rockchip: Remove unneeded syscon driver for RK35xx
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785871195; x=1786475995;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ebArJ4g7FCwrczEGY+wmMK4JRnNjbo8B/DAT6cxUSYQ=;
 b=lG+pfWzcnPfDwTU2BIuq3DZCL39qE+pIpscOvBXAehAczfnCNTe9HOPSqJk9md0l3x
 h0qyWfhuL1290OUVFsMlWS8kSXK9syGTf+8vbhCpZbO44K0fsbxNidy37m0XILBLn9Ej
 NEJmhBOefD6UAKKBR7YO3cmBNu6S1tetOxgKs=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=lG+pfWzc
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

On Tue, 4 Aug 2026 at 04:57, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> This series takes the initial steps required to try and remove use of
> syscon_get_first_range() or syscon_get_regmap_by_driver_data() to get
> GRF base addresses at runtime for the Rockchip platform.
>
> The GRF base addresses are fixed and known at compile time, yet drivers
> keep trying to resolve them at runtime delaying some operations by
> several ms.

I suppose all addresses are known at compile-time, if you have a
single device tree. I have always hoped that we might end up with a
generic U-Boot for rockchip.

I wonder if there is another way to do this, perhaps reading the
address once and caching it?

>
> In this initial part the three current uses of ROCKCHIP_SYSCON_x lookup
> used on RK35xx SoCs is converted to use a constant value or using
> phandle lookup, followed by removing the SoC specific syscon driver and
> finally removing the RK35xx special ROCKCHIP_SYSCON_x enum values.
>
> The changes included in this series have no intended behavior change for
> the affected RK35xx SoCs.
>
> Future series will continue to convert uses of ROCKCHIP_SYSCON_x for
> remaining older RK SoCs if this initial part is accepted.
>
> Jonas Karlman (9):
>   ram: rockchip: rk3568: Simplify get_info() ops
>   ram: rockchip: rk3588: Simplify get_info() ops
>   video: rockchip: dw_mipi_dsi: Get GRF base address from phandle
>   rockchip: rk3568: Remove unneeded syscon driver
>   rockchip: rk3588: Remove unneeded syscon driver
>   rockchip: rk3576: Remove unneeded syscon driver
>   rockchip: rk3528: Remove unneeded syscon driver
>   rockchip: rk3506: Remove unneeded syscon driver
>   rockchip: include: Remove unused ROCKCHIP_SYSCON_x enum values
>
>  arch/arm/include/asm/arch-rockchip/clock.h    |  8 -----
>  arch/arm/mach-rockchip/rk3506/Makefile        |  1 -
>  arch/arm/mach-rockchip/rk3506/syscon_rk3506.c | 19 ------------
>  arch/arm/mach-rockchip/rk3528/Makefile        |  1 -
>  arch/arm/mach-rockchip/rk3528/syscon_rk3528.c | 19 ------------
>  arch/arm/mach-rockchip/rk3568/Makefile        |  1 -
>  arch/arm/mach-rockchip/rk3568/syscon_rk3568.c | 23 --------------
>  arch/arm/mach-rockchip/rk3576/Makefile        |  1 -
>  arch/arm/mach-rockchip/rk3576/syscon_rk3576.c | 22 -------------
>  arch/arm/mach-rockchip/rk3588/Makefile        |  1 -
>  arch/arm/mach-rockchip/rk3588/syscon_rk3588.c | 31 -------------------
>  drivers/ram/rockchip/sdram_rk3568.c           | 29 +++--------------
>  drivers/ram/rockchip/sdram_rk3588.c           | 31 ++++---------------
>  drivers/video/rockchip/dw_mipi_dsi_rockchip.c | 16 ++++++----
>  14 files changed, 21 insertions(+), 182 deletions(-)
>  delete mode 100644 arch/arm/mach-rockchip/rk3506/syscon_rk3506.c
>  delete mode 100644 arch/arm/mach-rockchip/rk3528/syscon_rk3528.c
>  delete mode 100644 arch/arm/mach-rockchip/rk3568/syscon_rk3568.c
>  delete mode 100644 arch/arm/mach-rockchip/rk3576/syscon_rk3576.c
>  delete mode 100644 arch/arm/mach-rockchip/rk3588/syscon_rk3588.c
>
> --
> 2.54.0
>

Regards,
Simon
