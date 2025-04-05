Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32390C36018
	for <u-boot@archiver.kernel.org>; Sat,  5 Apr 2025 16:02:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A49A82A81;
	Sat,  5 Apr 2025 18:02:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="TxrRHrE2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 525C582A86; Sat,  5 Apr 2025 17:56:14 +0200 (CEST)
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com
 [91.218.175.188])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFEB582A76
 for <u-boot@lists.denx.de>; Sat,  5 Apr 2025 17:56:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexeymin@postmarketos.org
Message-ID: <4429b568-1200-4a6f-a41f-ad6c7905eec5@postmarketos.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1743868570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/ecYQOY0/L6iozEgu25cmAQKawUE8ccf0MC+Q/ZH75c=;
 b=TxrRHrE2Nvlsf3k6tMEHt3XNlIuQqeByIRWvEbRX75Lq9TVsy1Z/amx2/+uAGHNu9zqu5y
 aLvgG2FVk6s8JuKEZH8Ozoq8RbFvJjJ1+s1sIoAHpbZco22uNllziyg+AJhfNUw80OBIgV
 wcrnsCTYDYGzzvl1Ex8oornBTz3MfsGV8CHGFBaMXCub2XOzCE2XjwtgXeGr8aFS1a9ok1
 BoJLnw14j6g3bjIhwudfK+o2G8eIKdtPMXX3zdcw0DUxe+sCPwoSzjax8+q34H++Jxfvn0
 OC63dABv5bMpzw8CBGiMjaIzMKVhu5L/2g7V+t5XqjgDJ6FsZlfPYuJdOm6YYA==
Date: Sat, 5 Apr 2025 18:56:08 +0300
MIME-Version: 1.0
Subject: Re: [PATCH RFC/RFT 1/2] gpio: qcom: add new driver for SPMI gpios
To: u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
References: <20250401-topic-sm8x50-pmic-gpio-pinctrl-new-v1-0-74077ef0b464@linaro.org>
 <20250401-topic-sm8x50-pmic-gpio-pinctrl-new-v1-1-74077ef0b464@linaro.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Alexey Minnekhanov <alexeymin@postmarketos.org>
In-Reply-To: <20250401-topic-sm8x50-pmic-gpio-pinctrl-new-v1-1-74077ef0b464@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Sat, 05 Apr 2025 18:02:30 +0200
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

On 4/1/25 12:47, Neil Armstrong via groups.io wrote:
> The current qcom_pmic_gpio driver is too limited and doesn't
> support state tracking for all pins like the Linux driver.
> 
> Adding full pinconf support would require adding the state
> and it's much simpler to restart from scratch with a new
> driver based on the Linux one adapted to the U-Boot GPIO
> and Pinctrl APIs.
> 
> For now only the PMICs I've been able to validate are
> added in the compatible list but we should be able to
> add the entire list from the Linux driver.
> 
> There's a few difference from the Linux driver:
> - no IRQ support
> - uses the U-Boot GPIO flags that maps very well
> - uses the gpio-ranges to get the pins count
> - no debugfs but prints the pin state via pinmux callback
> 
> It uses the same CONFIG entry as the old one, since
> the ultimate goal is to migrate entirely on this new
> driver once we verify it doesn't break the older
> platforms.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   drivers/gpio/Makefile         |    2 +-
>   drivers/gpio/qcom_spmi_gpio.c | 1034 +++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 1035 insertions(+), 1 deletion(-)
> 

...

> +
> +static const struct udevice_id qcom_spmi_pmic_gpio_ids[] = {
> +	{ .compatible = "qcom,pm8550b-gpio" },
> +	{ .compatible = "qcom,pm8550ve-gpio" },
> +	{ .compatible = "qcom,pm8550vs-gpio" },
> +	{ .compatible = "qcom,pmk8550-gpio" },
> +	{ .compatible = "qcom,pmr735d-gpio" },
> +	{ }
> +};
> +

I've added 2 compatibles here to the top of that list

+       { .compatible = "qcom,pm660-gpio" },
+       { .compatible = "qcom,pm660l-gpio" },

and was able to confirm with "dm tree" that new driver is in use and it 
works fine (Volume Up key works and I'm able to navigate U-Boot menu).

Tested-by: Alexey Minnekhanov <alexeymin@postmarketos.org>

---
Regards,
Alexey Minnekhanov
