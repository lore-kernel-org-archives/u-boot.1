Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A29A8CA0ED1
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 10:45:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED39783865;
	Thu, 14 Aug 2025 12:45:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jd7Ng7IN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF4CD838AA; Thu, 14 Aug 2025 12:45:16 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9359283855
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 12:45:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-45a1b0d231eso4199145e9.3
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 03:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755168314; x=1755773114; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JNVf9AaU3Jswfg/iYeHTpYKY9ne5f+eKj2hw/O1qVOE=;
 b=jd7Ng7INz9MJXDtSriq/fZPdQTVgQDHQ1T7p60F3rcEN6g4bFvVzHpyjfjutxt9OAe
 rp7ll/ZWk2NBGJDSiSFNy463YLqN6CQwdJlmAVwpDE8f1pRb8sPEE22fO/2natnF9AC1
 hM8q3E+dZ0HkK/7yTvTdghlLHjHEbkrBLk1HosBjdZ4KYr5oNtwDj6tpt5SM0nhvDn5n
 NMhPLae55kxUXI7uXTaFOlqzNxpdmLTBH07egJnaV7MLGQvGJHC2kYkUOq6ujnD7YrVU
 JQ6vRTbZdcrmWmMEzFCTzX+TRNU7FwH0ZuXDPb6tDixbTfdsxcqUyEKx2NBoXFbtxlZa
 FxTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755168314; x=1755773114;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JNVf9AaU3Jswfg/iYeHTpYKY9ne5f+eKj2hw/O1qVOE=;
 b=TCSVhPHXT/VXmHvhgr0oHV3K0XdIoiWJa0TB8qIpw5RUS1hBS15p+62FgDffKjJb3v
 OfgEsjfh+b+o3B5MGzQ+XuEitMptarVWvuzxYIihpK0mPKUlqKMeH6v8fBLGCp1Mr/PU
 waTd1rIhONe69WwWTt3u0c5D9yyt9KIq8nbZxh16l9hsG5Wrvv7VIlrC/z6GpAFAHkxB
 4k43iqEyC+VzIQZeMgFP+MwMZJCclG0JJsr+bN1Wpwe+9F4u8Nr33tI+q50pkZeVxbif
 jv4FD2QsYdLX3hQJqTWac/li9+uTHrBlWIOAcr6qyQwvU/kJ90Zz7qaQoIMgsXaiwyCL
 AGjw==
X-Gm-Message-State: AOJu0YxaTusrFLTHU63shiL8CGJZ42XHbq4YuAa9OWxqEsJzEI4xC7kY
 bDanZtHxFF7WXJ2JRZ0MzOMkfj0yDtWcH1HcmQbfF8HBpsHJsFNuUx4O+Emm5HO6G48=
X-Gm-Gg: ASbGncuEA0LnsbrqVveuM9jSe/PtnqBmoTTwi8kLV2uGbB8YlEprVaYZUOvuyuPRiKt
 1TPSOrKX9ncGEwZnzvH8EfbgdgiPwIZQr6PbFaonucd0JLnwgfXuNkNqTK65KQZCzEE8ABO98wa
 Hd8R8nPQNPKiEGxjwRUXd3iqfQcLSxm2gOg0eVLFQsfshP8nsRZ0IOyAuUXkc2U3Qsw4qjehwiE
 5i3RLx83TjrfbQrKKBJEx+CpkwgG/FF0g/zR0c9wCLSJ+Lf7XfFQZyRw6aaaYwVsPgVuQvmoFDs
 n//KtpofilYq1hsXP1isfD4ojEMdojW21CyYNYe3FXUXtcI+rlbf5W/m1PJUc5hiZ6yVeqCkbKd
 SbBRLcCOB15zrz/GVdDukgYKovAE7ipqiD6sx43906ZnDyCxX8wab1q9ERvBzesOtgWjXlxAI/b
 kFaQ==
X-Google-Smtp-Source: AGHT+IHsEr2zMvuj2consPEAq3DnCvgS/JUcHRl5rhXv3VPtSgwZws8UvwsTNj4e0T4+9yt/frCnQA==
X-Received: by 2002:a05:600c:1d06:b0:43c:ec4c:25b4 with SMTP id
 5b1f17b1804b1-45a1b627139mr21214265e9.10.1755168313984; 
 Thu, 14 Aug 2025 03:45:13 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:f9e:3c01:2660:ce4c:ae32:6a0b?
 ([2a0a:ef40:f9e:3c01:2660:ce4c:ae32:6a0b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a1c6bc93fsm16754695e9.2.2025.08.14.03.45.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Aug 2025 03:45:13 -0700 (PDT)
Message-ID: <0a4f4611-8858-4a38-be70-bf0947d689c1@linaro.org>
Date: Thu, 14 Aug 2025 11:45:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: cdns3: Do not access memory after free
To: Marek Vasut <marex@nabladev.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Tom Rini
 <trini@konsulko.com>, "vigneshr@ti.com" <vigneshr@ti.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: u-boot@lists.denx.de
References: <20250813-usb_cdns3-v1-1-3779912fe660@linaro.org>
 <b83f79a7-66e9-43b9-859e-ebb69e4d536b@nabladev.com>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <b83f79a7-66e9-43b9-859e-ebb69e4d536b@nabladev.com>
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

On 14/08/2025 04:21, Marek Vasut wrote:
> On 8/13/25 6:30 PM, Andrew Goodbody wrote:
>> The call to cdns3_gadget_ep_free_request will free priv_req so do the
>> call to list_del_init which accesses the memory pointed to by priv_req
>> before the free.
>>
>> This issue was found by Smatch.
>>
>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>> ---
>>   drivers/usb/cdns3/gadget.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
>> index a30c40ef80e..9eaf7e40ab6 100644
>> --- a/drivers/usb/cdns3/gadget.c
>> +++ b/drivers/usb/cdns3/gadget.c
>> @@ -557,10 +557,10 @@ static void cdns3_wa2_remove_old_request(struct 
>> cdns3_endpoint *priv_ep)
>>           trace_cdns3_wa2(priv_ep, "removes eldest request");
>> +        list_del_init(&priv_req->list);
>>           kfree(priv_req->request.buf);
>>           cdns3_gadget_ep_free_request(&priv_ep->endpoint,
>>                            &priv_req->request);
>> -        list_del_init(&priv_req->list);
> 
> Shouldn't the kfree() be moved here instead ? 
> cdns3_gadget_ep_free_request() also accesses priv_req->request .

No, I do not think so. The kfree frees priv_req->request.buf not 
priv_req->request so must happen before the call to 
cdns3_gadget_ep_free_request. Nothing should touch priv_req after the 
call to to cdns3_gadget_ep_free_request. Moving the kfree as you suggest 
would make the problem worse.

Andrew

>>           --priv_ep->wa2_counter;
>>           if (!chain)
>> @@ -1959,10 +1959,10 @@ static int cdns3_gadget_ep_disable(struct 
>> usb_ep *ep)
>>       while (!list_empty(&priv_ep->wa2_descmiss_req_list)) {
>>           priv_req = cdns3_next_priv_request(&priv_ep- 
>> >wa2_descmiss_req_list);
>> +        list_del_init(&priv_req->list);
>>           kfree(priv_req->request.buf);
>>           cdns3_gadget_ep_free_request(&priv_ep->endpoint,
>>                            &priv_req->request);
>> -        list_del_init(&priv_req->list);
> 
> DTTO ?

