Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA61C7EE30
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 08:56:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A8B581FEE;
	Tue,  1 Jul 2025 10:56:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wmUDfytw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C44581FEE; Tue,  1 Jul 2025 10:56:23 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56AAF8003E
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 10:56:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ae0b6532345so1243096966b.1
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 01:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751360172; x=1751964972; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HqtW80X3sBswjQTxRB9BiJYVvcRbeb5nwBjTGPBcLVs=;
 b=wmUDfytwmiJ7mWUVkCom91utwuUSdatpDeFmU2QiVtroypyE8jbsneMFYyMT9WsGSL
 dxvMiLtSxtZzzzivdhZJcs7qUCs5ve3F2qMmn9ISc2pJs7eo1JJ5n6fQ1w0Ahba/So4A
 KwaRi+/9MMrw1PhUPkWWlEcgtAw8xH4yBJsyHMXS/GrUTdFzpYwTFw9tq4IerD6bJN05
 tv3lhYJ2IyPRMn7dWQDSvSFPpLFQNBmQFMBZVfAHi9YzEcixj5+PJ60mCpYuXSifkytP
 4CWuwUN8G7nUM1EachBD1zVGqDEfSq68jGCV2/QR0QeGy27SUqx2pAQSPIh0TnRvNPlw
 izLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751360172; x=1751964972;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HqtW80X3sBswjQTxRB9BiJYVvcRbeb5nwBjTGPBcLVs=;
 b=MFYmrZvmLRLl+hNhRJSHtKPiqzun5C6Et047Yx8mS55+USNPhbk/oKHmYpk6q7q7AP
 TdlQUBS6NOiRNhmRIDTKdsPQxXSUvrHlumlVr6YlJ31kNIt9Vopcnp5cy6LBaUozQGPR
 z+knktQKK2A55XtDgike/6hHgGbhTUPr9DeRo+E2U/2V4xMIf1CjiqLw1/P8seNaDDOQ
 8JGH5m51Yan+rN/5h4SQLuOksa5S0eOKJPp2XaOkDnxa4+y74ZcYdadLsUz3cqBBSe+C
 YaADEvZAmwYQjJOmkTSbfGGs4MlTudrbqS2Xlye8Q+zSV2PDksKgndRJN9onhoTE1I1j
 o77g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnDze1pCtOj0GXmJLJt2mQOSMwQ1udyw1XDpMc8l/EwsWfHM0U6FZVtxdf41oGC0w+RpYLwH4=@lists.denx.de
X-Gm-Message-State: AOJu0YyDFY0FpgD5zR5POvkN9mZSmO/AbQU8tiU55TWplr6UHegVcIj5
 nKOT9d9iYj4SNpMBKFIyda8y+QFFz9fq3k4sMGl1i4VNUVRqNlzh5l2qQcm5CeWqplE=
X-Gm-Gg: ASbGnctdzhz97OunHVv8aY3XiWwborVfNjPKGsHMaRjrswww7Df1E6eimoIa3qmSPBt
 3AqzgZXKZ1ZkfksgoWzJkQ5FNys7+KynZYFxYEskxVzysYb8EkCsHtEo9AXPoXWYjhcHMygXImQ
 hSpDK/nZpuMoOFBPjFolYePUGz8Y7TnDrrFVfVIVvzKI6FQHAAdw74qqahBqFm7sR/McXlS1ZyI
 n4eZe/0ssV0Iawm+1t7OSKgoJbjSYdNSwe3KKPZaG3IV8y0npMdIkMkeQPpyJ757GqNhx+2ajCa
 clKlUEmnINV2Y6+PSraVx/5JlpI8jMjGhoj+/uXEEv/Ji32SN2uogMatHewSWlZG8fGD
X-Google-Smtp-Source: AGHT+IGae9jHhRboiPny0GxDYvIl0328uMgWJqcdAZPBMcH1G7PvOYdpiamSZz7xtq6d01/zQVs3TA==
X-Received: by 2002:a17:907:7291:b0:ae3:6038:ad6f with SMTP id
 a640c23a62f3a-ae3aa022418mr249998666b.3.1751360171554; 
 Tue, 01 Jul 2025 01:56:11 -0700 (PDT)
Received: from [10.5.0.2] ([45.11.80.135]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae35365a19bsm835916266b.50.2025.07.01.01.56.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Jul 2025 01:56:11 -0700 (PDT)
Message-ID: <4df420f0-6329-430c-a40d-0bbcdb78dc23@linaro.org>
Date: Tue, 1 Jul 2025 10:56:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] spl: fit: Add ability to jump to Linux via
 OpTee-OS on ARMv7a
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Janne Grunau <j@jannau.net>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Sam Edwards <cfsworks@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20250630000832.952206-1-marek.vasut@mailbox.org>
 <20250630000832.952206-2-marek.vasut@mailbox.org>
 <198d53d6-bd1f-480f-86a7-5bd2987cd2a7@linaro.org>
 <c039089e-fc89-4cb9-9d98-86d0ecd11e1b@mailbox.org>
 <A5953878-CE64-4422-BD43-644C8C5F0A2E@gmx.de>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <A5953878-CE64-4422-BD43-644C8C5F0A2E@gmx.de>
Content-Type: text/plain; charset=UTF-8
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



On 6/30/25 18:51, Heinrich Schuchardt wrote:
> Am 30. Juni 2025 18:22:10 MESZ schrieb Marek Vasut <marek.vasut@mailbox.org>:
>> On 6/30/25 4:30 PM, Jerome Forissier wrote:
>>
>> Hi,
>>
>>> On 6/30/25 02:08, Marek Vasut wrote:
>>>> Add support for jumping to Linux kernel through OpTee-OS on ARMv7a to SPL.
>>>
>>> Nitpicking: OP-TEE OS
>> Is this the official spelling ? I was always under the impression it was OpTee-OS . but maybe I am wrong.
> 
> 
> OP-TEE (capital EE) or OP-TEE Trusted OS if you want to refer specifically to the secure side implementation. See: https://optee.readthedocs.io/en/latest/general/about.html and https://github.com/OP-TEE/optee_os

Yes, and the spelling 'optee' is correct when referring to a driver or subsystem
in a commit subject.

Thanks,
-- 
Jerome
