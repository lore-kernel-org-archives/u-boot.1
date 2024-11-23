Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE6BE6688F
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 22:59:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7736189419;
	Sat, 23 Nov 2024 23:59:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="cVmh4RsP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F01DA89407; Sat, 23 Nov 2024 23:59:44 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E4A189401
 for <u-boot@lists.denx.de>; Sat, 23 Nov 2024 23:59:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CAABC3F2B3
 for <u-boot@lists.denx.de>; Sat, 23 Nov 2024 22:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1732402781;
 bh=8Ra6SLWUTDdLo55pc1JK1NB7Oc6ey3jq3RbZv5J9DXg=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=cVmh4RsPONhuOqS7vs7C0ZYznzk9mAUu3ypJsCPNUr4Jdl440c3XOKF3VXj8ihHLC
 zG6IaJ/3BFRF3IRQTmrcU9EGMDnTko8zCU0XDMj0qLlEa2Jqqj70kJGeRaAVZREEiP
 6Bi9xa0ITYxJ8N9N8zNJKA+t/ABfyTGAwM6Nx/Q+uibemTy6i4kGLnoSGKGEwv72ZC
 xBOHrITB2TtDIqLvQPTqg9DwJhpKjKOAHAO/ABMcZL+y0tbGMBG6rUuKDmn/pH1ljr
 21m4sYvjlu2kkcD6cItK0X31rs4MvutGh5/uFGeNmQkXSvYl+8bzcOVwHfN7uBhFBu
 /9c1fISlhL3xg==
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3822ebe9321so1968603f8f.2
 for <u-boot@lists.denx.de>; Sat, 23 Nov 2024 14:59:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732402781; x=1733007581;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8Ra6SLWUTDdLo55pc1JK1NB7Oc6ey3jq3RbZv5J9DXg=;
 b=flWsJAs3TohZMPbwzjmI2pKri6JwaQzy3OSA82Luw9ZgHT0AxXNkGfBsJI6lRJl+lJ
 VpLmqVTgwbW0j1nbsuuNpj/os4BpWFMxHGTlZUId7i315Z3qJmojotHgQqhp/DM1md+G
 1VpQiXzsc3V38JR4s72voEYROa5Wcc+3iR3bbSnnl1ll6KlBoVBy/EnGlVzrAE59/sJ7
 emxxdPy02y/SFJFPamYGoKVYt5gAyYMZAErAJFLny+JbDZ13WAd/YSnA+OUdpQC0kiJK
 uVjlYORiMzwdnWbx6rqCNJMYcyCkN6F764+6oAWoreMtDs+LVcHByI2npamFdKdeFlrs
 V6tg==
X-Gm-Message-State: AOJu0YwdWVBY8ZVSsqpcEBx4Mzamw7wkObm1BOgfKBI+/2KKBFwuFUqU
 jLZsoUw9v14fHCFRtqDLuqLaDRIC+SQpHZS1Te5lkJw/2zNqkBeN2kfql52Q58Bfa8Cfo1NhLy7
 rJCc3WYzf6jBG3u1rPAWdTYtId59hTNeZUJipKYRo+NI1OucrkLD39qnKULKDTyTYUk8=
X-Gm-Gg: ASbGnct91JKDEUj6VzarErvNdBOlFuS+prFEUuz0nbgtwiHouPxMAe2vu/colmYecm1
 0ek+KofoT13WEHMlbwkQv7NvQgRSvIMjgM7rYsYF1DX4Clbufcs49E1QQx8MmyGmhxTk3DQ1fty
 uM3pJPufDJJ28S1NqywCaFf7mmnUOUyWM4/pjmtKZrNgC8kKifmNQAeVgJ0im7KdCkDXvP7FJcn
 0X3WCqxhD0J72h/HN+/xi1bpckmyEQaiTxVr1jL4MxGNGpEgIPiX6VaMzqc42yk8Wx9leb/Jme6
 RMNHtI0O1s2hbMvmEP/okAcRWFkygAugqXZ6q6eL6Hd/2dI=
X-Received: by 2002:a05:6000:154c:b0:382:5471:655b with SMTP id
 ffacd0b85a97d-38260bc8649mr6913381f8f.47.1732402781328; 
 Sat, 23 Nov 2024 14:59:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4USX16xU3JhA0TdpKUI0sbGl8yx07zXuzTJTKmwo3JPVSGDjQsrhXrJppu2PECZYeW4B9mQ==
X-Received: by 2002:a05:6000:154c:b0:382:5471:655b with SMTP id
 ffacd0b85a97d-38260bc8649mr6913370f8f.47.1732402780357; 
 Sat, 23 Nov 2024 14:59:40 -0800 (PST)
Received: from [192.168.123.161]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fb271ffsm6297382f8f.53.2024.11.23.14.59.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 23 Nov 2024 14:59:38 -0800 (PST)
Message-ID: <69ff1a82-e887-4950-bd06-c8e16f776f8a@canonical.com>
Date: Sat, 23 Nov 2024 23:59:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] examples: use QEMU compatible LOAD_ADDR on 32-bit ARM
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
References: <20241123084853.59252-1-heinrich.schuchardt@canonical.com>
 <20241123152447.GZ3600562@bill-the-cat>
 <CAM=mAO=zNaaBMFzcqyek8OTZfLbD26gw+OMH2eB8dMgYJXfa5g@mail.gmail.com>
 <20241123225541.GA3600562@bill-the-cat>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20241123225541.GA3600562@bill-the-cat>
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

On 11/23/24 23:55, Tom Rini wrote:
> On Sat, Nov 23, 2024 at 07:23:35PM +0100, Heinrich Schuchardt wrote:
>> Tom Rini <trini@konsulko.com> schrieb am Sa., 23. Nov. 2024, 16:24:
>>
>>> On Sat, Nov 23, 2024 at 09:48:53AM +0100, Heinrich Schuchardt wrote:
>>>> On many 32-bit ARM boards including QEMU memory starts at 0x40000000.
>>>
>>>>
>>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>>> ---
>>>>   examples/api/Makefile | 4 ----
>>>>   1 file changed, 4 deletions(-)
>>>>
>>>> diff --git a/examples/api/Makefile b/examples/api/Makefile
>>>> index 722c7e45904..f0f107562f1 100644
>>>> --- a/examples/api/Makefile
>>>> +++ b/examples/api/Makefile
>>>> @@ -9,11 +9,7 @@ ifeq ($(ARCH),powerpc)
>>>>   LOAD_ADDR = 0x40000
>>>>   endif
>>>>   ifeq ($(ARCH),arm)
>>>> -ifdef CONFIG_64BIT
>>>>   LOAD_ADDR = 0x40400000
>>>> -else
>>>> -LOAD_ADDR = 0x1000000
>>>> -endif
>>>>   endif
>>>>   ifeq ($(ARCH),mips)
>>>>   ifdef CONFIG_64BIT
>>>
>>> If we're going to start cleaning this area up and expecting it to work
>>> more broadly, is there a reason we can't use CONFIG_SYS_LOAD_ADDR or
>>> CONFIG_STANDALONE_LOAD_ADDR here?
>>>
>>
>> loadaddr == CONFIG_SYS_LOAD_ADDR on RISC-V QEMU. Command bootelf did not
>> work for me, if the ELF binary had been loaded to its LOAD_ADDR.
>>
>> I did not investigate yet why bootelf fails in this case.
> 
> The examples, broadly speaking, do not run out of the box since they
> assume an address to be loaded in to memory at and run from, rather than
> a Kconfig entry. The next problem for RISC-V is that, well, there's no
> api/api_platform-riscv.c file (and forever ago I steered people away

https://patchwork.ozlabs.org/project/uboot/patch/20241123084754.59182-2-heinrich.schuchardt@canonical.com/

provides api_platform.c for RISC-V. This patch is only about ARM.

Best regards

Heinrich


> from adding that and instead adding EFI support, the patches are in
> patchwork somewhere).
> 

