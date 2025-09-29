Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DBABCAC5B5
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 15:09:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D66F783071;
	Mon, 29 Sep 2025 17:09:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="e9o3lP50";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BF758319C; Mon, 29 Sep 2025 17:09:09 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EE8882A9E
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 17:09:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-46e37d10ed2so46043745e9.2
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 08:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759158546; x=1759763346; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pPskbLnPrB50KMYXN7F5eD0csKFgmF0CSfO19xUcfWY=;
 b=e9o3lP50Ktn0uvCBY1RSDYzAo2SpN5hwBM8ZBW32Vm4rki4eyFFvdOuHbAVE3zvoJD
 ifHzG0jQOMCwBgiAbKrwihIRfyv4qh+8WrPmdBDO2cFxlma8GWrYfq87NLTuzLrNxAML
 l+nGGYfIHqgb08dPbeBeNvsXEt502kVtYA51EwgY4cXetX2b8UKnXtRQp+eH3jCbNiaR
 1oZb1NPOU+RkaQhvS85L/Zm7yLD74Wq32LIclcc1DukFsTeFeGKz4BP/j0Omt/m5UK8M
 Iwg9XTpt/nhU+Nx611bYDKVBNQqH9W1++xT24ZiMJBwUQkw9RKVlbyWM7x81Aj/3NSR7
 jSNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759158546; x=1759763346;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pPskbLnPrB50KMYXN7F5eD0csKFgmF0CSfO19xUcfWY=;
 b=gDnkwlnXVBPzKLDkkLaouFrg6q18shlrbwSKsWcIqu+8eYHYfJQiB8NCG68Y2iZbZ0
 mHRwexH7vunbOv25tROakUjoJsY21Jv6+LIsBmx4Oj0DNr7jzh2Y2+xnD2FkVHmgx7EQ
 EBlGt3NM7BpdKC2mBIJKHjJ1xrSaE4Twzql6+aiDdFDvKVjxda/3TgbmBcDuBkF0AF4/
 XBiQnXr6UAUbiNNb4RvoUIYINnA4ODt9Af2OwfzPi2tlxEcRUIXo7Un5UfjN3o7K3fUx
 VMn1dZ9OFCsMAIziIvTRtZAVKxGnadJpCirQHGDXMgqjv9NG9NHyLOwxOE8s6tfQSbhM
 ansA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeMkjQM0OfrBSjfBnAh1Mww09DJttidaj/RQexRT8X8nEIH5gasEtAJvJn/CP48HnKU8SOBwE=@lists.denx.de
X-Gm-Message-State: AOJu0YzjcPDzhuIkgb/Adl6QL+pe21RaqybXPvpomRsUgkA+fvAX2fbb
 oLpXUcuHCe5KMHhqZBa0WF7ymme+KGcBWNzrmFSfyPc5O/wUspOAPX+4LfX14KkVbu8M+OYC+VE
 IC5gV
X-Gm-Gg: ASbGncs3+6R++Xhiq3qCdYpRutnNy/je9jVopoZUM2bTlWH3iY/J0l9guiXhlCNVoUV
 o5aRkm4zRHNkZVGFVZkh0hN2VacNdi5HuB96xQJCzYhEVCcjgh9P+lc+LIJku1iLupt1ko4WRCk
 okNZG4fEQCTzg2mLJc3NCooEFI4FjOOpw3OOErfyw4PiPOcPF8T1eI8MFKl5XRxvO+xgNcUWI/w
 ZjdAFZpLCoJuqPIB0l4JdiWKlekYMUV9QxdboE1rLZLKW4JWO2YZ+5WG5QXYjKOwVQU3SYRfSC/
 l3Y2awjaNNtAj9mZu1dxUAXlm/WN3+IQxUu2mX7F1OMxkCZb5SYX7ckyS9lCP1YYAwdEXW3S1RG
 sWAf+hUM+V9tnhxcl+oWSPEy1QcnFOJI+3janPMoGPCRgfufP5+GvQZdOu1rAXlB6F52KI8lbwH
 3ltQMZLHCcpw==
X-Google-Smtp-Source: AGHT+IHzoJh5hL7+iMMeQc7GcW8sQSxsvFNqxJmpTTbnGyezPHgGaSW9HPJIN7DYEaG53dZ/bp1i3w==
X-Received: by 2002:a05:600c:4512:b0:46d:996b:828c with SMTP id
 5b1f17b1804b1-46e329e3f76mr188162335e9.10.1759158545858; 
 Mon, 29 Sep 2025 08:09:05 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:f9e:3c01:4bc3:3107:fbfe:562?
 ([2a0a:ef40:f9e:3c01:4bc3:3107:fbfe:562])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e56f3dcacsm18377055e9.2.2025.09.29.08.09.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Sep 2025 08:09:05 -0700 (PDT)
Message-ID: <d1579ba6-35f5-4dfb-b7d7-f6073bd92996@linaro.org>
Date: Mon, 29 Sep 2025 16:09:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3: Remove redundant test
To: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de
References: <20250925-dwc3_ep0-v1-1-7af60ed1e28c@linaro.org>
 <b6d1f1df-eed5-4cbe-8add-31c1e77e3a16@mailbox.org>
 <02ef127e-f789-4cc6-9592-eb4b75f1b0ea@linaro.org>
 <59d4ef95-e030-4508-8e1e-ae37a0df6c29@mailbox.org>
 <cb3ad7f4-6e02-4a59-b763-887ead2c338d@linaro.org>
 <20250929141507.GE6093@bill-the-cat>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20250929141507.GE6093@bill-the-cat>
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

On 29/09/2025 15:15, Tom Rini wrote:
> On Mon, Sep 29, 2025 at 10:09:09AM +0100, Andrew Goodbody wrote:
>> On 25/09/2025 15:12, Marek Vasut wrote:
>>> On 9/25/25 4:07 PM, Andrew Goodbody wrote:
>>>> On 25/09/2025 14:56, Marek Vasut wrote:
>>>>> On 9/25/25 3:20 PM, Andrew Goodbody wrote:
>>>>>> In dwc3_ep0_complete_data there is a test for 'r' being null and the
>>>>>> code will return at that point if so. After that point 'r'
>>>>>> is guaranteed
>>>>>> to not be null and testing for that is redundant. Remove the test for
>>>>>> 'r' being non-null.
>>>>>>
>>>>>> This issue was found by Smatch.
>>>>>>
>>>>>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>>>>>> ---
>>>>>>    drivers/usb/dwc3/ep0.c | 5 +----
>>>>>>    1 file changed, 1 insertion(+), 4 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
>>>>>> index c656cbe25ce..680756532f0 100644
>>>>>> --- a/drivers/usb/dwc3/ep0.c
>>>>>> +++ b/drivers/usb/dwc3/ep0.c
>>>>>> @@ -799,10 +799,7 @@ static void
>>>>>> dwc3_ep0_complete_data(struct dwc3 *dwc,
>>>>>>        status = DWC3_TRB_SIZE_TRBSTS(trb->size);
>>>>>>        if (status == DWC3_TRBSTS_SETUP_PENDING) {
>>>>>>            dev_dbg(dwc->dev, "Setup Pending received");
>>>>>> -
>>>>>> -        if (r)
>>>>>> -            dwc3_gadget_giveback(ep0, r, -ECONNRESET);
>>>>>> -
>>>>>> +        dwc3_gadget_giveback(ep0, r, -ECONNRESET);
>>>>>>            return;
>>>>>>        }
>>>>> Please use ./scripts/get_maintainer.pl to get full CC list and
>>>>> CC all relevant parties.
>>>>
>>>> Hi Marek,
>>>>
>>>> I use 'b4 prep --auto-to-cc' which calls get_maintainer.pl to
>>>> populate the email addresses used.
>>> It seems to be missing these people:
>>>
>>> Mattijs Korpershoek <mkorpershoek@kernel.org>
>>> Neil Armstrong <neil.armstrong@linaro.org>
>>> Anshul Dalal <anshuld@ti.com>
>>
>> So it looks like the default command used by b4 for the Cc: section is
>> "scripts/get_maintainer.pl --nogit --nogit-fallback --nogit-chief-penguins
>> --norolestats --nom" which causes recent signers to not be included due to
>> the '--nogit' argument.
>>
>> I have added the following to my git config file.
>>
>> [b4]
>> 	send-auto-cc-cmd = scripts/get_maintainer.pl --nogit-fallback
>> --nogit-chief-penguins --norolestats --nom
>>
>> This will mean that from now on recent signers will be added to the Cc:
>> list. I hope that this is what is expected.
>>
>> I will resend this patch with the expanded Cc: list.
> 
> A while back someone submitted a .b4.conf (or .b4.config? I forget...)
> patch, but at the time it wasn't setting anything non-standard I
> thought. However, is the above something that can be configured there?
> If so, that would be good to put in a project-wide b4 config file, and
> if it's not it'd be a good feature request for upstream.

[1] which also incidentally dropped the --nogit along with some other 
arguments without mentioning that in the summary.

Yes this could be done in the same way. Do you want to take that old 
patch or should I do a new one?

Andrew

1 - 
http://patchwork.ozlabs.org/project/uboot/patch/20240717-b4-config-v1-1-0bc9e80ef582@flygoat.com/
