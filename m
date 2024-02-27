Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 981C3C54E4A
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 03:15:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E42CE87F80;
	Tue, 27 Feb 2024 04:15:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oqUUd1UW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5950B87FAD; Tue, 27 Feb 2024 04:15:23 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 389EA87F7C
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 04:15:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-412a57832fcso11872535e9.1
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 19:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709003720; x=1709608520; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=68aSGmjhHNC8KeeaqxTdKNhRtTQNrFJS+zSvDFkfdMM=;
 b=oqUUd1UWDjvJmraJvCChq4Gf34BBfgnIxJMrHrb6adeXcnpv0BM6e66bKTNuiIpgJL
 NeDJU/NzEojrvj+QagX/pDlqSub3kMfSO1KV1gzCbEJ5MJRKBclPvD5DLIx1vVQl0DSU
 Sj654Y1COXwPwrnNZ3jj8eSbMl+RjuUC7hlRY4MywRivCi+tm/gO+Z+zgeRjHCE10cDF
 qNacwrgubSQu6tjWlVyfD3JjyD71D2uaaCVvfu9htmGHZZ3uL5cMByunUCOongHbL/hc
 2Jkd9lMNJrnft4tlsZddnNRIRL88e0EszO0CyrDWcwXCdsu8sV8+w2VBnj0CmqpJJMsJ
 0KBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709003720; x=1709608520;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=68aSGmjhHNC8KeeaqxTdKNhRtTQNrFJS+zSvDFkfdMM=;
 b=HDhXlGMVoFUDMMBR8Uy2X3aJiHzHxiC7creTxZ4bLcokGrmph21tb98JjszI+kk+Zx
 wt0EIHXNPuCDQHiHzl+AyqQSCKWt4eR8mGLfWO6keacpjSE2D+P/QAFcWpA6NLKLF8hP
 cBgMnXULyJ4SCjY329ICFYpF/TDJ8KDEPqotaxzLdODy3kPW2F7EQXQTCwLSvKjNCkE1
 hDv/hjLf/bEYulFLYi/Rg43IClBmWsAKJqaZ8TXElteFEqHnf72QO2DHpYiAX1EtBY4O
 oO8hkYxhXicEZjGaeMi1zCzlF6kp/Z5RgX8wpmKC9uaI+mRGdvn6IBmpO0/Pbe/H/ySU
 JyzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgHqOWT4V2FcrNnnAaM+3s/sUssxAkwWq+I8BXI9jY2ZIS18vvyDCo9a0Btq6H58TqTxH80Zj7yXG3/n7jJw/x8BGgsA==
X-Gm-Message-State: AOJu0Yw1MCLD3kXUrz9+3OrZiov2hECZihIbgse5ul0WDv+KpKqtiq/E
 Vzqp8kjdWaqJ1rnhC0VKLYJoB8S4lQohqu1/ZS0jXEiPMKwrxl++/8602saprYs=
X-Google-Smtp-Source: AGHT+IFcnWu14nOFAFSWNMORQsWMzuPiCFiXutnVlczpVCrzsxFewOnKe3HH8NnkLcNoDW6NBM7XIg==
X-Received: by 2002:a05:600c:4c92:b0:412:8d27:b757 with SMTP id
 g18-20020a05600c4c9200b004128d27b757mr6215458wmp.37.1709003720597; 
 Mon, 26 Feb 2024 19:15:20 -0800 (PST)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 p7-20020a7bcc87000000b00412656ba919sm13435403wma.20.2024.02.26.19.15.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Feb 2024 19:15:20 -0800 (PST)
Message-ID: <458ee39d-7c04-41df-82aa-1dc37d2fddcc@linaro.org>
Date: Tue, 27 Feb 2024 03:15:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] mmc: msm_sdhci: Reset clocks before reconfiguration
Content-Language: en-US
To: Varadarajan Narayanan <quic_varada@quicinc.com>, u-boot@lists.denx.de
Cc: Jaehoon Chung <jh80.chung@samsung.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>
References: <20240226100807.1095607-1-quic_varada@quicinc.com>
 <20240226100807.1095607-10-quic_varada@quicinc.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240226100807.1095607-10-quic_varada@quicinc.com>
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



On 26/02/2024 10:08, Varadarajan Narayanan wrote:
> U-Boot has to reconfigure the clocks that were set in the boot
> loaders. However, in IPQ9574, the clocks have to be reset before
> they can be reconfigured. Hence add code to do the relevant
> resets.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
With below feedback addressed, please add

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
> 
>  drivers/mmc/msm_sdhci.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
> index 9285d412fe..2e9d521159 100644
> --- a/drivers/mmc/msm_sdhci.c
> +++ b/drivers/mmc/msm_sdhci.c
> @@ -16,6 +16,7 @@
>  #include <asm/global_data.h>
>  #include <asm/io.h>
>  #include <linux/bitops.h>
> +#include <reset.h>
>  
>  /* Non-standard registers needed for SDHCI startup */
>  #define SDCC_MCI_POWER   0x0
> @@ -122,10 +123,19 @@ static int msm_sdc_probe(struct udevice *dev)
>  	struct msm_sdhc *prv = dev_get_priv(dev);
>  	const struct msm_sdhc_variant_info *var_info;
>  	struct sdhci_host *host = &prv->host;
> +	struct reset_ctl bcr_rst;
>  	u32 core_version, core_minor, core_major;
>  	u32 caps;
>  	int ret;
>  
> +	ret = reset_get_by_name(dev, "bcr_rst", &bcr_rst);
reset-names is not not valid according to the DT bindings, please use
reset_get_by_index() instead.
> +	if (!ret) {
> +		reset_assert(&bcr_rst);
> +		mdelay(10);
Is 10ms really necessary here? The equivalent code in Linux suggests
that only 125us are needed (with a 32.7KHz sleep clock) and uses 200us
to be "on the safe side". So maybe udelay(200) here instead?
> +		reset_deassert(&bcr_rst);
> +		mdelay(10);
> +	}
> +
>  	host->quirks = SDHCI_QUIRK_WAIT_SEND_CMD | SDHCI_QUIRK_BROKEN_R1B;
>  
>  	host->max_clk = 0;

-- 
// Caleb (they/them)
