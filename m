Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33352CA0FED
	for <u-boot@archiver.kernel.org>; Wed, 27 Aug 2025 10:46:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34FC283145;
	Wed, 27 Aug 2025 12:46:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gPdF254q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02033831BB; Wed, 27 Aug 2025 12:46:11 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD0338304F
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 12:46:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-afebe21a1c0so128235566b.1
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 03:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756291567; x=1756896367; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3SzmVqXRypbT2x2JISd4y1+7Ixa9iDkjuoq7U1PK4hc=;
 b=gPdF254qUI8KAlFqTF6+Tt5z7j/g7QHi3IAIJhNB5PWoNAENEqFGSzGCRyceU/Ym1n
 IuFG1f/5mmG4ev/a3lTcUCP+Nq5EVkdVBrzKePyiJCRWRqtHr00Wf2qeaOFR0Tj8O5mj
 C1t9lDCApHWx+BR8NqWvjRIqFevO03Gs6Mfl+74qLjwu/gZBnFhQIySAgVPhnbzmF7w9
 zZ2K1e8g1FW7ZHRgSFxNB6kLSr651HfqiUdFFu4O3O6AeZNFUPIFppLTu8qs5hWbUPNY
 y/F3Oa03A4Q+fEx3GHskKAZF8xx/DVgeBKGxot3cTobqmqtF9Mwe1nE0vPazwH3HADTT
 QyBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756291567; x=1756896367;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3SzmVqXRypbT2x2JISd4y1+7Ixa9iDkjuoq7U1PK4hc=;
 b=QVCSbJQOhYXMk2ujHadlSLn4XOaPw8A2XnE8ZGNWhVXQlYRMRJYGk0hnys+I32H+fR
 mIzCkI1Y+CGQNl8er37xt2LlXDhCDA3FZwVhGGRrEuQ9lR9QXiNocg50GUp2skbYZwf6
 e0wj1eH5Mwla1B7pVKJBDzTMF/qsoZM4zlSDaRcPtiycLynu252s4hapY8HDgCYfbpCK
 kk4Oa6f9Va6ZMc+QsdkfSpd8i75vO9T/75ODc0UDbr7DswQDM+R5F0cq6uZpqSnLc/gg
 fKLSUrISbV4474YALTvfJIBNgnx6YwgCdhm3W2dl31VqjQ9QhaJnF9iIdvcrSx5wOh3J
 o4pA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWc140AcJJgVaBVBMrUxXHc+VUQxPf3Sv/yTCKZCdaO33dbTm8E7uoCPM5lZieUutreYUilRJs=@lists.denx.de
X-Gm-Message-State: AOJu0Yw/7tMUjXLx+9jeuMDXpKsEjfUUD+O+xbDP0VoyWrcd9oeKWVkN
 Ph4LOqCAPJiiz/KWcTToIHmUrXmRUswtEftF2Q8ucsDRe0/sfKYuMyLmGIYxNC2bXFs=
X-Gm-Gg: ASbGncv/2OFZm7HF3itlSCLp0tTRDy8GurF5A6eRrfpBdNhimEGahBBFriOJkiZOgiY
 AfQnQ9FIuCRdZIjVafN9/pkSAFu+9dNhn13P938R6V7VPnjnHTkrYon9fL4/zjKYyJ5IsE1s+gU
 23MnHjjYUfOHVNHFpGRtC95Iik0UamV6SGo44+ipy65M+1nazlhLUIhArkTkqlQwkSm0cNhBSDN
 5qaWz3XBjFbbbHoylft2Ep0P4Pzzv+C38bipq9mXCuvrtLgJwWVMhA3jN5H2C5NwmU6iYy8C7Cx
 sPZwiEd2XSlCx1bK59r6BrbGLQG5oRD63EwqTbX6lmj9vWDGm88KCss72uRZx8sbraj/2ZbVsKv
 U8dlxC+mJRpK+QYQOIUqVTgxv0dmeyjEJW7gAbj3fMrE0qGyXKU2PwTbsgIQYgWguwZg1Hg+oc5
 aO
X-Google-Smtp-Source: AGHT+IFcD4Nzsj+syTfyxypaMe3Kses+zW2KtspmB2Oiy/xjtm3R6gBKUi/M4cCBcEjiXKCYgFL1sg==
X-Received: by 2002:a17:907:76b0:b0:afe:764d:6b19 with SMTP id
 a640c23a62f3a-afe764d7251mr871257466b.2.1756291567329; 
 Wed, 27 Aug 2025 03:46:07 -0700 (PDT)
Received: from [192.168.1.36] (p4fc3dd6f.dip0.t-ipconnect.de. [79.195.221.111])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-afeb167670esm290231866b.112.2025.08.27.03.46.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Aug 2025 03:46:06 -0700 (PDT)
Message-ID: <8ea04777-2251-49ca-9e3c-79c46d1cc870@linaro.org>
Date: Wed, 27 Aug 2025 12:46:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: qcom-rpmh-regulator: add support for pm6150l
Content-Language: en-US
To: Jens Reidel <adrian@mainlining.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250826233339.64077-1-adrian@mainlining.org>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250826233339.64077-1-adrian@mainlining.org>
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

Hi Jens,

On 27/08/2025 01:33, Jens Reidel wrote:
> Provides the supplies for SD card on SM7150.
> 
> Signed-off-by: Jens Reidel <adrian@mainlining.org>
> ---
>  drivers/power/regulator/qcom-rpmh-regulator.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/power/regulator/qcom-rpmh-regulator.c b/drivers/power/regulator/qcom-rpmh-regulator.c
> index 954deca5ed7..ac63c50e1d4 100644
> --- a/drivers/power/regulator/qcom-rpmh-regulator.c
> +++ b/drivers/power/regulator/qcom-rpmh-regulator.c
> @@ -493,6 +493,19 @@ static const struct rpmh_vreg_hw_data pmic5_pldo515_mv = {
>  	.supply_name	= _supply_name, \
>  }
>  
> +static const struct rpmh_vreg_init_data pm6150l_vreg_data[] = {
> +	RPMH_VREG("ldo1",   "ldo%s1",  &pmic5_pldo_lv,   "vdd-l1-l8"),
> +	RPMH_VREG("ldo4",   "ldo%s4",  &pmic5_pldo,      "vdd-l4-l5-l6"),

Any reason you skipped ldo2/3? It would be nice to include them for
completeness.

Kind regards,> +	RPMH_VREG("ldo5",   "ldo%s5",  &pmic5_pldo,
"vdd-l4-l5-l6"),
> +	RPMH_VREG("ldo6",   "ldo%s6",  &pmic5_pldo,      "vdd-l4-l5-l6"),
> +	RPMH_VREG("ldo7",   "ldo%s7",  &pmic5_pldo,      "vdd-l7-l11"),
> +	RPMH_VREG("ldo8",   "ldo%s8",  &pmic5_pldo,      "vdd-l1-l8"),
> +	RPMH_VREG("ldo9",   "ldo%s9",  &pmic5_pldo,      "vdd-l9-l10"),
> +	RPMH_VREG("ldo10",  "ldo%s10", &pmic5_pldo,      "vdd-l9-l10"),
> +	RPMH_VREG("ldo11",  "ldo%s11", &pmic5_pldo,      "vdd-l7-l11"),
> +	{}
> +};
> +
>  static const struct rpmh_vreg_init_data pm8150_vreg_data[] = {
>  	RPMH_VREG("ldo13",  "ldo%s13", &pmic5_pldo,      "vdd-l13-l16-l17"),
>  	{}
> @@ -705,6 +718,10 @@ static int rpmh_regulators_bind(struct udevice *dev)
>  }
>  
>  static const struct udevice_id rpmh_regulator_ids[] = {
> +	{
> +		.compatible = "qcom,pm6150l-rpmh-regulators",
> +		.data = (ulong)pm6150l_vreg_data,
> +	},
>  	{
>  		.compatible = "qcom,pm8150-rpmh-regulators",
>  		.data = (ulong)pm8150_vreg_data,

-- 
// Casey (she/her)

