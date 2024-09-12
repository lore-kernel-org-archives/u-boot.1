Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7204EED606
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 13:32:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 208B688CA0;
	Thu, 12 Sep 2024 15:32:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LRqtW7M2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 008ED88FC7; Thu, 12 Sep 2024 15:32:02 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 027D588FBA
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 15:32:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42bb7298bdeso10938895e9.1
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 06:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726147919; x=1726752719;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=litmrcN2QxTkcvRnzQnAi2VsCxZW79+8uGdga0VRdhg=;
 b=LRqtW7M284+K0np3P7GtQPjOMjF77Ue2mShr+k/UzCewvrgOH0tsSOzB7qY1hyoDx8
 E6KjKuOA21410KKz4uwpv9Z0xkGX4HkrDiHJu10LSOEkhYSc7o+1e8k7yNWH+LKzFQZ0
 S7mJT7f8/EVVTG4jM/Pq8loE+WHKoAPv70v6UOJpu3Djbq1fPLbM6UEeAKlYZ3hjjo2D
 24XOQVWvcLQeMx23v7mg3jGXvzkTqKrnSOgjaXi4H5F13++UgloCVF4N/q9LjvrTbePS
 yGtL8UDYqYeKmPfxGQPGNS6XpaY8ZBVbZfzT2Snv8y1plELMNgFBvmqIUA08Rwr6qDqm
 81xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726147919; x=1726752719;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=litmrcN2QxTkcvRnzQnAi2VsCxZW79+8uGdga0VRdhg=;
 b=tIyUAwsHYu2XlpV/NyHpymY7NBqv+JIVNSqEbtQ2kn/0G7yrtbuNADDLWL+hx/YvSV
 2DZtDw99ft73sOocRJRafZIJJztEAyaMH+h4xjhCR/nsFsqFXs0NUptxbq5ctlNfPqYD
 DcoyLWLo8FQVtn79H5SNrt3Vut1dp0saV1/b/4imE6E2q+/NnMF7KYop8EmPc6v8xqY0
 KrdPMMSjrz2GAs+Ud/oxIR/t0fiOX5r5Di489e67A+nGLY+dkcdjXWb2MHSkYMFGLozB
 xa2+Adl52bDdXJKJqchtd5P0M5zf2YL2umPR3CckXJ2UdI2x0UYKewOmImOf/p7amdMc
 ZO/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRITHAbeDnDUsPt0hWi1NWo2KxWjtaJNI7nxtT2agKKuFWnSbCiifblhjrdlhmj+T9b9u4fzs=@lists.denx.de
X-Gm-Message-State: AOJu0Yz1tvfLVWU0DtdtEAXcrOPlBLlDxJ5WnSj4VlwT7Dzn9AtoS5KG
 eHENxbWUpyDJC1KAJplhNf+VbT6DUGdZb9cELWw141dsnbzxYi9KIQkXKn0mTgQ=
X-Google-Smtp-Source: AGHT+IFGTEXmtCaqBe6d882qV3w+Wv9pN27Bbj4Lxw11c9Z5UGmB+5VhnnkYnBremDBuWpV4sPLvkw==
X-Received: by 2002:a05:600c:1c04:b0:42c:bbd5:727b with SMTP id
 5b1f17b1804b1-42cdb56ef5emr31202165e9.25.1726147918722; 
 Thu, 12 Sep 2024 06:31:58 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42cb6db7ddbsm138849725e9.34.2024.09.12.06.31.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2024 06:31:56 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, Tom Rini <trini@konsulko.com>, Lukasz
 Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>, Sean Anderson
 <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, Andre Przywara
 <andre.przywara@arm.com>, Samuel Holland <samuel@sholland.org>, Lukas
 Funke <lukas.funke@weidmueller.com>, Jonas Karlman <jonas@kwiboo.se>,
 Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v2] spl: ram: hide SPL_RAM_SUPPORT
In-Reply-To: <20240910130019.3211647-1-jerome.forissier@linaro.org>
References: <20240910130019.3211647-1-jerome.forissier@linaro.org>
Date: Thu, 12 Sep 2024 15:31:55 +0200
Message-ID: <871q1pkng4.fsf@baylibre.com>
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

Hi Jerome,

Thank you for the patch.

On mar., sept. 10, 2024 at 15:00, Jerome Forissier <jerome.forissier@linaro=
.org> wrote:

> Make SPL_RAM_SUPPORT a hidden Kconfig symbol, automatically selected
> by SPL_RAM_DEVICE or SPL_DFU. Avoids the situation where SPL_RAM_SUPPORT
> may be enabled without the other two being enabled, which results in the
> following build warning:
>
> common/spl/spl_ram.c:19:14: warning: =E2=80=98spl_ram_load_read=E2=80=99 =
defined but not used [-Wunused-function]
>    19 | static ulong spl_ram_load_read(struct spl_load_info *load, ulong =
sector,
>       |              ^~~~~~~~~~~~~~~~~
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  common/spl/Kconfig         | 8 ++------
>  drivers/usb/gadget/Kconfig | 2 +-
>  2 files changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index c08ff064493..885a012461c 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -1238,15 +1238,11 @@ config SPL_POWER_DOMAIN
>  	  the drivers in drivers/power/domain as part of a SPL build.
>=20=20
>  config SPL_RAM_SUPPORT
> -	bool "Support booting from RAM"
> -	default y if MICROBLAZE || ARCH_SOCFPGA || ARCH_TEGRA || ARCH_ZYNQ
> -	help
> -	  Enable booting of an image in RAM. The image can be preloaded or
> -	  it can be loaded by SPL directly into RAM (e.g. using USB).
> +	bool
>=20=20
>  config SPL_RAM_DEVICE
>  	bool "Support booting from preloaded image in RAM"
> -	depends on SPL_RAM_SUPPORT
> +	select SPL_RAM_SUPPORT
>  	default y if MICROBLAZE || ARCH_SOCFPGA || ARCH_TEGRA || ARCH_ZYNQ
>  	help
>  	  Enable booting of an image already loaded in RAM. The image has to
> diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
> index 4621a6fd5e6..b1247a9eeae 100644
> --- a/drivers/usb/gadget/Kconfig
> +++ b/drivers/usb/gadget/Kconfig
> @@ -323,7 +323,7 @@ config SPL_DFU
>  	bool "Support DFU (Device Firmware Upgrade) in SPL"
>  	select SPL_HASH
>  	select SPL_DFU_NO_RESET
> -	depends on SPL_RAM_SUPPORT
> +	select SPL_RAM_SUPPORT
>  	help
>  	  This feature enables the DFU (Device Firmware Upgrade) in SPL with
>  	  RAM memory device support. The ROM code will load and execute
> --=20
> 2.40.1
