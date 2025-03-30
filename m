Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B374C28B20
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 14:55:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12A6F8144A;
	Sun, 30 Mar 2025 16:55:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YpsCKUlh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B028081DE3; Sun, 30 Mar 2025 16:55:31 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89B97800C1
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 16:55:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3912c09be7dso2383944f8f.1
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 07:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743346529; x=1743951329; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1SGKUULR+jQLzxQj7bIjcLjqat17DsZLfygcbIpEBy4=;
 b=YpsCKUlh+JwX1z9MTNq88RTa8V3ezGoESRblB1ewY4qmzUEmj94H6NucB3Jhfx4sir
 UMZiIi5tj9394E9tqSc9a9teNhfYctN+9E+XN6ys0MtDyxCCNxJQZnOoMSGftHOCnN9h
 0OwQ6yPR+6cIT4wjwQs1F0uez5wd/XUlVd+7WMlHF3OXy5PpmyieWpb4bfnQEPrFD9sv
 +6uiXh/5LlFOTVaf+RA7vhZfq73baV3HdGg/9slXPP//sUp+8tFpouXktvptyaKf1QUx
 VyJSMwgHvvZ7PpdDSwRoV8fp7z+7sW5+v0exAcVcz2NO1pPUV1Rku3AlVC0XxYgXcZ6Y
 G2bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743346529; x=1743951329;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1SGKUULR+jQLzxQj7bIjcLjqat17DsZLfygcbIpEBy4=;
 b=kpUXIEpshF3nuK/9sNyORcQ0r6Fxt6vrYUAg/4QB2/mMcAZGKjSbFSp8POBF+Gct7m
 QXbYjKMm4cdXcduVzY8j3jYyM6L/GDrtnA45NTqmQXkD8je3Sb/LpstUmULq1kdnAeqn
 U+4Wp90EEnZjTQ+EAr5fNCbu6byqDC7pECxqZoE9Eu1jV2J1x9BKCKF/54AXFYd+UQLw
 OlYGhR2ex+73goh3UE6XIoTb92/pD3mi4CFq9A5rpSXJaMgii7CPFWb2Cy1LwlDDKVc+
 qQKC7FJzwIdLK97xXbX0aL785crf0TPuAF53QwNFVWpnfRfC/dPImWqlrhb35t+UMdqI
 SUPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzeD7lKcoRDps47mZiZfV0OtIjCPuvjy6oXzfpv0tTlN0cvIAieNOj9TIRahikPV2+BKqpDfI=@lists.denx.de
X-Gm-Message-State: AOJu0YyHmIkvN0LMpH3JfUW4cSu1pPQ+O9QQVsdgEcJWSl9PW5UPwBq5
 fen3kFjm0BGL4tYAeNeO7cy+nrWPk6uNNo7nwMji2MhThgqNZYFfvRiG1XXNyL8=
X-Gm-Gg: ASbGncso03Y6/GjjR0HUkkQUvHE2zPHdJQQ9l2muGlNtRdsURPgZjw8Lty44W+Aui+v
 6PghyDphBeolQvrsRf1aBVUAaRt7YW5k5xMyIxoG8X0ZKQY54C5m9JEqtxCaY0C7QDV2dO8k9sH
 MxnU7QO0GsEiKTyKPxR0zC7BE8wLPnMoGUJ+38rCo25eOz/ScPS6UujCo8VeNpFExT7VcL1azGt
 hkbCDPRMQB752lFBIvmccFltORFnaghqNSmp+BMSmg0tFbEiCI+6g6p/2Jr3QAm8iwdaqHUPXRm
 /MxwaQkpM3f+PB4AWTURktmW7ibuKfLB6ZnG4xu0C0ltXHlWBCumag+Y+s/Rf3f2bL2Y61JNHCE
 =
X-Google-Smtp-Source: AGHT+IFEX7Ej/uT1jzewgzL0jUmBfXAFUjw99uqOdiLQD4HPLqXdZJS+i7f8WCfwl6vhAucXQqavYw==
X-Received: by 2002:a5d:6d85:0:b0:391:2dea:c984 with SMTP id
 ffacd0b85a97d-39c120ca4a0mr4619247f8f.11.1743346529018; 
 Sun, 30 Mar 2025 07:55:29 -0700 (PDT)
Received: from [192.168.1.38] (i5E863BED.versanet.de. [94.134.59.237])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b7a41e8sm8876913f8f.92.2025.03.30.07.55.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Mar 2025 07:55:28 -0700 (PDT)
Message-ID: <2a4dfd46-bf93-4cb1-898b-2549ac61c04b@linaro.org>
Date: Sun, 30 Mar 2025 16:55:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] regulator: qcom-rpmh-regulator: add support for
 pmm8654 regulators
To: Varadarajan Narayanan <quic_varada@quicinc.com>, jh80.chung@samsung.com,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, trini@konsulko.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250324113030.2597986-1-quic_varada@quicinc.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250324113030.2597986-1-quic_varada@quicinc.com>
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



On 3/24/25 12:30, Varadarajan Narayanan wrote:
> Add the PMC8380 regulator data found on the Qualcomm SA8775P platform.
> The tables are imported from the Linux driver.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/power/regulator/qcom-rpmh-regulator.c | 45 +++++++++++++++++++
>   1 file changed, 45 insertions(+)
> 
> diff --git a/drivers/power/regulator/qcom-rpmh-regulator.c b/drivers/power/regulator/qcom-rpmh-regulator.c
> index cd2b1a654c1..954deca5ed7 100644
> --- a/drivers/power/regulator/qcom-rpmh-regulator.c
> +++ b/drivers/power/regulator/qcom-rpmh-regulator.c
> @@ -466,6 +466,25 @@ static const struct rpmh_vreg_hw_data pmic5_nldo515 = {
>   	.n_modes = ARRAY_SIZE(pmic_mode_map_pmic5_ldo),
>   };
>   
> +static const struct rpmh_vreg_hw_data pmic5_ftsmps527 = {
> +	.regulator_type = VRM,
> +	.ops = &rpmh_regulator_vrm_drms_ops,
> +	.voltage_range = REGULATOR_LINEAR_RANGE(320000, 0, 215, 8000),
> +	.n_voltages = 215,
> +	.pmic_mode_map = pmic_mode_map_pmic5_smps,
> +	.n_modes = ARRAY_SIZE(pmic_mode_map_pmic5_smps),
> +};
> +
> +static const struct rpmh_vreg_hw_data pmic5_pldo515_mv = {
> +	.regulator_type = VRM,
> +	.ops = &rpmh_regulator_vrm_drms_ops,
> +	.voltage_range = REGULATOR_LINEAR_RANGE(1800000, 0, 187, 8000),
> +	.n_voltages = 188,
> +	.hpm_min_load_uA = 10000,
> +	.pmic_mode_map = pmic_mode_map_pmic5_ldo,
> +	.n_modes = ARRAY_SIZE(pmic_mode_map_pmic5_ldo),
> +};
> +
>   #define RPMH_VREG(_name, _resource_name, _hw_data, _supply_name) \
>   { \
>   	.name		= _name, \
> @@ -558,6 +577,28 @@ static const struct rpmh_vreg_init_data pmc8380_vreg_data[] = {
>   	{}
>   };
>   
> +static const struct rpmh_vreg_init_data pmm8654au_vreg_data[] = {
> +	RPMH_VREG("smps1",  "smp%s1",  &pmic5_ftsmps527,  "vdd-s1"),
> +	RPMH_VREG("smps2",  "smp%s2",  &pmic5_ftsmps527,  "vdd-s2"),
> +	RPMH_VREG("smps3",  "smp%s3",  &pmic5_ftsmps527,  "vdd-s3"),
> +	RPMH_VREG("smps4",  "smp%s4",  &pmic5_ftsmps527,  "vdd-s4"),
> +	RPMH_VREG("smps5",  "smp%s5",  &pmic5_ftsmps527,  "vdd-s5"),
> +	RPMH_VREG("smps6",  "smp%s6",  &pmic5_ftsmps527,  "vdd-s6"),
> +	RPMH_VREG("smps7",  "smp%s7",  &pmic5_ftsmps527,  "vdd-s7"),
> +	RPMH_VREG("smps8",  "smp%s8",  &pmic5_ftsmps527,  "vdd-s8"),
> +	RPMH_VREG("smps9",  "smp%s9",  &pmic5_ftsmps527,  "vdd-s9"),
> +	RPMH_VREG("ldo1",   "ldo%s1",  &pmic5_nldo515,    "vdd-s9"),
> +	RPMH_VREG("ldo2",   "ldo%s2",  &pmic5_nldo515,    "vdd-l2-l3"),
> +	RPMH_VREG("ldo3",   "ldo%s3",  &pmic5_nldo515,    "vdd-l2-l3"),
> +	RPMH_VREG("ldo4",   "ldo%s4",  &pmic5_nldo515,    "vdd-s9"),
> +	RPMH_VREG("ldo5",   "ldo%s5",  &pmic5_nldo515,    "vdd-s9"),
> +	RPMH_VREG("ldo6",   "ldo%s6",  &pmic5_nldo515,    "vdd-l6-l7"),
> +	RPMH_VREG("ldo7",   "ldo%s7",  &pmic5_nldo515,    "vdd-l6-l7"),
> +	RPMH_VREG("ldo8",   "ldo%s8",  &pmic5_pldo515_mv, "vdd-l8-l9"),
> +	RPMH_VREG("ldo9",   "ldo%s9",  &pmic5_pldo,       "vdd-l8-l9"),
> +	{}
> +};
> +
>   /* probe an individual regulator */
>   static int rpmh_regulator_probe(struct udevice *dev)
>   {
> @@ -688,6 +729,10 @@ static const struct udevice_id rpmh_regulator_ids[] = {
>   		.compatible = "qcom,pmc8380-rpmh-regulators",
>   		.data = (ulong)pmc8380_vreg_data,
>   	},
> +	{
> +		.compatible = "qcom,pmm8654au-rpmh-regulators",
> +		.data = (ulong)pmm8654au_vreg_data,
> +	},
>   	{ /* sentinal */ },
>   };
>   
> 
> base-commit: 244e61fbb7f5045e4e187024f7ae80434c952145

-- 
Caleb (they/them)

