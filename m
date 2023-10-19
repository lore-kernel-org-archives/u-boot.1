Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D361CDB482
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 15:24:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7CE38729D;
	Thu, 19 Oct 2023 17:24:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Csa14YLO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DED2E8729D; Thu, 19 Oct 2023 17:24:40 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1F4D8727D
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 17:24:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 12DD63F21F
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 15:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1697729077;
 bh=CTpIiCxLrO1z7g/snu2OB8xif04TNf5LAkGR3KiaFVU=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=Csa14YLOeMbPsd5GhIQk3Ro7HMBui+8uINSWqvgsVmbpOuMBPKfZPN3dkv91eU3nu
 +3bgAns9/9Ce7uYDOXAz8ZwuHf3tBu7qFccFv8mGf0ZLtreXliP6pWp1kFXQH0CrPO
 6Pq6YJZez8V8fuAbXXibEu+PTNYMFJLPmhppiO7Ge04/HU5VdZ1+wZylKxf8U/5JRX
 UtbuTH01mblm8Rf4epfQtQCJjbzJuCv6DMlLaT091e55JTQNGTVI4hqCg0zFVhCGgF
 FY/Rqq/VwD5yugMQtCzqYjHPtEn6HodLBF+vu+zy8He7QJteX3Yw0+T59iLSfzobIq
 aQLUWfYWLcvGw==
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-32cef5f8af5so500150f8f.1
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 08:24:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697729076; x=1698333876;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CTpIiCxLrO1z7g/snu2OB8xif04TNf5LAkGR3KiaFVU=;
 b=RP3OEW2JL0L7aNnfC5h3ngN2JVGiKDE4TQBK30im5nB6w9x7MWlszDUNF/N/MWpWc/
 0PqCw/HQQq/SN5qdaVM/qDtMQWem5kaWSgvDkfHHDb7ZJgQ3Fbgl3yQn7IdNi3VXZhHl
 y0scNTRSA1SnM1f5PQ86WgLQOBdUeanaYFxI/YxLdAhLUxBLD8GisepnIQ/7sNKbhT6+
 DCSA18AHnnL8JHVvgQLn7Sj+cbucc7RrWvoHVU4UhyEjBb/jYzfCZ6fNVSiknBqyMMLG
 7z5vqaaCL2tspoGghbQ28qphutTXbe2davBDpADq/xpMEgw8PSEdbotOxLTxWoUU6AJn
 ZKtQ==
X-Gm-Message-State: AOJu0YzMq2UNnwVKIB2INBefMjEnetPtY1vC75eNFWJ8VfQnIrTvJHEl
 5Khe3TL04zRn283ojEuEeED0nZMZzQG4j6osI50qbF1CVvNz1jzhyJaFYOuNElNvPwCFQLQEsaU
 OiIohfiz2CqcDwZuh9cNCctLOeySpcG5jUSLZxSs=
X-Received: by 2002:adf:b307:0:b0:314:3369:df57 with SMTP id
 j7-20020adfb307000000b003143369df57mr2486600wrd.5.1697729075967; 
 Thu, 19 Oct 2023 08:24:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGop6sH6HV44JcUnosIZH41rUeYKrI8WY9xI40+33DLtBxtZn0KFePMiN5q6wf+ayXvQQBtxg==
X-Received: by 2002:adf:b307:0:b0:314:3369:df57 with SMTP id
 j7-20020adfb307000000b003143369df57mr2486567wrd.5.1697729075467; 
 Thu, 19 Oct 2023 08:24:35 -0700 (PDT)
Received: from [192.168.123.67] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 e18-20020adffc52000000b0032da35baf7bsm4698222wrs.113.2023.10.19.08.24.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Oct 2023 08:24:34 -0700 (PDT)
Message-ID: <5f4d1fd6-3f6f-4c68-a65b-ac4ab43f0490@canonical.com>
Date: Thu, 19 Oct 2023 17:24:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v4 11/24] efi: Rearrange the Kconfig for CMD_BOOTEFI_BOOTMGR
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
References: <20231019150105.714407-1-trini@konsulko.com>
 <20231019150105.714407-11-trini@konsulko.com>
 <4a17c974-fd56-4412-93e3-47bfe3268489@canonical.com>
 <20231019151933.GC3119521@bill-the-cat>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20231019151933.GC3119521@bill-the-cat>
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

On 19.10.23 17:19, Tom Rini wrote:
> On Thu, Oct 19, 2023 at 05:16:28PM +0200, Heinrich Schuchardt wrote:
>> On 19.10.23 17:00, Tom Rini wrote:
>>> From: Simon Glass <sjg@chromium.org>
>>>
>>> The command should not be used to enable library functionality. Add a
>>> new BOOTEFI_BOOTMGR Kconfig for that. Adjust the conditions so that the
>>> same code is built.
>>>
>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>> Suggested-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>>> ---
>>> Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>> Changes in v4:
>>> - Integrate AKASHI Takahiro's feedback from v3
>>> - Reword the help text on CMD_BOOTEFI_BOOTMGR slightly
>>> ---
>>>    cmd/Kconfig             | 11 ++++++++++-
>>>    lib/efi_loader/Kconfig  |  6 +++---
>>>    lib/efi_loader/Makefile |  2 +-
>>>    3 files changed, 14 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/cmd/Kconfig b/cmd/Kconfig
>>> index 16e5cb8f0633..872cb49150cc 100644
>>> --- a/cmd/Kconfig
>>> +++ b/cmd/Kconfig
>>> @@ -379,6 +379,15 @@ config CMD_BOOTEFI
>>>    	help
>>>    	  Boot an EFI image from memory.
>>> +config CMD_BOOTEFI_BOOTMGR
>>> +	bool "UEFI Boot Manager command"
>>> +	depends on BOOTEFI_BOOTMGR && CMD_BOOTEFI
>>> +	default y
>>> +	help
>>> +	  Select this option to enable the 'bootmgr' subcommand of 'bootefi'.
>>> +	  This subcommand will allow you to select the UEFI binary to be booted
>>> +	  via UEFI variables Boot####, BootOrder, and BootNext.
>>> +
>>>    config CMD_BOOTEFI_HELLO_COMPILE
>>>    	bool "Compile a standard EFI hello world binary for testing"
>>>    	depends on CMD_BOOTEFI && !CPU_V7M
>>> @@ -2110,7 +2119,7 @@ config CMD_EFIDEBUG
>>>    config CMD_EFICONFIG
>>>    	bool "eficonfig - provide menu-driven uefi variables maintenance interface"
>>>    	default y if !HAS_BOARD_SIZE_LIMIT
>>> -	depends on CMD_BOOTEFI_BOOTMGR
>>> +	depends on BOOTEFI_BOOTMGR
>>>    	select MENU
>>>    	help
>>>    	  Enable the 'eficonfig' command which provides the menu-driven UEFI
>>> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
>>> index d20aaab6dba4..13cad6342c36 100644
>>> --- a/lib/efi_loader/Kconfig
>>> +++ b/lib/efi_loader/Kconfig
>>> @@ -32,14 +32,14 @@ config EFI_LOADER
>>>    if EFI_LOADER
>>> -config CMD_BOOTEFI_BOOTMGR
>>> +config BOOTEFI_BOOTMGR
>>>    	bool "UEFI Boot Manager"
>>>    	default y
>>>    	select BOOTMETH_GLOBAL if BOOTSTD
>>>    	help
>>>    	  Select this option if you want to select the UEFI binary to be booted
>>> -	  via UEFI variables Boot####, BootOrder, and BootNext. This enables the
>>> -	  'bootefi bootmgr' command.
>>> +	  via UEFI variables Boot####, BootOrder, and BootNext. You should also
>>> +	  normally enable CMD_BOOTEFI_BOOTMGR so that the command is available.
>>>    choice
>>>    	prompt "Store for non-volatile UEFI variables"
>>> diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
>>> index 8d31fc61c601..0a2cb6e3c476 100644
>>> --- a/lib/efi_loader/Makefile
>>> +++ b/lib/efi_loader/Makefile
>>> @@ -42,7 +42,7 @@ targets += initrddump.o
>>>    endif
>>>    obj-$(CONFIG_CMD_BOOTEFI_HELLO) += helloworld_efi.o
>>> -obj-$(CONFIG_CMD_BOOTEFI_BOOTMGR) += efi_bootmgr.o
>>> +obj-$(CONFIG_BOOTEFI_BOOTMGR) += efi_bootmgr.o
>>>    obj-y += efi_boottime.o
>>>    obj-y += efi_helper.o
>>>    obj-$(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) += efi_capsule.o
>>
>> This patch looks wrong.
>>
>> Symbol CONFIG_CMD_BOOTEFI_BOOTMGR is used in a lot of places where it is not
>> related to the 'bootefi bootmgr' subcommand.
>>
>> I see no benefit in two separate symbols. If you want to rename the symbol,
>> please, replace *all* occurrences:
>>
>> %s/CONFIG_CMD_BOOTEFI_BOOTMGR/CONFIG_BOOTEFI_BOOTMGR/
> 
> Yes, there's work on the EFI_LOADER side of things to support the use
> case of "boot to menu" (or, "boot to efi bootmgr") of which this is the
> starting point. The follow-up work that I'm hoping you or someone else
> with more EFI_LOADER experience will pick up is splitting cmd/bootefi.c
> such that we can call in to starting an EFI payload (or bootmgr) without
> the command line.
> 

Even after factoring out the boot functionality I would not know why we 
should have two separate symbols. I am fine with a rename which makes it 
clear that this symbol is about a library functionality.

Best regards

Heinrich
