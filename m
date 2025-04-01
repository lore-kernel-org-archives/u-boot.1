Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF95C36014
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 07:56:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14A4C81F32;
	Tue,  1 Apr 2025 09:56:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="JiDIjbrv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79B7081F7B; Tue,  1 Apr 2025 09:56:34 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87F5D801BE
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 09:56:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=9d47=WT=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1743494190;
 bh=Xei2NL7p/WnQccw748+WlLz4Jf/KMMcYbUdO8uy4QDE=;
 b=JiDIjbrvMdKt+Type6UTkPxiO6XfrtQJmIuz/1+O1m0rI8oXTjJ5JrEM95nfETR9JgQbdOhbj
 KmczlraX+QB5SVsG6vG85IaqzuFYrWZ/eWKmTGWNyuwiy20gvBN9JDQl1Ap+vK/izwu5h3KHXb6
 oPx+KE0LBw9VT4OgaF76V3JFU+tupbhGFzx3Klc/l0hB+MyTIkwkyw/us1FKpR96tN5Z6JBdtCi
 K0No5s+wC5fTE5DklODJMfx5Jyb7IfSyK5jhQ6ThQ7GLTdm/tIyVTMHSCNkwUNbHkbrAeZwy16P
 pflOrDMCfX3HJXKpT0eeffEOg/VMGuNybLF4UK9YqEkA==
X-Forward-Email-ID: 67eb9c2aace0b676385e4a5c
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.0.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <3088459a-0482-44fd-a06b-a713fa57b100@kwiboo.se>
Date: Tue, 1 Apr 2025 09:56:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] rockchip: rock64-rk3328_defconfig: enable HDMI
 output and USB keyboard
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Anatolij Gustschin <agust@denx.de>,
 Jagan Teki <jagan@edgeble.ai>, Quentin Schulz <quentin.schulz@cherry.de>,
 u-boot@lists.denx.de
References: <20250323225134.2369473-1-anarsoul@gmail.com>
 <20250323225134.2369473-3-anarsoul@gmail.com>
 <3819cbcb-5fa6-4939-a2b4-643cadcc50ff@kwiboo.se>
 <CA+E=qVdwL2JK7XpUvvwvs8R88Mx9nCpZc1TOf=EFYaNaVzi2JQ@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CA+E=qVdwL2JK7XpUvvwvs8R88Mx9nCpZc1TOf=EFYaNaVzi2JQ@mail.gmail.com>
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

Hi Vasily,

On 2025-04-01 00:16, Vasily Khoruzhick wrote:
> On Sun, Mar 30, 2025 at 4:45 AM Jonas Karlman <jonas@kwiboo.se> wrote:
>>
>> Hi Vasily,
>>
>> On 2025-03-23 23:50, Vasily Khoruzhick wrote:
>>> Enable HDMI output and USB keyboard on Rock64 board
>>>
>>> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
>>> ---
>>> v2: no change
>>>
>>>  configs/rock64-rk3328_defconfig | 10 ++++++++++
>>>  1 file changed, 10 insertions(+)
>>>
>>> diff --git a/configs/rock64-rk3328_defconfig b/configs/rock64-rk3328_defconfig
>>> index 6d00b52e62f..ae3512625cf 100644
>>> --- a/configs/rock64-rk3328_defconfig
>>> +++ b/configs/rock64-rk3328_defconfig
>>> @@ -21,7 +21,9 @@ CONFIG_FIT_VERBOSE=y
>>>  CONFIG_SPL_FIT_SIGNATURE=y
>>>  CONFIG_SPL_LOAD_FIT=y
>>>  CONFIG_LEGACY_IMAGE_FORMAT=y
>>> +CONFIG_USE_PREBOOT=y
>>
>> This will add a large delay during boot as it forces a run of the slow
>> "usb start" and is something we want to avoid for normal use, please
>> drop this.
> 
> Well, I can just drop the patch altogether.
> 
> Personally, I do need USB and HDMI support, since it allows me to boot
> from a secondary storage in case the OS on main storage doesn't boot.
> Not having USB support defeats the purpose of this patch.

With bootstd the storage media is initialized in fastest to slowest
(initialization time) order. So USB will be initialized if nothing it
found on mmc nvme etc, see boot_targets env var.

However, if you want usb in efi bootmgr you must initialize usb (and any
other storage media) before starting bootstd loop. To my knowledge
someone should be working on a change to the boot order to load efi
bootmgr just before removable media and have it initialize usb etc.

Since ROCK64 has env by default you can easily change the boot command
to run "usb start" before booting on your device, until the reordered
efi bootmgr work lands.

Slowing down boot (USE_PREBOOT=y) for everyone by several seconds to
force initialize USB when it is not really needed for i.e. a quick
extlinux/scripts boot from MMC is not ideal.

We could look into options using e.g. recovery button, env var or
similar to use an alternative boot flow.

Regards,
Jonas

> 
>>>  CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-rock64.dtb"
>>> +# CONFIG_SYS_DEVICE_NULLDEV is not set
>>>  # CONFIG_DISPLAY_CPUINFO is not set
>>>  CONFIG_DISPLAY_BOARDINFO_LATE=y
>>>  CONFIG_SPL_MAX_SIZE=0x40000
>>> @@ -72,6 +74,7 @@ CONFIG_DM_ETH_PHY=y
>>>  CONFIG_PHY_GIGE=y
>>>  CONFIG_ETH_DESIGNWARE=y
>>>  CONFIG_GMAC_ROCKCHIP=y
>>> +CONFIG_PHY_ROCKCHIP_INNO_HDMI=y
>>>  CONFIG_PHY_ROCKCHIP_INNO_USB2=y
>>>  CONFIG_PINCTRL=y
>>>  CONFIG_SPL_PINCTRL=y
>>> @@ -80,6 +83,8 @@ CONFIG_PMIC_RK8XX=y
>>>  CONFIG_SPL_DM_REGULATOR=y
>>>  CONFIG_DM_REGULATOR_FIXED=y
>>>  CONFIG_SPL_DM_REGULATOR_FIXED=y
>>> +CONFIG_DM_REGULATOR_GPIO=y
>>> +CONFIG_SPL_DM_REGULATOR_GPIO=y
>>
>> The ROCK64 does not use any regulator-gpio, this look unrelated and can
>> be dropped?
>>
>>>  CONFIG_REGULATOR_RK8XX=y
>>>  CONFIG_PWM_ROCKCHIP=y
>>>  CONFIG_RAM=y
>>> @@ -104,6 +109,11 @@ CONFIG_USB_OHCI_GENERIC=y
>>>  CONFIG_USB_DWC2=y
>>>  CONFIG_USB_DWC3=y
>>>  CONFIG_USB_DWC3_GENERIC=y
>>> +CONFIG_USB_KEYBOARD=y
>>> +CONFIG_VIDEO=y
>>> +CONFIG_DISPLAY=y
>>> +CONFIG_VIDEO_ROCKCHIP=y
>>> +CONFIG_DISPLAY_ROCKCHIP_HDMI=y
>>
>> This will force a small delay of at least a 300ms timeout for all users
>> that does not have HDMI connected during boot.
>>
>> Maybe this could be extracted to a rockchip-hdmi.config-file to make it
>> more optional?
>>
>> E.g. use "make rock64-rk3328_defconfig rockchip-hdmi.config" to build
>> with something like:
>>
>>   > cat rockchip-hdmi.config
>>   CONFIG_VIDEO=y
>>   CONFIG_DISPLAY=y
>>   CONFIG_VIDEO_ROCKCHIP=y
>>   CONFIG_DISPLAY_ROCKCHIP_HDMI=y
>>
>> Regards,
>> Jonas
>>
>>>  CONFIG_SPL_TINY_MEMSET=y
>>>  CONFIG_TPL_TINY_MEMSET=y
>>>  CONFIG_ERRNO_STR=y
>>

