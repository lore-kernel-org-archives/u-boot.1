Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C20C3ABBC
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 16:48:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63C7C8269F;
	Fri,  9 May 2025 18:48:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ze0vTBLF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E14E8283E; Fri,  9 May 2025 17:28:57 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 715D382162
 for <u-boot@lists.denx.de>; Fri,  9 May 2025 17:28:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ad21a5466f6so195422466b.1
 for <u-boot@lists.denx.de>; Fri, 09 May 2025 08:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746804535; x=1747409335; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i2wWNmF0wbYyQ0Rj5M7XPaM7qWRt7AW8rsi4dRLbRXQ=;
 b=ze0vTBLFaBcyhgvFqP1eQeDNhIC3zsIxF8x+qn2JtIDy6ge5L/Gqy7PGhgGQI320IZ
 iaM1WRBwfZewH1RtguY+VNHF/nAB1Zrpg/k36ey9WqrXg7l+9eMYRHB67/AkEJHwzTrs
 YULDDsL+KanGe6QD53JM9ILOmrbJrskmw3zO0p6rVZHDcGA8Ea5B3Gm0r6GmA3Yk+fFS
 9f89njF8VLI4cD78Yk8O4FKZ2detOqa49sEFmRFYz6r7dmCHTcc/PeMkU70sDCC7x3UE
 XtRq8MSiitM2Aq6mSdIwXdlSwaNhjOT1C+zFnW4AhJgvCEGKPUWz7BDrSXqtN/3QvUiJ
 3OaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746804535; x=1747409335;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i2wWNmF0wbYyQ0Rj5M7XPaM7qWRt7AW8rsi4dRLbRXQ=;
 b=nxcICTA1xbH4h3M0bVxmMJJv0/FozHYdQNt8T7AOC3iGnZesbr5e8FeUl2hYuaZYta
 ij9dlVF2S62icaaIz2ZUR9j3xPncz4hQNjoz+gwHyL77VLQufXOsGuX3qN79fqz9QVbu
 +SJZYc7EnP012QHs6DLTsrXEUz9wNxvQ0QuXC1sVnsaABlxfl9cjXZfmVc9Ea9yzdaZV
 1khctMTTmOBDbNdmPWQuvcXLzzd2+fPq1igd0/RcYxcb/HNxtZJi0vxb+PAhvtnOnGCx
 8hLUvsC/052i8f8CaHi7Rql02gbvl3go+cJ9s+kq4ELrs2jSz0N/EI78LkS6yR5IylKv
 ubfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRigrbQXPeqNvodov45DedOUpEwbn2F4wj+r08EjFKQy07Up8rfWXFGkHR6UT3M8ZsXnyuWBs=@lists.denx.de
X-Gm-Message-State: AOJu0Yx7n6p1aca/lSUtqduvnm9YoXJo+SstVUg8s/qrtsfkv+uL2S7Y
 ZBDaaLtx4kxvmIaWlZGfguKhDmU083h7IIig2KJsVs9Ba9d3iq2q49kLJ+NLzJg=
X-Gm-Gg: ASbGnctbuaOs9YjCqpOYTqPlxCVvZVlVAGzuc49a9gVmDpMTMbprRkVuD9UxC5+m6bg
 vNcdIKd3pOiJ/SikrCdAbqrW+MBtdDmENNqzvxCGTWcsZGov1M0ygQWxJfOhehpIuYvS6Fy+oMl
 rS08VWRFQjEcPIPVKd5BY+lwH5Oaqhe0gB+9zFoIA2hvfJGOI82o8pVHsHbDEW4kXacH9WOoSS3
 8CkNn9U8F+pZ4yWSirchevRFXHlD2IqM0y44Vs6/vJGleTrnwOXdNlvKcrh+9v+2SXOh0tJsEBB
 6xdLkRiy3OF1iHcgl291V8cFeNQEhomeZ8sftyhXt7QhhA9GKlxE77Jkf3Eid6tqJ5zRPeeb4+g
 KZWW3fR1CMRSwuUIt0+oPRYSrEN741Mb9JCLUvgAB5xIi9pHiHrJrz/ZjpKFmMzez6FtpCZ1BNQ
 wX7arRJmAV+NaMAaUctKCDPfR5Wg==
X-Google-Smtp-Source: AGHT+IG5cfVZjwifs5I/bP56aDvq4PfZTwxxL163WnFjM/i40UmwZ58Gq4Dwm3w2mEMzENnQ2v9zyA==
X-Received: by 2002:a17:907:8749:b0:ad2:175b:9e4 with SMTP id
 a640c23a62f3a-ad21b14cb89mr341204566b.4.1746804534825; 
 Fri, 09 May 2025 08:28:54 -0700 (PDT)
Received: from ?IPV6:2001:1c00:3b8a:ea00:3e1a:65c8:b220:d6dd?
 (2001-1c00-3b8a-ea00-3e1a-65c8-b220-d6dd.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:3b8a:ea00:3e1a:65c8:b220:d6dd])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad2197bd3a6sm164265866b.131.2025.05.09.08.28.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 May 2025 08:28:53 -0700 (PDT)
Message-ID: <17533175-998f-4a15-b939-3a16d4224e88@linaro.org>
Date: Fri, 9 May 2025 17:28:52 +0200
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
X-Mailman-Approved-At: Fri, 09 May 2025 18:48:29 +0200
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

Hi Balaji,

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

Also, this should be named qcom_qcs8300_defconfig so that 
get_maintainers will work properly.

Kind regards,

> @@ -0,0 +1,21 @@
> +# Configuration for building U-Boot to be flashed
> +# to the uefi partition of QCM6490 dev boards with
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

