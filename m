Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8A9CC83F2D
	for <u-boot@archiver.kernel.org>; Sun,  3 Sep 2023 10:04:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2DC686411;
	Sun,  3 Sep 2023 12:04:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="s2JgSUVf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C0A08645D; Sun,  3 Sep 2023 12:04:27 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C6B78144A
 for <u-boot@lists.denx.de>; Sun,  3 Sep 2023 12:04:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=massimo.pegorer@gmail.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-59205f26e47so4565217b3.2
 for <u-boot@lists.denx.de>; Sun, 03 Sep 2023 03:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693735463; x=1694340263; darn=lists.denx.de;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KUaUF7VXaRONIuKRMXNN3DD5B/+p8ChZGXymCnzFFxU=;
 b=s2JgSUVfKIyHLyl3usgdkxg543ZF7S+Xp6ErLIdSwAeEO+pIzSDYPoamZDUt/wfxHy
 mGzVQLP7ZtZ+uI8JCwMtpfSTGdjsaBW2j5F13ieoNXiDN1Cm8rX3/bK4Q7THP0bHZ1W3
 xbZ2g6ybgZXIHszHcXljpbeRJCxJLBGdIETlILOOi+fY+huWsfIqd+yWyJ9xJLcj2Vn/
 1kCIhg546jPBRc371nJOvlPsUl0CwqCYf4p30KjDs61nzp33uElR76yo+Wje8FC9lzkk
 kOY8efFnOW/JGv+48vWwHy77BBdmKhR14o7vtFbRRrnVTA1s1EC3h17WKD9iH/yeC1tE
 PEGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693735463; x=1694340263;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KUaUF7VXaRONIuKRMXNN3DD5B/+p8ChZGXymCnzFFxU=;
 b=H7N52D0nya8yd9UJ7Ity4oZTuo0TzoyaXoxXSz1YGtoEaQYSxLUXPT9DRkjYYA3ZCA
 Zz3/WV18nbFRHiwS8+8h2YBpLPehqk4PVBSY0BxBCYoRQTMauWZK/8vW8Louik+Up5TR
 k8eWYVQWfHXOnq17HDd9kUKccCkQ3QZiRAzuCQWHO9m04o5u+WdmF7yQ+4vpSrDUeSAZ
 ZZYsxKDrGPyMm3MRIwpigCcoenYB1/B3pg8qB+Lysnp45R8IVOy/mMdpIU+iKdlF98fc
 ct5QpMZAiG7a/i2Q4+IhGyESAS2KP+eecCsdL7e6oAfUQs+RLPUscpGQczT/E1S++rV4
 H0dQ==
X-Gm-Message-State: AOJu0YzrLbxsDf3An5PFGlbW4Pvwv4nh23vwXtqYNHZYuiRoVABj4+yA
 RHooWGA06kajrvuG82t9j1EaUraCx4mDdwKZyAjQIoS031ex6w==
X-Google-Smtp-Source: AGHT+IGptiv1qocRDYoKQJlpQCepUmf1/EvoTbjlQa+X9DhuCq1glxmSK/FN6fbqefwNh+53tILLP4IpYgRr661OEew=
X-Received: by 2002:a81:91d2:0:b0:577:417b:8e90 with SMTP id
 i201-20020a8191d2000000b00577417b8e90mr7656313ywg.10.1693735463026; Sun, 03
 Sep 2023 03:04:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230902163159.343716-1-massimo.pegorer+oss@gmail.com>
In-Reply-To: <20230902163159.343716-1-massimo.pegorer+oss@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Sun, 3 Sep 2023 12:04:12 +0200
Message-ID: <CAC928HY_6fotX5DnQMR4=pAojOTjMFhSmOQLX3sD87UF+ruQJw@mail.gmail.com>
Subject: Re: [PATCH 1/2] rockchip: Use an external TPL binary on RK3308
To: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jagan Teki <jagan@edgeble.ai>,
 FUKAUMI Naoki <naoki@radxa.com>
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

Il giorno sab 2 set 2023 alle ore 18:32 Massimo Pegorer
<massimo.pegorer+oss@gmail.com> ha scritto:
>
> There is no support to initialize DRAM on RK3308 SoC using U-Boot
> TPL and therefore an external TPL binary must be used to generate
> a bootable u-boot-rockchip.bin image.
>
> Imply ROCKCHIP_EXTERNAL_TPL by default for RK3308 builds. Remove
> useless TPL_SERIAL.
>
> Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
> ---
>  arch/arm/mach-rockchip/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index a279582f4f..e8584de258 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -159,6 +159,7 @@ config ROCKCHIP_RK3308
>         select SPL_ATF
>         select SPL_ATF_NO_PLATFORM_PARAM
>         select SPL_LOAD_FIT
> +       imply ROCKCHIP_EXTERNAL_TPL
>         imply ROCKCHIP_COMMON_BOARD
>         imply SPL_ROCKCHIP_COMMON_BOARD
>         imply SPL_CLK
> @@ -166,7 +167,6 @@ config ROCKCHIP_RK3308
>         imply SPL_SYSCON
>         imply SPL_RAM
>         imply SPL_SERIAL
> -       imply TPL_SERIAL
>         imply SPL_SEPARATE_BSS
>         help
>           The Rockchip RK3308 is a ARM-based Soc which embedded with quad
> --
> 2.34.1
>

I've just noticed that Jonas followed a different approach for RK3568
and RK3588:

config ROCKCHIP_EXTERNAL_TPL
    bool "Use external TPL binary"
    default y if ROCKCHIP_RK3568 || ROCKCHIP_RK3588

Is any one preferred? I slightly prefer the one I've done, as it gives
a terse picture of what a SoC select/imply in a single place. Of
course I can change it in a V2, if Jonas way is preferred, and to have
a single congruent way to do things.

Thanks. Regards,
Massimo
