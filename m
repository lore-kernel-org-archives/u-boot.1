Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C15C35FFC
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 13:07:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA1B680EEF;
	Tue, 25 Mar 2025 14:07:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="f4eHmVfj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB8B48186D; Tue, 25 Mar 2025 14:07:44 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 613E4808AF
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 14:07:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43cf257158fso37501115e9.2
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 06:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742908062; x=1743512862; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xR/LsPLBprlbbFeyMm+UPxcowxoKRVuQ6bDEEabgZ9E=;
 b=f4eHmVfjvuSLPyUhOPBzPAloMxXXpheLIAG0ddbeTJOXJECCcaShQaSwtlt2GmxVWH
 FqTO+eMrhbGnXh5t0Fil9K0VcT1aCC4KazAx2lS8A0c3K35brw0s6GR2e/efEcw5Gmp7
 ojzleU0+KSnxsgGrHz9wubRtQBwRhNBo69rjpUi4iFwDCdd8nkO7M4QG6Y0iUuCpHC/j
 rletxnOq4PITtsCtfl0KbWJSoGXyduGk8uR1Bx2KN5/6QxHuPS6Z3jNR0gIDz6j2oWDa
 wxztAA3h40s7XsVW0Kl03hdGMwTePkzLp+S+MuciE33Qc63oQt251aT9weObO+IYzR5J
 s7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742908062; x=1743512862;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xR/LsPLBprlbbFeyMm+UPxcowxoKRVuQ6bDEEabgZ9E=;
 b=S/B3UU3J8rZKslqssP3OBCjui0Cc1/anK04TUySozwdyglnjaRwAo8wzXu+0LBYmNZ
 7qgSyfkHNnjkK3K/TuVQBYu9s/3KAuVEXYx4Hzuxj9RSMxJdRZDebaQKhed91Tt37w0J
 s0g/FLAaimMeQaT1ya+kdbV6ioX3Va6PaUFCA8K/30ctl8Ol0NSRAYkEgqSM/WkbE+T3
 yXh8Vw2j0ABUFjokL/Izmg0tfWGIDBJhpQRaUeuEuiSyTdvjqzbBE7HZp81w4lRlNBx8
 7xPe4YdsiV+2Ht305JVlqIgWTqJK8CG5SYS4RHdxB8frzPh80YSPWQ/6h9CUIukXEury
 3skQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWksUTUF0/8QgaydQ33GQkWi0PtfQX18++fSslOpOqMV40uflfGUzKBYsmo2KyKJwqj8P8a3LQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzkeCXXEojGx9eNXvdssaL3SWw6xUzraJ4CgF3ph/5MoyJ726+w
 JAuXGWy+ci3r8OVDVLOXTBA/6YzcD7eR5P0+ElB86lRt28rtDkHuU141xf950f4=
X-Gm-Gg: ASbGncsHLQZaMOA8KTWBECzf0H3waum9k9f03snT39H7k/KDTSsutTxJd1ilbmLWoKL
 +0CYQbuy7tBRM/h2Z7A8dZ6NmaL11qGrvcXKbKg+OmmgIR/Hrb35UepBD5AZ2QqzeFvCrBPqoxU
 JcsWCBb1wslvDqBW2+v2LycOSU7T8NuISXt1Swi3EuEo2NfjFL4MtKW3ipSRzOs0+j1vycBC/5+
 dkNAIhOzc/MKyL9g1bTUA0T6B09Egi6zosswphk8li0ADgi+63mipPVoHd4dkiJD53F6Uv+Kdq/
 zqHCi+DDhOSqdubPE+M5RTqS2QFNIvK0X73ruohprj0MVfUQf57RJNBYacVADZsjCu4R4Yu8uuM
 =
X-Google-Smtp-Source: AGHT+IHF05Zo4kXW80dWPJ0FOZxWtnfYQwVOEf1jGpS4xHZGkGZgvNMBdd92f5fkG4O0+xmL2ZycHA==
X-Received: by 2002:a05:600c:1c19:b0:43d:db5:7b1a with SMTP id
 5b1f17b1804b1-43d509efb48mr141065645e9.12.1742908061732; 
 Tue, 25 Mar 2025 06:07:41 -0700 (PDT)
Received: from [192.168.1.38] (i5E863BED.versanet.de. [94.134.59.237])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d4fd9e960sm149488685e9.29.2025.03.25.06.07.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Mar 2025 06:07:40 -0700 (PDT)
Message-ID: <f8e4106c-5f48-4677-9571-deb5abbddf5e@linaro.org>
Date: Tue, 25 Mar 2025 14:07:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL] Please pull qcom-next-20250324
To: Tom Rini <trini@konsulko.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de, Sam Day <me@samcday.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>
References: <20250324181903.499245-1-caleb.connolly@linaro.org>
 <20250325020117.GE93000@bill-the-cat>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250325020117.GE93000@bill-the-cat>
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



On 3/25/25 03:01, Tom Rini wrote:
> On Mon, Mar 24, 2025 at 07:18:12PM +0100, Caleb Connolly wrote:
> 
>> Take 2, this includes that build failure fix, sorry about that.
>>
>> CI: https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/pipelines/25297
>>
>> The following changes since commit 0e1fc465fea62ebae91f2f56cb823e8b37ee1077:
>>
>>    Merge tag 'dm-pull-15mar25' of git://git.denx.de/u-boot-dm into next (2025-03-15 08:19:31 -0600)
>>
>> are available in the Git repository at:
>>
>>    git@source.denx.de:u-boot/custodians/u-boot-snapdragon.git tags/qcom-next-20250324
>>
>> for you to fetch changes up to dcb6a5e7651f4a6cebfad4389119407e2a852783:
>>
>>    mach-snapdragon: always select SYSRESET_PSCI for ARCH_SNAPDRAGON (2025-03-18 11:55:14 +0000)
>>
> 
> I pulled the merge commit message out of v1 as that looked right. And

Oh thank you, yes that's right. I thought I had copied it in :/
> please note that b4 doesn't support the "git@.." protocol. Which on the

ack, I'll update that for next time.
> other hand is useful when I have more to say than just applied ;)
> 
> Applied to u-boot/next, thanks!

Thanks, and thanks for bearing with me :)
> 

-- 
Caleb (they/them)

