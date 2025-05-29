Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B1CC54FB3
	for <u-boot@archiver.kernel.org>; Thu, 29 May 2025 19:03:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 183E783010;
	Thu, 29 May 2025 21:03:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kzlPFYGf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED0438307F; Thu, 29 May 2025 21:03:29 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0560382B20
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 21:03:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-450cf2291bbso5421485e9.0
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 12:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748545407; x=1749150207; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=x7BiaY3jy8D7YFIJRF3HqOQrXfhv8Ehlpb0L9CDlAcc=;
 b=kzlPFYGfSq6gShnzU8awMvYuco7Yvl+aFVx6BFe+b0T9VVJNu7taWoZ+Qc1/clP/en
 9llyVjQL1UD6PioLjU7INP2+W8NxQ6hpZDGO5ibzuq8OAjkYqG08QkTFg/OOiXzDXaVq
 Bo+WqkEi8TuBBVYGDq/eFFfyelLd2aLO6HyGLVPXbmsGX+IVvSZhtU+XvUMwdhnD7ZBT
 LLfx5n+VINMmG/Ui2TNfnK+jjrt/w6KQmIILg1pue7cxNc/A6pE/SVFryRnDVVT00Yw5
 Q8LpW52Y+cfiESsmz5t8uV8xjoe+NekH2geSTreFAeswcSG8/A6xSJ57XOcDphPruBXR
 3lew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748545407; x=1749150207;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x7BiaY3jy8D7YFIJRF3HqOQrXfhv8Ehlpb0L9CDlAcc=;
 b=fAD0O7RNK0IBlcOmK6wwQ18ZWIAQCSuWCTO0MoYC7bCJ+FObFU0P4m+D4cLutTAUNN
 kMzNP57kNK5Z7xbYXuxUpj6WR+xzQikBagHO3g0FV2OJcqgQnT8MrJX62Zq8PaI63iWY
 njRCVkuLh4Bjg0zrliiQgdxUVomQQ+QTUOuxyoIvpF2NdvjSduhbgHsiZNEr7AfeADqD
 kWBmQotwLaCMTIfwP8o3UQenvfGtEBrH88ReJgLgQL05mVJcWcoZr71LWMMSo5qsyoUA
 cKGTVdud2jmfnGuiFX8yw+qsJmYZXxVlIul8Q1x2ie+cXEL0toB4MI84oxm1lfw3KnCS
 Ex8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3ZcxDpkLymhG4ll0uWv6+qFJOporU24CLrohXpCubYFPueLqzIv0QUtkUKF+9oHqdV/5Dj0A=@lists.denx.de
X-Gm-Message-State: AOJu0Yxe1MBvVodbdPT4zCNN0iSpUnDXMDPBhdA8L4BjYI+n4FNump0y
 FBqmxzAW9iMpgzqvwhXVdBBGXxDJ99QOT4dM23ClQsH8rNvstV+iCEYjjzkgR+AQyT4=
X-Gm-Gg: ASbGncs8nSlQadKH5N9ouJikq3p86KDtOVqU2PmwSMr7S1GDlRcyQ5Y0CHt7XjuZFi7
 xcVYrnglhEMS1OiWvJ0g7FIsD/Ic/dRZtZbBYCDAM95GJbFEva/8ojnxKGtpsp7DVEKPvk1BMiq
 FBJTfv+0KElKwyEQPZVdPIUjpJe48aRdOBG6fEUdBVsH0hM7A+eSfwd+RlOwoYDliHsWFByAhCo
 9fJo7KSk+UE6XzCECLlS3stNh0xxfCAmztuyFDt/AYm0SOxJVu7cwsJlRRRy9EVWPxrZ8oCJjNe
 gaoZQ2BqX0nHTME29PNaatZczoZRqB32TA5NSgv5TTsnPTSnfwSOwvzZSiyqjBuL4lfQdRCEr+G
 XWc4032dYopSHI26hDy0F1DD6ww==
X-Google-Smtp-Source: AGHT+IGheH5I2xJDJLwKA6NWBesNaY4P5VMMLMjxkqOjHuj5xuko6OjLapbGZJk/Vq/75KSZOiip9Q==
X-Received: by 2002:a05:6000:4282:b0:3a3:6e62:d8e8 with SMTP id
 ffacd0b85a97d-3a4f7ab1425mr270158f8f.55.1748545407447; 
 Thu, 29 May 2025 12:03:27 -0700 (PDT)
Received: from ?IPV6:2a01:170:117e:fc:9bc3:77c2:6c71:775c?
 ([2a01:170:117e:fc:9bc3:77c2:6c71:775c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe73eebsm2761210f8f.44.2025.05.29.12.03.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 May 2025 12:03:26 -0700 (PDT)
Message-ID: <b8548d86-f2a5-4719-90be-d2c682a497aa@linaro.org>
Date: Thu, 29 May 2025 21:03:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] configs: qcs9100: Enable env in SCSI
To: u-boot-qcom@groups.io, neil.armstrong@linaro.org, sumit.garg@kernel.org,
 trini@konsulko.com, joe.hershberger@ni.com, quic_varada@quicinc.com,
 avromanov@salutedevices.com, michael@amarulasolutions.com, sjg@chromium.org,
 hs@denx.de, michal.simek@amd.com, marek.vasut+renesas@mailbox.org,
 venkatesh.abbarapu@amd.com, ansuelsmth@gmail.com,
 cniedermaier@dh-electronics.com, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org, u-boot@lists.denx.de
References: <20250513091710.3719292-1-quic_varada@quicinc.com>
 <20250513091710.3719292-6-quic_varada@quicinc.com>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250513091710.3719292-6-quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 5/20/25 16:32, Varadarajan Narayanan via groups.io wrote:
> Enable CONFIG_ENV_IS_IN_SCSI to store environment variables in SCSI.
> Set env variables partition UUID as seen in qcs9100 based boards.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>> ---
> v3: s/CONFIG_SCSI_ENV_PART/CONFIG_SCSI_ENV_PART_UUID
> ---
>   configs/qcs9100_defconfig | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/configs/qcs9100_defconfig b/configs/qcs9100_defconfig
> index 10ff4d25398..cd48973599b 100644
> --- a/configs/qcs9100_defconfig
> +++ b/configs/qcs9100_defconfig
> @@ -14,5 +14,8 @@ CONFIG_DEBUG_UART_CLOCK=14745600
>   # Address where U-Boot will be loaded
>   CONFIG_TEXT_BASE=0xaf000000
>   CONFIG_REMAKE_ELF=y
> -
>   CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs9100-ride-r3"
> +CONFIG_ENV_IS_IN_SCSI=y
> +CONFIG_SCSI_ENV_PART_UUID="71cb9cd0-acf1-b6cb-ad91-be9572fe11a9"
> +# CONFIG_ENV_IS_DEFAULT is not set
> +# CONFIG_ENV_IS_NOWHERE is not set

-- 
Casey (she/they)

