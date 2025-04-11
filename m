Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1A36C36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 14:48:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4B5A84033;
	Fri, 11 Apr 2025 16:48:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VmtSTVJi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0003840C9; Fri, 11 Apr 2025 16:48:35 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAB0784006
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 16:48:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-39d83782ef6so2012795f8f.0
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 07:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744382913; x=1744987713; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y5Kssn2yNVeg2Ls2XVfIFMvBy5oStCcoU3mnPWYIKWE=;
 b=VmtSTVJib3UgLshpPfIyAN6H4vMknz2YML2th6a6dHMOfBJuhAevumRYFkw/pVTgWH
 p1oaSeQVZp/BtXx3n3BRZKPrQ24+YRj4JQATHGpeJmGey1X+i57TUwMdWNP6mIXdvayQ
 snYSO/h87uHscaPEZ2nD5ucbIXdbyz/PLoiEekzf00zJ1hMkURTJl5BuVa2KHBluvbhD
 ewE0tReJV9n3FIUmRqkDqZDBkd9qfXABvjKt/pZvi4HrM7UY2zGKpAWebp7bqQ9TqHrl
 bZNJ8gmgvziLpkZ+yZSD4WjqGvq3uRTvbQk6enczDvXg+c52CpPcmXhIw2msujueo+5S
 Rglw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744382913; x=1744987713;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y5Kssn2yNVeg2Ls2XVfIFMvBy5oStCcoU3mnPWYIKWE=;
 b=nVp49tSZDUonJsUdbBYRiVmvUXTQB/MBvvHP9lmqQu9yfjcGCHQz79HnrV1HBpF/Ir
 UcdN/XCTQykm03n7htJcsKryM+rz65qUKhE0Pe8c/BX+WqY6Ea40FZXhkYHinJWBzCJR
 ZbsTj8tYeUJ7fCPd7xtifpRKFmK6Pdht+4w/uOzAc3hPL55nbjKj8WyOzYxulaENQDFb
 RjrA9TlfuHLg+ZY72ZHAdUXFhTfBuZtz1xcI/Yy2IGdEz+UALzcI+uL6QVispn0pAoH7
 nu4Qwl3fuFXBOxTRntvtzSLAIuLlw+p6mb61v38/cYHV9NGX3A1pSfTyVyy09eg2/H3T
 Dypw==
X-Gm-Message-State: AOJu0YzPpUypHhE+GBkNU20+s74WYXnGhmz5Net9F1J/2lM5d+iShA0n
 nSfCJ8Zv84JY3LRYeUosmKUGxrJ42g4fL14hOXRvCGx4ImEbzlp65zIt7TIDW4I=
X-Gm-Gg: ASbGncsI3ZB7X/3CKxh9kbwK1OhNi8SUnyADNjV4rpAAGpuJlOihoYc6xjM7xCHALnJ
 nNjifzHiA3pzvbjlmA9WzXpotVyTuC1pitWyPMTzk/ezmKR9KNaYbVp8y25UMLMEmXUGFvd1RzC
 YVTi7HznFKqJgI2WWdszxdnCPWLcMZOcNHt0AkOaQit2K3IcH88S8zaoLTol0kqLmA8vCDK3pN+
 eBVT0jexGTRWLSHOVVBGhL5u7/I05dHZ8a2KDNkGT0S5X7pX0dmpActQmzz2LXW/wwPInP1cFv6
 0ziJqUDc0HK5WDNEzwgIOXCwtlQbXs25ufMuAY6ly76TsBiz6ByKFti4WHv9UTdtWhk31PlpZwx
 0Ph8yfWG9sRVmLhs=
X-Google-Smtp-Source: AGHT+IEom+FljRx9/2THYp1yn4SE4s4+23kOFKk8ueie7qSsPt1CpFVj9Z65rTD1V3PEPfdgDJApbQ==
X-Received: by 2002:a5d:6d8c:0:b0:39a:c9ae:9eea with SMTP id
 ffacd0b85a97d-39e6e48e276mr2884533f8f.10.1744382913116; 
 Fri, 11 Apr 2025 07:48:33 -0700 (PDT)
Received: from [192.168.1.47] (35-60-142-46.pool.kielnet.net. [46.142.60.35])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eaf43cc7esm2198233f8f.77.2025.04.11.07.48.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Apr 2025 07:48:32 -0700 (PDT)
Message-ID: <ba9cf6bc-800b-4a6e-abd0-faad53fc0541@linaro.org>
Date: Fri, 11 Apr 2025 16:48:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] mach-snapdragon: CapsuleUpdate: support all boot
 methods
To: neil.armstrong@linaro.org, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250326-b4-qcom-capsule-update-improvements-v1-0-afe2e3696675@linaro.org>
 <20250326-b4-qcom-capsule-update-improvements-v1-2-afe2e3696675@linaro.org>
 <ab310f36-bec7-42d5-b25f-f3e4d738e26c@linaro.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <ab310f36-bec7-42d5-b25f-f3e4d738e26c@linaro.org>
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

Hi Neil,

> The logic is complex but looks to be good.
> 
> What would happen if we plug an eMMC with conflicting partitions names ?

That would cause issues... Probably the more correct way to do things 
here would be to use part UUIDs, but it's not clear how consistent those 
are.

> 
> Is there a way to get the boot media from xBL ?

In the chainloaded case we could i think map some DT path from the 
kernel cmdline to the boot device, but I think just checking that if we 
have SCSI then the partition we find MUST be on a SCSI device would be 
enough.

In the non-chainloaded case, we actually do get handed a pointer to a 
shared data structure from sbl1 which has all kinds of goodies in but 
the whole thing is proprietary :(

> 
> Anyway, with the typo fix:

Ack, seems like the 'z' is how U-Boot tends to do it, though it pains me 
so :P

> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks>
> Neil
-- 
Caleb (they/them)

