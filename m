Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E36E7C35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 15:38:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37A9587863;
	Thu, 21 Dec 2023 16:38:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jpjqer3E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84FE4876A6; Thu, 21 Dec 2023 16:38:49 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09C8887864
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 16:38:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3368ae75082so392682f8f.1
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 07:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703173123; x=1703777923; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JkxZTPUuoVx8Hc6okKvqWD5PBkVf1zMAh7uRIoYcNec=;
 b=jpjqer3Ev69TZaMrhO5WnLKvh/QdhG/duzpS5tqXxuJ3lv0vHmKIpryC6zjGnE+6ar
 F3cVfvu/g5BR+SpjCd2RuuEhCrgpHny4CRntiQDoTZu5zK3f4zupsi6OhVLaUqF9FZ7w
 bDHC8OYB5E6I0FK3SxFaEX4PZRIpFvQP2x+MUMOKTkmU3j9PMXqLLH4xZeLhQMEdZ2HG
 uXY5ERA5+evAgFWzmGJyWhLWA4Zaji0nbwAKsu3qsKbuXqJexvdexJR6buXV35vxtLji
 G4iovC/WiFptzuDvwT/yfFnYqkGQqxhQtobBtqikpYGW2cF5cO6j9ZLzDuc431tFqi8S
 +ZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703173123; x=1703777923;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JkxZTPUuoVx8Hc6okKvqWD5PBkVf1zMAh7uRIoYcNec=;
 b=nyFilWBTEOizv/V5AtnfvbtGKMG7xhOw4WGAja5ddnjlIWAcPUsr+NflMSMwnw/UKI
 2r8//t29N77dDi+DkrRTFmFcCTNXWepSdUtcoE+soBcdwQRaS3D0mXD83bzN4zpc4WxK
 yWmhyybzfYplhhsexFD3OCVmuttb61slWGax/9Zvq6LlFF/i+9b6cZ2k/W1QpCDG7fbR
 3oymkO97Futuzkt5oJdqzuHKSrKR1LF008KDtJ0jkj+21tHccvVfmFDiUnH5YgCj0hkx
 RBZFbbFwKOR6jFBGtHhnrOv7HAY2OUpQbROhwETQ6elRvW96H0qouJBKDOT02pC/BNLl
 LzGA==
X-Gm-Message-State: AOJu0Yy/fJl6upXCKo6crqIQfuQEn83EkhQCH48o6ShESugzGBomuovJ
 hwbLxQyV/YGh2rIyl8Dow+uObQ==
X-Google-Smtp-Source: AGHT+IHoXYvVgo2EiJhEILC8wEDdZlbnR2ErlYSTx9W98vXxJCZqOlpluCqIdbmLY+KAFtMZP2ajug==
X-Received: by 2002:a05:600c:4e56:b0:3fe:1fd9:bedf with SMTP id
 e22-20020a05600c4e5600b003fe1fd9bedfmr667941wmq.11.1703173123355; 
 Thu, 21 Dec 2023 07:38:43 -0800 (PST)
Received: from [192.168.1.83] (host-92-17-96-230.as13285.net. [92.17.96.230])
 by smtp.gmail.com with ESMTPSA id
 fm13-20020a05600c0c0d00b0040b37f107c4sm3831445wmb.16.2023.12.21.07.38.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Dec 2023 07:38:42 -0800 (PST)
Message-ID: <55e63d4d-22cd-43be-8e30-cc02e2941542@linaro.org>
Date: Thu, 21 Dec 2023 15:38:42 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/32] Qualcomm generic board support
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, Dzmitry Sankouski
 <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
References: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
 <CAFA6WYON2Rx8zb=An7agmeNu1mJk=UKQuZqjZ4fbtH2xD+8uFg@mail.gmail.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFA6WYON2Rx8zb=An7agmeNu1mJk=UKQuZqjZ4fbtH2xD+8uFg@mail.gmail.com>
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



On 20/12/2023 13:07, Sumit Garg wrote:
> Hi Caleb,

Hi Sumit,

[...]

>>
>> == Upstream DT ==
>>
>> All Qualcomm boards have had their devicetree files replaced with the
>> upstream versions. Previous patch series made the necessary driver
>> adjustments to fully support the upstream DT format. All future
>> Qualcomm boards should use upstream DTS by default.
>>
>> Once Sumit's work to import dt-rebasing has been merged, we will drop
>> the imported DT and bindings again.
> 
> Since there is consensus building in the U-Boot community to use DT
> rebasing subtree, I would suggest you rebase your work on top of [1].
> You can take an amlogic SoC patch [2] as a reference and see
> corresponding value-add. I don't see the point of unnecessary churn if
> there is consensus we agree upon.


I designed this so that we can just delete the imported stuff once the
dt-rebasing series is merged. Importing a few files and deleting them
later is not really a big deal, so please let's not block fixing
Qualcomm support on this tangentially related series.

Thanks,

> 
> [1] https://lore.kernel.org/all/20231214135103.1606605-1-sumit.garg@linaro.org/
> [2] https://lore.kernel.org/all/20231214135103.1606605-8-sumit.garg@linaro.org/
> 
>>

-- 
// Caleb (they/them)
