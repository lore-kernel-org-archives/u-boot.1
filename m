Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C50E3C369CB
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 06:42:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1AE880BA8;
	Wed, 23 Apr 2025 08:42:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=koansoftware.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B396380EE5; Wed, 23 Apr 2025 08:42:07 +0200 (CEST)
Received: from mail.koansoftware.com (mail.koansoftware.com [172.104.12.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F47E80AE1
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 08:42:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=koansoftware.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m.salvini@koansoftware.com
Received: from localhost (localhost [127.0.0.1])
 by mail.koansoftware.com (Postfix) with ESMTP id 06714437EB;
 Wed, 23 Apr 2025 08:42:03 +0200 (CEST)
Received: from mail.koansoftware.com ([127.0.0.1])
 by localhost (mail.koansoftware.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EGbJKQCanXaS; Wed, 23 Apr 2025 08:42:01 +0200 (CEST)
Message-ID: <b7770036-4d0a-4dad-bd94-602ddb676779@koansoftware.com>
Date: Wed, 23 Apr 2025 08:41:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Unexpected RPi5 Behavior with Saved U-Boot Environment
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Richard Weinberger <richard@sigma-star.at>,
 U-Boot Mailing List <u-boot@lists.denx.de>, upstream+uboot@sigma-star.at,
 Simon Graber <simon.graber@sigma-star.at>, mbrugger@suse.com
References: <3097333.a1USZiQ7eK@anvil>
 <df93a047-2a97-4028-90b3-510b9c75493c@koansoftware.com>
 <CALeDE9OdFxZe+r29=KHaaE_wT3KOp9AAQy0WbgrNpEb0JYBtLw@mail.gmail.com>
Content-Language: en-US, it
From: Mauro Salvini <m.salvini@koansoftware.com>
In-Reply-To: <CALeDE9OdFxZe+r29=KHaaE_wT3KOp9AAQy0WbgrNpEb0JYBtLw@mail.gmail.com>
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

On 21/04/25 12:15, Peter Robinson wrote:
> Hi Mauro,
> 
>>> We recently started using U-Boot on various Raspberry Pi 5 boards
>>> with different hardware configurations.
>>>
>>> While testing, Simon noticed unusual boot failures, such as the kernel
>>> failing to boot with no output or U-Boot reporting:
>>> "ERROR: Did not find a cmdline Flattened Device Tree."
>>>
>>> Today, I spent time investigating these issues. It appears that U-Boot
>>> retrieves several variables from the Raspberry Pi firmware, with fdt_addr
>>> being particularly important.
>>> If the environment is saved, fdt_addr gets stored and takes precedence
>>> over what the firmware provides to U-Boot.
>>>
>>> Interestingly, the RPi firmware seems to modify fdt_addr based on connected
>>> hardware.  Our experiments showed that even attaching an RPi camera module
>>> changes the computed fdt_addr and U-Boot reads from the wrong memory location.
>>>
>>> As a result, saving the environment, whether via the saveenv command in U-Boot
>>> or fw_setenv in Linux, can lead to boot failures if the hardware configuration changes.
>>>
>>> Do you have any suggestions for mitigating this issue?
>>> In my opinion, U-Boot should not override such critical variables.
>>>
>>> Thanks,
>>> //richard
>>>
>>
>> Hi Richard,
>>
>> could be related tho this [1]?
>>
>> I sent this patch some years ago but was never accepted in u-boot tree.
>> But meta-rpi uses it in u-boot recipe [2].
> 
> After digging into this and a discussion with Tom we decided this is
> the correct fix so I've pulled that patch in for 2025.07.
> 
> Thanks,
> Peter
> 

Hi Peter,

thank you.

Regards

Mauro

>> Regards
>>
>> [1] https://lists.denx.de/pipermail/u-boot/2021-May/449609.html
>> [2]
>> https://github.com/agherzan/meta-raspberrypi/blob/master/recipes-bsp/u-boot/files/0001-rpi-always-set-fdt_addr-with-firmware-provided-FDT-address.patch
>>
>> --
>> Mauro
> 
