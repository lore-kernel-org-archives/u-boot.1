Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE4AC87FD2
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 13:26:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFAD0832DD;
	Mon, 11 Aug 2025 15:26:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="n2uoLJa1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B451383322; Mon, 11 Aug 2025 15:26:27 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F2E38329C
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 15:26:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-458ba079338so33824785e9.1
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 06:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754918785; x=1755523585; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/ktoTJg3uqGesStuCcfuZbsZawZx623hyXSyOptv6hw=;
 b=n2uoLJa1j5P84XJjWWZ2lvVylk0zBHCBJ5wfcneVsm3+veJBXQksCXOI5T8ZOGZqVz
 hPB5vYrG5FnFQ+YUTNsstqsE+OLmJ2iZmr7qBmv/oAdjRTBI+DdXwf93Ypnb2DesDom9
 jcdHVCJnwrE/iWhH/54miXvEtecblOmHyvAPSeEGqbfZ1UkvEIZuZKiL+nWM4GCaSrY4
 rPGEDNmcwD0WVXUoFwR/yphjJ8GlVoylXKM8iHAzgeBakQMjuk4rt0VRVkdb6qJMmTaR
 MZpl0hhkgh34vB3gMYx5cm2LeXxx9FahDPtb0Hb2RbvBytHA65N5z9kM+Tc97lOWGHKe
 +l2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754918785; x=1755523585;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/ktoTJg3uqGesStuCcfuZbsZawZx623hyXSyOptv6hw=;
 b=YHHplomSbLjj0h1ugxwQrW8o39FdF1bsJdjP5R5Jl3UCstOYtgajidU6V9TEI65Zit
 FPNI+9Qjai+NDTtsscnjLVQ5DuNasGqAgA6m4kJvGfrKRcbS4ZwNF1nhneHhEx5TAYzQ
 unVbvLRYZ5VENfRJofL95Q4aPSZFMyM8yEThafOPSv3QJ642JfeQEv/YEaxqBmu22U5a
 BUoqhVhzNWjB0vzBHX40TnzWQIoDYIEVNcS6R6T9Ncvw5ned7LWgBoGvSwf/Ose0u7bx
 Hw2sQGNLtcl4X3hC3TiFts2BzBtVYEOlZz1HsheOOMU5jKyG6n4fdz9ph74IEUFyEOZX
 8oIA==
X-Gm-Message-State: AOJu0YxJlscoVHvDiBj79rZHTzObn3FSX9tTfIGD5g7PPQ1p1f0gYFTj
 9bAJmcDxAVhY2hAS59hSQTPt0noKTgCeLfrKOq1dKHs1Bxs3oqipqtoSiSdOajxY1snd4LcCPcF
 +peB0
X-Gm-Gg: ASbGnctedfOlJ9hue4//BRGjhDQkZ12tRFvby31qysRmA9GWNZqjHrhdGKyOr/3Rm4/
 gUs+SZIzsXi9nhL17Z63wS5bRVDhb4Iubovt6PrkmwDc5G+9ynqjASnkLD6hAvLPSLM1jwDaPO1
 11tysbkDCiuoiRw2zz75GbM4klI8EfY0F5TLHDnDaaHwleF/P57nx+qmtufac1XISjT3Siln3je
 QtSNDyaCnnDJ8vv0BPyWEgjq73yEnK1eTv/DSkUI3GDSLXLiCNFTyWHk2N/jpGIeJLol4+JIvN4
 XkOIsg/tK4GjR8135xPc7vbWnGiWLDgc2CV0dQvpKM8kaObN8AnCuaknv3yZlIGfW53r/VT64A5
 KfdOJfhXZ7VHkAH89lwy0lhZk7gbf77yocCPnubqc79lrNEiOKZtUBx5UU0uRUuYwFTRzJQOLqM
 L/LM/dzPwSPm6S
X-Google-Smtp-Source: AGHT+IFeSlrI1MFKvapOUjN3NQAfRfb5tOzzxfLXp9NZuBNDm6suNS/Brckuds2Tu8WqNiF3Y++PuA==
X-Received: by 2002:a05:600c:3b1b:b0:459:e39e:e5a5 with SMTP id
 5b1f17b1804b1-459f51a7fbamr110770555e9.5.1754918784811; 
 Mon, 11 Aug 2025 06:26:24 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:f9e:3c01:3e73:96b1:418e:3053?
 ([2a0a:ef40:f9e:3c01:3e73:96b1:418e:3053])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e6dcdbbbsm124296435e9.7.2025.08.11.06.26.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Aug 2025 06:26:24 -0700 (PDT)
Message-ID: <a50941ee-7817-4e9b-88ea-be380e76f9bc@linaro.org>
Date: Mon, 11 Aug 2025 14:26:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: phy: vitesse: Fix incorrect test for timeout
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250806-net_vitesse-v1-1-47f5a923d586@linaro.org>
 <277eb50f-26a5-4b24-acfe-210dfe346e49@cherry.de>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <277eb50f-26a5-4b24-acfe-210dfe346e49@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 11/08/2025 14:01, Quentin Schulz wrote:
> Hi Andrew,
> 
> On 8/6/25 11:37 AM, Andrew Goodbody wrote:
>> In vsc8514_config there is a while loop for detecting a config failure
>> using a timeout counter with a post-decrement. In the case of a timeout
>> this will result in the loop exiting with timeout == -1 so use that as
>> the test below the loop to detect that the timeout occurred.
>>
>> This issue was found by Smatch.
>>
>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>> ---
>>   drivers/net/phy/vitesse.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/phy/vitesse.c b/drivers/net/phy/vitesse.c
>> index 4867d1931b4..821d3878236 100644
>> --- a/drivers/net/phy/vitesse.c
>> +++ b/drivers/net/phy/vitesse.c
>> @@ -239,7 +239,7 @@ static int vsc8514_config(struct phy_device *phydev)
>>       while ((val & MIIM_VSC8514_18G_CMDSTAT) && timeout--)
>>           val = phy_read(phydev, MDIO_DEVAD_NONE, 
>> MIIM_VSC8514_GENERAL18);
>> -    if (0 == timeout) {
>> +    if (timeout == -1) {
> 
> Could have used --timeout instead in the while loop and that could even 
> have allowed us to change the type of timeout to an unsigned number type.

Yes indeed but that would have meant 1 less pass through the loop and so 
I chose to not affect the operation at all.

> But that works too, so
> 
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Thanks!
> Quentin

Thanks,
Andrew
