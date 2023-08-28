Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85CBFC83F12
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 15:40:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A6878643E;
	Mon, 28 Aug 2023 17:40:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Up1Xivu/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94C15846B8; Mon, 28 Aug 2023 17:40:16 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FB268643E
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 17:40:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alpernebiyasak@gmail.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-31aeee69de0so2846952f8f.2
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 08:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693237213; x=1693842013;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QN94Nw+5/AJbf72B7Ubuju28FM1C/m+Izst2OcuT8+A=;
 b=Up1Xivu/SNuwagv8ft0j+aSH8FcTRo22Fk/10bpex9V7iR2xhnUh6Ew486+qmk5X0s
 Ft3q6lZlx8TT+lE5qNIbgEkuswDVVSvnKdQIJz4F56sePwBo4od9yykrJ1oVcoliogTe
 yUTcIuKNtGXelygnuM1QIOS0XDjnXYq50PGPdH5X4IBYNVJr61mqoiuZW+Et4qSO/v80
 6n6KM0rkxFDQD2RWr4JFAhi80OGrsyepzUUBNPil7bfoZNBy8eAkVS+cPybf6vKVvjT7
 HQUb35HJ6ScqJz8YJslijhLHtl8HPqu35TSNxFDV5eEpw58lVMs6sRfwe9o580O+08o1
 xzxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693237213; x=1693842013;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QN94Nw+5/AJbf72B7Ubuju28FM1C/m+Izst2OcuT8+A=;
 b=USXaJQtnFvtG511lTtusErFtNET9T2xSfjwcVSlXTOxy7c4m53hZDnMOuaVIiACQ6D
 PCAUhB4s5sp5Df0ydXqPJxFVyknC23B+HejTxzEfZa0UkNVTpSSbCu301gMcT3HqnxkY
 E+BTF+vujLQ5WYSUme6Rur4LkQ2K6dxIAqBIKOvnq7pfcr2xoWTS4//WHKJt9/BKjbx8
 FkLVfW2lRYDdkIbjONw2KO4y572tnh3OmEtc+I5RmkdTN+YFwJLJFi7OCrC37qTo7fLj
 Pw3ffMK13Lu7X5sxC3YukO3BUhWwEedWwHK1BT0vrDNpGN3KclTysA6/d6ilP+syOMvx
 U9sw==
X-Gm-Message-State: AOJu0YyKDqKn+jfptFkiL1U9yyhuxOfNYb4X4yGh6ZReVJLi5YA00AEv
 5zBI5foPQQRnUEShESMUfCs=
X-Google-Smtp-Source: AGHT+IEC2hTVXaAKWpQzf5FuJHGyIVhUoTPO0rVeCHRRvQmmPH6euSJrXETakXQpqoEU5e03gAUE0A==
X-Received: by 2002:a5d:630e:0:b0:314:1ca4:dbd9 with SMTP id
 i14-20020a5d630e000000b003141ca4dbd9mr18868442wru.27.1693237212718; 
 Mon, 28 Aug 2023 08:40:12 -0700 (PDT)
Received: from [192.168.0.84] ([178.233.24.1])
 by smtp.gmail.com with ESMTPSA id
 l13-20020a5d4bcd000000b003141e629cb6sm10779604wrt.101.2023.08.28.08.40.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Aug 2023 08:40:12 -0700 (PDT)
Message-ID: <69354e85-2c73-4623-b286-e4820aef494b@gmail.com>
Date: Mon, 28 Aug 2023 18:40:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] x86: qemu: Enable ramfb by default
Content-Language: en-US, tr, en-GB
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, Asherah Connor <ashe@kivikakk.ee>,
 Alexander Graf <agraf@csgraf.de>, Mark Kettenis <mark.kettenis@xs4all.nl>
References: <20230822121026.1007105-1-alpernebiyasak@gmail.com>
 <20230822121026.1007105-8-alpernebiyasak@gmail.com>
 <CAPnjgZ36NmL0jkHaRyeCSQQm78bDaYwei84WVLt32-ZX0M_J1w@mail.gmail.com>
From: Alper Nebi Yasak <alpernebiyasak@gmail.com>
In-Reply-To: <CAPnjgZ36NmL0jkHaRyeCSQQm78bDaYwei84WVLt32-ZX0M_J1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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

On 2023-08-22 21:56 +03:00, Simon Glass wrote:
> Hi Alper,
> 
> On Tue, 22 Aug 2023 at 06:10, Alper Nebi Yasak <alpernebiyasak@gmail.com> wrote:
>>
>> Now that we have everything in place to support ramfb, let's wire it up
>> by default in the x86 QEMU targets. That way, we can use ramfb graphical
>> console instead of the default by passing -vga none -device ramfb to the
>> QEMU command line.
>>
>> Also increase SYS_MALLOC_F_LEN for QEMU x86_64 to be the same as its SPL
>> counterpart, because we're running out of alloc space in pre-reloc stage
>> with ramfb enabled.
>>
>> Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
>> ---
>> This also suffers from the same issue with distros as the Bochs display
>> driver [1], where it results in a hang after GRUB menu selection before
>> the kernel can display anything. Couldn't reproduce on arm*/riscv*.
> 
> Yes I see that problem too. I wonder how we can debug it?

No idea, and I couldn't find a good commit to bisect from, tried as far
back as v2021.10.

>> But just having it enabled doesn't seem to cause problems unless you run
>> QEMU with -device ramfb, so this (unlike the Bochs video driver) can
>> actually be co-enabled with VIDEO_VESA.
> 
> Indeed...which makes me wonder if we can do something similar with
> Bochs, so that (from the cmdline) it is possible to chose ramfb, bochs
> or vesa?

(Tried to answer video choice and DT concerns in another mail)

>> [1] https://lore.kernel.org/u-boot/20230724145210.304917-4-sjg@chromium.org/
>>
>> Changes in v2:
>> - Add patch "x86: qemu: Enable ramfb by default"
>>
>>  arch/x86/cpu/qemu/Kconfig           |  4 +++
>>  board/emulation/qemu-x86/qemu-x86.c | 47 +++++++++++++++++++++++++++++
>>  configs/qemu-x86_64_defconfig       |  4 +--
>>  configs/qemu-x86_defconfig          |  1 -
>>  4 files changed, 52 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/x86/cpu/qemu/Kconfig b/arch/x86/cpu/qemu/Kconfig
>> index f8f2f6473088..e0a57ac2d687 100644
>> --- a/arch/x86/cpu/qemu/Kconfig
>> +++ b/arch/x86/cpu/qemu/Kconfig
>> @@ -13,6 +13,10 @@ config QEMU
>>         imply USB
>>         imply USB_EHCI_HCD
>>         imply VIDEO_VESA
>> +       imply VIDEO_RAMFB
>> +       imply BOARD_EARLY_INIT_F
>> +       imply BOARD_EARLY_INIT_R
>> +       imply CMD_QFW
>>
>>  if QEMU
>>
>> [...]
>> 
>> @@ -59,7 +58,6 @@ CONFIG_CMD_USB=y
>>  CONFIG_BOOTP_BOOTFILESIZE=y
>>  CONFIG_CMD_EFIDEBUG=y
>>  CONFIG_CMD_TIME=y
>> -CONFIG_CMD_QFW=y
> 
> What is happening here? Why disable it?

I used `imply CMD_QFW` above to be consistent with previous patches, so
it's no longer necessary in defconfigs. Should I drop the imply and keep
these in defconfig?
