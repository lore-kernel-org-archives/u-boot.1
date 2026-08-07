Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6907C5AC7A
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 20:41:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 522214098B;
	Fri,  7 Aug 2026 20:41:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1HRx5nv-Crbs; Fri,  7 Aug 2026 20:41:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 88D4240999
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786135263;
	bh=67BBNbZyTuaWWFHg7i6JUgwv9ZrVIoHGLpgoInY54mk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CwhuGTfuEYCcG7I2YqhIrv/03cX/dRbTMpTj/TsoiB9o/h7XLSLUM8egD10FhiSEb
	 zJ0tby/U3RwzW5Kue1tPsXtDOgf24LVdQ+n9AbhBa77gqRV4E/vMo6wCpSQUwK1siS
	 lfu+ildKIly1BX/Pu8cxcH4W3dNjqgxjyH8xHpMqq50734VvyomO4B7OAGbbkYCAo9
	 2hHVQVRxqIExfLbTwBkyQ9N4tfrJcI7+sIgZ1XaESwgfWIkATdqrsZ0NNtJZ9Hac76
	 QMmIprooayXf1vFWaIdXJvKJ2t0XwFGnI8teol4RVCOQlpQImYCRPIJfhMRErh1qjT
	 zemjkcjwaE5rw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 88D4240999;
	Fri,  7 Aug 2026 20:41:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 996982F5
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 20:41:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8B08E40999
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 20:41:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OpUsW_zbThSO for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 20:41:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 8B91D4098B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8B91D4098B
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8B91D4098B
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 20:41:00 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6a051b737d8so4195948a12.1
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 13:41:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786135258; cv=none;
 d=google.com; s=arc-20260327;
 b=Ej48a7Mo1ysauuy6HesW0pmJwnpS8aRMUSJ6IoJV4M69y/1uxNValn1bh4AgjlA+QR
 QJPQyvhgpZtB+NCyszuyoFMC/BofyakiQ9f6uQ95aG/GUIT/aJvJZeOlG4DEVnm0ahvD
 QGjREbn94tiN4hDbORIJ8yLfzF/AOrXubtW0xmb0N6ahDIs5KQ+hgMy2Ov65LvEgarzL
 KGyNInTcLyyaiLHoMpOiNys54XJdIMSuf4y2Mm2P7M84XYTSis6/nfVziho1MEPPpXS8
 BdBZmNjFpKFCW/GrL4M2kZ5FVsv/lBnmXeK7uWHB0IpX4kS20yhjsOTBNCvh+peJx7Ur
 DhiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=67BBNbZyTuaWWFHg7i6JUgwv9ZrVIoHGLpgoInY54mk=;
 fh=kV8TEdUg0fu/uIwa2WQOtjY98xc/e9lYWfTnhEF5JIw=;
 b=LkUnNx/d/VJv29x2w8ho66UKMVLpTlYOTBsxuKh/WAPgIxvhByWZaEIAtc6xP/oy9p
 3G8fhOllpV8sJ01db/zZq+BGP4IZ0dSPx4d5e3ML1n4fX7NPzVO3L383KdU2xrisRE8X
 Jmfm5fsjM4oUrqhpYoJ/vTJs7pHSo6AONnAkY7TOYtKB+1wWX7nfNIk+l0ZI+/S7nhLI
 b9o53Y50KD5odLzAfKS5w4CZLiDklvniwTk1X+hqfx8gXY61jzPgAa8Go0t1lhmxqGl/
 9nt6GaHWJ7J05Qcfx9TOoAi2/glP/P4MkNGe8Wy1lHPl74W2qq0vJB49YE4qBbTTzTq7
 de/A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786135258; x=1786740058;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=67BBNbZyTuaWWFHg7i6JUgwv9ZrVIoHGLpgoInY54mk=;
 b=pnh8dncx+21I/vLH74DvfRauV9+psjfj7x8eA2h+WXf/rUzyidu78BqoZaSPD9nzTH
 ++iuN3FPFa54RF/xwC+n1iH+6E7Uunxrz6hfVV5SH+Skw3HdSiF6EdGokgfoplsyOtnS
 OcAkRIEEiHwwky2ldtJe9QaU+W2Yf1lNIewCK6X+SpbgsKCFpHZ61p1J/GVDxbQmsSLV
 jErNjHMz434r876Ixl+KkhJAfvWN4hnz1JX43VQRJ8yRDOlGZbqv9AGzeK7B2r/P/B5G
 d4ubhtgSZzpqm99t+zuYBmzbA5m3+PDrsYw+E3oshaLTtcSH0J9iUI5vWYPoSPwqSxxu
 raIw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrWAqc1PyS1xErv0zZV7uTKLbSDPWz2aHdcXYwWSn9AFHDtKgIDNvafBfT0TaZQoKkWddEo95s=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzzbmeYUB+CT/UHRXruDEXhSIfXLaiNVKr/JpmACB16Ti+W9nA7
 PEXIi3nQ66DxhROYdeKVuT4yPi7ltumYGDVjFhZd3GirareJ9DEcjKQsmhLfvptCfTkMjuBYDdI
 7UxszTlRU3rJ2sVyA/kZvgKb0Y+dQxja7HRC19sLg
X-Gm-Gg: AR+sD109jPBFy3mp09LHxmOprE6Cyn6FCgHyJxKQJvun4dQPA4A98S0qpM/w+iqthkh
 xe0+vncz9gqIesrCkuwlWVXnrTOuPeUSf/73U5sFEUw10JEGZV6tRcnXVVFxKiA/9s2RNgQwIYB
 4GBj9Ji76Ej011Ass6gdiyBYUXKHUNhOVzKctyrcG0VjU7ieg28w3M7PorbA+ktBGizPAQFW+BE
 h1ydQ8cZkQIqp1zVdLUoaJDktJjEkwdXWUrybPN2OCvEbAR0m42YyoAEaAxWSG0E5KDKA0z7CAE
 Vj2/pmTWl6WZs0aqT2zWT4OfasBl60eFTCsiN3Cc/Pw=
X-Received: by 2002:a05:6402:42c3:b0:69a:a279:dc10 with SMTP id
 4fb4d7f45d1cf-6a1f28d746dmr1242870a12.10.1786135258484; Fri, 07 Aug 2026
 13:40:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260807090431.464978-1-jonas@kwiboo.se>
In-Reply-To: <20260807090431.464978-1-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 7 Aug 2026 14:40:46 -0600
X-Gm-Features: AUfX_mxhClB2TUmpUhuRjkcHjuM_tL1BdvNhpJkJ4uhADSviBfbYt0_jUrEq7a0
Message-ID: <CAFLszThA3502QnQxSGyQL+WPEz3tovqE8VA7512gjVKUPSBMEg@mail.gmail.com>
Subject: Re: [PATCH] rockchip: px30: Fix TPL_STACK overflow into BootROM
 reserved region
To: jonas@kwiboo.se
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786135258; x=1786740058;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=67BBNbZyTuaWWFHg7i6JUgwv9ZrVIoHGLpgoInY54mk=;
 b=G3d1m7O09HkwTP0AQAMlNXwsffW26s9z+X0ATMcmBXJS0r8BLLnQ9KMSKzTXihRAjQ
 bWQDe1h8ErTtdCa4ba28fmwdTjxS64o0D/cvPuhb16K2bswgyt3uGfpu4x+7HRTSORD4
 cb3TNx31CcdgUJiAu8tWtmA9XPmISN4GXwrhc=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=G3d1m7O0
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

On 2026-08-07T09:04:31, Jonas Karlman <jonas@kwiboo.se> wrote:
> rockchip: px30: Fix TPL_STACK overflow into BootROM reserved region
>
> The PX30/RK3326 has 16 KiB SRAM at [0xff0e0000, 0xff0e4000), with the
> initial 4 KiB at [0xff0e0000, 0xff0e1000) reserved for BootROM at boot.
>
> SRAM addressing only seem to use 14 bits, meaning that reading from
> 0xff0e4000+ wraps around and instad reads back data at 0xff0e0000+.

Typos: 'seem' -> 'seems', 'instad' -> 'instead' and 'possible looks'
below -> 'possibly looks'.

>
> Using a TPL_STACK at 0xff0e4ff0 (16-bytes aligned) means TPL use BootROM
> reserved region for its global data, malloc area and runtime stack.
>
> TPL on PX30/RK3326 does not have any use for the malloc area and the
> generated GD_SIZE is typically around 304 bytes.
>
> Current memory layout possible looks something like:
>
>   [0xff0e0000, 0xff0e4000)          16 KiB   SRAM
>     [0xff0e0000, 0xff0e1000)         4 KiB   BROM area
>       [0xff0e09f0, 0xff0e0ff0)    1536 bytes  malloc area (unused)
>       [0xff0e08c0, 0xff0e09f0)     304 bytes  global data
> [...]
>
> arch/arm/mach-rockchip/px30/Kconfig | 4 ++--
>  common/spl/Kconfig.tpl              | 2 +-
>  tools/rkcommon.c                    | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)

> diff --git a/common/spl/Kconfig.tpl b/common/spl/Kconfig.tpl
> @@ -129,7 +129,7 @@ config TPL_MAX_SIZE
> -     default 0x2800 if ROCKCHIP_PX30
> +     default 0x2c00 if ROCKCHIP_PX30

Just to check, the layout shows [0xff0e3c00, 0xff0e3ed0) as pure
stack, but BSS (e.g. dram_info in sdram_px30.c) sits after
__image_copy_end and is not counted by the TPL_MAX_SIZE assert in
u-boot-tpl-v8.lds, so with an image close to 11 KiB the real stack
headroom is a bit less than 720 bytes.

The rest checks out: crt0_64.S does bic sp, x0, #0xf then
board_init_f_alloc_reserve(), so with 0xff0e4000 the GD ends up at
rounddown(0xff0e4000 - sizeof(gd), 16) and nothing writes at or above
0xff0e4000, and px30-board-tpl.c uses no malloc, so a zero
TPL_SYS_MALLOC_F_LEN is safe.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
