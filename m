Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 197FBC55174
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 21:59:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D852C607FC;
	Wed,  5 Aug 2026 21:59:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XX-vvylMCKGE; Wed,  5 Aug 2026 21:59:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E2FC4607F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785967180;
	bh=KZozz+nrpJa0f4aljTUix+QA52eWi2NlDa5Nq9EioiM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tiEbkLHyceSzj+TgxYDVj4FRdNcH9komvyeFDp5Gd7+U1Ye5TIzHoNpxi4lYmQFQT
	 DEAxbSoLgWS4QNvQWchxvQuSRAYEQ9XxxcWqI+6ieW7p1rUGps7DfR/L693TvQdiD8
	 LIu/JOVXBnrSbMQAokEDwBRPYx4mpJdDl8eHfs1Kdrfl1y4LJ9U72nMVzViAxbfBgR
	 X+hoPn0XHNcq03nX6pjRWVSozj8KQ1ATjaNT4RPiB5n6eDoKVuLshZWUct09/Kdd0K
	 KoweXJ9wPGZKnGzb03op1R6XGHEZvlsV3ooJox0JSkO8BPW+QYLdjOeWARcimEaXPu
	 6yxx1jNIfakSQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E2FC4607F3;
	Wed,  5 Aug 2026 21:59:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 78C8410E
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 21:59:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6B040607F3
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 21:59:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dZZrZ5Nsncrh for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 21:59:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 89837607EC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 89837607EC
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 89837607EC
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 21:59:37 +0000 (UTC)
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2cca0c5799eso14703885ad.0
 for <u-boot@lists.u-boot-project.org>; Wed, 05 Aug 2026 14:59:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785967177; cv=none;
 d=google.com; s=arc-20260327;
 b=Vqc+scW6jL9X/zF6LCIy0PSMj4os/wnFg4THiNiIV9iD+Mq5NqlgzNaCbuel3pEZ0X
 kvhaONL950Tj6Ltt7ATJQww5dTHZzayzUzhd7jaYzFAcZiEvK2PsQ3Zcgjf3TFa7363O
 gEE++mAGJH9CX0wtGQ7D4gbySRbYKdYiz7a1Nm4A9brfY/yvwTIZ9UIwIJTY2fZspts3
 e/zApVPKInZpbTU5u9sqP0J/X5Db3CrjgvxQn/3K45eLNA26E0wH/ILEtWJrPYB0EXL4
 6mhWnRtBpC4TqwT2GedFel3ejl5dH35ej2BQndiGborADpyuDHpbM0lc+z5QPHxgrgJF
 VPSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=KZozz+nrpJa0f4aljTUix+QA52eWi2NlDa5Nq9EioiM=;
 fh=GgddJ0Y2B0TGYeYwz7nvdpt2hNg7U5gwGYMCJMjR0g8=;
 b=UqIk22GRp1WcT2EeEvLfQ1oRdfjYXjYs4tj3YbI4vwyZ6UkPMjcjXQFkfFZ/8dYdzo
 Dxuv95xSHPW8G3UQggf/Mnjcw96yo8ZryxaIsjBH4NcfnMpC00MefUAXiapNsYI4CL1z
 aoVfiELiDkzWbNCxBNTPwFuxry2a8vMg9cbfHM1ZREvITYW/adoPpFLL5ovteYuYXIWv
 SgyapIAyrLJIGqYEyn+ZguCY7YzrRPZe/Fo/aolfbFjdAQy6eaoI45UtJMCQXwPFoc1t
 ik5RRtdgfPvETwgjc47Lg7ZvmjlJQadmGuXCgiDQk6Of9mFBigFN0vvM8ZYAYiH/Xz/g
 Pjmw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785967177; x=1786571977;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=KZozz+nrpJa0f4aljTUix+QA52eWi2NlDa5Nq9EioiM=;
 b=e5KDljRj5TiKI+AAI5nsIPbfusy9/OyaDXZ+XJo+UlkrecVfyitPWYsXw33n0ofZ3A
 mB11+Jv2wCRHORB7zrl7r9v4A68/8yl1E9fr51Lnat40VRnHk5bNPzrBk01G6kwAJc/x
 VUcju2RCQYGMQ/e7i6Ihpn3r49on+1rYZJICrJ6z7J+wsiCeiN6bv6HZfYFVsVqWeEEg
 W1q1DX14kqSWo6pcXFdoSSUHyFvahcA+cmSoZZrp3+X0fa7sesvFTXxyxWTaBiJiJSah
 RiTT/sa/AY6QLeOffuMUDcHIrTU5OE6EC4XUyfry3CoZg/qDF5K7pMolhhuzrxgt+aS5
 DhbA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp65Wf3QwVQzO8kC7UuW3s+Vc024k5gbBeaj5nd4SPIXap5MoBLYkNWPZUfurkcEstB2lMNNHA=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yy9utu8VC1z+1qXyr5KfNct23jf1dpMx+M5gkgiA2owLCZeq6KK
 7Wda2Aw9tdU7K0Qa74TtELAKub4X32ekJ2oqCh4itsrJJyyInk75F3lyxyh9wBN/WM2ouOEtKsH
 JEmdod9Je9qCkoJstDFnREK6YLJnRyNuE9ci0yNNE
X-Gm-Gg: AR+sD10rjMKa0LYn9ExkGo2U8u2ouT130sGkll8c40Te7kziBm0OGL1z4jeCrXkto1x
 ogA1fUkoZFEw+mdtIljry8ZarqmAjCSY8ahBsJS1Bdp8L1wTHolqUAVybEadyOplWmvRe+aNXvC
 LmDCePnwABwx+ugiT80hqLUJ8AT3BmT8cAZeJD1XgfaYVrUfcuKesvyusx0ATJsQBR749LXV7yM
 YW64PHXj0RvcZc8KykbuGpjgDzsGt9VLdhjyjbimoufzh/WM3dOYxDEh1dbW+ZUdNCCfqkRZR5Y
 p+r8QDbiIvoBXBkE3K00sIk7G3diKVJFU2RVLHw5cCA=
X-Received: by 2002:a17:902:ef0a:b0:2c9:c517:d070 with SMTP id
 d9443c01a7336-2d0ca7afebcmr123879265ad.3.1785967176759; Wed, 05 Aug 2026
 14:59:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260730-math64-resync-v1-0-8792d9119d49@flipper.net>
 <20260730-math64-resync-v1-5-8792d9119d49@flipper.net>
In-Reply-To: <20260730-math64-resync-v1-5-8792d9119d49@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 5 Aug 2026 15:59:05 -0600
X-Gm-Features: AUfX_mzm_coRit2k7t7fDiA2gB7-OP1DPI202ts43Iv9A3khrOlRNKoF-P47CUU
Message-ID: <CAFLszTj8iC7A6TtTcGei8Ma=0y24hhxN_=8-itAaRKJ5aXJQyA@mail.gmail.com>
Subject: Re: [PATCH 5/5] lib: math64: sync <linux/math64.h> with Linux v7.1
To: alchark@flipper.net
Cc: Peng Fan <peng.fan@nxp.com>, u-boot@lists.u-boot-project.org, 
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785967177; x=1786571977;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KZozz+nrpJa0f4aljTUix+QA52eWi2NlDa5Nq9EioiM=;
 b=blo4i4oJw5fJ6llWnUp/rK+XMHOryuCrNtzQfR5GT3X35rgkvbjnPuVvU2LVG/oqXI
 vyZTkB3heGKro8qrFQvVIlcopfaErYMqweLkAxHc4QDZa5vlj5WSYX7NOiCMV24PF3j2
 dT0T1yRQmztKK0j2TIk8i3m5SlNiIVoLX4/nY=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=blo4i4oJ
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

On 2026-07-30T18:40:37, Alexey Charkov <alchark@flipper.net> wrote:
> lib: math64: sync <linux/math64.h> with Linux v7.1
>
> U-Boot's copy was last synced with Linux in 2017 by commit 0342e335ba88
> ("lib: div64: sync with Linux"). Since then it has only been touched
> twice locally, and both times in ways that increased the divergence
> rather than tracking upstream. Take the file from the v7.1 tag.
>
> The immediate motivation is DIV64_U64_ROUND_UP(). Commit 3adc17f60bf8
> ("lib: div64: Add support for round up of div64_u64") added it inside
> the #if BITS_PER_LONG == 64 branch, whereas Linux defines it
> unconditionally after that block. Any 32-bit user therefore fails to
> compile:
>
>   error: implicit declaration of function 'DIV64_U64_ROUND_UP';
>   did you mean 'DIV_ROUND_UP'?
>
> This has been surfaced while reworking fractional PLL logic for Rockchip
> RK3588/RK3576, which unexpectedly failed to compile on 32-bit variants [1].
>
> Newly available as a result: DIV64_U64_ROUND_UP() on 32-bit,
> DIV_U64_ROUND_UP(), DIV64_U64_ROUND_CLOSEST(), DIV_U64_ROUND_CLOSEST(),
> DIV_S64_ROUND_CLOSEST(), roundup_u64(), add_u64_u32() and
> mul_s64_u64_shr(), plus upstream's kernel-doc for everything that was
> already here and __always_inline on mul_u64_u32_shr()/mul_u64_u64_shr().
>
> The file is otherwise a verbatim copy of v7.1. Four deviations:
>
>  - The includes. U-Boot has no <linux/math.h>, no <asm/div64.h> and no
>    <vdso/math64.h>. do_div() comes from U-Boot's <div64.h>,
>    BITS_PER_LONG from <linux/bitops.h>, and abs64() from
>    <linux/kernel.h>, which is where U-Boot keeps the rest of what
>    upstream puts in <linux/math.h>.
>
>  - mul_s64_u64_shr() uses abs64() rather than abs(), because U-Boot's
>    abs() evaluates its argument as int for anything that is not a long.
>
>  - mul_u64_add_u64_div_u64() and the mul_u64_u64_div_u64() and
>    mul_u64_u64_div_u64_roundup() macros built on it are not ported.
>    They would need ~110 lines of lib/math/div64.c brought along, plus a
>    u128 type and OPTIMIZER_HIDE_VAR(), and U-Boot has no users for them
>    yet.
>
>  - abs_diff(), added locally by commit f1f4a1d1d835 ("compat: math64:
>    add abs_diff()"), is kept. Upstream has it in <linux/math.h>.
>
> Build tested for evb-rk3288-rk808 (32-bit LE), generic-rk3576 (64-bit
> LE), malta (32-bit BE, which is what compiles the __BIG_ENDIAN union
> paths in mul_u64_u64_shr() and mul_u64_u32_div()), sandbox and
> tools-only, with both gcc and clang. All six DIV*_ROUND_* macros plus
> roundup_u64(), mul_s64_u64_shr(), add_u64_u32() and abs_diff() were
> additionally instantiated on 32-bit ARM to confirm they now resolve.
>
> Closes: https://patchwork.ozlabs.org/project/uboot/patch/20260723-rk3588-fracpll-v2-2-382d113f3a80@flipper.net/#3731361 [1]
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
> include/linux/math64.h | 182 ++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 171 insertions(+), 11 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
