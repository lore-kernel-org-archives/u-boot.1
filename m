Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3D7CCAC5A7
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 14:07:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B63F80107;
	Thu, 25 Sep 2025 16:07:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="d2DhzqQZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C86C380B9B; Thu, 25 Sep 2025 16:07:39 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 734108004F
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 16:07:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3ee12a63af1so735351f8f.1
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 07:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758809257; x=1759414057; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E27/frpiSUPsjCd5DjqogTNKAmdc+aqSlRRb6wBP4Gs=;
 b=d2DhzqQZlSgJiAeUDEsf6ltRCTKsIrChWtPgZa0/wBDgLxxp/1sQyTGmlXCJTZl1N7
 YqRmQnPwkEDCnaWbL9N6EVJAZzUeDSg5fp9FH7pFXqucl3g1p/Kvlbne6dTih6w3H4wP
 gsXbA/h/EqARDRQvlLdiIe3N5JojWmbuzVx+Pudmo9qQWSR7DC4Mzj0KsQC0Rs994zcY
 bvK8dWJwpDgfeJTBcE3P4wZUnnN7br6qDCl8TQxLLgC/CcjZk3FtR1FXrsENB5ZIY0up
 mennlC//GO0iP5J1HCr0dFtk+fjMB8RrBg2PcINCHcjK5zpb9/zuqE9Nj0ejqPQGSqgB
 YBdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758809257; x=1759414057;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E27/frpiSUPsjCd5DjqogTNKAmdc+aqSlRRb6wBP4Gs=;
 b=dYDR1ViuP4GAc1sz2fgWdxz1GOUGlBpQ5iIWrj26Rior9paM9jxrFUFfAqclBrNQXl
 Nw2cZRxPPcvkQjhwkLn6B2Vwdpu3Rq7kWsgj5PmaS/4l21cX9EZ+XbAvhAAcVJ1Funu+
 5Ud8OK9mevnM+lbI4h+W/4hFs/9AS595S9Uy4CZIAT8te72v/W+gFX6CrWgVsBBhx74G
 cEGgV4aFBmHjKn47G7QzkIWRq86nIC9+eMzMZhzn5lOcLAyJzLbQfW0goFYMDhM+Ly+f
 nThSzoKV6N3phozqQ6hjfCcx5okIlmocAlMf7wM/0Frk/ragdTjgffdFW/Y4WL3KxE4n
 BZwA==
X-Gm-Message-State: AOJu0YwTcc4yyGyoMyeE+R8YxJLdbrf25WZAUtpX4vl++J7eqt/MhPVF
 MAmVT3Mk4NKapx8+qMHz09y/U4cyNnRQ4+MVocXmcRwPO6ZUupWrrGHhLetfhS6W0mA=
X-Gm-Gg: ASbGncvbche2H90SzB268n/hPW7JbvX2kIq/s0+dqmdVIozooQ3qahZNPW6/z+oH+To
 RQu8ITsFeHvaReGbj9COKEYRejF3OYaD5qQufxb5vZtiMtAYpE3oeW0tfOzIC3FsZWWeEyxyVdj
 Fj6c/4wpdXU5al+TRusav6PsijtyPsVKW3v4QgLzTsaPygjC2HXvloTXgHztoM5b+ttq5fBzoBv
 ifCuAsqHS0bNLX2IIfkPhGiv1BWgiJowFZX50b45BMxZzV4a98WlSfeKJqGtEr+zVgJopLv+eEE
 naAPB576Vcj6USLOgMGu0obeKTxUPxoV6ustYrUugCkJAAFcmyjx7RjxvNUJYurQN1/Qy+bFe3R
 jX0+q/knaiydggD8KDoGkE8yvnIlUytAnm2wHcvnZ/qtVusRggkvwR8X/k0Vg7I5dmCTWfivwWY
 Lq/w==
X-Google-Smtp-Source: AGHT+IFKhycDg6OMcFjucBDiXms7mHNmh8u+lU2/GJy8iknMC0t/+lIeXDMEEgVnkegWx4SSLGKQGg==
X-Received: by 2002:adf:eb8f:0:b0:3ec:db87:e8fa with SMTP id
 ffacd0b85a97d-41358755438mr120191f8f.26.1758809256863; 
 Thu, 25 Sep 2025 07:07:36 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:f9e:3c01:5cb4:3820:cbe0:c98b?
 ([2a0a:ef40:f9e:3c01:5cb4:3820:cbe0:c98b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc82f2965sm3123871f8f.55.2025.09.25.07.07.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Sep 2025 07:07:36 -0700 (PDT)
Message-ID: <02ef127e-f789-4cc6-9592-eb4b75f1b0ea@linaro.org>
Date: Thu, 25 Sep 2025 15:07:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3: Remove redundant test
To: Marek Vasut <marek.vasut@mailbox.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250925-dwc3_ep0-v1-1-7af60ed1e28c@linaro.org>
 <b6d1f1df-eed5-4cbe-8add-31c1e77e3a16@mailbox.org>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <b6d1f1df-eed5-4cbe-8add-31c1e77e3a16@mailbox.org>
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

On 25/09/2025 14:56, Marek Vasut wrote:
> On 9/25/25 3:20 PM, Andrew Goodbody wrote:
>> In dwc3_ep0_complete_data there is a test for 'r' being null and the
>> code will return at that point if so. After that point 'r' is guaranteed
>> to not be null and testing for that is redundant. Remove the test for
>> 'r' being non-null.
>>
>> This issue was found by Smatch.
>>
>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>> ---
>>   drivers/usb/dwc3/ep0.c | 5 +----
>>   1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
>> index c656cbe25ce..680756532f0 100644
>> --- a/drivers/usb/dwc3/ep0.c
>> +++ b/drivers/usb/dwc3/ep0.c
>> @@ -799,10 +799,7 @@ static void dwc3_ep0_complete_data(struct dwc3 *dwc,
>>       status = DWC3_TRB_SIZE_TRBSTS(trb->size);
>>       if (status == DWC3_TRBSTS_SETUP_PENDING) {
>>           dev_dbg(dwc->dev, "Setup Pending received");
>> -
>> -        if (r)
>> -            dwc3_gadget_giveback(ep0, r, -ECONNRESET);
>> -
>> +        dwc3_gadget_giveback(ep0, r, -ECONNRESET);
>>           return;
>>       }
> Please use ./scripts/get_maintainer.pl to get full CC list and CC all 
> relevant parties.

Hi Marek,

I use 'b4 prep --auto-to-cc' which calls get_maintainer.pl to populate 
the email addresses used.

Andrew
