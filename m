Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C61CD8C9D
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 17:01:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B1038466E;
	Mon,  8 Jun 2026 19:01:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dEcVtXZ0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07285846A7; Mon,  8 Jun 2026 19:01:00 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64898841C2
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 19:00:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-bec49f7e35eso621674166b.2
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 10:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780938057; x=1781542857; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YQdKRDGLxWtcVy3dVG4sqJ3R7C9ssUG4+sQ2kF3IHpM=;
 b=dEcVtXZ0GoPo69Q6hIDCHf5W/XUSoG1/paWEOb7V+WY1QpTNfSphdeevRP/aRFqP+I
 BCKiOsF4U01N+bAjQaaKDUhGTxM4kXZKuIf7p2E9OEO3QXlsWLBx/3+k1SyqhaPgnCUK
 B45W8z8rSkPmJFG4Tzn7iSNveW1ty7wXqqO+dQDdj7I1MFY3gqeKj2gLoi7L+BOSEiOg
 OWcIL/O1czaoDvAD4mW8kzDSqtTSAmaboYITg9shPCafq4/MQD/QspweU70tp+BbiFz3
 64+f4oG8QdPCwT6g2itAJ+KJaLwy2m+11FXfFR2L5kEbPcL8ptr5vOPpYmXGF9HrolP0
 nmpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780938057; x=1781542857;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YQdKRDGLxWtcVy3dVG4sqJ3R7C9ssUG4+sQ2kF3IHpM=;
 b=IZMIf0sX1hEbixj6J1i66OYs1FKtgMtA7+rwGA4mfjOaCNxthochYVlRPHJx3DIq7v
 k9Y+j/M1TF6j99H8AW1E7HjGs1+D5GLfk15Va3S6KAwiMPQgFMKocZGaNKOZKhMf2vSd
 R1lkX5/PVxQYYAc7OXBl8K6KgHWCL/L9SPE1NE/S0QYAQ2iVpxw2ZEtjIBKHa9bAlkdG
 N62y9URJDz6f47tijr1EwRu4Nz5w/xdnFFPJNR1gbZfMN8k0wL4LvgaZPe68ZubLa9mw
 0XLS533NwBYGPLSRWEuiuzr243dwWXrPxV2NhGr/wdOIoN3AueHXUTvqhJUAD2vxPBSp
 GKrw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+6FgDGJeyXTOvTYn9bZeVR3EpAhVLFFWcnx92JRisAuw8OBs3zEgFMg2Z490dK5la2q9LroUs=@lists.denx.de
X-Gm-Message-State: AOJu0YwkMLlGXIhah7s0N43jCVtgwX5jOyah75YepY17a2HD5r1SAoWV
 9TVx/v0lkIJ2Lkdm5L8A5CSn8gzzDDH0EnkjupQQoJVOHmPi7HxUyBV25NHOZS0euyo=
X-Gm-Gg: Acq92OHTA6k6kqutdtbDf64B9ggUTI2gb0AwmmLcEsTD9zXPG6rJVMAPIsnAgmyU7+7
 TpNz19I02Yssrcl+Fk550h2eOiwdPipN6GmJa4fGCXur1tXdXjLN4tLpCsmrmajdV/I6IQE+J2x
 mznbxryTNbyqzqxbnvt0P4FZgrszlGyQeYQwqMmLxE0/mAPg99uXmHCsMLBtBf9j3k6/b3ugtbF
 RUrjswwCK4Rn+YK0fsu1nUWPzP4QLNSRiMady3g+TxxdbwZ6oCYQOC9zwIbDuhWmsDOFcVgl342
 PlQPV+AjPzMRMNGTqgdecxcc5Ah3zMM5AbfsG571fiiIsO4kdmu4NbzJ8YiNfI40l4mIjo20pXN
 7hS+7pKy3PpSzx8+B5giOSEmU5mA/HU7jvxXj01Y7HfTsyBtw7J1hG1PuA0eFrkox/HxdzZ/Ig+
 vzJ1lUDrpctzkfQYq12fV/+kMQT+d/6gjcoZIRedIIaH6gXlVF3P9jYJJYZnZ8Vcsue1vJJu4lL
 Q==
X-Received: by 2002:a17:907:94cc:b0:bd8:f4bf:76e2 with SMTP id
 a640c23a62f3a-bf373afb82bmr653512366b.48.1780938056680; 
 Mon, 08 Jun 2026 10:00:56 -0700 (PDT)
Received: from [192.168.1.36] (p5b29e032.dip0.t-ipconnect.de. [91.41.224.50])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-68e64303892sm7454030a12.0.2026.06.08.10.00.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2026 10:00:54 -0700 (PDT)
Message-ID: <9883eec4-84af-41f7-abc6-46531e44e926@linaro.org>
Date: Mon, 8 Jun 2026 19:00:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] gpio: qcom_spmi_gpio: move PM8998 GPIO from legacy
 pmic driver
Content-Language: en-US
To: petr.hodina@protonmail.com, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini
 <trini@konsulko.com>, Rui Miguel Silva <rui.silva@linaro.org>,
 phone-devel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>,
 David Wronek <david.wronek@mainlining.org>,
 Jens Reidel <adrian@mainlining.org>
References: <20260605-qcom-gpio-v2-1-c34093041c66@protonmail.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260605-qcom-gpio-v2-1-c34093041c66@protonmail.com>
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



On 05/06/2026 17:09, Petr Hodina via B4 Relay wrote:
> From: Petr Hodina <petr.hodina@protonmail.com>
> 
> Move the "qcom,pm8998-gpio" compatible from the legacy driver
> qcom_pmic_gpio.c to qcom_spmi_gpio.c. Enables on PM8998-based boards
> (sdm845: SHIFT 6mq, Pixel 3, OnePlus 6, Poco F1, Sony Xperia Akatsuki)
> the Volume UP gpio-key.
> 
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
> ---
> Move the "qcom,pm8998-gpio" compatible from the legacy driver
> qcom_pmic_gpio.c to qcom_spmi_gpio.c. Enables on PM8998-based boards
> (sdm845: SHIFT 6mq, Pixel 3, OnePlus 6, Poco F1, Sony Xperia Akatsuki)
> the Volume UP gpio-key.
> 
> Suggested-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> ---
> Changes in v2:
> - Reworked per Neil Armstrong's suggestion on v1: migrate PM8998 to the
>   modern qcom_spmi_gpio driver instead of extending the legacy
>   qcom_pmic_gpio.c.
> - Dropped "gpio: qcom_pmic_gpio: implement standard pinconf parameters".
> - Dropped "gpio: qcom_pmic_gpio: don't reset pull on direction change".
> - Replaced with a single qcom_spmi_gpio.c patch that claims the
>   qcom,pm8998-gpio compatible.
> - Link to v1: https://patch.msgid.link/20260601-qcom-gpio-v1-0-e24bcdb35da0@protonmail.com
> 
> To: Sumit Garg <sumit.garg@kernel.org>
> To: u-boot-qcom@groups.io
> To: u-boot@lists.denx.de
> Cc: Casey Connolly <casey.connolly@linaro.org>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Rui Miguel Silva <rui.silva@linaro.org>
> Cc: Petr Hodina <petr.hodina@protonmail.com>
> Cc: Luca Weiss <luca.weiss@fairphone.com>
> Cc: David Wronek <david.wronek@mainlining.org>
> Cc: Jens Reidel <adrian@mainlining.org>
> ---
>  drivers/gpio/qcom_pmic_gpio.c | 1 -
>  drivers/gpio/qcom_spmi_gpio.c | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/qcom_pmic_gpio.c b/drivers/gpio/qcom_pmic_gpio.c
> index 4458c55cd3d..6215f794e09 100644
> --- a/drivers/gpio/qcom_pmic_gpio.c
> +++ b/drivers/gpio/qcom_pmic_gpio.c
> @@ -344,7 +344,6 @@ static int qcom_gpio_probe(struct udevice *dev)
>  static const struct udevice_id qcom_gpio_ids[] = {
>  	{ .compatible = "qcom,pm8916-gpio" },
>  	{ .compatible = "qcom,pm8994-gpio" },	/* 22 GPIO's */
> -	{ .compatible = "qcom,pm8998-gpio" },
>  	{ .compatible = "qcom,pms405-gpio" },
>  	{ .compatible = "qcom,pm6125-gpio" },
>  	{ .compatible = "qcom,pm8150-gpio" },
> diff --git a/drivers/gpio/qcom_spmi_gpio.c b/drivers/gpio/qcom_spmi_gpio.c
> index 1a7c7c48dfc..8c3323b23b7 100644
> --- a/drivers/gpio/qcom_spmi_gpio.c
> +++ b/drivers/gpio/qcom_spmi_gpio.c
> @@ -751,6 +751,7 @@ static const struct udevice_id qcom_spmi_pmic_gpio_ids[] = {
>  	{ .compatible = "qcom,pm8550b-gpio" },
>  	{ .compatible = "qcom,pm8550ve-gpio" },
>  	{ .compatible = "qcom,pm8550vs-gpio" },
> +	{ .compatible = "qcom,pm8998-gpio" },
>  	{ .compatible = "qcom,pmk8550-gpio" },
>  	{ .compatible = "qcom,pmr735d-gpio" },
>  	{ }
> 
> ---
> base-commit: 1f89ddd61cd8c27a3dc1fc7edbeccb55d424eb72
> change-id: 20260601-qcom-gpio-98e85ab22647
> 
> Best regards,
> --  
> Petr Hodina <petr.hodina@protonmail.com>
> 
> 

-- 
// Casey (she/her)

