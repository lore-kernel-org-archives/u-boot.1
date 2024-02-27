Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0234C48BF6
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 02:49:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70A9D87F6D;
	Tue, 27 Feb 2024 03:49:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FEsX/NYr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6321F87FAA; Tue, 27 Feb 2024 03:49:08 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85D508751B
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 03:49:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-33dd2f0a0c4so1258222f8f.0
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 18:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709002146; x=1709606946; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sK2JO90lQx4DThl4aZ5ms6Swxjj0ndkYBDLHuZOVR+k=;
 b=FEsX/NYrUfvXBBGs8sSfYirv7yCSZTCTzB/NWfu0Q1xkuiZGKAHqn3uOJFvEbivggv
 0q/ORmga4GEOK/4gy9V+nnzgki7zfDKWwPyiDJ7NS/kA7oh76/tDK5eNI2a+vQWsI+pn
 H9+Z1pM08QxZczcQafJLVLgks4TJ17SIreKrgL+ZUY41ihVfd5ETPKpmOKfunkrFE0rY
 6stJW+/IunnzAWPOWwKUmWcOdbeLG9UAAGbMKY9tNMIRCOPrx9EzGHl8nQx06DrenqDM
 FTWmWTguQ1K7m56cRqgQh56GCsCmqUOHZlgaDOGF+uIgf6R5Yld9WLewpqrOjfzmhYAa
 v4hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709002146; x=1709606946;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sK2JO90lQx4DThl4aZ5ms6Swxjj0ndkYBDLHuZOVR+k=;
 b=KhaytNK40lMi+bq+L8mupXcdeFA+Npuk7T8+SY/rKUbAx8qtpOayKBgjN6UvDQCj8g
 V2NH/gGDX6g7R/ftEVAled2UHBcMJxGN6vAde7JP4O6tgttzc4edcv3nZRY5dZATvPvT
 HFHYIsVEZQUk/+DNincYTvDlvbVMl4o/jCSN4KfAtGVtoRjaUj2tqF8BKsiP8gYFXmdc
 FQ0k4/c4odRW1eSYxqbqd+df3/ZsPxfowljSiSEDUhi1aBulXtrIB2PWRcOqXTOnaWyk
 tbAt7avTGEuLcGaXPrSKyjyZCvdDPSko8yEUN5SGWoZmcjGEOA0JTTx8MrQk12g9smWc
 9hXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbeSVqH9bYVcfVSKMS6NSUFLmO+324JG5Mk7MHUSDnWaLBiGmYyvdFHtV1sSzvzhI7qrHrFwNlyG0ojvspK2rUBzOHkw==
X-Gm-Message-State: AOJu0Yz6lC7pzxK79hpkpoEliPvAfBlzs7xlIxqybwJHLwW5FF53DSg0
 c6cjyY2/i6e2uNwXVXh4du55na03Lrxquue9YrCHj3Nfy5FWz8TYr8N9hv0sCnM=
X-Google-Smtp-Source: AGHT+IH1EasV5NgZb/BiZBdVjwtVzivOnaYGkiMO98WZ2k/WiotzDZKg+eXUHIrTS+J2+dqhr1BNgQ==
X-Received: by 2002:a5d:6da8:0:b0:33d:b536:d658 with SMTP id
 u8-20020a5d6da8000000b0033db536d658mr7369291wrs.9.1709002146030; 
 Mon, 26 Feb 2024 18:49:06 -0800 (PST)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 bj20-20020a0560001e1400b0033db0c866f7sm10027559wrb.11.2024.02.26.18.49.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Feb 2024 18:49:05 -0800 (PST)
Message-ID: <ee430e36-7be3-44af-8386-5a0f7c0ea4d1@linaro.org>
Date: Tue, 27 Feb 2024 02:49:05 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] clk/qcom: Include IPQ9574
Content-Language: en-US
To: Varadarajan Narayanan <quic_varada@quicinc.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sean Anderson
 <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>
References: <20240226100807.1095607-1-quic_varada@quicinc.com>
 <20240226100807.1095607-5-quic_varada@quicinc.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240226100807.1095607-5-quic_varada@quicinc.com>
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
> Include the IPQ9574 clock driver into build framework
Please squash this patch into your patch adding the clock driver on the
next revision.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> 
>  drivers/clk/qcom/Kconfig  | 8 ++++++++
>  drivers/clk/qcom/Makefile | 1 +
>  2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 0df0d1881a..73947e1659 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -47,6 +47,14 @@ config CLK_QCOM_SDM845
>  	  on the Snapdragon 845 SoC. This driver supports the clocks
>  	  and resets exposed by the GCC hardware block.
>  
> +config CLK_QCOM_IPQ9574
> +	select CLK_QCOM
> +	bool "Clock controller driver for QTI IPQ9574"
> +	help
> +	  Say Y here to enable support for the Global Clock Controller
> +	  on the IPQ9574 SoC. This driver supports the clocks
> +	  and resets exposed by the GCC hardware block.
> +
>  endmenu
>  
>  endif
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index cb179fdac5..c68abeea9c 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -8,3 +8,4 @@ obj-$(CONFIG_CLK_QCOM_APQ8016) += clock-apq8016.o
>  obj-$(CONFIG_CLK_QCOM_APQ8096) += clock-apq8096.o
>  obj-$(CONFIG_CLK_QCOM_IPQ4019) += clock-ipq4019.o
>  obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
> +obj-$(CONFIG_CLK_QCOM_IPQ9574) += clock-ipq9574.o

-- 
// Caleb (they/them)
