Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C4ACC27C53
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 20:10:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FC46881AF;
	Fri,  7 Jun 2024 22:10:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VImJcU9O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DBFD884A7; Fri,  7 Jun 2024 22:10:11 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AE9888047
 for <u-boot@lists.denx.de>; Fri,  7 Jun 2024 22:10:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a6267778b3aso304237366b.3
 for <u-boot@lists.denx.de>; Fri, 07 Jun 2024 13:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717791009; x=1718395809; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5sek5eOlErMdi7XCVZd4QsuduzhydLqF80l/WFD46ps=;
 b=VImJcU9OujDFEnwU1vlHCB4C6uyGUGP3wsq23hxyexGfZN7X13sWk1dBwYNvQn0IQE
 1SEfC8K1OdCZf4sIy90roeQhRGieTdFMF0CMqpyqV5wqGXG4yCdxOgsV2Nae5AKTtydo
 4MxZSrEb67MdXdUtCrxXn3MPIsUl4mtDKdn3mjSnwiSfZDUCG8xTqFzDt5eYF6eBJ9aF
 dv4DjuKmeEQKm6OfQkvetcYAsvrGHtsGvD7d+W1232xZiYjKv3xvZA26yy+3XuoGbI8g
 F4U7SBIJh09EMphThqSYB9zdgzpKMNj25mpjhF3Rse9VzpIWiGupfckeH+6RKqoUfiX1
 OBiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717791009; x=1718395809;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5sek5eOlErMdi7XCVZd4QsuduzhydLqF80l/WFD46ps=;
 b=ZAoZ0/TuTwA+UJuZngsP+IBFKllGp8iMwYBjSrrrwCie4+EvLdqVCc6gJ8EG3pil3w
 yEa+IqrZZ9No7fiNDBYXpkHCtQbhIj/aFkQ4gQtzK8ohpPoKcvRZ3j47F6NKzFtoWxC8
 DkCndhDl44B4A0ffricA1yayYJKt/qx6bF+alAhCPBAlit7zfCLm6JsuQUYmFLhescR2
 v4LE/JWo8XYViGYkb36sWLL5WWVzHKUgwwN8SrP2wYqeO4DDYfKFR5KEcsMzFbd0k2SR
 4uaBcHR/waGBf+1ci8NEJ0PnytuzNY1AqqZ+bCgaF2IjT1cmHDLQroEyXzG2OZkb7X0i
 0ZYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdiVzXEmVAnt4rBi3IPTI1SHg6le44LgADYiUUdZWSjL1xY7Xnc1cxm+H5qdGIpybuPafkRPBgIXNuXoV+2X7mABEoyQ==
X-Gm-Message-State: AOJu0Yz0AFTyXJALX0M/7B5Ew20Bdu9LsgVDjXb2hG7b0+cV5BHsbxAd
 Un0o/r17lGxXoqys+wrdnR9fGxa0oEBoUQGQYECKrRL/E5o5vbl5LSgd3Cx+y5Q=
X-Google-Smtp-Source: AGHT+IHmnZt7QM/lf4Jtr03/+dhaf+TQ8jUhSdRqvZXF+uzyzXAtrGm0eDzP7jCwXqQLBGrPYq2TbQ==
X-Received: by 2002:a17:906:2644:b0:a6e:f8dd:d2fd with SMTP id
 a640c23a62f3a-a6ef8ddd398mr53678266b.29.1717791008612; 
 Fri, 07 Jun 2024 13:10:08 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::8090? ([2a02:8109:aa0d:be00::8090])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c8070dcd7sm292288966b.180.2024.06.07.13.10.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jun 2024 13:10:08 -0700 (PDT)
Message-ID: <66b2bad8-2f68-4ad7-a580-cce9613fe797@linaro.org>
Date: Fri, 7 Jun 2024 22:10:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: add software pagetable walker
To: Tom Rini <trini@konsulko.com>
Cc: Michal Simek <michal.simek@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de
References: <20240607-caleb-upstreaming-v1-0-99094dabb3d9@linaro.org>
 <20240607-caleb-upstreaming-v1-2-99094dabb3d9@linaro.org>
 <20240607170050.GJ68077@bill-the-cat>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240607170050.GJ68077@bill-the-cat>
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



On 07/06/2024 19:00, Tom Rini wrote:
> On Fri, Jun 07, 2024 at 06:51:20PM +0200, Caleb Connolly wrote:
> 
>> Add a basic software implementation of the ARM64 pagetable walker. This
>> can be used for debugging U-Boot's pagetable, as well as dumping the
>> pagetable from the previous bootloader stage if it used one (by reading
>> out the ttbr address).
>>
>> One can either call dump_pagetable() to print the pagetable to the
>> console with the default formatter, or implement their own pagetable
>> handler using walke_pagetable() with a custom pte_walker_cb_t callback.
>>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>>   arch/arm/cpu/armv8/cache_v8.c    | 202 +++++++++++++++++++++++++++++++++++++++
>>   arch/arm/include/asm/armv8/mmu.h |  55 +++++++++++
>>   2 files changed, 257 insertions(+)
> 
> So, I assume that by default, all of this gets discarded as unused code
> and that's why it's not behind a Kconfig. Next, please add something

Yes, a basic "strings" check on the U-Boot binary suggests this is the case.
> under maybe doc/arch/ or doc/develop (I'm honestly not sure which is
> best) that documents all of this. Thanks!

Sure, will try and find a suitable place for it.
> 

-- 
// Caleb (they/them)
