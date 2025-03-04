Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B541C021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 09:46:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1A9F810ED;
	Tue,  4 Mar 2025 10:46:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nUrg8beY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99D8A81249; Tue,  4 Mar 2025 10:46:42 +0100 (CET)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 655F980BAA
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 10:46:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e60ad903382so3105333276.0
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 01:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741081599; x=1741686399; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ct4U+v6q89qoa7KRaz/OwnA1Pw5o5OR6DAt2q0T6yFo=;
 b=nUrg8beYChFkj2j8IE7/5ya8hJxwzig7kk6cayCyuoNRdp35OygKvw3ll3wjFGO+rj
 EqnWqdLk0FBzUhP7dyJVmYPsldx2qKStFNNpYgdZj+WiZFr0ludPVeIni5AoRZ/bBmsH
 wf4NKzuOBzuW6FUISxzopg8nR0kM6dApO+y/LivKP6efweLiXLB0/T66pVjuhBq4m4Qa
 OCT+GmtLQI+ma+JkvuGB3X0aLp/EP4clBTEONgjD9nXrTKzsrA/ev/8jL3K8Q1a6RjPe
 PS7NoZRpq5CZPQoabn/VvYNpiJ5mjb0gRuAGUeEe3x7Xed9UlubsLGjLqQx7CCCsNSzO
 tDIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741081599; x=1741686399;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ct4U+v6q89qoa7KRaz/OwnA1Pw5o5OR6DAt2q0T6yFo=;
 b=bbvEe+9g4+ixk7eUilGweT/GhkZywEMSWlwvs6G2ZDzYHaTchIyeBgC1gBliAh0FP+
 Xi4uEOmWwq2pKbSDV3vytNG/ceO0mqyxwMw1lYIEvYHUwN+4mwkRJ0eXkxCbpPQEH3Gj
 3OVxd3t/0qxJYlDN4qQJ3I20HBmJ5vlhXjMA1a0JeY1ldrW3aeme8kKOigPuXPQJyr4U
 zOS84frSbssarc3zV4BkIGArvaCWJUtT4y/duUN0sC3MkaK6sGA+CsFA+nGyJAQakg1y
 WqdZHH8GFVed72IHJRdTaLQxR+N7twWliku0ChjxxOQ2Z7Nv2uFyiFQdMefrrZpo/q5h
 A1Zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcT1iIPjehKC+fFtbGARtzp8u2tViyfGs4t5ST7aMgM0mCoPL53xAfZJuDacq/TbyVyn/Avzc=@lists.denx.de
X-Gm-Message-State: AOJu0YznZwMBQv+ZJ1+2HC1It1tjhHiWtJfviRRPGAPZgnWUpdd/MlYB
 K61PGEf/1mQd2gVKZ/Rtk+83cvEBymzS2bh9h2p63QQS00Miv/VW0IITRX/OSIti0B6J5ICQjZW
 iPACuCZ8crKbP3SxkCBaEZ/tAqcNgyTWkunVspQ==
X-Gm-Gg: ASbGncvbtsHBdah8tg1S9apCWwfMujyDQSN3+8yB0DVfX4v+Dhsw3VakqLkMEHU0peA
 JP4osuUhsJHMCMbzA4t199qZwt8PLOr4WbjxRmsK+7YgwcEeqXf2WFZ/p/MQyb0cgnMo6ygve4j
 loVhhjjjSgP+aAgO2PHMcd+sP7ThAr
X-Google-Smtp-Source: AGHT+IHHyX59jxEcGqtjj4hSPLgTXLYAbfTmfWIrJCQz9US5Kn74c4hpM6/PLRNgq7wuOCkO52uSfw6Ubq6zIq8NUB4=
X-Received: by 2002:a05:6902:1b01:b0:e60:aa66:8b30 with SMTP id
 3f1490d57ef6-e60b2f4381amr21610770276.31.1741081599208; Tue, 04 Mar 2025
 01:46:39 -0800 (PST)
MIME-Version: 1.0
References: <20250302150231.152179-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250302150231.152179-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 4 Mar 2025 09:46:03 +0000
X-Gm-Features: AQ5f1JoynyQzqmSe6xYETEbTY4uzT_soX-AU-jPYZwmi5fN1quW1p7AqI4vcyOk
Message-ID: <CAC_iWjLE8zsm+fXjL7PPY8+6GNQUwFxzezJLKC0XnhUeU3vFxA@mail.gmail.com>
Subject: Re: [PATCH] lib: correct description of CONFIG_SYS_FDT_PAD
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 =?UTF-8?Q?Pawe=C5=82_Kochanowski?= <pkochanowski@sii.pl>, 
 u-boot@lists.denx.de
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

On Sun, 2 Mar 2025 at 15:02, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> CONFIG_SYS_FDT_PAD defines the number of unused bytes added to a
> device-tree and not the total size.
>
> Fixes: 40ed7be4af52 ("Convert CONFIG_SYS_FDT_PAD to Kconfig")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/Kconfig | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 1a683dea670..a21b3378fa7 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -1008,14 +1008,14 @@ config OF_LIBFDT_OVERLAY
>           This enables the FDT library (libfdt) overlay support.
>
>  config SYS_FDT_PAD
> -       hex "Maximum size of the FDT memory area passeed to the OS"
> +       hex "Free space added to device-tree before booting"
>         depends on OF_LIBFDT
>         default 0x13000 if FMAN_ENET || QE || U_QE
>         default 0x3000
>         help
> -         During OS boot, we allocate a region of memory within the bootmap
> -         for the FDT. This is the size that we will expand the FDT that we
> -         are using will be extended to be, in bytes.
> +         The operating system may need a free area at the end of the device-
> +         tree for fix-ups. This setting defines by how many bytes U-Boot
> +         extends the device-tree before booting.
>
>  config SPL_OF_LIBFDT
>         bool "Enable the FDT library for SPL"
> --
> 2.48.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
