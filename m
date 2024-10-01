Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 277C7CE7D12
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 12:24:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC5D7891AC;
	Tue,  1 Oct 2024 14:24:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Qi7zPDPD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC7DC891AC; Tue,  1 Oct 2024 14:24:42 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3147891A0
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 14:24:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a7aa086b077so801917766b.0
 for <u-boot@lists.denx.de>; Tue, 01 Oct 2024 05:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727785479; x=1728390279; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cpDmIu4G6TXONJFE2YHbhBIVTeWrw3GXdfP1ZYFIqvw=;
 b=Qi7zPDPD69Gmk90t4POxkXz8VcBgGrC2RtreMznmDuCYGNFxzPWMlniJ98U+/TkrvG
 OO6dGZi5y6h7aUG94VfIMBtB2ceVFu5cbqhn7eqysitNokY+ddhkfb50U6fC2gt2Dpk2
 AWmTHRf9JVStn/oIvIUGtFgWc/PRdR9HT7rHyko6bJVaKG2AhejhztoblyRNgPUud6sl
 k1yESWTC4IUT9l7lJvV3DDc9zJZwvXfl1ViO32MgWCVB/sv1GE3+Zg8693j/f5mjuMyq
 u0jvxQeifFxG9Pb51Ey9A3GAGwQJjP1d28BPYooXqgmGwCCMLNhBSur81BwrNosYz3Q8
 nK8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727785479; x=1728390279;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cpDmIu4G6TXONJFE2YHbhBIVTeWrw3GXdfP1ZYFIqvw=;
 b=YL6O3yPpWYNJkAe8K/fzpAw0dZRT1e5oUjfZv3kWf9ouHlsIifDCXEid/61AlHSPOg
 epGmjg8BbYLNO0rVdb/UBlkwmmKLcwSCnGPVoStB+17vxi3opUORvDU2oSlJSpsuSoZ6
 xc1VTFo20b/R3OsCjwTk9QHEkPYBmppbSs2t/09aQK/VpDTs3jalmpHpeAKb8hdjdetT
 9cPvt2BrydmRAjUYgI7AoluiF4h3yYX0Y71PnI+AxjGfQCpDvVtWKngDJE5Ai9OocCrZ
 MiolwYCiVJp0iLbptLhFXc+fmjBM/3uqV2m1Mt+zJMAgtgBt/5ZoHLgUq2GEjy0T4MZe
 puug==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/UMQKBDcSLxyTdE0V/0NckodeqnCU6a5KwakjJ0tFXsAKOmLNIFCzdDrlGidba3YmHNSmd4U=@lists.denx.de
X-Gm-Message-State: AOJu0YyngI7xRF7ynAaEH6tZRO5zxfrQPsd3bOmLMXtORJWVgvmSiVU8
 wH8z98jtjcWXlTFIyc22JuphbqeKp4NJEDST2Tt97pxWLVERJOnc9UXS1s528x/jSV06P3N5JDD
 3
X-Google-Smtp-Source: AGHT+IHxb/1sR90ygzR22L65XqLHCMCM5tyfJ/oURc58vrRLm+4FkFTx2LT3VUefFBGdYWxlNMAEfg==
X-Received: by 2002:a17:907:1c8d:b0:a8a:9054:8399 with SMTP id
 a640c23a62f3a-a93c492f8b7mr1817701566b.27.1727785479021; 
 Tue, 01 Oct 2024 05:24:39 -0700 (PDT)
Received: from ?IPV6:2a0f:5382:acab:1312:9265:84ff:fec9:103a?
 ([2a0f:5382:acab:1312:9265:84ff:fec9:103a])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93c299f5a9sm704575266b.225.2024.10.01.05.24.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Oct 2024 05:24:38 -0700 (PDT)
Message-ID: <ee2e9f46-d2e3-4d91-a140-9fe81859a1dc@linaro.org>
Date: Tue, 1 Oct 2024 14:24:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] cmd: simplify CONFIG_CMD_USB_MASS_STORAGE dependencies
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Lukasz Majewski <lukma@denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
References: <20240921092050.9260-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240921092050.9260-1-heinrich.schuchardt@canonical.com>
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



On 21/09/2024 11:20, Heinrich Schuchardt wrote:
> CONFIG_USB_GADGET_DOWNLOAD depends on CONFIG_USB_GADGET.
> It is sufficient to depend on the prior.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   cmd/Kconfig | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 4ccb0cef390..02b2569e713 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -1685,9 +1685,8 @@ config CMD_ROCKUSB
>   
>   config CMD_USB_MASS_STORAGE
>   	bool "UMS usb mass storage"
> -	depends on USB_GADGET_DOWNLOAD
> +	depends on BLK && USB_GADGET_DOWNLOAD
>   	select USB_FUNCTION_MASS_STORAGE
> -	depends on BLK && USB_GADGET
>   	help
>   	  Enables the command "ums" and the USB mass storage support to the
>   	  export a block device: U-Boot, the USB device, acts as a simple

-- 
// Caleb (they/them)

