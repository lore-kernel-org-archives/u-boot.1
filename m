Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4144DC4345F
	for <u-boot@archiver.kernel.org>; Sat, 20 Apr 2024 00:51:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D2BD88258;
	Sat, 20 Apr 2024 02:51:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fjx/pZLV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F33A088305; Sat, 20 Apr 2024 02:51:12 +0200 (CEST)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 063BC88208
 for <u-boot@lists.denx.de>; Sat, 20 Apr 2024 02:51:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ganboing@gmail.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1e5715a9ebdso22543235ad.2
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 17:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713574268; x=1714179068; darn=lists.denx.de;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3tqM/ScLtuoi2/N2s+QrqCfLL3HDekfD/QcTnBUftTA=;
 b=fjx/pZLVUpjAVdA/J2tBeNMwyBgp1VOXRqfenlTXXrLHtCjR7afJanNDtfsjGFKiUG
 ALRk9q22aVUpsKpxeTia0GgxXsIGfaUN9/oKvkL2j31lqP06ZGBgnjpBKoYo2bwj4E+F
 tBIKF1lDT2prGPSiXsUV57dBQZK8A6eMbvVLexJIHeHY/qjnc9qBnzvCmjxx7jKV1Fya
 BWb7VZYEkWhcsAq4EfSaZfWukY2ZSJ9g3dPI8f8RtapsIEfFcQJ6meTf+4cIVzcGflDn
 XcIlQJmIFKOckY1dP2S95YJAhX+aeGB+z274jfiaBQk9IwY/KW6fPHc5mWq8rAcEobx4
 Wp7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713574268; x=1714179068;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3tqM/ScLtuoi2/N2s+QrqCfLL3HDekfD/QcTnBUftTA=;
 b=BGYOEUB3fsQNTj3295xDECAIh6x5Liz+J84ld56Wl9hZuNU5Go8gTRZPcbk4JAi6Uz
 TK1egDtYbq97RDvxcPjUnlLXPJspXPslnW7+EsYvCD+WlvKmUKhi61I5gJA/+/6NI73g
 u3PwJZZ6oup6FAPoUK3SvBAkI5QalTI2SmBjKzNg74Wxw9FI+kaRLynxKzIjxB582WXi
 1WH9YPso6AvSzTn+Ea+pZyQaUJUx3VfRcZNgLtGJFedcjIP/CUfL5rObfPd4YDamYDbr
 skRoZwAh8ZQYQhjn4+QjoauFOZpI/GxYYsoRx9CwR917wBbOVk5jXJSIErgpUo4rPcUM
 JMpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbCxL/g6k3m3mRJCQXOO/wUVYzxJgSp/Z5ActGHN+uEZ02HGdmRtiLn8ECCYXNyuagup/CVrOTrJX3PZKXx6nd30hvag==
X-Gm-Message-State: AOJu0YzlCg4C4ZYAC4cG4oaeWVxHhMInFdRJkfBA0Y0R+Iztp8KfV497
 QIoleQ5zsw50QQJgelTKFQbvo1h2Lpemp3PPzndXoVqc+iRrZHWJC3VLN6Um
X-Google-Smtp-Source: AGHT+IGmD8iajQRAdGr6NhZzKl5AmCUNPLl8EaFje86a2zJnEwOzAPNIQfNuPFqW3QwCRUdfb7w4YQ==
X-Received: by 2002:a17:902:a3cc:b0:1e6:ac1:6650 with SMTP id
 q12-20020a170902a3cc00b001e60ac16650mr3551317plb.65.1713574267949; 
 Fri, 19 Apr 2024 17:51:07 -0700 (PDT)
Received: from [192.168.0.13] ([172.92.174.232])
 by smtp.gmail.com with ESMTPSA id
 b14-20020a170902650e00b001e5e6877494sm4043933plk.238.2024.04.19.17.51.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Apr 2024 17:51:07 -0700 (PDT)
Subject: Re: [PATCH] riscv: dts: jh7110: Enable PLL node in SPL
To: E Shattow <lucent@gmail.com>, Bo Gan <ganboing@gmail.com>
Cc: Hal Feng <hal.feng@starfivetech.com>,
 "rick@andestech.com" <rick@andestech.com>,
 "ycliang@andestech.com" <ycliang@andestech.com>,
 "trini@konsulko.com" <trini@konsulko.com>,
 "yanhong.wang@starfivetech.com" <yanhong.wang@starfivetech.com>,
 Minda Chen <minda.chen@starfivetech.com>, "duwe@suse.de" <duwe@suse.de>,
 "namcao@linutronix.de" <namcao@linutronix.de>,
 Xingyu Wu <xingyu.wu@starfivetech.com>,
 Mason Huo <mason.huo@starfivetech.com>,
 "chanho61.park@samsung.com" <chanho61.park@samsung.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <1709694011-683-1-git-send-email-ganboing@gmail.com>
 <ZQ2PR01MB13079F11D2A7B2A20968F4FDE62BA@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
 <CANV2PTMPrQVZhWvNFxi8-RA0ZC4UAF1sHBbHiipUc01aWx6oqg@mail.gmail.com>
 <0eda64cb-4ca8-f8bc-7515-6d2a2d3d4638@gmail.com>
 <CANV2PTP3o1Q2JPCZO8Ewfye+oz9f3TVNTYhYZ3EAKtdYAhvkHg@mail.gmail.com>
From: Bo Gan <ganboing@gmail.com>
Message-ID: <f355e582-cb52-e4c5-538b-26bcf69f0a2c@gmail.com>
Date: Fri, 19 Apr 2024 17:51:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CANV2PTP3o1Q2JPCZO8Ewfye+oz9f3TVNTYhYZ3EAKtdYAhvkHg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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

On 4/16/24 9:59 PM, E Shattow wrote:
> On Tue, Apr 9, 2024 at 11:44 PM Bo Gan <ganboing@gmail.com> wrote:
>>
>> On 4/9/24 6:55 PM, E Shattow wrote:
>>> Original speed class SD cards fail with this change "unable to change mode".
>>>
>>
>> The BUS_ROOT clock will have to be switched to PLL2 anyway in U-Boot proper or
>> in Linux, because it's the parent or grandparent clock for *lots* of devices,
>> including PCIe, i2c, spi, qspi... If there's an issue with this change, then
>> I suspect there's something wrong with the dw_mmc driver.
>>
>> Bo
> 
> I've bisected and can confirm this change is what breaks original
> speed SD function on Milk-V Mars CM Lite (DFRobot mini router
> carrier). Class 10 speed SD media does not seem to be affected.
> Reverting the change allows the original speed SD media access to
> function again. SD access is functional in Linux with and without the
> change.
> 
> How to troubleshoot this?
> 
> Thanks,
> 
> E
> 

If without the change (reverted), can you read/write the same SD media in U-boot
proper? (U-boot proper will switch BUS_ROOT to PLL2). One potential problem I
could think of is perhaps the SPL built is without SPL_PINCTRL_STARFIVE/JH7110
or the u-boot dts is missing the pinctrl that properly sets drive-strength and
other properties of the mmc0/1 pins. What dtb are you using? I tested this with
visionfive2 and it's working fine. Can you share the tree/config you used to
built for Milk-V Mars CM Lite? I don't see the corresponding dts being checked-
in to u-boot tree, so it helps if you can share the code. Thanks!

Bo
