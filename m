Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AD321091912
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 19:51:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A11B83F00;
	Thu, 19 Mar 2026 20:51:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nPtW89gW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87E8483F2E; Thu, 19 Mar 2026 20:51:45 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37E9083E36
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 20:51:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4852c9b4158so9672855e9.0
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 12:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773949902; x=1774554702; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yHV2oZiVmPbUngfY0rE4aQTkS1Nu2OCbdhsnflpnkT8=;
 b=nPtW89gW1XCeQ77tTojK0DmqetoxhSoYpZ+hJby+ySVse5skB3bXsekcvsLbOdI/Q/
 DH+0mU0nf3lbkN09Vz4w3sV46/1vmdOpYY8kZYGwmo8XnYSwYDkJJSNdWa+TjQ4H0FTn
 QjSOX2D1qsQpEgddp0mQnSCbLySq2vruykZohfq/0N5obMVOQFHnNWTsof1W3+irBGav
 PgKLQfkhvMZvfA3rdgOwVLqeI1GiK9vdc1/oIbfePYWkhOyiaL/k6HgOxX7gXEYgIOZd
 /12YrfBJIuX0P2si6VPTOZxRuFluR1VCZALMJuIQL9EgVfN/HOyDIf7qIdG3SWhg4sT/
 vGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773949902; x=1774554702;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yHV2oZiVmPbUngfY0rE4aQTkS1Nu2OCbdhsnflpnkT8=;
 b=HEhO3Gpqi60l1tF27ogKaXHPm4XgU0BOQMdWZBdD+I4UVwl2XbUCvKbRyucL7T6bye
 0MOHXNOjsyiAS9mFT9OmyUJp20e6nXvaHe6OTiDuqNlsOJfHnTUXsQRdXyLg32X/MJuG
 sUQ+B9iIAv7lz4SaDi+chl/SyBtWj/kolUHDkVnp+aw5VzXNSKCDP3ue3k7VvXQhp1nT
 W04Ezn3o39Yoo0Oz2uBRgTZyp71XS9iBwDi35MqulDoODxCs9YkkJEtFyK2qgrOK+1Ev
 sqHgVVJe4lGy28R+rZv4YKcSd+R0fMbINvUiy1olXACqOMZqOS/ZWUiUvzxpjTFqnBAp
 82Nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDxAsdwHi4pm2zECXMQ6GqByFHMzKEIXKmbABnwL14HY5B5/VMdwQ4PfNYsK8MRcZsj66Gfp0=@lists.denx.de
X-Gm-Message-State: AOJu0Yym6wNUN25y7ZF4qjnRooRALrl3XNIjsNcIbEQ7lS/86Md0IVgd
 Kbaz+pq1xvFnVpheHwRFyS7j7dj5Bte89TCff9R0BeHt+7DxXXsDA8hE8ZMeItxRf5I4XBHDl42
 t27s1
X-Gm-Gg: ATEYQzzSh6FiaK1sIPx0QtP1WZMBwktWt7VT1Bun5mibOHKxSObxh5FmpiZmF6Gjn8Q
 x4BcPRJ5hWVJLPEQ6bIy4A8MrK0Z0Fo1mQPX069WqLDU5Dz5pDXorFlfRM57jpffIP3O7gEN+HD
 gasJjkLZWcAYCwAY4Qa+L/DhhP1u5pnTz3N0FWA+WwdmMXFDLZdBnLBfKxmsIGuIhZkj+xgEh27
 cIv8XokdFt3bX1mq6BrqcHg0dVFteiATPQemlJeJ6DJjoctRfM9uFXAbWDUmv6kbTs7Oj1vkVtb
 GXHJ8TIeV1ix+dftty1TzofBckN5zCZ7//H5FwCeCtkqpTG1FDILCFKZD4uy9y95ddf4DIFuH6J
 I87ZfJkdeO1PcOaDVC/600LfCLUP0CfOANlHrM7sDzgMfwkPhM+QTsCuKYmTpNwX5CUKIIk0iQQ
 iyPZganjSpUAHRHCOU6n5+npfbUcbQr5u2owKBn7ktyt+RUE1lfv5qsIAOAdXISZX6
X-Received: by 2002:a05:600c:c173:b0:485:5981:1411 with SMTP id
 5b1f17b1804b1-486fee1a26bmr4748235e9.23.1773949902470; 
 Thu, 19 Mar 2026 12:51:42 -0700 (PDT)
Received: from [192.168.1.36] (p4fc3dd39.dip0.t-ipconnect.de. [79.195.221.57])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486ff1e6029sm1374795e9.9.2026.03.19.12.51.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2026 12:51:41 -0700 (PDT)
Message-ID: <c162837f-2443-4642-b994-704b35c3c24c@linaro.org>
Date: Thu, 19 Mar 2026 20:51:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] misc: Correct dependencies on QCOM_GENI
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260317012439.4162568-1-trini@konsulko.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260317012439.4162568-1-trini@konsulko.com>
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



On 17/03/2026 02:24, Tom Rini wrote:
> As exposed by "make randconfig", we have an issue with the dependencies
> for QCOM_GENI. The symbol PARTITION_TYPE_GUID depends on EFI_PARTITION
> and this driver cannot function without both being set, so select that
> as well.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> ---
> Cc: Casey Connolly <casey.connolly@linaro.org>
> ---
>  drivers/misc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 798f1dbf26cf..b2dfc7f5b663 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -86,6 +86,7 @@ config GATEWORKS_SC
>  config QCOM_GENI
>  	bool "Qualcomm Generic Interface (GENI) driver"
>  	depends on MISC
> +	select EFI_PARTITION
>  	select PARTITION_TYPE_GUID
>  	help
>  	  Enable support for Qualcomm GENI and it's peripherals. GENI is responseible

-- 
// Casey (she/her)

