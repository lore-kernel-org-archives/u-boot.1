Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD1E5CD11C2
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 10:00:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BBE488180;
	Wed, 10 Apr 2024 12:00:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Z74xGJWV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B197088180; Wed, 10 Apr 2024 12:00:37 +0200 (CEST)
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com
 [IPv6:2607:f8b0:4864:20::e31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A489587FDD
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 12:00:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe31.google.com with SMTP id
 ada2fe7eead31-479e8e4ab6fso1435163137.0
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 03:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712743234; x=1713348034; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MWPUwM3VNFb/JCEHe/8FtWl/L0IzGPqFr9AL4GwP7RM=;
 b=Z74xGJWVkpO/9ohA9oBdQw15EhEzZv7tMeOBiObYs3fESRyXI2iAgbUTYQcSVZENYe
 ZSlgU3d9daX0uDHJBnTjA+sxFKISLOe5NeTO1AWSadIamq1aaMsurEMXbP8lHnaYejPY
 wbZ+1NP7SOeobEoDMk5pFIz9LwPpTfGCDYU5535bOdSvMHKnjy/+oH4SazG3RKukf6TS
 X5zP9FFyd+hYvvlkWGTpTqORLzNk0IfVXQTAtLaavKPOMQnOYAKw83gAI2W5GX6fsaFW
 L+D2QBL6qJwJMquPaJvDs7xFXaqkt6CzLqFrQi2+EydMiMmbPsYKipmaNFRjCEgIYl37
 u5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712743234; x=1713348034;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MWPUwM3VNFb/JCEHe/8FtWl/L0IzGPqFr9AL4GwP7RM=;
 b=cGVDYU3n8bLstC+ofBljrZRspsq5r8udSs1V/cd3N0KsmZA3VFutzDZ6HhzRMA0+Sl
 0hyNkvJntr/7nBwU+TAtenq+1f9V3a9QNr2Gh4yZMUjHxe9qnxCG1upolhi7SAltLWC9
 +mGLqMGwGX6ZZ/+rhiLgG1l/V1WcbnzMudvAshdPuLT2xr/myKwq9dnjX2jyg0b7o8Jw
 CKJlDPTzX71zxm5wWTiz5Aea8aQ2k6cEL09dNxsjc022193Q0+EGXOUMuU37u1XzPdWo
 yw9pOO3zS7RCeLvXlHS3RvPFo0CshLXyY+Du4FkvDKDs+cQNBzIIi70/SPZGe4bMK0FC
 cVfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlkf9KOGpgSgItGlIdquHxtBnzd8P5hxyi2MJ+KGoxJizALLQ3njD5T7zWcLLYuHU1Ar3Ojzl8fNuPqw7tU0hFnyE0Ag==
X-Gm-Message-State: AOJu0YxXieQ1kDFbY0LNTcng/Hyt5X+41EKwJAO5DLvmBRlhPW5fAQ4J
 U1bQ9P6kYuI0CxD7S7fG10pX/aFAqTGxhDsIYgkaUYQUWOvxN57DT001JBK+7FUMEo/8FIaKf9x
 /ZcGi8uZo3srVUKwUvrYVh1Dw7t3W9Zz0qnjPcg==
X-Google-Smtp-Source: AGHT+IGLUOpz1EVh8yMPLExy3ddeOkZ3T+a1e1TEc3oYxGR64HsQP/ZgEplUBcgQeDhyI6aVQKMPHMaWKJYeAOBbkfw=
X-Received: by 2002:a05:6102:943:b0:47a:2ea3:5353 with SMTP id
 a3-20020a056102094300b0047a2ea35353mr17915vsi.21.1712743234565; Wed, 10 Apr
 2024 03:00:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240405-topic-sm8x50-pinctrl-v1-0-92d563c28c90@linaro.org>
 <20240405-topic-sm8x50-pinctrl-v1-3-92d563c28c90@linaro.org>
In-Reply-To: <20240405-topic-sm8x50-pinctrl-v1-3-92d563c28c90@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 10 Apr 2024 15:30:23 +0530
Message-ID: <CAFA6WYP_-=hhdhhd52K622J5ZK2grfMuqcmW+g4QTy5R5945jg@mail.gmail.com>
Subject: Re: [PATCH 3/3] qcom_defconfig: enable SM8550 & SM8650 pinctrl driver
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 u-boot@lists.denx.de
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

On Fri, 5 Apr 2024 at 13:45, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> Enable the SM8550 & SM8650 pinctrl drivers for Qualcomm defconfig.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  configs/qcom_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
>

Acked-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index 222db6448ab..a92b6ef7911 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -43,6 +43,8 @@ CONFIG_PHY=y
>  CONFIG_PINCTRL=y
>  CONFIG_PINCTRL_QCOM_QCS404=y
>  CONFIG_PINCTRL_QCOM_SDM845=y
> +CONFIG_PINCTRL_QCOM_SM8550=y
> +CONFIG_PINCTRL_QCOM_SM8650=y
>  CONFIG_DM_PMIC=y
>  CONFIG_PMIC_QCOM=y
>  CONFIG_SCSI=y
>
> --
> 2.34.1
>
