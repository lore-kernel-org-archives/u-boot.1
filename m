Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 425EAC44520
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 18:05:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EF866406BE;
	Mon, 20 Jul 2026 18:05:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1Oe6XiSirbQR; Mon, 20 Jul 2026 18:05:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CDE1640620
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784570755;
	bh=oEh/J+sBGeHfqXgsWy5/H2rZvgni7gFRyeUP54cFCAY=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=DIbMwGS+tgppFVcV7BaLmaWIJlf2SSSqTn8430Xz8rUYjRB8l5i1CCoMMAzNhGq53
	 CQXzuArqkeVhCsVaXTR/fa4EjvivnrrK/DDrF+XGIP7zEHX4/E7CWFs8y4K7WA6a9e
	 LO07IsnLYEbcfvWF2utjMS6LtvtwmTw3U4ug5Z100YZVA5r2hdi0UCJuLlmhXpeJiA
	 LnRaaaTSLmnNPsoR9axIP4OwLho7zaORoOzaJThH1J5O6OJZSJzmKQ+qhLSFBEvxUN
	 qPgX7U7/0+HvLeC05E3lBnSYSRn0AQRgZCVo8MYeSw7rmtuTHy9ejJ3obadq187MC3
	 Bqx93xdcEvyqA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CDE1640620;
	Mon, 20 Jul 2026 18:05:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 72D342E5
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:05:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 64D366060E
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:05:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HrNl0zxTpK03 for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 18:05:53 +0000 (UTC)
Received-SPF: Neutral (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 2F3DE606D6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2F3DE606D6
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2F3DE606D6
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:05:53 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88A3D80433; Mon, 20 Jul 2026 20:05:51 +0200 (CEST)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A4F280433
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 20:05:49 +0200 (CEST)
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2cc7e86e7aeso76934365ad.2
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 11:05:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784570747; cv=none;
 d=google.com; s=arc-20260327;
 b=aKGSHlecGP6QjCS3LiSeZU8jDL6FY0z0pePLG0y5EsrhAPhvF8fnGamPx7ueRVVW0u
 O+NTy2moPEvZ4hef3ZLxNKReOLWJ6PKPRe6p2YvUjOiMSxvXVvvgcCfwkDxTsSm2TsgR
 9nRrKcOT1fJQ1Sg0IjMLqERrJuiYSB7rph4QNJlsOU7yfVpai2t3CfSN8ONVowSKOaNc
 ZxJqfxXiNA0arOquSUhGGKrz8Y6PW9vaIgiQQGkup7sWIKyv+KOrHptTG8Y1C9RkSVDt
 qP/0FzeFF0OSnb8bJwQIQQlJl4q6RwvmApk3sKuoP3oALQzFrdLfbQOT/fmjiw2xgjru
 gJ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=oEh/J+sBGeHfqXgsWy5/H2rZvgni7gFRyeUP54cFCAY=;
 fh=S5IsS0p2q/mDhy6CofKU3XdI4SX18ALJnocWEeQR4Xw=;
 b=e1br/Aus0ZWLcGycbhUM0n4K7hFtgsIEKjEFoP6GwNQmLyXsZGpxN9d56p3TVJNne3
 X+mwfEOjnLcuT77AbQg3cl5LWfQZMSghI/Sh9Zo6Q00rHw6dgsg4DExfQ1To5XPpuoed
 CRn+/DjPjK7XFaWbc7ReggXIWMjRYaqNBrcjSV/NAhx3oAGgavsWkLBE+Xkh3yuM4fER
 ykqOy86lozjLk+DNlSbw7wzDf5ZgBz0lUDtL2UHqyE6jTKAnz4s3h3JG+7cuTJ5bW10M
 Uj71f2aULuDW372TYjl6uVyAmCJgHcEwLcB6TXgiVLMVguMDyFgusHju7iQMPEZoD0Ek
 jFow==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784570747; x=1785175547;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=oEh/J+sBGeHfqXgsWy5/H2rZvgni7gFRyeUP54cFCAY=;
 b=DdRQwGj/3q6u4zLD5eZOBv4u/YN6JZgzrIa4RHWzlKYs+iGbzPQSImA0oXwDvO+EZz
 ZckLyl7yi/4rHUddQrg+CFTrhZlruO4uUcMJG0CCgQt5a0kVdEmN7BeJHaij/ykkc6Ld
 lGToRktwQyuPeEn/tAFeA2FMnAxKef8MiQDYmShegmDbFVJizMDcAtaa81/QLohpRSuC
 3mfJ4DmHQPemurkGNaWIdoQFoCbzi3ZLgkQrZVcuPQOKo6w96z6BNAVSfqY961z0LXwJ
 mRmZRHxhY72BovYkXgtcts1snNDx8QSQLSlyDQMuWi/tYaZPsXgM2D88V0pb+gj62TSk
 8Oyw==
X-Gm-Message-State: AOJu0YzS3cw8ZAVucrWqJZrq43QIBNOhZqYzVS/pRgQlMl78Va8reVDU
 FPHqM4Z25LRjfWg3d9y0o+WgxInafYarMhHWmO5GoY3lp9kc/lEgqqsSiC+q6jC8T7kzzJczj5k
 cNbeD9EodU3WCYEjtUh2EPiFpLXdFzSxz73/N17Iw
X-Gm-Gg: AR+sD10TuntyMWAjaQ6yAMI2Vajkj30lHwF9X30Nph3QGy4JMrcX6jCYk7fVG+/olmp
 Bz28PnpNKo7XpTJctwjc6ZW6Ob2Zh3+mf/I4whifmfat6FbSxhYDLWiePsDS5upL7vpPSe/sDw+
 N60+4dkPxRYXUFmFRdfPoecyxkgsB1IBFsu/fdXXQzZwHvShUzmP4dfVeI/3IGxXrIvaItkoZ48
 IiiLvz175nXp/slrpW8iQo00lrYphvQUDmYzR0QYfhTRpE7gOOrLE2vaq/n
X-Received: by 2002:a17:903:a8f:b0:2ce:a600:6022 with SMTP id
 d9443c01a7336-2cf34850c21mr166073245ad.7.1784570747542; Mon, 20 Jul 2026
 11:05:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260713-rk3576-boost-v1-0-9d23aa08f674@flipper.net>
 <20260713-rk3576-boost-v1-7-9d23aa08f674@flipper.net>
In-Reply-To: <20260713-rk3576-boost-v1-7-9d23aa08f674@flipper.net>
Date: Mon, 20 Jul 2026 12:05:20 -0600
X-Gm-Features: AUfX_mzEFvXI6rtuwE132WjFjNvvWHZmfzfM_HyZAk8ygEgIP7QVQbcG0mz3kRk
Message-ID: <CAFLszTjBfASHbKd2xivHghrACR6TR1ESyyPw9nLbox5fGnR71g@mail.gmail.com>
Subject: Re: [PATCH 7/7] rockchip: mkimage: Add rk3576 align and sd-card
 workaround
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
 d=chromium.org; s=google; t=1784570747; x=1785175547; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oEh/J+sBGeHfqXgsWy5/H2rZvgni7gFRyeUP54cFCAY=;
 b=mMQUZ/Vq7Aei5rLG2FBzSC5yYSuycdXquz+R78wKpj125JiLnBr1XABwseMWOvT2zh
 Iq21MhsGCrdOBdKc2+jbXsB3wx3DV9d2doIFwQWtAuJZ1vqLaeS0Oo1lDbsbg86z9+lb
 iFCKP44HMo/KpMoiH3BC8l88fF1cp38fdupWw=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=mMQUZ/Vq
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=sjg@chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="mMQUZ/Vq";
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

Hi Alexey,

On 2026-07-13T10:02:41, Alexey Charkov <alchark@flipper.net> wrote:
> rockchip: mkimage: Add rk3576 align and sd-card workaround
>
> The BootROM on RK3576 has an issue loading boot images from an SD-card.
> This issue can be worked around by injecting an initial boot image
> before TPL that:
>
>   writel(0x3ffff800, 0x3ff803b0)
>
> Prepend an image containing binary code that does this and return to
> BootROM to load next image, TPL.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> [switch from pre-built binary to from-source build via existing Makefiles,
> add commentary on what the magic write does based on JTAG debugging of
> the boot process]
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
> arch/arm/mach-rockchip/rk3576/Makefile       | 10 +++++++++
>  arch/arm/mach-rockchip/rk3576/rk3576-boost.c | 31 ++++++++++++++++++++++++++++
>  tools/rkcommon.c                             | 22 +++++++++++++++++++-
>  3 files changed, 62 insertions(+), 1 deletion(-)

> diff --git a/arch/arm/mach-rockchip/rk3576/Makefile b/arch/arm/mach-rockchip/rk3576/Makefile
> @@ -7,3 +7,13 @@
> +quiet_cmd_rk3576boost = BOOST   $@
> +      cmd_rk3576boost = $(CC) -nostdlib -ffreestanding -Os -c -o $@.o $< && \
> +                     $(OBJCOPY) -O binary -j .text $@.o $@

Since the object is never linked, any relocations end up unapplied in
the output binary. Toolchains defaulting to -fstack-protector-strong or
PIE can emit references to __stack_chk_guard or GOT loads, which
objcopy silently bakes in as broken code. Please can you add
-fno-stack-protector and -fno-pic (or reuse the kbuild flags)?

Also, nothing guarantees that _start() is at offset 0 of .text if a
second function is ever added to this file - a comment on that
constraint would help. The intermediate $@.o file also needs adding to
clean-files.

> diff --git a/arch/arm/mach-rockchip/rk3576/rk3576-boost.c b/arch/arm/mach-rockchip/rk3576/rk3576-boost.c
> @@ -0,0 +1,31 @@
> +     uint32_t *sram = (void *)(SYS_SRAM_BASE + OFFSET);

This is effectively an MMIO-style poke into live ROM state, so please
make it a volatile pointer (writel() semantics) rather than relying on
the optimiser keeping a plain store.

> diff --git a/tools/rkcommon.c b/tools/rkcommon.c
> @@ -288,6 +288,26 @@ int rkcommon_check_params(struct image_tool_params *params)
> +     if (!strcmp(params->imagename, "rk3576")) {
> +             char *boost = "arch/arm/mach-rockchip/rk3576/rk3576-boost.bin";

As mentioned on the cover letter, mkimage is shipped standalone (e.g.
as u-boot-tools) and is documented for creating idbloader.img by hand,
so with this change any rk3576 image can only be created from a U-Boot
build tree containing this file. Passing the boost binary in as a
normal datafile from the build system would keep the tool independent
of the source layout. Also, just to check: this path is shared by rksd
and rkspi, so the workaround is prepended to SPI images as well - is
that intended, given the issue is SD-card specific?

If binman is used to create the image, it could pass mkimage a
parameter pointing to the file.

> diff --git a/tools/rkcommon.c b/tools/rkcommon.c
> @@ -288,6 +288,26 @@ int rkcommon_check_params(struct image_tool_params *params)
> +             for (i = ARRAY_SIZE(spl_params.images) - 1; i > 0; i--)
> +                     spl_params.images[i] = spl_params.images[i - 1];

Patch 5 allows four input files; if all four slots are used, this shift
silently drops the last image. Please can you error out when images[3]
is already set?

Regards,
Simon
