Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F953C982DB
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 17:05:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6D9B82BF2;
	Fri, 16 Jan 2026 18:05:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LPrn0+yv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFB7483015; Fri, 16 Jan 2026 18:05:40 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 172A48003E
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 18:05:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b8765b7f4c0so379290566b.0
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 09:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768583137; x=1769187937; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P8E/e9F8LUE0tzkUUNaGX6LTIPU+hDWYmvBCp698ymE=;
 b=LPrn0+yvY9/C+45WnqMqCSr1Hb6CzsuXJ7AtQjxQCAaStUi6a5IfyFGxpog6x92Rui
 g/7qS13cWf8wRvSKOURv3VmqJC8Xv4sVFqx0JbzbrkcCU3U2YCj4UOJ+Vgq8TVhT01Av
 B1400Lyb6aKgBC06GFDtrpZCfN1sVe6YQn88v9cHMCGqU4DP4k6moJJre75nBp/u8s/F
 4PeLav9xhmwuCcuGiNisJ2HYJxU7FwFy/DJHaiQAtsnF5xHocqYCexgo8Tha7FZ0E1fy
 RtCVIrLdZqa+6m3s3PUhAlE06xYFLkM3VLJG0xpMYy+rwC88VH1oV7nbpxg9eauBCWuw
 OtOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768583137; x=1769187937;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P8E/e9F8LUE0tzkUUNaGX6LTIPU+hDWYmvBCp698ymE=;
 b=gxi+JDm5cbeEjBhJeR0jWxYK4iDhji0TdKuJWcJyiuVhJRXvs9w04qAG2B/ZVg30Qh
 hRTxtwYJGQvVAvIyoZ1cC2IMF7BRVHOHQvFnSzuWCg4fMBN0MTlM0WEhOZgfYrk1WTUj
 rAHd/E1sKY0eCMQMgAo4fOUC3l1WMwLZ4SyWj5s2mrboDc2Bft6oO+BYf8wE3niDPoeB
 tBdv+j+DsTwb+eYxy7QN4LUmTDC7yXxOoFD6uDnVRojJdrV1c62Qm/JYKXJjh4Adrp3Q
 pjprxfVLEZ9eYcJxRNPFvRi144GCgtrMIW4IpKRBGRbOCBI53BGmAeln4yq26c8GBISS
 yyDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbTVJQWOjQXbxQC1KOt/x+6916FrMKBMh6Q816YJXlqnLG5JVwA/DKt7taSjVds8HISiADY+o=@lists.denx.de
X-Gm-Message-State: AOJu0Ywp0t4htg9DleOsgCDIo4+aIyOAIwPz5oqvoK+fBrWiadjsL7u7
 D26C81p871oSxLI1paeNdKVcDYAD1/o5XkoxWnr/eYNzTVoTEWH4S9XdLVkz7Dvmj6Q=
X-Gm-Gg: AY/fxX4MAHDSPEEwwjgcwhiTleH6YxQCN1YsiqYlJO9dUo4EsvWlRpAmCnXvHUbTMTV
 cyfcdznJfers5oDN13V7qbIGOIxkJkE7RNGsSr4rDHx5914FFnnFnexyiZI1A7YwrMkumv42VSL
 iZmGzALEIJlINQKWE6WXydkvNq5DKr8My8Vi5gxovMRr1zR6uS4M//1Bls2X870Fm9EmPh57+wG
 sL+cMwo2o0D8dCOGyTTBroNnnDPV7OG+1HEfh+/HHXFP7Ca9eXkEYI3e/et1jpoGyW5iEtMx0BB
 j4qn+HduIYJO9d9YeqftoCDIShFGomly7YaviLbYHXHz9NvDvBMtQZWUJYLBAJkpQbdHOz2mcrp
 vYK19Zwx8C5hFFEVGY+/VAALVk3GzgV7HhIZstEOUCqW/Hz0Vdfy56o7c52J5ZZWnLWUkT3Wzs9
 9O+YXLTvJCTsfAlqMnn/o+alXRm/kKoSWyE+c8nDiqLWM4Rf8kCzvI
X-Received: by 2002:a17:906:7304:b0:b83:95ca:589b with SMTP id
 a640c23a62f3a-b8792d68202mr284365066b.10.1768583137321; 
 Fri, 16 Jan 2026 09:05:37 -0800 (PST)
Received: from [192.168.1.160] (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8795168b2esm302151366b.17.2026.01.16.09.05.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jan 2026 09:05:36 -0800 (PST)
Message-ID: <69c4d09d-fedf-4940-b4de-1cc824b31e7b@linaro.org>
Date: Fri, 16 Jan 2026 18:05:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] usb: common: default dr_mode to OTG when not set
To: Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Jonas Karlman <jonas@kwiboo.se>, Sam Protsenko <semen.protsenko@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
References: <20260114-casey-usb-role-switch-v1-0-fb7a626466b9@linaro.org>
 <20260114-casey-usb-role-switch-v1-1-fb7a626466b9@linaro.org>
 <875x93fd54.fsf@kernel.org> <877btheo4b.fsf@kernel.org>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <877btheo4b.fsf@kernel.org>
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



On 1/16/26 13:30, Mattijs Korpershoek wrote:
> On Thu, Jan 15, 2026 at 10:17, Mattijs Korpershoek <mkorpershoek@kernel.org> wrote:
> 
>> Hi Casey,
>>
>> Thank you for the patch.
>>
>> On Wed, Jan 14, 2026 at 15:13, Casey Connolly <casey.connolly@linaro.org> wrote:
>>
>>> DT bindings dictate that dr_mode being unset on a DRD capable USB
>>
>> For the curious, this is defined in https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/usb/usb-drd.yaml#n23
>>
>>> controller means we should default to OTG mode. Adjust usb_get_dr_mode()
>>> to reflect this.
>>>
>>> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
>>> ---
>>>   drivers/usb/common/common.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/usb/common/common.c b/drivers/usb/common/common.c
>>> index 13e9a61072a9..e3bd7339e68e 100644
>>> --- a/drivers/usb/common/common.c
>>> +++ b/drivers/usb/common/common.c
>>> @@ -29,9 +29,10 @@ enum usb_dr_mode usb_get_dr_mode(ofnode node)
>>>   
>>>   	dr_mode = ofnode_read_string(node, "dr_mode");
>>>   	if (!dr_mode) {
>>>   		pr_debug("usb dr_mode not found\n");
>>> -		return USB_DR_MODE_UNKNOWN;
>>> +		/* Default to OTG mode as per DT bindings */
>>
>> Nitpick: can we change the comment to:
>> /* Default to OTG mode as per devicetree/bindings/usb/usb-drd.yaml */
>>
>> This tells the same but is more precise and is imho, a more helpful
>> comment.
>>
>> Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
> 
> Also, I just noticed, but there is another similar change here:
> https://lore.kernel.org/all/20260108-usb-dwc3-exynos7870-v3-1-343fa1e81e48@disroot.org/
> 
> Casey, can you see if the above is useful to you?

Oh yep, same patch basically. I'll drop my version in the next revision.

> 
>>
>>
>>> +		return USB_DR_MODE_OTG;
>>>   	}
>>>   
>>>   	for (i = 0; i < ARRAY_SIZE(usb_dr_modes); i++)
>>>   		if (!strcmp(dr_mode, usb_dr_modes[i]))
>>>
>>> -- 
>>> 2.51.0

