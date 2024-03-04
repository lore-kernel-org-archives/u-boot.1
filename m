Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF1BBC5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 17:43:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D032F87EBB;
	Mon,  4 Mar 2024 18:43:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hTvQ1+Sf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5C13876A9; Mon,  4 Mar 2024 18:43:23 +0100 (CET)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD13D87F8F
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 18:43:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=konrad.dybcio@linaro.org
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-512f3e75391so3770889e87.2
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 09:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709574200; x=1710179000; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iY/C0FgdaeuMeMQQ1dOaWJMNlwu28TeGsbgHAFT/vwo=;
 b=hTvQ1+Sfoky/Mp7lNLoIKth67PU8x0korjK22TdVaOjKBUAew+wUjyx2qmudfrybe5
 jINrpE8U3+cUDVFRXVrkpyB2aO4R5qK2XnCjUezf7bVfrK7AvAfeiJS4szznsY35V9Z1
 pXSGy/qYF+rz0botLTzqBITu05pzfnkf4Fy/ZbYyGwnJdYFOkFl7Y5Ee9AIJ5AzyI7xk
 D2XHkkspqFCFJl8M44LKiAvWWdqb0iGUCInVuPYVFtSoVcvtMDy0FIDnW3UojXX2buqW
 5MXm4chwvIQUpptSLqGuivB4xDUYKkT8QVoN4vDAtfdCQTsKTIQ9/0JcAs95d4UxEk9O
 2xsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709574200; x=1710179000;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iY/C0FgdaeuMeMQQ1dOaWJMNlwu28TeGsbgHAFT/vwo=;
 b=kRLN2pGjoCUvK0nZ13YxHZNz0dendFylgzj+a7MpUnAMsMzhPQ5tcK5jD7/sQKEsZk
 jFl7HA0y+pNK/ZrFzzipAGDWln1acagYiadRwajVOpakzFl7TsDn32/Zu3eOhnRWN1d5
 Bnr56BXz91kdvcAE4oCmMeKpaoslkFdjTPrWGS1tWUcjq93epcldYk9wstg7Kl+Bh0Ma
 KC5OYF1l/YKALl/iouysIiLkwZQd/5uMerX+r8gEufqnlcBf0HS46YoYDj67N4KTcSlK
 2LUn1Gi9RKI+nMD9Cj9X4EtbSjLlBGIpMJAl0Q6WoNcLKP2gnnGRqT8wehtdbnlf0Z3X
 p/6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtbUqkZjH/211kXSJKtr0bCg61hy0EAWIPdCgz9j2hlfcqziqxyH/pV1r12kr7e/6lOrkNq4c9zubjvPsw9nboMgv64g==
X-Gm-Message-State: AOJu0Yyv3sHRWVXefgnl0UPvh9ScJWYpSzmBALxmsTpBSOBxMsA8PjKi
 5t7xrxqUwOPkLF25BDzFbZPmR5lidtpYT0ihY4qzLXZaSmh1fF9LA0DY6KxTi10=
X-Google-Smtp-Source: AGHT+IHPOjVrcr8Bjj7pgjyVFy1zfDRelP8j6KA6v8E+6z46MB8ri4c7BlZdrFgcg+UoJ1fDOrLYIQ==
X-Received: by 2002:a05:6512:318f:b0:513:3ea7:770a with SMTP id
 i15-20020a056512318f00b005133ea7770amr4788393lfe.17.1709574200136; 
 Mon, 04 Mar 2024 09:43:20 -0800 (PST)
Received: from [172.30.204.149] (UNUSED.212-182-62-129.lubman.net.pl.
 [212.182.62.129]) by smtp.gmail.com with ESMTPSA id
 j10-20020a19f50a000000b005129e5d7f11sm1791373lfb.125.2024.03.04.09.43.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Mar 2024 09:43:19 -0800 (PST)
Message-ID: <cd98b326-eafd-4be1-87d8-09bef5108c0e@linaro.org>
Date: Mon, 4 Mar 2024 18:43:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] Add support for Qualcomm SA8155-ADP board
Content-Language: en-US
To: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
 Stephan Gerhold <stephan@gerhold.net>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Elmar Psilog <epsi@gmx.de>,
 Joe Hershberger <joe.hershberger@ni.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Ley Foon Tan <leyfoon.tan@starfivetech.com>, Lukasz Majewski
 <lukma@denx.de>, Marek Vasut <marex@denx.de>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>
References: <20240229142043.1263690-1-volodymyr_babchuk@epam.com>
 <dc97490e-4029-41e2-bbbd-b1351f5cf9eb@linaro.org> <87bk7x6c88.fsf@epam.com>
 <ZeXN7EZHU89qS5PF@gerhold.net> <87r0gq3shy.fsf@epam.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <87r0gq3shy.fsf@epam.com>
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



On 3/4/24 16:51, Volodymyr Babchuk wrote:
> 
> Hi Stephan,
> 
> Stephan Gerhold <stephan@gerhold.net> writes:
> 
>> On Fri, Mar 01, 2024 at 06:25:39PM +0000, Volodymyr Babchuk wrote:
>>> Caleb Connolly <caleb.connolly@linaro.org> writes:
>>>> On 29/02/2024 14:21, Volodymyr Babchuk wrote:
>>>>> This patch series adds support for Qualcomm SA8155-ADP development
>>>>> board. Main motivation for this series is to allow running
>>>>> virtualization software on this board and U-Boot is a good way to
>>>>> break Qualcomm's boot chain at EL2 with more convenient ways for
>>>>> uploading and running the code. With this patches applied it is
>>>>> possible to upload and run Xen on this board. KVM probably should work
>>>>> too.
>>>>
>>>> This is really cool! I've experimented with this on SDM845 and SM8250
>>>> but never really did anything with it... I'd love to take a look at your
>>>> Xen branch?
>>>
>>> Honestly, there is nothing to look at right now. I just implemented
>>> early printk serial driver for the qcom, made hacks to the device tree
>>> and trying to boot Dom0. I already expecting issues with the GPU,
>>> because it has own SMMU without virtualization support and Xen already
>>> complains about it. So I had to remove it from the DTS for a time being.
>>>
>>
>> Did you enable all the clocks/power domains/etc for the GPU SMMU? If I
>> remember correctly it is off by default and all registers read as
>> zeroes. The SMMU driver could easily get confused about the capabilities
>> of the SMMU (e.g. the stage 2/virtualization support) if all the ID
>> registers read as zeroes.
> 
> Ah, this is a great idea, thanks. I tried a quick test by enabling only
> clocks that are provided by GCC, but looks like I need to enable GPUCC
> clocks as well. So I need to write a driver for GPUCC or at least
> figure which registers to write with a debugger. I'll try this later.

You'll probably also need to enable the CX GDSC (not sure about the
order, probably GDSC and then clocks)

Konrad
