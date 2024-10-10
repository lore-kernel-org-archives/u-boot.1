Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1106CF11F5
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 13:29:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6509089277;
	Thu, 10 Oct 2024 15:29:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PDVY2SgO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 278308928E; Thu, 10 Oct 2024 15:29:41 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F13E8928E
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 15:29:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-430ee5c9570so10110615e9.3
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 06:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728566970; x=1729171770; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TTYD8S+6c+6pNuMKoLqs1+DIh/qLUGJkS1CmG9skUao=;
 b=PDVY2SgOytFp90njsITkzSFJx53WJAg3wzCE6qocH0etYrGd/Wlk/T7FOkejjJ8kMl
 xzvwY7E35yk5IdavdTpjmJGZ60oaAtVPc7O7JixvDPubYLY91bMew5qpZ7LHO6MX3Fv4
 P7A0rsU9FyMORmtiHsjt49cuC4G7kZ29Oqs2b9QuYT0PZRVTl4SZM6nVgJN7fx0uY2DF
 Ih/uL6HnNrwlbHbX37gTniYfW/RxKuhC7Zh1iKwh+J/7SIiXI/+xoITJdfiAWfAoBTHf
 sD/XwTDsplSU875IGtIpW7llEwKbYvFgwDKTWKZd9pmlxLDj2smer47yUzO2UFnQq6PI
 7ctQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728566970; x=1729171770;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TTYD8S+6c+6pNuMKoLqs1+DIh/qLUGJkS1CmG9skUao=;
 b=AtGIrvRU+bIgO+v1jQ3Hexo3SQF4sSp/Zrwo/YPH/h+02+t4/jXjF0apqK2SUjWWIy
 PTUjpiot1Wi273bpsZ8rUZyxTA3j2PbXK3dBOU/v5kVF0Cx1gt7U2fgO5cb8gZJiemRT
 Ky69IPqIkJ5+YMpmlZoQQP4MTq20HLhNqvNbpipMR9b+LHvU7DSe8KdJx0HuLGeGEeV2
 +E6lmlwHgbSZ9QzaGTTrp1oPy/4lhaXD8a5eQqX3fjuTEqYDlbQiGmzC/XobEyQdpdmT
 n0jWxceuzc97JQR1tEnYeJY20x5Ndx1LWy/OYWxTldRHGnrYBz0sQTG0ohu/SZGkFOSW
 P0uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWF7cdwSo0JLdNSiqX0bdfEO77gRHxgnAdHJMVLGOUGv7hSPrUryndezYUM/DR0/oiJZw6nGtM=@lists.denx.de
X-Gm-Message-State: AOJu0Ywve3pDOkDtmbVFkMxQi7rtIn9TlNP0ll7jlQVE1Do/M2a69FJL
 DpaK4/2cz2gYUMvd7JI1+hTGwB2fxUKRlw9wbPuOS/10/o5vaZiqJ4dQtw1oW5c=
X-Google-Smtp-Source: AGHT+IHVijPLVGTekf61wsmRzufGm3ynuXies4Wd6lEI/CaNL8FeB0CpPVdqOLi19W3hdgtrwcbCjg==
X-Received: by 2002:a05:600c:4f0c:b0:428:d31:ef25 with SMTP id
 5b1f17b1804b1-430ccf1d787mr63057305e9.12.1728566969656; 
 Thu, 10 Oct 2024 06:29:29 -0700 (PDT)
Received: from [192.168.7.95] ([212.114.21.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431182ffd14sm16563525e9.18.2024.10.10.06.29.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Oct 2024 06:29:29 -0700 (PDT)
Message-ID: <d66901bb-e1da-4ee3-b546-19c817adcbfe@linaro.org>
Date: Thu, 10 Oct 2024 15:29:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 03/29] linker_lists: set LINKER_LIST_ALIGN to 8 for
 CPU_MIPS64
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>, Simon Glass <sjg@chromium.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Alexander Gendin <agendin@matrox.com>, u-boot@lists.denx.de
References: <cover.1727968902.git.jerome.forissier@linaro.org>
 <1699de5384a71c0d0ad535cdc48cc2b95087719d.1727968902.git.jerome.forissier@linaro.org>
 <5c4686da-f39f-4a48-ba57-4d2f7fb3e66a@gmx.de>
 <c9f50143-4e49-43df-913e-43bf5f5484cc@linaro.org>
 <20241004182822.GH4737@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20241004182822.GH4737@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
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



On 10/4/24 20:28, Tom Rini wrote:
> On Fri, Oct 04, 2024 at 02:55:58PM +0200, Jerome Forissier wrote:
>>
>>
>> On 10/4/24 14:04, Heinrich Schuchardt wrote:
>>> On 03.10.24 17:22, Jerome Forissier wrote:
>>>> Note: Patch posted separately [0].
>>>>
>>>> [0] https://patchwork.ozlabs.org/project/uboot/patch/20241003142030.1610222-1-jerome.forissier@linaro.org/
>>>>
>>>> CPU_MIPS64 needs 8-byte alignment on the linker lists, otherwise an
>>>> exception may occur. Fixes an issue found on malta64 with QEMU:
>>>>
>>>>   Breakpoint 1, lists_driver_lookup_name (name=0xffffffffbe043578 "root_driver") at /home/uboot/u-boot/drivers/core/lists.c:31
>>>>   31                      if (!strcmp(name, entry->name))
>>>>   [...]
>>>>   ld      a1,0(s0)
>>>>
>>>>   (gdb) p/x &entry->name
>>>>   0xffffffffbe04b0d4
>>>>   (gdb) p/x $s0
>>>>   0xffffffffbe04b0d4
>>>>
>>>>   $ grep __u_boot_list /tmp/malta64/u-boot.objdump
>>>>   4 __u_boot_list 000018e0  ffffffffbe04a4d4  ffffffffbe04a4d4  0004a584  2**2
>>>>
>>>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>>>> ---
>>>>   arch/Kconfig | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/Kconfig b/arch/Kconfig
>>>> index 8f1f4667012..8f4df849801 100644
>>>> --- a/arch/Kconfig
>>>> +++ b/arch/Kconfig
>>>> @@ -45,7 +45,7 @@ config SYS_CACHELINE_SIZE
>>>>   config LINKER_LIST_ALIGN
>>>>       int
>>>>       default 32 if SANDBOX
>>>> -    default 8 if ARM64 || X86
>>>> +    default 8 if ARM64 || X86 || CPU_MIPS64
>>>
>>> Shouldn't we set 8 byte alignment on all 64bit architectures including
>>> riscv64?
>>>
>>>     default 8 if 64BIT
>>
>> Makes sense.
>>
>>>
>>> @Simon
>>> I would not know why 32bit X86 should need 8 byte alignment.
>>> I am a bit astonished that you chose 32 byte alignment for the Sandbox.
>>> Is there any justification to use more than 4 on the 32bit Sandbox and
>>> more than 8 on the 64bit Sandbox? If yes, we should document it via a
>>> comment.
>>
>> I tried running what CI does manually (.azure_pipelines.yml) with
>> "default 32 if SANDBOX" removed, and I got SIGSEGV with
>> TEST_PY_BD=sandbox. OTOH, TEST_PY_BD=sandbox64 worked fine but it might
>> have been a fluke.
> 
> I think we can leave sandbox as a future cleanup, and perhaps file an
> issue at https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/ so
> it doesn't get lost.

https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/29

Thanks,
-- 
Jerome
