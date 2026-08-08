Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2126C55174
	for <u-boot@archiver.kernel.org>; Sat,  8 Aug 2026 17:35:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 83D0060626;
	Sat,  8 Aug 2026 17:35:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HoQVSJzbhwsZ; Sat,  8 Aug 2026 17:35:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C8A2060692
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786210544;
	bh=PO+mc7BZdnsev4h5E3be+QuyIw2r/ZTqBTPl+bARC74=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Xz0uF+VWXf/r9JrJc6JvBwGeVEOSYsmLQlvUKld4h5qGjVhCzxNe+zqhsXNuPZ8uH
	 +qD8Jf2WOHrAUCvDGpWEOeyqmNlJ25c3VuByO1eWFRLb9jb2UN5PcMzNoIjUIY6H0x
	 f6LHoq6VhflfC7lrsev/elkV4ztJJWDQQ67pzSzJ5CIgfadKb7hrOi8oYYoP5QXOxk
	 NbVp84HgM9nkaR4KRIDF4QUmFV34wItn9kMzr+J0qvmsoqrVJb6ookFiDYtnGkp9xW
	 nLSYd9u7RlWidNdFoFMhwCCCYMaQClfkRfQM0JfWRDT+v1zRsCL8kh4yx/9YTkPVku
	 n1AWUj7yU6IKA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C8A2060692;
	Sat,  8 Aug 2026 17:35:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DC781218
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 17:35:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C2799405CF
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 17:35:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ek3hN9eLBsx1 for <u-boot@lists.u-boot-project.org>;
 Sat,  8 Aug 2026 17:35:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 8A642405BF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8A642405BF
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8A642405BF
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 17:35:41 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6a1995ac437so897483a12.0
 for <u-boot@lists.u-boot-project.org>; Sat, 08 Aug 2026 10:35:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786210539; cv=none;
 d=google.com; s=arc-20260327;
 b=b2s/8OeAquE/bGOOkR6q2Tx7XtDjiqQkE6Kyym0yOYVKAUeRX6fR28OjqaOCydXX7l
 o6cP9SLzzQUXKpkP0LJ33Czl/ZpEI7n0mbHD2Z1ebYKZRstQmexjDQKCCqfCXRFHsfq/
 kp9G0sJrVgkPwbrhpFdh18gwQkqQoukWYv5BQTGtXCFZhjQ864eJDZg9cHQ+lF/JOCj/
 skJGV2jEOS2AOcevD0G2ygmwKC2K3JiIPylNUm2J3qLo1B/9aBhNhuAr0hl0qEWIkiTB
 Uby4AR2mA2/pjK35yqe/V4lNJUlo5syhGymaVqudz/zIDK3hz+aKH1KhqWVa1fWt6u3O
 8Eig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=PO+mc7BZdnsev4h5E3be+QuyIw2r/ZTqBTPl+bARC74=;
 fh=i8gjXuO8tzU7aloeRtN9Z2Ja50e3WtHPODgP9rh6VyU=;
 b=WlBqLv36YfzMxHXddKyBcVi65Rvat8kdNJ2xxsorSQht7Y1mK0Bx5CNh5v7lmZMFSB
 rrU9JwJ6c17QbdoEefLMjFW47ROgFzxOru9m/0U1aCMxUinq+BqE217m8rfpeAZHDdZB
 ycioanAloNDXQVOMKljEOjiIjlwb3cCc98zdY2ZHC7zC8aAUhHMm5S58H/SMX3pzZG/E
 HVJZIdk29uqC1GaGOqUxWP0hL/OxtYf3XNjzsNBEu9aiJ0t06ZF7faBhEPRHEUQVmiCS
 J1yGntumvArr62KtkxNVcoHZEMAtP3MocnhhkqL9Flhm2SkhIsvzpym34i40V2LsUNz1
 Coog==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786210539; x=1786815339;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=PO+mc7BZdnsev4h5E3be+QuyIw2r/ZTqBTPl+bARC74=;
 b=XnBwJv4IjiMevU4gCRuGJ1qM+Ogg5gheiXy1NhJ7yElT9SoH7ZFBSiJ+QDUP+QUiMp
 ckM4EnZwaxqRD7vJ2UbJG7HlM5f1O0dwJ44IBpZzEywLzKSPwVQqcMR0Z7a0GdrCNxde
 EwkCg/G/iUn98b21dAHIKZGE10hWso8usf5bWLuQy5W55TsmqabxR74S/q4wnI90OLSp
 lQMcp1NUWqERVUjfn2WthNewoAGfd/vwkCOkBG2vYasBGGiveamDdEOFaXSTugA29bkI
 0V1dXeSLXneVrKJuJpIHS4YbabDrV5/o7gnsGe5UHZgiT9FrRslSS7HQRTggVMnoq5F3
 7RWA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqYZhwq5OkEl7aSyUmjmEc1NUGNQrtZo/vIKDAlJqsrtt1OA715/kNaDVnyhpVAKDuOQgCcq8A=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yz1cTOETtlRAxp0+EV0xmLUOf4wzGvYCHKhigXpbYijrT34yPfb
 0YbEQPDVk6RZ+v4a1zB347HZeDl3OMrKt3IWY6F1ml5DcU8jUGbZewOBtOQrN/LNmYteaW34xjY
 WJf4eu0jXtZn47ZNCX1W7IYGSdPuGQ2ryIIC8//Hf
X-Gm-Gg: AR+sD10gPA8hKiVPUaTZhPINZMq1PoH3WFLvCwqivd5rN57v+UeEy3bcM6k4mr7InzK
 GK27GQMvqiZ+yYUFkXA7tTgzZqRQbdEpA/ZIWAUU33nIVoNyqaQB0YWk626dr9D/PzFFHIz+uUv
 +uc0Yr5mzjC1XW+hCsPbmSf+/PAEAtEldVzzvRLZ5E35cVl0VL9jPS6ic752RBgqw0GrCfc9Olt
 DsPXDRj5HG7OVfc8w+6yRGvB8j6UoDIVJEI5ZjYPHCAphcpECXvJPjN1VP6wKpCeB1smUaecngC
 IsICy0PVT3TcpHAFwOXGqNoCelGn+goKs9tSYAOSNrI=
X-Received: by 2002:aa7:c4cc:0:b0:6a0:50d8:142d with SMTP id
 4fb4d7f45d1cf-6a1f48418e3mr2282448a12.0.1786210539437; Sat, 08 Aug 2026
 10:35:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260803190946.2259514-1-jonas@kwiboo.se>
 <20260803190946.2259514-3-jonas@kwiboo.se>
In-Reply-To: <20260803190946.2259514-3-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 8 Aug 2026 11:35:27 -0600
X-Gm-Features: AUfX_my2wzzJHSrmBP7XnUE3B2sBTl5lm8LEROGCMkvKsvJoZC_aI1JXQlajTjw
Message-ID: <CAFLszTidbJMj-zHgu4WfidNRY-vJR6=L4vnjLjgpo0MSgF90ew@mail.gmail.com>
Subject: Re: [PATCH 2/6] rockchip: rk3506: Update ENV_MEM_LAYOUT_SETTINGS
To: jonas@kwiboo.se
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786210539; x=1786815339;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PO+mc7BZdnsev4h5E3be+QuyIw2r/ZTqBTPl+bARC74=;
 b=A+bkvFDSdUoKPfRtJjC32SHMnnI+TI1TvcfzNU7vX4LqD5IeazEqn+hT0006uhZN23
 9Xm030LikDpaboaPN7aTp0S8Bmw5ZsO2CylC1DzpSEjdcvGvwsWXv+RwiF5+ZVPPjpHj
 dURizka4FLybQ84cqI1+WLEA3uECtcfdI2HMI=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=A+bkvFDS
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

On 2026-08-03T19:09:38, Jonas Karlman <jonas@kwiboo.se> wrote:
> rockchip: rk3506: Update ENV_MEM_LAYOUT_SETTINGS
>
> The RK3506G1 has 64 MiB integrated DDR2, the RK3506G2 has 128 MiB
> integrated DDR3 and the RK3506B support external memory up to 1 GiB.

> Change the default load addresses to also work on SoC variants with
> limited memory, keep all default addresses in the 0-64 MiB range.

The addresses fit in 0-64 MiB, but kernel_comp_addr_r (48 MiB) +
kernel_comp_size (32 MiB) reaches 80 MiB, past the end of DDR on the
RK3506G1. Does this need separate values for each SoC ?

>
> Current memory layout cause issues using compressed kernels or ramdisk
> due to the default load addresses being used.
>
> Change the default load addresses to also work on SoC variants with
> limited memory, keep all default addresses in the 0-64 MiB range.
>
>                          old             new
>   scriptaddr            5 MiB           2 MiB
>   pxefile_addr_r        6 MiB           1 MiB
>   kernel_addr_r         32.5 MiB        8 MiB
>   kernel_comp_addr_r    128 MiB         48 MiB
>   fdt_addr_r            30.5 MiB        4 MiB
>   fdtoverlay_addr_r     31.5 MiB        6 MiB
>   ramdisk_addr_r        96 MiB          48 MiB
>
> [...]
>
> include/configs/rk3506_common.h | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

> diff --git a/include/configs/rk3506_common.h b/include/configs/rk3506_common.h
> @@ -18,15 +18,15 @@
> -     "kernel_comp_addr_r=0x08000000\0"       \
> -     "ramdisk_addr_r=0x06000000\0"           \
> +     "kernel_comp_addr_r=0x03000000\0"       \
> +     "ramdisk_addr_r=0x03000000\0"           \
>       "kernel_comp_size=0x2000000\0"

kernel_comp_addr_r and ramdisk_addr_r are both at 0x03000000, so
decompression will scribble over an already-loaded ramdisk. Every
other rockchip *_common.h keeps these apart. Please can you space them
so the kernel_comp window (0x03000000 + kernel_comp_size = 0x05000000)
does not overlap the ramdisk?

Regards,
Simon
