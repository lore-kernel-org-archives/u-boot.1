Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DDBCC4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 14:36:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45B3F8719B;
	Thu,  9 Nov 2023 15:36:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=gerhold.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gerhold.net header.i=@gerhold.net header.b="LRjU04PX";
	dkim=permerror (0-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="SXT4ZGjq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9305F87193; Thu,  9 Nov 2023 15:36:02 +0100 (CET)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de
 [81.169.146.165])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8234D871DF
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 15:35:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=gerhold.net
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=stephan@gerhold.net
ARC-Seal: i=1; a=rsa-sha256; t=1699540558; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=tVXz27QQzg/2vAVrIacfrxunJlckZF5bVXKHtLtH0vbJCuA59FrYRkVLSddKZ6UpmA
 pZL6QAIakaOUI8hRF6TVaegd1PMrFNsNiI9m5zGXL3qtD/WeGuQs+WOz/Ckwao+6VLO5
 50YfnSFa5foG8nHJj67isQhrdiVuoUYUPerZ0+z7LH2w1u46+SsAjluM2mc7VGsB5oLM
 gOgfllMwqZZ8491+EGPwtxBcwwRLocggQTAekfIHf3/Vzl0iK76Ay/atEIwSpR7p/qbO
 cwKmUC9I6t//dqrh8YeemrkQcgIiq42qfY2CZ92EK19/g+BRQYSDxLVdZzDza7bimUqK
 ja1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1699540558;
 s=strato-dkim-0002; d=strato.com;
 h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=PAOVJq+bMWqemhY7hHMJIbV97UuvrhTyL6qYBmRqLkE=;
 b=K/wyEAEGnwDcraN/Yc5TdIz8W/iB4FOjEEcq5JKAqYmddOBytDZo7Xq+T1284mGHDZ
 IqiqI1suis19CuHb2h0+86eJbVdu1LfNQ6Nd+aDcPuoBX8afRmr0N3TKlGRbgehvBuSF
 ILtN/g3kn9oAGnnTGc5ps37s1wAuyHtpzKwkdQI+hrhCOjN0Ub4nYK+iW5RipxCUcnsI
 tZkupPzLsJIjQCARf++vSzHH5ZXQhqStlSFPwScHUuYK6DOlxMm0VmDShwc2JWdUUFWd
 ZcmCiVOxctBgJN+a0Mxcu/NQoz6q00EyLF2v0JP3CL9OIr2++hHEZH5nB56poAJjmsVY
 unHw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1699540558;
 s=strato-dkim-0002; d=gerhold.net;
 h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=PAOVJq+bMWqemhY7hHMJIbV97UuvrhTyL6qYBmRqLkE=;
 b=LRjU04PXfRvEAD8Zp+ODzIRiOFn/iF1FTH0xnaomgEIbfqWqEUdlCW2S1iwWgNwkKy
 LzwCkh4yVqPdDOlVe7JiXLx/Th/LwKnNwY/hO3G6Um0gq9OfUCvWy5j90fesrEFzsXvJ
 lJYTimr2dFwTJgajoOM+6OjIfraZ2jYFPcYszufaFAEePTDafuAWhYwRzyALzBNxfJIS
 03cbUjx6+9VElddBB4yB4ZZ0RFnk0kJJqmvbQBEDGD5QHZB66MWHbphF/oABcDJ6OitV
 je++UwgvMez+Qu5Hz/kKb69UADLFpz7kC/q+h3rlDWew0qUFSk1om6WuR/+ZoRQG37Cl
 jmzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1699540558;
 s=strato-dkim-0003; d=gerhold.net;
 h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=PAOVJq+bMWqemhY7hHMJIbV97UuvrhTyL6qYBmRqLkE=;
 b=SXT4ZGjqAxzJw6y9wY2AptIo5jkV94APLCnueRsQouCjl2dd5+UpAUQYh02eIeOqHy
 TK3ozq3mJ/NexPAaBZAw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA8paF1A=="
Received: from gerhold.net by smtp.strato.de (RZmta 49.9.1 SBL|AUTH)
 with ESMTPSA id Lbb8e2zA9EZwir7
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Thu, 9 Nov 2023 15:35:58 +0100 (CET)
Date: Thu, 9 Nov 2023 15:35:56 +0100
From: Stephan Gerhold <stephan@gerhold.net>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Ramon Fried <rfried.dev@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 3/5] gpio: qcom_pmic: fix support for upstream DT
Message-ID: <ZUzuTFFiz2KdpODs@gerhold.net>
References: <20231108-b4-qcom-dt-compat-v2-0-713233c72948@linaro.org>
 <20231108-b4-qcom-dt-compat-v2-3-713233c72948@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108-b4-qcom-dt-compat-v2-3-713233c72948@linaro.org>
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

On Wed, Nov 08, 2023 at 04:20:55PM +0000, Caleb Connolly wrote:
> Linux devicetrees use the "gpio-ranges" property, add support for
> parsing it instead of "gpio-count" so that upstream DTs can be used with
> U-Boot.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  drivers/gpio/qcom_pmic_gpio.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/gpio/qcom_pmic_gpio.c b/drivers/gpio/qcom_pmic_gpio.c
> index 7b83c67fa464..647d4143ce14 100644
> --- a/drivers/gpio/qcom_pmic_gpio.c
> +++ b/drivers/gpio/qcom_pmic_gpio.c
> @@ -245,11 +245,37 @@ static int qcom_gpio_probe(struct udevice *dev)
>  	return 0;
>  }
>  
> +/*
> + * Parse basic GPIO count specified via the gpio-ranges property
> + * as specified in Linux devicetrees
> + * Returns < 0 on error, otherwise gpio count
> + */
> +static int qcom_gpio_of_parse_ranges(struct udevice *dev)
> +{
> +	int ret;
> +	struct ofnode_phandle_args args;
> +
> +	ret = ofnode_parse_phandle_with_args(dev_ofnode(dev), "gpio-ranges",
> +					     NULL, 3, 0, &args);
> +	if (ret)
> +		return log_msg_ret("gpio-ranges", ret);
> +
> +	return args.args[2];
> +}
> +
>  static int qcom_gpio_of_to_plat(struct udevice *dev)
>  {
>  	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
> +	int ret;
>  
>  	uc_priv->gpio_count = dev_read_u32_default(dev, "gpio-count", 0);
> +	if (!uc_priv->gpio_count) {
> +		ret = qcom_gpio_of_parse_ranges(dev);
> +		if (ret > 0)
> +			uc_priv->gpio_count = ret;
> +		else
> +			printf("gpio-ranges error: %d\n", ret);
> +	}

I would drop support for the non-standard gpio-count and instead adjust
the existing device trees to use gpio-ranges (copied from the upstream
DTs).

>  	uc_priv->bank_name = dev_read_string(dev, "gpio-bank-name");
>  	if (uc_priv->bank_name == NULL)
>  		uc_priv->bank_name = "qcom_pmic";
> 

Maybe you can replace this property as well while you're at it. Perhaps
the default fallback name is sufficient. Alternatively one could
obtain the actual PMIC name from the compatible or similar.

Thanks,
Stephan
