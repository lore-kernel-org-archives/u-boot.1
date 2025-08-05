Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3634C87FD1
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 15:16:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07BB683893;
	Tue,  5 Aug 2025 17:16:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wjbrIUVE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81BF48389A; Tue,  5 Aug 2025 17:16:48 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 830F783890
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 17:16:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-458b49c98a7so26058755e9.1
 for <u-boot@lists.denx.de>; Tue, 05 Aug 2025 08:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754407005; x=1755011805; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ui5CLtvUpQj25HJnG7TNUTiVJNepvlC1udo699wqtX4=;
 b=wjbrIUVEZhumH7hEY1EJCa04x//XVjxx7LSCHUsO2BxJRPqtbh610CrZoPTCAUKfLy
 r4Yg+DTRtk83U4rkomJPRdaV9Uyj48NEaL9d6dRtdvgjfOC2b1fbIYpt7XZY06AUfC6E
 9Jp2MTKl51Agzb0JBIUAy2yyx5Yt8nvnJzahfQHWsSCTXhHMuVoHOrZIHHS1SZRC8mgL
 5gCJKkT5WqS0M0dIpDeAgKqD/YlCDRI8OdUJYSHTVIQkMl7W0d06Me/T31dm3qEiSYWY
 E4klNcEdTJlEBJiv28L+DREHZ33Jb6N4C7h1cQq6GWFrlOC9tKZWhK6GiCA7BHWJOBsC
 iWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754407005; x=1755011805;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ui5CLtvUpQj25HJnG7TNUTiVJNepvlC1udo699wqtX4=;
 b=SS2nWYyF5aTG1ygTY8Xu85hXsX7BBWxuBXnshPVmToXy+LXgZALAmhHDwJsU9Kq3Ko
 M1whtIUwk9rBLrmwfTXOiM/QNzz/v/PCp5YS6dfOJAJ3MmqwhzvVy1KZiBNimV6/237+
 u0Gm9VWI7aCV3BQONeWtfgxufyXv0MtPTbJpsjbBW54wzpY/w5DQazdZz78qHJukFEq8
 B1jwHIdxvdE6Usulk14+oY5+2bWduqeBNR899CC1b//ZUGYC1jvpNDX+uQZvFbQKaGeY
 y3vTtThlEri/WqqPfBScq26eBEbJBYSl09xKAzmZ1TThOBFMStjxxkGMnWr+HZSNXVTy
 eLqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPeBXRo4fXLnrBeO3o2q2ACwy5XZ9TDT6igRF5SHTH9TxEnVSmVumOsmuOoDQMnWfTleG70Tw=@lists.denx.de
X-Gm-Message-State: AOJu0Ywc/ue97nPYPV8RuUYj8zP0/FSJCSdDw2xWk0jFLsHXhHU9yR4U
 lqIVxPurb9KxmYJ+MNtaoVaZv5PLe2inSqURZ3RC7QoXnv7jUGGFyQ8rPv53kxoNvpUWY7svy2a
 jXS1y
X-Gm-Gg: ASbGnctOBNToMo6rfkMoD6SSDxIC9zXKhUt/AyNAvUINEopWGoxfix3622wzWyyfCov
 I9uC26ZC3RMnGHHu74K073T4dZTOVx7CrZrWgzuzZATzC+KzVH7bm+ObWtHsa7/SlWYYTXBo7Ng
 OFDV6YXMDtlaYrAPaP8TcQql0JHfue2JR964Kp1aRkYxE3FTa00QbJJODnNUQ330aGAIhAdzSuz
 5D9KCcbXGJOlznxNKVk9h+U84FXu5naV+ChXcWUSKPpWQTjnV9Q3b8DECZRSdAZaIRn9F9XxwiR
 CSULmtQVkpCRtofkYbCItPsZDGGK5Q7GlMsVOU0ZvVhDi4u0zqiLox2kYUvFYmSfPXzDoLMyGss
 sTWp191ZR0kUeOJcoQyKf0BYUT2MDLd+loDplqhOR6SZWvI3kD7BTV2fKkGrGdqg3
X-Google-Smtp-Source: AGHT+IEndd/9UcKKVz9Ajjratsb9SSXxCnw/C1uXWZFd6HLgugsulwtVqsGyv6BmWQm/t9bOsYqB8w==
X-Received: by 2002:a05:600c:3152:b0:455:f187:6203 with SMTP id
 5b1f17b1804b1-458b6b43c8emr94657365e9.27.1754407004859; 
 Tue, 05 Aug 2025 08:16:44 -0700 (PDT)
Received: from [192.168.1.36] (p4fc3de8e.dip0.t-ipconnect.de. [79.195.222.142])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458be70c5f7sm129003965e9.26.2025.08.05.08.16.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Aug 2025 08:16:44 -0700 (PDT)
Message-ID: <e35f3402-5a2a-4133-b944-75da7206b849@linaro.org>
Date: Tue, 5 Aug 2025 17:16:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: Tighten some soc driver dependencies
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20250804215719.1413106-1-trini@konsulko.com>
 <20250804215719.1413106-6-trini@konsulko.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250804215719.1413106-6-trini@konsulko.com>
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



On 04/08/2025 23:57, Tom Rini wrote:
> The Qualcomm Snapdragon "SoC" driver cannot build without access to some
> ARM64 specific functionality. Express that requirements in Kconfig as
> well.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> ---
> Cc: Casey Connolly <casey.connolly@linaro.org>
> ---
>  drivers/soc/qcom/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index 4aa7833930c7..8243805e46a3 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -4,6 +4,7 @@
>  #
>  menuconfig SOC_QCOM
>  	bool "Qualcomm SOC drivers support"
> +	depends on ARM64
>  	help
>  	  Say Y here if you want to enable Qualcomm SOC drivers support.
>  

-- 
// Casey (she/her)

