Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57982E77188
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 06:47:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3E02801E8;
	Mon,  6 Jan 2025 07:47:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Carxm86k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE383801E8; Mon,  6 Jan 2025 07:47:03 +0100 (CET)
Received: from mail-m11867.qiye.163.com (mail-m11867.qiye.163.com
 [115.236.118.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CFD9801DE
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 07:46:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 7cf293eb;
 Mon, 6 Jan 2025 14:46:54 +0800 (GMT+08:00)
Message-ID: <3a7f8b43-288c-4951-a781-c9d7139bab2a@rock-chips.com>
Date: Mon, 6 Jan 2025 14:46:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] config: efi-x86_payload: Enable DEBUG_UART
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20241128114737.1.I9eac706713ffc05dccc51ad3d60833a179c9e83d@changeid>
 <20241128114737.2.I03b59e1d26d2a79a666adc8ef313077da8dce145@changeid>
 <c31b3d7a-c840-4b3d-a6fe-90f9a576ffb4@gmx.de>
 <CAFLszTikmQfBsQTJ5FLfvOv2GgPWPj0GyDCoCxYnXVtbruvf-A@mail.gmail.com>
 <3EE77A40-CD92-4330-B66D-7F00CCEA7BE4@gmx.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <3EE77A40-CD92-4330-B66D-7F00CCEA7BE4@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkNDSlYYT0xOH0JCGkNCHh5WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpOTE
 pVSktLVUpCS0tZBg++
X-HM-Tid: 0a943a5dd00203afkunm7cf293eb
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OlE6TDo6KTIOPRgRDSM1KC4M
 HxUKCzVVSlVKTEhNSk9NS0pOSk9KVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFOS05KNwY+
DKIM-Signature: a=rsa-sha256;
 b=Carxm86kbc/YEvhTBh3bpwFDyHS0sUbBmmrIyxwamALN9XN48xOl/c6CjCQ0DIW9kB0UrnhQJwQF7sXwnaEx1O7qcgeJ3Pf/j6UfP8hfrb1/i1B/7T6rdcFYkemvgk1BDmpafl8w1IK08er6FcP69kKxfcGy1BvC74ZqFAdbxKM=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=f0z829gV2BPzYXmiENt3veZEY6O32ry5O7tjtQNcJng=;
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

Hi Heinrich and Simon,

     I send these two change because I want to fix the build error 
below(from[1]) which is for disable the DEBUG_UART[2].
Do you have clear suggestion on how to do this in efi_stub, since I have 
no idea about this module, so I just follow how
it works in other serial driver.
+/binman/rom/intel-mrc (mrc.bin):
+Image 'rom' has faked external blobs and is non-functional: 
descriptor.bin me.bin refcode.bin vga.bin mrc.bin
+In file included from lib/efi/efi_stub.c:12:
+include/debug_uart.h:205:9: error: stray '#' in program
+  205 |         #warning "DEBUG_UART not defined!"
+      |         ^
+lib/efi/efi_stub.c:91:1: note: in expansion of macro 'DEBUG_UART_FUNCS'
+   91 | DEBUG_UART_FUNCS
+      | ^~~~~~~~~~~~~~~~
+include/debug_uart.h:205:18: error: expected '=', ',', ';', 'asm' or 
'__attribute__' before string constant
+      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~
+lib/efi/efi_stub.c:86:13: error: '_debug_uart_putc' defined but not 
used [-Werror=unused-function]
+   86 | static void _debug_uart_putc(int ch)
+      |             ^~~~~~~~~~~~~~~~
+make[3]: *** [scripts/Makefile.build:257: lib/efi/efi_stub.o] Error 1
+make[2]: *** [scripts/Makefile.build:398: lib/efi] Error 2

Thanks,
- Kever
[1] https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/jobs/987462
[2] 
https://patchwork.ozlabs.org/project/uboot/patch/20240918130155.299353-2-lukasz.czechowski@thaumatec.com/ 

On 2025/1/5 07:02, Heinrich Schuchardt wrote:
> Am 4. Januar 2025 20:29:43 MEZ schrieb Simon Glass <sjg@chromium.org>:
>> Hi Heinrich,
>>
>> On Sat, 4 Jan 2025 at 05:16, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>>> On 28.11.24 04:47, Kever Yang wrote:
>>>> The efi_stub is useing DEBUG_UART interface by default, Enable it.
>>> As Simon already wrote in a code comment the implementation of the EFI
>>> stub is broken as it is not hardware agnostic.
>> If I said that I was wrong, sorry. Actually that is the stub's intent,
>> to take over the machine, exit boot-services and carry on. It is the
>> EFI app which is designed to use boot services.
>>
>> So the stub cannot be hardware-agnostic, unfortunately. It only runs
>> on x86 hardware, unless, for example, EFI has something like
>> serial_getinfo() or we disable the UART / keyboard input.
> I would assume that there is no serial console that the user has access to on many x86 systems (like on my laptop).
>
> In the stub itself we can use the Simple Text Output Protocol and the Simple Text Input Protocol offered by the UEFI implementation that started the stub.
>
> The UEFI specification defines a Serial Io Protocol which may be implemented but I would not know why we should restrict the usability in this way.
>
> Once we start U-Boot of course we will use hardware specific IO, e.g. on a RISC-V system use the debug console offered by the SBI
>
> Best regards
>
> Heinrich
>
>>> In the EFI stub we should never directly access hardware. Please, use
>>> SimpleTextOutputProtocol.OutputString() for printing.
>> Once the stub starts, boot services are gone. See efi_main() for how
>> this works. There is a definite point at which we stop using that and
>> start using U-Boot's own thing.
>>
>> At this point I think I may be misunderstanding what you said...
>>
>>>> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
>>>> ---
>>>>
>>>>    configs/efi-x86_payload32_defconfig | 1 +
>>>>    configs/efi-x86_payload64_defconfig | 1 +
>>>>    2 files changed, 2 insertions(+)
>>>>
>>>> diff --git a/configs/efi-x86_payload32_defconfig b/configs/efi-x86_payload32_defconfig
>>>> index 071ddb8e36d..f0b9acc358d 100644
>>>> --- a/configs/efi-x86_payload32_defconfig
>>>> +++ b/configs/efi-x86_payload32_defconfig
>>>> @@ -5,6 +5,7 @@ CONFIG_DEFAULT_DEVICE_TREE="efi-x86_payload"
>>>>    CONFIG_PRE_CON_BUF_ADDR=0x100000
>>>>    CONFIG_VENDOR_EFI=y
>>>>    CONFIG_TARGET_EFI_PAYLOAD=y
>>>> +CONFIG_DEBUG_UART=y
>>> On x86 this uses the NS16550 UART driver. This is fine as long as we
>>> don't use the debug UART in the EFI stub. But correcting this is for a
>>> separate patch.
>>>
>>> Having a debug UART available after the EFI stub makes sense.
>>>
>>> I will update the commit message when merging.
>>>
>>> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>>>
>>>>    CONFIG_EFI=y
>>>>    CONFIG_EFI_STUB=y
>>>>    CONFIG_FIT=y
>>>> diff --git a/configs/efi-x86_payload64_defconfig b/configs/efi-x86_payload64_defconfig
>>>> index 71612d7fb19..b02a861e59c 100644
>>>> --- a/configs/efi-x86_payload64_defconfig
>>>> +++ b/configs/efi-x86_payload64_defconfig
>>>> @@ -5,6 +5,7 @@ CONFIG_DEFAULT_DEVICE_TREE="efi-x86_payload"
>>>>    CONFIG_PRE_CON_BUF_ADDR=0x100000
>>>>    CONFIG_VENDOR_EFI=y
>>>>    CONFIG_TARGET_EFI_PAYLOAD=y
>>>> +CONFIG_DEBUG_UART=y
>>>>    CONFIG_EFI=y
>>>>    CONFIG_EFI_STUB=y
>>>>    CONFIG_EFI_STUB_64BIT=y
>> Regards,
>> Simon
>
