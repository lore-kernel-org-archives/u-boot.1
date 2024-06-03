Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83F88C25B75
	for <u-boot@archiver.kernel.org>; Mon,  3 Jun 2024 13:49:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 070A68813A;
	Mon,  3 Jun 2024 15:49:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ONRYRxlM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2F6F88300; Mon,  3 Jun 2024 15:49:07 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2A5F88282
 for <u-boot@lists.denx.de>; Mon,  3 Jun 2024 15:49:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a690161d3ccso117726966b.2
 for <u-boot@lists.denx.de>; Mon, 03 Jun 2024 06:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717422545; x=1718027345; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qR8r8tn1GZVvDJLHAA/YXNGxPCbPeMKRTPuyibF8i0Y=;
 b=ONRYRxlMUdKxDV67opvPGf5kmzp0lH9baFOn9TYo4NrQ2m0OjV9UNqoRulCvjo+EQF
 zJZJJLe8nRCU0qjgfRbmnGEFlehAbapY+vKOABpOgWghcbU9PilT2mWduE86kNhcClj6
 cJTSVJC0Yslejxj2pc/Z4ExD0EEUD0aj3mXig7fBXpHl7r7uuAAvCvKU3rsiQMld/OPT
 BZ6cTbo0E+y9jp6Wa/Hnc6QleOKlicBqAguwCU+zXmhDyQXDkQtJ9949hJGkygIQxuI/
 rO/0Dgjmhf4cds6nr/qFFjmhnUYFJG3CeKq6SqRDZew5IZHC6fhQNxp8cpDG9N6aYiO6
 D4Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717422545; x=1718027345;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qR8r8tn1GZVvDJLHAA/YXNGxPCbPeMKRTPuyibF8i0Y=;
 b=gm/OAG+LQWxEAFTlElm8tLBEkVPPG3JgfjkEMr/hDI246P94/Tf9oxz35FSxv1OSeJ
 L+Oabv/7FjFpoNWYn2EK60mC7K3BOJHKZ1HvE4+KakFOMRlaMlSWvoyYJK/a+0HcqZiI
 ViJPaKMZ/5DWvrgCmmjC3Xdt420ShH6Ot2yx7O5B0bsJaX5yPKc+7M5K5zxALbAV+zRM
 7OUaVjI9BLnEv3qU4/qTJ7WPgqSjdbG5JqpNGMPsHquA+4hdi05AO7LFpve9kExrns8a
 wprC2EKW3XRb4HVzg0QOSQDVHWx6wjk0wZryLErgIvSr9eHgkdUtUyy4hz06H8sD8wV+
 Z6jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlRcxiIRYl1gEHcTM9iHjnYlt6/B273BU26voY2ZSRJ8VYLXV3Z3ebNCjdgAIKWkmGcKCQi9hWSNBN9r8CqFu+bHvliw==
X-Gm-Message-State: AOJu0YybS/M1gPVVboq8zgWqu7UUcIr6lEcWn+QVVvzPuMlqggStfBrT
 R1doqOvOMtvgEyXbGDKPbi6z6TppO7vky7UwgEUuWfvo7HPuUEC/sKeoWArv7rKwbHONQ4Ggnxn
 c+zVK+uCO7XgaTCdoRjHIWWll7Dx10UXdv5C54w==
X-Google-Smtp-Source: AGHT+IFAPlRNOMCsoTcVznSeewofyelfPI5gXXhcMQmgLh694ce3DnZbw19GrCmcA5t2Iy3f+GdS1VeHPKjk9+b+7hg=
X-Received: by 2002:a17:906:f152:b0:a68:cb91:f98d with SMTP id
 a640c23a62f3a-a68cb920457mr344433666b.37.1717422545321; Mon, 03 Jun 2024
 06:49:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240603-b4-qcom-capsule-updates-v3-0-fe2e083289ec@linaro.org>
 <20240603-b4-qcom-capsule-updates-v3-8-fe2e083289ec@linaro.org>
In-Reply-To: <20240603-b4-qcom-capsule-updates-v3-8-fe2e083289ec@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 3 Jun 2024 16:48:28 +0300
Message-ID: <CAC_iWjLqTbOCz2k0JY+N6JOcTeHgg8pmLRN=q3Hve2yoEmCf6Q@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] qcom_defconfig: enable capsule update support
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
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

On Mon, 3 Jun 2024 at 15:49, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Enable all the necessary options for capsule updates to work, as well as
> a few additional EFI features.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  configs/qcom_defconfig | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index f2dfced4bc1e..d1de7158e3f5 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -19,33 +19,39 @@ CONFIG_LOG_MAX_LEVEL=9
>  CONFIG_LOG_DEFAULT_LEVEL=4
>  # CONFIG_DISPLAY_CPUINFO is not set
>  CONFIG_DISPLAY_BOARDINFO_LATE=y
>  CONFIG_CMD_BOOTMENU=y
> +CONFIG_CMD_NVEDIT_EFI=y
>  CONFIG_CMD_EEPROM=y
>  CONFIG_SYS_I2C_EEPROM_BUS=2
>  CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
>  CONFIG_SYS_EEPROM_PAGE_WRITE_BITS=5
>  # CONFIG_CMD_BIND is not set
>  CONFIG_CMD_CLK=y
> +CONFIG_CMD_DFU=y
>  CONFIG_CMD_GPIO=y
>  CONFIG_CMD_I2C=y
>  CONFIG_CMD_MMC=y
>  CONFIG_CMD_UFS=y
>  CONFIG_CMD_USB=y
>  CONFIG_CMD_CAT=y
>  CONFIG_CMD_BMP=y
> +CONFIG_CMD_EFIDEBUG=y
>  CONFIG_CMD_LOG=y
>  CONFIG_OF_LIVE=y
>  CONFIG_BUTTON_QCOM_PMIC=y
>  CONFIG_CLK=y
> +CONFIG_CLK_STUB=y
>  CONFIG_CLK_QCOM_QCM2290=y
>  CONFIG_CLK_QCOM_QCS404=y
>  CONFIG_CLK_QCOM_SDM845=y
>  CONFIG_CLK_QCOM_SM6115=y
>  CONFIG_CLK_QCOM_SM8250=y
>  CONFIG_CLK_QCOM_SM8550=y
>  CONFIG_CLK_QCOM_SM8650=y
> -CONFIG_CLK_STUB=y
> +CONFIG_DFU_MMC=y
> +CONFIG_DFU_SCSI=y
> +CONFIG_SYS_DFU_DATA_BUF_SIZE=0x200000
>  CONFIG_MSM_GPIO=y
>  CONFIG_QCOM_PMIC_GPIO=y
>  CONFIG_DM_I2C=y
>  CONFIG_SYS_I2C_QUP=y
> @@ -105,6 +111,10 @@ CONFIG_VIDEO=y
>  CONFIG_VIDEO_FONT_16X32=y
>  CONFIG_SYS_WHITE_ON_BLACK=y
>  CONFIG_NO_FB_CLEAR=y
>  CONFIG_VIDEO_SIMPLE=y
> -CONFIG_HEXDUMP=y
> +CONFIG_SYMBOL_LOOKUP=y
> +CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
> +CONFIG_EFI_CAPSULE_ON_DISK=y
> +CONFIG_EFI_IGNORE_OSINDICATIONS=y
> +CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
>  CONFIG_LMB_MAX_REGIONS=64
>
> --
> 2.45.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
