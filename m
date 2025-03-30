Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0994BC28B20
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 12:11:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D83F8144A;
	Sun, 30 Mar 2025 14:11:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="BzT4YQ9T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A6118171B; Sun, 30 Mar 2025 14:11:42 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A310D80FDA
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 14:11:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=c171=WS=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1743336697;
 bh=0p50WQkih7ADiW46Ayph5vJJ1oTGLy/p6d6xesurF6s=;
 b=BzT4YQ9TaHHRgWUupnvRiK1h7PkMBuxBAWzvyQ6A2XtUgn+HbA5n0ddZt0xN9BlQLCyNMpAy+
 tGCvm0OkmHqQNojVvnZ6Lmh+aQQs5xbsdge6opPLNxoz6/ZRKCCfmJHwCLT8a2SZKfZwRw5af9j
 ut1JrPjVtLTjilmMrmg+TVlMyRlR5gACUZubr+KcGQ2pyrPoGHEITCpyQyvq5TRo0CR8kGdm6Ax
 3vc6jx7/j8adKwOZkG6rj1DzCKlCm2vKB0J3/ucYmdxR6QT8qO0RsF8db3ixzHgY7FMBi0sK/do
 Kri4AaalV03kd4BOUWT5oNbaLNO83lnECCUo3dreWk0Q==
X-Forward-Email-ID: 67e934f3b53fbafc9c391419
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <a2dea153-33a0-42cd-a094-bfea08587a41@kwiboo.se>
Date: Sun, 30 Mar 2025 14:11:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] rockchip: rock64-rk3328_defconfig: enable HDMI
 output and USB keyboard
To: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Anatolij Gustschin <agust@denx.de>,
 Jagan Teki <jagan@edgeble.ai>, Quentin Schulz <quentin.schulz@cherry.de>,
 u-boot@lists.denx.de
References: <20250323225134.2369473-1-anarsoul@gmail.com>
 <20250323225134.2369473-3-anarsoul@gmail.com>
 <3819cbcb-5fa6-4939-a2b4-643cadcc50ff@kwiboo.se>
 <CAJs94EZR5HZSoQFQH=ByoUeQzOk9VoQD7-td00wvCzpFWR4F=Q@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAJs94EZR5HZSoQFQH=ByoUeQzOk9VoQD7-td00wvCzpFWR4F=Q@mail.gmail.com>
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

Hi Matwey,

On 2025-03-30 13:52, Matwey V. Kornilov wrote:
> вс, 30 мар. 2025 г. в 14:45, Jonas Karlman <jonas@kwiboo.se>:
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
>>
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
> 
> It already takes about 2 sec to initialize Ethernet. I would say that
> nobody notices another 300ms.

If it takes 2 seconds then I think you may have something wrong in your
configuration? Please share a "bootstage report".

The Ethernet initialization should be fast, trying to use the Ethernet
will however be slow. The Ethernet PHY reset should be around 10+50ms.

Reaching eth_common_init may take some time, but eth_initialize should
be relative fast.

Regards,
Jonas

> 
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
> 
> 

