Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A833DCAC592
	for <u-boot@archiver.kernel.org>; Mon, 15 Sep 2025 21:34:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA26482C84;
	Mon, 15 Sep 2025 23:34:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JwZ2ctWO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D46D8344E; Mon, 15 Sep 2025 23:34:12 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36B2B81E13
 for <u-boot@lists.denx.de>; Mon, 15 Sep 2025 23:34:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-62f1987d547so2695875a12.2
 for <u-boot@lists.denx.de>; Mon, 15 Sep 2025 14:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757972050; x=1758576850; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v/BZptiUaF9QbdqsZt6bKhgHq2F5moAxS/2k3Rfcli8=;
 b=JwZ2ctWOreGF+9NDGub+/XiUmoI5P2z9Vjzjx3ZjVWpDZS76kb7kWcePO06ODTROzR
 +nljyKRC4qYglgnJLQEKCiZpZhL+rjts3yZNpQHE34vX5aYSZELEloSyCNudU5ZU14tK
 Cv+45Uh9EBHr7haOD5bAzSJUY3oiIYqq67rvTMRLh4sKUGD7aJvkp6o/lTLmYc7sHU/7
 SwaXsYUinSyy/6oqXzkqnhT3L+P8wQfUXvPfaxraSARsjD6dMTlvNWPB12qcw2pQlgOW
 lt55lt/IXvuKkbq05qMrP6IZD/CtisisuKqBI4Hb9SgnQN/mbbjQkCaMDuEFKu5/XnPt
 jj1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757972050; x=1758576850;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v/BZptiUaF9QbdqsZt6bKhgHq2F5moAxS/2k3Rfcli8=;
 b=TdlBnnNwZwgaeuvrG61lk+xCkBOToPPfv7n/s5skvWugVaEf9U+hYCLdLJGa/I2Ro/
 zoW1dElsutyP1lNgf1onuX7pRrF24BDfOBYlqrwayk8m4/NctOGGWD0fs2cL2RNzL1fP
 CJPIwxaGXKdphaJY1ouw4Vdf+v0xpAjvxziH9d/gZc6wIaXt2+fuN1iFB7eD7ADfDw2V
 IBkQgihWU2UyNOC5lu/cUXx1zEnx/ONjqDanag1Ue4CYUBYpm+Rdxdv3KMDPoLJr3fM1
 D4166WJ+IesOhUZEkfJZF2VoW9YxwFPkbGsjr1biWbXNcz2BRY3kzqG+R8vUCgb96Hq7
 bvSw==
X-Gm-Message-State: AOJu0Yxyvu/McE7VIxd2YOZP2lPrg4JzEBDezILDsaD8xmXOtAyUudyj
 1F7vDw1QDTHDl0p5PuQ0NI3EKiXUivxmRSneyF/cmBcnvfZvHgbWG1Lpbi2vvOnxu35QIuyMpGL
 cJIw2q6PtMXKrUYdQzq9EiXb0Kg0Siv4=
X-Gm-Gg: ASbGncub9zDz+v0aA8N9RmV7VGur+TAtlgBjGCnuDPJj17NRa/5MAYNeTul3jkenEUz
 Qg8tCSEry9wIBMG1rX/ktifNtiXV+9jNc9cAysVjvXum1uQRZDhdYrGYcPvmEe/m0sRw70znuAL
 6wfEs/qWWtOCAnNCt6tmYnw1/Aq0NqB2Xkqfcxen38UvLA8yQOEBq6PpbQPrQ4R83fBEzB8bdhf
 JvvfRwGbBmXshnmAiw=
X-Google-Smtp-Source: AGHT+IFwVgDQ5YMLoG+xa2MvRqDZSO9uV01ttDmBg6AFJql+kGXXVcucxDCkM0+mrdci/VlywT9srGwPkzkK2KCEjrI=
X-Received: by 2002:a05:6402:a0c2:b0:61c:e99d:fdef with SMTP id
 4fb4d7f45d1cf-62ed8241121mr12140477a12.2.1757972049387; Mon, 15 Sep 2025
 14:34:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250915210109.459864-1-trini@konsulko.com>
In-Reply-To: <20250915210109.459864-1-trini@konsulko.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Mon, 15 Sep 2025 14:33:56 -0700
X-Gm-Features: AS18NWAW6m8_3q7ZNflGVvNYaqK-UcoMEhUnOyeeTb9MZmsYjNxaPgDeZZ2wBSQ
Message-ID: <CAJaLiFx-127XfC5tQNBvPoHbtzKXN3DB4AGg-53VedshEt_xwg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update Luka Perkov's roles
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Luka Perkov <luka.perkov@sartura.hr>
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

On Mon, Sep 15, 2025 at 2:01=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> Per a private email, drop Luka Perkov from MAINTAINERS entries.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Thanks for all your work in the past!
>
> Cc: Luka Perkov <luka.perkov@sartura.hr>
> ---
>  MAINTAINERS                                | 1 -
>  board/Marvell/mvebu_armada-8k/MAINTAINERS  | 1 -
>  board/iomega/iconnect/MAINTAINERS          | 1 -
>  board/mikrotik/crs3xx-98dx3236/MAINTAINERS | 4 ----
>  board/zyxel/nsa310s/MAINTAINERS            | 1 -
>  5 files changed, 8 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3fb163aa1db1..1b41f57a58bc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -346,7 +346,6 @@ F:  drivers/spi/gxp_spi.c
>
>  ARM IPQ40XX
>  M:     Robert Marko <robert.marko@sartura.hr>
> -M:     Luka Perkov <luka.perkov@sartura.hr>
>  S:     Maintained
>  F:     arch/arm/mach-ipq40xx/
>  F:     include/dt-bindings/clock/qcom,gcc-ipq4019.h
> diff --git a/board/Marvell/mvebu_armada-8k/MAINTAINERS b/board/Marvell/mv=
ebu_armada-8k/MAINTAINERS
> index 55e485faa962..15660cd17d4f 100644
> --- a/board/Marvell/mvebu_armada-8k/MAINTAINERS
> +++ b/board/Marvell/mvebu_armada-8k/MAINTAINERS
> @@ -13,7 +13,6 @@ F:    configs/mvebu_mcbin-88f8040_defconfig
>
>  Puzzle-M801 BOARD
>  M:     Luka Kovacic <luka.kovacic@sartura.hr>
> -M:     Luka Perkov <luka.perkov@sartura.hr>
>  S:     Maintained
>  F:     configs/mvebu_puzzle-m801-88f8040_defconfig
>  F:     arch/arm/dts/armada-8040-puzzle-m801.dts
> diff --git a/board/iomega/iconnect/MAINTAINERS b/board/iomega/iconnect/MA=
INTAINERS
> index a1b018e8169f..d9093b28ef08 100644
> --- a/board/iomega/iconnect/MAINTAINERS
> +++ b/board/iomega/iconnect/MAINTAINERS
> @@ -1,6 +1,5 @@
>  ICONNECT BOARD
>  M:      Tony Dinh <mibodhi@gmail.com>
> -M:     Luka Perkov <luka@openwrt.org>
>  S:     Maintained
>  F:     board/iomega/iconnect/
>  F:     include/configs/iconnect.h
> diff --git a/board/mikrotik/crs3xx-98dx3236/MAINTAINERS b/board/mikrotik/=
crs3xx-98dx3236/MAINTAINERS
> index 906ff98970bd..04423556924a 100644
> --- a/board/mikrotik/crs3xx-98dx3236/MAINTAINERS
> +++ b/board/mikrotik/crs3xx-98dx3236/MAINTAINERS
> @@ -1,13 +1,11 @@
>  CRS3XX-98DX3236 BOARD
>  M:     Luka Kovacic <luka.kovacic@sartura.hr>
> -M:     Luka Perkov <luka.perkov@sartura.hr>
>  S:     Maintained
>  F:     board/mikrotik/crs3xx-98dx3236/
>  F:     include/configs/crs3xx-98dx3236.h
>
>  CRS305-1G-4S BOARD
>  M:     Luka Kovacic <luka.kovacic@sartura.hr>
> -M:     Luka Perkov <luka.perkov@sartura.hr>
>  S:     Maintained
>  F:     configs/crs305-1g-4s_defconfig
>  F:     configs/crs305-1g-4s-bit_defconfig
> @@ -16,7 +14,6 @@ F:    arch/arm/dts/armada-xp-crs305-1g-4s-bit.dts
>
>  CRS326-24G-2S BOARD
>  M:     Luka Kovacic <luka.kovacic@sartura.hr>
> -M:     Luka Perkov <luka.perkov@sartura.hr>
>  S:     Maintained
>  F:     configs/crs326-24g-2s_defconfig
>  F:     configs/crs326-24g-2s-bit_defconfig
> @@ -25,7 +22,6 @@ F:    arch/arm/dts/armada-xp-crs326-24g-2s-bit.dts
>
>  CRS328-4C-20S-4S BOARD
>  M:     Luka Kovacic <luka.kovacic@sartura.hr>
> -M:     Luka Perkov <luka.perkov@sartura.hr>
>  S:     Maintained
>  F:     configs/crs328-4c-20s-4s_defconfig
>  F:     configs/crs328-4c-20s-4s-bit_defconfig
> diff --git a/board/zyxel/nsa310s/MAINTAINERS b/board/zyxel/nsa310s/MAINTA=
INERS
> index 11106acf3e94..865c98f7724d 100644
> --- a/board/zyxel/nsa310s/MAINTAINERS
> +++ b/board/zyxel/nsa310s/MAINTAINERS
> @@ -1,6 +1,5 @@
>  NSA310S BOARD
>  M:     Tony Dinh <mibodhi@gmail.com>
> -M:     Luka Perkov <luka.perkov@sartura.hr>
>  S:     Maintained
>  F:     board/zyxel/nsa310s/
>  F:     include/configs/nsa310s.h
> --
> 2.43.0
>
For Iomega iconnect and ZyXEL NSA310S.
Reviewed-by: Tony Dinh <mibodhi@gmail.com>

All the best ,
Tony
