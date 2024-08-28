Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4A01C54ED1
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 11:59:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE9CB88861;
	Wed, 28 Aug 2024 13:59:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eE5h174+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 958B688868; Wed, 28 Aug 2024 13:59:25 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9264D8884F
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 13:59:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42817f1eb1fso58237215e9.1
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 04:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724846363; x=1725451163; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m//8VqJuBU4D/FAUfPihcjOcPufF0kbpBmnZq/qBUpI=;
 b=eE5h174+x3BSdVpCLKSdB3D4V94LiMfAe8zm4/e+KwNLJuBdHJanNizYyJGeXGt8H0
 zUaiBLxiCYSmjRtlcLW2EFcOSIycY+Jmx47lLzEr7smGLbMRrhV0rmrTRuUOikX3yMys
 KQQs/ctqBao10B9+B5lPtTxB99iONys2rS00gcp+FwyfyDucGN+POlJjVBM/vvvqPItj
 FqM1LmL8B3diQzPMNfi/EhTOjxTe0YDevNqljMkd4RP15oCieUPDgivbO0441XhL3sgM
 SwY6GYdTC6Q5luEtIEAd3dLOjBVQKNnjRMkdzZSGsx1qBlbFO4qsr+nlHjWmC23moqC5
 d6ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724846363; x=1725451163;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m//8VqJuBU4D/FAUfPihcjOcPufF0kbpBmnZq/qBUpI=;
 b=bAW/NOWoJc0EL3BgQTBL2vK8AA+/XwQaTkw58goPWjaabWomEp3V5zBnRodyC2AHgI
 ppPaoQSaIdNO5+G6t8X+bzoCR/Yc2rK2nNvRs1alI3ZD33OifN+aVA5C0VX44Zhp1tEa
 WleYP+Q+CzidE0Ue5zuw+C7IAoLfoL9sP0Cj4RCibdYHeDWB5akYsGyrIi59zUAWnxSD
 6W8c1hT1Z/JPS/s4AGwe0dtikqIuiGekIbs8B6nTX39K46qTVtWwQUaev0/U2D3mhIGy
 Z3VzcLmMInr1Fiks6x7XJc32VPPaYhUZQWZNUJs9SOfhohjJNUN4NwV+7gMtEgH/6KPg
 r/YA==
X-Gm-Message-State: AOJu0Yz2lflzvriyXczwI8m4HjULoYB24yXwZ/QWW2yvsSAPgQdq8la1
 9kQtjyUozuYYFIyZy5P2Irm4i5wO1S0noiM6Wc38m1wyVXz11BGyRksXuvTfMgA=
X-Google-Smtp-Source: AGHT+IFu8LE1wStxhNaG9dcHFJYcM0vGtz/LeUVkTMq/g+fgMgLsfa7S8xcGSwipHc45Q+kyh953ow==
X-Received: by 2002:a05:6000:1815:b0:371:8ca4:1b76 with SMTP id
 ffacd0b85a97d-373118b8ba3mr10423239f8f.32.1724846362799; 
 Wed, 28 Aug 2024 04:59:22 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:18ae:f2bf:3df2:e3c4?
 ([2a01:e0a:3cb:7bb0:18ae:f2bf:3df2:e3c4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3730813cde5sm15250064f8f.40.2024.08.28.04.59.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Aug 2024 04:59:22 -0700 (PDT)
Message-ID: <aefec277-84aa-462f-8446-06e8b874a3e9@linaro.org>
Date: Wed, 28 Aug 2024 13:59:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/23] Introduce the lwIP network stack
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>
References: <cover.1724419624.git.jerome.forissier@linaro.org>
 <CALeDE9MkmOXQw0PM54v=-jHki1MYdSrdpb3dSvHZ0d6VgKzTpg@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CALeDE9MkmOXQw0PM54v=-jHki1MYdSrdpb3dSvHZ0d6VgKzTpg@mail.gmail.com>
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

Hi Peter,

On 8/28/24 13:05, Peter Robinson wrote:
> Hi Jerome,
> 
>>
>> Jerome Forissier (36):
>>   Makefile: detect HOST_ARCH properly when CROSS_COMPILE is multi-word
>>   flash: prefix error codes with FL_
>>   at91: rename mem_init() to at91_mem_init()
>>   arm: omap2: add missing #include <netdev.h>
>>   net: fm: call dtsec_init_phy() only when it is defined
>>   net: wget: removed unused function wget_success()
>>   net: phy: ncsi: depend on NET
>>   net: ftgmac100: depend on NET
>>   net: wget: allow EFI boot
>>   net: fec_mxc_init(): do not ignore return status of fec_open()
>>   test/py: net_boot: fix comment
>>   test/py: test_efi_loader: add missing dependency on cmd_tftpboot
>>   test/py: test_efi_loader: add HTTP (wget) test for the EFI loader
> 
> All of the above look like they should be sent as a separate fixes
> series which the following can depend on, they all look like fixes
> that are separate to the rest and likely are useful on their own. It
> would have the advantage of slimming down the series.

I agree. I'll send them soon.

Thanks,
-- 
Jerome
