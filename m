Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02914C369BA
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 19:03:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 616C182E38;
	Wed, 16 Apr 2025 21:03:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qla8e4mr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED7F382E3F; Wed, 16 Apr 2025 21:03:51 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D705D8008A
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 21:03:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-abec8b750ebso1183907366b.0
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 12:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744830229; x=1745435029; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YIPaFDUV45u25Z3b6BJz4Kr0nG5PNAmXCQphtD2Dqmk=;
 b=qla8e4mrSP6G5UKCVyvPWNjAg9E3mVzwzrOn2Fe1F9Do9S9GthXlaga7bHeXFaQnyI
 F/8Bx5IBMVaxFlELQ3nB4uKXwE9VPClkSrJvZnWtibs6MJQq8ETwPkWFtT4bjpwWatny
 5uW5I6ytZhDjgbF/6Ef1GTbCplSI4YBrBapGjQ1ITozELKqoFW9OGo0jh0Eq+1t0R5oi
 XoGlg9cDMdFsSX0jn/Jc18M8brPpebDtXF3fr2eazDKng7HBjhZ88Afm6ojR3XRpYpqu
 GBQPOIUhoeWojyGxgjskkbB3ZvDrm0l1AVqFBK5EkbkShrQq5vDhJgpHHGGmvThZb7Nr
 9myw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744830229; x=1745435029;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YIPaFDUV45u25Z3b6BJz4Kr0nG5PNAmXCQphtD2Dqmk=;
 b=Ix12tu3z1igVTTALQJHGIkvAq9T9Tz59Ibj+FY2HD8WvJNG5sjfhNGAAnBKhWobkz4
 uhObNEE1ipJYdOCujTrSnysY5DrE7NDchvp1JwXwWUOEnFL5AjnLKBcEPJieKsnFdjkP
 5SMh7kjvHw0mvxDMdPB/J6xQmXS4O/xtnH1bnUIjr4H23GzAVzaKB1hHlFlRTWO9j2RG
 KnE/6PRh58q8mYkw/kWFichGzd1AcywV8Syg8j9aDgl4nawC9qwxSelRY0HBvwR7GImf
 EuzqcDfx3asyU3imSaJzhDPeulk5PInqZqvQSAejzTYSxs9TRG4iq3D+pSHI7GWS9IbU
 EsBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXA6fjd5SdbfkIPXpSEswpFsmYZbLDRll042GG3WDwmfUdLZMMavHhoMXyCQz/XZwTHq5v+Q4k=@lists.denx.de
X-Gm-Message-State: AOJu0YxUo3HDvZhVRCFYtQRF9qKXuDmm3ICfcRMTvaV9HZRAKAezCr/k
 W1j5CBmn3EFPRLGwfXBQRu9E+pccVw8QDvoV5nmB6XWk3uIBKkM2ER3qxasDBNQ=
X-Gm-Gg: ASbGnctSgr4m0NvaGWJzhfrZ6EFHGPM3TSrxJ5Hc6hnUdkPre2tUJiDJoGy6yL+ASI0
 BjtKSodkZTIJzZooCag1zMVgrgeVrXTSSZ1zqhtw4gk6NPgC2xtf7TjcwC/nlTBSh8sI/eZrEcz
 Lq0GsVY7T30gthFOJTNWkPIU+doPGuUQW7nqSc41Fh34+CsADjrhDAh7x311Bd2CWacLAPNOI4M
 jnRWQ0HTWPMUamdcmvtGdXhgbQpX33oE8xON7n7JBKSFAgRf6VPaisdMx0efHGoKc0brpOFpVEv
 UpkE4T+uzD5Z2MEmOAGGqFNXPMBekbJHzKEayxTspfMo2sR06w0=
X-Google-Smtp-Source: AGHT+IHhl/LH6Ty8SfHSiflOpR0RNyt3M6TxZJq5abACEdHlgVIGoKMnQ+PgmFAAuKp6+n84y2M0Cg==
X-Received: by 2002:a17:907:3cd5:b0:ac8:179a:42f5 with SMTP id
 a640c23a62f3a-acb428f0f9emr258829266b.14.1744830229102; 
 Wed, 16 Apr 2025 12:03:49 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:ef30:4dd7:8393:2255:f87])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-acb3d34a20csm171440366b.181.2025.04.16.12.03.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 12:03:48 -0700 (PDT)
Date: Wed, 16 Apr 2025 21:03:44 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Sam Day <me@samcday.com>
Cc: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
Subject: Re: [PATCH 3/3] qcom_defconfig: Enable MSM8916 USB PHY + ChipIdea UDC
Message-ID: <Z___EPpD74PqDyRq@linaro.org>
References: <20250412-msm8916-usb-v1-0-2925239caf4b@samcday.com>
 <20250412-msm8916-usb-v1-3-2925239caf4b@samcday.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250412-msm8916-usb-v1-3-2925239caf4b@samcday.com>
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

On Sat, Apr 12, 2025 at 07:40:11PM +0000, Sam Day wrote:
> Now that the ChipIdea UDC driver supports USB Gadget driver model, we
> can enable it alongside the dwc3 generic driver.
> 
> Signed-off-by: Sam Day <me@samcday.com>
> ---
>  configs/qcom_defconfig | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index 537806450dc4a61d3c617cdd2b0cfb8eab1c343c..e8582d4e6bd2fae4ff2f7e34dc32651ea2de76bc 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -45,6 +45,7 @@ CONFIG_OF_UPSTREAM_BUILD_VENDOR=y
>  CONFIG_USE_DEFAULT_ENV_FILE=y
>  CONFIG_DEFAULT_ENV_FILE="board/qualcomm/default.env"
>  CONFIG_BUTTON_QCOM_PMIC=y
> +CONFIG_CI_UDC=y
>  CONFIG_CLK=y
>  CONFIG_CLK_STUB=y
>  CONFIG_CLK_QCOM_APQ8016=y
> @@ -121,6 +122,7 @@ CONFIG_RNG_MSM=y
>  CONFIG_SCSI=y
>  CONFIG_MSM_SERIAL=y
>  CONFIG_MSM_GENI_SERIAL=y
> +CONFIG_MSM8916_USB_PHY=y
>  CONFIG_SOC_QCOM=y
>  CONFIG_QCOM_COMMAND_DB=y
>  CONFIG_QCOM_RPMH=y
> @@ -133,6 +135,10 @@ CONFIG_USB_XHCI_HCD=y
>  CONFIG_USB_XHCI_DWC3=y
>  CONFIG_USB_DWC3=y
>  CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_USB_EHCI_MSM=y
> +CONFIG_USB_ULPI=y
> +CONFIG_USB_ULPI_VIEWPORT=y
>  CONFIG_USB_GADGET=y
>  CONFIG_USB_GADGET_DOWNLOAD=y
>  CONFIG_USB_FUNCTION_MASS_STORAGE=y

Please run "make savedefconfig" "cp defconfig configs/qcom_defconfig".

Defconfigs are not alphabetically ordered, they are ordered based on the
definitions in the Kconfig files. And some of the options (e.g.
CONFIG_MSM8916_USB_PHY) will disappear because they're already selected
by other options. :-)

Thanks,
Stephan
