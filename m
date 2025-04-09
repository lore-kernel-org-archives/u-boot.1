Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DACDC36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 12:27:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F38283622;
	Wed,  9 Apr 2025 14:26:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MRhVInYn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38EF68363B; Wed,  9 Apr 2025 14:26:58 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2031183544
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 14:26:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5e6167d0536so11550329a12.1
 for <u-boot@lists.denx.de>; Wed, 09 Apr 2025 05:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744201615; x=1744806415; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/N/4KVNkkD6KPWR+v0kFFGnNht0jLHPRrGFOzP9JTGY=;
 b=MRhVInYn3PgSmFeNIITIdAyuNrC5HbYApzl+4klv8RAyEG5YA2n8wiiRjwm6h79IkR
 Iatp6ELQ7J1xqe20UDdZCWsZqgPTlYsBN+59UUKRU2KDHmCRD6P9pPvkvWfKMK3YEQ6f
 2pV902CmXCqCbtxWlM4f7Hk5Wk7+fwyh9GjdGVy5zPMMMqRJPrazOD4U5V7poePlzmd+
 yODjE/BR4AD86bZS1RXeHv4I8RqLqGVr6qVBasX+1bYu2m8xq2JDC2DNBn1iGIukmNkb
 gAYyb6JwhYeAXhezx9CTbzeTnaA6n3ToTFooldoNZ/8CkDzr9d/qQc/WUqYgZeRtFcBO
 3qcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744201615; x=1744806415;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/N/4KVNkkD6KPWR+v0kFFGnNht0jLHPRrGFOzP9JTGY=;
 b=VqFPWdjOmfIBkO1SDQTtbMbrun2/dqw+HOyaA9n8wcVAlDTn022obz85pU5pxX7Goa
 eBM07H6z05Wzlz/dRvDYl45XqKzkSMvAt8IqEapp0fBfbiIash028RMZ9Q2RpA7qbybO
 iWnDNw8JpVbOjwiqWmXKTLjkkiMp3mUCZZ5tnqjwZD90rbcm2bet+3LNqylIaEeaxzvf
 vqEXzW+KOFKRXe1pufsaBiD36NXJJZ6WvVzU1zWihv0AI7w83z9lmpbpF4bj0Avnyxt6
 k0RODCj0S7mBMgCsuKxioZuh86P6r7NhdwWGHnoJrdCsw/cIi6wreKMRIn66XukoH3fd
 I+SQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPCrQlThQL8P/2DXC2mcJWsxXQFZfU9FYrMqhQbp6FN1SGLpJm09T6UmZYVVwBxZYxaNN2tgg=@lists.denx.de
X-Gm-Message-State: AOJu0Yyh//DrEo1zAqK3gi6DaT+9+AcZUESkLLcNWZ+KrszmIuoo68MS
 hrmTuE4TRHffaHXvFUzq+i4Pyy2w9OH1NKdNp8KrhaXu4qh/CJq+SVZhTDduVg8=
X-Gm-Gg: ASbGncsW/zy/rI9IMMaptjdgsk4GnjtWu/qXbJIsKCgeW12oUGzEo3HSUWu8rU9QIne
 kP39MqsZOyp9E72LuX6xOBnbedWin38PDXiWLtKtwHR9VBShkf+CRAiXrD2Z9u/PyoXJ+CyHz6K
 n7fSpf6kdqO15FlsbtNjc1zqCFkSlnni6e5Jxbg8H96YM+RXfOebeTuMjX0Ai4xhCueG1QNQ6eo
 mtrjek8X2CXq2gHjGA7rDq3JRvnqEjABmH9cbxHvN6rbFhYq/HBSbouXHM9egHB5w2GSbUm1RAX
 550nrzSY5vuD330XYpmaXSSmY3AAwgXKhNkzSfOEL1nHnQwPdO29o8PLfKAVdCNH2PGUTYG78qL
 RNdvbT8vp0xBlOdF6sKGPa3BVo0Q4
X-Google-Smtp-Source: AGHT+IFCkeoQCL1f2JfopRD7rYuRCMeSYdcjDQUEqegEnO+mWRkkVa7ZYthdEJUbADJ5eeloNgUumg==
X-Received: by 2002:a05:6402:254e:b0:5e5:c5f5:f4b with SMTP id
 4fb4d7f45d1cf-5f2f773d107mr2126121a12.22.1744201615517; 
 Wed, 09 Apr 2025 05:26:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:7cd9:8fac:d1e:8d79?
 ([2a01:e0a:3cb:7bb0:7cd9:8fac:d1e:8d79])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f2fbc2e427sm730556a12.47.2025.04.09.05.26.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Apr 2025 05:26:55 -0700 (PDT)
Message-ID: <0f43211f-a858-48e1-a878-76d7e8df3128@linaro.org>
Date: Wed, 9 Apr 2025 14:26:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: dhcp6: Send DHCPv6 using multicast MAC
To: seanedmond@linux.microsoft.com, u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, trini@konsulko.com
References: <20250324204845.25603-1-seanedmond@linux.microsoft.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250324204845.25603-1-seanedmond@linux.microsoft.com>
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

Hi Sean,

On 3/24/25 21:48, seanedmond@linux.microsoft.com wrote:
> From: Sean Edmond <seanedmond@microsoft.com>
> 
> In IPv6, the broadcast MAC address is not used.  Instead, it should use
> the multicast address (see RFC RFC2464).
> 
> Add IPV6_ALL_NODE_ETH_ADDR macro for clarity.
> 
> Signed-off-by: Sean Edmond <seanedmond@microsoft.com>
> ---
>  include/net6.h | 10 ++++++++++
>  net/dhcpv6.c   | 12 ++++++------
>  net/dhcpv6.h   |  8 +++++++-
>  3 files changed, 23 insertions(+), 7 deletions(-)

Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>

[...]

Thanks,
-- 
Jerome
