Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB6CFC5DF66
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 16:22:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9C083406A1;
	Mon, 17 Aug 2026 16:22:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LLWAp8hxTh1P; Mon, 17 Aug 2026 16:22:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DB86240637
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786983728;
	bh=Pa7sLVqRq4J7Di0MYjpmnYHNpSfg1rWC0kEzqI8r3eM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LEbA9h9pKQkElub6BJv47Q4ikLBf2pH8wsTokAGcjMzU1+UpDx+YVEKQW4TFucpif
	 i/m+Mq+fOLtPiYScber/VKEPgfuFmtLMeExGs5iClkiMN2JIOA5Yki0fSjXOhqR/gn
	 K4NJxzCrqg58TareKF8fqNSkIfgFzeR5l1oDjD+UwN7Up4g9DwWM5ho7EEiFUxw35E
	 PQOQVSJQVSvsmLvQXY7NUZxQUtoyzMwHy8Ff85mpp759+0n+o5gqqyW2erLFSu+AyO
	 mY5061OYcDduIpnaCNVnA6KIwcf3zByVaXqJGyCbrJYW8tVdFl8nViE1cRBJCPkLQm
	 jZpSWXgidw9QQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DB86240637;
	Mon, 17 Aug 2026 16:22:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 78E4D333
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 16:22:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5ED99405BE
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 16:22:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id suckpmHlGM9J for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 16:22:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=stephan.gerhold@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 4B13D4043E
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4B13D4043E
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=PtuiYn8M
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4B13D4043E
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 16:22:05 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4980dc26022so36843425e9.1
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 09:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786983723; x=1787588523;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Pa7sLVqRq4J7Di0MYjpmnYHNpSfg1rWC0kEzqI8r3eM=;
 b=PtuiYn8M9UXy+3NDsJX0V0cm5ujoQCUGNExWf/xduYKqqeKSr4gRsQnVXEi2T1vwnK
 dWdEqQaEpvTtyyg5vT5iYzU2idmCFDb+Ayuvpvqvl17TwjSERPWhJ8TtNvzqJxyXDIjc
 zjwBaiBLjrm7qS50y0NfOtlPI1MHK8PvH9vF8I4UvRP/Psdr/sU11Aj55jEHuGgRXlBf
 wI0tsLYYdN/4D2vXQJITXvPhdLirrpH9pamry/HsQR3HJI6cFGuxbg2VLqp6sRaQfLaU
 kjcvFCIhg+Xr8Co0yf8LFqD/+U+RgqBkvLjKFp7YH2T9T0mva3+GsjVv8hl5Ex/ZdOM8
 Y9sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786983723; x=1787588523;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Pa7sLVqRq4J7Di0MYjpmnYHNpSfg1rWC0kEzqI8r3eM=;
 b=aJN/sJxbk10SzBpwxPpb8eKG9oRjfC/oKl71IyyYKrOQiRl5yX9W7iVifPoduvy1x6
 dNOahidVsgp5G5Lh7no8278RG8Yf8tnBACmVWTP6bch4tPP+BDAyI7WU0c/XOJYMYXmI
 m6MenHUpOQcQL7VmuXVssFQb8whPTn+0D3zZ/bnAS8NTzxHrwm2ynXc+6AI+Jv5zPQHT
 DaYUtKE8gCjiXmvAd0QjSB29dHoIJ/WMvm1s7UGCg6xjHyyuwObE2WC25vSVF51gHfmu
 BTHghHPVNpq3XQTTvSBqrXMM8bs0Q5X8ODRKUfj0ihS8LhP/IffGCV8I+rku4dy0i+rQ
 uGjg==
X-Gm-Message-State: AOJu0YyVNUXpgMQHQkYoFp+7/GwtERujm/R3OqnsiIGtAZkZXG7tHqwa
 l+wu6JuJHyGI25CK3/ozW/8hINr6jLNlup63rQLH5cFrb0I5x/5r1JlcIwhHA/URljXhr8gdUSe
 mpv6TQlg=
X-Gm-Gg: AR+sD11QAQu9C6SQNpO0rLik7Ch0UIS5R+oh/rCEtFnJGPvvKEszt+vhlWvXCvm1HXt
 Nq0qfEKcQS0urF4bFccHFLu+jxFdLp0fIfDxrtMK4r3jr1NfnS3DqmTMkPNuUcquywFB9mfCVpy
 +Tkq01mO9ihwz2HL20DUKEX/XOnnf+9WChf5pY2AuhXEgFbe1Eewkb7R8szBYZ9DcYSZQbpVOgy
 G6hevbMbj0yFT+RHJEdA6ixDUwwJCVHRGKhNHc03B6MpMYGpbbXT85TZyc2X4V1u+aNR09OAkOc
 HmwG5zjGdcXtUvASp0vK5GvkzTFiNP4NQfIlmqUT5iuBahbFzTQdqAE2ffaKSrfA/9UtXz3mDUK
 LXbJ5pxJuX4GUsKvUAZaaYpqThGXBaghsh846krF0cMhCZtQScmcEPh6AxqQvYYsjJSrELLp9ew
 WfKlW1adiOao3TbDHTPWL87NI2p8RKgvjT7NU/mORIT2YVGI29DzgePZRsjuLFgwMkwnjafQIo
X-Received: by 2002:a7b:c4d0:0:b0:498:1595:be7b with SMTP id
 5b1f17b1804b1-4998792f242mr302880765e9.4.1786983723147; 
 Mon, 17 Aug 2026 09:22:03 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff24:7210:7281:1989:ca4f:c9c9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49981e54b31sm169938785e9.4.2026.08.17.09.22.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 09:22:02 -0700 (PDT)
Date: Mon, 17 Aug 2026 18:21:58 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Linus Walleij <linusw@kernel.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Stefan Hansson <newbyte@postmarketos.org>
Subject: Re: [PATCH v2 4/8] power: regulator: Add AB8500 AUX3 support
Message-ID: <aoM1Jm0wkrtPpbMM@linaro.org>
References: <20260817-ux500-external-sdcard-v2-0-ca9a110bd9c6@kernel.org>
 <20260817-ux500-external-sdcard-v2-4-ca9a110bd9c6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817-ux500-external-sdcard-v2-4-ca9a110bd9c6@kernel.org>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Mon, Aug 17, 2026 at 11:31:53AM +0200, Linus Walleij wrote:
> Add regulator support for LDO AUX3 on AB8500 and AB8505 PMICs.
> AUX3 supplies the removable SD card on the upstream Ux500 Samsung
> device trees, and both PMIC variants use the same control registers.
> 
> Imply the regulator core for ARCH_U8500 so the driver can instantiate
> from the upstream device trees.
> 
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  MAINTAINERS                      |   1 +
>  arch/arm/Kconfig                 |   2 +
>  drivers/power/pmic/ab8500.c      |   1 +
>  drivers/power/regulator/Kconfig  |   7 +++
>  drivers/power/regulator/Makefile |   1 +
>  drivers/power/regulator/ab8500.c | 111 +++++++++++++++++++++++++++++++++++++++
>  6 files changed, 123 insertions(+)
> 
> [...]
> diff --git a/drivers/power/regulator/ab8500.c b/drivers/power/regulator/ab8500.c
> new file mode 100644
> index 000000000000..03beb0834d53
> --- /dev/null
> +++ b/drivers/power/regulator/ab8500.c
> @@ -0,0 +1,111 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/* ST-Ericsson AB8500/AB8505 LDO AUX3 regulator */
> +
> +#include <dm.h>
> +#include <dm/device-internal.h>
> +#include <dm/lists.h>
> +#include <linux/errno.h>
> +#include <power/ab8500.h>
> +#include <power/pmic.h>
> +#include <power/regulator.h>
> +
> +#define AB8500_VAUX3_REGU	AB8500_REGU_CTRL2(0x0a)
> +#define AB8500_VAUX3_SEL	AB8500_REGU_CTRL2(0x21)
> +#define AB8500_VAUX3_EN_MASK	GENMASK(1, 0)
> +#define AB8500_VAUX3_EN		BIT(0)

Nitpick: Can you call this _REGU_EN maybe to make it clear that this
belongs to the REGU register?

> +#define AB8500_VAUX3_SEL_MASK	GENMASK(2, 0)
> +
> +static const int ab8500_vaux3_voltages[] = {
> +	1200000, 1500000, 1800000, 2100000,
> +	2500000, 2750000, 2790000, 2910000,
> +};
> +
> +static struct udevice *ab8500_regulator_pmic(struct udevice *dev)
> +{
> +	return dev->parent->parent;
> +}
> +
> +static int ab8500_regulator_get_value(struct udevice *dev)
> +{
> +	int ret;
> +
> +	ret = pmic_reg_read(ab8500_regulator_pmic(dev), AB8500_VAUX3_SEL);
> +	if (ret < 0)
> +		return ret;
> +	ret &= AB8500_VAUX3_SEL_MASK;
> +
> +	return ab8500_vaux3_voltages[ret];
> +}
> +
> +static int ab8500_regulator_set_value(struct udevice *dev, int uV)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(ab8500_vaux3_voltages); i++) {
> +		if (ab8500_vaux3_voltages[i] == uV)
> +			return pmic_clrsetbits(ab8500_regulator_pmic(dev),
> +					       AB8500_VAUX3_SEL,
> +					       AB8500_VAUX3_SEL_MASK, i);
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int ab8500_regulator_get_enable(struct udevice *dev)
> +{
> +	int ret;
> +
> +	ret = pmic_reg_read(ab8500_regulator_pmic(dev), AB8500_VAUX3_REGU);
> +	if (ret < 0)
> +		return ret;
> +
> +	return (ret & AB8500_VAUX3_EN_MASK) == AB8500_VAUX3_EN;
> +}
> +
> +static int ab8500_regulator_set_enable(struct udevice *dev, bool enable)
> +{
> +	return pmic_clrsetbits(ab8500_regulator_pmic(dev), AB8500_VAUX3_REGU,
> +			       AB8500_VAUX3_EN_MASK,
> +			       enable ? AB8500_VAUX3_EN : 0);
> +}
> +
> +static const struct dm_regulator_ops ab8500_regulator_ops = {
> +	.get_value = ab8500_regulator_get_value,
> +	.set_value = ab8500_regulator_set_value,
> +	.get_enable = ab8500_regulator_get_enable,
> +	.set_enable = ab8500_regulator_set_enable,
> +};
> +
> +U_BOOT_DRIVER(ab8500_ldo_aux3) = {
> +	.name = "ab8500_ldo_aux3",
> +	.id = UCLASS_REGULATOR,
> +	.ops = &ab8500_regulator_ops,
> +};
> +
> +static int ab8500_regulators_bind(struct udevice *dev)
> +{
> +	struct driver *drv = lists_driver_lookup_name("ab8500_ldo_aux3");
> +	ofnode node;
> +
> +	dev_for_each_subnode(node, dev) {
> +		if (!strcmp(ofnode_get_name(node), "ab8500_ldo_aux3"))
> +			return device_bind_with_driver_data(dev, drv,
> +						    ofnode_get_name(node), 0,
> +						    node, NULL);
> +	}

dev_read_subnode(node, "ab8500_ldo_aux3") and
device_bind_driver_to_node() instead of lists_driver_lookup_name() +
device_bind_with_driver_data() should be a bit simpler.

Thanks,
Stephan
