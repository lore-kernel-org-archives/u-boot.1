Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA1DC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 09:24:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1DDF88B36;
	Wed,  1 May 2024 11:24:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Uofp0l8M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8D3D88B37; Wed,  1 May 2024 11:24:06 +0200 (CEST)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD5DB88B27
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 11:24:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-602801ea164so4484752a12.0
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 02:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714555442; x=1715160242; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=giudb46qYXb2aJtZR3vud3JoQVvYTqvW6WQIyda7Rls=;
 b=Uofp0l8MOKRzdJXAoAHbp+mb/03oi8KtkA3gwwBghfx9ge6+H/+/uF7B6rNNEgmzHm
 eOji9ALS0FdQleO0lp3rTmbgxR3q5k0zpUe9uo5jPNf7tIak5JoTt/Gra+Q9pvHtBmN4
 uxpz3D4FPc706KAcFv4O2pTQflb/kV3wusuZLGJWni6C68tGt9NRy19sRfbbZYo/JOlV
 yRngEec8BNAQRvpn1a2Qr1+EpYL3NaMavPDKL6oBxTBNpVTUemhomvyRBaGuLMiq7gsp
 l1ZPKZfLx0AJ688f2CKJ17olqBTXq3/TJdtqEl+cuJxBmaikaaDcyd6NUo4M5lE5ykhG
 lwVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714555442; x=1715160242;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=giudb46qYXb2aJtZR3vud3JoQVvYTqvW6WQIyda7Rls=;
 b=GcthopejCtEmFRO41bf7bQIT+XhOY+OIfkju83BCb+UWwcmguyTH9BGib/9hrjX4Nm
 7DIp5H79ZmF85ZIToV9ErHyEhZPoWNXHuoyZTrif/aXZCPX1vXJI230B3QIcO9FLKWzN
 EgVLU3KhmgiDvkx69beN/i5dBhPMtDuOkZJ+50THbTaIrboQdHgQxYMgD7BOKxTA/9HR
 u/Sl8/OFtvng3W1o5zq3Yi7kKZiakDcSKR3CrGuY63hqP3gEe/M05zgu0S0CClGUc7RI
 EqJsvXbAuThXS0Vax3nTOp/7+wIz6GMxvXkScu9BGVgAoGD+DOSE/9wCyPCW2WFeP/8c
 h0Kw==
X-Gm-Message-State: AOJu0YzZj5T9chGdPNk/29O+DouSS5o6R9M/VXQRe9tl2XlB/LymjkEP
 9SpNX2hWFdOW0jF1WfeG1o6Xna83kjzOlZnXq4hP0b3tWEL/ohJiNMAiM7vT7pbsqL1vzG5kLdS
 syADNZOgZrRJ2ZUJ1daVaXaGQRrJVJw==
X-Google-Smtp-Source: AGHT+IFvjZTbhM6NeoGowYpWy0F49xlp1bHnwOCfvv1LwTKr91IpzudZcLIJy4BAjxdi+jvHUWaPaQ3cYFBsqZ2X0qA=
X-Received: by 2002:a05:6a21:99a6:b0:1af:4e66:5eb6 with SMTP id
 ve38-20020a056a2199a600b001af4e665eb6mr2628223pzb.22.1714555442172; Wed, 01
 May 2024 02:24:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240501024316.1767971-1-trini@konsulko.com>
 <20240501024316.1767971-86-trini@konsulko.com>
In-Reply-To: <20240501024316.1767971-86-trini@konsulko.com>
From: Adam Ford <aford173@gmail.com>
Date: Wed, 1 May 2024 04:23:50 -0500
Message-ID: <CAHCN7xLPjSUz-PAEpCAHoEFdhX6DCFM=H8p4XmhhES+tKBoXOw@mail.gmail.com>
Subject: Re: [PATCH 086/149] board: logicpd: Remove <common.h> and add needed
 includes
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

On Tue, Apr 30, 2024 at 9:44=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> Remove <common.h> from this board vendor directory and when needed
> add missing include files directly.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>

Acked-by:  Adam Ford <aford173@gmail.com>

> ---
> Cc: Adam Ford <aford173@gmail.com>
> ---
>  board/logicpd/am3517evm/am3517evm.c | 1 -
>  board/logicpd/imx6/imx6logic.c      | 1 -
>  board/logicpd/omap3som/omap3logic.c | 2 +-
>  3 files changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/board/logicpd/am3517evm/am3517evm.c b/board/logicpd/am3517ev=
m/am3517evm.c
> index e69a73f2af6f..e6ca31016b7c 100644
> --- a/board/logicpd/am3517evm/am3517evm.c
> +++ b/board/logicpd/am3517evm/am3517evm.c
> @@ -10,7 +10,6 @@
>   * Texas Instruments Incorporated - https://www.ti.com/
>   */
>
> -#include <common.h>
>  #include <dm.h>
>  #include <init.h>
>  #include <net.h>
> diff --git a/board/logicpd/imx6/imx6logic.c b/board/logicpd/imx6/imx6logi=
c.c
> index 0d53548dcb4b..589136fd64aa 100644
> --- a/board/logicpd/imx6/imx6logic.c
> +++ b/board/logicpd/imx6/imx6logic.c
> @@ -8,7 +8,6 @@
>   * and updates by Jagan Teki <jagan@amarulasolutions.com>
>   */
>
> -#include <common.h>
>  #include <env.h>
>  #include <init.h>
>  #include <miiphy.h>
> diff --git a/board/logicpd/omap3som/omap3logic.c b/board/logicpd/omap3som=
/omap3logic.c
> index 86992829caf4..a9fe61918b6a 100644
> --- a/board/logicpd/omap3som/omap3logic.c
> +++ b/board/logicpd/omap3som/omap3logic.c
> @@ -10,7 +10,7 @@
>   *     Richard Woodruff <r-woodruff2@ti.com>
>   *     Syed Mohammed Khasim <khasim@ti.com>
>   */
> -#include <common.h>
> +#include <config.h>
>  #include <dm.h>
>  #include <init.h>
>  #include <net.h>
> --
> 2.34.1
>
