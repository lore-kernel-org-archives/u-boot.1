Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 682BFC3DA6D
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 20:04:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9264F82C87;
	Tue, 20 May 2025 22:03:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FfouAXDP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D328782B7C; Tue, 20 May 2025 22:03:57 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C83B382B7C
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 22:03:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-442f4a3a4d6so39244985e9.0
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 13:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747771435; x=1748376235; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FvaAvhL8wynaBF2PKaDUQwfVFkh8mB4LVx6SFjPKSM4=;
 b=FfouAXDP26tiOCO1dtUlzJLH+1mfwh5XI3/Tb6jYtyb94sL3cPSGhSQTwIZbZz0ehb
 KnZ/XdjLHD9s64x0UOE1n5sMQMT2FHxrTHArDOVFR427tCAsTsVsyNr/SI07oN/dOQi1
 tsEBVFDE/egylizkkYQlEI0oLTkqz1jgpEGeBUXgOs7kcZsAyaGmYksTm0ICqCX2rm+Y
 ZlK94yjDRa+uGru5Ad/H6xixJ3gUpzF+mIFzZhTMZhgvktX5dYzUeJAYm1zsOV9T9sqG
 RK6J1cZnbq90zQEqwoMve49EnZzT5hVYm6L2Enbf7prmVod3Zmth1G0dsWhnnjAsMqZY
 QxLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747771435; x=1748376235;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FvaAvhL8wynaBF2PKaDUQwfVFkh8mB4LVx6SFjPKSM4=;
 b=v0kmAkHr3EKZVDmC1/9fOtfqSMa7ln82GYOgi31UDNvHqUhW/I8evR6DdKHuL5eTO8
 ZS44qrOBE+3Z6A1rV+MkTIIN6bcpLN9KYmv89CvLA28piKp0OO+t4Qwgwb+CbBWkQqGm
 UcxgPWGXqse/yhy9sLlClYMS0rfKeL3AaEdyZQwTOejVSlE400ps5RaPqNatzzX0CpSa
 efapH++baVQZHka5Y8P40iMYdFRX8bxqpK14GnmBwSaaivCrM9uooUyLtrGfgHaIPXTG
 7Ur7DPx6Ks3gNNsVxhTHhapR+ZXjbqFYzoKcClkU8U/wwCeIfXBiXrLY6qFpiJr6d1Qv
 RQWQ==
X-Gm-Message-State: AOJu0YzTstgzgwqXMLSZ8GX1G/UVmlVhEGjAbsCmfMPSeehwV0XTLziu
 sDLPMhyWE0/Vj3k6/4ReCmyTUkVUG1D/47sfwpAJD/1MB6uoV4ikJTilBu1SF4QPlrk=
X-Gm-Gg: ASbGnctlt079jZbh1LXNTWodVvPi4I0IeUnUTxNe/9zdCBGCT1Sr2NMAXiiuIBZaiia
 i+W8CPAAM2J5i0jKzYl8JeEY8ffU+zAag1Ih+bkK+fnnRKQRdt/sIPvcvrvrcSYfANib58PwVhZ
 Q95P/bvVetatb1PE0nWDClkvuisng4dnBkd2rK2hyHQ07KoQwIfJTVy8KUQaLW+uhmdfCvWqEI/
 8pTnB9kN6yhL9Eq0zeQVGh/nByT8iVXTKHPoaQ6h/oIRdNkZSbUEyeHDmHsh3nJEtyzqDLLH799
 qzOOL4GoIaFgTRnCjhBlYxrgEG58rMev+UXtKrPUQRRh+4NaycwmjN1mSKHinyyY1EQxOcxLYCW
 eO6iFCi5OGx98dNs4gy63+XgrHfc6QNk=
X-Google-Smtp-Source: AGHT+IFrTfKv0NG3AzJFxrX/OSblJkZHgLaM+uJDABxRBiPUgdZ0Itc2U7JfoqOKCzJrlz+vOeIaBQ==
X-Received: by 2002:a05:600c:3d07:b0:442:f904:1305 with SMTP id
 5b1f17b1804b1-442fd93d54emr165817785e9.6.1747771435232; 
 Tue, 20 May 2025 13:03:55 -0700 (PDT)
Received: from ?IPV6:2001:818:dd7b:1900:4a4e:99d7:b164:548a?
 ([2001:818:dd7b:1900:4a4e:99d7:b164:548a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f7bae3b9sm41279495e9.33.2025.05.20.13.03.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 May 2025 13:03:54 -0700 (PDT)
Message-ID: <477a8226-83a1-49b6-abd9-12fd9bc49e0b@linaro.org>
Date: Tue, 20 May 2025 21:03:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] iommu: qcom-smmu: Introduce sc7180 compatible string
To: gchan9527@gmail.com, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io,
 Vitalii Skorkin <nikroks@mainlining.org>
References: <20250520-sc7180-android-boot-v1-0-3075a84ea094@gmail.com>
 <20250520-sc7180-android-boot-v1-2-3075a84ea094@gmail.com>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250520-sc7180-android-boot-v1-2-3075a84ea094@gmail.com>
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



On 5/20/25 15:25, George Chan via B4 Relay wrote:
> From: George Chan <gchan9527@gmail.com>
> 
> Add basic compatible string for sc7180 family soc.
> 
> Signed-off-by: Vitalii Skorkin <nikroks@mainlining.org>
> Co-developed-by: George Chan <gchan9527@gmail.com>
> Signed-off-by: George Chan <gchan9527@gmail.com>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> ---
>   drivers/iommu/qcom-hyp-smmu.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/qcom-hyp-smmu.c b/drivers/iommu/qcom-hyp-smmu.c
> index c1b95bc8b8c..2a356613a26 100644
> --- a/drivers/iommu/qcom-hyp-smmu.c
> +++ b/drivers/iommu/qcom-hyp-smmu.c
> @@ -388,6 +388,7 @@ static struct iommu_ops qcom_smmu_ops = {
>   
>   static const struct udevice_id qcom_smmu500_ids[] = {
>   	{ .compatible = "qcom,sdm845-smmu-500" },
> +	{ .compatible = "qcom,sc7180-smmu-500" },
>   	{ .compatible = "qcom,sc7280-smmu-500" },
>   	{ .compatible = "qcom,smmu-500", },
>   	{ /* sentinel */ }
> 

-- 
Casey (she/they)

