Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00BADC43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 10:27:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A49A384A4B;
	Thu,  2 Jul 2026 12:27:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kcQceMfH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BEDA84A4C; Thu,  2 Jul 2026 12:27:36 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 205FB84A47
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 12:27:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-698aa7ba320so898903a12.1
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 03:27:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782988053; cv=none;
 d=google.com; s=arc-20260327;
 b=dXF1PIUa8utBKh0b9FnH48iSpwZOjmYTFkJOkZvqMEWGUnRhrjZK/v+iBA8jtgrZAn
 w3acCvKxKpZlfpcqilo3y5L2KR6C0GW0cgsdxW4YsIegMZR6/vbbCWtlC0yT2S48IvaD
 j5g2YHj/82fMhkNP1ypolkrfbdC0AULObGm2O2nDVZGFIUa0ZXuCaWZg9utwZh7sRxjV
 YwNmG0LaDdhs3SGTETvD7Tr2M7HKWhuw8pYUnxaRf/m0O8dVd7BFiCnsAxvz9N20Dk7M
 wHs0RFvsklWm2CTWPHgYT7syUfmtwBkZRRBhSUdA+Da9H3lxQadyroZu2ghFraN5PuBF
 sY+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1vkRGsqaDF3KxwH6oLEWu7WtU7swUJLuHf/eZ2QApbs=;
 fh=TXcWTNrRiLA3aF6p1Vh3HkcUBugLvZyWomkARLt6aQQ=;
 b=MWYT0YCII/PzKdUUQ7vXSkW3/H5qAX8q9IzlF2C3478D96bssQ8OaLNY1hy0Bcs/50
 lf6ORgvd9tLxTmIkkQZY60NJp6sfNuJZs0KnSPRRnCt5+PzmJBF9x3CkRAMUBG07rFpb
 9aA8Pz5ioKdmBnGz/UWJe314jloreuQmXcr/k8RoSQKIu9zrdkACXq26KZQn9hYxi7ym
 ikaqqU/AJkBxmxWB1hMa0ak570hUAl78QI73LVUQuZK00sYJrpHbEkFnb7pCILwf12WJ
 AgZ6FFA2Xfc5AqdKbRaIiJRd6renjWlJB02VO9P9lCfJU2todANooxrERSqES9WHdTG4
 ivOQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782988053; x=1783592853; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1vkRGsqaDF3KxwH6oLEWu7WtU7swUJLuHf/eZ2QApbs=;
 b=kcQceMfHOVb86V51GzYEP8/btW/TT9M/KhWU2wdOtx4EOOAeC3qL0kMGO0JsjJIKeN
 CsmYgUjaDNKpZlMSE7B8DeGzcwunFMyNzygom2sUVXSyEGwLfH2eFJBsmropLk0ApabV
 kNzOsXu8HfHR8G+7e8QrHFjNp+naCIpQIHSrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782988053; x=1783592853;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1vkRGsqaDF3KxwH6oLEWu7WtU7swUJLuHf/eZ2QApbs=;
 b=OooAwrHg6p4tigJrzgF2vs8zQwV2tSWCaO9oHzmvLhrqh6ypZt8aKqZLPLLFobAXXS
 emjLaT9LIlWMJDfqPxFB1cOZ235a2CoJr470u7Vo7WMirNW03WDWZq6uwuusC3w9FGuv
 1R4YOcanbEStrZDXUanBCYtOVzC00IB/jvfxtMWkcEGNMAbh050W2JfLxUkOT+jrPXmW
 pbqHCnVSlTS680cFl/JiCDa6JO9HVQimUG/ARU1rrpCIguyuStTZIRb+/xt9HNjfKYZH
 rS6J3byjNQeoYWa/at6bTcIZqUK4H8giT28gj1eISr13af3Z+L4ARVjEd0KE7gpxP9Zv
 aPbQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrr+rFE845w+Q+1Qkbjswau5ZVceQ/a06nii5TiyLyLaT0HsklIkEkrWEkx1Sj+K43CC0lGpq0=@lists.denx.de
X-Gm-Message-State: AOJu0YwuIkpW2GxOkfF27F8f2wHvJwihHs2lcefTULMkI1C/cEKUoVV9
 RvRcj9FacBEQ/7jY7g7hGbDdl7WAgLfJxfR6NyAjXrJDDyFUSUr4z6L7Os5lyICJzLLR048e5gX
 gZhi7Iky4a2FDApcoJV89X9RR7dkJtjchbAs9+Ysm
X-Gm-Gg: AfdE7cnCuUwBQsb3lZ6kOtlMbdB9TXcrAZrqRNDjSAYv6L3SCzJ/04FGlQU3bkSkIjA
 Y8LgquP928Ytma2P42p87DQpvJSYg45gU0M+KLv5wFnYFdoM36UTg9dn01r+sYbOPoZPGFl1vvR
 YCjkAxYBRjlJdwb6Oclek4n3G9+/pOL/WBRSEN+NTCSuHlGD/7X1q6bt+q1TaSAKhINqnP/OyaL
 WOscW3mbcn94ilc5NPCB5STlHgpVXPt4nPtVHhRKZKloa1RPmzur0aBGOHaToJKYMYiDI7zcg==
X-Received: by 2002:a05:6402:1cc7:b0:697:eb97:a4ed with SMTP id
 4fb4d7f45d1cf-6989f115f13mr2406756a12.7.1782988053620; Thu, 02 Jul 2026
 03:27:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260701111808.870705-1-me@ziyao.cc>
 <20260701111808.870705-15-me@ziyao.cc>
In-Reply-To: <20260701111808.870705-15-me@ziyao.cc>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Jul 2026 11:27:21 +0100
X-Gm-Features: AVVi8CfPhZtSC6I9IYnaMOHJhHy9YBVkpAwdmEGU-HcwaUBS0Sc8cI6xWI58dIM
Message-ID: <CAFLszTg37_PF--k_jE0A6RecyAj1pEc+Kpj2TSOgjiGSX7vRnw@mail.gmail.com>
Subject: Re: [PATCH v2 14/16] board: emulation: Add qemu-loongarch
To: me@ziyao.cc
Cc: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

Hi Yao,

On 2026-07-01T11:17:53, Yao Zi <me@ziyao.cc> wrote:
> board: emulation: Add qemu-loongarch
>
> Yet another generic QEMU VIRT machine.
> QEMU placed FDT in memory before launching U-Boot, so we
> can just obtian FDT here.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Yao Zi <me@ziyao.cc>
>
> arch/loongarch/Kconfig                            |  5 ++
>  arch/loongarch/dts/qemu-loongarch64.dts           |  9 +++
>  board/emulation/qemu-loongarch/Kconfig            | 68 +++++++++++++++++++++++
>  board/emulation/qemu-loongarch/MAINTAINERS        |  7 +++
>  board/emulation/qemu-loongarch/Makefile           |  6 ++
>  board/emulation/qemu-loongarch/qemu-loongarch.c   | 67 ++++++++++++++++++++++
>  board/emulation/qemu-loongarch/qemu-loongarch.env |  6 ++
>  configs/qemu-loongarch64_defconfig                | 36 ++++++++++++
>  include/configs/qemu-loongarch.h                  | 13 +++++
>  9 files changed, 217 insertions(+)

> Yet another generic QEMU VIRT machine.
> QEMU placed FDT in memory before launching U-Boot, so we
> can just obtian FDT here.

Please flesh this out a bit more - how the board is booted,
memory-layout assumptions, the FDT source. Also 'obtian' -> 'obtain'
and use present tense ('QEMU places the FDT ...').

> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> @@ -7,9 +7,14 @@ config SYS_ARCH
>  choice
>       prompt "Target select"
>
> +config TARGET_QEMU_LOONGARCH_VIRT
> +     bool "Support QEMU Virt Board"
> +     select BOARD_LATE_INIT
> +
>  endchoice

Please move this symbol into board/emulation/qemu-loongarch/Kconfig
alongside the other options, so the arch Kconfig only lists the
choice. Also BOARD_LATE_INIT is duplicated as an 'imply' inside
BOARD_SPECIFIC_OPTIONS - pick one.

> diff --git a/board/emulation/qemu-loongarch/qemu-loongarch.c b/board/emulation/qemu-loongarch/qemu-loongarch.c
> @@ -0,0 +1,67 @@
> +phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
> +{
> +     /* Limit RAM used by U-Boot to the DDR low region */
> +     if (gd->ram_top > 0x10000000)
> +             return 0x10000000;
> +
> +     return gd->ram_top;
> +}

Please introduce a named constant for 0x10000000 (something like
SYS_LOWMEM_TOP), and explain in the comment why the low region
matters - TLB/direct-map restriction, or a QEMU quirk?

> diff --git a/board/emulation/qemu-loongarch/qemu-loongarch.c b/board/emulation/qemu-loongarch/qemu-loongarch.c
> @@ -0,0 +1,67 @@
> +int board_init(void)
> +{
> +     return 0;
> +}

If there is nothing to do, please drop in favour of the weak default.

> diff --git a/board/emulation/qemu-loongarch/qemu-loongarch.c b/board/emulation/qemu-loongarch/qemu-loongarch.c
> @@ -0,0 +1,67 @@
> +int board_fdt_blob_setup(void **fdtp)
> +{
> +     /* Stored the DTB address there during our init */
> +     *fdtp = (void *)(ulong)0x100000;
> +     return 0;
> +}

The comment is misleading - U-Boot does not store the DTB anywhere;
QEMU (LoongArchQemuPkg) places it at this address. Please rework
the comment, and use a named constant rather than 0x100000. It
would also be worth an fdt_check_header() before returning success,
so a mis-launch fails cleanly.

> diff --git a/board/emulation/qemu-loongarch/qemu-loongarch.env b/board/emulation/qemu-loongarch/qemu-loongarch.env
> @@ -0,0 +1,6 @@
> +
> +stdin=serial,usbkbd
> +stdout=serial,vidconsole
> +stderr=serial,vidconsole

Drop the leading blank line.

> diff --git a/include/configs/qemu-loongarch.h b/include/configs/qemu-loongarch.h
> @@ -0,0 +1,13 @@
> +/* Those values are chosen by LoongArchQemuPkg */
> +#define CFG_SYS_INIT_RAM_ADDR        0x10000
> +#define CFG_SYS_INIT_RAM_SIZE        0x10000

'These values', not 'Those'. Also, since both the DTB address
(0x100000) and the low-RAM cap (0x10000000) are baked into the C
file, please pull those into this header so the QEMU/edk2 ABI lives
in one place.

Regards,
Simon
