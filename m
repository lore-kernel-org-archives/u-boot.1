Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C5C1C71141
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 10:40:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EF4282A4B;
	Thu, 12 Jun 2025 12:40:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XZWW3gqD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F09D082B70; Thu, 12 Jun 2025 12:40:33 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0431800C1
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 12:40:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a376ba6f08so484286f8f.1
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 03:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749724831; x=1750329631; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BNIpqI1uCX16ug4F6gI90i24UdJEfs+hOguPGm7O0jQ=;
 b=XZWW3gqDtRpeaUBerL27/Ewin/FHEyGidZBD7pHWAOhYNH4gegNaqrnPkM0EkufgEw
 iCmw37ScDnl5bLTzVaIaQIF2WZu9LDdrL577f9DBCOSNDuVpiTzTMB6IGZiF+C/WH8XR
 /45wOmw4SU+pksVXg9xHxTT7NBWLnFyd1LHOceRu8dljaE7NFtjWrIpgJH/YfDf56TRq
 XagA/EzhoB5rhisA3OkBvX/SbPfZXB3bcTzMZ9oUGsH4HQAjpI/VkO3+wgQBObmHTSm9
 hkalt2TMOsofxaeHBraiXUptn4FYOTRlrZrOeZVPAhtxk2H23bLbnoUZN6dGPrTY8LD1
 ao2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749724831; x=1750329631;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BNIpqI1uCX16ug4F6gI90i24UdJEfs+hOguPGm7O0jQ=;
 b=Mw8BktyBDk/g/Suf0YmOw95JSxeOkwWDX6RapxxkMV30j3RqN+lvwaA+opGjmA2qzy
 FfMnKhISDjanubQrhiAN5h30LPwc5B8sBAVg5ENI90+WGyig2KObKVPOifeYO9e+6fn0
 JeX8BiNH0XMRLOiu0hxVDmFmI+HcwLZJ9KHFGuV2QtXqJh2zNqKMxzpE+BXnvXy/kFgy
 vgmUApLN8UPOe6DPwOo+1IcPec8oGgiIRb8ETMmHDF1sHr84imE12OzPBALzVUzIYKl/
 G/l07PmLxhtOP1BHYYKGDjUFGLtUUcPSeJduNTuszDiGGtrfB6b76gMY3fmZsyCgbOkO
 fjxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVY/S19RPHZ5BB1YEdlQC9A1LpyQk8J9+LdcEMulcvA8LTIe8nXe4AR4UDdqIGkUZnBhBiV9XM=@lists.denx.de
X-Gm-Message-State: AOJu0YzmsbGIuspDydsjOOYJVcQ8YCZl1pOdubKT/IyQbrVl50kwpLif
 we+7o9pLMrJPKzdVO4ZAGc1MHkdJHuMUrPqLXj+4hQn9SwlpoYpamx/2b3kAAXz/wiU=
X-Gm-Gg: ASbGncshHWl5B6O+Bq5oicPbS1pHr1v5+4SUDPrGGaGQHZDq5ZtNboz9aUC2cLtOqnU
 rXVl3o32WWTF+0OrKCxAvS+o2Vb58mYd2ym2KUT0lqR0OZaZiVXhdJ5H8kfquosdtER3WhLPBJf
 9pd36kYt+eabFvae0PEXPRte9IvSBZyoLQrYm7sdARXq6jaqT9LkWYkYESkNLd/PHOpoKMA0zhP
 At4qD3+/pQwqonQ5+gzq5GoBCTUrmEZ4mdWI5XPWEMu9E0wv7vNvFVd2XWYosHdaJVXiQnq37h6
 R8HbWFS0Ce/rlb2Q6S8AIqxvmircm44hTiDSmLjeCpj03zVjKP15Jq1J7lQGJe3hqxlFWWS2tu9
 ORyG9LHlQodxB5DM8/tkFU/UIuhssSEWeWqAkmA==
X-Google-Smtp-Source: AGHT+IHU41K+XCr47EalrXpFrxxTcLqC1fvENVjHOSTTkBxCx/VdfUUHMBgDn3uHkF79RfrItYxvPQ==
X-Received: by 2002:a5d:5f89:0:b0:3a4:f786:4fa1 with SMTP id
 ffacd0b85a97d-3a5612f0d01mr2173306f8f.2.1749724830942; 
 Thu, 12 Jun 2025 03:40:30 -0700 (PDT)
Received: from ?IPV6:2a01:170:117e:fc:1405:203b:89a3:c77a?
 ([2a01:170:117e:fc:1405:203b:89a3:c77a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a5619767b3sm1660038f8f.13.2025.06.12.03.40.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Jun 2025 03:40:30 -0700 (PDT)
Message-ID: <57061d19-294e-418e-b74a-4c3d6411b9a7@linaro.org>
Date: Thu, 12 Jun 2025 12:40:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] Implement reset to EDL for qcs9100
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: neil.armstrong@linaro.org, sumit.garg@kernel.org, trini@konsulko.com,
 ilias.apalodimas@linaro.org, clamor95@gmail.com, robert.marko@sartura.hr,
 me@samcday.com, sjg@chromium.org, marek.vasut+renesas@mailbox.org,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250507070733.2871986-1-quic_varada@quicinc.com>
 <fb46de68-c969-433c-8f11-2dbc258afeb0@linaro.org>
 <20250612100924.wlowchclk3u7uijd@hu-varada-blr.qualcomm.com>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250612100924.wlowchclk3u7uijd@hu-varada-blr.qualcomm.com>
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



On 6/12/25 12:09, Varadarajan Narayanan wrote:
> On Wed, Jun 11, 2025 at 01:55:32PM +0200, Casey Connolly wrote:
>> Hi Varadarajan,
>>
>> On 5/7/25 09:07, Varadarajan Narayanan wrote:
>>> Using the 'reboot edl' command in Linux, the platform can reboot to the
>>> Emergency Download mode. Implement the same for U-Boot.
>>>
>>> v3: * Introduce a sysreset op that will pass down the 'reset' command
>>>         arguments to registered handlers
>>>       * Handle 'reset to edl' alone in qcom-psci driver
>>>
>>> v2: * Rebased to recent sources
>>>       * Dropped the first patch as it is not applicable anymore
>>>       * Bind the new driver from psci driver
>>
>>
>> Sorry for the late reply.
>>
>> This really needs some associated documentation, at least adding the edl arg
>> to doc/usage/cmd/reset.rst and the help output in cmd/boot.c should describe
>> the edl arg if CONFIG_SYSRESET_QCOM_PSCI is enabled.
> 
> ok.
> 
>>
>> it also doesn't build?
>>
>> ../drivers/sysreset/sysreset-uclass.c: In function 'sysreset_walk_arg':
>> ../drivers/sysreset/sysreset-uclass.c:93:63: error: passing argument 3 of
>> 'sysreset_request_arg' from incompatible pointer type
>> [-Wincompatible-pointer-types]
>>     93 |                         ret = sysreset_request_arg(dev, argc, argv);
>>        |                                                               ^~~~
>>        |                                                               |
>>        | char * const*
>> ../drivers/sysreset/sysreset-uclass.c:35:69: note: expected 'const char **'
>> but argument is of type 'char * const*'
>>     35 | int sysreset_request_arg(struct udevice *dev, int argc, const char
>> *argv[])
> 
> ok.
> 
>> ignoring that for a sec, I'm a bit worried still about how this behaves on
>> boards that don't implement this psci call, on sdm845 for example we just
>> hang.
>>
>> I think psci_system_reset2() should be adjusted to time out (though I can't
>> imagine a psci implementation that would return execution to el1 during the
>> reset, so maybe the timeout isn't even needed?) and return an error if the
>> reset didn't happen.
> 
> Would checking if the system-reset2 function is implemented in PSCI and
> handling appropriately similar to [1] be ok? Please let me know.
> 

Yeah that looks good.

>> Then qcom_psci_sysreset_request_arg() should print some useful error message
>> ("reset2 not supported on this platform, reset to edl failed") and bubble up
>> the error code to abort the reset entirely.
> 
> If the function is not implemented will print a message and bubble up
> -EPROTONOSUPPORT.

Makes sense. Thanks!>
> 1 - https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/firmware/psci/psci.c#n554
> 
> Thanks
> Varada

-- 
Casey (she/they)

