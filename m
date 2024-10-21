Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93FD0D17123
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 18:37:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C826388A3C;
	Mon, 21 Oct 2024 20:37:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cMt96VCi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEEF588E8A; Mon, 21 Oct 2024 20:37:35 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAD6388A3C
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 20:37:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5c40aea5c40so194694a12.0
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 11:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729535851; x=1730140651; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EuzpcWRaJYRSKofzownP23Z2oCi6lTTr6q09TCaUUP0=;
 b=cMt96VCi+8SDtcPlCxIpJrHNm61Mbkv8psdQEjdMJAOKsyQCAw2DRYs/1duEvNLeIA
 1CWBAx3HU/rVF9f5oqnOLR92YWpuHwY0uSj7XZUPWnUDSONpMR80BOfPZ+e0zRmMXbWl
 9AL+xs7nBFM9w6So3jENmou1QLIbFm6BVLuIesbiHpkcDTfkTy6Y6XS1mkF2PtI0/c3c
 WKJgkgtlk0PHXl/tmjak+56SdtTAyV1yabJy1M5+whjrJ4avDt5K5ZHJZnS8Cge5P47G
 z++URtttMY2xXwIGLOk18yqmNgOzbkwj7GGYEJb4Sr0/xBLcW16BbBIWaQsxsYNU83Xb
 47tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729535851; x=1730140651;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EuzpcWRaJYRSKofzownP23Z2oCi6lTTr6q09TCaUUP0=;
 b=aTxbmBHWn8nbpyNyQ37cHisNgk81fpJqx+UadNdqAYt8DpcOSZSlZ8ETnvTt2W5j7P
 muZAMSc9ExEBrVcttNotr45ilufOK1QSIDwPxQ48mMXJP2EGDPFrj1cbYr51auXlgwyY
 3JBEdHkBeaNRJyS4oJg/GJsldM/RcUSQCK+waIT+h5NhY2fLgM7uaBA+Fj+K7CbzyW57
 RLNx7k7PwF/wYiCwbFuEqMcn9hE9H8U96/RpZOimMOd7cM+SS0wIUYQ793nNvQNasVK6
 8DUcYP6Bq4+vgtKqPUuegMDts+Pn1rxDK2pemE5zg/SUDjNINsyNXx/01x2U9lyLsX8j
 plGw==
X-Gm-Message-State: AOJu0Yx5zalCmZWiLmsKjck8NErpmFkUt9BDFnIJOgZJOIyJunOhaMim
 Q5eMGCBqgv6HSqKrrTjfig8+WMvzHH2xC6NPiU98dOZ7UBaE941Rnl0YEvtv6chg76JjCyJnoXv
 w6Ea6Wx8eAwwgAOTYS3kln1DO614=
X-Google-Smtp-Source: AGHT+IGQmJJuEEVV6958VxBzFoIm07vpvmO0egurE/bWDe1UDhk2Syzq44J0X35z8MUQjWb8SyPRnLfRP+lCBrGycQU=
X-Received: by 2002:a05:6402:270c:b0:5c9:813a:b1c1 with SMTP id
 4fb4d7f45d1cf-5cb7944cd65mr663940a12.1.1729535850943; Mon, 21 Oct 2024
 11:37:30 -0700 (PDT)
MIME-Version: 1.0
References: <20241021113839.318572-1-sjg@chromium.org>
 <20241021113839.318572-5-sjg@chromium.org>
In-Reply-To: <20241021113839.318572-5-sjg@chromium.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 21 Oct 2024 19:37:19 +0100
Message-ID: <CALeDE9MNqjWFuw+08Wzx+KcpTDDjKQA-uJ_8LNj4KEL4UJwGfQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/25] mx23_olinuxino: pinephone: Enable LED
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marex@denx.de>, Samuel Holland <samuel@sholland.org>
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

Hi Simon,

> Drop the STATUS_LED options and enable LED and LED_BOOT instead, since
> this is the new way to access the LED functionality.

Should this be two commits? The subject reads as pinephone is part of
another device.

> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v2:
> - Add a patch to enable LED and LED_BOOT for these boards
>
>  configs/mx23_olinuxino_defconfig | 10 ++--------
>  configs/pinephone_defconfig      |  7 ++-----
>  2 files changed, 4 insertions(+), 13 deletions(-)
>
> diff --git a/configs/mx23_olinuxino_defconfig b/configs/mx23_olinuxino_defconfig
> index 3016f750e64..c1319077891 100644
> --- a/configs/mx23_olinuxino_defconfig
> +++ b/configs/mx23_olinuxino_defconfig
> @@ -39,14 +39,8 @@ CONFIG_USE_BOOTFILE=y
>  CONFIG_BOOTFILE="uImage"
>  CONFIG_VERSION_VARIABLE=y
>  CONFIG_MXS_GPIO=y
> -CONFIG_LED_STATUS=y
> -CONFIG_LED_STATUS_GPIO=y
> -CONFIG_LED_STATUS0=y
> -CONFIG_LED_STATUS_BIT=778
> -CONFIG_LED_STATUS_STATE=2
> -CONFIG_LED_STATUS_BOOT_ENABLE=y
> -CONFIG_LED_STATUS_BOOT=0
> -CONFIG_LED_STATUS_CMD=y
> +CONFIG_LED=y
> +CONFIG_LED_BOOT=y
>  CONFIG_MMC_MXS=y
>  CONFIG_CONS_INDEX=0
>  CONFIG_DM_SERIAL=y
> diff --git a/configs/pinephone_defconfig b/configs/pinephone_defconfig
> index 9d39204a439..272fce1c1a4 100644
> --- a/configs/pinephone_defconfig
> +++ b/configs/pinephone_defconfig
> @@ -11,8 +11,5 @@ CONFIG_MMC_SUNXI_SLOT_EXTRA=2
>  CONFIG_PINEPHONE_DT_SELECTION=y
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
>  CONFIG_OF_LIST="sun50i-a64-pinephone-1.1 sun50i-a64-pinephone-1.2"
> -CONFIG_LED_STATUS=y
> -CONFIG_LED_STATUS_GPIO=y
> -CONFIG_LED_STATUS0=y
> -CONFIG_LED_STATUS_BIT=114
> -CONFIG_LED_STATUS_STATE=2
> +CONFIG_LED=y
> +CONFIG_LED_BOOT=y
> --
> 2.43.0
>
