Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAFC4CFC51B
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 09:01:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EBED8903C;
	Mon, 14 Oct 2024 11:01:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WjItybnn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 738B288FB9; Mon, 14 Oct 2024 11:01:34 +0200 (CEST)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4155D89021
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 11:01:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2e2e2d09decso2267909a91.1
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 02:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728896490; x=1729501290; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ahhPHHzEHYr1CxUKbCO926U9QF+HuN98l9odHJAVHNc=;
 b=WjItybnnresVVd8W9UR2PlMiEgtMGHXW47r6SeAKZpKMDvBYpYP+GqKrb4oV4yeSEh
 6pNEdq1fsZdyaPiMrGTgLCtz99WLCyHMp9x1eyPXll6P4/PH83hexBH/RbwkwG3K+RGP
 ihcRL1c6NOVNpPkjKhm28mQ2zoLfpTjzevCnWuUlnjnv0lZFCbFX/+K0MWTxlCnS2g8Q
 jL1CUPWfuAtaSXaGhSb80lUpHPRoVonpl4vuUvA4WNMwdwZbQBcSylDEY2hsFulhDCul
 /Q+sqbkFKa33ZGWQy9p5XvbssAdDXTN3zBF7iIr7NvcuBUknPK4wD1udNS6DGbIGTQCF
 s0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728896490; x=1729501290;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ahhPHHzEHYr1CxUKbCO926U9QF+HuN98l9odHJAVHNc=;
 b=QsSlnoNN5eBlPxbC0XbfX5l0WZrqh39h4O38DrVx1FVOuHB4Ax7qCqLKiunGxGD/q8
 7cewNfDl+ZWzlPVTemUHlsVgppEi/Oq4PdyDVxngbA0D9GBOGr8nm6ayxHLwskE60XUi
 4jfc1Kt5LmbTN8vy9ZhDUtB0J86rrFL0brxftFu7v07N1FL+9TLamnjdnzUjSqZv7gMy
 DfM0v95QUFyePHB8WI5Jx/FmtKAQr8dG7LBS3cajQnvoJrWj8xlzBvppJCasCVY4LCEN
 oatHRjg2HvFM3iiadmzV0aIWjHgDFarLJSF3DCgga7Lf/dD+Rzf5aZR/tHLTIEEcTeAU
 kXtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlajP0tDUglLOTkWIc1+ym2W+lAk50bl1k/dnRQdICHl08sKgzjcvon0/4jbZ/b4IisrZtLwI=@lists.denx.de
X-Gm-Message-State: AOJu0Yw0sEjj5NxVaz6G5kg1yjE2iZH7ALVSESikgZVizbOjIzqlmx1p
 FQVPcp6aAU6YR8EAaRs9wA+dcP7qYDrimf+4qDm+N+V3eCXMk08oE2Kxemiz8kBX+QgIIG1Uclt
 FzxDNo6EWhMPHQ5EAxlv+b4IQrD5hNBtuWHo7CA==
X-Google-Smtp-Source: AGHT+IG30hD8UW9iB5Rq6mY4EBXV06kiFMq6OnR53U8OfdL6EMIpd47QN5NxaTfxcAgXJ5uK/22PVaCVNVofOwzoXUA=
X-Received: by 2002:a17:90a:2dcc:b0:2e2:8f4d:45a with SMTP id
 98e67ed59e1d1-2e2c81ba3c8mr22899565a91.13.1728896490507; Mon, 14 Oct 2024
 02:01:30 -0700 (PDT)
MIME-Version: 1.0
References: <20241012-b4-qcom-capsule-updates-v4-0-abd05f15255f@linaro.org>
 <20241012-b4-qcom-capsule-updates-v4-4-abd05f15255f@linaro.org>
In-Reply-To: <20241012-b4-qcom-capsule-updates-v4-4-abd05f15255f@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 14 Oct 2024 12:00:53 +0300
Message-ID: <CAC_iWjLLd1-Rx9cFo18jXEEprqWks8PNmw3TLsPk+QewOJoojw@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] qcom_defconfig: enable capsule update support
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

On Sat, 12 Oct 2024 at 16:57, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Enable all the necessary options for capsule updates to work, as well as
> a few additional EFI features.
>
> Capsule updates themselves are only enabled for the RB3 Gen 2, since the
> exact details on where to flash U-Boot (or how to handle multiple boot
> methods) has not been finalised for other boards.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  configs/qcm6490_defconfig | 6 ++++++
>  configs/qcom_defconfig    | 8 +++++++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/configs/qcm6490_defconfig b/configs/qcm6490_defconfig
> index 5ddc5ab3ef8c..ba26924da161 100644
> --- a/configs/qcm6490_defconfig
> +++ b/configs/qcm6490_defconfig
> @@ -18,4 +18,10 @@ CONFIG_DEBUG_UART_CLOCK=14745600
>  CONFIG_TEXT_BASE=0x9fc00000
>  CONFIG_REMAKE_ELF=y
>
>  CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs6490-rb3gen2"
> +
> +# Enable capsule updates
> +CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
> +CONFIG_EFI_CAPSULE_ON_DISK=y
> +CONFIG_EFI_IGNORE_OSINDICATIONS=y
> +CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index e7ed03ff0f24..4c8ff0e84372 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -20,21 +20,24 @@ CONFIG_LOG_MAX_LEVEL=9
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
>  CONFIG_CMD_REGULATOR=y
>  CONFIG_CMD_LOG=y
>  CONFIG_OF_LIVE=y
>  CONFIG_USE_DEFAULT_ENV_FILE=y
> @@ -44,15 +47,18 @@ CONFIG_CLK=y
>  CONFIG_CLK_QCOM_APQ8016=y
>  CONFIG_CLK_QCOM_APQ8096=y
>  CONFIG_CLK_QCOM_QCM2290=y
>  CONFIG_CLK_QCOM_QCS404=y
> -CONFIG_CLK_QCOM_SC7280=y
>  CONFIG_CLK_QCOM_SDM845=y
>  CONFIG_CLK_QCOM_SM6115=y
>  CONFIG_CLK_QCOM_SM8150=y
>  CONFIG_CLK_QCOM_SM8250=y
>  CONFIG_CLK_QCOM_SM8550=y
>  CONFIG_CLK_QCOM_SM8650=y
> +CONFIG_CLK_QCOM_SC7280=y
> +CONFIG_DFU_MMC=y
> +CONFIG_DFU_SCSI=y
> +CONFIG_SYS_DFU_DATA_BUF_SIZE=0x200000
>  CONFIG_MSM_GPIO=y
>  CONFIG_QCOM_PMIC_GPIO=y
>  CONFIG_DM_I2C=y
>  CONFIG_SYS_I2C_QUP=y
>
> --
> 2.46.2
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
