Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6034AC44529
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 18:06:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 213A260708;
	Mon, 20 Jul 2026 18:06:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1spoZHwruas6; Mon, 20 Jul 2026 18:06:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 22327606A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784570769;
	bh=knfvZAjjGDlFRap++MkE48W/z+cPfere9ueNV3iKhVM=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=qSOAX6YmhlBqMJYxjKyX2ixmIFIbV/fku1NyUP0bAMx6ut7CWVVD32CzriJ3PH0ai
	 d/tQsLaI2BJPXPA+uskZyoC1ie1NGik19GFAXZhOHGREevupzBn8CRCtXMe3g4g83k
	 BD49FchyohB72+hPfRan5BNQLfz/Vvf1zr56fGsBH2ecXkgWKCDyaW4hK0gdECXUEN
	 O8wQ0d+a9tfXZ1Hzyf8RiMOviuZth2IBkfFOAE+meb12DPQYbEHkTck7Zj+0UzBk1b
	 JLU2mpZr0AArADfYFvd5boZoMKehL93fn/TyUwwKPt4TXUkk0QnCjBU5I6XDckDQVz
	 58wOIvj55IBvw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 22327606A7;
	Mon, 20 Jul 2026 18:06:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 725F8224
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:06:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 63A844009C
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:06:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uiYTJweOASxF for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 18:06:06 +0000 (UTC)
Received-SPF: Neutral (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 315A140081
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 315A140081
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 315A140081
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:06:06 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DC0A842FC; Mon, 20 Jul 2026 20:06:04 +0200 (CEST)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAC7980433
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 20:06:01 +0200 (CEST)
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-8486672f03cso10397144b3a.0
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 11:06:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784570760; cv=none;
 d=google.com; s=arc-20260327;
 b=jpXTYaXeIFTbuPeQdrhUpjY/Rjkrpphpp4I/O7FEBVnBzgC0S4V0GkyoKENvWr1zEH
 KJJg8WltbAatcN1b3ybHCs86okDEjUqEt1aWQSRtc4XVgFBounq0MWSSoWGALHeusf/d
 4eDsGYdL4c1+BYsR7Dw7lQ5l2XbuN4FjFwQusPgQUno4fHEBpHpVUe0I9pYyv9oqmGHS
 URRWqCxkksDwyD4EU2+dYpjBPOsFvGzmFYzkOxGZfFVt+z5jVDpQNQhzV9mlyVXAtoR1
 n9iSjzu12FhG0cnjL8sZIKfTODYrOtgl8nyY3NQQ2CzDrQt7Dfw5yZ+ovUJnzyTplonA
 mw5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=knfvZAjjGDlFRap++MkE48W/z+cPfere9ueNV3iKhVM=;
 fh=S5IsS0p2q/mDhy6CofKU3XdI4SX18ALJnocWEeQR4Xw=;
 b=olDZi+CFaBSEHpsz2HKU5X5DYrD0Qou8JV9pOKEdYDsZIcZslke520/gMRf/rtVzho
 5yk03jzqr2PZwZMAJRto/n9Ig0hfsjpbh8+wJBdHY075HtcyV7ZXzcZUliNF9tixnpYo
 E4eyfj5sskocRbJiKjPLlOvGNlczGc/EtfZsBhcQP+UkRglywroVK+TAZ17WDJzFBhUp
 otbvNZ5fVA1KAIOI0+z69aXhapciPCYquqf/nLkK/q13s/Eac0QIFyCqw4NC3zBTv7Px
 8Xd7rgRJ5A2OTGSoS/MqRQLRuqyBRk2wBRiWI9WN8Q1GjKk7Irw7sBcuCadVpvkiJNUy
 UwQw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784570760; x=1785175560;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=knfvZAjjGDlFRap++MkE48W/z+cPfere9ueNV3iKhVM=;
 b=c8rVpHGczH0Z69xXF0Q49za9eLRWhUI1fw5yqaG8Q07ggqesL7ogkFXuVvKBFZNZtN
 wSbkMA+eiBK8kmkVsezX5wwwlueBCiLgMcggorAocCbF84mPIZ+oH8/S/Gd9o6W7C5m+
 udrxdFueVULv6XPv2XESireOm7xhchYjgorJqr513Nt1+pzCKnofR7m9IUuvp7tjIrps
 hWS6iQpm/ih5ozOWJSJK8hAY13pFt4KZ7aOSZINDuNK+7Jf/0ymi3CdtRDfxXFql2T2x
 7irK2YdomXSTlyNo+yndAnHfnx6ZLYJOGXP/bYxl0pDgcH7eNYAjpMPRaNMHHoriKZkX
 Cscw==
X-Gm-Message-State: AOJu0YyHE4gfah6iaCaUUwRD6Ymk6PP+RIycMWMMWPTY7XqWNeWnXEXY
 rIlQPf2vg2Ilz0qqvzggPx+t9uaaPAqLXdDiSJkpMaT4wQ99aMJGFesZMN9k2swr63kOfM5mWQa
 Bz+/FMR5b0SnaQCQjtvQ6WONdB4+EA6PSGkv339zx
X-Gm-Gg: AfdE7ckukA9eUF4j4eX6C5Fzmi1z3BULgtPXlj05TKB7y8iGjU4mR41nUaS9DHa8t53
 IdJYMYTdDA/vYZjjsyFlh2BoPr+2cVp6052fXBsFSjCrvDY318NWxYTLfVV61Vpy5McTSVsnCul
 BaNFEo2yIfOHUvEVhNudHLgN5KbFvXXlTvk/z4aj7YlybWGchiA9GZ6JsrXpxI92sZTDYUM8vkd
 8++zXQWmrdGtK7BDID4K0EiitiIyUC+bmYoP+6fHE8CqYlhLR1bDYJmicjzMjef0XnaWFg=
X-Received: by 2002:a05:6a00:1c90:b0:847:8387:e32a with SMTP id
 d2e1a72fcca58-84c2948b8f7mr14124680b3a.46.1784570760120; Mon, 20 Jul 2026
 11:06:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260713-rk3576-boost-v1-0-9d23aa08f674@flipper.net>
 <20260713-rk3576-boost-v1-6-9d23aa08f674@flipper.net>
In-Reply-To: <20260713-rk3576-boost-v1-6-9d23aa08f674@flipper.net>
Date: Mon, 20 Jul 2026 12:05:12 -0600
X-Gm-Features: AUfX_mwbPisXm47cYN9mX_pKgH5SYY473sGAQvyDM9Io3YNeyvz1yjgp2wrmHlA
Message-ID: <CAFLszTiLyXPHD7fCC=3v2oHusLfE=rk+KRnBiqj_yQPTJmSSfw@mail.gmail.com>
Subject: Re: [PATCH 6/7] rockchip: mkimage: Add option for image load address
 and flag
To: alchark@flipper.net
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Tom Rini <trini@konsulko.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Xuhui Lin <xuhui.lin@rock-chips.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784570760; x=1785175560; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=knfvZAjjGDlFRap++MkE48W/z+cPfere9ueNV3iKhVM=;
 b=QBm+jHUUhPR9l7aO1UBXczNrIO/7QM9u8gx1H1GsMRCB3e76oRWyL+VgOtfg9CmHiT
 ROko1gb3utT0EaNUIBSUNdIPRuuPvt0XNEHUNDFGWGNgGZ2jc+MokXQHnFtBi1DTcbS6
 m2M6yh6bkFZBcxAGXShBx8rG+r0ERhaW5OfUA=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=QBm+jHUU
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=sjg@chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="QBm+jHUU";
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
From: Simon Glass via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Simon Glass <sjg@chromium.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Jonas,

On 2026-07-13T10:02:41, Alexey Charkov <alchark@flipper.net> wrote:
> rockchip: mkimage: Add option for image load address and flag
>
> The v2 image format supports defining a load address and flag for each
> embedded image.
>
> Add initial support for writing the image load address and flag to the
> v2 image format header.
>
> This may later be used for RK3576 to embed a minimal initial image that
> if required to fix booting from SD-card due to a BootROM issue.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
> tools/rkcommon.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

> This may later be used for RK3576 to embed a minimal initial image that
> if required to fix booting from SD-card due to a BootROM issue.

Typo: 'that if required' should be 'that is required'.

> diff --git a/tools/rkcommon.c b/tools/rkcommon.c
> @@ -385,7 +389,8 @@ static void rkcommon_set_header0_v2(void *buf, struct image_tool_params *params)
> -             hdr->images[i].address = 0xFFFFFFFF;
> +             hdr->images[i].address = spl_params.images[i].address ?: 0xFFFFFFFF;
> +             hdr->images[i].flag = spl_params.images[i].flag;

Lower-case hex please.

These should have cpu_to_le32(), as with the other header fields, even
though I suspect we don't use big-endian with Rockchip.

Also, the subject says 'Add option' but no mkimage option is added -
the fields can only be set from within rkcommon.c - so perhaps 'Add
support for image load address and flag' would be more accurate.

Regards,
Simon
