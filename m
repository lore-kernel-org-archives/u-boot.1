Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9000BC71153
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 15:46:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A95F88651E;
	Mon, 28 Aug 2023 17:46:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XkR3x8TP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C24F8651E; Mon, 28 Aug 2023 17:46:17 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DECC786422
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 17:46:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alpernebiyasak@gmail.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-31dd10c2b8bso295683f8f.3
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 08:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693237574; x=1693842374;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K51ait8+QosV7l2kfmRvJNafcTkJg6B52f8YosCYgSY=;
 b=XkR3x8TPgeyowxWnBBFUak2jIrf4FroQDBdCwmxQJAS4fq8Kl3Spa0Ki70d0hKfZEW
 TiVV1TSvmdq6iuxyJ79KMtn+QntpCLNDWHpVY/yiyRUJLArCGRVwrDHjgk2SpD+K/BF4
 nUIQCDRM5+iOrraEw69bzD1tG2HcEJm7sTOQTLPoOd9EBMtvYHWodW4AnNCPa39+DACE
 x0+lOO8f9RFrU3cviWFjT6LxuDNyupEM5SaRKVg5/Tg5V/GOhgXPfGKz3xDu8zWz0N62
 4cdGosBPh3k79O++K64gmlUF5MxRhV8RblGaIhvmOGJ20liE/PicphWFC3aMixGe1ImB
 vAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693237574; x=1693842374;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K51ait8+QosV7l2kfmRvJNafcTkJg6B52f8YosCYgSY=;
 b=GXc9Y871e5MCl4WrX+PR8tLBtn/GeuzJFQ8OYEfrcqBcOBeqiglzBtzT/qbBimsrRA
 p22YAe8vNzAhll9Aw7MOXIuJWeFdr4xzSvUlv6H/5Fy/w8hbtHsVNnWTtqXIwCMdgieU
 tssfuE+6zALk303FrEIuE0XU1MeP4pD87YwLbvKXrhEWTNmKEBLh6y2TS/y+aexnOyiV
 wHRJHnrQNbztGXWv7AiJaa01AHtHTRURFgA8pZJC91bAc6ozzv7cdvKU+rwLrfr0WKbT
 1YQ02fm1RX3X36q+4chcREp75/937EIZ5f4GNLTp12Hrea1osoyWAE3uQLyEQ5+1H3rj
 GeEA==
X-Gm-Message-State: AOJu0YyXdWI9Q50sMUnoypu/No8ReRmI1cUR5a5YbQOxFbj781X5BjSn
 FfPb2bbyWTB3CPAby5fPZYg=
X-Google-Smtp-Source: AGHT+IFAB66wkjN33KHsUT+JSVOuwiCtYgHhCUtuYNkEtYSSJd7/djqN//s/LIqI5siNlkcmY+Yrew==
X-Received: by 2002:a05:6000:1081:b0:319:72f8:7249 with SMTP id
 y1-20020a056000108100b0031972f87249mr19322926wrw.66.1693237574143; 
 Mon, 28 Aug 2023 08:46:14 -0700 (PDT)
Received: from [192.168.0.84] ([178.233.24.1])
 by smtp.gmail.com with ESMTPSA id
 k4-20020a05600c0b4400b003fe0a0e03fcsm14222354wmr.12.2023.08.28.08.46.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Aug 2023 08:46:13 -0700 (PDT)
Message-ID: <b32aa9eb-d355-4ff5-8f6d-0b1701da8a0c@gmail.com>
Date: Mon, 28 Aug 2023 18:46:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] arm: qemu: Enable ramfb by default
Content-Language: en-US, tr, en-GB
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, Asherah Connor <ashe@kivikakk.ee>,
 Alexander Graf <agraf@csgraf.de>, Mark Kettenis <mark.kettenis@xs4all.nl>
References: <20230822121026.1007105-1-alpernebiyasak@gmail.com>
 <20230822121026.1007105-6-alpernebiyasak@gmail.com>
 <CAPnjgZ0hj+0kFYtTUTQAQpDN9rgt-F8jHm_boeve6SLMeOV1Ww@mail.gmail.com>
From: Alper Nebi Yasak <alpernebiyasak@gmail.com>
In-Reply-To: <CAPnjgZ0hj+0kFYtTUTQAQpDN9rgt-F8jHm_boeve6SLMeOV1Ww@mail.gmail.com>
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
>> From: Alexander Graf <agraf@csgraf.de>
>>
>> Now that we have everything in place to support ramfb, let's wire it up
>> by default in the ARM QEMU targets. That way, you can easily use a
>> graphical console by just passing -device ramfb to the QEMU command line.
>>
>> Signed-off-by: Alexander Graf <agraf@csgraf.de>
>> [Alper: Rebase on bochs changes, add pre-reloc init, error handling]
>> Co-developed-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
>> Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
>> ---
>>
>> Changes in v2:
>> - Rebase on "qemu: arm: Enable Bochs, console buffering, USB keyboard"
>> - Drop env changes from ARM (necessary but in prerequisite series)
>> - Drop imply VIDEO, SYS_CONSOLE_IN_ENV changes from ARM (in prereq.)
>> - Probe QFW in ARM QEMU board_early_init_f to bind ramfb pre-reloc
>> - Add IS_ENABLED(CONFIG_QFW) check and error handling to ARM QEMU
>>
>>  arch/arm/Kconfig                    |  3 +++
>>  board/emulation/qemu-arm/qemu-arm.c | 41 +++++++++++++++++++++++++++++
>>  2 files changed, 44 insertions(+)
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index 1fd3ccd1607f..7afe26ac804f 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -1046,6 +1046,9 @@ config ARCH_QEMU
>>         imply USB_XHCI_PCI
>>         imply USB_KEYBOARD
>>         imply CMD_USB
>> +       imply VIDEO_RAMFB
>> +       imply BOARD_EARLY_INIT_F
>> +       imply BOARD_EARLY_INIT_R
>>
>>  config ARCH_RMOBILE
>>         bool "Renesas ARM SoCs"
>> diff --git a/board/emulation/qemu-arm/qemu-arm.c b/board/emulation/qemu-arm/qemu-arm.c
>> index 942f1fff5717..23ef31cb7feb 100644
>> --- a/board/emulation/qemu-arm/qemu-arm.c
>> +++ b/board/emulation/qemu-arm/qemu-arm.c
>> @@ -11,6 +11,7 @@
>>  #include <fdtdec.h>
>>  #include <init.h>
>>  #include <log.h>
>> +#include <qfw.h>
>>  #include <usb.h>
>>  #include <virtio_types.h>
>>  #include <virtio.h>
>> @@ -102,6 +103,46 @@ static struct mm_region qemu_arm64_mem_map[] = {
>>  struct mm_region *mem_map = qemu_arm64_mem_map;
>>  #endif
>>
>> +int board_early_init_f(void)
>> +{
>> +       struct udevice *dev;
>> +       int ret;
>> +
>> +       /*
>> +        * Make sure we enumerate the QEMU Firmware device to bind ramfb
>> +        * so video_reserve() can reserve memory for it.
>> +        */
>> +       if (IS_ENABLED(CONFIG_QFW)) {
>> +               ret = qfw_get_dev(&dev);
>> +               if (ret) {
>> +                       log_err("Failed to get QEMU FW device: %d\n", ret);
> 
> We should only present an error if the device is present but
> failed...so if the user doesn't provide the flag, all should be well.

I don't understand what you mean by "user doesn't provide the flag". But
I assume this should ignore the error (unless what?) so that we can
continue to boot. Would that apply for board_early_init_r below as well?

>> +                       return ret;
>> +               }
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +int board_early_init_r(void)
>> +{
>> +       struct udevice *dev;
>> +       int ret;
>> +
>> +       /*
>> +        * Make sure we enumerate the QEMU Firmware device to find ramfb
>> +        * before console_init.
>> +        */
>> +       if (IS_ENABLED(CONFIG_QFW)) {
>> +               ret = qfw_get_dev(&dev);
>> +               if (ret) {
>> +                       log_err("Failed to get QEMU FW device: %d\n", ret);
>> +                       return ret;
>> +               }
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>>  int board_init(void)
>>  {
>>         return 0;
>> --
>> 2.40.1
>>
> 
> The glue here feels like a bit of a hack...we should rely on normal DT
> mechanisms here.
> 
> Regards,
> Simon
