Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D17D0CD98E2
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 13:57:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43200848D8;
	Wed, 17 Jun 2026 15:57:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mwQFnDt0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 680CB849A1; Wed, 17 Jun 2026 15:57:22 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58990846B0
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 15:57:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4903d730b1fso73701515e9.2
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 06:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781704640; x=1782309440; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mSD6oXx4Hr9p3IznKAPMVVApO2My2UNE63qSg7HlHtg=;
 b=mwQFnDt0bY8zDrZnW45IoIZ4e7wQ63hbYQMPRvKxfmtgQWgdlqD2leaAbFJw3mTQnV
 Gmtv2nmBOUJl569EOhsLqUnYoft9FBsmR2g5UDSSVDkoH/VCG5Mctl2zlPPh3meDoQOI
 XSSiuBw6SQ6aYov1keGCF/0a4CpsXJcytdYu8xOABoNNJ66k71fdYD10+QO68W2ag3BB
 KMfNZbs2P+CpMZ+o+empNiRpH+TgrUW4en/fS17gQm0H3Fg/+skuxGHUcobk6lJNLw3V
 RAfhHaAl8QFMk70n745aPc6nss/7IIQOCzuMt5ENjopdikX8Tf78aw4t2mRVGm6lwFbg
 7MvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781704640; x=1782309440;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mSD6oXx4Hr9p3IznKAPMVVApO2My2UNE63qSg7HlHtg=;
 b=FFWfW0MltuXdarnS6gujNeMS952zI0E0UAIWVU0VEpYQurnuhnfCzUSmf2/XKpBlkC
 69ph2AAtoWhc67mc0MkP2Nmebht1HkM9FnHlprZFjy2q2zE2o92WQgLNmUSb2Ome750n
 5fIBP3MqkEClsrJMpSVdXgSA3lGurfpOEBxDb3NgKo0L1o6Qq/xmD8XTeFGokUgfSkNQ
 fkj6jxzH2BwRF2LUJFhA5Jaf5gWrKvZgESA/MfzUsWr0XVeZK11VEpxqh2NNKksQtZFK
 KUoWWJsaVi5V6B8FphyhBnx6urxrfa+0bC5zi/4mm/MqTy65Q7LNLqgJY0n7YOdWFflN
 JJsQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9HAXXeCDBV1tCWqqXHEjKpzyn73tYI8CgAZM6OmJFSoQ3sRdlSRGSWyEfJqQMyRMqHjwo4vww=@lists.denx.de
X-Gm-Message-State: AOJu0Ywul+s9BLrEwUWdwHEW94qTpBZyOEtThI2OMZKn5efQSF1Z/Xaj
 xzblOQr2nGM5PDRlVM8wIfVJaqBYCkWFgIgxvYhPbr02yFKAHsdMOdmDS0sma78CJrQ=
X-Gm-Gg: Acq92OE4DhmVJtFRYDy6/29XlgeiesmQMcLkOz9SIT36dV7lcMeVgwUPFO3odWm9bxh
 QcQcCK3U3g0mA8m7Zap7ALFkutoa8Qp9Bkh+QxLO0JXvCZN5aw1pBsqwa1PmJoCBUOMHMpoqq3I
 RShaq1iMVbZcxDGXY0yXaYkxmDW+q3Y+SMr/AZzL2DupXHtzJcEJ21ylJYzq+UsV0GOqSn1W8aK
 GF24chii20uDTXWFiCs1SIVgtXJ3+pqOONVhbZ7+FzxVzd8xx/MfRMQfYuPQyZ1gt3GdPFwgEsb
 ZrMiOolN7y/M2Rb7n1JVc7lu8G7j0dExAY0i5V6bT55weyE6SsprGFaATDDce/UDUc9Mku6clmB
 MfbI8VHKo5beoc9qiDrublKjjVl698d6JWgPd2LalAcuZZS7cU7ngmK5EUZCqBlLiJ9qFkLkYRC
 RNP7xHyz32nBIWQV1EvkYK1n1mEOdbUgbcUVRAWGG8MpoCwmZRG3yO
X-Received: by 2002:a05:600c:a305:b0:490:b629:286c with SMTP id
 5b1f17b1804b1-492333aa59bmr54370095e9.12.1781704639636; 
 Wed, 17 Jun 2026 06:57:19 -0700 (PDT)
Received: from [192.168.1.36] (p5b29e032.dip0.t-ipconnect.de. [91.41.224.50])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49234daafc7sm46351215e9.10.2026.06.17.06.57.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2026 06:57:19 -0700 (PDT)
Message-ID: <1911bf93-de5f-4b9e-bef8-3cca7fa80374@linaro.org>
Date: Wed, 17 Jun 2026 15:57:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] drivers: misc: pm8916_pon: add glue driver
Content-Language: en-US
To: me@samcday.com, u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Anshul Dalal <anshuld@ti.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Neha Malcom Francis <n-francis@ti.com>, Justin Klaassen
 <justin@tidylabs.net>, Jamie Gibbons <jamie.gibbons@microchip.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 George Chan <gchan9527@gmail.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
 Dmitrii Merkurev <dimorinny@google.com>
References: <20260606-pm8916-pon-v1-0-170c9cbe5099@samcday.com>
 <20260606-pm8916-pon-v1-2-170c9cbe5099@samcday.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260606-pm8916-pon-v1-2-170c9cbe5099@samcday.com>
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



On 06/06/2026 10:47, Sam Day via B4 Relay wrote:
> From: Sam Day <me@samcday.com>
> 
> Initially, this driver binds the existing qcom_pwrkey driver to continue
> supporting pwrkey/resin buttons. In follow-up commits it will be further
> extended to bind a reboot-mode driver.
> 
> The "qcom,pm8916-pon" compatible is removed from qcom_pwrkey, since
> pm8916_pon owns it and handles binding qcom_pwrkey.
> 
> Signed-off-by: Sam Day <me@samcday.com>
> ---
>  drivers/button/button-qcom-pmic.c |  1 -
>  drivers/misc/Kconfig              |  7 ++++
>  drivers/misc/Makefile             |  1 +
>  drivers/misc/pm8916_pon.c         | 78 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 86 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/button/button-qcom-pmic.c b/drivers/button/button-qcom-pmic.c
> index d9ac6a51df5..caa47cd9373 100644
> --- a/drivers/button/button-qcom-pmic.c
> +++ b/drivers/button/button-qcom-pmic.c
> @@ -216,7 +216,6 @@ static const struct button_ops button_qcom_pmic_ops = {
>  };
>  
>  static const struct udevice_id qcom_pwrkey_ids[] = {
> -	{ .compatible = "qcom,pm8916-pon" },
>  	{ .compatible = "qcom,pm8941-pon" },
>  	{ .compatible = "qcom,pm8998-pon" },
>  	{ .compatible = "qcom,pmk8350-pon" },
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index ea785793d18..d2e9b833ff7 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -439,6 +439,13 @@ config SPL_PWRSEQ
>  	  device. When the device is started up, its power sequence can be
>  	  initiated.
>  
> +config PM8916_PON
> +	bool "Enable PM8916 PON driver"
> +	depends on PMIC_QCOM && MISC
> +	help
> +	  The PM8916 PMIC is a multifunction device that handles pwr/resin buttons,
> +	  reboot type (soft/hard/poweroff) and reboot mode (recovery/bootloader).
> +
>  config STM32MP_FUSE
>  	bool "Enable STM32MP fuse wrapper providing the fuse API"
>  	depends on ARCH_STM32MP && MISC
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index e2170212e5a..6b979ba4289 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -92,3 +92,4 @@ obj-$(CONFIG_K3_BIST) += k3_bist.o
>  obj-$(CONFIG_ESM_PMIC) += esm_pmic.o
>  obj-$(CONFIG_SL28CPLD) += sl28cpld.o
>  obj-$(CONFIG_SPL_SOCFPGA_DT_REG) += socfpga_dtreg.o
> +obj-$(CONFIG_PM8916_PON) += pm8916_pon.o
> diff --git a/drivers/misc/pm8916_pon.c b/drivers/misc/pm8916_pon.c
> new file mode 100644
> index 00000000000..d65a7cab459
> --- /dev/null
> +++ b/drivers/misc/pm8916_pon.c
> @@ -0,0 +1,78 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Qualcomm PM8916 PON glue driver
> + *
> + * The PON device handles pwrkey/resin buttons, as well as setting reboot
> + * type and reboot mode. This glue driver binds the respective drivers.
> + */
> +
> +#include <dm.h>
> +#include <dm/lists.h>
> +#include <dm/device_compat.h>
> +#include <power/pmic.h>
> +#include "button/qcom-pmic.h"
> +
> +#define PON_REV2 0x01
> +
> +struct pm8916_pon_priv {
> +	struct udevice *pmic;
> +	phys_addr_t base;
> +	u32 revision;
> +};
> +
> +static int pm8916_pon_probe(struct udevice *dev)
> +{
> +	int ret;
> +	struct pm8916_pon_priv *priv = dev_get_priv(dev);
> +
> +	priv->pmic = dev->parent;
> +	if (!priv->pmic) {
> +		dev_err(dev, "PMIC driver not found\n");

I don't think this can ever be NULL, this check shouldn't be needed.

> +		return -EINVAL;
> +	}
> +
> +	priv->base = dev_read_addr(dev);
> +
> +	if (!priv->base) {

You should compare this to FDT_ADDR_T_NONE, I'd suggest using
dev_read_addr_ptr() here instead.

Kind regards,

> +		dev_err(dev, "missing reg base\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = pmic_reg_read(priv->pmic, priv->base + PON_REV2);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to determine PON rev: %d\n", ret);
> +		return ret;
> +	}
> +
> +	priv->revision = ret;
> +	dev_dbg(dev, "PON rev: %d\n", priv->revision);
> +
> +	return 0;
> +}
> +
> +static int pm8916_pon_bind(struct udevice *dev)
> +{
> +	int ret;
> +
> +	if (CONFIG_IS_ENABLED(BUTTON_QCOM_PMIC)) {
> +		ret = button_qcom_pmic_setup(dev);
> +		if (ret)
> +			dev_warn(dev, "failed to bind qcom_pwrkey: %d\n", ret);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct udevice_id pm8916_pon_ids[] = {
> +	{ .compatible = "qcom,pm8916-pon" },
> +	{},
> +};
> +
> +U_BOOT_DRIVER(pm8916_pon) = {
> +	.name = "pm8916_pon",
> +	.id = UCLASS_MISC,
> +	.of_match = pm8916_pon_ids,
> +	.bind = pm8916_pon_bind,
> +	.probe = pm8916_pon_probe,
> +	.priv_auto = sizeof(struct pm8916_pon_priv),
> +};
> 

-- 
// Casey (she/her)

