Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D30AC021B1
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 13:50:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A47D080C98;
	Thu, 20 Feb 2025 14:50:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fnxSlyz7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E64A680FB4; Thu, 20 Feb 2025 14:50:12 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D648380F5F
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 14:50:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ab771575040so371473566b.1
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 05:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740059410; x=1740664210; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P5qc1gbGawt/Z491ukgIKnUE6MiM/XKTHuT6fm/2vGY=;
 b=fnxSlyz79ANawrIeSFqkGwklXQ7raRgRSGBcrycHGYPbHGk/XmVVP3XE23oYXP0yVt
 5EvN4Z3OSKCNVc1DL6H4GWakmRNml5wePrS/IGAT77XKkVUh/zMLtUzyb5OfEUIv+DeO
 VaoIfIrG1dIVgqerEHvlMNk3Sj0IgOoIbmCPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740059410; x=1740664210;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P5qc1gbGawt/Z491ukgIKnUE6MiM/XKTHuT6fm/2vGY=;
 b=mZ5KO0yIbtjexKtb4Q1T48JOKR96h9YWip8snCJKkjFGcCRzftLJFiGRknPW3Q0PHQ
 b8b6+1r/OqcIkAe4AkDeCnneW1DwdKVXIC+Tgc+3oOf3su12lmq7H6WeF+HNQkCVJJoV
 wDAfqcUmabn/+sjdktrszAhrljNCqQtkOQFL/DGp69C7ue9UnEViAGI03vkzV2xTN2aX
 aEDbOknHKzouI8iDxn/AfbeBeDgStvOVKu2hCxseQEnxCero7Ci32MaUmL6MbOyhQJQ+
 JvOZ2KdQjj0dPEkZLPPkA8wB5vhWjrLtWlPfohTFi371vh5l8RfdGDFMVE3LPOz2R7OC
 Si9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqzmrb1TKtfkN1J2bTlNadObnByVmk38er992GItHQRe6p29jj2xmqpCylWGIpxj5YolgRVgI=@lists.denx.de
X-Gm-Message-State: AOJu0Yx/PyCuIsNveQ0VYXKW+W5bAFosmgOLBDFAml10vd/F5eBpIoN6
 YX2EnJSaSAIsPyrW9BlL3czdwChW10DG1fHWuCGxH1Bu4p8zBZlx4Bza/g2wuwUinpuuocl4xoL
 lCH0M7dlb4R6Wy53mJIAXYKe4Z0p6ielw1nlP
X-Gm-Gg: ASbGncs0dIqznEd1YtOStXZ3JgF++Bfk1ysPEHBxS4LqmIEC/zvCJpIBehD6b9bLPff
 rWIyZ+bAdgQAsv+ne+ns3msseM36Wp3AlGRezkPCzWnz7aTT0CDJduhgDt0cnKOZBu5dKAtOJXQ
 ==
X-Google-Smtp-Source: AGHT+IEVrU6uD4ztMwOOOVrdhMVBe3MXgPN5pLVx850r/1lyd9c+TtxL/Zcr/OSCdyPw34RTiJzD+c2noiXR8Yz+Mng=
X-Received: by 2002:a17:907:c38b:b0:ab6:504a:4c03 with SMTP id
 a640c23a62f3a-abbedeb43a3mr280091866b.24.1740059410196; Thu, 20 Feb 2025
 05:50:10 -0800 (PST)
MIME-Version: 1.0
References: <20250218-init-v1-1-a1c5bf9e8fb0@posteo.net>
In-Reply-To: <20250218-init-v1-1-a1c5bf9e8fb0@posteo.net>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 20 Feb 2025 06:49:58 -0700
X-Gm-Features: AWEUYZkwnBBbAiL7l73-BsEPENi8F5RaWdZfFAlVQkfbMGkqPAGsMpPz8dtYGkM
Message-ID: <CAFLszTgKD0YQaCYyeHFxqj55YRQzvo2_yqkcjnZ6uy3dG_rEGg@mail.gmail.com>
Subject: Re: [PATCH] common: board_r: Initialize interrupts before watchdog
To: j.ne@posteo.net
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi J,

On Tue, 18 Feb 2025 at 08:55, J. Neusch=C3=A4fer via B4 Relay
<devnull+j.ne.posteo.net@kernel.org> wrote:
>
> From: "J. Neusch=C3=A4fer" <j.ne@posteo.net>
>
> On some platforms, initializing the watchdog driver enables a timer
> interrupt. This of course requires the interrupt handlers to be
> properly initialized, otherwise U-Boot may crash or run the timer
> interrupt handler of a previous bootloader stage.
>
> To account for such systems, always initialize interrupts
> (arch_initr_trap) before the watchdog (initr_watchdog).
>
> This problem was observed on a PowerPC MPC83xx board.
>
> Signed-off-by: J. Neusch=C3=A4fer <j.ne@posteo.net>
> ---
> NOTE: This approach seems safe and fine to me, but an argument could be
>       made that this should be fixed in the platform-specific drivers
>       instead.  Please let me know what you think.
>
>
> Rough stack trace (not sure if it should be part of the commit message):
>
>   initr_watchdog                (drivers/watchdog/wdt-uclass.c)
>     device_probe(wdt@200)
>       device_probe(timer)
>         mpc8xxx_wdt_start       (drivers/watchdog/mpc8xxx_wdt.c)
>           set_msr(get_msr() | MSR_EE);
>
>   arch_initr_trap               (arch/powerpc/lib/traps.c)
>     trap_init                   (arch/powerpc/cpu/mpc83xx/start.S)
> ---
>  common/board_r.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/common/board_r.c b/common/board_r.c
> index 179259b00de81f7ba9802fc5288e7c2b6e6f381a..f711cd237ae76d80ca2413017=
bfe131656f44180 100644
> --- a/common/board_r.c
> +++ b/common/board_r.c
> @@ -652,11 +652,11 @@ static init_fnc_t init_sequence_r[] =3D {
>         serial_initialize,
>         initr_announce,
>         dm_announce,
> +       arch_initr_trap,
>  #if CONFIG_IS_ENABLED(WDT)
>         initr_watchdog,
>  #endif
>         INIT_FUNC_WATCHDOG_RESET
> -       arch_initr_trap,
>  #if defined(CONFIG_BOARD_EARLY_INIT_R)
>         board_early_init_r,
>  #endif
>
> ---
> base-commit: 064556910e61044f1295162ceaad600582b66cda
> change-id: 20250218-init-dab1fc72abd2
>
> Best regards,
> --
> J. Neusch=C3=A4fer <j.ne@posteo.net>
>
>

The driver model way of doing this would be that your UCLASS_WDT
driver calls uclass_first_device(UCLASS_IRQ) to make sure interrupts
are ready.

The arch_initr_trap thing should probably not be used in new code.
Also, we have interrupt_init() which sounds like it is similar?

Regards,
Simon
