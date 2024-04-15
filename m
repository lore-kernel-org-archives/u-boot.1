Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B4EC00A94
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 12:15:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29BBE88213;
	Mon, 15 Apr 2024 14:14:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uNugNouV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0041388153; Mon, 15 Apr 2024 09:27:16 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E19208810D
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 09:27:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tudor.ambarus@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-346b94fa7ecso2756373f8f.3
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 00:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713166034; x=1713770834; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5royMnrp7kOHadJdjB9zmqDe/0aVi+S55F2Z3dvpsiI=;
 b=uNugNouVvDsvFOePVMk3l3CFjqEiPoXWttFlmJSKoiCFAqq8DekfPqfiuJSp7ybbyW
 zs43pWlECDuq4B//oLtGe6Ryaoi7vYtem6m4oV/sDyaJtel8dhfpW1vPVMlovhm0H0OV
 6ns8pR5917Q1mgfp8ERXPjy66BTT66W2xqKdw3zev08uh1qnA00TS2atJv0co+1UGe3s
 Wl4SuAQ5WE3775WqMwQ7LAdaY7uLGES/KnsOi4N/+Gn5vvdRAZnBX6iXSQlikIPaU8ie
 DdUPFl9FnQzOv1DwXY1etJZHi1dybpDCjaCIR23AxEeBoayT3jJJzQ+aefqg1zSNlsx5
 BZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713166034; x=1713770834;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5royMnrp7kOHadJdjB9zmqDe/0aVi+S55F2Z3dvpsiI=;
 b=P4o8gD8T7AUVWFxiK4DMGrK97/XAakGQQy4MP9SU7oub9oIQIgQEMJyOP0yTIYNiOF
 NTtEoCiWKR7HDsEtwPfgfVEfyqLHld+RWljUwWQsZcZBpUakWuUQAnCED8hc/1S9ufa/
 VbVNQyKVSvSHiSf3Hah5Au1oSeLPJ+rIHx9jR/yPVNPYT+lmwPEhMLq/QQFwZdajCpMV
 IqNHx4nQm3RhSs1b8TqsFTXkq9zt2v+HJNNJ8UHDDK929wtS0m0hUGT5rvyGRGz76jGo
 G42mV0Lt5tRFI0sy4bFxZkIKElpn6z8xoVBGshjPn94IDBe0m6aqS4DYZ4a+lvWLwbvP
 pLdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU57kCz4Pb0LHFH7zXgoTaNqS2JUe4ohcrhBJYP0O6jgPk1ID1kQgVh+cpb7RIuqly4C+oJNxvxcQfl6jGGZdsWnk4f7Q==
X-Gm-Message-State: AOJu0YwqIl923Z1MziY1NP67cr8SV0cRg58QOjSS5oj5MlEfq4fNukIU
 URwI11j3ze1wMNKzpx4y+Cf37ac42rp/HxldyXMKA0ERK0Mm4CMz7kvJ3KJ9mT8=
X-Google-Smtp-Source: AGHT+IEyY7GIm182qG/hf/oAXnRCpyOX2wfSvQlwDzmz49l4VYCumWzFIatWk9oX3mqOcuGZ8jPhbQ==
X-Received: by 2002:a5d:4089:0:b0:347:3d28:c872 with SMTP id
 o9-20020a5d4089000000b003473d28c872mr4769187wrp.9.1713166034311; 
 Mon, 15 Apr 2024 00:27:14 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.35])
 by smtp.gmail.com with ESMTPSA id
 s11-20020a5d69cb000000b00346bf37c97bsm10855535wrw.63.2024.04.15.00.27.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Apr 2024 00:27:13 -0700 (PDT)
Message-ID: <86a321ed-2ee9-44f8-abbd-7f147420212e@linaro.org>
Date: Mon, 15 Apr 2024 08:27:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] mtd: spi-nor-core: Rework default_init() to take
 flash_parameter
To: Takahiro Kuwano <tkuw584924@gmail.com>, u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, pratyush@kernel.org,
 d-gole@ti.com, Bacem.Daassi@infineon.com,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
References: <cover.1713154967.git.Takahiro.Kuwano@infineon.com>
 <9db9fb39e655b514c21952e0a5005572510ad3ec.1713154967.git.Takahiro.Kuwano@infineon.com>
 <377037b3-1bf2-492b-bb88-de233d8b373c@linaro.org>
 <7149031f-b359-4218-9a52-e4ab0ea16c4c@gmail.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <7149031f-b359-4218-9a52-e4ab0ea16c4c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 15 Apr 2024 14:14:08 +0200
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



On 4/15/24 08:09, Takahiro Kuwano wrote:
> Hi Tudor,

Hi!

> 
> On 4/15/2024 3:47 PM, Tudor Ambarus wrote:
>>
>>
>> On 4/15/24 05:33, tkuw584924@gmail.com wrote:
>>> From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
>>>
>>> default_init() fixup hook should be used to initialize flash parameters
>>> when its information is not provided in SFDP. To support that case, it
>>> needs to take flash_parameter structure like as other hooks.
>>>
>>> Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
>>> ---
>>
>> I'd like to get rid of the default_init hook, let's not extend it if
>> possible. Can you use the late_init hook instead?
>>
> It looks easy to migrate from default_init to late_init so I will do it.
> Could you provide the links to related discussion in Linux MTD side so that
> I can summarize it in commit message?
> 

I can't, I don't remember if I brought this up or when, but I can
explain why.

default_init() is wrong, it contributes to the maze of initializing
flash parameters. We'd like to get rid of it because the flash
parameters that it initializes are not really used at SFDP parsing time,
thus they can be initialized later.

Ideally we want SFDP to initialize all the flash parameters. If (when)
SFDP tables are wrong, we fix them with the post_sfdp/bfpt hooks, to
emphasize that SFDP is indeed wrong. When there are parameters that are
not covered by SFDP, we initialize them in late_init() - these
parameters have nothing to do with SFDP and they are not needed earlier.
With this we'll have a clearer view of who initializes what.

Feel free to use this in the commit message if you think it helps.
Cheers,
ta
