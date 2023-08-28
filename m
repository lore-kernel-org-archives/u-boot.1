Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B2BC71153
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 20:32:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C0A28645F;
	Mon, 28 Aug 2023 22:32:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=csgraf.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D8A6805C9; Mon, 28 Aug 2023 22:32:35 +0200 (CEST)
Received: from zulu616.server4you.de (mail.csgraf.de [85.25.223.15])
 by phobos.denx.de (Postfix) with ESMTP id 80E9C8645F
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 22:32:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=csgraf.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=agraf@csgraf.de
Received: from [0.0.0.0] (ec2-3-122-114-9.eu-central-1.compute.amazonaws.com
 [3.122.114.9]) by csgraf.de (Postfix) with ESMTPSA id 0AD2160801EC;
 Mon, 28 Aug 2023 22:32:30 +0200 (CEST)
Message-ID: <9cd28ea5-3a5d-4500-a94c-d6f0dae3031a@csgraf.de>
Date: Mon, 28 Aug 2023 22:32:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] arm: qemu: Enable ramfb by default
Content-Language: en-GB
To: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, Asherah Connor <ashe@kivikakk.ee>,
 Mark Kettenis <mark.kettenis@xs4all.nl>
References: <20230822121026.1007105-1-alpernebiyasak@gmail.com>
 <20230822121026.1007105-6-alpernebiyasak@gmail.com>
 <CAPnjgZ0hj+0kFYtTUTQAQpDN9rgt-F8jHm_boeve6SLMeOV1Ww@mail.gmail.com>
 <b32aa9eb-d355-4ff5-8f6d-0b1701da8a0c@gmail.com>
 <CAPnjgZ33DwdxrW7ys9n8DRMnbpKdzqunEozOFf-5LKpnhh3bZA@mail.gmail.com>
 <3ff5dcb5-27f6-4529-a186-b16130d4249e@gmail.com>
From: Alexander Graf <agraf@csgraf.de>
In-Reply-To: <3ff5dcb5-27f6-4529-a186-b16130d4249e@gmail.com>
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


On 28.08.23 20:28, Alper Nebi Yasak wrote:
> On 2023-08-28 20:54 +03:00, Simon Glass wrote:
>> Hi Alper,
>> On Mon, 28 Aug 2023 at 09:46, Alper Nebi Yasak <alpernebiyasak@gmail.com> wrote:
>>> On 2023-08-22 21:56 +03:00, Simon Glass wrote:
>>>> Hi Alper,
>>>>
>>>> On Tue, 22 Aug 2023 at 06:10, Alper Nebi Yasak <alpernebiyasak@gmail.com> wrote:
>>>>> From: Alexander Graf <agraf@csgraf.de>
>>>>>
>>>>> Now that we have everything in place to support ramfb, let's wire it up
>>>>> by default in the ARM QEMU targets. That way, you can easily use a
>>>>> graphical console by just passing -device ramfb to the QEMU command line.
>>>>>
>>>>> Signed-off-by: Alexander Graf <agraf@csgraf.de>
>>>>> [Alper: Rebase on bochs changes, add pre-reloc init, error handling]
>>>>> Co-developed-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
>>>>> Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
>>>>> ---
>>>>>
>>>>> Changes in v2:
>>>>> - Rebase on "qemu: arm: Enable Bochs, console buffering, USB keyboard"
>>>>> - Drop env changes from ARM (necessary but in prerequisite series)
>>>>> - Drop imply VIDEO, SYS_CONSOLE_IN_ENV changes from ARM (in prereq.)
>>>>> - Probe QFW in ARM QEMU board_early_init_f to bind ramfb pre-reloc
>>>>> - Add IS_ENABLED(CONFIG_QFW) check and error handling to ARM QEMU
>>>>>
>>>>>   arch/arm/Kconfig                    |  3 +++
>>>>>   board/emulation/qemu-arm/qemu-arm.c | 41 +++++++++++++++++++++++++++++
>>>>>   2 files changed, 44 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>>>>> index 1fd3ccd1607f..7afe26ac804f 100644
>>>>> --- a/arch/arm/Kconfig
>>>>> +++ b/arch/arm/Kconfig
>>>>> @@ -1046,6 +1046,9 @@ config ARCH_QEMU
>>>>>          imply USB_XHCI_PCI
>>>>>          imply USB_KEYBOARD
>>>>>          imply CMD_USB
>>>>> +       imply VIDEO_RAMFB
>>>>> +       imply BOARD_EARLY_INIT_F
>>>>> +       imply BOARD_EARLY_INIT_R
>>>>>
>>>>>   config ARCH_RMOBILE
>>>>>          bool "Renesas ARM SoCs"
>>>>> diff --git a/board/emulation/qemu-arm/qemu-arm.c b/board/emulation/qemu-arm/qemu-arm.c
>>>>> index 942f1fff5717..23ef31cb7feb 100644
>>>>> --- a/board/emulation/qemu-arm/qemu-arm.c
>>>>> +++ b/board/emulation/qemu-arm/qemu-arm.c
>>>>> @@ -11,6 +11,7 @@
>>>>>   #include <fdtdec.h>
>>>>>   #include <init.h>
>>>>>   #include <log.h>
>>>>> +#include <qfw.h>
>>>>>   #include <usb.h>
>>>>>   #include <virtio_types.h>
>>>>>   #include <virtio.h>
>>>>> @@ -102,6 +103,46 @@ static struct mm_region qemu_arm64_mem_map[] = {
>>>>>   struct mm_region *mem_map = qemu_arm64_mem_map;
>>>>>   #endif
>>>>>
>>>>> +int board_early_init_f(void)
>>>>> +{
>>>>> +       struct udevice *dev;
>>>>> +       int ret;
>>>>> +
>>>>> +       /*
>>>>> +        * Make sure we enumerate the QEMU Firmware device to bind ramfb
>>>>> +        * so video_reserve() can reserve memory for it.
>>>>> +        */
>>>>> +       if (IS_ENABLED(CONFIG_QFW)) {
>>>>> +               ret = qfw_get_dev(&dev);
>>>>> +               if (ret) {
>>>>> +                       log_err("Failed to get QEMU FW device: %d\n", ret);
>>>> We should only present an error if the device is present but
>>>> failed...so if the user doesn't provide the flag, all should be well.
>>> I don't understand what you mean by "user doesn't provide the flag". But
>>> I assume this should ignore the error (unless what?) so that we can
>>> continue to boot. Would that apply for board_early_init_r below as well?
>> I thought you said there was a qemu flag to enable ramfb? So add it to
>> the DT and then the device can (in its bind routine) decide not to be
>> bound by returning -ENODEV
> Ah. I'm not used to calling them flags, especially those that have
> values as in "-device ramfb". My mind jumped to DM_FLAG_PRE_RELOC /
> bootph-some-ram.
>
> But note that what this code tries to probe here is not the ramfb
> device, it's the bus/parent of that. If this fails, we can't know if the
> user specified "-device ramfb" or not.


You bring up a great point here. I don't think we should model the 
actual ramfb device as device tree (platform) device. It's 100% 
enumerable from QFW which means we should treat it as a dynamic entity 
that gets created by QFW instead of from device tree, just like USB or 
PCI devices.

And when you do that, everything should fall into place nicely: You 
don't need to dynamically modify device trees on boot, the DT you get 
from QEMU is sufficient to enumerate everything, etc etc.


Alex

