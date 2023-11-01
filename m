Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD07CC4167D
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 17:12:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3050B87D47;
	Wed,  1 Nov 2023 18:12:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mf0VDDa9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DED887D5B; Wed,  1 Nov 2023 18:12:21 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADD7287D49
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 18:12:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-670e7ae4a2eso9546796d6.1
 for <u-boot@lists.denx.de>; Wed, 01 Nov 2023 10:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698858732; x=1699463532; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uRuxvJsK/N1oREgCV2uD8VdTs3lvdBwA54CvH8KsMlU=;
 b=mf0VDDa9FhIejZTgg7fRteLjCt7jNlXV0PDfWutFpbITg+Zg4ui1nv4rnsZKH6u/Uy
 n3nosnc5UBl9JuT8rlXRzmBXnhvreSxLOsN3A7MqvW1XQStRcjoagR13uOtQHcIvz7ZL
 /+6p6aH8OfrEdu+C/cWoa96noZZDGUlQT3Up0T4wySUo8Yr0xZdahbf62x+rc2zwaPgy
 xanEVzA3XulLUuoxPAIgv/RfFZJvND6TBboufxnRNAeSIcnFtS5xqfi3QZPbDGe21WKg
 h3oFr/GmUK+M6NHwXBlN2uvlv6DfljYWLnoiRj9K+Lqgs+bczh7fAlK1LPwHWGHvU9Rm
 hg9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698858732; x=1699463532;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uRuxvJsK/N1oREgCV2uD8VdTs3lvdBwA54CvH8KsMlU=;
 b=Y0PyW1Gk23R7CDEr8odl9+wFvBfAi1Q/UMRl+kRB0vu/maiOwyhc7u5K5p3vFmn805
 2eah1R3cxLgychgJGsn14tYvJ9LcqLpBmUJGAAK+uwdTmv647kwQGIu6TFSo55Ou4nWT
 DbMVu38EVb/t8cFN3FXvInndN68MedkZsaaK080p+N/3hD6LuGCMLSVnTEhDqclYjNXW
 0kaKFSraLBHvfDovkFtcJLgHI9Yjrasv1NiFgw/X//GPO9lYpjoEDTtT6HbZ/YaORv/+
 Fl6qiC9xeocC7j0YS5if4iRKNXjZBtTzkgH1Ee1b5LSEyZx2TPoAOVztnWG2uAypDLi3
 KdsA==
X-Gm-Message-State: AOJu0Yz7tdDwh4poMyCMg4G7cK1DV3UT63jbxLSfWqT/wIrOi2vPJrF0
 /YL+LUveaSjWSy/iO5ihHW0=
X-Google-Smtp-Source: AGHT+IEh9pcDdj7MSOdioIiR+CHysM01noGu3l8//+J+dTQNeFosR4AJLog5PEU1ITw+Aw2h9Wcy5Q==
X-Received: by 2002:a05:6214:5c6:b0:66f:ac56:fb9b with SMTP id
 t6-20020a05621405c600b0066fac56fb9bmr4718605qvz.22.1698858732348; 
 Wed, 01 Nov 2023 10:12:12 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 cp13-20020ad44aed000000b0066d32666a20sm1651513qvb.71.2023.11.01.10.12.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Nov 2023 10:12:12 -0700 (PDT)
Message-ID: <d4bc9fbc-d8de-0a72-d8cd-c54dcf5a4d5e@gmail.com>
Date: Wed, 1 Nov 2023 13:12:11 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 3/8] clk: k210: Move soc_clk_dump function
Content-Language: en-US
To: Igor Prusov <ivprusov@sberdevices.ru>, Michal Simek
 <michal.simek@amd.com>, Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Stefan Roese <sr@denx.de>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: prusovigor@gmail.com, kernel@sberdevices.ru,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 uboot-stm32@st-md-mailman.stormreply.com
References: <20231017165649.1492-1-ivprusov@sberdevices.ru>
 <20231017165649.1492-4-ivprusov@sberdevices.ru>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20231017165649.1492-4-ivprusov@sberdevices.ru>
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

On 10/17/23 12:56, Igor Prusov wrote:
> Move clock dump function to avoid forward declaration after switching to
> dump in clk_ops.
> 
> Signed-off-by: Igor Prusov <ivprusov@sberdevices.ru>
> ---
>   drivers/clk/clk_k210.c | 92 +++++++++++++++++++++---------------------
>   1 file changed, 46 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/clk/clk_k210.c b/drivers/clk/clk_k210.c
> index c534cc07e0..2f17152021 100644
> --- a/drivers/clk/clk_k210.c
> +++ b/drivers/clk/clk_k210.c
> @@ -1238,52 +1238,6 @@ static int k210_clk_request(struct clk *clk)
>   	return 0;
>   }
>   
> -static const struct clk_ops k210_clk_ops = {
> -	.request = k210_clk_request,
> -	.set_rate = k210_clk_set_rate,
> -	.get_rate = k210_clk_get_rate,
> -	.set_parent = k210_clk_set_parent,
> -	.enable = k210_clk_enable,
> -	.disable = k210_clk_disable,
> -};
> -
> -static int k210_clk_probe(struct udevice *dev)
> -{
> -	int ret;
> -	struct k210_clk_priv *priv = dev_get_priv(dev);
> -
> -	priv->base = dev_read_addr_ptr(dev_get_parent(dev));
> -	if (!priv->base)
> -		return -EINVAL;
> -
> -	ret = clk_get_by_index(dev, 0, &priv->in0);
> -	if (ret)
> -		return ret;
> -
> -	/*
> -	 * Force setting defaults, even before relocation. This is so we can
> -	 * set the clock rate for PLL1 before we relocate into aisram.
> -	 */
> -	if (!(gd->flags & GD_FLG_RELOC))
> -		clk_set_defaults(dev, CLK_DEFAULTS_POST_FORCE);
> -
> -	return 0;
> -}
> -
> -static const struct udevice_id k210_clk_ids[] = {
> -	{ .compatible = "canaan,k210-clk" },
> -	{ },
> -};
> -
> -U_BOOT_DRIVER(k210_clk) = {
> -	.name = "k210_clk",
> -	.id = UCLASS_CLK,
> -	.of_match = k210_clk_ids,
> -	.ops = &k210_clk_ops,
> -	.probe = k210_clk_probe,
> -	.priv_auto = sizeof(struct k210_clk_priv),
> -};
> -
>   #if IS_ENABLED(CONFIG_CMD_CLK)
>   static char show_enabled(struct k210_clk_priv *priv, int id)
>   {
> @@ -1342,3 +1296,49 @@ int soc_clk_dump(void)
>   	return 0;
>   }
>   #endif
> +
> +static const struct clk_ops k210_clk_ops = {
> +	.request = k210_clk_request,
> +	.set_rate = k210_clk_set_rate,
> +	.get_rate = k210_clk_get_rate,
> +	.set_parent = k210_clk_set_parent,
> +	.enable = k210_clk_enable,
> +	.disable = k210_clk_disable,
> +};
> +
> +static int k210_clk_probe(struct udevice *dev)
> +{
> +	int ret;
> +	struct k210_clk_priv *priv = dev_get_priv(dev);
> +
> +	priv->base = dev_read_addr_ptr(dev_get_parent(dev));
> +	if (!priv->base)
> +		return -EINVAL;
> +
> +	ret = clk_get_by_index(dev, 0, &priv->in0);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Force setting defaults, even before relocation. This is so we can
> +	 * set the clock rate for PLL1 before we relocate into aisram.
> +	 */
> +	if (!(gd->flags & GD_FLG_RELOC))
> +		clk_set_defaults(dev, CLK_DEFAULTS_POST_FORCE);
> +
> +	return 0;
> +}
> +
> +static const struct udevice_id k210_clk_ids[] = {
> +	{ .compatible = "canaan,k210-clk" },
> +	{ },
> +};
> +
> +U_BOOT_DRIVER(k210_clk) = {
> +	.name = "k210_clk",
> +	.id = UCLASS_CLK,
> +	.of_match = k210_clk_ids,
> +	.ops = &k210_clk_ops,
> +	.probe = k210_clk_probe,
> +	.priv_auto = sizeof(struct k210_clk_priv),
> +};

Reviewed-by: Sean Anderson <seanga2@gmail.com>
