Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF1AEC4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 12:52:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B15288371;
	Tue, 23 Apr 2024 14:52:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="J/eJWRnJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5E058828C; Tue, 23 Apr 2024 14:52:14 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D4C5884EC
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 14:52:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dbarboza@ventanamicro.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1e4c4fb6af3so37766805ad.0
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 05:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1713876731; x=1714481531; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DHeRXJOB8SJKXJCftDcl2LHPZytrbfLyUr+GJK3UfAQ=;
 b=J/eJWRnJ9fHbbXu8WtKyACKff/taTGRPpp7e7tBMkrEK1mxTEZ68r63vtsY4ET3bh/
 gEeG9VKI4oCSnlkN19YRt4Wodo+Z3e91b9wB6yvKmCNntx4x+gBNXpZW7SaquNFr8O9N
 mkiMq50X6c0PY+iq8MHOfobEgHXwm3LQzuGesLJhcSb+SOeeThYR1MJtaMKcRz2DoCFD
 /76KuehsUDObD5H6cuSl043feyqwuXn1KNb+7yvpsebJiMnxWe5vfQg4KoGtl0Xca2lw
 T0mhIIgVFFOiK9Kj5ywjJFVRvoum+s0+A/aleOyvPQtKrrH19me3woISqaoeXpSBVDQD
 UQFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713876731; x=1714481531;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DHeRXJOB8SJKXJCftDcl2LHPZytrbfLyUr+GJK3UfAQ=;
 b=wO1E8Za/KEvHQuCDnCzP1mDIvkP05UF/ZGCeorBABcom6vIvyCRuCgxrxFzc7K/DoZ
 vjMDPIpdOLMYBrA2OqQeSPwA0ouKhxSYWjLlqRDtPUF2OJ2Fyc1SXMOMbe6pYpK+CMSQ
 pxQK3g6Qs+Ms6jqbfF3FomhRZr03lMooaVVbXI35ez9ssslHh8s+/ZPWy5IejieRoHRu
 MMbJddIdUcJ3RrMpxoS+044ixLBnPVYoQDQlozzTMOEkMj/RJtkFd2F9TfhW18NlZRbl
 FfIJZs0DshL6fzAke22wpw5LGMn8pGEmw6zhYLqwfFDtJc8445ZUO43bHk31LRakH0Ap
 QMWg==
X-Gm-Message-State: AOJu0YwQYfXd65vrqwlZjlJBKixibrrO/E68yGGTCIL8jPw16ZpMa6gV
 bTCbu9sHw/20Qc1qk6KGunrbORi130lEk9fAfhZFxgqQ3XCQwHqdObUaXITzKxTy+wvCS7wuklx
 L
X-Google-Smtp-Source: AGHT+IHa6QqdjrDJyix29osgn14kylW1HGcrRHrGRENXj64gVP4GkP9zzNny1+kT6G+k47AzvqJ+JA==
X-Received: by 2002:a17:903:42c5:b0:1e5:1041:7ed4 with SMTP id
 jy5-20020a17090342c500b001e510417ed4mr2653406plb.14.1713876730704; 
 Tue, 23 Apr 2024 05:52:10 -0700 (PDT)
Received: from [192.168.68.110] ([191.255.35.121])
 by smtp.gmail.com with ESMTPSA id
 e10-20020a170902b78a00b001dc3916853csm9904314pls.73.2024.04.23.05.52.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Apr 2024 05:52:10 -0700 (PDT)
Message-ID: <0d320487-04d4-4be9-a885-854dadf04be7@ventanamicro.com>
Date: Tue, 23 Apr 2024 09:52:06 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RISC-V u-boot unable to boot QEMU using '-cpu max'
Content-Language: en-US
To: Conor Dooley <conor.dooley@microchip.com>,
 Leo Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, Andrew Jones <ajones@ventanamicro.com>
References: <bed7e137-4613-4153-babc-3b8b7c911151@ventanamicro.com>
 <ZidIcgEPSb_vDQw7@swlinux02> <20240423-enzyme-book-1907217f891b@wendy>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240423-enzyme-book-1907217f891b@wendy>
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



On 4/23/24 09:41, Conor Dooley wrote:
> On Tue, Apr 23, 2024 at 01:34:42PM +0800, Leo Liang wrote:
>> On Mon, Apr 22, 2024 at 04:43:59PM -0300, Daniel Henrique Barboza wrote:
>>> [EXTERNAL MAIL]
>>>
>>> Hi,
>>>
>>> In QEMU we have a 'max' type CPU that implements (almost) all extensions that QEMU
>>> is able to emulate. Recently, in QEMU commit 249e0905d05, we bumped the extensions
>>> for this CPU.
>>>
>>> And after this commit this CPU is now unable to boot a guest using upstream
>>> u-boot. Here's the error being thrown:
>>>
>>> qemu-system-riscv64 \
>>>          -machine virt -nographic -m 8G -smp 8 \
>>>          -cpu max -kernel uboot.elf (...)
>>> (...)
>>>
>>> initcall sequence 000000008027c3e8 failed at call 000000008021259e (err=-28)
>>> ### ERROR ### Please RESET the board ###
>>>
>>>
>>> I can get the guest to boot if I disable the following extensions from the 'max' CPU:
>>>
>>>   -cpu max,zfbfmin=false,zvfbfmin=false,zvfbfwma=false
>>>
>>> Due to QEMU extension dependencies I'm not able to disable these individually. What I can
>>> say is that u-boot isn't playing ball to at least one of them.
>>>
>>> Is this an u-boot bug? Up to this point I was assuming that u-boot would silently ignore
>>> hart extensions that it doesn't support.
>>
>> Hi Daniel,
>>
>> Which u-boot version are you using?
>>
>> I think this issue is fixed by the following patch set sent by Conor.
>>
>> 	f39b1b77d8 riscv: support extension probing using riscv, isa-extensions
>> 	b90edde701 riscv: don't read riscv, isa in the riscv cpu's get_desc()
>>
>> I've tested and can reproduce the issue you mentioned if these two patches are reverted.
>>
>> Could you try with the lastest u-boot master branch again?
>>
>>
>> For reference, my testing commands are as follows:
>> 1. cd ${u-boot} && make qemu-riscv64_defconfig && make -j`nproc`
>> 2. ./${qemu}/build/qemu-system-riscv64 -nographic -machine virt -cpu max -bios u-boot.bin -m 8G -smp 8
>>
>> - u-boot branch (commit): master (38ea74d6d5c0 "Prepare v2024.07-rc1")
>> - qemu branch (commit): master (62dbe54c24db "Update version for v9.0.0-rc4 release")
> 
> I'll go take a look at this, it's possible that my patches only hide the
> problem due to the new property being prioritised.


Don't bother. I just checked with most recent u-boot master and I can't reproduce the
problem, as Leo said.

I apologize for the noise. I failed to fetch the latest upstream and do a last
test before posting it here.

We were discussing here and there about disabling these extensions in the 'max'
CPU in QEMU if u-boot wasn't able to handle them. I'm happy to see that u-boot
is now able to do so and we can keep the 'max' CPU as is.


Thanks for the help,

Daniel

