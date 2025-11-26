Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 850EBD11186
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 17:10:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98ED2839B7;
	Wed, 26 Nov 2025 18:10:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pJ5dHiju";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26B5583FDB; Wed, 26 Nov 2025 18:10:02 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C54783642
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 18:09:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-47118259fd8so61259155e9.3
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 09:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764176999; x=1764781799; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s95/epx5qiBq2sUXNB/F0YqQhbW3N45SYdo5cnH5npw=;
 b=pJ5dHiju+7K9qwwI91JPGZnDzFzXJNYrXzXUL45GGjIOxlZZkRWXpeLpeK4BbKGv/2
 UnF0r7u1m8X5FClk2tDWW5DQH8Yhh8NXzRU1BWQAUX4K7HU+tKHcre6zanXoHOUzuuSb
 iWTiMdp86X3YSZOLYtRJTZvK2aVZOfVAiVom2ogxW9w+OKBqo7RMJ3gLFgImuV8fORY+
 2vvNpSIM/Pryf5jXjwfshYxFbDUWR5wZICVp0VDbX39aKwuEKkkU/DGZPMVUYef5E/W9
 rS6Lpg/tkXc0zPTS1amSNnT2UcTIHITPoatmhceJNJCrIrhmGQZ1iBiC7Cul7JlKtttl
 Ud1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764176999; x=1764781799;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s95/epx5qiBq2sUXNB/F0YqQhbW3N45SYdo5cnH5npw=;
 b=kV7zS0ZRZK5S3Du91/vJmWG1VbFuE7Oxdhz9qOXzmjdUaLsPk5f3dEMF1LPjZQw9iZ
 H/u8owuQIu9go1TBYCk0Kn0Qb+psxzav3G8Bkh/QGm9CTTe7RHiaohpc4StP0KaCjNj0
 8m6znOfxDgvMELp8vyRKr19tW7RQt9OQqoF0HCGyeBGQMNtLCWC3uNLyZjdelupRqUDy
 PbZGRn8at3KrPV6cKJYbUSYeO9KK2SaDgAne1J+kNTyzYyjhYkyDEKB5ot7o1bf6EEHC
 cy63AXpFTZuZ9sMzxOm5b+E6PHXJYyCLmksMYX2b3HOQnY2rJ8oU41W1n5NOiYqPyMxb
 e9fg==
X-Gm-Message-State: AOJu0YxNZkZrI4jL/rrWOmesfg6qcXkidm89gYFrDl7x+g5VXCB+HadC
 L1bhKa9me9UGJLJ/PUmuM+TLNIO3HUanPg9yU/1uPdLxmagyTj+n31ohqW5JYuOvWpY=
X-Gm-Gg: ASbGncsXuwnWGfzg+8E0uYhIR/nOSVnwdvgMdvZArZk2GiUjwFIu3Ad9xvqmA3AUsPl
 hWDlOSwysZOkJDObQNkKaXwIYYPyGvXR3zFdwq8/ibGBNO2M/GVCoOVawdghtJHELm9S9l3b97I
 lAnu3WmvKog/3vgLKj370qD33DQX/xpt1eROiCoaee81w11j9tA8CmzgsWOPKD/+079//Jn23n4
 +onK6ok0HTUXoOOENxN8yOqOJwzzT0frH1g8uRki3bVz4SWZhVahuy6D+ihjx7uljo/gOgSSIGx
 rQz2LcbQ1zqEc++IGSwIPmyvHwLc1vRkozBH/tCgvk8IEv4qHuvEBEhdHkq+RHTm9eZLgSViIRl
 gAFc0jmjjrAyEXVEkrqFLmLxPDYFQ2rtF/C4lZ0w/V7e4nBrUzCsNHth2cT1W4U53WQDTJQw11j
 lud2adAXhmjt/CovjKyBHViWkan68JVXzOVQIxivYTu6bTPWw9DEq6XV2/VhHcBefA22ihswr7r
 14M
X-Google-Smtp-Source: AGHT+IH/h3zDMXgkgRMel2lnzRC/Kn+Coh1uVSxYFW8eolln1nogFYstwenUOx8JBxHmearD8wkKpA==
X-Received: by 2002:a05:600c:8b37:b0:45d:d97c:236c with SMTP id
 5b1f17b1804b1-47904b1ad25mr68665595e9.21.1764176998979; 
 Wed, 26 Nov 2025 09:09:58 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:74cf:cf99:df2c:2480?
 ([2a01:e0a:3cb:7bb0:74cf:cf99:df2c:2480])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4790adc8bc7sm57482105e9.1.2025.11.26.09.09.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Nov 2025 09:09:57 -0800 (PST)
Message-ID: <7e694c29-babc-4ddb-9de2-4cfc02844545@linaro.org>
Date: Wed, 26 Nov 2025 18:09:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docker: Use GitHub-mirrored TF-A repository to avoid
 clone failures
To: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
References: <20251110133758.1644822-1-bmeng.cn@gmail.com>
 <20251126154139.GA3759421@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20251126154139.GA3759421@bill-the-cat>
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



On 11/26/25 16:41, Tom Rini wrote:
> On Mon, Nov 10, 2025 at 09:37:58PM +0800, Bin Meng wrote:
> 
>> GitHub Actions consistently fails to clone the upstream TF-A repo,
>> returning the error: "The requested URL returned error: 403".
>>
>> To improve compatibility in building the docker image with GitHub
>> Actions, switch to the GitHub-mirrored TF-A repository instead.
>>
>> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
>> ---
>>
>>  tools/docker/Dockerfile | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
>> index d2384219c06..201a1cdbac1 100644
>> --- a/tools/docker/Dockerfile
>> +++ b/tools/docker/Dockerfile
>> @@ -243,7 +243,7 @@ RUN git clone --depth=1 https://github.com/OP-TEE/optee_os.git /tmp/optee_os \
>>  
>>  # Build fiptool, bl1 and fip for fvp and qemu_arm64
>>  RUN git clone --depth=1 -b mbedtls-3.6 https://github.com/ARMmbed/mbedtls.git /tmp/mbedtls
>> -RUN git clone --depth=1 https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git /tmp/tf-a \
>> +RUN git clone --depth=1 https://github.com/ARM-software/arm-trusted-firmware.git /tmp/tf-a \
>>  	-b v2.13.0 && \
>>  	cd /tmp/tf-a/ && \
>>  	make CROSS_COMPILE=/opt/gcc-${TCVER}-nolibc/aarch64-linux/bin/aarch64-linux- \
> 
> How consistent is this failure? I've had problems this past year
> building various parts of the container due to AI scraper overloads but
> never had a problem with the TF-A repository.

FWIW,

The OP-TEE OS CI is also running GitHub Actions, and I have seen Git clone
failures with projects hosted on git.trustedfirmware.org on several occasions
(TF-A, Hafnium). GitHub on the other hand has been rock solid and fast (not
surprising I suppose, since this is GitHub <-> GitHub).

-- 
Jerome
