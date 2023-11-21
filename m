Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1020C61D85
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 20:21:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E6E587572;
	Tue, 21 Nov 2023 21:21:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="I5pUIRQK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00E8F87253; Tue, 21 Nov 2023 21:21:27 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 411E487572
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 21:21:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4083f61312eso31511245e9.3
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 12:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700598083; x=1701202883; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/GKNo1HFOP3VLt5U4nG6J6bZJA6YclxdeOn5yJkJREk=;
 b=I5pUIRQKRmMUZC7R4VaVZXIF+Lp7aCgA8oRjVinkcO4p1LnSZ/1V7JarZ5ciupEcc0
 VXXQ2JhtxqsQMYEy24CMXuE9AUYy9bqgRcEpbJMEt7UCHldPtOX4E46BNE/qVIBM64pK
 vHyBCidkPDdiPWymxg0/4m/6nxFEhLUaCveK3niNdWU9bTaYDFLSlhRotbnJcpOQo7jY
 4SDEvK/wQ0OgoXFqrHX0nbzdG3+CX4aQDhfO7MSZVnWY2ZIBC0Zi4w9BorOLNqOvG8ky
 SrKVMaZRUjRoS5S7//d9iPznDpNIyfiiVRjnxCD0okTGpBUHzDFdn9KDStcMR3JErLEz
 iyLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700598083; x=1701202883;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/GKNo1HFOP3VLt5U4nG6J6bZJA6YclxdeOn5yJkJREk=;
 b=NtHhLZC5CeXCx0tjQAQy5m+smYfV6MxlcDpPMDhJ/yo+hjjBHmQ9esiRuj0LpZB2h0
 yYN1/MklAWoNChS/8X5LgIpE78MRlF9a9J52DScPrSaqnM5vcjzK0/OwdN7+yc+aZ9RU
 G6KJZYOryVwuvbsm5kkBBn8v68LDS3DwW5b2SNjSzkalo9EnkqBwowSQK6840RZvW7AQ
 vWR8A8Vit/SsWsNu3+0I84x64BZ9+PHEIxTOfDqyxt1MicfosG7rkco1y7irXRKDixRU
 PzJBYHXBXbA4y6eCB10tyA5CLLiW9qmC+T0bolO7wb/guYtyLWEl4FUSnUEtAG7L43hc
 faAQ==
X-Gm-Message-State: AOJu0Ywj1FY74jxUpByi2ysG0YrakEvjLUBMae6hCO0E8krr8ma0qyrR
 NFyrVWdttfo8NYNja8Af49xzFA==
X-Google-Smtp-Source: AGHT+IHGEiNooWDoTWY21s84TkArrd0vfM90YuVktqjJ4lNeYMiUmiJHidOEy0xr089/kZxYkUbDLg==
X-Received: by 2002:a05:600c:1c10:b0:409:5a1a:fe16 with SMTP id
 j16-20020a05600c1c1000b004095a1afe16mr300270wms.28.1700598082672; 
 Tue, 21 Nov 2023 12:21:22 -0800 (PST)
Received: from [192.168.1.7] ([79.79.179.141])
 by smtp.gmail.com with ESMTPSA id
 u25-20020a7bcb19000000b00405391f485fsm17781699wmj.41.2023.11.21.12.21.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Nov 2023 12:21:22 -0800 (PST)
Message-ID: <498279aa-e7e7-4e06-925f-e104abf8d721@linaro.org>
Date: Tue, 21 Nov 2023 20:21:21 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/21] configs: add dragonboard410c_chainloaded_defconfig
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
References: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
 <20231121-b4-qcom-common-target-v1-9-9492198e0c15@linaro.org>
 <20231121190851.GE2513409@bill-the-cat>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20231121190851.GE2513409@bill-the-cat>
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



On 21/11/2023 19:08, Tom Rini wrote:
> On Tue, Nov 21, 2023 at 05:09:32PM +0000, Caleb Connolly wrote:
> 
>> Revive support for booting db410c using the Linux kernel header, this
>> allows for testing the board more easily via `fastboot`.
>>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>>  board/qualcomm/dragonboard410c/MAINTAINERS    |  1 +
>>  configs/dragonboard410c_chainloaded_defconfig | 75 +++++++++++++++++++++++++++
>>  2 files changed, 76 insertions(+)
> 
> How different is this from the regular defconfig, and assuming this is
> also a partial answer to my question about "why not select?", why is
> this not just a config fragment instead of a whole new defconfig to keep
> in sync?

Oh, I was totally unaware of the concept of board config fragments in
U-Boot. That's definitely a much cleaner solution.
> 

-- 
// Caleb (they/them)
