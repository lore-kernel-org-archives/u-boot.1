Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2848D75BB9
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 05:12:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 110278964D;
	Thu, 21 Nov 2024 06:12:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="m2EtBAkW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C19A089654; Thu, 21 Nov 2024 06:12:45 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4A8689637
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 06:12:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a9ef275b980so83311166b.0
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 21:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732165963; x=1732770763; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SlZCeTkBlQZ0phJpt2w6i0an0okyhTuApBi3dlDcdHE=;
 b=m2EtBAkW056G1JrrC7MjQIIWgH2C1v+4YGbWhRBnajG6Z83h8+lBiqGJh9hdcJv4O8
 UEJgS28UfJmOEbNXiNQpl3i+mCoUcwFK0AcYL7xsZ9mlsxQeWbffUqieT4d6YBVCOR/+
 RKjeSWPouB9c6JXeSV1ZBawoTlfdoKzzZ2IF7bzolR5gUV5A/qjCiR5gWMLk2V5wtFV0
 l1tBxeG3m/XVKv03Rxpd7H8HgxVBxYPHcu0Uv1zCRHN1o6WwVr245NmPSiSdoMVKZ70R
 4YfoA/+QK/9lS4lmHWp6fe5ZxCv9Z+Uh0H5/BTETYRKfE0zsEqZ11glZm3XPJn3M0bKS
 aSXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732165963; x=1732770763;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SlZCeTkBlQZ0phJpt2w6i0an0okyhTuApBi3dlDcdHE=;
 b=CLw5DUShfeoftB4PtFFCBEIdM0+dE3zpGPFD/ecRtWRiMw7tvb+XOOTbvTiT4Xn4TC
 FLNYEPXPWayAEqZBV9KZs/mFgSatYDy1p9/lKiEyFqWou6LZkxV7yuEJ4mgvv/664+cT
 bopeGors0sf5eOURMdgN0P7B/HUlWM+uV1X/lTGm5H4pzlNXe0JL+UVaRaoZYUd6bI5k
 HLJhgw9w4kbKurcKCdNXC4sli2m2+CK5uSLwmEFH77D3H075RK7ZGXI7oR8W6oVxaaL+
 32N4th4DYziwmgLcC2W2CQjiFuX49bG2HDzviJODUS+fIrMaIuMeMzEFBZwOd6mdjhzg
 xtkA==
X-Gm-Message-State: AOJu0YxqvSBAgnX499rZLMYg/Ww2aEo4kcqQOKnVAq8X9FHYElrvdRCT
 tnJCDxNbehJr+yOReFAbsx2wvRjIlsmNQVP+VU5XcOtpRaTDAB6rRSBZqb69ym8=
X-Google-Smtp-Source: AGHT+IGUqDv57NVXB5GxAHPdIyndli5fpRBLk6sy6cUOeiTqmcrBWTrJoQQKUvYHUfOLisX7PJUv9A==
X-Received: by 2002:a17:907:9392:b0:aa4:e18e:1ca9 with SMTP id
 a640c23a62f3a-aa4e18e1df3mr308278466b.60.1732165963002; 
 Wed, 20 Nov 2024 21:12:43 -0800 (PST)
Received: from ?IPV6:2a02:8109:888d:ff00:ca7f:54ff:fe52:4519?
 ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa4f41537c5sm36328466b.26.2024.11.20.21.12.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Nov 2024 21:12:42 -0800 (PST)
Message-ID: <fe8bbafa-72d1-4e5a-bac7-bf10173c64bd@linaro.org>
Date: Thu, 21 Nov 2024 06:12:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] pinctrl: add support for X1E80100 TLMM
Content-Language: en-US
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini
 <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20241115-topic-x1e80100-pinctrl-v1-0-35f984226e47@linaro.org>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20241115-topic-x1e80100-pinctrl-v1-0-35f984226e47@linaro.org>
Content-Type: text/plain; charset=UTF-8
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



On 15/11/2024 16:44, Neil Armstrong wrote:
> Add support for TLMM in X1E80100, and enable it in qcom_defconfig
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Tested-by: Caleb Connolly <caleb.connolly@linaro.org> # Yoga Slim 7x
Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>

Turns out my UART issue was totally self-invented....

Thanks for sending this!
> ---
> Neil Armstrong (2):
>       pinctrl: qcom: Add X1E80100 pinctrl driver
>       qcom_defconfig: enable X1E80100 pinctrl driver
> 
>  configs/qcom_defconfig                  |   1 +
>  drivers/pinctrl/qcom/Kconfig            |   7 +++
>  drivers/pinctrl/qcom/Makefile           |   1 +
>  drivers/pinctrl/qcom/pinctrl-x1e80100.c | 100 ++++++++++++++++++++++++++++++++
>  4 files changed, 109 insertions(+)
> ---
> base-commit: 56accc56b9aab87ef4809ccc588e1257969cd271
> change-id: 20241115-topic-x1e80100-pinctrl-fb69c767b51b
> 
> Best regards,

-- 
// Caleb (they/them)

