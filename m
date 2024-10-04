Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E67DBCFA777
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 12:56:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B3408865D;
	Fri,  4 Oct 2024 14:56:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lHyaVsdl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE5858870D; Fri,  4 Oct 2024 14:56:02 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69BEA88606
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 14:56:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-53992157528so2492864e87.2
 for <u-boot@lists.denx.de>; Fri, 04 Oct 2024 05:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728046560; x=1728651360; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7UxGieZP0TjHn3067dICPvAGYenWCXD+NWsj3lLnvEg=;
 b=lHyaVsdloRtEmwekcBLO60r/McxW33vBZdzDMyuAnohiEV7iGl9eZr2H656lfE0E1F
 WorDZAYevwHR88CbxAIxU0vqB7YKgHR0ZgBzIgoWGT3NlB19Uarvt3WwZZOyDHfqcrQ1
 jwr/xcLSWLpC7H6/G+MPyqoyPMAYfkRGLsxiHQau5duLIcyRypr9mb0ZOzVynSqT16QP
 rkDv6KSAvkz2Hxf7LfveaAsywvQ6vb/WVbYU6yNX150pN2KDrxl0o3wLnP9jaYQahwtz
 s8WLyIG7fy7z87hMwq5RrZ5+pEoN0ayrldIY+ekXnYJ9CfQKErwdqrZ49q5UvwPUEtQv
 Fz0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728046560; x=1728651360;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7UxGieZP0TjHn3067dICPvAGYenWCXD+NWsj3lLnvEg=;
 b=S1zh+R2BqFfEP1fcgdVD/ksS0ttTlKnbg65oyl7VaJDZQ6p9w4hCEX1876hSD85/Sn
 5+5ECiUXl4MsS5iPUpbT1qMWd9skY+jtpEev5h3ZY7+3l1B7zP0fPVCBy0ZcwZ9TMsIi
 aSNFwyEqJYWa2oGh5GPBM28zxTJphz4qEePhR59FbqQk7Jq1iKC1yNLeu/8oLPuiEn3p
 vKudaB0N7pUdZGQrLIvJ3Ke0R2KHbJS5fWlgOhNs4o+il/yXaC8088sgd5ml7zHo7o3M
 gprR36FFVsabuKoRaVq/GpbGYNxvTjcM1a3EahoqmaYNQqG1brdc+/mgdrNgr3+17SNr
 InLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUe2HpawEAAJa5QQQVNaNbBajaLnzGgjPIHpdhC0yOwTzblWsHLKCh/XhgRyjc4JDr0LowJpfg=@lists.denx.de
X-Gm-Message-State: AOJu0YwQuHjcWTMPcS1piD0a9o9AE1Ru+rZ0gnN9DmN6dUTcqEQLYn0B
 +XvzM9ICip62wnS2s46gdBFEJP2R59LIw8zDNqHY6G36tceRrv8y1eKRLX+qYNA=
X-Google-Smtp-Source: AGHT+IGvh1yM3v92vQHr/DafGvNLmTXrV9wG/b81ASaCitvQ2WCuNo2FvgLsOLMDPRPDlvfTg2R6ww==
X-Received: by 2002:a05:6512:3da2:b0:52e:eacd:bc05 with SMTP id
 2adb3069b0e04-539ab9f17c1mr1195065e87.61.1728046559638; 
 Fri, 04 Oct 2024 05:55:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:c79f:f6d3:6b70:dbe?
 ([2a01:e0a:3cb:7bb0:c79f:f6d3:6b70:dbe])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99102a5826sm223950766b.75.2024.10.04.05.55.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Oct 2024 05:55:59 -0700 (PDT)
Message-ID: <c9f50143-4e49-43df-913e-43bf5f5484cc@linaro.org>
Date: Fri, 4 Oct 2024 14:55:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 03/29] linker_lists: set LINKER_LIST_ALIGN to 8 for
 CPU_MIPS64
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Alexander Gendin <agendin@matrox.com>, u-boot@lists.denx.de
References: <cover.1727968902.git.jerome.forissier@linaro.org>
 <1699de5384a71c0d0ad535cdc48cc2b95087719d.1727968902.git.jerome.forissier@linaro.org>
 <5c4686da-f39f-4a48-ba57-4d2f7fb3e66a@gmx.de>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <5c4686da-f39f-4a48-ba57-4d2f7fb3e66a@gmx.de>
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



On 10/4/24 14:04, Heinrich Schuchardt wrote:
> On 03.10.24 17:22, Jerome Forissier wrote:
>> Note: Patch posted separately [0].
>>
>> [0] https://patchwork.ozlabs.org/project/uboot/patch/20241003142030.1610222-1-jerome.forissier@linaro.org/
>>
>> CPU_MIPS64 needs 8-byte alignment on the linker lists, otherwise an
>> exception may occur. Fixes an issue found on malta64 with QEMU:
>>
>>   Breakpoint 1, lists_driver_lookup_name (name=0xffffffffbe043578 "root_driver") at /home/uboot/u-boot/drivers/core/lists.c:31
>>   31                      if (!strcmp(name, entry->name))
>>   [...]
>>   ld      a1,0(s0)
>>
>>   (gdb) p/x &entry->name
>>   0xffffffffbe04b0d4
>>   (gdb) p/x $s0
>>   0xffffffffbe04b0d4
>>
>>   $ grep __u_boot_list /tmp/malta64/u-boot.objdump
>>   4 __u_boot_list 000018e0  ffffffffbe04a4d4  ffffffffbe04a4d4  0004a584  2**2
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> ---
>>   arch/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/Kconfig b/arch/Kconfig
>> index 8f1f4667012..8f4df849801 100644
>> --- a/arch/Kconfig
>> +++ b/arch/Kconfig
>> @@ -45,7 +45,7 @@ config SYS_CACHELINE_SIZE
>>   config LINKER_LIST_ALIGN
>>       int
>>       default 32 if SANDBOX
>> -    default 8 if ARM64 || X86
>> +    default 8 if ARM64 || X86 || CPU_MIPS64
> 
> Shouldn't we set 8 byte alignment on all 64bit architectures including
> riscv64?
> 
>     default 8 if 64BIT

Makes sense.

> 
> @Simon
> I would not know why 32bit X86 should need 8 byte alignment.
> I am a bit astonished that you chose 32 byte alignment for the Sandbox.
> Is there any justification to use more than 4 on the 32bit Sandbox and
> more than 8 on the 64bit Sandbox? If yes, we should document it via a
> comment.

I tried running what CI does manually (.azure_pipelines.yml) with
"default 32 if SANDBOX" removed, and I got SIGSEGV with
TEST_PY_BD=sandbox. OTOH, TEST_PY_BD=sandbox64 worked fine but it might
have been a fluke.

Thanks,
-- 
Jerome

> 
> Best regards
> 
> Heinrich
> 
>>       default 4
>>       help
>>         Force the each linker list to be aligned to this boundary. This
> 
