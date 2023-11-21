Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D589FC61D85
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 20:17:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD12187253;
	Tue, 21 Nov 2023 21:17:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ybslxLGR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F432868AE; Tue, 21 Nov 2023 21:17:36 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C1CE87253
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 21:17:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-332ce3fa438so75807f8f.1
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 12:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700597852; x=1701202652; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RwP7E4gLebXTQlzi9tDaHp8L1qS2mrzwPKvfi+053nM=;
 b=ybslxLGRA3NZnlc2gffJ6PFFob4sx3mlkc1zDxvC6CnDeoNTe3Y59e2fvmbo+8hjhA
 46DBZSh3gLqeBb4BChIOWoTB80RUV43xiCN1YAj6oCw22wqWfzO+Te97Ke4OfCUDPF22
 E8TmiK93z68dUl5A0wXY6CyVDdkIEcebKbI/CBQXyV8ykKDtyXzuky2Y2CE960QR7qrN
 tIj3MynDQ59KN1A6XhLeMsjNt0DnTrGizBFFkwp64++kJvbB0u+sJNAX1V+jYvf4qdFL
 CFuSFUUp/PICwC3e+lpvLCJDLupsoTVb5vbi1VErEmeI/7oc6Ox34tGOURDeeQvwWTb7
 Eywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700597852; x=1701202652;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RwP7E4gLebXTQlzi9tDaHp8L1qS2mrzwPKvfi+053nM=;
 b=f7wev6WCcX/b1nse6mFuCDosdYYtxW40DDoHtzzoQHz6UGVbGdd08IVQo2YulLR1GA
 lWRkX6PHCHm33m9S0WLeHU74IJ6yNeUpazZ7RnRU1UoeMujUuLoFKVzZTu5wQj6ggQ8R
 AVIQvRwze+3uGuKl6ybB1D2dabioSA+drNfjvbBhjynqVm6GibB17Ioz7ML1Tl98WQmE
 yIXLbU7K6BQCe7mfEPx1FNOt5SA9qxj51ahpVFv7XWwh/YrUkAiyo9B1M+8+wdINbkAk
 2SUa71oQZ+9H6r2syKvEvMLj1GIl3yyFijlwF7Fo8QTFfGAEblf6MZThXij2NCHFXf+C
 s38g==
X-Gm-Message-State: AOJu0YzkTw0QOS0Zbq/nCTxudOE6yFpTjdpBp9VCZ0ODdyz38gjrrzL2
 QROHa1kDaMsI2siC1bSflrwfWw==
X-Google-Smtp-Source: AGHT+IE0wRI2B2lVovxRvDn94lW3nUEnm1vhQ5fsMuoBCLHJMb1JJo4t93jPRAZjCS+JYNUO05DSjw==
X-Received: by 2002:adf:d1cf:0:b0:32d:8c67:be05 with SMTP id
 b15-20020adfd1cf000000b0032d8c67be05mr261323wrd.22.1700597852320; 
 Tue, 21 Nov 2023 12:17:32 -0800 (PST)
Received: from [192.168.1.7] ([79.79.179.141])
 by smtp.gmail.com with ESMTPSA id
 cg3-20020a5d5cc3000000b00332cdfb0b79sm2951249wrb.84.2023.11.21.12.17.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Nov 2023 12:17:32 -0800 (PST)
Message-ID: <adda70dc-b81e-4684-9ff2-7169af1ce4f3@linaro.org>
Date: Tue, 21 Nov 2023 20:17:30 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/21] arm: allow CONFIG_LINUX_KERNEL_IMAGE_HEADER to be
 set in defconfig
To: Tom Rini <trini@konsulko.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
References: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
 <20231121-b4-qcom-common-target-v1-2-9492198e0c15@linaro.org>
 <20231121190720.GD2513409@bill-the-cat>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20231121190720.GD2513409@bill-the-cat>
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



On 21/11/2023 19:07, Tom Rini wrote:
> On Tue, Nov 21, 2023 at 05:09:25PM +0000, Caleb Connolly wrote:
> 
>> Let this option be enabled dynamically for boards that support multiple
>> mechanisms for booting U-Boot (e.g. as a first-stage or chainloaded
>> bootloader).
>>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>> This patch has no dependencies
>>
>> Cc: Simon Glass <sjg@chromium.org>
>> ---
>>  arch/arm/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index bd48131292e3..1add4282f336 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -81,7 +81,7 @@ config SPL_SYS_NO_VECTOR_TABLE
>>  
>>  config LINUX_KERNEL_IMAGE_HEADER
>>  	depends on ARM64
>> -	bool
>> +	bool "Linux kernel binary header"
>>  	help
>>  	  Place a Linux kernel image header at the start of the U-Boot binary.
>>  	  The format of the header is described in the Linux kernel source at
> 
> Why are we not select'ing this like the other platforms which need the
> same do?

On some Qualcomm boards we can boot either as a Linux kernel or we can
replace the first-stage bootloader. To run as the primary bootloader we
unset this option and enable REMAKE_ELF as well as configuring a few
other things.

Would it make more sense to introduce a Qualcomm specific config option
to handle these cases?

> 

-- 
// Caleb (they/them)
