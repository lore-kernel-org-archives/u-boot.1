Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF129C43458
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 15:42:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CA288496E;
	Fri, 26 Jun 2026 17:42:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PIximi4i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6B5984979; Fri, 26 Jun 2026 17:42:52 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB13E8404D
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 17:42:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so8101375e9.0
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 08:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782488570; x=1783093370; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aj2TNHV7Z4SwaHbc26FN2IPXqmkxDPvwBynrMFWySwQ=;
 b=PIximi4iuHcvjWtF9UPup63ckx1GPp0jynO0luDHa+FOXqU4uwWDSkc2R3ek8SmGka
 Huh0Rpdgs6AuVnIYmJVZNW8xl2enBU9FaCIGbr841ZHgf6V5IJ1N1Paer4O7+UxcxG1n
 UjZY2pkPJHP7sVRZxVLH8fwqjJCC5WG/A3E35hnawV8yBnFCIDDQeYBOfp3cgoXjasgN
 oONr90kzcUDtODAUu+zCupLWA5qx3TKTHHxS7c5z0PdS3KlFjWpFl8OMZwylRqNrBGW8
 3n1GqctZodC/SppRoa+yS179gUCE0gqTX1TPHt4GqaxDTO/Ehrq8HoCnzHG5mDyBqcZ2
 Jxmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782488570; x=1783093370;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aj2TNHV7Z4SwaHbc26FN2IPXqmkxDPvwBynrMFWySwQ=;
 b=dLgFM+SW2rcFePA5jyPlzmKmLBemiPkfWwCQtSPvujkR2ujGRt+q7q8VIEPECoFlFA
 2PVNaRi2XUyBcd16NGz3y09T0bTeY8pV9AEtTc+jqJJrzz1qvYciX9tsb5H8Xe7UCLo9
 CxDT7/RbRcUHfrjKvOsSKr8AzWWBwfnihX5KeUxA7A4oDyilmJwS1iUoZbdOzeeHneFk
 rKxV3+KygJ6WoUKupRXA2rcXOkcy18lZyMrbkDvlY/iVRuroCGubR8YEu9y0+6Q/v3hi
 7SYc34iV5jiFNMHWQIyz0/u9pI7x4a47IWGjRV9R+h+G2e9f0qwIUVcJ9WSTRvroFcnJ
 ySCw==
X-Forwarded-Encrypted: i=1;
 AFNElJ941UoUSLY+hAkkYH9hG+q82P50wQvX0m5UErVnJrCxGIo8NkxS/wcTA2tnbx1WGi764sAjDf4=@lists.denx.de
X-Gm-Message-State: AOJu0YxfQWRl3SjsbvZdPkjhk6H3vdui+YEr9D5E5fxEb42A9Mvu2dGc
 /r1fDJCqxycKm4tY/O5MRxuQsalPIBBpjNPAu7NvSoWIdYTLJwoYbCR5jopbw3K0Tyk=
X-Gm-Gg: AfdE7cl0+WlCCFXjudEZ5AR1qkNV8gRvRI6pklYlytc7UqTP9ynjxYlegFPHssejjix
 3Vg7+QKrfDP+JQeAsEkytfSsOwwDpa1vIyMEmgmHhNDmsci5n8oizJOl0i0rm/sWfk/L3HbJSCm
 QAgIqxRkJBz9KzWbLm8aY6PDFcGUhglBAclP2xtCHa9QT8rlnhrULiN/Tnc6V0tXGtokX/n6cZ5
 KohSUkq51G2G3Xsd2+srzMqHZoIW7qFI5xVAjN3tNHvQGmFOXtzCBL687nmylMUoT7ItK2ZEdZt
 fZCyTpVs2lt27RNpKxszq/o8nEICekZHX30sALERrCMUQASMjWBAEYXM8qts6hBrnGapZzhZKMR
 tw2fZhJ7Y0n0noTjiM3fdL0o3U5Eo73gOVMv8NGcjmyBYXi21WDXgTD3bpxrJuR8jrKdwm7IZm+
 6Oq8d6xeyt8n2epuNJMgR7V5/7TwXxVV6CTKGSUnFDhreq3J/j1GY2ewU1sEAV0AkaxftO
X-Received: by 2002:a05:600c:c1d7:10b0:492:4667:8c40 with SMTP id
 5b1f17b1804b1-492668638c1mr88075725e9.8.1782488570301; 
 Fri, 26 Jun 2026 08:42:50 -0700 (PDT)
Received: from [192.168.1.39] (159.89.222.87.dynamic.jazztel.es.
 [87.222.89.159]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492692d5149sm87519555e9.9.2026.06.26.08.42.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jun 2026 08:42:49 -0700 (PDT)
Message-ID: <fc60aac4-7af0-48fe-8aa8-1f7fb8815e06@linaro.org>
Date: Fri, 26 Jun 2026 17:42:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] clk/qcom: milos: Add TCSRCC clocks
To: Luca Weiss <luca.weiss@fairphone.com>, Sumit Garg
 <sumit.garg@kernel.org>, u-boot-qcom@groups.io, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20260625-milos-ufs-fix-v1-0-b0923dabc35f@fairphone.com>
 <20260625-milos-ufs-fix-v1-2-b0923dabc35f@fairphone.com>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260625-milos-ufs-fix-v1-2-b0923dabc35f@fairphone.com>
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



On 6/25/26 15:14, Luca Weiss wrote:
> With a recent change to the UFS driver, now all clocks need to be
> available. Add all the clocks from the TCSRCC block on Milos.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> ---
>   drivers/clk/qcom/clock-milos.c | 66 ++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 66 insertions(+)
> 
> diff --git a/drivers/clk/qcom/clock-milos.c b/drivers/clk/qcom/clock-milos.c
> index 571cd134f1c..54103adc114 100644
> --- a/drivers/clk/qcom/clock-milos.c
> +++ b/drivers/clk/qcom/clock-milos.c
> @@ -15,6 +15,7 @@
>   #include <linux/bitops.h>
>   #include <dt-bindings/clock/qcom,milos-gcc.h>
>   #include <dt-bindings/clock/qcom,rpmh.h>
> +#include <dt-bindings/clock/qcom,sm8650-tcsr.h>
>   
>   #include "clock-qcom.h"
>   
> @@ -201,3 +202,68 @@ U_BOOT_DRIVER(milos_rpmh_clk) = {
>   	.ops		= &milos_rpmh_clk_ops,
>   	.flags		= DM_FLAG_DEFAULT_PD_CTRL_OFF,
>   };
> +
> +/* TCSRCC */
> +
> +static const struct gate_clk milos_tcsr_clks[] = {
> +	GATE_CLK(TCSR_PCIE_0_CLKREF_EN,		0x31100, BIT(0)),
> +	GATE_CLK(TCSR_PCIE_1_CLKREF_EN,		0x31114, BIT(0)),
> +	GATE_CLK(TCSR_UFS_CLKREF_EN,		0x31118, BIT(0)),
> +	GATE_CLK(TCSR_UFS_PAD_CLKREF_EN,	0x31104, BIT(0)),
> +};
> +
> +static struct msm_clk_data milos_tcsrcc_data = {
> +	.clks = milos_tcsr_clks,
> +	.num_clks = ARRAY_SIZE(milos_tcsr_clks),
> +};
> +
> +static int tcsrcc_milos_clk_enable(struct clk *clk)
> +{
> +	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> +
> +	qcom_gate_clk_en(priv, clk->id);
> +
> +	return 0;
> +}
> +
> +static ulong tcsrcc_milos_clk_get_rate(struct clk *clk)
> +{
> +	return TCXO_RATE;
> +}
> +
> +static int tcsrcc_milos_clk_probe(struct udevice *dev)
> +{
> +	struct msm_clk_data *data = (struct msm_clk_data *)dev_get_driver_data(dev);
> +	struct msm_clk_priv *priv = dev_get_priv(dev);
> +
> +	priv->base = dev_read_addr(dev);
> +	if (priv->base == FDT_ADDR_T_NONE)
> +		return -EINVAL;
> +
> +	priv->data = data;
> +
> +	return 0;
> +}
> +
> +static struct clk_ops tcsrcc_milos_clk_ops = {
> +	.enable = tcsrcc_milos_clk_enable,
> +	.get_rate = tcsrcc_milos_clk_get_rate,
> +};
> +
> +static const struct udevice_id tcsrcc_milos_of_match[] = {
> +	{
> +		.compatible = "qcom,milos-tcsr",
> +		.data = (ulong)&milos_tcsrcc_data,
> +	},
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(tcsrcc_milos) = {
> +	.name		= "tcsrcc_milos",
> +	.id		= UCLASS_CLK,
> +	.of_match	= tcsrcc_milos_of_match,
> +	.ops		= &tcsrcc_milos_clk_ops,
> +	.priv_auto	= sizeof(struct msm_clk_priv),
> +	.probe		= tcsrcc_milos_clk_probe,
> +	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
> +};
> 

