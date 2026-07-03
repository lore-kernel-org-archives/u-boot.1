Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 599E8C43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 13:18:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFE7A84A35;
	Fri,  3 Jul 2026 15:18:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jMn4hHqv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4E6E84A4C; Fri,  3 Jul 2026 15:18:38 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 024C1849F6
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 15:18:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-493b6f1b14bso2591035e9.0
 for <u-boot@lists.denx.de>; Fri, 03 Jul 2026 06:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783084715; x=1783689515; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sQfWG2RBtQ6fsVdS1WgVbfKcPtRtRLTKby81F5wddu0=;
 b=jMn4hHqvXA5C5WEcovtqnlo4212s3VPIrktsAYYmCwlEIp6gWxK7xyBEoFKUkVLzMJ
 AavZYx8lSUIFUpQJwfEuftk5Lg30STdTZiWzWIahFhoRd0v8eJFQQ/9EuOt3jeciIE3e
 JCRjc60fkau2Eecq4agGRrWDi1MRbhm7XK6zxVVLPXHpHB2nsy/S0BJ9HdghId344YhX
 Bu5/+K8LQvLxIae/hATxcsgIH8k0CYBVJ+d2m62u4BBLv1xTjjj+5vYQpyh9dDu0wcdj
 9xQy2eYKYg56UqdNZ75mHBqhPJe0UDL356566lFGylW0JkpeRY1FfhzpzD+EaB9YdMqe
 SH0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783084715; x=1783689515;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sQfWG2RBtQ6fsVdS1WgVbfKcPtRtRLTKby81F5wddu0=;
 b=VWIaPkqXMYYCwtF92a7NuH9QyZbcsCoY6a4AdASXO5+KbrSK5R1wXbvJi3oB7BhEHG
 H4Jb0sSzJ5QMhyu4suB27Oq2ewXTKUQc9VX7HLVB9GYYJS4V10d77qCcpFqAdeFbwPYn
 xivfEatSybZi6FBcAi3JVa4db8nzk6RxLg5svKdOuF2rg3b8gbS2NmQp8k4gyPfpXod1
 fx4mTmHLoyUCzNQMaeG1IRLcHxERrEMt1R+tVXQWuq9IqHO8qTzMc4cN45l1u5IYScPw
 YBlYIze33/ko4gOWp4WyMqUhi1sbnW++/qKjK7A31sJxdvejX5RQZSUwDH4wtUxbKmWq
 cjGA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8gN28GY0u1W2JpobtjINTkoG8PAWGMVp7nVc74+WlMIonKIBvqbA6NJTcjH6cL+kbuMbCXvbw=@lists.denx.de
X-Gm-Message-State: AOJu0YzkqK75Z8DbSMS6J5kfFdbJ77jZlkLryzWY4Abo555LstnhEQZ7
 aBD9ddrtX+k1J7zjOX/Mb0KawdRh3ls0PHHA1EVtSOgqmoH6k39RcjijoJP5GCxQGcc=
X-Gm-Gg: AfdE7cl7YfzbWxUPAT22LAj8itlQlWIZiQXVF2TWarNoasXLtLPy3LoTnCvxqLigyEw
 RkrMM+Kl94mkyEV2qQG4bA2rJ/CucRoB0gO5UNv1qXMGZJ5c4zgaa4cpMl35PDozbYPv5l5dJOV
 xsFpbligRCQwKTecEOgyuKgd3635Y1wp1DDvaYirEVG5X/1Ju6gyS4jxMiyUtgHUM+WCQ0XI77G
 oyvqxd60vHlYsNi2a+YF+0k7ojJ78D0C/9E8tRJb8EVx0Z/Ef8aqtFpkuzXk9v2ZwNmh0VrqT48
 FoBFGs8FCh9zGVhCrDYlKhJX3WvUtgRJ6YW3ctggqTrVU0SA6N0lphq0jxFUtoVctJdYiHaF04v
 uzpUFPUbesAeJYIanbQNfUf02Ad1pfaGNpkd2OXBor334OtodOSNEyRxSbKmMMaHtxuhtBiaUkh
 qbfp5UL1jtD+AZL7Lo+PXYRg+5Lu/YAX8d8BeAlnjXoV6IEfdY8xliEMM=
X-Received: by 2002:a05:600c:3f08:b0:493:b811:e549 with SMTP id
 5b1f17b1804b1-493c2b981ffmr133024865e9.29.1783084715279; 
 Fri, 03 Jul 2026 06:18:35 -0700 (PDT)
Received: from [192.168.1.245] (p509936c9.dip0.t-ipconnect.de. [80.153.54.201])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63172fesm229252685e9.0.2026.07.03.06.18.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2026 06:18:34 -0700 (PDT)
Message-ID: <2eb40799-7fc1-4c4d-8ebd-8a61f8ba1e53@linaro.org>
Date: Fri, 3 Jul 2026 15:18:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] configs: qualcomm: Add secure boot config fragment
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, trini@konsulko.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20260701122225.1628456-1-aswin.murugan@oss.qualcomm.com>
 <6f8e31ce-8e3d-4b91-807a-c2252301456e@oss.qualcomm.com>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <6f8e31ce-8e3d-4b91-807a-c2252301456e@oss.qualcomm.com>
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

Hi Aswin,

On 7/3/26 15:01, Aswin Murugan wrote:
> Hi Casey/Ilias,
> 
> Thanks for the feedback and apologies for not providing enough context 
> in the commit message.
> The intention of this patch is not to introduce a complete Secure Boot 
> solution by itself, but to provide a common configuration fragment that 
> enables the EFI Secure Boot framework and the required hash algorithm 
> support across.

Since this is just additional functionality, and we are hardly space 
constrained on Qualcomm platforms, I think it would be acceptable to add 
this to qcom_defconfig (with the exception of PRESEED I guess).

> When these secure boot configurations are enabled, a persistent EFI 
> variable store (ubootefi.var) is expected to be present in workspace 
> before building. Platform keys and signature databases (PK/KEK/db) are 
> provisioned into that variable store using the efivar.py tooling.

Then you should really propose some docs or at least roughly outline how 
this works (maybe pointing to the existing docs?). In the end if we're 
enabling functionality it should be clear how one might use it...

> At boot time, U-Boot loads the EFI variables from ubootefi.var, and EFI 
> image authentication is performed using the enrolled keys. The 
> expectation is that kernel EFI images are signed with the same keys 
> enrolled in ubootefi.var, and are authenticated by U-Boot against those 
> enrolled keys during boot.
> I agree that this fragment alone does not establish a complete platform 
> secure boot chain. My goal here was to avoid duplicating the common EFI 
> Secure Boot configuration across Qualcomm boards that use this workflow.
> Suggestions are welcome on whether this should be handled differently. 
> In particular, I'd also be interested in exploring Ilias' suggestion of 
> integrating efivar.py into the EFI loader build flow so that a default 
> ubootefi.var can be generated automatically from the EFI loader 
> Makefile, rather than requiring it to be created as a separate manual step.

That sounds good, but we're missing the forest for the trees a bit here. 
I'd love to see some docs explaining how I might go and test EFI 
secureboot on my Rubik Pi 3 (for example).

Ilias: do you think it would be possible and/or sensible to have a 
generic efi-secureboot.config fragment in the toplevel configs/ dir so 
that it could be used easily on Rockchip/Amlogic etc SoCs?

Thanks,
// Casey
> 
> Thanks,
> Aswin
> 
> On 7/1/2026 5:52 PM, Aswin Murugan wrote:
>> Add a common configuration fragment for EFI Secure Boot and the
>> required hash algorithm configs to reuse across Qualcomm boards.
>>
>> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
>> ---
>>   board/qualcomm/secure-boot.config | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>   create mode 100644 board/qualcomm/secure-boot.config
>>
>> diff --git a/board/qualcomm/secure-boot.config b/board/qualcomm/ 
>> secure-boot.config
>> new file mode 100644
>> index 00000000000..21f567e1a45
>> --- /dev/null
>> +++ b/board/qualcomm/secure-boot.config
>> @@ -0,0 +1,6 @@
>> +# Enables EFI Secure Boot support
>> +CONFIG_EFI_VARIABLES_PRESEED=y
>> +CONFIG_EFI_SECURE_BOOT=y
>> +CONFIG_FIT_SIGNATURE=y
>> +CONFIG_SHA512=y
>> +CONFIG_SHA384=y

