Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B25CCCFB441
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 13:35:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 378CB88B11;
	Mon,  7 Oct 2024 15:35:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xsMWJBss";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1FD388B3F; Mon,  7 Oct 2024 15:35:35 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 278C988AE4
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 15:35:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a99543ab209so134639366b.2
 for <u-boot@lists.denx.de>; Mon, 07 Oct 2024 06:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728308132; x=1728912932; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KAy6MR1susd9E0jE8ahHOT4eaW9qgrR5F72KGYRWb1Q=;
 b=xsMWJBss4EyStQT2F2GTEN1UvGqG8Gtl8fIh7p775plf7O2ZNydSh40VvFcqNN/Y9v
 EQ+iS1IejX13yPZjlW3Q9ykKY6xaWTO1SznZ1hFbWW8OZrQk+Y7xLymQAdIeQOc30VPj
 8501QOSAW50zmD8JGtRSpcyJyzrPHR/u3wjrxH6IXgalzQ+fLFLJWNg/tHyCJyJqFrNQ
 waoHuKBXj44Ob+FCFukTF7T4Rk9IRKiPzYa5QqwtER6Y9fNC+3qpJbhBd6cOGn9XAodx
 NVTTO8tATOxZO5iOGDTdK+kUCJdJEgWbh5n8pmUzKDe0ckbuxl/gFKYfZvuaXeGzKAnb
 vJiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728308132; x=1728912932;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KAy6MR1susd9E0jE8ahHOT4eaW9qgrR5F72KGYRWb1Q=;
 b=DkeMtEE43Kc7HrRdWv/c7gT5e43XzJRW9ZGITeKvauMcHReIFTErJ4acNXTzBtvPLL
 a/fOGyiLorHsKcl+3gf7B/nBxPbKYJrKkDHstnrXe6fZt4YGI7R54yI0juEOrcLqN9Ld
 mSYba7bwPaUcg2IJW3Q++L2JJClxJKLx5d/UEjVWAiU5qyGMGF8ZAHiJnj78R1s6iVlZ
 0PRrahAPhSXBXJgqqRGMGZfHN5zqaU1bbkmdqTeqQTMByr2USzdgEoh5RhEgKoPsXB8e
 oaxEvdqI2UrxmA5vzzj2es2Sa03pasUhzzxzGODDgjxZR3ZmDPVycJW4ZwZyd85vXPPr
 5Qrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6AzB81K6YTe6Sa2JlVl0mvTQruioig6XTFfYUeCxl/KBWyVWbFjAwDt29AD5f1Pb2my7HfLI=@lists.denx.de
X-Gm-Message-State: AOJu0YxWfkTtyX7N24MR+ZmWUWyqm+hwVWi+WZiPhI9dQTt25Gg9cbUu
 2y9ZpHdj5TXgz45uO++yoJBlRQQFp7YNEAy11HwvbKktpMbPRx9hVQ8RONNRGa8=
X-Google-Smtp-Source: AGHT+IGBEaWEphrabxEbC/1YTbuMdDI2N6M6iWPDqnO2YS7zQmfkldhtnh7UImxDIXEaI78iEljEeQ==
X-Received: by 2002:a17:907:971c:b0:a8d:67d5:5e16 with SMTP id
 a640c23a62f3a-a991c077e14mr1357675466b.57.1728308132498; 
 Mon, 07 Oct 2024 06:35:32 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:6f4b:a50f:5140:7b75?
 ([2a01:e0a:3cb:7bb0:6f4b:a50f:5140:7b75])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9941a697cesm295935966b.173.2024.10.07.06.35.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2024 06:35:32 -0700 (PDT)
Message-ID: <15642b42-54dc-4b31-9ca9-b62368e0046d@linaro.org>
Date: Mon, 7 Oct 2024 15:35:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linker_lists: set LINKER_LIST_ALIGN to 8 if 64BIT
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alexander Gendin <agendin@matrox.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, u-boot@lists.denx.de
References: <20241007094206.2928071-1-jerome.forissier@linaro.org>
 <4f24827f-22d9-49d3-995c-6e2c3ed6859e@linaro.org>
 <86b48670-ada7-4245-b12f-9b6e423e3db5@gmx.de>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <86b48670-ada7-4245-b12f-9b6e423e3db5@gmx.de>
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



On 10/7/24 15:31, Heinrich Schuchardt wrote:
> On 07.10.24 14:55, Jerome Forissier wrote:
>>
>>
>> On 10/7/24 11:42, Jerome Forissier wrote:
>>> CPU_MIPS64 needs 8-byte alignment on the linker lists, otherwise an
>>> exception may occur. In fact all 64BIT architectures should default
>>> to 8; that's what this patch does.
>>> Fixes an issue found on malta64 with QEMU:
>>>
>>>   Breakpoint 1, lists_driver_lookup_name (name=0xffffffffbe043578 "root_driver") at /home/uboot/u-boot/drivers/core/lists.c:31
>>>   31                      if (!strcmp(name, entry->name))
>>>   [...]
>>>   ld      a1,0(s0)
>>>
>>>   (gdb) p/x &entry->name
>>>   0xffffffffbe04b0d4
>>>   (gdb) p/x $s0
>>>   0xffffffffbe04b0d4
>>>
>>>   $ grep __u_boot_list /tmp/malta64/u-boot.objdump
>>>   4 __u_boot_list 000018e0  ffffffffbe04a4d4  ffffffffbe04a4d4  0004a584  2**2
>>>
>>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>>> ---
>>>   arch/Kconfig | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/Kconfig b/arch/Kconfig
>>> index 8f1f4667012..72bf4029251 100644
>>> --- a/arch/Kconfig
>>> +++ b/arch/Kconfig
>>> @@ -45,7 +45,7 @@ config SYS_CACHELINE_SIZE
>>>   config LINKER_LIST_ALIGN
>>>       int
>>>       default 32 if SANDBOX
>>> -    default 8 if ARM64 || X86
>>> +    default 8 if 64BIT
>>>       default 4
>>>       help
>>>         Force the each linker list to be aligned to this boundary. This
>>
>> Superseded by https://patchwork.ozlabs.org/project/uboot/patch/20241007094206.2928071-1-jerome.forissier@linaro.org/
> 
> It seems you are pointing to this very patch. You probably wanted to
> respond to an earlier version.

Sorry about that. I wanted to reply to [1] indeed. And I wondering
why my reply wouldn't show up on patchwork... :o

[1] http://patchwork.ozlabs.org/project/uboot/patch/20241003142030.1610222-1-jerome.forissier@linaro.org/

Thanks.
-- 
Jerome
