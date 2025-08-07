Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA75C87FDA
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 15:11:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B11C9845DB;
	Thu,  7 Aug 2025 17:11:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="h4MsGs0v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE468845E3; Thu,  7 Aug 2025 17:11:05 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10342845DF
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 17:11:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-458b2d9dba5so7426745e9.1
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 08:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754579462; x=1755184262; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0Sh+Y6K5JScyHWEG8PkziN2WzD5CeSYa8BcZw4QL+mA=;
 b=h4MsGs0vWOEMZyrsOHTArRV+Yt6caXoko69FmoMQ25b1d3OZZZA2HBRPFaEW6fvF+j
 RyXC1ctKvNe/WYrDVrETkabxk7ri9PsstVetpd9vQm6oz/3pNsPDsZ4Dhq4ntaifArLO
 GlkmfpuR8LZQLCOOXlOsS1fd6hG08vQtGXL+OzhmKBzSRp+ORkV7S/ljd3H4y/6t/mNo
 whdImSB3Qls3EtQsu2s4hlkjeMTXseomof1yAoQOXN16MDugrmMo+RggSFyftSay5JDA
 tfkCj1VaTVxvGTVFSAi5cgY2s71TQ5rYk3vSArr1n8cyXzUnwW4M8EK/YigCzuFNG5F8
 agOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754579462; x=1755184262;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0Sh+Y6K5JScyHWEG8PkziN2WzD5CeSYa8BcZw4QL+mA=;
 b=Yy1F6WGAEx8DaLaU82EZ8psNDae0gIN2Uw/nD7t1k+uFMBz8PRlNdBRQx9of6w3e47
 8ee7NDAfS4igJAIgGkNKh+WBmF2UjB1ihSNODiw36sFdzJH5DnARJSNLcDvUBSyTOv30
 PAiHYqgHfGUVId+FLNFnSbkE2nj0ufU3gogDrUu+qCN4dXhK/o8wu2XXQ4IpJ7+zGWqi
 wumnWjRL5AuKRyg+t0tVxmbn6uOQ7wqQP7VNLgePggwARwjTdEmtSVOa/18HWvjrMHgv
 NOykYWVw86UyLJUfESEEUJ0OoV3fzuGTpEdWciVy6yNvYx+zcf3Y0xBfATAKvtRV7pw2
 MNrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQK9ZMU9AgmQbSWR8p3kv85XeiCsVGfmcmekTvaBZnk9iCZyaM5stnbquS7UwDEjrLHZsJTno=@lists.denx.de
X-Gm-Message-State: AOJu0YyE855R2TfRpPk49owuBDAnnbRaxJZjKB25lAa5KA4O3CzBlX1q
 SbJOrB5UkMIBOvvfZ38HIklnER2mMvkWvmp27RuXxv+dluZyHnKTTiPpmbdVRME3LvU=
X-Gm-Gg: ASbGnctC3gS2PHLaFJAHRJLPtRBb/cTeKsZjB5VPr3g/zAflyo8raD8YxmXadrwazr9
 fF/cDt1DEQ3BYTzj4JAcW03yH8Ja9eVmdhJn3oBs5nx0u5brdN0NhxY2HZMbwVcmexKShgPkpWD
 MXeeo1h0uz5qaUfF8C4Yisv0r6WkgiW3IvOIMPuLpXN1ccZv/Jb9CZcgtEl9RHBmy47T6T8Mjvn
 SXoXk0sioJvrjp+hsXEXVDDhq84b7r61fRrvC3gI4uU6IatsSNO0gdvwMxhiqVuuXfQIZUXMA0U
 lUT9jDbSPchygALwC6ocEUTlyR1klNaSMdv4FcwvnknHc0CfQOh5vyAp8o/tFvYv/FUCvi2M2Qj
 awkPONnjQQskb8fD72+Jp1LpsfONK6Z1PQLwzX8McroiuYiBzGMJi+zTj7oeToj2iY96ITqQKnt
 lQyQ==
X-Google-Smtp-Source: AGHT+IGJC/sVcU0YnDOG99JirVe041EUIMmRcZ8lJ79KNPSAoT0rzM8p2bHKYYj6ByFiL9YbTDEaSA==
X-Received: by 2002:a05:600c:4e87:b0:459:e06b:afb4 with SMTP id
 5b1f17b1804b1-459e7080202mr70611125e9.4.1754579461818; 
 Thu, 07 Aug 2025 08:11:01 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:f9e:3c01:377e:cf4f:d0ff:80bf?
 ([2a0a:ef40:f9e:3c01:377e:cf4f:d0ff:80bf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4595cfea56fsm122504725e9.1.2025.08.07.08.11.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Aug 2025 08:11:01 -0700 (PDT)
Message-ID: <a4bacc70-7975-4f05-9017-681ecd5cf369@linaro.org>
Date: Thu, 7 Aug 2025 16:10:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] button: qcom-pmic: Fix dereference of uninitialised
 pointer
To: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250723-button-qcom-pmic-v1-1-9c317ac71167@linaro.org>
 <a0b9ba21-eb35-47cc-9efe-fce5a8b19f10@linaro.org>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <a0b9ba21-eb35-47cc-9efe-fce5a8b19f10@linaro.org>
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

On 25/07/2025 14:25, Casey Connolly wrote:
> 
> 
> On 23/07/2025 12:58, Andrew Goodbody wrote:
>> The pointer 'label' is declared and later dereferenced without ever
>> having a value assigned to it. Add an assignment to this pointer so it
>> will be valid later when dereferenced.
>>
>> This issue was found by Smatch.
>>
>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> 
> Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
> 
>> ---
>>   drivers/button/button-qcom-pmic.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/button/button-qcom-pmic.c b/drivers/button/button-qcom-pmic.c
>> index 85addfe32a2..b823490d6d5 100644
>> --- a/drivers/button/button-qcom-pmic.c
>> +++ b/drivers/button/button-qcom-pmic.c
>> @@ -195,8 +195,9 @@ static int button_qcom_pmic_bind(struct udevice *parent)
>>   			continue;
>>   		}
>>   
>> +		label = ofnode_get_name(node);
>>   		ret = device_bind_driver_to_node(parent, "qcom_pwrkey",
>> -						 ofnode_get_name(node),
>> +						 label,
>>   						 node, &dev);
>>   		if (ret) {
>>   			printf("Failed to bind %s! %d\n", label, ret);
>>
>> ---
>> base-commit: bd0ade7d090a334b3986936d63a34001d99722ad
>> change-id: 20250723-button-qcom-pmic-882cb5415dd6
>>
>> Best regards,
> 

Is there anything else needed before this can be merged please?

Thanks,
Andrew
