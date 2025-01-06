Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 699E5E77197
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 03:33:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E0FA801E8;
	Mon,  6 Jan 2025 04:33:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="GpbrlLu8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C08C6803DC; Mon,  6 Jan 2025 04:33:46 +0100 (CET)
Received: from mail-m19731118.qiye.163.com (mail-m19731118.qiye.163.com
 [220.197.31.118])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD7AD801DE
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 04:33:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 7c9a9f56;
 Mon, 6 Jan 2025 11:33:38 +0800 (GMT+08:00)
Message-ID: <ffd2be2e-02d1-4b79-97fe-2097bb7464b0@rock-chips.com>
Date: Mon, 6 Jan 2025 11:33:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] efi_stub: Sync the debug UART definition like other
 platform
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20241128114737.1.I9eac706713ffc05dccc51ad3d60833a179c9e83d@changeid>
 <bd3b49c9-55b0-4707-baf9-ae6bb97e2d01@gmx.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <bd3b49c9-55b0-4707-baf9-ae6bb97e2d01@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh1LGlZKThpCSUNDQk5DGRlWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
 JVSktLVUpCS0tZBg++
X-HM-Tid: 0a9439acdf4603afkunm7c9a9f56
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NCo6Pzo5MDIVVhgxKD0wLjMa
 EjYwFEtVSlVKTEhNSkhPT0pCSUNLVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJTExLNwY+
DKIM-Signature: a=rsa-sha256;
 b=GpbrlLu8iJunTZTL22xvhZrY1BHCKg4oUmE8qQfWzRXi0pQ2+2zJn6sCOkX/UpdiyxV2j3OuBhtg3MK2S8YIGENux74dLXhg5OYCaBizJD9HKvua+B4TwwIsnoc6SEmnkkTNsaaZiMIpHPc0CRAatV6Nf/ozQgrAmfaaf+jdU7s=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=ZH6h1POA8vwhMY+INgV3uXcOkMtG5TUIh1fKvu4XO/w=;
 h=date:mime-version:subject:message-id:from;
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

Hi Heinrich,

On 2025/1/3 23:43, Heinrich Schuchardt wrote:
> On 28.11.24 04:47, Kever Yang wrote:
>> The debug UART interface is available when CONFIG_DEBUG_UART is defined,
>> sync with the other platforms to use the same definition.
>>
>> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
>> ---
>>
>>   lib/efi/efi_stub.c | 16 ++++++++++------
>>   1 file changed, 10 insertions(+), 6 deletions(-)
>>
>> diff --git a/lib/efi/efi_stub.c b/lib/efi/efi_stub.c
>> index 40fc29d9adf..5179c5b2c09 100644
>> --- a/lib/efi/efi_stub.c
>> +++ b/lib/efi/efi_stub.c
>> @@ -9,7 +9,6 @@
>>    * EFI application. It can be built either in 32-bit or 64-bit mode.
>>    */
>>
>> -#include <debug_uart.h>
>>   #include <efi.h>
>>   #include <efi_api.h>
>>   #include <errno.h>
>> @@ -55,10 +54,6 @@ struct __packed desctab_info {
>>    * considering if we start needing more U-Boot functionality. Note 
>> that we
>>    * could then move get_codeseg32() to arch/x86/cpu/cpu.c.
>>    */
>> -void _debug_uart_init(void)
>> -{
>> -}
>> -
>>   void putc(const char ch)
>>   {
>>       struct efi_priv *priv = efi_get_priv();
>> @@ -83,12 +78,21 @@ void puts(const char *str)
>>           putc(*str++);
>>   }
>>
>> -static void _debug_uart_putc(int ch)
>> +#ifdef CONFIG_DEBUG_UART
>
> Why do we need this #ifdef? In other places we leave it to the linker to
> remove unused functions.

I think you are right for most of modules, but for this DEBUG_UART, it's 
a little different

because it's for early debug, and not so stand alone to disable.

And now we are try to make it clean and able to disable, see patch[1].

>
>> +
>> +#include <debug_uart.h>
>
> You cannot consume function _debug_uart_putc() before defining it.
>
This is following what all other serial driver have done.

And I think put all the code support for DEBUG_UART together is reasonable.

This efi_stub is a little bit different and cause the DEBUG_UART not 
able to disable, that's

why I'm doing this "sync" commit.


Thanks,

- Kever

[1] 
https://patchwork.ozlabs.org/project/uboot/patch/20240918130155.299353-2-lukasz.czechowski@thaumatec.com/

> So either the #include statement must follow the implementations or you
> have to define the function prototypes in the include.
>
> I would prefer adding the missing definitions to the include and leaving
> it at the top of the code.
>
> Best regards
>
> Heinrich
>
>> +
>> +void _debug_uart_init(void)
>> +{
>> +}
>> +
>> +static inline void _debug_uart_putc(int ch)
>>   {
>>       putc(ch);
>>   }
>>
>>   DEBUG_UART_FUNCS
>> +#endif
>>
>>   void *memcpy(void *dest, const void *src, size_t size)
>>   {
>
>
