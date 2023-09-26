Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB716E7D263
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 08:38:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1439786BF7;
	Tue, 26 Sep 2023 10:38:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Z03/WJoq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2206086C13; Tue, 26 Sep 2023 10:38:49 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFEFC86BCE
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 10:38:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7EBE53F314
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 08:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1695717522;
 bh=LbiZZAL4BXaRIZwxj6xUQRVaqRTM6aRvMtHMwBbYPUY=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=Z03/WJoqjEh5udKRb9Ho5vOdhQ6AFxuHYip5Mm7QpscyKCKRw+dJS3p9fQoWFfpQ0
 2uY+KJV9sCP+Uxvnvs+SatRv71NY5XjsF3uvIJyfM2oZUNU93wlPa8DJhj00vNhR8u
 JNwWhabQoSY1pE6H3IPLmvifE+2OZZwqoj80QGa5O/JWunE7jdVAW1772RaeCdCk3a
 gzuKrAXcpunNSflmsVCuwLspsVoiG8Dex429EC9+L18nhbPln8dxE5udDUouW+JCp7
 BFnbwcK+8y6CYb977/G8/hNlrkaLqbhKQbPgiFyCGBEApL7LMg69CkeyCqDmrhBeAc
 MTo3QXG/pnmow==
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fd0fa4d08cso69012925e9.1
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 01:38:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695717522; x=1696322322;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LbiZZAL4BXaRIZwxj6xUQRVaqRTM6aRvMtHMwBbYPUY=;
 b=b3EuXAxCzcNnsvzhpCe5Dtoa8mPDzWTVpSEl+N7Y6VwmXKw9wvr2Flmke3fKdlKoTz
 +swFOVqb2KFsOyZjnYS3+ZwIcy5fBJhK+MWD2oOHYuR7u6Jj7GovuL0o06JVlSfconKS
 fEerZoC0oHaXyoOYVisBLLVuGQ0/ZFFbqqVWRFhLLL6reHaZJfIc3avSVunBwhLMVbK1
 Trzvmns+MoBWOL8A0vn8/52ETVQuOrEW3eFdMiTKLr/YLIMwmi/8+s+/iCGl+79cJuuB
 HlzAl2wwT5qxVgkxzqViAqVsw0HMH3lLOMrttvOzQPiC2HB51FZP2UUG+hc7Fgg64xe7
 gv7g==
X-Gm-Message-State: AOJu0YzJ7PKq7im/wZ8HRn+d74dmMFAKGCM8qpsVeyUS8N2Eg6VCPUUC
 IYeKG6iWckgzDS0Ou/LLM8Bf5cHlox0R5y2klHJF5+rrNBL5Doclnc6w31BIVW7dR1Vwm6ARfcJ
 mC11ZnHYuK+I/nUiZ1Zcw8Vgu7x9hm2HqQMxK9LA=
X-Received: by 2002:a05:600c:204:b0:401:b6f6:d8fd with SMTP id
 4-20020a05600c020400b00401b6f6d8fdmr7971570wmi.6.1695717522138; 
 Tue, 26 Sep 2023 01:38:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGj0NWRvN/vjMexsWY/we6gJniQc29AMw1NP1aeg5nPR8XdiYKF1dtDRJj/ucZ6zPywanOvtQ==
X-Received: by 2002:a05:600c:204:b0:401:b6f6:d8fd with SMTP id
 4-20020a05600c020400b00401b6f6d8fdmr7971562wmi.6.1695717521709; 
 Tue, 26 Sep 2023 01:38:41 -0700 (PDT)
Received: from [192.168.123.94] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 m28-20020a05600c3b1c00b004053a2138bfsm12843582wms.12.2023.09.26.01.38.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Sep 2023 01:38:41 -0700 (PDT)
Message-ID: <2e0732ae-ade7-4f36-9c50-168b34a3838b@canonical.com>
Date: Tue, 26 Sep 2023 10:38:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] riscv: enable CONFIG_DEBUG_UART by default
Content-Language: en-US, de-DE
To: Leo Liang <ycliang@andestech.com>
Cc: Rick Chen <rick@andestech.com>, u-boot@lists.denx.de
References: <20230922233526.62642-1-heinrich.schuchardt@canonical.com>
 <ZRKN7VB6MNttakKv@swlinux02>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <ZRKN7VB6MNttakKv@swlinux02>
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

On 9/26/23 09:53, Leo Liang wrote:
> Hi Heinrich,
> 
> On Sat, Sep 23, 2023 at 01:35:26AM +0200, Heinrich Schuchardt wrote:
>> Most boards don't enable the pre-console buffer. So we will not see any
>> early messages. OpenSBI 1.3 provides us with the debug console extension
>> that can fill this gap.
>>
>> For S-Mode U-Boot enable CONFIG_DEBUG_UART by default.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   arch/riscv/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index 1c62c2345b..06fae7ebe8 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -141,6 +141,7 @@ config RISCV_MMODE
>>   
>>   config RISCV_SMODE
>>   	bool "Supervisor"
>> +	imply DEBUG_UART
> 
> This patch will cause the following compilation warnings.
> Could you take a look at them ?
> 
> It seems that some configuration values will not be set
> if we imply DEBUG_UART.
> 
> u-boot$ make qemu-riscv64_spl_defconfig
>    HOSTCC  scripts/basic/fixdep
>    HOSTCC  scripts/kconfig/conf.o
>    YACC    scripts/kconfig/zconf.tab.c
>    LEX     scripts/kconfig/zconf.lex.c
>    HOSTCC  scripts/kconfig/zconf.tab.o
>    HOSTLD  scripts/kconfig/conf
> #
> # configuration written to .config
> #
> 

Hello Leo,

thanks for testing.

> u-boot$ make ARCH_FLAGS="-march=rv64imafdc" -j`nproc`

This does not work with a current gcc.
arch/riscv/lib/cache.c:12: Error: unrecognized opcode `fence.i', 
extension `zifencei' required

> scripts/kconfig/conf  --syncconfig Kconfig
> .config:78:warning: symbol value '' invalid for DEBUG_UART_BASE

Please, observe:

origin/next lacks these patches

d14222e7c152 ("risc-v: implement DBCN write byte")
dfe08374943c ("risc-v: implement DBCN based debug console")

You must add these when testing the current patch.

On Ubuntu 23.10 I have been running

export CROSS_COMPILE=riscv64-linux-gnu-
make clean
make qemu-riscv64_spl_defconfig
make -j8

for origin/master and the current patch. I did not see any warning.

Same for origin/next and all three patches applied.

We have

config DEBUG_UART_BASE
         hex "Base address of UART"
         depends on DEBUG_UART
         default 0 if DEBUG_SBI_CONSOLE

since 41f7be73344.

I don't see any issues in
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/17882
(origin/master + this patch).

Best regards

Heinrich

> .config:79:warning: symbol value '' invalid for DEBUG_UART_CLOCK
> .config:1347:warning: symbol value '' invalid for SPL_DEBUG_UART_BASE
> ...
> 
> Best regards,
> Leo
> 
>>   	help
>>   	  Choose this option to build U-Boot for RISC-V S-Mode.
>>   
>> -- 
>> 2.40.1
>>

