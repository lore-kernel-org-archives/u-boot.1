Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47372C25B4F
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 12:47:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A75F188725;
	Tue,  7 May 2024 14:46:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aQmd8xXd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46B4C8872F; Tue,  7 May 2024 14:46:56 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EE6288719
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 14:46:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-34f7d8bfaa0so820109f8f.0
 for <u-boot@lists.denx.de>; Tue, 07 May 2024 05:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715086013; x=1715690813;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=en8Sz9jg2Ntq+LvXCGwAJCYIwlinMXEVWoYR1iXKxn0=;
 b=aQmd8xXd9DdIGrOAoCfrMYW+zCBiX2htnGyBTnJtMdPw3xwSUdJZJLIxp/IRLE69Hl
 NTyXUUul11/FrCtlZ1g1g3r5o+qwZ19+h/rvQ+FsxgpGob8htZvdrWBbaSYl6P85BzuT
 TAnKXGsAfH7RN0E7rCl0sAyEDNyPayVAd0OqdTEELU5zF/183zrK/NrIF4lzB2Y73d+U
 xOkG47bX2rAHsvqqQZ7dy79v8B8JxRYPc5O50cAW2mh68a23pdpezrIRVtDAqv39t01H
 ghHJEBirpNmrXPZg2Qu0KFHKgw+RBg8CWfbm+XUvWsB7rqI7cLKXOnINH6XHLI3kLKol
 RT6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715086013; x=1715690813;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=en8Sz9jg2Ntq+LvXCGwAJCYIwlinMXEVWoYR1iXKxn0=;
 b=hQvJ+Cxs0yP4dibfjq+dMXljldKSq2CSWYH7+e7nQhiEuI5sa2VLf5zj+22aEb6qor
 T+tkqWmjpDGnpy8Tz8bfljrKAa+YB3923V5aos3ocXF53PcPy6dzHy6UmSZ32SI9YHmz
 ue2l2NcQreEjnwCLaeqiBYm0r3Rux7uMzwubNmILbtmSuXkWLoeLqDBvPbZUZ+UzNarC
 Q2wv+sR/puVM4oWIuM4WyJVKL/qRPuWYqHaqDxzSsBkGrHLBIl401D6Jt2/RMyALz5ra
 o4rvTQYaCXB0J5YhXB/B5LwU1rrMYQUI1xTgixXhUDxuQ1UuIgbH5t9UDaHLCV8dvzKY
 /MZA==
X-Gm-Message-State: AOJu0YyQasAKd7a6/uFJVb7LXQCafvXiw0Q1I6PrbY2d45JYZgn74Q+p
 +9CQMRxnmua35fJ8QH8p2RAmFZxY6pDQAXOTcwLfXlvy5W1MogsqaO7MI0G2rkM=
X-Google-Smtp-Source: AGHT+IGsawwNMl4ZlXlbCPWVDZ8H0ibDzfk62zZ0vRaR0typSZnmCDOhEyQeZ48w+hvyllaBaOuKgA==
X-Received: by 2002:a5d:6da3:0:b0:34f:4cc7:88f5 with SMTP id
 u3-20020a5d6da3000000b0034f4cc788f5mr3601787wrs.27.1715086013491; 
 Tue, 07 May 2024 05:46:53 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 cx14-20020a056000092e00b0034a2d0b9a4fsm12994065wrb.17.2024.05.07.05.46.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 05:46:52 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Benjamin Hahn <B.Hahn@phytec.de>, Teresa Remmet <t.remmet@phytec.de>,
 Yannic Moog <y.moog@phytec.de>, Tom Rini <trini@konsulko.com>, Wadim
 Egorov <w.egorov@phytec.de>, Martyn Welch <martyn.welch@collabora.com>,
 Parthiban Nallathambi <parthitce@gmail.com>, Fabio Estevam
 <festevam@gmail.com>
Cc: u-boot@lists.denx.de, upstream@lists.phytec.de, Benjamin Hahn
 <B.Hahn@phytec.de>
Subject: Re: [PATCH] configs: Make USB_GADGET_MANUFACTURER consistent over
 all PHYTEC boards
In-Reply-To: <20240503-wip-bhahn-bspimx8m-3196-v1-1-855c7242151f@phytec.de>
References: <20240503-wip-bhahn-bspimx8m-3196-v1-1-855c7242151f@phytec.de>
Date: Tue, 07 May 2024 14:46:51 +0200
Message-ID: <87ttj9vlfo.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Benjamin,

Thank you for the patch.

On ven., mai 03, 2024 at 09:00, Benjamin Hahn <B.Hahn@phytec.de> wrote:

> Set CONFIG_USB_GADGET_MANUFACTURER to PHYTEC for all PHYTEC boards.
>
> Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

This is assigned to me on patchwork. I can pick it up through
u-boot-dfu.

If someone else wants to pick it up, please let me know.

> ---
>  configs/phycore-imx8mp_defconfig     | 2 +-
>  configs/phycore_am64x_a53_defconfig  | 2 +-
>  configs/phycore_am64x_r5_defconfig   | 2 +-
>  configs/phycore_pcl063_defconfig     | 2 +-
>  configs/phycore_pcl063_ull_defconfig | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/configs/phycore-imx8mp_defconfig b/configs/phycore-imx8mp_defconfig
> index e9a287cb441f..9f42edd72324 100644
> --- a/configs/phycore-imx8mp_defconfig
> +++ b/configs/phycore-imx8mp_defconfig
> @@ -147,7 +147,7 @@ CONFIG_USB_DWC3=y
>  CONFIG_USB_DWC3_GENERIC=y
>  CONFIG_USB_STORAGE=y
>  CONFIG_USB_GADGET=y
> -CONFIG_USB_GADGET_MANUFACTURER="FSL"
> +CONFIG_USB_GADGET_MANUFACTURER="PHYTEC"
>  CONFIG_USB_GADGET_VENDOR_NUM=0x0525
>  CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
>  CONFIG_IMX_WATCHDOG=y
> diff --git a/configs/phycore_am64x_a53_defconfig b/configs/phycore_am64x_a53_defconfig
> index 1a9359773b45..9b52f8ad0644 100644
> --- a/configs/phycore_am64x_a53_defconfig
> +++ b/configs/phycore_am64x_a53_defconfig
> @@ -159,7 +159,7 @@ CONFIG_USB_CDNS3=y
>  CONFIG_USB_CDNS3_GADGET=y
>  CONFIG_USB_CDNS3_HOST=y
>  CONFIG_USB_GADGET=y
> -CONFIG_USB_GADGET_MANUFACTURER="Texas Instruments"
> +CONFIG_USB_GADGET_MANUFACTURER="PHYTEC"
>  CONFIG_USB_GADGET_VENDOR_NUM=0x0451
>  CONFIG_USB_GADGET_PRODUCT_NUM=0x6165
>  CONFIG_USB_GADGET_DOWNLOAD=y
> diff --git a/configs/phycore_am64x_r5_defconfig b/configs/phycore_am64x_r5_defconfig
> index 61d784fa17f6..15a7e7089e73 100644
> --- a/configs/phycore_am64x_r5_defconfig
> +++ b/configs/phycore_am64x_r5_defconfig
> @@ -171,7 +171,7 @@ CONFIG_USB_STORAGE=y
>  CONFIG_SPL_USB_STORAGE=y
>  CONFIG_USB_GADGET=y
>  CONFIG_SPL_USB_GADGET=y
> -CONFIG_USB_GADGET_MANUFACTURER="Texas Instruments"
> +CONFIG_USB_GADGET_MANUFACTURER="PHYTEC"
>  CONFIG_USB_GADGET_VENDOR_NUM=0x0451
>  CONFIG_USB_GADGET_PRODUCT_NUM=0x6165
>  CONFIG_USB_GADGET_DOWNLOAD=y
> diff --git a/configs/phycore_pcl063_defconfig b/configs/phycore_pcl063_defconfig
> index 017054a8e12b..2f6b158a6772 100644
> --- a/configs/phycore_pcl063_defconfig
> +++ b/configs/phycore_pcl063_defconfig
> @@ -62,7 +62,7 @@ CONFIG_IMX_THERMAL=y
>  CONFIG_USB=y
>  CONFIG_SPL_USB_HOST=y
>  CONFIG_USB_GADGET=y
> -CONFIG_USB_GADGET_MANUFACTURER="Phytec"
> +CONFIG_USB_GADGET_MANUFACTURER="PHYTEC"
>  CONFIG_USB_GADGET_VENDOR_NUM=0x1b67
>  CONFIG_USB_GADGET_PRODUCT_NUM=0x4fff
>  CONFIG_CI_UDC=y
> diff --git a/configs/phycore_pcl063_ull_defconfig b/configs/phycore_pcl063_ull_defconfig
> index b3da43a5bf1e..b42a410da69c 100644
> --- a/configs/phycore_pcl063_ull_defconfig
> +++ b/configs/phycore_pcl063_ull_defconfig
> @@ -53,7 +53,7 @@ CONFIG_IMX_THERMAL=y
>  CONFIG_USB=y
>  CONFIG_SPL_USB_HOST=y
>  CONFIG_USB_GADGET=y
> -CONFIG_USB_GADGET_MANUFACTURER="Phytec"
> +CONFIG_USB_GADGET_MANUFACTURER="PHYTEC"
>  CONFIG_USB_GADGET_VENDOR_NUM=0x1b67
>  CONFIG_USB_GADGET_PRODUCT_NUM=0x4fff
>  CONFIG_CI_UDC=y
>
> ---
> base-commit: 6fdb021f148f598a67eb3cac5e3eb4a569cdaacd
> change-id: 20240503-wip-bhahn-bspimx8m-3196-c1ebd0bab6ac
>
> Best regards,
> -- 
> Benjamin Hahn <B.Hahn@phytec.de>
