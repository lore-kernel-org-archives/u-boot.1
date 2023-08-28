Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1821BC71153
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 18:29:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3586486487;
	Mon, 28 Aug 2023 20:29:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oU+uy7ax";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 383028648C; Mon, 28 Aug 2023 20:29:05 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 642818647D
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 20:29:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alpernebiyasak@gmail.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-31c8a710545so1816608f8f.3
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 11:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693247341; x=1693852141;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=N85Pv3k4HvRAifuMvFRa25ZrRULMipKGAsJ8jV97ZxY=;
 b=oU+uy7ax1AvCK9wtK35g2lUhTeJQUkywAeH1B7nBOrtI4vGRG4an5PvBpRO3lGINKs
 HiVZKlPu+skbyfguj5ZYN2fDThgx0RNw5UzCkYgUv5ML2j7+2B/PaTRq09Cta+S23/Hd
 xAPB3YlhrhrqQu5r9YuhcVsp4+Q071nbwUR+qid75vKMvtYRvF2EEoYf8SOHJHNtD9Zq
 ZtW8wy0unUsqhVugbbC8e8gxMoe9mR7zuCy33xFwdFW1ENQS8N92rEOg8VZ4NAq0IZow
 ZsAmNi3RfcuzXkR7bsd7TDGtX50mhZBqNXORwgZOycFTXbAw8bd1FIsekCsNX5kLzKxQ
 I7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693247341; x=1693852141;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N85Pv3k4HvRAifuMvFRa25ZrRULMipKGAsJ8jV97ZxY=;
 b=lfnic/UKyvUfReifh8JCB9PjUShqGTObHTsQGQsfPuVQxEpyYFrn/cUaPzdpd007FD
 aDWBUxvufMmbvjISLTLb8PCcE0uKGUIHk3+AO4zKaD0C3Hw8EZRtBNRieVM7kw+f66fj
 S/DvK34FIw+efD2HmhnHX6qODu/MfaCs3C6HrNMgnbmAwhj+jnk0jMQWRjuqQyO6ZCd+
 YYlqhkFTleO1WJBgemDKsooUT4k5DjBbYcPLof/4Xdq2ua8d1HiPLYefs23ZwT6n39+3
 ULzjEZZdzw2rO0+cAu/AjDFURIxx99M8IJGLhtEpONBKJzXG7sG4O0NNjl50HYa0foht
 eU5w==
X-Gm-Message-State: AOJu0YxZfCZr2KTd2fj7YcEZ8XMmByrXlEXl0ywRhF47ZtVANjdHn7WJ
 /G3+eoJAmWqNOp/DEq9xccg=
X-Google-Smtp-Source: AGHT+IESs8fm0DNnuOY9jFESd4h113n56VTqdMO5lrYbcyl9dMeBCEj3uP88T5s8UNUgrVnEP+V80g==
X-Received: by 2002:a5d:65c5:0:b0:319:76a2:36e9 with SMTP id
 e5-20020a5d65c5000000b0031976a236e9mr19597350wrw.56.1693247340574; 
 Mon, 28 Aug 2023 11:29:00 -0700 (PDT)
Received: from [192.168.0.84] ([178.233.24.1])
 by smtp.gmail.com with ESMTPSA id
 n5-20020a5d4205000000b00317ddccb0d1sm11250052wrq.24.2023.08.28.11.28.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Aug 2023 11:29:00 -0700 (PDT)
Message-ID: <3ff5dcb5-27f6-4529-a186-b16130d4249e@gmail.com>
Date: Mon, 28 Aug 2023 21:28:58 +0300
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
 <b32aa9eb-d355-4ff5-8f6d-0b1701da8a0c@gmail.com>
 <CAPnjgZ33DwdxrW7ys9n8DRMnbpKdzqunEozOFf-5LKpnhh3bZA@mail.gmail.com>
From: Alper Nebi Yasak <alpernebiyasak@gmail.com>
In-Reply-To: <CAPnjgZ33DwdxrW7ys9n8DRMnbpKdzqunEozOFf-5LKpnhh3bZA@mail.gmail.com>
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

On 2023-08-28 20:54 +03:00, Simon Glass wrote:
> Hi Alper,
> On Mon, 28 Aug 2023 at 09:46, Alper Nebi Yasak <alpernebiyasak@gmail.com> wrote:
>>
>> On 2023-08-22 21:56 +03:00, Simon Glass wrote:
>>> Hi Alper,
>>>
>>> On Tue, 22 Aug 2023 at 06:10, Alper Nebi Yasak <alpernebiyasak@gmail.com> wrote:
>>>>
>>>> From: Alexander Graf <agraf@csgraf.de>
>>>>
>>>> Now that we have everything in place to support ramfb, let's wire it up
>>>> by default in the ARM QEMU targets. That way, you can easily use a
>>>> graphical console by just passing -device ramfb to the QEMU command line.
>>>>
>>>> Signed-off-by: Alexander Graf <agraf@csgraf.de>
>>>> [Alper: Rebase on bochs changes, add pre-reloc init, error handling]
>>>> Co-developed-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
>>>> Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
>>>> ---
>>>>
>>>> Changes in v2:
>>>> - Rebase on "qemu: arm: Enable Bochs, console buffering, USB keyboard"
>>>> - Drop env changes from ARM (necessary but in prerequisite series)
>>>> - Drop imply VIDEO, SYS_CONSOLE_IN_ENV changes from ARM (in prereq.)
>>>> - Probe QFW in ARM QEMU board_early_init_f to bind ramfb pre-reloc
>>>> - Add IS_ENABLED(CONFIG_QFW) check and error handling to ARM QEMU
>>>>
>>>>  arch/arm/Kconfig                    |  3 +++
>>>>  board/emulation/qemu-arm/qemu-arm.c | 41 +++++++++++++++++++++++++++++
>>>>  2 files changed, 44 insertions(+)
>>>>
>>>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>>>> index 1fd3ccd1607f..7afe26ac804f 100644
>>>> --- a/arch/arm/Kconfig
>>>> +++ b/arch/arm/Kconfig
>>>> @@ -1046,6 +1046,9 @@ config ARCH_QEMU
>>>>         imply USB_XHCI_PCI
>>>>         imply USB_KEYBOARD
>>>>         imply CMD_USB
>>>> +       imply VIDEO_RAMFB
>>>> +       imply BOARD_EARLY_INIT_F
>>>> +       imply BOARD_EARLY_INIT_R
>>>>
>>>>  config ARCH_RMOBILE
>>>>         bool "Renesas ARM SoCs"
>>>> diff --git a/board/emulation/qemu-arm/qemu-arm.c b/board/emulation/qemu-arm/qemu-arm.c
>>>> index 942f1fff5717..23ef31cb7feb 100644
>>>> --- a/board/emulation/qemu-arm/qemu-arm.c
>>>> +++ b/board/emulation/qemu-arm/qemu-arm.c
>>>> @@ -11,6 +11,7 @@
>>>>  #include <fdtdec.h>
>>>>  #include <init.h>
>>>>  #include <log.h>
>>>> +#include <qfw.h>
>>>>  #include <usb.h>
>>>>  #include <virtio_types.h>
>>>>  #include <virtio.h>
>>>> @@ -102,6 +103,46 @@ static struct mm_region qemu_arm64_mem_map[] = {
>>>>  struct mm_region *mem_map = qemu_arm64_mem_map;
>>>>  #endif
>>>>
>>>> +int board_early_init_f(void)
>>>> +{
>>>> +       struct udevice *dev;
>>>> +       int ret;
>>>> +
>>>> +       /*
>>>> +        * Make sure we enumerate the QEMU Firmware device to bind ramfb
>>>> +        * so video_reserve() can reserve memory for it.
>>>> +        */
>>>> +       if (IS_ENABLED(CONFIG_QFW)) {
>>>> +               ret = qfw_get_dev(&dev);
>>>> +               if (ret) {
>>>> +                       log_err("Failed to get QEMU FW device: %d\n", ret);
>>>
>>> We should only present an error if the device is present but
>>> failed...so if the user doesn't provide the flag, all should be well.
>>
>> I don't understand what you mean by "user doesn't provide the flag". But
>> I assume this should ignore the error (unless what?) so that we can
>> continue to boot. Would that apply for board_early_init_r below as well?
> 
> I thought you said there was a qemu flag to enable ramfb? So add it to
> the DT and then the device can (in its bind routine) decide not to be
> bound by returning -ENODEV

Ah. I'm not used to calling them flags, especially those that have
values as in "-device ramfb". My mind jumped to DM_FLAG_PRE_RELOC /
bootph-some-ram.

But note that what this code tries to probe here is not the ramfb
device, it's the bus/parent of that. If this fails, we can't know if the
user specified "-device ramfb" or not.

Is the parent node's device probed by the time .bind() is called? Or,
can I have it probed by calling qfw_get_dev() (which is just
uclass_first_device_err(UCLASS_QFW, ...))?
