Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 359C2E7719C
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 05:15:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8AE9801F5;
	Fri, 10 Jan 2025 06:15:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GxgT4F2N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1E72801FD; Fri, 10 Jan 2025 06:15:43 +0100 (CET)
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com
 [IPv6:2607:f8b0:4864:20::e31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C7D8800D0
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 06:15:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe31.google.com with SMTP id
 ada2fe7eead31-4afdd15db60so600326137.1
 for <u-boot@lists.denx.de>; Thu, 09 Jan 2025 21:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736486140; x=1737090940; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NhNF35bHUHloKlryg6oXYkiJSY6vX+MzJLTVxlcZZmQ=;
 b=GxgT4F2N4zgh7eFRw+7KfTV1RVkiO/xSpZrW+6GplABlJl56R8A+tX3Fc42cMu+/TU
 mVHCrH9flKgZ28rRwu1hmn41hQf5b9xiWFM9M9o7qpKpztrqRWLLJUwwQsPkHnCAp3cm
 7coBaqTZanjR8qLhWG8J6C6f8l7TcsBuwkisGG3rL/znvnlDee459k7F6pK0o4A2UVuI
 Uq9gp5Ycb+IwLkGEL8zLrxo2apl/dNPYEzp2RA9LQt6vjD8q/IdhNlgf5Tv6+P+j3/BX
 k9nwTPbSF+CMkfXxXAVm/H4Rtoa/EfQ5gp94+YIA4DsDfS6Pqw2eEBuzBv4ZG0jZMcdq
 fZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736486140; x=1737090940;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NhNF35bHUHloKlryg6oXYkiJSY6vX+MzJLTVxlcZZmQ=;
 b=oy2fdOpSxDhgzOQZaZ2j8mjOlzUXjd/VHLZULWdJAsQsj++SatRqu940tfKBn+Dh1n
 EH5WM9wynzi2YbOOlG+fQAY9X/XD295xV1JTapJPuJhaNrcEeVRayyUaehGHXVQWTR6k
 gtsXP/Oead0EpXvI5pnM85SD2aBLqUPucqtvp0FFGo7VWLvVVjRF5HmBM2vuUP2RTAYp
 R+ujSOJ3gvpGc+S2Uxy9cwkd2rmK1goxqiqZSH5FUzs7UhoWZzZJ6eV8biYUL+c5JeI1
 n8byl+lde3I5uSKwAZ6fnPj+lziTghfHcwPOA9jshuMjJufFBJIN8wdJJD4fwDg+tkH4
 /EJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4J0aRcpu+DBi+6s1V6NrebzlOJc8wKSfSsmHJMe4+pYtZqyBi7ylu98oWBs17K47UPh3UBK8=@lists.denx.de
X-Gm-Message-State: AOJu0YzhvBA7KJsLxALkhm0IBfgXb4zT39lfcuQv+SnQ9aZ6mpTdjNVq
 OvbelvVAQmBx6e4dQvrjppIWwhyH6CKXHTM5WqOBi7KlLUJFu4/UpByO16+f//WxlR2m578q6+7
 fqUMCKFISDoEktc7IyTEOTccSzhUiDJJIUpMCvw==
X-Gm-Gg: ASbGnct7yrfrpZiuTzrc12adc4PZ4nSojD8D7dXtGDisr6jbmD3WZh9/FVj8Eq7Jpbr
 CDS2WMHNc7Gfq+V6GSOt6Qrv/lUarV/tHmvZihYM=
X-Google-Smtp-Source: AGHT+IGCtNz73Aegsshnn7LEPQTvPZ5qqrjo1zQFd4I/OKtr9djtKz7go2ETnN8sjEt933NF1PLdr/U1iVr915if2M0=
X-Received: by 2002:a05:6102:6e88:b0:4b4:7cb0:ac58 with SMTP id
 ada2fe7eead31-4b47cb0bac6mr6418137137.2.1736486140423; Thu, 09 Jan 2025
 21:15:40 -0800 (PST)
MIME-Version: 1.0
References: <20250110050817.3819282-1-quic_varada@quicinc.com>
 <20250110050817.3819282-7-quic_varada@quicinc.com>
In-Reply-To: <20250110050817.3819282-7-quic_varada@quicinc.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 10 Jan 2025 10:45:29 +0530
X-Gm-Features: AbW1kvZpQOu4gOPhaycAoID6XbRt5WAwGesnpCFvFvTvgXONgpKyQUmtdRMtVJk
Message-ID: <CAFA6WYO7bvo8RWJ4=gU50Q41a88NfMe2C6HHh5bzioUz_VPxGw@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] configs: add qcs9100_defconfig
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: trini@konsulko.com, caleb.connolly@linaro.org, neil.armstrong@linaro.org, 
 lukma@denx.de, seanga2@gmail.com, sjg@chromium.org, 
 ilias.apalodimas@linaro.org, Volodymyr_Babchuk@epam.com, lehmanju@devpi.de, 
 bhupesh.linux@gmail.com, konradybcio@kernel.org, quic_tengfan@quicinc.com, 
 andersson@kernel.org, u-boot@lists.denx.de, u-boot-qcom@groups.io
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

On Fri, 10 Jan 2025 at 10:39, Varadarajan Narayanan
<quic_varada@quicinc.com> wrote:
>
> Introduce a defconfig for the Ride R3 and other QCS9100 boards with a
> dedicated uefi partition. These can replace EDK2 entirely with U-Boot.
>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v3: Removed duplicates
>         CONFIG_ARM, CONFIG_PHY_QCOM_QMP_UFS & CONFIG_QCOM_UFS
> v2: Use qcs9100-ride-r3 for default DT instead of sa8775p-ride-r3
> ---
>  configs/qcs9100_defconfig | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 configs/qcs9100_defconfig
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/configs/qcs9100_defconfig b/configs/qcs9100_defconfig
> new file mode 100644
> index 0000000000..10ff4d2539
> --- /dev/null
> +++ b/configs/qcs9100_defconfig
> @@ -0,0 +1,18 @@
> +# Configuration for building U-Boot to be flashed
> +# to the uefi partition of QCS9100 based dev boards with
> +# the "Linux Embedded" partition layout (which have
> +# a dedicated "uefi" partition for edk2/U-Boot)
> +
> +#include "qcom_defconfig"
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
> --
> 2.34.1
>
