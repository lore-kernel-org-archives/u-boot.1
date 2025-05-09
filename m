Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD36C3ABBC
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 12:40:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 482AF82A3B;
	Fri,  9 May 2025 14:39:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eKZPWt6a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E53FF8210D; Fri,  9 May 2025 13:09:03 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8D488059D
 for <u-boot@lists.denx.de>; Fri,  9 May 2025 13:09:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43ede096d73so13878925e9.2
 for <u-boot@lists.denx.de>; Fri, 09 May 2025 04:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746788941; x=1747393741; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TapR/hBcnU2+EPEuDTvskT1IOr6bEELQZhXdypFftcU=;
 b=eKZPWt6aE2NWh0qTA+kM2Ok+FymgQQhez8nXbZrMjOoc6gZA6z6fTwABc9R7va5CG9
 02+DIaK4dneUg4CskBa3ixgDZy1EZm3j9TxJetre78XHCFj1n3M4j814fABxL6XPFRPQ
 OXP10wk2421ZVoeOjqjazjar9hX4OBQkbtbNAi6/Wq8aHzpFoYBJiiCLA2N6mW9f9Gpx
 GqQHH9YKL9Kc++BRNbrJCsoSLjUFP161YAwDO1+iCDz9/XiHzhf5rZqqyvUOVyDGtxth
 QtTg6BFV8AFQxdMJc+eJqT0Yfj+rEyhK1Mtqw6iiG0Bij9JOLh1j3DsCmUU9t0076Hv2
 3Q/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746788941; x=1747393741;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TapR/hBcnU2+EPEuDTvskT1IOr6bEELQZhXdypFftcU=;
 b=ca447J42E9VkfglIeXFYckeh/yLjWPyDsxGyhaqsEK+KIN5lc6nFsUWCoupl3cbj33
 ZzjS+REYLuG5NmTBPHDgGlpxQEI6I5SHWBwgO9J4Twl8y8jENA5Y8GneYKPWZnSW7srg
 pYttmTXXv1abnUFyOCkoJ8/xsj/48MAWeVSl1mhj/xY5fVFtw2QuzNPSderDbMGfPcSW
 swsEunhHaDQ/KdKXkNHvayeVQFH2Fp20jDGtc8JgHbiavESHOZv0NzzbNs+xPsH1uYNq
 T9lHDSqIPJB3u9MPaAbzxAm6Y+BDeTc+xPVf/6d8AlCSyAStEEgW0h+uMzG/YnWU+t9P
 d13w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1o2myoJQjbzY3K7OKxtsERFQVFniwGM3mpbssonMSsMQhkrjfy95NJALfaBCNmJmQS03ayns=@lists.denx.de
X-Gm-Message-State: AOJu0YwOltlrNCtomZyRqWnOAqdvLcW8c5NVEVACGL/jAqDuLONzTWeg
 pCC2dcVyjomr7rvCoco32CZqbFFz68CzT1c7IUdm1BqOMphhxjsrh5wYViLA55o=
X-Gm-Gg: ASbGncvGQyib5/ga5vlYhFCe8E7qklsrhEDROpQJM4s20Uu10JcOzagBNYBAGN0wmN7
 Z1MmaQY6i19LoR3ODpGX33KQgo0fDwvFCDnYzDlzX8D87FptU6g5bCms04vvwVq9WKlSyxwh6DJ
 fNSGoMXAwKRGaPYGfx+9A54U+WtnuE3gO3xLtkghu1aiFarUl4BDxi+qZelKr6va0TX0E10Mydg
 ZDQ3Ulsh1vCEG/UvO5XHU8CqYdLwteIixbGXxVpvzoP+fNYKc5RL2Ggk19hRu8vwqM8mmTImklZ
 3k6UIytrhMnYU1bLChICX/TeOpYCmpFcE+HC4yYc/vwZoRKo42msNuWdbbbr53TvjTx9LPNuMq3
 fm+8/pdPwanIANg==
X-Google-Smtp-Source: AGHT+IEQTvO93kTSW6aJ/e/pyKDhQVv48RzMASfyU3HNqVxG9w2ZE0FZOzf6XtKKcNzRPyaTQ66+FQ==
X-Received: by 2002:a05:600c:1d8c:b0:43d:683:8caa with SMTP id
 5b1f17b1804b1-442d6d64644mr25358445e9.15.1746788941175; 
 Fri, 09 May 2025 04:09:01 -0700 (PDT)
Received: from [172.18.195.54] (ip-185-104-138-77.ptr.icomera.net.
 [185.104.138.77]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442cd328f0fsm70291975e9.7.2025.05.09.04.08.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 May 2025 04:09:00 -0700 (PDT)
Message-ID: <b8155d82-ff4b-4ff3-9b0c-2f0e181f6994@linaro.org>
Date: Fri, 9 May 2025 13:08:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/6] qcom_defconfig: Enable QCS8300 clock driver
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 trini@konsulko.com, neil.armstrong@linaro.org, sumit.garg@kernel.org,
 lukma@denx.de, seanga2@gmail.com, ilias.apalodimas@linaro.org,
 me@samcday.com, sjg@chromium.org, quic_varada@quicinc.com,
 sughosh.ganu@linaro.org, lehmanju@devpi.de, bhupesh.linux@gmail.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250508111952.2304578-1-balaji.selvanathan@oss.qualcomm.com>
 <20250508111952.2304578-6-balaji.selvanathan@oss.qualcomm.com>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250508111952.2304578-6-balaji.selvanathan@oss.qualcomm.com>
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
> Enable the QCS8300 clock driver in Qualcomm defconfig.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>   configs/qcom_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index 537806450dc..5a3e5aa8e97 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -52,6 +52,7 @@ CONFIG_CLK_QCOM_APQ8096=y
>   CONFIG_CLK_QCOM_QCM2290=y
>   CONFIG_CLK_QCOM_QCS404=y
>   CONFIG_CLK_QCOM_SA8775P=y
> +CONFIG_CLK_QCOM_QCS8300=y

Please run "make qcom_defconfig && make savedefconfig && cp defconfig 
configs/qcom_defconfig"

It's fine if there's some other changes. But this needs to be in the 
right order.

With that

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

>   CONFIG_CLK_QCOM_SDM845=y
>   CONFIG_CLK_QCOM_SM6115=y
>   CONFIG_CLK_QCOM_SM8150=y
-- 
Casey (she/they)

