Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF7F606A31C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 13:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rGSjkuLl;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BJdKH9cm
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 093F2408F4;
	Thu, 26 Nov 2026 13:06:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 368TpIG5-qIY; Thu, 26 Nov 2026 13:06:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 45DE6408BD
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795698374;
	b=gLOzpJrCcyT+K9kC8i5K0itqXg/3EHTg0TOtfQ+DaMYa9xDoaz9hztSauEXIwNtEzuHX
	 evJjJ4/vELVjthHS17SiOOKY+uIG9Mk34R6q+tYUgz1igjkUfibny1oi36W4TYUoFgh8E
	 UWCBvXbkoRDb0Nbx5lx7rgthbN9vLtWB5VkvTc5jiDaimB1l9FH9CaMwghWq3Wa3YR+hK
	 PZTjU7rWsiokVRry0/QqghWcC4n+4S8/V5n+XdMbaOzm6/F9NEF7B86ZXbA7uiVNuNmLX
	 Ibq1/kFKsxZKFzevQeLTgclAjXIafNfnb4dzcvUC8mMauDxdlVJiMO3fvSt03QeUWXg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795698374;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=w0Psk/c6x6FPX9xWMZ6bwqhJ6J3+AQBYIA3+EcY9pVU=;
	b=SficWSXRXm2ihBC7vsu+UpC7Xjflf1jR0c0GLeORmIbwkb3ZJOLyVrcX09oqp4lYL6dp
	 ib9BBuMsICJetfjIYO/O+5h7To1Qq5td12FShnDCXqWyADxv3iCGmsScv1GLBNsN0wZps
	 NvTsa9hmDzjj4GmjNCFCfPq6dTmkQWZeUw3l4BaeQ2WI0lklkAduDmt7HdlMJNoz8EaPe
	 N14uYJ1jTQcvUQctLFPsatT16/dBgX/eE0kjd65qIePmz3LEYD3/xlcOoFuK90/KqhKQ/
	 UfUxyjANWnrhoIux9RW28Y7wK805KHDy9K8g4O1TlChTU43kW+wTRXcKHNlWlTFrC8A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795698374;
	bh=w0Psk/c6x6FPX9xWMZ6bwqhJ6J3+AQBYIA3+EcY9pVU=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rGSjkuLl1lrfZ3jybc2LF6iDSlfwuy8CmLixU3NU+fLtwyAzXnrtrMkOCKg6X62mn
	 FM7hzxmwkdtTZjt3R2B5QJK/kzpucEzcBtdgQp1G7JdYf4PJXx+sdbJfaTR9FQ2jfX
	 y01HUv0IG3y1AXr8fMrYNwaZS35+BERI2HJ1Xz2SeAGbtOUIeOXUaESHUttskCiNGs
	 uVNBw7LmMKbkvEHchfX2UKzBTFdN2EeZfWKaEQD+tMQ+Tejj/Xo1fcf4/REV9Nwlrb
	 JRl4CJQ/4Rmqs9LXxkXuXPceTCaEPjChqE0/kfAJdZyti0GWb9zWvdkxl1QVA2d2L/
	 CRV2y6EciuiGA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 45DE6408BD;
	Thu, 26 Nov 2026 13:06:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 528141AB
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:06:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 36FEE404DC
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:06:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f7tQ08P6YdBR for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 13:06:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 921BC404E5
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=sumit.garg@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=BJdKH9cm
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 921BC404E5
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:06:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1D83060F36;
 Thu, 26 Nov 2026 13:06:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A49571F000C4;
 Thu, 26 Nov 2026 13:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795698369;
 bh=w0Psk/c6x6FPX9xWMZ6bwqhJ6J3+AQBYIA3+EcY9pVU=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=BJdKH9cmvVaLeAPmP7JUfHzMbVRCHCZs/kwN3/8bD7AuO4TjPskSn2zYnZYOTSKyH
 cdqRW3almzspaqyLq6KpjS8L+VILlBbgpKJmsa61kG2QjNdVvr1UKdauIKMmOZvCb8
 U2Ae7/dr76iG9oJaHRmffTn5RB7a06P0uvzu1FM8PG9UuyAEtkFqsF/skIPoMc3Ij9
 jXz9s29n6+HRyh/z/CXKMZsLMfzJzYYQRV6fdAKPjPgvAFy2PYv0m2ggHOdkCJzAI3
 LdXXA+G7GyzCeOdi8azW2LhSlKHCqqO2CBjXEbC3sY2rx14EqfAFafjxveUBnLhF/E
 7zSkJ7xBcCrCA==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] gpio: qcom_spmi: Add pmm8654au GPIO subtype support
From: Sumit Garg <sumit.garg@kernel.org>
To: Deepak G <deepak.g10@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.u-boot-project.org, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Petr Hodina <petr.hodina@protonmail.com>, Deepak G <gde@qti.qualcomm.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <20261104-gpio-qcom_spmi-v1-1-2e430ec0843d@oss.qualcomm.com>
References: <20261104-gpio-qcom_spmi-v1-1-2e430ec0843d@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 18:36:04 +0530
Message-Id: <179569836416.130558.5761718211910888134.b4-reply@b4>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-04 15:20 +0530, Deepak G wrote:
> Add the LV_VIN2_CLK (0x14) and MV_VIN3_CLK (0x15) GPIO subtypes,
> which are handled the same as the existing LV_VIN2 and MV_VIN3
> subtypes, and register the "qcom,pmm8654au-gpio" compatible string
> so the pmm8654au PMIC's GPIO controller is probed correctly.

Please be explicit in commit message on "why". Which SoC supports this
controller?

-Sumit

> 
> Taken from linux commit: bfdccbe92e6d ("pinctrl: qcom: spmi-gpio: add support for {LV_VIN2, MV_VIN3}_CLK subtypes")
> 
> Signed-off-by: Deepak G <deepak.g10@oss.qualcomm.com>
> ---
>  drivers/gpio/qcom_spmi_gpio.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpio/qcom_spmi_gpio.c b/drivers/gpio/qcom_spmi_gpio.c
> index d06b9a4b513..8cb9aa0a205 100644
> --- a/drivers/gpio/qcom_spmi_gpio.c
> +++ b/drivers/gpio/qcom_spmi_gpio.c
> @@ -42,6 +42,8 @@
>  #define PMIC_GPIO_SUBTYPE_GPIO_MV		0x11
>  #define PMIC_GPIO_SUBTYPE_GPIO_LV_VIN2		0x12
>  #define PMIC_GPIO_SUBTYPE_GPIO_MV_VIN3		0x13
> +#define PMIC_GPIO_SUBTYPE_GPIO_LV_VIN2_CLK	0x14
> +#define PMIC_GPIO_SUBTYPE_GPIO_MV_VIN3_CLK	0x15
>  
>  #define PMIC_MPP_REG_RT_STS			0x10
>  #define PMIC_MPP_REG_RT_STS_VAL_MASK		0x1
> @@ -398,11 +400,13 @@ static int spmi_pmic_gpio_populate(struct qcom_spmi_pmic_gpio_data *plat,
>  		pad->lv_mv_type = true;
>  		break;
>  	case PMIC_GPIO_SUBTYPE_GPIO_LV_VIN2:
> +	case PMIC_GPIO_SUBTYPE_GPIO_LV_VIN2_CLK:
>  		pad->num_sources = 2;
>  		pad->have_buffer = true;
>  		pad->lv_mv_type = true;
>  		break;
>  	case PMIC_GPIO_SUBTYPE_GPIO_MV_VIN3:
> +	case PMIC_GPIO_SUBTYPE_GPIO_MV_VIN3_CLK:
>  		pad->num_sources = 3;
>  		pad->have_buffer = true;
>  		pad->lv_mv_type = true;
> @@ -757,6 +761,7 @@ static const struct udevice_id qcom_spmi_pmic_gpio_ids[] = {
>  	{ .compatible = "qcom,pm8350c-gpio" },
>  	{ .compatible = "qcom,pmk8350-gpio" },
>  	{ .compatible = "qcom,pmk8550-gpio" },
> +	{ .compatible = "qcom,pmm8654au-gpio" },
>  	{ .compatible = "qcom,pmr735d-gpio" },
>  	{ }
>  };
> 
> ---
> base-commit: b8668aa4114e445d020fcb68a223b7f0af74c1a9
> change-id: 20261103-gpio-qcom_spmi-99ed8334ea98
> 
> Best regards,
> --  
> Deepak G <deepak.g10@oss.qualcomm.com>
> 
> 
> 


