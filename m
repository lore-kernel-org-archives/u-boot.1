Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53248C3DA47
	for <u-boot@archiver.kernel.org>; Tue,  9 Jul 2024 14:24:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 811E8885BF;
	Tue,  9 Jul 2024 16:24:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="R4q7Ar9h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EF7D885CF; Tue,  9 Jul 2024 16:24:11 +0200 (CEST)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AD2E87F5C
 for <u-boot@lists.denx.de>; Tue,  9 Jul 2024 16:24:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-70b09c2ade6so2646631b3a.3
 for <u-boot@lists.denx.de>; Tue, 09 Jul 2024 07:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720535046; x=1721139846; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=e8787tgafSPbYsuKZB7bj454dTP9hQdcO59NYafAS0Y=;
 b=R4q7Ar9h6hqFqDuD8tGrWUjJ5Fiz4K2cG6/LYAoDF8BgscyGl0ze3kxs4aMq2UftJ4
 27L8Xpu7IPZeBk4OuuiVziBj8R/KNfrZI4MSjicqbBuZ0Tkye5iC9kv85nus+/qn7Tz1
 OMStlY6ZxWljq3CN4KjPX1u/Cza4rmQQI4xee9uVq2uv7ibnHOW4O4uKiTKYMRQ3xHW1
 hSsfL+5W18CSI+KAUKmY5xZaCs9ihdhHGsqvvLA7T5whPOnPaM0dIuHbfkb2zhw9DBvr
 iX58Rcx99lZXqR8TS8W50eQrss+xdDG36yvGNOXNl+JH0ZpFNjhA7xDXTx7eLkXHbXXK
 ey3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720535046; x=1721139846;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e8787tgafSPbYsuKZB7bj454dTP9hQdcO59NYafAS0Y=;
 b=D834f0K8xyZyM6bEoX/vLQwwBPtvfoRiF63aXjiKA8YPICjsZQuLQEbsTXtCbUXm24
 lqOPTtLSFwK+cKbEDa+6UECN0BhM9nHmgKEBLthNI/D+Sr5nyFyNzuO4xXZcyqjMdDGp
 e4Eys0OdXo9FSJAXVnXPTOcj19qBXOJ/J1kvLRnkRqpa5Ej02I1LLdA3P5salgDbMGw4
 G2eScr4ZZR9HyOG1BqlEF+DCGmvbs2YYSuctp6hi/Kat8Lyw9s7eBlrFLGs9xigbh4Al
 dnlB9i4cD5+HYKaKbi9QvnT00sZ9hqanSpFde5/hs0Xhfuidl8x1TEXbM/Y2l60oIf6e
 /zSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8FMrGE+n5S9RnVbsyN+rUgOeypot4srBtKdSJMP5gD4faUciDkAKs5//+9mBEkOPfDuO0wrG5Zug0p3StYZ9Ih+E25g==
X-Gm-Message-State: AOJu0Yzz/ebbXY+404hdh+ic2zFZmQZvYR/BY6yCrLQYyTx94jSHOujV
 JuqwTFaNDNdW3qsXSRcRYhTZuAwurjZ+168y8ZM5BPIhrTrh8Vd2HV4xhf08EVx8B1yUXv+v8Br
 pU7yTcpMVupULcpgf4EDZQXQYoRBEsoDoW1QqSg==
X-Google-Smtp-Source: AGHT+IGUGNK4LEY0qIQHNkhkU1rRyLctRkSC0bY0rWukit4NdYzBpSLRMNAepWA3y/w2ZrR9pOaH1bLbue1gdRrS0d4=
X-Received: by 2002:a05:6a00:4650:b0:706:6248:93e with SMTP id
 d2e1a72fcca58-70b43522345mr3384425b3a.1.1720535046417; Tue, 09 Jul 2024
 07:24:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240709132516.2427654-1-yeoreum.yun@arm.com>
In-Reply-To: <20240709132516.2427654-1-yeoreum.yun@arm.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Tue, 9 Jul 2024 10:23:54 -0400
Message-ID: <CAEfUkUKQGN3NBomwAkyP2fD6e6MoCrsiav3cS39gVxM43JHrXg@mail.gmail.com>
Subject: Re: [PATCH] bloblist: Fix bloblist convention checking.
To: Levi Yun <yeoreum.yun@arm.com>
Cc: trini@konsulko.com, sjg@chromium.org, ilias.apalodimas@linaro.org, 
 n-jain1@ti.com, bmeng.cn@gmail.com, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Levi,

On Tue, 9 Jul 2024 at 09:25, Levi Yun <yeoreum.yun@arm.com> wrote:

> According to recently firmware handsoff spec [1]'s
> "Register usage at handoff boundary",
> Transfer List's signature value was changed from 0x40_b10b
> (3 bytes) to 4a0f_b10b (4 bytes).
>
> As updating of TL's signature, register value of x1/r1 should be:
>
> In aarch32's r1 value should be
>     R1[23:0]: TL signature (4a0f_b10b->masked range value: 0f_b10b)
>     R1[31:24]: version of the register convention ==  1
>
> and
>
> In aarch64's x1 value should be
>     X1[31:0]: TL signature (4a0f_b10b)
>     X1[39:32]: version of the register convention ==  1
>     X1[63:40]: MBZ
> (See the [2] and [3]).
>
> Also, according to architecture, the convention is slight different:
>
> In aarch32:
>     R0: MBZ
>     R1: see above
>     R2: Compatibility location for passing a platform description
> devicetree
>     R3: tl_base_pa
>
> In aarch64:
>     X0: Compatibility location for passing a platform description
> devicetree
>     X1: see above
>     X2: MBZ
>     X3: tl_base_pa
>
> This patch fix problems:
>    1. breaking X1 value with updated specification in aarch64
>         - change of length of signature field.
>
>    2. previous error value set in R1 in arm32.
>         - length of signature should be 24, but it uses 32bit signature.
>
>    3. according to architecture, check register convetion differently.
>
> [1] https://github.com/FirmwareHandoff/firmware_handoff
> [2] https://github.com/FirmwareHandoff/firmware_handoff/issues/32
> [3]
> https://github.com/FirmwareHandoff/firmware_handoff/commit/5aa7aa1d3a1db75213e458d392b751f0707de027
>
> Signed-off-by: Levi Yun <yeoreum.yun@arm.com>
> ---
>  arch/arm/lib/xferlist.c |  8 +++++---
>  common/bloblist.c       | 11 ++++++++++-
>  include/bloblist.h      |  5 ++++-
>  3 files changed, 19 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/lib/xferlist.c b/arch/arm/lib/xferlist.c
> index f9c5d88bd4..a6349293bd 100644
> --- a/arch/arm/lib/xferlist.c
> +++ b/arch/arm/lib/xferlist.c
> @@ -12,12 +12,14 @@ int xferlist_from_boot_arg(ulong addr, ulong size)
>  {
>         int ret;
>
> -       ret = bloblist_check(saved_args[3], size);
> +       if (IS_ENABLED(CONFIG_64BIT))
> +               ret = bloblist_check_reg_conv(saved_args[0],
> saved_args[2], saved_args[1]);
> +       else
> +               ret = bloblist_check_reg_conv(saved_args[2],
> saved_args[0], saved_args[1]);
>

The handoff of armv7 will break if you swap arg[0] and arg[2] here.
The args are already aligned in the correct order via the assembly code.
Please see the 'save_boot_params' function in start.S of armv7.

Regards,
Raymond
