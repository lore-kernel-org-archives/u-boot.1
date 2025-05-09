Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0058C3ABBC
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 12:40:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E0FE82A55;
	Fri,  9 May 2025 14:39:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EE6AaAbA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5436B8210D; Fri,  9 May 2025 13:09:34 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F8418059D
 for <u-boot@lists.denx.de>; Fri,  9 May 2025 13:09:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43cf848528aso16042625e9.2
 for <u-boot@lists.denx.de>; Fri, 09 May 2025 04:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746788972; x=1747393772; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W2sw3J06Luawrulvtac0mZn7DI/2e2aeReiunVJ24GQ=;
 b=EE6AaAbAH3Z1T8K3RF+AzKeY/92PFaxcchH04JwC9l56bXujJJcZ2HbhXiQiubcBgj
 mpbSa95arsPfxWqV5h3iA1Xum01nKiVcD5TIo5of5zga2z3afj8IE6xwzJsWJx3y5k4a
 zBM73ehLCrjC/YDlVDsOTiYiI5CPo3lyXl8EMsZg5iWAPpcnmnmEvtWIHJedSi6oxz8u
 ZHmbO/1tXHXTL36O+dw8xtvybW2Uudg7z3unRLVozL55WeZ/1SyLV72Gtb1/BiTYp0No
 gfPZuE1JK90+rQI6p1C9vMWpZWMJtpnPgEkd1c4N51aJu3aPQHKHH3WQPycXXJKcp0eU
 YN5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746788972; x=1747393772;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W2sw3J06Luawrulvtac0mZn7DI/2e2aeReiunVJ24GQ=;
 b=gQ3jxV6r6G+rPD1Kp2J8Z9A/0hqNJRWw2hAMvdvfNvlYNm1sugCBO2MEF6FzyKVL0q
 NIsD5TxObyoVCUU9o/Z6SsSdCLEiTTWpdjWhzVy3QUMgJm9n2kw5coEbVrdtekP4rqDu
 B336tIAgXeIgUruPGh+I/0JA5LYHn7fXW2gH3K1hVo9JnEKh/KGUb02K+NEiSFwmO71h
 b+l2axENadkuvKNjkqNW9f2jZB0tXRW3Jyan/eBuZ2GUpz+LU9gxsALMIezWM2MwcoWE
 D77jcABjPVJxM4RMHVAVIkzuZDVqXYb1GMq0Cxzr/VUfYwP41Qh5fzM4izXS0QXMyRkK
 yvmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVq3bUP1Bt5EfSvqm6k46KAXfma/AAfgSjFYx5VnwREim5f/VMqMCXLtUFbfNGxAw2jzLtLGdw=@lists.denx.de
X-Gm-Message-State: AOJu0YymPon5PugWFmDnyM33FL41Jb/C9kgZJ0VmA4HdDyUF81sOEPi/
 0c33ZJoMzLC7/tU3zyqkkZj7ihWc6KZn3DiASc8M5w2gwDYQ/TD7VcppN+LpUf4=
X-Gm-Gg: ASbGncsiITbWVLduNaeL/2LTGX267jpUGiJnuHCn7CFvoEnHtE43kq8neoVAEJKm2i/
 DXDSehg4I8wMizLPkO7iAqy3oq1OWgQWNJukDe+ce8+tY3J4Jn+Mdc59OSuEM/w9WRPHYC9yBz6
 ddThijfNTiNIy77gdcLuAML54DIfW8NUQE8aeMHGK7Y9w37Oke8Si3GdD29/Xu862QSQNkciPVT
 JIN2uc481qXbuxo9ISUhbZh5y00fK9Km5lCuXZeBg6lBzHkModHnE17u4nJ80GwIk9Udn7791cK
 sXQ65faHYnLfAdGyckAkUbOS+AZfKQvqU6ZSxSx0IlIgMz8ZM9Zu4j0VtrfvvztpAxh+FvCTFIW
 olt418vEmIMLvCQ==
X-Google-Smtp-Source: AGHT+IFq40camSnzwZ9kNsvuijQ3JaStVTAt8ZypHAA4ohz4RGA3t0iD3v/wCJ48KDGI4VGkF5lw9Q==
X-Received: by 2002:a05:600c:3b17:b0:441:b5cb:4f94 with SMTP id
 5b1f17b1804b1-442d6d08c20mr25228985e9.5.1746788971748; 
 Fri, 09 May 2025 04:09:31 -0700 (PDT)
Received: from [172.18.195.54] (ip-185-104-138-77.ptr.icomera.net.
 [185.104.138.77]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f5a2d30asm2909092f8f.76.2025.05.09.04.09.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 May 2025 04:09:31 -0700 (PDT)
Message-ID: <23755901-642c-4be5-92ea-ce32ec42cbc3@linaro.org>
Date: Fri, 9 May 2025 13:09:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 6/6] configs: add qcs8300_defconfig
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 trini@konsulko.com, neil.armstrong@linaro.org, sumit.garg@kernel.org,
 lukma@denx.de, seanga2@gmail.com, ilias.apalodimas@linaro.org,
 me@samcday.com, sjg@chromium.org, quic_varada@quicinc.com,
 sughosh.ganu@linaro.org, lehmanju@devpi.de, bhupesh.linux@gmail.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250508111952.2304578-1-balaji.selvanathan@oss.qualcomm.com>
 <20250508111952.2304578-7-balaji.selvanathan@oss.qualcomm.com>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250508111952.2304578-7-balaji.selvanathan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 09 May 2025 14:39:39 +0200
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



On 5/8/25 13:19, Balaji Selvanathan wrote:
> Introduce a defconfig for QCS8300 based boards.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>   configs/qcs8300_defconfig | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
>   create mode 100644 configs/qcs8300_defconfig
> 
> diff --git a/configs/qcs8300_defconfig b/configs/qcs8300_defconfig
> new file mode 100644
> index 00000000000..06afc45ec33
> --- /dev/null
> +++ b/configs/qcs8300_defconfig
> @@ -0,0 +1,21 @@
> +# Configuration for building U-Boot to be flashed
> +# to the uefi partition of QCM6490 dev boards with

I don't think so

> +# the "Linux Embedded" partition layout (which have
> +# a dedicated "uefi" partition for edk2/U-Boot)
> +
> +#include "qcom_defconfig"
> +
> +# Otherwise buildman thinks this isn't an ARM platform
> +CONFIG_ARM=y
> +
> +CONFIG_DEBUG_UART=y
> +CONFIG_DEBUG_UART_ANNOUNCE=y
> +CONFIG_DEBUG_UART_BASE=0x99C000
> +CONFIG_DEBUG_UART_MSM_GENI=y
> +CONFIG_DEBUG_UART_CLOCK=14745600
> +
> +# Address where U-Boot will be loaded
> +CONFIG_TEXT_BASE=0xaf000000
> +CONFIG_REMAKE_ELF=y
> +
> +CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs8300-ride"

-- 
Casey (she/they)

