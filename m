Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CFA8C83F15
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 14:30:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05CE880702;
	Mon, 28 Aug 2023 16:30:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1693233023;
	bh=Kwv0P1tb402O0dYI6sZ3szUDLy6UMmOwjI8Ko9T39vk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nJSfqn5mlUPVGxabDf2nOOTWxbQenU7SPl2pO08ZLYXBWm0HFmw1g/HvglSyBDOGT
	 dLirNmdI1cA6/7AT5UHy890vMc9Mu+UzJN1kNTlhdFga5r/ngGQeMweanRkpHCopLv
	 TdtrKOuCffSWKAKApwG0/yWNJPielvW82iYYZUq3qy8OwUe8/0a6KbbvvlQztUDdCy
	 FqVI8ZhR95bv7hORo/Y9s3A7qkFvKtqz97r+SaPMtepINzdEAjUtf/eD6L4D/COyns
	 a95PBq53h/YG1lmH97yDmFce3TbCL1EQkwh3sp0VBW1/NyKXfHuNi2Ya7m0x6g3Ao8
	 o5AZ999E3+eyQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id A263686478; Mon, 28 Aug 2023 16:30:21 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org
 [IPv6:2001:67c:2050:101:465::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17DC380569
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 16:30:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4RZCdN3lD3z9sFh;
 Mon, 28 Aug 2023 16:30:16 +0200 (CEST)
Message-ID: <a7e87a65-c27e-cd2f-1282-27406b30b360@denx.de>
Date: Mon, 28 Aug 2023 16:30:14 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2] spl: watchdog: introduce SPL_HW_WATCHDOG
To: Oleksandr Suvorov <cryosay@gmail.com>
Cc: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, u-boot@lists.denx.de, 
 Igor Opaniuk <igor.opaniuk@foundries.io>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>,
 Bin Meng <bmeng.cn@gmail.com>, Claudiu Beznea
 <claudiu.beznea@microchip.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Marek Vasut <marex@denx.de>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Michal Simek <michal.simek@amd.com>, Nikhil M Jain <n-jain1@ti.com>,
 Paul Barker <paul.barker@sancloud.com>, Roger Quadros <rogerq@kernel.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>
References: <20230823120021.50146-1-oleksandr.suvorov@foundries.io>
 <65aced18-8116-9501-07ad-13281a3498b6@denx.de>
 <CAGgjyvFqP0NC=Mp83BRQBSQ26T_NnBjoor+tCL0BP4uG_G3=NA@mail.gmail.com>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <CAGgjyvFqP0NC=Mp83BRQBSQ26T_NnBjoor+tCL0BP4uG_G3=NA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4RZCdN3lD3z9sFh
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

Hi Oleksandr,

On 8/28/23 15:23, Oleksandr Suvorov wrote:
> Hi Stefan,
> 
> On Thu, Aug 24, 2023 at 2:24 PM Stefan Roese <sr@denx.de> wrote:
>>
>> On 8/23/23 14:00, Oleksandr Suvorov wrote:
>>> Add SPL_HW_WATCHDOG Kconfig symbol which can be used to enable
>>> non-WDT hardware watchdog in SPL.
>>
>> Hmmm, my hope / plan was to completely drop HW_WATCHDOG at some point.
>> It's some old relict and if I don't miss something completely, it's more
>> a "normal" watchdog that needs to get triggered very early in most
>> cases (PowerPC etc).
> 
> Oh, it's a good approach, thanks.

Good that we agree. But...

>> So adding some more *_HW_WATCHDOG stuff does not sound appealing to me.
>> Could you perhaps investigate a bit, if your HW_WATCHDOG use case can
>> be converted to the "normal" watchdog support instead?
> 
> We just need to be able to exclude a hardware watchdog from SPL to
> save some memory.

Did you already enable LTO so decrease the image size? Just checking.

> So I resign this patch and we'll wait for your work and then revise
> what we have again.

...but: Actually I don't have any plans to do this rework myself. At
least not short-term. My hope was that someone for the platforms using
this HW_WATCHDOG stuff would jump in here. ;)

Thanks,
Stefan

>> Thanks,
>> Stefan
> 
> Cheers,
> Oleksandr
> 
>>
>>> Co-developed-by: Igor Opaniuk <igor.opaniuk@foundries.io>
>>> Signed-off-by: Igor Opaniuk <igor.opaniuk@foundries.io>
>>> Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
>>> ---
>>>
>>> Changes in v2:
>>> - remove mistakenly included unwanted changes
>>>
>>>    common/spl/Kconfig        | 1 -
>>>    drivers/Makefile          | 1 +
>>>    drivers/sysreset/Kconfig  | 6 ++++++
>>>    drivers/sysreset/Makefile | 2 +-
>>>    drivers/watchdog/Kconfig  | 4 ++++
>>>    5 files changed, 12 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
>>> index c5dd476db58..07d9dac29bd 100644
>>> --- a/common/spl/Kconfig
>>> +++ b/common/spl/Kconfig
>>> @@ -1351,7 +1351,6 @@ config SPL_THERMAL
>>>
>>>    config SPL_WATCHDOG
>>>        bool "Support watchdog drivers"
>>> -     imply SPL_WDT if !HW_WATCHDOG
>>>        help
>>>          Enable support for watchdog drivers in SPL. A watchdog is
>>>          typically a hardware peripheral which can reset the system when it
>>> diff --git a/drivers/Makefile b/drivers/Makefile
>>> index efc2a4afb24..2eb8ec0a894 100644
>>> --- a/drivers/Makefile
>>> +++ b/drivers/Makefile
>>> @@ -62,6 +62,7 @@ obj-$(CONFIG_SPL_USB_GADGET) += usb/gadget/
>>>    obj-$(CONFIG_SPL_USB_GADGET) += usb/common/
>>>    obj-$(CONFIG_SPL_USB_GADGET) += usb/gadget/udc/
>>>    obj-$(CONFIG_SPL_WATCHDOG) += watchdog/
>>> +obj-$(CONFIG_SPL_HW_WATCHDOG) += watchdog/
>>>    obj-$(CONFIG_SPL_USB_HOST) += usb/host/
>>>    obj-$(CONFIG_SPL_SATA) += ata/ scsi/
>>>    obj-$(CONFIG_SPL_LEGACY_BLOCK) += block/
>>> diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
>>> index bdbe2a95364..0d21673e402 100644
>>> --- a/drivers/sysreset/Kconfig
>>> +++ b/drivers/sysreset/Kconfig
>>> @@ -157,6 +157,12 @@ config SYSRESET_WATCHDOG
>>>        help
>>>          Reboot support for generic watchdog reset.
>>>
>>> +config SPL_SYSRESET_WATCHDOG
>>> +     bool "Enable support for watchdog reboot driver in SPL mode"
>>> +     select SPL_WDT
>>> +     help
>>> +       Reboot support for generic watchdog reset in SPL mode.
>>> +
>>>    config SYSRESET_WATCHDOG_AUTO
>>>        bool "Automatically register first watchdog with sysreset"
>>>        depends on SYSRESET_WATCHDOG
>>> diff --git a/drivers/sysreset/Makefile b/drivers/sysreset/Makefile
>>> index 40c876764af..e5a7fc07a81 100644
>>> --- a/drivers/sysreset/Makefile
>>> +++ b/drivers/sysreset/Makefile
>>> @@ -18,7 +18,7 @@ obj-$(CONFIG_SYSRESET_SOCFPGA) += sysreset_socfpga.o
>>>    obj-$(CONFIG_SYSRESET_SOCFPGA_SOC64) += sysreset_socfpga_soc64.o
>>>    obj-$(CONFIG_SYSRESET_TI_SCI) += sysreset-ti-sci.o
>>>    obj-$(CONFIG_SYSRESET_SYSCON) += sysreset_syscon.o
>>> -obj-$(CONFIG_SYSRESET_WATCHDOG) += sysreset_watchdog.o
>>> +obj-$(CONFIG_$(SPL_)SYSRESET_WATCHDOG) += sysreset_watchdog.o
>>>    obj-$(CONFIG_SYSRESET_RESETCTL) += sysreset_resetctl.o
>>>    obj-$(CONFIG_$(SPL_TPL_)SYSRESET_AT91) += sysreset_at91.o
>>>    obj-$(CONFIG_$(SPL_TPL_)SYSRESET_X86) += sysreset_x86.o
>>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>>> index 07fc4940e91..d696a04fc18 100644
>>> --- a/drivers/watchdog/Kconfig
>>> +++ b/drivers/watchdog/Kconfig
>>> @@ -39,9 +39,13 @@ config WATCHDOG_TIMEOUT_MSECS
>>>    config HW_WATCHDOG
>>>        bool
>>>
>>> +config SPL_HW_WATCHDOG
>>> +     bool
>>> +
>>>    config IMX_WATCHDOG
>>>        bool "Enable Watchdog Timer support for IMX and LSCH2 of NXP"
>>>        select HW_WATCHDOG if !WDT
>>> +     select SPL_HW_WATCHDOG if !SPL_WDT
>>>        help
>>>          Select this to enable the IMX and LSCH2 of Layerscape watchdog
>>>          driver.
>>
>> Viele Grüße,
>> Stefan Roese
>>
>> --
>> DENX Software Engineering GmbH,      Managing Director: Erika Unter
>> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
>> Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
> 
> 
> 

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
