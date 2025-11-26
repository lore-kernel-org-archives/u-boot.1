Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09324D10F58
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 14:28:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5565284247;
	Wed, 26 Nov 2025 15:28:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eLijtKkf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B94884248; Wed, 26 Nov 2025 15:28:56 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5054E8423F
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 15:28:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-477a219dbcaso60806135e9.3
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 06:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764167334; x=1764772134; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1wQk+6WXBHdGLWOItOIJWP+FvGsGFJB9qe/vfOKgDLE=;
 b=eLijtKkfiz3ygKgbL+MnG5b8u6KVV/VAMMJ2v93zvUL3Yp0X0CG9u73d6KGV4lwe3a
 BvI3FHTh21bQgeajncMXKGKY7Q1s30+gIycyhFiBBGXA9q2Nx3rJLKs9ddkK9xlHyjbZ
 7kI/KL+Zo+aY1iAWSerPtAwWQKsNpOrEpjzEEKeJUlQS3yX7MmGEA+Rb80+aWUxXOVf5
 YRQ/+Zitga/9aJjXzb6mu4Ljar6kuEZmtgtYf2x2f464q8p5tKntHfyW8MoChuvkM1wu
 6kfBnC437SydbUF9QAjF3R9uMLnKlKu/I4DNePdP/oyaIcjxaFBnTlXeBD/A06FAwA+G
 P4OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764167334; x=1764772134;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1wQk+6WXBHdGLWOItOIJWP+FvGsGFJB9qe/vfOKgDLE=;
 b=m1WADR8oKU/aUcx84i8M/Aw0Gunkgpvwuj1coeK+BURDz2Z6daIiKi1L/7jwBmGTIf
 xb99em4E+im6YayhIx7QwobvdNK4xKjnDQ3LXADY6jOKpYkMPG1l7QNW0zk1olSONV0f
 u5VXIoOBEvz85t7yxS0j3dNVIlcdgxiq+FSMUOd21MoCXhVQAjuJ3sRTL4pLoIei0osb
 tLdIXWkLcn1dGiZI0kGJo0+10V+OBQJlJ09Vs7gMuQMfa0oDXXUbAuRxyeK99EGupjW7
 O4ACOoqxhKRHmBibuIpNakhI6vyIvaov/lIBqJmqUpY0eNT+VaJHpXw5swPrl7ZjYkB3
 TNyQ==
X-Gm-Message-State: AOJu0YxYQejH8kkIBfwJA0Lfu2i7I+2bEz7W+aRjiAagQEIUjzzlEJwg
 Ofqabx7VLOi69XgM7I6AAX1f/fSANIcNTZKFE3aCTyitqJmMPGq2bz19RMDzYd3u4yA=
X-Gm-Gg: ASbGncv2X0RSqObltpFkpOFI9av77b8pB2Y/hWIeULTh/wLBp463x1W3rDKj+RuAOzr
 KVAIWdtOFtI7QkMo1dtkDG+6N4SyguotHPb4uSpgfhqKk0fFVPgOkH1pThxay3NaTWsmOVVAQOp
 8uen2KDYyU+MwMMtU6zWUb00ye8K68sVmrEJCcfu2iUJquNMZPBKGAkmnmhU6DfSCJ4OY4kKU9g
 PEk5ABTouxytRU3iGTFZga0ySgMqJYEH209fyAY+Si1PzzF078kESsZ14GAVmX563N7ne1fdo2f
 VqU7KavAVQHfF9hQyXSIpJTnh4rTTqGxJ14GOAcXAqm/qM3XLdbJKd7p2cKIxpxw+ETiDGXjuGn
 0NWb5sSdLaeJ21gMqQfHnuavX3hPaCbJBQcUeWh9Yv9xejgC8QNTujgIRqYRIvgOW/7mJOwm6LO
 WJOBwJsqmiedjPQmkDGGBBPuPgMe8KzsZgAVUeH4ulmvTM60NGc2J2ArBmbqyP9Zz1hA==
X-Google-Smtp-Source: AGHT+IEgc9YRxEIWu1FYojy8TKAU8TDcTYbu1aiZhv1X3P6vHcxZwS5FR1AXTBqFVdX5+d23gKswWg==
X-Received: by 2002:a05:600c:1d0e:b0:471:21:554a with SMTP id
 5b1f17b1804b1-477c01860aemr190932285e9.13.1764167333731; 
 Wed, 26 Nov 2025 06:28:53 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:74cf:cf99:df2c:2480?
 ([2a01:e0a:3cb:7bb0:74cf:cf99:df2c:2480])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4790b0c3a28sm48170185e9.9.2025.11.26.06.28.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Nov 2025 06:28:53 -0800 (PST)
Message-ID: <2177d026-59a4-46eb-874f-9e02bebe4902@linaro.org>
Date: Wed, 26 Nov 2025 15:28:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/2] net: phy: aquantia: Switch to generic firmware
 loader
To: Marek Vasut <marek.vasut@mailbox.org>, Beiyan Yun <root@infi.wang>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Zi Yao <ziyao@disroot.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, Ramon Fried <rfried.dev@gmail.com>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Sky Huang <SkyLake.Huang@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>
References: <20251101123401.110681-1-root@infi.wang>
 <4D63D655-F67F-4FC7-B02F-653BF49754EB@infi.wang>
 <59b26617-ea1d-4a65-a474-de16399f8205@linaro.org>
 <7e2b90c8-b814-4027-a7ad-9a0a5e747557@mailbox.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <7e2b90c8-b814-4027-a7ad-9a0a5e747557@mailbox.org>
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



On 11/26/25 15:24, Marek Vasut wrote:
> On 11/26/25 3:22 PM, Jerome Forissier wrote:
>> Hi Yun,
>>
>> On 11/15/25 08:48, Beiyan Yun wrote:
>>> Hi all,
>>>
>>> Gentle ping. Any comments on this patch?
>>
>> Since there is no comment I will pick it up and move it to my net-next queue.
> 
> Ideally the driver should use one firmware loader, not both.

Is this a NACK or can things be improved later on?

-- 
Jerome
