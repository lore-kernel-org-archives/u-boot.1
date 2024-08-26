Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F2FBC5472E
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 19:06:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28AC6884C3;
	Mon, 26 Aug 2024 21:06:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="X5KiG1DT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34D568842C; Mon, 26 Aug 2024 21:06:34 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9012088AE2
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 21:06:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a83597ce5beso720501666b.1
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 12:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1724699190; x=1725303990; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HAaJEY31GHYG7OVz5ZzNLRxgIbBJcNA44aOzXEFhLGM=;
 b=X5KiG1DTJrPrfpGSuqYMbuKRv9hQ8hEhdOgIstq4hCHg1OcGtdX4l0obs20Tx9OKFf
 wY8HaKg+E1PX7XraVZIaIFCwuo2ElE6wt8kYt8xfbgJpsoCAlqjtl1oJO6znGABv8ieL
 rZNwhGePQeRvoFDfiYrkv5ON1Ji8Mn4QoUvj2MUfv0kBHGgtChIqrEY/c3YnhsdiQ6t0
 tNbjope9nEz7wKGUOQ4ZOrXJ5lFUfAgNUgrR2NATPCy1bjAKxw60B4/Z4hnsUjcFhuLG
 o6ZlcnjQBJdQjkZ9OhLgR+nT5CQUjWACuaISg3bBrPJP4/bedoBw67qRed6IMVSBZDSk
 Fkqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724699190; x=1725303990;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HAaJEY31GHYG7OVz5ZzNLRxgIbBJcNA44aOzXEFhLGM=;
 b=Hbm25ZwRJ4AHcOqwwVuH8hqIQiUSQXGbWZVLNlqbSFTY/wrlnP4Z4Lj7KknCW7ABkc
 gmFmXJJv3InymN7Z3tLdvD9fn2FWcglzMPvdfj4Fn4Ge2A4a3bH6XvVnNvy1pxTx5x4Z
 6wQVoOkLMhMA87rTbgLyIjsTZ73rPGwqHndhfyvtBja7/clL4KyQWxs24t+Ho8ec9s0t
 2uUbZXiCQYuu20/AV/8sdNJLTURLbHQ0mP2GiAlEiH3OyNHLPUpgYb1oikG8QkFXT79q
 +sY8zfdXx4PdTRrPEc0mmAqTf3rdtqkkNOdbfHFFKwE6O+sQJd8I4kg1750m7AYTedti
 yzAQ==
X-Gm-Message-State: AOJu0Yzy0jTAZ9doXyn3nO2WLQedkl77rh8gEYilMcIM6RDch3Uej0NG
 YcY3ObZr6uia2Y/UGUFt8q5a2MlrVuZf+Uu5L2hdmPlGjEYCDp/YxSWCvs2vaQfKYHpY7Vrgb6T
 OmDSsqzd2I1vZZsx6yUNMksNN95fyaBAJAfPYO2PmGCzVsfpIUh8=
X-Google-Smtp-Source: AGHT+IFDBpZxrhKbcu/oKNZIV/0QWSZxOqshDNnKyxpuuHPtUdRidq6Ip+gnmkE8xzQ+ZrMVY5bKRE4xK2vgFBwFC9Q=
X-Received: by 2002:a17:907:60d1:b0:a77:d9b5:ad4b with SMTP id
 a640c23a62f3a-a86e2901bcamr67180666b.9.1724699189393; Mon, 26 Aug 2024
 12:06:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240816032217.267689-1-festevam@gmail.com>
In-Reply-To: <20240816032217.267689-1-festevam@gmail.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Mon, 26 Aug 2024 12:06:17 -0700
Message-ID: <CAJ+vNU32x+MieDJj3urBs7q_Rc+u+4zMinGGOLDY43rnih04FA@mail.gmail.com>
Subject: Re: [PATCH] gw_ventana: Remove unneeded comments
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>
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

On Thu, Aug 15, 2024 at 8:22=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> From: Fabio Estevam <festevam@denx.de>
>
> Remove several comments that do not apply anymore to
> the current file content.
>
> While at it, write 'PMIC' into a single line for consistency.
>
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---
>  include/configs/gw_ventana.h | 31 +------------------------------
>  1 file changed, 1 insertion(+), 30 deletions(-)
>
> diff --git a/include/configs/gw_ventana.h b/include/configs/gw_ventana.h
> index ebc5d03d0d5..3e720a6e0af 100644
> --- a/include/configs/gw_ventana.h
> +++ b/include/configs/gw_ventana.h
> @@ -6,55 +6,26 @@
>  #ifndef __CONFIG_H
>  #define __CONFIG_H
>
> -/* SPL */
> -/* Location in NAND to read U-Boot from */
> -
> -/* Falcon Mode */
> -
> -/* Falcon Mode - MMC support: args@1MB kernel@2MB */
> -
>  #include "mx6_common.h"
>
>  /* Serial */
>  #define CFG_MXC_UART_BASE             UART2_BASE
>
> -/* NAND */
> -
>  /* MMC Configs */
>  #define CFG_SYS_FSL_ESDHC_ADDR      0
>
> -/*
> - * PCI express
> - */
> -
> -/*
> - * PMIC
> - */
> +/* PMIC */
>  #define CFG_POWER_PFUZE100_I2C_ADDR    0x08
>  #define CFG_POWER_LTC3676_I2C_ADDR  0x3c
>
> -/* Various command support */
> -
>  /* USB Configs */
>  #define CFG_MXC_USB_PORTSC     (PORT_PTS_UTMI | PORT_PTS_PTW)
>  #define CFG_MXC_USB_FLAGS      0
>
> -/* Miscellaneous configurable options */
> -
> -/* Memory configuration */
> -
>  /* Physical Memory Map */
>  #define PHYS_SDRAM                     MMDC0_ARB_BASE_ADDR
>  #define CFG_SYS_SDRAM_BASE          PHYS_SDRAM
>  #define CFG_SYS_INIT_RAM_ADDR       IRAM_BASE_ADDR
>  #define CFG_SYS_INIT_RAM_SIZE       IRAM_SIZE
>
> -/*
> - * MTD Command for mtdparts
> - */
> -
> -/* Persistent Environment Config */
> -
> -/* Environment */
> -
>  #endif                        /* __CONFIG_H */
> --
> 2.34.1
>

Hi Fabio,

Acked-by: Tim Harvey <tharvey@gateworks.com>

Looks like there isn't much left to be moved to Kconfig. I'm not sure
if your interested or have the time (I know I currently don't) but the
USB defines can be cleaned up pretty easily:
- '#define CFG_MXC_USB_PORTSC     (PORT_PTS_UTMI | PORT_PTS_PTW)' can
be removed from mx6/mx7/mx8m includes as its defaulted in
drivers/usb/host/ehci-mx6.c
- CFG_MXC_USB_FLAGS is only used for drivers/usb/host/ehci-mx5.c so
can be removed for all mx6/mx7/mx8m and the mx51evk.h is the only
place its not set to 0

best regards,

Tim
