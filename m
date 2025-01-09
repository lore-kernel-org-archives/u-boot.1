Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B1B4E7719A
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 05:38:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87E1A8006D;
	Thu,  9 Jan 2025 06:38:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FMnsfwo5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABE30800D0; Thu,  9 Jan 2025 06:38:42 +0100 (CET)
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com
 [IPv6:2607:f8b0:4864:20::92e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C02A8001F
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 06:38:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92e.google.com with SMTP id
 a1e0cc1a2514c-85c4d855fafso146867241.2
 for <u-boot@lists.denx.de>; Wed, 08 Jan 2025 21:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736401119; x=1737005919; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kOYpURe675KOnwRNK5vz2kYcKHoV4zpteztJyDV2rXM=;
 b=FMnsfwo5MBriTPMJQq4oXVJ06+KIAf7F8X2PAHNQKKTmXHLRbmFh4JTld2+qKp4GTL
 lb+oV4VKAsA05jobohOnjRiKDvuMbqOUTpLNWrH9lx+iIKG7uF+tm8g5LJJxGWoiybD4
 DgHdR+7rYqp/dc0aEOrgba0hTa1TGj7DSepru1ug2EeeZt5MsafHqLydNpl7N2JJWflw
 5iPBQMD7wu9hfoI9yd9xgM31/viw85lp9BF7YnVulNOdMpd2jBynI+6iCAbHbqSfDq2e
 Gbcan1DJB/I+OKF5lrVU+1O6waAJvzuLlvuXdNLnBiPuXY99nQ4ROaNXSy0lvs019Kzy
 Ajrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736401119; x=1737005919;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kOYpURe675KOnwRNK5vz2kYcKHoV4zpteztJyDV2rXM=;
 b=HC0sFYSmajYzEFV/ab+gJPGfb6ZWOnzYaGorQyxcNLTVkMhIlcKRikA4U3vsZRCras
 i6q3a815o0dl3soUyE9zGUjkgvLX08qx2vl6uMQe49IeELE4GzgyMxrvXFeFUPT1l6Mc
 89kNVKJigwo3mjmBnxWpARFlSfOCBIubmkZW9nxsO3qKrFSvTIOfgZ3v6ZpkYJ7oNdzd
 ObJidIxCXY4roMbwYihBfXljRZzXMhGcX4gbKhofJqhOKLX/ysr3W1d3AbfDElRaNVhw
 3hQg/hXIeGbtW2P63LqjmoncpVPy/VvB08ciDTpfurnTfXPTWLl3IgzfZrgzvHTi+flT
 LK/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1eEwNVtz1mOedDeMAhKJBhFdE00+0gJ/hoUP77XG47PsMaHOPSaN5uplAdGGCcU2YuhShgVo=@lists.denx.de
X-Gm-Message-State: AOJu0YyTbD8hE3hT1sdFmfVC7eZbD3ErpnQrR0+k1qTixc79SbUSJjPP
 9bEm5UvsSfCDWNbs+5snNd/3SPC3e5CxXaKjCB4VYdshBV6ATIy8MwJq8De0aljXJ/5rqnepwy/
 z+89jZCEc99n2VDwBPVUoNrdIPiwCPXkciqSWAw==
X-Gm-Gg: ASbGnct4BtMWSZqL9uSPL663Bs0LTouzluD/6KzK4b4WlHE0nlh0ypxEHEmvnAo+Nyc
 AC6XmlmJsvUCQYxTGPutNV5FLk8kflMVQmqqn+gy2
X-Google-Smtp-Source: AGHT+IGm0LUTsEOaap/er1uw29oTnbABsdPdwRtpJerdg6xtAY+u0Y2o1EeKZ1uqtfH7VeJi5nZZ3042hzVy3VQkppE=
X-Received: by 2002:a05:6102:c90:b0:4af:f740:c1b4 with SMTP id
 ada2fe7eead31-4b3d0f6193fmr4482344137.5.1736401118750; Wed, 08 Jan 2025
 21:38:38 -0800 (PST)
MIME-Version: 1.0
References: <20250109052545.2921502-1-quic_varada@quicinc.com>
 <20250109052545.2921502-7-quic_varada@quicinc.com>
In-Reply-To: <20250109052545.2921502-7-quic_varada@quicinc.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 9 Jan 2025 11:08:27 +0530
X-Gm-Features: AbW1kvbqbsgpxX6K93JuXgJjB-g0PLWIXkXEt4vGi4iz0aFxWYRZ5IXhzI1SSYw
Message-ID: <CAFA6WYOTxmjaQ8nKj5Z2fJ8VJcS8XS21Z2sdLKx=HBsUkQjCMQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] configs: add qcs9100_defconfig
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: trini@konsulko.com, caleb.connolly@linaro.org, neil.armstrong@linaro.org, 
 lukma@denx.de, seanga2@gmail.com, ilias.apalodimas@linaro.org, 
 sjg@chromium.org, Volodymyr_Babchuk@epam.com, lehmanju@devpi.de, 
 bhupesh.linux@gmail.com, andersson@kernel.org, quic_tengfan@quicinc.com, 
 konradybcio@kernel.org, u-boot@lists.denx.de, u-boot-qcom@groups.io
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

On Thu, 9 Jan 2025 at 10:56, Varadarajan Narayanan
<quic_varada@quicinc.com> wrote:
>
> Introduce a defconfig for the Ride R3 and other QCS9100 boards with a
> dedicated uefi partition. These can replace EDK2 entirely with U-Boot.
>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v2: Use qcs9100-ride-r3 for default DT instead of sa8775p-ride-r3
> ---
>  configs/qcs9100_defconfig | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 configs/qcs9100_defconfig
>
> diff --git a/configs/qcs9100_defconfig b/configs/qcs9100_defconfig
> new file mode 100644
> index 00000000000..7e72c64968b
> --- /dev/null
> +++ b/configs/qcs9100_defconfig
> @@ -0,0 +1,24 @@
> +# Configuration for building U-Boot to be flashed
> +# to the uefi partition of QCS9100 based dev boards with
> +# the "Linux Embedded" partition layout (which have
> +# a dedicated "uefi" partition for edk2/U-Boot)
> +
> +#include "qcom_defconfig"
> +
> +# Otherwise buildman thinks this isn't an ARM platform
> +CONFIG_ARM=y

This is already defined in qcom_defconfig.

> +
> +CONFIG_DEBUG_UART=y
> +CONFIG_DEBUG_UART_ANNOUNCE=y
> +CONFIG_DEBUG_UART_BASE=0xA8C000
> +CONFIG_DEBUG_UART_MSM_GENI=y
> +CONFIG_DEBUG_UART_CLOCK=14745600
> +
> +# Address where U-Boot will be loaded
> +CONFIG_TEXT_BASE=0xaf000000
> +CONFIG_REMAKE_ELF=y
> +
> +CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs9100-ride-r3"
> +
> +CONFIG_PHY_QCOM_QMP_UFS=y
> +CONFIG_QCOM_UFS=y

Again, these are already defined in qcom_defconfig.

-Sumit

> --
> 2.34.1
>
