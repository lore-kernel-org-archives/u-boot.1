Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C37D2CD37AC
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 12:27:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FF5083E76;
	Mon, 11 May 2026 14:27:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qBf90MpZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0127383E76; Mon, 11 May 2026 14:27:05 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2848083EF9
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 14:27:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-bcd0111ea98so196502566b.1
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 05:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778502419; x=1779107219; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jGlsJDapRKAGyLt3/h3IdSPD2s47opUQKWYSwinHYmM=;
 b=qBf90MpZVpBNz9DUUQ3vWIv4FuE1SODO1fKHPbEJkiS+EiMBj3LxE0LUB31gDSYdR+
 YN1ldVISaLL45gqpOwo5jY+phY+bBl037opLADgWvKFhtLyXs8FityuBnXQ+PmeWS/bj
 azG81DfvsFwv7xRS6LiR1t6vx6NwbUs8rOA1klrM0cj2uvm1araXMH1VQ4vQZES8VTXQ
 yQME+xTA26ChSfyTPWPxXjndgjpBVIpIwgmsakureuM8IfB5rYscxm/IwchCKa463jlr
 e8FYtVCyh3rFIKFsV5mlhceantVDfctMIWmL/mR4JdFrF53Iy1xKnzzqMaA3/7KuFFb2
 cHzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778502419; x=1779107219;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jGlsJDapRKAGyLt3/h3IdSPD2s47opUQKWYSwinHYmM=;
 b=sLguUxjyMnbgv1z5LeASAiW0U5YWzCEsEQXMzvni2IOmfRDKUFTQTZWMGMX2AEWSKy
 C0o8pg1V/4Rdtx9fHocor6hqUn5wY+7HM0ZVgAETuS4s0L80mOkxIRQBfU9OB/QTq57L
 BEQXgPWQUh/UU+wb0hTC9oZwEzphIfKsH69+JMkGe3hG3ddcKrdgOAwNYKSErMEIa25N
 cyxqFH9qlmLsVezaRzP16ohs8rURbPRgWHokafQZq2tb6oxsLgioNAH0RlmlH8KcFUdM
 0Jtlhekkl/TDk8Ggk01PqTguHaakJrg25CZE4QRR9VOoVbJpfZbqjpDWd+rmA9OjWVIx
 Goiw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+c6rZvJqbJ5djW6Wvs/+UjvrF545fjDDXQO5h4QUvcwuyo1e1atDJERefgVIdke0Doc81HCgc=@lists.denx.de
X-Gm-Message-State: AOJu0Yz7LGzXygPIj/EblaeU8fPVerhUDwCyuUxsUiaNY595OUrCGpFN
 oUnGfgjC/5iTi7PhbAgvwJ6DZGP3ShX97tqM0MDKCm1/++XPrqOwhgdycpgndZh0xVE=
X-Gm-Gg: Acq92OHVVi6FvYLx3QhGqvfCPwIVbHISFksRooEtitWNnRFMbABaPggoo0m2ct3Yt7r
 2wM70/koDXv/ZR1hinTJIvb46pRTxRl41rI+mzANVLW/Vjo8/9Kn+mPryZKSdDzLcYa6zv6QcMx
 0AiBc8Vv6BmdTdM8ThXx328/V5WyYIfMoNnO80tfvhhfHH4za09QRxnPIIpUvQxd9eDdOW96KPY
 Eby6Vaa+cI91/M0OL8EAgN2PCEN+KqZMKmBe29l1Zz75b46AGuR/AV5wsC+L4CfexxGdpQruWD3
 Q1zZUObTzdgpzGcax6M44IyEw9SSP95rPN6qqRZsQrIUkNlRCSAz4GupQxyIesvkXNYAHp4Bltg
 LgQKXlydzMF4j/xvc2wnJDPrMHXsUHAypX2EZCaA4uwuEb/SAZ/1rT2k7MDf68vpSu3qaGDO/og
 vfKrmC4ILk6HuwMJR+24ZTmifjVp/XBvu7ZSnlCuJNbGyWuIsSRqTIRLEjo1wdnIdpEQ==
X-Received: by 2002:a17:907:c988:b0:bd1:c82b:8bae with SMTP id
 a640c23a62f3a-bd1c82b8cbdmr46686566b.45.1778502419461; 
 Mon, 11 May 2026 05:26:59 -0700 (PDT)
Received: from [192.168.1.36] (p4fc3dd86.dip0.t-ipconnect.de. [79.195.221.134])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bcb2882737fsm459381966b.63.2026.05.11.05.26.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 05:26:58 -0700 (PDT)
Message-ID: <40e6cd89-ffae-47ec-b299-af837f6cdb5e@linaro.org>
Date: Mon, 11 May 2026 14:26:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] gpio: qcom: Staticize and constify driver ops
Content-Language: en-US
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: David Wronek <david.wronek@mainlining.org>,
 Jens Reidel <adrian@mainlining.org>, Luca Weiss <luca.weiss@fairphone.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Rui Miguel Silva <rui.silva@linaro.org>, Sumit Garg <sumit.garg@kernel.org>,
 Tom Rini <trini@konsulko.com>, u-boot-qcom@groups.io
References: <20260507220549.209113-1-marek.vasut+renesas@mailbox.org>
 <20260507220549.209113-2-marek.vasut+renesas@mailbox.org>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260507220549.209113-2-marek.vasut+renesas@mailbox.org>
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



On 08/05/2026 00:05, Marek Vasut wrote:
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> ---
> Cc: Casey Connolly <casey.connolly@linaro.org>
> Cc: David Wronek <david.wronek@mainlining.org>
> Cc: Jens Reidel <adrian@mainlining.org>
> Cc: Luca Weiss <luca.weiss@fairphone.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Rui Miguel Silva <rui.silva@linaro.org>
> Cc: Sumit Garg <sumit.garg@kernel.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot-qcom@groups.io
> Cc: u-boot@lists.denx.de
> ---
>  drivers/gpio/qcom_spmi_gpio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/qcom_spmi_gpio.c b/drivers/gpio/qcom_spmi_gpio.c
> index 77a69140213..ae75a4e151d 100644
> --- a/drivers/gpio/qcom_spmi_gpio.c
> +++ b/drivers/gpio/qcom_spmi_gpio.c
> @@ -1020,7 +1020,7 @@ static int qcom_spmi_pmic_pinctrl_pinmux_set_mux(struct udevice *dev, unsigned i
>  	return spmi_pmic_gpio_write(plat, pad, PMIC_GPIO_REG_EN_CTL, val);
>  }
>  
> -struct pinctrl_ops qcom_spmi_pmic_pinctrl_ops = {
> +static const struct pinctrl_ops qcom_spmi_pmic_pinctrl_ops = {
>  	.get_pins_count = qcom_spmi_pmic_pinctrl_get_pins_count,
>  	.get_pin_name = qcom_spmi_pmic_pinctrl_get_pin_name,
>  	.set_state = pinctrl_generic_set_state,

-- 
// Casey (she/her)

