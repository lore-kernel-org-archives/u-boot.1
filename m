Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40BE2D37E3B
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 14:42:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98103830E4;
	Wed, 14 Jan 2026 15:42:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Yz4CH1Ry";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 999A18352B; Wed, 14 Jan 2026 15:42:41 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 861718063E
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 15:42:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-477ba2c1ca2so96432805e9.2
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 06:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768401759; x=1769006559; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qdtEUJ4oER6C0oyJYvtqmkkc+5bV/+jMahXeiuCDSl0=;
 b=Yz4CH1RyJlL1LZFpFQ9fd5LNyJfQwXj5uiSZAT+ciBKVfuk19JqAh9C78nrkRhqFL3
 vYAiRQtFbY+Udf7Iw4oCWn7j1DKBrLBXsMfKGGHwegabmYcRx9WKU5xxjAuYb+kqBcSL
 Mmfb3rNmfOkTZDFtoRi6WGYpoI4ohQXRPrJKwyI6HLhXDoMhsSmHg5CKUb07XsHAtecL
 8VdXxGZ5pgUKbFZ7OazM4VvBgbILWymVy2kUspGMJON3RB8nLXE6VjqpMicHpoKL4NOV
 EGd7Ak/Z8dHkaee0q3If+9qLSoFgNyeQN49c+bzhEjuqcg23SDZzuuUWGB62fHcJzslA
 0sEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768401759; x=1769006559;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qdtEUJ4oER6C0oyJYvtqmkkc+5bV/+jMahXeiuCDSl0=;
 b=X3l9xmt72QpdD7QS4toHkTvSuCwkPeWbVS7GdX0w4go8dNsME4r2Pm1yNx4ppxxIb5
 C3GYmj1IF3Dwr9xidf8dr9aNw8WSkKD9YypbDDPIDHppIzyUhz001rEJCbLiRGXPw6rE
 uvGVhIzM9xZGBzPBC4sKZZpVRBMs7fWDaDWo41wDBWWxTw1gOQ7DXEcl0ow9IhGC6Qyw
 /BX0rtrc95wbWNmBZszfzDYQJC3YMHnyEk6G/cSAbADpSp4o/boc2F79tXFbsRahOlsh
 xyrIek3eCSGkFsNt6tyj2eGmCcITxzfcYfX0VASgcJTBIzxj2EuoFqFax+aIH3S5aGz1
 8JCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+cwK66eS/opYJW4WyJPDJQvLcNKMDnKc315pr10vfA2Gqx18GO/S3Ji/u7t4mBkyq0ECG/l0=@lists.denx.de
X-Gm-Message-State: AOJu0YxmhHct43Hips3R/AuFkoiVzuam2beVXPDHjshlHh9MgW8HVT9A
 5IRKcSUasngx2bYekZBUe3bgHKLc244Y2QfDg/c5EDwBBdyUD/96y5YNfYu8cr024Gg=
X-Gm-Gg: AY/fxX7v5fFVvSiHw+sjsWaBxpQAE0f6mNbtRatF1pRQ2AG8G2n5Yye5H2mEMzVq0oC
 vb9nCnJU/fDkX1j1cmY0WP/2APsQPOxil0tz+d5ZBitcYC+BwjXmYF0SQQNZoH2HGsACOo/7dLA
 wBducJbIBzAIwYUj5jTTdjL5Gaua3gebHORgkaAz03OCDwPWsAunChD4KITSSfzlqHg4MlfE6Z3
 gUkivoXaMkET4v/1ToC0wiFmO/q1m3fMyLakVt6Zh9kgaFNgBZpxfp3Q6v8/5YSH3YQo7nImzlr
 HDlmaRhtlkTXyXe0uQoTVoyWkJmJKw1o/MpQ+2bI5NV97fpAgzpbcnh2DtEqJ+Zf/nbG4SRtUiD
 7pGh6IJ9jvcyi6ATvrx7OBonpWDJFdSRSOwqIR2MY9pcKOnpWpge7W88Joze8b8PytMWapROdLy
 Ea4a6LDINyd1UWhT3YbyG1fjLR9hx9S6peFQl7kTEoEh5057znuzY3uMLwQnXrsg==
X-Received: by 2002:a05:600c:1910:b0:475:e09c:960e with SMTP id
 5b1f17b1804b1-47ee338a7c6mr34935555e9.32.1768401758933; 
 Wed, 14 Jan 2026 06:42:38 -0800 (PST)
Received: from [192.168.1.36] (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47ee573e2eesm32267355e9.15.2026.01.14.06.42.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jan 2026 06:42:38 -0800 (PST)
Message-ID: <fe0b3ba1-cef1-41ae-8a8c-703b7e7eb55b@linaro.org>
Date: Wed, 14 Jan 2026 15:42:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] usb: dwc3-generic: respect role-switch-default-mode
Content-Language: en-US
To: Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Jonas Karlman <jonas@kwiboo.se>, Sam Protsenko <semen.protsenko@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
References: <20260114-casey-usb-role-switch-v1-0-fb7a626466b9@linaro.org>
 <20260114-casey-usb-role-switch-v1-3-fb7a626466b9@linaro.org>
 <328c1940-2557-4b5a-a089-d83c4fbee14c@linaro.org>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <328c1940-2557-4b5a-a089-d83c4fbee14c@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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



On 14/01/2026 15:39, Neil Armstrong wrote:
> On 1/14/26 15:13, Casey Connolly wrote:
>> Respect the default mode configured in DT if it is set and dr_mode is
>> OTG. This allows the board to prefer host mode even on a DRD capable
>> controller.
>>
>> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
>> ---
>>   drivers/usb/dwc3/dwc3-generic.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-
>> generic.c
>> index 7044696ced0c..1aa9fc933282 100644
>> --- a/drivers/usb/dwc3/dwc3-generic.c
>> +++ b/drivers/usb/dwc3/dwc3-generic.c
>> @@ -528,8 +528,13 @@ static int dwc3_glue_bind_common(struct udevice
>> *parent, ofnode node)
>>       dr_mode = usb_get_dr_mode(dev_ofnode(parent));
>>       if (!dr_mode)
>>           dr_mode = usb_get_dr_mode(node);
>>   +    /* check default role for DRD controllers */
>> +    if ((dr_mode == USB_DR_MODE_OTG || dr_mode ==
>> USB_DR_MODE_UNKNOWN) &&
>> +        ofnode_read_bool(node, "usb-role-switch"))
>> +        dr_mode = usb_get_role_switch_default_mode(node);
>> +
>>       /* usb mode must fallback to peripheral if not known */
>>       if (dr_mode == USB_DR_MODE_UNKNOWN)
>>           dr_mode = USB_DR_MODE_OTG;
>>  
> 
> So it means that,on phone platforms, the controller will default to host ?

No, it will default to whatever role-switch-default-mode is if it's set,
phones will have this set to peripheral if it's set at all.

> 
> Neil

-- 
// Casey (she/her)

