Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B47C27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 08:13:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 828EB86582;
	Thu, 24 Aug 2023 10:13:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20221208.gappssmtp.com header.i=@baylibre-com.20221208.gappssmtp.com header.b="DodQTf3M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80A7A8658A; Thu, 24 Aug 2023 10:13:47 +0200 (CEST)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D70EC8654F
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 10:13:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2ba1e9b1fa9so99803661fa.3
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 01:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1692864824; x=1693469624; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6OdOfENUfQCu4gBAFlryYbszTTPhU5bT6wJamelfgL8=;
 b=DodQTf3MJATNrixww3NXc0V4y3kF4XK5x45e5pvnuetr8s9PS/wWio1bn5vZZX3as+
 uxws7ChMleKa9OGCfTfAWAiDv03gfjg1Y98/qu2BejvQNW/G8WdSxnjoyU22EFnnwYNz
 W9RGxUAvxt2vVBYDxWcTUP9X3dcxScuH3mWmGTtbkbIi9J5PsoJkGkdlL9iSUBiP5zrJ
 bJKW/hze1X5XP6V4HujDLTciNGcvjEsSZ2b3uBNrIUbr3KqFRHq9jssfH2Xs/yRHdue2
 /uNRjlFD7qbFToLoqt+kG2BH+ikuG0L4htVCRO4lpbh8bxfi4FwmFOCD+MKAceT+Eevk
 wCVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692864824; x=1693469624;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6OdOfENUfQCu4gBAFlryYbszTTPhU5bT6wJamelfgL8=;
 b=LYzXul91fv0K8wnuyrP5ojsgA75tH+/NWPMNfm2UQzqM1iK42aaOtXOAZ5GrjWKh/N
 XuioNOSYkLBr/7aY4V0vpb5TtPft8YGRZFGza+XQk2EZIVAeyc8kn/JlABaOIlQLEl15
 tEDyEc3ffGfjUZpcjZlfqLkzQFa59UCWRnD0/HudRt+JTAaZ8skeHlI4KR4mHy3TbHMQ
 M+JtzYtNRL+BBkS1J4J/t8UQmcAj+604UBvCVGeYRNnqNKetnDf97uiYt1prTToBbcPY
 sJ2/vpeYlNpJrk9rd0rzMdU+k0Bg0GDqskof73VyuMZEMtRH1oC3z7AKXmjS++IgepKE
 QVpw==
X-Gm-Message-State: AOJu0YyiIxFUl71hyYlsPBP9K18hy4rGhQ3sABO52nLKr0h51nYXWVkN
 Zlu4m3ddlC2J6lwXBiLyiO+Xpw==
X-Google-Smtp-Source: AGHT+IHX6MyuxgBpd4A9xPFUO+ofO9+BWbTERVvlLyJ4bjgmu3rDAgw0A1rm3mB7Y9pn0r0zRo8SPQ==
X-Received: by 2002:a05:6512:1296:b0:4fe:993:2218 with SMTP id
 u22-20020a056512129600b004fe09932218mr13563177lfs.31.1692864823984; 
 Thu, 24 Aug 2023 01:13:43 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 s5-20020adff805000000b003143cb109d5sm21460549wrp.14.2023.08.24.01.13.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 01:13:43 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Neha Francis <n-francis@ti.com>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@google.com>
Cc: Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 u-boot@lists.denx.de, Jan Kiszka <jan.kiszka@siemens.com>, Nishanth Menon
 <nm@ti.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>
Subject: Re: [PATCH V5 02/17] include: configs: am62x_evm: Drop unused SDRAM
 address
In-Reply-To: <20230824031101.3460411-3-nm@ti.com>
References: <20230824031101.3460411-1-nm@ti.com>
 <20230824031101.3460411-3-nm@ti.com>
Date: Thu, 24 Aug 2023 10:13:42 +0200
Message-ID: <87il94rh6x.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hi Nishanth,

On mer., ao=C3=BBt 23, 2023 at 22:10, Nishanth Menon <nm@ti.com> wrote:

> Drop unused macro. This was meant for a second region of DDR which we
> do not need for AM62x evm configurations.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> New patch (part of bootstd transition)
>
>  include/configs/am62x_evm.h | 3 ---
>  1 file changed, 3 deletions(-)

What about include/configs/verdin-am62.h ?

It seems that that board, which is am62x based, also has the un-needed
include.

Since i'm not 100% sure, I have added Marcel (who posted the verdin am62
support) here.

>
> diff --git a/include/configs/am62x_evm.h b/include/configs/am62x_evm.h
> index 44180dc7687b..379e0c13a395 100644
> --- a/include/configs/am62x_evm.h
> +++ b/include/configs/am62x_evm.h
> @@ -12,9 +12,6 @@
>  #include <config_distro_bootcmd.h>
>  #include <env/ti/mmc.h>
>=20=20
> -/* DDR Configuration */
> -#define CFG_SYS_SDRAM_BASE1		0x880000000
> -
>  /* Now for the remaining common defines */
>  #include <configs/ti_armv7_common.h>
>=20=20
> --=20
> 2.40.0
