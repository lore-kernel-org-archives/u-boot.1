Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A38BD20682
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 22:53:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC1B488A1B;
	Wed, 16 Oct 2024 00:53:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fFsGizV3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B121688A1B; Wed, 16 Oct 2024 00:53:37 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB51288995
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 00:53:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-37d58377339so4686789f8f.1
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 15:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729032814; x=1729637614; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WDTZp4iQSGlXWMYJzpsaZHv9hJlL3KMol4rpQ5EH508=;
 b=fFsGizV3986G8+E1Yo5Qb/Il/dtXrjlV5Fr4TNud8iW1bEHC9qnQKUwuConAN9M63p
 QKypjXaOc+FWfdTvFOczii/s9XOhDtuQ+kTfLStJsGEse8h1yd0mM7EW1+0+Wcbcq647
 XhmS9wnXjCqn2EEBq9cMBSPyaO4mEBiMr7k0iosiquE+MHT8Ax3QNGv773CaIIo5mP3C
 tuE7ivIa4BpxKkZAn/4+vx96IYX0EZ8qxZWUcEldzsQWs5lNBkN7+mCDYzrUxHtm2CTs
 ome4SSRuju0i8UFhGCoc2DP0DNgFpHQ45lJ6s8OYiUy0tCJDi+A/iGN3kEezc7s00bbN
 IXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729032814; x=1729637614;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WDTZp4iQSGlXWMYJzpsaZHv9hJlL3KMol4rpQ5EH508=;
 b=cVOkQV6I8TszZR9NAUUr99UE52pC/GtTos5FJaVBdEcHTj4hqogiMmUwM0rq7TZuFD
 njAwu6tcxVSFGlYTi/xqq5fTB9P4GhHqxCli6cVdyzcq1pXWv2wz4xl9d2YmF4Zy+cPe
 ZFcyt1Ru+lQckzOY6WGKZCRgOT4Vi2ClLoXV8uK5X5jnmsW91qIYuF4i2v2pRW2BivNA
 I3nQtu1jbAZ5gCoDvqmqSxgib83CqTdnf57ggbNrzf9/S5wEHEHmAUxrLl/dFOE49Na/
 vivyXIDc1aqzesqqQXyraMu1H1q4JOzabh/EYQraxdsEMgwt0XlcR9XQVFUjYar1rTZK
 o3HA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSY0odR+4LB3Psv1mEyqljxOL9Kv3Fh5BxJqcu1WXnGFiVXfBe4fax/wGhW9Wg70vM/6tqDSo=@lists.denx.de
X-Gm-Message-State: AOJu0YxswCjv7ULflsiV7gEMNzyIcDLtAURsHNR2aSwicH45jDxjY9kK
 plSdRKMM5u/jAypN6Oy5hgfkmQHXLltTWl7ImqQc3krZKeYBtEAC6iQUg/MRHcE=
X-Google-Smtp-Source: AGHT+IF5WhG71XoNgzaHVhV/QKW8lllbiezHq0gzeRixFv0I8dU0FesnGqPBJs3zhinXE9Ui+X9MJw==
X-Received: by 2002:a05:6000:11ce:b0:37d:3e6d:6a00 with SMTP id
 ffacd0b85a97d-37d600d329cmr12059789f8f.47.1729032814192; 
 Tue, 15 Oct 2024 15:53:34 -0700 (PDT)
Received: from ?IPV6:2a02:8109:888d:ff00::2? ([2a02:8109:888d:ff00::2])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a29816c45sm113550266b.118.2024.10.15.15.53.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Oct 2024 15:53:32 -0700 (PDT)
Message-ID: <29c7385d-e613-4d27-b60f-ca5f692fda65@linaro.org>
Date: Wed, 16 Oct 2024 00:53:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qcom_defconfig: enable UFS Qualcomm controller and PHY
 drivers
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20241014-topic-ufs-qcom-config-v1-1-b33cf11b6adb@linaro.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20241014-topic-ufs-qcom-config-v1-1-b33cf11b6adb@linaro.org>
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



On 14/10/2024 09:00, Neil Armstrong wrote:
> Now the Qualcomm controller and PHY drivers were accepted,
> enable then in the qcom_defconfig file.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   configs/qcom_defconfig | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index ea0dd3e5801..def171150b1 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -77,6 +77,7 @@ CONFIG_DWC_ETH_QOS=y
>   CONFIG_DWC_ETH_QOS_QCOM=y
>   CONFIG_RGMII=y
>   CONFIG_PHY=y
> +CONFIG_PHY_QCOM_QMP_UFS=y
>   CONFIG_PHY_QCOM_QUSB2=y
>   CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2=y
>   CONFIG_PHY_QCOM_SNPS_EUSB2=y
> @@ -114,6 +115,7 @@ CONFIG_USB_GADGET=y
>   CONFIG_USB_GADGET_DOWNLOAD=y
>   CONFIG_USB_FUNCTION_MASS_STORAGE=y
>   CONFIG_UFS=y
> +CONFIG_QCOM_UFS=y
>   CONFIG_VIDEO=y
>   # CONFIG_VIDEO_FONT_8X16 is not set
>   CONFIG_VIDEO_FONT_16X32=y
> 
> ---
> base-commit: 580fb5773634c4a01f907a164b2a05961840b4c0
> change-id: 20241014-topic-ufs-qcom-config-9165ee7ed9bc
> 
> Best regards,

-- 
// Caleb (they/them)

