Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D0B9C25B7E
	for <u-boot@archiver.kernel.org>; Thu, 30 May 2024 09:56:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D58EF8864C;
	Thu, 30 May 2024 11:56:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TGPdL6/R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68BDA886D5; Thu, 30 May 2024 11:56:10 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 159348864C
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 11:56:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1f47eb2354bso4933335ad.3
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 02:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717062966; x=1717667766; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UtTgG99gzYVQfL1IQ6zYc5jWnZGlP4mj5zArdsJN74U=;
 b=TGPdL6/R2HlnOWfF0uyTDFsIPJ8Hckcy/Pg00btfYHGlT7f3V21CteRPsfmUJRsUax
 DKCxJzCnN1RX7s4SesZZApNG1BclEUtUzrnkIqtHBPAAOw6zqTNYLHwT7Aui14e0G+zS
 iJKTRJkKMCXSvvLFdnnVxifIYI3XgRhgrd6cFn6gvPek1hSmg8ITMZsaSkPooqInLOQF
 MUrzUCFLh2eqK7y8aiYSFsoFXjDrOVDG/GzmCwnWJPtekbeXQvhqJrb/0JkZuKH4J06x
 vPBTUWjRuuuPFktU2t0KTd4CM8CnxDhMvEi3gQyIqCQmg9mKU+mwONEEpWl/8SSyDV1g
 Lwcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717062966; x=1717667766;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UtTgG99gzYVQfL1IQ6zYc5jWnZGlP4mj5zArdsJN74U=;
 b=XtcjtnTXwXRSL1ukxWJqgbI2byoIGTskXH3Nxm65zpN/VVbMiWLNlhLpStGMHyMfR1
 m3cP+tGKaUAgKjj9y2xC6q4fDgMkMN39RsBqmQEo8eKMHnT5jKSO4LGrnL1lj5Kleq5l
 zh2pOxLRmEbodR7PMynKJb08sIbu4OLfs0U8Nbrh+WJuG6jt+MU+wr9xKa7xehyBODYe
 z7o7e117wOoObFYUfjMKdA/Ct0UNbgauFSM4UK5Uuu/AHQTFW/pFVhIfYYM0VMQWtDfc
 bh4VL2duJ6kOfivX8+IjvLZUDlB2LudM8q+Ujz8EKa5KGv9PE4U7iqC881heeE+TE62C
 xm1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+I3y6SLJpKIWqSeTyTeT4u/daa2hCoOxawQlFsBAZwtdxhuYkz64UrEcpaxtQV2DnsbmzVE25vj0tAKEhUYBYw6AKfw==
X-Gm-Message-State: AOJu0YwitCYqPQDWS93ME2ey06nTe/A7/Y3+ogPVEtIxYe4ubCXUfFL1
 yMMd44sFBDp4zBBol0HIlQETik01fSKBvT+9RZn+kyHGHa6aLbYA/t4WKLALHY+gz1d84e8gur2
 kW18fHqw3pdvIaiPDpYfnRh7PKuOmmjuKxkxcsQ==
X-Google-Smtp-Source: AGHT+IFmWXfU/zgJZU1bQ5COuHxPJvqMVTg5jSR3jk6N0zeljWlabvO9fl6Y62rSdGw/1StNYqBorPz2Mk8P4xdY3nY=
X-Received: by 2002:a17:902:ecc2:b0:1f3:4d2:7025 with SMTP id
 d9443c01a7336-1f619932961mr16974335ad.49.1717062966444; Thu, 30 May 2024
 02:56:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240527-b4-qcom-capsule-updates-v2-0-47583d7ad428@linaro.org>
 <20240527-b4-qcom-capsule-updates-v2-8-47583d7ad428@linaro.org>
In-Reply-To: <20240527-b4-qcom-capsule-updates-v2-8-47583d7ad428@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 30 May 2024 12:55:29 +0300
Message-ID: <CAC_iWjJuFsxRAdSBwD+GRvc_0CS_+j=h=+_u8BJnwg9PqMB_Jw@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] qcom_defconfig: enable capsule update support
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Mon, 27 May 2024 at 20:18, Caleb Connolly <caleb.connolly@linaro.org>
wrote:

> Enable all the necessary options for capsule updates to work, as well as
> a few additional EFI features.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  configs/qcom_defconfig | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index f2dfced4bc1e..3a0ada9fd418 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -19,33 +19,38 @@ CONFIG_LOG_MAX_LEVEL=9
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
> +CONFIG_SYS_DFU_DATA_BUF_SIZE=0x200000
>  CONFIG_MSM_GPIO=y
>  CONFIG_QCOM_PMIC_GPIO=y
>  CONFIG_DM_I2C=y
>  CONFIG_SYS_I2C_QUP=y
> @@ -105,6 +110,10 @@ CONFIG_VIDEO=y
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
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
