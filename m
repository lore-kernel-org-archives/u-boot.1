Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75912CAC5B5
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 09:09:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D12648319C;
	Mon, 29 Sep 2025 11:09:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TFL4ycsM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C28C8329F; Mon, 29 Sep 2025 11:09:14 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6693083189
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 11:09:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3fc36b99e92so3226699f8f.0
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 02:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759136951; x=1759741751; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ok65uZEp6xQyWY7iP+2yK65WL0cbXBKp17Hu0IEJY3s=;
 b=TFL4ycsMxf2TKHw1GRTygIPJOILNE6u1BgfsBQVhQmHf+nS4NFAk6xsU0e1SZOf+ef
 X5oy0Z9pj2YVuuu+owZDeAW/9auhoGIpgZzb2gUx79sQLzA6J6UJBUtazUmEfSOUeGvk
 EoIiPEhkg0/Er7658Mnrpf9aG1Qm3kajwUeuuAEsPsp92pGQKbLNVQ9BK9LbULqiwY8u
 Es9L7A08wtFY49EdcLPqYYbzxZaqMIbGKnaRA8H/LlJLAFDj8ZPUOYHvcr6PZKovAxXY
 JTexlIKo+M2WoWRnNSbsXtwhCoZFbbDqT7q+ZvSF1Fnoi00pZ9xgZqB+vDeY6yNBmjmf
 RXIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759136951; x=1759741751;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ok65uZEp6xQyWY7iP+2yK65WL0cbXBKp17Hu0IEJY3s=;
 b=Wfe1yv5RtXTDhwOuBapfFp5icD6CsXv8Tgoz4m7MgLxWJkkJjTsPobmNMrtk174wZw
 8HbbzqJbfD/oDIq68qtWYJpL+sJmHnHMkfN4Ns5MltDXr8c1T5qz09hqGpc9B3v96jbN
 SiQI5+ZlmvaCtGbG2/o97GhpoTCKOaZbmOLpPTHCp54ABq5zfbEKQxYLsNNbwrvQH4eh
 wBfk+btIhasTQvs9FwlsjJ6VcCGsFbOAx3RmP2wxfg51O07VhjdYI6WmaFwF/o18MRxg
 kGFQvy45bS8J9HhHDi+HqBhET/8Zc9kCWh/pticPfEXL+8oA2G3wnSLGCwFdATCaRBKO
 dvvw==
X-Gm-Message-State: AOJu0Yyg6oqCqv8z5CibbIG7Y7/rf4TarWU1dUm66lR8qziZkP1MU7dl
 QLxn5wiQhELHuQCMBbYgjt9clURUxoayAqs/95Zw3dKSHyRQWRiYQjtIGK3JU/I5PkQcFPmwt9v
 w9vwk
X-Gm-Gg: ASbGncsUMtcMFb5M425JtasNZ/jFrtCpnw46+tbO+GoGkzfqq9eiXvwBtll4w0QJMXq
 cgNoVKIcuax1QvRaTOdNHfK8u6pO8CvAgPsn/NeWBGayIxFmy8/3r9caHs8MIwPiot3cdopv6NR
 6ka3P46IHdDHb+2nBqf0tNoWw8c2hOsryySOFv05SZjJRgBFWDVG9lmFSJ/I6odW+jOYlUCjkoO
 hVxj8s/A7+AY4li2cJhzd334Z0TPvFgVBXqMOAnqI4NHX7Qcch5R5bXdEKP1DBJ+O6vxKKIr1Dd
 eCYIbwa7nTxQdtv6KWgDz/C2Pg+jFPVqebnNx/8UesLNLRnpNh/nZKOdC4IHMF7ZLnJg6Kzp/nq
 Ese+jW8tFi1DDa3qeTbcvLPW0tGxO22LjR0k//Ssd/tmvq4NfZvGonzi7pYGKQB2T5zpVAykmxP
 I=
X-Google-Smtp-Source: AGHT+IE/iPXMBCdT9ElTQfvJTEq7f4fPm2R11Ar0kKPfPSUQ9WSN+7nbwO8+Jo7n9ZmTpGpi2ihP5g==
X-Received: by 2002:a05:6000:2082:b0:3ec:42f9:953e with SMTP id
 ffacd0b85a97d-4180040ca06mr6852385f8f.7.1759136950783; 
 Mon, 29 Sep 2025 02:09:10 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:f9e:3c01:4bc3:3107:fbfe:562?
 ([2a0a:ef40:f9e:3c01:4bc3:3107:fbfe:562])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc5602df0sm17447159f8f.36.2025.09.29.02.09.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Sep 2025 02:09:10 -0700 (PDT)
Message-ID: <cb3ad7f4-6e02-4a59-b763-887ead2c338d@linaro.org>
Date: Mon, 29 Sep 2025 10:09:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3: Remove redundant test
To: Marek Vasut <marek.vasut@mailbox.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250925-dwc3_ep0-v1-1-7af60ed1e28c@linaro.org>
 <b6d1f1df-eed5-4cbe-8add-31c1e77e3a16@mailbox.org>
 <02ef127e-f789-4cc6-9592-eb4b75f1b0ea@linaro.org>
 <59d4ef95-e030-4508-8e1e-ae37a0df6c29@mailbox.org>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <59d4ef95-e030-4508-8e1e-ae37a0df6c29@mailbox.org>
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

On 25/09/2025 15:12, Marek Vasut wrote:
> On 9/25/25 4:07 PM, Andrew Goodbody wrote:
>> On 25/09/2025 14:56, Marek Vasut wrote:
>>> On 9/25/25 3:20 PM, Andrew Goodbody wrote:
>>>> In dwc3_ep0_complete_data there is a test for 'r' being null and the
>>>> code will return at that point if so. After that point 'r' is 
>>>> guaranteed
>>>> to not be null and testing for that is redundant. Remove the test for
>>>> 'r' being non-null.
>>>>
>>>> This issue was found by Smatch.
>>>>
>>>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>>>> ---
>>>>   drivers/usb/dwc3/ep0.c | 5 +----
>>>>   1 file changed, 1 insertion(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
>>>> index c656cbe25ce..680756532f0 100644
>>>> --- a/drivers/usb/dwc3/ep0.c
>>>> +++ b/drivers/usb/dwc3/ep0.c
>>>> @@ -799,10 +799,7 @@ static void dwc3_ep0_complete_data(struct dwc3 
>>>> *dwc,
>>>>       status = DWC3_TRB_SIZE_TRBSTS(trb->size);
>>>>       if (status == DWC3_TRBSTS_SETUP_PENDING) {
>>>>           dev_dbg(dwc->dev, "Setup Pending received");
>>>> -
>>>> -        if (r)
>>>> -            dwc3_gadget_giveback(ep0, r, -ECONNRESET);
>>>> -
>>>> +        dwc3_gadget_giveback(ep0, r, -ECONNRESET);
>>>>           return;
>>>>       }
>>> Please use ./scripts/get_maintainer.pl to get full CC list and CC all 
>>> relevant parties.
>>
>> Hi Marek,
>>
>> I use 'b4 prep --auto-to-cc' which calls get_maintainer.pl to populate 
>> the email addresses used.
> It seems to be missing these people:
> 
> Mattijs Korpershoek <mkorpershoek@kernel.org>
> Neil Armstrong <neil.armstrong@linaro.org>
> Anshul Dalal <anshuld@ti.com>

So it looks like the default command used by b4 for the Cc: section is
"scripts/get_maintainer.pl --nogit --nogit-fallback 
--nogit-chief-penguins --norolestats --nom" which causes recent signers 
to not be included due to the '--nogit' argument.

I have added the following to my git config file.

[b4]
	send-auto-cc-cmd = scripts/get_maintainer.pl --nogit-fallback 
--nogit-chief-penguins --norolestats --nom

This will mean that from now on recent signers will be added to the Cc: 
list. I hope that this is what is expected.

I will resend this patch with the expanded Cc: list.

Andrew

