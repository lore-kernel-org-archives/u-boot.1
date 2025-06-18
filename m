Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC64AC71157
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 18:05:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D2D282B18;
	Wed, 18 Jun 2025 20:05:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wfC06uAL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B66782C2F; Wed, 18 Jun 2025 20:05:29 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9336182B0F
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 20:05:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ade5ca8bc69so1113708266b.0
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 11:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750269927; x=1750874727; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wxC6YZ6vPSFWaZ1W+jndIa1hZAkgp57Xnydm8ufAJcY=;
 b=wfC06uALuifv3ciT1xvcXaqfY7jmb0nYUtQFkEokObI2ymY6xGFam9OOkwHH2VsrD0
 LNZQva0W2R7K5PThcft8IRYH7gvdBZ6njHeCUNR3by5URh6bx2ypOBClnnp23MjbesgP
 0AHU6YD5y2XZkuCLK8EX86uDRLDs3uuoUlY3p+zADWGyMTkCkWTRt3D+LO4MYLpo0jUn
 APH+Gx3bx9e3Y/c9F17yLebMPNG7GxD5rjW8yBdmPQUuIFE7wVpI67Ugv4YD3zEUlc7n
 efF5jEiHyvbK5VJQh1YL5XOKjWmkT9ZTKfDsQKnEV5gr+bxNYYbl3LtvLBqmVORVueI+
 bicg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750269927; x=1750874727;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wxC6YZ6vPSFWaZ1W+jndIa1hZAkgp57Xnydm8ufAJcY=;
 b=cj13trev1UVcmXXoJPyPTSNh/ZPy+8x/XdHOT1FImWXdKBxONG1TlZ1QHD1KeiLW9S
 BmtiuCivyhNG+37ZXysGWLgR6fi5it8LiHM9pMG1FOoqgSeUtRgnoBUQYbxyL7JqvoPm
 jL9iZOSA0JMUGZoSMhDi2PjndsfUizga1g8kB/Y/ke5WrUpN2Si3R7v63jLF955U9EAv
 k0+I+sThjSAJ0zSvV5pJZjrBp89NSCa2IhC6TT1oHYEAta+ZP8T5O/NqWbb/WTQdfdVc
 3BksWucPEBNHV2Cv27qJb3CGqaS2Czfpc/K869izNA373QWOQkpepH7pkikmTe4//ADy
 jVEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4N3ZWV8feHX2Nsx4eUgmj2x8NlOlSBfsd+2/wjvzQpLANy94EptlRguaVpV02tM2geb3MNvg=@lists.denx.de
X-Gm-Message-State: AOJu0Yyi8HmlRwmIbOOKMlq6yCOlK0CJp15P+6QjQAqhT7CaFuAz4cv4
 1Gy0CbKYXYBjpFd4+qv2KQ1Sm66D8MSGMu1PCJQ4IAoZ/wg9RwcChnr3iAHgITjcSJb1nUYl7V5
 0HCwB
X-Gm-Gg: ASbGncsgRVrA+pyxD5zFabpjxFB28rBFcWBTqON6RlBQt17Hi7APm3+wJsu/bs/Dejo
 0+PkaUsqGdALM3e6OOyvj7hQguYJPXwrVDfRh1owOajJsMepfEYeanzB7YUN9gzzLIw53y/CLRk
 STUARY/IZw9kaXuyE9/OUEYxFSAYUYJQ+TBzxnqOvO7DEtc8cJZ9y9NWk3fhHVu9puPlKInE/+i
 tO4dDPrS/arZIJFks2H/eFnhVpjsBW9vAVoLW9mb4/J0Ol7ROMmo/Sz1OGsCdJQuh57Q5UnRbQu
 gAiF0Ahvt044KndDrRql2Q2GiJ8klksWnFyQZuIFAtBQCQcr86/WkrbixpBVtWo4BFW5wm4nTeZ
 +AME+cmCWEG9VXmi7GDA8MUfcSGngr/xpVQKrIWhVLKWnl3o+Zho=
X-Google-Smtp-Source: AGHT+IHkgs8OK+oUejXqlQBqtbWRWWJiXOt1eFiqM/WLKUA/DoRDan97N8PhHyATWBoDZcpl0OdJNg==
X-Received: by 2002:a17:907:e90:b0:ad5:7529:94d with SMTP id
 a640c23a62f3a-adfad59951cmr1730059966b.42.1750269926967; 
 Wed, 18 Jun 2025 11:05:26 -0700 (PDT)
Received: from [192.168.23.225] (ip-037-024-206-101.um08.pools.vodafone-ip.de.
 [37.24.206.101]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-adec892b216sm1091947866b.135.2025.06.18.11.05.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Jun 2025 11:05:26 -0700 (PDT)
Message-ID: <4b55bab1-0c40-44a6-b8be-9751b88cd977@linaro.org>
Date: Wed, 18 Jun 2025 20:05:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/9] WIP: rb3gen2: describe micro-usb port
To: Sumit Garg <sumit.garg@kernel.org>
Cc: Heiko Schocher <hs@denx.de>, Tom Rini <trini@konsulko.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
References: <20250616-geni-load-fw-v4-0-e7df44205505@linaro.org>
 <20250616-geni-load-fw-v4-7-e7df44205505@linaro.org>
 <aFE6HP629Ocg3Fj6@sumit-X1>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <aFE6HP629Ocg3Fj6@sumit-X1>
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



On 6/17/25 11:49, Sumit Garg wrote:
> Hi Casey,
> 
> On Mon, Jun 16, 2025 at 11:44:49AM +0200, Casey Connolly wrote:
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>>   dts/upstream/src/arm64/qcom/qcs6490-rb3gen2.dts | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
> 
> I suppose this is an unrelated change to the patch-set and I don't think
> this patch as it is applied upstream since the manual patch isn't
> allowed for dts/upstream subtree. You can rather have a *-u-boot.dtsi
> for this change.

oops, didn't mean to include this one in the series...

thanks for pointing that out>
> -Sumit
> 
>>
>> diff --git a/dts/upstream/src/arm64/qcom/qcs6490-rb3gen2.dts b/dts/upstream/src/arm64/qcom/qcs6490-rb3gen2.dts
>> index 7a36c90ad4ec8b52f30b22b1621404857d6ef336..a9689f126cc7f94a01921fe2dc70efb83774610a 100644
>> --- a/dts/upstream/src/arm64/qcom/qcs6490-rb3gen2.dts
>> +++ b/dts/upstream/src/arm64/qcom/qcs6490-rb3gen2.dts
>> @@ -881,8 +881,25 @@
>>   
>>   	status = "okay";
>>   };
>>   
>> +&usb_2 {
>> +	status = "okay";
>> +};
>> +
>> +&usb_2_dwc3 {
>> +	dr_mode = "peripheral";
>> +	/delete-property/ usb-role-switch;
>> +};
>> +
>> +&usb_2_hsphy {
>> +	vdda-pll-supply = <&vreg_l10c_0p88>;
>> +	vdda18-supply = <&vreg_l1c_1p8>;
>> +	vdda33-supply = <&vreg_l2b_3p072>;
>> +
>> +	status = "okay";
>> +};
>> +
>>   &usb_dp_qmpphy_out {
>>   	remote-endpoint = <&redriver_phy_con_ss>;
>>   };
>>   
>>
>> -- 
>> 2.49.0
>>

-- 
Casey (she/they)

