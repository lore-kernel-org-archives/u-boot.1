Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75999C369A2
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 14:43:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF15482E0A;
	Tue,  8 Apr 2025 16:43:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sW7o/1BT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C40082E0A; Tue,  8 Apr 2025 16:43:53 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C5E182D2A
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 16:43:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43cf58eea0fso29341185e9.0
 for <u-boot@lists.denx.de>; Tue, 08 Apr 2025 07:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744123431; x=1744728231; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zZClw+jHIcxPT7ONj1lRKn4kbF32yPJ9KtZVcpJGcBE=;
 b=sW7o/1BTGgKYPnO4gFdCIlkOXqmGx03Gap77QUcK601fSHJY7KzlWsxZiZ1s7/v2P1
 HYR5KrCL2SrwA8M1gb9QJ4fmgTgevFAak+4xBX8wAlzyWFgEBx6nGUkssy2ByOpEeIMB
 UNjlKn58vMPUH8pXm1WbsXqWLQA6+a0dMXVbcbafDxS6PINO6rPk6NFzXEq8hdkNMvrQ
 tH8i/4LE9R+VC3XdTD3eq+PyDYJndk3fIgJSJHCS2/zmcP40i55ItGp/1VJaS9B7EXzf
 SbmvDB54Dq0SH6sgob2E583ck6S0vY10529p8N3lIMUnJ4c2RlHgrCSI6kibhnD3fDJ1
 ZvxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744123431; x=1744728231;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zZClw+jHIcxPT7ONj1lRKn4kbF32yPJ9KtZVcpJGcBE=;
 b=jtZTSToM6W/2fWu8dh3fU0z6bPj4gS/dI/9xLh0KYI3K9uQ4OjaEAu/zUUA/w35JEN
 prNfj/7rmFpOlUcy2vrpF/meUn2Du9IPMzvpvO0xyNPGjyuueiwRjPykcIQdBLTb+SNV
 IHdacLJdFd/VIvxwLGPGmWC98wHE0dalYtTtUg18qvFKdQNzYSVM6vuRPHdOWcFVX/yp
 F45lDAicq1QRsWUrxX3C+QvdnvbRasktevF146ZdJk0BjsnlN9Se5H++09y1v9C8XVKM
 NKfRg8Shsv8nSyJWDWxPUMC3OBmIXgV9ADcoPOvMgFTnEAhPJcAQ2wIha/zTXXZOUqW3
 QSzw==
X-Gm-Message-State: AOJu0Yyx1NKb7Aj+v8wMS5ASd0+4ObrhgG3mJwEtfRhCbsmebfFxvUvS
 vPDH1qMraPOsA73/qrBUybY6OM9eFIUixF0HL3pDeuoFSufiZasR21AYWw5tDS2Z7+nl53krwVd
 Q0es=
X-Gm-Gg: ASbGncv04vrvr9/vZppX1v483vHeZVDLnkAgkcfpqFMh5YRIC1r83MoV2hT+fymhot5
 zz1tjRFns6CqF7AcMQBirg8MPIvgNL9Zsj8dShUmT4Z0dpiXbwuzHAIpmMtMQhdI6Cze9HdfcZa
 1/82lFcZgET0BIGKZuJo/TUPGZApTMPN969/hPoPqPgBheU/WYLhTX2x3Vq3VmDUuDJZ5uR0H2Q
 hFEH7dqSLxOiyv9IqTGa0VISBkVWarIU6CFEKzWPyvZBXnm1jD+eh0iSbTLeqcsNg5+UIVw6x5W
 Bdm17CNtAc4Y2jjyXrGDa0rHbxGDU7AqsQuRVJcw8z9RJWcMy9M6pBiFNR+U6rLduACAhMhZ
X-Google-Smtp-Source: AGHT+IEtok/kPvlCwQblnbFEMsFV2+580aKVo3R4sbzFAMAxSgf8xKKv4DOkc1NvNpla8K8FS0mYag==
X-Received: by 2002:a05:6000:40c8:b0:39c:142d:c0a with SMTP id
 ffacd0b85a97d-39cb35bda23mr14338365f8f.19.1744123430645; 
 Tue, 08 Apr 2025 07:43:50 -0700 (PDT)
Received: from [192.168.1.47] (i5E863B08.versanet.de. [94.134.59.8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec364d036sm162408765e9.26.2025.04.08.07.43.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Apr 2025 07:43:50 -0700 (PDT)
Message-ID: <deb7ccd0-978b-4b97-bf67-de540dc02fe6@linaro.org>
Date: Tue, 8 Apr 2025 16:43:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm: dts: Add override for RB1
To: Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, neil.armstrong@linaro.org, trini@konsulko.com,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20250407132810.35149-1-sumit.garg@kernel.org>
 <20250407132810.35149-2-sumit.garg@kernel.org>
 <baa7e896-a286-47ed-bd9a-18338978fc0d@linaro.org> <Z_UouNz11eRxIIa-@sumit-X1>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <Z_UouNz11eRxIIa-@sumit-X1>
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



On 4/8/25 15:46, Sumit Garg wrote:
> On Tue, Apr 08, 2025 at 02:17:29PM +0200, Caleb Connolly wrote:
>>
>>
>> On 4/7/25 15:28, Sumit Garg wrote:
>>> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
>>>
>>> Add U-Boot override for RB1 to for USB in host mode as OTG mode isn't
>>> supported. Also, disable sdhc_2 as it's currently not supported, sdhc_1
>>> works fine though.
>>>
>>> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
>>> ---
>>>    arch/arm/dts/qrb2210-rb1-u-boot.dtsi | 11 +++++++++++
>>>    1 file changed, 11 insertions(+)
>>>    create mode 100644 arch/arm/dts/qrb2210-rb1-u-boot.dtsi
>>>
>>> diff --git a/arch/arm/dts/qrb2210-rb1-u-boot.dtsi b/arch/arm/dts/qrb2210-rb1-u-boot.dtsi
>>> new file mode 100644
>>> index 00000000000..1e136ee405a
>>> --- /dev/null
>>> +++ b/arch/arm/dts/qrb2210-rb1-u-boot.dtsi
>>> @@ -0,0 +1,11 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +
>>> +/* This is usually OTG but U-Boot doesn't support that properly */
>>> +&usb_dwc3 {
>>> +	dr_mode = "host";
>>> +};
>>> +
>>> +/* SDHC_2 isn't supported in U-Boot as of now */
>>
>> I'd rather avoid disabling this here, I guess it's just missing clocks and
>> regulators which doesn't justify modifying DT. An error that mmc1 couldn't
>> be enabled seems fine to me?
> 
> I totally echo with your thinking that we should avoid modifying DT but
> at the same point we shouldn't enable peripherals in U-Boot which throws
> errors. It's also possible that U-Boot misconfiguring mmc1 which might

I disagree, DT isn't enabling or disabling peripherals, it's describing 
hardware. U-Boot lacking proper support for that hardware isn't a good 
justification to disable it. Especially since you might boot Linux with 
the same DT and now have no working sdcard for seemingly no reason.

An error in U-Boot is exactly the behaviour we want to see, masking it 
only created confusion.> turn as a problem for later stages.
> 
> I have been totally working with a remote lab to fix issues on RB1. I
> will soon get one on my desk then I will be able to fix mmc1 too.

In that case we can surely land the proper fixes for 2025.07 anyway, so 
I'd just keep the errors until then.

Kind regards,>
> -Sumit
> 
>>> +&sdhc_2 {
>>> +	status = "disabled";
>>> +};
>> -- 
>> Caleb (they/them)
>>

-- 
Caleb (they/them)

