Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF17D0EE30
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 19:54:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E80B893CC;
	Fri, 11 Oct 2024 21:54:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="TzIaN8RL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A62EE893D5; Fri, 11 Oct 2024 21:54:16 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 501A889026
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 21:54:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a9950d27234so342591566b.1
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 12:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1728676454; x=1729281254;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DkAA2y7QSbf8MhI8AXhVvqFi4hO28KuVILXvZkehdTk=;
 b=TzIaN8RLFrH1KCPcDTp8YhDyL5IzBhQWaPuheXxv5FHHH2koLh0oPiOGfDjBxyX3Le
 tCYlQpC/77rfpEUCBrXnba8EBsGcGZDGWdsyy1umPzhGHrK/k/oTr33fkTaPuZN2d6h3
 0xzlL5ljMmAQIZmHyGi+KBnbQHWfOPFZ/ZHS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728676454; x=1729281254;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DkAA2y7QSbf8MhI8AXhVvqFi4hO28KuVILXvZkehdTk=;
 b=YzqpSVHu2KAxelPLB2XqVp3hUMX+YvXle9yGo98Segw9FYnpAEZu+7z7D8s/mkT3Kr
 qiHqg6Kq4YYVHJ2sw0UBXz64a2C3MghipRrU4ieziSkk6ygiy4RPxvuMtw9zJ7RiiXdL
 X5jwvw8Eo5QP64ypIIdTND+Z/AbpDJ1XeKIBWgUoT962kwHBIdx411lSB9CluXfS+BNE
 vKXbLfaUpExZNB9q+TT+JuFh3jgb9LxN6D48ZVSx3XUWtVODAEoC7Vr9bktTh+lxlFrh
 m32Co0jLUtA5PsqTMY4L595dxPwJCoLVMobxLtqNMCipz5kHp4WwbtMuJwxoTwAAN8kO
 jU0g==
X-Gm-Message-State: AOJu0Yw9M0vSPDnMdlpNab30tWyrgKgRa/jtV8gDVKSPOpQ4BJIuvqSR
 FSXjbdaf4ccQGNKcnohU8IVCVVnrXeLs+JrEVrLwTxirTvtzP533opPmTUqSm5Q9IcLa5QuIgUc
 92XjsEE6JhBgaKW9J6Opy78z2gHMzNRxtSvIfxg==
X-Google-Smtp-Source: AGHT+IGp7sAm+blsLIYNGzZLoecTCQYWDPcFOdbuRkOrSGgZNYoTnL+3bbdWhrQ+RQ/j19xlGngdNYepG9pfIwzYiVw=
X-Received: by 2002:a17:907:3f03:b0:a99:c9a4:a4da with SMTP id
 a640c23a62f3a-a99c9a4b767mr198152466b.61.1728676453529; Fri, 11 Oct 2024
 12:54:13 -0700 (PDT)
MIME-Version: 1.0
References: <20241011-bcmbca-nand-support-v2-0-1fe928e5b933@linaro.org>
In-Reply-To: <20241011-bcmbca-nand-support-v2-0-1fe928e5b933@linaro.org>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Fri, 11 Oct 2024 21:54:01 +0200
Message-ID: <CAOf5uwm8p6WgzSBAB__V09zqcYnXO8YkFjdjEyTLHPOO-M+eGg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] mtd: rawnand: brcmnand: Add BCMBCA support
To: Linus Walleij <linus.walleij@linaro.org>
Cc: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Anand Gore <anand.gore@broadcom.com>,
 William Zhang <william.zhang@broadcom.com>, 
 Kursad Oney <kursad.oney@broadcom.com>,
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
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

Hi

On Fri, Oct 11, 2024 at 4:49=E2=80=AFPM Linus Walleij <linus.walleij@linaro=
.org> wrote:
>
> This adds support for the NAND controller on the Broadcom
> BCA (Broadband Access) platforms.
>
> This requires the series with brcmnand fixes that I sent
> separately to be merged first. See:
> https://patchwork.ozlabs.org/project/uboot/list/?series=3D424109
>
> The development was done on the Genexis XG6846B which is
> a derivative of the BCM96846 reference design, but probably
> has a different flash layout, be sure to check the last
> patch in the series for a comment on that.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Changes in v2:
> - Switch to using OF_UPSTREAM instead of syncing DTS files.
> - Mention the Linux version the BCMBCA NAND driver is based on.
> - Link to v1: https://lore.kernel.org/r/20240930-bcmbca-nand-support-v1-0=
-e637c65de947@linaro.org
>

Acked-by: Michael Trimarchi <michael@amarulasolutions.com>

I will queue in weekend

Michael

> ---
> Linus Walleij (4):
>       mtd: rawnand: brcmnand: Add BCMBCA RAW NAND driver
>       drivers: nand: bcmbca: Enable on BCM6846
>       board: bcm96846: Enable NAND options
>       board: bcm96846: Switch to using OF_UPSTREAM
>
>  arch/arm/dts/bcm6846.dtsi                   | 103 -------------------
>  arch/arm/dts/bcm96846.dts                   |  30 ------
>  arch/arm/mach-bcmbca/bcm6846/Kconfig        |   4 +
>  configs/bcm96846_defconfig                  |  15 ++-
>  drivers/mtd/nand/raw/Kconfig                |   7 ++
>  drivers/mtd/nand/raw/brcmnand/Makefile      |   1 +
>  drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c | 152 ++++++++++++++++++++++=
++++++
>  7 files changed, 178 insertions(+), 134 deletions(-)
> ---
> base-commit: a404065479be2c1fe1167c3c91367e8194a69d1b
> change-id: 20240930-bcmbca-nand-support-4447e176bbbd
>
> Best regards,
> --
> Linus Walleij <linus.walleij@linaro.org>
>


--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
